------------------------------- CARICA ID-MECA - ID-ARMO ---------------------------------
USE [sterigenics270P]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[u_m2000_4_s_meca] @k_status varchar(100) OUTPUT
as
BEGIN

   
   declare @K_DATA_LIMITE  date;
   declare @K_CONTA_REC integer, @K_CONTA_TOT_REC integer, @k_ctr   integer;
   --define k_data_elab_da, k_data_elab_a   date;
   declare @k_ARMO_1_ID_ARMO integer  /* like ARMO.ID_ARMO */;  
   declare @k_ARMO_1_ID_MECA integer  /* like ARMO.ID_MECA */;     
     
   --set debug file to '.m2000_nt.trace.txt';
   --trace on;

   --- se incontra lock attende 300 secondi prima di andare in errore
   --   set lock @mode to wait 300;
   
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
      set @k_status = '(u_m2000_4_s_meca)  Errore in select max(data_int)  x K_DATA_LIMITE  sqlcode' + isnull(@@ERROR, '');
      goto FORZA_FINE;
   end
----------------------------------------------------------------------------------------
      
   --let k_data_elab_da = mdy(01,01, year(today) - 4);

   --- Lettura archivio entrate per estrarre i singoli articoli
   declare C_M_ESTR_S_MECA_0 cursor for
           select distinct 
                    ID_ARMO,
                    ID_MECA
             from  armo 
             where id_armo is not null and id_meca is not null
                   AND ARMO.DATA_INT > @K_DATA_LIMITE
             order by id_meca, id_armo;
   open C_M_ESTR_S_MECA_0;
   fetch C_M_ESTR_S_MECA_0 into @K_ARMO_1_ID_ARMO, @K_ARMO_1_ID_MECA;
   while @@fetch_status = 0 begin

   --- carico record                             
      insert into s_meca_n
                  (
                  ID_MECA
                  ,ID_ARMO
                  )  
                values
                  (
                   @k_ARMO_1_ID_MECA
                   ,@k_ARMO_1_ID_ARMO
                  );

      if @@ERROR < 0 begin
         set @k_status = '(u_m2000_4_s_meca)  Errore in insert into s_meca_n  sqlcode' + isnull(@@ERROR, '');
         goto FORZA_FINE;
      end

      set @K_CONTA_TOT_REC = @K_CONTA_TOT_REC + 1;
   --- Per evitare che si riempa il log forza la commit ogni tot records      
      --set @K_CONTA_REC = @K_CONTA_REC + 1;
      --if @K_CONTA_REC > 1000 begin
       --  set @K_CONTA_REC = 0;
         --commit work;
         --begin work;
   --- imposta il tipo di ISOLATION al piu' flessibile, ovvero se incontra tab con Insert piglia le righe ancora non committed         
         --SET ISOLATION TO DIRTY READ;
      --end

   fetch C_M_ESTR_S_MECA_0 into @K_ARMO_1_ID_ARMO, @K_ARMO_1_ID_MECA;
   end
   close C_M_ESTR_S_MECA_0;
   deallocate C_M_ESTR_S_MECA_0;

   if @@ERROR < 0 begin
      set @k_status = '(u_m2000_4_s_meca)  Errore in foreach C_M_ESTR_S_MECA_0  sqlcode' + isnull(@@ERROR, '');
      goto FORZA_FINE;
   end

   goto OK;

FORZA_FINE:
   --BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
   --   rollback;
   --END
   goto FINE;

OK:
   --BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
   --   commit work;
   --END
   set @k_status = 'Ok caricati ' + ISNULL(@K_CONTA_TOT_REC, '') + ' record in tab S_MECA_N' ;

FINE:
   --trace off;

return @k_status ;


end 
;

