﻿$PBExportHeader$w_pl_barcode_l.srw
forward
global type w_pl_barcode_l from w_g_tab0
end type
type dw_data from uo_d_std_1 within w_pl_barcode_l
end type
end forward

global type w_pl_barcode_l from w_g_tab0
integer width = 3072
integer height = 1444
string title = "Piani di Lavoro"
boolean ki_toolbar_window_presente = true
dw_data dw_data
end type
global w_pl_barcode_l w_pl_barcode_l

type variables
//
private date ki_data_ini
private kuf_pl_barcode kiuf_pl_barcode
private kuf_pl_barcode_g3 kiuf_pl_barcode_g3

end variables

forward prototypes
private function string leggi_liste ()
protected subroutine forma_elenco ()
private function string cancella ()
private function string inizializza ()
private subroutine open_notepad_documento (string k_file) throws uo_exception
protected subroutine open_start_window ()
protected subroutine attiva_tasti_0 ()
protected subroutine attiva_menu ()
public subroutine smista_funz (string k_par_in)
private subroutine u_cambia_data ()
end prototypes

private function string leggi_liste ();//
//======================================================================
//=== Liste Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
string k_key
long k_riga


	k_riga = dw_lista_0.getrow()
	inizializza()
	
	if k_riga > dw_lista_0.rowcount() then
		k_riga = dw_lista_0.rowcount() 
	end if
	if k_riga > 0 then
		dw_lista_0.scrolltorow(k_riga)
		dw_lista_0.setrow(k_riga)
		dw_lista_0.selectrow(0 , false)
		dw_lista_0.selectrow(k_riga , false)
	end if
	
	attiva_tasti( )

	
return k_return


end function

protected subroutine forma_elenco ();
end subroutine

private function string cancella ();//
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
string k_msg
st_tab_pl_barcode kst_tab_pl_barcode


k_riga = dw_lista_0.getrow()	
if k_riga > 0 then
	kst_tab_pl_barcode.codice = dw_lista_0.getitemnumber(k_riga, "codice")
	kst_tab_pl_barcode.data = dw_lista_0.getitemdate(k_riga, "data")
	kst_tab_pl_barcode.note_1 = trim(dw_lista_0.getitemstring(k_riga, "note_1"))

	k_msg = "Sei sicuro di voler Cancellare il Piano di Lavoro " &
	         + kkg.acapo + "codice: " + string(kst_tab_pl_barcode.codice, "#####") + " del " + string(kst_tab_pl_barcode.data, "dd mmm yy") 
	if kst_tab_pl_barcode.note_1 > " " then
		k_msg += " note:" + kst_tab_pl_barcode.note_1
	end if
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina Piano di Lavorazione", k_msg, question!, yesno!, 2) = 1 then
		
//=== Cancella la riga dal data windows di lista
		k_errore = kiuf_pl_barcode.tb_delete(kst_tab_pl_barcode) 
		if Left(k_errore, 1) = "0" then
	
			kguo_sqlca_db_magazzino.db_commit( )

			dw_lista_0.setitemstatus(k_riga, 0, primary!, new!)
			dw_lista_0.deleterow(k_riga)

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

dw_lista_0.setfocus()

return " "
end function

private function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
string k_operazione, k_key
int k_importa = 0
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)
	
	ki_win_titolo_custom = ""

	k_operazione = trim(ki_st_open_w.key2)    //--- tipo mandante/ricevente/fatturato
	if isnull(k_operazione) then
		k_operazione = "tutti"
	end if

//	dw_dett_0.visible = false


//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 

		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)

	end if
		
	if k_importa <= 0 then // Nessuna importazione eseguita

		if dw_lista_0.retrieve(ki_data_ini, k_operazione) > 0 then
			ki_win_titolo_custom = "dal " + string(ki_data_ini)

		else
			k_return = "1Nessun P.L. presente "
			SetPointer(oldpointer)
			messagebox("Lista Piani di Lavorazione", &
					"Elenco vuoto per la richiesta fatta" &
					+ "  (dalla data del " + string(ki_data_ini, "dd/mm/yyyy") + " - " + k_operazione + ")" )
		end if		
	end if

	set_titolo_window_personalizza( )

return k_return



end function

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

protected subroutine open_start_window ();//--- prendo la chiave
	if isdate(trim(ki_st_open_w.key1)) then
		ki_data_ini = date(trim(ki_st_open_w.key1))
	else
		ki_data_ini = relativedate(today(),-30)
	end if

	kiuf_pl_barcode = create kuf_pl_barcode
	kiuf_pl_barcode_g3 = create kuf_pl_barcode_g3
	
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

//cb_aggiorna.enabled = false
cb_modifica.enabled = false
cb_cancella.enabled = false

//=== Nr righe ne DW lista
if dw_lista_0.getrow ( ) > 0 then
	cb_modifica.enabled = true
	cb_cancella.enabled = true

end if

//=== Nr righe ne DW lista
if dw_dett_0.getrow ( ) > 0 and dw_dett_0.enabled = true then
	cb_cancella.enabled = true
//	cb_aggiorna.enabled = true
end if
            


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

public subroutine smista_funz (string k_par_in);//
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

private subroutine u_cambia_data ();//---
//--- Visualizza il box x il cambio DATA
//---


dw_data.triggerevent("ue_visibile")

end subroutine

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

end event

type dw_print_0 from w_g_tab0`dw_print_0 within w_pl_barcode_l
end type

type st_ritorna from w_g_tab0`st_ritorna within w_pl_barcode_l
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_pl_barcode_l
boolean enabled = true
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_pl_barcode_l
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_pl_barcode_l
integer x = 2514
integer y = 1180
integer height = 92
integer taborder = 110
boolean cancel = true
end type

type st_stampa from w_g_tab0`st_stampa within w_pl_barcode_l
integer x = 37
integer y = 1112
integer width = 270
integer height = 100
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_pl_barcode_l
integer x = 850
integer y = 1176
integer taborder = 30
end type

event cb_visualizza::clicked;//
long k_riga
st_open_w kst_open_w


k_riga = dw_lista_0.u_getrow(1)
if k_riga > 0 then

	kst_open_w.key1 = string(dw_lista_0.getitemnumber( k_riga, "codice" ))
	kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	if dw_lista_0.getitemnumber( k_riga, "impianto" ) = 3 then
		kiuf_pl_barcode_g3.u_open(kst_open_w)
	else
		kiuf_pl_barcode.u_open(kst_open_w)
	end if

end if
//long k_riga
//long k_codice
//st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window
//
//
//k_riga = dw_lista_0.getrow()
//if k_riga > 0 then
//
//	dw_lista_0.selectrow( k_riga, true)
//	k_codice = dw_lista_0.getitemnumber( k_riga, "codice" ) 
//		
//	if k_codice  > 0 then
//		K_st_open_w.id_programma = "pl_barcode"
//		K_st_open_w.flag_primo_giro = "S"
//		K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
//		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
//		K_st_open_w.flag_leggi_dw = "N"
//		K_st_open_w.flag_cerca_in_lista = " "
//		K_st_open_w.key1 = string(k_codice, "0000000000")
//		K_st_open_w.key2 = " "
//		K_st_open_w.key3 = " "
//		K_st_open_w.key4 = " "
//		K_st_open_w.flag_where = " "
//		
//		kuf1_menu_window = create kuf_menu_window 
//		kuf1_menu_window.open_w_tabelle(k_st_open_w)
//		destroy kuf1_menu_window
//		
//	end if
//end if
	


end event

type cb_modifica from w_g_tab0`cb_modifica within w_pl_barcode_l
integer x = 1737
integer y = 1144
integer height = 96
integer taborder = 90
end type

event cb_modifica::clicked;//
long k_riga
st_open_w kst_open_w


k_riga = dw_lista_0.u_getrow(1)
if k_riga > 0 then

	kst_open_w.key1 = string(dw_lista_0.getitemnumber( k_riga, "codice" ))
	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	if dw_lista_0.getitemnumber( k_riga, "impianto" ) = 3 then
		kiuf_pl_barcode_g3.u_open(kst_open_w)
	else
		kiuf_pl_barcode.u_open(kst_open_w)
	end if

end if
//long k_riga
//long k_codice
//st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window
//
//
//k_riga = dw_lista_0.getrow()
//if k_riga > 0 then
//
//	dw_lista_0.selectrow( k_riga, true)
//	k_codice = dw_lista_0.getitemnumber( k_riga, "codice" ) 
//		
//	if k_codice  > 0 then
//		K_st_open_w.id_programma = "pl_barcode"
//		K_st_open_w.flag_primo_giro = "S"
//		K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
//		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
//		K_st_open_w.flag_leggi_dw = "N"
//		K_st_open_w.flag_cerca_in_lista = " "
//		K_st_open_w.key1 = string(k_codice, "0000000000")
//		K_st_open_w.key2 = " "
//		K_st_open_w.key3 = " "
//		K_st_open_w.key4 = " "
//		K_st_open_w.flag_where = " "
//		
//		kuf1_menu_window = create kuf_menu_window 
//		kuf1_menu_window.open_w_tabelle(k_st_open_w)
//		destroy kuf1_menu_window
//		
//	end if
//end if

end event

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_pl_barcode_l
integer x = 329
integer y = 1140
integer height = 96
integer taborder = 130
end type

type cb_cancella from w_g_tab0`cb_cancella within w_pl_barcode_l
integer x = 2121
integer y = 1144
integer height = 96
integer taborder = 100
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_pl_barcode_l
integer x = 1349
integer y = 1152
integer height = 96
integer taborder = 80
boolean enabled = false
end type

event cb_inserisci::clicked;//

	kiuf_pl_barcode.u_open(kkg_flag_modalita.inserimento)

end event

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_pl_barcode_l
integer x = 2030
integer y = 1032
integer width = 489
integer height = 184
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_pl_barcode_l
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_pl_barcode_l
integer width = 2807
integer height = 672
string dataobject = "d_pl_barcode_l"
end type

event dw_lista_0::clicked;call super::clicked;//
//=== Premuto Link nella DW ?
//
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


try
		

	if dwo.name = "k_path_file_pilota" then
	
		open_notepad_documento(this.getitemstring(row, "path_file_pilota"))
	
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try


//=== Riprist. il vecchio puntatore :
SetPointer(kpointer)



end event

type dw_guida from w_g_tab0`dw_guida within w_pl_barcode_l
end type

type st_duplica from w_g_tab0`st_duplica within w_pl_barcode_l
end type

type dw_data from uo_d_std_1 within w_pl_barcode_l
event u_button_ok ( )
integer x = 1216
integer y = 444
integer width = 827
integer height = 492
integer taborder = 90
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
	
	this.visible = false
	this.accepttext( )
	ki_data_ini  = this.getitemdate( 1, "kdata")
	inizializza()

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

event u_pigiato_enter;//
	this.event u_button_ok()

end event
