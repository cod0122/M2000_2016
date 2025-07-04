﻿$PBExportHeader$w_clienti_err.srw
forward
global type w_clienti_err from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_clienti_err from w_g_tab_3
integer x = 169
integer y = 148
integer width = 3127
integer height = 1688
string title = "Anagrafica"
end type
global w_clienti_err w_clienti_err

forward prototypes
protected subroutine inizializza_2 ()
private function integer check_rek (long k_codice)
protected subroutine inizializza_4 ()
protected function string dati_modif (string k_titolo)
protected subroutine inizializza_3 ()
protected function integer cancella ()
protected function integer inserisci ()
private function integer check_cliente ()
protected subroutine attiva_tasti ()
protected subroutine inizializza_1 ()
protected function string check_dati ()
protected subroutine pulizia_righe ()
protected subroutine riempi_id ()
protected function string aggiorna ()
protected function string inizializza ()
end prototypes

protected subroutine inizializza_2 ();////======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
long k_codice, k_id_cliente
string k_scelta
int k_rc
//datawindowchild kdwc_sl_pt, kdwc_t_contr



k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
k_scelta = trim(ki_st_open_w.flag_modalita)

//=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
	if k_codice = 0 then
		inserisci()
		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
	end if

//=== Se tab_3 non ha righe INSERISCI_tab_3 altrimenti controllo che righe sono
//=== Se le righe presenti non c'entrano con la cliente allora resetto		
//	if tab_1.tabpage_3.dw_3.rowcount() > 0 then
//		if tab_1.tabpage_3.dw_3.getitemnumber(1, "codice") <> k_codice then 
//			tab_1.tabpage_3.dw_3.reset()
//		end if
//	end if
	if tab_1.tabpage_3.dw_3.rowcount() < 1 then

//		k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")  

////--- Attivo dw archivio Piani Trattamento
//		k_rc=tab_1.tabpage_3.dw_3.getchild("cod_sl_pt", kdwc_sl_pt)
//	
//		k_rc=kdwc_sl_pt.settransobject(sqlca)
//
//		k_rc=kdwc_sl_pt.getchild("t_contr", kdwc_t_contr)
//		k_rc=kdwc_t_contr.settransobject(sqlca)
//	
//		if kdwc_t_contr.rowcount() = 0 then
//			kdwc_t_contr.retrieve("%")
//			kdwc_t_contr.insertrow(1)
//		end if
//	
//		if kdwc_sl_pt.rowcount() = 0 then
//			kdwc_sl_pt.retrieve("%", "*")
//			kdwc_sl_pt.insertrow(1)
//		end if

//=== Parametri : cliente, articolo, sl-pt
		if tab_1.tabpage_3.dw_3.retrieve(k_codice, "*", "*") <= 0 then

			inserisci()
		else
					
			attiva_tasti()

		end if				
	else
		attiva_tasti()
	end if

	tab_1.tabpage_3.dw_3.setitem(1, "k_pwd", kg_pwd)

	tab_1.tabpage_3.dw_3.setfocus()
	

end subroutine

private function integer check_rek (long k_codice);//
int k_return = 0
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
					"Vuoi modificare la anagrafica "+ &
					trim(k_rag_soc_10), question!, yesno!, 2) = 1 then
		
//			tab_1.tabpage_1.dw_1.reset()

			ki_st_open_w.flag_modalita = "mo"
			ki_st_open_w.key1 = string(k_codice,"0000000000")

			tab_1.tabpage_1.dw_1.reset()
			inizializza()
			
		else
			
			k_return = 1
		end if
	end if  

	attiva_tasti()



return k_return


end function

protected subroutine inizializza_4 ();////======================================================================
//=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
//======================================================================
//
long k_codice, k_codice_4, k_rc
string k_scelta
string k_fine_ciclo=""
int k_ctr=0
datawindowchild kdwc_clienti_1, kdwc_clienti_2
kuf_utility kuf1_utility


k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
k_scelta = trim(ki_st_open_w.flag_modalita)

//--- Acchiappo il codice CLIENTE x evitare la rilettura
if IsNumber(tab_1.tabpage_5.st_5_retrieve.Text) then
	k_codice_4 = long(tab_1.tabpage_5.st_5_retrieve.Text)
else
	k_codice_4 = 0
end if
//=== Forza valore Codice cliente per ricordarlo per le prossime richieste
tab_1.tabpage_5.st_5_retrieve.Text=string(k_codice, "####0")


//=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
	if k_codice = 0 then
		tab_1.tabpage_5.dw_5.reset()
	else

//=== Se tab_4 non ha righe INSERISCI_TAB_4 altrimenti controllo che righe sono
//=== Se le righe presenti non c'entrano con la cliente allora resetto		
		if tab_1.tabpage_5.dw_5.rowcount() > 0 then
			if k_codice_4 <> k_codice then 
				tab_1.tabpage_5.dw_5.reset()
			end if
		end if
	
	
		if tab_1.tabpage_5.dw_5.rowcount() < 1 then
	
			k_rc = tab_1.tabpage_5.dw_5.retrieve(k_codice) 
		
		end if
		
		attiva_tasti()
		
	end if



//--- Inabilita campi alla modifica se Vsualizzazione
   kuf1_utility = create kuf_utility 
   if trim(ki_st_open_w.flag_modalita) = "vi" or k_codice_4 <> k_codice then 
	
      kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_5.dw_5)

	end if
	destroy kuf1_utility
	


end subroutine

protected function string dati_modif (string k_titolo);//
//=== Controllo se ci sono state modifiche di dati sui DW
string k_return="0 "
int k_msg=0


//=== Toglie le righe eventualmente da non registrare
	pulizia_righe()
	
	if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0  & 
	 	or tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0  & 
	 	or tab_1.tabpage_5.dw_5.getnextmodified(0, primary!) > 0  & 
		or tab_1.tabpage_1.dw_1.getnextmodified(0, delete!) > 0  & 
	 	or tab_1.tabpage_2.dw_2.getnextmodified(0, delete!) > 0  & 
	 	or tab_1.tabpage_5.dw_5.getnextmodified(0, delete!) > 0  & 
		then 

		if isnull(k_titolo) or len(trim(k_titolo)) = 0 then
			k_titolo = "Aggiorna Archivio"
		end if

		k_msg = messagebox(k_titolo, "Dati Modificati, vuoi Salvare gli Aggiornamenti ?", &
							question!, yesnocancel!, 1) 
	
		if k_msg = 1 then
			k_return = "1Dati Modificati"	
		else
			k_return = string(k_msg)			
		end if

	end if


return k_return
end function

protected subroutine inizializza_3 ();////======================================================================
//=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
//======================================================================
//
long k_codice, k_codice_4
string k_scelta, k_estrazione
date k_data_int
kuf_base kuf1_base 



k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
k_scelta = trim(ki_st_open_w.flag_modalita)
k_data_int = RelativeDate(today(), -365)

//--- Acchiappo il codice CLIENTE x evitare la rilettura
if IsNumber(tab_1.tabpage_4.dw_4.Object.k_codice.Text) then
	k_codice_4 = long(tab_1.tabpage_4.dw_4.Object.k_codice.Text)
else
	k_codice_4 = 0
end if
//=== Forza valore Codice cliente per ricordarlo per le prossime richieste
tab_1.tabpage_4.dw_4.Object.k_codice.Text=string(k_codice, "####0")


//=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
	if k_codice = 0 then
		inserisci()
		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
	end if

//=== Se tab_4 non ha righe INSERISCI_TAB_4 altrimenti controllo che righe sono
//=== Se le righe presenti non c'entrano con la cliente allora resetto		
	if tab_1.tabpage_4.dw_4.rowcount() > 0 then
		if k_codice_4 <> k_codice then 
			tab_1.tabpage_4.dw_4.reset()
		end if
	end if

	if tab_1.tabpage_4.dw_4.rowcount() < 1 then
//			if k_scelta <> "in" then

		kuf1_base = create kuf_base 
//--- reperisce l'ultima estremi estrazione	
		k_estrazione = mid(kuf1_base.prendi_dato_base("descr_ultima_estrazione_statistici"),2)
		destroy kuf1_base 
		tab_1.tabpage_4.dw_4.object.t_estrazione.text = trim(k_estrazione)
	
		if tab_1.tabpage_4.dw_4.retrieve(k_codice, k_data_int) <= 0 then

			inserisci()
		else
			attiva_tasti()
		end if				
//			else
//				inserisci()
//			end if
	else
		attiva_tasti()

	end if

////=== Se tab_4 non ha righe INSERISCI_TAB_41 altrimenti controllo che righe sono
////=== Se le righe presenti non c'entrano con la cliente allora resetto
//	if tab_1.tabpage_4.dw_41.rowcount() > 0 then
//		tab_1.tabpage_4.dw_41.accepttext()
//		if tab_1.tabpage_4.dw_41.getitemnumber(1, "codice") <> k_codice then 
//			tab_1.tabpage_4.dw_41.reset()
//		end if
//	end if
//
//	if tab_1.tabpage_4.dw_41.rowcount() < 1 then
//
//		if tab_1.tabpage_4.dw_41.retrieve(k_codice) <= 0 then
//
//			inserisci()
//		else
//			attiva_tasti()
//		end if				
//	else
//		attiva_tasti()
//	end if
//	
//	tab_1.tabpage_4.dw_41.setfocus()
//	

	



end subroutine

protected function integer cancella ();////
////=== Cancellazione rekord dal DB
////=== Ritorna : 0=OK 1=KO 2=non eseguita
////
int k_return=0
string k_desc, k_record, k_record_1
long k_key = 0, k_clie_1=0, k_clie_2
string k_errore = "0 ", k_errore1 = "0 ", k_nro_fatt
long k_riga, k_seq
date k_data
kuf_clienti  kuf1_clienti



//=== 
choose case tab_1.selectedtab 
	case 1 
		k_record = " Cliente "
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
					"Sei sicuro di voler eliminare la Anagrafica~n~r" + &
					string(k_key, "#####") +  &
					"~n~r" + trim(k_desc) + " ?"
			else
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
			end if
		end if
	case 2
		k_record = " Indirizzo Commerciale "
		k_riga = tab_1.tabpage_2.dw_2.getrow()	
		if tab_1.tabpage_2.dw_2.getcolumn() < 8 then
			k_riga = 0
			messagebox("Cancella Indirizzo di Spedizione", &
						"Devi mettere manualmente a spazio tutti i campi. ")
		else			
			if k_riga > 0 then
				if tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> new! and &
					tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
					k_key = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "clie_c")
					k_desc = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "rag_soc_1_c")
					if isnull(k_desc) = true or trim(k_desc) = "" then
						k_desc = "senza ragione sociale" 
					end if
					k_record_1 = &
						"Sei sicuro di voler eliminare l'Indirizzo Commerciale del cliente~n~r" + &
						string(k_key, "#####") + " - " + trim(k_desc) + " ?"
				else
					tab_1.tabpage_2.dw_2.setitem(k_riga, "codice", 0)
					inizializza_1()
				end if
			end if
		end if
	case 5
		k_record = " Associazione Anagrafiche "
		k_riga = tab_1.tabpage_5.dw_5.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_5.dw_5.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_5.dw_5.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_5.dw_5.getitemnumber(k_riga, "m_r_f_clie_3")
				k_clie_1 = tab_1.tabpage_5.dw_5.getitemnumber(k_riga, "clie_1")
				k_clie_2 = tab_1.tabpage_5.dw_5.getitemnumber(k_riga, "clie_2")
				k_record_1 = &
					"Sei sicuro di voler eliminare il legame con il~n~r" &
					+ "Mandante " + trim(string(k_clie_1)) + "  e  il Ricevente " &
					+ trim(string(k_clie_2)) + " ?"
			else
				tab_1.tabpage_5.dw_5.deleterow(k_riga)
			end if
		end if
end choose	



//=== Se righe in lista
if k_riga > 0 and k_key > 0 then
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina" + k_record, k_record_1, &
		question!, yesno!, 2) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_clienti = create kuf_clienti
		
//=== Cancella la riga dal data windows di lista
		choose case tab_1.selectedtab 
			case 1 
				k_errore = kuf1_clienti.tb_delete(k_key) 
			case 2
				k_errore = kuf1_clienti.tb_delete_ind_comm(k_key) 
			case 5
				k_errore = kuf1_clienti.tb_delete_m_r_f(k_clie_1, k_clie_2, k_key) 
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
					case 2
						tab_1.tabpage_2.dw_2.setitem(k_riga, "codice", 0)
						inizializza_1()
	//					tab_1.tabpage_2.dw_2.deleterow(k_riga)
					case 5 
						tab_1.tabpage_5.dw_5.deleterow(k_riga)
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

//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
		destroy kuf1_clienti

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
	case 2
		tab_1.tabpage_2.dw_2.setfocus()
		tab_1.tabpage_2.dw_2.setcolumn(7)
		tab_1.tabpage_2.dw_2.ResetUpdate ( ) 
	case 5
		tab_1.tabpage_5.dw_5.setfocus()
		tab_1.tabpage_5.dw_5.setcolumn(1)
		tab_1.tabpage_5.dw_5.ResetUpdate ( ) 
end choose	


return k_return

end function

protected function integer inserisci ();//
int k_return=1, k_ctr
string k_errore="0 "
date k_data
long k_codice, k_nro_commessa, k_riga, k_id_cliente, k_id_protocollo
//datawindowchild kdwc_cliente, kdwc_cliente_1, kdwc_cliente_2 
kuf_base kuf1_base


//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
//if left(dati_modif(""), 1) = "1" then //Richisto Aggiornamento

//=== Controllo congruenza dei dati caricati e Aggiornamento  
//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
//===                : 2=errore non grave dati aggiornati;
//===			         : 3=LIBERO
//===      il resto della stringa contiene la descrizione dell'errore   
//	k_errore = aggiorna_dati()

//end if


if left(k_errore, 1) = "0" then


//=== Aggiunge una riga al data windows
	choose case tab_1.selectedtab 
		case  1 
	
//			tab_1.tabpage_1.dw_1.getchild("clienti_a_rag_soc_1", kdwc_cliente)

//			kdwc_cliente.settransobject(sqlca)
	
			tab_1.tabpage_1.dw_1.insertrow(0)
			
			tab_1.tabpage_1.dw_1.setcolumn(2)
			
		case 2 // dati indirizzi
			k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
//=== Riempe indirizzo di Spedizione da DW_1
			if k_codice > 0 then
				k_riga = tab_1.tabpage_2.dw_2.insertrow(0)
	
				tab_1.tabpage_2.dw_2.setitem(k_riga, "codice", k_codice)
				tab_1.tabpage_2.dw_2.setitem(k_riga, "clie_3", k_codice)
	
				tab_1.tabpage_2.dw_2.scrolltorow(k_riga)
				tab_1.tabpage_2.dw_2.setrow(k_riga)
				tab_1.tabpage_2.dw_2.setcolumn(1)
			end if
			
		case 3 // Listino
			k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
				 
//			if k_id_cliente > 0 and k_codice > 0 then
//				tab_1.tabpage_3.dw_3.Modify("codice.CheckBox.On='"+ &
//										string(k_codice, "#####")+"'")
//
////=== Parametri : commessa, cliente, flag di rek commessa + altri prot non abbinati
//				if tab_1.tabpage_3.dw_3.retrieve(k_codice, k_id_cliente, 1) > 0 then
//					tab_1.tabpage_3.dw_3.scrolltorow(1)
//					tab_1.tabpage_3.dw_3.setrow(1)
//					tab_1.tabpage_3.dw_3.setcolumn(1)
////=== Imposto il protocollo messo in testata
//					k_id_protocollo = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_protocollo")
//					if k_id_protocollo > 0 then 
//						k_ctr = tab_1.tabpage_3.dw_3.find("id_protocollo=" + &
//											string(k_id_protocollo, "#####"), 0, &
//											tab_1.tabpage_3.dw_3.rowcount())
//						if k_ctr > 0 then 
//							if tab_1.tabpage_3.dw_3.getitemnumber(k_ctr, "codice") = 0 or & 
//								isnull(tab_1.tabpage_3.dw_3.getitemnumber(k_ctr, "codice")) then 
//							
//								tab_1.tabpage_3.dw_3.setitem(k_ctr, "codice", k_codice)
//							end if
//						end if
//					end if
//
//				end if
//			end if
//
			
		case 4 // 
			k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
	
//			if k_codice > 0 then
//				k_riga = tab_1.tabpage_4.dw_4.insertrow(0)
//
//				tab_1.tabpage_4.dw_4.setitem(k_riga, "codice", k_codice)
//				tab_1.tabpage_4.dw_4.scrolltorow(k_riga)
//				tab_1.tabpage_4.dw_4.setrow(k_riga)
//				tab_1.tabpage_4.dw_4.setcolumn(1)
//
////				if tab_1.tabpage_4.dw_41.rowcount() = 0 then
////					k_riga = tab_1.tabpage_4.dw_41.insertrow(0)
////
////					tab_1.tabpage_4.dw_41.setitem(k_riga, "codice", k_codice)
////					tab_1.tabpage_4.dw_41.scrolltorow(k_riga)
////					tab_1.tabpage_4.dw_41.setrow(k_riga)
////					tab_1.tabpage_4.dw_41.setcolumn(1)
////				end if
//			end if
			
		case 5 // 
			k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
	
//=== Riempe indirizzo di Spedizione da DW_1
			if k_codice > 0 then
				k_riga = tab_1.tabpage_5.dw_5.insertrow(0)
	
				tab_1.tabpage_5.dw_5.setitem(k_riga, "m_r_f_clie_3", k_codice)
	
				tab_1.tabpage_5.dw_5.scrolltorow(k_riga)
				tab_1.tabpage_5.dw_5.setrow(k_riga)
				tab_1.tabpage_5.dw_5.setcolumn("clie_1")
				
			end if
			
	end choose	

	k_return = 0

//=== 
	attiva_tasti()

end if

return (k_return)



end function

private function integer check_cliente ();//
int k_return 
string k_rag_soc, k_rag_soc_10
long k_id_cliente


k_rag_soc_10 = trim(tab_1.tabpage_1.dw_1.gettext())

if len(k_rag_soc_10) > 0 then

	declare c_clienti cursor for  
		SELECT 
  	     clienti.codice,  
  	     clienti.rag_soc_10  
    	FROM clienti  
   	WHERE upper(clienti.rag_soc_10) >= :k_rag_soc_10 
			order by clienti.rag_soc_10 ;

	k_rag_soc = "Anagrafica non trovata"

	open c_clienti;
	if sqlca.sqlcode = 0 then
		
		fetch c_clienti into :k_id_cliente, :k_rag_soc;
		if sqlca.sqlcode = 0 then

			tab_1.tabpage_1.dw_1.setitem(1, "codice", k_id_cliente)
			tab_1.tabpage_1.dw_1.setitem(1, "clienti_a_rag_soc_10", k_rag_soc)
			tab_1.tabpage_1.dw_1.settext(k_rag_soc)
		else			
			k_rag_soc = "Anagrafica non trovata"
		end if
		close c_clienti;
	end if
			
end if

k_return = 1

return k_return

end function

protected subroutine attiva_tasti ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

//long k_nr_righe

super::attiva_tasti()

tab_1.tabpage_2.enabled = false
tab_1.tabpage_3.enabled = false
tab_1.tabpage_4.enabled = false
tab_1.tabpage_5.enabled = false

//=== Nr righe ne DW lista
if tab_1.tabpage_1.dw_1.rowcount() > 0 then

	if tab_1.tabpage_1.dw_1.getitemnumber(1, "codice") > 0 then
		tab_1.tabpage_2.enabled = true
		tab_1.tabpage_3.enabled = true
		tab_1.tabpage_4.enabled = true
		tab_1.tabpage_5.enabled = true
	end if
	
	choose case tab_1.selectedtab
		case 1
			cb_aggiorna.enabled = true
		case 2
			if ki_st_open_w.flag_modalita <> kkg_flag_modalita_inserimento then
				cb_modifica.enabled = true
				cb_aggiorna.enabled = true
				cb_cancella.enabled = true
			end if
		case 3 //listino
		   cb_visualizza.enabled = true
		case 4 //movimentazione
		   cb_visualizza.enabled = true
		case 5
			if ki_st_open_w.flag_modalita <> kkg_flag_modalita_inserimento then
				cb_modifica.enabled = true
				cb_inserisci.enabled = true
				cb_aggiorna.enabled = true
				cb_cancella.enabled = true
			end if
	end choose

else
	
	cb_inserisci.enabled = true
	cb_inserisci.default = true
	
end if

if ki_st_open_w.flag_modalita = kkg_flag_modalita_visualizzazione &
   or ki_st_open_w.flag_modalita = kkg_flag_modalita_cancellazione then
	cb_inserisci.enabled = false
	cb_aggiorna.enabled = false
	cb_cancella.enabled = false
	cb_modifica.enabled = false
end if

POST attiva_menu()


end subroutine

protected subroutine inizializza_1 ();////======================================================================
////=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
////======================================================================
////
//long k_codice
//string k_scelta
//string k_fine_ciclo=""
//int k_ctr=0
//kuf_utility kuf1_utility
//
//
//k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
//k_scelta = trim(ki_st_open_w.flag_modalita)
//
////=== Se cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
//	if k_codice = 0 then
//		inserisci()
//		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
//	end if
//
////=== Se tab_2 non ha righe INSERISCI_TAB_2 altrimenti controllo che righe sono
////=== Se le righe presenti non c'entrano con il cliente allora resetto		
//	if tab_1.tabpage_2.dw_2.rowcount() > 0 then
//		if tab_1.tabpage_2.dw_2.getitemnumber(1, "codice") <> k_codice then 
//			tab_1.tabpage_2.dw_2.reset()
//		end if
//	end if
//
//	if tab_1.tabpage_2.dw_2.rowcount() < 1 then
//
//
////=== Retrive indirizzo di Spedizione e Fatturazione
//		if tab_1.tabpage_2.dw_2.retrieve(k_codice) <= 0 then
//
//			inserisci()
//		else
//			attiva_tasti()
//		end if				
//
////=== Setto lostato della dw per insert o update della tab indi_commerciali
//		if tab_1.tabpage_2.dw_2.rowcount() > 0 then
//			k_ctr = tab_1.tabpage_2.dw_2.getrow()
//			if tab_1.tabpage_2.dw_2.getitemnumber ( k_ctr, "clie_c") > 0 then
//				tab_1.tabpage_2.dw_2.SetItemStatus(k_ctr, 0, Primary!, NotModified!)
//			else
//				tab_1.tabpage_2.dw_2.SetItemStatus(k_ctr, 0, Primary!, New!)
//			end if
//		end if
//	else
//		attiva_tasti()
//	end if
//
//	tab_1.tabpage_2.dw_2.setfocus()
//
//	
//
////--- Inabilita campi alla modifica se Visualizzazione
//   kuf1_utility = create kuf_utility 
//   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_visualizzazione &
//	    or tab_1.tabpage_2.dw_2.getitemnumber(1, "codice") <> k_codice then 
//	
//      kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_2.dw_2)
//
//	end if
//	destroy kuf1_utility
//
//////--- Inabilita campi alla modifica se Vsualizzazione
////   kuf1_utility = create kuf_utility 
////   if trim(ki_st_open_w.flag_modalita) = "vi" then
////	
////      kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_2.dw_2)
////
////	else		
////		
//////--- S-protezione campi per riabilitare la modifica a parte la chiave
////      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_2.dw_2)
////
////	end if
////	destroy kuf1_utility
////	
//	
//
//
//
end subroutine

protected function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK ma errore non grave
//===                : 5=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_return = " "
char k_errore = "0"
long k_nr_righe
int k_riga, k_ctr
int k_nr_errori
string k_key_str
char k_stato, k_tipo
long k_key
st_esito kst_esito
st_tab_clienti kst_tab_clienti
kuf_clienti kuf1_clienti


//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = tab_1.tabpage_1.dw_1.getrow()
	k_ctr = tab_1.tabpage_2.dw_2.getrow()


//=== Valorizzo indi di sped e resetto i flag di modificati
//	if k_nr_righe > 0 and tab_1.tabpage_2.dw_2.rowcount() > 0 then
//		
//		if tab_1.tabpage_2.dw_2.GetItemStatus ( k_riga, "rag_soc_20", primary!) = newmodified! &
//		   or tab_1.tabpage_2.dw_2.GetItemStatus ( k_riga, "rag_soc_20", primary!) = datamodified! &
//			then
//			tab_1.tabpage_1.dw_1.setitem ( k_riga, "rag_soc_20", &
//				tab_1.tabpage_2.dw_2.getitemstring ( k_ctr, "rag_soc_20"))
//			tab_1.tabpage_2.dw_2.SetItemStatus(k_riga, "rag_soc_20", Primary!, NotModified!)
//		end if
//		
//		if tab_1.tabpage_2.dw_2.GetItemStatus ( k_riga, "rag_soc_21", primary!) = newmodified! &
//		   or tab_1.tabpage_2.dw_2.GetItemStatus ( k_riga, "rag_soc_21", primary!) = datamodified! &
//			then
//			tab_1.tabpage_1.dw_1.setitem ( k_riga, "rag_soc_21", &
//					tab_1.tabpage_2.dw_2.getitemstring ( k_ctr, "rag_soc_21"))
//			tab_1.tabpage_2.dw_2.SetItemStatus(k_riga, "rag_soc_21", Primary!, NotModified!)
//		end if
//		
//		if tab_1.tabpage_2.dw_2.GetItemStatus ( k_riga, "indi_2", primary!) = newmodified! &
//		   or tab_1.tabpage_2.dw_2.GetItemStatus ( k_riga, "indi_2", primary!) = datamodified! &
//			then
//			tab_1.tabpage_1.dw_1.setitem ( k_riga, "indi_2", &
//					tab_1.tabpage_2.dw_2.getitemstring ( k_ctr, "indi_2"))
//			tab_1.tabpage_2.dw_2.SetItemStatus(k_riga, "indi_2", Primary!, NotModified!)
//		end if
//		
//		if tab_1.tabpage_2.dw_2.GetItemStatus ( k_riga, "cap_2", primary!) = newmodified! &
//		   or tab_1.tabpage_2.dw_2.GetItemStatus ( k_riga, "cap_2", primary!) = datamodified! &
//			then
//			tab_1.tabpage_1.dw_1.setitem ( k_riga, "cap_2", &
//					tab_1.tabpage_2.dw_2.getitemstring ( k_ctr, "cap_2"))
//			tab_1.tabpage_2.dw_2.SetItemStatus(k_riga, "cap_2", Primary!, NotModified!)
//		end if
//		
//		if tab_1.tabpage_2.dw_2.GetItemStatus ( k_riga, "loc_2", primary!) = newmodified! &
//		   or tab_1.tabpage_2.dw_2.GetItemStatus ( k_riga, "loc_2", primary!) = datamodified! &
//			then
//			tab_1.tabpage_1.dw_1.setitem ( k_riga, "loc_2", &
//					tab_1.tabpage_2.dw_2.getitemstring ( k_ctr, "loc_2"))
//			tab_1.tabpage_2.dw_2.SetItemStatus(k_riga, "loc_2", Primary!, NotModified!)
//		end if
//		
//		if tab_1.tabpage_2.dw_2.GetItemStatus ( k_riga, "prov_2", primary!) = newmodified! &
//		   or tab_1.tabpage_2.dw_2.GetItemStatus ( k_riga, "prov_2", primary!) = datamodified! &
//			then
//			tab_1.tabpage_1.dw_1.setitem ( k_riga, "prov_2", &
//					tab_1.tabpage_2.dw_2.getitemstring ( k_ctr, "prov_2"))
//			tab_1.tabpage_2.dw_2.SetItemStatus(k_riga, "prov_2", Primary!, NotModified!)
//		end if
//		
//	end if

	k_key = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "codice") 

	if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "rag_soc_10")) = true then
		k_return = tab_1.tabpage_1.text + ": Manca la Ragione sociale " + "~n~r" 
		k_errore = "3"
		k_nr_errori++
	end if

	if len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "p_iva"))) > 0 then
		kst_tab_clienti.p_iva = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "p_iva")
		kuf1_clienti = create kuf_clienti
	   kst_esito = kuf1_clienti.conta_p_iva(kst_tab_clienti)
		destroy kuf1_clienti
		if kst_esito.esito = "0" then
			if ((isnull(k_key) or k_key = 0) and kst_tab_clienti.contati > 0) &
			   or kst_tab_clienti.contati > 1 then 
				k_return = k_return &
				           + tab_1.tabpage_1.text + ": Partita IVA già utilizzata x altro Cliente " + "~n~r" 
				k_errore = "1"
				k_nr_errori++
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
//--- controllo ESENZIONE	
	if	k_errore = "0" then
		if isnull(k_key) or k_key = 0 then
			k_return = tab_1.tabpage_1.text + ": Il Codice verra' assegnato automaticamente. " + "~n~r"
			k_errore = "5"
			k_nr_errori++
		else
		end if
	end if

//=== Controllo altro tab
	k_nr_righe = tab_1.tabpage_5.dw_5.rowcount()
	k_riga = tab_1.tabpage_5.dw_5.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10

		if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
			if isnull(tab_1.tabpage_5.dw_5.getitemnumber ( k_riga, "clie_1")) = true &
			   or tab_1.tabpage_5.dw_5.getitemnumber ( k_riga, "clie_1") = 0 &
				then
				k_return = trim(k_return) +  tab_1.tabpage_5.text + ": Mandante alla riga " + &
				string(k_riga, "#####") + " non impostato~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if
			if isnull(tab_1.tabpage_5.dw_5.getitemnumber ( k_riga, "clie_2")) = true & 
			   or tab_1.tabpage_5.dw_5.getitemnumber ( k_riga, "clie_2") = 0 &
				then
				k_return = trim(k_return) + tab_1.tabpage_5.text + ": Ricevente alla riga " + &
				string(k_riga, "#####") + " non impostato~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if
		end if
		
		k_riga++

		k_riga = tab_1.tabpage_5.dw_5.getnextmodified(k_riga, primary!)

	loop

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

protected subroutine pulizia_righe ();//
long k_riga
long k_nr_righe


if tab_1.tabpage_1.dw_1.rowcount() > 0 then
	tab_1.tabpage_1.dw_1.accepttext()
end if
if tab_1.tabpage_5.dw_5.rowcount() > 0 then
	tab_1.tabpage_5.dw_5.accepttext()
end if

//=== Pulizia dei rek non validi sui vari TAB
	k_nr_righe = tab_1.tabpage_5.dw_5.rowcount()
	for k_riga = k_nr_righe to 1 step -1

		if tab_1.tabpage_5.dw_5.getitemstatus(k_riga, 0, primary!) = newmodified! then 
			if (isnull(tab_1.tabpage_5.dw_5.getitemnumber ( k_riga, "clie_1")) or &
				 tab_1.tabpage_5.dw_5.getitemnumber ( k_riga, "clie_1") = 0) or &
				(isnull(tab_1.tabpage_5.dw_5.getitemnumber ( k_riga, "clie_2")) or &
				 tab_1.tabpage_5.dw_5.getitemnumber ( k_riga, "clie_2") = 0) &
				then
		
				tab_1.tabpage_5.dw_5.deleterow(k_riga)

			end if
		end if
		
	next


end subroutine

protected subroutine riempi_id ();//
//=== Imposta gli Effettivi ID degli archivi
long k_righe, k_ctr, k_codice, k_nro_old
long k_codice_1
string k_ret_code
kuf_base kuf1_base


//=== Salvo ID originale x piu' avanti
	k_codice_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")


//=== Se non sono in caricamento allora prelevo l'ID dalla dw
	if tab_1.tabpage_1.dw_1.getitemstatus(1, 0, primary!) <> newmodified! then
		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
	else

		if isnull(k_codice_1) then				
			tab_1.tabpage_1.dw_1.setitem(1, "codice", 0)
		end if

//		kuf1_base = create kuf_base
//	//=== Imposto il ID  su arch. Azienda
//		k_ret_code = kuf1_base.prendi_dato_base("codice")
//		if left(k_ret_code, 1) = "0" then
//			k_codice = long(mid(k_ret_code, 2)) + 1
//			k_ret_code = kuf1_base.metti_dato_base(0, "codice", string(k_codice,"#####"))
//		end if
//		if left(k_ret_code, 1) = "1" then
//	
//			k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
//			
//			messagebox("Aggiornamento Automatico Fallito !!", &
//				"Attenzione: non sono riuscito ad aggiornare il contatore COMMESSE,~n~r" + &
//				"in archivio Azienda. ~n~r" + &
//				"Aggiornare immediatamente in modo manuale il 'ID Commessa' in Azienda. ~n~r" + &
//				"Per eseguire l'aggiornamento fare ALT+Z ed impostare  ~n~r" + &
//				"il numero " + string(k_codice,"#####") + " nel campo 'ID Commess'. ~n~r" + &
//				"Eseguire poi gli opportuni controlli su questi dati Commessa. ~n~r" + &

//				"Se il problema persiste, si prega di contattare il programmatore. Grazie", &
//				stopsign!, ok!)
//				
//		end if		
	
//		destroy kuf1_base
//		k_nro_commessa_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "nro_commessa")
//		if k_nro_commessa <> k_nro_commessa_1 then
//
////=== ho trovato il nr commessa diverso da quello in BASE controllo se commessa gia' caricata
//			select codice into :k_ctr
//				from commesse
//				where nro_commessa = :k_nro_commessa_1;
//
//			if sqlca.sqlcode = 0 then
//				k_nro_old = tab_1.tabpage_1.dw_1.getitemnumber(1, "nro_commessa") 
//				messagebox("Aggiornamento Commessa", &
//					"Mi spiace ma il numero abbinato a questa commessa e' stato cambiato ~n~r" + &
//					"da " + string(k_nro_old,"#####") + " a " + &
//						string(k_nro_commessa,"#####") + "~n~r" + &
//					"Motivo : potrebbero esserci altri utenti che stanno caricando Commesse, ~n~r" + &
//					"nessun pericolo di perdita dati. ", &
//					information!, ok!)
//			end if
//		end if		
//	
	
//		tab_1.tabpage_1.dw_1.setitem(1, "nro_commessa", k_nro_commessa)
	
		tab_1.tabpage_1.dw_1.setitem(1, "codice", k_codice)

	end if
	
	k_ctr = tab_1.tabpage_2.dw_2.getrow()
	if k_ctr  > 0 then
	
		if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_ctr, "rag_soc_1_c")) then
			tab_1.tabpage_1.dw_1.setitem ( k_ctr, "rag_soc_1_c", " ") 
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_ctr, "rag_soc_2_c")) then 
			tab_1.tabpage_1.dw_1.setitem ( k_ctr, "rag_soc_2_c", " ") 
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_ctr, "indi_c")) then
			tab_1.tabpage_1.dw_1.setitem ( k_ctr, "indi_c", " ") 
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_ctr, "loc_c")) then
			tab_1.tabpage_1.dw_1.setitem ( k_ctr, "loc_c", " ") 
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_ctr, "cap_c")) then
			tab_1.tabpage_1.dw_1.setitem ( k_ctr, "cap_c", " ") 
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_ctr, "prov_c")) then
			tab_1.tabpage_1.dw_1.setitem ( k_ctr, "prov_c", " ") 
		end if
//		if isnull(tab_1.tabpage_2.dw_2.getitemnumber(k_ctr, "clie_c")) &
//		   or k_codice_1 <> tab_1.tabpage_2.dw_2.getitemnumber(k_ctr, "clie_c") then
//			if len(trim(tab_1.tabpage_2.dw_2.getitemstring ( k_ctr, "rag_soc_1_c"))) > 0 &
//				or len(trim(tab_1.tabpage_2.dw_2.getitemstring ( k_ctr, "rag_soc_2_c"))) > 0 &
//				or len(trim(tab_1.tabpage_2.dw_2.getitemstring ( k_ctr, "indi_c"))) > 0 &
//				or len(trim(tab_1.tabpage_2.dw_2.getitemstring ( k_ctr, "loc_c"))) > 0 &
//				then
//				tab_1.tabpage_2.dw_2.setitem(k_ctr, "clie_c", k_codice_1)
//			end if
//		end if
	end if
	
	k_righe = tab_1.tabpage_5.dw_5.rowcount()
	for k_ctr = 1 to k_righe 

		tab_1.tabpage_5.dw_5.setitem(k_ctr, "m_r_f_clie_3", k_codice_1)
				
	end for



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
long k_riga
st_tab_ind_comm kst_tab_ind_comm
st_tab_clienti kst_tab_clienti
kuf_clienti kuf1_clienti

//=== Aggiorna, se modificato, la TAB_1	
if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 & 
	then
//	tab_1.tabpage_1.dw_1.getnextmodified(0, delete!) > 0 & 

	k_riga = tab_1.tabpage_1.dw_1.getrow()
	tab_1.tabpage_1.dw_1.setitem(k_riga, "x_datins", kuf1_data_base.prendi_x_datins())
	tab_1.tabpage_1.dw_1.setitem(k_riga, "x_utente", kuf1_data_base.prendi_x_utente())

	if tab_1.tabpage_1.dw_1.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		k_errore1 = kuf1_data_base.db_commit()
		if left(k_errore1, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_1.text + mid(k_errore1, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
			k_riga = tab_1.tabpage_1.dw_1.getrow()
			if k_riga > 0 then
				kst_tab_ind_comm.clie_c = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "codice")
				kst_tab_ind_comm.rag_soc_1_c = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "ind_comm_rag_soc_1_c")
				kst_tab_ind_comm.rag_soc_2_c = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "ind_comm_rag_soc_2_c")
				kst_tab_ind_comm.indi_c = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "ind_comm_indi_c")
				kst_tab_ind_comm.loc_c = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "ind_comm_loc_c")
				kst_tab_ind_comm.cap_c = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "ind_comm_cap_c")
				kst_tab_ind_comm.prov_c = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "ind_comm_prov_c")
				kuf1_clienti = create kuf_clienti
				kuf1_clienti.tb_update_ind_comm(kst_tab_ind_comm)
				destroy kuf1_clienti
			end if
		end if
	else
		k_errore1 = kuf1_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + &
					tab_1.tabpage_1.text + "' ~n~r" 
	end if
end if

//=== Aggiorna, se modificato, la TAB_2
if tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 & 
	then
//	tab_1.tabpage_2.dw_2.getnextmodified(0, delete!) > 0 & 

	if tab_1.tabpage_2.dw_2.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		k_errore1 = kuf1_data_base.db_commit()
		if left(k_errore1, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_2.text + mid(k_errore1, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
		end if
	else
		k_errore1 = kuf1_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + &
					tab_1.tabpage_2.text + "' ~n~r" 
	end if	
end if

//=== Aggiorna, se modificato, la TAB_5
if tab_1.tabpage_5.dw_5.getnextmodified(0, primary!) > 0 & 
	then
//	tab_1.tabpage_5.dw_5.getnextmodified(0, delete!) > 0 & 

	if tab_1.tabpage_5.dw_5.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		k_errore1 = kuf1_data_base.db_commit()
		if left(k_errore1, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_5.text + mid(k_errore1, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
		end if
	else
		k_errore1 = kuf1_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + &
					tab_1.tabpage_5.text + "' ~n~r" 
	end if	
end if



//=== errore : 0=tutto OK o NON RICHIESTA; 1=errore grave I-O;
//=== 		 : 2=LIBERO
//===			 : 3=Commit fallita

if left(k_return, 1) = "1" then
	messagebox("Operazione di Aggiornamento Non Eseguita !!", &
		mid(k_return, 2))
else
	if left(k_return, 1) = "3" then
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
long  k_key, k_id_cliente
int k_err_ins, k_rc
string k_fine_ciclo=""
int k_ctr=0
datawindowchild  kdwc_clienti_1, kdwc_clienti_2 
datawindowchild kdwc_iva, kdwc_pag
kuf_utility kuf1_utility
//datawindowchild kdwc_contatto, kdwc_divisione, kdwc_tipo, kdwc_protocollo
//






//=== 
//tab_1.tabpage_4.dw_41.settransobject(sqlca)


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	k_key = long(trim(ki_st_open_w.key1))


//--- Attivo dw archivio Clienti Mandanti
	k_rc = tab_1.tabpage_5.dw_5.getchild("clienti_rag_soc_1", kdwc_clienti_1)

	k_rc = kdwc_clienti_1.settransobject(sqlca)

	if kdwc_clienti_1.rowcount() = 0 then
		kdwc_clienti_1.insertrow(1)
	end if
//--- Attivo dw archivio Clienti Riceventi
	k_rc = tab_1.tabpage_5.dw_5.getchild("clienti_rag_soc_2", kdwc_clienti_2)

	k_rc = kdwc_clienti_2.settransobject(sqlca)

	if kdwc_clienti_2.rowcount() = 0 then
		kdwc_clienti_2.insertrow(1)
	end if

//--- Attivo dw archivio IVA
	tab_1.tabpage_1.dw_1.getchild("iva", kdwc_iva)

	kdwc_iva.settransobject(sqlca)

	if kdwc_iva.rowcount() = 0 then
		kdwc_iva.retrieve(0)
		kdwc_iva.insertrow(1)
	end if

//--- Attivo dw archivio TIPO PAGAMENTO
	tab_1.tabpage_1.dw_1.getchild("cod_pag", kdwc_pag)

	kdwc_pag.settransobject(sqlca)

	if kdwc_pag.rowcount() = 0 then
		kdwc_pag.retrieve(0)
		kdwc_pag.insertrow(1)
	end if

//	if k_key = 0 then
	if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento then
		
		k_err_ins = inserisci()
		tab_1.tabpage_1.dw_1.setfocus()
	else

		k_rc = tab_1.tabpage_1.dw_1.retrieve(k_key) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(ID Anagrafica cercata :" + string(k_key) + ")~n~r" )
				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				if k_scelta = "mo" then
					messagebox("Ricerca fallita", &
						"Mi spiace ma la Anagrafica non e' in archivio ~n~r" + &
						"(ID anagrafica cercata :" + string(k_key) + ")~n~r" )

					cb_ritorna.triggerevent("clicked!")
					
				else
					k_err_ins = inserisci()
					tab_1.tabpage_1.dw_1.setfocus()
				end if
			case is > 0		
				if k_scelta = "in" then
					messagebox("Trovata Anagrafica", &
						"La Anagrafica e' gia' in archivio ~n~r" + &
						"(ID anagrafica cercata :" + string(k_key) + ")~n~r" )
			
					ki_st_open_w.flag_modalita = "mo"

				end if

				tab_1.tabpage_1.dw_1.setcolumn(1)
				tab_1.tabpage_1.dw_1.setfocus()
				
				attiva_tasti()
		
		end choose

	end if

else
	attiva_tasti()
end if

//===
//--- se inserimento inabilito gli altri TAB, sono inutili
if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento then

	tab_1.tabpage_2.enabled = false
	tab_1.tabpage_3.enabled = false
	tab_1.tabpage_4.enabled = false
	tab_1.tabpage_5.enabled = false
	
end if

if ki_st_open_w.flag_primo_giro = 'S' then //se giro di prima volta

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

end if
//tab_1.tabpage_1.dw_1.resetupdate()

return "0"


end function

on w_clienti_err.create
int iCurrent
call super::create
end on

on w_clienti_err.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_clienti_err
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_clienti_err
integer x = 2711
integer y = 1356
end type

type st_stampa from w_g_tab_3`st_stampa within w_clienti_err
end type

type st_ritorna from w_g_tab_3`st_ritorna within w_clienti_err
end type

type dw_filtro_0 from w_g_tab_3`dw_filtro_0 within w_clienti_err
integer x = 1335
integer y = 468
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_clienti_err
integer x = 795
integer y = 1396
end type

event cb_visualizza::clicked;call super::clicked;//
string k_cod_art
long k_cod_cli, k_mis_x, k_mis_y, k_mis_z
double k_dose
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


if tab_1.tabpage_3.dw_3.getrow() > 0 then

	k_cod_cli = tab_1.tabpage_3.dw_3.getitemnumber( &
						tab_1.tabpage_3.dw_3.getrow(), "listino_cod_cli") 
	k_cod_art = tab_1.tabpage_3.dw_3.getitemstring( &
						tab_1.tabpage_3.dw_3.getrow(), "listino_cod_art") 
	k_dose = tab_1.tabpage_3.dw_3.getitemnumber( &
						tab_1.tabpage_3.dw_3.getrow(), "listino_dose") 
	k_mis_x = tab_1.tabpage_3.dw_3.getitemnumber( &
						tab_1.tabpage_3.dw_3.getrow(), "listino_mis_x") 
	k_mis_y = tab_1.tabpage_3.dw_3.getitemnumber( &
						tab_1.tabpage_3.dw_3.getrow(), "listino_mis_y") 
	k_mis_z = tab_1.tabpage_3.dw_3.getitemnumber( &
						tab_1.tabpage_3.dw_3.getrow(), "listino_mis_z") 


//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli; key2=cod sl-pt

	K_st_open_w.id_programma = "listino"
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita_visualizzazione
	K_st_open_w.flag_adatta_win = KK_ADATTA_WIN_NO
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(k_cod_cli)) // cod cliente
	K_st_open_w.key2 = trim(k_cod_art) // cod articolo 
	K_st_open_w.key3 = trim(string(k_dose)) // dose
	K_st_open_w.key4 = trim(string(k_mis_x)) // misure imballo
	K_st_open_w.key5 = trim(string(k_mis_y)) // misure imballo
	K_st_open_w.key6 = trim(string(k_mis_z)) // misure imballo
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if

end event

type cb_modifica from w_g_tab_3`cb_modifica within w_clienti_err
integer x = 1221
integer y = 1400
end type

event cb_modifica::clicked;//
string k_cod_art
long k_cod_cli, k_mis_x, k_mis_y, k_mis_z
double k_dose
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window
kuf_utility kuf1_utility


	choose case tab_1.selectedtab
		case 1
		case 2
		case 3 // chiama listino
			if tab_1.tabpage_3.dw_3.getrow() > 0 then
			
				k_cod_cli = tab_1.tabpage_3.dw_3.getitemnumber( &
									tab_1.tabpage_3.dw_3.getrow(), "listino_cod_cli") 
				k_cod_art = tab_1.tabpage_3.dw_3.getitemstring( &
									tab_1.tabpage_3.dw_3.getrow(), "listino_cod_art") 
				k_dose = tab_1.tabpage_3.dw_3.getitemnumber( &
									tab_1.tabpage_3.dw_3.getrow(), "listino_dose") 
				k_mis_x = tab_1.tabpage_3.dw_3.getitemnumber( &
									tab_1.tabpage_3.dw_3.getrow(), "listino_mis_x") 
				k_mis_y = tab_1.tabpage_3.dw_3.getitemnumber( &
									tab_1.tabpage_3.dw_3.getrow(), "listino_mis_y") 
				k_mis_z = tab_1.tabpage_3.dw_3.getitemnumber( &
									tab_1.tabpage_3.dw_3.getrow(), "listino_mis_z") 
			
			//=== Parametri : 
			//=== struttura st_open_w
			//=== dati particolare programma
			//
			//=== Si potrebbero passare:
			//=== key1=codice cli; key2=cod sl-pt
			
				K_st_open_w.id_programma = "listino"
				K_st_open_w.flag_primo_giro = "S"
				K_st_open_w.flag_modalita = kkg_flag_modalita_modifica
				K_st_open_w.flag_adatta_win = KK_ADATTA_WIN_NO
				K_st_open_w.flag_leggi_dw = " "
				K_st_open_w.flag_cerca_in_lista = " "
				K_st_open_w.key1 = trim(string(k_cod_cli)) // cod cliente
				K_st_open_w.key2 = trim(k_cod_art) // cod articolo 
				K_st_open_w.key3 = trim(string(k_dose)) // dose
				K_st_open_w.key4 = trim(string(k_mis_x)) // misure imballo
				K_st_open_w.key5 = trim(string(k_mis_y)) // misure imballo
				K_st_open_w.key6 = trim(string(k_mis_z)) // misure imballo
				K_st_open_w.flag_where = " "
				
				kuf1_menu_window = create kuf_menu_window 
				kuf1_menu_window.open_w_tabelle(k_st_open_w)
				destroy kuf1_menu_window
											
			else
				messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")
			end if
		case 4
		case 5
			if tab_1.tabpage_5.dw_5.rowcount() > 0 then
			   kuf1_utility = create kuf_utility 
//--- S-protezione campi per riabilitare la modifica a parte la chiave
		      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_5.dw_5)
				destroy kuf1_utility
			else
				inserisci() 
			end if
			
	end choose



end event

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_clienti_err
integer x = 1970
integer y = 1388
end type

event cb_aggiorna::clicked;//

//=== Toglie le righe eventualmente da non registrare
pulizia_righe()

//=== Aggiornamento dei dati inseriti/modificati
if left(aggiorna_dati(), 1) = "0" then
	messagebox("Operazione eseguita", "Dati aggiornati correttamente")
//	dw_dett_0.reset()
//	dw_lista_0.setfocus()
	
	attiva_tasti()
	
////	inserisci()
//	if cb_inserisci.enabled = true then
//		cb_inserisci.triggerevent(clicked!)
//	end if
//
	
end if

end event

type cb_cancella from w_g_tab_3`cb_cancella within w_clienti_err
integer x = 2341
integer y = 1376
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_clienti_err
integer x = 1600
integer y = 1384
boolean enabled = false
end type

event cb_inserisci::clicked;//
//=== 
string k_errore="0"
string k_cod_art
long k_cod_cli, k_mis_x, k_mis_y, k_mis_z
double k_dose
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window
kuf_utility kuf1_utility


//=== Nuovo Rekord
	choose case tab_1.selectedtab 
		case  1   // clienti
			
			Super::EVENT Clicked()
			
		case 3 // listino
			
			if tab_1.tabpage_1.dw_1.getrow() > 0 then

				k_cod_cli = tab_1.tabpage_1.dw_1.getitemnumber( &
									tab_1.tabpage_1.dw_1.getrow(), "codice") 
				k_cod_art = ""
				k_dose = 0
				k_mis_x = 0
				k_mis_y = 0
				k_mis_z = 0
			
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli; key2=cod sl-pt

				K_st_open_w.id_programma = "listino"
				K_st_open_w.flag_primo_giro = "S"
				K_st_open_w.flag_modalita = kkg_flag_modalita_inserimento
				K_st_open_w.flag_adatta_win = KK_ADATTA_WIN_NO
				K_st_open_w.flag_leggi_dw = " "
				K_st_open_w.flag_cerca_in_lista = " "
				K_st_open_w.key1 = trim(string(k_cod_cli)) // cod cliente
				K_st_open_w.key2 = trim(k_cod_art) // cod articolo 
				K_st_open_w.key3 = trim(string(k_dose)) // dose
				K_st_open_w.key4 = trim(string(k_mis_x)) // misure imballo
				K_st_open_w.key5 = trim(string(k_mis_y)) // misure imballo
				K_st_open_w.key6 = trim(string(k_mis_z)) // misure imballo
				K_st_open_w.flag_where = " "
				
				kuf1_menu_window = create kuf_menu_window 
				kuf1_menu_window.open_w_tabelle(k_st_open_w)
				destroy kuf1_menu_window
											
			else
			
				messagebox("Operazione non eseguita", "Nessun cliente presente")
			
			end if


		case 5
			inserisci() 
			if tab_1.tabpage_5.dw_5.rowcount() > 0 then
			   kuf1_utility = create kuf_utility 
//--- S-protezione campi per riabilitare la modifica a parte la chiave
		      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_5.dw_5)
				destroy kuf1_utility
			end if
			
			
	end choose
	

end event

type tab_1 from w_g_tab_3`tab_1 within w_clienti_err
integer x = 23
integer y = 28
integer width = 3040
integer height = 1440
end type

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 3003
integer height = 1312
string text = "Anagrafica"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer y = 40
integer width = 2967
integer height = 1244
string dataobject = "d_clienti_1"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::itemchanged;call super::itemchanged;//
date k_data
long k_codice
string k_rag_soc
int k_errore=0


choose case dwo.name 
	case "codice" 
		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
		if isnull(k_codice) = false and k_codice > 0 then
			if check_rek( k_codice ) > 0 then
				k_errore = 1
			end if
		end if
//	case "rag_soc_10" 
//		check_cliente()
//		k_errore = 1
end choose 

if k_errore = 1 then
	return 2
end if
	
end event

event dw_1::clicked;//
//
end event

event dw_1::buttonclicked;call super::buttonclicked;//
//=== Premuto pulsante nella DW
//

if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento &
   or ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica &
	then
	//--- copia NOMINATIVO princ in spedizione
	if dwo.name = "b_copia_sped" then
		this.setitem(row, "rag_soc_20", this.getitemstring(row, "rag_soc_10")) 
		this.setitem(row, "rag_soc_21", this.getitemstring(row, "rag_soc_11")) 
	else	
	//--- copia NOMINATIVO princ in fatturazione
		if dwo.name = "b_copia_fatt" then
			this.setitem(row, "ind_comm_rag_soc_1_c", this.getitemstring(row, "rag_soc_10")) 
			this.setitem(row, "ind_comm_rag_soc_2_c", this.getitemstring(row, "rag_soc_11")) 
		end if
	end if
end if

//
end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
boolean visible = false
integer width = 3003
integer height = 1312
boolean enabled = false
string text = "?"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = false
integer x = 0
integer width = 2981
integer height = 1228
boolean enabled = false
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_2::clicked;//
end event

event dw_2::getfocus;//
end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer width = 3003
integer height = 1312
string text = "Listino"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
integer x = 23
integer y = 20
integer width = 2981
integer height = 1252
string dataobject = "d_clienti_listino_sl_pt"
boolean hscrollbar = true
boolean vscrollbar = true
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
boolean visible = true
integer width = 3003
integer height = 1312
string text = "Movimenti"
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
string dataobject = "d_clienti_mov"
boolean hscrollbar = true
boolean vscrollbar = true
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
boolean visible = true
integer width = 3003
integer height = 1312
string text = "Mandanti & Riceventi"
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
integer width = 2935
integer height = 1172
string dataobject = "d_m_r_f_l"
boolean hscrollbar = true
boolean vscrollbar = true
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

event dw_5::itemchanged;call super::itemchanged;//
string k_rag_soc, k_codice
long k_rc, k_riga=0
integer k_return=0
datawindowchild kdwc_cli


choose case upper(dwo.name)

	case "CLIENTI_RAG_SOC_1" 

		k_rag_soc = RightTrim(data)
		if isnull(k_rag_soc) = false and len(trim(k_rag_soc)) > 0 then
			
			k_rc = tab_1.tabpage_5.dw_5.getchild("clienti_rag_soc_1", kdwc_cli)
			k_rc = kdwc_cli.find("rag_soc_1 like ~""+k_rag_soc+"%~"",0,kdwc_cli.rowcount())
			k_riga = k_rc
			if k_riga <= 0 or isnull(k_riga) then
				k_return = 2
				tab_1.tabpage_5.dw_5.setitem(row, "clienti_rag_soc_1", k_rag_soc+" - NON TROVATO -")
				tab_1.tabpage_5.dw_5.setitem(row, "clie_1", 0)
			else
				k_return = 2
				tab_1.tabpage_5.dw_5.setitem(row, "clienti_rag_soc_1", kdwc_cli.getitemstring(k_riga, "rag_soc_1"))
				tab_1.tabpage_5.dw_5.setitem(row, "clie_1", kdwc_cli.getitemnumber(k_riga, "id_cliente"))
			end if
			
		end if

	
	case "CLIENTI_RAG_SOC_2" 
	
		k_rag_soc = RightTrim(data)
		if isnull(k_rag_soc) = false and len(trim(k_rag_soc)) > 0 then
			
			k_rc = tab_1.tabpage_5.dw_5.getchild("clienti_rag_soc_2", kdwc_cli)
			k_rc = kdwc_cli.find("rag_soc_1 like ~""+k_rag_soc+"%~"",0,kdwc_cli.rowcount())
			k_riga = k_rc
			if k_riga <= 0 or isnull(k_riga) then
				k_return = 2
				tab_1.tabpage_5.dw_5.setitem(row, "clienti_rag_soc_2", " - NON TROVATO -")
				tab_1.tabpage_5.dw_5.setitem(row, "clie_2", 0)
			else
				k_return = 2
				tab_1.tabpage_5.dw_5.setitem(row, "clienti_rag_soc_2", kdwc_cli.getitemstring(k_riga, "rag_soc_1"))
				tab_1.tabpage_5.dw_5.setitem(row, "clie_2", kdwc_cli.getitemnumber(k_riga, "id_cliente"))
			end if
			
		end if
	
		
	case "CLIE_1" 
	
		if isnumber(Trim(data)) then
			k_codice = Trim(data)
		else
			k_codice = "0"
		end if
		if isnull(k_codice) = false and len(trim(k_codice)) > 0 then
			
			k_rc = tab_1.tabpage_5.dw_5.getchild("clienti_rag_soc_1", kdwc_cli)
			k_rc = kdwc_cli.find("id_cliente = "+k_codice+" ",0,kdwc_cli.rowcount())
			k_riga = k_rc
			if k_riga <= 0 or isnull(k_riga) then
				k_return = 2
				tab_1.tabpage_5.dw_5.setitem(row, "clienti_rag_soc_1", " - NON TROVATO -")
//				tab_1.tabpage_5.dw_5.setitem(row, "clie_2", 0)
			else
				k_return = 2
				tab_1.tabpage_5.dw_5.setitem(row, "clienti_rag_soc_1", kdwc_cli.getitemstring(k_riga, "rag_soc_1"))
				tab_1.tabpage_5.dw_5.setitem(row, "clie_1", kdwc_cli.getitemnumber(k_riga, "id_cliente"))
			end if
			
		end if
		
	case "CLIE_2" 
	
		if isnumber(Trim(data)) then
			k_codice = Trim(data)
		else
			k_codice = "0"
		end if
		if isnull(k_codice) = false and len(trim(k_codice)) > 0 then
			
			k_rc = tab_1.tabpage_5.dw_5.getchild("clienti_rag_soc_2", kdwc_cli)
			k_rc = kdwc_cli.find("id_cliente = "+k_codice+" ",0,kdwc_cli.rowcount())
			k_riga = k_rc
			if k_riga <= 0 or isnull(k_riga) then
				k_return = 2
				tab_1.tabpage_5.dw_5.setitem(row, "clienti_rag_soc_2", k_rag_soc+" - NON TROVATO -")
//				tab_1.tabpage_5.dw_5.setitem(row, "clie_2", 0)
			else
				k_return = 2
				tab_1.tabpage_5.dw_5.setitem(row, "clienti_rag_soc_2", kdwc_cli.getitemstring(k_riga, "rag_soc_1"))
				tab_1.tabpage_5.dw_5.setitem(row, "clie_2", kdwc_cli.getitemnumber(k_riga, "id_cliente"))
			end if
			
		end if

end choose


return k_return



end event

event dw_5::itemfocuschanged;call super::itemfocuschanged;long k_rc
datawindowchild kdwc_clienti, kdwc_clienti_2

if (dwo.name = "clienti_rag_soc_1" or dwo.name = "clienti_rag_soc_2"  &
   or dwo.name = "clie_1" or dwo.name = "clie_2")  &
	and ki_st_open_w.flag_modalita <> "vi" then

//--- Attivo dw archivio Clienti
	k_rc = tab_1.tabpage_5.dw_5.getchild("clienti_rag_soc_1", kdwc_clienti)
	k_rc = tab_1.tabpage_5.dw_5.getchild("clienti_rag_soc_2", kdwc_clienti_2)

//	k_rc = kdwc_clienti_d.settransobject(sqlca)

	if kdwc_clienti.rowcount() < 2 then
		kdwc_clienti.retrieve("%")
		kdwc_clienti.insertrow(1)
	end if

//--- copio le righe sulla seconda child clienti
	kdwc_clienti.rowscopy(kdwc_clienti.GetRow(), kdwc_clienti.RowCount(), &
				 		       Primary!, kdwc_clienti_2, 1, Primary!)


end if

end event

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
integer x = 283
integer y = 1008
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 3003
integer height = 1312
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3003
integer height = 1312
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3003
integer height = 1312
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3003
integer height = 1312
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type cb_cerca_1 from w_g_tab_3`cb_cerca_1 within w_clienti_err
end type

type sle_cerca from w_g_tab_3`sle_cerca within w_clienti_err
end type

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

