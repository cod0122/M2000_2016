$PBExportHeader$w_asdrackbarcode.srw
forward
global type w_asdrackbarcode from w_g_tab0
end type
end forward

global type w_asdrackbarcode from w_g_tab0
integer width = 2039
integer height = 2180
boolean ki_riparte_dopo_save_ok = true
boolean ki_reset_dopo_save_ok = false
boolean ki_reselect_row_if_updated = false
end type
global w_asdrackbarcode w_asdrackbarcode

type variables
//
st_tab_asdrackbarcode kist_tab_asdrackbarcode
kuf_asdrackbarcode kiuf_asdrackbarcode
kuf_asdrackcode kiuf_asdrackcode


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
st_tab_asdrackcode kst_tab_asdrackcode


	setpointer(kkg.pointer_attesa)

//--- Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima 
		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)
	
	end if
			
		
	if k_importa <= 0 then // Nessuna importazione eseguita
	
		if isnumber(trim(ki_st_open_w.key1)) then
			kist_tab_asdrackbarcode.id_asdrackcode = long(trim(ki_st_open_w.key1))  // passa il ID del RACK
		end if
		
		if ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.modifica or ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.inserimento then 

			if kist_tab_asdrackbarcode.id_asdrackcode > 0 then
	//--- se Rck in lavorazione allora blocca qualsiasi modifica		
				kst_tab_asdrackcode.id_asdrackcode = kist_tab_asdrackbarcode.id_asdrackcode
				if kiuf_asdrackcode.if_rackcode_in_lav(kst_tab_asdrackcode) then
					ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.visualizzazione
				else	
					k_show_all = "S"
				end if
			end if
		end if
		if dw_dett_0.retrieve(kist_tab_asdrackbarcode.id_asdrackcode, k_show_all) < 1 then
				
			k_return = "1Nessun Rack associato a un Barcode di lavorazione trovato"

			setpointer(kkg.pointer_default)
			messagebox("Nussun dato disponibile", "Lista Associazioni Rack ai Barcode di lavorazione '"  + string(kist_tab_asdrackbarcode.id_asdrackcode) + "' Vuota.")
			
		else
				
			dw_dett_0.resetupdate( )
			
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
//				if ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.modifica then 
//					cb_modifica.postevent(clicked!)
//				end if
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
		
		dw_dett_0.setitem(k_riga, "k_associato_rack", 0)
		
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
kiuf_asdrackbarcode = create kuf_asdrackbarcode
kiuf_asdrackcode = create kuf_asdrackcode


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
long k_row, k_rows, k_row_del, k_row_add
int k_associato
st_tab_asdrackbarcode kst_tab_asdrackbarcode_add[], kst_tab_asdrackbarcode_del[]


try
	
	k_rows = dw_dett_0.rowcount( )

	for k_row = 1 to k_rows
		
		k_associato = dw_dett_0.getitemnumber(k_row, "k_associato_rack")
		
		if dw_dett_0.getitemnumber(k_row, "pl_barcode") > 0 then
			// se già in Pianificazione non fa un bel nulla!!
		else
			
			if dw_dett_0.getitemnumber(k_row, "id_asdrackbarcode") > 0 then
				if k_associato = 0 then  // associazione da rimuovere 
				
					k_row_del++
					kst_tab_asdrackbarcode_del[k_row_del].id_asdrackbarcode = dw_dett_0.getitemnumber(k_row, "id_asdrackbarcode")
					kst_tab_asdrackbarcode_del[k_row_del].id_asdrackcode = dw_dett_0.getitemnumber(k_row, "id_asdrackcode")
					kst_tab_asdrackbarcode_del[k_row_del].barcode = trim(dw_dett_0.getitemstring(k_row, "barcode"))
					
				end if
			else
				if k_associato = 1 then  // associazione da caricare
	
					k_row_add++
					dw_dett_0.setitem(k_row, "id_asdrackcode", kist_tab_asdrackbarcode.id_asdrackcode)
					kst_tab_asdrackbarcode_add[k_row_add].id_asdrackcode = dw_dett_0.getitemnumber(k_row, "id_asdrackcode")
					kst_tab_asdrackbarcode_add[k_row_add].barcode = trim(dw_dett_0.getitemstring(k_row, "barcode"))
				
				end if
			end if
		end if
		
	next

	if k_row_del > 0 then
		kiuf_asdrackbarcode.tb_delete(kst_tab_asdrackbarcode_del[])
	end if
	if k_row_add > 0 then
		kiuf_asdrackbarcode.u_add_barcode(kst_tab_asdrackbarcode_add[])
	end if

	dw_dett_0.ResetUpdate()
	
	
catch (uo_exception kuo_exception)

		k_return = "1Errore: " + kuo_exception.kist_esito.SQLerrtext + " (" + string(kuo_exception.kist_esito.SQLcode) + ")" 

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

on w_asdrackbarcode.create
call super::create
end on

on w_asdrackbarcode.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_asdrackbarcode) then destroy kiuf_asdrackbarcode
if isvalid(kiuf_asdrackcode) then destroy kiuf_asdrackcode

end event

type dw_print_0 from w_g_tab0`dw_print_0 within w_asdrackbarcode
end type

type st_ritorna from w_g_tab0`st_ritorna within w_asdrackbarcode
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_asdrackbarcode
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_asdrackbarcode
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_asdrackbarcode
end type

type st_stampa from w_g_tab0`st_stampa within w_asdrackbarcode
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_asdrackbarcode
end type

type cb_modifica from w_g_tab0`cb_modifica within w_asdrackbarcode
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_asdrackbarcode
end type

type cb_cancella from w_g_tab0`cb_cancella within w_asdrackbarcode
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_asdrackbarcode
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_asdrackbarcode
integer x = 0
integer y = 0
boolean enabled = true
string dataobject = "d_asdrackbarcode_l"
boolean hsplitscroll = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = true
boolean ki_d_std_1_attiva_cerca = true
boolean ki_dw_visibile_in_open_window = true
end type

event dw_dett_0::itemchanged;call super::itemchanged;//
if dwo.name = "k_associato_rack" then
	if this.getitemnumber(row, "k_associato_rack") = 2 then
		return 2
	end if
	if string(data) = "2" then
		if this.getitemnumber(row, "k_associato_rack") = 1 then
			this.post setitem(row, "k_associato_rack", 0)
		else
			if this.getitemnumber(row, "k_associato_rack") = 0 then
				this.post setitem(row, "k_associato_rack", 1)
			end if
		end if
	end if
end if

end event

event dw_dett_0::doubleclicked;call super::doubleclicked;//
// disab double click
end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_asdrackbarcode
boolean enabled = false
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_asdrackbarcode
boolean enabled = false
boolean ki_dw_visibile_in_open_window = false
end type

type dw_guida from w_g_tab0`dw_guida within w_asdrackbarcode
end type

type st_duplica from w_g_tab0`st_duplica within w_asdrackbarcode
end type

