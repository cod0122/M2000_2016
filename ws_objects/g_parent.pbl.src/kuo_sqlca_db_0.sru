$PBExportHeader$kuo_sqlca_db_0.sru
forward
global type kuo_sqlca_db_0 from transaction
end type
end forward

global type kuo_sqlca_db_0 from transaction
event type integer u_dberror ( long a_code,  string a_sqlsyntax,  string a_sqlerrtext )
end type
global kuo_sqlca_db_0 kuo_sqlca_db_0

type variables
//
//--- identifica il DB es. "db_magazzino"
public string ki_title_id = ""
//--- mettere la descrizione del tipo di DB, serve x personalizzare eventuale messaggio all'utente
public string ki_db_descrizione = "" 

//--- valori della colonna blocca_richieste
public constant string ki_blocca_connessione_no = "0" 
public constant string ki_blocca_connessione_si = "1"

//--- valori della colonna cfg_dbms_scelta 
private constant string ki_cfg_dbms_scelta_princ = "1"
private constant string ki_cfg_dbms_scelta_muletto = "2"

//protected st_esito kist_esito

private integer ki_n_riconnessioni
public boolean ki_conn_blk_msg_done 

//--- utile per salvare i dati sqlerr ... 
protected kuo_sqlca_db_0 kiuo_sqlca_db_0_saved

protected kuo_sqlca_db_0 kiuo_sqlca_db_0 = this


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
protected function boolean u_if_dberror_grave (integer a_code)
protected function boolean u_error_db_if_login (ref st_esito ast_esito)
protected function boolean u_error_db_if_conn (ref st_esito ast_esito)
protected function boolean u_error_db_if_conn_timeout (ref st_esito ast_esito)
private subroutine u_error_common (ref st_esito ast_esito)
protected function boolean u_error_others (ref st_esito ast_esito)
public function boolean db_disconnetti ()
protected function integer db_sql_execute (string a_sql, boolean a_commit, boolean a_throw_when_error) throws uo_exception
public function integer db_insert_select (string k_table, string k_campi, string k_select) throws uo_exception
public function st_esito db_crea_view (string k_view, string k_sql) throws uo_exception
public function st_esito db_crea_temp_table (string a_table, string a_campi, string a_select) throws uo_exception
public function st_esito db_crea_temp_table (string a_table, string a_campi) throws uo_exception
private function st_esito db_crea_temp_table_1 (string a_table, string a_campi) throws uo_exception
public subroutine u_if_col_len_ok (string a_table, string a_col, string a_value) throws uo_exception
protected subroutine u_error_db (ref st_esito ast_esito)
end prototypes

event type integer u_dberror(long a_code, string a_sqlsyntax, string a_sqlerrtext);//
st_esito kst_esito

// -1 è di solito un errore di 'TRANSAZIONE NON CONNESSA' che si verifica spesso, quindi non faccio nulla
//     code = 4104 o 207 l'ho beccato per errore da retrieve in un DATASTORE
	if a_code <> -1 and (sqldbcode <> 0 or a_code = 4104 or a_code = 207) then  
		
//--- errori personaizzati sul DB		
		if u_if_dberror_grave(a_code) then
	
			kst_esito = kguo_exception.inizializza(kGuf_data_base.u_getfocus_nome())
		
			kst_esito.sqlsyntax = trim(a_sqlsyntax)
			if isnull(kst_esito.sqlsyntax) then kst_esito.sqlsyntax = ""
		
			kst_esito.sqlerrtext = trim(a_sqlerrtext)
			if isnull(kst_esito.sqlerrtext) then kst_esito.sqlerrtext = ""
		
			kst_esito.sqlcode = this.sqlcode
			if this.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
			else
				kst_esito.esito = kkg_esito.db_wrn
			end if
			kst_esito.sqldbcode = a_code

			kguo_exception.set_esito(kst_esito)

			u_error_db(kst_esito)
			
		end if
	end if


RETURN 1 // Do not display system error message

end event

public function st_esito db_commit ();//
//===	Ritorna St_esito - come da standard
//
st_esito kst_esito
uo_exception kuo_exception

	kst_esito.esito = kkg_esito.ok

	commit using this;

	if this.sqlcode <> 0 then
		kuo_exception = create uo_exception
		kuo_sqlca_db_0 = this
		if sqlerrtext > " " then
			sqlerrtext = "Errore in Conferma dati sul DB (Commit)." + kkg.acapo + sqlerrtext
		else
			sqlerrtext = "Errore in Conferma dati sul DB (Commit)."
		end if			
		kst_esito = kuo_exception.set_st_esito_err_db(kiuo_sqlca_db_0, sqlerrtext)
		kuo_exception.scrivi_log( )
	end if

return kst_esito

 
end function

public function st_esito db_rollback ();//
//===	Ritorna St_esito - come da standard
//
st_esito kst_esito
uo_exception kuo_exception


	kst_esito.esito = kkg_esito.ok

	rollback using this;

	if this.sqlcode <> 0 then
		kuo_exception = create uo_exception
		kst_esito = kuo_exception.set_st_esito_err_db(kiuo_sqlca_db_0, "Errore in Recupero dati sul DB (Rollback).")
		kuo_exception.scrivi_log( )
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
	
	if this.sqldbcode = 0 then
	
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

try
	SetPointer(kkg.pointer_attesa)
	kst_esito = kguo_exception.inizializza(this.classname())

//--- Cancello e ricreo view/tab
	k_sql_d = "drop view " + trim(k_table) + "  " 
	db_sql_execute(k_sql_d, true, false)

	k_sql_d = "drop table " + trim(k_table) + "  " 
	db_sql_execute(k_sql_d, true, false)
	
	k_sql = " CREATE TABLE  " + trim(k_table) + "  (	" + k_sql + " ) "
	db_sql_execute(k_sql, true, false)
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

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
boolean k_return
string k_file, k_sezione
st_esito kst_esito


	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

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
		SetPointer(kkg.pointer_default)
		kst_esito.esito = kkg_esito.not_fnd
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText =  "Non trovata definizione del " + ki_db_descrizione + " in 'Proprietà Accesso al Database'."+ &
					+ kkg.acapo + "Impossibile stabilire la connessione a: " +  &
					+ " DbParm '" + trim(this.dbparm) + "' " & 
					+ kkg.acapo + "Definizione cercata nella Tabella di Configurazione. " &
					+ kkg.acapo+ "Non sarà possibile operare sugli archivi del Database! " 
					
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	
	end if

	k_return = true

	SetPointer(kkg.pointer_default)

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
		ki_n_riconnessioni = 0
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

public function boolean db_disconnetti ();/*
 Disconnette il DB
    Rit: TRUE x OK
*/
boolean k_return = true
//pointer oldpointer  // Declares a pointer variable
uo_exception kuo_exception


//oldpointer = SetPointer(HourGlass!)

kuo_exception = create uo_exception								
kuo_exception.inizializza(this.classname())

//--- Se DB connesso 
	if this.DBHandle ( ) > 0 then

		disconnect using this;

		if this.sqlcode <> 0 then
			k_return = false
			kuo_exception.set_st_esito_err_db(kiuo_sqlca_db_0, &
					"Errore in Chiusura della Connessione del db " + trim(this.ki_db_descrizione))
			kuo_exception.scrivi_log()
		end if
	end if

//SetPointer(oldpointer)

return k_return


end function

protected function integer db_sql_execute (string a_sql, boolean a_commit, boolean a_throw_when_error) throws uo_exception;/*
	Esegue istruzione SQL 
		inp: sql
			: true = fa commit/rollback
			: true = esegue 'throw kguo_exception' se errore sql
		ret: sqlcode
*/
int k_sqlcode

	kguo_exception.inizializza(this.classname())

//--- Cancello e ricreo la view
	EXECUTE IMMEDIATE :a_sql using this;
	k_sqlcode = this.sqlcode

	if this.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Esecuzione comando al Database fallito! " &
											+ kkg.acapo + trim(a_sql))
		if a_commit then
			rollback using this;
		end if
		
		if a_throw_when_error then 
			kguo_exception.scrivi_log( )
			throw kguo_exception
		end if
		
	else
		if a_commit then
			commit using this;
		end if
	end if

return k_sqlcode
end function

public function integer db_insert_select (string k_table, string k_campi, string k_select) throws uo_exception;/*
	Istruzione di	INSERT INTO table2 (column1, column2, column3, ...)
			SELECT column1, column2, column3, ...
			FROM table1
			WHERE condition;
		inp: k_table = nome della tabella su cu fare l'INSERT
	  		: k_campi = i campi della tabella
			: k_select = la query da cui caricare i dati
		rit: sqlcode
*/
string k_sql_d
int k_sqlcode


	k_sql_d = " INSERT INTO "  + trim(k_table) + "  (" + trim(k_campi) + ") " + k_select
	k_sqlcode = db_sql_execute( k_sql_d, true, true)
	
	
return k_sqlcode
end function

public function st_esito db_crea_view (string k_view, string k_sql) throws uo_exception;/*
 CREA VIEW 
	inp: k_view = nome della view
     	: k_sql = query della view
*/
string k_sql_d


try
	
	kguo_exception.inizializza(this.classname())
	
//--- Cancello e ricreo la view
	k_sql_d = "drop table " + trim(k_view) + " " 
	db_sql_execute(k_sql_d, true, false)

	k_sql_d = "drop view " + trim(k_view) + " " 
	db_sql_execute(k_sql_d, true, false)
	
// nelle vecchie chiamate veniva aggiunta la 'CREATE VIEW xxxxx'	
	if pos(upper(k_sql) + " ", " VIEW ") > 0 then  
		k_sql_d = k_sql
	else
		k_sql_d = "create view " + trim(k_view) + " " + k_sql
	end if
	db_sql_execute(k_sql_d, true, true)  // esegue la CREATE VIEW

catch (uo_exception kuo_exception)
	throw kuo_exception
//	kst_esito = kuo_exception.get_st_esito()
	
end try

return kguo_exception.kist_esito
end function

public function st_esito db_crea_temp_table (string a_table, string a_campi, string a_select) throws uo_exception;/*
CREA TEMP TABLE 
	inp: a_table = nome della tabella (in SQL SERVER deve iniziare per '#')
	          		: a_campi = i campi della tabella
            		: k_select = la query di carico della tabella
*/
string k_sql_d


	kguo_exception.inizializza(this.classname())

	kguo_exception.kist_esito = db_crea_temp_table(a_table, a_campi)  // crea la tabella

	if trim(a_select) = "" then
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlcode = 0
		kguo_exception.kist_esito.sqlerrtext = "Manca la query da cui prendere i dati - tabella temporanea '" + trim(a_table) + "' non popolata! "
		return kguo_exception.kist_esito
	end if

	k_sql_d = " insert into "  + trim(a_table) + "  " + trim(a_select) 
	db_sql_execute( k_sql_d, true, true)
	
return kguo_exception.kist_esito
end function

public function st_esito db_crea_temp_table (string a_table, string a_campi) throws uo_exception;/*
CREA TEMP TABLE 
	inp: a_table = nome della tabella (in SQL SERVER deve iniziare per '#')
	          		: a_campi = i campi della tabella
*/

	kguo_exception.inizializza(this.classname())

	if trim(a_table) > " " and a_campi > " " then
	else
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlcode = 0
		if a_table > " " then
			kguo_exception.kist_esito.sqlerrtext = "Mancano i nomi delle colonne per la tabella temporanea '" + a_table + "', generazione tabella interrotta! "
		else
			kguo_exception.kist_esito.sqlerrtext = "Manca il nome della tabella temporanea, generazione tabella interrotta! "
		end if			
		return kguo_exception.kist_esito
	end if

	return db_crea_temp_table_1(a_table, a_campi)

end function

private function st_esito db_crea_temp_table_1 (string a_table, string a_campi) throws uo_exception;/*
CREA TEMP TABLE 
	inp: a_table = nome della tabella (in SQL SERVER deve iniziare per '#')
	          		: a_campi = i campi della tabella
*/
string k_sql_d


	kguo_exception.inizializza(this.classname())

//--- Cancello e ricreo la view
	k_sql_d = "drop view " + trim(a_table) + "  " 
	db_sql_execute(k_sql_d, true, false)
	
	k_sql_d = "drop table " + trim(a_table) + "  " 
	db_sql_execute(k_sql_d, true, false)
	
	k_sql_d = " CREATE  TABLE "  + trim(a_table) + "  (" + trim(a_campi) + ") "
//	k_sql_d = " CREATE TEMP  TABLE "  + trim(k_table) + "  (" + trim(k_campi) + ") with no log "
//	k_sql_d = " CREATE  TABLE "  + trim(k_table) + "  (" + trim(k_campi) + ") " // DEBUG
	db_sql_execute( k_sql_d, true, true)   // crea la tabella
		
return kguo_exception.kist_esito
end function

public subroutine u_if_col_len_ok (string a_table, string a_col, string a_value) throws uo_exception;//
//--- Verifica lunghezza del valore nel campo se supera la dim max della colonna in tabella
//
int k_len_db

k_len_db = u_get_col_len(a_table, a_col)

IF k_len_db > 0 and len(trim(a_value)) > k_len_db THEN
	  kguo_exception.kist_esito.esito = kkg_esito.db_ko
	  kguo_exception.kist_esito.sqlerrtext = "Attenzione il campo '" + a_col + "' valore: '" + trim(a_value) + "' " &
								 + kkg.acapo + " lungo " + string(len(trim(a_value))) + ", supera la lunghezza massima di " &
								 + string(k_len_db) &
								 + " definita sul DB!. " + kkg.acapo + " Operazione Interrotta! "
   THROW kguo_exception
END IF
	 
end subroutine

protected subroutine u_error_db (ref st_esito ast_esito);//
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
	
// questo può mandare il LOOP l'errore xhè c'è un comando SQL elseif u_error_db_if_conn(ast_esito) then

elseif u_error_db_if_conn_timeout(ast_esito) then
	
elseif u_error_others(ast_esito) then
	
	u_error_common(ast_esito)
	
end if

this.sqlcode = k_sqlcode
this.sqldbcode = k_sqldbcode 
this.sqlerrtext = k_sqlerrtext


end subroutine

on kuo_sqlca_db_0.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuo_sqlca_db_0.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//
ki_db_descrizione = "DB della Procedura"   // il default

end event

event destructor;//
if isvalid(kiuo_sqlca_db_0_saved) then destroy kiuo_sqlca_db_0_saved
end event

event dberror;//
return event u_dberror(code, sqlsyntax, sqlerrortext + " (" + trim(ki_db_descrizione) + ")")

end event

