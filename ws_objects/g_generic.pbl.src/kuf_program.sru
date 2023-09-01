$PBExportHeader$kuf_program.sru
forward
global type kuf_program from nonvisualobject
end type
end forward

global type kuf_program from nonvisualobject
end type
global kuf_program kuf_program

type variables
//
//kuf_data_base kiuf_data_base
end variables

forward prototypes
public function boolean u_if_chiudi_procedura ()
public function boolean u_if_is_running ()
public function boolean u_update_setup ()
public function boolean u_update_dev_version (boolean a_update_ask)
end prototypes

public function boolean u_if_chiudi_procedura ();//
boolean k_return = true


if not isnull(kguf_data_base.prendi_win_la_ultima( )) then
	if not isnull(kguf_data_base.prendi_win_la_prima( )) then
		if kguf_data_base.prendi_win_la_ultima( ) <> kguf_data_base.prendi_win_la_prima( ) then
			k_return = false
		end if
	end if
end if

return k_return 
end function

public function boolean u_if_is_running ();
//
//String ls_name
//If Handle(GetApplication()) > 0 Then
//	ls_name = GetApplication().AppName + Char(0)
//	CreateMutex(0, True, ls_name)
//	If GetLastError() = 183 Then Return True
//End If

//OleObject locator,service,props
//String ls_query = &
// 'select name , description from Win32_Process where name = "' + ls_name  + '" '  //"textpad.exe"'
//int num, ret, i
//locator = CREATE OleObject
//ret = locator.ConnectToNewObject("WbemScripting.SWbemLocator");
//service = locator.ConnectServer();
//props = service.ExecQuery(ls_query);
//num = props.count()
//
//if num> 0 then return true

Return False

end function

public function boolean u_update_setup ();//
//=== Lancio programma di aggiornamento della procedura
//=== DA RIVEDERE lanciava l'installer di INNOSETUP
//
boolean k_return
string k_base, k_programma
kuf_base kuf1_base
st_profilestring_ini kst_profilestring_ini
pointer 	kpointer_orig 


kpointer_orig = setpointer(hourglass!)

try
	kuf1_base = create kuf_base


//=== Legge utente di Login
	k_base = trim(mid(kuf1_base.prendi_dato_base("utente_login"), 2))

//--- Aggiorna arch di config
	kst_profilestring_ini.operazione = "2"
	kst_profilestring_ini.file = ""
	kst_profilestring_ini.titolo = "ambiente"
	kst_profilestring_ini.nome = "utente_login"
	kst_profilestring_ini.valore = k_base
	kguf_data_base.profilestring_ini ( kst_profilestring_ini )

//=== Legge il percorso di dove sono i programmi aggiornati
	k_base = trim(mid(kuf1_base.prendi_dato_base("path_pgm_upd"), 2))

//--- Aggiorna arch di config
	kst_profilestring_ini.operazione = "2"
	kst_profilestring_ini.file = ""
	kst_profilestring_ini.titolo = "ambiente"
	kst_profilestring_ini.nome = "path_pgm_upd"
	kst_profilestring_ini.valore = k_base
	kguf_data_base.profilestring_ini ( kst_profilestring_ini )

//=== Legge il percorso del root del server della Procedura
	k_base = trim(mid(kuf1_base.prendi_dato_base("path_centrale"), 2))

//--- Aggiorna arch di config
	kst_profilestring_ini.operazione = "2"
	kst_profilestring_ini.file = ""
	kst_profilestring_ini.titolo = "ambiente"
	kst_profilestring_ini.nome = "path_centrale"
	kst_profilestring_ini.valore = k_base
	kguf_data_base.profilestring_ini ( kst_profilestring_ini )

	
	if kst_profilestring_ini.esito = kkg_esito.ok then
		
		if len(trim(kst_profilestring_ini.valore)) > 0 then
			
			setpointer(hourglass!)

			if isvalid(w_main) then close(w_main)
			
			k_programma = trim(kst_profilestring_ini.valore)  +  KKG.PATH_SEP + "xWxp"  +  KKG.PATH_SEP  +  "m2000_setup.exe"
			
			if run (k_programma, normal!) = 1 then
				k_return = true
			end if
			
		end if
	end if

catch (uo_exception kuo_execption)
	kuo_execption.scrivi_log( )
	
end try

return k_return
end function

public function boolean u_update_dev_version (boolean a_update_ask);//
//--- Lancio prgramma di aggiornamento della procedura
//--- copia da path di aggiornamento su client i compilati
//--- Inp:  true = chiede se aggiornare 
//
boolean k_return
boolean k_db_connesso
string k_base, k_path_centrale
int k_aggiorna
kuf_base kuf1_base
st_profilestring_ini kst_profilestring_ini
pointer 	kpointer_orig 
Kuo_sqlca_db_magazzino Kuo1_sqlca_db_magazzino
kuf_utility kuf1_utility
st_esito kst_esito


try
	
	kguo_exception.inizializza(this.classname())
	
	kuf1_utility = create kuf_utility
	if not kuf1_utility.u_check_network() then
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_non_eseguito)
		kguo_exception.setmessage("Rete non Connessa", "Riavviare l'applicazione, aggiornamento non possibile.")
		throw kguo_exception
	end if

	if not u_if_chiudi_procedura() then
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_wrn )
		kguo_exception.setmessage("Richiesta di Aggiornamento", "Prima di procedere occorre chiudere tutte le 'funzioni' aperte")
		throw kguo_exception
		
	end if	

	if a_update_ask then
		k_aggiorna = messagebox ("Richiesta di Aggiornamento", "Aggiornare alla versione di Sviluppo (non stabile) dei programmi?", &
						 question!, YesNo!, 2) 
	else
		k_aggiorna = 1
	end if
						
	if k_aggiorna = 1 then

		kpointer_orig = setpointer(hourglass!)
	
		try
			k_db_connesso = Kguo_sqlca_db_magazzino.db_connetti()

		catch (uo_exception kuo_exception)
			
		end try
	
		if not k_db_connesso then
			
	//messagebox("Problemi di connessione con il DB", trim(kst_esito.sqlerrtext ))
	//--- se connessione DB KO! allora provo a scaricare gli aggiornamenti con i dati dell'utlimo confdb aggiornato
			k_path_centrale = kGuf_data_base.profilestring_leggi_scrivi(kguf_data_base.ki_profilestring_operazione_leggi, "path_centrale")
	
		else
			
			kuf1_base = create kuf_base
	
		//=== Legge utente di Login
//				k_base = kGuf_data_base.profilestring_leggi_scrivi(kguf_data_base.ki_profilestring_operazione_leggi, "utente_login")
			k_base = trim(mid(kuf1_base.prendi_dato_base("utente_login"), 2))
		
		//--- Aggiorna arch di config
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.file = ""
			kst_profilestring_ini.titolo = "ambiente"
			kst_profilestring_ini.nome = "utente_login"
			kst_profilestring_ini.valore = k_base
			kguf_data_base.profilestring_ini ( kst_profilestring_ini )
		
		//=== Legge il percorso di dove sono i programmi aggiornati
			k_base = trim(mid(kuf1_base.prendi_dato_base("path_pgm_upd"), 2))
		
		//--- Aggiorna arch di config
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.file = ""
			kst_profilestring_ini.titolo = "ambiente"
			kst_profilestring_ini.nome = "path_pgm_upd"
			kst_profilestring_ini.valore = k_base
			kguf_data_base.profilestring_ini ( kst_profilestring_ini )
		
		//=== Legge il percorso del root del server della Procedura
			k_base = trim(mid(kuf1_base.prendi_dato_base("path_centrale"), 2))
		
		//--- Aggiorna arch di config
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.file = ""
			kst_profilestring_ini.titolo = "ambiente"
			kst_profilestring_ini.nome = "path_centrale"
			kst_profilestring_ini.valore = k_base
			kguf_data_base.profilestring_ini ( kst_profilestring_ini )
		
			destroy kuf1_base 

			if kst_profilestring_ini.esito = kkg_esito.ok then
				
				if trim(kst_profilestring_ini.valore) > " " then
					
					k_path_centrale = trim(kst_profilestring_ini.valore)

				end if
			end if

		end if

		if k_path_centrale > " " then
			if run (trim(kst_profilestring_ini.valore) + KKG.PATH_SEP + "xWxp" + KKG.PATH_SEP + "r2022r2" + KKG.PATH_SEP + "g_upd_ver.exe", normal!) = 1 then
				k_return = true
			end if
		end if
				
	end if

catch (uo_exception kuo1_exception)
	kuo1_exception.messaggio_utente()
	
finally
	if isvalid(kuf1_utility) then destroy kuf1_utility
	if k_return then
		if isvalid(w_main) then close(w_main)
	end if
	
end try
	
return k_return

end function

event constructor;//
//kiuf_data_base = create kuf_data_base
end event

event destructor;//
//if isvalid(kiuf_data_base) then destroy kiuf_data_base

end event

on kuf_program.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_program.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

