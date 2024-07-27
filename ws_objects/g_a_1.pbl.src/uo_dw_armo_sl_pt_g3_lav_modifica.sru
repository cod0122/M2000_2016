$PBExportHeader$uo_dw_armo_sl_pt_g3_lav_modifica.sru
forward
global type uo_dw_armo_sl_pt_g3_lav_modifica from uo_d_std_1
end type
end forward

global type uo_dw_armo_sl_pt_g3_lav_modifica from uo_d_std_1
boolean visible = true
integer width = 3365
integer height = 1756
boolean titlebar = true
string title = "Visualizza/Modifica dati di Trattamento del Lotto"
string dataobject = "d_armo_sl_pt_g3_lav_modif"
boolean controlmenu = true
boolean hscrollbar = false
boolean vscrollbar = false
boolean resizable = true
string icon = "Form!"
boolean hsplitscroll = false
boolean livescroll = false
borderstyle borderstyle = styleraised!
boolean ki_attiva_standard_select_row = false
event ue_aggiornamenti_ok ( )
event u_resize_min ( )
event u_resize_max ( )
event u_aggiorna ( )
event type long u_retrieve ( ) throws uo_exception
event u_delete ( )
end type
global uo_dw_armo_sl_pt_g3_lav_modifica uo_dw_armo_sl_pt_g3_lav_modifica

type variables
//
public:
kuf_armo_sl_pt_g3_lav kiuf_armo_sl_pt_g3_lav


end variables

forward prototypes
private subroutine resize ()
private function integer check_dati ()
protected function st_esito u_delete_g3 ()
protected function st_esito u_aggiorna_g3 ()
end prototypes

event ue_aggiornamenti_ok();//---
//--- mettere qui il codice da fare dopo che aggiornamenti fatti OK!
//---

end event

event u_resize_min();//
	this.height = 190 + long(this.object.b_linea.y1) 

end event

event u_resize_max();//
	this.height = 190 + long(this.object.b_linea_fine.y1) 
end event

event u_aggiorna();//
st_esito kst_esito


//--- Aggiunge/Aggiorna trattamento alla tabella che va in deroga sul trattamento
	kst_esito = u_aggiorna_g3()

//--- se aggiornamento tutto ok		
	if kst_esito.esito = kkg_esito.ok then
	
		this.modify("p_ok_applica.visible='1'")
		
//--- dopo che aggiornamenti OK esegue questa (DA PERSONALIZZARE) 					
		this.event ue_aggiornamenti_ok()

	end if
end event

event type long u_retrieve();/*
*/
long k_return 


kguo_exception.inizializza(this.classname())

k_return = this.retrieve(kiuf_armo_sl_pt_g3_lav.kist_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav &
					,kiuf_armo_sl_pt_g3_lav.kist_tab_armo_sl_pt_g3_lav.id_armo &
					,kiuf_armo_sl_pt_g3_lav.kist_tab_armo_sl_pt_g3_lav.id_sl_pt_g3_lav)
					
if k_return < 0 then					
	kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Lettura dati di Trattamento G3, " &
			 	+ " per Id riga Lotto " + string(kiuf_armo_sl_pt_g3_lav.kist_tab_armo_sl_pt_g3_lav.id_armo) &
				+ " e Id G3 " + string(kiuf_armo_sl_pt_g3_lav.kist_tab_armo_sl_pt_g3_lav.id_sl_pt_g3_lav) &
				+ " o Id G3 di Trattamento " + string( kiuf_armo_sl_pt_g3_lav.kist_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav))
	throw kguo_exception				
end if

return k_return					
end event

event u_delete();//
st_esito kst_esito


//--- Aggiunge/Aggiorna trattamento alla tabella che va in deroga sul trattamento
	kst_esito = u_delete_g3()

//--- se aggiornamento tutto ok		
	if kst_esito.esito = kkg_esito.ok then
		
		this.modify("p_ok_applica.ripri='1'")
	
//--- dopo che aggiornamenti OK esegue questa (DA PERSONALIZZARE) 					
		this.event ue_aggiornamenti_ok()

	end if
end event

private subroutine resize ();//
//=== Dimensiona e Posiziona la dw nella window 
	this.setredraw(false)

	this.width = long(this.object.b_linea.x2) + 100
	if this.object.cb_dettaglio.text = "Nascondi" then
		event u_resize_max( )
	else
		this.object.cb_dettaglio.text = "Dettaglio >>" 
		event u_resize_min( )
	end if
		
	this.setredraw(true) 

	parent.triggerevent(resize!)
	
end subroutine

private function integer check_dati ();/*
 Controllo se dati modificati in modo congruente
 	Ritorna  : 0=tutto OK; 1=errore 
*/

if this.rowcount() > 0 then

//--- N.GIRI obbligatori 
	if this.getitemnumber(1, "ngiri") > 0 then 
	else
		kguo_exception.inizializza( )
		kguo_exception.messaggio_utente("Valore assente", "Impostare il Numero Giri di Trattamento")
		return 1
	end if
	
//--- CICLO obbligatorio
	if this.getitemnumber(1, "ciclo_target") > 0 then 
	else
		kguo_exception.inizializza( )
		kguo_exception.messaggio_utente("Valore assente", "Impostare il Ciclo di Trattamento")
		return 1
	end if
	
end if

return 0

end function

protected function st_esito u_delete_g3 ();//
string k_msg
int k_elaboro=0
st_esito kst_esito 
st_tab_armo_sl_pt_g3_lav kst_tab_armo_sl_pt_g3_lav


try

	kst_esito = kguo_exception.inizializza( this.classname())
	
	this.accepttext( )
	
	if this.rowcount() > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione 
		kst_esito.sqlerrtext = "Dati mancanti per Modifica giri di Trattamento."
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	kst_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav = this.object.id_armo_sl_pt_g3_lav[1]  //.primary.original[1]	
	
	k_msg = "Rimozione dei dati proposti per il Trattamento per questo Lotto n. " &
				+ string(this.getitemnumber(1, "meca_num_int")) + ". " &
				+ kkg.acapo + "Cancellazione del N. Giri " + string(this.object.ngiri[1]) + " e del Ciclo " + string(this.object.ciclo_target[1]) + " " &
				+ kkg.acapo + "e ripristino del N. Giri " + string(this.object.sl_pt_g3_lav_ngiri[1]) &
				+ " e del Ciclo " + string(this.object.sl_pt_g3_lav_ciclo_target[1]) &
				+ kkg.acapo + "Applicare l'operazione?"

	k_elaboro = messagebox("Rimozione Dati di Trattamento", k_msg, question!, yesno!, 2)
					
//--- operazione annullata			
	if k_elaboro = 2 then
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione 
		kguo_exception.kist_esito.sqlerrtext = "Elaborazione annullata dall'utente."
		throw kguo_exception
	end if

	if kiuf_armo_sl_pt_g3_lav.tb_delete(kst_tab_armo_sl_pt_g3_lav) then
			
		this.setitem(1, "id_armo_sl_pt_g3_lav", 0)
		this.setitem(1, "ngiri", 0)
		this.setitem(1, "ciclo_target", 0)
		
	end if						

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return kst_esito

end function

protected function st_esito u_aggiorna_g3 ();//
string k_msg
int k_elaboro=0
st_esito kst_esito //, kst_esito_update, kst_esito_return, kst_esito_err
st_tab_armo_sl_pt_g3_lav kst_tab_armo_sl_pt_g3_lav


try

	kst_esito = kguo_exception.inizializza( this.classname())
	
	this.accepttext( )
	
	if this.rowcount() > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione 
		kst_esito.sqlerrtext = "Dati mancanti per Modifica giri di Trattamento."
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	kst_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav = this.object.id_armo_sl_pt_g3_lav[1]  //.primary.original[1]	
	kst_tab_armo_sl_pt_g3_lav.id_armo = this.object.id_armo[1]  
	kst_tab_armo_sl_pt_g3_lav.id_sl_pt_g3_lav = this.object.id_sl_pt_g3_lav[1]
	kst_tab_armo_sl_pt_g3_lav.ciclo_target = this.object.ciclo_target[1]
	kst_tab_armo_sl_pt_g3_lav.ngiri = this.object.ngiri[1]
	//kst_tab_armo_sl_pt_g3_lav.descr = this.object.descr[1]
	kst_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav = this.object.id_armo_sl_pt_g3_lav[1]  
	kst_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav = this.object.id_armo_sl_pt_g3_lav[1]  
	
	k_msg = "Modifica dei dati proposti per il Trattamento per questo Lotto n. " &
				+ string(this.getitemnumber(1, "meca_num_int")) + ". " &
				+ kkg.acapo + "Sostituzione del N. Giri " + string(this.object.sl_pt_g3_lav_ngiri[1]) &
				+ " e del Ciclo " + string(this.object.sl_pt_g3_lav_ciclo_target[1]) &
				+ " con " + string(this.object.ngiri[1]) + " e " + string(this.object.ciclo_target[1]) &
				+ kkg.acapo + "Applicare l'aggiornamento?"

	k_elaboro = messagebox("Aggiornamento Dati di Trattamento", k_msg, question!, yesno!, 2)
					
//--- operazione annullata			
	if k_elaboro = 2 then
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione 
		kguo_exception.kist_esito.sqlerrtext = "Elaborazione di Modifica dati di Trattamento annullata dall'utente."
		throw kguo_exception
	end if

	if kiuf_armo_sl_pt_g3_lav.set_armo_sl_pt_g3_lav(kst_tab_armo_sl_pt_g3_lav) > 0 then
			
		this.setitem(1, "id_armo_sl_pt_g3_lav", kst_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav)
			
	end if						

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return kst_esito

end function

on uo_dw_armo_sl_pt_g3_lav_modifica.create
call super::create
end on

on uo_dw_armo_sl_pt_g3_lav_modifica.destroy
call super::destroy
end on

event buttonclicked;call super::buttonclicked;//
//
st_esito kst_esito

	
	choose case dwo.name
			
		case "cb_esci"
			close(parent)
			
//		case "cb_dettaglio"
////=== Dimensiona e Posiziona la dw nella window 
//			if this.object.cb_dettaglio.text = "Dettaglio >>" then
//				this.object.cb_dettaglio.text = "Nascondi" 
//			else
//				this.object.cb_dettaglio.text = "Dettaglio >>" 
//			end if
//			resize()
			
		case "cb_aggiorna"
			this.modify("p_ok_applica.visible='0'")
			this.modify("p_ok_applica.ripri='0'")
			this.accepttext()

//--- controllo dati immessi			
			if check_dati() = 0 then
		
				event u_aggiorna( )
				
			end if
			
		case "cb_ripristina"
			this.modify("p_ok_applica.visible='0'")
			this.modify("p_ok_applica.ripri='0'")
			if this.object.id_armo_sl_pt_g3_lav[1] > 0 then
				
				this.object.cb_ripristina.enabled = "0"

				event u_delete( )
				
			end if
							

	end choose


end event

event constructor;call super::constructor;//
	kiuf_armo_sl_pt_g3_lav = create kuf_armo_sl_pt_g3_lav

end event

event destructor;call super::destructor;//
if isvalid(kiuf_armo_sl_pt_g3_lav) then destroy kiuf_armo_sl_pt_g3_lav

end event

