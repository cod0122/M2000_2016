$PBExportHeader$ds_plav_parent.sru
forward
global type ds_plav_parent from uo_ds_std_1
end type
end forward

global type ds_plav_parent from uo_ds_std_1
string dataobject = "d_nulla"
end type
global ds_plav_parent ds_plav_parent

forward prototypes
public subroutine u_settransobject () throws uo_exception
end prototypes

public subroutine u_settransobject () throws uo_exception;/*
 Fa Connessione se richiesta e settransobject 
*/
int k_rc

try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

	if kguo_sqlca_db_plav.db_connetti( ) then
		k_rc = this.settransobject(kguo_sqlca_db_plav)
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)
end try
end subroutine

on ds_plav_parent.create
call super::create
end on

on ds_plav_parent.destroy
call super::destroy
end on

event constructor;call super::constructor;//

try
	u_settransobject( )
catch (uo_exception kuo_exception)
	throw kuo_exception
end try
end event

