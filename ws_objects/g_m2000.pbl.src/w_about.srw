$PBExportHeader$w_about.srw
forward
global type w_about from window
end type
type cb_start from picturebutton within w_about
end type
type dw_about from datawindow within w_about
end type
end forward

global type w_about from window
boolean visible = false
integer x = 672
integer y = 264
integer width = 2021
integer height = 1428
boolean titlebar = true
string icon = "main.ico"
boolean center = true
event u_key pbm_keydown
event ue_open ( )
event u_pbm_lbuttondown pbm_lbuttondown
cb_start cb_start
dw_about dw_about
end type
global w_about w_about

type variables

//
st_open_w kist_open_w
//kuf_sr_sicurezza kiuf_sr_sicurezza
kuf_sr_utenti kiuf_sr_utenti


end variables

forward prototypes
private subroutine imposta_password ()
public function boolean u_check_date ()
public subroutine u_set_menu ()
public subroutine u_update_software ()
public subroutine u_close ()
public subroutine u_inizializza ()
public subroutine u_start ()
public function boolean if_connesso_db () throws uo_exception
public function boolean u_authentication ()
private function any db_check_pwd ()
public subroutine set_connesso_display (boolean a_connesso) throws uo_exception
end prototypes

event ue_open();//
int k_revision=0
string k_build=""
st_esito kst_esito
kuf_utility kuf1_utility
environment kenv
pointer kpointer


try
	
	kpointer = setpointer(hourglass!)
	
	dw_about.move(1,1)
	dw_about.resize(this.width, this.height)
	//st_versione.text = kkG_versione
	
	kuf1_utility = create kuf_utility	
	
	this.title = trim(this.title) + "  Versione " + kguo_g.get_app_release( ) 
	this.title = this.title + " su " + trim(kuf1_utility.u_nome_computer()) //prendo nome del Computer
	
	kiuf_sr_utenti = create kuf_sr_utenti

	dw_about.insertrow(0)

	k_revision = GetEnvironment(kenv)
	if k_revision = 1 then
		k_revision = kenv.pbbuildnumber   //--- get del numero di build di PB
		if k_revision > 0 then
			k_build = "pb build: " + string(k_revision)
		end if
	end if
	dw_about.setitem(1, "st_rev", k_build)
	
	cb_start.visible = false

	//dw_about.setitem(1, "st_ultimo_utente_login_data", "")
	dw_about.modify("sle_password.protect = '1' sle_utente.protect = '1'")
	dw_about.modify("sle_password.Background.Color='"+ string(kkg_colore.campo_disattivo)+"' sle_utente.Background.Color='"+ string(kkg_colore.campo_disattivo)+"'")
	dw_about.setitem(1, "sle_utente", kguo_utente.get_codice())
		
//	if kuf1_utility.u_check_network() then
//	else
//		dw_about.setitem(1, "st_net", "Rete Assente")
//	end if
//
//	u_check_caps_on()
//
//	this.show( )
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )
	halt close

finally
	if isvalid(kuf1_utility) then destroy kuf1_utility
	
	dw_about.visible = true
	dw_about.setfocus( )
	
	setpointer(kpointer)
	
end try



end event

private subroutine imposta_password ();//=== Lancia il Logo iniziale
//open (w_about)
//
st_open_w kst_open_w
kuf_menu kuf1_menu


	kuf1_menu = create kuf_menu
	kuf1_menu.set_tab_menu_window( )
	destroy kuf1_menu

//===
//=== Menu Treeview
//===
	kst_open_w.id_programma = "srpassword_c"
	kst_open_w.flag_primo_giro = "S"
	kst_open_w.flag_modalita = "mo"
	kst_open_w.flag_adatta_win = "s"
	kst_open_w.flag_leggi_dw = " "
	kst_open_w.flag_cerca_in_lista = " "
	kst_open_w.key1 = string(kguo_utente.get_id_utente( )) // get_pwd())
	kst_open_w.key2 = " "
	kst_open_w.key3 = " "
	kst_open_w.key4 = " " 

	
	kguf_menu_window.open_w_tabelle(kst_open_w)


							
							



end subroutine

public function boolean u_check_date ();//---
//---  Controlla che la data sia conguente
//---
boolean k_return = false
datetime k_datetime
int k_anno, k_anno_base
string k_dato
kuf_base kuf1_base


kuf1_base = create kuf_base

k_datetime = kGuf_data_base.prendi_x_datins()
k_anno = integer(string(k_datetime, "yyyy"))

k_dato = kuf1_base.prendi_dato_base("anno")
if left(k_dato, 1) = "0" then
	if isnumber(mid(k_dato, 2)) then
		k_anno_base = integer(mid(k_dato, 2))
		if k_anno = k_anno_base or k_anno = (k_anno_base + 1) then
			k_return = true
		end if
	end if
end if

destroy kuf1_base

if not k_return then
	kguo_exception.inizializza( )
	kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali)
	kguo_exception.setmessage( "ATTENZIONE DATA ERRATA", "La data " + string(k_datetime, "[ShortDate]") &
					+ " rilevata su questo terminale non è conguente con l'anno " + string(k_anno_base) + " indicato in Proprità Azienda come Anno di esercizio." &
					+ "~n~rATTENZIONE qualunque modifica ai dati potrebbe essere dannosa.")
	kguo_exception.messaggio_utente( )
end if

return k_return

end function

public subroutine u_set_menu ();//
kuf_menu kuf1_menu


	kuf1_menu = create kuf_menu
//--- Popola Tabella della SICUREZZA: abilitazione alle funzioni x Utente
	kuf1_menu.set_tab_menu_window( )
	destroy kuf1_menu

	if isvalid(w_main) then
		m_main.u_inizializza( ) 
//		m_main.autorizza_menu()
	end if
end subroutine

public subroutine u_update_software ();//
kuf_program kuf1_program
//kuf_utility kuf1_utility
//st_esito kst_esito


	this.enabled = false
	cb_start.enabled = false

	kuf1_program = create kuf_program
	if kuf1_program.u_update_dev_version(true) then

		u_close( )
		
	else
		dw_about.event u_set_st_informa("Aggiornamento software non riuscito.")
		//st_informa.visible = true
		this.enabled = true
		cb_start.enabled = true
	end if

	destroy kuf1_program

//	if messagebox ("Aggiornamento del software", "Eseguire l'aggiornamento dei programmi di M2000?", &
//					 question!, YesNo!, 2) = 1 then
//
//		this.enabled = false
//		cb_start.enabled = false
//		st_informa.text = "Aggiornamento software:  chiusura archivi in esecuzione...."
//		st_informa.visible = true
//		
//		oldpointer = SetPointer(HourGlass!)
//
////		kuf1_db = create kuf_db			 
//		
//		try
//			KGuo_sqlca_db_magazzino.db_connetti()
//
//			kuf1_program = create kuf_program			 
//			//kuf1_utility.u_aggiorna_procedura()			
//			kuf1_program.u_aggiorna_procedura_diprova( )
//			destroy kuf1_program
//
//		catch (uo_exception kuo_exception)
//				
//			kst_esito =kuo_exception.get_st_esito( )
//			kuf1_utility = create kuf_utility
//			if kuf1_utility.u_check_network() then
//				st_informa.text = "Problemi di connessione con il DB " + trim(kst_esito.sqlerrtext)
////				messagebox("Problemi di connessione con il DB", trim(kst_esito.sqlerrtext ))
//			else
//				st_informa.text = "Attenzione tentativo di connessione dati al Database Server fallita"
//				//messagebox("Connessione al DB", "Attenzione tentativo di connessione dati al Database Server fallita")
//			end if
//			st_informa.visible = true
//			destroy kuf1_utility		
//			
//		finally	
////			destroy kuf1_db
//
//		end try 
//
//		
//		 SetPointer(oldpointer)
//
////--- ESCE PROCEDURA		
//		close(this)
//
//		
//	end if
//
end subroutine

public subroutine u_close ();//
	try
		kguo_sqlca_db_magazzino.db_disconnetti( )   // disconnessione dal DB
	catch (uo_exception kuo_exception)
	end try

//--- ESCE PROCEDURA		
	close(this)

end subroutine

public subroutine u_inizializza ();string k_path_risorse
string k_ultimo_utente_login_data, k_utente_codice
int k_revision=0
string k_build=""
st_esito kst_esito 
kuf_base kuf1_base
kuf_utility kuf1_utility
//kuf_file_explorer kuf1_file_explorer
environment kenv
pointer kpointer


try
	
	kpointer = setpointer(hourglass!)

	kuf1_utility = create kuf_utility	
	
	if kist_open_w.flag_modalita = kkg_flag_modalita.visualizzazione then
	
		cb_start.visible = false
		
		dw_about.modify("sle_password.protect = '1' sle_utente.protect = '1'")
		dw_about.modify("sle_password.Background.Color='"+ string(kkg_colore.campo_disattivo)+"' sle_utente.Background.Color='"+ string(kkg_colore.campo_disattivo)+"'")
		dw_about.setitem(1, "sle_utente", kguo_utente.get_codice())
	
	else
		dw_about.modify("sle_password.protect = '0' sle_utente.protect = '0'")
		dw_about.modify("sle_password.Background.Color='"+ string(kkg_colore.campo_attivo)+"' sle_utente.Background.Color='"+ string(kkg_colore.campo_attivo)+"'")
		dw_about.setitem(1, "sle_utente", kguo_utente.get_codice())
		
		kuf1_base = create kuf_base
		k_utente_codice = trim(mid(kuf1_base.prendi_dato_base("ultimo_utente_login_nome"), 2))
		if len(trim(k_utente_codice)) = 0 or trim(k_utente_codice) = "nullo" then
			k_utente_codice = trim(mid(kuf1_base.prendi_dato_base("utente_login"), 2))
		end if
		k_ultimo_utente_login_data = trim(mid(kuf1_base.prendi_dato_base("ultimo_utente_login_data"), 2))
		
		if len(trim(k_utente_codice)) = 0 then
			k_utente_codice = " "
		end if
		kGuo_utente.set_codice(k_utente_codice)
	
		dw_about.setitem(1, "sle_utente", k_utente_codice)
		//sle_utente.text = k_utente_codice
		if len(trim(k_ultimo_utente_login_data)) = 0 or trim(k_ultimo_utente_login_data) = "nullo" then
			dw_about.setitem(1, "st_ultimo_utente_login_data", "")
			//st_ultimo_utente_login_data.text = " "
		else
			dw_about.setitem(1, "st_ultimo_utente_login_data", "ultimo accesso: " + trim(k_ultimo_utente_login_data) &
								 + "  (" + trim(k_utente_codice) + ") ")
			//st_ultimo_utente_login_data.text = "ultimo accesso: " + trim(k_ultimo_utente_login_data) &
			//					 + "  (" + trim(k_utente_codice) + ") "
		end if
	
		dw_about.setcolumn("sle_password")
		
		dw_about.modify("cb_img_start.enabled = '1'")
		
	end if
	
	set_connesso_display( if_connesso_db() )
	
	if kuf1_utility.u_check_network() then
		dw_about.setitem(1, "st_net", "ON")
	else
		dw_about.setitem(1, "st_net", "OFF")
	end if
	if kuf1_utility.u_check_caps_on() then
		dw_about.setitem(1, "st_caps", "ON")
	else
		dw_about.setitem(1, "st_caps", "OFF")
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )
	halt close

finally
	if isvalid(kuf1_utility) then destroy kuf1_utility
	if isvalid(kuf1_base) then destroy kuf1_base
	
	setpointer(kpointer)
	this.show( )
	this.setfocus( )
	
end try



end subroutine

public subroutine u_start ();//
boolean k_chiudi = false
boolean k_db_connected
string k_utente,  k_passwd
st_esito kst_esito
kuf_utility kuf1_utility
kuf_menu_window kuf1_menu_window
kuf_base kuf1_base
st_tab_base kst_tab_base


//try

	setpointer(kkg.pointer_attesa)
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	kuf1_base = create kuf_base

	//st_informa.visible = false
	dw_about.event u_set_st_informa("")

	try 
		kGuf_data_base.u_set_uo_sqlca_db_magazzino()  // rifà tutta la connessione al DB principale
		k_db_connected = if_connesso_db( )
		if not k_db_connected then
	
			k_db_connected = kguo_sqlca_db_magazzino.db_connetti( ) //ritenta la connessione al DB
		
		end if
	
		set_connesso_display( k_db_connected )
	
	catch (uo_exception kuo_exception)
		
		dw_about.event u_set_st_informa("Fallita connesione alla Base Dati !" + kkg.acapo + trim(kuo_exception.kist_esito.sqlerrtext) + ".")
		
	end try
		
//	if not kiuf_sr_utenti.u_if_master(k_passwd) then
//		if not u_authentication() then	
//			kst_esito.esito = kkg_esito.ko
//		end if
//	end if

if kst_esito.esito <> kkg_esito.ok then	

	//KGuo_sqlca_db_magazzino.db_disconnetti()
	dw_about.setitem(1, "sle_password", "")
	dw_about.setcolumn("sle_password")
	
else
	
//--- Se Connessione OK inizio con il controllo della password digitata
	if db_check_pwd() then

//--- Segnala il logon dell'applicazione (I=messaggio Informativo)
		kst_esito.esito = kguo_exception.KK_st_uo_exception_tipo_LOGIN
		kst_esito.sqlcode = KGuo_sqlca_db_magazzino.sqlcode
		kst_esito.sqlerrtext = "Connessione Accesso alla Procedura M2000 Accettata. " &
								    + " Utente di login: " + kguo_utente.get_codice()
		kguo_exception.set_esito(kst_esito)

////--- pswd ok
//	if kguo_utente.get_pwd() > 0 then
		
		k_chiudi = true
		
		if isvalid(w_main) = false then

			u_set_menu( )

			open(w_main)
				
		else
//--- w_main già aperta per cui lancio solo l'evento OPEN

			u_set_menu( )

			w_main.inizializza()
				
		end if

//--- Salvo in INI il nome utente collegato e la data-ora
		kst_tab_base.key = "ultimo_utente_login_nome" 
		kst_tab_base.key1 = kguo_utente.get_codice() 
		kuf1_base.metti_dato_base(kst_tab_base)
		kst_tab_base.key = "ultimo_utente_login_data" 
		kst_tab_base.key1 = string(now(), "dd/mm/yy  hh:mm")
		kuf1_base.metti_dato_base(kst_tab_base)

////---- compatta il codice Utente
//		kg_utente_comp = kguo_utente.get_comp()

	else
	//--- pwd non ok
		dw_about.setitem(1, "sle_password", "")
		dw_about.setcolumn("sle_password")

//--- Segnala il login dell'applicazione (I=messaggio Informativo)
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = KGuo_sqlca_db_magazzino.sqlcode
		kst_esito.sqlerrtext = "Connessione alla Procedura M2000 Non Accettata! " &
								    + " Tantato da Utente: " + kguo_utente.get_codice()
		kguo_exception.set_esito(kst_esito)
		
	end if
		
end if

if isvalid(kuf1_base) then destroy kuf1_base

setpointer(kkg.pointer_default)
	
if k_chiudi then
	close(this)
end if


end subroutine

public function boolean if_connesso_db () throws uo_exception;//
boolean k_return


try

	if kguo_sqlca_db_magazzino.if_connesso( ) then
		k_return = true
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try
	

return k_return
end function

public function boolean u_authentication ();// SHEKAR - LDAP Authentication
boolean k_return
int	li_Result
long		ll_Color
string	ls_Username, ls_Password, ls_Domain, ls_Message
n_login kn_login
string sle_Username, sle_Password, sle_Domain   
st_esito kst_esito
kuf_utility kuf1_utility


SetPointer( HourGlass! )

kn_login = create n_login

ls_Domain   = kguo_utente.ki_domain
ls_Username = trim(dw_about.getitemstring(1, "sle_utente"))
ls_Password = trim(dw_about.getitemstring(1, "sle_password"))

li_Result = kn_login.u_authentication(ls_Username, ls_Password, ls_Domain, "AD")
//
IF li_Result > 0 THEN		// 1
	k_return = true
//	ll_Color   = C_COLOR_GREEN
	ls_Message = kn_login.C_LOGIN_SUCCESS_MESSAGE
	// TODO: Go ahead and login into the database "implicitly", now...
ELSE
//	ll_Color = C_COLOR_RED
	
	Beep( 1 )		// Audible error
	
	kuf1_utility = create kuf_utility
	if not kuf1_utility.u_check_network() then
		ls_Message = "Accesso non Riuscito, problemi di connessione al Server di rete!"
	else
	
		IF li_Result     = kn_login.C_LOGIN_ERROR_USERNAME THEN	// -1
			ls_Message    = kn_login.C_LOGIN_ERROR_USERNAME_MESSAGE
	//		lsle_Control  = sle_Username
		ELSEIF li_Result = kn_login.C_LOGIN_ERROR_PASSWORD THEN	// -2
			ls_Message    = kn_login.C_LOGIN_ERROR_PASSWORD_MESSAGE
	//		lsle_Control  = sle_Password
		ELSEIF li_Result = kn_login.C_LOGIN_ERROR_DOMAIN THEN		// -3
			ls_Message    = kn_login.C_LOGIN_ERROR_DOMAIN_MESSAGE
	//		lsle_Control  = sle_Domain
		ELSE		// 0
			ls_Message    = kn_login.C_LOGIN_FAILURE_MESSAGE
	//		lsle_Control  = sle_Username
		END IF
		
	end if

//--- Segnala il tentativo di Start dell'applicazione (I=messaggio Informativo)
	kst_esito = kguo_exception.inizializza(this.classname())
	kst_esito.esito = kguo_exception.kk_st_uo_exception_tipo_dati_utente
	kst_esito.sqlerrtext = "Avvio applicazione M2000 - "  &
								+ " Autenticazone fallito: " + ls_Message + ", " &
								+ " Utente presunto: " + kguo_utente.get_codice()
	kguo_exception.set_esito(kst_esito)

	//kguo_g.set_anno_procedura(integer(mid(kuf1_base.prendi_dato_base("anno"),2)))
	//u_check_date( )  // controlla che la data di lavoro sia coerente

END IF

dw_about.event u_set_st_informa(" " + ls_Message)
//st_informa.visible = true


destroy kn_login
destroy kuf1_utility		

RETURN k_return

end function

private function any db_check_pwd ();//
boolean k_return = false
string k_passwd, k_utente
int k_ctr
st_tab_sr_utenti kst_tab_sr_utenti  
st_esito kst_esito


try

	kGuo_utente.set_pwd(0)
	
	k_utente = trim(dw_about.getitemstring(1, "sle_utente"))
	if k_utente > " " then
	else
		k_utente = kguo_utente.get_codice()
	end if
	//k_ctr = dw_about.rowcount()
	k_passwd = trim(dw_about.getitemstring(1, "sle_password"))
	if k_passwd > " " then
	else
		k_passwd = ""
	end if
		
	kst_tab_sr_utenti.codice = trim(k_utente)
	kst_tab_sr_utenti.password = trim(k_passwd)
	k_return = kiuf_sr_utenti.check_user_password (kst_tab_sr_utenti)

//--- Utente esistente imposto variabili globali
	if kst_tab_sr_utenti.id > 0 then
		kguo_utente.set_pwd (kst_tab_sr_utenti.id)   // OBSOLETO mantenuto solo per compatibilità con il passato
		kguo_utente.set_nome(kst_tab_sr_utenti.nome) 
		kguo_utente.set_codice(kst_tab_sr_utenti.codice)
		kguo_utente.set_id_utente(kst_tab_sr_utenti.id)
		kguo_utente.set_virtual_user(kst_tab_sr_utenti.virtual_user)
	end if
	
//--- se password corretta non faccio niente
	if k_return then
							
	else			
		kguo_utente.set_pwd (0) 
		kst_esito = kiuf_sr_utenti.tb_select(kst_tab_sr_utenti)
		if kst_esito.esito = kkg_esito.ok then 
			dw_about.event u_set_st_informa("Accesso non Autorizzato, password non riconosciuta. Sono rimasti " + string(kst_tab_sr_utenti.tentativi_max - kst_tab_sr_utenti.tentativi_ko) + " tentativi.")
			kguo_exception.inizializza(this.classname())
			kguo_exception.kist_esito.esito = kkg_esito.ko
			kguo_exception.kist_esito.sqlerrtext = dw_about.getitemstring(1, "st_informa")
			kguo_exception.scrivi_log( )
		else
			dw_about.event u_set_st_informa("Accesso non Autorizzato, provare a ripetere le credenziali di accesso")
		end if
//		st_informa.visible = true
	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

//--- Utente esistente imposto variabili globali
	if kst_tab_sr_utenti.id > 0 then
		kguo_utente.set_pwd (kst_tab_sr_utenti.id)   // OBSOLETO mantenuto solo per compatibilità con il passato
		kguo_utente.set_nome(kst_tab_sr_utenti.nome) 
		kguo_utente.set_codice(kst_tab_sr_utenti.codice)
		kguo_utente.set_id_utente(kst_tab_sr_utenti.id)
	end if
	
	choose case kst_esito.esito

		case kkg_esito.pwd_inscad 
		
			if messagebox ("Accesso al Sistema", trim(kst_esito.sqlerrtext) + kkg.acapo + "Vuoi cambiarla ora? ", Question!, yesno!, 1) = 1 then
				imposta_password()
			else
				k_return = true  // OK lancia M2000
			end if

		case kkg_esito.pwd_scaduta  // PWD scaduta deve essere cambiata!!!
			messagebox ("Accesso al Sistema", trim(kst_esito.sqlerrtext), Exclamation!, ok! &
							) 
			imposta_password()

		case else
			dw_about.event u_set_st_informa("Accesso non Autorizzato. "  + trim(kst_esito.sqlerrtext))
			//st_informa.visible = true + kkg.acapo
						

	end choose	
	
end try


return k_return 


end function

public subroutine set_connesso_display (boolean a_connesso) throws uo_exception;//

	if a_connesso then
		dw_about.setitem(1, "st_conn_db", "ON")
	else
		dw_about.setitem(1, "st_conn_db", "OFF")
	end if
	

end subroutine

on w_about.create
this.cb_start=create cb_start
this.dw_about=create dw_about
this.Control[]={this.cb_start,&
this.dw_about}
end on

on w_about.destroy
destroy(this.cb_start)
destroy(this.dw_about)
end on

event key;//
//=== Controllo quale tasto da tastiera ha premuto
//

choose case key

	case keyenter! 
		u_start( )

	case keyescape! 
		close(this)

//	case else
//		post u_check_caps_on()

end choose


end event

event open;//

if isvalid(message.powerobjectparm) then
	kist_open_w = message.powerobjectparm
else
	kist_open_w.flag_modalita = kkg_flag_modalita.inserimento
end if

setpointer(hourglass!)

event post ue_open()



end event

event close;//
if isvalid(kiuf_sr_utenti) then destroy kiuf_sr_utenti
end event

type cb_start from picturebutton within w_about
boolean visible = false
integer x = 1774
integer y = 480
integer width = 110
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
boolean flatstyle = true
string picturename = "RunSCC1!"
string powertiptext = "Entra"
long textcolor = 16777215
long backcolor = 15793151
end type

event clicked;//
u_start()

end event

type dw_about from datawindow within w_about
event u_enter pbm_dwnprocessenter
event u_dwnkey pbm_dwnkey
event u_lbuttondown pbm_lbuttondown
event u_lbuttonup pbm_lbuttonup
event u_set_st_informa ( string a_txt )
boolean visible = false
integer y = 4
integer width = 2016
integer height = 1356
integer taborder = 10
string title = "none"
string dataobject = "d_about"
boolean border = false
end type

event u_enter;//
this.accepttext( )
u_start()
end event

event u_dwnkey;//
if key = KeyCapsLock! then
	kuf_utility kuf1_utility
	kuf1_utility = create kuf_utility
	if kuf1_utility.u_check_caps_on() then
		dw_about.setitem(1, "st_caps", "ON")
	else
		dw_about.setitem(1, "st_caps", "OFF")
	end if
	destroy kuf1_utility
end if

end event

event u_lbuttondown;//

long kp_password_view_x, kp_password_view_x1, kp_password_view_y, kp_password_view_y1


kp_password_view_x = long(this.Describe("p_password_view.X"))
kp_password_view_x1 = kp_password_view_x + long(this.Describe("p_password_view.Width"))
kp_password_view_y = long(this.Describe("p_password_view.Y"))
kp_password_view_y1 = kp_password_view_x + long(this.Describe("p_password_view.Heigh"))

if xpos > kp_password_view_x and xpos < kp_password_view_x1 &
		and ypos > kp_password_view_y and ypos < kp_password_view_y1 then
		
	dw_about.Modify("sle_password.Edit.Password='no'")
		
end if


end event

event u_lbuttonup;//
	dw_about.Modify("sle_password.Edit.Password='yes'")  // rimette la pwd a nascosta

end event

event u_set_st_informa(string a_txt);//
if this.rowcount( ) > 0 then
	if a_txt > " " then
	else
		a_txt = ""
	end if
	this.setitem(1, "st_informa", trim(a_txt))
	this.modify("st_informa.visible='1'")
else
	this.modify("st_informa.visible='0'")
end if
end event

event buttonclicked;//
string k_nome

	this.accepttext( )

	//st_informa.visible = false

	k_nome = lower(trim(dwo.name))

	if k_nome = "p_img_gplv" then
	
		open (w_gnu_gpl)
	
	elseif k_nome = "p_img_update" then
		
		u_update_software()
		
	elseif k_nome = "cb_img_start" then
	
		u_start()	
		
	elseif k_nome = "b_close" then

		u_close( )
		
	end if
	
end event

event clicked;//
string k_nome

	this.accepttext( )

	//st_informa.visible = false

	k_nome = lower(trim(dwo.name))

	if k_nome = "p_img_gplv" then
	
		open (w_gnu_gpl)
	
	end if
	
end event

