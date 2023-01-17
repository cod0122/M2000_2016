$PBExportHeader$w_login.srw
$PBExportComments$SHEKAR
forward
global type w_login from window
end type
type cbx_showpassword from checkbox within w_login
end type
type cb_resetdomain from commandbutton within w_login
end type
type cb_username from commandbutton within w_login
end type
type ddlb_theme from dropdownlistbox within w_login
end type
type st_4 from statictext within w_login
end type
type st_status from statictext within w_login
end type
type mle_copyright from multilineedit within w_login
end type
type p_logo from picture within w_login
end type
type p_login from picture within w_login
end type
type cb_ad from commandbutton within w_login
end type
type cb_cancel from commandbutton within w_login
end type
type st_3 from statictext within w_login
end type
type sle_domain from singlelineedit within w_login
end type
type st_2 from statictext within w_login
end type
type st_1 from statictext within w_login
end type
type sle_password from singlelineedit within w_login
end type
type sle_username from singlelineedit within w_login
end type
type cb_ldap from commandbutton within w_login
end type
type ln_1 from line within w_login
end type
type ln_2 from line within w_login
end type
type ln_3 from line within w_login
end type
type ln_4 from line within w_login
end type
end forward

global type w_login from window
integer width = 2039
integer height = 1160
boolean titlebar = true
string title = "Login"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cbx_showpassword cbx_showpassword
cb_resetdomain cb_resetdomain
cb_username cb_username
ddlb_theme ddlb_theme
st_4 st_4
st_status st_status
mle_copyright mle_copyright
p_logo p_logo
p_login p_login
cb_ad cb_ad
cb_cancel cb_cancel
st_3 st_3
sle_domain sle_domain
st_2 st_2
st_1 st_1
sle_password sle_password
sle_username sle_username
cb_ldap cb_ldap
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
end type
global w_login w_login

type prototypes
// This function gets the network login userid
Function ulong WNetGetUser(string lpname, ref string lpusername, ref ulong buflen) Library "mpr.dll" Alias For "WNetGetUserA;Ansi"

// This function validates the login userid/password
Function boolean LogonUser(string lpszUsername, string lpszDomain, string lpszPassword, ulong dwLogonType, ulong dwLogonProvider, ref ulong phToken) Library "advapi32.dll" Alias For "LogonUserA;Ansi"
//Function boolean LogonUserEx(string lpszUsername, string lpszDomain, string lpszPassword, ulong dwLogonType, ulong dwLogonProvider, ref ulong phToken) Library "advapi32.dll" Alias For "LogonUserExA;Ansi"

// Close the connection
Function boolean CloseHandle(ulong hObject) Library "kernel32.dll"

end prototypes

type variables
// SHEKAR - LDAP Authentication
CONSTANT long C_COLOR_RED    = RGB( 192, 0, 0 )
CONSTANT long C_COLOR_GREEN  = RGB( 0, 128, 0 )
CONSTANT long C_COLOR_YELLOW = RGB( 255, 255, 0 )
//
n_cst_Login	inv_Login
string	is_Theme
string	is_Username, is_Domain, is_Computer
end variables

forward prototypes
public function integer of_login (string as_type)
public function integer of_applytheme ()
end prototypes

public function integer of_login (string as_type);// SHEKAR - LDAP Authentication
integer	li_Result
long		ll_Color
string	ls_Username, ls_Password, ls_Domain, ls_Message
singleLineEdit	lsle_Control
//
SetPointer( HourGlass! )
as_Type = Upper( Trim( as_Type ))
//
IF as_Type = '' THEN
	as_Type = 'LDAP'
END IF
//
ls_Username = sle_Username.Text
ls_Password = sle_Password.Text
ls_Domain   = sle_Domain.Text
//
st_Status.Text = " Please wait..."
st_Status.TextColor = 0			// Black
st_Status.BackColor = C_COLOR_YELLOW
//
IF as_Type = 'LDAP' THEN
	li_Result = inv_Login.of_LoginLDAP( ls_Username, ls_Password, ls_Domain )
ELSEIF as_Type = 'AD' THEN
	li_Result = inv_Login.of_LoginAD(   ls_Username, ls_Password, ls_Domain )
ELSE
	li_Result = inv_Login.C_LOGIN_FAILURE
END IF
//
IF li_Result > 0 THEN		// 1
	ll_Color   = C_COLOR_GREEN
	ls_Message = inv_Login.C_LOGIN_SUCCESS_MESSAGE
	// TODO: Go ahead and login into the database "implicitly", now...
ELSE
	//
	Beep( 1 )		// Audible error
	ll_Color = C_COLOR_RED
	//
	IF li_Result     = inv_Login.C_LOGIN_ERROR_USERNAME THEN	// -1
		ls_Message    = inv_Login.C_LOGIN_ERROR_USERNAME_MESSAGE
		lsle_Control  = sle_Username
	ELSEIF li_Result = inv_Login.C_LOGIN_ERROR_PASSWORD THEN	// -2
		ls_Message    = inv_Login.C_LOGIN_ERROR_PASSWORD_MESSAGE
		lsle_Control  = sle_Password
	ELSEIF li_Result = inv_Login.C_LOGIN_ERROR_DOMAIN THEN		// -3
		ls_Message    = inv_Login.C_LOGIN_ERROR_DOMAIN_MESSAGE
		lsle_Control  = sle_Domain
	ELSE		// 0
		ls_Message    = inv_Login.C_LOGIN_FAILURE_MESSAGE
		lsle_Control  = sle_Username
	END IF
	//
END IF
//
st_Status.Text      = ' ' + ls_Message
st_Status.BackColor = ll_Color
st_Status.TextColor = C_COLOR_YELLOW
//
// Set focus to the right edit control for user-friendliness :)
IF IsValid( lsle_Control ) THEN
	lsle_Control.SetFocus()
END IF
//
RETURN li_Result

end function

public function integer of_applytheme ();// SHEKAR - UI Themes
// Valid values: dark, blue, grey or gray, silver
// gnv_App.of_GetTheme()
// Upper( Trim( ProfileString( gnv_App.is_IniFile, 'GENERAL','THEME', '' )))
is_Theme = Upper( Trim( ddlb_Theme.Text ))		// Or populate the DDLB with Theme folder names
//
IF is_Theme = 'DARK' THEN
	is_Theme = 'Flat Design Dark'
ELSEIF is_Theme = 'BLUE' THEN
	is_Theme = 'Flat Design Blue'
ELSEIF is_Theme = 'GREY' OR is_Theme = 'GRAY' THEN
	is_Theme = 'Flat Design Grey'
ELSEIF is_Theme = 'SILVER' THEN
	is_Theme = 'Flat Design Silver'
ELSE
	is_Theme = ''		// System
END IF
//
// gnv_App.of_SetTheme( is_Theme )
// Upper( Trim( SetProfileString( gnv_App.is_IniFile, 'GENERAL','THEME', is_Theme )))
//
//RETURN ApplyTheme( is_Theme )		// Uncomment for PowerBuilder 2019 and above
RETURN 1

end function

on w_login.create
this.cbx_showpassword=create cbx_showpassword
this.cb_resetdomain=create cb_resetdomain
this.cb_username=create cb_username
this.ddlb_theme=create ddlb_theme
this.st_4=create st_4
this.st_status=create st_status
this.mle_copyright=create mle_copyright
this.p_logo=create p_logo
this.p_login=create p_login
this.cb_ad=create cb_ad
this.cb_cancel=create cb_cancel
this.st_3=create st_3
this.sle_domain=create sle_domain
this.st_2=create st_2
this.st_1=create st_1
this.sle_password=create sle_password
this.sle_username=create sle_username
this.cb_ldap=create cb_ldap
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.ln_4=create ln_4
this.Control[]={this.cbx_showpassword,&
this.cb_resetdomain,&
this.cb_username,&
this.ddlb_theme,&
this.st_4,&
this.st_status,&
this.mle_copyright,&
this.p_logo,&
this.p_login,&
this.cb_ad,&
this.cb_cancel,&
this.st_3,&
this.sle_domain,&
this.st_2,&
this.st_1,&
this.sle_password,&
this.sle_username,&
this.cb_ldap,&
this.ln_1,&
this.ln_2,&
this.ln_3,&
this.ln_4}
end on

on w_login.destroy
destroy(this.cbx_showpassword)
destroy(this.cb_resetdomain)
destroy(this.cb_username)
destroy(this.ddlb_theme)
destroy(this.st_4)
destroy(this.st_status)
destroy(this.mle_copyright)
destroy(this.p_logo)
destroy(this.p_login)
destroy(this.cb_ad)
destroy(this.cb_cancel)
destroy(this.st_3)
destroy(this.sle_domain)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_password)
destroy(this.sle_username)
destroy(this.cb_ldap)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.ln_4)
end on

event open;// SHEKAR - LDAP Authentication
string	ls_Username, ls_Domain, ls_Computer, ls_Copyright
//
ls_Copyright = mle_Copyright.Text
ls_Copyright = Mid( ls_Copyright, 7 )
ls_Copyright = '© ' + String( Year( Today())) + ls_Copyright
mle_Copyright.Text = ls_Copyright
//
inv_Login.of_GetDetails( is_Username, is_Domain, is_Computer )
//
// Initialize fields and set focus
sle_Username.Text = is_Username
sle_Domain.Text	= is_Domain
//
IF sle_Username.Text <> "" THEN
	sle_Password.SetFocus()
END IF



/*
// Initialize fields and set focus
sle_Username.Text = inv_Login.of_GetUsername()
sle_Domain.Text	= inv_Login.of_GetDomain()
//
IF sle_Username.Text <> "" THEN
	sle_Password.SetFocus()
END IF
*/
end event

type cbx_showpassword from checkbox within w_login
integer x = 1746
integer y = 224
integer width = 201
integer height = 68
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Show"
end type

event clicked;// SHEKAR
sle_Password.Password = ( NOT This.Checked)

end event

type cb_resetdomain from commandbutton within w_login
integer x = 1742
integer y = 352
integer width = 201
integer height = 80
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Reset"
end type

event clicked;// SHEKAR
sle_Domain.Text = is_Domain

end event

type cb_username from commandbutton within w_login
integer x = 1742
integer y = 88
integer width = 201
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Reset"
end type

event clicked;// SHEKAR
sle_Username.Text = is_Username

end event

type ddlb_theme from dropdownlistbox within w_login
integer x = 1673
integer y = 876
integer width = 288
integer height = 596
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean sorted = false
string item[] = {"System","Dark","Blue","Gray","Silver"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;of_ApplyTheme()
end event

type st_4 from statictext within w_login
integer x = 1714
integer y = 804
integer width = 251
integer height = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "THEME"
boolean focusrectangle = false
end type

type st_status from statictext within w_login
integer x = 9
integer y = 996
integer width = 2011
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 65535
long backcolor = 67108864
boolean focusrectangle = false
end type

type mle_copyright from multilineedit within w_login
integer x = 46
integer y = 808
integer width = 1623
integer height = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "© 2022 PowerObject.  All rights reserved."
boolean border = false
borderstyle borderstyle = stylelowered!
end type

type p_logo from picture within w_login
integer x = 69
integer y = 588
integer width = 457
integer height = 104
boolean focusrectangle = false
end type

type p_login from picture within w_login
integer width = 590
integer height = 768
boolean focusrectangle = false
end type

type cb_ad from commandbutton within w_login
integer x = 1106
integer y = 588
integer width = 402
integer height = 112
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "AD"
end type

event clicked;// SHEKAR - LDAP Authentication
RETURN of_Login( 'AD' )

end event

type cb_cancel from commandbutton within w_login
integer x = 1550
integer y = 588
integer width = 402
integer height = 112
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancel"
boolean cancel = true
end type

event clicked;// SHEKAR - LDAP Authentication
CloseWithReturn( Parent, -1 )

end event

type st_3 from statictext within w_login
integer x = 667
integer y = 356
integer width = 325
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Domain:"
boolean focusrectangle = false
end type

type sle_domain from singlelineedit within w_login
integer x = 992
integer y = 344
integer width = 960
integer height = 96
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_login
integer x = 667
integer y = 224
integer width = 325
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Password:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_login
integer x = 667
integer y = 88
integer width = 325
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Username:"
boolean focusrectangle = false
end type

type sle_password from singlelineedit within w_login
integer x = 992
integer y = 212
integer width = 960
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type sle_username from singlelineedit within w_login
integer x = 992
integer y = 80
integer width = 960
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_ldap from commandbutton within w_login
integer x = 667
integer y = 588
integer width = 402
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "LDAP"
boolean default = true
end type

event clicked;// SHEKAR - LDAP Authentication
RETURN of_Login( 'LDAP' )

end event

type ln_1 from line within w_login
long linecolor = 268435456
integer linethickness = 4
integer beginx = -50
integer beginy = 516
integer endx = 2098
integer endy = 516
end type

type ln_2 from line within w_login
long linecolor = 33554432
integer linethickness = 4
integer beginx = 585
integer beginy = -16
integer endx = 585
integer endy = 768
end type

type ln_3 from line within w_login
long linecolor = 134217749
integer linethickness = 4
integer beginx = -59
integer beginy = 768
integer endx = 2089
integer endy = 768
end type

type ln_4 from line within w_login
long linecolor = 134217744
integer linethickness = 4
integer beginx = -50
integer beginy = 992
integer endx = 2075
integer endy = 992
end type

