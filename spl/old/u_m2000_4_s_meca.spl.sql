------------------------------- CARICA ID-MECA - ID-ARMO ---------------------------------
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


