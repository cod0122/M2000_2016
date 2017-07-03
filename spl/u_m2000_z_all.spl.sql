--CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
CONNECT to 'gammarad@gammarad_at1' user 'informix' using 'infoxgamma';

drop function u_m2000_get_datetime();
create function u_m2000_get_datetime() 
      returning  datetime hour to second;

   define K_DATATIME  datetime hour to second;

   SELECT
    DBINFO('utc_to_datetime', sh_curtime)
   INTO
    K_DATATIME
   FROM
      sysmaster:sysshmvals;
   --select current
    --  into K_DATATIME
     -- from systables
      --where tabname="systables";   

   return K_DATATIME;
   
end function
;--CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
DROP FUNCTION u_m2000_wm_pklist_flag_sped();
CREATE FUNCTION u_m2000_wm_pklist_flag_sped()
  RETURNING VARCHAR(100);

-- scopre le bolle caricate su camion e le chiude

   define k_conta_righe, k_errore, k_codice, k_colli_arfa, k_colli_arsp integer;
   define K_NUM_BOLLA_OUT        like ARSP.NUM_BOLLA_OUT ;
   define K_DATA_BOLLA_OUT       like ARSP.DATA_BOLLA_OUT ;
   define K_id_wm_pklist_riga          like MECA.ID;
   define K_ID_ARMO              like ARMO.ID_ARMO;
   define k_data_start           date;
   define k_gg, k_mm, k_aa  integer;
   define k_data_elab date;
   define k_status varchar(100);

   --set debug file to '.\m2000_nt.trace.txt';
   --trace on;
   
   begin work;

   let k_codice = 0;

   let K_AA    = year(today) - 1;
   let K_MM    = month(today);
   let K_GG    = day(today);
   if k_mm > 6 then
      let k_mm = k_mm - 6;
   else
      let k_aa = k_aa - 1;
      let k_mm = k_mm + 6;
   end if
   let k_data_start = mdy(k_mm, k_gg, k_aa);
      
   let k_data_elab = mdy(01,01, year(today) - 1);

-- aggiorna solo le righe bolle WM gia' Caricate su Camion
   foreach WM_PKLIST_FLAG_SPED_C for
          select id_wm_pklist_riga
             into K_id_wm_pklist_riga
             from wm_pklist_righe, outer meca 
             where meca.DATA_INT > k_data_elab
                   and wm_pklist_righe.INSPED = 'S'
                   and wm_pklist_righe.id_meca = meca.id
                   and id_wm_pklist_riga > 0            
    
      if sqlcode < 0 then
         let k_status = '(u_m2000_wm_pklist_flag_sped)  Errore in foreach WM_PKLIST_FLAG_SPED_C sqlcode' || sqlcode;
         rollback;
         goto FORZA_FINE;
      end if

      update wm_pklist_righe
            set SPED = "S"
         where id_wm_pklist_riga = K_id_wm_pklist_riga; 

      if sqlcode < 0 then
         let k_status = '(u_m2000_wm_pklist_flag_sped)  Errore in update wm_pklist_righe sped sqlcode' || sqlcode;
         rollback;
         goto FORZA_FINE;
      else
         if sqlcode = 0 then
            let k_codice = k_codice + 1;
         end if
      end if
--               exit foreach
   end foreach; 

    goto OK;

<<FORZA_FINE>>
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
      rollback;
   END
   goto FINE;

<<OK>>
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
      commit work;
   END
   let k_status = 'Ok operazione conclusa, aggiornati ' || k_codice || ' DDT.';

<<FINE>>
   --trace off;

return K_STATUS ;


end function
;--CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
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
 ;                     
                      
              
--CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
DROP FUNCTION u_m2000_1_cr_tab_s_armo();
CREATE FUNCTION u_m2000_1_cr_tab_s_armo()
  RETURNING VARCHAR(100);

  
   define k_status varchar(100);
     
   --set debug file to '.\m2000_nt.trace.txt';
   --trace on;
     
   --whenever error continue;
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
      drop view informix.s_armo;
      drop table informix.s_armo_n;
   END
   --whenever error goto  FORZA_FINE;

   ---- solo per INFORMIX 12.10
   --create table informix.s_armo as select * from informix.s_armo_p;

   ---- x informix vecchi
   create table informix.s_armo_n
       (
        id_meca         integer,
        id_armo         integer,
        id_listino      integer,
        magazzino       integer,
        num_int         integer,
        data_int        date,
        data_ent        date,
        gruppo          decimal(3,0),
        dose            decimal(7,2),
        travaso         char(1),
        m_cubi_arsp     decimal(12,2),
        colli_1         decimal(09,0),
        colli_2         decimal(09,0),
        m_cubi          decimal(12,2),
        giri_f1_pl      integer,
        giri_f1_lav     integer,
        giri_f2_pl      integer,
        giri_f2_lav     integer,
        pedane          decimal(12,2),
        imp_fatt        decimal(15,2),
        imp_da_fatt     decimal(15,2),
        clie_1          integer,
        clie_2          integer,
        clie_3          integer,
        aperto         char(1)
       );

   if sqlcode < 0 then
      let k_status = '(u_m2000_1_cr_tab_s_armo)  Errore in create table informix.s_armo_n sqlcode' || sqlcode;
      goto FORZA_FINE;
   end if

   CREATE VIEW informix.s_armo AS 
      SELECT * 
         FROM informix.s_armo_n;
--      union all
--      SELECT * 
--         FROM informix.s_armo_p;


   if sqlcode < 0 then
      let k_status = '(u_m2000_1_cr_tab_s_armo)  Errore in  CREATE VIEW informix.s_armo  sqlcode' || sqlcode;
      rollback;
      goto FORZA_FINE;
   end if


   revoke all on informix.s_armo_n from public;
   revoke all on informix.s_armo from public;
   grant all on informix.s_armo_n to "ixuser" as "informix";
   grant all on informix.s_armo to "ixuser" as "informix";

--------------------------------------------------------------------------------------------------------------------------------
-- ARCHIVIO  DI SERVIZIO PER GLI STATISTICI * ENTRATE *
-- Magazzino Magazzino di lavorazione della merce
-- Dose      Dose
-- Gruppo    Gruppo articoli
-- Travaso   Flag se travaso avvenuto impostato a 'S'
-- Colli_1   Colli entrati in bolla di entrata
-- Colli_2   Nr. colli di lavorazione in magazzino
-- M_cubi    M_Cubi effettivamente accupati dall'impianto (come sped cli)
-- Clie_1    Mandante della merce
-- Clie_2    Ricevente della bolla di uscita 
-- Clie_3    Ricevente della fattura         
--------------------------------------------------------------------------------------------------------------------------------

    goto OK;

<<FORZA_FINE>>
   --rollback;
   goto FINE;

<<OK>>
   --commit;
   let k_status = 'Ok operazione conclusa, create Table s_armo_n e View  s_armo' ;

<<FINE>>
   --trace off;

return K_STATUS ;


end function
;
--CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
drop function u_m2000_2_s_armo();
create function u_m2000_2_s_armo() 
      returning varchar(100);

      
   define k_status 		 varchar(100);
   define K_DATA_LIMITE  date;
   define k_armo_prezzi_importo, k_importo_da_fatt_a_corpo, k_importo_da_fatt_x_qta  decimal(15,2);
   define K_CONTA_REC, K_CONTA_TOT_REC integer;
   define K_ARMO_COLLI        decimal(5);
   define k_colli_da_nontrattare decimal(5);
   --define K_ARMO     row (
   define K_ARMO_MAGAZZINO     smallint;
   define K_ARMO_DOSE          decimal(6,1);
   define K_ARMO_TRAVASO       char(1);     
   define K_ARMO_COLLI_TRATTATI decimal(5);
   define K_ARMO_COLLI_1       decimal(5);
   define K_ARMO_COLLI_2       decimal(5);
   define K_ARMO_COLLI_FATT  	decimal(5);
   define K_ARMO_M_CUBI_ARSP   decimal(6,2);
   define K_ARMO_M_CUBI        decimal(6,2);
   define K_ARMO_PEDANE        decimal(5,2); 
   define K_ARMO_ID_MECA       integer;   
   define K_ARMO_NUM_INT       integer;   
   define K_ARMO_DATA_INT      date;
   define K_DATA_ENT      date;
   define K_ARMO_DATA_LAV_FIN  date;
   define K_ARMO_CLIE_1        integer;   
   define K_ARMO_CLIE_2        integer;   
   define K_ARMO_CLIE_3        integer;   
   define K_ARMO_APERTO        char(1);
   define K_ARMO_GRUPPO        decimal(3);
   define K_ARMO_imp_fatt      decimal(15,2);
   define K_ARMO_imp_da_fatt   decimal(15,2);
   --   );           
   --define k_ARMO_1     row (
   define k_ARMO_1_ID_ARMO       integer;   
   define k_ARMO_1_ID_ARMO_1_PREZZI  integer;   
   define k_ARMO_1_ID_LISTINO    integer;   
   define k_ARMO_1_ART           char(12);   
   define k_ARMO_1_COLLI_2       decimal(5);
   define k_ARMO_1_LARG_2        decimal(5);
   define k_ARMO_1_LUNG_2        decimal(5);
   define k_ARMO_1_ALT_2         decimal(5);
   define k_ARMO_1_PESO_KG       decimal(8,2);
   define k_ARMO_1_M_CUBI        decimal(6,2);
   define k_ARMO_1_PEDANE        decimal(5,2); 
   --   );
   --define K_BARCODE     row (
   define K_BARCODE_giri_f1_pl      integer;
   define K_BARCODE_giri_f1_lav     integer;
   define K_BARCODE_giri_f2_pl      integer;
   define K_BARCODE_giri_f2_lav     integer;
   --   );           
   --define K_ARFA     row (
   define K_ARFA_colli      integer;
   define K_ARFA_CLIE_3     integer;
   --   );
   --define K_SPED     row (
   define K_SPED_CLIE_2        integer;
   --   );
   --define K_LISTINO  row (
   define K_LISTINO_MAGAZZINO     smallint;
   define K_LISTINO_PREZZO        decimal(15,2);
   define K_LISTINO_TIPO          char(1);
   define K_LISTINO_CAMPIONE      char(1);   
   define K_LISTINO_M_CUBI_F      decimal(6,2);
   --   );

      
   --set debug file to '.\m2000_nt.trace.txt';
   --trace on;

--- se incontra lock attende 300 secondi prima di andare in errore
   set lock mode to wait 300;
   
   --commit;
   begin work;
--- imposta il tipo di ISOLATION al piu' flessibile, ovvero se incontra righe appena inserite/aggiornate piglia le righe ancora non committed         
   SET ISOLATION TO DIRTY READ;

   let K_CONTA_TOT_REC = 0;
   let K_CONTA_REC = 0;
   
----------------------------------------------------------------------------------------
-- DATA LIMITE FINO DA CUI ESTRARRE 
   select max(data_int) 
        into K_DATA_LIMITE
        from s_armo_p;
   if sqlcode <> 0 then
      let k_status = '(u_m2000_2_s_armo)  Errore in select max(data_int)  x K_DATA_LIMITE  sqlcode' || sqlcode;
      goto FORZA_FINE;
   end if
----------------------------------------------------------------------------------------
     
   
   foreach C_M_ESTR_S_ARMO with hold for
      select distinct
                 ARMO.MAGAZZINO,
                 ARMO.DOSE,
                 ARMO.TRAVASO,
                 ARMO.COLLI_1,
                 ARMO.COLLI_2,
                 ARMO.COLLI_FATT,
                 ARMO.M_CUBI,
                 ARMO.PEDANE,
                 MECA.ID,
                 MECA.NUM_INT,
                 MECA.DATA_INT,
                 date(MECA.DATA_ENT),
                 MECA.CLIE_1,
                 MECA.CLIE_2,
                 MECA.CLIE_3,
                 MECA.APERTO,
                 PRODOTTI.GRUPPO
                 ,ARMO.ID_LISTINO   
                 ,ARMO.ID_ARMO   
                 ,ARMO_PREZZI.ID_ARMO
                 ,ARMO.ART
                 ,ARMO.PESO_KG
                 ,ARMO.LARG_2
                 ,ARMO.LUNG_2
                 ,ARMO.ALT_2
            into  
                 K_ARMO_MAGAZZINO    
                 ,K_ARMO_DOSE         
                 ,K_ARMO_TRAVASO       
                 ,K_ARMO_COLLI_1       
                 ,K_ARMO_COLLI_2       
                 ,K_ARMO_COLLI_FATT
                 ,K_ARMO_M_CUBI        
                 ,K_ARMO_PEDANE        
                 ,K_ARMO_ID_MECA      
                 ,K_ARMO_NUM_INT       
                 ,K_ARMO_DATA_INT      
                 ,K_DATA_ENT      
                 ,K_ARMO_CLIE_1        
                 ,K_ARMO_CLIE_2        
                 ,K_ARMO_CLIE_3        
                 ,K_ARMO_APERTO
                 ,K_ARMO_GRUPPO    
                 ,K_ARMO_1_ID_LISTINO   
                 ,K_ARMO_1_ID_ARMO  
                 ,K_ARMO_1_ID_ARMO_1_PREZZI  
                 ,K_ARMO_1_ART
                 ,K_ARMO_1_PESO_KG
                 ,K_ARMO_1_LARG_2
                 ,K_ARMO_1_LUNG_2
                 ,K_ARMO_1_ALT_2
             from  MECA, outer (ARMO, outer PRODOTTI, outer ARMO_PREZZI) 
             where
                   meca.id = armo.id_meca and
                   armo.art = prodotti.codice and
                   armo.id_armo = ARMO_PREZZI.id_armo
                   and ARMO.COLLI_2 > 0
                   AND MECA.DATA_INT > K_DATA_LIMITE
              order by meca.id, armo.id_armo

---16.12.2010 Piglia il ricevente dal ddt
      select max(sped.clie_2)
          into K_SPED_clie_2
          from arsp, outer sped 
         where arsp.id_sped = sped.id_sped
                  and id_armo = K_ARMO_1_id_armo ;
      if sqlcode < 0 then
         let k_status = '(u_m2000_2_s_armo)  Errore in select max(sped.clie_2) arsp e sped  sqlcode' || sqlcode;
         goto FORZA_FINE;
      end if
                  
      if K_SPED_clie_2 > 0 then 
         let K_ARMO_clie_2 = K_SPED_clie_2;
      end if
---16.12.2010 Piglia il cliente di fattura
      select max(clie_3)
          into K_ARFA_clie_3
          from arfa
         where id_armo = K_ARMO_1_id_armo ;
      if sqlcode < 0 then
         let k_status = '(u_m2000_2_s_armo)  Errore in select max(clie_3) arfa  sqlcode' || sqlcode;
         goto FORZA_FINE;
      end if
      if K_ARFA_clie_3 > 0 then 
         let K_ARMO_clie_3 = K_ARFA_clie_3;
      end if
   
--- Piglia i giri di lavorazione   
      select sum(FILA_1 + FILA_1P)
             ,sum(FILA_2 + FILA_2P)
             ,sum(lav_FILA_1 + lav_FILA_1P)
             ,sum(lav_FILA_2 + lav_FILA_2P)
         into K_BARCODE_giri_f1_pl
             ,K_BARCODE_giri_f2_pl
             ,K_BARCODE_giri_f1_lav
             ,K_BARCODE_giri_f2_lav
         from barcode
         where barcode.id_armo = K_ARMO_1_ID_armo 
                   and (barcode.causale is null or barcode.causale <> "T");
      if sqlcode < 0 then
         let k_status = '(u_m2000_2_s_armo)  Errore in select sum(FILA_1 + FILA_1P) ... barcode  sqlcode' || sqlcode;
         goto FORZA_FINE;
      end if

---16.12.2010 Piglia nr colli da NON trattare
      let k_colli_da_nontrattare=0;
      select count(*)
          into k_colli_da_nontrattare
          from barcode
         where barcode.id_armo = K_ARMO_1_id_armo 
                   and barcode.causale = 'T';
      if sqlcode < 0 then
         let k_status = '(u_m2000_2_s_armo)  Errore in select count(*)  barcode  sqlcode' || sqlcode;
         goto FORZA_FINE;
      end if
      if k_colli_da_nontrattare is null then 
         let k_colli_da_nontrattare = 0;
      end if
   
--- Piglia importo fatturato    
      let K_ARFA_colli = 0;
      let K_ARMO_imp_fatt = 0;
      select sum(prezzo_t), sum(colli)
            into K_ARMO_imp_fatt, K_ARFA_colli
            from arfa
            where arfa.id_armo = K_ARMO_1_ID_ARMO;
      if sqlcode < 0 then
         let k_status = '(u_m2000_2_s_armo)  Errore in select sum(prezzo_t), sum(colli)  arfa  sqlcode' || sqlcode;
         goto FORZA_FINE;
      end if
         
--- x default il LOTTO è aperto
      if K_ARMO_APERTO is null then 
         let K_ARMO_APERTO = 'S';
      end if

      if K_ARFA_colli is null then 
         let K_ARFA_colli = 0;
      end if
      if K_ARMO_imp_fatt is null then 
         let K_ARMO_imp_fatt = 0;
      end if
      if K_ARMO_colli_fatt is null then 
         let K_ARMO_colli_fatt = 0;
      end if
-- se ho forzato i colli fatturati su ARMO > dei colli Fatturati su ARFA (quindi reali) allora piglia quest'ultimo dato         
      if K_ARMO_colli_fatt < K_ARFA_colli  then 
         let  K_ARMO_colli_fatt = K_ARMO_colli_fatt;
      end if

      let K_ARMO_COLLI = K_ARMO_colli_2 ;
      let K_ARMO_colli_2 = K_ARMO_colli_2 - K_ARFA_colli - k_colli_da_nontrattare;

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--- 07082012 Se il Lotto non è stato completamente fatturato ed è ancora APERTO allora CALCOLO il valore dei colli NON fatturati
-----------------------------------------------------------------------------------------------------------------------------------------------------------
--- Inizializza Importi da Fatturare per fare il calcolo         
      let k_armo_prezzi_importo =  0;
      let K_ARMO_imp_da_fatt = 0;
                        
      if K_ARMO_colli_2 > 0 and K_ARMO_APERTO <> "N"  then 
         
--- se colli non fatturati (anche parzialm) piglia il valore dal listino
--- se non ho il prezzo in entrata allora lo calcolo alla 'vecchia maniera'
         if  K_ARMO_1_id_listino > 0 then
            select    LISTINO.MAGAZZINO,
                        LISTINO.PREZZO,
                        LISTINO.TIPO,
                        LISTINO.CAMPIONE,
                        LISTINO.M_CUBI_F
               into     K_LISTINO_MAGAZZINO,
                        K_LISTINO_PREZZO,
                        K_LISTINO_TIPO,
                        K_LISTINO_CAMPIONE,
                        K_LISTINO_M_CUBI_F
               from LISTINO
               where id = K_ARMO_1_id_listino;
            if sqlcode < 0 then
               let k_status = '(u_m2000_2_s_armo)  Errore in select    LISTINO.MAGAZZINO.... LISTINO  sqlcode' || sqlcode;
               goto FORZA_FINE;
            end if

         else
            select  max(LISTINO.MAGAZZINO),
                    max(LISTINO.PREZZO),
                    max(LISTINO.TIPO),
                    max(LISTINO.CAMPIONE),
                    max(LISTINO.M_CUBI_F)
                  into     K_LISTINO_MAGAZZINO,
                           K_LISTINO_PREZZO,
                           K_LISTINO_TIPO,
                           K_LISTINO_CAMPIONE,
                           K_LISTINO_M_CUBI_F
                  from LISTINO
                  where 
                            K_ARMO_CLIE_3   = LISTINO.COD_CLI    and
                               K_ARMO_1_ART    = LISTINO.COD_ART    and
                            K_ARMO_DOSE   = LISTINO.DOSE       and
                           (K_ARMO_1_LARG_2     = LISTINO.MIS_Z  or
                            LISTINO.MIS_Z = 0) and
                           (K_ARMO_1_LUNG_2     = LISTINO.MIS_X  or
                            LISTINO.MIS_X = 0) and
                           (K_ARMO_1_ALT_2      = LISTINO.MIS_y  or
                            LISTINO.MIS_y = 0);
            if sqlcode < 0 then
               let k_status = '(u_m2000_2_s_armo)  Errore in select  max(LISTINO.MAGAZZINO).... LISTINO  sqlcode' || sqlcode;
               goto FORZA_FINE;
            end if
         end if
        
--- CALCOLO DEL PREZZO                  
         if SQLCODE = 0 then
   
            if K_LISTINO_PREZZO is NULL then
               let K_LISTINO_PREZZO     = 0;
            end if

--- Calcolo i metri cubi per la fatturazione, che possono differire da quelli
--- reali se, impostati nel Listino
            if K_LISTINO_M_CUBI_F > 0 then
               let K_ARMO_1_M_CUBI = K_ARMO_COLLI * K_LISTINO_M_CUBI_F;
            end if

--- Importo da fatturare da ARMO_PREZZI se esiste
            if K_ARMO_1_ID_ARMO_1_PREZZI  > 0 then
               
               --- prima piglia Importi da fatturare x collo 
               select sum(prezzo * item_dafatt) 
                        into k_importo_da_fatt_x_qta
                        from armo_prezzi
                        where id_armo = K_ARMO_1_ID_ARMO
                               and stato = '6'  and tipo_calcolo = 'C';
               if sqlcode < 0 then
                  let k_status = '(u_m2000_2_s_armo)  Errore in select sum(prezzo * item_dafatt)  armo_prezzi  sqlcode' || sqlcode;
                  goto FORZA_FINE;
               end if
               --- qui piglia Importi da fatturare a corpo (cifra unica) 
               select sum(prezzo) 
                        into k_importo_da_fatt_a_corpo
                        from armo_prezzi
                        where id_armo = K_ARMO_1_ID_ARMO
                               and stato = '6'  and tipo_calcolo = 'I';
               if sqlcode < 0 then
                  let k_status = '(u_m2000_2_s_armo)  Errore in select sum(prezzo) armo_prezzi  sqlcode' || sqlcode;
                  goto FORZA_FINE;
               end if
                  
               if k_importo_da_fatt_x_qta > 0 then
                  let k_armo_prezzi_importo = k_importo_da_fatt_x_qta;
               end if
               if k_importo_da_fatt_a_corpo > 0 then
                  let k_armo_prezzi_importo = k_armo_prezzi_importo + k_importo_da_fatt_a_corpo;
               end if
            
            else

--- altrimenti Importo da fatturare nel modo 'vecchio'  direttamente da ENTRATE - FATTURATO
               case K_LISTINO_TIPO
                  when "C" then
                     let K_ARMO_imp_da_fatt = K_ARMO_imp_da_fatt + K_LISTINO_PREZZO * K_ARMO_colli_2;
                  when "P" then
                     let K_ARMO_imp_da_fatt = K_ARMO_imp_da_fatt + K_LISTINO_PREZZO 
                             * ((K_ARMO_1_PESO_KG / K_ARMO_COLLI) * K_ARMO_colli_2);
                  when "M" then
                     let K_ARMO_imp_da_fatt = K_ARMO_imp_da_fatt + K_LISTINO_PREZZO 
                             * ((K_ARMO_1_M_CUBI / K_ARMO_COLLI) * K_ARMO_colli_2);
                  when "B" then
                     let K_ARMO_imp_da_fatt = K_ARMO_imp_da_fatt + K_LISTINO_PREZZO 
                             * ((K_ARMO_1_PEDANE / K_ARMO_COLLI) * K_ARMO_colli_2);
                  else
                     let K_ARMO_imp_da_fatt = K_ARMO_imp_da_fatt + K_LISTINO_PREZZO;
               end case
            
               if K_ARMO_imp_da_fatt is NULL then
                  let K_ARMO_imp_da_fatt = 0;
               end if
            
            end if
         end if

      end if
      let K_ARMO_imp_da_fatt = K_ARMO_imp_da_fatt + k_armo_prezzi_importo;
-----------------------------------------------------------------------------------------------------------------------------------------------------------

      insert into s_armo_n
               (
                ID_ARMO,
			    id_listino,
                MAGAZZINO,
                DOSE,
                TRAVASO,
                COLLI_1,
                COLLI_2,
                M_CUBI,
                PEDANE,
                ID_MECA,
                NUM_INT,
                DATA_INT,
				DATA_ENT,
                CLIE_1,
                CLIE_2,
                CLIE_3
               ,APERTO
               ,GRUPPO
               ,imp_fatt   
               ,imp_da_fatt   
               ,M_CUBI_ARSP
               ,giri_f1_pl                
               ,giri_f2_pl
               ,giri_f1_lav
               ,giri_f2_lav
               )  
             values
               (
                 K_ARMO_1_ID_ARMO,
				 K_ARMO_1_ID_LISTINO,
                 K_ARMO_MAGAZZINO,
                 K_ARMO_DOSE,
                 K_ARMO_TRAVASO,
                 K_ARMO_COLLI_1,
                 K_ARMO_COLLI,
                 K_ARMO_M_CUBI,
                 K_ARMO_PEDANE,
                 K_ARMO_ID_MECA,
                 K_ARMO_NUM_INT,
                 K_ARMO_DATA_INT,
				 K_DATA_ENT,
                 K_ARMO_CLIE_1,
                 K_ARMO_CLIE_2,
                 K_ARMO_CLIE_3
                ,K_ARMO_APERTO
                ,K_ARMO_GRUPPO
                ,K_ARMO_imp_fatt
                ,K_ARMO_imp_da_fatt
                ,0.0
                ,K_BARCODE_giri_f1_pl                
                ,K_BARCODE_giri_f2_pl
                ,K_BARCODE_giri_f1_lav
                ,K_BARCODE_giri_f2_lav
               );
      if sqlcode < 0 then
         let k_status = '(u_m2000_2_s_armo)  Errore in insert into s_armo_n  sqlcode' || sqlcode;
         goto FORZA_FINE;
      end if

      let K_CONTA_TOT_REC = K_CONTA_TOT_REC + 1;
               
--- Per evitare che si riempa il log forza la commit ogni tot records      
      let K_CONTA_REC = K_CONTA_REC + 1;
      if K_CONTA_REC > 500 then
         let K_CONTA_REC = 0;
         commit work;
         if sqlcode < 0 then
            let k_status = '(u_m2000_2_s_armo)  Errore in commit work  sqlcode' || sqlcode;
            goto FORZA_FINE;
         end if
         begin work;
--- imposta il tipo di ISOLATION al piu' flessibile, ovvero se incontra righe appena inserite/aggiornate piglia le righe ancora non committed         
         SET ISOLATION TO DIRTY READ;
      end if
                  
   end foreach

   if sqlcode < 0 then
      let k_status = '(u_m2000_2_s_armo)  Errore in foreach C_M_ESTR_S_ARMO  sqlcode' || sqlcode;
      goto FORZA_FINE;
   end if

   
--- Crea gli indici della Tabella ---------------------------------------------------------------------------------------------------------------------------------

--- Durante la cancellazione degli Indici non importano le segnalazioni
   --whenever error continue
   BEGIN 
      ON EXCEPTION END EXCEPTION WITH RESUME;
      commit work;
   END
   
   BEGIN 
      ON EXCEPTION END EXCEPTION WITH RESUME;
--- crea indici 
      drop index informix.i_s_armo_n_0 ;
      drop index informix.i_s_armo_n_1 ;
      drop index informix.i_s_armo_n_2 ;
      drop index informix.i_s_armo_n_3 ;
      drop index informix.i_s_armo_n_4 ;
      drop index informix.i_s_armo_n_5 ;
      drop index informix.i_s_armo_n_6 ;

      create index informix.i_s_armo_n_0 on informix.s_armo_n (id_meca);
      create index informix.i_s_armo_n_1 on informix.s_armo_n (id_armo);
      create index informix.i_s_armo_n_2 on informix.s_armo_n (data_int desc, num_int);
      create index informix.i_s_armo_n_3 on informix.s_armo_n (clie_1, data_int);
      create index informix.i_s_armo_n_4 on informix.s_armo_n (clie_2, data_int);
      create index informix.i_s_armo_n_5 on informix.s_armo_n (clie_3, data_int);
      create index informix.i_s_armo_n_6 on informix.s_armo_n (id_listino);
   
   END
   
   if sqlcode != 0 then
      let k_status = '(u_m2000_2_s_armo)  Errore in  create index  sqlcode' || sqlcode;
      goto FORZA_FINE;
   end if   
   
   goto OK;

<<FORZA_FINE>>
   BEGIN
      ON EXCEPTION END EXCEPTION WITH RESUME;
      rollback;
   END
   goto FINE;

<<OK>>
   BEGIN 
      ON EXCEPTION END EXCEPTION WITH RESUME;
      commit work;
   END
   let k_status = 'Ok caricati ' || K_CONTA_TOT_REC || ' record in tab S_ARMO_N' ;

<<FINE>>
   --trace off;
   return k_status ;

end function
;

                            
                               
                        
---------------------------------------------------------------
--- Tabella link ID-MECA e ID-ARMO
---------------------------------------------------------------
--CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
DROP FUNCTION u_m2000_3_cr_tab_s_meca();
CREATE FUNCTION u_m2000_3_cr_tab_s_meca()
  RETURNING VARCHAR(100);

  
   define k_status varchar(100);
     
   --set debug file to '.\m2000_nt.trace.txt';
   --trace on;
     
   --whenever error continue;
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
   --lock table informix.s_meca_n in exclusive mode; 
      drop view informix.s_meca;
      drop table informix.s_meca_n;
   END

--- solo per INFORMIX 12.10
--create table informix.s_meca as select * from informix.s_meca_p;

-- x informix vecchi
   create table informix.s_meca_n
       (
        id_meca         integer,
        id_armo         integer
       );
   if sqlcode < 0 then
      let k_status = '(u_m2000_3_cr_tab_s_meca)  Errore in create table informix.s_meca_n sqlcode' || sqlcode;
      --rollback;
      goto FORZA_FINE;
   end if
   --commit;

   CREATE VIEW informix.s_meca AS 
      SELECT * 
         FROM informix.s_meca_n;
--      union all
--      SELECT * 
--         FROM informix.s_meca_p;

   if sqlcode < 0 then
      let k_status = '(u_m2000_3_cr_tab_s_meca)  Errore in  CREATE VIEW informix.s_meca  sqlcode' || sqlcode;
      BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
         rollback;
      END
      goto FORZA_FINE;
   end if

--INSERT INTO informix.s_meca SELECT * FROM informix.s_meca_p;


   revoke all on informix.s_meca_n from public;
   grant all on "informix".s_meca_n to "ixuser" as "informix";
   revoke all on informix.s_meca from public;
   grant all on "informix".s_meca to "ixuser" as "informix";


    goto OK;

<<FORZA_FINE>>
   --rollback;
   goto FINE;

<<OK>>
   --commit;
   let k_status = 'Ok operazione conclusa, create Table s_meca_n e View  s_meca' ;

<<FINE>>
   --trace off;

return K_STATUS ;


end function
;------------------------------- CARICA ID-MECA - ID-ARMO ---------------------------------
--CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
DROP FUNCTION u_m2000_4_s_meca();
CREATE FUNCTION u_m2000_4_s_meca()
  RETURNING VARCHAR(100);

  
   define k_status varchar(100);
   define K_DATA_LIMITE  date;
   define K_CONTA_REC, K_CONTA_TOT_REC, k_ctr   integer;
   --define k_data_elab_da, k_data_elab_a   date;
   define k_ARMO_1_ID_ARMO  like ARMO.ID_ARMO;  
   define k_ARMO_1_ID_MECA  like ARMO.ID_MECA;     
     
   --set debug file to '.\m2000_nt.trace.txt';
   --trace on;

   --- se incontra lock attende 300 secondi prima di andare in errore
   set lock mode to wait 300;
   
   --commit;
   begin work;
--- imposta il tipo di ISOLATION al piu' flessibile, ovvero se incontra righe appena inserite/aggiornate piglia le righe ancora non committed         
   SET ISOLATION TO DIRTY READ;

   let K_CONTA_TOT_REC = 0;
   let K_CONTA_REC = 0;
----------------------------------------------------------------------------------------
-- DATA LIMITE FINO DA CUI ESTRARRE 
   select max(data_int) 
        into K_DATA_LIMITE
        from s_armo_p;
   if sqlcode <> 0 then
      let k_status = '(u_m2000_4_s_meca)  Errore in select max(data_int)  x K_DATA_LIMITE  sqlcode' || sqlcode;
      goto FORZA_FINE;
   end if
----------------------------------------------------------------------------------------
      
   --let k_data_elab_da = mdy(01,01, year(today) - 4);

   --- Lettura archivio entrate per estrarre i singoli articoli
   foreach C_M_ESTR_S_MECA_0 with hold for
           select distinct 
                    ID_ARMO,
                    ID_MECA
                into  
                    K_ARMO_1_ID_ARMO
                    ,K_ARMO_1_ID_MECA
                from  armo 
             where id_armo is not null and id_meca is not null
                   AND ARMO.DATA_INT > K_DATA_LIMITE
             order by id_meca, id_armo

   --- carico record                             
      insert into s_meca_n
                  (
                  ID_MECA
                  ,ID_ARMO
                  )  
                values
                  (
                   k_armo_1_ID_MECA
                   ,k_armo_1_ID_armo
                  );

      if sqlcode < 0 then
         let k_status = '(u_m2000_4_s_meca)  Errore in insert into s_meca_n  sqlcode' || sqlcode;
         goto FORZA_FINE;
      end if

      let K_CONTA_TOT_REC = K_CONTA_TOT_REC + 1;
   --- Per evitare che si riempa il log forza la commit ogni tot records      
      let K_CONTA_REC = K_CONTA_REC + 1;
      if K_CONTA_REC > 1000 then
         let K_CONTA_REC = 0;
         commit work;
         begin work;
   --- imposta il tipo di ISOLATION al piu' flessibile, ovvero se incontra tab con Insert piglia le righe ancora non committed         
         SET ISOLATION TO DIRTY READ;
      end if

   end foreach

   if sqlcode < 0 then
      let k_status = '(u_m2000_4_s_meca)  Errore in foreach C_M_ESTR_S_MECA_0  sqlcode' || sqlcode;
      goto FORZA_FINE;
   end if

   goto OK;

<<FORZA_FINE>>
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
      rollback;
   END
   goto FINE;

<<OK>>
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
      commit work;
   END
   let k_status = 'Ok caricati ' || K_CONTA_TOT_REC || ' record in tab S_MECA_N' ;

<<FINE>>
   --trace off;

return K_STATUS ;


end function
;

---------------------------------------------------------------
--- Tabella Trattamenti
---------------------------------------------------------------
--CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
DROP FUNCTION u_m2000_5_cr_tab_s_artr();
CREATE FUNCTION u_m2000_5_cr_tab_s_artr()
  RETURNING VARCHAR(100);

  
   define k_status varchar(100);
     
   --set debug file to '.\m2000_nt.trace.txt';
   --trace on;
     
   --whenever error continue;
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
   --lock table informix.s_meca_n in exclusive mode; 
      drop view informix.s_artr;
      drop table informix.s_artr_n;
   END
-- solo per INFORMIX 12.10
--create table informix.s_artr as select * from informix.s_artr_p;

   --begin work;

--- x informix vecchi
   create table informix.s_artr_n
       (
        id_armo         integer,
        id_meca         integer,
        data_lav_fin    date,
        colli_trattati  decimal(09,0),
        colli_entrati   decimal(09,0),
        colli_fatturati decimal(09,0),
        colli_armo_fatt decimal(09,0),
        m_cubi          decimal(12,2),
        pedane          decimal(12,2),
        giri_f1_pl      integer,
        giri_f1_lav     integer,
        giri_f2_pl      integer,
        giri_f2_lav     integer,
        giri_f1_pl_gp      integer,
        giri_f1_lav_gp     integer,
        giri_f2_pl_gp      integer,
        giri_f2_lav_gp     integer,
        imp_x_collo     decimal(15,2),
        OCCUP_PED    integer,
         importo_girif1   decimal(15,2),
         importo_girif2   decimal(15,2),
         importo_giri   decimal(15,2),
         nr_pedane      integer
      , colli_F1_PL     integer
      , colli_F2_PL     integer
      , colli_F1_LAV     integer
      , colli_F2_LAV     integer
      , colli_F1_PL_GP     integer
      , colli_F2_PL_GP     integer
      , colli_F1_LAV_GP     integer
      , colli_F2_LAV_GP     integer
       );
   if sqlcode < 0 then
      let k_status = '(u_m2000_5_cr_tab_s_artr)  Errore in  create table informix.s_artr_n  sqlcode' || sqlcode;
      goto FORZA_FINE;
   end if


   CREATE VIEW informix.s_artr AS 
      SELECT * 
         FROM informix.s_artr_n;
--      union all
--      SELECT * 
--         FROM informix.s_artr_p;

   if sqlcode < 0 then
      let k_status = '(u_m2000_5_cr_tab_s_artr)  Errore in  CREATE VIEW informix.s_artr  sqlcode' || sqlcode;
      goto FORZA_FINE;
   end if
--   INSERT INTO informix.s_artr SELECT * FROM informix.s_artr_p;


   revoke all on informix.s_artr_n from public;
   grant all on "informix".s_artr_n to "ixuser" as "informix";
   revoke all on informix.s_artr from public;
   grant all on "informix".s_artr to "ixuser" as "informix";


    goto OK;

<<FORZA_FINE>>
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
      rollback;
   END
   goto FINE;

<<OK>>
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
      commit;
   END
   let k_status = 'Ok operazione conclusa, create Table s_artr_n e View  s_artr' ;

<<FINE>>
   --trace off;

   return K_STATUS ;


end function
; 
                                    ------------------------------- CARICA DATI TRATTAMENTO (ARTR)  ---------------------------------
--CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
DROP FUNCTION u_m2000_6_s_artr();
CREATE FUNCTION u_m2000_6_s_artr()
  RETURNING VARCHAR(100);

  
   define k_status varchar(100);
   define K_DATA_LIMITE, k_data_nuovo_grp date;
   define K_CONTA_REC, K_CONTA_TOT_REC integer;
   --define k_data_elab          date;

   define k_ARMO_1_ID_ARMO       like ARMO.ID_ARMO;   
   define k_ARMO_1_DOSE          like ARMO.DOSE;
   define k_ARMO_1_ART           like ARMO.ART;
   define k_ARMO_1_COLLI_2       like ARMO.COLLI_2;
   define k_ARMO_1_LARG_2        like ARMO.LARG_2;
   define k_ARMO_1_LUNG_2        like ARMO.LUNG_2;
   define k_ARMO_1_ALT_2         like ARMO.ALT_2;
   define k_ARMO_1_COLLI_FATT like ARMO.COLLI_FATT;
   define k_ARMO_1_PESO_KG       like ARMO.PESO_KG;
   define k_ARMO_1_M_CUBI        like ARMO.M_CUBI;
   define k_ARMO_1_PEDANE        like ARMO.PEDANE;
   define k_ARMO_1_ID_MECA       like ARMO.ID_MECA;     
   define k_ARMO_1_CLIE_3        like S_ARMO.CLIE_3;      
   define k_ARMO_1_ID_LISTINO    like ARMO.ID_LISTINO;
      
   define K_giri_f1_pl           integer;
   define K_giri_f1p_pl          integer;
   define K_giri_f2_pl           integer;
   define K_giri_f2p_pl          integer;
   define K_giri_f1_lav          integer;
   define K_giri_f1p_lav         integer;
   define K_giri_f2_lav          integer;
   define K_giri_f2p_lav         integer;
   define K_giri_f1_pl_gp        integer;
   define K_giri_f1p_pl_gp       integer;
   define K_giri_f2_pl_gp        integer;
   define K_giri_f2p_pl_gp       integer;
   define K_giri_f1_lav_gp       integer;
   define K_giri_f1p_lav_gp      integer;
   define K_giri_f2_lav_gp       integer;
   define K_giri_f2p_lav_gp      integer;
   define k_barcode_padre        like barcode.barcode;
   define k_OCCUP_PED_calcolata  like LISTINO.OCCUP_PED;
   define k_nr_padri             integer;
   define k_nr_figli             integer;
   define k_importo_giri         decimal(15,2);  
   define k_importo_giriF1       decimal(15,2); 
   define k_importo_giriF2       decimal(15,2);  
   define k_ctr                  integer;
   define K_NR_BARCODE_F1_PL     integer;
   define K_NR_BARCODE_F2_PL     integer;
   define K_NR_BARCODE_F1_LAV    integer;
   define K_NR_BARCODE_F2_LAV    integer;
   define K_NR_BARCODE_F1_PL_GP  integer;
   define K_NR_BARCODE_F2_PL_GP  integer;
   define K_NR_BARCODE_F1_LAV_GP integer;
   define K_NR_BARCODE_F2_LAV_GP integer;
      
   define K_BARCODE_giri_fn_lav     integer; 
   define K_BARCODE_giri_f1_pl      integer;
   define K_BARCODE_giri_f1_lav     integer;
   define K_BARCODE_giri_f2_pl      integer;
   define K_BARCODE_giri_f2_lav     integer;
   define K_BARCODE_giri_f1_pl_gp   integer;
   define K_BARCODE_giri_f1_lav_gp  integer;
   define K_BARCODE_giri_f2_pl_gp   integer;
   define K_BARCODE_giri_f2_lav_gp  integer;
   define K_BARCODE_barcode_lav  like barcode.barcode_lav;
 
   define K_arfa_colli        integer;
   define K_arfa_prezzo_u     like arfa.prezzo_u;
   define K_arfa_prezzo_t     like arfa.prezzo_t;

   define K_ARTR_COLLI         like ARMO.COLLI_2;
   define K_ARTR_M_CUBI        like ARMO.M_CUBI;
   define K_ARTR_PEDANE        like ARMO.PEDANE;
   define K_ARTR_DATA_lav_FIN  like artr.data_fin;
   define K_ARTR_imp_fatt      decimal(15,2);
   define K_ARTR_imp_da_fatt   decimal(15,2);
      
   define K_LISTINO_MAGAZZINO   like LISTINO.MAGAZZINO;
   define K_LISTINO_PREZZO      like LISTINO.PREZZO;
   define K_LISTINO_PREZZO_2    like LISTINO.PREZZO;
   define K_LISTINO_PREZZO_3    like LISTINO.PREZZO;
   define K_LISTINO_TIPO        like LISTINO.TIPO;
   define K_LISTINO_CAMPIONE    like LISTINO.CAMPIONE;
   define K_LISTINO_M_CUBI_F    like LISTINO.M_CUBI_F;
   define K_LISTINO_OCCUP_PED   like LISTINO.OCCUP_PED;
      

   let k_data_nuovo_grp = mdy(10,26, 2006);      
   --let k_data_elab = mdy(01,01, year(today) - 4)      
   begin work;
--- imposta il tipo di ISOLATION al piu' flessibile, ovvero se incontra righe appena inserite/aggiornate piglia le righe ancora non committed         
   SET ISOLATION TO DIRTY READ;

   let K_CONTA_TOT_REC = 0;
   let K_CONTA_REC = 0;
----------------------------------------------------------------------------------------
-- DATA LIMITE FINO DA CUI ESTRARRE 
   select max(data_int) 
        into K_DATA_LIMITE
        from s_armo_p;
   if sqlcode <> 0 then
      let k_status = '(u_m2000_6_s_artr)  Errore in select max(data_int)  x K_DATA_LIMITE  sqlcode' || sqlcode;
      goto FORZA_FINE;
   end if
----------------------------------------------------------------------------------------

--- Lettura archivio TRATTAMENTI 
   foreach C_M_ESTR_S_ARTR with hold for
      select
             ID_MECA,
             ID_ARMO,
             DATA_LAV_FIN,
             count(*)
         into  
              k_ARMO_1_ID_MECA
             ,k_ARMO_1_ID_ARMO
             ,K_ARTR_DATA_LAV_FIN         
             ,K_ARTR_COLLI      
         from  barcode
         where 
             BARCODE.DATA_INT > K_DATA_LIMITE
         group by 
            ID_MECA,
            ID_ARMO,
            DATA_LAV_FIN
         order by 
            ID_MECA,
            ID_ARMO
 
      let K_NR_BARCODE_F1_PL = 0;
      let K_NR_BARCODE_F2_PL = 0;
      let K_NR_BARCODE_F1_LAV = 0;
      let K_NR_BARCODE_F2_LAV = 0;
      let K_NR_BARCODE_F1_PL_GP = 0;
      let K_NR_BARCODE_F2_PL_GP = 0;
      let K_NR_BARCODE_F1_LAV_GP = 0;
      let K_NR_BARCODE_F2_LAV_GP = 0;
      
      let K_BARCODE_giri_f1_pl = 0; 
      let K_BARCODE_giri_f2_pl = 0; 
      let K_BARCODE_giri_f1_lav = 0; 
      let K_BARCODE_giri_f2_lav = 0; 
      let K_BARCODE_giri_f1_pl_gp = 0; 
      let K_BARCODE_giri_f2_pl_gp = 0; 
      let K_BARCODE_giri_f1_lav_gp = 0; 
      let K_BARCODE_giri_f2_lav_gp = 0; 
         
 
--------------------------------------------------------------------------------------------------------
--- Piglia i giri di lavorazione dal BARCODE poiche' solo qui c'e' la vera situazione di Lavorazione  
--- dal 26.10.2006 e' entrato in funzione il nuovo 'GROUPAGE' 
---      per riconoscere il groupage figlio e' necessario testare il barcode_lav (pres. del PADRE)
--- somma tutti i giri groupage e no        
--------------------------------------------------------------------------------------------------------
      foreach C_M_ESTR_S_ARTR1 with hold for
         select
             FILA_1
             ,FILA_1P
             ,FILA_2
             ,FILA_2P
             ,lav_FILA_1
             ,lav_FILA_1P
             ,lav_FILA_2
             ,lav_FILA_2P
             ,0
             ,0
             ,0
             ,0
             ,0
             ,0
             ,0
             ,0
            into
                   K_giri_f1_pl
                   ,K_giri_f1p_pl
                   ,K_giri_f2_pl
                   ,K_giri_f2p_pl
                   ,K_giri_f1_lav
                   ,K_giri_f1p_lav
                   ,K_giri_f2_lav
                   ,K_giri_f2p_lav
                   ,K_giri_f1_pl_gp
                   ,K_giri_f1p_pl_gp
                   ,K_giri_f2_pl_gp
                   ,K_giri_f2p_pl_gp
                   ,K_giri_f1_lav_gp
                   ,K_giri_f1p_lav_gp
                   ,K_giri_f2_lav_gp
                   ,K_giri_f2p_lav_gp
         from barcode
         where barcode.id_armo = k_ARMO_1_ID_ARMO 
               and data_lav_fin = K_ARTR_DATA_LAV_FIN
               and (groupage <> 'S' or groupage is null)
               and data_lav_fin <= k_data_nuovo_grp 
          union all 
         select
             FILA_1
             ,FILA_1P
             ,FILA_2
             ,FILA_2P
             ,lav_FILA_1
             ,lav_FILA_1P
             ,lav_FILA_2
             ,lav_FILA_2P
             ,0
             ,0
             ,0
             ,0
             ,0
             ,0
             ,0
             ,0
         from barcode
         where barcode.id_armo = k_ARMO_1_ID_ARMO 
               and data_lav_fin = K_ARTR_DATA_LAV_FIN
               and (barcode_lav = ' ' or barcode_lav is null)
               and data_lav_fin > k_data_nuovo_grp 
          union all 
        select
             0
             ,0
             ,0
             ,0
             ,0
             ,0
             ,0
             ,0
             ,FILA_1
             ,FILA_1P
             ,FILA_2
             ,FILA_2P
             ,lav_FILA_1
             ,lav_FILA_1P
             ,lav_FILA_2
             ,lav_FILA_2P
         from barcode 
         where barcode.id_armo = k_ARMO_1_ID_ARMO 
               and data_lav_fin = K_ARTR_DATA_LAV_FIN
               and (groupage = 'S')
               and data_lav_fin <= k_data_nuovo_grp 
          union all 
        select
             0
             ,0
             ,0
             ,0
             ,0
             ,0
             ,0
             ,0
             ,FILA_1
             ,FILA_1P
             ,FILA_2
             ,FILA_2P
             ,lav_FILA_1
             ,lav_FILA_1P
             ,lav_FILA_2
             ,lav_FILA_2P
         from barcode
         where barcode.id_armo = k_ARMO_1_ID_ARMO 
               and data_lav_fin = K_ARTR_DATA_LAV_FIN
               and barcode_lav <> ' ' and barcode_lav is not null
               and data_lav_fin > k_data_nuovo_grp 

         if K_giri_f1_pl is null then let K_giri_f1_pl = 0; end if
         if K_giri_f1p_pl is null then let K_giri_f1p_pl = 0; end if
         if K_giri_f2_pl is null then let K_giri_f2_pl = 0; end if
         if K_giri_f2p_pl is null then let K_giri_f2p_pl = 0; end if
         if K_giri_f1_lav is null then let K_giri_f1_lav = 0; end if
         if K_giri_f1p_lav is null then let K_giri_f1p_lav = 0; end if
         if K_giri_f2_lav is null then let K_giri_f2_lav = 0; end if
         if K_giri_f2p_lav is null then let K_giri_f2p_lav = 0; end if

         if K_giri_f1_pl_gp is null then let K_giri_f1_pl_gp = 0; end if
         if K_giri_f1p_pl_gp is null then let K_giri_f1p_pl_gp = 0; end if
         if K_giri_f2_pl_gp is null then let K_giri_f2_pl_gp = 0; end if
         if K_giri_f2p_pl_gp is null then let K_giri_f2p_pl_gp = 0; end if
         if K_giri_f1_lav_gp is null then let K_giri_f1_lav_gp = 0; end if
         if K_giri_f1p_lav_gp is null then let K_giri_f1p_lav_gp = 0; end if
         if K_giri_f2_lav_gp is null then let K_giri_f2_lav_gp = 0; end if
         if K_giri_f2p_lav_gp is null then let K_giri_f2p_lav_gp = 0; end if

-- 131213 calcolo colli in fila 1 e fila 2
         if K_giri_f1_pl > 0 then let K_NR_BARCODE_F1_PL = K_NR_BARCODE_F1_PL + 1; end if
         if K_giri_f2_pl > 0 then let K_NR_BARCODE_F2_PL = K_NR_BARCODE_F2_PL + 1; end if
         if K_giri_f1_lav > 0 then let K_NR_BARCODE_F1_LAV = K_NR_BARCODE_F1_LAV + 1; end if
         if K_giri_f2_lav > 0 then let K_NR_BARCODE_F2_LAV = K_NR_BARCODE_F2_LAV + 1; end if
         if K_giri_f1_pl_gp > 0 then let K_NR_BARCODE_F1_PL_GP = K_NR_BARCODE_F1_PL_GP + 1; end if
         if K_giri_f2_pl_gp > 0 then let K_NR_BARCODE_F2_PL_GP = K_NR_BARCODE_F2_PL_GP + 1; end if
         if K_giri_f1_lav_gp > 0 then let K_NR_BARCODE_F1_LAV_GP = K_NR_BARCODE_F1_LAV_GP + 1; end if
         if K_giri_f2_lav_gp > 0 then let K_NR_BARCODE_F2_LAV_GP = K_NR_BARCODE_F2_LAV_GP + 1; end if
          

         let K_BARCODE_giri_f1_pl = K_BARCODE_giri_f1_pl + K_giri_f1_pl + K_giri_f1p_pl;
         let K_BARCODE_giri_f2_pl = K_BARCODE_giri_f2_pl + K_giri_f2_pl + K_giri_f2p_pl;
         let K_BARCODE_giri_f1_lav = K_BARCODE_giri_f1_lav + K_giri_f1_lav + K_giri_f1p_lav;
         let K_BARCODE_giri_f2_lav = K_BARCODE_giri_f2_lav + K_giri_f2_lav + K_giri_f2p_lav;
         let K_BARCODE_giri_f1_pl_gp = K_BARCODE_giri_f1_pl_gp + K_giri_f1_pl_gp + K_giri_f1p_pl_gp;
         let K_BARCODE_giri_f2_pl_gp = K_BARCODE_giri_f2_pl_gp + K_giri_f2_pl_gp + K_giri_f2p_pl_gp;
         let K_BARCODE_giri_f1_lav_gp = K_BARCODE_giri_f1_lav_gp + K_giri_f1_lav_gp + K_giri_f1p_lav_gp;
         let K_BARCODE_giri_f2_lav_gp = K_BARCODE_giri_f2_lav_gp + K_giri_f2_lav_gp + K_giri_f2p_lav_gp;
         
      end foreach
      if sqlcode < 0 then
         let k_status = '(u_m2000_6_s_artr)  Errore in foreach C_M_ESTR_S_ARTR1 sqlcode' || sqlcode;
         goto FORZA_FINE;
      end if
   
---------------------------------------------------------------------------------------------------------------------------------------
      if K_ARTR_colli is null then let K_ARTR_colli = 0; end if
         

--- Lettura archivio entrate per estrarre i singoli articoli
      --fetch C_M_ESTR_S_ARTR_0 with hold for
      select ARMO.ID_LISTINO,
                 ARMO.DOSE,
                 ARMO.ART,
                 ARMO.PESO_KG,
                 ARMO.M_CUBI,
                 ARMO.PEDANE,
                 ARMO.COLLI_2,
                 ARMO.LARG_2,
                 ARMO.LUNG_2,
                 ARMO.ALT_2,
                 ARMO.COLLI_FATT,
                 MECA.ID,
                 MECA.CLIE_3
             into  
                 k_ARMO_1_ID_LISTINO,
                 k_ARMO_1_DOSE,
                 k_ARMO_1_ART,
                 k_ARMO_1_PESO_KG,
                 k_ARMO_1_M_CUBI,
                 k_ARMO_1_PEDANE,
                 k_ARMO_1_COLLI_2,
                 k_ARMO_1_LARG_2,
                 k_ARMO_1_LUNG_2,
                 k_ARMO_1_ALT_2,
                 k_ARMO_1_COLLI_FATT,
                 k_ARMO_1_ID_MECA,
                 k_ARMO_1_CLIE_3
             from  ARMO, outer MECA 
             where id_armo = k_ARMO_1_ID_ARMO  
                    and meca.id = armo.id_meca; 

      let K_arfa_prezzo_t = 0;
      let K_arfa_colli = 0;
      let K_ARTR_imp_fatt = 0;

--- Dati Fattura se ci sono....       
      select sum(prezzo_t), sum(colli)
         into K_arfa_prezzo_t, K_arfa_colli
         from arfa
         where arfa.id_armo = k_ARMO_1_ID_ARMO;
      if sqlcode < 0 then
         let k_status = '(u_m2000_6_s_artr)  Errore in select sum(prezzo_t), sum(colli)  sqlcode' || sqlcode;
         goto FORZA_FINE;
      end if

--- Ottengo il Prezzo Unitario x collo      
      if sqlcode <> 0 or K_arfa_colli is null or K_arfa_colli = 0 then 
         let K_arfa_colli = 0; 
         let K_arfa_prezzo_u = 0; 
      else
         let K_arfa_prezzo_u = (K_arfa_prezzo_t / K_arfa_colli);
      end if 

--- Sistemazione 'grossolana' del campo COLLI_FATT 
      if k_ARMO_1_colli_fatt is null then 
         let k_ARMO_1_colli_fatt  = 0; 
      end if
      if k_ARMO_1_colli_fatt > k_ARMO_1_COLLI_2 then 
         let k_ARMO_1_colli_fatt  = k_ARMO_1_COLLI_2;
      end if
      
--- se no fattura calcolo prezzo unitario dal listino
      if K_arfa_prezzo_u = 0 then 
      
         select      LISTINO.MAGAZZINO,
                     LISTINO.PREZZO,
                     LISTINO.PREZZO_2,
                     LISTINO.PREZZO_3,
                     LISTINO.TIPO,
                     LISTINO.CAMPIONE,
                     LISTINO.M_CUBI_F,
                     LISTINO.OCCUP_PED
            into     K_LISTINO_MAGAZZINO,
                     k_listino_PREZZO,
                     k_listino_PREZZO_2,
                     k_listino_PREZZO_3,
                     k_listino_TIPO,
                     k_listino_CAMPIONE,
                     k_listino_M_CUBI_F,
                     k_listino_OCCUP_PED
            from LISTINO 
            where  
                  LISTINO.id =  k_ARMO_1_id_listino ;
         if sqlcode < 0 then
            let k_status = '(u_m2000_6_s_artr)  Errore in select LISTINO.MAGAZZINO, su LISTINO sqlcode' || sqlcode;
            goto FORZA_FINE;
         end if
                      
--- CALCOLO DEL PREZZO                 
         if SQLCODE = 0 then

            if k_listino_OCCUP_PED is NULL then
               let k_listino_OCCUP_PED = 100;
            end if
            if k_listino_PREZZO is NULL then
               let k_listino_PREZZO     = 0;
            end if
            if k_listino_PREZZO_2 is NULL then
               let k_listino_PREZZO_2     = 0;
            end if
            if k_listino_PREZZO_3 is NULL then
               let k_listino_PREZZO_3     = 0;
            end if
--- prende il prezzo piu' alto (quello senza sconti)
            if k_listino_PREZZO_2 > k_listino_PREZZO then
               let k_listino_PREZZO = k_listino_PREZZO_2;
            end if
            if k_listino_PREZZO_3 > k_listino_PREZZO then
               let k_listino_PREZZO = k_listino_PREZZO_3;
            end if  

--- Calcolo i metri cubi per la fatturazione, che possono differire da quelli
--- reali se, impostati nel Listino
            if k_listino_M_CUBI_F > 0 then
               let k_ARMO_1_M_CUBI = K_ARTR_colli * k_listino_M_CUBI_F;
            end if

            BEGIN
               ON EXCEPTION IN (1202)  --Divisione x ZERO
               let k_status = '(u_m2000_6_s_artr)  Errore Divisione per ZERO-1 nel ID riga lotto: ' || k_ARMO_1_ID_ARMO; 
               BEGIN
                  ON EXCEPTION END EXCEPTION WITH RESUME;
                  rollback;
               END
               return k_status;
            END EXCEPTION
            case k_listino_TIPO
               when "C" then
                  let K_arfa_prezzo_u =  k_listino_PREZZO; 
               when "P" then
                  let K_arfa_prezzo_u =  k_listino_PREZZO * (k_ARMO_1_PESO_KG / k_ARMO_1_colli_2);
               when "M" then
                  let K_arfa_prezzo_u =  k_listino_PREZZO * (k_ARMO_1_M_CUBI / k_ARMO_1_colli_2);
               when "B" then
                  let K_arfa_prezzo_u =  k_listino_PREZZO * (k_ARMO_1_PEDANE / k_ARMO_1_colli_2);
               else
                  let K_arfa_prezzo_u =  k_listino_PREZZO;
            end case
            END
         end if

      end if

      if k_ARMO_1_M_CUBI > 0 and k_ARMO_1_colli_2 > 0 then
         let K_ARTR_M_CUBI = (k_ARMO_1_M_CUBI / k_ARMO_1_colli_2) * K_ARTR_colli;
      else
         let K_ARTR_M_CUBI = 0;
      end if
      if k_ARMO_1_PEDANE > 0 and k_ARMO_1_colli_2 > 0 then
         let K_ARTR_PEDANE = (k_ARMO_1_PEDANE / k_ARMO_1_colli_2) * K_ARTR_colli;
      else
         let K_ARTR_PEDANE = 0;
      end if

--- calcolo il numero barcode sulla pedana  dove hanno girato i barcode di un certo ID_ARMO ---------------------------------------------------------------        
      let k_nr_padri = 0; -- che è poi il nr pedane utilizzate
      let k_nr_figli = 0;
      let k_importo_giri = 0;
      let k_importo_giriF1 = 0;
      let k_importo_giriF2 = 0;
      
      if K_ARTR_data_lav_fin  > k_data_nuovo_grp then

--- prima calcola i padri del ID_ARMO      
         foreach C_M_ESTR_S_ARTR2 with hold for
             select barcode 
               into k_barcode_padre
              from barcode 
               where barcode.id_armo = k_ARMO_1_ID_ARMO 
                     and barcode.data_lav_fin = K_ARTR_data_lav_fin 
                     and (barcode_lav = ' ' or barcode_lav is null)
            
            let k_nr_padri = k_nr_padri + 1;
--- conta i figli         
            let k_ctr = 0;
            select count (*) 
                 into k_ctr
                 from barcode
                 where barcode_lav = k_barcode_padre;
            if sqlcode < 0 then
               let k_status = '(u_m2000_6_s_artr)  Errore in select count (*) su barcode sqlcode' || sqlcode;
               goto FORZA_FINE;
            end if
            
            if k_ctr > 0 then 
               let k_nr_figli = k_nr_figli + k_ctr;
            end if
            
         end foreach
         if sqlcode < 0 then
            let k_status = '(u_m2000_6_s_artr)  Errore in foreach C_M_ESTR_S_ARTR2 sqlcode' || sqlcode;
            goto FORZA_FINE;
         end if
 
         if k_nr_figli is null then 
            let k_nr_figli = 0;
         end if
         
--- poi calcola i padri che appartengono a un altro ID_ARMO  ma con figli di questo ID_ARMO
         foreach C_M_ESTR_S_ARTR3 with hold for
             select distinct barcode_lav 
               into k_barcode_padre
                 from barcode 
                  where barcode.id_armo = k_ARMO_1_ID_ARMO 
                        and barcode.data_lav_fin = K_ARTR_data_lav_fin 
                        and barcode_lav > ' '
                        and barcode_lav <> barcode 
               
            let k_nr_padri = k_nr_padri + 1;
--- conta i figli         
            let k_ctr = 0;
            select count (*) 
                 into k_ctr
                 from barcode
                 where barcode_lav = k_barcode_padre;
            if k_ctr > 0 then 
               let k_nr_figli = k_nr_figli + k_ctr;
            end if
            if sqlcode < 0 then
               let k_status = '(u_m2000_6_s_artr)  Errore in foreach C_M_ESTR_S_ARTR3 sqlcode' || sqlcode;
               goto FORZA_FINE;
            end if

         end foreach
         if sqlcode < 0 then
            let k_status = '(u_m2000_6_s_artr)  Errore in select count (*) da barcode sqlcode' || sqlcode;
            goto FORZA_FINE;
         end if

         if k_nr_figli is null then 
            let k_nr_figli = 0;
         end if
       
         if k_nr_figli > 0 or k_nr_padri > 0 then --nr barcode contenuti nelle pedane dove c'earno i barcode del ID_ARMO
            let k_importo_giri =  K_arfa_prezzo_u * (k_nr_figli + k_nr_padri);

--- media prezzo a giro x Fila 1 e 2    18-01-2014  
            let K_BARCODE_giri_fn_lav = (K_BARCODE_giri_f1_lav + K_BARCODE_giri_f1_lav_gp + K_BARCODE_giri_f2_lav + K_BARCODE_giri_f2_lav_gp );
            if K_BARCODE_giri_fn_lav = 0 or K_BARCODE_giri_fn_lav is null then
               let K_BARCODE_giri_fn_lav = 1;
            end if
            let k_importo_giriF1 = (K_arfa_prezzo_u * K_ARTR_COLLI) * ((K_BARCODE_giri_f1_lav + K_BARCODE_giri_f1_lav_gp) 
                  / K_BARCODE_giri_fn_lav
                  );
            let k_importo_giriF2 = (K_arfa_prezzo_u * K_ARTR_COLLI) * ((K_BARCODE_giri_f2_lav + K_BARCODE_giri_f2_lav_gp) 
                  / K_BARCODE_giri_fn_lav
                  );
                  --/ (K_BARCODE_giri_f1_lav + K_BARCODE_giri_f1_lav_gp + K_BARCODE_giri_f2_lav + K_BARCODE_giri_f2_lav_gp )  
                  --/ (K_BARCODE_giri_f1_lav + K_BARCODE_giri_f1_lav_gp + K_BARCODE_giri_f2_lav + K_BARCODE_giri_f2_lav_gp )  
         end if
         
      end if
---------------------------------------------------------------------------------------------------------------------------------
 
--- carico record                             
      insert into s_artr_n
               (
               ID_MECA
               ,ID_ARMO
               ,data_lav_fin               
               ,colli_trattati               
               ,colli_entrati               
               ,colli_fatturati               
               ,colli_armo_fatt               
               ,M_CUBI               
               ,PEDANE               
               ,giri_f1_pl                
               ,giri_f2_pl
               ,giri_f1_lav
               ,giri_f2_lav
               ,giri_f1_pl_gp                
               ,giri_f2_pl_gp
               ,giri_f1_lav_gp
               ,giri_f2_lav_gp
               ,imp_x_collo 
               ,OCCUP_PED
               ,importo_giriF1
               ,importo_giriF2
               ,importo_giri
               ,nr_pedane
               , colli_F1_PL 
               , colli_F2_PL 
               , colli_F1_LAV 
               , colli_F2_LAV 
               , colli_F1_PL_GP 
               , colli_F2_PL_GP 
               , colli_F1_LAV_GP 
               , colli_F2_LAV_GP 
               )  
             values
               (
                k_ARMO_1_ID_MECA
                ,k_ARMO_1_ID_armo
                ,K_ARTR_data_lav_fin               
                ,K_ARTR_COLLI
                ,k_ARMO_1_COLLI_2
                ,K_arfa_colli
                ,k_ARMO_1_COLLI_FATT
                ,K_ARTR_M_CUBI
                ,K_ARTR_PEDANE
                ,K_BARCODE_giri_f1_pl                
                ,K_BARCODE_giri_f2_pl
                ,K_BARCODE_giri_f1_lav
                ,K_BARCODE_giri_f2_lav
                ,K_BARCODE_giri_f1_pl_gp                
                ,K_BARCODE_giri_f2_pl_gp
                ,K_BARCODE_giri_f1_lav_gp
                ,K_BARCODE_giri_f2_lav_gp
                ,K_arfa_prezzo_u
                ,k_listino_OCCUP_PED
               ,k_importo_giriF1
               ,k_importo_giriF2
               ,k_importo_giri
               ,k_nr_padri
               , K_NR_BARCODE_F1_PL 
               , K_NR_BARCODE_F2_PL 
               , K_NR_BARCODE_F1_LAV 
               , K_NR_BARCODE_F2_LAV 
               , K_NR_BARCODE_F1_PL_GP 
               , K_NR_BARCODE_F2_PL_GP 
               , K_NR_BARCODE_F1_LAV_GP 
               , K_NR_BARCODE_F2_LAV_GP 
               );

      if sqlcode < 0 then
         let k_status = '(u_m2000_6_s_artr)  Errore in foreach insert into s_artr_n sqlcode' || sqlcode;
         goto FORZA_FINE;
      end if

      let K_CONTA_TOT_REC = K_CONTA_TOT_REC + 1;
--- Per evitare che si riempa il log forza la commit ogni tot records      
      let K_CONTA_REC = K_CONTA_REC + 1;
      if K_CONTA_REC > 1000 then
         let K_CONTA_REC = 0;
         commit work;
         begin work;
--- imposta il tipo di ISOLATION al piu' flessibile, ovvero se incontra tab con Insert piglia le righe ancora non committed         
         SET ISOLATION TO DIRTY READ;
      end if
                  
   end foreach
 
   if sqlcode < 0 then
      let k_status = '(u_m2000_6_s_artr)  Errore in foreach C_M_ESTR_S_ARTR sqlcode' || sqlcode;
      goto FORZA_FINE;
   end if

--- Crea gli indici della Tabella ---------------------------------------------------------------------------------------------------------------------------------

--- Durante la cancellazione degli Indici non importano le segnalazioni
   --whenever error continue
   BEGIN 
      ON EXCEPTION END EXCEPTION WITH RESUME;
      commit work;
   END
   BEGIN 
      ON EXCEPTION END EXCEPTION WITH RESUME;
--- crea indici 
      drop index informix.i_s_artr_1 ;
      drop index informix.i_s_artr_2 ;
      drop index informix.i_s_artr_3 ;
      create index informix.i_s_artr_1 on informix.s_artr_n (id_meca);
      create index informix.i_s_artr_2 on informix.s_artr_n (data_lav_fin);
      create unique index informix.i_s_artr_3 on informix.s_artr_n (id_armo, data_lav_fin);
   END
   if sqlcode != 0 then
      let k_status = '(u_m2000_6_s_artr)  Errore in  create index  sqlcode' || sqlcode;
      goto FORZA_FINE;
   end if   
   
   
   goto OK;

<<FORZA_FINE>>
   BEGIN
      ON EXCEPTION END EXCEPTION WITH RESUME;
      rollback;
   END
   goto FINE;

<<OK>>
   BEGIN
      ON EXCEPTION END EXCEPTION WITH RESUME;
      commit work;
   END
   let k_status = 'Ok caricati ' || K_CONTA_TOT_REC || ' record in tab S_ARTR_N' ;

<<FINE>>
   --trace off;

return K_STATUS ;

end function
;
                               
---------------------------------------------------------------
--- Tabella Fatturazione
---------------------------------------------------------------
--CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
DROP FUNCTION u_m2000_7_cr_tab_s_arfa();
CREATE FUNCTION u_m2000_7_cr_tab_s_arfa()
  RETURNING VARCHAR(100);

  
   define k_status varchar(100);
     
   --set debug file to '.\m2000_nt.trace.txt';
   --trace on;
     
   --whenever error continue;
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
   --lock table informix.s_meca_n in exclusive mode; 
      drop view informix.s_arfa;
      drop table informix.s_arfa_n;
   END

   --begin work;

--- solo per INFORMIX 12.10
--create table informix.s_arfa as select * from informix.s_arfa_p;

--- x informix vecchi
   create table informix.s_arfa_n
       (
        id_meca         integer,
        magazzino       integer,
        num_fatt        integer,
        data_fatt       date,
        num_int         integer,
        data_int        date,
        num_bolla_out   integer,
        data_bolla_out  date,
        gruppo          decimal(3,0),
        dose            decimal(7,2),
        colli           decimal(09,0),
        cub_tot         decimal(12,2),
        giri_f1_pl      integer,
        giri_f1_lav     integer,
        giri_f2_pl      integer,
        giri_f2_lav     integer,
        prezzo_t        decimal(15,2),
        clie_1          integer,
        clie_2          integer,
        clie_3          integer,
        tipo_doc        char(2)
       );
   if sqlcode < 0 then
      let k_status = '(u_m2000_7_cr_tab_s_arfa)  Errore in  create table informix.s_arfa_n  sqlcode' || sqlcode;
      BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
         rollback;
      END
      goto FORZA_FINE;
   end if

   --INSERT INTO informix.s_arfa SELECT * FROM informix.s_arfa_p;


   CREATE VIEW informix.s_arfa AS 
      SELECT * 
         FROM informix.s_arfa_n;
--      union all
--      SELECT * 
--         FROM informix.s_arfa_p;

   if sqlcode < 0 then
      let k_status = '(u_m2000_7_cr_tab_s_arfa)  Errore in  CREATE VIEW informix.s_arfa_n sqlcode' || sqlcode;
      BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
         rollback;
      END
      goto FORZA_FINE;
   end if


   revoke all on informix.s_arfa_n from public;
   grant all on "informix".s_arfa_n to "ixuser" as "informix";
   revoke all on informix.s_arfa from public;
   grant all on "informix".s_arfa to "ixuser" as "informix";


    goto OK;

<<FORZA_FINE>>
   --rollback;
   goto FINE;

<<OK>>
   --commit;
   let k_status = 'Ok operazione conclusa, create Table s_arfa_n e View  s_arfa' ;

<<FINE>>
   --trace off;

return K_STATUS ;



---- ARCHIVIO DI SERVIZIO PER GLI STATISTICI * USCITE *
---- Dose     Dose
---- Gruppo   Gruppo articoli
---- Colli    Colli fatturati
---- Cub_tot  M_Cubi effettivamente accupati dall'impianto (come sped cli)
---- Clie_1   Mandante della merce
---- Clie_2   Cliente a cui ho spedito
---- Clie_3   Cliente di fatturazione
---- Prezzo_t Prezzo Totale
---- Tipo_doc Tipo del documento
-------------------------------------------------------------------------------------------------


end function
; 
								   
                                    
------------------------------- CARICA DATI TRATTAMENTO (ARTR)  ---------------------------------
--CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
DROP FUNCTION u_m2000_8_s_arfa();
CREATE FUNCTION u_m2000_8_s_arfa()
  RETURNING VARCHAR(100);

  
   define k_status varchar(100);
   define K_DATA_LIMITE date;
   define K_CONTA_REC, K_CONTA_TOT_REC integer;

   define K_ARFA_MAGAZZINO        like S_ARFA.MAGAZZINO;
   define K_ARFA_DOSE             like S_ARFA.DOSE;
   define K_ARFA_PREZZO_T         like S_ARFA.PREZZO_T;
   define K_ARFA_COLLI            like S_ARFA.COLLI;
   define K_ARFA_CUB_TOT          like S_ARFA.CUB_TOT;
   define K_ARFA_ID_MECA          like ARMO.ID_MECA;     
   define K_ARFA_NUM_INT          like S_ARFA.NUM_INT;
   define K_ARFA_DATA_INT         like S_ARFA.DATA_INT;
   define K_ARFA_NUM_BOLLA_OUT    like S_ARFA.NUM_BOLLA_OUT;
   define K_ARFA_DATA_BOLLA_OUT   like S_ARFA.DATA_BOLLA_OUT;
   define K_ARFA_NUM_FATT         like S_ARFA.NUM_FATT;
   define K_ARFA_DATA_FATT        like S_ARFA.DATA_FATT;
   define K_ARFA_CLIE_1           like S_ARFA.CLIE_1;
   define K_ARFA_CLIE_2           like S_ARFA.CLIE_2;
   define K_ARFA_CLIE_3           like S_ARFA.CLIE_3;
   define K_ARFA_TIPO_DOC         like S_ARFA.TIPO_DOC;
   define K_ARFA_GRUPPO           like S_ARFA.GRUPPO;

   define K_BARCODE_giri_f1_pl      integer;
   define K_BARCODE_giri_f1_lav     integer;
   define K_BARCODE_giri_f2_pl      integer;
   define K_BARCODE_giri_f2_lav     integer;

   begin work;
--- imposta il tipo di ISOLATION al piu' flessibile, ovvero se incontra righe appena inserite/aggiornate piglia le righe ancora non committed         
   SET ISOLATION TO DIRTY READ;

   let K_CONTA_TOT_REC = 0;
   let K_CONTA_REC = 0;
----------------------------------------------------------------------------------------
-- DATA LIMITE FINO DA CUI ESTRARRE 
   select max(data_int) 
        into K_DATA_LIMITE
        from s_armo_p;
   if sqlcode <> 0 then
      let k_status = '(u_m2000_8_s_arfa)  Errore in select max(data_int)  x K_DATA_LIMITE  sqlcode' || sqlcode;
      goto FORZA_FINE;
   end if
----------------------------------------------------------------------------------------

   foreach C_M_ESTR_S_ARFA with hold for
      select
                 ARMO.MAGAZZINO,
                 ARMO.DOSE,
                 SUM(ARFA.PREZZO_T),
                 sum(ARFA.COLLI) COLLI,
                 sum(ARMO.M_CUBI / ARMO.COLLI_2 * ARFA.COLLI)  CUB_TOT,
                 ARMO.ID_MECA,
                 ARMO.NUM_INT,
                 ARMO.DATA_INT,
                 ARFA.NUM_BOLLA_OUT,
                 ARFA.DATA_BOLLA_OUT,
                 ARFA.NUM_FATT,
                 ARFA.DATA_FATT,
                 MECA.CLIE_1,
                 MECA.CLIE_2,
                 ARFA.CLIE_3,
                 ARFA.TIPO_DOC,
                 PRODOTTI.GRUPPO
             into 
               K_ARFA_MAGAZZINO        
               ,K_ARFA_DOSE            
               ,K_ARFA_PREZZO_T        
               ,K_ARFA_COLLI           
               ,K_ARFA_CUB_TOT         
               ,K_ARFA_ID_MECA         
               ,K_ARFA_NUM_INT         
               ,K_ARFA_DATA_INT        
               ,K_ARFA_NUM_BOLLA_OUT   
               ,K_ARFA_DATA_BOLLA_OUT  
               ,K_ARFA_NUM_FATT        
               ,K_ARFA_DATA_FATT       
               ,K_ARFA_CLIE_1          
               ,K_ARFA_CLIE_2          
               ,K_ARFA_CLIE_3          
               ,K_ARFA_TIPO_DOC        
               ,K_ARFA_GRUPPO          
             from  ARMO, outer ARFA, outer PRODOTTI, outer MECA
             where
                   ARMO.ID_ARMO        = ARFA.ID_ARMO  and
                   ARMO.NUM_INT        = MECA.NUM_INT  and
                   ARMO.DATA_INT       = MECA.DATA_INT and
                   ARFA.COLLI          > 0             and
                   ARMO.ART            = PRODOTTI.CODICE
                   and ARMO.COLLI_2 > 0
                   AND ARFA.DATA_FATT > K_DATA_LIMITE
             group by 1, 2,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17
             order by ARMO.ID_MECA
   
   
      select sum(FILA_1 + FILA_1P)
             ,sum(FILA_2 + FILA_2P)
             ,sum(lav_FILA_1 + lav_FILA_1P)
             ,sum(lav_FILA_2 + lav_FILA_2P)
         into K_BARCODE_giri_f1_pl
             ,K_BARCODE_giri_f2_pl
             ,K_BARCODE_giri_f1_lav
             ,K_BARCODE_giri_f2_lav
         from barcode
         where barcode.id_meca = K_arfa_ID_MECA;
      if sqlcode < 0 then
         let k_status = '(u_m2000_8_s_arfa)  Errore in select sum(FILA_1 + FILA_1P) da barcode sqlcode' || sqlcode;
         goto FORZA_FINE;
      end if
  

      if K_arfa_PREZZO_T is NULL then
         let K_arfa_PREZZO_T = 0;
      end if
   
      insert into s_arfa_n
               (
                MAGAZZINO,
                DOSE,
                PREZZO_T,
                COLLI,
                CUB_TOT,
                ID_MECA,
                NUM_INT,
                DATA_INT,
                NUM_BOLLA_OUT,
                DATA_BOLLA_OUT,
                NUM_FATT,
                DATA_FATT,
                CLIE_1,
                CLIE_2,
                CLIE_3,
                TIPO_DOC,
                GRUPPO
               ,giri_f1_pl                
               ,giri_f2_pl
               ,giri_f1_lav
               ,giri_f2_lav
               )
             values
               (
                K_arfa_MAGAZZINO
                ,K_arfa_DOSE     
                ,K_arfa_PREZZO_T 
                ,K_arfa_COLLI    
                ,K_arfa_CUB_TOT  
                ,K_arfa_ID_MECA           
                ,K_arfa_NUM_INT         
                ,K_arfa_DATA_INT        
                ,K_arfa_NUM_BOLLA_OUT   
                ,K_arfa_DATA_BOLLA_OUT  
                ,K_arfa_NUM_FATT        
                ,K_arfa_DATA_FATT       
                ,K_arfa_CLIE_1          
                ,K_arfa_CLIE_2          
                ,K_arfa_CLIE_3          
                ,K_arfa_TIPO_DOC        
                ,K_arfa_GRUPPO          
                ,K_BARCODE_giri_f1_pl                
                ,K_BARCODE_giri_f2_pl
                ,K_BARCODE_giri_f1_lav
                ,K_BARCODE_giri_f2_lav 
               );
      if sqlcode < 0 then
         let k_status = '(u_m2000_8_s_arfa)  Errore in insert into s_arfa_n sqlcode' || sqlcode;
         goto FORZA_FINE;
      end if
      
      let K_CONTA_TOT_REC = K_CONTA_TOT_REC + 1;
--- Per evitare che si riempa il log forza la commit ogni tot records      
      let K_CONTA_REC = K_CONTA_REC + 1;
      if K_CONTA_REC > 1000 then
         let K_CONTA_REC = 0;
         commit work;
         begin work;
--- imposta il tipo di ISOLATION al piu' flessibile, ovvero se incontra tab con Insert piglia le righe ancora non committed         
         SET ISOLATION TO DIRTY READ;
      end if
                  
   end foreach
   
   if sqlcode < 0 then
      let k_status = '(u_m2000_8_s_arfa)  Errore in  foreach C_M_ESTR_S_ARFA  sqlcode' || sqlcode;
      goto FORZA_FINE;
   end if
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
      commit;
   END
   
{Carica archivio fatture con i NO DOSE }
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
      begin work;
   END
   insert into s_arfa_n
               (
                MAGAZZINO,
                DOSE,
                PREZZO_T,
                COLLI,
                CUB_TOT,
                ID_MECA,
                NUM_INT,
                DATA_INT,
                NUM_BOLLA_OUT,
                DATA_BOLLA_OUT,
                NUM_FATT,
                DATA_FATT,
                CLIE_1,
                CLIE_2,
                CLIE_3,
                TIPO_DOC,
                GRUPPO
               ,giri_f1_pl                
               ,giri_f2_pl
               ,giri_f1_lav
               ,giri_f2_lav
               )
      select
                  0,
                  0,
                  sum(ARFA_V.PREZZO_T),
                  sum(ARFA_V.COLLI) COLLI,
                  0,
                  0,
                  0,
                  date(0),
                  0,
                  date(0),
                  ARFA_V.NUM_FATT,
                  ARFA_V.DATA_FATT,
                  0,
                  0,
                  ARFA_V.CLIE_3,
                  ARFA_V.TIPO_DOC,
                  PRODOTTI.GRUPPO,
                  0,
                  0,
                  0,
                  0 
            from ARFA_V, outer PRODOTTI
            where
                  ARFA_V.PREZZO_T  <> 0  
                  AND ARFA_V.ART = PRODOTTI.CODICE
                  AND ARFA_V.DATA_FATT > K_DATA_LIMITE
            group by 1, 2, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21
            order by PRODOTTI.GRUPPO;
   
   if sqlcode < 0 then
      let k_status = '(u_m2000_8_s_arfa)  Errore in  insert into s_arfa_n  NO DOSE  sqlcode' || sqlcode;
      goto FORZA_FINE;
   end if

--- Crea gli indici della Tabella ---------------------------------------------------------------------------------------------------------------------------------

--- Durante la cancellazione degli Indici non importano le segnalazioni
   --whenever error continue
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
      commit work;
   END
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
--- crea indici 
      drop index informix.i_s_arfa_0 ;
      drop index informix.i_s_arfa_1 ;
      drop index informix.i_s_arfa_2 ;
      drop index informix.i_s_arfa_3 ;
      drop index informix.i_s_arfa_4 ;
      create index informix.i_s_arfa_0 on informix.s_arfa_n (id_meca);
      create index informix.i_s_arfa_1 on informix.s_arfa_n (data_fatt desc, num_fatt desc, dose, clie_3);
      create index informix.i_s_arfa_2 on informix.s_arfa_n (clie_3, data_int);
      create index informix.i_s_arfa_3 on informix.s_arfa_n (data_int desc, num_int);
      create index informix.i_s_arfa_4 on informix.s_arfa_n (id_meca desc, dose);
    END

   if sqlcode != 0 then
      let k_status = '(u_m2000_8_s_arfa)  Errore in  create index  sqlcode' || sqlcode;
      goto FORZA_FINE;
   end if   
   
   goto OK;

<<FORZA_FINE>>
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
      rollback;
   END
   goto FINE;

<<OK>>
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
      commit work;
   END
   let k_status = 'Ok caricati ' || K_CONTA_TOT_REC || ' record in tab S_ARFA_N' ;

<<FINE>>
   --trace off;
   return K_STATUS ;

end function
;
                            
  
   
---------------------------------------------------------------
--- Tabella Spedizione
---------------------------------------------------------------
--CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
DROP FUNCTION u_m2000_9_cr_tab_s_arsp();
CREATE FUNCTION u_m2000_9_cr_tab_s_arsp()
  RETURNING VARCHAR(100);

  
   define k_status varchar(100);
     
   --set debug file to '.\m2000_nt.trace.txt';
   --trace on;
     
   --whenever error continue;
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
   --lock table informix.s_meca_n in exclusive mode; 
      drop view informix.s_arsp;
      drop table informix.s_arsp_n;
   END

   
--- solo per INFORMIX 12.10
--create table informix.s_arsp_n as select * from informix.s_arsp_p;

--- x informix vecchi
   create table informix.s_arsp_n
       (
        id_meca         integer,
        id_armo         integer,
        id_sped         integer,
        magazzino       integer,
        num_int         integer,
        data_int        date,
        num_bolla_out   integer,
        data_bolla_out  date,
        data_rit        date,
        gruppo          decimal(3,0),
        dose            decimal(7,2),
        colli           decimal(09,0),
        cub_tot         decimal(12,2),
        giri_f1_pl      integer,
        giri_f1_lav     integer,
        giri_f2_pl      integer,
        giri_f2_lav     integer,
        clie_1          integer,
        clie_2          integer,
        clie_3          integer
       );
   if sqlcode < 0 then
      let k_status = '(u_m2000_9_cr_tab_s_arsp)  Errore in  create table informix.s_arsp_n  sqlcode' || sqlcode;
      BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
         rollback;
      END
      goto FORZA_FINE;
   end if

   --INSERT INTO informix.s_arsp SELECT * FROM informix.s_arsp_p;


   CREATE VIEW informix.s_arsp AS 
      SELECT * 
         FROM informix.s_arsp_n;
--      union all
--      SELECT * 
--         FROM informix.s_arsp_p;

   if sqlcode < 0 then
      let k_status = '(u_m2000_9_cr_tab_s_arsp)  Errore in  CREATE VIEW informix.s_arsp  sqlcode' || sqlcode;
      BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
         rollback;
      END
      goto FORZA_FINE;
   end if

   revoke all on informix.s_arsp_n from public;
   grant all on "informix".s_arsp_n to "ixuser" as "informix";
   revoke all on informix.s_arsp from public;
   grant all on "informix".s_arsp to "ixuser" as "informix";


    goto OK;

<<FORZA_FINE>>
   --rollback;
   goto FINE;

<<OK>>
   --commit;
   let k_status = 'Ok operazione conclusa, create Table s_arsp_n e View  s_arsp' ;

<<FINE>>
   --trace off;

return K_STATUS ;


end function
;
------------------------------- CARICA DATI  DI SPEDIZIONE (ARSP)  ---------------------------------
--CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
DROP FUNCTION u_m2000_10_s_arsp();
CREATE FUNCTION u_m2000_10_s_arsp()
  RETURNING VARCHAR(100);

  
   define k_status varchar(100);
   define K_DATA_LIMITE    date;
   define K_CONTA_REC, K_CONTA_TOT_REC integer;
   --define k_data_elab      date;
   
   define K_SPED_MAGAZZINO      like ARMO.MAGAZZINO;
   define K_SPED_DOSE           like ARMO.DOSE;
   define K_SPED_COLLI          like ARMO.COLLI_2;
   define K_SPED_CUB_TOT        decimal(12,2);
   define K_SPED_ID_MECA        like ARMO.ID_MECA;
   define K_SPED_ID_ARMO        like ARMO.ID_ARMO;
   define K_SPED_NUM_INT        like ARMO.NUM_INT;
   define K_SPED_DATA_INT       like ARMO.DATA_INT;
   define K_SPED_NUM_BOLLA_OUT  like ARSP.NUM_BOLLA_OUT;
   define K_SPED_DATA_BOLLA_OUT like ARSP.DATA_BOLLA_OUT;
   define K_SPED_ID_SPED      like ARSP.ID_SPED;
   define K_SPED_DATA_RIT       like SPED.DATA_RIT;
   define K_SPED_CLIE_1         like MECA.CLIE_1;
   define K_SPED_CLIE_2         like MECA.CLIE_2;
   define K_SPED_CLIE_3         like MECA.CLIE_3;
   define K_SPED_GRUPPO         like GRU.CODICE;
     
  define K_BARCODE_giri_f1_pl      integer;
  define K_BARCODE_giri_f1_lav     integer;
  define K_BARCODE_giri_f2_pl      integer;
  define K_BARCODE_giri_f2_lav     integer;
 
   begin work;
--- imposta il tipo di ISOLATION al piu' flessibile, ovvero se incontra righe appena inserite/aggiornate piglia le righe ancora non committed         
   SET ISOLATION TO DIRTY READ;

   let K_CONTA_TOT_REC = 0;
   let K_CONTA_REC = 0;
----------------------------------------------------------------------------------------
-- DATA LIMITE FINO DA CUI ESTRARRE 
   select max(data_int) 
        into K_DATA_LIMITE
        from s_armo_p;
   if sqlcode <> 0 then
      let k_status = '(u_m2000_10_s_arsp)  Errore in select max(data_int)  x K_DATA_LIMITE  sqlcode' || sqlcode;
      goto FORZA_FINE;
   end if
----------------------------------------------------------------------------------------
     
             

   --let k_data_elab = mdy(01,01, year(today) - 4)      


   foreach C_M_ESTR_S_SPED with hold for
      select
                 ARMO.MAGAZZINO,
                 ARMO.DOSE,
                 sum(ARSP.COLLI) COLLI,
                 ARMO.M_CUBI / ARMO.COLLI_2  CUB_TOT,
                 ARMO.ID_MECA,
                 ARSP.ID_ARMO,
                 ARMO.NUM_INT,
                 ARMO.DATA_INT,
                 ARSP.NUM_BOLLA_OUT,
                 ARSP.DATA_BOLLA_OUT,
                 ARSP.ID_SPED,
                 SPED.DATA_RIT,
                 MECA.CLIE_1,
                 SPED.CLIE_2,
                 SPED.CLIE_3,
                 PRODOTTI.GRUPPO
            into  
                    K_SPED_MAGAZZINO,
                    K_SPED_DOSE,
                    K_SPED_COLLI,
                    K_SPED_CUB_TOT,
                    K_SPED_ID_MECA,
                    K_SPED_ID_ARMO,
                    K_SPED_NUM_INT,
                    K_SPED_DATA_INT,
                    K_SPED_NUM_BOLLA_OUT,
                    K_SPED_DATA_BOLLA_OUT,
                    K_SPED_ID_SPED,
                    K_SPED_DATA_RIT,
                    K_SPED_CLIE_1,
                    K_SPED_CLIE_2,
                    K_SPED_CLIE_3,
                    K_SPED_GRUPPO
             from  SPED, outer (ARSP, outer (ARMO, outer (PRODOTTI, MECA)))
             where
                   SPED.NUM_BOLLA_OUT  = ARSP.NUM_BOLLA_OUT  
                   and SPED.DATA_BOLLA_OUT = ARSP.DATA_BOLLA_OUT
                   and ARSP.ID_ARMO        = ARMO.ID_ARMO 
                   and ARSP.COLLI          > 0             
                   and ARMO.COLLI_2        > 0
                   and ARMO.NUM_INT        = MECA.NUM_INT  
                   and ARMO.DATA_INT       = MECA.DATA_INT 
                   and ARMO.ART            = PRODOTTI.CODICE
                   AND SPED.DATA_BOLLA_OUT > K_DATA_LIMITE
             group by 1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
             order by ARMO.ID_MECA,
                      ARSP.ID_ARMO

                              
      select sum(FILA_1 + FILA_1P)
             ,sum(FILA_2 + FILA_2P)
             ,sum(lav_FILA_1 + lav_FILA_1P)
             ,sum(lav_FILA_2 + lav_FILA_2P)
         into K_BARCODE_giri_f1_pl
             ,K_BARCODE_giri_f2_pl
             ,K_BARCODE_giri_f1_lav
             ,K_BARCODE_giri_f2_lav
         from barcode
         where barcode.id_armo = K_SPED_ID_armo;
      if sqlcode < 0 then
         let k_status = '(u_m2000_8_s_arfa)  Errore in select sum(FILA_1 + FILA_1P) da barcode sqlcode' || sqlcode;
         goto FORZA_FINE;
      end if

      if K_SPED_CUB_TOT is NULL then
         let K_SPED_CUB_TOT = 0;
      end if
      let K_SPED_CUB_TOT = K_SPED_CUB_TOT * K_SPED_COLLI;
   
      insert into s_arsp_n
               (
                 MAGAZZINO       
                ,DOSE            
                ,COLLI           
                ,CUB_TOT         
                ,ID_MECA         
                ,ID_ARMO         
                ,NUM_INT         
                ,DATA_INT        
                ,NUM_BOLLA_OUT   
                ,DATA_BOLLA_OUT  
                ,ID_SPED  
                ,DATA_RIT  
                ,CLIE_1       
                ,CLIE_2       
                ,CLIE_3       
                ,GRUPPO       
                ,giri_f1_pl                
                ,giri_f2_pl
                ,giri_f1_lav
                ,giri_f2_lav               
               )
             values
               (
                K_SPED_MAGAZZINO       
                ,K_SPED_DOSE           
                ,K_SPED_COLLI          
                ,K_SPED_CUB_TOT        
                ,K_SPED_ID_MECA        
                ,K_SPED_ID_ARMO        
                ,K_SPED_NUM_INT        
                ,K_SPED_DATA_INT       
                ,K_SPED_NUM_BOLLA_OUT  
                ,K_SPED_DATA_BOLLA_OUT 
                ,K_SPED_ID_SPED
                ,K_SPED_DATA_RIT 
                ,K_SPED_CLIE_1         
                ,K_SPED_CLIE_2         
                ,K_SPED_CLIE_3         
                ,K_SPED_GRUPPO         
                ,K_BARCODE_giri_f1_pl                
                ,K_BARCODE_giri_f2_pl
                ,K_BARCODE_giri_f1_lav
                ,K_BARCODE_giri_f2_lav               
               );
      if sqlcode < 0 then
         let k_status = '(u_m2000_8_s_arfa)  Errore in insert into s_arsp sqlcode' || sqlcode;
         goto FORZA_FINE;
      end if

      let K_CONTA_TOT_REC = K_CONTA_TOT_REC + 1;
--- Per evitare che si riempa il log forza la commit ogni tot records      
      let K_CONTA_REC = K_CONTA_REC + 1;
      if K_CONTA_REC > 1000 then
         let K_CONTA_REC = 0;
         commit work;
         begin work;
--- imposta il tipo di ISOLATION al piu' flessibile, ovvero se incontra tab con Insert piglia le righe ancora non committed         
         SET ISOLATION TO DIRTY READ;
      end if
                  
   end foreach

   
   if sqlcode < 0 then
      let k_status = '(u_m2000_8_s_arfa)  Errore in  foreach C_M_ESTR_S_SPED  sqlcode' || sqlcode;
      goto FORZA_FINE;
   end if


 --- Crea gli indici della Tabella ---------------------------------------------------------------------------------------------------------------------------------

--- Durante la cancellazione degli Indici non importano le segnalazioni
   --whenever error continue
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
      commit work;
   END
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
      drop index informix.i_s_arsp_1 ;
      drop index informix.i_s_arsp_2 ;
      drop index informix.i_s_arsp_3 ;
      drop index informix.i_s_arsp_4 ;
      drop index informix.i_s_arsp_5 ;
      drop index informix.i_s_arsp_6 ;

      create unique index informix.i_s_arsp_1 on informix.s_arsp_n (id_meca, id_armo, NUM_BOLLA_OUT);
      create unique index informix.i_s_arsp_2 on informix.s_arsp_n (id_armo, NUM_BOLLA_OUT);
      create index informix.i_s_arsp_3 on informix.s_arsp_n (num_bolla_out, data_bolla_out);
      create index informix.i_s_arsp_4 on informix.s_arsp_n (id_meca, id_armo, num_bolla_out, data_bolla_out);
      create unique index informix.i_s_arsp_5 on informix.s_arsp_n (id_sped, id_armo);
      create index informix.i_s_arsp_6 on informix.s_arsp_n (id_meca, dose);
   
    END

   if sqlcode != 0 then
      let k_status = '(u_m2000_8_s_arfa)  Errore in  create index  sqlcode' || sqlcode;
      goto FORZA_FINE;
   end if   
   
   goto OK;

<<FORZA_FINE>>
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
      rollback;
   END
   goto FINE;

<<OK>>
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
      commit work;
   END
   let k_status = 'Ok caricati ' || K_CONTA_TOT_REC || ' record in tab S_ARSP_N' ;

<<FINE>>
   --trace off;
   return K_STATUS ;

end function
;
                            
   
   --CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
--CONNECT to 'gammarad@informix_at1' user 'informix' using 'infoxgamma';
drop function u_m2000_0_start_stat();
create function u_m2000_0_start_stat() 
      returning lvarchar(1000);

   define K_BASE_DATA_STAT like BASE.DATA_STAT;
   define K_BASE_ORA_STAT like BASE.ORA_STAT;
   define k_status lvarchar(1000);
   define k_rc varchar(100);
   define k_rc_tot lvarchar(1000);
   define k_datetime datetime hour to second;
   define k_id_step, k_appo integer;

   
   let k_rc_tot = '';
   let K_BASE_DATA_STAT   = today;
   let K_BASE_ORA_STAT    = 'IN ESEC.';
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;
            
-- STEP 1 --------------------------------------------------------------------------------------------   
   let k_datetime         = current;
   let k_id_step = 1;
   select id_step 
      into k_appo 
      from BASE_STAT
      where id_base = 'A'
            and id_step = k_id_step;
   if k_appo != k_id_step or k_appo is null then
      insert into BASE_STAT (
            id_base 
            ,id_step
            ,step_descr
            ,dataora_start
            ,dataora_end
            ,esito
            ,x_datins
            ,x_utente
         )
         values(
            'A'
            ,k_id_step
            ,'crea S_ARMO_N'
            ,k_datetime
            ,''
            ,'In esecuzione....'
            ,k_datetime
            ,'batch'         
         );
   --let k_status = 'DBG Insert BASE_STAT id_step: ' || k_id_step || ' sqlcode: ' || sqlcode;
   --goto FORZA_FINE;
   else
      if sqlcode >= 0 then
         update BASE_STAT
            set id_base = 'A'
               ,id_step = k_id_step
               ,step_descr = 'crea S_ARMO_N'
               ,dataora_start = k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = k_datetime
               ,x_utente = 'batch'
            where id_base = 'A'
               and id_step = k_id_step;
      else
         let k_status = 'Ko! Insert BASE_STAT id_step: ' || k_id_step;
         goto FORZA_FINE;
      end if
   end if

-- Step 1: crea S_ARMO_N            
   call u_m2000_1_cr_tab_s_armo() returning k_rc;
   if left(k_rc,2) = 'Ok' then
      let k_rc_tot = trim(substr(k_rc,3,97));
   end if
   let K_BASE_DATA_STAT   = today;
   --let k_datetime1 = sysdate;
   --let k_datetime1 = TO_DATE("2016-01-01 10:10:55","%Y-%m-%d %H:%M:%S"); 
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
-- Aggiorna BASE
   if left(k_rc,2) = 'Ok' then
      let k_rc_tot = k_rc_tot || ' ' || trim(substr(k_rc,3,97)); 
      let K_BASE_ORA_STAT = 'ese.2.10';
   else
      let K_BASE_ORA_STAT = 'Err.es.1';
   end if
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;
   update BASE_STAT
         set dataora_end = k_datetime
            ,esito = trim(k_rc)
            ,x_datins = k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;


-- STEP 2 --------------------------------------------------------------------------------------------   
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   let k_id_step = 2;
   select id_step 
      into k_appo 
      from BASE_STAT
      where id_base = 'A'
            and id_step = k_id_step;
   if k_appo != k_id_step or k_appo is null then
      insert into BASE_STAT  (
            id_base 
            ,id_step
            ,step_descr
            ,dataora_start
            ,dataora_end
            ,esito
            ,x_datins
            ,x_utente
         )
         values(
            'A'
            ,k_id_step
            ,'insert S_ARMO_N'
            ,k_datetime
            ,''
            ,'In esecuzione....'
            ,k_datetime
            ,'batch'         
         );
   else
      if sqlcode >= 0 then
         update BASE_STAT
            set id_base = 'A'
               ,id_step = k_id_step
               ,step_descr = 'insert S_ARMO_N'
               ,dataora_start = k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
      else
         let k_status = 'Ko! Insert BASE_STAT id_step: ' || k_id_step;
         goto FORZA_FINE;
      end if
   end if
   
-- Step 2: carica S_ARMO_N            
   if left(k_rc,2) = 'Ok' then
      call u_m2000_2_s_armo() returning k_rc;
   else
      goto FORZA_FINE;
   end if
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
   if left(k_rc,2) = 'Ok' then
      let K_BASE_ORA_STAT = 'ese.3.10';
   else
      let K_BASE_ORA_STAT = 'Err.es.2';
   end if
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;
   update BASE_STAT
         set dataora_end = k_datetime
            ,esito = trim(k_rc)
            ,x_datins = k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
            
-- STEP 3 --------------------------------------------------------------------------------------------   
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   let k_id_step = 3;
   select id_step 
      into k_appo 
      from BASE_STAT
      where id_base = 'A'
            and id_step = k_id_step;
   if k_appo != k_id_step or k_appo is null then
      insert into BASE_STAT  (
            id_base 
            ,id_step
            ,step_descr
            ,dataora_start
            ,dataora_end
            ,esito
            ,x_datins
            ,x_utente
         )
         values(
            'A'
            ,k_id_step
            ,'crea S_MECA_N'
            ,k_datetime
            ,''
            ,'In esecuzione....'
            ,k_datetime
            ,'batch'         
         );
   else
      if sqlcode >= 0 then
         update BASE_STAT
            set id_base = 'A'
               ,id_step = k_id_step
               ,step_descr = 'crea S_MECA_N'
               ,dataora_start = k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
      else
         let k_status = 'Ko! Insert BASE_STAT id_step: ' || k_id_step;
         goto FORZA_FINE;
      end if
   end if

-- Step 3: crea S_MECA_N            
   if left(k_rc,2) = 'Ok' then
      call u_m2000_3_cr_tab_s_meca () returning k_rc;
   else
      goto FORZA_FINE;
   end if
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
   if left(k_rc,2) = 'Ok' then
      let k_rc_tot = k_rc_tot || ' ' || trim(substr(k_rc,3,97)); 
      let K_BASE_ORA_STAT = 'ese.4.10';
   else
      let K_BASE_ORA_STAT = 'Err.es.3';
   end if
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;
   update BASE_STAT
         set dataora_end = k_datetime
            ,esito = trim(k_rc)
            ,x_datins = k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
            
-- STEP 4 --------------------------------------------------------------------------------------------   
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   let k_id_step = 4;
   select id_step 
      into k_appo 
      from BASE_STAT
      where id_base = 'A'
            and id_step = k_id_step;
   if k_appo != k_id_step or k_appo is null then
      insert into BASE_STAT  (
            id_base 
            ,id_step
            ,step_descr
            ,dataora_start
            ,dataora_end
            ,esito
            ,x_datins
            ,x_utente
         )
         values(
            'A'
            ,k_id_step
            ,'insert S_MECA_N'
            ,k_datetime
            ,''
            ,'In esecuzione....'
            ,k_datetime
            ,'batch'         
         );
   else
      if sqlcode >= 0 then
         update BASE_STAT
            set id_base = 'A'
               ,id_step = k_id_step
               ,step_descr = 'insert S_MECA_N'
               ,dataora_start = k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
      else
         let k_status = 'Ko! Insert BASE_STAT id_step: ' || k_id_step;
         goto FORZA_FINE;
      end if
   end if
-- Step 4: carica S_MECA_N            
   if left(k_rc,2) = 'Ok' then
      call u_m2000_4_s_meca () returning k_rc;
   else
      goto FORZA_FINE;
   end if
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
   if left(k_rc,2) = 'Ok' then
      let k_rc_tot = k_rc_tot || ' ' || trim(substr(k_rc,3,97)); 
      let K_BASE_ORA_STAT = 'ese.5.10';
   else
      let K_BASE_ORA_STAT = 'Err.es.4';
   end if
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;
   update BASE_STAT
         set dataora_end = k_datetime
            ,esito = trim(k_rc)
            ,x_datins = k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
            
-- STEP 5 --------------------------------------------------------------------------------------------   
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   let k_id_step = 5;
   select id_step 
      into k_appo 
      from BASE_STAT
      where id_base = 'A'
            and id_step = k_id_step;
   if k_appo != k_id_step or k_appo is null then
      insert into BASE_STAT  (
            id_base 
            ,id_step
            ,step_descr
            ,dataora_start
            ,dataora_end
            ,esito
            ,x_datins
            ,x_utente
         )
         values(
            'A'
            ,k_id_step
            ,'crea S_ARTR_N'
            ,k_datetime
            ,''
            ,'In esecuzione....'
            ,k_datetime
            ,'batch'         
         );
   else
      if sqlcode >= 0 then
         update BASE_STAT
            set id_base = 'A'
               ,id_step = k_id_step
               ,step_descr = 'crea S_ARTR_N'
               ,dataora_start = k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
      else
         let k_status = 'Ko! Insert BASE_STAT id_step: ' || k_id_step;
         goto FORZA_FINE;
      end if
   end if
-- Step 5: crea S_ARTR_N            
   if left(k_rc,2) = 'Ok' then
      call u_m2000_5_cr_tab_s_artr () returning k_rc;
   else
      goto FORZA_FINE;
   end if
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
   if left(k_rc,2) = 'Ok' then
      let k_rc_tot = k_rc_tot || ' ' || trim(substr(k_rc,3,97)); 
      let K_BASE_ORA_STAT = 'ese.6.10';
   else
      let K_BASE_ORA_STAT = 'Err.es.5';
   end if
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;
   update BASE_STAT
         set dataora_end = k_datetime
            ,esito = trim(k_rc)
            ,x_datins = k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
            
-- STEP 6 --------------------------------------------------------------------------------------------   
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   let k_id_step = 6;
   select id_step 
      into k_appo 
      from BASE_STAT
      where id_base = 'A'
            and id_step = k_id_step;
   if k_appo != k_id_step or k_appo is null then
      insert into BASE_STAT  (
            id_base 
            ,id_step
            ,step_descr
            ,dataora_start
            ,dataora_end
            ,esito
            ,x_datins
            ,x_utente
         )
         values(
            'A'
            ,k_id_step
            ,'insert S_ARTR_N'
            ,k_datetime
            ,''
            ,'In esecuzione....'
            ,k_datetime
            ,'batch'         
         );
   else
      if sqlcode >= 0 then
         update BASE_STAT
            set id_base = 'A'
               ,id_step = k_id_step
               ,step_descr = 'insert S_ARTR_N'
               ,dataora_start = k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
      else
         let k_status = 'Ko! Insert BASE_STAT id_step: ' || k_id_step;
         goto FORZA_FINE;
      end if
   end if
-- Step 6: carica S_ARTR_N            
   if left(k_rc,2) = 'Ok' then
      call u_m2000_6_s_artr() returning k_rc;
   else
      goto FORZA_FINE;
   end if
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
   if left(k_rc,2) = 'Ok' then
      let k_rc_tot = k_rc_tot || ' ' || trim(substr(k_rc,3,97)); 
      let K_BASE_ORA_STAT = 'ese.7.10';
   else
      let K_BASE_ORA_STAT = 'Err.es.6';
   end if
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;
   update BASE_STAT
         set dataora_end = k_datetime
            ,esito = trim(k_rc)
            ,x_datins = k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
            
-- STEP 7 --------------------------------------------------------------------------------------------   
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   let k_id_step = 7;
   select id_step 
      into k_appo 
      from BASE_STAT
      where id_base = 'A'
            and id_step = k_id_step;
   if k_appo != k_id_step or k_appo is null then
      insert into BASE_STAT  (
            id_base 
            ,id_step
            ,step_descr
            ,dataora_start
            ,dataora_end
            ,esito
            ,x_datins
            ,x_utente
         )
         values(
            'A'
            ,k_id_step
            ,'crea S_ARFA_N'
            ,k_datetime
            ,''
            ,'In esecuzione....'
            ,k_datetime
            ,'batch'         
         );
   else
      if sqlcode >= 0 then
         update BASE_STAT
            set id_base = 'A'
               ,id_step = k_id_step
               ,step_descr = 'crea S_ARFA_N'
               ,dataora_start = k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
      else
         let k_status = 'Ko! Insert BASE_STAT id_step: ' || k_id_step;
         goto FORZA_FINE;
      end if
   end if
-- Step 7: crea S_ARFA_N            
   if left(k_rc,2) = 'Ok' then
      call u_m2000_7_cr_tab_s_arfa() returning k_rc;
   else
      goto FORZA_FINE;
   end if
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
   if left(k_rc,2) = 'Ok' then
      let k_rc_tot = k_rc_tot || ' ' || trim(substr(k_rc,3,97)); 
      let K_BASE_ORA_STAT = 'ese.8.10';
   else
      let K_BASE_ORA_STAT = 'Err.es.7';
   end if
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;
   update BASE_STAT
         set dataora_end = k_datetime
            ,esito = trim(k_rc)
            ,x_datins = k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
            
-- STEP 8 --------------------------------------------------------------------------------------------   
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   let k_id_step = 8;
   select id_step 
      into k_appo 
      from BASE_STAT
      where id_base = 'A'
            and id_step = k_id_step;
   if k_appo != k_id_step or k_appo is null then
      insert into BASE_STAT  (
            id_base 
            ,id_step
            ,step_descr
            ,dataora_start
            ,dataora_end
            ,esito
            ,x_datins
            ,x_utente
         )
         values(
            'A'
            ,k_id_step
            ,'insert S_ARFA_N'
            ,k_datetime
            ,''
            ,'In esecuzione....'
            ,k_datetime
            ,'batch'         
         );
   else
      if sqlcode >= 0 then
         update BASE_STAT
            set id_base = 'A'
               ,id_step = k_id_step
               ,step_descr = 'insert S_ARFA_N'
               ,dataora_start = k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
      else
         let k_status = 'Ko! Insert BASE_STAT id_step: ' || k_id_step;
         goto FORZA_FINE;
      end if
   end if
-- Step 8: carica S_ARFA_N            
   if left(k_rc,2) = 'Ok' then
      call u_m2000_8_s_arfa() returning k_rc;
   else
      goto FORZA_FINE;
   end if
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
   if left(k_rc,2) = 'Ok' then
      let k_rc_tot = k_rc_tot || ' ' || trim(substr(k_rc,3,97)); 
      let K_BASE_ORA_STAT = 'ese.9.10';
   else
      let K_BASE_ORA_STAT = 'Err.es.8';
   end if
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;
   update BASE_STAT
         set dataora_end = k_datetime
            ,esito = trim(k_rc)
            ,x_datins = k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
            
-- STEP 9 --------------------------------------------------------------------------------------------   
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   let k_id_step = 9;
   select id_step 
      into k_appo 
      from BASE_STAT
      where id_base = 'A'
            and id_step = k_id_step;
   if k_appo != k_id_step or k_appo is null then
      insert into BASE_STAT  (
            id_base 
            ,id_step
            ,step_descr
            ,dataora_start
            ,dataora_end
            ,esito
            ,x_datins
            ,x_utente
         )
         values(
            'A'
            ,k_id_step
            ,'crea S_ARSP_N'
            ,k_datetime
            ,''
            ,'In esecuzione....'
            ,k_datetime
            ,'batch'         
         );
   else
      if sqlcode >= 0 then
         update BASE_STAT
            set id_base = 'A'
               ,id_step = k_id_step
               ,step_descr = 'crea S_ARSP_N'
               ,dataora_start = k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
      else
         let k_status = 'Ko! Insert BASE_STAT id_step: ' || k_id_step;
         goto FORZA_FINE;
      end if
   end if
-- Step 9: crea S_ARSP_N            
   if left(k_rc,2) = 'Ok' then
      call u_m2000_9_cr_tab_s_arsp() returning k_rc;
   else
      goto FORZA_FINE;
   end if
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
   if left(k_rc,2) = 'Ok' then
      let k_rc_tot = k_rc_tot || ' ' || trim(substr(k_rc,3,97)); 
      let K_BASE_ORA_STAT = '*es.10.10';
   else
      let K_BASE_ORA_STAT = 'Err.es.9';
   end if
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;
   update BASE_STAT
         set dataora_end = k_datetime
            ,esito = trim(k_rc)
            ,x_datins = k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;

            
-- STEP 10 --------------------------------------------------------------------------------------------   
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   let k_id_step = 10;
   select id_step 
      into k_appo 
      from BASE_STAT
      where id_base = 'A'
            and id_step = k_id_step;
   if k_appo != k_id_step or k_appo is null then
      insert into BASE_STAT  (
            id_base 
            ,id_step
            ,step_descr
            ,dataora_start
            ,dataora_end
            ,esito
            ,x_datins
            ,x_utente
         )
         values(
            'A'
            ,k_id_step
            ,'insert S_ARSP_N'
            ,k_datetime
            ,''
            ,'In esecuzione....'
            ,k_datetime
            ,'batch'         
         );
   else
      if sqlcode >= 0 then
         update BASE_STAT
            set id_base = 'A'
               ,id_step = k_id_step
               ,step_descr = 'insert S_ARSP_N'
               ,dataora_start = k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
      else
         let k_status = 'Ko! Insert BASE_STAT id_step: ' || k_id_step;
         goto FORZA_FINE;
      end if
   end if
-- Step 10: carica S_ARSP_N            
   if left(k_rc,2) = 'Ok' then
      call u_m2000_10_s_arsp() returning k_rc;
   else
      goto FORZA_FINE;
   end if
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   update BASE_STAT
         set dataora_end = k_datetime
            ,esito = trim(k_rc)
            ,x_datins = k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
   
-- Errore durante estrazione se != 0
   if left(k_rc,2) = 'Ok' then
      let k_rc_tot = k_rc_tot || ' ' || trim(substr(k_rc,3,97)); 
      let K_BASE_ORA_STAT = current hour to second;
      --let K_BASE_ORA_STAT = hour(today) || ':' || MINUTE(today);
   else
      let K_BASE_ORA_STAT = 'Errore*';
   end if
   let K_BASE_DATA_STAT   = today;
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;


            
   goto OK;

   
<<FORZA_FINE>>
   BEGIN 
      ON EXCEPTION END EXCEPTION WITH RESUME;
      rollback;
   END
   goto FINE;

<<OK>>
   BEGIN 
      ON EXCEPTION END EXCEPTION WITH RESUME;
      commit;
   END
   let k_status = 'Ok estrazione statistici terminata alle ' || K_BASE_ORA_STAT || ' del ' || to_char(K_BASE_DATA_STAT, '%d %B %Y') || ' id_step ' || k_id_step || ': ' || k_rc_tot; 


<<FINE>>
   --trace off;
               
               
   return K_STATUS ;


end function
;
               --CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
--CONNECT to 'gammarad@informix_at1' user 'informix' using 'infoxgamma';
grant  execute on function "informix".u_m2000_get_datetime () to "public" as "informix";
grant  execute on function "informix".u_m2000_wm_pklist_flag_sped () to "public" as "informix";
grant  execute on function "informix".u_m2000_chiudi_bolle () to "public" as "informix";
grant  execute on function "informix".u_m2000_1_cr_tab_s_armo () to "public" as "informix";
grant  execute on function "informix".u_m2000_3_cr_tab_s_meca () to "public" as "informix";
grant  execute on function "informix".u_m2000_4_s_meca () to "public" as "informix";
grant  execute on function "informix".u_m2000_5_cr_tab_s_artr () to "public" as "informix";
grant  execute on function "informix".u_m2000_7_cr_tab_s_arfa () to "public" as "informix";
grant  execute on function "informix".u_m2000_8_s_arfa () to "public" as "informix";
grant  execute on function "informix".u_m2000_9_cr_tab_s_arsp () to "public" as "informix";
grant  execute on function "informix".u_m2000_10_s_arsp () to "public" as "informix";
grant  execute on function "informix".u_m2000_0_start_stat () to "public" as "informix";

grant  execute on function "informix".u_m2000_update_stat () to "public" as "informix";
--grant  execute on function "informix".genidxstats () to "public" as "informix";
