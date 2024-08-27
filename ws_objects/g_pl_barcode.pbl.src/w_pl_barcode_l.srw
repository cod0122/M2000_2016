$PBExportHeader$w_pl_barcode_l.srw
forward
global type w_pl_barcode_l from w_g_tab_3
end type
type dw_data from uo_d_std_1 within w_pl_barcode_l
end type
end forward

global type w_pl_barcode_l from w_g_tab_3
integer width = 3035
integer height = 5180
dw_data dw_data
end type
global w_pl_barcode_l w_pl_barcode_l

type variables
//
private date ki_data_ini
private kuf_pl_barcode kiuf_pl_barcode
private kuf_pl_barcode_g3 kiuf_pl_barcode_g3
private kuf_plav_programmi kiuf_plav_programmi

end variables

forward prototypes
protected subroutine open_start_window ()
private subroutine open_notepad_documento (string k_file) throws uo_exception
private subroutine u_cambia_data ()
protected subroutine attiva_menu ()
protected subroutine attiva_tasti_0 ()
protected function integer cancella ()
protected function string inizializza () throws uo_exception
protected subroutine smista_funz (string k_par_in)
protected function integer visualizza ()
private subroutine u_open_pl (string a_modalita)
protected subroutine modifica ()
protected function integer inserisci ()
protected subroutine inizializza_1 () throws uo_exception
protected function boolean sicurezza (st_open_w kst_open_w)
end prototypes

protected subroutine open_start_window ();//--- prendo la chiave
	if isdate(trim(ki_st_open_w.key1)) then
		ki_data_ini = date(trim(ki_st_open_w.key1))
	else
		ki_data_ini = relativedate(today(),-30)
	end if

	kiuf_pl_barcode = create kuf_pl_barcode
	kiuf_pl_barcode_g3 = create kuf_pl_barcode_g3
	kiuf_plav_programmi = create kuf_plav_programmi
	
end subroutine

private subroutine open_notepad_documento (string k_file) throws uo_exception;//
kuf_ole kuf1_ole
st_esito kst_esito
uo_exception kuo_exception


	if LenA(trim(k_file)) > 0 then 
	
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

private subroutine u_cambia_data ();//---
//--- Visualizza il box x il cambio DATA
//---


dw_data.triggerevent("ue_visibile")

end subroutine

protected subroutine attiva_menu ();
	m_main.m_strumenti.m_fin_gest_libero2.text = "Programma G3"
	m_main.m_strumenti.m_fin_gest_libero2.microhelp = m_main.m_strumenti.m_fin_gest_libero2.text
	m_main.m_strumenti.m_fin_gest_libero2.enabled = true
	m_main.m_strumenti.m_fin_gest_libero2.toolbaritemText = "G3,"+m_main.m_strumenti.m_fin_gest_libero2.text
	m_main.m_strumenti.m_fin_gest_libero2.toolbaritemName = "pianifp16.png"
	m_main.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
	m_main.m_strumenti.m_fin_gest_libero2.visible = true
	m_main.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true

	m_main.m_strumenti.m_fin_gest_libero4.text = "Cambia data di inizio estrazione"
	m_main.m_strumenti.m_fin_gest_libero4.microhelp = m_main.m_strumenti.m_fin_gest_libero4.text
	m_main.m_strumenti.m_fin_gest_libero4.enabled = true
	m_main.m_strumenti.m_fin_gest_libero4.toolbaritemText = "Data,"+m_main.m_strumenti.m_fin_gest_libero4.text
	m_main.m_strumenti.m_fin_gest_libero4.toolbaritemName = "Custom015a!"
	m_main.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2
	m_main.m_strumenti.m_fin_gest_libero4.visible = true
	m_main.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = true

super::attiva_menu()
end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================
long k_nr_righe


super::attiva_tasti_0()

cb_ritorna.enabled = true
cb_inserisci.enabled = true
cb_visualizza.enabled = true

cb_modifica.enabled = false
cb_cancella.enabled = false

//=== Nr righe ne DW lista
if tab_1.selectedtab = 1 then
	if tab_1.tabpage_1.dw_1.getrow ( ) > 0 then
		cb_modifica.enabled = true
		cb_cancella.enabled = true
	end if
end if

end subroutine

protected function integer cancella ();//
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
string k_msg
st_tab_pl_barcode kst_tab_pl_barcode


if tab_1.selectedtab <> 1 then
	return 0
end if

k_riga = tab_1.tabpage_1.dw_1.getrow()	
if k_riga > 0 then
	kst_tab_pl_barcode.codice = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "codice")
	kst_tab_pl_barcode.data = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data")
	kst_tab_pl_barcode.note_1 = trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "note_1"))

	k_msg = "Sei sicuro di voler Cancellare il Piano di Lavoro " &
	         + kkg.acapo + "codice: " + string(kst_tab_pl_barcode.codice, "#") + " del " + string(kst_tab_pl_barcode.data, "dd mmm yy") 
	if kst_tab_pl_barcode.note_1 > " " then
		k_msg += " note:" + kst_tab_pl_barcode.note_1
	end if
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina Piano di Lavorazione", k_msg, question!, yesno!, 2) = 1 then
		
//=== Cancella la riga dal data windows di lista
		k_errore = kiuf_pl_barcode.tb_delete(kst_tab_pl_barcode) 
		if Left(k_errore, 1) = "0" then
	
			kguo_sqlca_db_magazzino.db_commit( )

			tab_1.tabpage_1.dw_1.setitemstatus(k_riga, 0, primary!, new!)
			tab_1.tabpage_1.dw_1.deleterow(k_riga)

		else
			kguo_sqlca_db_magazzino.db_rollback( )

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							MidA(k_errore, 2) ) 	
	
			attiva_tasti()

		end if

	else
		messagebox("Elimina Piano di Lavorazione", "Operazione Annullata !!")

	end if
end if

tab_1.tabpage_1.dw_1.setfocus()

return 0
end function

protected function string inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_return="0 "
string k_operazione, k_key
int k_importa = 0


	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
	ki_win_titolo_custom = ""

	k_operazione = trim(ki_st_open_w.key2)    //--- tipo mandante/ricevente/fatturato
	if isnull(k_operazione) then
		k_operazione = "tutti"
	end if


//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 

		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), tab_1.tabpage_1.dw_1)

	end if
		
	if k_importa <= 0 then // Nessuna importazione eseguita

		if tab_1.tabpage_1.dw_1.rowcount() <= 0 then

			if tab_1.tabpage_1.dw_1.retrieve(ki_data_ini, k_operazione) > 0 then
				ki_win_titolo_custom = "dal " + string(ki_data_ini)
	
			else
				k_return = "1Nessun P.L. presente "
				SetPointer(kkg.pointer_default)
				messagebox("Lista Piani di Lavorazione", &
						"Elenco vuoto per la richiesta fatta" &
						+ " dal " + string(ki_data_ini, "dd/mm/yyyy") + " (" + k_operazione + ")." )
			end if		
		end if		
	end if

	set_titolo_window_personalizza( )

return k_return



end function

protected subroutine smista_funz (string k_par_in);//
//===

choose case k_par_in 

	case KKG_FLAG_RICHIESTA.libero2		//+ programmazione G3
		kiuf_pl_barcode_g3.u_open(kkg_flag_modalita.inserimento)

	case KKG_FLAG_RICHIESTA.libero4		//cambia data inizio estrazione 
		u_cambia_data()
		
	case else
		super::smista_funz(k_par_in)

end choose



end subroutine

protected function integer visualizza ();//
try
	
	if tab_1.selectedtab = 1 then
	
		u_open_pl(kkg_flag_modalita.visualizzazione)
		
	elseif tab_1.selectedtab = 2 then
		
		kiuf_plav_programmi.link_call(tab_1.tabpage_2.dw_2, "programmi_richieste_id_programma")
		
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return 0

end function

private subroutine u_open_pl (string a_modalita);//
long k_row
st_open_w kst_open_w


k_row = tab_1.tabpage_1.dw_1.u_getrow(1)
if k_row > 0 then
else
	k_row = 1
end if

if tab_1.tabpage_1.dw_1.rowcount( ) >= k_row then
	kst_open_w.key1 = string(tab_1.tabpage_1.dw_1.getitemnumber(k_row, "codice"))
	kst_open_w.flag_modalita = a_modalita
	if tab_1.tabpage_1.dw_1.getitemnumber(k_row, "impianto") = 3 then
		kiuf_pl_barcode_g3.u_open(kst_open_w)
	else
		kiuf_pl_barcode.u_open(kst_open_w)
	end if
end if


end subroutine

protected subroutine modifica ();//
if tab_1.selectedtab = 1 then
	u_open_pl(kkg_flag_modalita.modifica)
end if




end subroutine

protected function integer inserisci ();//

	kiuf_pl_barcode.u_open(kkg_flag_modalita.inserimento)

return 0
end function

protected subroutine inizializza_1 () throws uo_exception;//
long k_rows
ds_programmi_richieste_l kds_programmi_richieste_l
//datetime k_datetime_ini


	if tab_1.tabpage_2.dw_2.rowcount() <= 0 then
		kds_programmi_richieste_l = create ds_programmi_richieste_l
		//k_datetime_ini = datetime(ki_data_ini, time(0))  viene formattato male non con yyy-mm-dd .... ma dd/mm/yyyy....
		k_rows = kds_programmi_richieste_l.u_retrieve(ki_data_ini)
		if k_rows >0 then
			kds_programmi_richieste_l.rowscopy(1, k_rows, primary!, tab_1.tabpage_2.dw_2, 1, primary!)
			tab_1.tabpage_2.dw_2.sort( )
		else
			tab_1.tabpage_2.dw_2.reset( )
		end if
	end if


end subroutine

protected function boolean sicurezza (st_open_w kst_open_w);//
try
	kst_open_w.id_programma = "" // lo va a reperire dall'oggetto
	kiuf_pl_barcode.if_sicurezza(kst_open_w)
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	return false
	
end try

return true
end function

on w_pl_barcode_l.create
int iCurrent
call super::create
this.dw_data=create dw_data
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_data
end on

on w_pl_barcode_l.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_data)
end on

event close;call super::close;//
if isvalid(kiuf_pl_barcode) then destroy kiuf_pl_barcode
if isvalid(kiuf_pl_barcode_g3) then destroy kiuf_pl_barcode_g3
if isvalid(kiuf_plav_programmi) then destroy kiuf_plav_programmi

end event

type dw_print_0 from w_g_tab_3`dw_print_0 within w_pl_barcode_l
end type

type st_ritorna from w_g_tab_3`st_ritorna within w_pl_barcode_l
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_pl_barcode_l
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_pl_barcode_l
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_pl_barcode_l
end type

type st_stampa from w_g_tab_3`st_stampa within w_pl_barcode_l
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_pl_barcode_l
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_pl_barcode_l
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_pl_barcode_l
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_pl_barcode_l
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_pl_barcode_l
end type

type tab_1 from w_g_tab_3`tab_1 within w_pl_barcode_l
event create ( )
event destroy ( )
integer x = 0
integer y = 0
end type

on tab_1.create
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9}
end on

on tab_1.destroy
call super::destroy
end on

event tab_1::u_constructor;call super::u_constructor;//---
//--- se personalizzi le derivate e vuoi finalizzare i TAB attivi o meno inserisci queste due righe
ki_tabpage_enabled = {true, true, false, false, false, false, false, false, false} // disabilita alcune tabpage
super::event u_constructor( )

event u_constructor_main( )
end event

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer y = 176
integer height = 952
string text = "Elenco~r~nP.L."
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
string dataobject = "d_pl_barcode_l"
end type

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer y = 176
integer height = 952
string text = "Pilota~r~nProgrammi Inviati"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
boolean enabled = true
string dataobject = "d_programmi_richieste_l"
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer y = 176
integer height = 952
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer y = 176
integer height = 952
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer y = 176
integer height = 952
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer y = 176
integer height = 952
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer y = 176
integer height = 952
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer y = 176
integer height = 952
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer y = 176
integer height = 952
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type st_duplica from w_g_tab_3`st_duplica within w_pl_barcode_l
end type

type dw_data from uo_d_std_1 within w_pl_barcode_l
event u_button_ok ( )
integer x = 1216
integer y = 444
integer width = 827
integer height = 492
integer taborder = 100
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Data di inizio elenco"
string dataobject = "d_data"
boolean controlmenu = true
string icon = "Information!"
boolean hsplitscroll = false
boolean livescroll = false
boolean ki_dw_visibile_in_open_window = false
end type

event u_button_ok();//
try

	this.visible = false
	this.accepttext( )
	if ki_data_ini = this.getitemdate( 1, "kdata") then
	else
		ki_data_ini = this.getitemdate( 1, "kdata")
	
		tab_1.tabpage_1.dw_1.reset( )
		tab_1.tabpage_2.dw_2.reset( )

		inizializza_lista()
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try
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

event u_pigiato_enter;//
	this.event u_button_ok()

end event

event ue_visibile;call super::ue_visibile;//
int k_rc

	this.width = long(this.object.kdata.x) + long(this.object.kdata.width) + 100
	this.height = long(this.object.b_ok.y) + long(this.object.b_ok.height) + 260

	this.x = (kiw_this_window.width  - this.width) / 4
	this.y = (kiw_this_window.height - this.height) / 4

	this.reset()
	k_rc = this.insertrow(0)
	k_rc = this.setitem(1, "kdata", ki_data_ini)
	this.visible = true
	this.setfocus()
end event

