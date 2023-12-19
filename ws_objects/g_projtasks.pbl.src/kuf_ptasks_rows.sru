$PBExportHeader$kuf_ptasks_rows.sru
forward
global type kuf_ptasks_rows from kuf_parent
end type
end forward

global type kuf_ptasks_rows from kuf_parent
end type
global kuf_ptasks_rows kuf_ptasks_rows

type variables

end variables

forward prototypes
public subroutine _readme ()
public function boolean tb_delete_x_id_ptask (st_tab_ptasks_rows ast_tab_ptasks_rows) throws uo_exception
public function boolean tb_delete (st_tab_ptasks_rows ast_tab_ptasks_rows) throws uo_exception
public subroutine if_isnull (ref st_tab_ptasks_rows ast_tab_ptasks_rows)
private function st_esito tb_update_json (ref st_tab_ptasks_rows kst_tab_ptasks_rows) throws uo_exception
public function st_esito tb_insert (ref st_tab_ptasks_rows ast_tab_ptasks_rows) throws uo_exception
public function long get_id_ptasks_row_max (st_tab_ptasks_rows ast_tab_ptasks_rows) throws uo_exception
public function st_esito tb_update (ref st_tab_ptasks_rows ast_tab_ptasks_rows) throws uo_exception
public function long get_id_ptasks_row (st_tab_ptasks_rows ast_tab_ptasks_rows) throws uo_exception
private subroutine tb_update_json_field (st_tab_ptasks_rows ast_tab_ptasks_rows, ref string a_json_key, string a_json_val) throws uo_exception
public subroutine set_valid_modaccompdata (ref st_tab_ptasks_rows kst_tab_ptasks_rows) throws uo_exception
public function string set_valid_modaccomprogr (ref st_tab_ptasks_rows kst_tab_ptasks_rows) throws uo_exception
public function long get_valid_modaccompn_last_by_base () throws uo_exception
public function long get_cs_invoicen_last_by_base () throws uo_exception
public subroutine set_cs_invoicen_last_in_base (ref st_tab_ptasks_rows ast_tab_ptasks_rows) throws uo_exception
public subroutine set_valid_modaccompn_last_in_base (ref st_tab_ptasks_rows ast_tab_ptasks_rows, integer a_anno_modulo) throws uo_exception
end prototypes

public subroutine _readme ();//
//--- Righe dettaglio Attività del Progetto
//
end subroutine

public function boolean tb_delete_x_id_ptask (st_tab_ptasks_rows ast_tab_ptasks_rows) throws uo_exception;//
//------------------------------------------------------------------
//--- Cancella le Righe Attività del Progetto (ptasks_rows)
//--- 
//--- inp: st_tab_ptasks_rows.id_ptask
//--- rit: true = rimosso
//--- 
//--- 
//------------------------------------------------------------------
boolean k_return
st_esito kst_esito



try
	kst_esito = kguo_exception.inizializza(this.classname())

	delete from ptasks_rows
		where id_ptask = :ast_tab_ptasks_rows.id_ptask
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in Cancellazione di tutte le Attività del Progetto n. " &
						+ string(ast_tab_ptasks_rows.id_ptask) + ": " &
						+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)							
		throw kguo_exception
	end if

	if ast_tab_ptasks_rows.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_ptasks_rows.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if

	k_return = true
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try

return k_return

end function

public function boolean tb_delete (st_tab_ptasks_rows ast_tab_ptasks_rows) throws uo_exception;//
//------------------------------------------------------------------
//--- Cancella Riga Attività Progetti (ptasks_rows)
//--- 
//--- inp: st_tab_ptasks_rows.id_ptask_row
//--- rit: true = rimosso
//--- 
//--- 
//------------------------------------------------------------------
boolean k_return
st_esito kst_esito



try
	kst_esito = kguo_exception.inizializza(this.classname())

	delete from ptasks_rows
		where id_ptasks_row = :ast_tab_ptasks_rows.id_ptasks_row
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in Cancellazione nel Progetto dell'Attività n. " &
						+ string(ast_tab_ptasks_rows.id_ptasks_row) + ": " &
						+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)							
		throw kguo_exception
	end if

	if ast_tab_ptasks_rows.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_ptasks_rows.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if

	k_return = true
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try

return k_return

end function

public subroutine if_isnull (ref st_tab_ptasks_rows ast_tab_ptasks_rows);//---
//--- toglie i NULL ai campi della tabella 
//---
st_tab_ptasks_rows kst_tab_ptasks_rows

if isnull(ast_tab_ptasks_rows.id_ptask) then ast_tab_ptasks_rows.id_ptask = 0
if isnull(ast_tab_ptasks_rows.id_ptasks_row) then ast_tab_ptasks_rows.id_ptasks_row = 0
if isnull(ast_tab_ptasks_rows.id_ptasks_type) then ast_tab_ptasks_rows.id_ptasks_type = 0
if isnull(ast_tab_ptasks_rows.data_json) then ast_tab_ptasks_rows.data_json = "[]"
if isnull(ast_tab_ptasks_rows.x_utente) then ast_tab_ptasks_rows.x_utente = ""
if isnull(ast_tab_ptasks_rows.x_datins) then ast_tab_ptasks_rows.x_datins = datetime(kkg.data_no)
   
if isnull(ast_tab_ptasks_rows.valid_modaccomprogr) then ast_tab_ptasks_rows.valid_modaccomprogr = kst_tab_ptasks_rows.valid_modaccomprogr
if isnull(ast_tab_ptasks_rows.valid_proddescr) then ast_tab_ptasks_rows.valid_proddescr = kst_tab_ptasks_rows.valid_proddescr   
if isnull(ast_tab_ptasks_rows.valid_prodlotto) then ast_tab_ptasks_rows.valid_prodlotto = kst_tab_ptasks_rows.valid_prodlotto	  
if isnull(ast_tab_ptasks_rows.valid_laboratorio) then ast_tab_ptasks_rows.valid_laboratorio = kst_tab_ptasks_rows.valid_laboratorio  
if isnull(ast_tab_ptasks_rows.valid_qaa) then ast_tab_ptasks_rows.valid_qaa = kst_tab_ptasks_rows.valid_qaa 
if isnull(ast_tab_ptasks_rows.valid_campioniqta) then ast_tab_ptasks_rows.valid_campioniqta = kst_tab_ptasks_rows.valid_campioniqta  
if isnull(ast_tab_ptasks_rows.valid_offertarif) then ast_tab_ptasks_rows.valid_offertarif = kst_tab_ptasks_rows.valid_offertarif 
if isnull(ast_tab_ptasks_rows.valid_attivitacod) then ast_tab_ptasks_rows.valid_attivitacod = kst_tab_ptasks_rows.valid_attivitacod  
if isnull(ast_tab_ptasks_rows.valid_speddata) then ast_tab_ptasks_rows.valid_speddata = kst_tab_ptasks_rows.valid_speddata
if isnull(ast_tab_ptasks_rows.valid_finepresuntadata) then ast_tab_ptasks_rows.valid_finepresuntadata = kst_tab_ptasks_rows.valid_finepresuntadata 
if isnull(ast_tab_ptasks_rows.valid_laboratoriocertifn) then ast_tab_ptasks_rows.valid_laboratoriocertifn = kst_tab_ptasks_rows.valid_laboratoriocertifn  
if isnull(ast_tab_ptasks_rows.valid_laboratoriocertifdata) then ast_tab_ptasks_rows.valid_laboratoriocertifdata = kst_tab_ptasks_rows.valid_laboratoriocertifdata   
if isnull(ast_tab_ptasks_rows.valid_laboratoriocertif1n) then ast_tab_ptasks_rows.valid_laboratoriocertif1n = kst_tab_ptasks_rows.valid_laboratoriocertif1n  
if isnull(ast_tab_ptasks_rows.valid_laboratoriocertif1data) then ast_tab_ptasks_rows.valid_laboratoriocertif1data = kst_tab_ptasks_rows.valid_laboratoriocertif1data   
if isnull(ast_tab_ptasks_rows.valid_dose) then ast_tab_ptasks_rows.valid_dose = kst_tab_ptasks_rows.valid_dose    
if isnull(ast_tab_ptasks_rows.valid_dose_min) then ast_tab_ptasks_rows.valid_dose_min = kst_tab_ptasks_rows.valid_dose_min  
if isnull(ast_tab_ptasks_rows.valid_dose_max) then ast_tab_ptasks_rows.valid_dose_max = kst_tab_ptasks_rows.valid_dose_max  
if isnull(ast_tab_ptasks_rows.valid_notereport) then ast_tab_ptasks_rows.valid_notereport= kst_tab_ptasks_rows.valid_notereport 
	
end subroutine

private function st_esito tb_update_json (ref st_tab_ptasks_rows kst_tab_ptasks_rows) throws uo_exception;//
//====================================================================
//=== Update/Insert the row in  ptasks_rows campo JSON
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
int k_idx, k_idx_max, k_insert
string k_json_key[100]
string k_json_val[100]
string k_json_all
st_esito kst_esito
kuf_utility kuf1_utility

	try
		kst_esito = kguo_exception.inizializza(this.classname())
		kuf1_utility = create kuf_utility
		
		if kst_tab_ptasks_rows.id_ptasks_row > 0 then
	
	//--- pulizia di tutto il campo JSON
			update ptasks_rows
				 set data_json = '{"cs":{}, "acc":{}, "valid":{}, "approvv":{}}'
						where id_ptasks_row = :kst_tab_ptasks_rows.id_ptasks_row
						using kguo_sqlca_db_magazzino ;
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Fallito Aggiornamento 'Dati Attività di dettaglio Progetto'. Id riga " + string(kst_tab_ptasks_rows.id_ptasks_row) &
							+ ", pulizia area dati (ptasks_rows): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

	//--- compone i campi JSON		
		//	kst_tab_ptasks_rows.data_json = "
			k_idx_max = 0
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "qta"; if kst_tab_ptasks_rows.cs_qta > 0 then k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_qta))
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "prezzo"; if kst_tab_ptasks_rows.cs_prezzo > 0 then k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_ptasks_rows.cs_prezzo)), false)
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "clienteddtn"; k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.cs_clienteddtn)
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "usdqta"; if kst_tab_ptasks_rows.cs_usdqta > 0 then k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_usdqta))
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "usdprezzo"; if kst_tab_ptasks_rows.cs_usdprezzo > 0 then k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_ptasks_rows.cs_usdprezzo)), false)
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "pesonettoxlottokg"; if kst_tab_ptasks_rows.cs_pesonettoxlottokg > 0 then k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_ptasks_rows.cs_pesonettoxlottokg)), false)
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "custcode "; k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.cs_custcode)
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "qtabox"; if kst_tab_ptasks_rows.cs_qtabox > 0 then k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_qtabox))
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "trackitusn"; k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.cs_trackitusn)
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "trackusitn"; k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.cs_trackusitn)
			if isdate(string(kst_tab_ptasks_rows.cs_speddata)) and kst_tab_ptasks_rows.cs_speddata > kkg.data_no then
				k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "speddata"; k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_speddata))
			end if
			if isdate(string(kst_tab_ptasks_rows.cs_charlottedatain)) and kst_tab_ptasks_rows.cs_charlottedatain > kkg.data_no then
				k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "charlottedatain"; k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_charlottedatain))
			end if
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "charlottewo"; if kst_tab_ptasks_rows.cs_charlottewo > 0 then k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_charlottewo))
			if isdate(string(kst_tab_ptasks_rows.cs_charlottewodata)) and kst_tab_ptasks_rows.cs_charlottewodata > kkg.data_no then
				k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "charlottewodata"; k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_charlottewodata))
			end if
			if isdate(string(kst_tab_ptasks_rows.cs_datarientro)) and kst_tab_ptasks_rows.cs_datarientro > kkg.data_no then
				k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "datarientro"; k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_datarientro))
			end if
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "e1so"; k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.cs_e1so)
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "e1sofattura"; if kst_tab_ptasks_rows.cs_e1sofattura > 0 then k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_e1sofattura ))
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "e1ancillary"; k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.cs_e1ancillary)
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "stgfatturan"; if kst_tab_ptasks_rows.cs_stgfatturan > 0 then k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_stgfatturan))
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "stgfatturadata"; 
			if isdate(string(kst_tab_ptasks_rows.cs_stgfatturadata)) and kst_tab_ptasks_rows.cs_stgfatturadata > kkg.data_no then
				k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_stgfatturadata))
			else
			 	setnull(k_json_val[k_idx_max]) 
			end if
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "stgfatturaimporto"; if kst_tab_ptasks_rows.cs_stgfatturaimporto > 0 then k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_ptasks_rows.cs_stgfatturaimporto)), false)
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "stgddtn"; if kst_tab_ptasks_rows.cs_stgddtn > 0 then k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_stgddtn))
			if isdate(string(kst_tab_ptasks_rows.cs_stgddtdata)) and kst_tab_ptasks_rows.cs_stgddtdata > kkg.data_no then
				k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "stgddtdata"; k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_stgddtdata))
			end if
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "docfinen"; k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_docfinen ))
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "notefatt"; k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_notefatt ))
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "ordine"; k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_ordine ))
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "invoicen"; if kst_tab_ptasks_rows.cs_invoicen > 0 then k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_invoicen))
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "invoice_id_cliente"; if kst_tab_ptasks_rows.cs_invoice_id_cliente > 0 then k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_invoice_id_cliente))
			if isdate(string(kst_tab_ptasks_rows.cs_invoicedata)) and kst_tab_ptasks_rows.cs_invoicedata > kkg.data_no then
				k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "invoicedata"; k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_invoicedata))
			end if
			if isdate(string(kst_tab_ptasks_rows.cs_invoicefirmadata)) and kst_tab_ptasks_rows.cs_invoicefirmadata > kkg.data_no then
				k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "invoicefirmadata"; k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_invoicefirmadata))
			end if
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "invoicefirmanome"; k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_invoicefirmanome))
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "invoicefirmaruolo"; k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_invoicefirmaruolo))
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "invoiceorigin"; k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_invoiceorigin))
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "invoiceproducer"; k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_invoiceproducer))
			k_idx_max ++; k_json_key[k_idx_max] = "$.cs." + "invoiceproduceraddress"; k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.cs_invoiceproduceraddress))

			if isdate(string(kst_tab_ptasks_rows.acc_arrivodata)) and kst_tab_ptasks_rows.acc_arrivodata > kkg.data_no then
				k_idx_max ++; k_json_key[k_idx_max] = "$.acc." + "arrivodata";	k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.acc_arrivodata))				
			end if
			k_idx_max ++; k_json_key[k_idx_max] = "$.acc." + "e1wo"; if kst_tab_ptasks_rows.acc_e1wo > 0 then k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.acc_e1wo))
			k_idx_max ++; k_json_key[k_idx_max] = "$.acc." + "pesolordoxlottokg"; if kst_tab_ptasks_rows.acc_pesolordoxlottokg > 0.00 then k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_ptasks_rows.acc_pesolordoxlottokg)), false)
			k_idx_max ++; k_json_key[k_idx_max] = "$.acc." + "dhlbox";k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.acc_dhlbox)
			k_idx_max ++; k_json_key[k_idx_max] = "$.acc." + "boxdimcm";k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.acc_boxdimcm)
			
			k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "modaccompn"; if kst_tab_ptasks_rows.valid_modaccompn > 0 then k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.valid_modaccompn))
			k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "modaccomprogr";k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.valid_modaccomprogr)
			if isdate(string(kst_tab_ptasks_rows.valid_modaccompdata)) and kst_tab_ptasks_rows.valid_modaccompdata > kkg.data_no then
				k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "modaccompdata";	k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.valid_modaccompdata))				
			end if
			k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "modaccompqtadescr";k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.valid_modaccompqtadescr)
			k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "proddescr";k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.valid_proddescr)
			k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "proddescr_eng";k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.valid_proddescr_eng)
			k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "prodlotto";k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.valid_prodlotto)
			k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "laboratorio";k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.valid_laboratorio)
			k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "qaa";k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.valid_qaa)
			k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "campioniqta"; if kst_tab_ptasks_rows.valid_campioniqta > 0 then k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.valid_campioniqta))
			k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "offertarif";k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.valid_offertarif)
			k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "attivitacod";k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.valid_attivitacod)
			if isdate(string(kst_tab_ptasks_rows.valid_speddata)) and kst_tab_ptasks_rows.valid_speddata > kkg.data_no then
				k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "speddata";	k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.valid_speddata))
			end if
			if isdate(string(kst_tab_ptasks_rows.valid_finepresuntadata)) and kst_tab_ptasks_rows.valid_finepresuntadata > kkg.data_no then
				k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "finepresuntadata"; k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.valid_finepresuntadata))
			end if
			k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "laboratoriocertifn";k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.valid_laboratoriocertifn)
			if isdate(string(kst_tab_ptasks_rows.valid_laboratoriocertifdata)) and kst_tab_ptasks_rows.valid_laboratoriocertifdata > kkg.data_no then
				k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "laboratoriocertifdata"; k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.valid_laboratoriocertifdata))
			end if
			k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "laboratoriocertif1n";k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.valid_laboratoriocertif1n)
			if isdate(string(kst_tab_ptasks_rows.valid_laboratoriocertif1data)) and kst_tab_ptasks_rows.valid_laboratoriocertif1data > kkg.data_no then
				k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "laboratoriocertif1data"; k_json_val[k_idx_max] = trim(string(kst_tab_ptasks_rows.valid_laboratoriocertif1data))
			end if
			k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "dose"; if kst_tab_ptasks_rows.valid_dose > 0 then k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_ptasks_rows.valid_dose)), false)
			k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "dose_min"; if kst_tab_ptasks_rows.valid_dose_min > 0 then k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_ptasks_rows.valid_dose_min)), false)
			k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "dose_max"; if kst_tab_ptasks_rows.valid_dose_max > 0 then k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_ptasks_rows.valid_dose_max)), false)
			k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "notereport";k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.valid_notereport)
			k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "noterifpo";k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.valid_noterifpo)
			k_idx_max ++; k_json_key[k_idx_max] = "$.valid." + "notealtre";k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.valid_notealtre)			
			
			k_idx_max ++; k_json_key[k_idx_max] = "$.approvv." + "stgcharlfattinterc";k_json_val[k_idx_max] = trim(kst_tab_ptasks_rows.approvv_stgcharlfattinterc)

			kguo_sqlca_db_magazzino.sqlcode = 0
			k_idx = 0
			do while k_idx < k_idx_max and kguo_sqlca_db_magazzino.sqlcode = 0 
				k_idx ++
				
				if k_json_val[k_idx] > " " then
					update ptasks_rows
						 set data_json = replace(JSON_MODIFY(data_json, :k_json_key[k_idx], :k_json_val[k_idx]), '\/', '/')
						where id_ptasks_row = :kst_tab_ptasks_rows.id_ptasks_row
						using kguo_sqlca_db_magazzino ;
				end if
				
			loop
			
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Fallito Aggiornamento 'Dati Attività di dettaglio Progetto'. Id riga: " + string(kst_tab_ptasks_rows.id_ptasks_row) &
								+ ", campo: " + k_json_key[k_idx] &
								+ " valore: "+ k_json_val[k_idx] + " (ptasks_rows). " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

			if kst_tab_ptasks_rows.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_ptasks_rows.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			
		end if
		
	catch	(uo_exception kuo_exception)
		kuo_exception.scrivi_log( )
		if kuo_exception.kist_esito.esito = kkg_esito.db_ko then
			if kst_tab_ptasks_rows.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_ptasks_rows.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		end if
		throw kuo_exception
	
	finally
		if isvalid(kuf1_utility) then destroy kuf1_utility
	
	end try
		


return kst_esito

end function

public function st_esito tb_insert (ref st_tab_ptasks_rows ast_tab_ptasks_rows) throws uo_exception;//
//====================================================================
//=== Insert new row in  id_ptasks_row 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
st_tab_ptasks_rows kst_tab_ptasks_rows


	try
		kst_esito = kguo_exception.inizializza(this.classname())
	
//--- controlla se utente autorizzato alla funzione in atto
	//	if_sicurezza(kkg_flag_modalita.inserimento )
	
		if_isnull(ast_tab_ptasks_rows)
		ast_tab_ptasks_rows.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_ptasks_rows.x_utente = kGuf_data_base.prendi_x_utente()

//--- aggiorna altri dati non JSON 
		insert into ptasks_rows
					  	(id_ptask 
					  	, id_ptasks_type 
					 	, x_datins 
						, x_utente )
					values (
					  	:ast_tab_ptasks_rows.id_ptask
					   , :ast_tab_ptasks_rows.id_ptasks_type
					 	, :ast_tab_ptasks_rows.x_datins
						, :ast_tab_ptasks_rows.x_utente)
					using kguo_sqlca_db_magazzino ;
					
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Fallito Inserimento nuova 'Dati Attività di dettaglio Progetto' " &
							+ ", dati generici (ptasks_rows): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		ast_tab_ptasks_rows.id_ptasks_row = get_id_ptasks_row_max(ast_tab_ptasks_rows)
					
//--- aggiorna i dati del Contratto (JSON)
		kst_tab_ptasks_rows = ast_tab_ptasks_rows
		kst_tab_ptasks_rows.st_tab_g_0.esegui_commit = "N"
		tb_update_json(kst_tab_ptasks_rows)

		kst_tab_ptasks_rows.st_tab_g_0.esegui_commit = ast_tab_ptasks_rows.st_tab_g_0.esegui_commit
		ast_tab_ptasks_rows = kst_tab_ptasks_rows

		if ast_tab_ptasks_rows.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_ptasks_rows.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
			
	catch	(uo_exception kuo_exception)
		if kuo_exception.kist_esito.esito = kkg_esito.db_ko then
			if ast_tab_ptasks_rows.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_ptasks_rows.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			kguo_exception.scrivi_log( )
		end if
		throw kuo_exception
	
	finally
	
	end try
		
return kst_esito

end function

public function long get_id_ptasks_row_max (st_tab_ptasks_rows ast_tab_ptasks_rows) throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo id_ptasks_row per il Progetto id_ptasks inserito 
//--- 
//---  input: ID_PTASK
//---  ret: max id_ptasks_row
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	SELECT coalesce(max(id_ptasks_row), 0)
		 INTO 
				:k_return
		 FROM ptasks_rows  
		 where ID_PTASK = :ast_tab_ptasks_rows.ID_PTASK
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo N. Attività del Progetto " + string(ast_tab_ptasks_rows.ID_PTASK) + " inserito in tabella (ptasks_rows)" &
									 + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if isnull(k_return) then k_return = 0
	else
		k_return = 0
	end if
	

return k_return

end function

public function st_esito tb_update (ref st_tab_ptasks_rows ast_tab_ptasks_rows) throws uo_exception;//
//====================================================================
//=== Update the row in  ptasks_rows 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
st_tab_ptasks_rows kst_tab_ptasks_rows


	try
		kst_esito = kguo_exception.inizializza(this.classname())
	
//--- controlla se utente autorizzato alla funzione in atto
	//	if_sicurezza(kkg_flag_modalita.modifica )
	
		if ast_tab_ptasks_rows.id_ptasks_row > 0 then
	
			if_isnull(ast_tab_ptasks_rows)

			ast_tab_ptasks_rows.x_datins = kGuf_data_base.prendi_x_datins()
			ast_tab_ptasks_rows.x_utente = kGuf_data_base.prendi_x_utente()

//--- aggiorna i dati del Contratto (JSON)
			kst_tab_ptasks_rows = ast_tab_ptasks_rows
			kst_tab_ptasks_rows.st_tab_g_0.esegui_commit = "N"
			tb_update_json(kst_tab_ptasks_rows)
			
			kst_tab_ptasks_rows.st_tab_g_0.esegui_commit = ast_tab_ptasks_rows.st_tab_g_0.esegui_commit
			ast_tab_ptasks_rows = kst_tab_ptasks_rows

//--- aggiorna altri dati non JSON 
			update ptasks_rows
					 set 
					  	id_ptask = :ast_tab_ptasks_rows.id_ptask
					   , id_ptasks_type = :ast_tab_ptasks_rows.id_ptasks_type
					 	, x_datins = :ast_tab_ptasks_rows.x_datins
						, x_utente = :ast_tab_ptasks_rows.x_utente
					where id_ptasks_row = :ast_tab_ptasks_rows.id_ptasks_row
					using kguo_sqlca_db_magazzino ;
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Fallito Aggiornamento 'Dati Attività di dettaglio Progetto'. Id riga: " + string(ast_tab_ptasks_rows.id_ptasks_row) &
								+ ", dati vari e di ultimo aggiornamento (ptasks_rows): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

			if ast_tab_ptasks_rows.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_ptasks_rows.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			
		end if
		
	catch	(uo_exception kuo_exception)
		if kuo_exception.kist_esito.esito = kkg_esito.db_ko then
			if ast_tab_ptasks_rows.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_ptasks_rows.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			kguo_exception.scrivi_log( )
		end if
		throw kuo_exception
	
	finally
	
	end try
		


return kst_esito

end function

public function long get_id_ptasks_row (st_tab_ptasks_rows ast_tab_ptasks_rows) throws uo_exception;//
//------------------------------------------------------------------
//--- Torna id_ptasks_row per il Progetto id_ptasks inserito 
//--- 
//---  input: ID_PTASK + ID_PTASKS_TYPE
//---  ret: id_ptasks_row
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	SELECT coalesce(id_ptasks_row, 0)
		 INTO 
				:k_return
		 FROM ptasks_rows  
		 where ID_PTASK = :ast_tab_ptasks_rows.ID_PTASK
		    and ID_PTASKS_TYPE = :ast_tab_ptasks_rows.ID_PTASKS_TYPE
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura N. Attività del Progetto n. " + string(ast_tab_ptasks_rows.ID_PTASK) &
										+ " Attività n. " + string(ast_tab_ptasks_rows.ID_PTASKS_TYPE) &
										+ ", (ptasks_rows)." &
									 	+ kkg.acapo  + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if isnull(k_return) then k_return = 0
	else
		k_return = 0
	end if
	

return k_return

end function

private subroutine tb_update_json_field (st_tab_ptasks_rows ast_tab_ptasks_rows, ref string a_json_key, string a_json_val) throws uo_exception;//
//====================================================================
//=== Aggiorna campo 'modaccompdata' in  ptasks_rows (campo JSON)
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito


	try
		kst_esito = kguo_exception.inizializza(this.classname())
		
		if ast_tab_ptasks_rows.id_ptasks_row > 0 then
	
			update ptasks_rows
					 set data_json = replace(JSON_MODIFY(data_json, :a_json_key, :a_json_val), '\/', '/')
					where id_ptasks_row = :ast_tab_ptasks_rows.id_ptasks_row
					using kguo_sqlca_db_magazzino ;
				
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				if isnull(a_json_val) then a_json_val = "NULLO"
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Fallito Aggiornamento riga Progetto '" + string(ast_tab_ptasks_rows.id_ptasks_row) &
								+ ", campo: " + a_json_key + "' " &
								+ "valore: '"+ a_json_val + "' (tab.ptasks_rows). " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

			if ast_tab_ptasks_rows.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_ptasks_rows.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			
		end if
		
	catch	(uo_exception kuo_exception)
		if kuo_exception.kist_esito.esito = kkg_esito.db_ko then
			if ast_tab_ptasks_rows.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_ptasks_rows.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			kuo_exception.scrivi_log( )
		end if
		throw kuo_exception
	
	finally

	
	end try
		

end subroutine

public subroutine set_valid_modaccompdata (ref st_tab_ptasks_rows kst_tab_ptasks_rows) throws uo_exception;//
//====================================================================
//=== Aggiorna campo 'modaccompdata' in  ptasks_rows (campo JSON)
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
string k_json_key
string k_json_val


	try
		
		if kst_tab_ptasks_rows.id_ptasks_row > 0 then
	
			if isdate(string(kst_tab_ptasks_rows.valid_modaccompdata)) and kst_tab_ptasks_rows.valid_modaccompdata > kkg.data_no then
				k_json_key = "$.valid." + "modaccompdata"
				k_json_val = trim(string(kst_tab_ptasks_rows.valid_modaccompdata))				
			else
			 	setnull(k_json_val) 
			end if
				
			tb_update_json_field(kst_tab_ptasks_rows, k_json_key, k_json_val)

		end if
		
	catch	(uo_exception kuo_exception)
		throw kuo_exception
	
	finally

	
	end try

end subroutine

public function string set_valid_modaccomprogr (ref st_tab_ptasks_rows kst_tab_ptasks_rows) throws uo_exception;//
//====================================================================
//=== Aggiorna campo 'modaccomprogr' in  ptasks_rows (campo JSON)
//=== 
//=== Inp: valid_modaccompn + valid_modaccompdata
//=== Out: valid_modaccomprogr 
//===           	
//====================================================================
//
string k_json_key
string k_json_val


	try
		
		if kst_tab_ptasks_rows.id_ptasks_row > 0 then
			
			kst_tab_ptasks_rows.valid_modaccomprogr = string(kst_tab_ptasks_rows.valid_modaccompn, "#") &
																	+ "/" + string(kst_tab_ptasks_rows.valid_modaccompdata, "yyyy")
	
			if trim(string(kst_tab_ptasks_rows.valid_modaccomprogr)) > " " then
				k_json_key = "$.valid." + "modaccomprogr"
				k_json_val = trim(string(kst_tab_ptasks_rows.valid_modaccomprogr))				
			else
			 	setnull(k_json_val) 
			end if
				
			tb_update_json_field(kst_tab_ptasks_rows, k_json_key, k_json_val)

		end if
		
	catch	(uo_exception kuo_exception)
		throw kuo_exception
	
	finally

	end try
	
return kst_tab_ptasks_rows.valid_modaccomprogr

end function

public function long get_valid_modaccompn_last_by_base () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo numero del Modulo Laboratorio dal BASE
//--- 
//---  input: 
//---  ret: valid_modaccompn
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito
string k_esito_base
kuf_base kuf1_base


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	kuf1_base = create kuf_base
	k_esito_base = kuf1_base.prendi_dato_base( "ptasks_valid_modaccompn")
	if left(k_esito_base,1) <> "0" then
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.SQLErrText = "Errore in lettura da Proprietà di 'ultimo N. Modulo di Accomp. Laboratorio' " &
									 + "~n~r"  + trim(mid(k_esito_base,2))
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		k_return = long(mid(k_esito_base,2))
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_base) then destroy kuf1_base

end try

return k_return

end function

public function long get_cs_invoicen_last_by_base () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo numero della Fattura dal BASE
//--- 
//---  input: 
//---  ret: ptasks_cs_invoicen
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito
string k_esito_base
kuf_base kuf1_base


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	kuf1_base = create kuf_base
	k_esito_base = kuf1_base.prendi_dato_base( "ptasks_cs_invoicen")
	if left(k_esito_base,1) <> "0" then
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.SQLErrText = "Errore in lettura da Proprietà di 'ultimo N. Fattura' per i Progetti. " &
									 + "~n~r"  + trim(mid(k_esito_base,2))
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		k_return = long(mid(k_esito_base,2))
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_base) then destroy kuf1_base

end try

return k_return

end function

public subroutine set_cs_invoicen_last_in_base (ref st_tab_ptasks_rows ast_tab_ptasks_rows) throws uo_exception;//
//------------------------------------------------------------------
//--- Registra numero della Fattura nel BASE
//--- 
//---  input: ast_tab_ptasks_rows.cs_invoicen
//---  ret: 
//---                                     
//------------------------------------------------------------------
//
long k_long
st_tab_base kst_tab_base
st_esito kst_esito
string k_esito_base
kuf_base kuf1_base


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	k_long = get_cs_invoicen_last_by_base( )
	
//--- aggiorna solo se è più grande 	
	if k_long > ast_tab_ptasks_rows.cs_invoicen then
	else
		kuf1_base = create kuf_base
		kst_tab_base.st_tab_g_0.esegui_commit = "S"
		kst_tab_base.key = "ptasks_cs_invoicen"
		kst_tab_base.key1 = string(ast_tab_ptasks_rows.cs_invoicen)
		kst_esito  = kuf1_base.metti_dato_base(kst_tab_base)
		if kst_esito.esito = kkg_esito.db_ko then
			kst_esito.SQLErrText = "Errore in aggiornamento in Proprietà di 'ultimo N. Fattura' di Progetti al n. '" &
										+ string(ast_tab_ptasks_rows.cs_invoicen) + "'" &
										+ "~n~r"  + trim(kst_esito.SQLErrText)
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
	

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_base) then destroy kuf1_base

end try

end subroutine

public subroutine set_valid_modaccompn_last_in_base (ref st_tab_ptasks_rows ast_tab_ptasks_rows, integer a_anno_modulo) throws uo_exception;//
//------------------------------------------------------------------
//--- Registra numero del Modulo Laboratorio nel BASE
//--- 
//---  input: ast_tab_ptasks_rows.valid_modaccompn
//---  ret: 
//---                                     
//------------------------------------------------------------------
//
long k_long
st_tab_base kst_tab_base
st_esito kst_esito
string k_esito_base
kuf_base kuf1_base


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	k_long = get_valid_modaccompn_last_by_base( )
	
//--- aggiorna solo se è più grande 	
	if ast_tab_ptasks_rows.valid_modaccompn > k_long then
		// aggiorna se è dello stesso anno oppure se sono a + 1 rispetto all'ultimo 
		if a_anno_modulo = kguo_g.get_anno_procedura( ) or ast_tab_ptasks_rows.valid_modaccompn = (k_long + 1) then
		
			kuf1_base = create kuf_base
			kst_tab_base.st_tab_g_0.esegui_commit = "S"
			kst_tab_base.key = "ptasks_valid_modaccompn"
			kst_tab_base.key1 = string(ast_tab_ptasks_rows.valid_modaccompn)
			kst_esito  = kuf1_base.metti_dato_base(kst_tab_base)
			if kst_esito.esito = kkg_esito.db_ko then
				kst_esito.SQLErrText = "Errore in aggiornamento in Proprietà di 'ultimo N. Modulo di Accomp. Laboratorio' a '" &
											+ string(ast_tab_ptasks_rows.valid_modaccompn) + "'" &
											+ "~n~r"  + trim(kst_esito.SQLErrText)
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			
		end if
	end if
	

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_base) then destroy kuf1_base

end try

end subroutine

on kuf_ptasks_rows.create
call super::create
end on

on kuf_ptasks_rows.destroy
call super::destroy
end on

