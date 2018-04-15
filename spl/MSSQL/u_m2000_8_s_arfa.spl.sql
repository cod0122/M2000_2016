------------------------------- CARICA DATI FATTURAZIONE  ---------------------------------
USE [sterigenics270P]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[u_m2000_8_s_arfa] @k_status varchar(100) OUTPUT
as
BEGIN
  
--   declare @k_status varchar(100);
   declare @K_DATA_LIMITE date;
   declare @K_CONTA_REC integer, @K_CONTA_TOT_REC integer;

   declare @K_ARFA_MAGAZZINO        tinyint;
   declare @K_ARFA_DOSE             decimal(6,2);
   declare @K_ARFA_PREZZO_T         decimal(13,2);
   declare @K_ARFA_COLLI            smallint;
   declare @K_ARFA_CUB_TOT          decimal(8,2);
   declare @K_ARFA_ID_MECA          integer;     
   declare @K_ARFA_NUM_INT          smallint;
   declare @K_ARFA_DATA_INT         date;
   declare @K_ARFA_NUM_BOLLA_OUT    smallint;
   declare @K_ARFA_DATA_BOLLA_OUT   date;
   declare @K_ARFA_NUM_FATT         smallint;
   declare @K_ARFA_DATA_FATT        date;
   declare @K_ARFA_CLIE_1           smallint;
   declare @K_ARFA_CLIE_2           smallint;
   declare @K_ARFA_CLIE_3           smallint;
   declare @K_ARFA_TIPO_DOC         char(2);
   declare @K_ARFA_GRUPPO           smallint;

   declare @K_BARCODE_giri_f1_pl      integer;
   declare @K_BARCODE_giri_f1_lav     integer;
   declare @K_BARCODE_giri_f2_pl      integer;
   declare @K_BARCODE_giri_f2_lav     integer;

--   begin work;
--- imposta il tipo di ISOLATION al piu' flessibile, ovvero se incontra righe appena inserite/aggiornate piglia le righe ancora non committed         
	SET TRANSACTION ISOLATION LEVEL Read uncommitted;

	set @K_CONTA_TOT_REC = 0;
	set @K_CONTA_REC = 0;
----------------------------------------------------------------------------------------
-- DATA LIMITE FINO DA CUI ESTRARRE 
	select @K_DATA_LIMITE = max(data_int) 
        from s_armo_p;
	if @@ERROR <> 0 begin
      set @k_status = '(u_m2000_8_s_arfa)  Errore in select max(data_int)  x K_DATA_LIMITE  sqlcode' + isnull(@@ERROR, '');
      goto FORZA_FINE;
   end
----------------------------------------------------------------------------------------

   declare C_M_ESTR_S_ARFA cursor for
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
             from  ARMO inner join ARFA on ARMO.ID_ARMO = ARFA.ID_ARMO
			            inner join PRODOTTI on ARMO.ART = PRODOTTI.CODICE
						inner join MECA on ARMO.ID_MECA = MECA.ID
             where
                   ARFA.COLLI > 0      
                   and ARMO.COLLI_2 > 0
                   AND ARFA.DATA_FATT > @K_DATA_LIMITE
             group by 
                 ARMO.MAGAZZINO,
                 ARMO.DOSE,
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
             order by ARMO.ID_MECA;

   open C_M_ESTR_S_ARFA;
   fetch C_M_ESTR_S_ARFA into 
					@K_ARFA_MAGAZZINO
					, @K_ARFA_DOSE
					, @K_ARFA_PREZZO_T
					, @K_ARFA_COLLI
					, @K_ARFA_CUB_TOT
					, @K_ARFA_ID_MECA
					, @K_ARFA_NUM_INT
					, @K_ARFA_DATA_INT
					, @K_ARFA_NUM_BOLLA_OUT
					, @K_ARFA_DATA_BOLLA_OUT
					, @K_ARFA_NUM_FATT
					, @K_ARFA_DATA_FATT
					, @K_ARFA_CLIE_1
					, @K_ARFA_CLIE_2
					, @K_ARFA_CLIE_3
					, @K_ARFA_TIPO_DOC
					, @K_ARFA_GRUPPO;

	while @@fetch_status = 0 begin
  
		select @K_BARCODE_giri_f1_pl = sum(FILA_1 + FILA_1P)
             ,@K_BARCODE_giri_f2_pl = sum(FILA_2 + FILA_2P)
             ,@K_BARCODE_giri_f1_lav = sum(lav_FILA_1 + lav_FILA_1P)
             ,@K_BARCODE_giri_f2_lav = sum(lav_FILA_2 + lav_FILA_2P)
                 from barcode
			where barcode.id_meca = @K_ARFA_ID_MECA;
		if @@ERROR < 0 begin
			set @k_status = '(u_m2000_8_s_arfa)  Errore in select sum(FILA_1 + FILA_1P) da barcode sqlcode' + isnull(@@ERROR, '');
			goto FORZA_FINE;
		end
  
		if @K_ARFA_PREZZO_T is NULL begin
			set @K_arfa_PREZZO_T = 0;
		end
   
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
                @K_ARFA_MAGAZZINO
                ,@K_ARFA_DOSE     
                ,@K_ARFA_PREZZO_T 
                ,@K_ARFA_COLLI    
                ,@K_ARFA_CUB_TOT  
                ,@K_ARFA_ID_MECA           
                ,@K_ARFA_NUM_INT         
                ,@K_ARFA_DATA_INT        
                ,@K_ARFA_NUM_BOLLA_OUT   
                ,@K_ARFA_DATA_BOLLA_OUT  
                ,@K_ARFA_NUM_FATT        
                ,@K_ARFA_DATA_FATT       
                ,@K_ARFA_CLIE_1          
                ,@K_ARFA_CLIE_2          
                ,@K_ARFA_CLIE_3          
                ,@K_ARFA_TIPO_DOC        
                ,@K_ARFA_GRUPPO          
                ,@K_BARCODE_giri_f1_pl                
                ,@K_BARCODE_giri_f2_pl
                ,@K_BARCODE_giri_f1_lav
                ,@K_BARCODE_giri_f2_lav 
               );
		if @@ERROR < 0 begin
			set @k_status = '(u_m2000_8_s_arfa)  Errore in insert into s_arfa_n sqlcode' + isnull(@@ERROR, '');
			goto FORZA_FINE;
		end
      
		set @K_CONTA_TOT_REC = @K_CONTA_TOT_REC + 1;
--- Per evitare che si riempa il log forza la commit ogni tot records      
		--set @K_CONTA_REC = @K_CONTA_REC + 1;
		--if @K_CONTA_REC > 1000 begin
		--	set @K_CONTA_REC = 0;
	--		commit work;
		--	begin work;
--- imposta il tipo di ISOLATION al piu' flessibile, ovvero se incontra tab con Insert piglia le righe ancora non committed         
		--	SET ISOLATION TO DIRTY READ;
		--end
                  
		fetch C_M_ESTR_S_ARFA into 
					@K_ARFA_MAGAZZINO
					, @K_ARFA_DOSE
					, @K_ARFA_PREZZO_T
					, @K_ARFA_COLLI
					, @K_ARFA_CUB_TOT
					, @K_ARFA_ID_MECA
					, @K_ARFA_NUM_INT
					, @K_ARFA_DATA_INT
					, @K_ARFA_NUM_BOLLA_OUT
					, @K_ARFA_DATA_BOLLA_OUT
					, @K_ARFA_NUM_FATT
					, @K_ARFA_DATA_FATT
					, @K_ARFA_CLIE_1
					, @K_ARFA_CLIE_2
					, @K_ARFA_CLIE_3
					, @K_ARFA_TIPO_DOC
					, @K_ARFA_GRUPPO;

   end
   close C_M_ESTR_S_ARFA;
   deallocate C_M_ESTR_S_ARFA;
   
   if @@ERROR < 0 begin
      set @k_status = '(u_m2000_8_s_arfa)  Errore in  foreach C_M_ESTR_S_ARFA  sqlcode' + isnull(@@ERROR, '');
      goto FORZA_FINE;
   end
   --BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
    --  commit;
   --END
   
/*Carica archivio fatture con i NO DOSE */
   --BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
    --  begin work;
   --END
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
                  convert(date,'01.01.1899'),
                  0,
                  convert(date,'01.01.1899'),
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
            from ARFA_V inner join PRODOTTI on ARFA_V.ART = PRODOTTI.CODICE
            where
                  ARFA_V.PREZZO_T  <> 0  
                  AND ARFA_V.DATA_FATT > @K_DATA_LIMITE
            group by 
                  ARFA_V.NUM_FATT,
                  ARFA_V.DATA_FATT,
                  ARFA_V.CLIE_3,
                  ARFA_V.TIPO_DOC,
                  PRODOTTI.GRUPPO
            order by PRODOTTI.GRUPPO;
   
   if @@ERROR < 0 begin
      set @k_status = '(u_m2000_8_s_arfa)  Errore in  insert into s_arfa_n  NO DOSE  sqlcode' + isnull(@@ERROR, '');
      goto FORZA_FINE;
   end

--- Crea gli indici della Tabella ---------------------------------------------------------------------------------------------------------------------------------

--- Durante la cancellazione degli Indici non importano le segnalazioni
   --whenever error continue
   --BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
    --  commit work;
   --END
   --BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
--- crea indici 
      drop index IF EXISTS dbo.i_s_arfa_0 ;
      drop index IF EXISTS dbo.i_s_arfa_1 ;
      drop index IF EXISTS dbo.i_s_arfa_2 ;
      drop index IF EXISTS dbo.i_s_arfa_3 ;
      drop index IF EXISTS dbo.i_s_arfa_4 ;
      create index i_s_arfa_0 on dbo.s_arfa_n (id_meca);
      create index i_s_arfa_1 on dbo.s_arfa_n (data_fatt desc, num_fatt desc, dose, clie_3);
      create index i_s_arfa_2 on dbo.s_arfa_n (clie_3, data_int);
      create index i_s_arfa_3 on dbo.s_arfa_n (data_int desc, num_int);
      create index i_s_arfa_4 on dbo.s_arfa_n (id_meca desc, dose);
    --END

   if @@ERROR != 0 begin
      set @k_status = '(u_m2000_8_s_arfa)  Errore in  create index  sqlcode' + isnull(@@ERROR, '');
      goto FORZA_FINE;
   end   
   
   goto OK;

FORZA_FINE:
   --BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
    --  rollback;
   --END
   goto FINE;

OK:
   --BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
    --  commit work;
   --END
   set @k_status = 'Ok caricati ' + ISNULL(@K_CONTA_TOT_REC, '') + ' record in tab S_ARFA_N' ;

FINE:
   --trace off;
   --return @k_status ;

end 
;
                            
  
   
