$PBExportHeader$kuf_email_invio_pm.sru
forward
global type kuf_email_invio_pm from kuf_email_invio
end type
end forward

global type kuf_email_invio_pm from kuf_email_invio
end type
global kuf_email_invio_pm kuf_email_invio_pm

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//

	if trim(ast_open_w.flag_modalita) > " " then
	else
		ast_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	end if
	ast_open_w.id_programma = super::get_id_programma(ast_open_w.flag_modalita) // dovrebbe sempre fare così!


	return super::if_sicurezza(ast_open_w)
end function

on kuf_email_invio_pm.create
call super::create
end on

on kuf_email_invio_pm.destroy
call super::destroy
end on

