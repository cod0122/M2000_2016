--CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
--CONNECT to 'gammarad@informix_at1' user 'informix' using 'infoxgamma';
grant  execute on function "informix".u_m2000_get_datetime () to "public" as "informix";
grant  execute on function "informix".u_m2000_wm_pklist_flag_sped () to "public" as "informix";
grant  execute on function "informix".u_m2000_chiudi_bolle () to "public" as "informix";
grant  execute on function "informix".u_m2000_1_cr_tab_s_armo () to "public" as "informix";
grant  execute on function "informix".u_m2000_3_cr_tab_s_meca () to "public" as "informix";
grant  execute on function "informix".u_m2000_4_s_meca () to "public" as "informix";
grant  execute on function "informix".u_m2000_5_cr_tab_s_artr () to "public" as "informix";
grant  execute on function "informix".u_m2000_7_cr_tab_s_arfa () to "public" as "informix";
grant  execute on function "informix".u_m2000_8_s_arfa () to "public" as "informix";
grant  execute on function "informix".u_m2000_9_cr_tab_s_arsp () to "public" as "informix";
grant  execute on function "informix".u_m2000_10_s_arsp () to "public" as "informix";
grant  execute on function "informix".u_m2000_0_start_stat () to "public" as "informix";

grant  execute on function "informix".u_m2000_update_stat () to "public" as "informix";
--grant  execute on function "informix".genidxstats () to "public" as "informix";
