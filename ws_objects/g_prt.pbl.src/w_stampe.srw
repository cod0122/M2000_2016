﻿$PBExportHeader$w_stampe.srw
forward
global type w_stampe from w_g_tab
end type
type cb_esci from commandbutton within w_stampe
end type
type cb_email from commandbutton within w_stampe
end type
type cb_close_anteprima from commandbutton within w_stampe
end type
type cb_personalizza from commandbutton within w_stampe
end type
type st_parametri from statictext within w_stampe
end type
type dw_personalizza from datawindow within w_stampe
end type
type cb_excel from commandbutton within w_stampe
end type
type cb_anteprima from commandbutton within w_stampe
end type
type cb_imposta from commandbutton within w_stampe
end type
type cb_stampa from commandbutton within w_stampe
end type
type dw_originale from datawindow within w_stampe
end type
type cb_pdf from commandbutton within w_stampe
end type
type ddplb_stampanti from dropdownpicturelistbox within w_stampe
end type
type dw_crea_xls from datawindow within w_stampe
end type
type cb_printlist from picturebutton within w_stampe
end type
type dw_setup from datawindow within w_stampe
end type
type dw_print from datawindow within w_stampe
end type
type st_preview_zoom from statictext within w_stampe
end type
type pb_preview_zoom_meno from picturebutton within w_stampe
end type
type pb_preview_zoom_piu from picturebutton within w_stampe
end type
type cbx_preview from checkbox within w_stampe
end type
type cb_apply_customization from commandbutton within w_stampe
end type
type r_dimensione_win from rectangle within w_stampe
end type
end forward

global type w_stampe from w_g_tab
boolean visible = true
integer x = 101
integer y = 100
integer width = 1413
integer height = 1680
string title = "Stampa"
string menuname = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 32567536
string icon = "Report5!"
string pointer = "Arrow!"
boolean clientedge = true
boolean center = true
boolean ki_toolbar_window_presente = true
boolean ki_sincronizza_window_consenti = false
event set_window_size ( )
event u_resize ( )
event u_preview_only ( )
event rbuttonup pbm_rbuttonup
event u_preview_show_display ( boolean k_visible )
event u_preview_show ( )
event u_preview_custom ( )
cb_esci cb_esci
cb_email cb_email
cb_close_anteprima cb_close_anteprima
cb_personalizza cb_personalizza
st_parametri st_parametri
dw_personalizza dw_personalizza
cb_excel cb_excel
cb_anteprima cb_anteprima
cb_imposta cb_imposta
cb_stampa cb_stampa
dw_originale dw_originale
cb_pdf cb_pdf
ddplb_stampanti ddplb_stampanti
dw_crea_xls dw_crea_xls
cb_printlist cb_printlist
dw_setup dw_setup
dw_print dw_print
st_preview_zoom st_preview_zoom
pb_preview_zoom_meno pb_preview_zoom_meno
pb_preview_zoom_piu pb_preview_zoom_piu
cbx_preview cbx_preview
cb_apply_customization cb_apply_customization
r_dimensione_win r_dimensione_win
end type
global w_stampe w_stampe

type variables
//w_stampe_1 kiwindow_stampe_1
//menu private m_popup ki_menu
//private st_stampe kist_stampe
private boolean ki_personalizzato_dw = false
private boolean ki_ridimensiona_colonna = false
private long ki_ridimensione_x=0
private long ki_ridimensione_y=0
private string ki_stampante_pdf=""
private boolean ki_anteprima_on=false
private boolean ki_custom_on=false
kuf_stampe kiuf_stampe
private int ki_winsaved_x
private int ki_winsaved_y
private int ki_winsaved_w
private int ki_winsaved_h

private boolean ki_zoom_ok=true
private string ki_setup_grid_lines 
private string ki_setup_stampa_testata

//w_g_tab kiw_this_window
//m_toolbar_libx ki_menu   
end variables

forward prototypes
public subroutine zoom_avanti ()
public subroutine zoom_indietro ()
protected subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
protected function string inizializza () throws uo_exception
public function string get_nome_pdf ()
private subroutine aggiungi_testata ()
protected subroutine inizializza_lista ()
private subroutine u_imposta_form ()
protected subroutine open_start_window ()
protected subroutine attiva_tasti_0 ()
public subroutine u_resize_1 ()
private subroutine u_setup_personalizzazioni ()
public subroutine zoom_set (integer a_zoom)
private subroutine preview_set (boolean a_set_preview)
private subroutine crea_report (boolean a_preview)
private subroutine crea_report_setup ()
end prototypes

event set_window_size();//



//
//
	this.x = ki_winsaved_x 
	this.y = ki_winsaved_y 
	this.width = ki_winsaved_w 
	this.height = ki_winsaved_h 
	this.windowState = normal!

//	r_dimensione_win.visible = false
//
//
////=== Posiziona window all'interno della MDI
//	if w_main.width > this.width then
//		this.x = (w_main.width - this.width) / 2
//	else
//		this.x = 1
//	end if
//	if w_main.height > this.height then
//		this.y = (w_main.height - this.height) / 4
//	else
//		this.y = 1
//	end if
//	
	this.setredraw(true)

	

end event

event u_preview_only();//

	this.title = "Anteprima di Stampa: " + trim(kist_stampe.titolo)

	this.event u_preview_show()


	
end event

event rbuttonup;//
string k_stringa=""
//long k_riga=0
//string k_tag_old=""
//string k_tag=""
//m_popup m_menu
//
//
//	attiva_tasti()
//
//
////=== Salvo il Tag attuale per reimpostarlo a fine routine
//		k_tag_old = this.tag
//
////=== Creo menu Popup 
//		m_menu = create m_popup
//	
//		m_menu.m_t_lib_3.visible = ki_menu.m_strumenti.m_fin_gest_libero1.visible
//		m_menu.m_lib_1.visible = ki_menu.m_strumenti.m_fin_gest_libero1.visible
//		m_menu.m_lib_1.enabled = ki_menu.m_strumenti.m_fin_gest_libero1.enabled
//		m_menu.m_lib_1.text = ki_menu.m_strumenti.m_fin_gest_libero1.text
//		m_menu.m_lib_2.visible = ki_menu.m_strumenti.m_fin_gest_libero2.visible
//		m_menu.m_lib_2.enabled = ki_menu.m_strumenti.m_fin_gest_libero2.enabled
//		m_menu.m_lib_2.text = ki_menu.m_strumenti.m_fin_gest_libero2.text
//		m_menu.m_lib_3.visible = ki_menu.m_strumenti.m_fin_gest_libero3.visible
//		m_menu.m_lib_3.enabled = ki_menu.m_strumenti.m_fin_gest_libero3.enabled
//		m_menu.m_lib_3.text = ki_menu.m_strumenti.m_fin_gest_libero3.text
//		
//
////=== Attivo il menu Popup
//		m_menu.visible = true
//		//m_menu.popmenu(this.x + pointerx(), this.y +pointery())
//		m_menu.popmenu(pointerx(), pointery())
//		m_menu.visible = false
//
//		destroy m_menu
//
//		k_tag = this.tag 
//
//		this.tag = k_tag_old 
//
//		smista_funz(k_tag)


end event

event u_preview_show_display(boolean k_visible);//
boolean k_not_visible
string k_zoom


	k_not_visible = not k_visible

	ki_anteprima_on = k_visible
	if not k_visible then
		ki_custom_on = false
	end if
	if ki_custom_on then
		cb_close_anteprima.text = "&Chiudi Personalizza"
	else
		cb_close_anteprima.text = "&Chiudi Anteprima"
	end if
	cb_close_anteprima.visible = k_visible 
	cb_apply_customization.visible = ki_custom_on 
	cbx_preview.visible = k_visible
	pb_preview_zoom_meno.visible = k_visible
	pb_preview_zoom_piu.visible = k_visible
	st_preview_zoom.visible = k_visible 
	dw_print.visible = k_visible
//	r_print.visible = not k_visible

//	dw_print.hscrollbar = not k_visible
//	dw_print.vscrollbar = not k_visible
//	dw_print.livescroll = not k_visible

	dw_print.enabled = k_visible
	if k_visible then
		dw_print.bringtotop = true
	end if

	cb_imposta.visible = k_not_visible
	cb_anteprima.visible = k_not_visible
	cb_stampa.visible = k_not_visible
	cb_excel.visible = k_not_visible
	cb_personalizza.visible = k_not_visible
	cb_esci.visible = k_not_visible
	ddplb_stampanti.visible = k_not_visible	
	cb_printlist.visible = k_not_visible
	
	cb_imposta.BringToTop = k_not_visible
	cb_anteprima.BringToTop = k_not_visible
	cb_stampa.BringToTop = k_not_visible
	cb_excel.BringToTop = k_not_visible
	cb_personalizza.BringToTop = k_not_visible
	cb_esci.BringToTop = k_not_visible
	ddplb_stampanti.BringToTop = k_not_visible	
	cb_printlist.bringtotop = k_not_visible
	
	this.setredraw(true)

	

end event

event u_preview_show();//

	ki_anteprima_on = true

//--- applica o meno le personalizzazioni alla stampa
	crea_report(true)

	u_resize()

	this.event u_preview_show_display(true)

	this.setredraw(true) 
	dw_print.setredraw( true)
	dw_print.setfocus()
	
end event

event u_preview_custom();//
	ki_custom_on = true

	this.title = "Personalizza Stampa: " + trim(kist_stampe.titolo)

	this.event u_preview_show()


	
end event

public subroutine zoom_avanti ();//
int k_zoom


if dw_print.visible then 

	preview_set(true)

	// controlla ol fattore Zoom se e' gia al max 
	k_zoom = integer(dw_print.describe("DataWindow.Print.Preview.Zoom"))
	IF k_zoom > 400 THEN
		Beep (1)
		k_zoom = 100
	else
			k_zoom = k_zoom + 20
	end if
	
	zoom_set(k_zoom)

end if

end subroutine

public subroutine zoom_indietro ();//
int k_zoom

if dw_print.visible then 

	preview_set(true)

	// controlla ol fattore Zoom se e' gia al max 
	k_zoom = integer(dw_print.describe("DataWindow.Print.Preview.Zoom"))
	IF k_zoom < 24 THEN
		Beep (1)
		k_zoom = 400
	ELSE
		k_zoom = k_zoom - 20
	end if
	
	zoom_set(k_zoom)

end if

end subroutine

protected subroutine smista_funz (string k_par_in);//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===
window kwindow



choose case trim(left(k_par_in, 3))

//	case "ag"		//richiesta aggiorna la stampa (retrieve)
//		estrae_dati()
//		leggi_liste()	

	case kkg_flag_modalita.stampa		//fuoco sui parametri di stampa
//--- chiudo solo se nascosta
//		kwindow = kGuf_data_base.prendi_win_uguale("w_stampe")
		if dw_print.visible then
			this.event set_window_size()
			this.event u_preview_show_display(false)
//			kwindow.triggerevent ("u_ripri_size_win")
		else
			cb_stampa.triggerevent("clicked")
		end if
		
//	case KKG_FLAG_RICHIESTA.esci		//richiesta chiusura finestra
//		cb_ritorna.triggerevent("clicked")

	case "za"		//
		zoom_avanti()

	case "zi"		//
		zoom_indietro()

//	case KKG_FLAG_RICHIESTA.libero1		//fuoco sui parametri di stampa
//		if dw_print.visible then
//			this.event u_ripri_size_win()
//		else
//			cb_anteprima.triggerevent("clicked")
//		end if
//
//	case KKG_FLAG_RICHIESTA.libero2		//mostra / nascondi colonna
//		dw_personalizza.event u_personalizza_start()
//
//	case KKG_FLAG_RICHIESTA.libero3		
//		
	case else
		super::smista_funz(k_par_in)
		
end choose





end subroutine

protected subroutine attiva_menu ();////
//	if dw_print.visible then
//		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Chiudi ANTEPRIMA"
//		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = "Torna al pannello di esecuzione della stampa"
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext = "Chiudi," + ki_menu.m_strumenti.m_fin_gest_libero1.text
//	else
//		ki_menu.m_strumenti.m_fin_gest_libero1.text = "" //"Anteprima di stampa"
//		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = "" //"Mostra la stampa a Video"
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext = "" //"Anteprima," + ki_menu.m_strumenti.m_fin_gest_libero1.text
//	end if
//	
//	if not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
//		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
//		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
//	//	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex = 2
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemvisible = true
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemname = "Report5!"
//	end if
//
//	if not ki_menu.m_strumenti.m_fin_gest_libero2.visible or ki_menu.m_strumenti.m_fin_gest_libero2.enabled <> dw_print.visible then
//		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Mostra/Nascondi dati da stampare"
//		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Mostra o nascondi una colonna da mettere in stampa"
//		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
//		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = dw_print.visible
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemtext = "Nascondi," + ki_menu.m_strumenti.m_fin_gest_libero2.text
//	//	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex = 2
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemvisible = true
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemname = "CreateTable5!" //ki_path_risorse + "\barcodeF.bmp"
//	end if
////

//---
	super::attiva_menu()


end subroutine

protected function string inizializza () throws uo_exception;//
string k_return = "0"
string k_rcx
long k_rc


//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)

//--- Genera la stampa copiandola nella dw di stampa
	kiuf_stampe.kist_stampe = kist_stampe 

//	k_rc = kist_stampe.dw_print.rowcount( ) 
//	k_rc = kiuf_stampe.kist_stampe.dw_print.rowcount( ) 
	k_rcx = kiuf_stampe.smista_stampe(dw_print)

	if left(k_rcx, 1) <> "0" then

		SetPointer(kkg.pointer_default)
		
		messagebox("Stampa ",  "Operazione non eseguita :~n~r" +  mid( k_rcx, 2 ), exclamation!, ok!)

		k_return = "E"
		//post close(this)
 
	else

//--- salvo la dw per un eventuale ripristino	
		kiuf_stampe.kist_stampe = kist_stampe 
		k_rcx = kiuf_stampe.smista_stampe(dw_originale)
		
		attiva_tasti()
		
		cb_stampa.setfocus( )
	end if

	SetPointer(kkg.pointer_default)

return k_return

end function

public function string get_nome_pdf ();//
//---- torna nome file della stampa
//
string k_return=" "



k_return = "\" + trim(kGuf_data_base.prendi_x_utente()) + "_" + kist_stampe.titolo //string(kGuf_data_base.prendi_x_datins())



return k_return
end function

private subroutine aggiungi_testata ();//
//kuf_stampe kuf1_stampe
pointer koldpointer


//=== Puntatore Cursore da attesa.....
	koldpointer = SetPointer(HourGlass!)
	
	
//--- aggiunge testata standard solo al tabulato di tipo GRID
	if dw_print.Object.DataWindow.Processing = "1" or dw_print.Object.DataWindow.Processing = "8" or dw_print.Object.DataWindow.Processing = "9" then
		kiuf_stampe.kist_stampe_add_testata = kist_stampe	
		kiuf_stampe.kist_stampe_add_testata.dw_print = dw_print	
		kiuf_stampe.dw_print_testata_add()
		dw_print = kiuf_stampe.kist_stampe_add_testata.dw_print  	
	end if

//	destroy kuf1_stampe
	
	SetPointer(koldpointer)	

end subroutine

protected subroutine inizializza_lista ();//
string k_ret
st_esito kst_esito


try
	k_ret = inizializza() 
	if k_ret = "E" then
		ki_exit_si = true   //--- info che sono in uscita
	end if
	
catch (uo_exception kguo_exception)
	kguo_exception.messaggio_utente( )


finally


end try

	

end subroutine

private subroutine u_imposta_form ();//
string k_rcx
int k_idx, k_rc
st_profilestring_ini kst_profilestring_ini
string k_esito="", k_stampante, k_nome_stampa=""
kuf_base kuf1_base


	this.event u_preview_show_display(false)
		
//--- possibilita di range di pagine
	if kist_stampe.scegli_pagina = "S" then
		dw_setup.visible = true
		ddplb_stampanti.visible = true
		cb_printlist.visible = true
	end if 

	
	k_nome_stampa = kist_stampe.dataobject
	
//	kist_stampe.k_nome_stampa = create datawindow
//	kist_stampe.dw_esporta = create datawindow

//--- setto la stampante di default
	if len(trim(kist_stampe.stampante_predefinita)) > 0 then
		PrintSetPrinter (kist_stampe.stampante_predefinita)
	end if


//--- attivo bottone esportazione PDF -----------------------------
		kuf1_base = create kuf_base
//--- Piglio il nome della stampante PDF
		k_esito = kuf1_base.prendi_dato_base( "stamp_pdf")
		if left(k_esito,1) <> "0" then
			ki_stampante_pdf = ""
			cb_pdf.enabled = false
		else
			ki_stampante_pdf	= trim(mid(k_esito,2))
			cb_pdf.enabled = true
		end if
		destroy kuf1_base


//--- Riempio il DDLB con Lista delle stampanti
		kiuf_stampe.ddlb_set_stampanti(ddplb_stampanti)
		k_stampante = trim(dw_print.object.datawindow.printer)
		if len(k_stampante) > 0 and ddplb_stampanti.totalitems( ) > 0 then
			k_idx = ddplb_stampanti.FindItem (k_stampante , 0 )
			if k_idx < 1 and left(k_stampante,1) = "\" or left(k_stampante,1) = "/" then 
				k_idx = ddplb_stampanti.FindItem (mid(k_stampante,3) , 0 )
			end if
			if k_idx > 0 then
				ddplb_stampanti.text = ddplb_stampanti.text( k_idx )
			end if
		end if
		
////--- salvo la dw per un eventuale ripristino	
//		kiuf_stampe.kist_stampe = kist_stampe 
//		k_rcx = kiuf_stampe.smista_stampe(dw_originale)

		kst_profilestring_ini.operazione = "1"
		kst_profilestring_ini.valore = "1"
		kst_profilestring_ini.file = "stampe" 
		kst_profilestring_ini.titolo = "stampe" 
		kst_profilestring_ini.nome = "stampe_" + trim(k_nome_stampa) + "_orientation"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		if kst_profilestring_ini.esito <> "0" then
			kst_profilestring_ini.valore = "0"
		end if
//--- Orientamento della stampa
//		if dw_print.Object.DataWindow.Print.orientation = "1" then
		if kst_profilestring_ini.valore = "1" then
			dw_setup.object.cbx_landscape[1] = "S"
		else
			dw_setup.object.cbx_landscape[1] = "N"
		end if
		//cbx_landscape.triggerevent (clicked!)

//--- recupero i valori se personalizzati della window
		kst_profilestring_ini.operazione = "1"
		kst_profilestring_ini.valore = "N"
		kst_profilestring_ini.file = "stampe" 
		kst_profilestring_ini.titolo = "personalizzate" 
		kst_profilestring_ini.nome = trim(k_nome_stampa) 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		if kst_profilestring_ini.esito <> "0" then
			kst_profilestring_ini.valore = "N"
		end if
		if kst_profilestring_ini.valore = "S" then
			dw_setup.object.cbx_personalizzazioni[1] = "S"
//--- lancia l'evento per applicare le personalizzazioni 
//			cbx_personalizzazioni.triggerevent (clicked!)
		else
			dw_setup.object.cbx_personalizzazioni[1] = "N"
		end if

//--- recupero i valori se personalizzati della window
		kst_profilestring_ini.operazione = "1"
		kst_profilestring_ini.valore = "S"
		kst_profilestring_ini.file = "stampe" 
		kst_profilestring_ini.titolo = "personalizzate_salva" 
		kst_profilestring_ini.nome = trim(k_nome_stampa) 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		if kst_profilestring_ini.esito <> "0" then
			kst_profilestring_ini.valore = "N"
		end if
		if kst_profilestring_ini.valore = "S" then
			dw_setup.object.cbx_personalizzazioni_salva[1] = "S"
		else
			dw_setup.object.cbx_personalizzazioni_salva[1] = "N"
		end if

//--- recupero i valori se personalizzati della window
		kst_profilestring_ini.operazione = "1"
		kst_profilestring_ini.valore = "S"
		kst_profilestring_ini.file = "stampe" 
		kst_profilestring_ini.titolo = "testata_xls" 
		kst_profilestring_ini.nome = trim(k_nome_stampa) 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		if kst_profilestring_ini.esito <> "0" then
			kist_stampe.testata_xls = "N"
		else
			kist_stampe.testata_xls = kst_profilestring_ini.valore
		end if
		
//--- recupero i valori se personalizzati della window
		kst_profilestring_ini.operazione = "1"
		kst_profilestring_ini.valore = "S"
		kst_profilestring_ini.file = "stampe" 
		kst_profilestring_ini.titolo = "chiudeafine" 
		kst_profilestring_ini.nome = trim(k_nome_stampa) 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		if kst_profilestring_ini.esito <> "0" then
			kst_profilestring_ini.valore = "S"
		end if
		if kst_profilestring_ini.valore = "S" then
			dw_setup.object.cbx_chiude[1] = "S"
		else
			dw_setup.object.cbx_chiude[1] = "N"
		end if

//--- recupero valore "Griglia" tra linee e colonne
		kst_profilestring_ini.operazione = "1"
		kst_profilestring_ini.valore = "S"
		kst_profilestring_ini.file = "stampe" 
		kst_profilestring_ini.titolo = "Grid_Lines" 
		kst_profilestring_ini.nome = trim(k_nome_stampa) 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		if kst_profilestring_ini.esito <> "0" then
			kst_profilestring_ini.valore = "S"
		end if
		if kst_profilestring_ini.valore = "N" then
			ki_setup_grid_lines = "N"
		else
			ki_setup_grid_lines = "S"
		end if

//--- recupero valore "stampa dati di Testata"
		kst_profilestring_ini.operazione = "1"
		kst_profilestring_ini.valore = "S"
		kst_profilestring_ini.file = "stampe" 
		kst_profilestring_ini.titolo = "stampaTestata" 
		kst_profilestring_ini.nome = trim(k_nome_stampa) 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		if kst_profilestring_ini.esito <> "0" then
			kst_profilestring_ini.valore = "S"
		end if
		if kst_profilestring_ini.valore = "N" then
			ki_setup_stampa_testata = "N"
		else
			ki_setup_stampa_testata = "S"
		end if
		
//		attiva_tasti()

//	SetPointer(kkg.pointer_default)


end subroutine

protected subroutine open_start_window ();//
long k_rc
st_stampe kst_stampe
kuf_utility kuf1_utility

	
	ki_toolbar_window_presente=true

	dw_crea_xls.insertrow(0)
	dw_crea_xls.object.nome_scheda[1] = ""
	dw_crea_xls.object.testata[1] = ""
	
	kiuf_stampe = create kuf_stampe

	kst_stampe = ki_st_open_w.key12_any

//--- salvo il datastore x intero prima che venga distrutto dopo questo EVENTO
	if isvalid(kst_stampe.ds_print) then
		k_rc = kst_stampe.ds_print.rowcount()
		kist_stampe.ds_print = create datastore
		kist_stampe.ds_print.dataobject = kst_stampe.ds_print.dataobject
		kst_stampe.ds_print.RowsCopy(1,kst_stampe.ds_print.rowcount(), Primary!,  kist_stampe.ds_print, 1, Primary!)
		dw_originale.dataobject = kst_stampe.ds_print.dataobject
	end if	
	if isvalid(kst_stampe.ds_esporta) then
		k_rc = kst_stampe.ds_esporta.rowcount()
		kist_stampe.ds_esporta = create datastore
		kist_stampe.ds_esporta.dataobject = kst_stampe.ds_esporta.dataobject
		kst_stampe.ds_esporta.RowsCopy(1,kst_stampe.ds_esporta.rowcount(), Primary!,  kist_stampe.ds_esporta, 1, Primary!)
		dw_originale.dataobject = kst_stampe.ds_esporta.dataobject
	end if	
	if isvalid(kst_stampe.dw_print) then
		kist_stampe.dw_print = kst_stampe.dw_print
		dw_originale.dataobject = kst_stampe.dw_print.dataobject
	end if	

	kist_stampe.tipo = kst_stampe.tipo
	kist_stampe.titolo = kst_stampe.titolo
	kist_stampe.titolo_2 = kst_stampe.titolo_2
	kist_stampe.dataobject = kst_stampe.dataobject
	kist_stampe.scegli_pagina = kst_stampe.scegli_pagina
	kist_stampe.dw_syntax = kst_stampe.dw_syntax
	kist_stampe.graph_print = kst_stampe.graph_print
	kist_stampe.stampante_predefinita = kst_stampe.stampante_predefinita
	kist_stampe.modificafont = kst_stampe.modificafont
	kist_stampe.testata_xls = kst_stampe.testata_xls
	kist_stampe.blob_print = kst_stampe.blob_print
//--- estrae un nome per il file
	if kist_stampe.nome_file > " " then
	else
		if kist_stampe.titolo_2 > " " then
			kist_stampe.nome_file = trim(kist_stampe.titolo_2)
		else
			if kist_stampe.titolo > " " then
				kist_stampe.nome_file = trim(kist_stampe.titolo)
			else
				kist_stampe.nome_file = ""
			end if
		end if
		if kist_stampe.nome_file > " " then
			kuf1_utility = create kuf_utility
			kist_stampe.nome_file = kuf1_utility.u_stringa_tonome(kist_stampe.nome_file) 
			if isvalid(kuf1_utility) then destroy kuf1_utility
		end if
	end if

	ki_win_titolo_orig  = "Esegui Stampa: " + trim(kist_stampe.titolo)

end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================


super::attiva_tasti_0( )

if dw_print.visible then
	cb_imposta.visible = false
	cb_anteprima.visible = false
	cb_stampa.visible = false
	cb_excel.visible = false
//	cb_ritorna.visible = false
else
	
	cb_imposta.visible = true
	cb_stampa.visible = true
	cb_anteprima.visible = true
	cb_excel.visible = true
//	cb_ritorna.visible = true

	
	//=== Nr righe ne DW lista
	if dw_print.rowcount ( ) > 0 or kist_stampe.tipo = kiuf_stampe.ki_stampa_tipo_dw_rtf then
		cb_imposta.enabled = true
		cb_stampa.enabled = true
		cb_anteprima.enabled = true
		cb_excel.enabled = true
	else
		cb_imposta.enabled = false
		cb_stampa.enabled = false
		cb_anteprima.enabled = false
		cb_excel.enabled = false
	end if

end if


//post set_titolo_window_personalizza()


end subroutine

public subroutine u_resize_1 ();//

	super::u_resize_1()

	if ki_anteprima_on then

		ki_winsaved_x = this.x
		ki_winsaved_y = this.y
		ki_winsaved_w = this.width
		ki_winsaved_h = this.height
		
		This.WindowState = Maximized!

		dw_setup.x = 0
		dw_setup.y = 0
		dw_print.move(0, 0)

		this.dw_print.resize(this.workspacewidth( ) , this.workspaceheight( ) - cb_close_anteprima.height * 2.0 -100)
		this.dw_print.setredraw(true)
		cb_close_anteprima.x = dw_print.x + cb_close_anteprima.width * 0.25
		cb_close_anteprima.y = dw_print.height  + cb_close_anteprima.height / 2
		if ki_custom_on then
			cb_apply_customization.x = cb_close_anteprima.x + cb_close_anteprima.width * 1.25
			cb_apply_customization.y = cb_close_anteprima.y
		end if
		st_preview_zoom.x = dw_print.width - st_preview_zoom.width * 2
		st_preview_zoom.y = cb_close_anteprima.y
		pb_preview_zoom_meno.x = st_preview_zoom.x - pb_preview_zoom_meno.width * 1.5 
		pb_preview_zoom_meno.y = cb_close_anteprima.y + (cb_close_anteprima.height - pb_preview_zoom_meno.height) / 2
		pb_preview_zoom_piu.x = pb_preview_zoom_meno.x - pb_preview_zoom_piu.width * 1.5 
		pb_preview_zoom_piu.y = pb_preview_zoom_meno.y 
		cbx_preview.x = pb_preview_zoom_piu.x - cbx_preview.width * 1.5 
		cbx_preview.y = cb_close_anteprima.y + (cb_close_anteprima.height - cbx_preview.height) / 2

		
	end if
	
	

end subroutine

private subroutine u_setup_personalizzazioni ();//
string k_rc


//--- imposta le personalizzazioni
	if dw_setup.object.cbx_personalizzazioni[1] = "S" then

		kiuf_stampe.kist_stampe_orig.dw_print = dw_originale
		kiuf_stampe.kist_stampe_restore.dw_print = dw_print
		kiuf_stampe.u_dw_personalizza_restore ()
		
	else

//--- copio la dw di stampa
		kiuf_stampe.kist_stampe_orig.dw_print = dw_originale
		kiuf_stampe.kist_stampe_restore.dw_print = dw_print
		kiuf_stampe.u_dw_personalizza_restore ()
		kiuf_stampe.u_dw_personalizza_restore_orig()
			
	end if


end subroutine

public subroutine zoom_set (integer a_zoom);//


	if a_zoom > 0 then
		st_preview_zoom.text = "zoom: " + string(a_zoom) + "%"
		dw_print.modify("DataWindow.Print.Preview.Zoom=" +	String (a_zoom))
	else
		st_preview_zoom.text = "zoom: ---"
	end if
	

end subroutine

private subroutine preview_set (boolean a_set_preview);//

cbx_preview.checked = a_set_preview

if a_set_preview then 

	dw_print.Modify("DataWindow.Print.Preview=yes")
	
else

	dw_print.Modify("DataWindow.Print.Preview=no")

end if

end subroutine

private subroutine crea_report (boolean a_preview);//
int k_zoom


	SetPointer(kkg.pointer_attesa)

	crea_report_setup( )  // compone il report con le personalizzazioni indicate

//--- Zoom della stampa
	k_zoom = dw_setup.object.em_zoom[1]
	if isnull(k_zoom) or k_zoom = 0 then
		k_zoom=100
	end if
	
	if a_preview then

		//k_zoom = dw_print.describe("DataWindow.Print.Preview.Zoom")
		if not ki_zoom_ok &
		    		or kist_stampe.tipo = kiuf_stampe.ki_stampa_tipo_dw_rtf then
			preview_set(false)
			zoom_set(0)
		else
			preview_set(true)
			zoom_set(k_zoom)
		end if
		
	else
		preview_set(false)
		cbx_preview.enabled = false
		dw_print.modify("DataWindow.Zoom=" + string(k_zoom))
	end if


	SetPointer(kkg.pointer_default)

end subroutine

private subroutine crea_report_setup ();//
string k_rcx


	SetPointer(kkg.pointer_attesa)

//--- ripristina la sintassi (composizione) di stampa come in origine
	if isvalid(kist_stampe.dw_print)then
		
		kiuf_stampe.dw_print_restore_orig()
		
	end if
	
//--- pagine in stampa
	if dw_setup.object.rb_pagine[1] = "T" then
		k_rcx=dw_print.modify("DataWindow.Print.Pageinclude.Range=0")
	else
		if trim(dw_setup.object.em_nro[1]) > " " then
			k_rcx=dw_print.modify("DataWindow.Print.Page.Range='" + trim(dw_setup.object.em_nro[1])+"'")	
		end if
	end if

//--- lanscape/portrait
	if dw_setup.object.cbx_landscape[1] = "S" then
		k_rcx=dw_print.modify("DataWindow.Print.orientation = '1'")
	else
		k_rcx=dw_print.modify("DataWindow.Print.orientation = '2'")
	end if

//--- Griglia: 1=assente, 0=visibile	
	if ki_setup_grid_lines = "S" then
		dw_print.Object.DataWindow.Grid.Lines = '0'
	else
		dw_print.Object.DataWindow.Grid.Lines = '1'
	end if

//--- Resize delle righe
	dw_print.Object.DataWindow.Row.Resize='1'

//--- applica personalizzazioni come richiesto	
	u_setup_personalizzazioni( )

	if ki_setup_stampa_testata = "S" then
		aggiungi_testata()
	end if

	SetPointer(kkg.pointer_default)

end subroutine

event u_open;//
//--- Operazioni iniziali di OPEN 
//

		IF IsValid (THIS.MenuID) then			
 			//m_main.autorizza_menu( )
			m_main.u_inizializza( )
			m_main.u_espone_testo_delete(ki_display_delete_key_on_menu)
		end if

//setpointer(kkg.pointer_attesa)

	open_start_window()
	inizializza_lista()
	
	ki_st_open_w.flag_primo_giro = "N"
	
	if ki_exit_si then

		cb_esci.event clicked( )

	else

		ki_winsaved_x = this.x
		ki_winsaved_y = this.y
		ki_winsaved_w = r_dimensione_win.width
		ki_winsaved_h = r_dimensione_win.height
		
		dw_setup.width = r_dimensione_win.width
		dw_setup.insertrow(0)
		
//--- imposta dimensioni della window 
		post event set_window_size()	

		post u_imposta_form( )

		post attiva_tasti()

	end if
				
end event

on w_stampe.create
int iCurrent
call super::create
this.cb_esci=create cb_esci
this.cb_email=create cb_email
this.cb_close_anteprima=create cb_close_anteprima
this.cb_personalizza=create cb_personalizza
this.st_parametri=create st_parametri
this.dw_personalizza=create dw_personalizza
this.cb_excel=create cb_excel
this.cb_anteprima=create cb_anteprima
this.cb_imposta=create cb_imposta
this.cb_stampa=create cb_stampa
this.dw_originale=create dw_originale
this.cb_pdf=create cb_pdf
this.ddplb_stampanti=create ddplb_stampanti
this.dw_crea_xls=create dw_crea_xls
this.cb_printlist=create cb_printlist
this.dw_setup=create dw_setup
this.dw_print=create dw_print
this.st_preview_zoom=create st_preview_zoom
this.pb_preview_zoom_meno=create pb_preview_zoom_meno
this.pb_preview_zoom_piu=create pb_preview_zoom_piu
this.cbx_preview=create cbx_preview
this.cb_apply_customization=create cb_apply_customization
this.r_dimensione_win=create r_dimensione_win
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_esci
this.Control[iCurrent+2]=this.cb_email
this.Control[iCurrent+3]=this.cb_close_anteprima
this.Control[iCurrent+4]=this.cb_personalizza
this.Control[iCurrent+5]=this.st_parametri
this.Control[iCurrent+6]=this.dw_personalizza
this.Control[iCurrent+7]=this.cb_excel
this.Control[iCurrent+8]=this.cb_anteprima
this.Control[iCurrent+9]=this.cb_imposta
this.Control[iCurrent+10]=this.cb_stampa
this.Control[iCurrent+11]=this.dw_originale
this.Control[iCurrent+12]=this.cb_pdf
this.Control[iCurrent+13]=this.ddplb_stampanti
this.Control[iCurrent+14]=this.dw_crea_xls
this.Control[iCurrent+15]=this.cb_printlist
this.Control[iCurrent+16]=this.dw_setup
this.Control[iCurrent+17]=this.dw_print
this.Control[iCurrent+18]=this.st_preview_zoom
this.Control[iCurrent+19]=this.pb_preview_zoom_meno
this.Control[iCurrent+20]=this.pb_preview_zoom_piu
this.Control[iCurrent+21]=this.cbx_preview
this.Control[iCurrent+22]=this.cb_apply_customization
this.Control[iCurrent+23]=this.r_dimensione_win
end on

on w_stampe.destroy
call super::destroy
destroy(this.cb_esci)
destroy(this.cb_email)
destroy(this.cb_close_anteprima)
destroy(this.cb_personalizza)
destroy(this.st_parametri)
destroy(this.dw_personalizza)
destroy(this.cb_excel)
destroy(this.cb_anteprima)
destroy(this.cb_imposta)
destroy(this.cb_stampa)
destroy(this.dw_originale)
destroy(this.cb_pdf)
destroy(this.ddplb_stampanti)
destroy(this.dw_crea_xls)
destroy(this.cb_printlist)
destroy(this.dw_setup)
destroy(this.dw_print)
destroy(this.st_preview_zoom)
destroy(this.pb_preview_zoom_meno)
destroy(this.pb_preview_zoom_piu)
destroy(this.cbx_preview)
destroy(this.cb_apply_customization)
destroy(this.r_dimensione_win)
end on

event closequery;call super::closequery;//
st_profilestring_ini kst_profilestring_ini
//kuf_stampe kiuf_stampe


////--- chiudo solo se no in anteprima
//if dw_print.visible then
//	this.event set_window_size()
//	this.event set_window_size_oggetti()
//	return 1
//else


////=== Puntatore Cursore da attesa.....
//	SetPointer(kkg.pointer_attesa)
if dw_setup.rowcount( ) > 0 then
	
//--- salvo campo personalizzazione 
	kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_scrivi
	kst_profilestring_ini.file = "stampe" 
	kst_profilestring_ini.titolo = "personalizzate" 
	kst_profilestring_ini.nome = trim(dw_print.dataobject) 
	if	dw_setup.object.cbx_personalizzazioni[1] = "S" then
		kst_profilestring_ini.valore = "S"
	else
		kst_profilestring_ini.valore = "N"
	end if
	kGuf_data_base.profilestring_ini(kst_profilestring_ini)


//--- salva Proprieta' PRINT ORIENTATIONE della dw
	kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_scrivi
	kst_profilestring_ini.file = "stampe" 
	kst_profilestring_ini.titolo = "stampe"
	kst_profilestring_ini.nome = "stampe_" + trim(dw_print.dataobject) + "_orientation"
	if	dw_setup.object.cbx_landscape[1] = "S" then
		kst_profilestring_ini.valore = "1"
	else
		kst_profilestring_ini.valore = "0"
	end if
	kGuf_data_base.profilestring_ini(kst_profilestring_ini)
	
//--- salvo campo "salva personalizzazioni"
	kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_scrivi
	kst_profilestring_ini.file = "stampe" 
	kst_profilestring_ini.titolo = "personalizzate_salva" 
	kst_profilestring_ini.nome = trim(dw_print.dataobject) 
	if	dw_setup.object.cbx_personalizzazioni_salva[1] = "S" then
		kst_profilestring_ini.valore = "S"
	else
		kst_profilestring_ini.valore = "N"
	end if
	kGuf_data_base.profilestring_ini(kst_profilestring_ini)
	

//--- recupero i valori se personalizzati della window
	kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_scrivi
	kst_profilestring_ini.file = "stampe" 
	kst_profilestring_ini.titolo = "testata_xls" 
	kst_profilestring_ini.nome = trim(dw_print.dataobject) 
	kst_profilestring_ini.valore = dw_crea_xls.object.testata[1]
	trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	
	
//--- salvo campo "Chiudi a fine stampa"
	kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_scrivi
	kst_profilestring_ini.file = "stampe" 
	kst_profilestring_ini.titolo = "chiudeafine" 
	kst_profilestring_ini.nome = trim(dw_print.dataobject) 
	if	dw_setup.object.cbx_chiude[1] = "S" then
		kst_profilestring_ini.valore = "S"
	else
		kst_profilestring_ini.valore = "N"
	end if
	kGuf_data_base.profilestring_ini(kst_profilestring_ini)

//--- salvo campo "Griglia" tra linee e colonne
	if dw_personalizza.rowcount( ) > 0 then
		ki_setup_grid_lines = dw_personalizza.object.grid[1] 
	end if
	kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_scrivi
	kst_profilestring_ini.file = "stampe" 
	kst_profilestring_ini.titolo = "Grid_Lines" 
	kst_profilestring_ini.nome = trim(dw_print.dataobject) 
	if ki_setup_grid_lines = "S" then
		kst_profilestring_ini.valore = "S"
	else
		kst_profilestring_ini.valore = "N"
	end if
	kGuf_data_base.profilestring_ini(kst_profilestring_ini)
	
//--- salvo campo "stampa dati di testata" 
	if dw_personalizza.rowcount( ) > 0 then
		ki_setup_stampa_testata = dw_personalizza.object.testata[1] 
	end if
	kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_scrivi
	kst_profilestring_ini.file = "stampe" 
	kst_profilestring_ini.titolo = "stampaTestata" 
	kst_profilestring_ini.nome = trim(dw_print.dataobject) 
	if ki_setup_stampa_testata = "S" then
		kst_profilestring_ini.valore = "S"
	else
		kst_profilestring_ini.valore = "N"
	end if
	kGuf_data_base.profilestring_ini(kst_profilestring_ini)

	
//--- richiesto x salva personalizzazioni?	
	if dw_setup.object.cbx_personalizzazioni_salva[1] = "S" then
		if ki_personalizzato_dw then
			
			kiuf_stampe.personalizza_dw_print_save( dw_personalizza, dw_print, dw_originale )
			
		end if
	end if

//	SetPointer(kkg.pointer_default)
	
end if



end event

event close;call super::close;// 

if isvalid(kiuf_stampe) then destroy kiuf_stampe

end event

event open;//
long k_ctr


//--- Recupera i parametri passati con il WITHPARM
	if isvalid(message.powerobjectparm) then 
		ki_st_open_w = message.powerobjectparm
	else
		ki_st_open_w.flag_adatta_win = kkg.adatta_win
		ki_st_open_w.flag_modalita = "" 
	end if
//--- Imposta il flag di Giro di 'prima Volta' x evitare alcuni controlli 
	ki_st_open_w.flag_primo_giro = "S"

	if ki_st_open_w.st_tab_menu_window.salva_controlli = "S" then
		ki_salva_controlli = true
	end if

	ki_nome_save = trim(this.ClassName())

//--- Importante: personalizzazione x i figli	
	event u_open_preliminari()   

//--- assegna il puntatore alla Window x renderlo visibile negli script
	kiw_this_window = this
	kGuo_g.kgw_attiva = this
	
//--- setta la directory di base
	kGuf_data_base.setta_path_default ()

//--- setta il titolo della window
	set_titolo_window()

//--- oggetto utile alla sincronizzazione con una window chiamata, es canc di una riga dall'elenco
	kiuf1_sync_window = create kuf_sync_window

//---- oggetto generico 
	kiuf_parent = create kuf_parent

	setpointer(kkg.pointer_attesa)

//--- altre operazioni
	post event u_open( )
	post attiva_tasti( )


end event

type dw_print_0 from w_g_tab`dw_print_0 within w_stampe
end type

type st_ritorna from w_g_tab`st_ritorna within w_stampe
end type

type st_ordina_lista from w_g_tab`st_ordina_lista within w_stampe
end type

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_stampe
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_stampe
end type

type st_stampa from w_g_tab`st_stampa within w_stampe
end type

type cb_esci from commandbutton within w_stampe
integer x = 709
integer y = 1332
integer width = 393
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "&Chiudi"
boolean flatstyle = true
end type

event clicked;//
close(parent)

end event

type cb_email from commandbutton within w_stampe
integer x = 709
integer y = 1216
integer width = 393
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "&Email"
boolean flatstyle = true
end type

event clicked;//
string k_email, k_body, k_subject, k_attach
long k_id_stampa
int k_msg_rc = 2, k_rc
string k_path, k_nome_file, k_pathnomefile
kuf_file_explorer kuf1_file_explorer
kuf_utility kuf1_utility
n_cst_outlook kn1_cst_outlook
st_esito kst_esito


try

	SetPointer(kkg.pointer_attesa)

//=== Disabilito il tasto x evitare ridondanze
	this.enabled = false

//--- applica o meno le personalizzazioni alla stampa
	crea_report(false)

	SetPointer(kkg.pointer_attesa)

	kn1_cst_outlook = create n_cst_outlook
	kuf1_utility = create kuf_utility
	kn1_cst_outlook = create n_cst_outlook
	kuf1_file_explorer = create kuf_file_explorer


//--- imposta il nome per il file
	k_path = kiuf_stampe.get_path_tempemail( ) 
	k_pathnomefile = kist_stampe.nome_file
		
	k_rc = GetFileSaveName ( "Scegliere dove salvare il file pdf", k_pathnomefile, k_nome_file,  "pdf",  "pdf (*.pdf),*.*", k_path, 32770 )
	if k_rc = 1 then
		if trim(k_nome_file) > " " then
			SetPointer(kkg.pointer_attesa)
			if right(trim(k_nome_file),4) = ".pdf" then k_nome_file = left(k_nome_file, len(trim(k_nome_file)) - 4) // toglie eventuale .pdf
			dw_print.Object.DataWindow.Export.PDF.Method = NativePDF!
			k_id_stampa = dw_print.saveas(k_pathnomefile,PDF!, false) 
	
			if k_id_stampa < 1 then
				SetPointer(kkg.pointer_default)
				messagebox("Operazione non eseguita", "Allegato pdf all'email non generato (errore: " + string(k_id_stampa) + ") " )
			else
				SetPointer(kkg.pointer_default)
				k_msg_rc = messagebox("Documento generato",  "Vuoi aprire il documento '" + k_nome_file + "' allegato all'email~n~r(" + k_pathnomefile + ")", Question!, yesnocancel!, 2) 
				if k_msg_rc = 1 then
					SetPointer(kkg.pointer_attesa)
					kuf1_file_explorer.of_execute(trim(k_pathnomefile))
				end if
			end if

//--- Invio email con programma predefinito
			if k_id_stampa > 0 then
				if k_msg_rc <> 3 then
					
				k_attach = trim(k_path + k_nome_file)
				k_subject = "Invio per posta elettronica:" + k_nome_file
				k_body = "~n~rIl messaggio è pronto per essere inviato con il seguente file allegato:~n~r" + k_nome_file
				
				kn1_cst_outlook.of_create_email1(k_attach, "", k_subject, k_body)
		//--- DBG queste righe che seguono solo solo per test visto che non ho outlook						
		//		kuf1_file_explorer.of_email(k_email, "", k_subject, k_body, k_attach)
						
				end if
			end if
		end if
	end if
	
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kst_esito.SQLErrText = "Errore in esecuzione stampa via email~n~r" + trim(kst_esito.SQLErrText)
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception
	
	
finally

//--- Ripristina path di lavoro
	kGuf_data_base.setta_path_default()
	
	if isvalid(kuf1_utility) then destroy kuf1_utility
	if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
	if isvalid(kn1_cst_outlook) then destroy kn1_cst_outlook
	this.enabled = true
		
	
end try
			



end event

type cb_close_anteprima from commandbutton within w_stampe
boolean visible = false
integer x = 640
integer y = 1496
integer width = 709
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string pointer = "HyperLink!"
string text = "&Chiudi _________"
boolean flatstyle = true
end type

event clicked;//
//--- chiudo solo anteprima
	parent.event set_window_size()
	parent.event u_preview_show_display(false)
	dw_personalizza.visible = false
	
end event

type cb_personalizza from commandbutton within w_stampe
integer x = 165
integer y = 1332
integer width = 393
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
string pointer = "HyperLink!"
string text = "&Personalizza"
boolean flatstyle = true
end type

event clicked;//
//--- 
//
	this.enabled = false

//--- esegue l'anteprima		
	parent.event u_preview_custom()
	dw_personalizza.event u_personalizza_start()
	
	attiva_tasti()
	
	this.enabled = true

end event

type st_parametri from statictext within w_stampe
boolean visible = false
integer x = 992
integer y = 1392
integer width = 466
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "none"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_personalizza from datawindow within w_stampe
event rbuttonup pbm_dwnrbuttonup
event u_personalizza_start ( )
event ue_keydwn pbm_dwnkey
event u_set_grid_lines ( string a_attiva )
event u_set_stampa_testata ( string a_attiva )
boolean visible = false
integer x = 1650
integer y = 8
integer width = 1710
integer height = 1056
integer taborder = 120
boolean bringtotop = true
boolean titlebar = true
string title = "Mostra o Nascondi colonne in stampa"
string dataobject = "d_pers_st_campi"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean border = false
string icon = "UserObject5!"
boolean livescroll = true
end type

event rbuttonup;//
	parent.triggerevent("rbuttonup")
//	return 1

end event

event u_personalizza_start();//


	SetPointer(kkg.pointer_attesa)

	this.reset()
	
	kiuf_stampe.personalizza_dw_print (dw_print, dw_personalizza)

	event u_set_grid_lines(ki_setup_grid_lines)
	event u_set_stampa_testata(ki_setup_stampa_testata)

	dw_print.setredraw( true )
	dw_print.enabled = true
//	this.Resize(dw_print.width*0.35, dw_print.Height*0.70)
//	this.Modify("nome_testata.Width='"+ String(this.width - 100) +"' ")

	this.height = dw_print.Height *0.90
	this.x = dw_print.width * 0.70 
	this.y = 10 //((dw_print.Height - dw_personalizza.Height)*0.50)

	this.enabled = true
	this.visible = true
	this.BringToTop = TRUE
	this.setfocus()
	
	SetPointer(kkg.pointer_default)




end event

event ue_keydwn;//
//=== Controllo quale tasto da tastiera ha premuto


if keydown(KeyAdd!) then

	zoom_avanti()

else
if keydown(KeySubtract!) then

	zoom_indietro()

else
if keydown(keyescape!) then
	if cb_close_anteprima.visible then
		cb_close_anteprima.event clicked( )
	end if
//	close(parent)

else
if keydown(keyPageDown!) and	dw_print.visible = true then

	this.scrollnextpage ( )

else
if keydown(keyPageUp!) and	dw_print.visible = true then

	this.scrollpriorpage ( )

end if
end if
end if
end if
end if


end event

event u_set_grid_lines(string a_attiva);//
//--- escamotage per impostare il flag 'unico' di presenza del grid.lines 
//
int k_ind


	ki_setup_grid_lines = a_attiva

	for k_ind = 1 to this.rowcount( )
		this.object.grid[k_ind] = ki_setup_grid_lines
	next

end event

event u_set_stampa_testata(string a_attiva);//
//--- escamotage per impostare il flag 'unico' di presenza del grid.lines 
//
int k_ind


	ki_setup_stampa_testata = a_attiva

	for k_ind = 1 to this.rowcount( )
		this.object.testata[k_ind] = ki_setup_stampa_testata
	next

end event

event buttonclicked;//

//--- applico personalizzazioni
//	ki_personalizzato_dw = true

	if String(dwo.name)= "cb_rirpistina" then
		kiuf_stampe.kist_stampe_orig.dw_print = dw_originale
		kiuf_stampe.personalizza_dw_print_ripri( )
		kiuf_stampe.kist_stampe_orig.dw_print = dw_originale
		kiuf_stampe.kist_stampe_restore.dw_print = dw_print
		kiuf_stampe.u_dw_personalizza_restore ( )
		this.object.grid[1] = ki_setup_grid_lines
		this.object.testata[1] = ki_setup_stampa_testata
	end if

//	crea_report_setup()

end event

event clicked;//

if dwo.name = "grid" then
	
	if ki_setup_grid_lines = "S" then
		ki_setup_grid_lines = "N"
	else
		ki_setup_grid_lines = "S"
	end if		
	
	event u_set_grid_lines( ki_setup_grid_lines )
else	

	if dwo.name = "testata" then
		
		if ki_setup_stampa_testata = "S" then
			ki_setup_stampa_testata = "N"
		else
			ki_setup_stampa_testata = "S"
		end if		
		
		event u_set_stampa_testata( ki_setup_stampa_testata )
		
	end if		
end if
end event

type cb_excel from commandbutton within w_stampe
integer x = 709
integer y = 984
integer width = 393
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
string pointer = "HyperLink!"
string text = "Crea &XLS..."
boolean flatstyle = true
end type

event clicked;//

//--- Disabilito il tasto x evitare ridondanze
this.enabled = false


if len(trim(dw_crea_xls.object.nome_scheda[1])) = 0 then
	dw_crea_xls.object.nome_scheda[1] = kist_stampe.nome_file + string(kguo_g.get_datetime_current( ), "_dd_mm_hh_mm")
end if

if len(trim(dw_crea_xls.object.testata[1])) = 0 then
	dw_crea_xls.object.testata[1] = kist_stampe.testata_xls
end if	

if not dw_crea_xls.visible then
	dw_crea_xls.x = (parent.width - dw_crea_xls.width) / 2.3
	dw_crea_xls.y = (parent.height - dw_crea_xls.height ) / 2.5
	dw_crea_xls.visible = true
end if

this.enabled = true

end event

type cb_anteprima from commandbutton within w_stampe
integer x = 165
integer y = 1216
integer width = 393
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "&Anteprima"
boolean default = true
boolean flatstyle = true
end type

event clicked;//
//--- 
//
	this.enabled = false

//--- esegue l'anteprima		
	parent.event u_preview_only()
	attiva_tasti()
	
	this.enabled = true
	
end event

type cb_imposta from commandbutton within w_stampe
integer x = 165
integer y = 984
integer width = 393
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "S&tampante..."
boolean flatstyle = true
end type

event clicked;//
int k_idx 
pointer kpointer_1

kpointer_1 = setPointer(HourGlass!)

printsetup()

k_idx = ddplb_stampanti.FindItem ( trim(dw_print.object.datawindow.printer), 0 )
if k_idx > 0 then
	ddplb_stampanti.text = ddplb_stampanti.text( k_idx )
	
end if

SetPointer(kpointer_1)

end event

type cb_stampa from commandbutton within w_stampe
integer x = 165
integer y = 1100
integer width = 393
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "&Stampa"
boolean flatstyle = true
end type

event clicked;//
string k_ret, k_zoom_orig, k_scelta, k_rc
long k_id_stampa
int k_rc_print
pointer oldpointer  // Declares a pointer variable



//--- Disabilito il tasto x evitare ridondanze
	this.enabled = false

	SetPointer(kkg.pointer_attesa )

	k_zoom_orig=dw_print.describe("DataWindow.Zoom")			

//--- applica o meno le personalizzazioni alla stampa
	crea_report(false)

	k_ret=dw_print.modify("DataWindow.DocumentName='" + trim(dw_print.title)+"'")	

//=== Puntatore Cursore da attesa.....
	SetPointer(HourGlass!)
	
	k_rc_print = dw_print.print()

//--- chiude la window se tutto ok	e se richiesto dal cbx
	if k_rc_print > 0 and dw_setup.object.cbx_chiude[1] = "S" then
		
		sleep(1)
		if isvalid(cb_esci) then
			cb_esci.POST event clicked( )
		end if
//			close(parent)
	else
		
		dw_print.modify("DataWindow.Zoom="+k_zoom_orig)			
		
		attiva_tasti()

		if isvalid(kiw_this_window) then
			kiw_this_window.setfocus( )
		end if

		this.enabled = true
		
	end if
	
//	end if



end event

type dw_originale from datawindow within w_stampe
boolean visible = false
integer x = 110
integer y = 1960
integer width = 439
integer height = 284
boolean bringtotop = true
boolean enabled = false
string title = "DW pasata originalmente senza Personalizzazioni"
string dataobject = "d_nulla"
string icon = "Exclamation!"
end type

type cb_pdf from commandbutton within w_stampe
integer x = 709
integer y = 1100
integer width = 393
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "crea &PDF"
boolean flatstyle = true
end type

event clicked;//
long k_id_stampa
string k_pathnomefile="",k_path, k_nome_file, k_zoom_orig, k_printer_orig, k_printer_new
int k_rc
kuf_file_explorer kuf1_file_explorer
kuf_utility kuf1_utility


//--- Disabilito il tasto x evitare ridondanze
	this.enabled = false

	SetPointer(kkg.pointer_attesa )

	k_zoom_orig=dw_print.describe("DataWindow.Zoom")			

//--- applica o meno le personalizzazioni alla stampa
	crea_report(false)

//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa )
	
	if dw_print.rowcount( ) = 0 then
		messagebox("PDF non generato", "Nessun dato da stampare" )
	else		

//--- imposta il nome per il file
		k_path = kguf_data_base.profilestring_leggi_scrivi(kguf_data_base.ki_profilestring_operazione_leggi, kiw_this_window.classname( ) + "_utlimosaveas", "")
		k_pathnomefile = kist_stampe.nome_file
		
			
		k_rc = GetFileSaveName ( "Scegliere dove salvare il file pdf", k_pathnomefile, k_nome_file,  "pdf",  "pdf (*.pdf),*.*", k_path, 32770 )
		if k_rc = 1 then
			if trim(k_nome_file) > " " then
				SetPointer(kkg.pointer_attesa)
				if right(trim(k_nome_file),4) = ".pdf" then k_nome_file = left(k_nome_file, len(trim(k_nome_file)) - 4) // toglie eventuale .pdf
				dw_print.Object.DataWindow.Export.PDF.Method = NativePDF!
				dw_print.Object.DataWindow.Export.PDF.NativePDF.ImageFormat = '2' 				
				k_id_stampa = dw_print.saveas(k_pathnomefile,PDF!, false) 
				SetPointer(kkg.pointer_default)
			else
				k_id_stampa = -99
			end if
		
		
			if k_id_stampa < 1 then
				SetPointer(kkg.pointer_default)
				messagebox("PDF non generato", "Esportazione dati in PDF fallita (err=" + string(k_id_stampa) + ")" ) // (stampante: " + ki_stampante_pdf + ") " )
			else
				
				kuf1_utility = create kuf_utility
				kguf_data_base.profilestring_leggi_scrivi(kguf_data_base.ki_profilestring_operazione_scrivi, kiw_this_window.classname( ) + "_utlimosaveas" &
											, kuf1_utility.u_get_path_file(k_pathnomefile))
				if isvalid(kuf1_utility) then destroy kuf1_utility
				
				kist_stampe.nome_file = k_nome_file
				SetPointer(kkg.pointer_default)
				if messagebox("Operazione terminata correttamente",  "Vuoi aprire subito il file '" + trim(k_nome_file) + "'~n~r( " + k_pathnomefile + ")", Question!, yesno!, 1) = 1 then
					SetPointer(kkg.pointer_attesa)
					kuf1_file_explorer = create kuf_file_explorer
					kuf1_file_explorer.of_execute(trim(k_pathnomefile))
					destroy kuf1_file_explorer
				end if
			end if
		end if
	end if

//--- Ripristina path di lavoro
	kGuf_data_base.setta_path_default()

//--- chiude la window se tutto ok	e se richiesto dal cbx
//	if k_id_stampa > 0 and cbx_chiude.checked then
//		
//		//cb_esci.event clicked( )
//		if isvalid(cb_esci) then
//			cb_esci.event clicked( )
//		else
//			this.enabled = true
//		end if
//	else
		dw_print.modify("DataWindow.Zoom="+k_zoom_orig)			
		this.enabled = true
//	end if



end event

type ddplb_stampanti from dropdownpicturelistbox within w_stampe
integer x = 165
integer y = 856
integer width = 1125
integer height = 736
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean border = false
boolean sorted = false
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
long picturemaskcolor = 536870912
end type

event selectionchanged;//
dw_print.object.datawindow.printer = trim(ddplb_stampanti.text( index ) )


end event

type dw_crea_xls from datawindow within w_stampe
boolean visible = false
integer x = 1499
integer y = 528
integer width = 1143
integer height = 668
integer taborder = 130
boolean bringtotop = true
boolean titlebar = true
string title = "Esporta in formato xls"
string dataobject = "d_param_xls"
boolean controlmenu = true
boolean border = false
end type

event buttonclicked;//
long k_id_stampa, k_rc
string k_path="",k_nome_file, k_rcx="",k_path_init="", k_setup_stampa_testata
st_profilestring_ini kst_profilestring_ini
kuf_utility kuf1_utility
kuf_file_explorer kuf1_file_explorer
datastore kds_1 


//=== Puntatore Cursore da attesa.....
SetPointer(kkg.pointer_attesa)

if dwo.name = "b_esporta" then
	
	this.modify(dwo.name + ".enabled = '0'")  // disbilita pulsante

//--- applica o meno le personalizzazioni alla stampa
	k_setup_stampa_testata = ki_setup_stampa_testata
	if dw_crea_xls.object.testata[1] = "S" then //non si vuole EVITARE la testata
		ki_setup_stampa_testata = "S"
	else
		ki_setup_stampa_testata = "N"
	end if
	crea_report(false)
	ki_setup_stampa_testata = k_setup_stampa_testata

//=== Scelgo file x Esportare i dati DW
	kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi
	kst_profilestring_ini.file = "ambiente" 
	kst_profilestring_ini.titolo = "ambiente" 
	kst_profilestring_ini.nome = "arch_export_xls"
	kst_profilestring_ini.valore = " " 
	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	k_nome_file = trim(kst_profilestring_ini.valore)
	if Len(k_nome_file) > 0 then
		k_rcx = k_nome_file
		k_rc = Len(k_rcx)
		do while Mid(k_rcx, k_rc, 1) <> "\" and k_rc > 1
			k_rcx = Replace(k_rcx, k_rc, 1, " ")  
			k_rc= k_rc - 1
		loop
		k_path_init = trim(k_rcx)
	end if

	k_path=kist_stampe.nome_file
	
	k_id_stampa = GetFileSaveName("Esporta file in formato EXCEL/CALC", &
										k_path, k_nome_file, "xls", "Excel (*.xls),*.xls",k_path_init, 32770) 
	
	if k_id_stampa <= 0 or LenA(trim(k_nome_file)) = 0 then
		k_path = " "
//		kst_esito.esito = kkg_esito.NO_ESECUZIONE
//		kst_esito.sqlcode = 0
//		kst_esito.SQLErrText = "Elaborazione interrotta dall'utente" 
		
	else
		n_dwr_service_parm kn_dwr_service_parm
		kn_dwr_service_parm = create  n_dwr_service_parm
//   k_path = trim(profilestring ( "confdb.ini", "ambiente", "arch_export", "stampa"))
//   k_nome_file = trim(mid(parent.title,9,8)) + string(today(), "ddmmyy")
//	trim(kist_stampe.dataobject)

//	k_path=""
//	k_id_stampa = dw_print.saveas(k_path ,Excel5!, true)

		if len(trim(dw_crea_xls.object.nome_scheda[1])) > 0 then
//			kuf1_utility = create kuf_utility
//			dw_crea_xls.object.nome_scheda[1] = kuf1_utility.u_stringa_pulisci(dw_crea_xls.object.nome_scheda[1])
//			destroy kuf1_utility
		else
			dw_crea_xls.object.nome_scheda[1] = string(kguo_g.get_datetime_current( ) , "dd_mm_hh_mm")
		end if
		
#if defined PBNATIVE then		
		kn_dwr_service_parm.is_sheet_name = dw_crea_xls.object.nome_scheda[1]
		kn_dwr_service_parm.il_title_fg_color = kkg_colore.blu_chiaro
		kn_dwr_service_parm.ib_background = false
		kn_dwr_service_parm.ib_background_color = false
		kn_dwr_service_parm.ib_group_header = false   //skip all group headers 
		kn_dwr_service_parm.ib_group_trailer = false  //skip all group trailers 
		kn_dwr_service_parm.ib_summary = false        //skip summary band 
		kn_dwr_service_parm.ib_footer = false         //skip footer band 

//--- se richiesto Testata esporta il dw_print
		if dw_crea_xls.object.testata[1] = "S" then //Stampa anche la testata
			kn_dwr_service_parm.ib_header = true         //skip header band 
//			k_id_stampa = uf_save_dw_as_excel_parm(dw_print, k_path, kn_dwr_service_parm)  //esportazione in EXCEL attraverso prodotto di terzi
		else
			kn_dwr_service_parm.ib_header = false         //skip header band 
//			k_id_stampa = uf_save_dw_as_excel_parm(dw_esporta, k_path, kn_dwr_service_parm)  //esportazione in EXCEL attraverso prodotto di terzi
		end if

		kds_1 = create datastore

//--- se non indicata nessuna dw_esporta allora la faccio uguale alla dw_print
		if isvalid(kist_stampe.ds_esporta) then
			if trim(kist_stampe.ds_esporta.dataobject) > " " then
				kds_1.dataobject = kist_stampe.ds_esporta.dataobject
				k_rc = kist_stampe.ds_esporta.rowscopy(1, kist_stampe.ds_esporta.rowcount( ) ,primary!, kds_1 ,1, primary!)
			end if
		end if
		if trim(kds_1.dataobject) > " "  then
		else
			kds_1.dataobject = dw_print.dataobject
			k_rc = dw_print.rowscopy(1, dw_print.rowcount( ) ,primary!, kds_1 ,1, primary!)
		end if
		
		if kds_1.rowcount() > 0 then
			k_rcx = kds_1.Modify(kiuf_stampe.u_dw_sintax_pulizia(kds_1.describe("DataWindow.Syntax")))
//--- esportazione in EXCEL attraverso prodotto di terzi			
			k_id_stampa = uf_save_ds_as_excel_parm(kds_1, k_path, kn_dwr_service_parm)  
			if k_id_stampa < 1 then
				SetPointer(kkg.pointer_default)
				messagebox("Operazione in anomalia", string(kds_1.rowcount()) + " righe non esportate")
			end if
		else
			SetPointer(kkg.pointer_default)
			messagebox("Operazione non eseguita", "Non ci sono dati da esportare")
			k_id_stampa = 0
		end if
		
		
		if isvalid(kn_dwr_service_parm) then destroy kn_dwr_service_parm
#end if
	end if


	if k_id_stampa > 0 then

		kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_scrivi
		kst_profilestring_ini.file = "ambiente" 
		kst_profilestring_ini.titolo = "ambiente" 
		kst_profilestring_ini.nome = "arch_export_xls"
		kst_profilestring_ini.valore = trim(k_path) 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		
		SetPointer(kkg.pointer_default)
		if messagebox("Operazione terminata correttamente",  "Vuoi aprire subito il file~n~r" + trim(k_path), Question!, yesno!, 1) = 1 then
			SetPointer(kkg.pointer_attesa)
			kuf1_file_explorer = create kuf_file_explorer
			kuf1_file_explorer.of_execute( trim(k_path))
			destroy kuf1_file_explorer
		end if
					
	end if

//--- Ripristina path di lavoro
	kGuf_data_base.setta_path_default()

//--- chiude la window se tutto ok	e se richiesto dal cbx
//	if isvalid(cbx_chiude ) then
		
//		if k_id_stampa > 0 and cbx_chiude.checked then
//			
//			if isvalid(cb_esci) then
//				cb_esci.event clicked( )
//			end if
//		else
			if isvalid(kiw_this_window) then
				
				this.visible = false // Nasconde la finestra
				this.modify(dwo.name + ".enabled = '1'")  // Riabilita il pulsante

				kiw_this_window.setfocus( )
			end if
//		end if
//	end if

end if

end event

type cb_printlist from picturebutton within w_stampe
integer x = 37
integer y = 856
integer width = 119
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean flatstyle = true
string picturename = "Print!"
alignment htextalign = left!
boolean map3dcolors = true
string powertiptext = "Trova le stampanti disponibili"
long backcolor = 16711935
end type

event clicked;//
//--- legge le stampanti definitive
kiuf_stampe.get_stampanti( )
kiuf_stampe.ddlb_set_stampanti(ddplb_stampanti)

end event

type dw_setup from datawindow within w_stampe
boolean visible = false
integer width = 1335
integer height = 820
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_stampe_setup"
boolean border = false
boolean livescroll = true
end type

type dw_print from datawindow within w_stampe
event ue_keydwn pbm_dwnkey
event rbuttonup pbm_rbuttonup
event u_lbuttondown pbm_lbuttondown
event u_lbuttonup pbm_lbuttonup
string tag = "serve x stampare i dati"
boolean visible = false
integer x = 1120
integer y = 1208
integer width = 1312
integer height = 968
boolean bringtotop = true
string title = "Anteprima"
string dataobject = "d_nulla"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event ue_keydwn;//
//=== Controllo quale tasto da tastiera ha premuto


if keydown(keyenter!) or keydown(KeyAdd!) then

	zoom_avanti()

else
if keydown(KeySubtract!) then

	zoom_indietro()

else
if keydown(keyescape!) then
	if cb_close_anteprima.visible then
		cb_close_anteprima.event clicked( )
	end if
	//close(parent)

else
if keydown(keyPageDown!) and	dw_print.visible = true then

	this.scrollnextpage ( )

else
if keydown(keyPageUp!) and	dw_print.visible = true then

	this.scrollpriorpage ( )

end if
end if
end if
end if
end if


end event

event rbuttonup;//
	parent.triggerevent("rbuttonup")

end event

event u_lbuttondown;//
ki_ridimensiona_colonna = true
ki_ridimensione_x=xpos
ki_ridimensione_y=ypos

end event

event u_lbuttonup;//

if ki_ridimensiona_colonna then

	ki_ridimensiona_colonna = false
	if ki_ridimensione_x <> xpos or ki_ridimensione_y <> ypos then
		ki_personalizzato_dw = true
	end if

end if
end event

event dberror;//
st_esito kst_esito

CHOOSE CASE sqldbcode

	CASE -01,-02 
		MessageBox("Problemi sul DataBase",  &
			"Collegamento con il DataBase fallito.~n~r" &
			+ "Prego, provare a fare File-Apri DB dal menu")

	CASE -04
		MessageBox("Altri Utenti su questi dati",  &
			"Dati non piu' congruenti.~n~r" &
			+ "Modificati, poco fa, da altro utente !!")

END CHOOSE


kst_esito.esito = kkg_esito.db_ko
kst_esito.sqlcode = sqlca.sqlcode
kst_esito.sqlerrtext = "Errore DB: " + SQLErrText &
								+ ", Query: " + SQLsyntax &
								+ ", Utente: " + kguo_utente.get_codice()
kguo_exception.scrivi_log(kst_esito)


RETURN 1 // Do not display system error message

end event

event retrievestart;//
//=== Per evitare che ad ogni nuova Retrieve cancelli la vecchia 
return 2


end event

type st_preview_zoom from statictext within w_stampe
integer x = 2007
integer y = 1340
integer width = 526
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "zoom: 100%"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pb_preview_zoom_meno from picturebutton within w_stampe
integer x = 1728
integer y = 1316
integer width = 128
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "zoommeno.png"
end type

event clicked;//
	zoom_indietro()
	

end event

type pb_preview_zoom_piu from picturebutton within w_stampe
integer x = 1582
integer y = 1320
integer width = 128
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "zoompiu.png"
end type

event clicked;//
	zoom_avanti()

end event

type cbx_preview from checkbox within w_stampe
boolean visible = false
integer x = 1719
integer y = 1476
integer width = 887
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "mostra come in stampa"
end type

event clicked;//
	preview_set(this.checked)
end event

type cb_apply_customization from commandbutton within w_stampe
boolean visible = false
integer x = 1335
integer y = 1496
integer width = 951
integer height = 104
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string pointer = "HyperLink!"
string text = "&Applica modifiche"
boolean flatstyle = true
end type

event clicked;//
	SetPointer(kkg.pointer_attesa)

	this.enabled = false
	
//--- applico personalizzazioni
	ki_personalizzato_dw = true

	dw_setup.object.cbx_personalizzazioni[1] = "S"
	kiuf_stampe.personalizza_dw_print_save( dw_personalizza, dw_print, dw_originale )
	kiuf_stampe.kist_stampe_orig.dw_print = dw_originale
	kiuf_stampe.kist_stampe_restore.dw_print = dw_print
	kiuf_stampe.u_dw_personalizza_restore ( )

	crea_report_setup()

	this.enabled = true

	SetPointer(kkg.pointer_default)

end event

type r_dimensione_win from rectangle within w_stampe
boolean visible = false
linestyle linestyle = transparent!
integer linethickness = 4
long fillcolor = 255
integer width = 1413
integer height = 1628
end type

