$PBExportHeader$uo_g_tab_elenco_tabpage_web.sru
forward
global type uo_g_tab_elenco_tabpage_web from userobject
end type
type wb_1 from uo_webbrowser within uo_g_tab_elenco_tabpage_web
end type
end forward

global type uo_g_tab_elenco_tabpage_web from userobject
boolean visible = false
integer width = 1883
integer height = 940
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event resize ( long a_w,  long a_h )
wb_1 wb_1
end type
global uo_g_tab_elenco_tabpage_web uo_g_tab_elenco_tabpage_web

type variables
//
private uo_ds_std_1 kids_elenco
public st_open_w kist_open_w	
private boolean ki_conferma=false, ki_disattiva_exit=false, ki_u_ricevi_da_elenco_in_esec=false
//private kuf_utility kiuf_utility
public tab kitab_1
end variables

forward prototypes
public subroutine u_zoom_meno ()
public subroutine u_zoom_off ()
public subroutine u_zoom_piu ()
public subroutine u_esegui_funzione (string a_flag_modalita)
private subroutine attiva_drag_drop (uo_d_std_1 adw_1)
private function boolean u_attiva_evento_in_win_origine ()
public subroutine set_ki_conferma (boolean a_conferma)
public subroutine u_resize (long a_width, long a_height)
public subroutine set_wb_1_visible (boolean a_visible)
public subroutine set_wb_1_enabled (boolean a_enabled)
public function string inizializza () throws uo_exception
public function boolean u_refresh ()
end prototypes

event resize(long a_w, long a_h);//
u_resize(a_w, a_h)
end event

public subroutine u_zoom_meno ();////
////--- diminuisce 
////
//int k_zoom
//
//
//	k_zoom = integer(dw_1.Object.DataWindow.Print.Preview.Zoom)
//	if k_zoom < 11 then
//		k_zoom = 100
//	else
//		k_zoom -= 10
//	end if
//	if k_zoom = 100 then
//		dw_1.Object.DataWindow.Print.Preview = "No"
//	else
//		dw_1.Object.DataWindow.Print.Preview = "Yes"
//	end if
//	dw_1.Object.DataWindow.Print.Preview.Zoom = k_zoom
//	dw_1.SetRedraw(TRUE)
//
end subroutine

public subroutine u_zoom_off ();////
////--- diminuisce 
////
//	dw_1.Object.DataWindow.Print.Preview = "No"
//	dw_1.Object.DataWindow.Print.Preview.Zoom = 100
//	dw_1.SetRedraw(TRUE)
//
end subroutine

public subroutine u_zoom_piu ();//
//--- ingrandisce 
//
//int k_zoom
//
//	k_zoom = integer(dw_1.Object.DataWindow.Print.Preview.Zoom)
//	if k_zoom > 1000 then
//		k_zoom = 100
//	else
//		k_zoom += 10
//	end if
//	if k_zoom = 100 then
//		dw_1.Object.DataWindow.Print.Preview = "No"
//	else
//		dw_1.Object.DataWindow.Print.Preview = "Yes"
//	//	adw_1.Object.DataWindow.Print.Margin.Bottom = '0'
//	//	adw_1.Object.DataWindow.Print.Margin.Left = '0'
//	//	adw_1.Object.DataWindow.Print.Margin.Right = '0'
//	//	adw_1.Object.DataWindow.Print.Margin.Top = '0'
//	//	adw_1.Object.DataWindow.Print.paper.source = '0'
//	end if
//	dw_1.Object.DataWindow.Print.Preview.Zoom = k_zoom
//	dw_1.SetRedraw(TRUE)

end subroutine

public subroutine u_esegui_funzione (string a_flag_modalita);////
//st_open_w kst_open_w
//datastore kds_1
//
//
//try
//
//	kds_1 = create datastore
//	kds_1.dataobject = dw_1.dataobject
//
//	if dw_1.rowcount( ) > 0 then
//		if dw_1.getrow( ) = 0 then dw_1.setrow(1) 
//		dw_1.rowscopy( dw_1.getrow( ) , dw_1.getrow( ), primary!, kds_1, 1, primary!)
//	end if
//	
//	kGuf_menu_window.open_w_tabelle_da_ds(kds_1, a_flag_modalita)
//		
//
//catch (uo_exception kuo_exception)
//	kuo_exception.messaggio_utente()
//	
//end try
end subroutine

private subroutine attiva_drag_drop (uo_d_std_1 adw_1);////
//if dw_1.u_get_tipo() = dw_1.kki_tipo_processing_grid then
//	dw_1.ki_attiva_dragdrop = true
//else
//	dw_1.ki_attiva_dragdrop = false
//end if
end subroutine

private function boolean u_attiva_evento_in_win_origine ();////
////--- Call Windows chiamante event: "u_ricevi_da_elenco"
////---
////--- rit.: TRUE se evento chiamato
////---
//boolean k_return
//long k_riga=0, k_riga_ins=0, k_righe
//int k_errore, k_rc
//string k_key
//
//
////--- imposta gli oggetti standard
////	setta_oggetti()
//
//
////=== Valorizza l'oggetto DATASTORE per ritorno dei valori 
//	if isvalid(kids_elenco) then destroy kids_elenco 
//	kids_elenco = create uo_ds_std_1 //create datastore
//	kids_elenco.dataobject = dw_1.dataobject
//	kids_elenco.reset( )
//	
////--- copia solo i record selezionati	
//	k_riga = dw_1.getselectedrow(0)
//	do while k_riga > 0
//		
//		k_riga_ins++
//		if dw_1.rowscopy(k_riga, k_riga, primary!, kids_elenco, k_riga_ins, primary!) > 0 then // copia la riga SELECTED
//			kids_elenco.selectrow( k_riga_ins,true) // anche qui la rende SELECTED (solo x mantenere la vecchia compatibilità)
//		end if
//			
//		kist_open_w.key12_any = kids_elenco
//		kist_open_w.key3 = string(k_riga_ins) //"1"
//		
//		if not isnull(kist_open_w.key10_window_chiamante) then
//			
//			if isvalid(kist_open_w.key10_window_chiamante) and not ki_u_ricevi_da_elenco_in_esec then
//				ki_u_ricevi_da_elenco_in_esec = true
//				if kist_open_w.key10_window_chiamante.event u_ricevi_da_elenco (kist_open_w) > 0 then
//					k_return = true
//					//kist_open_w.key10_window_chiamante.post setfocus( )
//				end if
//				ki_u_ricevi_da_elenco_in_esec = false
//			end if
//			
//		end if
//		
//		k_riga = dw_1.getselectedrow(k_riga) // cerca la successiva selezionata
//		
//	loop
//	
//	if k_return	then
//		kist_open_w.key10_window_chiamante.post setfocus( )
//	end if
//	
//return k_return	
return false
end function

public subroutine set_ki_conferma (boolean a_conferma);//
ki_conferma = a_conferma
end subroutine

public subroutine u_resize (long a_width, long a_height);//
//	constant int kk_barra_width = 0 //1
//	constant int kk_barra_height = 0 //100

//--- Dimensiona dw nel tab
	wb_1.width = a_width //- kk_barra_width
	wb_1.height = a_height //- kk_barra_height
	wb_1.x = 0
	wb_1.y = 0
	

end subroutine

public subroutine set_wb_1_visible (boolean a_visible);//
wb_1.visible = a_visible

end subroutine

public subroutine set_wb_1_enabled (boolean a_enabled);//
wb_1.enabled = a_enabled

end subroutine

public function string inizializza () throws uo_exception;/*
 Inizializzazione
*/
string k_return
integer k_rc


	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname)

	if kist_open_w.key8 > " " then
		
		if u_refresh( ) then 
			
			wb_1.visible = true // visualizza il tab
			this.visible = true
			this.enabled = true
	
			wb_1.setfocus()
		
		else	
			
			k_return = "1Url non raggiungibile (funzione di ZOOM): '" + kist_open_w.key8 + "'"
	
		end if
			
	end if

	SetPointer(kkg.pointer_default)
	
return k_return



end function

public function boolean u_refresh ();//
boolean k_return
int k_rc
string k_msg


	k_rc = wb_1.navigate(kist_open_w.key8)

	choose case k_rc
		case 1 // success
			k_return = true
		case -1 // errore
			k_msg = "Errore in ricerca del url '" + kist_open_w.key8 + "'. Prego, verificare la connessione a Internet. (funzione di ZOOM)"
		case -2 // Failed to get the browser instance.
			k_msg = "Errore in apertura del Browser per caricare la pagina '" + kist_open_w.key8 + "'. Forse il Browser non è associato o pronto al Sistema. (funzione di ZOOM)"
		case -5 // Invalid URL.
			k_msg = "Pagina irraggiungibile '" + kist_open_w.key8 + "'. Verificare l'indirizzo indicato manualmente sul browser. (funzione di ZOOM)"
		case else
			k_msg = "URL non caricato '" + kist_open_w.key8 + "'. Ritentare o verificare l'indirizzo indicato manualmente sul browser. (funzione di ZOOM)"
	end choose
		
return k_return
end function

event constructor;//
	if trim(message.stringparm) > " " then 
		if len(trim(message.stringparm)) > 14 then
			this.text = left(trim(message.stringparm), 14) + "..."
		else
			this.text = trim(message.stringparm)
		end if
		this.powertiptext = trim(message.stringparm)
	else
		this.text = "?????"
		this.powertiptext = ""
	end if
	
//	if not isvalid(kiuf_utility) then kiuf_utility = create kuf_utility


end event

on uo_g_tab_elenco_tabpage_web.create
this.wb_1=create wb_1
this.Control[]={this.wb_1}
end on

on uo_g_tab_elenco_tabpage_web.destroy
destroy(this.wb_1)
end on

event destructor;//
//	if isvalid(kiuf_utility) then destroy kiuf_utility 

end event

type wb_1 from uo_webbrowser within uo_g_tab_elenco_tabpage_web
boolean visible = false
end type

