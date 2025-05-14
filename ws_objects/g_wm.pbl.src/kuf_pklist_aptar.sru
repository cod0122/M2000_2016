$PBExportHeader$kuf_pklist_aptar.sru
forward
global type kuf_pklist_aptar from kuf_parent
end type
end forward

global type kuf_pklist_aptar from kuf_parent
end type
global kuf_pklist_aptar kuf_pklist_aptar

forward prototypes
public subroutine _readme ()
public function uo_ds_std_1 u_csv_import (string a_file_path_name) throws uo_exception
public function integer u_build_pklist (ref uo_ds_std_1 ads_csv) throws uo_exception
private function integer u_build_pklist_1 (ref uo_ds_std_1 ads_csv) throws uo_exception
end prototypes

public subroutine _readme ();/*
Gestione Cliente APTAR delle packing-list formato xls (csv)
*/
end subroutine

public function uo_ds_std_1 u_csv_import (string a_file_path_name) throws uo_exception;//
integer k_result
string k_file_name
uo_ds_std_1 ads_csv


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

	
	if trim(a_file_path_name) > " " then
		k_result = 1
	else
		k_result = GetFileOpenName("Packig-List da importare", &
									a_file_path_name, k_file_name, "csv", "CSV/TXT File (*.csv;*.txt),*.csv;*.txt", "", 256) 
	end if
	
	if k_result = 0 then 
		kguo_exception.kist_esito.sqlerrtext = "Operazione interrotta dall'utente."
		throw kguo_exception
	end if
	if k_result < 0 then 
		kguo_exception.kist_esito.esito = kkg_esito_no_esecuzione
		kguo_exception.kist_esito.sqlerrtext = "Impossibile selezionare il file '" + a_file_path_name + "'. " &
								+ kkg.acapo + "Codice errore " + string(k_result)
		throw kguo_exception
	end if
	
	ads_csv = create uo_ds_std_1
	ads_csv.dataobject = "d_xls_pklist_aptar"
	
// Importa il file nel DataWindow
	choose case upper(right(trim(a_file_path_name),3)) 
		case 'CSV'
			k_result = ads_csv.ImportFile(CSV!, a_file_path_name, 2, 0, 3)
		case 'TXT'
			k_result = ads_csv.ImportFile(Text!, a_file_path_name, 2, 0, 3)
		case else
			k_result = 99
	end choose

	choose case k_result 
		case -1
			kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
			kguo_exception.kist_esito.sqlerrtext = "Impossibile importare il file '" + a_file_path_name + "'. " &
								+ kkg.acapo + "Codice errore " + string(k_result)
			throw kguo_exception
		case -99
			kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
			kguo_exception.kist_esito.sqlerrtext = "Il file indicato non sembra nel formato corretto, scegliere un 'CSV' o 'TXT'. Operazione Interrotta!" + a_file_path_name + "'. " &
								+ kkg.acapo + "Codice errore " + string(k_result)
			throw kguo_exception
	end choose
	
	kguo_exception.kist_esito.sqlerrtext = "File importato con successo. Righe importate: " + String(k_result)
	kguo_exception.messaggio_utente( )		
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return ads_csv

end function

public function integer u_build_pklist (ref uo_ds_std_1 ads_csv) throws uo_exception;//
integer k_pklist_imported_n
string k_file_name
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
 
 
try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

	if ads_csv.rowcount() > 0 then
		
		k_pklist_imported_n = u_build_pklist_1(ads_csv)
		
	else

		kguo_exception.kist_esito.sqlerrtext = "Elenco righe dati vuoto nessun packing-list da generare. "
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_pklist_imported_n

end function

private function integer u_build_pklist_1 (ref uo_ds_std_1 ads_csv) throws uo_exception;//
integer k_return
integer k_row, k_rows, k_row_new, k_rc
int k_pos
string k_x
string k_batch_number, k_batch_number_old, k_barcode
string k_mc_co, k_sc_cf, k_customerlot, k_ddt_n
datetime k_ddt_date 
uo_ds_std_1 kds_out
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad
kuf_wm_receiptgammarad kuf1_wm_receiptgammarad 
n_string kn_string

 
try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

	kuf1_wm_receiptgammarad = create kuf_wm_receiptgammarad
	kn_string = create n_string

	kds_out = create uo_ds_std_1
	kds_out.dataobject = "ds_receiptgammarad_l"
	kds_out.settransobject(kguo_sqlca_db_magazzino)

	k_rows = ads_csv.RowCount()
	
	FOR k_row = 1 TO k_rows

		k_barcode = trim(ads_csv.getitemstring(k_row, "batch_number")) // composto da 'nnnnnnn'/'barcode cliente' nnnnn=preso come codice packingklist	
		
		k_barcode = kn_string.u_stringa_pulisci_asc(k_barcode)
		
		if k_barcode > " " then
		
			k_batch_number = "X" + left(k_barcode, pos(k_barcode,"/") - 1)
			//k_sub_barcode = trim(mid(k_x, pos(k_x,"/") + 1))
			if k_batch_number <> k_batch_number_old then
				k_batch_number_old = k_batch_number
				
				kst_tab_wm_receiptgammarad.packinglistcode = k_batch_number
				if kuf1_wm_receiptgammarad.if_exists_packinglistcode(kst_tab_wm_receiptgammarad) > 0 then  // se già caricato e in uso lo salta!
					k_ddt_n = ""
				else				
					kuf1_wm_receiptgammarad.tb_delete_x_idwmpklist(kst_tab_wm_receiptgammarad) // Cancella se eventualmente già caricato ma non ancora in uso
					if trim(ads_csv.getitemstring(k_row, "contract_number")) > " " then // se non c'è allora eredita quello delle riga preced.
						k_x = trim(ads_csv.getitemstring(k_row, "contract_number")) // composto da 'e1codanag'_'cod.CO'_'cod.capitolato' 
						k_x = kn_string.u_stringa_pulisci_asc(k_x)
						k_pos = pos(k_x,"_") + 1
						k_mc_co = trim(mid(k_x, k_pos, pos(k_x,"_", k_pos) - k_pos))
						k_pos = pos(k_x,"_", k_pos) + 1   // dal secondo '_'
						k_sc_cf = trim(mid(k_x, k_pos))
					end if
					k_customerlot = trim(ads_csv.getitemstring(k_row, "customer_load_number")) 
					k_customerlot = kn_string.u_stringa_pulisci_asc(k_customerlot)
					k_ddt_n = trim(ads_csv.getitemstring(k_row, "delivery_note")) 
					k_ddt_n = kn_string.u_stringa_pulisci_asc(k_ddt_n)
					k_ddt_date = datetime(ads_csv.getitemdate(k_row, "delivery_note_date"), time(0)) 
				end if
			end if
			
			if k_ddt_n > " " then
				
				k_row_new = kds_out.insertrow(0)
				kds_out.setitem(k_row_new, "id", 0)
				kds_out.setitem(k_row_new, "pathfile", "")
				kds_out.setitem(k_row_new, "nomefile", "")
				kds_out.setitem(k_row_new, "transmissiondate", kguo_g.get_datetime_current())
				kds_out.setitem(k_row_new, "transmissioncode", 0)
						
				kds_out.setitem(k_row_new, "packinglistcode", k_batch_number)
				
				kds_out.setitem(k_row_new, "ordercode", "")
				kds_out.setitem(k_row_new, "orderrow", 0)
				kds_out.setitem(k_row_new, "orderdate", kguo_g.get_datetime_current_local( ))
				
				kds_out.setitem(k_row_new, "ddtcode", k_ddt_n)
				kds_out.setitem(k_row_new, "ddtdate", k_ddt_date)
						
				kds_out.setitem(k_row_new, "palletquantity", 1)
				
				kds_out.setitem(k_row_new, "externalpalletcode", k_barcode)
				
				kds_out.setitem(k_row_new, "customeritem", "")
				kds_out.setitem(k_row_new, "customerlot", k_customerlot)
				
				kds_out.setitem(k_row_new, "dtlotscad", date(0))
				kds_out.setitem(k_row_new, "pltqtalorda", 0)
				kds_out.setitem(k_row_new, "pltqtanetta", 0)
				kds_out.setitem(k_row_new, "pltqtapezzi", 0)
				kds_out.setitem(k_row_new, "pltidpezzo", 0) 
				kds_out.setitem(k_row_new, "quantitasacchi", 0)
				
				kds_out.setitem(k_row_new, "specification", k_sc_cf) // capitolato 
				kds_out.setitem(k_row_new, "contract", k_mc_co) // Conferma Ordine 
				
				kds_out.setitem(k_row_new, "palletlength", 0) 
				kds_out.setitem(k_row_new, "mandatorcustomercode", string(ads_csv.getitemnumber(k_row, "clie_1"))) 
				kds_out.setitem(k_row_new, "receivercustomercode", string(ads_csv.getitemnumber(k_row, "clie_2"))) 
				kds_out.setitem(k_row_new, "invoicecustomercode", string(ads_csv.getitemnumber(k_row, "clie_3"))) 
				
				kds_out.setitem(k_row_new, "accept", "True") 
				kds_out.setitem(k_row_new, "warehouse", "") 
	//			kds_out.setitem(k_row_new, "area_mag_trim", kst_tab_wm_receiptgammarad[k_riga].area_mag_trim) 
				kds_out.setitem(k_row_new, "id_meca", 0) 
				kds_out.setitem(k_row_new, "idwmpklist", 0) 
				kds_out.setitem(k_row_new, "internalpalletcode", "") 
				kds_out.setitem(k_row_new, "note_1", "") 
				kds_out.setitem(k_row_new, "note_2", "")
				kds_out.setitem(k_row_new, "note_3", "")
				kds_out.setitem(k_row_new, "note_4", "")
				kds_out.setitem(k_row_new, "pesolordo", 0) 
				kds_out.setitem(k_row_new, "pesonetto", 0) 
				kds_out.setitem(k_row_new, "quarantine", "") 
				kds_out.setitem(k_row_new, "readed", "False") 
				kds_out.setitem(k_row_new, "receiptdate", kguo_g.get_datetime_current_local( )) 
			//	kds_out.setitem(k_row_new, "registered", kst_tab_wm_receiptgammarad[k_riga].registered) 
				kds_out.setitem(k_row_new, "stored", "0")
				kds_out.setitem(k_row_new, "barcodewo", "0")
				kds_out.setitem(k_row_new, "tipoinvio", "CSV")
			
			end if
		end if

	NEXT

	if k_row_new > 0 then
		k_rc = kds_out.update( )
		if k_rc < 0 then
			kguo_exception.set_st_esito_err_ds(kds_out, "Errore in inserimento nuova Packing-List cliente da file csv, primo batch number: " &
								+ string(trim(ads_csv.getitemstring(1, "batch_number"))))
			kguo_sqlca_db_magazzino.db_rollback( )
			throw kguo_exception	
		end if
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	k_return = k_row_new
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kn_string) then destroy kn_string
	if isvalid(kds_out) then destroy kds_out
	if isvalid(kuf1_wm_receiptgammarad) then destroy kuf1_wm_receiptgammarad
	
	SetPointer(kkg.pointer_default)

end try

return k_return

end function

on kuf_pklist_aptar.create
call super::create
end on

on kuf_pklist_aptar.destroy
call super::destroy
end on

