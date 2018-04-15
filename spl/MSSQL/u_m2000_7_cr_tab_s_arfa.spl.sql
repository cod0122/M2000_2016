------------------------------- CARICA DATI TRATTAMENTO (ARTR)  ---------------------------------
USE [sterigenics270P]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------
--- Tabella Fatturazione
---------------------------------------------------------------

CREATE PROCEDURE [dbo].[u_m2000_7_cr_tab_s_arfa] @k_status varchar(100) OUTPUT
as
BEGIN
  
--   declare @k_status varchar(100);
     
   --set debug file to '.m2000_nt.trace.txt';
   --trace on;
     
   --whenever error continue;
  -- BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
   --lock table informix.s_meca_n in exclusive mode; 
      drop view IF EXISTS dbo.s_arfa;
      drop table IF EXISTS dbo.s_arfa_n;
  -- END

   --begin work;

--- solo per INFORMIX 12.10
--create table informix.s_arfa as select * from informix.s_arfa_p;

--- x informix vecchi
   create table dbo.s_arfa_n
       (
        id_meca         integer,
        magazzino       integer,
        num_fatt        integer,
        data_fatt       date,
        num_int         integer,
        data_int        date,
        num_bolla_out   integer,
        data_bolla_out  date,
        gruppo          decimal(3,0),
        dose            decimal(7,2),
        colli           decimal(09,0),
        cub_tot         decimal(12,2),
        giri_f1_pl      integer,
        giri_f1_lav     integer,
        giri_f2_pl      integer,
        giri_f2_lav     integer,
        prezzo_t        decimal(15,2),
        clie_1          integer,
        clie_2          integer,
        clie_3          integer,
        tipo_doc        char(2)
       );
   if @@ERROR < 0 begin
      set @k_status = '(u_m2000_7_cr_tab_s_arfa)  Errore in  create table s_arfa_n  sqlcode' + isnull(@@ERROR, '');
    --  BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
    --     rollback;
    --  END
      goto FORZA_FINE;
   end

   --INSERT INTO informix.s_arfa SELECT * FROM informix.s_arfa_p;


   exec ('CREATE VIEW dbo.s_arfa AS 
      SELECT * 
         FROM dbo.s_arfa_n')
--      union all
--      SELECT * 
--         FROM informix.s_arfa_p;

   if @@ERROR < 0 begin
      set @k_status = '(u_m2000_7_cr_tab_s_arfa)  Errore in  CREATE VIEW s_arfa_n sqlcode' + isnull(@@ERROR, '');
   --   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
    --     rollback;
     -- END
      goto FORZA_FINE;
   end


   --revoke all on informix.s_arfa_n from public;
   --grant all on "informix".s_arfa_n to "ixuser" as "informix";
   --revoke all on informix.s_arfa from public;
   --grant all on "informix".s_arfa to "ixuser" as "informix";

    goto OK;

FORZA_FINE:
   --rollback;
   goto FINE;

OK:
   --commit;
   set @k_status = 'Ok operazione conclusa, create Table s_arfa_n e View  s_arfa' ;

FINE:
   --trace off;

;



---- ARCHIVIO DI SERVIZIO PER GLI STATISTICI * USCITE *
---- Dose     Dose
---- Gruppo   Gruppo articoli
---- Colli    Colli fatturati
---- Cub_tot  M_Cubi effettivamente accupati dall'impianto (come sped cli)
---- Clie_1   Mandante della merce
---- Clie_2   Cliente a cui ho spedito
---- Clie_3   Cliente di fatturazione
---- Prezzo_t Prezzo Totale
---- Tipo_doc Tipo del documento
-------------------------------------------------------------------------------------------------


end 
; 
