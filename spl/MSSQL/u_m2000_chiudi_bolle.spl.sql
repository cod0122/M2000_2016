------------------------------- UTILITY CHIUDE DDT DI SPED  ---------------------------------
USE [sterigenics270P]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[u_m2000_chiudi_bolle] @k_status varchar(100) OUTPUT
as
BEGIN

--   declare @k_status varchar(100);
   declare @k_conta_righe integer, @k_colli_arfa integer, @k_colli_arsp integer, @k_num_upd_testa integer, @k_num_upd_righe integer;
   declare @K_NUM_BOLLA_OUT smallint        /* like ARSP.NUM_BOLLA_OUT */;
   declare @K_DATA_BOLLA_OUT date       /* like ARSP.DATA_BOLLA_OUT */;
   declare @K_ID_ARMO integer              /* like ARMO.ID_ARMO */;
  -- declare @k_data_start     date;
  -- declare @k_gg integer, @k_mm integer, @k_aa integer;
   declare @k_data_elab      date;
	
   --set debug file to '.m2000_nt.trace.txt';
   --trace on;
   
   set @k_num_upd_testa = 0;
   set @k_num_upd_righe = 0;
   
   --set @K_AA    = year(getdate()) - 1;
  -- set @K_MM    = month(getdate());
  -- set @K_GG    = 01; --day(today);
 --  if @k_mm > 6 begin
  --    set @k_mm = @k_mm - 6;
  -- end
  -- else begin
  --    set @k_aa = @k_aa - 1;
   --   set @k_mm = @k_mm + 6;
  -- end 
  -- set @k_data_start = DATEDIFF(day, -540, getdate()) -- mdy(@k_mm, @k_gg, @k_aa);

   set @k_data_elab = DATEADD(day, -365, getdate()) -- mdy(01,01, year(getdate()) - 1);

		
   declare c_elenco_bolle cursor for
	      select NUM_BOLLA_OUT, DATA_BOLLA_OUT 
       		  from sped
                  where DATA_BOLLA_OUT > @k_data_elab and STAMPA <> 'F';
   open c_elenco_bolle;
   fetch c_elenco_bolle into @K_NUM_BOLLA_OUT, @K_DATA_BOLLA_OUT;
   while @@fetch_status = 0 begin
	
      if @@ERROR < 0 begin
         set @k_status = '(u_m2000_chiudi_bolle) Errore in foreach c_elenco_bolle sqlcode' + isnull(@@ERROR, '');
         rollback;
         goto FORZA_FINE;
      end

      declare c_elenco_righe cursor for
	     select distinct id_armo
      		 from arsp
	       where NUM_BOLLA_OUT = @K_NUM_BOLLA_OUT
       	         and DATA_BOLLA_OUT = @K_DATA_BOLLA_OUT;
      open c_elenco_righe;
      fetch c_elenco_righe into @k_id_armo;
      while @@fetch_status = 0 begin
       --  begin work;

         if @@ERROR < 0 begin
            set @k_status = '(u_m2000_chiudi_bolle) Errore in foreach c_elenco_righe sqlcode' + isnull(@@ERROR, '');
            rollback;  
            goto FORZA_FINE;
         end

         select @k_colli_arsp = sum(colli)
           from arsp
           where id_armo = @K_ID_ARMO;
	
         if @@ERROR < 0 begin
            set @k_status = '(u_m2000_chiudi_bolle) Errore in select sum(colli) arsp sqlcode' + isnull(@@ERROR, '');
            rollback;
            goto FORZA_FINE;
         end

         set @k_colli_arfa = 0;

         select @k_colli_arfa = sum(colli)
           from arfa
           where id_armo = @K_ID_ARMO
             and (id_armo_prezzo = 0 or id_armo_prezzo is null);

         if @@ERROR < 0 begin
            set @k_status = '(u_m2000_chiudi_bolle) Errore in select sum(colli) arfa sqlcode' + isnull(@@ERROR, '');
            rollback;
            goto FORZA_FINE;
         end

         if @@ERROR > 0 or @k_colli_arfa = 0 or @k_colli_arfa is null begin

            select @k_colli_arfa = sum(colli)
              from arfa, armo_prezzi
              where arfa.id_armo = @K_ID_ARMO and arfa.id_armo_prezzo > 0
                    and arfa.id_armo_prezzo = armo_prezzi.id_armo_prezzo
                   and armo_prezzi.tipo_calcolo = 'U';

  	         if @@ERROR < 0 begin
               set @k_status = '(u_m2000_chiudi_bolle) Errore in select sum(colli) arfa e armo_prezzi sqlcode' + isnull(@@ERROR, '');
	            rollback;
	            goto FORZA_FINE;
            end
         end 

         if @@ERROR >= 0 begin

            if @k_colli_arfa = @k_colli_arsp begin

               update ARSP
                 set
                    ARSP.STAMPA = 'F'
                 where ARSP.NUM_BOLLA_OUT  = @K_NUM_BOLLA_OUT  and
                       ARSP.DATA_BOLLA_OUT = @K_DATA_BOLLA_OUT and
                       ARSP.ID_ARMO        = @K_ID_ARMO;

               if @@ERROR < 0 begin
                  set @k_status = '(u_m2000_chiudi_bolle) Errore in update ARSP sqlcode' + isnull(@@ERROR, '');
                  rollback;
   	              goto FORZA_FINE;
               end
               else begin
                  set @k_num_upd_righe = @k_num_upd_righe + 1;
               end
            end 
         end 

      fetch c_elenco_righe into @k_id_armo;
      end
      close c_elenco_righe;
      deallocate c_elenco_righe;

      set @k_conta_righe = 0;
      select @k_conta_righe = count(*)
            from arsp
            where  ARSP.STAMPA          <> 'F'
                   and ARSP.NUM_BOLLA_OUT  = @K_NUM_BOLLA_OUT
                   and ARSP.DATA_BOLLA_OUT = @K_DATA_BOLLA_OUT ;

	  if @@ERROR < 0 begin
         set @k_status = '(u_m2000_chiudi_bolle) Errore in select count(*)  arsp sqlcode' + isnull(@@ERROR, '');
         rollback;
   	     goto FORZA_FINE;
      end

      if @k_conta_righe = 0 begin
         update SPED
           set
              STAMPA = 'F'
           where NUM_BOLLA_OUT  = @K_NUM_BOLLA_OUT  and
                 DATA_BOLLA_OUT = @K_DATA_BOLLA_OUT ;
         if @@ERROR < 0 begin
            set @k_status = '(u_m2000_chiudi_bolle) Errore in update SPED sqlcode' + isnull(@@ERROR, '');
            rollback;
            goto FORZA_FINE;
         end
         else begin
            set @k_num_upd_testa = @k_num_upd_testa + 1;
         end
      end 

      commit;
   fetch c_elenco_bolle into @K_NUM_BOLLA_OUT, @K_DATA_BOLLA_OUT;
   end
   close c_elenco_bolle;
   deallocate c_elenco_bolle;

   if @@ERROR != 0 begin
      set @K_STATUS = 'Errore sqlcode' + isnull(@@ERROR, '');
   end 

   goto OK;

FORZA_FINE:
   goto FINE;

OK:
   set @k_status = 'Ok operazione conclusa, aggiornate ' + isnull(@k_num_upd_righe, '') + ' righe e ' + isnull(@k_num_upd_testa, '') + ' testate.';

FINE:
   --trace off;

--return @k_status ;

end 
 ;                     
