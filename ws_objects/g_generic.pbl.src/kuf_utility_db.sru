$PBExportHeader$kuf_utility_db.sru
forward
global type kuf_utility_db from nonvisualobject
end type
end forward

global type kuf_utility_db from nonvisualobject
end type
global kuf_utility_db kuf_utility_db

forward prototypes
private function boolean u_crea_view_v_arfa_riga () throws uo_exception
private function boolean u_crea_view_v_arfa_tot_imponibili () throws uo_exception
private function boolean u_crea_view_v_arfa_x_id_armo () throws uo_exception
public function boolean u_crea_view () throws uo_exception
private function boolean u_crea_view_v_armo_out_colli () throws uo_exception
private function boolean u_crea_view_v_arsp_colli_x_id_armo () throws uo_exception
private function boolean u_crea_view_v_crm_listino_prezzi () throws uo_exception
private function boolean u_crea_view_v_armo_colli_inout () throws uo_exception
private function boolean u_crea_view_v_armo_out_dosezero_old () throws uo_exception
private function boolean u_crea_view_v_meca_pl () throws uo_exception
public function integer u_crea_spl_chiudi_bolle ()
private function boolean u_crea_view_e1_v_e1barcode () throws uo_exception
private function boolean u_crea_view_v_meca_dosim_barcode_max () throws uo_exception
private function boolean u_crea_view_v_alarm_instock_tosend () throws uo_exception
private function boolean u_crea_view_v_asd_barcode_all () throws uo_exception
private function boolean u_crea_view_v_contratti_all_rid () throws uo_exception
private function boolean u_crea_view_v_contratti_doc () throws uo_exception
private function boolean u_crea_view_v_ptasks_rows () throws uo_exception
private function boolean u_crea_view_v_meca_instock () throws uo_exception
private function boolean u_crea_view_v_sped_free () throws uo_exception
private function boolean u_crea_view_v_temptable_armo () throws uo_exception
private function boolean u_crea_view_v_temptable_meca () throws uo_exception
private function boolean u_crea_view_v_temptable_meca_blk () throws uo_exception
private function boolean u_crea_view_v_temptable_meca_dosimbozza () throws uo_exception
private function boolean u_crea_view_v_temptable_meca_dosim () throws uo_exception
private function boolean u_crea_view_v_temptable_meca_qtna () throws uo_exception
private function boolean u_crea_view_v_temptable_barcode () throws uo_exception
private function boolean u_crea_view_v_temptable_certif () throws uo_exception
private function boolean u_crea_view_v_temptable_sl_pt () throws uo_exception
private function boolean u_crea_view_v_temptable_sl_pt_dosimpos () throws uo_exception
private function boolean u_crea_view_v_temptable_sc_cf () throws uo_exception
private function boolean u_crea_view_v_temptable_contratti () throws uo_exception
private function boolean u_crea_view_v_temptable_listino () throws uo_exception
private function boolean u_crea_view_v_temptable_sl_pt_g3 () throws uo_exception
private function boolean u_crea_view_v_contatti () throws uo_exception
private function boolean u_crea_view_v_meca_artr_impianto () throws uo_exception
private function boolean u_tb_crea_view (string a_viewname, string a_sql) throws uo_exception
private function boolean u_crea_view_v_colli_sped () throws uo_exception
private function boolean u_crea_view_v_sped_deposito_anag () throws uo_exception
private function boolean u_crea_view_v_barcode_data_json () throws uo_exception
private function boolean u_crea_view_v_clienti_mkt_web () throws uo_exception
private function boolean u_crea_view_v_memo () throws uo_exception
private function boolean u_crea_view_v_rubrica_clienti () throws uo_exception
private function boolean u_crea_view_v_rubrica_all () throws uo_exception
private function boolean u_tb_crea_view (kuo_sqlca_db_0 auo_sqlca_db_0, string a_viewname, string a_sql) throws uo_exception
end prototypes

private function boolean u_crea_view_v_arfa_riga () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_arfa_riga'
//=== Righe fattura 
//===
int k_errore=0
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
 




//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)


	k_sql = "CREATE VIEW v_arfa_riga  " &
			 + " (num_fatt , " &
			 + " data_fatt , " &
			 + " id_arfa , " &
			 + " id_fattura , " &
			 + " id_armo , " &
			 + " id_armo_prezzo,  " &
			 + " id_arsp , " &
			 + " nriga , " &
			 + " num_bolla_out , " &
			 + " data_bolla_out , " &
			 + " tipo_riga , " &
			 + " des , " &
			 + " iva , " &
			 + " colli , " &
			 + " prezzo_u , " &
			 + " prezzo_t , " &
			 + " clie_3 , " &
			 + " tipo_doc , " &
			 + " stampa , " &
			 + " colli_out , " &
			 + " peso_kg_out , " &
			 + " tipo_l , " &
			 + " cod_pag , " & 
			 + " id_arfa_se_nc,  " &
			+ " num_int,   " &
			+ " data_int,  " &
			+ " art , " &
			+ " dose,    " &
			+ " gruppo,  " &
			+ " magazzino,   " &
			+ " id_listino,  " &
			+ " campione,  " &
			+ " alt_2,  " &
			+ " id_meca,  " &
			+ " contratto  " &
			 + ") " &
			+ " AS  " &
			+ " select  " & 
			 + " x0.num_fatt , " &
			 + " x0.data_fatt , " &
			 + " x0.id_arfa , " &
			 + " x0.id_fattura , " &
			 + " x0.id_armo , " &
			 + " x0.id_armo_prezzo,  " &
			 + " x0.id_arsp , " &
			 + " x0.nriga , " &
			 + " x0.num_bolla_out , " &
			 + " x0.data_bolla_out , " &
			 + " x0.tipo_riga , " &
			 + " x0.des , " &
			 + " x0.iva , " &
			 + " x0.colli , " &
			 + " x0.prezzo_u , " &
			 + " x0.prezzo_t , " &
			 + " x0.clie_3 , " &
			 + " x0.tipo_doc , " &
			 + " x0.stampa , " &
			 + " x0.colli_out , " &
			 + " x0.peso_kg_out , " &
			 + " x0.tipo_l , " &
			 + " x0.cod_pag , " &
			 + " x0.id_arfa_se_nc  " &
			+ "    ,x1.num_int   " &
			+ "    ,x1.data_int  " &
			+ "    ,x1.art " &
			+ "    ,x1.dose    " &
			+ "    ,x2.gruppo  " &
			+ "    ,x1.magazzino   " &
			+ "    ,x1.id_listino  " &
			+ "    ,x1.campione  " &
			+ "    ,x1.alt_2  " &
			+ "    ,x1.id_meca  " &
			+ " ,xL.contratto  " &
			 + " 	from     " &
			 + " 		arfa x0 inner join armo x1 on x1.id_armo = x0.id_armo   " &
			 + " 			   left join prodotti x2 on x2.codice = x1.art   " &
			 + " 			   left join listino xL on x1.id_listino = xL.id   " &
			 + " union all  " &
			 + "     select    " &
			 + " x3.num_fatt , " &
			 + " x3.data_fatt , " &
			 + " x3.id_arfa_v , " &
			 + " x3.id_fattura , " &
			 + " 0 , " &
			 + " 0 , " &
			 + " 0 , " &
			 + " x3.nriga , " &
			 + " 0 ,  " &
	 		 + " CONVERT(DATE, '01.01.1899'),  " &
			 + " 'V' ,  " &
			 + " x3.comm,    " &
			 + " x3.iva , " &
			 + " 0 , " &
			 + " x3.prezzo_u , " &
			 + " x3.prezzo_t , " &
			 + " x3.clie_3 , " &
			 + " x3.tipo_doc , " &
			 + " x3.stampa , " &
			 + " x3.colli , " &
			 + " 0.00 , " &
			 + " ''  , " &
			 + " x3.cod_pag , " &
			 + " 0,  " &
			 + " 0 ,  " &
	 		 + " CONVERT(DATE, '01.01.1899'),  " &
			+ "  x3.art , " &
			+ "  0,    " &
			+ "  x4.gruppo,  " &
			+ "  0,  " &
			+ "  0,   " &
			+ "  'S',  " &
			+ "  0,  " &
			+ "  0,  " &
			+ " x3.contratto  " &
			 + "  	from  arfa_v x3  " &
			 + " 				left join prodotti x4 on (x4.codice = x3.art )  " 

	EXECUTE IMMEDIATE "drop VIEW v_arfa_riga" using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_arfa_riga): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
	else
//		k_sql = "grant select on v_arfa_riga to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_arfa_riga): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			


	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_arfa_riga' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_arfa_tot_imponibili () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View
//=== 
int k_errore=0
boolean k_codice = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
 




//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)

	k_sql = "	CREATE VIEW v_arfa_tot_imponibili  (id_fattura, num_fatt,data_fatt,iva,prezzo_t) AS " &
	 + " select x0.id_fattura ,x0.num_fatt ,x0.data_fatt ,x0.iva ,sum( " &
	 + "         x0.prezzo_t ) " &
	  + "  from arfa x0 " &
	  + "  where  x0.iva > 0 " &
		+ "	 group by " &
		+ "    x0.id_fattura " &
		+ "  , x0.num_fatt " &
		+ "  , x0.data_fatt" &
		+ "  ,x0.iva " &
	+ " union all" &
		+ " Select " &
		+ "    x1.id_fattura " &
		+ "    ,x1.num_fatt " &
		+ "    ,x1.data_fatt" &
		+ "    ,x1.iva " &
		+ "    ,sum(x1.prezzo_t )" &
		 + "   from arfa_v x1" &
  		+ "  where  x1.iva > 0 " &
		+ " 	group by " &
		+ " 	    x1.id_fattura " &
		+ " 	  , x1.num_fatt " &
		+ " 	   ,x1.data_fatt " &
		+ " 	   ,x1.iva "  


	EXECUTE IMMEDIATE "drop VIEW v_arfa_tot_imponibili" using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_codice = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on V_ARFA_TOT_IMPONIBILI to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_codice = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			

	k_sql = "CREATE VIEW v_arfa  " &
	+ " (id_armo, clie_3 " &
  	+  " ,id_fattura " &
  	+  " ,num_fatt " &
	 +  " ,data_fatt " &
	  +  ",num_bolla_out " &
	  +  ",data_bolla_out " &
	  +  ",num_int, data_int  " &
 	 + " ,tipo_riga  " &
 	 + " ,nriga ,art  " &
	 + " ,iva,dose,colli  " &
  	 + " ,colli_out,peso_kg_out,prezzo_u,prezzo_t  " &
	 + " ,tipo_doc,stampa  " &
	 + " ,tipo_l " &
 	 + " ,cod_pag,prodotti_des  " &
 	 + " ,gruppo  " &
 	 + " ,magazzino  " &
 	 + " ,campione) " &
  	 + " AS  " &
      + " select x0.id_armo ,x0.clie_3 " & 
	 + "	,x0.id_fattura " & 
	 + "	,x0.num_fatt ,x0.data_fatt " & 
	  + "	,x0.num_bolla_out   " &
      + "   ,x0.data_bolla_out ,x1.num_int ,x1.data_int  " &
	 + "    ,x0.tipo_riga   " &
      + "    ,x0.nriga   " &
      + "    ,x1.art ,x0.iva ,x1.dose ,x0.colli ,x0.colli_out   " &
      + "    ,x0.peso_kg_out ,x0.prezzo_u   " &
      + "    ,x0.prezzo_t   " &
      + "    ,x0.tipo_doc   " &
      + "    ,x0.stampa   " &
      + "    ,x0.tipo_l     " &
      + "    ,x0.cod_pag  " &
      + "    ,x2.des    " &
      + "    ,x2.gruppo  " &
      + "    ,x1.magazzino   " &
      + "    ,x1.campione  " &
	 + " 	from (    " &
	 + " 		(arfa x0 join armo x1 on (x1.id_armo = x0.id_armo ) )  " &
	 + " 							left join prodotti x2 on (x2.codice = x1.art ) )  " &
 	 + " union all  " &
	 + "     select 0   " &
	 + " 		,x3.clie_3   " &
	 + " 		,x3.id_fattura   " &
	 + " 		,x3.num_fatt   " &
	 + " 		,x3.data_fatt   " &
	 + " 		,0  " &
	 + "       ,CONVERT(DATE, '01.01.1899') " &
	 + " 		,0   " &
	 + "       ,CONVERT(DATE, '01.01.1899') " &
	 + " 		,'V'   " &
      + "        ,x3.nriga  ,' '  " &
	 + " 		,x3.iva   " &
	 + " 		,0 ,x3.colli   " &
	 + " 		,x3.colli   " &
	 + " 		,0 ,x3.prezzo_u    " &
	 + " 		,x3.prezzo_t    " &
	 + " 		,x3.tipo_doc    " &
	 + " 		,x3.stampa    " &
	 + " 		,'C'    " &
	 + " 		,x3.cod_pag   " &
	 + " 		,x3.comm    " &
	 + " 		,0    " &
	 + " 		,0   " &
	 + " 		,'S'   " &
	 + "  	from  arfa_v x3  " 

	EXECUTE IMMEDIATE "drop VIEW v_arfa" using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_codice = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (2): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_arfa to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_codice = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (2): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			



	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW fatture completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(kkg.pointer_default)

return k_codice

end function

private function boolean u_crea_view_v_arfa_x_id_armo () throws uo_exception;//-----------------------------------------------------------------------------------------------------------------------------
//--- Crea la View totali x id_armo
//--- 
//--- 
//------------------------------------------------------------------------------------------------------------------------------
boolean k_return = false
string k_sql
st_esito kst_esito
st_tab_treeview kst_tab_treeview_nulla, kst_tab_treeview
st_tab_treeview kst_tab_treeview_array[]
pointer oldpointer


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname( )



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(kkg.pointer_attesa )

	k_sql = "	CREATE VIEW v_arfa_x_id_armo  " & 
			+ "(id_armo, colli, colli_out, prezzo_t) AS " &
	 		+ " select  x0.id_armo, sum(x0.colli),  sum(x0.colli_out) , sum(x0.prezzo_t)  " &
	  		+ "     from arfa x0 " &
			+ "	 group by " &
			+ "           x0.id_armo " 

	EXECUTE IMMEDIATE "drop VIEW v_arfa_x_id_armo" using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;
	if sqlca.sqlcode <> 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kguo_exception.inizializza( )
		kguo_exception.set_tipo( kguo_exception.KK_st_uo_exception_tipo_internal_bug )
		kguo_exception.set_esito(kst_esito )
		throw kguo_exception
	end if
	
//	k_sql = "grant select on v_arfa_x_id_armo to ixuser as informix"		
//	EXECUTE IMMEDIATE :k_sql using sqlca;
//	if sqlca.sqlcode <> 0 then
//		kst_esito.esito = kkg_esito.db_ko
//		kst_esito.sqlcode = sqlca.sqlcode
//		kst_esito.sqlerrtext = "Errore durante GRANT View (1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//		kguo_exception.inizializza( )
//		kguo_exception.set_tipo( kguo_exception.KK_st_uo_exception_tipo_internal_bug )
//		kguo_exception.set_esito(kst_esito )
//		throw kguo_exception
//	end if	


	SetPointer(kkg.pointer_default)

	kst_esito.nome_oggetto = this.classname()
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.sqlerrtext = "Generazione VIEW fatture completata." 
	kguo_exception.inizializza( )
	kguo_exception.set_tipo( kguo_exception.KK_st_uo_exception_tipo_OK )
	kguo_exception.set_esito(kst_esito )
	kguo_exception.scrivi_log()
	 
	k_return = true
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
		
		
end try

return k_return


end function

public function boolean u_crea_view () throws uo_exception;//-------------------------------------------------------------------------------------------------------------
//--- Lanciato probabilemente solo la prima volta x creare le diverse view utili alla Procedura
//---
//---
//-------------------------------------------------------------------------------------------------------------
//
//
boolean krc = false, k_return=true

try

	krc = u_crea_view_v_arfa_x_id_armo()
	if not krc then k_return=false
	krc = u_crea_view_v_arfa_tot_imponibili()
	if not krc then k_return=false
	krc = u_crea_view_v_arfa_riga()
	if not krc then k_return=false
	krc = u_crea_view_v_armo_out_colli()
	if not krc then k_return=false
	krc = u_crea_view_v_arsp_colli_x_id_armo()
	if not krc then k_return=false
	krc = u_crea_view_v_crm_listino_prezzi()
	if not krc then k_return=false
	krc = u_crea_view_v_armo_colli_inout()
	if not krc then k_return=false
	krc = u_crea_view_v_meca_pl()
	if not krc then k_return=false
	krc = u_crea_view_v_meca_dosim_barcode_max()
	if not krc then k_return=false
	krc = u_crea_view_v_contratti_doc()
	if not krc then k_return=false
	krc = u_crea_view_v_contratti_all_rid()
	if not krc then k_return=false
	krc = u_crea_view_v_colli_sped()
	if not krc then k_return=false
	krc = u_crea_view_v_sped_free()
	if not krc then k_return=false
	krc = u_crea_view_v_sped_deposito_anag()
	if not krc then k_return=false
	krc = u_crea_view_v_alarm_instock_tosend()
	if not krc then k_return=false
	krc = u_crea_view_v_meca_instock()
	if not krc then k_return=false
	krc = u_crea_view_v_ptasks_rows( )
	if not krc then k_return=false
	krc = u_crea_view_v_asd_barcode_all( )
	if not krc then k_return=false
	krc = u_crea_view_v_barcode_data_json( )
	if not krc then k_return=false	
	krc = u_crea_view_v_memo( )
	if not krc then k_return=false	
	krc = u_crea_view_v_rubrica_clienti()
	if not krc then k_return=false	
	krc = u_crea_view_v_rubrica_all( )
	if not krc then k_return=false	

	krc = u_crea_view_v_temptable_armo( )
	if not krc then k_return=false
	krc = u_crea_view_v_temptable_meca( )
	if not krc then k_return=false
	krc = u_crea_view_v_temptable_meca_blk( )
	if not krc then k_return=false
	krc = u_crea_view_v_temptable_meca_dosimbozza( )
	if not krc then k_return=false
	krc = u_crea_view_v_temptable_meca_dosim( )
	if not krc then k_return=false
	krc = u_crea_view_v_temptable_meca_qtna( )
	if not krc then k_return=false
	krc = u_crea_view_v_temptable_barcode( )
	if not krc then k_return=false
	krc = u_crea_view_v_temptable_certif( )
	if not krc then k_return=false
	krc = u_crea_view_v_temptable_sl_pt( )
	if not krc then k_return=false	
	krc = u_crea_view_v_temptable_sl_pt_g3( )
	if not krc then k_return=false	
	krc = u_crea_view_v_temptable_sl_pt_dosimpos( )
	if not krc then k_return=false	
	krc = u_crea_view_v_temptable_sc_cf( )
	if not krc then k_return=false	
	krc = u_crea_view_v_temptable_contratti( )	
	if not krc then k_return=false	
	krc = u_crea_view_v_temptable_listino( )
	if not krc then k_return=false	
	krc = u_crea_view_v_contatti( )
	if not krc then k_return=false	
	krc = u_crea_view_v_meca_artr_impianto( )
	if not krc then k_return=false	
	krc = u_crea_view_v_clienti_mkt_web()
	if not krc then k_return=false	
	
	kguo_sqlca_db_magazzino.db_commit( )

	if not k_return then
		kguo_exception.messaggio_utente()
	end if

catch (uo_exception kuo_exception)
	k_return = false
	kuo_exception.messaggio_utente()
	
end try

return k_return 

end function

private function boolean u_crea_view_v_armo_out_colli () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_armo_out_colli'
//=== Righe fattura 
//===
int k_errore=0
boolean k_codice = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
 




//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)


	k_sql = "CREATE VIEW v_armo_out_colli  (" &
			+ " id_armo,   " &
				+ " colli   " &
				+ ") " &
				+ " AS  " &
				+ " select  " & 
				+ " armo_out.id_armo,  " &  
				+ " sum(armo_out.colli)    " &
				+ " from armo_out " &
				+ " group by id_armo "

	EXECUTE IMMEDIATE "drop VIEW v_armo_out_colli" using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_codice = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_armo_out_colli): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_armo_out_colli to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_codice = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_armo_out_colli): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			


	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_armo_out_colli' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(kkg.pointer_default)

return k_codice

end function

private function boolean u_crea_view_v_arsp_colli_x_id_armo () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_arfa_riga'
//=== Righe fattura 
//===
int k_errore=0
boolean k_codice = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
 




//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)


	k_sql = "CREATE VIEW v_arsp_colli_x_id_armo  (" &
			+ " id_armo,   " &
				+ " colli   " &
				+ ") " &
				+ " AS  " &
				+ " select  " & 
				+ " arsp.id_armo,  " &  
				+ " sum(arsp.colli)    " &
				+ " from arsp " &
				+ " group by id_armo "

	EXECUTE IMMEDIATE "drop VIEW v_arsp_colli_x_id_armo" using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_codice = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_arsp_colli_x_id_armo): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_arsp_colli_x_id_armo to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_codice = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_arsp_colli_x_id_armo): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			


	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_arsp_colli_x_id_armo' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(kkg.pointer_default)

return k_codice

end function

private function boolean u_crea_view_v_crm_listino_prezzi () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_crm_listino_prezzi' x CRM esterno
//=== Righe prezzi Listino
//===
int k_errore=0
boolean k_codice = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
 




//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)


	k_sql = "CREATE VIEW v_crm_listino_prezzi  (" &
                           + " id_listino,   " &
         				+ " prezzo,      " &
         				+ " id_listino_voce,   " &
         				+ " voce_decriz,   " &
         				+ " id_cond_fatt,      " &
         				+ " cond_fatt_descriz     " &
				+ " ) as   " &
  				+ " SELECT listino.id,      " &
         				+ " listino.prezzo,      " &
         				+ " 0,   " &
         				+ " '',   " &
         				+ " listino.id_cond_fatt_1,      " &
         				+ " cond_fatt.descr     " &
    				+ " FROM listino LEFT OUTER JOIN cond_fatt ON listino.id_cond_fatt_1 = cond_fatt.id   " &
   				+ " WHERE   " &
         				+ " listino.attivo = 'S' and attiva_listino_pregruppi <> 'S' and prezzo > 0      " &
		+ " union all   " &
				+ "   SELECT listino.id,      " &
         				+ " listino.prezzo_2,      " &
         				+ " 0,   " &
         				+ " '',   " &
         				+ " listino.id_cond_fatt_2,      " &
        			 	    + " cond_fatt.descr     " &
    				+ " FROM listino LEFT OUTER JOIN cond_fatt ON listino.id_cond_fatt_2 = cond_fatt.id   " &
   				+ " WHERE  listino.attivo = 'S' and attiva_listino_pregruppi <> 'S' and prezzo_2 > 0     " & 
		+ " union all   " &
  				+ " SELECT listino.id,      " &
         				+ " listino.prezzo_3,      " &
         				+ " 0,   " &
         				+ " '',   " &
         				+ " listino.id_cond_fatt_3,      " &
         				+ " cond_fatt.descr     " &
    				+ " FROM listino LEFT OUTER JOIN cond_fatt ON listino.id_cond_fatt_3 = cond_fatt.id   " &
   				+ " WHERE   " &
         				+ " listino.attivo = 'S' and attiva_listino_pregruppi <> 'S' and prezzo_3 > 0      " &
		+ " union all   " &   
  				+ " SELECT listino.id,   " &   
         				+ " listino_pregruppi_voci.prezzo,      " &
         				+ " listino_pregruppi_voci.id_listino_voce,      " &
         				+ " listino_voci.descr,      " &
         				+ " listino_link_pregruppi.id_cond_fatt,      " &
         				+ " cond_fatt.descr     " &
    				+ " FROM listino LEFT OUTER JOIN listino_link_pregruppi ON listino.id = listino_link_pregruppi.id_listino    " &
                         				+ " LEFT OUTER JOIN cond_fatt ON listino_link_pregruppi.id_cond_fatt = cond_fatt.id    " &
                         				+ " INNER JOIN listino_pregruppi_voci ON listino_link_pregruppi.id_listino_pregruppo = listino_pregruppi_voci.id_listino_pregruppo       " &
                         				+ " INNER JOIN listino_voci ON  listino_pregruppi_voci.id_listino_voce = listino_voci.id_listino_voce       " &
   				+ " WHERE    " &
         				+ " ( ( listino.attivo = 'S' and attiva_listino_pregruppi = 'S' ) )     " 

	EXECUTE IMMEDIATE "drop VIEW v_crm_listino_prezzi" using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_codice = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_crm_listino_prezzi): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_crm_listino_prezzi to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_codice = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_crm_listino_prezzi): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			


	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_crm_listino_prezzi' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(kkg.pointer_default)

return k_codice

end function

private function boolean u_crea_view_v_armo_colli_inout () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_armo_colli_inout'
//=== Righe fattura 
//===
int k_errore=0
boolean k_codice = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
 




//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)

	k_sql = "CREATE VIEW v_armo_colli_inout  " &
			 + " (ID_MECA , " &
			 + " ID_ARMO , " &
			 + " COLLI_1 , " &
			 + " COLLI_2 , " &
			 + " colli_sped , " &
			 + " colli_fatt , " &
			 + " colli_trattati , " &
			 + " colli_danontrattare  " &
			 + ") " &
			+ " AS  " &
			+ " select  " & 
			 + " ARMO.ID_MECA , " &
			 + " ARMO.ID_ARMO , " &
			 + " ARMO.COLLI_1 , " &
			 + " ARMO.COLLI_2 , " &
			 + " sum(ARSP.COLLI) as colli_sped , " &
			 + " sum(0) , " &
			 + " sum(0) , " &
			 + " sum(0)  " &
			 + " from " &
			 + " 	ARMO left outer join ARSP on ARMO.ID_ARMO = ARSP.ID_ARMO  " &
          + " group by " &
			 + " ARMO.ID_MECA , " &
			 + " ARMO.ID_ARMO , " &
			 + " ARMO.COLLI_1 , " &
			 + " ARMO.COLLI_2  " &
		  + " union all  " &
			 + "     select    " &
			 + " ARMO.ID_MECA , " &
			 + " ARMO.ID_ARMO , " &
			 + " ARMO.COLLI_1 , " &
			 + " ARMO.COLLI_2 , " &
			 + " sum(0) , " &
			 + " sum(ARFA.COLLI) as colli_fatt , " &
			 + " sum(0) , " &
			 + " sum(0)  " &
			 + " from " &
			 + " 	ARMO inner join ARFA on ARMO.ID_ARMO = ARFA.ID_ARMO  " &
          + " group by " &
			 + " ARMO.ID_MECA , " &
			 + " ARMO.ID_ARMO , " &
			 + " ARMO.COLLI_1 , " &
			 + " ARMO.COLLI_2  " &
		 + " union all  " &
			 + "     select    " &
			 + " ARMO.ID_MECA , " &
			 + " ARMO.ID_ARMO , " &
			 + " ARMO.COLLI_1 , " &
			 + " ARMO.COLLI_2 , " &
			 + " sum(0) , " &
			 + " sum(0) , " &
			 + " count(barcode) as colli_trattati , " &
			 + " sum(0)  " &
			 + " from " &
			 + " 	ARMO inner join BARCODE on ARMO.ID_ARMO = BARCODE.ID_ARMO and barcode.data_lav_fin > CONVERT(DATE, '01.01.1899') " &
          + " group by " &
			 + " ARMO.ID_MECA , " &
			 + " ARMO.ID_ARMO , " &
			 + " ARMO.COLLI_1 , " &
			 + " ARMO.COLLI_2  " &
		 + " union all  " &
			 + "     select    " &
			 + " ARMO.ID_MECA , " &
			 + " ARMO.ID_ARMO , " &
			 + " ARMO.COLLI_1 , " &
			 + " ARMO.COLLI_2 , " &
			 + " sum(0) , " &
			 + " sum(0) , " &
			 + " sum(0) , " &
			 + " count(barcode) as colli_danontrattare  " &
			 + " from " &
			 + " 	ARMO inner join BARCODE on ARMO.ID_ARMO = BARCODE.ID_ARMO and barcode.causale = 'T' " &
          + " group by " &
			 + " ARMO.ID_MECA , " &
			 + " ARMO.ID_ARMO , " &
			 + " ARMO.COLLI_1 , " &
			 + " ARMO.COLLI_2  " 

//			 + " colli_nontrattati , " &

//		 + " union all  " &
//			 + "     select    " &
//			 + " ARMO.ID_MECA , " &
//			 + " ARMO.ID_ARMO , " &
//			 + " ARMO.COLLI_1 , " &
//			 + " ARMO.COLLI_2 , " &
//			 + " sum(0) , " &
//			 + " sum(0) , " &
//			 + " sum(0) , " &
//			 + " count(barcode) as colli_nontrattati , " &
//			 + " sum(0)  " &
//			 + " from " &
//			 + " 	ARMO inner join BARCODE on ARMO.ID_ARMO = BARCODE.ID_ARMO and (barcode.data_lav_fin <= date(0) or barcode.data_lav_fin is null)" &
//          + " group by " &
//			 + " ARMO.ID_MECA , " &
//			 + " ARMO.ID_ARMO , " &
//			 + " ARMO.COLLI_1 , " &
//			 + " ARMO.COLLI_2  " &

	EXECUTE IMMEDIATE "drop VIEW v_armo_colli_inout" using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_codice = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_armo_colli_inout): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_armo_colli_inout to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_codice = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_armo_colli_inout): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			


	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_armo_colli_inout' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(kkg.pointer_default)

return k_codice

end function

private function boolean u_crea_view_v_armo_out_dosezero_old () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_armo_out_dosezero'
//=== Righe fattura 
//===
int k_errore=0
boolean k_codice = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
 




//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)

	k_sql = "CREATE VIEW v_armo_out_dosezero  (" &
			+ " ID_ARMO, " &
			+ " ,colli " &
			+ ") " &
			+ " AS  " &
		+ "	select " &
			+ " ID_ARMO, " &
			+ " ,sum(arsp.colli_2) " &
			+ " from ARMO inner join arsp on armo.id_armo = arsp.id_armo " &
			+ " where ARMO.DATA_INT > today -700  and " &
			+ " ARMO.DOSE = 0 " &
			+ " group by id_armo " &
		+ " union all " &
		+ " select " &
			+ " ID_ARMO, " &
			+ " ,sum(armo_out.colli) " &
			+ " from ARMO inner join armo_out on armo.id_armo = armo_out.id_armo " &
			+ " where ARMO.DATA_INT > today -700  and " &
			+ " ARMO.DOSE = 0 " &
			+ " group by id_armo "

	EXECUTE IMMEDIATE "drop VIEW v_armo_out_dosezero" using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_codice = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_armo_out_dosezero): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_armo_out_dosezero to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_codice = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_armo_out_dosezero): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			


	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_armo_out_dosezero' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(kkg.pointer_default)

return k_codice

end function

private function boolean u_crea_view_v_meca_pl () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_meca_pl_v1' (ex v_meca_pl)
//=== Righe fattura 
//===
int k_errore=0
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
 

//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)


	k_sql = "CREATE VIEW v_meca_pl_v1  " &
			+ " (id_armo , " &
			+ " contati, " & 
         + " contati_orig, " & 
         + " data_ent, " & 
         + " data_int, " & 
         + " num_int,  " & 
         + " contratto,    " & 
         + " area_mag, " & 
			+ " area_mag_pos, "  &
         + " impianto, " & 
         + " mc_co,    " & 
         + " sc_cf,    " & 
         + " sl_pt,    " & 
         + " descr,  "   & 
         + " clie_1,    " & 
         + " clie_2,    " & 
         + " clie_3,    " & 
         + " num_bolla_in,    " & 
         + " data_bolla_in,   " & 
         + " consegna_data, " & 
         + " consegna_dataora, " & 
			+ " pl_barcode, " &
         + " fila_1,    " & 
         + " fila_2,    " & 
         + " fila_1p,    " & 
         + " fila_2p,    " & 
         + " grp " & 
         + " ,stato_in_attenzione " & 
         + " ,id " & 
         + " ,barcode_dosimetro " & 
         + " ,k_wm_associato " & 
         + " ,e1doco " & 
         + " ,e1rorn " & 
         + " ,e1srst " & 
	      + ") " &
			+ " AS  " &
			+ " select  " & 
         + " barcode.id_armo,    " & 
         + " count(*) as contati, " & 
         + " count(*) as contati_orig, " & 
         + " meca.data_ent,    " & 
         + " meca.data_int,    " & 
         + " meca.num_int,    " & 
         + " meca.contratto,    " & 
         + " isnull(meca.area_mag, ''),     " & 
			+ " isnull(substring(meca.area_mag, 5, 1), ''), "  &
         + " isnull(meca.impianto, 2) , " & 
         + " contratti.mc_co,    " & 
         + " isnull(contratti.sc_cf, ''),    " & 
         + " contratti.sl_pt,    " & 
         + " trim(contratti.descr),  "   & 
         + " meca.clie_1,    " & 
         + " meca.clie_2,    " & 
         + " meca.clie_3,    " & 
         + " meca.num_bolla_in,    " & 
         + " meca.data_bolla_in,   " & 
         + " consegna_data, " & 
         + " CONVERT(DATETIME, CONVERT(CHAR(8), consegna_data, 112) + ' ' + CONVERT(CHAR(8), coalesce(consegna_ora, '00:00:00'), 108)) , " &
			+ " isnull(barcode.pl_barcode, 0), " &
         + " isnull(barcode.fila_1, 0),    " & 
         + " isnull(barcode.fila_2, 0),    " & 
         + " isnull(barcode.fila_1p, 0),    " & 
         + " isnull(barcode.fila_2p, 0),    " & 
         + " isnull(max(barcode.groupage), '') as grp " & 
         + " ,meca.stato_in_attenzione " & 
         + " ,meca.id " & 
         + " ,'' as barcode_dosimetro" & 
         + " ,'A' as k_wm_associato " & 
         + " ,coalesce(meca.e1doco, 0) " & 
         + " ,coalesce(meca.e1rorn, 0) " & 
         + " ,coalesce(e1srst, 'NC') " & 
     + " FROM  meca " & 
          + " INNER JOIN barcode ON meca.id = barcode.id_meca " & 
          + " LEFT OUTER JOIN contratti ON meca.contratto = contratti.codice  " & 
   + " WHERE  " & 
        + "  (meca.stato = 0 or meca.stato is null)  " &
        + " and ((meca.aperto <> 'N' and meca.aperto <> 'A') or meca.aperto is null)  " &
		+ "   and (barcode.barcode_lav is null or barcode.barcode_lav = '')  " &
		 + "  and barcode.data_stampa > CONVERT(date,'01.01.1899')  " &
		 + "  and (barcode.data_sosp <= CONVERT(date,'01.01.1990') or barcode.data_sosp is null)   " &
		 + "  and (barcode.causale <> 'T' or barcode.causale is null)   " &
    + " group by " &
		 + " barcode.id_armo , " &
         + " meca.data_int,   " &
         + " meca.data_ent,   " &
         + " meca.num_int,   " &
         + " meca.contratto,  "  &
         + " meca.area_mag,   " &
         + " meca.impianto,   " &
         + " contratti.mc_co,  "  &
         + " contratti.sc_cf,  "  &
         + " contratti.sl_pt,  "  &
         + " contratti.descr,  "  &
         + " meca.clie_1,  "  &
         + " meca.clie_2,  "  &
         + " meca.clie_3,  "  &
         + " meca.num_bolla_in,  "  &
         + " meca.data_bolla_in, "  &
         + " meca.consegna_data, " &
         + " meca.consegna_ora, " &
		   + " barcode.pl_barcode, " &
         + " barcode.fila_1,   " &
         + " barcode.fila_2,  "  &
         + " barcode.fila_1p, "   &
         + " barcode.fila_2p,  "  &
         + " meca.stato_in_attenzione " &
         + " ,meca.id " &
         + " ,meca.e1doco " & 
         + " ,meca.e1rorn " &
         + " ,meca.e1srst " 


//         + " coalesce(CONVERT(DATETIME, CONVERT(CHAR(8), consegna_data, 112) + ' ' + CONVERT(CHAR(8), consegna_ora, 108)), convert(datetime, '01.01.1900 00:00:00')) , " &
//         + " meca.consegna_data, " & 
///         + " coalesce(meca.consegna_ora, convert(time, '00:00')), " & 


	EXECUTE IMMEDIATE "drop VIEW v_meca_pl_v1 " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			


	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_meca_pl_v1' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(kkg.pointer_default)

return k_return

end function

public function integer u_crea_spl_chiudi_bolle ();
//CREATE FUNCTION u_m2000_chiudi_bolle()
//		RETURNING INT
//
//   define
//      k_conta_righe           integer
//      ,k_colli_arfa           integer
//      ,k_colli_arsp           integer
//      ,K_NUM_BOLLA_OUT        like ARSP.NUM_BOLLA_OUT 
//      ,K_DATA_BOLLA_OUT       like ARSP.DATA_BOLLA_OUT 
//      ,K_ID_ARMO              like ARMO.ID_ARMO
//      ,k_data_start           date
//      ,k_gg                   integer
//      ,k_mm                   integer
//      ,k_aa                   integer
//      ,k_data_elab          date
//
//
//
//#   begin work
//
//   let K_AA    = year(today) - 1
//   let K_MM    = month(today)
//   let K_GG    = day(today)
//   if k_mm > 6 then
//      let k_mm = k_mm - 6
//   else
//      let k_aa = k_aa - 1
//      let k_mm = k_mm + 6 
//   end if
//   let k_data_start = mdy(k_mm, k_gg, k_aa)
//   
//   
//   let k_data_elab = mdy(01,01, year(today) - 1)      
//
//#--- declare per estrazione BOLLE con flag non 'F' da un anno e piu' indietro
//   declare M_ESTR_S_c_elenco_bolle cursor with hold for
//   select NUM_BOLLA_OUT, DATA_BOLLA_OUT
//       from sped 
//       where DATA_BOLLA_OUT > k_data_elab
//             and STAMPA <> 'F'
//
//#--- declare per estrazione righe BOLLA
//   declare M_ESTR_S_c_elenco_righe cursor with hold for
//   select distinct id_armo
//       from arsp 
//       where NUM_BOLLA_OUT = K_NUM_BOLLA_OUT
//             and DATA_BOLLA_OUT = K_DATA_BOLLA_OUT
//
//
//   open M_ESTR_S_c_elenco_bolle 
//
//#--- estrae le bolle non fatturate
//   foreach M_ESTR_S_c_elenco_bolle into K_NUM_BOLLA_OUT, K_DATA_BOLLA_OUT
//          
//      open M_ESTR_S_c_elenco_righe 
//
//#--- estrae la riga della bolle non fatturata
//      foreach  M_ESTR_S_c_elenco_righe into k_id_armo
//
//         select sum(colli)
//           into k_colli_arsp
//           from arsp 
//           where id_armo = k_id_armo 
//
//         let k_colli_arfa = 0 
//         select sum(colli)
//           into k_colli_arfa
//           from arfa
//           where id_armo = k_id_armo and (id_armo_prezzo = 0 or id_armo_prezzo is null)
//
//#--- se non trovato alcun collo fatturato allora tento per lotti con i prezzi spacchettati
//         if status > 0 or k_colli_arfa = 0 or k_colli_arfa is null then   
//
//            select sum(colli)
//              into k_colli_arfa
//              from arfa, armo_prezzi
//              where arfa.id_armo = k_id_armo and arfa.id_armo_prezzo > 0 
//                    and arfa.id_armo_prezzo = armo_prezzi.id_armo_prezzo and armo_prezzi.tipo_calcolo = "U"
//
//         end if
//         
//         if status >= 0 then
//         
//#--- se la riga e' stata totalmete fatturata
//            if k_colli_arfa = k_colli_arsp then 
//
//#--- aggiorna ARSP con il flag BOLLA FATTURATA              
//               update ARSP
//                 set
//                    ARSP.STAMPA = "F" 
//                 where ARSP.NUM_BOLLA_OUT  = K_NUM_BOLLA_OUT  and
//                       ARSP.DATA_BOLLA_OUT = K_DATA_BOLLA_OUT and
//                       ARSP.ID_ARMO        = K_ID_ARMO
//
//            end if
//         end if
//
//      end foreach 
//
//      CLOSE M_ESTR_S_c_elenco_righe 
//
//#--- Conta le righe bolla SENZA il flag BOLLA FATTURATA              
//      let k_conta_righe = 0
//      select count(*) into k_conta_righe
//            from arsp
//            where  ARSP.STAMPA          <> "F"
//                   and ARSP.NUM_BOLLA_OUT  = K_NUM_BOLLA_OUT  
//                   and ARSP.DATA_BOLLA_OUT = K_DATA_BOLLA_OUT 
//                   
//      if k_conta_righe = 0 then
//#--- se non ci sono piu' righe NON FATT allora aggiorna SPED con il flag BOLLA FATTURATA              
//         update SPED
//           set
//              STAMPA          = "F"
//           where NUM_BOLLA_OUT  = K_NUM_BOLLA_OUT  and
//                 DATA_BOLLA_OUT = K_DATA_BOLLA_OUT 
//      end if
//
//   end foreach 
//
//   CLOSE M_ESTR_S_c_elenco_bolle 
//
//#   commit work
//
//   if INT_FLAG != 0 then
//      goto M_ESTR_S_FORZA_FINE8
//   end if
//
//#=== Errore durante estrazione
//   if STATUS != 0 then
//      let K_STATUS = 19
//   end if
//
//   if INT_FLAG != 0 then
//      goto M_ESTR_S_FORZA_FINE8
//   end if
//      
//   goto M_ESTR_S_OK8
//
//
//label M_ESTR_S_FORZA_FINE8:
//   let K_STATUS  = 7
//
//
//label M_ESTR_S_OK8:
//
//end function
//
return 0
end function

private function boolean u_crea_view_e1_v_e1barcode () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View su DB ORACLE 'v_e1barcode' 
//=== Righe fattura 
//===
int k_errore=0
boolean k_return = true
string k_sql
st_esito kst_esito
kuf_e1_conn_cfg kuf1_e1_conn_cfg


try

//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)

	kuf1_e1_conn_cfg = create kuf_e1_conn_cfg

	k_sql = "CREATE VIEW v_e1barcode  " &
			+ " (wadoco , " &
			+ " waan8, " & 
	       	+ " wadrqj, " & 
  	       	+ " wmcpil,    " & 
  	       	+ " wmlotn,    " & 
  	       	+ " iolot2,    " & 
  	       	+ " waapid     " & 
	      	+ ") " &
			+ " AS  " &
			+ " select  " & 
         + "  f4801.wadoco , " & 
          + " f4801.waan8 , " & 
          + " f4801.wadrqj , " & 
          + " f3111.wmcpil , " & 
          + " f3111.wmlotn , " & 
          + " f4108.iolot2 , " & 
          + " f4801.waapid " & 
     + " FROM  F4801_ADT  f4801   " & 
          + " INNER JOIN F3111_ADT  f3111 on ON f4801.wadoco = f3111.wmdoco  " & 
          + " inner join F4108_adt  f4108 on f3111.wmlotn = f4108.iolotn  " & 
   + " WHERE  " & 
        + "  f3111.wmlnty = 'S'   " &
		+ "   and f4801.wasrst = '08'  " &
		+ "  and f4801.wamcu = '" + kguo_g.E1MCU + "'  " &
		+ "  and f4108.iomcu = '" + kguo_g.E1MCU + "'  "

//	k_sql = kuf1_e1_conn_cfg.u_sql_set_schema_nome(k_sql)  // imposta il giusto nome schema

	kguo_sqlca_db_e1.db_connetti( )

	EXECUTE IMMEDIATE "drop VIEW v_e1barcode " using kguo_sqlca_db_e1 ;

	EXECUTE IMMEDIATE :k_sql using kguo_sqlca_db_e1;

	if kguo_sqlca_db_e1.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		kguo_exception.inizializza()
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_e1.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_e1barcode): " + string(kguo_sqlca_db_e1.sqldbcode, "#####") + "; " +kguo_sqlca_db_e1.sqlerrtext
		kguo_exception.set_tipo( kguo_exception.KK_st_uo_exception_tipo_internal_bug )
		kguo_exception.set_esito(kst_esito )
		throw kguo_exception
//	else
//		k_sql = "grant select on v_e1barcode to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using kguo_sqlca_db_e1;
//		if kguo_sqlca_db_e1.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = kguo_sqlca_db_e1.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_e1barcode): " + string(kguo_sqlca_db_e1.sqldbcode, "#####") + "; " +kguo_sqlca_db_e1.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
		
	kst_esito.nome_oggetto = this.classname()
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = kguo_sqlca_db_e1.sqlcode
	kst_esito.sqlerrtext = "Generazione VIEW 'v_e1barcode' completata." 
	kguo_exception.inizializza()
	kguo_exception.set_tipo( kguo_exception.KK_st_uo_exception_tipo_OK )
	kguo_exception.set_esito(kst_esito )
	kguo_exception.scrivi_log()
	
catch	 (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)
	
end try

return k_return

end function

private function boolean u_crea_view_v_meca_dosim_barcode_max () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_meca_dosim_barcode_max'
//=== Righe fattura 
//===
int k_errore=0
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
 



//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)


	k_sql = "CREATE VIEW v_meca_dosim_barcode_max  " &
			+ " (id_meca , " &
			+ " barcode_dosimetro " & 
	      + ") " &
			+ " AS  " &
			+ " select  distinct " & 
                      + " meca_dosim.id_meca  " & 
                      + "  ,max(meca_dosim.barcode_dosimetro)  " & 
                      + " FROM  meca_dosim " &
					+ " group by meca_dosim.id_meca "

	EXECUTE IMMEDIATE "drop VIEW v_meca_dosim_barcode_max " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_meca_dosim_barcode_max): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
	end if	

	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_meca_pl_v1' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_alarm_instock_tosend () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_alarm_instock_tosend' 
//===
boolean k_return = true
string k_sql
kuf_alarm_instock kuf1_alarm_instock
 

	SetPointer(kkg.pointer_attesa)

//13-12-2022 richiesta da Pietro di mettere x gg lavorativi (quindi aggiungo parte circa la tab u_calendario)

	k_sql = " as SELECT " &
   	+ " distinct alarm_instock.id_alarm_instock,  " & 
   	+ " armo.id_meca  " &
   	+ " FROM alarm_instock " &
	  			+ " , armo inner join meca on armo.id_meca = meca.id and (meca.aperto in ('S', 'R', '') or meca.aperto is null) " &
	  					+ " left outer join certif on armo.id_meca = certif.id_meca " &
					+ " inner join u_calendar_working kcal_today on kcal_today.cal_date = (CONVERT (date, GETUTCDATE())) " &
					+ ", u_calendar_working kcal_start_stock " &
   	+ " WHERE " &
   	+ " alarm_instock.attivo = '" + trim(kuf1_alarm_instock.kki_attivo_si) +"' " &
   	+ " and (alarm_instock.id_cliente = 0 OR alarm_instock.id_cliente = meca.clie_3) " &
   	+ " and (alarm_instock.contratto = 0 OR alarm_instock.contratto = meca.contratto) " &
	  	+ " and ((kcal_start_stock.cal_date = (CONVERT (date, meca.data_ent )) and alarm_instock.calc_stocktime = " + string(kuf1_alarm_instock.ki_calc_stocktime_by_data_ent) + ")" &
  	        + " or (kcal_start_stock.cal_date = certif.data and alarm_instock.calc_stocktime = " + string(kuf1_alarm_instock.ki_calc_stocktime_by_certif_data) + "))" &
		+ " and meca.data_ent > '01.01.1990' " &
		+ " and ((alarm_instock.workday = 1 " &
		+ "         and (kcal_today.workday - kcal_start_stock.workday - 1) > alarm_instock.nday_instock) " &
		+ "      or (DATEDIFF(day, kcal_start_stock.cal_date, kcal_today.cal_date) - 1) > alarm_instock.nday_instock ) " &
   	+ " and not exists " &
	         + "(select " &
	      	+ " alarm_instock_email.id_alarm_instock_email " &
		  			+ " from alarm_instock_email " &
		  			+ " where alarm_instock.id_alarm_instock = alarm_instock_email.id_alarm_instock " &
		        		+ " and alarm_instock_email.id_meca = meca.id " &
						+ " and DATEDIFF(d, alarm_instock_email.generated, getutcdate() ) < coalesce(alarm_instock.email_nday_elapsed,0) " &
		      + " ) " &
   	+ " and not exists " &
		+       "( select sum(arsp.colli) from arsp where arsp.id_armo = armo.id_armo " &
		+                " HAVING SUM(colli) >= armo.colli_2 ) " 
		
	k_return = u_tb_crea_view("v_rubrica_all", k_sql)

	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_asd_barcode_all () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_asd_barcode_all' 
//===
int k_errore=0
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception



//=== Puntatore Cursore da attesa..... 
	SetPointer(kkg.pointer_attesa)

	k_sql = "create view v_asd_barcode_all  " &
		+ " as " &
		+ "SELECT barcode  " &
		+ "   , id_asdrackcode " &
		+ "   , id_asdrackbarcode " &
		+ "   , min(linktype) linktype " & 
		+ "from " &
		+ " (select asdrackbarcode.barcode as barcode " &
		+ "   , asdrackbarcode.id_asdrackcode id_asdrackcode " &
		+ "   , asdrackbarcode.id_asdrackbarcode id_asdrackbarcode " &
		+ "   , 'A' as linktype  " &
		+ "from asdrackbarcode  " &
		+ "union all  " &
		+ "   select barcode.barcode  " &
		+ ",  COALESCE(asdrackbarcode.id_asdrackcode " &
		+ ", 0)  id_asdrackcode  " &
		+ ", 0 as id_asdrackbarcode " &
		+ ", 'F' as linktype  " &
		+ "from barcode INNER JOIN asdrackbarcode ON asdrackbarcode.barcode = barcode.barcode_lav " &
		+ "   where barcode.barcode_lav in  " &
		+ "       (SELECT DISTINCT asdrackbarcode.barcode from asdrackbarcode )  " &
		+ "     and barcode.barcode NOT IN  " &
		+ "       (SELECT DISTINCT barcode FROM asdrackbarcode)  " &
		+ "union all  " &
		+ "select barcode.barcode  " &
		+ ",  COALESCE(asdrackbarcode.id_asdrackcode " &
		+ ", 0)  id_asdrackcode  " &
		+ ", 0 as id_asdrackbarcode  " &
		+ ", 'P' as linktype  " &
		+ "from barcode INNER JOIN asdrackbarcode ON asdrackbarcode.barcode = barcode.barcode " &
		+ "             INNER JOIN barcode b1 on asdrackbarcode.barcode = b1.barcode_lav  " &
		+ "where barcode.barcode in (  " &
		+ "   SELECT DISTINCT barcode.barcode_lav " &
		+ "      from barcode inner join asdrackbarcode ON barcode.barcode = asdrackbarcode.barcode ) " &
		+ " ) appo " &
		+ "group by barcode " &
		+ "  , id_asdrackcode " &
		+ "  , id_asdrackbarcode  " 
		
//		+ "SELECT barcode, id_asdrackcode, id_asdrackbarcode, min(linktype) linktype " &
//		+ "from (" &
//		+ "select asdrackbarcode.barcode as barcode" &
//		+ "  ,asdrackbarcode.id_asdrackcode id_asdrackcode" &
//		+ "  ,asdrackbarcode.id_asdrackbarcode id_asdrackbarcode" &
//		+ "  ,'A' as linktype " & 
//		+ "  from asdrackbarcode " &
//		+ "union all" &
//		+ "  select barcode.barcode" &
//		+ "  ,(select asdrackbarcode.id_asdrackcode from asdrackbarcode where asdrackbarcode.barcode = barcode.barcode_lav) id_asdrackcode" &
//		+ "  ,0 as id_asdrackbarcode" &
//		+ "  ,'F' as linktype " & 
//		+ "  from barcode" &
//		+ "  where barcode.barcode_lav in (" &
//		+ "     SELECT asdrackbarcode.barcode " &
//		+ "	      from asdrackbarcode " &
//		+ "  ) " &
//		+ "union all" &
//		+ "  select barcode.barcode" &
//		+ "  ,(select asdrackbarcode.id_asdrackcode from " & 
//		+ "       asdrackbarcode inner join barcode b1 on asdrackbarcode.barcode = b1.barcode_lav " &
//		+ "       where asdrackbarcode.barcode = barcode.barcode) id_asdrackcode" &
//		+ "  ,0 as id_asdrackbarcode" &
//		+ "  ,'P' as linktype " & 
//		+ "  from barcode" &
//		+ "  where barcode.barcode in (" &
//		+ "	  SELECT " &
//		+ "         barcode.barcode_lav" &
//		+ "	from barcode" &
//		+ "			 inner join asdrackbarcode ON " &
//		+ "			 barcode.barcode = asdrackbarcode.barcode " &
//		+ "	) " &
//		+ ") appo " &
//		+ "group by barcode, id_asdrackcode, id_asdrackbarcode "


	EXECUTE IMMEDIATE "drop VIEW v_asd_barcode_all " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_asd_barcode_all): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			


	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_asd_barcode_all' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_contratti_all_rid () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_contratti_all_rid' 
//===
int k_errore=0
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
 



//=== Puntatore Cursore da attesa.....
SetPointer(kkg.pointer_attesa)

k_sql = "create view  v_contratti_all_rid   " &
		+ "as   " &
		+ " SELECT  " &
		+ " offerta_data  " &
		+ " , [offerta_validita]  " &
		+ " , isnull([oggetto], '') oggetto  " &
		+ " , isnull([id_cliente], 0) id_cliente  " &
		+ " , isnull([nome_contatto], '') nome_contatto  " &
		+ " , isnull([note], '') note  " &
		+ " , isnull(note_audit, '') note_audit  " &
		+ " , isnull(note_fasi_operative, '') note_fasi_operative  " &
		+ " , isnull([banca], '') banca  " &
		+ " , isnull([abi], 0) abi  " &
		+ " , isnull([cab], 0) cab  " &
		+ " , isnull([altre_condizioni], '') altre_condizioni  " &
		+ " , isnull([fattura_da], '') fattura_da  " &
		+ " ,'' quotazione_cod  " &
		+ " ,'' cliente_desprod  " &
		+ " ,'' cliente_desprod_rid  " &
		+ " ,'' unita_misura  " &
		+ " ,'' note_qtax  " &
		+ " ,'' note_fatt  " &
		+ " ,'' consegna_des  " &
		+ " ,'' ritiro_des  " &                                        
		+ " ,'' contratti_des  " &                                        
		+ " ,'' reso_des  " &                                        
		+ " ,'' gest_doc_des  " &                                        
		+ " ,'' dir_tecnico_des  " &                                        
		+ " ,'' analisi_lab_des  " &                                        
		+ " ,'' dosim_agg_des  " &                                        
		+ " ,'' logistica_des  " &                                        
		+ " ,'' stoccaggio_des  " &                                        
		+ " ,'' altro_des  " &                                        
		+ " ,'' note_interne  " &                                        
		+ " FROM contratti_rd " &                                        
		+ " union all  " &                                        
		+ " SELECT  " &                                        
		+ " offerta_data  " &                                        
		+ " , [offerta_validita]  " &                                        
		+ " , isnull([oggetto], '')  " &                                        
		+ " , isnull([id_cliente], 0)  " &                                        
		+ " , isnull([nome_contatto], '')  " &                                        
		+ " , isnull([note], '')  " &                                        
		+ " , '' note_audit  " &                                        
		+ " , '' note_fasi_operative  " &                                        
		+ " , isnull([banca], '')  " &                                        
		+ " , isnull([abi], 0)  " &                                        
		+ " , isnull([cab], 0)  " &                                        
		+ " , isnull([altre_condizioni], '')  " &                                        
		+ " , isnull([fattura_da], '')  " &                                        
		+ " , '' quotazione_cod  " &                                        
		+ " , '' cliente_desprod  " &                                        
		+ " , '' cliente_desprod_rid  " &                                        
		+ " , isnull([unita_misura], '')  " &                                        
		+ " , isnull([note_qtax], '')  " &                                        
		+ " , isnull([note_fatt], '')  " &                                        
		+ " , isnull([consegna_des], '')  " &                                        
		+ " , isnull([ritiro_des], '')  " &                                        
		+ " , isnull([contratti_des], '')  " &                                        
		+ " , isnull([reso_des], '')  " &                                        
		+ " , isnull([gest_doc_des], '')  " &                                        
		+ " , isnull([dir_tecnico_des], '')  " &                                        
		+ " , isnull([analisi_lab_des], '')  " &                                        
		+ " , isnull([dosim_agg_des], '')  " &                                        
		+ " , isnull([logistica_des], '')  " &                                        
		+ " , isnull([stoccaggio_des], '')  " &                                        
		+ " , isnull([altro_des], '')  " &                                        
		+ " , isnull([note_interne], '')  " &                                        
		+ " FROM contratti_co " &                                        
		+ " union all  " &                                        
		+ " SELECT   " &                                        
		+ " offerta_data  " &                                        
		+ " ,JSON_VALUE(ctr.dati_contratto ,'$.offerta_validita') offerta_validita,  " &                                        
		+ " JSON_VALUE(ctr.dati_contratto ,'$.oggetto') oggetto,  " &                                        
		+ " case    " &                                        
		+ "   when JSON_VALUE(ctr.dati_contratto ,'$.id_cliente') > '0' then JSON_VALUE(ctr.dati_contratto ,'$.id_cliente')  " &                                         
		+ "   else 0  " &                                        
		+ " end id_cliente,   " &                                        
		+ " JSON_VALUE(ctr.dati_contratto ,'$.nome_contatto')  nome_contatto,  " &                                        
		+ " JSON_VALUE(ctr.dati_contratto ,'$.note') note,  " &                                        
		+ " JSON_VALUE(ctr.dati_contratto ,'$.note_audit') note_audit,  " &                                        
		+ " JSON_VALUE(ctr.dati_contratto ,'$.note_fasi_operative') note_fasi_operative,  " &                                        
		+ " rtrim(JSON_VALUE(ctr.dati_contratto ,'$.banca')) banca  " &                                        
		+ " ,case    " &                                        
		+ "   when JSON_VALUE(ctr.dati_contratto ,'$.abi') > '0' then JSON_VALUE(ctr.dati_contratto ,'$.abi')  " &                                        
		+ "   else 0  " &                                        
		+ " end abi  " &                                        
		+ " ,case    " &                                        
		+ "   when JSON_VALUE(ctr.dati_contratto ,'$.cab') > '0' then JSON_VALUE(ctr.dati_contratto ,'$.cab')   " &                                        
		+ "   else 0  " &                                        
		+ " end cab,   " &                                        
		+ " JSON_VALUE(ctr.dati_contratto ,'$.altre_condizioni') altre_condizioni,  " &                                        
		+ " JSON_VALUE(ctr.dati_contratto ,'$.fattura_da') fattura_da  " &                                        
		+ " , JSON_VALUE(ctr.dati_contratto, '$.quotazione_cod') quotazione_cod  " &                                        
		+ " , JSON_VALUE(ctr.dati_contratto, '$.cliente_desprod') cliente_desprod  " &                                        
		+ " , JSON_VALUE(ctr.dati_contratto, '$.cliente_desprod_rid') cliente_desprod_rid  " &                                        
		+ " ,'' unita_misura  " &                                        
		+ " ,'' note_qtax  " &                                        
		+ " ,'' note_fatt  " &                                        
		+ " ,'' consegna_des  " &                                        
		+ " ,'' ritiro_des  " &                                        
		+ " ,'' contratti_des  " &                                        
		+ " ,'' reso_des  " &                                        
		+ " ,'' gest_doc_des  " &                                        
		+ " ,'' dir_tecnico_des  " &                                        
		+ " ,'' analisi_lab_des  " &                                        
		+ " ,'' dosim_agg_des  " &                                        
		+ " ,'' logistica_des  " &                                        
		+ " ,'' stoccaggio_des  " &                                        
		+ " ,'' altro_des  " &                                        
		+ " ,'' note_interne  " &                                        
		+ " FROM contratti_doc as ctr  "
	
	EXECUTE IMMEDIATE "drop VIEW v_contratti_all_rid " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_contratti_all_rid): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			


	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_contratti_all_rid' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_contratti_doc () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_contratti_doc' 
//===
int k_errore=0
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
 



//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)

	k_sql = "create view v_contratti_doc  " &
		+ " as SELECT ctr.id_contratto_doc " &
		+ " ,ctr.offerta_data " &
		+ " ,ctr.stampa_tradotta " & 
		+ " ,ctr.stato " &
		+ " ,ctr.data_stampa " & 
		+ " ,form_di_stampa " & 
		+ " ,ctr.esito_operazioni_ts_operazione " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.anno') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.anno')) else 0 end anno " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.magazzino') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.magazzino')) else 0 end magazzino " & 
		+ " ,trim(JSON_VALUE(ctr.dati_contratto ,'$.offerta_validita')) offerta_validita " & 
		+ " ,trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.oggetto'), '')) oggetto " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.id_cliente') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.id_cliente'))  else 0  end id_cliente " & 
		+ " ,JSON_VALUE(ctr.dati_contratto ,'$.id_clie_settore') id_clie_settore " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.gruppo') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.gruppo'))  else 0  end gruppo " & 
		+ " ,trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.nome_contatto'), '')) nome_contatto " & 
		+ " ,trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.note'), '')) note " & 
		+ " ,trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.note_audit'), '')) note_audit " & 
		+ " ,trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.note_fasi_operative'), '')) note_fasi_operative " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.iva') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.iva')) else 0 end iva " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.cod_pag') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.cod_pag')) else 0 end cod_pag " & 
		+ " ,trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.banca'), '')) banca " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.abi') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.abi')) else 0 end abi " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.cab') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.cab')) else 0 end cab " & 
		+ " ,trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.altre_condizioni'), '')) altre_condizioni " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.data_inizio') > '01.01.2019' then convert(DATE, JSON_VALUE(ctr.dati_contratto ,'$.data_inizio'))  else null  end data_inizio  " &
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.data_fine') > '01.01.2019' then convert(DATE, JSON_VALUE(ctr.dati_contratto ,'$.data_fine'))  else null  end data_fine  " &
		+ " ,JSON_VALUE(ctr.dati_contratto ,'$.fattura_da') fattura_da " & 
		+ " ,trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.art'), '')) art " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.id_listino_pregruppo') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.id_listino_pregruppo')) else 0 end id_listino_pregruppo " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[0].id_listino_voce') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.voci[0].id_listino_voce')) else 0 end id_listino_voce_1 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[1].id_listino_voce') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.voci[1].id_listino_voce')) else 0 end id_listino_voce_2 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[2].id_listino_voce') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.voci[2].id_listino_voce')) else 0 end id_listino_voce_3 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[3].id_listino_voce') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.voci[3].id_listino_voce')) else 0 end id_listino_voce_4 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[4].id_listino_voce') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.voci[4].id_listino_voce')) else 0 end id_listino_voce_5 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[5].id_listino_voce') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.voci[5].id_listino_voce')) else 0 end id_listino_voce_6 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[6].id_listino_voce') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.voci[6].id_listino_voce')) else 0 end id_listino_voce_7 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[7].id_listino_voce') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.voci[7].id_listino_voce')) else 0 end id_listino_voce_8 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[8].id_listino_voce') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.voci[8].id_listino_voce')) else 0 end id_listino_voce_9 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[9].id_listino_voce') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.voci[9].id_listino_voce')) else 0 end id_listino_voce_10 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[0].voce_prezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci[0].voce_prezzo')) else 0.00 end voce_prezzo_1 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[1].voce_prezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci[1].voce_prezzo')) else 0.00 end voce_prezzo_2 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[2].voce_prezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci[2].voce_prezzo')) else 0.00 end voce_prezzo_3 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[3].voce_prezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci[3].voce_prezzo')) else 0.00 end voce_prezzo_4 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[4].voce_prezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci[4].voce_prezzo')) else 0.00 end voce_prezzo_5 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[5].voce_prezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci[5].voce_prezzo')) else 0.00 end voce_prezzo_6 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[6].voce_prezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci[6].voce_prezzo')) else 0.00 end voce_prezzo_7 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[7].voce_prezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci[7].voce_prezzo')) else 0.00 end voce_prezzo_8 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[8].voce_prezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci[8].voce_prezzo')) else 0.00 end voce_prezzo_9 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[9].voce_prezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci[9].voce_prezzo')) else 0.00 end voce_prezzo_10 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.totale_contratto') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.totale_contratto')) else 0.00 end totale_contratto " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.voci[0].descr'), '')) descr_1 " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.voci[1].descr'), ''))  descr_2 " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.voci[2].descr'), ''))  descr_3 " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.voci[3].descr'), ''))  descr_4 " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.voci[4].descr'), ''))  descr_5 " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.voci[5].descr'), ''))  descr_6 " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.voci[6].descr'), ''))  descr_7 " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.voci[7].descr'), ''))  descr_8 " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.voci[8].descr'), ''))  descr_9 " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.voci[9].descr'), ''))  descr_10 " &
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[0].voce_prezzo_tot') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci[0].voce_prezzo_tot')) else 0.00 end voce_prezzo_tot_1 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[1].voce_prezzo_tot') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci[1].voce_prezzo_tot')) else 0.00 end voce_prezzo_tot_2 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[2].voce_prezzo_tot') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci[2].voce_prezzo_tot')) else 0.00 end voce_prezzo_tot_3 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[3].voce_prezzo_tot') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci[3].voce_prezzo_tot')) else 0.00 end voce_prezzo_tot_4 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[4].voce_prezzo_tot') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci[4].voce_prezzo_tot')) else 0.00 end voce_prezzo_tot_5 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[5].voce_prezzo_tot') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci[5].voce_prezzo_tot')) else 0.00 end voce_prezzo_tot_6 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[6].voce_prezzo_tot') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci[6].voce_prezzo_tot')) else 0.00 end voce_prezzo_tot_7 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[7].voce_prezzo_tot') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci[7].voce_prezzo_tot')) else 0.00 end voce_prezzo_tot_8 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[8].voce_prezzo_tot') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci[8].voce_prezzo_tot')) else 0.00 end voce_prezzo_tot_9 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[9].voce_prezzo_tot') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci[9].voce_prezzo_tot')) else 0.00 end voce_prezzo_tot_10 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[0].voce_qta') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.voci[0].voce_qta')) else 0 end voce_qta_1 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[1].voce_qta') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.voci[1].voce_qta')) else 0 end voce_qta_2 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[2].voce_qta') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.voci[2].voce_qta')) else 0 end voce_qta_3 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[3].voce_qta') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.voci[3].voce_qta')) else 0 end voce_qta_4 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[4].voce_qta') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.voci[4].voce_qta')) else 0 end voce_qta_5 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[5].voce_qta') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.voci[5].voce_qta')) else 0 end voce_qta_6 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[6].voce_qta') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.voci[6].voce_qta')) else 0 end voce_qta_7 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[7].voce_qta') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.voci[7].voce_qta')) else 0 end voce_qta_8 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[8].voce_qta') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.voci[8].voce_qta')) else 0 end voce_qta_9 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci[9].voce_qta') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.voci[9].voce_qta')) else 0 end voce_qta_10 " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.voci[0].flg_st_voce'), '')) flg_st_voce_1 " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.voci[1].flg_st_voce'), '')) flg_st_voce_2 " &  
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.voci[2].flg_st_voce'), '')) flg_st_voce_3 " &  
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.voci[3].flg_st_voce'), '')) flg_st_voce_4 " &  
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.voci[4].flg_st_voce'), '')) flg_st_voce_5 " &  
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.voci[5].flg_st_voce'), '')) flg_st_voce_6 " &  
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.voci[6].flg_st_voce'), '')) flg_st_voce_7 " &  
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.voci[7].flg_st_voce'), '')) flg_st_voce_8 " &  
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.voci[8].flg_st_voce'), '')) flg_st_voce_9 " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.voci[9].flg_st_voce'), '')) flg_st_voce_10 " &  
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto ,'$.flg_fatt_dopo_valid'), '')) flg_fatt_dopo_valid " &
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.id_meca_causale') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.id_meca_causale')) else 0 end id_meca_causale " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.acconto_perc') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.acconto_perc')) else 0 end acconto_perc " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.acconto_imp') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.acconto_imp')) else 0.00 end acconto_imp " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.acconto_cod_pag') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.acconto_cod_pag')) else 0 end acconto_cod_pag " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.id_docprod') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.id_docprod')) else 0 end id_docprod " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.quotazione_tipo'), '')) quotazione_tipo " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.quotazione_cod'), ''))  quotazione_cod " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.cliente_desprod'), '')) cliente_desprod " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.cliente_desprod_rid'), '')) cliente_desprod_rid " &
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.impon_minimo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.impon_minimo')) else 0.00 end impon_minimo " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.unita_misura'), '')) unita_misura " &
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.mis_x_1') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.mis_x_1')) else 0 end mis_x_1 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.mis_y_1') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.mis_y_1')) else 0 end mis_y_1 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.mis_z_1') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.mis_z_1')) else 0 end mis_z_1 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.peso_max_kg') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.peso_max_kg')) else 0.00 end peso_max_kg " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.dose_min') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.dose_min')) else 0.00 end dose_min " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.dose_max') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.dose_max')) else 0.00 end dose_max " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.density_x'), '')) density_x " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.e1litm'), '')) e1litm " &
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.prezzo_1') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.prezzo_1')) else 0.00 end prezzo_1 " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.code_our'), '')) code_our_1 " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.qaa'), '')) qaa_1 " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.voci_irr[0].unita_misura'), '')) unita_misura_2 " &
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[0].mis_x') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[0].mis_x')) else 0 end mis_x_2 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[0].mis_y') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[0].mis_y')) else 0 end mis_y_2 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[0].mis_z') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[0].mis_z')) else 0 end mis_z_2 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[0].peso_max_kg') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[0].peso_max_kg')) else 0.00 end peso_max_kg_2 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[0].dose_min') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[0].dose_min')) else 0.00 end dose_min_2 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[0].dose_max') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[0].dose_max')) else 0.00 end dose_max_2 " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.voci_irr[0].density_x'), '')) density_x_2 " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.voci_irr[0].e1litm'), '')) e1litm_2 " &
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[0].prezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[0].prezzo')) else 0.00 end prezzo_2 " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.voci_irr[0].code_our'), '')) code_our_2 " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.voci_irr[0].qaa'), '')) qaa_2 " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.voci_irr[1].unita_misura'), '')) unita_misura_3 " &
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[1].mis_x') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[1].mis_x')) else 0 end mis_x_3 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[1].mis_y') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[1].mis_y')) else 0 end mis_y_3 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[1].mis_z') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[1].mis_z')) else 0 end mis_z_3 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[1].peso_max_kg') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[1].peso_max_kg')) else 0.00 end peso_max_kg_3 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[1].dose_min') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[1].dose_min')) else 0.00 end dose_min_3 " & 
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[1].dose_max') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[1].dose_max')) else 0.00 end dose_max_3 " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.voci_irr[1].density_x'), '')) density_x_3 " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.voci_irr[1].e1litm'), '')) e1litm_3 " &
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[1].prezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.voci_irr[1].prezzo')) else 0.00 end prezzo_3 " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.voci_irr[1].code_our'), '')) code_our_3 " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.voci_irr[1].qaa'), '')) qaa_3 " &
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.dose') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.dose')) else 0.00 end dose " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.note_qtax'), '')) note_qtax " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.e1itmdosim'), '')) e1itmdosim " &
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.e1itmdosimprezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.e1itmdosimprezzo')) else 0.00 end e1itmdosimprezzo " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.contratti_des'), '')) contratti_des " &
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.id_sd_md') > '0' then convert(INTEGER, JSON_VALUE(ctr.dati_contratto ,'$.id_sd_md')) else 0 end id_sd_md " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.note_interne'), '')) note_interne " &
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.gest_doc_prezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.gest_doc_prezzo')) else 0.00 end gest_doc_prezzo " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.gest_doc_des'), '')) gest_doc_des " &
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.dir_tecnico_prezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.dir_tecnico_prezzo')) else 0.00 end dir_tecnico_prezzo " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.dir_tecnico_des'), '')) dir_tecnico_des " &
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.analisi_lab_prezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.analisi_lab_prezzo')) else 0.00 end analisi_lab_prezzo " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.analisi_lab_des'), '')) analisi_lab_des " &
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.dosim_agg_prezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.dosim_agg_prezzo')) else 0.00 end dosim_agg_prezzo " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.dosim_agg_des'), '')) dosim_agg_des " &
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.stoccaggio_prezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.stoccaggio_prezzo')) else 0.00 end stoccaggio_prezzo " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.stoccaggio_des'), '')) stoccaggio_des " &
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.logistica_prezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.logistica_prezzo')) else 0.00 end logistica_prezzo " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.logistica_des'), '')) logistica_des " &
		+ " , case when JSON_VALUE(ctr.dati_contratto ,'$.altro_prezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ctr.dati_contratto ,'$.altro_prezzo')) else 0.00 end altro_prezzo " & 
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.altro_des'), '')) altro_des " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.rif_interno_alt'), '')) rif_interno_alt " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.venditore_nome'), '')) venditore_nome " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.venditore_ruolo'), '')) venditore_ruolo " &
		+ " , trim(COALESCE(JSON_VALUE(ctr.dati_contratto, '$.treat_validate'), '')) treat_validate " &
		+ " , ctr.x_datins " &
		+ " , ctr.x_utente " &
		+ " FROM contratti_doc as ctr " 

//				+ " ,JSON_VALUE(ctr.dati_contratto ,'$.iva') iva " & 

	EXECUTE IMMEDIATE "drop VIEW v_contratti_doc " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_contratti_doc): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			


	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_contratti_doc' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_ptasks_rows () throws uo_exception;/*
Estemporanea da lanciare una sola volta
	Crae tabella View  'v_ptsks_rows' 
*/
boolean k_return = true
string k_sql


	SetPointer(kkg.pointer_attesa)

	//k_sql = "create view " + k_viewName + "as "
	k_sql = " as SELECT ptasks_rows.id_ptasks_row " &
		+ " ,ptasks_rows.id_ptask " &
		+ " ,ptasks_rows.id_ptasks_type " & 
		+ " , ptasks_rows.x_datins " &
		+ " , ptasks_rows.x_utente " &
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.qta') > '0' then convert(INTEGER, JSON_VALUE(ptasks_rows.data_json ,'$.cs.qta')) else 0 end cs_qta " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.prezzo') > '0' then convert(decimal(9,2), JSON_VALUE(ptasks_rows.data_json ,'$.cs.prezzo')) else 0.00 end cs_prezzo " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.cs.clienteddtn')) cs_clienteddtn " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.usdqta') > '0' then convert(INTEGER, JSON_VALUE(ptasks_rows.data_json ,'$.cs.usdqta')) else 0 end cs_usdqta " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.usdprezzo') > '0' then convert(decimal(8,4), JSON_VALUE(ptasks_rows.data_json ,'$.cs.usdprezzo')) else 0.0000 end cs_usdprezzo " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.pesonettoxlottokg') > '0' then convert(decimal(8,3), JSON_VALUE(ptasks_rows.data_json ,'$.cs.pesonettoxlottokg')) else 0.0000 end cs_pesonettoxlottokg " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.cs.custcode')) cs_custcode " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.qtabox') > '0' then convert(INTEGER, JSON_VALUE(ptasks_rows.data_json ,'$.cs.qtabox')) else 0 end cs_qtabox " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.cs.trackitusn')) cs_trackitusn " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.cs.trackusitn')) cs_trackusitn " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.speddata') > '01.01.2019' then convert(DATE, JSON_VALUE(ptasks_rows.data_json ,'$.cs.speddata'))  else null  end cs_speddata " &
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.charlottedatain') > '01.01.2019' then convert(DATE, JSON_VALUE(ptasks_rows.data_json ,'$.cs.charlottedatain'))  else null  end cs_charlottedatain  " &
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.charlottewo') > '0' then convert(INTEGER, JSON_VALUE(ptasks_rows.data_json ,'$.cs.charlottewo')) else 0 end cs_charlottewo " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.charlottewodata') > '01.01.2019' then convert(DATE, JSON_VALUE(ptasks_rows.data_json ,'$.cs.charlottewodata'))  else null  end cs_charlottewodata  " &
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.datarientro') > '01.01.2019' then convert(DATE, JSON_VALUE(ptasks_rows.data_json ,'$.cs.datarientro'))  else null  end cs_datarientro  " &
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.cs.e1so')) cs_e1so " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.e1sofattura') > '0' then convert(INTEGER, JSON_VALUE(ptasks_rows.data_json ,'$.cs.e1sofattura')) else 0 end cs_e1sofattura " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.cs.e1ancillary')) cs_e1ancillary " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.stgfatturan') > '0' then convert(INTEGER, JSON_VALUE(ptasks_rows.data_json ,'$.cs.stgfatturan')) else 0 end cs_stgfatturan " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.stgfatturadata') > '01.01.2019' then convert(DATE, JSON_VALUE(ptasks_rows.data_json ,'$.cs.stgfatturadata'))  else null  end cs_stgfatturadata  " &
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.stgfatturaimporto') > '0' then convert(decimal(9,2), JSON_VALUE(ptasks_rows.data_json ,'$.cs.stgfatturaimporto')) else 0.00 end cs_stgfatturaimporto " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.stgddtn') > '0' then convert(INTEGER, JSON_VALUE(ptasks_rows.data_json ,'$.cs.stgddtn')) else 0 end cs_stgddtn " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.stgddtdata') > '01.01.2019' then convert(DATE, JSON_VALUE(ptasks_rows.data_json ,'$.cs.stgddtdata'))  else null  end cs_stgddtdata " &
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.cs.docfinen')) cs_docfinen " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.cs.notefatt')) cs_notefatt " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.cs.ordine')) cs_ordine " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.invoice_id_cliente') > '0' then convert(INTEGER, JSON_VALUE(ptasks_rows.data_json ,'$.cs.invoice_id_cliente')) else 0 end cs_invoice_id_cliente " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.invoicen') > '0' then convert(INTEGER, JSON_VALUE(ptasks_rows.data_json ,'$.cs.invoicen')) else 0 end cs_invoicen " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.invoicedata') > '01.01.2019' then convert(DATE, JSON_VALUE(ptasks_rows.data_json ,'$.cs.invoicedata'))  else null  end cs_invoicedata " &
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.cs.invoicefirmadata') > '01.01.2019' then convert(DATE, JSON_VALUE(ptasks_rows.data_json ,'$.cs.invoicefirmadata'))  else null  end cs_invoicefirmadata " &
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.cs.invoicefirmanome')) cs_invoicefirmanome " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.cs.invoicefirmaruolo')) cs_invoicefirmaruolo " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.cs.invoiceorigin')) cs_invoiceorigin " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.cs.invoiceproducer')) cs_invoiceproducer " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.cs.invoiceproduceraddress')) cs_invoiceproduceraddress " & 		
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.acc.arrivodata') > '01.01.2019' then convert(DATE, JSON_VALUE(ptasks_rows.data_json ,'$.acc.arrivodata'))  else null  end accettazione_arrivodata  " &
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.acc.e1wo') > '0' then convert(INTEGER, JSON_VALUE(ptasks_rows.data_json ,'$.acc.e1wo')) else 0 end accettazione_e1wo " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.acc.pesolordoxlottokg') > '0' then convert(decimal(8,3), JSON_VALUE(ptasks_rows.data_json ,'$.acc.pesolordoxlottokg')) else 0.0000 end accettazione_pesolordoxlottokg " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.acc.clie_1') > '0' then convert(INTEGER, JSON_VALUE(ptasks_rows.data_json ,'$.acc.clie_1')) else 0 end accettazione_clie_1 " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.acc.clie_2') > '0' then convert(INTEGER, JSON_VALUE(ptasks_rows.data_json ,'$.acc.clie_2')) else 0 end accettazione_clie_2 " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.acc.dhlbox')) accettazione_dhlbox " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.acc.boxdimcm')) accettazione_boxdimcm " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.valid.modaccompn') > '0' then convert(INTEGER, JSON_VALUE(ptasks_rows.data_json ,'$.valid.modaccompn')) else 0 end validation_modaccompn " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.valid.modaccomprogr')) validation_modaccomprogr " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.valid.modaccompdata') > '01.01.2019' then convert(DATE, JSON_VALUE(ptasks_rows.data_json ,'$.valid.modaccompdata'))  else null  end validation_modaccompdata  " &
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.valid.modaccompqtadescr')) validation_modaccompqtadescr " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.valid.proddescr')) validation_proddescr " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.valid.proddescr_eng')) validation_proddescr_eng " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.valid.prodlotto')) validation_prodlotto " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.valid.laboratorio')) validation_laboratorio " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.valid.qaa')) validation_qaa " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.valid.campioniqta') > '0' then convert(INTEGER, JSON_VALUE(ptasks_rows.data_json ,'$.valid.campioniqta')) else 0 end validation_campioniqta " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.valid.offertarif')) validation_offertarif " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.valid.attivitacod')) validation_attivitacod " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.valid.speddata') > '01.01.2019' then convert(DATE, JSON_VALUE(ptasks_rows.data_json ,'$.valid.speddata'))  else null  end validation_speddata " &
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.valid.finepresuntadata') > '01.01.2019' then convert(DATE, JSON_VALUE(ptasks_rows.data_json ,'$.valid.finepresuntadata'))  else null  end validation_finepresuntadata " &
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.valid.laboratoriocertifn')) validation_laboratoriocertifn " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.valid.laboratoriocertifdata') > '01.01.2019' then convert(DATE, JSON_VALUE(ptasks_rows.data_json ,'$.valid.laboratoriocertifdata'))  else null  end validation_laboratoriocertifdata  " &
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.valid.laboratoriocertif1n')) validation_laboratoriocertif1n " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.valid.laboratoriocertif1data') > '01.01.2019' then convert(DATE, JSON_VALUE(ptasks_rows.data_json ,'$.valid.laboratoriocertif1data'))  else null  end validation_laboratoriocertif1data  " &
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.valid.dose') > '0' then convert(decimal(6,2), JSON_VALUE(ptasks_rows.data_json ,'$.valid.dose')) else 0.00 end validation_dose " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.valid.dose_min') > '0' then convert(decimal(6,2), JSON_VALUE(ptasks_rows.data_json ,'$.valid.dose_min')) else 0.00 end validation_dose_min " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.valid.dose_max') > '0' then convert(decimal(6,2), JSON_VALUE(ptasks_rows.data_json ,'$.valid.dose_max')) else 0.00 end validation_dose_max " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.valid.notereport')) validation_notereport " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.valid.noterifpo')) validation_noterifpo " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.valid.notealtre')) validation_notealtre " & 
		+ " , trim(JSON_VALUE(ptasks_rows.data_json ,'$.approvv.stgcharlfattinterc')) approvvigionamenti_stgcharlfattinterc " &
		+ " FROM ptasks_rows " 

	k_return = u_tb_crea_view("v_ptasks_rows", k_sql)

	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_meca_instock () throws uo_exception;//---
//--- Estemporanea da lanciare una sola volta
//--- Crae tabella View  'v_lots_instock' 
//--- Lotti entrati e ancora in giacenza
//---
int k_errore=0
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
 


//--- Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)
	
	//k_data_int = relativedate(kguo_g.get_dataoggi( ), -365)

	k_sql = "create view v_meca_instock  " &
		+ " as SELECT " &
   	+ "  armo.id_meca" & 
   	+ " ,armo.colli_2" & 
   	+ " ,sum(coalesce(arsp.colli, 0)) colli_sped" &
   	+ " ,coalesce(certif.num_certif, 0) num_certif" &
		+ " ,certif.data data_certif" &
		+ " ,coalesce(DATEDIFF(DAY, certif.data, GETDATE()), 0) gg_giacenza" &
   	+ " FROM " & 
	  			+ "armo inner join meca on armo.id_meca = meca.id and (meca.aperto in ('S', 'R', '') or meca.aperto is null) " &
	  			+ " left outer join certif on armo.id_meca = certif.id_meca " &
	  			+ " left outer join arsp on armo.id_armo = arsp.id_armo " &
   	+ " WHERE " &
   	+    " meca.data_int > DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 12, 0) " &
		+    " and meca.data_ent > '01.01.1990' " &
		+ " group by " &
   	+      " armo.id_meca" & 
   	+      " ,armo.colli_2" & 
   	+      " ,certif.num_certif" &
		+      " ,certif.data" &
		+ " HAVING armo.colli_2 > sum(coalesce(arsp.colli, 0)) " 
		
	EXECUTE IMMEDIATE "drop VIEW v_meca_instock " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_meca_instock): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
	end if	

	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_meca_instock' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_sped_free () throws uo_exception;/*
 Estemporanea da lanciare una sola volta
	 Crae tabella View  'v_sped_free' 
*/
boolean k_return = true
string k_sql
 

//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)

	//k_sql = "create view v_sped_free  " &
	k_sql = " as SELECT " &
		+ " id_sped_free " & 
		+ " ,id_deposito " & 
		+ " ,data_bolla_out " & 
		+ " ,trim(num_bolla_out) num_bolla_out " &  
		+ " ,coalesce(clie_2,0) clie_2 " & 
		+ " ,coalesce(clie_3,0) clie_3 " &  
		+ " ,coalesce(stampa, 'N') stampa " & 
		+ " ,data_stampa" & 
		+ " ,coalesce(form_di_stampa, '') form_di_stampa " &
		+ " ,trim(JSON_VALUE(dati ,'$.Indirizzo_riga_1'))  Indirizzo_riga_1  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.Indirizzo_riga_2'))  Indirizzo_riga_2  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.Indirizzo_riga_3'))  Indirizzo_riga_3  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.Indirizzo_riga_4'))  Indirizzo_riga_4  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.Indirizzo_riga_5'))  Indirizzo_riga_5  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.aspetto'))           aspetto" & 
		+ " ,trim(JSON_VALUE(dati ,'$.causale'))           causale" & 
		+ " ,trim(JSON_VALUE(dati ,'$.colli'))             colli  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.consegna'))          consegna   " & 
		+ " ,trim(JSON_VALUE(dati ,'$.data_ora_rit'))      data_ora_rit  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.descr_1'))           descr_1" & 
		+ " ,trim(JSON_VALUE(dati ,'$.descr_2'))           descr_2" & 
		+ " ,trim(JSON_VALUE(dati ,'$.descr_3'))           descr_3" & 
		+ " ,trim(JSON_VALUE(dati ,'$.descr_4'))           descr_4" & 
		+ " ,trim(JSON_VALUE(dati ,'$.descr_5'))           descr_5" & 
		+ " ,trim(JSON_VALUE(dati ,'$.descr_6'))           descr_6" & 
		+ " ,trim(JSON_VALUE(dati ,'$.descr_7'))           descr_7" & 
		+ " ,trim(JSON_VALUE(dati ,'$.descr_8'))           descr_8" & 
		+ " ,trim(JSON_VALUE(dati ,'$.descr_9'))           descr_9" & 
		+ " ,trim(JSON_VALUE(dati ,'$.descr_10'))          descr_10   " & 
		+ " ,trim(JSON_VALUE(dati ,'$.descr_11'))          descr_11   " & 
		+ " ,trim(JSON_VALUE(dati ,'$.descr_12'))          descr_12   " & 
		+ " ,trim(JSON_VALUE(dati ,'$.descr_13'))          descr_13   " & 
		+ " ,trim(JSON_VALUE(dati ,'$.descr_14'))          descr_14   " & 
		+ " ,trim(JSON_VALUE(dati ,'$.descr_15'))          descr_15   " & 
		+ " ,trim(JSON_VALUE(dati ,'$.descr_16'))          descr_16   " & 
		+ " ,trim(JSON_VALUE(dati ,'$.descr_17'))          descr_17   " & 
		+ " ,trim(JSON_VALUE(dati ,'$.descr_18'))          descr_18   " & 
		+ " ,trim(JSON_VALUE(dati ,'$.descr_19'))          descr_19   " & 
		+ " ,trim(JSON_VALUE(dati ,'$.dicit_ind_intest'))  dicit_ind_intest  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.dicit_ind_sped'))    dicit_ind_sped" & 
		+ " ,trim(JSON_VALUE(dati ,'$.intestazione'))      intestazione  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.intestazione_ind1'))  intestazione_ind1  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.intestazione_ind2'))  intestazione_ind2  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.intestazione_ind3'))  intestazione_ind3  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.intestazione_ind4'))  intestazione_ind4  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.kgy_1'))             kgy_1  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.kgy_2'))             kgy_2  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.kgy_3'))             kgy_3  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.kgy_4'))             kgy_4  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.kgy_5'))             kgy_5  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.kgy_6'))             kgy_6  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.kgy_7'))             kgy_7  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.kgy_8'))             kgy_8  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.kgy_9'))             kgy_9  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.kgy_10'))            kgy_10 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.kgy_11'))            kgy_11 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.kgy_12'))            kgy_12 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.kgy_13'))            kgy_13 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.kgy_14'))            kgy_14 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.kgy_15'))            kgy_15 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.kgy_16'))            kgy_16 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.kgy_17'))            kgy_17 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.kgy_18'))            kgy_18 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.kgy_19'))            kgy_19 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.note_1'))            note_1 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.note_2'))            note_2 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.note_3'))            note_3 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.note_4'))            note_4 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.note_5'))            note_5 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.peso_kg'))           peso_kg" & 
		+ " ,trim(JSON_VALUE(dati ,'$.porto'))             porto  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.qta_1'))             qta_1  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.qta_2'))             qta_2  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.qta_3'))             qta_3  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.qta_4'))             qta_4  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.qta_5'))             qta_5  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.qta_6'))             qta_6  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.qta_7'))             qta_7  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.qta_8'))             qta_8  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.qta_9'))             qta_9  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.qta_10'))            qta_10 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.qta_11'))            qta_11 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.qta_12'))            qta_12 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.qta_13'))            qta_13 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.qta_14'))            qta_14 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.qta_15'))            qta_15 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.qta_16'))            qta_16 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.qta_17'))            qta_17 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.qta_18'))            qta_18 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.qta_19'))            qta_19 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.sped_note'))         sped_note  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.tipo_copia'))        tipo_copia " & 
		+ " ,trim(JSON_VALUE(dati ,'$.trasporto'))         trasporto  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.um_1'))              um_1   " & 
		+ " ,trim(JSON_VALUE(dati ,'$.um_2'))              um_2   " & 
		+ " ,trim(JSON_VALUE(dati ,'$.um_3'))              um_3   " & 
		+ " ,trim(JSON_VALUE(dati ,'$.um_4'))              um_4   " & 
		+ " ,trim(JSON_VALUE(dati ,'$.um_5'))              um_5   " & 
		+ " ,trim(JSON_VALUE(dati ,'$.um_6'))              um_6   " & 
		+ " ,trim(JSON_VALUE(dati ,'$.um_7'))              um_7   " & 
		+ " ,trim(JSON_VALUE(dati ,'$.um_8'))              um_8   " & 
		+ " ,trim(JSON_VALUE(dati ,'$.um_9'))              um_9   " & 
		+ " ,trim(JSON_VALUE(dati ,'$.um_10'))             um_10  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.um_11'))             um_11  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.um_12'))             um_12  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.um_13'))             um_13  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.um_14'))             um_14  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.um_15'))             um_15  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.um_16'))             um_16  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.um_17'))             um_17  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.um_18'))             um_18  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.um_19'))             um_19  " & 
		+ " ,trim(JSON_VALUE(dati ,'$.vett_1'))            vett_1 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.vett_2'))            vett_2 " & 
		+ " ,trim(JSON_VALUE(dati ,'$.resa'))          resa " & 
		+ " ,trim(JSON_VALUE(dati ,'$.annotazioni'))   annotazioni " & 
		+ " ,trim(JSON_VALUE(dati ,'$.conducente'))   conducente " & 
		+ " , x_datins " &
		+ " , coalesce(x_utente, '') x_utente" &
		+ " FROM sped_free " 

	k_return = u_tb_crea_view("v_sped_free", k_sql)

	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_temptable_armo () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_temptable_armo' 
//===
int k_errore
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception



//=== Puntatore Cursore da attesa..... 
	SetPointer(kkg.pointer_attesa)

	kuo_exception = create uo_exception
	kst_esito = kuo_exception.inizializza(this.classname())

	k_sql = "create view v_temptable_armo  " &
	  + " as " &
     + " WITH T " &
     + " AS ( " &
	  + " SELECT " &
	  + "  '*' as Attuale " &
     + " ,x_ValidFrom " &
     + " ,x_ValidTo " &
     + " ,id_armo " &
     + " ,id_meca " &
     + " ,num_int " &
     + " ,data_int " &
     + " ,isnull(id_listino    ,0)       id_listino " &
     + " ,isnull(art   ,'')      art " &
     + " ,isnull(dose  ,0.0)     dose " &
     + " ,isnull(note_1        ,'')      note_1 " &
     + " ,isnull(note_2        ,'')      note_2 " &
     + " ,isnull(note_3        ,'')      note_3 " &
     + " ,isnull(larg_2        ,0)       larg_2 " &
     + " ,isnull(lung_2        ,0)       lung_2 " &
     + " ,isnull(alt_2         ,0)       alt_2 " &
     + " ,isnull(colli_2       ,0)       colli_2 " &
     + " ,isnull(m_cubi        ,0.0)     m_cubi " &
     + " ,isnull(peso_kg       ,0)       peso_kg " &
     + " ,isnull(magazzino     ,0)       magazzino " &
     + " ,isnull(pedane        ,0)       pedane " &
     + " ,isnull(campione      ,0)       campione " &
     + " ,isnull(cod_sl_pt     ,'')      cod_sl_pt " &
     + " ,isnull(campionecolli ,0)       campionecolli " &
     + " ,isnull(parzialecolli ,0)       parzialecolli " &
     + " ,x_utente " &
     + " ,nextid_listino    = LAG(id_listino   ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextart           = LAG(art          ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextdose          = LAG(dose         ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextnote_1        = LAG(note_1       ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextnote_2        = LAG(note_2       ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextnote_3        = LAG(note_3       ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextlarg_2        = LAG(larg_2       ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextlung_2        = LAG(lung_2       ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextalt_2         = LAG(alt_2        ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextcolli_2       = LAG(colli_2      ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextm_cubi        = LAG(m_cubi       ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextpeso_kg       = LAG(peso_kg      ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextmagazzino     = LAG(magazzino    ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextpedane        = LAG(pedane       ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextcampione      = LAG(campione     ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextcod_sl_pt     = LAG(cod_sl_pt    ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextcampionecolli = LAG(campionecolli) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextparzialecolli = LAG(parzialecolli) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextx_utente 	    = LAG(x_utente)      OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " & 	   
     + " FROM armo " &
   + " union all " &
     + " SELECT " &
     + " ' ' as Attuale " &
     + " ,x_ValidFrom " &
     + " ,x_ValidTo " &
     + " ,id_armo " &
     + " ,id_meca " &
     + " ,num_int " &
     + " ,data_int " &
     + " ,isnull(id_listino    ,0) " &
     + " ,isnull(art   ,'') " &
     + " ,isnull(dose  ,0.0) " &
     + " ,isnull(note_1        ,'') " &
     + " ,isnull(note_2        ,'') " &
     + " ,isnull(note_3        ,'') " &
     + " ,isnull(larg_2        ,0) " &
     + " ,isnull(lung_2        ,0) " &
     + " ,isnull(alt_2         ,0) " &
     + " ,isnull(colli_2       ,0) " &
     + " ,isnull(m_cubi        ,0.0) " &
     + " ,isnull(peso_kg       ,0) " &
     + " ,isnull(magazzino     ,0) " &
     + " ,isnull(pedane        ,0) " &
     + " ,isnull(campione      ,0) " &
     + " ,isnull(cod_sl_pt     ,'') " &
     + " ,isnull(campionecolli ,0) " &
     + " ,isnull(parzialecolli ,0) " &
     + " ,x_utente " &
     + " ,nextid_listino    = LAG(id_listino   ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextart           = LAG(art          ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextdose          = LAG(dose         ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextnote_1        = LAG(note_1       ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextnote_2        = LAG(note_2       ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextnote_3        = LAG(note_3       ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextlarg_2        = LAG(larg_2       ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextlung_2        = LAG(lung_2       ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextalt_2         = LAG(alt_2        ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextcolli_2       = LAG(colli_2      ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextm_cubi        = LAG(m_cubi       ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextpeso_kg       = LAG(peso_kg      ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextmagazzino     = LAG(magazzino    ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextpedane        = LAG(pedane       ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextcampione      = LAG(campione     ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextcod_sl_pt     = LAG(cod_sl_pt    ) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextcampionecolli = LAG(campionecolli) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextparzialecolli = LAG(parzialecolli) OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " &      
     + " ,nextx_utente 	    = LAG(x_utente)      OVER (PARTITION BY id_armo ORDER BY x_ValidFrom) " & 	   
       + " FROM   armoH " &
     + "  ) " &
     + " , T1   " &
     + " AS ( " &
       + " SELECT t.id_meca " &
       + " ,id_armo " &
       + " ,coltext       	 " &
       + " ,colname       	 " &
       + " ,value       	 " &
       + " ,max(Attuale)       attuale " &
       + " ,min(x_ValidFrom) x_validfrom " &
       + " FROM   T " &
       + "  CROSS APPLY ( VALUES " &
       + " 	('id_listino',    'id_listino   '  ,     CAST(id_listino        AS NVARCHAR(4000)), CAST(nextid_listino   	AS NVARCHAR(4000))) " &
       + "   ,('articolo',      'art          '  ,     CAST(art               AS NVARCHAR(4000)), CAST(nextart          	AS NVARCHAR(4000))) " &
       + "   ,('dose',          'dose         '  ,     CAST(dose              AS NVARCHAR(4000)), CAST(nextdose         	AS NVARCHAR(4000))) " &
       + "   ,('note_1',        'note_1       '  ,     CAST(note_1            AS NVARCHAR(4000)), CAST(nextnote_1       	AS NVARCHAR(4000))) " &
       + "   ,('note_2',        'note_2       '  ,     CAST(note_2            AS NVARCHAR(4000)), CAST(nextnote_2       	AS NVARCHAR(4000))) " &
       + "   ,('note_3',        'note_3       '  ,     CAST(note_3            AS NVARCHAR(4000)), CAST(nextnote_3       	AS NVARCHAR(4000))) " &
       + "   ,('larghezza',     'larg_2       '  ,     CAST(larg_2            AS NVARCHAR(4000)), CAST(nextlarg_2       	AS NVARCHAR(4000))) " &
       + "   ,('lunghezza',     'lung_2       '  ,     CAST(lung_2            AS NVARCHAR(4000)), CAST(nextlung_2       	AS NVARCHAR(4000))) " &
       + "   ,('altezza',       'alt_2        '  ,     CAST(alt_2             AS NVARCHAR(4000)), CAST(nextalt_2        	AS NVARCHAR(4000))) " &
       + "   ,('colli',         'colli_2      '  ,     CAST(colli_2           AS NVARCHAR(4000)), CAST(nextcolli_2      	AS NVARCHAR(4000))) " &
       + "   ,('mt cubi',        'm_cubi       '  ,     CAST(m_cubi            AS NVARCHAR(4000)), CAST(nextm_cubi       	AS NVARCHAR(4000))) " &
       + "   ,('peso kg',       'peso_kg      '  ,     CAST(peso_kg           AS NVARCHAR(4000)), CAST(nextpeso_kg      	AS NVARCHAR(4000))) " &
       + "   ,('magazzino',     'magazzino    '  ,     CAST(magazzino         AS NVARCHAR(4000)), CAST(nextmagazzino    	AS NVARCHAR(4000))) " &
       + "   ,('pedane',        'pedane       '  ,     CAST(pedane            AS NVARCHAR(4000)), CAST(nextpedane       	AS NVARCHAR(4000))) " &
       + "   ,('campione',      'campione     '  ,     CAST(campione          AS NVARCHAR(4000)), CAST(nextcampione     	AS NVARCHAR(4000))) " &
       + "   ,('cod. PT',            'cod_sl_pt    '  ,     CAST(cod_sl_pt         AS NVARCHAR(4000)), CAST(nextcod_sl_pt    	AS NVARCHAR(4000))) " &
       + "   ,('n. controcampioni','campionecolli'  ,     CAST(campionecolli     AS NVARCHAR(4000)), CAST(nextcampionecolli	AS NVARCHAR(4000))) " &
       + "   ,('n. parziali','parzialecolli'  ,     CAST(parzialecolli     AS NVARCHAR(4000)), CAST(nextparzialecolli	AS NVARCHAR(4000))) " &
       + "           ) CA( coltext, colname, value, nextvalue) " &
        + " WHERE  EXISTS(SELECT value " &
                 + " EXCEPT " &
                   + " SELECT nextvalue) " &
        + " group by id_meca, " &
        + "    id_armo, coltext, Colname, value " &
        + " ) " &
        + " SELECT t1.id_meca   	as id_lotto " &
       + " ,id_armo " &
       + " ,coltext       	as colonna " &
       + " ,colname       	as colname " &
       + " ,value       	as valore " &
       + " ,Attuale           as 'Attuale' " &
       + " ,x_ValidFrom      as 'Valido_dal' " &
       + " ,(select t2.x_utente from t t2 where t2.x_ValidFrom = t1.x_ValidFrom and t2.id_armo = t1.id_armo) as utente " &
        + " FROM  T1 " 
		  
     // + "  where id_meca = 274041          " &
     //   + " ORDER  BY id_meca, " &
     //       + " id_armo, " &
     //       + " Colonna " &
     //       + " Valido_dal " 

	EXECUTE IMMEDIATE "drop VIEW v_temptable_armo " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_temptable_armo): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			
	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_temptable_armo' completata." 
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	 
	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_temptable_meca () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View 'v_temptable_meca' 
//===
int k_errore
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception



//=== Puntatore Cursore da attesa..... 
	SetPointer(kkg.pointer_attesa)

	kuo_exception = create uo_exception
	kst_esito = kuo_exception.inizializza(this.classname())

	k_sql = "create view v_temptable_meca  " &
	  + " as " &
     + " WITH T " &
     + " AS ( " &
	+ " SELECT " &
	  + " '*' as Attuale " &
     + " ,x_ValidFrom " &
     + " ,x_ValidTo " &
     + " ,id " &
     + " ,isnull(e1doco, 0) e1doco " &
     + " ,num_int " &
     + " ,data_int " &
     + " ,data_ent " &
     + " ,isnull(num_bolla_in, '')     num_bolla_in " &
     + " ,data_bolla_in data_bolla_in " &
     + " ,consegna_data consegna_data " &
     + " ,isnull(clie_1, 0)     clie_1 " &
     + " ,isnull(clie_2, 0)     clie_2 " &
     + " ,isnull(clie_3, 0)     clie_3 " &
     + " ,isnull(area_mag, '')  area_mag " &
     + " ,isnull(aperto, '')    aperto " &
     + " ,isnull(stato, '')     stato " &
     + " ,isnull(stato_in_attenzione, '')   stato_in_attenzione " &
     + " ,isnull(cert_forza_stampa, '')     cert_forza_stampa " &
     + " ,x_data_cert_f_st     x_data_cert_f_st " &
     + " ,isnull(x_utente_cert_f_st, '')     x_utente_cert_f_st " &
     + " ,isnull(cert_farma_st_ok, '')     cert_farma_st_ok " &
     + " ,x_data_cert_farma     x_data_cert_farma " &
     + " ,isnull(x_utente_cert_farm, '')     x_utente_cert_farm " &
     + " ,isnull(cert_aliment_st_ok, '')     cert_aliment_st_ok " &
     + " ,x_data_cert_alim     x_data_cert_alim " &
     + " ,isnull(x_utente_cert_alim, '') x_utente_cert_alim  " &
	  + " ,x_utente " &
     + " ,nexte1doco = LAG(e1doco) 	OVER (PARTITION BY e1doco ORDER BY x_ValidFrom) " &      
     + " ,nextnum_int = LAG(num_int) 	OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextdata_int = LAG(data_int) 	OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextdata_ent = LAG(data_ent) 	OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextnum_bolla_in = LAG(num_bolla_in) 	OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextdata_bolla_in = LAG(data_bolla_in) 	OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextconsegna_data = LAG(consegna_data) 	OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextclie_1 = LAG(clie_1) 			OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextclie_2 = LAG(clie_2) 			OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextclie_3 = LAG(clie_3) 			OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextarea_mag = LAG(area_mag) 		OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextaperto = LAG(aperto) 			OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextstato = LAG(stato) 			OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextstato_in_attenzione = LAG(stato_in_attenzione) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextcert_forza_stampa = LAG(cert_forza_stampa) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextx_data_cert_f_st = LAG(x_data_cert_f_st)  OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextx_utente_cert_f_st = LAG(x_utente_cert_f_st) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextcert_farma_st_ok = LAG(cert_farma_st_ok)  OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextx_data_cert_farma = LAG(x_data_cert_farma) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextx_utente_cert_farm = LAG(x_utente_cert_farm) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextcert_aliment_st_ok = LAG(cert_aliment_st_ok) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextx_data_cert_alim = LAG(x_data_cert_alim)  OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextx_utente_cert_alim = LAG(x_utente_cert_alim) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextx_utente 	    = LAG(x_utente)      OVER (PARTITION BY id ORDER BY x_ValidFrom) " & 	   
     + " FROM meca " &
   + " union all " &
     + " SELECT " &
     + " ' ' as Attuale " &
     + " ,x_ValidFrom " &
     + " ,x_ValidTo " &
     + " ,id " &
     + " ,isnull(e1doco, 0) e1doco " &
     + " ,num_int " &
     + " ,data_int " &
     + " ,data_ent " &
     + " ,isnull(num_bolla_in, '')     num_bolla_in " &
     + " ,data_bolla_in data_bolla_in " &
     + " ,consegna_data consegna_data " &
     + " ,isnull(clie_1, 0)     clie_1 " &
     + " ,isnull(clie_2, 0)     clie_2 " &
     + " ,isnull(clie_3, 0)     clie_3 " &
     + " ,isnull(area_mag, '')  area_mag " &
     + " ,isnull(aperto, '')    aperto " &
     + " ,isnull(stato, '')     stato " &
     + " ,isnull(stato_in_attenzione, '')   stato_in_attenzione " &
     + " ,isnull(cert_forza_stampa, '')     cert_forza_stampa " &
     + " ,x_data_cert_f_st     x_data_cert_f_st " &
     + " ,isnull(x_utente_cert_f_st, '')     x_utente_cert_f_st " &
     + " ,isnull(cert_farma_st_ok, '')     cert_farma_st_ok " &
     + " ,x_data_cert_farma     x_data_cert_farma " &
     + " ,isnull(x_utente_cert_farm, '')     x_utente_cert_farm " &
     + " ,isnull(cert_aliment_st_ok, '')     cert_aliment_st_ok " &
     + " ,x_data_cert_alim     x_data_cert_alim " &
     + " ,isnull(x_utente_cert_alim, '') x_utente_cert_alim  " &
 	  + " ,x_utente " &
     + " ,nexte1doco = LAG(e1doco) 	OVER (PARTITION BY e1doco ORDER BY x_ValidFrom) " &      
     + " ,nextnum_int = LAG(num_int) 	OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextdata_int = LAG(data_int) 	OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextdata_ent = LAG(data_ent) 	OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextnum_bolla_in = LAG(num_bolla_in) 	OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextdata_bolla_in = LAG(data_bolla_in) 	OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextconsegna_data = LAG(consegna_data) 	OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextclie_1 = LAG(clie_1) 			OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextclie_2 = LAG(clie_2) 			OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextclie_3 = LAG(clie_3) 			OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextarea_mag = LAG(area_mag) 		OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextaperto = LAG(aperto) 			OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextstato = LAG(stato) 			OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextstato_in_attenzione = LAG(stato_in_attenzione) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextcert_forza_stampa = LAG(cert_forza_stampa) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextx_data_cert_f_st = LAG(x_data_cert_f_st)  OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextx_utente_cert_f_st = LAG(x_utente_cert_f_st) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextcert_farma_st_ok = LAG(cert_farma_st_ok)  OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextx_data_cert_farma = LAG(x_data_cert_farma) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextx_utente_cert_farm = LAG(x_utente_cert_farm) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextcert_aliment_st_ok = LAG(cert_aliment_st_ok) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextx_data_cert_alim = LAG(x_data_cert_alim)  OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextx_utente_cert_alim = LAG(x_utente_cert_alim) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &      
     + " ,nextx_utente 	    = LAG(x_utente)      OVER (PARTITION BY id ORDER BY x_ValidFrom) " & 	   
        + " FROM   mecaH " &
     + "  ) " &
     + " , T1   " &
     + " AS ( " &
       + " SELECT t.id " &
       + " ,coltext " &
       + " ,colname " &
       + " ,value   " &
       + " ,max(Attuale)   attuale " &
       + " ,min(x_ValidFrom) x_validfrom " &
       + " FROM   T " &
       + "  CROSS APPLY ( VALUES " &
       + " 	 ('(Lotto E1-WO)', 'e1doco',     CAST(e1doco AS NVARCHAR(4000)), CAST(nexte1doco	AS NVARCHAR(4000))) " &
       + "  ,('0-Lotto Aperto', 'aperto',     CAST(aperto AS NVARCHAR(4000)), CAST(nextaperto    AS NVARCHAR(4000))) " &
       + " 	,('1-Lotto n.', 'num_int',     CAST(num_int AS NVARCHAR(4000)), CAST(nextnum_int	AS NVARCHAR(4000))) " &
       + " 	,('2-Lotto del', 'data_int',     CAST(data_int AS NVARCHAR(4000)), CAST(nextdata_int AS NVARCHAR(4000))) " &
       + " 	,('3-Lotto entrato il', 'data_ent',     CAST(data_ent AS NVARCHAR(4000)), CAST(nextdata_ent AS NVARCHAR(4000))) " &
       + " 	,('4-Lotto DDT n'   , 'num_bolla_in',     CAST(num_bolla_in        AS NVARCHAR(4000)), CAST(nextnum_bolla_in       	AS NVARCHAR(4000))) " &
       + "  ,('5-Lotto DDT del', 'data_bolla_in',     CAST(data_bolla_in       AS NVARCHAR(4000)), CAST(nextdata_bolla_in      	AS NVARCHAR(4000))) " &
       + "  ,('6-Cliente Mandante','clie_1',   CAST(clie_1 AS NVARCHAR(4000)), CAST(nextclie_1    AS NVARCHAR(4000))) " &
       + "  ,('7-Cliente Ricevente', 'clie_2',   CAST(clie_2 AS NVARCHAR(4000)), CAST(nextclie_2    AS NVARCHAR(4000))) " &
       + "  ,('8-Cliente a Listino', 'clie_3',   CAST(clie_3 AS NVARCHAR(4000)), CAST(nextclie_3    AS NVARCHAR(4000))) " &
       + "  ,('9-Lotto Consegna prevista', 'consegna_data',     CAST(consegna_data       AS NVARCHAR(4000)), CAST(nextconsegna_data      	AS NVARCHAR(4000))) " &
       + "  ,('9-Lotto in Area mag.', 'area_mag',  CAST(area_mag AS NVARCHAR(4000)), CAST(nextarea_mag  AS NVARCHAR(4000))) " &
       + "  ,('9-Lotto in Stato', 'stato',     CAST(stato  AS NVARCHAR(4000)), CAST(nextstato     AS NVARCHAR(4000))) " &
       + "  ,('9-Lotto In Attenzione', 'stato_in_attenzione',     CAST(stato_in_attenzione AS NVARCHAR(4000)), CAST(nextstato_in_attenzione	AS NVARCHAR(4000))) " &
       + "  ,('Attestato, Forzato', 'cert_forza_stampa',     CAST(cert_forza_stampa AS NVARCHAR(4000)), CAST(nextcert_forza_stampa	    AS NVARCHAR(4000))) " &
       + "  ,('Attestato, Forzato il', 'x_data_cert_f_st',     CAST(x_data_cert_f_st AS NVARCHAR(4000)), CAST(nextx_data_cert_f_st	    AS NVARCHAR(4000))) " &
       + "  ,('Attestato, Forzato da', 'x_utente_cert_f_st ',     CAST(x_utente_cert_f_st AS NVARCHAR(4000)), CAST(nextx_utente_cert_f_st	AS NVARCHAR(4000))) " &
       + "  ,('Attestato, Farmaceutico ok', 'cert_farma_st_ok',     CAST(cert_farma_st_ok AS NVARCHAR(4000)), CAST(nextcert_farma_st_ok	  AS NVARCHAR(4000))) " &
       + "  ,('Attestato, Farmaceutico ok il',  'x_data_cert_farma',     CAST(x_data_cert_farma AS NVARCHAR(4000)), CAST(nextx_data_cert_farma	  AS NVARCHAR(4000))) " &
       + "  ,('Attestato, Farmaceutico ok da', 'x_utente_cert_farm ',     CAST(x_utente_cert_farm AS NVARCHAR(4000)), CAST(nextx_utente_cert_farm	AS NVARCHAR(4000))) " &
       + "  ,('Attestato, Alimentare ok',  'cert_aliment_st_ok ',     CAST(cert_aliment_st_ok AS NVARCHAR(4000)), CAST(nextcert_aliment_st_ok	AS NVARCHAR(4000))) " &
       + "  ,('Attestato, Alimentare ok il',  'x_data_cert_alim',     CAST(x_data_cert_alim AS NVARCHAR(4000)), CAST(nextx_data_cert_alim	AS NVARCHAR(4000))) " &
       + "  ,('Attestato, Alimentare ok da', 'x_utente_cert_alim',     CAST(x_utente_cert_alim AS NVARCHAR(4000)), CAST(nextx_utente_cert_alim	AS NVARCHAR(4000))) " &
       + "           ) CA( coltext, colname, value, nextvalue) " &
        + " WHERE  EXISTS(SELECT value " &
                 + " EXCEPT " &
                   + " SELECT nextvalue) " &
        + " group by id " &
        + " ,coltext, Colname, value " & 
        + " ) " &
        + " SELECT t1.id  as id_lotto " &
       + " ,coltext     as colonna " &
       + " ,colname     as colname " &
       + " ,value       as valore " &
       + " ,Attuale     as 'Attuale' " &
       + " ,x_ValidFrom as 'Valido_dal' " &
       + " ,(select t2.x_utente from t t2 where t2.x_ValidFrom = t1.x_ValidFrom and t2.id = t1.id) as utente " &
        + " FROM  T1 " 
     // + "  where id_meca = 274041          " &
     //   + " ORDER  BY id_meca, " &
     //       + " id_armo, " &
     //       + " Colonna " &
     //       + " Valido_dal " 

	EXECUTE IMMEDIATE "drop VIEW v_temptable_meca " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_temptable_meca): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			
	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_temptable_meca' completata." 
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	 
	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_temptable_meca_blk () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View'v_temptable_meca_blk' 
//===
int k_errore
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception



//=== Puntatore Cursore da attesa..... 
	SetPointer(kkg.pointer_attesa)

	kuo_exception = create uo_exception
	kst_esito = kuo_exception.inizializza(this.classname())

	k_sql = "create view v_temptable_meca_blk  " &
	  + " as " &
	+ "  WITH T " &
    + "  AS ( " &
	+ "   SELECT " &
	+ " '*' as Attuale " &
    + "  ,x_ValidFrom " &
    + "  ,x_ValidTo " &
    + "  ,id_meca " &
    + "  ,isnull(id_meca_causale, 0)  id_meca_causale " &
    + "  ,isnull(descrizione, '')   descrizione " &
    + "  ,isnull(rich_autorizz, '') rich_autorizz " &
    + "  ,x_datins_blk x_datins_blk " &
    + "  ,isnull(x_utente_blk, '')   x_utente_blk " &
    + "  ,x_datins_sblk x_datins_sblk " &
    + "  ,isnull(x_utente_sblk, '')  x_utente_sblk " &
	+ "  ,x_utente " &
    + "  ,nextid_meca_causale = LAG(id_meca_causale) 	OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
    + "  ,nextdescrizione     = LAG(descrizione    ) 	OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
    + "  ,nextrich_autorizz   = LAG(rich_autorizz  ) 	OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
    + "  ,nextx_datins_blk    = LAG(x_datins_blk   ) 	OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
    + "  ,nextx_utente_blk    = LAG(x_utente_blk   ) 	OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
    + "  ,nextx_datins_sblk   = LAG(x_datins_sblk  ) 	OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
    + "  ,nextx_utente_sblk   = LAG(x_utente_sblk  ) 	OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
    + "  ,nextx_utente 	   = LAG(x_utente)          OVER (PARTITION BY id_meca ORDER BY x_ValidFrom)  	 " &
    + "  FROM meca_blk " &
    + "union all " &
    + "  SELECT " &
    + "' ' as Attuale " &
    + "  ,x_ValidFrom " &
    + "  ,x_ValidTo " &
    + "  ,id_meca " &
    + "  ,isnull(id_meca_causale, 0)  id_meca_causale " &
    + "  ,isnull(descrizione, '')   descrizione " &
    + "  ,isnull(rich_autorizz, '') rich_autorizz " &
    + "  ,x_datins_blk x_datins_blk " &
    + "  ,isnull(x_utente_blk, '')   x_utente_blk " &
    + "  ,x_datins_sblk x_datins_sblk " &
    + "  ,isnull(x_utente_sblk, '')  x_utente_sblk " &
	+ "  ,x_utente " &
    + "  ,nextid_meca_causale = LAG(id_meca_causale) 	OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
    + "  ,nextdescrizione     = LAG(descrizione    ) 	OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
    + "  ,nextrich_autorizz   = LAG(rich_autorizz  ) 	OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
    + "  ,nextx_datins_blk    = LAG(x_datins_blk   ) 	OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
    + "  ,nextx_utente_blk    = LAG(x_utente_blk   ) 	OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
    + "  ,nextx_datins_sblk   = LAG(x_datins_sblk  ) 	OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
    + "  ,nextx_utente_sblk   = LAG(x_utente_sblk  ) 	OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
    + "  ,nextx_utente 	   = LAG(x_utente)          OVER (PARTITION BY id_meca ORDER BY x_ValidFrom)  	 " &
    + "     FROM   meca_blkH " &
    + "   ) " &
    + "  , T1 " &
    + "  AS ( " &
    + "    SELECT t.id_meca " &
    + "    ,coltext " &
    + "    ,colname " &
    + "    ,value   " &
    + "    ,max(Attuale)       attuale " &
    + "    ,min(x_ValidFrom) x_validfrom " &
    + "    FROM   T " &
    + "     CROSS APPLY ( VALUES " &
    + "      (' Id Causale di blocco', 'id_meca_causale', CAST(id_meca_causale  AS NVARCHAR(4000)), CAST(nextid_meca_causale AS NVARCHAR(4000))) " &
    + "      ,(' Descrizione', 'descrizione', CAST(descrizione  AS NVARCHAR(4000)), CAST(nextdescrizione AS NVARCHAR(4000))) " &
    + "      ,('Rich. autorizz.', 'rich_autorizz', CAST(rich_autorizz  AS NVARCHAR(4000)), CAST(nextrich_autorizz AS NVARCHAR(4000))) " &
    + "      ,('Bloccato in Data', 'x_datins_blk ', CAST(x_datins_blk  AS NVARCHAR(4000)), CAST(nextx_datins_blk AS NVARCHAR(4000))) " &
    + "      ,('Bloccato da Utente', 'x_utente_blk ', CAST(x_utente_blk  AS NVARCHAR(4000)), CAST(nextx_utente_blk AS NVARCHAR(4000))) " &
    + "      ,('Sbloccato in data', 'x_datins_sblk', CAST(x_datins_sblk  AS NVARCHAR(4000)), CAST(nextx_datins_sblk AS NVARCHAR(4000))) " &
    + "      ,('Sbloccato da Utente', 'x_utente_sblk', CAST(x_utente_sblk  AS NVARCHAR(4000)), CAST(nextx_utente_sblk AS NVARCHAR(4000))) " &
    + "              )  CA( coltext, colname, value, nextvalue) " &
    + "      WHERE  EXISTS(SELECT value " &
    + "              EXCEPT " &
    + "                SELECT nextvalue) " &
    + "     group by id_meca " &
    + "     ,coltext, Colname, value " &
    + "     ) " &
    + "     SELECT t1.id_meca  as id_lotto " &
    + "    ,coltext     as colonna " &
    + "    ,colname     as colname " &
    + "    ,value       as valore " &
    + "    ,Attuale     as 'Attuale' " &
    + "    ,x_ValidFrom as 'Valido_dal' " &
    + "    ,(select t2.x_utente from t t2 where t2.x_ValidFrom = t1.x_ValidFrom and t2.id_meca = t1.id_meca) as utente " &
    + "     FROM  T1 " 
     // + "  where id_meca = 274041          " &
     //   + " ORDER  BY id_meca, " &
     //       + " id_armo, " &
     //       + " Colonna " &
     //       + " Valido_dal " 

	EXECUTE IMMEDIATE "drop VIEW v_temptable_meca_blk " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_temptable_meca_blk): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			
	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_temptable_meca_blk' completata." 
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	 
	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_temptable_meca_dosimbozza () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_temptable_meca_dosimbozza' 
//===
int k_errore
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception



//=== Puntatore Cursore da attesa..... 
	SetPointer(kkg.pointer_attesa)

	kuo_exception = create uo_exception
	kst_esito = kuo_exception.inizializza(this.classname())

	k_sql = "create view v_temptable_meca_dosimbozza  " &
	  + " as " &
		+ " WITH T " &
		+ "      AS ( " & 
		+ "SELECT " &                                                                                                 
		+ "  '*' as Attuale " &
		+ "   ,x_ValidFrom  " &
		+ "   ,x_ValidTo " &
		+ "   ,id_meca " &
      + "   ,isnull(id_meca_dosimbozza, 0) id_meca_dosimbozza " &
		+ "   ,isnull(barcode, '') barcode " &
      + "   ,isnull(barcode_lav, '') barcode_lav " &
		+ "   ,isnull(barcode_dosimetro, '') barcode_dosimetro " &
		+ "   ,dosim_data " &
		+ "   ,isnull(dosim_flg_tipo_dose, '') dosim_flg_tipo_dose " &
		+ "   ,isnull(dosim_dose ,0)          dosim_dose " &
		+ "   ,isnull(dosim_assorb ,0)     dosim_assorb " &
		+ "   ,isnull(dosim_spessore ,0.0)  dosim_spessore " &
		+ "   ,isnull(dosim_rapp_a_s ,0)   dosim_rapp_a_s " &
		+ "   ,isnull(dosim_lotto_dosim ,'')  dosim_lotto_dosim " &
		+ "   ,isnull(dosim_temperatura ,0)   dosim_temperatura " &
		+ "   ,isnull(dosim_umidita,0)    dosim_umidita " &
		+ "   ,isnull(dosim_esito, '')    dosim_esito " &
		+ "   ,isnull(dosim_note,'')      dosim_note  " &
		+ "   ,isnull(note,'')      note  " &
		+ "   ,isnull(x_data_dosim_lettura,'')  x_data_dosim_lettura      " &
		+ "   ,isnull(x_utente_dosim_lettura,'')  x_utente_dosim_lettura      " &
		+ "   ,x_utente " &
		+ "   ,nextbarcode = LAG(barcode)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "   ,nextbarcode_lav = LAG(barcode_lav)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "   ,nextbarcode_dosimetro = LAG(barcode_dosimetro)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "   ,nextdosim_data = LAG(dosim_data)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "   ,nextdosim_flg_tipo_dose = LAG(dosim_flg_tipo_dose)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "   ,nextdosim_dose = LAG(dosim_dose)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "   ,nextdosim_assorb = LAG(dosim_assorb)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "   ,nextdosim_spessore = LAG(dosim_spessore)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "   ,nextdosim_rapp_a_s = LAG(dosim_rapp_a_s)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "   ,nextdosim_lotto_dosim = LAG(dosim_lotto_dosim)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "   ,nextdosim_temperatura = LAG(dosim_temperatura)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "   ,nextdosim_umidita = LAG(dosim_umidita)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "   ,nextdosim_esito = LAG(dosim_esito)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "   ,nextdosim_note = LAG(dosim_note)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "   ,nextnote = LAG(note)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "   ,nextx_data_dosim_lettura = LAG(x_data_dosim_lettura)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "   ,nextx_utente_dosim_lettura = LAG(x_utente_dosim_lettura)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "   ,nextx_utente 	 = LAG(x_utente)			OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "  FROM  meca_dosimbozza " &
		+ "  union all " &
		+ "SELECT " &                                                                                                 
		+ "  ' ' as Attuale " &
		+ "  ,x_ValidFrom  " &
		+ "  ,x_ValidTo " &
		+ "  ,id_meca " &
      + "  ,isnull(id_meca_dosimbozza, 0) id_meca_dosimbozza " &
		+ "  ,isnull(barcode, '') barcode " &
      + "  ,isnull(barcode_lav, '') barcode_lav " &
		+ "  ,isnull(barcode_dosimetro, '') barcode_dosimetro " &
		+ "  ,dosim_data " &
		+ "  ,isnull(dosim_flg_tipo_dose, '') dosim_flg_tipo_dose " &
		+ "  ,isnull(dosim_dose ,0)          dosim_dose " &
		+ "  ,isnull(dosim_assorb ,0)     dosim_assorb " &
		+ "  ,isnull(dosim_spessore ,0.0)  dosim_spessore " &
		+ "  ,isnull(dosim_rapp_a_s ,0)   dosim_rapp_a_s " &
		+ "  ,isnull(dosim_lotto_dosim ,'')  dosim_lotto_dosim " &
		+ "  ,isnull(dosim_temperatura ,0)   dosim_temperatura " &
		+ "  ,isnull(dosim_umidita ,0)    dosim_umidita " &
		+ "  ,isnull(dosim_esito, '')    dosim_esito " &
		+ "  ,isnull(dosim_note,'')      dosim_note  " &
		+ "  ,isnull(note,'')      note  " &
		+ "  ,isnull(x_data_dosim_lettura,'')  x_data_dosim_lettura      " &
		+ "  ,isnull(x_utente_dosim_lettura,'')  x_utente_dosim_lettura      " &
		+ "  ,x_utente " &
		+ "  ,nextbarcode = LAG(barcode)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "  ,nextbarcode_lav = LAG(barcode_lav)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "  ,nextbarcode_dosimetro = LAG(barcode_dosimetro)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "  ,nextdosim_data = LAG(dosim_data)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "  ,nextdosim_flg_tipo_dose = LAG(dosim_flg_tipo_dose)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "  ,nextdosim_dose = LAG(dosim_dose)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "  ,nextdosim_assorb = LAG(dosim_assorb)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "  ,nextdosim_spessore = LAG(dosim_spessore)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "  ,nextdosim_rapp_a_s = LAG(dosim_rapp_a_s)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "  ,nextdosim_lotto_dosim = LAG(dosim_lotto_dosim)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "  ,nextdosim_temperatura = LAG(dosim_temperatura)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "  ,nextdosim_umidita = LAG(dosim_umidita)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "  ,nextdosim_esito = LAG(dosim_esito)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "  ,nextdosim_note = LAG(dosim_note)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "  ,nextnote = LAG(note)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "  ,nextx_data_dosim_lettura = LAG(x_data_dosim_lettura)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "  ,nextx_utente_dosim_lettura = LAG(x_utente_dosim_lettura)		OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ "  ,nextx_utente 	 = LAG(x_utente)			OVER (PARTITION BY id_meca_dosimbozza ORDER BY x_ValidFrom) " &
		+ " FROM  meca_dosimbozzaH " &
		+ " ) " &
		+ " , T1 " &
		+ "      AS (  " &
		+ " SELECT t.id_meca " &
		+ "   ,id_meca_dosimbozza " &
		+ "   ,barcode " &
		+ "   ,coltext			 " &
		+ "   ,colname			 " &
		+ "   ,value			 " &
		+ "   ,max(Attuale)		attuale " &
		+ "   ,min(x_ValidFrom) x_validfrom " &
		+ " FROM  T  " &
		   + " CROSS APPLY ( VALUES " &
		   + "   (' Barcode di Tratt.',      'barcode_lav'  ,     CAST(barcode_lav AS NVARCHAR(4000)), CAST(nextbarcode_lav  AS NVARCHAR(4000))) " &
		   + "  ,(' Dosimetro',      'barcode_dosimetro'  ,     CAST(barcode_dosimetro AS NVARCHAR(4000)), CAST(nextbarcode_dosimetro  AS NVARCHAR(4000))) " &
		   + "  ,(' data',      'dosim_data'  ,     CAST(dosim_data AS NVARCHAR(4000)), CAST(nextdosim_data  AS NVARCHAR(4000))) " &
		   + "  ,('dato Tipo (X=max; M=Min; A=altro)',     'dosim_flg_tipo_dose' ,      CAST(dosim_flg_tipo_dose AS NVARCHAR(4000)), CAST(nextdosim_flg_tipo_dose  AS NVARCHAR(4000))) " &
		   + "  ,('dato Dose',      'dosim_dose'  ,     CAST(dosim_dose AS NVARCHAR(4000)), CAST(nextdosim_dose  AS NVARCHAR(4000))) " &
		   + "  ,('dato Assorbanza',      'dosim_assorb'  ,     CAST(dosim_assorb AS NVARCHAR(4000)), CAST(nextdosim_assorb  AS NVARCHAR(4000))) " &
		   + "  ,('dato Spessore',      'dosim_spessore'  ,     CAST(dosim_spessore AS NVARCHAR(4000)), CAST(nextdosim_spessore  AS NVARCHAR(4000))) " &
		   + "  ,('dato Assorb./Spess.',      'dosim_rapp_a_s'  ,     CAST(dosim_rapp_a_s AS NVARCHAR(4000)), CAST(nextdosim_rapp_a_s  AS NVARCHAR(4000))) " &
		   + "  ,(' Lotto Dosim.',      'dosim_lotto_dosim'  ,     CAST(dosim_lotto_dosim AS NVARCHAR(4000)), CAST(nextdosim_lotto_dosim  AS NVARCHAR(4000))) " &
		   + "  ,('dato Temperatura',      'dosim_temperatura'  ,     CAST(dosim_temperatura AS NVARCHAR(4000)), CAST(nextdosim_temperatura  AS NVARCHAR(4000))) " &
		   + "  ,('dato Umidità',      'dosim_umidita'  ,     CAST(dosim_umidita AS NVARCHAR(4000)), CAST(nextdosim_umidita  AS NVARCHAR(4000))) " &
		   + "  ,('Esito',      'dosim_esito'  ,     CAST(dosim_esito AS NVARCHAR(4000)), CAST(nextdosim_esito  AS NVARCHAR(4000))) " &
		   + "  ,('Esito Note',      'dosim_note'  ,     CAST(dosim_note AS NVARCHAR(4000)), CAST(nextdosim_note  AS NVARCHAR(4000))) " &
		   + "  ,('Note',      'note'  ,     CAST(note AS NVARCHAR(4000)), CAST(nextnote  AS NVARCHAR(4000))) " &
		   + "  ,('Lettura il',      'x_data_dosim_lettura'  ,     CAST(x_data_dosim_lettura AS NVARCHAR(4000)), CAST(nextx_data_dosim_lettura  AS NVARCHAR(4000))) " &
		   + "  ,('Lettura da Utente',      'x_utente_dosim_lettura'  ,     CAST(x_utente_dosim_lettura AS NVARCHAR(4000)), CAST(nextx_utente_dosim_lettura  AS NVARCHAR(4000))) " &
	 	+ " ) CA( coltext, colname, value, nextvalue)" &
		+ " WHERE  EXISTS(SELECT value" &
		      + " EXCEPT" &
		      + " SELECT nextvalue)" &
		      + " group by id_meca," &
		      + " id_meca_dosimbozza, barcode, coltext, Colname, value " &
		+ " )" &
  	 	 + " SELECT t1.id_meca   	as id_lotto " &
      		+ "  ,id_meca_dosimbozza" &
   			+ "  ,barcode " &
      		+ "  ,coltext			as colonna" &
      		+ "  ,colname			as colname" &
      		+ "  ,value			as valore" &
      		+ "  ,Attuale		    as 'Attuale'" &
      		+ "  ,x_ValidFrom      as 'Valido_dal'" &
      		+ "  ,(select t2.x_utente from t t2 where t2.x_ValidFrom = t1.x_ValidFrom and t2.id_meca_dosimbozza = t1.id_meca_dosimbozza) as utente " &
		+ " FROM  T1 " 

     // + "  where id_meca = 274041          " &
     //   + " ORDER  BY id_meca, " &
     //       + " id_armo, " &
     //       + " Colonna " &
     //       + " Valido_dal " 

	EXECUTE IMMEDIATE "drop VIEW v_temptable_meca_dosimbozza " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_temptable_meca_dosimbozza): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			
	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_temptable_meca_dosimbozza' completata." 
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	 
	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_temptable_meca_dosim () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_temptable_meca_dosim' 
//===
int k_errore
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception



//=== Puntatore Cursore da attesa..... 
	SetPointer(kkg.pointer_attesa)

	kuo_exception = create uo_exception
	kst_esito = kuo_exception.inizializza(this.classname())

	k_sql = "create view v_temptable_meca_dosim  " &
	  + " as " &
		+ " WITH T " &
		+ "      AS ( " & 
		+ "SELECT " &                                                                                                 
		+ "  '*' as Attuale " &
		+ "  , x_ValidFrom  " &
		+ "  , x_ValidTo " &
		+ "  , id_meca " &
      + "  , barcode " &
      + "  , isnull(barcode_lav, '') barcode_lav " &
		+ "  , isnull(barcode_dosimetro, '') barcode_dosimetro " &
		+ "  , dosim_data " &
		+ "  , dosim_ora " &
		+ "  , isnull(dosim_flg_tipo_dose, '') dosim_flg_tipo_dose " &
		+ "  , isnull(dosim_dose, 0)   dosim_dose " &
		+ "  , isnull(dosim_assorb, 0)     dosim_assorb " &
		+ "  , isnull(dosim_spessore, 0.0)  dosim_spessore " &
		+ "  , isnull(dosim_rapp_a_s, 0)   dosim_rapp_a_s " &
		+ "  , isnull(dosim_lotto_dosim, '')  dosim_lotto_dosim " &
		+ "  , isnull(dosim_temperatura, 0)   dosim_temperatura " &
		+ "  , isnull(dosim_umidita, 0)  dosim_umidita " &
		+ "  , isnull(err_lav_ok, '')    err_lav_ok " &
		+ "  , isnull(note_lav_ok,'')    note_lav_ok  " &
		+ "  , isnull(x_data_dosim_verifica,'')  x_data_dosim_verifica      " &
		+ "  , isnull(x_utente_dosim_verifica,'')  x_utente_dosim_verifica      " &
		+ "  , isnull(x_data_dosim_sblocco_ko,'')  x_data_dosim_sblocco_ko      " &
		+ "  , isnull(x_utente_dosim_sblocco_ko,'')  x_utente_dosim_sblocco_ko      " &
		+ "  , x_utente " &
		+ "  , nextbarcode = LAG(barcode) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextbarcode_lav = LAG(barcode_lav) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextbarcode_dosimetro = LAG(barcode_dosimetro) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_data = LAG(dosim_data) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_ora = LAG(dosim_ora) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_flg_tipo_dose = LAG(dosim_flg_tipo_dose) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_dose = LAG(dosim_dose) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_assorb = LAG(dosim_assorb) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_spessore = LAG(dosim_spessore) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_rapp_a_s = LAG(dosim_rapp_a_s) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_lotto_dosim = LAG(dosim_lotto_dosim) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_temperatura = LAG(dosim_temperatura) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_umidita = LAG(dosim_umidita) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nexterr_lav_ok = LAG(err_lav_ok) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextnote_lav_ok = LAG(note_lav_ok) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextx_data_dosim_verifica = LAG(x_data_dosim_verifica) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente_dosim_verifica = LAG(x_utente_dosim_verifica)	OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextx_data_dosim_sblocco_ko = LAG(x_data_dosim_sblocco_ko)	OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente_dosim_sblocco_ko = LAG(x_utente_dosim_sblocco_ko) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente = LAG(x_utente) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  FROM  meca_dosim " &
		+ "  union all " &
		+ "SELECT " &                                                                                                 
		+ "  ' ' as Attuale " &
		+ "  , x_ValidFrom  " &
		+ "  , x_ValidTo " &
		+ "  , id_meca " &
      + "  , barcode " &
      + "  , isnull(barcode_lav, '') barcode_lav " &
		+ "  , isnull(barcode_dosimetro, '') barcode_dosimetro " &
		+ "  , dosim_data " &
		+ "  , dosim_ora " &
		+ "  , isnull(dosim_flg_tipo_dose, '') dosim_flg_tipo_dose " &
		+ "  , isnull(dosim_dose, 0)   dosim_dose " &
		+ "  , isnull(dosim_assorb, 0)     dosim_assorb " &
		+ "  , isnull(dosim_spessore, 0.0)  dosim_spessore " &
		+ "  , isnull(dosim_rapp_a_s, 0)   dosim_rapp_a_s " &
		+ "  , isnull(dosim_lotto_dosim, '')  dosim_lotto_dosim " &
		+ "  , isnull(dosim_temperatura, 0)   dosim_temperatura " &
		+ "  , isnull(dosim_umidita, 0)  dosim_umidita " &
		+ "  , isnull(err_lav_ok, '')    err_lav_ok " &
		+ "  , isnull(note_lav_ok,'')    note_lav_ok  " &
		+ "  , isnull(x_data_dosim_verifica,'')  x_data_dosim_verifica      " &
		+ "  , isnull(x_utente_dosim_verifica,'')  x_utente_dosim_verifica      " &
		+ "  , isnull(x_data_dosim_sblocco_ko,'')  x_data_dosim_sblocco_ko      " &
		+ "  , isnull(x_utente_dosim_sblocco_ko,'')  x_utente_dosim_sblocco_ko      " &
		+ "  , x_utente " &
		+ "  , nextbarcode = LAG(barcode) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextbarcode_lav = LAG(barcode_lav) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextbarcode_dosimetro = LAG(barcode_dosimetro) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_data = LAG(dosim_data) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_ora = LAG(dosim_ora) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_flg_tipo_dose = LAG(dosim_flg_tipo_dose) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_dose = LAG(dosim_dose) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_assorb = LAG(dosim_assorb) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_spessore = LAG(dosim_spessore) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_rapp_a_s = LAG(dosim_rapp_a_s) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_lotto_dosim = LAG(dosim_lotto_dosim) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_temperatura = LAG(dosim_temperatura) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_umidita = LAG(dosim_umidita) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nexterr_lav_ok = LAG(err_lav_ok) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextnote_lav_ok = LAG(note_lav_ok) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextx_data_dosim_verifica = LAG(x_data_dosim_verifica) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente_dosim_verifica = LAG(x_utente_dosim_verifica)	OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextx_data_dosim_sblocco_ko = LAG(x_data_dosim_sblocco_ko)	OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente_dosim_sblocco_ko = LAG(x_utente_dosim_sblocco_ko) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente = LAG(x_utente) OVER (PARTITION BY id_meca, barcode ORDER BY x_ValidFrom) " &
		+ "  FROM  meca_dosimH " &
		+ " ) " &
		+ ",  T1 " &
		+ "      AS (  " &
		+ " SELECT t.id_meca " &
		+ "  , barcode " &
		+ "  , coltext			 " &
		+ "  , colname			 " &
		+ "  , value			 " &
		+ "  , max(Attuale) attuale " &
		+ "  , min(x_ValidFrom) x_validfrom " &
		+ " FROM  T  " &
		   + "   CROSS APPLY ( VALUES " &
		   + "   (' Barcode di Tratt.',      'barcode_lav' ,      CAST(barcode_lav AS NVARCHAR(4000)), CAST(nextbarcode_lav  AS NVARCHAR(4000))) " &
		   + "  , (' Dosimetro',      'barcode_dosimetro' ,      CAST(barcode_dosimetro AS NVARCHAR(4000)), CAST(nextbarcode_dosimetro  AS NVARCHAR(4000))) " &
		   + "  , ('Verificato in Data',     'dosim_data' ,      CAST(dosim_data AS NVARCHAR(4000)), CAST(nextdosim_data  AS NVARCHAR(4000))) " &
		   + "  , ('Verificato alle ore',      'dosim_ora' ,      CAST(dosim_ora AS NVARCHAR(4000)), CAST(nextdosim_ora  AS NVARCHAR(4000))) " &
		   + "  , ('dato Tipo (X=max; M=Min; A=altro)',     'dosim_flg_tipo_dose' ,      CAST(dosim_flg_tipo_dose AS NVARCHAR(4000)), CAST(nextdosim_flg_tipo_dose  AS NVARCHAR(4000))) " &
		   + "  , ('dato Dose',     'dosim_dose' ,      CAST(dosim_dose AS NVARCHAR(4000)), CAST(nextdosim_dose  AS NVARCHAR(4000))) " &
		   + "  , ('dato Assorbanza',      'dosim_assorb' ,      CAST(dosim_assorb AS NVARCHAR(4000)), CAST(nextdosim_assorb  AS NVARCHAR(4000))) " &
		   + "  , ('dato Spessore',      'dosim_spessore' ,      CAST(dosim_spessore AS NVARCHAR(4000)), CAST(nextdosim_spessore  AS NVARCHAR(4000))) " &
		   + "  , ('dato Assorb./Spess.',      'dosim_rapp_a_s' ,      CAST(dosim_rapp_a_s AS NVARCHAR(4000)), CAST(nextdosim_rapp_a_s  AS NVARCHAR(4000))) " &
		   + "  , (' Lotto Dosim.',      'dosim_lotto_dosim' ,      CAST(dosim_lotto_dosim AS NVARCHAR(4000)), CAST(nextdosim_lotto_dosim  AS NVARCHAR(4000))) " &
		   + "  , ('dato Temperatura',      'dosim_temperatura' ,      CAST(dosim_temperatura AS NVARCHAR(4000)), CAST(nextdosim_temperatura  AS NVARCHAR(4000))) " &
		   + "  , ('dato Umidità',      'dosim_umidita' ,      CAST(dosim_umidita AS NVARCHAR(4000)), CAST(nextdosim_umidita  AS NVARCHAR(4000))) " &
		   + "  , ('Esito',      'err_lav_ok' ,      CAST(err_lav_ok AS NVARCHAR(4000)), CAST(nexterr_lav_ok  AS NVARCHAR(4000))) " &
		   + "  , ('Esito Note',      'note_lav_ok' ,      CAST(note_lav_ok AS NVARCHAR(4000)), CAST(nextnote_lav_ok  AS NVARCHAR(4000))) " &
		   + "  , ('Verificato il',      'x_data_dosim_verifica' ,      CAST(x_data_dosim_verifica AS NVARCHAR(4000)), CAST(nextx_data_dosim_verifica  AS NVARCHAR(4000))) " &
		   + "  , ('Verificato da Utente',      'x_utente_dosim_verifica' ,      CAST(x_utente_dosim_verifica AS NVARCHAR(4000)), CAST(nextx_utente_dosim_verifica  AS NVARCHAR(4000))) " &
		   + "  , ('Sbloccato il',      'x_data_dosim_sblocco_ko' ,      CAST(x_data_dosim_sblocco_ko AS NVARCHAR(4000)), CAST(nextx_data_dosim_sblocco_ko  AS NVARCHAR(4000))) " &
		   + "  , ('Sbloccato da Utente',      'x_utente_dosim_sblocco_ko' ,      CAST(x_utente_dosim_sblocco_ko AS NVARCHAR(4000)), CAST(nextx_utente_dosim_sblocco_ko  AS NVARCHAR(4000))) " &
		+ " 	   ) CA( coltext, colname, value, nextvalue)" &
		+ " WHERE  EXISTS(SELECT value" &
		      + " EXCEPT" &
		      + " SELECT nextvalue)" &
		      + " group by id_meca," &
		      + " barcode, coltext, Colname, value " &
		+ " )" &
  	 	 + " SELECT t1.id_meca   	as id_lotto " &
      		+ " , barcode" &
      		+ " , coltext			as colonna" &
      		+ " , colname			as colname" &
      		+ " , value			as valore" &
      		+ " , Attuale		    as 'Attuale'" &
      		+ " , x_ValidFrom      as 'Valido_dal'" &
      		+ " , (select t2.x_utente from t t2 where t2.x_ValidFrom = t1.x_ValidFrom and t2.id_meca = t1.id_meca and t2.barcode = t1.barcode) as utente " &
		+ " FROM  T1 " 

     // + "  where id_meca = 274041          " &
     //   + " ORDER  BY id_meca, " &
     //       + " id_armo, " &
     //       + " Colonna " &
     //       + " Valido_dal " 

	EXECUTE IMMEDIATE "drop VIEW v_temptable_meca_dosim " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_temptable_meca_dosim): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			
	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_temptable_meca_dosimbozza' completata." 
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	 
	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_temptable_meca_qtna () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_temptable_meca_qtna' 
//===
int k_errore
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception



//=== Puntatore Cursore da attesa..... 
	SetPointer(kkg.pointer_attesa)

	kuo_exception = create uo_exception
	kst_esito = kuo_exception.inizializza(this.classname())

	k_sql = "create view v_temptable_meca_qtna  " &
	  + " as " &
		+ " WITH T " &
		+ "      AS ( " & 
		+ "SELECT " &                                                                                                 
		+ "  '*' as Attuale " &
		+ "  , x_ValidFrom  " &
		+ "  , x_ValidTo " &
		+ "  , id_meca " &
      + "  , id_meca_qtna " &
      + "  , isnull(stampa_ddt_dicitura, '') stampa_ddt_dicitura " &
		+ "  , isnull(note, '') note " &
		+ "  , x_data_inizio " &
		+ "  , isnull(x_utente_inizio, '') x_utente_inizio " &
		+ "  , x_data_riapri " &
		+ "  , isnull(x_utente_riapri, '') x_utente_riapri " &
		+ "  , x_data_fine " &
		+ "  , isnull(x_utente_fine, '') x_utente_fine " &
		+ "  , isnull(sped_lotto_no_completo, '') sped_lotto_no_completo " &
		+ "  , x_utente " &
		+ "  , nextx_data_inizio = LAG(x_data_inizio) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente_inizio = LAG(x_utente_inizio) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextx_data_riapri = LAG(x_data_riapri) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente_riapri = LAG(x_utente_riapri) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextx_data_fine = LAG(x_data_fine) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente_fine = LAG(x_utente_fine) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextstampa_ddt_dicitura = LAG(stampa_ddt_dicitura) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextnote = LAG(note) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextsped_lotto_no_completo = LAG(sped_lotto_no_completo) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente = LAG(x_utente) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  FROM  meca_qtna " &
		+ "  union all " &
		+ "SELECT " &                                                                                                 
		+ "  ' ' as Attuale " &
		+ "  , x_ValidFrom  " &
		+ "  , x_ValidTo " &
		+ "  , id_meca " &
      + "  , id_meca_qtna " &
      + "  , isnull(stampa_ddt_dicitura, '') stampa_ddt_dicitura " &
		+ "  , isnull(note, '') note " &
		+ "  , x_data_inizio " &
		+ "  , isnull(x_utente_inizio, '') x_utente_inizio " &
		+ "  , x_data_riapri " &
		+ "  , isnull(x_utente_riapri, '') x_utente_riapri " &
		+ "  , x_data_fine " &
		+ "  , isnull(x_utente_fine, '') x_utente_fine " &
		+ "  , isnull(sped_lotto_no_completo, '') sped_lotto_no_completo " &
		+ "  , x_utente " &
		+ "  , nextx_data_inizio = LAG(x_data_inizio) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente_inizio = LAG(x_utente_inizio) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextx_data_riapri = LAG(x_data_riapri) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente_riapri = LAG(x_utente_riapri) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextx_data_fine = LAG(x_data_fine) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente_fine = LAG(x_utente_fine) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextstampa_ddt_dicitura = LAG(stampa_ddt_dicitura) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextnote = LAG(note) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextsped_lotto_no_completo = LAG(sped_lotto_no_completo) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente = LAG(x_utente) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  FROM  meca_qtnaH " &
		+ " ) " &
		+ ",  T1 " &
		+ "      AS (  " &
		+ " SELECT t.id_meca " &
		+ "  , id_meca_qtna " &
		+ "  , coltext			 " &
		+ "  , colname			 " &
		+ "  , value			 " &
		+ "  , max(Attuale) attuale " &
		+ "  , min(x_ValidFrom) x_validfrom " &
		+ " FROM  T  " &
		   + "   CROSS APPLY ( VALUES " &
		   + "    ('Aperto il', 'x_data_inizio' , CAST(x_data_inizio AS NVARCHAR(4000)), CAST(nextx_data_inizio  AS NVARCHAR(4000))) " &
		   + "  , ('Aperto da Utente', 'x_utente_inizio' , CAST(x_utente_inizio AS NVARCHAR(4000)), CAST(nextx_utente_inizio  AS NVARCHAR(4000))) " &
		   + "  , ('Riaperto il', 'x_data_riapri' , CAST(x_data_riapri AS NVARCHAR(4000)), CAST(nextx_data_riapri  AS NVARCHAR(4000))) " &
		   + "  , ('Riaperto da Utente', 'x_utente_riapri' , CAST(x_utente_riapri AS NVARCHAR(4000)), CAST(nextx_utente_riapri  AS NVARCHAR(4000))) " &
		   + "  , ('Chiuso il', 'x_data_fine' , CAST(x_data_fine AS NVARCHAR(4000)), CAST(nextx_data_fine  AS NVARCHAR(4000))) " &
		   + "  , ('Chiuso da Utente', 'x_utente_fine' , CAST(x_utente_fine AS NVARCHAR(4000)), CAST(nextx_utente_fine  AS NVARCHAR(4000))) " &
		   + "  , ('Dicitura su DDT', 'stampa_ddt_dicitura' , CAST(stampa_ddt_dicitura AS NVARCHAR(4000)), CAST(nextstampa_ddt_dicitura  AS NVARCHAR(4000))) " &
		   + "  , ('Note', 'note', CAST(note AS NVARCHAR(4000)), CAST(nextnote  AS NVARCHAR(4000))) " &
		   + "  , ('Lotto Incompleto',    'sped_lotto_no_completo' , CAST(sped_lotto_no_completo AS NVARCHAR(4000)), CAST(nextsped_lotto_no_completo  AS NVARCHAR(4000))) " &
		+ " 	   ) CA( coltext, colname, value, nextvalue)" &
		+ " WHERE  EXISTS(SELECT value" &
		      + " EXCEPT" &
		      + " SELECT nextvalue)" &
		      + " group by id_meca," &
		      + " id_meca_qtna, coltext, Colname, value " &
		+ " )" &
  	 	 + " SELECT t1.id_meca  as id_lotto " &
      		+ " , id_meca_qtna" &
      		+ " , coltext	as colonna" &
      		+ " , colname	as colname" &
      		+ " , value		as valore" &
      		+ " , Attuale	as 'Attuale'" &
      		+ " , x_ValidFrom as 'Valido_dal'" &
      		+ " , (select t2.x_utente from t t2 where t2.x_ValidFrom = t1.x_ValidFrom and t2.id_meca_qtna = t1.id_meca_qtna) as utente " &
		+ " FROM  T1 "
		
     // + "  where id_meca = 274041          " &
     //   + " ORDER  BY id_meca, " &
     //       + " id_armo, " &
     //       + " Colonna " &
     //       + " Valido_dal " 

	EXECUTE IMMEDIATE "drop VIEW v_temptable_meca_qtna " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_temptable_meca_qtna): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			
	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_temptable_meca_dosimbozza' completata." 
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	 
	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_temptable_barcode () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_temptable_barcode' 
//===
int k_errore
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception


//=== Puntatore Cursore da attesa..... 
	SetPointer(kkg.pointer_attesa)

	kuo_exception = create uo_exception
	kst_esito = kuo_exception.inizializza(this.classname())

	k_sql = "create view v_temptable_barcode  " &
	  + " as " &
		+ " WITH T " &
		+ "      AS ( " & 
		+ "SELECT " &                                                                                                 
		+ "  '*' as Attuale " & 
		+ "  , x_ValidFrom  " & 
		+ "  , x_ValidTo " & 
		+ "  , id_meca " & 
            + "  , id_armo " & 
            + "  , barcode " & 
            + "  , isnull(data, '') data  " &
            + "  , isnull(groupage, '') groupage  " &
            + "  , isnull(barcode_lav, '') barcode_lav  " &
            + "  , isnull(flg_dosimetro, '') flg_dosimetro  " &
            + "  , isnull(tipo, '') tipo  " &
            + "  , isnull(causale, '') causale  " &
            + "  , isnull(fila_1, 0) fila_1  " &
            + "  , isnull(fila_2, 0) fila_2  " &
            + "  , isnull(fila_1p, 0) fila_1p  " &
            + "  , isnull(fila_2p, 0) fila_2p  " &
            + "  , isnull(tipo_cicli, '') tipo_cicli  " &
            + "  , isnull(pl_barcode, 0) pl_barcode  " &
            + "  , isnull(num_int, 0) num_int  " &
            + "  , isnull(data_int, '') data_int  " &
            + "  , isnull(data_stampa, '') data_stampa  " &
            + "  , isnull(data_lav_ini, '') data_lav_ini  " &
            + "  , isnull(ora_lav_ini, '') ora_lav_ini  " &
            + "  , isnull(data_lav_fin, '') data_lav_fin  " &
            + "  , isnull(ora_lav_fin, '') ora_lav_fin  " &
            + "  , isnull(data_lav_ok, '') data_lav_ok  " &
            + "  , isnull(data_sosp, '') data_sosp  " &
            + "  , isnull(err_lav_fin, '') err_lav_fin  " &
            + "  , isnull(note_lav_fin, '') note_lav_fin  " &
            + "  , isnull(err_lav_ok, '') err_lav_ok  " &
            + "  , isnull(note_lav_ok, '') note_lav_ok  " &
            + "  , isnull(posizione, '') posizione  " &
            + "  , isnull(bilancella, 0) bilancella  " &
            + "  , isnull(lav_dose, 0) lav_dose  " &
            + "  , isnull(lav_fila_1, 0) lav_fila_1  " &
            + "  , isnull(lav_fila_2, 0) lav_fila_2  " &
            + "  , isnull(lav_fila_1p, 0) lav_fila_1p  " &
            + "  , isnull(lav_fila_2p, 0) lav_fila_2p  " &
            + "  , isnull(upd_data_fin, '') upd_data_fin  " &
            + "  , isnull(upd_utente_fin, '') upd_utente_fin  " &
            + "  , isnull(upd_data_ok, '') upd_data_ok  " &
            + "  , isnull(modgiri_data, '') modgiri_data  " &
            + "  , isnull(modgiri_utente, '') modgiri_utente  " &
            + "  , isnull(upd_utente_ok, '') upd_utente_ok  " &
            + "  , isnull(imptime_second, 0) imptime_second  " &
            + "  , isnull(flg_parziale, 0) flg_parziale  " &
            + "  , isnull(flg_campione, 0) flg_campione" &
		+ "  , x_utente " &
		+ "  , nextdata = LAG(data) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextgroupage = LAG(groupage) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextbarcode_lav = LAG(barcode_lav) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextflg_dosimetro = LAG(flg_dosimetro) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nexttipo = LAG(tipo) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextcausale = LAG(causale) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextfila_1 = LAG(fila_1) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextfila_2 = LAG(fila_2) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextfila_1p = LAG(fila_1p) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextfila_2p = LAG(fila_2p) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nexttipo_cicli = LAG(tipo_cicli) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextpl_barcode = LAG(pl_barcode) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextnum_int = LAG(num_int) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdata_int = LAG(data_int) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdata_stampa = LAG(data_stampa) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdata_lav_ini = LAG(data_lav_ini) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextora_lav_ini = LAG(ora_lav_ini) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdata_lav_fin = LAG(data_lav_fin) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextora_lav_fin = LAG(ora_lav_fin) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdata_lav_ok = LAG(data_lav_ok) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdata_sosp = LAG(data_sosp) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nexterr_lav_fin = LAG(err_lav_fin) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextnote_lav_fin = LAG(note_lav_fin) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nexterr_lav_ok = LAG(err_lav_ok) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextnote_lav_ok = LAG(note_lav_ok) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextposizione = LAG(posizione) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextbilancella = LAG(bilancella) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextlav_dose = LAG(lav_dose) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextlav_fila_1 = LAG(lav_fila_1) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextlav_fila_2 = LAG(lav_fila_2) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextlav_fila_1p = LAG(lav_fila_1p) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextlav_fila_2p = LAG(lav_fila_2p) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextupd_data_fin = LAG(upd_data_fin) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextupd_utente_fin = LAG(upd_utente_fin) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextupd_data_ok = LAG(upd_data_ok) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextmodgiri_data = LAG(modgiri_data) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextmodgiri_utente = LAG(modgiri_utente) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextupd_utente_ok = LAG(upd_utente_ok) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextimptime_second = LAG(imptime_second) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextflg_parziale = LAG(flg_parziale) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextflg_campione = LAG(flg_campione) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente = LAG(x_utente) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  FROM  barcode " &
		+ "  union all " &
		+ "SELECT " &                                                                                                 
		+ "  ' ' as Attuale " &
		+ "  , x_ValidFrom  " &
		+ "  , x_ValidTo " &
		+ "  , id_meca " &
            + "  , id_armo " &
            + "  , barcode " &
            + "  , isnull(data, '') data  " &
            + "  , isnull(groupage, '') groupage  " &
            + "  , isnull(barcode_lav, '') barcode_lav  " &
            + "  , isnull(flg_dosimetro, '') flg_dosimetro  " &
            + "  , isnull(tipo, '') tipo  " &
            + "  , isnull(causale, '') causale  " &
            + "  , isnull(fila_1, 0) fila_1  " &
            + "  , isnull(fila_2, 0) fila_2  " &
            + "  , isnull(fila_1p, 0) fila_1p  " &
            + "  , isnull(fila_2p, 0) fila_2p  " &
            + "  , isnull(tipo_cicli, '') tipo_cicli  " &
            + "  , isnull(pl_barcode, 0) pl_barcode  " &
            + "  , isnull(num_int, 0) num_int  " &
            + "  , isnull(data_int, '') data_int  " &
            + "  , isnull(data_stampa, '') data_stampa  " &
            + "  , isnull(data_lav_ini, '') data_lav_ini  " &
            + "  , isnull(ora_lav_ini, '') ora_lav_ini  " &
            + "  , isnull(data_lav_fin, '') data_lav_fin  " &
            + "  , isnull(ora_lav_fin, '') ora_lav_fin  " &
            + "  , isnull(data_lav_ok, '') data_lav_ok  " &
            + "  , isnull(data_sosp, '') data_sosp  " &
            + "  , isnull(err_lav_fin, '') err_lav_fin  " &
            + "  , isnull(note_lav_fin, '') note_lav_fin  " &
            + "  , isnull(err_lav_ok, '') err_lav_ok  " &
            + "  , isnull(note_lav_ok, '') note_lav_ok  " &
            + "  , isnull(posizione, '') posizione  " &
            + "  , isnull(bilancella, 0) bilancella  " &
            + "  , isnull(lav_dose, 0) lav_dose  " &
            + "  , isnull(lav_fila_1, 0) lav_fila_1  " &
            + "  , isnull(lav_fila_2, 0) lav_fila_2  " &
            + "  , isnull(lav_fila_1p, 0) lav_fila_1p  " &
            + "  , isnull(lav_fila_2p, 0) lav_fila_2p  " &
            + "  , isnull(upd_data_fin, '') upd_data_fin  " &
            + "  , isnull(upd_utente_fin, '') upd_utente_fin  " &
            + "  , isnull(upd_data_ok, '') upd_data_ok  " &
            + "  , isnull(modgiri_data, '') modgiri_data  " &
            + "  , isnull(modgiri_utente, '') modgiri_utente  " &
            + "  , isnull(upd_utente_ok, '') upd_utente_ok  " &
            + "  , isnull(imptime_second, 0) imptime_second  " &
            + "  , isnull(flg_parziale, 0) flg_parziale  " &
            + "  , isnull(flg_campione, 0) flg_campione" &
		+ "  , x_utente " &
		+ "  , nextdata = LAG(data) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextgroupage = LAG(groupage) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextbarcode_lav = LAG(barcode_lav) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextflg_dosimetro = LAG(flg_dosimetro) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nexttipo = LAG(tipo) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextcausale = LAG(causale) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextfila_1 = LAG(fila_1) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextfila_2 = LAG(fila_2) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextfila_1p = LAG(fila_1p) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextfila_2p = LAG(fila_2p) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nexttipo_cicli = LAG(tipo_cicli) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextpl_barcode = LAG(pl_barcode) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextnum_int = LAG(num_int) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdata_int = LAG(data_int) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdata_stampa = LAG(data_stampa) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdata_lav_ini = LAG(data_lav_ini) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextora_lav_ini = LAG(ora_lav_ini) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdata_lav_fin = LAG(data_lav_fin) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextora_lav_fin = LAG(ora_lav_fin) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdata_lav_ok = LAG(data_lav_ok) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextdata_sosp = LAG(data_sosp) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nexterr_lav_fin = LAG(err_lav_fin) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextnote_lav_fin = LAG(note_lav_fin) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nexterr_lav_ok = LAG(err_lav_ok) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextnote_lav_ok = LAG(note_lav_ok) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextposizione = LAG(posizione) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextbilancella = LAG(bilancella) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextlav_dose = LAG(lav_dose) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextlav_fila_1 = LAG(lav_fila_1) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextlav_fila_2 = LAG(lav_fila_2) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextlav_fila_1p = LAG(lav_fila_1p) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextlav_fila_2p = LAG(lav_fila_2p) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextupd_data_fin = LAG(upd_data_fin) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextupd_utente_fin = LAG(upd_utente_fin) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextupd_data_ok = LAG(upd_data_ok) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextmodgiri_data = LAG(modgiri_data) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextmodgiri_utente = LAG(modgiri_utente) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextupd_utente_ok = LAG(upd_utente_ok) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextimptime_second = LAG(imptime_second) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextflg_parziale = LAG(flg_parziale) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextflg_campione = LAG(flg_campione) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente = LAG(x_utente) OVER (PARTITION BY barcode ORDER BY x_ValidFrom) " &
		+ "  FROM  barcodeH " &
		+ " ) " &
		+ ",  T1 " &
		+ "      AS (  " &
		+ " SELECT t.id_meca " &
		+ "  , barcode " &
		+ "  , coltext			 " &
		+ "  , colname			 " &
		+ "  , value			 " &
		+ "  , max(Attuale) attuale " &
		+ "  , min(x_ValidFrom) x_validfrom " &
		+ " FROM  T  " &
		   + "   CROSS APPLY ( VALUES " &
		   + "    ('Data', 'data' , CAST(data AS NVARCHAR(4000)), CAST(nextdata AS NVARCHAR(4000))) " &
		   + "    ,('In groupage', 'groupage' , CAST(groupage AS NVARCHAR(4000)), CAST(nextgroupage AS NVARCHAR(4000))) " &
		   + "    ,('Barcode padre', 'barcode_lav' , CAST(barcode_lav AS NVARCHAR(4000)), CAST(nextbarcode_lav AS NVARCHAR(4000))) " &
		   + "    ,('Dosimetro', 'flg_dosimetro' , CAST(flg_dosimetro AS NVARCHAR(4000)), CAST(nextflg_dosimetro AS NVARCHAR(4000))) " &
		   + "    ,('Tipo', 'tipo' , CAST(tipo AS NVARCHAR(4000)), CAST(nexttipo AS NVARCHAR(4000))) " &
		   + "    ,('Causale', 'causale' , CAST(causale AS NVARCHAR(4000)), CAST(nextcausale AS NVARCHAR(4000))) " &
		   + "    ,('Giri Fila 1 previsti', 'fila_1' , CAST(fila_1 AS NVARCHAR(4000)), CAST(nextfila_1 AS NVARCHAR(4000))) " &
		   + "    ,('Giri Fila 2 previsti', 'fila_2' , CAST(fila_2 AS NVARCHAR(4000)), CAST(nextfila_2 AS NVARCHAR(4000))) " &
		   + "    ,('Giri Fila 1p previsti', 'fila_1p' , CAST(fila_1p AS NVARCHAR(4000)), CAST(nextfila_1p AS NVARCHAR(4000))) " &
		   + "    ,('Giri Fila 2p previsti', 'fila_2p' , CAST(fila_2p AS NVARCHAR(4000)), CAST(nextfila_2p AS NVARCHAR(4000))) " &
		   + "    ,('Tipo Cicli', 'tipo_cicli' , CAST(tipo_cicli AS NVARCHAR(4000)), CAST(nexttipo_cicli AS NVARCHAR(4000))) " &
		   + "    ,('Piano di Lavoro Id', 'pl_barcode' , CAST(pl_barcode AS NVARCHAR(4000)), CAST(nextpl_barcode AS NVARCHAR(4000))) " &
		   + "    ,('Lotto n.', 'num_int' , CAST(num_int AS NVARCHAR(4000)), CAST(nextnum_int AS NVARCHAR(4000))) " &
		   + "    ,('Lotto data', 'data_int' , CAST(data_int AS NVARCHAR(4000)), CAST(nextdata_int AS NVARCHAR(4000))) " &
		   + "    ,('Stampato il', 'data_stampa' , CAST(data_stampa AS NVARCHAR(4000)), CAST(nextdata_stampa AS NVARCHAR(4000))) " &
		   + "    ,('Tratt.iniziato il', 'data_lav_ini' , CAST(data_lav_ini AS NVARCHAR(4000)), CAST(nextdata_lav_ini AS NVARCHAR(4000))) " &
		   + "    ,('Tratt.iniziato alle', 'ora_lav_ini' , CAST(ora_lav_ini AS NVARCHAR(4000)), CAST(nextora_lav_ini AS NVARCHAR(4000))) " &
		   + "    ,('Tratt.terminato il', 'data_lav_fin' , CAST(data_lav_fin AS NVARCHAR(4000)), CAST(nextdata_lav_fin AS NVARCHAR(4000))) " &
		   + "    ,('Tratt.terminato alle', 'ora_lav_fin' , CAST(ora_lav_fin AS NVARCHAR(4000)), CAST(nextora_lav_fin AS NVARCHAR(4000))) " &
		   + "    ,('Tratt.Convalidato il', 'data_lav_ok' , CAST(data_lav_ok AS NVARCHAR(4000)), CAST(nextdata_lav_ok AS NVARCHAR(4000))) " &
		   + "    ,('Sospeso il', 'data_sosp' , CAST(data_sosp AS NVARCHAR(4000)), CAST(nextdata_sosp AS NVARCHAR(4000))) " &
		   + "    ,('Tratt.Esito (1=err)', 'err_lav_fin' , CAST(err_lav_fin AS NVARCHAR(4000)), CAST(nexterr_lav_fin AS NVARCHAR(4000))) " &
		   + "    ,('Tratt.Esito Note', 'note_lav_fin' , CAST(note_lav_fin AS NVARCHAR(4000)), CAST(nextnote_lav_fin AS NVARCHAR(4000))) " &
		   + "    ,('Conv.Esito (1=err)', 'err_lav_ok' , CAST(err_lav_ok AS NVARCHAR(4000)), CAST(nexterr_lav_ok AS NVARCHAR(4000))) " &
		   + "    ,('Conv.Esito Note', 'note_lav_ok' , CAST(note_lav_ok AS NVARCHAR(4000)), CAST(nextnote_lav_ok AS NVARCHAR(4000))) " &
		   + "    ,('Posizione', 'posizione' , CAST(posizione AS NVARCHAR(4000)), CAST(nextposizione AS NVARCHAR(4000))) " &
		   + "    ,('Bilancella', 'bilancella' , CAST(bilancella AS NVARCHAR(4000)), CAST(nextbilancella AS NVARCHAR(4000))) " &
		   + "    ,('lav_dose', 'lav_dose' , CAST(lav_dose AS NVARCHAR(4000)), CAST(nextlav_dose AS NVARCHAR(4000))) " &
		   + "    ,('Giri fila 1 effettivi', 'lav_fila_1' , CAST(lav_fila_1 AS NVARCHAR(4000)), CAST(nextlav_fila_1 AS NVARCHAR(4000))) " &
		   + "    ,('Giri fila_2 effettivi', 'lav_fila_2' , CAST(lav_fila_2 AS NVARCHAR(4000)), CAST(nextlav_fila_2 AS NVARCHAR(4000))) " &
		   + "    ,('Giri fila 1p effettivi', 'lav_fila_1p' , CAST(lav_fila_1p AS NVARCHAR(4000)), CAST(nextlav_fila_1p AS NVARCHAR(4000))) " &
		   + "    ,('Giri fila 2p effettivi', 'lav_fila_2p' , CAST(lav_fila_2p AS NVARCHAR(4000)), CAST(nextlav_fila_2p AS NVARCHAR(4000))) " &
		   + "    ,('Tratt. aggiornato il', 'upd_data_fin' , CAST(upd_data_fin AS NVARCHAR(4000)), CAST(nextupd_data_fin AS NVARCHAR(4000))) " &
		   + "    ,('Tratt. aggiornato da utente', 'upd_utente_fin' , CAST(upd_utente_fin AS NVARCHAR(4000)), CAST(nextupd_utente_fin AS NVARCHAR(4000))) " &
		   + "    ,('Conv. aggiornato il', 'upd_data_ok' , CAST(upd_data_ok AS NVARCHAR(4000)), CAST(nextupd_data_ok AS NVARCHAR(4000))) " &
		   + "    ,('Conv. aggiornato da utente', 'upd_utente_ok' , CAST(upd_utente_ok AS NVARCHAR(4000)), CAST(nextupd_utente_ok AS NVARCHAR(4000))) " &
		   + "    ,('Giri aggiornati il', 'modgiri_data' , CAST(modgiri_data AS NVARCHAR(4000)), CAST(nextmodgiri_data AS NVARCHAR(4000))) " &
		   + "    ,('Giri aggiornati da utente', 'modgiri_utente' , CAST(modgiri_utente AS NVARCHAR(4000)), CAST(nextmodgiri_utente AS NVARCHAR(4000))) " &
		   + "    ,('Tratt.Tempi (secondi)', 'imptime_second' , CAST(imptime_second AS NVARCHAR(4000)), CAST(nextimptime_second AS NVARCHAR(4000))) " &
		   + "    ,('Parziale', 'flg_parziale' , CAST(flg_parziale AS NVARCHAR(4000)), CAST(nextflg_parziale AS NVARCHAR(4000))) " &
		   + "    ,('Controcampione abbinato', 'flg_campione' , CAST(flg_campione AS NVARCHAR(4000)), CAST(nextflg_campione AS NVARCHAR(4000))) " &
		+ " 	   ) CA( coltext, colname, value, nextvalue)" &
		+ " WHERE  EXISTS(SELECT value" &
		      + " EXCEPT" &
		      + " SELECT nextvalue)" &
		      + " group by id_meca," &
		      + " barcode, coltext, Colname, value " &
		+ " )" &
  	 	 + " SELECT t1.id_meca  as id_lotto " &
      		+ " , barcode" &
      		+ " , coltext	as colonna" &
      		+ " , colname	as colname" &
      		+ " , value		as valore" &
      		+ " , Attuale	as 'Attuale'" &
      		+ " , x_ValidFrom as 'Valido_dal'" &
      		+ " , (select distinct t2.x_utente from t t2 where t2.x_ValidFrom = t1.x_ValidFrom and t2.barcode = t1.barcode) as utente " &
		+ " FROM  T1 " 
		
		
     // + "  where id_meca = 274041          " &
     //   + " ORDER  BY id_meca, " &
     //       + " id_armo, " &
     //       + " Colonna " &
     //       + " Valido_dal " 

	EXECUTE IMMEDIATE "drop VIEW v_temptable_barcode " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_temptable_barcode): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			
	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_temptable_barcode' completata." 
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	 
	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_temptable_certif () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_temptable_certif' 
//===
int k_errore
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception



//=== Puntatore Cursore da attesa..... 
	SetPointer(kkg.pointer_attesa)

	kuo_exception = create uo_exception
	kst_esito = kuo_exception.inizializza(this.classname())

	k_sql = "create view v_temptable_certif  " &
	  + " as " &
		+ " WITH T " &
		+ "      AS ( " & 
		+ "SELECT " &                                                                                                 
		+ "  '*' as Attuale " & 
		+ "  , x_ValidFrom  " & 
		+ "  , x_ValidTo " & 
		+ "  , id_meca " & 
            + "  , id " & 
            + "  , num_certif " & 
            + "  , isnull(data, '') data  " &
            + "  , isnull(ora, '') ora  " &
            + "  , isnull(data_stampa, '') data_stampa  " &
            + "  , isnull(ora_stampa, '') ora_stampa  " &
            + "  , isnull(clie_2, 0) clie_2  " &
            + "  , isnull(colli, 0) colli  " &
            + "  , isnull(dose, 0) dose  " &
            + "  , isnull(dose_min, 0) dose_min  " &
            + "  , isnull(dose_max, 0) dose_max  " &
            + "  , isnull(lav_data_ini, '') lav_data_ini  " &
            + "  , isnull(lav_data_fin, '') lav_data_fin  " &
            + "  , isnull(note, '') note  " &
            + "  , isnull(note_1, '') note_1  " &
            + "  , isnull(note_2, '') note_2  " &
            + "  , isnull(st_dose_min, '') st_dose_min  " &
            + "  , isnull(st_dose_max, '') st_dose_max  " &
            + "  , isnull(st_data_ini, '') st_data_ini  " &
            + "  , isnull(st_data_fin, '') st_data_fin  " &
            + "  , isnull(st_dati_bolla_in, '') st_dati_bolla_in  " &
            + "  , isnull(form_di_stampa, '') form_di_stampa  " &
            + "  , isnull(flg_ristampa_xddt, '') flg_ristampa_xddt  " &
		+ "  , x_utente " &
		+ "  , nextnum_certif = LAG(num_certif) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextdata = LAG(data) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextora = LAG(ora) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextdata_stampa = LAG(data_stampa) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextora_stampa = LAG(ora_stampa) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextclie_2 = LAG(clie_2) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextcolli = LAG(colli) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextdose = LAG(dose) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextdose_min = LAG(dose_min) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextdose_max = LAG(dose_max) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextlav_data_ini = LAG(lav_data_ini) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextlav_data_fin = LAG(lav_data_fin) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextnote = LAG(note) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextnote_1 = LAG(note_1) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextnote_2 = LAG(note_2) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextst_dose_min = LAG(st_dose_min) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextst_dose_max = LAG(st_dose_max) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextst_data_ini = LAG(st_data_ini) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextst_data_fin = LAG(st_data_fin) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextst_dati_bolla_in = LAG(st_dati_bolla_in) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextform_di_stampa = LAG(form_di_stampa) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextflg_ristampa_xddt = LAG(flg_ristampa_xddt) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente = LAG(x_utente) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  FROM  certif " &
		+ "  union all " &
		+ "SELECT " &                                                                                                 
		+ "  ' ' as Attuale " &
		+ "  , x_ValidFrom  " &
		+ "  , x_ValidTo " &
		+ "  , id_meca " & 
            + "  , id " & 
            + "  , num_certif " & 
            + "  , isnull(data, '') data  " &
            + "  , isnull(ora, '') ora  " &
            + "  , isnull(data_stampa, '') data_stampa  " &
            + "  , isnull(ora_stampa, '') ora_stampa  " &
            + "  , isnull(clie_2, 0) clie_2  " &
            + "  , isnull(colli, 0) colli  " &
            + "  , isnull(dose, 0) dose  " &
            + "  , isnull(dose_min, 0) dose_min  " &
            + "  , isnull(dose_max, 0) dose_max  " &
            + "  , isnull(lav_data_ini, '') lav_data_ini  " &
            + "  , isnull(lav_data_fin, '') lav_data_fin  " &
            + "  , isnull(note, '') note  " &
            + "  , isnull(note_1, '') note_1  " &
            + "  , isnull(note_2, '') note_2  " &
            + "  , isnull(st_dose_min, '') st_dose_min  " &
            + "  , isnull(st_dose_max, '') st_dose_max  " &
            + "  , isnull(st_data_ini, '') st_data_ini  " &
            + "  , isnull(st_data_fin, '') st_data_fin  " &
            + "  , isnull(st_dati_bolla_in, '') st_dati_bolla_in  " &
            + "  , isnull(form_di_stampa, '') form_di_stampa  " &
            + "  , isnull(flg_ristampa_xddt, '') flg_ristampa_xddt  " &
		+ "  , x_utente " &
		+ "  , nextnum_certif = LAG(num_certif) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextdata = LAG(data) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextora = LAG(ora) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextdata_stampa = LAG(data_stampa) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextora_stampa = LAG(ora_stampa) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextclie_2 = LAG(clie_2) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextcolli = LAG(colli) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextdose = LAG(dose) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextdose_min = LAG(dose_min) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextdose_max = LAG(dose_max) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextlav_data_ini = LAG(lav_data_ini) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextlav_data_fin = LAG(lav_data_fin) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextnote = LAG(note) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextnote_1 = LAG(note_1) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextnote_2 = LAG(note_2) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextst_dose_min = LAG(st_dose_min) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextst_dose_max = LAG(st_dose_max) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextst_data_ini = LAG(st_data_ini) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextst_data_fin = LAG(st_data_fin) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextst_dati_bolla_in = LAG(st_dati_bolla_in) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextform_di_stampa = LAG(form_di_stampa) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextflg_ristampa_xddt = LAG(flg_ristampa_xddt) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente = LAG(x_utente) OVER (PARTITION BY id_meca ORDER BY x_ValidFrom) " &
		+ "  FROM  certifH " &
		+ " ) " &
		+ ",  T1 " &
		+ "      AS (  " &
		+ " SELECT t.id_meca " &
		+ "  , id " &
		+ "  , num_certif " &
		+ "  , coltext			 " &
		+ "  , colname			 " &
		+ "  , value			 " &
		+ "  , max(Attuale) attuale " &
		+ "  , min(x_ValidFrom) x_validfrom " &
		+ " FROM  T  " &
		   + "   CROSS APPLY ( VALUES " &
		   + "    ('num_certif', 'num_certif' , CAST(num_certif AS NVARCHAR(4000)), CAST(nextnum_certif AS NVARCHAR(4000))) " &
		   + "    ,('Generato il', 'data' , CAST(data AS NVARCHAR(4000)), CAST(nextdata AS NVARCHAR(4000))) " &
		   + "    ,('Generato alle', 'ora' , CAST(ora AS NVARCHAR(4000)), CAST(nextora AS NVARCHAR(4000))) " &
		   + "    ,('Stampato il', 'data_stampa' , CAST(data_stampa AS NVARCHAR(4000)), CAST(nextdata_stampa AS NVARCHAR(4000))) " &
		   + "    ,('Stampato alle', 'ora_stampa' , CAST(ora_stampa AS NVARCHAR(4000)), CAST(nextora_stampa AS NVARCHAR(4000))) " &
		   + "    ,('Ricevente', 'clie_2' , CAST(clie_2 AS NVARCHAR(4000)), CAST(nextclie_2 AS NVARCHAR(4000))) " &
		   + "    ,('colli', 'colli' , CAST(colli AS NVARCHAR(4000)), CAST(nextcolli AS NVARCHAR(4000))) " &
		   + "    ,('dose', 'dose' , CAST(dose AS NVARCHAR(4000)), CAST(nextdose AS NVARCHAR(4000))) " &
		   + "    ,('dose min', 'dose_min' , CAST(dose_min AS NVARCHAR(4000)), CAST(nextdose_min AS NVARCHAR(4000))) " &
		   + "    ,('dose max', 'dose_max' , CAST(dose_max AS NVARCHAR(4000)), CAST(nextdose_max AS NVARCHAR(4000))) " &
		   + "    ,('Tratt. Iniziato il', 'lav_data_ini' , CAST(lav_data_ini AS NVARCHAR(4000)), CAST(nextlav_data_ini AS NVARCHAR(4000))) " &
		   + "    ,('Tratt. Finito il', 'lav_data_fin' , CAST(lav_data_fin AS NVARCHAR(4000)), CAST(nextlav_data_fin AS NVARCHAR(4000))) " &
		   + "    ,('Note', 'note' , CAST(note AS NVARCHAR(4000)), CAST(nextnote AS NVARCHAR(4000))) " &
		   + "    ,('Note 1', 'note_1' , CAST(note_1 AS NVARCHAR(4000)), CAST(nextnote_1 AS NVARCHAR(4000))) " &
		   + "    ,('Note 2', 'note_2' , CAST(note_2 AS NVARCHAR(4000)), CAST(nextnote_2 AS NVARCHAR(4000))) " &
		   + "    ,('Stampa dose min', 'st_dose_min' , CAST(st_dose_min AS NVARCHAR(4000)), CAST(nextst_dose_min AS NVARCHAR(4000))) " &
		   + "    ,('Stampa dose max', 'st_dose_max' , CAST(st_dose_max AS NVARCHAR(4000)), CAST(nextst_dose_max AS NVARCHAR(4000))) " &
		   + "    ,('Stampa data inizio', 'st_data_ini' , CAST(st_data_ini AS NVARCHAR(4000)), CAST(nextst_data_ini AS NVARCHAR(4000))) " &
		   + "    ,('Stampa data fine', 'st_data_fin' , CAST(st_data_fin AS NVARCHAR(4000)), CAST(nextst_data_fin AS NVARCHAR(4000))) " &
		   + "    ,('Stampa dati ddt entrato', 'st_dati_bolla_in' , CAST(st_dati_bolla_in AS NVARCHAR(4000)), CAST(nextst_dati_bolla_in AS NVARCHAR(4000))) " &
		   + "    ,('Layout di stampa', 'form_di_stampa' , CAST(form_di_stampa AS NVARCHAR(4000)), CAST(nextform_di_stampa AS NVARCHAR(4000))) " &
		   + "    ,('Ristampa uff.Sped.', 'flg_ristampa_xddt' , CAST(flg_ristampa_xddt AS NVARCHAR(4000)), CAST(nextflg_ristampa_xddt AS NVARCHAR(4000))) " &
		+ " 	   ) CA( coltext, colname, value, nextvalue)" &
		+ " WHERE  EXISTS(SELECT value" &
		      + " EXCEPT" &
		      + " SELECT nextvalue)" &
		      + " group by id_meca," &
		      + " id, num_certif, coltext, Colname, value " &
		+ " )" &
  	 	 + " SELECT t1.id_meca  as id_lotto " &
      		+ " , id" &
      		+ " , num_certif" &
      		+ " , coltext	as colonna" &
      		+ " , colname	as colname" &
      		+ " , value		as valore" &
      		+ " , Attuale	as 'Attuale'" &
      		+ " , x_ValidFrom as 'Valido_dal'" &
      		+ " , (select t2.x_utente from t t2 where t2.x_ValidFrom = t1.x_ValidFrom and t2.id = t1.id) as utente " &
		+ " FROM  T1 "
		
     // + "  where id_meca = 274041          " &
     //   + " ORDER  BY id_meca, " &
     //       + " id_armo, " &
     //       + " Colonna " &
     //       + " Valido_dal " 

	EXECUTE IMMEDIATE "drop VIEW v_temptable_certif " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_temptable_certif): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			
	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_temptable_certif' completata." 
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	 
	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_temptable_sl_pt () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_temptable_sl_pt' 
//===
int k_errore
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception



//=== Puntatore Cursore da attesa..... 
	SetPointer(kkg.pointer_attesa)

	kuo_exception = create uo_exception
	kst_esito = kuo_exception.inizializza(this.classname())

	k_sql = "create view v_temptable_sl_pt  " &
	  + " as " &
	   + " WITH T " &
		+ "AS ( " & 
		+ "SELECT " &                                                                                                 
		+ "  '*' as Attuale " & 
		+ "  , x_ValidFrom  " & 
		+ "  , x_ValidTo " & 
            + ",cod_sl_pt " &
            + ",isnull(descr, '') descr "&
            + ",isnull(tipo_cicli, '') tipo_cicli "&
            + ",isnull(fila_pref, '') fila_pref "&
            + ",isnull(fila_1, 0) fila_1 "&
            + ",isnull(fila_2, 0) fila_2 "&
            + ",isnull(fila_1p, 0) fila_1p "&
            + ",isnull(fila_2p, 0) fila_2p "&
            + ",isnull(dose, 0.0) dose "&
            + ",isnull(dose_min, 0.0) dose_min "&
            + ",isnull(dose_max, 0.0) dose_max "&
            + ",isnull(composizione, '') composizione "&
            + ",isnull(peso, '') peso "&
            + ",isnull(routine, '') routine "&
            + ",isnull(dosimetrie_spec, '') dosimetrie_spec "&
            + ",isnull(note_descr, '') note_descr "&
            + ",isnull(tipo, '') tipo "&
            + ",isnull(magazzino, 0) magazzino "&
            + ",isnull(mis_x, 0) mis_x "&
            + ",isnull(mis_y, 0) mis_y "&
            + ",isnull(mis_z, 0) mis_z "&
            + ",isnull(proposta_tipo_cicli, '') proposta_tipo_cicli "&
            + ",isnull(proposta_fila_pref, '') proposta_fila_pref "&
            + ",isnull(proposta_fila_1, 0) proposta_fila_1 "&
            + ",isnull(proposta_fila_1p, 0) proposta_fila_1p "&
            + ",isnull(proposta_fila_2, 0) proposta_fila_2 "&
            + ",isnull(proposta_fila_2p, 0) proposta_fila_2p "&
            + ",proposta_data proposta_data "&
            + ",isnull(proposta_utente, '') proposta_utente "&
            + ",isnull(dosim_x_bcode, 0) dosim_x_bcode "&
            + ",isnull(dosim_delta_bcode, 0) dosim_delta_bcode "&
            + ",isnull(dosim_et_descr, '') dosim_et_descr "&
            + ",isnull(dosetgminmin, 0.0) dosetgminmin "&
            + ",isnull(dosetgminmax, 0.0) dosetgminmax "&
            + ",isnull(dosetgmaxmin, 0.0) dosetgmaxmin "&
            + ",isnull(dosetgmaxmax, 0.0) dosetgmaxmax "&
            + ",isnull(dosetgminfattcorr, 0.0) dosetgminfattcorr "&
            + ",isnull(dosetgmaxfattcorr, 0.0) dosetgmaxfattcorr "&
            + ",isnull(dosetgmintcalc, '') dosetgmintcalc "&
            + ",isnull(dosetgmaxtcalc, '') dosetgmaxtcalc "&
            + ",isnull(dosetgminfattcorr_max, 0.0) dosetgminfattcorr_max "&
            + ",isnull(dosetgmaxfattcorr_max, 0.0) dosetgmaxfattcorr_max "&
            + ",isnull(dosetgmintcalc_max, '') dosetgmintcalc_max "&
            + ",isnull(dosetgmaxtcalc_max, '') dosetgmaxtcalc_max "&
            + ",isnull(pesomax, '') pesomax "&
            + ",isnull(densita, 0.0) densita "&
            + ",isnull(densitamax, 0.0) densitamax "&
            + ",isnull(notestoccaggio, '') notestoccaggio "&
            + ",isnull(id_cliente, 0) id_cliente "&
            + ",isnull(cert_st_dose_min, '') cert_st_dose_min "&
            + ",isnull(cert_st_dose_max, '') cert_st_dose_max "&
            + ",isnull(cert_st_data_ini, '') cert_st_data_ini "&
            + ",isnull(cert_st_data_fin, '') cert_st_data_fin "&
            + ",isnull(notecliente, '') notecliente "&
            + ",isnull(unitwork, 0.0) unitwork "&
            + ",isnull(savedosimeter, 0) savedosimeter "&
            + ",isnull(packingformin_file, '') packingformin_file "&
            + ",isnull(impianto, 0) impianto "&
		+ "  , x_utente " &
		+ "  , nextdescr = LAG(descr) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nexttipo_icli = LAG(tipo_cicli) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextfila_pref = LAG(fila_pref) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextfila_1 = LAG(fila_1) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextfila_2 = LAG(fila_2) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextfila_1p = LAG(fila_1p) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextfila_2p = LAG(fila_2p) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdose = LAG(dose) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdose_min = LAG(dose_min) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdose_max = LAG(dose_max) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextcomposizione = LAG(composizione) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextpeso = LAG(peso) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextroutine = LAG(routine) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosimetrie_spec = LAG(dosimetrie_spec) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextnote_descr = LAG(note_descr) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nexttipo = LAG(tipo) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextmagazzino = LAG(magazzino) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextmis_x = LAG(mis_x) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextmis_y= LAG(mis_y) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextmis_z= LAG(mis_z) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextproposta_tipo_cicli = LAG(proposta_tipo_cicli) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextproposta_fila_pref = LAG(proposta_fila_pref) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextproposta_fila_1 = LAG(proposta_fila_1) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextproposta_fila_1p = LAG(proposta_fila_1p) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextproposta_fila_2 = LAG(proposta_fila_2) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextproposta_fila_2p = LAG(proposta_fila_2p) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextproposta_data = LAG(proposta_data) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextproposta_utente = LAG(proposta_utente) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_x_bcode = LAG(dosim_x_bcode) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_delta_bcode = LAG(dosim_delta_bcode) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_et_descr = LAG(dosim_et_descr) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgminmin = LAG(dosetgminmin) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgminmax = LAG(dosetgminmax) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxmin = LAG(dosetgmaxmin) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxmax = LAG(dosetgmaxmax) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgminfattcorr = LAG(dosetgminfattcorr) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxfattcorr = LAG(dosetgmaxfattcorr) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmintcalc = LAG(dosetgmintcalc) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxtcalc = LAG(dosetgmaxtcalc) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgminfattcorr_max = LAG(dosetgminfattcorr_max) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxfattcorr_max = LAG(dosetgmaxfattcorr_max) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmintcalc_max = LAG(dosetgmintcalc_max) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxtcalc_max = LAG(dosetgmaxtcalc_max) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextpesomax = LAG(pesomax) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdensita= LAG(densita) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdensitamax = LAG(densitamax) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextnotestoccaggio = LAG(notestoccaggio) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextid_cliente = LAG(id_cliente) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextcert_st_dose_min = LAG(cert_st_dose_min) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextcert_st_dose_max = LAG(cert_st_dose_max) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextcert_st_data_ini = LAG(cert_st_data_ini) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextcert_st_data_fin = LAG(cert_st_data_fin) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextnotecliente = LAG(notecliente) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextunitwork = LAG(unitwork) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextsavedosimeter = LAG(savedosimeter) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextpackingformin_file = LAG(packingformin_file) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextimpianto = LAG(impianto) OVER (PARTITION BY impianto ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente = LAG(x_utente) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  FROM sl_pt " &
		+ "  union all " &
		+ "SELECT " &                                                                                                 
		+ "  ' ' as Attuale " &
		+ "  , x_ValidFrom  " &
		+ "  , x_ValidTo " &
            + ",cod_sl_pt " &
            + ",isnull(descr, '') descr "&
            + ",isnull(tipo_cicli, '') tipo_cicli "&
            + ",isnull(fila_pref, '') fila_pref "&
            + ",isnull(fila_1, 0) fila_1 "&
            + ",isnull(fila_2, 0) fila_2 "&
            + ",isnull(fila_1p, 0) fila_1p "&
            + ",isnull(fila_2p, 0) fila_2p "&
            + ",isnull(dose, 0.0) dose "&
            + ",isnull(dose_min, 0.0) dose_min "&
            + ",isnull(dose_max, 0.0) dose_max "&
            + ",isnull(composizione, '') composizione "&
            + ",isnull(peso, '') peso "&
            + ",isnull(routine, '') routine "&
            + ",isnull(dosimetrie_spec, '') dosimetrie_spec "&
            + ",isnull(note_descr, '') note_descr "&
            + ",isnull(tipo, '') tipo "&
            + ",isnull(magazzino, 0) magazzino "&
            + ",isnull(mis_x, 0) mis_x "&
            + ",isnull(mis_y, 0) mis_y "&
            + ",isnull(mis_z, 0) mis_z "&
            + ",isnull(proposta_tipo_cicli, '') proposta_tipo_cicli "&
            + ",isnull(proposta_fila_pref, '') proposta_fila_pref "&
            + ",isnull(proposta_fila_1, 0) proposta_fila_1 "&
            + ",isnull(proposta_fila_1p, 0) proposta_fila_1p "&
            + ",isnull(proposta_fila_2, 0) proposta_fila_2 "&
            + ",isnull(proposta_fila_2p, 0) proposta_fila_2p "&
            + ",isnull(proposta_data, '') proposta_data "&
            + ",isnull(proposta_utente, '') proposta_utente "&
            + ",isnull(dosim_x_bcode, '') dosim_x_bcode "&
            + ",isnull(dosim_delta_bcode, '') dosim_delta_bcode "&
            + ",isnull(dosim_et_descr, '') dosim_et_descr "&
            + ",isnull(dosetgminmin, 0.0) dosetgminmin "&
            + ",isnull(dosetgminmax, 0.0) dosetgminmax "&
            + ",isnull(dosetgmaxmin, 0.0) dosetgmaxmin "&
            + ",isnull(dosetgmaxmax, 0.0) dosetgmaxmax "&
            + ",isnull(dosetgminfattcorr, 0.0) dosetgminfattcorr "&
            + ",isnull(dosetgmaxfattcorr, 0.0) dosetgmaxfattcorr "&
            + ",isnull(dosetgmintcalc, '') dosetgmintcalc "&
            + ",isnull(dosetgmaxtcalc, '') dosetgmaxtcalc "&
            + ",isnull(dosetgminfattcorr_max, 0.0) dosetgminfattcorr_max "&
            + ",isnull(dosetgmaxfattcorr_max, 0.0) dosetgmaxfattcorr_max "&
            + ",isnull(dosetgmintcalc_max, '') dosetgmintcalc_max "&
            + ",isnull(dosetgmaxtcalc_max, '') dosetgmaxtcalc_max "&
            + ",isnull(pesomax, '') pesomax "&
            + ",isnull(densita, 0.0) densita "&
            + ",isnull(densitamax, 0.0) densitamax "&
            + ",isnull(notestoccaggio, '') notestoccaggio "&
            + ",isnull(id_cliente, 0) id_cliente "&
            + ",isnull(cert_st_dose_min, '') cert_st_dose_min "&
            + ",isnull(cert_st_dose_max, '') cert_st_dose_max "&
            + ",isnull(cert_st_data_ini, '') cert_st_data_ini "&
            + ",isnull(cert_st_data_fin, '') cert_st_data_fin "&
            + ",isnull(notecliente, '') notecliente "&
            + ",isnull(unitwork, 0.0) unitwork "&
            + ",isnull(savedosimeter, 0) savedosimeter "&
            + ",isnull(packingformin_file, '') packingformin_file "&
            + ",isnull(impianto, 0) impianto "&
		+ "  , x_utente " &
		+ "  , nextdescr = LAG(descr) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nexttipo_icli = LAG(tipo_cicli) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextfila_pref = LAG(fila_pref) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextfila_1 = LAG(fila_1) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextfila_2 = LAG(fila_2) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextfila_1p = LAG(fila_1p) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextfila_2p = LAG(fila_2p) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdose = LAG(dose) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdose_min = LAG(dose_min) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdose_max = LAG(dose_max) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextcomposizione = LAG(composizione) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextpeso = LAG(peso) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextroutine = LAG(routine) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosimetrie_spec = LAG(dosimetrie_spec) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextnote_descr = LAG(note_descr) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nexttipo = LAG(tipo) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextmagazzino = LAG(magazzino) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextmis_x = LAG(mis_x) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextmis_y= LAG(mis_y) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextmis_z= LAG(mis_z) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextproposta_tipo_cicli = LAG(proposta_tipo_cicli) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextproposta_fila_pref = LAG(proposta_fila_pref) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextproposta_fila_1 = LAG(proposta_fila_1) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextproposta_fila_1p = LAG(proposta_fila_1p) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextproposta_fila_2 = LAG(proposta_fila_2) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextproposta_fila_2p = LAG(proposta_fila_2p) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextproposta_data = LAG(proposta_data) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextproposta_utente = LAG(proposta_utente) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_x_bcode = LAG(dosim_x_bcode) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_delta_bcode = LAG(dosim_delta_bcode) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_et_descr = LAG(dosim_et_descr) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgminmin = LAG(dosetgminmin) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgminmax = LAG(dosetgminmax) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxmin = LAG(dosetgmaxmin) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxmax = LAG(dosetgmaxmax) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgminfattcorr = LAG(dosetgminfattcorr) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxfattcorr = LAG(dosetgmaxfattcorr) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmintcalc = LAG(dosetgmintcalc) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxtcalc = LAG(dosetgmaxtcalc) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgminfattcorr_max = LAG(dosetgminfattcorr_max) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxfattcorr_max = LAG(dosetgmaxfattcorr_max) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmintcalc_max = LAG(dosetgmintcalc_max) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxtcalc_max = LAG(dosetgmaxtcalc_max) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextpesomax = LAG(pesomax) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdensita= LAG(densita) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdensitamax = LAG(densitamax) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextnotestoccaggio = LAG(notestoccaggio) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextid_cliente = LAG(id_cliente) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextcert_st_dose_min = LAG(cert_st_dose_min) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextcert_st_dose_max = LAG(cert_st_dose_max) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextcert_st_data_ini = LAG(cert_st_data_ini) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextcert_st_data_fin = LAG(cert_st_data_fin) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextnotecliente = LAG(notecliente) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextunitwork = LAG(unitwork) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextsavedosimeter = LAG(savedosimeter) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextpackingformin_file = LAG(packingformin_file) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextimpianto = LAG(impianto) OVER (PARTITION BY impianto ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente = LAG(x_utente) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  FROM sl_ptH " &
		+ " ) " &
		+ ",  T1 " &
		+ "      AS (  " &
		+ " SELECT t.cod_sl_pt " &
		+ "  , coltext			 " &
		+ "  , colname			 " &
		+ "  , value			 " &
		+ "  , max(Attuale) attuale " &
		+ "  , min(x_ValidFrom) x_validfrom " &
		+ " FROM  T  " &
		   + "   CROSS APPLY ( VALUES " &
		   + "    ('descrizione', 'descr' , CAST(descr AS NVARCHAR(4000)), CAST(nextdescr AS NVARCHAR(4000))) " &
		   + "   ,('Giri fila preferita', 'fila_pref' , CAST(fila_pref AS NVARCHAR(4000)), CAST(nextfila_pref AS NVARCHAR(4000))) " &
		   + "   ,('Giri fila 1', 'fila_1' , CAST(fila_1 AS NVARCHAR(4000)), CAST(nextfila_1 AS NVARCHAR(4000))) " &
		   + "   ,('Giri fila 2', 'fila_2' , CAST(fila_2 AS NVARCHAR(4000)), CAST(nextfila_2 AS NVARCHAR(4000))) " &
		   + "   ,('Giri fila 1p', 'fila_1p' , CAST(fila_1p AS NVARCHAR(4000)), CAST(nextfila_1p AS NVARCHAR(4000))) " &
		   + "   ,('Giri fila 2p', 'fila_2p' , CAST(fila_2p AS NVARCHAR(4000)), CAST(nextfila_2p AS NVARCHAR(4000))) " &
		   + "   ,('Dose', 'dose' , CAST(dose AS NVARCHAR(4000)), CAST(nextdose AS NVARCHAR(4000))) " &
		   + "   ,('Dose min', 'dose_min' , CAST(dose_min AS NVARCHAR(4000)), CAST(nextdose_min AS NVARCHAR(4000))) " &
		   + "   ,('Dose max', 'dose_max' , CAST(dose_max AS NVARCHAR(4000)), CAST(nextdose_max AS NVARCHAR(4000))) " &
		   + "   ,('Composizione', 'composizione' , CAST(composizione AS NVARCHAR(4000)), CAST(nextcomposizione AS NVARCHAR(4000))) " &
		   + "   ,('Peso', 'peso' , CAST(peso AS NVARCHAR(4000)), CAST(nextpeso AS NVARCHAR(4000))) " &
		   + "   ,('Routine', 'routine' , CAST(routine AS NVARCHAR(4000)), CAST(nextroutine AS NVARCHAR(4000))) " &
		   + "   ,('Dosimetrie spec.', 'dosimetrie_spec' , CAST(dosimetrie_spec AS NVARCHAR(4000)), CAST(nextdosimetrie_spec AS NVARCHAR(4000))) " &
		   + "   ,('Note', 'note_descr' , CAST(note_descr AS NVARCHAR(4000)), CAST(nextnote_descr AS NVARCHAR(4000))) " &
		   + "   ,('Tipo', 'tipo' , CAST(tipo AS NVARCHAR(4000)), CAST(nexttipo AS NVARCHAR(4000))) " &
		   + "   ,('Magazzino', 'magazzino' , CAST(magazzino AS NVARCHAR(4000)), CAST(nextmagazzino AS NVARCHAR(4000))) " &
		   + "   ,('Mis.x', 'mis_x' , CAST(mis_x AS NVARCHAR(4000)), CAST(nextmis_x AS NVARCHAR(4000))) " &
		   + "   ,('Mis.y', 'mis_y' , CAST(mis_y AS NVARCHAR(4000)), CAST(nextmis_y AS NVARCHAR(4000))) " &
		   + "   ,('Mis.z', 'mis_z' , CAST(mis_z AS NVARCHAR(4000)), CAST(nextmis_z AS NVARCHAR(4000))) " &
		   + "   ,('Proposta tipo cicli', 'proposta_tipo_cicli' , CAST(proposta_tipo_cicli AS NVARCHAR(4000)), CAST(nextproposta_tipo_cicli AS NVARCHAR(4000))) " &
		   + "   ,('Proposta fila pref.', 'proposta_fila_pref' , CAST(proposta_fila_pref AS NVARCHAR(4000)), CAST(nextproposta_fila_pref AS NVARCHAR(4000))) " &
		   + "   ,('Proposta fila_1', 'proposta_fila_1' , CAST(proposta_fila_1 AS NVARCHAR(4000)), CAST(nextproposta_fila_1 AS NVARCHAR(4000))) " &
		   + "   ,('Proposta fila_1p', 'proposta_fila_1p' , CAST(proposta_fila_1p AS NVARCHAR(4000)), CAST(nextproposta_fila_1p AS NVARCHAR(4000))) " &
		   + "   ,('Proposta fila_2', 'proposta_fila_2' , CAST(proposta_fila_2 AS NVARCHAR(4000)), CAST(nextproposta_fila_2 AS NVARCHAR(4000))) " &
		   + "   ,('Proposta fila_2p', 'proposta_fila_2p' , CAST(proposta_fila_2p AS NVARCHAR(4000)), CAST(nextproposta_fila_2p AS NVARCHAR(4000))) " &
		   + "   ,('Proposta il', 'proposta_data' , CAST(proposta_data AS NVARCHAR(4000)), CAST(nextproposta_data AS NVARCHAR(4000))) " &
		   + "   ,('Proposta da', 'proposta_utente' , CAST(proposta_utente AS NVARCHAR(4000)), CAST(nextproposta_utente AS NVARCHAR(4000))) " &
		   + "   ,('Dosim. per barcode', 'dosim_x_bcode' , CAST(dosim_x_bcode AS NVARCHAR(4000)), CAST(nextdosim_x_bcode AS NVARCHAR(4000))) " &
		   + "   ,('Dosim. delta barcode', 'dosim_delta_bcode' , CAST(dosim_delta_bcode AS NVARCHAR(4000)), CAST(nextdosim_delta_bcode AS NVARCHAR(4000))) " &
		   + "   ,('Dosim. descr. etichetta', 'dosim_et_descr' , CAST(dosim_et_descr AS NVARCHAR(4000)), CAST(nextdosim_et_descr AS NVARCHAR(4000))) " &
		   + "   ,('Dose target min. min.', 'dosetgminmin' , CAST(dosetgminmin AS NVARCHAR(4000)), CAST(nextdosetgminmin AS NVARCHAR(4000))) " &
		   + "   ,('Dose target min. max', 'dosetgminmax' , CAST(dosetgminmax AS NVARCHAR(4000)), CAST(nextdosetgminmax AS NVARCHAR(4000))) " &
		   + "   ,('Dose target min. fatt. corr.min.', 'dosetgminfattcorr' , CAST(dosetgminfattcorr AS NVARCHAR(4000)), CAST(nextdosetgminfattcorr AS NVARCHAR(4000))) " &
		   + "   ,('Dose target min. tipo calc.min.', 'dosetgmintcalc' , CAST(dosetgmintcalc AS NVARCHAR(4000)), CAST(nextdosetgmintcalc AS NVARCHAR(4000))) " &
		   + "   ,('Dose target min. fatt. corr.max.', 'dosetgmaxfattcorr' , CAST(dosetgmaxfattcorr AS NVARCHAR(4000)), CAST(nextdosetgmaxfattcorr AS NVARCHAR(4000))) " &
		   + "   ,('Dose target min. tipo calc.max.', 'dosetgmaxtcalc' , CAST(dosetgmaxtcalc AS NVARCHAR(4000)), CAST(nextdosetgmaxtcalc AS NVARCHAR(4000))) " &
		   + "   ,('Dose target max. min.', 'dosetgmaxmin' , CAST(dosetgmaxmin AS NVARCHAR(4000)), CAST(nextdosetgmaxmin AS NVARCHAR(4000))) " &
		   + "   ,('Dose target max. max', 'dosetgmaxmax' , CAST(dosetgmaxmax AS NVARCHAR(4000)), CAST(nextdosetgmaxmax AS NVARCHAR(4000))) " &
		   + "   ,('Dose target max. fatt. corr.min.', 'dosetgminfattcorr_max' , CAST(dosetgminfattcorr_max AS NVARCHAR(4000)), CAST(nextdosetgminfattcorr_max AS NVARCHAR(4000))) " &
		   + "   ,('Dose target max. tipo calc.min.', 'dosetgmintcalc_max' , CAST(dosetgmintcalc_max AS NVARCHAR(4000)), CAST(nextdosetgmintcalc_max AS NVARCHAR(4000))) " &
		   + "   ,('Dose target max. fatt. corr.max.', 'dosetgmaxfattcorr_max' , CAST(dosetgmaxfattcorr_max AS NVARCHAR(4000)), CAST(nextdosetgmaxfattcorr_max AS NVARCHAR(4000))) " &
		   + "   ,('Dose target max. tipo calc.max.', 'dosetgmaxtcalc_max' , CAST(dosetgmaxtcalc_max AS NVARCHAR(4000)), CAST(nextdosetgmaxtcalc_max AS NVARCHAR(4000))) " &
		   + "   ,('Peso max', 'pesomax' , CAST(pesomax AS NVARCHAR(4000)), CAST(nextpesomax AS NVARCHAR(4000))) " &
		   + "   ,('Densità', 'densita' , CAST(densita AS NVARCHAR(4000)), CAST(nextdensita AS NVARCHAR(4000))) " &
		   + "   ,('Densità max', 'densitamax' , CAST(densitamax AS NVARCHAR(4000)), CAST(nextdensitamax AS NVARCHAR(4000))) " &
		   + "   ,('Note stoccaggio', 'notestoccaggio' , CAST(notestoccaggio AS NVARCHAR(4000)), CAST(nextnotestoccaggio AS NVARCHAR(4000))) " &
		   + "   ,('Cliente', 'id_cliente' , CAST(id_cliente AS NVARCHAR(4000)), CAST(nextid_cliente AS NVARCHAR(4000))) " &
		   + "   ,('Att. stampa dose min.', 'cert_st_dose_min' , CAST(cert_st_dose_min AS NVARCHAR(4000)), CAST(nextcert_st_dose_min AS NVARCHAR(4000))) " &
		   + "   ,('Att. stampa dose max', 'cert_st_dose_max' , CAST(cert_st_dose_max AS NVARCHAR(4000)), CAST(nextcert_st_dose_max AS NVARCHAR(4000))) " &
		   + "   ,('Att. stampa data inizio', 'cert_st_data_ini' , CAST(cert_st_data_ini AS NVARCHAR(4000)), CAST(nextcert_st_data_ini AS NVARCHAR(4000))) " &
		   + "   ,('Att. stampa data fine', 'cert_st_data_fin' , CAST(cert_st_data_fin AS NVARCHAR(4000)), CAST(nextcert_st_data_fin AS NVARCHAR(4000))) " &
		   + "   ,('Note cliente', 'notecliente' , CAST(notecliente AS NVARCHAR(4000)), CAST(nextnotecliente AS NVARCHAR(4000))) " &
		   + "   ,('Unità di lavoro', 'unitwork' , CAST(unitwork AS NVARCHAR(4000)), CAST(nextunitwork AS NVARCHAR(4000))) " &
		   + "   ,('Salva dosimetro', 'savedosimeter' , CAST(savedosimeter AS NVARCHAR(4000)), CAST(nextsavedosimeter AS NVARCHAR(4000))) " &
		   + "   ,('Packing form nel file', 'packingformin_file' , CAST(packingformin_file AS NVARCHAR(4000)), CAST(nextpackingformin_file AS NVARCHAR(4000))) " &
		   + "   ,('Impianto (predef.)', 'impianto' , CAST(impianto AS NVARCHAR(4000)), CAST(nextimpianto AS NVARCHAR(4000))) " &
		+ " 	   ) CA( coltext, colname, value, nextvalue)" &
		+ " WHERE  EXISTS(SELECT value" &
		      + " EXCEPT" &
		      + " SELECT nextvalue)" &
		      + " group by cod_sl_pt," &
		      + "  coltext, Colname, value " &
		+ " )" &
  	 	 + " SELECT t1.cod_sl_pt " &
      		+ " , coltext	as colonna" &
      		+ " , colname	as colname" &
      		+ " , value		as valore" &
      		+ " , Attuale	as 'Attuale'" &
      		+ " , x_ValidFrom as 'Valido_dal'" &
      		+ " , (select t2.x_utente from t t2 where t2.x_ValidFrom = t1.x_ValidFrom and t2.cod_sl_pt = t1.cod_sl_pt) as utente " &
		+ " FROM  T1 "
		  
     // + "  where id_meca = 274041          " &
     //   + " ORDER  BY id_meca, " &
     //       + " id_armo, " &
     //       + " Colonna " &
     //       + " Valido_dal " 

	EXECUTE IMMEDIATE "drop VIEW v_temptable_sl_pt " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_temptable_sl_pt): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			
	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_temptable_armo' completata." 
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	 
	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_temptable_sl_pt_dosimpos () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_temptable_sl_pt_dosimpos' 
//===
int k_errore
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception


	SetPointer(kkg.pointer_attesa)

	kuo_exception = create uo_exception
	kst_esito = kuo_exception.inizializza(this.classname())

	k_sql = "create view v_temptable_sl_pt_dosimpos  " &
	  + " as " &
		+ " WITH T " &
		+ " AS ( " & 
		+ "SELECT " &                                                                                                 
		+ "  '*' as Attuale " & 
		+ " ,x_ValidFrom  " & 
		+ " ,x_ValidTo " & 
            + " ,id_sl_pt_dosimpos " &
            + " ,cod_sl_pt " &
            + " ,isnull(impianto, 0) impianto "&
            + " ,isnull(seq, 0) seq "&
            + " ,isnull(id_dosimpos, 0) id_dosimpos "&
            + " ,isnull(dosim_flg_tipo_dose, '') dosim_flg_tipo_dose "&
            + " ,isnull(descr, '') descr "&
            + " ,isnull(descr1, '') descr1 "&
            + " ,isnull(dosim_tipo, '') dosim_tipo "&
            + " ,isnull(posxcm, 0) posxcm "&
            + " ,isnull(posycm, 0) posycm "&
            + " ,isnull(poszcm, 0) poszcm "&
		+ " ,x_utente " &
		+ " ,nextimpianto = LAG(impianto) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " ,nextseq = LAG(seq) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " ,nextid_dosimpos = LAG(id_dosimpos) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " ,nextdosim_flg_tipo_dose = LAG(dosim_flg_tipo_dose) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " ,nextdescr = LAG(descr) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " ,nextdescr1 = LAG(descr1) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " ,nextdosim_tipo = LAG(dosim_tipo) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " ,nextposxcm = LAG(posxcm) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " ,nextposycm = LAG(posycm) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " ,nextposzcm = LAG(poszcm) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " ,nextx_utente = LAG(x_utente) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " FROM sl_pt_dosimpos " &
		+ " union all " &
		+ "SELECT " &                                                                                                 
		+ " ' ' as Attuale " &
		+ " ,x_ValidFrom  " &
		+ " ,x_ValidTo " &
            + " ,id_sl_pt_dosimpos " &
            + " ,cod_sl_pt " &
            + " ,isnull(impianto, 0) impianto "&
            + " ,isnull(seq, 0) seq "&
            + " ,isnull(id_dosimpos, 0) id_dosimpos "&
            + " ,isnull(dosim_flg_tipo_dose, '') dosim_flg_tipo_dose "&
            + " ,isnull(descr, '') descr "&
            + " ,isnull(descr1, '') descr1 "&
            + " ,isnull(dosim_tipo, '') dosim_tipo "&
            + " ,isnull(posxcm, 0) posxcm "&
            + " ,isnull(posycm, 0) posycm "&
            + " ,isnull(poszcm, 0) poszcm "&
		+ " ,x_utente " &
		+ " ,nextimpianto = LAG(impianto) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " ,nextseq = LAG(seq) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " ,nextid_dosimpos = LAG(id_dosimpos) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " ,nextdosim_flg_tipo_dose = LAG(dosim_flg_tipo_dose) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " ,nextdescr = LAG(descr) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " ,nextdescr1 = LAG(descr1) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " ,nextdosim_tipo = LAG(dosim_tipo) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " ,nextposxcm = LAG(posxcm) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " ,nextposycm = LAG(posycm) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " ,nextposzcm = LAG(poszcm) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " ,nextx_utente = LAG(x_utente) OVER (PARTITION BY id_sl_pt_dosimpos ORDER BY x_ValidFrom) " &
		+ " FROM sl_pt_dosimposH " &
		+ " ) " &
		+ ",  T1 " &
		+ "      AS (  " &
		+ " SELECT id_sl_pt_dosimpos " &
      + "  , cod_sl_pt " &
      + "  , impianto " &
      + "  , seq " &
		+ "  , coltext			 " &
		+ "  , colname			 " &
		+ "  , value			 " &
		+ "  , max(Attuale) attuale " &
		+ "  , min(x_ValidFrom) x_validfrom " &
		+ " FROM  T  " &
		   + " CROSS APPLY ( VALUES " &
		   + "  ('Posizione id', 'id_dosimpos' , CAST(id_dosimpos AS NVARCHAR(4000)), CAST(nextid_dosimpos AS NVARCHAR(4000))) " &
		   + "  ,('Dosimetro Tipo Dose  (M=min, X=max)', 'dosim_flg_tipo_dose' , CAST(dosim_flg_tipo_dose AS NVARCHAR(4000)), CAST(nextdosim_flg_tipo_dose AS NVARCHAR(4000))) " &
		   + "  ,('Descrizione 1', 'descr' , CAST(descr AS NVARCHAR(4000)), CAST(nextdescr AS NVARCHAR(4000))) " &
		   + "  ,('Descrizione 2', 'descr1' , CAST(descr1 AS NVARCHAR(4000)), CAST(nextdescr1 AS NVARCHAR(4000))) " &
		   + "  ,('Dosimetro Tipo (R=red, A=amber)', 'dosim_tipo' , CAST(dosim_tipo AS NVARCHAR(4000)), CAST(nextdosim_tipo AS NVARCHAR(4000))) " &
		   + "  ,('Pos.x (cm)', 'posxcm' , CAST(posxcm AS NVARCHAR(4000)), CAST(nextposxcm AS NVARCHAR(4000))) " &
		   + "  ,('Pos.y (cm)', 'posycm' , CAST(posycm AS NVARCHAR(4000)), CAST(nextposycm AS NVARCHAR(4000))) " &
		   + "  ,('Pos.z (cm)', 'poszcm' , CAST(poszcm AS NVARCHAR(4000)), CAST(nextposzcm AS NVARCHAR(4000))) " &
		+ " ) CA( coltext, colname, value, nextvalue)" &
		+ " WHERE  EXISTS(SELECT value" &
		      + " EXCEPT" &
		      + " SELECT nextvalue)" &
		      + " group by cod_sl_pt, impianto, seq, id_sl_pt_dosimpos," &
		       + " coltext, Colname, value " &
		+ " )" &
  	 	 + " SELECT id_sl_pt_dosimpos " &
            + " ,cod_sl_pt " &
		      + " ,impianto " &
            + " ,seq " &
      		+ " ,coltext	as colonna" &
      		+ " ,colname	as colname" &
      		+ " ,value		as valore" &
      		+ " ,Attuale	as 'Attuale'" &
      		+ " ,x_ValidFrom as 'Valido_dal'" &
      		+ " ,(select distinct (t2.x_utente) from t t2 where t2.x_ValidFrom = t1.x_ValidFrom and t2.id_sl_pt_dosimpos = t1.id_sl_pt_dosimpos) as utente " &
		+ " FROM  T1 " 
				
     // + "  where id_meca = 274041          " &
     //   + " ORDER  BY id_meca, " &
     //       + " id_armo, " &
     //       + " Colonna " &
     //       + " Valido_dal " 

	EXECUTE IMMEDIATE "drop VIEW v_temptable_sl_pt_dosimpos " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_temptable_sl_pt_dosimpos): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			
	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_temptable_sl_pt_dosimpos' completata." 
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	 
	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_temptable_sc_cf () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_temptable_sc_cf' 
//===
int k_errore
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception



//=== Puntatore Cursore da attesa..... 
	SetPointer(kkg.pointer_attesa)

	kuo_exception = create uo_exception
	kst_esito = kuo_exception.inizializza(this.classname())

	k_sql = "create view v_temptable_sc_cf  " &
	  + " as " &
		+ " WITH T " &
		+ "      AS ( " & 
		+ "SELECT " &                                                                                                 
		+ "  '*' as Attuale " & 
		+ " ,x_ValidFrom  " & 
		+ " ,x_ValidTo " & 
            + " ,codice " &
            + " ,isnull(data, '') data "&
            + " ,isnull(data_scad, '') data_scad "&
            + " ,isnull(descr, '') descr "&
            + " ,isnull(cod_cli, 0) cod_cli "&
            + " ,isnull(m_r_f, '') m_r_f "&
            + " ,isnull(attivo, '') attivo "&
            + " ,isnull(sc_cv, '') sc_cv "&
            + " ,isnull(sd_md, '') sd_md "&
            + " ,isnull(sl_pt, '') sl_pt "&
            + " ,isnull(magazzino, 0) magazzino "&
		+ " ,x_utente " &
		+ " ,nextdata = LAG(data) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextdata_scad = LAG(data_scad) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextdescr = LAG(descr) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextcod_cli = LAG(cod_cli) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextm_r_f = LAG(m_r_f) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextattivo = LAG(attivo) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextsc_cv = LAG(sc_cv) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextsd_md = LAG(sd_md) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextsl_pt = LAG(sl_pt) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextmagazzino = LAG(magazzino) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextx_utente = LAG(x_utente) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " FROM sc_cf " &
		+ " union all " &
		+ "SELECT " &                                                                                                 
		+ " ' ' as Attuale " &
		+ " ,x_ValidFrom  " &
		+ " ,x_ValidTo " &
            + " ,codice " &
            + " ,isnull(data, '') data "&
            + " ,isnull(data_scad, '') data_scad "&
            + " ,isnull(descr, '') descr "&
            + " ,isnull(cod_cli, 0) cod_cli "&
            + " ,isnull(m_r_f, '') m_r_f "&
            + " ,isnull(attivo, '') attivo "&
            + " ,isnull(sc_cv, '') sc_cv "&
            + " ,isnull(sd_md, '') sd_md "&
            + " ,isnull(sl_pt, '') sl_pt "&
            + " ,isnull(magazzino, 0) magazzino "&
		+ " ,x_utente " &
		+ " ,nextdata = LAG(data) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextdata_scad = LAG(data_scad) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextdescr = LAG(descr) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextcod_cli = LAG(cod_cli) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextm_r_f = LAG(m_r_f) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextattivo = LAG(attivo) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextsc_cv = LAG(sc_cv) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextsd_md = LAG(sd_md) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextsl_pt = LAG(sl_pt) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextmagazzino = LAG(magazzino) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextx_utente = LAG(x_utente) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " FROM sc_cfH " &
		+ " ) " &
		+ ",  T1 " &
		+ "      AS (  " &
		+ " SELECT codice " &
		+ "  , coltext			 " &
		+ "  , colname			 " &
		+ "  , value			 " &
		+ "  , max(Attuale) attuale " &
		+ "  , min(x_ValidFrom) x_validfrom " &
		+ " FROM  T  " &
		   + " CROSS APPLY ( VALUES " &
		   + "   ('Valido dal', 'data' , CAST(data AS NVARCHAR(4000)), CAST(nextdata AS NVARCHAR(4000))) " &
		   + "  ,('Valido fino al', 'data_scad' , CAST(data_scad AS NVARCHAR(4000)), CAST(nextdata_scad AS NVARCHAR(4000))) " &
		   + "  ,('Descrizione', 'descr' , CAST(descr AS NVARCHAR(4000)), CAST(nextdescr AS NVARCHAR(4000))) " &
		   + "  ,('Cod cliente', 'cod_cli' , CAST(cod_cli AS NVARCHAR(4000)), CAST(nextcod_cli AS NVARCHAR(4000))) " &
		   + "  ,('Mand./Ric./Clie.', 'm_r_f' , CAST(m_r_f AS NVARCHAR(4000)), CAST(nextm_r_f AS NVARCHAR(4000))) " &
		   + "  ,('Attivo', 'attivo' , CAST(attivo AS NVARCHAR(4000)), CAST(nextattivo AS NVARCHAR(4000))) " &
		   + "  ,('Cod. sc-cv', 'sc_cv' , CAST(sc_cv AS NVARCHAR(4000)), CAST(nextsc_cv AS NVARCHAR(4000))) " &
		   + "  ,('Cod. sd-md', 'sd_md' , CAST(sd_md AS NVARCHAR(4000)), CAST(nextsd_md AS NVARCHAR(4000))) " &
		   + "  ,('Piano di Trattamento', 'sl_pt' , CAST(sl_pt AS NVARCHAR(4000)), CAST(nextsl_pt AS NVARCHAR(4000))) " &
		   + "  ,('Magazzino', 'magazzino' , CAST(magazzino AS NVARCHAR(4000)), CAST(nextmagazzino AS NVARCHAR(4000))) " &
		+ " 	   ) CA( coltext, colname, value, nextvalue)" &
		+ " WHERE  EXISTS(SELECT value" &
		      + " EXCEPT" &
		      + " SELECT nextvalue)" &
		      + " group by codice," &
		       + " coltext, Colname, value " &
		+ " )" &
  	 	 + " SELECT codice " &
      		+ " ,coltext	as colonna" &
      		+ " ,colname	as colname" &
      		+ " ,value		as valore" &
      		+ " ,Attuale	as 'Attuale'" &
      		+ " ,x_ValidFrom as 'Valido_dal'" &
      		+ " ,(select t2.x_utente from t t2 where t2.x_ValidFrom = t1.x_ValidFrom and t2.codice = t1.codice) as utente " &
		+ " FROM  T1 " 
		  
     // + "  where id_meca = 274041          " &
     //   + " ORDER  BY id_meca, " &
     //       + " id_armo, " &
     //       + " Colonna " &
     //       + " Valido_dal " 

	EXECUTE IMMEDIATE "drop VIEW v_temptable_sc_cf " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_temptable_sc_cf): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			
	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_temptable_sc_cf' completata." 
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	 
	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_temptable_contratti () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_temptable_contratti' 
//===
int k_errore
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception


	SetPointer(kkg.pointer_attesa)

	kuo_exception = create uo_exception
	kst_esito = kuo_exception.inizializza(this.classname())

	k_sql = "create view v_temptable_contratti  " &
	  + " as " &
		+ " WITH T " &
		+ "      AS ( " & 
		+ "SELECT " &                                                                                                 
		+ "  '*' as Attuale " & 
		+ " ,x_ValidFrom  " & 
		+ " ,x_ValidTo " & 
            + " ,codice " &
            + " ,isnull(contratto_co_data_ins, '') contratto_co_data_ins "&
            + " ,isnull(id_contratto_co, 0) id_contratto_co "&
            + " ,isnull(id_contratto_dp, 0) id_contratto_dp "&
            + " ,isnull(id_contratto_rd, 0) id_contratto_rd "&
            + " ,isnull(mc_co, '') mc_co "&
            + " ,isnull(sc_cf, '') sc_cf "&
            + " ,isnull(sl_pt, '') sl_pt "&
            + " ,isnull(data, '') data "&
            + " ,isnull(data_scad, '') data_scad "&
            + " ,isnull(tipo, '') tipo "&
            + " ,isnull(cod_cli, 0) cod_cli "&
            + " ,isnull(descr, '') descr "&
            + " ,isnull(cert_st_dose_min, '') cert_st_dose_min "&
            + " ,isnull(cert_st_dose_max, '') cert_st_dose_max "&
            + " ,isnull(cert_st_data_ini, '') cert_st_data_ini "&
            + " ,isnull(cert_st_data_fin, '') cert_st_data_fin "&
            + " ,isnull(cert_st_dati_bolla_in, '') cert_st_dati_bolla_in "&
            + " ,isnull(flag_bolla_in_dett, '') flag_bolla_in_dett "&
            + " ,isnull(et_bcode_st_dt_rif, '') et_bcode_st_dt_rif "&
            + " ,isnull(et_bcode_note_old, '') et_bcode_note_old "&
            + " ,isnull(et_bcode_note, '') et_bcode_note "&
            + " ,isnull(costi_accessori, '') costi_accessori "&
            + " ,isnull(id_meca_causale, 0) id_meca_causale "&
            + " ,isnull(et_dosimetro, 0) et_dosimetro "&
            + " ,isnull(flg_fatt_dopo_valid, '') flg_fatt_dopo_valid "&
            + " ,isnull(flg_acconto, '') flg_acconto "&
            + " ,isnull(dosim_x_bcode, 0) dosim_x_bcode "&
            + " ,isnull(dosim_delta_bcode, 0) dosim_delta_bcode "&
            + " ,isnull(flg_deperibile, '') flg_deperibile "&
		+ " ,x_utente " &
		+ " ,nextcontratto_co_data_ins = LAG(contratto_co_data_ins) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextid_contratto_co = LAG(id_contratto_co) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextid_contratto_dp = LAG(id_contratto_dp) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextid_contratto_rd = LAG(id_contratto_rd) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextmc_co = LAG(mc_co) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextsc_cf = LAG(sc_cf) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextsl_pt = LAG(sl_pt) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextdata = LAG(data) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextdata_scad = LAG(data_scad) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nexttipo = LAG(tipo) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextcod_cli = LAG(cod_cli) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextdescr = LAG(descr) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextcert_st_dose_min = LAG(cert_st_dose_min) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextcert_st_dose_max = LAG(cert_st_dose_max) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextcert_st_data_ini = LAG(cert_st_data_ini) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextcert_st_data_fin = LAG(cert_st_data_fin) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextcert_st_dati_bolla_in = LAG(cert_st_dati_bolla_in) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextflag_bolla_in_dett = LAG(flag_bolla_in_dett) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextet_bcode_st_dt_rif = LAG(et_bcode_st_dt_rif) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextet_bcode_note_old = LAG(et_bcode_note_old) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextet_bcode_note = LAG(et_bcode_note) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextcosti_accessori = LAG(costi_accessori) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextid_meca_causale = LAG(id_meca_causale) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextet_dosimetro = LAG(et_dosimetro) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextflg_fatt_dopo_valid = LAG(flg_fatt_dopo_valid) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextflg_acconto = LAG(flg_acconto) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextdosim_x_bcode = LAG(dosim_x_bcode) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextdosim_delta_bcode = LAG(dosim_delta_bcode) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextflg_deperibile = LAG(flg_deperibile) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextx_utente = LAG(x_utente) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " FROM contratti " &
		+ " union all " &
		+ "SELECT " &                                                                                                 
		+ " ' ' as Attuale " &
		+ " ,x_ValidFrom  " &
		+ " ,x_ValidTo " &
            + " ,codice " &
            + " ,isnull(contratto_co_data_ins, '') contratto_co_data_ins "&
            + " ,isnull(id_contratto_co, 0) id_contratto_co "&
            + " ,isnull(id_contratto_dp, 0) id_contratto_dp "&
            + " ,isnull(id_contratto_rd, 0) id_contratto_rd "&
            + " ,isnull(mc_co, '') mc_co "&
            + " ,isnull(sc_cf, '') sc_cf "&
            + " ,isnull(sl_pt, '') sl_pt "&
            + " ,isnull(data, '') data "&
            + " ,isnull(data_scad, '') data_scad "&
            + " ,isnull(tipo, '') tipo "&
            + " ,isnull(cod_cli, 0) cod_cli "&
            + " ,isnull(descr, '') descr "&
            + " ,isnull(cert_st_dose_min, '') cert_st_dose_min "&
            + " ,isnull(cert_st_dose_max, '') cert_st_dose_max "&
            + " ,isnull(cert_st_data_ini, '') cert_st_data_ini "&
            + " ,isnull(cert_st_data_fin, '') cert_st_data_fin "&
            + " ,isnull(cert_st_dati_bolla_in, '') cert_st_dati_bolla_in "&
            + " ,isnull(flag_bolla_in_dett, '') flag_bolla_in_dett "&
            + " ,isnull(et_bcode_st_dt_rif, '') et_bcode_st_dt_rif "&
            + " ,isnull(et_bcode_note_old, '') et_bcode_note_old "&
            + " ,isnull(et_bcode_note, '') et_bcode_note "&
            + " ,isnull(costi_accessori, '') costi_accessori "&
            + " ,isnull(id_meca_causale, 0) id_meca_causale "&
            + " ,isnull(et_dosimetro, 0) et_dosimetro "&
            + " ,isnull(flg_fatt_dopo_valid, '') flg_fatt_dopo_valid "&
            + " ,isnull(flg_acconto, '') flg_acconto "&
            + " ,isnull(dosim_x_bcode, 0) dosim_x_bcode "&
            + " ,isnull(dosim_delta_bcode, 0) dosim_delta_bcode "&
            + " ,isnull(flg_deperibile, '') flg_deperibile "&
		+ " ,x_utente " &
		+ " ,nextcontratto_co_data_ins = LAG(contratto_co_data_ins) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextid_contratto_co = LAG(id_contratto_co) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextid_contratto_dp = LAG(id_contratto_dp) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextid_contratto_rd = LAG(id_contratto_rd) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextmc_co = LAG(mc_co) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextsc_cf = LAG(sc_cf) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextsl_pt = LAG(sl_pt) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextdata = LAG(data) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextdata_scad = LAG(data_scad) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nexttipo = LAG(tipo) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextcod_cli = LAG(cod_cli) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextdescr = LAG(descr) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextcert_st_dose_min = LAG(cert_st_dose_min) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextcert_st_dose_max = LAG(cert_st_dose_max) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextcert_st_data_ini = LAG(cert_st_data_ini) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextcert_st_data_fin = LAG(cert_st_data_fin) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextcert_st_dati_bolla_in = LAG(cert_st_dati_bolla_in) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextflag_bolla_in_dett = LAG(flag_bolla_in_dett) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextet_bcode_st_dt_rif = LAG(et_bcode_st_dt_rif) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextet_bcode_note_old = LAG(et_bcode_note_old) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextet_bcode_note = LAG(et_bcode_note) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextcosti_accessori = LAG(costi_accessori) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextid_meca_causale = LAG(id_meca_causale) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextet_dosimetro = LAG(et_dosimetro) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextflg_fatt_dopo_valid = LAG(flg_fatt_dopo_valid) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextflg_acconto = LAG(flg_acconto) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextdosim_x_bcode = LAG(dosim_x_bcode) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextdosim_delta_bcode = LAG(dosim_delta_bcode) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextflg_deperibile = LAG(flg_deperibile) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " ,nextx_utente = LAG(x_utente) OVER (PARTITION BY codice ORDER BY x_ValidFrom) " &
		+ " FROM contrattiH " &
		+ " ) " &
		+ ",  T1 " &
		+ "      AS (  " &
		+ " SELECT codice " &
		+ "  , coltext			 " &
		+ "  , colname			 " &
		+ "  , value			 " &
		+ "  , max(Attuale) attuale " &
		+ "  , min(x_ValidFrom) x_validfrom " &
		+ " FROM  T  " &
		   + " CROSS APPLY ( VALUES " &
		   + "   ('Data inserimento', 'contratto_co_data_ins' , CAST(contratto_co_data_ins AS NVARCHAR(4000)), CAST(nextcontratto_co_data_ins AS NVARCHAR(4000))) " &
		   + "  ,('id contratto co', 'id_contratto_co' , CAST(id_contratto_co AS NVARCHAR(4000)), CAST(nextid_contratto_co AS NVARCHAR(4000))) " &
		   + "  ,('id contratto dp', 'id_contratto_dp' , CAST(id_contratto_dp AS NVARCHAR(4000)), CAST(nextid_contratto_dp AS NVARCHAR(4000))) " &
		   + "  ,('id contratto rd', 'id_contratto_rd' , CAST(id_contratto_rd AS NVARCHAR(4000)), CAST(nextid_contratto_rd AS NVARCHAR(4000))) " &
		   + "  ,('Comferma Ordine', 'mc_co' , CAST(mc_co AS NVARCHAR(4000)), CAST(nextmc_co AS NVARCHAR(4000))) " &
		   + "  ,('Capitolato di Fornitura', 'sc_cf' , CAST(sc_cf AS NVARCHAR(4000)), CAST(nextsc_cf AS NVARCHAR(4000))) " &
		   + "  ,('Piano di Trattamento', 'sl_pt' , CAST(sl_pt AS NVARCHAR(4000)), CAST(nextsl_pt AS NVARCHAR(4000))) " &
		   + "  ,('Data di inizio', 'data' , CAST(data AS NVARCHAR(4000)), CAST(nextdata AS NVARCHAR(4000))) " &
		   + "  ,('Data di scadenza', 'data_scad' , CAST(data_scad AS NVARCHAR(4000)), CAST(nextdata_scad AS NVARCHAR(4000))) " &
		   + "  ,('Tipo', 'tipo' , CAST(tipo AS NVARCHAR(4000)), CAST(nexttipo AS NVARCHAR(4000))) " &
		   + "  ,('Codice Cliente', 'cod_cli' , CAST(cod_cli AS NVARCHAR(4000)), CAST(nextcod_cli AS NVARCHAR(4000))) " &
		   + "  ,('Descrizione', 'descr' , CAST(descr AS NVARCHAR(4000)), CAST(nextdescr AS NVARCHAR(4000))) " &
		   + "  ,('Att. in stampa dose min.', 'cert_st_dose_min' , CAST(cert_st_dose_min AS NVARCHAR(4000)), CAST(nextcert_st_dose_min AS NVARCHAR(4000))) " &
		   + "  ,('Att. in stampa dose max', 'cert_st_dose_max' , CAST(cert_st_dose_max AS NVARCHAR(4000)), CAST(nextcert_st_dose_max AS NVARCHAR(4000))) " &
		   + "  ,('Att. in stampa data inizio lav.', 'cert_st_data_ini' , CAST(cert_st_data_ini AS NVARCHAR(4000)), CAST(nextcert_st_data_ini AS NVARCHAR(4000))) " &
		   + "  ,('Att. in stampa data fine lav.', 'cert_st_data_fin' , CAST(cert_st_data_fin AS NVARCHAR(4000)), CAST(nextcert_st_data_fin AS NVARCHAR(4000))) " &
		   + "  ,('Att. in stampa dati bolla entrata merce', 'cert_st_dati_bolla_in' , CAST(cert_st_dati_bolla_in AS NVARCHAR(4000)), CAST(nextcert_st_dati_bolla_in AS NVARCHAR(4000))) " &
		   + "  ,('Flag bolla in dettaglio', 'flag_bolla_in_dett' , CAST(flag_bolla_in_dett AS NVARCHAR(4000)), CAST(nextflag_bolla_in_dett AS NVARCHAR(4000))) " &
		   + "  ,('Etich. barcode in stampa data Lotto', 'et_bcode_st_dt_rif' , CAST(et_bcode_st_dt_rif AS NVARCHAR(4000)), CAST(nextet_bcode_st_dt_rif AS NVARCHAR(4000))) " &
		   + "  ,('Etich. barcode in stampa le note', 'et_bcode_note' , CAST(et_bcode_note AS NVARCHAR(4000)), CAST(nextet_bcode_note AS NVARCHAR(4000))) " &
		   + "  ,('Costi accessori', 'costi_accessori' , CAST(costi_accessori AS NVARCHAR(4000)), CAST(nextcosti_accessori AS NVARCHAR(4000))) " &
		   + "  ,('id causale di entrata', 'id_meca_causale' , CAST(id_meca_causale AS NVARCHAR(4000)), CAST(nextid_meca_causale AS NVARCHAR(4000))) " &
		   + "  ,('Etich. Dosimetro', 'et_dosimetro' , CAST(et_dosimetro AS NVARCHAR(4000)), CAST(nextet_dosimetro AS NVARCHAR(4000))) " &
		   + "  ,('Dosim. x bcode num.', 'dosim_x_bcode' , CAST(dosim_x_bcode AS NVARCHAR(4000)), CAST(nextdosim_x_bcode AS NVARCHAR(4000))) " &
		   + "  ,('Dosim. delta tra barcode', 'dosim_delta_bcode' , CAST(dosim_delta_bcode AS NVARCHAR(4000)), CAST(nextdosim_delta_bcode AS NVARCHAR(4000))) " &
		   + "  ,('Flg Deperibile', 'flg_deperibile' , CAST(flg_deperibile AS NVARCHAR(4000)), CAST(nextflg_deperibile AS NVARCHAR(4000))) " &
		+ " 	   ) CA( coltext, colname, value, nextvalue)" &
		+ " WHERE  EXISTS(SELECT value" &
		      + " EXCEPT" &
		      + " SELECT nextvalue)" &
		      + " group by codice," &
		       + " coltext, Colname, value " &
		+ " )" &
  	 	 + " SELECT codice " &
      		+ " ,coltext	as colonna" &
      		+ " ,colname	as colname" &
      		+ " ,value		as valore" &
      		+ " ,Attuale	as 'Attuale'" &
      		+ " ,x_ValidFrom as 'Valido_dal'" &
      		+ " ,(select t2.x_utente from t t2 where t2.x_ValidFrom = t1.x_ValidFrom and t2.codice = t1.codice) as utente " &
		+ " FROM  T1 " 
		  
     // + "  where id_meca = 274041          " &
     //   + " ORDER  BY id_meca, " &
     //       + " id_armo, " &
     //       + " Colonna " &
     //       + " Valido_dal " 

	EXECUTE IMMEDIATE "drop VIEW v_temptable_contratti " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_temptable_contratti): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			
	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_temptable_contratti' completata." 
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	 
	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_temptable_listino () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_temptable_listino' 
//===
int k_errore
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception


	SetPointer(kkg.pointer_attesa)

	kuo_exception = create uo_exception
	kst_esito = kuo_exception.inizializza(this.classname())

	k_sql = "create view v_temptable_listino  " &
	  + " as " &
		+ " WITH T " &
		+ "      AS ( " & 
		+ "SELECT " &                                                                                                 
		+ "  '*' as Attuale " & 
		+ " ,x_ValidFrom  " & 
		+ " ,x_ValidTo " & 
            + " ,id " &
            + " ,isnull(cod_cli, 0) cod_cli "&
            + " ,isnull(cod_art, 0) cod_art "&
            + " ,isnull(dose, 0.0) dose "&
            + " ,isnull(attiva_listino_pregruppi, '') attiva_listino_pregruppi "&
            + " ,isnull(prezzo, 0.0) prezzo "&
            + " ,isnull(id_cond_fatt_1, 0) id_cond_fatt_1 "&
            + " ,isnull(prezzo_2, 0.0) prezzo_2 "&
            + " ,isnull(id_cond_fatt_2, 0) id_cond_fatt_2 "&
            + " ,isnull(prezzo_3, 0.0) prezzo_3 "&
            + " ,isnull(id_cond_fatt_3, 0) id_cond_fatt_3 "&
            + " ,isnull(tipo, '') tipo "&
            + " ,isnull(campione, '') campione "&
            + " ,isnull(mis_x, 0) mis_x "&
            + " ,isnull(mis_y, 0) mis_y "&
            + " ,isnull(mis_z, 0) mis_z "&
            + " ,isnull(occup_ped, 0) occup_ped "&
            + " ,isnull(travaso, '') travaso "&
            + " ,isnull(peso_kg, 0) peso_kg "&
            + " ,isnull(magazzino, 0) magazzino "&
            + " ,isnull(m_cubi_f, 0.0) m_cubi_f "&
            + " ,isnull(attivo, '') attivo "&
            + " ,isnull(contratto, 0) contratto "&
            + " ,isnull(contratto_co_data_ins, '') contratto_co_data_ins "&
            + " ,isnull(id_contratto_co, 0) id_contratto_co "&
            + " ,isnull(id_parent, 0) id_parent "&
            + " ,isnull(e1litm, '') e1litm "&
            + " ,isnull(dt_start, '') dt_start "&
            + " ,isnull(dt_end, '') dt_end "&
		+ " ,x_utente " &
		+ " ,nextcod_cli = LAG(cod_cli) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextcod_art = LAG(cod_art) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextdose = LAG(dose) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextattiva_listino_pregruppi = LAG(attiva_listino_pregruppi) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextprezzo = LAG(prezzo) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextid_cond_fatt_1 = LAG(id_cond_fatt_1) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextprezzo_2 = LAG(prezzo_2) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextid_cond_fatt_2 = LAG(id_cond_fatt_2) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextprezzo_3 = LAG(prezzo_3) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextid_cond_fatt_3 = LAG(id_cond_fatt_3) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nexttipo = LAG(tipo) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextcampione = LAG(campione) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextmis_x = LAG(mis_x) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextmis_y = LAG(mis_y) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextmis_z = LAG(mis_z) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextoccup_ped = LAG(occup_ped) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nexttravaso = LAG(travaso) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextpeso_kg = LAG(peso_kg) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextmagazzino = LAG(magazzino) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextm_cubi_f = LAG(m_cubi_f) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextattivo = LAG(attivo) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextcontratto = LAG(contratto) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextcontratto_co_data_ins = LAG(contratto_co_data_ins) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextid_contratto_co = LAG(id_contratto_co) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextid_parent = LAG(id_parent) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nexte1litm = LAG(e1litm) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextdt_start = LAG(dt_start) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextdt_end = LAG(dt_end) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextx_utente = LAG(x_utente) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " FROM listino " &
		+ " union all " &
		+ "SELECT " &                                                                                                 
		+ " ' ' as Attuale " &
		+ " ,x_ValidFrom  " &
		+ " ,x_ValidTo " &
            + " ,id " &
            + " ,isnull(cod_cli, 0) cod_cli "&
            + " ,isnull(cod_art, 0) cod_art "&
            + " ,isnull(dose, 0.0) dose "&
            + " ,isnull(attiva_listino_pregruppi, '') attiva_listino_pregruppi "&
            + " ,isnull(prezzo, 0.0) prezzo "&
            + " ,isnull(id_cond_fatt_1, 0) id_cond_fatt_1 "&
            + " ,isnull(prezzo_2, 0.0) prezzo_2 "&
            + " ,isnull(id_cond_fatt_2, 0) id_cond_fatt_2 "&
            + " ,isnull(prezzo_3, 0.0) prezzo_3 "&
            + " ,isnull(id_cond_fatt_3, 0) id_cond_fatt_3 "&
            + " ,isnull(tipo, '') tipo "&
            + " ,isnull(campione, '') campione "&
            + " ,isnull(mis_x, 0) mis_x "&
            + " ,isnull(mis_y, 0) mis_y "&
            + " ,isnull(mis_z, 0) mis_z "&
            + " ,isnull(occup_ped, 0) occup_ped "&
            + " ,isnull(travaso, '') travaso "&
            + " ,isnull(peso_kg, 0) peso_kg "&
            + " ,isnull(magazzino, 0) magazzino "&
            + " ,isnull(m_cubi_f, 0.0) m_cubi_f "&
            + " ,isnull(attivo, '') attivo "&
            + " ,isnull(contratto, 0) contratto "&
            + " ,isnull(contratto_co_data_ins, '') contratto_co_data_ins "&
            + " ,isnull(id_contratto_co, 0) id_contratto_co "&
            + " ,isnull(id_parent, 0) id_parent "&
            + " ,isnull(e1litm, '') e1litm "&
            + " ,isnull(dt_start, '') dt_start "&
            + " ,isnull(dt_end, '') dt_end "&
		+ " ,x_utente " &
		+ " ,nextcod_cli = LAG(cod_cli) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextcod_art = LAG(cod_art) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextdose = LAG(dose) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextattiva_listino_pregruppi = LAG(attiva_listino_pregruppi) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextprezzo = LAG(prezzo) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextid_cond_fatt_1 = LAG(id_cond_fatt_1) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextprezzo_2 = LAG(prezzo_2) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextid_cond_fatt_2 = LAG(id_cond_fatt_2) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextprezzo_3 = LAG(prezzo_3) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextid_cond_fatt_3 = LAG(id_cond_fatt_3) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nexttipo = LAG(tipo) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextcampione = LAG(campione) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextmis_x = LAG(mis_x) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextmis_y = LAG(mis_y) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextmis_z = LAG(mis_z) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextoccup_ped = LAG(occup_ped) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nexttravaso = LAG(travaso) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextpeso_kg = LAG(peso_kg) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextmagazzino = LAG(magazzino) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextm_cubi_f = LAG(m_cubi_f) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextattivo = LAG(attivo) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextcontratto = LAG(contratto) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextcontratto_co_data_ins = LAG(contratto_co_data_ins) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextid_contratto_co = LAG(id_contratto_co) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextid_parent = LAG(id_parent) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nexte1litm = LAG(e1litm) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextdt_start = LAG(dt_start) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextdt_end = LAG(dt_end) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " ,nextx_utente = LAG(x_utente) OVER (PARTITION BY id ORDER BY x_ValidFrom) " &
		+ " FROM listinoH " &
		+ " ) " &
		+ ",  T1 " &
		+ "      AS (  " &
		+ " SELECT id " &
		+ "  , coltext			 " &
		+ "  , colname			 " &
		+ "  , value			 " &
		+ "  , max(Attuale) attuale " &
		+ "  , min(x_ValidFrom) x_validfrom " &
		+ " FROM  T  " &
		   + " CROSS APPLY ( VALUES " &
		   + "   ('Codice cliente', 'cod_cli' , CAST(cod_cli AS NVARCHAR(4000)), CAST(nextcod_cli AS NVARCHAR(4000))) " &
		   + "  ,('Codice articolo', 'cod_art' , CAST(cod_art AS NVARCHAR(4000)), CAST(nextcod_art AS NVARCHAR(4000))) " &
		   + "  ,('Dose', 'dose' , CAST(dose AS NVARCHAR(4000)), CAST(nextdose AS NVARCHAR(4000))) " &
		   + "  ,('Listino prezzi gruppo', 'attiva_listino_pregruppi' , CAST(attiva_listino_pregruppi AS NVARCHAR(4000)), CAST(nextattiva_listino_pregruppi AS NVARCHAR(4000))) " &
		   + "  ,('Prezzo 1', 'prezzo' , CAST(prezzo AS NVARCHAR(4000)), CAST(nextprezzo AS NVARCHAR(4000))) " &
		   + "  ,('Prezzo 1 condizioni', 'id_cond_fatt_1' , CAST(id_cond_fatt_1 AS NVARCHAR(4000)), CAST(nextid_cond_fatt_1 AS NVARCHAR(4000))) " &
		   + "  ,('Prezzo 2', 'prezzo_2' , CAST(prezzo_2 AS NVARCHAR(4000)), CAST(nextprezzo_2 AS NVARCHAR(4000))) " &
		   + "  ,('Prezzo 2 condizioni', 'id_cond_fatt_2' , CAST(id_cond_fatt_2 AS NVARCHAR(4000)), CAST(nextid_cond_fatt_2 AS NVARCHAR(4000))) " &
		   + "  ,('Prezzo 3', 'prezzo_3' , CAST(prezzo_3 AS NVARCHAR(4000)), CAST(nextprezzo_3 AS NVARCHAR(4000))) " &
		   + "  ,('Prezzo 3 condizioni', 'id_cond_fatt_3' , CAST(id_cond_fatt_3 AS NVARCHAR(4000)), CAST(nextid_cond_fatt_3 AS NVARCHAR(4000))) " &
		   + "  ,('Tipo', 'tipo' , CAST(tipo AS NVARCHAR(4000)), CAST(nexttipo AS NVARCHAR(4000))) " &
		   + "  ,('Campione', 'campione' , CAST(campione AS NVARCHAR(4000)), CAST(nextcampione AS NVARCHAR(4000))) " &
		   + "  ,('Mis. x', 'mis_x' , CAST(mis_x AS NVARCHAR(4000)), CAST(nextmis_x AS NVARCHAR(4000))) " &
		   + "  ,('Mis. y', 'mis_y' , CAST(mis_y AS NVARCHAR(4000)), CAST(nextmis_y AS NVARCHAR(4000))) " &
		   + "  ,('Mis. z', 'mis_z' , CAST(mis_z AS NVARCHAR(4000)), CAST(nextmis_z AS NVARCHAR(4000))) " &
		   + "  ,('Occupazione pedana', 'occup_ped' , CAST(occup_ped AS NVARCHAR(4000)), CAST(nextoccup_ped AS NVARCHAR(4000))) " &
		   + "  ,('Travaso', 'travaso' , CAST(travaso AS NVARCHAR(4000)), CAST(nexttravaso AS NVARCHAR(4000))) " &
		   + "  ,('Peso_kg', 'peso_kg' , CAST(peso_kg AS NVARCHAR(4000)), CAST(nextpeso_kg AS NVARCHAR(4000))) " &
		   + "  ,('Magazzino', 'magazzino' , CAST(magazzino AS NVARCHAR(4000)), CAST(nextmagazzino AS NVARCHAR(4000))) " &
		   + "  ,('Mt. cubi', 'm_cubi_f' , CAST(m_cubi_f AS NVARCHAR(4000)), CAST(nextm_cubi_f AS NVARCHAR(4000))) " &
		   + "  ,('Attivo', 'attivo' , CAST(attivo AS NVARCHAR(4000)), CAST(nextattivo AS NVARCHAR(4000))) " &
		   + "  ,('CO Codice Contratto', 'contratto' , CAST(contratto AS NVARCHAR(4000)), CAST(nextcontratto AS NVARCHAR(4000))) " &
		   + "  ,('CO data inserimento Contratto', 'contratto_co_data_ins' , CAST(contratto_co_data_ins AS NVARCHAR(4000)), CAST(nextcontratto_co_data_ins AS NVARCHAR(4000))) " &
		   + "  ,('CO id Contratto', 'id_contratto_co' , CAST(id_contratto_co AS NVARCHAR(4000)), CAST(nextid_contratto_co AS NVARCHAR(4000))) " &
		   + "  ,('Listino collegato id', 'id_parent' , CAST(id_parent AS NVARCHAR(4000)), CAST(nextid_parent AS NVARCHAR(4000))) " &
		   + "  ,('E1 codice', 'e1litm' , CAST(e1litm AS NVARCHAR(4000)), CAST(nexte1litm AS NVARCHAR(4000))) " &
		   + "  ,('Valido dal', 'dt_start' , CAST(dt_start AS NVARCHAR(4000)), CAST(nextdt_start AS NVARCHAR(4000))) " &
		   + "  ,('Valido fino al', 'dt_end' , CAST(dt_end AS NVARCHAR(4000)), CAST(nextdt_end AS NVARCHAR(4000))) " &
		+ " 	   ) CA( coltext, colname, value, nextvalue)" &
		+ " WHERE  EXISTS(SELECT value" &
		      + " EXCEPT" &
		      + " SELECT nextvalue)" &
		      + " group by id," &
		       + " coltext, Colname, value " &
		+ " )" &
  	 	 + " SELECT id " &
      		+ " ,coltext	as colonna" &
      		+ " ,colname	as colname" &
      		+ " ,value		as valore" &
      		+ " ,Attuale	as 'Attuale'" &
      		+ " ,x_ValidFrom as 'Valido_dal'" &
      		+ " ,(select t2.x_utente from t t2 where t2.x_ValidFrom = t1.x_ValidFrom and t2.id = t1.id) as utente " &
		+ " FROM  T1 " 
		  
     // + "  where id_meca = 274041          " &
     //   + " ORDER  BY id_meca, " &
     //       + " id_armo, " &
     //       + " Colonna " &
     //       + " Valido_dal " 

	EXECUTE IMMEDIATE "drop VIEW v_temptable_listino " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_temptable_listino): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			
	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_temptable_listino' completata." 
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	 
	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_temptable_sl_pt_g3 () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_temptable_sl_pt_g3' 
//===
int k_errore
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception



//=== Puntatore Cursore da attesa..... 
	SetPointer(kkg.pointer_attesa)

	kuo_exception = create uo_exception
	kst_esito = kuo_exception.inizializza(this.classname())

	k_sql = "create view v_temptable_sl_pt_g3  " &
	  + " as " &
	   + " WITH T " &
		+ "AS ( " & 
		+ "SELECT " &                                                                                                 
		+ "  '*' as Attuale " & 
		+ "  , x_ValidFrom  " & 
		+ "  , x_ValidTo " & 
            + ",cod_sl_pt " &
	         + ",isnull(peso, '') peso "&
            + ",isnull(pesomax, '') pesomax "&
            + ",isnull(mis_x, 0) mis_x "&
            + ",isnull(mis_y, 0) mis_y "&
            + ",isnull(mis_z, 0) mis_z "&
            + ",isnull(dosim_x_bcode, 0) dosim_x_bcode "&
            + ",isnull(dosim_delta_bcode, 0) dosim_delta_bcode "&
            + ",isnull(dosim_et_descr, '') dosim_et_descr "&
            + ",isnull(dosim_et_descr_1, '') dosim_et_descr_1 "&
            + ",isnull(dosetgminmin, 0.0) dosetgminmin "&
            + ",isnull(dosetgminmax, 0.0) dosetgminmax "&
            + ",isnull(dosetgmaxmin, 0.0) dosetgmaxmin "&
            + ",isnull(dosetgmaxmax, 0.0) dosetgmaxmax "&
            + ",isnull(dosetgminfattcorr, 0.0) dosetgminfattcorr "&
            + ",isnull(dosetgmaxfattcorr, 0.0) dosetgmaxfattcorr "&
            + ",isnull(dosetgmintcalc, '') dosetgmintcalc "&
            + ",isnull(dosetgmaxtcalc, '') dosetgmaxtcalc "&
            + ",isnull(dosetgminfattcorr_max, 0.0) dosetgminfattcorr_max "&
            + ",isnull(dosetgmaxfattcorr_max, 0.0) dosetgmaxfattcorr_max "&
            + ",isnull(dosetgmintcalc_max, '') dosetgmintcalc_max "&
            + ",isnull(dosetgmaxtcalc_max, '') dosetgmaxtcalc_max "&
            + ",isnull(densita, 0.0) densita "&
            + ",isnull(densitamax, 0.0) densitamax "&
            + ",isnull(unitwork, 0.0) unitwork "&
            + ",isnull(savedosimeter, 0) savedosimeter "&
            + ",isnull(notecliente, '') notecliente "&
	         + ",isnull(note_descr, '') note_descr "&
		+ "  , x_utente " &
		+ "  , nextpeso = LAG(peso) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextpesomax = LAG(pesomax) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextmis_x = LAG(mis_x) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextmis_y= LAG(mis_y) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextmis_z= LAG(mis_z) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_x_bcode = LAG(dosim_x_bcode) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_delta_bcode = LAG(dosim_delta_bcode) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_et_descr = LAG(dosim_et_descr) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_et_descr_1 = LAG(dosim_et_descr_1) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgminmin = LAG(dosetgminmin) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgminmax = LAG(dosetgminmax) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxmin = LAG(dosetgmaxmin) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxmax = LAG(dosetgmaxmax) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgminfattcorr = LAG(dosetgminfattcorr) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxfattcorr = LAG(dosetgmaxfattcorr) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmintcalc = LAG(dosetgmintcalc) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxtcalc = LAG(dosetgmaxtcalc) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgminfattcorr_max = LAG(dosetgminfattcorr_max) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxfattcorr_max = LAG(dosetgmaxfattcorr_max) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmintcalc_max = LAG(dosetgmintcalc_max) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxtcalc_max = LAG(dosetgmaxtcalc_max) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdensita= LAG(densita) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdensitamax = LAG(densitamax) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextunitwork = LAG(unitwork) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextsavedosimeter = LAG(savedosimeter) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextnotecliente = LAG(notecliente) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextnote_descr = LAG(note_descr) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente = LAG(x_utente) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  FROM sl_pt_g3 " &
		+ "  union all " &
		+ "SELECT " &                                                                                                 
		+ "  ' ' as Attuale " &
		+ "  , x_ValidFrom  " &
		+ "  , x_ValidTo " &
            + ",cod_sl_pt " &
	         + ",isnull(peso, '') peso "&
            + ",isnull(pesomax, '') pesomax "&
            + ",isnull(mis_x, 0) mis_x "&
            + ",isnull(mis_y, 0) mis_y "&
            + ",isnull(mis_z, 0) mis_z "&
            + ",isnull(dosim_x_bcode, 0) dosim_x_bcode "&
            + ",isnull(dosim_delta_bcode, 0) dosim_delta_bcode "&
            + ",isnull(dosim_et_descr, '') dosim_et_descr "&
            + ",isnull(dosim_et_descr_1, '') dosim_et_descr_1 "&
            + ",isnull(dosetgminmin, 0.0) dosetgminmin "&
            + ",isnull(dosetgminmax, 0.0) dosetgminmax "&
            + ",isnull(dosetgmaxmin, 0.0) dosetgmaxmin "&
            + ",isnull(dosetgmaxmax, 0.0) dosetgmaxmax "&
            + ",isnull(dosetgminfattcorr, 0.0) dosetgminfattcorr "&
            + ",isnull(dosetgmaxfattcorr, 0.0) dosetgmaxfattcorr "&
            + ",isnull(dosetgmintcalc, '') dosetgmintcalc "&
            + ",isnull(dosetgmaxtcalc, '') dosetgmaxtcalc "&
            + ",isnull(dosetgminfattcorr_max, 0.0) dosetgminfattcorr_max "&
            + ",isnull(dosetgmaxfattcorr_max, 0.0) dosetgmaxfattcorr_max "&
            + ",isnull(dosetgmintcalc_max, '') dosetgmintcalc_max "&
            + ",isnull(dosetgmaxtcalc_max, '') dosetgmaxtcalc_max "&
            + ",isnull(densita, 0.0) densita "&
            + ",isnull(densitamax, 0.0) densitamax "&
            + ",isnull(unitwork, 0.0) unitwork "&
            + ",isnull(savedosimeter, 0) savedosimeter "&
            + ",isnull(notecliente, '') notecliente "&
	         + ",isnull(note_descr, '') note_descr "&
		+ "  , x_utente " &
		+ "  , nextpeso = LAG(peso) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextpesomax = LAG(pesomax) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextmis_x = LAG(mis_x) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextmis_y= LAG(mis_y) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextmis_z= LAG(mis_z) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_x_bcode = LAG(dosim_x_bcode) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_delta_bcode = LAG(dosim_delta_bcode) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_et_descr = LAG(dosim_et_descr) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosim_et_descr_1 = LAG(dosim_et_descr_1) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgminmin = LAG(dosetgminmin) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgminmax = LAG(dosetgminmax) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxmin = LAG(dosetgmaxmin) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxmax = LAG(dosetgmaxmax) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgminfattcorr = LAG(dosetgminfattcorr) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxfattcorr = LAG(dosetgmaxfattcorr) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmintcalc = LAG(dosetgmintcalc) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxtcalc = LAG(dosetgmaxtcalc) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgminfattcorr_max = LAG(dosetgminfattcorr_max) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxfattcorr_max = LAG(dosetgmaxfattcorr_max) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmintcalc_max = LAG(dosetgmintcalc_max) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdosetgmaxtcalc_max = LAG(dosetgmaxtcalc_max) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdensita= LAG(densita) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextdensitamax = LAG(densitamax) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextunitwork = LAG(unitwork) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextsavedosimeter = LAG(savedosimeter) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextnotecliente = LAG(notecliente) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextnote_descr = LAG(note_descr) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  , nextx_utente = LAG(x_utente) OVER (PARTITION BY cod_sl_pt ORDER BY x_ValidFrom) " &
		+ "  FROM sl_pt_g3H " &
		+ " ) " &
		+ ",  T1 " &
		+ "      AS (  " &
		+ " SELECT t.cod_sl_pt " &
		+ "  , coltext			 " &
		+ "  , colname			 " &
		+ "  , value			 " &
		+ "  , max(Attuale) attuale " &
		+ "  , min(x_ValidFrom) x_validfrom " &
		+ " FROM  T  " &
		   + "   CROSS APPLY ( VALUES " &
		   + "   ('Peso', 'peso' , CAST(peso AS NVARCHAR(4000)), CAST(nextpeso AS NVARCHAR(4000))) " &
		   + "   ,('Peso max', 'pesomax' , CAST(pesomax AS NVARCHAR(4000)), CAST(nextpesomax AS NVARCHAR(4000))) " &
		   + "   ,('Mis.x', 'mis_x' , CAST(mis_x AS NVARCHAR(4000)), CAST(nextmis_x AS NVARCHAR(4000))) " &
		   + "   ,('Mis.y', 'mis_y' , CAST(mis_y AS NVARCHAR(4000)), CAST(nextmis_y AS NVARCHAR(4000))) " &
		   + "   ,('Mis.z', 'mis_z' , CAST(mis_z AS NVARCHAR(4000)), CAST(nextmis_z AS NVARCHAR(4000))) " &
		   + "   ,('Dosim. per barcode', 'dosim_x_bcode' , CAST(dosim_x_bcode AS NVARCHAR(4000)), CAST(nextdosim_x_bcode AS NVARCHAR(4000))) " &
		   + "   ,('Dosim. delta barcode', 'dosim_delta_bcode' , CAST(dosim_delta_bcode AS NVARCHAR(4000)), CAST(nextdosim_delta_bcode AS NVARCHAR(4000))) " &
		   + "   ,('Dosim. descr. etichetta', 'dosim_et_descr' , CAST(dosim_et_descr AS NVARCHAR(4000)), CAST(nextdosim_et_descr AS NVARCHAR(4000))) " &
		   + "   ,('Dose target min. min.', 'dosetgminmin' , CAST(dosetgminmin AS NVARCHAR(4000)), CAST(nextdosetgminmin AS NVARCHAR(4000))) " &
		   + "   ,('Dose target min. max', 'dosetgminmax' , CAST(dosetgminmax AS NVARCHAR(4000)), CAST(nextdosetgminmax AS NVARCHAR(4000))) " &
		   + "   ,('Dose target min. fatt. corr.min.', 'dosetgminfattcorr' , CAST(dosetgminfattcorr AS NVARCHAR(4000)), CAST(nextdosetgminfattcorr AS NVARCHAR(4000))) " &
		   + "   ,('Dose target min. tipo calc.min.', 'dosetgmintcalc' , CAST(dosetgmintcalc AS NVARCHAR(4000)), CAST(nextdosetgmintcalc AS NVARCHAR(4000))) " &
		   + "   ,('Dose target min. fatt. corr.max.', 'dosetgmaxfattcorr' , CAST(dosetgmaxfattcorr AS NVARCHAR(4000)), CAST(nextdosetgmaxfattcorr AS NVARCHAR(4000))) " &
		   + "   ,('Dose target min. tipo calc.max.', 'dosetgmaxtcalc' , CAST(dosetgmaxtcalc AS NVARCHAR(4000)), CAST(nextdosetgmaxtcalc AS NVARCHAR(4000))) " &
		   + "   ,('Dose target max. min.', 'dosetgmaxmin' , CAST(dosetgmaxmin AS NVARCHAR(4000)), CAST(nextdosetgmaxmin AS NVARCHAR(4000))) " &
		   + "   ,('Dose target max. max', 'dosetgmaxmax' , CAST(dosetgmaxmax AS NVARCHAR(4000)), CAST(nextdosetgmaxmax AS NVARCHAR(4000))) " &
		   + "   ,('Dose target max. fatt. corr.min.', 'dosetgminfattcorr_max' , CAST(dosetgminfattcorr_max AS NVARCHAR(4000)), CAST(nextdosetgminfattcorr_max AS NVARCHAR(4000))) " &
		   + "   ,('Dose target max. tipo calc.min.', 'dosetgmintcalc_max' , CAST(dosetgmintcalc_max AS NVARCHAR(4000)), CAST(nextdosetgmintcalc_max AS NVARCHAR(4000))) " &
		   + "   ,('Dose target max. fatt. corr.max.', 'dosetgmaxfattcorr_max' , CAST(dosetgmaxfattcorr_max AS NVARCHAR(4000)), CAST(nextdosetgmaxfattcorr_max AS NVARCHAR(4000))) " &
		   + "   ,('Dose target max. tipo calc.max.', 'dosetgmaxtcalc_max' , CAST(dosetgmaxtcalc_max AS NVARCHAR(4000)), CAST(nextdosetgmaxtcalc_max AS NVARCHAR(4000))) " &
		   + "   ,('Densità', 'densita' , CAST(densita AS NVARCHAR(4000)), CAST(nextdensita AS NVARCHAR(4000))) " &
		   + "   ,('Densità max', 'densitamax' , CAST(densitamax AS NVARCHAR(4000)), CAST(nextdensitamax AS NVARCHAR(4000))) " &
		   + "   ,('Unità di lavoro', 'unitwork' , CAST(unitwork AS NVARCHAR(4000)), CAST(nextunitwork AS NVARCHAR(4000))) " &
		   + "   ,('Salva dosimetro', 'savedosimeter' , CAST(savedosimeter AS NVARCHAR(4000)), CAST(nextsavedosimeter AS NVARCHAR(4000))) " &
		   + "   ,('Note cliente', 'notecliente' , CAST(notecliente AS NVARCHAR(4000)), CAST(nextnotecliente AS NVARCHAR(4000))) " &
		   + "   ,('Note', 'note_descr' , CAST(note_descr AS NVARCHAR(4000)), CAST(nextnote_descr AS NVARCHAR(4000))) " &
		+ " 	   ) CA( coltext, colname, value, nextvalue)" &
		+ " WHERE  EXISTS(SELECT value" &
		      + " EXCEPT" &
		      + " SELECT nextvalue)" &
		      + " group by cod_sl_pt," &
		      + "  coltext, Colname, value " &
		+ " )" &
  	 	 + " SELECT t1.cod_sl_pt " &
      		+ " , coltext	as colonna" &
      		+ " , colname	as colname" &
      		+ " , value		as valore" &
      		+ " , Attuale	as 'Attuale'" &
      		+ " , x_ValidFrom as 'Valido_dal'" &
      		+ " , (select t2.x_utente from t t2 where t2.x_ValidFrom = t1.x_ValidFrom and t2.cod_sl_pt = t1.cod_sl_pt) as utente " &
		+ " FROM  T1 "
		  
     // + "  where id_meca = 274041          " &
     //   + " ORDER  BY id_meca, " &
     //       + " id_armo, " &
     //       + " Colonna " &
     //       + " Valido_dal " 

	EXECUTE IMMEDIATE "drop VIEW v_temptable_sl_pt_g3 " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_temptable_sl_pt_g3): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(kkg.pointer_default)
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_internal_bug )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			
	SetPointer(kkg.pointer_default)

	if k_errore = 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_temptable_armo' completata." 
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	 
	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_contatti () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_contatti' 
//===
boolean k_return
string k_sql


//	k_sql = "create view v_contatti  " &

	k_sql = " as SELECT " &
			+" isnull(clienti.codice, 0) id_cliente ," & 
			+" isnull(clienti.stato,'6') stato, " & 
			+" isnull(clienti.tipo,'') tipo, " & 
			+" isnull(trim(clienti.rag_soc_10),'') rag_soc_10," & 
			+" isnull(trim(clienti.rag_soc_11),'') rag_soc_11," & 
			+" isnull(trim(clienti.indi_1),'') indi_1," & 
			+" isnull(clienti.cap_1,'') cap_1," & 
			+" isnull(trim(clienti.loc_1),'') loc_1," & 
			+" isnull(clienti.prov_1,'') prov_1," & 
			+" isnull(clienti.zona,'') zona," & 
			+" isnull(clienti.p_iva,'') p_iva," & 
			+" isnull(clienti.cf,'') cf," & 
			+" isnull(trim(clienti.fono),'')  fono," & 
			+" isnull(trim(clienti.fax),'')   fax, " & 
			+" isnull(clienti.id_nazione_1,0) id_nazione," & 
			+" clienti.x_datins," & 
			+" clienti.x_utente," & 
			+" isnull(trim(clienti_web.email),'')  email," & 
			+" isnull(trim(clienti_web.email1),'') email1," & 
			+" isnull(trim(clienti_web.email2),'') email2," &  
			+" isnull(trim(clienti_web.note),' ')  note," & 
			+" isnull(trim(clienti_web.sito_web),'')  sito_web," & 
			+" isnull(trim(clienti_web.sito_web1),'') sito_web1, " & 
			+" isnull(trim(clienti_web.blog_web),'')  blog_web, " &
			+" isnull(trim(clienti_web.blog_web1),'')  blog_web1, " & 
			+" isnull(clienti_mkt.id_cliente_link,0) id_cliente_link," & 
			+" isnull(clienti_mkt.qualifica,'') qualifica, " & 
			+" isnull(trim(JSON_VALUE(clienti_mkt.data_json ,'$.for_qa_italy')),'') for_qa_italy, " & 
			+" isnull(trim(JSON_VALUE(clienti_mkt.data_json ,'$.for_cobalt_rload')),'') for_cobalt_rload, " & 
			+" isnull(trim(JSON_VALUE(clienti_mkt.data_json ,'$.for_price_cntct')),'') for_price_cntct, " & 
			+" isnull(trim(JSON_VALUE(clienti_mkt.data_json ,'$.cell')),'') cell, " & 
			+" isnull(trim(JSON_VALUE(clienti_mkt.data_json ,'$.categ')),'') categ " & 
		 +" FROM clienti " & 
			+" left outer join clienti_web on clienti.codice = clienti_web.id_cliente " & 
			+" left outer join clienti_mkt on clienti.codice = clienti_mkt.id_cliente " &
		 +" Where clienti.tipo = 'C' "
		
//				+ " ,JSON_VALUE(ptasks_rows.data_json ,'$.iva') iva " & 

	k_return = u_tb_crea_view("v_contatti", k_sql)


return k_return

end function

private function boolean u_crea_view_v_meca_artr_impianto () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_meca_artr_impianto'
//=== Righe fattura 
//===
boolean k_return 
string k_sql


	//k_sql = "CREATE VIEW v_meca_artr_impianto  " &
	k_sql = " " &
			+ " (id_meca , " &
			+ " impianto " & 
	      + ") " &
			+ " AS  " &
			+ " select  distinct " & 
                      + " meca.id  " & 
							 + " , case when max(artr.impianto) > 0 then max(artr.impianto) " &
								 + " else isnull(meca.impianto, 2) " &
                      + " end as impianto  " & 
                      + " FROM meca inner join armo on meca.id = armo.id_meca " &
									 + " left outer join artr on armo.id_armo = artr.id_armo " &
					+ " group by meca.id, meca.impianto "

	k_return = u_tb_crea_view("v_meca_artr_impianto", k_sql)

return k_return

end function

private function boolean u_tb_crea_view (string a_viewname, string a_sql) throws uo_exception;/*
  Esegue la CREATE VIEW
  Inp: nome della view + sql della view
  ret: TRUE = ok
*/

return u_tb_crea_view(kguo_sqlca_db_magazzino, a_viewname, a_sql)


end function

private function boolean u_crea_view_v_colli_sped () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_colli_sped' 
//===
boolean k_return
string k_sql


	k_sql = " ( id_meca, id_armo, colli_sped) AS  " &
			 + "  SELECT armo.id_meca,   " &
					+ " armo.id_armo,   " &
					+ " sum(arsp.colli) " &
			      + " FROM armo inner join arsp on armo.id_armo = arsp.id_armo   " &
               + " group by  armo.id_meca, armo.id_armo " 

	k_return = u_tb_crea_view("v_colli_sped", k_sql)


return k_return

end function

private function boolean u_crea_view_v_sped_deposito_anag () throws uo_exception;/*
 Estemporanea da lanciare una sola volta
	 Crae tabella View  'v_sped_deposito_anag' 
*/
boolean k_return = true
string k_sql
 

	SetPointer(kkg.pointer_attesa)

	k_sql = " as SELECT " &
		+ " id_sped " & 
		+ " ,convert(integer,isnull(JSON_VALUE(deposito_anag ,'$.id_deposito_anag'),0))  id_deposito_anag " &
		+ ",CASE " &
		+ "	WHEN trim(JSON_VALUE(deposito_anag ,'$.depo_rag_soc_1 ')) > ' ' THEN trim(JSON_VALUE(deposito_anag ,'$.depo_rag_soc_1')) " &
		+ "	ELSE 'Sterigenics Italy S.p.A.'       " &
		+ "	END depo_rag_soc_1 "  &
		+ ",CASE " &
		+ "	WHEN trim(JSON_VALUE(deposito_anag ,'$.depo_rag_soc_1 ')) > ' ' THEN trim(JSON_VALUE(deposito_anag ,'$.depo_rag_soc_2')) " &
		+ "	ELSE ' ' " &
		+ "	END depo_rag_soc_2 "  &
		+ ",CASE " &
		+ "	WHEN trim(JSON_VALUE(deposito_anag ,'$.depo_rag_soc_1 ')) > ' ' THEN trim(JSON_VALUE(deposito_anag ,'$.depo_indi'))  " &
		+ "	ELSE 'Via Marzabotto, 4' "  &
		+ "	END depo_indi " &
		+ ",CASE " &
		+ "	WHEN trim(JSON_VALUE(deposito_anag ,'$.depo_rag_soc_1 ')) > ' ' THEN " &
		+ "									concat(trim(JSON_VALUE(deposito_anag ,'$.depo_cap')), ' ' " &
		+ "									,trim(JSON_VALUE(deposito_anag ,'$.depo_loc')),' ('" &
		+ "									,trim(JSON_VALUE(deposito_anag ,'$.depo_prov')),') ')  "  &
		+ "	ELSE '40061 MINERBIO (BO)' "  &
		+ "	END depo_cap_loc_prov  " &
		+ ",CASE " &
		+ "	WHEN trim(JSON_VALUE(deposito_anag ,'$.depo_rag_soc_1 ')) > ' ' THEN trim(JSON_VALUE(deposito_anag ,'$.depo_nazione'))   " &
		+ "	ELSE ''  " &
		+ "	END depo_nazione "  &
		+ ",CASE " &
		+ "	WHEN trim(JSON_VALUE(deposito_anag ,'$.depo_rag_soc_1 ')) > ' ' THEN trim(JSON_VALUE(deposito_anag ,'$.depo_contatto1')) " &
		+ "	ELSE 'Tel. (+39) 051 66 05 998' " &
		+ "	END depo_contatto1 "  &
		+ ",CASE " &
		+ "	WHEN trim(JSON_VALUE(deposito_anag ,'$.depo_rag_soc_1 ')) > ' ' THEN trim(JSON_VALUE(deposito_anag ,'$.depo_contatto2')) " &
		+ "	ELSE 'Fax (+39) 051 66 05 574' " &
		+ "	END depo_contatto2 "  &
		+ ",CASE " &
		+ "	WHEN trim(JSON_VALUE(deposito_anag ,'$.depo_rag_soc_1 ')) > ' ' THEN trim(JSON_VALUE(deposito_anag ,'$.depo_contatto3')) " &
		+ "	ELSE 'www.sterigenics.com' "  &
		+ "	END depo_contatto3 "  &
		+ ",CASE " &
		+ "	WHEN trim(JSON_VALUE(deposito_anag ,'$.depo_rag_soc_1 ')) > ' ' THEN trim(JSON_VALUE(deposito_anag ,'$.depo_contatto4')) " &
		+ "	ELSE 'gestione.clienti@sterigenics.com'   " &
		+ "	END depo_contatto4  " &
		+ "FROM sped  " 

	k_return = u_tb_crea_view("v_sped_deposito_anag", k_sql)

	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_barcode_data_json () throws uo_exception;/*
Estemporanea da lanciare una sola volta
	Crae tabella View  'v_ptsks_rows' 
*/
boolean k_return = true
string k_sql


	SetPointer(kkg.pointer_attesa)

	k_sql = " as SELECT barcode.barcode " &
		+ " , case when JSON_VALUE(barcode.data_json ,'$.g3lav_cicloin' ) > '0' then convert(INTEGER, JSON_VALUE(barcode.data_json ,'$.g3lav_cicloin'  )) else 0 end g3lav_cicloin " & 
		+ " , case when JSON_VALUE(barcode.data_json ,'$.g3lav_cicloout') > '0' then convert(integer, JSON_VALUE(barcode.data_json ,'$.g3lav_cicloout' )) else 0 end g3lav_cicloout " & 
		+ " FROM barcode " 

	k_return = u_tb_crea_view("v_barcode_data_json", k_sql)

	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_clienti_mkt_web () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_clienti_mkt_web' 
//===
boolean k_return
string k_sql


	k_sql = " as " &
		  +" SELECT  " &
        +" clienti_mkt.id_cliente,   " &
        +" trim(clienti_mkt.qualifica) as qualifica,   " &
        +" isnull(clienti_mkt.id_cliente_link,0) as id_cliente_link,   " &
        +" trim(isnull(c_link.rag_soc_10,'')) as c_link_rag_soc_10,   " &
        +" trim(clienti_mkt.altra_sede) as altra_sede,   " &
        +" trim(isnull(clienti_mkt.cod_atecori,'')) as cod_atecori,   " &
        +" trim(isnull(clienti_mkt.note_attivita,'')) as note_attivita,   " &
        +" trim(isnull(clienti_mkt.note_prodotti,'')) as note_prodotti,   " &
        +" trim(isnull(clienti_mkt.tipo_rapporto,'')) as tipo_rapporto,   " &
        +" trim(isnull(clienti_web.email,'')) as email,   " &
        +" trim(isnull(clienti_web.email1,'')) as email1,   " &
        +" trim(isnull(clienti_web.email2,'')) as email2,   " &
        +" trim(isnull(clienti_web.note,'')) as note,   " &
        +" trim(isnull(clienti_web.sito_web,'')) as sito_web,   " &
        +" trim(isnull(clienti_web.sito_web1,'')) as sito_web1,   " &
        +" trim(isnull(clienti_web.blog_web,'')) as blog_web,   " &
        +" trim(isnull(clienti_web.blog_web1,'')) as blog_web1,    " &
        +" clienti_mkt.x_datins,   " &
        +" clienti_mkt.x_utente,   " &
        +" clienti_web.x_datins x_datins1,   " &
        +" clienti_web.x_utente x_utente1,  " &
        +" isnull(clienti_mkt.gruppo, 0) gruppo,   " &
        +" trim(isnull(gru.des,'')) as gru_des, " &
        +" trim(isnull(clienti_mkt.doc_esporta,'')) as doc_esporta,   " &
        +" trim(isnull(clienti_mkt.doc_esporta_prefpath,'')) as doc_esporta_prefpath, " &
        +" trim(isnull(clienti_web.email3,'')) as email3,   " &
        +" isnull(clienti_web.email_prontomerce, 0) as email_prontomerce " &
        +" ,isnull(clienti_web.email_send_certif_off, 0) as email_send_certif_off   " &
        +" ,trim(isnull(clienti.rag_soc_10,'')) as rag_soc_10   " &
			+" ,isnull(trim(JSON_VALUE(clienti_mkt.data_json ,'$.for_qa_italy')),'') for_qa_italy " & 
			+" ,isnull(trim(JSON_VALUE(clienti_mkt.data_json ,'$.for_cobalt_rload')),'') for_cobalt_rload " & 
			+" ,isnull(trim(JSON_VALUE(clienti_mkt.data_json ,'$.for_price_cntct')),'') for_price_cntct " & 
			+" ,isnull(trim(JSON_VALUE(clienti_mkt.data_json ,'$.cell')),'') cell " & 
			+" ,isnull(trim(JSON_VALUE(clienti_mkt.data_json ,'$.categ')),'') categ " & 
         +" ,isnull(clienti_altro.parzialecolli_warning, 0) as parzialecolli_warning   " &
         +" ,isnull(clienti_fatt.email_invio, '0') as email_invio " &
+ " ,'' as contatto_5_qualif " &
    +" FROM (clienti left outer join clienti_mkt on  clienti.codice = clienti_mkt.id_cliente" &
   					  +" left outer join clienti as c_link on clienti_mkt.id_cliente_link = c_link.codice" &
   					  +" left outer join gru on clienti_mkt.gruppo = gru.codice)" &
                    +" left outer join clienti_web on clienti.codice = clienti_web.id_cliente" &
                    +" left outer join clienti_altro on clienti.codice = clienti_altro.id_cliente " & 
                    +" left outer join clienti_fatt on  clienti.codice = clienti_fatt.id_cliente " 

     //   +" trim(isnull(clienti_mkt.contatto_5_qualif,'')) as contatto_5_qualif,   " &
                 //   +" left outer join clienti as c1 on clienti_mkt.id_contatto_1 = c1.codice" &
//   					  +" left outer join clienti as c2 on clienti_mkt.id_contatto_2 = c2.codice" &
//   					  +" left outer join clienti as c3 on clienti_mkt.id_contatto_3 = c3.codice" &
//   					  +" left outer join clienti as c4 on clienti_mkt.id_contatto_4 = c4.codice" &
//   					  +" left outer join clienti as c5 on clienti_mkt.id_contatto_5 = c5.codice" &

	k_return = u_tb_crea_view("v_clienti_mkt_web", k_sql)


return k_return

end function

private function boolean u_crea_view_v_memo () throws uo_exception;/*
 Estemporanea da lanciare una sola volta
	 Crae tabella View  'v_memo' 
*/
boolean k_return = true
string k_sql
 

//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)

	k_sql = " as SELECT " &
			+ " clienti_memo.id_cliente_memo " &
			+ " ,clienti_memo.id_memo " &
			+ " ,clienti_memo.id_cliente " &
			+ " ,0 id_meca " &
			+ " ,trim(coalesce(clienti_memo.tipo_sv, '')) tipo_sv " &
			+ " ,trim(coalesce(clienti_memo.allarme, '')) allarme " &
			+ " ,coalesce(clienti_memo.xclie_1, 0) xclie_1 " &
			+ " ,coalesce(clienti_memo.xclie_2, 0) xclie_2 " &
			+ " ,coalesce(clienti_memo.xclie_3, 0) xclie_3 " &
			+ " ,trim(coalesce(memo.titolo, '')) titolo " &
			+ " ,trim(coalesce(memo.note, '')) note " &
			+ " from clienti_memo inner join memo on clienti_memo.id_memo = memo.id_memo " &
		+ " union all " &
			+ " select " &
			+ " meca_memo.id_meca_memo " &
			+ " ,meca_memo.id_memo " &
			+ " ,coalesce(meca.clie_3,0) id_cliente " &
			+ " ,meca_memo.id_meca " &
			+ " ,trim(coalesce(meca_memo.tipo_sv, '')) tipo_sv " &
			+ " ,trim(coalesce(meca_memo.allarme, '')) allarme " &
			+ " ,1 xclie_1 " &
			+ " ,1 xclie_2 " &
			+ " ,1 xclie_3 " &
			+ " ,trim(coalesce(memo.titolo, '')) titolo " &
			+ " ,trim(coalesce(memo.note, '')) note " &
			+ " from meca_memo inner join memo on meca_memo.id_memo = memo.id_memo " &
			+ " left outer join meca on meca_memo.id_meca = meca.id " &
		+ " union all " &
			+ "  select " &
			+ " id_sl_pt_memo " &
			+ " ,sl_pt_memo.id_memo " &
			+ " ,0 id_cliente " &
			+ " ,cod_sl_pt  " &
			+ " ,trim(coalesce(sl_pt_memo.tipo_sv, '')) tipo_sv " &
			+ " ,'' allarme " &
			+ " ,0 xclie_1 " &
			+ " ,0 xclie_2 " &
			+ " ,0 xclie_3 " &
			+ " ,trim(coalesce(memo.titolo, '')) titolo " &
			+ " ,trim(coalesce(memo.note, '')) note " &
			+ " from sl_pt_memo inner join memo on sl_pt_memo.id_memo = memo.id_memo " 
		
//		+ " , x_datins " &
//		+ " , coalesce(x_utente, '') x_utente" &

	k_return = u_tb_crea_view("v_memo", k_sql)

	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_rubrica_clienti () throws uo_exception;/*
 Estemporanea da lanciare una sola volta
	 Crae tabella View  'v_rubrica_clienti' 
*/
boolean k_return = true
string k_sql
 

//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)

	k_sql = " as SELECT " &
		+ " email " &
      + " ,rag_soc_10 " &
      + " ,id_cliente " &
      + " ,max(x_datins) x_datins " &
 + " from( " &
		+ " select trim(value) email " &
		+ " 			,coalesce(trim(clienti.rag_soc_10),'') rag_soc_10 " &
		+ " 			,id_cliente id_cliente " &
		+ " 			,clienti_web.x_datins x_datins " &
		+ " 	from clienti_web " &
		+ " 		 left outer join clienti on clienti_web.id_cliente = clienti.codice " &
		+ " 	cross apply STRING_SPLIT(replace(trim(email), ',', ';'), ';') " &
		+ " where trim(value) > ' ' " &
		+ " union  " &
		+ " select trim(value) email " &
		+ " 			,coalesce(trim(clienti.rag_soc_10),'') " &
		+ " 			,id_cliente " &
		+ " 			,clienti_web.x_datins x_datins " &
		+ " 	from clienti_web " &
		+ " 		 left outer join clienti on clienti_web.id_cliente = clienti.codice " &
		+ " 	cross apply STRING_SPLIT(replace(trim(email1), ',', ';'), ';') " &
		+ " where trim(value) > ' ' " &
		+ " union  " &
		+ " select trim(value) email " &
		+ " 			,coalesce(trim(clienti.rag_soc_10),'') " &
		+ " 			,id_cliente " &
		+ " 			,clienti_web.x_datins x_datins " &
		+ " 	from clienti_web " &
		+ " 		 left outer join clienti on clienti_web.id_cliente = clienti.codice " &
		+ " 	cross apply STRING_SPLIT(replace(trim(email2), ',', ';'), ';') " &
		+ " where trim(value) > ' ' " &
		+ " union  " &
		+ " select trim(value) email " &
		+ " 			,coalesce(trim(clienti.rag_soc_10),'') " &
		+ " 			,id_cliente " &
		+ " 			,clienti_web.x_datins x_datins " &
		+ " 	from clienti_web " &
		+ " 		 left outer join clienti on clienti_web.id_cliente = clienti.codice " &
		+ " 	cross apply STRING_SPLIT(replace(trim(email3), ',', ';'), ';') " &
		+ " where trim(value) > ' ' " &
		+ " union  " &
		+ " select trim(value) email " &
		+ " 			,coalesce(trim(clienti.rag_soc_10),'') " &
		+ " 			,id_cliente " &
		+ " 			,email_invio.x_datins x_datins " &
		+ " 	from email_invio left outer join clienti on email_invio.id_cliente = clienti.codice " &
		+ " 	cross apply STRING_SPLIT(replace(trim(email), ',', ';'), ';') " &
		+ " where trim(value) > ' ' " &
	+ " ) as t1 " &
    + " group by email " &
		+ " ,id_cliente " &
		+ " ,rag_soc_10 " 
  //  + " order by t1.rag_soc_10, t1.email " 

	k_return = u_tb_crea_view("v_rubrica_clienti", k_sql)

	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_crea_view_v_rubrica_all () throws uo_exception;/*
 Estemporanea da lanciare una sola volta
	 Crae tabella View  'v_rubrica_all' 
*/
boolean k_return = true
string k_sql
 

//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)

	k_sql = " as SELECT " &
		+ " email " &
      + " ,rag_soc_10 " &
      + " ,id_cliente " &
      + " ,x_datins x_datins " &
		+ " ,'C' tipo " &
      + " from v_rubrica_clienti " &
   + " union " &
		+ "  select trim(sr_utenti.email) " &
		+ " ,coalesce(trim(sr_utenti.nome),'') " &
		+ " ,sr_utenti.id " &
		+ " ,sr_utenti.x_datins x_datins " &
		+ " ,'B' tipo " &
		+ " from sr_utenti " &
		+ " where sr_utenti.email > ' ' " &
   + " union " &
		+ " select trim(base.e_mail) " &
		+ " ,coalesce(trim(base.rag_soc_1),'') " &
		+ " ,cast(1 + ascii(upper(id)) - ascii('A') as tinyint) " &
		+ " ,getdate() x_datins " &
		+ " ,'A' tipo " &
		+ " from base " 
   // + " order by 2, 1 "    and stato = 0

	k_return = u_tb_crea_view("v_rubrica_all", k_sql)

	SetPointer(kkg.pointer_default)

return k_return

end function

private function boolean u_tb_crea_view (kuo_sqlca_db_0 auo_sqlca_db_0, string a_viewname, string a_sql) throws uo_exception;/*
  Esegue la CREATE VIEW
  Inp: kuo_sqlca_db_0, nome della view + sql della view
  ret: TRUE = ok
*/
boolean k_return
string k_immediate_sql


try
	
	SetPointer(kkg.pointer_attesa)

	kguo_exception.inizializza(this.classname())

	auo_sqlca_db_0.db_crea_view(a_viewname, a_sql)

	kguo_exception.kist_esito.nome_oggetto = this.classname()
	kguo_exception.kist_esito.sqlerrtext = "Generazione della View '" + trim(a_viewname) + "' completata." 
	kguo_exception.scrivi_log()
	 
	k_return = true

catch ( uo_exception kuo_exception)	
	throw kuo_exception
		
finally		
	SetPointer(kkg.pointer_default)

end try

return k_return

end function

on kuf_utility_db.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_utility_db.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

