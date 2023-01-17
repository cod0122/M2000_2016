$PBExportHeader$w_test.srw
forward
global type w_test from w_g_tab0
end type
end forward

global type w_test from w_g_tab0
end type
global w_test w_test

forward prototypes
protected function string inizializza () throws uo_exception
end prototypes

protected function string inizializza () throws uo_exception;dw_dett_0.retrieve(234002)
return "0"
end function

on w_test.create
call super::create
end on

on w_test.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_g_tab0`st_ritorna within w_test
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_test
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_test
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_test
end type

type st_stampa from w_g_tab0`st_stampa within w_test
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_test
end type

type cb_modifica from w_g_tab0`cb_modifica within w_test
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_test
end type

type cb_cancella from w_g_tab0`cb_cancella within w_test
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_test
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_test
boolean visible = true
boolean enabled = true
string dataobject = "d_meca_ptmerce_labelaccept"
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_test
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_test
boolean enabled = false
end type

type dw_guida from w_g_tab0`dw_guida within w_test
end type

type st_duplica from w_g_tab0`st_duplica within w_test
end type

