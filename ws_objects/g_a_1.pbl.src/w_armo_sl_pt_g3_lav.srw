$PBExportHeader$w_armo_sl_pt_g3_lav.srw
forward
global type w_armo_sl_pt_g3_lav from w_super
end type
type dw_modifica from uo_dw_armo_sl_pt_g3_lav_modifica within w_armo_sl_pt_g3_lav
end type
end forward

global type w_armo_sl_pt_g3_lav from w_super
boolean visible = true
integer x = 30002
integer y = 30000
integer width = 3131
integer height = 1684
string title = "Visualizza/Modifica Cicli di Lavorazione del Barcode/Riferimento"
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 32567536
string icon = "Asterisk!"
integer animationtime = 50
boolean ki_utente_abilitato = true
boolean ki_salva_controlli = false
boolean ki_windowpredef = false
boolean ki_personalizza_pos_controlli = false
boolean ki_controlli_ripristinati = false
boolean ki_risize_w = false
string ki_nome_save = " "
boolean ki_toolbar_window_presente = false
boolean ki_win_minimizzata = false
boolean ki_win_massimizzata = false
boolean ki_primo_giro_obj_visible = true
dw_modifica dw_modifica
end type
global w_armo_sl_pt_g3_lav w_armo_sl_pt_g3_lav

type variables
//
private w_super kiw_this
private kuf_armo_sl_pt_g3_lav kiuf_armo_sl_pt_g3_lav
private graphicobject ki_obj
private boolean ki_permetti_chiusura=false
//private st_alert kist_alert 

private int ki_open_timer=0

private int li_ScreenHt = 0, li_ScreenWid = 0

end variables

forward prototypes
public subroutine set_posizione ()
public subroutine u_retrieve ()
protected subroutine u_resize ()
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

public subroutine u_retrieve ();

try
	SetPointer(kkg.pointer_attesa)
	
	dw_modifica.kiuf_armo_sl_pt_g3_lav = kiuf_armo_sl_pt_g3_lav
	dw_modifica.event u_retrieve()
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	SetPointer(kkg.pointer_default)

end try

end subroutine

protected subroutine u_resize ();//
dw_modifica.x = 1
dw_modifica.y = 1
dw_modifica.width = long(dw_modifica.describe("b_linea_fine.x2")) + 150  //  this.width //- 90
dw_modifica.height = long(dw_modifica.describe("b_linea_fine.y2")) + 190 //this.height //- 90
this.width = dw_modifica.width  //-100
this.height = dw_modifica.height //-120

end subroutine

event u_open;call super::u_open;//
environment kenv
integer k_rtn
kuf_armo_sl_pt_g3_lav kuf1_armo_sl_pt_g3_lav

try  
	kguo_exception.inizializza(this.classname())

	kiuf_armo_sl_pt_g3_lav = create kuf_armo_sl_pt_g3_lav

	if isnull(ki_st_open_w.key12_any) then
		kguo_exception.kist_esito.esito = kkg_esito.ko
		kguo_exception.kist_esito.sqlerrtext = "Funzione abortita, dati di Trattamento G3 mancanti!"
		throw kguo_exception
	else
		kuf1_armo_sl_pt_g3_lav = ki_st_open_w.key12_any
	end if
	if isvalid(kuf1_armo_sl_pt_g3_lav) then
		kiuf_armo_sl_pt_g3_lav.kist_tab_armo_sl_pt_g3_lav = kuf1_armo_sl_pt_g3_lav.kist_tab_armo_sl_pt_g3_lav
	else
		kguo_exception.kist_esito.esito = kkg_esito.ko
		kguo_exception.kist_esito.sqlerrtext = "Funzione abortita, è stato passato un oggetto dati non riconosciuto!"
		throw kguo_exception
	end if
	if kiuf_armo_sl_pt_g3_lav.kist_tab_armo_sl_pt_g3_lav.id_armo > 0 or kiuf_armo_sl_pt_g3_lav.kist_tab_armo_sl_pt_g3_lav.id_sl_pt_g3_lav > 0 &
							or kiuf_armo_sl_pt_g3_lav.kist_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav > 0 then
	else
		kguo_exception.kist_esito.esito = kkg_esito.ko
		kguo_exception.kist_esito.sqlerrtext = "Funzione abortita, dati ID del Trattamento G3 mancanti!"
		throw kguo_exception
	end if
	
	try
		kiuf_armo_sl_pt_g3_lav.if_sicurezza(ki_st_open_w.flag_modalita) 
		this.title = "Modifica "
		dw_modifica.ki_flag_modalita = ki_st_open_w.flag_modalita

	catch (uo_exception kuo1_exception)
		this.title = "Visualizza "
		dw_modifica.ki_flag_modalita = kkg_flag_modalita.visualizzazione 
		dw_modifica.u_proteggi_sproteggi_dw()
		dw_modifica.modify("cb_aggiorna.visible='0' cb_ripristina.visible='0'")
		
	finally
		if kiuf_armo_sl_pt_g3_lav.kist_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav > 0 then
			this.title += "dati Trattamento G3 per Id " + string(kiuf_armo_sl_pt_g3_lav.kist_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav)
		else
			this.title += "dati Trattamento G3 per Id riga Lotto " + string(kiuf_armo_sl_pt_g3_lav.kist_tab_armo_sl_pt_g3_lav.id_armo) &
							+ " e Id G3 " + string(kiuf_armo_sl_pt_g3_lav.kist_tab_armo_sl_pt_g3_lav.id_sl_pt_g3_lav) 
		end if
	end try
		
	post u_retrieve( )  // Visualizza DATI 
	
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

end try

end event

on w_armo_sl_pt_g3_lav.create
int iCurrent
call super::create
this.dw_modifica=create dw_modifica
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_modifica
end on

on w_armo_sl_pt_g3_lav.destroy
call super::destroy
destroy(this.dw_modifica)
end on

event close;call super::close;//

int k 
k=1
//if isvalid(kiuf_armo_sl_pt_g3_lav) then destroy kiuf_armo_sl_pt_g3_lav
end event

event u_open_preliminari;call super::u_open_preliminari;//
u_resize()
end event

type dw_modifica from uo_dw_armo_sl_pt_g3_lav_modifica within w_armo_sl_pt_g3_lav
integer width = 3429
integer height = 1748
integer taborder = 10
boolean enabled = true
boolean titlebar = false
string title = "Modifica dati Trattamento G3 "
boolean controlmenu = false
boolean resizable = false
end type

event ue_aggiornamenti_ok;call super::ue_aggiornamenti_ok;//
st_open_w kst_open_w


if this.rowcount( ) > 0 then
		
//	messagebox("
	if isvalid(ki_st_open_w.key10_window_chiamante) then 
		
		kst_open_w.key2 = dw_modifica.dataobject
		kst_open_w.key12_any = dw_modifica
		ki_st_open_w.key10_window_chiamante.event u_ricevi_da_elenco(kst_open_w)
		
	end if
end if


end event

