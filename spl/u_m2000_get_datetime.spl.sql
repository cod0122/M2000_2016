CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
--CONNECT to 'gammarad@gammarad_at1' user 'informix' using 'infoxgamma';

drop function u_m2000_get_datetime();
create function u_m2000_get_datetime() 
      returning  datetime hour to second;

   define K_DATATIME  datetime hour to second;

   SELECT
    DBINFO('utc_to_datetime', sh_curtime)
   INTO
    K_DATATIME
   FROM
      sysmaster:sysshmvals;
   --select current
    --  into K_DATATIME
     -- from systables
      --where tabname="systables";   

   return K_DATATIME;
   
end function
;