$PBExportHeader$ds_barcode_print_label.sru
forward
global type ds_barcode_print_label from datastore
end type
end forward

global type ds_barcode_print_label from datastore
end type
global ds_barcode_print_label ds_barcode_print_label

on ds_barcode_print_label.create
call super::create
TriggerEvent( this, "constructor" )
end on

on ds_barcode_print_label.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

