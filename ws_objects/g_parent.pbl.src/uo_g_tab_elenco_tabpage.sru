$PBExportHeader$uo_g_tab_elenco_tabpage.sru
forward
global type uo_g_tab_elenco_tabpage from userobject
end type
type dw_sel from uo_d_std_1 within uo_g_tab_elenco_tabpage
end type
type dw_1 from uo_d_std_1 within uo_g_tab_elenco_tabpage
end type
end forward

global type uo_g_tab_elenco_tabpage from userobject
boolean visible = false
integer width = 1883
integer height = 940
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event resize ( long a_w,  long a_h )
dw_sel dw_sel
dw_1 dw_1
end type
global uo_g_tab_elenco_tabpage uo_g_tab_elenco_tabpage

type variables
//
private string ki_syntaxquery
public uo_d_std_1 kidw_selezionata
private uo_ds_std_1 kids_elenco
public uo_ds_std_1  kids_elenco_orig
public st_open_w kist_open_w	
private boolean ki_conferma=false, ki_disattiva_exit=false, ki_u_ricevi_da_elenco_in_esec=false
private kuf_utility kiuf_utility
public tab kitab_1
end variables

forward prototypes
public subroutine u_zoom_meno ()
public subroutine u_zoom_off ()
public subroutine u_zoom_piu ()
public subroutine set_dw_1_visible (boolean a_visible)
public subroutine set_dw_1_enabled (boolean a_enabled)
public function uo_d_std_1 get_dw_1 ()
public function string conferma_dati ()
public function uo_d_std_1 get_dw_sel ()
public function datastore get_ds_elenco_orig ()
public function datastore get_ds_elenco ()
public function string inizializza () throws uo_exception
public subroutine leggi_liste ()
public subroutine mostra_elenco_selezionati ()
public subroutine u_esegui_funzione (string a_flag_modalita)
private subroutine attiva_drag_drop (uo_d_std_1 adw_1)
private function boolean u_attiva_evento_in_win_origine ()
private function integer u_togli_righe_selezionate ()
private function long u_riposiziona_cursore ()
public subroutine set_ki_conferma (boolean a_conferma)
public subroutine u_resize (long a_width, long a_height)
private function long u_set_kids_elenco () throws uo_exception
end prototypes

event resize(long a_w, long a_h);//
u_resize(a_w, a_h)
end event

public subroutine u_zoom_meno ();//
//--- diminuisce 
//
int k_zoom


	k_zoom = integer(dw_1.Object.DataWindow.Print.Preview.Zoom)
	if k_zoom < 11 then
		k_zoom = 100
	else
		k_zoom -= 10
	end if
	if k_zoom = 100 then
		dw_1.Object.DataWindow.Print.Preview = "No"
	else
		dw_1.Object.DataWindow.Print.Preview = "Yes"
	end if
	dw_1.Object.DataWindow.Print.Preview.Zoom = k_zoom
	dw_1.SetRedraw(TRUE)

end subroutine

public subroutine u_zoom_off ();//
//--- diminuisce 
//
	dw_1.Object.DataWindow.Print.Preview = "No"
	dw_1.Object.DataWindow.Print.Preview.Zoom = 100
	dw_1.SetRedraw(TRUE)

end subroutine

public subroutine u_zoom_piu ();//
//--- ingrandisce 
//
int k_zoom

	k_zoom = integer(dw_1.Object.DataWindow.Print.Preview.Zoom)
	if k_zoom > 1000 then
		k_zoom = 100
	else
		k_zoom += 10
	end if
	if k_zoom = 100 then
		dw_1.Object.DataWindow.Print.Preview = "No"
	else
		dw_1.Object.DataWindow.Print.Preview = "Yes"
	//	adw_1.Object.DataWindow.Print.Margin.Bottom = '0'
	//	adw_1.Object.DataWindow.Print.Margin.Left = '0'
	//	adw_1.Object.DataWindow.Print.Margin.Right = '0'
	//	adw_1.Object.DataWindow.Print.Margin.Top = '0'
	//	adw_1.Object.DataWindow.Print.paper.source = '0'
	end if
	dw_1.Object.DataWindow.Print.Preview.Zoom = k_zoom
	dw_1.SetRedraw(TRUE)

end subroutine

public subroutine set_dw_1_visible (boolean a_visible);//
dw_1.visible = a_visible

end subroutine

public subroutine set_dw_1_enabled (boolean a_enabled);//
dw_1.enabled = a_enabled

end subroutine

public function uo_d_std_1 get_dw_1 ();// 
return dw_1 
end function

public function string conferma_dati ();//
//--- Operazione di Conferma della riga/righe selezionate
//
string k_rc
string k_processing 
string k_return = ""
long k_riga
boolean k_funzione_eseguita



k_processing = dw_1.Object.DataWindow.Processing

ki_conferma = false
ki_disattiva_exit = false

if dw_1.ki_ultrigasel > 0 then
	
	dw_1.setfocus()
		
//--- invia la riga selezionata alla windows che ha chiamato l'elenco	
	k_funzione_eseguita = u_attiva_evento_in_win_origine()
	
	if k_funzione_eseguita then
		if NOT ki_disattiva_exit then
			if kist_open_w.key7 = "N" then
			else
				k_return = "EXIT"
			end if
		else
	
//--- Se è stata aperta come windows di "CONFERMA" oppure come da "inquiry" ma è di tipo "GRID" o "TREEVIEW" allora 
//--- x doppio click metto il record nella DW di appoggio 'dei selzionati'
			if dw_1.rowcount() > 0 & 
				and ( &
					 (k_processing = "1" &
						or k_processing = "8" &
						or k_processing = "9") ) then

				u_togli_righe_selezionate()

//--- ripiglia il fuoco sul tab giusto
				u_riposiziona_cursore()

			end if

			ki_conferma = true
		end if
	end if
else
	ki_conferma = true
end if

return k_return 

end function

public function uo_d_std_1 get_dw_sel ();// 
return dw_sel
end function

public function datastore get_ds_elenco_orig ();// 
return kids_elenco_orig
end function

public function datastore get_ds_elenco ();// 
return kids_elenco
end function

public function string inizializza () throws uo_exception;/*
 Inizializzazione della Windows
 Ripristino DW; tasti; e retrieve liste
 Ritorna 1 chr : 0=Retrieve OK; 1 e 2=Retrieve fallita (2=uscita Window)
    Dal 2 char in poi spiegazione errore
*/
string k_return="0 "
integer k_rc
long k_nr_rek, k_riga
datastore kds_1
uo_d_std_1 kds_d_std_1
uo_datastore_0 kds_0


	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname)

	k_nr_rek = kids_elenco_orig.rowcount( )

//--- Popolo l'elenco dal datastore passato
	if k_nr_rek = 0 then 
		
		u_set_kids_elenco( )

		dw_1.dataobject = kids_elenco.dataobject
		choose case trim(kist_open_w.settrans)
			case kguo_sqlca_db_magazzino.ki_title_id 
				dw_1.settrans (kguo_sqlca_db_magazzino)
			case kguo_sqlca_db_pilota.ki_title_id 
				dw_1.settrans (kguo_sqlca_db_pilota)
			case kguo_sqlca_db_e1.ki_title_id 
				dw_1.settrans (kguo_sqlca_db_e1)
			case else
				dw_1.settrans (kguo_sqlca_db_magazzino)
		end choose

		dw_sel.dataobject = dw_1.dataobject

		attiva_drag_drop(dw_1)  // attiva il dar&drop solo se dw GRID
	
		leggi_liste()		
	
		//k_rc = kids_elenco.rowscopy(1, kids_elenco.rowcount(), primary!,dw_1,1,primary!)
		k_nr_rek = dw_1.rowcount() 
		
		if k_nr_rek < 1 then
			k_return = "1Nessuna dato per la funzione di ZOOM (" + kids_elenco.dataobject + ")"
	
			messagebox("Nessun dato disponibile", &
				"Nessun dato trovato per la richiesta fatta (funzione di ZOOM: '" + kids_elenco.dataobject + "')") 
	
		else
			
	//--- Inabilita campi alla modifica 
			kiuf_utility.u_dw_toglie_ddw(1, dw_1)
			kiuf_utility.u_proteggi_dw("1", 0, dw_1)
	
	//--- attiva i LINK standard
			dw_1.event u_personalizza_dw ()
			dw_sel.event u_personalizza_dw ()
			
		end if
			
	end if

	if k_nr_rek > 0 then 

		dw_1.visible = true // visualizza il tab
	
		//riposiziona_cursore(dw_1)   // riga seleziona
		if isvalid(dw_1) then dw_1.setredraw(true)
		dw_sel.visible = false
		
		this.visible = true
		this.enabled = true

		dw_1.setfocus()
	end if
	
	SetPointer(kkg.pointer_default)
	
return k_return



end function

public subroutine leggi_liste ();//
int k_rc
long k_row


	if dw_1.rowcount( ) > 0 then
		dw_1.reset()
		k_row = kids_elenco_orig.getrow( )
		if k_row > 0 then
		else
			k_row = 1
		end if
		k_rc = kids_elenco_orig.reselectrow(k_row)
	end if
	k_rc = kids_elenco_orig.rowscopy(1, kids_elenco_orig.rowcount(), primary!, dw_1,1,primary!)

	dw_sel.visible = false
	dw_sel.reset()


end subroutine

public subroutine mostra_elenco_selezionati ();//

if dw_sel.visible then
	dw_sel.visible = false
else
	dw_sel.visible = true
end if

end subroutine

public subroutine u_esegui_funzione (string a_flag_modalita);//
st_open_w kst_open_w
datastore kds_1


try

	kds_1 = create datastore
	kds_1.dataobject = dw_1.dataobject

	if dw_1.rowcount( ) > 0 then
		if dw_1.getrow( ) = 0 then dw_1.setrow(1) 
		dw_1.rowscopy( dw_1.getrow( ) , dw_1.getrow( ), primary!, kds_1, 1, primary!)
	end if
	
	kGuf_menu_window.open_w_tabelle_da_ds(kds_1, a_flag_modalita)
		

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try
end subroutine

private subroutine attiva_drag_drop (uo_d_std_1 adw_1);//
if dw_1.u_get_tipo() = dw_1.kki_tipo_processing_grid then
	dw_1.ki_attiva_dragdrop = true
else
	dw_1.ki_attiva_dragdrop = false
end if
end subroutine

private function boolean u_attiva_evento_in_win_origine ();//
//--- Call Windows chiamante event: "u_ricevi_da_elenco"
//---
//--- rit.: TRUE se evento chiamato
//---
boolean k_return
long k_riga=0, k_riga_ins=0, k_righe
int k_errore, k_rc
string k_key


//--- imposta gli oggetti standard
//	setta_oggetti()


//=== Valorizza l'oggetto DATASTORE per ritorno dei valori 
	if isvalid(kids_elenco) then destroy kids_elenco 
	kids_elenco = create uo_ds_std_1 //create datastore
	kids_elenco.dataobject = dw_1.dataobject
	kids_elenco.reset( )
	
//--- copia solo i record selezionati	
	k_riga = dw_1.getselectedrow(0)
	do while k_riga > 0
		
		k_riga_ins++
		if dw_1.rowscopy(k_riga, k_riga, primary!, kids_elenco, k_riga_ins, primary!) > 0 then // copia la riga SELECTED
			kids_elenco.selectrow( k_riga_ins,true) // anche qui la rende SELECTED (solo x mantenere la vecchia compatibilità)
		end if
			
		kist_open_w.key12_any = kids_elenco
		kist_open_w.key3 = string(k_riga_ins) //"1"
		
		if not isnull(kist_open_w.key10_window_chiamante) then
			
			if isvalid(kist_open_w.key10_window_chiamante) and not ki_u_ricevi_da_elenco_in_esec then
				ki_u_ricevi_da_elenco_in_esec = true
				if kist_open_w.key10_window_chiamante.event u_ricevi_da_elenco (kist_open_w) > 0 then
					k_return = true
					//kist_open_w.key10_window_chiamante.post setfocus( )
				end if
				ki_u_ricevi_da_elenco_in_esec = false
			end if
			
		end if
		
		k_riga = dw_1.getselectedrow(k_riga) // cerca la successiva selezionata
		
	loop
	
	if k_return	then
		kist_open_w.key10_window_chiamante.post setfocus( )
	end if
	
return k_return	
end function

private function integer u_togli_righe_selezionate ();//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
long k_ind_selected=0, k_return


	k_ind_selected = dw_1.getselectedrow( 0 )
	do while k_ind_selected > 0 
		
		k_return ++
		dw_sel.event ue_aggiungi_riga(k_ind_selected)
	
		k_ind_selected --
		k_ind_selected = dw_1.getselectedrow( k_ind_selected )
		
	loop
	
	
return k_return
end function

private function long u_riposiziona_cursore ();//
long k_riga


		k_riga = dw_1.getrow()
		if k_riga = 0 then
			k_riga = dw_1.GetSelectedRow(0)
		end if
		if k_riga = 0 then
			k_riga = 1
		end if
		if k_riga > 0 and dw_1.rowcount() > 0 then
			if k_riga > dw_1.rowcount() then
				k_riga = dw_1.rowcount()
			end if
	
			if dw_1.Rowcount() > 1 then // and ki_st_open_w.flag_primo_giro <> 'S' then
			 
				dw_1.selectrow( 0, false)
				dw_1.selectrow( k_riga, true)
				dw_1.setrow( k_riga )
				dw_1.scrolltorow( k_riga )
	
			end if
		end if

return k_riga
end function

public subroutine set_ki_conferma (boolean a_conferma);//
ki_conferma = a_conferma
end subroutine

public subroutine u_resize (long a_width, long a_height);//
//	constant int kk_barra_width = 0 //1
//	constant int kk_barra_height = 0 //100

//--- Dimensiona dw nel tab
	dw_1.width = a_width //- kk_barra_width
	dw_1.height = a_height //- kk_barra_height
	dw_1.x = 0
	dw_1.y = 0
	
//--- Dimensione e Posizione dw di selezione nella window 
	dw_sel.height = dw_1.height * 0.70
	dw_sel.width = dw_1.width * 0.30
	dw_sel.x = (a_width - dw_sel.width) - 45
	dw_sel.y = dw_1.y + 30

end subroutine

private function long u_set_kids_elenco () throws uo_exception;/*
 Popola kids_elenco
 Rit: num righe in kids_elenco
*/
integer k_rc
datastore kds_1
uo_ds_std_1 kds_d_std_1
uo_datastore_0 kds_0


	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname)

	if isvalid(kids_elenco) then 
		destroy kids_elenco 
		kids_elenco = create uo_ds_std_1 
	end if
	if isvalid(kids_elenco_orig) then 
		destroy kids_elenco_orig 
		kids_elenco_orig = create uo_ds_std_1 
	end if

	if isvalid(kist_open_w.key12_any) then
		choose case ClassName(kist_open_w.key12_any)
			case "datastore"
				kds_1 = kist_open_w.key12_any
				kids_elenco.dataobject = kds_1.dataobject
				k_rc = kds_1.RowsCopy(1, kds_1.RowCount(), Primary!, kids_elenco, 1, Primary!)
			case "uo_ds_std_1"
				kds_d_std_1 = kist_open_w.key12_any
				kids_elenco.dataobject = kds_d_std_1.dataobject
				k_rc = kds_d_std_1.RowsCopy(1, kds_d_std_1.RowCount(), Primary!, kids_elenco, 1, Primary!)
			case "uo_datastore_0"
				kds_0 = kist_open_w.key12_any
				kids_elenco.dataobject = kds_0.dataobject
				k_rc = kds_0.RowsCopy(1, kds_0.RowCount(), Primary!, kids_elenco, 1, Primary!)
			case else
				kguo_exception.kist_esito.esito = kguo_exception.KK_st_uo_exception_tipo_internal_bug
				kguo_exception.kist_esito.sqlerrtext = "ZOOM: dati assenti (oggetto datastore non riconosciuto '" + trim(kist_open_w.key2) + "' di tipo '" + trim(ClassName(kist_open_w.key12_any)) + "')"
				throw kguo_exception
		end choose

	else
		if isvalid(kist_open_w.key11_ds) then
			kids_elenco.dataobject = kist_open_w.key11_ds.dataobject
			k_rc = kist_open_w.key11_ds.RowsCopy(1, kist_open_w.key11_ds.RowCount(), Primary!, kids_elenco, 1, Primary!)
		else
			kguo_exception.kist_esito.esito = kguo_exception.KK_st_uo_exception_tipo_internal_bug
			kguo_exception.kist_esito.sqlerrtext = "ZOOM: dati assenti (oggetto datastore non riconosciuto '" + trim(kist_open_w.key2) + "')"
			throw kguo_exception
		end if

	end if

	kids_elenco_orig.dataobject = kids_elenco.dataobject
	k_rc = kids_elenco.rowscopy(1, kids_elenco.rowcount(), primary!,kids_elenco_orig,1,primary!)

return kids_elenco.rowcount()



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
	
	if not isvalid(kids_elenco) then kids_elenco = create uo_ds_std_1 //create datastore
	if not isvalid(kids_elenco_orig) then kids_elenco_orig = create uo_ds_std_1 //create datastore
	if not isvalid(kiuf_utility) then kiuf_utility = create kuf_utility


end event

on uo_g_tab_elenco_tabpage.create
this.dw_sel=create dw_sel
this.dw_1=create dw_1
this.Control[]={this.dw_sel,&
this.dw_1}
end on

on uo_g_tab_elenco_tabpage.destroy
destroy(this.dw_sel)
destroy(this.dw_1)
end on

event destructor;//
	if isvalid(kids_elenco) then destroy kids_elenco 
	if isvalid(kids_elenco_orig) then destroy  kids_elenco_orig 
	if isvalid(kiuf_utility) then destroy kiuf_utility 

end event

type dw_sel from uo_d_std_1 within uo_g_tab_elenco_tabpage
integer x = 663
integer y = 72
integer taborder = 20
boolean enabled = true
boolean titlebar = true
string title = "righe selezionate"
boolean maxbox = true
boolean resizable = true
boolean hsplitscroll = false
end type

event sqlpreview;call super::sqlpreview;//
	ki_syntaxquery = sqlsyntax

end event

event ue_aggiungi_riga;call super::ue_aggiungi_riga;//
dw_1.rowsmove(a_riga, a_riga , Primary!, this, 1,Primary!)

end event

event getfocus;call super::getfocus;//
kidw_selezionata = this


end event

event ue_dwnkey;call super::ue_dwnkey;//

	if key = KeyAdd! or key = KeySubtract! or key = KeyEqual! or key = KeyDash! or key = KeyEscape! or key = KeyDelete! then
		if key = KeyEscape! or key = KeyDelete! then
			u_zoom_off()
		else
			if key = KeyAdd! or key = KeyEqual! then
				u_zoom_piu()   //Zoomma +
			else
				u_zoom_meno()   //Zoomma -
			end if
		end if
	else
	end if

end event

event clicked;call super::clicked;//
parent.triggerevent(clicked!)
end event

type dw_1 from uo_d_std_1 within uo_g_tab_elenco_tabpage
integer taborder = 10
boolean enabled = true
end type

event doubleclicked;//
if row < 1 then
	return 1
end if
if ki_conferma then 
	kist_open_w.key5 = " " //--- nessun pulsante pigiato
	if conferma_dati( ) = "EXIT" then
		kitab_1.triggerevent("ue_exit") 
	end if
end if


end event

event clicked;call super::clicked;//
//kiw_g_tab_elenco.u_attiva_tasti()
kitab_1.post triggerevent(clicked!)

end event

event getfocus;call super::getfocus;//
kidw_selezionata = this
//u_resize( )



end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax

end event

event ue_drag_out;call super::ue_drag_out;//


if ki_conferma then 

//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
	u_togli_righe_selezionate()

end if

return 1

end event

event ue_dwnkey;call super::ue_dwnkey;//

	if key = KeyAdd! or key = KeySubtract! or key = KeyEqual! or key = KeyDash! or key = KeyEscape! or key = KeyDelete! then
		if key = KeyEscape! or key = KeyDelete! then
			u_zoom_off()
		else
			if key = KeyAdd! or key = KeyEqual! then
				u_zoom_piu()   //Zoomma +
			else
				u_zoom_meno()   //Zoomma -
			end if
		end if
	else
	end if

end event

