$PBExportHeader$ds_pilota_pallet_workqueue_temp_g3.sru
forward
global type ds_pilota_pallet_workqueue_temp_g3 from uo_ds_std_1
end type
end forward

global type ds_pilota_pallet_workqueue_temp_g3 from uo_ds_std_1
string dataobject = "ds_pilota_pallet_workqueue_temp_g3"
end type
global ds_pilota_pallet_workqueue_temp_g3 ds_pilota_pallet_workqueue_temp_g3

forward prototypes
public subroutine u_settransobject () throws uo_exception
end prototypes

public subroutine u_settransobject () throws uo_exception;/*
 Fa Connessione se richiesta e settransobject 
*/
int k_rc
uo_ds_std_1 kds_this

try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

	kds_this = this
	kguf_data_base.u_set_ds_change_name_tab(kds_this, "vx_MAST_pilota_pallet_workqueue_g3")

	//if kguo_sqlca_db_plav.db_connetti( ) then
		k_rc = this.settransobject(kguo_sqlca_db_magazzino)
	//end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)
end try
end subroutine

on ds_pilota_pallet_workqueue_temp_g3.create
call super::create
end on

on ds_pilota_pallet_workqueue_temp_g3.destroy
call super::destroy
end on

event constructor;call super::constructor;//

try
	u_settransobject( )
catch (uo_exception kuo_exception)
	throw kuo_exception
end try
end event

