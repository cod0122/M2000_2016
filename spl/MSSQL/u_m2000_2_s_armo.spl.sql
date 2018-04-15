USE [sterigenics270P]
GO

/****** Object:  StoredProcedure [dbo].[u_m2000_2_s_armo]    Script Date: 10/04/2018 18:02:24 ******/
DROP PROCEDURE [dbo].[u_m2000_2_s_armo]
GO

/****** Object:  StoredProcedure [dbo].[u_m2000_2_s_armo]    Script Date: 10/04/2018 18:02:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[u_m2000_2_s_armo] @k_status varchar(100) OUTPUT
as

BEGIN

      
   --declare @k_status 		 varchar(100);
   declare @K_DATA_LIMITE  date;
   declare @k_armo_prezzi_importo decimal(15,2), @k_importo_da_fatt_a_corpo decimal(15,2), @k_importo_da_fatt_x_qta  decimal(15,2);
   declare @K_CONTA_REC integer, @K_CONTA_TOT_REC integer;
   declare @K_ARMO_COLLI        decimal(5);
   declare @k_colli_da_nontrattare decimal(5);
   --define K_ARMO     row (
   declare @K_ARMO_MAGAZZINO     smallint;
   declare @K_ARMO_DOSE          decimal(6,1);
   declare @K_ARMO_TRAVASO       char(1);     
   declare @K_ARMO_COLLI_TRATTATI decimal(5);
   declare @K_ARMO_COLLI_1       decimal(5);
   declare @K_ARMO_COLLI_2       decimal(5);
   declare @K_ARMO_COLLI_FATT  	decimal(5);
   declare @K_ARMO_M_CUBI_ARSP   decimal(6,2);
   declare @K_ARMO_M_CUBI        decimal(6,2);
   declare @K_ARMO_PEDANE        decimal(5,2); 
   declare @K_ARMO_ID_MECA       integer;   
   declare @K_ARMO_NUM_INT       integer;   
   declare @K_ARMO_DATA_INT      date;
   declare @K_DATA_ENT      date;
   declare @K_ARMO_DATA_LAV_FIN  date;
   declare @K_ARMO_CLIE_1        integer;   
   declare @K_ARMO_CLIE_2        integer;   
   declare @K_ARMO_CLIE_3        integer;   
   declare @K_ARMO_APERTO        char(1);
   declare @K_ARMO_GRUPPO        decimal(3);
   declare @K_ARMO_imp_fatt      decimal(15,2);
   declare @K_ARMO_imp_da_fatt   decimal(15,2);
   --   );           
   --define k_ARMO_1     row (
   declare @k_ARMO_1_ID_ARMO       integer;   
   declare @k_ARMO_1_ID_ARMO_1_PREZZI  integer;   
   declare @k_ARMO_1_ID_LISTINO    integer;   
   declare @k_ARMO_1_ART           char(12);   
   declare @k_ARMO_1_COLLI_2       decimal(5);
   declare @k_ARMO_1_LARG_2        decimal(5);
   declare @k_ARMO_1_LUNG_2        decimal(5);
   declare @k_ARMO_1_ALT_2         decimal(5);
   declare @k_ARMO_1_PESO_KG       decimal(8,2);
   declare @k_ARMO_1_M_CUBI        decimal(6,2);
   declare @k_ARMO_1_PEDANE        decimal(5,2); 
   --   );
   --define K_BARCODE     row (
   declare @K_BARCODE_giri_f1_pl      integer;
   declare @K_BARCODE_giri_f1_lav     integer;
   declare @K_BARCODE_giri_f2_pl      integer;
   declare @K_BARCODE_giri_f2_lav     integer;
   --   );           
   --define K_ARFA     row (
   declare @K_ARFA_colli      integer;
   declare @K_ARFA_CLIE_3     integer;
   --   );
   --define K_SPED     row (
   declare @K_SPED_CLIE_2        integer;
   --   );
   --define K_LISTINO  row (
   declare @K_LISTINO_MAGAZZINO     smallint;
   declare @K_LISTINO_PREZZO        decimal(15,2);
   declare @K_LISTINO_TIPO          char(1);
   declare @K_LISTINO_CAMPIONE      char(1);   
   declare @K_LISTINO_M_CUBI_F      decimal(6,2);
   --   );

      
   --set debug file to '.m2000_nt.trace.txt';
   --trace on;

--- se incontra lock attende 300 secondi prima di andare in errore
 --  set lock @mode to wait 300;
   
--- imposta il tipo di ISOLATION al piu' flessibile, ovvero se incontra righe appena inserite/aggiornate piglia le righe ancora non committed         
   --SET ISOLATION TO DIRTY READ;
	SET TRANSACTION ISOLATION LEVEL Read uncommitted;

   --commit;
	--BEGIN TRANSACTION;

	set @K_CONTA_TOT_REC = 0;
	set @K_CONTA_REC = 0;
   
----------------------------------------------------------------------------------------
-- DATA LIMITE FINO DA CUI ESTRARRE 
	select @K_DATA_LIMITE = max(data_int) 
		from s_armo_p;
	if @@ERROR <> 0 begin
		set @k_status = '(u_m2000_2_s_armo)  Errore in select max(data_int)  x K_DATA_LIMITE  @@ERROR' + isnull(@@ERROR, '');
		goto FORZA_FINE;
	end
----------------------------------------------------------------------------------------
     
   
	declare C_M_ESTR_S_ARMO cursor for
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
                 convert(date, MECA.DATA_ENT),
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
             from  MECA inner join ARMO on meca.id = armo.id_meca
			  inner join PRODOTTI on armo.art = prodotti.codice
			  left outer join ARMO_PREZZI on armo.id_armo = ARMO_PREZZI.id_armo
             where ARMO.COLLI_2 > 0
                   AND MECA.DATA_INT > @K_DATA_LIMITE
              order by meca.id, armo.id_armo;

	open C_M_ESTR_S_ARMO;
	fetch C_M_ESTR_S_ARMO into @K_ARMO_MAGAZZINO, @K_ARMO_DOSE, @K_ARMO_TRAVASO, @K_ARMO_COLLI_1
                  , @K_ARMO_COLLI_2, @K_ARMO_COLLI_FATT, @K_ARMO_M_CUBI, @K_ARMO_PEDANE, @K_ARMO_ID_MECA
				  , @K_ARMO_NUM_INT, @K_ARMO_DATA_INT, @K_DATA_ENT
                 ,@K_ARMO_CLIE_1        
                 ,@K_ARMO_CLIE_2        
                 ,@K_ARMO_CLIE_3        
                 ,@K_ARMO_APERTO
                 ,@K_ARMO_GRUPPO    
                 ,@k_ARMO_1_ID_LISTINO   
                 ,@k_ARMO_1_ID_ARMO  
                 ,@k_ARMO_1_ID_ARMO_1_PREZZI  
                 ,@k_ARMO_1_ART
                 ,@k_ARMO_1_PESO_KG
                 ,@k_ARMO_1_LARG_2
                 ,@k_ARMO_1_LUNG_2
                 ,@k_ARMO_1_ALT_2

	while @@fetch_status = 0 begin

---16.12.2010 Piglia il ricevente dal ddt
		select @K_SPED_clie_2 = max(sped.clie_2)
			from arsp inner join sped  on arsp.id_sped = sped.id_sped
			where id_armo = @k_ARMO_1_ID_ARMO ;
		if @@ERROR < 0 begin
			set @k_status = '(u_m2000_2_s_armo)  Errore in select max(sped.clie_2) arsp e sped  @@ERROR' + isnull(@@ERROR, '');
			goto FORZA_FINE;
		end
                  
		if @K_SPED_CLIE_2 > 0 begin 
			set @K_ARMO_clie_2 = @K_SPED_CLIE_2;
		end
	---16.12.2010 Piglia il cliente di fattura
		select @K_ARFA_clie_3 = max(clie_3)
			from arfa
			where id_armo = @k_ARMO_1_ID_ARMO ;
		if @@ERROR < 0 begin
			set @k_status = '(u_m2000_2_s_armo)  Errore in select max(clie_3) arfa  @@ERROR' + isnull(@@ERROR, '');
			goto FORZA_FINE;
		end
		if @K_ARFA_CLIE_3 > 0 begin 
			set @K_ARMO_clie_3 = @K_ARFA_CLIE_3;
		end
   
--- Piglia i giri di lavorazione   
		select @K_BARCODE_giri_f1_pl = sum(FILA_1 + FILA_1P)
				,@K_BARCODE_giri_f2_pl = sum(FILA_2 + FILA_2P)
				,@K_BARCODE_giri_f1_lav = sum(lav_FILA_1 + lav_FILA_1P)
				,@K_BARCODE_giri_f2_lav = sum(lav_FILA_2 + lav_FILA_2P)
					from barcode
			where barcode.id_armo = @k_ARMO_1_ID_ARMO 
					and (barcode.causale is null or barcode.causale <> 'T');
		if @@ERROR < 0 begin
			set @k_status = '(u_m2000_2_s_armo)  Errore in select sum(FILA_1 + FILA_1P) ... barcode  @@ERROR' + isnull(@@ERROR, '');
			goto FORZA_FINE;
		end

---16.12.2010 Piglia nr colli da NON trattare
		set @k_colli_da_nontrattare=0;
		select @k_colli_da_nontrattare = count(*)
			from barcode
			where barcode.id_armo = @k_ARMO_1_ID_ARMO 
					and barcode.causale = 'T';
		if @@ERROR < 0 begin
			set @k_status = '(u_m2000_2_s_armo)  Errore in select count(*)  barcode  @@ERROR' + isnull(@@ERROR, '');
			goto FORZA_FINE;
		end
		if @k_colli_da_nontrattare is null begin 
			set @k_colli_da_nontrattare = 0;
		end
   
--- Piglia importo fatturato    
		set @K_ARFA_colli = 0;
		set @K_ARMO_imp_fatt = 0;
		select @K_ARMO_imp_fatt = sum(prezzo_t), @K_ARFA_colli = sum(colli)
			from arfa
			where arfa.id_armo = @k_ARMO_1_ID_ARMO;
		if @@ERROR < 0 begin
			set @k_status = '(u_m2000_2_s_armo)  Errore in select sum(prezzo_t), sum(colli)  arfa  @@ERROR' + isnull(@@ERROR, '');
			goto FORZA_FINE;
		end
         
--- x default il LOTTO è aperto
		if @K_ARMO_APERTO is null begin 
			set @K_ARMO_APERTO = 'S';
		end

		if @K_ARFA_colli is null begin 
			set @K_ARFA_colli = 0;
		end
		if @K_ARMO_imp_fatt is null begin 
			set @K_ARMO_imp_fatt = 0;
		end
		if @K_ARMO_COLLI_FATT is null begin 
			set @K_ARMO_colli_fatt = 0;
		end
-- se ho forzato i colli fatturati su ARMO > dei colli Fatturati su ARFA (quindi reali) allora piglia quest'ultimo dato         
		if @K_ARMO_COLLI_FATT < @K_ARFA_colli  begin 
			set @K_ARMO_colli_fatt = @K_ARMO_COLLI_FATT;
		end
		
		set @K_ARMO_COLLI = @K_ARMO_COLLI_2 ;
		set @K_ARMO_colli_2 = @K_ARMO_COLLI_2 - @K_ARFA_colli - @k_colli_da_nontrattare;

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--- 07082012 Se il Lotto non è stato completamente fatturato ed è ancora APERTO allora CALCOLO il valore dei colli NON fatturati
-----------------------------------------------------------------------------------------------------------------------------------------------------------
--- Inizializza Importi da Fatturare per fare il calcolo         
		set @k_armo_prezzi_importo =  0;
		set @K_ARMO_imp_da_fatt = 0;
                        
		if @K_ARMO_COLLI_2 > 0 and @K_ARMO_APERTO <> 'N' begin
         
--- se colli non fatturati (anche parzialm) piglia il valore dal listino
--- se non ho il prezzo in entrata allora lo calcolo alla 'vecchia maniera'
			if @k_ARMO_1_ID_LISTINO > 0 begin
				select @K_LISTINO_MAGAZZINO = LISTINO.MAGAZZINO,
							@K_LISTINO_PREZZO = LISTINO.PREZZO,
							@K_LISTINO_TIPO = LISTINO.TIPO,
							@K_LISTINO_CAMPIONE = LISTINO.CAMPIONE,
							@K_LISTINO_M_CUBI_F = LISTINO.M_CUBI_F
								 from LISTINO
				   where id = @k_ARMO_1_ID_LISTINO;
				if @@ERROR < 0 begin
				   set @k_status = '(u_m2000_2_s_armo)  Errore in select    LISTINO.MAGAZZINO.... LISTINO  @@ERROR' + isnull(@@ERROR, '');
				   goto FORZA_FINE;
				end
			end
		end
		else begin
		
			select  @K_LISTINO_MAGAZZINO = max(LISTINO.MAGAZZINO),
					@K_LISTINO_PREZZO = max(LISTINO.PREZZO),
					@K_LISTINO_TIPO = max(LISTINO.TIPO),
					@K_LISTINO_CAMPIONE = max(LISTINO.CAMPIONE),
					@K_LISTINO_M_CUBI_F = max(LISTINO.M_CUBI_F)
					from LISTINO
					where 
							@K_ARMO_CLIE_3   = LISTINO.COD_CLI    and
								@k_ARMO_1_ART    = LISTINO.COD_ART    and
							@K_ARMO_DOSE   = LISTINO.DOSE       and
							(@k_ARMO_1_LARG_2     = LISTINO.MIS_Z  or
							LISTINO.MIS_Z = 0) and
							(@k_ARMO_1_LUNG_2     = LISTINO.MIS_X  or
							LISTINO.MIS_X = 0) and
							(@k_ARMO_1_ALT_2      = LISTINO.MIS_y  or
							LISTINO.MIS_y = 0);
			if @@ERROR < 0 begin
				set @k_status = '(u_m2000_2_s_armo)  Errore in select  max(LISTINO.MAGAZZINO).... LISTINO  @@ERROR' + isnull(@@ERROR, '');
				goto FORZA_FINE;
			end
		end

--- CALCOLO DEL PREZZO                  
		if @@ERROR = 0 begin
--- Calcolo i metri cubi per la fatturazione, che possono differire da quelli
--- reali se, impostati nel Listino
			if @K_LISTINO_PREZZO is NULL begin
				set @K_LISTINO_PREZZO     = 0;
			end
			if @K_LISTINO_M_CUBI_F > 0 begin
				set @K_ARMO_1_M_CUBI = @K_ARMO_COLLI * @K_LISTINO_M_CUBI_F;
			end
			
--- Importo da fatturare da ARMO_PREZZI se esiste
			if @k_ARMO_1_ID_ARMO_1_PREZZI  > 0 begin
			--- prima piglia Importi da fatturare x collo 
				select @k_importo_da_fatt_x_qta = sum(prezzo * item_dafatt) 
							from armo_prezzi
							where id_armo = @k_ARMO_1_ID_ARMO
								   and stato = '6'  and tipo_calcolo = 'C';
				if @@ERROR < 0 begin
				   set @k_status = '(u_m2000_2_s_armo)  Errore in select sum(prezzo * item_dafatt)  armo_prezzi  @@ERROR' + isnull(@@ERROR, '');
				   goto FORZA_FINE;
				end
         --- qui piglia Importi da fatturare a corpo (cifra unica) 
				select @k_importo_da_fatt_a_corpo = sum(prezzo) 
							from armo_prezzi
							where id_armo = @k_ARMO_1_ID_ARMO
								   and stato = '6'  and tipo_calcolo = 'I';
				if @@ERROR < 0 begin
				   set @k_status = '(u_m2000_2_s_armo)  Errore in select sum(prezzo) armo_prezzi  @@ERROR' + isnull(@@ERROR, '');
				   goto FORZA_FINE;
				end
				if @k_importo_da_fatt_x_qta > 0 begin
				   set @k_armo_prezzi_importo = @k_importo_da_fatt_x_qta;
				end
				if @k_importo_da_fatt_a_corpo > 0 begin
				   set @k_armo_prezzi_importo = @k_armo_prezzi_importo + @k_importo_da_fatt_a_corpo;
				end
			end
		end
		else begin
		
--- altrimenti Importo da fatturare nel modo 'vecchio'  direttamente da ENTRATE - FATTURATO
			if @K_LISTINO_TIPO = 'C'  
				set @K_ARMO_imp_da_fatt = @K_ARMO_imp_da_fatt + @K_LISTINO_PREZZO * @K_ARMO_COLLI_2;
			else begin 
				if @K_LISTINO_TIPO = 'P' 
					set @K_ARMO_imp_da_fatt = @K_ARMO_imp_da_fatt + @K_LISTINO_PREZZO 
                             * ((@k_ARMO_1_PESO_KG / @K_ARMO_COLLI) * @K_ARMO_COLLI_2);
				else begin 
					if @K_LISTINO_TIPO = 'M' 
						set @K_ARMO_imp_da_fatt = @K_ARMO_imp_da_fatt + @K_LISTINO_PREZZO 
                             * ((@k_ARMO_1_M_CUBI / @K_ARMO_COLLI) * @K_ARMO_COLLI_2);
					else begin 
						if @K_LISTINO_TIPO = 'B' 
							set @K_ARMO_imp_da_fatt = @K_ARMO_imp_da_fatt + @K_LISTINO_PREZZO 
                             * ((@k_ARMO_1_PEDANE / @K_ARMO_COLLI) * @K_ARMO_COLLI_2);
						else begin
							set @K_ARMO_imp_da_fatt = @K_ARMO_imp_da_fatt + @K_LISTINO_PREZZO;
						end 
					end 
				end
			end 
            
			if @K_ARMO_imp_da_fatt is NULL begin
				set @K_ARMO_imp_da_fatt = 0;
			end
		end            

	    set @K_ARMO_imp_da_fatt = @K_ARMO_imp_da_fatt + @k_armo_prezzi_importo;
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
                 @k_ARMO_1_ID_ARMO,
				 @k_ARMO_1_ID_LISTINO,
                 @K_ARMO_MAGAZZINO,
                 @K_ARMO_DOSE,
                 @K_ARMO_TRAVASO,
                 @K_ARMO_COLLI_1,
                 @K_ARMO_COLLI,
                 @K_ARMO_M_CUBI,
                 @K_ARMO_PEDANE,
                 @K_ARMO_ID_MECA,
                 @K_ARMO_NUM_INT,
                 @K_ARMO_DATA_INT,
                 @K_DATA_ENT,
                 @K_ARMO_CLIE_1,
                 @K_ARMO_CLIE_2,
                 @K_ARMO_CLIE_3
                ,@K_ARMO_APERTO
                ,@K_ARMO_GRUPPO
                ,@K_ARMO_imp_fatt
                ,@K_ARMO_imp_da_fatt
                ,0.0
                ,@K_BARCODE_giri_f1_pl                
                ,@K_BARCODE_giri_f2_pl
                ,@K_BARCODE_giri_f1_lav
                ,@K_BARCODE_giri_f2_lav
               );
		if @@ERROR < 0 begin
			set @k_status = '(u_m2000_2_s_armo)  Errore in insert into s_armo_n  @@ERROR' + isnull(@@ERROR, '');
			goto FORZA_FINE;
		end

	    set @K_CONTA_TOT_REC = @K_CONTA_TOT_REC + 1;
               
--- Per evitare che si riempa il log forza la commit ogni tot records      
		--set @K_CONTA_REC = @K_CONTA_REC + 1;
		--if @K_CONTA_REC > 500 begin
		--	set @K_CONTA_REC = 0;
			--COMMIT TRANSACTION;
	--		if @@ERROR < 0 begin
	--			set @k_status = '(u_m2000_2_s_armo)  Errore in commit work  @@ERROR' + isnull(@@ERROR, '');
	--			goto FORZA_FINE;
	--		end
			--BEGIN TRANSACTION;
--- imposta il tipo di ISOLATION al piu' flessibile, ovvero se incontra righe appena inserite/aggiornate piglia le righe ancora non committed         
--         SET ISOLATION TO DIRTY READ;
			--end
		--end
		
		fetch C_M_ESTR_S_ARMO into @K_ARMO_MAGAZZINO, @K_ARMO_DOSE, @K_ARMO_TRAVASO, @K_ARMO_COLLI_1
                  , @K_ARMO_COLLI_2, @K_ARMO_COLLI_FATT, @K_ARMO_M_CUBI, @K_ARMO_PEDANE, @K_ARMO_ID_MECA
				  , @K_ARMO_NUM_INT, @K_ARMO_DATA_INT, @K_DATA_ENT
                 ,@K_ARMO_CLIE_1        
                 ,@K_ARMO_CLIE_2        
                 ,@K_ARMO_CLIE_3        
                 ,@K_ARMO_APERTO
                 ,@K_ARMO_GRUPPO    
                 ,@k_ARMO_1_ID_LISTINO   
                 ,@k_ARMO_1_ID_ARMO  
                 ,@k_ARMO_1_ID_ARMO_1_PREZZI  
                 ,@k_ARMO_1_ART
                 ,@k_ARMO_1_PESO_KG
                 ,@k_ARMO_1_LARG_2
                 ,@k_ARMO_1_LUNG_2
                 ,@k_ARMO_1_ALT_2
                  
	end
	
	close C_M_ESTR_S_ARMO;
	deallocate C_M_ESTR_S_ARMO;

	if @@ERROR < 0 begin
		set @k_status = '(u_m2000_2_s_armo)  Errore in foreach C_M_ESTR_S_ARMO  @@ERROR' + isnull(@@ERROR, '');
		goto FORZA_FINE;
	end

   
--- Crea gli indici della Tabella ---------------------------------------------------------------------------------------------------------------------------------

--- Durante la cancellazione degli Indici non importano le segnalazioni
   --whenever error continue
	--BEGIN 
     -- ON EXCEPTION END EXCEPTION WITH RESUME;
	--COMMIT TRANSACTION;
	--END
   
  -- BEGIN 
    --  ON EXCEPTION END EXCEPTION WITH RESUME;
--- crea indici 
	drop index IF EXISTS dbo.i_s_armo_n_0 ;
	drop index IF EXISTS dbo.i_s_armo_n_1 ;
	drop index IF EXISTS dbo.i_s_armo_n_2 ;
	drop index IF EXISTS dbo.i_s_armo_n_3 ;
	drop index IF EXISTS dbo.i_s_armo_n_4 ;
	drop index IF EXISTS dbo.i_s_armo_n_5 ;
	drop index IF EXISTS dbo.i_s_armo_n_6 ;

	create index i_s_armo_n_0 on dbo.s_armo_n (id_meca);
	create index i_s_armo_n_1 on dbo.s_armo_n (id_armo);
	create index i_s_armo_n_2 on dbo.s_armo_n (data_int desc, num_int);
	create index i_s_armo_n_3 on dbo.s_armo_n (clie_1, data_int);
	create index i_s_armo_n_4 on dbo.s_armo_n (clie_2, data_int);
	create index i_s_armo_n_5 on dbo.s_armo_n (clie_3, data_int);
	create index i_s_armo_n_6 on dbo.s_armo_n (id_listino);
   
 --  END
   
	if @@ERROR != 0 begin
		set @k_status = '(u_m2000_2_s_armo)  Errore in  create index  @@ERROR' + isnull(@@ERROR, '');
		goto FORZA_FINE;
	end   
   
	goto OK;

FORZA_FINE:
  -- BEGIN
      --ON EXCEPTION END EXCEPTION WITH RESUME;
     -- rollback;
 --  END
   goto FINE;

OK:
   --BEGIN 
      --ON EXCEPTION END EXCEPTION WITH RESUME;
	--COMMIT TRANSACTION;
   --END
	set @k_status = 'Ok caricati ' + ISNULL(@K_CONTA_TOT_REC, '') + ' record in tab S_ARMO_N' ;

FINE:
	set @k_status = 'KO Errore: ' + @k_status + ' (tab S_ARMO_N)' ;
   --trace off;
   --return @k_status ;

end 
;

                            
                               
                        
GO


