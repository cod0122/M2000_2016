$PBExportHeader$w_sr_utenti.srw
forward
global type w_sr_utenti from w_g_tab_3
end type
end forward

global type w_sr_utenti from w_g_tab_3
integer width = 2277
integer height = 1568
string title = "Utenti"
long backcolor = 67108864
windowanimationstyle closeanimation = topslide!
boolean ki_toolbar_window_presente = true
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_fai_exit_dopo_update = true
boolean ki_msg_dopo_update = false
boolean ki_attiva_tasti_vmi = true
boolean ki_consenti_duplica = true
end type
global w_sr_utenti w_sr_utenti

type variables
//
//	private datastore kdsi_elenco 
	private st_tab_sr_utenti kist_tab_sr_utenti
	private constant string ki_dw_lista_utenti = "d_sr_prof_utenti_l_diverso" 
	private string ki_path_risorse = "."

	

end variables

forward prototypes
protected subroutine pulizia_righe ()
protected subroutine riempi_id ()
protected subroutine inizializza_1 ()
protected subroutine attiva_menu ()
protected function integer cancella ()
protected function string aggiorna ()
protected function string inizializza ()
public function string check_dati ()
protected subroutine inizializza_2 () throws uo_exception
protected subroutine attiva_tasti_0 ()
private function string u_get_email_compone ()
public function boolean u_duplica () throws uo_exception
protected subroutine open_start_window ()
end prototypes

protected subroutine pulizia_righe ();//
long k_riga
long k_nr_righe


tab_1.tabpage_1.dw_1.accepttext()
tab_1.tabpage_2.dw_2.accepttext()
tab_1.tabpage_3.dw_3.accepttext()
tab_1.tabpage_4.dw_4.accepttext()
tab_1.tabpage_5.dw_5.accepttext()

//
//=== Pulizia dei rek non validi sui vari TAB
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	for k_riga = k_nr_righe to 1 step -1

		if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) = newmodified! then 
			if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "nome")) &
				or LenA(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "nome"))) = 0  &
				then
		
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
				
			end if
		end if
		
	next

end subroutine

protected subroutine riempi_id ();//
string k_nome
long k_riga
kuf_utility kuf1_utility


	
	k_riga = tab_1.tabpage_1.dw_1.getrow()
	
	if k_riga > 0 then

		if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "codice")) &
		   or LenA(trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "codice"))) = 0 &
			then		
			k_nome = LeftA(trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "nome")),10)
			kuf1_utility = create kuf_utility
			k_nome = kuf1_utility.u_replace(k_nome, " ", ".")
			destroy kuf1_utility
			tab_1.tabpage_1.dw_1.setitem(k_riga, "codice", k_nome)
		end if

//		if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "email")) &
//		   or len(trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "password"))) = 0 &
//			then		
//			k_nome = left(trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "nome")), 1) &
//			         + mid(trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "nome")), 3,1) &
//			         + mid(trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "nome")), 5,1) &
//			         + mid(trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "nome")), 7,1) &
//			         + string(today(), "yy")
//			kuf1_utility = create kuf_utility
//			k_nome = kuf1_utility.u_replace(k_nome, " ", ".")
//			destroy kuf1_utility
//			tab_1.tabpage_1.dw_1.setitem(k_riga, "password", k_nome)
//		end if

		if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "stato")) &
		   or LenA(trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "stato"))) = 0 &
			then				
			tab_1.tabpage_1.dw_1.setitem(k_riga, "stato", '0')
		end if
	
//=== Se sono in inser azzero il ID  
		if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) = newmodified! then
			if isnull(tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id")) &
				then				
				tab_1.tabpage_1.dw_1.setitem(k_riga, "id", 0)
			end if
		end if
	end if

	

end subroutine

protected subroutine inizializza_1 ();//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0
long k_riga
double k_dose 
string k_codice_attuale, k_codice_prec
st_tab_sr_prof_utenti kst_tab_sr_prof_utenti
	
	

k_riga = tab_1.tabpage_1.dw_1.getrow() 
	
kst_tab_sr_prof_utenti.id_utenti = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id")

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_2.st_2_retrieve.text) then
	k_codice_prec = tab_1.tabpage_2.st_2_retrieve.text
else
	k_codice_prec = string(kst_tab_sr_prof_utenti.id_utenti)
end if

k_codice_attuale = "*"

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_2.st_2_retrieve.text = k_codice_attuale

if k_codice_attuale <> k_codice_prec or tab_1.tabpage_2.dw_2.rowcount() = 0 then

	k_rc=tab_1.tabpage_2.dw_2.retrieve(kst_tab_sr_prof_utenti.id_utenti)  

end if				
				

attiva_tasti()
if tab_1.tabpage_2.dw_2.rowcount() = 0 then
	tab_1.tabpage_2.dw_2.insertrow(0) 
end if


tab_1.tabpage_2.dw_2.setfocus()
	
	

end subroutine

protected subroutine attiva_menu ();//
	choose case tab_1.selectedtab 
		case 1
			m_main.m_finestra.m_gestione.m_fin_inserimento.text = "Nuovo Utente"
			m_main.m_finestra.m_gestione.m_fin_elimina.text = "Elimina Utente"
			m_main.m_finestra.m_gestione.m_fin_inserimento.toolbaritemtext = "Nuovo," + m_main.m_finestra.m_gestione.m_fin_inserimento.text
			m_main.m_finestra.m_gestione.m_fin_elimina.toolbaritemtext = "Elimina," + m_main.m_finestra.m_gestione.m_fin_elimina.text
		case 2 
			m_main.m_finestra.m_gestione.m_fin_inserimento.text = "Aggiunge Profilo"
			m_main.m_finestra.m_gestione.m_fin_elimina.text = "Toglie Profilo"
			m_main.m_finestra.m_gestione.m_fin_inserimento.toolbaritemtext = "Aggiunge," + m_main.m_finestra.m_gestione.m_fin_inserimento.text
			m_main.m_finestra.m_gestione.m_fin_elimina.toolbaritemtext = "Toglie," + m_main.m_finestra.m_gestione.m_fin_elimina.text
	end choose
	m_main.m_finestra.m_gestione.m_fin_inserimento.microhelp = m_main.m_finestra.m_gestione.m_fin_inserimento.text
	m_main.m_finestra.m_gestione.m_fin_elimina.microhelp = m_main.m_finestra.m_gestione.m_fin_elimina.text


	super::attiva_menu()



end subroutine

protected function integer cancella ();//
//=== Cancellazione record dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_record, k_record_1, k_key, k_testo
string k_errore = "0 " 
long k_riga
kuf_sr_sicurezza  kuf1_sr_sicurezza
st_esito kst_esito
st_tab_sr_utenti kst_tab_sr_utenti
st_tab_sr_profili kst_tab_sr_profili
st_tab_sr_prof_utenti kst_tab_sr_prof_utenti



//=== 
choose case tab_1.selectedtab 
	case 1 
		k_record = " " + trim(tab_1.tabpage_1.text) + " "
		k_riga = tab_1.tabpage_1.dw_1.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				
				kst_tab_sr_utenti.id = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id")
				kst_tab_sr_utenti.codice = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "codice")
				
				if isnull(kst_tab_sr_utenti.codice) = true or trim(kst_tab_sr_utenti.codice) = "" then
					k_testo = trim(tab_1.tabpage_2.dw_2.object.codice_t.text)
					kst_tab_sr_utenti.codice = "senza " + k_testo
				end if
				k_record_1 = &
					"Sei sicuro di voler eliminare l'Utente " + &
					"'" + trim(kst_tab_sr_utenti.codice) + "'" &
				   + " ?"
			else
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
			end if
		end if
		k_key = trim(string(kst_tab_sr_profili.id))
		
	case 2  
		k_record = " " + trim(tab_1.tabpage_2.text) + " " 
		k_riga = tab_1.tabpage_2.dw_2.getselectedrow(0)	
		if k_riga > 0 then
				
			kst_tab_sr_prof_utenti.id = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "sr_prof_utenti_id")
				
			if tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				
				kst_tab_sr_profili.nome = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "nome")
				kst_tab_sr_profili.descrizione = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "descrizione")
				
				if isnull(kst_tab_sr_profili.nome) or trim(kst_tab_sr_profili.nome) = "" then
					k_testo = trim(tab_1.tabpage_2.dw_2.object.nome_t.text)
					kst_tab_sr_profili.nome = "senza " + k_testo
				end if
				if isnull(kst_tab_sr_profili.descrizione) or trim(kst_tab_sr_profili.descrizione) = "" then
					kst_tab_sr_profili.descrizione = " "
				end if
				k_record_1 = &
					"Sei sicuro di voler rimuovere il collegmento al Profilo: " + &
					trim(kst_tab_sr_profili.nome) + " " + trim(kst_tab_sr_profili.descrizione) &
				   + " ?"
			else
				tab_1.tabpage_2.dw_2.deleterow(k_riga)
			end if
		else
			messagebox("Elimina" + k_record,  "Selezionare almeno una riga. ")
		end if
		k_key = trim(string(kst_tab_sr_prof_utenti.id))
		
//	case 4
//		k_record = " Fattura di anticipo "
//		k_riga = tab_1.tabpage_4.dw_4.getselectedrow(0)	
//		if k_riga > 0 then
//			if tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) <> new! and &
//				tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
//				k_key = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_commessa")
//				k_nro_fatt = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "id_fattura")
//				k_data = tab_1.tabpage_4.dw_4.getitemdate(k_riga, "data_fattura")
//				k_record_1 = &
//					"Sei sicuro di voler eliminare la Fattura~n~r" + &
//					trim(k_nro_fatt) + " del " + string(k_data, "dd-mm-yy") + " ?"
//			else
//				tab_1.tabpage_4.dw_4.deleterow(k_riga)
//			end if
//		end if
end choose	



//=== Se righe in lista
if k_riga > 0 and LenA(trim(k_key)) > 0 then
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina" + k_record, k_record_1, &
		question!, yesno!, 2) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_sr_sicurezza = create kuf_sr_sicurezza
		
//=== Cancella la riga dal data windows di lista
		choose case tab_1.selectedtab 
			case 1 
				kst_esito = kuf1_sr_sicurezza.tb_delete_sr_utenti(kst_tab_sr_utenti) 
			case 2
				kst_esito = kuf1_sr_sicurezza.tb_delete_sr_prof_utenti(kst_tab_sr_prof_utenti) 
		end choose	
		if kst_esito.esito = "0" then

			kguo_sqlca_db_magazzino.db_commit()
				
			choose case tab_1.selectedtab 
				case 1 
					tab_1.tabpage_1.dw_1.deleterow(k_riga)
				case 2
					tab_1.tabpage_2.dw_2.deleterow(k_riga)
			end choose	

			cb_ritorna.post event clicked( )

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
		destroy kuf1_sr_sicurezza

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
end choose	


return k_return

end function

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================
 
string k_return="0 ", k_errore="0 ", k_errore1="0 "
pointer kp_oldpointer


//=== Puntatore Cursore da attesa..... 
kp_oldpointer = SetPointer(HourGlass!)

//=== Aggiorna, se modificato, la TAB_1	
if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 OR &
	tab_1.tabpage_1.dw_1.getnextmodified(0, delete!) > 0 & 
	then

	if tab_1.tabpage_1.dw_1.update() = 1 then
		kguo_sqlca_db_magazzino.db_commit()
	else
		k_errore1 = kGuf_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + &
						tab_1.tabpage_1.text + "' ~n~r" 
		messagebox("Operazione di Aggiornamento Non Eseguita !!", mid(k_return, 2))
	end if
end if

//=== Puntatore Cursore da attesa.....
SetPointer(kp_oldpointer)


return k_return

end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta
string k_stato = "0"
string k_fine_ciclo="", k_rcx
int k_ctr=0, k_errore = 0
int k_err_ins, k_rc
kuf_utility kuf1_utility


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	if kist_tab_sr_utenti.id = 0 then
		cb_inserisci.postevent(clicked!)
		tab_1.tabpage_1.dw_1.setfocus()
	else

		k_rc = tab_1.tabpage_1.dw_1.retrieve(kist_tab_sr_utenti.id) 
		tab_1.tabpage_2.dw_2.reset( )
		tab_1.tabpage_3.dw_3.reset( )
		
		choose case k_rc

			case is < 0				
				k_errore = 1
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(Codice ricercato:" + string(kist_tab_sr_utenti.id) + ")~n~r" )
				cb_ritorna.postevent(clicked!)
				

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				if k_scelta <> kkg_flag_modalita.inserimento then
					k_errore = 1
					messagebox("Ricerca fallita", &
						"Mi spiace ma il dato non e' in Archivio ~n~r" + &
						"(Codice Cercato:" + string(kist_tab_sr_utenti.id) + ")~n~r" )

					cb_ritorna.postevent(clicked!)
					
				else
					k_err_ins = inserisci()
					tab_1.tabpage_1.dw_1.setfocus()
				end if
				
			case is > 0		
				if k_scelta =  kkg_flag_modalita.inserimento then
					cb_inserisci.postevent(clicked!)
				end if
				
				tab_1.tabpage_1.dw_1.setrow(1)
				tab_1.tabpage_1.dw_1.setfocus()
				tab_1.tabpage_1.dw_1.setcolumn("nome")
				
				attiva_tasti()
		
		end choose

	end if

//	kdwc_dw1.retrieve()

else
	attiva_tasti()
end if


//===
//--- inabilito le modifiche sulla dw
if k_errore = 0 then

//--- Inabilita campi alla modifica se Vsualizzazione
	kuf1_utility = create kuf_utility 
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione &
	   or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.cancellazione then
		
		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)
		tab_1.tabpage_1.dw_1.object.b_email_compone.enabled = "0"

	else		
		
//--- S-protezione campi per riabilitare la modifica 
      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)
		tab_1.tabpage_1.dw_1.object.b_email_compone.enabled = "1"

	end if
	destroy kuf1_utility
	
//--- se cancellazione
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then
		
		cb_cancella.postevent (clicked!)
		
	end if
end if



return "0"


end function

public function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_return = ""
string k_errore = "0"
long k_nr_righe
int k_riga
int k_nr_errori
string k_key_str
string k_stato, k_tipo
string k_key, k_testo
kuf_email kuf1_email
st_email_address kst_email_address
st_esito kst_esito


//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = 1

	k_key = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "nome") 
	if isnull(k_key) or LenA(trim(k_key)) = 0 then
		k_testo = trim(tab_1.tabpage_1.dw_1.object.nome_t.text)
		k_return = tab_1.tabpage_1.text + ": Manca valore nel campo '" + k_testo + "'. " + "~n~r"
		k_errore = "3"
		k_nr_errori++
	end if
//	if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_programma")) = true then
//		k_testo = trim(tab_1.tabpage_1.dw_1.object.id_programma_t.text)
//		k_return = k_return + tab_1.tabpage_1.text + ": Manca valore nel campo '" + k_testo + "'. " + "~n~r" 
//		k_errore = "3"
//		k_nr_errori++
//	end if
//--- Controllo sintassi Indirizzi email				
	try
		kuf1_email = create kuf_email 
		kst_email_address.email_all = tab_1.tabpage_1.dw_1.getitemstring( k_riga, "email")
		if trim(kst_email_address.email_all) > " " then
			if kuf1_email.get_email_from_string(kst_email_address) > 0 then
				tab_1.tabpage_1.dw_1.setitem(k_riga, "email", kst_email_address.email_all)
			end if
		end if
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		k_return = trim(k_return) +  tab_1.tabpage_1.text + ": riscontrato indirizzo 'e-mail' non corretto, prego controllare" &
		+"~n~r" + kst_esito.sqlerrtext + "~n~r" 
		k_errore = "4"
		k_nr_errori++
	finally
		if isvalid(kuf1_email) then destroy kuf1_email
	end try


//
////=== Controllo altro tab
//	k_nr_righe = tab_1.tabpage_2.dw_2.rowcount()
//	k_riga = tab_1.tabpage_2.dw_2.getnextmodified(0, primary!)
//
//	do while k_riga > 0  and k_nr_errori < 10
//
//		k_key = tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "sequenza") 
//
//		if isnull(k_key) then
//			tab_1.tabpage_2.dw_2.setitem ( k_riga, "sequenza", 0) 
//			k_key = 0
//		end if
//
//		if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
//			if isnull(tab_1.tabpage_2.dw_2.getitemdate ( k_riga, "data_prev")) = true then
//				k_return = "Data " + tab_1.tabpage_2.text + " alla riga " + &
//				string(k_riga, "#####") + " non impostata~n~r" 
//				k_errore = "4"
//				k_nr_errori++
//			end if
//
//			if k_errore = "0" and k_riga < k_nr_righe and k_key > 0 then
//				k_tipo = tab_1.tabpage_2.dw_2.getitemstring ( k_riga, "tipo") 
//				if tab_1.tabpage_2.dw_2.find("sequenza = " +  &
//							string(k_key, "#####") + " and tipo='" + k_tipo + "'", &
//							(k_riga+1), k_nr_righe) > 0 then
//					k_return = "La stessa sequenza " + tab_1.tabpage_2.text + " ripetuta piu' volte~n~r" 
//					k_return = k_return + "(Codice " + string(k_key) + ") ~n~r"
//					k_errore = "4"
//					k_nr_errori++
//				end if
//			end if
//		end if
//		k_riga++
//
//		k_riga = tab_1.tabpage_2.dw_2.getnextmodified(k_riga, primary!)
//
//	loop
//
////=== Controllo altro tab
//	k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
//	k_riga = tab_1.tabpage_4.dw_4.getnextmodified(0, primary!)
//
//	do while k_riga > 0  and k_nr_errori < 10
//
//		k_key_str = tab_1.tabpage_4.dw_4.getitemstring ( k_riga, "id_fattura") 
//
//
//		if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
//
//			if isnull(tab_1.tabpage_4.dw_4.getitemdate ( k_riga, "data_fattura")) = true then
//				k_return = "Manca la Data " + tab_1.tabpage_4.text + " alla riga " + &
//				string(k_riga, "#####") + " ~n~r" 
//				k_errore = "3"
//				k_nr_errori++
//			end if
//
//			if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
//				if isnull(tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "importo")) = true or & 
//					tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "importo") = 0 then
//					k_return = "Manca l'Importo " + tab_1.tabpage_4.text + " alla riga " + &
//					string(k_riga, "#####") + " ~n~r" 
//					k_errore = "4"
//					k_nr_errori++
//				end if
//			end if
//
//		end if
//		k_riga++
//
//		k_riga = tab_1.tabpage_4.dw_4.getnextmodified(k_riga, primary!)
//
//	loop
//
//
//
return k_errore + k_return


end function

protected subroutine inizializza_2 () throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0
long k_riga
double k_dose 
string k_codice_attuale, k_codice_prec
st_tab_sr_prof_utenti kst_tab_sr_prof_utenti
	
	

k_riga = tab_1.tabpage_1.dw_1.getrow() 
	
kst_tab_sr_prof_utenti.id_utenti = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id")

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_3.st_3_retrieve.text) then
	k_codice_prec = tab_1.tabpage_3.st_3_retrieve.text
else
	k_codice_prec = "" 
end if

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_3.st_3_retrieve.text = k_codice_attuale

if k_codice_attuale <> k_codice_prec or tab_1.tabpage_3.dw_3.rowcount() = 0 then

	k_rc=tab_1.tabpage_3.dw_3.retrieve(0, kst_tab_sr_prof_utenti.id_utenti)  

end if				
				

attiva_tasti()
if tab_1.tabpage_3.dw_3.rowcount() = 0 then
	tab_1.tabpage_3.dw_3.insertrow(0) 
end if


tab_1.tabpage_3.dw_3.setfocus()
	
	

end subroutine

protected subroutine attiva_tasti_0 ();//
	super::attiva_tasti_0()

	cb_modifica.enabled = false
	cb_visualizza.enabled = false
	cb_inserisci.enabled = true
	cb_cancella.enabled = true

	tab_1.tabpage_2.enabled = false
	if tab_1.tabpage_1.dw_1.getrow() > 0 then
		if tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id") > 0 then
			tab_1.tabpage_2.enabled = true 
		end if
	end if

	if tab_1.selectedtab <> 1 then
		cb_aggiorna.enabled = false
	end if
	

end subroutine

private function string u_get_email_compone ();//
string k_domain, k_nome, k_cognome, k_email
int k_pos
kuf_utility kuf1_utility


try
	kuf1_utility = create kuf_utility
	k_domain = kuf1_utility.u_get_email_domain( )
	
//---estrae il nome pfortini + ....dominio da 'pietro fortini'
	k_nome = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "nome"))
	k_pos = pos(k_nome, " ", 1)
	if k_pos > 0 then
		k_cognome = trim(mid(k_nome, k_pos + 1))
	end if
	k_email = left(k_nome, 1) + k_cognome + k_domain

finally
	if isvalid(kuf1_utility) then destroy kuf1_utility
	
end try

return k_email
end function

public function boolean u_duplica () throws uo_exception;//
boolean k_return
st_tab_sr_utenti kst_tab_sr_utenti
kuf_sr_sicurezza kuf1_sr_sicurezza


try
	//=== Richiesta di conferma operazione
	if messagebox("Duplica Utente", "Genera il nuovo Utente copiando i collegamenti ai Profili da questo '" &
				+ trim(tab_1.tabpage_1.dw_1.getitemstring(1, "codice")) + "'",  &
				question!, yesno!, 2) = 1 then
				
		kuf1_sr_sicurezza = create kuf_sr_sicurezza
		
		kst_tab_sr_utenti.id = tab_1.tabpage_1.dw_1.getitemnumber(1, "id")
		kst_tab_sr_utenti.id = kuf1_sr_sicurezza.tb_duplica(kst_tab_sr_utenti)
		if kst_tab_sr_utenti.id > 0 then
			k_return = true
			kist_tab_sr_utenti.id = kst_tab_sr_utenti.id
			tab_1.tabpage_1.dw_1.reset()
			inizializza( )
		end if

	end if	
	
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

	
finally
	if isvalid(kuf1_sr_sicurezza) then destroy kuf1_sr_sicurezza
	
end try

return k_return
end function

protected subroutine open_start_window ();//
if isnumber(trim(ki_st_open_w.key1)) then
	kist_tab_sr_utenti.id = long(trim(ki_st_open_w.key1))
else
	kist_tab_sr_utenti.id = 0
end if

end subroutine

on w_sr_utenti.create
call super::create
end on

on w_sr_utenti.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
//
int k_return
int k_rc
st_esito kst_esito
st_tab_sr_prof_utenti kst_tab_sr_prof_utenti 
kuf_sr_sicurezza kuf1_sr_sicurezza



//st_open_w kst_open_w

//kst_open_w = Message.PowerObjectParm	

if isvalid(kst_open_w) then

//--- Dalla finestra di Elenco Valori
	if kst_open_w.id_programma = "elenco" then
	
		if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore
	
//--- Se dalla w di elenco doppio-click		
 		if kst_open_w.key2 = ki_dw_lista_utenti and long(kst_open_w.key3) > 0 then
			k_return = 1
		
			kdsi_elenco_input = kst_open_w.key12_any 
		
			if kdsi_elenco_input.rowcount() > 0 then
				
				kst_tab_sr_prof_utenti.id_utenti = &
			      tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id")
				kst_tab_sr_prof_utenti.id_profili  = &
  		      	kdsi_elenco_input.getitemnumber(long(kst_open_w.key3), "id")

				if kst_tab_sr_prof_utenti.id_utenti > 0 then
					
					kuf1_sr_sicurezza = create kuf_sr_sicurezza
					kst_esito = kuf1_sr_sicurezza.tb_insert_sr_prof_utenti (kst_tab_sr_prof_utenti)
					destroy kuf1_sr_sicurezza
					
//--- torna a rileggere la lista					
					inizializza_lista()
					
					if kst_esito.esito <> "0" then
						messagebox("Operazione non riuscita", "Errore: " + trim(kst_esito.sqlerrtext), StopSign!)   
					end if
					
				end if
							
			end if
		end if

	end if

end if

return k_return

end event

event open;call super::open;////
//st_profilestring_ini kst_profilestring_ini
//
//
//
////--- path per reperire il BMP
//	kst_profilestring_ini.operazione = "1"
//	kst_profilestring_ini.valore = "\"
//	kst_profilestring_ini.titolo = "risorse_grafiche" 
//	kst_profilestring_ini.nome = "arch_graf"
//	kGuf_data_base.profilestring_ini(kst_profilestring_ini)
//	if kst_profilestring_ini.esito = "0" then
//		
//		ki_path_risorse = trim(kst_profilestring_ini.valore) 
//	else
//		ki_path_risorse = "."
//	end if
//
//	ki_fai_nuovo_dopo_update = false
end event

type dw_print_0 from w_g_tab_3`dw_print_0 within w_sr_utenti
end type

type st_ritorna from w_g_tab_3`st_ritorna within w_sr_utenti
integer x = 101
integer y = 1148
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_sr_utenti
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_sr_utenti
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_sr_utenti
end type

type st_stampa from w_g_tab_3`st_stampa within w_sr_utenti
integer x = 507
integer y = 1152
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_sr_utenti
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_sr_utenti
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_sr_utenti
end type

event cb_aggiorna::clicked;//
boolean k_inserisci

	k_inserisci = cb_inserisci.enabled
	
	cb_inserisci.enabled = false
	Super::EVENT Clicked()	 
	
	cb_inserisci.enabled = k_inserisci

end event

type cb_cancella from w_g_tab_3`cb_cancella within w_sr_utenti
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_sr_utenti
end type

event cb_inserisci::clicked;//
int k_rc
string k_id_programma="", k_key
long k_riga=0
window k_window
st_open_w k_st_open_w
st_open_w kst_open_w
kuf_base kuf1_base
kuf_menu_window kuf1_menu_window
st_tab_sr_prof_utenti kst_tab_sr_prof_utenti
st_tab_sr_utenti kst_tab_sr_utenti

choose case tab_1.selectedtab 

	case 2 
//--- ricavo l'utente
		k_riga = tab_1.tabpage_1.dw_1.getrow()
		kst_tab_sr_prof_utenti.id_utenti = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id")
		kst_tab_sr_utenti.codice = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "codice")
		kst_tab_sr_utenti.nome = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "nome")
	
//--- popolo il datasore (dw non visuale) per appoggio elenco
		if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore

		kdsi_elenco_output.dataobject = ki_dw_lista_utenti 
		k_rc = kdsi_elenco_output.settransobject ( sqlca )
		k_rc = kdsi_elenco_output.retrieve(kst_tab_sr_prof_utenti.id_utenti)

		if isnull(kst_tab_sr_utenti.codice) then
			kst_tab_sr_utenti.codice = " "
		end if
		if isnull(kst_tab_sr_utenti.nome) then
			kst_tab_sr_utenti.nome = " "
		end if
		
		kst_open_w.key1 = "Elenco Profili disponibili per l'Utente " &
		                 + trim(kst_tab_sr_utenti.codice) + " " &
							  + trim(kst_tab_sr_utenti.nome) 

	
		if kdsi_elenco_output.rowcount() > 0 then
	
			k_window = kGuf_data_base.prendi_win_attiva()
			
//--- chiamare la window di elenco
//
//=== Parametri : 
//=== struttura st_open_w
			kst_open_w.id_programma = "elenco"
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = k_window.title    //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key12_any = kdsi_elenco_output
			kst_open_w.flag_where = " "
			kuf1_menu_window = create kuf_menu_window 
			kuf1_menu_window.open_w_tabelle(kst_open_w)
			destroy kuf1_menu_window
	
		else
			
			messagebox("Elenco Dati", &
						"Nessun valore disponibile. ")
			
			
		end if
				
	case else
		Super::EVENT Clicked()
		
end choose	

attiva_tasti()


end event

type tab_1 from w_g_tab_3`tab_1 within w_sr_utenti
integer width = 1545
long backcolor = 32172778
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

event tab_1::u_constructor;call super::u_constructor;//
							// 1     2     3     4     5     6      7      8      9   
ki_tabpage_enabled = {true, true, true, false, false, false, false, false, false} // disabilita alcune tabpage
super::event u_constructor( )
 
end event

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 1509
long backcolor = 32172778
string text = "Utenti"
long tabbackcolor = 67108864
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
boolean visible = true
integer width = 1202
string dataobject = "d_sr_utenti"
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_1::buttonclicked;call super::buttonclicked;//
//=== Premuto pulsante nella DW
//
int k_rc
long k_id
string k_email
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window


if dwo.name = "b_password" then
	
	k_id = this.getitemnumber(row, "id")
	
	if k_id > 0 then	
		
//--- chiamare la window di elenco
//
//=== Parametri : 
//=== struttura st_open_w
		kst_open_w.id_programma = kkg_id_programma.sr_change_pwd_u
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = ki_st_open_w.flag_modalita
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key1 = string(k_id)
		kst_open_w.key2 = " "
		kst_open_w.key3 = " "
		kst_open_w.key4 = " " 
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window

	else
		
		messagebox("Gestione Password Utente", &
					"Utente senza Identificativo; prima occorre registrarlo in archivio. ")
		
		
	end if
else 
	
	if dwo.name = "b_email_compone" then
		
		k_email = u_get_email_compone()
		if k_email > " " then
			this.setitem( row, "email", k_email)
			attiva_tasti( )
		end if
		
	end if
	
end if

//
end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 1509
long backcolor = 32172778
string text = "Profili"
long tabbackcolor = 67108864
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer x = 9
integer y = 28
boolean enabled = true
string dataobject = "d_sr_prof_utenti_l"
pointer kipointer_orig = nopointer!
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer width = 1509
boolean enabled = true
long backcolor = 32172778
string text = "Funzioni"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean visible = true
boolean enabled = true
string dataobject = "d_sr_funz_utenti_l"
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 1509
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 1509
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 1509
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 1509
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 1509
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 1509
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type st_duplica from w_g_tab_3`st_duplica within w_sr_utenti
end type

