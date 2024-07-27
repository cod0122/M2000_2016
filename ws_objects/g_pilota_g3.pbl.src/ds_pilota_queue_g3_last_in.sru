$PBExportHeader$ds_pilota_queue_g3_last_in.sru
forward
global type ds_pilota_queue_g3_last_in from ds_pilota_g3_parent
end type
end forward

global type ds_pilota_queue_g3_last_in from ds_pilota_g3_parent
string dataobject = "d_pilota_queue_g3_last_in"
end type
global ds_pilota_queue_g3_last_in ds_pilota_queue_g3_last_in

forward prototypes
public function integer u_get_npass (long a_row)
public function integer u_get_ciclo (long a_row)
end prototypes

public function integer u_get_npass (long a_row);/*
 Trasforma il ID_MODO alpha in N.PASS numerico
*/
string k_id_modo

if a_row > this.rowcount( ) then return -1

k_id_modo = trim(this.getitemstring(a_row, "id_modo"))

if isnumber(k_id_modo) then
	return integer(k_id_modo)
else
	return 0
end if

end function

public function integer u_get_ciclo (long a_row);/*
 Trasforma il CICLO alpha in CICLO numerico
*/
string k_ciclo


if a_row > this.rowcount( ) then return -1

k_ciclo = trim(this.getitemstring(a_row, "ciclo"))

if isnumber(k_ciclo) then
	return integer(k_ciclo)
else
	return 0
end if
	
end function

on ds_pilota_queue_g3_last_in.create
call super::create
end on

on ds_pilota_queue_g3_last_in.destroy
call super::destroy
end on

