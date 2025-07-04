﻿$PBExportHeader$w_contatti.srw
forward
global type w_contatti from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_contatti from w_g_tab_3
integer x = 169
integer y = 148
integer width = 3127
integer height = 1728
string title = "Piano di Trattamento SL-PT"
boolean ki_fai_nuovo_dopo_update = false
end type
global w_contatti w_contatti

type variables
//
kuf_clienti kiuf_clienti
st_tab_clienti kist_tab_clienti

end variables
forward prototypes
private function integer inserisci ()
protected function integer cancella ()
private subroutine leggi_altre_tab ()
protected subroutine inizializza_1 ()
protected function string aggiorna ()
protected function string inizializza ()
protected function string check_dati ()
private function boolean check_rek (string k_codice)
end prototypes

private function integer inserisci ();//
int k_return=1, k_ctr




//=== Aggiunge una riga al data windows
	choose case tab_1.selectedtab 
	
		case  1 
	
			if tab_1.tabpage_1.dw_1.rowcount() > 0 then
				tab_1.tabpage_1.dw_1.reset() 
			end if
			k_ctr=tab_1.tabpage_1.dw_1.insertrow(0)
			tab_1.tabpage_1.dw_1.setitem(k_ctr, "codice", 0)
			
			tab_1.tabpage_1.dw_1.SetItemStatus( 1, 0, Primary!, NotModified!)

			ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento
			
			
		case 2 // dati listino
//			k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")
			
			
	end choose	

	attiva_tasti()

	k_return = 0


return (k_return)



end function

protected function integer cancella ();
////
////=== Cancellazione rekord dal DB
////=== Ritorna : 0=OK 1=KO 2=non eseguita
////
int k_return=0
string k_desc, k_record, k_record_1
long k_key = 0, k_clie_1=0, k_clie_2
string k_errore = "0 ", k_errore1 = "0 ", k_nro_fatt
long k_riga, k_seq
date k_data
st_tab_clienti_m_r_f kst_tab_clienti_m_r_f


//=== 
choose case tab_1.selectedtab 
	case 1 
		k_record = " Contatto "
		k_riga = tab_1.tabpage_1.dw_1.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "codice")
				k_desc = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "rag_soc_10")
				if isnull(k_desc) = true or trim(k_desc) = "" then
					k_desc = "senza ragione sociale" 
				end if
				k_record_1 = &
					"Sei sicuro di voler eliminare l'intera Anagrafica~n~r" + &
					string(k_key, "#####") +  &
					"~n~r" + trim(k_desc) + " ?"
			else
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
			end if
		end if
	case 4
		k_record = " Associazione Anagrafiche "
		k_riga = tab_1.tabpage_4.dw_4.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "m_r_f_clie_3")
				k_clie_1 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "clie_1")
				k_clie_2 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "clie_2")
				k_record_1 = &
					"Sei sicuro di voler eliminare il legame con il~n~r" &
					+ "Mandante " + trim(string(k_clie_1)) + "  e  il Ricevente " &
					+ trim(string(k_clie_2)) + " ?"
			else
				tab_1.tabpage_4.dw_4.deleterow(k_riga)
			end if
		end if
end choose	



//=== Se righe in lista
if k_riga > 0 and k_key > 0 then
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina" + k_record, k_record_1, &
		question!, yesno!, 2) = 1 then
 
//=== Cancella la riga dal data windows di lista
		choose case tab_1.selectedtab 
			case 1 
				k_errore = kiuf_clienti.tb_delete(k_key) 
			case 4
				kst_tab_clienti_m_r_f.clie_1 = k_clie_1
				kst_tab_clienti_m_r_f.clie_2 = k_clie_2
				kst_tab_clienti_m_r_f.clie_3 = k_key
				k_errore = kiuf_clienti.tb_delete_m_r_f(kst_tab_clienti_m_r_f) 
		end choose	
		if left(k_errore, 1) = "0" then

			k_errore = kuf1_data_base.db_commit()
			if left(k_errore, 1) <> "0" then
				k_return = 1
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + mid(k_errore, 2))

			else
				
				choose case tab_1.selectedtab 
					case 1 
						tab_1.tabpage_1.dw_1.deleterow(k_riga)
					case 4 
						tab_1.tabpage_4.dw_4.deleterow(k_riga)
				end choose	

			end if

		else
			k_return = 1
			k_errore1 = k_errore
			k_errore = kuf1_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							mid(k_errore1, 2) ) 	
			if left(k_errore, 1) <> "0" then
				messagebox("Problemi durante il recupero dell'errore !!", &
					"Controllare i dati. " + mid(k_errore, 2))
			end if

			attiva_tasti()

		end if


	else
		messagebox("Elimina" + k_record,  "Operazione Annullata !!")
		k_return = 2
	end if


end if


choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_1.dw_1.setfocus()
		tab_1.tabpage_1.dw_1.setcolumn(1)
		tab_1.tabpage_1.dw_1.ResetUpdate ( ) 
	case 4
		tab_1.tabpage_4.dw_4.setfocus()
		tab_1.tabpage_4.dw_4.setcolumn(1)
		tab_1.tabpage_4.dw_4.ResetUpdate ( ) 
end choose	


return k_return

end function

private subroutine leggi_altre_tab ();
end subroutine

protected subroutine inizializza_1 ();//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_codice
string k_scelta


//=== 
//tab_1.tabpage_4.dw_41.settransobject(sqlca)



	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt")  
		k_scelta = trim(ki_st_open_w.flag_modalita)

////=== Se cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
//	if k_codice = 0 then
//		inserisci()
//		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
//	end if

//=== Se tab_2 non ha righe INSERISCI_TAB_2 altrimenti controllo che righe sono
//=== Se le righe presenti non c'entrano con il cliente allora resetto		
		if tab_1.tabpage_2.dw_2.rowcount() > 0 then
			if tab_1.tabpage_2.dw_2.getitemstring(1, "sl_pt") <> k_codice then 
				tab_1.tabpage_2.dw_2.reset()
			end if
		end if
	
		if tab_1.tabpage_2.dw_2.rowcount() < 1 then
	
//if tab_1.tabpage_2.dw_2.rowcount() = 0 then
	

//	k_key = long(mid(st_parametri.text, 3, 10))



//=== Retrive 
			if tab_1.tabpage_2.dw_2.retrieve(0, "*", k_codice) <= 0 then

//			inserisci()
			else
				attiva_tasti()
			end if				
		else
			attiva_tasti()
		end if
	
		tab_1.tabpage_2.dw_2.setfocus()
		
	end if
	



end subroutine

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="0 ", k_errore="0 ", k_errore1="0 "

//=== Aggiorna, se modificato, la TAB_1	
if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 OR &
	tab_1.tabpage_1.dw_1.getnextmodified(0, delete!) > 0 & 
	then

	if tab_1.tabpage_1.dw_1.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		k_errore1 = kuf1_data_base.db_commit()
		if LeftA(k_errore1, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_1.text + MidA(k_errore1, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
		end if
	else
		k_errore1 = kuf1_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + &
					tab_1.tabpage_1.text + "' ~n~r" 
	end if
end if

////=== Aggiorna, se modificato, la TAB_2
//if tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 or & 
//	tab_1.tabpage_2.dw_2.getnextmodified(0, delete!) > 0 & 
//	then
//
//	if tab_1.tabpage_2.dw_2.update() = 1 then
//
////=== Se tutto OK faccio la COMMIT		
//		k_errore1 = kuf1_data_base.db_commit()
//		if left(k_errore1, 1) <> "0" then
//			k_return = "3" + "Archivio " + tab_1.tabpage_2.text + mid(k_errore1, 2)
//		else // Tutti i Dati Caricati in Archivio
//			k_return ="0 "
//		end if
//	else
//		k_errore1 = kuf1_data_base.db_rollback()
//		k_return="1Fallito aggiornamento archivio '" + &
//					tab_1.tabpage_2.text + "' ~n~r" 
//	end if	
//end if
//
////=== Aggiorna, se modificato, la TAB_3
//if tab_1.tabpage_3.dw_3.getnextmodified(0, primary!) > 0 or & 
//	tab_1.tabpage_3.dw_3.getnextmodified(0, delete!) > 0 & 
//	then
//
//	if tab_1.tabpage_3.dw_3.update() = 1 then
//
////=== Se tutto OK faccio la COMMIT		
//		k_errore1 = kuf1_data_base.db_commit()
//		if left(k_errore1, 1) <> "0" then
//			k_return = "3" + "Archivio " + tab_1.tabpage_3.text + mid(k_errore1, 2)
//		else // Tutti i Dati Caricati in Archivio
//			k_return ="0 "
//		end if
//	else
//		k_errore1 = kuf1_data_base.db_rollback()
//		k_return="1Fallito aggiornamento archivio '" + &
//					tab_1.tabpage_3.text + "' ~n~r" 
//	end if	
//end if

////=== Aggiorna, se modificato, la TAB_4
//if tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0 or &
//	tab_1.tabpage_4.dw_4.getnextmodified(0, delete!) > 0 & 
//	then
//
//	if tab_1.tabpage_4.dw_4.update() = 1 then
//
////=== Se tutto OK faccio la COMMIT		
//		k_errore1 = kuf1_data_base.db_commit()
//		if left(k_errore1, 1) <> "0" then
//			k_return = "3" + "Archivio Movimenti " + mid(k_errore1, 2)
//		else // Tutti i Dati Caricati in Archivio
//			k_return ="0 "
//		end if
//	else
//		k_errore1 = kuf1_data_base.db_rollback()
//		k_return="1Fallito aggiornamento archivio 'Movimenti'" + &
//					 "' ~n~r" 
//	end if	
//end if
//
////=== Aggiorna, se modificato, la TAB_4 dw_41
//if tab_1.tabpage_4.dw_41.getnextmodified(0, primary!) > 0 or &
//	tab_1.tabpage_4.dw_41.getnextmodified(0, delete!) > 0 & 
//	then
//
//	if tab_1.tabpage_4.dw_41.update() = 1 then
//
////=== Se tutto OK faccio la COMMIT		
//		k_errore1 = kuf1_data_base.db_commit()
//		if left(k_errore1, 1) <> "0" then
//			k_return = "3" + "Archivio Note Commessa " + mid(k_errore1, 2)
//		else // Tutti i Dati Caricati in Archivio
//			k_return ="0 "
//		end if
//	else
//		k_errore1 = kuf1_data_base.db_rollback()
//		k_return="1Fallito aggiornamento archivio 'Note Commessa'" + &
//					" ~n~r" 
//	end if	
//end if


//=== errore : 0=tutto OK o NON RICHIESTA; 1=errore grave I-O;
//=== 		 : 2=LIBERO
//===			 : 3=Commit fallita

if LeftA(k_return, 1) = "1" then
	messagebox("Operazione di Aggiornamento Non Eseguita !!", &
		MidA(k_return, 2))
else
	if LeftA(k_return, 1) = "3" then
		messagebox("Registrazione dati : problemi nella 'Commit' !!", &
			"Consiglio : chiudere e ripetere le operazioni eseguite")
	end if
end if


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
string  k_key
string k_fine_ciclo=""
int k_ctr=0
int k_err_ins, k_rc
kuf_utility kuf1_utility

//=== 
//tab_1.tabpage_4.dw_41.settransobject(sqlca)


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	k_key = trim(ki_st_open_w.key1)

	if LenA(k_key) = 0 then
		
		k_err_ins = inserisci()
		tab_1.tabpage_1.dw_1.setfocus()
	else

		if isnumber(k_key) then
			kist_tab_clienti.codice = long(k_key)
		end if
		k_rc = tab_1.tabpage_1.dw_1.retrieve(kist_tab_clienti.codice) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(Codice cercato:" + trim(k_key) + ")~n~r" )
				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()

				if k_scelta =kkg_flag_modalita_modifica then
					messagebox("Ricerca fallita", &
						"Anagrafica non trovata in Archivio ~n~r" + &
						"(Codice cercato:" + trim(k_key) + ")~n~r" )

					cb_ritorna.triggerevent("clicked!")
					
				else
					k_err_ins = inserisci()
					tab_1.tabpage_1.dw_1.setfocus()
				end if
				
			case is > 0		
				if k_scelta = kkg_flag_modalita_inserimento then
					messagebox("Anagrafe Trovata ", &
						"Anagrafica gia' in archivio ~n~r" + &
						"(Codice cercato :" + trim(k_key) + ")~n~r" )
			
		         	ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica

				end if

				tab_1.tabpage_1.dw_1.setcolumn(1)
				tab_1.tabpage_1.dw_1.setfocus()
				
	
		end choose

	end if

else
	attiva_tasti()
end if



//--- Inabilita campi alla modifica se Vsualizzazione
	kuf1_utility = create kuf_utility 
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_visualizzazione then
	
		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
		kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
		if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_modifica then
			kuf1_utility.u_proteggi_dw("1", 1, tab_1.tabpage_1.dw_1)
		end if

	end if
	destroy kuf1_utility
	

return "0"

end function

protected function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK ma errore non grave
//===                : 5=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_return = " "
string k_errore = "0"
long k_nr_righe
int k_riga, k_ctr
int k_nr_errori, k_anno
string k_key_str
string k_stato, k_tipo
long k_key
st_esito kst_esito
st_tab_clienti kst_tab_clienti
st_tab_cap kst_tab_cap
st_tab_nazioni kst_tab_nazioni
st_tab_clienti_web kst_tab_clienti_web
st_tab_clienti_mkt kst_tab_clienti_mkt
st_web kst_web 
kuf_base kuf1_base
kuf_ausiliari kuf1_ausiliari
kuf_web kuf1_web


kuf1_ausiliari = create kuf_ausiliari


//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = tab_1.tabpage_1.dw_1.getrow()
	k_ctr = tab_1.tabpage_2.dw_2.getrow()

	k_key = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "codice") 

	if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "rag_soc_10")) = true then
		k_return = tab_1.tabpage_1.text + ": Manca la Ragione sociale " + "~n~r" 
		k_errore = "3"
		k_nr_errori++
	end if

//--- controlli validi solo se anagrafica ITALIANA
	if trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_nazione_1")) = "IT"	 &
		or len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_nazione_1"))) = 0 &
		or isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_nazione_1")) then

		if len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cap_1"))) > 0 &
			or len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "prov_1"))) > 0 then

//--- controllo del CAP 1
			if len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cap_1"))) > 0 then
		
				kst_tab_cap.cap =  trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cap_1"))
				kst_esito = kuf1_ausiliari.tb_select(kst_tab_cap)
				if kst_esito.esito = kkg_esito_ok then
					if len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "prov_1"))) > 0 then
						if kst_tab_cap.prov <>  trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "prov_1")) then
							k_return += tab_1.tabpage_1.text + ": Provincia non congruente con il CAP, suggerisco '" + trim(kst_tab_cap.prov) + "'~n~r" 
							k_errore = "1"
							k_nr_errori++
						end if
					else
						tab_1.tabpage_1.dw_1.setitem (k_riga, "prov_1", trim(kst_tab_cap.prov))
					end if
				else
					k_return += tab_1.tabpage_1.text + ": " + trim(kst_esito.sqlerrtext) + "~n~r" 
					k_return += tab_1.tabpage_1.text + ": Errore CAP non trovato ("+left(trim(kst_esito.sqlerrtext),40)+")~n~r" 
					k_errore = "1"
					k_nr_errori++
				end if
			else
	
//--- controllo della  PROVINCIA 1
				if len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "prov_1"))) > 0 then
		
					kst_tab_cap.prov =  trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "prov_1"))
					kst_esito = kuf1_ausiliari.tb_select_cap_provincia(kst_tab_cap)
					if kst_esito.esito = kkg_esito_ok then
						if len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cap_1"))) > 0 then
							if kst_tab_cap.cap <>  trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cap_1")) then
								k_return += tab_1.tabpage_1.text + ": CAP non congruente con la Provincia, il primo CAP e' '" + trim(kst_tab_cap.cap) + "'~n~r" 
								k_errore = "1"
								k_nr_errori++
							end if
						else
							k_return += tab_1.tabpage_1.text + ": CAP non presente, il primo CAP di questa prov. e' '" + trim(kst_tab_cap.cap) + "'~n~r" 
							k_errore = "5"
							k_nr_errori++
						end if
					else
						k_return += tab_1.tabpage_1.text + ": " + trim(kst_esito.sqlerrtext) + "~n~r" 
						k_errore = "1"
						k_nr_errori++
					end if
				end if
			end if
			
			
		end if

	
//--- controllo della NAZIONE

		kst_tab_nazioni.id_nazione =  trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_nazione_1"))
		kst_esito = kuf1_ausiliari.tb_select(kst_tab_nazioni)
		if kst_esito.esito <> kkg_esito_ok then
			k_return += tab_1.tabpage_1.text + ": " + trim(kst_esito.sqlerrtext) + "~n~r" 
			k_errore = "1"
			k_nr_errori++
		end if
	end if


//--- controllo della PIVA solo SE ITALIA
	if len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "p_iva"))) > 0 then
		kst_tab_clienti.p_iva = trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "p_iva"))
		tab_1.tabpage_1.dw_1.setitem ( k_riga, "p_iva", kst_tab_clienti.p_iva)
		kst_esito = kiuf_clienti.conta_p_iva(kst_tab_clienti)
		if kst_esito.esito = "0" then
			if ((isnull(k_key) or k_key = 0) and kst_tab_clienti.contati > 0) &
			   or kst_tab_clienti.contati > 1 then 
				k_return = k_return &
				           + tab_1.tabpage_1.text + ": Partita IVA già utilizzata x altro Cliente " + "~n~r" 
				k_errore = "1"
				k_nr_errori++
			end if
		end if
		if	k_errore = "0" or k_errore = "4" then
			if trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_nazione_1")) = "IT"	 &
			   or len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_nazione_1"))) = 0 then

				kst_esito = kiuf_clienti.check_piva(kst_tab_clienti)
				if kst_esito.esito <> kkg_esito_ok then
					k_return += tab_1.tabpage_1.text + ": " + trim(kst_esito.sqlerrtext) + "~n~r" 
					k_errore = "4"
					k_nr_errori++
				end if
			end if
		end if
	end if
		
//--- controllo della Codice Fiscale solo SE ITALIA
	if len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cf"))) > 0 then
		kst_tab_clienti.cf = trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cf"))
		tab_1.tabpage_1.dw_1.setitem ( k_riga, "cf", kst_tab_clienti.cf)
		if k_errore = "0" or k_errore = "4" then
			if trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_nazione_1")) = "IT"	 &
			   or len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_nazione_1"))) = 0 then

				kst_esito = kiuf_clienti.check_cf(kst_tab_clienti)
				if kst_esito.esito <> kkg_esito_ok then
					k_return += tab_1.tabpage_1.text + ": " + trim(kst_esito.sqlerrtext) + "~n~r" 
					k_errore = "4"
					k_nr_errori++
				end if
			end if
		end if
	end if

	if	k_errore = "0" then
		if isnull(k_key) or k_key = 0 then
			k_return = tab_1.tabpage_1.text + ": Il Codice verra' assegnato automaticamente. " + "~n~r"
			k_errore = "5"
			k_nr_errori++
		else
		end if
	end if
	
	
	if k_errore = "0" or k_errore = "4" or k_errore = "5" then
		k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
		k_riga = tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) 
		if k_riga > 0 then
			kuf1_web = create kuf_web 
			kst_tab_clienti_web.email =  tab_1.tabpage_1.dw_1.getitemstring( k_riga, "email")
			if len(trim(kst_tab_clienti_web.email)) > 0 then
				kst_web.email = kst_tab_clienti_web.email
				if not kuf1_web.if_sintassi_email_ok( kst_web ) then
					k_return = trim(k_return) +  tab_1.tabpage_3.text + ": il primo campo 'e-mail' non sembra corretto, prego controllare " &
					+" ~n~r" 
					k_errore = "4"
					k_nr_errori++
				end if
			end if
			kst_tab_clienti_web.email =  tab_1.tabpage_1.dw_1.getitemstring( k_riga, "email1")
			if len(trim(kst_tab_clienti_web.email1)) > 0 then
				kst_web.email = kst_tab_clienti_web.email1
				if not kuf1_web.if_sintassi_email_ok( kst_web ) then
					k_return = trim(k_return) +  tab_1.tabpage_3.text + ": il secondo campo 'e-mail' non sembra corretto, prego controllare " &
					+" ~n~r" 
					k_errore = "4"
					k_nr_errori++
				end if
			end if
			kst_tab_clienti_web.email2 =  tab_1.tabpage_1.dw_1.getitemstring( k_riga, "email2")
			if len(trim(kst_tab_clienti_web.email2)) > 0 then
				kst_web.email = kst_tab_clienti_web.email2
				if not kuf1_web.if_sintassi_email_ok( kst_web ) then
					k_return = trim(k_return) +  tab_1.tabpage_3.text + ": Terzo campo 'e-mail' non sembra corretto, prego controllare " &
					+" ~n~r" 
					k_errore = "4"
					k_nr_errori++
				end if
			end if
			kst_tab_clienti_web.sito_web =  tab_1.tabpage_1.dw_1.getitemstring( k_riga, "sito_web")
			if len(trim(kst_tab_clienti_web.sito_web )) > 0 then
				kst_web.url = kst_tab_clienti_web.sito_web
				kuf1_web.url_add_http( kst_web ) //aggiunge http:// all'indirizzo
				tab_1.tabpage_1.dw_1.setitem( k_riga, "sito_web", kst_web.url)
				if not kuf1_web.if_url_esiste( kst_web ) then
					k_return = trim(k_return) +  tab_1.tabpage_3.text + ": Il 'Sito Web' indicato sembra non esistere, prego controllare " &
					+" ~n~r" 
					k_errore = "4"
					k_nr_errori++
				end if
			end if
			kst_tab_clienti_web.sito_web1 =  tab_1.tabpage_1.dw_1.getitemstring( k_riga, "sito_web1")
			if len(trim(kst_tab_clienti_web.sito_web1 )) > 0 then
				kst_web.url = kst_tab_clienti_web.sito_web1
				kuf1_web.url_add_http( kst_web ) //aggiunge http:// all'indirizzo
				tab_1.tabpage_1.dw_1.setitem( k_riga, "sito_web", kst_web.url)
				if not kuf1_web.if_url_esiste( kst_web ) then
					k_return = trim(k_return) +  tab_1.tabpage_3.text + ": L'indirizzo di 'Altro Sito' sembra non esistere, prego controllare " &
					+" ~n~r" 
					k_errore = "4"
					k_nr_errori++
				end if
			end if
			destroy kuf1_web
		end if
	end if
	
	
////=== Controllo altro tab
//	k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
//	k_riga = tab_1.tabpage_4.dw_4.getnextmodified(0, primary!)
//
//	do while k_riga > 0  and k_nr_errori < 10
//
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

private function boolean check_rek (string k_codice);//
boolean k_return = false
int k_anno
string k_rag_soc_10
long k_codice_1



	SELECT 
         clienti.rag_soc_10
   	 INTO 
      	   :k_rag_soc_10  
    	FROM clienti 
   	WHERE codice = :k_codice;

	if sqlca.sqlcode = 0 then

		if messagebox("Anagrafica gia' in Archivio", & 
					"Vuoi modificare i dati anagrafici "+ &
					trim(k_rag_soc_10), question!, yesno!, 2) = 1 then
		
//			tab_1.tabpage_1.dw_1.reset()

			ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica
			ki_st_open_w.key1 = string(k_codice,"0000000000")

			tab_1.tabpage_1.dw_1.reset()
			inizializza()
			
		else
			
			k_return = true
		end if
	end if  

	attiva_tasti()



return k_return


end function

on w_contatti.create
int iCurrent
call super::create
end on

on w_contatti.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_contatti
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_contatti
integer x = 2711
integer y = 1424
end type

type st_stampa from w_g_tab_3`st_stampa within w_contatti
end type

type st_ritorna from w_g_tab_3`st_ritorna within w_contatti
end type

type dw_trova from w_g_tab_3`dw_trova within w_contatti
integer x = 1705
integer y = 304
end type

type dw_filtra from w_g_tab_3`dw_filtra within w_contatti
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_contatti
integer x = 1152
integer y = 1440
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_contatti
integer x = 768
integer y = 1440
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_contatti
integer x = 1970
integer y = 1424
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_contatti
integer x = 2341
integer y = 1424
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_contatti
integer x = 1600
integer y = 1424
boolean enabled = false
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

type tab_1 from w_g_tab_3`tab_1 within w_contatti
integer x = 32
integer y = 52
integer width = 3040
integer height = 1396
end type

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 32435950
string text = " Contatto "
long tabbackcolor = 32435950
long picturemaskcolor = 31646434
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 5
integer width = 2967
integer height = 1244
string dataobject = "d_contatto"
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_1::itemchanged;//
string k_codice
int k_errore=0


choose case dwo.name 
	case "codice" 

		k_codice = upper(trim(data))
		if Len(trim(k_codice)) > 0 then
			if check_rek( k_codice )  then
				k_errore = 1
			end if
		
		end if

end choose 

if k_errore = 1 then
	return 2
end if
	
end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 16777215
string text = "Associazioni"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer x = 0
integer width = 2981
integer height = 1228
boolean enabled = true
string dataobject = "d_clienti_listino_sl_pt"
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer width = 3003
integer height = 1268
boolean enabled = false
string text = ""
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
integer width = 2967
integer height = 1232
end type

event dw_3::itemchanged;call super::itemchanged;//



end event

event dw_3::getfocus;call super::getfocus;//getfocus
if This.getSelectedRow(0) <= 0 then
	This.SelectRow(1, TRUE)
end if
//

end event

event dw_3::clicked;call super::clicked;This.SetRow(row)
This.SelectRow(0, FALSE)
if row > 0 then
	This.SelectRow(row, TRUE)
end if

end event

event rowfocuschanged;//
This.SelectRow(0, FALSE)
this.SelectRow(currentrow, TRUE)

end event

event dw_3::ue_dwnkey;//

end event

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 3003
integer height = 1268
boolean enabled = false
string text = ""
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
end type

event dw_4::getfocus;call super::getfocus;//getfocus
if This.getSelectedRow(0) <= 0 then
	This.SelectRow(1, TRUE)
end if
//

end event

event dw_4::clicked;call super::clicked;//
This.SetRow(row)
This.SelectRow(0, FALSE)
if row > 0 then
	This.SelectRow(row, TRUE)
end if

end event

event rowfocuschanged;//
This.SelectRow(0, FALSE)
this.SelectRow(currentrow, TRUE)

end event

event dw_4::ue_dwnkey;//

end event

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 3003
integer height = 1268
boolean enabled = false
string text = ""
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
integer width = 2935
integer height = 1172
end type

event dw_5::clicked;call super::clicked;//
This.SetRow(row)
This.SelectRow(0, FALSE)
if row > 0 then
	This.SelectRow(row, TRUE)
end if

end event

event dw_5::getfocus;call super::getfocus;//getfocus
if This.getSelectedRow(0) <= 0 then
	This.SelectRow(1, TRUE)
end if
//

end event

event rowfocuschanged;//
This.SelectRow(0, FALSE)
this.SelectRow(currentrow, TRUE)

end event

event dw_5::ue_dwnkey;//
end event

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 3003
integer height = 1268
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3003
integer height = 1268
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3003
integer height = 1268
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3003
integer height = 1268
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

