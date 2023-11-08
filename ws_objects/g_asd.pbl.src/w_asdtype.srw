$PBExportHeader$w_asdtype.srw
forward
global type w_asdtype from w_g_tab0
end type
end forward

global type w_asdtype from w_g_tab0
boolean ki_reset_dopo_save_ok = false
boolean ki_reselect_row_if_updated = false
end type
global w_asdtype w_asdtype

type variables
//
kuf_asdtype kiuf_asdtype

end variables

forward prototypes
protected function string inizializza () throws uo_exception
protected function string cancella ()
protected subroutine open_start_window ()
protected function integer modifica ()
protected function integer inserisci ()
protected function integer visualizza ()
public subroutine pulizia_righe ()
protected function boolean u_lancia_funzione_ins (ref st_open_w ast_open_w)
protected function boolean u_lancia_funzione_mod (ref st_open_w ast_open_w)
public function string u_lancia_funzione_if_modificato ()
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
//string k_key
long k_riga
int k_importa = 0
kuf_utility kuf1_utility


	setpointer(kkg.pointer_attesa)

//--- Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima 
		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)
	
	end if
			
		
	if k_importa <= 0 then // Nessuna importazione eseguita
	
		if dw_dett_0.retrieve() < 1 then
				
			k_return = "1Nessun Tipo di Dispositivo Ausiliario trovato"

			setpointer(kkg.pointer_default)
			messagebox("Lista 'Tipi di Dispositivi Ausiliari' Vuota", "Nesun Codice Trovato per la richiesta fatta")
			
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
string k_errore = "0 "
long k_riga
st_tab_asdtype kst_tab_asdtype


try
	//=== Controllo se sul dettaglio c'e' qualche cosa
	k_riga = dw_dett_0.GetSelectedRow(0)
	if k_riga = 0 then
		k_riga = dw_dett_0.getrow()	
	end if
	if k_riga > 0 then
		kst_tab_asdtype.id_asdtype = dw_dett_0.getitemnumber(k_riga, "id_asdtype")
		kst_tab_asdtype.code = dw_dett_0.getitemstring(k_riga, "code")
		kst_tab_asdtype.des = trim(dw_dett_0.getitemstring(k_riga, "des"))
	end if
	
	if isnull(kst_tab_asdtype.code) then
		kst_tab_asdtype.code = ". "
	end if
	if isnull(kst_tab_asdtype.des) = true or trim(kst_tab_asdtype.des) = "" then
		kst_tab_asdtype.des = "Tipo di Dispositivo Ausiliario senza descrizione" 
	end if
	
	if k_riga > 0 and not isnull(kst_tab_asdtype.id_asdtype) then	
		
	//=== Richiesta di conferma della eliminazione del rek
	
		if messagebox("Elimina Tipo di Dispositivo Ausiliario", "Sei sicuro di voler Cancellare : ~n~r" &
						 + trim(kst_tab_asdtype.code) + " " + trim(kst_tab_asdtype.des) &
						 + " (" + string(kst_tab_asdtype.id_asdtype) + ")", &
					question!, yesno!, 2) = 1 then
	 
	//=== Cancella la riga dal data windows di lista
			kiuf_asdtype.tb_delete( kst_tab_asdtype )  
	
			kguo_sqlca_db_magazzino.db_commit()
	
	//--- cancello riga a video
			dw_dett_0.deleterow(k_riga)
	
			dw_dett_0.setfocus()
	
			attiva_tasti()
	
		else
			messagebox("Cancellazione", "Operazione Annullata !!")
		end if
	
		dw_dett_0.setcolumn(1)
	
	end if
	
catch (uo_exception kuo_exception)
		k_return = "1Errore in cancellazione. ~n~r" + kuo_exception.get_errtext( )
		kguo_sqlca_db_magazzino.db_rollback( )
	
end try

return(k_return)
//

end function

protected subroutine open_start_window ();//
kiuf_asdtype = create kuf_asdtype
end subroutine

protected function integer modifica ();//
//--- Torna : <=0=Ko, >0=Ok
int k_return=1
kuf_utility kuf1_utility


	kuf1_utility = create kuf_utility

	dw_dett_0.ki_flag_modalita = ki_st_open_w.flag_modalita
   kuf1_utility.u_proteggi_sproteggi_dw(dw_dett_0)

	destroy kuf1_utility

	attiva_tasti()

	dw_dett_0.Setfocus()


return k_return

end function

protected function integer inserisci ();//
long k_return
long k_row
kuf_utility kuf1_utility


	kuf1_utility = create kuf_utility

	dw_dett_0.ki_flag_modalita = ki_st_open_w.flag_modalita
   kuf1_utility.u_proteggi_sproteggi_dw(dw_dett_0)

	destroy kuf1_utility

	k_row = dw_dett_0.getselectedrow(0)
	if k_row = 0 then
		k_row = dw_dett_0.getrow( )
	end if
	k_row = dw_dett_0.insertrow(k_row)
	dw_dett_0.setcolumn("code")
	dw_dett_0.setrow(k_row)
	dw_dett_0.selectrow(0, false)
	dw_dett_0.selectrow(k_row, true)
	
	k_return = k_row

	attiva_tasti()

	dw_dett_0.Setfocus()


return k_return

end function

protected function integer visualizza ();//
//--- Torna : <=0=Ko, >0=Ok
int k_return=1
kuf_utility kuf1_utility


	kuf1_utility = create kuf_utility

	dw_dett_0.ki_flag_modalita = ki_st_open_w.flag_modalita
   kuf1_utility.u_proteggi_sproteggi_dw(dw_dett_0)

	destroy kuf1_utility

	attiva_tasti()

	dw_dett_0.Setfocus()


return k_return

end function

public subroutine pulizia_righe ();//
long k_row, k_rows
	
	k_rows = dw_dett_0.rowcount( )

	for k_row = k_rows to 1 step -1

		if dw_dett_0.getitemnumber(k_row, "id_asdtype") > 0 &
				 or trim(dw_dett_0.getitemstring(k_row, "des")) > " " or trim(dw_dett_0.getitemstring(k_row, "code")) > " " then
		else
			dw_dett_0.deleterow(k_row)
		end if
	next

	
	
end subroutine

protected function boolean u_lancia_funzione_ins (ref st_open_w ast_open_w);/*
lancia la funzione di Inserimento

	Inp: st_open_w.flag_modalita
	Out: boolean: TRUE = OK
*/
boolean k_return 
 
try
	kguo_exception.inizializza(this.classname( ))
	
	//dw_dett_0.reset()
	ki_st_open_w.flag_modalita = ast_open_w.flag_modalita
	dw_dett_0.ki_flag_modalita = ast_open_w.flag_modalita
	inserisci( )
	k_return = true
	
//	if dw_dett_0.enabled then
//		ki_resize_dw_dett = true
//		u_resize()
//		dw_dett_0.setfocus()		
//
//		u_personalizza_dw ()
//	end if
	

catch (uo_exception kuo_exception)
	throw kuo_exception
	
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
	
	if dw_lista_0.rowcount( ) > 0 or (not dw_lista_0.enabled and dw_dett_0.enabled and dw_dett_0.rowcount( ) > 0)  then 
		//dw_dett_0.reset()
		ki_st_open_w.flag_modalita = ast_open_w.flag_modalita
		dw_dett_0.ki_flag_modalita = ast_open_w.flag_modalita
		if modifica( ) > 0 then
			k_return = true
			
//			if dw_dett_0.rowcount( ) > 0 and dw_dett_0.enabled then
//				ki_resize_dw_dett = true
//				u_resize()
//				dw_dett_0.setfocus()		
//	
//				u_personalizza_dw ()
//				dw_dett_0.resetupdate( )
//	
//	//--- posizionamento della riga in modo che si veda							
//				if dw_lista_0.getrow( ) > 0 then
//					dw_lista_0.scrolltorow(dw_lista_0.getrow( ))
//				end if
//			end if
		else
			kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
			kguo_exception.setmessage( "Operazione fallita", "Dati non trovati in archivio~n~r" + &
															"Provare a riaggiornare l'elenco e rifare l'operazione appena tentata")
			throw kguo_exception
		end if
	end if
					

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return



end function

public function string u_lancia_funzione_if_modificato ();//
return "0"
end function

on w_asdtype.create
call super::create
end on

on w_asdtype.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_asdtype) then destroy kiuf_asdtype
end event

type dw_print_0 from w_g_tab0`dw_print_0 within w_asdtype
end type

type st_ritorna from w_g_tab0`st_ritorna within w_asdtype
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_asdtype
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_asdtype
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_asdtype
end type

type st_stampa from w_g_tab0`st_stampa within w_asdtype
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_asdtype
end type

type cb_modifica from w_g_tab0`cb_modifica within w_asdtype
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_asdtype
end type

type cb_cancella from w_g_tab0`cb_cancella within w_asdtype
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_asdtype
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_asdtype
boolean enabled = true
string dataobject = "d_asdtype_l"
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = true
boolean ki_d_std_1_attiva_cerca = true
boolean ki_dw_visibile_in_open_window = true
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_asdtype
boolean enabled = false
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_asdtype
boolean enabled = false
boolean ki_dw_visibile_in_open_window = false
end type

type dw_guida from w_g_tab0`dw_guida within w_asdtype
end type

type st_duplica from w_g_tab0`st_duplica within w_asdtype
end type

