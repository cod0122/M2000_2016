$PBExportHeader$w_sped_addr_excl.srw
forward
global type w_sped_addr_excl from w_g_tab0
end type
end forward

global type w_sped_addr_excl from w_g_tab0
integer width = 2898
integer height = 2084
string title = " "
long backcolor = 17966373
windowanimationstyle openanimation = topslide!
boolean ki_toolbar_window_presente = true
boolean ki_reset_dopo_save_ok = false
boolean ki_msg_dopo_save_ok = true
end type
global w_sped_addr_excl w_sped_addr_excl

type variables
//
kuf_sped_addr_excl kiuf_sped_addr_excl
//st_sped_ddt kist_sped_ddt[]

end variables

forward prototypes
private function string inizializza ()
public subroutine popola_st_sped_ddt_da_lista ()
protected subroutine open_start_window ()
protected function string aggiorna_tabelle ()
end prototypes

private function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
int k_righe
st_tab_sped kst_tab_sped


	SetPointer(kkg.pointer_attesa)

	if len(trim(ki_st_open_w.key1)) > 0 then 
		kst_tab_sped.clie_2 = long(trim(ki_st_open_w.key1))
	else
		kst_tab_sped.clie_2 = 0
	end if
	k_righe = dw_dett_0.retrieve(kst_tab_sped.clie_2)
	if k_righe < 1 then
		if kst_tab_sped.clie_2 > 0 then
			k_return = "1Nessun Indirizzo trovato per l'anagrafica: " + string(kst_tab_sped.clie_2)
		else
			k_return = "1Nessun Indirizzo trovato"
		end if

		messagebox("Elenco Indirizzi", k_return)
	else
		if k_righe = 1 then
			dw_dett_0.setrow(1)
			dw_dett_0.selectrow(1, true)
		end if
		
	end if

	attiva_tasti()

	SetPointer(kkg.pointer_default)
	
	dw_dett_0.event getfocus( )

return k_return


end function

public subroutine popola_st_sped_ddt_da_lista ();//---
//--- riempie la  st_sped_ddt  da dw di elenco
//---
long k_riga, k_riga_st
st_esito kst_esito
//st_sped_ddt kst_sped_ddt_vuota[]


//kist_sped_ddt[] = kst_sped_ddt_vuota[]


k_riga_st = 0
for k_riga = 1 to dw_lista_0.rowcount()

//--- se selezionata la metto da stampare
	if dw_lista_0.IsSelected ( k_riga)   then

		if dw_lista_0.getitemnumber(k_riga, "num_bolla_out") > 0 then

			k_riga_st++
//			kist_sped_ddt[k_riga_st].kst_tab_sped.id_sped = dw_lista_0.getitemnumber(k_riga, "id_sped")
//			kist_sped_ddt[k_riga_st].kst_tab_sped.num_bolla_out = dw_lista_0.getitemnumber(k_riga, "num_bolla_out")
//			kist_sped_ddt[k_riga_st].kst_tab_sped.data_bolla_out = dw_lista_0.getitemdate(k_riga, "data_bolla_out")
//			kist_sped_ddt[k_riga_st].sel = 1
			
		end if			
	end if		
	
end for



end subroutine

protected subroutine open_start_window ();//
	kiuf_sped_addr_excl = create kuf_sped_addr_excl

end subroutine

protected function string aggiorna_tabelle ();//
//=== Update delle Tabelle
string k_return = "0 "
long k_row, k_rows, k_rows_upd
st_esito kst_esito
st_tab_sped_addr_excl kst_tab_sped_addr_excl

try
	
	kst_tab_sped_addr_excl.st_tab_g_0.esegui_commit = "N"
	
	k_rows = dw_dett_0.rowcount()
	for k_row = 1 to k_rows
	
		kst_tab_sped_addr_excl.id_sped_addr_excl = dw_dett_0.getitemnumber(k_row, "id_sped_addr_excl")
	
		if dw_dett_0.getitemnumber(k_row, "k_excluded") = 1 &
				and kst_tab_sped_addr_excl.id_sped_addr_excl = 0 then
			kst_tab_sped_addr_excl.id_sped_addr_excl = 0
			kst_tab_sped_addr_excl.id_cliente = dw_dett_0.getitemnumber(k_row, "clie_2")
			kst_tab_sped_addr_excl.rag_soc_1 = dw_dett_0.getitemstring(k_row, "rag_soc_1")
			kst_tab_sped_addr_excl.rag_soc_2 = dw_dett_0.getitemstring(k_row, "rag_soc_2")
			kst_tab_sped_addr_excl.indi = dw_dett_0.getitemstring(k_row, "indi")
			kst_tab_sped_addr_excl.loc = dw_dett_0.getitemstring(k_row, "loc")
			kst_tab_sped_addr_excl.cap = dw_dett_0.getitemstring(k_row, "cap")
			kst_tab_sped_addr_excl.prov = dw_dett_0.getitemstring(k_row, "prov")
			kst_tab_sped_addr_excl.id_nazione = dw_dett_0.getitemstring(k_row, "id_nazione")
			
			kst_tab_sped_addr_excl.id_sped_addr_excl = kiuf_sped_addr_excl.tb_add(kst_tab_sped_addr_excl)
			if kst_tab_sped_addr_excl.id_sped_addr_excl > 0 then
				k_rows_upd ++
				dw_dett_0.setitem(k_row, "id_sped_addr_excl", kst_tab_sped_addr_excl.id_sped_addr_excl)
			end if
		else
			if dw_dett_0.getitemnumber(k_row, "k_excluded") = 0 &
						and kst_tab_sped_addr_excl.id_sped_addr_excl > 0 then
				
				if kiuf_sped_addr_excl.tb_delete(kst_tab_sped_addr_excl) > 0 then
					k_rows_upd ++
					dw_dett_0.setitem(k_row, "k_excluded", 0)
					dw_dett_0.setitem(k_row, "id_sped_addr_excl", 0)
				end if
			end if
		end if
		
	end for
	
	if k_rows_upd > 0 then
		ki_msg_updated_ok = "Aggiornati " + string(k_rows_upd) + " righe Indirizzi da escludere dal DDT."
		dw_dett_0.resetupdate( )
	end if

catch (uo_exception kuo_exception)
	k_return = "1Errore: " + kguo_exception.get_errtext( ) 
	
end try
	

return k_return


end function

on w_sped_addr_excl.create
call super::create
end on

on w_sped_addr_excl.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_sped_addr_excl) then destroy kiuf_sped_addr_excl

end event

type dw_print_0 from w_g_tab0`dw_print_0 within w_sped_addr_excl
end type

type st_ritorna from w_g_tab0`st_ritorna within w_sped_addr_excl
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_sped_addr_excl
integer x = 1408
integer y = 1124
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_sped_addr_excl
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_sped_addr_excl
integer x = 2427
integer y = 1160
integer height = 92
integer taborder = 90
boolean cancel = true
end type

type st_stampa from w_g_tab0`st_stampa within w_sped_addr_excl
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_sped_addr_excl
integer x = 1563
integer y = 1368
end type

type cb_modifica from w_g_tab0`cb_modifica within w_sped_addr_excl
integer x = 1783
integer y = 1152
integer height = 96
integer taborder = 70
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_sped_addr_excl
integer x = 1134
integer y = 1160
integer height = 96
integer taborder = 100
end type

type cb_cancella from w_g_tab0`cb_cancella within w_sped_addr_excl
integer x = 2121
integer y = 1164
integer height = 96
integer taborder = 80
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_sped_addr_excl
integer x = 1467
integer y = 1156
integer height = 96
integer taborder = 60
boolean enabled = false
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_sped_addr_excl
integer x = 1769
integer y = 1104
integer width = 827
integer height = 524
integer taborder = 50
boolean enabled = true
string dataobject = "d_sped_addr_excl_l"
pointer kipointer_orig = appstarting!
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_sempre_possibile = true
boolean ki_attiva_standard_select_row = true
boolean ki_d_std_1_attiva_cerca = true
boolean ki_dw_visibile_in_open_window = true
end type

on dw_dett_0::rbuttondown;call w_g_tab0`dw_dett_0::rbuttondown;//
//=== Scateno l'evento sulla window
parent.triggerevent("rbuttondown")

end on

event dw_dett_0::u_doppio_click;//
// non fa nulla
end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_sped_addr_excl
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_sped_addr_excl
integer width = 2807
integer height = 708
integer taborder = 120
boolean enabled = false
borderstyle borderstyle = stylelowered!
boolean ki_dw_visibile_in_open_window = false
end type

type dw_guida from w_g_tab0`dw_guida within w_sped_addr_excl
end type

type st_duplica from w_g_tab0`st_duplica within w_sped_addr_excl
end type

