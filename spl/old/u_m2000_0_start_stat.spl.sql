drop function u_m2000_0_start_stat();
create function u_m2000_0_start_stat() 
      returning lvarchar(1000);

   define K_BASE_DATA_STAT like BASE.DATA_STAT;
   define K_BASE_ORA_STAT like BASE.ORA_STAT;
   define k_status lvarchar(1000);
   define k_rc varchar(100);
   define k_rc_tot lvarchar(1000);
   define k_datetime datetime hour to second;
   define k_id_step, k_appo integer;

   
   let k_rc_tot = '';
   let K_BASE_DATA_STAT   = today;
   let K_BASE_ORA_STAT    = 'IN ESEC.';
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;
            
-- STEP 1 --------------------------------------------------------------------------------------------   
   let k_datetime         = current;
   let k_id_step = 1;
   select id_step 
      into k_appo 
      from BASE_STAT
      where id_base = 'A'
            and id_step = k_id_step;
   if k_appo != k_id_step or k_appo is null then
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
            ,k_id_step
            ,'crea S_ARMO_N'
            ,k_datetime
            ,''
            ,'In esecuzione....'
            ,k_datetime
            ,'batch'         
         );
   --let k_status = 'DBG Insert BASE_STAT id_step: ' || k_id_step || ' sqlcode: ' || sqlcode;
   --goto FORZA_FINE;
   else
      if sqlcode >= 0 then
         update BASE_STAT
            set id_base = 'A'
               ,id_step = k_id_step
               ,step_descr = 'crea S_ARMO_N'
               ,dataora_start = k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = k_datetime
               ,x_utente = 'batch'
            where id_base = 'A'
               and id_step = k_id_step;
      else
         let k_status = 'Ko! Insert BASE_STAT id_step: ' || k_id_step;
         goto FORZA_FINE;
      end if
   end if

-- Step 1: crea S_ARMO_N            
   call u_m2000_1_cr_tab_s_armo() returning k_rc;
   if left(k_rc,2) = 'Ok' then
      let k_rc_tot = trim(substr(k_rc,3,97));
   end if
   let K_BASE_DATA_STAT   = today;
   --let k_datetime1 = sysdate;
   --let k_datetime1 = TO_DATE("2016-01-01 10:10:55","%Y-%m-%d %H:%M:%S"); 
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
-- Aggiorna BASE
   if left(k_rc,2) = 'Ok' then
      let k_rc_tot = k_rc_tot || ' ' || trim(substr(k_rc,3,97)); 
      let K_BASE_ORA_STAT = 'ese.2.10';
   else
      let K_BASE_ORA_STAT = 'Err.es.1';
   end if
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;
   update BASE_STAT
         set dataora_end = k_datetime
            ,esito = trim(k_rc)
            ,x_datins = k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;


-- STEP 2 --------------------------------------------------------------------------------------------   
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   let k_id_step = 2;
   select id_step 
      into k_appo 
      from BASE_STAT
      where id_base = 'A'
            and id_step = k_id_step;
   if k_appo != k_id_step or k_appo is null then
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
            ,k_id_step
            ,'insert S_ARMO_N'
            ,k_datetime
            ,''
            ,'In esecuzione....'
            ,k_datetime
            ,'batch'         
         );
   else
      if sqlcode >= 0 then
         update BASE_STAT
            set id_base = 'A'
               ,id_step = k_id_step
               ,step_descr = 'insert S_ARMO_N'
               ,dataora_start = k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
      else
         let k_status = 'Ko! Insert BASE_STAT id_step: ' || k_id_step;
         goto FORZA_FINE;
      end if
   end if
   
-- Step 2: carica S_ARMO_N            
   if left(k_rc,2) = 'Ok' then
      call u_m2000_2_s_armo() returning k_rc;
   else
      goto FORZA_FINE;
   end if
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
   if left(k_rc,2) = 'Ok' then
      let K_BASE_ORA_STAT = 'ese.3.10';
   else
      let K_BASE_ORA_STAT = 'Err.es.2';
   end if
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;
   update BASE_STAT
         set dataora_end = k_datetime
            ,esito = trim(k_rc)
            ,x_datins = k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
            
-- STEP 3 --------------------------------------------------------------------------------------------   
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   let k_id_step = 3;
   select id_step 
      into k_appo 
      from BASE_STAT
      where id_base = 'A'
            and id_step = k_id_step;
   if k_appo != k_id_step or k_appo is null then
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
            ,k_id_step
            ,'crea S_MECA_N'
            ,k_datetime
            ,''
            ,'In esecuzione....'
            ,k_datetime
            ,'batch'         
         );
   else
      if sqlcode >= 0 then
         update BASE_STAT
            set id_base = 'A'
               ,id_step = k_id_step
               ,step_descr = 'crea S_MECA_N'
               ,dataora_start = k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
      else
         let k_status = 'Ko! Insert BASE_STAT id_step: ' || k_id_step;
         goto FORZA_FINE;
      end if
   end if

-- Step 3: crea S_MECA_N            
   if left(k_rc,2) = 'Ok' then
      call u_m2000_3_cr_tab_s_meca () returning k_rc;
   else
      goto FORZA_FINE;
   end if
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
   if left(k_rc,2) = 'Ok' then
      let k_rc_tot = k_rc_tot || ' ' || trim(substr(k_rc,3,97)); 
      let K_BASE_ORA_STAT = 'ese.4.10';
   else
      let K_BASE_ORA_STAT = 'Err.es.3';
   end if
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;
   update BASE_STAT
         set dataora_end = k_datetime
            ,esito = trim(k_rc)
            ,x_datins = k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
            
-- STEP 4 --------------------------------------------------------------------------------------------   
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   let k_id_step = 4;
   select id_step 
      into k_appo 
      from BASE_STAT
      where id_base = 'A'
            and id_step = k_id_step;
   if k_appo != k_id_step or k_appo is null then
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
            ,k_id_step
            ,'insert S_MECA_N'
            ,k_datetime
            ,''
            ,'In esecuzione....'
            ,k_datetime
            ,'batch'         
         );
   else
      if sqlcode >= 0 then
         update BASE_STAT
            set id_base = 'A'
               ,id_step = k_id_step
               ,step_descr = 'insert S_MECA_N'
               ,dataora_start = k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
      else
         let k_status = 'Ko! Insert BASE_STAT id_step: ' || k_id_step;
         goto FORZA_FINE;
      end if
   end if
-- Step 4: carica S_MECA_N            
   if left(k_rc,2) = 'Ok' then
      call u_m2000_4_s_meca () returning k_rc;
   else
      goto FORZA_FINE;
   end if
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
   if left(k_rc,2) = 'Ok' then
      let k_rc_tot = k_rc_tot || ' ' || trim(substr(k_rc,3,97)); 
      let K_BASE_ORA_STAT = 'ese.5.10';
   else
      let K_BASE_ORA_STAT = 'Err.es.4';
   end if
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;
   update BASE_STAT
         set dataora_end = k_datetime
            ,esito = trim(k_rc)
            ,x_datins = k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
            
-- STEP 5 --------------------------------------------------------------------------------------------   
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   let k_id_step = 5;
   select id_step 
      into k_appo 
      from BASE_STAT
      where id_base = 'A'
            and id_step = k_id_step;
   if k_appo != k_id_step or k_appo is null then
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
            ,k_id_step
            ,'crea S_ARTR_N'
            ,k_datetime
            ,''
            ,'In esecuzione....'
            ,k_datetime
            ,'batch'         
         );
   else
      if sqlcode >= 0 then
         update BASE_STAT
            set id_base = 'A'
               ,id_step = k_id_step
               ,step_descr = 'crea S_ARTR_N'
               ,dataora_start = k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
      else
         let k_status = 'Ko! Insert BASE_STAT id_step: ' || k_id_step;
         goto FORZA_FINE;
      end if
   end if
-- Step 5: crea S_ARTR_N            
   if left(k_rc,2) = 'Ok' then
      call u_m2000_5_cr_tab_s_artr () returning k_rc;
   else
      goto FORZA_FINE;
   end if
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
   if left(k_rc,2) = 'Ok' then
      let k_rc_tot = k_rc_tot || ' ' || trim(substr(k_rc,3,97)); 
      let K_BASE_ORA_STAT = 'ese.6.10';
   else
      let K_BASE_ORA_STAT = 'Err.es.5';
   end if
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;
   update BASE_STAT
         set dataora_end = k_datetime
            ,esito = trim(k_rc)
            ,x_datins = k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
            
-- STEP 6 --------------------------------------------------------------------------------------------   
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   let k_id_step = 6;
   select id_step 
      into k_appo 
      from BASE_STAT
      where id_base = 'A'
            and id_step = k_id_step;
   if k_appo != k_id_step or k_appo is null then
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
            ,k_id_step
            ,'insert S_ARTR_N'
            ,k_datetime
            ,''
            ,'In esecuzione....'
            ,k_datetime
            ,'batch'         
         );
   else
      if sqlcode >= 0 then
         update BASE_STAT
            set id_base = 'A'
               ,id_step = k_id_step
               ,step_descr = 'insert S_ARTR_N'
               ,dataora_start = k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
      else
         let k_status = 'Ko! Insert BASE_STAT id_step: ' || k_id_step;
         goto FORZA_FINE;
      end if
   end if
-- Step 6: carica S_ARTR_N            
   if left(k_rc,2) = 'Ok' then
      call u_m2000_6_s_artr() returning k_rc;
   else
      goto FORZA_FINE;
   end if
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
   if left(k_rc,2) = 'Ok' then
      let k_rc_tot = k_rc_tot || ' ' || trim(substr(k_rc,3,97)); 
      let K_BASE_ORA_STAT = 'ese.7.10';
   else
      let K_BASE_ORA_STAT = 'Err.es.6';
   end if
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;
   update BASE_STAT
         set dataora_end = k_datetime
            ,esito = trim(k_rc)
            ,x_datins = k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
            
-- STEP 7 --------------------------------------------------------------------------------------------   
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   let k_id_step = 7;
   select id_step 
      into k_appo 
      from BASE_STAT
      where id_base = 'A'
            and id_step = k_id_step;
   if k_appo != k_id_step or k_appo is null then
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
            ,k_id_step
            ,'crea S_ARFA_N'
            ,k_datetime
            ,''
            ,'In esecuzione....'
            ,k_datetime
            ,'batch'         
         );
   else
      if sqlcode >= 0 then
         update BASE_STAT
            set id_base = 'A'
               ,id_step = k_id_step
               ,step_descr = 'crea S_ARFA_N'
               ,dataora_start = k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
      else
         let k_status = 'Ko! Insert BASE_STAT id_step: ' || k_id_step;
         goto FORZA_FINE;
      end if
   end if
-- Step 7: crea S_ARFA_N            
   if left(k_rc,2) = 'Ok' then
      call u_m2000_7_cr_tab_s_arfa() returning k_rc;
   else
      goto FORZA_FINE;
   end if
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
   if left(k_rc,2) = 'Ok' then
      let k_rc_tot = k_rc_tot || ' ' || trim(substr(k_rc,3,97)); 
      let K_BASE_ORA_STAT = 'ese.8.10';
   else
      let K_BASE_ORA_STAT = 'Err.es.7';
   end if
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;
   update BASE_STAT
         set dataora_end = k_datetime
            ,esito = trim(k_rc)
            ,x_datins = k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
            
-- STEP 8 --------------------------------------------------------------------------------------------   
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   let k_id_step = 8;
   select id_step 
      into k_appo 
      from BASE_STAT
      where id_base = 'A'
            and id_step = k_id_step;
   if k_appo != k_id_step or k_appo is null then
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
            ,k_id_step
            ,'insert S_ARFA_N'
            ,k_datetime
            ,''
            ,'In esecuzione....'
            ,k_datetime
            ,'batch'         
         );
   else
      if sqlcode >= 0 then
         update BASE_STAT
            set id_base = 'A'
               ,id_step = k_id_step
               ,step_descr = 'insert S_ARFA_N'
               ,dataora_start = k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
      else
         let k_status = 'Ko! Insert BASE_STAT id_step: ' || k_id_step;
         goto FORZA_FINE;
      end if
   end if
-- Step 8: carica S_ARFA_N            
   if left(k_rc,2) = 'Ok' then
      call u_m2000_8_s_arfa() returning k_rc;
   else
      goto FORZA_FINE;
   end if
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
   if left(k_rc,2) = 'Ok' then
      let k_rc_tot = k_rc_tot || ' ' || trim(substr(k_rc,3,97)); 
      let K_BASE_ORA_STAT = 'ese.9.10';
   else
      let K_BASE_ORA_STAT = 'Err.es.8';
   end if
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;
   update BASE_STAT
         set dataora_end = k_datetime
            ,esito = trim(k_rc)
            ,x_datins = k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
            
-- STEP 9 --------------------------------------------------------------------------------------------   
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   let k_id_step = 9;
   select id_step 
      into k_appo 
      from BASE_STAT
      where id_base = 'A'
            and id_step = k_id_step;
   if k_appo != k_id_step or k_appo is null then
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
            ,k_id_step
            ,'crea S_ARSP_N'
            ,k_datetime
            ,''
            ,'In esecuzione....'
            ,k_datetime
            ,'batch'         
         );
   else
      if sqlcode >= 0 then
         update BASE_STAT
            set id_base = 'A'
               ,id_step = k_id_step
               ,step_descr = 'crea S_ARSP_N'
               ,dataora_start = k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
      else
         let k_status = 'Ko! Insert BASE_STAT id_step: ' || k_id_step;
         goto FORZA_FINE;
      end if
   end if
-- Step 9: crea S_ARSP_N            
   if left(k_rc,2) = 'Ok' then
      call u_m2000_9_cr_tab_s_arsp() returning k_rc;
   else
      goto FORZA_FINE;
   end if
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo

-- Aggiorna BASE
   if left(k_rc,2) = 'Ok' then
      let k_rc_tot = k_rc_tot || ' ' || trim(substr(k_rc,3,97)); 
      let K_BASE_ORA_STAT = '*es.10.10';
   else
      let K_BASE_ORA_STAT = 'Err.es.9';
   end if
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;
   update BASE_STAT
         set dataora_end = k_datetime
            ,esito = trim(k_rc)
            ,x_datins = k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;

            
-- STEP 10 --------------------------------------------------------------------------------------------   
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   let k_id_step = 10;
   select id_step 
      into k_appo 
      from BASE_STAT
      where id_base = 'A'
            and id_step = k_id_step;
   if k_appo != k_id_step or k_appo is null then
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
            ,k_id_step
            ,'insert S_ARSP_N'
            ,k_datetime
            ,''
            ,'In esecuzione....'
            ,k_datetime
            ,'batch'         
         );
   else
      if sqlcode >= 0 then
         update BASE_STAT
            set id_base = 'A'
               ,id_step = k_id_step
               ,step_descr = 'insert S_ARSP_N'
               ,dataora_start = k_datetime
               ,dataora_end = null
               ,esito ='In esecuzione....'
               ,x_datins = k_datetime
               ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
      else
         let k_status = 'Ko! Insert BASE_STAT id_step: ' || k_id_step;
         goto FORZA_FINE;
      end if
   end if
-- Step 10: carica S_ARSP_N            
   if left(k_rc,2) = 'Ok' then
      call u_m2000_10_s_arsp() returning k_rc;
   else
      goto FORZA_FINE;
   end if
   call u_m2000_get_datetime() returning k_datetime; -- get del timestamp reale altrimenti torna sempre lo stesso tempo
   update BASE_STAT
         set dataora_end = k_datetime
            ,esito = trim(k_rc)
            ,x_datins = k_datetime
            ,x_utente = 'batch'
         where id_base = 'A'
           and id_step = k_id_step;
   
-- Errore durante estrazione se != 0
   if left(k_rc,2) = 'Ok' then
      let k_rc_tot = k_rc_tot || ' ' || trim(substr(k_rc,3,97)); 
      let K_BASE_ORA_STAT = current hour to second;
      --let K_BASE_ORA_STAT = hour(today) || ':' || MINUTE(today);
   else
      let K_BASE_ORA_STAT = 'Errore*';
   end if
   let K_BASE_DATA_STAT   = today;
   update BASE
         set
            BASE.DATA_STAT  = K_BASE_DATA_STAT,
            BASE.ORA_STAT   = K_BASE_ORA_STAT;


            
   goto OK;

   
<<FORZA_FINE>>
--   BEGIN 
--      ON EXCEPTION END EXCEPTION WITH RESUME;
      rollback;
 --  END
   goto FINE;

<<OK>>
--   BEGIN 
 --     ON EXCEPTION END EXCEPTION WITH RESUME;
      commit;
  -- END
   let k_status = 'Ok estrazione statistici terminata alle ' || K_BASE_ORA_STAT || ' del ' || to_char(K_BASE_DATA_STAT, '%d %B %Y') || ' id_step ' || k_id_step || ': ' || k_rc_tot; 


<<FINE>>
   --trace off;
               
               
   return K_STATUS ;


end function
               