$PBExportHeader$w_ptasks.srw
forward
global type w_ptasks from w_g_tab_3
end type
type dw_task from uo_d_std_1 within tabpage_1
end type
end forward

global type w_ptasks from w_g_tab_3
boolean ki_sincronizza_window_consenti = false
boolean ki_filtra_attivo = false
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_msg_dopo_update = false
event u_ ( )
event u_disp_avvertenze ( string a_msg )
end type
global w_ptasks w_ptasks

type variables
//
private st_tab_ptasks kist_tab_ptasks_orig
private st_tab_ptasks_rows kist_tab_ptasks_rows

private kuf_ptasks kiuf_ptasks

private kuf_ptasks_rows kiuf_ptasks_rows
private kuf_utility kiuf_utility
private kuf_armo kiuf_armo

private datastore kids_1

private boolean ki_status_enable
end variables

forward prototypes
protected subroutine u_resize_1 ()
protected subroutine open_start_window ()
protected function string inizializza () throws uo_exception
protected function string aggiorna ()
protected function integer inserisci ()
protected function string check_dati ()
private function string u_get_ptasks_types_json ()
public subroutine u_set_tab_1_enable ()
protected function integer inserisci_2 ()
protected subroutine inizializza_1 () throws uo_exception
protected function integer u_dw_2_inizializza () throws uo_exception
protected function integer inserisci_3 ()
protected function integer u_dw_3_inizializza () throws uo_exception
protected subroutine inizializza_2 () throws uo_exception
public subroutine u_set_st_tab_ptasks_rows_from_dw (ref st_tab_ptasks_rows kst_tab_ptasks_rows) throws uo_exception
protected function integer inserisci_4 ()
protected function integer u_dw_4_inizializza () throws uo_exception
protected subroutine inizializza_3 () throws uo_exception
protected function integer inserisci_5 ()
protected function integer u_dw_5_inizializza () throws uo_exception
protected subroutine inizializza_4 () throws uo_exception
protected function boolean dati_modif_0 ()
private function integer u_dw_task_change_selected ()
protected function integer u_dw_7_inizializza () throws uo_exception
protected subroutine inizializza_6 () throws uo_exception
protected subroutine riempi_id ()
protected subroutine inizializza_8 () throws uo_exception
protected function integer u_dw_9_inizializza () throws uo_exception
protected subroutine attiva_menu ()
public subroutine smista_funz (string k_par_in)
public function long u_get_valid_modaccompn ()
private function integer u_dw_1_inizializza () throws uo_exception
private subroutine u_protegge_sprotegge_dw ()
private subroutine u_aggiorna () throws uo_exception
public function long u_get_cs_invoicen ()
public subroutine u_stampa_mod ()
public subroutine u_stampa_mod_invoice (long a_row)
public subroutine u_stampa_mod_laboratorio (long a_row)
protected subroutine attiva_tasti_0 ()
end prototypes

protected subroutine u_resize_1 ();//
	long k_width_tak

//=== Se tab_1 e visible oppure sono in prima volta
	if tab_1.visible then
		this.setredraw(false)
	end if

//=== Dimensione dw nella window 
	tab_1.width = this.width //- 90
	tab_1.height = this.height //- 200
//=== Posiziona dw nella window 
	tab_1.x = (this.width - tab_1.width) / 4
	tab_1.y = (this.height - tab_1.height) / 7

	tab_1.tabpage_1.dw_task.x = 1 //tab_1.tabpage_1.x + tab_1.tabpage_1.st_report.width + 50
	tab_1.tabpage_1.dw_task.y = 1
	if tab_1.tabpage_1.width / 4 < 900 then
		tab_1.tabpage_1.dw_task.width = 900 
	else
		tab_1.tabpage_1.dw_task.width = tab_1.tabpage_1.width / 4 //1050 //tab_1.tabpage_1.width - tab_1.tabpage_1.st_report.width - 100
	end if
	tab_1.tabpage_1.dw_task.height = tab_1.tabpage_1.height // tab_1.tabpage_1.st_report.height
	
	tab_1.tabpage_1.dw_1.width = tab_1.tabpage_1.width - 10 - tab_1.tabpage_1.dw_task.width //tab_1.tabpage_1.width - 10
	tab_1.tabpage_1.dw_1.height = tab_1.tabpage_1.height //tab_1.tabpage_1.height - tab_1.tabpage_1.st_report.height - 130
	tab_1.tabpage_1.dw_1.x = tab_1.tabpage_1.dw_task.width + tab_1.tabpage_1.dw_task.x //(tab_1.tabpage_1.width - tab_1.tabpage_1.dw_1.width) / 2
	tab_1.tabpage_1.dw_1.y = tab_1.tabpage_1.dw_task.y //tab_1.tabpage_1.st_report.y + 150 //(tab_1.tabpage_1.height - tab_1.tabpage_1.dw_1.height) / 2

//=== Dimensiona dw nel tab
	tab_1.tabpage_2.dw_2.width = tab_1.tabpage_2.width - 10
	tab_1.tabpage_2.dw_2.height = tab_1.tabpage_2.height - 30
	tab_1.tabpage_2.dw_2.x = (tab_1.tabpage_2.width - tab_1.tabpage_2.dw_2.width) / 2
	tab_1.tabpage_2.dw_2.y = (tab_1.tabpage_2.height - tab_1.tabpage_2.dw_2.height) / 2
	tab_1.tabpage_2.dw_2.modify("k_titolo.width = " + string(tab_1.tabpage_2.dw_2.width - 10))

	tab_1.tabpage_3.dw_3.width = tab_1.tabpage_3.width - 10
	tab_1.tabpage_3.dw_3.height = tab_1.tabpage_3.height - 30
	tab_1.tabpage_3.dw_3.x = (tab_1.tabpage_3.width - tab_1.tabpage_3.dw_3.width) / 2
	tab_1.tabpage_3.dw_3.y = (tab_1.tabpage_3.height - tab_1.tabpage_3.dw_3.height) / 2
	tab_1.tabpage_3.dw_3.modify("k_titolo.width = " + string(tab_1.tabpage_3.dw_3.width - 10))

	tab_1.tabpage_4.dw_4.width = tab_1.tabpage_4.width - 10
	tab_1.tabpage_4.dw_4.height = tab_1.tabpage_4.height - 30
	tab_1.tabpage_4.dw_4.x = (tab_1.tabpage_4.width - tab_1.tabpage_4.dw_4.width) / 2
	tab_1.tabpage_4.dw_4.y = (tab_1.tabpage_4.height - tab_1.tabpage_4.dw_4.height) / 2
	tab_1.tabpage_4.dw_4.modify("k_titolo.width = " + string(tab_1.tabpage_4.dw_4.width - 10))

	tab_1.tabpage_5.dw_5.width = tab_1.tabpage_5.width - 10
	tab_1.tabpage_5.dw_5.height = tab_1.tabpage_5.height - 30
	tab_1.tabpage_5.dw_5.x = (tab_1.tabpage_5.width - tab_1.tabpage_5.dw_5.width) / 2
	tab_1.tabpage_5.dw_5.y = (tab_1.tabpage_5.height - tab_1.tabpage_5.dw_5.height) / 2
	tab_1.tabpage_5.dw_5.modify("k_titolo.width = " + string(tab_1.tabpage_5.dw_5.width - 10))


	tab_1.tabpage_7.dw_7.width = tab_1.tabpage_7.width - 10
	tab_1.tabpage_7.dw_7.height = tab_1.tabpage_7.height - 30
	tab_1.tabpage_7.dw_7.x = (tab_1.tabpage_7.width - tab_1.tabpage_7.dw_7.width) / 2
	tab_1.tabpage_7.dw_7.y = (tab_1.tabpage_7.height - tab_1.tabpage_7.dw_7.height) / 2

	tab_1.tabpage_9.dw_9.width = tab_1.tabpage_9.width - 10
	tab_1.tabpage_9.dw_9.height = tab_1.tabpage_9.height - 30
	tab_1.tabpage_9.dw_9.x = (tab_1.tabpage_9.width - tab_1.tabpage_9.dw_9.width) / 2
	tab_1.tabpage_9.dw_9.y = (tab_1.tabpage_9.height - tab_1.tabpage_9.dw_9.height) / 2

//
	k_width_tak = tab_1.tabpage_1.dw_task.width
	tab_1.tabpage_1.dw_task.modify("descr.width = " + string(k_width_tak - long(tab_1.tabpage_1.dw_task.describe("k_add_minus.Width")) -30 ))
	
	tab_1.visible = true
	tab_1.tabpage_1.dw_task.visible = true

	
	this.setredraw(true)





end subroutine

protected subroutine open_start_window ();//
	kiuf_utility = create kuf_utility
	kiuf_ptasks = create kuf_ptasks
	kiuf_ptasks_rows = create kuf_ptasks_rows
	kiuf_armo = create kuf_armo
	
	if not isnumber(trim(ki_st_open_w.key1)) then
		kist_tab_ptasks_orig.id_ptask = 0
	else
		kist_tab_ptasks_orig.id_ptask  = long(trim(ki_st_open_w.key1))
	end if
	
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		
		ki_status_enable = true

	end if

end subroutine

protected function string inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
int k_err_ins


tab_1.tabpage_1.dw_1.ki_flag_modalita = ki_st_open_w.flag_modalita

//kist_tab_ptasks_orig.id_ptask = kst_tab_ptasks_attuale.id_ptask

if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
//--- Se inserimento.... 
   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
		
		k_err_ins = inserisci()
		
	else
		
		u_dw_1_inizializza( )

		if not ki_exit_si then
			
			try
				tab_1.tabpage_1.dw_task.event u_select_row(1)
				//tab_1.tabpage_1.dw_task.modify("DataWindow.Color='" + kkg_colore.nerox + "'")
				
				if tab_1.tabpage_1.dw_1.rowcount() > 0 then
					inizializza_1( )
					inizializza_2( )
					inizializza_3( )
					inizializza_4( )
					
					inizializza_6( )
					inizializza_8( )
				end if
				
			catch (uo_exception kuo_exception)
				kuo_exception.messaggio_utente()
				
			finally
				u_tab_1_tabpage_dw_resetupdate( )  // RESET GLI STATUS DI UPDATE
				
			end try

		end if
		
	end if
	
end if

if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
	kist_tab_ptasks_orig.id_meca = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")
end if

if not ki_exit_si then
	u_set_tab_1_enable( )
	//attiva_tasti()
	
   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
		tab_1.selecttab(1)
		tab_1.tabpage_1.dw_1.setfocus( )
		tab_1.tabpage_1.dw_1.setcolumn("id_ptasks_types_grp")
	else
		tab_1.tabpage_1.dw_1.setfocus( )
		tab_1.tabpage_1.dw_1.setcolumn("cntr_val")
	end if
	
end if

return "0"
end function

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; >0=errore grave I-O;
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="0 "
st_esito kst_esito


try
	setpointer(kkg.pointer_attesa) 

//	tab_1.selecttab(1)

	u_aggiorna()			// Lancia AGGIORNAMENTO su db

catch (uo_exception kuo_execption)
	setpointer(kkg.pointer_default)
	kst_esito = kuo_execption.get_st_esito()
	k_return = trim(kst_esito.esito) + trim(kst_esito.sqlerrtext)
	if k_return > " " then
		tab_1.tabpage_1.dw_1.event u_disp_avvertenze("Aggiornamento dati Progetto non completatato.")
		messagebox("Aggiornamento in Errore", "Aggiornamento dati Progetto non completatato" +"~n~r"+ k_return)
	else
		tab_1.tabpage_1.dw_1.event u_disp_avvertenze("Errore in Aggiornamento Lotto, operazione non completata.")
		k_return = "1Errore in Aggiornamento Lotto, operazione non completata."
		messagebox("Aggiornamento in Errore", "Aggiornamento dati Progetto non completatato")
	end if

finally
	setpointer(kkg.pointer_default)

end try

return k_return

end function

protected function integer inserisci ();//
int k_return=0
//st_memo kst_memo
//st_tab_meca_memo kst_tab_meca_memo
//kuf_memo kuf1_memo
//kuf_memo_inout kuf1_memo_inout

try
	
//--- Aggiunge una riga al data windows
	choose case ki_tab_1_index_new 
		case  1
			this.setredraw(false)
	
			u_tab_1_tabpage_dw_reset( )
			
			tab_1.tabpage_1.dw_1.insertrow(0)
			
//--- S-protezione campi per riabilitare la modifica a parte la chiave
			kiuf_utility.u_proteggi_sproteggi_dw(tab_1.tabpage_1.dw_1)

			this.setredraw(true)

			tab_1.tabpage_1.dw_1.setfocus()

//--- popola dw child dw clienti 
			tab_1.tabpage_1.dw_1.event u_ddwc() // _clienti( )
			kist_tab_ptasks_orig.id_ptask = 0
			tab_1.tabpage_1.dw_1.setitem(1, "id_ptask", 0)
			
//		case 9 // allegati
//			kuf1_memo = create kuf_memo
//			kuf1_memo_inout = create kuf_memo_inout
//			kst_tab_meca_memo.id_meca_memo = 0
//			kst_tab_meca_memo.tipo_sv = ki_st_open_w.sr_settore
//			kst_tab_meca_memo.id_meca = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")
//			kst_memo.st_tab_meca_memo = kst_tab_meca_memo
//			kuf1_memo_inout.memo_xmeca(kst_memo.st_tab_meca_memo, kst_memo.st_tab_memo)
//			kuf1_memo.u_attiva_funzione(kst_memo,kkg_flag_modalita.inserimento )   // APRE FUNZIONE
				
	end choose	

catch (uo_exception kuo_exception) 
	kuo_exception.messaggio_utente()
	

finally
	k_return = 0

	attiva_tasti()

end try

return (k_return)



end function

protected function string check_dati ();//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK ma errore non grave
//===                : 5=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
//
string k_return = " "
string k_errore = "0"
st_esito kst_esito,kst_esito1
st_tab_ptasks kst_tab_ptasks
int k_riga
st_tab_clienti kst_tab_clienti
datawindowchild kdwc_1


try
	kst_esito = kguo_exception.inizializza(this.classname())

//--- Controllo il primo tab
	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		tab_1.tabpage_1.dw_1.event u_ddwc( )

		if tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptasks_types_grp") > 0 then
		else
			k_return = tab_1.tabpage_1.text + ": Indicare il Tipo Attività " + "'~n~r" 
			k_errore = kkg_esito.DATI_INSUFF
		end if

		if	k_errore = kkg_esito.ok or k_errore = kkg_esito.DB_WRN or k_errore = kkg_esito.DATI_WRN then
			kst_tab_ptasks.cntr_val = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "cntr_val"))
			tab_1.tabpage_1.dw_1.getchild("cntr_val", kdwc_1)
			k_riga=kdwc_1.find("ptasks_cntr_val = '"+kst_tab_ptasks.cntr_val+"' ", 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = kdwc_1.getitemnumber(k_riga, "id_cliente")
			end if
			if kst_tab_clienti.codice <> tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente") then
				k_return = tab_1.tabpage_1.text + ": Cliente '" + string(tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")) &
									+ "' diverso da quello indicato in Quotazione '" &
									+ string(kst_tab_clienti.codice) + "'~n~r" 
				k_errore = kkg_esito.DATI_WRN
			end if
		end if
		
	end if
	
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

finally
	choose case kst_esito.esito
		case kkg_esito.OK
			k_errore = "0"
		case kkg_esito.ERR_LOGICO
			k_errore = "1"
		case kkg_esito.err_formale
			k_errore = "2"
		case kkg_esito.DATI_INSUFF
			k_errore = "3"
		case kkg_esito.DB_WRN
			k_errore = "4"
		case kkg_esito.DATI_WRN
			k_errore = "5"
		case else
			k_errore = "1"
	end choose

	k_return = trim(kst_esito.sqlerrtext)
//--- Attenzione se ho interesse di conoscere i campi in errore scorrere i TAG di ciascun campo nel DATASTORE dove c'e' il tipo di errore riscontrato 	
	
end try


return k_errore + k_return

return "0"
end function

private function string u_get_ptasks_types_json ();//
string k_return
int k_row, k_rows


//--- riempie array json
k_return = "{}"
k_rows = tab_1.tabpage_1.dw_task.rowcount( )
for k_row = 1 to k_rows
	if tab_1.tabpage_1.dw_task.getitemnumber(k_row, "id_ptasks_type") > 0 then
		if k_return = "{}" then
			k_return = "["
		else
			k_return += ","
		end if
		k_return += &
				string(tab_1.tabpage_1.dw_task.getitemnumber(k_row, "id_ptasks_type"), "#")
	end if
next
if k_return = "{}" then
else
	k_return += "]"
end if

return k_return
end function

public subroutine u_set_tab_1_enable ();//	
boolean k_enable

if tab_1.tabpage_1.dw_task.getselectedrow(0) > 0 then
	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		if tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask") > 0 then
			
			tab_1.tabpage_7.enabled = true
			tab_1.tabpage_9.enabled = true

			if tab_1.tabpage_1.dw_task.getitemnumber(tab_1.tabpage_1.dw_task.getselectedrow(0) , "id_ptasks_type") > 0 then
				k_enable = true
			end if
		else
			tab_1.tabpage_7.enabled = false
			tab_1.tabpage_9.enabled = false
		end if
	end if
end if

tab_1.tabpage_2.enabled = k_enable
tab_1.tabpage_3.enabled = k_enable
tab_1.tabpage_4.enabled = k_enable
tab_1.tabpage_5.enabled = k_enable

end subroutine

protected function integer inserisci_2 ();//
int k_return, k_ctr
st_tab_ptasks_types kst_tab_ptasks_types


kst_tab_ptasks_types.id_ptasks_type = tab_1.tabpage_1.dw_task.event u_get_id_ptasks_type()

if kst_tab_ptasks_types.id_ptasks_type > 0 and tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
	
	tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.inserimento
	k_return = tab_1.tabpage_2.dw_2.insertrow(0)

	tab_1.tabpage_2.dw_2.setitem(1, "id_ptasks_row", 0)
	tab_1.tabpage_2.dw_2.setitem(1, "id_ptask", tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask"))
	tab_1.tabpage_2.dw_2.setitem(1, "id_ptasks_type", kst_tab_ptasks_types.id_ptasks_type)
	tab_1.tabpage_2.dw_2.setitem(1, "ptasks_types_descr", tab_1.tabpage_1.dw_task.event u_get_type_descr())
	tab_1.tabpage_2.dw_2.setitem(1, "task", tab_1.tabpage_1.dw_task.event u_get_task())

	tab_1.tabpage_2.dw_2.resetupdate( )
			
else
	tab_1.tabpage_2.dw_2.reset( )
end if

return (k_return)



end function

protected subroutine inizializza_1 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
int k_rows

	if tab_1.tabpage_2.dw_2.rowcount() = 0 then
	
		k_rows = u_dw_2_inizializza( )
		
		if k_rows = 0 then
			tab_1.tabpage_2.dw_2.visible = false
		else
			tab_1.tabpage_2.dw_2.visible = true
		end if
		
	end if
	
	tab_1.tabpage_2.dw_2.ki_flag_modalita = ki_st_open_w.flag_modalita
	kiuf_utility.u_proteggi_sproteggi_dw_no_protect(tab_1.tabpage_2.dw_2)
	

end subroutine

protected function integer u_dw_2_inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_return
long k_id_ptasks_type


try
	SetPointer(kkg.pointer_attesa)

	if tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask") > 0 then
		k_id_ptasks_type = tab_1.tabpage_1.dw_task.event u_get_id_ptasks_type()
		if k_id_ptasks_type > 0 then
				
			tab_1.tabpage_2.dw_2.ki_flag_modalita = ki_st_open_w.flag_modalita
	
			k_return = tab_1.tabpage_2.dw_2.retrieve(0 &
															,tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask") &
															,k_id_ptasks_type) 
	
			if k_return < 0 then
				kguo_exception.inizializza(this.classname())
				kguo_exception.kist_esito.esito = kkg_esito.db_ko
				kguo_exception.kist_esito.sqlerrtext = "Ricerca Fallita dati '" + trim(tab_1.tabpage_2.text) + "', errore dal DB"
				kguo_exception.scrivi_log( )
				throw kguo_exception
			end if
			
			if k_return = 0 then
				if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then

					k_return = inserisci_2()
					
				end if
			end if
		end if
	end if

	if k_return > 0 then
		if tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.modifica &
					or tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.inserimento then
			tab_1.tabpage_2.dw_2.event u_ddwc( )  // Prepara le DDWC
		else
			tab_1.tabpage_2.dw_2.event u_ddwc_invoiceid_cliente_x_id_cliente(tab_1.tabpage_2.dw_2.getitemnumber(1, "cs_invoice_id_cliente"))
		end if
		
		tab_1.tabpage_2.dw_2.setitem(1, "k_flag_modalita", tab_1.tabpage_2.dw_2.ki_flag_modalita)
		tab_1.tabpage_2.dw_2.SetItemStatus( 1, "k_flag_modalita", Primary!, NotModified!)
	else
		tab_1.tabpage_2.dw_2.reset()
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)
	
end try


return k_return 

end function

protected function integer inserisci_3 ();//
int k_return, k_ctr
st_tab_ptasks_types kst_tab_ptasks_types


kst_tab_ptasks_types.id_ptasks_type = tab_1.tabpage_1.dw_task.event u_get_id_ptasks_type()

if kst_tab_ptasks_types.id_ptasks_type > 0 and tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
	
	tab_1.tabpage_3.dw_3.ki_flag_modalita = kkg_flag_modalita.inserimento
	k_return = tab_1.tabpage_3.dw_3.insertrow(0)

	tab_1.tabpage_3.dw_3.setitem(1, "id_ptasks_row", 0)
	tab_1.tabpage_3.dw_3.setitem(1, "id_ptask", tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask"))
	tab_1.tabpage_3.dw_3.setitem(1, "id_ptasks_type", kst_tab_ptasks_types.id_ptasks_type)
	tab_1.tabpage_3.dw_3.setitem(1, "ptasks_types_descr", tab_1.tabpage_1.dw_task.event u_get_type_descr())
	tab_1.tabpage_3.dw_3.setitem(1, "task", tab_1.tabpage_1.dw_task.event u_get_task())

	tab_1.tabpage_3.dw_3.resetupdate( )
			
else
	tab_1.tabpage_3.dw_3.reset( )
end if

return (k_return)



end function

protected function integer u_dw_3_inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_return
long k_id_ptasks_type


try
	SetPointer(kkg.pointer_attesa)

	if tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask") > 0 then
		k_id_ptasks_type = tab_1.tabpage_1.dw_task.event u_get_id_ptasks_type()
		if k_id_ptasks_type > 0 then
				
			tab_1.tabpage_3.dw_3.ki_flag_modalita = ki_st_open_w.flag_modalita
	
			tab_1.tabpage_3.dw_3.event u_ddwc_e1wo()
	
			k_return = tab_1.tabpage_3.dw_3.retrieve(0 &
															,tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask") &
															,k_id_ptasks_type) 
	
			if k_return < 0 then
				kguo_exception.inizializza(this.classname())
				kguo_exception.kist_esito.esito = kkg_esito.db_ko
				kguo_exception.kist_esito.sqlerrtext = "Ricerca Fallita dati '" + trim(tab_1.tabpage_3.text) + "', errore dal DB"
				kguo_exception.scrivi_log( )
				throw kguo_exception
			end if
			
			if k_return = 0 then
				if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then

					k_return = inserisci_3()
					
				end if
			end if
			
			if k_return > 0 then
				
				tab_1.tabpage_3.dw_3.event u_ddwc_accettazione_pesolordoxlottokg( )
				tab_1.tabpage_3.dw_3.event u_ddwc_accettazione_dhlbox( )
				
			end if
			
		end if
	end if

	if k_return > 0 then
		tab_1.tabpage_3.dw_3.setitem(1, "k_flag_modalita", tab_1.tabpage_3.dw_3.ki_flag_modalita)
		tab_1.tabpage_3.dw_3.SetItemStatus( 1, "k_flag_modalita", Primary!, NotModified!)
	else
		tab_1.tabpage_3.dw_3.reset()
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)
	
end try


return k_return 

end function

protected subroutine inizializza_2 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_rc
int k_rows
st_tab_meca kst_tab_meca


if tab_1.tabpage_3.dw_3.rowcount() = 0 then
	
	k_rows = u_dw_3_inizializza( )
	
	if k_rows = 0 then
		tab_1.tabpage_3.dw_3.visible = false
	else
		tab_1.tabpage_3.dw_3.visible = true
	end if
	
	tab_1.tabpage_3.dw_3.setcolumn("accettazione_arrivodata")
	
end if
	
if tab_1.tabpage_3.dw_3.ki_flag_modalita = kkg_flag_modalita.modifica &
				or tab_1.tabpage_3.dw_3.ki_flag_modalita = kkg_flag_modalita.inserimento then
				
//	if tab_1.tabpage_3.dw_3.getitemdate( 1, "accettazione_arrivodata") > kkg.data_no then
//	else
		kst_tab_meca.id = kist_tab_ptasks_orig.id_meca //tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")	
		kiuf_armo.get_data_ent(kst_tab_meca)
		if date(kst_tab_meca.data_ent) > kkg.data_no then 
			tab_1.tabpage_3.dw_3.setitem(1, "k_accettazione_arrivodata", date(kst_tab_meca.data_ent))
		end if
//	end if
//	if tab_1.tabpage_3.dw_3.getitemnumber( 1, "accettazione_e1wo") > 0 then
//	else
		kst_tab_meca.id = kist_tab_ptasks_orig.id_meca //tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")	
		kiuf_armo.get_e1doco(kst_tab_meca)
		if kst_tab_meca.e1doco > 0 then 
			tab_1.tabpage_3.dw_3.setitem(1, "k_accettazione_e1wo", kst_tab_meca.e1doco)
		end if
//	end if
		
end if
	
tab_1.tabpage_3.dw_3.ki_flag_modalita = ki_st_open_w.flag_modalita
kiuf_utility.u_proteggi_sproteggi_dw_no_protect(tab_1.tabpage_3.dw_3)


end subroutine

public subroutine u_set_st_tab_ptasks_rows_from_dw (ref st_tab_ptasks_rows kst_tab_ptasks_rows) throws uo_exception;//
int k_idx, k_rc


choose case true
	case tab_1.tabpage_2.dw_2.rowcount( ) > 0
		kst_tab_ptasks_rows.id_ptask = tab_1.tabpage_2.dw_2.getitemnumber( 1, "id_ptask")
		kst_tab_ptasks_rows.id_ptasks_type = tab_1.tabpage_2.dw_2.getitemnumber( 1, "id_ptasks_type")
		kst_tab_ptasks_rows.id_ptasks_row = tab_1.tabpage_2.dw_2.getitemnumber( 1, "id_ptasks_row")
	case tab_1.tabpage_3.dw_3.rowcount( ) > 0
		kst_tab_ptasks_rows.id_ptask = tab_1.tabpage_3.dw_3.getitemnumber( 1, "id_ptask")
		kst_tab_ptasks_rows.id_ptasks_type = tab_1.tabpage_3.dw_3.getitemnumber( 1, "id_ptasks_type")
		kst_tab_ptasks_rows.id_ptasks_row = tab_1.tabpage_3.dw_3.getitemnumber( 1, "id_ptasks_row")
	case tab_1.tabpage_4.dw_4.rowcount( ) > 0
		kst_tab_ptasks_rows.id_ptask = tab_1.tabpage_4.dw_4.getitemnumber( 1, "id_ptask")
		kst_tab_ptasks_rows.id_ptasks_type = tab_1.tabpage_4.dw_4.getitemnumber( 1, "id_ptasks_type")
		kst_tab_ptasks_rows.id_ptasks_row = tab_1.tabpage_4.dw_4.getitemnumber( 1, "id_ptasks_row")
	case tab_1.tabpage_5.dw_5.rowcount( ) > 0
		kst_tab_ptasks_rows.id_ptask = tab_1.tabpage_5.dw_5.getitemnumber( 1, "id_ptask")
		kst_tab_ptasks_rows.id_ptasks_type = tab_1.tabpage_5.dw_5.getitemnumber( 1, "id_ptasks_type")
		kst_tab_ptasks_rows.id_ptasks_row = tab_1.tabpage_5.dw_5.getitemnumber( 1, "id_ptasks_row")
end choose

if kst_tab_ptasks_rows.id_ptasks_row > 0 then
else
	kst_tab_ptasks_rows.id_ptasks_row = kiuf_ptasks_rows.get_id_ptasks_row(kist_tab_ptasks_rows)
end if
kist_tab_ptasks_rows.id_ptasks_row = kst_tab_ptasks_rows.id_ptasks_row

if tab_1.tabpage_2.dw_2.rowcount( ) > 0 then
else
	tab_1.tabpage_2.dw_2.retrieve( kist_tab_ptasks_rows.id_ptasks_row, 0, 0 ) // recupera i dati della riga
end if
if tab_1.tabpage_2.dw_2.rowcount( ) > 0 then
	kst_tab_ptasks_rows.cs_qta = tab_1.tabpage_2.dw_2.getitemnumber( 1, "cs_qta")
	kst_tab_ptasks_rows.cs_prezzo = tab_1.tabpage_2.dw_2.getitemnumber( 1, "cs_prezzo")
	kst_tab_ptasks_rows.cs_clienteddtn = tab_1.tabpage_2.dw_2.getitemstring( 1, "cs_clienteddtn")
	kst_tab_ptasks_rows.cs_usdqta = tab_1.tabpage_2.dw_2.getitemnumber( 1, "cs_usdqta")
	kst_tab_ptasks_rows.cs_usdprezzo = tab_1.tabpage_2.dw_2.getitemnumber( 1, "cs_usdprezzo")
	kst_tab_ptasks_rows.cs_pesonettoxlottokg = tab_1.tabpage_2.dw_2.getitemnumber( 1, "cs_pesonettoxlottokg")
	kst_tab_ptasks_rows.cs_custcode = tab_1.tabpage_2.dw_2.getitemstring( 1, "cs_custcode")
	kst_tab_ptasks_rows.cs_qtabox = tab_1.tabpage_2.dw_2.getitemnumber( 1, "cs_qtabox")
	kst_tab_ptasks_rows.cs_trackitusn = tab_1.tabpage_2.dw_2.getitemstring( 1, "cs_trackitusn")
	kst_tab_ptasks_rows.cs_trackusitn = tab_1.tabpage_2.dw_2.getitemstring( 1, "cs_trackusitn")
	kst_tab_ptasks_rows.cs_speddata = tab_1.tabpage_2.dw_2.getitemdate( 1, "cs_speddata")
	kst_tab_ptasks_rows.cs_charlottedatain = tab_1.tabpage_2.dw_2.getitemdate( 1, "cs_charlottedatain")
	kst_tab_ptasks_rows.cs_charlottewo = tab_1.tabpage_2.dw_2.getitemnumber( 1, "cs_charlottewo")
	kst_tab_ptasks_rows.cs_charlottewodata = tab_1.tabpage_2.dw_2.getitemdate( 1, "cs_charlottewodata")
	kst_tab_ptasks_rows.cs_datarientro = tab_1.tabpage_2.dw_2.getitemdate( 1, "cs_datarientro")
	kst_tab_ptasks_rows.cs_e1so = tab_1.tabpage_2.dw_2.getitemstring( 1, "cs_e1so")
	kst_tab_ptasks_rows.cs_e1sofattura = tab_1.tabpage_2.dw_2.getitemnumber( 1, "cs_e1sofattura")
	kst_tab_ptasks_rows.cs_e1ancillary = tab_1.tabpage_2.dw_2.getitemstring( 1, "cs_e1ancillary")
	kst_tab_ptasks_rows.cs_stgfatturan = tab_1.tabpage_2.dw_2.getitemnumber( 1, "cs_stgfatturan")
	kst_tab_ptasks_rows.cs_stgfatturadata = tab_1.tabpage_2.dw_2.getitemdate( 1, "cs_stgfatturadata")
	kst_tab_ptasks_rows.cs_stgfatturaimporto = tab_1.tabpage_2.dw_2.getitemnumber( 1, "cs_stgfatturaimporto")
	kst_tab_ptasks_rows.cs_stgddtn = tab_1.tabpage_2.dw_2.getitemnumber( 1, "cs_stgddtn")
	kst_tab_ptasks_rows.cs_stgddtdata = tab_1.tabpage_2.dw_2.getitemdate( 1, "cs_stgddtdata")
	kst_tab_ptasks_rows.cs_docfinen = tab_1.tabpage_2.dw_2.getitemstring( 1, "cs_docfinen")
	kst_tab_ptasks_rows.cs_notefatt = tab_1.tabpage_2.dw_2.getitemstring( 1, "cs_notefatt")
	kst_tab_ptasks_rows.cs_invoicen = tab_1.tabpage_2.dw_2.getitemnumber( 1, "cs_invoicen")
	kst_tab_ptasks_rows.cs_invoice_id_cliente = tab_1.tabpage_2.dw_2.getitemnumber( 1, "cs_invoice_id_cliente")
	kst_tab_ptasks_rows.cs_invoicedata = tab_1.tabpage_2.dw_2.getitemdate( 1, "cs_invoicedata")
	kst_tab_ptasks_rows.cs_invoicefirmadata = tab_1.tabpage_2.dw_2.getitemdate( 1, "cs_invoicefirmadata")
	kst_tab_ptasks_rows.cs_invoicefirmanome = tab_1.tabpage_2.dw_2.getitemstring( 1, "cs_invoicefirmanome")
	kst_tab_ptasks_rows.cs_invoicefirmaruolo = tab_1.tabpage_2.dw_2.getitemstring( 1, "cs_invoicefirmaruolo")
end if
 
if tab_1.tabpage_3.dw_3.rowcount( ) > 0 then
else
	tab_1.tabpage_3.dw_3.retrieve( kist_tab_ptasks_rows.id_ptasks_row, 0, 0 ) // recupera i dati della riga
end if
if tab_1.tabpage_3.dw_3.rowcount( ) > 0 then
	kst_tab_ptasks_rows.acc_arrivodata = tab_1.tabpage_3.dw_3.getitemdate( 1, "accettazione_arrivodata")
	kst_tab_ptasks_rows.acc_e1wo = tab_1.tabpage_3.dw_3.getitemnumber( 1, "accettazione_e1wo")
	kst_tab_ptasks_rows.acc_pesolordoxlottokg = tab_1.tabpage_3.dw_3.getitemnumber( 1, "accettazione_pesolordoxlottokg")
	kst_tab_ptasks_rows.acc_dhlbox = tab_1.tabpage_3.dw_3.getitemstring( 1, "accettazione_dhlbox")
	kst_tab_ptasks_rows.acc_boxdimcm = tab_1.tabpage_3.dw_3.getitemstring( 1, "accettazione_boxdimcm")
end if

if tab_1.tabpage_4.dw_4.rowcount( ) > 0 then
else
	tab_1.tabpage_4.dw_4.retrieve( kist_tab_ptasks_rows.id_ptasks_row, 0, 0 ) // recupera i dati della riga
end if
if tab_1.tabpage_4.dw_4.rowcount( ) > 0 then
	kst_tab_ptasks_rows.valid_modaccompn			= tab_1.tabpage_4.dw_4.getitemnumber( 1, "validation_modaccompn")
	kst_tab_ptasks_rows.valid_modaccomprogr		= tab_1.tabpage_4.dw_4.getitemstring( 1, "validation_modaccomprogr")
	kst_tab_ptasks_rows.valid_modaccompdata		= tab_1.tabpage_4.dw_4.getitemdate( 1, "validation_modaccompdata")
	kst_tab_ptasks_rows.valid_modaccompqtadescr	= tab_1.tabpage_4.dw_4.getitemstring( 1, "validation_modaccompqtadescr")
 	kst_tab_ptasks_rows.valid_proddescr 			= tab_1.tabpage_4.dw_4.getitemstring( 1, "validation_proddescr")
 	kst_tab_ptasks_rows.valid_proddescr_eng		= tab_1.tabpage_4.dw_4.getitemstring( 1, "validation_proddescr_eng")
	kst_tab_ptasks_rows.valid_prodlotto 			= tab_1.tabpage_4.dw_4.getitemstring( 1, "validation_prodlotto")  
	kst_tab_ptasks_rows.valid_laboratorio			= tab_1.tabpage_4.dw_4.getitemstring( 1, "validation_laboratorio")  
	kst_tab_ptasks_rows.valid_qaa					   = tab_1.tabpage_4.dw_4.getitemstring( 1, "validation_qaa")
	kst_tab_ptasks_rows.valid_campioniqta			= tab_1.tabpage_4.dw_4.getitemnumber( 1, "validation_campioniqta")
	kst_tab_ptasks_rows.valid_offertarif			= tab_1.tabpage_4.dw_4.getitemstring( 1, "validation_offertarif")
	kst_tab_ptasks_rows.valid_attivitacod			= tab_1.tabpage_4.dw_4.getitemstring( 1, "validation_attivitacod")
	kst_tab_ptasks_rows.valid_speddata				= tab_1.tabpage_4.dw_4.getitemdate( 1, "validation_speddata")
	kst_tab_ptasks_rows.valid_finepresuntadata	= tab_1.tabpage_4.dw_4.getitemdate( 1, "validation_finepresuntadata")
	kst_tab_ptasks_rows.valid_laboratoriocertifn	= tab_1.tabpage_4.dw_4.getitemstring( 1, "validation_laboratoriocertifn")
	kst_tab_ptasks_rows.valid_laboratoriocertifdata = tab_1.tabpage_4.dw_4.getitemdate( 1, "validation_laboratoriocertifdata")
	kst_tab_ptasks_rows.valid_laboratoriocertif1n	= tab_1.tabpage_4.dw_4.getitemstring( 1, "validation_laboratoriocertif1n")
	kst_tab_ptasks_rows.valid_laboratoriocertif1data = tab_1.tabpage_4.dw_4.getitemdate( 1, "validation_laboratoriocertif1data")
	kst_tab_ptasks_rows.valid_dose					= tab_1.tabpage_4.dw_4.getitemnumber( 1, "validation_dose")
	kst_tab_ptasks_rows.valid_dose_min				= tab_1.tabpage_4.dw_4.getitemnumber( 1, "validation_dose_min")
	kst_tab_ptasks_rows.valid_dose_max				= tab_1.tabpage_4.dw_4.getitemnumber( 1, "validation_dose_max")
	kst_tab_ptasks_rows.valid_notereport			= tab_1.tabpage_4.dw_4.getitemstring( 1, "validation_notereport")
	kst_tab_ptasks_rows.valid_noterifpo 			= tab_1.tabpage_4.dw_4.getitemstring( 1, "validation_noterifpo")
	kst_tab_ptasks_rows.valid_notealtre 			= tab_1.tabpage_4.dw_4.getitemstring( 1, "validation_notealtre")
end if

if tab_1.tabpage_5.dw_5.rowcount( ) > 0 then
else
	tab_1.tabpage_5.dw_5.retrieve( kist_tab_ptasks_rows.id_ptasks_row, 0, 0 ) // recupera i dati della riga
end if
if tab_1.tabpage_5.dw_5.rowcount( ) > 0 then
	kst_tab_ptasks_rows.approvv_stgcharlfattinterc = tab_1.tabpage_5.dw_5.getitemstring( 1, "approvvigionamenti_stgcharlfattinterc")
end if

end subroutine

protected function integer inserisci_4 ();//
int k_return, k_ctr
st_tab_ptasks_types kst_tab_ptasks_types


kst_tab_ptasks_types.id_ptasks_type = tab_1.tabpage_1.dw_task.event u_get_id_ptasks_type()

if kst_tab_ptasks_types.id_ptasks_type > 0 and tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
	
	tab_1.tabpage_4.dw_4.ki_flag_modalita = kkg_flag_modalita.inserimento
	k_return = tab_1.tabpage_4.dw_4.insertrow(0)

	tab_1.tabpage_4.dw_4.setitem(1, "id_ptasks_row", 0)
	tab_1.tabpage_4.dw_4.setitem(1, "id_ptask", tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask"))
	tab_1.tabpage_4.dw_4.setitem(1, "id_ptasks_type", kst_tab_ptasks_types.id_ptasks_type)
	tab_1.tabpage_4.dw_4.setitem(1, "ptasks_types_descr", tab_1.tabpage_1.dw_task.event u_get_type_descr())
	tab_1.tabpage_4.dw_4.setitem(1, "task", tab_1.tabpage_1.dw_task.event u_get_task())

	tab_1.tabpage_4.dw_4.resetupdate( )
			
else
	tab_1.tabpage_4.dw_4.reset( )
end if


return (k_return)



end function

protected function integer u_dw_4_inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_return
long k_id_ptasks_type


try
	SetPointer(kkg.pointer_attesa)

	if tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask") > 0 then
		k_id_ptasks_type = tab_1.tabpage_1.dw_task.event u_get_id_ptasks_type()
		if k_id_ptasks_type > 0 then
				
			tab_1.tabpage_4.dw_4.ki_flag_modalita = ki_st_open_w.flag_modalita
	
			k_return = tab_1.tabpage_4.dw_4.retrieve(0 &
															,tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask") &
															,k_id_ptasks_type) 
	
			if k_return < 0 then
				kguo_exception.inizializza(this.classname())
				kguo_exception.kist_esito.esito = kkg_esito.db_ko
				kguo_exception.kist_esito.sqlerrtext = "Ricerca Fallita dati '" + trim(tab_1.tabpage_4.text) + "', errore dal DB"
				kguo_exception.scrivi_log( )
				throw kguo_exception
			end if
			
			if k_return = 0 then
				if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then

					k_return = inserisci_4()
					
				end if
			end if
		end if
	end if

	if k_return > 0 then
		if tab_1.tabpage_4.dw_4.ki_flag_modalita = kkg_flag_modalita.modifica &
					or tab_1.tabpage_4.dw_4.ki_flag_modalita = kkg_flag_modalita.inserimento then
			tab_1.tabpage_4.dw_4.event u_ddwc_retrieve() // Prepara le DDWC
		end if
		
		tab_1.tabpage_4.dw_4.setitem(1, "k_flag_modalita", tab_1.tabpage_4.dw_4.ki_flag_modalita)
		tab_1.tabpage_4.dw_4.SetItemStatus( 1, "k_flag_modalita", Primary!, NotModified!)
	else
		tab_1.tabpage_4.dw_4.reset()
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)
	
end try


return k_return 

end function

protected subroutine inizializza_3 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_rc
int k_rows
st_tab_meca kst_tab_meca


if tab_1.tabpage_4.dw_4.rowcount() = 0 then
	
	k_rows = u_dw_4_inizializza( )
	
	if k_rows = 0 then
		tab_1.tabpage_4.dw_4.visible = false
	else
		tab_1.tabpage_4.dw_4.visible = true
	end if
	
	tab_1.tabpage_4.dw_4.setcolumn("validation_modaccomprogr")
	
end if	

tab_1.tabpage_4.dw_4.ki_flag_modalita = ki_st_open_w.flag_modalita
kiuf_utility.u_proteggi_sproteggi_dw_no_protect(tab_1.tabpage_4.dw_4)

end subroutine

protected function integer inserisci_5 ();//
int k_return, k_ctr
st_tab_ptasks_types kst_tab_ptasks_types


kst_tab_ptasks_types.id_ptasks_type = tab_1.tabpage_1.dw_task.event u_get_id_ptasks_type()

if kst_tab_ptasks_types.id_ptasks_type > 0 and tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
	
	tab_1.tabpage_5.dw_5.ki_flag_modalita = kkg_flag_modalita.inserimento
	k_return = tab_1.tabpage_5.dw_5.insertrow(0)

	tab_1.tabpage_5.dw_5.setitem(1, "id_ptasks_row", 0)
	tab_1.tabpage_5.dw_5.setitem(1, "id_ptask", tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask"))
	tab_1.tabpage_5.dw_5.setitem(1, "id_ptasks_type", kst_tab_ptasks_types.id_ptasks_type)
	tab_1.tabpage_5.dw_5.setitem(1, "ptasks_types_descr", tab_1.tabpage_1.dw_task.event u_get_type_descr())
	tab_1.tabpage_5.dw_5.setitem(1, "task", tab_1.tabpage_1.dw_task.event u_get_task())

	tab_1.tabpage_5.dw_5.resetupdate( )
			
else
	tab_1.tabpage_5.dw_5.reset( )
end if


return (k_return)



end function

protected function integer u_dw_5_inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_return
long k_id_ptasks_type


try
	SetPointer(kkg.pointer_attesa)

	if tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask") > 0 then
		k_id_ptasks_type = tab_1.tabpage_1.dw_task.event u_get_id_ptasks_type()
		if k_id_ptasks_type > 0 then
				
			tab_1.tabpage_5.dw_5.ki_flag_modalita = ki_st_open_w.flag_modalita
	
			k_return = tab_1.tabpage_5.dw_5.retrieve(0 &
															,tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask") &
															,k_id_ptasks_type) 
	
			if k_return < 0 then
				kguo_exception.inizializza(this.classname())
				kguo_exception.kist_esito.esito = kkg_esito.db_ko
				kguo_exception.kist_esito.sqlerrtext = "Ricerca Fallita dati '" + trim(tab_1.tabpage_5.text) + "', errore dal DB"
				kguo_exception.scrivi_log( )
				throw kguo_exception
			end if
			
			if k_return = 0 then
				if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then

					k_return = inserisci_5()
					
				end if
			end if
		end if
	end if

	if k_return > 0 then
		tab_1.tabpage_5.dw_5.setitem(1, "k_flag_modalita", tab_1.tabpage_5.dw_5.ki_flag_modalita)
		tab_1.tabpage_5.dw_5.SetItemStatus( 1, "k_flag_modalita", Primary!, NotModified!)
	else
		tab_1.tabpage_5.dw_5.reset()
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)
	
end try


return k_return 

end function

protected subroutine inizializza_4 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_rc
int k_rows
st_tab_meca kst_tab_meca


if tab_1.tabpage_5.dw_5.rowcount() = 0 then
	
	k_rows = u_dw_5_inizializza( )
	
	if k_rows = 0 then
		tab_1.tabpage_5.dw_5.visible = false
	else
		tab_1.tabpage_5.dw_5.visible = true
	end if
	
	tab_1.tabpage_5.dw_5.setcolumn("approvvigionamenti_stgcharlfattinterc")
	
end if	

tab_1.tabpage_5.dw_5.ki_flag_modalita = ki_st_open_w.flag_modalita
kiuf_utility.u_proteggi_sproteggi_dw_no_protect(tab_1.tabpage_5.dw_5)

end subroutine

protected function boolean dati_modif_0 ();//

return tab_1.tabpage_1.dw_task.event u_if_modifyed()

end function

private function integer u_dw_task_change_selected ();//
//--- verifica se è cambiato qualcosa nelle schede dati
//
int k_return
int k_rc, k_row_task
long k_id_ptasks_type, k_id_ptask
string k_esito
boolean k_modificato

	
//	if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then 

	k_row_task = tab_1.tabpage_1.dw_task.getselectedrow(0)
	if k_row_task > 0 then
		k_id_ptasks_type = tab_1.tabpage_1.dw_task.getitemnumber(k_row_task, "id_ptasks_type")
	end if
	
	//=== Controllo se ho modificato dei dati nelle Schede
	dati_modif_accept( )
	k_modificato =  dati_modif_dw(tab_1.tabpage_2.dw_2) 
	if not k_modificato then 
		k_modificato =  dati_modif_dw(tab_1.tabpage_3.dw_3) 
	elseif not k_modificato then
		k_modificato =  dati_modif_dw(tab_1.tabpage_4.dw_4) 
	elseif not k_modificato then 
		k_modificato =  dati_modif_dw(tab_1.tabpage_5.dw_5) 
	end if
	if k_modificato then 
		
		k_rc = messagebox("Salvare i dati", "Dati Modificati. Per mantenere i dati salvare gli Aggiornamenti prima di cambiare Attività. Procedere?", &
									question!, yesnocancel!, 1) 
		if k_rc = 3 then
			
			k_return = 2
	
		else
			
			if k_rc = 1 then
		
	//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
	//===	              : 2=Errore Non grave dati aggiornati
	//===               : 3=
				k_esito = aggiorna_dati()	
				if Left(k_esito, 1) = "1" then
					k_return = 2
				end if
			end if
		end if
	end if
		
		
	if k_return = 0 then
	
		if k_row_task > 0 then
			
			k_id_ptask = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask")
		
			if tab_1.tabpage_2.dw_2.rowcount( ) > 0 then 
				if k_id_ptask <> tab_1.tabpage_2.dw_2.getitemnumber(1, "id_ptask") &
						or k_id_ptasks_type <> tab_1.tabpage_2.dw_2.getitemnumber(1, "id_ptasks_type") then
					tab_1.tabpage_2.dw_2.reset( )
				end if
			end if
			if tab_1.tabpage_3.dw_3.rowcount( ) > 0 then 
				if k_id_ptask <> tab_1.tabpage_3.dw_3.getitemnumber(1, "id_ptask") &
						or k_id_ptasks_type <> tab_1.tabpage_3.dw_3.getitemnumber(1, "id_ptasks_type") then
					tab_1.tabpage_3.dw_3.reset( )
				end if
			end if
			if tab_1.tabpage_4.dw_4.rowcount( ) > 0 then 
				if k_id_ptask <> tab_1.tabpage_4.dw_4.getitemnumber(1, "id_ptask") &
						or k_id_ptasks_type <> tab_1.tabpage_4.dw_4.getitemnumber(1, "id_ptasks_type") then
					tab_1.tabpage_4.dw_4.reset( )
				end if
			end if
			if tab_1.tabpage_5.dw_5.rowcount( ) > 0 then 
				if k_id_ptask <> tab_1.tabpage_5.dw_5.getitemnumber(1, "id_ptask") &
						or k_id_ptasks_type <> tab_1.tabpage_5.dw_5.getitemnumber(1, "id_ptasks_type") then
					tab_1.tabpage_5.dw_5.reset( )
				end if
			end if
			
		else
			tab_1.tabpage_2.dw_2.reset( )
			tab_1.tabpage_3.dw_3.reset( )
			tab_1.tabpage_4.dw_4.reset( )
			tab_1.tabpage_5.dw_5.reset( )
		end if
		//--- tab di riepilogo generale dei dati
		if tab_1.tabpage_7.dw_7.rowcount( ) > 0 then 
			if k_id_ptask <> tab_1.tabpage_7.dw_7.getitemnumber(1, "id_ptask") then
				tab_1.tabpage_7.dw_7.reset( )
			end if
		end if
		
		kist_tab_ptasks_rows.id_ptasks_type = k_id_ptasks_type
	end if
	
return k_return 

	
end function

protected function integer u_dw_7_inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_return
long k_id_ptasks_type


try
	SetPointer(kkg.pointer_attesa)

	if tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask") > 0 then
				
		tab_1.tabpage_7.dw_7.ki_flag_modalita = kkg_flag_modalita.visualizzazione
	
		k_return = tab_1.tabpage_7.dw_7.retrieve(tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask"))
	
		if k_return < 0 then
			kguo_exception.inizializza(this.classname())
			kguo_exception.kist_esito.esito = kkg_esito.db_ko
			kguo_exception.kist_esito.sqlerrtext = "Ricerca Fallita dati '" + trim(tab_1.tabpage_7.text) + "', errore dal DB"
			kguo_exception.scrivi_log( )
			throw kguo_exception
		end if
	end if

	if k_return > 0 then
	else
		tab_1.tabpage_7.dw_7.reset()
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
//	kiuf_utility.u_proteggi_sproteggi_dw(tab_1.tabpage_7.dw_7)
	SetPointer(kkg.pointer_default)
	
end try

return k_return 

end function

protected subroutine inizializza_6 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_rc
int k_rows
st_tab_meca kst_tab_meca


if tab_1.tabpage_7.dw_7.rowcount() = 0 then
	
	k_rows = u_dw_7_inizializza( )
	
	if k_rows = 0 then
		tab_1.tabpage_7.dw_7.visible = false
	else
		tab_1.tabpage_7.dw_7.visible = true
	end if
		
end if	

end subroutine

protected subroutine riempi_id ();//

if tab_1.tabpage_1.dw_1.rowcount() > 0 then

	kist_tab_ptasks_orig.status = tab_1.tabpage_1.dw_1.getitemstring(1, "status")
	if kist_tab_ptasks_orig.status > " " then
	else
		kist_tab_ptasks_orig.status = kiuf_ptasks.kki_status_aperto
		tab_1.tabpage_1.dw_1.setitem(1, "status", kist_tab_ptasks_orig.status)
	end if

	if tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente") > 0 then
	else
		tab_1.tabpage_1.dw_1.setitem(1, "id_cliente", 0)
	end if
	if tab_1.tabpage_1.dw_1.getitemstring(1, "cntr_val") > " " then
	else
		tab_1.tabpage_1.dw_1.setitem(1, "cntr_val", "")
	end if
	if tab_1.tabpage_1.dw_1.getitemstring(1, "cntr_descr") > " " then
	else
		tab_1.tabpage_1.dw_1.setitem(1, "cntr_descr", "")
	end if
	if tab_1.tabpage_1.dw_1.getitemdate(1, "cntr_expiry") > date(0) then
	else
		tab_1.tabpage_1.dw_1.setitem(1, "cntr_expiry", date(0))
	end if

end if
end subroutine

protected subroutine inizializza_8 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_rc
int k_rows
st_tab_meca kst_tab_meca


if tab_1.tabpage_9.dw_9.rowcount() = 0 then
	
	k_rows = u_dw_9_inizializza( )
	
	if k_rows = 0 then
		tab_1.tabpage_9.dw_9.visible = false
	else
		tab_1.tabpage_9.dw_9.visible = true
	end if
		
end if	

end subroutine

protected function integer u_dw_9_inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_return
long k_id_ptasks_type


try
	SetPointer(kkg.pointer_attesa)

	if tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask") > 0 then
				
		tab_1.tabpage_9.dw_9.ki_flag_modalita = kkg_flag_modalita.visualizzazione
	
		k_return = tab_1.tabpage_9.dw_9.retrieve(tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask"))
	
		if k_return < 0 then
			kguo_exception.inizializza(this.classname())
			kguo_exception.kist_esito.esito = kkg_esito.db_ko
			kguo_exception.kist_esito.sqlerrtext = "Ricerca Fallita dati '" + trim(tab_1.tabpage_9.text) + "', errore dal DB"
			kguo_exception.scrivi_log( )
			throw kguo_exception
		end if
	end if

	if k_return > 0 then
	else
		tab_1.tabpage_9.dw_9.reset()
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
//	kiuf_utility.u_proteggi_sproteggi_dw(tab_1.tabpage_9.dw_9)
	SetPointer(kkg.pointer_default)
	
end try

return k_return 

end function

protected subroutine attiva_menu ();//
//--- Attiva/Dis. Voci di menu personalizzate
//
	m_main.m_strumenti.m_fin_gest_libero9.text = "Stampa Moduli Laboratorio e Fatture (Invoice)"
	m_main.m_strumenti.m_fin_gest_libero9.microhelp = "Stampa Moduli Laboratorio e Fatture (Invoice)"
	m_main.m_strumenti.m_fin_gest_libero9.visible = true
	if tab_1.selectedtab = 9 then
		m_main.m_strumenti.m_fin_gest_libero9.enabled = tab_1.tabpage_9.dw_9.visible
	else
		m_main.m_strumenti.m_fin_gest_libero9.enabled = false
	end if
	m_main.m_strumenti.m_fin_gest_libero9.toolbaritemVisible = true
	m_main.m_strumenti.m_fin_gest_libero9.toolbaritemText = "Moduli,"+m_main.m_strumenti.m_fin_gest_libero9.text
	m_main.m_strumenti.m_fin_gest_libero9.toolbaritemName = "printa16.png"
	
//---
	super::attiva_menu()


end subroutine

public subroutine smista_funz (string k_par_in);//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===


choose case k_par_in 

	case KKG_FLAG_RICHIESTA.libero9	//stampa modulo Laboratorio
		u_stampa_mod( )
		
	case else
		super::smista_funz(k_par_in)

end choose




end subroutine

public function long u_get_valid_modaccompn ();//
long k_return


try
	
	setpointer(kkg.pointer_attesa)
	
	k_return = kiuf_ptasks_rows.get_valid_modaccompn_last_by_base()
	
	setpointer(kkg.pointer_default)
	

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally


end try
	
return k_return	
end function

private function integer u_dw_1_inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
int k_err_ins, k_rc
boolean k_flag_numero_lotto_modificato = false
st_tab_clienti kst_tab_clienti
st_tab_ptasks kst_tab_ptasks_attuale
st_esito kst_esito



	SetPointer(kkg.pointer_attesa)

	u_tab_1_tabpage_dw_reset( ) // reset di tutti i TAB
	k_rc = tab_1.tabpage_1.dw_1.retrieve(kist_tab_ptasks_orig.id_ptask) 
	
	choose case k_rc

		case is < 0		
			SetPointer(kkg.pointer_default)
			kguo_exception.inizializza(this.classname())
			kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
			kguo_exception.setmessage(  &
				"Attenzione si e' verificato un errore in lettura del Progetto n. " &
				+ string(kist_tab_ptasks_orig.id_ptask)) 
			tab_1.tabpage_1.dw_1.event u_disp_avvertenze(kguo_exception.getmessage( ))
			kguo_exception.messaggio_utente( )	
			//post close(this)

		case 0
			tab_1.tabpage_1.dw_1.reset()

			if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
				
				ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento

				SetPointer(kkg.pointer_default)
				kguo_exception.inizializza()
				kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_not_fnd )
				kguo_exception.setmessage(  &
							"Il Progetto richiesto n. " + string(kist_tab_ptasks_orig.id_ptask) &
							+ " non e' stato trovato in archivio.") // ~n~r" )
				//tab_1.tabpage_1.dw_1.event u_disp_avvertenze(kguo_exception.getmessage( ))
				kguo_exception.messaggio_utente( )	
				//close(this)
			end if

		case is > 0		
			ki_status_enable = true
			
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
				SetPointer(kkg.pointer_default)
				kguo_exception.inizializza()
				kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_allerta )
				kguo_exception.setmessage(  &
							"Attenzione, il Progetto n. " &
							+ string(kist_tab_ptasks_orig.id_ptask) &
							+ " è già Presente in Archivio") // ~n~r" 
				tab_1.tabpage_1.dw_1.event u_disp_avvertenze(kguo_exception.getmessage( ))
				kguo_exception.messaggio_utente( )	
		
				ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica

			end if

			try
			
			//--- se sono in CANCELLAZIONE....
				if ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then
				
				//--- se sono entrato x cancellazione...				
					ki_esci_dopo_cancella = true
					tab_1.tabpage_1.dw_1.ki_flag_modalita = kkg_flag_modalita.cancellazione
					kiuf_utility.u_proteggi_sproteggi_dw(tab_1.tabpage_1.dw_1)
					tab_1.tabpage_1.dw_1.visible = true
					cancella()
				
				else
					
					//u_protegge_sprotegge_dw( )
			
					tab_1.tabpage_1.dw_task.event u_retrieve( )  // popolo box Attività
					
				end if 
	
			catch (uo_exception kuo2_exception)
				tab_1.tabpage_1.dw_1.visible = true
				tab_1.tabpage_1.dw_1.event u_disp_avvertenze(kguo_exception.getmessage( ))
				kuo2_exception.messaggio_utente()
			
			finally
			
			end try
	
		tab_1.tabpage_1.dw_1.visible = true
		if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
			tab_1.tabpage_1.dw_task.setfocus()
		else
			tab_1.tabpage_1.dw_1.setfocus()
		end if
	
	end choose

	SetPointer(kkg.pointer_default)
	
return 0


end function

private subroutine u_protegge_sprotegge_dw ();//

	if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
		
		kist_tab_ptasks_orig.status = tab_1.tabpage_1.dw_1.getitemstring(1, "status")
		if kist_tab_ptasks_orig.status = kiuf_ptasks.kki_status_aperto &
						or trim(kist_tab_ptasks_orig.status) = "" then
		else
			ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
		end if
	end if

	tab_1.tabpage_1.dw_1.ki_flag_modalita = ki_st_open_w.flag_modalita
	kiuf_utility.u_proteggi_sproteggi_dw(tab_1.tabpage_1.dw_1)

//--- Inabilita alcuni campi alla modifica se Funzione MODIFICA
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
		
		kiuf_utility.u_proteggi_dw("1", "id_ptasks_types_grp", tab_1.tabpage_1.dw_1)
		kiuf_utility.u_proteggi_dw("1", "rag_soc_10", tab_1.tabpage_1.dw_1)
		kiuf_utility.u_proteggi_dw("1", "id_cliente", tab_1.tabpage_1.dw_1)
		
		tab_1.tabpage_1.dw_1.event u_ddwc( )
	end if
	
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica &
			or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
		tab_1.tabpage_1.dw_1.modify("kget_n_ptask = '1'")
	else
		tab_1.tabpage_1.dw_1.modify("kget_n_ptask = '0'")
	end if

//--- campo STATUS da abilitare se sono entrato in MODIFICA 
	if ki_status_enable then
		kiuf_utility.u_proteggi_dw("0", "status", tab_1.tabpage_1.dw_1)
	else
		kiuf_utility.u_proteggi_dw("1", "status", tab_1.tabpage_1.dw_1)
	end if


end subroutine

private subroutine u_aggiorna () throws uo_exception;//
//---------------------------------------------------------------------
//--- Aggiorna tabelle 
//--- Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//--- 				  : 2=
//---					  : 3=Commit fallita
//---		dal char 2 in poi spiegazione dell'errore
//---------------------------------------------------------------------
//
int k_rc
long k_riga, k_id_ptasks_row
st_esito kst_esito
st_tab_ptasks_rows kst_tab_ptasks_rows
datetime k_datetime


try

	setpointer(kkg.pointer_attesa) 
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	k_riga = tab_1.tabpage_1.dw_1.getrow()

	//=== Aggiorna, se modificato, la TAB_1	
	if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0	&
				or tab_1.tabpage_1.dw_task.event u_if_modifyed( ) then

		kist_tab_ptasks_orig.id_ptask = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask")
		if kist_tab_ptasks_orig.id_ptask = 0 then 
					//if tab_1.tabpage_1.dw_1.GetItemStatus(tab_1.tabpage_1.dw_1.getrow(), 0,  primary!) = NewModified!	then
			if tab_1.tabpage_1.dw_1.getitemdatetime(1, "date_ins") > kguo_g.get_datetime_zero( ) then
			else
				tab_1.tabpage_1.dw_1.setitem(1, "date_ins", kGuf_data_base.prendi_x_datins())
			end if
			tab_1.tabpage_1.dw_1.setitem(1, "user_ins", kGuf_data_base.prendi_x_utente())
		end if
		tab_1.tabpage_1.dw_1.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins())
		tab_1.tabpage_1.dw_1.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente())

		k_rc = tab_1.tabpage_1.dw_1.update( )
		if k_rc < 0 then
			kst_esito.sqlcode = k_rc
			kst_esito.esito = kkg_esito.db_ko  // fermo la registrazione  ROLLBACK!
			if kist_tab_ptasks_orig.id_ptask = 0 then
				kst_esito.sqlerrtext = "Errore in Inserimento nuovo Progetto!  Operazione non eseguita." //, ~n~r" 
			else
				kst_esito.sqlerrtext = "Errore in Aggiornamento del Progetto id.'" + string(kist_tab_ptasks_orig.id_ptask) + "'! Operazione non eseguita." //, ~n~r" 
			end if
			kguo_exception.set_esito(kst_esito)
			tab_1.tabpage_1.dw_1.event u_disp_avvertenze(kst_esito.sqlerrtext)
			throw kguo_exception
		end if

		if kist_tab_ptasks_orig.id_ptask > 0 then
		else
			kist_tab_ptasks_orig.id_ptask = kiuf_ptasks.get_id_ptask_max( )
			ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
		end if
//--- aggiorna l'elenco delle Attività
		kist_tab_ptasks_orig.ptasks_types_json = u_get_ptasks_types_json( )
		kiuf_ptasks.tb_update_json(kist_tab_ptasks_orig)

		if tab_1.tabpage_1.dw_1.GetItemnumber(1, "id_ptask") > 0 then
			tab_1.tabpage_1.dw_1.event u_disp_avvertenze("Aggiornato il Progetto n. " + string(kist_tab_ptasks_orig.id_ptask))
		else
			tab_1.tabpage_1.dw_1.event u_disp_avvertenze("Caricato il nuovo Progetto n. " + string(kist_tab_ptasks_orig.id_ptask))
		end if

		tab_1.tabpage_1.dw_1.setitem(1, "id_ptask", kist_tab_ptasks_orig.id_ptask)
		tab_1.tabpage_1.dw_1.resetupdate( )
		tab_1.tabpage_1.dw_task.event u_copy_to_kids_1( )

	end if

	if tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 &
							or tab_1.tabpage_3.dw_3.getnextmodified(0, primary!) > 0 &
							or tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0 &
							or tab_1.tabpage_5.dw_5.getnextmodified(0, primary!) > 0 then


//--- recupera i dati dalle schede per fare un unico record
		u_set_st_tab_ptasks_rows_from_dw(kst_tab_ptasks_rows)

		if tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 then
			
//--- get ID_MECA from ddwc da mettere su PTASKS
			kist_tab_ptasks_orig.id_meca = 0
			if kst_tab_ptasks_rows.cs_clienteddtn > ' ' then
				kist_tab_ptasks_orig.id_meca = tab_1.tabpage_2.dw_2.event u_ddwc_ddt_in_get_id_meca( )
			end if
			kiuf_ptasks.set_id_meca(kist_tab_ptasks_orig)
			tab_1.tabpage_1.dw_1.setitem(1, "id_meca", kist_tab_ptasks_orig.id_meca)
		
		end if
		
//--- aggiorna le righe
		if kst_tab_ptasks_rows.id_ptasks_row > 0 then
			kiuf_ptasks_rows.tb_update(kst_tab_ptasks_rows)
		else
			kiuf_ptasks_rows.tb_insert(kst_tab_ptasks_rows)
		end if
		if k_rc < 0 then
			kst_esito.sqlcode = k_rc
			kst_esito.esito = kkg_esito.db_ko  // fermo la registrazione  ROLLBACK!
			kst_esito.sqlerrtext = "Errore in Aggiornamento dati '" &
							+ trim(tab_1.tabpage_2.text) + "' del Progetto!" //, ~n~r" 
			kguo_exception.set_esito(kst_esito)
			tab_1.tabpage_1.dw_1.event u_disp_avvertenze(kst_esito.sqlerrtext)
			throw kguo_exception
		end if

		k_id_ptasks_row = kst_tab_ptasks_rows.id_ptasks_row
		if kst_tab_ptasks_rows.id_ptasks_row = 0 then
			kst_tab_ptasks_rows.id_ptasks_row = kiuf_ptasks_rows.get_id_ptasks_row_max(kst_tab_ptasks_rows)
		end if
//--- aggiorna l'elenco delle Attività
		kist_tab_ptasks_orig.ptasks_types_json = u_get_ptasks_types_json( )
		//kiuf_ptasks_rows.tb_update_json(kist_tab_ptasks_orig)

		if k_id_ptasks_row > 0 then
			tab_1.tabpage_1.dw_1.event u_disp_avvertenze("Aggiornati dati '" &
							+ trim(tab_1.tabpage_2.text) + "' del Progetto n. " + string(kst_tab_ptasks_rows.id_ptask))
		else
			tab_1.tabpage_1.dw_1.event u_disp_avvertenze("Caricato i nuovi dati '" &
							+ trim(tab_1.tabpage_2.text) + "' del Progetto n. " + string(kst_tab_ptasks_rows.id_ptask))
		end if

		if tab_1.tabpage_2.dw_2.rowcount( ) > 0 then
			tab_1.tabpage_2.dw_2.setitem(1, "id_ptasks_row", kst_tab_ptasks_rows.id_ptasks_row)
		end if
		if tab_1.tabpage_3.dw_3.rowcount( ) > 0 then
			tab_1.tabpage_3.dw_3.setitem(1, "id_ptasks_row", kst_tab_ptasks_rows.id_ptasks_row)
		end if
		if tab_1.tabpage_4.dw_4.rowcount( ) > 0 then
			tab_1.tabpage_4.dw_4.setitem(1, "id_ptasks_row", kst_tab_ptasks_rows.id_ptasks_row)
		end if
		if tab_1.tabpage_5.dw_5.rowcount( ) > 0 then
			tab_1.tabpage_5.dw_5.setitem(1, "id_ptasks_row", kst_tab_ptasks_rows.id_ptasks_row)
		end if

	end if

//--- Se tutto OK faccio la COMMIT -------------------------------------------------------------------------------------------------------------------		
	kguo_sqlca_db_magazzino.db_commit( )    

//---- azzera il flag delle modifiche
	u_tab_1_tabpage_dw_resetupdate( )

//--- infine aggiorna n. modulo sul base se superiore all'esistente
	if kst_tab_ptasks_rows.valid_modaccompn > 0 then
		
		k_datetime = tab_1.tabpage_1.dw_1.GetItemdatetime(1, "date_ins")
		
		kiuf_ptasks_rows.set_valid_modaccompn_last_in_base(kst_tab_ptasks_rows, year(date(k_datetime)))
	end if

//--- infine aggiorna n. Fattura sul base se superiore all'esistente
	if kst_tab_ptasks_rows.cs_invoicen > 0 &
				and year(kst_tab_ptasks_rows.cs_invoicedata) = kguo_g.get_anno( ) then
		kiuf_ptasks_rows.set_cs_invoicen_last_in_base(kst_tab_ptasks_rows)
	end if
		
catch (uo_exception kuo_exception)
	kguo_sqlca_db_magazzino.db_rollback()   // ROLLBACK
	throw kuo_exception


finally
	u_set_tab_1_enable()		

	setpointer(kkg.pointer_default)
	
end try


end subroutine

public function long u_get_cs_invoicen ();//
long k_return


try
	
	setpointer(kkg.pointer_attesa)
	
	k_return = kiuf_ptasks_rows.get_cs_invoicen_last_by_base()
	
	setpointer(kkg.pointer_default)
	

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally


end try
	
return k_return	
end function

public subroutine u_stampa_mod ();//
string k_tipo
int k_rc, k_row


try

	SetPointer(kkg.pointer_attesa)
	if tab_1.tabpage_9.dw_9.rowcount( ) = 1 then
		tab_1.tabpage_9.dw_9.selectrow(1, true)
		tab_1.tabpage_9.dw_9.setrow(1)
	end if
	k_row = tab_1.tabpage_9.dw_9.getselectedrow(0)
	if k_row = 0 then
		messagebox("Stampa Modulo", "Selezionare almeno una riga dall'elenco")
	end if
	do while k_row > 0
	
		k_tipo = tab_1.tabpage_9.dw_9.getitemstring(k_row, "k_tipo_modulo")
		if k_tipo = "INVOICE" then

			u_stampa_mod_invoice(k_row)

		else
			
			u_stampa_mod_laboratorio(k_row)
			
		end if

		if tab_1.tabpage_4.dw_4.rowcount( ) > 0 then
			tab_1.tabpage_4.dw_4.ReselectRow(1)
		end if
		tab_1.tabpage_9.dw_9.ReselectRow(k_row)
		
		k_row = tab_1.tabpage_9.dw_9.getselectedrow(k_row)
	loop
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try



end subroutine

public subroutine u_stampa_mod_invoice (long a_row);//
//long k_num_riga, k_riga
string k_stampa
int k_rc
st_tab_ptasks_rows kst_tab_ptasks_rows
st_stampe kst_stampe


try

	SetPointer(kkg.pointer_attesa)
	kst_tab_ptasks_rows.id_ptasks_row = tab_1.tabpage_9.dw_9.getitemnumber(a_row, "id_ptasks_row")
	kst_tab_ptasks_rows.cs_invoicen = tab_1.tabpage_9.dw_9.getitemnumber(a_row, "validation_modaccompn")
	kst_tab_ptasks_rows.cs_invoicedata = tab_1.tabpage_9.dw_9.getitemdate(a_row, "validation_modaccompdata")
	kst_tab_ptasks_rows.valid_proddescr = trim(tab_1.tabpage_9.dw_9.getitemstring(a_row, "validation_laboratorio"))
	
	if kst_tab_ptasks_rows.valid_proddescr > " " then
	else
		kst_tab_ptasks_rows.valid_proddescr = "*non indicato*"
	end if
	
	k_stampa = "Fattura n. " + string(kst_tab_ptasks_rows.cs_invoicen) + " " &
				+ "del " + string(kst_tab_ptasks_rows.cs_invoicedata, "dd mmm yyyy") &
				+ " - " + kst_tab_ptasks_rows.valid_proddescr + "'" 

	if not isvalid(kst_stampe.ds_print) then kst_stampe.ds_print = create datastore
	kst_stampe.ds_print.reset( )
	kst_stampe.ds_print.dataobject = "d_ptasks_invoice"
	kst_stampe.ds_print.settransobject(kguo_sqlca_db_magazzino)
	k_rc = kst_stampe.ds_print.retrieve(kst_tab_ptasks_rows.id_ptasks_row)
	if k_rc > 0 then
		kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta
		kst_stampe.titolo = trim(k_stampa)
		kGuf_data_base.stampa_dw(kst_stampe)
		kst_stampe.titolo = trim(k_stampa)
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try



end subroutine

public subroutine u_stampa_mod_laboratorio (long a_row);//
//long k_num_riga, k_riga
string k_stampa
int k_rc
st_tab_ptasks_rows kst_tab_ptasks_rows
st_stampe kst_stampe


try

	SetPointer(kkg.pointer_attesa)
	kst_tab_ptasks_rows.id_ptasks_row = tab_1.tabpage_9.dw_9.getitemnumber(a_row, "id_ptasks_row")
	kst_tab_ptasks_rows.valid_modaccompn = tab_1.tabpage_9.dw_9.getitemnumber(a_row, "validation_modaccompn")
	kst_tab_ptasks_rows.valid_laboratorio = tab_1.tabpage_9.dw_9.getitemstring(a_row, "validation_laboratorio")
	if kst_tab_ptasks_rows.valid_laboratorio > " " then
	else
		kst_tab_ptasks_rows.valid_laboratorio = "*non indicato*"
	end if
	k_stampa = "Modulo Laboratorio '" + kst_tab_ptasks_rows.valid_laboratorio + "'" &
				+ " Attività '" + string(tab_1.tabpage_9.dw_9.getitemnumber(a_row, "id_ptasks_type")) &
				+ " - " + tab_1.tabpage_9.dw_9.getitemstring(a_row, "ptasks_types_descr") + "'" 

	if not isvalid(kst_stampe.ds_print) then kst_stampe.ds_print = create datastore
	kst_stampe.ds_print.reset( )
	kst_stampe.ds_print.dataobject = "d_ptasks_report_lab"
	kst_stampe.ds_print.settransobject(kguo_sqlca_db_magazzino)
	k_rc = kst_stampe.ds_print.retrieve(kst_tab_ptasks_rows.id_ptasks_row)
	if k_rc > 0 then
			
		kst_tab_ptasks_rows.valid_modaccompdata = kst_stampe.ds_print.getitemdate(1, "validation_modaccompdata")
		if kst_tab_ptasks_rows.valid_modaccompdata > kkg.data_no then
		else
			kst_tab_ptasks_rows.valid_modaccompdata = kguo_g.get_dataoggi()
			kst_stampe.ds_print.setitem(1, "validation_modaccompdata", kst_tab_ptasks_rows.valid_modaccompdata)
			if messagebox("Stampa Modulo", "Aggiorno la data di emissione per il " + k_stampa &
							+ " (id " + string(kst_tab_ptasks_rows.id_ptasks_row) + ") ?" &
							,Question! ,YesNo!, 2) = 1 then
				
				kiuf_ptasks_rows.set_valid_modaccompdata(kst_tab_ptasks_rows)
				
			end if
		end if
		
		kst_tab_ptasks_rows.valid_modaccomprogr = kiuf_ptasks_rows.set_valid_modaccomprogr(kst_tab_ptasks_rows)
		k_rc = kst_stampe.ds_print.retrieve(kst_tab_ptasks_rows.id_ptasks_row)
		
		kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta
		kst_stampe.titolo = trim(k_stampa)
		kGuf_data_base.stampa_dw(kst_stampe)
		kst_stampe.titolo = trim(k_stampa)
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try



end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================


super::attiva_tasti_0()

if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.visualizzazione then
	
	//=== Nr righe ne DW lista
	if tab_1.selectedtab <> 1 then
		cb_inserisci.enabled = false
		cb_inserisci.default = false
	end if
	
end if
end subroutine

on w_ptasks.create
int iCurrent
call super::create
end on

on w_ptasks.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
	if isvalid(kiuf_ptasks) then destroy kuf_ptasks
	if isvalid(kiuf_ptasks_rows) then destroy kuf_ptasks_rows
	if isvalid(kiuf_utility) then destroy kiuf_utility
	if isvalid(kiuf_armo) then destroy kiuf_armo

end event

type dw_print_0 from w_g_tab_3`dw_print_0 within w_ptasks
integer x = 1472
integer y = 320
end type

type st_ritorna from w_g_tab_3`st_ritorna within w_ptasks
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_ptasks
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_ptasks
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_ptasks
end type

type st_stampa from w_g_tab_3`st_stampa within w_ptasks
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_ptasks
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_ptasks
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_ptasks
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_ptasks
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_ptasks
boolean enabled = false
end type

type tab_1 from w_g_tab_3`tab_1 within w_ptasks
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

event tab_1::u_constructor;call super::u_constructor;//---
//--- se personalizzi le derivate e vuoi finalizzare i TAB attivi o meno inserisci queste due righe
ki_tabpage_enabled = {true, true, true, true, true, false, false, false, false} // disabilita alcune tabpage
super::event u_constructor( )

end event

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
string text = "Progetto"
dw_task dw_task
end type

on tabpage_1.create
this.dw_task=create dw_task
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_task
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_task)
end on

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
event u_ddwc_clienti ( )
event u_ddwc_contratti_doc ( )
event u_main_disp_contratto_doc ( st_tab_contratti_doc kst_tab_contratti_doc )
event u_main_disp_clienti ( st_tab_clienti kst_tab_clienti )
event u_disp_avvertenze ( string a_msg )
event u_ddwc ( )
event u_ddwc_ptasks_types_grp ( )
integer x = 654
integer y = 36
string dataobject = "d_ptasks"
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_1::u_ddwc_clienti();//
long k_rc
datawindowchild kdwc_1


	this.getchild("rag_soc_10", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	if kdwc_1.rowcount() < 2 then
		k_rc = kdwc_1.retrieve("%")
		kdwc_1.insertrow(1)
	end if
	
end event

event dw_1::u_ddwc_contratti_doc();//
st_tab_clienti kst_tab_clienti
datawindowchild kdwc_1


	this.getchild("cntr_val", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )

	if this.rowcount( ) > 0 then
		kst_tab_clienti.codice = this.getitemnumber(1, "id_cliente")
		if isnull(kst_tab_clienti.codice) then kst_tab_clienti.codice = 0
	
		if kdwc_1.rowcount() < 2 then
			kdwc_1.retrieve(kst_tab_clienti.codice)
			kdwc_1.insertrow(1)
		end if
	else
		kdwc_1.reset()
	end if
end event

event dw_1::u_main_disp_contratto_doc(st_tab_contratti_doc kst_tab_contratti_doc);//

	if kst_tab_contratti_doc.id_contratto_doc > 0 then
		this.setitem(1, "id_contratto_doc", kst_tab_contratti_doc.id_contratto_doc)
		this.setitem(1, "cntr_expiry", kst_tab_contratti_doc.data_fine)
		this.setitem(1, "cntr_descr", kst_tab_contratti_doc.oggetto)
	else
		this.setitem(1, "id_contratto_doc",0)
	end if

end event

event dw_1::u_main_disp_clienti(st_tab_clienti kst_tab_clienti);//

	if kst_tab_clienti.codice > 0 then
		tab_1.tabpage_1.dw_1.setitem(1, "id_cliente", kst_tab_clienti.codice)
		tab_1.tabpage_1.dw_1.setitem(1, "rag_soc_10", kst_tab_clienti.rag_soc_10)
	else
		tab_1.tabpage_1.dw_1.setitem(1, "id_cliente",0)
		tab_1.tabpage_1.dw_1.setitem(1, "rag_soc_10","")
	end if


end event

event dw_1::u_disp_avvertenze(string a_msg);//
if a_msg > " " then
	if this.rowcount( ) = 0 then
		this.insertrow(0)
	end if
	this.setitem(1, "k_avvertenze", a_msg)
	this.SetItemStatus(1, "k_avvertenze", primary!, NotModified!) 
end if
end event

event dw_1::u_ddwc();//

event u_ddwc_ptasks_types_grp( )
event u_ddwc_clienti()
event u_ddwc_contratti_doc()

end event

event dw_1::u_ddwc_ptasks_types_grp();//
datawindowchild kdwc_1


	this.getchild("id_ptasks_types_grp", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	if kdwc_1.rowcount() < 2 then
		kdwc_1.retrieve()
		kdwc_1.insertrow(1)
	end if
	
end event

event dw_1::itemchanged;call super::itemchanged;//
int k_errore=0
int k_riga
st_tab_clienti kst_tab_clienti
st_tab_contratti_doc kst_tab_contratti_doc
datawindowchild kdwc_1, kdwc_2


	choose case dwo.name 
			
		case "status"
			if ki_st_open_w.flag_modalita <> kkg_flag_modalita.inserimento then
				if this.getitemstring(row, "status") = kiuf_ptasks.kki_status_aperto then
					post aggiorna_dati()	
//				if Left(k_esito, 1) = "1" then
//					k_errore = 1
//				end if
				end if			
				ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
				post u_protegge_sprotegge_dw( )
			end if
		
		case "rag_soc_10" & 
				,"id_cliente"
				
			if dwo.name = "id_cliente" then
				if isnumber(trim(data)) then
					kst_tab_clienti.codice = long(trim(data))
				end if
			else 
				kst_tab_clienti.rag_soc_10 = trim(data)
			end if
			if kst_tab_clienti.rag_soc_10 > " " or kst_tab_clienti.codice > 0 then
				this.getchild("rag_soc_10", kdwc_1)
				if kdwc_1.rowcount() < 2 then
					kdwc_1.retrieve("%")
					kdwc_1.insertrow(1)
				end if
				if dwo.name = "id_cliente" then
					k_riga=kdwc_1.find("id_cliente = "+string(kst_tab_clienti.codice)+"",&
														1, kdwc_1.rowcount())
				else
					k_riga=kdwc_1.find("rag_soc_1 like '%"+trim(kst_tab_clienti.rag_soc_10)+"%'",&
														1, kdwc_1.rowcount())
				end if
				if k_riga > 0 then
					kst_tab_clienti.codice = kdwc_1.getitemnumber(k_riga, "id_cliente")
					kst_tab_clienti.rag_soc_10 = trim(kdwc_1.getitemstring(k_riga, "rag_soc_1"))
				end if
				post event u_main_disp_clienti(kst_tab_clienti)
				//k_errore = 1
			else
				kst_tab_clienti.codice = 0
				kst_tab_clienti.rag_soc_10 = ""
				post event u_main_disp_clienti(kst_tab_clienti)
			end if
//--- rifaccio la lettura dei contratti				
			this.getchild("cntr_val", kdwc_1)  
			kdwc_1.retrieve(kst_tab_clienti.codice)
			kdwc_1.insertrow(1)
	
		case "id_ptasks_types_grp"
			if trim(data) > " " then
				this.getchild(dwo.name, kdwc_1)
				if kdwc_1.rowcount() < 2 then
					kdwc_1.retrieve("%")
					kdwc_1.insertrow(1)
				end if
				k_riga=kdwc_1.find("id_ptasks_types_grp = "+trim(data)+"", 1, kdwc_1.rowcount())
				if k_riga > 0 then
					this.post setitem(1, "ptasks_types_grp_descr", trim(kdwc_1.getitemstring(k_riga, "descr")))
					tab_1.tabpage_1.dw_task.post event u_retrieve()
				end if
				//k_errore = 1
			else
				this.post setitem(1, "ptasks_types_grp_descr", "")
			end if
			

		case "cntr_val" 
			if trim(data) > " " then
				this.getchild("cntr_val", kdwc_1)
				k_riga=kdwc_1.find("ptasks_cntr_val = '"+trim(data)+"' ", 1, kdwc_1.rowcount())
				if k_riga > 0 then
					kst_tab_contratti_doc.id_contratto_doc = kdwc_1.getitemnumber(k_riga, "id_contratto_doc")
					kst_tab_contratti_doc.data_fine = kdwc_1.getitemdate(k_riga, "data_fine")
					kst_tab_contratti_doc.oggetto = kdwc_1.getitemstring(k_riga, "oggetto")
					kst_tab_clienti.codice = kdwc_1.getitemnumber(k_riga, "id_cliente")
					kst_tab_clienti.rag_soc_10 = trim(kdwc_1.getitemstring(k_riga, "rag_soc_10"))
					post event u_main_disp_clienti(kst_tab_clienti)
				end if
				post event u_main_disp_contratto_doc(kst_tab_contratti_doc)
			else		
				kst_tab_contratti_doc.id_contratto_doc = 0
				kst_tab_contratti_doc.data_fine = kkg.data_no
				post event u_main_disp_contratto_doc(kst_tab_contratti_doc)
			end if
			//--- recupera le dsecr per codice Contratto
			this.getchild("cntr_descr", kdwc_2)
			kdwc_2.settransobject(kguo_sqlca_db_magazzino)
			kdwc_2.retrieve(trim(data))
			kdwc_2.insertrow(1)
			
			
	end choose 


	if k_errore = 1 then
		return 2
	end if

	

	


end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;//
	choose case dwo.name 
		
		case "rag_soc_10" & 
				,"id_cliente"
			event u_ddwc_clienti( )
		
		case "cntr_val"
			event u_ddwc_contratti_doc( )
			
	end choose
end event

event dw_1::clicked;call super::clicked;//
long k_long


try
	choose case dwo.name 
		
		case "kget_n_ptask"
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento &
						or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
				k_long = kiuf_ptasks.get_n_ptask_max( )
				k_long ++
				this.setitem(row, "n_ptask", k_long)
				this.setitem(row, "date_ins", kguo_g.get_datetime_current( ))
			end if
				
	end choose
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try
end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
boolean enabled = false
string text = "CS/SPEDIZIONI"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
event u_ddwc_ddt_in ( )
event u_ddwc_ddt_out ( )
event type long u_ddwc_ddt_in_get_id_meca ( )
event u_ddwc_e1so ( )
event u_ddwc ( )
event u_ddwc_invoicefirmanomeruolo ( )
event u_ddwc_invoiceid_cliente ( )
event u_ddwc_invoiceid_cliente_x_id_cliente ( integer k_id_cliente )
boolean enabled = true
string dataobject = "d_ptasks_row_cs"
boolean hsplitscroll = false
boolean livescroll = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_2::u_ddwc_ddt_in();//
long k_rc
long k_id_cliente, k_clie_3
string k_clie_3x
datawindowchild kdwc_1


k_rc = this.getchild("cs_clienteddtn", kdwc_1)
k_clie_3x = kdwc_1.describe("evaluate('k_clie_3', 1)")
//kdwc_1.describe("k_clie_3")
if isnumber(k_clie_3x) then k_clie_3 = long(k_clie_3x)
	
if tab_1.tabpage_1.dw_1.rowcount() > 0 then	
	k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")
	
	if k_id_cliente > 0 then
		if kdwc_1.rowcount() < 2 then
			if k_id_cliente <> k_clie_3 then
				kdwc_1.settransobject( kguo_sqlca_db_magazzino )
				k_rc = kdwc_1.retrieve(k_id_cliente)
				kdwc_1.insertrow(1)
			end if
		end if
	else
		kdwc_1.reset()
	end if
else
	kdwc_1.reset()
end if
end event

event dw_2::u_ddwc_ddt_out();//
long k_rc
long k_id_cliente, k_clie_3
string k_clie_3x
datawindowchild kdwc_1


this.getchild("cs_stgddtn", kdwc_1)
k_clie_3x = kdwc_1.describe("evaluate('k_clie_3', 1)")
if isnumber(k_clie_3x) then k_clie_3 = long(k_clie_3x)
	
if tab_1.tabpage_1.dw_1.rowcount() > 0 then	
	k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")
	
	if k_id_cliente > 0 then
		if kdwc_1.rowcount() < 2 then
			if k_id_cliente <> k_clie_3 then
				kdwc_1.settransobject( kguo_sqlca_db_magazzino )
				k_rc = kdwc_1.retrieve(k_id_cliente)
				kdwc_1.insertrow(1)
			end if
		end if
	else
		kdwc_1.reset()
	end if
else
	kdwc_1.reset()
end if
end event

event type long dw_2::u_ddwc_ddt_in_get_id_meca();//
long k_rc
long k_id_meca, k_row
string k_num_bolla_in
datawindowchild kdwc_1


if this.rowcount( ) > 0 then

	k_num_bolla_in = trim(this.getitemstring(1, "cs_clienteddtn"))

	if k_num_bolla_in > " " then
		k_rc = this.getchild("cs_clienteddtn", kdwc_1)
	
		if kdwc_1.rowcount( ) < 2 then
			this.event u_ddwc_ddt_in( )
		end if		
		
		if kdwc_1.rowcount( ) > 1 then
		
			k_row = kdwc_1.find("num_bolla_in = '" + k_num_bolla_in + "'", 1, kdwc_1.rowcount())
			if k_row > 0 then
				k_id_meca = kdwc_1.getitemnumber(k_row, "id_meca")
			end if
		
		end if		
		
	end if
end if

return k_id_meca
end event

event dw_2::u_ddwc_e1so();//
long k_rc, k_id_cliente
datawindowchild kdwc_1


	k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")
	this.getchild("k_e1so", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	if kdwc_1.rowcount() < 2 then
		k_rc = kdwc_1.retrieve(k_id_cliente)
		kdwc_1.insertrow(1)
	end if
	
end event

event dw_2::u_ddwc();//

event u_ddwc_ddt_in( )
event u_ddwc_ddt_out( )
event u_ddwc_e1so( )
event u_ddwc_invoicefirmanomeruolo()
event u_ddwc_invoiceid_cliente()

end event

event dw_2::u_ddwc_invoicefirmanomeruolo();//
int k_rc
datawindowchild kdwc_1


	this.getchild("cs_invoicefirmanome", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	if kdwc_1.rowcount() < 2 then
		k_rc = kdwc_1.retrieve()
		kdwc_1.insertrow(1)
	end if

	this.getchild("cs_invoicefirmaruolo", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	if kdwc_1.rowcount() < 2 then
		k_rc = kdwc_1.retrieve()
		kdwc_1.insertrow(1)
	end if
	
end event

event dw_2::u_ddwc_invoiceid_cliente();//
event u_ddwc_invoiceid_cliente_x_id_cliente(0)
	
end event

event dw_2::u_ddwc_invoiceid_cliente_x_id_cliente(integer k_id_cliente);//
int k_rc
datawindowchild kdwc_1

	
	if isnull(k_id_cliente) then k_id_cliente = 0

	//this.getchild("cs_invoice_id_cliente", kdwc_1)
	this.getchild("invoice_rag_soc_10", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	if kdwc_1.rowcount() < 2 then
		k_rc = kdwc_1.retrieve(k_id_cliente)
		kdwc_1.insertrow(1)
	end if
	
end event

event dw_2::itemchanged;call super::itemchanged;//
int k_errore=0
long k_rc, k_row
datawindowchild kdwc_1


	choose case dwo.name 
		
		case "cs_stgddtn" 
			if trim(data) > " " then
				this.getchild(dwo.name, kdwc_1)
				k_row = kdwc_1.find("num_bolla_out = "+trim(data)+"", 1, kdwc_1.rowcount())
				if k_row > 0 then
					this.post setitem(1, "cs_stgddtdata", kdwc_1.getitemdate(k_row, "data_bolla_out"))
				end if
			end if
			
		case "cs_clienteddtn" 
			if trim(data) > " " then
				this.getchild(dwo.name, kdwc_1)
				k_row = kdwc_1.find("num_bolla_in = '"+trim(data)+"' ", 1, kdwc_1.rowcount())
				if k_row > 0 then
					this.post setitem(1, "data_bolla_in", kdwc_1.getitemdate(k_row, "data_bolla_in"))
					this.post setitem(1, "id_meca", kdwc_1.getitemnumber(k_row, "id_meca"))
					kist_tab_ptasks_orig.id_meca = kdwc_1.getitemnumber(k_row, "id_meca")
				end if
			end if
			
		case "cs_custcode" 
			if trim(data) > " " then
				if len(trim(data)) <> 10 then
					messagebox(trim(describe(dwo.name + "_t.text")), "Codice lungo " + string(len(trim(data))) &
														+ " caratteri, deve essere di 10. Operazione interrotta", stopsign!)
					return 1
				end if
			end if
			
		case "k_e1so"
			this.post SetItemStatus(row, "k_e1so", Primary!, NotModified!)

		case "cs_invoicefirmanome" 
			// popola il Ruolo dalla riga del ddwc scelta
			if data > " " then	
				this.getchild("cs_invoicefirmanome", kdwc_1)
				kdwc_1.settransobject( kguo_sqlca_db_magazzino )
				if kdwc_1.rowcount() > 0 then
					k_row = kdwc_1.find("cs_invoicefirmanome = '" + trim(data) + "'", 1, kdwc_1.rowcount())
					if k_row > 0 then
						if trim(kdwc_1.getitemstring(k_row, "cs_invoicefirmaruolo")) > " " then
							this.post setitem(1, "cs_invoicefirmaruolo", trim(kdwc_1.getitemstring(k_row, "cs_invoicefirmaruolo")))
						end if
					end if
				end if
				// imposta la data firma di default = alla data invoice
				if this.getitemdate(row, "cs_invoicedata") > kkg.data_zero then
					if this.getitemdate(row, "cs_invoicefirmadata") > kkg.data_zero then
					else
						this.post setitem(row, "cs_invoicefirmadata", this.getitemdate(row, "cs_invoicedata"))
					end if
				end if	
			end if	

		case "invoice_rag_soc_10" 
			if data > " " and isnumber(data) then	
				this.post setitem(1, "cs_invoice_id_cliente", long(data))
//				this.getchild("invoice_rag_soc_10", kdwc_1)
//				kdwc_1.settransobject( kguo_sqlca_db_magazzino )
//				if kdwc_1.rowcount() > 0 then
//					k_row = kdwc_1.find("rag_soc_10 = '" + trim(data) + "'", 1, kdwc_1.rowcount())
//					if k_row > 0 then
//						if kdwc_1.getitemnumber(k_row, "id_cliente") > 0 then
//							this.post setitem(1, "cs_invoice_id_cliente", kdwc_1.getitemnumber(k_row, "id_cliente"))
//						end if
//					end if
//				end if
			else
				this.post setitem(1, "cs_invoice_id_cliente", 0)
			end if	
						

	end choose 


end event

event dw_2::clicked;call super::clicked;//
string k_e1so
long k_cs_invoicen


	choose case dwo.name 
		
		case "b_cs_e1so"
			if this.getitemnumber(row, "k_e1so") > 0 then
				k_e1so = trim(this.getitemstring(row, "cs_e1so"))
				if k_e1so > " " then
					k_e1so += ", " 
				else
					k_e1so = ""
				end if
				this.setitem(row, "cs_e1so", k_e1so + string(this.getitemnumber(row, "k_e1so"), "#"))
			end if
			
		case "b_cs_invoicen"
			k_cs_invoicen = u_get_cs_invoicen() + 1
			if k_cs_invoicen > 0 then
				this.setitem(row, "cs_invoicen", k_cs_invoicen)
			end if

	end choose
end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
string text = "ACCETTAZIONE"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
event u_ddwc_e1wo ( )
event u_ddwc_accettazione_pesolordoxlottokg ( )
event u_ddwc_accettazione_dhlbox ( )
boolean enabled = true
string dataobject = "d_ptasks_row_acc"
end type

event dw_3::u_ddwc_e1wo();//
long k_rc, k_id_cliente
datawindowchild kdwc_1


	k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")
	this.getchild("accettazione_e1wo", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	if kdwc_1.rowcount() < 2 then
		k_rc = kdwc_1.retrieve(k_id_cliente)
		kdwc_1.insertrow(1)
	end if
	
end event

event dw_3::u_ddwc_accettazione_pesolordoxlottokg();//
long k_rc, k_id
datawindowchild kdwc_1


	if this.rowcount() > 0 then
		k_id = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask")
		this.getchild("k_accettazione_pesolordoxlottokg", kdwc_1)
		kdwc_1.settransobject( kguo_sqlca_db_magazzino )
		if kdwc_1.rowcount() = 0 then
			if kdwc_1.retrieve(k_id) > 0 then
				this.setitem(1, "k_accettazione_pesolordoxlottokg", kdwc_1.getitemnumber(1, "accettazione_pesolordoxlottokg"))
			end if
		end if
	end if	
	
end event

event dw_3::u_ddwc_accettazione_dhlbox();//
long k_rc, k_id
datawindowchild kdwc_1


	if this.rowcount() > 0 then
		k_id = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask")
		this.getchild("k_accettazione_dhlbox", kdwc_1)
		kdwc_1.settransobject( kguo_sqlca_db_magazzino )
		if kdwc_1.rowcount() = 0 then
			if kdwc_1.retrieve(k_id) > 0 then
				this.setitem(1, "k_accettazione_dhlbox", kdwc_1.getitemstring(1, "accettazione_dhlbox"))
			end if
		end if
	end if	
	
end event

event dw_3::clicked;call super::clicked;//
	choose case dwo.name 
		
		case "b_accettazione_arrivodata"
			if date(this.getitemdatetime(row, "k_accettazione_arrivodata")) > kkg.data_no then
				this.setitem(row, "accettazione_arrivodata", date(this.getitemdatetime(row, "k_accettazione_arrivodata")))
			end if
		case "b_accettazione_e1wo"
			if this.getitemnumber(row, "k_accettazione_e1wo") > 0 then
				this.setitem(1, "accettazione_e1wo", this.getitemnumber(row, "k_accettazione_e1wo"))
			end if
			
	end choose
end event

event dw_3::itemchanged;call super::itemchanged;//
long k_rc, k_row
datawindowchild kdwc_1


if dwo.name = "accettazione_dhlbox" then
	
	if data > " " then	

		this.getchild("accettazione_dhlbox", kdwc_1)
		kdwc_1.settransobject( kguo_sqlca_db_magazzino )
		if kdwc_1.rowcount() > 0 then
			k_row = kdwc_1.find("accettazione_dhlbox = '" + trim(data) + "'", 1, kdwc_1.rowcount())
			if k_row > 0 then
				if trim(kdwc_1.getitemstring(k_row, "accettazione_boxdimcm")) > " " then
					this.post setitem(1, "accettazione_boxdimcm", trim(kdwc_1.getitemstring(k_row, "accettazione_boxdimcm")))
				end if
			end if
		end if
	end if	
end if
end event

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean visible = true
string text = "VALIDATION"
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
event u_ddwc_validation_attivitacod ( )
event u_ddwc_validation_proddescr ( )
event u_ddwc_retrieve ( )
boolean enabled = true
string dataobject = "d_ptasks_row_validation"
end type

event dw_4::u_ddwc_validation_attivitacod();//
long k_rc
string k_lab
datawindowchild kdwc_1


	k_lab = this.getitemstring(1, "validation_laboratorio")
	this.getchild("validation_attivitacod", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	if kdwc_1.rowcount() < 2 then
		k_rc = kdwc_1.retrieve(k_lab)
		kdwc_1.insertrow(1)
	end if
	
end event

event dw_4::u_ddwc_validation_proddescr();//
long k_rc, k_row
string k_rcx, k_find
datawindowchild kdwc_1


	k_rcx = this.getitemstring(1, "validation_proddescr")
	this.getchild("validation_proddescr", kdwc_1)
	k_find = "validation_proddescr = '" + k_rcx + "' and validation_proddescr_eng > ' '"
	k_row = kdwc_1.find(k_find, 1, kdwc_1.rowcount())
	if k_row > 0 then
		k_rcx = kdwc_1.getitemstring(k_row, "validation_proddescr_eng")
		this.setitem(1, "validation_proddescr_eng", k_rcx)
	end if
	
end event

event dw_4::u_ddwc_retrieve();//
long k_rc
datawindowchild kdwc_1


	this.event u_ddwc_validation_attivitacod()  

	this.getchild("validation_proddescr", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	if kdwc_1.rowcount() < 2 then
		k_rc = kdwc_1.retrieve()
		kdwc_1.insertrow(1)
	end if

	this.getchild("validation_proddescr_eng", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	if kdwc_1.rowcount() < 2 then
		k_rc = kdwc_1.retrieve()
		kdwc_1.insertrow(1)
	end if

	this.getchild("validation_prodlotto", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	if kdwc_1.rowcount() < 2 then
		k_rc = kdwc_1.retrieve()
		kdwc_1.insertrow(1)
	end if

	this.getchild("validation_laboratorio", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	if kdwc_1.rowcount() < 2 then
		k_rc = kdwc_1.retrieve()
		kdwc_1.insertrow(1)
	end if

	this.getchild("validation_qaa", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	if kdwc_1.rowcount() < 2 then
		k_rc = kdwc_1.retrieve()
		kdwc_1.insertrow(1)
	end if

	this.getchild("validation_modaccompqtadescr", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	if kdwc_1.rowcount() < 2 then
		k_rc = kdwc_1.retrieve()
		kdwc_1.insertrow(1)
	end if

	this.getchild("validation_offertarif", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	if kdwc_1.rowcount() < 2 then
		k_rc = kdwc_1.retrieve()
		kdwc_1.insertrow(1)
	end if

	this.getchild("validation_notereport", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	if kdwc_1.rowcount() < 2 then
		k_rc = kdwc_1.retrieve()
		kdwc_1.insertrow(1)
	end if

	this.getchild("validation_noterifpo", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	if kdwc_1.rowcount() < 2 then
		k_rc = kdwc_1.retrieve()
		kdwc_1.insertrow(1)
	end if

	this.getchild("validation_notealtre", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	if kdwc_1.rowcount() < 2 then
		k_rc = kdwc_1.retrieve()
		kdwc_1.insertrow(1)
	end if


end event

event dw_4::clicked;call super::clicked;//
long k_validation_modaccompn


	choose case dwo.name 
		
		case "b_validation_finepresuntadata"
			this.accepttext( )
			if date(this.getitemdatetime(row, "k_validation_finepresuntadata")) > kkg.data_no then
				this.post setitem(row, "validation_finepresuntadata", date(this.getitemdatetime(row, "k_validation_finepresuntadata")))
			end if
		
		case "b_validation_dose_min"
			this.accepttext( )
			if this.getitemnumber(row, "k_validation_dose_min") > 0 then
				this.post setitem(row, "validation_dose_min", this.getitemnumber(row, "k_validation_dose_min"))
			end if
		
		case "b_validation_dose_max"
			this.accepttext( )
			if this.getitemnumber(row, "k_validation_dose_max") > 0 then
				this.post setitem(row, "validation_dose_max", this.getitemnumber(row, "k_validation_dose_max"))
			end if
			
		case "b_validation_modaccompn"
			this.accepttext( )
			if this.getitemnumber(row, "validation_modaccompn") > 0 then
				post messagebox("Numero Modulo di Accompagnamento", "Azzerare per ottenere il nuovo numero", information!)
			else
				k_validation_modaccompn = u_get_valid_modaccompn() + 1
				if k_validation_modaccompn > 0 then
					this.post setitem(row, "validation_modaccompn", k_validation_modaccompn)
				end if
			end if
				
	end choose
end event

event dw_4::itemchanged;call super::itemchanged;//
choose case dwo.name

	case "validation_laboratorio" 
		this.event post u_ddwc_validation_attivitacod( )
		
	case "validation_proddescr" 
		this.event post u_ddwc_validation_proddescr( )
	
end choose


end event

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
boolean visible = true
string text = "APPROVV."
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
boolean enabled = true
string dataobject = "d_ptasks_row_approvv"
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
string text = ""
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
boolean visible = true
string text = "riepilogo"
string powertiptext = "Riepilogo generale del Progetto"
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
boolean enabled = true
string dataobject = "d_ptasks_summary"
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
boolean visible = true
string text = "Moduli"
string powertiptext = "report per i Laboratori e Invoice"
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
boolean enabled = true
string dataobject = "d_ptasks_row_modaccomp_l"
boolean hsplitscroll = false
end type

type st_duplica from w_g_tab_3`st_duplica within w_ptasks
end type

type dw_task from uo_d_std_1 within tabpage_1
event u_retrieve ( )
event u_set_add_minus_off ( )
event type long u_get_id_ptasks_type ( )
event type string u_get_task ( )
event type string u_get_type_descr ( )
event type boolean u_if_modifyed ( )
event u_ddwc_task_l ( )
event u_select_row ( integer a_row )
event u_copy_to_kids_1 ( )
integer y = 4
integer width = 1015
integer height = 900
integer taborder = 20
boolean bringtotop = true
boolean enabled = true
string dataobject = "d_ptasks_types_used_l"
boolean hscrollbar = false
boolean hsplitscroll = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
boolean ki_attiva_dragdrop = true
boolean ki_attiva_dragdrop_self = true
end type

event u_retrieve();//
st_tab_ptasks kst_tab_ptasks
long k_id_ptask
int k_rows


this.ki_flag_modalita = ki_st_open_w.flag_modalita

if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
	kst_tab_ptasks.id_ptask = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask")
	
	if this.rowcount() > 0 then
		k_id_ptask = this.getitemnumber(1, "id_ptask")
	end if
	
	if kst_tab_ptasks.id_ptask <> k_id_ptask or kst_tab_ptasks.id_ptask = 0 then
		
		kst_tab_ptasks.id_ptasks_types_grp = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptasks_types_grp")
	
		if isnull(kst_tab_ptasks.id_ptask) then kst_tab_ptasks.id_ptask = 0
		if isnull(kst_tab_ptasks.id_ptasks_types_grp) then kst_tab_ptasks.id_ptasks_types_grp = 0
		
		//this.event u_ddwc_task_l(kst_tab_ptasks.id_ptask) // popola elenco attività del ddwc
		
		k_rows = this.retrieve(kst_tab_ptasks.id_ptask, kst_tab_ptasks.id_ptasks_types_grp)
	
		if k_rows > 0 then
			if this.ki_flag_modalita = kkg_flag_modalita.inserimento &
					or this.ki_flag_modalita = kkg_flag_modalita.modifica then
			else
				event u_set_add_minus_off()
				this.setitem(k_rows, "k_add_minus", "X")
			end if
		end if

		event u_copy_to_kids_1( )
		
	end if

else
	tab_1.tabpage_1.dw_1.reset( )
end if
end event

event u_set_add_minus_off();//
int k_row, k_rows
string k_rcx


	k_rows = this.rowcount( ) 
	for k_row = 1 to k_rows
		this.setitem(k_row, "k_add_minus", "")
	next
	k_rcx=this.modify("b_add_minus.visible=0")

	k_row = this.find("k_add_minus = '+'", 1, this.rowcount())
	if k_row > 0 then
		this.deleterow(k_row)
	end if
end event

event type long u_get_id_ptasks_type();//
int k_row
long k_return 


k_row = this.getselectedrow(0)
if k_row > 0 then
	
	k_return = this.getitemnumber(k_row, "id_ptasks_type")
	
end if
if k_return > 0 then
   return k_return
else
	return 0
end if

end event

event type string u_get_task();//
int k_row
string k_return 


k_row = this.getselectedrow(0)
if k_row > 0 then
	
	k_return = trim(this.getitemstring(k_row, "task"))
	
end if
if k_return > " " then
   return k_return
else
	return ""
end if

end event

event type string u_get_type_descr();//
int k_row
string k_return 


k_row = this.getselectedrow(0)
if k_row > 0 then
	
	k_return = trim(this.getitemstring(k_row, "descr"))
	
end if
if k_return > " " then
   return k_return
else
	return ""
end if

end event

event type boolean u_if_modifyed();//
boolean k_return
int k_row, k_rows

	
if isvalid(kids_1) then
	
	if kids_1.rowcount() > 0 then
		if this.rowcount() <> kids_1.rowcount() then
			
			k_return = true
			
		else
			k_rows = this.rowcount()
			do while k_row < k_rows
				k_row ++
				if this.getitemnumber(k_row, "id_ptasks_type") <> kids_1.getitemnumber(k_row, "id_ptasks_type") then
					k_return = true
					exit
				end if
			loop
		end if
	end if
end if

	
return k_return
end event

event u_ddwc_task_l();//
//string k_rcx
int k_rc, k_row, k_rows
datawindowchild kdwc_1
st_tab_ptasks kst_tab_ptasks

	kst_tab_ptasks.id_ptask = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_ptask")

	this.getchild("descr", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	//if kdwc_1.rowcount() < 2 then
	k_rc = kdwc_1.retrieve(kst_tab_ptasks.id_ptask)
	kdwc_1.insertrow(1)
	
	//--- rimuove le righe con lo stesso ID_PTASKS_TYPE già nel dw
	k_rows = this.rowcount( )
	for k_row = 1 to k_rows
		
		if this.getitemnumber(k_row, "id_ptask") > 0 then
		else
			k_rc = kdwc_1.find("id_ptasks_type = " + string(this.getitemnumber(k_row, "id_ptasks_type")), 1, kdwc_1.rowcount())
			if k_rc > 0 then
				kdwc_1.deleterow(k_rc)
			end if
		end if		
	next
		
	//end if
	
end event

event u_select_row(integer a_row);//		
if this.rowcount( ) > 0 then
	this.selectrow(0,false)
	this.selectrow(a_row,true)
	this.setrow(a_row)
end if

end event

event u_copy_to_kids_1();//
	if not isvalid(kids_1) then
		kids_1 = create datastore
		kids_1.dataobject = this.dataobject
	end if

	kids_1.reset()
	this.rowscopy(1, this.rowcount(), primary!, kids_1, 1, primary!)

end event

event constructor;//
this.settransobject(kguo_sqlca_db_magazzino)

end event

event clicked;//
string k_add_minus, k_descr
int k_dwc_row, k_row
long k_id_ptasks_type
datawindowchild k_dwc

this.ki_in_DRAG = false

this.selectrow(0, false)

//--- toglie il focus sull'ultima riga se sono in fase di conferma e metto il +
if this.rowcount( ) <> row then
	if trim(this.getitemstring(this.rowcount(), "k_add_minus")) = "V" then
		this.setitem(this.rowcount(), "k_add_minus", "+")
	end if
end if

if row = 0 then
else

	event u_dragdrop_mouse_pos(xpos, ypos) // original coordinates of pointer x fare il drag&drop 

	k_descr = this.getitemstring(row, "descr")
//	k_id_ptasks_type = this.getitemnumber(row, "id_ptasks_type")
	
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento &
			 or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
			 
		if left(dwo.name,6) = "b_task" or dwo.name = "k_add_minus" then
//			if k_id_ptasks_type > 0 then
//			else
				k_add_minus = trim(this.getitemstring(row, "k_add_minus"))
				if k_add_minus = "+" then
					k_add_minus = "V"
					this.setitem(row, "k_add_minus", k_add_minus)
					
					this.event u_ddwc_task_l() // popola elenco attività del ddwc
					
				elseif k_add_minus = "V" then
					if trim(k_descr) > " " then
						 this.getchild("descr", k_dwc)
						 k_dwc_row = k_dwc.find("descr = ~"" + k_descr + "~"", 1 , k_dwc.rowcount())
						 if k_dwc_row > 0 then
							 this.setitem(row, "id_ptasks_type", k_dwc.getitemnumber(k_dwc_row, "id_ptasks_type"))
							 this.setitem(row, "task", k_dwc.getitemstring(k_dwc_row, "task"))
							 this.setitem(row, "k_add_minus", "-")
							 
							 k_row = this.insertrow(0)
							 this.setitem(k_row, "k_add_minus", "+")
							 this.scrolltorow(k_row)
							 this.selectrow(0, false)
							 this.selectrow(k_row, true)
						end if
					end if
				elseif k_add_minus = "-" then
					this.deleterow(row)
					post attiva_tasti( )
				end if
	//		end if
		end if
	end if
	
	this.event u_select_row(row)
	
	u_set_tab_1_enable( )
		
end if
end event

event doubleclicked;//
//--- no doppio click standard
//

end event

event rowfocuschanged;call super::rowfocuschanged;//
//--- resetta i tab se cambio l'attività scelta
long k_return 
k_return = u_dw_task_change_selected()
post u_protegge_sprotegge_dw( )

return k_return 



end event

event ue_dragdrop_end;call super::ue_dragdrop_end;//
if this.u_dati_modificati( ) then
	
	attiva_tasti()
	
end if

end event

event ue_dropfromthis;//
if this.ki_in_DRAG then
	return super::event ue_dropfromthis(k_droprow, kdw_source)
else
	return 0
end if
end event

