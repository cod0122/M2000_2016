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
	krc = u_crea_view_v_sped_free()
	if not krc then k_return=false
	krc = u_crea_view_v_alarm_instock_tosend()
	if not krc then k_return=false
	krc = u_crea_view_v_meca_instock()
	if not krc then k_return=false
	krc = u_crea_view_v_ptasks_rows( )
	if not krc then k_return=false
	krc = u_crea_view_v_asd_barcode_all( )
	if not krc then k_return=false
	

	kguo_sqlca_db_magazzino.db_commit( )

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
         + " data_ent,    " & 
         + " data_int,    " & 
         + " num_int,    " & 
         + " contratto,    " & 
         + " area_mag,     " & 
			+ " area_mag_pos, "  &
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
         + " meca.area_mag,     " & 
			+ " substring(meca.area_mag, 5, 1), "  &
         + " contratti.mc_co,    " & 
         + " contratti.sc_cf,    " & 
         + " contratti.sl_pt,    " & 
         + " contratti.descr,  "   & 
         + " meca.clie_1,    " & 
         + " meca.clie_2,    " & 
         + " meca.clie_3,    " & 
         + " meca.num_bolla_in,    " & 
         + " meca.data_bolla_in,   " & 
         + " consegna_data, " & 
         + " CONVERT(DATETIME, CONVERT(CHAR(8), consegna_data, 112) + ' ' + CONVERT(CHAR(8), coalesce(consegna_ora, '00:00:00'), 108)) , " &
			+ " coalesce(barcode.pl_barcode, 0), " &
         + " barcode.fila_1,    " & 
         + " barcode.fila_2,    " & 
         + " barcode.fila_1p,    " & 
         + " barcode.fila_2p,    " & 
         + " max(barcode.groupage) as grp " & 
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
		kst_esito.esito = kkg_esito.db_ko
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
		kst_esito.esito = kkg_esito.db_ko
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
int k_errore=0
boolean k_return = true
string k_sql
st_esito kst_esito
kuf_alarm_instock kuf1_alarm_instock
uo_exception kuo_exception
 


	SetPointer(kkg.pointer_attesa)

//13-12-2022 richiesta da Pietro di mettere x gg lavorativi (quindi aggiungo parte circa la tab u_calendario)

	k_sql = "create view v_alarm_instock_tosend  " &
		+ " as SELECT " &
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
	  	+ " and ((kcal_start_stock.cal_date = meca.data_ent and alarm_instock.calc_stocktime = " + string(kuf1_alarm_instock.ki_calc_stocktime_by_data_ent) + ")" &
  	        + " or (kcal_start_stock.cal_date = certif.data and alarm_instock.calc_stocktime = " + string(kuf1_alarm_instock.ki_calc_stocktime_by_certif_data) + "))" &
		+ " and meca.data_ent > '01.01.1990' " &
		+ " and (kcal_today.workday - kcal_start_stock.workday - 1) > alarm_instock.nday_instock " &
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
		
//13-12-2022 richiesta da Pietro di mettere x gg lavorativi (quindi tolgo questa parte):
//    + " and ((alarm_instock.calc_stocktime = " + string(kuf1_alarm_instock.ki_calc_stocktime_by_data_ent) &
//	   +        " and meca.data_ent <= dateadd(DD, (-1 * alarm_instock.nday_instock), getdate()) " &
//		+        ") or (alarm_instock.calc_stocktime = " + string(kuf1_alarm_instock.ki_calc_stocktime_by_certif_data) &
//	   +        " and certif.data <= dateadd(DD, (-1 * alarm_instock.nday_instock), getdate()) " &
//      +       ")) " &

//   	+ " (alarm_instock.nday_instock = 0 OR alarm_instock.nday_instock > DATEDIFF(d, getdate(), meca.data_ent) ) " &
	EXECUTE IMMEDIATE "drop VIEW v_alarm_instock_tosend " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_alarm_instock_tosend): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
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
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_alarm_instock_tosend' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
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
		kst_esito.esito = kkg_esito.db_ko
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
		kst_esito.esito = kkg_esito.db_ko
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
		kst_esito.esito = kkg_esito.db_ko
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

private function boolean u_crea_view_v_ptasks_rows () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_ptsks_rows' 
//===
int k_errore=0
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception



//=== Puntatore Cursore da attesa..... 
	SetPointer(kkg.pointer_attesa)

	k_sql = "create view v_ptasks_rows  " &
		+ " as SELECT ptasks_rows.id_ptasks_row " &
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
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.acc.arrivodata') > '01.01.2019' then convert(DATE, JSON_VALUE(ptasks_rows.data_json ,'$.acc.arrivodata'))  else null  end accettazione_arrivodata  " &
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.acc.e1wo') > '0' then convert(INTEGER, JSON_VALUE(ptasks_rows.data_json ,'$.acc.e1wo')) else 0 end accettazione_e1wo " & 
		+ " , case when JSON_VALUE(ptasks_rows.data_json ,'$.acc.pesolordoxlottokg') > '0' then convert(decimal(8,3), JSON_VALUE(ptasks_rows.data_json ,'$.acc.pesolordoxlottokg')) else 0.0000 end accettazione_pesolordoxlottokg " & 
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

//				+ " ,JSON_VALUE(ptasks_rows.data_json ,'$.iva') iva " & 

	EXECUTE IMMEDIATE "drop VIEW v_ptasks_rows " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_ptasks_rows): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
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
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_ptasks_rows' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
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
		kst_esito.esito = kkg_esito.db_ko
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

private function boolean u_crea_view_v_sped_free () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_sped_free' 
//===
int k_errore=0
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
 



//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)

	k_sql = "create view v_sped_free  " &
		+ " as SELECT " &
		+ " id_sped_free" & 
		+ " ,data_bolla_out " & 
		+ " ,trim(num_bolla_out) num_bolla_out " &  
		+ " ,clie_2     " & 
		+ " ,clie_3     " &  
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
		+ " , x_datins " &
		+ " , coalesce(x_utente, '') x_utente" &
		+ " FROM sped_free " 

//				+ " ,JSON_VALUE(dati ,'$.iva') iva " & 

	EXECUTE IMMEDIATE "drop VIEW v_sped_free " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(kkg.pointer_default)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_sped_free): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
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
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_sped_free' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(kkg.pointer_default)

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

