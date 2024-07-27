$PBExportHeader$uo_ds_std_1.sru
forward
global type uo_ds_std_1 from datastore
end type
end forward

global type uo_ds_std_1 from datastore
end type
global uo_ds_std_1 uo_ds_std_1

type variables
//
st_esito kist_esito
end variables

forward prototypes
public function string u_get_evaluate (string a_field, string a_field_describe, long a_row)
end prototypes

public function string u_get_evaluate (string a_field, string a_field_describe, long a_row);/*
   torna il valore calcolato da EXPRESSION
	inp: 
	     field: nome campo
	     filed_describe: es. background.color
		  row: riga se però è una testata si può passare zero
*/
string ls_expression, ls_value, ls_eval
int k_pos


a_field = trim(a_field)

IF IsNumber(a_field) THEN   
	ls_expression = trim(this.describe("#" + a_field + "." + a_field_describe))
else
	ls_expression = trim(this.describe(a_field + "." + a_field_describe))
end if

IF ls_expression > " " THEN   
else
	return ""   // ESCE con nulla
end if

// Get the expression following the tab (~t) 
ls_expression = trim(Right(ls_expression, Len(ls_expression) - Pos(ls_expression, "~t")))

//--- se NON c'è una parentesi è poco probabile che sia una expression 
if Pos(ls_expression, "(") = 0 then return ""     // ESCE con nulla

//--- rimuove i doppi apici
k_pos = Pos(ls_expression, '~"', 1)
do while k_pos > 0 
	ls_expression = replace(ls_expression, k_pos, 1, "'")
	k_pos = Pos(ls_expression, '~"', k_pos)
loop
k_pos = Pos(ls_expression, "~~", 1)
do while k_pos > 0 
	ls_expression = replace(ls_expression, k_pos, 1, "")
	k_pos = Pos(ls_expression, "~~", k_pos)
loop

if left(ls_expression, 1) = "'" then
	ls_expression = trim(mid(ls_expression, 2))
end if
if mid(ls_expression, Len(ls_expression), 1) = "'" then
	ls_expression = left(ls_expression, Len(ls_expression) -1)
end if

IF ls_expression > " " THEN   
else
	return ""   // ESCE con nulla
end if

// Build string for Describe. Include a leading   
// quote to match the trailing quote that remains
ls_eval = "Evaluate(~"" + ls_expression + "~", " + String(a_row) + ")"   

ls_value = this.Describe(ls_eval)

//--- se errore Torna nulla
if ls_value = "!" then return ""
		
return trim(ls_value)

end function

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

on uo_ds_std_1.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ds_std_1.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event error;//
uo_exception kuo1_exception


kuo1_exception = create uo_exception
kist_esito = kuo1_exception.inizializza(this.classname())

if isvalid(this.getparent()) then
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

event constructor;//
kist_esito.sqlsyntax = "" 
kist_esito.sqlerrtext = ""
kist_esito.sqldbcode = 0
kist_esito.sqlcode = 0
kist_esito.nome_oggetto = (this.classname( ))
end event

