$PBExportHeader$w_pl_barcode_dett_g3.srw
forward
global type w_pl_barcode_dett_g3 from w_g_tab0
end type
type dw_meca from uo_d_std_1 within w_pl_barcode_dett_g3
end type
type dw_barcode from uo_d_std_1 within w_pl_barcode_dett_g3
end type
type dw_groupage from uo_d_std_1 within w_pl_barcode_dett_g3
end type
type dw_periodo from uo_d_std_1 within w_pl_barcode_dett_g3
end type
type cb_aggiungi from statictext within w_pl_barcode_dett_g3
end type
type cb_chiudi from statictext within w_pl_barcode_dett_g3
end type
type dw_pilota_inlav from uo_d_std_1 within w_pl_barcode_dett_g3
end type
type cb_togli from statictext within w_pl_barcode_dett_g3
end type
type dw_g3ciclo_alt from datawindow within w_pl_barcode_dett_g3
end type
end forward

global type w_pl_barcode_dett_g3 from w_g_tab0
integer width = 4037
integer height = 3180
long backcolor = 16777215
windowanimationstyle openanimation = rightroll!
boolean ki_toolbar_window_presente = true
boolean ki_reset_dopo_save_ok = false
dw_meca dw_meca
dw_barcode dw_barcode
dw_groupage dw_groupage
dw_periodo dw_periodo
cb_aggiungi cb_aggiungi
cb_chiudi cb_chiudi
dw_pilota_inlav dw_pilota_inlav
cb_togli cb_togli
dw_g3ciclo_alt dw_g3ciclo_alt
end type
global w_pl_barcode_dett_g3 w_pl_barcode_dett_g3

type variables
//
private constant long ki_dw_groupage_colore = rgb(173,174,222)
//private boolean ki_dragdrop = false
private boolean ki_chiudi_PL_enabled = false
private boolean ki_PL_chiuso = false
private boolean ki_operazione_chiusura = false
private boolean ki_consenti_lavoraz_non_associati_wmf = false
private date ki_data_ini 
private date ki_data_fin 

private boolean ki_lista_0_modifcato=false

private kuf_pl_barcode kiuf_pl_barcode
private kuf_armo kiuf_armo
private kuf_barcode kiuf_barcode
private kuf_barcode_mod_giri kiuf_barcode_mod_giri
private kuf_asdrackbarcode kiuf_asdrackbarcode
private kuf_barcode_asd kiuf_barcode_asd
private kuf_clienti kiuf_clienti
private kuf_prodotti kiuf_prodotti
private kuf_sl_pt kiuf_sl_pt
private kuf_impianto kiuf_impianto
private kuf_pilota_previsioni_g3 kiuf_pilota_previsioni_g3
private kuf_sl_pt_g3 kiuf_sl_pt_g3

private kds_sl_pt_g3_lav_if_datilav_ok kids_sl_pt_g3_lav_if_datilav_ok

private boolean ki_autorizza_marca_stato_in_attenzione=false

//private string ki_dw_fuoco_nome = ""  // datawindow da cui ho iniziato a fare il drag&drop

private long ki_riga_pos_dw_meca = 0

private kuf_e1_asn kiuf_e1_asn
private boolean ki_e1_enabled = false

private int ki_nchoosed

private boolean ki_refresh_dw_meca_needed=false

private boolean ki_save_for_crash_insert=false

private boolean ki_dw_pilota_inlav_firsttime=true

private integer ki_g3ciclo_alt
private string ki_dw_source_name

private constant int kki_impianto = kiuf_impianto.kki_impiantog3 //G3
private string ki_impianto_des

private uo_ds_std_1 kdsi_elenco_output_1

private ds_pilota_queue_g3_last_in kids_pilota_queue_g3_last_in
private ds_storico_mastertimer_tempo_last kids_storico_mastertimer_tempo_last

end variables

forward prototypes
public subroutine u_set_dw_icon ()
protected subroutine open_start_window ()
private function long u_aggiungi_barcode_tutti_check (st_tab_meca ast_tab_meca, long a_meca_row)
private function long u_dw_barcode_retrieve (long a_riga_meca)
private function boolean if_lotto_associato (ref st_tab_meca ast_tab_meca) throws uo_exception
private function boolean if_lotto_rack_asscociati () throws uo_exception
private subroutine if_lotto_rack_con_padri () throws uo_exception
private subroutine copia_dw_groupage_to_dw_barcode (integer k_riga1, integer k_riga2)
private subroutine copia_dw_groupage_to_dw_lista_0 (integer k_riga1, integer k_riga2)
private subroutine copia_dw_lista_0_to_dw_barcode (integer k_riga1, integer k_riga2)
private function boolean if_pl_barcode_chiuso ()
public subroutine u_aggiorna_data_consegna (st_tab_meca kst_tab_meca, long k_riga)
private subroutine u_aggiungi_barcode_padre (st_tab_barcode kst_tab_barcode)
private subroutine u_aggiungi_figli_dal_dw_lista (long a_row)
private subroutine screma_lista_from_dw_lista (long a_riga)
private subroutine screma_lista_from_dw_xxx_1 (long a_riga, ref datawindow adw_inp)
protected function boolean u_resize_predefinita ()
protected subroutine u_resize ()
public subroutine u_obj_visible_0 ()
protected subroutine u_dw_groupage_colore (ref datawindow k_dw)
private subroutine u_abilita_chiusura_pl ()
private subroutine u_autorizza_stato_in_attenzione ()
private function boolean u_autorizza_mod_consegna_data ()
private subroutine u_crash_reset ()
private subroutine u_crash_dw_lista_0_restore ()
private subroutine u_crash_dw_lista_0_backup ()
private subroutine u_check_troppi_barcode ()
public function string u_check_programmazione ()
private subroutine apri_pl_elabora () throws uo_exception
private function integer apri_pl ()
private subroutine chiudi_pl_elabora () throws uo_exception
protected function boolean if_programmazione_rack_completa () throws uo_exception
protected function boolean if_programmazione_ok () throws uo_exception
private function st_esito retrieve_figli_all ()
private function st_esito retrieve_figlio_nel_dw_groupage (long a_riga)
private function integer chiudi_pl ()
private subroutine proteggi_campi ()
protected function string inizializza () throws uo_exception
public function long togli_barcode_figlio (boolean k_esponi_msg)
public subroutine togli_barcode_padre ()
public subroutine togli_dettaglio ()
private function integer call_window_barcode ()
public subroutine togli_barcode_figlio_post (long a_id_meca)
private subroutine screma_lista_from_dw_groupage (long a_riga)
protected function string inizializza_post ()
protected function string aggiorna_dati ()
protected function string aggiorna_tabelle ()
protected function string leggi_liste ()
private function st_esito screma_lista_riferimenti_from_dw_all ()
public subroutine u_marca_rif_file_davanti ()
public subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
protected subroutine attiva_tasti_0 ()
public subroutine set_stato_in_attenzione ()
public subroutine u_mostra_proprieta (boolean k_forza_visible)
private subroutine set_dw_dett_0 (st_tab_pl_barcode kst_tab_pl_barcode)
public subroutine set_base_data_ini ()
private subroutine open_elenco_lettore_grp ()
private subroutine open_elenco_pilota_coda () throws uo_exception
public subroutine call_elenco_grp ()
private subroutine cambia_periodo_elenco ()
protected function string cancella ()
protected function string dati_modif (string k_titolo)
protected function boolean dati_modif_1 ()
protected function integer inserisci ()
protected subroutine pulizia_righe ()
protected subroutine riempi_id ()
private subroutine screma_lista_dw_barcode ()
private subroutine u_refresh_dw ()
private subroutine togli_figli_al_dw_groupage (st_tab_barcode kst_tab_barcode)
protected subroutine stampa ()
private function long u_check_rif_file_davanti (long a_riga_inp)
protected function string check_dati ()
public subroutine u_aggiungi_a_dw_lista (string a_dw_name)
private subroutine u_set_dragdrop ()
private subroutine scegli_padre_da_dw_lista (long a_riga_dw_groupage)
private function boolean u_open_w_armo_sl_pt_g3_lav ()
private subroutine u_aggiungi_figli_al_dw_groupage (long a_row)
private function boolean u_stop_if_lotto_in_attenzione (long a_row_meca)
private function boolean u_stop_if_lotto_non_associato (ref st_tab_meca kst_tab_meca) throws uo_exception
public subroutine u_aggiungi_barcode_singolo (ref uo_d_std_1 adw_out, ref uo_d_std_1 adw_inp)
private subroutine u_aggiungi_barcode_tutti (ref uo_d_std_1 adw_out)
public subroutine u_aggiungi_barcode_singolo_check (ref uo_d_std_1 adw_inp) throws uo_exception
private function long u_aggiungi_barcode_tutti_1 (long a_row, ref uo_d_std_1 adw_out)
private subroutine u_aggiungi_grp_barcode_singolo (ref uo_d_std_1 kdw_2)
private function boolean u_aggiungi_grp_barcode_singolo_if (ref uo_d_std_1 adw_2, long a_riga_dw2)
public subroutine u_aggiungi_grp_rif_intero (ref uo_d_std_1 kdw_1)
private subroutine imposta_codice_progr (ref datawindow kdw_1)
private subroutine imposta_id_sl_pt_g3 (ref datawindow kdw_1, long a_row_to_check) throws uo_exception
private subroutine copia_dw_barcode_to_dw_groupage (integer k_row1, integer k_row2) throws uo_exception
private subroutine copia_dw_barcode_to_dw_lista_0 (integer k_row1, integer k_row2)
private subroutine copia_dw_lista_0_to_dw_groupage (integer k_row1, integer k_row2) throws uo_exception
end prototypes

public subroutine u_set_dw_icon ();
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

protected subroutine open_start_window ();//
int k_rc
st_tab_pl_barcode kst_tab_pl_barcode
kuf_base kuf1_base
kuf_impianto kuf1_impianto


try
	
	kiuf_pl_barcode = create kuf_pl_barcode								
	kiuf_armo = create kuf_armo								
	kiuf_e1_asn = create kuf_e1_asn
	kiuf_asdrackbarcode = create kuf_asdrackbarcode
	kiuf_barcode = create kuf_barcode
	kiuf_barcode_asd = create kuf_barcode_asd
	kids_sl_pt_g3_lav_if_datilav_ok = create kds_sl_pt_g3_lav_if_datilav_ok
	kiuf_clienti = create kuf_clienti
	kiuf_prodotti = create kuf_prodotti
	kiuf_sl_pt = create kuf_sl_pt		

	kuf1_base = create kuf_base
	kuf1_impianto = create kuf_impianto

	kids_storico_mastertimer_tempo_last = create ds_storico_mastertimer_tempo_last
	
	ki_toolbar_window_presente=true
	
	kidw_selezionata = dw_meca
	
//--- cambia colore alla dw del groupage x distinguerla da quella normale
	u_dw_groupage_colore(dw_groupage)
	
	ki_e1_enabled = kguo_g.if_e1_enabled( )			// interfaccia E1 attiva?
	
//--- abilita la funzione di Chiusura del PL
	u_abilita_chiusura_pl()	
	
//--- get descrizione dell'impianto		
	ki_impianto_des = " -> IMPIANTO " + kuf1_impianto.get_descr(kki_impianto)
	
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

catch (uo_exception ki_e1_enabled)
	ki_e1_enabled.messaggio_utente()
	cb_chiudi.post event clicked( )
	
finally 
	if isvalid(kuf1_base) then destroy kuf1_base
	if isvalid(kuf1_impianto) then destroy kuf1_impianto
	
end try
end subroutine

private function long u_aggiungi_barcode_tutti_check (st_tab_meca ast_tab_meca, long a_meca_row);//
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
kuf_barcode_mod_giri kuf1_barcode_mod_giri 
kuf_response3 kuf1_response3


try 

	kst_esito = kguo_exception.inizializza(this.classname())

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
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Lotto n. " + string(ast_tab_meca.num_int ) + ", tutti i barcode da aggiungere al piano devono essere schermati (associati al Rack). Pianificazione non consentita!"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

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
			
	
catch(uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	if kst_esito.esito <> kkg_esito.ok then
		throw kuo_exception
	end if

finally
	if isvalid(kuf1_response3) then destroy kuf1_response3

	
end try 
	
return k_return
end function

private function long u_dw_barcode_retrieve (long a_riga_meca);/*
Popola dw di dettaglio (dw_barcode)
 inp: row dw_meca to processing
 out: rows in dw detail
*/
long k_row, k_rows, k_return
int k_rc 
st_tab_barcode kst_tab_barcode

if a_riga_meca > 0 then

	kst_tab_barcode.id_meca = dw_meca.getitemnumber(a_riga_meca, "id_meca")	
	kst_tab_barcode.id_sl_pt_g3_lav = dw_meca.getitemnumber(a_riga_meca, "id_sl_pt_g3_lav")	
	
	if dw_dett_0.rowcount( ) > 0 then
		kst_tab_barcode.pl_barcode = dw_dett_0.getitemnumber(1, "codice")
	end if

	if isnull(kst_tab_barcode.pl_barcode)  then
		kst_tab_barcode.pl_barcode = 0
	end if

	k_rc = dw_barcode.reset() 
	k_rows = dw_barcode.retrieve(kst_tab_barcode.id_meca, kst_tab_barcode.pl_barcode, kst_tab_barcode.id_sl_pt_g3_lav) 
	
	if k_rows > 0 then

//---- rimuove le righe se il barcode è già messo in elenco da trattare (kdw_lista_0) o groupage (kdw_groupage)
		for k_row = k_rows to 1 step -1
			
			if dw_lista_0.find("barcode_barcode = '" + dw_barcode.getitemstring(k_row, "barcode_barcode") + "' ", 0, dw_lista_0.rowcount( ) ) > 0 &
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

private function boolean if_lotto_associato (ref st_tab_meca ast_tab_meca) throws uo_exception;//
//--- Controllo se Lotto gia' associato in E1
//--- inp: st_tab_meca.id
//--- torna: TRUE=associato
boolean k_return=false

	
try
	
	if ki_e1_enabled then
		
		k_return = kiuf_armo.if_lotto_associato(ast_tab_meca)

	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally

end try
			
return k_return
end function

private function boolean if_lotto_rack_asscociati () throws uo_exception;/*
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

private subroutine if_lotto_rack_con_padri () throws uo_exception;/*
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

private subroutine copia_dw_groupage_to_dw_barcode (integer k_riga1, integer k_riga2);//---
//--- copia dati dal dw groupage (dw_groupage) al DW di dettaglio (dw_barcode)
//--- parametri: 
//---            riga1 riga della dw1
//---            riga2 riga della dw2
//---
	
		dw_barcode.setitem(k_riga1, "barcode_barcode", &
					 dw_groupage.getitemstring(k_riga2, "barcode_barcode"))
					 
		dw_barcode.setitem(k_riga1, "g3npass", dw_groupage.getitemnumber(k_riga2, "g3npass"))
		dw_barcode.setitem(k_riga1, "ngiri", dw_groupage.getitemnumber(k_riga2, "g3ngiri")) 
		dw_barcode.setitem(k_riga1, "ciclo_min", dw_groupage.getitemnumber(k_riga2, "ciclo_min")) 
		dw_barcode.setitem(k_riga1, "ciclo_max", dw_groupage.getitemnumber(k_riga2, "ciclo_max"))
		dw_barcode.setitem(k_riga1, "id_sl_pt_g3_lav", dw_groupage.getitemnumber(k_riga2, "id_sl_pt_g3_lav"))					 
					 
		dw_barcode.setitem(k_riga1, "barcode_num_int", &
					 dw_groupage.getitemnumber(k_riga2, "barcode_num_int"))
		dw_barcode.setitem(k_riga1, "barcode_data_int", &
					 dw_groupage.getitemdate(k_riga2, "barcode_data_int"))
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

end subroutine

private subroutine copia_dw_groupage_to_dw_lista_0 (integer k_riga1, integer k_riga2);//---
//--- copia dalla dw_lista in dw del groupage 
//--- parametri: 
//---            riga1 riga della dw1
//---            riga2 riga della dw2
//---
	
		dw_lista_0.setitem(k_riga1, "barcode_barcode", dw_groupage.getitemstring(k_riga2, "barcode_barcode"))
					 
		dw_lista_0.setitem(k_riga1, "g3npass", dw_groupage.getitemnumber(k_riga2, "g3npass"))
		dw_lista_0.setitem(k_riga1, "g3ngiri", dw_groupage.getitemnumber(k_riga2, "g3ngiri"))
		dw_lista_0.setitem(k_riga1, "g3ciclo", dw_groupage.getitemnumber(k_riga2, "g3ciclo"))
		dw_lista_0.setitem(k_riga1, "id_sl_pt_g3_lav", dw_groupage.getitemnumber(k_riga2, "id_sl_pt_g3_lav"))
		dw_lista_0.setitem(k_riga1, "ciclo_min", dw_groupage.getitemnumber(k_riga2, "ciclo_min"))
		dw_lista_0.setitem(k_riga1, "ciclo_max", dw_groupage.getitemnumber(k_riga2, "ciclo_max"))
					 
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


end subroutine

private subroutine copia_dw_lista_0_to_dw_barcode (integer k_riga1, integer k_riga2);//---
//--- copia dati dal dw del groupage (dw_lista_0) al DW di dettaglio (dw_barcode)
//--- parametri: 
//---            riga1 riga della dw1
//---            riga2 riga della dw2
//---
	
		dw_barcode.setitem(k_riga1, "barcode_barcode", dw_lista_0.getitemstring(k_riga2, "barcode_barcode"))
		
		dw_barcode.setitem(k_riga1, "g3npass", dw_lista_0.getitemnumber(k_riga2, "g3npass"))
		dw_barcode.setitem(k_riga1, "ngiri", dw_lista_0.getitemnumber(k_riga2, "g3ngiri"))
		dw_barcode.setitem(k_riga1, "id_sl_pt_g3_lav", dw_lista_0.getitemnumber(k_riga2, "id_sl_pt_g3_lav"))
		dw_barcode.setitem(k_riga1, "ciclo_min", dw_lista_0.getitemnumber(k_riga2, "ciclo_min"))
		dw_barcode.setitem(k_riga1, "ciclo_max", dw_lista_0.getitemnumber(k_riga2, "ciclo_max"))
		
		dw_barcode.setitem(k_riga1, "barcode_num_int", &
					 dw_lista_0.getitemnumber(k_riga2, "barcode_num_int"))
		dw_barcode.setitem(k_riga1, "barcode_data_int", &
					 dw_lista_0.getitemdate(k_riga2, "barcode_data_int"))
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
			
			if kiuf_pl_barcode.if_esiste(kst_tab_pl_barcode) then
				if kiuf_pl_barcode.if_pl_barcode_aperto(kst_tab_pl_barcode) then
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
	
end if

end subroutine

private subroutine u_aggiungi_figli_dal_dw_lista (long a_row);/*
Verifica se nella dw_lista  ci sono Padri e aggiunge i figli nella dw_groupage
   inp: n. riga del barcode nel dw_lista da verificare; 0 = tutti
*/	
long k_riga, k_rows

ki_lista_0_modifcato = true

if a_row > 0 then
	k_rows = a_row
else
	a_row = 1
	k_rows = dw_lista_0.rowcount()
end if
for k_riga = a_row to k_rows
	u_aggiungi_figli_al_dw_groupage ( k_riga )
next

end subroutine

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
long k_riga_find, k_presenti_meca, k_rows_meca, k_id_meca
string k_find_txt, k_tipo_cicli 
st_esito kst_esito	


	kst_esito = kguo_exception.inizializza(this.classname())
	k_rows_meca = dw_meca.rowcount()

//--- sottrae dai Riferimenti i barcode messi in questa pianficazione
	k_id_meca = adw_inp.getitemnumber (a_riga, "id_meca")
						
//--- costruzione della FIND			
	k_find_txt = "id_meca = " + trim(string(k_id_meca)) + " "  
		
//--- cerca il riferimento in lista				
	k_riga_find = dw_meca.find(k_find_txt, 1, k_rows_meca) 
	do while k_riga_find > 0 
		k_presenti_meca = dw_meca.getitemnumber( k_riga_find, "contati" )
		k_presenti_meca = k_presenti_meca - 1
			
//--- se azzero il contatore dei barcode tolgo il riferimento dalla lista				
		if k_presenti_meca <= 0 then
			dw_meca.deleterow( k_riga_find ) 
			k_rows_meca --
		else	
			dw_meca.setitem( k_riga_find, "contati", k_presenti_meca )
			k_riga_find ++
		end if

		if k_riga_find > k_rows_meca then
			exit
		else
			k_riga_find = dw_meca.find(k_find_txt, k_riga_find, k_rows_meca) 
		end if
	loop
									  
	





end subroutine

protected function boolean u_resize_predefinita ();//---
int k_dist_bordi, k_spess_bordi_x, k_spess_bordi_y

	this.setredraw(false)
		
	k_dist_bordi = 5
	k_spess_bordi_x = 0 
	k_spess_bordi_y = 0 

	dw_guida.event u_enabled_if( )
	dw_guida.width = this.width 

	dw_meca.y = dw_guida.x + dw_guida.height + k_dist_bordi
	dw_meca.height = this.height * 0.53
	dw_meca.width = this.width * 0.62 
	
	dw_barcode.width = dw_meca.width * 0.57 
	dw_lista_0.width = this.width - dw_meca.width - (k_dist_bordi * 3 + k_spess_bordi_x)
	dw_groupage.width = this.width - dw_barcode.width - dw_lista_0.width - k_dist_bordi * 3 - k_spess_bordi_x

	dw_barcode.height = this.height - (dw_meca.y + dw_meca.height + k_dist_bordi * 3 + k_spess_bordi_y)
	dw_groupage.height = dw_barcode.height 

	dw_lista_0.height = this.height - (dw_guida.height + k_dist_bordi * 3 + k_spess_bordi_y)

	dw_meca.x = k_dist_bordi
	dw_barcode.x = dw_meca.x
	dw_barcode.y = dw_meca.y + dw_meca.height + k_dist_bordi 
	dw_groupage.x = dw_meca.x + dw_barcode.width + k_dist_bordi
	dw_groupage.y = dw_meca.y + dw_meca.height + k_dist_bordi 

	dw_lista_0.x = dw_meca.x + dw_meca.width + k_dist_bordi
	dw_lista_0.y = dw_meca.y
	
	this.setredraw(true)

	dw_guida.visible = true
	dw_meca.visible = true
	dw_barcode.visible = true
	dw_groupage.visible = true
	dw_lista_0.visible = true

return TRUE

end function

protected subroutine u_resize ();//

	dw_guida.width = this.width 

	super::u_resize()
	
end subroutine

public subroutine u_obj_visible_0 ();//
dw_guida.event u_enabled_if()

super::u_obj_visible_0( )
end subroutine

protected subroutine u_dw_groupage_colore (ref datawindow k_dw);//---
//--- Cambia il colore della DW GROUPAGE
//---
int k_rc
int k_ctr, k_colcount
string  k_rcx

	
	k_dw.modify("DataWindow.Color='" + string(ki_dw_groupage_colore) + "' " )	
	k_dw.modify("k_contati.Background.Color='" + string(ki_dw_groupage_colore) + "' " )	

	k_colcount = integer(k_dw.Describe("DataWindow.Column.Count"))


	for k_ctr = 1 to k_colcount 

//--- copia Proprieta' VISIBLE
		k_rcx=k_dw.modify("#" + trim(string(k_ctr,"###")) + ".backgroundcolor = '" &
		                        + string(ki_dw_groupage_colore) &
										+ "' " )
		
	next




end subroutine

private subroutine u_abilita_chiusura_pl ();//
//--- controllo autorizzazione x chiusura P.L.
//
st_esito kst_esito


kst_esito = kiuf_pl_barcode.consenti_chiusura() 
if kst_esito.esito = kkg_esito.ok then
	ki_chiudi_PL_enabled = true
end if

end subroutine

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

return ki_chiudi_PL_enabled 


end function

private subroutine u_crash_reset ();/*
  Reset del backup di rirpistino del Piano-Lav 
*/
int k_rc

if ki_save_for_crash_insert then	
	k_rc=kGuf_data_base.dw_salva_righe_reset("Restore", dw_lista_0, "for_crash")
	ki_save_for_crash_insert=false
end if

end subroutine

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

private subroutine apri_pl_elabora () throws uo_exception;//---
//--- Apre Piano di Lavorazione (chiamato da apri_pl)
//---
//--- lancia EXCEPTION
//---
st_tab_pl_barcode kst_tab_pl_barcode
st_esito kst_esito
kuf_plav kuf1_plav


try	
	SetPointer(kkg.pointer_attesa)
	
	kguo_exception.inizializza(this.classname())

	kst_tab_pl_barcode.data_chiuso = dw_dett_0.getitemdate(dw_dett_0.getrow(), "data_chiuso")
	kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")
	kst_tab_pl_barcode.id_programma = kiuf_pl_barcode.get_id_programma(kst_tab_pl_barcode)

	if kst_tab_pl_barcode.id_programma > 0 then
			
		kuf1_plav = create kuf_plav
		
//--- Riverifica se è già stato trasferito al PILOTA allora NON si può APRIRE
		if kuf1_plav.if_riapro_si(kst_tab_pl_barcode.id_programma) then

			kuf1_plav = create kuf_plav
			kuf1_plav.set_id_stato_to_deprecato(kst_tab_pl_barcode.id_programma)
	
			kst_tab_pl_barcode.st_tab_g_0.esegui_commit =  "S"    //"N" x temporaltable
			kiuf_pl_barcode.riapre_pl_barcode(kst_tab_pl_barcode)
		
			dw_dett_0.setitem (1, "programmi_richieste_id_programma", kst_tab_pl_barcode.id_programma)
			
		end if
	
	else
//--- per una qualche ragione manca il ID_PROGRAMMA, probabilmente è ndata in errore l'operazione quindi RIAPRE
		kst_tab_pl_barcode.st_tab_g_0.esegui_commit =  "S"    //"N" x temporaltable
		kiuf_pl_barcode.riapre_pl_barcode(kst_tab_pl_barcode)

	end if
	
	dw_dett_0.setitem (1, "data_chiuso", kst_tab_pl_barcode.data_chiuso)

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kst_esito.sqlerrtext = "Errore in Riapertura del Piano di Lavorazione (apri_pl_elabora): " &
					+ string(kst_tab_pl_barcode.codice) + " " + kkg.acapo + trim(kst_esito.sqlerrtext)
	kguo_exception.set_esito(kst_esito)
	kguo_exception.scrivi_log( )
	throw kguo_exception
	
finally
	if IsValid(kuf1_plav) then destroy kuf1_plav
	SetPointer(kkg.pointer_default)

end try
		





end subroutine

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
kuf_plav kuf1_plav


try 


	kuf1_plav = create kuf_plav

	kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")
	
	if kst_tab_pl_barcode.codice > 0 then
	else
		return 2
	end if

//--- se anche solo un barcode ha già iniziato il trattamento NO!
	kst_tab_barcode.pl_barcode = kst_tab_pl_barcode.codice
	if kiuf_barcode.get_nr_barcode_in_lav_x_pl(kst_tab_barcode) > 0  then

		k_errore = 2
		ki_chiudi_PL_enabled = false
		messagebox("Elaborazione non eseguita", &
				  "Il Piano di Lavorazione è già in TRATTAMENTO quindi non può essere Riaperto. " &
				  + kkg.acapo + "Codice: " + trim(string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice"))), &
				  Information! )

	else
		
		kst_tab_pl_barcode.id_programma = kiuf_pl_barcode.get_id_programma(kst_tab_pl_barcode)

		if kst_tab_pl_barcode.id_programma > 0 then
			
//--- se anche solo un barcode è già stato trasferito al PILOTA allora NON si può APRIRE
			if not kuf1_plav.if_riapro_si(kst_tab_pl_barcode.id_programma) then
				
				ki_chiudi_PL_enabled = false
				messagebox("Elaborazione non eseguita", &
					  "Il Piano di Lavorazione è già stato Trasferito al Pilota e non può essere Riaperto. " &
					  + kkg.acapo + "Codice: " + trim(string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice"))), &
					  Information! )
	
			else
	
				k_nrc = messagebox("Riapre Programmazione - Elaborazione CRITICA ", &
						  "RIAPERTURA!!! " &
						  + kkg.acapo + "L'elaborazione Riapre il Piano di Lavorazione! " &
						  + kkg.acapo + "I barcode sembrano ancora disponibili ma il PILOTA potrebbe fare il carico del Piano in questi istanti. " &
						  + kkg.acapo + "Se i barcode fossero già in carico al Pilota la nuova Programmazione potrebbe essere respinta e " &
						  + kkg.acapo + "bisognerà poi intervenire manualmente sulle tabelle per aggiornare i barcode di questo Piano di Lavorazione." &
						  + kkg.acapo + "Proseguire comunque?", &
						  question!, YesNo!, 2) 
		
				if k_nrc = 2 then
					k_errore = 2
				else
					k_elabora = true  // OK APRIAMO!
				end if
					
			end if
		else
			k_elabora = true  // OK APRIAMO!
		end if
	end if
	

	if k_elabora then 
		
		SetPointer(kkg.pointer_attesa)

//--- RI-APRE il PL effettivamente !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!			
		apri_pl_elabora( )
//-------------------------------------------------------			

		kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")
			
		messagebox("Operazione Conclusa", &
					"Il Piano di Lavorazione è stato Riaperto correttamente. ")

	end if

catch (uo_exception kuo_exception)
	k_errore = 1
	kst_esito = kguo_exception.get_st_esito( )
	kguo_exception.inizializza( )
	kguo_exception.messaggio_utente("Riapertura Piano di Lavorazione", &
					  "Operazione di aggiornamento fallita. Il Piano è rimasto chiuso." &
					  + kkg.acapo + trim(kst_esito.sqlerrtext))
finally
	if IsValid(kuf1_plav) then destroy kuf1_plav
	SetPointer(kkg.pointer_default)

end try


return k_errore

end function

private subroutine chiudi_pl_elabora () throws uo_exception;//---
//--- Chiude Piano di Lavorazione (chiamato da chiudi_pl)
//---
//--- lancia EXCEPTION
//---
long k_riga
int k_errore=0
st_tab_pl_barcode kst_tab_pl_barcode
st_esito kst_esito, kst_esito_err

	
	try	

		kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(1, "codice")
	
//--- prima di Chiudere RIPRISTINA gli archivi da eventuali chiusure passate
		kst_tab_pl_barcode.st_tab_g_0.esegui_commit =  "S"    //"N" x temporaltable
		kiuf_pl_barcode.riapre_pl_barcode(kst_tab_pl_barcode)
			
//--- Controllo se Tutto OK			
		if_programmazione_ok()

//--- Chiude PL: inizio delle fasi di chiusura del PL 
		kst_tab_pl_barcode.st_tab_g_0.esegui_commit =  "S"    //"N" x temporaltable
		kst_esito = kiuf_pl_barcode.tb_update_campo(kst_tab_pl_barcode, "data_chiuso")
		
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
	
		dw_dett_0.setitem (1, "data_chiuso", kst_tab_pl_barcode.data_chiuso)
		
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
		SetPointer(kkg.pointer_default)  // ripristino Puntatore

	end try




end subroutine

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

protected function boolean if_programmazione_ok () throws uo_exception;//---
//--- Controlla Programmazione
//---      
//--- Ritorna TRUE=OK
//---      
//
boolean k_return
string k_barcode
date k_data, k_data_chiuso, k_dataoggi
long k_riga, k_nr_righe, k_riga_ds, k_pl_barcode_progr
int k_nr_errori
st_esito kst_esito
st_tab_barcode kst_tab_barcode
ds_pl_barcode_dett kds_pl_barcode_dett, kds_pl_barcode_dett_grp
st_tab_pl_barcode kst_tab_pl_barcode
uo_ds_std_1 kds_get_barcode_rackcode_not_in_pl_barcode

try
	kst_esito = kguo_exception.inizializza(this.classname())

	kds_pl_barcode_dett = create ds_pl_barcode_dett
	kds_pl_barcode_dett_grp = create ds_pl_barcode_dett

	dw_lista_0.accepttext()
	dw_groupage.accepttext()

	k_nr_righe = dw_lista_0.rowcount()

	k_riga = 1
	do while k_riga <= k_nr_righe and k_nr_errori < 15

		k_pl_barcode_progr = dw_lista_0.getitemnumber ( k_riga, "barcode_pl_barcode_progr")

//--- Tolgo valori a null dai giri
		if isnull(dw_lista_0.getitemnumber ( k_riga, "g3npass")) then
			dw_lista_0.setitem ( k_riga, "g3npass", 0)
		end if
		if isnull(dw_lista_0.getitemnumber ( k_riga, "g3ngiri")) then
			dw_lista_0.setitem ( k_riga, "g3ngiri", 0)
		end if
		if isnull(dw_lista_0.getitemnumber ( k_riga, "g3ciclo")) then
			dw_lista_0.setitem ( k_riga, "g3ciclo", 0)
		end if

		if kids_sl_pt_g3_lav_if_datilav_ok.get_datilav_x_ciclo( dw_lista_0.getitemnumber( k_riga, "id_armo") &
													, dw_lista_0.getitemnumber( k_riga, "g3npass") &
													, dw_lista_0.getitemnumber( k_riga, "g3ngiri") &
													, dw_lista_0.getitemnumber( k_riga, "g3ciclo")) = 0 then
			kst_esito.esito = kkg_esito.ko 			 
			kst_esito.SQLErrText += "Riga n. " + string(k_riga, "#0") + " Barcode '" &
											+ dw_lista_0.getitemstring ( k_riga, "barcode_barcode") + "': " & 
											+ "non è stato trovato il Trattameno per N.Pass (" & 
											+ string(dw_lista_0.getitemnumber( k_riga, "g3npass")) &
											+ ")+N.Giri (" + string(dw_lista_0.getitemnumber( k_riga, "g3ngiri")) + ")+Ciclo " &
											+ "(" + string(dw_lista_0.getitemnumber( k_riga, "g3ciclo")) + "); " + kkg.acapo
			k_nr_errori++
		end if

//--- Popolo il Datastore x il controllo della Programmazione
		k_riga_ds = kds_pl_barcode_dett.insertrow(0)
		kds_pl_barcode_dett.object.pl_barcode_progr[k_riga_ds] = dw_lista_0.getitemnumber ( k_riga, "barcode_pl_barcode_progr")
		kds_pl_barcode_dett.object.barcode[k_riga_ds] = dw_lista_0.getitemstring ( k_riga, "barcode_barcode")

		k_riga ++
	loop

	if k_nr_errori > 0 then 
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- Controllo programmazione
	kiuf_pl_barcode.if_pianificazione_ok(kds_pl_barcode_dett, "inserimento")

//---- Controllo Barcode FIGLI ------------------------------------------------------------------------------------

//--- Aggiungo eventuali Figli nati all'insaputa fuori da questo pianificazione
	u_aggiungi_figli_dal_dw_lista(0)

//--- Rilegge e Controlla i dati di trattamento dei barcode figli
	kst_esito = retrieve_figli_all()
	if kst_esito.esito <> kkg_esito.ok then
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	k_nr_righe = dw_groupage.rowcount()
	for k_riga = 1 to k_nr_righe

//--- Popolo il Datastore Figli x il controllo della Programmazione
		k_riga_ds = kds_pl_barcode_dett_grp.insertrow(0)
		kds_pl_barcode_dett_grp.object.pl_barcode_progr[k_riga_ds] = dw_groupage.getitemnumber ( k_riga, "barcode_pl_barcode_progr")
		kds_pl_barcode_dett_grp.object.barcode[k_riga_ds] = dw_groupage.getitemstring ( k_riga, "barcode_barcode")
		kds_pl_barcode_dett_grp.object.barcode_lav[k_riga_ds] = dw_groupage.getitemstring ( k_riga, "barcode_lav")
		
	next

//--- controlla pianificazione figli
	kiuf_pl_barcode.if_pianificazione_figli_g3_ok(kds_pl_barcode_dett, kds_pl_barcode_dett_grp, "inserimento")

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
	if isvalid(kds_pl_barcode_dett) then destroy kds_pl_barcode_dett
	if isvalid(kds_pl_barcode_dett_grp) then destroy kds_pl_barcode_dett_grp
	
end try

return k_return



end function

private function st_esito retrieve_figli_all ();//
//---- Rilegge tutti i figli da db2 contenuti nel dw_groupage
//
long k_riga
st_esito kst_esito, kst1_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	for k_riga = 1 to dw_groupage.rowcount()
	
		kst1_esito = retrieve_figlio_nel_dw_groupage(k_riga)
		if kst1_esito.esito <> kkg_esito.ok and kst1_esito.esito <> kkg_esito.db_wrn then
			kst_esito.esito = kst1_esito.esito
			kst_esito.sqlerrtext += kkg.acapo + trim(kst1_esito.sqlerrtext)
		end if
		
	end for


return kst_esito

end function

private function st_esito retrieve_figlio_nel_dw_groupage (long a_riga);//
//--- Aggiorna i dati del Figlio nel dw_groupage  
//--- 
//--- Input kst_tab_barcode.barcode il FIGLIO da rileggere 
//
long k_riga_find, k_riga_find_padre
st_tab_barcode kst_tab_barcode
st_esito kst_esito 


	try
		kst_esito = kguo_exception.inizializza(this.classname())

		kst_tab_barcode.barcode = dw_groupage.object.barcode_barcode[a_riga]

//--- Cerco il barcode tra i figli gia' presenti
		k_riga_find = dw_groupage.find("barcode_barcode = '" + trim(kst_tab_barcode.barcode) + "' ", 1, dw_groupage.rowcount()) 

//--- se  barcode Trovato procedo nella lettura dei dati su DB non c'e' ancora tra i figli allora lo aggiungo
		if k_riga_find > 0  then

//--- Cerco il barcode PADRE 
			k_riga_find_padre = dw_lista_0.find("barcode_barcode = '" + trim(kst_tab_barcode.barcode_lav) + "' ", 1, dw_lista_0.rowcount()) 
			if k_riga_find_padre > 0  then
			
				kst_tab_barcode.barcode_lav = kiuf_barcode.get_barcode_lav(kst_tab_barcode)
				kiuf_barcode.get_id_meca(kst_tab_barcode)  // torna anche ID_ARMO
			
			
				if kids_sl_pt_g3_lav_if_datilav_ok.get_datilav_x_ciclo(kst_tab_barcode.id_armo, &
												dw_lista_0.getitemnumber(k_riga_find_padre, "g3npass" ), &
												dw_lista_0.getitemnumber(k_riga_find_padre, "g3ngiri" ), &
												dw_lista_0.getitemnumber(k_riga_find_padre, "g3ciclo" )) > 0 then
												
					dw_groupage.setitem(k_riga_find, "k_errore", '0')
				else
					dw_groupage.setitem(k_riga_find, "k_errore", '1')
				end if
			
				dw_groupage.setitem(k_riga_find, "barcode_lav",kst_tab_barcode.barcode_lav)
				dw_groupage.setitem(k_riga_find, "g3npass", dw_lista_0.getitemnumber(k_riga_find_padre, "g3npass"))
				dw_groupage.setitem(k_riga_find, "g3ngiri", dw_lista_0.getitemnumber(k_riga_find_padre, "g3ngiri"))
				dw_groupage.setitem(k_riga_find, "g3ciclo", dw_lista_0.getitemnumber(k_riga_find_padre, "g3ciclo"))
				if kids_sl_pt_g3_lav_if_datilav_ok.rowcount() > 0 then
					dw_groupage.setitem(k_riga_find, "id_sl_pt_g3_lav", kids_sl_pt_g3_lav_if_datilav_ok.getitemnumber(1, "id_sl_pt_g3_lav"))
				else
					dw_groupage.setitem(k_riga_find, "id_sl_pt_g3_lav", 0)
				end if

			end if
			
		else
			kst_esito.esito = kkg_esito.err_logico
			kst_esito.sqlerrtext = "Errore in ricerca 'Figlio' " +  trim(kst_tab_barcode.barcode) + " in " + trim(this.classname())
		end if

		
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		
	finally
		
	end try

return kst_esito


end function

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
					  "ATTENZIONE " + kkg.acapo +"L'operazione Aggiorna e Chiude il Piano di Lavorazione. " &
					  + kkg.acapo &
					  + "Dopo l'aggiornamento non sarà più possibile eseguire alcuna " &
					  + "modifica. " + kkg.acapo &
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
				kst_esito_err.esito = Left(k_rc, 1)
				kst_esito_err.sqlcode = 0
				kst_esito_err.sqlerrtext = trim(Mid(k_rc, 2))
				kst_esito_err.nome_oggetto = this.classname()
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito_err)
				throw kguo_exception
				
			end if
		
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
				messagebox("Piano di Lavorazione Chiuso" ,"Operazione terminata correttamente. " &
						  + kkg.acapo + "Chiuso Piano di Lavorazione n.: " &
						  + (string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")))  &
						  + kkg.acapo + "Il piano sarà inviato in automatico alle " &
						  + string(kst_sv_eventi_sked.run_ora ) + " del " + string(kst_sv_eventi_sked.run_giorno )  &
						  ,Information! )
		
			else
				if kst_esito.esito = kkg_esito.not_fnd then
					messagebox("Piano di Lavorazione Chiuso" ,"Operazione terminata correttamente. " &
						  + kkg.acapo + "Chiuso Piano di Lavorazione n.: " &
						  + (string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")))  &
						  + kkg.acapo + "Effettuare l'Invio del Piano in modo manuale dal Menu 'Magazzino'! " &
						  ,Information! )
				else
					messagebox("Piano di Lavorazione Chiuso" ,"Operazione terminata correttamente. " &
						  + kkg.acapo + "Chiuso Piano di Lavorazione n.: " &
						  + (string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")))  &
						  ,Information! )
				end if
			end if
		
		end if

	end if
		
catch (uo_exception kuo_exception)
	k_errore = 1
	kst_esito = kguo_exception.get_st_esito( )
	kguo_exception.inizializza( )
	kguo_exception.messaggio_utente("Chiusura Piano di Lavorazione", "Operazione non eseguita!!" &
								+ kkg.acapo + trim(kst_esito.sqlerrtext) &
								+ kkg.acapo + "Piano non chiuso, esecuzione Interrotta." )

finally
	ki_operazione_chiusura = false
	SetPointer(kkg.pointer_default)  // ripristino Puntatore

end try
		

return k_errore

end function

private subroutine proteggi_campi ();/*
 Protegge i campi della Windows
*/
	
	dw_dett_0.u_proteggi_sproteggi_dw(ki_st_open_w.flag_modalita, true)
	dw_lista_0.u_proteggi_sproteggi_dw(ki_st_open_w.flag_modalita, true)
	dw_groupage.u_proteggi_sproteggi_dw(ki_st_open_w.flag_modalita, true)

	dw_barcode.ki_flag_modalita = ki_st_open_w.flag_modalita

	u_set_dragdrop()   // abilita se necassario il Drag&Drop
	
	//dw_meca.u_proteggi_sproteggi_dw(ki_st_open_w.flag_modalita, true)


end subroutine

protected function string inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1 e 2=Retrieve fallita (2=uscita Window)
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
int  k_rc
long k_key
string k_fine_ciclo="", k_rcx
int k_ctr=0
date k_data_chiuso, k_data
st_tab_pl_barcode kst_tab_pl_barcode


	SetPointer(kkg.pointer_attesa)

	if isnumber(trim(ki_st_open_w.key1)) then
		k_key = long(trim(ki_st_open_w.key1))
		ki_st_open_w.window_title += " ID: " + string(k_key, "#")
		set_titolo_window( )
	end if

	dw_lista_0.reset()
	dw_groupage.reset()

		
	k_rc = dw_dett_0.retrieve(k_key)

	choose case k_rc

		case is < 0				
			SetPointer(kkg.pointer_default)
			messagebox("Operazione fallita", &
				"Mi spiace, ma si e' verificato un errore interno al programma " &
				+ kkg.acapo + "Errore: " + string(dw_dett_0.kist_esito.sqlcode) + " - " + dw_dett_0.kist_esito.sqlerrtext)
			ki_exit_si = true
	
		case 0
			SetPointer(kkg.pointer_default)
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
				inserisci( )
			else
				ki_exit_si = true
				messagebox("Piano di Lavorazione", &
					"Non e' stato trovato in archivio il P.L. ~n~r" + &
					"(Codice cercato :" + string(k_key) + ")~n~r" )
				return "2"		
			end if
						
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
		
//--- Se PL gia' chiuso allora nessuna modifica possibile, forza Visualizzazione		
	try
		ki_PL_chiuso = false
		kst_tab_pl_barcode.codice = long(trim(ki_st_open_w.key1))
		kst_tab_pl_barcode.impianto = kki_impianto
		if kst_tab_pl_barcode.codice > 0 then
			if not kiuf_pl_barcode.if_pl_barcode_aperto(kst_tab_pl_barcode) then
//--- se ero entrato per modificare ma non si può allora avvertimento				
				if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
					SetPointer(kkg.pointer_default)
					kguo_exception.inizializza( )
					kguo_exception.messaggio_utente("Apertura del Piano di Lavorazione", &
						"Il Piano " + string(kst_tab_pl_barcode.codice) + " è già stato chiuso il " &
										+ string(kst_tab_pl_barcode.data_chiuso, "dd mmm yy") + ", può essere solo visualizzato e non modificato.")
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
	end if
	

	if ki_st_open_w.flag_primo_giro = 'S' then
		ki_riga_pos_dw_meca = 0  //cattura la riga selezionata
		retrieve_figli_all( )   // verifica i figli
		leggi_liste()
		dw_lista_0.resetupdate()
		ki_lista_0_modifcato=false					
	end if

	proteggi_campi()

	attiva_tasti()
	
	dw_guida.post event u_resize( )
	
	dw_meca.setfocus()

	SetPointer(kkg.pointer_default)


return k_return

end function

public function long togli_barcode_figlio (boolean k_esponi_msg);/*
 Toglie i BARCODE FIGLI selezionati della lista dei Pianificati
 inpt: esporre il messaggio di avvertimento
 rit: primo id_meca rimosso
*/
long k_riga, k_riga_drag, k_riga_prima, k_riga_meca, k_id_meca
int k_rc
long k_num_int
date k_data_int
st_tab_barcode kst_tab_barcode, kst_tab_barcode_lav
st_esito kst_esito


try
	kguo_exception.inizializza(this.classname())

	ki_lista_0_modifcato = true
	
	k_rc = dw_barcode.reset() 
	
	k_riga_drag = dw_groupage.getselectedrow(0)
	k_riga_prima = k_riga_drag

	dw_barcode.setredraw(false)
	dw_meca.setredraw(false)
	
	do while k_riga_drag > 0

		k_riga = dw_barcode.insertrow(0)

		kst_tab_barcode.barcode = trim(dw_groupage.getitemstring(k_riga_drag, "barcode_barcode"))
		kst_tab_barcode.barcode_lav = trim(dw_groupage.getitemstring(k_riga_drag, "barcode_lav"))
		kst_tab_barcode.id_meca = dw_groupage.getitemnumber(k_riga_drag, "id_meca")
		if isnull(kst_tab_barcode.barcode_lav) then kst_tab_barcode.barcode_lav = " "

		if k_esponi_msg then 
			k_rc = messagebox("Rimuove barcode figlio", &
						  "Il barcode: " + trim(kst_tab_barcode.barcode) &
						  + " verrà TOLTO definitivamente da questa Pianificazione" &
						  + " e sarà RIMOSSO anche il legame con il Padre ("+trim(kst_tab_barcode.barcode_lav)+")" &
						  + kkg.acapo + "Proseguire l'operazione?" &
						  , Question!, yesno!, 1) 
			if k_rc = 2 then
				exit   // chiude LOOP
			end if
		end if
		
		kiuf_barcode.tb_update_g3_reset(kst_tab_barcode)   // RESET dei dati di trattamento Impianto G3
//		kst_esito = kiuf_barcode.tb_update_campo( kst_tab_barcode, "ripri_pl_barcode" ) 
//		if kst_esito.esito <> "0" then
//			messagebox("Rimozione del Barcode", "Operazione di aggiornamento fallita! " &
//			  + "Errore non grave, ma consiglio di 'salvare' questo Piano per evitare incongruenze " &
//			  + kkg.acapo + "tra il barcode rimosso " + trim(kst_tab_barcode.barcode ) &
//			  + " e il barcode padre " + trim(kst_tab_barcode.barcode_lav) + ". " &
//			  + kkg.acapo + "Errore: " + string(kst_esito.sqlcode) + " - " + trim(kst_esito.sqlerrtext))
//			exit   // chiude LOOP
//		end if

		kst_esito = kiuf_barcode.tb_togli_da_groupage( kst_tab_barcode ) 
		if kst_esito.esito <> "0" then
			messagebox("Rimozione del Padre dal Barcode", "Operazione di aggiornamento fallita! " &
			  + kkg.acapo + "ATTENZIONE: eliminare manualmente sul Barcode " + trim(kst_tab_barcode.barcode) + " " &
			  + kkg.acapo + "il legame con il Padre " + trim(kst_tab_barcode.barcode_lav)+". " &
			  + kkg.acapo + "Errore: " + string(kst_esito.sqlcode) + " - " + trim(kst_esito.sqlerrtext))
			exit   // chiude LOOP
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

			k_num_int = dw_groupage.getitemnumber(k_riga_drag, "barcode_num_int")
			k_data_int = dw_groupage.getitemdate(k_riga_drag, "barcode_data_int")
			
			k_riga_meca = dw_meca.find("meca_num_int = " + trim(string(k_num_int)) + " " &
							 + "and meca_data_int = date('" &
							 + trim(string(k_data_int)) + "') " &
							 , 1, dw_meca.rowcount())
		end if						 
		
//--- copia la dw1 in barcode, il formato e' la solito dettaglio			
		copia_dw_groupage_to_dw_barcode(k_riga, k_riga_drag)
	
		dw_groupage.deleterow( k_riga_drag )
		k_riga_drag = dw_groupage.getselectedrow( 0 )
		
	loop

//--- sistema il codice e i progressivi nella lista
	imposta_codice_progr( dw_groupage )
//--- posizionamento sulla riga precednte al primo barcode tolto
	if dw_groupage.rowcount() > 0 then
	
		if k_riga_prima > 1 then
			k_riga_prima = k_riga_prima - 1
		end if
		if k_riga_prima > dw_groupage.rowcount() then
			k_riga_prima = dw_groupage.rowcount()
		end if
		if k_riga_prima > 0 then
			dw_groupage.setrow(k_riga_prima)
			dw_groupage.selectrow(k_riga_prima, true)
			dw_groupage.scrolltorow(k_riga_prima)
		end if
		
		dw_groupage.setcolumn(1)
		dw_groupage.setfocus()
		
	end if	

	
catch (uo_exception kuo1_exception)
	kuo1_exception.scrivi_log()
	
finally
	dw_barcode.setredraw(true)
	dw_meca.setredraw(true)
	
end try

return kst_tab_barcode.id_meca
end function

public subroutine togli_barcode_padre ();/*
  Toglie i BARCODE selezionati della lista dei Pianificati
  inp: dw_lista_0
*/
long k_riga, k_riga_drag, k_riga_prima, k_riga_meca, k_riga_find
int k_ctr, k_rc, k_nrows_to_restore
string k_rc_x
long k_id_meca
boolean k_rileggi_lista_da_db = false
int k_scelta_msg
st_tab_barcode kst_tab_barcode, kst_tab_barcode_figlio
st_esito kst_esito
	

try
	kguo_exception.inizializza(this.classname())

	ki_lista_0_modifcato = true
	
	k_rc = dw_barcode.reset() 
	
	k_riga_drag = dw_lista_0.getselectedrow(0)
	k_riga_prima = k_riga_drag
	
	dw_barcode.setredraw(false)
	dw_meca.setredraw(false)
	
	do while k_riga_drag > 0

		k_id_meca = dw_lista_0.getitemnumber(k_riga_drag, "id_meca")

		kst_tab_barcode.barcode = trim(dw_lista_0.getitemstring(k_riga_drag, "barcode_barcode"))

//--- Cerco il barcode tra i figli gia' presenti -----------------------------------------------------------------------------------------
		dw_groupage.selectrow(0, false)
		k_riga_find = dw_groupage.find("barcode_lav = '" + trim(kst_tab_barcode.barcode) + "' ", 1, dw_groupage.rowcount()) 
		do while k_riga_find > 0 
			dw_groupage.selectrow(k_riga_find, true)
			k_riga_find = dw_groupage.find("barcode_lav = '" + trim(kst_tab_barcode.barcode) + "' ", k_riga_find+1, dw_groupage.rowcount()) 
		loop
		if dw_groupage.getselectedrow(0) > 0 then
			togli_barcode_figlio(false)   // rimuove eventuali figli
		end if
						
//----------------------------------------------------------------------------------------------------------------------------------------
		kiuf_barcode.tb_update_g3_reset(kst_tab_barcode)   // RESET dei dati di trattamento Impianto G3
//		kst_esito = kiuf_barcode.tb_update_campo( kst_tab_barcode, "ripri_pl_barcode" ) 
//		if kst_esito.esito <> "0" then
//			kst_esito.sqlerrtext = "Operazione di Rimozione del Barcode fallita, ~n~r" &
//					  + "Non e' grave, ma consiglio di 'salvare' questo Piano x evitare incongruenze nel prosieguo. " + trim(kst_tab_barcode.barcode)+"~n~r" &
//					  + "Barcode: " + trim(kst_tab_barcode.barcode)+"~n~r" &
//					  + "Errore: " + string(kst_esito.sqlcode) + "-" + trim(kst_esito.sqlerrtext)
//		end if

//--- copia la dw1 in barcode, il formato e' la solito dettaglio		
		k_riga = dw_barcode.insertrow(0)
		copia_dw_lista_0_to_dw_barcode(k_riga, k_riga_drag)

		dw_lista_0.deleterow( k_riga_drag )
		k_riga_drag = dw_lista_0.getselectedrow(0)
		
	loop
	
	dw_barcode.scrolltorow(dw_barcode.rowcount())

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally	
	
	u_crash_dw_lista_0_backup() // Salva per restore se crash
	
//--- sistema il codice e i progressivi nella lista
	imposta_codice_progr( dw_lista_0 )
	imposta_codice_progr( dw_groupage )

	ki_riga_pos_dw_meca = 0  //cattura la riga selezionata
	
//--- rilegge la lista riferimenti non lavorati
	leggi_liste()

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
	if dw_lista_0.rowcount() > 0 then
	
		if k_riga_prima > 1 then
			k_riga_prima = k_riga_prima - 1
		end if
		if k_riga_prima > dw_lista_0.rowcount() then
			k_riga_prima = dw_lista_0.rowcount()
		end if
		if k_riga_prima > 0 then
			dw_lista_0.setrow(k_riga_prima)
			dw_lista_0.selectrow(k_riga_prima, true)
			dw_lista_0.scrolltorow(k_riga_prima)
		end if
		
		dw_lista_0.setcolumn(1)
		dw_lista_0.setfocus()
		
	end if	

	//--- Riempe il titolo della dw di dettaglio
	if dw_barcode.rowcount() > 0 then
		dw_barcode.title = "Dettaglio Riferimento: " + string(dw_barcode.getitemnumber(1, "barcode_num_int"))
	else
		dw_barcode.title = "Dettaglio Riferimento " 
	end if
		
end try

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
	if k_riga > 0 then
		dw_meca.reselectrow(k_riga)
		dw_meca.scrolltorow(k_riga)
		dw_meca.selectrow( 0, false)
		dw_meca.selectrow(k_riga, true)
		dw_meca.setrow(k_riga)
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

private function integer call_window_barcode ();//
//--- Chiama finestra di dettaglio
//
integer k_return = 0
long k_riga=0
st_tab_barcode kst_tab_barcode
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window



	if kidw_selezionata.dataobject = "d_pl_barcode_dett_g3" then
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

	if kidw_selezionata.dataobject = "d_pl_barcode_dett_grp_g3_all" then
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
	
	if kidw_selezionata.dataobject = "d_barcode_g3_l_no_pl" then
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

public subroutine togli_barcode_figlio_post (long a_id_meca);/*
 Da chiamare al termine dell'operazione di Rimozione dei BARCODE FIGLI
 inpt: prima riga eliminata
*/
long k_num_int, k_riga_meca
date k_data_int


try
	kguo_exception.inizializza(this.classname())

	dw_barcode.scrolltorow(dw_barcode.rowcount())

	ki_riga_pos_dw_meca = 0  //cattura la riga selezionata
	
//--- rilegge la lista riferimenti non lavorati
	leggi_liste()

//--- posizionamento sul riferimento della riga trattata	
	if dw_meca.rowcount() > 0 then	
		k_riga_meca = dw_meca.find("id_meca = " + string(a_id_meca), 1, dw_meca.rowcount())
//--- Seleziono riferimento 
		if k_riga_meca > 0 then
			dw_meca.selectrow( 0, false)
			dw_meca.selectrow(k_riga_meca, true)
			dw_meca.setrow(k_riga_meca)
			dw_meca.scrolltorow(k_riga_meca)
		end if
	end if

	//--- imposta il titolo della dw di dettaglio
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
	
end try

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

protected function string inizializza_post ();//

	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 
		dw_meca.setfocus( )
	end if
	

return "0"

end function

protected function string aggiorna_dati ();//
string k_return = "0 "


try
	dw_dett_0.accepttext()
	if dw_dett_0.rowcount() > 0 then
	
	//--- Aggiorna dei dati inseriti/modificati
		k_return = super::aggiorna_dati()

		dw_dett_0.resetupdate()
		dw_lista_0.resetupdate()
		dw_groupage.resetupdate()
		
		attiva_tasti()
		
	end if
	
catch (uo_exception kuo_exception)
	
end try

return k_return 

end function

protected function string aggiorna_tabelle ();//
//=== Update delle Tabelle
string k_return = "0 "
long k_riga, k_n_righe
int k_rc
kuf_impianto kuf1_impianto
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_barcode kst_tab_barcode
st_esito kst_esito 


 try
	SetPointer(kkg.pointer_attesa)
	kst_esito = kguo_exception.inizializza(this.classname())

	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		dw_dett_0.setitemstatus(1, 0, primary!, NewModified!)
	end if
	
	kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(1, "codice")	
	kst_tab_pl_barcode.impianto = kiuf_impianto.kki_impiantog3
	kst_tab_pl_barcode.data = dw_dett_0.getitemdate(1, "data")			
	kst_tab_pl_barcode.data_chiuso = date(0) 
	kst_tab_pl_barcode.dataora_chiuso = kguo_g.get_datetime_zero()
	kst_tab_pl_barcode.data_sosp = dw_dett_0.getitemdate(1, "data_sosp")			
	kst_tab_pl_barcode.note_1 = trim(dw_dett_0.getitemstring(1, "note_1"))		
	kst_tab_pl_barcode.note_2 = trim(dw_dett_0.getitemstring(1, "note_2"))
	kst_tab_pl_barcode.stato = dw_dett_0.getitemstring(1, "stato_pl")			
	kst_tab_pl_barcode.stato_pl = dw_dett_0.getitemstring(1, "stato_pl")			
	kst_tab_pl_barcode.priorita = dw_dett_0.getitemstring(1, "priorita")			
	kst_tab_pl_barcode.prima_del_barcode = dw_dett_0.getitemstring(1, "prima_del_barcode")			

	kiuf_pl_barcode.tb_update( kst_tab_pl_barcode ) 
	
	if kst_tab_pl_barcode.codice > 0 then
	else
		kst_esito.esito = kkg_esito.ko
		kst_esito.sqlerrtext = "Attenzione aggiornamento bloccato, manca il Codice del Piano! " 
		kguo_sqlca_db_magazzino.db_rollback( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if		

	kguo_sqlca_db_magazzino.db_commit( )
		
	k_rc=dw_dett_0.setitem(1, "codice", kst_tab_pl_barcode.codice)	
	
	kst_tab_barcode.pl_barcode = kst_tab_pl_barcode.codice
	k_return = kiuf_barcode.togli_pl_barcode_all( kst_tab_barcode ) 
	if Left(k_return,1) <> "0" then
		kst_esito.esito = kkg_esito.ko
		kst_esito.sqlerrtext = "Errore durante rimozione dei Barcode tolti dal Piano! " &
					+ kkg.acapo + "(errore=" + trim(k_return) + ") " 
		kguo_sqlca_db_magazzino.db_rollback( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if			

//--- aggiorna Barcode PADRI
	kst_esito = kguo_exception.inizializza(this.classname())
	k_n_righe = dw_lista_0.rowcount()
	k_riga = 1 
	do while k_riga <= k_n_righe and kst_esito.esito = kkg_esito.ok

		dw_lista_0.setitem(k_riga, "barcode_pl_barcode", kst_tab_pl_barcode.codice)

		kst_tab_barcode.barcode = trim(dw_lista_0.getitemstring(k_riga, "barcode_barcode"))
		kst_tab_barcode.pl_barcode = dw_lista_0.getitemnumber(k_riga, "barcode_pl_barcode")			
		kst_tab_barcode.pl_barcode_progr = dw_lista_0.getitemnumber(k_riga, "barcode_pl_barcode_progr")			
		kst_tab_barcode.g3ciclo = dw_lista_0.getitemnumber(k_riga, "g3ciclo")	
		kst_tab_barcode.g3ngiri = dw_lista_0.getitemnumber(k_riga, "g3ngiri")	
		kst_tab_barcode.g3npass = dw_lista_0.getitemnumber(k_riga, "g3npass")	
		kst_tab_barcode.id_sl_pt_g3_lav = dw_lista_0.getitemnumber(k_riga, "id_sl_pt_g3_lav")	
		kst_tab_barcode.impianto = kuf1_impianto.kki_impiantog3

		kiuf_barcode.tb_update_g3(kst_tab_barcode) //set_pl_barcode( kst_tab_barcode, "normale") 
		
		k_riga++ 
		 
	loop

//--- aggiorna Barcode FIGLI
	k_n_righe = dw_groupage.rowcount()
	k_riga = 1 
	do while k_riga <= k_n_righe and trim(kst_esito.esito) =  kkg_esito.ok

		dw_groupage.setitem(k_riga, "barcode_pl_barcode", kst_tab_pl_barcode.codice)

		kst_tab_barcode.barcode = trim(dw_groupage.getitemstring(k_riga, "barcode_barcode"))
		kst_tab_barcode.pl_barcode = dw_groupage.getitemnumber(k_riga, "barcode_pl_barcode")			
		kst_tab_barcode.pl_barcode_progr = dw_groupage.getitemnumber(k_riga, "barcode_pl_barcode_progr")			
		kst_tab_barcode.g3ciclo = dw_groupage.getitemnumber(k_riga, "g3ciclo")	
		kst_tab_barcode.g3ngiri = dw_groupage.getitemnumber(k_riga, "g3ngiri")	
		kst_tab_barcode.g3npass = dw_groupage.getitemnumber(k_riga, "g3npass")	
		kst_tab_barcode.id_sl_pt_g3_lav = dw_groupage.getitemnumber(k_riga, "id_sl_pt_g3_lav")	
		kst_tab_barcode.impianto = kuf1_impianto.kki_impiantog3

		kiuf_barcode.tb_update_g3(kst_tab_barcode) //set_pl_barcode( kst_tab_barcode, "normale") 
		
		k_riga++ 
		
	loop

	kguo_sqlca_db_magazzino.db_commit( )

	ki_lista_0_modifcato = false
	dati_modif_1()

	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	k_return = "1" + kuo_exception.kist_esito.sqlerrtext
	kst_esito.sqlerrtext = "1" + kuo_exception.kist_esito.sqlerrtext + kkg.acapo + "Aggiornamento del Piano fallito! "
	kguo_sqlca_db_magazzino.db_rollback( )
	
finally
	u_crash_reset( )  // pulisce il backup di ripri
	SetPointer(kkg.pointer_default)

end try


return k_return


end function

protected function string leggi_liste ();//======================================================================
//=== Liste Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
string k_sort = " "
long k_pl_barcode, k_riga
int k_rc
int k_ciclo_min, k_ciclo_max, k_ciclo, k_npass
st_tab_barcode kst_tab_barcode
datastore kds_meca_kchoose
datastore kds_1


	SetPointer(kkg.pointer_attesa)

	dw_meca.setredraw(false)
	dw_barcode.reset( )

	dw_guida.event u_inizializza()

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
		kst_tab_barcode.id_sl_pt_g3_lav = dw_meca.getitemnumber(ki_riga_pos_dw_meca, "id_sl_pt_g3_lav")
	end if

//=== acchiappa il sort della merce da trattare
	k_sort = dw_meca.Object.DataWindow.Table.Sort

	if dw_meca.rowcount() > 0 then
//--- salva il dw_meca x ripri dei selezionati		
		kds_meca_kchoose = create datastore
		kds_meca_kchoose.dataobject = dw_meca.dataobject
		dw_meca.rowscopy(1, dw_meca.rowcount(), Primary!, kds_meca_kchoose, 1, Primary!)
	end if

//--- leggo righe 
	ki_refresh_dw_meca_needed = false

	dw_meca.title = "Lotti non Pianificati"
	if ki_impianto_des > " " then
		dw_meca.title += ki_impianto_des
	end if
	dw_meca.title += " dal " + string(ki_data_ini, "dd mmm yyyy") + " "
	
	k_npass = dw_guida.getitemnumber(1, "g3npass")
	if k_npass > 0 then
		dw_meca.title += "Pass: " + string(k_npass) + " "
	else
		dw_meca.title += "Pass: TUTTI "
	end if
	
	choose case dw_guida.getitemnumber(1, "filtrocicli")
		case 0
			k_ciclo = dw_guida.getitemnumber(1, "g3ciclo")
			if k_ciclo > 0 then
				dw_meca.title += "Ciclo: " + string(k_ciclo) + " "
			else
				dw_meca.title += "Ciclo: TUTTI "
			end if
		case 1
			k_ciclo_min = dw_guida.getitemnumber(1, "ciclo_min")
			k_ciclo_max = dw_guida.getitemnumber(1, "ciclo_max")
			dw_meca.title += "Filtro per Ciclo: " + string(k_ciclo_min) + " - " + string(k_ciclo_max) + "."
		case 2
			dw_meca.title += "Ciclo: TUTTI "
	end choose

	dw_meca.retrieve(k_pl_barcode, ki_data_ini, k_npass, k_ciclo, k_ciclo_min, k_ciclo_max)   //--- leggo su DB
		
//=== Salva le righe del dw (saveas)
	kGuf_data_base.dw_saveas("no_pl", dw_meca)
		
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
														+ " and id_sl_pt_g3_lav = " + string(kst_tab_barcode.id_sl_pt_g3_lav) &
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
		dw_meca.setrow(ki_riga_pos_dw_meca)
	end if

	dw_meca.setredraw(true)
	dw_meca.setfocus( )

	SetPointer(kkg.pointer_default)

return k_return

end function

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

public subroutine smista_funz (string k_par_in);//---
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

		
	case kkg_flag_richiesta.libero2		//modifica dati di Trattamento
		if u_open_w_armo_sl_pt_g3_lav() then
			dw_barcode.reset( )
		end if

	case kkg_flag_richiesta.libero3		//Imposta Flag 'Stato_in_attenzione'
		if cb_aggiungi.enabled then
			set_stato_in_attenzione( )
		end if
	case kkg_flag_richiesta.libero4		//Aggiungi riga
		if cb_aggiungi.enabled then
			cb_aggiungi.postevent(clicked!)
		end if
	case kkg_flag_richiesta.libero5		//Controllo Programmazione
		u_check_programmazione( )
	case kkg_flag_richiesta.libero6		//Riapre/Chiude Progetto
		if cb_chiudi.enabled then
			u_mostra_proprieta(true)
		end if
	case kkg_flag_richiesta.libero71		//Consenti di mettere in lavorazione Lotti NON associati in WMF 
		if not ki_PL_chiuso then
			ki_consenti_lavoraz_non_associati_wmf = not ki_consenti_lavoraz_non_associati_wmf  // setta True/False il flag
		end if
		
	case kkg_flag_richiesta.libero8  	//Crea Groupage prodotti da Palmare
		open_elenco_lettore_grp()

	case kkg_flag_richiesta.refresh		//Aggiorna Liste
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
		m_main.m_strumenti.m_fin_gest_libero1.visible = true
	end if

	//if m_main.m_strumenti.m_fin_gest_libero2.enabled <> cb_file.enabled then
		m_main.m_strumenti.m_fin_gest_libero2.text = "&Trattamento"
		m_main.m_strumenti.m_fin_gest_libero2.microhelp = "Visualizza/Modifica dati di trattamento del Lotto "
		m_main.m_strumenti.m_fin_gest_libero2.enabled = true //cb_file.enabled
		m_main.m_strumenti.m_fin_gest_libero2.toolbaritemtext = "Giri,"+ m_main.m_strumenti.m_fin_gest_libero2.text
		m_main.m_strumenti.m_fin_gest_libero2.toolbaritemvisible = true
		m_main.m_strumenti.m_fin_gest_libero2.toolbaritemname = "cicli16.png"
	//	ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex = 2
		m_main.m_strumenti.m_fin_gest_libero2.visible = true
//	end if

	m_main.m_strumenti.m_fin_gest_libero3.enabled = ki_autorizza_marca_stato_in_attenzione
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
	
	if not ki_PL_chiuso then 
		m_main.m_strumenti.m_fin_gest_libero6.text = "Chiudi P.L."
		m_main.m_strumenti.m_fin_gest_libero6.microhelp = 	"Salva e Chiude il Piano di Lavorazione, NON SARA' PIU' possibile effettuare alcuna modifica     "
		m_main.m_strumenti.m_fin_gest_libero6.toolbaritemtext = "Chiudi,"+ m_main.m_strumenti.m_fin_gest_libero6.text
		//ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemname = kGuo_path.get_risorse() + "\lucch16.png"
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


if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento &
   or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
	cb_aggiorna.enabled = true
//	cb_togli.enabled = true
	cb_aggiungi.enabled = true
	cb_cancella.enabled = true
	cb_chiudi.enabled = ki_chiudi_PL_enabled 
else
	cb_aggiorna.enabled = false
//	cb_togli.enabled = false
	cb_aggiungi.enabled = false
	cb_chiudi.enabled = ki_chiudi_PL_enabled
	cb_cancella.enabled = false
end if



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

public subroutine u_mostra_proprieta (boolean k_forza_visible);//---
//--- Mostra finestra Proprietà
//---
st_tab_pl_barcode kst_tab_pl_barcode


//--- se non è visibile o è da forzare la visibilita allora VISIBLE!
if not dw_dett_0.visible or k_forza_visible then

	if dw_dett_0.rowcount() = 0 then
		kiuf_pl_barcode.set_pl_barcode_nuovo_default(kst_tab_pl_barcode)
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

private subroutine set_dw_dett_0 (st_tab_pl_barcode kst_tab_pl_barcode);//---
//---
int k_riga = 0

dw_dett_0.reset()
dw_dett_0.insertrow(0)
k_riga = 1 //dw_dett_0.rowcount()

	
	setnull(kst_tab_pl_barcode.data_chiuso)
	setnull(kst_tab_pl_barcode.data_sosp)
	
	dw_dett_0.setitem(k_riga, "codice", kst_tab_pl_barcode.codice)
	dw_dett_0.setitem(k_riga, "data", kst_tab_pl_barcode.data) 
	dw_dett_0.setitem(k_riga, "priorita", kst_tab_pl_barcode.priorita)
	dw_dett_0.setitem(k_riga, "stato_pl", kst_tab_pl_barcode.stato_pl)
	dw_dett_0.setitem(k_riga, "data_chiuso", kst_tab_pl_barcode.data_chiuso)
	dw_dett_0.setitem(k_riga, "data_sosp", kst_tab_pl_barcode.data_sosp)
	dw_dett_0.setitem(k_riga, "note_1", kst_tab_pl_barcode.note_1)
	dw_dett_0.setitem(k_riga, "note_2", kst_tab_pl_barcode.note_2)
	dw_dett_0.setitem(k_riga, "programmi_richieste_id_programma", kst_tab_pl_barcode.id_programma)

	dw_dett_0.SetItemStatus(k_riga, 0, Primary!, NotModified!)





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

	kdsi_elenco_output.dataobject = "d_pilota_queue_g3" 
	k_rc = kdsi_elenco_output.settrans ( kguo_sqlca_db_pilota_g3 )  // conn/disconn in automatico
	k_rc = kdsi_elenco_output.retrieve()

	kst_open_w.key1 = "Elenco Barcode in coda di Lavorazione Impianto G3" 
	
	if kdsi_elenco_output.rowcount() > 0 then
	
		k_riga_max_queue = kdsi_elenco_output.rowcount() 
		if k_riga_max_queue > 0 then
			for k_riga = 1 to k_riga_max_queue 
				kst_tab_barcode[k_riga].barcode = kdsi_elenco_output.getitemstring( k_riga, "barcode")
			next
			kds1_barcode_x_pilota_queue = create kds_barcode_x_pilota_queue
			k_riga_max = kds1_barcode_x_pilota_queue.u_retrieve(kst_tab_barcode[])
			for k_riga = 1 to k_riga_max 
				k_riga_queue = kdsi_elenco_output.find("barcode = '" + kds1_barcode_x_pilota_queue.getitemstring(k_riga, "barcode") + "'" , 1, k_riga_max_queue)
				if kds1_barcode_x_pilota_queue.getitemdate(k_riga, "consegna_data") > kkg.data_zero then
					kdsi_elenco_output.setitem(k_riga_queue, "consegna_data", string(kds1_barcode_x_pilota_queue.getitemdate(k_riga, "consegna_data"), "dd mmm" ))
				end if
				kdsi_elenco_output.setitem(k_riga_queue, "id_meca", kds1_barcode_x_pilota_queue.getitemnumber(k_riga, "id_meca"))
				//kdsi_elenco_output.setitem(k_riga_queue, "num_int", kds1_barcode_x_pilota_queue.getitemnumber(k_riga, "num_int"))
				kdsi_elenco_output.setitem(k_riga_queue, "e1ancodrs", kds1_barcode_x_pilota_queue.getitemstring(k_riga, "e1ancodrs"))
			next
		end if
		
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

end subroutine

public subroutine call_elenco_grp ();//
kuf_barcode_tree kuf1_barcode_tree


	try
		
		kuf1_barcode_tree = create kuf_barcode_tree
		kuf1_barcode_tree.link_call( dw_meca, "grp" )
		
	catch (uo_exception kuo_exception)
		
		
	finally 
		destroy kuf1_barcode_tree
		//ki_dragdrop = false
		dw_meca.drag(cancel!)
		
	end try

end subroutine

private subroutine cambia_periodo_elenco ();//---
//--- Visualizza il box x il cambio del Periodo di elenco fatture 
//---


dw_periodo.triggerevent("ue_visibile")

end subroutine

protected function string cancella ();//
string k_return="0 "
string k_desc
long k_codice
string k_errore = "0 "
long k_riga
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

	if messagebox("Elimina Programmazione", "Sei sicuro di voler Cancellare il Piano n: " + string(k_codice, "####0") &
				+ " " + kkg.acapo + trim(k_desc), &
				question!, yesno!, 1) = 1 then
 
//=== Cancella la riga dal data windows di lista
		kst_tab_pl_barcode.codice = k_codice
		k_errore = kiuf_pl_barcode.tb_delete(kst_tab_pl_barcode) 
		if Left(k_errore, 1) = "0" then

			kguo_sqlca_db_magazzino.db_commit( )
			
			dw_dett_0.deleterow(k_riga)

			dw_dett_0.setfocus()

		else

			kguo_sqlca_db_magazzino.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							Mid(k_errore, 2) ) 	

			attiva_tasti()
	
		end if

	else
		messagebox("Elimina Programmazione", "Operazione Annullata !!")
	end if

	dw_dett_0.setcolumn(1)

end if

return(k_return)
end function

protected function string dati_modif (string k_titolo);//=== Controllo se ci sono state modifiche di dati sui DW
string k_return="0 "
int k_msg
string k_key


	dw_dett_0.accepttext()

	pulizia_righe()

	if dati_modif_1() then
		
		k_return = "1"

		if isnull(k_titolo) or Len(trim(k_titolo)) = 0 then
			k_titolo = "Aggiorna Archivio"
		end if

		k_msg = messagebox(k_titolo, "Dati Modificati, vuoi Salvare gli Aggiornamenti ? ", &
							question!, yesnocancel!, 1) 
	
		k_return = string(k_msg, "0")
		
	end if


return k_return
end function

protected function boolean dati_modif_1 ();//
//--- dati modificati?
//--- true=si; false=no
//
boolean k_boolean


	if dw_dett_0.getitemnumber( 1, "codice") > 0 then
	else
		
//--- x pl nuovo se non ci sono righe Pianificate non faccio nulla
		if dw_lista_0.rowcount( ) = 0 then 
			ki_lista_0_modifcato = false
		end if

	end if			
			
	if ki_lista_0_modifcato then
		
		k_boolean = true
		
	end if
			
return k_boolean
	
end function

protected function integer inserisci ();//
st_tab_pl_barcode kst_tab_pl_barcode


	ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento

//=== Pulizia della riga
	dw_lista_0.reset()
	dw_groupage.reset()

//--- Aggiunge una riga al dw delle proprietà
//--- setta i dati di default del pl_barcode
	kiuf_pl_barcode.set_pl_barcode_nuovo_default(kst_tab_pl_barcode)
	set_dw_dett_0(kst_tab_pl_barcode)

	attiva_tasti()

	proteggi_campi()

//--- rilegge le liste utili al nuovo programma da fare
	ki_riga_pos_dw_meca = dw_meca.getrow( )  //cattura la riga selezionata
	dw_meca.setfocus( )
	leggi_liste()


return (0)


end function

protected subroutine pulizia_righe ();//
//=== Oltre a confermare ACCEPTTEXT toglie righe da non UPDATE
//
string k_key
long k_riga, k_ctr


dw_dett_0.accepttext()
dw_lista_0.accepttext()
dw_groupage.accepttext()


////=== Pulisco eventuali righe rimaste vuote e aggiusto campi a NULL
//k_riga = dw_dett_0.rowcount ( )
//for k_ctr = k_riga to 1 step -1
//
// 	if dw_dett_0.getitemnumber(k_ctr, "codice") > 0 &
// 			or dw_dett_0.getitemdate(k_ctr, "data") > date(0)) &
// 			or trim(dw_dett_0.getitemstring(k_ctr, "note_1")) > " " &
// 			or trim(dw_dett_0.getitemstring(k_ctr, "note_2")) > " " then
//	else
//		dw_dett_0.deleterow(k_ctr)
//	end if
//next
if dw_dett_0.rowcount( ) <= 0 then
	inserisci()
end if

//=== Pulisco eventuali righe rimaste vuote e aggiusto campi a NULL
k_riga = dw_lista_0.rowcount ( )
for k_ctr = k_riga to 1 step -1
	if trim(dw_lista_0.getitemstring(k_ctr, "barcode_barcode")) > " " then
	else
		dw_lista_0.deleterow(k_ctr)
	end if
next

//=== Pulisco eventuali righe rimaste vuote e aggiusto campi a NULL
k_riga = dw_groupage.rowcount ( )
for k_ctr = k_riga to 1 step -1
	if trim(dw_groupage.getitemstring(k_ctr, "barcode_barcode")) > " " then
	else
		dw_groupage.deleterow(k_ctr)
	end if
next



end subroutine

protected subroutine riempi_id ();/*
non fa nulla
*/



end subroutine

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

private subroutine u_refresh_dw ();//
st_esito kst_esito


choose case  kidw_selezionata.dataobject 

	case "d_pl_barcode_dett_grp_all"
		kst_esito = retrieve_figli_all()
		if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn  then
			kguo_exception.set_esito( kst_esito)
			kguo_exception.messaggio_utente()
		end if

	case else
		ki_riga_pos_dw_meca = dw_meca.getrow( )  //cattura la riga selezionata
		leggi_liste()

end choose

dw_barcode.reset()

attiva_tasti( )

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

protected subroutine stampa ();//
string k_nome_controllo, k_codice
st_stampe kst_stampe
w_g_tab kwindow_1

k_codice = string(dw_dett_0.getitemnumber(1, "codice"))
if k_codice > " " then
else
	k_codice = "NUOVO"
end if

k_nome_controllo = kidw_selezionata.dataobject 

choose case k_nome_controllo
	case dw_lista_0.dataobject
	
		kwindow_1 = kGuf_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_lista_0
		kst_stampe.titolo = ("Barcode in Programmazione Piano " + k_codice)
		kGuf_data_base.stampa_dw(kst_stampe)

	case dw_groupage.dataobject 
	
		kwindow_1 = kGuf_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_groupage
		kst_stampe.titolo = ("Barcode 'groupage' in Programmazione nel Piano " + string(dw_dett_0.getitemnumber(1, "codice")))
		kGuf_data_base.stampa_dw(kst_stampe)

	case dw_meca.dataobject 
	
		kwindow_1 = kGuf_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_meca
		kst_stampe.titolo = trim(dw_meca.title)
		kGuf_data_base.stampa_dw(kst_stampe)
		
	case dw_barcode.dataobject 
	
		kwindow_1 = kGuf_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_barcode
		kst_stampe.titolo = trim(dw_barcode.title)
		kGuf_data_base.stampa_dw(kst_stampe)
		
//	case dw_prev.dataobject
//	
//		kwindow_1 = kGuf_data_base.prendi_win_attiva()
//	
//		kst_stampe.dw_print = dw_prev
//		kst_stampe.titolo = trim(dw_prev.title)
//		kGuf_data_base.stampa_dw(kst_stampe)
		
//	case dw_pilota_inlav.dataobject
//	
//		kwindow_1 = kGuf_data_base.prendi_win_attiva()
//	
//		kst_stampe.dw_print = dw_pilota_inlav
//		kst_stampe.titolo = trim(dw_pilota_inlav.title)
//		kGuf_data_base.stampa_dw(kst_stampe)
		
end choose

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
ds_pl_barcode_dett kds_pl_barcode_dett
st_tab_pl_barcode kst_tab_pl_barcode


	kds_pl_barcode_dett = create ds_pl_barcode_dett

	dw_lista_0.accepttext()
	dw_groupage.accepttext()
	
	k_riga = dw_dett_0.getrow() 
	if k_riga > 0 then
	else
		k_riga = dw_dett_0.insertrow(0)
	end if

	if isnull(dw_dett_0.getitemnumber(k_riga, "codice")) then
		dw_dett_0.setitem(k_riga, "codice", 0)
	end if

//--- controllo se PL ancora aperto altrimenti NISBA
	try 
		kst_tab_pl_barcode.codice = dw_dett_0.object.codice[1]
		if kst_tab_pl_barcode.codice > 0 then
			if not kiuf_pl_barcode.if_pl_barcode_aperto(kst_tab_pl_barcode) then
				ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione   // forza visualizzazione
				k_return = & 
					"Piano di Lavoro NON APERTO, operazione bloccata! Prego uscire Immediatamente.  " + "~n~r"
				k_errore = "1"
			end if
		end if
	catch (uo_exception kuo1_exception)
		kst_esito = kuo1_exception.get_st_esito()
		k_return += "Errore: " + trim(kst_esito.sqlerrtext)  + "~n~r"
		k_errore = "1"
	end try

	try
//--- Controllo programmazione
		if_programmazione_ok()
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito( )
		k_return += trim(kst_esito.sqlerrtext) + "~n~r"
		k_errore = "1"
	end try


	if k_errore = "0" or k_errore = "4" then
		kst_tab_pl_barcode.data = dw_dett_0.getitemdate ( k_riga, "data") 
		if isnull(kst_tab_pl_barcode.data) or kst_tab_pl_barcode.data = date(0) then
			k_return += "Impostare la data di questo Piano " + kkg.acapo 
			k_errore = "3"
		end if
	
//--- se sono in CHIUSURA controlla la data	
		if ki_operazione_chiusura then 
	
			kst_tab_pl_barcode.data_chiuso = dw_dett_0.getitemdate ( k_riga, "data_chiuso") 
			if k_errore = "0" or k_errore = "4" then
				if kst_tab_pl_barcode.data_chiuso > date(0) then
					if kst_tab_pl_barcode.data > kst_tab_pl_barcode.data_chiuso then
						k_return = k_return + & 
						 "Data di Chiusura " + string(kst_tab_pl_barcode.data_chiuso) + " precedente alla data del Piano " &
				 			+ string(kst_tab_pl_barcode.data) + ". " &
							+ "Prego sistemarla. " + kkg.acapo 
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
 				k_return += "Data del Piano "  + string (kst_tab_pl_barcode.data) &
								 + ", diversa dalla data odierna (" + string(k_dataoggi) + ") " + kkg.acapo 
				k_errore = "4"
			end if

//--- se sono in CHIUSURA controlla la data	
			if ki_operazione_chiusura then 
				if kst_tab_pl_barcode.data_chiuso > KKG.DATA_ZERO and kst_tab_pl_barcode.data_chiuso <> k_dataoggi then
					k_return += "Data Chiusura del Piano " + string(kst_tab_pl_barcode.data_chiuso) &
									+ ", diversa dalla data odierna (" + string(k_dataoggi) +") " + kkg.acapo  
					k_errore = "4"
				end if
			end if
		end if
	end if

	if k_errore = "0" or k_errore = "4" then
		kst_tab_pl_barcode.data_sosp = dw_dett_0.getitemdate ( k_riga, "data_sosp")
		if kst_tab_pl_barcode.data_sosp > kst_tab_pl_barcode.data_chiuso then
 			k_return += "Data Sospensione " + string(kst_tab_pl_barcode.data_sosp) &
			 				 + " maggiore della data di Chiusura (" + string(kst_tab_pl_barcode.data_chiuso) + "). " &
							 + "Prego sistemarla. " + kkg.acapo 
			k_errore = "4"
		end if
	end if

//--- controllo la priorita se congruente con il valore nel campo 'pima del barcode'
	if k_errore = "0" or k_errore = "4" then
		if trim(dw_dett_0.getitemstring ( k_riga, "priorita")) = kiuf_pl_barcode.k_priorita_prima_del_barcode then
			if trim(dw_dett_0.getitemstring ( k_riga, "prima_del_barcode")) > " " then
			else
 				k_return += "Attenzione, indicare il valore nel campo 'Prima del Barcode'. " + kkg.acapo 
				k_errore = "2"
			end if
		else
			dw_dett_0.setitem ( k_riga, "prima_del_barcode", "")
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
					
					k_return += & 
							  + "Il Barcode "+ trim(k_barcode) +" è già presente nel Piano " + string(kst_tab_barcode.pl_barcode) &
							  + ". Lo elimino dalla LISTA. " + kkg.acapo 
					k_errore = "1"
					k_nr_errori++
					
					dw_lista_0.deleterow(k_riga)  // Elimino la riga gia associata ad altro Piano dalla Lista!!!
					
				end if
				
			catch (uo_exception kuo2_exception)
				kst_esito = kuo2_exception.get_st_esito()
				k_return += & 
						   "Problemi durante controllo barcode " + trim(k_barcode) + " se già pianificato, " + trim(kst_esito.sqlerrtext) + ". " + kkg.acapo 
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
					k_return += & 
							 "Stesso Barcode presente in piu' righe, " + kkg.acapo &
							  + "(Codice " + trim(k_barcode) + ") vedi alla riga " + string(k_riga_find) + "; " + kkg.acapo 
					k_errore = "1"
					k_nr_errori++
				end if
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
				k_return += trim(kst_esito.sqlerrtext ) + "; " + kkg.acapo 
				k_errore = "4"
				k_nr_errori++
			else
				k_return += trim(kst_esito.sqlerrtext ) + "; " + kkg.acapo 
				k_errore = "1"
				k_nr_errori++
			end if
		end if
		
	end if

	if k_errore = "0" or k_errore = "4" then
		try
			imposta_id_sl_pt_g3(dw_groupage, 0)  // Imposta dati di trattamento su tutti i Figli
		catch (uo_exception kuo3_exception)
			kst_esito = kuo3_exception.get_st_esito()
			k_return += & 
						"Problemi durante controllo groupage " + trim(k_barcode) + " in ricerca dati di Trattamento G3, " + trim(kst_esito.sqlerrtext) + ". " + kkg.acapo 
			k_errore = "1"
		end try
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
					k_return += & 
							 "Stesso 'Figlio' presente su piu' righe, "  &
							 + "(Codice " + trim(k_barcode) + ") vedi alla riga " + string(k_riga_find) + "; " + kkg.acapo
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
								k_return += & 
									  "Barcode figlio " + trim(k_barcode) + " nello stato diverso da 'Associato' ('20'), "  &
									  + " vedi alla riga " + string(k_riga) + "; " + kkg.acapo
								k_errore = "1"
								k_nr_errori++
							end if
						end if
					end if	
				end if
				
			catch (uo_exception kuo4_exception)
				kst_esito = kuo4_exception.get_st_esito()
				k_return += & 
					  "Problemi durante controllo stato 'Figlio' " + trim(k_barcode) + ", " &
					  + trim(kst_esito.sqlerrtext) + " " + kkg.acapo
				k_errore = "1"
				k_nr_errori++
			end try

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

public subroutine u_aggiungi_a_dw_lista (string a_dw_name);//
	choose case a_dw_name
			
		case "dw_meca" 
			u_aggiungi_barcode_tutti(dw_lista_0)
	
		case "dw_barcode" 
			u_aggiungi_barcode_singolo(dw_lista_0, dw_barcode)
			
		case "dw_groupage" 
			u_aggiungi_barcode_singolo(dw_lista_0, dw_groupage)
				
	end choose

	attiva_tasti()

	dw_lista_0.setfocus( )
	
end subroutine

private subroutine u_set_dragdrop ();//
boolean k_enable_dragdrop


	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
		k_enable_dragdrop = true
	end if

	dw_lista_0.ki_attiva_dragdrop = k_enable_dragdrop
	dw_barcode.ki_attiva_dragdrop = k_enable_dragdrop
	dw_meca.ki_attiva_dragdrop = k_enable_dragdrop
	dw_groupage.ki_attiva_dragdrop = k_enable_dragdrop

	dw_lista_0.ki_attiva_dragdrop_self = k_enable_dragdrop
	dw_barcode.ki_attiva_dragdrop_self = false
	dw_meca.ki_attiva_dragdrop_self = false
	dw_groupage.ki_attiva_dragdrop_self = false

end subroutine

private subroutine scegli_padre_da_dw_lista (long a_riga_dw_groupage);//
//=== Premuto pulsante nella DW
//
boolean k_aperto = true
int k_rc
long k_rows, k_row
string k_cond_to_delete
st_tab_barcode kst_tab_barcode
st_tab_pl_barcode kst_tab_pl_barcode
st_esito kst_esito
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window
//kds_sl_pt_g3_lav_if_padre_figlio_ok kds1_sl_pt_g3_lav_if_padre_figlio_ok
uo_ds_std_1 kds_padri_potenziali 
st_tab_sl_pt_g3_lav kst_tab_sl_pt_g3_lav


try

//--- Devo poter essere in inserimento o modifca x fare questa operazione...
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento &
  					 or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then

		kguo_exception.inizializza(this.classname())
		
		kst_tab_pl_barcode.codice = dw_dett_0.object.codice[1]
		kst_tab_barcode.barcode = trim(dw_groupage.object.barcode_barcode[a_riga_dw_groupage])
	//--- datasore per appoggio elenco barcode padri potenziali
		if not isvalid(kdsi_elenco_output_1) then kdsi_elenco_output_1 = create uo_ds_std_1
	
		if kst_tab_pl_barcode.codice > 0 then
			k_aperto = kiuf_pl_barcode.if_pl_barcode_aperto(kst_tab_pl_barcode) 
		else
			kst_tab_pl_barcode.codice = 0
		end if
		
	//--- Se PL non aperto EXIT
		if not k_aperto then 
			kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
			kguo_exception.kist_esito.sqlerrtext = "Operazione non permessa, il Piano di Lavoro " + string(kst_tab_pl_barcode.codice)+ " è già stato Chiuso. "
			throw kguo_exception
		end if

		//kds1_sl_pt_g3_lav_if_padre_figlio_ok = create kds_sl_pt_g3_lav_if_padre_figlio_ok
		kdsi_elenco_output_1.dataobject = "d_barcode_g3_padri_potenziali"
		kdsi_elenco_output_1.settransobject(kguo_sqlca_db_magazzino)
		
		kst_tab_sl_pt_g3_lav.id_sl_pt_g3_lav = dw_groupage.object.id_sl_pt_g3_lav[a_riga_dw_groupage]
		kst_tab_sl_pt_g3_lav.ciclo_target = dw_groupage.object.g3ciclo[a_riga_dw_groupage]
		kst_tab_sl_pt_g3_lav.g3npass = dw_groupage.object.g3npass[a_riga_dw_groupage]
		
		
		if kst_tab_sl_pt_g3_lav.id_sl_pt_g3_lav > 0 and kst_tab_sl_pt_g3_lav.ciclo_target > 0 then
		else
			if k_rows = 0 then  
				kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
				kguo_exception.kist_esito.sqlerrtext = "Elenco Barcode Padri non possibile, mancano tutti o in parte i dati del Trattamento sul Barcode " + trim(kst_tab_barcode.barcode) + ". "
				throw kguo_exception
			end if
		end if
		
		k_rows = kdsi_elenco_output_1.retrieve(kst_tab_pl_barcode.codice &
												, kst_tab_sl_pt_g3_lav.g3npass &
												, kst_tab_sl_pt_g3_lav.ciclo_target &
												, kst_tab_barcode.barcode)
		if k_rows < 0 then
			kguo_exception.set_st_esito_err_ds(kdsi_elenco_output_1, &
						"Errore in elenco Barcode Padri associabili al Barcode " + kst_tab_barcode.barcode + ". ")
			throw kguo_exception
		end if
//--- Se non ci sono PADRI disponibili chiude
		if k_rows = 0 then  
			kguo_exception.kist_esito.esito = kkg_esito.not_fnd
			kguo_exception.kist_esito.sqlerrtext = "Nessun barcode trovato da associare come padre al barcode " + trim(kst_tab_barcode.barcode) + ". "
			throw kguo_exception
		end if
		
// rimuove da elenco Padri Potenziali i barcode già presenti come Figlio in Groupage
		for k_row = k_rows to 1 step -1
			if dw_groupage.find("barcode_barcode = '" + kdsi_elenco_output_1.object.barcode[k_row] + "' ", 1, dw_lista_0.rowcount()) > 0 then
				kdsi_elenco_output_1.deleterow(k_row)   // rimuovo è un barcode figlio
			end if
		next
			
		kdsi_elenco_output_1.sort( )
			
		kst_open_w.key1 = "Sceglere il 'padre' per il barcode: " + trim(string(kst_tab_barcode.barcode,"@@@ @@@@@@@@@")) &
							+ " e Ciclo: " + string(kst_tab_sl_pt_g3_lav.ciclo_target)
							
		if kdsi_elenco_output_1.rowcount() > 0 then
	
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
			kst_open_w.key2 = trim(kdsi_elenco_output_1.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = kiw_this_window.title    //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key12_any = kdsi_elenco_output_1
			kst_open_w.flag_where = " "
			kuf1_menu_window = create kuf_menu_window 
			kuf1_menu_window.open_w_tabelle(kst_open_w)
			destroy kuf1_menu_window
	
		else
			
			kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
			kguo_exception.kist_esito.sqlerrtext =  &
						"Nessun barcode padre disponibile da associare al " + trim(string(kst_tab_barcode.barcode,"@@@ @@@@@@@@@")) + " per il trattamento, Ciclo=" &
								 + string(dw_groupage.object.g3ciclo[a_riga_dw_groupage]) &
								 + " e id lavorazione=" + string(dw_groupage.object.id_sl_pt_g3_lav[a_riga_dw_groupage])
			throw kguo_exception
		end if
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally
	
end try



end subroutine

private function boolean u_open_w_armo_sl_pt_g3_lav ();/*
  Chiama window di modifica dati di Trattamento
  out: true = dati modificati
*/
boolean k_return 
long k_row
kuf_armo_sl_pt_g3_lav kuf1_armo_sl_pt_g3_lav
st_open_w kst_open_w

	k_row = dw_meca.getselectedrow(0)
	if k_row > 0 then
	else
		messagebox("Modifica Trattamento", "Prego selezionare una riga da elenco Lotti")
		return false
	end if

	kuf1_armo_sl_pt_g3_lav = create kuf_armo_sl_pt_g3_lav
	
	
	kuf1_armo_sl_pt_g3_lav.kist_tab_armo_sl_pt_g3_lav.id_armo = dw_meca.getitemnumber(k_row, "id_armo")
	kuf1_armo_sl_pt_g3_lav.kist_tab_armo_sl_pt_g3_lav.id_sl_pt_g3_lav = dw_meca.getitemnumber(k_row, "id_sl_pt_g3_lav")
	kuf1_armo_sl_pt_g3_lav.kist_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav = 0

	kst_open_w.key12_any = kuf1_armo_sl_pt_g3_lav
	kst_open_w.key10_window_chiamante = this
	kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
	
	kuf1_armo_sl_pt_g3_lav.u_open(kst_open_w)   // OPEN WINDOWS MODIFICA DATI TRATTAMENTO
	
//--- se ho dati giri in deroga oppure li ho tolti allora torna a TRUE
	if kuf1_armo_sl_pt_g3_lav.kist_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav > 0 &
			or kuf1_armo_sl_pt_g3_lav.kist_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav <> dw_meca.getitemnumber(k_row, "id_armo_sl_pt_g3_lav") then 
		k_return = true
	end if

	if isvalid(kuf1_armo_sl_pt_g3_lav) then destroy kuf1_armo_sl_pt_g3_lav
	
return k_return 

end function

private subroutine u_aggiungi_figli_al_dw_groupage (long a_row);/*
   Verifica del barcode se ha figli se il barcode ha figli li AGGIUNGO dalla dw
   Inp: kst_tab_barcode.barcode 
*/
long k_row_kds_1, k_rows_grp
int k_rc, k_rows
string k_rcx
st_tab_barcode kst_tab_barcode
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_prodotti kst_tab_prodotti
st_tab_armo kst_tab_armo
st_tab_asdrackbarcode kst_tab_asdrackbarcode
st_tab_sl_pt kst_tab_sl_pt
uo_ds_std_1 kds_1


ki_lista_0_modifcato = true

try
	
	kguo_exception.inizializza(this.classname())
	
	kst_tab_barcode.barcode = trim(dw_lista_0.getitemstring(a_row, "barcode_barcode"))
	
	kds_1 = kiuf_barcode.get_figli_barcode(kst_tab_barcode)  //get figli del barcode per aggiungerli
	k_rows = kds_1.rowcount( )
	if k_rows <= 0 then	return 
		
	dw_groupage.setredraw(false)
	
	for k_row_kds_1 = 1 to k_rows

		kst_tab_barcode.barcode = kds_1.object.barcode[k_row_kds_1]

//--- Cerco il barcode tra i figli e padri gia' presenti (non ci possono essere NONNI)
		k_rows_grp = dw_groupage.find("barcode_barcode = '" + trim(kst_tab_barcode.barcode) + "' or barcode_lav = '" + trim(kst_tab_barcode.barcode) + "'", 1, dw_groupage.rowcount()) 
		if k_rows_grp < 0 then
			kguo_exception.kist_esito.esito = kkg_esito.ko
			kguo_exception.kist_esito.sqlerrtext = "Errore in ricerca barcode " + trim(kst_tab_barcode.barcode) + " tra i groupage (err.="+ string(k_rows_grp)+") "&
															+ kkg.acapo + "Operazione interrotta!"
			throw kguo_exception												
		end if	
			
//--- se il barcode non c'e' ancora tra i figli allora lo aggiungo
		if k_rows_grp > 0 then
			continue   // fa nuvo giro
		end if
		
		k_rows_grp = dw_groupage.insertrow(1)
			
		kiuf_barcode.select_barcode( kst_tab_barcode )
		kst_tab_armo.id_armo = kst_tab_barcode.id_armo
		kiuf_armo.leggi_riga( " ", kst_tab_armo )
		
		kst_tab_armo.peso_kg = kst_tab_armo.peso_kg / kst_tab_armo.colli_2 // ricavo il peso x collo
		kst_tab_meca.id = kst_tab_armo.id_meca
		kiuf_armo.leggi_testa("P", kst_tab_meca )
		
		kst_tab_clienti.codice = kst_tab_meca.clie_2
		kiuf_clienti.leggi_rag_soc( kst_tab_clienti )
		kst_tab_prodotti.codice = kst_tab_armo.art
		kiuf_prodotti.select_riga( kst_tab_prodotti )
		
		kst_tab_sl_pt.cod_sl_pt = kst_tab_armo.cod_sl_pt
		kiuf_sl_pt.get_densita(kst_tab_sl_pt)

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
	
		dw_groupage.setitem(k_rows_grp, "g3npass", dw_lista_0.getitemnumber(a_row, "g3npass"))
		dw_groupage.setitem(k_rows_grp, "g3ngiri", dw_lista_0.getitemnumber(a_row, "g3ngiri"))
		dw_groupage.setitem(k_rows_grp, "g3ciclo", dw_lista_0.getitemnumber(a_row, "g3ciclo"))
		dw_groupage.setitem(k_rows_grp, "ciclo_min", 0)
		dw_groupage.setitem(k_rows_grp, "ciclo_max", 0)
		dw_groupage.setitem(k_rows_grp, "id_sl_pt_g3_lav", 0)

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
		dw_groupage.setitem(k_rows_grp, "dose",kst_tab_armo.dose)
		dw_groupage.setitem(k_rows_grp, "e1ancodrs",kst_tab_clienti.e1ancodrs)
		dw_groupage.setitem(k_rows_grp, "id_asdrackcode",kst_tab_asdrackbarcode.id_asdrackcode)
		
		if kst_tab_sl_pt.densitamax > 0 then
			dw_groupage.setitem(k_rows_grp, "k_densita", kst_tab_sl_pt.densitamax )
		else
			dw_groupage.setitem(k_rows_grp, "k_densita", kst_tab_sl_pt.densita )
		end if
		
	next
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	dw_groupage.setredraw(true)
	if isvalid(kds_1) then destroy kds_1
	
end try


end subroutine

private function boolean u_stop_if_lotto_in_attenzione (long a_row_meca);/*
   Controlla se LOTTO in stato di ATTENZIONE
	Rit: TRUE = richiesta di stop per lotto in attenzione
*/
			
//--- Controllo se Riferimento 'IN ATTENZIONE'
if dw_meca.getitemnumber(a_row_meca, "stato_in_attenzione") = 1 then
	if messagebox( "Lotto in ATTENZIONE", "Lotto " + string(dw_meca.getitemnumber(a_row_meca, "meca_num_int")) &
						+ " è 'IN ATTENZIONE'. NON sarebbe ancora da TRATTARE. Proseguire l'operazione?", &
						+ stopsign!, yesno!, 1) = 2 then
		return TRUE
		
	end if
end if

return FALSE


end function

private function boolean u_stop_if_lotto_non_associato (ref st_tab_meca kst_tab_meca) throws uo_exception;/*
   COntrolla se bloccare per Lotto non Assciato
   	inp: st_tab_meca.id, num_int
		Rit: TRUE = ferma elaborazione
*/

try
	
	kguo_exception.inizializza( )
	
	if kst_tab_meca.id > 0 then
		if not if_lotto_associato(kst_tab_meca) then
			
			if ki_consenti_lavoraz_non_associati_wmf then
				kguo_exception.messaggio_utente( "Manca Associazione", "Lotto n. " + string(kst_tab_meca.num_int ) + " non è stato 'Associato' ('20') - Operazione consentita grazie al consenso impostato a menu.")
			else
				kguo_exception.messaggio_utente( "Operazione Bloccata", "Lotto n. " + string(kst_tab_meca.num_int ) + " non è stato 'Associato' ('20') - Pianificazione non consentita")

				return TRUE
				
			end if
		end if
	end if

	return FALSE

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

end function

public subroutine u_aggiungi_barcode_singolo (ref uo_d_std_1 adw_out, ref uo_d_std_1 adw_inp);/*
   Aggiungi un BARCODE alla lista dei Pianificati
   adw_inp (dw_barcode/dw_groupage) -----> adw_out (dw_lista_0)
*/
long k_row_dw_lista_0, k_insertrow, k_row_drag, k_row_last=0, k_row_find=0
long k_row_meca
int k_ctr, k_rc
st_tab_barcode kst_tab_barcode, kst_tab_barcode_padre
st_tab_meca kst_tab_meca
st_tab_asdrackbarcode kst_tab_asdrackbarcode
st_esito kst_esito
kuf_sl_pt kuf1_sl_pt
	

try
	kst_esito = kguo_exception.inizializza(this.classname())

	ki_lista_0_modifcato = true

	if adw_inp.rowcount() = 0 then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Nessun barcode da Pianificare in elenco '" + trim(adw_inp.title) + "'"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	k_row_dw_lista_0 = adw_out.getselectedrow(0)  // riga dove inserire i barcode da pianificare

	u_aggiungi_barcode_singolo_check(adw_inp)  // Vari Controlli sui Barcode da Pianificare

	adw_out.setredraw(false)

	k_row_drag = adw_inp.getselectedrow(0)
	do while k_row_drag > 0 
		
		k_row_dw_lista_0 = adw_out.insertrow(k_row_dw_lista_0 + 1)
		if k_row_dw_lista_0 < 0 then
			kst_esito.esito = kkg_esito.ko
			kst_esito.sqlerrtext = "Inserimento barcode in pianificazione fallito: '" + trim(kst_tab_barcode_padre.barcode ) + "'"
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		k_row_last = k_row_dw_lista_0 
				
//--- copia la dw2 in dw1, il formato e' il solito dettaglio		
		if adw_inp.dataobject = dw_groupage.dataobject then
			copia_dw_groupage_to_dw_lista_0(k_row_dw_lista_0, k_row_drag)
		else
			copia_dw_barcode_to_dw_lista_0(k_row_dw_lista_0, k_row_drag)
		end if
				
//--- se i barcode in dw_lista hanno figli li aggiunge al dw_groupage			
		u_aggiungi_figli_dal_dw_lista(k_row_dw_lista_0)
		
//		screma_lista_from_dw_lista(k_row_dw_lista_0)  // screma dw_meca

		adw_inp.deleterow(k_row_drag) 
		k_row_drag --

//--- leggo la successiva!
		k_row_drag = adw_inp.getselectedrow(k_row_drag)
	loop
	
	
	if k_row_last > 0 then
//--- sistema il codice e i progressivi nella lista
		imposta_codice_progr( adw_out )

		adw_out.selectrow(0, false)
		adw_out.setrow(k_row_last)
		adw_out.selectrow(k_row_last, true)
		adw_out.scrolltorow(k_row_last)
		
		adw_out.setcolumn(1)
		adw_out.setfocus()

//		u_check_troppi_barcode( )
//		u_crash_dw_lista_0_backup( )  // fa il backup per ripri da eventuale crash
		
	end if

	adw_out.setredraw(true)

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	if kst_esito.esito <> kkg_esito.ok then
		kuo_exception.messaggio_utente()
	end if
	
finally
	
end try 



end subroutine

private subroutine u_aggiungi_barcode_tutti (ref uo_d_std_1 adw_out);//
//=== Aggiungi tutti i BARCODE del Lotto alla lista dei Barcode Pianificati / Groupage
//===  dw_meca ----> adw_out (dw_lista o dw_groupage)
//
long k_row_meca, k_row, k_row_delete
long k_row_out
string k_id_meca_x
st_esito kst_esito


SetPointer(kkg.pointer_attesa)

try

	k_row_meca = dw_meca.getselectedrow(0)

	if k_row_meca = 0 then	
		messagebox("Nessuna Operazione Eseguita", "Selezionare una riga dall'elenco.", StopSign!)
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
				k_id_meca_x = string(dw_meca.getitemnumber(k_row_meca, "id_meca"))
				k_row_delete = dw_meca.find("id_meca = " + k_id_meca_x, 1, dw_meca.rowcount(), primary!)
				do while k_row_delete > 0 
					dw_meca.selectrow(k_row_delete, false)
					dw_meca.deleterow(k_row_delete)
					k_row_delete = dw_meca.find("id_meca = " + k_id_meca_x, 1, dw_meca.rowcount(), primary!)
				loop
				k_row_meca = dw_meca.getselectedrow(0) 
			loop
				
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
	imposta_codice_progr( dw_lista_0 )

	
end try

SetPointer(kkg.pointer_default)

end subroutine

public subroutine u_aggiungi_barcode_singolo_check (ref uo_d_std_1 adw_inp) throws uo_exception;/*
   Verifica i BARCODE da aggiungere ai Pianificati se tutto OK
   	Inp: adw_inp (dw_barcode/dw_groupage)
*/
long k_riga_drag
long k_riga_meca
long k_id_meca_verified
st_tab_barcode kst_tab_barcode_padre
st_tab_meca kst_tab_meca
st_tab_asdrackbarcode kst_tab_asdrackbarcode
	

try
	kguo_exception.inizializza(this.classname())

	k_riga_drag = adw_inp.getselectedrow(0) 			
	do while k_riga_drag > 0 

//--- Controllo Lotto
		kst_tab_meca.id = 0
		kst_tab_meca.num_int = adw_inp.object.barcode_num_int[k_riga_drag]   
		if kst_tab_meca.num_int > 0 then
			k_riga_meca = dw_meca.find( "meca_num_int = " + string(kst_tab_meca.num_int), 1, dw_meca.rowcount() )
			if k_riga_meca > 0 then
				kst_tab_meca.id = dw_meca.object.id_meca[k_riga_meca]
				kst_tab_meca.data_int = dw_meca.object.meca_data_int[k_riga_meca] 
	
				if kst_tab_meca.id <> k_id_meca_verified then
					k_id_meca_verified = kst_tab_meca.id
					
					if u_stop_if_lotto_non_associato(kst_tab_meca) then  //--- Blocca elaborazione per Lotto non Associato
						return
					end if
		
					if u_stop_if_lotto_in_attenzione(k_riga_meca) then // Controllo se Riferimento 'IN ATTENZIONE'
						return 
					end if
				end if
	
			end if
		end if

//--- altre verifiche
		kst_tab_barcode_padre.barcode = adw_inp.object.barcode_barcode[k_riga_drag]
				
//--- NON è possibile mettere tra i padri un FIGLIO!!!			
		if kiuf_barcode.if_barcode_figlio(kst_tab_barcode_padre) then
			kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
			kguo_exception.kist_esito.sqlerrtext = "Barcode '" + trim(kst_tab_barcode_padre.barcode) + "' già associato a un altro 'PADRE' '" + kst_tab_barcode_padre.barcode_lav + "' per il Trattamento. Operazione non consentita."
			kguo_exception.messaggio_utente( )
			adw_inp.selectrow(k_riga_drag, false)
			continue
		end if
		
//--- Il barcode è stato associato al RACK insieme a tutti gli altri del Lotto? (se necessario)
		kst_tab_asdrackbarcode.barcode = kst_tab_barcode_padre.barcode
		if not kiuf_asdrackbarcode.if_barcode_is_associated(kst_tab_asdrackbarcode) then
			kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
			kguo_exception.kist_esito.sqlerrtext = "Prima di aggiungere il barcode '" + trim(kst_tab_barcode_padre.barcode) + "' schermarlo. Operazione non consentita." //~n~r"
			throw kguo_exception
		end if
		
		kst_tab_asdrackbarcode.barcode = kst_tab_barcode_padre.barcode
		if not kiuf_asdrackbarcode.if_barcode_only_existing_father(kst_tab_asdrackbarcode) then
			kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
			kguo_exception.kist_esito.sqlerrtext = "Attenzione ci sono più barcode 'PADRI' come il '" + trim(kst_tab_asdrackbarcode.barcode) + "' associati a questa schermatura (id " &
								+ string(kst_tab_asdrackbarcode.id_asdrackcode) + "). E' consentito un solo barcode 'PADRE' gli altri devono essere spostati in groupage." &
								+ kkg.acapo + "Operazione non consentita." 
			throw kguo_exception
		end if
			
//--- leggo la successiva!
		k_riga_drag = adw_inp.getselectedrow(k_riga_drag)
	loop

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally

end try 



end subroutine

private function long u_aggiungi_barcode_tutti_1 (long a_row, ref uo_d_std_1 adw_out);//
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


SetPointer(kkg.pointer_attesa)

try 
	kst_esito = kguo_exception.inizializza(this.classname())

	kst_tab_meca.id = dw_meca.getitemnumber(a_row, "id_meca")
	kst_tab_meca.num_int = dw_meca.getitemnumber(a_row, "meca_num_int")
	kst_tab_meca.data_int = dw_meca.getitemdate(a_row, "meca_data_int")

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
						
					end if
					
				case "dw_groupage" 
					k_row_adw_out = adw_out.insertrow(k_row_adw_out + 1)
					copia_dw_barcode_to_dw_groupage(k_row_adw_out, k_riga_drag)
		
			end choose
		
		next 
		
		ki_lista_0_modifcato = true

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
	if not ki_refresh_dw_meca_needed then
		attiva_tasti()
	end if

	SetPointer(kkg.pointer_default)	
	
end try 
	
return k_row_adw_out
end function

private subroutine u_aggiungi_grp_barcode_singolo (ref uo_d_std_1 kdw_2);/*
   Aggiungi un BARCODE come figlio nella lista dei Pianificati in Groupage
   	inp: kdw_2 -----> dw_lista/dw_barcode
*/
long k_row, k_row_drag, k_row_last_ins
boolean k_verified, k_row_insert


try
	
	if kdw_2.rowcount() = 0 then	return 
		
	dw_groupage.setredraw(false)

	k_row = dw_groupage.getselectedrow(0) // posizione per dove inserire i barcode

	k_row_drag = kdw_2.getselectedrow(0)
	do while k_row_drag > 0 

		if not k_verified then
			if not u_aggiungi_grp_barcode_singolo_if(kdw_2, k_row_drag) then // controlli vari
				exit
			else
				k_verified = true   // se Lotto già verificato esce con ok
			end if
		end if
 
		k_row = dw_groupage.insertrow(k_row + 1)
		k_row_last_ins = k_row

//--- copia in dw_groupage la dw2 (dw_barcode/dw_lista_0) 			
		if kdw_2.dataobject = dw_lista_0.dataobject then
			copia_dw_lista_0_to_dw_groupage(k_row, k_row_drag)
		else
			copia_dw_barcode_to_dw_groupage(k_row, k_row_drag)			
		end if

		screma_lista_from_dw_groupage(k_row)  // screma dw_meca

		kdw_2.deleterow(k_row_drag) 

		k_row_drag = kdw_2.getselectedrow(k_row_drag - 1)
		
	loop

	if k_row_last_ins > 0 then
		ki_lista_0_modifcato = true
		
//--- sistema il codice e i progressivi nella lista
		imposta_codice_progr( dw_groupage )

		dw_groupage.selectrow(0, false)
		dw_groupage.setrow(k_row_last_ins)
		dw_groupage.selectrow(k_row_last_ins, true)
		dw_groupage.scrolltorow(k_row_last_ins)
	end if

	dw_groupage.setcolumn(1)
	dw_groupage.setfocus()

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally 
	dw_groupage.setredraw(true)
	
	
end try

end subroutine

private function boolean u_aggiungi_grp_barcode_singolo_if (ref uo_d_std_1 adw_2, long a_riga_dw2);/*
   Controlla BARCODE se può essere AGGIUNTO
   adw_2 -----> dw_lista/dw_barcode
	Rit: FALSE = il Barcode non può essere aggiunto
*/
long k_row_meca
st_tab_meca kst_tab_meca
st_tab_barcode kst_tab_barcode


try
	
	kguo_exception.inizializza( )
	
//--- Controllo che barcode non abbia figli
	kst_tab_barcode.barcode = adw_2.getitemstring(a_riga_dw2, "barcode_barcode")
	if kiuf_barcode.if_barcode_padre(kst_tab_barcode) then
		kguo_exception.setmessage( "ATTENZIONE", "Il Barcode " + trim(kst_tab_barcode.barcode ) + " è già asscociato come 'PADRE' non è possibile aggiungerlo come 'FIGLIO' - Operazione bloccata!")
		return false
	end if

//--- Controlli sul Lotto 
	kst_tab_meca.num_int = adw_2.getitemnumber(a_riga_dw2, "barcode_num_int")
	
	k_row_meca = dw_meca.find( "meca_num_int = " + string(kst_tab_meca.num_int), 1, dw_meca.rowcount() )
	if k_row_meca > 0 then 

		kst_tab_meca.id = dw_meca.getitemnumber(k_row_meca, "id_meca")
		kst_tab_meca.num_int = dw_meca.getitemnumber(k_row_meca, "meca_num_int") 
		kst_tab_meca.data_int = dw_meca.getitemdate(k_row_meca, "meca_data_int") 
		if u_stop_if_lotto_non_associato(kst_tab_meca) then // Ferma associazioni x Lotto non Associato
			return FALSE
		end if
			
		if u_stop_if_lotto_in_attenzione(k_row_meca) then // Controllo se Riferimento 'IN ATTENZIONE'
			return false
		end if

	end if

	return true

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

end function

public subroutine u_aggiungi_grp_rif_intero (ref uo_d_std_1 kdw_1);//
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
			
			if u_stop_if_lotto_non_associato(kst_tab_meca) then  //--- Blocca elaborazione per Lotto non Associato
				exit
			end if

			if u_stop_if_lotto_in_attenzione(k_riga_meca) then // Controllo se Riferimento 'IN ATTENZIONE'
				exit 
			end if
			
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
		end try

//--- popola dw_barcode		
		u_dw_barcode_retrieve(k_riga_meca)

		if dw_barcode.rowcount() <= 0 then
			exit  //USCITA!
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

		dw_meca.deleterow(k_riga_meca) 

		k_riga_meca_old = k_riga_meca
		k_riga_meca = dw_meca.getselectedrow(k_riga_meca - 1)
	loop
	
//--- sistema il codice e i progressivi nella lista
	if k_riga_posiziona > 0 then
		
		imposta_codice_progr( kdw_1 )
	
		if k_riga_meca_old > dw_meca.rowcount() then
			k_riga_meca_old = dw_meca.rowcount()
		end if
		if k_riga_meca_old > 0 then
			dw_meca.setrow(k_riga_meca_old)
			dw_meca.selectrow(k_riga_meca_old, true)
		end if
		
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

SetPointer(kkg.pointer_default)

end subroutine

private subroutine imposta_codice_progr (ref datawindow kdw_1);//
//=== Imposta in lista barcode/groupage i progressivi del dettaglio del P.L.
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

private subroutine imposta_id_sl_pt_g3 (ref datawindow kdw_1, long a_row_to_check) throws uo_exception;/*
 Imposta in lista barcode/groupage dati di trattamento G3 (id_sl_pt_g3) 
   inp: dw, a_row_to_check = riga da trattare se ZERO = tutte
*/
long k_row, k_rows
int k_rc
string k_barcode
st_tab_sl_pt_g3_lav kst_tab_sl_pt_g3_lav
uo_ds_std_1 kds_sl_pt_g3_lav_x_barcode_dati_lav


if isvalid(kdw_1) then
						
	kds_sl_pt_g3_lav_x_barcode_dati_lav = create uo_ds_std_1
	kds_sl_pt_g3_lav_x_barcode_dati_lav.dataobject = "ds_sl_pt_g3_lav_x_barcode_dati_lav"
	kds_sl_pt_g3_lav_x_barcode_dati_lav.settransobject(kguo_sqlca_db_magazzino)
	
	if a_row_to_check > 0 then  // get dei dati di solo una riga
		k_rows = a_row_to_check
	else
		k_rows = kdw_1.rowcount() 
		a_row_to_check = 1
	end if
	
	for k_row = a_row_to_check to kdw_1.rowcount() 
		k_barcode = trim(kdw_1.getitemstring(k_row, "barcode_barcode"))
		kst_tab_sl_pt_g3_lav.g3npass = kdw_1.getitemnumber(k_row, "g3npass")
		kst_tab_sl_pt_g3_lav.ngiri = kdw_1.getitemnumber(k_row, "g3ngiri")
		kst_tab_sl_pt_g3_lav.ciclo_target = kdw_1.getitemnumber(k_row, "g3ciclo")
		
		if k_barcode > " " &
			and kst_tab_sl_pt_g3_lav.g3npass > 0 &
			and kst_tab_sl_pt_g3_lav.ngiri > 0 &
			and kst_tab_sl_pt_g3_lav.ciclo_target > 0 then
			
			k_rc = kds_sl_pt_g3_lav_x_barcode_dati_lav.retrieve(k_barcode, &
																		kst_tab_sl_pt_g3_lav.g3npass, &
																		kst_tab_sl_pt_g3_lav.ngiri, &
																		kst_tab_sl_pt_g3_lav.ciclo_target)

			if k_rc < 0 then
				kguo_exception.set_st_esito_err_ds(kds_sl_pt_g3_lav_x_barcode_dati_lav, &
							"Errore in ricerca dati dettaglio di Trattamento G3 del barcode " + string(k_barcode) + " " &
																	+ kkg.acapo + "N.Pass: " + string(kst_tab_sl_pt_g3_lav.g3npass) &
																	+ " N.Giri: " + string(kst_tab_sl_pt_g3_lav.ngiri) &
																	+ " Ciclo: " + string(kst_tab_sl_pt_g3_lav.ciclo_target) + ". ")
				throw kguo_exception
			end if
			kdw_1.setitem(k_row, "ciclo_min", kds_sl_pt_g3_lav_x_barcode_dati_lav.getitemnumber(1, "ciclo_min"))
			kdw_1.setitem(k_row, "ciclo_max", kds_sl_pt_g3_lav_x_barcode_dati_lav.getitemnumber(1, "ciclo_max"))
			kdw_1.setitem(k_row, "id_sl_pt_g3_lav", kds_sl_pt_g3_lav_x_barcode_dati_lav.getitemnumber(1, "id_sl_pt_g3_lav"))
		end if
	next

end if
end subroutine

private subroutine copia_dw_barcode_to_dw_groupage (integer k_row1, integer k_row2) throws uo_exception;//--- copia dalla dw_barcode in dw del groupage 
//--- parametri: riga1 riga della dw1
//---            riga2 riga della dw2
//---
int k_rcn
string k_lav
st_tab_barcode kst_tab_barcode
st_esito kst_esito
	
	
	try 
		kguo_exception.inizializza( this.classname())
		
		if dw_barcode.getitemnumber(k_row2, "ngiri") > 0 then
		else
			kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_dati_insufficienti
			kguo_exception.kist_esito.sqlerrtext = "Operazione non consentita il barcode non ha il numero giri G3 indicati." 
			throw kguo_exception
		end if
			
		kst_tab_barcode.barcode = dw_barcode.getitemstring(k_row2, "barcode_barcode")
		if not kiuf_barcode.get_padre(kst_tab_barcode) then
			kst_tab_barcode.barcode_lav = " "
		end if
		if kiuf_barcode.if_barcode_padre(kst_tab_barcode) then
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlcode = 0
			kst_esito.sqlerrtext = "Il barcode " + kst_tab_barcode.barcode + " utilizzato come figlio risulta già 'padre'. Operazione non consentita!"
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	
		dw_groupage.setitem(k_row1, "barcode_lav",  kst_tab_barcode.barcode_lav)
		dw_groupage.setitem(k_row1, "barcode_barcode",  dw_barcode.getitemstring(k_row2, "barcode_barcode"))
		
		dw_groupage.setitem(k_row1, "g3npass", dw_barcode.getitemnumber(k_row2, "g3npass"))
		dw_groupage.setitem(k_row1, "g3ngiri", dw_barcode.getitemnumber(k_row2, "ngiri")) 
		dw_groupage.setitem(k_row1, "g3ciclo", dw_guida.getitemnumber(1, "g3ciclo"))
		dw_groupage.setitem(k_row1, "ciclo_min", dw_barcode.getitemnumber(k_row2, "ciclo_min")) 
		dw_groupage.setitem(k_row1, "ciclo_max", dw_barcode.getitemnumber(k_row2, "ciclo_max"))
		dw_groupage.setitem(k_row1, "id_sl_pt_g3_lav", dw_barcode.getitemnumber(k_row2, "id_sl_pt_g3_lav"))

		dw_groupage.setitem(k_row1, "barcode_num_int", &
					 dw_barcode.getitemnumber(k_row2, "barcode_num_int"))
		dw_groupage.setitem(k_row1, "barcode_data_int", &
					 dw_barcode.getitemdate(k_row2, "barcode_data_int"))
		dw_groupage.setitem(k_row1, "dose", &
					 dw_barcode.getitemnumber(k_row2, "armo_dose"))
		dw_groupage.setitem(k_row1, "peso_kg", &
					 dw_barcode.getitemnumber(k_row2, "armo_peso_kg"))
		dw_groupage.setitem(k_row1, "larg_2", &
					 dw_barcode.getitemnumber(k_row2, "armo_larg_2"))
		dw_groupage.setitem(k_row1, "lung_2", &
					 dw_barcode.getitemnumber(k_row2, "armo_lung_2"))
		dw_groupage.setitem(k_row1, "alt_2", &
					 dw_barcode.getitemnumber(k_row2, "armo_alt_2"))
		dw_groupage.setitem(k_row1, "pedane", &
					 dw_barcode.getitemnumber(k_row2, "armo_pedane"))
		dw_groupage.setitem(k_row1, "campione", &
					 dw_barcode.getitemstring(k_row2, "armo_campione"))
		dw_groupage.setitem(k_row1, "art", &
					 dw_barcode.getitemstring(k_row2, "armo_art"))
		dw_groupage.setitem(k_row1, "area_mag", &
					 dw_barcode.getitemstring(k_row2, "meca_area_mag"))
		dw_groupage.setitem(k_row1, "id_armo", &
					 dw_barcode.getitemnumber(k_row2, "armo_id_armo"))
		dw_groupage.setitem(k_row1, "id_meca", &
					 dw_barcode.getitemnumber(k_row2, "id_meca"))
		dw_groupage.setitem(k_row1, "e1ancodrs", &
					 dw_barcode.getitemstring(k_row2, "e1ancodrs"))
		dw_groupage.setitem(k_row1, "k_densita", &
					 dw_barcode.getitemnumber(k_row2, "k_densita"))
		dw_groupage.setitem(k_row1, "id_asdrackcode", &
					 dw_barcode.getitemnumber(k_row2, "id_asdrackcode"))

		imposta_id_sl_pt_g3(dw_groupage, k_row1) // Imposta dati di trattamento sul Figlio
		
	catch (uo_exception kuo_exception)
		kuo_exception.scrivi_log()
		throw kuo_exception
		
	finally 
		
	end try

end subroutine

private subroutine copia_dw_barcode_to_dw_lista_0 (integer k_row1, integer k_row2);//---
//--- copia dati dal DW di dettaglio (dw_bacode) al dw di lavoro (dw_lista_0) 
//--- parametri:
//---            riga1 riga della dw_lista
//---            riga2 riga della dw_barcode
//---
int k_rc	
	
		dw_lista_0.setitem(k_row1, "barcode_barcode", dw_barcode.getitemstring(k_row2, "barcode_barcode"))
		
		k_rc = dw_lista_0.setitem(k_row1, "g3npass", dw_barcode.getitemnumber(k_row2, "g3npass"))
		dw_lista_0.setitem(k_row1, "g3ngiri", dw_barcode.getitemnumber(k_row2, "ngiri"))
		
		if dw_guida.getitemnumber(1, "g3ciclo") > 0 then
			dw_lista_0.setitem(k_row1, "g3ciclo", dw_guida.getitemnumber(1, "g3ciclo"))
		else
			dw_lista_0.setitem(k_row1, "g3ciclo", ki_g3ciclo_alt)
		end if
		dw_lista_0.setitem(k_row1, "id_sl_pt_g3_lav", dw_barcode.getitemnumber(k_row2, "id_sl_pt_g3_lav"))
		dw_lista_0.setitem(k_row1, "ciclo_min", dw_barcode.getitemnumber(k_row2, "ciclo_min"))
		dw_lista_0.setitem(k_row1, "ciclo_max", dw_barcode.getitemnumber(k_row2, "ciclo_max"))
					 
		dw_lista_0.setitem(k_row1, "barcode_num_int", &
					 dw_barcode.getitemnumber(k_row2, "barcode_num_int"))
		dw_lista_0.setitem(k_row1, "barcode_data_int", &
					 dw_barcode.getitemdate(k_row2, "barcode_data_int"))
		dw_lista_0.setitem(k_row1, "dose", &
					 dw_barcode.getitemnumber(k_row2, "armo_dose"))
		dw_lista_0.setitem(k_row1, "peso_kg", &
					 dw_barcode.getitemnumber(k_row2, "armo_peso_kg"))
		dw_lista_0.setitem(k_row1, "larg_2", &
					 dw_barcode.getitemnumber(k_row2, "armo_larg_2"))
		dw_lista_0.setitem(k_row1, "lung_2", &
					 dw_barcode.getitemnumber(k_row2, "armo_lung_2"))
		dw_lista_0.setitem(k_row1, "alt_2", &
					 dw_barcode.getitemnumber(k_row2, "armo_alt_2"))
		dw_lista_0.setitem(k_row1, "pedane", &
					 dw_barcode.getitemnumber(k_row2, "armo_pedane"))
		dw_lista_0.setitem(k_row1, "campione", &
					 dw_barcode.getitemstring(k_row2, "armo_campione"))
		dw_lista_0.setitem(k_row1, "art", &
					 dw_barcode.getitemstring(k_row2, "armo_art"))
		dw_lista_0.setitem(k_row1, "area_mag", &
					 dw_barcode.getitemstring(k_row2, "meca_area_mag"))
		dw_lista_0.setitem(k_row1, "id_armo", &
					 dw_barcode.getitemnumber(k_row2, "armo_id_armo"))
		dw_lista_0.setitem(k_row1, "id_meca", &
					 dw_barcode.getitemnumber(k_row2, "id_meca"))
		dw_lista_0.setitem(k_row1, "e1ancodrs", &
					 dw_barcode.getitemstring(k_row2, "e1ancodrs"))
		dw_lista_0.setitem(k_row1, "k_densita", &
					 dw_barcode.getitemnumber(k_row2, "k_densita"))
		dw_lista_0.setitem(k_row1, "id_asdrackcode", &
					 dw_barcode.getitemnumber(k_row2, "id_asdrackcode"))

end subroutine

private subroutine copia_dw_lista_0_to_dw_groupage (integer k_row1, integer k_row2) throws uo_exception;//---
//--- copia dalla dw_lista in dw del groupage 
//--- parametri: 
//---            riga1 riga della dw1
//---            riga2 riga della dw2
//---
	
		dw_groupage.setitem(k_row1, "barcode_barcode",  dw_lista_0.getitemstring(k_row2, "barcode_barcode"))
		
		dw_groupage.setitem(k_row1, "g3npass", dw_lista_0.getitemnumber(k_row2, "g3npass"))
		dw_groupage.setitem(k_row1, "g3ngiri", dw_lista_0.getitemnumber(k_row2, "g3ngiri"))
		dw_groupage.setitem(k_row1, "g3ciclo", dw_lista_0.getitemnumber(k_row2, "g3ciclo"))
		dw_groupage.setitem(k_row1, "id_sl_pt_g3_lav", dw_lista_0.getitemnumber(k_row2, "id_sl_pt_g3_lav"))
		dw_groupage.setitem(k_row1, "ciclo_min", dw_lista_0.getitemnumber(k_row2, "ciclo_min"))
		dw_groupage.setitem(k_row1, "ciclo_max", dw_lista_0.getitemnumber(k_row2, "ciclo_max"))
		
		dw_groupage.setitem(k_row1, "barcode_num_int", &
					 dw_lista_0.getitemnumber(k_row2, "barcode_num_int"))
		dw_groupage.setitem(k_row1, "barcode_data_int", &
					 dw_lista_0.getitemdate(k_row2, "barcode_data_int"))
		dw_groupage.setitem(k_row1, "dose", dw_lista_0.getitemnumber(k_row2, "dose"))
		dw_groupage.setitem(k_row1, "peso_kg", &
					 dw_lista_0.getitemnumber(k_row2, "peso_kg"))
		dw_groupage.setitem(k_row1, "larg_2", &
					 dw_lista_0.getitemnumber(k_row2, "larg_2"))
		dw_groupage.setitem(k_row1, "lung_2", &
					 dw_lista_0.getitemnumber(k_row2, "lung_2"))
		dw_groupage.setitem(k_row1, "alt_2", &
					 dw_lista_0.getitemnumber(k_row2, "alt_2"))
		dw_groupage.setitem(k_row1, "pedane", &
					 dw_lista_0.getitemnumber(k_row2, "pedane"))
		dw_groupage.setitem(k_row1, "campione", &
					 dw_lista_0.getitemstring(k_row2, "campione"))
		dw_groupage.setitem(k_row1, "art", &
					 dw_lista_0.getitemstring(k_row2, "art"))
		dw_groupage.setitem(k_row1, "area_mag", &
					 dw_lista_0.getitemstring(k_row2, "area_mag"))
		dw_groupage.setitem(k_row1, "id_armo", &
					 dw_lista_0.getitemnumber(k_row2, "id_armo"))
		dw_groupage.setitem(k_row1, "id_meca", &
					 dw_lista_0.getitemnumber(k_row2, "id_meca"))

		dw_groupage.setitem(k_row1, "e1ancodrs", &
					 dw_lista_0.getitemstring(k_row2, "e1ancodrs"))
					 
		dw_groupage.setitem(k_row1, "k_densita", &
					 dw_lista_0.getitemnumber(k_row2, "k_densita"))
		dw_groupage.setitem(k_row1, "id_asdrackcode", &
					 dw_lista_0.getitemnumber(k_row2, "id_asdrackcode"))

		imposta_id_sl_pt_g3(dw_groupage, k_row1) // Imposta dati di trattamento sul Figlio
		

end subroutine

on w_pl_barcode_dett_g3.create
int iCurrent
call super::create
this.dw_meca=create dw_meca
this.dw_barcode=create dw_barcode
this.dw_groupage=create dw_groupage
this.dw_periodo=create dw_periodo
this.cb_aggiungi=create cb_aggiungi
this.cb_chiudi=create cb_chiudi
this.dw_pilota_inlav=create dw_pilota_inlav
this.cb_togli=create cb_togli
this.dw_g3ciclo_alt=create dw_g3ciclo_alt
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_meca
this.Control[iCurrent+2]=this.dw_barcode
this.Control[iCurrent+3]=this.dw_groupage
this.Control[iCurrent+4]=this.dw_periodo
this.Control[iCurrent+5]=this.cb_aggiungi
this.Control[iCurrent+6]=this.cb_chiudi
this.Control[iCurrent+7]=this.dw_pilota_inlav
this.Control[iCurrent+8]=this.cb_togli
this.Control[iCurrent+9]=this.dw_g3ciclo_alt
end on

on w_pl_barcode_dett_g3.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_meca)
destroy(this.dw_barcode)
destroy(this.dw_groupage)
destroy(this.dw_periodo)
destroy(this.cb_aggiungi)
destroy(this.cb_chiudi)
destroy(this.dw_pilota_inlav)
destroy(this.cb_togli)
destroy(this.dw_g3ciclo_alt)
end on

event closequery;call super::closequery;//
if ki_exit_si then
	dw_dett_0.visible = false
end if

end event

event close;call super::close;//
int k_rc

//--- registra la data piu' indietro su BASE cosi' da recuperarla al pross. giro 
//set_base_data_ini()

//dw_pilota_inlav.event u_hide( )

u_crash_reset( )  // pulisce il backup di ripri

k_rc=kGuf_data_base.dw_salva_righe("v.1", dw_guida, "dwguida")

//if isvalid(kids_meca_orig) then destroy kids_meca_orig
if isvalid(kiuf_pl_barcode) then destroy kiuf_pl_barcode								
if isvalid(kiuf_armo) then destroy kiuf_armo								
if isvalid(kiuf_e1_asn) then destroy kiuf_e1_asn
if isvalid(kiuf_asdrackbarcode) then destroy kiuf_asdrackbarcode
if isvalid(kiuf_barcode) then destroy kiuf_barcode
if isvalid(kiuf_barcode_asd) then destroy kiuf_barcode_asd
if isvalid(kiuf_clienti) then destroy kiuf_clienti
if isvalid(kiuf_prodotti) then destroy kiuf_prodotti
if isvalid(kiuf_sl_pt) then destroy kiuf_sl_pt
if isvalid(kids_sl_pt_g3_lav_if_datilav_ok) then destroy kids_sl_pt_g3_lav_if_datilav_ok
if isvalid(kiuf_pilota_previsioni_g3) then destroy kiuf_pilota_previsioni_g3
if isvalid(kiuf_prodotti) then destroy kiuf_prodotti
if isvalid(kiuf_sl_pt) then destroy kiuf_sl_pt
if isvalid(kids_storico_mastertimer_tempo_last) then destroy kids_storico_mastertimer_tempo_last
if isvalid(kids_pilota_queue_g3_last_in) then destroy kids_pilota_queue_g3_last_in

end event

event rbuttondown;call super::rbuttondown;//
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
int k_return
int k_rc
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_barcode kst_tab_barcode
uo_d_std_1 kuo_d_std_1 



if isvalid(kst_open_w) then

//--- vale solo se sono in aggiornamento	
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then

//--- Dalla finestra di Elenco Valori
		if kst_open_w.id_programma = kkg_id_programma_elenco and long(kst_open_w.key3) > 0 then	

			if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore
	
//--- Se dalla w di elenco doppio-click		
			choose case kst_open_w.key2
					
				case "d_pilota_queue_g3" 
			
					kdsi_elenco_input = kst_open_w.key12_any 
				
					if kdsi_elenco_input.rowcount() > 0 then
						k_return = 1
				
						kst_tab_pl_barcode.prima_del_barcode = trim( kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "barcode") )
		
						if Len(trim(kst_tab_pl_barcode.prima_del_barcode)) > 0 then
							
//--- imposta il dato selezionato in elenco nel campo
							dw_dett_0.setitem(dw_dett_0.getrow(), "prima_del_barcode", kst_tab_pl_barcode.prima_del_barcode) 
							dw_dett_0.setitem(dw_dett_0.getrow(), "priorita", kiuf_pl_barcode.k_priorita_prima_del_barcode) 
							
						end if					
						
					end if

//--- scelto Padre potenziale
				case  "d_barcode_g3_padri_potenziali" 
					kdsi_elenco_input = kst_open_w.key12_any 
					if kdsi_elenco_input.rowcount() > 0 then
						k_return = 1
						kst_tab_barcode.barcode = kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "barcode")
						u_aggiungi_barcode_padre(kst_tab_barcode)
					end if


				case "d_pl_barcode_dett_g3"
					kdsi_elenco_input = kst_open_w.key12_any 
					if kdsi_elenco_input.rowcount() > 0 then
						k_return = 1
						kst_tab_barcode.barcode = kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "barcode_barcode")
						u_aggiungi_barcode_padre(kst_tab_barcode)
					end if

			end choose
			
		else
		
//--- da Modifica Giri					
			choose case kst_open_w.key2

				case "d_armo_sl_pt_g3_lav_modif"
					kuo_d_std_1 = create uo_dw_armo_sl_pt_g3_lav_modifica
					kuo_d_std_1 = kst_open_w.key12_any 
					if kuo_d_std_1 .rowcount() > 0 then
						if dw_meca.getselectedrow(0) > 0 then
							k_return = 1
							if kuo_d_std_1.getitemnumber(1, "id_armo_sl_pt_g3_lav") > 0 then
								dw_meca.setitem(dw_meca.getselectedrow(0), "ngiri", kuo_d_std_1.getitemnumber(1, "ngiri"))
								dw_meca.setitem(dw_meca.getselectedrow(0), "ciclo_target", kuo_d_std_1.getitemnumber(1, "ciclo_target"))
								dw_meca.setitem(dw_meca.getselectedrow(0), "ciclo_min", kuo_d_std_1.getitemnumber(1, "ciclo_target"))
								dw_meca.setitem(dw_meca.getselectedrow(0), "ciclo_max", kuo_d_std_1.getitemnumber(1, "ciclo_target"))
							else
								dw_meca.setitem(dw_meca.getselectedrow(0), "ngiri", kuo_d_std_1.getitemnumber(1, "sl_pt_g3_lav_ngiri"))
								dw_meca.setitem(dw_meca.getselectedrow(0), "ciclo_target", kuo_d_std_1.getitemnumber(1, "sl_pt_g3_lav_ciclo_target"))
								dw_meca.setitem(dw_meca.getselectedrow(0), "ciclo_min", kuo_d_std_1.getitemnumber(1, "sl_pt_g3_lav_ciclo_min"))
								dw_meca.setitem(dw_meca.getselectedrow(0), "ciclo_max", kuo_d_std_1.getitemnumber(1, "sl_pt_g3_lav_ciclo_max"))
							end if
						end if
					end if
					//destroy kuo_d_std_1
			end choose
		end if
	end if

end if

attiva_tasti()

return k_return

end event

type dw_print_0 from w_g_tab0`dw_print_0 within w_pl_barcode_dett_g3
end type

type st_ritorna from w_g_tab0`st_ritorna within w_pl_barcode_dett_g3
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_pl_barcode_dett_g3
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_pl_barcode_dett_g3
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_pl_barcode_dett_g3
end type

type st_stampa from w_g_tab0`st_stampa within w_pl_barcode_dett_g3
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_pl_barcode_dett_g3
end type

type cb_modifica from w_g_tab0`cb_modifica within w_pl_barcode_dett_g3
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_pl_barcode_dett_g3
end type

type cb_cancella from w_g_tab0`cb_cancella within w_pl_barcode_dett_g3
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_pl_barcode_dett_g3
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_pl_barcode_dett_g3
integer x = 910
integer y = 1296
integer width = 3099
integer height = 956
boolean enabled = true
boolean titlebar = true
string title = "G3: Proprietà Piano di Lavorazione"
string dataobject = "d_pl_barcode_testa_g3"
boolean controlmenu = true
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_select_multirows = false
end type

event dw_dett_0::getfocus;//
//--- evitare lo script standard
//
kidw_selezionata = this
//ki_dw_focus_dataobject = this.dataobject
attiva_tasti( ) 
 
end event

event dw_dett_0::losefocus;//

end event

event dw_dett_0::clicked;call super::clicked;//

end event

event dw_dett_0::buttonclicked;call super::buttonclicked;//

kidw_selezionata.icon = ki_icona_normale  // toglie l'icona alla precedente dw che sta perdendo il fluoco
kidw_selezionata = this
kidw_selezionata.icon = ki_icona_selezionata  // mette l'conda di dw selezionata

try
		
	choose case dwo.name

//		case "b_file_pilota"  // qui aprire la richiesta
//			open_notepad_documento()

		case "b_queue_pilota"  // ripristinare quando sappiamo le tabelle PILOTA G3
			open_elenco_pilota_coda()
			
		case "b_chiudi"
			cb_chiudi.event clicked( ) 
			this.visible = false

	end choose

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try

	
end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_pl_barcode_dett_g3
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_pl_barcode_dett_g3
integer x = 1157
integer y = 216
boolean titlebar = true
string title = "Pianificazione irraggiamento G3 - Trascina qui il Riferimento o Barcode."
string dataobject = "d_pl_barcode_dett_g3"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
borderstyle borderstyle = stylebox!
boolean ki_d_std_1_attiva_sort = false
boolean ki_attiva_dragdrop = true
boolean ki_attiva_dragdrop_self = true
end type

event dw_lista_0::ue_dropfromthis;call super::ue_dropfromthis;//
//--- dopo l'evento PARENT, sistema il codice e i progressivi nella lista
		imposta_codice_progr( kdw_source )

return 1

end event

event dw_lista_0::buttonclicked;call super::buttonclicked;//
kidw_selezionata.icon = ki_icona_normale  // toglie l'icona alla precedente dw che sta perdendo il fluoco
kidw_selezionata = this
kidw_selezionata.icon = ki_icona_selezionata  // mette l'conda di dw selezionata

//if dwo.name = "b_previsioni" then
//	
//	this.Object.b_previsioni.Enabled='No'
//	dw_prev.event u_run( )
//	this.Object.b_previsioni.Enabled='Yes'
//	
//else
	if dwo.name = "b_stato_impianto" then
		
		this.Object.b_stato_impianto.Enabled='No'
		dw_pilota_inlav.event u_run( )
		this.Object.b_stato_impianto.Enabled='Yes'
		
	end if	
//end if
end event

event dw_lista_0::clicked;call super::clicked;//
if dwo.name = "barcode_pl_barcode_progr_t" THEN
	
	u_sort(dwo.name)   // Esegue il SORT
	
end if


end event

event dw_lista_0::getfocus;//
kidw_selezionata = this
u_set_dw_icon( )

end event

event dw_lista_0::losefocus;//

end event

event dw_lista_0::doubleclicked;//
if this.rowcount() < 2 then
	beep(1)
else
	call_window_barcode()
end if


end event

event dw_lista_0::ue_drop_out;call super::ue_drop_out;//
string k_nome



if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then

	if isvalid(kdw_source) then
		if dw_guida.getitemnumber(1, "g3ciclo") > 0 then
			
			u_aggiungi_a_dw_lista(kdw_source.classname())
			
			//kdw_source.setfocus()
	
		else

//--- se CICLO non indicato in testata lo chiede 'al volo'
			ki_dw_source_name = kdw_source.classname()
			dw_g3ciclo_alt.setfocus( )
				
		end if
	end if
						
end if
		
return 1

end event

type dw_guida from w_g_tab0`dw_guida within w_pl_barcode_dett_g3
event u_enabled_if ( )
event u_resize ( )
event u_inizializza ( )
integer x = 0
integer y = 0
integer width = 3945
integer height = 180
boolean enabled = true
string dataobject = "d_pl_barcode_g3lav"
end type

event dw_guida::u_enabled_if();//
// --- Visualizza questa DW se necessario

//if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then

	this.x = 0
	this.y = 0	

	this.visible = true
	this.height = 212
	if this.rowcount() > 0 then
	else
		this.insertrow(0)
	end if
	
//else
	
//	this.visible = false
//	this.height = 0

///end if


end event

event dw_guida::u_resize();////
//long k_b_view_default_width 
//long k_newwidth, k_objectToRight
//
//
//k_b_view_default_width = long(this.describe("b_view_default.width"))
//k_newwidth = this.width //PixelsToUnits(this.width, XPixelsToUnits!)
//k_objectToRight = long(this.describe("storico_mastertimer_data_evento.x")) + long(this.describe("storico_mastertimer_data_evento.width"))
//
//if (k_newwidth) > (k_objectToRight + (k_b_view_default_width * 1.2)) then
//	this.modify("b_view_default.x = " + string((k_newwidth - (k_b_view_default_width * 1.2) )))
//	this.modify("b_view_default.visible = '1'")
//else
//	this.modify("b_view_default.visible = '0'")
//end if
end event

event dw_guida::u_inizializza();//
int k_rc
datetime k_datetime_bck
datawindow kdw_this


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

	if this.rowcount( ) = 0 then
		
		kdw_this = this
		k_rc = kguf_data_base.dw_ripri_righe( "v.1", "dwguida", kdw_this, k_datetime_bck)
		if k_rc > 0 then 
		else
			this.insertrow(0)
		end if
	
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
			
			if not isvalid(kids_pilota_queue_g3_last_in) then kids_pilota_queue_g3_last_in = create ds_pilota_queue_g3_last_in
		
//--- estrazione dal PILOTA ultimi dati inviate del N-PASS e CICLO per riproporli  
			if kids_pilota_queue_g3_last_in.retrieve( ) > 0 then
				
				this.setitem(1, "g3npass", kids_pilota_queue_g3_last_in.u_get_npass(1))
				this.setitem(1, "g3ciclo", kids_pilota_queue_g3_last_in.u_get_ciclo(1))
				
			end if
		end if		
	end if

		
//--- estrazione dal PILOTA dei dati in tempo reale del CICLO
	if kids_storico_mastertimer_tempo_last.retrieve( ) > 0 then
		this.setitem(1, "storico_mastertimer_tempo", kids_storico_mastertimer_tempo_last.getitemnumber(1, "tempo"))	
		this.setitem(1, "storico_mastertimer_data_evento", kids_storico_mastertimer_tempo_last.getitemdatetime(1, "data_evento"))	
	else
		this.setitem(1, "storico_mastertimer_tempo", 0)	
		this.setitem(1, "storico_mastertimer_data_evento", kguo_g.get_datetime_zero( ) )	
	end if

	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente("Dati dal Pilota G3")
	
finally
	SetPointer(kkg.pointer_default)

end try
	

end event

event dw_guida::getfocus;//
this.describe( "g3npass.protect = '0'")

//-- NPASS impostabile solo se non c'è nulla nei Pianificati e sono in aggiornamento
if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
	if dw_lista_0.rowcount( ) > 0 then
		this.describe( "g3npass.protect = '1'")
	end if
end if

end event

event dw_guida::ue_buttonclicked;call super::ue_buttonclicked;//
//string k_rcx
//
//k_rcx = this.describe("b_ok.enabled" )
//k_rcx = "~"" + Right(k_rcx, Len(k_rcx) - Pos(k_rcx, "~t")) // Get the expression following the tab (~t)   
//
//if this.describe("Evaluate(" + k_rcx + ", 1)" ) = "1" then
//	leggi_liste( )
//end if
//
this.post accepttext( )
leggi_liste( )
	

end event

event dw_guida::buttonclicked;//
this.accepttext( )

if dwo.name = "b_view_default" then
	smista_funz(KKG_FLAG_RICHIESTA.VISUALIZZ_PREDEFINITA)
else
	event ue_buttonclicked(dwo.name)	// ok!
end if
end event

event dw_guida::resize;call super::resize;//
this.width = parent.width

this.event post u_resize()
end event

event dw_guida::constructor;call super::constructor;move(0, 0)

end event

event dw_guida::clicked;call super::clicked;/*
  filtrocicli = 1 Attivo range 
  filtrocicli = 2 range non attivo 
*/
string k_name

k_name = dwo.name
choose case k_name
	case "kfrangeoff" &
			,"kfrangeon" 
		choose case getitemnumber(row, "filtrocicli")	
			case 2, 0 
				this.setitem(row, "filtrocicli", 1)
			case else
				this.setitem(row, "filtrocicli", 0)
		end choose
	case "kftuttooff" &
	      ,"kftuttoon"
		choose case getitemnumber(row, "filtrocicli")	
			case 1, 0 
				this.setitem(row, "filtrocicli", 2)
			case else
				this.setitem(row, "filtrocicli", 0)
		end choose
end choose

	
end event

event dw_guida::itemchanged;//
if dwo.name = "ciclo_min"  then
	if trim(data) > " " then
		if isnumber(trim(data)) then
			if this.getitemnumber(row, "ciclo_max") > 0 then
			else
				this.setitem(row, "ciclo_max", long(trim(data)))
//				this.post setcolumn("ciclo_max")
//				this.post SelectText(0, Len(String(this.GetItemNumber(row, "ciclo_max"))))
			end if
		end if
	end if
end if

end event

event dw_guida::itemfocuschanged;//
end event

event dw_guida::losefocus;//

end event

type st_duplica from w_g_tab0`st_duplica within w_pl_barcode_dett_g3
end type

type dw_meca from uo_d_std_1 within w_pl_barcode_dett_g3
event u_selectrow_false ( long a_row,  string a_fila )
event u_selectrow_false_all ( string a_fila )
event u_selectrow_true ( long a_row,  string a_fila )
event u_restore_k_choose ( ref datastore kds_meca_kchoose,  string a_fila )
event ue_set_pos_evidenzia_area_mag ( )
event ue_pbmlbuttonup pbm_lbuttonup
integer y = 236
integer width = 2103
integer height = 1808
integer taborder = 10
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Elenco Riferimenti non Pianificati"
string dataobject = "d_pl_barcode_meca_no_lav_g3_l"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
borderstyle borderstyle = stylebox!
boolean ki_link_standard_sempre_possibile = true
boolean ki_attiva_dragdrop_solo_ins_mod = false
boolean ki_attiva_dragdrop = true
end type

event u_selectrow_false(long a_row, string a_fila);//
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
long k_width_img, k_width_col 
long k_x_img

	
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

event buttonclicked;call super::buttonclicked;			
if left(trim(dwo.name), 15) = "k_choose_clear_" then
	event u_selectrow_false_all(right(dwo.name, 16))
end if

end event

event clicked;//
//--- scompare la dw_modifica se perdo il fuoco
//
long k_riga= 0
string k_rcx


//   ki_dw_fuoco_nome = this.dataobject
//	dw_modifica.visible = false

	choose case	dwo.name 
		case "grp" 
			k_riga = this.u_selectrow_onclick(row)
			if k_riga > 0 then this.setrow(k_riga)
			
//			post call_elenco_grp()
			
		case "meca_consegna_dataora"	
			// nulla
			
		case "k_choose_t"
			super::event clicked( xpos, ypos, row, dwo)
			
		case "k_choose_clear_1" &
			  ,"k_choose_clear_2" &
			  ,"k_choose_clear_g3"
			//vedi buttonclicked event u_selectrow_false_all( )
			
		case else
			super::event clicked( xpos, ypos, row, dwo)
		
	end choose
	
	
end event

event getfocus;//
kidw_selezionata.icon = ki_icona_normale  // toglie l'icona alla precedente dw che sta perdendo il fluoco
kidw_selezionata = this
kidw_selezionata.icon = ki_icona_selezionata  // mette l'conda di dw selezionata

dw_barcode.SelectRow(0, FALSE)

u_set_dw_icon( )
 
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
				this.post event u_selectrow_true(row, mid(trim(dwo.name), 10, 1))
				if dwo.name = "k_choose_1" then
					this.post event u_selectrow_false(row, "2")
				else
					this.post event u_selectrow_false(row, "1")
				end if
			end if

end choose
end event

event losefocus;//
this.accepttext( )
//attiva_menu( )

end event

event rowfocuschanged;//

//if ki_dragdrop = false then
if not this.ki_in_drag then
	
	super::EVENT rowfocuschanged(currentrow)

end if

end event

event ue_dwnkey;call super::ue_dwnkey;//
if key = keyF12! then
	
	smista_funz( KKG_FLAG_RICHIESTA.libero3 )  // attiva/disattiva Lotto "in Attenzione"
	
end if

end event

event u_doppio_click;//
long k_riga


//--- ripopola dw di dettaglio barcode (dw_barcode)
	u_dw_barcode_retrieve(a_row)
	this.setfocus()

end event

event ue_drop_out;call super::ue_drop_out;//
long k_riga	
	
	CHOOSE CASE kdw_source.DataObject 
		case "d_pl_barcode_dett_g3"
			togli_barcode_padre()
		case "d_pl_barcode_dett_grp_g3_all"
			k_riga = togli_barcode_figlio(true)
			togli_barcode_figlio_post(k_riga)
		case "d_barcode_g3_l"
			togli_dettaglio()
	end choose
	
	attiva_tasti()
	this.setfocus( )
	

return 1
end event

event ue_lbuttondown;call super::ue_lbuttondown;//
//ki_dw_fuoco_nome = this.dataobject
//
//if this.ki_attiva_DRAGDROP then
//	ki_dragdrop = true
//end if

end event

type dw_barcode from uo_d_std_1 within w_pl_barcode_dett_g3
integer x = 91
integer y = 1880
integer width = 1390
integer taborder = 40
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Dettaglio Riferimento"
string dataobject = "d_pl_barcode_barcode_no_pl_g3_l"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean hsplitscroll = false
borderstyle borderstyle = stylebox!
boolean ki_link_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_attiva_dragdrop = true
end type

event clicked;call super::clicked;//
//--- scompare la dw_modifica se perdo il fuoco
//
//   ki_dw_fuoco_nome = this.dataobject
 

end event

event getfocus;//
kidw_selezionata.icon = ki_icona_normale  // toglie l'icona alla precedente dw che sta perdendo il fluoco
kidw_selezionata = this
kidw_selezionata.icon = ki_icona_selezionata  // mette l'conda di dw selezionata

if this.rowcount() > 0 then
	this.title = "Dettaglio Riferimento: " + string(this.getitemnumber(1, "barcode_num_int"))
else
	this.title = "Dettaglio Riferimento " 
end if

u_set_dw_icon( )

end event

event losefocus;//
if this.rowcount() > 0 then
	this.title = "Dettaglio Riferimento: " + string(this.getitemnumber(1, "barcode_num_int"))
else
	this.title = "Dettaglio Riferimento " 
end if

end event

event rowfocuschanged;//

//if ki_dragdrop = false then
if not this.ki_in_drag then
	super::EVENT rowfocuschanged(currentrow)
end if

end event

event u_doppio_click;//
if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then

	u_aggiungi_barcode_singolo(dw_lista_0, dw_barcode)

end if



end event

event ue_drop_out;call super::ue_drop_out;//
long k_riga


		if kdw_source.DataObject = "d_pl_barcode_dett_g3" then
			togli_barcode_padre()
		elseif kdw_source.DataObject = "d_pl_barcode_dett_grp_g3_all" then
			k_riga=togli_barcode_figlio(true)
			togli_barcode_figlio_post(k_riga)
		elseif kdw_source.DataObject = "d_pl_barcode_meca_no_lav_g3_l" then
			k_riga = kdw_source.getselectedrow(0)
//--- ripopola dw di dettaglio barcode (dw_barcode)
			u_dw_barcode_retrieve(k_riga)
		end if

		attiva_tasti()
		if isvalid(kdw_source) then
			kdw_source.setfocus()
		end if
			
return 1
end event

event ue_lbuttondown;call super::ue_lbuttondown;//
//ki_dw_fuoco_nome = this.dataobject
//
//if this.ki_attiva_DRAGDROP then
//	ki_dragdrop = true
//end if

end event

type dw_groupage from uo_d_std_1 within w_pl_barcode_dett_g3
integer x = 1632
integer y = 1908
integer width = 1312
integer height = 832
integer taborder = 60
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Groupage trascina il barcode per identificarlo come Figlio"
string dataobject = "d_pl_barcode_dett_grp_g3_all"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean hsplitscroll = false
borderstyle borderstyle = stylebox!
boolean ki_d_std_1_attiva_sort = false
boolean ki_attiva_dragdrop = true
boolean ki_attiva_dragdrop_self = true
end type

event clicked;call super::clicked;//
	kidw_selezionata.icon = ki_icona_normale  // toglie l'icona alla precedente dw che sta perdendo il fluoco
	kidw_selezionata = this
	kidw_selezionata.icon = ki_icona_selezionata  // mette l'conda di dw selezionata
	
	if dwo.name = "scegli_padre" or dwo.name = "img_b_scegli_padre"  then
		post scegli_padre_da_dw_lista(row)
	end if


end event

event doubleclicked;//
if this.rowcount() < 2 then
	beep(1)
else
//	call_window_barcode()
end if

attiva_tasti ()


end event

event getfocus;//
kidw_selezionata = this
u_set_dw_icon( )

//attiva_tasti( ) 
end event

event itemchanged;call super::itemchanged;//
attiva_tasti ()

end event

event losefocus;//
// non fare il focus del super
end event

event rowfocuschanged;////
//if not k_dragdrop then
//	Super::EVENT rowfocuschanged(currentrow)
//end if
//
end event

event ue_drop_out;call super::ue_drop_out;	
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
			
return 1
end event

event ue_lbuttondown;call super::ue_lbuttondown;//
//ki_dw_fuoco_nome = this.dataobject
//
//if this.ki_attiva_DRAGDROP then
//	ki_dragdrop = true
//end if

end event

type dw_periodo from uo_d_std_1 within w_pl_barcode_dett_g3
event u_button_ok ( )
integer x = 3081
integer y = 2488
integer width = 955
integer height = 504
integer taborder = 80
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Periodo di estrazione"
string dataobject = "d_periodo"
boolean controlmenu = true
boolean hsplitscroll = false
boolean livescroll = false
boolean ki_dw_visibile_in_open_window = false
end type

event u_button_ok();//
	this.visible = false
	this.accepttext( )

	ki_data_ini  = this.getitemdate( 1, "data_dal")
	ki_data_fin  = this.getitemdate( 1, "data_al")
	ki_riga_pos_dw_meca = dw_meca.getrow( )  //cattura la riga selezionata
	leggi_liste()

end event

event buttonclicked;call super::buttonclicked;//
st_stampe kst_stampe
pointer oldpointer  // Declares a pointer variable

	
//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)
	

if dwo.name = "b_ok" then
	
	this.event u_button_ok()

else
	if dwo.name = "b_annulla" then

		this.visible = false
	
	
	end if
end if

SetPointer(oldpointer)


end event

event ue_visibile;call super::ue_visibile;//
int k_rc

	this.width = long(this.object.data_al.x) + long(this.object.data_al.width) + 200
	this.height = long(this.object.b_ok.y) + long(this.object.b_ok.height) + 260

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

event u_pigiato_enter;//
	this.event u_button_ok()

end event

type cb_aggiungi from statictext within w_pl_barcode_dett_g3
boolean visible = false
integer x = 3451
integer y = 2140
integer width = 375
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

type cb_chiudi from statictext within w_pl_barcode_dett_g3
boolean visible = false
integer x = 3461
integer y = 2236
integer width = 283
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
				
					k_elaborazione_ok = chiudi_pl()     // CHIUDE IL PIANO DI LAVORAZIONE
						
				end if
						
				if k_elaborazione_ok = 0 then
	
					kiuf1_sync_window.u_window_set_funzione_aggiornata(ki_st_open_w) // setta x sicronizzare il ritorno

					smista_funz( KKG_FLAG_RICHIESTA.esci )  // Esce!
					
//					if ki_PL_chiuso then 
//					else
//						ki_chiudi_PL_enabled = false
//						ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
//						ki_st_open_w.key1 = string( dw_dett_0.getitemnumber(1, "codice")) 
//				
//						proteggi_campi()
//						
//					end if
					
				end if
			else
				messagebox("Operazione non Autorizzata", &
					"Utente non autorizzato a Chiudere/Riaprire il Piano di Lavorazione. " + kkg.acapo)
				
			end if
		end if
	end if
end if

cb_chiudi.enabled = true


end event

type dw_pilota_inlav from uo_d_std_1 within w_pl_barcode_dett_g3
event u_show ( )
event u_run ( )
event u_hide ( )
integer x = 9998
integer y = 11228
integer width = 3456
integer height = 1208
integer taborder = 120
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
long k_rows, k_rc


try
	
	kguo_exception.inizializza(this.classname())
	
	setpointer(kkg.pointer_attesa)
	
	if this.rowcount( ) > 0 then
		this.reset( )
	end if
	
	if not isvalid(kiuf_pilota_previsioni_g3) then kiuf_pilota_previsioni_g3 = create kuf_pilota_previsioni_g3
	k_rows = kiuf_pilota_previsioni_g3.crea_temptable_pilota_pallet_workqueue( ) 
	dw_pilota_inlav.dataobject = "d_pilota_workqueue_g3"
	kguf_data_base.u_set_ds_change_name_tab(dw_pilota_inlav, "vx_MAST_pilota_pallet_workqueue_g3" )

	if k_rows > 0 then
	
		dw_pilota_inlav.settransobject(kguo_sqlca_db_magazzino)
	
		k_rows = dw_pilota_inlav.retrieve()
		
	end if
				
	this.event u_show( )
	
catch (uo_exception kuo_exception)
	
finally
	setpointer(kkg.pointer_default)
	
end try
	

end event

event u_hide();//

this.enabled = false
this.visible = false
	

end event

event getfocus;call super::getfocus;//
kidw_selezionata.icon = ki_icona_normale  // toglie l'icona alla precedente dw che sta perdendo il fluoco
kidw_selezionata = this
kidw_selezionata.icon = ki_icona_selezionata  // mette l'conda di dw selezionata

end event

event losefocus;//

end event

event resize;call super::resize;//
if sizetype = 1 then //SIZE_MINIMIZED
	ki_dw_pilota_inlav_firsttime = true
end if

end event

type cb_togli from statictext within w_pl_barcode_dett_g3
boolean visible = false
integer x = 3328
integer y = 2304
integer width = 375
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

	if dw_lista_0.getselectedrow(0) <= 0 then

		messagebox("Operazione fallita", &
				"Selezionare almeno un Barcode dalla lista 'barcode da trattare'.~n~r")
	else

		togli_barcode_padre()
	end if

	attiva_tasti ()

	dw_lista_0.setfocus ()
	

end event

type dw_g3ciclo_alt from datawindow within w_pl_barcode_dett_g3
event u_enter pbm_dwnprocessenter
boolean visible = false
integer x = 1467
integer y = 384
integer width = 910
integer height = 320
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_w_pl_barcode_g3ciclo"
end type

event u_enter;//
this.accepttext( )
ki_g3ciclo_alt = this.getitemnumber(1, "g3ciclo")
if ki_g3ciclo_alt > 0 then
	u_aggiungi_a_dw_lista(ki_dw_source_name)
end if
this.visible = false

end event

event losefocus;//
dw_g3ciclo_alt.visible = false
end event

event buttonclicked;//
if dwo.name = "b_cancel" then
	this.visible = false
	ki_g3ciclo_alt = 0
end if
	
end event

event getfocus;//
			this.width = 910
			this.height = 320
			this.y = parent.height / 4
			this.x = (parent.width - this.width) / 2
			if this.rowcount() = 0 then
				this.insertrow(0)
			end if
			this.visible = true
			this.bringtotop = true

end event

