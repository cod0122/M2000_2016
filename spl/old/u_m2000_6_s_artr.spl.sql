------------------------------- CARICA DATI TRATTAMENTO (ARTR)  ---------------------------------
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

                               
