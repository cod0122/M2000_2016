--CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
DROP FUNCTION u_m2000_update_stat();
CREATE FUNCTION u_m2000_update_stat()
		RETURNING VARCHAR(100);

   define k_status varchar(100);

   let k_status = "Operazione in esecuzione...";

   call genidxstats();

-- non si può fare dentro a una SPL:   update statistics;

--   if sqlcode != 0 then
--      let K_STATUS = 'Errore sqlcode' || sqlcode;
--   end if;

   goto OK;

<<FORZA_FINE>>
   goto FINE;

<<OK>>
   let k_status = 'Ok operazione di Aggiornamento Indici conclusa correttamente.';

<<FINE>>
   --trace off;

return K_STATUS ;

end function
  
;

                      
              
