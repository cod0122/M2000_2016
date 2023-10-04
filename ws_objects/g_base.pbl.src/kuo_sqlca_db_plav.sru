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

on kuo_sqlca_db_plav.create
call super::create
end on

on kuo_sqlca_db_plav.destroy
call super::destroy
end on

event constructor;call super::constructor;//
	ki_db_descrizione = "DB di Interfaccia Programmazione Pilota Impianto"
	ki_title_id = "db_plav"
end event

