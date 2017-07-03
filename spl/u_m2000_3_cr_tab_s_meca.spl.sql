---------------------------------------------------------------
--- Tabella link ID-MECA e ID-ARMO
---------------------------------------------------------------
--CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
DROP FUNCTION u_m2000_3_cr_tab_s_meca();
CREATE FUNCTION u_m2000_3_cr_tab_s_meca()
  RETURNING VARCHAR(100);

  
   define k_status varchar(100);
     
   --set debug file to '.\m2000_nt.trace.txt';
   --trace on;
     
   --whenever error continue;
   BEGIN ON EXCEPTION END EXCEPTION WITH RESUME
   --lock table informix.s_meca_n in exclusive mode; 
      drop view informix.s_meca;
      drop table informix.s_meca_n;
   END

--- solo per INFORMIX 12.10
--create table informix.s_meca as select * from informix.s_meca_p;

-- x informix vecchi
   create table informix.s_meca_n
       (
        id_meca         integer,
        id_armo         integer
       );
   if sqlcode < 0 then
      let k_status = '(u_m2000_3_cr_tab_s_meca)  Errore in create table informix.s_meca_n sqlcode' || sqlcode;
      --rollback;
      goto FORZA_FINE;
   end if
   --commit;

   CREATE VIEW informix.s_meca AS 
      SELECT * 
         FROM informix.s_meca_n;
--      union all
--      SELECT * 
--         FROM informix.s_meca_p;

   if sqlcode < 0 then
      let k_status = '(u_m2000_3_cr_tab_s_meca)  Errore in  CREATE VIEW informix.s_meca  sqlcode' || sqlcode;
      BEGIN ON EXCEPTION END EXCEPTION WITH RESUME;
         rollback;
      END
      goto FORZA_FINE;
   end if

--INSERT INTO informix.s_meca SELECT * FROM informix.s_meca_p;


   revoke all on informix.s_meca_n from public;
   grant all on "informix".s_meca_n to "ixuser" as "informix";
   revoke all on informix.s_meca from public;
   grant all on "informix".s_meca to "ixuser" as "informix";


    goto OK;

<<FORZA_FINE>>
   --rollback;
   goto FINE;

<<OK>>
   --commit;
   let k_status = 'Ok operazione conclusa, create Table s_meca_n e View  s_meca' ;

<<FINE>>
   --trace off;

return K_STATUS ;


end function
;