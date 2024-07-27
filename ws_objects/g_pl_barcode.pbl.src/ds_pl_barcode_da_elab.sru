$PBExportHeader$ds_pl_barcode_da_elab.sru
forward
global type ds_pl_barcode_da_elab from ds_db_magazzino_parent
end type
end forward

global type ds_pl_barcode_da_elab from ds_db_magazzino_parent
string dataobject = "ds_pl_barcode_da_elab"
end type
global ds_pl_barcode_da_elab ds_pl_barcode_da_elab

on ds_pl_barcode_da_elab.create
call super::create
end on

on ds_pl_barcode_da_elab.destroy
call super::destroy
end on

