$PBExportHeader$kuf_meca_parziali.sru
forward
global type kuf_meca_parziali from kuf_parent
end type
end forward

global type kuf_meca_parziali from kuf_parent
end type
global kuf_meca_parziali kuf_meca_parziali

type variables
//
kuf_armo kiuf_armo

end variables

forward prototypes
public subroutine _readme ()
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
end prototypes

public subroutine _readme ();/*
  Tabellina con indicazioni per la gestione dei Lotti Parziali 
*/
end subroutine

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return kiuf_armo.if_sicurezza(ast_open_w)



end function

event constructor;call super::constructor;//
kiuf_armo = create kuf_armo

end event

event destructor;call super::destructor;//
if isvalid(kiuf_armo) then destroy kiuf_armo

end event

on kuf_meca_parziali.create
call super::create
end on

on kuf_meca_parziali.destroy
call super::destroy
end on

