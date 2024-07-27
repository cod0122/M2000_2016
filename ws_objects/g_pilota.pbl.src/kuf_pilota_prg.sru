$PBExportHeader$kuf_pilota_prg.sru
$PBExportComments$report x movimenti registro articolo 50
forward
global type kuf_pilota_prg from kuf_parent
end type
end forward

global type kuf_pilota_prg from kuf_parent
end type
global kuf_pilota_prg kuf_pilota_prg

forward prototypes
public subroutine _readme ()
end prototypes

public subroutine _readme ();/*
  Modifica programmazione Pilota Impianto Gamma 2
*/
end subroutine

on kuf_pilota_prg.create
call super::create
end on

on kuf_pilota_prg.destroy
call super::destroy
end on

