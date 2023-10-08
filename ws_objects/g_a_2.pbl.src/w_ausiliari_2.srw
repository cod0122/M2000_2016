$PBExportHeader$w_ausiliari_2.srw
forward
global type w_ausiliari_2 from w_ausiliari
end type
end forward

global type w_ausiliari_2 from w_ausiliari
string title = "Tabelle Ausiliarie 3"
boolean ki_toolbar_window_presente = true
end type
global w_ausiliari_2 w_ausiliari_2

type variables
//
private boolean ki_dosimetrie_join_history
end variables

forward prototypes
protected function integer cancella ()
protected function string check_dati ()
protected function string inizializza () throws uo_exception
protected subroutine inizializza_1 () throws uo_exception
protected subroutine inizializza_2 () throws uo_exception
protected subroutine pulizia_righe ()
protected subroutine riempi_id ()
private subroutine u_ptasks_types_put_descr ()
public function integer u_get_col_iniziale ()
protected function integer check_key (integer k_riga, string k_colonna, string k_key, ref datawindow k_dw)
end prototypes

protected function integer cancella ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_desc, k_record
string k_key
long k_key_1, k_key_2, k_key_3
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
boolean k_elabora=false
st_esito kst_esito
kuf_ausiliari  kuf1_ausiliari
kuf_utility kuf1_utility
st_tab_nazioni kst_tab_nazioni
st_tab_cap kst_tab_cap
st_tab_province kst_tab_province 


//=== 
choose case tab_1.selectedtab 
	case 1
		k_record = tab_1.tabpage_1.text //" CAP "
		k_riga = tab_1.tabpage_1.dw_1.getrow()	
		if k_riga > 0 then
			k_key = tab_1.tabpage_1.dw_1.getitemstring(k_riga, 1)
			k_desc = tab_1.tabpage_1.dw_1.getitemstring(k_riga, 2)
		end if
	case 2
		k_record = tab_1.tabpage_2.text //" Province "
		k_riga = tab_1.tabpage_2.dw_2.getrow()	
		if k_riga > 0 then
			k_key = tab_1.tabpage_2.dw_2.getitemstring(k_riga, 1)
			k_desc = tab_1.tabpage_2.dw_2.getitemstring(k_riga, 2)
		end if
	case 3
		k_record = tab_1.tabpage_3.text //" Nazioni "
		k_riga = tab_1.tabpage_3.dw_3.getrow()	
		if k_riga > 0 then
			k_key = tab_1.tabpage_3.dw_3.getitemstring(k_riga, 1)
			k_desc = tab_1.tabpage_3.dw_3.getitemstring(k_riga, 2)
		end if
end choose	



//=== Se righe in lista
if k_riga > 0 and (isnull(k_key) = false or isnull(k_key_1) = false) then

	u_set_dw_selezionata()
	
//--- se sono in inserimento rimuove solo la riga sul dw	
	if kidw_selezionata.ki_flag_modalita = kkg_flag_modalita.inserimento then
		
		kst_esito.esito = "0"
		k_elabora = true
		
	else
	
		if isnull(k_desc) = true or trim(k_desc) = "" then
			k_desc = "Codice" + k_record + "senza Descrizione" 
		end if
		
		kuf1_utility = create kuf_utility
		k_record = kuf1_utility.u_stringa_pulisci(k_record)
		destroy kuf1_utility
		
	//=== Richiesta di conferma della eliminazione del rek
		if messagebox("Elimina" + k_record, &
			"Sei sicuro di voler eliminare " + k_record + "~n~r" + &
			k_key + " " + trim(k_desc),  &
			question!, yesno!, 1) = 1 then
			k_elabora = true

		end if

		if k_elabora then

	//=== Creo l'oggetto che ha la funzione x cancellare la tabella
			kuf1_ausiliari = create kuf_ausiliari
			
	//=== Cancella la riga dal data windows di lista
			choose case tab_1.selectedtab 
				case 1
					kst_tab_cap.cap = k_key
					kst_esito = kuf1_ausiliari.tb_delete_cap(kst_tab_cap) 
				case 2
					kst_tab_province.sigla = k_key
					kst_esito = kuf1_ausiliari.tb_delete(kst_tab_province) 
				case 3
					kst_tab_nazioni.id_nazione = k_key
					kst_esito = kuf1_ausiliari.tb_delete_nazioni(kst_tab_nazioni) 
			end choose	
			
			if trim(kst_esito.esito) = "0" then

				kst_esito = kguo_sqlca_db_magazzino.db_commit()
				
			end if
		end if
	end if

	if k_elabora then
	
		if trim(kst_esito.esito) = "0" then
			
			choose case tab_1.selectedtab 
				case 1 
					tab_1.tabpage_1.dw_1.deleterow(k_riga)
				case 2
					tab_1.tabpage_2.dw_2.deleterow(k_riga)
				case 3
					tab_1.tabpage_3.dw_3.deleterow(k_riga)
			end choose	

		else
			k_return = 1
			k_errore = kGuf_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							trim(kst_esito.SQLErrText) ) 	
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi durante il recupero dell'errore !!", &
					"Controllare i dati. " + MidA(k_errore, 2))
			end if

			attiva_tasti()

		end if

//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
		destroy kuf1_ausiliari

	else
		messagebox("Elimina" + k_record,  "Operazione Annullata !!")
		k_return = 2
	end if


end if


choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_1.dw_1.setfocus()
		tab_1.tabpage_1.dw_1.setcolumn(1)
	case 2
		tab_1.tabpage_2.dw_2.setfocus()
		tab_1.tabpage_2.dw_2.setcolumn(1)
	case 3
		tab_1.tabpage_3.dw_3.setfocus()
		tab_1.tabpage_3.dw_3.setcolumn(1)
end choose	


return k_return

end function

protected function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
string k_return = " "
string k_errore = "0"
long k_nr_righe
int k_riga, k_riga_find
int k_nr_errori
string k_key
st_esito kst_esito
st_tab_cap kst_tab_cap
st_tab_nazioni kst_tab_nazioni


try
//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = tab_1.tabpage_1.dw_1.getnextmodified(0, primary!)

	
//=== Controllo altro tab
	k_riga = tab_1.tabpage_1.dw_1.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10

		k_key = string(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cap"))
		k_riga_find = tab_1.tabpage_1.dw_1.find("cap = '" + k_key + "' ", 1, k_nr_righe) 
		if k_riga_find > 0 and k_riga_find < k_nr_righe then
			k_riga_find++
			if tab_1.tabpage_1.dw_1.find("cap = '" + k_key + "' ", k_riga_find, k_nr_righe) > 1 then
				k_return = tab_1.tabpage_1.text + ": CAP postale gia' in archivio " + "~n~r" 
				k_return = k_return + "(CAP " + trim(k_key) + ") ~n~r"
				k_errore = "3"
				k_nr_errori++
			end if
		end if
		if k_errore = "0" or k_errore = "4" then
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
				kst_tab_cap.cap = trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "cap"))
				if kiuf_ausiliari.if_gia_esiste(kst_tab_cap) then
					k_return = tab_1.tabpage_1.text + ": CAP postale gia' in archivio " + "~n~r" 
					k_return = k_return + "(CAP " + trim(kst_tab_cap.cap) + ") ~n~r"
					k_errore = "3"
					k_nr_errori++
		
				end if
			end if
		end if

		k_riga = tab_1.tabpage_1.dw_1.getnextmodified(k_riga, primary!)

	loop
	
	
//=== Controllo altro tab
	k_riga = tab_1.tabpage_2.dw_2.getnextmodified(0, primary!)
	k_nr_righe = tab_1.tabpage_2.dw_2.rowcount()

	do while k_riga > 0  and k_nr_errori < 10


		if k_errore = "0" or k_errore = "4" then // and k_riga <= k_nr_righe then
			k_key = string(tab_1.tabpage_2.dw_2.getitemstring ( k_riga, "sigla"))
			k_riga_find = tab_1.tabpage_2.dw_2.find("sigla = '" + k_key + "' ", 1, k_nr_righe) 
			if k_riga_find > 0 and k_riga_find < k_nr_righe then
				k_riga_find++
				if tab_1.tabpage_2.dw_2.find("sigla = '" + k_key + "' ", k_riga_find, k_nr_righe) > 1 then
					k_return = tab_1.tabpage_2.text + ": Sigla gia' in archivio " + "~n~r" 
					k_return = k_return + "(Sigla " + trim(k_key) + ") ~n~r"
					k_errore = "3"
					k_nr_errori++
				end if
			end if
		end if
		if k_errore = "0" or k_errore = "4" then
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
				select sigla
					into :k_key
					from province
					where sigla = :k_key;
				if sqlca.sqlcode = 0 then
					k_return = tab_1.tabpage_5.text + ": Sigla gia' in archivio " + "~n~r" 
					k_return = k_return + "(Sigla " + trim(k_key) + ") ~n~r"
					k_errore = "3"
					k_nr_errori++
				end if
			end if
		end if

		k_riga = tab_1.tabpage_2.dw_2.getnextmodified(k_riga, primary!)

	loop

//=== Controllo altro tab
	k_riga = tab_1.tabpage_3.dw_3.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10

		k_key = string(tab_1.tabpage_3.dw_3.getitemstring ( k_riga, "id_nazione"))
		k_riga_find = tab_1.tabpage_3.dw_3.find("id_nazione = '" + k_key + "' ", 1, k_nr_righe) 
		if k_riga_find > 0 and k_riga_find < k_nr_righe then
			k_riga_find++
			if tab_1.tabpage_3.dw_3.find("id_nazione = '" + k_key + "' ", k_riga_find, k_nr_righe) > 1 then
				k_return = tab_1.tabpage_3.text + ": Nazione gia' in archivio " + "~n~r" 
				k_return = k_return + "(Codice " + trim(k_key) + ") ~n~r"
				k_errore = "3"
				k_nr_errori++
			end if
		end if
		if k_errore = "0" or k_errore = "4" then
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
				kst_tab_nazioni.id_nazione = trim(tab_1.tabpage_3.dw_3.getitemstring(k_riga, "id_nazione"))
				if kiuf_ausiliari.if_gia_esiste(kst_tab_nazioni) then
					k_return = tab_1.tabpage_3.text + ": Nazione gia' in archivio " + "~n~r" 
					k_return = k_return + "(Codice " + trim(kst_tab_nazioni.id_nazione) + ") ~n~r"
					k_errore = "3"
					k_nr_errori++
		
				end if
			end if
		end if

		k_riga = tab_1.tabpage_3.dw_3.getnextmodified(k_riga, primary!)

	loop
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	k_return = "Anomalia su DB: " + trim(kst_esito.sqlerrtext) + "~n~r" 
	k_return = k_return + "(Errore codice: " + string(kst_esito.sqlcode) + ") ~n~r"
	k_errore = "1"
	k_nr_errori++

end try


return k_errore + k_return
end function

protected function string inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
	
	u_retrieve("d_cap_l")

return "0"
	



end function

protected subroutine inizializza_1 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
	u_retrieve("d_prov_l")

	





end subroutine

protected subroutine inizializza_2 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
	
	u_retrieve("d_nazioni_l")

end subroutine

protected subroutine pulizia_righe ();//
//=== STANDARD MODIFICABILE 
//
//=== Oltre a confermare ACCEPTTEXT toglie righe da non UPDATE
//
string k_key
long k_riga, k_ctr


tab_1.tabpage_1.dw_1.accepttext()
tab_1.tabpage_2.dw_2.accepttext()
tab_1.tabpage_3.dw_3.accepttext()


k_riga = tab_1.tabpage_1.dw_1.rowcount ( )
for k_ctr = k_riga to 1 step -1

	if tab_1.tabpage_1.dw_1.getitemstatus(k_ctr, 0, primary!) = newmodified! &
					or tab_1.tabpage_1.dw_1.getitemstatus(k_ctr, 0, primary!) = new! then  
		if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_ctr, 2)) &  
		   or LenA(trim(tab_1.tabpage_1.dw_1.getitemstring(k_ctr, 2))) <= 0 then
			tab_1.tabpage_1.dw_1.deleterow(k_ctr)
		end if
	end if
next

k_riga = tab_1.tabpage_2.dw_2.rowcount ( )
for k_ctr = k_riga to 1 step -1

	if tab_1.tabpage_2.dw_2.getitemstatus(k_ctr, 0, primary!) = newmodified! &
					or tab_1.tabpage_2.dw_2.getitemstatus(k_ctr, 0, primary!) = new! then  
		if isnull(tab_1.tabpage_2.dw_2.getitemstring(k_ctr, 2)) &  
		   or LenA(trim(tab_1.tabpage_2.dw_2.getitemstring(k_ctr, 2))) <= 0 then
			tab_1.tabpage_2.dw_2.deleterow(k_ctr)
		end if
	end if
next

k_riga = tab_1.tabpage_3.dw_3.rowcount ( )
for k_ctr = k_riga to 1 step -1

	if tab_1.tabpage_3.dw_3.getitemstatus(k_ctr, 0, primary!) = newmodified! &
					or tab_1.tabpage_3.dw_3.getitemstatus(k_ctr, 0, primary!) = new! then  
		if isnull(tab_1.tabpage_3.dw_3.getitemstring(k_ctr, 2)) &  
		   or LenA(trim(tab_1.tabpage_3.dw_3.getitemstring(k_ctr, 2))) <= 0 then
			tab_1.tabpage_3.dw_3.deleterow(k_ctr)
		end if
	end if
next

end subroutine

protected subroutine riempi_id ();////
////=== 
//long k_riga
//
//choose case tab_1.selectedtab 
//
//	case 2 
//		k_riga = tab_1.tabpage_2.dw_2.getnextmodified(0, primary!)
//		do while k_riga > 0  
//			tab_1.tabpage_2.dw_2.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
//			tab_1.tabpage_2.dw_2.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
//			k_riga = tab_1.tabpage_2.dw_2.getnextmodified(k_riga, primary!)
//		loop

		
//end choose

end subroutine

private subroutine u_ptasks_types_put_descr ();
end subroutine

public function integer u_get_col_iniziale ();//
return 1

end function

protected function integer check_key (integer k_riga, string k_colonna, string k_key, ref datawindow k_dw);//
//--- Controllo se gia' era un campo presente nella retrieve
int k_return = 0
dwItemStatus k_status

   k_status = k_dw.GetItemStatus(k_riga, k_colonna, primary!) 
	
	if k_status = datamodified! or k_status = notmodified! then 
		if not isnull(k_dw.getitemnumber(k_riga, k_colonna,  Primary!, true)) then  
			k_return = 2
		end if
	end if

	if tab_1.tabpage_1.dw_1.find("#1 = " + trim(k_key), 1, k_dw.rowcount()) > 1 then
		k_return = 1
	end if

return k_return

end function

on w_ausiliari_2.create
call super::create
end on

on w_ausiliari_2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event u_open_preliminari;//
ki_tabtext_sizemax_onleft = 750//820
end event

type dw_print_0 from w_ausiliari`dw_print_0 within w_ausiliari_2
integer x = 165
integer y = 892
end type

type st_ritorna from w_ausiliari`st_ritorna within w_ausiliari_2
end type

type st_ordina_lista from w_ausiliari`st_ordina_lista within w_ausiliari_2
end type

type st_aggiorna_lista from w_ausiliari`st_aggiorna_lista within w_ausiliari_2
end type

type cb_ritorna from w_ausiliari`cb_ritorna within w_ausiliari_2
end type

type st_stampa from w_ausiliari`st_stampa within w_ausiliari_2
end type

type cb_visualizza from w_ausiliari`cb_visualizza within w_ausiliari_2
end type

type cb_modifica from w_ausiliari`cb_modifica within w_ausiliari_2
end type

type cb_aggiorna from w_ausiliari`cb_aggiorna within w_ausiliari_2
end type

type cb_cancella from w_ausiliari`cb_cancella within w_ausiliari_2
end type

type cb_inserisci from w_ausiliari`cb_inserisci within w_ausiliari_2
end type

type tab_1 from w_ausiliari`tab_1 within w_ausiliari_2
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
this.tabpage_9,&
this.tabpage_8}
end on

on tab_1.destroy
call super::destroy
end on

type tabpage_1 from w_ausiliari`tabpage_1 within tab_1
integer x = 434
integer width = 1381
string text = "CAP postale"
end type

type dw_1 from w_ausiliari`dw_1 within tabpage_1
integer y = 0
string dataobject = "d_cap_l"
boolean hsplitscroll = false
end type

event dw_1::doubleclicked;//
//--- evito evento  doppio click
//
end event

type st_1_retrieve from w_ausiliari`st_1_retrieve within tabpage_1
end type

type st_orizzontal_11 from w_ausiliari`st_orizzontal_11 within tabpage_1
end type

type dw_11 from w_ausiliari`dw_11 within tabpage_1
end type

type tabpage_2 from w_ausiliari`tabpage_2 within tab_1
integer x = 434
integer width = 1381
string text = "Province"
end type

type dw_2 from w_ausiliari`dw_2 within tabpage_2
string dataobject = "d_prov_l"
boolean hsplitscroll = false
end type

event dw_2::doubleclicked;//
//--- evito evento  doppio click
//
end event

type st_2_retrieve from w_ausiliari`st_2_retrieve within tabpage_2
end type

type st_orizzontal_12 from w_ausiliari`st_orizzontal_12 within tabpage_2
end type

type dw_12 from w_ausiliari`dw_12 within tabpage_2
end type

type tabpage_3 from w_ausiliari`tabpage_3 within tab_1
integer x = 434
integer width = 1381
string text = "Nazioni"
end type

type dw_3 from w_ausiliari`dw_3 within tabpage_3
string dataobject = "d_nazioni_l"
end type

event dw_3::doubleclicked;//
//--- evito evento  doppio click
//
end event

type st_3_retrieve from w_ausiliari`st_3_retrieve within tabpage_3
end type

type st_orizzontal_13 from w_ausiliari`st_orizzontal_13 within tabpage_3
end type

type dw_13 from w_ausiliari`dw_13 within tabpage_3
end type

type tabpage_4 from w_ausiliari`tabpage_4 within tab_1
boolean visible = false
integer x = 434
integer width = 1381
boolean enabled = false
string text = ""
end type

type dw_4 from w_ausiliari`dw_4 within tabpage_4
boolean enabled = false
string dataobject = "d_nulla"
end type

event dw_4::doubleclicked;//
//--- evito evento  doppio click
//
end event

type st_4_retrieve from w_ausiliari`st_4_retrieve within tabpage_4
end type

type st_orizzontal_14 from w_ausiliari`st_orizzontal_14 within tabpage_4
end type

type dw_14 from w_ausiliari`dw_14 within tabpage_4
end type

type tabpage_5 from w_ausiliari`tabpage_5 within tab_1
boolean visible = false
integer x = 434
integer width = 1381
boolean enabled = false
string text = ""
end type

type dw_5 from w_ausiliari`dw_5 within tabpage_5
boolean enabled = false
string dataobject = "d_nulla"
end type

event dw_5::doubleclicked;//
//--- evito evento  doppio click
//
end event

type st_5_retrieve from w_ausiliari`st_5_retrieve within tabpage_5
end type

type st_orizzontal_15 from w_ausiliari`st_orizzontal_15 within tabpage_5
end type

type dw_15 from w_ausiliari`dw_15 within tabpage_5
end type

type tabpage_6 from w_ausiliari`tabpage_6 within tab_1
boolean visible = false
integer x = 434
integer width = 1381
boolean enabled = false
string text = ""
end type

type st_6_retrieve from w_ausiliari`st_6_retrieve within tabpage_6
end type

type dw_6 from w_ausiliari`dw_6 within tabpage_6
integer x = 9
integer y = 12
boolean enabled = false
string dataobject = "d_nulla"
end type

event dw_6::doubleclicked;//
//--- evito evento  doppio click
//
end event

type st_orizzontal_16 from w_ausiliari`st_orizzontal_16 within tabpage_6
end type

type dw_16 from w_ausiliari`dw_16 within tabpage_6
end type

type tabpage_7 from w_ausiliari`tabpage_7 within tab_1
boolean visible = false
integer x = 434
integer width = 1381
boolean enabled = false
string text = ""
end type

type st_7_retrieve from w_ausiliari`st_7_retrieve within tabpage_7
end type

type dw_7 from w_ausiliari`dw_7 within tabpage_7
boolean enabled = false
string dataobject = "d_nulla"
end type

type st_orizzontal_17 from w_ausiliari`st_orizzontal_17 within tabpage_7
end type

type dw_17 from w_ausiliari`dw_17 within tabpage_7
end type

type tabpage_8 from w_ausiliari`tabpage_8 within tab_1
boolean visible = false
integer x = 434
integer width = 1381
boolean enabled = false
string text = ""
end type

type st_8_retrieve from w_ausiliari`st_8_retrieve within tabpage_8
end type

type dw_8 from w_ausiliari`dw_8 within tabpage_8
boolean enabled = false
string dataobject = "d_nulla"
end type

type st_orizzontal_18 from w_ausiliari`st_orizzontal_18 within tabpage_8
integer width = 919
end type

type dw_18 from w_ausiliari`dw_18 within tabpage_8
end type

type tabpage_9 from w_ausiliari`tabpage_9 within tab_1
boolean visible = false
integer x = 434
integer width = 1381
boolean enabled = false
string text = ""
string powertiptext = "Elenco associazioni Attività dei Progetti"
end type

type st_9_retrieve from w_ausiliari`st_9_retrieve within tabpage_9
end type

type dw_9 from w_ausiliari`dw_9 within tabpage_9
event u_set_descr ( )
integer width = 1083
boolean enabled = false
string dataobject = "d_nulla"
boolean hsplitscroll = false
borderstyle borderstyle = styleraised!
end type

event dw_9::u_set_descr();//
	this.setitem(this.getrow(), "descr", this.event ue_get_display_dddw("task"))

end event

event dw_9::itemchanged;call super::itemchanged;//

if dwo.name = "task" then
	this.post event u_set_descr( )
end if
end event

type st_orizzontal_19 from w_ausiliari`st_orizzontal_19 within tabpage_9
end type

type dw_19 from w_ausiliari`dw_19 within tabpage_9
end type

type st_duplica from w_ausiliari`st_duplica within w_ausiliari_2
end type

