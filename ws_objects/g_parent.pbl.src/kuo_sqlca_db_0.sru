$PBExportHeader$kuo_sqlca_db_0.sru
forward
global type kuo_sqlca_db_0 from transaction
end type
end forward

global type kuo_sqlca_db_0 from transaction
end type
global kuo_sqlca_db_0 kuo_sqlca_db_0

type variables
//
//--- mettere la descrizione del tipo di DB, serve x personalizzare eventuale messaggio all'utente
protected string ki_db_descrizione = "" 

//--- valori della colonna blocca_richieste
public constant string ki_blocca_connessione_no = "0" 
public constant string ki_blocca_connessione_si = "1"

//--- valori della colonna cfg_dbms_scelta 
private constant string ki_cfg_dbms_scelta_princ = "1"
private constant string ki_cfg_dbms_scelta_muletto = "2"

//protected st_esito kist_esito

private integer ki_n_riconnessioni
public boolean ki_conn_blk_msg_done 

//--- identifica il DB es. "db_magazzino"
public string ki_title_id = ""

//--- utile per salvare i dati sqlerr ... 
protected kuo_sqlca_db_0 kiuo_sqlca_db_0_saved

end variables

forward prototypes
public function st_esito db_commit ()
public function st_esito db_rollback ()
protected function boolean x_db_connetti () throws uo_exception
protected subroutine x_db_profilo () throws uo_exception
public function boolean if_connesso () throws uo_exception
public function boolean if_connesso_x () throws uo_exception
public function boolean db_set_isolation_level () throws uo_exception
public function st_esito db_crea_table (string k_table, string k_sql) throws uo_exception
public function st_esito db_crea_temp_table (string k_table, string k_campi, string k_select) throws uo_exception
public function st_esito db_crea_view (integer k_id, string k_view, string k_sql)
public function boolean test_connessione () throws uo_exception
public subroutine u_crea_schema () throws uo_exception
public function boolean if_connessione_bloccata () throws uo_exception
public function boolean db_connetti (st_tab_db_cfg kst_tab_db_cfg) throws uo_exception
private function boolean x_db_profilo (st_tab_db_cfg kst_tab_db_cfg) throws uo_exception
public function st_esito db_truncate (string k_table) throws uo_exception
public subroutine set_profilo_db () throws uo_exception
public function boolean db_riconnetti () throws uo_exception
public function integer u_get_col_len (string a_table, string a_col)
public function integer x_db_connetti_post_ok () throws uo_exception
public function boolean db_connetti () throws uo_exception
public function boolean db_disconnetti () throws uo_exception
protected function boolean u_if_dberror_grave (integer a_code)
protected function boolean u_error_db_if_login (ref st_esito ast_esito)
private subroutine u_error_db (ref st_esito ast_esito)
protected function boolean u_error_db_if_conn (ref st_esito ast_esito)
protected function boolean u_error_db_if_conn_timeout (ref st_esito ast_esito)
private subroutine u_error_common (ref st_esito ast_esito)
protected function boolean u_error_others (ref st_esito ast_esito)
end prototypes

public function st_esito db_commit ();//
//===	Ritorna St_esito - come da standard
//

st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


	commit using this;

	if this.sqlcode <> 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = this.sqlcode
		kst_esito.SQLErrText = trim(this.SQLErrText)
	end if

return kst_esito

 
end function

public function st_esito db_rollback ();//
//===	Ritorna St_esito - come da standard
//

st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


	rollback using this;

	if this.sqlcode <> 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = this.sqlcode
		kst_esito.SQLErrText = trim(this.SQLErrText)
	end if

return kst_esito


end function

protected function boolean x_db_connetti () throws uo_exception;//---
//---	Connessione effettiva al DB
//---   Out: TRUE = connesso
//---
//---  funzione da personalizzare
//---
boolean k_return = false
st_esito kst_esito

	
	SetPointer(kkg.pointer_attesa)
	
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	connect using this;
	
	if this.sqlcode = 0 then
	
		x_db_connetti_post_ok()
		
	else
	
		if this.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = this.sqlcode
			kst_esito.SQLErrText = "Fallito tentativo di Connessione al DB " + ki_db_descrizione &
							+ " '" + this.DBParm + "; Server: " + this.servername & 		
							+ "; ReturnData: " + trim(this.sqlreturndata)&
							+ "; Errore sqldbcode: "+ string(this.sqldbcode) &
							+ "; Text: " +trim(this.sqlerrtext) + "' " //". ~n~r " &
			kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_db_ko)
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception			
		end if			
	end if
	
	try	
//--- Imposta l'ISOLATION LEVEL ovvero cosa fare se becco un LOCK su un record
		db_set_isolation_level( )
	catch (uo_exception kuo_exception)
	end try
	
	k_return = true

	SetPointer(kkg.pointer_default)

return k_return

end function

protected subroutine x_db_profilo () throws uo_exception;//---
//---	Popola questo oggetto con i dati di Connessiore
//---      
//---   Lancia Exception
//---   funzione da personalizzare



end subroutine

public function boolean if_connesso () throws uo_exception;//
boolean k_return = false


// salva i valori di errore
	if not isvalid(kiuo_sqlca_db_0_saved) then kiuo_sqlca_db_0_saved = create kuo_sqlca_db_0
	kiuo_sqlca_db_0_saved.sqlcode = this.sqlcode 
	kiuo_sqlca_db_0_saved.sqldbcode = this.sqldbcode
	kiuo_sqlca_db_0_saved.sqlerrtext = this.sqlerrtext
	kiuo_sqlca_db_0_saved.sqlreturndata = this.sqlreturndata

	if this.DBHandle ( ) > 0  then
		
		if if_connesso_x( ) then 
			k_return = true    // OK DB GIA' CONNESSO!
		else
			db_disconnetti()
		end if
	end if

// ripri i valori in entrata
	this.sqlcode = kiuo_sqlca_db_0_saved.sqlcode
	this.sqldbcode = kiuo_sqlca_db_0_saved.sqldbcode
	this.sqlerrtext = kiuo_sqlca_db_0_saved.sqlerrtext
	this.sqlreturndata = kiuo_sqlca_db_0_saved.sqlreturndata


return k_return
end function

public function boolean if_connesso_x () throws uo_exception;//
//--- controllo personalizzato x Verifica Connessione sullo specifico DB 


// DA PERSONALIZZARE !!!!


return true


end function

public function boolean db_set_isolation_level () throws uo_exception;//---------------------------------------------------------------------
//--- 
//--- SETTA ISOLATION LEVEL DEL DB
//---
//--- lancia exception
//---
//---------------------------------------------------------------------
//--- DA PERSONALIZZARE A SECONDA DEL DB 

boolean k_return=false

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
	k_sql_d = "drop view " + trim(k_table) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	if this.sqlcode = 0 then 
		commit using this;
	end if
	k_sql_d = "drop table " + trim(k_table) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	if this.sqlcode = 0 then 
		commit using this;
	end if
	
	k_sql = " CREATE TABLE  " + trim(k_table) + "  (	" + k_sql + " ) "
	EXECUTE IMMEDIATE :k_sql using this;
	kst_esito.sqlerrtext = "Generazione terminata correttamente "
	if this.sqlcode <> 0 then
		if this.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Anomalie durante generazione Table '" &
			                       + trim(k_table) + "' err.: " + trim(this.SQLErrText)
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Generazione Table '" &
			                       + trim(k_table) + "' non riuscita: " + trim(this.SQLErrText)
		end if
		rollback using this;

		if kst_esito.sqlcode < 0 then
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		end if
		
	else
		commit using this;
	end if


return kst_esito
end function

public function st_esito db_crea_temp_table (string k_table, string k_campi, string k_select) throws uo_exception;//---------------------------------------------------------------------------------------------------------
//--- 
//--- CREA TEMP TABLE 
//---
//--- Par. input	: k_table = nome della tabella (in SQL SERVER deve iniziare per '#')
//---           		: k_campi = i campi della tabella
//---           		: k_select = la query di carico della tabella
//---
//--- Ritorna st_esito : Vedi Standard
//---   
//---------------------------------------------------------------------------------------------------------
string k_sql_d
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

//--- Cancello e ricreo la view
	k_sql_d = "drop view " + trim(k_table) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	commit using this;
	k_sql_d = "drop table " + trim(k_table) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	commit using this;
	k_sql_d = " CREATE  TABLE "  + trim(k_table) + "  (" + trim(k_campi) + ") "
//	k_sql_d = " CREATE TEMP  TABLE "  + trim(k_table) + "  (" + trim(k_campi) + ") with no log "
//	k_sql_d = " CREATE  TABLE "  + trim(k_table) + "  (" + trim(k_campi) + ") " // DEBUG
	EXECUTE IMMEDIATE :k_sql_d using this;
	if this.sqlcode < 0 then
//		rollback using this;
//		if this.sqlcode > 0 then
//			kst_esito.esito = kkg_esito.db_wrn
//			kst_esito.sqlcode = this.sqlcode
//			kst_esito.sqlerrtext = "Anomalie durante generazione Temp-Table '" &
//										  + trim(k_table) + "' err.:" + trim(this.SQLErrText)
//		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Generazione Temp-Table '" &
										  + trim(k_table) + "' non riuscita: " + trim(this.SQLErrText)
//		end if
	else
		commit using this;
		
		if trim(k_select) = "" then
			kst_esito.esito = kkg_esito.db_wrn
			kst_esito.sqlcode = 0
			kst_esito.sqlerrtext = "Manca la query da cui prendere i dati - tabella temporanea '" + trim(k_table) + "' non popolata! "
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
		
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if


return kst_esito
end function

public function st_esito db_crea_view (integer k_id, string k_view, string k_sql);//---------------------------------------------------------------------------------------------------------
//--- 
//--- CREA VIEW 
//---
//--- Par. input	: k_id = tipo operazione
//---				: k_view = nome della view
//---    	       	: k_sql = query della view
//---
//--- Ritorna st_esito : Vedi Standard
//---   
//---------------------------------------------------------------------------------------------------------
string k_sql_d
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

//--- Cancello e ricreo la view
	k_sql_d = "drop table " + trim(k_view) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	commit using this;
	k_sql_d = "drop view " + trim(k_view) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	commit using this;
	
	EXECUTE IMMEDIATE :k_sql using this;

	kst_esito.sqlerrtext = "Generazione terminata correttamente "
	if this.sqlcode <> 0 then
		if this.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Anomalie durante generazione View '" &
			                       + trim(k_view) + "' err.: " + trim(this.SQLErrText)
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Generazione View '" &
			                       + trim(k_view) + "' non riuscita: " + trim(this.SQLErrText)
		end if
		rollback using this;

//--- scrive l'errore su LOG
		kst_esito.sqldbcode = this.sqlcode
		kst_esito.sqlsyntax = trim(k_sql)
		kguo_exception.u_errori_gestione(kst_esito)
				
	else
		commit using this;
	end if


return kst_esito
end function

public function boolean test_connessione () throws uo_exception;//
boolean k_return = false


	try
		
		try
			db_disconnetti( ) 
		catch (uo_exception kuo_exceptionOK)
		end try

		if db_connetti( ) then
			k_return = true
		end if
		
	catch (uo_exception kuo_exception)
		
	end try
	
return k_return
end function

public subroutine u_crea_schema () throws uo_exception;//
//--- QUI METTERE LE ISTRUZIONI DI CREAZIONE DEL DB
//
end subroutine

public function boolean if_connessione_bloccata () throws uo_exception;//
//---	Torna FALSE=connessione OK, TRUE=connessione BLOCCATA
//--- da personalizzare
//
boolean k_return = false
//st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
//kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
//
//
//kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg
////--- controlla se connessione bloccata
//kuf1_wm_pklist_cfg.get_wm_pklist_cfg( kst_tab_wm_pklist_cfg)
//
//if kst_tab_wm_pklist_cfg.blocca_importa = kuf1_wm_pklist_cfg.ki_blocca_importa_tutto then	
//	k_return = TRUE
//end if	


return k_return

end function

public function boolean db_connetti (st_tab_db_cfg kst_tab_db_cfg) throws uo_exception;//---
//---	Effettua la connessione al DB X IL CRM
//---	Output: TRUE=connessione OK; FALSE=nessuna connessione
//---
//---   Lancia una ECCEZIONE x errore grave
//---
boolean k_return = false
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	if this.DBHandle ( ) <= 0  or isnull(this.DBHandle ( )) then

		
//=== Definizione del DB (profilo dal confdb.ini)
		if x_db_profilo(kst_tab_db_cfg) then
	
			k_return = x_db_connetti()

		end if
	end if
	

return k_return

end function

private function boolean x_db_profilo (st_tab_db_cfg kst_tab_db_cfg) throws uo_exception;//
//===	Ritorna: TRUE se tutto OK
//===     Solleva una ECCEZIONE x errore
//
boolean k_return = true
string k_file, k_sezione
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
uo_exception kuo_exception
//kuf_pilota_cmd kuf1_pilota_cmd
//kuo_sqlca_db_xweb kuo1_sqlca_db_xweb
//

//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


//--- setta il profile del DB
//set_profilo_db(kst_tab_db_cfg)
if kst_tab_db_cfg.cfg_dbms_scelta = ki_cfg_dbms_scelta_princ then
	this.DBMS = kst_tab_db_cfg.cfg_dbms
	this.DBParm = kst_tab_db_cfg.cfg_dbparm
else
	this.DBMS = kst_tab_db_cfg.cfg_dbms_alt
	this.DBParm = kst_tab_db_cfg.cfg_dbparm_alt
end if

if kst_tab_db_cfg.cfg_autocommit = "true" then
	this.AutoCommit = true
else
	this.AutoCommit = false
end if

if trim(this.dbms) = "nessuno"  then
	k_return = false
	kst_esito.esito = kkg_esito.not_fnd
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText =  "Non trovata definizione del " + ki_db_descrizione + " in 'Proprietà Accesso del DB' ~n~r"+ &
				"Impossibile stabilire la connessione con il DB: ~n~r" +  &
				"(" + trim(this.dbms) + " DbParm " + &
				trim(this.dbparm) + ")~n~r" & 
				+ "Definizione cercata nella Tabella: DB_CFG~n~r" &
				+ " ~n~rNon sara' possibile operare sugli archivi del Database ~n~r" 
				
	kuo_exception = create uo_exception								
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception

end if


SetPointer(oldpointer)


return k_return


end function

public function st_esito db_truncate (string k_table) throws uo_exception;//-----------------------------------------------------------------------------------------------------------------------------------
//--- 
//--- TRUNCATE TABELLA  (pulizia di tutte le righe!!!) 
//---
//--- Par. input	: k_table = nome della tabella
//--- 		        
//--- Ritorna st_esito : Vedi Standard
//---   
//-----------------------------------------------------------------------------------------------------------------------------------
string k_sql_d
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

//--- Cancello e ricreo view/tab
	k_sql_d = "TRUNCATE TABLE " + trim(k_table) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	kst_esito.sqlerrtext = "Generazione terminata correttamente "
	if this.sqlcode <> 0 then
		if this.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Anomalie durante op. di TRUNCATE Table '" &
			                       + trim(k_table) + "' err.:" + trim(this.SQLErrText)
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Operazione di TRUNCATE Table '" &
			                       + trim(k_table) + "' non riuscita:" + trim(this.SQLErrText)
		end if
		rollback using this;

		if kst_esito.sqlcode < 0 then
			
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		end if
		
	else
		commit using this;
	end if


return kst_esito
end function

public subroutine set_profilo_db () throws uo_exception;//---
//--- Imposta il profilo DB su questo oggetto x la Connessione
//---

x_db_profilo( )

//




end subroutine

public function boolean db_riconnetti () throws uo_exception;//---
//---   Effettua tentativi di Ri-connessione al DB (massimo 10 tentativi)
//---	Output: TRUE=connessione OK; FALSE=nessuna connessione
//---
//---   Lancia una ECCEZIONE x errore grave
//---
boolean k_connesso=false
st_esito kst_esito
pointer oldpointer

	
try

	k_connesso = if_connesso_x( )

	do while not k_connesso and ki_n_riconnessioni < 3
		
		try 
//--- Puntatore Cursore da attesa.....
			oldpointer = SetPointer("cur_connection.cur")
			
			if ki_n_riconnessioni > 0 then
				sleep (2) // un attimo di attesa....
			end if
			ki_n_riconnessioni ++
			
//--- Connessione al db
			if x_db_connetti() then
				ki_n_riconnessioni = 0
				k_connesso = true // RI-CONNESSO!!
			end if
			
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
			if kst_esito.esito = kguo_exception.KK_st_uo_exception_tipo_non_eseguito then
				exit
			end if
		end try
		
	loop
	
	kguo_exception.inizializza(this.classname())
	if k_connesso then
		kguo_exception.kist_esito.esito = kkg_esito.ok
		kguo_exception.kist_esito.sqlerrtext = "Riconnesso al DB dopo '" + string(ki_n_riconnessioni) + "' tentativi."
	else
		kguo_exception.kist_esito.esito = kkg_esito.db_ko
		kguo_exception.kist_esito.sqlerrtext = "Non è stato possibile riconnettersi al DB dopo '" + string(ki_n_riconnessioni) + "' tentativi."
	end if
	kguo_exception.scrivi_log( )
	
catch (uo_exception kuo1_exception)	
	throw kuo1_exception
	
finally
	SetPointer(kkg.pointer_default)
	

end try

return k_connesso
end function

public function integer u_get_col_len (string a_table, string a_col);//
//--- get defined column size 
//

return 0
end function

public function integer x_db_connetti_post_ok () throws uo_exception;//
//--- Dopo la connessione ok fa delle cose 
//

return 0
end function

public function boolean db_connetti () throws uo_exception;//---
//---   Effettua la connessione al DB 
//---	Output: TRUE=connessione OK; FALSE=nessuna connessione
//---
//---   Lancia una ECCEZIONE x errore grave
//---
boolean k_return=false
st_esito kst_esito


try

	kst_esito = kguo_exception.inizializza(this.classname())

//--- Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)

	if if_connessione_bloccata( ) then
	
		db_disconnetti( ) // devo disconnettermi poichè la connessione è bloccata
	
		if not ki_conn_blk_msg_done then
			ki_conn_blk_msg_done = true 
			kguo_exception.inizializza(this.classname())
			kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_non_eseguito )
			kguo_exception.setmessage( "La connessione dati a " + ki_db_descrizione &
											+ " è BLOCCATA, puoi abilitarla da 'Proprietà del DB'" &
											+ " - Nessuna operazione verso questo connessione può essere effettuata. ")
			kGuo_exception.messaggio_utente( ) 
//			throw kguo_exception
		end if
	
	else
		ki_conn_blk_msg_done = false

		if if_connesso( ) then
			k_return=true
		else
	//--- piglia i dati di connessione dal DB	
			x_db_profilo() 
		
	//--- Connessione al db
			k_return = x_db_connetti()
		end if

	end if
	
catch (uo_exception kuo_exception)	
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)
	

end try

return k_return
end function

public function boolean db_disconnetti () throws uo_exception;//
//---   Ritorna: TRUE x OK
//
boolean k_return = true
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
uo_exception kuo_exception



//--- Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


//--- Se DB connesso 
	if this.DBHandle ( ) > 0 then

		disconnect using this;

		if this.sqlcode < 0 then
			k_return = false
			kst_esito.esito = kkg_esito.DB_KO
			kst_esito.sqlcode = this.sqlcode
			kst_esito.SQLErrText = trim(this.sqlerrtext) + "~n~r" + &
						"Codice : " + string(this.sqldbcode, "#####") + "~n~r" +&
					this.sqlreturndata
			kuo_exception = create uo_exception								
			kuo_exception.set_esito(kst_esito)
			throw kuo_exception
		else
			if this.sqlcode <> 0 then
				k_return = false
				kst_esito.esito = kkg_esito.db_wrn
				kst_esito.sqlcode = this.sqlcode
				kst_esito.SQLErrText = trim(this.sqlerrtext) 
				kuo_exception = create uo_exception								
				kuo_exception.set_esito(kst_esito)
				throw kuo_exception
			end if	
		end if
	end if


SetPointer(oldpointer)

return k_return


end function

protected function boolean u_if_dberror_grave (integer a_code);//
//--- DA PERSONALIZZARE: Ogni Db ha i suoi errori differenti
//
//--- evito di esporre gli errori di 'DROP TBABLE/VIEW' (in ORACLE code = 942 e in MSSQL sono 3701 e 3705  è tabella o view non esiste!) 
//---     oppure di non connesso (in ORACLE 3113)
//	if a_code <> 942 and a_code <> -523 and a_code <> -206 and a_code <> -394 and a_code <> 3705 and a_code <> 3701 &
//			and a_code <> 3113 then
//			
//		return true
//		
//	else
//		
//		return false
//		
//	end if
return true
end function

protected function boolean u_error_db_if_login (ref st_esito ast_esito);//
//---- Gestione PERSONALIZZATA a seconda del DB x errore di Login
//
//
	return false

end function

private subroutine u_error_db (ref st_esito ast_esito);//
//---- gestione prsonalizzata a seconda del DB degli errori della procedura
//
//
long k_sqlcode 
long k_sqldbcode
string k_sqlerrtext


k_sqlcode = this.sqlcode
k_sqldbcode = this.sqldbcode
k_sqlerrtext = this.sqlerrtext

if u_error_db_if_login(ast_esito) then
	
elseif u_error_db_if_conn(ast_esito) then

elseif u_error_db_if_conn_timeout(ast_esito) then
	
elseif u_error_others(ast_esito) then
	
	u_error_common(ast_esito)
	
end if

this.sqlcode = k_sqlcode
this.sqldbcode = k_sqldbcode 
this.sqlerrtext = k_sqlerrtext


end subroutine

protected function boolean u_error_db_if_conn (ref st_esito ast_esito);//
//---- gestione personalizzata a seconda del DB per errore di CONNESSIONE
//
//
		
	return false




end function

protected function boolean u_error_db_if_conn_timeout (ref st_esito ast_esito);//
//---- gestione PERSONALIZZATA a seconda del DB per errore di TIMEOUT di CONNESSIONE
//
//
		
	return false




end function

private subroutine u_error_common (ref st_esito ast_esito);//
//---- gestione generica degli errori della procedura
//
//

	CHOOSE CASE ast_esito.SQLdbcode
	
	//		"~n~r"
		CASE 121  // errore strano interno
			kguo_exception.messaggio_utente("Connessione di rete Interrotta",  &
				"Riconnettersi alla rete e riaprire questa funzione. Altrimenti chiudere il programma.~n~r" &
				+ " Oggetto: " + trim(ast_esito.nome_oggetto)   &
				+ " dbcode: " + string(ast_esito.sqldbcode)  &
				+ " sqlcode: " + string(ast_esito.sqlcode) &
				+ " syntax: " + trim(ast_esito.SQLErrText) + " -> " + trim(ast_esito.sqlsyntax))   
			
	//		"~n~r"
		CASE -04  // errore strano interno
			ast_esito.esito = kkg_esito.no_esecuzione
			ast_esito.sqlcode = 0
			ast_esito.sqlerrtext = "Anomalia generica. " &
				+ "Non è possibile proseguire correttamente l'operazione!!~n~r" + trim(ast_esito.SQLErrText)  &
				+ " Oggetto: " + trim(ast_esito.nome_oggetto)   &
				+ " dbcode: " + string(ast_esito.sqldbcode)  &
				+ " sqlcode: " + string(ast_esito.sqlcode) &
				+ " syntax: " + trim(ast_esito.sqlsyntax)
			kguo_exception.scrivi_log( ) // u_write_error()
			
		case else
			if sqlca.sqlcode = 0 and ast_esito.SQLdbcode > 0 then
				// niente di grave forse solo un tentativo di connessione fallito
			else
				kguo_exception.messaggio_utente("Codice programma errato",  &
					"Probabile errore interno di programmazione. " &
					+ "Non è possibile proseguire correttamente l'operazione!!~n~r" + trim(ast_esito.SQLErrText)  &
					+ "- Oggetto: " + trim(ast_esito.nome_oggetto)   &
					+ " dbcode: " + string(ast_esito.sqldbcode)  &
					+ " sqlcode: " + string(ast_esito.sqlcode) &
					+ " syntax: " + trim(ast_esito.sqlsyntax))
		end if
	
	END CHOOSE





end subroutine

protected function boolean u_error_others (ref st_esito ast_esito);//
//---- gestione generica x errori generici
//
//

return false
end function

on kuo_sqlca_db_0.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuo_sqlca_db_0.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event dberror;//
st_esito kst_esito

// -1 è di solito un errore di 'TRANSAZIONE NON CONNESSA' che si verifica spesso, quindi non faccio nulla
	if code <> -1 and sqldbcode <> 0 then  
		
//--- errori personaizzati sul DB		
		if u_if_dberror_grave(code) then
	
			kst_esito = kguo_exception.inizializza(kGuf_data_base.u_getfocus_nome())
		
			kst_esito.sqlsyntax = trim(sqlsyntax)
			if isnull(kst_esito.sqlsyntax) then kst_esito.sqlsyntax = ""
		
			kst_esito.sqlerrtext = trim(sqlerrtext)
			if isnull(kst_esito.sqlerrtext) then kst_esito.sqlerrtext = ""
		
			kst_esito.sqlcode = this.sqlcode
			if this.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
			else
				kst_esito.esito = kkg_esito.db_wrn
			end if
			kst_esito.sqldbcode = code

			kguo_exception.set_esito(kst_esito)

			u_error_db(kst_esito)
			
		end if
	end if


RETURN 1 // Do not display system error message

end event

event constructor;//
ki_db_descrizione = "DB della Procedura"   // il default

end event

event destructor;//
if isvalid(kiuo_sqlca_db_0_saved) then destroy kiuo_sqlca_db_0_saved
end event

