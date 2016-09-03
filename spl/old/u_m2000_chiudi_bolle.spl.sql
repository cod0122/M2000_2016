DROP FUNCTION u_m2000_chiudi_bolle();
CREATE FUNCTION u_m2000_chiudi_bolle()
		RETURNING VARCHAR(100);

   define k_conta_righe, k_colli_arfa, k_colli_arsp, k_num_upd_testa, k_num_upd_righe integer;
   define K_NUM_BOLLA_OUT        like ARSP.NUM_BOLLA_OUT;
   define K_DATA_BOLLA_OUT       like ARSP.DATA_BOLLA_OUT;
   define K_ID_ARMO              like ARMO.ID_ARMO;
   define k_data_start     date;
   define k_gg, k_mm, k_aa integer;
   define k_data_elab      date;
   define k_status varchar(100);
	
   --set debug file to '.\m2000_nt.trace.txt';
   --trace on;
   
   let k_num_upd_testa = 0;
   let k_num_upd_righe = 0;
   
   let K_AA    = year(today) - 1;
   let K_MM    = month(today);
   let K_GG    = 01; --day(today);
   if k_mm > 6 then
      let k_mm = k_mm - 6;
   else
      let k_aa = k_aa - 1;
      let k_mm = k_mm + 6;
   end if;
   let k_data_start = mdy(k_mm, k_gg, k_aa);

   let k_data_elab = mdy(01,01, year(today) - 1);

		
   foreach c_elenco_bolle for
	      select NUM_BOLLA_OUT, DATA_BOLLA_OUT 
     	 	      into K_NUM_BOLLA_OUT, K_DATA_BOLLA_OUT
       		  from sped
                  where DATA_BOLLA_OUT > k_data_elab and STAMPA <> 'F'
	
      if sqlcode < 0 then
         let k_status = '(u_m2000_chiudi_bolle) Errore in foreach c_elenco_bolle sqlcode' || sqlcode;
         rollback;
         goto FORZA_FINE;
      end if

      foreach c_elenco_righe WITH HOLD for
	     select distinct id_armo
                 into k_id_armo
      		 from arsp
	       where NUM_BOLLA_OUT = K_NUM_BOLLA_OUT
       	         and DATA_BOLLA_OUT = K_DATA_BOLLA_OUT
         begin work;

         if sqlcode < 0 then
            let k_status = '(u_m2000_chiudi_bolle) Errore in foreach c_elenco_righe sqlcode' || sqlcode;
            rollback;  
            goto FORZA_FINE;
         end if

         select sum(colli)
           into k_colli_arsp
           from arsp
           where id_armo = k_id_armo;
	
         if sqlcode < 0 then
            let k_status = '(u_m2000_chiudi_bolle) Errore in select sum(colli) arsp sqlcode' || sqlcode;
            rollback;
            goto FORZA_FINE;
         end if

         let k_colli_arfa = 0;

         select sum(colli)
           into k_colli_arfa
           from arfa
           where id_armo = k_id_armo
             and (id_armo_prezzo = 0 or id_armo_prezzo is null);

         if sqlcode < 0 then
            let k_status = '(u_m2000_chiudi_bolle) Errore in select sum(colli) arfa sqlcode' || sqlcode;
            rollback;
            goto FORZA_FINE;
         end if

         if sqlcode > 0 or k_colli_arfa = 0 or k_colli_arfa is null then

            select sum(colli)
              into k_colli_arfa
              from arfa, armo_prezzi
              where arfa.id_armo = k_id_armo and arfa.id_armo_prezzo > 0
                    and arfa.id_armo_prezzo = armo_prezzi.id_armo_prezzo
                   and armo_prezzi.tipo_calcolo = "U";

  	         if sqlcode < 0 then
               let k_status = '(u_m2000_chiudi_bolle) Errore in select sum(colli) arfa e armo_prezzi sqlcode' || sqlcode;
	            rollback;
	            goto FORZA_FINE;
            end if
         end if;

         if sqlcode >= 0 then

            if k_colli_arfa = k_colli_arsp then

               update ARSP
                 set
                    ARSP.STAMPA = "F"
                 where ARSP.NUM_BOLLA_OUT  = K_NUM_BOLLA_OUT  and
                       ARSP.DATA_BOLLA_OUT = K_DATA_BOLLA_OUT and
                       ARSP.ID_ARMO        = K_ID_ARMO;

               if sqlcode < 0 then
                  let k_status = '(u_m2000_chiudi_bolle) Errore in update ARSP sqlcode' || sqlcode;
                  rollback;
   	              goto FORZA_FINE;
               else
                  let k_num_upd_righe = k_num_upd_righe + 1;
               end if
            end if;
         end if;

      end foreach ;

      let k_conta_righe = 0;
      select count(*) into k_conta_righe
            from arsp
            where  ARSP.STAMPA          <> "F"
                   and ARSP.NUM_BOLLA_OUT  = K_NUM_BOLLA_OUT
                   and ARSP.DATA_BOLLA_OUT = K_DATA_BOLLA_OUT ;

	  if sqlcode < 0 then
         let k_status = '(u_m2000_chiudi_bolle) Errore in select count(*)  arsp sqlcode' || sqlcode;
         rollback;
   	     goto FORZA_FINE;
      end if

      if k_conta_righe = 0 then
         update SPED
           set
              STAMPA = "F"
           where NUM_BOLLA_OUT  = K_NUM_BOLLA_OUT  and
                 DATA_BOLLA_OUT = K_DATA_BOLLA_OUT ;
         if sqlcode < 0 then
            let k_status = '(u_m2000_chiudi_bolle) Errore in update SPED sqlcode' || sqlcode;
            rollback;
            goto FORZA_FINE;
         else
            let k_num_upd_testa = k_num_upd_testa + 1;
         end if
      end if;

      commit;
   end foreach;

   if sqlcode != 0 then
      let K_STATUS = 'Errore sqlcode' || sqlcode;
   end if;

   goto OK;

<<FORZA_FINE>>
   goto FINE;

<<OK>>
   let k_status = 'Ok operazione conclusa, aggiornate ' || k_num_upd_righe || ' righe e ' || k_num_upd_testa || ' testate.';

<<FINE>>
   --trace off;

return K_STATUS ;

end function
                      
                      
              
