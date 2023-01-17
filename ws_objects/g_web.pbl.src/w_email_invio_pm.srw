$PBExportHeader$w_email_invio_pm.srw
forward
global type w_email_invio_pm from w_email_invio
end type
end forward

global type w_email_invio_pm from w_email_invio
end type
global w_email_invio_pm w_email_invio_pm

on w_email_invio_pm.create
call super::create
end on

on w_email_invio_pm.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_print_0 from w_email_invio`dw_print_0 within w_email_invio_pm
end type

type st_ritorna from w_email_invio`st_ritorna within w_email_invio_pm
end type

type st_ordina_lista from w_email_invio`st_ordina_lista within w_email_invio_pm
end type

type st_aggiorna_lista from w_email_invio`st_aggiorna_lista within w_email_invio_pm
end type

type cb_ritorna from w_email_invio`cb_ritorna within w_email_invio_pm
end type

type st_stampa from w_email_invio`st_stampa within w_email_invio_pm
end type

type cb_visualizza from w_email_invio`cb_visualizza within w_email_invio_pm
end type

type cb_modifica from w_email_invio`cb_modifica within w_email_invio_pm
end type

type cb_aggiorna from w_email_invio`cb_aggiorna within w_email_invio_pm
end type

type cb_cancella from w_email_invio`cb_cancella within w_email_invio_pm
end type

type cb_inserisci from w_email_invio`cb_inserisci within w_email_invio_pm
end type

type dw_dett_0 from w_email_invio`dw_dett_0 within w_email_invio_pm
end type

type st_orizzontal from w_email_invio`st_orizzontal within w_email_invio_pm
end type

type dw_lista_0 from w_email_invio`dw_lista_0 within w_email_invio_pm
string dataobject = "d_email_invio_l_pm"
end type

type dw_guida from w_email_invio`dw_guida within w_email_invio_pm
end type

type st_duplica from w_email_invio`st_duplica within w_email_invio_pm
end type

type dw_segnaposto_l from w_email_invio`dw_segnaposto_l within w_email_invio_pm
end type

