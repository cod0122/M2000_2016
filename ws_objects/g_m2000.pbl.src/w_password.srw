$PBExportHeader$w_password.srw
forward
global type w_password from window
end type
type cb_start from picturebutton within w_password
end type
type dw_about from datawindow within w_password
end type
end forward

global type w_password from window
boolean visible = false
integer x = 672
integer y = 264
integer width = 2094
integer height = 352
windowtype windowtype = response!
long backcolor = 33554431
string icon = "main.ico"
boolean center = true
event u_key pbm_keydown
event ue_open ( )
event u_pbm_lbuttondown pbm_lbuttondown
cb_start cb_start
dw_about dw_about
end type
global w_password w_password

type variables
//
st_open_w kist_open_w
kuf_password kiuf_password
kuf_sr_sicurezza kiuf_sr_sicurezza

end variables

forward prototypes
private function boolean db_check_pwd ()
public subroutine u_close ()
public subroutine u_inizializza ()
public subroutine u_start ()
public function boolean if_connesso_db () throws uo_exception
end prototypes

event ue_open();//
int k_revision=0
string k_build=""
st_esito kst_esito
kuf_utility kuf1_utility
environment kenv
pointer kpointer


try
	kiuf_sr_sicurezza = create kuf_sr_sicurezza
	
	kpointer = setpointer(hourglass!)
	
	dw_about.move(1,1)
	dw_about.resize(this.width, this.height)
	//st_versione.text = kkG_versione
	
	kuf1_utility = create kuf_utility	
	
	this.title = trim(this.title) + "  Versione " + kguo_g.get_app_release( ) 
	this.title = this.title + " su " + trim(kuf1_utility.u_nome_computer()) //prendo nome del Computer
	
	dw_about.insertrow(0)

	cb_start.visible = false
	dw_about.setitem(1, "sle_password", kguo_utente.get_codice())
	
	u_inizializza( )
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )
	halt close

finally
	if isvalid(kuf1_utility) then destroy kuf1_utility
	
	setpointer(kpointer)
	
end try



end event

private function boolean db_check_pwd ();//
boolean k_sr_ok
string k_passwd="", k_utente=""
int k_ctr
st_tab_sr_utenti kst_tab_sr_utenti  
st_esito kst_esito


try

//	kGuo_utente.set_pwd(0)
	
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

	if kiuf_sr_sicurezza.u_if_master(k_passwd) then
		kiuf_password.ki_user_autenticato = true
	else
		
		kst_tab_sr_utenti.codice = trim(k_utente)
		kst_tab_sr_utenti.password = trim(k_passwd)
		k_sr_ok = kiuf_sr_sicurezza.check_user_password (kst_tab_sr_utenti)
	
	//--- Utente esistente imposto variabili globali
	//	if kst_tab_sr_utenti.id > 0 then
	//		kguo_utente.set_pwd (kst_tab_sr_utenti.id)   // OBSOLETO mantenuto solo per compatibilità con il passato
	//		kguo_utente.set_nome(kst_tab_sr_utenti.nome) 
	//		kguo_utente.set_codice(kst_tab_sr_utenti.codice)
	//		kguo_utente.set_id_utente(kst_tab_sr_utenti.id)
	//	end if
		
	//--- se password corretta OK autenticato
		if k_sr_ok then
			
			kiuf_password.ki_user_autenticato = true
			
		else			
			kiuf_password.ki_user_autenticato = false
	
			kst_esito = kiuf_sr_sicurezza.tb_select(kst_tab_sr_utenti)
			if kst_esito.esito = kkg_esito.ok then 
				messagebox("Autenticazione Fallita", "Password non riconosciuta, sono rimasti " + string(kst_tab_sr_utenti.tentativi_max - kst_tab_sr_utenti.tentativi_ko) + " tentativi.", information!)
			else
				messagebox("Autenticazione Fallita", "Provare a ripetere le credenziali di accesso")
			end if
		end if
		
	end if

catch (uo_exception kuo_exception)
	kiuf_password.ki_user_autenticato = false
	kst_esito = kuo_exception.get_st_esito()
	
	messagebox("Autenticazione Fallita", trim(kst_esito.sqlerrtext), Exclamation!)

end try


return kiuf_password.ki_user_autenticato 


end function

public subroutine u_close ();//
	kiuf_password.ki_user_autenticato = false
	
	close(this)
	

end subroutine

public subroutine u_inizializza ();//
st_esito kst_esito 
kuf_utility kuf1_utility
pointer kpointer


try
	
	kpointer = setpointer(hourglass!)

	kuf1_utility = create kuf_utility	
	
	dw_about.modify("sle_password.protect = '0' sle_utente.protect = '0'")
	dw_about.modify("sle_password.Background.Color='"+ string(kkg_colore.campo_attivo)+"' sle_utente.Background.Color='"+ string(kkg_colore.campo_attivo)+"'")
	dw_about.setitem(1, "sle_utente", kguo_utente.get_codice())
	
	//kGuo_utente.set_codice(k_utente_codice)

	dw_about.setcolumn("sle_password")
	
	dw_about.modify("cb_img_start.enabled = '1'")
	
	if_connesso_db()
	
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
	
	setpointer(kpointer)
	this.show( )
	this.setfocus( )
	
end try



end subroutine

public subroutine u_start ();//
//--- Controllo della password digitata
	if db_check_pwd() then
		
		close(this)
		
	end if


end subroutine

public function boolean if_connesso_db () throws uo_exception;//
boolean k_return


try

	if kguo_sqlca_db_magazzino.if_connesso( ) then
		k_return = true
		dw_about.setitem(1, "st_conn_db", "ON")
	else
		dw_about.setitem(1, "st_conn_db", "OFF")
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try
	

return k_return
end function

on w_password.create
this.cb_start=create cb_start
this.dw_about=create dw_about
this.Control[]={this.cb_start,&
this.dw_about}
end on

on w_password.destroy
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
	kiuf_password = kist_open_w.key12_any
else
	kist_open_w.flag_modalita = kkg_flag_modalita.inserimento
end if

setpointer(hourglass!)

event post ue_open()



end event

type cb_start from picturebutton within w_password
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

type dw_about from datawindow within w_password
event u_enter pbm_dwnprocessenter
event u_dwnkey pbm_dwnkey
event u_lbuttondown pbm_lbuttondown
event u_lbuttonup pbm_lbuttonup
integer y = 4
integer width = 2016
integer height = 1348
integer taborder = 10
string title = "none"
string dataobject = "d_password"
boolean border = false
borderstyle borderstyle = stylelowered!
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

event buttonclicked;//
string k_nome

	this.accepttext( )

	k_nome = lower(trim(dwo.name))

	if k_nome = "cb_img_start" then
	
		u_start()	
		
	elseif k_nome = "b_close" then

		u_close( )
		
	end if
	
end event

