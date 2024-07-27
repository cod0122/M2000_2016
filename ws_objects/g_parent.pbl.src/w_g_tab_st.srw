$PBExportHeader$w_g_tab_st.srw
forward
global type w_g_tab_st from w_g_tab
end type
type rb_emissione_tutto from radiobutton within w_g_tab_st
end type
type rb_emissione_selezione from radiobutton within w_g_tab_st
end type
type rb_definitiva from radiobutton within w_g_tab_st
end type
type rb_prova from radiobutton within w_g_tab_st
end type
type pb_ok from picturebutton within w_g_tab_st
end type
type dw_documenti from uo_d_std_1 within w_g_tab_st
end type
type cbx_aggiorna_stato from checkbox within w_g_tab_st
end type
type cbx_update_profis from checkbox within w_g_tab_st
end type
type st_1 from statictext within w_g_tab_st
end type
type cbx_update_tab_varie from checkbox within w_g_tab_st
end type
type rb_modo_stampa_e from radiobutton within w_g_tab_st
end type
type rb_modo_stampa_s from radiobutton within w_g_tab_st
end type
type cbx_chiude from checkbox within w_g_tab_st
end type
type dw_note from datawindow within w_g_tab_st
end type
type gb_aggiorna from groupbox within w_g_tab_st
end type
type gb_emissione from groupbox within w_g_tab_st
end type
type gb_produzione from groupbox within w_g_tab_st
end type
end forward

global type w_g_tab_st from w_g_tab
integer width = 3602
integer height = 2012
string title = "Stampa Documenti"
long backcolor = 67108864
string icon = "RunReport5!"
boolean ki_toolbar_window_presente = true
event u_add_note ( string a_text )
rb_emissione_tutto rb_emissione_tutto
rb_emissione_selezione rb_emissione_selezione
rb_definitiva rb_definitiva
rb_prova rb_prova
pb_ok pb_ok
dw_documenti dw_documenti
cbx_aggiorna_stato cbx_aggiorna_stato
cbx_update_profis cbx_update_profis
st_1 st_1
cbx_update_tab_varie cbx_update_tab_varie
rb_modo_stampa_e rb_modo_stampa_e
rb_modo_stampa_s rb_modo_stampa_s
cbx_chiude cbx_chiude
dw_note dw_note
gb_aggiorna gb_aggiorna
gb_emissione gb_emissione
gb_produzione gb_produzione
end type
global w_g_tab_st w_g_tab_st

type variables

end variables

forward prototypes
protected subroutine u_personalizza_dw ()
protected subroutine attiva_menu ()
protected subroutine u_seleziona_tutti ()
protected subroutine u_deseleziona_tutti ()
protected subroutine smista_funz (string k_par_in)
public subroutine u_resize ()
protected subroutine fine_primo_giro ()
end prototypes

protected subroutine u_personalizza_dw ();//---
//--- Personalizza DW
//---

	dw_documenti.ki_flag_modalita = ki_st_open_w.flag_modalita 
	dw_documenti.event u_personalizza_dw()
	



end subroutine

protected subroutine attiva_menu ();//	
	if not m_main.m_strumenti.m_fin_gest_libero3.enabled  then
		m_main.m_strumenti.m_fin_gest_libero3.text = "Togli Selezione a tutti "
		m_main.m_strumenti.m_fin_gest_libero3.microhelp = "Toglie 'selezione' a tutti i documenti in elenco   "
		m_main.m_strumenti.m_fin_gest_libero3.enabled = true
		m_main.m_strumenti.m_fin_gest_libero3.toolbaritemtext = "Deseleziona,"+  m_main.m_strumenti.m_fin_gest_libero3.text
		m_main.m_strumenti.m_fin_gest_libero3.toolbaritemname = "custom080!"
		m_main.m_strumenti.m_fin_gest_libero3.toolbaritemvisible = true
//		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
		m_main.m_strumenti.m_fin_gest_libero3.visible = true
	end if
//	
	if not m_main.m_strumenti.m_fin_gest_libero4.enabled  then
		m_main.m_strumenti.m_fin_gest_libero4.text = "Attiva Selezione a tutti "
		m_main.m_strumenti.m_fin_gest_libero4.microhelp = "Attiva 'selezione' a tutti i documenti in elenco   "
		m_main.m_strumenti.m_fin_gest_libero4.enabled = true
		m_main.m_strumenti.m_fin_gest_libero4.toolbaritemtext = "Seleziona,"+ m_main.m_strumenti.m_fin_gest_libero4.text
		m_main.m_strumenti.m_fin_gest_libero4.toolbaritemname = "custom038!"
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2
		m_main.m_strumenti.m_fin_gest_libero4.visible = true
		m_main.m_strumenti.m_fin_gest_libero4.toolbaritemvisible = true
	end if

//---
	super::attiva_menu()


end subroutine

protected subroutine u_seleziona_tutti ();//
//--- Seleziona tutti i record del dw: dw_documenti
//
long k_ctr


for k_ctr = 1 to dw_documenti.rowcount( )
	
	dw_documenti.object.sel[k_ctr] = 1		
	
next




end subroutine

protected subroutine u_deseleziona_tutti ();//
//--- Deseleziona tutti i record del dw: dw_documenti
//
long k_ctr


for k_ctr = 1 to dw_documenti.rowcount( )
	
	dw_documenti.object.sel[k_ctr] = 0		
	
next




end subroutine

protected subroutine smista_funz (string k_par_in);//---
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===

choose case LeftA(k_par_in, 2) 

	case KKG_FLAG_RICHIESTA.libero3		//Togli Selezione
		this.u_deseleziona_tutti( )

	case KKG_FLAG_RICHIESTA.libero4		//Metti Selezione
		this.u_seleziona_tutti( )


	case else // standard
		super::smista_funz(k_par_in)
		
end choose



end subroutine

public subroutine u_resize ();//
int k_documenti_height

this.setredraw(false) 

if dw_note.visible then
	dw_note.x = gb_emissione.x + gb_emissione.width + 20 
	dw_note.y = this.height - (this.height * 0.20) 
	dw_note.width = this.width - gb_emissione.width - 30
	if dw_note.width < 0 then
		dw_note.width = 100
	end if
	dw_note.height = this.height - dw_note.y - 10
	k_documenti_height = dw_note.y - 10
else
	dw_note.x = 0
	dw_note.y = 0
	dw_note.width = 0
	dw_note.height = 0
	k_documenti_height = this.height - 10
end if

dw_documenti.x = gb_emissione.x + gb_emissione.width + 20 
dw_documenti.y = 0
dw_documenti.width = this.width - gb_emissione.width - 30
if dw_documenti.width < 0 then
	dw_documenti.width = 100
end if
dw_documenti.height = k_documenti_height

this.setredraw(true) 



end subroutine

protected subroutine fine_primo_giro ();//
dw_documenti.visible = true

super::fine_primo_giro()

end subroutine

on w_g_tab_st.create
int iCurrent
call super::create
this.rb_emissione_tutto=create rb_emissione_tutto
this.rb_emissione_selezione=create rb_emissione_selezione
this.rb_definitiva=create rb_definitiva
this.rb_prova=create rb_prova
this.pb_ok=create pb_ok
this.dw_documenti=create dw_documenti
this.cbx_aggiorna_stato=create cbx_aggiorna_stato
this.cbx_update_profis=create cbx_update_profis
this.st_1=create st_1
this.cbx_update_tab_varie=create cbx_update_tab_varie
this.rb_modo_stampa_e=create rb_modo_stampa_e
this.rb_modo_stampa_s=create rb_modo_stampa_s
this.cbx_chiude=create cbx_chiude
this.dw_note=create dw_note
this.gb_aggiorna=create gb_aggiorna
this.gb_emissione=create gb_emissione
this.gb_produzione=create gb_produzione
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_emissione_tutto
this.Control[iCurrent+2]=this.rb_emissione_selezione
this.Control[iCurrent+3]=this.rb_definitiva
this.Control[iCurrent+4]=this.rb_prova
this.Control[iCurrent+5]=this.pb_ok
this.Control[iCurrent+6]=this.dw_documenti
this.Control[iCurrent+7]=this.cbx_aggiorna_stato
this.Control[iCurrent+8]=this.cbx_update_profis
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.cbx_update_tab_varie
this.Control[iCurrent+11]=this.rb_modo_stampa_e
this.Control[iCurrent+12]=this.rb_modo_stampa_s
this.Control[iCurrent+13]=this.cbx_chiude
this.Control[iCurrent+14]=this.dw_note
this.Control[iCurrent+15]=this.gb_aggiorna
this.Control[iCurrent+16]=this.gb_emissione
this.Control[iCurrent+17]=this.gb_produzione
end on

on w_g_tab_st.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_emissione_tutto)
destroy(this.rb_emissione_selezione)
destroy(this.rb_definitiva)
destroy(this.rb_prova)
destroy(this.pb_ok)
destroy(this.dw_documenti)
destroy(this.cbx_aggiorna_stato)
destroy(this.cbx_update_profis)
destroy(this.st_1)
destroy(this.cbx_update_tab_varie)
destroy(this.rb_modo_stampa_e)
destroy(this.rb_modo_stampa_s)
destroy(this.cbx_chiude)
destroy(this.dw_note)
destroy(this.gb_aggiorna)
destroy(this.gb_emissione)
destroy(this.gb_produzione)
end on

event closequery;call super::closequery;st_profilestring_ini kst_profilestring_ini


//--- salvo campo "Chiudi a fine stampa"
	kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_scrivi
	kst_profilestring_ini.file = "stampe" 
	kst_profilestring_ini.titolo = "chiudeafine"
	kst_profilestring_ini.nome = this.classname( )
	if cbx_chiude.checked then
		kst_profilestring_ini.valore = "S"
	else
		kst_profilestring_ini.valore = "N"
	end if
	kGuf_data_base.profilestring_ini(kst_profilestring_ini)

end event

event u_open;call super::u_open;//
string k_rcx=""
st_profilestring_ini kst_profilestring_ini

//--- recupero i valori se personalizzati della window
	kst_profilestring_ini.operazione = "1"
	kst_profilestring_ini.valore = "S"
	kst_profilestring_ini.file = "stampe" 
	kst_profilestring_ini.titolo = "chiudeafine" 
	kst_profilestring_ini.nome = this.classname( ) 
	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	if kst_profilestring_ini.esito <> "0" then
		kst_profilestring_ini.valore = "S"
	end if
	if kst_profilestring_ini.valore = "S" then
		cbx_chiude.checked = true
	else
		cbx_chiude.checked = false
	end if

	pb_ok.picturename = "printa36.png"
	st_aggiorna_lista.enabled  = TRUE

//--- Fine PRIMO GIRO
	ki_st_open_w.flag_primo_giro = "N" 
	 
	u_resize()

end event

type dw_print_0 from w_g_tab`dw_print_0 within w_g_tab_st
end type

type st_ritorna from w_g_tab`st_ritorna within w_g_tab_st
integer x = 2551
integer y = 1844
integer height = 72
end type

type st_ordina_lista from w_g_tab`st_ordina_lista within w_g_tab_st
end type

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_g_tab_st
integer x = 229
integer y = 1752
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_g_tab_st
integer x = 901
integer y = 1708
integer taborder = 0
end type

type st_stampa from w_g_tab`st_stampa within w_g_tab_st
integer x = 2043
integer y = 1856
end type

type rb_emissione_tutto from radiobutton within w_g_tab_st
integer x = 96
integer y = 104
integer width = 1042
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tutti i documenti "
end type

type rb_emissione_selezione from radiobutton within w_g_tab_st
integer x = 96
integer y = 200
integer width = 1042
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo documenti con ~'Sel~' attivato"
boolean checked = true
end type

type rb_definitiva from radiobutton within w_g_tab_st
integer x = 78
integer y = 988
integer width = 608
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Genera e Aggiorna "
end type

event clicked;//
if this.checked then
	
	cbx_update_tab_varie.enabled = true
	cbx_aggiorna_stato.enabled = true
	cbx_update_profis.enabled = true
	
end if
end event

type rb_prova from radiobutton within w_g_tab_st
integer x = 78
integer y = 900
integer width = 1042
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo emissione (no Aggiornamenti) "
boolean checked = true
end type

event clicked;//
if this.checked then
	
	cbx_update_tab_varie.enabled = false
	cbx_update_profis.enabled = false
	cbx_aggiorna_stato.enabled = false
	
end if
end event

type pb_ok from picturebutton within w_g_tab_st
integer x = 96
integer y = 1576
integer width = 201
integer height = 176
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "printa36.png"
vtextalign vtextalign = top!
string powertiptext = "Emissione  della stampa e/o elettronico"
end type

event clicked;//
//this.enabled = false

stampa()

//this.enabled = true


end event

type dw_documenti from uo_d_std_1 within w_g_tab_st
integer x = 1184
integer width = 2354
integer height = 1448
integer taborder = 80
boolean bringtotop = true
boolean enabled = true
string dataobject = "d_arfa_l"
boolean border = true
boolean ki_link_standard_sempre_possibile = true
end type

event getfocus;call super::getfocus;//
kidw_selezionata = this

end event

type cbx_aggiorna_stato from checkbox within w_g_tab_st
integer x = 142
integer y = 1112
integer width = 997
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Agg. lo Stato + elenco doc. da Esportare"
boolean checked = true
end type

type cbx_update_profis from checkbox within w_g_tab_st
integer x = 142
integer y = 1192
integer width = 827
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "crea Movim. per la Contabilità"
boolean checked = true
end type

type st_1 from statictext within w_g_tab_st
integer x = 329
integer y = 1632
integer width = 695
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Emissione Documenti"
boolean focusrectangle = false
end type

type cbx_update_tab_varie from checkbox within w_g_tab_st
integer x = 142
integer y = 1272
integer width = 827
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "crea  Scadenze ecc..."
boolean checked = true
end type

type rb_modo_stampa_e from radiobutton within w_g_tab_st
integer x = 91
integer y = 600
integer width = 1042
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Emissione digitale (pdf) "
end type

type rb_modo_stampa_s from radiobutton within w_g_tab_st
integer x = 91
integer y = 508
integer width = 1042
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Stampa cartecea"
boolean checked = true
end type

type cbx_chiude from checkbox within w_g_tab_st
integer x = 23
integer y = 1460
integer width = 1152
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
long backcolor = 67108864
string text = "Chiudi al termine dell~'elaborazione"
boolean lefttext = true
boolean righttoleft = true
end type

type dw_note from datawindow within w_g_tab_st
event u_add_note ( string a_text )
boolean visible = false
integer x = 1193
integer y = 1464
integer width = 2327
integer height = 284
integer taborder = 70
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "dw_note"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event u_add_note(string a_text);//
this.insertrow(1)
this.setitem(1, "note", trim(a_text))

end event

event resize;//
this.modify("note.width = " + string(this.width - 10) )

end event

type gb_aggiorna from groupbox within w_g_tab_st
integer x = 27
integer y = 812
integer width = 1125
integer height = 596
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = " Genera e Aggiorna "
end type

type gb_emissione from groupbox within w_g_tab_st
integer x = 27
integer y = 8
integer width = 1125
integer height = 352
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "  Emissione "
end type

type gb_produzione from groupbox within w_g_tab_st
integer x = 27
integer y = 400
integer width = 1125
integer height = 352
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = " Produzione dei documenti"
end type

