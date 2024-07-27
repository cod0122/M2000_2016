$PBExportHeader$w_deposito_anag.srw
forward
global type w_deposito_anag from w_g_tab0
end type
end forward

global type w_deposito_anag from w_g_tab0
integer width = 3634
integer height = 2100
string title = "Elenco CO"
long backcolor = 32501743
string icon = "AppIcon!"
windowanimationstyle closeanimation = rightslide!
boolean ki_toolbar_window_presente = true
boolean ki_reset_dopo_save_ok = false
end type
global w_deposito_anag w_deposito_anag

type variables
//
private:
st_tab_deposito_anag kist_tab_deposito_anag_arg
kuf_deposito_anag kiuf_deposito_anag
end variables

forward prototypes
public function string inizializza ()
private function string cancella ()
protected function string check_dati ()
protected subroutine riempi_id ()
protected subroutine open_start_window ()
public subroutine legge_dwc ()
public subroutine posiziona_su_codice ()
public function integer u_retrieve_dw_lista () throws uo_exception
end prototypes

public function string inizializza ();//
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


try
	SetPointer(kkg.pointer_attesa )

	if dw_lista_0.rowcount() = 0 then
		k_rc = u_retrieve_dw_lista()
		if k_rc = 1 then
//			ki_st_tab_contratti_arg.id_deposito_anag = dw_lista_0.getitemnumber(1, "id_deposito_anag")
//			post posiziona_su_id_deposito_anag( )   // si posizione e apre il id_deposito_anag indicato
		end if

	end if

	if k_rc < 1 then
			
		k_return = "1Nessuna Anagrafica di Deposito Trovata "

	end if		

catch (uo_exception kuo_exception)		
	kuo_exception.messaggio_utente()
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return



end function

private function string cancella ();//
string k_return="0 "
st_tab_deposito_anag kst_tab_deposito_anag
string k_errore = "0 ", k_errore1 = "0 "
long k_riga


//=== Controllo se sul dettaglio c'e' qualche cosa
k_riga = dw_dett_0.rowcount()	
if k_riga > 0 then
	kst_tab_deposito_anag.id_deposito_anag = dw_dett_0.getitemnumber(1, "id_deposito_anag")
	kst_tab_deposito_anag.rag_soc_1 = dw_dett_0.getitemstring(1, "rag_soc_1")
end if
//=== Se sul dw non c'e' nessuna riga o nessun codice allora pesco dalla lista
if k_riga > 0 and kst_tab_deposito_anag.id_deposito_anag > 0 then
else
	k_riga = dw_lista_0.getselectedrow(0)	
	if k_riga > 0 then
		kst_tab_deposito_anag.id_deposito_anag = dw_lista_0.getitemnumber(k_riga, "id_deposito_anag")
		kst_tab_deposito_anag.rag_soc_1 = dw_lista_0.getitemstring(k_riga, "rag_soc_1")
	end if
end if

if trim(kst_tab_deposito_anag.rag_soc_1) > " " then
	kst_tab_deposito_anag.rag_soc_1 = "Anagrafica senza ragione sociale" 
end if

if k_riga > 0 and kst_tab_deposito_anag.id_deposito_anag > 0 then	
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina Anagrafica", "Sei sicuro di voler Cancellare la Anagrafica " + &
				string(kst_tab_deposito_anag.id_deposito_anag, "####0") + kkg.acapo + " " + trim(kst_tab_deposito_anag.rag_soc_1), &
				question!, yesno!, 2) = 1 then
		
//=== Cancella la riga dal data windows di lista
		try
			kiuf_deposito_anag.tb_delete(kst_tab_deposito_anag) 

			kGuf_data_base.db_commit()

//--- cancello riga a video
			kst_tab_deposito_anag.id_deposito_anag = 0
			k_riga = dw_dett_0.rowcount()	
			if k_riga > 0 then
				kst_tab_deposito_anag.id_deposito_anag = dw_dett_0.getitemnumber(1, "codice")
				dw_dett_0.deleterow(k_riga)
			end if
			if k_riga > 0 and kst_tab_deposito_anag.id_deposito_anag > 0 then
				k_riga = dw_lista_0.getselectedrow(0)	
				if k_riga > 0 then
					dw_lista_0.deleterow(k_riga)
				end if
			end if

			dw_dett_0.setfocus()

		catch (uo_exception kuo_exception)
			kuo_exception.scrivi_log()
			k_errore = "1" + kuo_exception.kist_esito.sqlerrtext
			kuo_exception.messaggio_utente( )

		end try
		attiva_tasti()
	
	else
		messagebox("Elimina Contratto", "Operazione Annullata !!")
	end if

	dw_dett_0.setcolumn(1)

end if

return(k_return)
end function

protected function string check_dati ();//
//=== Controllo dati inseriti
string k_return = ""
string k_errore = "0"
long k_riga
st_tab_deposito_anag kst_tab_deposito_anag


try
	setpointer(kkg.pointer_attesa)

	k_riga = dw_dett_0.getrow()

	if isnull(dw_dett_0.getitemstring ( k_riga, "rag_soc_1")) = true then
		k_return += "Manca il dato '" + trim(dw_dett_0.object.descr_t.text) + "' " + kkg.acapo 
		k_errore = "3"
	end if

//--- errori meno gravi
//   if trim(k_errore) = "0" then
//	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally
	setpointer(kkg.pointer_default)

end try

return trim(k_errore) + (k_return)


end function

protected subroutine riempi_id ();//
long k_riga=0


//--- Imposta valori di default
	k_riga = dw_dett_0.rowcount( )
	if k_riga > 0 then
		if dw_dett_0.getitemstring(k_riga, "deleted") > " " then
		else
			dw_dett_0.setitem(k_riga, "deleted", "N")
		end if
		dw_dett_0.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
		dw_dett_0.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
	end if


end subroutine

protected subroutine open_start_window ();//---
int k_rc


	kiuf_deposito_anag = create  kuf_deposito_anag
	
	SetPointer(kkg.pointer_attesa)

	if trim(ki_st_open_w.id_programma_chiamante) = kiuf_deposito_anag.get_id_programma(kkg_flag_modalita.elenco ) then
		
	else

//--- Salva Argomenti programma chiamante
		if isnumber(trim(ki_st_open_w.key1)) then // CODICE CLIENTE
			kist_tab_deposito_anag_arg.id_deposito_anag = long(trim(ki_st_open_w.key1))
		else
			kist_tab_deposito_anag_arg.id_deposito_anag = 0
		end if
		
	end if

	SetPointer(kkg.pointer_default)



end subroutine

public subroutine legge_dwc ();////--- legge i DWC presenti
//int k_rc=0
//datawindowchild  kdwc_clienti_des, kdwc_sc_cf_d, kdwc_sl_pt_d, kdwc_clienti 
//pointer oldpointer  // Declares a pointer variable
//
//
//
////=== Puntatore Cursore da attesa.....
//	oldpointer = SetPointer(HourGlass!)
//
//////--- Attivo dw archivio Clienti
////	k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_clienti_d)
////	k_rc = kdwc_clienti_d.settransobject(sqlca)
////	if kdwc_clienti_d.rowcount() < 2 then
////		kdwc_clienti_d.retrieve("%")
////		kdwc_clienti_d.insertrow(1)
////	end if
////--- Attivo dw archivio Clienti
//	k_rc = dw_dett_0.getchild("cod_cli", kdwc_clienti)
//	k_rc = kdwc_clienti.settransobject(sqlca)
//	k_rc = kdwc_clienti.insertrow(1)
//
//	k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_clienti_des)
//	k_rc = kdwc_clienti_des.settransobject(sqlca)
//	k_rc = kdwc_clienti_des.insertrow(1)
//
////	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
//		if kdwc_clienti.rowcount() < 2 then
//			kdwc_clienti.retrieve("%")
//			kdwc_clienti.RowsCopy(kdwc_clienti.GetRow(), kdwc_clienti.RowCount(), Primary!, kdwc_clienti_des, 1, Primary!)
//			kdwc_clienti.setsort( "id_cliente A")
//			kdwc_clienti.sort( )
//			k_rc = kdwc_clienti.insertrow(1)
//			k_rc = kdwc_clienti_des.insertrow(1)
//		end if
////	end if
//
//	
////--- Attivo dw archivio SC_CF
//	k_rc = dw_dett_0.getchild("sc_cf", kdwc_sc_cf_d)
//	k_rc = kdwc_sc_cf_d.settransobject(sqlca)
////	kdwc_sc_cf_d.reset() 
////--- Attivo dw archivio Capitolati
//	k_rc = dw_dett_0.getchild("sc_cf", kdwc_sc_cf_d)
//	if kdwc_sc_cf_d.rowcount() < 2 then
//		kdwc_sc_cf_d.retrieve(0, "S")
//		kdwc_sc_cf_d.insertrow(1)
//	end if
//
//
////--- Attivo dw archivio SL-PT
//	k_rc = dw_dett_0.getchild("sl_pt", kdwc_sl_pt_d)
//	k_rc = kdwc_sl_pt_d.settransobject(sqlca)
////	kdwc_sl_pt_d.reset()
////--- Attivo dw archivio PT
//	k_rc = dw_dett_0.getchild("sl_pt", kdwc_sl_pt_d)
//	if kdwc_sl_pt_d.rowcount() < 2 then
//		kdwc_sl_pt_d.retrieve()
//		kdwc_sl_pt_d.insertrow(1)
//	end if
//
//
////--- Attivo dw chiild NOTE etichette
//	k_rc = dw_dett_0.getchild("et_bcode_note", kdwc_sl_pt_d)
//	k_rc = kdwc_sl_pt_d.settransobject(sqlca)
//	kdwc_sl_pt_d.reset() 
//	kdwc_sl_pt_d.retrieve()
//	kdwc_sl_pt_d.insertrow(0)
//	
////--- Attivo dw child Descrizione
//	k_rc = dw_dett_0.getchild("descr", kdwc_sl_pt_d)
//	k_rc = kdwc_sl_pt_d.settransobject(sqlca)
//	kdwc_sl_pt_d.reset() 
//	kdwc_sl_pt_d.retrieve()
//	kdwc_sl_pt_d.insertrow(0)
//
////--- Attivo dw archivio CAUSALI
//	k_rc = dw_dett_0.getchild("id_meca_causale", kdwc_sl_pt_d)
//	k_rc = kdwc_sl_pt_d.settransobject(sqlca)
//	kdwc_sl_pt_d.reset() 
//	kdwc_sl_pt_d.retrieve()
//	kdwc_sl_pt_d.insertrow(1)
//	
//	SetPointer(oldpointer)
//	
//	
//
end subroutine

public subroutine posiziona_su_codice ();//
long k_riga


//--- se ho passato anche il id_deposito_anag contratto allora....
	k_riga = dw_lista_0.find( "id_deposito_anag = " + string(kist_tab_deposito_anag_arg.id_deposito_anag), 1, dw_lista_0.rowcount( ) )
	if k_riga > 0 then 
		dw_lista_0.selectrow( 0, false)
		dw_lista_0.setrow( k_riga)

//--- se entro per fare qls sulla riga allora....
		u_lancia_funzione_imvc(ki_st_open_w)	
		
		dw_lista_0.selectrow( k_riga, true)
		dw_lista_0.scrolltorow( k_riga)
		
	end if

end subroutine

public function integer u_retrieve_dw_lista () throws uo_exception;//---
//---  Fa la Retrieve
//---
long k_return
st_tab_contratti kst_tab_contratti


	
//	dw_lista_0.reset()
//	dw_lista_0.u_filtra_record("") 
	k_return = dw_lista_0.retrieve(kist_tab_deposito_anag_arg.id_deposito_anag)
	if k_return < 0 then
		kguo_exception.set_st_esito_err_dw(dw_lista_0, "Errore in lettura Anagrafiche per Deposito, id " + string(kist_tab_deposito_anag_arg.id_deposito_anag))
		throw kguo_exception
	end if

//--- seleziona almeno una riga
	if k_return > 0 then
		if dw_lista_0.getselectedrow(0) = 0 then
			if dw_lista_0.getrow() = 0 then
				dw_lista_0.setrow(1)
				dw_lista_0.selectrow( 1, true)
			else
				dw_lista_0.selectrow(dw_lista_0.getrow(), true)
			end if
		end if
		dw_lista_0.setfocus( )
	end if
	attiva_tasti( )
	
	
return k_return
	

end function

on w_deposito_anag.create
call super::create
end on

on w_deposito_anag.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_deposito_anag)  then destroy kiuf_deposito_anag


end event

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
int k_return
int k_rc


	if isvalid(kst_open_w) then

		if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore
		
		choose case kst_open_w.key2
			case kuf_ausiliari.kki_cap_l 
//--- Se dalla w di elenco non ho premuto un pulsante ma ad esempio doppio-click		
				if long(kst_open_w.key3) > 0 then
				
					kdsi_elenco_input = kst_open_w.key12_any 
				
					if kdsi_elenco_input.rowcount() > 0 then
						k_return = 1		
						dw_dett_0.setitem(1, "cap", kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "cap"))
						dw_dett_0.setitem(1, "loc", kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "localita"))
						dw_dett_0.setitem(1, "prov", kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "prov")) 
					end if
				end if

			case  kuf_ausiliari.kki_nazioni_l 
				if long(kst_open_w.key3) > 0 then

					kdsi_elenco_input = kst_open_w.key12_any 
					if kdsi_elenco_input.rowcount() > 0 then
						k_return = 1
						dw_dett_0.setitem(1, "id_nazione", kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "id_nazione"))
						dw_dett_0.setitem(1, "nome", trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "nome")))
						dw_dett_0.setitem(1, "area", trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "area")))
					end if
					
				end if				
				
		end choose 

	end if
	
	if k_return = 1 then
		attiva_tasti()
	end if
	
return k_return	
	

end event

type dw_print_0 from w_g_tab0`dw_print_0 within w_deposito_anag
end type

type st_ritorna from w_g_tab0`st_ritorna within w_deposito_anag
integer x = 2821
integer y = 980
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_deposito_anag
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_deposito_anag
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_deposito_anag
integer x = 2880
integer y = 1768
end type

type st_stampa from w_g_tab0`st_stampa within w_deposito_anag
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_deposito_anag
integer x = 2834
integer y = 1664
end type

type cb_modifica from w_g_tab0`cb_modifica within w_deposito_anag
integer x = 2926
integer y = 1240
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_deposito_anag
integer x = 2894
integer y = 1536
end type

type cb_cancella from w_g_tab0`cb_cancella within w_deposito_anag
integer x = 2880
integer y = 1384
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_deposito_anag
integer x = 2907
integer y = 1092
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_deposito_anag
integer x = 5
integer y = 792
integer width = 2784
integer height = 1148
boolean enabled = true
string dataobject = "d_deposito_anag"
boolean hsplitscroll = false
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_sort = false
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_deposito_anag
integer x = 0
integer y = 744
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_deposito_anag
integer y = 148
integer width = 3291
integer height = 732
string dataobject = "d_deposito_anag_l"
boolean ki_link_standard_sempre_possibile = true
end type

type dw_guida from w_g_tab0`dw_guida within w_deposito_anag
event u_put_codice ( string a_tipo,  string a_codice )
event u_clear ( )
event u_dwc_retrieve ( )
event type long u_get_id_cliente ( string a_dacercare )
integer x = 0
integer y = 0
integer width = 3342
integer height = 124
end type

type st_duplica from w_g_tab0`st_duplica within w_deposito_anag
end type

