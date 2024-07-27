$PBExportHeader$kuf_pl_barcode_stato.sru
forward
global type kuf_pl_barcode_stato from kuf_parent0
end type
end forward

global type kuf_pl_barcode_stato from kuf_parent0
end type
global kuf_pl_barcode_stato kuf_pl_barcode_stato

forward prototypes
public function st_esito u_batch_run () throws uo_exception
end prototypes

public function st_esito u_batch_run () throws uo_exception;//
long k_rows, k_row, k_id_programma, k_n_update
int k_id_stato
st_esito kst_esito
kuf_pl_barcode kuf1_pl_barcode
ds_pl_barcode_da_elab kds_pl_barcode_da_elab
ds_programmi_richieste_get_id_stato kds_programmi_richieste_get_id_stato
kuf_plav kuf1_plav
st_tab_pl_barcode kst_tab_pl_barcode

try
	SetPointer(kkg.pointer_attesa)
	kst_esito = kguo_exception.inizializza(this.classname())
	
	kuf1_pl_barcode = create kuf_pl_barcode	
	kds_pl_barcode_da_elab = create ds_pl_barcode_da_elab
	kds_programmi_richieste_get_id_stato = create ds_programmi_richieste_get_id_stato
	
	kst_tab_pl_barcode.codice = kuf1_pl_barcode.get_codice_max( )
	if kst_tab_pl_barcode.codice > 50 then
		kst_tab_pl_barcode.codice -= 50
	else
		kst_tab_pl_barcode.codice = 0
	end if
	
	k_rows = kds_pl_barcode_da_elab.retrieve(kst_tab_pl_barcode.codice)
	
	for k_row = 1 to k_rows
		
		kst_tab_pl_barcode.codice = kds_pl_barcode_da_elab.getitemnumber(k_row, "codice")
		kst_tab_pl_barcode.id_programma = kds_pl_barcode_da_elab.getitemnumber(k_row, "id_programma")
		if kst_tab_pl_barcode.id_programma > 0 then
			if kds_programmi_richieste_get_id_stato.retrieve(kst_tab_pl_barcode.id_programma) > 0 then
				k_id_stato = kds_programmi_richieste_get_id_stato.getitemnumber(1, "id_stato")
				
				choose case k_id_stato
					case kuf1_plav.kki_richieste_stato_in_preparazione
						kst_tab_pl_barcode.stato = kuf1_pl_barcode.ki_stato_pl_inelab
					case kuf1_plav.kki_richieste_stato_ricezione_impianto_ko
						kst_tab_pl_barcode.stato = kuf1_pl_barcode.ki_stato_pl_respinto
					case kuf1_plav.kki_richieste_stato_ricezione_impianto_ok
						kst_tab_pl_barcode.stato = kuf1_pl_barcode.ki_stato_pl_consegnato
					case else
						kst_tab_pl_barcode.stato = ""
				end choose
				
				if kst_tab_pl_barcode.stato > " " then 
					if kuf1_pl_barcode.set_stato_pl(kst_tab_pl_barcode) then
						k_n_update ++
					end if
				end if
			end if
		end if
		
	next
	
	kguo_sqlca_db_magazzino.db_commit()
	
	if k_n_update > 0 then
		kst_esito.sqlerrtext = "Sono stati Aggiornati gli STATI di " + string(k_n_update) + " Piani di Lavoro inviati dal codice " + string(kst_tab_pl_barcode.codice)
	else
		kst_esito.sqlerrtext = "Non ci sono valori di Stato da aggiornare sui Piani di Lavoro inviati dal codice " + string(kst_tab_pl_barcode.codice) 
	end if
	
catch (uo_exception kuo_exception)
	kst_esito.sqlerrtext = "Anomalia in ricerca e aggiornamento dgli STATI dei Piani di Lavoro inviati dal codice " + string(kst_tab_pl_barcode.codice) &
				+ kkg.acapo + kuo_exception.kist_esito.sqlerrtext
	kuo_exception.scrivi_log( )
	kguo_sqlca_db_magazzino.db_rollback( )
	throw kuo_exception
	
finally
	if isvalid(kds_pl_barcode_da_elab) then destroy kds_pl_barcode_da_elab
	if isvalid(kuf1_pl_barcode) then destroy kuf1_pl_barcode
	if isvalid(kds_programmi_richieste_get_id_stato) then destroy kds_programmi_richieste_get_id_stato
	
	SetPointer(kkg.pointer_default)
	
end try

return kst_esito
end function

on kuf_pl_barcode_stato.create
call super::create
end on

on kuf_pl_barcode_stato.destroy
call super::destroy
end on

