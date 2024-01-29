$PBExportHeader$w_db_cfg_proprieta.srw
forward
global type w_db_cfg_proprieta from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_db_cfg_proprieta from w_g_tab_3
integer x = 169
integer y = 148
integer width = 3214
integer height = 1504
string title = "Propriea DB"
long backcolor = 31909606
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
boolean ki_toolbar_programmi_attiva_voce = false
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
string ki_syntaxquery = ""
string ki_dw_titolo_modif_1 = ""
end type
global w_db_cfg_proprieta w_db_cfg_proprieta

type variables
//
kuf_db_cfg kiuf_db_cfg
st_tab_db_cfg kist_tab_db_cfg

end variables

forward prototypes
private function integer inserisci ()
protected function string inizializza ()
private subroutine open_notepad_documento (string k_file) throws uo_exception
protected subroutine open_start_window ()
protected subroutine attiva_tasti_0 ()
end prototypes

private function integer inserisci ();////
int k_return=1, k_ctr


	tab_1.tabpage_1.dw_1.reset( )
	tab_1.tabpage_1.dw_1.insertrow(0)

	//kist_tab_db_cfg.codice = long(trim(ki_st_open_w.key1))
	kiuf_db_cfg.if_isnull(kist_tab_db_cfg)

	tab_1.tabpage_1.dw_1.setcolumn(1)
	attiva_tasti()

return (k_return)



end function

protected function string inizializza ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta
string k_stato = "0"
string  k_key, k_codice
int k_err_ins, k_rc


//=== 


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)

	k_key = trim(ki_st_open_w.key1)

	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		
		k_err_ins = inserisci()
//		tab_1.tabpage_1.dw_1.setfocus()
	else

		k_rc = tab_1.tabpage_1.dw_1.retrieve(k_key) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma" + &
					kkg.acapo + "Codice cercato: " + trim(k_key) + " " )
				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				if k_scelta = kkg_flag_modalita.modifica then
					if messagebox("Configurazione DB", &
						"Configurazione " + "codice " + trim(k_key) + " non trovata, vuoi generarla ora? ", &
						 question!, yesno!, 2 ) = 2 then
						ki_exit_si = true
					end if
				end if
					
				if not ki_exit_si then
					k_err_ins = inserisci()
				end if

			case is > 0		
				if k_scelta = kkg_flag_modalita.inserimento then
					messagebox("Configurazione DB", &
						"Configurazione già in archivio, accesso in modifica anzichè in inserimento. " + &
						+ kkg.acapo + "Codice cercato: " + trim(k_key) + " " )
			
						ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica

				end if

				tab_1.tabpage_1.dw_1.setcolumn(1)
//				tab_1.tabpage_1.dw_1.setfocus()
				
				attiva_tasti()
		
		end choose

	end if

else
	attiva_tasti()
end if


if not ki_exit_si then
	
	tab_1.tabpage_1.dw_1.ki_flag_modalita = ki_st_open_w.flag_modalita
	tab_1.tabpage_1.dw_1.u_proteggi_sproteggi_dw( )

end if

return "0"

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

protected subroutine open_start_window ();
try
	
	kiuf_db_cfg = create kuf_db_cfg
	kiuf_db_cfg.set_sqlca_db(ki_st_open_w.key1)

catch (uo_exception kuo_exception)
	
end try

//tab_1.tabpage_1.dw_1.object.cfg_dbms_scelta.sendtoback
end subroutine

protected subroutine attiva_tasti_0 ();//
	super::attiva_tasti_0()
	cb_inserisci.enabled = false


end subroutine

on w_db_cfg_proprieta.create
int iCurrent
call super::create
end on

on w_db_cfg_proprieta.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event u_open;call super::u_open;
//kiw_this_window.icon = "pklist.ico" 
tab_1.tabpage_1.dw_1.SetPosition("cfg_dbms_scelta", "", false)
tab_1.tabpage_1.dw_1.SetPosition("b_odbc", "", true)

end event

type dw_print_0 from w_g_tab_3`dw_print_0 within w_db_cfg_proprieta
end type

type st_ritorna from w_g_tab_3`st_ritorna within w_db_cfg_proprieta
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_db_cfg_proprieta
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_db_cfg_proprieta
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_db_cfg_proprieta
integer x = 2711
integer y = 1444
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
string text = ""
end type

type st_stampa from w_g_tab_3`st_stampa within w_db_cfg_proprieta
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_db_cfg_proprieta
integer x = 1175
integer y = 1440
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
string text = ""
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_db_cfg_proprieta
integer x = 503
integer y = 1436
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
string text = ""
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_db_cfg_proprieta
integer x = 1970
integer y = 1444
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
string text = ""
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_db_cfg_proprieta
integer x = 2341
integer y = 1444
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
string text = ""
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_db_cfg_proprieta
integer x = 1600
integer y = 1444
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
boolean enabled = false
string text = ""
end type

event cb_inserisci::clicked;//
//=== 
string k_errore="0"

//=== Nuovo Rekord
	choose case tab_1.selectedtab 
		case  1, 3 
	
			k_errore = LeftA(dati_modif(parent.title), 1)

//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
			if k_errore = "1" then //Fare gli aggiornamenti

//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
//===	              : 2=Errore Non grave dati aggiornati
//===               : 3=
				k_errore = aggiorna_dati()		

			else

				if k_errore = "2" then //Aggiornamento non richiesto
					k_errore = "0"
				end if

			end if
			
	end choose
	
	if LeftA(k_errore, 1) = "0" then 
		inserisci()
	end if

end event

type tab_1 from w_g_tab_3`tab_1 within w_db_cfg_proprieta
integer x = 0
integer y = 0
integer width = 3040
integer height = 1396
integer taborder = 0
integer weight = 0
string facename = ""
long backcolor = 32172778
boolean raggedright = false
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

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 32435950
string text = "Configurazione"
long tabtextcolor = 0
long tabbackcolor = 33554431
string picturename = "DosEdit5!"
long picturemaskcolor = 553648127
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 18
integer y = 60
integer width = 2967
integer height = 1144
integer taborder = 0
string title = ""
string dataobject = "d_db_cfg"
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_1::buttonclicked;call super::buttonclicked;//
kuf_utility kuf1_utility

try
	choose case  dwo.name 
		
		case "b_odbc"
			kuf1_utility = create kuf_utility
			kuf1_utility.u_apri_programma_esterno("odbcad32.exe")
			destroy kuf1_utility
	
		case "b_dbparm"
			kguo_exception.inizializza( )
			kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_OK)  //~n~r
			kguo_exception.messaggio_utente("Test Connessione", "Attenzione: il test di Connessione è fatto con i parametri già SALVATI su DB!")
			try
								
				if kiuf_db_cfg.test_connessione( ) then
					kguo_exception.inizializza( )
					kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_OK)
					kguo_exception.messaggio_utente("Test Connessione",  "OK, connessione eseguita.")
				else
					kguo_exception.inizializza( )
					kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_KO)
					kguo_exception.messaggio_utente("Test Connessione",  "Connessione RESPINTA. ~n~r" + kguo_exception.get_errtext( )  )
				end if
					
			catch (uo_exception kuo_exceptionOK)
				kguo_exception.inizializza( )
				kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_KO)
				kguo_exception.messaggio_utente("Test Connessione",  "Connessione RESPINTA (2). ~n~r" + kguo_exception.get_errtext( ) )
				
			end try
	
		case "cb_genera_schema"
			if messagebox("Operazione DISTRUTTIVA", "Sei sicuro di volre cancellare tutti i dati del DB e rigenerarlo vuoto?", Question!, yesno!, 2) = 1 then
				if kiuf_db_cfg.db_crea_schema( ) then
					kguo_exception.inizializza( )
					kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_OK)
					kguo_exception.messaggio_utente("Operazione terminata",  "OK, il database è stato rigenerato correttamente.")
				else
					kguo_exception.inizializza( )
					kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_KO)
					kguo_exception.messaggio_utente("Operazione conclusa per errore",  "DB non rigenerato, si sono verificate delle anomalie. ~n~r" + kguo_exception.get_errtext( )  )
				end if
			end if
	
	
	
	end choose
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try


end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
integer x = 507
integer y = 832
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
boolean visible = false
integer width = 3003
integer height = 1268
boolean enabled = false
long backcolor = 31909606
string text = ""
long tabtextcolor = 0
long tabbackcolor = 33544171
long picturemaskcolor = 553648127
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
integer y = 24
integer width = 2981
integer height = 1180
integer taborder = 0
string title = ""
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_2::clicked;call super::clicked;//
//=== Premuto Link nella DW ?
//
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


try
		

	if dwo.name = "path_file_pl_barcode" then
	
		open_notepad_documento(this.getitemstring(row, "path_file_pl_barcode"))
	
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try


//=== Riprist. il vecchio puntatore :
SetPointer(kpointer)


//
end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 31909606
string text = ""
long tabtextcolor = 0
long tabbackcolor = 33544171
long picturemaskcolor = 553648127
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
integer y = 48
integer width = 2967
integer height = 1156
integer taborder = 0
string title = ""
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_3::itemchanged;call super::itemchanged;//



end event

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 33544171
string text = ""
long tabtextcolor = 0
long tabbackcolor = 33544171
long picturemaskcolor = 553648127
ln_1 ln_1
end type

on tabpage_4.create
this.ln_1=create ln_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ln_1
end on

on tabpage_4.destroy
call super::destroy
destroy(this.ln_1)
end on

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
integer y = 24
integer width = 2939
integer height = 1116
integer taborder = 10
string title = ""
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

event buttonclicked;//
//=== Attivo/Disattivo visione grafico
if this.object.kgr_1.visible = "1" then
	tab_1.tabpage_4.dw_4.object.kcb_gr.text = "Grafico"
	tab_1.tabpage_4.dw_4.object.kgr_1.visible = "0" 
else
	tab_1.tabpage_4.dw_4.object.kcb_gr.text = "Dati"
	tab_1.tabpage_4.dw_4.object.kgr_1.visible = "1"
end if
//

end event

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 31909606
string text = ""
long tabtextcolor = 0
long tabbackcolor = 33544171
long picturemaskcolor = 553648127
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
integer y = 20
integer width = 2935
integer height = 1152
integer taborder = 0
string title = ""
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 0
string text = ""
long tabtextcolor = 0
long tabbackcolor = 0
long picturemaskcolor = 0
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
integer width = 0
integer height = 0
integer taborder = 0
string title = ""
string dataobject = ""
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 0
string text = ""
long tabtextcolor = 0
long tabbackcolor = 0
long picturemaskcolor = 0
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
integer width = 0
integer height = 0
integer taborder = 0
string title = ""
string dataobject = ""
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 0
string text = ""
long tabtextcolor = 0
long tabbackcolor = 0
long picturemaskcolor = 0
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
integer width = 0
integer height = 0
integer taborder = 0
string title = ""
string dataobject = ""
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 0
string text = ""
long tabtextcolor = 0
long tabbackcolor = 0
long picturemaskcolor = 0
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
integer width = 0
integer height = 0
integer taborder = 0
string title = ""
string dataobject = ""
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

type st_duplica from w_g_tab_3`st_duplica within w_db_cfg_proprieta
end type

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

