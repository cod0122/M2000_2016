$PBExportHeader$n_cst_systemtray_callback.sru
forward
global type n_cst_systemtray_callback from nonvisualobject
end type
end forward

global type n_cst_systemtray_callback from nonvisualobject
end type
global n_cst_systemtray_callback n_cst_systemtray_callback

type variables
//w_main_0 iw_win
kuf_user_notification kiuf_user_notification
end variables

forward prototypes
public subroutine of_delete_from_systemtray ()
//public subroutine of_register (w_main_0 aw_win)
//public subroutine of_register (kuf_user_notification kuf1_user_notification)
end prototypes

public subroutine of_delete_from_systemtray (); //Si hay en pantalla una Noficación la elimino.
if isvalid(kguf_user_notification) then
	IF kguf_user_notification.in_systemtray.of_get_systemtray_active() = TRUE THEN
		kguf_user_notification.of_delete_from_systemtray ()	
	END IF
end if
end subroutine

on n_cst_systemtray_callback.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_systemtray_callback.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

