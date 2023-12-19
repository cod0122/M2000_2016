$PBExportHeader$ds_pl_barcode.sru
forward
global type ds_pl_barcode from uo_ds_std_1
end type
end forward

global type ds_pl_barcode from uo_ds_std_1
string dataobject = "ds_pl_barcode"
event u_settransobject ( )
end type
global ds_pl_barcode ds_pl_barcode

event u_settransobject();//
int k_rc

k_rc = this.settransobject(kguo_sqlca_db_magazzino)

end event

on ds_pl_barcode.create
call super::create
end on

on ds_pl_barcode.destroy
call super::destroy
end on

event constructor;call super::constructor;//
event u_settransobject( )

end event

