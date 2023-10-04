$PBExportHeader$kuo_sqlca_db_e1.sru
forward
global type kuo_sqlca_db_e1 from kuo_sqlca_db_0
end type
end forward

global type kuo_sqlca_db_e1 from kuo_sqlca_db_0
end type
global kuo_sqlca_db_e1 kuo_sqlca_db_e1

forward prototypes
protected subroutine x_db_profilo () throws uo_exception
public function boolean if_connessione_bloccata () throws uo_exception
public function boolean u_db_connetti (ref datawindow adw_1) throws uo_exception
public function integer u_get_col_len (string a_table, string a_col)
public function integer x_db_connetti_post_ok () throws uo_exception
protected function boolean u_if_dberror_grave (integer a_code)
protected function boolean u_error_db_if_conn (ref st_esito ast_esito)
protected function boolean u_error_db_if_conn_timeout (ref st_esito ast_esito)
public function boolean if_connesso_x () throws uo_exception
end prototypes

protected subroutine x_db_profilo () throws uo_exception;//
//===	Ritorna: TRUE se tutto OK
//===     Solleva una ECCEZIONE x errore
//
string k_file, k_sezione
st_esito kst_esito
kuf_e1_conn_cfg kuf1_e1_conn_cfg


SetPointer(kkg.pointer_attesa)
kst_esito = kguo_exception.inizializza(this.classname())

kuo_sqlca_db_e1 kuo1_sqlca_db_e1 

kuf1_e1_conn_cfg = create kuf_e1_conn_cfg

kuo1_sqlca_db_e1 = this

kuf1_e1_conn_cfg.get_profilo_db(kuo1_sqlca_db_e1)

//kuo1_sqlca_db_e1 = kuf1_e1_conn_cfg.get_profilo_db()

this.dbms = kuo1_sqlca_db_e1.dbms
this.dbparm = kuo1_sqlca_db_e1.dbparm
this.AutoCommit = kuo1_sqlca_db_e1.AutoCommit
this.servername = kuo1_sqlca_db_e1.servername
this.logid = kuo1_sqlca_db_e1.logid
this.logpass = kuo1_sqlca_db_e1.logpass

if trim(this.dbms) = "nessuno"  then

	kst_esito.esito = kkg_esito.not_fnd
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText =  "Non trovata definizione del 'DB di E-ONE' in Proprietà Connessione E-ONE ~n~r"+ &
				"Impossibile stabilire la connessione con il DB: ~n~r" +  &
				"(" + trim(this.dbms) + " DbParm " + &
				trim(this.dbparm) + ")~n~r" & 
				+ "Definizione cercata nella Tabella: E1_CONN_CFG~n~r" &
				+ " ~n~rNon sara' possibile operare sugli archivi del Server di E-ONE (db remoto di Sterigenics) ~n~r" 
				
//	if isvalid(kuo1_sqlca_db_e1) then destroy kuo1_sqlca_db_e1
	if isvalid(kuf1_e1_conn_cfg) then destroy kuf1_e1_conn_cfg 
				
	kguo_exception.inizializza()
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception

end if

//if isvalid(kuo1_sqlca_db_e1) then destroy kuo1_sqlca_db_e1
destroy kuf1_e1_conn_cfg 

SetPointer(kkg.pointer_default)



end subroutine

public function boolean if_connessione_bloccata () throws uo_exception;//
//---	Torna FALSE=connessione OK, TRUE=connessione BLOCCATA
//--- da personalizzare
//
boolean k_return = false
st_tab_e1_conn_cfg kst_tab_e1_conn_cfg
kuf_e1_conn_cfg kuf1_e1_conn_cfg


kuf1_e1_conn_cfg = create kuf_e1_conn_cfg
//--- controlla se connessione bloccata
kuf1_e1_conn_cfg.get_e1_conn_cfg( kst_tab_e1_conn_cfg)

if kst_tab_e1_conn_cfg.blocca_conn = kuf1_e1_conn_cfg.ki_blocca_conn_si then	
	k_return = TRUE
end if	

return k_return

end function

public function boolean u_db_connetti (ref datawindow adw_1) throws uo_exception;//---
//---  Effettua la connessione al DB e aggiorna e setta la transazione e lo schema del DW  
//---	Inp: datawindow su cui lavorare
//---	Out: TRUE=connessione OK; FALSE=nessuna connessione
//---
//---   Lancia una ECCEZIONE x errore grave
//---
boolean k_return = false

	
try
	SetPointer(kkg.pointer_attesa )

	if db_connetti( ) then
		k_return = true
		
		adw_1.settransobject(this)
		
	end if
	
	
catch (uo_exception kuo_exception)	
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)
	

end try



return k_return

end function

public function integer u_get_col_len (string a_table, string a_col);//
int k_return 
datastore kds_1

SELECT min(CHAR_LENGTH)
          into :k_return
            FROM ALL_TAB_COLUMNS 
	WHERE TABLE_NAME = :a_table AND COLUMN_NAME = :a_col
	using this;

if isnull(k_return) then
	k_return = 0
end if
		
return k_return


end function

public function integer x_db_connetti_post_ok () throws uo_exception;//---
//---  Setta lo schema del DB
//---  rit: 0 
//---
//---   Lancia una ECCEZIONE x errore grave
//---
kuf_e1_conn_cfg kuf1_e1_conn_cfg

	
try
	
	kuf1_e1_conn_cfg = create kuf_e1_conn_cfg
	kuf1_e1_conn_cfg.u_sql_set_schema_nome()
	
	
catch (uo_exception kuo_exception)	
	throw kuo_exception
	
finally
	if isvalid(kuf1_e1_conn_cfg) then destroy kuf1_e1_conn_cfg
	

end try



return 0

end function

protected function boolean u_if_dberror_grave (integer a_code);//--- evito di esporre gli errori di 'DROP TBABLE/VIEW' in ORACLE code = 942 
//---     oppure di non connesso (in ORACLE 3113)
	if a_code <> 942  &
			and a_code <> 3113 then
			
		return true
		
	else
		
		return false
		
	end if
end function

protected function boolean u_error_db_if_conn (ref st_esito ast_esito);//
//---- gestione personalizzata a seconda del DB per errore di CONNESSIONE
//
//
	try 

		if not if_connesso( ) then
			
			ast_esito.sqlerrtext = "Tentativo di Ri-connessione ai Dati di E1... " 
			kguo_exception.scrivi_log( ) // u_write_error()
			//errori_scrivi_esito("W", kst_esito) 
//--- tentativo di connessione al db.....
			if not kguo_sqlca_db_e1.db_riconnetti( ) then
				kguo_exception.messaggio_utente("Disconnessione Dati E1", "Persa la Connessione dati al DB di E1, il programma continua senza connessione.")
			else
				ast_esito.esito = kkg_esito.ok
				ast_esito.sqlcode = 0
				ast_esito.sqlerrtext = "Ri-connessione ai Dati di E1 conclusa con successo. " 
				kguo_exception.scrivi_log( ) // u_write_error()
			end if

		else
			
			return false
	
		end if
	
	catch (uo_exception kuo1_exception)
		kguo_exception.messaggio_utente("Connessione Dati E1", "Persa la Connessione al DB di E1, tentativo di riconnessione fallito (" + trim(kuo1_exception.getmessage())+").")
		
	finally

	end try
	
	return true

end function

protected function boolean u_error_db_if_conn_timeout (ref st_esito ast_esito);//
//---- gestione personalizzata a seconda del DB per errore di CONNESSIONE
//
//
CHOOSE CASE ast_esito.SQLdbcode

	case 	12170 // timeout ORACLE
			
		kguo_exception.messaggio_utente( &
						"Fallita connessione al DB di E1", "Connessione ai Dati E1 in errore, superato il tempo massimo di attesa di risposta del DB (" &
						+ trim(ast_esito.sqlerrtext)+").")
		kguo_exception.scrivi_log( ) // u_write_error()

		return true
		
	case else
		
		return false

END CHOOSE


end function

public function boolean if_connesso_x () throws uo_exception;//
int k_connesso=0

	
	if kiuo_sqlca_db_0_saved.sqldbcode = 12541 then // connessione persa

		return false

	else
		
		SELECT count(*)
		  into :k_connesso 
		  FROM global_name 
		  using this; 
		
		if sqlcode = 0 then
			
			return true   
			
		else
			
			return false
	
		end if

	end if


end function

on kuo_sqlca_db_e1.create
call super::create
end on

on kuo_sqlca_db_e1.destroy
call super::destroy
end on

event constructor;//
 ki_db_descrizione = "DB di scambio dati con il Sistema E-ONE"
ki_title_id = "db_e1"
end event

