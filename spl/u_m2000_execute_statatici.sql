-- ESEGUE ESTRAZIONE STATISTICI
CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
--CONNECT to 'gammarad@gammarad_at1' user 'informix' using 'infoxgamma';
execute procedure u_m2000_0_start_stat();