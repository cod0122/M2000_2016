$PBExportHeader$kuo_sqlca_db_pilota_g3.sru
forward
global type kuo_sqlca_db_pilota_g3 from kuo_sqlca_db_0
end type
end forward

global type kuo_sqlca_db_pilota_g3 from kuo_sqlca_db_0
end type
global kuo_sqlca_db_pilota_g3 kuo_sqlca_db_pilota_g3

on kuo_sqlca_db_pilota_g3.create
call super::create
end on

on kuo_sqlca_db_pilota_g3.destroy
call super::destroy
end on

event constructor;call super::constructor;//
	ki_db_descrizione = "DB dati PILOTA Impianto G3"
	ki_title_id = "db_pilota"
end event

