$PBExportHeader$ds_programmi_work_orders_update.sru
forward
global type ds_programmi_work_orders_update from ds_plav_parent
end type
end forward

global type ds_programmi_work_orders_update from ds_plav_parent
string dataobject = "ds_programmi_work_orders"
end type
global ds_programmi_work_orders_update ds_programmi_work_orders_update

on ds_programmi_work_orders_update.create
call super::create
end on

on ds_programmi_work_orders_update.destroy
call super::destroy
end on

