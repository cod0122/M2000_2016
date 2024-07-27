$PBExportHeader$kuo_sqlca_db_plav.sru
forward
global type kuo_sqlca_db_plav from kuo_sqlca_db_0
end type
end forward

global type kuo_sqlca_db_plav from kuo_sqlca_db_0
end type
global kuo_sqlca_db_plav kuo_sqlca_db_plav

type variables

end variables

forward prototypes
private subroutine x_db_profilo () throws uo_exception
protected function boolean u_if_dberror_grave (integer a_code)
public function boolean if_connesso_x () throws uo_exception
protected function boolean u_error_db_if_login (ref st_esito ast_esito)
protected function boolean u_error_db_if_conn (ref st_esito ast_esito)
protected function boolean u_error_db_if_conn_timeout (ref st_esito ast_esito)
protected function boolean u_error_others (ref st_esito ast_esito)
end prototypes

private subroutine x_db_profilo () throws uo_exception;//
//===	Ritorna: TRUE se tutto OK
//===     Solleva una ECCEZIONE x errore
//
string k_file, k_sezione
st_esito kst_esito
kuf_plav_conn_cfg kuf1_plav_conn_cfg


SetPointer(kkg.pointer_attesa)

kst_esito = kguo_exception.inizializza(this.classname())
kuo_sqlca_db_plav kuo1_sqlca_db_plav 
	
kuf1_plav_conn_cfg = create kuf_plav_conn_cfg

kuo1_sqlca_db_plav = this

kuf1_plav_conn_cfg.get_profilo_db(kuo1_sqlca_db_plav)

this.dbms = kuo1_sqlca_db_plav.dbms
this.dbparm = kuo1_sqlca_db_plav.dbparm
this.AutoCommit = kuo1_sqlca_db_plav.AutoCommit
this.servername = kuo1_sqlca_db_plav.servername
this.logid = kuo1_sqlca_db_plav.logid
this.logpass = kuo1_sqlca_db_plav.logpass

if trim(this.dbms) = "nessuno"  then

	kst_esito.esito = kkg_esito.not_fnd
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText =  "Non trovata definizione del 'DB di Interfaccia al Pilota' in Proprietà Connessione "+ &
				+ kkg.acapo + "Impossibile stabilire la connessione con il DB: " +  &
				+ kkg.acapo + "(" + trim(this.dbms) + " DbParm " + &
				trim(this.dbparm) + ")" & 
				+ kkg.acapo + "Definizione cercata nella Tabella: PLAV_CONN_CFG" &
				+ kkg.acapo + "Non sara' possibile operare sul DB di Interfaccia con il Pilota! "
				
	if isvalid(kuf1_plav_conn_cfg) then destroy kuf1_plav_conn_cfg 
				
	kguo_exception.inizializza()
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception

end if

//if isvalid(kuo1_sqlca_db_e1) then destroy kuo1_sqlca_db_e1
destroy kuf1_plav_conn_cfg 

SetPointer(kkg.pointer_default)



end subroutine

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

public function boolean if_connesso_x () throws uo_exception;//
int k_connesso=0

	
	if kiuo_sqlca_db_0_saved.sqldbcode = 999 or kiuo_sqlca_db_0_saved.sqldbcode = 10054 &
					or kiuo_sqlca_db_0_saved.sqldbcode = 53 then // connessione persa

		return false

	else
		select count(*) into :k_connesso from sys.tables 
			using this;
		
		if k_connesso > 0 then
			
			return true   
			
		else
			
			return false
	
		end if

	end if

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
			if not db_riconnetti( ) then
				kguo_exception.messaggio_utente("Programma non operativo", "Persa la Connessione al database " + ki_db_descrizione + ", il programma verrà chiuso. " & 
								+ kkg.acapo + "Motivo: " + left(ast_esito.sqlerrtext,40))
			else
				ast_esito.esito = kkg_esito.ok
				ast_esito.sqlcode = 0
				ast_esito.sqlerrtext = "Ri-connessione al database " + ki_db_descrizione + " conclusa con successo. " 
				kguo_exception.scrivi_log( ) // u_write_error()
			end if
		
		else
		
			return false

		end if
		
	catch (uo_exception kuo_exception)
			kguo_exception.messaggio_utente("Programma non operativo", "Persa la Connessione al database  " + ki_db_descrizione + ", prego chiudere e riavviare il programma")
			
	finally

	end try
	
	return true

end function

protected function boolean u_error_db_if_conn_timeout (ref st_esito ast_esito);//
//---- gestione personalizzata a seconda del DB per errore di CONNESSIONE
//
//
CHOOSE CASE ast_esito.SQLdbcode

//informix	case -1811, -349, -1803, -25580 //--- manca connessione 
	case 	-4060, -40197, -40501, -40613, -49918, -49919, -49920, -4221, 10054, 64 //, 121 timeout
		
		kguo_exception.messaggio_utente( &
						"Fallita connessione al DB", "Connessione al db " + ki_db_descrizione + " in errore, superato il tempo massimo di attesa di risposta del server (" &
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
		kguo_exception.messaggio_utente( )
		
		return true
		
	elseif ast_esito.SQLdbcode = 13535 then // Errore in aggiornamento TEmporalTable

		ast_esito.esito = kkg_esito.db_wrn
		ast_esito.sqlerrtext = "Errore interno restituito dal DB '" + ki_db_descrizione + "' (tabella TemporalTable). " + ast_esito.sqlerrtext
		kguo_exception.scrivi_log(ast_esito)
		
		return false
		
	end if

end function

on kuo_sqlca_db_plav.create
call super::create
end on

on kuo_sqlca_db_plav.destroy
call super::destroy
end on

event constructor;call super::constructor;//
	ki_db_descrizione = "DB di Interfaccia Programmazione Pilota Impianto G2 e G3"
	ki_title_id = "db_plav"
end event

