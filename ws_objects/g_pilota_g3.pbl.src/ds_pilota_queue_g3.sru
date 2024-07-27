$PBExportHeader$ds_pilota_queue_g3.sru
forward
global type ds_pilota_queue_g3 from ds_pilota_g3_parent
end type
end forward

global type ds_pilota_queue_g3 from ds_pilota_g3_parent
string dataobject = "d_pilota_queue_g3"
end type
global ds_pilota_queue_g3 ds_pilota_queue_g3

on ds_pilota_queue_g3.create
call super::create
end on

on ds_pilota_queue_g3.destroy
call super::destroy
end on

