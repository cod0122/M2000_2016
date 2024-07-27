$PBExportHeader$kuf_stat_invent.sru
forward
global type kuf_stat_invent from kuf_parent
end type
end forward

global type kuf_stat_invent from kuf_parent
end type
global kuf_stat_invent kuf_stat_invent

type variables
//
private st_stat_invent kist_stat_invent_crea_view_6
private st_stat_invent kist_stat_invent_crea_GiacenzaXData
private st_stat_invent kist_stat_invent_crea_view_6_nolav

end variables

forward prototypes
public function boolean visualizza_importi ()
public function string crea_view_6 (st_stat_invent ast_stat_invent) throws uo_exception
public function string old_crea_view_6_nolav (st_stat_invent ast_stat_invent) throws uo_exception
public subroutine old_crea_view_altri_dati (st_stat_invent kast_stat_invent)
private subroutine old_crea_view_x_data_fatt (st_stat_invent kast_stat_invent)
private subroutine old_crea_view_x_data_fatt_id_armo (st_stat_invent kast_stat_invent) throws uo_exception
private subroutine old_crea_view_x_data_fatt_id_meca (st_stat_invent kast_stat_invent)
private subroutine get_id_meca_min_max (ref st_stat_invent ast_stat_invent) throws uo_exception
public function string crea_view_giacenze_x_data (st_stat_invent ast_stat_invent) throws uo_exception
private function string u_crea_view_stat_inv_pilota (string a_view_name, st_stat_invent ast_stat_invent) throws uo_exception
private function string u_crea_view_stat_inv_entrate (string a_view_name, string a_view_name_pilota, st_stat_invent ast_stat_invent) throws uo_exception
private function string u_crea_view_stat_inv_trattati (string a_view_name, string a_view_name_pilota, st_stat_invent ast_stat_invent) throws uo_exception
private function string u_crea_view_stat_inv_danontrattare (string a_view_name, string a_view_name_pilota, st_stat_invent ast_stat_invent) throws uo_exception
private function string u_crea_view_stat_int_spediti (string a_view_name, string a_view_name_pilota, st_stat_invent ast_stat_invent) throws uo_exception
private function string u_crea_view_stat_inv_finale (string a_view_name, string a_view_name_entrate, string a_view_name_trattati, string a_view_name_danontrattatare, string a_view_name_spediti, string a_view_name_pilota, st_stat_invent ast_stat_invent) throws uo_exception
private function string u_crea_table_statinvtab (string a_tab_name, string a_view_name_statinvfinale) throws uo_exception
private function string u_get_dati_tab_statinvtab (string a_tab_name, st_stat_invent ast_stat_invent) throws uo_exception
private function string u_insert_table_statinvtab_giacenze (string a_tab_name, string a_view_name_statinvfinale) throws uo_exception
private function string u_crea_table_statinvtab_giacenze (string a_tab_name, string a_view_name_statinvfinale) throws uo_exception
private function string u_insert_table_statinvtab_bloccati (string a_tab_name, st_stat_invent ast_stat_invent) throws uo_exception
private function string u_crea_view_stat_inv_entrate_x_giacenze (string a_view_name, string a_view_name_pilota, st_stat_invent ast_stat_invent) throws uo_exception
private function string u_crea_view_stat_inv_trattati_x_giacenze (string a_view_name, string a_view_name_pilota, st_stat_invent ast_stat_invent) throws uo_exception
private function string u_crea_view_stat_int_spediti_x_giacenze (string a_view_name, string a_view_name_pilota, st_stat_invent ast_stat_invent) throws uo_exception
private function string u_crea_view_stat_inv_finale_x_giacenze (string a_view_name, string a_view_name_entrate, string a_view_name_trattati, string a_view_name_danontrattatare, string a_view_name_spediti, string a_view_name_pilota, st_stat_invent ast_stat_invent) throws uo_exception
private function string u_crea_view_stat_inv_pilota_giacenze (string a_view_name, st_stat_invent ast_stat_invent) throws uo_exception
end prototypes

public function boolean visualizza_importi ();//
//--- Verifica le autorizzazioni x visualizzare gli importi
//--- Ritorna: TRUE=autorizzato/FALSE=non autorizzato
//
boolean k_return
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
kuf_listino kuf1_listino
kuf_fatt kuf1_fatt


	kuf1_listino = create kuf_listino
	kuf1_fatt = create kuf_fatt
	kuf1_sicurezza = create kuf_sicurezza

//--- utente autorizzato almeno alla visualizzazione Listini
	kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	kst_open_w.id_programma = kuf1_listino.get_id_programma( kst_open_w.flag_modalita )
	k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	
	if not k_return then
//--- utente autorizzato almeno alla visualizzazione Fatture
		kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
		kst_open_w.id_programma = kuf1_fatt.get_id_programma( kst_open_w.flag_modalita )
		k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	end if	
	
	destroy kuf1_sicurezza
	destroy kuf1_listino
	destroy kuf1_fatt

return k_return

end function

public function string crea_view_6 (st_stat_invent ast_stat_invent) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------------------------------------------
//--- Crea la TEMP TABLE per le query INVENTARIO
//--- Torna il nome della TABELLA (se vuoto qls è andato male)
//----------------------------------------------------------------------------------------------------------------------------------------------------
//
int k_ctr
string k_view, k_sql, k_sql_orig, k_stringn, k_string, k_campi
string k_sql_w
string k_return
string k_vx_statInv
string k_vx_statInvEntrate
string k_vx_statInvTrattati
string k_vx_statInvDaNonTrattare
string k_vx_statInvSped
string k_vx_statInvFinale
string k_vx_statInvTab
//kuf_utility kuf1_utility


try
	
	SetPointer(kkg.pointer_attesa)

//--- elabora solo se i parametri di entrata sono cambiati
	if kist_stat_invent_crea_view_6 = ast_stat_invent then
		
	else
		kist_stat_invent_crea_view_6 = ast_stat_invent
	
//		kuf1_utility = create kuf_utility
	
//--- recupera ID minimo e max su cui fare le query
		get_id_meca_min_max(ast_stat_invent)

		k_vx_statInv = "vx_" + trim(ast_stat_invent.utente) + "_statInv" + string(ast_stat_invent.stat_tab)
		k_vx_statInvEntrate = "vx_" + trim(ast_stat_invent.utente) + "_statInvEntrate" + string(ast_stat_invent.stat_tab)
		k_vx_statInvTrattati = "vx_" + trim(ast_stat_invent.utente) + "_statInvTrattati"  + string(ast_stat_invent.stat_tab)
		k_vx_statInvDaNonTrattare = "vx_" + trim(ast_stat_invent.utente) + "_statInvDaNonTrattare"  + string(ast_stat_invent.stat_tab)	
		k_vx_statInvSped = "vx_" + trim(ast_stat_invent.utente) + "_statInvSped"  + string(ast_stat_invent.stat_tab)	
		k_vx_statInvFinale = "vx_" + trim(ast_stat_invent.utente) + "_statInvFinale" + string(ast_stat_invent.stat_tab)
		k_vx_statInvTab = "#" + kguf_data_base.u_change_nometab_xutente( "vx_MAST_statinvTab" + string(ast_stat_invent.stat_tab))
	
//--- costruisco view del Lotti Pilota
		u_crea_view_stat_inv_pilota(k_vx_statInv, ast_stat_invent)
	
//--- costruisco view dei totali Entrati per Lotto
		u_crea_view_stat_inv_entrate(k_vx_statInvEntrate, k_vx_statInv, ast_stat_invent)
	
//--- costruisco la view dei Trattati  
		u_crea_view_stat_inv_trattati(k_vx_statInvTrattati, k_vx_statInv, ast_stat_invent)
	
//--- costruisco la view dei Barcode Magazzino 2 da NON trattare (causale='T' e Magazzino da Trattare (=2)) 
		u_crea_view_stat_inv_danontrattare(k_vx_statInvDaNonTrattare, k_vx_statInv, ast_stat_invent)
	
//		if ast_stat_invent.flag_check_spediti then  // SE RICHIESTO LEGGE ANCHE TAB DDT SPEDITI
//--- costruisco la view dei  Spediti (Ritirati) 
		u_crea_view_stat_int_spediti(k_vx_statInvSped, k_vx_statInv, ast_stat_invent)
			
//--- Metto insieme le view e faccio una tabella....
		u_crea_view_stat_inv_finale(k_vx_statInvFinale, k_vx_statInvEntrate, k_vx_statInvTrattati, k_vx_statInvDaNonTrattare, k_vx_statInvSped, k_vx_statInv, ast_stat_invent)

		SetPointer(kkg.pointer_attesa)
	
//--- costruisco la temp-table con valorizzazione x singolo Lotto 
		u_crea_table_statinvtab(k_vx_statInvTab, k_vx_statInvFinale)
		
	end if
	
	k_return = k_vx_statInvTab

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
//	if isvalid(kuf1_utility) then destroy kuf1_utility
	
	SetPointer(kkg.pointer_default)

end try

return k_return
//
end function

public function string old_crea_view_6_nolav (st_stat_invent ast_stat_invent) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------------------------------------------
//--- Crea la TEMP TABLE per le query - MATERIALE NON TRATTATO ES CONTO DEPOSITO
//--- Torna il nome della TABELLA (se vuoto qls è andato male)
//----------------------------------------------------------------------------------------------------------------------------------------------------
//
int k_ctr
string k_view, k_sql, k_sql_w, k_sql_orig, k_stringn, k_string, k_campi
string  k_return = ""
st_tab_armo kst_tab_armo
kuf_armo kuf1_armo
kuf_utility kuf1_utility
pointer kpointer  


try
	kpointer = SetPointer(HourGlass!)

//--- elabora solo se i parametri di entrata sono cambiati
	if kist_stat_invent_crea_view_6_nolav = ast_stat_invent then
		
	else
		kist_stat_invent_crea_view_6_nolav = ast_stat_invent
	
		kuf1_utility = create kuf_utility
		kuf1_armo = create kuf_armo

	//--- recupera ID minimo e max su cui fare le query
		get_id_meca_min_max(ast_stat_invent)
	
//	//--- crea la view con i riferimenti solo x le date fattura comprese come indicato
//		crea_view_x_data_fatt(ast_stat_invent)
//		crea_view_x_data_fatt_id_meca(ast_stat_invent)
	
	//--- costruisco la view dei Lotti entrati 
		k_view = "vx_" + trim(ast_stat_invent.utente) + "_statEntrate" + string(ast_stat_invent.stat_tab)	
		k_sql_w = " "
		k_sql = " " 
		k_sql = "CREATE VIEW " + trim(k_view) + " ( id_meca, id_armo, colli ) AS   "  
		k_sql +=  &
				 + " SELECT distinct " &
				 + " s_armo.id_meca " &
				 + " ,s_armo.id_armo " &
				 + " ,sum(s_armo.colli_2) " &
				 + " FROM s_armo  " &
				 + "      INNER JOIN meca    ON  s_armo.id_meca = meca.id " &
				 + "	where "  &
				 + " s_armo.id_meca between " + string(ast_stat_invent.id_meca_da) + " and "+ string(ast_stat_invent.id_meca_a) &
				 + " and (meca.stato = 0 or meca.stato is null) " &
				 + " and ((meca.aperto <> 'N' and meca.aperto <> 'A') or meca.aperto is null) " &
				 + " and meca.data_ent between '" + string(ast_stat_invent.data_da ) + "' and '"+ string(ast_stat_invent.data_a) + "' " 

		if ast_stat_invent.id_cliente > 0 then
			k_sql_w =  " and s_armo.clie_3 = " + string(ast_stat_invent.id_cliente) + " "
		end if
		if ast_stat_invent.id_gruppo > 0 then
			if ast_stat_invent.gruppo_flag = 1 then
				k_sql_w += " and s_armo.gruppo = " + string(ast_stat_invent.id_gruppo) + " "
			else
				k_sql_w += " and s_armo.gruppo <> " + string(ast_stat_invent.id_gruppo) + " "
			end if
		end if
		if ast_stat_invent.magazzino <> 9 then
			k_sql_w = k_sql_w + " and s_armo.magazzino = " + string(ast_stat_invent.magazzino) + " "
		end if
		k_sql_w = k_sql_w + " group by s_armo.id_meca ,s_armo.id_armo  "
		k_sql += " " + trim(k_sql_w)  //+ " group by 1, 2  "
		kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		


	//--- costruisco la view dei  Spediti (Ritirati) 
		k_view = "vx_" + trim(ast_stat_invent.utente) + "_statSped"  + string(ast_stat_invent.stat_tab)	
		k_sql_w = " "
		k_sql = " " 
		k_sql = "CREATE VIEW " + trim(k_view) + " ( id_meca, id_armo, colli ) AS   "  
		k_sql +=  &
				 + " SELECT " &
				 + " s_arsp.id_meca " &
				 + " ,s_arsp.id_armo " &
				 + " ,sum(coalesce(s_arsp.colli,0))  as colli " &
				 + " FROM  s_arsp " 
		k_sql +=  &
				 "	  where (s_arsp.data_rit > '" + string(date(0)) + "' "  &  
				 + "	      and s_arsp.data_rit <= '" + string(ast_stat_invent.data_a, "dd/mm/yyyy") + "')  "  &
				 + "   and s_arsp.id_armo in ( " &
				 + " SELECT distinct " &
				 + " a.id_armo " &
				 + " FROM " + "vx_" + trim(ast_stat_invent.utente) + "_statEntrate" + string(ast_stat_invent.stat_tab) + " as a  " &
				 + " ) " 
		k_sql += " group by s_arsp.id_meca, s_arsp.id_armo  "
		kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		


	//--- costruisco la view dei Rif Trattati meno gli Spediti (Ritirati) maggiori di zero 
		k_view = "vx_" + trim(ast_stat_invent.utente) + "_statNoSped" + string(ast_stat_invent.stat_tab)	
		k_sql_w = " "
		k_sql = " " 
		k_sql =  &
		"CREATE VIEW " + trim(k_view) + " ( id_meca, id_armo, colli ) AS   "  
		k_sql +=  &
				 + " SELECT " &
				 + " a.id_meca " &
				 + " ,a.id_armo " &
				 + " ,a.colli - coalesce(s.colli,0)  as colli " &
				 + " FROM   vx_" + trim(ast_stat_invent.utente) + "_statEntrate" + string(ast_stat_invent.stat_tab) + " as a  " & 
				 + "   left outer join  vx_" + trim(ast_stat_invent.utente) + "_statSped" + string(ast_stat_invent.stat_tab) + " as s  on " & 
				 + "   a.id_armo = s.id_armo " &
					 + "  where s.colli is null or a.colli > s.colli " 
		kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		


	//--- costruisco la view con Entrata
		k_view = "vx_" + trim(ast_stat_invent.utente) + "_statarmo5" + string(ast_stat_invent.stat_tab)	
		k_sql_w = " "
		k_sql = + &
		"CREATE VIEW " + trim(k_view) + " ( id_meca, id_armo, colli_2, m_cubi, pedane, importo ) AS   " 
		k_sql =  k_sql &
				 + " SELECT  " &
				 + " s_armo.id_meca " &
				 + " ,s_armo.id_armo " &
				 + " ,sum(s_armo.colli_2) " & 
				 + " ,sum(s_armo.m_cubi / s_armo.colli_2) " & 
				 + " ,sum(s_armo.pedane / s_armo.colli_2) " &
				 + " ,sum( (coalesce(s_armo.imp_fatt,0) + coalesce(s_armo.imp_da_fatt,0)) / s_armo.colli_2 ) " &
				 + " FROM s_armo  " &
				 + "	where " &  
				 + "	  s_armo.id_armo in (select distinct id_armo from " &
				 + " vx_" + trim(ast_stat_invent.utente) + "_statNoSped" + string(ast_stat_invent.stat_tab) + ") " 
		k_sql += " group by s_arsp.id_meca, s_arsp.id_armo  "
		kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
	
	
	//--- costruisco la view con colli_fatturati
		k_view = "vx_" + trim(ast_stat_invent.utente) + "_statarfa5" + string(ast_stat_invent.stat_tab)	
		k_sql_w = " "
		k_sql = "CREATE VIEW " + trim(k_view) + " ( id_armo,  colli_fatt) AS   " 
		k_sql += &
				 + " SELECT distinct " &
				 + " id_armo " &
				 + " ,sum(colli) " &   
				 + " FROM arfa  " &
				 + "	where " &  
				 + "	  arfa.tipo_doc = 'FT' and arfa.id_armo in (select distinct id_armo from " &
				 + " vx_" + trim(ast_stat_invent.utente) + "_statNoSped" + string(ast_stat_invent.stat_tab) + " " + ") "  
		if ast_stat_invent.flag_fatturati = "N" or ast_stat_invent.flag_fatturati = "S" then
			k_sql += " and data_fatt between '" + string(ast_stat_invent.data_da) + "' and '" + string(ast_stat_invent.data_a) + "'"
		end if
		k_sql += " group by arfa.id_armo "
		kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
	
	//--- Union delle tabelle per simularne una sola
		k_view = "vx_" + trim(ast_stat_invent.utente) + "_statinv_5" + string(ast_stat_invent.stat_tab)	
		k_sql_w = " "
		k_sql = + &
		"CREATE VIEW " + trim(k_view) &
		 + " (id_meca,  id_armo, colli_lav, colli_trattati_da_sped, colli_2,  colli_sped, colli_fatt, m_cubi, pedane, importo) AS   " & 
		 + " SELECT " &
		 + " r.id_meca, " &
		 + " r.id_armo, " &
		 + " 0, " &   
		 + " 0,  " &   
		 + " sum(r.colli_2), " &   
		 + " 0, " &   
		 + " 0, " &   
		 + " sum(r.m_cubi), " &   
		 + " sum(r.pedane), " &
		 + " r.importo " &
		 + " FROM vx_" + trim(ast_stat_invent.utente) + "_statarmo5" + string(ast_stat_invent.stat_tab) + " " + " as r  " &  
		 + " group by  "  &
			 + " r.id_meca, " &
			 + " r.id_armo, " &
			 + " r.importo " &
		 + " union all " &
		 + " SELECT " &
		 + " nosp.id_meca, " &
		 + " nosp.id_armo, " &
		 + " 0,  " &   
		 + " sum(nosp.colli),  " &   
		 + " 0, " &   
		 + " 0, " &   
		 + " 0, " &   
		 + " 0, " &   
		 + " 0, " &
		 + " 0 " &
		 + " FROM vx_" + trim(ast_stat_invent.utente) + "_statNoSped" + string(ast_stat_invent.stat_tab) + " " + " as nosp " &
		 + "          inner join vx_" + trim(ast_stat_invent.utente) + "_statEntrate" + string(ast_stat_invent.stat_tab) + " as ent on  " &	 
		 + " nosp.id_armo = ent.id_armo " &
		 + " group by " & 
			 + " nosp.id_meca, " &
			 + " nosp.id_armo " 
		k_sql = k_sql + " " + trim(k_sql_w) 
		kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
	
	//--- costruisco la view con valorizzazione x singola riga Lotto 
		k_view = "vx_" + trim(ast_stat_invent.utente) + "_statinv15" + string(ast_stat_invent.stat_tab)	
		k_sql_w = " "
		k_sql = + &
		"CREATE VIEW " + trim(k_view) &
		 + " (id_meca,  id_armo, colli_2, colli_lav, colli_trattati_da_sped, colli_da_sped, colli_fatt,  m_cubi, pedane, importo) AS   " & 
		 + " SELECT " &
		 + " s.id_meca, " &
		 + " s.id_armo, " &
		 + " sum(s.colli_2), " &   
		 + " sum(s.colli_lav),  " &   
		 + " sum(s.colli_trattati_da_sped),  " &   
		 + " sum(s.colli_2) - sum(s.colli_sped), " &   
		 + " f.colli_fatt,  " &   
		 + " sum(s.m_cubi)  * (sum(s.colli_trattati_da_sped)), " &   
		 + " sum(s.pedane)  * (sum(s.colli_trattati_da_sped)), " &   
		 + " sum(s.importo) * (sum(s.colli_trattati_da_sped)) " &   
		 + " FROM vx_" + trim(ast_stat_invent.utente) + "_statinv_5" + string(ast_stat_invent.stat_tab) + " as s left outer join vx_" + trim(ast_stat_invent.utente) + "_statarfa5" + string(ast_stat_invent.stat_tab) + " as f on " &
		 + "  s.id_armo = f.id_armo "  
		k_sql = k_sql + " " + trim(k_sql_w) + &
		" group by " &
			 + " s.id_meca, " &
			 + " s.id_armo, " &
			 + " f.colli_fatt "    
		kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
	
	//--- costruisco la temp-table con valorizzazione x singolo Lotto 
		k_view = "#vx_" + trim(ast_stat_invent.utente) + "_statinv25" + string(ast_stat_invent.stat_tab)	
		k_sql_w = " "
		k_sql =  &
		 + " SELECT distinct" &
		 + " s.id_meca, " &
		 + " s_armo.num_int, " &
		 + " s_armo.data_int, " &
		 + " s_armo.data_ent, " &
		 + " s_armo.clie_1, " &
		 + " s_armo.clie_2, " &
		 + " s_armo.clie_3, " &
		 + " (s.colli_2),  " &   
		 + " (s.colli_lav),  " &   
		 + " (s.colli_trattati_da_sped),  " &   
		 + " (s.colli_da_sped),  " &   
		 + " (s.colli_fatt),  " &   
		 + " (s.m_cubi), " &   
		 + " (s.pedane), " &   
		 + " (s.importo) " &   
		 + " FROM vx_" + trim(ast_stat_invent.utente) + "_statinv15" + string(ast_stat_invent.stat_tab) + " as s  " &
		 + "             INNER JOIN s_armo ON " &
		 + "  s.id_meca = s_armo.id_meca " 
		k_sql +=  " " + trim(k_sql_w) 
	//	" group by 1, 2, 3, 4, 5, 6 "
		k_campi =  &
				 + " id_meca integer" &
				 + " ,num_int integer " &
				 + " ,data_int date " &
				 + " ,data_ent datetime " &
				 + " ,clie_1 integer " &
				 + " ,clie_2 integer " &
				 + " ,clie_3 integer " &
				 + " ,colli_2 integer " &
				 + " ,colli_lav integer " &
				 + " ,colli_trattati_da_sped integer " &
				 + " ,colli_da_sped integer " &
				 + " ,colli_fatt integer " & 
				 + " ,m_cubi decimal(9,2) " &
				 + " ,pedane decimal(5,2) " &
				 + " ,importo decimal(12,2) " 
		kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)		

	end if
	
	k_return =  "#vx_" + trim(ast_stat_invent.utente) + "_statinv25" + string(ast_stat_invent.stat_tab)	


catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_utility) then destroy kuf1_utility
	if isvalid(kuf1_armo) then destroy kuf1_armo
	
	SetPointer(kpointer)

end try

	
//--- Riprist. il vecchio puntatore : 
SetPointer(kpointer)

return k_return
//
end function

public subroutine old_crea_view_altri_dati (st_stat_invent kast_stat_invent);//----------------------------------------------------------------------------------------------------------------------------------------
//--- Crea le View per le query
//----------------------------------------------------------------------------------------------------------------------------------------
//
int k_ctr
string k_view, k_sql, k_sql_orig, k_stringn, k_string
boolean k_esegui_query=true
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable


//--- Puntatore Cursore da attesa.....
//--- Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


//--- costruisco la view x Reperire il Numero Attestato 
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_stat_num_certif"  + string(kast_stat_invent.stat_tab)
	k_sql = " "
	k_sql = &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca, num_certif ) AS   " &
	 + " SELECT distinct " &
	 + "    id_meca, max(num_certif)  " &
	 + " FROM s_armo inner join artr on s_armo.id_armo =  artr.id_armo " &
     + "      left outer join gru on s_armo.gruppo = gru.codice " & 
	 + " where " 

	choose case kast_stat_invent.tipo_data
			
		case '1', '2' // x data fine lavorazione e fatt
	 
		k_sql +=  &
			 + "	  s_armo.data_int between '" &
			 + string(relativedate(kast_stat_invent.data_da,-180), "dd/mm/yyyy") + "' and '" &
			 + string(relativedate(kast_stat_invent.data_a, +180), "dd/mm/yyyy") + "' "  

		case '3' // x data Riferimento
	 
			k_sql +=  &
			 + "	  s_armo.data_int between '" &
			 + string(kast_stat_invent.data_da, "dd/mm/yyyy") &
			 + "' and '" + string(kast_stat_invent.data_a, "dd/mm/yyyy") + "' "  

	end choose

	if kast_stat_invent.id_gruppo > 0 then
	// solo un gruppo puntuale
		if kast_stat_invent.gruppo_flag = 1 then
			k_sql += " and s_armo.gruppo = " + string(kast_stat_invent.id_gruppo) + " "
		else
	// escludi solo un gruppo (+tutti quelli da Escludere x stat)
			if kast_stat_invent.gruppo_flag = 0 then
				k_sql += " and s_armo.gruppo <> " + string(kast_stat_invent.id_gruppo) + " "
				k_sql += " and gru.escludi_da_stat_glob = 'N'  "
			else
	// tutti i gruppi (meno quelli da Escludere x stat)
				k_sql += " and gru.escludi_da_stat_glob = 'N' "
			end if
		end if
	else
		k_sql += " and gru.escludi_da_stat_glob = 'N'  "
	end if

//	if kast_stat_invent.id_gruppo > 0 then
//		if kast_stat_invent.gruppo_flag = 1 then
//			k_sql += " and s_armo.gruppo = " + string(kast_stat_invent.id_gruppo) + " "
//		else
//			if kast_stat_invent.gruppo_flag = 0 then
//				k_sql += " and (s_armo.gruppo <> " + string(kast_stat_invent.id_gruppo) + " or s_armo.gruppo is null)  "
//			end if
//		end if
//	end if
	if kast_stat_invent.magazzino <> 9 then
		k_sql += " and s_armo.magazzino = " + string(kast_stat_invent.magazzino) + " "
	end if
	choose case kast_stat_invent.no_dose
		case "S"
			k_sql += " and dose = 0 " + " "
		case "T"  // estrae tutte le dosi
			k_sql += "  " + " "
		case else
			k_sql += " and dose > 0 " + " "
	end choose
	if  kast_stat_invent.no_dose <> "S" and kast_stat_invent.dose > 0 then
		k_sql += " and s_armo.dose = " + kast_stat_invent.dose_str + " "
	end if


 	k_sql += " GROUP BY s_armo.id_meca "
	//kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		


//--- costruisco la view x Reperire il Numero Fattura + altro x id_meca
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_stat_id_fattura"  + string(kast_stat_invent.stat_tab)
	k_sql = " "
	k_sql = &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca, id_fattura ) AS   " &
	 + " SELECT distinct " &
	 + "    id_meca, max(id_fattura)   " &
	 + " FROM s_armo inner join arfa on s_armo.id_armo =  arfa.id_armo " &
     + "      left outer join gru on s_armo.gruppo = gru.codice " & 
	 + " where " 

	choose case kast_stat_invent.tipo_data
			
		case '1', '2' // x data fine lavorazione e fatt
	 
		k_sql +=  &
			 + "	  s_armo.data_int between '" &
			 + string(relativedate(kast_stat_invent.data_da,-180), "dd/mm/yyyy") + "' and '" &
			 + string(relativedate(kast_stat_invent.data_a, +180), "dd/mm/yyyy") + "' "  

		case '3' // x data Riferimento
	 
			k_sql +=  &
			 + "	  s_armo.data_int between '" &
			 + string(kast_stat_invent.data_da, "dd/mm/yyyy") &
			 + "' and '" + string(kast_stat_invent.data_a, "dd/mm/yyyy") + "' "  

	end choose

	if kast_stat_invent.id_gruppo > 0 then
	// solo un gruppo puntuale
		if kast_stat_invent.gruppo_flag = 1 then
			k_sql += " and s_armo.gruppo = " + string(kast_stat_invent.id_gruppo) + " "
		else
	// escludi solo un gruppo (+tutti quelli da Escludere x stat)
			if kast_stat_invent.gruppo_flag = 0 then
				k_sql += " and s_armo.gruppo <> " + string(kast_stat_invent.id_gruppo) + " "
				k_sql += " and gru.escludi_da_stat_glob = 'N'  "
			else
	// tutti i gruppi (meno quelli da Escludere x stat)
				k_sql += " and gru.escludi_da_stat_glob = 'N' "
			end if
		end if
	else
		k_sql += " and gru.escludi_da_stat_glob = 'N'  "
	end if

//	if kast_stat_invent.id_gruppo > 0 then
//		if kast_stat_invent.gruppo_flag = 1 then
//			k_sql += " and s_armo.gruppo = " + string(kast_stat_invent.id_gruppo) + " "
//		else
//			if kast_stat_invent.gruppo_flag = 0 then
//				k_sql += " and (s_armo.gruppo <> " + string(kast_stat_invent.id_gruppo) + " or s_armo.gruppo is null)  "
//			end if
//		end if
//	end if

	if kast_stat_invent.magazzino <> 9 then
		k_sql += " and s_armo.magazzino = " + string(kast_stat_invent.magazzino) + " "
	end if
	choose case kast_stat_invent.no_dose
		case "S"
			k_sql += " and s_armo.dose = 0 " + " "
		case "T"  // estrae tutte le dosi
			k_sql += "  " + " "
		case else
			k_sql += " and s_armo.dose > 0 " + " "
	end choose
	if  kast_stat_invent.no_dose <> "S" and kast_stat_invent.dose > 0 then
		k_sql += " and s_armo.dose = " + kast_stat_invent.dose_str + " "
	end if
 	k_sql += " GROUP BY s_armo.id_meca "
//	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	
//--- Riprist. il vecchio puntatore : 
SetPointer(kpointer)


end subroutine

private subroutine old_crea_view_x_data_fatt (st_stat_invent kast_stat_invent);//======================================================================
//=== Crea le View per le query
//======================================================================
//
int k_ctr
string k_view, k_sql, k_sql_orig, k_stringn, k_string
boolean k_esegui_query=true
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)

//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_stat_dfat "
	k_sql = " "
	k_sql = &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_armo ) AS   " 
	 
	k_sql = + k_sql &
	 + " SELECT distinct " &
	 + "     s_arfa.id_armo  " &
	 + " FROM arfa as s_arfa  " &
	 + "	where " &  
	 + "	  s_arfa.data_fatt between '" &
	 + string(kast_stat_invent.data_da, "dd/mm/yyyy") + "' and '" + string(kast_stat_invent.data_a, "dd/mm/yyyy") + "' "  

	
	if kast_stat_invent.id_cliente > 0 then
		k_sql +=  " and clie_3 = " + string(kast_stat_invent.id_cliente) + " "
	end if
	
//	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		


	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

//
end subroutine

private subroutine old_crea_view_x_data_fatt_id_armo (st_stat_invent kast_stat_invent) throws uo_exception;//======================================================================
//=== Crea le View per le query
//======================================================================
//
int k_ctr
string k_view, k_sql, k_sql_orig, k_stringn, k_string, k_campi
boolean k_esegui_query=true
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable


try

//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
	kpointer = SetPointer(HourGlass!)



//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view = "#vx_" + trim(kast_stat_invent.utente) + "_stat_mfat "
	k_sql = " "                                   
//	k_sql = + &
//	"CREATE VIEW " + trim(k_view) + " ( id_armo ) AS   " 
	k_campi = " id_armo integer   " 
	 
	k_sql = + k_sql &
	 + " SELECT distinct " &
	 + " arfa.id_armo  " &
	 + " FROM  s_arfa inner join arfa on s_arfa.num_fatt = arfa.num_fatt and s_arfa.data_fatt = arfa.data_fatt " &
	 + "	where " &  
	 + "	  s_arfa.data_fatt between '" &
	 + string(kast_stat_invent.data_da, "dd/mm/yyyy") + "' and '" + string(kast_stat_invent.data_a, "dd/mm/yyyy") + "' "  

	
	if kast_stat_invent.id_cliente > 0 then
		k_sql +=  " and s_arfa.clie_3 = " + string(kast_stat_invent.id_cliente) + " "
	end if
	if kast_stat_invent.id_gruppo > 0 then
		if kast_stat_invent.gruppo_flag = 1 then
			k_sql += " and s_arfa.gruppo = " + string(kast_stat_invent.id_gruppo) + " "
		else
			k_sql += " and s_arfa.gruppo <> " + string(kast_stat_invent.id_gruppo) + " "
		end if
	end if
	if kast_stat_invent.magazzino <> 9 then
		k_sql += " and s_arfa.magazzino = " + string(kast_stat_invent.magazzino) + " "
	end if
	if kast_stat_invent.dose > 0 then
		k_sql += " and s_arfa.dose = " + kast_stat_invent.dose_str + " "
	end if
	choose case kast_stat_invent.no_dose
		case "S"
			k_sql += " and s_arfa.dose = 0 " + " "
		case "T"  // estrae tutte le dosi
			k_sql += "  " + " "
		case else
			k_sql += " and s_arfa.dose > 0 " + " "
	end choose
	
//	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
	kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)		

catch (uo_exception kuo_exception)
	throw kuo_exception

finally	
//=== Riprist. il vecchio puntatore : 
	SetPointer(kpointer)

end try
//
end subroutine

private subroutine old_crea_view_x_data_fatt_id_meca (st_stat_invent kast_stat_invent);//======================================================================
//=== Crea le View per le query
//======================================================================
//
int k_ctr
string k_view, k_sql, k_sql_orig, k_stringn, k_string, k_campi
boolean k_esegui_query=true
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)



//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view = "#vx_" + trim(kast_stat_invent.utente) + "_stat_mfat "
	k_sql = " "                                   
//	k_sql = + &
//	"CREATE VIEW " + trim(k_view) &
//	 + " ( id_meca ) AS   " 
	k_campi = " id_meca integer   " 
	 
	k_sql = + k_sql &
	 + " SELECT distinct " &
	 + " s_arfa.id_meca  " &
	 + " FROM  s_arfa  " &
     + "      left outer join gru on s_arfa.gruppo = gru.codice " & 
	 + "	where " &  
	 + "	  s_arfa.data_fatt between '" &
	 + string(kast_stat_invent.data_da, "dd/mm/yyyy") + "' and '" + string(kast_stat_invent.data_a, "dd/mm/yyyy") + "' "  

	
	if kast_stat_invent.id_cliente > 0 then
		k_sql +=  " and clie_3 = " + string(kast_stat_invent.id_cliente) + " "
	end if

	if kast_stat_invent.id_gruppo > 0 then
	// solo un gruppo puntuale
		if kast_stat_invent.gruppo_flag = 1 then
			k_sql += " and s_arfa.gruppo = " + string(kast_stat_invent.id_gruppo) + " "
		else
	// escludi solo un gruppo (+tutti quelli da Escludere x stat)
			if kast_stat_invent.gruppo_flag = 0 then
				k_sql += " and s_arfa.gruppo <> " + string(kast_stat_invent.id_gruppo) + " "
				k_sql += " and gru.escludi_da_stat_glob = 'N'  "
			else
	// tutti i gruppi (meno quelli da Escludere x stat)
				k_sql += " and gru.escludi_da_stat_glob = 'N' "
			end if
		end if
	else
		k_sql += " and gru.escludi_da_stat_glob = 'N'  "
	end if

//	if kast_stat_invent.id_gruppo > 0 then
//		if kast_stat_invent.gruppo_flag = 1 then
//			k_sql += " and gruppo = " + string(kast_stat_invent.id_gruppo) + " "
//		else
//			k_sql += " and gruppo <> " + string(kast_stat_invent.id_gruppo) + " "
//		end if
//	end if

	if kast_stat_invent.magazzino <> 9 then
		k_sql += " and magazzino = " + string(kast_stat_invent.magazzino) + " "
	end if
	if kast_stat_invent.dose > 0 then
		k_sql += " and dose = " + kast_stat_invent.dose_str + " "
	end if
	choose case kast_stat_invent.no_dose
		case "S"
			k_sql += " and dose = 0 " + " "
		case "T"  // estrae tutte le dosi
			k_sql += "  " + " "
		case else
			k_sql += " and dose > 0 " + " "
	end choose
	
	try
	//	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
		kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)		
	catch (uo_exception kuo_exception)
		kuo_exception.scrivi_log()
	end try

	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

//return k_esegui_query
//
end subroutine

private subroutine get_id_meca_min_max (ref st_stat_invent ast_stat_invent) throws uo_exception;//
kguo_exception.inizializza(this.classname())

//--- piglio i ID_MECA rispetto alla data indicata
	select min(id_meca)
			, max(id_meca) 
	  into :ast_stat_invent.id_meca_da
				,:ast_stat_invent.id_meca_a 
	  from s_armo 
	  where data_ent between :ast_stat_invent.data_da and :ast_stat_invent.data_a 
			  and id_meca > 0
		using kguo_sqlca_db_magazzino;
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
				"Errore in lettura ID minimo e massimo dei Lotti entrati dal " + string(ast_stat_invent.data_da) &
											+ " al " + string(ast_stat_invent.data_a))
		throw kguo_exception
	end if
	if kguo_sqlca_db_magazzino.sqlcode = 100 or isnull(ast_stat_invent.id_meca_da) then
		ast_stat_invent.id_meca_da = 9999999 
	end if
	if isnull(ast_stat_invent.id_meca_a) then
		ast_stat_invent.id_meca_a = 0
	end if


end subroutine

public function string crea_view_giacenze_x_data (st_stat_invent ast_stat_invent) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------------------------------------------
//--- Crea la TEMP TABLE per le query INVENTARIO
//--- Torna il nome della TABELLA (se vuoto qls è andato male)
//----------------------------------------------------------------------------------------------------------------------------------------------------
//
int k_ctr
int k_giorniMemo = 31, k_gg
string k_view, k_sql, k_sql_orig, k_stringn, k_string, k_campi
string k_sql_w
string k_return
string k_vx_statInv
string k_vx_statInvEntrate
string k_vx_statInvTrattati
string k_vx_statInvDaNonTrattare
string k_vx_statInvSped
string k_vx_statInvFinale
string k_vx_statInvTab
st_stat_invent kst_stat_invent


try
	
	SetPointer(kkg.pointer_attesa)

//--- elabora solo se i parametri di entrata sono cambiati
	if kist_stat_invent_crea_view_6 = ast_stat_invent then
		
	else
		kist_stat_invent_crea_view_6 = ast_stat_invent
	
	//--- recupera ID minimo e max su cui fare le query
		get_id_meca_min_max(ast_stat_invent)

		k_vx_statInv = "vx_" + trim(ast_stat_invent.utente) + "_statInv" + string(ast_stat_invent.stat_tab)
		k_vx_statInvEntrate = "vx_" + trim(ast_stat_invent.utente) + "_statInvEntrate" + string(ast_stat_invent.stat_tab)
		k_vx_statInvTrattati = "vx_" + trim(ast_stat_invent.utente) + "_statInvTrattati"  + string(ast_stat_invent.stat_tab)
		k_vx_statInvDaNonTrattare = "vx_" + trim(ast_stat_invent.utente) + "_statInvDaNonTrattare"  + string(ast_stat_invent.stat_tab)	
		k_vx_statInvSped = "vx_" + trim(ast_stat_invent.utente) + "_statInvSped"  + string(ast_stat_invent.stat_tab)	
		k_vx_statInvFinale = "vx_" + trim(ast_stat_invent.utente) + "_statInvFinale" + string(ast_stat_invent.stat_tab)
		k_vx_statInvTab = "#" + kguf_data_base.u_change_nometab_xutente( "vx_MAST_statinvTab" + string(ast_stat_invent.stat_tab))
	
		kst_stat_invent = ast_stat_invent

		u_crea_view_stat_inv_pilota_giacenze(k_vx_statInv, kst_stat_invent) // ESTRAZIONE COMPLETA DEI LOTTI COINVOLTI

		kst_stat_invent.data_a = RelativeDate(ast_stat_invent.data_a, -(k_giorniMemo -1))  // calcolo fino al giorno richiesto meno un tot
	
		k_gg = 1
//--- costruisco view dei totali Entrati per Lotto
		u_crea_view_stat_inv_entrate_x_giacenze(k_vx_statInvEntrate + string(k_gg, "#"), k_vx_statInv, kst_stat_invent)
//--- costruisco la view dei Trattati  
		u_crea_view_stat_inv_trattati_x_giacenze(k_vx_statInvTrattati + string(k_gg, "#"), k_vx_statInv, kst_stat_invent)
//--- costruisco la view dei  Spediti (Ritirati) 
		u_crea_view_stat_int_spediti_x_giacenze(k_vx_statInvSped + string(k_gg, "#"), k_vx_statInv, kst_stat_invent)
//--- Metto insieme le view....
		u_crea_view_stat_inv_finale_x_giacenze(k_vx_statInvFinale + string(k_gg, "#"), k_vx_statInvEntrate + string(k_gg, "#"), k_vx_statInvTrattati + string(k_gg, "#"), k_vx_statInvDaNonTrattare + string(k_gg, "#"), k_vx_statInvSped + string(k_gg, "#"), k_vx_statInv, kst_stat_invent)

//--- costruisco la temp-table con valorizzazione x singolo Lotto 
		u_crea_table_statinvtab_giacenze(k_vx_statInvTab, k_vx_statInvFinale + string(k_gg, "#"))
//--- butto dentro alla tabella i Bloccati
		u_insert_table_statinvtab_bloccati(k_vx_statInvTab, kst_stat_invent)

		
		kst_stat_invent.data_a = RelativeDate(kst_stat_invent.data_a, +1) // data 'da' e data 'a' puntano allo stesso giorno
		kst_stat_invent.data_da = kst_stat_invent.data_a  // data 'da' e data 'a' puntano allo stesso giorno

		for k_gg = 2 to k_giorniMemo
	
		//--- costruisco view dei totali Entrati per Lotto
			u_crea_view_stat_inv_entrate_x_giacenze(k_vx_statInvEntrate + string(k_gg, "#"), k_vx_statInv, kst_stat_invent)
		
		//--- costruisco la view dei Trattati  
			u_crea_view_stat_inv_trattati_x_giacenze(k_vx_statInvTrattati + string(k_gg, "#"), k_vx_statInv, kst_stat_invent)
		
		//--- costruisco la view dei Barcode Magazzino 2 da NON trattare (causale='T' e Magazzino da Trattare (=2)) 
		//	u_crea_view_stat_inv_danontrattare(k_vx_statInvDaNonTrattare + string(k_gg, "#"), k_vx_statInv + string(k_gg, "#"), kst_stat_invent)
		
		//--- costruisco la view dei  Spediti (Ritirati) 
			u_crea_view_stat_int_spediti_x_giacenze(k_vx_statInvSped + string(k_gg, "#"), k_vx_statInv, kst_stat_invent)
				
		//--- Metto insieme le view....
			u_crea_view_stat_inv_finale_x_giacenze(k_vx_statInvFinale + string(k_gg, "#"), k_vx_statInvEntrate + string(k_gg, "#"), k_vx_statInvTrattati + string(k_gg, "#"), k_vx_statInvDaNonTrattare + string(k_gg, "#"), k_vx_statInvSped + string(k_gg, "#"), k_vx_statInv, kst_stat_invent)
			
			kst_stat_invent.data_a = RelativeDate(kst_stat_invent.data_a, +1) // data 'da' e data 'a' puntano allo stesso giorno
			kst_stat_invent.data_da = kst_stat_invent.data_a  // data 'da' e data 'a' puntano allo stesso giorno
		next

		SetPointer(kkg.pointer_attesa)
	
		kst_stat_invent = ast_stat_invent
		kst_stat_invent.data_a = RelativeDate(ast_stat_invent.data_a, -(k_giorniMemo -1))  // calcolo fino al giorno richiesto meno un tot

//--- aggiungo i dati alla temp-table dalle view x giorno generate
		for k_gg = 2 to k_giorniMemo

			u_insert_table_statinvtab_giacenze(k_vx_statInvTab, k_vx_statInvFinale + string(k_gg, "#"))
			
			kst_stat_invent.data_a = RelativeDate(kst_stat_invent.data_a, +1) // data 'da' e data 'a' puntano allo stesso giorno
			kst_stat_invent.data_da = kst_stat_invent.data_a  // data 'da' e data 'a' puntano allo stesso giorno
			u_insert_table_statinvtab_bloccati(k_vx_statInvTab, kst_stat_invent)
		next	

	end if

	k_return = k_vx_statInvTab

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
	SetPointer(kkg.pointer_default)

end try

return k_return
//
end function

private function string u_crea_view_stat_inv_pilota (string a_view_name, st_stat_invent ast_stat_invent) throws uo_exception;/*
   Crea la View Pilota INVENTARIO con i Lotti coinvolti
	Inp: nome della view, st_stat_invent valorizzata
	Rit: sql della view
*/
int k_ctr
string k_view, k_sql, k_campi
string k_sql_w
kuf_armo kuf1_armo


try
	
	SetPointer(kkg.pointer_attesa)
	
	//--- costruisco view del Lotti Pilota
	k_view = a_view_name	
	k_sql_w = ""
	k_campi =  &
			 + " data_inv date " &
			 + " ,clie_3 integer" &
			 + " ,barcode char(13)" &
			 + " ,id_meca integer" &
			 + " ,id_armo integer" &
			 + " ,causale char(1)" &
			 + " ,magazzino integer" 
	k_sql = "CREATE VIEW " + trim(k_view) &
				+ " (data_inv, clie_3, barcode, id_meca, id_armo, causale, magazzino ) AS   "  
	k_sql += &
			 + " SELECT distinct " &
			 + " '" + string(ast_stat_invent.data_a) + "' " &
			 + " ,0 " &
			 + " ,'' " &
			 + " ,0 " &
			 + " ,0 " &
			 + " ,'' " &
			 + " ,0 " &
			 + "FROM u_calendar_working " &
			+ " where " &
		     + " cal_date = '" + string(ast_stat_invent.data_a ) + "' " &
		 + "UNION " &
			 + " SELECT distinct " &
			 + " '" + string(ast_stat_invent.data_a) + "' " &
			 + " ,s_armo.clie_3 " &
			 + " ,barcode.barcode " &
			 + " ,s_armo.id_meca " &
			 + " ,s_armo.id_armo " &
			 + " ,barcode.causale " &
			 + " ,s_armo.magazzino " &
			 + " FROM s_armo INNER JOIN barcode ON barcode.id_armo = s_armo.id_armo " 
	if ast_stat_invent.id_gruppo > 0 then
		k_sql += " left outer join gru on s_armo.gruppo = gru.codice " 
	end if
	k_sql += " where "  &
			 + " s_armo.id_meca between " + string(ast_stat_invent.id_meca_da) + " and " + string(ast_stat_invent.id_meca_a) &
			 + " and s_armo.data_ent between '" + string(ast_stat_invent.data_da ) + "' and '" + string(ast_stat_invent.data_a) + "' " &
			 + " and s_armo.aperto <> 'A' and s_armo.aperto <> 'X'" 

//				 and meca.stato = 0 " & 

	if ast_stat_invent.flag_lotto_chiuso then 
		k_sql +=  " and s_armo.aperto <> 'N'"
	end if

	if ast_stat_invent.id_cliente > 0 then
		k_sql_w =  " and s_armo.clie_3 = " + string(ast_stat_invent.id_cliente) + " "
	end if
	
	if ast_stat_invent.id_gruppo > 0 then
	// solo un gruppo puntuale
		if ast_stat_invent.gruppo_flag = 1 then
			k_sql_w += " and s_armo.gruppo = " + string(ast_stat_invent.id_gruppo) + " "
		else
	// escludi solo un gruppo (+tutti quelli da Escludere x stat)
			if ast_stat_invent.gruppo_flag = 0 then
				k_sql_w += " and s_armo.gruppo <> " + string(ast_stat_invent.id_gruppo) + " "
				k_sql_w += " and gru.escludi_da_stat_glob = 'N'  "
			else
	// tutti i gruppi (meno quelli da Escludere x stat)
				k_sql_w += " and gru.escludi_da_stat_glob = 'N' "
			end if
		end if
//		else
//			k_sql_w += " and gru.escludi_da_stat_glob = 'N'  "
	end if
	if ast_stat_invent.magazzino <> kuf1_armo.kki_magazzino_tutti then
		k_sql_w = k_sql_w + " and s_armo.magazzino = " + string(ast_stat_invent.magazzino) + " "
	end if
	if ast_stat_invent.dose > 0 then
		k_sql_w = k_sql_w + " and s_armo.dose = " + ast_stat_invent.dose_str + " "
	end if
	choose case ast_stat_invent.no_dose
		case "S"
			k_sql_w += " and s_armo.dose = 0 " + " "
		case else
			k_sql_w += " and s_armo.dose > 0 " + " "
	end choose
	k_sql += " " + trim(k_sql_w)  //+ " group by 1, 2  "
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
//		kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)		


catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
	SetPointer(kkg.pointer_default)

end try

return k_sql
//
end function

private function string u_crea_view_stat_inv_entrate (string a_view_name, string a_view_name_pilota, st_stat_invent ast_stat_invent) throws uo_exception;/*
   Crea la View INVENTARIO ENTRATE
	Inp: nome della view, nome della view Pilota, st_stat_invent valorizzata
	Rit: sql della view
*/
int k_ctr
string k_view, k_sql, k_campi
string k_sql_w


try
	
	SetPointer(kkg.pointer_attesa)
	
//--- costruisco view dei totali Entrati per Lotto
	k_view = a_view_name	
	k_sql_w = ""
	k_campi =  &
			 + " id_meca integer" &
			 + " ,colli integer" &
			 + " ,m_cubi DECIMAL(9, 2)" &
			 + " ,pedane DECIMAL(9, 2)" 
	k_sql = "CREATE VIEW " + trim(k_view) &
				+ " (id_meca, colli_2, m_cubi, pedane ) AS   "  
	k_sql +=  &
			+ " SELECT " &
			+ " r.id_meca, " &
			+ " sum(r.colli_2), " &   
			+ " sum(r.m_cubi), " &   
			+ " sum(r.pedane) " &
			+ " FROM s_armo as r " &
			+ " where " &
				+ " r.id_meca in " & 
				+ " (select distinct a.id_meca " &
							 + " from " + a_view_name_pilota + " as a) " &
			+ " group by r.id_meca  "
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
//		kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)		


catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
	SetPointer(kkg.pointer_default)

end try

return k_sql
//
end function

private function string u_crea_view_stat_inv_trattati (string a_view_name, string a_view_name_pilota, st_stat_invent ast_stat_invent) throws uo_exception;/*
   Crea la View INVENTARIO lotti TRATTATI
	Inp: nome della view, nome della view Pilota, st_stat_invent valorizzata
	Rit: sql della view
*/
int k_ctr
string k_view, k_sql, k_campi
string k_sql_w


try
	
	SetPointer(kkg.pointer_attesa)
	
	//--- costruisco la view dei Trattati  
		k_view = a_view_name	
		k_sql = "CREATE VIEW " + trim(k_view) + " ( id_meca, colli ) AS   "  
		k_sql +=  &
				 + " SELECT  " &
				 + " barcode.id_meca " &
				 + " ,count(*) as colli " &
				 + " FROM " &
				      + " barcode " &
			    + " where " &
			 	 	   + " barcode.data_lav_fin between '" + string(ast_stat_invent.data_da, "dd/mm/yyyy") + "' " &
							 			   + " and '" + string(ast_stat_invent.data_a, "dd/mm/yyyy") + "' " &
						+ " and barcode.barcode in " & 
					  		 + " (select distinct a.barcode " &
					  		 		    + " from " + a_view_name_pilota + " as a) " &
				 + " group by barcode.id_meca  "
		kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
//		kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)		


catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
	SetPointer(kkg.pointer_default)

end try

return k_sql
//
end function

private function string u_crea_view_stat_inv_danontrattare (string a_view_name, string a_view_name_pilota, st_stat_invent ast_stat_invent) throws uo_exception;/*
   Crea la View INVENTARIO dei barcode da NON TRATTARE
	Inp: nome della view, nome della view Pilota, st_stat_invent valorizzata
	Rit: sql della view
*/
int k_ctr
string k_view, k_sql, k_campi
string k_sql_w
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode


try
	
	SetPointer(kkg.pointer_attesa)
	
//--- costruisco la view dei Barcode Magazzino 2 da NON trattare (causale='T' e Magazzino da Trattare (=2)) 
	kst_tab_barcode.causale = kuf1_barcode.ki_causale_non_trattare
	k_view = a_view_name
	k_sql = "CREATE VIEW " + trim(k_view) + " ( id_meca, colli ) AS   "  
	k_sql +=  &
			 + " SELECT " &
			 + " a.id_meca " &
			 + " ,count(*)  as colli " &
				 + " FROM " + a_view_name_pilota + " as a  " &
					+ " where a.causale = '"  + kst_tab_barcode.causale + "' " &
						 + " and a.magazzino = " + string(kkg_magazzino.LAVORAZIONE)  &
			 + " group by a.id_meca  "
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
//		kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)		

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
	SetPointer(kkg.pointer_default)

end try

return k_sql
//
end function

private function string u_crea_view_stat_int_spediti (string a_view_name, string a_view_name_pilota, st_stat_invent ast_stat_invent) throws uo_exception;/*
   Crea la View INVENTARIO lotti SPEDITI
	Inp: nome della view, nome della view Pilota, st_stat_invent valorizzata
	Rit: sql della view
*/
int k_ctr
string k_view, k_sql, k_campi
string k_sql_w


try
	
	SetPointer(kkg.pointer_attesa)
	
	//--- costruisco la view dei  Spediti (Ritirati) 
	k_view = a_view_name	
	k_sql_w = " "
	k_sql = " " 
	k_sql = "CREATE VIEW " + trim(k_view) + " ( id_meca, colli ) AS   "  
	k_sql +=  &
			 + " SELECT " &
			 + " s_arsp.id_meca " &
			 + " ,sum(coalesce(s_arsp.colli,0))  as colli " &
			 + " FROM s_arsp " &
			 + " where " &
				 + " s_arsp.data_rit between '" + string(ast_stat_invent.data_da, "dd/mm/yyyy") + "' " &
							 			   + " and '" + string(ast_stat_invent.data_a, "dd/mm/yyyy") + "' " &
					 + " and s_arsp.id_armo in " &
					 + " (select distinct a.id_armo " &
								 + " from " + a_view_name_pilota + " as a) " &
			 + " group by s_arsp.id_meca  "
			// + " (s_arsp.data_rit > '" + string(date(0)) + "' "  &  
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
//		kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)		

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
	SetPointer(kkg.pointer_default)

end try

return k_sql
//
end function

private function string u_crea_view_stat_inv_finale (string a_view_name, string a_view_name_entrate, string a_view_name_trattati, string a_view_name_danontrattatare, string a_view_name_spediti, string a_view_name_pilota, st_stat_invent ast_stat_invent) throws uo_exception;/*
   Crea la View INVENTARIO FINALE
	Inp: nome della view, i vari nomi delle view da caricare, nome della view Pilota, st_stat_invent valorizzata
	Rit: sql della view
*/
int k_ctr
string k_view, k_sql, k_campi


try
	
	SetPointer(kkg.pointer_attesa)
	
	//--- Union delle tabelle per simularne una sola
	k_view = a_view_name
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	  + "(id_meca, " &
	  + " data_inv, " &
	  + " clie_3, " &
	  + " colli_2, " &
	  + " m_cubi, " &
	  + " pedane," &
	  + " colli_lav," &
	  + " colli_trattati_da_sped, " &
	  + " colli_sped," &
	  + " colli_da_non_trattare) AS   " & 
	 + " SELECT distinct " &
		 + " r.id_meca, " &
		 + " r.data_inv, " &
		 + " r.clie_3, " &
		 + " isnull(entrate.colli_2,0), " &   
		 + " isnull(entrate.m_cubi,0), " &   
		 + " isnull(entrate.pedane,0), " &
		 + " isnull(trattati.colli,0), " &   
		 + " isnull(trattati.colli,0) - isnull(spediti.colli,0), " &   
		 + " isnull(spediti.colli,0), " &   
		 + " isnull(daNonTrattare.colli, 0) " &
		 + " FROM " + a_view_name_pilota + " as r  " &  
				 + " inner join " + a_view_name_entrate + " as entrate on r.id_meca = entrate.id_meca " &
				 + " left outer join " + a_view_name_trattati + " as trattati on r.id_meca = trattati.id_meca " &
				 + " left outer join " + a_view_name_spediti + " as spediti on r.id_meca = spediti.id_meca " &
				 + " left outer join " + a_view_name_danontrattatare + " as daNonTrattare on r.id_meca = daNonTrattare.id_meca " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
//		kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)		

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
	SetPointer(kkg.pointer_default)

end try

return k_sql
//
end function

private function string u_crea_table_statinvtab (string a_tab_name, string a_view_name_statinvfinale) throws uo_exception;/*
   Crea la Temp Table con i Dati della View Finale
	Inp: nome della tabella, array coi nomi delle view finali
	Rit: sql della view
*/
int k_ind, k_n_view
string k_tab, k_sql, k_campi


try

	SetPointer(kkg.pointer_attesa)

//--- costruisco la temp-table con valorizzazione x singolo Lotto 
	k_sql +=  &
				 + "SELECT distinct" &
				 + " s.data_inv, " &
				 + " s.id_meca, " &
				 + " s_armo.num_int, " &
				 + " s_armo.data_int, " &
				 + " s_armo.data_ent, " &
				 + " s_armo.clie_1, " &
				 + " s_armo.clie_2, " &
				 + " s.clie_3, " &
				 + " s.colli_2, " &   
				 + " s.colli_lav, " &   
				 + " s.colli_trattati_da_sped, " &   
				 + " s.colli_da_non_trattare, " &
				 + " s.colli_sped,  " &   
				 + " s.m_cubi, " &   
				 + " s.pedane " &   
				 + " FROM " + a_view_name_statinvfinale + " as s INNER JOIN s_armo ON s.id_meca = s_armo.id_meca " &
					+ " where s.colli_2 > s.colli_sped " 
		
	k_campi =  &
			 + " data_inv date " &
			 + " ,id_meca integer" &
			 + " ,num_int integer " &
			 + " ,data_int date " &
			 + " ,data_ent datetime " &
			 + " ,clie_1 integer " &
			 + " ,clie_2 integer " &
			 + " ,clie_3 integer " &
			 + " ,colli_2 integer " &
			 + " ,colli_lav integer " &
			 + " ,colli_trattati_da_sped integer " &
			 + " ,colli_da_non_trattare integer " &
			 + " ,colli_sped integer " &
			 + " ,m_cubi decimal(9,2) " &
			 + " ,pedane decimal(9,2) " 
	kguo_sqlca_db_magazzino.db_crea_temp_table(a_tab_name, k_campi, k_sql)		
//		kguo_sqlca_db_magazzino.db_crea_table(k_view, k_campi)		


catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	SetPointer(kkg.pointer_default)

end try

return k_sql
//
end function

private function string u_get_dati_tab_statinvtab (string a_tab_name, st_stat_invent ast_stat_invent) throws uo_exception;/*
   Get dati contatori dalla Temp Table
	Inp: nome della tabella
	out: st_stat_invent.out_...
	Rit: sql della view
*/
int k_ind, k_n_view
string k_tab, k_sql, k_campi


try

	SetPointer(kkg.pointer_attesa)

//--- costruisco la temp-table con valorizzazione x singolo Lotto 
	k_sql +=  &
				 + "SELECT " &
				 + " s.data_inv, " &
				 + " s.colli_2, " &   
				 + " s.colli_lav, " &   
				 + " s.colli_trattati_da_sped, " &   
				 + " s.colli_da_non_trattare, " &
				 + " s.colli_sped,  " &   
				 + " s.m_cubi, " &   
				 + " s.pedane " &   
				 + " FROM " + a_tab_name + " as s INNER JOIN s_armo ON s.id_meca = s_armo.id_meca " &
					+ " where s.colli_2 > s.colli_sped " 
		
	k_campi =  &
			 + " data_inv date " &
			 + " ,id_meca integer" &
			 + " ,num_int integer " &
			 + " ,data_int date " &
			 + " ,data_ent datetime " &
			 + " ,clie_1 integer " &
			 + " ,clie_2 integer " &
			 + " ,clie_3 integer " &
			 + " ,colli_2 integer " &
			 + " ,colli_lav integer " &
			 + " ,colli_trattati_da_sped integer " &
			 + " ,colli_da_non_trattare integer " &
			 + " ,colli_sped integer " &
			 + " ,m_cubi decimal(9,2) " &
			 + " ,pedane decimal(9,2) " 
	kguo_sqlca_db_magazzino.db_crea_temp_table("#" + a_tab_name, k_campi, k_sql)		
//		kguo_sqlca_db_magazzino.db_crea_table(k_view, k_campi)		

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	SetPointer(kkg.pointer_default)

end try

return k_sql
//
end function

private function string u_insert_table_statinvtab_giacenze (string a_tab_name, string a_view_name_statinvfinale) throws uo_exception;/*
   Insert nella Temp Table i Dati della View Finale
	Inp: nome della tabella, nome view con i calcoli finali
	Rit: sql della view
*/
string k_sql, k_campi


try
	SetPointer(kkg.pointer_attesa)

//--- costruisco la INSERT nella temp-table con Select
	k_campi = " data_inv " &
			 + " ,clie_3 " &
			 + " ,colli_bloccati " & 
			 + " ,colli_2 " &
			 + " ,colli_2_tot " &
			 + " ,colli_lav " &
			 + " ,colli_sped " &
			 + " ,colli_sped_tot " &
			 + " ,m_cubi " &
			 + " ,pedane " &
			 + " ,colli_giacenza " 
	k_sql =  &
			+  "SELECT " &
			+     " b.data_inv" &
			+     " ,a.clie_3" &
			+     " ,0 " &
			+     " ,b.colli_2 colli_2" &
			+     " ,(a.colli_2_tot) + b.colli_2 colli_2_tot " &
			+     " ,b.colli_lav colli_lav" &
			+     " ,b.colli_sped colli_sped" &
			+     " ,(a.colli_sped_tot) + b.colli_sped colli_sped_tot" &
			+     " ,b.m_cubi 	m_cubi" &
			+     " ,b.pedane 	pedane" &
			+     " ,(a.colli_2_tot + b.colli_2) - (a.colli_sped_tot + b.colli_sped) giacenza_colli" &
			+  " FROM " +  a_tab_name + " a inner join ( " &
			+     "select CLIE_3" &
			+        " ,data_inv" &
			+			" ,sum(colli_2) 	  colli_2" &
			+			" ,sum(colli_lav)   colli_lav" &
			+			" ,sum(colli_sped)  colli_sped" &
			+			" ,sum(m_cubi) 	  m_cubi" &
			+			" ,sum(pedane) 	  pedane" &
			+		" FROM " + a_view_name_statinvfinale  &
			+		" GROUP BY CLIE_3, data_inv " &
			+	  ") b	on a.clie_3 = b.clie_3 and a.data_inv = DATEADD(day,-1,b.data_inv)" 

	kguo_sqlca_db_magazzino.db_insert_select(a_tab_name, k_campi, k_sql)	// Alimenta la tabella 

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	SetPointer(kkg.pointer_default)

end try

return k_sql
//
end function

private function string u_crea_table_statinvtab_giacenze (string a_tab_name, string a_view_name_statinvfinale) throws uo_exception;/*
   Crea la Temp Table con i Dati della View Finale
	Inp: nome della tabella, array coi nomi delle view finali
	Rit: sql della view
*/
int k_ind, k_n_view
string k_tab, k_sql, k_campi


try
	SetPointer(kkg.pointer_attesa)
	
//--- costruisco la temp-table con valorizzazione x singolo Lotto 
	k_sql =  &
				  "SELECT distinct" &
					 + " s.data_inv, " &
					 + " s.clie_3, " &
					 + " 0 colli_bloccati, " & 
					 + " sum(s.colli_2), " &   
					 + " sum(s.colli_2), " &   
					 + " sum(s.colli_lav), " &   
					 + " sum(s.colli_sped),  " &   
					 + " sum(s.colli_sped),  " &   
					 + " sum(s.m_cubi), " &   
					 + " sum(s.pedane), " &   
					 + " sum(s.colli_2) - sum(s.colli_sped) colli_giacenza " &
				 + " FROM " + a_view_name_statinvfinale + " as s " &
				 + " group by " &
					 + " s.data_inv, " &
					 + " s.clie_3 " 
				 
	k_campi =  &
			   " data_inv date " &
			 + " ,clie_3 integer " &
			 + " ,colli_bloccati integer " &
			 + " ,colli_2 integer " &
			 + " ,colli_2_tot integer " &
			 + " ,colli_lav integer " &
			 + " ,colli_sped integer " &
			 + " ,colli_sped_tot integer " &
			 + " ,m_cubi decimal(9,2) " &
			 + " ,pedane decimal(9,2) " &
			 + " ,colli_giacenza integer " 
	kguo_sqlca_db_magazzino.db_crea_temp_table(a_tab_name, k_campi, k_sql)		

/*
  genera una tabella con i valori anzichè una temporanea

	kguo_sqlca_db_magazzino.db_crea_table(a_tab_name, k_campi)		

//			 + " ,id_meca " &
	k_campi =  &
			 + " data_inv " &
			 + " ,clie_3  " &
			 + " ,colli_bloccati " &
			 + " ,colli_2 " &
			 + " ,colli_2_tot " &
			 + " ,colli_lav " &
			 + " ,colli_sped " &
			 + " ,colli_sped_tot " &
			 + " ,m_cubi " &
			 + " ,pedane " &
			 + " ,colli_giacenza " 
	kguo_sqlca_db_magazzino.db_insert_select(a_tab_name, k_campi, k_sql)	
*/

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	SetPointer(kkg.pointer_default)

end try

return k_sql
//
end function

private function string u_insert_table_statinvtab_bloccati (string a_tab_name, st_stat_invent ast_stat_invent) throws uo_exception;/*
   Insert dei Lotti Bloccati nella Temp Table con i Dati delle View Finali
	Inp: nome della tabella
	Rit: sql della view
*/
string k_sql, k_campi


try

//	a_tab_name = "#" + a_tab_name

	SetPointer(kkg.pointer_attesa)

//--- costruisco la INSERT nella temp-table con Select
	k_campi = " data_inv " &
			 + " ,clie_3 " &
			 + " ,colli_bloccati " & 
			 + " ,colli_2 " &
			 + " ,colli_2_tot " &
			 + " ,colli_lav " &
			 + " ,colli_sped " &
			 + " ,colli_sped_tot  " &
			 + " ,m_cubi " &
			 + " ,pedane " &
			 + " ,colli_giacenza " 
	k_sql =  &
			 + "SELECT " &
           + " meca.data_int," &
           + " meca.clie_3," &
           + " sum(armo.colli_2) as colli_bloccati, " &
	 		  + " 0 colli_2," &
	 		  + " 0 colli_2_tot," &
	 		  + " 0 lav," &
			  + " 0 sped," &
			  + " 0 sped_tot," &
           + " sum(isnull(armo.m_cubi,0)) as m_cubi, " &
           + " sum(isnull(armo.pedane,0)) as pedane, " &
			  + " sum(armo.colli_2) as colli_giacenza " &
    		+ " FROM meca LEFT OUTER JOIN meca_blk ON meca.id = meca_blk.id_meca " &
			  	  + " INNER JOIN armo ON meca.id = armo.id_meca " &
			+ " where meca.data_int between '" + string(ast_stat_invent.data_da ) + "' and '" + string(ast_stat_invent.data_a) + "' " &
         	+ " and meca.stato > 0 and armo.colli_2 > 0 " &
        		+ " and (meca.aperto is not null and meca.aperto <> 'N' and meca.aperto <> 'A')" &

	if ast_stat_invent.id_cliente > 0 then
		k_sql += " and meca.clie_3 = " + string(ast_stat_invent.id_cliente) + " "
	end if

	k_sql += "group by " &
         	+ " meca.data_int," &
         	+ " meca.clie_3, " &
         	+ " meca.id " 

//	kguo_sqlca_db_magazzino.db_insert_select("#" + a_tab_name, k_campi, k_sql)	
	kguo_sqlca_db_magazzino.db_insert_select(a_tab_name, k_campi, k_sql)	// x TEST alimenta una tabella VERA

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	SetPointer(kkg.pointer_default)

end try

return k_sql
//
end function

private function string u_crea_view_stat_inv_entrate_x_giacenze (string a_view_name, string a_view_name_pilota, st_stat_invent ast_stat_invent) throws uo_exception;/*
   Crea la View INVENTARIO ENTRATEx fare il Calcolo Giacenze x data
	Inp: nome della view, nome della view Pilota, st_stat_invent valorizzata
	Rit: sql della view
*/
int k_ctr
string k_view, k_sql, k_campi
string k_sql_w


try
	
	SetPointer(kkg.pointer_attesa)
	
//--- costruisco view dei totali Entrati per Lotto
	k_view = a_view_name	
	k_sql_w = ""
	k_campi =  &
			 + " clie_3 integer" &
			 + " ,colli integer" &
			 + " ,m_cubi DECIMAL(9, 2)" &
			 + " ,pedane DECIMAL(9, 2)" 
	k_sql = "CREATE VIEW " + trim(k_view) &
				+ " (clie_3, colli_2, m_cubi, pedane ) AS   "  
	k_sql +=  &
			+ " SELECT " &
			+ " r.clie_3, " &
			+ " sum(r.colli_2), " &   
			+ " sum(r.m_cubi), " &   
			+ " sum(r.pedane) " &
			+ " FROM s_armo as r " &
			+ " where " &
			 + " r.data_ent between '" + string(ast_stat_invent.data_da ) + "' and '" + string(ast_stat_invent.data_a) + "' " &
				+ " and r.id_meca in " & 
				+ " (select distinct a.id_meca " &
							 + " from " + a_view_name_pilota + " as a) " &
			+ " group by r.clie_3  "
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
//		kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)		


catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
	SetPointer(kkg.pointer_default)

end try

return k_sql
//
end function

private function string u_crea_view_stat_inv_trattati_x_giacenze (string a_view_name, string a_view_name_pilota, st_stat_invent ast_stat_invent) throws uo_exception;/*
   Crea la View INVENTARIO lotti TRATTATI per calcolo Giacenze x data
	Inp: nome della view, nome della view Pilota, st_stat_invent valorizzata
	Rit: sql della view
*/
int k_ctr
string k_view, k_sql, k_campi
string k_sql_w


try
	
	SetPointer(kkg.pointer_attesa)
	
	//--- costruisco la view dei Trattati  
		k_view = a_view_name	
		k_sql = "CREATE VIEW " + trim(k_view) + " ( clie_3, colli ) AS   "  
		k_sql +=  &
				 + " SELECT  " &
				 + " s_armo.clie_3 " &
				 + " ,count(*) as colli " &
				 + " FROM " &
				      + " barcode inner join s_armo on barcode.id_meca = s_armo.id_meca" &
			    + " where " &
			 	 	   + " barcode.data_lav_fin between '" + string(ast_stat_invent.data_da, "dd/mm/yyyy") + "' " &
							 			   + " and '" + string(ast_stat_invent.data_a, "dd/mm/yyyy") + "' " &
						+ " and barcode.barcode in " & 
					  		 + " (select distinct a.barcode " &
					  		 		    + " from " + a_view_name_pilota + " as a) " &
				 + " group by s_armo.clie_3  "
		kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
//		kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)		


catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
	SetPointer(kkg.pointer_default)

end try

return k_sql
//
end function

private function string u_crea_view_stat_int_spediti_x_giacenze (string a_view_name, string a_view_name_pilota, st_stat_invent ast_stat_invent) throws uo_exception;/*
   Crea la View INVENTARIO lotti SPEDITI per calcolo Giacenze
	Inp: nome della view, nome della view Pilota, st_stat_invent valorizzata
	Rit: sql della view
*/
int k_ctr
string k_view, k_sql, k_campi
string k_sql_w


try
	
	SetPointer(kkg.pointer_attesa)
	
	//--- costruisco la view dei  Spediti (Ritirati) 
	k_view = a_view_name	
	k_sql_w = " "
	k_sql = " " 
	k_sql = "CREATE VIEW " + trim(k_view) + " ( clie_3, colli ) AS   "  
	k_sql +=  &
			 + " SELECT " &
			 + " s_arsp.clie_3 " &
			 + " ,sum(coalesce(s_arsp.colli,0))  as colli " &
			 + " FROM s_arsp " &
			 + " where " &
				 + " s_arsp.data_rit between '" + string(ast_stat_invent.data_da, "dd/mm/yyyy") + "' " &
							 			   + " and '" + string(ast_stat_invent.data_a, "dd/mm/yyyy") + "' " &
				 + " and s_arsp.id_armo in " &
					 + " (select distinct a.id_armo " &
								 + " from " + a_view_name_pilota + " as a) " &
			 + " group by s_arsp.clie_3  "
			// + " (s_arsp.data_rit > '" + string(date(0)) + "' "  &  
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
//		kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)		

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
	SetPointer(kkg.pointer_default)

end try

return k_sql
//
end function

private function string u_crea_view_stat_inv_finale_x_giacenze (string a_view_name, string a_view_name_entrate, string a_view_name_trattati, string a_view_name_danontrattatare, string a_view_name_spediti, string a_view_name_pilota, st_stat_invent ast_stat_invent) throws uo_exception;/*
   Crea la View INVENTARIO FINALE pr calcolo giacenze per data
	Inp: nome della view, i vari nomi delle view da caricare, nome della view Pilota, st_stat_invent valorizzata
	Rit: sql della view
*/
int k_ctr
string k_view, k_sql, k_campi


try
	
	SetPointer(kkg.pointer_attesa)
	
	//--- Union delle tabelle per simularne una sola
	k_view = a_view_name
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	  + "(" &
	  + " data_inv, " &
	  + " clie_3, " &
	  + " colli_2, " &
	  + " m_cubi, " &
	  + " pedane," &
	  + " colli_lav," &
	  + " colli_sped " &
	  + " ) AS   " & 
	 + " SELECT distinct " &
		 + " '" + string(ast_stat_invent.data_a) + "', " &
		 + " r.clie_3, " &
		 + " isnull(entrate.colli_2,0), " &   
		 + " isnull(entrate.m_cubi,0), " &   
		 + " isnull(entrate.pedane,0), " &
		 + " isnull(trattati.colli,0), " &   
		 + " isnull(spediti.colli,0) " &   
		 + " " &
		 + " FROM " + a_view_name_pilota + " as r  " &  
				 + " left outer join " + a_view_name_entrate + " as entrate on r.clie_3 = entrate.clie_3 " &
				 + " left outer join " + a_view_name_trattati + " as trattati on r.clie_3 = trattati.clie_3 " &
				 + " left outer join " + a_view_name_spediti + " as spediti on r.clie_3 = spediti.clie_3 " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
//		kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)		

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
	SetPointer(kkg.pointer_default)

end try

return k_sql
//
end function

private function string u_crea_view_stat_inv_pilota_giacenze (string a_view_name, st_stat_invent ast_stat_invent) throws uo_exception;/*
   Crea la View Pilota INVENTARIO con i Lotti coinvolti
	Inp: nome della view, st_stat_invent valorizzata
	Rit: sql della view
*/
int k_ctr
string k_view, k_sql, k_campi
string k_sql_w
kuf_armo kuf1_armo


try
	
	SetPointer(kkg.pointer_attesa)
	
	//--- costruisco view del Lotti Pilota
	k_view = a_view_name	
	k_sql_w = ""
	k_campi =  &
			 + " data_inv date " &
			 + " ,clie_3 integer" &
			 + " ,barcode char(13)" &
			 + " ,id_meca integer" &
			 + " ,id_armo integer" &
			 + " ,causale char(1)" &
			 + " ,magazzino integer" 
	k_sql = "CREATE VIEW " + trim(k_view) &
				+ " (data_inv, clie_3, barcode, id_meca, id_armo, causale, magazzino ) AS   "  
	k_sql += &
		   " SELECT distinct " &
			 + " cal.cal_date " &
			 + " ,s_armo.clie_3 " &
			 + " ,barcode.barcode " &
			 + " ,s_armo.id_meca " &
			 + " ,s_armo.id_armo " &
			 + " ,barcode.causale " &
			 + " ,s_armo.magazzino " &
			 + " FROM u_calendar_working cal left outer join s_armo on cal.cal_date = s_armo.data_ent " &
						 + " left outer JOIN barcode ON s_armo.id_armo = barcode.id_armo " 
	if ast_stat_invent.id_gruppo > 0 then
		k_sql += " left outer join gru on s_armo.gruppo = gru.codice " 
	end if
	k_sql += " where "  &
			 + " s_armo.id_meca between " + string(ast_stat_invent.id_meca_da) + " and " + string(ast_stat_invent.id_meca_a) &
			 + " and s_armo.data_ent between '" + string(ast_stat_invent.data_da ) + "' and '" + string(ast_stat_invent.data_a) + "' " &
			 + " and s_armo.aperto <> 'A' and s_armo.aperto <> 'X'" 

//				 and meca.stato = 0 " & 

	if ast_stat_invent.flag_lotto_chiuso then 
		k_sql +=  " and s_armo.aperto <> 'N'"
	end if

	if ast_stat_invent.id_cliente > 0 then
		k_sql_w =  " and s_armo.clie_3 = " + string(ast_stat_invent.id_cliente) + " "
	end if
	
	if ast_stat_invent.id_gruppo > 0 then
	// solo un gruppo puntuale
		if ast_stat_invent.gruppo_flag = 1 then
			k_sql_w += " and s_armo.gruppo = " + string(ast_stat_invent.id_gruppo) + " "
		else
	// escludi solo un gruppo (+tutti quelli da Escludere x stat)
			if ast_stat_invent.gruppo_flag = 0 then
				k_sql_w += " and s_armo.gruppo <> " + string(ast_stat_invent.id_gruppo) + " "
				k_sql_w += " and gru.escludi_da_stat_glob = 'N'  "
			else
	// tutti i gruppi (meno quelli da Escludere x stat)
				k_sql_w += " and gru.escludi_da_stat_glob = 'N' "
			end if
		end if
//		else
//			k_sql_w += " and gru.escludi_da_stat_glob = 'N'  "
	end if
	if ast_stat_invent.magazzino <> kuf1_armo.kki_magazzino_tutti then
		k_sql_w = k_sql_w + " and s_armo.magazzino = " + string(ast_stat_invent.magazzino) + " "
	end if
	if ast_stat_invent.dose > 0 then
		k_sql_w = k_sql_w + " and s_armo.dose = " + ast_stat_invent.dose_str + " "
	end if
	choose case ast_stat_invent.no_dose
		case "S"
			k_sql_w += " and s_armo.dose = 0 " + " "
		case else
			k_sql_w += " and s_armo.dose > 0 " + " "
	end choose
	k_sql += " " + trim(k_sql_w)  //+ " group by 1, 2  "
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
//		kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)		


catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
	SetPointer(kkg.pointer_default)

end try

return k_sql
//
end function

on kuf_stat_invent.create
call super::create
end on

on kuf_stat_invent.destroy
call super::destroy
end on

