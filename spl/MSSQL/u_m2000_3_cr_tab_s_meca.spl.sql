---------------------------------------------------------------
--- Tabella link ID-MECA e ID-ARMO
---------------------------------------------------------------
USE [sterigenics270P]
GO

/****** Object:  StoredProcedure [dbo].[u_m2000_3_cr_tab_s_meca]    Script Date: 09/04/2018 15:57:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[u_m2000_3_cr_tab_s_meca] @k_status varchar(100) OUTPUT
as
BEGIN

 
--   declare @k_status varchar(100);
     
   --set debug file to '.m2000_nt.trace.txt';
   --trace on;
     
   --whenever error continue;
   --BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
   --lock table informix.s_meca_n in exclusive mode; 
      drop view IF EXISTS dbo.s_meca;
      drop table IF EXISTS dbo.s_meca_n;
   --END

--- solo per INFORMIX 12.10
--create table informix.s_meca as select * from informix.s_meca_p;

-- x informix vecchi
   create table dbo.s_meca_n
       (
        id_meca         integer,
        id_armo         integer
       );
   if @@ERROR < 0 begin
      set @k_status = '(u_m2000_3_cr_tab_s_meca)  Errore in create table informix.s_meca_n sqlcode' + isnull(@@ERROR, '');
      --rollback;
      goto FORZA_FINE;
   end
   --commit;

   exec ('CREATE VIEW dbo.s_meca AS 
      SELECT * 
         FROM dbo.s_meca_n');
--      union all
--      SELECT * 
--         FROM informix.s_meca_p;

   if @@ERROR < 0 begin
      set @k_status = '(u_m2000_3_cr_tab_s_meca)  Errore in  CREATE VIEW informix.s_meca  sqlcode' + isnull(@@ERROR, '');
      --BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
      --   rollback;
      --END
      goto FORZA_FINE;
   end

--INSERT INTO informix.s_meca SELECT * FROM informix.s_meca_p;


 --  revoke all on informix.s_meca_n from public;
 --  grant all on "informix".s_meca_n to "ixuser" as "informix";
 --  revoke all on informix.s_meca from public;
 --  grant all on "informix".s_meca to "ixuser" as "informix";


    goto OK;

FORZA_FINE:
   --rollback;
   goto FINE;

OK:
   --commit;
   set @k_status = 'Ok operazione conclusa, create Table s_meca_n e View  s_meca' ;

FINE:
   --trace off;

return @k_status ;


end 
;