$PBExportHeader$w_recover_e1_data.srw
forward
global type w_recover_e1_data from w_g_tab_3
end type
type dw_1_shared from uo_d_std_0 within tabpage_1
end type
type dw_2_shared from uo_d_std_0 within tabpage_2
end type
type dw_3_shared from uo_d_std_0 within tabpage_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_recover_e1_data from w_g_tab_3
integer x = 169
integer y = 148
integer width = 3186
integer height = 1656
string title = "Esporta dati x il WEB"
boolean resizable = false
long backcolor = 32501743
integer animationtime = 0
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
boolean ki_toolbar_programmi_attiva_voce = false
boolean ki_sincronizza_window_consenti = false
boolean ki_aggiorna_richiesta_conferma = false
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_msg_dopo_update = false
string ki_syntaxquery = ""
string ki_dw_titolo_modif_1 = ""
end type
global w_recover_e1_data w_recover_e1_data

type variables
//
private kuf_recover_e1_data kiuf_recover_e1_data
end variables

forward prototypes
protected function string inizializza ()
protected subroutine open_start_window ()
public subroutine u_esporta ()
protected subroutine inizializza_1 () throws uo_exception
public subroutine u_recover_cube ()
end prototypes

protected function string inizializza ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//

	if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
		if inserisci( ) = 0 then
						
			tab_1.tabpage_1.dw_1.setitem(1, "data_da", today())
			tab_1.tabpage_1.dw_1.setitem(1, "data_a", relativedate(today(), -30))
						
		end if

	end if

	
return "0"


end function

protected subroutine open_start_window ();//
kiuf_recover_e1_data = create kuf_recover_e1_data

end subroutine

public subroutine u_esporta ();//
string k_file, k_rcx
long k_nr_rec, k_rows
string k_titolo
datawindow kdw_1
DataStore kds_1
kuf_file_explorer kuf1_file_explorer
kuf_utility kuf1_utility
kuf_xsmart_pickup_lots kuf1_xsmart_pickup_lots
st_esito kst_esito


try	
	
	kuf1_utility = create kuf_utility

//--- get di quale elenco esportare	
	choose case tab_1.selectedtab 
		case 1 
			k_titolo = trim(tab_1.tabpage_1.text)
			//kdw_1 = tab_1.tabpage_1.dw_1
			kdw_1 = tab_1.tabpage_1.dw_1_shared
		case 2 
			k_titolo = trim(tab_1.tabpage_2.text)
			//kdw_1 = tab_1.tabpage_2.dw_2
			kdw_1 = tab_1.tabpage_2.dw_2_shared
		case 3
			k_titolo = trim(tab_1.tabpage_3.text)
			kds_1 = create datastore
			kds_1.dataobject = tab_1.tabpage_3.dw_3.dataobject
			tab_1.tabpage_3.dw_3_shared.RowsCopy(1, tab_1.tabpage_3.dw_3_shared.RowCount(), primary!, kds_1, 1, primary!)
	end choose
	
	if tab_1.selectedtab = 1 or tab_1.selectedtab = 2 then
		//k_file = u_get_filename_exp(k_titolo)
		
		if k_file > " " then
			SetPointer(kkg.pointer_attesa)
			kds_1 = create DataStore
			kds_1.dataobject = kdw_1.dataobject
			k_rows = kdw_1.rowcount( )
			kdw_1.ROWscopy( 1, k_rows, primary!, kds_1, 1, primary!)
	
			k_rows = kds_1.rowcount( )
	
			choose case tab_1.selectedtab 
				case 1 
	//--- Filtra solo le righe con il Listino E1
					kds_1.setfilter("e1litm > ' '")
					if kds_1.filter( ) > 0 then
						k_rcx = kds_1.Modify("cod_cli_t.text='Id_cliente'")
	//--- queste colonne non voglio che escano in CSV		
						k_rcx = kds_1.Modify("data.visible='0'")
						k_rcx = kds_1.Modify("attivo.visible='0'")
						k_rcx = kds_1.Modify("e1litm.visible='0'")
						k_rcx = kds_1.Modify("id_listino.visible='0'")
						//k_rcx = kds_1.Modify("fattura_per.visible='0'")  // TEMPORANEO
					end if
					
				case 2
					
			end choose
			
	//--- Produzione del file CSV		
			k_nr_rec = kuf1_utility.u_ds_to_csv(kds_1, k_file)
			
			SetPointer(kkg.pointer_default)
			
		end if

	else
		//--- esporta dati Ritiro Lotto
		if tab_1.selectedtab = 3 then
			kuf1_xsmart_pickup_lots = create kuf_xsmart_pickup_lots
			kst_esito = kuf1_xsmart_pickup_lots.export_pickup_lots(kds_1)
			if kst_esito.esito = kkg_esito.ok then
				k_nr_rec = kds_1.rowcount()
				if k_nr_rec > 0 then
					k_file = kuf1_xsmart_pickup_lots.get_export_file_name( )
				end if
			end if
		end if
	end if		
	if k_nr_rec > 0 and k_file > " " then
		if messagebox("Operazione terminata correttamente",  "Vuoi aprire subito il file contenente " + string(k_nr_rec) + " righe dei dati esportati~n~r"&
									+ trim(k_file), Question!, yesno!, 1) = 1 then
			SetPointer(kkg.pointer_attesa)
			kuf1_file_explorer = create kuf_file_explorer
			kuf1_file_explorer.of_execute( trim(k_file))
			destroy kuf1_file_explorer
		end if
	else
		messagebox("Estrazione Dati", "Nessuna esportazione Eseguita!")
	end if

//--- Ripristina path di lavoro
	kGuf_data_base.setta_path_default()
	
catch(uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )

finally
	if isvalid(kds_1) then destroy kds_1
	if isvalid(kuf1_xsmart_pickup_lots) then destroy kuf1_xsmart_pickup_lots

end try


end subroutine

protected subroutine inizializza_1 () throws uo_exception;//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
int k_rc


	tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.elenco 

	if tab_1.tabpage_2.dw_2.rowcount() = 0 then
	
		k_rc = tab_1.tabpage_2.dw_2.retrieve() 
		
		choose case k_rc

			case is < 0		
				kguo_exception.set_st_esito_err_dw(tab_1.tabpage_2.dw_2, "Errore in lettura Dati 'Cube Interface' per E1. ")
				throw kguo_exception

			case 0
				tab_1.tabpage_2.dw_2.reset()

		end choose
		tab_1.tabpage_2.dw_2.event getfocus( )
		
		attiva_tasti()
	end if




end subroutine

public subroutine u_recover_cube ();//
long k_n_lotti
string k_tabname
uo_ds_std_1 kds_recover_e1_data

try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

	if tab_1.tabpage_1.dw_1.getitemnumber( 1, "impianto") > 0 &
				and tab_1.tabpage_1.dw_1.getitemstring( 1, "cube") > " " then
	else
		messagebox("Recupero dati E1", "Indicare i dati da elaborare. Operazione interrotta!", stopsign!)
		return
	end if
		
	if messagebox("Reupero dati", "Procedere con il recupero dati?", question!, yesno!, 2) = 2 then
		kguo_exception.messaggio_utente("Recupero dati", "Operazione interrotta dall'utente.")
	end if

// start elab
	kds_recover_e1_data = create uo_ds_std_1
	kds_recover_e1_data.dataobject = tab_1.tabpage_1.dw_1.dataobject

	tab_1.tabpage_1.dw_1.sharedata(kds_recover_e1_data)

	if tab_1.tabpage_1.dw_1.getitemstring( 1, "cube") = "S" then
		k_tabname = "e1_wo_f5537001"
		k_n_lotti = kiuf_recover_e1_data.u_run_recover_cube_data(kds_recover_e1_data)
	end if

	if k_n_lotti > 0 then
		messagebox("Recupero dati E1", "Elaborazione terminata, sono stati trovati " + string(k_n_lotti) + " Lotti. " &
				+ kkg.acapo + "Verificare la tabella " + k_tabname)
	else
		messagebox("Recupero dati E1", "Non è stato trovato nessun Lotto da elaborare. ")
	end if	
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	SetPointer(kkg.pointer_default)

end try

end subroutine

on w_recover_e1_data.create
int iCurrent
call super::create
end on

on w_recover_e1_data.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_recover_e1_data) then destroy kiuf_recover_e1_data
end event

type dw_print_0 from w_g_tab_3`dw_print_0 within w_recover_e1_data
end type

type st_ritorna from w_g_tab_3`st_ritorna within w_recover_e1_data
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_recover_e1_data
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_recover_e1_data
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_recover_e1_data
integer x = 2711
integer y = 1444
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
string text = ""
end type

type st_stampa from w_g_tab_3`st_stampa within w_recover_e1_data
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_recover_e1_data
integer x = 1175
integer y = 1440
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
string text = ""
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_recover_e1_data
integer x = 503
integer y = 1436
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
string text = ""
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_recover_e1_data
integer x = 1970
integer y = 1444
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
string text = ""
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_recover_e1_data
integer x = 2341
integer y = 1444
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
string text = ""
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_recover_e1_data
integer x = 1600
integer y = 1444
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
boolean enabled = false
string text = ""
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

type tab_1 from w_g_tab_3`tab_1 within w_recover_e1_data
integer width = 3040
integer height = 1396
integer taborder = 0
integer weight = 0
string facename = ""
long backcolor = 32172778
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

event tab_1::u_constructor;call super::u_constructor;//
							// 1     2     3     4     5     6      7      8     9   
ki_tabpage_enabled = {true, true, true, false, false, false, false, false, false} // disabilita alcune tabpage
super::event u_constructor( )
 
end event

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 3003
integer height = 1268
string text = "Recupera dati E1"
long tabtextcolor = 0
long tabbackcolor = 33554431
string picturename = "DataPipeline!"
long picturemaskcolor = 553648127
dw_1_shared dw_1_shared
end type

on tabpage_1.create
this.dw_1_shared=create dw_1_shared
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1_shared
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_1_shared)
end on

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 14
integer y = 44
integer width = 2533
integer height = 1144
integer taborder = 0
string title = ""
string dataobject = "d_recover_e1_data"
boolean hsplitscroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_primo_giro = true
end type

event dw_1::buttonclicked;call super::buttonclicked;//
if dwo.name = "b_run" then
	u_recover_cube( )
end if

end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
integer x = 507
integer y = 832
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 31909606
string text = "Dati tab. e1_wo_f5537001"
long tabtextcolor = 0
long tabbackcolor = 32501743
string picturename = "DataPipeline!"
long picturemaskcolor = 553648127
dw_2_shared dw_2_shared
end type

on tabpage_2.create
this.dw_2_shared=create dw_2_shared
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2_shared
end on

on tabpage_2.destroy
call super::destroy
destroy(this.dw_2_shared)
end on

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer y = 24
integer width = 2661
integer height = 1180
integer taborder = 0
boolean enabled = true
string title = ""
string dataobject = "d_e1_wo_f5537001_l"
boolean hsplitscroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_sempre_possibile = true
boolean ki_d_std_1_primo_giro = true
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 31909606
long tabtextcolor = 0
long tabbackcolor = 33544171
long picturemaskcolor = 553648127
dw_3_shared dw_3_shared
end type

on tabpage_3.create
this.dw_3_shared=create dw_3_shared
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3_shared
end on

on tabpage_3.destroy
call super::destroy
destroy(this.dw_3_shared)
end on

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean visible = true
integer y = 48
integer width = 2583
integer height = 1156
integer taborder = 0
boolean enabled = true
string title = ""
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_sempre_possibile = true
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 32501743
string text = ""
long tabtextcolor = 0
long tabbackcolor = 16777215
long picturemaskcolor = 553648127
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
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 3003
integer height = 1268
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 3003
integer height = 1268
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3003
integer height = 1268
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3003
integer height = 1268
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3003
integer height = 1268
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type st_duplica from w_g_tab_3`st_duplica within w_recover_e1_data
end type

type dw_1_shared from uo_d_std_0 within tabpage_1
boolean visible = false
integer x = 2501
integer y = 500
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_listino_x_smart_shared"
boolean border = false
boolean livescroll = false
end type

type dw_2_shared from uo_d_std_0 within tabpage_2
boolean visible = false
integer x = 2190
integer y = 608
integer taborder = 90
boolean bringtotop = true
string dataobject = "ds_mrf_x_smart_shared"
boolean border = false
boolean livescroll = false
end type

type dw_3_shared from uo_d_std_0 within tabpage_3
boolean visible = false
integer x = 2647
integer y = 352
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_xsmart_instock_shared"
boolean border = false
boolean livescroll = false
end type

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

