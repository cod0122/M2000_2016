------------------------------- CARICA DATI  DI SPEDIZIONE (ARSP)  ---------------------------------
USE [sterigenics270P]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[u_m2000_10_s_arsp] @k_status varchar(100) OUTPUT
as
BEGIN
  
--   declare @k_status varchar(100);
   declare @K_DATA_LIMITE    date;
   declare @K_CONTA_REC integer, @K_CONTA_TOT_REC integer;
   --define k_data_elab      date;
   
   declare @K_SPED_MAGAZZINO tinyint      /* like ARMO.MAGAZZINO */;
   declare @K_SPED_DOSE decimal(6,2)           /* like ARMO.DOSE */;
   declare @K_SPED_COLLI smallint          /* like ARMO.COLLI_2 */;
   declare @K_SPED_CUB_TOT        decimal(12,2);
   declare @K_SPED_ID_MECA integer        /* like ARMO.ID_MECA */;
   declare @K_SPED_ID_ARMO integer        /* like ARMO.ID_ARMO */;
   declare @K_SPED_NUM_INT smallint        /* like ARMO.NUM_INT */;
   declare @K_SPED_DATA_INT date     /* like ARMO.DATA_INT */;
   declare @K_SPED_NUM_BOLLA_OUT smallint  /* like ARSP.NUM_BOLLA_OUT */;
   declare @K_SPED_DATA_BOLLA_OUT date /* like ARSP.DATA_BOLLA_OUT */;
   declare @K_SPED_ID_SPED integer      /* like ARSP.ID_SPED */;
   declare @K_SPED_DATA_RIT date       /* like SPED.DATA_RIT */;
   declare @K_SPED_CLIE_1 smallint               /* like MECA.CLIE_1 */;
   declare @K_SPED_CLIE_2 smallint             /* like MECA.CLIE_2 */;
   declare @K_SPED_CLIE_3 smallint              /* like MECA.CLIE_3 */;
   declare @K_SPED_GRUPPO smallint                /* like GRU.CODICE */;
     
  declare @K_BARCODE_giri_f1_pl      integer;
  declare @K_BARCODE_giri_f1_lav     integer;
  declare @K_BARCODE_giri_f2_pl      integer;
  declare @K_BARCODE_giri_f2_lav     integer;
 
   --begin work;
--- imposta il tipo di ISOLATION al piu' flessibile, ovvero se incontra righe appena inserite/aggiornate piglia le righe ancora non committed         
	SET TRANSACTION ISOLATION LEVEL Read uncommitted;


	set @K_CONTA_TOT_REC = 0;
	set @K_CONTA_REC = 0;
----------------------------------------------------------------------------------------
-- DATA LIMITE FINO DA CUI ESTRARRE 
	select @K_DATA_LIMITE = max(data_int) 
        from s_armo_p;
	if @@ERROR <> 0 begin
		set @k_status = '(u_m2000_10_s_arsp)  Errore in select max(data_int)  x K_DATA_LIMITE  sqlcode' + isnull(@@ERROR, '');
		goto FORZA_FINE;
	end
----------------------------------------------------------------------------------------
     
   --let k_data_elab = mdy(01,01, year(today) - 4)      

	declare C_M_ESTR_S_SPED cursor for
		select
                 ARMO.MAGAZZINO,
                 ARMO.DOSE,
                 sum(ARSP.COLLI) COLLI,
                 (ARMO.M_CUBI / ARMO.COLLI_2)  CUB_TOT,
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
             from  SPED inner join ARSP on SPED.id_sped = ARSP.id_sped
			            inner join ARMO on ARSP.ID_ARMO = ARMO.ID_ARMO 
						inner join PRODOTTI on ARMO.ART = PRODOTTI.CODICE
						inner join MECA on ARMO.id_meca = MECA.id
             where ARSP.COLLI > 0             
                   and ARMO.COLLI_2 > 0
                   AND SPED.DATA_BOLLA_OUT > @K_DATA_LIMITE
             group by 
                 ARMO.MAGAZZINO,
                 ARMO.DOSE,
                 (ARMO.M_CUBI / ARMO.COLLI_2),
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
             order by ARMO.ID_MECA,
                      ARSP.ID_ARMO
	open C_M_ESTR_S_SPED;
	fetch C_M_ESTR_S_SPED into 
					@K_SPED_MAGAZZINO
					, @K_SPED_DOSE
					, @K_SPED_COLLI
					, @K_SPED_CUB_TOT
					, @K_SPED_ID_MECA
					, @K_SPED_ID_ARMO
					, @K_SPED_NUM_INT
					, @K_SPED_DATA_INT
					, @K_SPED_NUM_BOLLA_OUT
					, @K_SPED_DATA_BOLLA_OUT
					, @K_SPED_ID_SPED
					, @K_SPED_DATA_RIT
					, @K_SPED_CLIE_1
					, @K_SPED_CLIE_2
					, @K_SPED_CLIE_3
					, @K_SPED_GRUPPO;

	while @@fetch_status = 0 begin

		select @K_BARCODE_giri_f1_pl = sum(FILA_1 + FILA_1P)
             ,@K_BARCODE_giri_f2_pl = sum(FILA_2 + FILA_2P)
             ,@K_BARCODE_giri_f1_lav = sum(lav_FILA_1 + lav_FILA_1P)
             ,@K_BARCODE_giri_f2_lav = sum(lav_FILA_2 + lav_FILA_2P)
            from barcode
            where barcode.id_armo = @K_SPED_ID_ARMO;
		if @@ERROR < 0 begin
			set @k_status = '(u_m2000_8_s_arfa)  Errore in select sum(FILA_1 + FILA_1P) da barcode sqlcode' + isnull(@@ERROR, '');
			goto FORZA_FINE;
		end

		if @K_SPED_CUB_TOT is NULL begin
			set @K_SPED_CUB_TOT = 0;
		end
		set @K_SPED_CUB_TOT = @K_SPED_CUB_TOT * @K_SPED_COLLI;
   
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
                @K_SPED_MAGAZZINO       
                ,@K_SPED_DOSE           
                ,@K_SPED_COLLI          
                ,@K_SPED_CUB_TOT        
                ,@K_SPED_ID_MECA        
                ,@K_SPED_ID_ARMO        
                ,@K_SPED_NUM_INT        
                ,@K_SPED_DATA_INT       
                ,@K_SPED_NUM_BOLLA_OUT  
                ,@K_SPED_DATA_BOLLA_OUT 
                ,@K_SPED_ID_SPED
                ,@K_SPED_DATA_RIT 
                ,@K_SPED_CLIE_1         
                ,@K_SPED_CLIE_2         
                ,@K_SPED_CLIE_3         
                ,@K_SPED_GRUPPO         
                ,@K_BARCODE_giri_f1_pl                
                ,@K_BARCODE_giri_f2_pl
                ,@K_BARCODE_giri_f1_lav
                ,@K_BARCODE_giri_f2_lav               
               );
		if @@ERROR < 0 begin
			set @k_status = '(u_m2000_8_s_arfa)  Errore in insert into s_arsp sqlcode' + isnull(@@ERROR, '');
			goto FORZA_FINE;
		end

		set @K_CONTA_TOT_REC = @K_CONTA_TOT_REC + 1;
--- Per evitare che si riempa il log forza la commit ogni tot records      
	--	set @K_CONTA_REC = @K_CONTA_REC + 1;
	--	if @K_CONTA_REC > 1000 begin
	--		set @K_CONTA_REC = 0;
	--		commit work;
	--		begin work;
--- imposta il tipo di ISOLATION al piu' flessibile, ovvero se incontra tab con Insert piglia le righe ancora non committed         
	--		SET ISOLATION TO DIRTY READ;
	--	end
                  
		fetch C_M_ESTR_S_SPED into 
					@K_SPED_MAGAZZINO
					, @K_SPED_DOSE
					, @K_SPED_COLLI
					, @K_SPED_CUB_TOT
					, @K_SPED_ID_MECA
					, @K_SPED_ID_ARMO
					, @K_SPED_NUM_INT
					, @K_SPED_DATA_INT
					, @K_SPED_NUM_BOLLA_OUT
					, @K_SPED_DATA_BOLLA_OUT
					, @K_SPED_ID_SPED
					, @K_SPED_DATA_RIT
					, @K_SPED_CLIE_1
					, @K_SPED_CLIE_2
					, @K_SPED_CLIE_3
					, @K_SPED_GRUPPO;
	end
	close C_M_ESTR_S_SPED;
	deallocate C_M_ESTR_S_SPED;

   
	if @@ERROR < 0 begin
		set @k_status = '(u_m2000_8_s_arfa)  Errore in  foreach C_M_ESTR_S_SPED  sqlcode' + isnull(@@ERROR, '');
		goto FORZA_FINE;
	end


 --- Crea gli indici della Tabella ---------------------------------------------------------------------------------------------------------------------------------

--- Durante la cancellazione degli Indici non importano le segnalazioni
   --whenever error continue
   --BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
    --  commit work;
   --END
   --BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
      drop index IF EXISTS dbo.i_s_arsp_1 ;
      drop index IF EXISTS dbo.i_s_arsp_2 ;
      drop index IF EXISTS dbo.i_s_arsp_3 ;
      drop index IF EXISTS dbo.i_s_arsp_4 ;
      drop index IF EXISTS dbo.i_s_arsp_5 ;
      drop index IF EXISTS dbo.i_s_arsp_6 ;

      create unique index i_s_arsp_1 on dbo.s_arsp_n (id_meca, id_armo, NUM_BOLLA_OUT);
      create unique index i_s_arsp_2 on dbo.s_arsp_n (id_armo, NUM_BOLLA_OUT);
      create index i_s_arsp_3 on dbo.s_arsp_n (num_bolla_out, data_bolla_out);
      create index i_s_arsp_4 on dbo.s_arsp_n (id_meca, id_armo, num_bolla_out, data_bolla_out);
      create unique index i_s_arsp_5 on dbo.s_arsp_n (id_sped, id_armo);
      create index i_s_arsp_6 on dbo.s_arsp_n (id_meca, dose);
   
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
   --   commit work;
   --END
   set @k_status = 'Ok caricati ' + ISNULL(@K_CONTA_TOT_REC, '') + ' record in tab S_ARSP_N' ;

FINE:
   --trace off;
   --return @k_status ;

end 
;
                            
   
   