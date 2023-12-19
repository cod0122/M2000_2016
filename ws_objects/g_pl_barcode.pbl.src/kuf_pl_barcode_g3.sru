$PBExportHeader$kuf_pl_barcode_g3.sru
forward
global type kuf_pl_barcode_g3 from kuf_parent
end type
end forward

global type kuf_pl_barcode_g3 from kuf_parent
end type
global kuf_pl_barcode_g3 kuf_pl_barcode_g3

type variables
//
kuf_pl_barcode kiuf_pl_barcode
end variables

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return kiuf_pl_barcode.if_sicurezza(ast_open_w)

end function

on kuf_pl_barcode_g3.create
call super::create
end on

on kuf_pl_barcode_g3.destroy
call super::destroy
end on

event constructor;call super::constructor;//
kiuf_pl_barcode = create kuf_pl_barcode
end event

event destructor;call super::destructor;//
if isvalid(kiuf_pl_barcode) then destroy kiuf_pl_barcode
end event

