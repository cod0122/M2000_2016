$PBExportHeader$w_logtrace.srw
forward
global type w_logtrace from w_g_tab_3
end type
end forward

global type w_logtrace from w_g_tab_3
integer width = 5038
integer height = 4180
boolean ki_nessun_tasto_funzionale = true
boolean ki_sincronizza_window_consenti = false
boolean ki_filtra_attivo = false
boolean ki_aggiorna_richiesta_conferma = false
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_msg_dopo_update = false
end type
global w_logtrace w_logtrace

type variables
//
private kuf_logtrace_meca kiuf_logtrace_meca
private uo_menu_logtrace_jtab kiuo_menu_logtrace_jtab
private string ki_idx
private long ki_id
end variables

forward prototypes
protected subroutine open_start_window ()
protected function string inizializza () throws uo_exception
private function integer u_dw_inizializza (uo_d_std_1 adw_1) throws uo_exception
protected subroutine inizializza_1 () throws uo_exception
protected subroutine inizializza_2 () throws uo_exception
protected subroutine inizializza_3 () throws uo_exception
protected subroutine inizializza_4 () throws uo_exception
protected subroutine inizializza_5 () throws uo_exception
protected subroutine inizializza_6 () throws uo_exception
protected subroutine inizializza_7 () throws uo_exception
public subroutine u_set_tab_by_jtab ()
protected subroutine inizializza_8 () throws uo_exception
end prototypes

protected subroutine open_start_window ();//
string k_id_menu_window


	kiuo_menu_logtrace_jtab = create uo_menu_logtrace_jtab
	kiuf_logtrace_meca = create kuf_logtrace_meca

//--- passare in KEY1 = ID del LOG da cercare
//--- passare in KEY2 = id_menu_window (modalità=VISUALIZZAZIONE) per pigliare i dati da MENU_LOGTRACE quella del dw LOG su cui cercare es. riferim_e per cercare tra i LOG dei LOTTI

	if trim(ki_st_open_w.key1) > " " then
		ki_idx  = trim(ki_st_open_w.key1)
		
		if trim(ki_st_open_w.key2) > " " then
			k_id_menu_window = trim(ki_st_open_w.key2)
		
			if kiuo_menu_logtrace_jtab.u_set_jtab(k_id_menu_window) > " " then
				ki_exit_si = true
			else
				u_set_tab_by_jtab( )   // imposta i TABPAGE e DW
				
				if kiuo_menu_logtrace_jtab.u_type_id_if_numeric() then
					if IsNumber(trim(ki_idx)) then
						ki_id = long(trim(ki_idx))
					end if
				end if
	
			end if
			
		else
			ki_exit_si = true
		end if

	else
		ki_exit_si = true
	end if

	try
		ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione 
		kiuf_logtrace_meca.if_sicurezza(kkg_flag_modalita.modifica)
	catch (uo_exception kuo_exception)
	end try

end subroutine

protected function string inizializza () throws uo_exception;//

if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	u_dw_inizializza(tab_1.tabpage_1.dw_1)

end if

return "0"

end function

private function integer u_dw_inizializza (uo_d_std_1 adw_1) throws uo_exception;//
int k_rc



	SetPointer(kkg.pointer_attesa)

	adw_1.reset()
	
	if ki_id > 0 then
		k_rc = adw_1.retrieve(ki_id) 
	else
		k_rc = adw_1.retrieve(ki_idx) 
	end if
	
	choose case k_rc

		case is < 0		
			SetPointer(kkg.pointer_default)
			kguo_exception.inizializza(this.classname())
			kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
			kguo_exception.setmessage(  &
				"Attenzione si e' verificato un errore in lettura della scheda Log, codice " &
				+ ki_idx + kkg.acapo + "Errore: " + adw_1.kist_esito.sqlerrtext + "(" + string(adw_1.kist_esito.sqlcode) + ")")
			kguo_exception.messaggio_utente( )	

		case 0
//			SetPointer(kkg.pointer_default)
//			kguo_exception.inizializza(this.classname())
//			kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
//			kguo_exception.setmessage(  &
//				"Nessun dato Log trovato per questa scheda (Lotto id " + string(kist_tab_meca.id) + ")")
//			kguo_exception.messaggio_utente( )	

		case is > 0		
			adw_1.setfocus()
	
	end choose

	SetPointer(kkg.pointer_default)
	
return 0


end function

protected subroutine inizializza_1 () throws uo_exception;//

if tab_1.tabpage_2.dw_2.rowcount() = 0 then
	
	u_dw_inizializza(tab_1.tabpage_2.dw_2)

end if


end subroutine

protected subroutine inizializza_2 () throws uo_exception;//

if tab_1.tabpage_3.dw_3.rowcount() = 0 then
	
	u_dw_inizializza(tab_1.tabpage_3.dw_3)

end if


end subroutine

protected subroutine inizializza_3 () throws uo_exception;//

if tab_1.tabpage_4.dw_4.rowcount() = 0 then
	
	u_dw_inizializza(tab_1.tabpage_4.dw_4)

end if


end subroutine

protected subroutine inizializza_4 () throws uo_exception;//

if tab_1.tabpage_5.dw_5.rowcount() = 0 then
	
	u_dw_inizializza(tab_1.tabpage_5.dw_5)

end if


end subroutine

protected subroutine inizializza_5 () throws uo_exception;//

if tab_1.tabpage_6.dw_6.rowcount() = 0 then
	
	u_dw_inizializza(tab_1.tabpage_6.dw_6)

end if


end subroutine

protected subroutine inizializza_6 () throws uo_exception;//

if tab_1.tabpage_7.dw_7.rowcount() = 0 then
	
	u_dw_inizializza(tab_1.tabpage_7.dw_7)

end if


end subroutine

protected subroutine inizializza_7 () throws uo_exception;//

if tab_1.tabpage_8.dw_8.rowcount() = 0 then
	
	u_dw_inizializza(tab_1.tabpage_8.dw_8)

end if


end subroutine

public subroutine u_set_tab_by_jtab ();//
//--- Out: ""=OK;  "E" = Uscita Immediata
//
string k_rc_inizializza
long k_row, k_rows


	k_rows = kiuo_menu_logtrace_jtab.rowcount( )

	for k_row = 1 to k_rows 
		choose case k_row
			case 1
				tab_1.tabpage_1.text = kiuo_menu_logtrace_jtab.getitemstring(k_row, "descr")
				tab_1.tabpage_1.dw_1.dataobject = kiuo_menu_logtrace_jtab.getitemstring(k_row, "dw")
				tab_1.tabpage_1.dw_1.settransobject(kguo_sqlca_db_magazzino)
				tab_1.tabpage_1.enabled = true
				tab_1.tabpage_1.visible = true
				tab_1.tabpage_1.dw_1.enabled = true
				tab_1.tabpage_1.dw_1.visible = true
			case 2
				tab_1.tabpage_2.text = kiuo_menu_logtrace_jtab.getitemstring(k_row, "descr")
				tab_1.tabpage_2.dw_2.dataobject = kiuo_menu_logtrace_jtab.getitemstring(k_row, "dw")
				tab_1.tabpage_2.dw_2.settransobject(kguo_sqlca_db_magazzino)
				tab_1.tabpage_2.enabled = true
				tab_1.tabpage_2.visible = true
				tab_1.tabpage_2.dw_2.enabled = true
				tab_1.tabpage_2.dw_2.visible = true
			case 3
				tab_1.tabpage_3.text = kiuo_menu_logtrace_jtab.getitemstring(k_row, "descr")
				tab_1.tabpage_3.dw_3.dataobject = kiuo_menu_logtrace_jtab.getitemstring(k_row, "dw")
				tab_1.tabpage_3.dw_3.settransobject(kguo_sqlca_db_magazzino)
				tab_1.tabpage_3.enabled = true
				tab_1.tabpage_3.visible = true
				tab_1.tabpage_3.dw_3.enabled = true
				tab_1.tabpage_3.dw_3.visible = true
			case 4
				tab_1.tabpage_4.text = kiuo_menu_logtrace_jtab.getitemstring(k_row, "descr")
				tab_1.tabpage_4.dw_4.dataobject = kiuo_menu_logtrace_jtab.getitemstring(k_row, "dw")
				tab_1.tabpage_4.dw_4.settransobject(kguo_sqlca_db_magazzino)
				tab_1.tabpage_4.enabled = true
				tab_1.tabpage_4.visible = true
				tab_1.tabpage_4.dw_4.enabled = true
				tab_1.tabpage_4.dw_4.visible = true
			case 5
				tab_1.tabpage_5.text = kiuo_menu_logtrace_jtab.getitemstring(k_row, "descr")
				tab_1.tabpage_5.dw_5.dataobject = kiuo_menu_logtrace_jtab.getitemstring(k_row, "dw")
				tab_1.tabpage_5.dw_5.settransobject(kguo_sqlca_db_magazzino)
				tab_1.tabpage_5.enabled = true
				tab_1.tabpage_5.visible = true
				tab_1.tabpage_5.dw_5.enabled = true
				tab_1.tabpage_5.dw_5.visible = true
			case 6
				tab_1.tabpage_6.text = kiuo_menu_logtrace_jtab.getitemstring(k_row, "descr")
				tab_1.tabpage_6.dw_6.dataobject = kiuo_menu_logtrace_jtab.getitemstring(k_row, "dw")
				tab_1.tabpage_6.dw_6.settransobject(kguo_sqlca_db_magazzino)
				tab_1.tabpage_6.enabled = true
				tab_1.tabpage_6.visible = true
				tab_1.tabpage_6.dw_6.enabled = true
				tab_1.tabpage_6.dw_6.visible = true
			case 7
				tab_1.tabpage_7.text = kiuo_menu_logtrace_jtab.getitemstring(k_row, "descr")
				tab_1.tabpage_7.dw_7.dataobject = kiuo_menu_logtrace_jtab.getitemstring(k_row, "dw")
				tab_1.tabpage_7.dw_7.settransobject(kguo_sqlca_db_magazzino)
				tab_1.tabpage_7.enabled = true
				tab_1.tabpage_7.visible = true
				tab_1.tabpage_7.dw_7.enabled = true
				tab_1.tabpage_7.dw_7.visible = true
			case 8
				tab_1.tabpage_8.text = kiuo_menu_logtrace_jtab.getitemstring(k_row, "descr")
				tab_1.tabpage_8.dw_8.dataobject = kiuo_menu_logtrace_jtab.getitemstring(k_row, "dw")
				tab_1.tabpage_8.dw_8.settransobject(kguo_sqlca_db_magazzino)
				tab_1.tabpage_8.enabled = true
				tab_1.tabpage_8.visible = true
				tab_1.tabpage_8.dw_8.enabled = true
				tab_1.tabpage_8.dw_8.visible = true
			case 9
				tab_1.tabpage_9.text = kiuo_menu_logtrace_jtab.getitemstring(k_row, "descr")
				tab_1.tabpage_9.dw_9.dataobject = kiuo_menu_logtrace_jtab.getitemstring(k_row, "dw")
				tab_1.tabpage_9.dw_9.settransobject(kguo_sqlca_db_magazzino)
				tab_1.tabpage_9.enabled = true
				tab_1.tabpage_9.visible = true
				tab_1.tabpage_9.dw_9.enabled = true
				tab_1.tabpage_9.dw_9.visible = true
		end choose	
		
	next		
	



	
end subroutine

protected subroutine inizializza_8 () throws uo_exception;//

if tab_1.tabpage_9.dw_9.rowcount() = 0 then
	
	u_dw_inizializza(tab_1.tabpage_9.dw_9)

end if


end subroutine

on w_logtrace.create
call super::create
end on

on w_logtrace.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
	if isnull(kiuo_menu_logtrace_jtab) then destroy kiuo_menu_logtrace_jtab

	if isvalid(kiuf_logtrace_meca) then destroy kiuf_logtrace_meca

end event

type dw_print_0 from w_g_tab_3`dw_print_0 within w_logtrace
end type

type st_ritorna from w_g_tab_3`st_ritorna within w_logtrace
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_logtrace
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_logtrace
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_logtrace
end type

type st_stampa from w_g_tab_3`st_stampa within w_logtrace
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_logtrace
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_logtrace
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_logtrace
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_logtrace
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_logtrace
end type

type tab_1 from w_g_tab_3`tab_1 within w_logtrace
integer x = 0
integer y = 0
integer width = 4000
integer height = 3000
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

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 3963
integer height = 2872
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
boolean ki_link_standard_sempre_possibile = true
end type

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
boolean visible = false
integer width = 3963
integer height = 2872
boolean enabled = false
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer width = 3963
integer height = 2872
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 3963
integer height = 2872
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 3963
integer height = 2872
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 3963
integer height = 2872
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3963
integer height = 2872
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3963
integer height = 2872
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3963
integer height = 2872
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type st_duplica from w_g_tab_3`st_duplica within w_logtrace
end type

