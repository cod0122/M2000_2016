------------------------------- CARICA DATI  DI SPEDIZIONE (ARSP)  ---------------------------------
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

                            
   
   