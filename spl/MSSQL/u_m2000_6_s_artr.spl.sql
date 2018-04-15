------------------------------- CARICA DATI TRATTAMENTO (ARTR)  ---------------------------------
USE [sterigenics270P]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[u_m2000_6_s_artr] @k_status varchar(100) OUTPUT
as
BEGIN

  
--   declare @k_status varchar(100);
   declare @K_DATA_LIMITE date, @k_data_nuovo_grp date;
   declare @K_CONTA_REC integer, @K_CONTA_TOT_REC integer;
   --define k_data_elab          date;

   declare @k_ARMO_1_ID_ARMO integer; --varchar(1000)       /* like ARMO.ID_ARMO */;   
   declare @k_ARMO_1_DOSE decimal(6,2) --varchar(1000)          /* like ARMO.DOSE */;
   declare @k_ARMO_1_ART varchar(1000)           /* like ARMO.ART */;
   declare @k_ARMO_1_COLLI_2 smallint --varchar(1000)       /* like ARMO.COLLI_2 */;
   declare @k_ARMO_1_LARG_2 smallint --varchar(1000)        /* like ARMO.LARG_2 */;
   declare @k_ARMO_1_LUNG_2 smallint --varchar(1000)        /* like ARMO.LUNG_2 */;
   declare @k_ARMO_1_ALT_2 smallint --varchar(1000)         /* like ARMO.ALT_2 */;
   declare @k_ARMO_1_COLLI_FATT smallint --varchar(1000) /* like ARMO.COLLI_FATT */;
   declare @k_ARMO_1_PESO_KG decimal(8,2) --varchar(1000)       /* like ARMO.PESO_KG */;
   declare @k_ARMO_1_M_CUBI decimal(8,2)        /* like ARMO.M_CUBI */;
   declare @k_ARMO_1_PEDANE smallint --varchar(1000)        /* like ARMO.PEDANE */;
   declare @k_ARMO_1_ID_MECA integer --varchar(1000)       /* like ARMO.ID_MECA */;     
   declare @k_ARMO_1_CLIE_3 smallint --varchar(1000)        /* like S_ARMO.CLIE_3 */;      
   declare @k_ARMO_1_ID_LISTINO integer --varchar(1000)    /* like ARMO.ID_LISTINO */;
      
   declare @K_giri_f1_pl           integer;
   declare @K_giri_f1p_pl          integer;
   declare @K_giri_f2_pl           integer;
   declare @K_giri_f2p_pl          integer;
   declare @K_giri_f1_lav          integer;
   declare @K_giri_f1p_lav         integer;
   declare @K_giri_f2_lav          integer;
   declare @K_giri_f2p_lav         integer;
   declare @K_giri_f1_pl_gp        integer;
   declare @K_giri_f1p_pl_gp       integer;
   declare @K_giri_f2_pl_gp        integer;
   declare @K_giri_f2p_pl_gp       integer;
   declare @K_giri_f1_lav_gp       integer;
   declare @K_giri_f1p_lav_gp      integer;
   declare @K_giri_f2_lav_gp       integer;
   declare @K_giri_f2p_lav_gp      integer;
   declare @k_barcode_padre char(13) ;       /* like barcode.barcode */;
   declare @k_OCCUP_PED_calcolata smallint;  /* like LISTINO.OCCUP_PED */;
   declare @k_nr_padri             integer;
   declare @k_nr_figli             integer;
   declare @k_importo_giri         decimal(15,2);  
   declare @k_importo_giriF1       decimal(15,2); 
   declare @k_importo_giriF2       decimal(15,2);  
   declare @k_ctr                  integer;
   declare @K_NR_BARCODE_F1_PL     integer;
   declare @K_NR_BARCODE_F2_PL     integer;
   declare @K_NR_BARCODE_F1_LAV    integer;
   declare @K_NR_BARCODE_F2_LAV    integer;
   declare @K_NR_BARCODE_F1_PL_GP  integer;
   declare @K_NR_BARCODE_F2_PL_GP  integer;
   declare @K_NR_BARCODE_F1_LAV_GP integer;
   declare @K_NR_BARCODE_F2_LAV_GP integer;
      
   declare @K_BARCODE_giri_fn_lav     integer; 
   declare @K_BARCODE_giri_f1_pl      integer;
   declare @K_BARCODE_giri_f1_lav     integer;
   declare @K_BARCODE_giri_f2_pl      integer;
   declare @K_BARCODE_giri_f2_lav     integer;
   declare @K_BARCODE_giri_f1_pl_gp   integer;
   declare @K_BARCODE_giri_f1_lav_gp  integer;
   declare @K_BARCODE_giri_f2_pl_gp   integer;
   declare @K_BARCODE_giri_f2_lav_gp  integer;
   declare @K_BARCODE_barcode_lav char(13)   /* like barcode.barcode_lav */;
 
   declare @K_arfa_colli        integer;
   declare @K_arfa_prezzo_u decimal(13,2)     /* like arfa.prezzo_u */;
   declare @K_arfa_prezzo_t decimal(13,2)     /* like arfa.prezzo_t */;

   declare @K_ARTR_COLLI smallint       /* like ARMO.COLLI_2 */;
   declare @K_ARTR_M_CUBI decimal(8,2)        /* like ARMO.M_CUBI */;
   declare @K_ARTR_PEDANE smallint        /* like ARMO.PEDANE */;
   declare @K_ARTR_DATA_lav_FIN date  /* like artr.data_fin */;
   declare @K_ARTR_imp_fatt      decimal(15,2);
   declare @K_ARTR_imp_da_fatt   decimal(15,2);
      
   declare @K_LISTINO_MAGAZZINO tinyint   /* like LISTINO.MAGAZZINO */;
   declare @K_LISTINO_PREZZO decimal(13,2)       /* like LISTINO.PREZZO */;
   declare @K_LISTINO_PREZZO_2 decimal(13,2)     /* like LISTINO.PREZZO */;
   declare @K_LISTINO_PREZZO_3 decimal(13,2)     /* like LISTINO.PREZZO */;
   declare @K_LISTINO_TIPO char(1)        /* like LISTINO.TIPO */;
   declare @K_LISTINO_CAMPIONE char(1)    /* like LISTINO.CAMPIONE */;
   declare @K_LISTINO_M_CUBI_F decimal(8,2)     /* like LISTINO.M_CUBI_F */;
   declare @K_LISTINO_OCCUP_PED smallint   /* like LISTINO.OCCUP_PED */;
      
--- DATA INIZIO ESTRAZIONE
   set @k_data_nuovo_grp = DATEADD(year,-10, getdate()) -- mdy(10,26, 2006);      
   
--   begin work;
--- imposta il tipo di ISOLATION al piu' flessibile, ovvero se incontra righe appena inserite/aggiornate piglia le righe ancora non committed         
   SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

   set @K_CONTA_TOT_REC = 0;
   set @K_CONTA_REC = 0;
----------------------------------------------------------------------------------------
-- DATA LIMITE FINO DA CUI ESTRARRE 
   select @K_DATA_LIMITE = max(data_int) 
        from s_armo_p;
   if @@ERROR <> 0 begin
      set @k_status = '(u_m2000_6_s_artr)  Errore in select max(data_int)  x K_DATA_LIMITE  sqlcode' + isnull(@@ERROR, '');
      goto FORZA_FINE;
   end
----------------------------------------------------------------------------------------

--- Lettura archivio TRATTAMENTI 
   declare C_M_ESTR_S_ARTR cursor for
      select
             ID_MECA,
             ID_ARMO,
             DATA_LAV_FIN,
             count(*)
        from  barcode
         where 
             BARCODE.DATA_INT > @K_DATA_LIMITE
         group by 
            ID_MECA,
            ID_ARMO,
            DATA_LAV_FIN
         order by 
            ID_MECA,
            ID_ARMO;
   open C_M_ESTR_S_ARTR;
   fetch C_M_ESTR_S_ARTR into @k_ARMO_1_ID_MECA, @k_ARMO_1_ID_ARMO, @K_ARTR_DATA_LAV_FIN, @K_ARTR_COLLI;
   while @@fetch_status = 0 begin
 
      set @K_NR_BARCODE_F1_PL = 0;
      set @K_NR_BARCODE_F2_PL = 0;
      set @K_NR_BARCODE_F1_LAV = 0;
      set @K_NR_BARCODE_F2_LAV = 0;
      set @K_NR_BARCODE_F1_PL_GP = 0;
      set @K_NR_BARCODE_F2_PL_GP = 0;
      set @K_NR_BARCODE_F1_LAV_GP = 0;
      set @K_NR_BARCODE_F2_LAV_GP = 0;
      
      set @K_BARCODE_giri_f1_pl = 0; 
      set @K_BARCODE_giri_f2_pl = 0; 
      set @K_BARCODE_giri_f1_lav = 0; 
      set @K_BARCODE_giri_f2_lav = 0; 
      set @K_BARCODE_giri_f1_pl_gp = 0; 
      set @K_BARCODE_giri_f2_pl_gp = 0; 
      set @K_BARCODE_giri_f1_lav_gp = 0; 
      set @K_BARCODE_giri_f2_lav_gp = 0; 
         
 
--------------------------------------------------------------------------------------------------------
--- Piglia i giri di lavorazione dal BARCODE poiche' solo qui c'e' la vera situazione di Lavorazione  
--- dal 26.10.2006 e' entrato in funzione il nuovo 'GROUPAGE' 
---      per riconoscere il groupage figlio e' necessario testare il barcode_lav (pres. del PADRE)
--- somma tutti i giri groupage e no        
--------------------------------------------------------------------------------------------------------
      declare C_M_ESTR_S_ARTR1 cursor for
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
         where barcode.id_armo = @k_ARMO_1_ID_ARMO 
               and data_lav_fin = @K_ARTR_DATA_lav_FIN
               and (groupage <> 'S' or groupage is null)
               and data_lav_fin <= @k_data_nuovo_grp 
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
         where barcode.id_armo = @k_ARMO_1_ID_ARMO 
               and data_lav_fin = @K_ARTR_DATA_lav_FIN
               and (barcode_lav = ' ' or barcode_lav is null)
               and data_lav_fin > @k_data_nuovo_grp 
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
         where barcode.id_armo = @k_ARMO_1_ID_ARMO 
               and data_lav_fin = @K_ARTR_DATA_lav_FIN
               and (groupage = 'S')
               and data_lav_fin <= @k_data_nuovo_grp 
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
         where barcode.id_armo = @k_ARMO_1_ID_ARMO 
               and data_lav_fin = @K_ARTR_DATA_lav_FIN
               and barcode_lav <> ' ' and barcode_lav is not null
               and data_lav_fin > @k_data_nuovo_grp;
      open C_M_ESTR_S_ARTR1;
      fetch C_M_ESTR_S_ARTR1 into 
			  @K_giri_f1_pl
			  , @K_giri_f1p_pl
			  , @K_giri_f2_pl
			  , @K_giri_f2p_pl
			  , @K_giri_f1_lav
			  , @K_giri_f1p_lav
			  , @K_giri_f2_lav
			  , @K_giri_f2p_lav
			  , @K_giri_f1_pl_gp
			  , @K_giri_f1p_pl_gp
			  , @K_giri_f2_pl_gp
			  , @K_giri_f2p_pl_gp
			  , @K_giri_f1_lav_gp
			  , @K_giri_f1p_lav_gp
			  , @K_giri_f2_lav_gp
			  , @K_giri_f2p_lav_gp;
      while @@fetch_status = 0 begin 

         if @K_giri_f1_pl is null begin set @K_giri_f1_pl = 0; end
         if @K_giri_f1p_pl is null begin set @K_giri_f1p_pl = 0; end
         if @K_giri_f2_pl is null begin set @K_giri_f2_pl = 0; end
         if @K_giri_f2p_pl is null begin set @K_giri_f2p_pl = 0; end
         if @K_giri_f1_lav is null begin set @K_giri_f1_lav = 0; end
         if @K_giri_f1p_lav is null begin set @K_giri_f1p_lav = 0; end
         if @K_giri_f2_lav is null begin set @K_giri_f2_lav = 0; end
         if @K_giri_f2p_lav is null begin set @K_giri_f2p_lav = 0; end

         if @K_giri_f1_pl_gp is null begin set @K_giri_f1_pl_gp = 0; end
         if @K_giri_f1p_pl_gp is null begin set @K_giri_f1p_pl_gp = 0; end
         if @K_giri_f2_pl_gp is null begin set @K_giri_f2_pl_gp = 0; end
         if @K_giri_f2p_pl_gp is null begin set @K_giri_f2p_pl_gp = 0; end
         if @K_giri_f1_lav_gp is null begin set @K_giri_f1_lav_gp = 0; end
         if @K_giri_f1p_lav_gp is null begin set @K_giri_f1p_lav_gp = 0; end
         if @K_giri_f2_lav_gp is null begin set @K_giri_f2_lav_gp = 0; end
         if @K_giri_f2p_lav_gp is null begin set @K_giri_f2p_lav_gp = 0; end

-- 131213 calcolo colli in fila 1 e fila 2
         if @K_giri_f1_pl > 0 begin set @K_NR_BARCODE_F1_PL = @K_NR_BARCODE_F1_PL + 1; end
         if @K_giri_f2_pl > 0 begin set @K_NR_BARCODE_F2_PL = @K_NR_BARCODE_F2_PL + 1; end
         if @K_giri_f1_lav > 0 begin set @K_NR_BARCODE_F1_LAV = @K_NR_BARCODE_F1_LAV + 1; end
         if @K_giri_f2_lav > 0 begin set @K_NR_BARCODE_F2_LAV = @K_NR_BARCODE_F2_LAV + 1; end
         if @K_giri_f1_pl_gp > 0 begin set @K_NR_BARCODE_F1_PL_GP = @K_NR_BARCODE_F1_PL_GP + 1; end
         if @K_giri_f2_pl_gp > 0 begin set @K_NR_BARCODE_F2_PL_GP = @K_NR_BARCODE_F2_PL_GP + 1; end
         if @K_giri_f1_lav_gp > 0 begin set @K_NR_BARCODE_F1_LAV_GP = @K_NR_BARCODE_F1_LAV_GP + 1; end
         if @K_giri_f2_lav_gp > 0 begin set @K_NR_BARCODE_F2_LAV_GP = @K_NR_BARCODE_F2_LAV_GP + 1; end
          

         set @K_BARCODE_giri_f1_pl = @K_BARCODE_giri_f1_pl + @K_giri_f1_pl + @K_giri_f1p_pl;
         set @K_BARCODE_giri_f2_pl = @K_BARCODE_giri_f2_pl + @K_giri_f2_pl + @K_giri_f2p_pl;
         set @K_BARCODE_giri_f1_lav = @K_BARCODE_giri_f1_lav + @K_giri_f1_lav + @K_giri_f1p_lav;
         set @K_BARCODE_giri_f2_lav = @K_BARCODE_giri_f2_lav + @K_giri_f2_lav + @K_giri_f2p_lav;
         set @K_BARCODE_giri_f1_pl_gp = @K_BARCODE_giri_f1_pl_gp + @K_giri_f1_pl_gp + @K_giri_f1p_pl_gp;
         set @K_BARCODE_giri_f2_pl_gp = @K_BARCODE_giri_f2_pl_gp + @K_giri_f2_pl_gp + @K_giri_f2p_pl_gp;
         set @K_BARCODE_giri_f1_lav_gp = @K_BARCODE_giri_f1_lav_gp + @K_giri_f1_lav_gp + @K_giri_f1p_lav_gp;
         set @K_BARCODE_giri_f2_lav_gp = @K_BARCODE_giri_f2_lav_gp + @K_giri_f2_lav_gp + @K_giri_f2p_lav_gp;
         
		fetch C_M_ESTR_S_ARTR1 into 
			  @K_giri_f1_pl
			  , @K_giri_f1p_pl
			  , @K_giri_f2_pl
			  , @K_giri_f2p_pl
			  , @K_giri_f1_lav
			  , @K_giri_f1p_lav
			  , @K_giri_f2_lav
			  , @K_giri_f2p_lav
			  , @K_giri_f1_pl_gp
			  , @K_giri_f1p_pl_gp
			  , @K_giri_f2_pl_gp
			  , @K_giri_f2p_pl_gp
			  , @K_giri_f1_lav_gp
			  , @K_giri_f1p_lav_gp
			  , @K_giri_f2_lav_gp
			  , @K_giri_f2p_lav_gp;     end
      close C_M_ESTR_S_ARTR1;
      deallocate C_M_ESTR_S_ARTR1;
      if @@ERROR < 0 begin
         set @k_status = '(u_m2000_6_s_artr)  Errore in foreach C_M_ESTR_S_ARTR1 sqlcode' + isnull(@@ERROR, '');
         goto FORZA_FINE;
      end
   
---------------------------------------------------------------------------------------------------------------------------------------
      if @K_ARTR_COLLI is null begin set @K_ARTR_colli = 0; end
         

--- Lettura archivio entrate per estrarre i singoli articoli
      --fetch C_M_ESTR_S_ARTR_0 with hold for
      select @k_ARMO_1_ID_LISTINO = ARMO.ID_LISTINO,
                 @k_ARMO_1_DOSE = ARMO.DOSE,
                 @k_ARMO_1_ART = ARMO.ART,
                 @k_ARMO_1_PESO_KG = ARMO.PESO_KG,
                 @k_ARMO_1_M_CUBI = ARMO.M_CUBI,
                 @k_ARMO_1_PEDANE = ARMO.PEDANE,
                 @k_ARMO_1_COLLI_2 = ARMO.COLLI_2,
                 @k_ARMO_1_LARG_2 = ARMO.LARG_2,
                 @k_ARMO_1_LUNG_2 = ARMO.LUNG_2,
                 @k_ARMO_1_ALT_2 = ARMO.ALT_2,
                 @k_ARMO_1_COLLI_FATT = ARMO.COLLI_FATT,
                 @k_ARMO_1_ID_MECA = MECA.ID,
                 @k_ARMO_1_CLIE_3 = MECA.CLIE_3
             from ARMO inner join MECA on meca.id = armo.id_meca
             where id_armo = @k_ARMO_1_ID_ARMO ; 

      set @K_arfa_prezzo_t = 0;
      set @K_arfa_colli = 0;
      set @K_ARTR_imp_fatt = 0;

--- Dati Fattura se ci sono....       
      select @K_arfa_prezzo_t = sum(prezzo_t), @K_arfa_colli = sum(colli)
         from arfa
         where arfa.id_armo = @k_ARMO_1_ID_ARMO;
      if @@ERROR < 0 begin
         set @k_status = '(u_m2000_6_s_artr)  Errore in select sum(prezzo_t), sum(colli)  sqlcode' + isnull(@@ERROR, '');
         goto FORZA_FINE;
      end

--- Ottengo il Prezzo Unitario x collo      
      if @@ERROR <> 0 or @K_arfa_colli is null or @K_arfa_colli = 0 begin 
         set @K_arfa_colli = 0; 
         set @K_arfa_prezzo_u = 0; 
      end
      else begin
         set @K_arfa_prezzo_u = (@K_arfa_prezzo_t / @K_arfa_colli);
      end 

--- Sistemazione 'grossolana' del campo COLLI_FATT 
      if @k_ARMO_1_COLLI_FATT is null begin 
         set @k_ARMO_1_colli_fatt  = 0; 
      end
      if @k_ARMO_1_COLLI_FATT > @k_ARMO_1_COLLI_2 begin 
         set @k_ARMO_1_colli_fatt  = @k_ARMO_1_COLLI_2;
      end
      
--- se no fattura calcolo prezzo unitario dal listino
      if @K_arfa_prezzo_u = 0 begin 
      
         select      @K_LISTINO_MAGAZZINO = LISTINO.MAGAZZINO,
                     @k_listino_PREZZO = LISTINO.PREZZO,
                     @k_listino_PREZZO_2 = LISTINO.PREZZO_2,
                     @k_listino_PREZZO_3 = LISTINO.PREZZO_3,
                     @k_listino_TIPO = LISTINO.TIPO,
                     @k_listino_CAMPIONE = LISTINO.CAMPIONE,
                     @k_listino_M_CUBI_F = LISTINO.M_CUBI_F,
                     @k_listino_OCCUP_PED = LISTINO.OCCUP_PED
            from LISTINO 
            where  
                  LISTINO.id =  @k_ARMO_1_ID_LISTINO ;
         if @@ERROR < 0 begin
            set @k_status = '(u_m2000_6_s_artr)  Errore in select LISTINO.MAGAZZINO, su LISTINO sqlcode' + isnull(@@ERROR, '');
            goto FORZA_FINE;
         end
                      
--- CALCOLO DEL PREZZO                 
         if @@ERROR = 0 begin

            if @K_LISTINO_OCCUP_PED is NULL begin
               set @k_listino_OCCUP_PED = 100;
            end
            if @K_LISTINO_PREZZO is NULL begin
               set @k_listino_PREZZO     = 0;
            end
            if @K_LISTINO_PREZZO_2 is NULL begin
               set @k_listino_PREZZO_2     = 0;
            end
            if @K_LISTINO_PREZZO_3 is NULL begin
               set @k_listino_PREZZO_3     = 0;
            end
--- prende il prezzo piu' alto (quello senza sconti)
            if @K_LISTINO_PREZZO_2 > @K_LISTINO_PREZZO begin
               set @k_listino_PREZZO = @K_LISTINO_PREZZO_2;
            end
            if @K_LISTINO_PREZZO_3 > @K_LISTINO_PREZZO begin
               set @k_listino_PREZZO = @K_LISTINO_PREZZO_3;
            end  

--- Calcolo i metri cubi per la fatturazione, che possono differire da quelli
--- reali se, impostati nel Listino
            if @K_LISTINO_M_CUBI_F > 0 begin
               set @k_ARMO_1_M_CUBI = @K_ARTR_COLLI * @K_LISTINO_M_CUBI_F;
            end

            --BEGIN
            --   ON EXCEPTION IN (1202)  --Divisione x ZERO
            --   set @k_status = '(u_m2000_6_s_artr)  Errore Divisione per ZERO-1 nel ID riga lotto: ' + ISNULL(@k_ARMO_1_ID_ARMO, ''); 
            --   BEGIN
            --      ON EXCEPTION END EXCEPTION WITH RESUME;
            --      rollback;
            --   END
            --   return @k_status;
            --END EXCEPTION
			set @K_arfa_prezzo_u =
				case @K_LISTINO_TIPO
					when 'C' then
						@K_LISTINO_PREZZO
					when 'P' then
						@K_LISTINO_PREZZO * (@k_ARMO_1_PESO_KG / @k_ARMO_1_COLLI_2)
					when 'M' then
						@K_LISTINO_PREZZO * (@k_ARMO_1_M_CUBI / @k_ARMO_1_COLLI_2)
					when 'B' then
						@K_LISTINO_PREZZO * (@k_ARMO_1_PEDANE / @k_ARMO_1_COLLI_2)
					else
						@K_LISTINO_PREZZO
				END
			end
		end

		if @k_ARMO_1_M_CUBI > 0 and @k_ARMO_1_COLLI_2 > 0 begin
			set @K_ARTR_M_CUBI = (@k_ARMO_1_M_CUBI / @k_ARMO_1_COLLI_2) * @K_ARTR_COLLI;
		end
		else begin
			set @K_ARTR_M_CUBI = 0;
		end
		if @k_ARMO_1_PEDANE > 0 and @k_ARMO_1_COLLI_2 > 0 begin
			set @K_ARTR_PEDANE = (@k_ARMO_1_PEDANE / @k_ARMO_1_COLLI_2) * @K_ARTR_COLLI;
		end
		else begin
			set @K_ARTR_PEDANE = 0;
		end

--- calcolo il numero barcode sulla pedana  dove hanno girato i barcode di un certo ID_ARMO ---------------------------------------------------------------        
		set @k_nr_padri = 0; -- che è poi il nr pedane utilizzate
		set @k_nr_figli = 0;
		set @k_importo_giri = 0;
		set @k_importo_giriF1 = 0;
		set @k_importo_giriF2 = 0;
      
		if @K_ARTR_DATA_lav_FIN  > @k_data_nuovo_grp begin

--- prima calcola i padri del ID_ARMO      
			declare C_M_ESTR_S_ARTR2 cursor for
				 select barcode 
				 from barcode 
				 where barcode.id_armo = @k_ARMO_1_ID_ARMO 
                     and barcode.data_lav_fin = @K_ARTR_DATA_lav_FIN 
                     and (barcode_lav = ' ' or barcode_lav is null);
			open C_M_ESTR_S_ARTR2;
			fetch C_M_ESTR_S_ARTR2 into @k_barcode_padre;
			while @@fetch_status = 0 begin
            
				set @k_nr_padri = @k_nr_padri + 1;
--- conta i figli         
				set @k_ctr = 0;
				select @k_ctr = count (*) 
					from barcode
					where barcode_lav = @k_barcode_padre;
				if @@ERROR < 0 begin
					set @k_status = '(u_m2000_6_s_artr)  Errore in select count (*) su barcode sqlcode' + isnull(@@ERROR, '');
					goto FORZA_FINE;
				end
            
				if @k_ctr > 0 begin 
			       set @k_nr_figli = @k_nr_figli + @k_ctr;
		        end
            
				fetch C_M_ESTR_S_ARTR2 into @k_barcode_padre;
			end
			close C_M_ESTR_S_ARTR2;
			deallocate C_M_ESTR_S_ARTR2;
			if @@ERROR < 0 begin
				set @k_status = '(u_m2000_6_s_artr)  Errore in foreach C_M_ESTR_S_ARTR2 sqlcode' + isnull(@@ERROR, '');
				goto FORZA_FINE;
			end
 
			if @k_nr_figli is null begin 
				set @k_nr_figli = 0;
			end
         
--- poi calcola i padri che appartengono a un altro ID_ARMO  ma con figli di questo ID_ARMO
			declare C_M_ESTR_S_ARTR3 cursor for
				 select distinct barcode_lav 
					 from barcode 
					where barcode.id_armo = @k_ARMO_1_ID_ARMO 
                        and barcode.data_lav_fin = @K_ARTR_DATA_lav_FIN 
                        and barcode_lav > ' '
                        and barcode_lav <> barcode;
			 open C_M_ESTR_S_ARTR3;
		     fetch C_M_ESTR_S_ARTR3 into @k_barcode_padre;
	         while @@fetch_status = 0 begin 
               
	            set @k_nr_padri = @k_nr_padri + 1;
--- conta i figli         
				set @k_ctr = 0;
				select @k_ctr = count (*) 
					 from barcode
					 where barcode_lav = @k_barcode_padre;
				if @k_ctr > 0 begin 
				   set @k_nr_figli = @k_nr_figli + @k_ctr;
				end
				if @@ERROR < 0 begin
				   set @k_status = '(u_m2000_6_s_artr)  Errore in foreach C_M_ESTR_S_ARTR3 sqlcode' + isnull(@@ERROR, '');
				   goto FORZA_FINE;
				end

			 fetch C_M_ESTR_S_ARTR3 into @k_barcode_padre;
			 end
			 close C_M_ESTR_S_ARTR3;
			 deallocate C_M_ESTR_S_ARTR3;
			 if @@ERROR < 0 begin
				set @k_status = '(u_m2000_6_s_artr)  Errore in select count (*) da barcode sqlcode' + isnull(@@ERROR, '');
				goto FORZA_FINE;
			 end

			if @k_nr_figli is null begin 
				set @k_nr_figli = 0;
			end
       
			if @k_nr_figli > 0 or @k_nr_padri > 0 begin --nr barcode contenuti nelle pedane dove c'earno i barcode del ID_ARMO
				set @k_importo_giri =  @K_arfa_prezzo_u * (@k_nr_figli + @k_nr_padri);

--- media prezzo a giro x Fila 1 e 2    18-01-2014  
				set @K_BARCODE_giri_fn_lav = (@K_BARCODE_giri_f1_lav + @K_BARCODE_giri_f1_lav_gp + @K_BARCODE_giri_f2_lav + @K_BARCODE_giri_f2_lav_gp );
				if @K_BARCODE_giri_fn_lav = 0 or @K_BARCODE_giri_fn_lav is null begin
					set @K_BARCODE_giri_fn_lav = 1;
				end
				set @k_importo_giriF1 = (@K_arfa_prezzo_u * @K_ARTR_COLLI) * ((@K_BARCODE_giri_f1_lav + @K_BARCODE_giri_f1_lav_gp) 
				   / @K_BARCODE_giri_fn_lav
				   );
				set @k_importo_giriF2 = (@K_arfa_prezzo_u * @K_ARTR_COLLI) * ((@K_BARCODE_giri_f2_lav + @K_BARCODE_giri_f2_lav_gp) 
					  / @K_BARCODE_giri_fn_lav
                  );
                  --/ (K_BARCODE_giri_f1_lav + K_BARCODE_giri_f1_lav_gp + K_BARCODE_giri_f2_lav + K_BARCODE_giri_f2_lav_gp )  
                  --/ (K_BARCODE_giri_f1_lav + K_BARCODE_giri_f1_lav_gp + K_BARCODE_giri_f2_lav + K_BARCODE_giri_f2_lav_gp )  
			end
         
		end
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
                @k_ARMO_1_ID_MECA
                ,@k_ARMO_1_ID_ARMO
                ,@K_ARTR_DATA_lav_FIN               
                ,@K_ARTR_COLLI
                ,@k_ARMO_1_COLLI_2
                ,@K_arfa_colli
                ,@k_ARMO_1_COLLI_FATT
                ,@K_ARTR_M_CUBI
                ,@K_ARTR_PEDANE
                ,@K_BARCODE_giri_f1_pl                
                ,@K_BARCODE_giri_f2_pl
                ,@K_BARCODE_giri_f1_lav
                ,@K_BARCODE_giri_f2_lav
                ,@K_BARCODE_giri_f1_pl_gp                
                ,@K_BARCODE_giri_f2_pl_gp
                ,@K_BARCODE_giri_f1_lav_gp
                ,@K_BARCODE_giri_f2_lav_gp
                ,@K_arfa_prezzo_u
                ,@K_LISTINO_OCCUP_PED
               ,@k_importo_giriF1
               ,@k_importo_giriF2
               ,@k_importo_giri
               ,@k_nr_padri
               , @K_NR_BARCODE_F1_PL 
               , @K_NR_BARCODE_F2_PL 
               , @K_NR_BARCODE_F1_LAV 
               , @K_NR_BARCODE_F2_LAV 
               , @K_NR_BARCODE_F1_PL_GP 
               , @K_NR_BARCODE_F2_PL_GP 
               , @K_NR_BARCODE_F1_LAV_GP 
               , @K_NR_BARCODE_F2_LAV_GP 
               );

		if @@ERROR < 0 begin
			set @k_status = '(u_m2000_6_s_artr)  Errore in foreach insert into s_artr_n sqlcode' + isnull(@@ERROR, '');
			goto FORZA_FINE;
		end

		set @K_CONTA_TOT_REC = @K_CONTA_TOT_REC + 1;
--- Per evitare che si riempa il log forza la commit ogni tot records      
   --   set @K_CONTA_REC = @K_CONTA_REC + 1;
   --   if @K_CONTA_REC > 1000 begin
   --      set @K_CONTA_REC = 0;
   --      commit work;
   --      begin work;
--- imposta il tipo di ISOLATION al piu' flessibile, ovvero se incontra tab con Insert piglia le righe ancora non committed         
   --      SET ISOLATION TO DIRTY READ;
    --  end
                  
		fetch C_M_ESTR_S_ARTR into 
			@k_ARMO_1_ID_MECA
			, @k_ARMO_1_ID_ARMO
			, @K_ARTR_DATA_LAV_FIN
			, @K_ARTR_COLLI;
	end
	close C_M_ESTR_S_ARTR;
	deallocate C_M_ESTR_S_ARTR;
 
   if @@ERROR < 0 begin
      set @k_status = '(u_m2000_6_s_artr)  Errore in foreach C_M_ESTR_S_ARTR sqlcode' + isnull(@@ERROR, '');
      goto FORZA_FINE;
   end

--- Crea gli indici della Tabella ---------------------------------------------------------------------------------------------------------------------------------

--- Durante la cancellazione degli Indici non importano le segnalazioni
   --whenever error continue
   --BEGIN 
   --   ON EXCEPTION END EXCEPTION WITH RESUME;
   --   commit work;
   --END
   --BEGIN 
    --  ON EXCEPTION END EXCEPTION WITH RESUME;
--- crea indici 
      drop index IF EXISTS dbo.i_s_artr_1 ;
      drop index IF EXISTS dbo.i_s_artr_2 ;
      drop index IF EXISTS dbo.i_s_artr_3 ;
      create index i_s_artr_1 on dbo.s_artr_n (id_meca);
      create index i_s_artr_2 on dbo.s_artr_n (data_lav_fin);
      create unique index i_s_artr_3 on dbo.s_artr_n (id_armo, data_lav_fin);
   --END
   if @@ERROR != 0 begin
      set @k_status = '(u_m2000_6_s_artr)  Errore in  create index  sqlcode' + isnull(@@ERROR, '');
      goto FORZA_FINE;
   end   
   
   
   goto OK;

FORZA_FINE:
--   BEGIN
 --     ON EXCEPTION END EXCEPTION WITH RESUME;
 --     rollback;
 --  END
   goto FINE;

OK:
--   BEGIN
 --     ON EXCEPTION END EXCEPTION WITH RESUME;
  --    commit work;
  -- END
   set @k_status = 'Ok caricati ' + ISNULL(@K_CONTA_TOT_REC, '') + ' record in tab S_ARTR_N' ;

FINE:
   --trace off;

return @k_status ;

end 
;
                               
