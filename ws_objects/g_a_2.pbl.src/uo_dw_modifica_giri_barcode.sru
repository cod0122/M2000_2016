$PBExportHeader$uo_dw_modifica_giri_barcode.sru
forward
global type uo_dw_modifica_giri_barcode from uo_d_std_1
end type
end forward

global type uo_dw_modifica_giri_barcode from uo_d_std_1
integer width = 3365
integer height = 2228
boolean titlebar = true
string title = "Visualizza/Modifica Cicli di Lavorazione del Barcode/Riferimento"
string dataobject = "d_giri_x_modif"
boolean controlmenu = true
boolean hscrollbar = false
boolean vscrollbar = false
boolean resizable = true
string icon = "Form!"
boolean hsplitscroll = false
boolean livescroll = false
borderstyle borderstyle = styleraised!
boolean ki_attiva_standard_select_row = false
event ue_mostra_aggiornamenti_dw ( )
event ue_aggiornamenti_ok ( )
event u_resize_min ( )
event u_resize_max ( )
event u_exit ( )
event u_rirpristina_valori ( )
event u_aggiorna ( )
end type
global uo_dw_modifica_giri_barcode uo_dw_modifica_giri_barcode

type variables
//
public:

//--- Se NON voglio Aggiornare le TABELLE ma solo il DW imposto il flag
boolean ki_AGGIORNARE_TABELLE = TRUE

int ki_modif_tutto_riferimento = 0
int ki_modifica_giri_pianificati = 1 

st_tab_barcode kist_tab_barcode

//-------------------------------------------------------------------------------------------------------------------------------------------
private:

kuf_barcode kiuf_barcode
kuf_barcode_mod_giri kiuf_barcode_mod_giri

st_tab_barcode kist_tab_barcode_contati

//--- la dw contenente i barcode da modificare, attenersi a quanto segue:
//--- se devo modificare solo un singolo barcode da dw deve contenere le seguenti colonne:
//--- barcode_barcode
//--- se devo modificare tutti i barcode del Riferimento:
//--- num_int, data_int
//--- inoltre, tutti i dw devono contenere le seguenti colonne: 
//--- barcode_fila_1, barcode_fila_2, barcode_fila_1p, barcode_fila_2p
//--- barcode_tipo_cicli
//--- PUOI USARE IL D_MODIFICA_GIRI_BARCODE
datawindow kidw_barcode_da_modificare // ex kidw_barcode_da_modificare
//--- Questa DW invece contiene gli eventuali barcode da non modificare 
//--- l'unica colonna necessaria e': barcode_barcode
datawindow kidw_barcode_da_non_modificare


end variables

forward prototypes
private function integer check_modifica_giri ()
public subroutine modifica_giri (st_tab_barcode kst_tab_barcode, string k_modalita_modifica_file, integer k_modif_tutto_riferimento, ref datawindow kdw_barcode_da_modificare, ref datawindow kdw_barcode_da_non_modificare)
private subroutine resize ()
private subroutine esponi_numero_figli ()
private function string u_get_nome_col (ref datawindow kdw_1, string knome_col)
private function boolean aggiorna_barcode_giri_esegue (st_tab_barcode ast_tab_barcode) throws uo_exception
protected function st_esito aggiorna_barcode_giri ()
private subroutine aggiorna_barcode_giri_seleziona_barcode_ ()
private function integer aggiorna_barcode_giri_1 (integer k_riga_selected) throws uo_exception
end prototypes

event ue_mostra_aggiornamenti_dw();//---
//--- mettere qui il codice che aggiorna la dw
//---

end event

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

event u_exit();//
	this.visible = false
	kidw_barcode_da_modificare.setfocus()

end event

event u_rirpristina_valori();//
long k_riga
st_tab_barcode kst_tab_barcode
st_tab_sl_pt kst_tab_sl_pt
st_esito kst_esito
kuf_sl_pt kuf1_sl_pt



			
k_riga = 1 //this.getrow() 
kst_tab_sl_pt.cod_sl_pt = this.object.armo_cod_sl_pt.primary[k_riga]
kuf1_sl_pt = create kuf_sl_pt
kst_esito=kuf1_sl_pt.select_riga(kst_tab_sl_pt)
destroy kuf1_sl_pt
if kst_esito.esito = kkg_esito.ok then
	this.object.barcode_tipo_cicli.primary[k_riga]=kst_tab_sl_pt.tipo_cicli
	this.object.fila_pref.primary[k_riga]=kst_tab_sl_pt.fila_pref
	this.object.barcode_fila_1.primary[k_riga]=kst_tab_sl_pt.fila_1
	this.object.barcode_fila_2.primary[k_riga]=kst_tab_sl_pt.fila_2
	this.object.barcode_fila_1p.primary[k_riga]=kst_tab_sl_pt.fila_1p
	this.object.barcode_fila_2p.primary[k_riga]=kst_tab_sl_pt.fila_2p
	if kst_tab_sl_pt.fila_1 > 0 or kst_tab_sl_pt.fila_1p > 0 &
		then
		this.object.scelta_fila_1.primary[k_riga]="1"
	else
		this.object.scelta_fila_1.primary[k_riga]="0"
	end if
	if kst_tab_sl_pt.fila_2 > 0 or kst_tab_sl_pt.fila_2p > 0 &
		then
		this.object.scelta_fila_2.primary[k_riga]="1"
	else
		this.object.scelta_fila_2.primary[k_riga]="0"
	end if
	
//--- se sono in tipo_cicli "a scelta" ed è stata data la preferenza a FILA 1 o FILA 2....
	if this.object.barcode_tipo_cicli.primary[k_riga] = kuf1_sl_pt.ki_tipo_cicli_a_scelta then
		 if this.object.fila_pref.primary[k_riga] = "1" then
			this.object.scelta_fila_1.primary[k_riga]="1"
			this.object.scelta_fila_2.primary[k_riga]="0"
		else
			 if this.object.fila_pref.primary[k_riga] = "2" then
				this.object.scelta_fila_1.primary[k_riga]="0"
				this.object.scelta_fila_2.primary[k_riga]="1"
			end if
		end if
	end if

	this.object.barcode_tipo_cicli.protect = "1"
	this.object.cb_aggiorna.visible = "0"
	this.object.barcode_fila_1.protect = "1"
	this.object.barcode_fila_2.protect = "1"
	this.object.barcode_fila_1p.protect = "1"
	this.object.scelta_fila_1.protect = "1"
	this.object.scelta_fila_2.protect = "1"
end if
end event

event u_aggiorna();//
st_esito kst_esito


//--- Aggiornamento 
	kst_esito = aggiorna_barcode_giri()

//--- se aggiornamento tutto ok		
	if kst_esito.esito = kkg_esito.ok then
	
		this.visible = false
		kidw_barcode_da_modificare.setfocus()

//--- dopo che aggiornamenti OK esegue questa (DA PERSONALIZZARE) 					
		this.event ue_aggiornamenti_ok()

	end if	

//--- aggiorna anche le dw a video (DA PERSONALIZZARE) 					
	this.event ue_mostra_aggiornamenti_dw()

end event

private function integer check_modifica_giri ();//
//----------------------------------------------------------------------------------------------------
//--- Controllo se giri modificati in modo congruente
//--- Ritorna  : 0=tutto OK; 1=errore logico
//--- 
//----------------------------------------------------------------------------------------------------

string k_errore_txt = ""
integer k_errore = 0
int k_riga
st_esito kst_esito
st_tab_sl_pt kst_tab_sl_pt
kuf_sl_pt kuf1_sl_pt



//--- Controllo il primo tab
k_riga = this.getrow()

if k_riga > 0 then


//--- se non sono attivi ne' il flag fila1 ne' fila2 allora c'e' un errore 
	if (this.object.scelta_fila_1.primary[k_riga] = "0" or isnull(this.object.scelta_fila_1.primary[k_riga])) &
			  and (this.object.scelta_fila_2.primary[k_riga] = "0" or isnull(this.object.scelta_fila_2.primary[k_riga])) then
	
	
		k_errore = 1 
		kguo_exception.inizializza( )
		kguo_exception.messaggio_utente("Imposta Giri di Trattamento", "Scegliere la fila di Trattamento, operazione non eseguita")
	
	else
	
	//--- se non e' attivo il campo di Scelta Fila allora azzero i giri della fila
		if this.object.scelta_fila_1.primary[k_riga] = "0" or isnull(this.object.scelta_fila_1.primary[k_riga]) then
			this.object.barcode_fila_1.primary[k_riga] = 0
			this.object.barcode_fila_1p.primary[k_riga] = 0
		end if
		if this.object.scelta_fila_2.primary[k_riga] = "0" or isnull(this.object.scelta_fila_2.primary[k_riga]) then
			this.object.barcode_fila_2.primary[k_riga] = 0
			this.object.barcode_fila_2p.primary[k_riga] = 0
		end if

		if ki_modif_tutto_riferimento <> kiuf_barcode_mod_giri.ki_modif_tutto_riferimento_si &
				and this.object.barcode_tipo_cicli.primary[k_riga] = kuf1_sl_pt.ki_tipo_cicli_a_scelta then
			this.object.barcode_tipo_cicli.primary[k_riga] = kuf1_sl_pt.ki_tipo_cicli_singolo
		end if
		kst_tab_sl_pt.tipo_cicli = this.object.barcode_tipo_cicli.primary[k_riga]
		kst_tab_sl_pt.fila_1 = this.object.barcode_fila_1.primary[k_riga]
		kst_tab_sl_pt.fila_2 = this.object.barcode_fila_2.primary[k_riga]
		kst_tab_sl_pt.fila_1p = this.object.barcode_fila_1p.primary[k_riga]
		kst_tab_sl_pt.fila_2p = this.object.barcode_fila_2p.primary[k_riga]

//--- 12.1.06 FORZO IL TIPO CICLI QUANDO NON VALORIZZATO (MA PERCHE' NON E' VALORIZZATO??=)	??????????????????????????
		if LenA(trim(kst_tab_sl_pt.tipo_cicli)) = 0 then
			if kst_tab_sl_pt.fila_1 > 0 and kst_tab_sl_pt.fila_2 > 0 then
				kst_tab_sl_pt.tipo_cicli = kuf1_sl_pt.ki_tipo_cicli_misto
			else
				kst_tab_sl_pt.tipo_cicli = kuf1_sl_pt.ki_tipo_cicli_singolo
			end if
		end if

//--- controllo di congruenza dei dati immessi
		kuf1_sl_pt = create kuf_sl_pt
		kst_esito=kuf1_sl_pt.check_formale_giri_in_lav(kst_tab_sl_pt)
		destroy kuf1_sl_pt	
	
		choose case kst_esito.esito
	
			case "1" //errore grave: incongruenze dati
				k_errore = 1 
				kguo_exception.inizializza( )
				kguo_exception.messaggio_utente("Dati incongruenti, operazione non eseguita", trim(kst_esito.sqlerrtext))
				
			case "2" //avvertenza: dati da rivedere
				
		end choose

	end if


end if


return k_errore 

end function

public subroutine modifica_giri (st_tab_barcode kst_tab_barcode, string k_modalita_modifica_file, integer k_modif_tutto_riferimento, ref datawindow kdw_barcode_da_modificare, ref datawindow kdw_barcode_da_non_modificare);//--- 
//--- Attiva modalita per modificare i giri su uno o piu' barcode
//---
//--- Input: st_tab_barcode valorizzare:
//							kst_tab_barcode.barcode, &
//			           	kst_tab_barcode.num_int, &
//							kst_tab_barcode.data_int, &
//							kst_tab_barcode.fila_1, &
//							kst_tab_barcode.fila_2, &
//							kst_tab_barcode.fila_1p, &
//							kst_tab_barcode.fila_2p, &
//							kst_tab_barcode.pl_barcode &
//---           k_modalita_modifica_file 					vedi variabile di stato nelle istanze
//---           k_modif_tutto_riferimento					indica se modificare solo uno o tutti i barcode del riferim (non trattati)
//---           datawindow kdw_barcode_da_modificare 	contenente i barcode da modificare (vedi istanze)
//---           datawindow kdw_barcode_da_non_modificare contenente i barcode eccezionali da NON modificare (vedi istanze)
//---
long k_rec //, k_riga
kuf_sl_pt kuf1_sl_pt


try

	ki_modif_tutto_riferimento = k_modif_tutto_riferimento
	kist_tab_barcode = kst_tab_barcode
	kidw_barcode_da_modificare = kdw_barcode_da_modificare
	kidw_barcode_da_non_modificare = kdw_barcode_da_non_modificare

//--- seleziona le prima riga selezionata
//	k_riga = kdw_barcode_da_modificare.getselectedrow(0)
//	if k_riga > 0 then
//		kidw_barcode_da_modificare.selectrow(k_riga, true)
//	end if

	if trim(kst_tab_barcode.barcode) > " " then

		this.settransobject (sqlca)

//--- dimensiona la dw
		resize()
			
		this.setredraw(false)

		if isnull(kst_tab_barcode.fila_1) then
			kst_tab_barcode.fila_1 = 999
		end if
		if isnull(kst_tab_barcode.fila_1p) then
			kst_tab_barcode.fila_1p = 999
		end if
		if isnull(kst_tab_barcode.fila_2) then
			kst_tab_barcode.fila_2 = 999
		end if
		if isnull(kst_tab_barcode.fila_2p) then
			kst_tab_barcode.fila_2p = 999
		end if
		
		if kst_tab_barcode.id_meca = 0 and kst_tab_barcode.barcode > ' ' then
			kiuf_barcode.get_id_meca(kst_tab_barcode)
		end if
	
		this.reset()
		k_rec = this.retrieve(kst_tab_barcode.barcode, &
									kst_tab_barcode.id_meca, &
									kst_tab_barcode.fila_1, &
									kst_tab_barcode.fila_2, &
									kst_tab_barcode.fila_1p, &
									kst_tab_barcode.fila_2p, &
									0 &
								  )

		if k_rec > 0 then
			this.setitem ( k_rec, "modalita_modifica", k_modalita_modifica_file)

//--- imposto dati di dafault  
//--- modalita' modifica giri  
			if k_modalita_modifica_file <> kiuf_barcode_mod_giri.ki_modalita_modifica_scelta_fila then
				if this.object.barcode_fila_1.primary[k_rec] > 0 &
					or this.object.barcode_fila_1p.primary[k_rec] > 0 &
					then
					this.object.scelta_fila_1.primary[k_rec]="1"
				else
					this.object.scelta_fila_1.primary[k_rec]="0"
				end if
				if this.object.barcode_fila_2.primary[k_rec] > 0 &
					or this.object.barcode_fila_2p.primary[k_rec] > 0 &
					then
					this.object.scelta_fila_2.primary[k_rec]="1"
				else
					this.object.scelta_fila_2.primary[k_rec]="0"
				end if

//--- se sono in tipo_cicli "a scelta" ed è stata data la preferenza a FILA 1 o FILA 2....
				if this.object.barcode_tipo_cicli.primary[k_rec] = kuf1_sl_pt.ki_tipo_cicli_a_scelta then
					 if this.object.fila_pref.primary[k_rec] = "1" then
						this.object.scelta_fila_1.primary[k_rec]="1"
						this.object.scelta_fila_2.primary[k_rec]="0"
					else
						 if this.object.fila_pref.primary[k_rec] = "2" then
							this.object.scelta_fila_1.primary[k_rec]="0"
							this.object.scelta_fila_2.primary[k_rec]="1"
						end if
					end if
				end if
				
			else
//--- modalita' scelta tra fila 1 o fila 2
				this.object.scelta_fila_1.primary[k_rec] = "0"
				this.object.scelta_fila_2.primary[k_rec] = "0"
				this.object.barcode_tipo_cicli.primary[k_rec] = kuf1_sl_pt.ki_tipo_cicli_singolo
			end if
			
			if k_modif_tutto_riferimento = kiuf_barcode_mod_giri.ki_modif_tutto_riferimento_si then
//--- toglie la specififca del barcode 					
				this.object.barcode_barcode.primary[k_rec] = "*"
//--- modifica l'intero Riferimento					
				this.object.aggiorna_rif.visible = "1"
				this.object.aggiorna_rif.primary[k_rec] = "1"
				this.object.aggiorna_righe_selezionate.primary[k_rec]="0"
			else
				this.object.aggiorna_rif.visible = "0"
				this.object.aggiorna_rif.primary[k_rec] = "0"
//--- modifica più barcode selezionati
				if k_modalita_modifica_file <> kiuf_barcode_mod_giri.ki_modalita_modifica_giri_riga then
			//k_riga = kdw_barcode_da_modificare.getselectedrow(0)
				//if k_riga > 0 then
					//k_riga = kdw_barcode_da_modificare.getselectedrow(k_riga)
				//end if
				//if k_riga > 0 then
					this.object.aggiorna_righe_selezionate.primary[k_rec]="1"  // + righe da modif
				else
					this.object.aggiorna_righe_selezionate.primary[k_rec]="0"  // solo 1 barcode
				end if
			end if


//--- mette a video il numero dei figli, se ce ne sono
			esponi_numero_figli()				
			
			this.visible = true
			this.setredraw(true)
			this.BringToTop = TRUE
		
		else
		
			kguo_exception.inizializza(this.classname())
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_not_fnd )
			kguo_exception.setmessage("Modifica Cicli di Trattamento: Barcode " + trim(kst_tab_barcode.barcode) + " non trovato in archivio!!")
			kguo_exception.messaggio_utente( )
			throw kguo_exception
		end if
	
	else
		
		kguo_exception.inizializza(this.classname())
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
		kguo_exception.setmessage("Modifica Cicli di Trattamento:  Dati selezionati non validi!!")
		kguo_exception.messaggio_utente()
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	kguo_exception.messaggio_utente( )
	
end try

end subroutine

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

private subroutine esponi_numero_figli ();//
long k_ctr=0
kuf_barcode kuf1_barcode



try 
	if kist_tab_barcode_contati.barcode <> kist_tab_barcode.barcode then
		kist_tab_barcode_contati = kist_tab_barcode
		kuf1_barcode = create kuf_barcode
		k_ctr = kuf1_barcode.get_conta_figli( kist_tab_barcode_contati)
		if k_ctr > 0 then
			this.object.barcode_figli_conta[this.getrow()] = k_ctr
		else
			this.object.barcode_figli_conta[this.getrow()] = 0
		end if
	end if
catch (uo_exception kuo_exception)
	this.object.barcode_figli_conta[this.getrow()] = 0
end try



end subroutine

private function string u_get_nome_col (ref datawindow kdw_1, string knome_col);//---
string k_ret

						
k_ret = kdw_1.describe("barcode_" + knome_col + ".x")

if k_ret = "!" or k_ret = "?" then
	k_ret = kdw_1.describe(knome_col + ".x")
	if k_ret = "!" or k_ret = "?" then
		return ""
	else
		return knome_col
	end if
else
	return "barcode_" + knome_col
end if


end function

private function boolean aggiorna_barcode_giri_esegue (st_tab_barcode ast_tab_barcode) throws uo_exception;//---
//--- Aggiorna i GIRI sulla tabella BARCODE
//---
//--- input : st_tab_barcode.barcode
//---
//--- Lancia Exception
//
boolean k_return = false
long k_riga, k_ctr=1
st_esito kst_esito_update
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode
uo_ds_std_1 kds_barcode_figli


try 

	kst_esito_update = kguo_exception.inizializza(this.classname())
	
	kist_tab_barcode.barcode = ast_tab_barcode.barcode
	
//--- mi chiedo se posso veramente aggiornare sti giri per questo barcode magari e' un figlio quindi NISBA
	k_return = kiuf_barcode_mod_giri.autorizza_modifica_giri(kist_tab_barcode, kiuf_barcode_mod_giri.ki_modifica_giri_pianificati_si) 
	if k_return then

		kuf1_barcode = create kuf_barcode

		if this.rowcount( ) > 0 then
			k_riga = this.getrow()
			kist_tab_barcode.tipo_cicli = this.object.barcode_tipo_cicli.primary[k_riga] 
			kist_tab_barcode.fila_1 = this.object.barcode_fila_1.primary[k_riga] 
			kist_tab_barcode.fila_2 = this.object.barcode_fila_2.primary[k_riga] 
			kist_tab_barcode.fila_1p = this.object.barcode_fila_1p.primary[k_riga] 
			kist_tab_barcode.fila_2p = this.object.barcode_fila_2p.primary[k_riga] 
		end if
						
//--- AGGIORNA i giri sul tab barcode	!!!!!!!!!!!!!!!!!!!!!!!---------------------------------------------------------------------------------------------------		
		if ki_AGGIORNARE_TABELLE then  // SOLO se flag di aggiornamento ATTIVATO!!!!
			kist_tab_barcode.st_tab_g_0.esegui_commit = "N" 
			kst_esito_update = kuf1_barcode.tb_update_campo( kist_tab_barcode, "barcode_update_giri")
		end if

//--- se barcode 'padre' allora aggiorno anche i figli dello stesso SL-PT
		if kst_esito_update.esito = kkg_esito.ok then
			kst_tab_barcode = kist_tab_barcode
			if kuf1_barcode.get_conta_figli(kst_tab_barcode) > 0 then
				kds_barcode_figli = kuf1_barcode.get_figli_barcode_uguale_sl_pt(kst_tab_barcode)
				k_ctr = 1
				do while k_ctr <= kds_barcode_figli.rowcount( ) and kst_esito_update.esito = kkg_esito.ok
//--- Aggiorna Barcode Figli con lo stesso PT												
					kst_tab_barcode.barcode = kds_barcode_figli.object.barcode[k_ctr]
					
					if ki_AGGIORNARE_TABELLE then  // flag di aggiornamento!
						kist_tab_barcode.st_tab_g_0.esegui_commit = "N" 
						kst_esito_update = kuf1_barcode.tb_update_campo( kst_tab_barcode, "barcode_update_giri")
					end if
					k_ctr++
					
				loop
			end if
		end if
//-
		if kst_esito_update.esito <> kkg_esito.ok and kst_esito_update.esito <> kkg_esito.db_wrn and kst_esito_update.esito <> kkg_esito.not_fnd then
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito_update )
			throw kguo_exception
		end if		
		
		k_return = TRUE     //--- TUTTO OK!!!!
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	if isvalid(kds_barcode_figli) then destroy kds_barcode_figli
	
end try 


return k_return 


end function

protected function st_esito aggiorna_barcode_giri ();//
long k_riga_selected, k_ctr, k_record_aggiornati
string k_errore, k_msg
string k_find
int k_elaboro=0
st_esito kst_esito //, kst_esito_update, kst_esito_return, kst_esito_err
st_tab_barcode kst_tab_barcode


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
	
	kiuf_barcode.kist_tab_barcode.id_meca = this.object.id_meca.primary.original[1]
	
	kiuf_barcode.kist_tab_barcode.fila_1 = this.object.barcode_fila_1.primary.original[1]	
	kiuf_barcode.kist_tab_barcode.fila_2 = this.object.barcode_fila_2.primary.original[1]
	kiuf_barcode.kist_tab_barcode.fila_1p = this.object.barcode_fila_1p.primary.original[1]	
	kiuf_barcode.kist_tab_barcode.fila_2p = this.object.barcode_fila_2p.primary.original[1]
	
//--- se richiesto di aggiornare solo un barcode
//		if this.object.aggiorna_rif[1] = "0" then
//		else
	if ki_modif_tutto_riferimento = kiuf_barcode_mod_giri.ki_modif_tutto_riferimento_si then
		k_msg = "Saranno modificati i Barcode NON ANCORA PIANIFICATI per il Trattamento " + kkg.acapo   &
				+ "del Lotto n. " &
				+ string(this.getitemnumber(1, "meca_num_int")) + " " + kkg.acapo
				
		if this.object.scelta_fila_1[1] = "1" then
			if kiuf_barcode.kist_tab_barcode.fila_1 > 0 then	
				k_msg += "giri FILA 1 = " + string(kiuf_barcode.kist_tab_barcode.fila_1) + "+" + string(kiuf_barcode.kist_tab_barcode.fila_1p) + " " + kkg.acapo
			end if
		end if
		if this.object.scelta_fila_2[1] = "1" then
			if kiuf_barcode.kist_tab_barcode.fila_2 > 0 then	
				k_msg += "giri FILA 2 = " + string(kiuf_barcode.kist_tab_barcode.fila_2) + "+" + string(kiuf_barcode.kist_tab_barcode.fila_2p) + " " + kkg.acapo
			end if
		end if
		k_msg += "Applicare l'aggiornamento?"

	else
		
		if this.object.aggiorna_righe_selezionate[1]  = "1" then
			k_msg = "Attenzione, saranno modificati tutti i barcode selezionati.~n~r"  &
					+ "Applicare l'aggiornamento?"
		else
			k_msg = "Sarà modificato il Barcode '" &
					+ trim(this.object.barcode_barcode.primary[1]) + "' " + kkg.acapo  &
					+ "Applicare l'aggiornamento?"
		end if
	end if

	if k_elaboro = 0 then
		k_elaboro = messagebox("Aggiornamento Giri di Lavorazione", k_msg, question!, yesno!, 2)
	else
		if k_elaboro = 2 then
			messagebox("Aggiornamento Giri di Lavorazione", k_msg, information!)
		end if
	end if
					
	if k_elaboro = 2 then
//--- operazione annullata			
		kst_esito.esito = kkg_esito.no_esecuzione 
		kst_esito.sqlerrtext = "Elaborazione di Modifica giri di Trattamento annullata dall'utente."
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
//--- se devo aggiornare l'inteo riferimento seleziono le righe 
//			   and kidw_barcode_da_modificare.classname() <> "dw_meca" then
//			if this.object.aggiorna_rif.primary[1]  = "1" &
//						and ki_modif_tutto_riferimento <> kiuf_barcode_mod_giri.ki_modif_tutto_riferimento_si then
//				if this.object.aggiorna_righe_selezionate.primary[1] = "0" then
//					kidw_barcode_da_modificare.selectrow(0, false)
//				end if
//				this.object.aggiorna_righe_selezionate.primary[1] = "1"
//				aggiorna_barcode_giri_seleziona_barcode()
//			end if

//			kist_tab_barcode.pl_barcode = dw_dett_0.object.codice.primary[dw_dett_0.getrow()]
	if isnull(kist_tab_barcode.pl_barcode) then kist_tab_barcode.pl_barcode = 0
	
//--- ciclo per eventuali modifiche su piu' righe
//			if this.object.aggiorna_righe_selezionate.primary[1]  = "1" then
	if kidw_barcode_da_modificare.rowcount( ) > 0 then
		k_riga_selected = kidw_barcode_da_modificare.getselectedrow(0)
		if k_riga_selected = 0 then //09122014
			k_riga_selected = kidw_barcode_da_modificare.getrow()
			if k_riga_selected = 0 and kidw_barcode_da_modificare.rowcount( ) = 1 then
				k_riga_selected = 1
			end if
		end if
	end if

	if	k_riga_selected > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione 
		kst_esito.sqlerrtext = "Nessu barcode indicato per la Modifica giri dei Trattamento."
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	if this.object.aggiorna_righe_selezionate.primary[1]  = "1" then
		do while k_riga_selected > 0 

//--- Cambia i GIRI 
			k_record_aggiornati = aggiorna_barcode_giri_1(k_riga_selected)
			k_riga_selected = kidw_barcode_da_modificare.getselectedrow(k_riga_selected)
		loop

	else
		
//--- Cambia i GIRI 
		k_record_aggiornati = aggiorna_barcode_giri_1(k_riga_selected)
	end if						
			
	if k_record_aggiornati = 0 then
		if kst_esito.esito = kkg_esito.ok then
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Nessun aggiornamento ai giri di Trattamento eseguito"
			if this.object.aggiorna_rif[1] = "0" then
				messagebox("Operazione non eseguita", &
					"Impossibile aggiornare i Giri del Barcode '" + trim(kiuf_barcode.kist_tab_barcode.barcode) + "'. ")
			else
				messagebox("Operazione non eseguita", &
					"Impossibile aggiornare i Giri del Riferimento n. " + string(kiuf_barcode.kist_tab_barcode.num_int) + ". ")
			end if
		end if
	end if
			

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return kst_esito

end function

private subroutine aggiorna_barcode_giri_seleziona_barcode_ ();////---
////--- seleziona i barcode dello stesso riferimento
////---
//string k_find
//long k_riga
//
//							
////--- modifico i giri sulla dw dei riferimenti non pianificati 
//	k_find = u_get_nome_col(kidw_barcode_da_modificare, "num_int") + " = " + string(this.object.meca_num_int.primary[1]) &
//				+ " and " + u_get_nome_col(kidw_barcode_da_modificare, "data_int") + " = date('" &
//				+ string(this.object.meca_data_int.primary[1]) + "') " &
//				+ " "
//
//	k_riga = 1
//	k_riga = kidw_barcode_da_modificare.find (k_find, k_riga, kidw_barcode_da_modificare.rowcount())
//	
//	do while k_riga > 0 and k_riga <= kidw_barcode_da_modificare.rowcount()
//		
//		kidw_barcode_da_modificare.selectrow(k_riga, true)
//		k_riga++								
//		if k_riga <= kidw_barcode_da_modificare.rowcount() then
//			k_riga = kidw_barcode_da_modificare.find (k_find, k_riga, kidw_barcode_da_modificare.rowcount())
//		end if
//
//	loop
//		
//
end subroutine

private function integer aggiorna_barcode_giri_1 (integer k_riga_selected) throws uo_exception;//
long k_riga_find, k_ctr, k_record_aggiornati
integer k_riga_curs, k_righe_curs
string k_suffisso
st_esito kst_esito
st_tab_barcode kst_tab_barcode
datastore kds_kicursor_barcode_1



try 

//do
	kst_esito = kguo_exception.inizializza(this.classname())

//--- se devo aggiornare l'intero riferimento ometto il barcode 
	if this.object.aggiorna_righe_selezionate.primary[1]  = "1" then

//--- non e' abilitato per modificare piu' di un riferimento
		//if ki_modif_tutto_riferimento <> kiuf_barcode_mod_giri.ki_modif_tutto_riferimento_si then
		if this.object.aggiorna_rif[1]  <> "1" then
//--- PEZZA: per sopperire al fatto che ci sono colonne 'barcode' e 'barcode_barcode'
			if u_get_nome_col(kidw_barcode_da_modificare, "barcode") > " " then
				k_suffisso = "" 
			else
				k_suffisso = "barcode_" 
			end if
			kst_tab_barcode.barcode = kidw_barcode_da_modificare.getitemstring(k_riga_selected, u_get_nome_col(kidw_barcode_da_modificare, k_suffisso + "barcode"))
			kst_tab_barcode.num_int = kidw_barcode_da_modificare.getitemnumber(k_riga_selected, u_get_nome_col(kidw_barcode_da_modificare, k_suffisso + "num_int"))
			kst_tab_barcode.data_int = kidw_barcode_da_modificare.getitemdate(k_riga_selected, u_get_nome_col(kidw_barcode_da_modificare, k_suffisso + "data_int"))
//			kst_tab_barcode.fila_1 = kidw_barcode_da_modificare.object.barcode_fila_1.primary.original[k_riga_selected]	
//			kst_tab_barcode.fila_2 = kidw_barcode_da_modificare.object.barcode_fila_2.primary.original[k_riga_selected]
//			kst_tab_barcode.fila_1p = kidw_barcode_da_modificare.object.barcode_fila_1p.primary.original[k_riga_selected]	
//			kst_tab_barcode.fila_2p = kidw_barcode_da_modificare.object.barcode_fila_2p.primary.original[k_riga_selected]
		else
			kst_esito.esito = kkg_esito.err_logico
			kst_esito.sqlerrtext = "Aggiorna_barcode_giri: Non e' possibile aggiornare piu' di un Riferimento alla volta"
			kst_tab_barcode.barcode = " "
			kst_tab_barcode.num_int = 0
			kst_tab_barcode.data_int = date(0)
			kguo_exception.set_esito(kst_esito)
			kguo_exception.scrivi_log( )
			throw kguo_exception
		end if
	else
		//if ki_modif_tutto_riferimento <> kiuf_barcode_mod_giri.ki_modif_tutto_riferimento_si then
		if this.object.aggiorna_rif[1]  <> "1" then
			kst_tab_barcode.barcode = this.object.barcode_barcode.primary[1]    	
		else
			kst_tab_barcode.barcode = "*"
		end if
		kst_tab_barcode.num_int = this.object.meca_num_int.primary.original[1]	
		kst_tab_barcode.data_int = this.object.meca_data_int.primary.original[1]
	end if

	if trim(kst_tab_barcode.barcode) = "" then	
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlerrtext = "Aggiorna Giri barcode: elaborazione non eseguita nessun barcode da modificare!"
		kguo_exception.set_esito(kst_esito)
		kguo_exception.scrivi_log( )
		throw kguo_exception
	end if
	
	kst_tab_barcode.pl_barcode = 0
	
	//--- valorizza la fila poi da modificare
	kst_tab_barcode.fila_1 = kiuf_barcode.kist_tab_barcode.fila_1
	kst_tab_barcode.fila_2 = kiuf_barcode.kist_tab_barcode.fila_2
	kst_tab_barcode.fila_1p = kiuf_barcode.kist_tab_barcode.fila_1p
	kst_tab_barcode.fila_2p = kiuf_barcode.kist_tab_barcode.fila_2p
	
	//--- cerco il Barcode da aggiornare	
	if isnull(kst_tab_barcode.pl_barcode) then
		kst_tab_barcode.pl_barcode = 0
	end if
	if isnull(kst_tab_barcode.fila_1) then
		kst_tab_barcode.fila_1 = 999
	end if
	if isnull(kst_tab_barcode.fila_1p) then
		kst_tab_barcode.fila_1p = 999
	end if
	if isnull(kst_tab_barcode.fila_2) then
		kst_tab_barcode.fila_2 = 999
	end if
	if isnull(kst_tab_barcode.fila_2p) then
		kst_tab_barcode.fila_2p = 999
	end if
	kst_tab_barcode.id_meca = this.getitemnumber(1, "id_meca")
	
	kds_kicursor_barcode_1 = create datastore 
	kds_kicursor_barcode_1.dataobject = "ds_barcode_cursor_1"
	kds_kicursor_barcode_1.settransobject(kguo_sqlca_db_magazzino)
	k_righe_curs = kds_kicursor_barcode_1.retrieve(kst_tab_barcode.barcode, kst_tab_barcode.pl_barcode, kst_tab_barcode.id_meca &
																, kst_tab_barcode.fila_1, kst_tab_barcode.fila_1p &
																, kst_tab_barcode.fila_2, kst_tab_barcode.fila_2p)
	
	
	do while k_riga_curs < k_righe_curs 
		k_riga_curs ++
	
	//--- cerco il barcode nella lista dei pianificati	se non sono nella dw dei pianificati
		k_riga_find = 0
	
		kst_tab_barcode.barcode = kds_kicursor_barcode_1.getitemstring(k_riga_curs, "barcode")
		kst_tab_barcode.pl_barcode = kds_kicursor_barcode_1.getitemnumber(k_riga_curs, "pl_barcode")
	
		if isvalid(kidw_barcode_da_NON_modificare) and not isnull(kidw_barcode_da_NON_modificare) then
			k_riga_find = kidw_barcode_da_non_modificare.find("barcode_barcode = '" &
					+ trim(kst_tab_barcode.barcode) + "' ", 1, &
					  kidw_barcode_da_non_modificare.rowcount()) 
		end if
			 
	//--- solo se non ho trovato il barcode 'da NON modificare' allora procedo alla modifica i giri
		if k_riga_find <= 0 then 
			
			kist_tab_barcode.barcode = kds_kicursor_barcode_1.getitemstring(k_riga_curs, "barcode")
	
	//--- aggiorna solo i barcode non ancora associati ad altro PL 
			if kst_tab_barcode.pl_barcode = 0  &
							 or kist_tab_barcode.pl_barcode = kst_tab_barcode.pl_barcode then
				
	//--- AGGIORNA TABELLE									
				if aggiorna_barcode_giri_esegue(kist_tab_barcode) then
	
	//--- modifico i dati nel dw
					if k_riga_selected > 0 then  //09122014
					
						k_record_aggiornati ++
					
						//if ki_modif_tutto_riferimento <> kiuf_barcode_mod_giri.ki_modif_tutto_riferimento_si then
						if this.object.aggiorna_rif[1]  <> "1" then
							kidw_barcode_da_modificare.object.barcode_tipo_cicli.primary[k_riga_selected] = kist_tab_barcode.tipo_cicli
						end if
						kidw_barcode_da_modificare.object.barcode_fila_1.primary[k_riga_selected] = kist_tab_barcode.fila_1 
						kidw_barcode_da_modificare.object.barcode_fila_2.primary[k_riga_selected] = kist_tab_barcode.fila_2 
						kidw_barcode_da_modificare.object.barcode_fila_1p.primary[k_riga_selected] = kist_tab_barcode.fila_1p
						kidw_barcode_da_modificare.object.barcode_fila_2p.primary[k_riga_selected] = kist_tab_barcode.fila_2p
					end if
					
				end if
					
			end if
		end if
	
	loop
	
	if isvalid(kds_kicursor_barcode_1) then destroy kds_kicursor_barcode_1

//		if this.object.aggiorna_righe_selezionate.primary[1]  = "1" then
//			k_riga_selected = kidw_barcode_da_modificare.getselectedrow(k_riga_selected)
//		else
//			k_riga_selected = 0
//		end if
//		
//	end if
//	
//loop while  k_riga_selected > 0 and kst_esito.esito = kkg_esito.ok

	if ki_AGGIORNARE_TABELLE then  // flag di aggiornamento!
//=== Se tutto OK faccio la COMMIT		
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
					
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	
	if kst_esito.esito <> kkg_esito.err_logico then

		if this.object.aggiorna_rif[1] = "0" then
			kst_esito.sqlerrtext = "Fallito Aggiornamento Giri del barcode " + trim(kst_tab_barcode.barcode) & 
									+ " ~n~r" + "(" + trim(kst_esito.sqlerrtext) + ")" 
		else
			kst_esito.sqlerrtext = "Fallito Aggiornamento Riferimento n. " + string(kst_tab_barcode.num_int) & 
									+ " dei giri di lavorazione. " &
									+ " ~n~r" + "(" + trim(kst_esito.sqlerrtext) + ")" 
		end if
		if ki_AGGIORNARE_TABELLE then  // flag di aggiornamento!
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
	end if
	kguo_exception.set_esito(kst_esito)
	kguo_exception.scrivi_log( )
	throw kguo_exception

end try
			

return k_record_aggiornati

end function

on uo_dw_modifica_giri_barcode.create
call super::create
end on

on uo_dw_modifica_giri_barcode.destroy
call super::destroy
end on

event buttonclicked;call super::buttonclicked;//
//
st_esito kst_esito

	
	choose case dwo.name
			
		case "cb_esci"
			event u_exit( )
			
		case "cb_dettaglio"
//=== Dimensiona e Posiziona la dw nella window 
			if this.object.cb_dettaglio.text = "Dettaglio >>" then
				this.object.cb_dettaglio.text = "Nascondi" 
			else
				this.object.cb_dettaglio.text = "Dettaglio >>" 
			end if
			resize()
			
		case "cb_aggiorna"
			this.accepttext()

			//k_riga_1 = this.getrow() 

//--- controllo dati immessi			
			if check_modifica_giri() = 0 then
		
				event u_aggiorna( )
				
			end if
			
		case "cb_ripristina"
			if this.object.cb_ripristina.text = "Salva Valori Ripristinati" then
				
				this.object.cb_ripristina.enabled = "0"

				event u_aggiorna( )
				
			else
				this.object.cb_ripristina.text = "Salva Valori Ripristinati"
				
				event u_rirpristina_valori( )
				
			end if
			

	end choose


end event

event constructor;call super::constructor;//
	kiuf_barcode = create kuf_barcode
	kiuf_barcode_mod_giri = create kuf_barcode_mod_giri
end event

event destructor;call super::destructor;//
if isvalid(kiuf_barcode) then destroy kiuf_barcode
if isvalid(kiuf_barcode_mod_giri) then destroy kiuf_barcode_mod_giri

end event

event itemchanged;call super::itemchanged;//
if dwo.name = "aggiorna_righe_selezionate" then
	
	if data = "1" then
		
		this.post setitem(1, "aggiorna_rif", "0")
		
	end if
	
else
	
	if dwo.name = "aggiorna_rif" then
		if data = "1" then
			
			this.post setitem(1, "aggiorna_righe_selezionate", "0")
			
		end if
		
	end if
	
end if
end event

