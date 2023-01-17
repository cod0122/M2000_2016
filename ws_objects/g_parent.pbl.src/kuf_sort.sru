$PBExportHeader$kuf_sort.sru
forward
global type kuf_sort from kuf_parent0
end type
end forward

global type kuf_sort from kuf_parent0
end type
global kuf_sort kuf_sort

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public subroutine u_open_window (ref datawindow adw_1)
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return true

end function

public subroutine u_open_window (ref datawindow adw_1);//
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


	K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	K_st_open_w.id_programma = this.get_id_programma(K_st_open_w.flag_modalita)
	K_st_open_w.key12_any = adw_1
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window
								

end subroutine

on kuf_sort.create
call super::create
end on

on kuf_sort.destroy
call super::destroy
end on

