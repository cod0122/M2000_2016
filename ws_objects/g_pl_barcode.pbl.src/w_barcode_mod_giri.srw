$PBExportHeader$w_barcode_mod_giri.srw
forward
global type w_barcode_mod_giri from w_super
end type
type dw_modifica from uo_dw_modifica_giri_barcode within w_barcode_mod_giri
end type
end forward

global type w_barcode_mod_giri from w_super
boolean visible = true
integer x = 30002
integer y = 30000
integer width = 3026
integer height = 1648
string title = "Visualizza/Modifica Cicli di Lavorazione del Barcode/Riferimento"
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 32567536
string icon = "Asterisk!"
integer animationtime = 50
dw_modifica dw_modifica
end type
global w_barcode_mod_giri w_barcode_mod_giri

type variables
//
private w_super kiw_this
private kuf_barcode kiuf_barcode
private graphicobject ki_obj
private boolean ki_permetti_chiusura=false
//private st_alert kist_alert 

private int ki_open_timer=0

private int li_ScreenHt = 0, li_ScreenWid = 0

private st_barcode_mod_giri kist_barcode_mod_giri
private kuf_barcode_mod_giri kiuf_barcode_mod_giri
end variables

forward prototypes
public subroutine set_posizione ()
public subroutine u_modifica_giri ()
protected subroutine u_resize_1 ()
end prototypes

public subroutine set_posizione ();//
//if not this.visible then

	this.width = 1300
	this.height = 190

	environment le_env
	
	// Get screen size from environment
	GetEnvironment( le_env )
	
	li_ScreenHt = PixelsToUnits( le_env.ScreenHeight, YPixelsToUnits! )
	li_ScreenWid = PixelsToUnits( le_env.ScreenWidth, XPixelsToUnits! )
	
	// open in lower right corner
	this.Move( ( li_ScreenWid - this.Width * 1.3 ), ( li_ScreenHt/2 - this.Height*2 ))
	
//end if

end subroutine

public subroutine u_modifica_giri ();//
	dw_modifica.modifica_giri(&
				kist_barcode_mod_giri.ast_tab_barcode &
				,kist_barcode_mod_giri.a_modalita_modifica_file &
				,kist_barcode_mod_giri.a_modif_tutto_riferimento &
				,kist_barcode_mod_giri.adw_x_modifica_giri &
				,kist_barcode_mod_giri.adw_barcode_da_non_modificare )
		

end subroutine

protected subroutine u_resize_1 ();//
dw_modifica.x = 1
dw_modifica.y = 1
dw_modifica.width = this.width //- 90
dw_modifica.height = this.height //- 90

end subroutine

event u_open;call super::u_open;//
environment kenv
integer k_rtn
kuf_utility kuf1_utility


try  

	kiuf_barcode = create kuf_barcode
	kiuf_barcode_mod_giri = ki_st_open_w.key12_any
	kist_barcode_mod_giri = kiuf_barcode_mod_giri.kist_barcode_mod_giri

	if kiuf_barcode_mod_giri.ki_modifica_cicli_enabled = kiuf_barcode_mod_giri.ki_modifica_cicli_enabled_visualizzazione then
		this.title = "Visualizza Cicli di Lavorazione del Barcode/Riferimento"
		dw_modifica.ki_flag_modalita = kkg_flag_modalita.visualizzazione 
		kuf1_utility = create kuf_utility
		kuf1_utility.u_proteggi_sproteggi_dw(dw_modifica)
		dw_modifica.modify("cb_aggiorna.visible='0' cb_ripristina.visible='0'")
	else
		this.title = "Modifica Cicli di Lavorazione del Barcode/Riferimento"
	end if
		
	u_modifica_giri( )
	
	dw_modifica.modify( "cb_dettaglio.visible = '0'")
	dw_modifica.event u_resize_max( )
	
	k_rtn = GetEnvironment(kenv)
	if k_rtn = 1 then
//		this.x = (PixelsToUnits(kenv.ScreenWidth, XPixelsToUnits!) - this.width) / 2 
//		this.y = (PixelsToUnits(kenv.ScreenHeight, YPixelsToUnits!) - this.height) / 2 
      this.x = w_main.x + (w_main.width - this.width) / 2
      this.y = w_main.y + (w_main.Height - this.height) / 2
	else
		this.move( 1, 1)
	end if
	dw_modifica.visible = true
	this.bringtotop = true
	
catch(uo_exception kuo_exception )
	post event close( )
	
finally
	if isvalid(kuf1_utility) then destroy kuf1_utility

end try

end event

on w_barcode_mod_giri.create
int iCurrent
call super::create
this.dw_modifica=create dw_modifica
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_modifica
end on

on w_barcode_mod_giri.destroy
call super::destroy
destroy(this.dw_modifica)
end on

event close;call super::close;//
if isvalid(kiuf_barcode) then destroy kiuf_barcode
end event

type dw_modifica from uo_dw_modifica_giri_barcode within w_barcode_mod_giri
integer width = 3017
integer height = 1564
integer taborder = 10
boolean enabled = true
boolean titlebar = false
boolean controlmenu = false
boolean resizable = false
end type

event u_exit;//
//	this.visible = false
	post close(parent)

end event

event ue_aggiornamenti_ok;call super::ue_aggiornamenti_ok;//
if this.rowcount( ) > 0 then
	if this.getitemstring( 1, "scelta_fila_1") = '1' then
		kiuf_barcode_mod_giri.kist_barcode_mod_giri.ast_tab_barcode.fila_1 = this.getitemnumber( 1, "barcode_fila_1")
		kiuf_barcode_mod_giri.kist_barcode_mod_giri.ast_tab_barcode.fila_1p = this.getitemnumber( 1, "barcode_fila_1p")
	else
		kiuf_barcode_mod_giri.kist_barcode_mod_giri.ast_tab_barcode.fila_1 = 0
		kiuf_barcode_mod_giri.kist_barcode_mod_giri.ast_tab_barcode.fila_1p = 0
	end if
	if this.getitemstring( 1, "scelta_fila_2") = '1' then
		kiuf_barcode_mod_giri.kist_barcode_mod_giri.ast_tab_barcode.fila_2 = this.getitemnumber( 1, "barcode_fila_2")
		kiuf_barcode_mod_giri.kist_barcode_mod_giri.ast_tab_barcode.fila_2p = this.getitemnumber( 1, "barcode_fila_2p")
	else
		kiuf_barcode_mod_giri.kist_barcode_mod_giri.ast_tab_barcode.fila_2 = 0
		kiuf_barcode_mod_giri.kist_barcode_mod_giri.ast_tab_barcode.fila_2p = 0
	end if
end if

event u_exit( )
end event

