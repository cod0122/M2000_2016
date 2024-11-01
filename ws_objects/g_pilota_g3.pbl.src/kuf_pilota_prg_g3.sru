$PBExportHeader$kuf_pilota_prg_g3.sru
$PBExportComments$report x movimenti registro articolo 50
forward
global type kuf_pilota_prg_g3 from kuf_parent
end type
end forward

global type kuf_pilota_prg_g3 from kuf_parent
end type
global kuf_pilota_prg_g3 kuf_pilota_prg_g3

forward prototypes
public subroutine _readme ()
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
end prototypes

public subroutine _readme ();/*
  Modifica programmazione Pilota Impianto Gamma 3
*/
end subroutine

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//	
boolean k_return
kuf_pilota_prg kuf1_pilota_prg


try
	kuf1_pilota_prg = create kuf_pilota_prg	
	
	k_return = kuf1_pilota_prg.if_sicurezza(ast_open_w)
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	throw kuo_exception
	
finally
	if isvalid(kuf1_pilota_prg) then destroy kuf1_pilota_prg

end try

return k_return

end function

on kuf_pilota_prg_g3.create
call super::create
end on

on kuf_pilota_prg_g3.destroy
call super::destroy
end on

