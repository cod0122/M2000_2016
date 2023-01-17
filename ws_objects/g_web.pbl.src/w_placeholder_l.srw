$PBExportHeader$w_placeholder_l.srw
forward
global type w_placeholder_l from w_g_tab0
end type
end forward

global type w_placeholder_l from w_g_tab0
integer width = 3163
integer height = 1732
string title = "Elenco Segnaposti"
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
boolean ki_sincronizza_window_consenti = false
boolean ki_aggiorna_richiesta_conferma = false
boolean ki_resize_inizializza_y = false
boolean ki_reset_dopo_save_ok = false
boolean ki_consenti_modifica = false
boolean ki_consenti_inserisci = false
boolean ki_consenti_visualizza = false
boolean ki_reselect_row_if_updated = false
end type
global w_placeholder_l w_placeholder_l

type variables
private string ki_mostra_nascondi_in_lista = "S" 
private string ki_win_titolo_orig_save = ""
 
end variables

forward prototypes
private function string inizializza ()
public subroutine mostra_nascondi_in_lista ()
end prototypes

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


	SetPointer(kkg.pointer_attesa)

//	if dw_lista_0.retrieve() < 1 then
//		k_return = "1Segnaposti Non trovati "
//
//		messagebox("Lista Segnaposti Vuota", &
//				"Nesun Codice Trovato per la richiesta fatta")
//	end if

	SetPointer(kkg.pointer_default)

return k_return



end function

public subroutine mostra_nascondi_in_lista ();
end subroutine

on w_placeholder_l.create
call super::create
end on

on w_placeholder_l.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_print_0 from w_g_tab0`dw_print_0 within w_placeholder_l
end type

type st_ritorna from w_g_tab0`st_ritorna within w_placeholder_l
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_placeholder_l
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_placeholder_l
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_placeholder_l
integer x = 2514
integer y = 1096
integer height = 92
integer taborder = 90
boolean enabled = false
boolean cancel = true
end type

type st_stampa from w_g_tab0`st_stampa within w_placeholder_l
integer x = 0
integer y = 1100
integer width = 279
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_placeholder_l
integer x = 855
integer y = 1100
integer taborder = 30
end type

event cb_visualizza::clicked;//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
string k_codice
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


k_riga = dw_lista_0.getrow()
if k_riga > 0 then

	k_codice = dw_lista_0.getitemstring( k_riga, "codice" ) 
		
	if LenA(trim(k_codice))  > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key=codice prodotto;

		K_st_open_w.id_programma = "pr"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = k_codice  // codice prodotto
		K_st_open_w.key2 = " "
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
		
	end if
end if
	




end event

type cb_modifica from w_g_tab0`cb_modifica within w_placeholder_l
integer x = 1737
integer y = 1096
integer height = 96
integer taborder = 70
end type

event cb_modifica::clicked;//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
string k_codice
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


k_riga = dw_lista_0.getrow()
if k_riga > 0 then

	k_codice = dw_lista_0.getitemstring( k_riga, "codice" ) 
		
	if LenA(trim(k_codice))  > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key=codice prodotto;

		K_st_open_w.id_programma = "pr"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = k_codice  // codice prodotto
		K_st_open_w.key2 = " "
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
		
	end if
end if
	




end event

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_placeholder_l
integer x = 448
integer y = 1108
integer height = 96
integer taborder = 110
end type

type cb_cancella from w_g_tab0`cb_cancella within w_placeholder_l
integer x = 2126
integer y = 1096
integer height = 96
integer taborder = 80
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_placeholder_l
integer x = 1349
integer y = 1096
integer height = 96
integer taborder = 60
boolean enabled = false
end type

event cb_inserisci::clicked;//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
string k_codice=""
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


k_riga = dw_lista_0.getrow()
if k_riga > 0 then

//	k_codice = dw_lista_0.getitemstring( k_riga, "codice" ) 
		
//	if len(trim(k_codice))  > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key=codice prodotto;

		K_st_open_w.id_programma = "pr"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = k_codice  // codice prodotto
		K_st_open_w.key2 = " "
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
				
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
		
//	end if
end if
	





end event

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_placeholder_l
integer x = 315
integer y = 976
integer width = 2235
integer height = 224
end type

on dw_dett_0::rbuttondown;call w_g_tab0`dw_dett_0::rbuttondown;//
//=== Scateno l'evento sulla window
parent.triggerevent("rbuttondown")

end on

on dw_dett_0::getfocus;////
//long k_id_vettore
//
////=== Verifico se ho gia' fatto almeno una retrieve o una insert
//if dw_dett_0.getrow() = 0 then
//	if cb_modifica.enabled = true then
//		cb_modifica.triggerevent("clicked")
//	else
//		cb_inserisci.triggerevent("clicked")
//	end if
//end if
//
////=== Controlla quali tasti attivare
//attiva_tasti()
//
//k_id_vettore = this.getitemnumber(1, "id_vettore")
////k_desc = this.getitemstring(1, "desc")
//
////=== Imposto valori di default se non ce ne sono
////if isnull(k_id_c_pag) = true or isnull(k_desc) = true or &
////	(trim(k_id_c_pag) = "" and &
////	 trim(k_desc) = "") then
////	setitem(1, "tipo", 1)
////	setitem(1, "scad_p", 1)
////end if
//
end on

type st_orizzontal from w_g_tab0`st_orizzontal within w_placeholder_l
boolean enabled = false
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_placeholder_l
string dataobject = "d_placeholder_l"
end type

type dw_guida from w_g_tab0`dw_guida within w_placeholder_l
end type

type st_duplica from w_g_tab0`st_duplica within w_placeholder_l
end type

