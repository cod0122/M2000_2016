$PBExportHeader$n_cst_login.sru
$PBExportComments$SHEKAR
forward
global type n_cst_login from nonvisualobject
end type
end forward

global type n_cst_login from nonvisualobject
end type
global n_cst_login n_cst_login

type prototypes
// This function gets the network login userid
//Function ulong WNetGetUser(string lpname, ref string lpusername, ref ulong buflen) Library "mpr.dll" Alias For "WNetGetUserA;Ansi"

// This function validates the login userid/password
Function boolean LogonUser(string lpszUsername, string lpszDomain, string lpszPassword, ulong dwLogonType, ulong dwLogonProvider, ref ulong phToken) Library "advapi32.dll" Alias For "LogonUserA;Ansi"
//Function boolean LogonUserEx(string lpszUsername, string lpszDomain, string lpszPassword, ulong dwLogonType, ulong dwLogonProvider, ref ulong phToken) Library "advapi32.dll" Alias For "LogonUserExA;Ansi"

// Close the connection
Function boolean CloseHandle(ulong hObject) Library "kernel32.dll"

end prototypes

type variables
CONSTANT ULong LOGON32_LOGON_NETWORK 	 = 3
CONSTANT ULong LOGON32_PROVIDER_DEFAULT = 0
//
CONSTANT integer C_LOGIN_SUCCESS = 1
CONSTANT integer C_LOGIN_FAILURE = 0
CONSTANT integer C_LOGIN_ERROR_USERNAME = -1
CONSTANT integer C_LOGIN_ERROR_PASSWORD = -2
CONSTANT integer C_LOGIN_ERROR_DOMAIN   = -3
//
CONSTANT string C_LOGIN_SUCCESS_MESSAGE = "Accesso consentito"
CONSTANT string C_LOGIN_FAILURE_MESSAGE = "Incorretto Utente o Password"
CONSTANT string C_LOGIN_ERROR_USERNAME_MESSAGE = "Utente non può essere a spazio"
CONSTANT string C_LOGIN_ERROR_PASSWORD_MESSAGE = "Password non può essere a spazio"
CONSTANT string C_LOGIN_ERROR_DOMAIN_MESSAGE   = "Il Server del DB non può essere a spazio"

end variables

forward prototypes
public function integer of_loginad (string as_username, string as_password, string as_domain)
public function integer of_loginldap (string as_username, string as_password, string as_domain)
public function integer of_getdetails (ref string as_username, ref string as_domain, ref string as_computername)
public function string xf_getdomain ()
public function string xf_getusername ()
public function integer of_validate (string as_username, string as_password, string as_domain)
public function integer xf_validate (string as_username, string as_password, string as_domain)
end prototypes

public function integer of_loginad (string as_username, string as_password, string as_domain);// SHEKAR - ActiveDirectory Authentication
uLong		lul_Result, lul_BufferLength, lul_Token
integer	li_Return
boolean	lb_Result
//
li_Return = of_Validate( as_Username, as_Password, as_Domain )
//
IF li_Return <= 0 THEN
	RETURN li_Return		// Error with credentials
END IF
//
lb_Result = LogonUser( as_Username, as_Domain, as_Password, LOGON32_LOGON_NETWORK, LOGON32_PROVIDER_DEFAULT, lul_Token )
//
IF lb_Result THEN
	CloseHandle( lul_Token )
	RETURN C_LOGIN_SUCCESS		// Login Success
END IF
//
RETURN C_LOGIN_FAILURE			// Login Failure

end function

public function integer of_loginldap (string as_username, string as_password, string as_domain);// // SHEKAR - LDAP Authentication
uLong		 lul_Result, lul_BufferLength, lul_Token
integer	 li_Return
boolean	 lb_result
string	 ls_Code, ls_Eval
OLEObject ole_Wsh
//
li_Return = of_Validate( as_Username, as_Password, as_Domain )
//
IF li_Return <= 0 THEN
	RETURN li_Return
END IF
//
// Define VBScript
ls_Code = 'Function Logon()~r~n' &
+ 'const ADS_SECURE_AUTHENTICATION = &h0001~r~n' &
+ 'const ADS_CHASE_REFERRALS_ALWAYS = &H60~r~n' &
+ 'strDomain = "'  + as_Domain   + '"~r~n' &
+ 'strUserID = "'  + as_Username + '"~r~n' &
+ 'strUserPWD = "' + as_Password + '"~r~n' &
+ 'strPath = "LDAP://" & strDomain & "/OU=Users,DC=" & strDomain~r~n' &
+ 'On Error Resume Next~r~n' &
+ 'set objDSO = GetObject("LDAP:")~r~n' &
+ 'set objUser = objDSO.OpenDSObject(strPath, strUserID, strUserPWD, ADS_SECURE_AUTHENTICATION OR ADS_CHASE_REFERRALS_ALWAYS)~r~n' &
+ 'if Err.Number <> 0 then~r~n' &
+ ' Logon = False~r~n' &
+ 'else~r~n' &
+ ' Logon = True~r~n' &
+ 'end if~r~n' &
+ 'Err.Clear~r~n' &
+ 'On Error Goto 0~r~n' &
+ 'set objDSO = Nothing~r~n' &
+ 'set objUser = Nothing~r~n' &
+ 'end function'
//
li_Return = C_LOGIN_FAILURE	// Init - Login failure
//
TRY
	//
	ole_Wsh   = CREATE OLEObject
	ole_Wsh.ConnectToNewObject( 'MSScriptControl.ScriptControl' )
	//
	// Set the VBScript
	ole_Wsh.Language = 'VBScript'
	ole_Wsh.AddCode( ls_Code )
	//
	// Run the function
	ls_Eval = Lower( String( ole_Wsh.Eval( 'Logon' )))
	//
	IF ls_Eval = 'true' THEN
		li_Return = C_LOGIN_SUCCESS
//		GOTO HELL
	END IF
	//
CATCH ( Exception e )
	MessageBox( 'Error', e.GetMessage())
END TRY
//
//////////////////////////
//HELL:
//////////////////////////
ole_Wsh.DisconnectObject()
DESTROY ole_Wsh
GarbageCollect()
//
RETURN li_Return

end function

public function integer of_getdetails (ref string as_username, ref string as_domain, ref string as_computername);// SHEKAR - Get Network details
integer	 li_Result
OLEObject ole_Wsh
//
ole_Wsh	 = CREATE OLEObject
li_Result = ole_Wsh.ConnectToNewObject( 'WScript.Network' )
//
IF li_Result = 0 THEN
	as_Username 	 = ole_Wsh.UserName
	as_Domain		 = ole_Wsh.UserDomain
	as_ComputerName = ole_Wsh.ComputerName
END IF
//
ole_Wsh.DisconnectObject()
DESTROY ole_Wsh
GarbageCollect()
//
RETURN li_Result



/*
oleobject ads
string ls_stuff
ads = CREATE OleObject

ads.ConnectToNewObject( "ADSystemInfo" )

ls_stuff = 'User: ' + String(ads.UserName)
ls_stuff += '~n~r' + 'Computer: ' + string(ads.ComputerName)
ls_stuff += '~n~r' + 'Domain: ' + string(ads.DomainDNSName)
ls_stuff += '~n~r' + 'Domain short: ' + string(ads.DomainShortName)
ls_stuff += '~n~r' + 'Forest: ' + string(ads.ForestDNSName)
ls_stuff += '~n~r' + 'Native Mode: ' + string(ads.IsNativeMode)
ls_stuff += '~n~r' + 'PDCRoleOwner: ' + string(ads.PDCRoleOwner)
ls_stuff += '~n~r' + 'SchemaRoleOwner: ' + string(ads.SchemaRoleOwner)
ls_stuff += '~n~r' + 'Site: ' + string(ads.SiteName)


MessageBox("Active Directory - Information",ls_stuff)
DESTROY(ads)
------
ADSystemInfo interface defines the following properties. All are read only

ComputerName
Retrieves the distinguished name of the local computer.

DomainDNSName
Retrieves the DNS name of the local computer domain, for example “example.fabrikam.com”.

DomainShortName
Retrieves the short name of the local computer domain, for example “myDom”.

ForestDNSName
Retrieves the DNS name of the local computer forest.

IsNativeMode
Determines whether the local computer domain is in native or mixed mode.

PDCRoleOwner
Retrieves the distinguished name of the NTDS-DSA object for the DC that owns the primary domain controller role in the local computer domain.

SchemaRoleOwner
Retrieves the distinguished name of the NTDS-DSA object for the DC that owns the schema role in the local computer forest.

SiteName
Retrieves the site name of the local computer.

UserName
Retrieves the Active Directory distinguished name of the current user, which is the logged-on user or the user impersonated by the calling thread.
*/
end function

public function string xf_getdomain ();string	 ls_Domain
OLEObject LDAP
//
// Connect to ActiveDirectory
LDAP = CREATE OLEObject
LDAP.ConnectToNewObject( "ADSystemInfo" )
//*/
// Get the Domain
TRY
	ls_Domain = String( LDAP.DomainDNSName )
CATCH ( Exception e )
	MessageBox( 'Error', e.GetMessage())
	ls_Domain = ''
END TRY
//
LDAP.DisconnectObject()
DESTROY LDAP
GarbageCollect()
//
RETURN ls_Domain

/*
FUNCTION long GetEnvironmentVariableA(string varname,REF
string lpszResultBuffer,long nBufferSize) LIBRARY
'kernel32.dll'

Put the following code wherever you want to :

string s_env
Long ll_ret
string s_buffer
Long ll_size

s_env = "USERDNSDOMAIN"
s_buffer= space(256)
ll_size= 50
ll_ret= GetEnvironmentVariableA(s_env, s_buffer, ll_size)

MessageBox("USERDNSDOMAIN",s_buffer)
=====================================

OLEObject  l_ole
int    li_rc
string   ls_domain, ls_user, ls_site, ls_computername

l_ole = CREATE OLEObject
li_rc = l_ole.ConnectToNewObject( "ADSystemInfo")

IF li_rc = 0 THEN
   ls_computername = l_ole.computername //CN=CAL26040,OU=Computers,OU=calgary,DC=forestoil,DC=com
   ls_site = l_ole.sitename     // calgary
   ls_user = l_ole.username     // CN=Terry Dykstra(tddykstra),OU=Users,OU=calgary,DC=forestoil,DC=com
   ls_domain = l_ole.domaindnsname    // forestoil.com
END IF

l_ole.DisConnectObject()
DESTROY l_ole
*/
end function

public function string xf_getusername ();string ls_Username
uLong  lul_Result, lul_BufferLength
//
// Get the username  
lul_BufferLength = 32
ls_Username = Space( lul_BufferLength )
//lul_Result  = WNetGetUser( '', ls_Username, lul_BufferLength )
//
IF lul_Result = 0 THEN
	RETURN ls_Username
END IF
//
RETURN ''


/*
PUBLIC FUNCTION Boolean GetUserNameA(REF string  user, REF ulong size)
LIBRARY "ADVAPI32.DLL"

Power Script:

ulong    lul_size = 255
string   ls_username = space(lul_size)

IF NOT GetUserNameA( ls_username, lul_size) THEN
   SetNull(ls_username)
END IF

RETURN ls_username
*/
end function

public function integer of_validate (string as_username, string as_password, string as_domain);// SHEKAR - LDAP Authentication
string	ls_User, ls_Dom, ls_Computer
boolean	lb_Invoked
//
as_Username = Trim( as_Username )
as_Domain   = Trim( as_Domain   )
// NO TRIMMING of the as_Password
//
// Validate login creds
IF IsNull( as_Username ) OR as_Username = '' THEN
	RETURN C_LOGIN_ERROR_USERNAME		// No Username
ELSEIF IsNull( as_Password ) OR as_Password = '' THEN
	RETURN C_LOGIN_ERROR_PASSWORD		// No Password
ELSEIF IsNull( as_Domain ) OR as_Domain = '' THEN
	RETURN C_LOGIN_ERROR_DOMAIN		// No Domain
END IF
//
RETURN 1		// All clear

end function

public function integer xf_validate (string as_username, string as_password, string as_domain);// SHEKAR - LDAP Authentication
string	ls_User, ls_Dom, ls_Computer
boolean	lb_Invoked
//
IF IsNull( as_Password ) OR as_Password = '' THEN
	RETURN C_LOGIN_ERROR_PASSWORD			// No password
END IF
//
as_Username = Trim( as_Username )
as_Domain   = Trim( as_Domain   )
//
// Get the username
IF IsNull( as_Username ) OR as_Username = '' THEN
	//
	RETURN C_LOGIN_ERROR_USERNAME		// Username error
	/*
	of_GetDetails( ls_User, ls_Dom, ls_Computer )
	lb_Invoked  = TRUE
	as_Username = ls_User
	//
	IF as_Username = '' THEN
		RETURN C_LOGIN_ERROR_USERNAME		// Username error
	END IF
	*/
	//
END IF
//
// Get the Domain
IF IsNull( as_Domain ) OR as_Domain = '' THEN
	//
	RETURN C_LOGIN_ERROR_DOMAIN		// Domain error
	/*
	IF NOT lb_Invoked THEN
		of_GetDetails( ls_User, ls_Dom, ls_Computer )
		lb_Invoked  = TRUE
	END IF
	//
	as_Domain = ls_Dom
	//
	IF as_Domain = '' THEN
		RETURN C_LOGIN_ERROR_DOMAIN		// Domain error
	END IF
	*/
	//
END IF
//
RETURN 1		// All clear



/*
IF as_Password = '' THEN
	RETURN -2			// No password
END IF
//
// Get the username
IF as_Username = '' THEN
	//
	as_Username = of_GetUsername()
	//
	IF as_Username = '' THEN
		RETURN -1		// Username error
	END IF
	//
END IF
//
// Get the Domain
IF as_Domain = '' THEN
	//
	as_Domain = of_GetDomain()
	//
	IF as_Domain = '' THEN
		RETURN -3		// Domain error
	END IF
	//
END IF
//
RETURN 1		// All clear
*/
end function

on n_cst_login.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_login.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

