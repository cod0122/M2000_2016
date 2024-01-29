$PBExportHeader$kuf_plav_conn_cfg.sru
forward
global type kuf_plav_conn_cfg from kuf_parent
end type
end forward

global type kuf_plav_conn_cfg from kuf_parent
end type
global kuf_plav_conn_cfg kuf_plav_conn_cfg

type variables
//---
public string ki_blocca_conn_si ="1"
public string ki_blocca_conn_no ="0"

//--- valori della colonna cfg_dbms_scelta 
public constant string ki_cfg_dbms_scelta_princ = "1"
public constant string ki_cfg_dbms_scelta_muletto = "2"

end variables

forward prototypes
public function boolean set_blocco_conn_no () throws uo_exception
public function boolean set_blocco_conn_si () throws uo_exception
public function string u_sql_set_schema_nome () throws uo_exception
public function boolean get_profilo_db (ref kuo_sqlca_db_plav kuo_sqlca) throws uo_exception
public function string get_schema_nome (st_tab_plav_conn_cfg kst_tab_plav_conn_cfg) throws uo_exception
public subroutine if_isnull (ref st_tab_plav_conn_cfg kst_tab_plav_conn_cfg)
private function boolean set_blocca_conn (st_tab_plav_conn_cfg kst_tab_plav_conn_cfg) throws uo_exception
public function boolean get_plav_conn_cfg (ref st_tab_plav_conn_cfg ast_tab_plav_conn_cfg) throws uo_exception
public function boolean if_conn_bloccata (st_tab_plav_conn_cfg ast_tab_plav_conn_cfg) throws uo_exception
end prototypes

public function boolean set_blocco_conn_no () throws uo_exception;//--- Sblocca Importazione
boolean k_return
st_tab_plav_conn_cfg kst_tab_plav_conn_cfg


	kst_tab_plav_conn_cfg.blocca_conn = ki_blocca_conn_no

	k_return = set_blocca_conn(kst_tab_plav_conn_cfg)
	
	
return k_return
	
end function

public function boolean set_blocco_conn_si () throws uo_exception;// Blocca Importazione
boolean k_return
st_tab_plav_conn_cfg kst_tab_plav_conn_cfg


	kst_tab_plav_conn_cfg.blocca_conn = ki_blocca_conn_SI

	k_return = set_blocca_conn(kst_tab_plav_conn_cfg)
	
	 
return k_return
	
end function

public function string u_sql_set_schema_nome () throws uo_exception;/*
  Aggiorna nel SQL il nome dello schema

  input: 
  otput: 
  ritorna: nome schema (table owner)
  se ERRORE lancia un Exception
  
  ad es.: alter schema [MIODBO] transfer [dbo].[clienti];
*/
string k_return=""
string k_sql_orig, k_stringn, k_string
int k_ctr, k_lenN, k_lenO
st_esito kst_esito 
st_tab_plav_conn_cfg kst_tab_plav_conn_cfg


try 
	
//	kst_esito.esito = kkg_esito.ok 
//	kst_esito.sqlcode = 0
//	kst_esito.SQLErrText = ""
//	kst_esito.nome_oggetto = this.classname()
//
//	kst_tab_plav_conn_cfg.schema_nome = get_schema_nome(kst_tab_plav_conn_cfg)
//
//	k_sql_orig  = "alter session set current_schema = " + trim(kst_tab_plav_conn_cfg.schema_nome)
//	
//	EXECUTE IMMEDIATE :k_sql_orig using kguo_sqlca_db_e1;
//	if kguo_sqlca_db_e1.sqlcode <> 0 then
//		if kguo_sqlca_db_e1.sqlcode > 0 then
//			kst_esito.esito = kkg_esito.db_wrn
//			kst_esito.sqlcode = kguo_sqlca_db_e1.sqlcode
//			kst_esito.sqlerrtext = "DB di E1 Connesso ma ci sono anomalie durante l'impostazione del Table-Owner (schema): ''" &
//			                       + trim(kst_tab_plav_conn_cfg.schema_nome) + "'. Errore: " + trim(kguo_sqlca_db_e1.SQLErrText)
//		else
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = kguo_sqlca_db_e1.sqlcode
//			kst_esito.sqlerrtext = "DB di E1 Connesso ma c'è un errore nel nome Table-Owner (schema): '" &
//			                       + trim(kst_tab_plav_conn_cfg.schema_nome) + "'. Errore: " + trim(kguo_sqlca_db_e1.SQLErrText)
//		end if
//
//		kguo_exception.inizializza()
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//
//	end if
//	k_return = trim(kst_tab_plav_conn_cfg.schema_nome)
	
catch (uo_exception kuo_exception)
	throw kuo_exception

end try


return k_return

end function

public function boolean get_profilo_db (ref kuo_sqlca_db_plav kuo_sqlca) throws uo_exception;//---
//--- Torna il profilo DB x la Connessione
//---
boolean k_return = false
st_tab_plav_conn_cfg kst_tab_plav_conn_cfg


kuo_sqlca = create  kuo_sqlca_db_plav

get_plav_conn_cfg(kst_tab_plav_conn_cfg)

//--- Recupera le info x la connessione
if kst_tab_plav_conn_cfg.cfg_dbms_scelta = ki_cfg_dbms_scelta_princ then
	kuo_sqlca.DBMS = kst_tab_plav_conn_cfg.cfg_dbms
	kuo_sqlca.DBParm = kst_tab_plav_conn_cfg.cfg_dbparm
	kuo_sqlca.servername = kst_tab_plav_conn_cfg.cfg_servername
	kuo_sqlca.logid = kst_tab_plav_conn_cfg.cfg_utente
	kuo_sqlca.logpass = kst_tab_plav_conn_cfg.cfg_pwd
else
	kuo_sqlca.DBMS = kst_tab_plav_conn_cfg.cfg_dbms_alt
	kuo_sqlca.DBParm = kst_tab_plav_conn_cfg.cfg_dbparm_alt
	kuo_sqlca.servername = kst_tab_plav_conn_cfg.cfg_servername_alt
	kuo_sqlca.logid = kst_tab_plav_conn_cfg.cfg_utente_alt
	kuo_sqlca.logpass = kst_tab_plav_conn_cfg.cfg_pwd_alt
end if

if trim(kuo_sqlca.DBMS) > " " then
else
	kuo_sqlca.DBMS =  "nessuno"
end if
if trim(kuo_sqlca.DBParm) > " " then
else
	kuo_sqlca.DBParm =  ""
end if
if trim(kuo_sqlca.Database) > " " then
else
	kuo_sqlca.Database =  ""
end if
if kst_tab_plav_conn_cfg.cfg_autocommit = "true" then
	kuo_sqlca.AutoCommit = true
else
	kuo_sqlca.AutoCommit = false
end if

k_return = true

return k_return 


end function

public function string get_schema_nome (st_tab_plav_conn_cfg kst_tab_plav_conn_cfg) throws uo_exception;//--
//---  Torna il nome dello schema
//---
//---  input: kst_tab_plav_conn_cfg.codice  (il default è 1)
//---  otput: 
//---  ritorna: nome dello schema
//---  se ERRORE lancia un Exception
//---
string k_return=""
st_esito kst_esito 



kst_esito.esito = kkg_esito.ok 
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_plav_conn_cfg.codice = 0 or isnull(kst_tab_plav_conn_cfg.codice) then kst_tab_plav_conn_cfg.codice = 1
 
SELECT 
         plav_conn_cfg.schema_nome
    INTO
         :kst_tab_plav_conn_cfg.schema_nome
    FROM plav_conn_cfg  
   WHERE plav_conn_cfg.codice = :kst_tab_plav_conn_cfg.codice   
		using kguo_sqlca_db_magazzino ;

	
	if kguo_sqlca_db_magazzino.sqlcode >= 0 then
		
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			if isnull(kst_tab_plav_conn_cfg.schema_nome) then kst_tab_plav_conn_cfg.schema_nome = ""
			k_return = trim(kst_tab_plav_conn_cfg.schema_nome)
		end if
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura nome schema in 'Connessione di Interfaccia Pilota' " + string(kst_tab_plav_conn_cfg.codice) + "~n~r  " &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if



return k_return

end function

public subroutine if_isnull (ref st_tab_plav_conn_cfg kst_tab_plav_conn_cfg);//---
//--- Inizializza i campi della tabella 
//---
if kst_tab_plav_conn_cfg.codice > 0 then 
else
	kst_tab_plav_conn_cfg.codice  = 1
end if
if isnull(kst_tab_plav_conn_cfg.blocca_conn  ) then kst_tab_plav_conn_cfg.blocca_conn = ki_blocca_conn_no
if isnull(kst_tab_plav_conn_cfg.schema_nome  ) then kst_tab_plav_conn_cfg.schema_nome = ""
if isnull(kst_tab_plav_conn_cfg.cfg_autocommit ) then kst_tab_plav_conn_cfg.cfg_autocommit = ""
if isnull(kst_tab_plav_conn_cfg.cfg_dbms ) then kst_tab_plav_conn_cfg.cfg_dbms = ""
if isnull(kst_tab_plav_conn_cfg.cfg_dbms_scelta ) then kst_tab_plav_conn_cfg.cfg_dbms_scelta = ""
if isnull(kst_tab_plav_conn_cfg.cfg_dbparm ) then kst_tab_plav_conn_cfg.cfg_dbparm = ""
if isnull(kst_tab_plav_conn_cfg.cfg_pwd ) then kst_tab_plav_conn_cfg.cfg_pwd = ""
if isnull(kst_tab_plav_conn_cfg.cfg_servername ) then kst_tab_plav_conn_cfg.cfg_servername = ""
if isnull(kst_tab_plav_conn_cfg.cfg_autocommit ) then kst_tab_plav_conn_cfg.cfg_autocommit = ""
if isnull(kst_tab_plav_conn_cfg.cfg_dbms_alt ) then kst_tab_plav_conn_cfg.cfg_dbms_alt = ""
if isnull(kst_tab_plav_conn_cfg.cfg_dbms_scelta ) then kst_tab_plav_conn_cfg.cfg_dbms_scelta = "1"
if isnull(kst_tab_plav_conn_cfg.cfg_dbparm_alt ) then kst_tab_plav_conn_cfg.cfg_dbparm_alt = ""
if isnull(kst_tab_plav_conn_cfg.cfg_pwd_alt ) then kst_tab_plav_conn_cfg.cfg_pwd_alt = ""
if isnull(kst_tab_plav_conn_cfg.cfg_servername_alt ) then kst_tab_plav_conn_cfg.cfg_servername_alt = ""

if isnull(kst_tab_plav_conn_cfg.x_datins) then kst_tab_plav_conn_cfg.x_datins = datetime(date(0))
if isnull(kst_tab_plav_conn_cfg.x_utente) then kst_tab_plav_conn_cfg.x_utente = " "

end subroutine

private function boolean set_blocca_conn (st_tab_plav_conn_cfg kst_tab_plav_conn_cfg) throws uo_exception;/*
 Imposta sul CFG il Blocco/Sblocco della Connessione
 
 Input: st_tab_plav_conn_cfg.codice (se ZERO imposta 1),  blocca_importa (impostato a SI/NO) 
 Ritorna:       ST_ESITO 
*/
boolean k_return=false


	kguo_exception.inizializza(this.classname())

	if kst_tab_plav_conn_cfg.codice > 0 then
	else
		kst_tab_plav_conn_cfg.codice = 1
	end if

	kst_tab_plav_conn_cfg.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_plav_conn_cfg.x_utente = kGuf_data_base.prendi_x_utente()
	
	
	update plav_conn_cfg
			set  blocca_conn = :kst_tab_plav_conn_cfg.blocca_conn
					,x_datins = :kst_tab_plav_conn_cfg.x_datins
					,x_utente = :kst_tab_plav_conn_cfg.x_utente
			WHERE codice = :kst_tab_plav_conn_cfg.codice
			using kguo_sqlca_db_magazzino ;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
				"Errore durante Impostazione Blocco Connessione in Proprietà al DB di Interfaccia Pilota " &
				+ kkg.acapo + "codice=" + string(kst_tab_plav_conn_cfg.codice, "####0") &
				+ kkg.acapo + "Errore-tab.'plav_conn_cfg':"	+ trim(sqlca.SQLErrText) &
				)	
		throw kguo_exception
	end if
	
//---- COMMIT....	
	if kst_tab_plav_conn_cfg.st_tab_g_0.esegui_commit = "N" then
	else
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	k_return=true

return k_return

end function

public function boolean get_plav_conn_cfg (ref st_tab_plav_conn_cfg ast_tab_plav_conn_cfg) throws uo_exception;//--
//---  Legge la tabella di configurazione per connessione al DB
//---
//---  input: ast_tab_plav_conn_cfg.codice  (il default è 1)
//---  otput: ast_tab_plav_conn_cfg 
//---  se ERRORE lancia un Exception
//---

boolean k_return=false
st_esito kst_esito 


try
	
	kst_esito = kguo_exception.inizializza(this.classname())

	if ast_tab_plav_conn_cfg.codice = 0 or isnull(ast_tab_plav_conn_cfg.codice) then ast_tab_plav_conn_cfg.codice = 1
 
  SELECT plav_conn_cfg.codice,   
         plav_conn_cfg.blocca_conn,   
         plav_conn_cfg.schema_nome,   
         plav_conn_cfg.cfg_dbms_scelta,   
         plav_conn_cfg.cfg_dbms,   
         plav_conn_cfg.cfg_autocommit,   
         plav_conn_cfg.cfg_dbparm,   
         plav_conn_cfg.cfg_dbms_alt,   
         plav_conn_cfg.cfg_autocommit_alt,   
         plav_conn_cfg.cfg_dbparm_alt,  
		plav_conn_cfg.cfg_servername,
		plav_conn_cfg.cfg_utente,
		plav_conn_cfg.cfg_pwd,
		plav_conn_cfg.cfg_servername_alt,
		plav_conn_cfg.cfg_utente_alt,
		plav_conn_cfg.cfg_pwd_alt
    INTO :ast_tab_plav_conn_cfg.codice,   
         :ast_tab_plav_conn_cfg.blocca_conn,   
         :ast_tab_plav_conn_cfg.schema_nome,   
         :ast_tab_plav_conn_cfg.cfg_dbms_scelta,   
         :ast_tab_plav_conn_cfg.cfg_dbms,   
         :ast_tab_plav_conn_cfg.cfg_autocommit,   
         :ast_tab_plav_conn_cfg.cfg_dbparm,   
         :ast_tab_plav_conn_cfg.cfg_dbms_alt,   
         :ast_tab_plav_conn_cfg.cfg_autocommit_alt,   
         :ast_tab_plav_conn_cfg.cfg_dbparm_alt,  
		:ast_tab_plav_conn_cfg.cfg_servername,
		:ast_tab_plav_conn_cfg.cfg_utente,
		:ast_tab_plav_conn_cfg.cfg_pwd,
		:ast_tab_plav_conn_cfg.cfg_servername_alt,
		:ast_tab_plav_conn_cfg.cfg_utente_alt,
		:ast_tab_plav_conn_cfg.cfg_pwd_alt
    FROM plav_conn_cfg  
   WHERE plav_conn_cfg.codice = :ast_tab_plav_conn_cfg.codice   
		using kguo_sqlca_db_magazzino ;

	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		
		k_return=true
		
		ast_tab_plav_conn_cfg.blocca_conn = trim(ast_tab_plav_conn_cfg.blocca_conn)
		if ast_tab_plav_conn_cfg.blocca_conn = "" then ast_tab_plav_conn_cfg.blocca_conn = ""

	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Lettura Proprietà Connessione di Interfaccia Pilota " + string(ast_tab_plav_conn_cfg.codice) + kkg.acapo &
										 + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return

end function

public function boolean if_conn_bloccata (st_tab_plav_conn_cfg ast_tab_plav_conn_cfg) throws uo_exception;/*
 Imposta sul CFG il Blocco/Sblocco della Connessione
 
 Input: st_tab_plav_conn_cfg.codice (se ZERO imposta 1)
 Ritorna:       ST_ESITO 
*/
boolean k_return
st_esito kst_esito


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
	if ast_tab_plav_conn_cfg.codice > 0 then
	else
		ast_tab_plav_conn_cfg.codice = 1
	end if

	select blocca_conn
	   into :ast_tab_plav_conn_cfg.blocca_conn
		from plav_conn_cfg
			WHERE codice = :ast_tab_plav_conn_cfg.codice
			using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in verifica se Connessione Bloccata in Proprietà DB di Interfaccia Pilota, codice=" + string(ast_tab_plav_conn_cfg.codice))
		throw kguo_exception		
	end if
	
	if ast_tab_plav_conn_cfg.blocca_conn = ki_blocca_conn_no then
		k_return = false
	else
		k_return = true
	end if

catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try	

return k_return

end function

on kuf_plav_conn_cfg.create
call super::create
end on

on kuf_plav_conn_cfg.destroy
call super::destroy
end on

