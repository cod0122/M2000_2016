$PBExportHeader$w_ptasks_types_grp.srw
forward
global type w_ptasks_types_grp from w_g_tab0
end type
end forward

global type w_ptasks_types_grp from w_g_tab0
string title = ""
end type
global w_ptasks_types_grp w_ptasks_types_grp

type variables
//
private kuf_ptasks_types_grp kiuf_ptasks_types_grp

end variables

forward prototypes
protected subroutine open_start_window ()
protected function string cancella ()
protected function integer modifica ()
protected function integer inserisci ()
protected function string inizializza () throws uo_exception
protected function integer visualizza ()
protected function boolean dati_modif_1 ()
protected subroutine dati_modif_accept ()
protected function string aggiorna_tabelle ()
private function st_tab_ptasks_types_grp u_get_st_tab_ptasks_types_grp ()
protected function string check_dati ()
end prototypes

protected subroutine open_start_window ();//
	kiuf_ptasks_types_grp = create kuf_ptasks_types_grp

	dw_lista_0.ki_flag_modalita = ki_st_open_w.flag_modalita


end subroutine

protected function string cancella ();//
long k_riga
st_tab_ptasks_types_grp kst_tab_ptasks_types_grp
st_tab_clienti kst_tab_clienti
st_esito kst_esito


if dw_lista_0.getselectedrow(0) = 0 then 
	if dw_lista_0.getrow() > 0 then 
		dw_lista_0.selectrow(dw_lista_0.getrow(), true)
	end if
end if

k_riga = dw_lista_0.getselectedrow(0)	
if k_riga > 0 then
	
	kst_tab_ptasks_types_grp.id_ptasks_types_grp = dw_lista_0.getitemnumber(k_riga, "id_ptasks_types_grp")
	kst_tab_ptasks_types_grp.descr = dw_lista_0.getitemstring(k_riga, "descr")

	if kst_tab_ptasks_types_grp.descr > " " then
	else
		kst_tab_ptasks_types_grp.descr = "*senza descrizione*" 
	end if
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina Gruppo", "Sei sicuro di voler Cancellare il gruppo: ~n~r" &
	         + string(kst_tab_ptasks_types_grp.id_ptasks_types_grp, "#####") + " - " + trim(kst_tab_ptasks_types_grp.descr) &
				,question! ,yesno!, 2) = 1 then
		
		// Cancella 
		try
			kst_tab_ptasks_types_grp.st_tab_g_0.esegui_commit = "S"
			kiuf_ptasks_types_grp.tb_delete( kst_tab_ptasks_types_grp ) 
		
			dw_lista_0.setitemstatus(k_riga, 0, primary!, new!)
			dw_lista_0.deleterow(k_riga)

		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()

			messagebox("Operazione fallita" &
						,"Cancellazione in errore.~n~r" + trim(kst_esito.sqlerrtext) &
						,stopsign!)

		end try
	
		attiva_tasti()
		dw_lista_0.setfocus()

	else
		messagebox("Elimina Gruppo", "Operazione Annullata !")

	end if
end if

return " "

end function

protected function integer modifica ();//
//--- Torna : <=0=Ko, >0=Ok
int k_return
kuf_utility kuf1_utility
st_tab_ptasks_types_grp kst_tab_ptasks_types_grp


	kuf1_utility = create kuf_utility

	kst_tab_ptasks_types_grp.id_ptasks_types_grp = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_ptasks_types_grp")
	dw_lista_0.dataobject = "d_ptasks_types_grp_h"
	dw_lista_0.settransobject( kguo_sqlca_db_magazzino )
	k_return = dw_lista_0.retrieve(kst_tab_ptasks_types_grp.id_ptasks_types_grp) 

	dw_lista_0.ki_flag_modalita = ki_st_open_w.flag_modalita
   kuf1_utility.u_proteggi_sproteggi_dw(dw_lista_0)

	dw_dett_0.dataobject = "d_ptasks_types_grp_d"
	dw_dett_0.settransobject( kguo_sqlca_db_magazzino )
	dw_dett_0.retrieve(kst_tab_ptasks_types_grp.id_ptasks_types_grp) 

	dw_dett_0.ki_flag_modalita = ki_st_open_w.flag_modalita
   kuf1_utility.u_proteggi_sproteggi_dw(dw_dett_0)

	destroy kuf1_utility

	attiva_tasti()

	dw_dett_0.Setfocus()


return k_return

end function

protected function integer inserisci ();//
//--- Torna : <=0=Ko, >0=Ok
int k_return
kuf_utility kuf1_utility
st_tab_ptasks_types_grp kst_tab_ptasks_types_grp


	kuf1_utility = create kuf_utility

	dw_lista_0.dataobject = "d_ptasks_types_grp_h"
	dw_lista_0.settransobject( kguo_sqlca_db_magazzino )
	dw_lista_0.reset( )
	k_return = dw_lista_0.insertrow(0)

	dw_lista_0.ki_flag_modalita = ki_st_open_w.flag_modalita
   kuf1_utility.u_proteggi_sproteggi_dw(dw_lista_0)

	dw_dett_0.dataobject = "d_ptasks_types_grp_d"
	dw_dett_0.settransobject( kguo_sqlca_db_magazzino )
	dw_dett_0.retrieve(0) 

	dw_dett_0.ki_flag_modalita = ki_st_open_w.flag_modalita
   kuf1_utility.u_proteggi_sproteggi_dw(dw_dett_0)

	destroy kuf1_utility

	attiva_tasti()

	dw_dett_0.Setfocus()

return k_return

end function

protected function string inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1 e 2=Retrieve fallita (2=uscita Window)
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
int k_rows


	choose case ki_st_open_w.flag_modalita
			
		case kkg_flag_modalita.inserimento
			k_rows = inserisci()
			//dw_lista_0.reset()
			//k_rows = dw_lista_0.insertrow(0)
			
		case kkg_flag_modalita.modifica
			k_rows = modifica()
			//k_rows = dw_lista_0.reselectrow(1)
		    
		case else
			k_rows = visualizza()
			//k_rows = dw_lista_0.retrieve()	
			
	end choose

	if k_rows < 1 then
		k_return = "1Nessuna Informazione trovata "

		messagebox("Elenco Vuoto", &
			"Mi spiace, nessun dato trovato per la richiesta fatta." &
			,information!)
	end if
		
return k_return



end function

protected function integer visualizza ();//
//
//--- Torna : <=0=Ko, >0=Ok
int k_return
int k_row_lista, k_row
st_tab_ptasks_types_grp kst_tab_ptasks_types_grp


	if dw_lista_0.rowcount( ) > 0 then
		k_row_lista = dw_lista_0.getrow()
		if k_row_lista > 0 then
		else 
			k_row_lista = 1
		end if
		kst_tab_ptasks_types_grp.id_ptasks_types_grp = dw_lista_0.getitemnumber(k_row_lista, "id_ptasks_types_grp")
	end if
	
	if dw_lista_0.dataobject = "d_ptasks_types_grp_l" then
		if dw_lista_0.rowcount( ) = 0 then
			k_return = dw_lista_0.retrieve()
		end if
	else
		dw_lista_0.dataobject = "d_ptasks_types_grp_l"
		dw_lista_0.settransobject( kguo_sqlca_db_magazzino )
		dw_lista_0.reset( )
		k_row_lista = dw_lista_0.retrieve()

		if k_row_lista > 0 then
			if kst_tab_ptasks_types_grp.id_ptasks_types_grp > 0 then
				k_row = dw_lista_0.find("id_ptasks_types_grp = " + string(kst_tab_ptasks_types_grp.id_ptasks_types_grp), 1, k_row_lista)
			else
				k_row = 1
				kst_tab_ptasks_types_grp.id_ptasks_types_grp = dw_lista_0.getitemnumber(1, "id_ptasks_types_grp")
			end if
			dw_lista_0.setrow(k_row)
			dw_lista_0.selectrow(0, false)
			dw_lista_0.selectrow(k_row, true)
		end if
	end if
	
	if k_row_lista > 0 then
		dw_dett_0.dataobject = "d_ptasks_types_grp_v"
		dw_dett_0.settransobject( kguo_sqlca_db_magazzino )
		if kst_tab_ptasks_types_grp.id_ptasks_types_grp > 0 then
			dw_dett_0.reset( )
			k_return = dw_dett_0.retrieve(kst_tab_ptasks_types_grp.id_ptasks_types_grp) 
		end if
	end if
	
	attiva_tasti()

	dw_lista_0.Setfocus()

return k_return

end function

protected function boolean dati_modif_1 ();//
//--- dati modificati?
//--- true=si; false=no
//
boolean k_boolean = false


if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then

	dati_modif_accept( )

	if dw_dett_0.u_dati_modificati() or dw_lista_0.u_dati_modificati() then
		
		k_boolean = true
		
	end if

end if
			
return k_boolean
			

end function

protected subroutine dati_modif_accept ();//
dw_lista_0.accepttext( )
super::dati_modif_accept( )

end subroutine

protected function string aggiorna_tabelle ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================
//
string k_return="0 "
st_tab_ptasks_types_grp kst_tab_ptasks_types_grp


try
	//--- get dati da aggiornare
	kst_tab_ptasks_types_grp = u_get_st_tab_ptasks_types_grp()
	
	kst_tab_ptasks_types_grp.st_tab_g_0.esegui_commit = "S"
	//--- aggiorna
	if kst_tab_ptasks_types_grp.id_ptasks_types_grp > 0 then
		kiuf_ptasks_types_grp.tb_update(kst_tab_ptasks_types_grp)
	else
	//--- nuovo
		kiuf_ptasks_types_grp.tb_insert(kst_tab_ptasks_types_grp)
		dw_lista_0.setitem(1, "id_ptasks_types_grp", kst_tab_ptasks_types_grp.id_ptasks_types_grp)
	end if

	dw_lista_0.resetupdate( )
	dw_dett_0.resetupdate( )
	dw_dett_0.visible = false

	ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	
catch (uo_exception kuo_exception)
	k_return="1Fallito aggiornamento in archivio " &
							+ "~n~r" &
							+ kuo_exception.get_errtext( )
	messagebox("Aggiornamento non eseguito", mid(k_return,2), stopsign!)
finally
				
end try

return k_return

end function

private function st_tab_ptasks_types_grp u_get_st_tab_ptasks_types_grp ();//
int k_row, k_rows
st_tab_ptasks_types_grp kst_tab_ptasks_types_grp


kst_tab_ptasks_types_grp.id_ptasks_types_grp = dw_lista_0.getitemnumber(1, "id_ptasks_types_grp")
kst_tab_ptasks_types_grp.descr = dw_lista_0.getitemstring(1, "descr")

//--- riempie array json
kst_tab_ptasks_types_grp.ptasks_types_json = "{}"
k_rows = dw_dett_0.rowcount( )
for k_row = 1 to k_rows
	if dw_dett_0.getitemnumber(k_row, "k_presente") = 1 then
		if kst_tab_ptasks_types_grp.ptasks_types_json = "{}" then
			kst_tab_ptasks_types_grp.ptasks_types_json = "["
		else
			kst_tab_ptasks_types_grp.ptasks_types_json += ","
		end if
		kst_tab_ptasks_types_grp.ptasks_types_json += &
				string(dw_dett_0.getitemnumber(k_row, "id_ptasks_type"))
	end if
next
if kst_tab_ptasks_types_grp.ptasks_types_json = "{}" then
else
	kst_tab_ptasks_types_grp.ptasks_types_json += "]"
end if

return kst_tab_ptasks_types_grp
end function

protected function string check_dati ();//
// evita i controlli di default
return "0"
end function

on w_ptasks_types_grp.create
call super::create
end on

on w_ptasks_types_grp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_ptasks_types_grp) then destroy kiuf_ptasks_types_grp

end event

type dw_print_0 from w_g_tab0`dw_print_0 within w_ptasks_types_grp
end type

type st_ritorna from w_g_tab0`st_ritorna within w_ptasks_types_grp
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_ptasks_types_grp
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_ptasks_types_grp
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_ptasks_types_grp
end type

type st_stampa from w_g_tab0`st_stampa within w_ptasks_types_grp
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_ptasks_types_grp
end type

type cb_modifica from w_g_tab0`cb_modifica within w_ptasks_types_grp
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_ptasks_types_grp
end type

type cb_cancella from w_g_tab0`cb_cancella within w_ptasks_types_grp
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_ptasks_types_grp
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_ptasks_types_grp
boolean enabled = true
string title = ""
string dataobject = "d_ptasks_types_grp_v"
boolean hsplitscroll = false
boolean ki_attiva_standard_select_row = true
boolean ki_attiva_dragdrop = true
boolean ki_attiva_dragdrop_self = true
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_ptasks_types_grp
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_ptasks_types_grp
string dataobject = "d_ptasks_types_grp_l"
end type

type dw_guida from w_g_tab0`dw_guida within w_ptasks_types_grp
end type

type st_duplica from w_g_tab0`st_duplica within w_ptasks_types_grp
end type

