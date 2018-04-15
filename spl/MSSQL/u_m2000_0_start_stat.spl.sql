------------------------------- CARICA ID-MECA - ID-ARMO ---------------------------------
USE [sterigenics270P]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[u_m2000_0_start_stat] @k_status varchar(1000) OUTPUT
as
BEGIN

--   declare @k_status varchar(1000);

   declare @K_BASE_DATA_STAT date /* like BASE.DATA_STAT */;
   declare @K_BASE_ORA_STAT char(08) /* like BASE.ORA_STAT */;
   declare @k_rc varchar(100);
   declare @k_rc_tot varchar(1000);
   declare @k_datetime datetime2(3);
   declare @k_id_step integer, @k_appo integer;

   
   set @k_rc_tot = '';
   set @K_BASE_DATA_STAT   = getdate();
   set @K_BASE_ORA_STAT    = 'IN ESEC.';
   update BASE
         set
            BASE.DATA_STAT  = @K_BASE_DATA_STAT,
            BASE.ORA_STAT   = @K_BASE_ORA_STAT;
            
-- STEP 1 --------------------------------------------------------------------------------------------   
   set @k_datetime         = getdate();
   set @k_id_step = 1;
   select @k_appo = id_step 
      from BASE_STAT
      where id_base = 'A'
            and id_step = @k_id_step;
   if @k_appo != @k_id_step or @k_appo is null begin
      insert into BASE_STAT (
            id_base 
            ,id_step
            ,step_descr
            ,dataora_start
            ,dataora_end
            ,esito
            ,x_datins
            ,x_utente
         )
         values(
            'A'
            ,@k_id_step
            ,'crea S_ARMO_N'
            ,@k_datetime
            ,''
            ,'In esecuzione....'
            ,@k_datetime
            ,'batch'         
         );
   --let k_status = 'DBG Insert BASE_STAT id_step: ' || k_id_step || ' @@ERROR: ' || @@ERROR;
   --goto FORZA_FINE;
   end
   else begin
      if @@ERROR >= 0 begin
         update BASE_STAT
            set id_base = 'A'
               ,id_step = @k_id_step
               ,step_descr = 'crea S_ARMO_N'
               ,dataora_start = @k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = @k_datetime
               ,x_utente = 'batch'
            where id_base = 'A'
               and id_step = @k_id_step;
      end
      else begin
         set @k_status = 'Ko! Insert BASE_STAT id_step: ' + isnull(@k_id_step, '');
         goto FORZA_FINE;
      end
   end

-- Step 1: crea S_ARMO_N           
	EXEC [dbo].[u_m2000_1_cr_tab_s_armo] @k_rc = @k_status OUTPUT 
   --call u_m2000_1_cr_tab_s_armo() returning @k_rc;
   if left(@k_rc,2) = 'Ok' begin
      set @k_rc_tot = rtrim(ltrim(substring(@k_rc,3,97)));
   end
   set @K_BASE_DATA_STAT   = getdate();
   set @k_datetime = getdate();
   --call u_m2000_get_datetime() returning @k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
-- Aggiorna BASE
   if left(@k_rc,2) = 'Ok' begin
      set @k_rc_tot = isnull(@k_rc_tot, '') + ' ' + isnull(rtrim(ltrim(substring(@k_rc,3,97))), ''); 
      set @K_BASE_ORA_STAT = 'ese.2.10';
   end
   else begin
      set @K_BASE_ORA_STAT = 'Err.es.1';
   end
   update BASE
         set
            BASE.DATA_STAT  = @K_BASE_DATA_STAT,
            BASE.ORA_STAT   = @K_BASE_ORA_STAT;
   update BASE_STAT
         set dataora_end = @k_datetime
            ,esito = rtrim(ltrim(@k_rc))
            ,x_datins = @k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = @k_id_step;


-- STEP 2 --------------------------------------------------------------------------------------------   
	set @k_datetime = getdate();
   --call u_m2000_get_datetime() returning @k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
	set @k_id_step = 2;
	select @k_appo = id_step 
		  from BASE_STAT
		 where id_base = 'A'
            and id_step = @k_id_step;
	if @k_appo != @k_id_step or @k_appo is null begin
		insert into BASE_STAT  (
            id_base 
            ,id_step
            ,step_descr
            ,dataora_start
            ,dataora_end
            ,esito
            ,x_datins
            ,x_utente
         )
         values(
            'A'
            ,@k_id_step
            ,'insert S_ARMO_N'
            ,@k_datetime
            ,''
            ,'In esecuzione....'
            ,@k_datetime
            ,'batch'         
         );
	end
	else begin
		if @@ERROR >= 0 begin
			update BASE_STAT
				set id_base = 'A'
				   ,id_step = @k_id_step
				   ,step_descr = 'insert S_ARMO_N'
				   ,dataora_start = @k_datetime
				   ,dataora_end = null
				   ,esito ='In esecuzione....'
				   ,x_datins = @k_datetime
				   ,x_utente = 'batch'
			 where id_base = 'A'
			   and id_step = @k_id_step;
		end
		else begin
			set @k_status = 'Ko! Insert BASE_STAT id_step: ' + isnull(@k_id_step, '');
			goto FORZA_FINE;
		end
	end
   
-- Step 2: carica S_ARMO_N            
	if left(@k_rc,2) = 'Ok' begin
		EXEC [dbo].[u_m2000_2_s_armo] @k_rc = @k_status OUTPUT 
		--call u_m2000_2_s_armo() returning @k_rc;
	end
	else begin
		goto FORZA_FINE;
	end
   --call u_m2000_get_datetime() returning @k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
	set @k_datetime = getdate();

-- Aggiorna BASE
	if left(@k_rc,2) = 'Ok' begin
		set @K_BASE_ORA_STAT = 'ese.3.10';
	end
	else begin
		set @K_BASE_ORA_STAT = 'Err.es.2';
	end
	update BASE
         set
            BASE.DATA_STAT  = @K_BASE_DATA_STAT,
            BASE.ORA_STAT   = @K_BASE_ORA_STAT;
	update BASE_STAT
         set dataora_end = @k_datetime
            ,esito = rtrim(ltrim(@k_rc))
            ,x_datins = @k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = @k_id_step;
            
-- STEP 3 --------------------------------------------------------------------------------------------   
	set @k_datetime = getdate();
   --call u_m2000_get_datetime() returning @k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
	set @k_id_step = 3;
	select @k_appo = id_step 
		  from BASE_STAT
		where id_base = 'A'
		     and id_step = @k_id_step;
	if @k_appo != @k_id_step or @k_appo is null begin
		insert into BASE_STAT  (
            id_base 
            ,id_step
            ,step_descr
            ,dataora_start
            ,dataora_end
            ,esito
            ,x_datins
            ,x_utente
         )
         values(
            'A'
            ,@k_id_step
            ,'crea S_MECA_N'
            ,@k_datetime
            ,''
            ,'In esecuzione....'
            ,@k_datetime
            ,'batch'         
         );
	end
	else begin
		if @@ERROR >= 0 begin
			update BASE_STAT
				set id_base = 'A'
				   ,id_step = @k_id_step
				   ,step_descr = 'crea S_MECA_N'
				   ,dataora_start = @k_datetime
				   ,dataora_end = null
				   ,esito ='In esecuzione....'
				   ,x_datins = @k_datetime
				   ,x_utente = 'batch'
			 where id_base = 'A'
			   and id_step = @k_id_step;
		end
		else begin
			set @k_status = 'Ko! Insert BASE_STAT id_step: ' + isnull(@k_id_step, '');
			goto FORZA_FINE;
		end
	end

-- Step 3: crea S_MECA_N            
	if left(@k_rc,2) = 'Ok' begin
		EXEC [dbo].[u_m2000_3_cr_tab_s_meca] @k_rc = @k_status OUTPUT 
		--call u_m2000_3_cr_tab_s_meca () returning @k_rc;
	end
	else begin
		goto FORZA_FINE;
	end
	set @k_datetime = getdate();
    --call u_m2000_get_datetime() returning @k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
	if left(@k_rc,2) = 'Ok' begin
		set @k_rc_tot = isnull(@k_rc_tot, '') + ' ' + isnull(rtrim(ltrim(substring(@k_rc,3,97))), ''); 
		set @K_BASE_ORA_STAT = 'ese.4.10';
	end
	else begin
		set @K_BASE_ORA_STAT = 'Err.es.3';
	end
	update BASE
         set
            BASE.DATA_STAT  = @K_BASE_DATA_STAT,
            BASE.ORA_STAT   = @K_BASE_ORA_STAT;
	update BASE_STAT
         set dataora_end = @k_datetime
            ,esito = rtrim(ltrim(@k_rc))
            ,x_datins = @k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = @k_id_step;
            
-- STEP 4 --------------------------------------------------------------------------------------------   
	set @k_datetime = getdate();
	--call u_m2000_get_datetime() returning @k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
	set @k_id_step = 4;
	select @k_appo = id_step 
		  from BASE_STAT
		 where id_base = 'A'
            and id_step = @k_id_step;
	if @k_appo != @k_id_step or @k_appo is null begin
		insert into BASE_STAT  (
            id_base 
            ,id_step
            ,step_descr
            ,dataora_start
            ,dataora_end
            ,esito
            ,x_datins
            ,x_utente
         )
         values(
            'A'
            ,@k_id_step
            ,'insert S_MECA_N'
            ,@k_datetime
            ,''
            ,'In esecuzione....'
            ,@k_datetime
            ,'batch'         
         );
	end
	else begin
		if @@ERROR >= 0 begin
			update BASE_STAT
            set id_base = 'A'
               ,id_step = @k_id_step
               ,step_descr = 'insert S_MECA_N'
               ,dataora_start = @k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = @k_datetime
               ,x_utente = 'batch'
           where id_base = 'A'
             and id_step = @k_id_step;
		end
		else begin
			set @k_status = 'Ko! Insert BASE_STAT id_step: ' + isnull(@k_id_step, '');
			goto FORZA_FINE;
		end
	end
-- Step 4: carica S_MECA_N            
	if left(@k_rc,2) = 'Ok' begin
      	EXEC [dbo].[u_m2000_4_s_meca] @k_rc = @k_status OUTPUT 
		--call u_m2000_4_s_meca () returning @k_rc;
	end
	else begin
		goto FORZA_FINE;
	end
	set @k_datetime = getdate();
    --call u_m2000_get_datetime() returning @k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
	if left(@k_rc,2) = 'Ok' begin
		set @k_rc_tot = isnull(@k_rc_tot, '') + ' ' + isnull(rtrim(ltrim(substring(@k_rc,3,97))), ''); 
		set @K_BASE_ORA_STAT = 'ese.5.10';
	end
	else begin
		set @K_BASE_ORA_STAT = 'Err.es.4';
	end
	update BASE
         set
            BASE.DATA_STAT  = @K_BASE_DATA_STAT,
            BASE.ORA_STAT   = @K_BASE_ORA_STAT;
	update BASE_STAT
         set dataora_end = @k_datetime
            ,esito = rtrim(ltrim(@k_rc))
            ,x_datins = @k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = @k_id_step;
            
-- STEP 5 --------------------------------------------------------------------------------------------   
	set @k_datetime = getdate();
	--call u_m2000_get_datetime() returning @k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
	set @k_id_step = 5;
	select @k_appo = id_step 
      from BASE_STAT
      where id_base = 'A'
            and id_step = @k_id_step;
	if @k_appo != @k_id_step or @k_appo is null begin
		insert into BASE_STAT  (
            id_base 
            ,id_step
            ,step_descr
            ,dataora_start
            ,dataora_end
            ,esito
            ,x_datins
            ,x_utente
         )
         values(
            'A'
            ,@k_id_step
            ,'crea S_ARTR_N'
            ,@k_datetime
            ,''
            ,'In esecuzione....'
            ,@k_datetime
            ,'batch'         
         );
	end
	else begin
		if @@ERROR >= 0 begin
			update BASE_STAT
            set id_base = 'A'
               ,id_step = @k_id_step
               ,step_descr = 'crea S_ARTR_N'
               ,dataora_start = @k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = @k_datetime
               ,x_utente = 'batch'
			where id_base = 'A'
				and id_step = @k_id_step;
		end
		else begin
			set @k_status = 'Ko! Insert BASE_STAT id_step: ' + isnull(@k_id_step, '');
			goto FORZA_FINE;
		end
	end
-- Step 5: crea S_ARTR_N            
	if left(@k_rc,2) = 'Ok' begin
      	EXEC [dbo].[u_m2000_5_cr_tab_s_artr] @k_rc = @k_status OUTPUT 
		--call u_m2000_5_cr_tab_s_artr () returning @k_rc;
	end
	else begin
		goto FORZA_FINE;
	end
	set @k_datetime = getdate();
    --call u_m2000_get_datetime() returning @k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
	if left(@k_rc,2) = 'Ok' begin
		set @k_rc_tot = isnull(@k_rc_tot, '') + ' ' + isnull(rtrim(ltrim(substring(@k_rc,3,97))), ''); 
		set @K_BASE_ORA_STAT = 'ese.6.10';
	end
	else begin
		set @K_BASE_ORA_STAT = 'Err.es.5';
	end
	update BASE
         set
            BASE.DATA_STAT  = @K_BASE_DATA_STAT,
            BASE.ORA_STAT   = @K_BASE_ORA_STAT;
	update BASE_STAT
         set dataora_end = @k_datetime
            ,esito = rtrim(ltrim(@k_rc))
            ,x_datins = @k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = @k_id_step;
            
-- STEP 6 --------------------------------------------------------------------------------------------   
	set @k_datetime = getdate();
	--call u_m2000_get_datetime() returning @k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   set @k_id_step = 6;
   select @k_appo = id_step 
      from BASE_STAT
      where id_base = 'A'
            and id_step = @k_id_step;
   if @k_appo != @k_id_step or @k_appo is null begin
      insert into BASE_STAT  (
            id_base 
            ,id_step
            ,step_descr
            ,dataora_start
            ,dataora_end
            ,esito
            ,x_datins
            ,x_utente
         )
         values(
            'A'
            ,@k_id_step
            ,'insert S_ARTR_N'
            ,@k_datetime
            ,''
            ,'In esecuzione....'
            ,@k_datetime
            ,'batch'         
         );
   end
   else begin
      if @@ERROR >= 0 begin
         update BASE_STAT
            set id_base = 'A'
               ,id_step = @k_id_step
               ,step_descr = 'insert S_ARTR_N'
               ,dataora_start = @k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = @k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = @k_id_step;
      end
      else begin
         set @k_status = 'Ko! Insert BASE_STAT id_step: ' + isnull(@k_id_step, '');
         goto FORZA_FINE;
      end
   end
-- Step 6: carica S_ARTR_N            
   if left(@k_rc,2) = 'Ok' begin
      	EXEC [dbo].[u_m2000_6_s_artr] @k_rc = @k_status OUTPUT 
		--call u_m2000_6_s_artr() returning @k_rc;
	end
	else begin
		goto FORZA_FINE;
	end
	set @k_datetime = getdate();
   --call u_m2000_get_datetime() returning @k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
	if left(@k_rc,2) = 'Ok' begin
		set @k_rc_tot = isnull(@k_rc_tot, '') + ' ' + isnull(rtrim(ltrim(substring(@k_rc,3,97))), ''); 
		set @K_BASE_ORA_STAT = 'ese.7.10';
	end
	else begin
		set @K_BASE_ORA_STAT = 'Err.es.6';
	end
	update BASE
         set
            BASE.DATA_STAT  = @K_BASE_DATA_STAT,
            BASE.ORA_STAT   = @K_BASE_ORA_STAT;
	update BASE_STAT
         set dataora_end = @k_datetime
            ,esito = rtrim(ltrim(@k_rc))
            ,x_datins = @k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = @k_id_step;
            
-- STEP 7 --------------------------------------------------------------------------------------------   
	set @k_datetime = getdate();
   --call u_m2000_get_datetime() returning @k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
	set @k_id_step = 7;
	select @k_appo = id_step 
      from BASE_STAT
      where id_base = 'A'
            and id_step = @k_id_step;
	if @k_appo != @k_id_step or @k_appo is null begin
		insert into BASE_STAT  (
            id_base 
            ,id_step
            ,step_descr
            ,dataora_start
            ,dataora_end
            ,esito
            ,x_datins
            ,x_utente
         )
         values(
            'A'
            ,@k_id_step
            ,'crea S_ARFA_N'
            ,@k_datetime
            ,''
            ,'In esecuzione....'
            ,@k_datetime
            ,'batch'         
         );
	end
	else begin
		if @@ERROR >= 0 begin
			update BASE_STAT
				set id_base = 'A'
				   ,id_step = @k_id_step
				   ,step_descr = 'crea S_ARFA_N'
				   ,dataora_start = @k_datetime
				   ,dataora_end = null
				   ,esito ='In esecuzione....'
				   ,x_datins = @k_datetime
				   ,x_utente = 'batch'
			 where id_base = 'A'
			   and id_step = @k_id_step;
		end
		else begin
			set @k_status = 'Ko! Insert BASE_STAT id_step: ' + isnull(@k_id_step, '');
			goto FORZA_FINE;
		end
	end
-- Step 7: crea S_ARFA_N            
	if left(@k_rc,2) = 'Ok' begin
      	EXEC [dbo].[u_m2000_7_cr_tab_s_arfa] @k_rc = @k_status OUTPUT 
		--call u_m2000_7_cr_tab_s_arfa() returning @k_rc;
	end
	else begin
		goto FORZA_FINE;
	end
	set @k_datetime = getdate();
	--call u_m2000_get_datetime() returning @k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
	if left(@k_rc,2) = 'Ok' begin
		set @k_rc_tot = isnull(@k_rc_tot, '') + ' ' + isnull(rtrim(ltrim(substring(@k_rc,3,97))), ''); 
		set @K_BASE_ORA_STAT = 'ese.8.10';
	end
	else begin
		set @K_BASE_ORA_STAT = 'Err.es.7';
	end
	update BASE
         set
            BASE.DATA_STAT  = @K_BASE_DATA_STAT,
            BASE.ORA_STAT   = @K_BASE_ORA_STAT;
	update BASE_STAT
         set dataora_end = @k_datetime
            ,esito = rtrim(ltrim(@k_rc))
            ,x_datins = @k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = @k_id_step;
            
-- STEP 8 --------------------------------------------------------------------------------------------   
	set @k_datetime = getdate();
	--call u_m2000_get_datetime() returning @k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
	set @k_id_step = 8;
	select @k_appo = id_step 
      from BASE_STAT
      where id_base = 'A'
            and id_step = @k_id_step;
	if @k_appo != @k_id_step or @k_appo is null begin
		insert into BASE_STAT  (
            id_base 
            ,id_step
            ,step_descr
            ,dataora_start
            ,dataora_end
            ,esito
            ,x_datins
            ,x_utente
         )
         values(
            'A'
            ,@k_id_step
            ,'insert S_ARFA_N'
            ,@k_datetime
            ,''
            ,'In esecuzione....'
            ,@k_datetime
            ,'batch'         
         );
	end
	else begin
		if @@ERROR >= 0 begin
			update BASE_STAT
				set id_base = 'A'
				   ,id_step = @k_id_step
				   ,step_descr = 'insert S_ARFA_N'
				   ,dataora_start = @k_datetime
				   ,dataora_end = null
				   ,esito ='In esecuzione....'
				   ,x_datins = @k_datetime
				   ,x_utente = 'batch'
			 where id_base = 'A'
			   and id_step = @k_id_step;
		end
		else begin
			set @k_status = 'Ko! Insert BASE_STAT id_step: ' + isnull(@k_id_step, '');
			goto FORZA_FINE;
		end
	end
-- Step 8: carica S_ARFA_N            
	if left(@k_rc,2) = 'Ok' begin
      	EXEC [dbo].[u_m2000_8_s_arfa] @k_rc = @k_status OUTPUT 
	    --call u_m2000_8_s_arfa() returning @k_rc;
	end
	else begin
		goto FORZA_FINE;
	end
	set @k_datetime = getdate();
	--call u_m2000_get_datetime() returning @k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
	if left(@k_rc,2) = 'Ok' begin
		set @k_rc_tot = isnull(@k_rc_tot, '') + ' ' + isnull(rtrim(ltrim(substring(@k_rc,3,97))), ''); 
		set @K_BASE_ORA_STAT = 'ese.9.10';
	end
	else begin
		set @K_BASE_ORA_STAT = 'Err.es.8';
	end
	update BASE
         set
            BASE.DATA_STAT  = @K_BASE_DATA_STAT,
            BASE.ORA_STAT   = @K_BASE_ORA_STAT;
	update BASE_STAT
         set dataora_end = @k_datetime
            ,esito = rtrim(ltrim(@k_rc))
            ,x_datins = @k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = @k_id_step;
            
-- STEP 9 --------------------------------------------------------------------------------------------   
	set @k_datetime = getdate();
	--call u_m2000_get_datetime() returning @k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
	set @k_id_step = 9;
	select @k_appo = id_step 
      from BASE_STAT
      where id_base = 'A'
            and id_step = @k_id_step;
	if @k_appo != @k_id_step or @k_appo is null begin
		insert into BASE_STAT  (
            id_base 
            ,id_step
            ,step_descr
            ,dataora_start
            ,dataora_end
            ,esito
            ,x_datins
            ,x_utente
         )
         values(
            'A'
            ,@k_id_step
            ,'crea S_ARSP_N'
            ,@k_datetime
            ,''
            ,'In esecuzione....'
            ,@k_datetime
            ,'batch'         
         );
	end
	else begin
		if @@ERROR >= 0 begin
			update BASE_STAT
            set id_base = 'A'
               ,id_step = @k_id_step
               ,step_descr = 'crea S_ARSP_N'
               ,dataora_start = @k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = @k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = @k_id_step;
		end
		else begin
			set @k_status = 'Ko! Insert BASE_STAT id_step: ' + isnull(@k_id_step, '');
			goto FORZA_FINE;
		end
	end
-- Step 9: crea S_ARSP_N            
	if left(@k_rc,2) = 'Ok' begin
      	EXEC [dbo].[u_m2000_9_cr_tab_s_arsp] @k_rc = @k_status OUTPUT 
		--call u_m2000_9_cr_tab_s_arsp() returning @k_rc;
	end
	else begin
		goto FORZA_FINE;
	end
	set @k_datetime = getdate();
	--call u_m2000_get_datetime() returning @k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
	if left(@k_rc,2) = 'Ok' begin
		set @k_rc_tot = isnull(@k_rc_tot, '') + ' ' + isnull(rtrim(ltrim(substring(@k_rc,3,97))), ''); 
		set @K_BASE_ORA_STAT = '*es.10.10';
	end
	else begin
		set @K_BASE_ORA_STAT = 'Err.es.9';
	end
	update BASE
         set
            BASE.DATA_STAT  = @K_BASE_DATA_STAT,
            BASE.ORA_STAT   = @K_BASE_ORA_STAT;
	update BASE_STAT
         set dataora_end = @k_datetime
            ,esito = rtrim(ltrim(@k_rc))
            ,x_datins = @k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = @k_id_step;

            
-- STEP 10 --------------------------------------------------------------------------------------------   
	set @k_datetime = getdate();
	--call u_m2000_get_datetime() returning @k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
	set @k_id_step = 10;
	select @k_appo = id_step 
      from BASE_STAT
      where id_base = 'A'
            and id_step = @k_id_step;
	if @k_appo != @k_id_step or @k_appo is null begin
		insert into BASE_STAT  (
            id_base 
            ,id_step
            ,step_descr
            ,dataora_start
            ,dataora_end
            ,esito
            ,x_datins
            ,x_utente
         )
         values(
            'A'
            ,@k_id_step
            ,'insert S_ARSP_N'
            ,@k_datetime
            ,''
            ,'In esecuzione....'
            ,@k_datetime
            ,'batch'         
         );
	end
	else begin
		if @@ERROR >= 0 begin
			update BASE_STAT
            set id_base = 'A'
               ,id_step = @k_id_step
               ,step_descr = 'insert S_ARSP_N'
               ,dataora_start = @k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = @k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = @k_id_step;
		end
		else begin
			set @k_status = 'Ko! Insert BASE_STAT id_step: ' + isnull(@k_id_step, '');
			goto FORZA_FINE;
		end
	end
-- Step 10: carica S_ARSP_N            
	if left(@k_rc,2) = 'Ok' begin
      	EXEC [dbo].[u_m2000_10_s_arsp] @k_rc = @k_status OUTPUT 
		--call u_m2000_10_s_arsp() returning @k_rc;
	end
	else begin
		goto FORZA_FINE;
	end
	set @k_datetime = getdate();
	--call u_m2000_get_datetime() returning @k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
	update BASE_STAT
         set dataora_end = @k_datetime
            ,esito = rtrim(ltrim(@k_rc))
            ,x_datins = @k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = @k_id_step;
   
-- Errore durante estrazione se != 0
	if left(@k_rc,2) = 'Ok' begin
		set @k_rc_tot = isnull(@k_rc_tot, '') + ' ' + isnull(rtrim(ltrim(substring(@k_rc,3,97))), ''); 
		set @K_BASE_ORA_STAT = getdate(); --hour to second;
      --let K_BASE_ORA_STAT = hour(today) || ':' || MINUTE(today);
	end
	else begin
		set @K_BASE_ORA_STAT = 'Errore*';
	end
	set @K_BASE_DATA_STAT   = getdate();
	update BASE
         set
            BASE.DATA_STAT  = @K_BASE_DATA_STAT,
            BASE.ORA_STAT   = @K_BASE_ORA_STAT;


            
	goto OK;

   
FORZA_FINE:
   --BEGIN 
    --  ON EXCEPTION END EXCEPTION WITH RESUME;
     -- rollback;
   --END
   goto FINE;

OK:
   --BEGIN 
    --  ON EXCEPTION END EXCEPTION WITH RESUME;
    --  commit;
   --END
   --DD-MM-YYYY = convert(varchar(08), @K_BASE_DATA_STAT, 105)
   set @k_status = 'Ok estrazione statistici terminata alle ' + ISNULL(@K_BASE_ORA_STAT, '') + ' del ' + isnull(convert(varchar(08), @K_BASE_DATA_STAT, 105), '') + ' id_step ' + isnull(@k_id_step, '') + ': ' + isnull(@k_rc_tot, ''); 


FINE:
   --trace off;
               
               
   --return @k_status ;


end 
;
               