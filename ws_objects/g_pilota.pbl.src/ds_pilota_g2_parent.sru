﻿$PBExportHeader$ds_pilota_g2_parent.sru
forward
global type ds_pilota_g2_parent from uo_ds_std_1
end type
end forward

global type ds_pilota_g2_parent from uo_ds_std_1
string dataobject = "d_nulla"
end type
global ds_pilota_g2_parent ds_pilota_g2_parent

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

	if kguo_sqlca_db_pilota.db_connetti( ) then
		k_rc = this.settransobject(kguo_sqlca_db_pilota)
		if k_rc < 0 then
			kguo_exception.kist_esito = this.kist_esito
			kguo_exception.kist_esito.sqlerrtext = "Errore SETTRANSOBJECT DB '" + kguo_sqlca_db_pilota.ki_db_descrizione + "' (u_settransobject) " &
						+ kkg.acapo + this.kist_esito.sqlerrtext
			kGuo_exception.scrivi_log( )
		end if
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)
end try
end subroutine

on ds_pilota_g2_parent.create
call super::create
end on

on ds_pilota_g2_parent.destroy
call super::destroy
end on

event constructor;call super::constructor;//
try
	u_settransobject( )
catch (uo_exception kuo_exception)
	throw kuo_exception
end try
end event

event destructor;call super::destructor;//
kguo_sqlca_db_pilota.db_disconnetti( )   // DISCONNESSIONE


end event

