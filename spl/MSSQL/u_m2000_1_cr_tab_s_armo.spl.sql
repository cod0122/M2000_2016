USE [sterigenics270P]
GO

/****** Object:  StoredProcedure [dbo].[u_m2000_1_cr_tab_s_armo]    Script Date: 08/04/2018 16:36:40 ******/
DROP PROCEDURE [dbo].[u_m2000_1_cr_tab_s_armo]
GO

/****** Object:  StoredProcedure [dbo].[u_m2000_1_cr_tab_s_armo]    Script Date: 08/04/2018 16:36:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[u_m2000_1_cr_tab_s_armo] @k_status varchar(100) OUTPUT
as
BEGIN

  
   --declare @k_status varchar(100);
     
   --set debug file to '.m2000_nt.trace.txt';
   --trace on;
     
   --whenever error continue;
   BEGIN TRY
      drop view IF EXISTS dbo.s_armo;
      drop table IF EXISTS dbo.s_armo_n;
   END TRY
   BEGIN CATCH		
   END CATCH
   --whenever error goto  FORZA_FINE;

   ---- solo per INFORMIX 12.10
   --create table dbo.s_armo as select * from dbo.s_armo_p;

   ---- x informix vecchi
   create table dbo.s_armo_n
       (
        id_meca         integer,
        id_armo         integer,
        id_listino      integer,
        magazzino       integer,
        num_int         integer,
        data_int        date,
        data_ent        date,
        gruppo          decimal(3,0),
        dose            decimal(7,2),
        travaso         char(1),
        m_cubi_arsp     decimal(12,2),
        colli_1         decimal(09,0),
        colli_2         decimal(09,0),
        m_cubi          decimal(12,2),
        giri_f1_pl      integer,
        giri_f1_lav     integer,
        giri_f2_pl      integer,
        giri_f2_lav     integer,
        pedane          decimal(12,2),
        imp_fatt        decimal(15,2),
        imp_da_fatt     decimal(15,2),
        clie_1          integer,
        clie_2          integer,
        clie_3          integer,
        aperto         char(1)
       );

   if @@ERROR < 0 begin
      set @k_status = '(u_m2000_1_cr_tab_s_armo)  Errore in create table dbo.s_armo_n sqlcode' + isnull(@@ERROR, '');
      goto FORZA_FINE;
   end

   exec ('CREATE VIEW dbo.s_armo AS 
      SELECT * 
         FROM dbo.s_armo_n')
--      union all
--      SELECT * 
--         FROM dbo.s_armo_p;


   if @@ERROR < 0 begin
      set @k_status = '(u_m2000_1_cr_tab_s_armo)  Errore in  CREATE VIEW dbo.s_armo  sqlcode' + isnull(@@ERROR, '');
      rollback;
      goto FORZA_FINE;
   end


   --revoke all on dbo.s_armo_n from public;
   --revoke all on dbo.s_armo from public;
   --grant all on dbo.s_armo_n to "ixuser" as "informix";
   --grant all on dbo.s_armo to "ixuser" as "informix";

--------------------------------------------------------------------------------------------------------------------------------
-- ARCHIVIO  DI SERVIZIO PER GLI STATISTICI * ENTRATE *
-- Magazzino Magazzino di lavorazione della merce
-- Dose      Dose
-- Gruppo    Gruppo articoli
-- Travaso   Flag se travaso avvenuto impostato a 'S'
-- Colli_1   Colli entrati in bolla di entrata
-- Colli_2   Nr. colli di lavorazione in magazzino
-- M_cubi    M_Cubi effettivamente accupati dall'impianto (come sped cli)
-- Clie_1    Mandante della merce
-- Clie_2    Ricevente della bolla di uscita 
-- Clie_3    Ricevente della fattura         
--------------------------------------------------------------------------------------------------------------------------------

    goto OK;

FORZA_FINE:
   --rollback;
   goto FINE;

OK:
   --commit;
   set @k_status = 'Ok operazione conclusa, create Table s_armo_n e View  s_armo' ;

FINE:
   --trace off;

return --@k_status ;


end 
;
GO

