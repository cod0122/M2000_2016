$PBExportHeader$kuf_contatti.sru
forward
global type kuf_contatti from kuf_parent
end type
end forward

global type kuf_contatti from kuf_parent
end type
global kuf_contatti kuf_contatti

type variables
//
kuf_clienti kiuf_clienti
end variables

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return kiuf_clienti.if_sicurezza(ast_open_w)

end function

event constructor;call super::constructor;//
kiuf_clienti = create kuf_clienti
end event

event destructor;call super::destructor;//
if isvalid(kiuf_clienti) then destroy kiuf_clienti

end event

on kuf_contatti.create
call super::create
end on

on kuf_contatti.destroy
call super::destroy
end on

