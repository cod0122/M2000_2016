$PBExportHeader$w_meca_parziali.srw
forward
global type w_meca_parziali from w_g_tab0
end type
type dw_data from uo_d_std_1 within w_meca_parziali
end type
end forward

global type w_meca_parziali from w_g_tab0
integer width = 5038
integer height = 4180
boolean ki_reset_dopo_save_ok = false
boolean ki_consenti_inserisci = false
boolean ki_reselect_row_if_updated = false
dw_data dw_data
end type
global w_meca_parziali w_meca_parziali

type variables
//
private kuf_meca_parziali kiuf_meca_parziali
private kuf_armo kiuf_armo
private kuf_clienti kiuf_clienti
private kuf_utility kiuf_utility

private st_tab_meca_parziali kist_tab_meca_parziali
private date ki_data_start, ki_data_start_old
private string ki_ultimo_codice_cercato = "#########"
private int ki_ulimo_stato_cercato = 9999

end variables

forward prototypes
protected subroutine attiva_menu ()
public subroutine smista_funz (string k_par_in)
private subroutine cambia_data ()
protected subroutine open_start_window ()
public function integer u_retrieve_dw_lista ()
protected function string inizializza () throws uo_exception
protected function integer modifica ()
protected function integer visualizza ()
protected subroutine riempi_id ()
public subroutine u_copia_massiva (string a_column)
protected function string cancella ()
protected subroutine attiva_tasti_0 ()
end prototypes

protected subroutine attiva_menu ();//
//--- Attiva/Dis. Voci di menu personalizzate
//
long k_row
string k_note, k_stato_x


	if not m_main.m_strumenti.m_fin_gest_libero1.visible then
	
		m_main.m_strumenti.m_fin_gest_libero1.text = "Cambia data estrazione Lotti"
		m_main.m_strumenti.m_fin_gest_libero1.microhelp = "Cambia data estrazione Lotti"
		m_main.m_strumenti.m_fin_gest_libero1.enabled = true
		m_main.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Data,"+m_main.m_strumenti.m_fin_gest_libero1.text
		m_main.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Custom015!"
		m_main.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
		m_main.m_strumenti.m_fin_gest_libero1.visible = true
		m_main.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
		
	end if
	
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
		k_row = dw_dett_0.getselectedrow(0)
		if k_row > 0 and dw_dett_0.getselectedrow(k_row) > 0 then
			k_stato_x = dw_dett_0.Describe("Evaluate('LookupDisplay(stato)', " + String(k_row) + ")")
			k_note = trim(dw_dett_0.getitemstring(k_row, "note"))
			if k_note > " " then
			else
				k_note = "<spazio>"
			end if
		
			m_main.m_strumenti.m_fin_gest_libero7.libero1.text = "Copia Stato e Note nelle righe selezionate a '" + k_stato_x + "' " + "e '" + k_note + "'" 
			m_main.m_strumenti.m_fin_gest_libero7.libero1.microhelp = "Copia Stato e Note nelle righe selezionate"
			m_main.m_strumenti.m_fin_gest_libero7.libero1.enabled = true
			
			m_main.m_strumenti.m_fin_gest_libero7.libero2.text = "Copia lo Stato nelle righe selezionate a '" + k_stato_x + "'"
			m_main.m_strumenti.m_fin_gest_libero7.libero2.microhelp = "Copia lo Stato nelle righe selezionate"
			m_main.m_strumenti.m_fin_gest_libero7.libero2.enabled = true
			m_main.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemText = "Copia," + m_main.m_strumenti.m_fin_gest_libero7.libero2.text
			m_main.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemName = "Custom079a!"
			m_main.m_strumenti.m_fin_gest_libero7.libero2.toolbaritembarindex=2
			
			m_main.m_strumenti.m_fin_gest_libero7.libero3.text = "Copia le Note nelle righe selezionate a '" + k_note + "'"
			m_main.m_strumenti.m_fin_gest_libero7.libero3.microhelp = "Copia le Note nelle righe selezionate"
			m_main.m_strumenti.m_fin_gest_libero7.libero3.enabled = true
			m_main.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemText = "Copia," + m_main.m_strumenti.m_fin_gest_libero7.libero3.text
			m_main.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemName = "Custom079a!"
			m_main.m_strumenti.m_fin_gest_libero7.libero3.toolbaritembarindex=2

			m_main.m_strumenti.m_fin_gest_libero7.toolbaritemText = "Copia,"+m_main.m_strumenti.m_fin_gest_libero7.libero1.text
			
		else
			
			m_main.m_strumenti.m_fin_gest_libero7.libero1.text = "Copia,Selezionare almeno una riga per copiare Stato e Note."
			m_main.m_strumenti.m_fin_gest_libero7.libero1.microhelp = "Selezionare almeno una riga per copiare Stato e Note."
			m_main.m_strumenti.m_fin_gest_libero7.libero1.enabled = false
			
		end if
	else
		m_main.m_strumenti.m_fin_gest_libero7.libero1.text = "Copia Stato e Note massiva non abilitata."
		m_main.m_strumenti.m_fin_gest_libero7.libero1.microhelp = "Copia Stato e Note non abilitata."
		m_main.m_strumenti.m_fin_gest_libero7.libero1.enabled = false
	end if	
	m_main.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemText = "Copia," + m_main.m_strumenti.m_fin_gest_libero7.libero1.text
	m_main.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemName = "Custom079a!"
	m_main.m_strumenti.m_fin_gest_libero7.libero1.toolbaritembarindex=2
	m_main.m_strumenti.m_fin_gest_libero7.libero1.visible = true
	m_main.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemVisible = true

	super::attiva_menu()


end subroutine

public subroutine smista_funz (string k_par_in);//
//===

choose case k_par_in 


	case KKG_FLAG_RICHIESTA.libero1	//cambia data estrazione scadenze
		cambia_data()
		
//	case KKG_FLAG_RICHIESTA.libero70	//Imposta Stato e Note x le righe selezionate come la prima
//		u_copia_massiva("")
	case KKG_FLAG_RICHIESTA.libero71	//Imposta Stato e Note x le righe selezionate come la prima
		u_copia_massiva("")
	case KKG_FLAG_RICHIESTA.libero72	//Imposta Stato x le righe selezionate come la prima
		u_copia_massiva("stato")
	case KKG_FLAG_RICHIESTA.libero73	//Imposta Note x le righe selezionate come la prima
		u_copia_massiva("note")
				
	case else
		super::smista_funz(k_par_in)

end choose



end subroutine

private subroutine cambia_data ();//---
//--- Visualizza il box x il cambio DATA
//---


dw_data.triggerevent("ue_visibile")

end subroutine

protected subroutine open_start_window ();//
long k_rc=0
//datawindowchild kdwc_cliente

	
	ki_sincronizza_window_consenti = false		// inizialmente nessuna sincronizzazione permessa
	
	kiuf_meca_parziali = create kuf_meca_parziali
   kiuf_armo = create kuf_armo
   kiuf_clienti = create kuf_clienti
   kiuf_utility = create kuf_utility

//---
	kist_tab_meca_parziali.id_meca = long(trim(ki_st_open_w.key1))  // ID lotto
	if isnull(kist_tab_meca_parziali.id_meca ) then
		kist_tab_meca_parziali.id_meca = 0
	end if
//	kist_tab_meca.clie_1 =  long(trim(ki_st_open_w.key2))  // codice mandante/cliente
//	if isnull(kist_tab_meca.clie_1) then
//		kist_tab_meca.clie_1 = 0
//	end if
	if trim(ki_st_open_w.key3) = "" then									// da quale data partire
		if isdate(trim(ki_st_open_w.key3)) then
			ki_data_start = date(trim(ki_st_open_w.key3))
		else
			ki_data_start = relativedate(kg_dataoggi, -180)
		end if
	else
		ki_data_start = relativedate(kg_dataoggi, -180)
	end if

	dw_guida.insertrow(0)

end subroutine

public function integer u_retrieve_dw_lista ();//---
//---  Fa la Retrieve
//---
long k_return=0, k_rowsPrev
long k_clie_3
date k_data_fine = date(9999,01,01)
	
	
	k_rowsPrev = dw_dett_0.rowcount( )
	
	ki_win_titolo_custom = "" 
	if kist_tab_meca_parziali.id_meca > 0 then
		ki_win_titolo_custom += "per ID lotto " + string(kist_tab_meca_parziali.id_meca) 
	else
//		if kist_tab_meca_parziali.id > 0 then
//			ki_win_titolo_custom += "per WO di E1 " + string(kist_tab_meca_parziali.e1doco) + " (id Lotto " + string(kist_tab_meca_parziali.id) + ")"  
//		
//		else
			ki_win_titolo_custom = "dal " + string(ki_data_start) 
			k_clie_3 = dw_guida.getitemnumber(dw_guida.getrow(), "id")
			if k_clie_3 > 0 then
				ki_win_titolo_custom += " e anagrafica " + string(k_clie_3) 
			else
				k_clie_3 = 0
			end if
//		end if
	end if
	
	k_return = dw_dett_0.retrieve(kist_tab_meca_parziali.id_meca, ki_ulimo_stato_cercato, k_clie_3, ki_data_start, k_data_fine)
	
	if k_return > 0 then
		ki_sincronizza_window_consenti = true		// attivo sincronizzazione 
	else
		ki_sincronizza_window_consenti = false		// nessuna sincronizzazione permessa
	end if
	
	
	if (k_rowsPrev > 0 and k_return = 0) or (k_rowsPrev = 0 and k_return > 0) then
		attiva_tasti( )
	end if
	
return k_return
	

end function

protected function string inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
int k_rc

	SetPointer(kkg.pointer_attesa)

//--- Se non ho richiesto un codice particolare mi fermo x chiedere
	if ki_st_open_w.flag_primo_giro = "S" and kist_tab_meca_parziali.id_meca = 0 and ki_ultimo_codice_cercato = "#########" and ki_ulimo_stato_cercato = 9999 then

		k_rc = dw_guida.setitem(1,"parziali", 0)
		dw_guida.setitem(1,"codice", "")
		dw_guida.setcolumn("codice")
		dw_guida.setfocus( )

		dw_dett_0.u_proteggi_dw("1", 0)

	else
		if ki_st_open_w.flag_primo_giro <> "S" or kist_tab_meca_parziali.id_meca = 0 or ki_ultimo_codice_cercato = "#########" or ki_ulimo_stato_cercato = 9999 then

			if kist_tab_meca_parziali.id_meca > 0 then
				if trim(dw_guida.getitemstring(1,"codice")) > " " then
				else
					dw_guida.setitem(1,"codice", string(kist_tab_meca_parziali.id_meca ))
				end if
			end if

			dw_guida.event ue_buttonclicked("default")
			
		end if
	end if

return k_return


end function

protected function integer modifica ();//

if dw_dett_0.rowcount() > 0 then
	dw_dett_0.u_proteggi_dw("0", 0)
end if

return 1

end function

protected function integer visualizza ();//

if dw_dett_0.rowcount() > 0 then
	dw_dett_0.u_proteggi_dw("1", 0)
end if

return 1

end function

protected subroutine riempi_id ();//
long k_row


k_row = dw_dett_0.getnextmodified( k_row, primary!)
do while k_row > 0

	if dw_dett_0.getitemnumber(k_row, "id_meca") > 0 then  
	else
		if dw_dett_0.getitemnumber(k_row, "stato") > 0 then
			dw_dett_0.setitem(k_row, "id_meca", dw_dett_0.getitemnumber(k_row, "meca_id"))
			dw_dett_0.setitem(k_row, "x_datins", kGuf_data_base.prendi_x_datins())
			dw_dett_0.setitem(k_row, "x_utente", kGuf_data_base.prendi_x_utente())
			dw_dett_0.setitemstatus(k_row, 0, primary!, NewModified!)
		else
			dw_dett_0.setitemstatus(k_row, 0, primary!, notmodified!)
		end if
	end if

	k_row = dw_dett_0.getnextmodified( k_row, primary!)
		
loop

end subroutine

public subroutine u_copia_massiva (string a_column);/*
  Cambia lo STATO delle righe Selezionate
*/
long k_rows
int k_row
int k_stato
string k_note

	
	k_row = dw_dett_0.getselectedrow(0)
	if k_row > 0 then
		if a_column = "stato" or a_column <> "note" then
			k_stato = dw_dett_0.getitemnumber(k_row, "stato")
		end if
		if a_column = "note" or a_column <> "stato" then
			k_note = trim(dw_dett_0.getitemstring(k_row, "note"))
			if isnull(k_note) then k_note = ""
		end if
	end if

	do while k_row > 0 
		
		if a_column = "stato" or a_column <> "note" then
			dw_dett_0.setitem(k_row, "stato", k_stato)
		end if
		if a_column = "note" or a_column <> "stato" then
			dw_dett_0.setitem(k_row, "note", k_note)
		end if

		k_row = dw_dett_0.getselectedrow(k_row)

	loop

end subroutine

protected function string cancella ();
return " "
end function

protected subroutine attiva_tasti_0 ();//
super::attiva_tasti_0( )
cb_cancella.enabled = false
end subroutine

on w_meca_parziali.create
int iCurrent
call super::create
this.dw_data=create dw_data
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_data
end on

on w_meca_parziali.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_data)
end on

event close;call super::close;//
	if isvalid(kiuf_armo) then destroy kiuf_armo
	if isvalid(kiuf_clienti) then destroy kiuf_clienti
	if isvalid(kiuf_utility) then destroy kiuf_utility
	if isvalid(kiuf_meca_parziali) then destroy kiuf_meca_parziali

end event

event u_open;call super::u_open;//
	ki_win_titolo_custom = " dalla data del " + string(ki_data_start) 

end event

type dw_print_0 from w_g_tab0`dw_print_0 within w_meca_parziali
end type

type st_ritorna from w_g_tab0`st_ritorna within w_meca_parziali
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_meca_parziali
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_meca_parziali
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_meca_parziali
end type

type st_stampa from w_g_tab0`st_stampa within w_meca_parziali
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_meca_parziali
end type

type cb_modifica from w_g_tab0`cb_modifica within w_meca_parziali
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_meca_parziali
end type

type cb_cancella from w_g_tab0`cb_cancella within w_meca_parziali
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_meca_parziali
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_meca_parziali
boolean enabled = true
string dataobject = "d_meca_parziali_l"
pointer kipointer_orig = help!
boolean ki_link_standard_sempre_possibile = true
boolean ki_attiva_standard_select_row = true
boolean ki_d_std_1_attiva_cerca = true
boolean ki_dw_visibile_in_open_window = true
end type

event dw_dett_0::itemchanged;call super::itemchanged;//
if dwo.name = "note" then
	if this.getitemnumber(row, "id_meca") > 0 then
	else
		if this.getitemnumber(row, "stato") > 0 then
		else
			this.post setitem(row, "stato", 1)
		end if
	end if
end if

	
end event

event dw_dett_0::clicked;call super::clicked;//
if dwo.Name = "b_select_all" then
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
		this.selectrow( 0, true)
	else
		messagebox("Seleziona tutte le Righe", "Operazione permessa solo in Modifica", information!)
	end if
end if
	

end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_meca_parziali
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_meca_parziali
integer y = 116
boolean enabled = false
boolean ki_dw_visibile_in_open_window = false
end type

type dw_guida from w_g_tab0`dw_guida within w_meca_parziali
event u_clear ( )
boolean visible = true
integer x = 0
integer y = 0
integer width = 3616
boolean enabled = true
string dataobject = "d_meca_meca_parziali_guida"
end type

event dw_guida::u_clear();//
	this.setitem(1, "codice", "")
	kist_tab_meca_parziali.id_meca = 0	
	ki_ultimo_codice_cercato="#########"

end event

event dw_guida::clicked;call super::clicked;//
if dwo.name = "b_clear" then
	event u_clear()
end if
end event

event dw_guida::rowfocuschanged;call super::rowfocuschanged;//
this.setrow( currentrow )
end event

event dw_guida::ue_dwnkey;call super::ue_dwnkey;//

end event

event dw_guida::ue_buttonclicked;call super::ue_buttonclicked;//---
boolean k_elabora, k_dato_valido
string k_codice_x, k_numero_x, k_anno_x, k_cliente_x, k_msg
int k_pos
long k_codice, k_rows, k_row
long k_clie_3=999999
long k_e1doco=999999
st_esito kst_esito
st_tab_armo kst_tab_armo
st_tab_meca kst_tab_meca


try
	kist_tab_meca_parziali.id_meca = 0
	k_clie_3 = 0
	k_e1doco = 0
	this.selectrow( 0, false)

	k_row = this.getrow()
	if k_row > 0 then
	else
		k_row = 1
	end if


//--- solo se ricerco un codice diverso
	k_codice_x = trim(this.getitemstring(k_row, "codice"))
	if isnull(k_codice_x) then k_codice_x = ""
	if dw_lista_0.rowcount( ) > 0 and ki_ultimo_codice_cercato = k_codice_x and k_codice_x = "" &
					and ki_data_start = ki_data_start_old &
					and ki_ulimo_stato_cercato = this.getitemnumber(k_row, "parziali") then
		return
	end if
	
	ki_data_start_old = ki_data_start  //salva data inizio estrazione
	ki_ultimo_codice_cercato = k_codice_x 
	ki_ulimo_stato_cercato = this.getitemnumber(k_row, "parziali")

//--- se la stringa di ricerca è vuota allora mostra tutto			
	if trim(k_codice_x) > " " then 	
	else
		k_elabora = true
		k_dato_valido = true
	end if

	if not k_elabora then
		if isnumber(k_codice_x) then
			k_dato_valido = true
			k_codice = long(k_codice_x)
	// se minore di 50 mila sicuramente si tratta di un numero lotto altrimenti probabile ID lotto 
			if k_codice < 50000 then 
				kst_tab_armo.num_int = k_codice
				kst_tab_armo.data_int = date(kguo_g.get_anno( ), 01, 01)
				kiuf_armo.get_id_meca(kst_tab_armo)
			else
				kst_tab_armo.id_meca = k_codice
			end if
			kist_tab_meca_parziali.id_meca = kst_tab_armo.id_meca
			if kist_tab_meca_parziali.id_meca > 0 then //or k_clie_3 > 0 then
				k_elabora = true
			end if
		end if
	end if

	if not (k_elabora or k_dato_valido) then
		//--- se n.lotto / anno 
		k_pos = pos(k_codice_x, "/", 1) 
		if k_pos > 1 then
			k_numero_x = trim(left(k_codice_x, k_pos - 1))
			k_anno_x = trim(mid(k_codice_x, k_pos + 1))
			if len(trim(k_anno_x)) < 4 then
				if len(trim(k_anno_x)) = 2 then
					k_anno_x = '20' + trim(k_anno_x)
				else
					k_anno_x = string(kguo_g.get_anno( ))
				end if
			end if
			if isnumber(k_numero_x) then
				k_dato_valido = true
				kst_tab_armo.num_int = long(k_numero_x)
				kst_tab_armo.data_int = date(integer(k_anno_x), 01, 01)
				kiuf_armo.get_id_meca(kst_tab_armo)
				kist_tab_meca_parziali.id_meca = kst_tab_armo.id_meca
				if kist_tab_meca_parziali.id_meca > 0 then 
					k_elabora = true
				end if
			end if
		end if
	end if

	if not (k_elabora or k_dato_valido) then
		//--- se ricerca per WO (wonnnnn)
		k_pos = pos(lower(k_codice_x), "wo", 1)  
		if k_pos > 0 then
			k_numero_x = trim(mid(k_codice_x, k_pos + 2))
			if isnumber(k_numero_x) then
				
				k_dato_valido = true
				k_e1doco = long(k_numero_x)
				kst_tab_meca.e1doco = k_e1doco
				kiuf_armo.get_id_meca_da_e1doco(kst_tab_meca)
				
				if kist_tab_meca_parziali.id_meca > 0 then 
					k_elabora = true
				end if
			end if
		end if
	end if
		
	if not (k_elabora or k_dato_valido) then
		//--- se ricerca per ID LOTTO (idnnnnn o ASNnnnnnnn)
		k_pos = pos(lower(k_codice_x), "id", 1)  
		if k_pos = 0 then
			k_pos = pos(lower(k_codice_x), "asn", 1)  
		end if
		if k_pos > 0 then
			k_numero_x = trim(mid(k_codice_x, k_pos + 2))
			if isnumber(k_numero_x) then
				k_dato_valido = true
				kist_tab_meca_parziali.id_meca = long(k_numero_x)
				k_elabora = true
			end if
		end if
	end if
		
	if not (k_elabora or k_dato_valido) then
		//--- se ricerca per CLIENTE (cnnnnn)
		k_pos = pos(lower(k_codice_x), "c", 1)  
		if k_pos > 0 then
			k_numero_x = trim(mid(k_codice_x, k_pos + 1))
			if isnumber(k_numero_x) then
				k_dato_valido = true
				k_clie_3 = long(k_numero_x)
				k_cliente_x = k_numero_x
				k_elabora = true
			end if
		end if
	end if
		
	//--- se ricerca per anagrafica (goglio...)
	if not (k_elabora or k_dato_valido) then
		if mid(k_codice_x, 3, 1) > " " then   
			k_dato_valido = true
			k_codice_x = upper(trim(k_codice_x))
			k_clie_3 = kiuf_clienti.get_clie_3_da_rag_soc(k_codice_x)
			if k_clie_3 > 0 then
				k_cliente_x = string(k_clie_3)
				dw_guida.setitem(k_row, "codice", k_codice_x)
				k_elabora = true
			end if
		end if
	end if
	
//--- Ho trovato dati ne Codice...
	if k_elabora then
		if kist_tab_meca_parziali.id_meca > 0 then
			this.setitem(k_row, "id", kist_tab_meca_parziali.id_meca)
		else
			if k_clie_3 > 0 then
				this.setitem(k_row, "id", k_clie_3)
			else 
				this.setitem(k_row, "id", 0)
			end if
		end if
	end if
		
	if k_dato_valido then
		k_rows = u_retrieve_dw_lista()  // leggi elenco
	end if
	
	if (k_elabora and k_rows = 0) or (not k_elabora and k_dato_valido) then
		messagebox("Ricerca Lotti", "Nessun Lotto trovato per la richiesta fatta")
	else
		if not k_dato_valido then
			k_msg = kiuf_utility.u_get_tooltip_text(this.describe("b_ok.Tooltip.Tip"))
			kguo_exception.inizializza()
			kguo_exception.messaggio_utente( "Dato non accettato", k_msg ) //this.describe("b_ok.Tooltip.Tip"))
		else
			//this.insertrow(0)
			//this.setitem(this.rowcount(), "codice", this.getitemstring(k_row, "codice"))
			//this.setitem(this.rowcount(), "id", this.getitemnumber(k_row, "id"))
			//this.scrolltorow(this.rowcount())
		end if
	end if

catch (uo_exception kuo_exception)

finally

end try
end event

type st_duplica from w_g_tab0`st_duplica within w_meca_parziali
end type

type dw_data from uo_d_std_1 within w_meca_parziali
event u_cb_ok ( )
integer x = 2382
integer y = 256
integer width = 887
integer height = 580
integer taborder = 90
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "estrae dal"
string dataobject = "d_data"
boolean controlmenu = true
boolean resizable = true
boolean hsplitscroll = false
boolean livescroll = false
end type

event u_cb_ok();//
	this.visible = false
	this.accepttext( )
	ki_data_start  = this.getitemdate( 1, "kdata")
	dw_guida.event ue_buttonclicked("default")
	

end event

event buttonclicked;call super::buttonclicked;//
st_stampe kst_stampe
pointer oldpointer  // Declares a pointer variable

	
//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)
	

if dwo.name = "b_ok" then
	
	event u_cb_ok( )
	
else
	if dwo.name = "b_annulla" then

		this.visible = false
	
	
	end if
end if

SetPointer(oldpointer)


end event

event u_pigiato_enter;//
event u_cb_ok( )

end event

event ue_visibile;call super::ue_visibile;//
int k_rc

	this.width = long(this.object.kdata.x) + long(this.object.kdata.width) + 100
	this.height = long(this.object.b_ok.y) + long(this.object.b_ok.height) + 260

	this.x = (kiw_this_window.width  - this.width) / 4
	this.y = (kiw_this_window.height - this.height) / 4

	this.reset()
	k_rc = this.insertrow(0)
	k_rc = this.setitem(1, "kdata", ki_data_start)
	this.visible = true
	this.setfocus()
end event

