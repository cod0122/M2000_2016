$PBExportHeader$kuf_user_notification.sru
forward
global type kuf_user_notification from nonvisualobject
end type
end forward

global type kuf_user_notification from nonvisualobject
end type
global kuf_user_notification kuf_user_notification

type prototypes
//
//Function long Shell_NotifyIconA (ulong dwMessage, ref st_user_notifyicondataa lpData) Library "shell32.dll"
//Function long Shell_NotifyIconW (ulong dwMessage, ref st_user_notifyicondataa lpData) Library "shell32.dll"
FUNCTION long ShowToastWrapper(string toast, long eventHandler, ref long error) LIBRARY "WinToast.dll"

end prototypes

type variables
//--- x TOAST NOTIFICATION
public:
n_cst_systemtray in_systemtray
n_cst_systemtray_callback in_callback

public:
window ki_window
int ki_timeduration = 5
icon ki_icon = information!


end variables

forward prototypes
public subroutine of_delete_from_systemtray ()
public subroutine send_notification (string as_title, string as_msg, icon a_icon, integer ai_messageboxtimeout, window a_window)
public subroutine send_notification (string as_title, string as_msg)
end prototypes

public subroutine of_delete_from_systemtray ();//
if isvalid(ki_window) and not isnull(ki_window) then
 	IF in_systemtray.of_get_systemtray_active() THEN
		in_systemtray.of_delete_from_systemtray (ki_window, FALSE ) // w_main_0, FALSE )
 	END IF
end if

end subroutine

public subroutine send_notification (string as_title, string as_msg, icon a_icon, integer ai_messageboxtimeout, window a_window);/*
	Invia Notifica Utente
*/

n_cst_systemtray_shared ln_shared1

SharedObjectRegister("n_cst_systemtray_shared","thread1")
SharedObjectGet("thread1", ln_shared1)

if isvalid(a_window) and not isnull(a_window) then

	 //Si hay en pantalla una Noficación la elimino.
	 IF in_systemtray.of_get_systemtray_active() THEN
		in_systemtray.of_delete_from_systemtray (a_window, FALSE )
	 END IF
	 
	in_systemtray.of_add_to_systemtray (a_window )															
	in_systemtray.of_set_notification_message (a_window, as_title, as_msg, a_icon)

end if

//Usamos un Objeto compartido para poder eliminar la notificación pasados unos segndos en un hilo distinto
ln_shared1.POST  of_delete_from_systemtray ( ai_MessageBoxTimeout, in_callback )	
			
SharedObjectUnRegister("thread1")

//return result

end subroutine

public subroutine send_notification (string as_title, string as_msg);/*
	Invia Notifica Utente
*/

send_notification(as_title ,as_msg ,ki_icon ,ki_timeduration , ki_window)


end subroutine

on kuf_user_notification.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_user_notification.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;
if isvalid(in_systemtray) then 

   of_delete_from_systemtray( )

	destroy in_systemtray										
 
	destroy in_callback
	
end if

end event

event constructor;
// Para el manejo de notificaciones
in_systemtray = CREATE n_cst_systemtray												
in_callback = Create n_cst_systemtray_callback
//in_callback.of_register(this) //w_main_0) 

end event

