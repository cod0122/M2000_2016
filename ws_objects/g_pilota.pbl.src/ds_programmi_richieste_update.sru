$PBExportHeader$ds_programmi_richieste_update.sru
forward
global type ds_programmi_richieste_update from ds_plav_parent
end type
end forward

global type ds_programmi_richieste_update from ds_plav_parent
string dataobject = "ds_programmi_richieste_update"
end type
global ds_programmi_richieste_update ds_programmi_richieste_update

on ds_programmi_richieste_update.create
call super::create
end on

on ds_programmi_richieste_update.destroy
call super::destroy
end on

