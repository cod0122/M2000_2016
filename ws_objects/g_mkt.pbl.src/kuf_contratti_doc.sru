﻿$PBExportHeader$kuf_contratti_doc.sru
forward
global type kuf_contratti_doc from kuf_parent
end type
end forward

global type kuf_contratti_doc from kuf_parent
end type
global kuf_contratti_doc kuf_contratti_doc

type variables
//
//
private constant string kki_form_di_stampa_attuale = "d_contratti_doc_st0_ed220401"  //"d_contratti_doc_st0_ed190401" 
private kuf_esito_operazioni kiuf_esito_operazioni

//---- campo STATO contratto
constant string kki_STATO_nuovo = '1' // nuovo contratto
constant string kki_STATO_riaperto = '2' // contratto Riaperto
constant string kki_STATO_stampato = '3' // contratto stampato definitivamente
constant string kki_STATO_accettato = '5' // contratto Accettato dal cliente
constant string kki_STATO_respinto = '6' // contratto NON Accettato dal cliente
constant string kki_STATO_trasferito = '7' // contratto Trasferito al LISTINO/CONTRATTI
constant string kki_STATO_annullato = '9' // contratto ANNULLATO




end variables

forward prototypes
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_contratti_doc kst_tab_contratti_doc)
public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_contratti_doc kst_tab_contratti_doc)
public subroutine if_isnull (ref st_tab_contratti_doc kst_tab_contratti_doc)
public function st_esito get_dati_default (ref st_tab_contratti_doc kst_tab_contratti_doc)
public function st_esito get_ultimo_cliente_anno (ref st_tab_contratti_doc kst_tab_contratti_doc)
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function st_esito stampa_documento_definitiva (st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception
public function st_esito stampa_documento_prova (st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception
public function st_esito get_id_cliente (ref st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception
public function boolean set_id_docprod (st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception
public function long aggiorna_docprod (ref st_tab_contratti_doc kst_tab_contratti_doc[]) throws uo_exception
public function st_esito get_offerta_data (ref st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception
public function long stampa_esporta_digitale (st_docprod_esporta kst_docprod_esporta) throws uo_exception
public function boolean if_esiste (st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception
private function st_esito set_stato (ref st_tab_contratti_doc kst_tab_contratti_doc)
private function boolean set_form_di_stampa (st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception
private function boolean set_data_stampa (st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception
public function st_esito set_trasferito (st_tab_contratti_doc kst_tab_contratti_doc)
private function st_esito set_ts_esito_operazione (ref st_tab_contratti_doc kst_tab_contratti_doc)
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
public subroutine log_destroy ()
public subroutine log_inizializza () throws uo_exception
private function st_esito stampa_documento_print (ref datastore kds_print, st_tab_contratti_doc ast_tab_contratti_doc)
private function st_esito stampa_documento (st_tab_contratti_doc ast_tab_contratti_doc) throws uo_exception
public function ds_contratti_doc_select get_dati (st_tab_contratti_doc kst_tab_contratti_doc)
public function st_esito set_dati_contratto_value (st_tab_contratti_doc kst_tab_contratti_doc, string a_key, string a_value) throws uo_exception
public function st_esito tb_insert (ref st_tab_contratti_doc ast_tab_contratti_doc) throws uo_exception
public function st_esito tb_update (ref st_tab_contratti_doc ast_tab_contratti_doc) throws uo_exception
private function st_esito tb_update_json (ref st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception
public function long u_conv_to_conferma_ordine_e_listini (st_tab_contratti_doc kst_tab_contratti_doc, st_contratti_doc_to_listini kst_contratti_doc_to_listini) throws uo_exception
private function long u_conv_conferma_ordine_to_listino (ref datastore kds_contratti_doc, st_tab_contratti kst_tab_contratti, st_contratti_doc_to_listini kst_contratti_doc_to_listini) throws uo_exception
public function st_esito select_riga (ref st_tab_contratti_doc k_st_tab_contratti_doc) throws uo_exception
public function st_esito u_check_dati_val (ref datastore ads_inp) throws uo_exception
public function st_esito u_check_dati_irr (ref datastore ads_inp) throws uo_exception
private function long u_conv_conferma_ordine_to_listino_val (ref datastore kds_contratti_doc, st_tab_listino kst_tab_listino, st_contratti_doc_to_listini kst_contratti_doc_to_listini) throws uo_exception
private function long u_conv_conferma_ordine_to_listino_irr (ref datastore kds_contratti_doc, st_tab_listino kst_tab_listino, st_contratti_doc_to_listini kst_contratti_doc_to_listini) throws uo_exception
public function st_esito anteprima_dettaglio (ref datawindow kdw_anteprima, st_tab_contratti_doc kst_tab_contratti_doc)
public function st_esito anteprima_dettaglio (ref datastore kdw_anteprima, st_tab_contratti_doc kst_tab_contratti_doc)
public function string get_stato_descrizione (ref st_tab_contratti_doc kst_tab_contratti_doc)
public function string get_stato (ref st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception
public function long get_ultimo_id () throws uo_exception
public function boolean tb_delete (st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception
public function string get_form_di_stampa (ref st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception
end prototypes

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_contratti_doc kst_tab_contratti_doc);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore  di  anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_esito kst_esito
kuf_utility kuf1_utility


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	k_return = if_sicurezza(kkg_flag_modalita.anteprima)
	
	if not k_return then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	else
	
		if isvalid(kdw_anteprima)  then
			if kdw_anteprima.dataobject = "d_contratti_doc"  then
				if kdw_anteprima.object.id_contratto_doc[1] = kst_tab_contratti_doc.id_contratto_doc  then
					kst_tab_contratti_doc.id_contratto_doc = 0 
				end if
			end if
		end if
	
		if kst_tab_contratti_doc.id_contratto_doc > 0 then
		
			kdw_anteprima.dataobject = "d_contratti_doc"		
			kdw_anteprima.settransobject(sqlca)
	
			kdw_anteprima.reset()	
			k_rc=kdw_anteprima.retrieve(kst_tab_contratti_doc.id_contratto_doc)
		
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Contratto da visualizzare: ~n~r" + "nessun Codice indicato"
			kst_esito.esito = kkg_esito.bug
			
		end if
	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

end try

return kst_esito

end function

public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_contratti_doc kst_tab_contratti_doc);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_contratti

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if isvalid(kdw_anteprima)  then
		if kdw_anteprima.dataobject = "d_contratti_doc"  then
			if kdw_anteprima.object.id_contratto_doc[1] = kst_tab_contratti_doc.id_contratto_doc  then
				kst_tab_contratti_doc.id_contratto_doc = 0 
			end if
		end if
	end if

	if kst_tab_contratti_doc.id_contratto_doc > 0 then
	
			kdw_anteprima.dataobject = "d_contratti_doc"		
			kdw_anteprima.settransobject(sqlca)
	
			kuf1_utility = create kuf_utility
			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_contratti_doc.id_contratto_doc)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Contratto da visualizzare: ~n~r" + "nessun Codice indicato"
			kst_esito.esito = kkg_esito.bug
			
		end if
end if


return kst_esito

end function

public subroutine if_isnull (ref st_tab_contratti_doc kst_tab_contratti_doc);//---
//--- Inizializza i campi della tabella 
//---
int k_idx


if isnull(kst_tab_contratti_doc.id_contratto_doc ) then kst_tab_contratti_doc.id_contratto_doc = 0
if isnull(kst_tab_contratti_doc.abi ) then kst_tab_contratti_doc.abi = 0
if isnull(kst_tab_contratti_doc.altre_condizioni ) then kst_tab_contratti_doc.altre_condizioni = " "
if isnull(kst_tab_contratti_doc.anno ) then kst_tab_contratti_doc.anno = year(KG_DATAOGGI)
if isnull(kst_tab_contratti_doc.magazzino ) then kst_tab_contratti_doc.magazzino = kkg_magazzino.LAVORAZIONE
if isnull(kst_tab_contratti_doc.banca ) then kst_tab_contratti_doc.banca = " "
if isnull(kst_tab_contratti_doc.cab ) then kst_tab_contratti_doc.cab = 0
if isnull(kst_tab_contratti_doc.cod_pag ) then kst_tab_contratti_doc.cod_pag = 0
if isnull(kst_tab_contratti_doc.stampa_tradotta ) then kst_tab_contratti_doc.stampa_tradotta = ""
if isnull(kst_tab_contratti_doc.data_stampa ) then kst_tab_contratti_doc.data_stampa = date(0)
if isnull(kst_tab_contratti_doc.data_fine ) then kst_tab_contratti_doc.data_fine = date(0)
if isnull(kst_tab_contratti_doc.data_inizio ) then kst_tab_contratti_doc.data_inizio = date(0) //date(31, 12, year(KG_DATAOGGI) )

if isnull(kst_tab_contratti_doc.id_listino_pregruppo ) then kst_tab_contratti_doc.id_listino_pregruppo = 0

for k_idx = 1 to 10
	if isnull(kst_tab_contratti_doc.id_listino_voce[k_idx] ) then kst_tab_contratti_doc.id_listino_voce[k_idx] = 0
	if isnull(kst_tab_contratti_doc.voce_prezzo[k_idx] ) then kst_tab_contratti_doc.voce_prezzo[k_idx] = 0.00
	if isnull(kst_tab_contratti_doc.descr[k_idx] ) then kst_tab_contratti_doc.descr[k_idx] = " "
	if isnull(kst_tab_contratti_doc.voce_prezzo_tot[k_idx] ) then kst_tab_contratti_doc.voce_prezzo_tot[k_idx] = 0.00
	if isnull(kst_tab_contratti_doc.voce_qta[k_idx] ) then kst_tab_contratti_doc.voce_qta[k_idx] = 0
	if isnull(kst_tab_contratti_doc.flg_st_voce[k_idx] ) then kst_tab_contratti_doc.flg_st_voce[k_idx] = " "
next

if isnull(kst_tab_contratti_doc.fattura_da ) then kst_tab_contratti_doc.fattura_da = " "
if isnull(kst_tab_contratti_doc.gruppo ) then kst_tab_contratti_doc.gruppo = 0
if isnull(kst_tab_contratti_doc.id_clie_settore ) then kst_tab_contratti_doc.id_clie_settore = " "
if isnull(kst_tab_contratti_doc.id_cliente ) then kst_tab_contratti_doc.id_cliente = 0
if isnull(kst_tab_contratti_doc.art ) then kst_tab_contratti_doc.art = ""
if isnull(kst_tab_contratti_doc.iva ) then kst_tab_contratti_doc.iva = 0
if isnull(kst_tab_contratti_doc.nome_contatto ) then kst_tab_contratti_doc.nome_contatto = " "
if isnull(kst_tab_contratti_doc.note ) then kst_tab_contratti_doc.note = " "
if isnull(kst_tab_contratti_doc.note_audit ) then kst_tab_contratti_doc.note_audit = " "
if isnull(kst_tab_contratti_doc.offerta_data ) then kst_tab_contratti_doc.offerta_data = date(0)
if isnull(kst_tab_contratti_doc.offerta_validita ) then kst_tab_contratti_doc.offerta_validita = " "
if isnull(kst_tab_contratti_doc.oggetto ) then kst_tab_contratti_doc.oggetto = " " 
if isnull(kst_tab_contratti_doc.flg_fatt_dopo_valid ) then kst_tab_contratti_doc.flg_fatt_dopo_valid = ""
if isnull(kst_tab_contratti_doc.acconto_perc ) then kst_tab_contratti_doc.acconto_perc = 0
if isnull(kst_tab_contratti_doc.acconto_imp ) then kst_tab_contratti_doc.acconto_imp = 0
if isnull(kst_tab_contratti_doc.acconto_cod_pag) then kst_tab_contratti_doc.acconto_cod_pag = 0
if isnull(kst_tab_contratti_doc.id_meca_causale ) then kst_tab_contratti_doc.id_meca_causale = 0

if isnull(kst_tab_contratti_doc.rif_interno_alt ) then kst_tab_contratti_doc.rif_interno_alt = ""
if isnull(kst_tab_contratti_doc.venditore_nome ) then kst_tab_contratti_doc.venditore_nome = ""
if isnull(kst_tab_contratti_doc.venditore_ruolo ) then kst_tab_contratti_doc.venditore_ruolo = ""
if isnull(kst_tab_contratti_doc.treat_validate ) then kst_tab_contratti_doc.treat_validate = ""

for k_idx = 1 to 3
	if isnull(kst_tab_contratti_doc.code_our[k_idx] ) then kst_tab_contratti_doc.code_our[k_idx] = ""
	if isnull(kst_tab_contratti_doc.qaa[k_idx] ) then kst_tab_contratti_doc.qaa[k_idx] = ""
next

if isnull(kst_tab_contratti_doc.x_datins) then kst_tab_contratti_doc.x_datins = datetime(date(0))
if isnull(kst_tab_contratti_doc.x_utente) then kst_tab_contratti_doc.x_utente = " "


end subroutine

public function st_esito get_dati_default (ref st_tab_contratti_doc kst_tab_contratti_doc);//
//====================================================================
//=== Torna l'ultimo dati Contratto di defualt x il caricamento
//=== 
//=== Input: st_tab_contratti_doc.anno      Output: st_tab_contratti_doc.*                  
//=== Ritorna ST_ESITO
//=== 
//====================================================================

st_esito kst_esito


	if kst_tab_contratti_doc.anno = 0 or isnull( kst_tab_contratti_doc.anno) then
		kst_tab_contratti_doc.anno = year(kg_dataoggi) 
	end if
	
	kst_esito = kguo_exception.inizializza(this.classname())

	kst_tab_contratti_doc.id_contratto_doc = 0
	kst_tab_contratti_doc.stato = kki_STATO_nuovo
	
	  SELECT 
	 	ctr.id_contratto_doc,
	  	ctr.anno,   
         ctr.offerta_data,   
         ctr.offerta_validita,   
         ctr.data_inizio,   
         ctr.data_fine,   
         ctr.oggetto,   
         ctr.id_clie_settore,   
         ctr.gruppo,   
         ctr.iva,   
         ctr.fattura_da,  
         ctr.stampa_tradotta, 
         ctr.id_listino_pregruppo,   
         ctr.id_listino_voce_1,   
         ctr.id_listino_voce_2,   
         ctr.id_listino_voce_3,   
         ctr.id_listino_voce_4,   
         ctr.id_listino_voce_5,   
         ctr.id_listino_voce_6,   
         ctr.id_listino_voce_7,   
         ctr.id_listino_voce_8,   
         ctr.id_listino_voce_9,   
         ctr.id_listino_voce_10,   
         ctr.voce_prezzo_1,   
         ctr.voce_prezzo_2,   
         ctr.voce_prezzo_3,   
         ctr.voce_prezzo_4,   
         ctr.voce_prezzo_5,   
         ctr.voce_prezzo_6,   
         ctr.voce_prezzo_7,   
         ctr.voce_prezzo_8,   
         ctr.voce_prezzo_9,   
         ctr.voce_prezzo_10   
    INTO
	 	:kst_tab_contratti_doc.id_contratto_doc,
	 	:kst_tab_contratti_doc.anno,   
         :kst_tab_contratti_doc.offerta_data,   
         :kst_tab_contratti_doc.offerta_validita,   
         :kst_tab_contratti_doc.data_inizio,   
         :kst_tab_contratti_doc.data_fine,   
         :kst_tab_contratti_doc.oggetto,   
         :kst_tab_contratti_doc.id_clie_settore,   
         :kst_tab_contratti_doc.gruppo,   
         :kst_tab_contratti_doc.iva,   
         :kst_tab_contratti_doc.fattura_da,  
         :kst_tab_contratti_doc.stampa_tradotta, 
         :kst_tab_contratti_doc.id_listino_pregruppo,   
         :kst_tab_contratti_doc.id_listino_voce[1],   
         :kst_tab_contratti_doc.id_listino_voce[2],   
         :kst_tab_contratti_doc.id_listino_voce[3],   
         :kst_tab_contratti_doc.id_listino_voce[4],   
         :kst_tab_contratti_doc.id_listino_voce[5],   
         :kst_tab_contratti_doc.id_listino_voce[6],   
         :kst_tab_contratti_doc.id_listino_voce[7],   
         :kst_tab_contratti_doc.id_listino_voce[8],   
         :kst_tab_contratti_doc.id_listino_voce[9],   
         :kst_tab_contratti_doc.id_listino_voce[10],   
         :kst_tab_contratti_doc.voce_prezzo[1],   
         :kst_tab_contratti_doc.voce_prezzo[2],   
         :kst_tab_contratti_doc.voce_prezzo[3],   
         :kst_tab_contratti_doc.voce_prezzo[4],   
         :kst_tab_contratti_doc.voce_prezzo[5],   
         :kst_tab_contratti_doc.voce_prezzo[6],   
         :kst_tab_contratti_doc.voce_prezzo[7],   
         :kst_tab_contratti_doc.voce_prezzo[8],   
         :kst_tab_contratti_doc.voce_prezzo[9],   
         :kst_tab_contratti_doc.voce_prezzo[10]
    FROM v_contratti_doc as ctr
	where id_contratto_doc in 
		 (  SELECT   max(id_contratto_doc)
			 FROM v_contratti_doc 
			 where anno = :kst_tab_contratti_doc.anno
			 )
		using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_tab_contratti_doc.anno = 0
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Quotazione~n~r:" + trim(sqlca.SQLErrText)
		end if
	end if




return kst_esito




end function

public function st_esito get_ultimo_cliente_anno (ref st_tab_contratti_doc kst_tab_contratti_doc);//
//====================================================================
//=== Torna l'ultimo Contratto caricato nell'anno x il cliente indicato 
//=== 
//=== Input: st_tab_contratti_doc.anno e id_cliente     Output: st_tab_clienti.id_contratto_doc/offerta_data                  
//=== Ritorna ST_ESITO
//=== 
//====================================================================

st_esito kst_esito



	kst_esito = kguo_exception.inizializza(this.classname())
	
   SELECT  offerta_data, max(id_contratto_doc)  
       into :kst_tab_contratti_doc.id_contratto_doc
		 FROM v_contratti_doc
		 where id_cliente = :kst_tab_contratti_doc.id_cliente
		 	and offerta_data in (select max(offerta_data) from v_contratti_doc where id_cliente =  :kst_tab_contratti_doc.id_cliente and anno = :kst_tab_contratti_doc.anno)
			 group by offerta_data
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Quotazione (cercato Ultimo Documento) ~n~r:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
	end if


return kst_esito




end function

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;//
//=== 
//====================================================================
//=== Attiva LINK cliccato 
//===
//=== Par. Inut: 
//===               datawindow su cui è stato attivato il LINK
//===               nome campo di LINK
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return=true
st_tab_contratti_doc kst_tab_contratti_doc
st_esito kst_esito
uo_exception kuo_exception
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
kuf_menu_window kuf1_menu_window
kuf_web kuf1_web
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


choose case a_campo_link

	case "id_contratto_doc"
		kst_tab_contratti_doc.id_contratto_doc = adw_link.getitemnumber(adw_link.getrow(), a_campo_link)
		if kst_tab_contratti_doc.id_contratto_doc > 0 then
			kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_contratti_doc )
			if kst_esito.esito <> kkg_esito.ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Quotazione  id =" + trim(string(kst_tab_contratti_doc.id_contratto_doc)) + " " 
		else
			k_return = false
		end if

	case "contratto_doc_dettaglio"
		kst_tab_contratti_doc.id_contratto_doc = adw_link.getitemnumber(adw_link.getrow(), "id_contratto_doc")
		if kst_tab_contratti_doc.id_contratto_doc > 0 then
			kst_tab_contratti_doc.quotazione_tipo = adw_link.getitemstring(adw_link.getrow(), "quotazione_tipo")
			kst_esito = this.anteprima_dettaglio( kdsi_elenco_output, kst_tab_contratti_doc )
			if kst_esito.esito <> kkg_esito.ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Quotazione (" + trim(kst_tab_contratti_doc.quotazione_tipo) + ")  id =" + trim(string(kst_tab_contratti_doc.id_contratto_doc)) + " " 
		else
			k_return = false
		end if
		

end choose

if k_return then

	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//=== Parametri : 
	//=== struttura st_open_w
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.id_programma = kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window


	else
		
		kuo_exception = create uo_exception
		kuo_exception.setmessage( "Nessun valore disponibile. " )
		throw kuo_exception
		
		
	end if

end if

SetPointer(kp_oldpointer)



return k_return

end function

public function st_esito stampa_documento_definitiva (st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception;//====================================================================
//=== 
//=== Aggiorna Tabelle + Prepara + Stampa Quotazione
//===
//=== Par. Inut: kst_tab_contratti_doc (valorizzare il num. Documento)
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:    Vedi standard
//=== 
//====================================================================
//
long k_rc
st_tab_contratti_doc kst_tab_contratti_doc_array[]
st_esito kst_esito
st_profilestring_ini kst_profilestring_ini


	kst_esito = kguo_exception.inizializza(this.classname())

	if_sicurezza(kkg_flag_modalita.stampa)

	if kst_tab_contratti_doc.id_contratto_doc > 0 then	

		try 
			
			kst_tab_contratti_doc.x_datins = kGuf_data_base.prendi_x_datins()
			kst_tab_contratti_doc.x_utente = kGuf_data_base.prendi_x_utente()
			kst_tab_contratti_doc.stato = kki_STATO_stampato
	
//--- aggiorna archivio
			get_form_di_stampa(kst_tab_contratti_doc)
			if len(trim(kst_tab_contratti_doc.form_di_stampa)) > 0 then 
				kst_tab_contratti_doc.st_tab_g_0.esegui_commit = "N"
				set_form_di_stampa(kst_tab_contratti_doc)
			end if
			kst_tab_contratti_doc.st_tab_g_0.esegui_commit = "N"
			kst_esito = set_stato(kst_tab_contratti_doc)
			if kst_esito.esito = kkg_esito.ok then
				kst_tab_contratti_doc.data_stampa = kg_dataoggi
				set_data_stampa(kst_tab_contratti_doc)
				kst_tab_contratti_doc_array[1] = kst_tab_contratti_doc
			else
				kst_tab_contratti_doc_array[1].id_contratto_doc = 0  // evita di caricare nell'archivio esporta-pdf
			end if				

			kguo_sqlca_db_magazzino.db_commit( ) 	

//--- LANCIA LA PREPARAZIONE E STAMPA !!!
			stampa_documento(kst_tab_contratti_doc)

		catch (uo_exception kuo_exception1)
			kst_esito = kuo_exception1.get_st_esito( )

		finally
			if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn or  kst_esito.esito = kkg_esito.no_esecuzione then 
			else
				if kst_esito.sqlcode < 0 then
					kguo_sqlca_db_magazzino.db_rollback( )
	
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.SQLErrText = "Fallita Registrazione dati di stampa Documento: "+ string(kst_tab_contratti_doc.id_contratto_doc) + "~n~r"&
								 + "Errore: " + trim(sqlca.sqlerrtext)
					kst_esito.esito = kkg_esito.db_ko
					kguo_exception.set_esito( kst_esito )
					throw kguo_exception
				end if
			end if

		end try


//--- Aggiunge la riga in DOCPROD x l'esportazione digitale ----------------------------------------------------------------------------------------
		try 

			kst_tab_contratti_doc_array[1].st_tab_g_0.esegui_commit = "S"
			aggiorna_docprod(kst_tab_contratti_doc_array[])
			
		catch (uo_exception kuo_exception)
			kuo_exception.kist_esito.sqlerrtext = "Archivio Contratto Commerciale Aggiornato Correttamente !  Ma si sono verificate le seguenti anonalie: ~n~r" &
									+ trim(kuo_exception.kist_esito.sqlerrtext)
			kst_esito = kuo_exception.get_st_esito( )
			kuo_exception.scrivi_log()
			
		finally
		
		end try
		
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna stampa eseguita: ~n~r" + "Numero Documento non indicato, registrazione dati non effettuata."
		kst_esito.esito = kkg_esito.bug
		
	end if


return kst_esito

end function

public function st_esito stampa_documento_prova (st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception;//
//=== 
//====================================================================
//=== 
//===Prova/Duplicato fa Preparazione + Stampa Quotazione (NO AGGIORNAMENTO)
//===
//=== Par. Inut: kst_tab_contratti_doc (valorizzare il num. Documento)
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:    Vedi standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
datawindow kdw_print
st_esito kst_esito
st_profilestring_ini kst_profilestring_ini


	kst_esito = kguo_exception.inizializza(this.classname())

//--- controlla se utente autorizzato alla funzione in atto
	if_sicurezza(kkg_flag_modalita.stampa)

	if kst_tab_contratti_doc.id_contratto_doc > 0 then		

//--- LANCIA LA PREPARAZIONE E STAMPA !!!
		stampa_documento(kst_tab_contratti_doc)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna stampa eseguita: ~n~r" + "Numero Documento non indicato, registrazione dati non effettuata."
		kst_esito.esito = kkg_esito.bug
		
	end if


return kst_esito

end function

public function st_esito get_id_cliente (ref st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna il Codice Cliente da id_contratto_doc 
//--- 
//--- 
//--- Input: st_tab_contratti_doc.id_contratto_doc
//--- Out: st_tab_contratti_doc.id_cliente
//---
//--- Ritorna tab. ST_ESITO, Esiti:   Vedi standard
//---
//----------------------------------------------------------------------------------------------------------------
//
string k_return = "0 "
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()



	SELECT
				id_cliente
			into
		         :kst_tab_contratti_doc.id_cliente  
			 FROM v_contratti_doc  
			 where 
						(id_contratto_doc  = :kst_tab_contratti_doc.id_contratto_doc)					     
				 using sqlca;
		
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante Lettura Contratto R. & D. (contratti_doc) id_contratto_doc = " + string(kst_tab_contratti_doc.id_contratto_doc) + " " &
						 + "): " + trim(SQLCA.SQLErrText)
									 
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
	

return kst_esito


end function

public function boolean set_id_docprod (st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------
//--- Imposta a id_docprod del Documento Esportato in Tabella contratti_doc
//--- 
//--- 
//--- Inp: st_tab_contratti_doc.id_contratto_doc  e  id_docprod
//--- Out:        
//--- Ritorna: TRUE = OK
//---           		
//--- Lancia EXCEPTION x errore
//--- 
//---------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito

	

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
	
if kst_tab_contratti_doc.id_contratto_doc > 0 then

	kst_tab_contratti_doc.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_contratti_doc.x_utente = kGuf_data_base.prendi_x_utente()

	UPDATE contratti_doc  
		  SET id_docprod = :kst_tab_contratti_doc.id_docprod
			,x_datins = :kst_tab_contratti_doc.x_datins
			,x_utente = :kst_tab_contratti_doc.x_utente
		WHERE contratti_doc.id_contratto_doc = :kst_tab_contratti_doc.id_contratto_doc
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiorn. 'id Documenti Esportati' sulla tab. Contratti R. & D. ~n~r" &
					+ "Id: " + string(kst_tab_contratti_doc.id_contratto_doc, "####0") + "  " &
					+ " ~n~rErrore-tab.contratti_doc:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_contratti_doc.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_doc.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	else
		if kst_tab_contratti_doc.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_doc.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	end if

else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore aggiornamento tab. Contratti R. & D., Manca Identificativo (id_contratto_doc) !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	

if kst_esito.esito = kkg_esito.err_logico or 	kst_esito.esito = kkg_esito.db_ko then
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

k_return = true

return k_return

end function

public function long aggiorna_docprod (ref st_tab_contratti_doc kst_tab_contratti_doc[]) throws uo_exception;//
//--- Aggiorna righe tabelle DOCPROD
//---
//--- input:  array st_tab_contratti_doc con l'elenco dei documenti da aggiornare
//--- out: Numero documenti caricati
//---
//--- Lancia EXCEPTION
//---
long k_return = 0
long k_riga_contratto_rd=0, k_nr_contratto_rd=0, k_nr_doc=0
st_esito kst_esito
st_tab_docprod kst_tab_docprod
kuf_docprod kuf1_docprod


	kst_esito = kguo_exception.inizializza(this.classname())

	k_nr_contratto_rd = upperbound(kst_tab_contratti_doc[])

	if k_nr_contratto_rd > 0 then
		
		
//--- Crea Documenti da Esportare (DOCPROD)
		kuf1_docprod = create kuf_docprod

		for k_riga_contratto_rd = 1 to k_nr_contratto_rd

			try

				if kst_tab_contratti_doc[k_riga_contratto_rd].id_contratto_doc > 0 then
	
					get_offerta_data(kst_tab_contratti_doc[k_riga_contratto_rd])
					kst_tab_docprod.doc_num = kst_tab_contratti_doc[k_riga_contratto_rd].id_contratto_doc
					kst_tab_docprod.doc_data = kst_tab_contratti_doc[k_riga_contratto_rd].offerta_data
					kst_tab_docprod.id_doc = kst_tab_contratti_doc[k_riga_contratto_rd].id_contratto_doc
					
					
					kst_esito = get_id_cliente(kst_tab_contratti_doc[k_riga_contratto_rd])
					if kst_esito.esito = kkg_esito.db_ko then
						if isvalid(kuf1_docprod) then destroy kuf1_docprod
						kguo_exception.inizializza( )
						kguo_exception.set_esito(kst_esito)
						throw kguo_exception
					end if
					
					kst_tab_docprod.id_cliente = kst_tab_contratti_doc[k_riga_contratto_rd].id_cliente
					
					kst_tab_docprod.st_tab_g_0.esegui_commit = kst_tab_contratti_doc[1].st_tab_g_0.esegui_commit
	
					kuf1_docprod.tb_add_contratti_rd ( kst_tab_docprod ) // AGGIUNGE IN DOCPROD
					k_nr_doc++
					
				end if		

			catch (uo_exception kuo1_exception)
				throw kuo1_exception
				
			end try
			
		next
	
		if isvalid(kuf1_docprod) then destroy kuf1_docprod
	
		if k_nr_doc > 0 then
			k_return = k_nr_doc
		end if
	
	end if


return k_return

end function

public function st_esito get_offerta_data (ref st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna Data dell'Offerta da Contratto rd 
//--- 
//--- 
//--- Input: st_tab_contratti_doc.id_contratto_doc
//--- Out: st_tab_contratti_doc.offerta_data
//---
//--- Ritorna tab. ST_ESITO, Esiti:   Vedi standard
//---
//----------------------------------------------------------------------------------------------------------------
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()

 

	SELECT
				contratti_doc.offerta_data
			into
		         :kst_tab_contratti_doc.offerta_data  
			 FROM contratti_doc  
			 where 
						(id_contratto_doc  = :kst_tab_contratti_doc.id_contratto_doc)					     
				 using sqlca;
		
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante Lettura 'Data Offerta' nel Contratto R. & D. (contratti_doc) id_contratto_doc = " + string(kst_tab_contratti_doc.id_contratto_doc) + " " &
						 + "): " + trim(SQLCA.SQLErrText)
									 
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
	

return kst_esito


end function

public function long stampa_esporta_digitale (st_docprod_esporta kst_docprod_esporta) throws uo_exception;//---
//---  Esporta in digitale (pdf) i CONTRATTI
//---
boolean k_sicurezza
int k_item_doc, k_rc, k_n_documenti_stampati, k_id_stampa
string k_path_risorse="", k_rcx="", k_esito="", k_stampante_pdf=""
//long k_rc, k_riga
datastore kds_print
st_tab_contratti_doc kst_tab_contratti_doc
st_open_w kst_open_w
st_esito kst_esito, kst_esito_armo
st_profilestring_ini kst_profilestring_ini
kuf_sicurezza kuf1_sicurezza
kuf_base kuf1_base

 

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.stampa) //kkg_id_programma_contratti_co

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_sicurezza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa Documento non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut
	
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
	
end if
	
try

//--- Piglio il nome della stampante PDF
	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base( "stamp_pdf")
	if left(k_esito,1) <> "0" then
		k_stampante_pdf = ""
	else
		k_stampante_pdf	= trim(mid(k_esito,2))
	end if
	destroy kuf1_base

//--- OK finalmente inizio a lavorare -----------------------------------------------------------------------------

//--- se oggetto dw Contratto NON ancora definito  
      if not isvalid(kds_print) then
         kds_print = create datastore
      end if

      for k_item_doc = 1 to upperbound(kst_docprod_esporta.kst_tab_docprod[])

         kst_tab_contratti_doc.id_contratto_doc = kst_docprod_esporta.kst_tab_docprod[k_item_doc].id_doc
         if kst_tab_contratti_doc.id_contratto_doc > 0 then
         
			if if_esiste(kst_tab_contratti_doc) then   // esiste il documento?
         
//--- Popola area dell'Contratto sul quale sto lavorando
				kst_tab_contratti_doc.id_contratto_doc = kst_docprod_esporta.kst_tab_docprod[k_item_doc].doc_num
				kst_tab_contratti_doc.offerta_data = kst_docprod_esporta.kst_tab_docprod[k_item_doc].doc_data
				kst_tab_contratti_doc.id_cliente = kst_docprod_esporta.kst_tab_docprod[k_item_doc].id_cliente

//--- Ricavo il nome del form se Documento gia' stampato
				kst_tab_contratti_doc.data_stampa = KKG.DATA_ZERO 
				get_form_di_stampa(kst_tab_contratti_doc)
         
//--- popola il DS con l'Contratto da stampare
				kds_print = create datastore
				
				if len(trim(kst_tab_contratti_doc.form_di_stampa)) > 0 then  //--- se sono in ristampa allora riprendo il form originale
					kds_print.dataobject = trim(kst_tab_contratti_doc.form_di_stampa) 
				else
					kds_print.dataobject = kki_form_di_stampa_attuale
				end if
//--- Imposta  Risorse Grafiche
				if len(trim(kGuo_path.get_risorse())) > 0 then
//					k_rcx=kds_print.Modify("p_img.Filename='" + kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img.text"))+ "'") 
//					k_rcx=kds_print.Modify("p_img_0.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img_0.text")) + "'")  
//					k_rcx=kds_print.Modify("p_img_1.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img_1.text")) + "'") 
					kds_print.object.DataWindow.Export.PDF.Method = NativePDF!
					k_rcx=kds_print.Modify("p_img_2.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img_2.text")) + "'") 
				end if
   
				kds_print.settransobject(sqlca)
   
//--- retrive dell'Contratto 
				k_rc=kds_print.retrieve(  kst_tab_contratti_doc.id_contratto_doc )
   
   
//--- Controllo se manca il percorso
				if len(trim( kst_docprod_esporta.path[k_item_doc])) > 0 then 
	
					k_n_documenti_stampati ++
	
//=== Crea il PDF
					kds_print.Object.DataWindow.Export.PDF.Method = Distill!
					kds_print.Object.DataWindow.Printer = k_stampante_pdf   
					kds_print.Object.DataWindow.Export.PDF.Distill.CustomPostScript="1"
					k_id_stampa = kds_print.saveas(trim( kst_docprod_esporta.path[k_item_doc]),PDF!, false)   //
					
					if k_id_stampa < 1 then
						
						kst_esito.sqlcode = 0
						kst_esito.SQLErrText = "Contratto digitale su: '" + k_stampante_pdf + "' non generato: ~n~r"  &
																	 + "Documento: " + trim(kst_docprod_esporta.path[k_item_doc]) + " ~n~r" &
																	 + "Funzione fallita per errore: " + string(k_id_stampa)
						kst_esito.esito = kkg_esito.no_esecuzione
						kguo_exception.set_esito(kst_esito)
						throw kguo_exception
					
					end if
					
//--- Aggiorna tab      
					kst_tab_contratti_doc.id_contratto_doc = kst_docprod_esporta.kst_tab_docprod[k_item_doc].id_doc
					kst_tab_contratti_doc.id_docprod = kst_docprod_esporta.kst_tab_docprod[k_item_doc].id_docprod
					set_id_docprod(kst_tab_contratti_doc)
						
				end if
			end if
      
         end if

	end for
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
	
end try



return k_n_documenti_stampati      

end function

public function boolean if_esiste (st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla esistenza Contratto R. & D. da id_rdntratti_rd
//--- 
//--- 
//--- Inp: st_tab_rdntratti_rd.id
//--- Out: TRUE = esiste
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
long k_trovato=0
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

//--- x numero contratto indicato			
	SELECT count(*)
			into :k_trovato
			 FROM contratti_doc  
			 where  id_contratto_doc  = :kst_tab_contratti_doc.id_contratto_doc
			 using sqlca;
		
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura Contratto R. & D. (contratti_doc) id = " + string(kst_tab_contratti_doc.id_contratto_doc) + " " &
						 + "~n~rErrore: " + trim(SQLCA.SQLErrText)
									 
		kst_esito.esito = kkg_esito.db_ko
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		if k_trovato > 0 then k_return = true
	end if
	

return k_return



end function

private function st_esito set_stato (ref st_tab_contratti_doc kst_tab_contratti_doc);//
//====================================================================
//=== Set del flag STATO
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
st_tab_contratti_doc kst_tab_contratti_doc_attuale
boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = get_id_programma (kst_open_w.flag_modalita) //kkg_id_programma_contratti_doc

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Modifica Stato del 'Contratto R. & D.' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else
	
	try

		if kst_tab_contratti_doc.id_contratto_doc > 0 then
	
			
			kst_tab_contratti_doc.x_datins = kGuf_data_base.prendi_x_datins()
			kst_tab_contratti_doc.x_utente = kGuf_data_base.prendi_x_utente()
	

//--- piglia lo stato attuale	
			kst_tab_contratti_doc_attuale = kst_tab_contratti_doc
			get_stato(kst_tab_contratti_doc_attuale)

		
			if len(trim(kst_tab_contratti_doc_attuale.stato)) > 0 then
			else
//--- se nulla forza a 'NUOVO' (il livello più basso)
				kst_tab_contratti_doc_attuale.stato = kki_STATO_nuovo
			end if
		
//--- Imposta lo STATO solo x metterlo a livello superiore MAI inferiore ad eccezione di RIAPERTO
			if kst_tab_contratti_doc.stato >= kst_tab_contratti_doc_attuale.stato then

//--- setta lo STATO
				update contratti_doc
						 set stato = :kst_tab_contratti_doc.stato
						 ,x_datins = :kst_tab_contratti_doc.x_datins
						 ,x_utente = :kst_tab_contratti_doc.x_utente
						where id_contratto_doc = :kst_tab_contratti_doc.id_contratto_doc
						using sqlca;
	
			
				if sqlca.sqlcode <> 0 then
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.SQLErrText = "Modifica Stato del 'Contratto R. & D.'  (contratti_doc):" + trim(sqlca.SQLErrText)
					kst_esito.esito = kkg_esito.db_ko
				end if
			else
				kst_esito.esito = kkg_esito.no_esecuzione
			end if

		else
			kst_esito.esito = kkg_esito.no_esecuzione

		end if
		
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		
		
	finally
//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_contratti_doc.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_doc.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_contratti_doc.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_doc.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if

	
		
	end try
	
end if


return kst_esito

end function

private function boolean set_form_di_stampa (st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------
//--- Set del campo FORM_DI_STAMPA
//--- 
//--- Inp: st_tab_contratti_doc.id_contratto_doc
//--- Out:
//--- 
//--- Ritorna TRUE = OK
//---           	
//---  Lancia EXCEPTION
//---           	
//--------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


kst_esito = kguo_exception.inizializza(this.classname())

kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = get_id_programma (kst_open_w.flag_modalita) //kkg_id_programma_contratti_rd

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa del 'Contratto R. & D.' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_contratti_doc.id_contratto_doc > 0 then

		
		kst_tab_contratti_doc.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_contratti_doc.x_utente = kGuf_data_base.prendi_x_utente()
	

		update contratti_doc
		    set form_di_stampa = :kst_tab_contratti_doc.form_di_stampa
			 ,x_datins = :kst_tab_contratti_doc.x_datins
			 ,x_utente = :kst_tab_contratti_doc.x_utente
			where id_contratto_doc = :kst_tab_contratti_doc.id_contratto_doc
			using sqlca;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Aggiorna Lay-Out di stampa del 'Contratto R. & D.'  (contratti_doc):" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		end if
	
//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_contratti_doc.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_doc.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_contratti_doc.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_doc.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if

		if kst_esito.esito = kkg_esito.db_ko then
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito )
			throw kguo_exception
			
		else
			
			if kst_esito.esito = kkg_esito.ok then
				k_return = true
			end if
			
		end if

	end if
end if


return k_return


end function

private function boolean set_data_stampa (st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------
//--- Set del campo DATA_STAMPA (di solito in concomitanza con il cambio di STATO)
//--- 
//--- Inp: st_tab_contratti_doc.id_contratto_doc
//--- Out:
//--- 
//--- Ritorna TRUE = OK
//---           	
//---  Lancia EXCEPTION
//---           	
//--------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


kst_esito = kguo_exception.inizializza(this.classname())

kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = get_id_programma (kst_open_w.flag_modalita) //kkg_id_programma_contratti_doc

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa del 'Contratto R. & D.' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_contratti_doc.id_contratto_doc > 0 then

		
		kst_tab_contratti_doc.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_contratti_doc.x_utente = kGuf_data_base.prendi_x_utente()
	

		update contratti_doc
		    set data_stampa = :kst_tab_contratti_doc.data_stampa
			 ,x_datins = :kst_tab_contratti_doc.x_datins
			 ,x_utente = :kst_tab_contratti_doc.x_utente
			where id_contratto_doc = :kst_tab_contratti_doc.id_contratto_doc
			using sqlca;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Aggiorna Lay-Out di stampa del 'Contratto R. & D.'  (contratti_doc):" + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
	
//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_contratti_doc.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_doc.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_contratti_doc.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_doc.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if

		if kst_esito.esito = kkg_esito.db_ko then
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito )
			throw kguo_exception
			
		else
			
			if kst_esito.esito = kkg_esito.ok then
				k_return = true
			end if
			
		end if
		
	else
		kst_esito.esito = kkg_esito.no_esecuzione
	end if
end if


return k_return


end function

public function st_esito set_trasferito (st_tab_contratti_doc kst_tab_contratti_doc);//
//====================================================================
//=== Imposta il flag stato a Convertito in CO e Listino in tabella contratti_doc
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_tab_contratti_doc.stato = kki_stato_trasferito

kst_esito = set_stato(kst_tab_contratti_doc) 

return kst_esito

end function

private function st_esito set_ts_esito_operazione (ref st_tab_contratti_doc kst_tab_contratti_doc);//
//====================================================================
//=== Set del flag il TimeStamp dell'esito del trasferimento a listino colonna: TS_ESITO_OPERAZIONE
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
//kuf_sicurezza kuf1_sicurezza
//st_open_w kst_open_w
boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

	k_autorizza = if_sicurezza(kkg_flag_modalita.modifica)

	if not k_autorizza then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Modifica 'data e ora esito' nel 'Quotazione' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	else
	
		if kst_tab_contratti_doc.id_contratto_doc > 0 then
	
			kst_tab_contratti_doc.x_datins = kGuf_data_base.prendi_x_datins()
			kst_tab_contratti_doc.x_utente = kGuf_data_base.prendi_x_utente()
	
			update contratti_doc
				 set esito_operazioni_ts_operazione = :kst_tab_contratti_doc.esito_operazioni_ts_operazione
					 ,x_datins = :kst_tab_contratti_doc.x_datins
					 ,x_utente = :kst_tab_contratti_doc.x_utente
				where id_contratto_doc = :kst_tab_contratti_doc.id_contratto_doc
				using sqlca;
	
			
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Modifica 'data e ora esito operazione'  del 'Quotazione'  (contratti_doc):" + trim(sqlca.SQLErrText)
				if sqlca.sqlcode = 100 then
					kst_esito.esito = kkg_esito.not_fnd
				else
					if sqlca.sqlcode > 0 then
						kst_esito.esito = kkg_esito.db_wrn
					else
						kst_esito.esito = kkg_esito.db_ko
					end if
				end if
			
			else
		
	//---- COMMIT....	
				if kst_esito.esito = kkg_esito.db_ko then
					if kst_tab_contratti_doc.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_doc.st_tab_g_0.esegui_commit) then
						kGuf_data_base.db_rollback_1( )
					end if
				else
					if kst_tab_contratti_doc.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_doc.st_tab_g_0.esegui_commit) then
						kGuf_data_base.db_commit_1( )
					end if
				end if
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()	
	
end try

return kst_esito

end function

public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception;//------------------------------------------------------------------------------------------------------
//---  Controllo dati 
//---  inp: datastore con i dati da controllare
//---  out: datastore con  	ads_inp.object.<nome campo>.tag che può valere:
//												0=tutto OK (kkg_esito.ok); 
//												1=errore logico (bloccante) (kkg_esito.ERR_LOGICO); 
//												2=errore forma  (bloccante) (kkg_esito.err_formale);
//												3=dati insufficienti  (bloccante) (kkg_esito.DATI_INSUFF);
//												4=KO ma errore non grave  (NON bloccante) (kkg_esito.DB_WRN);
//---							               	5=OK con degli avvertimenti (NON bloccante) (kkg_esito.DATI_WRN);
//---  rit: 
//---
//---  per errore lancia EXCEPTION anche x i warning
//---
//---  CONSIGLIO DI COPIARE DA QUESTO ESTENDENDO I CONTROLLI
//---
//------------------------------------------------------------------------------------------------------
//
int k_errori = 0
long k_nr_righe, k_ctr
int k_riga
string k_tipo_errore="0"
boolean k_voci_no_cod=false
st_tab_contratti_doc kst_tab_contratti_doc, kst1_tab_contratti_doc
st_tab_gru kst_tab_gru
st_tab_prodotti kst_tab_prodotti
//st_tab_listino_pregruppi_voci kst_tab_listino_pregruppi_voci
st_tab_clienti kst_tab_clienti
st_esito kst_esito, kst_esito1
kuf_ausiliari kuf1_ausiliari
kuf_prodotti kuf1_prodotti
//kuf_listino_pregruppi_voci kuf1_listino_pregruppi_voci


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
// ESEMPIO
//	if trim(ads_inp.object.descr) > " "  then
//	else
//		k_errori ++
//		k_tipo_errore="3"      // errore in questo campo: dati insuff.
//		ads_inp.object.descr.tag = k_tipo_errore 
//		kst_esito.esito = kkg_esito.err_formale
//		kst_esito.sqlerrtext = "Manca descrizione nel campo " + trim(ads_inp.object.descr_t.text) +  "~n~r"  
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if

	
	k_nr_righe =ads_inp.rowcount()
	k_errori = 0
	k_riga =ads_inp.getnextmodified(0, primary!)

	do while k_riga > 0  and k_errori < 10

		kst_tab_contratti_doc.id_contratto_doc = ads_inp.getitemnumber(k_riga, "contratti_doc_id_contratto_doc")

//--- controllo se sono stati caricati Contratti nell'anno x lo stesso cliente		
		if ki_flag_modalita = kkg_flag_modalita.inserimento then
			kst_tab_contratti_doc.id_cliente = ads_inp.getitemnumber(k_riga, "id_cliente")
			kst_tab_contratti_doc.anno = ads_inp.getitemnumber(k_riga, "anno")
			kst_esito = get_ultimo_cliente_anno(kst_tab_contratti_doc)
			if kst_esito.esito = kkg_esito.ok then
				if kst_tab_contratti_doc.id_contratto_doc > 0 then
					k_errori ++
					k_tipo_errore=kkg_esito.DATI_WRN      
					ads_inp.modify("id_cliente.tag = '" + k_tipo_errore + "' ")
					kst_esito.esito = kkg_esito.DATI_WRN
					kst_esito.sqlerrtext =  ": il cliente ha già altri Contratti, es il n. " + string(kst_tab_contratti_doc.id_contratto_doc ) &
												+ " del " + string(kst_tab_contratti_doc.offerta_data, "dd/mm/yyyy" ) + "~n~r" 
				end if
			end if
		end if
		
		if k_tipo_errore = "4" or k_tipo_errore = kkg_esito.DATI_WRN or k_tipo_errore = "0" then 
//--- check se codice quotazione già caricato
			kst_tab_contratti_doc.quotazione_cod = ads_inp.getitemstring(k_riga, "quotazione_cod")
			if trim(kst_tab_contratti_doc.quotazione_cod) >  " "  then
				select ctr.id_contratto_doc
							, clienti.codice
							, clienti.rag_soc_10 
					into :kst1_tab_contratti_doc.quotazione_cod
							, :kst1_tab_contratti_doc.id_cliente
							, :kst_tab_clienti.rag_soc_10
				    from v_contratti_doc ctr inner join clienti on
					 		ctr.id_cliente = clienti.codice
					where id_contratto_doc in ( 
						select max(id_contratto_doc) 
						    from v_contratti_doc
							where id_contratto_doc <> :kst_tab_contratti_doc.id_contratto_doc
					   		         and quotazione_cod = :kst_tab_contratti_doc.quotazione_cod)
				using kguo_sqlca_db_magazzino;
				if trim(kst1_tab_contratti_doc.quotazione_cod) > " " then
					k_errori++
					k_tipo_errore = "4"
					kst_esito.esito = kkg_esito.DATI_WRN
					kst_esito.sqlerrtext = "Quotazione '" + trim(kst_tab_contratti_doc.quotazione_cod) + "' già presente sul Contratto " + string(kst1_tab_contratti_doc.quotazione_cod) &
										+ " di " + trim(kst_tab_clienti.rag_soc_10) + " (" + string(kst1_tab_contratti_doc.id_cliente) + ")" &
										+ trim(ads_inp.describe("art_t.text")) +  "~n~r"  + trim(kst_esito.sqlerrtext)
				end if
			end if
		end if
		
		if k_tipo_errore = "4" or k_tipo_errore = kkg_esito.DATI_WRN or k_tipo_errore = "0" then 
//--- check presenza del cod articolo
			kst_tab_contratti_doc.art = ads_inp.getitemstring(k_riga, "art")
			if len(trim(kst_tab_contratti_doc.art)) = 0 or isnull(kst_tab_contratti_doc.art )  then
				k_errori++
				k_tipo_errore = "4"
				kst_esito.esito = kkg_esito.DATI_INSUFF
				kst_esito.sqlerrtext = "Manca valore nel campo " + trim(ads_inp.describe("art_t.text")) +  "~n~r"  + trim(kst_esito.sqlerrtext)
			end if

//--- warning sul cambio di STATO
			if ads_inp.getitemstring( k_riga, "stato") = kki_STATO_accettato then
				k_errori++
				k_tipo_errore = kkg_esito.DATI_WRN
				kst_esito.esito = kkg_esito.DATI_WRN
				kst_esito.sqlerrtext = "Lo Stato 'ACCETTATO' rende il documento IMMODIFICABILE, controlla meglio.  "  + trim(kst_esito.sqlerrtext)
			end if
		end if

//--- check se Gruppo coerente con il Settore
		kst_tab_contratti_doc.gruppo = ads_inp.getitemnumber(k_riga, "gruppo")
		kst_tab_contratti_doc.id_clie_settore = ads_inp.getitemstring(k_riga, "id_clie_settore")
		if len(trim(kst_tab_contratti_doc.id_clie_settore)) > 0 and kst_tab_contratti_doc.gruppo > 0 then
			kuf1_ausiliari = create kuf_ausiliari  
			kst_tab_gru.codice = kst_tab_contratti_doc.gruppo 
			kst_esito1 = kuf1_ausiliari.tb_gru_get_id_clie_settore( kst_tab_gru )
			destroy kuf1_ausiliari
			if kst_esito1.esito = kkg_esito.ok then
				if trim(kst_tab_gru.id_clie_settore) <> trim(kst_tab_contratti_doc.id_clie_settore) then
					k_errori++
					k_tipo_errore = "1"
					kst_esito.esito = kkg_esito.ERR_LOGICO
					kst_esito.sqlerrtext = "Settore non coerente con il Gruppo scelto (" + string(kst_tab_contratti_doc.gruppo) + ") ~n~r"   + trim(kst_esito.sqlerrtext)
				end if
			else
				if kst_esito1.esito <> kkg_esito.db_ko then
					k_errori++
					k_tipo_errore = "1"
					kst_esito.esito = kkg_esito.DB_KO
					kst_esito.sqlerrtext =  "Errore durante lettura Gruppo " + string(kst_tab_gru.codice ) &
									+ " err=" + string(kst_esito1.sqlcode) + " - " + trim(kst_esito1.sqlerrtext) + "~n~r"   + trim(kst_esito.sqlerrtext)
				end if
			end if
		end if

//--- check se Gruppo coerente con il Prodotto
		kst_tab_contratti_doc.art = ads_inp.getitemstring(k_riga, "art")
		kst_tab_contratti_doc.gruppo = ads_inp.getitemnumber(k_riga, "gruppo")
		if len(trim(kst_tab_contratti_doc.art)) > 0 and kst_tab_contratti_doc.gruppo > 0 then
			kuf1_prodotti = create kuf_prodotti  
			kst_tab_prodotti.codice = kst_tab_contratti_doc.art 
			kst_esito1 = kuf1_prodotti.get_gruppo( kst_tab_prodotti )
			destroy kuf1_prodotti
			if kst_esito1.esito = kkg_esito.ok then
				if kst_tab_prodotti.gruppo <> kst_tab_contratti_doc.gruppo then
					k_errori++
					k_tipo_errore = "4"
					kst_esito.esito = kkg_esito.DATI_WRN
					kst_esito.sqlerrtext = "Gruppo non coerente con l'articolo scelto (" + trim(kst_tab_contratti_doc.art) + ") ~n~r"   + trim(kst_esito1.sqlerrtext)  + trim(kst_esito.sqlerrtext)
				end if
			else
				if kst_esito1.esito <> kkg_esito.db_ko then
					k_errori++
					k_tipo_errore = "1"
					kst_esito.esito = kkg_esito.DB_KO
					kst_esito.sqlerrtext = "Errore durante lettura Articolo " + trim(kst_tab_prodotti.codice ) &
									+ " err=" + string(kst_esito1.sqlcode) + " - " + trim(kst_esito1.sqlerrtext) + "~n~r"   + trim(kst_esito.sqlerrtext)
				end if
			end if
		end if

//--- check se TIPO Quotazione presente e se coerente con il CODICE 
		kst_tab_contratti_doc.quotazione_tipo = trim(ads_inp.getitemstring(k_riga, "quotazione_tipo"))
		kst_tab_contratti_doc.quotazione_cod = trim(ads_inp.getitemstring(k_riga, "quotazione_cod"))
		if kst_tab_contratti_doc.quotazione_tipo > " " then
			if kst_tab_contratti_doc.quotazione_tipo > " " and kst_tab_contratti_doc.quotazione_cod > " "  then
				k_ctr = pos(kst_tab_contratti_doc.quotazione_cod, "-" + kst_tab_contratti_doc.quotazione_tipo + "-")
				if k_ctr = 0 then
					k_errori++
					k_tipo_errore = "4"
					kst_esito.esito = kkg_esito.DATI_WRN
					kst_esito.sqlerrtext = "Tipo Quotazione '" + kst_tab_contratti_doc.quotazione_tipo + "' non congruente con il Codice '" + kst_tab_contratti_doc.quotazione_cod + "~n~r"   + trim(kst_esito.sqlerrtext)
				end if
			end if
		else
			k_errori++
			k_tipo_errore = "3"
			kst_esito.esito = kkg_esito.DATI_INSUFF
			kst_esito.sqlerrtext = "Indicare il Tipo Quotazione" + "~n~r"   + trim(kst_esito.sqlerrtext)
		end if

//--- Nome Venditore da stampare sul Contratto 
		if k_tipo_errore = "4" or k_tipo_errore = kkg_esito.DATI_WRN or k_tipo_errore = "0" then 
			kst_tab_contratti_doc.venditore_nome = ads_inp.getitemstring(k_riga, "venditore_nome")
			if trim(kst_tab_contratti_doc.venditore_nome) > " "  then
			else
				k_errori++
				k_tipo_errore = "4"
				kst_esito.esito = kkg_esito.DATI_INSUFF
				kst_esito.sqlerrtext = "Manca il Nome del Venditore, se sconosciuto mettere un punto '.' (non verrà in stampa)~n~r"  + trim(kst_esito.sqlerrtext)
			end if
		end if

		if k_tipo_errore <> "0"  and k_tipo_errore <> "4" and k_tipo_errore <> kkg_esito.DATI_WRN then
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		k_riga++
		k_riga = ads_inp.getnextmodified(k_riga, primary!)

	loop

	
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if k_errori > 0 then
		
	end if
	
end try


return kst_esito

end function

public subroutine log_destroy ();//
if isvalid(kiuf_esito_operazioni) then destroy kiuf_esito_operazioni


 
end subroutine

public subroutine log_inizializza () throws uo_exception;//
//--- inizializza il log delle operazioni	
	if not isvalid(kiuf_esito_operazioni) then kiuf_esito_operazioni = create kuf_esito_operazioni

	kiuf_esito_operazioni.inizializza( kiuf_esito_operazioni.kki_tipo_operazione_rdco_to_listino)


 
end subroutine

private function st_esito stampa_documento_print (ref datastore kds_print, st_tab_contratti_doc ast_tab_contratti_doc);//
//=== 
//====================================================================
//=== Stampa Quotazione 
//=== per eseguire la stampa lanciare la routine "stampa_documento"
//===
//=== Par. Input:   datawindow da stampare
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:    Vedi standard 
//=== 
//====================================================================
//
int k_errore
string k_rag_soc, k_rcx
long k_rc
st_esito kst_esito
st_stampe kst_stampe
st_tab_clienti kst_tab_clienti
kuf_utility kuf1_utility
kuf_clienti kuf1_clienti


	SetPointer(kkg.pointer_attesa)

	kst_esito = kguo_exception.inizializza(this.classname())

	if kds_print.rowcount() > 0 then
		try
			get_id_cliente(ast_tab_contratti_doc)
			kst_tab_clienti.codice = ast_tab_contratti_doc.id_cliente
			kuf1_clienti = create kuf_clienti
			kuf1_clienti.get_nome(kst_tab_clienti)
			k_rag_soc = kst_tab_clienti.rag_soc_10
		catch (uo_exception kuo_exception)
			k_rag_soc = "Nessun cliente trovato"
		end try
		kuf1_utility = create kuf_utility
		k_rag_soc = kuf1_utility.u_stringa_pulisci(k_rag_soc)
		destroy kuf1_utility
		kds_print.Object.DataWindow.Print.DocumentName= "contratto_Quotazione_" + trim(string(ast_tab_contratti_doc.id_contratto_doc)) + "_" + trim(k_rag_soc) 

		kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta
		kst_stampe.ds_print = create datastore
		kst_stampe.ds_print.dataobject = kds_print.dataobject
		kds_print.rowscopy( 1, kds_print.rowcount() , primary!, kst_stampe.ds_print, 1, primary!)
//		kst_stampe.ds_print = kds_print
		kds_print.getfullstate(kst_stampe.blob_print)  // riempie il blob con il dw/ds da stampare
		kst_stampe.titolo = "Stampa Documento nr. " + string((ast_tab_contratti_doc.id_contratto_doc))
		kst_stampe.stampante_predefinita = "" 
		kst_stampe.modificafont = kuf_stampe.ki_stampa_modificafont_no

		k_errore = kGuf_data_base.stampa_dw(kst_stampe)
		if k_errore = 0 then
			kst_esito.esito = kkg_esito.OK
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Stampa Documento non effettuata! ~n~r" 
			kst_esito.esito = kkg_esito.bug
		end if

			
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Documento da stampare ~n~r" 
		kst_esito.esito = kkg_esito.bug
		
	end if

	SetPointer(kkg.pointer_default)


return kst_esito

end function

private function st_esito stampa_documento (st_tab_contratti_doc ast_tab_contratti_doc) throws uo_exception;//====================================================================
//=== 
//=== Prepara e Stampa Quotazione
//===
//=== Par. Inut:    kst_tab_contratti_doc (valorizzare il num. Documento)
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:    Vedi standard
//=== 
//====================================================================
//
long k_rc
datastore kds_print
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_contratti_doc.id_contratto_doc > 0 then		

		try

//--- Ricavo il nome del form se Documento gia' stampato
			ast_tab_contratti_doc.data_stampa = KKG.DATA_ZERO 
			get_form_di_stampa(ast_tab_contratti_doc)	

			kds_print = create datastore
			
			if len(trim(ast_tab_contratti_doc.form_di_stampa)) > 0 then  //--- se sono in ristampa allora riprendo il form originale
				kds_print.dataobject = trim(ast_tab_contratti_doc.form_di_stampa) 
			else
				kds_print.dataobject = kki_form_di_stampa_attuale 
			end if
			kds_print.settransobject(sqlca)
	
			k_rc=kds_print.settransobject(sqlca)
			
//--- retrive dell'attestato 
			k_rc=kds_print.retrieve(  ast_tab_contratti_doc.id_contratto_doc )
	
			if kds_print.rowcount() > 0 then

//--- LANCIA LA STAMPA !!!
				stampa_documento_print(kds_print, ast_tab_contratti_doc)

			end if
			
		catch (uo_exception kuo_exception)
			throw kuo_exception
			
		end try
		
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna stampa eseguita: ~n~r" + "Numero Documento non indicato"
		kst_esito.esito = kkg_esito.bug
		
	end if
	


return kst_esito

end function

public function ds_contratti_doc_select get_dati (st_tab_contratti_doc kst_tab_contratti_doc);//
//public function ds_contratti_doc_select get_dati (st_tab_contratti_doc kst_tab_contratti_doc);//
//====================================================================
//=== Torna tutt i dati del record/riga
//=== 
//=== Input: st_tab_contratti_doc.id_contratto_doc
//=== Output: ds ds_contratti_doc_select
//=== Ritorna ST_ESITO
//=== 
//====================================================================

st_esito kst_esito
ds_contratti_doc_select kds_contratti_doc_select

	
	kst_esito = kguo_exception.inizializza(this.classname())

	kds_contratti_doc_select = create ds_contratti_doc_select

	if kst_tab_contratti_doc.id_contratto_doc > 0 then
	
		kds_contratti_doc_select.retrieve(kst_tab_contratti_doc.id_contratto_doc )
		
		if kds_contratti_doc_select.kist_esito.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kds_contratti_doc_select.kist_esito.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Quotazione ~n~r:" + trim(kds_contratti_doc_select.kist_esito.SQLErrText)
		end if

	end if


return kds_contratti_doc_select



end function

public function st_esito set_dati_contratto_value (st_tab_contratti_doc kst_tab_contratti_doc, string a_key, string a_value) throws uo_exception;//
//====================================================================
//=== Update the row in  contratti_doc 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())

	if kst_tab_contratti_doc.id_contratto_doc > 0 then	
		if a_value > " " then
			a_value = trim(a_value)
		else
			setnull(a_value)
		end if
		
		a_key = '$.' + trim(a_key) 

		update contratti_doc
		     	set dati_contratto = JSON_MODIFY(dati_contratto, :a_key, :a_value)
				  where id_contratto_doc = :kst_tab_contratti_doc.id_contratto_doc
				  using kguo_sqlca_db_magazzino;
			
			
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Fallito Aggiornamento 'Quotazione' (contratti_doc): " + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if

		if kst_tab_contratti_doc.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_doc.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
		
	end if
		
catch	(uo_exception kuo_exception)
	if kuo_exception.kist_esito.esito = kkg_esito.db_ko then
		if kst_tab_contratti_doc.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_doc.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	end if
	throw kuo_exception

finally

end try
	


return kst_esito

end function

public function st_esito tb_insert (ref st_tab_contratti_doc ast_tab_contratti_doc) throws uo_exception;//
//====================================================================
//=== Insert new row in  contratti_doc 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
st_tab_contratti_doc kst_tab_contratti_doc


	try
		kst_esito = kguo_exception.inizializza(this.classname())
	
//--- controlla se utente autorizzato alla funzione in atto
	//	if_sicurezza(kkg_flag_modalita.inserimento )
	
		if_isnull(ast_tab_contratti_doc)

//--- aggiorna altri dati non JSON 
		insert into contratti_doc
					  	(offerta_data 
					  	, stampa_tradotta 
					 	, stato 
						, data_stampa 
					 	, form_di_stampa 
						, esito_operazioni_ts_operazione 
					 	, x_datins 
						, x_utente )
					values (
					  	:ast_tab_contratti_doc.offerta_data
					   , :ast_tab_contratti_doc.stampa_tradotta
					 	, :ast_tab_contratti_doc.stato
						, :ast_tab_contratti_doc.data_stampa
					 	, :ast_tab_contratti_doc.form_di_stampa
						, :ast_tab_contratti_doc.esito_operazioni_ts_operazione
					 	, :ast_tab_contratti_doc.x_datins
						, :ast_tab_contratti_doc.x_utente)
					using kguo_sqlca_db_magazzino ;
					
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Fallito Inserimento nuova 'Quotazione' " &
							+ ", dati generici (contratti_doc): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		//select SCOPE_IDENTITY() into :ast_tab_contratti_doc.id_contratto_doc from contratti_doc
		//			using kguo_sqlca_db_magazzino ;
		ast_tab_contratti_doc.id_contratto_doc = get_ultimo_id()
					
//--- aggiorna i dati del Contratto (JSON)
		kst_tab_contratti_doc = ast_tab_contratti_doc
		kst_tab_contratti_doc.st_tab_g_0.esegui_commit = "N"
		tb_update_json(kst_tab_contratti_doc)

		kst_tab_contratti_doc.st_tab_g_0.esegui_commit = ast_tab_contratti_doc.st_tab_g_0.esegui_commit
		ast_tab_contratti_doc = kst_tab_contratti_doc

		if ast_tab_contratti_doc.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_contratti_doc.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
			
	catch	(uo_exception kuo_exception)
		if kuo_exception.kist_esito.esito = kkg_esito.db_ko then
			if ast_tab_contratti_doc.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_contratti_doc.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			kguo_exception.scrivi_log( )
		end if
		throw kuo_exception
	
	finally
	
	end try
		


return kst_esito

end function

public function st_esito tb_update (ref st_tab_contratti_doc ast_tab_contratti_doc) throws uo_exception;//
//====================================================================
//=== Update the row in  contratti_doc 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
st_tab_contratti_doc kst_tab_contratti_doc


	try
		kst_esito = kguo_exception.inizializza(this.classname())
	
//--- controlla se utente autorizzato alla funzione in atto
	//	if_sicurezza(kkg_flag_modalita.modifica )
	
		if ast_tab_contratti_doc.id_contratto_doc > 0 then
	
			if_isnull(ast_tab_contratti_doc)

//--- aggiorna i dati del Contratto (JSON)
			kst_tab_contratti_doc = ast_tab_contratti_doc
			kst_tab_contratti_doc.st_tab_g_0.esegui_commit = "N"
			tb_update_json(kst_tab_contratti_doc)
			
			kst_tab_contratti_doc.st_tab_g_0.esegui_commit = ast_tab_contratti_doc.st_tab_g_0.esegui_commit
			ast_tab_contratti_doc = kst_tab_contratti_doc

//--- aggiorna altri dati non JSON 
			update contratti_doc
					 set 
					  	offerta_data = :ast_tab_contratti_doc.offerta_data
					  	, stampa_tradotta = :ast_tab_contratti_doc.stampa_tradotta
					 	, stato = :ast_tab_contratti_doc.stato
						, data_stampa = :ast_tab_contratti_doc.data_stampa
					 	, form_di_stampa = :ast_tab_contratti_doc.form_di_stampa
						, esito_operazioni_ts_operazione = :ast_tab_contratti_doc.esito_operazioni_ts_operazione
					 	, x_datins = :ast_tab_contratti_doc.x_datins
						, x_utente = :ast_tab_contratti_doc.x_utente
					where id_contratto_doc = :ast_tab_contratti_doc.id_contratto_doc
					using kguo_sqlca_db_magazzino ;
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Fallito Aggiornamento 'Quotazione' " + string(ast_tab_contratti_doc.id_contratto_doc) &
								+ ", dati vari e di ultimo aggiornamento (contratti_doc): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

			if ast_tab_contratti_doc.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_contratti_doc.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			
		end if
		
	catch	(uo_exception kuo_exception)
		if kuo_exception.kist_esito.esito = kkg_esito.db_ko then
			if ast_tab_contratti_doc.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_contratti_doc.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			kguo_exception.scrivi_log( )
		end if
		throw kuo_exception
	
	finally
	
	end try
		


return kst_esito

end function

private function st_esito tb_update_json (ref st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception;//
//====================================================================
//=== Update/Insert the row in  contratti_doc campo JSON
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
int k_idx, k_idx_max, k_insert
string k_json_key[100]
string k_json_val[100]
string k_vuoto[100]
string k_json
st_esito kst_esito
kuf_utility kuf1_utility

	try
		kst_esito = kguo_exception.inizializza(this.classname())
		kuf1_utility = create kuf_utility
		
		if kst_tab_contratti_doc.id_contratto_doc > 0 then
	
	//--- pulizia di tutto il campo JSON
//						 set dati_contratto = JSON_MODIFY(dati_contratto, '$.voci', NULL)
			update contratti_doc
				 set dati_contratto = '{}'
						where id_contratto_doc = :kst_tab_contratti_doc.id_contratto_doc
						using kguo_sqlca_db_magazzino ;
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Fallito Aggiornamento 'Quotazione'  " + string(kst_tab_contratti_doc.id_contratto_doc) &
							+ ", pulizia area dati (contratti_doc): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

	//--- compone i campi JSON		
		//	kst_tab_contratti_doc.dati_contratto = "
			k_idx_max = 0
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "quotazione_cod"
			k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.quotazione_cod))		
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "quotazione_tipo"
			k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.quotazione_tipo))		
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "anno"
			k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.anno))
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "magazzino"
			k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.magazzino))			
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "offerta_validita"
			k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.offerta_validita))
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "data_inizio"
			if isdate(string(kst_tab_contratti_doc.data_inizio)) and kst_tab_contratti_doc.data_inizio > kkg.data_no then
				k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.data_inizio))
			else
			 	setnull(k_json_val[k_idx_max]) 
			end if
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "data_fine"
			if isdate(string(kst_tab_contratti_doc.data_fine)) and kst_tab_contratti_doc.data_fine > kkg.data_no then
			 	k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.data_fine))
			else
			 	setnull(k_json_val[k_idx_max]) 
			end if
			
			if trim(string(kst_tab_contratti_doc.oggetto)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "oggetto"
				k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.oggetto))
			end if
			if trim(string(kst_tab_contratti_doc.id_clie_settore)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "id_clie_settore"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.id_clie_settore))
			end if							  
			if trim(string(kst_tab_contratti_doc.gruppo))  > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "gruppo"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.gruppo))
			end if							  
			if trim(string(kst_tab_contratti_doc.art)) > " " then 
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "art"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.art))
			end if							  
			if trim(string(kst_tab_contratti_doc.cliente_desprod)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "cliente_desprod"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.cliente_desprod))
			end if							  
			if trim(string(kst_tab_contratti_doc.cliente_desprod_rid)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "cliente_desprod_rid"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.cliente_desprod_rid))
			end if							  
			if trim(string(kst_tab_contratti_doc.id_cliente)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "id_cliente"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.id_cliente))
			end if							  
			if trim(string(kst_tab_contratti_doc.id_docprod)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "id_docprod"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.id_docprod))
			end if							  
			if trim(string(kst_tab_contratti_doc.nome_contatto)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "nome_contatto"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.nome_contatto))
			end if							  
			if trim(string(kst_tab_contratti_doc.note_fasi_operative)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "note_fasi_operative"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.note_fasi_operative))
			end if							  
			if trim(string(kst_tab_contratti_doc.note)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "note"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.note))
			end if							  
			if trim(string(kst_tab_contratti_doc.note_audit)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "note_audit"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.note_audit))
			end if							  
			if trim(string(kst_tab_contratti_doc.id_listino_pregruppo)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "id_listino_pregruppo"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.id_listino_pregruppo))
			end if							  
			if trim(string(kst_tab_contratti_doc.totale_contratto)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "totale_contratto"
								  k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.totale_contratto)), true)	
			end if							  
				
			if trim(string(kst_tab_contratti_doc.iva)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "iva"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.iva))
			end if							  
			if trim(string(kst_tab_contratti_doc.cod_pag)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "cod_pag"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.cod_pag))
			end if							  
			if trim(string(kst_tab_contratti_doc.banca)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "banca"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.banca))
			end if							  
			if trim(string(kst_tab_contratti_doc.abi)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "abi"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.abi))
			end if							  
			if trim(string(kst_tab_contratti_doc.cab)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "cab"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.cab))
			end if							  
			if trim(string(kst_tab_contratti_doc.acconto_perc)) > " " then	
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "acconto_perc"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.acconto_perc))	
			end if							  
								  
			if trim(string(kst_tab_contratti_doc.acconto_imp)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "acconto_imp"
								  k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.acconto_imp)), true)	
			end if							  
								  
			if trim(string(kst_tab_contratti_doc.acconto_cod_pag)) > " " then		
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "acconto_cod_pag"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.acconto_cod_pag))		
			end if							  
			if trim(string(kst_tab_contratti_doc.fattura_da)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "fattura_da"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.fattura_da))
			end if							  
			
			if trim(string(kst_tab_contratti_doc.altre_condizioni)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "altre_condizioni"
								  k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.altre_condizioni))
			end if							  
			if trim(string(kst_tab_contratti_doc.flg_fatt_dopo_valid)) > " " then	
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "flg_fatt_dopo_valid"
				k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.flg_fatt_dopo_valid))	
			end if
			if trim(string(kst_tab_contratti_doc.id_meca_causale)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "id_meca_causale"
				k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.id_meca_causale))
			end if							  
			
			if trim(string(kst_tab_contratti_doc.dose)) > " " then	 
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "dose"; k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.dose)), true)	 
			end if							  
			if trim(string(kst_tab_contratti_doc.note_qtax)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "note_qtax"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.note_qtax))
			end if							  
			if trim(string(kst_tab_contratti_doc.impon_minimo)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "impon_minimo"; k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.impon_minimo)), true)
			end if							  
			if trim(string(kst_tab_contratti_doc.e1itmdosim)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "e1itmdosim"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.e1itmdosim))
			end if							  
			if trim(string(kst_tab_contratti_doc.e1itmdosimprezzo)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "e1itmdosimprezzo"; k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.e1itmdosimprezzo)), true)
			end if							  
			if trim(string(kst_tab_contratti_doc.contratti_des)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "contratti_des"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.contratti_des))
			end if							  
			if trim(string(kst_tab_contratti_doc.id_sd_md)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "id_sd_md"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.id_sd_md))
			end if							  
			if trim(string(kst_tab_contratti_doc.sk_dose_map_des)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "sk_dose_map_des"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.sk_dose_map_des))
			end if							  
			
			if trim(string(kst_tab_contratti_doc.gest_doc_prezzo)) > " " then 
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "gest_doc_prezzo"; k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.gest_doc_prezzo)), true) 
			end if							  
			if trim(string(kst_tab_contratti_doc.gest_doc_des)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "gest_doc_des"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.gest_doc_des))
			end if							  
			if trim(string(kst_tab_contratti_doc.dir_tecnico_prezzo)) > " " then 
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "dir_tecnico_prezzo"; k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.dir_tecnico_prezzo)), true) 
			end if							  
			if trim(string(kst_tab_contratti_doc.dir_tecnico_des)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "dir_tecnico_des"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.dir_tecnico_des))
			end if							  
			if trim(string(kst_tab_contratti_doc.analisi_lab_prezzo)) > " " then 
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "analisi_lab_prezzo"; k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.analisi_lab_prezzo)), true) 
			end if							  
			if trim(string(kst_tab_contratti_doc.analisi_lab_des)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "analisi_lab_des"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.analisi_lab_des))
			end if							  
			if trim(string(kst_tab_contratti_doc.dosim_agg_prezzo)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "dosim_agg_prezzo"; k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.dosim_agg_prezzo)), true)
			end if							  
			if trim(string(kst_tab_contratti_doc.dosim_agg_des)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "dosim_agg_des"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.dosim_agg_des))
			end if							  
			if trim(string(kst_tab_contratti_doc.logistica_prezzo)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "logistica_prezzo"; k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.logistica_prezzo)), true)
			end if							  
			if trim(string(kst_tab_contratti_doc.logistica_des)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "logistica_des"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.logistica_des))
			end if							  
			if trim(string(kst_tab_contratti_doc.stoccaggio_prezzo)) > " " then 
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "stoccaggio_prezzo"; k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.stoccaggio_prezzo)), true) 
			end if							  
			if trim(string(kst_tab_contratti_doc.stoccaggio_des)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "stoccaggio_des"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.stoccaggio_des))
			end if							  
			if trim(string(kst_tab_contratti_doc.altro_prezzo)) > " " then 
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "altro_prezzo"; k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.altro_prezzo)), true) 
			end if							  
			if trim(string(kst_tab_contratti_doc.altro_des)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "altro_des"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.altro_des))
			end if							  
			if trim(string(kst_tab_contratti_doc.note_interne)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "note_interne"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.note_interne))
			end if							  
			if trim(string(kst_tab_contratti_doc.rif_interno_alt)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "rif_interno_alt"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.rif_interno_alt))
			end if							  
			if trim(string(kst_tab_contratti_doc.venditore_nome)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "venditore_nome"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.venditore_nome))
			end if							  
			
			if trim(string(kst_tab_contratti_doc.venditore_ruolo)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "venditore_ruolo"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.venditore_ruolo))
			end if							  
			if trim(string(kst_tab_contratti_doc.treat_validate)) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "treat_validate"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.treat_validate))
			end if							  
			
			if trim(string(kst_tab_contratti_doc.unita_misura[1])) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "unita_misura"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.unita_misura[1]))
			end if							  
			if trim(string(kst_tab_contratti_doc.mis_z[1])) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "mis_z_1"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.mis_z[1]))
			end if							  
			if trim(string(kst_tab_contratti_doc.mis_x[1])) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "mis_x_1"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.mis_x[1]))
			end if							  
			if trim(string(kst_tab_contratti_doc.mis_y[1])) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "mis_y_1"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.mis_y[1]))
			end if							  
			if trim(string(kst_tab_contratti_doc.dose_min[1])) > " " then	 
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "dose_min"; k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.dose_min[1])), true)	 
			end if							  
			if trim(string(kst_tab_contratti_doc.dose_max[1])) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "dose_max"; k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.dose_max[1])), true)
			end if							  
			if trim(string(kst_tab_contratti_doc.density_x[1])) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "density_x"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.density_x[1]))
			end if							  
			if trim(string(kst_tab_contratti_doc.peso_max_kg[1])) > " " then	 
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "peso_max_kg"; k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.peso_max_kg[1])), true)	 
			end if							  
			if trim(string(kst_tab_contratti_doc.e1litm[1])) > " " then
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "e1litm"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.e1litm[1]))
			end if							  
			if trim(string(kst_tab_contratti_doc.prezzo[1])) > " " then	 
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "prezzo_1"; k_json_val[k_idx_max] = kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.prezzo[1])), true)	 
			end if							  
			if trim(string(kst_tab_contratti_doc.prezzo[1])) > " " then	 
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "code_our"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.code_our[1]))
			end if							  
			if trim(string(kst_tab_contratti_doc.prezzo[1])) > " " then	 
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "qaa"; k_json_val[k_idx_max] = trim(string(kst_tab_contratti_doc.qaa[1]))
			end if							  

			kguo_sqlca_db_magazzino.sqlcode = 0
			k_idx = 0
			do while k_idx < k_idx_max and kguo_sqlca_db_magazzino.sqlcode = 0 
				k_idx ++
				update contratti_doc
						 set dati_contratto = replace(JSON_MODIFY(dati_contratto, :k_json_key[k_idx], :k_json_val[k_idx]), '\/', '/')
    														//	 , JSON_QUERY(:k_json_value))
						where id_contratto_doc = :kst_tab_contratti_doc.id_contratto_doc
						using kguo_sqlca_db_magazzino ;
			loop
			
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Fallito Aggiornamento 'Quotazione' " + string(kst_tab_contratti_doc.id_contratto_doc) &
								+ ", campo: " + k_json_key[k_idx] &
								+ " valore: "+ k_json_val[k_idx] + " (contratti_doc). " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

			k_json_val[] = k_vuoto[]
			k_json_key[] = k_vuoto[]
			
//--- Aggiungi l'array 'VOCI IRR' dal SECONDO item (il primo vedi sopra)
			k_insert = 0
			k_idx = 1
			kguo_sqlca_db_magazzino.sqlcode = 0 
			k_idx_max = upperbound(kst_tab_contratti_doc.unita_misura[])
			do while k_idx < k_idx_max and kguo_sqlca_db_magazzino.sqlcode = 0 
				k_idx ++
				
				if kst_tab_contratti_doc.unita_misura[k_idx] > " " &
										or kst_tab_contratti_doc.e1litm[k_idx] > " " &
										or kst_tab_contratti_doc.mis_z[k_idx] > 0 &
										or kst_tab_contratti_doc.mis_x[k_idx] > 0 &
										or kst_tab_contratti_doc.mis_y[k_idx] > 0 &
										or kst_tab_contratti_doc.dose_min[k_idx] > 0 &
										or kst_tab_contratti_doc.dose_max[k_idx] > 0 &
										or kst_tab_contratti_doc.peso_max_kg[k_idx] > 0 &
										or kst_tab_contratti_doc.prezzo[k_idx] > 0 &
										or kst_tab_contratti_doc.density_x[k_idx] > " " &
										or kst_tab_contratti_doc.code_our[k_idx] > " " &
										or kst_tab_contratti_doc.qaa[k_idx] > " " &
									then
					k_insert ++
					k_json_val[k_insert] = "{~"unita_misura~": ~"" + trim(string(kst_tab_contratti_doc.unita_misura[k_idx])) + "~"" &
											+ ", ~"mis_z~": " + trim(string(kst_tab_contratti_doc.mis_z[k_idx])) + "" &
											+ ", ~"mis_x~": " +  trim(string(kst_tab_contratti_doc.mis_x[k_idx])) + "" &
											+ ", ~"mis_y~": " +  trim(string(kst_tab_contratti_doc.mis_y[k_idx])) + "" &
			 								+ ", ~"dose_min~": " + kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.dose_min[k_idx])), true) + "" &
			 								+ ", ~"dose_max~": " + kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.dose_min[k_idx])), true) + "" &
											+ ", ~"density_x~": ~"" + trim(string(kst_tab_contratti_doc.density_x[k_idx])) + "~"" &
											+ ", ~"peso_max_kg~": ~"" + kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.peso_max_kg[k_idx])), true) + "~"" &
											+ ", ~"e1litm~": ~"" + trim(string(kst_tab_contratti_doc.e1litm[k_idx])) + "~"" &
			 								+ ", ~"prezzo~": " +  kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.prezzo[k_idx])), true) + "" &
			 								+ ", ~"code_our~": ~"" + trim(string(kst_tab_contratti_doc.code_our[k_idx])) + "~"" &
			 								+ ", ~"qaa~": ~"" + trim(string(kst_tab_contratti_doc.qaa[k_idx])) + "~"" &
											+ "}"
			
					if k_insert = 1 then
						k_json_val[k_insert] = "[" + k_json_val[k_insert] + "]"
						update contratti_doc
								 set dati_contratto = JSON_MODIFY(dati_contratto, '$.voci_irr', JSON_QUERY(:k_json_val[k_insert]))
								where id_contratto_doc = :kst_tab_contratti_doc.id_contratto_doc
								using kguo_sqlca_db_magazzino ;
					else

						update contratti_doc
								 set dati_contratto = JSON_MODIFY(dati_contratto, 'append $.voci_irr', JSON_QUERY(:k_json_val[k_insert]))
								where id_contratto_doc = :kst_tab_contratti_doc.id_contratto_doc
								using kguo_sqlca_db_magazzino ;
					end if
				end if
				
			loop

			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Fallito Aggiornamento 'Quotazione'  " + string(kst_tab_contratti_doc.id_contratto_doc) &
							+ ", campo: " + k_json + " valore: " + k_json_val[k_idx] + "(contratti_doc): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			
			k_json_val[] = k_vuoto[]
			k_json_key[] = k_vuoto[]

//--- Aggiungi l'array VOCI VAL
			k_insert = 0
			k_idx = 0
			k_idx_max = upperbound(kst_tab_contratti_doc.id_listino_voce[])
			do while k_idx < k_idx_max and kguo_sqlca_db_magazzino.sqlcode = 0 
				k_idx ++
				
				if kst_tab_contratti_doc.id_listino_voce[k_idx] > 0 &
										or trim(kst_tab_contratti_doc.descr[k_idx]) > " " &
										or kst_tab_contratti_doc.voce_prezzo[k_idx] > 0 &
										or kst_tab_contratti_doc.voce_prezzo_tot[k_idx] > 0 &
										or kst_tab_contratti_doc.voce_qta[k_idx] > 0 then
					k_insert ++
					k_json_val[k_insert] = "{~"id_listino_voce~": ~"" +  trim(string(kst_tab_contratti_doc.id_listino_voce[k_idx])) + "~"" &
											+ ", ~"descr~": ~"" +  trim(kst_tab_contratti_doc.descr[k_idx]) + "~"" & 
											+ ", ~"voce_prezzo~": " +  kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.voce_prezzo[k_idx])), true) + "" &
			 								+ ", ~"voce_prezzo_tot~": " +  kuf1_utility.u_num_itatousa2(trim(string(kst_tab_contratti_doc.voce_prezzo_tot[k_idx])), true) + "" &
											+ ", ~"voce_qta~": ~"" +  trim(string(kst_tab_contratti_doc.voce_qta[k_idx])) + "~"" &
											+ ", ~"flg_st_voce~": ~"" +  trim(string(kst_tab_contratti_doc.flg_st_voce[k_idx])) + "~"" &
											+ "}"
					if k_insert = 1 then
						k_json_val[k_insert] = "[" + k_json_val[k_insert] + "]"
						update contratti_doc
							 set dati_contratto = JSON_MODIFY(dati_contratto, '$.voci', JSON_QUERY(:k_json_val[k_insert]))
							where id_contratto_doc = :kst_tab_contratti_doc.id_contratto_doc
							using kguo_sqlca_db_magazzino ;
					else
						update contratti_doc
							 set dati_contratto = JSON_MODIFY(dati_contratto, 'append $.voci', JSON_QUERY(:k_json_val[k_insert]))
							where id_contratto_doc = :kst_tab_contratti_doc.id_contratto_doc
							using kguo_sqlca_db_magazzino ;
					end if
				end if
				
			loop

			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Fallito Aggiornamento 'Quotazione'  " + string(kst_tab_contratti_doc.id_contratto_doc) &
							+ ", campo: " + k_json + " valore: " + k_json_val[k_idx] + "(contratti_doc): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

			
			if kst_tab_contratti_doc.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_doc.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			
		end if
		
	catch	(uo_exception kuo_exception)
		if kuo_exception.kist_esito.esito = kkg_esito.db_ko then
			if kst_tab_contratti_doc.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_doc.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			kguo_exception.scrivi_log( )
		end if
		throw kuo_exception
	
	finally
		if isvalid(kuf1_utility) then destroy kuf1_utility
	
	end try
		


return kst_esito

end function

public function long u_conv_to_conferma_ordine_e_listini (st_tab_contratti_doc kst_tab_contratti_doc, st_contratti_doc_to_listini kst_contratti_doc_to_listini) throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- Alimenta tabella Conferma Ordine (CO) e Listini da Quotazione 
//---
//--- inp: kst_tab_contratti_doc.id_contratto_doc,  st_contratti_doc_to_listini x sapere se simulazione ecc... o meno
//--- out: -
//--- ritorna: nr contratti commerciali Trasferiti
//--- lancia Exception: uo_exception x errore grave
//---
//---
//---------------------------------------------------------------------------------------------------------------------------------------------------
//
long k_ctr_contratti_doc_trasferiti=0
long k_ctr_st_tab_contratti=1, k_ctr=0, k_ctr_max, k_ctr_contratti_doc_to_listini=0, k_ctr_ins_contratti=0
int k_nr_capitolato
string k_capitolati[]
st_tab_gru kst_tab_gru
st_tab_listino kst_tab_listino
st_tab_contratti kst_tab_contratti[], kst_tab_contratti_select
st_tab_sd_md kst_tab_sd_md
st_tab_esito_operazioni kst_tab_esito_operazioni
st_esito kst_esito
kuf_sl_pt kuf1_sl_pt
kuf_contratti kuf1_contratti
kuf_ausiliari kuf1_ausiliari
datastore kds_contratti_doc


try 
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	kuf1_ausiliari = create kuf_ausiliari
	kuf1_contratti = create kuf_contratti

	

//--- legge i dati del Quotazione
	kds_contratti_doc = create datastore
	kds_contratti_doc.dataobject = "ds_contratti_doc"
	kds_contratti_doc.settransobject( sqlca)
	if kds_contratti_doc.retrieve(kst_tab_contratti_doc.id_contratto_doc) > 0 then
	
		kst_tab_contratti[k_ctr_st_tab_contratti].cert_st_dose_min =  "N"
		kst_tab_contratti[k_ctr_st_tab_contratti].sc_cf = ""
		kst_tab_contratti[k_ctr_st_tab_contratti].sl_pt = ""
	
		kst_tab_contratti[k_ctr_st_tab_contratti].codice = 0
		//kst_tab_contratti[k_ctr_st_tab_contratti].mc_co = trim(kds_contratti_doc.getitemstring(1, "quotazione_tipo")) + string(kst_tab_contratti_doc.id_contratto_doc) + "/" + string(kds_contratti_doc.getitemnumber(1, "anno"), "0000")
		kst_tab_contratti[k_ctr_st_tab_contratti].mc_co = string(kst_tab_contratti_doc.id_contratto_doc) + "/" + string(kds_contratti_doc.getitemnumber(1, "anno"), "0000")
		
		kst_tab_contratti[k_ctr_st_tab_contratti].cod_cli = kds_contratti_doc.getitemnumber(1, "id_cliente")
		kst_tab_contratti[k_ctr_st_tab_contratti].contratto_co_data_ins = kGuf_data_base.prendi_dataora( )
		kst_tab_contratti[k_ctr_st_tab_contratti].id_contratto_co = kst_tab_contratti_doc.id_contratto_doc
	
		kst_tab_contratti[k_ctr_st_tab_contratti].data = kds_contratti_doc.getitemdate(1, "data_inizio")
		kst_tab_contratti[k_ctr_st_tab_contratti].data_scad = kds_contratti_doc.getitemdate(1, "data_fine")
		kst_tab_contratti[k_ctr_st_tab_contratti].flg_fatt_dopo_valid = kds_contratti_doc.getitemstring(1, "flg_fatt_dopo_valid")
		kst_tab_contratti[k_ctr_st_tab_contratti].id_meca_causale = kds_contratti_doc.getitemnumber(1, "id_meca_causale")
		if kds_contratti_doc.getitemnumber(1, "acconto_imp") > 0 then
			kst_tab_contratti[k_ctr_st_tab_contratti].flg_acconto = kuf1_contratti.kki_flg_acconto_si
		else
			kst_tab_contratti[k_ctr_st_tab_contratti].flg_acconto = kuf1_contratti.kki_flg_acconto_no
		end if	
		
		kst_tab_contratti[k_ctr_st_tab_contratti].tipo = kuf1_contratti.kki_tipo_deposito
		
//--- aggiunge riga al log
		if kst_contratti_doc_to_listini.k_simulazione = "N"  then // se non sono in simulazione eseguo!
			kiuf_esito_operazioni.tb_add_riga("-----------> Inizio 'TRASFERIMENTO' Quotazione: " + kst_tab_contratti[k_ctr_st_tab_contratti].mc_co &
							+ " del Cliente " + string(kst_tab_contratti[k_ctr_st_tab_contratti].cod_cli) + "; carico in automatico CO / LISTINI<-----------", false)
		else
			if kst_contratti_doc_to_listini.k_simulazione = "S"  then // se sono in simulazione eseguo!
				kiuf_esito_operazioni.tb_add_riga("-----------> Inizio SIMULAZIONE trasferimento Quotazione: " + kst_tab_contratti[k_ctr_st_tab_contratti].mc_co &
							+ " del Cliente " + string(kst_tab_contratti[k_ctr_st_tab_contratti].cod_cli) + "<-----------", false)
			else
				kiuf_esito_operazioni.tb_add_riga("-----------> Inizio 'TRASFERIMENTO' Quotazione: " + kst_tab_contratti[k_ctr_st_tab_contratti].mc_co &
							+ " del Cliente " + string(kst_tab_contratti[k_ctr_st_tab_contratti].cod_cli) + "; Caricare manualmente CO e LISTINI<-----------", false)
			end if
		end if


//--- piglio la descrizione del Gruppo
		if kds_contratti_doc.getitemnumber(1, "gruppo") > 0 then
			kst_tab_gru.codice = kds_contratti_doc.getitemnumber(1, "gruppo") 
			kst_esito = kuf1_ausiliari.tb_select(kst_tab_gru)
			if kst_esito.esito = kkg_esito.ok then
				kst_tab_contratti[k_ctr_st_tab_contratti].descr = trim(kst_tab_gru.des ) 
			else
				kst_tab_contratti[k_ctr_st_tab_contratti].descr = "Gruppo " + string(kds_contratti_doc.getitemnumber(1, "gruppo")) + " non trovato "
			end if
		end if

//--- get Cliente da Quotazione
		kst_tab_contratti[k_ctr_st_tab_contratti].cod_cli = kds_contratti_doc.getitemnumber(1,"id_cliente")
		
	//--- se CAPITOLATI presenti attivo 'stampa della DOSE MINIMA'
		if len(trim(kds_contratti_doc.getitemstring(1, "contratti_des"))) > 0 then
			kst_tab_contratti[k_ctr_st_tab_contratti].cert_st_dose_min =  "S"
		end if
	
	//--- get SC_CF dal campo CAPITOLATI (possono essere saparati da ; se ne ho più di uno)
		if len(trim(kds_contratti_doc.getitemstring(1, "contratti_des"))) > 0 then
			
			k_nr_capitolato = kuf1_contratti.get_capitolati(kds_contratti_doc.getitemstring(1, "contratti_des"), k_capitolati[]) // Spacchetto CAMPO CAPITOLATI
			k_ctr_max = k_nr_capitolato + k_ctr_st_tab_contratti - 1
	
			for k_ctr = k_ctr_st_tab_contratti to k_ctr_max
				
				if k_ctr > k_ctr_st_tab_contratti then  //--- se ho trovato + capitolati ribalto anche gli altri dati 
				
					kst_tab_contratti[k_ctr] = kst_tab_contratti[k_ctr - 1]
				
				end if
				
				kst_tab_contratti[k_ctr].sc_cf = k_capitolati[k_ctr - k_ctr_st_tab_contratti + 1]

//--- get del SL_PT da Capitolato
				kst_tab_contratti[k_ctr].sl_pt = kuf1_contratti.get_sl_pt(kst_tab_contratti[k_ctr].sc_cf)
//--- get Cliente da Capitolato NON PIU' IL 12/1/2010 LO HA DETTO LA BARBARA
//					kst_tab_contratti[k_ctr_st_tab_contratti].cod_cli = kuf1_contratti.get_cod_cli(kst_tab_contratti[k_ctr].sc_cf)
				kiuf_esito_operazioni.tb_add_riga("estratto il Capitolato: " + trim(kst_tab_contratti[k_ctr].sc_cf) + "; e il PT: " + trim(kst_tab_contratti[k_ctr].sl_pt) + " ", false)
				
			end for
	
			k_ctr_st_tab_contratti = k_ctr_max //03.02.2016 k_ctr - 1
		
		else
				
	//--- se indicato almeno il Dose-Mapping, piglio il SL_PT	
			if kds_contratti_doc.getitemnumber(1, "id_sd_md") > 0 then
				kst_tab_sd_md.id_sd_md = kds_contratti_doc.getitemnumber(1, "id_sd_md")
				kiuf_esito_operazioni.tb_add_riga("estratto il Dose-Mapping id: " + string(kst_tab_sd_md.id_sd_md) + " ", false)
				kst_esito = kuf1_contratti.get_sl_pt(kst_tab_sd_md)
				if kst_esito.esito = kkg_esito.ok then
					kst_tab_contratti[k_ctr_st_tab_contratti].sl_pt = kst_tab_sd_md.sl_pt
				else
					kst_tab_contratti[k_ctr_st_tab_contratti].sl_pt = ""
				end if
				kiuf_esito_operazioni.tb_add_riga("estratto il PT: " + trim(kst_tab_contratti[k_ctr_st_tab_contratti].sl_pt) + " ", false)
			end if
			
		end if
		
		
//--- se ho trovato errore Grave lancio eccezione
		if kst_esito.esito = kkg_esito.db_ko then
			kst_esito.sqlerrtext = "Errore durante lettura descrizione Gruppo codice " + string(kst_tab_gru.codice) + " (Contratto non Trasferito a Listino).  ~n~r" + kst_esito.sqlerrtext 
			kGuo_exception.set_esito(kst_esito) 
			kiuf_esito_operazioni.tb_add_riga(kst_esito.sqlerrtext, true) //--- aggiunge riga al log
			throw kGuo_exception
		end if


//--- Carico Conferme Ordine e Listini 
		for  k_ctr_ins_contratti = 1 to k_ctr_st_tab_contratti 
			
			if len(trim(kst_tab_contratti[k_ctr_ins_contratti].mc_co)) > 0 then 
				
				if kst_contratti_doc_to_listini.k_simulazione = "M" then // se carico arch. MANUALMENTE='M' allora non fa nulla
					kst_esito.sqlerrtext = "operazione di SIMULAZIONE Conferma Ordine non caricata  ~n~r"
				else
				
//--- Controlla l'esistenza del CO se già esiste NON carico
					kst_tab_contratti_select = kst_tab_contratti[k_ctr_ins_contratti]
					kst_tab_contratti[k_ctr_ins_contratti].codice = kuf1_contratti.if_esiste_co_x_mc_co(kst_tab_contratti_select) //if_esiste_co(kst_tab_contratti_select) 
					if kst_tab_contratti[k_ctr_ins_contratti].codice = 0 then
				
//--- Aggiunge Conferma Ordine  CO
//						if kst_contratti_doc_to_listini.k_simulazione = "N"  then // se non sono in simulazione eseguo!
							kst_tab_contratti[k_ctr_ins_contratti].st_tab_g_0.esegui_commit = "N"
							kst_tab_contratti[k_ctr_ins_contratti].codice = kuf1_contratti.tb_add(kst_tab_contratti[k_ctr_ins_contratti]) // ADD DEL CO
							kst_esito.sqlerrtext = "Conferma Ordine caricata con il codice " + string(kst_tab_contratti[k_ctr_ins_contratti].codice) + ".  ~n~r"
							kiuf_esito_operazioni.tb_add_riga(kst_esito.sqlerrtext, true) //--- aggiunge riga al log
//						end if
					else
//--- aggiunge riga al log
						kst_esito.sqlerrtext = "Conferma Ordine già presente nel codice " + string(kst_tab_contratti[k_ctr_ins_contratti].codice) + " (non generata).  ~n~r"
						kiuf_esito_operazioni.tb_add_riga(kst_esito.sqlerrtext, true) //--- aggiunge riga al log
					end if
				
//--- carico LISTINO
					kst_tab_listino.st_tab_g_0.esegui_commit = "N"
					kst_tab_listino.id = this.u_conv_conferma_ordine_to_listino(kds_contratti_doc,  kst_tab_contratti[k_ctr_ins_contratti], kst_contratti_doc_to_listini)  // ADD DEL LISTINO
						
				end if  
					
//--- Aggiorna lo STATO del Quotazione a TRASFERITO
//				if kst_contratti_doc_to_listini.k_simulazione <> "S" then
					
					k_ctr_contratti_doc_trasferiti++  //nr contratti trasferiti
					
					kst_tab_contratti_doc.st_tab_g_0.esegui_commit = "N"
					kst_esito = set_trasferito(kst_tab_contratti_doc)
					if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
						kst_esito.sqlerrtext = "Quotazione Trasferita a Listino ma 'STATO' non aggiornato.  ~n~r" + kst_esito.sqlerrtext 
						kGuo_exception.set_esito(kst_esito) 
						kiuf_esito_operazioni.tb_add_riga(kst_esito.sqlerrtext, true) //--- aggiunge riga al log
						throw kGuo_exception
					end if

//				else
//--- aggiunge riga al log
//					kiuf_esito_operazioni.tb_add_riga("simulazione di carico del Listino corretta ", false)
//				end if
				
				
//--- Visto che tutto OK COMMIT			
				if kst_contratti_doc_to_listini.k_simulazione <> "S" then
					kst_esito = kguo_sqlca_db_magazzino.db_commit( )  //COMMIT
//--- se ho trovato errore Grave lancio eccezione
					if kst_esito.esito = kkg_esito.ok then
						k_ctr_contratti_doc_to_listini ++
//--- aggiunge riga al log
						kiuf_esito_operazioni.tb_add_riga("caricato il Listino codice: " + string(kst_tab_listino.id), false)
					else
						kGuf_data_base.db_rollback_1( )  //ROLLBACK 
						kst_esito.sqlerrtext = "Errore in elaborazione Quotazione nr. " + string(kst_tab_contratti_doc.id_contratto_doc) + " (non Trasferito).  ~n~r" + kst_esito.sqlerrtext 
						kGuo_exception.set_esito(kst_esito) 
						kiuf_esito_operazioni.tb_add_riga(kst_esito.sqlerrtext, true) //--- aggiunge riga al log
						throw kGuo_exception
					end if
				else
//--- aggiunge riga al log
					kst_esito = kguo_sqlca_db_magazzino.db_rollback( )  //SIMULAZIONE FACCIO ROLLBACK
					kiuf_esito_operazioni.tb_add_riga("simulazione di carico Conferma Ordine corretta ", false)
				end if
				
				
			end if
			
		end for
		
	else

//--- contratto NON TROVATO
		kst_esito.sqlerrtext = "Quotazione non Trovata!   " 
		kGuo_exception.set_esito(kst_esito) 
		kiuf_esito_operazioni.tb_add_riga(kst_esito.sqlerrtext, true) //--- aggiunge riga al log
		throw kGuo_exception
		
	end if

//--- SE ERRORE	
catch (uo_exception kuo_exception)
	if kst_contratti_doc_to_listini.k_simulazione <> "S" and k_ctr_contratti_doc_to_listini > 0 then
		kguo_sqlca_db_magazzino.db_rollback( )  //ROLLBACK 
	end if
	kst_esito = kuo_exception.get_st_esito()
	kst_esito.sqlerrtext = "Errore durante elaborazione Quotazione nr. " + string(kst_tab_contratti_doc.id_contratto_doc) + ".  ~n~r" + kst_esito.sqlerrtext 
	kuo_exception.set_esito(kst_esito)
	kiuf_esito_operazioni.tb_add_riga(kst_esito.sqlerrtext, true ) //--- aggiunge riga al log
	throw kuo_exception


finally 
	

//--- aggiunge riga FINALE al log
	if kst_contratti_doc_to_listini.k_simulazione = "N"  then // se non sono in simulazione eseguo!
		kiuf_esito_operazioni.tb_add_riga("-----------> Fine carico archivi, trasferito Quotazione: " + string(kst_tab_contratti_doc.id_contratto_doc) + " <----------- ", false)
	else
		if kst_contratti_doc_to_listini.k_simulazione = "S"  then // se sono in simulazione eseguo!
			kiuf_esito_operazioni.tb_add_riga("-----------> Fine SIMULAZIONE trasferimento Quotazione: " + string(kst_tab_contratti_doc.id_contratto_doc) + " <----------- ", false)
		else
			kiuf_esito_operazioni.tb_add_riga("-----------> Fine, archivi non caricati ma 'Trasferito' Quotazione: " + string(kst_tab_contratti_doc.id_contratto_doc) + " <----------- ", false)
		end if
	end if
//--- Scrive LOG esiti su DB
	kst_tab_esito_operazioni.st_tab_g_0.esegui_commit = "S"
	kst_tab_contratti_doc.esito_operazioni_ts_operazione = kiuf_esito_operazioni.tb_add(kst_tab_esito_operazioni)
//--- scrive su Quotazione il riferimento all'esito 	
	kst_tab_contratti_doc.st_tab_g_0.esegui_commit = "S"
	this.set_ts_esito_operazione(kst_tab_contratti_doc)

	
	if isvalid(kuf1_contratti) then destroy kuf1_contratti
	if isvalid(kuf1_ausiliari) then destroy kuf1_ausiliari
	if isvalid(kds_contratti_doc) then destroy kds_contratti_doc
	
end try


return k_ctr_contratti_doc_trasferiti

end function

private function long u_conv_conferma_ordine_to_listino (ref datastore kds_contratti_doc, st_tab_contratti kst_tab_contratti, st_contratti_doc_to_listini kst_contratti_doc_to_listini) throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- Alimenta tabella Listini da una Conferma Ordine (CO) 
//---
//--- inp:  datastore del contratti_rd (d_contratti_doc)
//---                             ,kst_tab_contratti completamente riempito
//---                             ,st_contratti_doc_to_listini x sapere se simulazione ecc... o meno
//--- out: -
//--- ritorna: id (codice) del LISTINO caricato
//--- lancia Exception: uo_exception x errore grave
//---
//---
//---------------------------------------------------------------------------------------------------------------------------------------------------
//
long k_return = 0
int k_nr_listini_da_add=0, k_nr_listini_add=0
long k_riga=0
st_tab_base kst_tab_base 
st_tab_listino kst_tab_listino
st_tab_listino_prezzi kst_tab_listino_prezzi
st_esito kst_esito
st_tab_listino_link_pregruppi kst_tab_listino_link_pregruppi
st_tab_g_0 kst_tab_g_0
kuf_listino kuf1_listino
kuf_listino_link_pregruppi kuf1_listino_link_pregruppi
kuf_listino_prezzi kuf1_listino_prezzi
kuf_base kuf1_base
datastore kds_listino_link_pregruppi, kds_contratti_doc_listino_prezzi


try
	kst_esito = kguo_exception.inizializza(this.classname())

	kuf1_listino = create kuf_listino
	kuf1_base = create kuf_base

	if len(trim(kst_tab_contratti.mc_co)) > 0 then
	
//--- imposta il flag ATTIVO		
		if kst_contratti_doc_to_listini.k_subito_in_vigore = "S" then
			kst_tab_listino.attivo = kuf1_listino.kki_attivo_si
		else
			kst_tab_listino.attivo = kuf1_listino.kki_attivo_da_fare
		end if

		kst_tab_listino.magazzino =  kds_contratti_doc.getitemnumber(1,"magazzino")

//--- riempio i dati del Listino da quelli dei Contratti 
		kst_tab_listino.contratto = kst_tab_contratti.codice
		kst_tab_listino.contratto_co_data_ins = kGuf_data_base.prendi_dataora( )
		kst_tab_listino.id_contratto_co = kds_contratti_doc.getitemnumber(1,"id_contratto_doc")
		kst_tab_listino.cod_art = kds_contratti_doc.getitemstring(1,"art")
		kst_tab_listino.cod_cli = kds_contratti_doc.getitemnumber(1,"id_cliente")

//--- carica i dati di dettaglio VAL o IRR
		if kds_contratti_doc.getitemstring(1, "quotazione_tipo") = "VAL" then
			u_conv_conferma_ordine_to_listino_val(kds_contratti_doc, kst_tab_listino, kst_contratti_doc_to_listini)
		else
			u_conv_conferma_ordine_to_listino_irr(kds_contratti_doc, kst_tab_listino, kst_contratti_doc_to_listini)
		end if

	end if
	
catch (uo_exception kuo_exception)	
//--- aggiunge riga al log
	throw kuo_exception
	
	
finally 
	if isvalid(kuf1_listino) then destroy kuf1_listino
	if isvalid(kuf1_base) then destroy kuf1_base	
	if isvalid(kuf1_listino_link_pregruppi) then destroy kuf1_listino_link_pregruppi
	if isvalid(kds_listino_link_pregruppi) then destroy kds_listino_link_pregruppi

end try

return k_return

end function

public function st_esito select_riga (ref st_tab_contratti_doc k_st_tab_contratti_doc) throws uo_exception;//
//--- Leggo Contratto specifico
//
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	SELECT v_contratti_doc.id_contratto_doc,   
				v_contratti_doc.offerta_data,   
				v_contratti_doc.stampa_tradotta,   
				v_contratti_doc.stato,   
				v_contratti_doc.data_stampa,   
				v_contratti_doc.form_di_stampa,   
				v_contratti_doc.esito_operazioni_ts_operazione,   
				v_contratti_doc.anno,   
				v_contratti_doc.magazzino,   
				v_contratti_doc.offerta_validita,   
				v_contratti_doc.oggetto,   
				v_contratti_doc.id_cliente,   
				v_contratti_doc.id_clie_settore,   
				v_contratti_doc.gruppo,   
				v_contratti_doc.nome_contatto,   
				v_contratti_doc.note,   
				v_contratti_doc.note_audit,   
				v_contratti_doc.note_fasi_operative,   
				v_contratti_doc.iva,   
				v_contratti_doc.cod_pag,   
				v_contratti_doc.banca,   
				v_contratti_doc.abi,   
				v_contratti_doc.cab,   
				v_contratti_doc.altre_condizioni,   
				v_contratti_doc.data_inizio,   
				v_contratti_doc.data_fine,   
				v_contratti_doc.fattura_da,   
				v_contratti_doc.art,   
				v_contratti_doc.id_listino_pregruppo,   
				v_contratti_doc.id_listino_voce_1,   
				v_contratti_doc.id_listino_voce_2,   
				v_contratti_doc.id_listino_voce_3,   
				v_contratti_doc.id_listino_voce_4,   
				v_contratti_doc.id_listino_voce_5,   
				v_contratti_doc.id_listino_voce_6,   
				v_contratti_doc.id_listino_voce_7,   
				v_contratti_doc.id_listino_voce_8,   
				v_contratti_doc.id_listino_voce_9,   
				v_contratti_doc.id_listino_voce_10,   
				v_contratti_doc.voce_prezzo_1,   
				v_contratti_doc.voce_prezzo_2,   
				v_contratti_doc.voce_prezzo_3,   
				v_contratti_doc.voce_prezzo_4,   
				v_contratti_doc.voce_prezzo_5,   
				v_contratti_doc.voce_prezzo_6,   
				v_contratti_doc.voce_prezzo_7,   
				v_contratti_doc.voce_prezzo_8,   
				v_contratti_doc.voce_prezzo_9,   
				v_contratti_doc.voce_prezzo_10,   
				v_contratti_doc.totale_contratto,   
				v_contratti_doc.descr_1,   
				v_contratti_doc.descr_2,   
				v_contratti_doc.descr_3,   
				v_contratti_doc.descr_4,   
				v_contratti_doc.descr_5,   
				v_contratti_doc.descr_6,   
				v_contratti_doc.descr_7,   
				v_contratti_doc.descr_8,   
				v_contratti_doc.descr_9,   
				v_contratti_doc.descr_10,   
				v_contratti_doc.voce_prezzo_tot_1,   
				v_contratti_doc.voce_prezzo_tot_2,   
				v_contratti_doc.voce_prezzo_tot_3,   
				v_contratti_doc.voce_prezzo_tot_4,   
				v_contratti_doc.voce_prezzo_tot_5,   
				v_contratti_doc.voce_prezzo_tot_6,   
				v_contratti_doc.voce_prezzo_tot_7,   
				v_contratti_doc.voce_prezzo_tot_8,   
				v_contratti_doc.voce_prezzo_tot_9,   
				v_contratti_doc.voce_prezzo_tot_10,   
				v_contratti_doc.voce_qta_1,   
				v_contratti_doc.voce_qta_2,   
				v_contratti_doc.voce_qta_3,   
				v_contratti_doc.voce_qta_4,   
				v_contratti_doc.voce_qta_5,   
				v_contratti_doc.voce_qta_6,   
				v_contratti_doc.voce_qta_7,   
				v_contratti_doc.voce_qta_8,   
				v_contratti_doc.voce_qta_9,   
				v_contratti_doc.voce_qta_10,   
				v_contratti_doc.flg_st_voce_1,   
				v_contratti_doc.flg_st_voce_2,   
				v_contratti_doc.flg_st_voce_3,   
				v_contratti_doc.flg_st_voce_4,   
				v_contratti_doc.flg_st_voce_5,   
				v_contratti_doc.flg_st_voce_6,   
				v_contratti_doc.flg_st_voce_7,   
				v_contratti_doc.flg_st_voce_8,   
				v_contratti_doc.flg_st_voce_9,   
				v_contratti_doc.flg_st_voce_10,   
				v_contratti_doc.flg_fatt_dopo_valid,   
				v_contratti_doc.id_meca_causale,   
				v_contratti_doc.acconto_perc,   
				v_contratti_doc.acconto_imp,   
				v_contratti_doc.acconto_cod_pag,   
				v_contratti_doc.id_docprod,   
				v_contratti_doc.quotazione_tipo,   
				v_contratti_doc.quotazione_cod,   
				v_contratti_doc.cliente_desprod,   
				v_contratti_doc.cliente_desprod_rid,   
				v_contratti_doc.x_datins,   
				v_contratti_doc.x_utente  
	 into :k_st_tab_contratti_doc.id_contratto_doc,   
				:k_st_tab_contratti_doc.offerta_data,   
				:k_st_tab_contratti_doc.stampa_tradotta,   
				:k_st_tab_contratti_doc.stato,   
				:k_st_tab_contratti_doc.data_stampa,   
				:k_st_tab_contratti_doc.form_di_stampa,   
				:k_st_tab_contratti_doc.esito_operazioni_ts_operazione,   
				:k_st_tab_contratti_doc.anno,   
				:k_st_tab_contratti_doc.magazzino,   
				:k_st_tab_contratti_doc.offerta_validita,   
				:k_st_tab_contratti_doc.oggetto,   
				:k_st_tab_contratti_doc.id_cliente,   
				:k_st_tab_contratti_doc.id_clie_settore,   
				:k_st_tab_contratti_doc.gruppo,   
				:k_st_tab_contratti_doc.nome_contatto,   
				:k_st_tab_contratti_doc.note,   
				:k_st_tab_contratti_doc.note_audit,   
				:k_st_tab_contratti_doc.note_fasi_operative,   
				:k_st_tab_contratti_doc.iva,   
				:k_st_tab_contratti_doc.cod_pag,   
				:k_st_tab_contratti_doc.banca,   
				:k_st_tab_contratti_doc.abi,   
				:k_st_tab_contratti_doc.cab,   
				:k_st_tab_contratti_doc.altre_condizioni,   
				:k_st_tab_contratti_doc.data_inizio,   
				:k_st_tab_contratti_doc.data_fine,   
				:k_st_tab_contratti_doc.fattura_da,   
				:k_st_tab_contratti_doc.art,   
				:k_st_tab_contratti_doc.id_listino_pregruppo,   
				:k_st_tab_contratti_doc.id_listino_voce[1],   
				:k_st_tab_contratti_doc.id_listino_voce[2],   
				:k_st_tab_contratti_doc.id_listino_voce[3],   
				:k_st_tab_contratti_doc.id_listino_voce[4],   
				:k_st_tab_contratti_doc.id_listino_voce[5],   
				:k_st_tab_contratti_doc.id_listino_voce[6],   
				:k_st_tab_contratti_doc.id_listino_voce[7],   
				:k_st_tab_contratti_doc.id_listino_voce[8],   
				:k_st_tab_contratti_doc.id_listino_voce[9],   
				:k_st_tab_contratti_doc.id_listino_voce[10],   
				:k_st_tab_contratti_doc.voce_prezzo[1],   
				:k_st_tab_contratti_doc.voce_prezzo[2],   
				:k_st_tab_contratti_doc.voce_prezzo[3],   
				:k_st_tab_contratti_doc.voce_prezzo[4],   
				:k_st_tab_contratti_doc.voce_prezzo[5],   
				:k_st_tab_contratti_doc.voce_prezzo[6],   
				:k_st_tab_contratti_doc.voce_prezzo[7],   
				:k_st_tab_contratti_doc.voce_prezzo[8],   
				:k_st_tab_contratti_doc.voce_prezzo[9],   
				:k_st_tab_contratti_doc.voce_prezzo[10],   
				:k_st_tab_contratti_doc.totale_contratto,   
				:k_st_tab_contratti_doc.descr[1],   
				:k_st_tab_contratti_doc.descr[2],   
				:k_st_tab_contratti_doc.descr[3],   
				:k_st_tab_contratti_doc.descr[4],   
				:k_st_tab_contratti_doc.descr[5],   
				:k_st_tab_contratti_doc.descr[6],   
				:k_st_tab_contratti_doc.descr[7],   
				:k_st_tab_contratti_doc.descr[8],   
				:k_st_tab_contratti_doc.descr[9],   
				:k_st_tab_contratti_doc.descr[10],   
				:k_st_tab_contratti_doc.voce_prezzo_tot[1],   
				:k_st_tab_contratti_doc.voce_prezzo_tot[2],   
				:k_st_tab_contratti_doc.voce_prezzo_tot[3],   
				:k_st_tab_contratti_doc.voce_prezzo_tot[4],   
				:k_st_tab_contratti_doc.voce_prezzo_tot[5],   
				:k_st_tab_contratti_doc.voce_prezzo_tot[6],   
				:k_st_tab_contratti_doc.voce_prezzo_tot[7],   
				:k_st_tab_contratti_doc.voce_prezzo_tot[8],   
				:k_st_tab_contratti_doc.voce_prezzo_tot[9],   
				:k_st_tab_contratti_doc.voce_prezzo_tot[10],   
				:k_st_tab_contratti_doc.voce_qta[1],   
				:k_st_tab_contratti_doc.voce_qta[2],   
				:k_st_tab_contratti_doc.voce_qta[3],   
				:k_st_tab_contratti_doc.voce_qta[4],   
				:k_st_tab_contratti_doc.voce_qta[5],   
				:k_st_tab_contratti_doc.voce_qta[6],   
				:k_st_tab_contratti_doc.voce_qta[7],   
				:k_st_tab_contratti_doc.voce_qta[8],   
				:k_st_tab_contratti_doc.voce_qta[9],   
				:k_st_tab_contratti_doc.voce_qta[10],   
				:k_st_tab_contratti_doc.flg_st_voce[1],   
				:k_st_tab_contratti_doc.flg_st_voce[2],   
				:k_st_tab_contratti_doc.flg_st_voce[3],   
				:k_st_tab_contratti_doc.flg_st_voce[4],   
				:k_st_tab_contratti_doc.flg_st_voce[5],   
				:k_st_tab_contratti_doc.flg_st_voce[6],   
				:k_st_tab_contratti_doc.flg_st_voce[7],   
				:k_st_tab_contratti_doc.flg_st_voce[8],   
				:k_st_tab_contratti_doc.flg_st_voce[9],   
				:k_st_tab_contratti_doc.flg_st_voce[10],   
				:k_st_tab_contratti_doc.flg_fatt_dopo_valid,   
				:k_st_tab_contratti_doc.id_meca_causale,   
				:k_st_tab_contratti_doc.acconto_perc,   
				:k_st_tab_contratti_doc.acconto_imp,   
				:k_st_tab_contratti_doc.acconto_cod_pag,   
				:k_st_tab_contratti_doc.id_docprod,   
				:k_st_tab_contratti_doc.quotazione_tipo,   
				:k_st_tab_contratti_doc.quotazione_cod,   
				:k_st_tab_contratti_doc.cliente_desprod,   
				:k_st_tab_contratti_doc.cliente_desprod_rid,   
				:k_st_tab_contratti_doc.x_datins,   
				:k_st_tab_contratti_doc.x_utente  
		 FROM v_contratti_doc   
		where id_contratto_doc = :k_st_tab_contratti_doc.id_contratto_doc
		using sqlca;

	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in lettura tab. Quotazioni (codice=" + string(k_st_tab_contratti_doc.id_contratto_doc) + ") : " &
									 + trim(SQLCA.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				kguo_exception.scrivi_log( )
				throw kguo_exception
			end if
		end if
	end if

	
return kst_esito


end function

public function st_esito u_check_dati_val (ref datastore ads_inp) throws uo_exception;//------------------------------------------------------------------------------------------------------
//---  Controllo dati VAL
//---  inp: datastore con i dati da controllare
//---  out: datastore con  	ads_inp.object.<nome campo>.tag che può valere:
//												0=tutto OK (kkg_esito.ok); 
//												1=errore logico (bloccante) (kkg_esito.ERR_LOGICO); 
//												2=errore forma  (bloccante) (kkg_esito.err_formale);
//												3=dati insufficienti  (bloccante) (kkg_esito.DATI_INSUFF);
//												4=KO ma errore non grave  (NON bloccante) (kkg_esito.DB_WRN);
//---							               	5=OK con degli avvertimenti (NON bloccante) (kkg_esito.DATI_WRN);
//---  rit: 
//---
//---  per errore lancia EXCEPTION anche x i warning
//---
//---  CONSIGLIO DI COPIARE DA QUESTO ESTENDENDO I CONTROLLI
//---
//------------------------------------------------------------------------------------------------------
//
int k_errori = 0
long k_nr_righe, k_ctr, k_ctr1
int k_riga
string k_tipo_errore="0"
boolean k_voci_no_cod=false
st_tab_contratti_doc kst_tab_contratti_doc, kst1_tab_contratti_doc
st_tab_listino_pregruppi_voci kst_tab_listino_pregruppi_voci
st_esito kst_esito, kst_esito1
kuf_listino_pregruppi_voci kuf1_listino_pregruppi_voci


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
// ESEMPIO
//	if trim(ads_inp.object.descr) > " "  then
//	else
//		k_errori ++
//		k_tipo_errore="3"      // errore in questo campo: dati insuff.
//		ads_inp.object.descr.tag = k_tipo_errore 
//		kst_esito.esito = kkg_esito.err_formale
//		kst_esito.sqlerrtext = "Manca descrizione nel campo " + trim(ads_inp.object.descr_t.text) +  "~n~r"  
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if

	
	k_nr_righe =ads_inp.rowcount()
	k_errori = 0
	k_riga =ads_inp.getnextmodified(0, primary!)

	do while k_riga > 0  and k_errori < 10

		kst_tab_contratti_doc.id_listino_pregruppo = ads_inp.getitemnumber(k_riga, "id_listino_pregruppo")
		if kst_tab_contratti_doc.id_listino_pregruppo > 0  then
		else
			k_errori++
			k_tipo_errore = "3"
			kst_esito.esito = kkg_esito.DATI_INSUFF
			kst_esito.sqlerrtext = "Manca valore nel campo " + trim(ads_inp.describe("b_listino_pregruppo.text")) +  "~n~r"    + trim(kst_esito.sqlerrtext)
		end if

//--- check se Stessa Voce Ripetuta più volte
		for k_ctr = 1 to 10
			kst_tab_contratti_doc.descr[k_ctr] = ads_inp.getitemstring(k_riga, "descr_" + string(k_ctr))
			kst_tab_contratti_doc.id_listino_voce[k_ctr] = ads_inp.getitemnumber(k_riga, "id_listino_voce_" + string(k_ctr))
			if kst_tab_contratti_doc.id_listino_voce[k_ctr] > 0 then
				for k_ctr1 = k_ctr+1 to 9
			   		if kst_tab_contratti_doc.id_listino_voce[k_ctr] = ads_inp.getitemnumber(k_riga, "id_listino_voce_" + string(k_ctr1)) then
						k_errori++
						k_tipo_errore = "1"
						kst_esito.esito = kkg_esito.ERR_LOGICO
						kst_esito.sqlerrtext = "La Voce " + string(kst_tab_contratti_doc.id_listino_voce[k_ctr] ) &
										+ " duplicata nel campo '" +  trim(ads_inp.describe( "id_listino_voce_" + string(k_ctr1) +"_t.text"))  + "'.  " + "~n~r" + trim(kst_esito.sqlerrtext)
						k_ctr1 =11  	//forza uscita
						k_ctr = 11 //forza uscita
					end if
				end for

//--- check se la Voce esiste nel Gruppo Listino indicato		
				if kst_tab_contratti_doc.id_listino_pregruppo > 0  then
					kuf1_listino_pregruppi_voci = create kuf_listino_pregruppi_voci  
					kst_tab_listino_pregruppi_voci.id_listino_voce = kst_tab_contratti_doc.id_listino_voce[k_ctr] 
					kst_tab_listino_pregruppi_voci.id_listino_pregruppo = kst_tab_contratti_doc.id_listino_pregruppo 
					kst_esito1 = kuf1_listino_pregruppi_voci.get_id_listino_pregruppo_voce(kst_tab_listino_pregruppi_voci)
					if kst_esito1.esito = KKG_ESITO.not_fnd then
						if k_tipo_errore = "4" or k_tipo_errore = kkg_esito.DATI_WRN or k_tipo_errore = "0" then 
							k_errori++
							k_tipo_errore = kkg_esito.DATI_WRN
							kst_esito.esito = kkg_esito.DATI_WRN
						end if
						kst_esito.sqlerrtext = "La Voce " + string(kst_tab_contratti_doc.id_listino_voce[k_ctr] ) + ", alla riga " + string(k_ctr) &
											+ " non appartiene al '" + trim(ads_inp.describe("id_listino_pregruppo_t.text")) + " " &
											+ string(kst_tab_listino_pregruppi_voci.id_listino_pregruppo) + " ' indicato." + " - " + trim(kst_esito1.sqlerrtext) + "~n~r"  + trim(kst_esito.sqlerrtext)
					end if
				end if
			end if

//--- check se ci sono Voci senza ID ma con la sola descrizione (basta msg una volta)
			if kst_tab_contratti_doc.id_listino_voce[k_ctr] > 0 or k_voci_no_cod then
			else
				if trim(kst_tab_contratti_doc.descr[k_ctr]) > " " then
					k_voci_no_cod = true
					k_tipo_errore = kkg_esito.DATI_WRN
					kst_esito.esito = kkg_esito.DATI_WRN
					kst_esito.sqlerrtext = "Le Voci non Codificate non saranno TRASFERITE a Listino, come la riga " + string(k_ctr) + ": " + trim(kst_tab_contratti_doc.descr[k_ctr] ) 
				end if
			end if
				
		end for


		if k_tipo_errore <> "0"  and k_tipo_errore <> "4" and k_tipo_errore <> kkg_esito.DATI_WRN then
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		k_riga++
		k_riga = ads_inp.getnextmodified(k_riga, primary!)

	loop

	
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if k_errori > 0 then
		
	end if
	
end try


return kst_esito

end function

public function st_esito u_check_dati_irr (ref datastore ads_inp) throws uo_exception;//------------------------------------------------------------------------------------------------------
//---  Controllo dati IRR
//---  inp: datastore con i dati da controllare
//---  out: datastore con  	ads_inp.object.<nome campo>.tag che può valere:
//												0=tutto OK (kkg_esito.ok); 
//												1=errore logico (bloccante) (kkg_esito.ERR_LOGICO); 
//												2=errore forma  (bloccante) (kkg_esito.err_formale);
//												3=dati insufficienti  (bloccante) (kkg_esito.DATI_INSUFF);
//												4=KO ma errore non grave  (NON bloccante) (kkg_esito.DB_WRN);
//---							               	5=OK con degli avvertimenti (NON bloccante) (kkg_esito.DATI_WRN);
//---  rit: 
//---
//---  per errore lancia EXCEPTION anche x i warning
//---
//---  CONSIGLIO DI COPIARE DA QUESTO ESTENDENDO I CONTROLLI
//---
//------------------------------------------------------------------------------------------------------
//
int k_errori = 0
long k_nr_righe, k_ctr, k_ctr1
int k_riga
string k_tipo_errore="0"
boolean k_voci_no_cod=false

st_tab_contratti_doc kst_tab_contratti_doc, kst1_tab_contratti_doc
st_tab_listino_pregruppi_voci kst_tab_listino_pregruppi_voci
st_esito kst_esito, kst_esito1
kuf_listino_pregruppi_voci kuf1_listino_pregruppi_voci

string k_trova=""
int k_pos=1, k_start=1, k_nr_capitolato=0 
st_tab_contratti kst_tab_contratti
st_tab_gru kst_tab_gru
st_tab_prodotti kst_tab_prodotti
kuf_contratti kuf1_contratti
kuf_ausiliari kuf1_ausiliari
kuf_prodotti kuf1_prodotti


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
// ESEMPIO
//	if trim(ads_inp.object.descr) > " "  then
//	else
//		k_errori ++
//		k_tipo_errore="3"      // errore in questo campo: dati insuff.
//		ads_inp.object.descr.tag = k_tipo_errore 
//		kst_esito.esito = kkg_esito.err_formale
//		kst_esito.sqlerrtext = "Manca descrizione nel campo " + trim(ads_inp.object.descr_t.text) +  "~n~r"  
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if

	
	k_nr_righe =ads_inp.rowcount()
	k_errori = 0
	k_riga =ads_inp.getnextmodified(0, primary!)

	do while k_riga > 0  and k_errori < 10

//--- controlla SC-CF		
		kst_tab_contratti_doc.contratti_des = ads_inp.getitemstring(1, "contratti_des")
		if len(trim(kst_tab_contratti_doc.contratti_des)) > 0 then
				
			try 
				kuf1_contratti = create kuf_contratti

				k_nr_capitolato=0
//--- cerca il carattere separatore  ';' e ' - ' 				
				k_trova = ";"
				k_pos = pos(kst_tab_contratti_doc.contratti_des, k_trova, k_start)
				if k_pos = 0 then
					k_trova = " - "
					k_pos=pos(kst_tab_contratti_doc.contratti_des, k_trova, k_start)
				end if
//--- cerca altrim sc-cf				
				do while k_pos > 0 
					kst_tab_contratti.sc_cf = trim(mid(kst_tab_contratti_doc.contratti_des, k_start, k_pos - k_start))
					if len(trim(kst_tab_contratti.sc_cf)) > 0 then
//--- esiste il CF estratto?
						k_nr_capitolato++
						if NOT kuf1_contratti.if_esiste_sc_cf(kst_tab_contratti) then
							k_errori++
							k_tipo_errore = "1"
							kst_esito.esito = kkg_esito.not_fnd
							kst_esito.sqlerrtext =  trim(ads_inp.describe( "contratti_des_t.text"))  + "':  " &
										+ "Capitolato (" + string(k_nr_capitolato) + ") non Trovato, cod. " + string(kst_tab_contratti.sc_cf )  &
										+ "; err=" + string(kst_esito.sqlcode) + " - " + trim(kst_esito.sqlerrtext) + "~n~r"
						end if
						
					end if
					k_start = k_pos +  len(k_trova)
//--- cerca il carattere separatore  ';' e ' - ' 				
					k_trova = ";"
					k_pos = pos(kst_tab_contratti_doc.contratti_des, k_trova, k_start)
					if k_pos = 0 then
						k_trova = " - "
						k_pos=pos(kst_tab_contratti_doc.contratti_des, k_trova, k_start)
					end if
				loop

//--- c'e' un altro CF senza chiusura del carattere ';' o ' - '
				k_pos = len(kst_tab_contratti_doc.contratti_des)
				kst_tab_contratti.sc_cf = trim(mid(kst_tab_contratti_doc.contratti_des, k_start, k_pos - k_start + 1))
				if len(kst_tab_contratti.sc_cf) > 0 then
					k_nr_capitolato++
					if NOT kuf1_contratti.if_esiste_sc_cf(kst_tab_contratti) then
						k_errori++
						k_tipo_errore = "1"
						kst_esito.esito = kkg_esito.not_fnd
						kst_esito.sqlerrtext =  trim(ads_inp.describe( "contratti_des_t.text"))  + "':  " &
									+ "Capitolato (" + string(k_nr_capitolato) + ") non Trovato; cod. " + string(kst_tab_contratti.sc_cf )  &
									+ "; err=" + string(kst_esito.sqlcode) + " - " + trim(kst_esito.sqlerrtext) + "~n~r"
					end if
				end if

			
			catch (uo_exception kuo_exception)
				kst_esito = kuo_exception.get_st_esito()
				k_errori++
				k_tipo_errore = "1"
				kst_esito.esito = kkg_esito.not_fnd
				kst_esito.sqlerrtext =  trim(ads_inp.describe( "contratti_des_t.text"))  + "':  " &
									+ "Errore in lettura del Capitolato " + string(kst_tab_contratti.sc_cf )  &
									+ "; err=" + string(kst_esito.sqlcode) + " - " + trim(kst_esito.sqlerrtext) + "~n~r"
			
			finally 
				if isvalid(kuf1_contratti) then destroy kuf1_contratti
			end try
			
		end if

		if k_tipo_errore <> "0"  and k_tipo_errore <> "4" and k_tipo_errore <> kkg_esito.DATI_WRN then
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		k_riga++
		k_riga = ads_inp.getnextmodified(k_riga, primary!)

	loop

	
	
catch (uo_exception kuo1_exception)
	throw kuo1_exception

finally
	if k_errori > 0 then
		
	end if
	
end try


return kst_esito

end function

private function long u_conv_conferma_ordine_to_listino_val (ref datastore kds_contratti_doc, st_tab_listino kst_tab_listino, st_contratti_doc_to_listini kst_contratti_doc_to_listini) throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- Alimenta tabella Listini da una Conferma Ordine (CO) di Quotazione VAL
//---
//--- inp:  datastore del contratti_rd (d_contratti_doc)
//---                             ,kst_tab_contratti completamente riempito
//---                             ,st_contratti_doc_to_listini x sapere se simulazione ecc... o meno
//--- out: -
//--- ritorna: id (codice) del LISTINO caricato
//--- lancia Exception: uo_exception x errore grave
//---
//---
//---------------------------------------------------------------------------------------------------------------------------------------------------
//
long k_return = 0
int k_nr_listini_da_add=0, k_nr_listini_add=0
long k_riga=0
st_tab_listino_prezzi kst_tab_listino_prezzi
st_esito kst_esito
st_tab_listino_link_pregruppi kst_tab_listino_link_pregruppi
st_tab_g_0 kst_tab_g_0
kuf_listino kuf1_listino
kuf_listino_link_pregruppi kuf1_listino_link_pregruppi
kuf_listino_prezzi kuf1_listino_prezzi
datastore kds_listino_link_pregruppi, kds_contratti_doc_listino_prezzi


try
	kst_esito = kguo_exception.inizializza(this.classname())

	kuf1_listino = create kuf_listino

//--- prezzi nella tabella listino_link_pregruppi
	kst_tab_listino.attiva_listino_pregruppi = kuf1_listino.kki_attiva_listino_pregruppi_si
	
	kst_tab_listino.prezzo = 0

	if kst_tab_listino.magazzino > 0 then
	else
		kst_tab_listino.magazzino =  kuf1_listino.kki_tipo_magazzino_nessuno // 6
	end if
	
	kst_tab_listino.peso_kg = 0
		
	kst_tab_listino.tipo = kuf1_listino.kki_tipo_prezzo_a_collo

//--- Niente Occupazione Pedana
	kst_tab_listino.occup_ped = 0
//--- Niente dati di LISTINO dal SL_PT
	kst_tab_listino.dose =  0
	kst_tab_listino.mis_x = 0
	kst_tab_listino.mis_y = 0
	kst_tab_listino.mis_z = 0
//--- imposta altri valori di default
	kst_tab_listino.id = 0
	kst_tab_listino.campione ="N"
	kst_tab_listino.m_cubi_f = 0
	kst_tab_listino.travaso = "N"

//--- ADD dei dati nel LISTINO
	kst_tab_listino.st_tab_g_0.esegui_commit = "N"
	kst_tab_listino.id = kuf1_listino.tb_add(kst_tab_listino)
	k_return = kst_tab_listino.id

//--- Aggiunge il Legame tra Listino e Voce 
	kst_tab_listino_link_pregruppi.id_listino_pregruppo = kds_contratti_doc.getitemnumber(1,"id_listino_pregruppo")
	if kst_tab_listino_link_pregruppi.id_listino_pregruppo > 0 then
		kuf1_listino_link_pregruppi = create kuf_listino_link_pregruppi
		kds_listino_link_pregruppi = create datastore
		kds_listino_link_pregruppi.dataobject = "ds_listino_link_pregruppi"
		kds_listino_link_pregruppi.settransobject( kguo_sqlca_db_magazzino )
		kds_listino_link_pregruppi.insertrow(0)
		kds_listino_link_pregruppi.setitem(1, "id_listino", kst_tab_listino.id)
		kds_listino_link_pregruppi.setitem(1, "id_listino_pregruppo", kst_tab_listino_link_pregruppi.id_listino_pregruppo)
		kst_tab_g_0 = kst_tab_listino.st_tab_g_0
		kuf1_listino_link_pregruppi.tb_add(kds_listino_link_pregruppi, kst_tab_g_0)
	else
		kst_tab_listino_link_pregruppi.id_listino_pregruppo = 0 
	end if

//--- Aggiunge i Prezzi delle Voci al Listino
	kuf1_listino_prezzi = create kuf_listino_prezzi
	kds_contratti_doc_listino_prezzi = create datastore
	kds_contratti_doc_listino_prezzi.dataobject = "ds_contratti_doc_listino_prezzi"
	kds_contratti_doc_listino_prezzi.settransobject( kguo_sqlca_db_magazzino )
	kds_contratti_doc_listino_prezzi.retrieve(kds_contratti_doc.getitemnumber(1, "id_contratto_doc"))
	for k_riga = 1 to kds_contratti_doc_listino_prezzi.rowcount( )
		
		kst_tab_listino_prezzi.st_tab_g_0 = kst_tab_listino.st_tab_g_0
		kst_tab_listino_prezzi.id_listino_link_pregruppo = kst_tab_listino_link_pregruppi.id_listino_pregruppo //kds_listino_link_pregruppi.getitemnumber(1,"id_listino_link_pregruppo")
//			kst_tab_listino_prezzi.id_listino_pregruppo = kds_contratti_doc.getitemnumber(1,"id_listino_pregruppo")
		kst_tab_listino_prezzi.id_listino_voce = kds_contratti_doc_listino_prezzi.getitemnumber(k_riga,"id_listino_voce")
		kst_tab_listino_prezzi.prezzo = kds_contratti_doc_listino_prezzi.getitemnumber(k_riga,"prezzo")
		kst_tab_listino_prezzi.attivo = kuf1_listino_prezzi.kki_attivo_si
		
		if kst_tab_listino_prezzi.id_listino_voce > 0 then
			kuf1_listino_prezzi.tb_add(kst_tab_listino_prezzi)
		end if
	end for
	
	
catch (uo_exception kuo_exception)	
//--- aggiunge riga al log
	throw kuo_exception
	
	
finally 
	if isvalid(kuf1_listino) then destroy kuf1_listino
	if isvalid(kuf1_listino_link_pregruppi) then destroy kuf1_listino_link_pregruppi
	if isvalid(kds_listino_link_pregruppi) then destroy kds_listino_link_pregruppi

end try

return k_return

end function

private function long u_conv_conferma_ordine_to_listino_irr (ref datastore kds_contratti_doc, st_tab_listino kst_tab_listino, st_contratti_doc_to_listini kst_contratti_doc_to_listini) throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- Alimenta tabella Listini da una Conferma Ordine (CO) da Quotazione IRR
//---
//--- inp:  datastore del contratti_rd (d_contratti_doc)
//---                             ,kst_tab_contratti completamente riempito
//---                             ,st_contratti_doc_to_listini x sapere se simulazione ecc... o meno
//--- out: -
//--- ritorna: id (codice) del LISTINO caricato
//--- lancia Exception: uo_exception x errore grave
//---
//---
//---------------------------------------------------------------------------------------------------------------------------------------------------
//
long k_return = 0
st_tab_base kst_tab_base 
st_tab_sl_pt kst_tab_sl_pt
st_esito kst_esito
st_tab_g_0 kst_tab_g_0
kuf_base kuf1_base
kuf_listino kuf1_listino
kuf_sl_pt kuf1_sl_pt



try
	kst_esito = kguo_exception.inizializza(this.classname())

	kuf1_listino = create kuf_listino
	kuf1_sl_pt = create kuf_sl_pt
	kuf1_base = create kuf_base


	kst_tab_listino.prezzo = kds_contratti_doc.getitemnumber(1,"prezzo_1")
	
//--- legge i dati di LISTINO dal SL_PT
//	kst_tab_sl_pt.cod_sl_pt = kst_tab_contratti.sl_pt
	kst_esito = kuf1_sl_pt.select_riga(kst_tab_sl_pt )
	
//--- se ho trovato errore Grave lancio eccezione
	if kst_esito.esito = kkg_esito.db_ko then
		kGuo_exception.inizializza( )
		kGuo_exception.set_esito(kst_esito) 
		throw kGuo_exception
	else
		if kst_esito.esito = kkg_esito.ok then
	
			if kst_tab_listino.magazzino > 0 then
			else
				kst_tab_listino.magazzino = kst_tab_sl_pt.magazzino
			end if
			
		else //--- manca il SL_PT???
			kst_tab_listino.dose =  0
			kst_tab_listino.mis_x = 0
			kst_tab_listino.mis_y = 0
			kst_tab_listino.mis_z = 0
			kst_tab_listino.peso_kg = 0
			kst_tab_listino.magazzino = 0
		end if
	end if
	

//--- Dati vari tipo la dimensione da Contratto
		kst_tab_listino.dose =   kds_contratti_doc.getitemnumber(1,"dose")
		kst_tab_listino.mis_x = kds_contratti_doc.getitemnumber(1,"mis_x_1")
		kst_tab_listino.mis_y = kds_contratti_doc.getitemnumber(1,"mis_y_1")
		kst_tab_listino.mis_z = kds_contratti_doc.getitemnumber(1,"mis_z_1")
		kst_tab_listino.peso_kg = kds_contratti_doc.getitemnumber(1,"peso_max_kg") 
		if isnull(kst_tab_listino.peso_kg) then
			kst_tab_listino.peso_kg = 0
		end if

		kst_tab_listino.tipo = kuf1_listino.kki_tipo_prezzo_a_collo
		if kst_tab_listino.magazzino > 0 then
		else
			kst_tab_listino.magazzino = kuf1_listino.kki_tipo_magazzino_standard
		end if

//--- Calcolo Occupazione Pedana
		if kst_tab_listino.mis_x > 0 then
			kst_tab_base.mis_x = kst_tab_listino.mis_x
			kst_tab_base.mis_y = kst_tab_listino.mis_y
			kst_tab_base.mis_z = kst_tab_listino.mis_z
			kst_tab_listino.occup_ped = kuf1_base.get_occupazione_pedana(kst_tab_base )
//			if kst_contratti_doc_to_listini.k_occup_pedana_precisa = "N" then
				choose case kst_tab_listino.occup_ped
					case is < 15
						kst_tab_listino.occup_ped = 10
					case is < 55
						kst_tab_listino.occup_ped = 50
					case else
						kst_tab_listino.occup_ped = 100
				end choose

//			end if
		else
			kst_tab_listino.occup_ped = 0
		end if

//--- imposta i valori di default
		kst_tab_listino.id = 0
		kst_tab_listino.campione ="N"
		kst_tab_listino.m_cubi_f = 0
		kst_tab_listino.travaso = "N"

//--- ADD dei dati nel LISTINO
		kst_tab_listino.st_tab_g_0.esegui_commit = "N"
		kst_tab_listino.id = kuf1_listino.tb_add(kst_tab_listino)
		k_return = kst_tab_listino.id
	
catch (uo_exception kuo_exception)	
//--- aggiunge riga al log
	throw kuo_exception
	
	
finally 
	if isvalid(kuf1_listino) then destroy kuf1_listino
	if isvalid(kuf1_sl_pt) then destroy kuf1_sl_pt
	if isvalid(kuf1_base) then destroy kuf1_base

end try

return k_return

end function

public function st_esito anteprima_dettaglio (ref datawindow kdw_anteprima, st_tab_contratti_doc kst_tab_contratti_doc);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_esito kst_esito
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try 
	k_return = if_sicurezza( kkg_flag_modalita.anteprima)

	if kst_tab_contratti_doc.id_contratto_doc > 0 then
	
		if kst_tab_contratti_doc.quotazione_tipo =  "VAL" then
				kdw_anteprima.dataobject = "d_contratti_doc_val"		
			else
				kdw_anteprima.dataobject = "d_contratti_doc_irr"		
			end if
			kdw_anteprima.settransobject(sqlca)
	
			kuf1_utility = create kuf_utility
			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_contratti_doc.id_contratto_doc)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessuna Quotazione da visualizzare: ~n~r" + "nessun Codice indicato"
			kst_esito.esito = kkg_esito.bug
			
		end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	
end try


return kst_esito

end function

public function st_esito anteprima_dettaglio (ref datastore kdw_anteprima, st_tab_contratti_doc kst_tab_contratti_doc);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try 
	k_return = if_sicurezza( kkg_flag_modalita.anteprima)

	if kst_tab_contratti_doc.id_contratto_doc > 0 then
	
		if kst_tab_contratti_doc.quotazione_tipo =  "VAL" then
				kdw_anteprima.dataobject = "d_contratti_doc_val"		
			else
				kdw_anteprima.dataobject = "d_contratti_doc_irr"		
			end if
			kdw_anteprima.settransobject(sqlca)
	
			kdw_anteprima.reset()	
	//--- retrive 
			k_rc=kdw_anteprima.retrieve(kst_tab_contratti_doc.id_contratto_doc)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessuna Quotazione da visualizzare: ~n~r" + "nessun Codice indicato"
			kst_esito.esito = kkg_esito.bug
			
		end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	
end try


return kst_esito

end function

public function string get_stato_descrizione (ref st_tab_contratti_doc kst_tab_contratti_doc);//
//----------------------------------------------------------------------------------------------------------------------------
//--- 
//--- Legge lo STATO
//--- 
//--- 
//--- Input: st_tab_contratti_doc.stato
//--- Out: 
//---
//--- Ritorna: descrizione dello stato
//---
//--- Lancia EXCEPTION x errore
//---
//----------------------------------------------------------------------------------------------------------------------------
//
string k_return



	choose case kst_tab_contratti_doc.stato
		case kki_STATO_nuovo
			k_return = "Nuovo"
		case kki_STATO_riaperto
			k_return = "Riaperto"
		case kki_STATO_stampato
			k_return = "Stampato"
		case kki_STATO_accettato
			k_return = "Accettato"
		case kki_STATO_respinto
			k_return = "Respinto"
		case kki_STATO_trasferito
			k_return = "Trasferito"
		case kki_STATO_annullato
			k_return = "Annullato"
		case else
			k_return = "*non riconosciuto*"
	end choose


return k_return


end function

public function string get_stato (ref st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------------------
//--- 
//--- Legge lo STATO
//--- 
//--- 
//--- Input: st_tab_contratti_doc.id_contratto_doc
//--- Out: st_tab_contratti_doc.stato
//---
//--- Ritorna st_tab_contratti_doc.stato
//---
//--- Lancia EXCEPTION x errore
//---
//----------------------------------------------------------------------------------------------------------------------------
//
string k_return 
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	select stato
	  into :kst_tab_contratti_doc.stato
	  from contratti_doc 
	  where id_contratto_doc = :kst_tab_contratti_doc.id_contratto_doc  
	  using sqlca;
	

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Legge lo Stato del Contratto R. & D. (tab. contratti_doc id=" + string(kst_tab_contratti_doc.id_contratto_doc) + " " + "): " + trim(SQLCA.SQLErrText)
									 
		kst_esito.esito = kkg_esito.db_ko
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)		
		throw kguo_exception
		
	end if
	
	if sqlca.sqlcode = 0 then
		if len(trim(kst_tab_contratti_doc.stato)) > 0 then
		else
			kst_tab_contratti_doc.stato = kki_STATO_nuovo
		end if
	
		k_return = kst_tab_contratti_doc.stato 
	end if

return k_return


end function

public function long get_ultimo_id () throws uo_exception;//
//====================================================================
//=== Torna l'ultimo ID caricato 
//=== 
//=== Ritorna: ultimo id caricato
//=== 
//====================================================================
long k_return
st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

   SELECT   max(id_contratto_doc)
       into :k_return
		 FROM contratti_doc
			using kguo_sqlca_db_magazzino ;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Quotazione (cercato ultimo ID caricato) ~n~r:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception 
	end if

return k_return




end function

public function boolean tb_delete (st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception;//
//====================================================================
//=== Cancella il rek dalla tabella contratti_doc 
//=== 
//===           	
//====================================================================
//
boolean k_return
st_esito kst_esito
st_open_w kst_open_w
st_tab_docprod kst_tab_docprod
kuf_docprod kuf1_docprod
kuf_doctipo kuf1_doctipo


	kst_esito = kguo_exception.inizializza(this.classname())
	
	if_sicurezza(kkg_flag_modalita.cancellazione)

	try

		if kst_tab_contratti_doc.id_contratto_doc > 0 then
	
			delete from contratti_doc
				where id_contratto_doc = :kst_tab_contratti_doc.id_contratto_doc
				using kguo_sqlca_db_magazzino;
			
			if sqlca.sqlcode < 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Cancellazione 'Quotazione'  id " + string(kst_tab_contratti_doc.id_contratto_doc) + " (contratti_doc): " + trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

//--- cancella da docprod	 tutti i riferimenti
			kst_tab_docprod.id_doc = kst_tab_contratti_doc.id_contratto_doc
			kuf1_docprod = create kuf_docprod
			kuf1_doctipo = create kuf_doctipo
			kst_tab_docprod.st_tab_g_0.esegui_commit = "N"
			kuf1_docprod.tb_delete(kst_tab_docprod, kuf1_doctipo.kki_tipo_contr_rd )

//---- COMMIT....	
			if kst_tab_contratti_doc.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_doc.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		
			k_return = true
		end if
		
	catch (uo_exception kuo_exception)
		if kst_tab_contratti_doc.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_doc.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		throw kuo_exception

	finally
		if isvalid(kuf1_docprod) then destroy kuf1_docprod 
		if isvalid(kuf1_doctipo) then destroy kuf1_doctipo 
		
	end try
	
return k_return

end function

public function string get_form_di_stampa (ref st_tab_contratti_doc kst_tab_contratti_doc) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------------------
//--- 
//--- Legge il nome del Dataobject (datawindow) da contratti_doc ad esempio: "d_contratti_doc_stampa_2006"
//--- 
//--- 
//--- Input: st_tab_contratti_doc.id_contratto_doc
//--- Out: id, data_stampa, form_di_stampa
//---
//--- Ritorna: il nome del form (dataobject)
//---
//--- Lancia EXCEPTION x errore
//---
//----------------------------------------------------------------------------------------------------------------------------
//
string k_return
st_esito kst_esito



	kst_esito = kguo_exception.inizializza(this.classname())
	
	kst_tab_contratti_doc.form_di_stampa = ""

	if kst_tab_contratti_doc.id_contratto_doc > 0 then
		select data_stampa, trim(form_di_stampa)
		  into :kst_tab_contratti_doc.data_stampa, :kst_tab_contratti_doc.form_di_stampa 
		  from contratti_doc 
		  where id_contratto_doc = :kst_tab_contratti_doc.id_contratto_doc  
		  using kguo_sqlca_db_magazzino;
	
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Recupero nome Form di stampa Contratto R. & D. (tab. contratti_doc id=" + string(kst_tab_contratti_doc.id_contratto_doc) + " " + "): " + trim(SQLCA.SQLErrText)
										 
			kst_esito.esito = kkg_esito.db_ko
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)		
			throw kguo_exception
			
		end if
	end if
	
	if kst_tab_contratti_doc.form_di_stampa > " " then
	else
		kst_tab_contratti_doc.form_di_stampa = kki_form_di_stampa_attuale
//		kst_tab_contratti_doc.form_di_stampa = ""
	end if
	if isnull(kst_tab_contratti_doc.data_stampa) then
		kst_tab_contratti_doc.data_stampa = KKG.DATA_ZERO
	end if
	
	k_return = kst_tab_contratti_doc.form_di_stampa 

return k_return


end function

on kuf_contratti_doc.create
call super::create
end on

on kuf_contratti_doc.destroy
call super::destroy
end on

