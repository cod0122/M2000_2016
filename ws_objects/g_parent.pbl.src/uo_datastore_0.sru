$PBExportHeader$uo_datastore_0.sru
forward
global type uo_datastore_0 from datastore
end type
end forward

global type uo_datastore_0 from datastore
string dataobject = "d_nulla"
end type
global uo_datastore_0 uo_datastore_0

type variables
//
public:
st_esito kist_esito

end variables

on uo_datastore_0.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_datastore_0.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event dberror;//
uo_exception kuo1_exception


kuo1_exception = create uo_exception
kist_esito = kuo1_exception.inizializza(classname( ))

kist_esito.sqlcode = sqldbcode
kist_esito.sqldbcode = sqldbcode
kist_esito.sqlsyntax = trim(sqlsyntax)
kist_esito.sqlerrtext = trim(sqlerrtext)
kist_esito.esito = kkg_esito.db_ko
kist_esito.descrizione = "Errore nell'oggetto '" + this.classname( ) + "' riga " + string(row)
//if isvalid(parent) then 
//	kist_esito.nome_oggetto = parent.classname()
//else
	kist_esito.nome_oggetto = classname()
//end if
kist_esito.nome_oggetto += " (dataobject: " + this.dataobject + ")"

kuo1_exception.set_esito(kist_esito)
//kuo1_exception.scrivi_log( )
kuo1_exception.u_errori_gestione(kist_esito)

if isvalid(kguo_exception) then kguo_exception.set_esito(kist_esito)


RETURN 1 // Do not display system error message

end event

event constructor;//
kist_esito.sqlsyntax = "" 
kist_esito.sqlerrtext = ""
kist_esito.sqldbcode = 0
kist_esito.sqlcode = 0
kist_esito.nome_oggetto = (this.classname( ))
end event

event error;//
uo_exception kuo1_exception


kuo1_exception = create uo_exception
kist_esito = kuo1_exception.inizializza(this.classname())

if isvalid(parent) then 
	kist_esito.nome_oggetto = parent.classname()
else
	kist_esito.nome_oggetto = classname()
end if
if errorobject > " " then 
	kist_esito.nome_oggetto += " Errorobject: " + trim(errorobject)
end if
kist_esito.nome_oggetto += " (dataobject: " + this.dataobject + ")"

kist_esito.sqlsyntax = trim(errortext)
kist_esito.sqlerrtext = trim(errortext) + " " + errorscript + " Line " + string(errorline)
kist_esito.sqldbcode = errornumber
kist_esito.sqlcode = -1

kist_esito.esito = kkg_esito.ko

kuo1_exception.set_esito(kist_esito)
kuo1_exception.u_errori_gestione(kist_esito)

if isvalid(kguo_exception) then kguo_exception.set_esito(kist_esito)
end event

