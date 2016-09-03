--CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
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
;