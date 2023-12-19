$PBExportHeader$w_g_tab_elenco.srw
forward
global type w_g_tab_elenco from w_g_tab
end type
type cb_visualizza from commandbutton within w_g_tab_elenco
end type
type cb_modifica from commandbutton within w_g_tab_elenco
end type
type cb_conferma from commandbutton within w_g_tab_elenco
end type
type cb_cancella from commandbutton within w_g_tab_elenco
end type
type cb_inserisci from commandbutton within w_g_tab_elenco
end type
type tab_1 from tab within w_g_tab_elenco
end type
type tab_1 from tab within w_g_tab_elenco
end type
end forward

global type w_g_tab_elenco from w_g_tab
integer width = 261
integer height = 292
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
cb_visualizza cb_visualizza
cb_modifica cb_modifica
cb_conferma cb_conferma
cb_cancella cb_cancella
cb_inserisci cb_inserisci
tab_1 tab_1
end type
global w_g_tab_elenco w_g_tab_elenco

type variables
//
private kuf_elenco kiuf_elenco

private DataWindow  ki_dw_cerca

//private w_g_tab ki_window
//private kuf_g_tab_elenco kiuf_g_tab_elenco

private boolean ki_attendi_u_ricevi_da_elenco=false  // x evitare di fare richiamare troppo velocemente la funz. 'u_ricevi_da_elenco()'

protected int ki_selecttab = 0
protected string ki_syntaxquery=" " 

//--- Contatore per Gestire troppi tab aperti, ovvero chiude il successivo per ri-occuparlo
private int ki_tab_rioccupato=0

//--- Appoggio x gestione abilitazione tasti funzionali
private boolean ki_tasti_funzionali_enabled[100]
private string ki_dataobject[100]

private kuf_utility kiuf_utility 

//--- flag x disabilitare l'uscita dopo la conferma se ad es. si è aperta una nuova window
private boolean ki_disattiva_exit = false 
//--- evita il RESIZE!
private boolean ki_resize = true

private int ki_tab_max
private int ki_tab_max_dw
private int ki_tab_max_web
private string ki_tab_elenco_typeof[]  // nome del tipo
private int ki_tab_selected[] // nr del tabpage selezionato per tipo a dw o wb 
private uo_g_tab_elenco_tabpage kiuo_g_tab_elenco_tabpage[]
private uo_g_tab_elenco_tabpage_web kiuo_g_tab_elenco_tabpage_web[]

end variables

forward prototypes
protected subroutine inizializza_lista ()
private subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
public function boolean u_riopen (st_open_w kst_open_w) throws uo_exception
public subroutine u_close_tab ()
protected subroutine stampa_esegui (st_stampe ast_stampe)
protected subroutine open_start_window ()
protected function string inizializza () throws uo_exception
protected subroutine attiva_tasti_0 ()
public subroutine u_resize_1 ()
public function integer u_open_tab () throws uo_exception
public function integer u_get_tab_x_key ()
protected subroutine u_win_show ()
protected subroutine u_win_hide ()
public function integer u_win_close ()
protected subroutine u_set_dw_selezionata ()
end prototypes

protected subroutine inizializza_lista ();//
//=== Routine override dello standard
//

	ki_st_open_w.key1 = trim(ki_st_open_w.key1)
	if trim(ki_st_open_w.key1) > " " then
	else
		ki_st_open_w.key1 = ""
	end if

	tab_1.selecttab(1)

	if ki_st_open_w.flag_primo_giro = 'S' then

		if ki_tab_elenco_typeof[tab_1.selectedtab] = "uo_g_tab_elenco_tabpage" then
			kiuo_g_tab_elenco_tabpage[ki_tab_selected[tab_1.selectedtab]].dw_1.drag( Cancel! )
			kiuo_g_tab_elenco_tabpage[ki_tab_selected[tab_1.selectedtab]].dw_sel.drag( Cancel! )
		end if
		
	end if


end subroutine

private subroutine smista_funz (string k_par_in);//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===

choose case trim(k_par_in) 

	case KKG_FLAG_RICHIESTA.refresh		//Aggiorna Liste
		if ki_tab_elenco_typeof[tab_1.selectedtab] = "uo_g_tab_elenco_tabpage" then  // tab con le dw
			kiuo_g_tab_elenco_tabpage[ki_tab_selected[tab_1.selectedtab]].leggi_liste()
		else
			kiuo_g_tab_elenco_tabpage_web[ki_tab_selected[tab_1.selectedtab]].u_refresh()
		end if

	case KKG_FLAG_RICHIESTA.inserimento		//richiesta inserimento
		if ki_tab_elenco_typeof[tab_1.selectedtab] = "uo_g_tab_elenco_tabpage" then  // tab con le dw
			if cb_inserisci.enabled = true then
				cb_inserisci.postevent(clicked!)
			end if
		end if

	case KKG_FLAG_RICHIESTA.cancellazione		//richiesta cancellazione
		if ki_tab_elenco_typeof[tab_1.selectedtab] = "uo_g_tab_elenco_tabpage" then  // tab con le dw
			if cb_cancella.enabled = true then
				cb_cancella.postevent(clicked!)
			end if
		end if

	case KKG_FLAG_RICHIESTA.conferma		//richiesta conferma
		if ki_tab_elenco_typeof[tab_1.selectedtab] = "uo_g_tab_elenco_tabpage" then  // tab con le dw
			if cb_conferma.enabled = true then
				cb_conferma.postevent(clicked!)
			end if
		end if

	case KKG_FLAG_RICHIESTA.visualizzazione		//richiesta visualizz
		if ki_tab_elenco_typeof[tab_1.selectedtab] = "uo_g_tab_elenco_tabpage" then  // tab con le dw
			if cb_visualizza.enabled = true then
				cb_visualizza.postevent(clicked!)
			end if
		end if

	case KKG_FLAG_RICHIESTA.modifica		//richiesta modifica
		if ki_tab_elenco_typeof[tab_1.selectedtab] = "uo_g_tab_elenco_tabpage" then  // tab con le dw
			if cb_modifica.enabled  then
				cb_modifica.postevent(clicked!)
			end if
		end if

	case KKG_FLAG_RICHIESTA.stampa		//richiesta stampa
		if ki_tab_elenco_typeof[tab_1.selectedtab] = "uo_g_tab_elenco_tabpage" then  // tab con le dw
			stampa()
		end if

	case KKG_FLAG_RICHIESTA.esci		//richiesta uscita
		if cb_ritorna.enabled = true then
			post close(this)
		end if
		
	case KKG_FLAG_RICHIESTA.libero1	//chiude il tab
		u_close_tab()
		
	case KKG_FLAG_RICHIESTA.libero2	//conferma selezionato come doppio-click
		if ki_tab_elenco_typeof[tab_1.selectedtab] = "uo_g_tab_elenco_tabpage" then  // tab con le dw
			cb_conferma.event clicked( )
		end if

	case KKG_FLAG_RICHIESTA.libero3	//mostra nascondi elenco selezionati
		if ki_tab_elenco_typeof[tab_1.selectedtab] = "uo_g_tab_elenco_tabpage" then  // tab con le dw
			kiuo_g_tab_elenco_tabpage[ki_tab_selected[tab_1.selectedtab]].mostra_elenco_selezionati()
		end if

	case KKG_FLAG_RICHIESTA.libero71	//zoom +
		if ki_tab_elenco_typeof[tab_1.selectedtab] = "uo_g_tab_elenco_tabpage" then  // tab con le dw
			kiuo_g_tab_elenco_tabpage[ki_tab_selected[tab_1.selectedtab]].u_zoom_piu()
		end if
	case KKG_FLAG_RICHIESTA.libero72	//zoom -
		if ki_tab_elenco_typeof[tab_1.selectedtab] = "uo_g_tab_elenco_tabpage" then  // tab con le dw
			kiuo_g_tab_elenco_tabpage[ki_tab_selected[tab_1.selectedtab]].u_zoom_meno()
		end if

	case else
		super::smista_funz(k_par_in)


end choose


end subroutine

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu
string k_lista, k_nome_controllo
boolean k_attiva


if ki_st_open_w.flag_primo_giro <> "S" then

	if m_main.m_finestra.m_gestione.m_fin_visualizza.enabled <> cb_visualizza.enabled then
		m_main.m_finestra.m_gestione.m_fin_visualizza.enabled = cb_visualizza.enabled
	end if
	if m_main.m_finestra.m_gestione.m_fin_modifica.enabled <> cb_modifica.enabled then
		m_main.m_finestra.m_gestione.m_fin_modifica.enabled = cb_modifica.enabled
	end if
	if m_main.m_finestra.m_gestione.m_fin_inserimento.enabled <> cb_inserisci.enabled then
		m_main.m_finestra.m_gestione.m_fin_inserimento.enabled = cb_inserisci.enabled
	end if

//end if
//	if kdsi_elenco_orig.rowcount() <> kidw_lista_elenco.rowcount() then
//		 m_main.m_finestra.m_aggiornalista.text = "Rirpistina elenco "
//		 m_main.m_finestra.m_aggiornalista.text = "Rirpistina elenco "
//	end if

//--- Chiude scheda
	if not m_main.m_strumenti.m_fin_gest_libero1.enabled  or not m_main.m_strumenti.m_fin_gest_libero1.visible then
		m_main.m_strumenti.m_fin_gest_libero1.text = "Chiudi scheda "
		m_main.m_strumenti.m_fin_gest_libero1.microhelp = "Chiudi scheda "
		m_main.m_strumenti.m_fin_gest_libero1.toolbaritemText = 	"Chiudi, Chiudi scheda Selezionata  "
//		m_main.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
//		m_main.m_strumenti.m_fin_gest_libero1.toolbaritemName = kGuo_path.get_risorse() + "\Cancel16.ico"
		m_main.m_strumenti.m_fin_gest_libero1.toolbaritemName = "close16.png"
		m_main.m_strumenti.m_fin_gest_libero1.visible = true
		m_main.m_strumenti.m_fin_gest_libero1.enabled = true
		m_main.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
	end if		
	m_main.m_strumenti.m_fin_gest_libero1.visible = m_main.m_strumenti.m_fin_gest_libero1.enabled
	
//--- Accende/spegne le funzioni
	if ki_tab_elenco_typeof[tab_1.selectedtab] = "uo_g_tab_elenco_tabpage" then
		k_attiva = true
	else
		k_attiva = false
		cb_conferma.enabled = false
	end if
	m_main.m_strumenti.m_fin_gest_libero2.enabled = k_attiva
	if m_main.m_strumenti.m_fin_gest_libero2.enabled  <> cb_conferma.enabled or not m_main.m_strumenti.m_fin_gest_libero2.visible then
		m_main.m_strumenti.m_fin_gest_libero2.text = "Importa riga/righe Selezionata "
		m_main.m_strumenti.m_fin_gest_libero2.microhelp = "Importa riga/righe Selezionata "
		m_main.m_strumenti.m_fin_gest_libero2.toolbaritemText = 	"Importa, Importa riga/righe Selezionata  "
//		m_main.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
//		m_main.m_strumenti.m_fin_gest_libero2.toolbaritemName = kGuo_path.get_risorse() + "\spunta.gif"
		m_main.m_strumenti.m_fin_gest_libero2.toolbaritemName = "spunta16.png"
		m_main.m_strumenti.m_fin_gest_libero2.visible = true
		m_main.m_strumenti.m_fin_gest_libero2.enabled = cb_conferma.enabled
		m_main.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
	end if		
	m_main.m_strumenti.m_fin_gest_libero2.visible = m_main.m_strumenti.m_fin_gest_libero2.enabled

////--- Come doppio-click
//	m_main.m_strumenti.m_fin_gest_libero3.enabled = k_attiva
//	if not m_main.m_strumenti.m_fin_gest_libero3.enabled  then 
//		m_main.m_strumenti.m_fin_gest_libero3.text = "Mostra/Nascondi elenco Righe già Selezonate "
//		m_main.m_strumenti.m_fin_gest_libero3.microhelp = "Mostra Elenco Selezionati "
//		m_main.m_strumenti.m_fin_gest_libero3.toolbaritemText = "Mostra, Mosta/Nascondi elenco Righe già Selezonate  "
////		m_main.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
//		m_main.m_strumenti.m_fin_gest_libero3.toolbaritemName = "PlaceColumn_2!"
//		m_main.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = false
//		m_main.m_strumenti.m_fin_gest_libero3.visible = false
//		m_main.m_strumenti.m_fin_gest_libero3.enabled = true
//	end if

//--- ZOOM
	if not m_main.m_strumenti.m_fin_gest_libero7.visible  then 
		m_main.m_strumenti.m_fin_gest_libero7.text = "Zoom sulla scheda aperta (usa anche i tasti più e meno)"
		m_main.m_strumenti.m_fin_gest_libero7.microhelp = "per lo Zoom usare anche + o -"
		m_main.m_strumenti.m_fin_gest_libero7.toolbaritemText = 	"ZOOM, Zoom sulla scheda aperta (usa anche + o -) "
//		m_main.m_strumenti.m_fin_gest_libero7.toolbaritembarindex=2
		m_main.m_strumenti.m_fin_gest_libero7.toolbaritemName = "zoom.png"
		m_main.m_strumenti.m_fin_gest_libero7.visible = true
		m_main.m_strumenti.m_fin_gest_libero7.enabled = k_attiva
		m_main.m_strumenti.m_fin_gest_libero7.toolbaritemVisible = true

		m_main.m_strumenti.m_fin_gest_libero7.libero1.text = "Ingrandicse la scheda aperta (usa anche il tasto più)"
		m_main.m_strumenti.m_fin_gest_libero7.libero1.microhelp = "Ingrandisce usare anche il + "
		m_main.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemText = 	"ZOOM+, Ingrandisce la scheda aperta (usa anche il +) "
//		m_main.m_strumenti.m_fin_gest_libero7.libero1.toolbaritembarindex=2
		m_main.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemName = "zoompiu.png"
		m_main.m_strumenti.m_fin_gest_libero7.libero1.visible = true
		m_main.m_strumenti.m_fin_gest_libero7.libero1.enabled = k_attiva
		m_main.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemVisible = true

		m_main.m_strumenti.m_fin_gest_libero7.libero2.text = "Diminuisce la scheda aperta (usa anche il tasto meno)"
		m_main.m_strumenti.m_fin_gest_libero7.libero2.microhelp = "Diminuisce usare anche il + "
		m_main.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemText = 	"ZOOM-, Diminuisce la scheda aperta (usa anche il -) "
//		m_main.m_strumenti.m_fin_gest_libero7.libero2.toolbaritembarindex=2
		m_main.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemName = "zoommeno.png"
		m_main.m_strumenti.m_fin_gest_libero7.libero2.visible = true
		m_main.m_strumenti.m_fin_gest_libero7.libero2.enabled = k_attiva
		m_main.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemVisible = true
		
		m_main.m_strumenti.m_fin_gest_libero7.visible = true

	end if
	//m_main.m_strumenti.m_fin_gest_libero7.libero1.visible = m_main.m_strumenti.m_fin_gest_libero7.libero1.enabled
	//m_main.m_strumenti.m_fin_gest_libero7.libero2.visible = m_main.m_strumenti.m_fin_gest_libero7.libero2.enabled

//---
	super::attiva_menu()

end if

end subroutine

public function boolean u_riopen (st_open_w kst_open_w) throws uo_exception;//---
//--- Controlla il primo TAB disponibile e lo ATTIVA
//---
boolean k_return = true
int k_tabselected

ki_disattiva_exit = true

super::u_riopen(kst_open_w)

k_tabselected = u_open_tab( )
tab_1.selecttab(k_tabselected)

ki_st_open_w.flag_primo_giro = "N"

return k_return

end function

public subroutine u_close_tab ();//
//--- close il tab cliccato
//
int k_ctr, k_tab_idx
int k_tab_selected


	if ki_tab_max > 0 then
//--- se ho un solo tab chiudo tutto!
		if ki_tab_max = 1 then
			cb_ritorna.POST event clicked( )
		else
			
			k_tab_selected = ki_tab_selected[tab_1.selectedtab]			
			if k_tab_selected > 0 then
				if ki_tab_elenco_typeof[tab_1.selectedtab] = "uo_g_tab_elenco_tabpage" then  // tab con le dw
					k_ctr = tab_1.closetab(kiuo_g_tab_elenco_tabpage[k_tab_selected])
					if k_ctr > 0  then
						ki_tab_max --
						ki_tab_max_dw --
					//--- ricompatta i tab DW
						for k_tab_idx = k_tab_selected to ki_tab_max_dw
							kiuo_g_tab_elenco_tabpage[k_tab_idx] = kiuo_g_tab_elenco_tabpage[k_tab_idx + 1]
						next
					end if	
				else
					k_ctr = tab_1.closetab(kiuo_g_tab_elenco_tabpage_web[k_tab_selected])
					if k_ctr > 0  then
						ki_tab_max --
						ki_tab_max_web --
					//--- ricompatta i tab WEB
						for k_tab_idx = k_tab_selected to ki_tab_max_dw
							kiuo_g_tab_elenco_tabpage[k_tab_idx] = kiuo_g_tab_elenco_tabpage[k_tab_idx + 1]
						next
					end if	
				end if		
				if k_ctr > 0  then
					if k_tab_selected > 1 then
						k_tab_selected --
					else
						k_tab_selected = 1
					end if
					tab_1.selecttab(k_tab_selected)
				end if
			end if
		end if
	end if

end subroutine

protected subroutine stampa_esegui (st_stampe ast_stampe);//
int k_tab_selected


	if ki_tab_elenco_typeof[tab_1.selectedtab] = "uo_g_tab_elenco_tabpage" then  // tab con le dw

		k_tab_selected = ki_tab_selected[tab_1.selectedtab]
	
		if isvalid(kidw_selezionata) then
			ast_stampe.dw_print = kidw_selezionata
		else
			if kiuo_g_tab_elenco_tabpage[k_tab_selected].dw_1.visible then
				ast_stampe.dw_print = kiuo_g_tab_elenco_tabpage[k_tab_selected].dw_1
			end if
		end if
		
		if isvalid(ast_stampe.dw_print) then
			if isvalid(kiuo_g_tab_elenco_tabpage[k_tab_selected].dw_1) then
				ast_stampe.titolo = trim(kiuo_g_tab_elenco_tabpage[k_tab_selected].dw_1.tag)
			else
				ast_stampe.titolo = trim(kiuo_g_tab_elenco_tabpage[k_tab_selected].dw_1.title)
			end if
			kGuf_data_base.stampa_dw(ast_stampe)
		else
			messagebox("Richiesta Stampa", "Stampa non eseguita, funzione non attiva")
		end if
		
	end if

end subroutine

protected subroutine open_start_window ();//
//
//-------------------------------------------------------------------------------------------------------------
//--- Window utilizzata per ZOOM da  Valori  delle varie Window
//---
//--- spesso in alternativa alla DROP-DATAWINDOWS (doppio click)
//----
//--- Parametri richiesti:
//--- KEY1 = Titolo da dare a questa scheda di ZOOM ("elenco/anteprima")
//--- KEY2 = nome data-window x l'elenco
//--- KEY3 = RISERVATO non usare xchè ritorna il numero di RIGA cliccato
//--- KEY4 = Titolo della Window chiamante
//--- KEY5 = RISERVATO da non usare
//--- KEY6 = nome campo che ha scatenato la chiamata a questo elenco
//--- KEY7 = flag N= non chiudere lo ZOOM dopo il DOPPIO CLICK (kuf_elenco.ki_esci_dopo_scelta) 
//--- KEY8 = da riempire SOLO se si vuole aprire il WebBrowser
//--- KEY12_any = reference al datastore con i dati da visualizzare
//---
//--- Nell'evento chiamato questi altri valori, oltre a quelli di cui sopra:
//--- KEY3 = numero della riga scelta dall'elenco
//---        0 = nessuna riga scelta
//--- KEY5 = nome campo che ha scatenato la chiamata a questo elenco
//-------------------------------------------------------------------------------------------------------------
//
int k_rc

try
	
	kiuf_utility = create kuf_utility

//--- apre nuovo tab 	
	u_open_tab( )
	tab_1.visible = true
	

catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
end try

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


	SetPointer(kkg.pointer_attesa)

//--- imposta gli oggetti standard
	if ki_tab_elenco_typeof[tab_1.selectedtab] = "uo_g_tab_elenco_tabpage" then

		kiuo_g_tab_elenco_tabpage[ki_tab_selected[tab_1.selectedtab]].inizializza()
		
	else
		
		kiuo_g_tab_elenco_tabpage_web[ki_tab_selected[tab_1.selectedtab]].inizializza()
		
	end if

	
	SetPointer(kkg.pointer_default)
	
return k_return



end function

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

long k_nr_righe
string k_lista, k_nome_controllo
int k_tab_selected
st_tab_menu_window_anteprima kst_tab_menu_window_anteprima


//setta_oggetti( )
k_tab_selected = tab_1.selectedtab

super::attiva_tasti_0()		 

st_aggiorna_lista.enabled = true
//--- queste dovrebbero essere di tipo GRID...
//kdw_focus = u_get_dw( )  //kGuf_data_base. u_getfocus_dw()

if k_tab_selected > 0 &
				and tab_1.selectedtab <= UpperBound(kiuo_g_tab_elenco_tabpage) then
		
	if not isvalid(kiuo_g_tab_elenco_tabpage[k_tab_selected].kidw_selezionata) then 
		st_ordina_lista.enabled = false
	else
		k_lista = kiuo_g_tab_elenco_tabpage[k_tab_selected].kidw_selezionata.Object.DataWindow.Processing
		if k_lista = "1"  then
			st_ordina_lista.enabled = true
		else
			st_ordina_lista.enabled = false
		end if
		
		kst_tab_menu_window_anteprima.anteprima = kiuo_g_tab_elenco_tabpage[k_tab_selected].kidw_selezionata.dataobject
		if kiuo_g_tab_elenco_tabpage[k_tab_selected].kidw_selezionata.dataobject <> ki_dataobject[tab_1.selectedtab] then  // se è cambiato qls ricontrolla
			
			ki_dataobject[tab_1.selectedtab] = kiuo_g_tab_elenco_tabpage[k_tab_selected].kidw_selezionata.dataobject 
			
		//	kuf1_menu = create kuf_menu
			if kguf_menu_window.get_st_tab_menu_window_anteprima(kst_tab_menu_window_anteprima) then // se Anteprima è apribile...
				ki_tasti_funzionali_enabled[tab_1.selectedtab] = true
			else
				ki_tasti_funzionali_enabled[tab_1.selectedtab] = false
			end if	
		//	destroy kuf1_menu
		end if
	end if
	cb_visualizza.enabled = ki_tasti_funzionali_enabled[tab_1.selectedtab]
	cb_modifica.enabled = ki_tasti_funzionali_enabled[tab_1.selectedtab]
	cb_inserisci.enabled = ki_tasti_funzionali_enabled[tab_1.selectedtab]
	kiuo_g_tab_elenco_tabpage[tab_1.selectedtab].set_ki_conferma(true)
else
	cb_visualizza.enabled = false
	cb_modifica.enabled = false
	cb_inserisci.enabled = false
end if

cb_ritorna.visible = false
cb_conferma.visible = false

cb_ritorna.enabled = true
cb_conferma.enabled = true


end subroutine

public subroutine u_resize_1 ();//
int k_tabpage_i, k_i


	this.classdefinition
	super::u_resize_1()

//--- Se tab_1 e visible oppure sono in prima volta
	this.setredraw(false)

//--- Dimensione dw nella window 
	tab_1.resize(this.width - 1, this.height - 1)
	
	k_tabpage_i = upperbound(tab_1.control[])
	for k_i = 1 to k_tabpage_i
		//tab_1.control[k_i].resize(tab_1.width - 80, tab_1.height - 180)
		tab_1.control[k_i].event DYNAMIC resize(tab_1.width - 130, tab_1.height - 30)
	next

	this.setredraw(true)



end subroutine

public function integer u_open_tab () throws uo_exception;//
int k_ind_tab, k_rc


//--- tab già aperto?
	k_ind_tab = u_get_tab_x_key()
	
	if k_ind_tab > 0 then

		if ki_tab_elenco_typeof[k_ind_tab] = "uo_g_tab_elenco_tabpage" then  // tab con le dw
			kiuo_g_tab_elenco_tabpage[ki_tab_selected[k_ind_tab]].kist_open_w = ki_st_open_w
			kiuo_g_tab_elenco_tabpage[ki_tab_selected[k_ind_tab]].dw_1.reset()
			kiuo_g_tab_elenco_tabpage[ki_tab_selected[k_ind_tab]].dw_sel.reset()
			kiuo_g_tab_elenco_tabpage[ki_tab_selected[k_ind_tab]].kids_elenco_orig.reset()
		else
			kiuo_g_tab_elenco_tabpage_web[ki_tab_selected[k_ind_tab]].kist_open_w = ki_st_open_w // tab con il webBrowser
		end if
		tab_1.selecttab(k_ind_tab)

		inizializza( )
		
	else
		
		ki_tab_max++ 
		
		if trim(ki_st_open_w.key8) > " " then // in questo caso apre un WebBrowser
			ki_tab_max_web++
			ki_tab_selected[ki_tab_max] = ki_tab_max_web
			k_rc = tab_1.OpenTabWithParm(kiuo_g_tab_elenco_tabpage_web[ki_tab_max_web],  trim(ki_st_open_w.key1), 0)
			if k_rc > 0 then	
				ki_tab_elenco_typeof[ki_tab_max] = "uo_g_tab_elenco_tabpage_web"
				kiuo_g_tab_elenco_tabpage_web[ki_tab_max_web].backcolor = tab_1.backcolor
				kiuo_g_tab_elenco_tabpage_web[ki_tab_max_web].kist_open_w = ki_st_open_w
				kiuo_g_tab_elenco_tabpage_web[ki_tab_max_web].tag = this.title 
				kiuo_g_tab_elenco_tabpage_web[ki_tab_max_web].kitab_1 = tab_1
			end if
		else
			ki_tab_max_dw++
			ki_tab_selected[ki_tab_max] = ki_tab_max_dw
			k_rc = tab_1.OpenTabWithParm(kiuo_g_tab_elenco_tabpage[ki_tab_max_dw],  trim(ki_st_open_w.key1), 0)
			if k_rc > 0 then				
				ki_tab_elenco_typeof[ki_tab_max] = "uo_g_tab_elenco_tabpage"
				kiuo_g_tab_elenco_tabpage[ki_tab_max_dw].backcolor = tab_1.backcolor
				kiuo_g_tab_elenco_tabpage[ki_tab_max_dw].kist_open_w = ki_st_open_w
				kiuo_g_tab_elenco_tabpage[ki_tab_max_dw].tag = this.title 
				kiuo_g_tab_elenco_tabpage[ki_tab_max_dw].kitab_1 = tab_1
			end if
		end if
		
		if k_rc > 0 then				
			
			tab_1.selecttab(ki_tab_max)

			inizializza( )

			u_resize()
		
			post attiva_tasti()

			k_ind_tab = ki_tab_max
			
		else
			
			ki_tab_max --
			
		end if
	end if

return k_ind_tab

end function

public function integer u_get_tab_x_key ();//---
//--- Torna il numero se il TAB è già aperto cercato per chiave 
//---
//--- torna: ZERO = tab non ancora aperto
//---            > 0 il numero del TAB
//---
int k_return
int k_max_tab, k_ind_tab


k_max_tab = upperbound(tab_1.control[])

if k_max_tab > 0 then

	for k_ind_tab = 1 to k_max_tab 

		if ki_tab_elenco_typeof[k_ind_tab] = "uo_g_tab_elenco_tabpage" then

			if kiuo_g_tab_elenco_tabpage[k_ind_tab].kist_open_w.key2 = ki_st_open_w.key2 &
				  and  kiuo_g_tab_elenco_tabpage[k_ind_tab].kist_open_w.key1 =  ki_st_open_w.key1 then
				k_return = k_ind_tab  //--- trovato tab uguale
				exit
			end if
		
		else

			if kiuo_g_tab_elenco_tabpage[k_ind_tab].kist_open_w.key8 = ki_st_open_w.key8 then
			  	k_return = k_ind_tab  //--- trovato tab uguale
				exit
			end if
		
		end if

	next
	
end if

return k_return

end function

protected subroutine u_win_show ();//
tab_1.move(0, 0)

end subroutine

protected subroutine u_win_hide ();//
tab_1.move(30000, 30000)

end subroutine

public function integer u_win_close ();//
int k_return 


k_return = super::u_win_close( )

//if isvalid(kiuo_g_tab_elenco_tabpage[tab_1.selectedtab].kist_open_w.key10_window_chiamante) then
//
//	kiuo_g_tab_elenco_tabpage[tab_1.selectedtab].kist_open_w.key10_window_chiamante.BringToTop = TRUE
//	kiuo_g_tab_elenco_tabpage[tab_1.selectedtab].kist_open_w.key10_window_chiamante.setfocus()
//	
//end if

return k_return
end function

protected subroutine u_set_dw_selezionata ();//---
//--- Set il DW attivo
//---

	if ki_tab_elenco_typeof[tab_1.selectedtab] = "uo_g_tab_elenco_tabpage" then  // tab con le dw
		kidw_selezionata = kiuo_g_tab_elenco_tabpage[ki_tab_selected[tab_1.selectedtab]].dw_1
	end if


end subroutine

on w_g_tab_elenco.create
int iCurrent
call super::create
this.cb_visualizza=create cb_visualizza
this.cb_modifica=create cb_modifica
this.cb_conferma=create cb_conferma
this.cb_cancella=create cb_cancella
this.cb_inserisci=create cb_inserisci
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_visualizza
this.Control[iCurrent+2]=this.cb_modifica
this.Control[iCurrent+3]=this.cb_conferma
this.Control[iCurrent+4]=this.cb_cancella
this.Control[iCurrent+5]=this.cb_inserisci
this.Control[iCurrent+6]=this.tab_1
end on

on w_g_tab_elenco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_visualizza)
destroy(this.cb_modifica)
destroy(this.cb_conferma)
destroy(this.cb_cancella)
destroy(this.cb_inserisci)
destroy(this.tab_1)
end on

event u_open_preliminari;call super::u_open_preliminari;//
	ki_nome_save = trim(this.ClassName())

//--- Parametri passati con il WITHPARM
	ki_st_open_w = message.powerobjectparm
	ki_st_open_w.key3 = " "
	ki_nome_save =  trim(ki_st_open_w.key2)

	//ki_st_open_w = kist1_open_w

	
end event

event open;//
//
long k_ctr


//--- INIZIO OPERAZIONI PRELIMINARI --------------------------------------------------------------------------

//sembra nascondere il puntatore	this.setredraw(false)
	
//--- Importante: personalizzazione x i figli	
	event u_open_preliminari()   

//--- assegna il puntatore alla Window x renderlo visibile negli script
	kiw_this_window = this
	
//--- setta la directory di base
	kGuf_data_base.setta_path_default ()

//--- setta il titolo della window
	set_titolo_window()

//--- oggetto utile alla sincronizzazione con una window chiamata, es canc di una riga dall'elenco
	kiuf1_sync_window = create kuf_sync_window

//---- oggetto generico 
	kiuf_parent = create kuf_parent

//--- FINE !!!! OPERAZIONI PRELIMINARI --------------------------------------------------------------------------

	setpointer(kkg.pointer_attesa)


//--- altre operazioni
	post event u_open( )




end event

event u_open;call super::u_open;//
//--- setta la directory di base
	kGuf_data_base.setta_path_default ()

	set_titolo_window()

	inizializza_lista()
	
	fine_primo_giro()

	u_resize()

	

end event

type dw_print_0 from w_g_tab`dw_print_0 within w_g_tab_elenco
end type

type st_ritorna from w_g_tab`st_ritorna within w_g_tab_elenco
end type

type st_ordina_lista from w_g_tab`st_ordina_lista within w_g_tab_elenco
end type

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_g_tab_elenco
integer x = 1961
integer y = 1140
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_g_tab_elenco
integer x = 2523
integer y = 1088
integer width = 329
integer height = 88
end type

type st_stampa from w_g_tab`st_stampa within w_g_tab_elenco
integer x = 1961
integer y = 1012
end type

type cb_visualizza from commandbutton within w_g_tab_elenco
boolean visible = false
integer x = 2528
integer y = 644
integer width = 329
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Visualizza"
boolean default = true
end type

event clicked;//
try

	if tab_1.selectedtab > 0 then
		kiuo_g_tab_elenco_tabpage[tab_1.selectedtab].u_esegui_funzione(kkg_flag_modalita.visualizzazione)
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try
end event

type cb_modifica from commandbutton within w_g_tab_elenco
boolean visible = false
integer x = 2528
integer y = 868
integer width = 329
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Modifica"
end type

event clicked;//

	if tab_1.selectedtab > 0 then
		kiuo_g_tab_elenco_tabpage[tab_1.selectedtab].u_esegui_funzione(kkg_flag_modalita.modifica)
	end if

end event

type cb_conferma from commandbutton within w_g_tab_elenco
boolean visible = false
integer x = 69
integer y = 832
integer width = 329
integer height = 88
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Seleziona"
end type

event clicked;//
if tab_1.selectedtab > 0 then
	
	if kiuo_g_tab_elenco_tabpage[tab_1.selectedtab].dw_1.enabled then
		kiuo_g_tab_elenco_tabpage[tab_1.selectedtab].dw_1.enabled = false
		
		//setta_oggetti( )
		if kiuo_g_tab_elenco_tabpage[tab_1.selectedtab].conferma_dati( ) = "EXIT" then
		
			cb_ritorna.post event clicked( )
			
		else
			
			attiva_tasti( )
			kiuo_g_tab_elenco_tabpage[tab_1.selectedtab].dw_1.enabled = true
	
		end if
	end if
end if

end event

event getfocus;//
attiva_tasti( )

end event

type cb_cancella from commandbutton within w_g_tab_elenco
boolean visible = false
integer x = 2528
integer y = 756
integer width = 329
integer height = 88
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Elimina"
end type

event clicked;//
//cancella()
end event

type cb_inserisci from commandbutton within w_g_tab_elenco
boolean visible = false
integer x = 2528
integer y = 532
integer width = 329
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Nuovo"
end type

event clicked;//

	if tab_1.selectedtab > 0 then
		kiuo_g_tab_elenco_tabpage[tab_1.selectedtab].u_esegui_funzione(kkg_flag_modalita.inserimento)
	end if

end event

type tab_1 from tab within w_g_tab_elenco
event ue_exit ( )
boolean visible = false
integer width = 3886
integer height = 872
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 31449055
boolean multiline = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean powertips = true
boolean boldselectedtext = true
tabposition tabposition = tabsonleft!
integer selectedtab = 1
end type

event ue_exit();//
u_close_tab()


end event

event constructor;//
this.backcolor = parent.backcolor

end event

event selectionchanged;//
if upperbound(ki_tab_elenco_typeof) >= newindex then
	if ki_tab_elenco_typeof[newindex] = "uo_g_tab_elenco_tabpage" then  // tab con le dw
	
		post u_set_dw_selezionata()
	
		post attiva_tasti( )
		
	end if
end if
end event

