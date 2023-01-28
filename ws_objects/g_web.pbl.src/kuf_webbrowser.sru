$PBExportHeader$kuf_webbrowser.sru
forward
global type kuf_webbrowser from kuf_parent
end type
end forward

global type kuf_webbrowser from kuf_parent
end type
global kuf_webbrowser kuf_webbrowser

forward prototypes
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
end prototypes

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;//
string k_x, k_titolo
int k_pos
kuf_elenco kuf1_elenco

	
	k_x = trim(adw_link.getitemstring(adw_link.getrow(),a_campo_link))
	if k_x > " " then
		
		kuf1_elenco = create kuf_elenco 
		if len(k_x) > 20 then
			k_pos = pos(k_x, "//")
			if k_pos > 0 then
				k_titolo = mid(k_x, k_pos + 2, 16) + "..."
			else
				k_titolo = k_x
			end if
		else
			k_titolo = k_x
		end if
		kuf1_elenco.u_open_zoom(k_titolo, "", k_x) //CAMPO DI LINK + URL
		destroy kuf1_elenco
		
		return true
		
	else
		
		return false
		
	end if
	


end function

on kuf_webbrowser.create
call super::create
end on

on kuf_webbrowser.destroy
call super::destroy
end on

