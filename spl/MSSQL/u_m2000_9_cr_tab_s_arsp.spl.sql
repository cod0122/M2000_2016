---------------------------------------------------------------
--- Tabella Spedizione
---------------------------------------------------------------
USE [sterigenics270P]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[u_m2000_9_cr_tab_s_arsp] @k_status varchar(100) OUTPUT
as
BEGIN
  
  
--   declare @k_status varchar(100);
     
   --set debug file to '.m2000_nt.trace.txt';
   --trace on;
     
   --whenever error continue;
  --EGIN ON EXCEPTION END EXCEPTION WITH RESUME
   --lock table informix.s_meca_n in exclusive mode; 
      drop view IF EXISTS dbo.s_arsp;
      drop table IF EXISTS dbo.s_arsp_n;
   --END

   
--- solo per INFORMIX 12.10
--create table informix.s_arsp_n as select * from informix.s_arsp_p;

--- x informix vecchi
   create table dbo.s_arsp_n
       (
        id_meca         integer,
        id_armo         integer,
        id_sped         integer,
        magazzino       integer,
        num_int         integer,
        data_int        date,
        num_bolla_out   integer,
        data_bolla_out  date,
        data_rit        date,
        gruppo          decimal(3,0),
        dose            decimal(7,2),
        colli           decimal(09,0),
        cub_tot         decimal(12,2),
        giri_f1_pl      integer,
        giri_f1_lav     integer,
        giri_f2_pl      integer,
        giri_f2_lav     integer,
        clie_1          integer,
        clie_2          integer,
        clie_3          integer
       );
   if @@ERROR < 0 begin
      set @k_status = '(u_m2000_9_cr_tab_s_arsp)  Errore in  create table s_arsp_n  sqlcode' + isnull(@@ERROR, '');
      --BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
       --  rollback;
      --END
      goto FORZA_FINE;
   end

   --INSERT INTO informix.s_arsp SELECT * FROM informix.s_arsp_p;


   exec('CREATE VIEW dbo.s_arsp AS 
      SELECT * 
         FROM dbo.s_arsp_n')
--      union all
--      SELECT * 
--         FROM informix.s_arsp_p;

   if @@ERROR < 0 begin
      set @k_status = '(u_m2000_9_cr_tab_s_arsp)  Errore in  CREATE VIEW s_arsp  sqlcode' + isnull(@@ERROR, '');
    --  BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
     --    rollback;
      --END
      goto FORZA_FINE;
   end

   --revoke all on informix.s_arsp_n from public;
   --grant all on "informix".s_arsp_n to "ixuser" as "informix";
   --revoke all on informix.s_arsp from public;
   --grant all on "informix".s_arsp to "ixuser" as "informix";


    goto OK;

FORZA_FINE:
   --rollback;
   goto FINE;

OK:
   --commit;
   set @k_status = 'Ok operazione conclusa, create Table s_arsp_n e View  s_arsp' ;

FINE:
   --trace off;

--return @k_status ;


end 
;
