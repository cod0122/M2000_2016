$PBExportHeader$w_about_start.srw
forward
global type w_about_start from w_about
end type
end forward

global type w_about_start from w_about
boolean visible = true
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
end type
global w_about_start w_about_start

on w_about_start.create
call super::create
end on

on w_about_start.destroy
call super::destroy
end on

type st_informa from w_about`st_informa within w_about_start
end type

type cb_start from w_about`cb_start within w_about_start
end type

type dw_about from w_about`dw_about within w_about_start
end type

