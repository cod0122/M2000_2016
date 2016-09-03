------------------------------- CARICA DATI TRATTAMENTO (ARTR)  ---------------------------------
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

                            
  
   
