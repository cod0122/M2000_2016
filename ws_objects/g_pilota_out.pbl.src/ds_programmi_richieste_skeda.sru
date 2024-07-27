$PBExportHeader$ds_programmi_richieste_skeda.sru
forward
global type ds_programmi_richieste_skeda from ds_plav_parent
end type
end forward

global type ds_programmi_richieste_skeda from ds_plav_parent
string dataobject = "d_programmi_richieste_skeda"
end type
global ds_programmi_richieste_skeda ds_programmi_richieste_skeda

on ds_programmi_richieste_skeda.create
call super::create
end on

on ds_programmi_richieste_skeda.destroy
call super::destroy
end on

