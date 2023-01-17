$PBExportHeader$kuo_sqlca_db_magazzino.sru
forward
global type kuo_sqlca_db_magazzino from kuo_sqlca_db_0
end type
end forward

global type kuo_sqlca_db_magazzino from kuo_sqlca_db_0
end type
global kuo_sqlca_db_magazzino kuo_sqlca_db_magazzino

type variables
//
public string ki_user
public string ki_password
kuf_conf_access kiuf_conf_access


end variables

forward prototypes
protected subroutine x_db_profilo () throws uo_exception
public function boolean if_connesso_x ()
public function boolean db_set_isolation_level () throws uo_exception
public function st_esito db_crea_temp_table (string k_table, string k_campi, string k_select) throws uo_exception
public function st_esito db_crea_temp_table_global (string k_table, string k_campi, string k_select) throws uo_exception
public function integer u_get_col_len (string a_table, string a_col)
public function st_esito db_crea_table (string k_table, string k_sql) throws uo_exception
protected function boolean u_if_dberror_grave (integer a_code)
protected function boolean u_error_db_if_conn (ref st_esito ast_esito)
protected function boolean u_error_db_if_login (ref st_esito ast_esito)
protected function boolean u_error_db_if_conn_timeout (ref st_esito ast_esito)
protected function boolean u_error_others (ref st_esito ast_esito)
public subroutine inizializza () throws uo_exception
end prototypes

protected subroutine x_db_profilo () throws uo_exception;//
//-- cinacina
//
string k_file_ini 
boolean k_fileExist 
st_esito kst_esito 
pointer oldpointer  // Declares a pointer variable
uo_exception kuo_exception



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//--- ripristina la path di lavoro
	kGuf_data_base.setta_path_default()

	try 
		kGuf_data_base.u_if_profile_base_exists()
		
	
		k_file_ini = kGuf_data_base.get_nome_profile_base()  //trim(KG_PATH_PROCEDURA + KKg_NOME_PROFILE.BASE)
		if k_file_ini > " " then
		else 
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Attenzione, manca il nome del file dati di accesso al DB. Operazione interrotta~n~r "&
					+ "Il problema dovrebbe risolversi riavviando il programma altrimenti avvertire il tecnico." 
			kuo_exception = create uo_exception
			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_dati_insufficienti )
			kuo_exception.set_esito( kst_esito )
			destroy kuo_exception			
		end if
	
	catch (uo_exception kuo1_exception)
		kuo1_exception.messaggio_utente()
		
	end try
	
//	u_if_profile_base_exists()
//	k_fileExist = fileexists(k_file_ini)
//	if not k_fileExist then
//		kst_esito.esito = kkg_esito.not_fnd
//		kst_esito.sqlcode = 0
//		kst_esito.SQLErrText = "Attenzione, non trovo il file dati di accesso al DB '" + trim(KG_PATH_PROCEDURA + KKg_NOME_PROFILE.BASE) + "'.~n~r "&
//				+ "Operazione interrotta. Riprovare a riavviare il programma o avvertire il tecnico." 
//		kuo_exception = create uo_exception
//		kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_dati_anomali )
//		kuo_exception.set_esito( kst_esito )
//		destroy kuo_exception			
//	end if


//--- Recupera le info dal CONFDB.INI
	this.DBMS = profilestring (k_file_ini, "Database", "DBMS", "MSOLEDBSQL SQL Server")  //"SNC SQL Native Client(OLE DB)")
	this.DBParm = kiuf_conf_access.kist_conf_access.dbparm
	//this.DBParm = profilestring (k_file_ini, "Database", "DbParm", "Identity='SCOPE_IDENTITY()',DateFormat='\''dd-mm-yyyy\''', DateTimeFormat='\''dd-mm-yyyy hh:mm:ss\'''") //"Provider='SQLNCLI11',Database='sterigenics270',TrustedConnection=1")
	//this.Database = profilestring (k_file_ini, "Database", "Database", "'sterigenics270'")
	//this.UserId = profilestring (k_file_ini, "Database", "UserId", "")  // NUN USATO X MS-SQL
	//this.DBPass = profilestring (k_file_ini, "Database", "DBPass", "")  // NUN USATO X MS-SQL
	
//	if this.ki_user > " " then
//		this.LogId = this.ki_user
//	else
	this.LogId = profilestring (k_file_ini, "Database", "LogId", "M2000")
//	end if

//	if this.ki_password > " " then
//		this.LogPass = this.ki_password
//	else
	this.LogPass = profilestring (k_file_ini, "Database", "LogPass", "") //"start") 
	if this.LogPass > " " then
	else
		this.LogPass = kiuf_conf_access.kist_conf_access.pwd
	end if
//	end if

	this.ServerName = kguo_path.get_server_name( ) //profilestring (k_file_ini, "Database", "ServerName", "")
	
//	if (profilestring (k_file_ini, "Database", "AutoCommit", "false")) = "true" then
	if kiuf_conf_access.kist_conf_access.AutoCommit = "true" then
		this.AutoCommit = true
	else
		this.AutoCommit = false
	end if

// Profile db_STERIGENICS270_TEST
//this.DBMS = "SNC SQL Native Client(OLE DB)"
//this.LogPass = ""
//this.ServerName = "ALBERTOT"
//this.LogId = "alberto"
//this.Lock = "SS"
//this.AutoCommit = False
//this.DBParm = "Provider='SQLNCLI11',Database='sterigenics270',TrustedConnection=1"
	

	if trim(this.dbms) = "nessuno" or trim(this.dbparm) = "" then

		kst_esito.esito = kkg_esito.not_fnd
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Errore. "&
				+ "Impossibile stabilire la connessione con il DB." + kkg.acapo + "(DbParm: '" &
				+ trim(this.dbparm) + "')" + kkg.acapo + "Configurazione cercata nel file:" + kkg.acapo &
				+ kiuf_conf_access.kist_conf_access.file_name_configuration + " "

		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_db_ko)
		kuo_exception.set_esito( kst_esito )
		throw kuo_exception			

	end if





	
end subroutine

public function boolean if_connesso_x ();//
boolean k_return = false
int k_connesso=0


	select 1 into :k_connesso from base 
		using this;
	
	if k_connesso = 1 then
		
		k_return = true   

	end if


return k_return
end function

public function boolean db_set_isolation_level () throws uo_exception;//---------------------------------------------------------------------
//--- 
//--- SETTA ISOLATION LEVEL DEL DB
//---
//--- lancia exception
//---
//---------------------------------------------------------------------
//---

boolean k_return=false
string k_sql_d
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

//	//informix k_sql_d = " set isolation to committed read last committed " 
//	
	k_sql_d = "SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED"
	EXECUTE IMMEDIATE :k_sql_d using this ;
//if this.sqlcode = 0 then
//	
//		k_sql_d = " SET TRANSACTION ISOLATION LEVEL SNAPSHOT "
////"READ UNCOMMITTED "
//		EXECUTE IMMEDIATE :k_sql_d using this ;
//	
//	end if
//	

	if this.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = this.sqlcode
		kst_esito.sqlerrtext = "Fallito SET ISOLATION LEVEL: '" + trim(k_sql_d) + "'. Errore: " + trim(this.SQLErrText)

		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		k_return = true
	end if


return k_return
end function

public function st_esito db_crea_temp_table (string k_table, string k_campi, string k_select) throws uo_exception;//---------------------------------------------------------------------------------------------------------
//--- 
//--- CREA TEMP TABLE 
//---
//--- Par. input	: k_table = nome della tabella
//---           			: k_campi = i campi della tabella
//---           			: k_select = la query di carico della tabella
//---
//--- Ritorna st_esito : Vedi Standard
//---   
//---------------------------------------------------------------------------------------------------------
string k_sql_d
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

//--- il nome tabella in SQL SERVER inizia per # (visibilità locale) o ## (vsibilità globale)
	if left(trim(k_table),1)  <> '#' then
		k_table = "#" + trim(k_table) 
	end if

//--- Cancello e ricreo la temp o view
	k_sql_d = "drop view " + trim(k_table) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	commit using this;
	k_sql_d = "drop table " + trim(k_table) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	commit using this;
	k_sql_d = " CREATE  TABLE "  + trim(k_table) + "  (" + trim(k_campi) + ") "
	EXECUTE IMMEDIATE :k_sql_d using this;
	if this.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Generazione Temp-Table '" &
										  + trim(k_table) + "' non riuscita: " + trim(this.SQLErrText)
	else
		commit using this;
		
		if trim(k_select) = "" then
			kst_esito.esito = kkg_esito.db_wrn
			kst_esito.sqlcode = 0
			kst_esito.sqlerrtext = "Manca la query da cui prendere i dati - tabella temporanea '" + trim(k_table) + "' non popolata subito. "
		else
			k_sql_d = " insert into "  + trim(k_table) + "  " + trim(k_select) 
			EXECUTE IMMEDIATE :k_sql_d using this;
		
			kst_esito.sqlerrtext = "Generazione terminata correttamente "
			if this.sqlcode = 0 then
				commit using this;
			else
				if this.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
					kst_esito.sqlcode = this.sqlcode
					kst_esito.sqlerrtext = "Anomalie durante inserimento dati nella Temp-Table '" &
												  + trim(k_table) + "' err.:" + trim(this.SQLErrText)
				else
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = this.sqlcode
					kst_esito.sqlerrtext = "Inserimanto dati nella Temp-Table '" &
												  + trim(k_table) + "' non riuscita:" + trim(this.SQLErrText)
				end if
				rollback using this;
				
			end if
			
		end if

	end if
	
	if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.no_esecuzione and kst_esito.esito <> kkg_esito.db_wrn then
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if


return kst_esito
end function

public function st_esito db_crea_temp_table_global (string k_table, string k_campi, string k_select) throws uo_exception;//---------------------------------------------------------------------------------------------------------
//--- 
//--- CREA TEMP TABLE 
//---
//--- Par. input	: k_table = nome della tabella
//---           			: k_campi = i campi della tabella
//---           			: k_select = la query di carico della tabella
//---
//--- Ritorna st_esito : Vedi Standard
//---   
//---------------------------------------------------------------------------------------------------------
st_esito kst_esito

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//--- il nome tabella in SQL SERVER inizia per # (visibilità locale) o ## (vsibilità globale)
	k_table = "##" + trim(k_table) 

	kst_esito = db_crea_temp_table(k_table, k_campi, k_select)
	

return kst_esito
end function

public function integer u_get_col_len (string a_table, string a_col);//
int k_return 
datastore kds_1


kds_1 = create datastore 
kds_1.dataobject = "ds_ssql_col_len"
kds_1.settransobject(this)
if kds_1.retrieve(a_table, a_col) > 0 then
	k_return = kds_1.getitemnumber(1, "kcol_len") 
end if		
		
return k_return
end function

public function st_esito db_crea_table (string k_table, string k_sql) throws uo_exception;//-----------------------------------------------------------------------------------------------------------------------------------
//--- 
//--- CREA TABELLA 
//---
//--- Par. input	: k_table = nome della tabella
//--- 		         : k_sql = ddl della tabella
//---
//--- Ritorna st_esito : Vedi Standard
//---   
//-----------------------------------------------------------------------------------------------------------------------------------
string k_sql_d
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

//--- Cancello e ricreo view/tab
	k_sql_d = "drop view if exists " + trim(k_table) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	if this.sqlcode = 0 then 
		commit using this;
	end if

	k_sql_d = "SELECT 1 FROM sys.Tables WHERE  Name = N'" + trim(k_table) + "'"
	EXECUTE IMMEDIATE :k_sql_d using this;
	if this.sqlcode = 0 then 
	
//	k_sql_d = "IF OBJECT_ID('" + trim(k_table) + "') IS NOT NULL " + &
		k_sql_d = "truncate table " + trim(k_table) + "  " 
		EXECUTE IMMEDIATE :k_sql_d using this;
	
//		k_sql_d = "drop table " + trim(k_table) + "  " 
//		EXECUTE IMMEDIATE :k_sql_d using this;
//		if this.sqlcode = 0 then 
//			commit using this;
//		end if
	else		
		k_sql = " CREATE TABLE  " + trim(k_table) + "  (	" + k_sql + " ) "
		EXECUTE IMMEDIATE :k_sql using this;
	end if
	
	if this.sqlcode = 0 then 
		commit using this;
		kst_esito.sqlerrtext = "Generazione terminata correttamente "
	else	
		if this.sqlcode > 0 then
			commit using this;
			kst_esito.esito = kkg_esito.db_wrn
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Anomalie durante generazione Table '" &
										  + trim(k_table) + "' err.: " + trim(this.SQLErrText)
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Generazione Table '" &
										  + trim(k_table) + "' non riuscita: " + trim(this.SQLErrText)
			rollback using this;
	
			if kst_esito.sqlcode < 0 then
				
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
				
			end if
			
		end if
		
	end if


return kst_esito
end function

protected function boolean u_if_dberror_grave (integer a_code);//--- evito di esporre gli errori di 'DROP TBABLE/VIEW' in MSSQL sono 3701 e 3705  
//---     oppure di non connesso (11001 or 53)
	if a_code <> -394 and a_code <> 3705 and a_code <> 3701 &
			and a_code <> 11001 and a_code <> 53 &
		then
			
		return true
		
	else
		
		return false
		
	end if
end function

protected function boolean u_error_db_if_conn (ref st_esito ast_esito);//
//---- gestione prsonalizzata a seconda del DB per errore di CONNESSIONE
//
//

	try 
		if not if_connesso( ) then

			//ast_esito.sqlerrtext = "Tentativo di Ri-connessione al database di Magazzino... " 
			//kguo_exception.scrivi_log( ) // u_write_error()
			//errori_scrivi_esito("W", kst_esito) 
//--- tentativo di connessione al db.....
			if not kguo_sqlca_db_magazzino.db_riconnetti( ) then
				kguo_exception.messaggio_utente("Programma non operativo", "Persa la Connessione al database di Magazzino, il programma verrà chiuso.")
				halt close
			else
				ast_esito.esito = kkg_esito.ok
				ast_esito.sqlcode = 0
				ast_esito.sqlerrtext = "Ri-connessione al database di Magazzino conclusa con successo. " 
				kguo_exception.scrivi_log( ) // u_write_error()
			end if
		
		else
		
			return false

		end if
		
	catch (uo_exception kuo_exception)
			kguo_exception.messaggio_utente("Programma non operativo", "Persa la Connessione al database di Magazzino, prego chiudere e riavviare il programma")
			
	finally

	end try
	
	return true

end function

protected function boolean u_error_db_if_login (ref st_esito ast_esito);//
//---- Gestione PERSONALIZZATA a seconda del DB x errore di Login
//
//
	if ast_esito.SQLdbcode = 18456 then // LOGIN ERRATO 
	
		ast_esito.esito = kkg_esito.no_esecuzione
		ast_esito.sqlerrtext = "Login fallito, utente o password errata." 
		kguo_exception.scrivi_log( ) // u_write_error()
		
		return true
		
	else
		
		return false
		
	end if

end function

protected function boolean u_error_db_if_conn_timeout (ref st_esito ast_esito);//
//---- gestione personalizzata a seconda del DB per errore di CONNESSIONE
//
//
CHOOSE CASE ast_esito.SQLdbcode

//informix	case -1811, -349, -1803, -25580 //--- manca connessione 
	case 	-4060, -40197, -40501, -40613, -49918, -49919, -49920, -4221, 10054, 64 //, 121 timeout
		
		kguo_exception.messaggio_utente( &
						"Fallita connessione al DB di Magazzino", "Connessione ai Dati di Magazzino in errore, superato il tempo massimo di attesa di risposta del DB (" &
						+ trim(ast_esito.sqlerrtext)+").")
		kguo_exception.scrivi_log( ) // u_write_error()

		return true
		
	case else
		
		return false

END CHOOSE

end function

protected function boolean u_error_others (ref st_esito ast_esito);//
//---- Gestione PERSONALIZZATA a seconda del DB x errore generico
//
//
	if ast_esito.SQLdbcode = 208 then // Nome oggetto errato (tabella/view)
	
		ast_esito.esito = kkg_esito.db_ko
		ast_esito.sqlerrtext = "Errore interno restituito dal DB '" + ki_db_descrizione + "' dovuto ad un nome errato (tabella o altro oggetto). " + ast_esito.sqlerrtext
		kguo_exception.inizializza()
		kguo_exception.set_esito(ast_esito)
		kguo_exception.messaggio_utente( )
		
		return true
		
	else
		
		return false
		
	end if

end function

public subroutine inizializza () throws uo_exception;//
//
ki_db_descrizione = "DB di Magazzino"
ki_title_id = "db_magazzino"

kiuf_conf_access = create kuf_conf_access
kiuf_conf_access.u_set_st_conf_access( ) 
end subroutine

on kuo_sqlca_db_magazzino.create
call super::create
end on

on kuo_sqlca_db_magazzino.destroy
call super::destroy
end on

event destructor;call super::destructor;//
	if isvalid(kiuf_conf_access) then destroy kiuf_conf_access

end event

