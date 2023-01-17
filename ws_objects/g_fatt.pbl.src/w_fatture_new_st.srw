$PBExportHeader$w_fatture_new_st.srw
forward
global type w_fatture_new_st from w_g_tab_st
end type
end forward

global type w_fatture_new_st from w_g_tab_st
string title = "Stampa Documenti di Vendita"
end type
global w_fatture_new_st w_fatture_new_st

type variables
//
ds_fatture kids_fatture

end variables

forward prototypes
protected subroutine stampa ()
protected subroutine open_start_window ()
private subroutine popola_ds_da_lista ()
private subroutine popola_lista_da_ds ()
end prototypes

protected subroutine stampa ();//--
//--- Lancia Aggiornamento e Stampa delle fatture 
//---
long k_riga_fatture
int k_nr_fatture=0
kuf_fatt kuf1_fatt
st_tab_arfa kst_tab_arfa[]
st_esito kst_esito
uo_exception kuo1_exception
pointer kpointer


kpointer = setpointer(hourglass!)

kuf1_fatt = create kuf_fatt
kuo1_exception = create uo_exception

try 
	popola_ds_da_lista()

//--- Aggiornamento Tabelle se NON di PROVA	ovvero ELAB. DEFINITIVA
	if rb_definitiva.checked then
	
		if kids_fatture.rowcount() > 0 then
			for k_riga_fatture = 1 to kids_fatture.rowcount()
				kst_tab_arfa[k_riga_fatture].NUM_FATT = kids_fatture.object.NUM_FATT[k_riga_fatture]
				kst_tab_arfa[k_riga_fatture].DATA_FATT = kids_fatture.object.DATA_FATT[k_riga_fatture]
				kst_tab_arfa[k_riga_fatture].id_fattura = kids_fatture.object.id_fattura[k_riga_fatture]
			next
//		end if
	
//--- aggiorna dati documento a fine stampa 
			if cbx_aggiorna_stato.checked then
			
				kuf1_fatt.produci_fattura_aggiorna(kst_tab_arfa[])

			end if
		
////--- aggiorna tabelle tipo PROFIS 		
//			if cbx_update_profis.checked then
//				kst_esito = kuf1_fatt.aggiorna_tabelle_profis(kst_tab_arfa[])
//				if kst_esito.esito = kkg_esito.db_ko then
//					kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
//					kguo_exception.set_esito( kst_esito )
//				end if
//			end if

//--- aggiorna tabelle tipo SCADENZE....		
			if cbx_update_tab_varie.checked then
				kst_esito = kuf1_fatt.aggiorna_tabelle_correlate(kst_tab_arfa[])
				if kst_esito.esito = kkg_esito.db_ko then
					kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
					kguo_exception.set_esito( kst_esito )
				end if
			end if
		
		end if   // kids_fatture.rowcount() = 0
		
	end if

//--- STAMPA se richiesto esplicitamente oppure se EMISSIONE di PROVA!!! 	
	if rb_modo_stampa_s.checked or not rb_definitiva.checked then
	
		k_nr_fatture = kuf1_fatt.stampa_fattura (kids_fatture)
	
		if k_nr_fatture = 0 then
			kuo1_exception.set_tipo(kuo1_exception.KK_st_uo_exception_tipo_non_eseguito )
			kuo1_exception.setmessage(" Nessun documento Stampato ")
		else
			kuo1_exception.set_tipo(kuo1_exception.kk_st_uo_exception_tipo_ok )
			if k_nr_fatture = 1 then
				kuo1_exception.setmessage("Fine elaborazione, 1 documento stampato")
			else
				kuo1_exception.setmessage("Fine elaborazione, " + string(k_nr_fatture) + " documenti stampati")
			end if
		end if
	end if
	
//--- PDF!!!
	if not rb_modo_stampa_s.checked then
		
		k_nr_fatture = kuf1_fatt.stampa_fattura_digitale (kids_fatture)
		
		if k_nr_fatture = 0 then
			kuo1_exception.set_tipo(kuo1_exception.KK_st_uo_exception_tipo_non_eseguito )
			kuo1_exception.setmessage(" Nessun documento digitalizzato ")
		else
			kuo1_exception.set_tipo(kuo1_exception.kk_st_uo_exception_tipo_ok )
			if k_nr_fatture = 1 then
				kuo1_exception.setmessage("Fine elaborazione, 1 documento digitale emesso")
			else
				kuo1_exception.setmessage("Fine elaborazione, " + string(k_nr_fatture) + " documenti digitali emessi")
			end if
		end if
	
	end if
		
	kuo1_exception.messaggio_utente( )
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	destroy kuf1_fatt
	destroy kuo1_exception
	
	setpointer(kpointer)
	
//--- se richiesto ed elenco vuoto esce dalla funzione	
	if cbx_chiude.checked then
		cb_ritorna.event clicked( )
	end if
	
end try


end subroutine

protected subroutine open_start_window ();//---
//
string k_rcx=""
pointer kpointer_orig
kuf_fatt kuf1_fatt




try 
	ki_st_open_w.flag_modalita = kkg_flag_modalita.stampa
	
	kpointer_orig = setpointer(hourglass!)

	kids_fatture = create ds_fatture

	if isvalid(ki_st_open_w.key12_any) then 
		kids_fatture = ki_st_open_w.key12_any   //--- argomento ds_fattura
	end if
		
//--- pone i link nel dw
	u_personalizza_dw()

	if kids_fatture.rowcount() = 0 then

		kuf1_fatt = create kuf_fatt
		kuf1_fatt.get_fatture_da_stampare(kids_fatture)
			
	end if
	
	popola_lista_da_ds()
	
	if isvalid(kids_fatture) then destroy kids_fatture
	
	kids_fatture = create ds_fatture

	dw_documenti.visible = true
	dw_documenti.setfocus()
	
//	attiva_tasti( )

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		this.postevent(close!)

	finally
		if isvalid(kuf1_fatt) then destroy kuf1_fatt
		
		setpointer(kpointer_orig)	
		
end try


end subroutine

private subroutine popola_ds_da_lista ();//---
//--- riempie la  ds_fatture  da dw di elenco
//---
long k_riga, k_riga_ds
string k_diprova
kuf_fatt kuf1_fatt
st_tab_arfa kst_tab_arfa
st_tab_clienti kst_tab_clienti
st_esito kst_esito


kids_fatture.reset()
kuf1_fatt = create kuf_fatt

if rb_prova.checked then 
	k_diprova = kuf1_fatt.kki_stampa_diProva_si 
else
	k_diprova = kuf1_fatt.kki_stampa_diProva_no
end if

for k_riga = 1 to dw_documenti.rowcount()


	kst_tab_arfa.num_fatt = dw_documenti.getitemnumber(k_riga, "num_fatt")
	kst_tab_arfa.data_fatt = dw_documenti.getitemdate(k_riga, "data_fatt")
	kst_tab_arfa.id_fattura = dw_documenti.getitemnumber(k_riga, "id_fattura")

	if kst_tab_arfa.id_fattura = 0 or isnull(kst_tab_arfa.id_fattura) then
		kuf1_fatt.get_id(kst_tab_arfa)	// trova l'id della fattura
	end if
	kuf1_fatt.get_modo_stampa(kst_tab_arfa)	// torna il campo mod_stampa per capire se pdf
	
	if kst_tab_arfa.num_fatt > 0 then

//--- solo i documenti selezionati
		if rb_emissione_selezione.checked then
			
			if (dw_documenti.getitemnumber(k_riga, "sel")) = 1 then

				if (rb_modo_stampa_s.checked and kst_tab_arfa.modo_stampa = kuf1_fatt.kki_modo_stampa_cartaceo) &
							or (rb_modo_stampa_s.checked and not rb_definitiva.checked) &  
							or (rb_modo_stampa_e.checked and kst_tab_arfa.modo_stampa = kuf1_fatt.kki_modo_stampa_digitale) &
							or (kst_tab_arfa.modo_stampa = kuf1_fatt.kki_modo_stampa_cartedig) then

							
					k_riga_ds = kids_fatture.insertrow(0)
					kids_fatture.setitem(k_riga_ds,"num_fatt", kst_tab_arfa.num_fatt)
					kids_fatture.setitem(k_riga_ds,"data_fatt", kst_tab_arfa.data_fatt)
					kids_fatture.setitem(k_riga_ds,"id_fattura", kst_tab_arfa.id_fattura )
					kids_fatture.setitem(k_riga_ds,"modo_stampa", kst_tab_arfa.modo_stampa )
	//				kids_fatture.setitem(k_riga_ds,"data_stampa", kst_tab_arfa.data_stampa )
					kids_fatture.setitem(k_riga_ds,"prof", dw_documenti.getitemnumber(k_riga, "prof"))
					kids_fatture.setitem(k_riga_ds,"diprova", k_diprova)
					kids_fatture.setitem(k_riga_ds,"sel", 1)
					kids_fatture.setitem(k_riga_ds,"esporta", "")
				end if
			end if
			
		else
			
			if (rb_modo_stampa_s.checked and kst_tab_arfa.modo_stampa = kuf1_fatt.kki_modo_stampa_cartaceo) &
							or (rb_modo_stampa_s.checked and not rb_definitiva.checked) &  
							or ( rb_modo_stampa_e.checked and kst_tab_arfa.modo_stampa = kuf1_fatt.kki_modo_stampa_digitale) &
							or (kst_tab_arfa.modo_stampa = kuf1_fatt.kki_modo_stampa_cartedig) then
							
				k_riga_ds = kids_fatture.insertrow(0)
				kids_fatture.setitem(k_riga_ds,"num_fatt", kst_tab_arfa.num_fatt)
				kids_fatture.setitem(k_riga_ds,"data_fatt", kst_tab_arfa.data_fatt)
				kids_fatture.setitem(k_riga_ds,"id_fattura", kst_tab_arfa.id_fattura )
				kids_fatture.setitem(k_riga_ds,"modo_stampa", kst_tab_arfa.modo_stampa )
	//			kids_fatture.setitem(k_riga_ds,"data_stampa", kst_tab_arfa.data_stampa)
				kids_fatture.setitem(k_riga_ds,"prof", dw_documenti.getitemnumber(k_riga, "prof"))
				kids_fatture.setitem(k_riga_ds,"diprova", k_diprova)
				kids_fatture.setitem(k_riga_ds,"esporta", "")
			
				if (dw_documenti.getitemnumber(k_riga, "sel")) = 0 then
					kids_fatture.setitem(k_riga_ds,"sel", 0)
				else
					kids_fatture.setitem(k_riga_ds,"sel", 1)
				end if
				
			end if			
		end if			
	end if		
	
end for

destroy kuf1_fatt


end subroutine

private subroutine popola_lista_da_ds ();//---
//--- riempie la dw da oggetto ds_fatture
//---
long k_riga, k_riga_ins
st_tab_arfa kst_tab_arfa
st_tab_clienti kst_tab_clienti
st_tab_prof kst_tab_prof
kuf_fatt kuf1_fatt
kuf_clienti kuf1_clienti
kuf_prof kuf1_prof 
st_esito kst_esito
pointer kpointer_orig


kpointer_orig = setpointer(hourglass!)

kuf1_fatt = create kuf_fatt
kuf1_clienti = create kuf_clienti
kuf1_prof = create kuf_prof

for k_riga = 1 to kids_fatture.rowcount()

	k_riga_ins = dw_documenti.insertrow(0)

	kst_tab_arfa.num_fatt = kids_fatture.getitemnumber(k_riga, "num_fatt")
	kst_tab_arfa.data_fatt = kids_fatture.getitemdate(k_riga, "data_fatt")
	kst_tab_arfa.id_fattura = kids_fatture.getitemnumber(k_riga, "id_fattura")
	kst_tab_arfa.modo_stampa = kids_fatture.getitemstring(k_riga, "modo_stampa")
	
	if (kids_fatture.getitemnumber(k_riga, "sel")) = 0 then
		dw_documenti.setitem(k_riga_ins,"sel", 0)
	else
		dw_documenti.setitem(k_riga_ins,"sel", 1)
	end if
		
	dw_documenti.setitem(k_riga_ins,"num_fatt", kst_tab_arfa.num_fatt)
	dw_documenti.setitem(k_riga_ins,"data_fatt", kst_tab_arfa.data_fatt)
	dw_documenti.setitem(k_riga_ins,"id_fattura", kst_tab_arfa.id_fattura)
	dw_documenti.setitem(k_riga_ins,"modo_stampa", kst_tab_arfa.modo_stampa)
	kst_tab_prof.num_fatt = kst_tab_arfa.num_fatt
	kst_tab_prof.data_fatt = kst_tab_arfa.data_fatt
	try 
		if kuf1_prof.if_fattura_presente( kst_tab_prof ) = kuf1_prof.kki_fattura_in_profis_si then
			dw_documenti.setitem(k_riga_ins,"prof", 1) //kids_fatture.getitemnumber(k_riga, "prof"))
		else
			dw_documenti.setitem(k_riga_ins,"prof", 0)		
		end if
	catch ( uo_exception kuo_exception)
		dw_documenti.setitem(k_riga_ins,"prof", 2)		
	finally 
	end try
	
//--- se non c'e' piglio l'ID_FATTURA
	if kst_tab_arfa.id_fattura > 0 then
	else
		kst_esito = kuf1_fatt.get_id( kst_tab_arfa )
		if kst_esito.esito <> kkg_esito.ok then
			kst_tab_arfa.id_fattura = 0
		end if
	end if
//--- piglia data stampa			
	if kst_tab_arfa.id_fattura > 0 then
		kst_esito = kuf1_fatt.get_data_stampa( kst_tab_arfa )
		if kst_esito.esito = kkg_esito.ok then
			dw_documenti.setitem(k_riga_ins,"data_stampa", kst_tab_arfa.data_stampa)
		end if
	end if
 



	kst_esito = kuf1_fatt.get_cliente( kst_tab_arfa )
	if kst_esito.esito = kkg_esito.ok then
		dw_documenti.setitem(k_riga_ins,"clie_3", kst_tab_arfa.clie_3)
	
		kst_tab_clienti.codice = kst_tab_arfa.clie_3
		kst_esito = kuf1_clienti.leggi_rag_soc( kst_tab_clienti )
		if kst_esito.esito = kkg_esito.ok then
			dw_documenti.setitem(k_riga_ins,"rag_soc_10", trim(kst_tab_clienti.rag_soc_10+kst_tab_clienti.rag_soc_11))
			dw_documenti.setitem(k_riga_ins,"loc_10", trim(kst_tab_clienti.loc_1))
			dw_documenti.setitem(k_riga_ins,"nazione", trim(kst_tab_clienti.id_nazione_1))
		else
			dw_documenti.setitem(k_riga_ins,"rag_soc_10", "***non trovato***")
		end if
	else
		dw_documenti.setitem(k_riga_ins,"clie_3", 0)
	end if
		
		
end for

destroy kuf1_prof
destroy kuf1_fatt 
destroy kuf1_clienti 

setpointer(kpointer_orig)  


end subroutine

on w_fatture_new_st.create
call super::create
end on

on w_fatture_new_st.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_g_tab_st`st_ritorna within w_fatture_new_st
end type

type st_ordina_lista from w_g_tab_st`st_ordina_lista within w_fatture_new_st
end type

type st_aggiorna_lista from w_g_tab_st`st_aggiorna_lista within w_fatture_new_st
end type

type cb_ritorna from w_g_tab_st`cb_ritorna within w_fatture_new_st
end type

type st_stampa from w_g_tab_st`st_stampa within w_fatture_new_st
end type

type rb_emissione_tutto from w_g_tab_st`rb_emissione_tutto within w_fatture_new_st
end type

type rb_emissione_selezione from w_g_tab_st`rb_emissione_selezione within w_fatture_new_st
end type

type rb_definitiva from w_g_tab_st`rb_definitiva within w_fatture_new_st
end type

event clicked;//
if this.checked then
	
	cbx_update_tab_varie.enabled = true
	cbx_aggiorna_stato.enabled = true
	cbx_update_profis.enabled = true
	
end if
end event

type rb_prova from w_g_tab_st`rb_prova within w_fatture_new_st
end type

event clicked;//
if this.checked then
	
	cbx_update_tab_varie.enabled = false
	cbx_update_profis.enabled = false
	cbx_aggiorna_stato.enabled = false
	
end if
end event

type pb_ok from w_g_tab_st`pb_ok within w_fatture_new_st
end type

type dw_documenti from w_g_tab_st`dw_documenti within w_fatture_new_st
end type

event getfocus;call super::getfocus;//
kidw_selezionata = this

end event

type cbx_aggiorna_stato from w_g_tab_st`cbx_aggiorna_stato within w_fatture_new_st
end type

type cbx_update_profis from w_g_tab_st`cbx_update_profis within w_fatture_new_st
end type

type st_1 from w_g_tab_st`st_1 within w_fatture_new_st
integer x = 361
integer y = 1644
end type

type cbx_update_tab_varie from w_g_tab_st`cbx_update_tab_varie within w_fatture_new_st
end type

type rb_modo_stampa_e from w_g_tab_st`rb_modo_stampa_e within w_fatture_new_st
end type

type rb_modo_stampa_s from w_g_tab_st`rb_modo_stampa_s within w_fatture_new_st
end type

type cbx_chiude from w_g_tab_st`cbx_chiude within w_fatture_new_st
integer y = 1452
integer width = 1129
string text = "Esce al termine dell~'emissione documenti"
end type

type gb_aggiorna from w_g_tab_st`gb_aggiorna within w_fatture_new_st
end type

type gb_emissione from w_g_tab_st`gb_emissione within w_fatture_new_st
end type

type gb_produzione from w_g_tab_st`gb_produzione within w_fatture_new_st
end type

