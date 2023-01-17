$PBExportHeader$w_asdslpt.srw
forward
global type w_asdslpt from w_g_tab0
end type
end forward

global type w_asdslpt from w_g_tab0
boolean ki_esponi_msg_dati_modificati = false
boolean ki_reset_dopo_save_ok = false
boolean ki_reselect_row_if_updated = false
end type
global w_asdslpt w_asdslpt

type variables
//
kuf_asdslpt kiuf_asdslpt

end variables

forward prototypes
protected function string inizializza () throws uo_exception
protected function string cancella ()
protected subroutine open_start_window ()
protected function integer modifica ()
protected function integer visualizza ()
protected function boolean u_lancia_funzione_mod (ref st_open_w ast_open_w)
protected function string aggiorna_tabelle ()
protected subroutine attiva_tasti_pers ()
protected function integer inserisci ()
protected function boolean u_lancia_funzione_ins (ref st_open_w ast_open_w)
protected function string check_dati ()
end prototypes

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
string k_show_all
long k_riga
int k_importa = 0
kuf_utility kuf1_utility
st_tab_asdslpt kst_tab_asdslpt


	setpointer(kkg.pointer_attesa)

//--- Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima 
		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)
	
	end if
			
		
	if k_importa <= 0 then // Nessuna importazione eseguita
	
		if isnumber(trim(ki_st_open_w.key1)) then
			kst_tab_asdslpt.id_asddevice = long(trim(ki_st_open_w.key1))  // passa il ID del Dispositivo
		end if
		if ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.modifica or ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.inserimento then 
			k_show_all = "S"
		end if
		if dw_dett_0.retrieve(kst_tab_asdslpt.id_asddevice, k_show_all) < 1 then
				
			k_return = "1Nessun Piano di Trattamento associato al Dispositivo Ausiliario trovato"

			setpointer(kkg.pointer_default)
			messagebox("Nussun dato disponibile", "Lista Associazioni Piani di Trattamento al Dispositivo Ausiliario '"  + string(kst_tab_asdslpt.id_asddevice) + "' Vuota.")
			
		else
				
			if ki_st_open_w.flag_primo_giro = "S" then 
				k_riga = 1
				//if len(trim(ki_st_tab_contratti_arg.sc_cf)) > 0 then
				//	k_riga = dw_lista_0.find( "codice = '" + string(ki_st_tab_contratti_arg.sc_cf) + "' ", 1, dw_lista_0.rowcount( ) )
				//end if
				//if k_riga > 0 then 
					dw_dett_0.selectrow( 0, false)
					dw_dett_0.scrolltorow( k_riga)
					dw_dett_0.setrow( k_riga)
					dw_dett_0.selectrow( k_riga, true)
				//end if
				
//--- se entro per modificare allora....
				if ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.modifica then 
					cb_modifica.postevent(clicked!)
				end if
			end if

		end if		
	end if

	kuf1_utility = create kuf_utility
	dw_dett_0.ki_flag_modalita = ki_st_open_w.flag_modalita
	kuf1_utility.u_proteggi_sproteggi_dw(dw_dett_0)
	destroy kuf1_utility

	setpointer(kkg.pointer_default)
	
return k_return



end function

protected function string cancella ();//
string k_return="0 "
long k_riga


try
	//=== Controllo se sul dettaglio c'e' qualche cosa
	k_riga = dw_dett_0.GetSelectedRow(0)
	if k_riga = 0 then
		k_riga = dw_dett_0.getrow()	
	end if
	if k_riga > 0 then
		
		dw_dett_0.setitem(k_riga, "k_associato", 0)
		
		ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
		dw_dett_0.ki_flag_modalita = ki_st_open_w.flag_modalita
		
		attiva_tasti( )
		
	end if
	
catch (uo_exception kuo_exception)
		k_return = "1Errore in cancellazione dell'Associazione alla riga . ~n~r" + kuo_exception.get_errtext( )
		kguo_sqlca_db_magazzino.db_rollback( )
	
end try

return(k_return)
//

end function

protected subroutine open_start_window ();//
kiuf_asdslpt = create kuf_asdslpt
end subroutine

protected function integer modifica ();//
//--- Torna : <=0=Ko, >0=Ok
int k_return=1


	try
	
		inizializza( )
	
		attiva_tasti()
	
		dw_dett_0.Setfocus()
		
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
		
	end try


return k_return

end function

protected function integer visualizza ();//
//--- Torna : <=0=Ko, >0=Ok
int k_return=1


	try
	
		inizializza( )
	
		attiva_tasti()
	
		dw_dett_0.Setfocus()
		
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
		
	end try


return k_return

end function

protected function boolean u_lancia_funzione_mod (ref st_open_w ast_open_w);/*
lancia la funzione di Modifica

	Inp: st_open_w.flag_modalita
	Out: boolean: TRUE = OK
*/
boolean k_return

try
	
	kguo_exception.inizializza(this.classname( ))
	
	ki_st_open_w.flag_modalita = ast_open_w.flag_modalita
	dw_dett_0.ki_flag_modalita = ast_open_w.flag_modalita
	modifica( )
	k_return = true
			

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

protected function string aggiorna_tabelle ();//
//=== Update delle Tabelle
string k_return = "0 "
long k_row, k_rows
int k_associato
st_tab_asdslpt kst_tab_asdslpt


try
	
	k_rows = dw_dett_0.rowcount( )

	for k_row = 1 to k_rows
		
		kst_tab_asdslpt.id_asdslpt = dw_dett_0.getitemnumber(k_row, "id_asdslpt")
		
		k_associato = dw_dett_0.getitemnumber(k_row, "k_associato")
		
		if kst_tab_asdslpt.id_asdslpt > 0 then
			if k_associato = 0 then  // associazione da rimuovere 
			
				kiuf_asdslpt.tb_delete(kst_tab_asdslpt)
				   
			end if
		else
			if k_associato = 1 then  // associazione da caricare
			
				kst_tab_asdslpt.cod_sl_pt = dw_dett_0.getitemstring(k_row, "cod_sl_pt")
				kst_tab_asdslpt.id_asddevice = dw_dett_0.getitemnumber(k_row, "id_asddevice")
				kiuf_asdslpt.u_add(kst_tab_asdslpt)
			
			end if
		end if
		
	next

	dw_dett_0.ResetUpdate()
	
	
catch (uo_exception kuo_exception)

		k_return = "1Errore: " + kuo_exception.kist_esito.SQLsyntax + " (" + string(kuo_exception.kist_esito.SQLdbcode) + ")" 

end try
		

return k_return


end function

protected subroutine attiva_tasti_pers ();//
if dw_dett_0.rowcount( ) > 0 then
	cb_modifica.enabled = ki_consenti_modifica
	cb_inserisci.enabled = false
else
	cb_inserisci.enabled = ki_consenti_inserisci
	cb_modifica.enabled = false
end if

end subroutine

protected function integer inserisci ();//
//--- Torna : <=0=Ko, >0=Ok
int k_return=1


	try
	
		inizializza( )
	
		attiva_tasti()
	
		dw_dett_0.Setfocus()
		
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
		
	end try


return k_return

end function

protected function boolean u_lancia_funzione_ins (ref st_open_w ast_open_w);/*
lancia la funzione di Inserimento

	Inp: st_open_w.flag_Inserimento
	Out: boolean: TRUE = OK
*/
boolean k_return

try
	
	kguo_exception.inizializza(this.classname( ))
	
	ki_st_open_w.flag_modalita = ast_open_w.flag_modalita
	dw_dett_0.ki_flag_modalita = ast_open_w.flag_modalita
	inserisci( )
	k_return = true
			

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return



end function

protected function string check_dati ();//
return "0"
end function

on w_asdslpt.create
call super::create
end on

on w_asdslpt.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_asdslpt) then destroy kiuf_asdslpt
end event

type dw_print_0 from w_g_tab0`dw_print_0 within w_asdslpt
end type

type st_ritorna from w_g_tab0`st_ritorna within w_asdslpt
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_asdslpt
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_asdslpt
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_asdslpt
end type

type st_stampa from w_g_tab0`st_stampa within w_asdslpt
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_asdslpt
end type

type cb_modifica from w_g_tab0`cb_modifica within w_asdslpt
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_asdslpt
end type

type cb_cancella from w_g_tab0`cb_cancella within w_asdslpt
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_asdslpt
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_asdslpt
boolean enabled = true
string dataobject = "d_asdslpt_l_all"
boolean hsplitscroll = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = true
boolean ki_d_std_1_attiva_cerca = true
boolean ki_dw_visibile_in_open_window = true
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_asdslpt
boolean enabled = false
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_asdslpt
boolean enabled = false
boolean ki_dw_visibile_in_open_window = false
end type

type dw_guida from w_g_tab0`dw_guida within w_asdslpt
end type

type st_duplica from w_g_tab0`st_duplica within w_asdslpt
end type

