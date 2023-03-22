$PBExportHeader$w_ptasks_l.srw
forward
global type w_ptasks_l from w_g_tab0
end type
end forward

global type w_ptasks_l from w_g_tab0
integer width = 3022
integer height = 1504
string title = "SL-PT"
boolean ki_toolbar_window_presente = true
end type
global w_ptasks_l w_ptasks_l

type variables

private st_ptasks_guida kist_ptasks_guida_last_retrieve
private kuf_ptasks kiuf_ptasks


end variables

forward prototypes
private function string cancella ()
protected function integer visualizza ()
private function string inizializza ()
protected subroutine open_start_window ()
public function integer u_retrieve_dw_lista ()
protected function integer modifica ()
protected function integer inserisci ()
protected subroutine attiva_menu ()
public subroutine u_run_w_ptasks_types_grp ()
public subroutine smista_funz (string k_par_in)
end prototypes

private function string cancella ();//
string k_descr, k_cliente
string k_errore = "0 "
long k_riga, k_row_delete
int k_elabora
st_esito kst_esito
st_tab_ptasks kst_tab_ptasks


k_riga = dw_lista_0.getselectedrow(0)	
if k_riga > 0 then 
	k_cliente = trim(dw_lista_0.getitemstring(k_riga, "rag_soc_10"))
	k_descr = trim(dw_lista_0.getitemstring(k_riga, "ptasks_types_grp_descr"))
	kst_tab_ptasks.id_ptask = dw_lista_0.getitemnumber(k_riga, "id_ptask")
	do while k_riga > 0 
		k_row_delete ++
		k_riga = dw_lista_0.getselectedrow(k_riga)	
	loop
else
	messagebox("Elimina Progetto", "Prego, selezionare una riga dall'elenco !!")
end if
	
if k_row_delete > 0 then

	if k_descr > " " then
	else
		k_descr = "*senza descrizione*" 
	end if
	if k_cliente > " " then
	else
		k_cliente = "*cliente non indicato*" 
	end if
	
//=== Richiesta di conferma della eliminazione del rek
	if k_row_delete > 1 then
		k_elabora = messagebox("Elimina Progetti", "Sei sicuro di voler cancellare " &
				+ string(k_row_delete, "#") + " PROGETTI! ~n~r" &
				+ "di cui il primo è il n. " &
	         + string(kst_tab_ptasks.id_ptask) + " - contratto: " + k_descr &
				+ " del cliente~n~r" + k_cliente &
				, question!, yesno!, 2) 
	else
		k_elabora = messagebox("Elimina Progetto", "Sei sicuro di voler cancellare " &
				+ " il progetto n. " &
	         + string(kst_tab_ptasks.id_ptask) + " - contratto: " + k_descr &
				+ " del cliente~n~r" + k_cliente &
				, question!, yesno!, 2)
	end if
	
	if k_elabora = 1 then
		try
			k_riga = dw_lista_0.getselectedrow(0)	
			do while k_riga > 0 
 		
				kiuf_ptasks.tb_delete(kst_tab_ptasks) 

				dw_lista_0.setitemstatus(k_riga, 0, primary!, new!)
				dw_lista_0.deleterow(k_riga)
		
				k_riga = dw_lista_0.getselectedrow(0)	
			loop
			
			kguo_sqlca_db_magazzino.db_commit()
			
			attiva_tasti()
			
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
			k_errore = "1" + kst_esito.sqlerrtext
			messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + kst_esito.sqlerrtext &
						,stopsign!)
			
		end try
		
		dw_lista_0.setfocus()

	else
		messagebox("Elimina Progetto", "Operazione Annullata!")

	end if
end if

ki_st_open_w.flag_modalita = kkg_flag_modalita.elenco  // Ripristino della modalità

return " "
end function

protected function integer visualizza ();//
long k_code
st_open_w k_st_open_w


if dw_lista_0.getrow() > 0 then

	k_code = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_ptask") 

//--- key1=cod progetto
	k_st_open_w.id_programma = kiuf_ptasks.get_id_programma(kkg_flag_modalita.visualizzazione)
	k_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	k_st_open_w.key1 = string(k_code) 
	kiuf_ptasks.u_open(k_st_open_w)
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dall'elenco")

end if

ki_st_open_w.flag_modalita = kkg_flag_modalita.elenco  // Ripristino della modalità

return (1)
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


	SetPointer(kkg.pointer_attesa)

	if isnumber(trim(ki_st_open_w.key1)) then
		kist_ptasks_guida_last_retrieve.id_cliente = long(trim(ki_st_open_w.key1))
	end if

	if ki_st_open_w.flag_primo_giro = "S" and kist_ptasks_guida_last_retrieve.id_cliente = 0 then
			
		if not dw_guida.visible then
			dw_guida.setfocus( )
		end if
		
		SetPointer(kkg.pointer_default)

	else
		if u_retrieve_dw_lista() < 1 then
			k_return = "1Non sono stati trovati Progetti "
	
			SetPointer(kkg.pointer_default)
//			messagebox("Elenco PT Vuoto", "Nesun Codice Trovato per la richiesta fatta")
	
		end if		
	end if


return k_return


end function

protected subroutine open_start_window ();//
int k_rc
datawindowchild kdwc_1


	kiuf_ptasks = create kuf_ptasks

	dw_guida.insertrow(0)
	dw_guida.getchild("code", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	k_rc = kdwc_1.retrieve()
	k_rc = kdwc_1.insertrow(1)

end subroutine

public function integer u_retrieve_dw_lista ();//---
//---  Fa la Retrieve
//---
long k_return=0	

	
	dw_lista_0.reset()
	k_return = dw_lista_0.retrieve(kist_ptasks_guida_last_retrieve.id_cliente &
											,kist_ptasks_guida_last_retrieve.n_ptask &
											,kist_ptasks_guida_last_retrieve.status &
											,kist_ptasks_guida_last_retrieve.data_json) 
	dw_lista_0.setfocus()

//--- seleziona almeno una riga
	if dw_lista_0.rowcount() > 0 then
		if dw_lista_0.getselectedrow(0) = 0 then
			if dw_lista_0.getrow() = 0 then
				dw_lista_0.setrow(1)
				dw_lista_0.selectrow( 1, true)
			else
				dw_lista_0.selectrow(dw_lista_0.getrow(), true)
			end if
		end if
	end if
	
	attiva_tasti( )

return k_return
	

end function

protected function integer modifica ();//
long k_code
st_open_w k_st_open_w


if dw_lista_0.getrow() > 0 then

	k_code = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_ptask") 

//--- key1=cod progetto
	k_st_open_w.id_programma = kiuf_ptasks.get_id_programma(kkg_flag_modalita.modifica)
	k_st_open_w.flag_modalita = kkg_flag_modalita.modifica
	k_st_open_w.key1 = string(k_code) 
	kiuf_ptasks.u_open(k_st_open_w)
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dall'elenco")

end if

ki_st_open_w.flag_modalita = kkg_flag_modalita.elenco  // Ripristino della modalità

return (1)
end function

protected function integer inserisci ();//
st_open_w k_st_open_w


	k_st_open_w.id_programma = kiuf_ptasks.get_id_programma(kkg_flag_modalita.inserimento)
	k_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
	k_st_open_w.key1 = ""
	kiuf_ptasks.u_open(k_st_open_w)

	ki_st_open_w.flag_modalita = kkg_flag_modalita.elenco  // Ripristino della modalità

return (1)
end function

protected subroutine attiva_menu ();/*
 Attiva/Dis. Voci di menu personalizzate
*/
	
	m_main.m_strumenti.m_fin_gest_libero1.text = "Tipi Progetto"
	m_main.m_strumenti.m_fin_gest_libero1.microhelp = &
	"Gestione Gruppi Tipi progetto"
	m_main.m_strumenti.m_fin_gest_libero1.visible = true
	m_main.m_strumenti.m_fin_gest_libero1.enabled = true
	m_main.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
	m_main.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Tipi,"+m_main.m_strumenti.m_fin_gest_libero1.text
	m_main.m_strumenti.m_fin_gest_libero1.toolbaritemName = "prjtask16.png"
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2

//---
	super::attiva_menu()


end subroutine

public subroutine u_run_w_ptasks_types_grp ();//
kuf_ptasks_types_grp kuf1_ptasks_types_grp


kuf1_ptasks_types_grp = create kuf_ptasks_types_grp

kuf1_ptasks_types_grp.u_open(kkg_flag_modalita.elenco)

destroy kuf1_ptasks_types_grp
end subroutine

public subroutine smista_funz (string k_par_in);//

choose case k_par_in

	case KKG_FLAG_RICHIESTA.libero1
		u_run_w_ptasks_types_grp( )

	case else
		super::smista_funz(k_par_in)

end choose


end subroutine

on w_ptasks_l.create
call super::create
end on

on w_ptasks_l.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_ptasks) then destroy kiuf_ptasks

end event

type dw_print_0 from w_g_tab0`dw_print_0 within w_ptasks_l
end type

type st_ritorna from w_g_tab0`st_ritorna within w_ptasks_l
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_ptasks_l
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_ptasks_l
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_ptasks_l
integer x = 2514
integer y = 1180
integer height = 92
integer taborder = 80
boolean cancel = true
end type

type st_stampa from w_g_tab0`st_stampa within w_ptasks_l
integer x = 0
integer y = 1184
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_ptasks_l
integer x = 2144
integer y = 1072
end type

type cb_modifica from w_g_tab0`cb_modifica within w_ptasks_l
integer x = 1737
integer y = 1180
integer height = 96
integer taborder = 60
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_ptasks_l
integer x = 937
integer y = 1180
integer height = 96
integer taborder = 100
end type

type cb_cancella from w_g_tab0`cb_cancella within w_ptasks_l
integer x = 2126
integer y = 1180
integer height = 96
integer taborder = 70
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_ptasks_l
integer x = 1349
integer y = 1180
integer height = 96
integer taborder = 50
boolean enabled = false
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_ptasks_l
integer width = 1989
integer height = 524
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

type st_orizzontal from w_g_tab0`st_orizzontal within w_ptasks_l
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_ptasks_l
string dataobject = "d_ptasks_l"
boolean hsplitscroll = false
end type

type dw_guida from w_g_tab0`dw_guida within w_ptasks_l
event ue_itemchanged ( string k_nome,  string k_dato )
event u_clear ( )
event u_search_reset ( )
integer width = 2798
boolean enabled = true
string dataobject = "d_ptasks_l_guida"
end type

event dw_guida::ue_itemchanged(string k_nome, string k_dato);////
//int k_errore=0
//long k_riga
//string k_rag_soc
//st_stat_fatt kst_stat_fatt
//datawindowchild kdwc_cliente, kdwc_prodotti
//
//
//choose case k_nome 
//
//	case "rag_soc_1" 
//		k_rag_soc = k_dato
//		if LenA(k_rag_soc) > 0 then
//			dw_guida.getchild("rag_soc_1", kdwc_cliente)
//			if kdwc_cliente.rowcount() < 2 then
//				kdwc_cliente.retrieve("%")
//				kdwc_cliente.insertrow(1)
//			end if
//			k_riga=kdwc_cliente.find("upper(rag_soc_1) like '%"+upper(trim(k_rag_soc))+"%'",&
//									0, kdwc_cliente.rowcount())
//			if k_riga > 0 then
//				dw_guida.setitem(1, "id_cliente",	kdwc_cliente.getitemnumber(k_riga, "id_cliente"))
//				dw_guida.setitem(1, "rag_soc_1", 	kdwc_cliente.getitemstring(k_riga, "rag_soc_1"))
//			else
//				dw_guida.setitem(1, "rag_soc_1","")
//				dw_guida.setitem(1, "id_cliente",0)
//			end if
//			k_errore = 1
//		else
//			dw_guida.setitem(1, "id_cliente",0)
//		end if
//
//	case "id_cliente" 
//		if isnumber(k_dato) then
//			kst_stat_fatt.k_id_cliente = long(k_dato)
//			if kst_stat_fatt.k_id_cliente > 0 then
//				dw_guida.getchild("rag_soc_1", kdwc_cliente)
//				if kdwc_cliente.rowcount() < 2 then
//					kdwc_cliente.retrieve("%")
//					kdwc_cliente.insertrow(1)
//				end if
//				k_riga=kdwc_cliente.find("id_cliente = "+string(kst_stat_fatt.k_id_cliente)+" ", 0, kdwc_cliente.rowcount())
//				if k_riga > 0 then
//					dw_guida.setitem(1, "id_cliente",	kdwc_cliente.getitemnumber(k_riga, "id_cliente"))
//					dw_guida.setitem(1, "rag_soc_1", kdwc_cliente.getitemstring(k_riga, "rag_soc_1"))
//				else
//					dw_guida.setitem(1, "rag_soc_1","Nessun Listino caricato per questo cliente")
//					dw_guida.setitem(1, "id_cliente",kst_stat_fatt.k_id_cliente)
//				end if
//				k_errore = 1
//			else
//				dw_guida.setitem(1, "id_cliente",0)
//			end if
//		end if
//
//
//end choose 
//
//
//	

	



end event

event dw_guida::u_clear();//
	this.setitem(1, 1, "")
	event u_search_reset()

end event

event dw_guida::u_search_reset();//
	kist_ptasks_guida_last_retrieve.id_cliente = 0
	kist_ptasks_guida_last_retrieve.id_ptask = 0
	kist_ptasks_guida_last_retrieve.data_json = ""

	if this.rowcount( ) > 0 then
		if this.getitemnumber(1, "id_cliente") > 0 then
		else
			this.setitem(1, "id_cliente", 0)
		end if
	end if
	
end event

event dw_guida::ue_buttonclicked;call super::ue_buttonclicked;//---	
//--- 
//---
string k_code
long k_riga
st_ptasks_guida kst_ptasks_guida
datawindowchild kdwc_cliente


try

	if trim(dw_guida.getitemstring(1, "code")) > " " then
		k_code = trim(dw_guida.getitemstring(1, "code"))
		if isnumber(k_code) then
			kst_ptasks_guida.n_ptask = long(k_code)
		elseif upper(left(k_code, 1)) = "C" and isnumber(mid(k_code, 2)) then
	//--- estrazione puntuale sul cliente?	
			kst_ptasks_guida.id_cliente = long(trim(mid(k_code, 2)))
			kst_ptasks_guida.id_ptask = 0
			kst_ptasks_guida.id_ptask = 0
		end if
		if kst_ptasks_guida.id_cliente = 0 then
			if k_code > " " and left(k_code, 1) <> "%" then
				this.getchild("code", kdwc_cliente)
				if kdwc_cliente.rowcount() < 2 then
					kdwc_cliente.settransobject(kguo_sqlca_db_magazzino)
					kdwc_cliente.retrieve("%")
					kdwc_cliente.insertrow(1)
				end if
				k_riga=kdwc_cliente.find("rag_soc_10 like '%" + trim(k_code) + "%'",&
															1, kdwc_cliente.rowcount())
				if k_riga > 0 then
					kst_ptasks_guida.id_cliente = kdwc_cliente.getitemnumber(k_riga, "id_cliente")
				end if
			else
				
				//--- cerca dato nella stringona JSON
				if left(k_code, 1) = "%" and mid(k_code, 2, 1) > " " then
					kst_ptasks_guida.data_json = k_code + "%"
				end if
			
			end if
		end if
	end if
	
	kst_ptasks_guida.status = trim(dw_guida.getitemstring(1, "status"))
	
	if (kst_ptasks_guida.id_ptask = 0 and kst_ptasks_guida.id_cliente = 0 and k_code = "") &
				or kst_ptasks_guida.n_ptask <> kist_ptasks_guida_last_retrieve.n_ptask &
				or kst_ptasks_guida.id_cliente <> kist_ptasks_guida_last_retrieve.id_cliente &
				or (kst_ptasks_guida.n_ptask > 0 and kist_ptasks_guida_last_retrieve.n_ptask = 0) &
				or (kst_ptasks_guida.id_cliente > 0 and kist_ptasks_guida_last_retrieve.id_cliente = 0) &
				or kst_ptasks_guida.status <> kist_ptasks_guida_last_retrieve.status &
				or kst_ptasks_guida.data_json <> kist_ptasks_guida_last_retrieve.data_json &
			then
				
		kist_ptasks_guida_last_retrieve.n_ptask = kst_ptasks_guida.n_ptask
		kist_ptasks_guida_last_retrieve.id_cliente = kst_ptasks_guida.id_cliente
		kist_ptasks_guida_last_retrieve.status = kst_ptasks_guida.status
		kist_ptasks_guida_last_retrieve.data_json = kst_ptasks_guida.data_json
		u_retrieve_dw_lista()
			
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	
end try

end event

event dw_guida::clicked;call super::clicked;//
if dwo.name = "b_clear" then
	event u_clear()
end if
end event

event dw_guida::itemchanged;call super::itemchanged;//
if dwo.name = "status" then
	event post ue_buttonclicked("default")
end if
end event

type st_duplica from w_g_tab0`st_duplica within w_ptasks_l
end type

