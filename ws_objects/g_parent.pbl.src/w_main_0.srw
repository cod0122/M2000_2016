﻿$PBExportHeader$w_main_0.srw
$PBExportComments$windows principale di apertura
forward
global type w_main_0 from window
end type
type mdi_1 from mdiclient within w_main_0
end type
end forward

global type w_main_0 from window
integer width = 2848
integer height = 1852
boolean titlebar = true
string menuname = "m_main"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdidock!
windowstate windowstate = maximized!
long backcolor = 12632256
string icon = "main.ico"
boolean toolbarvisible = false
boolean clientedge = true
boolean center = true
integer transparency = 100
long tabbeddocumenttabsareacolor = 32567536
long tabbeddocumenttabsareagradientcolor = 16777215
long titlebaractivecolor = 32567536
long titlebaractivegradientcolor = 32567536
long titlebarinactivecolor = 67108864
long titlebarinactivegradientcolor = 32567536
long titlebarinactivetextcolor = 10789024
boolean tabbeddocumenttabicon = false
boolean tabbeddocumenttabscroll = true
windowdocktabshape tabbedwindowtabshape = windowdocktabsingleslanted!
long tabbeddocumentinactivetabbackcolor = 32567536
long tabbeddocumentinactivetabgradientbackcolor = 32238571
long tabbeddocumentinactivetabtextcolor = 8421504
long tabbeddocumentmouseovertabtextcolor = 32896
event u_open ( ) throws uo_exception
event u_show ( )
mdi_1 mdi_1
end type
global w_main_0 w_main_0

type prototypes

end prototypes

type variables
//--- Flag primo GIRO
boolean ki_flag_primo_giro = true
window kiw_this_window

//m_main m_main_0

constant string ki_suona_motivo_start = "Start.wav"

end variables

forward prototypes
protected subroutine smista_funz (string k_par_in)
protected subroutine apri_win_iniziale (string k_window_iniziale)
private subroutine imposta_password ()
public subroutine u_allarme_utente ()
public subroutine wf_initialize_winproperty ()
public subroutine u_open_toolbar ()
private function boolean u_if_update_software ()
public subroutine inizializza ()
public subroutine u_menu_init ()
end prototypes

event u_open();//
string k_titolo
string k_dataoggix
int k_ctr
kuf_base kuf1_base
st_tab_base_personale kst_tab_base_personale


try
//--- disattivo la toolbar
//this.SetToolbar(1, false)

//
//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(oldpointer)
	SetPointer(kkg.pointer_attesa)

//--- assegna il puntatore al MENU generale della MDI
	u_menu_init( )
//	ki_menu = this.menuid
	m_main.visible = false
//	m_main.autorizza_menu( )

	kuf1_base = create kuf_base

//--- memorizza l'anno di esercizio impostato sul BASE
	kguo_g.set_anno_procedura(integer(mid(kuf1_base.prendi_dato_base("anno"),2)))
//--- ZOOM: con il tasto CTRL?
	if mid(kuf1_base.prendi_dato_base(kuf1_base.kki_base_utenti_flagzoomctrl),2,1) = "S" then
		kguo_g.set_flagZOOMctrl(true)
	else
		kguo_g.set_flagZOOMctrl(false)
	end if		

//--- piglia dati standard personalizzati	
	try
		//kst_tab_base_personale.flag_suoni = trim(kuf1_base.get_dato_personale("flag_suoni"))
		kst_tab_base_personale.flag_suoni = trim(mid(kuf1_base.prendi_dato_base("flag_suoni"),2))
		kst_tab_base_personale.flag_salva_liste = trim(mid(kuf1_base.prendi_dato_base("flag_salva_liste"),2))
	catch (uo_exception kuo_exception2)
		kst_tab_base_personale.flag_suoni = ""
	end try
	if kst_tab_base_personale.flag_suoni = "S" then
		kguo_g.set_attiva_suoni(true) 
	else
		kguo_g.set_attiva_suoni(false) 
	end if
	if kst_tab_base_personale.flag_salva_liste = "S" then
		kguo_g.set_SALVA_LISTE(true) 
	else
		kguo_g.set_SALVA_LISTE(false) 
	end if

//--- set la path centrale sul SERVER
//	kGuf_data_base.set_path_base_del_server( ) 
	//kguo_path.set_path_icone( )
	kguo_path.set_path_base_del_server( ) 
	//KG_path_base_del_server = kguo_path.get_base_del_server( )
	//KG_PATH_BASE_DEL_SERVER_JOB = kguo_path.get_base_del_server_job( )
//--- set la path BASE ovvero dove risiedono ad esempio gli errori (spesso c:\at_m2000)
	kguo_path.set_path_base( )
	//kg_path_base = kguo_path.get_base()
//--- set PATH root dei doc elettronici
	kguo_path.set_doc_root()

//--- Verifica se interfaccia con E1 attivata
	try
		if kuf1_base.if_e1_enabled( ) then
			kguo_g.set_e1_enabled(true)
		else
			kguo_g.set_e1_enabled(false)
		end if

//--- Imposta le Variabli Globali dei Dati di Ora legale e UTC 	
		kuf1_base.set_oralegale_utc()

	catch (uo_exception kuo_exception1)
		kuo_exception1.messaggio_utente()
	finally
	end try

//	this.WindowState = maximized!

//--- assegna il puntatore alla Window x renderlo visibile negli script dell window
	kiw_this_window = this


#if defined PBNATIVE then
//--- apri win x 'finta' toolbar contente i riferimenti alle window della procedura aperte  
//	if kguo_g.if_w_toolbar_programmi( ) then  // ho attiva la gestione di questa toolbar?
//		open (w_toolbar_programmi)
//	end if
#end if

	try 
		k_titolo = kuf1_base.get_titolo_procedura()
	catch (uo_exception kuo_exception )
		k_titolo = "?????"
	end try

	this.title = trim(k_titolo) + " "

//--- toolbar subito visibile (metto invisibile la parte delle personalizzazioni)
#if defined PBNATIVE then
//	if kguo_g.if_w_toolbar_programmi( ) then  // ho attiva la gestione di questa toolbar?
//		this.toolbarvisible = true
//	else
//		this.toolbarvisible = false
//	end if
#else
//	this.toolbarvisible = false
#end if

//	this.SetToolbar(2, false)
//	this.SetToolbar(3, false)

//--- popola la data oggi
	k_dataoggix = MidA(kuf1_base.prendi_dato_base("dataoggi"), 2)
	if isdate(k_dataoggix) then
		kg_dataoggi = date (k_dataoggix)
	end if

//--- aggiornamento?
	if u_if_update_software( ) then
		event close( )
	else
		inizializza()	
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception

	
finally
	if isvalid(kuf1_base) then destroy kuf1_base
	SetPointer(kkg.pointer_default)
	
end try

end event

event u_show();//
//--- Suona Motivo di attivazione programma
	this.show( )
	kGuf_data_base.suona_motivo(ki_suona_motivo_start, 0)

end event

protected subroutine smista_funz (string k_par_in);
end subroutine

protected subroutine apri_win_iniziale (string k_window_iniziale);//
st_open_w k_st_open_w

	
	if trim(k_window_iniziale) > " " then 

//20/05/2019 SOLO TEMPORANEAMENTE SE LA WINDOW INIZIALE E' IL REPORT ALLORA IMPOSTA ST_INT_ARTR PER I TURNISTI
	
		setpointer(kkg.pointer_attesa)
	
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli; key2=cod sl-pt

		K_st_open_w.id_programma = trim(k_window_iniziale)
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = "  "
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = "1"
		K_st_open_w.key1 = " "
		K_st_open_w.key2 = " "
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		kguf_menu_window.open_w_tabelle(k_st_open_w)
								
		setpointer(kkg.pointer_default)

	end if
	
//	this.setredraw( true )
	
	

end subroutine

private subroutine imposta_password ();//=== Lancia il Logo iniziale
//open (w_about)
//
st_open_w kst_open_w



//===
//=== Menu Treeview
//===
	kst_open_w.id_programma = "srpassword_c"
	kst_open_w.flag_primo_giro = "S"
	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
	kst_open_w.flag_leggi_dw = " "
	kst_open_w.flag_cerca_in_lista = " "
	kst_open_w.key1 = string(kguo_utente.get_pwd())
	kst_open_w.key2 = " "
	kst_open_w.key3 = " "
	kst_open_w.key4 = " " 

	
	kguf_menu_window.open_w_tabelle(kst_open_w)


							
							



end subroutine

public subroutine u_allarme_utente ();//
st_memo_allarme kst_memo_allarme


try
	
	
	if kguf_memo_allarme.if_open_window_allarmi() then  // se Window attivabile 
		
		if kguf_memo_allarme.set_allarme_utente(kst_memo_allarme) then
			
			kguf_memo_allarme.u_attiva_memo_allarme_on()
			
			if kguf_memo_allarme.get_nr_avvisi( ) > 10 then
				kguf_memo_allarme.set_visualizza_allarme( )
			end if
		else
			kguf_memo_allarme.u_attiva_memo_allarme_hide( )
		end if

	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	

finally
	
	
end try



end subroutine

public subroutine wf_initialize_winproperty ();//
//long gl_tabAreaColor = RGB(41,57,85)	
//long gl_ActiveBarColor = RGB(255,243,205)
//long gl_splitebackcolor= rgb(240, 240, 240)
// 
//this.TabbedDocumentTabsAreaColor = gl_tabAreaColor
//this.TabbedDocumentTabsAreaGradientColor = gl_tabAreaColor
//This.TabbedWindowTabsAreaColor =	gl_tabAreaColor
//This.TabbedWindowTabsAreaGradientColor =	gl_tabAreaColor
//
//this.TabbedDocumentInActiveTabBackColor = gl_tabAreaColor
//this.TabbedDocumentInActiveTabGradientBackColor = gl_tabAreaColor
//This.TabbedWindowInActiveTabBackColor =	gl_tabAreaColor
//This.TabbedWindowInActiveTabGradientBackColor =	gl_tabAreaColor
//
//this.TabbedDocumentActiveTabBackColor = gl_ActiveBarColor
//this.TabbedDocumentActiveTabGradientBackColor = gl_ActiveBarColor
//This.TabbedWindowActiveTabBackColor =	gl_ActiveBarColor
//This.TabbedWindowActiveTabGradientBackColor =	gl_ActiveBarColor
//
//
//This.titleBarInactiveColor = 	gl_tabAreaColor
//This.titleBarInactiveGradientColor = 	gl_tabAreaColor
//This.titleBarActiveColor = 	gl_ActiveBarColor
//This.titleBarActiveGradientColor = 	gl_ActiveBarColor

//gs_registry = "\DockingWindow\Demo" // profilestring("dockwindow.ini", "registry", "RegistryName", "dockwindowtest")
//gs_solution_data = "APP"
end subroutine

public subroutine u_open_toolbar ();//
kuf_menu_tree kuf1_menu_tree

	kuf1_menu_tree = create kuf_menu_tree
//--- Apre la window con il menu TOOLBAR (w_menu_tree)
	kuf1_menu_tree.u_open( )
	if isvalid(kuf1_menu_tree) then destroy kuf1_menu_tree

end subroutine

private function boolean u_if_update_software ();//
boolean k_return
int k_ctr=0
string k_versione=""
kuf_program kuf1_program
kuf_base kuf1_base


	kuf1_base = create kuf_base
	
//--- Devo aggiornare i programmi?
	try
		if kuf1_base.if_update_proced_disponibile() then
			k_versione = string(kuf1_base.get_version( ))
			k_ctr = pos(k_versione,',') 
			if k_ctr > 0 then
				k_versione = replace(k_versione, k_ctr, 1,'.')
			end if
			
			kuf1_program = create kuf_program
	
			if messagebox ("Aggiornamento Automatico del software", &
								"E' disponibile la nuova versione " + k_versione + " del Programma, procedere con l'aggiornamento?", &
								 question!, YesNo!, 1) = 1 then
				k_return = kuf1_program.u_update_dev_version(false)			
			end if
		end if
		
	catch (uo_exception kuo2_exception)
		kuo2_exception.scrivi_log()
	end try
		

return k_return
end function

public subroutine inizializza ();//
int k_ctr=0
string k_window_iniziale, k_rcx
kuf_base kuf1_base



	if ki_flag_primo_giro then

		kuf1_base = create kuf_base
	
	// x un effetto migliore parte con trasparenza a 100 poi metto a zero quando sono pronto
	//	this.transparency = 0
	
		this.setredraw( true)
	
	//--- Gestione della window degli ALLERT
		if isvalid(kguf_memo_allarme) then
			kguf_memo_allarme.set_w_main( kiw_this_window )
		end if
	
//--- becco il valore del Tipo di modulo usato x la stampa dei barcode
		k_rcx = trim(kuf1_base.prendi_dato_base("barcode_modulo"))
		if left(k_rcx,1) = "0" then
			kGuf_data_base.Ki_barcode_modulo = mid(k_rcx,2,1)
		else
			kGuf_data_base.Ki_barcode_modulo=""
		end if

//--- Imposta parametri di Connessione ai DB 'ausiliari' alla Procedura
		try
			KGuo_sqlca_db_wm.set_profilo_db()
			k_rcx = trim(kuf1_base.prendi_dato_base("e1mcu"))
			if left(k_rcx,1) = "0" then
				kguo_g.E1MCU = mid(k_rcx,2)
			else
				kguo_g.E1MCU = ""
			end if
			KGuo_sqlca_db_e1.set_profilo_db()
			kguo_sqlca_db_pilota.set_profilo_db()
			kguo_sqlca_db_pilota_g3.set_profilo_db()
			KGuo_sqlca_db_plav.set_profilo_db()
			
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
		end try			
			
//--- Se NON utente MASTER
		if kguo_utente.get_pwd() <> 9999 then

//--- Apro finestra di inizio se richiesto				
			k_window_iniziale = trim(kuf1_base.prendi_dato_base(kuf1_base.kki_base_utenti_startfunz))
			if left(k_window_iniziale, 1) <> "1" and MidA(k_window_iniziale, 2) <> "nullo" then

				k_window_iniziale = trim(mid(k_window_iniziale, 2))
				
				if k_window_iniziale > " " then
		
	//--- Apre la prima windows
					apri_win_iniziale (k_window_iniziale)
					
				end if

			end if
			
		end if

		post u_open_toolbar( )

//--- get e visualizza eventuali allarmi MEMO
		u_allarme_utente( )

//--- Alert di apertura M2000 x una qlc ragione non funzia
//			try
//				kuf_alert kGuf_alert
//				st_alert kst_alert
//				kGuf_alert = create kuf_alert
//				kst_alert.allarme = kGuf_alert.kki_alert_ok
//				kst_alert.descr = "Utente " + kguo_utente.get_nome( ) + " sono le " + string(kguo_g.get_datetime_current( ), "hh:mm") + " di " + string(kguo_g.get_dataoggi( ), "dd.mmm.yy") + " e sei operativo su " + kguo_g.get_nome_computer( ) 
//				kGuf_alert.u_attiva_alert(kst_alert)
//			catch (uo_exception kuo2_exception)
//				
//			finally
//				//if isvalid(kuf1_alert) then destroy kuf1_alert
//			end try

	end if

//	this.changemenu( m_main )

	if isvalid(kuf1_base) then destroy kuf1_base
	
	post event u_show( )
	
	ki_flag_primo_giro = false

end subroutine

public subroutine u_menu_init ();//

	if not isvalid(this.menuid) or isnull(this.menuid) then
//--- assegna il puntatore al MENU generale della MDI
//		m_main = create m_main
//		ki_menu = this.menuid
//		ki_menu.visible = false
      this.menuid = m_main
	end if

	if isvalid(this.menuid) and not isnull(this.menuid) then
//		m_main.reset_menu_all( )
//		m_main.autorizza_menu( )
//		m_main.u_imposta_window_menu( )
		m_main.u_inizializza()

	end if

end subroutine

event closequery;//
//string k_titolo
//kuf_base kuf1_base
kuf_program kuf1_program


kuf1_program = create kuf_program

//=== Vedo se ci sono finestre aperte
if not kuf1_program.u_if_chiudi_procedura() then

//	kuf1_base = create kuf_base
//	k_titolo = Mid(kuf1_base.prendi_dato_base("titolo"), 2) //prendo il titolo della procedura
//	destroy kuf1_base
	
	if messagebox("Chiude " + trim(this.title), "Confermare la chiusura del programma",	question!, yesno!, 1) = 2 then
		return 1
	else
	end if
end if

destroy kuf1_program

if isvalid(m_main) then
	m_main.u_close_main()
end if

//--- per chiudere la window dell'allert poichè la MDI la chiude in automatico
kGuf_memo_allarme.set_chiudi_w_memo_allarme_on()

end event

on w_main_0.create
if this.MenuName = "m_main" then this.MenuID = create m_main
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_main_0.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event open;//
try

	this.hide( )
	
	SetPointer(kkg.pointer_attesa)

	this.icon = kkg.MAIN_ICON
	
	wf_initialize_winproperty( )

	post event u_open( )


catch (uo_exception kuo_exception)
	kuo_exception.post messaggio_utente()
	
finally
	//SetPointer(kkg.pointer_default)
	
	
end try
end event

event resize;////
//#if defined PBNATIVE then
//	if kguo_g.if_w_toolbar_programmi( ) then
//		if isvalid (w_toolbar_programmi) then
//			w_toolbar_programmi.imposta_toolbar_programmi()
//	//	ridimensiona_toolbar_programmi()
//		end if
//	end if
//#end if
//
//dw_current.move(this.x + this.width + dw_current.width, this.y + this.height - dw_current.height)
//dw_current.visible = true

//mdi_1.move(0, 5000 + newheight -  this.workspaceheight())
//mdi_1.resize(newwidth, newheight - 5000 - ( newheight - this.workspaceheight()))

//resize ribbonbar
//rbb_1.move(0,newheight - this.workspaceheight()  )
//rbb_1.width = newwidth
//mdi_1.move(0,rbb_1.height +newheight -  this.workspaceheight())
//mdi_1.resize(newwidth,newheight - rbb_1.height - ( newheight - this.workspaceheight()))

end event

event close;//
int k_ctr

//--- Riversa tutte le window modalità docking in Tabella
	try
		if isvalid(KGuf_base_docking) then
			KGuf_base_docking.u_set_dockingstate_window_opened()
			k_ctr = KGuf_base_docking.tb_update( )
		end if
	catch (uo_exception kuo_exception)
//		kuo_exception.messaggio_utente()
	end try

//--- svuota cartella TEMP
	kuf_utility kuf1_utility
	kuf1_utility = create kuf_utility
	kuf1_utility.u_svuota_temp( )

halt close

end event

event activate;//
//u_menu_init()

end event

type mdi_1 from mdiclient within w_main_0
long BackColor=12632256
end type

