$PBExportHeader$kuf_menu_tree.sru
forward
global type kuf_menu_tree from kuf_parent
end type
end forward

global type kuf_menu_tree from kuf_parent
end type
global kuf_menu_tree kuf_menu_tree

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public subroutine _readme ()
public function st_esito u_open ()
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return true

end function

public subroutine _readme ();//
//--- sostituisce il menu toolbar
//

end subroutine

public function st_esito u_open ();//
st_esito kst_esito

if isvalid(kguo_g.kgw_toolbar_programmi) then
	if isvalid(m_main) then
		kguo_g.kgw_toolbar_programmi.u_build_menu(m_main)
	end if
	kguo_g.kgw_toolbar_programmi.setfocus()
	
	kst_esito.esito = kkg_esito.ok
	return kst_esito
	
end if

return super::u_open()

end function

on kuf_menu_tree.create
call super::create
end on

on kuf_menu_tree.destroy
call super::destroy
end on

