$PBExportHeader$kuf_conf_access.sru
forward
global type kuf_conf_access from nonvisualobject
end type
end forward

global type kuf_conf_access from nonvisualobject
end type
global kuf_conf_access kuf_conf_access

type variables
//
st_conf_access kist_conf_access

end variables

forward prototypes
public subroutine u_set_st_conf_access () throws uo_exception
public subroutine kist_conf_access_if_is_null ()
end prototypes

public subroutine u_set_st_conf_access () throws uo_exception;//
//--- Recupera i dati dal file di accesso
//
string k_file, ls_Error
JSONParser kjsonParser 
uo_exception kuo_exception
uo_crypter kuo_crypter


kuo_exception = create uo_exception
kjsonParser = create JSONParser

k_file = kguo_path.get_path_dbaccess( )
if k_file > " " then
	kist_conf_access.file_name_configuration = k_file
	ls_Error = kjsonParser.loadfile( k_file )
	if Len(ls_Error) > 0 then
 		kuo_exception.inizializza(this.classname())
		kuo_exception.kist_esito.esito = kuo_exception.kk_st_uo_exception_tipo_ko
		kuo_exception.setmessage("Errore in lettura file '" + k_file + "' : " + ls_Error)
		throw kuo_exception
	else
		kist_conf_access.domain = trim(kjsonParser.getitemstring("/Domain"))
		kist_conf_access.uid = trim(kjsonParser.getitemstring("/Uid"))
		kist_conf_access.dbparm = trim(kjsonParser.getitemstring("/DbParm"))
		kist_conf_access.AutoCommit = lower(trim(kjsonParser.getitemstring("/AutoCommit")))
		kuo_crypter = create uo_crypter
		kist_conf_access.pwd = kuo_crypter.u_decrypt_aes_to_txt(kjsonParser.getitemstring( "/Pwd"))
		destroy kuo_crypter
	end if
end if

kist_conf_access_if_is_null()

destroy kuo_exception
destroy kjsonParser


end subroutine

public subroutine kist_conf_access_if_is_null ();//
	if isnull(kist_conf_access.file_name_configuration) then kist_conf_access.file_name_configuration = ""
	if isnull(kist_conf_access.domain) then kist_conf_access.domain = ""
	if isnull(kist_conf_access.dbparm) then kist_conf_access.dbparm = ""
	if isnull(kist_conf_access.uid) then kist_conf_access.uid = ""
	if isnull(kist_conf_access.pwd) then kist_conf_access.pwd = ""
	if isnull(kist_conf_access.AutoCommit) then kist_conf_access.AutoCommit = ""

end subroutine

on kuf_conf_access.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_conf_access.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

