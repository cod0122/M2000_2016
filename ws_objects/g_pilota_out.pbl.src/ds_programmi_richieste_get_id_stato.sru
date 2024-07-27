$PBExportHeader$ds_programmi_richieste_get_id_stato.sru
forward
global type ds_programmi_richieste_get_id_stato from ds_plav_parent
end type
end forward

global type ds_programmi_richieste_get_id_stato from ds_plav_parent
string dataobject = "ds_programmi_richieste_get_id_stato"
end type
global ds_programmi_richieste_get_id_stato ds_programmi_richieste_get_id_stato

on ds_programmi_richieste_get_id_stato.create
call super::create
end on

on ds_programmi_richieste_get_id_stato.destroy
call super::destroy
end on

