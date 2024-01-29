$PBExportHeader$w_pilota_g3_cfg_proprieta.srw
forward
global type w_pilota_g3_cfg_proprieta from w_db_cfg_proprieta
end type
end forward

global type w_pilota_g3_cfg_proprieta from w_db_cfg_proprieta
integer width = 3493
integer animationtime = 0
end type
global w_pilota_g3_cfg_proprieta w_pilota_g3_cfg_proprieta

type variables
//
kuf_plav_conn_cfg kiuf_plav_conn_cfg

end variables

forward prototypes
private function integer inserisci ()
private subroutine riempi_id ()
protected subroutine open_start_window ()
protected subroutine inizializza_1 () throws uo_exception
protected subroutine inizializza_2 () throws uo_exception
end prototypes

private function integer inserisci ();//
int k_return=1, k_ctr
st_tab_plav_conn_cfg kst_tab_plav_conn_cfg


	tab_1.tabpage_1.dw_1.reset( )
	tab_1.tabpage_1.dw_1.insertrow(0)
	
	kst_tab_plav_conn_cfg.codice = long(trim(ki_st_open_w.key1))
	kiuf_plav_conn_cfg.if_isnull(kst_tab_plav_conn_cfg)
	
	tab_1.tabpage_1.dw_1.setitem(1, "codice", kst_tab_plav_conn_cfg.codice )
	tab_1.tabpage_1.dw_1.setitem(1, "blocca_conn", kst_tab_plav_conn_cfg.blocca_conn )
	tab_1.tabpage_1.dw_1.setitem(1, "schema_nome", kst_tab_plav_conn_cfg.schema_nome )
	tab_1.tabpage_1.dw_1.setitem(1, "cfg_dbms_scelta", 1) //kst_tab_plav_conn_cfg.cfg_dbms_scelta )
	tab_1.tabpage_1.dw_1.setitem(1, "cfg_dbms", kst_tab_plav_conn_cfg.cfg_dbms )
	tab_1.tabpage_1.dw_1.setitem(1, "cfg_autocommit", kst_tab_plav_conn_cfg.cfg_autocommit )
	tab_1.tabpage_1.dw_1.setitem(1, "cfg_dbparm", kst_tab_plav_conn_cfg.cfg_dbparm )
	tab_1.tabpage_1.dw_1.setitem(1, "cfg_servername", kst_tab_plav_conn_cfg.cfg_servername )
	tab_1.tabpage_1.dw_1.setitem(1, "cfg_utente", kst_tab_plav_conn_cfg.cfg_utente )
	tab_1.tabpage_1.dw_1.setitem(1, "cfg_pwd", kst_tab_plav_conn_cfg.cfg_pwd )
	tab_1.tabpage_1.dw_1.setitem(1, "cfg_dbms_alt", kst_tab_plav_conn_cfg.cfg_dbms_alt )
	tab_1.tabpage_1.dw_1.setitem(1, "cfg_autocommit_alt", kst_tab_plav_conn_cfg.cfg_autocommit_alt )
	tab_1.tabpage_1.dw_1.setitem(1, "cfg_dbparm_alt", kst_tab_plav_conn_cfg.cfg_dbparm_alt )
	tab_1.tabpage_1.dw_1.setitem(1, "cfg_servername_alt", kst_tab_plav_conn_cfg.cfg_servername_alt )
	tab_1.tabpage_1.dw_1.setitem(1, "cfg_utente_alt", kst_tab_plav_conn_cfg.cfg_utente_alt )
	tab_1.tabpage_1.dw_1.setitem(1, "cfg_pwd_alt", kst_tab_plav_conn_cfg.cfg_pwd_alt )

	tab_1.tabpage_1.dw_1.setcolumn(1)
	attiva_tasti()

return (k_return)



end function

private subroutine riempi_id ();//

	if trim(tab_1.tabpage_1.dw_1.getitemstring(1, "cfg_dbms_scelta")) > " " then
	else
		tab_1.tabpage_1.dw_1.setitem(1, "cfg_dbms_scelta", 1)  // per dafault scelta db 1
	end if
	
	tab_1.tabpage_1.dw_1.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins())
	tab_1.tabpage_1.dw_1.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente())

end subroutine

protected subroutine open_start_window ();//
kiuf_plav_conn_cfg = create kuf_plav_conn_cfg

if isnumber(trim(ki_st_open_w.key1)) then
else
	ki_st_open_w.key1 = "1"
end if


end subroutine

protected subroutine inizializza_1 () throws uo_exception;/*
 Gestione del TAB 2
*/
int k_rc


	if tab_1.tabpage_2.dw_2.rowcount() = 0 then

		kguo_sqlca_db_plav.db_connetti( )
		tab_1.tabpage_2.dw_2.settransobject(kguo_sqlca_db_plav )
		k_rc = tab_1.tabpage_2.dw_2.retrieve()

		attiva_tasti()

	end if				

	tab_1.tabpage_2.dw_2.setfocus()

end subroutine

protected subroutine inizializza_2 () throws uo_exception;/*
 Gestione del TAB 3
*/
int k_rc


	if tab_1.tabpage_3.dw_3.rowcount() = 0 then

		kguo_sqlca_db_plav.db_connetti( )
		tab_1.tabpage_3.dw_3.settransobject(kguo_sqlca_db_plav )
		k_rc = tab_1.tabpage_3.dw_3.retrieve()

		attiva_tasti()

	end if				

	tab_1.tabpage_3.dw_3.setfocus()

end subroutine

on w_pilota_g3_cfg_proprieta.create
call super::create
end on

on w_pilota_g3_cfg_proprieta.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_print_0 from w_db_cfg_proprieta`dw_print_0 within w_pilota_g3_cfg_proprieta
end type

type st_ritorna from w_db_cfg_proprieta`st_ritorna within w_pilota_g3_cfg_proprieta
end type

type st_ordina_lista from w_db_cfg_proprieta`st_ordina_lista within w_pilota_g3_cfg_proprieta
end type

type st_aggiorna_lista from w_db_cfg_proprieta`st_aggiorna_lista within w_pilota_g3_cfg_proprieta
end type

type cb_ritorna from w_db_cfg_proprieta`cb_ritorna within w_pilota_g3_cfg_proprieta
end type

type st_stampa from w_db_cfg_proprieta`st_stampa within w_pilota_g3_cfg_proprieta
end type

type cb_visualizza from w_db_cfg_proprieta`cb_visualizza within w_pilota_g3_cfg_proprieta
end type

type cb_modifica from w_db_cfg_proprieta`cb_modifica within w_pilota_g3_cfg_proprieta
end type

type cb_aggiorna from w_db_cfg_proprieta`cb_aggiorna within w_pilota_g3_cfg_proprieta
end type

type cb_cancella from w_db_cfg_proprieta`cb_cancella within w_pilota_g3_cfg_proprieta
end type

type cb_inserisci from w_db_cfg_proprieta`cb_inserisci within w_pilota_g3_cfg_proprieta
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

type tab_1 from w_db_cfg_proprieta`tab_1 within w_pilota_g3_cfg_proprieta
boolean createondemand = false
end type

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
ki_tabpage_enabled = {true, true, true, false, false, false, false, false, false} // disabilita alcune tabpage
super::event u_constructor( )

end event

type tabpage_1 from w_db_cfg_proprieta`tabpage_1 within tab_1
integer y = 176
integer height = 1204
end type

type dw_1 from w_db_cfg_proprieta`dw_1 within tabpage_1
integer width = 3282
string dataobject = "d_pilota_g3_cfg"
end type

event dw_1::buttonclicked;//
kuf_utility kuf1_utility


try
	choose case  dwo.name 
		
		case "b_odbc"
			kuf1_utility = create kuf_utility
			kuf1_utility.u_apri_programma_esterno("odbcad32.exe")
			destroy kuf1_utility
	
		case "b_dbparm"
			if not isvalid(kguo_sqlca_db_plav) then kguo_sqlca_db_plav = create kuo_sqlca_db_plav
			kguo_exception.inizializza( )
			kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_OK)
			if messagebox("Test Connessione", "Salvare prima i dati della Connessione qui indicati. " &
						+ kkg.acapo + "Attenzione: il test è fatto con i parametri già salvati su DB! " &
						+ kkg.acapo + "Proseguire?", Question!, yesno!, 1) = 1 then
				try
					kguo_sqlca_db_plav.ki_conn_blk_msg_done = false  // reset flag display messagge
					if kguo_sqlca_db_plav.db_connetti( ) then
						kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_OK)
						kguo_exception.messaggio_utente("Test Connessione",  "Ok, connessione al DB eseguita.")
					end if
				catch (uo_exception kuo_exception)
					kuo_exception.messaggio_utente()
				end try
			end if
			//if isvalid(kiuo_sqlca_db_plav) then destroy kiuo_sqlca_db_plav
	
	
	
	end choose
	
catch (uo_exception kuo1_exception)
	kuo1_exception.messaggio_utente()
	
end try


end event

type st_1_retrieve from w_db_cfg_proprieta`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_db_cfg_proprieta`tabpage_2 within tab_1
boolean visible = true
integer y = 176
integer height = 1204
string text = "Elenco Tabelle"
long picturemaskcolor = 16777215
end type

type dw_2 from w_db_cfg_proprieta`dw_2 within tabpage_2
boolean visible = true
boolean enabled = true
string dataobject = "d_sterigenics_pp_tables_list"
boolean ki_link_standard_sempre_possibile = true
boolean ki_db_conn_standard = false
end type

type st_2_retrieve from w_db_cfg_proprieta`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_db_cfg_proprieta`tabpage_3 within tab_1
boolean visible = true
integer y = 176
integer height = 1204
string text = "IMPIANTO G2 ~r~nCoda pallet in Lavorazione"
end type

type dw_3 from w_db_cfg_proprieta`dw_3 within tabpage_3
boolean visible = true
boolean enabled = true
string dataobject = "d_programmi_richieste"
end type

event dw_3::itemchanged;call super::itemchanged;//



end event

type st_3_retrieve from w_db_cfg_proprieta`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_db_cfg_proprieta`tabpage_4 within tab_1
integer y = 176
integer height = 1204
end type

type dw_4 from w_db_cfg_proprieta`dw_4 within tabpage_4
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

type st_4_retrieve from w_db_cfg_proprieta`st_4_retrieve within tabpage_4
end type

type ln_1 from w_db_cfg_proprieta`ln_1 within tabpage_4
end type

type tabpage_5 from w_db_cfg_proprieta`tabpage_5 within tab_1
integer y = 176
integer height = 1204
end type

type dw_5 from w_db_cfg_proprieta`dw_5 within tabpage_5
end type

type st_5_retrieve from w_db_cfg_proprieta`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_db_cfg_proprieta`tabpage_6 within tab_1
integer y = 176
integer height = 1204
end type

type st_6_retrieve from w_db_cfg_proprieta`st_6_retrieve within tabpage_6
end type

type dw_6 from w_db_cfg_proprieta`dw_6 within tabpage_6
end type

type tabpage_7 from w_db_cfg_proprieta`tabpage_7 within tab_1
integer y = 176
integer height = 1204
end type

type st_7_retrieve from w_db_cfg_proprieta`st_7_retrieve within tabpage_7
end type

type dw_7 from w_db_cfg_proprieta`dw_7 within tabpage_7
end type

type tabpage_8 from w_db_cfg_proprieta`tabpage_8 within tab_1
integer y = 176
integer height = 1204
end type

type st_8_retrieve from w_db_cfg_proprieta`st_8_retrieve within tabpage_8
end type

type dw_8 from w_db_cfg_proprieta`dw_8 within tabpage_8
end type

type tabpage_9 from w_db_cfg_proprieta`tabpage_9 within tab_1
integer y = 176
integer height = 1204
end type

type st_9_retrieve from w_db_cfg_proprieta`st_9_retrieve within tabpage_9
end type

type dw_9 from w_db_cfg_proprieta`dw_9 within tabpage_9
end type

type st_duplica from w_db_cfg_proprieta`st_duplica within w_pilota_g3_cfg_proprieta
end type

