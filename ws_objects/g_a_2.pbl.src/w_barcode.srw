﻿$PBExportHeader$w_barcode.srw
forward
global type w_barcode from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
type dw_modifica_giri_scambio from uo_dw_modifica_giri_barcode_scambio within w_barcode
end type
end forward

global type w_barcode from w_g_tab_3
integer width = 3035
integer height = 1680
string title = "Barcode"
boolean ki_toolbar_window_presente = true
boolean ki_fai_nuovo_dopo_update = false
dw_modifica_giri_scambio dw_modifica_giri_scambio
end type
global w_barcode w_barcode

type variables
//
private string ki_path_risorse 


//private boolean ki_abilita_funzione_giri = false
private boolean ki_abilita_pianificazione_trattamento = false
private boolean ki_abilita_barcode_alla_modifica = false

datawindow  kidw_dett_0_da_non_modificare

private kuf_barcode kiuf_barcode
private string ki_flag_modalita_orig=""
private st_tab_barcode kist_tab_barcode_orig
private kuf_barcode_mod_giri kiuf_barcode_mod_giri

private st_tab_armo_campioni kist_tab_armo_campioni

private kuf_pilota_prg_g3 kiuf_pilota_prg_g3
private kuf_pilota_prg kiuf_pilota_prg
private boolean ki_provenieneza_pilota_prg 
end variables

forward prototypes
protected subroutine inizializza_1 ()
private subroutine riempi_id ()
protected function integer inserisci ()
protected function string check_dati ()
protected subroutine pulizia_righe ()
protected function integer cancella ()
private function integer check_rek (string k_codice)
protected function string inizializza ()
protected subroutine attiva_menu ()
private subroutine abilita_modifica_giri ()
protected subroutine smista_funz (string k_par_in)
private subroutine abilita_pianificazione_trattamento ()
private subroutine aggiungi_barcode_padre (st_tab_barcode kst_tab_barcode)
private subroutine aggiungi_barcode_figlio (st_tab_barcode kst_tab_barcode)
private subroutine call_elenco_barcode_figli_potenziali ()
protected function string aggiorna ()
private subroutine call_elenco_barcode_padri_potenziali ()
private subroutine conta_figli ()
protected subroutine open_start_window ()
protected function string dati_modif_figlio_inizio (string a_1)
protected subroutine dati_modif_figlio_fine (string a_1)
private function boolean if_barcode_da_trattare ()
protected subroutine inizializza_2 () throws uo_exception
protected subroutine attiva_tasti_0 ()
private subroutine modifica_giri ()
protected subroutine inizializza_3 () throws uo_exception
protected subroutine inizializza_4 () throws uo_exception
private subroutine call_logtrace ()
end prototypes

protected subroutine inizializza_1 ();//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_codice, k_codice_elenco = ""
string k_scelta


//=== 
//tab_1.tabpage_4.dw_41.settransobject(sqlca)



	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		k_codice = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "barcode")  )
		k_scelta = trim(ki_st_open_w.flag_modalita)


//=== Se tab_2 non ha righe INSERISCI_TAB_2 altrimenti controllo che righe sono
//=== Se le righe presenti non c'entrano con il cliente allora resetto		
		if tab_1.tabpage_2.dw_2.rowcount() > 0 then

			k_codice_elenco = trim(tab_1.tabpage_2.dw_2.getitemstring(1, "barcode_lav"))

		end if
	
		if  k_codice_elenco <> k_codice and tab_1.tabpage_2.dw_2.deletedcount( ) = 0 then 
			tab_1.tabpage_2.dw_2.reset()

//=== Retrive 
			if tab_1.tabpage_2.dw_2.retrieve( k_codice ) <= 0 then

				attiva_tasti()
			else
				
//03.04.2008//--- Imposto campi x link standar
//				tab_1.tabpage_2.dw_2.link_standard_imposta()
				
				attiva_tasti()
				
			end if				
		else
			attiva_tasti()
		end if
	
		tab_1.tabpage_2.dw_2.setfocus()
		
	end if
	
	tab_1.tabpage_2.dw_2.resetUpdate()



end subroutine

private subroutine riempi_id ();//
//=== Imposta gli Effettivi ID degli archivi
long k_righe, k_ctr
string k_codice
long k_riga
st_tab_barcode kst_tab_barcode
kuf_base kuf1_base

	
	k_riga = tab_1.tabpage_1.dw_1.getrow()

//=== Salvo ID del rec originale x piu' avanti
	kst_tab_barcode.barcode = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "barcode")

//=== Se non sono in caricamento allora prelevo l'ID dalla dw
	if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then
		k_codice = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "barcode")
	end if

//--- Se non specifico ne' PADRI ne' FIGLI allora tolgo il Groupage altrimento attivo il flag
	if Len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "barcode_lav"))) = 0 and tab_1.tabpage_2.dw_2.rowcount() = 0 then
		try 
			if kiuf_barcode.if_barcode_padre(kst_tab_barcode) then
				tab_1.tabpage_1.dw_1.setitem ( k_riga, "barcode_groupage", kiuf_barcode.ki_barcode_groupage_SI )
			else
				tab_1.tabpage_1.dw_1.setitem ( k_riga, "barcode_groupage",  kiuf_barcode.ki_barcode_groupage_NO )
			end if
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
		end try
	else
		tab_1.tabpage_1.dw_1.setitem ( k_riga, "barcode_groupage",  kiuf_barcode.ki_barcode_groupage_SI )
	end if
		
	
	tab_1.tabpage_1.dw_1.setitem(1, "barcode_x_datins", kGuf_data_base.prendi_x_datins())
	tab_1.tabpage_1.dw_1.setitem(1, "barcode_x_utente", kGuf_data_base.prendi_x_utente())
		
	


end subroutine

protected function integer inserisci ();//
int k_return=1, k_ctr, k_rc
string k_errore="0 "
date k_data
datetime k_datatime
string k_codice
long k_riga
//datawindowchild kdwc_cliente, kdwc_cliente_1, kdwc_cliente_2 
//kuf_base kuf1_base


//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
//if left(dati_modif(""), 1) = "1" then //Richisto Aggiornamento

//=== Controllo congruenza dei dati caricati e Aggiornamento  
//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
//===                : 2=errore non grave dati aggiornati;
//===			         : 3=LIBERO
//===      il resto della stringa contiene la descrizione dell'errore   
//	k_errore = aggiorna_dati()

//end if


if LeftA(k_errore, 1) = "0" then

//=== Pulizia dei campi
	attiva_tasti()

//=== Aggiunge una riga al data windows
//	choose case tab_1.selectedtab 
//		case  1 
	
			if tab_1.tabpage_1.dw_1.rowcount() = 0 then
//				tab_1.tabpage_1.dw_1.getchild("clienti_a_rag_soc_1", kdwc_cliente)
	
//				kdwc_cliente.settransobject(sqlca)
	
				k_riga = tab_1.tabpage_1.dw_1.insertrow(0)
			
//				tab_1.tabpage_1.dw_1.setitem(k_riga, "cod_sl_pt", "")
			
				tab_1.tabpage_1.dw_1.setcolumn(k_riga)
			else
				
				k_riga = tab_1.tabpage_1.dw_1.getrow()
//--- pulizia campi
				setnull(k_data)
				setnull(k_datatime)
				k_rc = tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode", "")
				k_rc = tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_data", k_data)
				k_rc = tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_data_stampa", k_data)
				k_rc = tab_1.tabpage_1.dw_1.setitem(k_riga, "pl_barcode", "")
				k_rc = tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_data_lav_ini", k_data)
				k_rc = tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_data_lav_fin", k_data)
				k_rc = tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_data_lav_ok", k_data)
				k_rc = tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_data_sosp", k_data)
				k_rc = tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_x_utente", "")
				k_rc = tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_x_datins", k_datatime)

			end if
			
			tab_1.tabpage_1.dw_1.SetItemStatus(k_riga, 0, Primary!, new!)


			
//		case 2 // dati listino
//			k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")
//////=== Riempe indirizzo di Spedizione da DW_1
////			if k_codice > 0 then
////				k_riga = tab_1.tabpage_2.dw_2.insertrow(0)
////	
////				tab_1.tabpage_2.dw_2.setitem(k_riga, "codice", k_codice)
////				tab_1.tabpage_2.dw_2.setitem(k_riga, "clie_3", k_codice)
////	
////				tab_1.tabpage_2.dw_2.scrolltorow(k_riga)
////				tab_1.tabpage_2.dw_2.setrow(k_riga)
////				tab_1.tabpage_2.dw_2.setcolumn(1)
////			end if
////			
////		case 3 // Listino
////			k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
////				 
////			if k_id_cliente > 0 and k_codice > 0 then
////				tab_1.tabpage_3.dw_3.Modify("codice.CheckBox.On='"+ &
////										string(k_codice, "#####")+"'")
////
//////=== Parametri : commessa, cliente, flag di rek commessa + altri prot non abbinati
////				if tab_1.tabpage_3.dw_3.retrieve(k_codice, k_id_cliente, 1) > 0 then
////					tab_1.tabpage_3.dw_3.scrolltorow(1)
////					tab_1.tabpage_3.dw_3.setrow(1)
////					tab_1.tabpage_3.dw_3.setcolumn(1)
//////=== Imposto il protocollo messo in testata
////					k_id_protocollo = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_protocollo")
////					if k_id_protocollo > 0 then 
////						k_ctr = tab_1.tabpage_3.dw_3.find("id_protocollo=" + &
////											string(k_id_protocollo, "#####"), 0, &
////											tab_1.tabpage_3.dw_3.rowcount())
////						if k_ctr > 0 then 
////							if tab_1.tabpage_3.dw_3.getitemnumber(k_ctr, "codice") = 0 or & 
////								isnull(tab_1.tabpage_3.dw_3.getitemnumber(k_ctr, "codice")) then 
////							
////								tab_1.tabpage_3.dw_3.setitem(k_ctr, "codice", k_codice)
////							end if
////						end if
////					end if
////
////				end if
////			end if
////
//			
//		case 4 
////			k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
//	
////			if k_codice > 0 then
////				k_riga = tab_1.tabpage_4.dw_4.insertrow(0)
////
////				tab_1.tabpage_4.dw_4.setitem(k_riga, "codice", k_codice)
////				tab_1.tabpage_4.dw_4.scrolltorow(k_riga)
////				tab_1.tabpage_4.dw_4.setrow(k_riga)
////				tab_1.tabpage_4.dw_4.setcolumn(1)
////
//////				if tab_1.tabpage_4.dw_41.rowcount() = 0 then
//////					k_riga = tab_1.tabpage_4.dw_41.insertrow(0)
//////
//////					tab_1.tabpage_4.dw_41.setitem(k_riga, "codice", k_codice)
//////					tab_1.tabpage_4.dw_41.scrolltorow(k_riga)
//////					tab_1.tabpage_4.dw_41.setrow(k_riga)
//////					tab_1.tabpage_4.dw_41.setcolumn(1)
//////				end if
////			end if
//			
////		case 5 // 
////			k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
////	
//////			if k_codice > 0 then
////				k_riga = tab_1.tabpage_4.dw_4.insertrow(0)
////
////				tab_1.tabpage_4.dw_4.setitem(k_riga, "codice", k_codice)
////				tab_1.tabpage_4.dw_4.scrolltorow(k_riga)
////				tab_1.tabpage_4.dw_4.setrow(k_riga)
////				tab_1.tabpage_4.dw_4.setcolumn(1)
////
//////				if tab_1.tabpage_4.dw_41.rowcount() = 0 then
//////					k_riga = tab_1.tabpage_4.dw_41.insertrow(0)
//////
//////					tab_1.tabpage_4.dw_41.setitem(k_riga, "codice", k_codice)
//////					tab_1.tabpage_4.dw_41.scrolltorow(k_riga)
//////					tab_1.tabpage_4.dw_41.setrow(k_riga)
//////					tab_1.tabpage_4.dw_41.setcolumn(1)
//////				end if
////			end if
//			
//	end choose	

	k_return = 0

end if

return (k_return)



end function

protected function string check_dati ();//
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
string k_key
int k_trovati=0
st_tab_barcode kst_tab_barcode, kst_tab_barcode_padre, kst_tab_barcode_figlio //, kst_tab_barcode_dosimetro
st_tab_meca_dosim kst_tab_meca_dosim
kuf_meca_dosim kuf1_meca_dosim
st_esito kst_esito



//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = 1

	k_key = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "barcode") 
	if isnull(k_key) or LenA(trim(k_key)) = 0 then
		k_return = tab_1.tabpage_1.text + ": Manca il Codice! " + "~n~r"
		k_errore = "3"
		k_nr_errori++
	end if
	if isnull( tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "barcode_data") ) then
		k_return = k_return + tab_1.tabpage_1.text + ": Manca la data! " + "~n~r"
		k_errore = "3"
		k_nr_errori++
	end if
	
//--- controllo Groupage	"PADRE NON CONSENTITO?"
	if LenA(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "barcode_lav"))) > 0 then
		kst_tab_barcode_padre.barcode = trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "barcode_lav"))
		kst_tab_barcode_figlio.fila_1 = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_1")
		kst_tab_barcode_figlio.fila_1p = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_1p")
		kst_tab_barcode_figlio.fila_2 = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_2")
		kst_tab_barcode_figlio.fila_2p = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_2p")
		try
//			kuf1_barcode = create kuf_barcode
			kiuf_barcode.if_isnull(kst_tab_barcode_padre)
			kiuf_barcode.if_isnull(kst_tab_barcode_figlio)

//--- piglia i dati del padre
			kiuf_barcode.get_barcode_dati_trattamento(kst_tab_barcode_padre)
			
			if not kiuf_barcode.if_essere_barcode_padre_con_giri_figlio(kst_tab_barcode_figlio, kst_tab_barcode_padre) then
				k_errore = "1"
				k_return = "Il barcode " + trim(kst_tab_barcode_padre.barcode) + " non può assumere il ruolo di Padre " + "~n~r" 
			end if
			
		catch (uo_exception kuo_exception)
			k_errore = "1"
			kst_esito = kuo_exception.get_st_esito()
			k_return = k_return + tab_1.tabpage_1.text + trim(kst_esito.sqlerrtext) + "~n~r" 
			kuo_exception.messaggio_utente()
			
//		finally 
//			destroy kuf1_barcode

		end try
	end if

//--- se il barcode è stato messo da NON TRATTARE allora rimuovere eventuali DOSIMETRI e GROUPAGE
	if k_errore = "0" or k_errore = "4" then
		kst_tab_barcode.barcode = tab_1.tabpage_1.dw_1.getitemstring(1, "barcode")
		kst_tab_barcode.causale = tab_1.tabpage_1.dw_1.getitemstring(1, "barcode_causale")

		if kist_tab_barcode_orig.barcode = kst_tab_barcode.barcode &
		        and kist_tab_barcode_orig.causale <> kst_tab_barcode.causale & 
				  and kst_tab_barcode.causale = kiuf_barcode.ki_causale_non_trattare then
			if tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "flg_dosimetro") = kiuf_barcode.ki_flg_dosimetro_SI then
					k_return = k_return + tab_1.tabpage_1.text + ": Sarà RIMOSSO il Dosimetro accoppiato a questo Barcode, inoltre rieseguire la stampa del barcode; " &
								  + "~n~r" 
					k_errore = "4"
					k_nr_errori++ 
			end if
			if tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "barcode_groupage") = kiuf_barcode.ki_barcode_groupage_si &
			       or trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "barcode_lav")) > " " then
					k_return = k_return + tab_1.tabpage_1.text + ": Questo Barcode sarà RIMOSSO dal GROUPAGE; " &
								  + "~n~r" 
					k_errore = "4"
					k_nr_errori++ 
			end if
		end if
	end if
	
	if k_errore = "0" or k_errore = "4" then
		try
			if kst_tab_barcode.causale = kiuf_barcode.ki_causale_non_trattare then
				kuf1_meca_dosim = create kuf_meca_dosim
//--- controlla barcode dosimetri
				kst_tab_meca_dosim.barcode_lav = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "barcode") 
				k_trovati = kuf1_meca_dosim.if_esiste_barcode_lav(kst_tab_meca_dosim)
				if tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "flg_dosimetro") = kiuf_barcode.ki_flg_dosimetro_SI then
					if k_trovati = 0 then
						k_return = k_return + tab_1.tabpage_1.text + ": Sarà generato un nuovo Dosimetro accoppiato al Barcode: " + trim(kst_tab_meca_dosim.barcode_lav) + ", poi rieseguire la stampa dei barcode; " &
									  + "~n~r" 
						k_errore = "4"
						k_nr_errori++ 
					end if
				else
					if k_trovati > 0 then
						k_return = k_return + tab_1.tabpage_1.text + ": Sarà RIMOSSO il Dosimetro accoppiato al Barcode: " + trim(kst_tab_meca_dosim.barcode_lav) + ", poi distruggere anche il cartaceo!!!; " &
									  + "~n~r" 
						k_errore = "4"
						k_nr_errori++ 
					end if
				end if
			end if
			
		catch (uo_exception kuo2_exception)
			k_errore = "1"
			kst_esito = kuo2_exception.get_st_esito()
			k_return = k_return + tab_1.tabpage_1.text + trim(kst_esito.sqlerrtext) + "~n~r" 
			kuo2_exception.messaggio_utente()
		finally
			if isvalid(kuf1_meca_dosim) then destroy kuf1_meca_dosim
		end try
		
	end if

	if k_errore = "0" or k_errore = "4" then
		if tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_1") > 0  &
			and tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_2") > 0 &
			then
			k_return = k_return + tab_1.tabpage_1.text + ": indicati giri per entrambe le File; " &
						  + "~n~r" 
			k_errore = "4"
			k_nr_errori++
		end if
	end if

	if k_errore = "0" or k_errore = "4" then
		if (tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_1") = 0  &
		   or isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_1")))   &
		   and  (tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_2") = 0 &
			 or isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_2"))) then
			k_return = k_return + tab_1.tabpage_1.text + ": nessun 'giro' di trattamento indicato; " &
			           + "~n~r" 
			k_errore = "4"
			k_nr_errori++
		end if
	end if

//	if k_errore = "0" then
//		if ( len(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "barcode_causale")) = 0  &
//		   or isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "barcode_causale")) )   &
//		   and (tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "barcode_data_lav_fin") > date(0)) then
//			k_return = k_return + tab_1.tabpage_1.text &
//						 + ": Barcode gia' trattato togliere la spunta al campo " &
//						 + trim(tab_1.tabpage_1.dw_1.describe ( "barcode_causale.name")) &
//		             + "~n~r" 
//			k_errore = "1"
//			k_nr_errori++
//		end if
//	end if

//
//=== Controllo altro tab
//	kuf1_barcode = create kuf_barcode
	k_nr_righe = tab_1.tabpage_2.dw_2.rowcount()
	if k_nr_righe > 0 then
		if LenA(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "barcode_lav"))) > 0 then
			k_return += "Presenza contemporanea di 'Padre' e 'Figli'. " + &
			string(k_riga, "#####") + " non permessa.~n~r" 
			k_errore = "1"
			k_nr_errori++
		end if
	end if
	
	if k_errore = "0" or k_errore = "4" then
		k_riga = tab_1.tabpage_1.dw_1.getrow()
	
		kst_tab_barcode_padre.barcode = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "barcode") 
		kst_tab_barcode_padre.fila_1 = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_1") 
		kst_tab_barcode_padre.fila_2 = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_2") 
		kst_tab_barcode_padre.fila_1p = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_1p") 
		kst_tab_barcode_padre.fila_2p = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_2p") 
	
		k_riga = 1
		do while k_riga <= tab_1.tabpage_2.dw_2.rowcount() and k_nr_errori < 10
	
			try 
				
				kst_tab_barcode_figlio.barcode = tab_1.tabpage_2.dw_2.getitemstring ( k_riga, "barcode") 
				
				if not kiuf_barcode.if_essere_barcode_figlio_g2(kst_tab_barcode_figlio, kst_tab_barcode_padre) then
						k_errore = "1"
						k_return = "Il barcode " + trim(kst_tab_barcode_figlio.barcode) + " non può assumere il ruolo di Figlio " + "~n~r" 
				end if
				
//				if kst_esito.esito <>  kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
//					k_return += "Errore in " + tab_1.tabpage_2.text + " alla riga " + &
//					string(k_riga, "#####") + ", " +trim(kst_esito.sqlerrtext)+".~n~r" 
//					k_errore = "1"
//					k_nr_errori++
//				end if
				
			catch (uo_exception kuo1_exception)
				kst_esito = kuo1_exception.get_st_esito() 
				k_return += "Errore in " + tab_1.tabpage_2.text + " alla riga " + &
				string(k_riga, "#####") + ", durante associazione figlio al Barcode "+ trim(kst_tab_barcode.barcode)+ ": ~n~r" + trim(kst_esito.sqlerrtext)+".~n~r" 
				k_errore = "1"
				k_nr_errori++
			end try
			
			k_riga++
			
		loop
//		destroy kuf1_barcode
	end if


return k_errore + k_return


end function

protected subroutine pulizia_righe ();//
long k_riga
long k_nr_righe
date k_data


tab_1.tabpage_1.dw_1.accepttext()
tab_1.tabpage_2.dw_2.accepttext()
tab_1.tabpage_3.dw_3.accepttext()
tab_1.tabpage_4.dw_4.accepttext()
tab_1.tabpage_5.dw_5.accepttext()
//tab_1.tabpage_4.dw_41.accepttext()

//=== Pulizia dei rek non validi sui vari TAB
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	for k_riga = k_nr_righe to 1 step -1
		if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) = newmodified!  &
		   or tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) = DataModified!	 then 
			if (isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "barcode")) or &
				 LenA(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "barcode"))) = 0) &
				then
		
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
				
			end if
		end if
		
	next

//	
//	k_nr_righe = tab_1.tabpage_2.dw_2.rowcount()
//	for k_riga = k_nr_righe to 1 step -1
//
//		if tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) = newmodified! then 
//			if (isnull(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "lav_interne")) or &
//				 tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "lav_interne") = 0) and &
//				(isnull(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "lav_esterne")) or &
//				 tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "lav_esterne") = 0) and &
//				(isnull(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "materiale")) or &
//				 tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "materiale") = 0) &
//				then
//		
//				tab_1.tabpage_2.dw_2.deleterow(k_riga)
//			end if
//		end if
//		
//	next
//
//
////	k_nr_righe = tab_1.tabpage_3.dw_3.rowcount()
////	for k_riga = k_nr_righe to 1 step -1
////		if tab_1.tabpage_3.dw_3.getitemstatus(k_riga, 0, primary!) = newmodified! then 
////		if (isnull(tab_1.tabpage_3.dw_3.getitemnumber ( k_riga, "id_commessa")) or &
////			 tab_1.tabpage_3.dw_3.getitemnumber ( k_riga, "id_commessa") = 0) &
////			then
////			tab_1.tabpage_3.dw_3.deleterow(k_riga)
////			//			tab_1.tabpage_3.dw_3.setitem(k_riga, "id_commessa", k_id_commessa)
////		end if
////	next
////
//
//	k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
//	for k_riga = k_nr_righe to 1 step -1
//
//		if tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) = newmodified! then 
//			if (isnull(tab_1.tabpage_4.dw_4.getitemstring ( k_riga, "id_fattura")) or &
//				 len(trim(tab_1.tabpage_4.dw_4.getitemstring ( k_riga, "id_fattura"))) = 0) &
//				then
//		
//				tab_1.tabpage_4.dw_4.deleterow(k_riga)
//			end if
//		end if
//		
//	next
//
////	k_nr_righe = tab_1.tabpage_4.dw_41.rowcount()
////	for k_riga = k_nr_righe to 1 step -1
////
////		if (isnull(tab_1.tabpage_4.dw_41.getitemstring ( k_riga, "commesse_note_at_note")) or &
////			 len(trim(tab_1.tabpage_4.dw_41.getitemstring ( k_riga, "commesse_note_at_note"))) = 0) &
////			then
////		
////			tab_1.tabpage_4.dw_41.deleterow(k_riga)
////		end if
////		
////	next
////

end subroutine

protected function integer cancella ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_desc, k_record, k_record_1, k_key = " "
long  k_nro=0, k_id_fase
string k_errore = "0 ", k_errore1 = "0 ", k_nro_fatt
long k_riga, k_seq
date k_data
kuf_barcode  kuf1_barcode
st_tab_barcode kst_tab_barcode
st_esito kst_esito


//=== 
choose case tab_1.selectedtab 
	case 1 
		k_record = " Barcode del Riferimento"
		k_riga = tab_1.tabpage_1.dw_1.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				
				k_key = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "barcode")
				k_desc = "Riferimento: " + string(tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_int"), "####0") &
				         + " del " + string(tab_1.tabpage_1.dw_1.getitemdate(k_riga, "barcode_data_int"), "dd.mm.yy") &
				         + " di " + trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "clienti_rag_soc_10")) 			
				if isnull(k_desc) = true or trim(k_desc) = "" then
					k_desc = "nessun Riferimento" 
				end if
				k_record_1 = &
					"Sei sicuro di voler eliminare il BARCODE~n~r" + &
					trim(k_key) +  &
					"~n~r" + trim(k_desc) + " ?"
				if messagebox("Elimina " + k_record, k_record_1, &
									question!, yesno!, 1) = 1 then

//=== Creo l'oggetto che ha la funzione x cancellare la tabella
					kuf1_barcode = create kuf_barcode
		
					kst_tab_barcode.barcode = trim(k_key)
//					k_errore = kuf1_barcode.tb_delete(kst_tab_barcode) 
					kst_esito = kuf1_barcode.tb_delete(kst_tab_barcode) 
					if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
						k_errore = "1"
					end if
					if LeftA(k_errore, 1) = "0" then

						tab_1.tabpage_1.dw_1.deleterow(k_riga)
						
						ki_esci_dopo_cancella = true    //chiude l'applicazione al termine della cancellazione
						
					end if			
					
					destroy kuf1_barcode
					
				else
					k_errore = "2"
				end if

					
			else
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
				ki_esci_dopo_cancella = true    //chiude l'applicazione al termine della cancellazione
			end if
		end if
	case 2
		k_record = " Figlio del Barcode "
		k_riga = tab_1.tabpage_2.dw_2.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> newmodified! then 

				tab_1.tabpage_2.dw_2.deleterow(k_riga)
				
//--- conta i figli rimasti				
				conta_figli()
				attiva_tasti()
			
			else
				tab_1.tabpage_2.dw_2.deleterow(k_riga)
			end if
		end if
end choose	


if LeftA(k_errore, 1) = "1" then
	k_return = 1
	k_errore1 = k_errore
//			k_errore = kGuf_data_base.db_rollback()

	messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
					MidA(k_errore1, 2) ) 	
	if LeftA(k_errore, 1) <> "0" then
		messagebox("Problemi durante il recupero dell'errore !!", &
			"Controllare i dati. " + MidA(k_errore, 2))
	end if

	attiva_tasti()


else
	if LeftA(k_errore, 1) = "2" then
	
		messagebox("Elimina" + k_record,  "Operazione Annullata !!")
		k_return = 2
	end if


end if


choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_1.dw_1.setfocus()
		tab_1.tabpage_1.dw_1.setcolumn(1)
	case 2
		if k_riga > 1 then
			if k_riga > tab_1.tabpage_2.dw_2.rowcount() then
				k_riga --
			end if
			k_riga = tab_1.tabpage_2.dw_2.u_selectrow_onclick(k_riga)
			if k_riga > 0 then tab_1.tabpage_2.dw_2.setrow(k_riga)
//			kGuf_data_base.dw_selectrow(tab_1.tabpage_2.dw_2, k_riga)
		else
			if tab_1.tabpage_2.dw_2.rowcount() > 0 then
				k_riga = tab_1.tabpage_2.dw_2.u_selectrow_onclick(0)
				if k_riga > 0 then tab_1.tabpage_2.dw_2.setrow(k_riga)
//				kGuf_data_base.dw_selectrow(tab_1.tabpage_2.dw_2, k_riga)
			end if
		end if
		tab_1.tabpage_2.dw_2.setfocus()
		tab_1.tabpage_2.dw_2.setcolumn(1)
end choose	


return k_return

end function

private function integer check_rek (string k_codice);//
int k_return
st_tab_barcode kst_tab_barcode


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

	kst_tab_barcode.barcode = trim (k_codice)
	if kiuf_barcode.if_barcode_exists(kst_tab_barcode) then

		if messagebox("Codice già caricato", & 
					"Vuoi modificare il BARCODE: " + trim(k_codice), question!, yesno!, 2) = 1 then
		
			ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
			ki_st_open_w.key1 = trim(k_codice) 

			tab_1.tabpage_1.dw_1.reset()
			inizializza()
			
		else
			
			k_return = 1

		end if
	end if  

	attiva_tasti()
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return


end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta, k_rcx
string k_stato = "0"
string  k_key
string k_fine_ciclo=""
int k_ctr=0, k_errore = 0
int k_err_ins, k_rc
st_tab_barcode kst_tab_barcode_vuoto
datawindowchild kdwc_barcode_figli_conta

//=== 
//tab_1.tabpage_4.dw_41.settransobject(sqlca)


if tab_1.tabpage_1.dw_1.rowcount() = 0 then

	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	k_key = trim(ki_st_open_w.key1)

	if LenA(k_key) = 0 then
		
//		cb_inserisci.postevent(clicked!)
		cb_ritorna.postevent(clicked!)
		tab_1.tabpage_1.dw_1.setfocus()

	else

		if k_scelta = kkg_flag_modalita.inserimento then
			messagebox("Operazione non consentita", &
				"Mi spiace ma non e' possibile inserire un BARCODE attraverso questa operazione! ~n~r"  &
						 )
			cb_ritorna.postevent(clicked!)
		else

			tab_1.tabpage_1.dw_1.getchild("barcode_figli_conta", kdwc_barcode_figli_conta)
			kdwc_barcode_figli_conta.settransobject(sqlca)
			if LenA(k_key) > 0 then
				if kdwc_barcode_figli_conta.rowcount() = 0 then
					kdwc_barcode_figli_conta.retrieve(k_key)
				end if
			else
				kdwc_barcode_figli_conta.insertrow(0)
			end if
	
			kist_tab_barcode_orig = kst_tab_barcode_vuoto

			k_rc = tab_1.tabpage_1.dw_1.retrieve(k_key) 
			
			choose case k_rc
	
				case is < 0				
					k_errore = 1
					messagebox("Operazione interrotta", &
						"Si e' verificato un errore interno al programma~n~r" + &
						"(Codice ricercato:" + trim(k_key) + ")~n~r" )
					cb_ritorna.postevent(clicked!)
					
	
				case 0
		
					tab_1.tabpage_1.dw_1.reset()
					attiva_tasti()
	
					if k_scelta <> kkg_flag_modalita.inserimento then
						k_errore = 1
						messagebox("Ricerca fallita", &
							"Il BARCODE ricercato non e' in Archivio ~n~r" + &
							"(Codice ricercato:" + trim(k_key) + ")~n~r" )
	
						cb_ritorna.postevent(clicked!)
						
					else
						k_err_ins = inserisci()
						tab_1.tabpage_1.dw_1.setfocus()
					end if
					
				case is > 0		
					kist_tab_barcode_orig.barcode = tab_1.tabpage_1.dw_1.getitemstring(1, "barcode")
					kist_tab_barcode_orig.causale = tab_1.tabpage_1.dw_1.getitemstring(1, "barcode_causale")
					
					if k_scelta = kkg_flag_modalita.inserimento then
						cb_inserisci.postevent(clicked!)
					end if

//--- Conta i figli associati al Barcode	
					conta_figli()	
					
					tab_1.tabpage_1.dw_1.setfocus()
					tab_1.tabpage_1.dw_1.setcolumn(1)
	
//--- Barcode ancora da Pianificare?
					ki_abilita_barcode_alla_modifica = not if_barcode_da_trattare()
		
					if ki_abilita_barcode_alla_modifica then
						
//--- sono abilitato a modificare i giri?
						abilita_modifica_giri()
						
//--- sono abilitato a fare la pianificazione lavorazione?
						abilita_pianificazione_trattamento ()
						
					else
						if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
							messagebox("Operazione non consentita", &
								"Il barcode " + trim(k_key) + " risulta già Trattato o in Pianificazione, è consentito solo la Visualizzazione")
						end if
						
						ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
						
					end if
					
					tab_1.tabpage_1.dw_1.resetUpdate() //--- resetta gli Stati dei campi a non modificati

					attiva_tasti()

			end choose
		end if			


	end if


else

end if


//===
//--- inabilito le mofidifiche sulla dw
if k_errore = 0 then
	
//--- Inabilita campi alla modifica se Vsualizzazione
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione &
		   or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.cancellazione then
		
		tab_1.tabpage_1.dw_1.u_proteggi_dw("1", 0)

//--- se arrivo da Modifica Programmazione Pilota abbiamo un'eccezione!!!!
		if ki_provenieneza_pilota_prg then
			tab_1.tabpage_1.dw_1.u_proteggi_dw("0", "b_barcode_figli")
		else
			tab_1.tabpage_1.dw_1.u_proteggi_dw("1", "b_barcode_figli")
		end if
		
   	tab_1.tabpage_5.dw_5.u_proteggi_dw("1", 0)
	else		

//--- S-protezione campi per riabilitare la modifica a parte la chiave
   	tab_1.tabpage_1.dw_1.u_proteggi_dw("0", 0)

//--- se barcode già con in Piano di Lavoro allora non posso cambiare il flag da trattare	
		if tab_1.tabpage_1.dw_1.rowcount() > 0 then
			if tab_1.tabpage_1.dw_1.getitemnumber(1, "pl_barcode") > 0 then
				tab_1.tabpage_1.dw_1.u_proteggi_dw("1", "barcode_causale") //proteggi campo
				tab_1.tabpage_1.dw_1.u_proteggi_dw("1", "flg_dosimetro") //proteggi campo
		   	tab_1.tabpage_5.dw_5.u_proteggi_dw("1", 0)
				k_rcx = tab_1.tabpage_1.dw_1.Modify("barcode_causale.Tooltip.Enabled=1 flg_dosimetro.Tooltip.Enabled=1")
				k_rcx = tab_1.tabpage_1.dw_1.Modify("barcode_causale.Tooltip.Tip='Già Pianificato, Non modificabile.' flg_dosimetro.Tooltip.Enabled=Tip='Già Pianificato, Non modificabile.'")
			end if
		end if
	end if
	
//--- se cancellazione
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then

		cb_cancella.postevent (clicked!)
		cb_ritorna.postevent(clicked!)
		
	end if
end if

return "0"

end function

protected subroutine attiva_menu ();//
//--- Aggiungi FIGLI	
	if m_main.m_strumenti.m_fin_gest_libero1.enabled <> ki_abilita_pianificazione_trattamento then
	
		m_main.m_strumenti.m_fin_gest_libero1.text = "&Aggiunge 'Figlio'"
		m_main.m_strumenti.m_fin_gest_libero1.microhelp = &
		"Inserisce un Barcode (figlio) nel pallet di trattamento  "
		m_main.m_strumenti.m_fin_gest_libero1.visible = true
		m_main.m_strumenti.m_fin_gest_libero1.enabled = ki_abilita_pianificazione_trattamento
		m_main.m_strumenti.m_fin_gest_libero1.toolbaritemtext = "+Figlio,"+&
												 m_main.m_strumenti.m_fin_gest_libero1.text
		m_main.m_strumenti.m_fin_gest_libero1.toolbaritemvisible = true
		m_main.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
		m_main.m_strumenti.m_fin_gest_libero1.toolbaritemname =  "Insert_2!"
	end if
	
//--- Modifica CICLI di Trattamento	
	//if m_main.m_strumenti.m_fin_gest_libero2.enabled <> ki_abilita_funzione_giri then
		if kiuf_barcode_mod_giri.ki_modifica_cicli_enabled = kiuf_barcode_mod_giri.ki_modifica_cicli_enabled_modif then
			m_main.m_strumenti.m_fin_gest_libero2.text = "Modifica &Cicli di Lavorazione"
			m_main.m_strumenti.m_fin_gest_libero2.microhelp = "Modifica i cicli di trattamento del Barcode/intero Lotto di Entrata   "
		else
			m_main.m_strumenti.m_fin_gest_libero2.text = "Visualizza &Cicli di Lavorazione"
			m_main.m_strumenti.m_fin_gest_libero2.microhelp = "Visualizza cicli di trattamento del Barcode/intero Lotto di Entrata   "
		end if
		m_main.m_strumenti.m_fin_gest_libero2.visible = true
		m_main.m_strumenti.m_fin_gest_libero2.enabled = true
		m_main.m_strumenti.m_fin_gest_libero2.toolbaritemtext = "Giri,"+&
												 m_main.m_strumenti.m_fin_gest_libero2.text
	//	ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex = 2
		m_main.m_strumenti.m_fin_gest_libero2.toolbaritemvisible = true
		m_main.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
		//ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemname = ki_path_risorse + "\cicli.bmp"
		m_main.m_strumenti.m_fin_gest_libero2.toolbaritemname = "cicli16.png"
	//end if

//--- Vedi LOG da TemporalTable
	m_main.m_strumenti.m_fin_gest_libero8.text = "Visualizza dati Storici del barcode (Log Trace)"
	m_main.m_strumenti.m_fin_gest_libero8.microhelp = "Visualizza dati Storici"
	m_main.m_strumenti.m_fin_gest_libero8.enabled = true
	m_main.m_strumenti.m_fin_gest_libero8.toolbaritemtext =  "Log,"+ m_main.m_strumenti.m_fin_gest_libero8.text
	m_main.m_strumenti.m_fin_gest_libero8.toolbaritemvisible = true
	m_main.m_strumenti.m_fin_gest_libero8.visible = true
	m_main.m_strumenti.m_fin_gest_libero8.toolbaritemname = "history16.png"

	super::attiva_menu()

	
end subroutine

private subroutine abilita_modifica_giri ();//
//--- controllo autorizzazione x cambio giri di lavorazione
//
				
			
	try
		
//		dw_modifica.kist_tab_barcode.barcode = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "barcode") )
//		dw_modifica.ki_modifica_giri_pianificati = kiuf_barcode_mod_giri.ki_modifica_giri_pianificati_no //--- non consento la modifica se barcode gia' pianificato e chiuso		
	
//		if ki_modifica_cicli_enabled = kiuf_barcode_mod_giri.ki_modifica_cicli_enabled_modif then
//		if ki_abilita_funzione_giri then
		if kiuf_barcode_mod_giri.autorizza_modifica_giri(kiuf_barcode_mod_giri.ki_modifica_giri_pianificati_no) &
			and (trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento &
						or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica) then
			kiuf_barcode_mod_giri.ki_modifica_cicli_enabled = kiuf_barcode_mod_giri.ki_modifica_cicli_enabled_modif
		else
			kiuf_barcode_mod_giri.ki_modifica_cicli_enabled = kiuf_barcode_mod_giri.ki_modifica_cicli_enabled_visualizzazione
		end if

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()			
		kiuf_barcode_mod_giri.ki_modifica_cicli_enabled = kiuf_barcode_mod_giri.ki_modifica_cicli_enabled_visualizzazione
		
	finally			
	end try
	
end subroutine

protected subroutine smista_funz (string k_par_in);//
//---
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===
uo_exception kuo1_exception

choose case LeftA(k_par_in, 2) 


//--- Personalizzo da qui

	case "l1"		//elenco dei barcode potenzialmente figli
		if ki_abilita_pianificazione_trattamento then
			call_elenco_barcode_figli_potenziali()   
		end if

	case "l2"		//modifica i cilci del riferimento
		modifica_giri()
		
//--- vedi LOG TRACE
	case kkg_flag_richiesta.libero8
		call_logtrace()	
		
	case else // standard
		super::smista_funz(k_par_in)
		
end choose


end subroutine

private subroutine abilita_pianificazione_trattamento ();//
//--- controllo Utente è autorizzato x Pianificare la lavorazione  
//
kuf_pl_barcode kuf1_pl_barcode
st_esito kst_esito

	kuf1_pl_barcode = create kuf_pl_barcode			
	
	kst_esito = kuf1_pl_barcode.if_utente_autorizzato()
	
	if kst_esito.esito = kkg_esito.ok then
		ki_abilita_pianificazione_trattamento = true
	else
		ki_abilita_pianificazione_trattamento = false
	end if
		
	destroy kuf1_pl_barcode

	
end subroutine

private subroutine aggiungi_barcode_padre (st_tab_barcode kst_tab_barcode);//---
//---   Aggiunge il Barcode padre su questo Barcode
//---
long k_riga


k_riga = tab_1.tabpage_1.dw_1.getrow()

if k_riga > 0 then
	tab_1.tabpage_1.dw_1.object.barcode_groupage[k_riga] = "S"
	tab_1.tabpage_1.dw_1.object.barcode_lav[k_riga] = kst_tab_barcode.barcode
end if

end subroutine

private subroutine aggiungi_barcode_figlio (st_tab_barcode kst_tab_barcode);//---
//---   Aggiunge il Barcode FIGLIO su questo Barcode
//---
long k_riga

try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
	kiuf_barcode.select_barcode(kst_tab_barcode)
	
	if tab_1.tabpage_2.dw_2.Find("barcode = '" + kst_tab_barcode.barcode+"' ", 1, tab_1.tabpage_2.dw_2.RowCount()) > 0 then
		
		kguo_exception.kist_esito.esito = kkg_esito.ko
		kguo_exception.setmessage( "Barcode Figlio gia' presente!")
		destroy kguo_exception
	
	else
		k_riga = tab_1.tabpage_2.dw_2.insertrow(0)
		
		if k_riga > 0 then
			tab_1.tabpage_2.dw_2.object.barcode_lav[k_riga] = tab_1.tabpage_1.dw_1.object.barcode[tab_1.tabpage_1.dw_1.getrow()] 
			tab_1.tabpage_2.dw_2.object.barcode[k_riga] = kst_tab_barcode.barcode
			tab_1.tabpage_2.dw_2.object.num_int[k_riga] = kst_tab_barcode.num_int
			tab_1.tabpage_2.dw_2.object.data_int[k_riga] = kst_tab_barcode.data_int
			tab_1.tabpage_2.dw_2.object.fila_1[k_riga] = string(kst_tab_barcode.fila_1) + ' + ' + string(kst_tab_barcode.fila_1p)
			tab_1.tabpage_2.dw_2.object.fila_2[k_riga] = string(kst_tab_barcode.fila_2) + ' + ' + string(kst_tab_barcode.fila_2p)
			tab_1.tabpage_2.dw_2.object.lav_fila_1[k_riga] = string(kst_tab_barcode.lav_fila_1) + ' + ' + string(kst_tab_barcode.lav_fila_1p)
			tab_1.tabpage_2.dw_2.object.lav_fila_2[k_riga] = string(kst_tab_barcode.lav_fila_2) + ' + ' + string(kst_tab_barcode.lav_fila_2p)
			
		end if
	
	//--- conta i figli rimasti				
		conta_figli()
		attiva_tasti()
		
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	SetPointer(kkg.pointer_default)

end try

end subroutine

private subroutine call_elenco_barcode_figli_potenziali ();//
//=== Elenco dei Barcode per associazione figli
//
int k_rc
date k_data, k_data_int
long  k_riga
st_tab_barcode kst_tab_barcode
st_esito kst_esito
window k_window
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window
kuf_barcode kuf1_barcode

	
	
//--- popolo il datasore (dw non visuale) per appoggio elenco
	if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore
	
	
	k_riga = tab_1.tabpage_1.dw_1.getrow()
	
	if k_riga > 0 then
		kdsi_elenco_output.dataobject = kuf1_barcode.kk_dw_nome_barcode_l_figli_potenziali
		k_rc = kdsi_elenco_output.settransobject ( sqlca )
		kst_tab_barcode.barcode_lav = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "barcode_lav")
		
		if LenA(trim(kst_tab_barcode.barcode_lav)) = 0 then
			kst_tab_barcode.barcode = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "barcode")
			kst_tab_barcode.fila_1 = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "barcode_fila_1")
			kst_tab_barcode.fila_2 = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "barcode_fila_2")
			kst_tab_barcode.fila_1p = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "barcode_fila_1p")
			kst_tab_barcode.fila_2p = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "barcode_fila_2p")
			if isnull(kst_tab_barcode.fila_1) then kst_tab_barcode.fila_1 = 0
			if isnull(kst_tab_barcode.fila_1p) then kst_tab_barcode.fila_1p = 0
			if isnull(kst_tab_barcode.fila_2) then kst_tab_barcode.fila_2 = 0
			if isnull(kst_tab_barcode.fila_2p) then kst_tab_barcode.fila_2p = 0
			k_rc = kdsi_elenco_output.retrieve(kst_tab_barcode.barcode, kst_tab_barcode.fila_1, kst_tab_barcode.fila_2, kst_tab_barcode.fila_1p, kst_tab_barcode.fila_2p)
			kst_open_w.key1 = "Elenco Barcode con uguale Trattamento, scegliere il 'Figlio'"  
		
						
			if kdsi_elenco_output.rowcount() > 0 then
		
				k_window = kGuf_data_base.prendi_win_attiva()
				
		//--- chiamare la window di elenco
		//
		//=== Parametri : 
		//=== struttura st_open_w
				kst_open_w.id_programma =kkg_id_programma.elenco
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
		else
			messagebox("Operazione non possibile", &
							"Prego, per inserire un 'Figlio' togliere il barcode 'Padre'. ")
		end if
	end if

//
end subroutine

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================
//---
//
string k_errore ="0 "
long k_riga=0
int k_rows, k_row
dwItemStatus kdwstatus_1
st_tab_barcode kst_tab_barcode
st_tab_meca_dosim kst_tab_meca_dosim
st_esito kst_esito
st_tab_g_0 kst_tab_g_0
st_tab_armo_campioni kst_tab_armo_campioni
kuf_armo_campioni kuf1_armo_campioni
kuf_meca_dosim kuf1_meca_dosim


try 

//=== Puntatore Cursore da attesa..... 
	SetPointer(kkg.pointer_attesa)

	kst_tab_barcode.barcode = trim(tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "barcode"))

//--- aggiorna eventuale barcode Campione accoppiandolo o disaccoppiandolo
	if kst_tab_barcode.barcode = kist_tab_armo_campioni.barcode_lav then // devo avere aperto la scheda dei Campioni
		kuf1_armo_campioni = create kuf_armo_campioni
		kst_tab_barcode.flg_campione = 0
		k_rows = tab_1.tabpage_5.dw_5.rowcount()
		for k_row = 1 to k_rows
			kst_tab_armo_campioni.id_armo_campione = tab_1.tabpage_5.dw_5.getitemnumber(k_row, "id_armo_campione") 
			if tab_1.tabpage_5.dw_5.getitemnumber(k_row, "k_associato") = 1 then 
				kst_tab_armo_campioni.barcode_lav = tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "barcode")
				kst_tab_barcode.flg_campione = 1   // attiva flag CAMPIONE sul Barcode
			else
				kst_tab_armo_campioni.barcode_lav = ""
			end if
			if kst_tab_armo_campioni.barcode_lav = tab_1.tabpage_5.dw_5.getitemstring( k_row, "barcode_lav") then
			else
				kst_tab_armo_campioni.st_tab_g_0.esegui_commit = "S"
				kuf1_armo_campioni.set_barcode_lav(kst_tab_armo_campioni)
			end if
		next
		tab_1.tabpage_1.dw_1.setitem(tab_1.tabpage_1.dw_1.getrow(), "flg_campione", kst_tab_barcode.flg_campione)  // toglie/mette il flag campione barcode
	//	kst_tab_barcode.id_meca = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id_meca") 
	//	kst_tab_g_0.esegui_commit = "S"
	//	kuf1_armo_campioni.u_genera_barcode_lotto(kst_tab_barcode.id_meca, kst_tab_g_0) // se non ci sono li genera
	end if
	
//=== Aggiorna, se modificato, la TAB_1	
	kst_esito = aggiorna_dw (tab_1.tabpage_1.dw_1, tab_1.tabpage_1.text)
	if kst_esito.esito <> kkg_esito.ok then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
//		if k_errore <> kkg_esito.db_ko then
//			k_errore = "2" 
//		else
//			k_errore = "1"
//		end if
//		k_errore += trim(kst_esito.sqlerrtext)
	end if

	//kguo_sqlca_db_magazzino.db_commit()  // forza COMMIT x evitare forse errore su TemporalTable

	kuf1_meca_dosim = create kuf_meca_dosim
			
//--- se BARCODE da NON TRATTARE allora lo rimuove dal GROUPAGE e anche il DOSIMETRO (eventuale)
	kst_tab_barcode.causale = tab_1.tabpage_1.dw_1.getitemstring(1, "barcode_causale")
	if kst_tab_barcode.causale = kiuf_barcode.ki_causale_non_trattare then
		
		kst_tab_barcode.st_tab_g_0.esegui_commit = "S"
		kiuf_barcode.tb_togli_figli_tutti(kst_tab_barcode)
		
		kst_tab_meca_dosim.st_tab_g_0.esegui_commit = "S"
		kst_tab_meca_dosim.barcode_lav = kst_tab_barcode.barcode
		//kst_tab_meca_dosim.barcode = ""  // reset del barcode dosimetro
		//kuf1_meca_dosim.set_barcode(kst_tab_meca_dosim)  // esegue il RESET del barcode dosimetro
		kuf1_meca_dosim.tb_delete_x_barcode_lav(kst_tab_meca_dosim)  // rimuove barcode dosimetro

	else

//--- se BARCODE da SENZA DOSIMETRO allora rimuove eventuali DOSIMETRI
		kst_tab_barcode.flg_dosimetro = tab_1.tabpage_1.dw_1.getitemstring(1, "flg_dosimetro")
		if kst_tab_barcode.flg_dosimetro = kiuf_barcode.ki_flg_dosimetro_si then
		else
			kst_tab_meca_dosim.st_tab_g_0.esegui_commit = "S"
			kst_tab_meca_dosim.barcode_lav = kst_tab_barcode.barcode
			kuf1_meca_dosim.tb_delete_x_barcode_lav(kst_tab_meca_dosim)  // rimuove barcode dosimetro
		end if

		kst_tab_barcode.barcode_lav = tab_1.tabpage_1.dw_1.getitemstring ( tab_1.tabpage_1.dw_1.getrow(), "barcode") 

//---- cancella eventuali nuovi figli	
		if tab_1.tabpage_2.dw_2.DeletedCount ( ) > 0 then
			
			k_riga = 1
			do while k_riga <= tab_1.tabpage_2.dw_2.DeletedCount()  and LeftA(k_errore,1) = "0" 
		
				kdwstatus_1 = tab_1.tabpage_2.dw_2.GetItemStatus(k_riga, 0, Delete!)
				if kdwstatus_1 = NotModified! or kdwstatus_1 = DataModified!	then
					kst_tab_barcode.barcode = tab_1.tabpage_2.dw_2.getitemstring ( k_riga, "barcode", delete!, true) 
					
					kst_tab_barcode.st_tab_g_0.esegui_commit =  "S"    //"N" x temporaltable
					kst_esito = kiuf_barcode.tb_togli_da_groupage(kst_tab_barcode)
					
					if kst_esito.esito = kkg_esito.ko or kst_esito.esito = kkg_esito.db_ko then
						k_errore = "1Errore in " + tab_1.tabpage_2.text + " alla riga " + &
									string(k_riga, "#####") + ", durante rimozione del Barcode figlio "+trim(kst_tab_barcode.barcode)+ ",~n~r" + trim(kst_esito.sqlerrtext) + ".~n~r" 
						kst_esito.sqlerrtext = mid(k_errore,2)
						kguo_exception.inizializza( )
						kguo_exception.set_esito(kst_esito)
						throw kguo_exception
					end if
				
				end if				
				k_riga++
				
			loop
			
		end if
		
//---- inserisce eventuali nuovi figli	
		k_riga = tab_1.tabpage_2.dw_2.GetNextModified(0, Primary!)
		do while k_riga <> 0  and LeftA(k_errore,1) = "0"//  tab_1.tabpage_2.dw_2.rowcount() and left(k_errore,1) = "0"
				
			kst_tab_barcode.barcode = tab_1.tabpage_2.dw_2.getitemstring ( k_riga, "barcode") 
			 
			kst_tab_barcode.st_tab_g_0.esegui_commit = "S"
			kst_esito = kiuf_barcode.tb_aggiungi_figlio(kst_tab_barcode)
			
			if kst_esito.esito = kkg_esito.ko or kst_esito.esito = kkg_esito.db_ko then
				k_errore = "1Errore in " + tab_1.tabpage_2.text + " alla riga " + &
						string(k_riga, "#####") + ", durante aggiornamento del Barcode figlio "+trim(kst_tab_barcode.barcode)+ ",~n~r" +trim(kst_esito.sqlerrtext)+".~n~r" 
				kst_esito.sqlerrtext = mid(k_errore,2)
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			
			k_riga = tab_1.tabpage_2.dw_2.GetNextModified(k_riga, Primary!)
			
		loop
			
	end if
		
//--- Genera/Rimuove barcode dosimetri
	kst_tab_meca_dosim.id_meca = tab_1.tabpage_1.dw_1.getitemnumber( tab_1.tabpage_1.dw_1.getrow(), "id_meca") 
	kst_tab_meca_dosim.barcode_lav = tab_1.tabpage_1.dw_1.getitemstring( tab_1.tabpage_1.dw_1.getrow(), "barcode") 
	kst_tab_meca_dosim.st_tab_g_0.esegui_commit = "S"
	kuf1_meca_dosim.u_genera_rimuove_barcode(kst_tab_meca_dosim)

//--- FINALMENTE COMMIT!
	kst_esito = kguo_sqlca_db_magazzino.db_commit()
		
	if kst_esito.esito = kkg_esito.db_ko then
		k_errore = "1Errore durante consolidamento (commit) dei dati del Barcode: " + kst_tab_barcode.barcode + " " + trim(kst_esito.sqlerrtext)+".~n~r" 
	else
			
//--- resetta gli Stati dei campi a non modificati
		tab_1.tabpage_1.dw_1.resetUpdate()
		tab_1.tabpage_2.dw_2.resetUpdate()
		tab_1.tabpage_5.dw_5.resetUpdate()
		
	end if

catch (uo_exception kuo1_exception)
	kuo1_exception.messaggio_utente()
	k_errore = "1" + trim(kst_esito.sqlerrtext)
	kguo_sqlca_db_magazzino.db_rollback()

//			kst_esito = kuo1_exception.get_st_esito() 
//			k_errore = "1Errore in '" + tab_1.tabpage_2.text + "' alla riga " + &
//			string(k_riga, "#####") + ", durante aggiornamento del Barcode "+ trim(kst_tab_barcode.barcode)+ ", " + trim(kst_esito.sqlerrtext)+".~n~r" 

finally
	if isvalid(kuf1_meca_dosim) then destroy kuf1_meca_dosim
	if isvalid(kuf1_armo_campioni) then destroy kuf1_armo_campioni
	
	SetPointer(kkg.pointer_default)
		
end try



return k_errore
end function

private subroutine call_elenco_barcode_padri_potenziali ();//
//=== Elenco dei Barcode per associazione figli
//
int k_rc
date k_data, k_data_int
long  k_riga
st_tab_barcode kst_tab_barcode
st_esito kst_esito
window k_window
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window
kuf_barcode kuf1_barcode


	k_riga = tab_1.tabpage_2.dw_2.rowcount()
	if k_riga = 0 then
	
//--- popolo il datasore (dw non visuale) per appoggio elenco
		if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore
		
		
		k_riga = tab_1.tabpage_1.dw_1.getrow()
		
		if k_riga > 0 then
	
			kdsi_elenco_output.dataobject = kuf1_barcode.kk_dw_nome_barcode_l_padri_potenziali
			k_rc = kdsi_elenco_output.settransobject ( sqlca )
			kst_tab_barcode.barcode = tab_1.tabpage_1.dw_1.getitemstring( k_riga, "barcode")
			kst_tab_barcode.fila_1 = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "barcode_fila_1")
			kst_tab_barcode.fila_2 = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "barcode_fila_2")
			kst_tab_barcode.fila_1p = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "barcode_fila_1p")
			kst_tab_barcode.fila_2p = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "barcode_fila_2p")
			if isnull(kst_tab_barcode.fila_1) then kst_tab_barcode.fila_1 = 0
			if isnull(kst_tab_barcode.fila_1p) then kst_tab_barcode.fila_1p = 0
			if isnull(kst_tab_barcode.fila_2) then kst_tab_barcode.fila_2 = 0
			if isnull(kst_tab_barcode.fila_2p) then kst_tab_barcode.fila_2p = 0
			k_rc = kdsi_elenco_output.retrieve(kst_tab_barcode.barcode, kst_tab_barcode.fila_1, kst_tab_barcode.fila_2, kst_tab_barcode.fila_1p, kst_tab_barcode.fila_2p)
			kst_open_w.key1 = "Elenco Barcode con uguale Trattamento, scegliere il 'Padre'  " 
	
						
			if kdsi_elenco_output.rowcount() > 0 then
		
				k_window = kGuf_data_base.prendi_win_attiva()
				
		//--- chiamare la window di elenco
		//
		//=== Parametri : 
		//=== struttura st_open_w
				kst_open_w.id_programma =kkg_id_programma.elenco
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
		end if
	else
				
		messagebox("Operazione non possibile", &
							"Sono già presenti 'Figli' per questo Barcode. ")
				
	end if
//
end subroutine

private subroutine conta_figli ();//
//--- Conta il numero figli associati 
//
long k_contati=0
kuf_barcode kuf1_barcode
st_tab_barcode kst_tab_barcode
st_esito kst_esito


if tab_1.tabpage_2.dw_2.rowcount() = 0 and tab_1.tabpage_2.dw_2.deletedcount( ) = 0 then
	try
		kuf1_barcode = create kuf_barcode			
		
		kst_tab_barcode.barcode = tab_1.tabpage_1.dw_1.object.barcode[tab_1.tabpage_1.dw_1.getrow()] 
		k_contati = kuf1_barcode.get_conta_figli(kst_tab_barcode)
		
	
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		k_contati = 0
		
	finally
		destroy kuf1_barcode
		
	end try
	
else
	k_contati = 	tab_1.tabpage_2.dw_2.rowcount()
end if

//--- aggiorna il contatore cosi' anche da peremmetere al programma di accorgersi che c'e' stato un cambiamento
if k_contati <> tab_1.tabpage_1.dw_1.object.barcode_figli_conta[tab_1.tabpage_1.dw_1.getrow()]  then
	tab_1.tabpage_1.dw_1.object.barcode_figli_conta[tab_1.tabpage_1.dw_1.getrow()] = 	k_contati
end if

	
	

end subroutine

protected subroutine open_start_window ();//
	ki_toolbar_window_presente=true

	kiuf_barcode = create kuf_barcode
	kiuf_barcode_mod_giri = create kuf_barcode_mod_giri

//--- flag di Provenienza da Modifica Programmazione G2 o G3
	kiuf_pilota_prg = create kuf_pilota_prg
	kiuf_pilota_prg_g3 = create kuf_pilota_prg_g3
	if trim(ki_st_open_w.id_programma_chiamante) = kiuf_pilota_prg_g3.get_id_programma(kkg_flag_modalita.modifica) &
							or trim(ki_st_open_w.id_programma_chiamante) = kiuf_pilota_prg.get_id_programma(kkg_flag_modalita.modifica) then
		ki_provenieneza_pilota_prg = true
	end if

end subroutine

protected function string dati_modif_figlio_inizio (string a_1);//
string k_return="0"


//--- salva la modalità 
	ki_flag_modalita_orig = ki_st_open_w.flag_modalita
	
//--- se arrivo da Modifica Programmazione Pilota abbiamo un'eccezione!!!!
	if ki_provenieneza_pilota_prg then

		ki_st_open_w.flag_modalita  = kkg_flag_modalita.modifica
	
	end if
	
return k_return
end function

protected subroutine dati_modif_figlio_fine (string a_1);

//--- ripristino modalita' origine
	ki_st_open_w.flag_modalita = ki_flag_modalita_orig


end subroutine

private function boolean if_barcode_da_trattare ();//
//--- controllo se Barcode già Pianificato 
//
boolean k_return=false
kuf_barcode kuf1_barcode
st_tab_barcode kst_tab_barcode


	try
		
		kuf1_barcode = create kuf_barcode			
		
		kst_tab_barcode.barcode = tab_1.tabpage_1.dw_1.object.barcode[1]
		k_return = kuf1_barcode.if_barcode_in_pl_chiuso(kst_tab_barcode)
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	finally
		destroy kuf1_barcode
		
	end try

return k_return
end function

protected subroutine inizializza_2 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_codice, k_codice_elenco = ""
string k_scelta
kuf_utility kuf1_utility



	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		k_codice = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "barcode")  )
		k_scelta = trim(ki_st_open_w.flag_modalita)

		if tab_1.tabpage_3.dw_3.rowcount() > 0 then

			k_codice_elenco = trim(tab_1.tabpage_3.dw_3.getitemstring(1, "barcode_lav"))

		end if
	
		if k_codice_elenco <> k_codice and tab_1.tabpage_3.dw_3.deletedcount( ) = 0 then 
			if tab_1.tabpage_3.dw_3.reset() > 0 then
				kuf1_utility = create kuf_utility
				kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_3.dw_3)
				if isvalid(kuf1_utility) then destroy kuf1_utility
			end if

//=== Retrive 
			tab_1.tabpage_3.dw_3.retrieve( k_codice )

		end if

		//attiva_tasti()

		tab_1.tabpage_3.dw_3.setfocus()
		
	end if
	
	tab_1.tabpage_3.dw_3.resetUpdate()



end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

long k_riga = 0
string k_codice = ""


super::attiva_tasti_0()

cb_ritorna.enabled = true
cb_ritorna.default = false
cb_inserisci.default = false
cb_aggiorna.default = false
cb_cancella.default = false

//--- inabilito le mofidifice sulla dw
//--- se arrivo da Modifica Programmazione Pilota abbiamo un'eccezione!!!!
if (ki_st_open_w.flag_modalita <> kkg_flag_modalita.inserimento and  ki_st_open_w.flag_modalita <> kkg_flag_modalita.modifica) &
	and ( isnull(ki_st_open_w.id_programma_chiamante) or not ki_provenieneza_pilota_prg)  then
	
	cb_inserisci.enabled = false
	cb_aggiorna.enabled = false
	cb_cancella.enabled = false

else
	
	cb_inserisci.enabled = false
	cb_aggiorna.enabled = true
	cb_cancella.enabled = true

//=== Nr righe ne DW lista
	choose case tab_1.selectedtab
		case 1
			k_riga = tab_1.tabpage_1.dw_1.getrow()
			if k_riga > 0 then
				k_codice = trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "barcode"))
			end if
			if k_riga <= 0 or LenA(k_codice) = 0 or isnull(k_codice) then
				cb_inserisci.enabled = false
				cb_inserisci.default = false
				cb_cancella.enabled = false
				cb_aggiorna.enabled = false
			end if
		case 2
			k_riga = tab_1.tabpage_2.dw_2.getrow()
			cb_inserisci.default = true
			if k_riga > 0 then
				k_codice = trim(tab_1.tabpage_2.dw_2.getitemstring(k_riga, "barcode"))
			end if
			if k_riga <= 0 or LenA(k_codice) = 0 or isnull(k_codice) then
//				cb_inserisci.enabled = false
//				cb_inserisci.default = false
				cb_cancella.enabled = false
//				cb_aggiorna.enabled = false
			end if
		case 3
				cb_cancella.enabled = false
				cb_inserisci.enabled = false
				cb_inserisci.default = false
				cb_aggiorna.enabled = false
		case 4
				cb_inserisci.enabled = false
				cb_inserisci.default = false
				cb_cancella.enabled = false
				cb_aggiorna.enabled = false
		case 5
				cb_inserisci.enabled = false
				cb_inserisci.default = false
				cb_aggiorna.enabled = false
				cb_aggiorna.enabled = false
	end choose

end if


end subroutine

private subroutine modifica_giri ();//
//--- k_modalita_modifica_file: 1=modalità modifica giri fila 1 e 2 
//
integer k_riga, k_rec
//string k_dw_fuoco_nome
//string k_aggiorna_rif //, k_modalita_modifica_file
//line kline_1
st_esito kst_esito
st_tab_barcode kst_tab_barcode
st_barcode_mod_giri kst_barcode_mod_giri


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.modifica &
				and ki_st_open_w.flag_modalita <> kkg_flag_modalita.inserimento then
		kiuf_barcode_mod_giri.ki_modifica_cicli_enabled = kiuf_barcode_mod_giri.ki_modifica_cicli_enabled_visualizzazione
	end if

	setnull(kidw_dett_0_da_non_modificare) 
	
	k_riga = tab_1.tabpage_1.dw_1.getrow() 
	if k_riga > 0 then		
		kst_tab_barcode.pl_barcode = 0
		kst_tab_barcode.barcode = tab_1.tabpage_1.dw_1.object.barcode.primary[k_riga]
		kiuf_barcode.select_barcode(kst_tab_barcode)
		kst_tab_barcode.num_int = kst_tab_barcode.num_int
		kst_tab_barcode.data_int = kst_tab_barcode.data_int
		kst_tab_barcode.fila_1 = tab_1.tabpage_1.dw_1.object.barcode_fila_1.primary[k_riga]
		kst_tab_barcode.fila_1p = tab_1.tabpage_1.dw_1.object.barcode_fila_1p.primary[k_riga]
		kst_tab_barcode.fila_2 = tab_1.tabpage_1.dw_1.object.barcode_fila_2.primary[k_riga]
		kst_tab_barcode.fila_2p = tab_1.tabpage_1.dw_1.object.barcode_fila_2p.primary[k_riga]
	end if	


	if k_riga > 0 then

		kidw_dett_0_da_non_modificare = create datawindow
		
		kidw_dett_0_da_non_modificare.reset()
		
		k_riga = tab_1.tabpage_1.dw_1.getrow()

		dw_modifica_giri_scambio.reset()
		k_rec = dw_modifica_giri_scambio.insertrow(0)
		dw_modifica_giri_scambio.object.barcode_fila_1[k_riga] = tab_1.tabpage_1.dw_1.object.barcode_fila_1p[k_riga]	
		dw_modifica_giri_scambio.object.barcode_fila_1p[k_riga] = tab_1.tabpage_1.dw_1.object.barcode_fila_1p[k_riga]	
		dw_modifica_giri_scambio.object.barcode_fila_2[k_riga] = tab_1.tabpage_1.dw_1.object.barcode_fila_2[k_riga]	
		dw_modifica_giri_scambio.object.barcode_fila_2p[k_riga] = tab_1.tabpage_1.dw_1.object.barcode_fila_2p[k_riga]	
		dw_modifica_giri_scambio.object.barcode_barcode[k_riga] = tab_1.tabpage_1.dw_1.object.barcode[k_riga]
		dw_modifica_giri_scambio.selectrow(k_riga, true)

		kst_tab_barcode.pl_barcode = 0
		kst_tab_barcode.id_meca = 0
		kst_tab_barcode.barcode = tab_1.tabpage_1.dw_1.object.barcode[k_riga]
		kst_tab_barcode.num_int = 0
		kst_tab_barcode.data_int = date(0)
		kst_tab_barcode.fila_1 = tab_1.tabpage_1.dw_1.object.barcode_fila_1[k_riga]	
		kst_tab_barcode.fila_1p = tab_1.tabpage_1.dw_1.object.barcode_fila_1p[k_riga]	
		kst_tab_barcode.fila_2 = tab_1.tabpage_1.dw_1.object.barcode_fila_2[k_riga]	
		kst_tab_barcode.fila_2p = tab_1.tabpage_1.dw_1.object.barcode_fila_2p[k_riga]	
		kst_barcode_mod_giri.ast_tab_barcode = kst_tab_barcode
		kst_barcode_mod_giri.a_modalita_modifica_file = kiuf_barcode_mod_giri.ki_modalita_modifica_giri_riga
		kst_barcode_mod_giri.a_modif_tutto_riferimento = kiuf_barcode_mod_giri.ki_modif_tutto_riferimento_no
		kst_barcode_mod_giri.adw_x_modifica_giri = dw_modifica_giri_scambio
		kst_barcode_mod_giri.adw_barcode_da_non_modificare = kidw_dett_0_da_non_modificare
		
		kiuf_barcode_mod_giri.u_open(kst_barcode_mod_giri)  // OPEN WINDOWS MODIFICA GIRI

	end if	
	
	
catch (uo_exception kuo_exception)
	messagebox("Modifica Cicli di Trattamento", &
						"Errore durante Ricerca del Barcode " + kkg.acapo + kuo_exception.kist_esito.sqlerrtext)
	
finally
	SetPointer(kkg.pointer_default)

end try	 


end subroutine

protected subroutine inizializza_3 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
//======================================================================
//
string k_codice, k_codice_elenco = ""
string k_scelta
//kuf_utility kuf1_utility



	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		k_codice = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "barcode")  )
		//k_scelta = trim(ki_st_open_w.flag_modalita)

		if tab_1.tabpage_4.dw_4.rowcount() > 0 then

			k_codice_elenco = trim(tab_1.tabpage_4.dw_4.getitemstring(1, "barcode"))

		end if
	
		if k_codice_elenco <> k_codice then 
//			if tab_1.tabpage_4.dw_4.reset() > 0 then
//				kuf1_utility = create kuf_utility
//				kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_4.dw_4)
//				if isvalid(kuf1_utility) then destroy kuf1_utility
//			end if

			tab_1.tabpage_4.dw_4.retrieve( k_codice )

		end if

		//attiva_tasti()

		tab_1.tabpage_4.dw_4.setfocus()
		
	end if
	
	tab_1.tabpage_4.dw_4.resetUpdate()



end subroutine

protected subroutine inizializza_4 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 5 controllandone i valori se gia' presenti
//======================================================================
//
string k_codice_elenco = ""
string k_scelta
kuf_utility kuf1_utility

try
	
	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		
		kist_tab_armo_campioni.barcode_lav = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "barcode")  )

		if tab_1.tabpage_5.dw_5.rowcount() > 0 then

			k_codice_elenco = trim(tab_1.tabpage_5.dw_5.getitemstring(1, "barcode"))

		end if
	
		if k_codice_elenco <> kist_tab_armo_campioni.barcode_lav then 

			tab_1.tabpage_5.dw_5.retrieve( kist_tab_armo_campioni.barcode_lav )

		end if

		tab_1.tabpage_5.dw_5.setfocus()

		if tab_1.tabpage_5.dw_5.rowcount( ) > 0 then
			tab_1.tabpage_5.dw_5.ki_flag_modalita = ki_st_open_w.flag_modalita
			
			kuf1_utility = create kuf_utility
			
			kuf1_utility.u_proteggi_sproteggi_dw(tab_1.tabpage_5.dw_5)
	
			if tab_1.tabpage_5.dw_5.ki_flag_modalita = kkg_flag_modalita.modifica then
	//--- se barcode già con in Piano di Lavoro allora non posso cambiare
				if tab_1.tabpage_1.dw_1.rowcount() > 0 then
					if tab_1.tabpage_1.dw_1.getitemnumber(1, "pl_barcode") > 0 then
						kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_5.dw_5)
					end if
				end if
			end if
		end if
		
	end if
	
	tab_1.tabpage_5.dw_5.resetUpdate()

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	if isvalid(kuf1_utility) then destroy kuf1_utility
	
end try
	
end subroutine

private subroutine call_logtrace ();//
//=== Open Window LogTrace MECA
long k_riga
st_tab_barcode kst_tab_barcode
st_open_w kst_open_w
kuf_logtrace_meca kuf1_logtrace_meca


try   
	k_riga = tab_1.tabpage_1.dw_1.getrow()
	if k_riga > 0 then

		kuf1_logtrace_meca = create kuf_logtrace_meca
	
		kst_tab_barcode.barcode = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "barcode" ))
			
		if kst_tab_barcode.barcode > " " then
			
			kst_open_w.key1 = trim(kst_tab_barcode.barcode)
			kst_open_w.key2 = kiuf_barcode.get_id_programma(kkg_flag_modalita.visualizzazione )
			kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
			kuf1_logtrace_meca.u_open(kst_open_w)  

		end if
	end if 
		
catch (uo_exception	kuo_exception)
	kuo_exception.messaggio_utente()
		
end try
	


end subroutine

on w_barcode.create
int iCurrent
call super::create
this.dw_modifica_giri_scambio=create dw_modifica_giri_scambio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_modifica_giri_scambio
end on

on w_barcode.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_modifica_giri_scambio)
end on

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
//
int k_return
int k_rc
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode


if isvalid(kst_open_w) then

//--- se ho chiuso una finestra di Elenco Valori
		if kst_open_w.id_programma = "elenco" and long(kst_open_w.key3) > 0 then

			if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore

			choose case kst_open_w.key2
					
				case "d_armo_elenco" 

//			if kst_open_w.key2 = "d_armo_elenco" and long(kst_open_w.key3) > 0 then
			
					kdsi_elenco_input = kst_open_w.key12_any 
				
					if kdsi_elenco_input.rowcount() > 0 then
						k_return = 1
			
						tab_1.tabpage_1.dw_1.setitem(1, "id_armo", &
										 kdsi_elenco_input.getitemnumber(long(kst_open_w.key3), "id_armo"))
						tab_1.tabpage_1.dw_1.setitem(1, "art", &
										 kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "art"))
						tab_1.tabpage_1.dw_1.setitem(1, "prodotti_des", &
										 kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "des"))
						tab_1.tabpage_1.dw_1.setitem(1, "armo_peso_kg", &
										 kdsi_elenco_input.getitemnumber(long(kst_open_w.key3), "peso_kg"))
						tab_1.tabpage_1.dw_1.setitem(1, "armo_larg_2", &
										 kdsi_elenco_input.getitemnumber(long(kst_open_w.key3), "armo_larg_2"))
						tab_1.tabpage_1.dw_1.setitem(1, "armo_lung_2", &
										 kdsi_elenco_input.getitemnumber(long(kst_open_w.key3), "armo_lung_2"))
						tab_1.tabpage_1.dw_1.setitem(1, "armo_alt_2", &
										 kdsi_elenco_input.getitemnumber(long(kst_open_w.key3), "armo_alt_2"))
						if isnull(tab_1.tabpage_1.dw_1.getitemnumber(1, "armo_dose")) &
							or tab_1.tabpage_1.dw_1.getitemnumber(1, "armo_dose") = 0 &
							then
							tab_1.tabpage_1.dw_1.setitem(1, "armo_dose", &
										 kdsi_elenco_input.getitemnumber(long(kst_open_w.key3), "dose"))
					
						end if
					end if

				case kuf1_barcode.kk_dw_nome_barcode_l_padri_potenziali
					kdsi_elenco_input = kst_open_w.key12_any 
				
					if kdsi_elenco_input.rowcount() > 0 then
						k_return = 1
						kst_tab_barcode.barcode = kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "barcode_padre")
						aggiungi_barcode_padre(kst_tab_barcode)
					end if

				case kuf1_barcode.kk_dw_nome_barcode_l_figli_potenziali
					kdsi_elenco_input = kst_open_w.key12_any 
				
					if kdsi_elenco_input.rowcount() > 0 then
						k_return = 1
						kst_tab_barcode.barcode = kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "barcode_figlio")
						if tab_1.selectedtab <> 2 then
							tab_1.selectedtab = 2
						end if
						aggiungi_barcode_figlio(kst_tab_barcode)
						
					end if
					
			end choose
					
		end if

end if

attiva_tasti( )

return k_return
end event

event open;call super::open;//

//--- path per reperire le ico del drag e drop
ki_path_risorse = kguo_path.get_risorse( )

end event

event close;call super::close;//
if isvalid(kiuf_barcode) then destroy kiuf_barcode
if isvalid(kiuf_barcode_mod_giri) then destroy kiuf_barcode_mod_giri

if isvalid(kiuf_pilota_prg) then destroy kiuf_pilota_prg
if isvalid(kiuf_pilota_prg_g3) then destroy kiuf_pilota_prg_g3

end event

type dw_print_0 from w_g_tab_3`dw_print_0 within w_barcode
end type

type st_ritorna from w_g_tab_3`st_ritorna within w_barcode
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_barcode
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_barcode
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_barcode
integer x = 2711
integer y = 1424
end type

type st_stampa from w_g_tab_3`st_stampa within w_barcode
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_barcode
integer x = 1152
integer y = 1440
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_barcode
integer x = 768
integer y = 1440
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_barcode
integer x = 1970
integer y = 1424
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_barcode
integer x = 2341
integer y = 1424
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_barcode
integer x = 1600
integer y = 1424
boolean enabled = false
end type

event cb_inserisci::clicked;//
//=== 
string k_errore="0"

//=== Nuovo Rekord
	choose case tab_1.selectedtab 
		case  2 
			if ki_abilita_pianificazione_trattamento then
				call_elenco_barcode_figli_potenziali()   
			end if
	
			
	end choose


end event

type tab_1 from w_g_tab_3`tab_1 within w_barcode
integer x = 0
integer y = 0
integer width = 2656
boolean fixedwidth = true
boolean powertips = true
end type

event tab_1::selectionchanged;call super::selectionchanged;//

if tab_1.tabpage_1.dw_1.rowcount() > 0 then
//--- Conta i figli associati al Barcode	
	conta_figli()	
end if

end event

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

event tab_1::u_constructor;//
							// 1     2     3     4     5      6     7      8      9   
ki_tabpage_enabled = {true, true, true, true, true, false, false, false, false} // disabilita alcune tabpage
super::event u_constructor( )

end event

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 2619
string text = "BARCODE"
string powertiptext = "dati barcode "
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer y = 16
integer width = 2967
integer height = 1180
string dataobject = "d_barcode"
boolean hsplitscroll = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_1::dragdrop;call super::dragdrop;////
//datawindow kdw_1
//long k_riga
//string k_nome
//st_tab_barcode kst_tab_barcode
//
//
//CHOOSE CASE TypeOf(source)
//
//	CASE datawindow!
//
//   		kdw_1 = source
//		kdw_1.Drag(cancel!)
// 
//		choose case kdw_1.classname()
//				
//			case kk_dw_nome_barcode_l_padri 
//				k_riga = kdw_1.getselectedrow( 0 )
//				if k_riga > 0 then
//					kst_tab_barcode.barcode = kdw_1.getitemstring( k_riga, "barcode_padre")
//					aggiungi_barcode_padre(kst_tab_barcode)
//				end if
//
//			case kk_dw_nome_barcode_l_figli_potenziali 
//				k_riga = kdw_1.getselectedrow( 0 )
//				if k_riga > 0 then
//					kst_tab_barcode.barcode = kdw_1.getitemstring( k_riga, "barcode_figlio")
////					aggiungi_barcode_figlio(kst_tab_barcode)
//				end if
//					
////			case "dw_groupage" 
////				aggiungi_barcode_singolo(dw_lista_0, dw_groupage)
////				
//		end choose
//		
//		
//END CHOOSE
//
end event

event dw_1::itemchanged;//
string k_codice
int k_errore=0


choose case dwo.name 
	case "barcode" 
      k_codice = upper(trim(data))
		if isnull(k_codice) = false and Len(trim(k_codice)) > 0 then

			k_errore = check_rek( k_codice ) 
			
		end if

//	case "barcode_groupage" 
//		post proteggi_barcode_lav()
//		
//	case "rag_soc_10" 
//		check_cliente()
//		k_errore = 1
end choose 

if k_errore = 1 then
	return 2
else
	post attiva_tasti()
end if
	
end event

event dw_1::clicked;//
//=== Premuto pulsante nella DW
//
int k_rc
//date k_data, k_data_int
long k_num_int, k_id
string k_cod_sl_pt
st_tab_barcode kst_tab_barcode
st_esito kst_esito
window k_window
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window
kuf_barcode_tree kuf1_barcode



choose case dwo.name 
				
	case "b_flg_dosimetro" 
		tab_1.selecttab(3)
		
	case "b_asdrackbarcode_1" 
		tab_1.selecttab(4)
		
	case "b_armo_colli_campioni_barcode_lav" 
		tab_1.selecttab(5)

	case "xb_barcode_lav" 
		call_elenco_barcode_padri_potenziali()			
		
	case "xb_barcode_figli" 
		call_elenco_barcode_figli_potenziali()			
		
	case "barcode_figli_t" 
		tab_1.selecttab(2)

	case "barcode_figli" 
	case "barcode_lav_t" 
		super::event clicked(xpos, ypos, row, dwo)

//	case "barcode_lav_t" 
//		tab_1.tabpage_1.dw_1.accepttext()
//		
//	//--- ricavo la data di partenza della lista
////			k_data = tab_1.tabpage_1.dw_1.getitemdate(row, "barcode_data")
////			k_data = RelativeDate ( k_data, -365 )
//		
//	//--- popolo il datasore (dw non visuale) per appoggio elenco
//		if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore
//	
//		kst_tab_barcode.barcode = this.getitemstring(this.getrow(), "barcode_lav")
//	
//		kuf1_barcode = create kuf_barcode_tree
//		kst_esito = kuf1_barcode.anteprima ( kdsi_elenco_output, kst_tab_barcode )
//		destroy kuf1_barcode
//		kst_open_w.key1 = "Dettaglio Barcode : " + trim(string(kst_tab_barcode.barcode,"@@@ @@@@@@@@@")) 
//						
//		if kdsi_elenco_output.rowcount() > 0 then
//	
//			k_window = kGuf_data_base.prendi_win_attiva()
//			kst_open_w.id_programma =kkg_id_programma_elenco
//			kst_open_w.flag_primo_giro = "S"
//			kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
//			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
//			kst_open_w.flag_leggi_dw = " "
//			kst_open_w.flag_cerca_in_lista = " "
//			kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
//			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
//			kst_open_w.key4 = k_window.title    //--- Titolo della Window di chiamata per riconoscerla
//			kst_open_w.key12_any = kdsi_elenco_output
//			kst_open_w.flag_where = " "
//			kuf1_menu_window = create kuf_menu_window 
//			kuf1_menu_window.open_w_tabelle(kst_open_w)
//			destroy kuf1_menu_window
//		end if	
		
	case else
		super::event clicked(xpos, ypos, row, dwo)
	
end choose


end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
integer x = 201
integer y = 1192
long backcolor = 255
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 2619
string text = "groupage"
string powertiptext = "barcode figli associati in groupage"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer y = 8
integer width = 2981
integer height = 1228
boolean enabled = true
string dataobject = "d_barcode_l_figli"
end type

event dw_2::clicked;call super::clicked;//					
//03.04.2008//--- e' tra i link standard ?
//try 
//	this.link_standard_call(dwo.name)
//catch ( uo_exception kuo_exception )
//	kuo_exception.messaggio_utente()
//end try	

	
				

end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer width = 2619
boolean enabled = true
string text = "dosimetri"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
integer width = 2866
integer height = 1232
boolean enabled = true
string dataobject = "d_meca_dosim_l_x_barcode_lav"
boolean ki_link_standard_sempre_possibile = true
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
integer width = 2619
boolean enabled = true
string text = "disp.ausiliari"
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
boolean enabled = true
string dataobject = "d_asdrackbarcode_l_x_barcode"
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
boolean visible = true
integer width = 2619
boolean enabled = true
string text = "Campioni"
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
integer width = 2935
integer height = 1172
boolean enabled = true
string dataobject = "d_armo_campioni_l_x_barcode"
boolean ki_link_standard_sempre_possibile = true
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
integer width = 2619
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 2619
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 2619
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 2619
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type st_duplica from w_g_tab_3`st_duplica within w_barcode
end type

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

type dw_modifica_giri_scambio from uo_dw_modifica_giri_barcode_scambio within w_barcode
integer x = 2254
integer y = 1988
integer width = 1001
integer height = 496
integer taborder = 40
boolean bringtotop = true
boolean hsplitscroll = false
boolean livescroll = false
end type

