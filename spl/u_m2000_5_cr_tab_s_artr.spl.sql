---------------------------------------------------------------
--- Tabella Trattamenti
---------------------------------------------------------------
--CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
DROP FUNCTION u_m2000_5_cr_tab_s_artr();
CREATE FUNCTION u_m2000_5_cr_tab_s_artr()
  RETURNING VARCHAR(100);

  
   define k_status varchar(100);
     
   --set debug file to '.\m2000_nt.trace.txt';
   --trace on;
     
   --whenever error continue;
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
   --lock table informix.s_meca_n in exclusive mode; 
      drop view informix.s_artr;
      drop table informix.s_artr_n;
   END
-- solo per INFORMIX 12.10
--create table informix.s_artr as select * from informix.s_artr_p;

   --begin work;

--- x informix vecchi
   create table informix.s_artr_n
       (
        id_armo         integer,
        id_meca         integer,
        data_lav_fin    date,
        colli_trattati  decimal(09,0),
        colli_entrati   decimal(09,0),
        colli_fatturati decimal(09,0),
        colli_armo_fatt decimal(09,0),
        m_cubi          decimal(12,2),
        pedane          decimal(12,2),
        giri_f1_pl      integer,
        giri_f1_lav     integer,
        giri_f2_pl      integer,
        giri_f2_lav     integer,
        giri_f1_pl_gp      integer,
        giri_f1_lav_gp     integer,
        giri_f2_pl_gp      integer,
        giri_f2_lav_gp     integer,
        imp_x_collo     decimal(15,2),
        OCCUP_PED    integer,
         importo_girif1   decimal(15,2),
         importo_girif2   decimal(15,2),
         importo_giri   decimal(15,2),
         nr_pedane      integer
      , colli_F1_PL     integer
      , colli_F2_PL     integer
      , colli_F1_LAV     integer
      , colli_F2_LAV     integer
      , colli_F1_PL_GP     integer
      , colli_F2_PL_GP     integer
      , colli_F1_LAV_GP     integer
      , colli_F2_LAV_GP     integer
       );
   if sqlcode < 0 then
      let k_status = '(u_m2000_5_cr_tab_s_artr)  Errore in  create table informix.s_artr_n  sqlcode' || sqlcode;
      goto FORZA_FINE;
   end if


   CREATE VIEW informix.s_artr AS 
      SELECT * 
         FROM informix.s_artr_n
      union all
      SELECT * 
         FROM informix.s_artr_p;

   if sqlcode < 0 then
      let k_status = '(u_m2000_5_cr_tab_s_artr)  Errore in  CREATE VIEW informix.s_artr  sqlcode' || sqlcode;
      goto FORZA_FINE;
   end if
--   INSERT INTO informix.s_artr SELECT * FROM informix.s_artr_p;


   revoke all on informix.s_artr_n from public;
   grant all on "informix".s_artr_n to "ixuser" as "informix";
   revoke all on informix.s_artr from public;
   grant all on "informix".s_artr to "ixuser" as "informix";


    goto OK;

<<FORZA_FINE>>
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
      rollback;
   END
   goto FINE;

<<OK>>
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
      commit;
   END
   let k_status = 'Ok operazione conclusa, create Table s_artr_n e View  s_artr' ;

<<FINE>>
   --trace off;

   return K_STATUS ;


end function
; 
                                    