$PBExportHeader$kuf_asdrackbarcode.sru
forward
global type kuf_asdrackbarcode from kuf_parent
end type
end forward

global type kuf_asdrackbarcode from kuf_parent
end type
global kuf_asdrackbarcode kuf_asdrackbarcode

type variables
//
private string kki_rackcode_pref = "ASD"    // fisso questo prefisso per distinguere i Disp.Ausiliari

//--- flag view v_asd_barcode_all che riporta tutti i barcode 'impegnati' attraverso i groupage al RACK
public constant string kki_linktype_Diretto = "A" // associato direttamente al RACK
public constant string kki_linktype_GRP_Child = "F" // associato al RACK come Figlio di un grp
public constant string kki_linktype_GRP_Father = "P" // associato al RACK come Padre di un grp

end variables

forward prototypes
public subroutine _readme ()
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function boolean u_add_barcode (ref st_tab_asdrackbarcode ast_tab_asdrackbarcode[]) throws uo_exception
public function boolean tb_delete_all_x_id_asdrackcode (ref st_tab_asdrackbarcode ast_tab_asdrackbarcode) throws uo_exception
public function boolean if_add_barcode (st_tab_asdrackbarcode ast_tab_asdrackbarcode) throws uo_exception
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
public function boolean tb_delete_all_x_barcode (ref st_tab_asdrackbarcode ast_tab_asdrackbarcode[]) throws uo_exception
public function boolean tb_delete (ref st_tab_asdrackbarcode ast_tab_asdrackbarcode[]) throws uo_exception
public function boolean if_barcode_same_asddevice (st_tab_asdrackbarcode ast_tab_asdrackbarcode, st_tab_asdrackbarcode ast_tab_asdrackbarcode_1) throws uo_exception
public function boolean if_barcode_is_associated (ref st_tab_asdrackbarcode ast_tab_asdrackbarcode) throws uo_exception
public function boolean if_asddevice_barcode_associated (st_tab_asdrackbarcode ast_tab_asdrackbarcode) throws uo_exception
public function boolean if_barcode_only_existing_father (ref st_tab_asdrackbarcode ast_tab_asdrackbarcode) throws uo_exception
end prototypes

public subroutine _readme ();/*
Associazioni Rack e BARCODE di lavorazione 
*/
end subroutine

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
boolean k_return


try
	kuf_asddevice kuf1_asddevice

	kuf1_asddevice = create kuf_asddevice
	k_return = kuf1_asddevice.if_sicurezza(ast_open_w)

catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally
	if isvalid(kuf1_asddevice) then destroy kuf1_asddevice
	
	
end try


return k_return


end function

public function boolean u_add_barcode (ref st_tab_asdrackbarcode ast_tab_asdrackbarcode[]) throws uo_exception;/*
 Associa alla tabella asdRackBarcode i barcode in tabella
 inp: st_tab_asdrackcode[].id_asdrackcode + barcode
 out: true = aggiunto
 ret: 
*/
boolean k_return
int k_rows, k_row, k_ctr, k_row_rack, k_rows_upd, k_row_upd
st_esito kst_esito
uo_ds_std_1 kuo_ds_std_1
uo_ds_std_1 kuo_ds_std_2
st_tab_asdrackcode kst_tab_asdrackcode, kst_tab_asdrackcode_del
kuf_asdrackcode kuf1_asdrackcode
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	k_rows = UpperBound(ast_tab_asdrackbarcode)
	if k_rows > 0 then
	else
		ast_tab_asdrackbarcode[1].id_asdrackcode = 0
	end if
	if ast_tab_asdrackbarcode[1].id_asdrackcode > 0 and ast_tab_asdrackbarcode[1].barcode > " " then
		
	else
		
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di aggiunta associazione tra Rack e Barcode di trattamento bloccata, manca codice ID Rack del Dispositivo Ausiliario e/o il Barcode" &
											+ " Id Rack " + string(ast_tab_asdrackbarcode[1].id_asdrackcode) &
											+ " Barcode " + string(ast_tab_asdrackbarcode[1].barcode) 
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
		
	// x aggiungere asdrackbarcode
	kuo_ds_std_1 = create uo_ds_std_1
	kuo_ds_std_1.dataobject = "ds_asdrackbarcode"
	kuo_ds_std_1.settransobject(kguo_sqlca_db_magazzino)
	
	// x aggiornare barcode già presenti (fa update)
	kuo_ds_std_2 = create uo_ds_std_1
	kuo_ds_std_2.dataobject = "ds_asdrackbarcode_upd_id_asdrackcode"
	kuo_ds_std_2.settransobject(kguo_sqlca_db_magazzino)

	kuf1_asdrackcode = create kuf_asdrackcode
	kuf1_barcode = create kuf_barcode
	
	if trim(ast_tab_asdrackbarcode[1].x_utente) > " " and date(ast_tab_asdrackbarcode[1].x_datins) > kguo_g.get_datazero() then
	else
		ast_tab_asdrackbarcode[1].x_datins = kGuf_data_base.prendi_x_datins() 		
		ast_tab_asdrackbarcode[1].x_utente = kGuf_data_base.prendi_x_utente() 
	end if
	
	for k_row_rack = 1 to k_rows 

		ast_tab_asdrackbarcode[k_row_rack].x_datins = ast_tab_asdrackbarcode[1].x_datins	
		ast_tab_asdrackbarcode[k_row_rack].x_utente = ast_tab_asdrackbarcode[1].x_utente

		kst_tab_asdrackcode.id_asdrackcode = ast_tab_asdrackbarcode[k_row_rack].id_asdrackcode 

//--- Verifica che il Rackcode non sia già in Lavorazione!
		if kuf1_asdrackcode.if_rackcode_in_lav(kst_tab_asdrackcode) then
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.SQLErrText = "Attenzione il Rack id " + string(ast_tab_asdrackbarcode[k_row_rack].id_asdrackcode) + " è in Lavorazione in Impianto. " &
										+ kkg.acapo + "Associazione al Barcode " + string(ast_tab_asdrackbarcode[k_row_rack].barcode) + " bloccata!" 
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
//--- Verifica che il Barcode non sia già Pianificato!
		kst_tab_barcode.barcode = ast_tab_asdrackbarcode[k_row_rack].barcode
		if kuf1_barcode.if_barcode_in_pl(kst_tab_barcode) then
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.SQLErrText = "Attenzione il Barcode '" + string(ast_tab_asdrackbarcode[k_row_rack].barcode) + "' è già stato messo in Pianificazione. " &
										 + kkg.acapo + "Associazione al Rack in " + string(ast_tab_asdrackbarcode[k_row_rack].id_asdrackcode) + " non consentita!" 
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

//--- NON POSSONO STARCI PIU' ASSOCIAZ. SU UN BARCODE CON LO STESSO DISPOSITIVO -------------------------------
		kuf1_asdrackcode.get_id_asddevice(kst_tab_asdrackcode)  // recupera ID dispositivo
		// verifica che il BARCODE non sia già stato assegnato allo stesso DISPOSITIVO
		if if_asddevice_barcode_associated(ast_tab_asdrackbarcode[k_row_rack]) then 
			// riassegna il barcode al nuovo rack
			k_rows_upd = kuo_ds_std_2.retrieve(ast_tab_asdrackbarcode[k_row_rack].barcode, ast_tab_asdrackbarcode[k_row_rack].id_asdrackcode)
			if k_rows_upd > 0 then // la prma associazione la aggiorno
				kst_tab_asdrackcode_del.id_asdrackcode = kuo_ds_std_2.getitemnumber(1, "id_asdrackcode") 
				kuo_ds_std_2.setitem(1, "id_asdrackcode", ast_tab_asdrackbarcode[k_row_rack].id_asdrackcode) 
				kuo_ds_std_2.setitem(1, "x_datins", ast_tab_asdrackbarcode[k_row_rack].x_datins)
				kuo_ds_std_2.setitem(1, "x_utente", ast_tab_asdrackbarcode[k_row_rack].x_utente)
			// le altre asscociazioni le rimuovo, non devono esserci lo stesso dipositivo più volte sullo stesso barcode
				for k_row_upd = k_rows_upd to 2 step -1
					kuo_ds_std_2.deleterow(k_row_upd)
				next
				k_ctr = kuo_ds_std_2.update( )
				if k_ctr < 1 then
					kst_esito = kuo_ds_std_2.kist_esito
					kst_esito.SQLErrText = "Errore in riassegnazione in tabella associazioni del rackcode del Dispositivo Ausiliario per il Barcode di trattamento (asdrackbarcode) " &
										+ kkg.acapo + "~n~rAssociazione non riassegnata a id Rack " + string(ast_tab_asdrackbarcode[k_row_rack].id_asdrackcode) &
														+ " Barcode di lav. " + string(ast_tab_asdrackbarcode[k_row_rack].barcode) &
										+ kkg.acapo + "Errore: " + trim(kuo_ds_std_2.kist_esito.SQLErrText) &
									   + " (" + kuo_ds_std_2.dataobject + ")"
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				else
					if ast_tab_asdrackbarcode[1].st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_asdrackbarcode[1].st_tab_g_0.esegui_commit) then
						kguo_sqlca_db_magazzino.db_commit( )
					end if
				end if

			end if
//-------------------------------------------------------------------------------------------------------				
		else
		
			k_row = kuo_ds_std_1.insertrow(0)
			kuo_ds_std_1.setitem(k_row, "id_asdrackbarcode", 0)
			kuo_ds_std_1.setitem(k_row, "id_asdrackcode", ast_tab_asdrackbarcode[k_row_rack].id_asdrackcode)
			kuo_ds_std_1.setitem(k_row, "barcode", ast_tab_asdrackbarcode[k_row_rack].barcode)
			kuo_ds_std_1.setitem(k_row, "x_datins", ast_tab_asdrackbarcode[k_row_rack].x_datins)
			kuo_ds_std_1.setitem(k_row, "x_utente", ast_tab_asdrackbarcode[k_row_rack].x_utente)
			
		end if			
	next
	
	k_rows = kuo_ds_std_1.rowcount( )
	if k_rows > 0 then
		k_ctr = kuo_ds_std_1.update( )
		if k_ctr < 1 then
			kst_esito = kuo_ds_std_1.kist_esito
			kst_esito.SQLErrText = "Errore in aggiunta in tabella associazioni tra il codice Rack del Dispositivo Ausiliario e il Barcode di trattamento (asdrackbarcode) id rack " &
											 + kkg.acapo + "Errore: " + trim(kuo_ds_std_1.kist_esito.SQLErrText) &
											 + " (" + kuo_ds_std_1.dataobject + ")"
			for k_ctr = 1 to k_rows 
				kst_esito.SQLErrText += kkg.acapo + "Associazioni non caricate: id Rack " &
											+ string(ast_tab_asdrackbarcode[k_ctr].id_asdrackcode) &
											+ " Barcode " + string(ast_tab_asdrackbarcode[k_ctr].barcode) 
			next
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if

	if ast_tab_asdrackbarcode[1].st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_asdrackbarcode[1].st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	k_return = true
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally
	if isvalid(kuo_ds_std_1) then destroy kuo_ds_std_1
	if isvalid(kuo_ds_std_2) then destroy kuo_ds_std_2
	if isvalid(kuf1_asdrackcode) then destroy kuf1_asdrackcode
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	
end try


return k_return
end function

public function boolean tb_delete_all_x_id_asdrackcode (ref st_tab_asdrackbarcode ast_tab_asdrackbarcode) throws uo_exception;/*
 Cancella tutte le associazione Rack - Barcode x un certo Rack
 inp: st_tab_asdrackbarcode.id_asdrackcode
 out: true = rimosso
 ret: 
*/
boolean k_return
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_asdrackbarcode.id_asdrackcode > 0 then
		
		delete from asdrackbarcode
			where asdrackbarcode.id_asdrackcode = :ast_tab_asdrackbarcode.id_asdrackcode
			using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Cancellazione di tutte le associazione codice Rack del Dispositivo Ausiliario e Barcode di Trattamento (asdrackbarcode) id Rack: " + string(ast_tab_asdrackbarcode.id_asdrackcode) &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = KKG_esito.db_ko
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		k_return = true
		
	else
		
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di cancellazione di tutte le associazione codice Rack del Dispositivo Ausiliario e Barcode di Trattamento bloccata, manca ID del Rack"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

public function boolean if_add_barcode (st_tab_asdrackbarcode ast_tab_asdrackbarcode) throws uo_exception;/*
Verifica se Barcode può essere aggiunto al Rack (diverso da quello indicato negli argomenti)
inp: st_tab_asdrackbarcode.id_asdrackcode (anche a zero) + barcode
rit: true = può sessere aggiunto
*/
boolean k_return
int k_rows
uo_ds_std_1 kds_1


try

	if trim(ast_tab_asdrackbarcode.barcode) > " " then
		
		kds_1 = create uo_ds_std_1
		kds_1.dataobject = "ds_if_barcode_in_rackcode"
		kds_1.settransobject( kguo_sqlca_db_magazzino )
		
		k_rows = kds_1.retrieve(ast_tab_asdrackbarcode.barcode, ast_tab_asdrackbarcode.id_asdrackcode)
		
		//--- se ci sono righe allora si può aggiungere
		if k_rows > 0 then
			
			k_return = true				
				
		else
			
			if k_rows < 0 then
				
				kguo_exception.inizializza(this.classname())
				kguo_exception.kist_esito.esito = kkg_esito.db_ko
				kguo_exception.kist_esito.sqlerrtext = "Errore in Verifica associazione Barcode '" + ast_tab_asdrackbarcode.barcode + "' al Rack (id " &
								+ string(ast_tab_asdrackbarcode.id_asdrackcode) + ") ~n~r " &
								+ kds_1.kist_esito.sqlerrtext + " (" + string(kds_1.kist_esito.sqlcode) + ")"
				throw kguo_exception

			end if
			
		end if
		
	end if
	
catch (uo_exception kuo_exception)
		throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
	
end try

return k_return 

end function

public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception;//------------------------------------------------------------------------------------------------------
//---  Controllo dati utente
//---  inp: datastore con i dati da controllare
//---  out: datastore con  	ads_inp.object.<nome campo>.tag che può valere:
//												0=tutto OK (kkg_esito.ok); 
//												1=errore logico (bloccante) (kkg_esito.ERR_LOGICO); 
//												2=errore forma  (bloccante) (kkg_esito.err_formale);
//												3=dati insufficienti  (bloccante) (kkg_esito.DATI_INSUFF);
//												4=KO ma errore non grave  (NON bloccante) (kkg_esito.DB_WRN);
//---							               	W=OK con degli avvertimenti (NON bloccante) (kkg_esito.DATI_WRN);
//---  rit: 
//---
//---  per errore lancia EXCEPTION anche x i warning
//---
//---  CONSIGLIO DI COPIARE DA QUESTO ESTENDENDO I CONTROLLI
//---
//------------------------------------------------------------------------------------------------------
//
int k_errori = 0
long k_nr_righe
int k_riga
string k_tipo_errore="0", k_type, k_valore
st_esito kst_esito
int k_associato
st_tab_asdrackbarcode kst_tab_asdrackbarcode
//uo_d_std_1 kds_1


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
//	kds_1 = create uo_d_std_1
//	kds_1.dataobject = "ds_asdrackbarcode_x_barcode"
//	kds_1.settransobject( kguo_sqlca_db_magazzino )
	
	k_nr_righe =ads_inp.rowcount()
	k_errori = 0
	k_riga =ads_inp.getnextmodified(0, primary!)

	do while k_riga > 0  and k_errori < 99

		k_associato = ads_inp.getitemnumber(k_riga, "k_associato_rack")
		if k_associato = 1 then // solo quelli da associare
			kst_tab_asdrackbarcode.barcode = ads_inp.getitemstring(k_riga, "barcode")
			kst_tab_asdrackbarcode.id_asdrackcode = ads_inp.getitemnumber(k_riga, "id_asdrackcode")
	
			if not this.if_add_barcode(kst_tab_asdrackbarcode) then
				k_errori ++
				k_tipo_errore="1"      // errore in questo campo: logico
				ads_inp.modify("#1.tag = '" + k_tipo_errore + "' ")
				kst_esito.esito = kkg_esito.ERR_LOGICO
				kst_esito.sqlerrtext += "Barcode '" + trim(kst_tab_asdrackbarcode.barcode) + "' già in Lavorazione, associazione al Rack non possibile! " + "~n~r" 
			end if
		end if
		
		k_riga++
		k_riga = ads_inp.getnextmodified(k_riga, primary!)

	loop

	if k_tipo_errore <> "0"  and k_tipo_errore <> "4" and k_tipo_errore <> kkg_esito.DATI_WRN then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if k_errori > 0 then
		
	end if
	
end try


return kst_esito
 
 
 
end function

public function boolean tb_delete_all_x_barcode (ref st_tab_asdrackbarcode ast_tab_asdrackbarcode[]) throws uo_exception;/*
 Cancella associazioni Rack - Barcode 
 inp: elenco st_tab_asdrackbarcode[].barcode da rimuovere
 out: true = rimosso
 ret: 
*/
boolean k_return
int k_row, k_rows
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())

	k_rows = UpperBound(ast_tab_asdrackbarcode)
	if k_rows > 0 then
	else
		ast_tab_asdrackbarcode[1].barcode = ""
	end if
		
	for k_row = 1 to k_rows 
	
		if ast_tab_asdrackbarcode[k_row].barcode > " " then
			
			delete from asdrackbarcode
				where asdrackbarcode.barcode = :ast_tab_asdrackbarcode[k_row].barcode
				using kguo_sqlca_db_magazzino;
		
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore in Cancellazione associazione Rack del Dispositivo Ausiliario al Barcode di Trattamento (asdrackbarcode): " + trim(ast_tab_asdrackbarcode[k_row].barcode) &
							 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = KKG_esito.db_ko
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
			
	next
		
	k_return = true
			
	if k_rows > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di cancellazione associazione Rack del Dispositivo Ausiliario al Barcode di Trattamento bloccata, manca codice Barcode di Trattamento"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

public function boolean tb_delete (ref st_tab_asdrackbarcode ast_tab_asdrackbarcode[]) throws uo_exception;/*
 Cancella associazione puntuale legame Rack - Barcode 
 inp: elenco st_tab_asdrackbarcode[].id_asdrackbarcode da rimuovere
 out: true = rimosso
 ret: 
*/
boolean k_return
int k_row, k_rows
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())

	k_rows = UpperBound(ast_tab_asdrackbarcode)
	if k_rows > 0 then
	else
		ast_tab_asdrackbarcode[1].id_asdrackbarcode = 0
	end if
		
	for k_row = 1 to k_rows 
	
		if ast_tab_asdrackbarcode[k_row].id_asdrackbarcode > 0 then
			
			delete from asdrackbarcode
				where asdrackbarcode.id_asdrackbarcode = :ast_tab_asdrackbarcode[k_row].id_asdrackbarcode
				using kguo_sqlca_db_magazzino;
		
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore in Cancellazione associazione Rack del Dispositivo Ausiliario al Barcode di Trattamento (asdrackbarcode) (id associazione: " + string(ast_tab_asdrackbarcode[k_row].id_asdrackbarcode) + ") " &
							 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = KKG_esito.db_ko
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
			
	next
		
	k_return = true
			
	if k_rows > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di cancellazione associazione Rack del Dispositivo Ausiliario al Barcode di Trattamento bloccata, manca codice 'id Associazione'"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

public function boolean if_barcode_same_asddevice (st_tab_asdrackbarcode ast_tab_asdrackbarcode, st_tab_asdrackbarcode ast_tab_asdrackbarcode_1) throws uo_exception;/*
Verifica se i due Barcode passati hanno gli stessi device
inp: st_tab_asdrackbarcode.barcode / st_tab_asdrackbarcode.barcode
rit: true = associazioni completate/non necessaria
*/
boolean k_return
int k_rows, k_row, k_row_2, k_rows_2
st_tab_asddevice kst_tab_asddevice
uo_ds_std_1 kds_1
uo_ds_std_1 kds_2


try

	if trim(ast_tab_asdrackbarcode.barcode) > " " &
				and trim(ast_tab_asdrackbarcode_1.barcode) > " " then
		
		kds_1 = create uo_ds_std_1
		kds_1.dataobject = "ds_rackcode_list_per_barcode"   // elenco schermature per il I' barcode
		kds_1.settransobject( kguo_sqlca_db_magazzino )
		k_rows = kds_1.retrieve(ast_tab_asdrackbarcode.barcode)
		
		kds_2 = create uo_ds_std_1
		kds_2.dataobject = "ds_rackcode_list_per_barcode"   // elenco schermature per il II' barcode
		kds_2.settransobject( kguo_sqlca_db_magazzino )
		k_rows_2 = kds_2.retrieve(ast_tab_asdrackbarcode_1.barcode)
		
		//--- se ci sono righe allora verifica
		if k_rows > 0 or k_rows_2 > 0 then
			
			if k_rows = k_rows_2 then // il numero righe (device) deve essere uguale
				
		//--- verifica che i device presenti siano uguali
				for k_row = 1 to k_rows
					kst_tab_asddevice.id_asddevice = kds_1.getitemnumber( k_row, "id_asddevice")
					if kst_tab_asddevice.id_asddevice = 0 then
						exit
					else
						if kds_2.find("id_asddevice = " + string(kst_tab_asddevice.id_asddevice), 1, k_rows_2) = 0 then
							exit
						end if
					end if
				next
			
				if k_row > k_rows then
					k_return = true	//OK stessi dispositivi presenti!
				end if
			end if			
		else
			
			if k_rows = 0 and k_rows_2 = 0 then
			
				k_return = true	//OK nessun dispositivo necessario

			else				
				kguo_exception.inizializza(this.classname())
				kguo_exception.kist_esito.esito = kkg_esito.db_ko
				kguo_exception.kist_esito.sqlerrtext = "Errore, Sembra che il Barcode '" + ast_tab_asdrackbarcode.barcode + "' e " &
				            + "il Barcode '" + ast_tab_asdrackbarcode_1.barcode + "' non abbiano assegnati gli stessi Dispositivi Ausiliari ~n~r " &
								+ kds_1.kist_esito.sqlerrtext + " (" + string(kds_1.kist_esito.sqlcode) + ")"
				throw kguo_exception

			end if
			
		end if
		
	end if
	
catch (uo_exception kuo_exception)
		throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
	if isvalid(kds_2) then destroy kds_2
	
end try

return k_return 

end function

public function boolean if_barcode_is_associated (ref st_tab_asdrackbarcode ast_tab_asdrackbarcode) throws uo_exception;/*
Vericifica se Barcode richiede la schemature e queste sono associate
inp: st_tab_asdrackbarcode.barcode
out: torna solo uno dei ID rack associati (ce ne possono essere altri)
rit: true = associazioni completate/non necessaria
*/
boolean k_return
int k_rows, k_row
uo_ds_std_1 kds_1


try

	if trim(ast_tab_asdrackbarcode.barcode) > " " then
		
		kds_1 = create uo_ds_std_1
		kds_1.dataobject = "ds_rackcode_list_per_barcode"   // elenco schermature per barcode
		kds_1.settransobject( kguo_sqlca_db_magazzino )
		
		k_rows = kds_1.retrieve(ast_tab_asdrackbarcode.barcode)
		
		//--- se ci sono righe allora verifica se il barcode è associato
		if k_rows > 0 then
			
			for k_row = 1 to k_rows
				ast_tab_asdrackbarcode.id_asdrackcode = kds_1.getitemnumber( k_row, "id_asdrackcode")
				ast_tab_asdrackbarcode.id_asdrackbarcode = kds_1.getitemnumber( k_row, "id_asdrackbarcode")
				if ast_tab_asdrackbarcode.id_asdrackbarcode > 0 then
				else
					k_row = 0
					exit
				end if
			next
			
			if k_row >= k_rows then
				k_return = true	//asociazioni completate
			end if
				
		else
			
			if k_rows = 0 then
				
				k_return = true	//non necessaria

			else				
				kguo_exception.inizializza(this.classname())
				kguo_exception.kist_esito.esito = kkg_esito.db_ko
				kguo_exception.kist_esito.sqlerrtext = "Errore in Verifica associazione Barcode '" + ast_tab_asdrackbarcode.barcode + "' ai Rack " + kkg.acapo &
								+ kds_1.kist_esito.sqlerrtext + " (" + string(kds_1.kist_esito.sqlcode) + ")"
				throw kguo_exception

			end if
			
		end if
		
	end if
	
catch (uo_exception kuo_exception)
		throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
	
end try

return k_return 

end function

public function boolean if_asddevice_barcode_associated (st_tab_asdrackbarcode ast_tab_asdrackbarcode) throws uo_exception;/*
Verifica se Barcode e già stato associato al ID Dispositivo attraverso il id_asdrackcode
inp: st_tab_asdrackbarcode.id_asdrackcode (di confronto) + barcode
rit: true = già assegnato
*/
boolean k_return
int k_rows
uo_ds_std_1 kds_1


try

	if trim(ast_tab_asdrackbarcode.barcode) > " " and ast_tab_asdrackbarcode.id_asdrackcode > 0 then
		
		kds_1 = create uo_ds_std_1
		kds_1.dataobject = "ds_if_asddevice_barcode_associated"
		kds_1.settransobject( kguo_sqlca_db_magazzino )
		
		k_rows = kds_1.retrieve(ast_tab_asdrackbarcode.barcode, ast_tab_asdrackbarcode.id_asdrackcode)
		
		//--- se ci sono righe allora si può aggiungere
		if k_rows > 0 then
			
			k_return = true				
				
		else
			
			if k_rows < 0 then
				
				kguo_exception.inizializza(this.classname())
				kguo_exception.kist_esito.esito = kkg_esito.db_ko
				kguo_exception.kist_esito.sqlerrtext = "Errore in Verifica associazione Barcode '" + ast_tab_asdrackbarcode.barcode + "' al Rack (id " &
								+ string(ast_tab_asdrackbarcode.id_asdrackcode) + ") ~n~r " &
								+ kds_1.kist_esito.sqlerrtext + " (" + string(kds_1.kist_esito.sqlcode) + ")"
				throw kguo_exception

			end if
			
		end if
		
	end if
	
catch (uo_exception kuo_exception)
		throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
	
end try

return k_return 

end function

public function boolean if_barcode_only_existing_father (ref st_tab_asdrackbarcode ast_tab_asdrackbarcode) throws uo_exception;/*
Verifica se il Barcode è il solo padre del Rackcode, non più di uno
inp: st_tab_asdrackbarcode.barcode
out: torna solo uno dei ID rack associati (ce ne possono essere altri)
rit: true = è ok il solo padre
*/
boolean k_return
int k_rows, k_row
uo_ds_std_1 kds_1


try

	if trim(ast_tab_asdrackbarcode.barcode) > " " then
		
		kds_1 = create uo_ds_std_1
		kds_1.dataobject = "ds_rackcode_list_per_barcode_padre_no_lav"   // elenco schermature per barcode padre, ce ne deve essere solo UNO!
		kds_1.settransobject( kguo_sqlca_db_magazzino )
		
		k_rows = kds_1.retrieve(ast_tab_asdrackbarcode.barcode)
		
		//--- se ci sono più righe allora KO! 
		if k_rows > 1 then
			
			// catturo un barcode (diverso da quello passato) pe comunicarlo in out
			for k_row = 1 to k_rows
				if trim(ast_tab_asdrackbarcode.barcode) <> trim(kds_1.getitemstring(k_row, "barcode")) then
					ast_tab_asdrackbarcode.barcode = kds_1.getitemstring( k_row, "barcode")
					ast_tab_asdrackbarcode.id_asdrackcode = kds_1.getitemnumber( k_row, "id_asdrackcode")
					exit
				end if
			next
			
				
		else
			
			if k_rows < 0 then
				kguo_exception.inizializza(this.classname())
				kguo_exception.kist_esito.esito = kkg_esito.db_ko
				kguo_exception.kist_esito.sqlerrtext = "Errore in Verifica associazioni Barcode '" + ast_tab_asdrackbarcode.barcode + "' ai Rack se presente su più 'padri'" &
								+ kkg.acapo + kds_1.kist_esito.sqlerrtext + " (" + string(kds_1.kist_esito.sqlcode) + ")"
				throw kguo_exception
			end if
				
			k_return = true  // OK non c'è più di 1 padre 
			
		end if
		
	end if
	
catch (uo_exception kuo_exception)
		throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
	
end try

return k_return 

end function

on kuf_asdrackbarcode.create
call super::create
end on

on kuf_asdrackbarcode.destroy
call super::destroy
end on

