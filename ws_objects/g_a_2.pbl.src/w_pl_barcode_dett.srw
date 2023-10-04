$PBExportHeader$w_pl_barcode_dett.srw
forward
global type w_pl_barcode_dett from w_g_tab0
end type
type cb_chiudi from statictext within w_pl_barcode_dett
end type
type cb_togli from statictext within w_pl_barcode_dett
end type
type cb_aggiungi from statictext within w_pl_barcode_dett
end type
type dw_groupage from uo_d_std_1 within w_pl_barcode_dett
end type
type dw_barcode from uo_d_std_1 within w_pl_barcode_dett
end type
type dw_meca from uo_d_std_1 within w_pl_barcode_dett
end type
type dw_periodo from uo_d_std_1 within w_pl_barcode_dett
end type
type dw_prev from uo_d_std_1 within w_pl_barcode_dett
end type
type dw_pilota_inlav from uo_d_std_1 within w_pl_barcode_dett
end type
end forward

global type w_pl_barcode_dett from w_g_tab0
boolean visible = true
integer width = 3685
integer height = 2320
string title = "Piano di Lavorazione"
boolean hscrollbar = true
boolean vscrollbar = true
long backcolor = 16777215
windowanimationstyle closeanimation = bottomroll!
boolean ki_toolbar_window_presente = true
boolean ki_reset_dopo_save_ok = false
cb_chiudi cb_chiudi
cb_togli cb_togli
cb_aggiungi cb_aggiungi
dw_groupage dw_groupage
dw_barcode dw_barcode
dw_meca dw_meca
dw_periodo dw_periodo
dw_prev dw_prev
dw_pilota_inlav dw_pilota_inlav
end type
global w_pl_barcode_dett w_pl_barcode_dett

type variables

private constant long ki_dw_groupage_colore = rgb(173,174,222)
//private datastore kdsi_elenco
//private datastore kids_meca_orig
//private datawindow kidw_selezionata
private datawindow kidw_x_modifica_giri
private boolean ki_dragdrop = false
//private boolean ki_modifica_cicli_enabled = false
private boolean ki_chiudi_PL_enabled = false
private boolean ki_PL_chiuso = false
private boolean ki_operazione_chiusura = false
private boolean ki_consenti_lavoraz_non_associati_wmf = false
//private constant char ki_modalita_modifica_scelta_fila="0"
//private constant char ki_modalita_modifica_giri_riga="1"
//private constant char ki_modalita_modifica_giri_righe="2"
//private constant char ki_modalita_modifica_giri_visualizza="3"
private date ki_data_ini 
private date ki_data_fin 

private boolean ki_lista_0_modifcato=false

private kuf_pl_barcode kiuf1_pl_barcode
private kuf_armo kiuf_armo
private kuf_barcode kiuf_barcode
private kuf_barcode_mod_giri kiuf_barcode_mod_giri
private kuf_asdrackbarcode kiuf_asdrackbarcode
private kuf_barcode_asd kiuf_barcode_asd

private boolean ki_autorizza_marca_stato_in_attenzione=false

private string ki_dw_fuoco_nome = ""  // datawindow da cui ho iniziato a fare il drag&drop

private long ki_riga_pos_dw_meca = 0
//private long ki_id_meca_pos_dw_meca = 0

private kuf_e1_asn kiuf_e1_asn
private boolean ki_e1_enabled = false

private int ki_nchoosed

private boolean ki_dw_prev_firsttime=true
private kuf_pilota_previsioni kiuf_pilota_previsioni

private boolean ki_refresh_dw_meca_needed=false

private boolean ki_dw_pilota_inlav_firsttime=true

private boolean ki_save_for_crash_insert=false

//private string ki_dw_focus_dataobject
end variables

forward prototypes
private function string cancella ()
private subroutine modifica_giri_riferimento ()
protected subroutine pulizia_righe ()
private subroutine proteggi_giri_barcode ()
protected function integer inserisci ()
protected subroutine stampa ()
public subroutine togli_dettaglio ()
protected function boolean dati_modif_1 ()
protected function string dati_modif (string k_titolo)
public subroutine imposta_codice_progr (ref datawindow kdw_1)
private function string aggiorna_tabelle ()
protected subroutine dw_groupage_colore (ref datawindow k_dw)
protected function string check_dati ()
protected function string inizializza ()
protected function string leggi_liste ()
private subroutine proteggi_campi ()
protected subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
private function boolean if_pl_barcode_chiuso ()
private subroutine set_dw_dett_0 (st_tab_pl_barcode kst_tab_pl_barcode)
private subroutine open_elenco_pilota_coda () throws uo_exception
private subroutine open_notepad_documento () throws uo_exception
private subroutine togli_figli_al_dw_groupage (st_tab_barcode kst_tab_barcode)
public subroutine togli_barcode_padre (ref datawindow kdw_1)
public subroutine togli_barcode_figlio (ref datawindow kdw_1)
private subroutine scegli_padre_da_dw_lista (long k_riga_dw_groupage)
private function integer call_window_barcode ()
private function st_esito retrieve_figlio_nel_dw_groupage (st_tab_barcode kst_tab_barcode)
private function st_esito retrieve_padre_nel_dw_lista (st_tab_barcode kst_tab_barcode)
private function st_esito retrieve_padri ()
protected function st_esito aggiorna_window ()
private subroutine cambia_periodo_elenco ()
protected subroutine open_start_window ()
public subroutine set_base_data_ini ()
private subroutine open_elenco_lettore_grp ()
public subroutine set_stato_in_attenzione ()
public subroutine call_elenco_grp ()
private subroutine chiudi_pl_elabora () throws uo_exception
private function integer chiudi_pl ()
private function integer apri_pl ()
private subroutine apri_pl_elabora () throws uo_exception
protected subroutine riempi_id ()
public subroutine u_marca_rif_file_davanti ()
protected function string inizializza_post ()
private subroutine u_autorizza_stato_in_attenzione ()
private function boolean u_autorizza_mod_consegna_data ()
public subroutine u_aggiorna_data_consegna (st_tab_meca kst_tab_meca, long k_riga)
private subroutine u_abilita_chiusura_pl ()
public subroutine u_mostra_proprieta (boolean k_forza_visible)
private subroutine copia_dw_barcode_to_dw_lista_0 (integer k_riga1, integer k_riga2)
private subroutine copia_dw_lista_0_to_dw_groupage (integer k_riga1, integer k_riga2)
private subroutine copia_dw_groupage_to_dw_barcode (integer k_riga1, integer k_riga2)
private subroutine copia_dw_lista_0_to_dw_barcode (integer k_riga1, integer k_riga2)
private subroutine copia_dw_groupage_to_dw_lista_0 (integer k_riga1, integer k_riga2)
public function boolean if_lotto_associato (ref st_tab_meca ast_tab_meca) throws uo_exception
protected function string aggiorna_dati ()
protected subroutine attiva_tasti_0 ()
public subroutine u_obj_visible_0 ()
public function boolean u_resize_predefinita ()
private subroutine u_check_troppi_barcode ()
private subroutine copia_dw_barcode_to_dw_groupage (integer k_riga1, integer k_riga2) throws uo_exception
private subroutine u_aggiungi_barcode_tutti (ref datawindow adw_out)
private subroutine u_aggiungi_barcode_padre (st_tab_barcode kst_tab_barcode)
private subroutine u_abilita_modifica_giri (st_tab_barcode ast_tab_barcode)
public subroutine u_aggiungi_barcode_singolo (ref datawindow adw_out, ref datawindow adw_inp)
private function long u_aggiungi_barcode_tutti_1 (long a_row, ref datawindow adw_out)
private subroutine u_refresh_dw ()
private subroutine modifica_giri_old (string a_modalita_modifica_file, long a_riga, ref datawindow a_dw_modifica_giri)
public subroutine u_set_dw_icon ()
private function boolean u_modifica_giri (ref datawindow a_dw_modifica_giri, long a_riga)
private subroutine screma_lista_dw_barcode ()
private function st_esito retrieve_figli_all ()
private subroutine screma_lista_from_dw_lista (long a_riga)
private subroutine screma_lista_from_dw_xxx_1 (long a_riga, ref datawindow adw_inp)
private subroutine screma_lista_from_dw_groupage (long a_riga)
private function st_esito screma_lista_riferimenti_from_dw_all ()
private function st_esito oldscrema_lista_riferimenti ()
public subroutine u_get_dw_x_cambio_giri (ref uo_d_std_1 adw_1)
private function long u_check_rif_file_davanti (long a_riga_inp)
public function boolean if_lotto_rack_asscociati () throws uo_exception
private subroutine u_aggiungi_figli_al_dw_groupage (st_tab_barcode kst_tab_barcode)
private subroutine u_aggiungi_figli_dal_dw_lista (long a_row)
public subroutine u_aggiungi_grp_barcode_singolo (ref datawindow kdw_2)
public subroutine u_aggiungi_grp_rif_intero (ref datawindow kdw_1)
public function string u_check_programmazione ()
protected function boolean if_programmazione_ok () throws uo_exception
protected function boolean if_programmazione_rack_completa () throws uo_exception
public subroutine if_lotto_rack_con_padri () throws uo_exception
private function long u_aggiungi_barcode_tutti_check (st_tab_meca ast_tab_meca, readonly long a_meca_row)
public function long u_dw_barcode_retrieve (readonly long a_riga_meca)
private subroutine u_crash_dw_lista_0_restore ()
private subroutine u_crash_dw_lista_0_backup ()
private subroutine u_crash_reset ()
end prototypes

private function string cancella ();//
string k_return="0 "
string k_desc
long k_codice
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
kuf_pl_barcode  kuf1_pl_barcode
st_tab_pl_barcode kst_tab_pl_barcode

//=== Controllo se sul dettaglio c'e' qualche cosa
k_riga = dw_dett_0.rowcount()	
if k_riga > 0 then
	k_codice = dw_dett_0.getitemnumber(1, "codice")
	k_desc = dw_dett_0.getitemstring(1, "note_1")
end if

if k_riga > 0 and isnull(k_codice) = false then	
	if isnull(k_desc) = true or trim(k_desc) = "" then
		k_desc = "senza note " 
	end if
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina Piano di Lavorazione", "Sei sicuro di voler Cancellare : ~n~r" + &
				string(k_codice, "####0") + " " + trim(k_desc), &
				question!, yesno!, 1) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_pl_barcode = create kuf_pl_barcode
		
//=== Cancella la riga dal data windows di lista
		kst_tab_pl_barcode.codice = k_codice
		k_errore = kuf1_pl_barcode.tb_delete(kst_tab_pl_barcode) 
		if Left(k_errore, 1) = "0" then

			k_errore = kGuf_data_base.db_commit()
			if Left(k_errore, 1) <> "0" then
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + Mid(k_errore, 2))

			else
				
				dw_dett_0.deleterow(k_riga)

			end if

			dw_dett_0.setfocus()

		else
			k_errore1 = k_errore
			k_errore = kGuf_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							Mid(k_errore1, 2) ) 	
			if Left(k_errore, 1) <> "0" then
				messagebox("Problemi durante il recupero dell'errore !!", &
					"Controllare i dati. " + Mid(k_errore, 2))
			end if

			attiva_tasti()
	

		end if

//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
		destroy kuf1_pl_barcode

	else
		messagebox("Elimina P. L.", "Operazione Annullata !!")
	end if

	dw_dett_0.setcolumn(1)

end if

return(k_return)
end function

private subroutine modifica_giri_riferimento ();
end subroutine

protected subroutine pulizia_righe ();//
//=== STANDARD MODIFICABILE 
//=== Oltre a confermare ACCEPTTEXT toglie righe da non UPDATE
//
string k_key
long k_riga, k_ctr


dw_dett_0.accepttext()
dw_lista_0.accepttext()
dw_groupage.accepttext()


//=== Pulisco eventuali righe rimaste vuote e aggiusto campi a NULL
k_riga = dw_dett_0.rowcount ( )
for k_ctr = k_riga to 1 step -1

 	if (isnull(dw_dett_0.getitemnumber(k_ctr, "codice") ) or dw_dett_0.getitemnumber(k_ctr, "codice") = 0) and &
 		(isnull(dw_dett_0.getitemdate(k_ctr, "data") ) or dw_dett_0.getitemdate(k_ctr, "data") = date(0)) and &
 		(isnull(dw_dett_0.getitemstring(k_ctr, "note_1") ) or Len(trim(dw_dett_0.getitemstring(k_ctr, "note_1") )) = 0) and &
 		(isnull(dw_dett_0.getitemstring(k_ctr, "note_2") ) or Len(trim(dw_dett_0.getitemstring(k_ctr, "note_2") )) = 0) &
	 	then
		dw_dett_0.deleterow(k_ctr)
	end if
next
if dw_dett_0.rowcount( ) <= 0 then
	inserisci()
end if

//=== Pulisco eventuali righe rimaste vuote e aggiusto campi a NULL
k_riga = dw_lista_0.rowcount ( )
for k_ctr = k_riga to 1 step -1
	k_key = dw_lista_0.getitemstring(k_ctr, "barcode_barcode") 
 	if isnull(k_key) or Len(trim(k_key)) = 0 then
		dw_lista_0.deleterow(k_ctr)
	end if
next

//=== Pulisco eventuali righe rimaste vuote e aggiusto campi a NULL
k_riga = dw_groupage.rowcount ( )
for k_ctr = k_riga to 1 step -1
	k_key = dw_groupage.getitemstring(k_ctr, "barcode_barcode") 
 	if isnull(k_key) or Len(trim(k_key)) = 0 then
		dw_groupage.deleterow(k_ctr)
	end if
next



end subroutine

private subroutine proteggi_giri_barcode ();//
//=== Proteggo giri barcode in groupage
//dw_groupage.Object.barcode_fila_1.TabSequence='0'
//dw_groupage.Object.barcode_fila_2.TabSequence='0'

end subroutine

protected function integer inserisci ();//
st_tab_pl_barcode kst_tab_pl_barcode


	ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento

//=== Pulizia della riga
	dw_lista_0.reset()
	dw_groupage.reset()

//--- Aggiunge una riga al dw delle proprietà
//--- setta i dati di default del pl_barcode
	kiuf1_pl_barcode.set_pl_barcode_nuovo_default(kst_tab_pl_barcode)
	set_dw_dett_0(kst_tab_pl_barcode)

//	dw_dett_0.setcolumn("data")


//=== Posiziona il cursore sul Data Windows
//	dw_dett_0.setfocus() 

	attiva_tasti()

	proteggi_campi()

//--- rilegge le liste utili al nuovo programma da fare
	ki_riga_pos_dw_meca = dw_meca.getrow( )  //cattura la riga selezionata
	//if ki_riga_pos_dw_meca > 0 then
	//	ki_id_meca_pos_dw_meca = dw_meca.getitemnumber( ki_riga_pos_dw_meca, "id_meca")
	//end if
	dw_meca.setfocus( )
	leggi_liste()


return (0)


end function

protected subroutine stampa ();//
string k_nome_controllo = " "
st_stampe kst_stampe
w_g_tab kwindow_1


//k_nome_controllo = kGuf_data_base.u_getfocus_nome()

//if dw_prev.visible or dw_pilota_inlav.visible then
//if ki_dw_focus_dataobject > " " then
//	k_nome_controllo = ki_dw_focus_dataobject
//else
	k_nome_controllo = kidw_selezionata.dataobject 
//end if

choose case k_nome_controllo
	case dw_lista_0.dataobject
	
		kwindow_1 = kGuf_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_lista_0
		kst_stampe.titolo = ("Barcode in lavorazione nel P.L. " + string(dw_dett_0.getitemnumber(1, "codice")))
		kGuf_data_base.stampa_dw(kst_stampe)

	case dw_groupage.dataobject //"d_pl_barcode_dett_grp_all"
	
		kwindow_1 = kGuf_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_groupage
		kst_stampe.titolo = ("Barcode in 'groupage' nel P.L. " + string(dw_dett_0.getitemnumber(1, "codice")))
		kGuf_data_base.stampa_dw(kst_stampe)

	case dw_meca.dataobject //"d_meca_barcode_elenco_no_lav"
	
		kwindow_1 = kGuf_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_meca
		kst_stampe.titolo = trim(dw_meca.title)
		kGuf_data_base.stampa_dw(kst_stampe)
		
	case dw_barcode.dataobject // "d_barcode_l_no_pl"
	
		kwindow_1 = kGuf_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_barcode
		kst_stampe.titolo = trim(dw_barcode.title)
		kGuf_data_base.stampa_dw(kst_stampe)
		
	case dw_prev.dataobject
	
		kwindow_1 = kGuf_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_prev
		kst_stampe.titolo = trim(dw_prev.title)
		kGuf_data_base.stampa_dw(kst_stampe)
		
	case dw_pilota_inlav.dataobject
	
		kwindow_1 = kGuf_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_pilota_inlav
		kst_stampe.titolo = trim(dw_pilota_inlav.title)
		kGuf_data_base.stampa_dw(kst_stampe)
		
end choose

end subroutine

public subroutine togli_dettaglio ();//
//=== 
//
long k_riga
long k_id_meca
int k_rc


ki_lista_0_modifcato = true
	
if dw_barcode.rowcount() > 0 then
		
	k_id_meca = dw_barcode.getitemnumber(1, "id_meca")
	k_riga = dw_meca.getselectedrow(0)
	if k_riga > 0 then
		if k_id_meca <> dw_meca.getitemnumber(k_riga, "id_meca") then
			k_riga = 0
		end if
	end if
	if k_riga = 0 then
		k_riga = dw_meca.find("id_meca = " + string(k_id_meca), 1, dw_meca.rowcount()) 
	end if	
	//ki_riga_pos_dw_meca = 0  //cattura la riga selezionata
	//leggi_liste()
	if k_riga > 0 then
		dw_meca.reselectrow(k_riga)
		dw_meca.scrolltorow(k_riga)
		dw_meca.selectrow( 0, false)
		dw_meca.selectrow(k_riga, true)
	end if
	
	k_rc = dw_barcode.reset() 
	
end if
	

//--- Riempe il titolo della dw di dettaglio
if dw_barcode.rowcount() > 0 then
	dw_barcode.title = "Dettaglio Riferimento: " + string(dw_barcode.getitemnumber(1, "barcode_num_int"))
else
	dw_barcode.title = "Dettaglio Riferimento " 
end if



end subroutine

protected function boolean dati_modif_1 ();//
//--- dati modificati?
//--- true=si; false=no
//
boolean k_boolean = false


	if dw_dett_0.getitemnumber( 1, "codice") > 0 then
	else
		
//--- pl nuovo
		if dw_lista_0.rowcount( ) = 0 then 
			ki_lista_0_modifcato = false
		end if

//	else
//		if dw_dett_0.getitemnumber( 1, "codice") > 0 then
//		else
//			ki_lista_0_modifcato = false
//		end if
	end if			
			
	//if dw_dett_0.u_dati_modificati() &
	if ki_lista_0_modifcato then
//			or dw_groupage.u_dati_modificati() &
//			or dw_lista_0.u_dati_modificati() & 
		
		k_boolean = true
		
	end if
			
return k_boolean
	
end function

protected function string dati_modif (string k_titolo);//=== Controllo se ci sono state modifiche di dati sui DW
string k_return="0 "
int k_msg
string k_key


	dw_dett_0.accepttext()

//=== Toglie le righe eventualmente da non registrare
	pulizia_righe()

//	if cb_aggiorna.enabled then
		
//		if dw_dett_0.getnextmodified ( 0, primary!) > 0 or &
//			dw_dett_0.getnextmodified ( 0, filter!) > 0 or &		
//			dw_lista_0.getnextmodified ( 0, primary!) > 0 or &
//			dw_lista_0.getnextmodified ( 0, filter!) > 0 or & 
//			dw_groupage.getnextmodified ( 0, primary!) > 0 or &
//			dw_groupage.getnextmodified ( 0, filter!) > 0 then		

		if dati_modif_1() then
			
			k_return = "1"
	
			if isnull(k_titolo) or Len(trim(k_titolo)) = 0 then
				k_titolo = "Aggiorna Archivio"
			end if
	
			k_msg = messagebox(k_titolo, "Dati Modificati, vuoi Salvare gli Aggiornamenti ?", &
								question!, yesnocancel!, 1) 
		
			k_return = string(k_msg, "0")
			
		end if
//	end if

return k_return
end function

public subroutine imposta_codice_progr (ref datawindow kdw_1);//
//=== Imposta nella lista dw_lista i progressivi del dettaglio del P.L.
//
long k_riga, k_pl_barcode=0, k_progr, k_progr_old


if isvalid(kdw_1) then
						
//--- Risistema i progressivi		
	if dw_dett_0.getrow() > 0 then
		k_pl_barcode = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")
	end if
	if isnull(k_pl_barcode) then
		k_pl_barcode = 0
	end if
	
	for k_riga = 1 to kdw_1.rowcount() 
		if trim(kdw_1.getitemstring(k_riga, "barcode_barcode")) > " " then
			kdw_1.setitem(k_riga, "barcode_pl_barcode", k_pl_barcode)
			k_progr ++ //= k_riga 
			k_progr_old = kdw_1.getitemnumber(k_riga, "barcode_pl_barcode_progr")
			if k_progr_old <> k_progr or isnull(k_progr_old) then
				ki_lista_0_modifcato = true
				kdw_1.setitem(k_riga, "barcode_pl_barcode_progr", k_progr)
			end if
		else
			kdw_1.deleterow(k_riga)
		end if
	next

end if
end subroutine

private function string aggiorna_tabelle ();//
//=== Update delle Tabelle
string k_return = "0 "
long k_riga, k_pl_barcode, k_n_righe
int k_rc
//kuf_pl_barcode kuf1_pl_barcode
//kuf_barcode kuf1_barcode
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_barcode kst_tab_barcode
st_esito kst_esito //, kst_esito_null


	kst_esito = kguo_exception.inizializza(this.classname())

	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		dw_dett_0.setitemstatus(1, 0, primary!, NewModified!)
	end if
	
	kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(1, "codice")			
	kst_tab_pl_barcode.data = dw_dett_0.getitemdate(1, "data")			
	kst_tab_pl_barcode.data_chiuso = date(0) //dw_dett_0.getitemdate(1, "data_chiuso")			
	kst_tab_pl_barcode.data_sosp = dw_dett_0.getitemdate(1, "data_sosp")			
	kst_tab_pl_barcode.note_1 = trim(dw_dett_0.getitemstring(1, "note_1"))		
	kst_tab_pl_barcode.note_2 = trim(dw_dett_0.getitemstring(1, "note_2"))
	kst_tab_pl_barcode.stato = dw_dett_0.getitemstring(1, "stato")			
	kst_tab_pl_barcode.priorita = dw_dett_0.getitemstring(1, "priorita")			
	kst_tab_pl_barcode.prima_del_barcode = dw_dett_0.getitemstring(1, "prima_del_barcode")			

//	kuf1_pl_barcode = create kuf_pl_barcode
	kst_esito = kiuf1_pl_barcode.tb_update( kst_tab_pl_barcode ) 
	
	if kst_tab_pl_barcode.codice > 0 then
		k_rc=dw_dett_0.setitem(1, "codice",kst_tab_pl_barcode.codice)	
	end if

	if kst_esito.esito <> kkg_esito.ok then

		if kst_esito.esito = "1" then
			k_return = trim(kst_esito.esito) + trim(kst_esito.sqlerrtext) + "~r~n(sqlcode=" + string(kst_esito.sqlcode) + ")" + "~r~nP.L. da aggiornare non trovato! "
		else
			k_return = trim(kst_esito.esito) + trim(kst_esito.sqlerrtext) + "~r~n(sqlcode=" + string(kst_esito.sqlcode) + ")" + "~r~ndurante aggiornamento P.L.! "
		end if

		kguo_sqlca_db_magazzino.db_rollback( )

	else

		kguo_sqlca_db_magazzino.db_commit( )

		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			k_return = "1" + string(kguo_sqlca_db_magazzino.sqlcode, "000") + trim(kguo_sqlca_db_magazzino.SQLErrText)
		end if					
		
//		dw_dett_0.resetupdate()
				
	end if
			
	if kst_esito.esito = kkg_esito.ok then
//		if Left(k_return,1) = "0" then
//		if dw_lista_0.getnextmodified ( 0, primary!) > 0 or &
//			dw_lista_0.getnextmodified ( 0, filter!) > 0 then		

			k_pl_barcode = dw_dett_0.getitemnumber(1, "codice")	
			if k_pl_barcode > 0 then
	
//				dw_dett_0.setitem(dw_dett_0.getrow(), "codice", k_pl_barcode)			
	
				//kuf1_barcode = create kuf_barcode
	
				kst_tab_barcode.pl_barcode = k_pl_barcode		
				k_return = kiuf_barcode.togli_pl_barcode_all( kst_tab_barcode ) 
	
				if Left(k_return,1) = "0" then

					kst_esito = kguo_exception.inizializza(this.classname())
					//kst_esito = kst_esito_null
					//kst_esito.esito =  kkg_esito.ok
					k_n_righe = dw_lista_0.rowcount()
					k_riga = 1 
					do while k_riga <= k_n_righe and kst_esito.esito = kkg_esito.ok
		
						dw_lista_0.setitem(k_riga, "barcode_pl_barcode", k_pl_barcode)
		
						kst_tab_barcode.barcode = trim(dw_lista_0.getitemstring(k_riga, "barcode_barcode"))
//						kst_tab_barcode.data_lav_ini = kst_tab_pl_barcode.data_chiuso
//						kst_tab_barcode.groupage = "N" 
//						kst_tab_barcode.fila_1 = dw_lista_0.getitemnumber(k_riga, "barcode_fila_1")			
//						kst_tab_barcode.fila_2 = dw_lista_0.getitemnumber(k_riga, "barcode_fila_2")			
//						kst_tab_barcode.fila_1p = dw_lista_0.getitemnumber(k_riga, "barcode_fila_1p")			
//						kst_tab_barcode.fila_2p = dw_lista_0.getitemnumber(k_riga, "barcode_fila_2p")			
						kst_tab_barcode.pl_barcode = dw_lista_0.getitemnumber(k_riga, "barcode_pl_barcode")			
						kst_tab_barcode.pl_barcode_progr = dw_lista_0.getitemnumber(k_riga, "barcode_pl_barcode_progr")			
//						kst_tab_barcode.x_datins  = dw_lista_0.getitemdatetime(k_riga, "barcode_x_datins")			
//						kst_tab_barcode.x_utente = trim(dw_lista_0.getitemstring(k_riga, "barcode_x_utente"))
			
						kst_esito = kiuf_barcode.set_pl_barcode( kst_tab_barcode, "normale") 
						
						k_riga++ 
						 
					loop

					k_n_righe = dw_groupage.rowcount()
					k_riga = 1 
					do while k_riga <= k_n_righe and trim(kst_esito.esito) =  kkg_esito.ok
		
						dw_groupage.setitem(k_riga, "barcode_pl_barcode", k_pl_barcode)
		
						kst_tab_barcode.barcode = trim(dw_groupage.getitemstring(k_riga, "barcode_barcode"))
//						kst_tab_barcode.data_lav_ini = kst_tab_pl_barcode.data_chiuso
//						kst_tab_barcode.groupage = "S" 
//						kst_tab_barcode.fila_1 = dw_groupage.getitemnumber(k_riga, "barcode_fila_1")			
//						kst_tab_barcode.fila_2 = dw_groupage.getitemnumber(k_riga, "barcode_fila_2")			
//						kst_tab_barcode.fila_1p = dw_groupage.getitemnumber(k_riga, "barcode_fila_1p")			
//						kst_tab_barcode.fila_2p = dw_groupage.getitemnumber(k_riga, "barcode_fila_2p")			
						kst_tab_barcode.pl_barcode = dw_groupage.getitemnumber(k_riga, "barcode_pl_barcode")			
						kst_tab_barcode.pl_barcode_progr = dw_groupage.getitemnumber(k_riga, "barcode_pl_barcode_progr")			
//						kst_tab_barcode.x_datins  = dw_groupage.getitemdatetime(k_riga, "x_datins")			
//						kst_tab_barcode.x_utente = trim(dw_groupage.getitemstring(k_riga, "x_utente"))
			
						kst_esito = kiuf_barcode.set_pl_barcode( kst_tab_barcode, "normale") 
						
						k_riga++ 
						
					loop

					k_return = trim(kst_esito.esito) + kst_esito.sqlerrtext + " (" + string(kst_esito.sqlcode) + ") "
					
				end if

	
				if Left(k_return,1) <> "0" then
				
					if Left(k_return,1) = "1" then
						k_return = k_return + "~r~n(Barcode da aggiornare non trovato!) "
					else
						k_return = k_return + "~r~n(durante aggiornamento Barcode!) "
					end if
					kguo_sqlca_db_magazzino.db_rollback( )
	
				else
					kguo_sqlca_db_magazzino.db_commit( )

					if kguo_sqlca_db_magazzino.sqlcode < 0 then
						k_return = "1" + string(kguo_sqlca_db_magazzino.sqlcode, "000") + trim(kguo_sqlca_db_magazzino.SQLErrText)
					else	
						ki_lista_0_modifcato = false
//						dw_lista_0.resetupdate()
//						dw_groupage.resetupdate()
						dati_modif_1()
					end if					
					
				end if
			else
	
				k_return = "1Errore. Aggiornamento Fallito: manca codice P.L."
	
			end if
//		end if		
	end if

	kguo_sqlca_db_magazzino.db_commit( )

//	if isvalid(kuf1_pl_barcode) then	destroy kuf1_pl_barcode
//	if isvalid(kuf1_barcode) then	destroy kuf1_barcode

	u_crash_reset( )  // pulisce il backup di ripri

return k_return


end function

protected subroutine dw_groupage_colore (ref datawindow k_dw);//---
//--- Cambia il colore della DW GROUPAGE
//---
int k_rc
int k_ctr, k_colcount
string  k_rcx, k_str, k_string
//long k_num


	
	k_dw.modify("DataWindow.Color='" + string(ki_dw_groupage_colore) + "' " )	
	k_dw.modify("k_contati.Background.Color='" + string(ki_dw_groupage_colore) + "' " )	
//	k_dw.modify("k_fila_1.Background.Color='" + string(ki_dw_groupage_colore) + "' " )	
//	k_dw.modify("k_fila_2.Background.Color='" + string(ki_dw_groupage_colore) + "' " )	
//	k_dw.modify("k_fila_1p.Background.Color='" + string(ki_dw_groupage_colore) + "' " )	
//	k_dw.modify("k_fila_2p.Background.Color='" + string(ki_dw_groupage_colore) + "' " )	
//	k_dw.modify("k_pedane.Background.Color='" + string(ki_dw_groupage_colore) + "' " )	

	k_colcount = integer(k_dw.Describe("DataWindow.Column.Count"))


	for k_ctr = 1 to k_colcount 

//--- estrae nome colonna
//		k_nome = trim(k_dw.Describe("#" + trim(string(k_ctr,"###")) + ".name"))

//--- copia Proprieta' VISIBLE
		k_rcx=k_dw.modify("#" + trim(string(k_ctr,"###")) + ".backgroundcolor = '" &
		                        + string(ki_dw_groupage_colore) &
										+ "' " )
		
	next




end subroutine

protected function string check_dati ();//=== Controllo congruenza dei dati caricati. 
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//
//=== Controllo dati inseriti
string k_return = " ", k_errore="0", k_barcode=""
date  k_dataoggi
int k_nr_errori, k_pl_barcode_progr 
long k_riga, k_nr_righe, k_riga_find, k_riga_find_1, k_riga_ds
st_esito kst_esito
st_tab_barcode kst_tab_barcode_padre, kst_tab_barcode_figlio, kst_tab_barcode
st_tab_meca kst_tab_meca
//kuf_barcode kuf1_barcode
ds_pl_barcode_dett kds_pl_barcode_dett
st_tab_pl_barcode kst_tab_pl_barcode


	kds_pl_barcode_dett = create ds_pl_barcode_dett
//	kuf1_barcode = create kuf_barcode

	dw_lista_0.accepttext()
	dw_groupage.accepttext()
	
	k_riga = dw_dett_0.getrow() 

	if isnull(dw_dett_0.getitemnumber(k_riga, "codice")) then
		dw_dett_0.setitem(k_riga, "codice", 0)
	end if

//--- controllo se PL ancora aperto altrimenti NISBA
	try 
		kst_tab_pl_barcode.codice = dw_dett_0.object.codice[1]
		if kst_tab_pl_barcode.codice > 0 then
			if not kiuf1_pl_barcode.if_pl_barcode_aperto(kst_tab_pl_barcode) then
				ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione   // forza visualizzazione
				k_return = k_return + & 
					"Piano di Lavorazione NON APERTO, operazione bloccata! Prego uscire Immediatamente.  " + "~n~r"
				k_errore = "1"
			end if
		end if
	catch (uo_exception kuo1_exception)
		kst_esito = kuo1_exception.get_st_esito()
		k_return = k_return + "Errore: " + trim(kst_esito.sqlerrtext)  + "~n~r"
		k_errore = "1"
	end try

	try
//--- Controllo programmazione
		if_programmazione_ok()
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito( )
		k_return = k_return + trim(kst_esito.sqlerrtext) + "~n~r"
		k_errore = "1"
	end try


	if k_errore = "0" or k_errore = "4" then
		kst_tab_pl_barcode.data = dw_dett_0.getitemdate ( k_riga, "data") 
		if isnull(kst_tab_pl_barcode.data) or kst_tab_pl_barcode.data = date(0) then
			k_return = k_return + & 
				"Impostare la data di questo P.L.  " + "~n~r"
			k_errore = "3"
		end if
	
//--- se sono in CHIUSURA controlla la data	
		if ki_operazione_chiusura then 
	
			kst_tab_pl_barcode.data_chiuso = dw_dett_0.getitemdate ( k_riga, "data_chiuso") 
			if k_errore = "0" or k_errore = "4" then
				if kst_tab_pl_barcode.data_chiuso > date(0) then
					if kst_tab_pl_barcode.data > kst_tab_pl_barcode.data_chiuso then
						k_return = k_return + & 
				 "Data di Chiusura " + string(kst_tab_pl_barcode.data_chiuso) + " minore della data del Piano " + string(kst_tab_pl_barcode.data) + ". Prego sistemarla.~n~r" 
						k_errore = "3"
					end if
				end if
			end if
		end if
		
	end if

	if k_errore = "0" or k_errore = "4" then
		k_dataoggi = kg_dataoggi
		if k_dataoggi > KKG.DATA_ZERO then
			if kst_tab_pl_barcode.data <> k_dataoggi then
 				k_return = k_return + "Data del P.L. "  + string (kst_tab_pl_barcode.data) + ", diversa dalla data odierna ( " + string(k_dataoggi) +" )~n~r" 
				k_errore = "4"
			end if

//--- se sono in CHIUSURA controlla la data	
			if ki_operazione_chiusura then 
		
				if kst_tab_pl_barcode.data_chiuso > KKG.DATA_ZERO and kst_tab_pl_barcode.data_chiuso <> k_dataoggi then
					k_return = k_return + "Data Chiusura del P.L. " + string(kst_tab_pl_barcode.data_chiuso) + ", diversa dalla data odierna ( " + string(k_dataoggi) +" )~n~r" 
					k_errore = "4"
				end if
			end if
		end if
	end if

	if k_errore = "0" or k_errore = "4" then
		kst_tab_pl_barcode.data_sosp = dw_dett_0.getitemdate ( k_riga, "data_sosp")
		if kst_tab_pl_barcode.data_sosp > kst_tab_pl_barcode.data_chiuso then
 			k_return = k_return + "Data Sospensione " + string(kst_tab_pl_barcode.data_sosp) + " maggiore della data di Chiusura (" + string(kst_tab_pl_barcode.data_chiuso) + ") " + "~n~r" 
			k_errore = "4"
		end if
	end if

//--- controllo la priorita se congruente con il valore nel campo 'pima del barcode'
	if k_errore = "0" or k_errore = "4" then
		if trim(dw_dett_0.getitemstring ( k_riga, "priorita")) = kiuf1_pl_barcode.k_priorita_prima_del_barcode then
			if Len(trim(dw_dett_0.getitemstring ( k_riga, "prima_del_barcode"))) = 0 then
 				k_return = k_return + "Dati errati, indicare il campo 'Prima del Barcode'   " + "~n~r" 
				k_errore = "2"
			end if
		else
			dw_dett_0.setitem ( k_riga, "prima_del_barcode", " ")
		end if
	end if


//---- Controllo Barcode PADRI
	if k_errore = "0" or k_errore = "4" then

//--- Rileggo i dati di trattamento dei barcode figli
		kst_esito = retrieve_padri()
		if kst_esito.esito <> kkg_esito.ok then
			if kst_esito.esito = kkg_esito.db_wrn then
				k_return = k_return  & 
									  + trim(kst_esito.sqlerrtext ) + ";~n~r" 
				k_errore = "4"
				k_nr_errori++
			else
				k_return = k_return  & 
									  + trim(kst_esito.sqlerrtext ) + ";~n~r" 
				k_errore = "1"
				k_nr_errori++
			end if
		end if
	end if
	
	if k_errore = "0" or k_errore = "4" then
//--- 04.02.2009 Controllo che i Barcode non siano già stati caricati con altro Piano di Trattamento
		k_riga = dw_lista_0.rowcount()
		k_nr_errori = 0
	
		do while k_nr_righe > 0 and k_nr_errori < 10

			try 
				k_pl_barcode_progr = dw_lista_0.getitemnumber ( k_riga, "barcode_pl_barcode_progr")
				k_barcode = string(dw_lista_0.getitemstring ( k_riga, "barcode_barcode"))

				kst_tab_barcode.barcode = k_barcode
				kst_tab_barcode.pl_barcode = kiuf_barcode.get_pl_barcode(kst_tab_barcode)

//---- se codice Piano presente è diverso da questo che sto caricando allora GRAVE! 
				if kst_tab_barcode.pl_barcode > 0 and kst_tab_barcode.pl_barcode <> kst_tab_pl_barcode.codice then
					
					k_return = k_return  & 
							  + "Il Barcode "+ trim(k_barcode) +" è già presente nel Piano " + string(kst_tab_barcode.pl_barcode) + ". Lo elimino dalla LISTA~n~r" 
					k_errore = "1"
					k_nr_errori++
					
					dw_lista_0.deleterow(k_riga)  // Elimino la riga gia associata ad altro Piano dalla Lista!!!
					
				end if
				
			catch (uo_exception kuo2_exception)
				kst_esito = kuo2_exception.get_st_esito()
				k_return = k_return  & 
						  + "Problemi durante controllo barcode "  + trim(k_barcode) + " se già pianificato, " + trim(kst_esito.sqlerrtext) + "~n~r"
				k_errore = "1"
			end try
			
			k_riga --
	
		loop

			
//--- altri controlli
		k_nr_righe = dw_lista_0.rowcount()
		k_nr_errori = 0
		k_riga_find = 0 
		k_riga = 1 //dw_lista_0.getnextmodified(0, primary!)
	
		do while k_nr_righe > k_riga and k_nr_errori < 10
	
			k_pl_barcode_progr = dw_lista_0.getitemnumber ( k_riga, "barcode_pl_barcode_progr")

//--- Controllo codici doppi
			if k_riga_find = 0 then
				k_barcode = string(dw_lista_0.getitemstring ( k_riga, "barcode_barcode"))
				k_riga_find = dw_lista_0.find("barcode_barcode = '" + trim(k_barcode) + "' ", k_riga + 1, dw_lista_0.rowcount()) 
				if k_riga_find > 0  then
					k_return = k_return  & 
								  + "Stesso Barcode presente in piu' righe, " + "~n~r" &
								  + "(Codice " + trim(k_barcode) + ") vedi alla riga " + string(k_riga_find) + "; ~n~r"
					k_errore = "1"
					k_nr_errori++
				end if
			end if
			
//--- Tolgo valori a null dai giri
			if isnull(dw_lista_0.getitemnumber ( k_riga, "barcode_fila_1")) then
				dw_lista_0.setitem ( k_riga, "barcode_fila_1", 0)
			end if
			if isnull(dw_lista_0.getitemnumber ( k_riga, "barcode_fila_1p")) then
				dw_lista_0.setitem ( k_riga, "barcode_fila_1p", 0)
			end if
			if isnull(dw_lista_0.getitemnumber ( k_riga, "barcode_fila_2")) then
				dw_lista_0.setitem ( k_riga, "barcode_fila_2", 0)
			end if
			if isnull(dw_lista_0.getitemnumber ( k_riga, "barcode_fila_2p")) then
				dw_lista_0.setitem ( k_riga, "barcode_fila_2p", 0)
			end if

			k_riga++ // = dw_lista_0.getnextmodified(k_riga, primary!) 
	
		loop

	end if


//---- Controllo Barcode FIGLI ------------------------------------------------------------------------------------
	if k_errore = "0" or k_errore = "4" then

//--- Aggiungo eventuali Figli nati all'insaputa fuori da questo pianificazione
		u_aggiungi_figli_dal_dw_lista(0)

//--- Rileggo i dati di trattamento dei barcode figli
		kst_esito = retrieve_figli_all()
		if kst_esito.esito <> kkg_esito.ok then
			if kst_esito.esito = kkg_esito.db_wrn then
				k_return = k_return  & 
									  + trim(kst_esito.sqlerrtext ) + ";~n~r" 
				k_errore = "4"
				k_nr_errori++
			else
				k_return = k_return  & 
									  + trim(kst_esito.sqlerrtext ) + ";~n~r" 
				k_errore = "1"
				k_nr_errori++
			end if
		end if
		
	end if

	if k_errore = "0" or k_errore = "4" then
		k_nr_righe = dw_groupage.rowcount()
		k_nr_errori = 0
		k_riga_find = 0 
		k_riga_find_1 = 0 
		k_riga = 1 
		do while k_nr_righe > k_riga and k_nr_errori < 10
	
			k_barcode = string(dw_groupage.getitemstring ( k_riga, "barcode_barcode"))

//--- Controllo codici doppi
			if k_riga_find = 0 then
				k_riga_find = dw_groupage.find("barcode_barcode = '" + trim(k_barcode) + "' ", k_riga + 1, dw_groupage.rowcount()) 
				if k_riga_find > 0  then
					k_return = k_return  & 
								  + "Stesso 'Figlio' presente su piu' righe, "  &
								  + "(Codice " + trim(k_barcode) + ") vedi alla riga " + string(k_riga_find) + "; ~n~r"
					k_errore = "1"
					k_nr_errori++
				end if
			end if

//--- Controllo che i figli siano già nello stato 20 di E1
			try
				if Left(k_errore,1) = "0" or Left(k_errore,1) = "4" then
					kst_tab_meca.id = dw_groupage.getitemnumber(k_riga, "id_meca")
					if kst_tab_meca.id > 0 then
						if not if_lotto_associato(kst_tab_meca) then
							if NOT ki_consenti_lavoraz_non_associati_wmf then
								k_return = k_return  & 
									  + "Barcode figlio " + trim(k_barcode) + " nello stato diverso da 'associato' ('20'), "  &
									  + " vedi alla riga " + string(k_riga) + "; ~n~r"
								k_errore = "1"
							end if
						end if
					end if	
				end if
				
			catch (uo_exception kuo3_exception)
				kst_esito = kuo3_exception.get_st_esito()
				k_return = k_return  & 
					  + "Problemi durante controllo stato 'Figlio' " + trim(k_barcode) + ", " + trim(kst_esito.sqlerrtext)
				k_errore = "1"
			end try
			
//--- Tolgo valori a null dai giri
			if isnull(dw_groupage.getitemnumber ( k_riga, "barcode_fila_1")) then
				dw_groupage.setitem ( k_riga, "barcode_fila_1", 0)
			end if
			if isnull(dw_groupage.getitemnumber ( k_riga, "barcode_fila_1p")) then
				dw_groupage.setitem ( k_riga, "barcode_fila_1p", 0)
			end if
			if isnull(dw_groupage.getitemnumber ( k_riga, "barcode_fila_2")) then
				dw_groupage.setitem ( k_riga, "barcode_fila_2", 0)
			end if
			if isnull(dw_groupage.getitemnumber ( k_riga, "barcode_fila_2p")) then
				dw_groupage.setitem ( k_riga, "barcode_fila_2p", 0)
			end if

			k_riga++ // = dw_lista_0.getnextmodified(k_riga, primary!) 
	
		loop

	end if

	if k_errore = "0" or k_errore = "4" then

//--- sistema il codice e i progressivi nella lista PADRI
		imposta_codice_progr( dw_lista_0 )
			
//--- sistema il codice e i progressivi nella lista FIGLI
		imposta_codice_progr( dw_groupage )
			
	end if

//	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	if isvalid(kds_pl_barcode_dett) then destroy kds_pl_barcode_dett

return k_errore + trim(k_return)



end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1 e 2=Retrieve fallita (2=uscita Window)
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
long k_key
int  k_rc, k_errore = 0
string k_fine_ciclo="", k_rcx
int k_ctr=0
int k_importa=0
date k_data_chiuso, k_data
kuf_utility kuf1_utility
st_tab_pl_barcode kst_tab_pl_barcode
//kuf_pl_barcode kuf1_pl_barcode
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

	if isnumber(trim(ki_st_open_w.key1)) then
		k_key = long(trim(ki_st_open_w.key1))
		ki_st_open_w.window_title += " ID: " + string(k_key, "#")
		set_titolo_window( )
	end if

	dw_lista_0.reset()
	dw_groupage.reset()
	
//	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
//		
//		k_errore = inserisci()
//		
//	else

		k_rc = dw_dett_0.retrieve(k_key) 

		choose case k_rc

			case is < 0				
				SetPointer(oldpointer)
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(Codice cercato :" + string(k_key) + ")~n~r" )
				cb_ritorna.postevent(clicked!)

//--- nessun codice trovato
			case 0
				SetPointer(oldpointer)
				k_errore = 1
				messagebox("Piano di Lavorazione", &
					"Non e' stato trovato in archivio il P.L. ~n~r" + &
					"(Codice cercato :" + string(k_key) + ")~n~r" )
		
				cb_ritorna.postevent("clicked!")
					
//--- se codice trovato
			case is > 0		
				dw_dett_0.resetupdate()
				
				if dw_lista_0.retrieve(k_key, "N") > 0 then

//--- sistema il codice e i progressivi nella lista
					imposta_codice_progr( dw_lista_0 )
					for k_ctr = 1 to dw_lista_0.rowcount()
						dw_lista_0.setitemstatus(k_ctr, 0, Primary!, notmodified!)
					end for

					dw_lista_0.selectrow(0, false)
					dw_lista_0.setrow(dw_lista_0.rowcount())
					dw_lista_0.selectrow(dw_lista_0.rowcount(), true)
					dw_lista_0.scrolltorow(dw_lista_0.rowcount())
					dw_lista_0.resetupdate()
					ki_lista_0_modifcato=false					
					
				end if

				if dw_groupage.retrieve(k_key) > 0 then

//--- sistema il codice e i progressivi nella lista
					imposta_codice_progr( dw_groupage )
					for k_ctr = 1 to dw_groupage.rowcount()
						dw_groupage.setitemstatus(k_ctr, 0, Primary!, notmodified!)
					end for

					dw_groupage.selectrow(0, false)
					dw_groupage.setrow(dw_groupage.rowcount())
					dw_groupage.selectrow(dw_groupage.rowcount(), true)
					dw_groupage.scrolltorow(dw_groupage.rowcount())
					
				end if
				dw_groupage.resetupdate()
				

		end choose

//	end if


//--- Se PL gia' chiuso allora nessuna modifica possibile, forza Visualizzazione		
	try
		ki_PL_chiuso = false
		kst_tab_pl_barcode.codice = long(trim(ki_st_open_w.key1))
		if kst_tab_pl_barcode.codice > 0 then
			if not kiuf1_pl_barcode.if_pl_barcode_aperto(kst_tab_pl_barcode) then
//--- se ero entrato per modificare ma non si può allora avvertimento				
				if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
					SetPointer(oldpointer)
					kguo_exception.inizializza( )
					kguo_exception.messaggio_utente("Modifica Piano bloccata", &
						"Il Piano è già stato chiuso cambio modalità in VISUALIZZAZIONE")
				end if
				ki_PL_chiuso = true
				ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
			end if
		end if
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try
	

	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
		
		u_crash_dw_lista_0_restore() // se uscito con un crash allora tenta il ripristino
		
		u_aggiungi_figli_dal_dw_lista(0)
		dw_lista_0.ki_attiva_dragdrop = true
		dw_barcode.ki_attiva_dragdrop = true
		dw_meca.ki_attiva_dragdrop = true
		dw_groupage.ki_attiva_dragdrop = true
	else
		dw_lista_0.ki_attiva_dragdrop = false
		dw_barcode.ki_attiva_dragdrop = false
		dw_meca.ki_attiva_dragdrop = false
		dw_groupage.ki_attiva_dragdrop = false
	end if
	
	if k_errore = 0 then

		if ki_st_open_w.flag_primo_giro = 'S' then

			ki_riga_pos_dw_meca = 0  //cattura la riga selezionata
			retrieve_figli_all( )   // verifica i figli
			leggi_liste()
			dw_lista_0.resetupdate()
			ki_lista_0_modifcato=false					
		end if

		proteggi_campi()
		
	end if
	
	//dw_dett_0.bringtotop = true
	
	attiva_tasti()

	dw_meca.setfocus()

	SetPointer(oldpointer)


return k_return



end function

protected function string leggi_liste ();//
//======================================================================
//=== Liste Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
string k_sort = " "
long k_pl_barcode=0, k_riga=0
int k_rc
st_tab_barcode kst_tab_barcode
datastore kds_meca_kchoose



	SetPointer(kkg.pointer_attesa)

	dw_meca.setredraw(false)
	dw_barcode.reset( )

	if dw_dett_0.getrow() > 0 then
		k_pl_barcode = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")
	end if
	if isnull(k_pl_barcode)  then
		k_pl_barcode = 0
	end if

//--- cattura la riga corrente x riproporla dopo la retrieve
	if ki_riga_pos_dw_meca > dw_meca.rowcount() then
		ki_riga_pos_dw_meca = dw_meca.rowcount()
	end if
	if ki_riga_pos_dw_meca > 0 then
		kst_tab_barcode.id_meca = dw_meca.getitemnumber(ki_riga_pos_dw_meca, "id_meca")
		kst_tab_barcode.fila_1 = dw_meca.getitemnumber(ki_riga_pos_dw_meca, "barcode_fila_1")
		kst_tab_barcode.fila_2 = dw_meca.getitemnumber(ki_riga_pos_dw_meca, "barcode_fila_2")
	end if

//=== acchiappa il sort della merce da trattare
	k_sort = dw_meca.Object.DataWindow.Table.Sort

//=== Se nonostante tutto la dw e' a zero allora: retrieve
//	k_data_int = ki_data_ini 

		
	if dw_meca.rowcount() > 0 then
//--- salva il dw_meca x ripri dei selezionati		
		kds_meca_kchoose = create datastore
		kds_meca_kchoose.dataobject = dw_meca.dataobject
		dw_meca.rowscopy(1, dw_meca.rowcount(), Primary!, kds_meca_kchoose, 1, Primary!)
	end if

//--- leggo righe 
//	if kids_meca_orig.rowcount() > 0 and ki_refresh_dw_meca_needed = false then

//		dw_meca.reset()
//--- faccio prima a ripri la copia			
//		kids_meca_orig.rowscopy(1, kids_meca_orig.rowcount(), primary!, dw_meca,1 , primary!)
		
//	else
		ki_refresh_dw_meca_needed = false
		
//--- leggo su DB
		dw_meca.title = "Elenco Riferimenti senza P.L. dal " + string(ki_data_ini, "dd.mm.yyyy")
//		dw_meca.retrieve(k_data_int, 0, 0, 0, "no_pl", k_pl_barcode)
		dw_meca.retrieve(ki_data_ini, k_pl_barcode)
		
//--- copia le righe in dw di appoggio		
//		kids_meca_orig.reset()
//		k_rc=dw_meca.rowscopy(1, dw_meca.rowcount(), primary!, kids_meca_orig,1 , primary!)

//=== Salva le righe del dw (saveas)
		kGuf_data_base.dw_saveas("no_pl", dw_meca)
		
//	end if

//--- ripristino flag di Lotto SELEZIONATO
	if isvalid(kds_meca_kchoose) then 
		dw_meca.event u_restore_k_choose(kds_meca_kchoose, "1")	
		dw_meca.event u_restore_k_choose(kds_meca_kchoose, "2")	
		destroy kds_meca_kchoose
	end if

//--- screma da elenco i Lotti e altro....
	screma_lista_riferimenti_from_dw_all( )

	if Len(trim(k_sort)) > 1 and trim(k_sort) <> "?" then
		dw_meca.setsort(k_sort)
		dw_meca.sort()
	end if

//--- cerca il riferimento su cui era posizionato		
	if dw_meca.rowcount() > 0 then
		k_riga = dw_meca.find("id_meca = " + string(kst_tab_barcode.id_meca) &
														+ " and barcode_fila_1 = " + string(kst_tab_barcode.fila_1) &
														+ " and barcode_fila_2 = " + string(kst_tab_barcode.fila_1) &
														, 1, dw_meca.rowcount())
		if k_riga > 0 then
			ki_riga_pos_dw_meca = k_riga
		end if
	end if

//--- seleziono la riga prec a quella prima della retrieve
	if ki_riga_pos_dw_meca > dw_meca.rowcount() then
		ki_riga_pos_dw_meca = dw_meca.rowcount()
	end if   
	if ki_riga_pos_dw_meca > 0 then
		dw_meca.scrolltorow(ki_riga_pos_dw_meca) // - 4)  
		dw_meca.selectrow(0, false)
		dw_meca.selectrow(ki_riga_pos_dw_meca, true)
	end if

	dw_meca.setredraw(true)
	dw_meca.setfocus( )

	SetPointer(kkg.pointer_default)

return k_return



end function

private subroutine proteggi_campi ();//
//======================================================================
//=== Protegge i campi della Windows
//======================================================================
//
kuf_utility kuf1_utility



//--- Inabilita campi alla modifica se Vsualizzazione
	kuf1_utility = create kuf_utility 
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione &
	   or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.cancellazione then
	
		kuf1_utility.u_proteggi_dw("3", 0, dw_dett_0)
		kuf1_utility.u_proteggi_dw("3", 0, dw_lista_0)
		kuf1_utility.u_proteggi_dw("3", 0, dw_groupage)


	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
		kuf1_utility.u_proteggi_dw("2", 0, dw_dett_0)
		kuf1_utility.u_proteggi_dw("2", 0, dw_lista_0)
		kuf1_utility.u_proteggi_dw("2", 0, dw_groupage)

//--- Inabilita campo codice
		kuf1_utility.u_proteggi_dw("3", 1, dw_dett_0)

	end if
	destroy kuf1_utility

	

	

end subroutine

protected subroutine smista_funz (string k_par_in);//---
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===
long k_riga = 0
uo_d_std_1 kdw_1


choose case trim(k_par_in) 

//--- Personalizzo da qui
	case kkg_flag_richiesta.libero1		//dettaglio barcode
		call_window_barcode()
		
	case kkg_flag_richiesta.libero2		//modifica i cicli del riferimento
		u_get_dw_x_cambio_giri(kdw_1)
		if u_modifica_giri(kdw_1, kidw_selezionata.getselectedrow(0)) then
			if kdw_1.dataobject = dw_meca.dataobject then
				dw_barcode.reset( )
			end if
		end if

////--- controlle se consentito solo visualizzazione
//			//k_riga = kidw_selezionata.getrow() 
//		k_riga = kidw_selezionata.getselectedrow(0)
//		if k_riga > 0 then
//			if ki_modifica_cicli_enabled = kiuf_barcode_mod_giri.ki_modifica_cicli_enabled_modif then
//				modifica_giri(kiuf_barcode_mod_giri.ki_modalita_modifica_giri_riga, k_riga, kidw_selezionata)
//			else
//				modifica_giri(kiuf_barcode_mod_giri.ki_modalita_modifica_giri_visualizza, k_riga, kidw_selezionata)
//			end if
//		end if
	case kkg_flag_richiesta.libero3		//Imposta Flag 'Stato_in_attenzione'
		if cb_aggiungi.enabled then
			set_stato_in_attenzione( )
		end if
	case kkg_flag_richiesta.libero4		//Aggiungi riga
		if cb_aggiungi.enabled then
			cb_aggiungi.postevent(clicked!)
		end if
//	case kkg_flag_richiesta.libero5		//Togli riga
//		if cb_togli.enabled then
//			cb_togli.postevent(clicked!)
//		end if
	case kkg_flag_richiesta.libero5		//Controllo Programmazione
		u_check_programmazione( )
	case kkg_flag_richiesta.libero6		//Riapre/Chiude Progetto
		if cb_chiudi.enabled then
			u_mostra_proprieta(true)
			//cb_chiudi.postevent(clicked!)
		end if
	case kkg_flag_richiesta.libero71		//Consenti di mettere in lavorazione Lotti NON associati in WMF 
		if not ki_PL_chiuso then
			ki_consenti_lavoraz_non_associati_wmf = not ki_consenti_lavoraz_non_associati_wmf  // setta True/False il flag
		end if
		
	case kkg_flag_richiesta.libero8  	//Crea Groupage prodotti da Palmare
		open_elenco_lettore_grp()

	case kkg_flag_richiesta.refresh		//Aggiorna Liste
		//u_set_kidw_selezionata_default( )
		u_refresh_dw()

	case kkg_flag_richiesta.libero9		//cambia date di estrazione
		cambia_periodo_elenco()

	case kkg_flag_richiesta.libero10		//finestra delle proprietà
		u_mostra_proprieta(false)


	case else // standard
		kigrf_x_trova = kidw_selezionata
		super::smista_funz(k_par_in)
		
end choose



end subroutine

protected subroutine attiva_menu ();//
if ki_st_open_w.flag_primo_giro <> "S" then
	
	m_main.m_trova.enabled = true
	m_main.m_trova.m_fin_ordina.enabled = true
	m_main.m_trova.m_fin_cerca.enabled = true
	m_main.m_trova.m_fin_cercaancora.enabled = true
	m_main.m_trova.m_fin_filtra.enabled = true
	m_main.m_finestra.m_aggiornalista.enabled = true
	m_main.m_finestra.m_riordinalista.enabled = true

//
//--- Attiva/Dis. Voci di menu personalizzate
//
	if not m_main.m_strumenti.m_fin_gest_libero1.visible then
		m_main.m_strumenti.m_fin_gest_libero1.text = "Dettaglio &Barcode"
		m_main.m_strumenti.m_fin_gest_libero1.microhelp = 	"Visualizza dettaglio del Barcode"
		m_main.m_strumenti.m_fin_gest_libero1.enabled = true
		m_main.m_strumenti.m_fin_gest_libero1.toolbaritemtext = "Barcode,"+ m_main.m_strumenti.m_fin_gest_libero1.text
		m_main.m_strumenti.m_fin_gest_libero1.toolbaritemvisible = true
		m_main.m_strumenti.m_fin_gest_libero1.toolbaritemname = "barcode.bmp"
	//	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex = 2
		m_main.m_strumenti.m_fin_gest_libero1.visible = true
	end if

	//if m_main.m_strumenti.m_fin_gest_libero2.enabled <> cb_file.enabled then
		m_main.m_strumenti.m_fin_gest_libero2.text = "&Cicli di Lavorazione"
		if kiuf_barcode_mod_giri.ki_modifica_cicli_enabled = kiuf_barcode_mod_giri.ki_modifica_cicli_enabled_modif then
			m_main.m_strumenti.m_fin_gest_libero2.microhelp = "Modifica i cicli di trattamento del Barcode/intero Lotto di Entrata   "
		else
			m_main.m_strumenti.m_fin_gest_libero2.microhelp = "Visualizza cicli di trattamento del Barcode/intero Lotto di Entrata   "
		end if
		m_main.m_strumenti.m_fin_gest_libero2.enabled = true //cb_file.enabled
		m_main.m_strumenti.m_fin_gest_libero2.toolbaritemtext = "Giri,"+ m_main.m_strumenti.m_fin_gest_libero2.text
		m_main.m_strumenti.m_fin_gest_libero2.toolbaritemvisible = true
		m_main.m_strumenti.m_fin_gest_libero2.toolbaritemname = "cicli16.png"
	//	ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex = 2
		m_main.m_strumenti.m_fin_gest_libero2.visible = true
//	end if

//	if dw_meca.icon <> dw_meca.ki_icona_selezionata then
//		ki_menu.m_strumenti.m_fin_gest_libero3.enabled = false
//	else
		m_main.m_strumenti.m_fin_gest_libero3.enabled = ki_autorizza_marca_stato_in_attenzione
//	end if
	if not m_main.m_strumenti.m_fin_gest_libero3.visible then
		m_main.m_strumenti.m_fin_gest_libero3.text = "Marca/Ripristina Lotto 'in Attenzione '   F12"
		m_main.m_strumenti.m_fin_gest_libero3.microhelp =  "Marca/Ripristina Lotto 'in Attenzione'      F12"
		m_main.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = false
		m_main.m_strumenti.m_fin_gest_libero3.toolbaritemText = "Marca,"+m_main.m_strumenti.m_fin_gest_libero3.text
		m_main.m_strumenti.m_fin_gest_libero3.toolbaritemName = "inattenzione16.png" //"Exclamation!"
	//	ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
		m_main.m_strumenti.m_fin_gest_libero3.visible = true
	end if	
	
	if cb_aggiungi.enabled then
	//if m_main.m_strumenti.m_fin_gest_libero4.enabled <> cb_aggiungi.enabled then
		m_main.m_strumenti.m_fin_gest_libero4.text = "Aggiungi Barcode (&+)"
		m_main.m_strumenti.m_fin_gest_libero4.microhelp = "Aggiunge Barcode da trattare a fine elenco"
		m_main.m_strumenti.m_fin_gest_libero4.enabled = cb_aggiungi.enabled
		m_main.m_strumenti.m_fin_gest_libero4.toolbaritemtext = "Metti,"+ m_main.m_strumenti.m_fin_gest_libero4.text
		m_main.m_strumenti.m_fin_gest_libero4.toolbaritemvisible = false
		m_main.m_strumenti.m_fin_gest_libero4.toolbaritemName = "barcode16.png"
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex = 2
		m_main.m_strumenti.m_fin_gest_libero4.visible = true
	else
		m_main.m_strumenti.m_fin_gest_libero4.visible = false
	end if
	
	if cb_aggiungi.enabled then
	//if m_main.m_strumenti.m_fin_gest_libero5.enabled <> cb_aggiungi.enabled then
		m_main.m_strumenti.m_fin_gest_libero5.text = "Controllo Programmazione"
		m_main.m_strumenti.m_fin_gest_libero5.microhelp = "Controlla l'intera Programmazione"
		m_main.m_strumenti.m_fin_gest_libero5.enabled = cb_aggiungi.enabled
		m_main.m_strumenti.m_fin_gest_libero5.toolbaritemtext = "Controllo,"+ m_main.m_strumenti.m_fin_gest_libero5.text
		m_main.m_strumenti.m_fin_gest_libero5.toolbaritemvisible = false
		m_main.m_strumenti.m_fin_gest_libero5.toolbaritemName = "check16.png"
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex = 2
		m_main.m_strumenti.m_fin_gest_libero5.visible = true
	else
		m_main.m_strumenti.m_fin_gest_libero5.visible = false
	end if
	
//	if m_main.m_strumenti.m_fin_gest_libero5.enabled <> cb_togli.enabled then
//		m_main.m_strumenti.m_fin_gest_libero5.text = "Togli Barcode (&-)"
//		m_main.m_strumenti.m_fin_gest_libero5.microhelp = "Toglie Barcode da trattare dall'elenco"
//		m_main.m_strumenti.m_fin_gest_libero5.enabled = cb_togli.enabled
//		m_main.m_strumenti.m_fin_gest_libero5.toolbaritemtext = "Toglie,"+ m_main.m_strumenti.m_fin_gest_libero5.text
//		m_main.m_strumenti.m_fin_gest_libero5.toolbaritemvisible = false
//		m_main.m_strumenti.m_fin_gest_libero5.toolbaritemName = "barcodeno16.png"
////		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritembarindex = 2
//		m_main.m_strumenti.m_fin_gest_libero5.visible = true
//	end if

	if not ki_PL_chiuso then 
		m_main.m_strumenti.m_fin_gest_libero6.text = "Chiudi P.L."
		m_main.m_strumenti.m_fin_gest_libero6.microhelp = 	"Salva e Chiude il Piano di Lavorazione, NON SARA' PIU' possibile effettuare alcuna modifica     "
		m_main.m_strumenti.m_fin_gest_libero6.toolbaritemtext = "Chiudi,"+ m_main.m_strumenti.m_fin_gest_libero6.text
		//ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemname = kGuo_path.get_risorse() + "\lucch32.png"
		m_main.m_strumenti.m_fin_gest_libero6.toolbaritemname = "lucch16.png"
	else
		m_main.m_strumenti.m_fin_gest_libero6.text = "Riapre P.L."
		m_main.m_strumenti.m_fin_gest_libero6.microhelp = 	"Riapre il Piano di Lavorazione appena inviato, SARA' di nuovo possibile effettuare le modifiche    "
		m_main.m_strumenti.m_fin_gest_libero6.toolbaritemtext = "Apre,"+ m_main.m_strumenti.m_fin_gest_libero6.text
		m_main.m_strumenti.m_fin_gest_libero6.toolbaritemname = "lucchOpen16.png"
	end if
	if m_main.m_strumenti.m_fin_gest_libero6.enabled <> cb_chiudi.enabled or not m_main.m_strumenti.m_fin_gest_libero6.toolbaritemvisible then
		m_main.m_strumenti.m_fin_gest_libero6.enabled = cb_chiudi.enabled
//		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemname = kGuo_path.get_risorse() + "\lucchetto1.bmp"
		m_main.m_strumenti.m_fin_gest_libero6.toolbaritemvisible = true
		m_main.m_strumenti.m_fin_gest_libero6.visible = true
	//	ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritembarindex = 2
	end if

		
//--- By-Passsa blocco Lotto ASSOCIATO (il menu 7 e' a tendina, quindi lo tratto diversamente)
	if m_main.m_strumenti.m_fin_gest_libero7.enabled = ki_PL_chiuso or m_main.m_strumenti.m_fin_gest_libero7.libero1.checked <> ki_consenti_lavoraz_non_associati_wmf then
		if  ki_consenti_lavoraz_non_associati_wmf then
			m_main.m_strumenti.m_fin_gest_libero7.text = "NON Consentire il Trattamento di Lotti non Associati in WMF"
		else
			m_main.m_strumenti.m_fin_gest_libero7.text = "Consentire il Trattamento di Lotti NON Associati in WMF"
		end if
		m_main.m_strumenti.m_fin_gest_libero7.microhelp = m_main.m_strumenti.m_fin_gest_libero7.text
		if ki_e1_enabled then  // Se è attivo E1 si possono mettere in trattamento solo lotti con lo stato a 20 (ASSOCIATI)
			ki_consenti_lavoraz_non_associati_wmf = false
		else
			m_main.m_strumenti.m_fin_gest_libero7.enabled = not ki_PL_chiuso
		end if
		m_main.m_strumenti.m_fin_gest_libero7.toolbaritemtext =  "WMF,"+ m_main.m_strumenti.m_fin_gest_libero7.text
		m_main.m_strumenti.m_fin_gest_libero7.toolbaritemvisible = false
//		ki_menu.m_strumenti.m_fin_gest_libero7.toolbaritembarindex=2
		m_main.m_strumenti.m_fin_gest_libero7.checked = ki_consenti_lavoraz_non_associati_wmf
		m_main.m_strumenti.m_fin_gest_libero7.libero1.text = m_main.m_strumenti.m_fin_gest_libero7.text
		m_main.m_strumenti.m_fin_gest_libero7.libero1.microhelp = m_main.m_strumenti.m_fin_gest_libero7.microhelp 
		m_main.m_strumenti.m_fin_gest_libero7.libero1.enabled =  m_main.m_strumenti.m_fin_gest_libero7.enabled
		m_main.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemtext = m_main.m_strumenti.m_fin_gest_libero7.toolbaritemtext
		m_main.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemvisible = m_main.m_strumenti.m_fin_gest_libero7.toolbaritemvisible
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritembarindex=2
		m_main.m_strumenti.m_fin_gest_libero7.libero1.checked = ki_consenti_lavoraz_non_associati_wmf
		m_main.m_strumenti.m_fin_gest_libero7.libero1.visible = true
	end if
	
	
	if not m_main.m_strumenti.m_fin_gest_libero8.visible then
		m_main.m_strumenti.m_fin_gest_libero8.text = "Elenco Groupage da Palmare "
		m_main.m_strumenti.m_fin_gest_libero8.microhelp =  "Importa Groupage creati da Palmare"
		m_main.m_strumenti.m_fin_gest_libero8.enabled = true
		m_main.m_strumenti.m_fin_gest_libero8.toolbaritemVisible = true
		m_main.m_strumenti.m_fin_gest_libero8.toolbaritemText = "Grp,"+m_main.m_strumenti.m_fin_gest_libero8.text
		m_main.m_strumenti.m_fin_gest_libero8.toolbaritemName = "Select All_2!"
	//	ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritembarindex=2
		m_main.m_strumenti.m_fin_gest_libero8.visible = true
	end if	

	if not m_main.m_strumenti.m_fin_gest_libero9.visible then
		m_main.m_strumenti.m_fin_gest_libero9.text = "Cambia data inizio periodo estrazione elenco Lotti da Trattare"
		m_main.m_strumenti.m_fin_gest_libero9.microhelp =  "Cambia data estrazione elenco Lotti"
		m_main.m_strumenti.m_fin_gest_libero9.enabled = true
		m_main.m_strumenti.m_fin_gest_libero9.toolbaritemVisible = false
		m_main.m_strumenti.m_fin_gest_libero9.toolbaritemText = "Periodo,"+m_main.m_strumenti.m_fin_gest_libero9.text
		m_main.m_strumenti.m_fin_gest_libero9.toolbaritemName = "Custom015!"
//		ki_menu.m_strumenti.m_fin_gest_libero9.toolbaritembarindex=2
		m_main.m_strumenti.m_fin_gest_libero9.visible = true
	end if

	if not m_main.m_strumenti.m_fin_gest_libero10.visible then
		m_main.m_strumenti.m_fin_gest_libero10.text = "Proprità Piano di Lavorazione"
		m_main.m_strumenti.m_fin_gest_libero10.microhelp =  "Vedi Proprietà"
		m_main.m_strumenti.m_fin_gest_libero10.enabled = true
		m_main.m_strumenti.m_fin_gest_libero10.toolbaritemVisible = true
		m_main.m_strumenti.m_fin_gest_libero10.toolbaritemText = "Proprietà,"+m_main.m_strumenti.m_fin_gest_libero10.text
		m_main.m_strumenti.m_fin_gest_libero10.toolbaritemName = "property.png"
//		ki_menu.m_strumenti.m_fin_gest_libero10.toolbaritembarindex=2
		m_main.m_strumenti.m_fin_gest_libero10.visible = true
	end if

	super::attiva_menu()
	
end if

end subroutine

private function boolean if_pl_barcode_chiuso ();//--- 
//--- Controlla se PL_BARCODE e' gia' stato chiuso
//---
boolean k_return=false
st_tab_pl_barcode kst_tab_pl_barcode


//--- P.L. chiuso?
if dw_dett_0.getrow() > 0 then
	kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(1, "codice")			

	try
		if kst_tab_pl_barcode.codice > 0 then
			
			if kiuf1_pl_barcode.if_esiste(kst_tab_pl_barcode) then
				if kiuf1_pl_barcode.if_pl_barcode_aperto(kst_tab_pl_barcode) then
					k_return=false
				else
					k_return=true
				end if
				
			end if
		end if

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try
	
end if


return k_return
end function

private subroutine set_dw_dett_0 (st_tab_pl_barcode kst_tab_pl_barcode);//---
//---
int k_riga = 0

dw_dett_0.reset()
dw_dett_0.insertrow(0)
k_riga = 1 //dw_dett_0.rowcount()

//if k_riga > 0 then
	
	setnull(kst_tab_pl_barcode.data_chiuso)
	setnull(kst_tab_pl_barcode.data_sosp)
	
	dw_dett_0.setitem(k_riga, "codice", kst_tab_pl_barcode.codice)
	dw_dett_0.setitem(k_riga, "data", kst_tab_pl_barcode.data) 
	dw_dett_0.setitem(k_riga, "priorita", kst_tab_pl_barcode.priorita)
	dw_dett_0.setitem(k_riga, "stato", kst_tab_pl_barcode.stato)
	dw_dett_0.setitem(k_riga, "data_chiuso", kst_tab_pl_barcode.data_chiuso)
	dw_dett_0.setitem(k_riga, "data_sosp", kst_tab_pl_barcode.data_sosp)
	dw_dett_0.setitem(k_riga, "note_1", kst_tab_pl_barcode.note_1)
	dw_dett_0.setitem(k_riga, "note_2", kst_tab_pl_barcode.note_2)
	dw_dett_0.setitem(k_riga, "path_file_pilota", kst_tab_pl_barcode.path_file_pilota)

	dw_dett_0.SetItemStatus(k_riga, 0, Primary!, NotModified!)


//end if



end subroutine

private subroutine open_elenco_pilota_coda () throws uo_exception;//
int k_rc
long k_riga, k_riga_max_queue, k_riga_max, k_riga_queue
date k_data_int
string k_rcx
st_tab_barcode kst_tab_barcode[]
//st_tab_meca kst_tab_meca
st_esito kst_esito
kds_barcode_x_pilota_queue kds1_barcode_x_pilota_queue
//kuf_armo kuf1_armo
//kuf_barcode kuf1_barcode

window k_window
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window 
datawindowchild kdwc_barcode
uo_exception kuo_exception
pointer kpointer_old


//--- popolo il datasore (dw non visuale) per appoggio elenco
if not isvalid(kdsi_elenco_output) then 
	kdsi_elenco_output = create datastore
end if

try
	
	kpointer_old = setpointer(hourglass!)
	
//	kguo_sqlca_db_pilota.db_connetti()

	kdsi_elenco_output.dataobject = "d_pilota_queue_table_h" 
//	k_rc = kdsi_elenco_output.settransobject ( kguo_sqlca_db_pilota )
	k_rc = kdsi_elenco_output.settrans ( kguo_sqlca_db_pilota )  // conn/disconn in automatico
	k_rc = kdsi_elenco_output.retrieve()

	kst_open_w.key1 = "Elenco Barcode in coda di Lavorazione nel Pilota " 
	
	if kdsi_elenco_output.rowcount() > 0 then
	
//--- piglia la data di consegna	
//		kuf1_armo = create kuf_armo
//		kuf1_barcode = create kuf_barcode
		k_riga_max_queue = kdsi_elenco_output.rowcount() 
		if k_riga_max_queue > 0 then
			for k_riga = 1 to k_riga_max_queue 
				kst_tab_barcode[k_riga].barcode = kdsi_elenco_output.getitemstring( k_riga, "barcode")
	//			kst_esito = kuf1_barcode.get_padre_id_meca(kst_tab_barcode)
	//			if kst_esito.esito = kkg_esito.ok then
	//				kst_tab_meca.id = kst_tab_barcode.id_meca
	//				kst_esito = kuf1_armo.get_consegna_data(kst_tab_meca)
	//				if kst_esito.esito = kkg_esito.ok then
	//					kdsi_elenco_output.setitem(k_riga, "consegna_data", string(kst_tab_meca.consegna_data, "dd/mm/yyyy" ))
	//				end if
	//			end if
			next
			kds1_barcode_x_pilota_queue = create kds_barcode_x_pilota_queue
			k_riga_max = kds1_barcode_x_pilota_queue.u_retrieve(kst_tab_barcode[])
			for k_riga = 1 to k_riga_max 
//				k_rcx = kds1_barcode_x_pilota_queue.describe("#1.name")
//				k_rcx = kds1_barcode_x_pilota_queue.describe("#2.name")
//				k_rcx = kds1_barcode_x_pilota_queue.describe("#3.name")
//				k_rcx = kds1_barcode_x_pilota_queue.describe("#4.name")
//				k_rcx = kds1_barcode_x_pilota_queue.describe("#5.name")
//				k_rcx = kds1_barcode_x_pilota_queue.describe("#6.name")
//				k_rcx = kds1_barcode_x_pilota_queue.describe("#7.name")
//				k_rcx = kds1_barcode_x_pilota_queue.describe("#8.name")
				k_riga_queue = kdsi_elenco_output.find("barcode = '" + kds1_barcode_x_pilota_queue.getitemstring(k_riga, "barcode") + "'" , 1, k_riga_max_queue)
				if kds1_barcode_x_pilota_queue.getitemdate(k_riga, "consegna_data") > kkg.data_zero then
					kdsi_elenco_output.setitem(k_riga_queue, "consegna_data", string(kds1_barcode_x_pilota_queue.getitemdate(k_riga, "consegna_data"), "dd mmm" ))
				end if
				kdsi_elenco_output.setitem(k_riga_queue, "id_meca", kds1_barcode_x_pilota_queue.getitemnumber(k_riga, "id_meca"))
				kdsi_elenco_output.setitem(k_riga_queue, "num_int", kds1_barcode_x_pilota_queue.getitemnumber(k_riga, "num_int"))
				kdsi_elenco_output.setitem(k_riga_queue, "e1ancodrs", kds1_barcode_x_pilota_queue.getitemstring(k_riga, "e1ancodrs"))
			next
		end if
//		destroy kuf1_armo
//		destroy kuf1_barcode
		
		k_window = kGuf_data_base.prendi_win_attiva()
		
	//--- chiamare la window di elenco
	
	//=== Parametri : 
	//=== struttura st_open_w
		kst_open_w.id_programma = kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = k_window.title    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window
	
	else
	
		kuo_exception = create uo_exception
		kuo_exception.set_tipo(kuo_exception.KK_st_uo_exception_tipo_not_fnd)
		kuo_exception.setmessage("Nessun valore disponibile per l'elenco richiesto. ")
		throw kuo_exception
		
		
	end if

catch (uo_exception k1uo_exception)
	throw k1uo_exception

finally 
	setpointer(kpointer_old)
end try
//





end subroutine

private subroutine open_notepad_documento () throws uo_exception;//
string k_file
kuf_ole kuf1_ole
st_esito kst_esito
uo_exception kuo_exception


	k_file = dw_dett_0.getitemstring(dw_dett_0.getrow(), "path_file_pilota") 
	
	if Len(trim(k_file)) > 0 then 
	
		kuf1_ole = create kuf_ole
		kst_esito = kuf1_ole.open_txt( k_file )
		if kst_esito.esito <> "0" then
			kst_esito = kuf1_ole.open_doc( k_file )
		end if
		destroy kuf1_ole
		if kst_esito.esito <> "0" then
			kuo_exception = create uo_exception
			kuo_exception.set_tipo(kuo_exception.KK_st_uo_exception_tipo_generico)
			kuo_exception.setmessage("Impossibile aprire il Documento" + trim(k_file)+ "~n~r" +trim(kst_esito.sqlerrtext) )
			throw kuo_exception
		end if
	else
	
		kuo_exception = create uo_exception
		kuo_exception.set_tipo(kuo_exception.KK_st_uo_exception_tipo_not_fnd)
		kuo_exception.setmessage("Nessun Documento Associato a questo P.L.!" )
		throw kuo_exception
		
	end if
	





end subroutine

private subroutine togli_figli_al_dw_groupage (st_tab_barcode kst_tab_barcode);//
//--- Verifica del barcode se ha figli  
//--- se il barcode ha figli li TOLGO dalla dw
//--- Input kst_tab_barcode.barcode
//
long k_riga_grp_copia, k_riga_grp
datastore kds_1
kuf_barcode kuf1_barcode
datawindow kdw_ds


	ki_lista_0_modifcato = true
	
	if dw_groupage.rowcount( ) > 0 then
		k_riga_grp=1
		do while k_riga_grp <= dw_groupage.rowcount() 
		
			if dw_groupage.object.barcode_lav[k_riga_grp] = kst_tab_barcode.barcode then
				dw_groupage.deleterow(k_riga_grp)
			else
				k_riga_grp++
			end if
		loop
	end if


end subroutine

public subroutine togli_barcode_padre (ref datawindow kdw_1);//
//=== Toglie i BARCODE selezionati della lista dei Pianificati
//===  
//
long k_riga, k_riga_drag, k_riga_prima, k_riga_meca, k_riga_find
int k_ctr, k_rc, k_nrows_to_restore
string k_rc_x
long k_id_meca
boolean k_rileggi_lista_da_db = false
int k_scelta_msg
st_tab_barcode kst_tab_barcode, kst_tab_barcode_figlio
st_esito kst_esito
kuf_sl_pt kuf1_sl_pt
uo_ds_std_1 kds_1
	

try
	kguo_exception.inizializza(this.classname())
	
	kuf1_sl_pt = create kuf_sl_pt

	ki_lista_0_modifcato = true
	
	k_rc = dw_barcode.reset() 
	
//--- conteggio righe da ripristinare anche i giri
	k_riga_drag = kdw_1.getselectedrow(0)
	k_riga = 1
	do while k_riga_drag > 0
		kst_tab_barcode.barcode = trim(kdw_1.getitemstring(k_riga_drag, "barcode_barcode"))
		kst_esito = kiuf_barcode.tb_prendi_campo( kst_tab_barcode, "fila_1_e_fila_2" ) 
		if kst_esito.esito = kkg_esito.ok then
			if kdw_1.getitemnumber(k_riga_drag, "barcode_fila_1") <> kst_tab_barcode.fila_1 &
					or kdw_1.getitemnumber(k_riga_drag, "barcode_fila_2") <> kst_tab_barcode.fila_2 &
					or kdw_1.getitemnumber(k_riga_drag, "barcode_fila_1p") <> kst_tab_barcode.fila_1p &
					or kdw_1.getitemnumber(k_riga_drag, "barcode_fila_2p") <> kst_tab_barcode.fila_2p &
					or kdw_1.getitemstring(k_riga_drag, "barcode_tipo_cicli") <> kst_tab_barcode.tipo_cicli &
				then
				k_nrows_to_restore ++
			end if
		else
			kst_esito.sqlerrtext = "Operazione di lettura dati fallita, ~n~r" &
							  + "Barcode: " + trim(kst_tab_barcode.barcode) + "~n~r" &
							  + "Errore: " + trim(kst_esito.sqlerrtext)  + "~n~r" + kst_esito.sqlerrtext
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		k_riga_drag = kdw_1.getselectedrow( k_riga_drag )
	loop
	if k_nrows_to_restore > 1 then
		k_scelta_msg = messagebox("Ripristino Trattamento come da Origine", &
				  "Ci sono " + string(k_nrows_to_restore) +  " barcode da ripristinare come da Piano di Lavorazione di origine." +"~n~r" &
				  + "Procedere senza conferma su ogni barcode?", &
				  Question!, yesnocancel!, 1)  
		if k_scelta_msg = 3 then
			kguo_exception.inizializza(this.classname())
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_interr_da_utente)
			kguo_exception.setmessage("Ripristino Trattamento come da Origine", "Operazione Interrotta dall'utente")
			throw kguo_exception
		end if
	end if
	
	k_riga_drag = kdw_1.getselectedrow(0)
	k_riga_prima = k_riga_drag
	
	dw_barcode.setredraw(false)
	dw_meca.setredraw(false)
	
	k_riga = 1
	do while k_riga_drag > 0

		k_id_meca = kdw_1.getitemnumber(k_riga_drag, "id_meca")

		k_riga = dw_barcode.insertrow(0)

		kst_tab_barcode.barcode = trim(kdw_1.getitemstring(k_riga_drag, "barcode_barcode"))
		kst_esito = kiuf_barcode.tb_prendi_campo( kst_tab_barcode, "fila_1_e_fila_2" ) 
		if kst_esito.esito <> "0" then
			kst_esito.sqlerrtext = "Operazione di lettura dati fallita, ~n~r" &
							  + "Barcode: " + trim(kst_tab_barcode.barcode) + "~n~r" &
							  + "Errore: " + trim(kst_esito.sqlerrtext)  + "~n~r" + kst_esito.sqlerrtext
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
			
		if k_nrows_to_restore > 1 then
			if k_scelta_msg = 2 then   // Conferma ad ogni barcode
				if kdw_1.getitemnumber(k_riga_drag, "barcode_fila_1") <> kst_tab_barcode.fila_1 &
						or kdw_1.getitemnumber(k_riga_drag, "barcode_fila_2") <> kst_tab_barcode.fila_2 &
						or kdw_1.getitemnumber(k_riga_drag, "barcode_fila_1p") <> kst_tab_barcode.fila_1p &
						or kdw_1.getitemnumber(k_riga_drag, "barcode_fila_2p") <> kst_tab_barcode.fila_2p &
						or kdw_1.getitemstring(k_riga_drag, "barcode_tipo_cicli") <> kst_tab_barcode.tipo_cicli &
					then
					
					k_rc = messagebox("Ripristino Giri e Tipo Trattamento come da Origine ", &
							  "Barcode: " + trim(kst_tab_barcode.barcode)+"~n~r" &
							  + "ripristino dei seguenti dati del Barcode  ~n~r"  &
							  + "imposto tipo trattamento a: " + kuf1_sl_pt.KI_SL_PT_TIPO_CICLI_DESCR[integer(kst_tab_barcode.tipo_cicli)] +" ~n~r" &
							  + "imposto n.giri in fila 1 a: " + string(kst_tab_barcode.fila_1) +" ~n~r" &
							  + "imposto n.giri in fila 1 permutata a: " + string(kst_tab_barcode.fila_1p) +"~n~r" &
							  + "imposto n.giri in fila 2 a: " + string(kst_tab_barcode.fila_2) +"~n~r" &
							  + "imposto n.giri in fila 2 permutata a: " + string(kst_tab_barcode.fila_2p) +"~n~r" &
							  + "(sono i valori letti dal 'SL-PT' di origine) "+"~n~r~n~r" &
							  + "Inoltre il Barcode sara' TOLTO definitivamente da questa Pianificazione. ~n~r", &
							  Information!) // yesno!, 1) 
				end if
			end if
				
			if isnull(kst_tab_barcode.tipo_cicli) then
				kst_tab_barcode.tipo_cicli = " "
			end if
			if isnull(kst_tab_barcode.fila_1) then
				kst_tab_barcode.fila_1 = 0
			end if
			if isnull(kst_tab_barcode.fila_1p) then
				kst_tab_barcode.fila_1p = 0
			end if
			if isnull(kst_tab_barcode.fila_2) then
				kst_tab_barcode.fila_2 = 0
			end if
			if isnull(kst_tab_barcode.fila_2p) then
				kst_tab_barcode.fila_2p = 0
			end if
			kst_esito = kiuf_barcode.tb_update_campo( kst_tab_barcode, "ripri_fila_orig" ) 
			if kst_esito.esito <> "0" then
				kst_esito.sqlerrtext = "Operazione di aggiornamento fallita, ~n~r" &
					  + "Barcode: " + trim(kst_tab_barcode.barcode)+"~n~r" &
					  + "Errore: " + string(kst_esito.sqlcode) + "-" + trim(kst_esito.sqlerrtext)
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			
			kdw_1.setitem(k_riga_drag, "barcode_tipo_cicli", kst_tab_barcode.tipo_cicli)			
			kdw_1.setitem(k_riga_drag, "barcode_fila_1", kst_tab_barcode.fila_1)			
			kdw_1.setitem(k_riga_drag, "barcode_fila_2", kst_tab_barcode.fila_2)			
			kdw_1.setitem(k_riga_drag, "barcode_fila_1p", kst_tab_barcode.fila_1p)			
			kdw_1.setitem(k_riga_drag, "barcode_fila_2p", kst_tab_barcode.fila_2p)	
			
			k_rileggi_lista_da_db = true //--- x forzare la rilettura della lista

//--- cerca eventuale figlio e lo toglie ---------------------------------------------------------------------------------------------
			kds_1 = kiuf_barcode.get_figli_barcode(kst_tab_barcode)
			for k_ctr = 1 to  kds_1.rowcount()
				kst_tab_barcode_figlio = kst_tab_barcode
				kst_tab_barcode_figlio.barcode = kds_1.object.barcode[k_ctr]
				kst_esito = kiuf_barcode.tb_update_campo( kst_tab_barcode_figlio, "ripri_fila_orig" ) 
				if kst_esito.esito <> "0" then
					kst_esito.sqlerrtext = "Operazione di aggiornamento fallita, ~n~r" &
						  + "Barcode FIGLIO: " + trim(kst_tab_barcode_figlio.barcode)+"~n~r" &
						  + "Errore: " + string(kst_esito.sqlcode) + "-" + trim(kst_esito.sqlerrtext)
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if

//--- Cerco il barcode tra i figli gia' presenti
				k_riga_find = dw_groupage.find("barcode_barcode = '" + trim(kst_tab_barcode_figlio.barcode) + "' ", 1, dw_groupage.rowcount()) 
				if k_riga_find > 0 then
					dw_groupage.setitem(k_riga_find, "barcode_tipo_cicli", kst_tab_barcode.tipo_cicli)			
					dw_groupage.setitem(k_riga_find, "barcode_fila_1", kst_tab_barcode.fila_1)			
					dw_groupage.setitem(k_riga_find, "barcode_fila_2", kst_tab_barcode.fila_2)			
					dw_groupage.setitem(k_riga_find, "barcode_fila_1p", kst_tab_barcode.fila_1p)			
					dw_groupage.setitem(k_riga_find, "barcode_fila_2p", kst_tab_barcode.fila_2p)	
				end if

//--- tolgo il codice PL_BARCODE dal figlio					
				kst_esito = kiuf_barcode.tb_update_campo( kst_tab_barcode_figlio, "ripri_pl_barcode" ) 
				if kst_esito.esito <> "0" then
					kst_esito.sqlerrtext = "Operazione di rimozione Barcode figlio fallita, ~n~r" &
						  + "Non e' grave, ma consiglio di 'salvare' questo Piano x evitare incongruenze nel prosieguo. " + trim(kst_tab_barcode.barcode)+"~n~r" &
						  + "Barcode: " + trim(kst_tab_barcode_figlio.barcode)+"~n~r" &
						  + "Errore: " + string(kst_esito.sqlcode) + "-" + trim(kst_esito.sqlerrtext)
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
						
			end for
					
//----------------------------------------------------------------------------------------------------------------------------------------
					
			kst_esito = kiuf_barcode.tb_update_campo( kst_tab_barcode, "ripri_pl_barcode" ) 
			if kst_esito.esito <> "0" then
				kst_esito.sqlerrtext = "Operazione di Rimozione del Barcode fallita, ~n~r" &
					  + "Non e' grave, ma consiglio di 'salvare' questo Piano x evitare incongruenze nel prosieguo. " + trim(kst_tab_barcode.barcode)+"~n~r" &
					  + "Barcode: " + trim(kst_tab_barcode.barcode)+"~n~r" &
					  + "Errore: " + string(kst_esito.sqlcode) + "-" + trim(kst_esito.sqlerrtext)
			end if
				
		end if

//--- copia la dw1 in barcode, il formato e' la solito dettaglio		
		copia_dw_lista_0_to_dw_barcode(k_riga, k_riga_drag)
//		copia_dettaglio_dw_1_da_dw_2(dw_barcode, kdw_1, k_riga, k_riga_drag)

		k_riga_drag = kdw_1.getselectedrow( k_riga_drag )
		
		k_riga++
		
	loop
	
	dw_barcode.scrolltorow(dw_barcode.rowcount())

//--- Tolgo le righe selezionata dalla lista Barcode Padri o Groupage
	k_riga = kdw_1.getselectedrow(0)
	do while k_riga > 0
		kst_tab_barcode.barcode = kdw_1.object.barcode_barcode[k_riga]
		togli_figli_al_dw_groupage (kst_tab_barcode) //se ce ne sono toglie anche i figli		
		kdw_1.deleterow( k_riga )
		k_riga = kdw_1.getselectedrow(0)
	loop
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
	
finally	
	
	u_crash_dw_lista_0_backup() // Salva per restore se crash
	
//--- sistema il codice e i progressivi nella lista
	imposta_codice_progr( kdw_1 )

	ki_riga_pos_dw_meca = 0  //cattura la riga selezionata
	
//--- rilegge la lista riferimenti non lavorati
//	kids_meca_orig.reset()
	leggi_liste()
	//u_rileggi_dw_meca()

//--- posizionamento sul riferimento della riga trattata	
	if dw_meca.rowcount() > 0 and k_id_meca > 0 then	
		k_riga_meca = dw_meca.find("id_meca = " + string(k_id_meca) + " ", 1, dw_meca.rowcount())
//--- Seleziono riferimento 
		if k_riga_meca > 0 then
			dw_meca.selectrow( 0, false)
			dw_meca.selectrow(k_riga_meca, true)
			dw_meca.setrow(k_riga_meca)
			dw_meca.scrolltorow(k_riga_meca)
		end if
	end if

	dw_barcode.setredraw(true)
	dw_meca.setredraw(true)
	
//--- posizionamento sulla riga precedente al barcode tolto
	if kdw_1.rowcount() > 0 then
	
		if k_riga_prima > 1 then
			k_riga_prima = k_riga_prima - 1
		end if
		if k_riga_prima > kdw_1.rowcount() then
			k_riga_prima = kdw_1.rowcount()
		end if
		if k_riga_prima > 0 then
			kdw_1.setrow(k_riga_prima)
			kdw_1.selectrow(k_riga_prima, true)
			kdw_1.scrolltorow(k_riga_prima)
		end if
		
		kdw_1.setcolumn(1)
		kdw_1.setfocus()
		
	end if	

	//--- Riempe il titolo della dw di dettaglio
	if dw_barcode.rowcount() > 0 then
		dw_barcode.title = "Dettaglio Riferimento: " + string(dw_barcode.getitemnumber(1, "barcode_num_int"))
	else
		dw_barcode.title = "Dettaglio Riferimento " 
	end if
	
	//attiva_tasti()
	
	//dw_meca.setfocus( )
	
	if isvalid(kuf1_sl_pt) then destroy kuf1_sl_pt
	if isvalid(kds_1) then destroy kds_1
	
end try

end subroutine

public subroutine togli_barcode_figlio (ref datawindow kdw_1);//
//=== Toglie i BARCODE FIGLI selezionati della lista dei Pianificati
//===  
//
long k_riga, k_riga_drag, k_riga_prima, k_riga_meca
int k_ctr, k_rc
string k_rc_x
long k_num_int
date k_data_int
boolean k_rileggi_lista_da_db = false
st_tab_barcode kst_tab_barcode, kst_tab_barcode_lav
st_esito kst_esito
kuf_sl_pt kuf1_sl_pt	


try
	kguo_exception.inizializza(this.classname())
	kuf1_sl_pt = create kuf_sl_pt

	ki_lista_0_modifcato = true
	
	k_rc = dw_barcode.reset() 
	
	k_riga_drag = kdw_1.getselectedrow(0)
	k_riga_prima = k_riga_drag

	dw_barcode.setredraw(false)
	dw_meca.setredraw(false)
	
	k_riga = 1
	do while k_riga_drag > 0

		k_riga = dw_barcode.insertrow(0)

		kst_tab_barcode.barcode = trim(kdw_1.getitemstring(k_riga_drag, "barcode_barcode"))
		kst_tab_barcode.barcode_lav = trim(kdw_1.getitemstring(k_riga_drag, "barcode_lav"))
		if isnull(kst_tab_barcode.barcode_lav) then kst_tab_barcode.barcode_lav = " "
		
		kst_esito = kiuf_barcode.tb_prendi_campo( kst_tab_barcode, "fila_1_e_fila_2" ) 
		if kst_esito.esito <> "0" then
			messagebox("Rimuove barcode figlio", "Operazione di lettura dati fallita, ~n~r" &
							  + "Barcode: " + trim(kst_tab_barcode.barcode)+"~n~r" &
							  + "Errore: " + trim(kst_esito.sqlerrtext))
			exit
		end if
		if kdw_1.getitemnumber(k_riga_drag, "barcode_fila_1") <> kst_tab_barcode.fila_1 &
				or kdw_1.getitemnumber(k_riga_drag, "barcode_fila_2") <> kst_tab_barcode.fila_2 &
			   or kdw_1.getitemnumber(k_riga_drag, "barcode_fila_1p") <> kst_tab_barcode.fila_1p &
				or kdw_1.getitemnumber(k_riga_drag, "barcode_fila_2p") <> kst_tab_barcode.fila_2p &
				or kdw_1.getitemstring(k_riga_drag, "barcode_tipo_cicli") <> kst_tab_barcode.tipo_cicli &
				then
			k_rc = messagebox("Ripristina Giri e Tipo Trattamento come da Origine" &
						  , "Ripristino dati del barcode '" + trim(kst_tab_barcode.barcode)+ "' a:~n~r" &
						  + "Tipo trattamento: " + kuf1_sl_pt.KI_SL_PT_TIPO_CICLI_DESCR[integer(kst_tab_barcode.tipo_cicli)] +" ~n~r" &
						  + "n.giri in fila 1: " + string(kst_tab_barcode.fila_1) &
						  + " + " + string(kst_tab_barcode.fila_1p) +"~n~r" &
						  + "n.giri in fila 2: " + string(kst_tab_barcode.fila_2) &
						  + " + " + string(kst_tab_barcode.fila_2p) +"~n~r" &
						  + "(sono i valori letti dal 'PT' di origine) "+"~n~r" &
						  + "Verrà TOLTO dalla Pianificazione" &
						  + " e RIMOSSO anche il legame con il Padre ("+trim(kst_tab_barcode.barcode_lav)+")" &
						  + "~n~rProseguire l'operazione?" &
						  , Question!, yesno!, 1) 
					
			if k_rc = 2 then
				exit
			end if
			if isnull(kst_tab_barcode.tipo_cicli) then
				kst_tab_barcode.tipo_cicli = " "
			end if
			if isnull(kst_tab_barcode.fila_1) then
				kst_tab_barcode.fila_1 = 0
			end if
			if isnull(kst_tab_barcode.fila_1p) then
				kst_tab_barcode.fila_1p = 0
			end if
			if isnull(kst_tab_barcode.fila_2) then
				kst_tab_barcode.fila_2 = 0
			end if
			if isnull(kst_tab_barcode.fila_2p) then
				kst_tab_barcode.fila_2p = 0

			end if
			kst_esito = kiuf_barcode.tb_update_campo( kst_tab_barcode, "ripri_fila_orig" ) 
			if kst_esito.esito <> "0" then
				messagebox("Ripristino Giri come da Origine", "Operazione di aggiornamento fallita, ~n~r" &
					  + "Barcode: " + trim(kst_tab_barcode.barcode)+"~n~r" &
					  + "Errore: " + string(kst_esito.sqlcode) + "-" + trim(kst_esito.sqlerrtext))
			else
				kdw_1.setitem(k_riga_drag, "barcode_tipo_cicli", kst_tab_barcode.tipo_cicli)			
				kdw_1.setitem(k_riga_drag, "barcode_fila_1", kst_tab_barcode.fila_1)			
				kdw_1.setitem(k_riga_drag, "barcode_fila_2", kst_tab_barcode.fila_2)			
				kdw_1.setitem(k_riga_drag, "barcode_fila_1p", kst_tab_barcode.fila_1p)			
				kdw_1.setitem(k_riga_drag, "barcode_fila_2p", kst_tab_barcode.fila_2p)	
				
				k_rileggi_lista_da_db = true //--- x forzare la rilettura della lista

			end if

		else
			
			k_rc = messagebox("Rimuove barcode figlio", &
						  "Il barcode: " + trim(kst_tab_barcode.barcode) &
						  + " verrà TOLTO definitivamente da questa Pianificazione" &
						  + " e sara' RIMOSSO anche il legame con il Padre ("+trim(kst_tab_barcode.barcode_lav)+")" &
						  + "~n~rProseguire l'operazione?" &
						  , Question!, yesno!, 1) 
			if k_rc = 2 then
				exit
			end if
		end if


		kst_esito = kiuf_barcode.tb_update_campo( kst_tab_barcode, "ripri_pl_barcode" ) 
		if kst_esito.esito <> "0" then
			messagebox("Rimozione del Barcode", "Operazione di aggiornamento fallita, ~n~r" &
			  + "Non e' grave, ma consiglio di 'salvare' questo Piano x evitare incongruenze nel prosieguo. " + trim(kst_tab_barcode.barcode)+"~n~r" &
			  + "Barcode: " + trim(kst_tab_barcode.barcode)+"~n~r" &
			  + "Errore: " + string(kst_esito.sqlcode) + "-" + trim(kst_esito.sqlerrtext))
		end if

		kst_esito = kiuf_barcode.tb_togli_da_groupage( kst_tab_barcode ) 
		if kst_esito.esito <> "0" then
			messagebox("Rimozione del Padre dal Barcode", "Operazione di aggiornamento fallita, ~n~r" &
			  + "ATTENZIONE: entrare nel Barcode ed eliminare il legame con il 'Padre'  " + trim(kst_tab_barcode.barcode_lav)+" manualmente!! ~n~r" &
			  + "Barcode: " + trim(kst_tab_barcode.barcode)+"~n~r" &
			  + "Errore: " + string(kst_esito.sqlcode) + "-" + trim(kst_esito.sqlerrtext))
		end if


//--- verifica se il Padre ha ancora figli se non e' cosi' lo resetta
		try
			kst_tab_barcode_lav.barcode = kst_tab_barcode.barcode_lav 
			if kiuf_barcode.get_conta_figli( kst_tab_barcode_lav ) = 0 then
				kst_esito = kiuf_barcode.tb_togli_da_groupage( kst_tab_barcode_lav ) 
			end if
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
		end try

//--- posizionamento sul riferimento della riga trattata	
		if dw_meca.rowcount() > 0 then	

			k_num_int = kdw_1.getitemnumber(k_riga_drag, "barcode_num_int")
			k_data_int = kdw_1.getitemdate(k_riga_drag, "barcode_data_int")
			
			k_riga_meca = dw_meca.find("meca_num_int = " + trim(string(k_num_int)) + " " &
							 + "and meca_data_int = date('" &
							 + trim(string(k_data_int)) + "') " &
							 , 1, dw_meca.rowcount())
//--- Se riferimento mancante accendo flag x rilettura da DB
			if k_riga_meca = 0 then
				k_rileggi_lista_da_db = true //--- x forzare la rilettura della lista
			end if
		else
			k_rileggi_lista_da_db = true //--- x forzare la rilettura della lista
		end if						 
		
//--- copia la dw1 in barcode, il formato e' la solito dettaglio			
		copia_dw_groupage_to_dw_barcode(k_riga, k_riga_drag)
	
		k_riga_drag = kdw_1.getselectedrow( k_riga_drag )
		
		k_riga++
		
	loop
	dw_barcode.scrolltorow(dw_barcode.rowcount())

//--- Tolgo le righe selezionate dalla lista groupage
	k_riga = kdw_1.getselectedrow(0)
	do while k_riga > 0
		kdw_1.deleterow( k_riga )
		k_riga = kdw_1.getselectedrow(0)
	loop
		
//--- sistema il codice e i progressivi nella lista
	imposta_codice_progr( kdw_1 )

	ki_riga_pos_dw_meca = 0  //cattura la riga selezionata
//--- rilegge la lista riferimenti non lavorati
	if k_rileggi_lista_da_db then
	//	kids_meca_orig.reset()
	end if
	leggi_liste()

//--- posizionamento sul riferimento della riga trattata	
	if dw_meca.rowcount() > 0 then	
		k_riga_meca = dw_meca.find("meca_num_int = " + trim(string(k_num_int)) + " " &
						 + "and meca_data_int = date('" &
						 + trim(string(k_data_int)) + "') " &
						 , 1, dw_meca.rowcount())
//--- Seleziono riferimento 
		if k_riga_meca > 0 then
			dw_meca.selectrow( 0, false)
			dw_meca.selectrow(k_riga_meca, true)
			dw_meca.setrow(k_riga_meca)
			dw_meca.scrolltorow(k_riga_meca)
		end if
	end if

//--- posizionamento sulla riga precednte al barcode tolto
	if kdw_1.rowcount() > 0 then
	
		if k_riga_prima > 1 then
			k_riga_prima = k_riga_prima - 1
		end if
		if k_riga_prima > kdw_1.rowcount() then
			k_riga_prima = kdw_1.rowcount()
		end if
		if k_riga_prima > 0 then
			kdw_1.setrow(k_riga_prima)
			kdw_1.selectrow(k_riga_prima, true)
			kdw_1.scrolltorow(k_riga_prima)
		end if
		
		kdw_1.setcolumn(1)
		kdw_1.setfocus()
		
	end if	


	//--- Riempe il titolo della dw di dettaglio
	if dw_barcode.rowcount() > 0 then
		dw_barcode.title = "Dettaglio Riferimento: " + string(dw_barcode.getitemnumber(1, "barcode_num_int"))
	else
		dw_barcode.title = "Dettaglio Riferimento " 
	end if
	
	//attiva_tasti()
	
catch (uo_exception kuo1_exception)
	kuo1_exception.scrivi_log()
	
	
finally
	dw_barcode.setredraw(true)
	dw_meca.setredraw(true)
	
	if isvalid(kuf1_sl_pt) then destroy kuf1_sl_pt
	
end try

end subroutine

private subroutine scegli_padre_da_dw_lista (long k_riga_dw_groupage);//
//=== Premuto pulsante nella DW
//
boolean k_aperto = true
int k_rc
long k_riga, k_riga_lista
st_tab_barcode kst_tab_barcode
st_tab_pl_barcode kst_tab_pl_barcode
st_esito kst_esito
//window k_window
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window


//--- Devo poter essere in inserimento o modifca x fare questa operazione...
if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento &
  					 or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then

	try
		
	//--- controllo se PL ancora aperto altrimenti NISBA
		kst_tab_pl_barcode.codice = dw_dett_0.object.codice[1]
	
		if kst_tab_pl_barcode.codice > 0 then
			k_aperto = kiuf1_pl_barcode.if_pl_barcode_aperto(kst_tab_pl_barcode) 
		else
			k_aperto = true
		end if
		
		if k_aperto then		

	//--- popolo il datasore (dw non visuale) per appoggio elenco
			if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore
		
		
			kst_tab_barcode.barcode = dw_groupage.object.barcode_barcode[k_riga_dw_groupage]
			kst_tab_barcode.fila_1 = dw_groupage.object.barcode_fila_1[k_riga_dw_groupage]
			kst_tab_barcode.fila_1p = dw_groupage.object.barcode_fila_1p[k_riga_dw_groupage]
			kst_tab_barcode.fila_2 = dw_groupage.object.barcode_fila_2[k_riga_dw_groupage]
			kst_tab_barcode.fila_2p = dw_groupage.object.barcode_fila_2p[k_riga_dw_groupage]
			k_riga=0
			kdsi_elenco_output.dataobject = "d_barcode_l_rid"  //dw_lista_0.dataobject
			for k_riga_lista = 1 to dw_lista_0.rowcount()
				
				if kst_tab_barcode.fila_1 = dw_lista_0.object.barcode_fila_1[k_riga_lista] &
						and kst_tab_barcode.fila_1p = dw_lista_0.object.barcode_fila_1p[k_riga_lista] &
						and kst_tab_barcode.fila_2 = dw_lista_0.object.barcode_fila_2[k_riga_lista] &
						and kst_tab_barcode.fila_2p = dw_lista_0.object.barcode_fila_2p[k_riga_lista] &
						then
						if dw_groupage.find("barcode_barcode = " + "'" + dw_lista_0.object.barcode_barcode[k_riga_lista] + "'", 1, dw_lista_0.rowcount()) = 0 then
							k_riga = kdsi_elenco_output.insertrow(0)
							kdsi_elenco_output.setitem( k_riga, "barcode", dw_lista_0.object.barcode_barcode[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "fila_1", dw_lista_0.object.barcode_fila_1[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "fila_1p", dw_lista_0.object.barcode_fila_1p[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "fila_2", dw_lista_0.object.barcode_fila_2[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "fila_2p", dw_lista_0.object.barcode_fila_2p[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "dose", dw_lista_0.object.dose[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "num_int", dw_lista_0.object.barcode_num_int[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "meca_area_mag", dw_lista_0.object.area_mag[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "armo_peso_kg", dw_lista_0.object.peso_kg[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "armo_larg_2", dw_lista_0.object.larg_2[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "armo_lung_2", dw_lista_0.object.lung_2[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "armo_alt_2", dw_lista_0.object.alt_2[k_riga_lista])
//							kdsi_elenco_output.setitem( k_riga, "armo_cod_sl_pt", dw_lista_0.object.cod_sl_pt[k_riga_lista])
//							kdsi_elenco_output.setitem( k_riga, "sl_pt_fila_1", dw_lista_0.object.sl_pt_fila_1[k_riga_lista])
//							kdsi_elenco_output.setitem( k_riga, "sl_pt_fila_1p", dw_lista_0.object.sl_pt_fila_1p[k_riga_lista])
//							kdsi_elenco_output.setitem( k_riga, "sl_pt_fila_2", dw_lista_0.object.sl_pt_fila_2[k_riga_lista])
//							kdsi_elenco_output.setitem( k_riga, "sl_pt_fila_2p", dw_lista_0.object.sl_pt_fila_2p[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "armo_art", dw_lista_0.object.art[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "id_armo", dw_lista_0.object.id_armo[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "id_meca", dw_lista_0.object.id_meca[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "data_int", dw_lista_0.object.barcode_data_int[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "e1ancodrs", dw_lista_0.object.e1ancodrs[k_riga_lista])
						end if
						//k_rc = dw_lista_0.rowscopy( k_riga_lista, k_riga_lista, primary!, kdsi_elenco_output, k_riga, primary!)					
				end if
			next
			
			for k_riga_lista = 1 to dw_barcode.rowcount()
				
				if kst_tab_barcode.fila_1 = dw_barcode.object.barcode_fila_1[k_riga_lista] &
						and kst_tab_barcode.fila_1p = dw_barcode.object.barcode_fila_1p[k_riga_lista] &
						and kst_tab_barcode.fila_2 = dw_barcode.object.barcode_fila_2[k_riga_lista] &
						and kst_tab_barcode.fila_2p = dw_barcode.object.barcode_fila_2p[k_riga_lista] &
						then
						if dw_groupage.find("barcode_barcode = " + "'" + dw_barcode.object.barcode_barcode[k_riga_lista] + "'", 1, dw_barcode.rowcount()) = 0 then
							k_riga = kdsi_elenco_output.insertrow(0)
							kdsi_elenco_output.setitem( k_riga, "barcode", dw_barcode.object.barcode_barcode[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "fila_1", dw_barcode.object.barcode_fila_1[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "fila_1p", dw_barcode.object.barcode_fila_1p[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "fila_2", dw_barcode.object.barcode_fila_2[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "fila_2p", dw_barcode.object.barcode_fila_2p[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "dose", dw_barcode.object.armo_dose[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "num_int", dw_barcode.object.barcode_num_int[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "meca_area_mag", dw_barcode.object.meca_area_mag[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "armo_peso_kg", dw_barcode.object.armo_peso_kg[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "armo_larg_2", dw_barcode.object.armo_larg_2[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "armo_lung_2", dw_barcode.object.armo_lung_2[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "armo_alt_2", dw_barcode.object.armo_alt_2[k_riga_lista])
//							kdsi_elenco_output.setitem( k_riga, "armo_cod_sl_pt", dw_barcode.object.armo_cod_sl_pt[k_riga_lista])
//							kdsi_elenco_output.setitem( k_riga, "sl_pt_fila_1", dw_barcode.object.sl_pt_fila_1[k_riga_lista])
//							kdsi_elenco_output.setitem( k_riga, "sl_pt_fila_1p", dw_barcode.object.sl_pt_fila_1p[k_riga_lista])
//							kdsi_elenco_output.setitem( k_riga, "sl_pt_fila_2", dw_barcode.object.sl_pt_fila_2[k_riga_lista])
//							kdsi_elenco_output.setitem( k_riga, "sl_pt_fila_2p", dw_barcode.object.sl_pt_fila_2p[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "armo_art", dw_barcode.object.armo_art[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "id_armo", dw_barcode.object.armo_id_armo[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "id_meca", dw_barcode.object.id_meca[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "data_int", dw_barcode.object.barcode_data_int[k_riga_lista])
							//k_rc = dw_barcode.rowscopy( k_riga_lista, k_riga_lista, primary!, kdsi_elenco_output, k_riga, primary!)					
							kdsi_elenco_output.setitem( k_riga, "e1ancodrs", dw_barcode.object.e1ancodrs[k_riga_lista])
					end if
				end if
			next
			kdsi_elenco_output.sort( )
			
			kst_open_w.key1 = "Scegli 'Padre' per il Barcode: " + trim(string(kst_tab_barcode.barcode,"@@@ @@@@@@@@@")) 
				
				
			if kdsi_elenco_output.rowcount() > 0 then
		
//				k_window = kGuf_data_base.prendi_win_attiva()
				
		//--- chiamare la window di elenco
		//
		//=== Parametri : 
		//=== struttura st_open_w
				kst_open_w.id_programma =kkg_id_programma_elenco
				kst_open_w.flag_primo_giro = "S"
				kst_open_w.flag_modalita = kkg_flag_modalita.elenco
				kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
				kst_open_w.flag_leggi_dw = " "
				kst_open_w.flag_cerca_in_lista = " "
				kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
				kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
				kst_open_w.key4 = kiw_this_window.title    //--- Titolo della Window di chiamata per riconoscerla
				kst_open_w.key12_any = kdsi_elenco_output
				kst_open_w.flag_where = " "
				kuf1_menu_window = create kuf_menu_window 
				kuf1_menu_window.open_w_tabelle(kst_open_w)
				destroy kuf1_menu_window
		
			else
				
				messagebox("Elenco Dati", &
							"Nessun barcode padre disponibile dagli elenchi di 'Dettaglio' e 'Pianificazione' per il trattamento  F1=" &
							      + string(kst_tab_barcode.fila_1) + "/" + string(kst_tab_barcode.fila_1p) &
								 + " e F2=" + string(kst_tab_barcode.fila_2) + "/" + string(kst_tab_barcode.fila_2p))
				
			end if
		else
			messagebox("Operazione non permessa", &
							"Piano di Lavoro " + string(kst_tab_pl_barcode.codice)+" gia' chiuso. ")
		end if
	
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
	
	finally
		
	end try
end if


end subroutine

private function integer call_window_barcode ();//
//--- Chiama finestra di dettaglio
//
integer k_return = 0
long k_riga=0
st_tab_barcode kst_tab_barcode
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window



	if kidw_selezionata.dataobject = "d_pl_barcode_dett_1" then
		if dw_lista_0.getrow() > 0 then		
			k_riga = dw_lista_0.getrow() 
		else
			if dw_lista_0.rowcount() = 1 then
				k_riga = 1
			else
				k_riga = 0
			end if
		end if
		if k_riga > 0 then		
			kst_tab_barcode.barcode = dw_lista_0.getitemstring(k_riga, "barcode_barcode")
		end if
	end if

	if kidw_selezionata.dataobject = "d_pl_barcode_dett_grp_all" then
		if dw_groupage.getrow() > 0 then		
			k_riga = dw_groupage.getrow() 
		else
			if dw_groupage.rowcount() = 1 then
				k_riga = 1
			else
				k_riga = 0
			end if
		end if
		if k_riga > 0 then		
			kst_tab_barcode.barcode = dw_groupage.getitemstring(k_riga, "barcode_barcode")
		end if
	end if
	
	if kidw_selezionata.dataobject = "d_barcode_l_no_pl" then
		if dw_barcode.getrow() > 0 then		
			k_riga = dw_barcode.getrow() 
		else
			if dw_barcode.rowcount() = 1 then
				k_riga = 1
			else
				k_riga = 0
			end if
		end if
		if k_riga > 0 then		
			kst_tab_barcode.barcode = dw_barcode.getitemstring(k_riga, "barcode_barcode")
		end if
	end if

	if k_riga > 0 then		
	

		if Len(trim(kst_tab_barcode.barcode)) > 0 &
			and not isnull(kst_tab_barcode.barcode) then

			
//--- chiamare la window di elenco
//
//=== Parametri : 
//=== struttura st_open_w
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento &
				or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
				kst_open_w.flag_modalita= kkg_flag_modalita.modifica
			else
				kst_open_w.flag_modalita= kkg_flag_modalita.visualizzazione
			end if
				
			kst_open_w.id_programma = kkg_id_programma_barcode
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key1 = trim(kst_tab_barcode.barcode)
			kst_open_w.key2 = " "
			kst_open_w.flag_where = " "
			
			kuf1_menu_window = create kuf_menu_window 
			kuf1_menu_window.open_w_tabelle(kst_open_w)
			destroy kuf1_menu_window
		
		else
			
			messagebox("Dettaglio Codice a Barre", &
						"Codice a barre selezionato non valido")
			
		end if
			
	else
			
		messagebox("Dettaglio Codice a Barre", &
						"Selezionare un codice a barre in elenco")

	
	end if
 
 
return k_return

end function

private function st_esito retrieve_figlio_nel_dw_groupage (st_tab_barcode kst_tab_barcode);//
//--- Aggiorna i dati del Figlio nel dw_groupage  
//--- 
//--- Input kst_tab_barcode.barcode il FIGLIO da rileggere 
//
long k_riga_find, k_riga_find_padre
kuf_barcode kuf1_barcode
st_esito kst_esito 


	kst_esito = kguo_exception.inizializza(this.classname())

	try
		kuf1_barcode = create kuf_barcode


//--- Cerco il barcode tra i figli gia' presenti
		k_riga_find = dw_groupage.find("barcode_barcode = '" + trim(kst_tab_barcode.barcode) + "' ", 1, dw_groupage.rowcount()) 

//--- se  barcode Trovato procedo nella lettura dei dati su DB non c'e' ancora tra i figli allora lo aggiungo
		if k_riga_find > 0  then
			
			kuf1_barcode.select_barcode( kst_tab_barcode )

			dw_groupage.setitem(k_riga_find, "barcode_lav",kst_tab_barcode.barcode_lav)
			dw_groupage.setitem(k_riga_find, "barcode_tipo_cicli",kst_tab_barcode.tipo_cicli)
			dw_groupage.setitem(k_riga_find, "barcode_fila_1",kst_tab_barcode.fila_1)
			dw_groupage.setitem(k_riga_find, "barcode_fila_2",kst_tab_barcode.fila_2)
			dw_groupage.setitem(k_riga_find, "barcode_fila_1p",kst_tab_barcode.fila_1p)
			dw_groupage.setitem(k_riga_find, "barcode_fila_2p",kst_tab_barcode.fila_2p)

//--- Cerco il barcode PADRE 
			k_riga_find_padre = dw_lista_0.find("barcode_barcode = '" + trim(kst_tab_barcode.barcode_lav) + "' ", 1, dw_lista_0.rowcount()) 
			if k_riga_find_padre > 0  then
				if dw_lista_0.getitemnumber(k_riga_find_padre, "barcode_fila_1") = kst_tab_barcode.fila_1 &
						and dw_lista_0.getitemnumber(k_riga_find_padre, "barcode_fila_2") = kst_tab_barcode.fila_2 &
						and dw_lista_0.getitemnumber(k_riga_find_padre, "barcode_fila_1p") = kst_tab_barcode.fila_1p &
						and dw_lista_0.getitemnumber(k_riga_find_padre, "barcode_fila_2p") = kst_tab_barcode.fila_2p then
					dw_groupage.setitem(k_riga_find, "k_errore", '0')
				else
					dw_groupage.setitem(k_riga_find, "k_errore", '1')
				end if
			end if
			
		else
			kst_esito.esito = kkg_esito.err_logico
			kst_esito.sqlerrtext = "Errore durante ricerca 'Figlio' " +  trim(kst_tab_barcode.barcode) + " in " + trim(this.classname())
		end if
		
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		
	finally
		destroy kuf1_barcode
		
	end try

return kst_esito


end function

private function st_esito retrieve_padre_nel_dw_lista (st_tab_barcode kst_tab_barcode);//
//--- Aggiorna i dati del Padre nel dw_lista_0  
//--- 
//--- Input kst_tab_barcode.barcode il FIGLIO da rileggere 
//
long k_riga_find
kuf_barcode kuf1_barcode
st_esito kst_esito 


	
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	try
		kuf1_barcode = create kuf_barcode


//--- Cerco il barcode tra i filgi gia' presenti
		k_riga_find = dw_lista_0.find("barcode_barcode = '" + trim(kst_tab_barcode.barcode) + "' ", 1, dw_lista_0.rowcount()) 

//--- se  barcode Trovato procedo nella lettura dei dati su DB non c'e' ancora tra i figli allora lo aggiungo
		if k_riga_find > 0  then
			
			kuf1_barcode.select_barcode( kst_tab_barcode )

			dw_lista_0.setitem(k_riga_find, "barcode_tipo_cicli",kst_tab_barcode.tipo_cicli)
			dw_lista_0.setitem(k_riga_find, "barcode_fila_1",kst_tab_barcode.fila_1)
			dw_lista_0.setitem(k_riga_find, "barcode_fila_2",kst_tab_barcode.fila_2)
			dw_lista_0.setitem(k_riga_find, "barcode_fila_1p",kst_tab_barcode.fila_1p)
			dw_lista_0.setitem(k_riga_find, "barcode_fila_2p",kst_tab_barcode.fila_2p)

		else
			kst_esito.esito = kkg_esito.err_logico
			kst_esito.sqlerrtext = "Errore durante ricerca 'Padre' " +  trim(kst_tab_barcode.barcode) + " in " + trim(this.classname())
		end if
		
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		
	finally
		destroy kuf1_barcode
		
	end try

return kst_esito


end function

private function st_esito retrieve_padri ();//
//---- Rilegge tutti i padri da db2 contenuti nel dw_lista_0
//
long k_riga
st_tab_barcode kst_tab_barcode
st_esito kst_esito, kst1_esito 


	
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	for k_riga = 1 to dw_lista_0.rowcount()
	
		kst_tab_barcode.barcode = dw_lista_0.object.barcode_barcode[k_riga]
		kst1_esito = retrieve_padre_nel_dw_lista(kst_tab_barcode)
		if kst1_esito.esito <> kkg_esito.ok and kst1_esito.esito <> kkg_esito.db_wrn then
			kst_esito.esito = kst1_esito.esito
			kst_esito.sqlerrtext += "~n~r" + trim(kst1_esito.sqlerrtext)
		end if
		
	end for


return kst_esito

end function

protected function st_esito aggiorna_window ();//
st_esito kst_esito


//--- Aggiungo eventuali Figli nati all'insaputa fuori da questo pianificazione
		u_aggiungi_figli_dal_dw_lista(0)

//--- Al ritorno da una window di aggiornamento, per sicurezza rileggo PADRI e FIGLI
//--- Rileggo i dati di trattamento dei barcode figli
		kst_esito = retrieve_padri()
		if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
			kst_esito = retrieve_figli_all()
		end if
		if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn  then
			kguo_exception.inizializza(this.classname())
			kguo_exception.set_esito(kst_esito)
			kguo_exception.messaggio_utente()
		end if
		
		attiva_tasti()

return kst_esito
end function

private subroutine cambia_periodo_elenco ();//---
//--- Visualizza il box x il cambio del Periodo di elenco fatture 
//---


dw_periodo.triggerevent("ue_visibile")

end subroutine

protected subroutine open_start_window ();//
st_tab_pl_barcode kst_tab_pl_barcode
kuf_base kuf1_base


try
	
	kuf1_base = create kuf_base
	kiuf1_pl_barcode = create kuf_pl_barcode								
	kiuf_armo = create kuf_armo								
	kiuf_e1_asn = create kuf_e1_asn
	kiuf_barcode_mod_giri = create kuf_barcode_mod_giri
	kiuf_asdrackbarcode = create kuf_asdrackbarcode
	kiuf_barcode = create kuf_barcode
	kiuf_barcode_asd = create kuf_barcode_asd

	ki_toolbar_window_presente=true
	
	kidw_selezionata = dw_meca
	
	//--- cambia colore alla dw del groupage x distinguerla da quella normale
	dw_groupage_colore(dw_groupage)
	
	ki_e1_enabled = kguo_g.if_e1_enabled( )			// interfaccia E1 attiva?
	
	//--- abilita i campi x modificare im giri delle lavorazioni
	//	abilita_modifica_giri()
	
	//--- abilita la funzione di Chiusura del PL
	u_abilita_chiusura_pl()	
	
	//--- crea dw di appoggio per lettura orginale dei rif da lavorare
//	kids_meca_orig = create datastore
//	kids_meca_orig.dataobject = dw_meca.dataobject 
	
	//--- abilita i campi x modificare i giri delle lavorazioni
	st_tab_barcode kst_tab_barcode
	u_abilita_modifica_giri(kst_tab_barcode)
//	if cb_file.enabled then 
//	//=== Dimensiona e Posiziona la dw di modifica giri nella window 
//		dw_modifica.x = (this.width - dw_modifica.width) / 2
//		dw_modifica.y = (this.height - dw_modifica.height) / 7
//	end if
	
	//---- imposta le icone nei pulsanti della dw
	dw_dett_0.Modify("b_queue_pilota.filename='" + "pilota_16.bmp" + "'")
	dw_dett_0.Modify("b_file_pilota.filename='" + "apri_file1.bmp" + "'")
	
	ki_data_ini = date(Mid(kuf1_base.prendi_dato_base("barcode_dt_no_lav"),2))
	if isnull(ki_data_ini) then
		ki_data_ini = date(0)
	end if 
	//--- la data deve essere compresa inizialmente tra 180 e 365 gg prima
	if ki_data_ini > relativedate(kguo_g.get_dataoggi( ), -180) then
		ki_data_ini = relativedate(kguo_g.get_dataoggi( ), -180)
	else	
		if ki_data_ini < relativedate(kguo_g.get_dataoggi( ), -365) then
			ki_data_ini = relativedate(kguo_g.get_dataoggi( ), -365)
		end if
	end if
	
	ki_data_fin = kguo_g.get_dataoggi()
	
	//--- controlla se utente autorizzato a cambiare lo stato in attenzione del lotto
	u_autorizza_stato_in_attenzione()
	
	//--- controlla se utente autorizzato a cambiare la data di consegna
	if u_autorizza_mod_consegna_data( ) then
		dw_meca.Modify("meca_consegna_dataora.protect='0'")
	end if
	
	if isvalid(kuf1_base) then destroy kuf1_base
	
	//--- attivo il timer ogni mezzo secondo	
	timer( 0.5 )
	
catch (uo_exception ki_e1_enabled)
	ki_e1_enabled.messaggio_utente()
	cb_chiudi.post event clicked( )
	
end try
end subroutine

public subroutine set_base_data_ini ();//
//--- Imposta sul BASE la data di inizio Elenco così da ricordarla al prx rientro
//
date k_data_inizio
int k_ctr=0, k_ind
kuf_base kuf1_base
st_tab_base kst_tab_base


	k_data_inizio = ki_data_ini

	k_ctr = dw_meca.rowcount()
	if k_ctr > 0 then
		ki_data_ini = dw_meca.getitemdate(1, "meca_data_int")
	end if
	for k_ind = 2 to k_ctr
		
		if ki_data_ini > dw_meca.getitemdate(k_ind, "meca_data_int") then
			ki_data_ini = dw_meca.getitemdate(k_ind, "meca_data_int")
		end if
		
	end for

	if k_data_inizio <> ki_data_ini then
		kuf1_base = create kuf_base
		kst_tab_base.key = trim("barcode_dt_no_lav")
		kst_tab_base.key1 = string(ki_data_ini)
		kuf1_base.metti_dato_base(kst_tab_base)
		destroy kuf1_base
	end if
	
end subroutine

private subroutine open_elenco_lettore_grp ();//
int k_rc
window k_window
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window 
kuf_lettore_grp kuf1_lettore_grp
datawindowchild kdwc_barcode
uo_exception kuo_exception
pointer kpointer_old


	kpointer_old = setpointer(hourglass!)

	kuf1_lettore_grp = create kuf_lettore_grp

//=== Parametri : 
//=== struttura st_open_w
	kst_open_w.flag_modalita = kkg_flag_modalita.elenco
	kst_open_w.id_programma = kuf1_lettore_grp.get_id_programma(kst_open_w.flag_modalita)
	kst_open_w.flag_primo_giro = "S"
	kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
	kst_open_w.flag_leggi_dw = " "
	kst_open_w.flag_cerca_in_lista = " "
	kst_open_w.key2 = " "
	kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
	kst_open_w.key4 = ""
	kst_open_w.key12_any = kdsi_elenco_output
	kst_open_w.flag_where = " "
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(kst_open_w)
	destroy kuf1_menu_window
	
	destroy kuf1_lettore_grp

	setpointer (kpointer_old)


end subroutine

public subroutine set_stato_in_attenzione ();//
//--- Cambia il flag dello 'stato in attenzione' sul Lotto
//
long k_riga=0
kuf_armo kuf1_armo
st_tab_meca kst_tab_meca



	k_riga = dw_meca.getselectedrow(0) 

	if k_riga > 0 then
		
		do
			
			kst_tab_meca.id = dw_meca.getitemnumber(k_riga, "id_meca")
			
			kuf1_armo = create kuf_armo
			kuf1_armo.set_stato_in_attenzione_cambia(kst_tab_meca)
			destroy kuf1_armo
			
			dw_meca.setitem(k_riga, "stato_in_attenzione", kst_tab_meca.stato_in_attenzione)

			k_riga = dw_meca.getselectedrow(k_riga) 
			
		loop while k_riga > 0

	else
		kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_dati_insufficienti )
		kguo_exception.setmessage("Prego, selezionare una riga dall'elenco.")
		kguo_exception.messaggio_utente( )
	end if
		
	
end subroutine

public subroutine call_elenco_grp ();//
kuf_barcode_tree kuf1_barcode_tree



	try
		
		kuf1_barcode_tree = create kuf_barcode_tree
		kuf1_barcode_tree.link_call( dw_meca, "grp" )
		
	catch (uo_exception kuo_exception)
		
		
	finally 
		destroy kuf1_barcode_tree
		ki_dragdrop = false
		dw_meca.drag(cancel!)
		
	end try

end subroutine

private subroutine chiudi_pl_elabora () throws uo_exception;//---
//--- Chiude Piano di Lavorazione (chiamato da chiudi_pl)
//---
//--- lancia EXCEPTION
//---
long k_riga
int k_errore=0
st_tab_pl_barcode kst_tab_pl_barcode
st_esito kst_esito, kst_esito_err

pointer oldpointer  // Declares a pointer variable


k_errore = 0
	
	try	

		kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")
	
//--- prima di Chiudere RIPRISTINA gli archivi da eventuali chiusure passate
		kst_tab_pl_barcode.st_tab_g_0.esegui_commit =  "S"    //"N" x temporaltable
		kiuf1_pl_barcode.riapre_pl_barcode(kst_tab_pl_barcode)
			
//--- Controllo se Tutto OK			
		if_programmazione_ok()

//--- Chiude PL: inizio delle fasi di chiusura del PL 
		kst_tab_pl_barcode.data_chiuso = kg_dataoggi
		kst_tab_pl_barcode.st_tab_g_0.esegui_commit =  "S"    //"N" x temporaltable
		kst_esito = kiuf1_pl_barcode.tb_update_campo(kst_tab_pl_barcode, "data_chiuso")
		
		if kst_esito.esito <> kkg_esito.ok then
			k_errore = 1
			kst_esito_err.esito = kst_esito.esito
			kst_esito_err.sqlcode = kst_esito.sqlcode
			kst_esito_err.sqlerrtext = "Errore durante Chiusura del P.L.." + kkg.acapo + "Errore " + trim(kst_esito.sqlerrtext)
			kGuf_data_base.errori_scrivi_esito("W", kst_esito_err) 
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito_err)
			throw kguo_exception
		end if			  
	
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		kst_esito_err.esito = kst_esito.esito
		kst_esito_err.sqlcode = kst_esito.sqlcode
		kst_esito_err.sqlerrtext = "Errore durante Chiusura Piano di Lavorazione Barcode: " + kkg.acapo + trim(kst_esito.sqlerrtext)
		kGuf_data_base.errori_scrivi_esito("W", kst_esito_err) 
		
		kguo_sqlca_db_magazzino.db_rollback( ) 
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito_err)
		throw kguo_exception
		
	finally
		SetPointer(oldpointer)  // ripristino Puntatore

	end try
		





end subroutine

private function integer chiudi_pl ();//
//=== Chiude Piano di Lavorazione
//
//--- Torna 0=tutto ok; 
//---       1=errore grave
//---       2=elab non eseguita; 
//
//
int k_errore=0, k_nrc
string k_rc
long k_riga
st_sv_eventi_sked kst_sv_eventi_sked
st_esito kst_esito, kst_esito_err
kuf_sv_skedula kuf1_sv_skedula


	
try 

	
	//--- se pl barcode gia' chiuso non fa un bel niente
	if if_pl_barcode_chiuso() then
	
		messagebox("Elaborazione non eseguita", &
					  "Il Piano di Lavorazione e' gia' Chiuso.~n~r" &
					  + "Codice: " &
					  + trim(string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice"))) + "~n~r", &
					  Information! )
	
	else
			
		k_nrc = messagebox("Chiudi P.L. - Elaborazione Definitiva ", &
					  "ATTENZIONE~n~rquesta elaborazione Aggiorna e Chiude il P.L..~n~r" &
					  + "Dopo l'aggiornamento non sara' piu' possibile eseguire alcuna~n~r" &
					  + "modifica al Piano di Lavorazione~n~r~n~r" &
					  + "Proseguire?", &
					  question!, YesNo!, 2) 
	
		if k_nrc = 2 then
			ki_operazione_chiusura = false
			k_errore = 2
		else
			ki_operazione_chiusura = true
		end if
				

		if ki_operazione_chiusura then 
			
//--- Salva il PL
			k_rc = aggiorna_dati()		
			
			if Left(k_rc, 1) <> "0" then //Aggiornamento fallito
//				k_errore = 1 
//				ki_operazione_chiusura = false 
				kst_esito_err.esito = Left(k_rc, 1)
				kst_esito_err.sqlcode = 0
				kst_esito_err.sqlerrtext = trim(Mid(k_rc, 2))
				kst_esito_err.nome_oggetto = this.classname()
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito_err)
				throw kguo_exception
				//kGuf_data_base.errori_scrivi_esito("W", kst_esito_err) 
				
			end if
//		end if		
		
//		if ki_operazione_chiusura and k_errore = 0 then 
		
			SetPointer(kkg.pointer_attesa)   // Puntatore Cursore da attesa.....

//--- Chiudi PL effettivamente !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!			
			chiudi_pl_elabora( )
//-------------------------------------------------------			

//--- Verifica se l'invio del pl è fatto in automatico
			kuf1_sv_skedula = create kuf_sv_skedula
			kst_sv_eventi_sked.id_menu_window = kkg_id_programma_pilota_esporta_pl
			kst_esito = kuf1_sv_skedula.get_time_evento( kst_sv_eventi_sked )
			if isvalid(kuf1_sv_skedula) then destroy kuf1_sv_skedula
			
			if kst_esito.esito = kkg_esito.ok then
				messagebox("Chiusura Piano di Lavorazione" ,"Operazione terminata correttamente.~n~r" + "Chiuso Piano di Lavorazione n.: " &
						  + (string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")))  &
						  + "~n~r~n~r" + "Il piano sara' inviato in automatico alle " &
						  + string(kst_sv_eventi_sked.run_ora ) + " del " + string(kst_sv_eventi_sked.run_giorno )  &
						  ,Information! )
		
			else
				if kst_esito.esito = kkg_esito.not_fnd then
					
					messagebox("Chiusura Piano di Lavorazione", "Operazione terminata correttamente.~n~r"  + "Chiuso Piano di Lavorazione n.: " &
						  + (string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")))  &
						  + "~n~r~n~r" + "Effettuare l'invio del Piano in modo Manuale dal Menu 'Magazzino'!  ~n~r" &
						  ,Information! )
				else
					messagebox("Chiusura Piano di Lavorazione", "Operazione terminata correttamente.~n~r" + "Chiuso Piano di Lavorazione n: " &
						  + (string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice"))) + "~n~r", &
						  Information! )
				end if
			end if
		
		end if

	end if
		
catch (uo_exception kuo_exception)
	k_errore = 1
	kst_esito = kguo_exception.get_st_esito( )
	kguo_exception.inizializza( )
	kguo_exception.messaggio_utente("Chiusura Piano di Lavorazione", "Operazione non eseguita!!" + "~n~r" + trim(kst_esito.sqlerrtext) + "~n~rPiano non chiuso, esecuzione Interrotta." )

finally
	ki_operazione_chiusura = false
	SetPointer(kkg.pointer_default)  // ripristino Puntatore

end try
		

return k_errore

end function

private function integer apri_pl ();//
//=== Ri-apre Piano di Lavorazione
//
//--- Torna 0=tutto ok; 
//---       1=errore grave
//---       2=elab non eseguita; 
//
//
int k_errore=0, k_nrc
string k_rc
boolean k_elabora=FALSE
st_tab_barcode kst_tab_barcode
st_tab_pl_barcode kst_tab_pl_barcode
st_esito kst_esito
kuf_barcode kuf1_barcode
pointer oldpointer  



try 


	kuf1_barcode = create kuf_barcode

//--- se anche solo un barcode ha già iniziato il trattamento NO!
	kst_tab_barcode.pl_barcode = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")
	if kuf1_barcode.get_nr_barcode_in_lav_x_pl(kst_tab_barcode) > 0  then

		k_errore = 2
		ki_chiudi_PL_enabled = false
		messagebox("Elaborazione non eseguita", &
				  "Il Piano di Lavorazione è già in TRATTAMENTO quindi non può essere Riaperto.~n~r" &
				  + "Codice: " &
				  + trim(string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice"))) + "~n~r", &
				  Information! )

	else

//--- se anche solo un barcode è già stato trasferito al PILOTA allora NON si può APRIRE
		kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")
		if kiuf1_pl_barcode.if_pl_trasferito_al_pilota(kst_tab_pl_barcode) then
			
			ki_chiudi_PL_enabled = false
			messagebox("Elaborazione non eseguita", &
				  "Il Piano di Lavorazione è già stato Trasferito al Pilota e non può essere Riaperto.~n~r" &
				  + "Codice: " &
				  + trim(string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice"))) + "~n~r", &
				  Information! )

		else

			k_nrc = messagebox("Chiudi P.L. - Elaborazione CRITICA ", &
					  "RIAPERTURA!!! ~n~rquesta elaborazione Rapre il P.L..~n~r" &
					  + "Se il Piano è già stato caricato nel PILOTA (magari in ritardo), potranno verificarsi delle Incongruenze GRAVI " &
					  + "nei dati dei BARCODE di questo Piano di Lavorazione!!! ~n~r~n~r" &
					  + "Proseguire comunque?", &
					  question!, YesNo!, 2) 
	
			if k_nrc = 2 then
				k_errore = 2
			else
				k_elabora = true  // OK APRIAMO!
			end if
				
		end if
	end if
	

	if k_elabora then 
			
		
		oldpointer = SetPointer(HourGlass!)   // Puntatore Cursore da attesa.....

//--- RI-APRE il PL effettivamente !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!			
		apri_pl_elabora( )
//-------------------------------------------------------			

		try 
			
			kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")
			kiuf1_pl_barcode.get_path_file_pilota(kst_tab_pl_barcode)
			kiuf1_pl_barcode.cancella_file_pilota(kst_tab_pl_barcode)
			
		catch (uo_exception kuo1_exception)
			kuo1_exception.messaggio_utente()
			
		end try


	end if

catch (uo_exception kuo_exception)
	k_errore = 1
	kst_esito = kguo_exception.get_st_esito( )
	kguo_exception.inizializza( )
	kguo_exception.messaggio_utente("Riapertura Piano di Lavorazione", &
					  "Operazione di aggiornamento fallita. Il Piano è rimasto chiuso!! ~n~r" &
					  + "~n~r" &
					  + trim(kst_esito.sqlerrtext) &
					  + "~n~r" )
finally
	if IsValid(kuf1_barcode) then destroy kuf1_barcode
	SetPointer(oldpointer)  // ripristino Puntatore

end try


return k_errore

end function

private subroutine apri_pl_elabora () throws uo_exception;//---
//--- Apre Piano di Lavorazione (chiamato da apri_pl)
//---
//--- lancia EXCEPTION
//---
long k_riga
int k_errore=0
st_tab_pl_barcode kst_tab_pl_barcode
st_esito kst_esito, kst_esito_err

pointer oldpointer  // Declares a pointer variable

 
k_errore = 0
	
	try	

		kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")
	
//--- RIPRISTINA gli archivi da eventuali chiusure passate
		kst_tab_pl_barcode.st_tab_g_0.esegui_commit =  "S"    //"N" x temporaltable
		kiuf1_pl_barcode.riapre_pl_barcode(kst_tab_pl_barcode)
			
		kguo_sqlca_db_magazzino.db_commit( ) 
	
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		kst_esito_err.esito = kst_esito.esito
		kst_esito_err.sqlcode = kst_esito.sqlcode
		kst_esito_err.sqlerrtext = "Errore durante Riapertura del Piano di Lavorazione (apri_pl_elabora): ~n~r" + trim(kst_esito.sqlerrtext)
		kGuf_data_base.errori_scrivi_esito("W", kst_esito_err) 
		
		kguo_sqlca_db_magazzino.db_rollback( ) 
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito_err)
		throw kguo_exception
		
	finally
		SetPointer(oldpointer)  // ripristino Puntatore

	end try
		





end subroutine

protected subroutine riempi_id ();/*
non fa nulla
*/



end subroutine

public subroutine u_marca_rif_file_davanti ();//
long k_riga, k_presenti_meca, k_num_loop_max, k_riga_find
long k_ctr, k_rc, k_fila_mag_n
string k_area_mag, k_fila_mag


//--- Evidenzia i Lotti con Fila davanti (la fila ZERO è quella a Muro la 1 davanti alla zero la 2 davanti alla 1 e così via) AREA_MAG il carattere 6 e' la fila
	k_num_loop_max	= dw_meca.rowcount()
	for k_riga = 1 to k_num_loop_max
		k_area_mag =  trim(dw_meca.getitemstring(k_riga, "meca_area_mag") )
		dw_meca.setitem(k_riga, "evidenzia_area_mag_value", 0)
		if len(k_area_mag) > 5 then
			k_fila_mag = mid(k_area_mag,6,1)
			k_area_mag = left(k_area_mag,5)
			if isnumber(k_fila_mag) then
				k_fila_mag_n = integer(k_fila_mag) + 1
				for k_ctr = k_fila_mag_n  to 9 // cerca AREA_MAG dietro al lotto (fila + bassa)
					k_riga_find = dw_meca.find("meca_area_mag = '" +k_area_mag + string(k_ctr)+"'", 0, dw_meca.rowcount())
					if k_riga_find > 0 then 
						dw_meca.setitem(k_riga, "evidenzia_area_mag_value", dw_meca.getitemnumber(k_riga_find, "meca_num_int"))
						EXIT
					end if
				next
			end if
		end if
	next



end subroutine

protected function string inizializza_post ();if not ki_exit_si then

	
	attiva_tasti()

	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 
		dw_meca.setfocus( )
	end if
	
end if

return "0"

end function

private subroutine u_autorizza_stato_in_attenzione ();//---
//--- Funzione: Autorizzazione a MARCARE il glag in Attenzione del LOTTO
//--- 
//--- Input:
//---
//--- Ritorno: no
//---
//---


try

	ki_autorizza_marca_stato_in_attenzione = true

	kiuf_armo.if_sicurezza(kkg_flag_modalita.inserimento) 

catch (uo_exception kuo_exception)
	ki_autorizza_marca_stato_in_attenzione = false

end try
	



end subroutine

private function boolean u_autorizza_mod_consegna_data ();//---
//--- Funzione: Autorizzazione a modificare la DATA di CONSEGNA
//--- 
//--- Input:
//---
//--- Ritorno: no
//---
//---
boolean k_autorizza=true


k_autorizza = ki_chiudi_PL_enabled 

//try
//	kiuf_armo.if_sicurezza(kkg_flag_modalita.modifica)
//
//catch (uo_exception kuo_exception)
//	k_autorizza = false
//	
//end try

return k_autorizza

end function

public subroutine u_aggiorna_data_consegna (st_tab_meca kst_tab_meca, long k_riga);//
datetime k_dataora

try
	
	kiuf_armo.set_consegna_data(kst_tab_meca)
	kiuf_armo.set_consegna_ora(kst_tab_meca)

	k_dataora = datetime(kst_tab_meca.consegna_data, kst_tab_meca.consegna_ora)

	dw_meca.setitem(k_riga, "meca_consegna_dataora", k_dataora)

catch (uo_exception kuo_exception)

	kuo_exception.messaggio_utente()
	
end try

end subroutine

private subroutine u_abilita_chiusura_pl ();//
//--- controllo autorizzazione x chiusura P.L.
//
st_esito kst_esito
kuf_pl_barcode kuf1_pl_barcode


kuf1_pl_barcode = create kuf_pl_barcode

kst_esito = kuf1_pl_barcode.consenti_chiusura() 

destroy kuf1_pl_barcode

if kst_esito.esito = kkg_esito.ok then
	ki_chiudi_PL_enabled = true
end if

end subroutine

public subroutine u_mostra_proprieta (boolean k_forza_visible);//---
//--- Mostra finestra Proprietà
//---
st_tab_pl_barcode kst_tab_pl_barcode


//--- se non è visibile o è da forzare la visibilita allora VISIBLE!
if not dw_dett_0.visible or k_forza_visible then

	if dw_dett_0.rowcount() = 0 then
		kiuf1_pl_barcode.set_pl_barcode_nuovo_default(kst_tab_pl_barcode)
		set_dw_dett_0(kst_tab_pl_barcode)
	end if

//--- determina lo stato del pulsante (CHIUDI APRI il PL)	
	if not ki_PL_chiuso then 
		dw_dett_0.object.b_chiudi.text = "CHIUDE PL"
	else
		dw_dett_0.object.b_chiudi.text = "RIAPRE PL"
	end if
	dw_dett_0.object.b_chiudi.enabled = cb_chiudi.enabled
	
	dw_dett_0.width = 3100
	dw_dett_0.height = 1016
	dw_dett_0.X = (this.width - dw_dett_0.width) / 2
	dw_dett_0.y = (this.height - dw_dett_0.height) / 3
	
	dw_dett_0.enabled = true

	dw_dett_0.visible = true
	dw_dett_0.bringtotop = true
	
else
	dw_dett_0.visible = false
end if

end subroutine

private subroutine copia_dw_barcode_to_dw_lista_0 (integer k_riga1, integer k_riga2);//---
//--- copia dati dal DW di dettaglio (dw_bacode) al dw di lavoro (dw_lista_0) 
//--- parametri:
//---            riga1 riga della dw1
//---            riga2 riga della dw2
//---
	
	
		dw_lista_0.setitem(k_riga1, "barcode_barcode", &
					 dw_barcode.getitemstring(k_riga2, "barcode_barcode"))
		dw_lista_0.setitem(k_riga1, "barcode_tipo_cicli", &
					 dw_barcode.getitemstring(k_riga2, "barcode_tipo_cicli"))
		dw_lista_0.setitem(k_riga1, "barcode_fila_1", &
					 dw_barcode.getitemnumber(k_riga2, "barcode_fila_1"))
		dw_lista_0.setitem(k_riga1, "barcode_fila_2", &
					 dw_barcode.getitemnumber(k_riga2, "barcode_fila_2"))
		dw_lista_0.setitem(k_riga1, "barcode_fila_1p", &
					 dw_barcode.getitemnumber(k_riga2, "barcode_fila_1p"))
		dw_lista_0.setitem(k_riga1, "barcode_fila_2p", &
					 dw_barcode.getitemnumber(k_riga2, "barcode_fila_2p"))
		dw_lista_0.setitem(k_riga1, "barcode_num_int", &
					 dw_barcode.getitemnumber(k_riga2, "barcode_num_int"))
		dw_lista_0.setitem(k_riga1, "barcode_data_int", &
					 dw_barcode.getitemdate(k_riga2, "barcode_data_int"))
//		dw_lista_0.setitem(k_riga1, "barcode_data_sosp", &
//					 dw_barcode.getitemdate(k_riga2, "barcode_data_sosp"))
//		dw_lista_0.setitem(k_riga1, "barcode_data_lav_ini", &
//					 dw_barcode.getitemdate(k_riga2, "barcode_data_lav_ini"))
//		dw_lista_0.setitem(k_riga1, "barcode_data_lav_fin",  dw_barcode.getitemdate(k_riga2, "barcode_data_lav_fin"))
//			
//		if dw_lista_0.dataobject = "dw_barcode" or dw_barcode.dataobject = "dw_barcode" then
//		else
//			dw_lista_0.setitem(k_riga1, "barcode_data_lav_ok", &
//						 dw_barcode.getitemdate(k_riga2, "barcode_data_lav_ok"))
//			dw_lista_0.setitem(k_riga1, "barcode_x_datins", &
//						 dw_barcode.getitemdatetime(k_riga2, "barcode_x_datins"))
//			dw_lista_0.setitem(k_riga1, "barcode_x_utente", &
//						 dw_barcode.getitemstring(k_riga2, "barcode_x_utente"))
//			dw_lista_0.setitem(k_riga1, "sl_pt_tipo_cicli", &
//						 dw_barcode.getitemstring(k_riga2, "sl_pt_tipo_cicli"))
//			dw_lista_0.setitem(k_riga1, "sl_pt_fila_1", &
//						 dw_barcode.getitemnumber(k_riga2, "sl_pt_fila_1"))
//			dw_lista_0.setitem(k_riga1, "sl_pt_fila_2", &
//						 dw_barcode.getitemnumber(k_riga2, "sl_pt_fila_2"))
//			dw_lista_0.setitem(k_riga1, "sl_pt_fila_1p", &
//						 dw_barcode.getitemnumber(k_riga2, "sl_pt_fila_1p"))
//			dw_lista_0.setitem(k_riga1, "sl_pt_fila_2p", &
//						 dw_barcode.getitemnumber(k_riga2, "sl_pt_fila_2p"))
			dw_lista_0.setitem(k_riga1, "dose", &
						 dw_barcode.getitemnumber(k_riga2, "armo_dose"))
			dw_lista_0.setitem(k_riga1, "peso_kg", &
						 dw_barcode.getitemnumber(k_riga2, "armo_peso_kg"))
			dw_lista_0.setitem(k_riga1, "larg_2", &
						 dw_barcode.getitemnumber(k_riga2, "armo_larg_2"))
			dw_lista_0.setitem(k_riga1, "lung_2", &
						 dw_barcode.getitemnumber(k_riga2, "armo_lung_2"))
			dw_lista_0.setitem(k_riga1, "alt_2", &
						 dw_barcode.getitemnumber(k_riga2, "armo_alt_2"))
			dw_lista_0.setitem(k_riga1, "pedane", &
						 dw_barcode.getitemnumber(k_riga2, "armo_pedane"))
			dw_lista_0.setitem(k_riga1, "campione", &
						 dw_barcode.getitemstring(k_riga2, "armo_campione"))
			dw_lista_0.setitem(k_riga1, "art", &
						 dw_barcode.getitemstring(k_riga2, "armo_art"))
//			dw_lista_0.setitem(k_riga1, "armo_cod_sl_pt", &
//						 dw_barcode.getitemstring(k_riga2, "armo_cod_sl_pt"))
			dw_lista_0.setitem(k_riga1, "area_mag", &
						 dw_barcode.getitemstring(k_riga2, "meca_area_mag"))
			dw_lista_0.setitem(k_riga1, "id_armo", &
						 dw_barcode.getitemnumber(k_riga2, "armo_id_armo"))
			dw_lista_0.setitem(k_riga1, "id_meca", &
						 dw_barcode.getitemnumber(k_riga2, "id_meca"))

			dw_lista_0.setitem(k_riga1, "e1ancodrs", &
						 dw_barcode.getitemstring(k_riga2, "e1ancodrs"))
			dw_lista_0.setitem(k_riga1, "k_densita", &
						 dw_barcode.getitemnumber(k_riga2, "k_densita"))
			dw_lista_0.setitem(k_riga1, "id_asdrackcode", &
						 dw_barcode.getitemnumber(k_riga2, "id_asdrackcode"))

//			dw_lista_0.setitem(k_riga1, "meca_contratto", &
//						 dw_barcode.getitemnumber(k_riga2, "meca_contratto"))
//			dw_lista_0.setitem(k_riga1, "meca_clie_3", &
//						 dw_barcode.getitemnumber(k_riga2, "meca_clie_3"))
//			dw_lista_0.setitem(k_riga1, "contratti_mc_co", &
//						 dw_barcode.getitemstring(k_riga2, "contratti_mc_co"))
//			dw_lista_0.setitem(k_riga1, "contratti_sc_cf", &
//						 dw_barcode.getitemstring(k_riga2, "contratti_sc_cf"))
//			dw_lista_0.setitem(k_riga1, "contratti_descr", &
//						 dw_barcode.getitemstring(k_riga2, "contratti_descr"))
//			dw_lista_0.setitem(k_riga1, "prodotti_des", &
//						 dw_barcode.getitemstring(k_riga2, "prodotti_des"))
//			dw_lista_0.setitem(k_riga1, "clienti_rag_soc_10", &
//						 dw_barcode.getitemstring(k_riga2, "clienti_rag_soc_10"))
//			dw_lista_0.setitem(k_riga1, "k_ricevente", &
//						 dw_barcode.getitemstring(k_riga2, "k_ricevente"))
//		end if

end subroutine

private subroutine copia_dw_lista_0_to_dw_groupage (integer k_riga1, integer k_riga2);//---
//--- copia dalla dw_lista in dw del groupage 
//--- parametri: 
//---            riga1 riga della dw1
//---            riga2 riga della dw2
//---
	
	
//			dw_groupage.setitem(k_riga1, "barcode_lav",  "")
			dw_groupage.setitem(k_riga1, "barcode_barcode", &
						 dw_lista_0.getitemstring(k_riga2, "barcode_barcode"))
			dw_groupage.setitem(k_riga1, "barcode_tipo_cicli", &
						 dw_lista_0.getitemstring(k_riga2, "barcode_tipo_cicli"))
			dw_groupage.setitem(k_riga1, "barcode_fila_1", &
						 dw_lista_0.getitemnumber(k_riga2, "barcode_fila_1"))
			dw_groupage.setitem(k_riga1, "barcode_fila_2", &
						 dw_lista_0.getitemnumber(k_riga2, "barcode_fila_2"))
			dw_groupage.setitem(k_riga1, "barcode_fila_1p", &
						 dw_lista_0.getitemnumber(k_riga2, "barcode_fila_1p"))
			dw_groupage.setitem(k_riga1, "barcode_fila_2p", &
						 dw_lista_0.getitemnumber(k_riga2, "barcode_fila_2p"))
			dw_groupage.setitem(k_riga1, "barcode_num_int", &
						 dw_lista_0.getitemnumber(k_riga2, "barcode_num_int"))
			dw_groupage.setitem(k_riga1, "barcode_data_int", &
						 dw_lista_0.getitemdate(k_riga2, "barcode_data_int"))
			dw_groupage.setitem(k_riga1, "dose", dw_lista_0.getitemnumber(k_riga2, "dose"))
			dw_groupage.setitem(k_riga1, "peso_kg", &
						 dw_lista_0.getitemnumber(k_riga2, "peso_kg"))
			dw_groupage.setitem(k_riga1, "larg_2", &
						 dw_lista_0.getitemnumber(k_riga2, "larg_2"))
			dw_groupage.setitem(k_riga1, "lung_2", &
						 dw_lista_0.getitemnumber(k_riga2, "lung_2"))
			dw_groupage.setitem(k_riga1, "alt_2", &
						 dw_lista_0.getitemnumber(k_riga2, "alt_2"))
			dw_groupage.setitem(k_riga1, "pedane", &
						 dw_lista_0.getitemnumber(k_riga2, "pedane"))
			dw_groupage.setitem(k_riga1, "campione", &
						 dw_lista_0.getitemstring(k_riga2, "campione"))
			dw_groupage.setitem(k_riga1, "art", &
						 dw_lista_0.getitemstring(k_riga2, "art"))
//			dw_groupage.setitem(k_riga1, "armo_cod_sl_pt", &
//						 dw_lista_0.getitemstring(k_riga2, "armo_cod_sl_pt"))
			dw_groupage.setitem(k_riga1, "area_mag", &
						 dw_lista_0.getitemstring(k_riga2, "area_mag"))
			dw_groupage.setitem(k_riga1, "id_armo", &
						 dw_lista_0.getitemnumber(k_riga2, "id_armo"))
			dw_groupage.setitem(k_riga1, "id_meca", &
						 dw_lista_0.getitemnumber(k_riga2, "id_meca"))

			dw_groupage.setitem(k_riga1, "e1ancodrs", &
						 dw_lista_0.getitemstring(k_riga2, "e1ancodrs"))
						 
			dw_groupage.setitem(k_riga1, "k_densita", &
						 dw_lista_0.getitemnumber(k_riga2, "k_densita"))
			dw_groupage.setitem(k_riga1, "id_asdrackcode", &
						 dw_lista_0.getitemnumber(k_riga2, "id_asdrackcode"))

//			dw_groupage.setitem(k_riga1, "meca_clie_2", &
//						 dw_lista_0.getitemnumber(k_riga2, "clie_2"))
//			dw_groupage.setitem(k_riga1, "prodotti_des", &
//						 dw_lista_0.getitemstring(k_riga2, "des"))
//			dw_groupage.setitem(k_riga1, "clienti_rag_soc_10", &
//						 dw_lista_0.getitemstring(k_riga2, "rag_soc_10") + " " + string(dw_lista_0.getitemnumber(k_riga2, "clie_2")))


end subroutine

private subroutine copia_dw_groupage_to_dw_barcode (integer k_riga1, integer k_riga2);//---
//--- copia dati dal dw del groupage (dw_groupage) al DW di dettaglio (dw_barcode)
//--- parametri: 
//---            riga1 riga della dw1
//---            riga2 riga della dw2
//---
	
	
		dw_barcode.setitem(k_riga1, "barcode_barcode", &
					 dw_groupage.getitemstring(k_riga2, "barcode_barcode"))
		dw_barcode.setitem(k_riga1, "barcode_tipo_cicli", &
					 dw_groupage.getitemstring(k_riga2, "barcode_tipo_cicli"))
		dw_barcode.setitem(k_riga1, "barcode_fila_1", &
					 dw_groupage.getitemnumber(k_riga2, "barcode_fila_1"))
		dw_barcode.setitem(k_riga1, "barcode_fila_2", &
					 dw_groupage.getitemnumber(k_riga2, "barcode_fila_2"))
		dw_barcode.setitem(k_riga1, "barcode_fila_1p", &
					 dw_groupage.getitemnumber(k_riga2, "barcode_fila_1p"))
		dw_barcode.setitem(k_riga1, "barcode_fila_2p", &
					 dw_groupage.getitemnumber(k_riga2, "barcode_fila_2p"))
		dw_barcode.setitem(k_riga1, "barcode_num_int", &
					 dw_groupage.getitemnumber(k_riga2, "barcode_num_int"))
		dw_barcode.setitem(k_riga1, "barcode_data_int", &
					 dw_groupage.getitemdate(k_riga2, "barcode_data_int"))
//		dw_barcode.setitem(k_riga1, "barcode_data_sosp", &
//					 dw_groupage.getitemdate(k_riga2, "barcode_data_sosp"))
//		dw_barcode.setitem(k_riga1, "barcode_data_lav_ini", &
//					 dw_groupage.getitemdate(k_riga2, "barcode_data_lav_ini"))
//		dw_barcode.setitem(k_riga1, "barcode_data_lav_fin",  dw_groupage.getitemdate(k_riga2, "barcode_data_lav_fin"))
//			
//		if dw_barcode.dataobject = "dw_barcode" or dw_groupage.dataobject = "dw_barcode" then
//		else
//			dw_barcode.setitem(k_riga1, "barcode_data_lav_ok", &
//						 dw_groupage.getitemdate(k_riga2, "barcode_data_lav_ok"))
//			dw_barcode.setitem(k_riga1, "barcode_x_datins", &
//						 dw_groupage.getitemdatetime(k_riga2, "barcode_x_datins"))
//			dw_barcode.setitem(k_riga1, "barcode_x_utente", &
//						 dw_groupage.getitemstring(k_riga2, "barcode_x_utente"))
//			dw_barcode.setitem(k_riga1, "sl_pt_tipo_cicli", &
//						 dw_groupage.getitemstring(k_riga2, "sl_pt_tipo_cicli"))
//			dw_barcode.setitem(k_riga1, "sl_pt_fila_1", &
//						 dw_groupage.getitemnumber(k_riga2, "sl_pt_fila_1"))
//			dw_barcode.setitem(k_riga1, "sl_pt_fila_2", &
//						 dw_groupage.getitemnumber(k_riga2, "sl_pt_fila_2"))
//			dw_barcode.setitem(k_riga1, "sl_pt_fila_1p", &
//						 dw_groupage.getitemnumber(k_riga2, "sl_pt_fila_1p"))
//			dw_barcode.setitem(k_riga1, "sl_pt_fila_2p", &
//						 dw_groupage.getitemnumber(k_riga2, "sl_pt_fila_2p"))
			dw_barcode.setitem(k_riga1, "armo_dose", &
						 dw_groupage.getitemnumber(k_riga2, "dose"))
			dw_barcode.setitem(k_riga1, "armo_peso_kg", &
						 dw_groupage.getitemnumber(k_riga2, "peso_kg"))
			dw_barcode.setitem(k_riga1, "armo_larg_2", &
						 dw_groupage.getitemnumber(k_riga2, "larg_2"))
			dw_barcode.setitem(k_riga1, "armo_lung_2", &
						 dw_groupage.getitemnumber(k_riga2, "lung_2"))
			dw_barcode.setitem(k_riga1, "armo_alt_2", &
						 dw_groupage.getitemnumber(k_riga2, "alt_2"))
			dw_barcode.setitem(k_riga1, "armo_pedane", &
						 dw_groupage.getitemnumber(k_riga2, "pedane"))
			dw_barcode.setitem(k_riga1, "armo_campione", &
						 dw_groupage.getitemstring(k_riga2, "campione"))
			dw_barcode.setitem(k_riga1, "armo_art", &
						 dw_groupage.getitemstring(k_riga2, "art"))
//			dw_barcode.setitem(k_riga1, "armo_cod_sl_pt", &
//						 dw_groupage.getitemstring(k_riga2, "armo_cod_sl_pt"))
			dw_barcode.setitem(k_riga1, "meca_area_mag", &
						 dw_groupage.getitemstring(k_riga2, "area_mag"))
			dw_barcode.setitem(k_riga1, "armo_id_armo", &
						 dw_groupage.getitemnumber(k_riga2, "id_armo"))
			dw_barcode.setitem(k_riga1, "id_meca", &
						 dw_groupage.getitemnumber(k_riga2, "id_meca"))

			dw_barcode.setitem(k_riga1, "e1ancodrs", &
						 dw_groupage.getitemstring(k_riga2, "e1ancodrs"))


			dw_barcode.setitem(k_riga1, "k_densita", &
						 dw_groupage.getitemnumber(k_riga2, "k_densita"))
			dw_barcode.setitem(k_riga1, "id_asdrackcode", &
						 dw_groupage.getitemnumber(k_riga2, "id_asdrackcode"))

//			dw_barcode.setitem(k_riga1, "meca_contratto", &
//						 dw_groupage.getitemnumber(k_riga2, "meca_contratto"))
//			dw_barcode.setitem(k_riga1, "meca_clie_3", &
//						 dw_groupage.getitemnumber(k_riga2, "meca_clie_3"))
//			dw_barcode.setitem(k_riga1, "contratti_mc_co", &
//						 dw_groupage.getitemstring(k_riga2, "contratti_mc_co"))
//			dw_barcode.setitem(k_riga1, "contratti_sc_cf", &
//						 dw_groupage.getitemstring(k_riga2, "contratti_sc_cf"))
//			dw_barcode.setitem(k_riga1, "contratti_descr", &
//						 dw_groupage.getitemstring(k_riga2, "contratti_descr"))
//			dw_barcode.setitem(k_riga1, "prodotti_des", &
//						 dw_groupage.getitemstring(k_riga2, "prodotti_des"))
//			dw_barcode.setitem(k_riga1, "clienti_rag_soc_10", &
//						 dw_groupage.getitemstring(k_riga2, "clienti_rag_soc_10"))
//			dw_barcode.setitem(k_riga1, "k_ricevente", &
//						 dw_groupage.getitemstring(k_riga2, "k_ricevente"))
//		end if

end subroutine

private subroutine copia_dw_lista_0_to_dw_barcode (integer k_riga1, integer k_riga2);//---
//--- copia dati dal dw del groupage (dw_lista_0) al DW di dettaglio (dw_barcode)
//--- parametri: 
//---            riga1 riga della dw1
//---            riga2 riga della dw2
//---
	
	
		dw_barcode.setitem(k_riga1, "barcode_barcode", &
					 dw_lista_0.getitemstring(k_riga2, "barcode_barcode"))
		dw_barcode.setitem(k_riga1, "barcode_tipo_cicli", &
					 dw_lista_0.getitemstring(k_riga2, "barcode_tipo_cicli"))
		dw_barcode.setitem(k_riga1, "barcode_fila_1", &
					 dw_lista_0.getitemnumber(k_riga2, "barcode_fila_1"))
		dw_barcode.setitem(k_riga1, "barcode_fila_2", &
					 dw_lista_0.getitemnumber(k_riga2, "barcode_fila_2"))
		dw_barcode.setitem(k_riga1, "barcode_fila_1p", &
					 dw_lista_0.getitemnumber(k_riga2, "barcode_fila_1p"))
		dw_barcode.setitem(k_riga1, "barcode_fila_2p", &
					 dw_lista_0.getitemnumber(k_riga2, "barcode_fila_2p"))
		dw_barcode.setitem(k_riga1, "barcode_num_int", &
					 dw_lista_0.getitemnumber(k_riga2, "barcode_num_int"))
		dw_barcode.setitem(k_riga1, "barcode_data_int", &
					 dw_lista_0.getitemdate(k_riga2, "barcode_data_int"))
//		dw_barcode.setitem(k_riga1, "barcode_data_sosp", &
//					 dw_lista_0.getitemdate(k_riga2, "barcode_data_sosp"))
//		dw_barcode.setitem(k_riga1, "barcode_data_lav_ini", &
//					 dw_lista_0.getitemdate(k_riga2, "barcode_data_lav_ini"))
//		dw_barcode.setitem(k_riga1, "barcode_data_lav_fin",  dw_lista_0.getitemdate(k_riga2, "barcode_data_lav_fin"))
//			
//		if dw_barcode.dataobject = "dw_barcode" or dw_lista_0.dataobject = "dw_barcode" then
//		else
//			dw_barcode.setitem(k_riga1, "barcode_data_lav_ok", &
//						 dw_lista_0.getitemdate(k_riga2, "barcode_data_lav_ok"))
//			dw_barcode.setitem(k_riga1, "barcode_x_datins", &
//						 dw_lista_0.getitemdatetime(k_riga2, "barcode_x_datins"))
//			dw_barcode.setitem(k_riga1, "barcode_x_utente", &
//						 dw_lista_0.getitemstring(k_riga2, "barcode_x_utente"))
//			dw_barcode.setitem(k_riga1, "sl_pt_tipo_cicli", &
//						 dw_lista_0.getitemstring(k_riga2, "sl_pt_tipo_cicli"))
//			dw_barcode.setitem(k_riga1, "sl_pt_fila_1", &
//						 dw_lista_0.getitemnumber(k_riga2, "sl_pt_fila_1"))
//			dw_barcode.setitem(k_riga1, "sl_pt_fila_2", &
//						 dw_lista_0.getitemnumber(k_riga2, "sl_pt_fila_2"))
//			dw_barcode.setitem(k_riga1, "sl_pt_fila_1p", &
//						 dw_lista_0.getitemnumber(k_riga2, "sl_pt_fila_1p"))
//			dw_barcode.setitem(k_riga1, "sl_pt_fila_2p", &
//						 dw_lista_0.getitemnumber(k_riga2, "sl_pt_fila_2p"))
			dw_barcode.setitem(k_riga1, "armo_dose", &
						 dw_lista_0.getitemnumber(k_riga2, "dose"))
			dw_barcode.setitem(k_riga1, "armo_peso_kg", &
						 dw_lista_0.getitemnumber(k_riga2, "peso_kg"))
			dw_barcode.setitem(k_riga1, "armo_larg_2", &
						 dw_lista_0.getitemnumber(k_riga2, "larg_2"))
			dw_barcode.setitem(k_riga1, "armo_lung_2", &
						 dw_lista_0.getitemnumber(k_riga2, "lung_2"))
			dw_barcode.setitem(k_riga1, "armo_alt_2", &
						 dw_lista_0.getitemnumber(k_riga2, "alt_2"))
			dw_barcode.setitem(k_riga1, "armo_pedane", &
						 dw_lista_0.getitemnumber(k_riga2, "pedane"))
			dw_barcode.setitem(k_riga1, "armo_campione", &
						 dw_lista_0.getitemstring(k_riga2, "campione"))
			dw_barcode.setitem(k_riga1, "armo_art", &
						 dw_lista_0.getitemstring(k_riga2, "art"))
//			dw_barcode.setitem(k_riga1, "armo_cod_sl_pt", &
//						 dw_lista_0.getitemstring(k_riga2, "armo_cod_sl_pt"))
			dw_barcode.setitem(k_riga1, "meca_area_mag", &
						 dw_lista_0.getitemstring(k_riga2, "area_mag"))
			dw_barcode.setitem(k_riga1, "armo_id_armo", &
						 dw_lista_0.getitemnumber(k_riga2, "id_armo"))
			dw_barcode.setitem(k_riga1, "id_meca", &
						 dw_lista_0.getitemnumber(k_riga2, "id_meca"))
						 
			dw_barcode.setitem(k_riga1, "e1ancodrs", &
						 dw_lista_0.getitemstring(k_riga2, "e1ancodrs"))
						 
			dw_barcode.setitem(k_riga1, "k_densita", &
						 dw_lista_0.getitemnumber(k_riga2, "k_densita"))
			dw_barcode.setitem(k_riga1, "id_asdrackcode", &
						 dw_lista_0.getitemnumber(k_riga2, "id_asdrackcode"))

//			dw_barcode.setitem(k_riga1, "meca_contratto", &
//						 dw_lista_0.getitemnumber(k_riga2, "meca_contratto"))
//			dw_barcode.setitem(k_riga1, "meca_clie_3", &
//						 dw_lista_0.getitemnumber(k_riga2, "meca_clie_3"))
//			dw_barcode.setitem(k_riga1, "contratti_mc_co", &
//						 dw_lista_0.getitemstring(k_riga2, "contratti_mc_co"))
//			dw_barcode.setitem(k_riga1, "contratti_sc_cf", &
//						 dw_lista_0.getitemstring(k_riga2, "contratti_sc_cf"))
//			dw_barcode.setitem(k_riga1, "contratti_descr", &
//						 dw_lista_0.getitemstring(k_riga2, "contratti_descr"))
//			dw_barcode.setitem(k_riga1, "prodotti_des", &
//						 dw_lista_0.getitemstring(k_riga2, "prodotti_des"))
//			dw_barcode.setitem(k_riga1, "clienti_rag_soc_10", &
//						 dw_lista_0.getitemstring(k_riga2, "clienti_rag_soc_10"))
//			dw_barcode.setitem(k_riga1, "k_ricevente", &
//						 dw_lista_0.getitemstring(k_riga2, "k_ricevente"))
//		end if

end subroutine

private subroutine copia_dw_groupage_to_dw_lista_0 (integer k_riga1, integer k_riga2);//---
//--- copia dalla dw_lista in dw del groupage 
//--- parametri: 
//---            riga1 riga della dw1
//---            riga2 riga della dw2
//---
	
	
	
//			dw_lista_0.setitem(k_riga1, "barcode_barcode_lav",  "")
			dw_lista_0.setitem(k_riga1, "barcode_barcode", &
						 dw_groupage.getitemstring(k_riga2, "barcode_barcode"))
			dw_lista_0.setitem(k_riga1, "barcode_tipo_cicli", &
						 dw_groupage.getitemstring(k_riga2, "barcode_tipo_cicli"))
			dw_lista_0.setitem(k_riga1, "barcode_fila_1", &
						 dw_groupage.getitemnumber(k_riga2, "barcode_fila_1"))
			dw_lista_0.setitem(k_riga1, "barcode_fila_2", &
						 dw_groupage.getitemnumber(k_riga2, "barcode_fila_2"))
			dw_lista_0.setitem(k_riga1, "barcode_fila_1p", &
						 dw_groupage.getitemnumber(k_riga2, "barcode_fila_1p"))
			dw_lista_0.setitem(k_riga1, "barcode_fila_2p", &
						 dw_groupage.getitemnumber(k_riga2, "barcode_fila_2p"))
			dw_lista_0.setitem(k_riga1, "barcode_num_int", &
						 dw_groupage.getitemnumber(k_riga2, "barcode_num_int"))
			dw_lista_0.setitem(k_riga1, "barcode_data_int", &
						 dw_groupage.getitemdate(k_riga2, "barcode_data_int"))
			dw_lista_0.setitem(k_riga1, "dose", dw_groupage.getitemnumber(k_riga2, "dose"))
			dw_lista_0.setitem(k_riga1, "peso_kg", &
						 dw_groupage.getitemnumber(k_riga2, "peso_kg"))
			dw_lista_0.setitem(k_riga1, "larg_2", &
						 dw_groupage.getitemnumber(k_riga2, "larg_2"))
			dw_lista_0.setitem(k_riga1, "lung_2", &
						 dw_groupage.getitemnumber(k_riga2, "lung_2"))
			dw_lista_0.setitem(k_riga1, "alt_2", &
						 dw_groupage.getitemnumber(k_riga2, "alt_2"))
			dw_lista_0.setitem(k_riga1, "pedane", &
						 dw_groupage.getitemnumber(k_riga2, "pedane"))
			dw_lista_0.setitem(k_riga1, "campione", &
						 dw_groupage.getitemstring(k_riga2, "campione"))
			dw_lista_0.setitem(k_riga1, "art", &
						 dw_groupage.getitemstring(k_riga2, "art"))
//			dw_lista_0.setitem(k_riga1, "armo_cod_sl_pt", &
//						 dw_groupage.getitemstring(k_riga2, "armo_cod_sl_pt"))
			dw_lista_0.setitem(k_riga1, "area_mag", &
						 dw_groupage.getitemstring(k_riga2, "area_mag"))
			dw_lista_0.setitem(k_riga1, "id_armo", &
						 dw_groupage.getitemnumber(k_riga2, "id_armo"))
			dw_lista_0.setitem(k_riga1, "id_meca", &
						 dw_groupage.getitemnumber(k_riga2, "id_meca"))

			dw_lista_0.setitem(k_riga1, "e1ancodrs", &
						 dw_groupage.getitemstring(k_riga2, "e1ancodrs"))
						 
			dw_lista_0.setitem(k_riga1, "k_densita", &
						 dw_groupage.getitemnumber(k_riga2, "k_densita"))
			dw_lista_0.setitem(k_riga1, "id_asdrackcode", &
						 dw_groupage.getitemnumber(k_riga2, "id_asdrackcode"))

//			dw_lista_0.setitem(k_riga1, "meca_clie_2", &
//						 dw_groupage.getitemnumber(k_riga2, "clie_2"))
//			dw_lista_0.setitem(k_riga1, "prodotti_des", &
//						 dw_groupage.getitemstring(k_riga2, "des"))
//			dw_lista_0.setitem(k_riga1, "clienti_rag_soc_10", &
//						 dw_groupage.getitemstring(k_riga2, "rag_soc_10") + " " + string(dw_groupage.getitemnumber(k_riga2, "clie_2")))


end subroutine

public function boolean if_lotto_associato (ref st_tab_meca ast_tab_meca) throws uo_exception;//
//--- Controllo se Lotto gia' associato in WMF/E1
//--- inp: st_tab_meca.id
//--- torna: TRUE=associato
boolean k_return=false

	
try
	
	if ki_e1_enabled then
		
		//--- 031017 nella fase iniziale di passaggio a E1 meglio forzare a ASSOCIATI quelli precedenti
		if ast_tab_meca.data_int < kkg.DATA_START_E1 then
			k_return = true
		else
//			if kiuf_armo.if_lotto_pianificato(ast_tab_meca) then  // se qlc barcode del Lotto già messo in pianificazione allora significa già ASSOCIATO!
//				k_return = true
//			else
//		//--- controllo su E1 se lotto ASSOCIATO		
//		
//				if kiuf_e1_asn.kids_e1_asn_x_schedule_l.find( "waapid = '" + string(ast_tab_meca.id) + "'", 1, kiuf_e1_asn.kids_e1_asn_x_schedule_l.rowcount( ) ) > 0 then
//					k_return = true
//				end if
//			end if
		
			k_return = kiuf_armo.if_lotto_associato(ast_tab_meca)
		end if

	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally

end try
			
return k_return
end function

protected function string aggiorna_dati ();//
string k_return = "0 "


try
	dw_dett_0.accepttext()
	if dw_dett_0.rowcount() > 0 then
	
	//--- Aggiornamento dei dati inseriti/modificati
		k_return = super::aggiorna_dati()
		
	end if
	
catch (uo_exception kuo_exception)
	
end try

return k_return 

end function

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati

//=========================================================================
st_tab_pl_barcode kst_tab_pl_barcode
kuf_pl_barcode kuf1_pl_barcode

//--- lancia la funzione ereditata
super::attiva_tasti_0( )

cb_modifica.enabled = false
cb_visualizza.enabled = false
//cb_file.enabled = false


if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento &
   or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
	cb_aggiorna.enabled = true
	cb_togli.enabled = true
	cb_aggiungi.enabled = true
	cb_cancella.enabled = true
	cb_chiudi.enabled = ki_chiudi_PL_enabled 
//	cb_file.enabled = true
else
	cb_aggiorna.enabled = false
	cb_togli.enabled = false
	cb_aggiungi.enabled = false
	cb_chiudi.enabled = ki_chiudi_PL_enabled
	cb_cancella.enabled = false
end if



end subroutine

public subroutine u_obj_visible_0 ();//
dw_meca.visible = true
dw_barcode.visible = true
dw_groupage.visible = true
dw_lista_0.visible = true

end subroutine

public function boolean u_resize_predefinita ();//---
int k_dist_bordi, k_spess_bordi_x, k_spess_bordi_y

	this.setredraw(false)
//	
////--- dimensione+posizione box delle Proprietà
//	if ki_st_open_w.flag_primo_giro = "S" then
//		dw_dett_0.width = 2600
//		dw_dett_0.height = 1000
//		dw_dett_0.x = (this.width - dw_dett_0.width) / 2
//		dw_dett_0.y = (this.height - dw_dett_0.height) / 2
//	end if
//	
//	if ki_st_open_w.flag_adatta_win = KKG.ADATTA_WIN &
//						and not(ki_personalizza_pos_controlli) &
//		then

		
		k_dist_bordi = 5
		k_spess_bordi_x = 0 //145
		k_spess_bordi_y = 0 //210 //180
		
		dw_meca.width = this.width * 0.62 
//		dw_dett_0.width = this.width - dw_meca.width - k_dist_bordi * 3 - k_spess_bordi_x
		dw_barcode.width = dw_meca.width * 0.57 
		dw_lista_0.width = this.width - dw_meca.width - k_dist_bordi * 3 - k_spess_bordi_x 
		dw_groupage.width = this.width - dw_barcode.width - dw_lista_0.width - k_dist_bordi * 3 - k_spess_bordi_x
	
		dw_meca.height = this.height * 0.53
		dw_barcode.height = this.height - dw_meca.height - k_dist_bordi * 3 - k_spess_bordi_y
		dw_groupage.height = dw_barcode.height 
	
		//dw_dett_0.height = this.height * 0.23 
		dw_lista_0.height = this.height - k_dist_bordi * 3 - k_spess_bordi_y
	
//=== Posiziona dw nella window 
		dw_meca.x = 5
		dw_meca.y = 5
		dw_barcode.x = dw_meca.x
		dw_barcode.y = dw_meca.height + k_dist_bordi 
		dw_groupage.x = dw_meca.x + dw_barcode.width + k_dist_bordi
		dw_groupage.y = dw_meca.height + k_dist_bordi 

		//dw_dett_0.x = dw_meca.x + dw_meca.width + k_dist_bordi
		//dw_dett_0.y = dw_meca.y 
		dw_lista_0.x = dw_meca.x + dw_meca.width + k_dist_bordi
		dw_lista_0.y = k_dist_bordi  //dw_dett_0.height + k_dist_bordi 
		
		
		
//	end if

	this.setredraw(true)

return TRUE

end function

private subroutine u_check_troppi_barcode ();//---
//--- Verifica se ci sono troppi bacode in programmazione
//---
int k_max_barcode = 300, k_n_barcode_presenti


k_n_barcode_presenti =  dw_lista_0.rowcount( )

if k_n_barcode_presenti > k_max_barcode then
	messagebox("Avvertimento",  string( k_n_barcode_presenti) + " superato limite n. dei barcode. Il Programma " + &
	               	"rischia di non essere caricato in Impianto. Si consiglia di Chiuderlo Inviarlo al Pilota e di proseguire " + &
					"con una nuova Programmazione.", stopsign!)
end if

	
end subroutine

private subroutine copia_dw_barcode_to_dw_groupage (integer k_riga1, integer k_riga2) throws uo_exception;//--- copia dalla dw_barcode in dw del groupage 
//--- parametri: riga1 riga della dw1
//---            riga2 riga della dw2
//---
st_tab_barcode kst_tab_barcode
st_esito kst_esito
kuf_barcode kuf1_barcode
int k_rcn
	
	
	try 
		kuf1_barcode = create kuf_barcode
		kst_tab_barcode.barcode = dw_barcode.getitemstring(k_riga2, "barcode_barcode")
		if not kuf1_barcode.get_padre(kst_tab_barcode) then
			kst_tab_barcode.barcode_lav = " "
		end if
		if kuf1_barcode.if_barcode_padre(kst_tab_barcode) then
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlcode = 0
			kst_esito.sqlerrtext = "Il barcode " + kst_tab_barcode.barcode + " utilizzato come figlio risulta già 'padre'. Operazione non consentita!"
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	
		dw_groupage.setitem(k_riga1, "barcode_lav",  kst_tab_barcode.barcode_lav)
		dw_groupage.setitem(k_riga1, "barcode_barcode",  dw_barcode.getitemstring(k_riga2, "barcode_barcode"))
		dw_groupage.setitem(k_riga1, "barcode_tipo_cicli", dw_barcode.getitemstring(k_riga2, "barcode_tipo_cicli"))
		k_rcn = dw_groupage.getitemnumber(k_riga1, "barcode_fila_1")
		k_rcn = dw_barcode.getitemnumber(k_riga2, "barcode_fila_1")
		dw_groupage.setitem(k_riga1, "barcode_fila_1", dw_barcode.getitemnumber(k_riga2, "barcode_fila_1"))
		dw_groupage.setitem(k_riga1, "barcode_fila_2", dw_barcode.getitemnumber(k_riga2, "barcode_fila_2"))
		dw_groupage.setitem(k_riga1, "barcode_fila_1p", &
					 dw_barcode.getitemnumber(k_riga2, "barcode_fila_1p"))
		dw_groupage.setitem(k_riga1, "barcode_fila_2p", &
					 dw_barcode.getitemnumber(k_riga2, "barcode_fila_2p"))
		dw_groupage.setitem(k_riga1, "barcode_num_int", &
					 dw_barcode.getitemnumber(k_riga2, "barcode_num_int"))
		dw_groupage.setitem(k_riga1, "barcode_data_int", &
					 dw_barcode.getitemdate(k_riga2, "barcode_data_int"))
		dw_groupage.setitem(k_riga1, "dose", &
					 dw_barcode.getitemnumber(k_riga2, "armo_dose"))
		dw_groupage.setitem(k_riga1, "peso_kg", &
					 dw_barcode.getitemnumber(k_riga2, "armo_peso_kg"))
		dw_groupage.setitem(k_riga1, "larg_2", &
					 dw_barcode.getitemnumber(k_riga2, "armo_larg_2"))
		dw_groupage.setitem(k_riga1, "lung_2", &
					 dw_barcode.getitemnumber(k_riga2, "armo_lung_2"))
		dw_groupage.setitem(k_riga1, "alt_2", &
					 dw_barcode.getitemnumber(k_riga2, "armo_alt_2"))
		dw_groupage.setitem(k_riga1, "pedane", &
					 dw_barcode.getitemnumber(k_riga2, "armo_pedane"))
		dw_groupage.setitem(k_riga1, "campione", &
					 dw_barcode.getitemstring(k_riga2, "armo_campione"))
		dw_groupage.setitem(k_riga1, "art", &
					 dw_barcode.getitemstring(k_riga2, "armo_art"))
//			dw_groupage.setitem(k_riga1, "armo_cod_sl_pt", &
//						 dw_barcode.getitemstring(k_riga2, "armo_cod_sl_pt"))
		dw_groupage.setitem(k_riga1, "area_mag", &
					 dw_barcode.getitemstring(k_riga2, "meca_area_mag"))
		dw_groupage.setitem(k_riga1, "id_armo", &
					 dw_barcode.getitemnumber(k_riga2, "armo_id_armo"))
		dw_groupage.setitem(k_riga1, "id_meca", &
					 dw_barcode.getitemnumber(k_riga2, "id_meca"))

		dw_groupage.setitem(k_riga1, "e1ancodrs", &
					 dw_barcode.getitemstring(k_riga2, "e1ancodrs"))

		dw_groupage.setitem(k_riga1, "k_densita", &
					 dw_barcode.getitemnumber(k_riga2, "k_densita"))
		dw_groupage.setitem(k_riga1, "id_asdrackcode", &
					 dw_barcode.getitemnumber(k_riga2, "id_asdrackcode"))

//			dw_groupage.setitem(k_riga1, "clie_2", &
//						 dw_barcode.getitemnumber(k_riga2, "meca_clie_2"))
//			dw_groupage.setitem(k_riga1, "des", &
//						 dw_barcode.getitemstring(k_riga2, "prodotti_des"))
//			dw_groupage.setitem(k_riga1, "rag_soc_10", &
//						 dw_barcode.getitemstring(k_riga2, "k_ricevente"))

		
	catch (uo_exception kuo_exception)
		throw kuo_exception
//		kuo_exception.messaggio_utente()
		
	finally 
		destroy kuf1_barcode
		
	end try

end subroutine

private subroutine u_aggiungi_barcode_tutti (ref datawindow adw_out);//
//=== Aggiungi tutti i BARCODE del Lotto alla lista dei Barcode Pianificati / Groupage
//===  dw_meca ----> adw_out (dw_lista o dw_groupage)
//
long k_row_meca, k_row
long k_row_out
st_esito kst_esito


SetPointer(kkg.pointer_attesa)

try

	k_row_meca = dw_meca.getselectedrow(0)

	if k_row_meca = 0 then	
		messagebox("Nessuna Operazione Eseguita", "Selezionare una riga dall'elenco." +"~n~r", StopSign!)
	else

		dw_lista_0.setredraw(false)

		do while k_row_meca > 0 
		
			k_row_out = u_aggiungi_barcode_tutti_1(k_row_meca, adw_out)
		
			k_row_meca = dw_meca.getselectedrow(k_row_meca) 

		loop
		
		dw_lista_0.setredraw(true)

//--- rimuove le righe dall'elenco
		k_row_meca = dw_meca.getselectedrow(0)
		if k_row_meca > 0 then

			do while k_row_meca > 0 
				dw_meca.selectrow(k_row_meca, false)
				dw_meca.deleterow(k_row_meca)
				k_row_meca = dw_meca.getselectedrow(0) 
			loop
				
//--- se i barcode in dw_lista hanno figli li aggiunge al dw_groupage			
//			aggiungi_figli_dal_dw_lista(0)
			
			u_check_troppi_barcode( )
			u_crash_dw_lista_0_backup( )  // fa il backup per ripri da eventuale crash


			adw_out.setcolumn(1)
			adw_out.setfocus()
			if k_row_out > 0 then
				adw_out.selectrow(0, false)
				adw_out.setrow(k_row_out)
				adw_out.scrolltorow(k_row_out) 
				adw_out.selectrow(k_row_out, true)
			end if
			
		end if

	end if

catch(uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally	

	
end try

SetPointer(kkg.pointer_default)

end subroutine

private subroutine u_aggiungi_barcode_padre (st_tab_barcode kst_tab_barcode);//---
//---   Aggiunge nel Groupage il Barcode padre su questo Barcode
//---
long k_riga
st_tab_barcode kst_tab_barcode_save
st_esito kst_esito
st_tab_asdrackbarcode kst_tab_asdrackbarcode, kst_tab_asdrackbarcode_1


kst_esito = kguo_exception.inizializza(this.classname())
k_riga = dw_groupage.getrow()

ki_lista_0_modifcato = true

if k_riga > 0 then
	//kuf1_barcode = create kuf_barcode
	
	if Len(trim(dw_groupage.object.barcode_lav[k_riga])) > 0 then
		kst_tab_barcode_save.barcode = trim(dw_groupage.object.barcode_lav[k_riga])
	else
		kst_tab_barcode_save.barcode = ""
	end if
	
	dw_groupage.object.barcode_lav[k_riga] = kst_tab_barcode.barcode
	kst_tab_barcode.barcode_lav = kst_tab_barcode.barcode
	kst_tab_barcode.barcode = dw_groupage.object.barcode_barcode[k_riga]
	
//--- Verifica se i barcode hanno lo stesso Dispositivo Ausiliario 
	try
		kst_tab_asdrackbarcode.barcode = kst_tab_barcode.barcode
		kst_tab_asdrackbarcode_1.barcode = kst_tab_barcode.barcode_lav
		if not kiuf_asdrackbarcode.if_barcode_same_asddevice(kst_tab_asdrackbarcode, kst_tab_asdrackbarcode_1) then
			kst_esito.esito = kkg_esito.no_esecuzione
		end if

	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		
	end try
	
//--- aggiorno sul Figlio l'indicazione del PADRE
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then
		kst_esito = kiuf_barcode.tb_aggiungi_figlio(kst_tab_barcode)	
	end if
	
	if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
		kguo_exception.set_esito(kst_esito)
		kguo_exception.messaggio_utente()
	else
		
//--- tolgo dall'eventuale vecchio padre il flag di GROUPAGE
		if Len(trim(kst_tab_barcode_save.barcode)) > 0 then
	
			kst_esito = kiuf_barcode.tb_togli_figlio_al_padre(kst_tab_barcode_save)	
			
			if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
				kguo_exception.set_esito(kst_esito)
				kguo_exception.messaggio_utente()
			end if
		end if
		
//--- aggiorno sul padre il flag di GROUPAGE
		kst_tab_barcode.barcode = kst_tab_barcode.barcode_lav
		kst_esito = kiuf_barcode.tb_set_padre(kst_tab_barcode)	
		
		if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
			kguo_exception.set_esito(kst_esito)
			kguo_exception.messaggio_utente()
		end if
		
	end if
	
//	destroy kuf1_barcode
end if

end subroutine

private subroutine u_abilita_modifica_giri (st_tab_barcode ast_tab_barcode);//
//--- controllo autorizzazione x cambio giri di lavorazione
//


	try

		//ki_modifica_cicli_enabled = kuf1_barcode_mod_giri.ki_modifica_cicli_enabled
		//if ki_modifica_cicli_enabled = kuf1_barcode_mod_giri.ki_modifica_cicli_enabled_modif &
		if kiuf_barcode_mod_giri.autorizza_modifica_giri(ast_tab_barcode, kiuf_barcode_mod_giri.ki_modifica_giri_pianificati_si) &
			   and (trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento &
			   		or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica) &
			then
			kiuf_barcode_mod_giri.ki_modifica_cicli_enabled = kiuf_barcode_mod_giri.ki_modifica_cicli_enabled_modif
		else
			kiuf_barcode_mod_giri.ki_modifica_cicli_enabled = kiuf_barcode_mod_giri.ki_modifica_cicli_enabled_visualizzazione
		end if

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()			
		//cb_file.enabled = false
		kiuf_barcode_mod_giri.ki_modifica_cicli_enabled = kiuf_barcode_mod_giri.ki_modifica_cicli_enabled_visualizzazione
		
	finally			
		
	end try

end subroutine

public subroutine u_aggiungi_barcode_singolo (ref datawindow adw_out, ref datawindow adw_inp);/*
   Aggiungi un BARCODE alla lista dei Pianificati
   adw_inp (dw_barcode/dw_groupage) -----> adw_out (dw_lista_0)
*/
long k_riga_dw_lista_0, k_insertrow, k_riga_drag, k_riga_ultima=0, k_riga_find=0
long k_riga_meca
int k_ctr, k_rc
//boolean k_elabora=true, k_blocca_operazione=false
st_tab_barcode kst_tab_barcode, kst_tab_barcode_padre
st_tab_meca kst_tab_meca
st_tab_asdrackbarcode kst_tab_asdrackbarcode
st_esito kst_esito
//kuf_barcode kuf1_barcode
kuf_sl_pt kuf1_sl_pt
//kuf_barcode_mod_giri kuf1_barcode_mod_giri
	

try
//	kuf1_barcode = create kuf_barcode
	kst_esito = kguo_exception.inizializza(this.classname())

	ki_lista_0_modifcato = true

	if adw_inp.rowcount() = 0 then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Nessun barcode da Pianificare in elenco '" + trim(adw_inp.title) + "'"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	k_riga_dw_lista_0 = adw_out.getselectedrow(0)  // riga dove inserire i barcode da pianificare

	k_riga_drag = adw_inp.getselectedrow(0) 			

//--- Controllo se Barcode ancora da Associare in WM
	kst_tab_meca.id = 0
	kst_tab_meca.num_int = adw_inp.object.barcode_num_int[k_riga_drag]   
	if kst_tab_meca.num_int > 0 then
		k_riga_meca = dw_meca.find( "meca_num_int = " + string(kst_tab_meca.num_int), 1, dw_meca.rowcount() )
		if k_riga_meca > 0 then
			kst_tab_meca.id = dw_meca.object.id_meca[k_riga_meca]
			kst_tab_meca.data_int = dw_meca.object.meca_data_int[k_riga_meca] 

//--- Controllo se Riferimento 'IN ATTENZIONE' : probabile grp pertanto espongo un msg
			if dw_meca.getitemnumber(k_riga_meca, "stato_in_attenzione") = 1 then
				if messagebox("Pianificazione", &
									"Lotto n. " + string(kst_tab_meca.num_int) &
									+ " è 'IN ATTENZIONE'  -   NON sarebbe ancora da TRATTARE." &
									+ "~n~rPianificare il barcode comunque ?", Question!, yesno!, 1) = 2 then
					throw kguo_exception
				end if
			end if
		end if
	end if
				
//--- Controllo se Barcode ancora da Associare al barcode CLIENTE in WMF/E1
	if kst_tab_meca.id > 0 then
		if not if_lotto_associato(kst_tab_meca) then
	
			kst_tab_meca.num_int = adw_inp.object.barcode_num_int[k_riga_drag]
			kguo_exception.inizializza( )
			if ki_consenti_lavoraz_non_associati_wmf then
				kguo_exception.messaggio_utente( "Avvertimento", "Lotto " + string(kst_tab_meca.num_int ) + " non è stato 'Associato' ('20') - Operazione consentita grazie al consenso impostato a menu.")
			else
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.sqlerrtext = "Lotto " + string(kst_tab_meca.num_int ) + " non è stato 'Associato' ('20). Lotto non ancora trattabile!"
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if

//--- altre verifiche
	do while k_riga_drag > 0 //and k_elabora
		kst_tab_barcode_padre.barcode = adw_inp.object.barcode_barcode[k_riga_drag]
				
//--- NON è possibile mettere tra i padri un FIGLIO!!!			
		if kiuf_barcode.if_barcode_figlio(kst_tab_barcode_padre) then
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Barcode '" + trim(kst_tab_barcode_padre.barcode) + "' già raggruppato al Padre '" + kst_tab_barcode_padre.barcode_lav + "' per il Trattamento. Operazione non consentita."
			kguo_exception.set_esito(kst_esito)
			kguo_exception.messaggio_utente( )
			adw_inp.selectrow(k_riga_drag, false)
			//k_elabora=false  // barcode da NON pianificare
		else
//--- Il barcode è stato associato al RACK insieme a tutti gli altri del Lotto? (se necessario)
			kst_tab_asdrackbarcode.barcode = kst_tab_barcode_padre.barcode
			if not kiuf_asdrackbarcode.if_barcode_is_associated(kst_tab_asdrackbarcode) then
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.sqlerrtext = "Prima di aggiungere il barcode '" + trim(kst_tab_barcode_padre.barcode) + "' schermarlo. Operazione non consentita." //~n~r"
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			kst_tab_asdrackbarcode.barcode = kst_tab_barcode_padre.barcode
			if not kiuf_asdrackbarcode.if_barcode_only_existing_father(kst_tab_asdrackbarcode) then
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.sqlerrtext = "Attenzione ci sono più barcode PADRI come il '" + trim(kst_tab_asdrackbarcode.barcode) + "' associati a questa schermatura (id " &
	                        + string(kst_tab_asdrackbarcode.id_asdrackcode) + "). E' consentito un solo barcode 'padre' gli altri devono essere spostati in groupage." &
									+ kkg.acapo + "Operazione non consentita." 
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			
		end if

//--- leggo la successiva!
		k_riga_drag = adw_inp.getselectedrow(k_riga_drag)
	loop

	adw_out.setredraw(false)

//--- Devo Modificare i GIRI?
	k_riga_drag = adw_inp.getselectedrow(0)
	do while k_riga_drag > 0 //and k_elabora
//--- se ciclo normale a scelta devo effettuare prima la scelta
		kiuf_barcode.get_tipo_cicli(kst_tab_barcode_padre)
		if kst_tab_barcode_padre.tipo_cicli = kuf1_sl_pt.ki_tipo_cicli_a_scelta then

//--- prima di pianificare scegliere i GIRI in modo puntale					
			//modifica_giri(kuf1_barcode_mod_giri.ki_modalita_modifica_scelta_fila, k_riga_drag,  adw_inp) //ki_dw_fuoco_nome)
			if u_modifica_giri(adw_inp, k_riga_drag) then

//--- se non ho modificato i giri salto il barcode					
			//	adw_inp.reselectrow(k_riga_drag)
			//kuf1_barcode.get_tipo_cicli(kst_tab_barcode_padre)
			//if kst_tab_barcode_padre.tipo_cicli = kuf1_sl_pt.ki_tipo_cicli_a_scelta then
			else
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.sqlerrtext = "Modifica giri Barcode interrotta dall'utente."
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if 
//		else
//			adw_inp.reselectrow(k_riga_drag)
		end if
		k_riga_dw_lista_0 = adw_out.insertrow(k_riga_dw_lista_0 + 1)
		if k_riga_dw_lista_0 < 0 then
			kst_esito.esito = kkg_esito.ko
			kst_esito.sqlerrtext = "Inserimento barcode in pianificazione fallito: '" + trim(kst_tab_barcode_padre.barcode ) + "'"
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		k_riga_ultima = k_riga_dw_lista_0 
				
//--- copia la dw2 in dw1, il formato e' la solito dettaglio		
		if adw_inp.dataobject = dw_groupage.dataobject then
			copia_dw_groupage_to_dw_lista_0(k_riga_dw_lista_0, k_riga_drag)
		else
			copia_dw_barcode_to_dw_lista_0(k_riga_dw_lista_0, k_riga_drag)
		end if
				
//--- se i barcode in dw_lista hanno figli li aggiunge al dw_groupage			
		u_aggiungi_figli_dal_dw_lista(k_riga_dw_lista_0)
		
		screma_lista_from_dw_lista(k_riga_dw_lista_0)  // screma dw_meca

		adw_inp.deleterow(k_riga_drag) 
		k_riga_drag --

//--- leggo la successiva!
		k_riga_drag = adw_inp.getselectedrow(k_riga_drag)
	loop
	
	
	if k_riga_ultima > 0 then
//--- sistema il codice e i progressivi nella lista
		imposta_codice_progr( adw_out )

		adw_out.selectrow(0, false)
		adw_out.setrow(k_riga_ultima)
		adw_out.selectrow(k_riga_ultima, true)
		adw_out.scrolltorow(k_riga_ultima)

		if adw_inp.dataobject = dw_barcode.dataobject then
			screma_lista_dw_barcode() // rimuove da dw_barcode quelli già in dw_lista+dw_groupage
		end if
		
//		if ki_refresh_dw_meca_needed then
//			ki_refresh_dw_meca_needed = false
//			ki_riga_pos_dw_meca = dw_meca.getselectedrow(0)  //cattura la riga selezionata
////			kids_meca_orig.reset()
//			leggi_liste()
//			if ki_refresh_dw_meca_needed then
//				retrieve_figli( )  // aggiorna elenco figli 
//			end if
//		else
//			screma_lista_riferimenti()
//		end if
		adw_out.setcolumn(1)
		adw_out.setfocus()

		u_check_troppi_barcode( )
		u_crash_dw_lista_0_backup( )  // fa il backup per ripri da eventuale crash
		
	end if

	adw_out.setredraw(true)
		
//	attiva_tasti()

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	if kst_esito.esito <> kkg_esito.ok then
		kuo_exception.messaggio_utente()
	end if
	
finally
//	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	

end try 



end subroutine

private function long u_aggiungi_barcode_tutti_1 (long a_row, ref datawindow adw_out);//
//--- Aggiungi tutti i BARCODE del Lotto alla lista dei Barcode Pianificati (padri o groupage)
//--- inp: a_row: riga del dw_meca
//---      adw_out: dw_lista o dw_groupage
//--- Return: l'ultima riga inserita in elenco 
//
long k_row_adw_out, k_insertrow, k_riga_drag
long k_rows_barcode
long k_row_orig
st_esito kst_esito
st_tab_barcode kst_tab_barcode
st_tab_meca kst_tab_meca
//kuf_barcode kuf1_barcode
//kuf_sl_pt kuf1_sl_pt


SetPointer(kkg.pointer_attesa)

kst_esito = kguo_exception.inizializza(this.classname())
//kuf1_barcode = create kuf_barcode

	
try 

	kst_tab_meca.id = dw_meca.getitemnumber(a_row, "id_meca")
	kst_tab_meca.num_int = dw_meca.getitemnumber(a_row, "meca_num_int")
	kst_tab_meca.data_int = dw_meca.getitemdate(a_row, "meca_data_int")

	//dw_meca.scrolltorow(a_row)

//--- controlla se Lotto (barcode) da mettere in pianificazione	
	k_row_orig = a_row
	a_row = u_aggiungi_barcode_tutti_check(kst_tab_meca, a_row)	

	if a_row = 0 then
		dw_meca.selectrow(k_row_orig, false) // event u_selectrow_false(k_row_orig) // Toglie la riga dalle selezionate
	else

//--- riga di partenza dove inserire i barcode da trattare
		if adw_out.rowcount() > 0 and adw_out.getselectedrow(0) > 0 then
			k_row_adw_out = adw_out.getselectedrow(0)
		else
			k_row_adw_out = 0
		end if
		
		//dw_meca.scrolltorow(a_row)
		
//--- sposto tutti i barcode del lotto		
		k_rows_barcode = dw_barcode.rowcount()
		for k_riga_drag = 1 to k_rows_barcode
	
			kst_tab_barcode.barcode = dw_barcode.getitemstring(k_riga_drag, "barcode_barcode")
	
			choose case adw_out.classname()
					
				case "dw_lista_0" 
	//--- NON è possibile mettere tra i padri un FIGLIO!!!			
					if NOT kiuf_barcode.if_barcode_figlio(kst_tab_barcode) then
						k_row_adw_out = adw_out.insertrow(k_row_adw_out + 1)
						copia_dw_barcode_to_dw_lista_0(k_row_adw_out, k_riga_drag)
						
						u_aggiungi_figli_dal_dw_lista(k_row_adw_out)
						
						//screma_lista_from_dw_lista(k_row_adw_out)  // screma dw_meca
						
					end if
					
				case "dw_groupage" 
					k_row_adw_out = adw_out.insertrow(k_row_adw_out + 1)
					copia_dw_barcode_to_dw_groupage(k_row_adw_out, k_riga_drag)
					//screma_lista_from_dw_groupage(k_row_adw_out)  // screma dw_meca
		
			end choose
		
		next 
		
		ki_lista_0_modifcato = true

		//dw_meca.deleterow(a_row) // Toglie la riga da elenco generale lotti
	end if	
	
	dw_barcode.reset( ) // Toglie le righe inserite da elenco BARCODE

//--- probabile messaggio di solo avvertimento
	if kst_esito.esito <> kkg_esito.ok then
		kguo_exception.messaggio_utente()
	end if

	
catch(uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	if kst_esito.esito <> kkg_esito.ok then
		throw kuo_exception
	end if

finally
//	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	if not ki_refresh_dw_meca_needed then
		attiva_tasti()
	end if

	SetPointer(kkg.pointer_default)	
	
end try 
	
return k_row_adw_out
end function

private subroutine u_refresh_dw ();//
st_esito kst_esito
uo_exception kuo_exception

choose case  kidw_selezionata.dataobject 


//	case "d_pl_barcode_dett_1"
//		kst_esito = retrieve_padri()
//		if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn  then
//			kuo_exception.set_esito( kst_esito)
//			kuo_exception.messaggio_utente()
//		end if

	case "d_pl_barcode_dett_grp_all"
		kst_esito = retrieve_figli_all()
		if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn  then
			kuo_exception.set_esito( kst_esito)
			kuo_exception.messaggio_utente()
		end if

	case else
		//u_rilegge_no_lav()
		ki_riga_pos_dw_meca = dw_meca.getrow( )  //cattura la riga selezionata
//		if ki_riga_pos_dw_meca > 0 then
//			ki_id_meca_pos_dw_meca = dw_meca.getitemnumber( ki_riga_pos_dw_meca, "id_meca")
//		end if
//		kids_meca_orig.reset()
		leggi_liste()


end choose

dw_barcode.reset()

attiva_tasti( )

end subroutine

private subroutine modifica_giri_old (string a_modalita_modifica_file, long a_riga, ref datawindow a_dw_modifica_giri);////
////--- a_modalita_modifica_file: 1=modalità modifica giri fila 1 e 2 
////--- a_riga = riga sulla quale modificare
////--- a_dw_modifica_giri = dw su cui fare la modifica giri
////
//integer k_rec , k_riga
////string k_dw_fuoco_nome
//string k_aggiorna_rif
//line kline_1
//st_esito kst_esito
//st_tab_barcode kst_tab_barcode 
////kuf_barcode kuf1_barcode
//datawindow kidw_barcode_da_non_modificare
//datastore kds_kicursor_barcode_1
//st_barcode_mod_giri kst_barcode_mod_giri
//kuf_barcode_mod_giri kuf1_barcode_mod_giri
//int k_modif_tutto_riferimento
//
//
////if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
//
////--- valorizza la dw sulla quale fare la modifica
//	kidw_x_modifica_giri = a_dw_modifica_giri //la dw selezionata
//	kidw_barcode_da_non_modificare = dw_lista_0 // i barcode in programmazione non devono essere modificati
//	k_modif_tutto_riferimento = kuf1_barcode_mod_giri.ki_modif_tutto_riferimento_no
//	
//	choose case a_dw_modifica_giri.dataobject
//
//		case dw_meca.dataobject // "d_meca_barcode_elenco_no_lav"
//			k_modif_tutto_riferimento = kuf1_barcode_mod_giri.ki_modif_tutto_riferimento_si
//			//k_riga = dw_meca.getrow() 
//			if a_riga > 0 then
//				kst_tab_barcode.barcode = " "
//				kst_tab_barcode.pl_barcode = dw_dett_0.getitemnumber(1, "codice")
//				if isnull(kst_tab_barcode.pl_barcode) then kst_tab_barcode.pl_barcode = 0
//				kst_tab_barcode.id_meca = dw_meca.getitemnumber(a_riga, "id_meca")
//				kst_tab_barcode.num_int = dw_meca.getitemnumber(a_riga, "meca_num_int")
//				kst_tab_barcode.data_int = dw_meca.getitemdate(a_riga, "meca_data_int")
//				kst_tab_barcode.fila_1 = dw_meca.getitemnumber(a_riga, "barcode_fila_1")
//				kst_tab_barcode.fila_1p = dw_meca.getitemnumber(a_riga, "barcode_fila_1p")
//				kst_tab_barcode.fila_2 = dw_meca.getitemnumber(a_riga, "barcode_fila_2")
//				kst_tab_barcode.fila_2p = dw_meca.getitemnumber(a_riga, "barcode_fila_2p")
//				
//				//kuf1_barcode = create kuf_barcode
//				//kuf1_barcode.kist_tab_barcode = kst_tab_barcode
//				//kuf1_barcode.kist_tab_barcode.barcode = "*"
//				//kst_esito = kuf1_barcode.kicursor_barcode_1_open()
//				
//				kds_kicursor_barcode_1 = create datastore 
//				kds_kicursor_barcode_1.dataobject = "ds_barcode_cursor_1"
//				kds_kicursor_barcode_1.settransobject(kguo_sqlca_db_magazzino)
//				if kds_kicursor_barcode_1.retrieve("*", kst_tab_barcode.pl_barcode, kst_tab_barcode.id_meca &
//																	, kst_tab_barcode.fila_1, kst_tab_barcode.fila_1p &
//																	, kst_tab_barcode.fila_2, kst_tab_barcode.fila_2p) > 0 then
//		
//					kst_tab_barcode.barcode = "*"
//				end if
//				//if kst_esito.esito = kkg_esito.ok then
//				//	kst_esito = kuf1_barcode.kicursor_barcode_1_fetch()
//				//	if kst_esito.esito = kkg_esito.ok then
//				//		kst_tab_barcode.barcode = kuf1_barcode.kist_tab_barcode.barcode 
//				//	end if
//				//end if
//				//kst_esito = kuf1_barcode.kicursor_barcode_1_close ()
//				//destroy kuf1_barcode
//
//				kst_tab_barcode.pl_barcode = dw_dett_0.getitemnumber(1, "codice") 
//				if isnull(kst_tab_barcode.pl_barcode) then kst_tab_barcode.pl_barcode = 0
//	
//			end if			
//
//		case dw_barcode.dataobject // "d_barcode_l_no_pl"
////--- se sono in modalita di modifica riga e ho selezionato piu' righe passo alla modalita
////--- modifica piu' righe
//			if a_modalita_modifica_file = kuf1_barcode_mod_giri.ki_modalita_modifica_giri_riga then
//			     k_riga = dw_barcode.getselectedrow(0)
//				if a_riga > 0 then
//				   k_riga = dw_barcode.getselectedrow(k_riga)
//					if k_riga > 0 then
//						a_modalita_modifica_file = kuf1_barcode_mod_giri.ki_modalita_modifica_giri_righe
//					end if
//				end if
//			end if
//			//k_riga = dw_barcode.getrow() 
//			if a_riga > 0 then		
//				kst_tab_barcode.pl_barcode = dw_dett_0.getitemnumber(1, "codice")
//				kst_tab_barcode.id_meca = dw_barcode.getitemnumber(a_riga, "id_meca")
//				kst_tab_barcode.barcode = dw_barcode.getitemstring(a_riga, "barcode_barcode")
//				kst_tab_barcode.num_int = dw_barcode.getitemnumber(a_riga, "barcode_num_int")
//				kst_tab_barcode.data_int = dw_barcode.getitemdate(a_riga, "barcode_data_int")
//				kst_tab_barcode.fila_1 = dw_barcode.getitemnumber(a_riga, "barcode_fila_1")
//				kst_tab_barcode.fila_1p = dw_barcode.getitemnumber(a_riga, "barcode_fila_1p")
//				kst_tab_barcode.fila_2 = dw_barcode.getitemnumber(a_riga, "barcode_fila_2")
//				kst_tab_barcode.fila_2p = dw_barcode.getitemnumber(a_riga, "barcode_fila_2p")
//			end if	
//
//		case dw_groupage.dataobject // "d_pl_barcode_dett_grp_all" 
////--- se sono in modalita di modifica riga e ho selezionato piu' righe passo alla modalita
////--- modifica piu' righe
//			if a_modalita_modifica_file = kuf1_barcode_mod_giri.ki_modalita_modifica_giri_riga then
//			    k_riga = dw_groupage.getselectedrow(0)
//				if k_riga > 0 then
//				   k_riga = dw_groupage.getselectedrow(k_riga)
//					if k_riga > 0 then
//						a_modalita_modifica_file = kuf1_barcode_mod_giri.ki_modalita_modifica_giri_righe
//					end if
//				end if
//			end if
//			//k_riga = dw_groupage.getrow() 
//			if a_riga > 0 then		
//				kst_tab_barcode.pl_barcode = dw_dett_0.getitemnumber(1, "codice")
//				kst_tab_barcode.id_meca = dw_groupage.getitemnumber(a_riga, "id_meca")
//				kst_tab_barcode.barcode = dw_groupage.getitemstring(a_riga, "barcode_barcode")
//				kst_tab_barcode.num_int = dw_groupage.getitemnumber(a_riga, "barcode_num_int")
//				kst_tab_barcode.data_int = dw_groupage.getitemdate(a_riga, "barcode_data_int")
//				kst_tab_barcode.fila_1 = dw_groupage.getitemnumber(a_riga, "barcode_fila_1")
//				kst_tab_barcode.fila_1p = dw_groupage.getitemnumber(a_riga, "barcode_fila_1p")
//				kst_tab_barcode.fila_2 = dw_groupage.getitemnumber(a_riga, "barcode_fila_2")
//				kst_tab_barcode.fila_2p = dw_groupage.getitemnumber(a_riga, "barcode_fila_2p")
//			end if	
//
//
//		case dw_lista_0.dataobject //"d_pl_barcode_dett_1"
//			
//			setnull(kidw_barcode_da_non_modificare)
////--- se sono in modalita di modifica riga e ho selezionato piu' righe passo alla modalita
////--- modifica piu' righe
//			if a_modalita_modifica_file = kuf1_barcode_mod_giri.ki_modalita_modifica_giri_riga then
//			    k_riga = dw_lista_0.getselectedrow(0)
//				if k_riga > 0 then
//				   k_riga = dw_lista_0.getselectedrow(k_riga)
//					if k_riga > 0 then
//						a_modalita_modifica_file = kuf1_barcode_mod_giri.ki_modalita_modifica_giri_righe
//					end if
//				end if
//			end if
//			//k_riga = dw_lista_0.getrow() 
//			if a_riga > 0 then		
//				kst_tab_barcode.pl_barcode = dw_dett_0.getitemnumber(1, "codice")
//				kst_tab_barcode.id_meca = dw_lista_0.getitemnumber(a_riga, "id_meca")
//				kst_tab_barcode.barcode = dw_lista_0.getitemstring(a_riga, "barcode_barcode")
//				kst_tab_barcode.num_int = dw_lista_0.getitemnumber(a_riga, "barcode_num_int")
//				kst_tab_barcode.data_int = dw_lista_0.getitemdate(a_riga, "barcode_data_int")
//				kst_tab_barcode.fila_1 = dw_lista_0.getitemnumber(a_riga, "barcode_fila_1")
//				kst_tab_barcode.fila_1p = dw_lista_0.getitemnumber(a_riga, "barcode_fila_1p")
//				kst_tab_barcode.fila_2 = dw_lista_0.getitemnumber(a_riga, "barcode_fila_2")
//				kst_tab_barcode.fila_2p = dw_lista_0.getitemnumber(a_riga, "barcode_fila_2p")
//			end if	
//
//	end choose
//
//	if a_riga > 0 then
//
////		dw_modifica.modifica_giri(&
////										kst_tab_barcode &
////										,a_modalita_modifica_file &
////										,dw_modifica.ki_modif_tutto_riferimento &
////										,kidw_x_modifica_giri &
////										,kidw_barcode_da_non_modificare &
////										)
//
//		kst_barcode_mod_giri.ast_tab_barcode = kst_tab_barcode
//		kst_barcode_mod_giri.a_modalita_modifica_file = a_modalita_modifica_file
//		kst_barcode_mod_giri.a_modif_tutto_riferimento = k_modif_tutto_riferimento
//		kst_barcode_mod_giri.adw_x_modifica_giri = kidw_x_modifica_giri
//		kst_barcode_mod_giri.adw_barcode_da_non_modificare = kidw_barcode_da_non_modificare
//		
//		kuf1_barcode_mod_giri = create kuf_barcode_mod_giri
//		kuf1_barcode_mod_giri.u_open(kst_barcode_mod_giri)  // OPEN WINDOWS MODIFICA GIRI
//
//		if isvalid(kuf1_barcode_mod_giri) then destroy kuf1_barcode_mod_giri
//
//		retrieve_figli( )  // aggiorna elenco figli 
//		
//	else
//		messagebox("Modifica Cicli di Trattamento", &
//						"Selezionare una riga nella lista")
//	end if	
//
////else
////	messagebox("Modifica non permessa", &
////						"In questa modalita' non e' consentita la modifica dei dati")
////end if
//	 
//
////st_open_w kst_open_w
////kuf_menu_window kuf1_menu_window
//// //--- chiamare la window di elenco
//////
//////=== Parametri : 
//////=== struttura st_open_w
////			kst_open_w.id_programma = "brcd_rifer_f"
////			kst_open_w.flag_primo_giro = "S"
////			if ki_st_open_w.flag_modalita = "mo" or ki_st_open_w.flag_modalita = "in" then
//
////				kst_open_w.flag_modalita= "mo"
////			else
////				kst_open_w.flag_modalita= "vi"
////			end if
////			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
////			kst_open_w.flag_leggi_dw = " "
////			kst_open_w.flag_cerca_in_lista = " "
////			kst_open_w.key1 = string(kst_tab_barcode.num_int)
////			kst_open_w.key2 = string(kst_tab_barcode.data_int, "dd.mm.yyyy")
////			kst_open_w.key3 = "S"
////			kst_open_w.flag_where = " "
////			
////			kuf1_menu_window = create kuf_menu_window 
////			kuf1_menu_window.open_w_tabelle(kst_open_w)
////			destroy kuf1_menu_window
//
// 
//
end subroutine

public subroutine u_set_dw_icon ();//
dw_meca.icon = kidw_selezionata.ki_icona_normale
dw_barcode.icon = kidw_selezionata.ki_icona_normale
dw_groupage.icon = kidw_selezionata.ki_icona_normale
dw_lista_0.icon = kidw_selezionata.ki_icona_normale

if kidw_selezionata.dataobject = dw_meca.dataobject &
		or kidw_selezionata.dataobject = dw_barcode.dataobject &
		or kidw_selezionata.dataobject = dw_groupage.dataobject &
		or kidw_selezionata.dataobject = dw_lista_0.dataobject then

	kidw_selezionata.icon = kidw_selezionata.ki_icona_selezionata

end if

end subroutine

private function boolean u_modifica_giri (ref datawindow a_dw_modifica_giri, long a_riga);//
//--- a_modalita_modifica_file: 1=modalità modifica giri fila 1 e 2 
//--- a_riga = riga sulla quale modificare
//--- a_dw_modifica_giri = dw su cui fare la modifica giri
//--- OUT: TRUE = giri modificati
//---      i giri modificati li trovi in: kiuf_barcode_mod_giri.kist_barcode_mod_giri.ast_tab_barcode
//
boolean k_return
integer k_rec , k_riga
//string k_dw_fuoco_nome
string k_aggiorna_rif
st_esito kst_esito
st_tab_barcode kst_tab_barcode 
datawindow kidw_barcode_da_non_modificare
datastore kds_kicursor_barcode_1
st_barcode_mod_giri kst_barcode_mod_giri
int k_modif_tutto_riferimento


try
	
	kguo_exception.inizializza( this.classname())
	if a_riga > 0 then
		if a_riga > dw_meca.rowcount() then
			kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_internal_bug )
			kguo_exception.setmessage( "Modifica Giri Interrotta", "N. riga " + string(a_riga) + " troppo alta. Righe presenti in elenco " + string(dw_meca.rowcount()))
			throw kguo_exception
		end if
	else
		kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_dati_insufficienti )
		kguo_exception.setmessage( "Modifica Giri Interrotta", "Selezionare una riga dall'elenco")
		throw kguo_exception
	end if
	
//if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then

//--- valorizza la dw sulla quale fare la modifica
	kidw_x_modifica_giri = a_dw_modifica_giri //la dw selezionata
	kidw_barcode_da_non_modificare = dw_lista_0 // i barcode in programmazione non devono essere modificati
			
	kst_tab_barcode.pl_barcode = dw_dett_0.getitemnumber(1, "codice")
	if isnull(kst_tab_barcode.pl_barcode) then kst_tab_barcode.pl_barcode = 0
	
	choose case a_dw_modifica_giri.dataobject

		case dw_meca.dataobject // "d_meca_barcode_elenco_no_lav"
			kst_tab_barcode.id_meca = dw_meca.getitemnumber(a_riga, "id_meca")
			kst_tab_barcode.num_int = dw_meca.getitemnumber(a_riga, "meca_num_int")
			kst_tab_barcode.data_int = dw_meca.getitemdate(a_riga, "meca_data_int")
			kst_tab_barcode.fila_1 = dw_meca.getitemnumber(a_riga, "barcode_fila_1")
			kst_tab_barcode.fila_1p = dw_meca.getitemnumber(a_riga, "barcode_fila_1p")
			kst_tab_barcode.fila_2 = dw_meca.getitemnumber(a_riga, "barcode_fila_2")
			kst_tab_barcode.fila_2p = dw_meca.getitemnumber(a_riga, "barcode_fila_2p")
			
			kds_kicursor_barcode_1 = create datastore 
			kds_kicursor_barcode_1.dataobject = "ds_barcode_cursor_1"
			kds_kicursor_barcode_1.settransobject(kguo_sqlca_db_magazzino)
			if kds_kicursor_barcode_1.retrieve("*", kst_tab_barcode.pl_barcode, kst_tab_barcode.id_meca &
																, kst_tab_barcode.fila_1, kst_tab_barcode.fila_1p &
																, kst_tab_barcode.fila_2, kst_tab_barcode.fila_2p) > 0 then 
	
				kst_tab_barcode.barcode = "*"
			else
				kst_tab_barcode.barcode = " "
			end if

	
		case dw_barcode.dataobject // "d_barcode_l_no_pl"
			kst_tab_barcode.id_meca = dw_barcode.getitemnumber(a_riga, "id_meca")
			kst_tab_barcode.barcode = dw_barcode.getitemstring(a_riga, "barcode_barcode")
			kst_tab_barcode.num_int = dw_barcode.getitemnumber(a_riga, "barcode_num_int")
			kst_tab_barcode.data_int = dw_barcode.getitemdate(a_riga, "barcode_data_int")
			kst_tab_barcode.fila_1 = dw_barcode.getitemnumber(a_riga, "barcode_fila_1")
			kst_tab_barcode.fila_1p = dw_barcode.getitemnumber(a_riga, "barcode_fila_1p")
			kst_tab_barcode.fila_2 = dw_barcode.getitemnumber(a_riga, "barcode_fila_2")
			kst_tab_barcode.fila_2p = dw_barcode.getitemnumber(a_riga, "barcode_fila_2p")

		case dw_groupage.dataobject // "d_pl_barcode_dett_grp_all" 
////--- se sono in modalita di modifica riga e ho selezionato piu' righe passo alla modalita modifica piu' righe
//			if a_modalita_modifica_file = kiuf_barcode_mod_giri.ki_modalita_modifica_giri_riga then
//				k_riga = dw_groupage.getselectedrow(a_riga)
//				if k_riga > 0 then
//					a_modalita_modifica_file = kiuf_barcode_mod_giri.ki_modalita_modifica_giri_righe
//				end if
//			end if
			kst_tab_barcode.id_meca = dw_groupage.getitemnumber(a_riga, "id_meca")
			kst_tab_barcode.barcode = dw_groupage.getitemstring(a_riga, "barcode_barcode")
			kst_tab_barcode.num_int = dw_groupage.getitemnumber(a_riga, "barcode_num_int")
			kst_tab_barcode.data_int = dw_groupage.getitemdate(a_riga, "barcode_data_int")
			kst_tab_barcode.fila_1 = dw_groupage.getitemnumber(a_riga, "barcode_fila_1")
			kst_tab_barcode.fila_1p = dw_groupage.getitemnumber(a_riga, "barcode_fila_1p")
			kst_tab_barcode.fila_2 = dw_groupage.getitemnumber(a_riga, "barcode_fila_2")
			kst_tab_barcode.fila_2p = dw_groupage.getitemnumber(a_riga, "barcode_fila_2p")


		case dw_lista_0.dataobject //"d_pl_barcode_dett_1"
			kidw_barcode_da_non_modificare.reset( )
			kst_tab_barcode.id_meca = dw_lista_0.getitemnumber(a_riga, "id_meca")
			kst_tab_barcode.barcode = dw_lista_0.getitemstring(a_riga, "barcode_barcode")
			kst_tab_barcode.num_int = dw_lista_0.getitemnumber(a_riga, "barcode_num_int")
			kst_tab_barcode.data_int = dw_lista_0.getitemdate(a_riga, "barcode_data_int")
			kst_tab_barcode.fila_1 = dw_lista_0.getitemnumber(a_riga, "barcode_fila_1")
			kst_tab_barcode.fila_1p = dw_lista_0.getitemnumber(a_riga, "barcode_fila_1p")
			kst_tab_barcode.fila_2 = dw_lista_0.getitemnumber(a_riga, "barcode_fila_2")
			kst_tab_barcode.fila_2p = dw_lista_0.getitemnumber(a_riga, "barcode_fila_2p")

	end choose

//--- se sono in modalita di modifica e più righe selezionate allora passo alla modalita di modifica piu'righe
	if kiuf_barcode_mod_giri.ki_modifica_cicli_enabled = kiuf_barcode_mod_giri.ki_modifica_cicli_enabled_modif then
		kst_barcode_mod_giri.a_modalita_modifica_file = kiuf_barcode_mod_giri.ki_modalita_modifica_scelta_fila //kiuf_barcode_mod_giri.ki_modalita_modifica_giri_riga	
		if a_dw_modifica_giri.dataobject <> dw_meca.dataobject then
			k_riga = kidw_x_modifica_giri.getselectedrow(a_riga)
			if k_riga > 0 then
				kst_barcode_mod_giri.a_modalita_modifica_file = kiuf_barcode_mod_giri.ki_modalita_modifica_giri_righe
			else
				kst_barcode_mod_giri.a_modalita_modifica_file = kiuf_barcode_mod_giri.ki_modalita_modifica_giri_riga
			end if
		end if
	else
		kiuf_barcode_mod_giri.ki_modifica_cicli_enabled = kiuf_barcode_mod_giri.ki_modifica_cicli_enabled_visualizzazione
	end if

	if a_dw_modifica_giri.dataobject = dw_meca.dataobject then
		kst_barcode_mod_giri.a_modif_tutto_riferimento = kiuf_barcode_mod_giri.ki_modif_tutto_riferimento_si
	else
		kst_barcode_mod_giri.a_modif_tutto_riferimento = kiuf_barcode_mod_giri.ki_modif_tutto_riferimento_no
	end if


	kst_barcode_mod_giri.ast_tab_barcode = kst_tab_barcode
	//kst_barcode_mod_giri.a_modalita_modifica_file = a_modalita_modifica_file
	//kst_barcode_mod_giri.a_modif_tutto_riferimento = k_modif_tutto_riferimento
	kst_barcode_mod_giri.adw_x_modifica_giri = kidw_x_modifica_giri
	kst_barcode_mod_giri.adw_barcode_da_non_modificare = kidw_barcode_da_non_modificare

	kiuf_barcode_mod_giri.u_open(kst_barcode_mod_giri)  // OPEN WINDOWS MODIFICA GIRI

//--- cambiati i giri?
	if kst_tab_barcode.fila_1 <> kiuf_barcode_mod_giri.kist_barcode_mod_giri.ast_tab_barcode.fila_1 &
			or kst_tab_barcode.fila_1p <> kiuf_barcode_mod_giri.kist_barcode_mod_giri.ast_tab_barcode.fila_1p &
			or kst_tab_barcode.fila_2 <> kiuf_barcode_mod_giri.kist_barcode_mod_giri.ast_tab_barcode.fila_2 &
			or kst_tab_barcode.fila_2p <> kiuf_barcode_mod_giri.kist_barcode_mod_giri.ast_tab_barcode.fila_2p then
		//ki_refresh_dw_meca_needed = true
		k_return = true
	end if
	
//	retrieve_figli( )  // aggiorna elenco figli 
	

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )
	

finally	
	a_dw_modifica_giri.setfocus()


end try

//		dw_modifica.modifica_giri(&
//										kst_tab_barcode &
//										,a_modalita_modifica_file &
//										,dw_modifica.ki_modif_tutto_riferimento &
//										,kidw_x_modifica_giri &
//										,kidw_barcode_da_non_modificare &
//										)
//else
//	messagebox("Modifica non permessa", &
//						"In questa modalita' non e' consentita la modifica dei dati")
//end if
	 
return k_return 

 

end function

private subroutine screma_lista_dw_barcode ();//
//=== Screma nella dw_barcode eventuali righe gia' presenti nella dw_lista e dw_groupage ma non ancora confermate
//
long k_riga, k_riga_find, k_rows, k_rows_lista, k_rows_groupage
//int k_ctr, k_rc
string k_barcode

	k_rows_groupage = dw_groupage.rowcount()
	k_rows_lista = dw_lista_0.rowcount()
	k_rows = dw_barcode.rowcount() 
	for k_riga = k_rows to 1 step -1
		
		k_barcode = trim(dw_barcode.getitemstring ( k_riga, "barcode_barcode"))

//--- Cerca nella dw_lista
		k_riga_find = dw_lista_0.find("barcode_barcode = '" + trim(string(k_barcode)) + "' ", 1, k_rows_lista) 
		if k_riga_find > 0 then 
			dw_barcode.deleterow( k_riga) 
		else
//--- Cerca nella dw_groupage
			k_riga_find = dw_groupage.find("barcode_barcode = '" + trim(string(k_barcode)) + "' ", 1, k_rows_lista) 
			if k_riga_find > 0 then 
				dw_barcode.deleterow( k_riga) 
			end if
		end if
		
	next
	



end subroutine

private function st_esito retrieve_figli_all ();//
//---- Rilegge tutti i figli da db2 contenuti nel dw_groupage
//
long k_riga
st_tab_barcode kst_tab_barcode
st_esito kst_esito, kst1_esito 


	kst_esito = kguo_exception.inizializza(this.classname())

	for k_riga = 1 to dw_groupage.rowcount()
	
		kst_tab_barcode.barcode = dw_groupage.object.barcode_barcode[k_riga]
		kst1_esito = retrieve_figlio_nel_dw_groupage(kst_tab_barcode)
		if kst1_esito.esito <> kkg_esito.ok and kst1_esito.esito <> kkg_esito.db_wrn then
			kst_esito.esito = kst1_esito.esito
			kst_esito.sqlerrtext += "~n~r" + trim(kst1_esito.sqlerrtext)
		end if
		
	end for


return kst_esito

end function

private subroutine screma_lista_from_dw_lista (long a_riga);//
//=== Sottrae un BARCODE da dw_meca (lista dei lotti non trattati) da dw_lista_0 
//=== inp: n.riga barcode in dw_lista_0 
//
long k_rows_meca
st_esito kst_esito	


try
	
	kst_esito = kguo_exception.inizializza(this.classname())

	k_rows_meca = dw_meca.rowcount()
	
//--- Screma se c'e' qualche riga nei box di lavorazione
	if k_rows_meca > 0 then
		
		screma_lista_from_dw_xxx_1(a_riga, dw_lista_0)
			
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally


end try






end subroutine

private subroutine screma_lista_from_dw_xxx_1 (long a_riga, ref datawindow adw_inp);//
//=== Sottrae un BARCODE da dw_meca (lista dei lotti non trattati) da dw_lista_0/dw_groupage 
//=== inp: n.riga barcode in dw_lista_0 
//
long k_riga_find, k_presenti_meca, k_rows_meca
long k_ctr, k_rc, k_fila_1, k_fila_2, k_fila_1p, k_fila_2p 
string k_find_txt, k_tipo_cicli 
long k_id_meca, k_num_int
date k_data_int
st_esito kst_esito	


//try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	//dw_meca.setredraw(false)		
	k_rows_meca = dw_meca.rowcount()

//--- sottrae dai Riferimenti i barcode messi in questa pianficazione
	k_tipo_cicli = adw_inp.getitemstring (a_riga, "barcode_tipo_cicli")
	k_id_meca = adw_inp.getitemnumber (a_riga, "id_meca")
	k_num_int = adw_inp.getitemnumber (a_riga, "barcode_num_int")
	k_data_int = adw_inp.getitemdate (a_riga, "barcode_data_int")
	k_fila_1 = adw_inp.getitemnumber(a_riga, "barcode_fila_1")	
	k_fila_2 = adw_inp.getitemnumber(a_riga, "barcode_fila_2")	
	k_fila_1p = adw_inp.getitemnumber(a_riga, "barcode_fila_1p")	
	k_fila_2p = adw_inp.getitemnumber(a_riga, "barcode_fila_2p")	
						
//--- costruzione della FIND			
	k_find_txt = "id_meca = " + trim(string(k_id_meca)) + " "  
	if k_fila_1 > 0 then
		k_find_txt += " and barcode_fila_1 = " + trim(string(k_fila_1)) + " "  
	else
		k_find_txt += " and barcode_fila_1 = 0 "
	end if
	if k_fila_2 > 0 then
		k_find_txt += " and barcode_fila_2 = " + trim(string(k_fila_2)) + " "  
	else
		k_find_txt += " and barcode_fila_2 = 0 "
	end if
	if k_fila_1p > 0 then
		k_find_txt += " and barcode_fila_1p = " + trim(string(k_fila_1p)) + " "  
	else
		k_find_txt += " and barcode_fila_1p = 0 "
	end if
	if k_fila_2p > 0 then
		k_find_txt += " and barcode_fila_2p = " + trim(string(k_fila_2p)) + " "  
	else
		k_find_txt += " and barcode_fila_2p = 0 "
	end if
		
//--- cerca il riferimento in lista				
	k_riga_find = dw_meca.find(k_find_txt, 1, k_rows_meca) 
		
//--- NON ho trovato un riferimento in lista, forse era già scremata o in elenco Pianificati 
	if k_riga_find = 0 then
	else				
		k_presenti_meca = dw_meca.getitemnumber( k_riga_find, "contati" )
		k_presenti_meca = k_presenti_meca - 1
			
//--- se azzero il contatore dei barcode tolgo il riferimento dalla lista				
		if k_presenti_meca <= 0 then
			dw_meca.deleterow( k_riga_find ) 
			k_rows_meca --
		else	
			dw_meca.setitem( k_riga_find, "contati", k_presenti_meca )
		end if
							
//--- ricerca il riferimento in lista ma non dovrebbe più esserci
		k_riga_find++
		k_riga_find = dw_meca.find(k_find_txt, k_riga_find, k_rows_meca) 
									  
//--- errore! ho trovato un altro lotto in lista con lo stesso ciclo
		if k_riga_find > 0 &
				and (ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica) then

			kst_esito.esito = kkg_esito.err_logico
			kst_esito.sqlerrtext =  " Pulizia elenco Lotti da trattare in errore, trovato Lotto alla riga " + string(k_riga_find) &
										  + " n. " + trim(string(k_num_int)) + " del " + trim(string(k_data_int)) &
										  + " su più righe con lo stesso trattamento: " &
										  + " F1=" + string(k_fila_1) + " + F2=" + string(k_fila_2) 
			kguo_exception.inizializza(classname(this))
			kguo_exception.scrivi_log( )
			//messagebox("Screma Lotti da Trattare", kst_esito.sqlerrtext + ". Proseguire l'operazione?", stopsign!) 
		end if
		
	end if
	
//catch (uo_exception kuo_exception)
//	kuo_exception.messaggio_utente()
//
//finally
//	//dw_meca.setredraw(true)		
//
//end try






end subroutine

private subroutine screma_lista_from_dw_groupage (long a_riga);//
//=== Sottrae un BARCODE da dw_meca (lista dei lotti non trattati) da dw_groupage 
//=== inp: n.riga barcode in dw_lista_0 
//
long k_rows_meca
st_esito kst_esito	


try
	
	kst_esito = kguo_exception.inizializza(this.classname())

	k_rows_meca = dw_meca.rowcount()
	
//--- Screma se c'e' qualche riga nei box di lavorazione
	if k_rows_meca > 0 then
		
		if trim(dw_groupage.getitemstring (a_riga, "barcode_lav")) > " " then 

		else

			screma_lista_from_dw_xxx_1(a_riga, dw_groupage)
			
		end if
			
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally


end try






end subroutine

private function st_esito screma_lista_riferimenti_from_dw_all ();//
//=== Toglie i BARCODE dalla lista se già messi in lavorazione nella dw_lista e dw_groupage
//=== torna numero barcode trovati 
//
long k_riga, k_num_loop_max, k_rows_meca
int k_tipo
long k_riga_pos
datastore kds_meca_kchoose
st_esito kst_esito	


try
	
	kst_esito = kguo_exception.inizializza(this.classname())

	dw_meca.setredraw(false)
	k_rows_meca = dw_meca.rowcount()
//--- cattura la riga corrente x riposizionamento finale
	k_riga_pos = dw_meca.getselectedrow(0)
	if k_riga_pos = 0 then
		k_riga_pos = dw_meca.getrow()
	end if

//--- salva il dw_meca x ripri dei selezionati		
	kds_meca_kchoose = create datastore
	kds_meca_kchoose.dataobject = dw_meca.dataobject
	dw_meca.rowscopy(1, k_rows_meca, Primary!, kds_meca_kchoose, 1, Primary!)

//--- Screma se c'e' qualche riga nei box di lavorazione
	if dw_lista_0.rowcount() > 0 or dw_groupage.rowcount()  > 0 then

		if k_rows_meca > 0 then
			
//--- elaborazione eseguita 2 volte: 1)in trattamento normale; 2)in trattam.Groupage
			
			k_num_loop_max = dw_lista_0.rowcount() 
			
			for k_riga = 1 to k_num_loop_max
					
				screma_lista_from_dw_lista(k_riga)  //elenco padri

			end for
			
			k_num_loop_max = dw_groupage.rowcount() 
			
			for k_riga = 1 to k_num_loop_max
				
				screma_lista_from_dw_groupage(k_riga)	//elenco figli
				
			end for
			
		end if
	
	end if

//--- segnalino sul riferimento che ha un lotto davanti
	u_marca_rif_file_davanti()

//--- ripristino flag di Lotto SELEZIONATO
	dw_meca.event u_restore_k_choose(kds_meca_kchoose, "1")	
	dw_meca.event u_restore_k_choose(kds_meca_kchoose, "2")	

//--- riposizionamento sulla riga come all'inizio
	if k_riga_pos > k_rows_meca then 
		k_riga_pos = k_rows_meca
	end if   
	if k_riga_pos > 0 then 
		//dw_meca.scrolltorow(k_riga_pos) // - 4)  
		dw_meca.setrow(k_riga_pos)  
		dw_meca.selectrow(k_riga_pos, true) // - 4)  
	end if

//--- sistema il codice e i progressivi nella lista
	imposta_codice_progr( dw_lista_0 )
	imposta_codice_progr( dw_groupage )

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally
	dw_meca.setredraw(true)		
	if isvalid(kds_meca_kchoose) then destroy kds_meca_kchoose

end try

return kst_esito




end function

private function st_esito oldscrema_lista_riferimenti ();//
//=== Toglie i BARCODE dalla lista se già messi in lavorazione nella dw_lista e dw_groupage
//=== torna numero barcode trovati 
//
long k_riga, k_riga_find=0, k_trovati_barcode, k_presenti_meca, k_num_loop_max
long k_ctr, k_rc, k_fila_1, k_fila_2, k_fila_1p, k_fila_2p, k_fila_mag_n, k_rows_meca
int k_tipo
boolean k_elabora
string k_find_txt, k_tipo_cicli, k_sort, k_area_mag, k_fila_mag
long k_id_meca, k_riga_pos, k_num_int
date k_data_int
datawindow kdw_1
datastore kds_meca_kchoose
st_esito kst_esito	


try
	
	kst_esito = kguo_exception.inizializza(this.classname())

	dw_meca.setredraw(false)
	k_rows_meca = dw_meca.rowcount()
//--- cattura la riga corrente x riposizionamento finale
	k_riga_pos = dw_meca.getselectedrow(0)
	if k_riga_pos = 0 then
		k_riga_pos = dw_meca.getrow()
	end if

//--- salva il dw_meca x ripri dei selezionati		
	kds_meca_kchoose = create datastore
	kds_meca_kchoose.dataobject = dw_meca.dataobject
	dw_meca.rowscopy(1, k_rows_meca, Primary!, kds_meca_kchoose, 1, Primary!)

////--- ripristina righe cancellate e contatori originali in lista riferimenti
//	if isvalid(kids_meca_orig) then
//		if kids_meca_orig.rowcount() > 0 then
//
////--- acchiappa il sort della merce da trattare
//			k_sort = dw_meca.Object.DataWindow.Table.Sort
//
//			dw_meca.reset()
////--- Ripristino elenco come ultima lettura	
//			kids_meca_orig.rowscopy(1, kids_meca_orig.rowcount(), primary!, dw_meca,1 , primary!)
//			
////--- ripristino eventuale sort 
//			if len(trim(k_sort)) > 1 and trim(k_sort) <> "?" then
//				dw_meca.setsort(k_sort)
//				dw_meca.sort()
//			end if
//		end if
//	end if

	
//--- Screma se c'e' qualche riga nei box di lavorazione
	if dw_lista_0.rowcount() > 0 or dw_groupage.rowcount()  > 0 then

		if k_rows_meca > 0 then
			
//--- elaborazione eseguita 2 volte: 1)in trattamento normale; 2)in trattam.Groupage
//? //--- 20.10.2009: attenzione i grp non sono conteggiati dentro "elenco da trattare" (dw_meca) x cui il giro sui figli non lo faccio più!
			k_tipo = 1
			for k_tipo = 1 to 2 
	
				if k_tipo = 1 then
					kdw_1 = dw_lista_0   //elenco padri
				else
					kdw_1 = dw_groupage  //elenco figli
				end if
			
//--- sottrae dai Riferimenti i barcode messi in questa pianficazione
				k_num_loop_max = kdw_1.rowcount() 
				
				for k_riga = 1 to k_num_loop_max
					
					k_elabora = true
					if k_tipo = 2 then // se elaboro GROUPAGE escludo quelli già con il PADRE
						if trim(kdw_1.getitemstring (k_riga, "barcode_lav")) > " " then 
							k_elabora = false
						end if
					end if
					
					if k_elabora then
				
						k_tipo_cicli = kdw_1.getitemstring (k_riga, "barcode_tipo_cicli")
						k_id_meca = kdw_1.getitemnumber (k_riga, "id_meca")
						k_num_int = kdw_1.getitemnumber (k_riga, "barcode_num_int")
						k_data_int = kdw_1.getitemdate (k_riga, "barcode_data_int")
						k_fila_1 = kdw_1.getitemnumber(k_riga, "barcode_fila_1")	
						k_fila_2 = kdw_1.getitemnumber(k_riga, "barcode_fila_2")	
						k_fila_1p = kdw_1.getitemnumber(k_riga, "barcode_fila_1p")	
						k_fila_2p = kdw_1.getitemnumber(k_riga, "barcode_fila_2p")	
						
//--- costruzione della FIND			
						k_find_txt = "id_meca = " + trim(string(k_id_meca)) + " "  
						if k_fila_1 > 0 then
							k_find_txt += " and barcode_fila_1 = " + trim(string(k_fila_1)) + " "  
						else
							k_find_txt += " and barcode_fila_1 = 0 "
						end if
						if k_fila_2 > 0 then
							k_find_txt += " and barcode_fila_2 = " + trim(string(k_fila_2)) + " "  
						else
							k_find_txt += " and barcode_fila_2 = 0 "
						end if
						if k_fila_1p > 0 then
							k_find_txt += " and barcode_fila_1p = " + trim(string(k_fila_1p)) + " "  
						else
							k_find_txt += " and barcode_fila_1p = 0 "
						end if
						if k_fila_2p > 0 then
							k_find_txt += " and barcode_fila_2p = " + trim(string(k_fila_2p)) + " "  
						else
							k_find_txt += " and barcode_fila_2p = 0 "
						end if
			
//						if k_rows_meca = 0 then
//							kst_esito.esito = kkg_esito.not_fnd
//							kst_esito.sqlerrtext = classname(this) + " - screma_lista_rifer: Lista Riferimenti Lotto Vuota! " 
//						else
			
//--- cerca il riferimento in lista				
						k_riga_find = dw_meca.find(k_find_txt, 1, k_rows_meca) 
			
//--- NON ho trovato un riferimento in lista, forse era già scremata o in elenco Pianificati 
						if k_riga_find = 0 then
						else				
							k_presenti_meca = dw_meca.getitemnumber( k_riga_find, "contati" )
							k_presenti_meca = k_presenti_meca - 1
								
//--- se azzero il contatore dei barcode tolgo il riferimento dalla lista				
							if k_presenti_meca <= 0 then
								dw_meca.deleterow( k_riga_find ) 
								k_rows_meca --
							else	
								dw_meca.setitem( k_riga_find, "contati", k_presenti_meca )
							end if
								
//--- ricerca il riferimento in lista ma non dovrebbe più esserci
							if k_riga_find < k_rows_meca then
								k_riga_find++
								k_riga_find = dw_meca.find(k_find_txt, k_riga_find, k_rows_meca) 
										  
//--- errore! ho trovato un altro lootto in lista con o stesso ciclo
								if k_riga_find > 0 then
									kst_esito.esito = kkg_esito.err_logico
									kst_esito.sqlerrtext =  " Pulizia elenco Lotti in errore, trovato Lotto "  &
																  + trim(string(k_num_int)) + " " + trim(string(k_data_int)) &
																  + " su più righe con lo stesso trattamento: " &
																  + " F1=" + string(k_fila_1) + " + F2=" + string(k_fila_2) 
									kguo_exception.inizializza(classname(this))
									kguo_exception.scrivi_log( )
									if messagebox("Screma Lotti da Trattare", kst_esito.sqlerrtext + ". Proseguire l'operazione?", stopsign!, yesno!, 1) = 2 then
										k_riga = k_num_loop_max + 1   // EXIT dal loop
									end if
								end if
							end if
							
						end if
		
					end if
					
				end for
			
			end for   // ciclo x fare sia elenco PADRI/FIGLI
		
		end if
	
	end if

//--- segnalino sul riferimento che ha un lotto davanti
	u_marca_rif_file_davanti()

//--- ripristino flag di Lotto SELEZIONATO
	dw_meca.event u_restore_k_choose(kds_meca_kchoose, "1")	
	dw_meca.event u_restore_k_choose(kds_meca_kchoose, "2")	

////--- Controllo se Lotto e' ASSOCIATO in WMF o in E1
//	if ki_e1_enabled then
//		set_flag_lotto_e1_associato( )
//	else
//		set_flag_lotto_wm_associato( )
//	end if
	
//--- riposizionamento sulla riga come all'inizio
	if k_riga_pos > k_rows_meca then 
		k_riga_pos = k_rows_meca
	end if   
	if k_riga_pos > 0 then 
		//dw_meca.scrolltorow(k_riga_pos) // - 4)  
		dw_meca.setrow(k_riga_pos)  
		dw_meca.selectrow(k_riga_pos, true) // - 4)  
	end if

//--- sistema il codice e i progressivi nella lista
	imposta_codice_progr( dw_lista_0 )
	imposta_codice_progr( dw_groupage )

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally
	dw_meca.setredraw(true)		
	if isvalid(kds_meca_kchoose) then destroy kds_meca_kchoose

end try

return kst_esito




end function

public subroutine u_get_dw_x_cambio_giri (ref uo_d_std_1 adw_1);//
//--- torna il dw x fare il cambio giri
//
	if kidw_selezionata.dataobject = dw_barcode.dataobject then
		adw_1 = dw_barcode
	else 
		adw_1 = dw_meca
	end if

end subroutine

private function long u_check_rif_file_davanti (long a_riga_inp);//
//--- Controlla in elenco riferimenti che non ci sia qlc pallet in posizione migliore fila 0=a muro, 1=prima della fila zero, 2=prima della fila 1 e così via
//--- input: num riga elenco da confrontare
//--- torna riga elenco che fa rif al numero Lotto trovato in pos migliore;  ZERO per nessun lotto trovato
//
long k_return = 0

//--- FORTINI: 13/09/2021 tolto il controllo 
//long k_riga_pos_migliore=0, k_righe, k_riga_find
//string k_area_mag_pos, k_area_mag, k_area, k_area_input
//int k_area_mag_pos_n,  k_pos_migliore, k_pos_input
//
//
//k_righe = dw_meca.rowcount() 
//
//if a_riga_inp > 0 and a_riga_inp < k_righe then
//	
////--- preleva il valore della posizione da confrontare	
//	k_area_mag =  trim(dw_meca.getitemstring(a_riga_inp, "meca_area_mag") )
//	if len(k_area_mag) > 5 then
//		k_area_mag_pos = mid(k_area_mag,6,1)
//		k_area_mag = left(k_area_mag,5)
//		if isnumber(k_area_mag_pos) then
//			k_area_mag_pos_n = integer(k_area_mag_pos) + 1
//			for k_pos_migliore = k_area_mag_pos_n  to 9 // cerca AREA_MAG davanti al lotto (fila + alta)
//				k_riga_find = dw_meca.find("meca_area_mag = '" +k_area_mag + string(k_pos_migliore)+"'", 0, dw_meca.rowcount())
//				if k_riga_find > 0 then 
//					k_return = k_riga_find    // trovato pallet in posizione migliore
//					EXIT
//				end if
//			next
//		end if
//	end if
//
//end if		
//

return k_return

end function

public function boolean if_lotto_rack_asscociati () throws uo_exception;/*
 Controllo se i barcode del Lotto se necessario sono gia' associati ai Rack
 ret: TRUE=associato/non necessario
*/
boolean k_return=true
int k_row, k_rows
st_tab_asdrackbarcode kst_tab_asdrackbarcode

	
try

	k_rows = dw_barcode.rowcount( )
	for k_row = 1 to k_rows
		kst_tab_asdrackbarcode.barcode = dw_barcode.getitemstring( k_row, "barcode_barcode")
		if not kiuf_asdrackbarcode.if_barcode_is_associated(kst_tab_asdrackbarcode) then
			k_return = false
			exit
		end if
	end for


catch (uo_exception kuo_exception)
	throw kuo_exception

finally

end try
			
return k_return
end function

private subroutine u_aggiungi_figli_al_dw_groupage (st_tab_barcode kst_tab_barcode);/*
   Verifica del barcode se ha figli se il barcode ha figli li AGGIUNGO dalla dw
   Inp: kst_tab_barcode.barcode
*/
long k_row_barcode_ds_1, k_rows_grp, k_riga_find
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_prodotti kst_tab_prodotti
st_tab_armo kst_tab_armo
st_tab_asdrackbarcode kst_tab_asdrackbarcode
st_tab_sl_pt kst_tab_sl_pt
uo_ds_std_1 kds_1
//kuf_barcode kuf1_barcode
//kuf_armo kuf1_armo
kuf_clienti kuf1_clienti
kuf_prodotti kuf1_prodotti
kuf_sl_pt kuf1_sl_pt


ki_lista_0_modifcato = true

	try
//		kuf1_barcode = create kuf_barcode
//		kuf1_armo = create kuf_armo
		kuf1_clienti = create kuf_clienti
		kuf1_prodotti = create kuf_prodotti
		kuf1_sl_pt = create kuf_sl_pt

		kds_1 = kiuf_barcode.get_figli_barcode(kst_tab_barcode)  //get figli del barcode per aggiungerli
		if kds_1.rowcount( ) > 0 then
			
			dw_groupage.setredraw(false)
			
			k_rows_grp = dw_groupage.rowcount( )
			//k_row_barcode_ds_1=1
			
			//do while k_rows_grp <= kds_1.rowcount() 
			for k_row_barcode_ds_1 = 1 to kds_1.rowcount() 

				kst_tab_barcode.barcode = kds_1.object.barcode[k_row_barcode_ds_1]

//--- Cerco il barcode tra i figli e padri gia' presenti (non ci possono essere NONNI)
				k_riga_find = dw_groupage.find("barcode_barcode = '" + trim(kst_tab_barcode.barcode) + "' or barcode_lav = '" + trim(kst_tab_barcode.barcode) + "'", 1, dw_groupage.rowcount()) 

//--- se il barcode non c'e' ancora tra i figli allora lo aggiungo
				if k_riga_find < 1  then
					
					k_rows_grp = dw_groupage.insertrow(k_rows_grp+1)
					
					kiuf_barcode.select_barcode( kst_tab_barcode )
					kst_tab_armo.id_armo = kst_tab_barcode.id_armo
					kiuf_armo.leggi_riga( " ", kst_tab_armo )
					
					kst_tab_armo.peso_kg = kst_tab_armo.peso_kg / kst_tab_armo.colli_2 // ricavo il peso x collo
					kst_tab_meca.id = kst_tab_armo.id_meca
					kiuf_armo.leggi_testa("P", kst_tab_meca )
					
					kst_tab_clienti.codice = kst_tab_meca.clie_2
					kuf1_clienti.leggi_rag_soc( kst_tab_clienti )
					kst_tab_prodotti.codice = kst_tab_armo.art
					kuf1_prodotti.select_riga( kst_tab_prodotti )
					
					kst_tab_sl_pt.cod_sl_pt = kst_tab_armo.cod_sl_pt
					kuf1_sl_pt.get_densita(kst_tab_sl_pt)
					
					kst_tab_asdrackbarcode.barcode = kst_tab_barcode.barcode
					if not kiuf_asdrackbarcode.if_barcode_is_associated(kst_tab_asdrackbarcode) then // get di almeno un id rack se c'è
						kst_tab_asdrackbarcode.id_asdrackcode = 0
					end if
	
					if dw_dett_0.object.codice[1] > 0 then
						dw_groupage.setitem(k_rows_grp, "barcode_pl_barcode",dw_dett_0.object.codice[1])
					else
						dw_groupage.setitem(k_rows_grp, "barcode_pl_barcode",0)
					end if
					dw_groupage.setitem(k_rows_grp, "barcode_lav",kst_tab_barcode.barcode_lav)
					dw_groupage.setitem(k_rows_grp, "barcode_barcode",kst_tab_barcode.barcode)
					dw_groupage.setitem(k_rows_grp, "barcode_tipo_cicli",kst_tab_barcode.tipo_cicli)
					dw_groupage.setitem(k_rows_grp, "barcode_fila_1",kst_tab_barcode.fila_1)
					dw_groupage.setitem(k_rows_grp, "barcode_fila_2",kst_tab_barcode.fila_2)
					dw_groupage.setitem(k_rows_grp, "barcode_fila_1p",kst_tab_barcode.fila_1p)
					dw_groupage.setitem(k_rows_grp, "barcode_fila_2p",kst_tab_barcode.fila_2p)
	
					dw_groupage.setitem(k_rows_grp, "dose",kst_tab_armo.dose)
					dw_groupage.setitem(k_rows_grp, "peso_kg",kst_tab_armo.peso_kg)
					dw_groupage.setitem(k_rows_grp, "larg_2",kst_tab_armo.larg_2)
					dw_groupage.setitem(k_rows_grp, "lung_2",kst_tab_armo.lung_2)
					dw_groupage.setitem(k_rows_grp, "alt_2",kst_tab_armo.alt_2)
					dw_groupage.setitem(k_rows_grp, "pedane",kst_tab_armo.pedane)
					dw_groupage.setitem(k_rows_grp, "art",kst_tab_armo.art)
					dw_groupage.setitem(k_rows_grp, "id_armo",kst_tab_armo.id_armo)
					dw_groupage.setitem(k_rows_grp, "id_meca",kst_tab_armo.id_meca)
					dw_groupage.setitem(k_rows_grp, "area_mag",kst_tab_meca.area_mag)
					dw_groupage.setitem(k_rows_grp, "campione",kst_tab_armo.campione)
					dw_groupage.setitem(k_rows_grp, "barcode_num_int",kst_tab_meca.num_int)
					dw_groupage.setitem(k_rows_grp, "barcode_data_int",kst_tab_meca.data_int)
//					dw_groupage.setitem(k_rows_grp, "clie_2",kst_tab_meca.clie_2)
//					dw_groupage.setitem(k_rows_grp, "rag_soc_10",kst_tab_clienti.rag_soc_10)
					dw_groupage.setitem(k_rows_grp, "dose",kst_tab_armo.dose)
					dw_groupage.setitem(k_rows_grp, "e1ancodrs",kst_tab_clienti.e1ancodrs)
					dw_groupage.setitem(k_rows_grp, "id_asdrackcode",kst_tab_asdrackbarcode.id_asdrackcode)
					
             	if kst_tab_sl_pt.densitamax > 0 then
	               dw_groupage.setitem(k_rows_grp, "k_densita", kst_tab_sl_pt.densitamax )
					else
	               dw_groupage.setitem(k_rows_grp, "k_densita", kst_tab_sl_pt.densita )
					end if
				end if
				
				//k_row_barcode_ds_1++
			//loop
			next
		end if
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	finally
		dw_groupage.setredraw(true)
	//	if isvalid(kuf1_barcode) then destroy kuf1_barcode
		if isvalid(kuf1_sl_pt) then destroy kuf1_sl_pt 
		if isvalid(kuf1_clienti) then destroy kuf1_clienti
		if isvalid(kuf1_prodotti) then destroy kuf1_prodotti
		if isvalid(kds_1) then destroy kds_1
		
	end try


end subroutine

private subroutine u_aggiungi_figli_dal_dw_lista (long a_row);//---
//---   Verifica se nella dw_lista  ci sono Padri e aggiunge i figli nella dw_groupage
//---
//---   inp: n. riga del barcode nel dw_lista da verificare; 0 = tutti
long k_riga, k_rows
st_tab_barcode kst_tab_barcode

ki_lista_0_modifcato = true

if a_row > 0 then
	k_rows = a_row
else
	a_row = 1
	k_rows = dw_lista_0.rowcount()
end if
for k_riga = a_row to k_rows
	kst_tab_barcode.barcode = trim(dw_lista_0.getitemstring(k_riga, "barcode_barcode"))
	u_aggiungi_figli_al_dw_groupage ( kst_tab_barcode )
next

end subroutine

public subroutine u_aggiungi_grp_barcode_singolo (ref datawindow kdw_2);//
//=== Aggiungi un BARCODE come figlio nella lista dei Pianificati in Groupage
//===   kdw_2 -----> dw_lista/dw_barcode
//
long k_riga, k_insertrow, k_riga_drag, k_riga_ultima=0, k_riga_find=0, k_riga_meca
long k_pl_barcode
date k_data_int
string k_find
int k_ctr, k_rc
boolean k_blocca_operazione=false
//boolean k_elabora=true
st_tab_meca kst_tab_meca
st_tab_barcode kst_tab_barcode
kuf_sl_pt kuf1_sl_pt
//kuf_barcode kuf1_barcode
//kuf_barcode_mod_giri kuf1_barcode_mod_giri

try
	
	
	if kdw_2.rowcount() > 0 then
		
		dw_groupage.setredraw(false)
	
		if dw_groupage.rowcount() > 0 and dw_groupage.getselectedrow(0) > 0 then
			k_insertrow = 1
			k_riga = dw_groupage.getselectedrow(0)
		else
			k_riga = 0
			k_insertrow = 0
		end if

		k_riga_drag = kdw_2.getselectedrow(0)
		if k_riga_drag > 0 then
			ki_lista_0_modifcato = true
			//kuf1_barcode = create kuf_barcode
		end if
		
		do while k_riga_drag > 0 
	
//--- Controllo che barcode non abbia figli
			kst_tab_barcode.barcode = kdw_2.getitemstring(k_riga_drag, "barcode_barcode")
			if kiuf_barcode.if_barcode_padre(kst_tab_barcode) then
				kguo_exception.inizializza( )
				kguo_exception.setmessage( "ATTENZIONE", "Il Barcode " + trim(kst_tab_barcode.barcode ) + " è 'PADRE' non è possibile aggiungerlo come 'FIGLIO' - Operazione bloccata!")
				throw kguo_exception
			end if

			kst_tab_meca.num_int = kdw_2.getitemnumber(k_riga_drag, "barcode_num_int")
			k_riga_meca = dw_meca.find( "meca_num_int = " + string(kst_tab_meca.num_int), 1, dw_meca.rowcount() )
			if k_riga_meca > 0 then 

				kst_tab_meca.id = dw_meca.getitemnumber(k_riga_meca, "id_meca")
				kst_tab_meca.num_int = dw_meca.getitemnumber(k_riga_meca, "meca_num_int") 
				kst_tab_meca.data_int = dw_meca.getitemdate(k_riga_meca, "meca_data_int") 
				if kst_tab_meca.id > 0 then
					if not if_lotto_associato(kst_tab_meca) then
					
						kguo_exception.inizializza( )
						if ki_consenti_lavoraz_non_associati_wmf then
							kguo_exception.messaggio_utente( "Manca Associazione", "Lotto n. " + string(kst_tab_meca.num_int ) + " non è stato 'Associato' ('20') - Operazione consentita grazie al consenso impostato a menu.")
						else
							k_blocca_operazione = true
							kguo_exception.messaggio_utente( "Operazione Bloccata", "Lotto n. " + string(kst_tab_meca.num_int ) + " non è stato 'Associato' ('20') - Pianificazione non consentita")
						end if
					end if
				end if
			
				if not k_blocca_operazione then
					//--- Controllo se Riferimento 'IN ATTENZIONE'
					if dw_meca.getitemnumber(k_riga_meca, "stato_in_attenzione") = 1 then
						SetPointer(kkg.pointer_default)
						if messagebox( "Lotto in ATTENZIONE", "Lotto " + string(dw_meca.getitemnumber(k_riga_meca, "meca_num_int")) &
											+ " è 'IN ATTENZIONE'. NON sarebbe ancora da TRATTARE. Proseguire l'operazione?", &
											+ stopsign!, yesno!, 1) = 2 then
	
							k_blocca_operazione = true
						end if
						SetPointer(kkg.pointer_attesa)
					end if
				end if
			end if

			if not k_blocca_operazione then
//--- se ciclo normale a scelta devo effettuare prima la scelta
				if kdw_2.getitemstring(k_riga_drag, "barcode_tipo_cicli") = kuf1_sl_pt.ki_tipo_cicli_a_scelta then
					
					//modifica_giri(kuf1_barcode_mod_giri.ki_modalita_modifica_scelta_fila, k_riga_drag,  kdw_2)
					if u_modifica_giri(kdw_2, k_riga_drag) then 
//						kdw_2.setitem(k_riga_drag, "barcode_fila_1", kiuf_barcode_mod_giri.kist_barcode_mod_giri.ast_tab_barcode.fila_1)
//						kdw_2.setitem(k_riga_drag, "barcode_fila_1p", kiuf_barcode_mod_giri.kist_barcode_mod_giri.ast_tab_barcode.fila_1p)
//						kdw_2.setitem(k_riga_drag, "barcode_fila_2", kiuf_barcode_mod_giri.kist_barcode_mod_giri.ast_tab_barcode.fila_2)
//						kdw_2.setitem(k_riga_drag, "barcode_fila_2p", kiuf_barcode_mod_giri.kist_barcode_mod_giri.ast_tab_barcode.fila_2p)
					else
						k_blocca_operazione = true
						kdw_2.selectrow(k_riga_drag, false)
					end if

				end if
			end if
					
			if k_blocca_operazione then
				k_riga_drag = 0 // forzo uscita ciclo
			else
	
				k_riga = dw_groupage.insertrow(k_riga + k_insertrow)
		
//--- copia in dw_groupage la dw2 (dw_barcode/dw_lista_0) 			
				if kdw_2.dataobject = dw_lista_0.dataobject then
					copia_dw_lista_0_to_dw_groupage(k_riga, k_riga_drag)
				else
					copia_dw_barcode_to_dw_groupage(k_riga, k_riga_drag)			
//					else
//						copia_dw_barcode_to_dwxlavorazione(dw_groupage, k_riga, k_riga_drag)
////						copia_dettaglio_dw_grp_da_dw1 (dw_groupage, kdw_2, k_riga, k_riga_drag)
				end if
				
				screma_lista_from_dw_groupage(k_riga)  // screma dw_meca

				kdw_2.deleterow(k_riga_drag) 

				k_riga_drag = kdw_2.getselectedrow(k_riga_drag - 1)
				
				k_riga_ultima = k_riga
					
			end if

		loop

		if k_riga_ultima > 0 then
			
//--- sistema il codice e i progressivi nella lista
			imposta_codice_progr( dw_groupage )

			dw_groupage.selectrow(0, false)
			dw_groupage.setrow(k_riga_ultima)
			dw_groupage.selectrow(k_riga_ultima, true)
			dw_groupage.scrolltorow(k_riga_ultima)
//			screma_lista_riferimenti()
		end if
		
//		if ki_refresh_dw_meca_needed then
//			retrieve_figli( )  // aggiorna elenco figli 
//		else
//			attiva_tasti()
//		end if

	end if

	dw_groupage.setcolumn(1)
	dw_groupage.setfocus()

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally 
	dw_groupage.setredraw(true)
	//if isvalid(kuf1_barcode) then destroy kuf1_barcode
	
	
end try

end subroutine

public subroutine u_aggiungi_grp_rif_intero (ref datawindow kdw_1);//
//=== Aggiungi i BARCODE dell'intera entrata alla lista dei Groupage da Pianificare
//===  dw_meca ------> dw_barcode -----> kdw_1 (groupage)
//
long k_riga, k_insertrow, k_riga_drag, k_riga_meca, k_riga_posiziona, k_riga_meca_old
long k_num_int, k_pl_barcode
date k_data_int
int k_ctr, k_rc
boolean k_elaborazione=true
st_tab_meca kst_tab_meca
st_esito kst_esito
kuf_sl_pt kuf1_sl_pt
//kuf_barcode_mod_giri kuf1_barcode_mod_giri


//=== Puntatore Cursore da attesa.....
SetPointer(kkg.pointer_attesa)

ki_lista_0_modifcato = true

k_riga_posiziona = 0
	
if dw_meca.rowcount() > 0 then
	
	dw_groupage.setredraw(false)

	k_riga_meca = dw_meca.getselectedrow(0)

	if k_riga_meca > 0 then	
		if kdw_1.rowcount() > 0 &
			and kdw_1.getselectedrow(0) > 0 then
			k_insertrow = 1
			k_riga = kdw_1.getselectedrow(0)
			//k_riga_posiziona = k_riga
		else
			k_riga = -1
			k_riga_posiziona = -1
			k_insertrow = 1
		end if
	else
		messagebox("Nessuna Operazione Eseguita", "Selezionare una riga dall'elenco.", StopSign!) // + "~n~r"
	end if	

	
	do while k_riga_meca > 0 and k_elaborazione

		try
			kst_tab_meca.id = dw_meca.getitemnumber(k_riga_meca, "id_meca")
			kst_tab_meca.num_int = dw_meca.getitemnumber(k_riga_meca, "meca_num_int") 
			kst_tab_meca.data_int = dw_meca.getitemdate(k_riga_meca, "meca_data_int") 
			if kst_tab_meca.id > 0 then
				if not if_lotto_associato(kst_tab_meca) then
				
					kguo_exception.inizializza( )
					if ki_consenti_lavoraz_non_associati_wmf then
						SetPointer(kkg.pointer_default)
						kguo_exception.messaggio_utente( "ATTENZIONE", "Lotto n. " + string(kst_tab_meca.num_int ) + " non è stato 'Associato' ('20') - Operazione consentita grazie al consenso impostato a menu.")
					else
						SetPointer(kkg.pointer_default)
						kguo_exception.messaggio_utente( "Operazione Bloccata", "Lotto n. " + string(kst_tab_meca.num_int ) + " non è stato 'Associato' ('20') - Pianificazione non consentita")
						exit
					end if
				end if
			end if
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
		end try

//--- Controllo se Riferimento 'IN ATTENZIONE'
		if dw_meca.getitemnumber(k_riga_meca, "stato_in_attenzione") = 1 then
			SetPointer(kkg.pointer_default)
			if messagebox( "Lotto in ATTENZIONE", "Lotto " + string(dw_meca.getitemnumber(k_riga_meca, "meca_num_int")) &
										+ " è 'IN ATTENZIONE'. NON sarebbe ancora da TRATTARE. Proseguire l'operazione?", &
										+ stopsign!, yesno!, 1) = 2 then
				exit
			end if
			SetPointer(kkg.pointer_attesa)
		end if

//--- popola dw_barcode		
		u_dw_barcode_retrieve(k_riga_meca)

		if dw_barcode.rowcount() <= 0 then
			exit  //USCITA!
		end if

//--- se ciclo normale a scelta devo effettuare prima la scelta
		if not isnull(dw_barcode.getitemstring(1, "barcode_tipo_cicli")) &
						and dw_barcode.getitemstring(1, "barcode_tipo_cicli") = kuf1_sl_pt.ki_tipo_cicli_a_scelta then
			
			if u_modifica_giri(dw_meca, k_riga_meca) then
			
				dw_barcode.reset()
				u_dw_barcode_retrieve(k_riga_meca)  // ripopola dw_barcode
				
			else

				exit
				k_elaborazione = false  // forzo uscita ciclo
				
			end if
		end if				
			
//--- se arrivo qui allora elabora!
		try
			k_riga_posiziona = 0
			k_riga_drag = 1
			do while k_riga_drag <= dw_barcode.rowcount() 
	
				k_riga_posiziona = kdw_1.insertrow(k_riga_posiziona + k_insertrow)

//--- copia la barcode in kdw_1, il formato e' il solito dettaglio			
				copia_dw_barcode_to_dw_groupage(k_riga_posiziona, k_riga_drag)
				
				screma_lista_from_dw_groupage(k_riga_posiziona)  // screma dw_meca

				k_riga_drag++
				
			loop
			
		catch (uo_exception kuo_exception1)
			kuo_exception1.messaggio_utente()
			
		end try
	
//--- Toglie le righe inserite
		dw_barcode.reset()
//			for k_ctr = dw_barcode.rowcount() to 0 step -1   
//				dw_barcode.deleterow(k_ctr) 
//			next 

		dw_meca.deleterow(k_riga_meca) 

		k_riga_meca_old = k_riga_meca
		k_riga_meca = dw_meca.getselectedrow(k_riga_meca - 1)
			
	loop
	

//--- sistema il codice e i progressivi nella lista
//	if k_riga_meca_old > 0 and k_elaborazione then
	if k_riga_posiziona > 0 then
		
		imposta_codice_progr( kdw_1 )
	
		if k_riga_meca_old > dw_meca.rowcount() then
			k_riga_meca_old = dw_meca.rowcount()
		end if
		if k_riga_meca_old > 0 then
			//dw_meca.scrolltorow(k_riga_meca_old)
			dw_meca.setrow(k_riga_meca_old)
			dw_meca.selectrow(k_riga_meca_old, true)
		end if
		
//		screma_lista_riferimenti()
//		if ki_refresh_dw_meca_needed then
//			//retrieve_figli( )  // aggiorna elenco figli 
//		end if
		
		kdw_1.setcolumn(1)
		kdw_1.setfocus()
		if k_riga_posiziona > 0 then
			kdw_1.selectrow(0, false)
			kdw_1.setrow(k_riga_posiziona)
			kdw_1.scrolltorow(k_riga_posiziona) 
			kdw_1.selectrow(k_riga_posiziona, true)
		end if
		
	end if

	dw_groupage.setredraw(true)

end if

////--- Toglie dalla lista principale i riferimenti messi in lavorazione
//if k_elaborazione and dw_lista_0.rowcount() > 0 or dw_groupage.rowcount() > 0 then
////--- se torna con qualche dubbio allora rifare le liste da DB
//	kst_esito = screma_lista_riferimenti()
//end if

//attiva_tasti()

SetPointer(kkg.pointer_default)

end subroutine

public function string u_check_programmazione ();/*
Completa gestione aggiornamento tabelle : Check dati + Update
   Ritorna 1 char: 0=Tutto OK; 
                 : 1=Errore grave e/o aggiuornam. non eseguito;
  	              : 2=Errore Non grave richiesto di non aggiornare i dati
                 : 3=
*/
string k_result = "0 "
string k_result_code


//--- Imposta campi e codici prima di aggiornare le tabelle
//	riempi_id()

/*=== Controllo congruenza dei dati caricati. 
      Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
  			         : 3=dati insufficienti; 
                  : 4=OK con incongruenze, richiesta se fare aggiornamento
                  : 5=ON con avvertenze generiche, richiesta se fare aggiornamento
      il resto della stringa contiene la descrizione dell'errore   
*/
k_result = check_dati()

k_result_code = Left(k_result,1)

choose case k_result_code 

	case "0" //Tutto OK!
		messagebox("Controllo Programmazione", "Verifica terminata correttamente.")
   case "1" //errore grave: incongruenze dati
		messagebox("Controllo Programmazione", "Dati incongruenti: " +  Mid(k_result, 2), stopsign!)
	case "2" //errore grave: digitazione dati 
		messagebox("Controllo Programmazione", "Dati non validi: " +  Mid(k_result, 2), stopsign!)
	case "3" //errore grave: mancanza dati
		messagebox("Controllo Programmazione", "Dati insufficienti: " +  Mid(k_result, 2), stopsign!)
	case "4" //avvertenza DB: dati da rivedere
		messagebox("Controllo Programmazione", "Rilevate alcune anomalie non bloccanti: " +  Mid(k_result, 2))
	case "5" //avvertenza dati: dati da rivedere
		messagebox("Controllo Programmazione", "Rilevate alcune incongruenze non bloccanti: " +  Mid(k_result, 2))
	case "6" //avvertenza dati: operazione non eseguita
		messagebox("Controllo Programmazione", "Dati errati: " +  Mid(k_result, 2), stopsign!)
		
	case else //avvertenze: altro
		messagebox("Controllo Programmazione", "Verifica corretta ma rilevate alcune informazioni: " +  Mid(k_result, 2))

	end choose
		

return k_result

end function

protected function boolean if_programmazione_ok () throws uo_exception;//---
//--- Controlla Programmazione
//---      
//--- Ritorna TRUE=OK
//---      
//
boolean k_return = false //, k_errore=false
string k_barcode//, k_errore_msg = ""
date k_data, k_data_chiuso, k_dataoggi
//int k_nr_errori, , k_rc 
long k_riga, k_nr_righe, k_riga_ds, k_pl_barcode_progr
st_esito kst_esito
st_tab_barcode kst_tab_barcode
//kuf_barcode kuf1_barcode
ds_pl_barcode_dett kds_pl_barcode_dett, kds_pl_barcode_dett_grp
st_tab_pl_barcode kst_tab_pl_barcode
uo_ds_std_1 kds_get_barcode_rackcode_not_in_pl_barcode

try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	kds_pl_barcode_dett = create ds_pl_barcode_dett
	kds_pl_barcode_dett_grp = create ds_pl_barcode_dett
//	kuf1_barcode = create kuf_barcode

	dw_lista_0.accepttext()
	dw_groupage.accepttext()

	k_nr_righe = dw_lista_0.rowcount()

	for k_riga = 1 to k_nr_righe 

		k_pl_barcode_progr = dw_lista_0.getitemnumber ( k_riga, "barcode_pl_barcode_progr")

			
//--- Tolgo valori a null dai giri
		if isnull(dw_lista_0.getitemnumber ( k_riga, "barcode_fila_1")) then
			dw_lista_0.setitem ( k_riga, "barcode_fila_1", 0)
		end if
		if isnull(dw_lista_0.getitemnumber ( k_riga, "barcode_fila_1p")) then
			dw_lista_0.setitem ( k_riga, "barcode_fila_1p", 0)
		end if
		if isnull(dw_lista_0.getitemnumber ( k_riga, "barcode_fila_2")) then
			dw_lista_0.setitem ( k_riga, "barcode_fila_2", 0)
		end if
		if isnull(dw_lista_0.getitemnumber ( k_riga, "barcode_fila_2p")) then
			dw_lista_0.setitem ( k_riga, "barcode_fila_2p", 0)
		end if

//--- Popolo il Datastore x il controllo della Programmazione
		k_riga_ds = kds_pl_barcode_dett.insertrow(0)
		kds_pl_barcode_dett.object.pl_barcode_progr[k_riga_ds] = dw_lista_0.getitemnumber ( k_riga, "barcode_pl_barcode_progr")
		kds_pl_barcode_dett.object.barcode[k_riga_ds] = dw_lista_0.getitemstring ( k_riga, "barcode_barcode")
		kds_pl_barcode_dett.object.fila_1[k_riga_ds] = dw_lista_0.getitemnumber ( k_riga, "barcode_fila_1")
		kds_pl_barcode_dett.object.fila_2[k_riga_ds] = dw_lista_0.getitemnumber ( k_riga, "barcode_fila_2")
		kds_pl_barcode_dett.object.fila_1p[k_riga_ds] = dw_lista_0.getitemnumber ( k_riga, "barcode_fila_1p")
		kds_pl_barcode_dett.object.fila_2p[k_riga_ds] = dw_lista_0.getitemnumber ( k_riga, "barcode_fila_2p")
		kds_pl_barcode_dett.object.tipo_cicli[k_riga_ds] = dw_lista_0.getitemstring ( k_riga, "barcode_tipo_cicli")
	
	next

//--- Controllo programmazione
	kiuf1_pl_barcode.if_pianificazione_ok(kds_pl_barcode_dett, "inserimento")

//---- Controllo Barcode FIGLI ------------------------------------------------------------------------------------

//--- Aggiungo eventuali Figli nati all'insaputa fuori da questo pianificazione
	u_aggiungi_figli_dal_dw_lista(0)

//--- Rileggo i dati di trattamento dei barcode figli
	kst_esito = retrieve_figli_all()
	if kst_esito.esito <> kkg_esito.ok then
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
//		k_errore_msg = k_errore_msg  & 
//							  + trim(kst_esito.sqlerrtext ) + ";~n~r" 
//		k_errore = true
	end if
	
//	if not k_errore  then

	k_nr_righe = dw_groupage.rowcount()
	for k_riga = 1 to k_nr_righe

//--- Popolo il Datastore Figli x il controllo della Programmazione
		k_riga_ds = kds_pl_barcode_dett_grp.insertrow(0)
		kds_pl_barcode_dett_grp.object.pl_barcode_progr[k_riga_ds] = dw_groupage.getitemnumber ( k_riga, "barcode_pl_barcode_progr")
		kds_pl_barcode_dett_grp.object.barcode[k_riga_ds] = dw_groupage.getitemstring ( k_riga, "barcode_barcode")
		kds_pl_barcode_dett_grp.object.barcode_lav[k_riga_ds] = dw_groupage.getitemstring ( k_riga, "barcode_lav")
		kds_pl_barcode_dett_grp.object.fila_1[k_riga_ds] = dw_groupage.getitemnumber ( k_riga, "barcode_fila_1")
		kds_pl_barcode_dett_grp.object.fila_2[k_riga_ds] = dw_groupage.getitemnumber ( k_riga, "barcode_fila_2")
		kds_pl_barcode_dett_grp.object.fila_1p[k_riga_ds] = dw_groupage.getitemnumber ( k_riga, "barcode_fila_1p")
		kds_pl_barcode_dett_grp.object.fila_2p[k_riga_ds] = dw_groupage.getitemnumber ( k_riga, "barcode_fila_2p")
		kds_pl_barcode_dett_grp.object.tipo_cicli[k_riga_ds] = dw_groupage.getitemstring ( k_riga, "barcode_tipo_cicli")
		
	next

//--- controlla pianificazione figli
	kiuf1_pl_barcode.if_pianificazione_figli_ok(kds_pl_barcode_dett, kds_pl_barcode_dett_grp, "inserimento")

//	end if

//	if not k_errore then

//--- sistema il codice e i progressivi nella lista PADRI
	imposta_codice_progr( dw_lista_0 )
			
//--- sistema il codice e i progressivi nella lista FIGLI
	imposta_codice_progr( dw_groupage )
			
//--- verifica se tutti i Rack sono stati messi in lav con tutti i Barcode associati			
	if_programmazione_rack_completa()

	k_return = TRUE   //sembra tutto OK!

catch (uo_exception kuo1_exception)
	throw kuo1_exception

finally
//	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	if isvalid(kds_pl_barcode_dett) then destroy kds_pl_barcode_dett
	if isvalid(kds_pl_barcode_dett_grp) then destroy kds_pl_barcode_dett_grp
	
end try

return k_return



end function

protected function boolean if_programmazione_rack_completa () throws uo_exception;//---
/*
  Controlla se i Rack messi in Programmazione contengono tutti i barcode Asscociati
      
  Ritorna TRUE=OK      
*/
boolean k_return = false
long k_riga, k_nr_righe, k_riga_found
st_tab_barcode kst_tab_barcode
uo_ds_std_1 kds_get_barcode_rackcode_not_in_pl_barcode

try
	kguo_exception.inizializza(this.classname())
	
//--- verifica se tutti i Rack sono stati messi in lav con tutti i Barcode associati			
	if dw_dett_0.rowcount( ) > 0 then
		kst_tab_barcode.pl_barcode = dw_dett_0.getitemnumber(1, "codice")
		if kst_tab_barcode.pl_barcode > 0 then
			kds_get_barcode_rackcode_not_in_pl_barcode = kiuf_barcode_asd.get_barcode_rackcode_not_in_pl_barcode(kst_tab_barcode)
			if isvalid(kds_get_barcode_rackcode_not_in_pl_barcode) then 
				if kds_get_barcode_rackcode_not_in_pl_barcode.rowcount( ) > 0 then   // ERRORE MANCANO ANCORA DEI BARCODE!
				
					k_nr_righe = kds_get_barcode_rackcode_not_in_pl_barcode.rowcount( )
					//--- screma eventuali barcode in programmazione+grp non salvati
					for k_riga = k_nr_righe to 1 step -1
						kst_tab_barcode.barcode = trim(kds_get_barcode_rackcode_not_in_pl_barcode.getitemstring(k_riga, "barcode"))
						k_riga_found = dw_lista_0.find("barcode_barcode = '" + kst_tab_barcode.barcode + "'", 1, dw_lista_0.rowcount( ))
						if k_riga_found = 0 then
							k_riga_found = dw_barcode.find("barcode_barcode = '" + kst_tab_barcode.barcode + "'", 1, dw_barcode.rowcount( ))
						end if
						if k_riga_found > 0 then
							kds_get_barcode_rackcode_not_in_pl_barcode.deleterow(k_riga)
							k_riga_found = 0
						end if
					next
					//--- infine se ci sono ancora righe allora la Programmazione non è completa ed espone i barcode da mettere in programmazione
					k_nr_righe = kds_get_barcode_rackcode_not_in_pl_barcode.rowcount( )
					if k_nr_righe > 0 then
						for k_riga = 1 to k_nr_righe
							if k_riga = 1 then
								kguo_exception.inizializza(this.classname())
								kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
								kguo_exception.kist_esito.sqlerrtext = "Attenzione, Rack messi in programmazione solo parzialmente, barcode mancanti: " 
							end if
							kguo_exception.kist_esito.sqlerrtext += kkg.acapo + kds_get_barcode_rackcode_not_in_pl_barcode.getitemstring(k_riga, "barcode") &
																				+ " (N. " + string(kds_get_barcode_rackcode_not_in_pl_barcode.getitemnumber(k_riga, "num_int")) &
																				+ " id/ASN " + string(kds_get_barcode_rackcode_not_in_pl_barcode.getitemnumber(k_riga, "id_meca")) &
																				+ ")" 
						next
						throw kguo_exception
					end if
					
				end if
			end if
		end if
	end if

	k_return = TRUE   //Controlli OK!

catch (uo_exception kuo1_exception)
	throw kuo1_exception

finally
	if isvalid(kds_get_barcode_rackcode_not_in_pl_barcode) then destroy kds_get_barcode_rackcode_not_in_pl_barcode
	
end try

return k_return



end function

public subroutine if_lotto_rack_con_padri () throws uo_exception;/*
 Controllo se il rack associato al barcode ha più di un PADRE (no buono!)
*/
int k_row, k_rows
st_tab_asdrackbarcode kst_tab_asdrackbarcode
st_esito kst_esito

	
try
	kst_esito = kguo_exception.inizializza(this.classname())

	k_rows = dw_barcode.rowcount( )
	for k_row = 1 to k_rows
		kst_tab_asdrackbarcode.barcode = dw_barcode.getitemstring( k_row, "barcode_barcode")
		if not kiuf_asdrackbarcode.if_barcode_only_existing_father(kst_tab_asdrackbarcode) then
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Attenzione ci sono più barcode PADRI come il '" + trim(kst_tab_asdrackbarcode.barcode) + "' associati a questa schermatura (id " &
	                        + string(kst_tab_asdrackbarcode.id_asdrackcode) + "). E' consentito un solo barcode 'padre' gli altri devono essere spostati in groupage." &
									+ kkg.acapo + "Operazione non consentita." 
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end for


catch (uo_exception kuo_exception)
	throw kuo_exception

finally

end try
			
end subroutine

private function long u_aggiungi_barcode_tutti_check (st_tab_meca ast_tab_meca, readonly long a_meca_row);//
//--- Controllo x aggiungere BARCODE alla lista dei Barcode Pianificati (padri o groupage)
//--- inp: ast_tab_meca: id, num_int
//---      a_meca_row: n. riga del sw di input (dw_meca)
//--- Return: N. riga da elaborare (0=NON ELABORARE)
//
long k_row_adw_out, k_insertrow, k_riga_drag
long k_riga_meca_fila_davanti
long k_return
integer k_rc
st_esito kst_esito
st_tab_barcode kst_tab_barcode
st_barcode_mod_giri kst_barcode_mod_giri
kuf_barcode kuf1_barcode
kuf_sl_pt kuf1_sl_pt
kuf_barcode_mod_giri kuf1_barcode_mod_giri 
kuf_response3 kuf1_response3


try 

	kst_esito = kguo_exception.inizializza(this.classname())
	kuf1_barcode = create kuf_barcode

//--- popola dw di dettaglio barcode (dw_barcode)
	if u_dw_barcode_retrieve(a_meca_row) = 0 then
		kst_esito = kguo_exception.inizializza(this.classname())
		throw kguo_exception
	end if

	k_return = a_meca_row // x default se tutto ok torna la riga da elaborare
		
//--- Controllo se Barcode ancora da Associare al barcode CLIENTE in WMF/E1
	if not if_lotto_associato(ast_tab_meca) then
		
		kst_esito = kguo_exception.inizializza(this.classname())
		if ki_consenti_lavoraz_non_associati_wmf then
			kst_esito.esito = kkg_esito.dati_wrn
			kst_esito.sqlerrtext = "Lotto n. " + string(ast_tab_meca.num_int ) + " non è nello stato di 'Associato' (20) ma l'operazione continuata grazie al consenso impostato a menu."
			//kguo_exception.messaggio_utente( "ATTENZIONE", "Lotto n. " + string(ast_tab_meca.num_int ) + " non nello stato 'Associato' (20) ma l'operazione continuata grazie al consenso impostato a menu.")
		else
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Lotto n. " + string(ast_tab_meca.num_int ) + " non è nello stato di 'Associato' ('20'). Pianificazione non consentita e interrotta!"
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			//k_blocca_operazione = true
			//kguo_exception.messaggio_utente( "Operazione Bloccata", "Lotto n. " + string(ast_tab_meca.num_int ) + " non nello stato 'Associato' ('20'). Pianificazione non consentita!")
		end if

	end if
		
//--- Controllo se Barcode associati ai RACK (se necessario)
	if not if_lotto_rack_asscociati() then
		
		kst_esito = kguo_exception.inizializza(this.classname())
//		if ki_consenti_lavoraz_non_associati_wmf then
//			kst_esito.esito = kkg_esito.dati_wrn
//			kst_esito.sqlerrtext = "Lotto n. " + string(ast_tab_meca.num_int ) + " non nello stato di 'Associato' (20) ma l'operazione continuata grazie al consenso impostato a menu.~n~r"
//		else
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Lotto n. " + string(ast_tab_meca.num_int ) + ", tutti i barcode da aggiungere al piano devono essere schermati (associati al Rack). Pianificazione non consentita!"
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
//		end if

	end if
	
//--- Controllo se Rack del Barcode ha più di un PADRE
	if_lotto_rack_con_padri( ) 

//--- Controllo se Riferimento 'IN ATTENZIONE' : probabile grp pertanto espongo un msg
	if dw_meca.getitemnumber(a_meca_row, "stato_in_attenzione") = 1 then
		if messagebox("Pianificazione", &
							"Lotto n. " + string(ast_tab_meca.num_int) &
							+ " è 'IN ATTENZIONE'  -   NON sarebbe ancora da TRATTARE." &
							+ kkg.acapo + "Pianificarlo comunque ?", Question!, yesno!, 1) = 2 then
			return 0
		end if
	else
//--- espone messaggio precedente se c'è
		if kst_esito.sqlerrtext > " " then
			kguo_exception.messaggio_utente("AVVERTIMENTO", kst_esito.sqlerrtext)
		end if
	end if
			

//--- se ciclo normale a scelta devo effettuare prima la scelta (MODIFICA GIRI)
	if dw_barcode.rowcount( ) > 0 then 
		kst_tab_barcode.barcode = dw_barcode.getitemstring(1, "barcode_barcode")
		kuf1_barcode.get_tipo_cicli(kst_tab_barcode)
		if kst_tab_barcode.tipo_cicli = kuf1_sl_pt.ki_tipo_cicli_a_scelta then
	
	//--- Completo i GIRI se richiesto da: tipo cicli 				
			//modifica_giri(kuf1_barcode_mod_giri.ki_modalita_modifica_scelta_fila, a_meca_row,  dw_meca)
			if u_modifica_giri(dw_meca, a_meca_row) then 
	
	//--- ripopola dw di dettaglio barcode (dw_barcode)
				if u_dw_barcode_retrieve(a_meca_row) > 0 then
					//u_set_dw_meca_fila(kst_tab_barcode, a_meca_row)
				else
					kst_esito = kguo_exception.inizializza(this.classname())
					kst_esito.esito = kkg_esito.no_esecuzione
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
			else
				return 0  // giri non cambiati !!
	
			end if
		end if
	end if
	
	
catch(uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	if kst_esito.esito <> kkg_esito.ok then
		throw kuo_exception
	end if

finally
	if isvalid(kuf1_response3) then destroy kuf1_response3
	if isvalid(kuf1_barcode) then destroy kuf1_barcode

	
end try 
	
return k_return
end function

public function long u_dw_barcode_retrieve (readonly long a_riga_meca);/*
Popola dw di dettaglio (dw_barcode)
 inp: row dw_meca to processing
 out: rows in dw detail
*/
long k_row, k_rows, k_return
int k_rc //, kst_tab_barcode.fila_1, kst_tab_barcode.fila_2, kst_tab_barcode.fila_1p, kst_tab_barcode.fila_2p
//double k_dose
//long k_pl_barcode
st_tab_barcode kst_tab_barcode

if a_riga_meca > 0 then

//	k_riga = dw_meca.getselectedrow(0)
		
	kst_tab_barcode.id_meca = dw_meca.getitemnumber(a_riga_meca, "id_meca")	
	kst_tab_barcode.fila_1 = dw_meca.getitemnumber(a_riga_meca, "barcode_fila_1")	
	kst_tab_barcode.fila_2 = dw_meca.getitemnumber(a_riga_meca, "barcode_fila_2")	
	kst_tab_barcode.fila_1p = dw_meca.getitemnumber(a_riga_meca, "barcode_fila_1p")	
	kst_tab_barcode.fila_2p = dw_meca.getitemnumber(a_riga_meca, "barcode_fila_2p")	
	
	if dw_dett_0.rowcount( ) > 0 then
		kst_tab_barcode.pl_barcode = dw_dett_0.getitemnumber(1, "codice")
	end if

	if isnull(kst_tab_barcode.pl_barcode)  then
		kst_tab_barcode.pl_barcode = 0
	end if
	if isnull(kst_tab_barcode.fila_1) then
		kst_tab_barcode.fila_1 = 999
	end if
	if isnull(kst_tab_barcode.fila_2) then
		kst_tab_barcode.fila_2 = 999
	end if
	if isnull(kst_tab_barcode.fila_1p) then
		kst_tab_barcode.fila_1p = 999
	end if
	if isnull(kst_tab_barcode.fila_2p) then
		kst_tab_barcode.fila_2p = 999
	end if

	k_rc = dw_barcode.reset() 
	k_rows = dw_barcode.retrieve(kst_tab_barcode.id_meca, kst_tab_barcode.pl_barcode) 
	
	if k_rows > 0 then

//---- rimuove le righe con la fila diversa e se il barcode è già messo in elenco da trattare (kdw_lista_0) o groupage (kdw_groupage)
		for k_row = k_rows to 1 step -1
			
			if (kst_tab_barcode.fila_1 <> 999 and dw_barcode.getitemnumber(k_row, "barcode_fila_1") <> kst_tab_barcode.fila_1) &
					or (kst_tab_barcode.fila_1p <> 999 and dw_barcode.getitemnumber(k_row, "barcode_fila_1p") <> kst_tab_barcode.fila_1p) &
					or (kst_tab_barcode.fila_2 <> 999 and dw_barcode.getitemnumber(k_row, "barcode_fila_2") <> kst_tab_barcode.fila_2) &
					or (kst_tab_barcode.fila_2p <> 999 and dw_barcode.getitemnumber(k_row, "barcode_fila_2p") <> kst_tab_barcode.fila_2p) &
					or dw_lista_0.find("barcode_barcode = '" + dw_barcode.getitemstring(k_row, "barcode_barcode") + "' ", 0, dw_lista_0.rowcount( ) ) > 0 &
					or dw_groupage.find("barcode_barcode = '" + dw_barcode.getitemstring(k_row, "barcode_barcode") + "' ", 0, dw_groupage.rowcount()) > 0 &
				then 

//--- cancella barcode dall'elenco
				dw_barcode.deleterow( k_row ) 
						
			end if 

		end for
	
	end if

end if

k_return = dw_barcode.rowcount()

//--- Riempe il titolo della dw di dettaglio
if k_return > 0 then
	dw_barcode.title = "Dettaglio Riferimento: " + string(dw_barcode.getitemnumber(1, "barcode_num_int"))
	dw_barcode.setcolumn(1)
	dw_barcode.setfocus()
else
	dw_barcode.title = "Dettaglio Riferimento " 
end if

return k_rows

end function

private subroutine u_crash_dw_lista_0_restore ();/*
  Ripristino Piano-Lav per eventuale crash
*/
int k_rc
datetime k_data_backup
datastore kds_1


kds_1 = create datastore
kds_1.dataobject = dw_lista_0.dataobject

k_rc=kGuf_data_base.dw_ripri_righe("Restore", "for_crash", kds_1, k_data_backup)

if kds_1.rowcount() > 0 then
//--- se non soo trascorsi più di 30 minuti (1800 sec)
	if date(k_data_backup) = today() and  SecondsAfter ( time(k_data_backup), now() ) < 1800 then
		if messagebox("Piano chiuso in modo inaspettato!", "Trovato un Piano di Lavorazione da Ripristinare delle ore " &
						+ string(k_data_backup, "hh:mm") + " con " + string(kds_1.rowcount()) + " righe." &
						+ kkg.acapo + "Proseguire con il recupero dei dati?"&
						, stopsign!, yesno!, 2) = 1 then
			
			dw_lista_0.reset( )
			kds_1.rowscopy( 1, kds_1.rowcount(), primary!, dw_lista_0, 1, primary!)

		end if
		ki_save_for_crash_insert = true
	end if
	//u_crash_reset( )  // praticamente pulisce il backup
end if

destroy kds_1
end subroutine

private subroutine u_crash_dw_lista_0_backup ();/*
  Salva Piano-Lav per eventuale ripristino in caso di crash
*/
int k_rc


	if dw_lista_0.rowcount( ) > 0 then
		k_rc=kGuf_data_base.dw_salva_righe("Restore", dw_lista_0, "for_crash")
		ki_save_for_crash_insert=true
	end if	

end subroutine

private subroutine u_crash_reset ();/*
  Reset del backup di rirpistino del Piano-Lav 
*/
int k_rc

if ki_save_for_crash_insert then	
	k_rc=kGuf_data_base.dw_salva_righe_reset("Restore", dw_lista_0, "for_crash")
	ki_save_for_crash_insert=false
end if

end subroutine

on w_pl_barcode_dett.create
int iCurrent
call super::create
this.cb_chiudi=create cb_chiudi
this.cb_togli=create cb_togli
this.cb_aggiungi=create cb_aggiungi
this.dw_groupage=create dw_groupage
this.dw_barcode=create dw_barcode
this.dw_meca=create dw_meca
this.dw_periodo=create dw_periodo
this.dw_prev=create dw_prev
this.dw_pilota_inlav=create dw_pilota_inlav
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_chiudi
this.Control[iCurrent+2]=this.cb_togli
this.Control[iCurrent+3]=this.cb_aggiungi
this.Control[iCurrent+4]=this.dw_groupage
this.Control[iCurrent+5]=this.dw_barcode
this.Control[iCurrent+6]=this.dw_meca
this.Control[iCurrent+7]=this.dw_periodo
this.Control[iCurrent+8]=this.dw_prev
this.Control[iCurrent+9]=this.dw_pilota_inlav
end on

on w_pl_barcode_dett.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_chiudi)
destroy(this.cb_togli)
destroy(this.cb_aggiungi)
destroy(this.dw_groupage)
destroy(this.dw_barcode)
destroy(this.dw_meca)
destroy(this.dw_periodo)
destroy(this.dw_prev)
destroy(this.dw_pilota_inlav)
end on

event timer;call super::timer;////
//
//dw_lista_0.title = Mid(dw_lista_0.title,2) + Left(dw_lista_0.title,1) 
//dw_groupage.title = Mid(dw_groupage.title,2) + Left(dw_groupage.title,1) 
//
end event

event close;call super::close;//

//=== Salva le righe del dw (saveas)
//kGuf_data_base.dw_saveas("no_pl", dw_meca)


//--- disattivo il timer
timer( 0 )
//dw_meca.accepttext( )

//--- registra la data piu' indietro su BASE cosi' da recuperarla al pross. giro 
set_base_data_ini()

dw_pilota_inlav.event u_hide( )

u_crash_reset( )  // pulisce il backup di ripri

//if isvalid(kids_meca_orig) then destroy kids_meca_orig
if isvalid(kiuf1_pl_barcode) then destroy kiuf1_pl_barcode								
if isvalid(kiuf_armo) then destroy kiuf_armo								
if isvalid(kiuf_e1_asn) then destroy kiuf_e1_asn
if isvalid(kiuf_barcode_mod_giri) then destroy kiuf_barcode_mod_giri
if isvalid(kiuf_asdrackbarcode) then destroy kiuf_asdrackbarcode
if isvalid(kiuf_barcode) then destroy kiuf_barcode
if isvalid(kiuf_barcode_asd) then destroy kiuf_barcode_asd

end event

event rbuttondown;//
string k_stringa=""
long k_riga=0
string k_tag_old=""
string k_tag=""
m_popup m_menu


//---
		attiva_menu( )
		
//--- Se sono sulla lista con il mouse allora posiziono il punt sul rek puntato

//--- Salvo il Tag attuale per reimpostarlo a fine routine
		k_tag_old = this.tag
		this.tag = " "

//--- Creo menu Popup 
		m_menu = create m_popup

		m_menu.m_pop_lib_1.text = "Rilettura elenco veloce "
		m_menu.m_pop_lib_1.enabled = true
		m_menu.m_pop_lib_1.visible = true
		m_menu.m_t_pop_lib_1.visible = true
		
		m_menu.m_lib_1.text = m_main.m_strumenti.m_fin_gest_libero1.text 
		m_menu.m_lib_1.visible = m_main.m_strumenti.m_fin_gest_libero1.visible
		m_menu.m_lib_1.enabled = m_main.m_strumenti.m_fin_gest_libero1.enabled
//
		m_menu.m_lib_2.text = m_main.m_strumenti.m_fin_gest_libero2.text 
		m_menu.m_lib_2.visible = m_main.m_strumenti.m_fin_gest_libero2.visible
		m_menu.m_lib_2.enabled = m_main.m_strumenti.m_fin_gest_libero2.enabled
//
		m_menu.m_lib_3.text = m_main.m_strumenti.m_fin_gest_libero3.text 
		m_menu.m_lib_3.visible = m_main.m_strumenti.m_fin_gest_libero3.visible
		m_menu.m_lib_3.enabled = m_main.m_strumenti.m_fin_gest_libero3.enabled
//
		m_menu.m_lib_4.text = m_main.m_strumenti.m_fin_gest_libero4.text 
		m_menu.m_lib_4.visible = m_main.m_strumenti.m_fin_gest_libero4.visible
		m_menu.m_lib_4.enabled = m_main.m_strumenti.m_fin_gest_libero4.enabled
		m_menu.m_t_lib_4.visible = m_menu.m_lib_4.visible

		m_menu.m_inserisci.visible = cb_inserisci.enabled
		m_menu.m_modifica.visible = cb_modifica.enabled
		m_menu.m_t_modifica.visible = cb_modifica.enabled
		m_menu.m_cancella.visible = cb_cancella.enabled
		m_menu.m_t_cancella.visible = cb_cancella.enabled
		m_menu.m_visualizza.visible = cb_visualizza.enabled

		m_menu.m_agglista.visible = true
		m_menu.m_t_agglista.visible = true

		m_menu.m_stampa.visible = st_stampa.enabled
		m_menu.m_t_stampa.visible = st_stampa.enabled
		m_menu.m_conferma.visible = cb_aggiorna.enabled
		m_menu.m_ritorna.visible = true

//--- Attivo il menu Popup
		m_menu.visible = true
		m_menu.popmenu(this.x + pointerx(), this.y + pointery())
		m_menu.visible = false

		destroy m_menu

		k_tag = this.tag 

		this.tag = k_tag_old 

		if trim(k_tag) <> "" then
			smista_funz(k_tag)
		end if
		


end event

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
//
int k_return
int k_rc
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_barcode kst_tab_barcode



if isvalid(kst_open_w) then

//--- Dalla finestra di Elenco Valori
	if kst_open_w.id_programma = kkg_id_programma_elenco and long(kst_open_w.key3) > 0 then
	
//--- vale solo se sono in aggiornamento	
 		if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then

			if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore
	
//--- Se dalla w di elenco doppio-click		
			choose case kst_open_w.key2
					
				case "d_pilota_queue_table_h" 
			
					kdsi_elenco_input = kst_open_w.key12_any 
				
					if kdsi_elenco_input.rowcount() > 0 then
						k_return = 1
				
						kst_tab_pl_barcode.prima_del_barcode = trim( kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "barcode") )
		
						if Len(trim(kst_tab_pl_barcode.prima_del_barcode)) > 0 then
							
		//--- imposta il dato selezioato in elenco nel campo
							dw_dett_0.setitem(dw_dett_0.getrow(), "prima_del_barcode", kst_tab_pl_barcode.prima_del_barcode) 				
						end if					
						
					end if

//--- scelto Padre potenziale
				case  "d_barcode_l_rid" //dw_lista_0.dataobject
					kdsi_elenco_input = kst_open_w.key12_any 
				
					if kdsi_elenco_input.rowcount() > 0 then
						k_return = 1
						kst_tab_barcode.barcode = kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "barcode")
						u_aggiungi_barcode_padre(kst_tab_barcode)
					end if


				case "d_pl_barcode_dett_1"
					kdsi_elenco_input = kst_open_w.key12_any 
				
					if kdsi_elenco_input.rowcount() > 0 then
						k_return = 1
						kst_tab_barcode.barcode = kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "barcode_barcode")
						u_aggiungi_barcode_padre(kst_tab_barcode)
					end if
					
							
			end choose
		end if

	end if

end if


return k_return

end event

event deactivate;call super::deactivate;//
//--- Disattivo il timer 
//	timer( 0 )
//

end event

event activate;call super::activate;//--- attivo il timer ogni mezzo secondo	
//	timer( 0.5 )
//

end event

event u_open;call super::u_open;//
dw_prev.visible = false

end event

event closequery;call super::closequery;//
if ki_exit_si then
	dw_dett_0.visible = false
end if

end event

type dw_print_0 from w_g_tab0`dw_print_0 within w_pl_barcode_dett
end type

type st_ritorna from w_g_tab0`st_ritorna within w_pl_barcode_dett
integer x = 37
integer y = 256
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_pl_barcode_dett
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_pl_barcode_dett
integer x = 1664
integer y = 724
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_pl_barcode_dett
integer x = 37
integer y = 544
integer taborder = 0
end type

type st_stampa from w_g_tab0`st_stampa within w_pl_barcode_dett
integer x = 37
integer y = 352
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_pl_barcode_dett
integer x = 37
integer y = 1248
integer taborder = 90
end type

type cb_modifica from w_g_tab0`cb_modifica within w_pl_barcode_dett
integer x = 37
integer y = 640
integer taborder = 0
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_pl_barcode_dett
integer x = 37
integer y = 832
integer taborder = 0
end type

event cb_aggiorna::clicked;//
string k_return


	dw_dett_0.accepttext()

//	k_return = aggiorna_dati( )

//--- sistema il codice e i progressivi nella lista PADRI
	imposta_codice_progr( dw_lista_0 )
//--- sistema il codice e i progressivi nella lista FIGLI
	imposta_codice_progr( dw_groupage )
	
	k_return = aggiorna()		

	if Left(k_return, 1) = "1" or Left(k_return, 1) = "3" then
		k_return="1" + Mid(k_return, 2)
	else
		if Left(k_return, 1) = "2" then
			k_return=trim(k_return)
		else
			if Left(k_return, 1) = "0" then
				k_return = "0"
			end if
		end if
	end if

	if Left(k_return, 1) = "0" then
		dw_lista_0.resetupdate()
		dw_groupage.resetupdate()
		dw_dett_0.resetupdate()
		ki_lista_0_modifcato = false
		messagebox("Richiesta Aggiornamento", "Dati aggiornati correttamente")
	else
		messagebox("Richiesta Aggiornamento", "Operazione in errore: " + Mid(trim(k_return), 2))
	end if
	
	
end event

type cb_cancella from w_g_tab0`cb_cancella within w_pl_barcode_dett
integer x = 37
integer y = 736
integer taborder = 0
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_pl_barcode_dett
integer x = 37
integer y = 1152
integer taborder = 0
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_pl_barcode_dett
event ue_mousemove pbm_mousemove
integer x = 302
integer y = 584
integer width = 3099
integer height = 1016
integer taborder = 10
boolean titlebar = true
string title = "Proprieta~'  Piano di Lavorazione"
string dataobject = "d_pl_barcode_testa_1"
boolean controlmenu = true
boolean vscrollbar = false
boolean resizable = true
boolean hsplitscroll = false
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_sort = false
end type

event dw_dett_0::buttonclicked;call super::buttonclicked;//
string k_file 
st_esito kst_esito
kuf_ole kuf1_ole


kidw_selezionata.icon = ki_icona_normale  // toglie l'icona alla precedente dw che sta perdendo il fluoco
kidw_selezionata = this
kidw_selezionata.icon = ki_icona_selezionata  // mette l'conda di dw selezionata

try
		
	choose case dwo.name
		case "b_file_pilota"
			open_notepad_documento()

		case "b_queue_pilota"
			open_elenco_pilota_coda()
			
		case "b_chiudi"
			cb_chiudi.event clicked( ) //postevent(clicked!)
			this.visible = false

	end choose

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try

	
end event

event dw_dett_0::getfocus;//
//--- evitare lo script standard
//
kidw_selezionata = this
//ki_dw_focus_dataobject = this.dataobject
attiva_tasti( ) 
 
end event

event dw_dett_0::clicked;//

end event

event dw_dett_0::losefocus;//

end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_pl_barcode_dett
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_pl_barcode_dett
integer x = 1797
integer width = 1755
integer height = 1404
integer taborder = 20
boolean titlebar = true
string title = "Pianificazione irraggiamento - Trascina qui il Riferimento o Barcode."
string dataobject = "d_pl_barcode_dett_1"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_attiva_dragdrop = true
boolean ki_attiva_dragdrop_self = true
end type

event dw_lista_0::doubleclicked;//
if this.rowcount() < 2 then
	beep(1)
else
	call_window_barcode()
end if


end event

event dw_lista_0::getfocus;//
//this.icon = this.ki_icona_selezionata
//ki_dw_focus_dataobject = this.dataobject
kidw_selezionata = this
u_set_dw_icon( )

//attiva_tasti( ) 
end event

event dw_lista_0::clicked;call super::clicked;//if row > 0 then
////
////--- scompare la dw_modifica se perdo il fuoco
////
//	dw_modifica.visible = false
//end if

if dwo.name = "barcode_pl_barcode_progr_t" THEN
	
	u_sort(dwo.name)   // Esegue il SORT
	
end if


end event

event dw_lista_0::ue_lbuttondown;call super::ue_lbuttondown;//
if this.ki_attiva_DRAGDROP then
	ki_dragdrop = true
end if

end event

event dw_lista_0::ue_drop_out;call super::ue_drop_out;//
//datawindow kdw_1
string k_nome




//CHOOSE CASE TypeOf(source)

//	CASE datawindow!

 //  	kdw_1 = source
//		kdw_1.Drag(cancel!)

		if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then

			choose case kdw_source.classname()
					
				case "dw_meca" 
					u_aggiungi_barcode_tutti(dw_lista_0)
	
				case "dw_barcode" 
					u_aggiungi_barcode_singolo(dw_lista_0, dw_barcode)
					
				case "dw_groupage" 
					u_aggiungi_barcode_singolo(dw_lista_0, dw_groupage)
					
//				case "dw_lista_0" 
////--- sistema il codice e i progressivi nella lista
//					post imposta_codice_progr( kdw_source )
				
			end choose
			
			attiva_tasti()
			if isvalid(kdw_source) then
				kdw_source.setfocus()
			end if
						
		end if
		
//		ki_dragdrop = false
		
//END CHOOSE

return 1

end event

event dw_lista_0::ue_dropfromthis;call super::ue_dropfromthis;//
//--- dopo l'evento PARENT, sistema il codice e i progressivi nella lista
		imposta_codice_progr( kdw_source )

return 1
end event

event dw_lista_0::buttonclicked;call super::buttonclicked;//
kidw_selezionata.icon = ki_icona_normale  // toglie l'icona alla precedente dw che sta perdendo il fluoco
kidw_selezionata = this
kidw_selezionata.icon = ki_icona_selezionata  // mette l'conda di dw selezionata

if dwo.name = "b_previsioni" then
	
	this.Object.b_previsioni.Enabled='No'
	dw_prev.event u_run( )
	this.Object.b_previsioni.Enabled='Yes'
	
else
	if dwo.name = "b_stato_impianto" then
		
		this.Object.b_stato_impianto.Enabled='No'
		dw_pilota_inlav.event u_run( )
		this.Object.b_stato_impianto.Enabled='Yes'
		
	end if	
end if
end event

event dw_lista_0::losefocus;//

end event

type dw_guida from w_g_tab0`dw_guida within w_pl_barcode_dett
end type

type st_duplica from w_g_tab0`st_duplica within w_pl_barcode_dett
end type

type cb_chiudi from statictext within w_pl_barcode_dett
boolean visible = false
integer x = 37
integer y = 416
integer width = 160
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "chiudi"
boolean focusrectangle = false
end type

event clicked;//
//
integer k_elaborazione_ok=0
string k_errore = "0"
date k_data_chiuso, k_dataoggi


if dw_dett_0.rowcount( ) > 0 then

	if dw_lista_0.rowcount() <= 0 and dw_groupage.rowcount() <= 0 then
		messagebox("Operazione fallita", &
					"Nessun Barcode immesso nella pianificazione.~n~r" + &
					"~n~r" )

	else


		dw_dett_0.accepttext()
		dw_lista_0.accepttext()

		if cb_chiudi.enabled then
			cb_chiudi.enabled = false
	
				
			if ki_chiudi_PL_enabled then
				if ki_PL_chiuso then   
	
					k_elaborazione_ok = apri_pl()  // RIAPRE IL PIANO
					
				else
				
					k_data_chiuso = dw_dett_0.getitemdate ( 1, "data_chiuso") 
					if isnull(k_data_chiuso) or k_data_chiuso <= date(0) then
						k_dataoggi = kg_dataoggi
						dw_dett_0.setitem (1, "data_chiuso", k_dataoggi)
					end if
				
					k_elaborazione_ok = chiudi_pl()     // CHIUDE IL PIANO DI LAVORAZIONE
						
				end if
						
				if k_elaborazione_ok = 0 then
	
					kiuf1_sync_window.u_window_set_funzione_aggiornata(ki_st_open_w) // setta x sicronizzare il ritorno
					
					if ki_PL_chiuso then 
						messagebox("Operazione Conclusa", "Il Piano di Lavorazione è stato Riaperto correttamente.")
						
						smista_funz( KKG_FLAG_RICHIESTA.esci )  // Esce!
	//						ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
					else
						ki_chiudi_PL_enabled = false
						ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
						ki_st_open_w.key1 = string( dw_dett_0.getitemnumber(1, "codice")) 
				
						proteggi_campi()
						
						inizializza() 
						//attiva_tasti ()
					end if
					
				end if
			else
				messagebox("Operazione non Autorizzata", &
					"Utente non autorizzato al Chiudere/Riaprire il Piano di Lavorazione.~n~r" + &
					"~n~r" )
				
			end if
		end if
	end if
end if

cb_chiudi.enabled = true


end event

type cb_togli from statictext within w_pl_barcode_dett
boolean visible = false
integer x = 37
integer y = 192
integer width = 105
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "sub"
boolean focusrectangle = false
end type

event clicked;//

//	if kGuf_data_base.u_getfocus_nome() = "dw_lista_0" then
//		
//		if dw_lista_0.rowcount() <= 0 then 
//			
//			messagebox("Operazione fallita", &
//						  "Nessuna Barcode presente in lista 'barcode da trattare'.~n~r")
//		
//		else
			if dw_lista_0.getselectedrow(0) <= 0 then
		
				messagebox("Operazione fallita", &
						"Selezionare almeno un Barcode dalla lista 'barcode da trattare'.~n~r")
			else
	
				togli_barcode_padre(dw_lista_0)
			end if
//		end if
		
//	else
//		if dw_lista_0.rowcount() <= 0 then 
//			
//			messagebox("Operazione fallita", &
//						  "Nessuna Barcode presente in lista 'barcode in GROUPAGE'.~n~r")
//		
//		else
//			if dw_lista_0.getselectedrow(0) <= 0 then
//		
//				messagebox("Operazione fallita", &
//						"Selezionare almeno un Barcode dalla lista 'barcode in GROUPAGE'.~n~r")
//			else
//	
//				togli_barcode_figlio(dw_groupage)
//			end if
//		end if
//	end if

	attiva_tasti ()

	dw_lista_0.setfocus ()
	

end event

type cb_aggiungi from statictext within w_pl_barcode_dett
boolean visible = false
integer x = 37
integer y = 128
integer width = 101
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "add"
boolean focusrectangle = false
end type

event clicked;//
//string k_rc
//k_rc = kidw_selezionata.dataobject

	
	if kidw_selezionata.dataobject = dw_meca.dataobject then
		if dw_meca.getselectedrow(0) > 0 then
			u_aggiungi_barcode_tutti(dw_lista_0)
			kidw_selezionata.setfocus( )
		end if
	elseif kidw_selezionata.dataobject = dw_barcode.dataobject then
		if dw_barcode.getselectedrow(0) > 0 then
			u_aggiungi_barcode_singolo(dw_lista_0, dw_barcode)
			kidw_selezionata.setfocus( )
		end if
	else
		messagebox("Spostamento in Lvorazione", "Selezionare almeno una riga dall'elenco dei Lotti o Barcode da Trattare", information!)
	end if


end event

type dw_groupage from uo_d_std_1 within w_pl_barcode_dett
integer x = 1157
integer y = 1184
integer width = 869
integer height = 832
integer taborder = 50
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Groupage trascina il barcode per identificarlo come Figlio"
string dataobject = "d_pl_barcode_dett_grp_all"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean hsplitscroll = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_attiva_dragdrop = true
boolean ki_attiva_dragdrop_self = true
end type

event ue_lbuttondown;call super::ue_lbuttondown;//
ki_dw_fuoco_nome = this.dataobject
//
if this.ki_attiva_DRAGDROP then
	ki_dragdrop = true
end if

end event

event doubleclicked;//
if this.rowcount() < 2 then
	beep(1)
else
	call_window_barcode()
end if

attiva_tasti ()


end event

event getfocus;//
//this.icon = this.ki_icona_selezionata
//ki_dw_focus_dataobject = this.dataobject
kidw_selezionata = this
u_set_dw_icon( )

//attiva_tasti( ) 
end event

event rowfocuschanged;////
//if not k_dragdrop then
//	Super::EVENT rowfocuschanged(currentrow)
//end if
//
end event

event clicked;call super::clicked;//


	kidw_selezionata.icon = ki_icona_normale  // toglie l'icona alla precedente dw che sta perdendo il fluoco
	kidw_selezionata = this
	kidw_selezionata.icon = ki_icona_selezionata  // mette l'conda di dw selezionata
	
	if dwo.name = "scegli_padre" or dwo.name = "img_b_scegli_padre"  then
		post scegli_padre_da_dw_lista(row)
	end if


end event

event itemchanged;call super::itemchanged;//
attiva_tasti ()

end event

event losefocus;//
// non fare il focus del super
end event

event ue_drop_out;call super::ue_drop_out;////
//datawindow kdw_1
//string k_nome
//
//CHOOSE CASE TypeOf(source)
//
//	CASE datawindow!
//
//		kdw_1 = source
//	 
//		if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
			
			choose case kdw_source.classname()
					
				case "dw_meca"  
					u_aggiungi_grp_rif_intero(dw_groupage)
	
				case "dw_barcode" 
					u_aggiungi_grp_barcode_singolo(dw_barcode)
					
				case "dw_lista_0" 
					u_aggiungi_grp_barcode_singolo(dw_lista_0)
					
			end choose
			
			attiva_tasti ()
			if isvalid(kdw_source) then
				kdw_source.setfocus()
			end if
			
//		end if
//		ki_dragdrop = false
//		kdw_1.Drag(cancel!)
//
//		
//END CHOOSE
//

return 1
end event

type dw_barcode from uo_d_std_1 within w_pl_barcode_dett
integer x = 55
integer y = 1236
integer width = 1390
integer taborder = 30
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Dettaglio Riferimento"
string dataobject = "d_barcode_l_no_pl"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean hsplitscroll = false
boolean ki_link_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_attiva_dragdrop = true
end type

event ue_lbuttondown;call super::ue_lbuttondown;//
ki_dw_fuoco_nome = this.dataobject
//
if this.ki_attiva_DRAGDROP then
	ki_dragdrop = true
end if

end event

event u_doppio_click;//
if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then

	u_aggiungi_barcode_singolo(dw_lista_0, dw_barcode)

end if



end event

event getfocus;////
//
//this.icon = "Exclamation!"
kidw_selezionata.icon = ki_icona_normale  // toglie l'icona alla precedente dw che sta perdendo il fluoco
kidw_selezionata = this
kidw_selezionata.icon = ki_icona_selezionata  // mette l'conda di dw selezionata

if this.rowcount() > 0 then
	this.title = "Dettaglio Riferimento: " + string(this.getitemnumber(1, "barcode_num_int"))
else
	this.title = "Dettaglio Riferimento " 
end if

u_set_dw_icon( )

// attiva_tasti( ) 
end event

event losefocus;//
if this.rowcount() > 0 then
	this.title = "Dettaglio Riferimento: " + string(this.getitemnumber(1, "barcode_num_int"))
else
	this.title = "Dettaglio Riferimento " 
end if

end event

event rowfocuschanged;//

if ki_dragdrop = false then
	
	super::EVENT rowfocuschanged(currentrow)

end if

end event

event clicked;call super::clicked;//
//--- scompare la dw_modifica se perdo il fuoco
//
//	dw_modifica.visible = false
   ki_dw_fuoco_nome = this.dataobject
 

end event

event ue_drop_out;call super::ue_drop_out;//
long k_riga
datawindow kdw_1


//CHOOSE CASE TypeOf(source)
//
//	CASE datawindow!
//
//   	kdw_1 = source

		if kdw_source.DataObject = "d_pl_barcode_dett_1" then
			togli_barcode_padre(dw_lista_0)
		elseif kdw_source.DataObject = "d_pl_barcode_dett_grp_all" then
			togli_barcode_figlio(dw_groupage)
		elseif kdw_source.DataObject = "d_meca_barcode_elenco_no_lav" then
			k_riga = kdw_source.getselectedrow(0)
//--- ripopola dw di dettaglio barcode (dw_barcode)
			u_dw_barcode_retrieve(k_riga)
		end if

		attiva_tasti()
		if isvalid(kdw_source) then
			kdw_source.setfocus()
		end if
			
//		
//		ki_dragdrop = false
//		source.Drag(cancel!)
//		
//
//END CHOOSE

return 1
end event

type dw_meca from uo_d_std_1 within w_pl_barcode_dett
event u_selectrow_false ( long a_row,  string a_fila )
event u_selectrow_false_all ( string a_fila )
event u_selectrow_true ( long a_row,  string a_fila )
event u_restore_k_choose ( ref datastore kds_meca_kchoose,  string a_fila )
event ue_set_pos_evidenzia_area_mag ( )
event ue_pbmlbuttonup pbm_lbuttonup
integer x = 5
integer width = 2103
integer height = 1040
integer taborder = 40
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Elenco Riferimenti senza P.L."
string dataobject = "d_meca_barcode_elenco_no_lav"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean ki_link_standard_sempre_possibile = true
boolean ki_attiva_dragdrop = true
end type

event u_selectrow_false(long a_row, string a_fila);//
	//this.selectrow(a_row, false)
	this.setitem(a_row, "k_choose_" + trim(a_fila), 2)

//--- se entrambe i flag FILA sono sisattivat allora azzzero anche il n.priorità	
	if a_fila = "1" then 
		a_fila = "2"
	else
		a_fila = "1"
	end if
	if this.getitemnumber(a_row, "k_choose_" + trim(a_fila)) = 2 then
		this.setitem(a_row, "k_nchoosed", 9999)		
	end if

end event

event u_selectrow_false_all(string a_fila);//
long k_row, k_rows, k_ctr
int k_nrowsel


	setpointer(kkg.pointer_attesa)
	
	k_nrowsel = this.getItemnumber ( 1 , "knrow_choosed_" + trim(a_fila) )
	if k_nrowsel > 0 then
	
		k_rows = this.rowcount()
		for k_row = 1 to k_rows
			if this.getitemnumber(k_row, "k_choose_" + trim(a_fila)) = 1 then
				k_ctr ++
				this.event u_selectrow_false(k_row, a_fila)
				if k_ctr > k_nrowsel then
					//ki_nchoosed = 0
					exit
				end if
			end if
		next
		
	end if
	
	setpointer(kkg.pointer_default)

end event

event u_selectrow_true(long a_row, string a_fila);//

	this.setitem(a_row, "k_choose_" + trim(a_fila), 1)
	
	ki_nchoosed ++
	this.setitem(a_row, "k_nchoosed", ki_nchoosed)		
	
end event

event u_restore_k_choose(ref datastore kds_meca_kchoose, string a_fila);//
//--- ripristino del flag di selezionato Fila 1 e 2
//--- input DS con i dati da ripristinare
//
long k_riga, k_righe_meca, k_riga_find=0, k_max_ds_choose
string k_find_txt


//--- ripristino i Lotti selezionati
	if isvalid(kds_meca_kchoose) then
		k_max_ds_choose = kds_meca_kchoose.rowcount()
		k_righe_meca = dw_meca.rowcount()
		if k_righe_meca > 0 and k_max_ds_choose > 0 then
			k_riga = kds_meca_kchoose.find("k_choose_" + trim(a_fila) + " = 1", 1, k_max_ds_choose)
			do while k_riga > 0
				k_find_txt = "id_meca = " + string(kds_meca_kchoose.getitemnumber(k_riga, "id_meca")) &
							+ " and barcode_fila_1 = " + string(kds_meca_kchoose.getitemnumber(k_riga, "barcode_fila_1")) &
							+ " and barcode_fila_2 = " + string(kds_meca_kchoose.getitemnumber(k_riga, "barcode_fila_2")) 
				k_riga_find = dw_meca.find(k_find_txt, 1, k_righe_meca)
				if k_riga_find > 0 then
					dw_meca.setitem(k_riga_find, "k_choose_" + trim(a_fila), 1)
					dw_meca.setitem(k_riga_find, "k_nchoosed", kds_meca_kchoose.getitemnumber(k_riga, "k_nchoosed"))
				end if 
				if k_riga = k_max_ds_choose then
					k_riga = 0
				else
					k_riga ++
					k_riga = kds_meca_kchoose.find("k_choose_" + trim(a_fila) + " = 1", k_riga, k_max_ds_choose)
				end if
			loop
		end if	
	end if
end event

event ue_set_pos_evidenzia_area_mag();//
long k_width_img, k_width_col //, k_x_col
long k_x_img
//string k_rc

	
//		k_width_col = long(this.describe("meca_area_mag_t.width"))
//		k_x_col = long(this.describe("meca_area_mag_t.x"))
//		k_width_img = 37 //long(this.describe("evidenzia_area_mag.width"))
//      k_x_img = k_x_col + k_width_col - k_width_img
//		k_rc = "evidenzia_area_mag.width = 37 " &
//				+ "evidenzia_area_mag.x = " + string(k_x_img)
//		k_rc = this.modify(k_rc)
	this.object.evidenzia_area_mag.width = 37
	k_width_col = long(this.object.meca_area_mag.width)
	k_x_img = long(this.object.meca_area_mag.x) + (k_width_col - 37)
	this.object.meca_area_mag_t.width = k_width_col
	this.object.evidenzia_area_mag.x = k_x_img
	this.object.meca_area_mag.width = k_width_col
	
end event

event ue_pbmlbuttonup;//
	event post ue_set_pos_evidenzia_area_mag( )

end event

event ue_lbuttondown;call super::ue_lbuttondown;//
ki_dw_fuoco_nome = this.dataobject
//
if this.ki_attiva_DRAGDROP then
	ki_dragdrop = true
end if

end event

event getfocus;//
kidw_selezionata.icon = ki_icona_normale  // toglie l'icona alla precedente dw che sta perdendo il fluoco
kidw_selezionata = this
kidw_selezionata.icon = ki_icona_selezionata  // mette l'conda di dw selezionata

dw_barcode.SelectRow(0, FALSE)

u_set_dw_icon( )
//attiva_tasti( ) 
end event

event rowfocuschanged;//

if ki_dragdrop = false then
	
	super::EVENT rowfocuschanged(currentrow)

end if

end event

event u_doppio_click;//
long k_riga


//	k_riga = this.getrow()
//	u_riempi_dettaglio(k_riga)
//--- ripopola dw di dettaglio barcode (dw_barcode)
	u_dw_barcode_retrieve(a_row)
	this.setfocus()
//	this.deleterow(k_riga)

end event

event losefocus;//
this.accepttext( )
//attiva_menu( )

end event

event clicked;//
//--- scompare la dw_modifica se perdo il fuoco
//
long k_riga= 0
string k_rcx


   ki_dw_fuoco_nome = this.dataobject
//	dw_modifica.visible = false

	choose case	dwo.name 
		case "grp" 
//		super::event ue_selectrow (row)
			k_riga = this.u_selectrow_onclick(row)
			if k_riga > 0 then this.setrow(k_riga)
			
			post call_elenco_grp()
			
		case "meca_consegna_dataora"	
			// nulla
			
		case "k_choose_t"
			super::event clicked( xpos, ypos, row, dwo)
			
		case "k_choose_clear_1" &
			  ,"k_choose_clear_2"
			//vedi buttonclicked event u_selectrow_false_all( )
			
		case else
			super::event clicked( xpos, ypos, row, dwo)
		
	end choose
	
	
end event

event ue_dwnkey;call super::ue_dwnkey;//
if key = keyF12! then
	
	smista_funz( KKG_FLAG_RICHIESTA.libero3 )  // attiva/disattiva Lotto "in Attenzione"
	
end if

end event

event itemchanged;call super::itemchanged;//
//
st_tab_meca kst_tab_meca
date k_date
time k_time
int k_yy, k_yy_now, k_mm, k_mm_now, k_dd, k_dd_now

choose case dwo.name 

	case "meca_consegna_dataora" 

		kst_tab_meca.id = this.getitemnumber(row, "id_meca")
		if IsDate(left(trim(data),10)) then
			
			k_date = date(trim(data)) //this.getitemdatetime(row, string(dwo.name))
			k_dd = day(k_date)
			k_mm = month(k_date)
			k_yy = year(k_date)
			k_time = time(datetime(trim(data))) //this.getitemdatetime(row, string(dwo.name))
			k_dd_now = day(kguo_g.get_dataoggi( ))
			k_mm_now = month(kguo_g.get_dataoggi( ))
			k_yy_now = year(kguo_g.get_dataoggi( ))
			
			if k_dd = 01 and k_mm = 01 and k_time = time("00:00") then
				setnull(kst_tab_meca.consegna_data)
				setnull(kst_tab_meca.consegna_ora)
			else
				if k_mm < k_mm_now then
					if k_dd < k_dd_now then
						k_mm = k_mm_now + 1
					else
						k_mm = k_mm_now
					end if
				end if
				if k_yy < k_yy_now then
					if month(kguo_g.get_dataoggi( )) > 9 then
						if month(kguo_g.get_dataoggi( )) < k_mm then
							k_yy = k_yy_now + 1
						else
							k_yy = k_yy_now
							k_mm = month(kguo_g.get_dataoggi( ))
						end if
					else
						k_yy = k_yy_now
					end if
				end if
				kst_tab_meca.consegna_data = date(k_yy, k_mm, day(k_date))
				kst_tab_meca.consegna_ora = time(k_time)
			end if
			post u_aggiorna_data_consegna(kst_tab_meca, row)		
		else
			if isnull(data) or (k_dd = 01 and k_mm = 01 and k_time = time("00:00")) then
				setnull(kst_tab_meca.consegna_data)
				setnull(kst_tab_meca.consegna_ora)
				post u_aggiorna_data_consegna(kst_tab_meca, row)		
			end if
		end if

		case "k_choose_1", "k_choose_2"
			if data = "1" then
			//if this.getitemnumber(row, trim(dwo.name)) = 1 then
			//	this.post event u_selectrow_false(row, mid(trim(dwo.name), 10, 1))
			//else
				this.post event u_selectrow_true(row, mid(trim(dwo.name), 10, 1))
				if dwo.name = "k_choose_1" then
					this.post event u_selectrow_false(row, "2")
				else
					this.post event u_selectrow_false(row, "1")
				end if
			end if

end choose
end event

event buttonclicked;call super::buttonclicked;			
if left(trim(dwo.name), 15) = "k_choose_clear_" then
	event u_selectrow_false_all(mid(dwo.name, 16, 1))
end if

end event

event ue_drop_out;call super::ue_drop_out;//
//datawindow kdw_1
//
//
//CHOOSE CASE TypeOf(source)
//
//	CASE datawindow!
//
//   	kdw_1 = source

//		if ki_dragdrop then
			
			CHOOSE CASE kdw_source.DataObject 
				case "d_pl_barcode_dett_1"
					togli_barcode_padre(dw_lista_0)
				case "d_pl_barcode_dett_grp_all"
					togli_barcode_figlio(dw_groupage)
				case "d_barcode_l"
					togli_dettaglio()
//					
//				case else
//					super::event dragdrop(source, row, dwo)
				
			end choose
			
			attiva_tasti()
			this.setfocus( )
			
//		end if
//
//END CHOOSE

//ki_dragdrop = false

//this.setcolumn(1)

return 1
end event

type dw_periodo from uo_d_std_1 within w_pl_barcode_dett
integer y = 848
integer width = 955
integer height = 504
integer taborder = 70
boolean enabled = true
boolean titlebar = true
string title = "Periodo di estrazione"
string dataobject = "d_periodo"
boolean controlmenu = true
boolean hsplitscroll = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;//
st_stampe kst_stampe
pointer oldpointer  // Declares a pointer variable

	
//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)
	

if dwo.name = "b_ok" then
	
	
	this.visible = false
	
	ki_data_ini  = this.getitemdate( 1, "data_dal")
	ki_data_fin  = this.getitemdate( 1, "data_al")
	//u_rilegge_no_lav()
	ki_riga_pos_dw_meca = dw_meca.getrow( )  //cattura la riga selezionata
//		if ki_riga_pos_dw_meca > 0 then
//			ki_id_meca_pos_dw_meca = dw_meca.getitemnumber( ki_riga_pos_dw_meca, "id_meca")
//		end if
//	kids_meca_orig.reset()
	leggi_liste()

else
	if dwo.name = "b_annulla" then

		this.visible = false
	
	
	end if
end if

SetPointer(oldpointer)


end event

event ue_visibile;call super::ue_visibile;//
int k_rc

	this.width = long(this.object.data_al.x) + long(this.object.data_al.width) + 100
	this.height = long(this.object.b_ok.y) + long(this.object.b_ok.height) + 160

	this.x = (kiw_this_window.width  - this.width) / 4
	this.y = (kiw_this_window.height - this.height) / 4

	this.reset()
	k_rc = this.insertrow(0)
	k_rc = this.setitem(1, "data_dal", ki_data_ini)
	k_rc = this.setitem(1, "data_al", ki_data_fin)
	this.object.data_al.Edit.DisplayOnly='Yes'
	this.object.data_al.Background.Color=kkg_colore.CAMPO_DISATTIVO
	this.object.data_al.TabSequence='0'
	this.visible = true
	this.setfocus()
	
end event

type dw_prev from uo_d_std_1 within w_pl_barcode_dett
event u_show ( )
event u_run ( )
integer x = 9998
integer y = 10000
integer width = 3456
integer height = 1208
integer taborder = 100
boolean bringtotop = true
boolean titlebar = true
string title = "Previsioni"
string dataobject = "d_pilota_queue_table_x_pl_dett"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean border = true
boolean ki_colora_riga_aggiornata = false
boolean ki_dw_visibile_in_open_window = false
end type

event u_show();//
if ki_dw_prev_firsttime then
	ki_dw_prev_firsttime = false
	
	this.x = parent.width * 0.05
	this.y = parent.height * 0.65
	this.width = (parent.width - (this.x * 2)) - 100
	if this.width > 4600 then this.width = 4600  // inutile farlo più grande
	this.height = parent.height - this.y - 100

end if

this.enabled = true
this.visible = true
	

end event

event u_run();//
long k_rows, k_rows_retrieve, k_row_found, k_row, k_rows_dw_lista_0
boolean k_pl_chiuso = false 	
datawindow kdw_lista
datastore kds_1


try
	
	kguo_exception.inizializza(this.classname())
	
	setpointer(kkg.pointer_attesa)
	
	if this.rowcount( ) > 0 then
		this.reset( )
	end if
	if isvalid(dw_lista_0) then 

		if not isvalid(kiuf_pilota_previsioni) then kiuf_pilota_previsioni = create kuf_pilota_previsioni

		if dw_dett_0.rowcount( ) > 0 then
			if dw_dett_0.getitemdate( 1, "data_chiuso") > kkg.data_zero then
				k_pl_chiuso = true 	
			end if
		end if
		
//--- se PL chiuso non passo i barcode perchè si presuppone siano già inviato alla coda		
		if	k_pl_chiuso then
			kdw_lista = create datawindow 
			kdw_lista.dataobject = dw_lista_0.dataobject
		else
			kdw_lista = dw_lista_0
		end if
		
		kds_1 = kiuf_pilota_previsioni.get_ds_pallet_workqueue_by_d_pl_barcode(kdw_lista)
		if isvalid(kds_1) then
			k_rows = kds_1.rowcount()
			if k_rows > 0 then
		
				this.dataobject = "d_pilota_queue_table_x_pl_dett"
			
				kguf_data_base.u_set_ds_change_name_tab(kidw_this, "vx_MAST_pilota_pallet_workqueue" )
				this.settransobject(kguo_sqlca_db_magazzino)
		
				k_rows_retrieve = this.retrieve()
				
				k_rows_dw_lista_0 = dw_lista_0.rowcount()
				if k_rows_dw_lista_0 > 0 and k_rows_retrieve > 0 then
					
					for k_row = 1 to k_rows_retrieve
						k_row_found = dw_lista_0.find("barcode_barcode = '" + this.getitemstring(k_row, "barcode") + "'", 1, k_rows_dw_lista_0, primary!)
						if k_row_found > 0 then
							dw_lista_0.setitem(k_row_found, "k_dataora_lav_ini_prev", this.getitemdatetime(k_row, "k_dataora_lav_ini"))
							dw_lista_0.setitem(k_row_found, "k_dataora_lav_fin_prev", this.getitemdatetime(k_row, "k_dataora_lav_prev_fin"))
						end if
					next
					
				end if
				
			end if
		end if

	end if

	this.event u_show( )
	if k_rows_retrieve > 0 then
		this.scrolltorow(k_rows)
		this.setrow(k_rows)
	end if
	
catch (uo_exception kuo_exception)
	
finally
	setpointer(kkg.pointer_default)
	
end try
	

end event

event resize;call super::resize;//
if sizetype = 1 then //SIZE_MINIMIZED
	ki_dw_prev_firsttime = true
end if
end event

event getfocus;call super::getfocus;//
kidw_selezionata.icon = ki_icona_normale  // toglie l'icona alla precedente dw che sta perdendo il fluoco
kidw_selezionata = this
kidw_selezionata.icon = ki_icona_selezionata  // mette l'conda di dw selezionata

end event

event losefocus;//

end event

type dw_pilota_inlav from uo_d_std_1 within w_pl_barcode_dett
event u_show ( )
event u_run ( )
event u_hide ( )
integer x = 9998
integer y = 11228
integer width = 3456
integer height = 1208
integer taborder = 110
boolean bringtotop = true
boolean titlebar = true
string title = "Barcode in lavorazione in impianto"
string dataobject = "d_pilota_inlav"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean border = true
boolean ki_colora_riga_aggiornata = false
boolean ki_db_conn_standard = false
boolean ki_dw_visibile_in_open_window = false
end type

event u_show();//
if ki_dw_pilota_inlav_firsttime then
	ki_dw_pilota_inlav_firsttime = false
	
	this.x = parent.width * 0.05
	this.y = parent.height * 0.30
	this.width = (parent.width - (this.x * 2)) - 100
	if this.width > 4600 then this.width = 4600  // inutile farlo più grande
	this.height = parent.height - this.y - 100

end if

this.enabled = true
this.visible = true
	

end event

event u_run();//
long k_rows_retrieve, k_rc
kuf_ausiliari kuf1_ausiliari
st_tab_imptime kst_tab_imptime
long k_tempo_impianto_secondi
int k_pos
string k_sql, k_rcx


try
	
	kguo_exception.inizializza(this.classname())
	
	setpointer(kkg.pointer_attesa)
	
	if this.rowcount( ) > 0 then
		this.reset( )
	end if
	
	kuf1_ausiliari = create kuf_ausiliari
	kuf1_ausiliari.tb_imptime_get(kst_tab_imptime)
	k_tempo_impianto_secondi = kst_tab_imptime.tminute * 60 + kst_tab_imptime.tsecond

	this.dataobject = "d_pilota_inlav"
	k_sql = this.Describe("DataWindow.Table.SQLSelect")
	k_pos = pos(k_sql, "250")
	k_sql = left(k_sql, k_pos - 1) + string(k_tempo_impianto_secondi) + mid(k_sql, k_pos + 3)
	//k_rcx = this.modify("DataWindow.Table.Select = '" + k_sql + "'")
			
	this.title = "Barcode in lavorazione in impianto ora locale " + string(now(), "hh:mm:ss") + " (tempo a step " + string(k_tempo_impianto_secondi) + " secondi)"
	
	k_rc = this.settrans(kguo_sqlca_db_pilota)  // conn/disconn in automatico ad ogni operaz
	k_rc = this.SetSQLSelect(k_sql)
	k_rows_retrieve = this.retrieve()
				
	this.event u_show( )
	
catch (uo_exception kuo_exception)
	
finally
	if isnull(kuf1_ausiliari) then destroy kuf1_ausiliari
	setpointer(kkg.pointer_default)
	
end try
	

end event

event u_hide();//

this.enabled = false
this.visible = false
	

end event

event resize;call super::resize;//
if sizetype = 1 then //SIZE_MINIMIZED
	ki_dw_pilota_inlav_firsttime = true
end if

end event

event getfocus;call super::getfocus;//
kidw_selezionata.icon = ki_icona_normale  // toglie l'icona alla precedente dw che sta perdendo il fluoco
kidw_selezionata = this
kidw_selezionata.icon = ki_icona_selezionata  // mette l'conda di dw selezionata

end event

event losefocus;//

end event

