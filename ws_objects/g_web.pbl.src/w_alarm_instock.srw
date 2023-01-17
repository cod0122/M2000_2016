$PBExportHeader$w_alarm_instock.srw
forward
global type w_alarm_instock from w_g_tab0
end type
end forward

global type w_alarm_instock from w_g_tab0
integer width = 2994
integer height = 1984
string title = ""
boolean maxbox = false
boolean ki_toolbar_window_presente = true
end type
global w_alarm_instock w_alarm_instock

type variables
//
private kuf_alarm_instock kiuf_alarm_instock
private st_tab_alarm_instock ki_st_tab_alarm_instock
private string ki_path_centrale =""


end variables

forward prototypes
public function string inizializza ()
private function string check_dati ()
private function string cancella ()
protected function integer visualizza ()
protected function integer inserisci ()
private function integer modifica ()
protected subroutine open_start_window ()
private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti)
public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti)
protected subroutine riempi_id ()
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
long k_riga
int k_importa = 0


//--- Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)
	
//--- Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then 

		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)

	end if
		
	
	if k_importa <= 0 then // Nessuna importazione eseguita


		if dw_lista_0.retrieve() < 1 then

			k_return = "1Avvisi non trovati "

			SetPointer(kkg.pointer_default)
			if ki_st_open_w.flag_primo_giro = "S" then 
				messagebox("Elenco Avvisi Vuota", "Nesun Codice Trovato per la richiesta fatta")
			end if
		else
			
			if ki_st_open_w.flag_primo_giro = "S" then 
				k_riga = 1
//--- se ho passato anche il ID allora....
				if ki_st_tab_alarm_instock.id_alarm_instock > 0 then
					k_riga = dw_lista_0.find( "id_alarm_instock = " + string(ki_st_tab_alarm_instock.id_alarm_instock) + " ", 1, dw_lista_0.rowcount( ) )
				end if
				if k_riga > 0 then 
					dw_lista_0.selectrow( 0, false)
					dw_lista_0.scrolltorow( k_riga)
					dw_lista_0.setrow( k_riga)
					dw_lista_0.selectrow( k_riga, true)
				end if
				
//--- se entro per modificare allora....
				if ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.modifica then 
					cb_modifica.postevent(clicked!)
				end if
			end if

		end if		
	end if

	attiva_tasti()
	
	SetPointer(kkg.pointer_default)
	
return k_return



end function

private function string check_dati ();//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===                : 3=dati insufficienti; 4=OK con errori non gravi
//===                      : 5=OK con avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
//=== Controllo dati inseriti
string k_return = ""
string k_errore = "0"
int k_rc=0
long k_riga
string k_descr=""
kuf_email kuf1_email
st_tab_alarm_instock kst_tab_alarm_instock
st_email_address kst_email_address
st_esito kst_esito

		
   k_riga = dw_dett_0.getrow()

   kst_tab_alarm_instock.email = dw_dett_0.getitemstring ( k_riga, "email") 
   if trim(kst_tab_alarm_instock.email) > " " then
		
//--- Controllo sintassi Indirizzi email				
		kst_email_address.email_all = kst_tab_alarm_instock.email
		if len(trim(kst_email_address.email_all)) > 0 then
			try
				kuf1_email = create kuf_email
				if kuf1_email.get_email_from_string(kst_email_address) > 0 then
					dw_dett_0.setitem(k_riga, "email", kst_email_address.email_all)
				end if
			catch (uo_exception kuo_exception)
				kst_esito = kuo_exception.get_st_esito()
				k_return = trim(k_return) + "Indirizzo email non corretto: " &
				+"~n~r" + kst_esito.sqlerrtext + "~n~r" 
				k_errore = "4"
			finally 
				if isvalid(kuf1_email) then destroy kuf1_email
			end try
		end if

	else
	   kst_tab_alarm_instock.sr_settore = dw_dett_0.getitemstring ( k_riga, "sr_settore") 
  	 	if trim(kst_tab_alarm_instock.sr_settore) > " " then
		else
      	k_return = k_return + "Indicare indirizzo/i email o il Settore" + "~n~r"
      	k_errore = "3"
		end if
   end if

   
//--- errori diversi
   if trim(k_errore) = "0" or trim(k_errore) = "4"  or trim(k_errore) = "5" then
      if trim(dw_dett_0.getitemstring ( 1, "des")) > " " then 
		else
         k_return = k_return + "Manca la descrizione " + "~n~r" 
         k_errore = "3"
      end if
      if dw_dett_0.getitemnumber(1, "id_email_funzione") > 0 or trim(dw_dett_0.getitemstring(1, "lettera")) > " " then 
		else
         k_return = k_return + "Indicare il collegamento al Prototipo o compilare il corpo della Lettera della Comunicazione " + "~n~r" 
         k_errore = "3"
      end if
   end if


return trim(k_errore) + trim(k_return)


end function

private function string cancella ();//
//--- Cancellazione rekord dal DB
//--- Ritorna : "0"=OK "1...."=KO 
//
string k_return=""
string k_errore = "0 "
long k_riga
string k_descr
string k_codice
st_tab_alarm_instock kst_tab_alarm_instock
st_esito kst_esito


//=== Controllo se sul dettaglio c'e' qualche cosa
if dw_dett_0.visible and dw_dett_0.rowcount() > 0 then
	k_riga = 1
	k_codice = string(dw_dett_0.getitemnumber(1, "id_alarm_instock"))
	k_descr = trim(dw_dett_0.getitemstring(1, "des"))
	kst_tab_alarm_instock.id_alarm_instock = dw_dett_0.getitemnumber(1, "id_alarm_instock") 
else
//=== Se sul dw non c'e' nessuna riga o nessun codice allora pesco dalla lista
	k_riga = dw_lista_0.getselectedrow(0)	
	if k_riga > 0 then
		k_codice = string(dw_lista_0.getitemnumber(k_riga, "id_alarm_instock"))
		k_descr = trim(dw_lista_0.getitemstring(k_riga, "des"))
		kst_tab_alarm_instock.id_alarm_instock = dw_lista_0.getitemnumber(k_riga, "id_alarm_instock") 
	end if
end if

if isnull(k_codice) then
	k_codice = ". "
end if
if isnull(k_descr) = true or trim(k_descr) = "" then
	k_descr = "Avviso senza descrizione" 
end if

if k_riga > 0 and isnull(k_codice) = false then	
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina "  + this.title , "Sei sicuro di voler Cancellare : ~n~r" &
	             + trim(k_codice) + " " + trim(k_descr), &
				question!, yesno!, 2) = 1 then
 
		
//=== Cancella la riga dal data windows di lista
		try
			kiuf_alarm_instock.tb_delete(kst_tab_alarm_instock) 

//--- cancello riga a video
			k_codice = " "
			if dw_dett_0.visible and dw_dett_0.rowcount() > 0 then
				k_codice = string(dw_dett_0.getitemnumber(1, "id_alarm_instock"))
				dw_dett_0.deleterow(1)
			else
				if k_riga > 0 then
					dw_lista_0.deleterow(k_riga)
				end if
			end if

		catch (uo_exception kuo_exception)
			kguo_sqlca_db_magazzino.db_rollback()
			kst_esito = kuo_exception.get_st_esito()
			k_errore  = "1" + kst_esito.sqlerrtext
			//messagebox("Problemi durante Cancellazione", MidA(k_errore, 2) ) 	
			
		finally
//			dw_dett_0.setfocus()

		end try
				

		attiva_tasti()

	else
		messagebox("Elimina " + this.title , "Operazione Annullata !!")
	end if

	//dw_dett_0.setcolumn(1)

end if

k_return = k_errore

return(k_return)


end function

protected function integer visualizza ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return
long k_key
kuf_utility kuf1_utility


	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_alarm_instock")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione

	k_return = dw_dett_0.retrieve( k_key ) 

//
//--- protezione campi per impedire la modifica
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
	kuf1_utility.u_proteggi_dw("1", "sr_settore_1", dw_dett_0)
	kuf1_utility.u_proteggi_dw("1", "id_email_funzione", dw_dett_0)
	destroy kuf1_utility

	attiva_tasti()

return k_return

end function

protected function integer inserisci ();//
kuf_utility kuf1_utility



	ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento 

	dw_dett_0.reset()
	dw_dett_0.insertrow(0)
	
	dw_dett_0.setitem(dw_dett_0.getrow(), "id_alarm_instock", 0 )
	dw_dett_0.setitem(dw_dett_0.getrow(), "attivo", kiuf_alarm_instock.kki_attivo_si )

	dw_dett_0.setcolumn(1)
	
//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
	kuf1_utility.u_proteggi_dw("0", "sr_settore_1", dw_dett_0)
	kuf1_utility.u_proteggi_dw("0", "id_email_funzione", dw_dett_0)
	destroy kuf1_utility  

	attiva_tasti()

//=== Posiziona il cursore sul Data Windows
	dw_dett_0.ResetUpdate ( ) 
	dw_dett_0.setfocus() 


return (0)


end function

private function integer modifica ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return
long k_key
kuf_utility kuf1_utility


	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_alarm_instock")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 

	k_return = dw_dett_0.retrieve( k_key ) 

//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
	kuf1_utility.u_proteggi_dw("0", "sr_settore_1", dw_dett_0)
	kuf1_utility.u_proteggi_dw("0", "id_email_funzione", dw_dett_0)

////--- Inabilita campo per la modifica se Funzione MODIFICA
//	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
//		kuf1_utility.u_proteggi_dw("1", 1, dw_dett_0)
//	end if


	attiva_tasti()

//=== Posiziona il cursore sul Data Windows
	dw_dett_0.SetColumn(1)
	dw_dett_0.ResetUpdate ( ) 
	dw_dett_0.setfocus() 


return k_return

end function

protected subroutine open_start_window ();//---
string k_esito
datawindowchild kdwc_1


	kiuf_alarm_instock = create kuf_alarm_instock

//--- Salva Argomenti programma chiamante
	if Len(trim(ki_st_open_w.key1)) = 0 then // ID su cui posizionarsi
		ki_st_tab_alarm_instock.id_alarm_instock = 0
	else
		ki_st_tab_alarm_instock.id_alarm_instock = long(trim(ki_st_open_w.key1))
	end if
	if Len(trim(ki_st_open_w.key2)) = 0 or isnull(trim(ki_st_open_w.key2)) then  // Indirizzo E-Mail 
		ki_st_tab_alarm_instock.email = ""
	else
		ki_st_tab_alarm_instock.email  = trim(ki_st_open_w.key2)
	end if


	if dw_dett_0.getchild("sr_settore_1", kdwc_1) = 1 then
		kdwc_1.settransobject(kguo_sqlca_db_magazzino)
		kdwc_1.retrieve( )
		kdwc_1.insertrow(1)
	end if
	
end subroutine

private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente 
//


dw_dett_0.modify( "id_cliente.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
dw_dett_0.modify( "rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 

dw_dett_0.setitem( 1, "id_cliente", kst_tab_clienti.codice)
dw_dett_0.setitem( 1, "rag_soc_10", kst_tab_clienti.rag_soc_10 )

//attiva_tasti()


end subroutine

public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti);//
boolean k_return = false
st_esito kst_esito
kuf_clienti kuf1_clienti


try
	
	kuf1_clienti = create kuf_clienti

	k_return = kuf1_clienti.leggi (kst_tab_clienti)

	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	

finally
	destroy kuf1_clienti
	
end try

return k_return


end function

protected subroutine riempi_id ();//
if dw_dett_0.rowcount() > 0 then
	if dw_dett_0.rowcount() > 0 then
		dw_dett_0.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins())
		dw_dett_0.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente())
	end if
	if dw_dett_0.getitemstring(1, "sr_settore") > " " then
	else
		dw_dett_0.setitem(1, "sr_settore", "")
	end if
	if dw_dett_0.getitemnumber(1, "id_cliente") > 0 then
	else
		dw_dett_0.setitem(1, "id_cliente", 0)
	end if
		if dw_dett_0.getitemnumber(1, "contratto") > 0 then
	else
		dw_dett_0.setitem(1, "contratto", 0)
	end if
end if

end subroutine

on w_alarm_instock.create
call super::create
end on

on w_alarm_instock.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_alarm_instock) then destroy kiuf_alarm_instock

end event

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
int k_return
long k_riga_zoom
string k_email_add, k_email
st_esito kst_esito
st_tab_cond_fatt  kst_tab_cond_fatt 
st_tab_clienti kst_tab_clienti
kuf_clienti kuf1_clienti
kuf_contratti kuf1_contratti


if isvalid(kst_open_w) then

//--- Dalla finestra di Elenco Valori
	if kst_open_w.id_programma = kkg_id_programma_elenco then
	
		if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore
	
		kdsi_elenco_input = kst_open_w.key12_any 
	
		k_riga_zoom = 0
		if isnumber(kst_open_w.key3) then k_riga_zoom = long(kst_open_w.key3)

		if kdsi_elenco_input.rowcount() > 0 and k_riga_zoom > 0 &
			and (ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento &
						or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica) then
						
			k_return = 1
			
			choose case kst_open_w.key6 //kst_open_w.key2 

				case "b_clienti" //kuf1_clienti.kki_anteprima_clienti_l    //se da zoom Anagrafiche clienti...
	
					ki_st_tab_alarm_instock.id_cliente = kdsi_elenco_input.getitemnumber(k_riga_zoom, "id_cliente")
		
					if ki_st_tab_alarm_instock.id_cliente > 0 then
						dw_dett_0.setitem( 1, "id_cliente", ki_st_tab_alarm_instock.id_cliente)
						dw_dett_0.setitem( 1, "rag_soc_10", kdsi_elenco_input.getitemstring(k_riga_zoom, "rag_soc_1"))
					else			
						dw_dett_0.setitem( 1, "id_cliente", 0)
						dw_dett_0.setitem( 1, "rag_soc_10", "")
					end if
					
				case "b_contratti_l" //kuf1_contratti.kki_anteprima_contratti_l    //se da zoom Contratti CO...
					ki_st_tab_alarm_instock.contratto = kdsi_elenco_input.getitemnumber(k_riga_zoom, "codice")
		
					if ki_st_tab_alarm_instock.contratto > 0 then
						dw_dett_0.setitem( 1, "contratto", ki_st_tab_alarm_instock.contratto)
						dw_dett_0.setitem( 1, "mc_co", kdsi_elenco_input.getitemstring(k_riga_zoom, "mc_co"))
						dw_dett_0.setitem( 1, "contratti_descr", kdsi_elenco_input.getitemstring(k_riga_zoom, "descr"))
						if dw_dett_0.getitemnumber(1, "id_cliente") > 0 then
						else
							ki_st_tab_alarm_instock.id_cliente = kdsi_elenco_input.getitemnumber(k_riga_zoom, "cod_cli")
							dw_dett_0.setitem( 1, "id_cliente", ki_st_tab_alarm_instock.id_cliente)
							dw_dett_0.setitem( 1, "rag_soc_10", kdsi_elenco_input.getitemstring(k_riga_zoom, "rag_soc_10"))
						end if
					else			
						dw_dett_0.setitem( 1, "contratto", 0)
						dw_dett_0.setitem( 1, "mc_co", "")
						dw_dett_0.setitem( 1, "contratti_descr", "")
					end if
					
				case "b_email_rubrica"  // rubrica indirizzi email
					k_email_add = trim(kdsi_elenco_input.getitemstring(k_riga_zoom, "email"))  + ","
					k_email = trim(dw_dett_0.getitemstring( 1, "email"))
					if right(k_email,1) = ";" or right(k_email,1) = "," then
						k_email += k_email_add
					else
						k_email += "," + k_email_add
					end if
					dw_dett_0.setitem( 1, "email", k_email)
					
			end choose
			attiva_tasti()
							
		end if

	end if

end if

return k_return


end event

type dw_print_0 from w_g_tab0`dw_print_0 within w_alarm_instock
end type

type st_ritorna from w_g_tab0`st_ritorna within w_alarm_instock
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_alarm_instock
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_alarm_instock
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_alarm_instock
integer x = 2350
integer y = 1348
end type

type st_stampa from w_g_tab0`st_stampa within w_alarm_instock
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_alarm_instock
integer x = 2350
integer y = 656
end type

type cb_modifica from w_g_tab0`cb_modifica within w_alarm_instock
integer x = 2350
integer y = 908
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_alarm_instock
integer x = 2350
integer y = 1200
end type

type cb_cancella from w_g_tab0`cb_cancella within w_alarm_instock
integer x = 2350
integer y = 1052
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_alarm_instock
integer x = 2350
integer y = 768
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_alarm_instock
integer y = 1032
integer width = 2747
integer height = 688
boolean enabled = true
string dataobject = "d_alarm_instock"
boolean border = true
string icon = "AppIcon!"
borderstyle borderstyle = styleraised!
boolean ki_link_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
end type

event dw_dett_0::itemchanged;call super::itemchanged;////
//int k_errore=0
//long k_riga, k_rc
//st_esito kst_esito
//st_tab_clienti kst_tab_clienti
//datawindowchild kdwc_1
//
//
//
//choose case 	lower(dwo.name)
//
//
//	case "rag_soc_10" 
//		if len(trim(data)) > 0 then 
//			dw_dett_0.getchild(dwo.name, kdwc_1)
//			k_riga = kdwc_1.find( "rag_soc_1 like '" + trim(data) + "%" +"'" , 1, kdwc_1.rowcount())
//			if k_riga > 0 then
//				kst_tab_clienti.codice = kdwc_1.getitemnumber( k_riga, "id_cliente")
//				get_dati_cliente(kst_tab_clienti)
//				post put_video_cliente(kst_tab_clienti)
//			else
//				dw_dett_0.object.id_cliente[1] = 0
//				dw_dett_0.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
//			end if
//		else
//			set_iniz_dati_cliente(kst_tab_clienti)
//			post put_video_cliente(kst_tab_clienti)
//		end if
//
//	case "id_cliente" 
//		if len(trim(data)) > 0 then 
//			dw_dett_0.getchild(dwo.name, kdwc_1)
//			k_riga = kdwc_1.find( "id_cliente = " + trim(data) + " " , 1, kdwc_1.rowcount())
//			if k_riga > 0 then
//				kst_tab_clienti.codice = long(trim(data))
//				get_dati_cliente(kst_tab_clienti)
//				post put_video_cliente(kst_tab_clienti)
//			else
//				dw_dett_0.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
//			end if
//		else
//			set_iniz_dati_cliente(kst_tab_clienti)
//			post put_video_cliente(kst_tab_clienti)
//		end if
//
//
//end choose 
//
//
//
//return k_errore
//	
end event

event dw_dett_0::itemfocuschanged;call super::itemfocuschanged;//int k_rc
//datawindowchild  kdwc_x, kdwc_x_des
//
//
//choose case lower(dwo.name)
//
//
////--- Attivo dw archivio CLIENTI
//	case "rag_soc_10", "id_cliente"
//		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
//			k_rc = this.getchild("id_cliente", kdwc_x)
//			if kdwc_x.rowcount() < 2 then
//				kdwc_x.retrieve("%")
//				k_rc = this.getchild("rag_soc_10", kdwc_x_des)
//				kdwc_x.RowsCopy(kdwc_x.GetRow(), kdwc_x.RowCount(), Primary!, kdwc_x_des, 1, Primary!)
//				kdwc_x.setsort( "id_cliente A")
//				kdwc_x.sort( )
//				k_rc = kdwc_x.insertrow(1)
//				k_rc = kdwc_x_des.insertrow(1)
//			end if	
//		end if
//
//end choose
//
//attiva_tasti()
//
end event

event dw_dett_0::clicked;call super::clicked;//
if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento &
			or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
	choose case dwo.name
		case "p_erase_id_cliente" 
			this.setitem( 1, "rag_soc_10", "")
			this.setitem( 1, "id_cliente", 0)
		
		case "p_erase_contratto" 
			this.setitem( 1, "mc_co", "")
			this.setitem( 1, "contratti_descr", "")
			this.setitem( 1, "contratto", 0)
		
//		case "p_erase_id_email_funzione" 
//			this.setitem( 1, "id_email_funzione", 0)
//			this.setitem( 1, "id_email_funzione_1", "")
//			this.setitem( 1, "id_email_funzione_2", "")
		
	end choose
end if
end event

event dw_dett_0::u_personalizza_dw;call super::u_personalizza_dw;//
if this.ki_flag_modalita = kkg_flag_modalita.inserimento &
					or this.ki_flag_modalita = kkg_flag_modalita.modifica then
	this.object.p_erase_id_cliente.visible = '1'
	this.object.p_erase_contratto.visible = '1'
//	this.object.p_erase_id_email_funzione.visible = '1'
	this.object.b_clienti.enabled = '1'
	this.object.b_contratti_l.enabled = '1'
//	this.object.p_erase_id_email_funzione.enabled = '1'
else
	this.object.p_erase_id_cliente.visible = '0'
	this.object.p_erase_contratto.visible = '0'
//	this.object.p_erase_id_email_funzione.visible = '0'
	this.object.b_clienti.enabled = '0'
	this.object.b_contratti_l.enabled = '0'
//	this.object.p_erase_id_email_funzione.enabled = '0'
end if
end event

event dw_dett_0::getfocus;call super::getfocus;//
int k_riga
datawindowchild kdwc_1


this.getchild("id_email_funzione", kdwc_1)
if kdwc_1.rowcount() = 0 then
	if this.ki_flag_modalita = KKG_FLAG_RICHIESTA.inserimento &
				or this.ki_flag_modalita = KKG_FLAG_RICHIESTA.modifica then 
		kdwc_1.settransobject(kguo_sqlca_db_magazzino)
		if kdwc_1.retrieve() > 0 then
			kdwc_1.insertrow(1)
		end if
	end if
end if
end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_alarm_instock
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_alarm_instock
integer y = 32
integer width = 2866
integer height = 864
string dataobject = "d_alarm_instock_l"
boolean ki_link_standard_sempre_possibile = true
end type

type dw_guida from w_g_tab0`dw_guida within w_alarm_instock
end type

type st_duplica from w_g_tab0`st_duplica within w_alarm_instock
end type

