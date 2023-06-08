$PBExportHeader$kuf_report_indici_run.sru
$PBExportComments$report indici x E1 (rtr, rts,etr, rte, relts....)
forward
global type kuf_report_indici_run from nonvisualobject
end type
end forward

global type kuf_report_indici_run from nonvisualobject
end type
global kuf_report_indici_run kuf_report_indici_run

type variables
//--- dati da restituire - il Report 
public datastore kids_report

private st_report_indici_run kist_report_indici_run
end variables

forward prototypes
private subroutine crea_view_x_report_23_runsrtrrts () throws uo_exception
private subroutine crea_view_x_report_23_xgru () throws uo_exception
private subroutine crea_view_x_report_23_xdtentgru () throws uo_exception
private subroutine crea_view_x_report_23_xdtent () throws uo_exception
private subroutine crea_view_x_report_23_xdtcertif () throws uo_exception
private subroutine crea_view_x_report_23_runsrtrrtscli () throws uo_exception
private subroutine crea_view_x_report_23_idxconsegnecli () throws uo_exception
private subroutine crea_view_x_report_23_idxconsegne () throws uo_exception
public subroutine get_report (ref st_report_indici_run kst_report_indici_run) throws uo_exception
end prototypes

private subroutine crea_view_x_report_23_runsrtrrts () throws uo_exception;//======================================================================
//=== Crea le View per le query
//======================================================================
//
string k_view, k_sql, k_campi



//=== Puntatore Cursore da attesa.....
SetPointer(kkg.pointer_attesa)

//--- costruisco le view di base 
	crea_view_x_report_23_xdtcertif( )
	crea_view_x_report_23_xgru( )
	
//--- costruisco altre view  
	k_view = kguf_data_base.u_get_nometab_xutente("report_23_trattati") 
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( mese, anno, runs, colli_trattati ) AS   " 
	k_sql += &
			" SELECT month(certif.data), year(certif.data), count(distinct meca.id), sum(artr.colli_trattati) FROM " &
			+ " armo  "  &
			+ " inner JOIN artr " &
			+ " ON armo.id_armo = artr.id_armo " &
			+ " inner JOIN meca " &
			+ " ON armo.id_meca = meca.id " &
			+ " inner JOIN certif " &
			+ " ON meca.id = certif.id_meca " 
	k_sql += " WHERE  " 
	k_sql += &
	 		 " armo.id_meca in (select id_meca from " &
			  + kguf_data_base.u_get_nometab_xutente("report_23_xdtcertif") + ")" 
	k_sql += " group by  month(certif.data), year(certif.data) " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	k_view = kguf_data_base.u_get_nometab_xutente("report_23_etr_1") 		//End TO Release  (grezzo)
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( mese, anno, etr_1 ) AS   " 
	k_sql += &
			" SELECT month(certif.data), year(certif.data) " & 
			+ " ,datediff( day, (select max(artr.data_fin) from artr where artr.num_certif = certif.num_certif), (certif.data) )  " & 
			+ " FROM certif " &
			+ " WHERE " & 
			+ " certif.id_meca in (select id_meca from " + kguf_data_base.u_get_nometab_xutente("report_23_xgru") + ")"
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
	
	k_view = kguf_data_base.u_get_nometab_xutente("report_23_etr")  		//End TO Release  (media gg)
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( mese, anno, etr ) AS   " 
	k_sql += &
			" SELECT mese, anno, avg(convert(decimal(6,2), etr_1 )) " & 
			+ " FROM " &
			+ kguf_data_base.u_get_nometab_xutente("report_23_etr_1") &
			+ " group by mese, anno " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	
	k_view = kguf_data_base.u_get_nometab_xutente("report_23_rtr") 		//Receive TO Release
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( mese, anno, rtr ) AS   " 
	k_sql += &
			" SELECT month(certif.data), year(certif.data)" &
			+ ", avg(convert(decimal(6,2),convert(int, datediff(day, convert(date, data_ent), certif.data))))  FROM " &
			+ " meca  "  &
			+ " inner JOIN certif " &
			+ " ON meca.id = certif.id_meca " &
			+ " WHERE " &
	 		+ " meca.id in (select id_meca from " + kguf_data_base.u_get_nometab_xutente("report_23_xgru") + ")" &
			+ " group by month(certif.data), year(certif.data) " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		


	k_view = kguf_data_base.u_get_nometab_xutente("report_23_rts_1")    //Receive TO Send (grezzo)
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( mese, anno, rts_1 ) AS   " 
	k_sql += &
			" SELECT month(certif.data), year(certif.data)" &
			+ ", convert(int, datediff(day, convert(date, meca.data_ent), coalesce(max(sped.data_rit), max(sped.data_bolla_out)) ))  FROM " &
			+ " meca  "  &
			+ " inner JOIN armo " &
			+ " ON meca.id = armo.id_meca " &
			+ " inner JOIN certif " &
			+ " ON meca.id = certif.id_meca " &
			+ " inner JOIN arsp " &
			+ " ON armo.id_armo = arsp.id_armo " &
			+ " inner JOIN sped " &
			+ " ON arsp.id_sped = sped.id_sped " &
			+ " WHERE " &
			+ " meca.id in (select id_meca from " + kguf_data_base.u_get_nometab_xutente("report_23_xgru") + ")" &
		 	+ " group by month(certif.data), year(certif.data),  meca.data_ent  " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	k_view = kguf_data_base.u_get_nometab_xutente("report_23_rts") 		//Receive TO Send (media)
	k_sql = " "                                   
	k_sql = + &
			"CREATE VIEW " + trim(k_view) &
			 + " ( mese, anno, rts ) AS   " 
	k_sql += &
			" SELECT mese, anno, avg(convert(decimal(6,2),rts_1))  FROM " &
			+ kguf_data_base.u_get_nometab_xutente("report_23_rts_1") &
	 		+ " group by mese, anno " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		


	k_view = kguf_data_base.u_get_nometab_xutente("report_23_rte_1") 		//Receive TO End (grezzo)
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( mese, anno, rte_1 ) AS   " 
	k_sql += &
			" SELECT month(certif.data), year(certif.data) " & 
	 				+ ", convert(int, datediff(day, convert(date, meca.data_ent) " &
									+ ", (select max(artr.data_fin) from artr where artr.num_certif = certif.num_certif))) " &
			+ " FROM meca " & 
			+ " inner JOIN certif " &
			+ " ON meca.id = certif.id_meca " &
	 		+ " WHERE  " & 
	 		+ " certif.id_meca in (select id_meca from " + kguf_data_base.u_get_nometab_xutente("report_23_xgru") + ")" &
			+ " group by month(certif.data), year(certif.data), certif.num_certif, meca.data_ent " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	k_view = kguf_data_base.u_get_nometab_xutente("report_23_rte") 		//Receive TO End (media)
	k_sql = " "                                   
	k_sql = + &
			"CREATE VIEW " + trim(k_view) &
			 + " ( mese, anno, rte ) AS   " 
	k_sql += &
			" SELECT mese, anno, avg(convert(decimal(6,2),rte_1))  FROM " &
			+ kguf_data_base.u_get_nometab_xutente("report_23_rte_1") &
	 		+ " group by mese, anno " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		


	k_view = kguf_data_base.u_get_nometab_xutente("report_23_relts_1") 	//Release TO Send (grezzo) 
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( mese, anno, relts_1 ) AS   " 
	k_sql += &
			" SELECT month(certif.data), year(certif.data) " & 
			+ ", convert(int, datediff(day " &
						+ ", certif.data " &
						+ ", (select coalesce(max(sped.data_rit), max(sped.data_bolla_out)) " &
					     		+ " from arsp inner join sped on arsp.id_sped = sped.id_sped " &
											+ " inner join armo on  arsp.id_armo = armo.id_armo " &
									+ " where armo.id_meca = certif.id_meca) )) " &
			+ " FROM certif " & 
	 		+ " WHERE  " & 
	 		+ " certif.id_meca in (select id_meca from " + kguf_data_base.u_get_nometab_xutente("report_23_xgru") + ")" &
			+ " group by month(certif.data), year(certif.data), certif.num_certif, certif.id_meca, certif.data " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	k_view = kguf_data_base.u_get_nometab_xutente("report_23_relts") 		//Release TO Send (media)
	k_sql = " "                                   
	k_sql = + &
			"CREATE VIEW " + trim(k_view) &
			 + " ( mese, anno, relts ) AS   " 
	k_sql += &
			" SELECT mese, anno, avg(convert(decimal(6,2),relts_1))  FROM " &
			+ kguf_data_base.u_get_nometab_xutente("report_23_relts_1") &
	 		+ " group by mese, anno " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		



//--- View Finale riepilogativa 
	k_view = kguf_data_base.u_get_nometab_xutente("report_23_runs_rtr_rts") 
	k_sql = " "                                   
	k_sql = "CREATE VIEW " + trim(k_view) &
			 + " ( mese, anno, colli_trattati, runs, rtr, rts, etr, rte, relts ) AS   " 
//	k_sql = " AS " //mese integer, anno integer, colli_trattati integer, runs integer, rtr integer, rts integer, etr integer  " 
	k_sql += &
			" SELECT runs.mese, runs.anno, runs.colli_trattati, runs.runs" &
					+ ", rtr.rtr, rts.rts, etr.etr, rte.rte, relts.relts  FROM " &
			+ kguf_data_base.u_get_nometab_xutente("report_23_trattati") + " as runs"  &
			+ " left outer JOIN " &
			+ kguf_data_base.u_get_nometab_xutente("report_23_rtr") + " as rtr"  &
			+ " ON runs.mese = rtr.mese and runs.anno = rtr.anno " &
			+ " left outer JOIN " &
			+ kguf_data_base.u_get_nometab_xutente("report_23_rts") + " as rts"  &
			+ " ON runs.mese = rts.mese and runs.anno = rts.anno " &
			+ " left outer JOIN " &
			+ kguf_data_base.u_get_nometab_xutente("report_23_etr") + " as etr"  &
			+ " ON runs.mese = etr.mese and runs.anno = etr.anno " &
			+ " left outer JOIN " &
			+ kguf_data_base.u_get_nometab_xutente("report_23_rte") + " as rte"  &
			+ " ON runs.mese = rte.mese and runs.anno = rte.anno " &
			+ " left outer JOIN " &
			+ kguf_data_base.u_get_nometab_xutente("report_23_relts") + " as relts"  &
			+ " ON runs.mese = relts.mese and runs.anno = relts.anno " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
//	kguo_sqlca_db_magazzino.db_crea_table(k_view, k_sql)


//--- View Finale x il '?'
	k_view = kguf_data_base.u_get_nometab_xutente("report_23_runsrtrrts_help") 
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " (id_meca, num_int, data_ent, data, data_bolla_out, num_bolla_out" &
	 		+ ", data_fin, colli_trattati, rtr, rts, etr, rte, relts, gruppo) AS   " 
	k_sql += &
			" SELECT meca.id, meca.num_int, meca.data_ent, certif.data " &
			+ ", coalesce(max(sped.data_rit), max(sped.data_bolla_out)), max(arsp.num_bolla_out) " & 
			+ ", max(artr.data_fin) " & 
			+ ", (select sum(artr.colli_trattati) from artr inner join armo on artr.id_armo = armo.id_armo where meca.id = armo.id_meca) " & 
			+ ", datediff(day, convert(date, meca.data_ent), certif.data) " & 
			+ ", datediff(day, convert(date, meca.data_ent), coalesce(max(sped.data_rit), max(sped.data_bolla_out))) " & 
			+ ", datediff(day, max(artr.data_fin), certif.data) " & 
			+ ", datediff(day, convert(date, meca.data_ent), max(artr.data_fin)) " & 
			+ ", datediff(day, certif.data, coalesce(max(sped.data_rit), max(sped.data_bolla_out)) )" & 
			+ ", prodotti.gruppo " & 
			+ " FROM " &
			+ kguf_data_base.u_get_nometab_xutente("report_23_xdtcertif") + " as runs"   &
			+ " inner JOIN meca " &
			+ " ON runs.id_meca = meca.id "  &
			+ " inner JOIN artr " &
			+ " ON runs.id_armo = artr.id_armo "  &
			+ " inner JOIN armo " &
			+ " ON runs.id_armo = armo.id_armo " &
			+ " inner JOIN prodotti " &
			+ " ON armo.art = prodotti.codice " &
			+ " left outer JOIN  " &
			+ kguf_data_base.u_get_nometab_xutente("report_23_xgru") + " as runs_xgru"   &
			+ " ON runs.id_meca = runs_xgru.id_meca "  &
			+ " left outer JOIN certif " &
			+ " ON runs_xgru.id_meca = certif.id_meca "  &
			+ " left outer JOIN arsp " &
			+ " ON runs_xgru.id_armo = arsp.id_armo " &
			+ " left outer JOIN sped " &
			+ " ON arsp.id_sped = sped.id_sped "  
	k_sql += " group by meca.id, meca.num_int, meca.data_ent, certif.data, prodotti.gruppo " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

//			", sum(artr.colli_trattati) " &
	
//=== Riprist. il vecchio puntatore : 
SetPointer(kkg.pointer_default)



			
end subroutine

private subroutine crea_view_x_report_23_xgru () throws uo_exception;//======================================================================
//=== Crea le View per le query Receipt To Releise per Cliente
//======================================================================
//
string k_view, k_sql, k_campi


	k_view =  kguf_data_base.u_get_nometab_xutente("report_23_xgru") 
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_armo, id_meca ) AS   " 
   k_campi = "id_armo integer " & 
            + ", id_meca integer " 
	k_sql += &
			" SELECT report_23.id_armo, report_23.id_meca  FROM " &
			+  kguf_data_base.u_get_nometab_xutente("report_23_xdtcertif") + " as report_23 "
	if kist_report_indici_run.gru_attiva = 1 then
		k_sql += &
			 " inner JOIN armo " &
			+ " ON report_23.id_meca = armo.id_meca " &
			+ " inner JOIN prodotti " &
			+ " ON armo.art = prodotti.codice " 
		if kist_report_indici_run.gru_flag = 1 or kist_report_indici_run.gru_flag = 0 then  // includi/escludi solo un gruppo puntuale
			if kist_report_indici_run.gru > 0 then
				k_sql += " WHERE  " 
				if kist_report_indici_run.gru_flag = 1 then  
					k_sql += " prodotti.gruppo = " + string(kist_report_indici_run.gru) + " " // includi solo un gruppo puntuale
				else  
					k_sql += " prodotti.gruppo <> " + string(kist_report_indici_run.gru) + " " // Ecludi solo un gruppo puntuale
				end if
			end if
		else
			 // escludi tutti quelli da Escludere x stat
			k_sql += &
			  " inner JOIN gru " &
			+ " ON prodotti.gruppo = gru.codice " &
			+ " WHERE  gru.escludi_da_stat_glob = 'N' "// tutti i gruppi (meno quelli da Escludere x stat)
		end if
	end if	
	k_sql += &
			" group by report_23.id_armo, report_23.id_meca "
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
//   kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)      

end subroutine

private subroutine crea_view_x_report_23_xdtentgru () throws uo_exception;//======================================================================
//=== Crea le View per le query Receipt To Releise per Cliente
//======================================================================
//
string k_view, k_sql, k_campi


	k_view =  kguf_data_base.u_get_nometab_xutente("report_23_xdtentgru") 
	                               
	k_sql = "CREATE VIEW " + trim(k_view) &
					 + " ( id_armo, id_meca ) AS   " 
   k_campi = "id_armo integer " & 
           			 + ", id_meca integer " 
	k_sql += &
			" SELECT report_23.id_armo, report_23.id_meca  FROM " &
			+  kguf_data_base.u_get_nometab_xutente("report_23_xdtent") + " as report_23 "
	if kist_report_indici_run.gru_attiva = 1 then
		k_sql += &
			 " inner JOIN armo " &
			+ " ON report_23.id_meca = armo.id_meca " &
			+ " inner JOIN prodotti " &
			+ " ON armo.art = prodotti.codice " 
		if kist_report_indici_run.gru_flag = 1 or kist_report_indici_run.gru_flag = 0 then  // includi/escludi solo un gruppo puntuale
			if kist_report_indici_run.gru > 0 then
				k_sql += " WHERE  " 
				if kist_report_indici_run.gru_flag = 1 then  
					k_sql += " prodotti.gruppo = " + string(kist_report_indici_run.gru) + " " // includi solo un gruppo puntuale
				else  
					k_sql += " prodotti.gruppo <> " + string(kist_report_indici_run.gru) + " " // Ecludi solo un gruppo puntuale
				end if
			end if
		else
			 // escludi tutti quelli da Escludere x stat
			k_sql += &
			  " inner JOIN gru " &
			+ " ON prodotti.gruppo = gru.codice " &
			+ " WHERE  gru.escludi_da_stat_glob = 'N' "// tutti i gruppi (meno quelli da Escludere x stat)
		end if
	end if	
	k_sql += " group by report_23.id_armo, report_23.id_meca "
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
//   kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)      

end subroutine

private subroutine crea_view_x_report_23_xdtent () throws uo_exception;//======================================================================
//=== Crea le View per le query circa i Tempi di Consegna
//======================================================================
//
string k_view, k_sql, k_campi


//--- costruisco la view con ID_MECA da estrarre
	k_view = kguf_data_base.u_get_nometab_xutente("report_23_xdtent") 
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " (clie_3, id_armo, id_meca, data_ent, id_sped " &
	 +"  , data_stampa, ora_stampa  " &
	 +"  , consegna_data, consegna_ora ) AS   " 
   k_campi = " clie_3 integer " & 
  			+ ", id_armo integer " & 
            + ", id_meca integer "  &
            + ", data_ent datetime "  &
            + ", id_sped integer "   &
		  	+ " , data_stampa date " &
			+ " , ora_stampa time "  &
		  	+ " , consegna_data date " &
			+ " , consegna_ora time " 
	k_sql += &
			" SELECT   meca.clie_3, armo.id_armo, meca.id  " &
            	+ " , meca.data_ent " &
			+ " , min(sped.id_sped) " &
		  	+ " , certif.data_stampa " &
			+ " , certif.ora_stampa " &
		  	+ " , meca.consegna_data  " &
			+ " , coalesce(meca.consegna_ora, convert(time, '23:59:59')) " &
			+ " FROM " &
			+ " meca  "  &
			+ " inner JOIN armo " &
			+ " ON meca.id = armo.id_meca " &
			+ " inner join certif " &
			+ " ON meca.id = certif.id_meca " &
			+ " inner JOIN arsp " &
			+ " ON armo.id_armo = arsp.id_armo " &
			+ " inner JOIN sped " &
			+ " ON arsp.id_sped = sped.id_sped " 
	k_sql += " WHERE  " &
			+ " meca.consegna_data > '" + string(kkg.data_no) + "' " &
			+ " and certif.data_stampa > '" + string(kkg.data_no) + "' " &
			+ " and certif.ora_stampa > '" + string(time(0)) + "' " 
			
	if kist_report_indici_run.num_int > 0 then
		k_sql += &
	 		 " and meca.id = " + string(kist_report_indici_run.id_meca_ini)
	else
		k_sql += &
			+ " and meca.data_ent between '" + string(datetime(kist_report_indici_run.data_da, time(0))) + "' and '" + string(datetime(kist_report_indici_run.data_a, time("23:59:59"))) + "' " 
		
		if kist_report_indici_run.clie_3 > 0 then
			k_sql += &
				 "and meca.clie_3 = " + string(kist_report_indici_run.clie_3)
		end if
	end if
	k_sql += " group by   meca.clie_3, armo.id_armo, meca.id, meca.data_ent " &
		  	+ " , certif.data_stampa " &
			+ " , certif.ora_stampa " &
		  	+ " , meca.consegna_data  " &
			+ " , meca.consegna_ora  " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

			
end subroutine

private subroutine crea_view_x_report_23_xdtcertif () throws uo_exception;//======================================================================
//=== Crea le View per le query Receipt To Releise per Cliente
//======================================================================
//
string k_view, k_sql, k_campi


//--- costruisco la view con ID_MECA da estrarre
	k_view = kguf_data_base.u_get_nometab_xutente("report_23_xdtcertif") 
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_armo, id_meca ) AS   " 
   k_campi = "id_armo integer " & 
            + ", id_meca integer " 
	k_sql += &
			" SELECT  armo.id_armo, armo.id_meca  FROM " &
			+ " meca  "  &
			+ " inner JOIN armo " &
			+ " ON meca.id = armo.id_meca " &
			+ " inner JOIN certif " &
			+ " ON meca.id = certif.id_meca " 
			
	k_sql += " WHERE  " 
	if kist_report_indici_run.num_int > 0 then
		k_sql += &
	 		 " meca.id = " + string(kist_report_indici_run.id_meca_ini)
	else
		k_sql += &
			+ " certif.data between '" + string(kist_report_indici_run.data_da) + "' and '" + string(kist_report_indici_run.data_a) + "' " 
		
		k_sql += &
			+ " and meca.data_ent >  '" + string(kkg.data_no) + "' "
		
		if kist_report_indici_run.clie_3 > 0 then
			k_sql += &
				 "and meca.clie_3 = " + string(kist_report_indici_run.clie_3)
		end if
	end if
	k_sql += " group by  armo.id_armo, armo.id_meca "
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		



end subroutine

private subroutine crea_view_x_report_23_runsrtrrtscli () throws uo_exception;//======================================================================
//=== Crea le View per le query Receipt To Releise per Cliente
//======================================================================
//
string k_view, k_sql, k_campi



//=== Puntatore Cursore da attesa.....
SetPointer(kkg.pointer_attesa)

//--- costruisco le view di base 
	crea_view_x_report_23_xdtcertif()
	crea_view_x_report_23_xgru( )
	
//--- costruisco altre view  
	k_view = kguf_data_base.u_get_nometab_xutente("report_23CLI_trattati") 
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( clie_3, mese, anno, runs, colli_trattati ) AS   " 
	k_sql += &
			" SELECT meca.clie_3, month(certif.data), year(certif.data), count(distinct meca.id), sum(artr.colli_trattati) FROM " &
			+ " armo  "  &
			+ " inner JOIN artr " &
			+ " ON armo.id_armo = artr.id_armo " &
			+ " inner JOIN meca " &
			+ " ON armo.id_meca = meca.id " &
			+ " inner JOIN certif " &
			+ " ON meca.id = certif.id_meca " 
	k_sql += " WHERE  " 
	k_sql += " armo.id_meca in (select id_meca from " &
			  + kguf_data_base.u_get_nometab_xutente("report_23_xdtcertif") + ")" 
	k_sql += " group by meca.clie_3, month(certif.data), year(certif.data) " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	k_view = kguf_data_base.u_get_nometab_xutente("report_23CLI_etr_1") //End TO Release  (grezzo)
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( clie_3, mese, anno, etr_1 ) AS   " 
	k_sql += &
			" SELECT meca.clie_3, month(certif.data), year(certif.data) " & 
			+ " ,datediff( day, (select max(artr.data_fin) from artr where artr.num_certif = certif.num_certif) " & 
						+ ", (certif.data) )  " & 
			+ " FROM " &
			+ " certif  inner join meca on certif.id_meca = meca.id " 
	k_sql += " WHERE  " 
	k_sql += &
	 		 " certif.id_meca in (select id_meca from " + kguf_data_base.u_get_nometab_xutente("report_23_xgru") + ")" 
			  
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
	
	k_view = kguf_data_base.u_get_nometab_xutente("report_23CLI_etr")  		//End TO Release  (media gg)
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( clie_3, mese, anno, etr ) AS   " 
	k_sql += &
			" SELECT clie_3, mese, anno, avg(convert(decimal(6,2), etr_1 )) " & 
			+ " FROM " &
			+ kguf_data_base.u_get_nometab_xutente("report_23CLI_etr_1") 
	k_sql += " group by clie_3, mese, anno " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	k_view = kguf_data_base.u_get_nometab_xutente("report_23CLI_rtr") 		//Receive TO Release
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( clie_3, mese, anno, rtr ) AS   " 
	k_sql += &
			" SELECT meca.clie_3, month(certif.data), year(certif.data) " + &
			+ ", avg(convert(decimal(6,2),datediff(day, convert(date, data_ent), certif.data))) " &
			+ " FROM meca inner JOIN certif " &
			+ " ON meca.id = certif.id_meca " 
	k_sql += " WHERE  " 
	k_sql += " meca.id in (select id_meca from " + kguf_data_base.u_get_nometab_xutente("report_23_xgru") + ")"
	k_sql += " group by meca.clie_3, month(certif.data), year(certif.data) " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	k_view = kguf_data_base.u_get_nometab_xutente("report_23CLI_rts_1")    //Receive TO Send (grezzo)
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( clie_3, mese, anno, rts_1 ) AS   " 
	k_sql += &
			" SELECT meca.clie_3, month(certif.data), year(certif.data)" &
		  	 	+ ", datediff(day, convert(date, meca.data_ent), coalesce(max(sped.data_rit), max(sped.data_bolla_out))) " &
			+ " FROM meca  "  &
			+ " inner JOIN armo " &
			+ " ON meca.id = armo.id_meca " &
			+ " inner JOIN certif " &
			+ " ON meca.id = certif.id_meca " &
			+ " inner JOIN arsp " &
			+ " ON armo.id_armo = arsp.id_armo " &
			+ " inner JOIN sped " &
			+ " ON arsp.id_sped = sped.id_sped " &
			+ " WHERE  " &
			+ " meca.id in (select id_meca from " + kguf_data_base.u_get_nometab_xutente("report_23_xgru") + ")" &
			+ " group by meca.clie_3, month(certif.data), year(certif.data),  meca.data_ent " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
   //kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)      

	k_view = kguf_data_base.u_get_nometab_xutente("report_23CLI_rts") 	//Receive TO Send (media)
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( clie_3, mese, anno, rts ) AS   " 
	k_sql += &
			" SELECT clie_3, mese, anno, avg(convert(decimal(6,2),rts_1))  FROM " &
			+ kguf_data_base.u_get_nometab_xutente("report_23CLI_rts_1")
	k_sql += " group by clie_3, mese, anno " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		


	k_view = kguf_data_base.u_get_nometab_xutente("report_23CLI_rte_1") 		//Receive TO End  (grezzo)
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( clie_3,mese, anno, rte_1 ) AS   " 
	k_sql += &
			" SELECT meca.clie_3, month(certif.data), year(certif.data) " & 
			+ ", convert(int, datediff(day, convert(date, data_ent) " &
						+ ", (select max(artr.data_fin) from artr where artr.num_certif = certif.num_certif))) " &
			+ " FROM " &
			+ " certif  inner join meca on certif.id_meca = meca.id " &
	 		+ " WHERE  " & 
	 		+ " certif.id_meca in (select id_meca from " + kguf_data_base.u_get_nometab_xutente("report_23_xgru") + ")" &
			+  " group by meca.clie_3, month(certif.data), year(certif.data), meca.data_ent, certif.num_certif " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	k_view = kguf_data_base.u_get_nometab_xutente("report_23CLI_rte") 		//Receive TO End  (media)
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( clie_3, mese, anno, rte ) AS   " 
	k_sql += &
			" SELECT clie_3, mese, anno, avg(convert(decimal(6,2),rte_1))  FROM " &
			+ kguf_data_base.u_get_nometab_xutente("report_23CLI_rte_1")
	k_sql += " group by clie_3, mese, anno " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		


	k_view = kguf_data_base.u_get_nometab_xutente("report_23CLI_relts_1") 		//Release TO Send  (grezzo)
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( clie_3,mese, anno, relts_1 ) AS   " 
	k_sql += &
			" SELECT meca.clie_3, month(certif.data), year(certif.data) " & 
			+ ", convert(int, datediff(day " &
						+ ", certif.data " &
						+ ", (select coalesce(max(sped.data_rit), max(sped.data_bolla_out)) " &
					     		+ " from arsp inner join sped on arsp.id_sped = sped.id_sped " &
											+ " inner join armo on  arsp.id_armo = armo.id_armo " &
									+ " where armo.id_meca = certif.id_meca) )) " &
			+ " FROM " &
			+ " certif  inner join meca on certif.id_meca = meca.id " &
	 		+ " WHERE  " & 
	 		+ " certif.id_meca in (select id_meca from " + kguf_data_base.u_get_nometab_xutente("report_23_xgru") + ")" &
			+  " group by meca.clie_3, month(certif.data), year(certif.data), certif.data, certif.id_meca " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	k_view = kguf_data_base.u_get_nometab_xutente("report_23CLI_relts") 			//Release TO Send  (media)
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( clie_3, mese, anno, relts ) AS   " 
	k_sql += &
			" SELECT clie_3, mese, anno, avg(convert(decimal(6,2),relts_1))  FROM " &
			+ kguf_data_base.u_get_nometab_xutente("report_23CLI_relts_1")
	k_sql += " group by clie_3, mese, anno " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		


//--- View Finale riepilogativa 
	k_view = kguf_data_base.u_get_nometab_xutente("report_23CLI_runs_rtr_rts") 
	k_sql = " "                                   
	k_sql = "CREATE VIEW " + trim(k_view) &
	 		+ " ( clie_3, mese, anno, colli_trattati, runs, rtr, rts, etr, rte, relts ) AS   " 
//   	k_campi = "clie_3 integer " & 
//            + ", mese integer "  & 
//            + ", anno integer "  & 
//            + ", colli_trattati integer " &  
//            + ", runs integer "  & 
//            + ", rtr integer "  & 
//            + ", rts integer "  & 
//            + ", etr integer " 
	k_sql += &
			" SELECT  runs.clie_3, runs.mese, runs.anno, runs.colli_trattati" &
			+      ", runs.runs, rtr.rtr, rts.rts, etr.etr, rte.rte, relts.relts  FROM " &
			+ kguf_data_base.u_get_nometab_xutente("report_23CLI_trattati") + " as runs"  &
			+ " left outer JOIN " &
			+ kguf_data_base.u_get_nometab_xutente("report_23CLI_rtr") + " as rtr"  &
			+ " ON runs.mese = rtr.mese and runs.anno = rtr.anno and runs.clie_3 = rtr.clie_3 " &
			+ " left outer JOIN " &
			+ kguf_data_base.u_get_nometab_xutente("report_23CLI_rts") + " as rts"  &
			+ " ON runs.mese = rts.mese and runs.anno = rts.anno and runs.clie_3 = rts.clie_3 " &
			+ " left outer JOIN " &
			+ kguf_data_base.u_get_nometab_xutente("report_23CLI_etr") + " as etr"  &
			+ " ON runs.mese = etr.mese and runs.anno = etr.anno and runs.clie_3 = etr.clie_3 " &
			+ " left outer JOIN " &
			+ kguf_data_base.u_get_nometab_xutente("report_23CLI_rte") + " as rte"  &
			+ " ON runs.mese = rte.mese and runs.anno = rte.anno and runs.clie_3 = rte.clie_3 " &
			+ " left outer JOIN " &
			+ kguf_data_base.u_get_nometab_xutente("report_23CLI_relts") + " as relts"  &
			+ " ON runs.mese = relts.mese and runs.anno = relts.anno and runs.clie_3 = relts.clie_3 " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
//  	kguo_sqlca_db_magazzino.db_crea_temp_table_global(k_view, k_campi, k_sql)      


//--- View Finale x il '?'
	k_view = kguf_data_base.u_get_nometab_xutente("report_23CLI_runsrtrrts_help") 
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " (clie_3, id_meca, num_int, data_int, data_ent, data, data_bolla_out, num_bolla_out" &
	 		+ ", data_fin, colli_trattati, rtr, rts, etr, rte, relts, gruppo ) AS   " 
	k_sql += &
			" SELECT meca.clie_3, meca.id, meca.num_int, meca.data_int, meca.data_ent, certif.data " &
			+ ", coalesce(max(sped.data_rit), max(sped.data_bolla_out)), max(arsp.num_bolla_out) " & 
			+ ", max(artr.data_fin) " &
			+ ", (select sum(artr.colli_trattati) from artr inner join armo on artr.id_armo = armo.id_armo where meca.id = armo.id_meca) " & 
			+ ", datediff(day, convert(date, meca.data_ent), certif.data) " & 
			+ ", datediff(day, convert(date, meca.data_ent), coalesce(max(sped.data_rit), max(sped.data_bolla_out))) " &
			+ ", datediff(day, max(artr.data_fin), certif.data) " & 
			+ ", datediff(day, convert(date, meca.data_ent), max(artr.data_fin)) " & 
			+ ", datediff(day, certif.data, coalesce(max(sped.data_rit), max(sped.data_bolla_out))) " & 
			+ ", prodotti.gruppo " & 
			+ " FROM " &
			+ kguf_data_base.u_get_nometab_xutente("report_23_xdtcertif") + " as runs"   &
			+ " inner JOIN meca " &
			+ " ON runs.id_meca = meca.id "  &
			+ " inner JOIN artr " &
			+ " ON runs.id_armo = artr.id_armo "  &
			+ " inner JOIN armo " &
			+ " ON runs.id_armo = armo.id_armo " &
			+ " inner JOIN prodotti " &
			+ " ON armo.art = prodotti.codice " &
			+ " left outer JOIN  " &
			+ kguf_data_base.u_get_nometab_xutente("report_23_xgru") + " as runs_xgru"   &
			+ " ON runs.id_meca = runs_xgru.id_meca "  &
			+ " left outer JOIN certif " &
			+ " ON runs_xgru.id_meca = certif.id_meca "  &
			+ " left outer JOIN arsp " &
			+ " ON runs_xgru.id_armo = arsp.id_armo " &
			+ " left outer JOIN sped " &
			+ " ON arsp.id_sped = sped.id_sped " &
			+ " GROUP BY meca.clie_3, meca.id, meca.num_int, meca.data_int, meca.data_ent, certif.data, prodotti.gruppo " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

//			+ ", (select sum(artr.colli_trattati) from artr where runs.id_armo = artr.id_armo) " &

	
//=== Riprist. il vecchio puntatore : 
SetPointer(kkg.pointer_default)



			
end subroutine

private subroutine crea_view_x_report_23_idxconsegnecli () throws uo_exception;//======================================================================
//=== Crea le View per le query:  Indicatori di spedizione (consegna prevista - spedizione)
//======================================================================
//
string k_view, k_sql, k_campi



//=== Puntatore Cursore da attesa.....
SetPointer(kkg.pointer_attesa)

//--- costruisco le view di base 
	crea_view_x_report_23_xdtent( )
	crea_view_x_report_23_xdtentgru( )
	

//--- costruisco altre view  
	k_view = kguf_data_base.u_get_nometab_xutente("report_23CLI_idx_meca_tot") 
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " (clie_3, mese, anno, n_id_meca_tot, colli_trattati ) AS   " 
	k_sql += &
			+ " SELECT xdent.clie_3, month(xdent.data_ent), year(xdent.data_ent), count(distinct xdent.id_meca), " &
			+ " sum(artr.colli_trattati) " &
			+ " FROM " &
			+  kguf_data_base.u_get_nometab_xutente("report_23_xdtent") + " as xdent " &
			+ " inner JOIN artr " &
			+ " ON xdent.id_armo = artr.id_armo " 
	k_sql += " group by xdent.clie_3, month(xdent.data_ent), year(xdent.data_ent) " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	k_view = kguf_data_base.u_get_nometab_xutente("report_23CLI_idx_meca_ko") 
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " (clie_3, mese, anno, n_id_meca_oltre_consegna ) AS   " 
	k_sql += &
			+ " SELECT t_xdtent.clie_3, month(t_xdtent.data_ent), year(t_xdtent.data_ent), count(distinct t_xdtent.id_meca) " &
			+ " FROM  " &
			 + kguf_data_base.u_get_nometab_xutente("report_23_xdtent") + " as t_xdtent " 
	k_sql += " WHERE  " &
	          + "  (t_xdtent.consegna_data < t_xdtent.data_stampa " &
	          +        " or (t_xdtent.consegna_data = t_xdtent.data_stampa and t_xdtent.consegna_ora < t_xdtent.ora_stampa) ) " 
	k_sql += " group by t_xdtent.clie_3, month(t_xdtent.data_ent), year(t_xdtent.data_ent) " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		


//--- View Finale riepilogativa 
	k_view = kguf_data_base.u_get_nometab_xutente("report_23CLI_idx_consegne") 
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " (clie_3, mese, anno, colli_trattati, n_id_meca_tot, n_id_meca_oltre_consegna, perc_id_meca_oltre_consegna  ) AS   " 
	k_sql += &
			" SELECT idxtot.clie_3, idxtot.mese, idxtot.anno, idxtot.colli_trattati, idxtot.n_id_meca_tot, idxko.n_id_meca_oltre_consegna  " &
			+ " , coalesce( ( (100 / cast(idxtot.n_id_meca_tot as float)) * idxko.n_id_meca_oltre_consegna), 0) " &
			+ " FROM " &
			+ kguf_data_base.u_get_nometab_xutente("report_23CLI_idx_meca_tot") + " as idxtot"  &
			+ " left outer JOIN " &
			+ kguf_data_base.u_get_nometab_xutente("report_23CLI_idx_meca_ko") + " as idxko"  &
			+ " ON idxtot.clie_3 = idxko.clie_3 and idxtot.mese = idxko.mese and idxtot.anno = idxko.anno " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		


//--- View Finale x il '?'
	k_view = kguf_data_base.u_get_nometab_xutente("report_23CLI_idx_consegne_help") 
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 		+ " (clie_3, id_meca, num_int, data_int, data_ent, data_bolla_out, num_bolla_out, data_fin, colli_trattati, gruppo " &
			+ ", consegna_data " &
			+ ", consegna_ora " &			
			+ ", data_certif " &
			+ ", ora_certif " &
			+ ", id_sped " &
			+ ", data_rit " &
			+ ", ora_rit " &
	 	 + "	 ) AS   " 
	k_sql += &
			" SELECT idx.clie_3, idx.id_meca, meca.num_int, meca.data_int, idx.data_ent " &
			+ ", min(sped.data_bolla_out), min(sped.num_bolla_out) " & 
			+ ", max(artr.data_fin), sum(artr.colli_trattati) " &
			+ ", prodotti.gruppo " & 
			+ ", idx.consegna_data " &
			+ ", idx.consegna_ora " &			
			+ ", idx.data_stampa " &
			+ ", idx.ora_stampa " &			
			+ ", min(sped.id_sped) " &
			+ ", min(sped.data_rit) " &
			+ ", min(sped.ora_rit) " &
			+ " FROM " &
			+ kguf_data_base.u_get_nometab_xutente("report_23_xdtent") + " as idx"   &
			+ " inner JOIN meca " &
			+ " ON idx.id_meca = meca.id "  &
			+ " inner JOIN artr " &
			+ " ON idx.id_armo = artr.id_armo "  &
			+ " inner JOIN sped " &
			+ " ON idx.id_sped = sped.id_sped " &
			+ " inner JOIN armo " &
			+ " ON idx.id_armo = armo.id_armo "  &
			+ " inner JOIN prodotti " &
			+ " ON armo.art = prodotti.codice " &
			+ " left outer JOIN  " &
			+ kguf_data_base.u_get_nometab_xutente("report_23_xdtentgru") + " as idx_xgru"   &
			+ " ON idx.id_meca = idx_xgru.id_meca "  
//			+ " where " &
//	          + "  (idx.consegna_data < idx.data_stampa " &
//	          +        " or (idx.consegna_data = idx.data_stampa and idx.consegna_ora < idx.ora_stampa) ) " 
	k_sql += " group by idx.clie_3, idx.id_meca, meca.num_int, meca.data_int, idx.data_ent, prodotti.gruppo " & 
			+ ", idx.consegna_data " &
			+ ", idx.consegna_ora " &
			+ ", idx.data_stampa " &
			+ ", idx.ora_stampa " 			
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

//			+ " left outer JOIN arsp " &
//			+ " ON idx_xgru.id_armo = arsp.id_armo "  
	
//=== Riprist. il vecchio puntatore : 
SetPointer(kkg.pointer_default)



			
end subroutine

private subroutine crea_view_x_report_23_idxconsegne () throws uo_exception;//======================================================================
//=== Crea le View per le query:  Indicatori di spedizione (consegna prevista - spedizione)
//======================================================================
//
string k_view, k_sql, k_campi



//=== Puntatore Cursore da attesa.....
SetPointer(kkg.pointer_attesa)

//--- costruisco le view di base 
	crea_view_x_report_23_xdtent( )
	crea_view_x_report_23_xdtentgru()
	

//--- costruisco altre view  
	k_view = kguf_data_base.u_get_nometab_xutente("report_23_idx_meca_tot") 
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( mese, anno, n_id_meca_tot, colli_trattati ) AS   " 
	k_sql += &
			+ " SELECT month(xdent.data_ent), year(xdent.data_ent), count(distinct xdent.id_meca), " &
			+ " sum(artr.colli_trattati) " &
			+ " FROM " &
			+  kguf_data_base.u_get_nometab_xutente("report_23_xdtent") + " as xdent " &
			+ " inner JOIN artr " &
			+ " ON xdent.id_armo = artr.id_armo " 
	k_sql += " group by  month(xdent.data_ent), year(xdent.data_ent) " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	k_view = kguf_data_base.u_get_nometab_xutente("report_23_idx_meca_ko") 
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( mese, anno, n_id_meca_oltre_consegna ) AS   " 
	k_sql += &
			+ " SELECT month(t_xdtent.data_ent), year(t_xdtent.data_ent), count(distinct t_xdtent.id_meca) " &
			+ " FROM  " &
			 + kguf_data_base.u_get_nometab_xutente("report_23_xdtent") + " as t_xdtent " 
	k_sql += " WHERE  " &
	          + "  (t_xdtent.consegna_data < t_xdtent.data_stampa " &
	          +        " or (t_xdtent.consegna_data = t_xdtent.data_stampa and t_xdtent.consegna_ora < t_xdtent.ora_stampa) ) " 
	k_sql += " group by month(t_xdtent.data_ent), year(t_xdtent.data_ent) " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		


//--- View Finale riepilogativa 
	k_view = kguf_data_base.u_get_nometab_xutente("report_23_idx_consegne") 
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( mese, anno, colli_trattati, n_id_meca_tot, n_id_meca_oltre_consegna, perc_id_meca_oltre_consegna  ) AS   " 
	k_sql += &
			" SELECT idxtot.mese, idxtot.anno, idxtot.colli_trattati, idxtot.n_id_meca_tot, idxko.n_id_meca_oltre_consegna  " &
			+ " , coalesce( ( (100 / cast(idxtot.n_id_meca_tot as float)) * idxko.n_id_meca_oltre_consegna), 0) " &
			+ " FROM " &
			+ kguf_data_base.u_get_nometab_xutente("report_23_idx_meca_tot") + " as idxtot"  &
			+ " left outer JOIN " &
			+ kguf_data_base.u_get_nometab_xutente("report_23_idx_meca_ko") + " as idxko"  &
			+ " ON idxtot.mese = idxko.mese and idxtot.anno = idxko.anno " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		


//--- View Finale x il '?'
	k_view = kguf_data_base.u_get_nometab_xutente("report_23_idx_consegne_help") 
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 		+ " (id_meca, num_int, data_int, data_ent, data_bolla_out, num_bolla_out, data_fin, colli_trattati, gruppo " &
			+ ", consegna_data " &
			+ ", consegna_ora " &			
			+ ", data_certif " &
			+ ", ora_certif " &
			+ ", id_sped " &
			+ ", data_rit " &
			+ ", ora_rit " &
	 	 + "	 ) AS   " 
	k_sql += &
			" SELECT meca.id, meca.num_int, meca.data_int, meca.data_ent " &
			+ ", min(sped.data_bolla_out), min(sped.num_bolla_out) " & 
			+ ", max(artr.data_fin), sum(artr.colli_trattati) " &
			+ ", prodotti.gruppo " & 
			+ ", idx.consegna_data " &
			+ ", idx.consegna_ora " &			
			+ ", idx.data_stampa " &
			+ ", idx.ora_stampa " &			
			+ ", min(sped.id_sped) " &
			+ ", min(sped.data_rit) " &
			+ ", min(sped.ora_rit) " &
			+ " FROM " &
			+ kguf_data_base.u_get_nometab_xutente("report_23_xdtent") + " as idx"   &
			+ " inner JOIN meca " &
			+ " ON idx.id_meca = meca.id "  &
			+ " inner JOIN artr " &
			+ " ON idx.id_armo = artr.id_armo "  &
			+ " inner JOIN sped " &
			+ " ON idx.id_sped = sped.id_sped " &
			+ " inner JOIN armo " &
			+ " ON idx.id_armo = armo.id_armo "  &
			+ " inner JOIN prodotti " &
			+ " ON armo.art = prodotti.codice " &
			+ " left outer JOIN  " &
			+ kguf_data_base.u_get_nometab_xutente("report_23_xdtentgru") + " as idx_xgru"   &
			+ " ON idx.id_meca = idx_xgru.id_meca "  &
			+ " where " &
	          + "  (idx.consegna_data < idx.data_stampa " &
	          +        " or (idx.consegna_data = idx.data_stampa and idx.consegna_ora < idx.ora_stampa) ) " 
	k_sql += " group by meca.id, meca.num_int, meca.data_int, meca.data_ent, prodotti.gruppo " & 
			+ ", idx.consegna_data " &
			+ ", idx.consegna_ora " &
			+ ", idx.data_stampa " &
			+ ", idx.ora_stampa " 			
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

//			+ " left outer JOIN arsp " &
//			+ " ON idx_xgru.id_armo = arsp.id_armo "  
	
//=== Riprist. il vecchio puntatore : 
SetPointer(kkg.pointer_default)



			
end subroutine

public subroutine get_report (ref st_report_indici_run kst_report_indici_run) throws uo_exception;//---
//--- Genera Report Indici RUNS per E1 (rtr, rts, rte, etr ...)
//--- Inp: st_report_indici_run.....
//--- out: 
//--- Lancia EXCPETION se errore
//---
int k_rc 
//long k_righe

	kist_report_indici_run = kst_report_indici_run

//--- view x estrazione 
	if kist_report_indici_run.report = 1 then
		if kist_report_indici_run.xcliente = "S" then
			crea_view_x_report_23_runsrtrrtscli()
			kids_report.dataobject = "d_report_23_runs_rtr_rts_cli" 
			kguf_data_base.u_set_ds_change_name_tab(kids_report, "vx_MAST2_report_23CLI_runs_rtr_rts") // Aggiorna SQL della dw	
		else
			crea_view_x_report_23_runsrtrrts()
			kids_report.dataobject = "d_report_23_runs_rtr_rts" 
			kguf_data_base.u_set_ds_change_name_tab(kids_report, "vx_MAST2_report_23_runs_rtr_rts") // Aggiorna SQL della dw	
		end if
	else
		if kist_report_indici_run.xcliente = "S" then
			crea_view_x_report_23_idxconsegnecli( )
			kids_report.dataobject = "d_report_23_idx_consegne_cli" 
			kguf_data_base.u_set_ds_change_name_tab(kids_report, "vx_MAST2_report_23CLI_idx_consegne") // Aggiorna SQL della dw	
		else
			crea_view_x_report_23_idxconsegne()
			kids_report.dataobject = "d_report_23_idx_consegne" 
			kguf_data_base.u_set_ds_change_name_tab(kids_report, "vx_MAST2_report_23_idx_consegne") // Aggiorna SQL della dw	
		end if
	end if
	
	k_rc = kids_report.settransobject( kguo_sqlca_db_magazzino )
	kids_report.retrieve()

end subroutine

event constructor;//
//--- dati da restituire - il Report 
kids_report = create datastore
kids_report.dataobject = "d_etichette_lotti_x2"
kids_report.settransobject(sqlca)

end event

on kuf_report_indici_run.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_report_indici_run.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//
if not isnull(kids_report) then destroy kids_report




end event

