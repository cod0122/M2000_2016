$PBExportHeader$ds_programmi_richieste_nuove_ko.sru
forward
global type ds_programmi_richieste_nuove_ko from ds_plav_parent
end type
end forward

global type ds_programmi_richieste_nuove_ko from ds_plav_parent
string dataobject = "ds_programmi_richieste_nuove_ko"
end type
global ds_programmi_richieste_nuove_ko ds_programmi_richieste_nuove_ko

on ds_programmi_richieste_nuove_ko.create
call super::create
end on

on ds_programmi_richieste_nuove_ko.destroy
call super::destroy
end on

