$PBExportHeader$uo_path.sru
forward
global type uo_path from nonvisualobject
end type
end forward

global type uo_path from nonvisualobject
end type
global uo_path uo_path

type variables
//--- PATH generali
private:
string ki_PATH_APP = "."  // path utente di lavoro della procedura dove sta il confdb.ini
string ki_BASE_DEL_SERVER="" //path dove risiede il server, di solito la CONSOLE
string ki_BASE_DEL_SERVER_JOB="" //path dove risiedono i batch da lanciare dal Server (di solito li lancia la CONSOLE)
string ki_TEMP_SERVER=""   //path Temporanea sul Server
string ki_BASE=""   //path archivi BASE dell'utente
string ki_TEMP_USER=""   //path archivi BASE dell'utente
string ki_arch_saveas=""   //path dove salvare le dw x accellerare le letture (ormai obsoleto)
string ki_risorse = ""  //path dove pescare le riscorse grafiche (icone, ecc...)
string ki_help = ""  //path file di HELP 
string ki_doc_root = ""  //path file di root dei documenti (impostato sul BASE) 
string ki_doc_root_interno = ""  //path file di root dei documenti x uso interno 
string ki_doc_root_esterno = ""  //path file di root dei documenti x uso esterno tipo WEB
string ki_SERVER_NAME = "" //punta al server con IP o il nome es.S67-APPS4 o 10.67.100.65 
string ki_pathfileaccessname = "" //nome del path+file contenete i dati di accesso es: DBAccess\M2000 

string ki_email_companyAttachments="" //path x allegati alle email interne 

string ki_app_extract_certif_E1_pdf="" //path + nome programma di Estrazione da file pdf stampati da E1 dei Certificati

//--- Root dei Documenti Elettronici 
constant string kki_doc_root_uso_interno = KKG.PATH_SEP + "interno"    //-- x uso interno 
constant string kki_doc_root_uso_esterno = KKG.PATH_SEP + "esterno"   //--- x uso esterno tipo WEB

constant string kki_nome_file_errori = KKG.PATH_SEP + "m2000_errori_1"

end variables

forward prototypes
public function string get_path_app ()
public function string get_base_del_server ()
public function string get_base_del_server_job ()
public function string get_base ()
public function string get_risorse ()
public subroutine set_path_base_del_server ()
public function string get_temp ()
public function string get_nome_file_errori_txt ()
public function string get_nome_file_errori_xml ()
public function string get_nome_path_file_errori_xml ()
public function string get_doc_root ()
public function string get_doc_root_interno ()
public function string get_doc_root_esterno ()
public subroutine set_doc_root ()
public function string get_app_extract_certif_e1_pdf ()
public function string get_temp_server ()
public function string get_email_companyattachments ()
public function string get_nome_path_file_errori_xml_noext ()
private function string get_nome_file_errori_xml_noext ()
public function string get_nome_file_errori_txt_all_user ()
public function string get_help ()
public function string get_server_name ()
public function string get_path_dbaccess ()
public subroutine set_server_name ()
public subroutine set_file_access_name ()
private subroutine set_path_risorse ()
public function string set_path_base ()
public function string set_path_app ()
public function string set_path_help ()
public function string set_arch_saveas ()
public function string get_path_arch_saveas ()
public subroutine set_path_locali ()
end prototypes

public function string get_path_app ();//
return trim(ki_PATH_APP)

end function

public function string get_base_del_server ();//
if ki_base_del_server > " " then
	return trim(ki_BASE_DEL_SERVER)
else
	// se non c'è nulla di impostato probailmente non è ancora connesso pertanto torna un default
	return kkg.path_sep + kkg.path_sep + kguo_utente.ki_domain + kkg.path_sep + kkg.APP_NAME + kkg.path_sep + "server" + kkg.path_sep + "app"
end if

end function

public function string get_base_del_server_job ();//
return trim(ki_BASE_DEL_SERVER_JOB)

end function

public function string get_base ();//
return trim(ki_BASE)

end function

public function string get_risorse ();//
return trim(ki_risorse)

end function

public subroutine set_path_base_del_server ();//
//=== Imposta il PATH impostato sul DB circa il SERVER 
//
string k_path=" "
kuf_base kuf1_base
st_esito kst_esito
pointer kpointer
uo_exception kuo_exception


	kpointer = setpointer(hourglass!)
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kuo_exception = create uo_exception

	kuf1_base = create kuf_base
	
//--- get path centrale sul SERVER
	k_path = kuf1_base.prendi_dato_base( "path_centrale")
	if left(k_path,1) <> "0" then
		ki_base_del_server = ""
	else
		ki_base_del_server = trim(mid(k_path,2))
		ki_BASE_DEL_SERVER_JOB = ki_base_del_server + kkg.path_sep + "job" 
	end if

	destroy kuf1_base
	
	if trim(ki_base_del_server) > " " then
		if not DirectoryExists(ki_base_del_server) then
			kst_esito.esito = kkg_esito.ko
			kst_esito.SQLErrText = "La cartella Principale del Server della Procedura non è raggiungibile: " + ki_base_del_server
		else
			
			set_path_risorse( )
			
		end if
	end if

	setpointer(kpointer)

	if kst_esito.esito <> kkg_esito.ok then
		kuo_exception.inizializza()
		kuo_exception.set_esito(kst_esito)
		kuo_exception.messaggio_utente( )
	end if
	
	if isvalid(kuo_exception) then destroy kuo_exception

end subroutine

public function string get_temp ();//
//--- torna Cartella utente x i file temporanei es.:  c:\at_m2000\temp
//

if ki_BASE > " " then
	ki_TEMP_USER = ki_BASE + kkg.path_sep + "tempM2000"
	//u_drectory_create(k_temp)
else
	ki_TEMP_USER = "."
end if


return ki_TEMP_USER

end function

public function string get_nome_file_errori_txt ();//
return get_base( ) + kki_nome_file_errori + ".txt"

end function

public function string get_nome_file_errori_xml ();//---
//--- restituisce il nome del File errori condiviso da tutti gli utenti in formato XML
//---

return get_nome_file_errori_xml_noext() + ".xml"

end function

public function string get_nome_path_file_errori_xml ();//---
//--- restituisce il nome + path del File errori di tutti gli utenti in formato XML
//---

string k_path = ""

k_path = get_base_del_server( )
if not directoryexists(k_path) then 
	k_path = get_base( )
end if

return k_path + get_nome_file_errori_xml() 

end function

public function string get_doc_root ();//
return trim(ki_doc_root)

end function

public function string get_doc_root_interno ();//
return trim(ki_doc_root) + kki_doc_root_uso_interno

end function

public function string get_doc_root_esterno ();//
return trim(ki_doc_root) + kki_doc_root_uso_esterno

end function

public subroutine set_doc_root ();//
//--- Imposta il PATH root dei documenti elettronici
//
string k_esito
kuf_base kuf1_base


kuf1_base = create kuf_base
k_esito = kuf1_base.prendi_dato_base( "doc_root")
if left(k_esito,1) <> "0" then
	ki_doc_root = ""
else
	ki_doc_root = trim(mid(k_esito,2)) 
end if

if isvalid(kuf1_base) then destroy kuf1_base


end subroutine

public function string get_app_extract_certif_e1_pdf ();//
return trim(ki_BASE_DEL_SERVER_JOB) + KKG.PATH_SEP + "mCertE1ChangeName" + KKG.PATH_SEP + "mCertE1ChangeName.exe"

end function

public function string get_temp_server ();//
//--- torna Cartella Temporanea del Server 
//
if ki_BASE_DEL_SERVER > " " then
	ki_TEMP_SERVER = ki_BASE_DEL_SERVER + kkg.path_sep + "tempM2000"
	//u_drectory_create(k_temp)
else
	ki_TEMP_SERVER = "."
end if


return ki_TEMP_SERVER

end function

public function string get_email_companyattachments ();//
//
//--- torna Cartella degli Allegati alle email interne 
//
if ki_doc_root > " " then
	ki_email_companyAttachments = ki_doc_root + kkg.path_sep + "emailAttach" + kkg.path_sep + string(now(), "yyyy")
	//u_drectory_create(k_temp)
else
	ki_email_companyAttachments = "."
end if


return ki_email_companyAttachments

end function

public function string get_nome_path_file_errori_xml_noext ();//---
//--- restituisce il nome + path del File errori di tutti gli utenti in formato XML
//---

string k_path = ""

k_path = get_base_del_server( )
if not directoryexists(k_path) then 
	k_path = get_base( )
end if

return k_path + get_nome_file_errori_xml_noext() 

end function

private function string get_nome_file_errori_xml_noext ();//---
//--- restituisce il nome del File senza l'estensione errori condiviso da tutti gli utenti in formato XML
//---

return kki_nome_file_errori 

end function

public function string get_nome_file_errori_txt_all_user ();//---
//--- File errori di tutti condiviso da tutti gli utenti formato TXT
//---
string k_path = ""

k_path = get_path_app( )
if not directoryexists(k_path) then 
	k_path = get_base( )
end if

return k_path + kki_nome_file_errori + ".txt"

end function

public function string get_help ();//
return trim(ki_help)

end function

public function string get_server_name ();//
return trim(ki_SERVER_NAME)

end function

public function string get_path_dbaccess ();//
//--- torna il path+nome file
//return KKG.PATH_SEP + KKG.PATH_SEP + ki_SERVER_NAME + KKG.PATH_SEP + ki_pathfileaccessname
return ki_pathfileaccessname

end function

public subroutine set_server_name ();//
//=== Imposta la variabile sul SERVER dove risiede il DB (impostato sul confdb)
//
st_esito kst_esito
uo_exception kuo_exception


	kuo_exception = create uo_exception
	kst_esito = kuo_exception.inizializza(this.classname())
	

	ki_SERVER_NAME = trim(kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_leggi, "ServerName", " "))
	if trim(ki_SERVER_NAME) > " " then
	else 
		kst_esito.esito = kkg_esito.ko
		kst_esito.SQLErrText += "Nome del SERVER DATI ('ServerName') non indicato nel file di Configurazione '" + kGuf_data_base.KKi_NOME_PROFILE_BASE + "'! "
	end if

	if kst_esito.esito <> kkg_esito.ok then
		kuo_exception.set_esito(kst_esito)
		kuo_exception.messaggio_utente( )
	end if

	if isvalid(kuo_exception) then destroy kuo_exception

end subroutine

public subroutine set_file_access_name ();//
//=== Imposta la variabile del nome file con i dati di accesso
//
//st_esito kst_esito


	ki_pathfileaccessname = trim(kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_leggi, "pathfileaccessname", " "))
	if trim(ki_pathfileaccessname) > " " then
	else
		if ki_SERVER_NAME > " " then
	 		ki_pathfileaccessname = KKG.PATH_SEP + KKG.PATH_SEP + ki_SERVER_NAME + KKG.PATH_SEP + "DBAccess$" + kkg.path_sep + "M2000"
		else
			ki_pathfileaccessname = "" //"DBAccess$" + kkg.path_sep + "M2000"
		end if
	end if


end subroutine

private subroutine set_path_risorse ();//
//=== Imposta il PATH di dove sono le risorse grafiche 
//
//string k_path=" "
//kuf_base kuf1_base
st_esito kst_esito
uo_exception kuo_exception

	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kuo_exception = create uo_exception

//	kuf1_base = create kuf_base

	ki_risorse = trim(kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_leggi, "arch_graf", " "))
	if trim(ki_risorse) > " " then
		if not DirectoryExists(ki_risorse) then
			kst_esito.esito = kkg_esito.ko
			kst_esito.SQLErrText += "La cartella delle Risorse grafiche quali le icone della Procedura non è raggiungibile: " + ki_risorse
		end if
	else
		kst_esito.esito = kkg_esito.ko
		kst_esito.SQLErrText += "La cartella delle Risorse grafiche quali le icone non è stata indicata in Proprietà della Procedura!!!  " 
	end if
	

	if kst_esito.esito <> kkg_esito.ok then
		kuo_exception.inizializza()
		kuo_exception.set_esito(kst_esito)
		kuo_exception.messaggio_utente( )
	end if

if isvalid(kuo_exception) then destroy kuo_exception

end subroutine

public function string set_path_base ();/*
 Imposta il PATH dei dati generici ovvero il path dell'utente + \db
*/
st_esito kst_esito

	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	ki_base = ki_path_app + kkg.path_sep + "db" //trim(kGuf_data_base.profilestring_leggi_scrivi (1, "arch_base", ""))

	if ki_base > " " then
		if not DirectoryExists(ki_base) then
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.SQLErrText = "La cartella dei dati generici ('Archivi Base') non è raggiungibile: " + ki_base
//			if not u_drectory_create(ki_base) then
//				kst_esito.esito = kkg_esito.ko
//				kst_esito.SQLErrText = "La cartella 'Archivi Base' (DB) della Procedura non è raggiungibile: " + ki_base
//			end if
		end if
	else
		ki_base = "."
		kst_esito.esito = kkg_esito.ko
		kst_esito.SQLErrText = "Manca nel file di configurazione '" + trim(kGuf_data_base.kki_nome_profile_base) + "' la chiave 'arch_base' dove indicare la cartella 'Archivi Base' !!  " 
	end if


return ki_base


end function

public function string set_path_app ();/*
 Imposta il PATH dell'aplicazione
*/
string k_esito
st_esito kst_esito
uo_exception kuo_exception


kuo_exception = create uo_exception
kst_esito = kuo_exception.inizializza(this.classname())

ki_PATH_APP = trim(GetCurrentDirectory ( )) //trim(kGuf_data_base.prendi_path_corrente())
if trim(ki_PATH_APP) > " " then
	if not DirectoryExists(ki_PATH_APP) then
		kst_esito.esito = kkg_esito.ko
		kst_esito.SQLErrText = "La cartella dell'Applicazione non è raggiungibile: " + ki_PATH_APP
	end if
else
	kst_esito.esito = kkg_esito.ko
	kst_esito.SQLErrText = "La cartella dell'Applicazione non è stata caricata, accesso negato!!!  " 
end if

if isvalid(kuo_exception) then destroy kuo_exception

return ki_PATH_APP
end function

public function string set_path_help ();/*
 Imposta il PATH dell'aplicazione
*/
string k_esito
st_esito kst_esito
uo_exception kuo_exception


kuo_exception = create uo_exception
kst_esito = kuo_exception.inizializza(this.classname())

ki_help = ki_PATH_APP + kkg.path_sep + "help"
if trim(ki_help) > " " then
	if not DirectoryExists(ki_help) then
		kst_esito.esito = kkg_esito.ko
		kst_esito.SQLErrText += "La cartella del documento di aiuto della Procedura non è raggiungibile: " + ki_help
	end if
end if

if isvalid(kuo_exception) then destroy kuo_exception

return ki_help
end function

public function string set_arch_saveas ();//
//--- Imposta il PATH di salvataggio dei dati della DW es. c:\at_m2000\save_dw
//
//
st_esito kst_esito
uo_exception kuo_exception


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kuo_exception = create uo_exception


	ki_arch_saveas = ki_path_app + kkg.path_sep + "save_dw"

	if trim(ki_arch_saveas) > " " then
		if not DirectoryExists(ki_arch_saveas) then
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.SQLErrText = "La cartella 'Salvataggio dati generici' non è raggiungibile: " + ki_base
		end if
	else
		ki_arch_saveas = "."
		kst_esito.esito = kkg_esito.ko
		kst_esito.SQLErrText = "Manca nel file di configurazione '" + trim(kGuf_data_base.kki_nome_profile_base) + "' la chiave 'arch_saveas' dove indicare la cartella di 'Salvataggio dati generici' !!  " 
	end if

return ki_arch_saveas

end function

public function string get_path_arch_saveas ();//
return ki_arch_saveas

end function

public subroutine set_path_locali ();//
set_path_app( )
set_arch_saveas( )
set_path_base( )
set_path_help( )

end subroutine

on uo_path.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_path.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

