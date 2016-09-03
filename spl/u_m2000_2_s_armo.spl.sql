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

      create index informix.i_s_armo_n_0 on informix.s_armo_n (id_meca);
      create index informix.i_s_armo_n_1 on informix.s_armo_n (id_armo);
      create index informix.i_s_armo_n_2 on informix.s_armo_n (data_int desc, num_int);
      create index informix.i_s_armo_n_3 on informix.s_armo_n (clie_1, data_int);
      create index informix.i_s_armo_n_4 on informix.s_armo_n (clie_2, data_int);
      create index informix.i_s_armo_n_5 on informix.s_armo_n (clie_3, data_int);
   
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

                            
                               
                        
