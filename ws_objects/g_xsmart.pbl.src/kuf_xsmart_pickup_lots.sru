$PBExportHeader$kuf_xsmart_pickup_lots.sru
forward
global type kuf_xsmart_pickup_lots from kuf_parent0
end type
end forward

global type kuf_xsmart_pickup_lots from kuf_parent0
end type
global kuf_xsmart_pickup_lots kuf_xsmart_pickup_lots

forward prototypes
public function st_esito u_batch_run () throws uo_exception
public subroutine _readme ()
public function long get_data_to_export (ref datastore kds_1) throws uo_exception
public function st_esito export_pickup_lots (datastore kds_1) throws uo_exception
public function string get_export_file_name () throws uo_exception
end prototypes

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
int k_ctr
datastore kds_1
st_esito kst_esito


try 

	kst_esito = kguo_exception.inizializza(this.classname())

	kst_esito = export_pickup_lots(kds_1) 
	kst_esito.SQLErrText = "Operazione conclusa." + kst_esito.sqlerrtext

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
	
end try


return kst_esito
end function

public subroutine _readme ();//
// esportazione dati per SMART 
// - dati di ritiro Lotto
//
//--- campi circa il file json passato a SMART
//"giacenza_allert":"SI"                                           SI = scatta l'allarme di superati i giorni di giacenza
//"giacenza_giorni":"7"                                           il numero dei giorni dalla data di rilascio
//"certificate_allegato_data":"2019-10-02"             data del 'Certicate Processing" che è sostanzialmente la data di rilascio del materiale
//"lotto_id":244344              id univoco del Lotto entrato (importato da un packing list)
//"lotto_num":4502              numero del Lotto entrato, in questo caso è univoco nell'anno
//"lotto_data":"2020-06-09"    data del lotto
//"lotto_data_arrivo":"2020-06-12 13:37:56"     data e ora del materiale entrato
//"ddt_mandante_num":"145/LB"             numero del DDT del mandante
//"ddt_mandante_data":"2020-06-09"     data del DDT del mandante
//"colli_entrati":2                colli del Lotto
//"colli_spediti":0                colli già spediti (possono esserci spedizioni del Lotto parziali)
//"mandante_cod":710      codice di M2000 (il gestionale) del mandante del materiale
//"mandante_nome":"BIODUE S.P.A."    nome del mandante del materiale
//"ricevente_cod":710       codice di M2000 (il gestionale) del ricevente (presunto) del materiale trattato
//"ricevente_nome":"BIODUE S.P.A."    nome del ricevente
//"certificate_allegato_num":0        numero dell'allegato al Certificate of Processing - Se maggiore di ZERO allora il materiale è stato Rilasciato e quindi è proprio pronto al Ritiro;
//"pklist_cod":"WWW_710_71170"        nome del packing-list importato
//"pklist_note":"NR. 2 BANCALI CON 13.334 STRIP ALUNEB IPER MONO 1 STR LOTTO 0608"        Note caricate dal cliente nel pklist caricato
//"cliente_cod":710       codice di M2000 (il gestionale) del cliente che sarà poi quello a cui mostrare il RITIRO
//"cliente_nome":"BIODUE S.P.A."    nome del cliente
//
//Tutti i lotti presenti nel file dovranno ricoprire il precedente scarico dello stesso. 

end subroutine

public function long get_data_to_export (ref datastore kds_1) throws uo_exception;//
//--- in caso di esportazione batch get dati da esportare
//
long k_righe=0
st_esito kst_esito


try
	SetPointer(kkg.pointer_attesa)
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if not isvalid(kds_1) then
		kds_1 = create datastore
		kds_1.dataobject = "d_xsmart_instock"
		kds_1.settransobject(kguo_sqlca_db_magazzino)
	end if
	k_righe = kds_1.retrieve()
	if k_righe < 0 then
		kst_esito.sqlcode = k_righe
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlerrtext = "Errore in lettura dati Ritiro Lotti per SMART (" + string(k_righe) + ")"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	SetPointer(kkg.pointer_default)

end try

return k_righe
end function

public function st_esito export_pickup_lots (datastore kds_1) throws uo_exception;//
long k_righe=0
string k_json
st_esito kst_esito
string k_file
long li_rc
long li_FileNum


try
	SetPointer(kkg.pointer_attesa)
	
	kst_esito = kguo_exception.inizializza(this.classname())

	if not isvalid(kds_1) then get_data_to_export(kds_1)

	k_righe = kds_1.rowcount()
	
	if k_righe > 0 then
		k_json = trim(kds_1.exportjson( ))
	end if
	
	if k_json > " " then

		k_file = get_export_file_name()
	
		FileDelete(k_file)
//		li_FileNum = FileOpen(k_file, LineMode!, Write!, LockWrite!, Replace!) //, EncodingUTF8!)
		li_FileNum = FileOpen(k_file, StreamMode!, Write!, LockWrite!, Replace!) //, EncodingUTF8!)
		if li_FileNum > 0 then
			
			li_rc = FileWriteEx(li_FileNum, blob(k_json, EncodingUTF8!)) //k_json)
		
			if li_rc < 0 then
				kst_esito.SQLErrText =  &
					"Errore in scrittura dati di Ritiro Lotti per SMART in formato JSON. "
			else
				kst_esito.SQLErrText =  &
					"Generato archivio con i dati di Ritiro Lotti per SMART in formato JSON. "
			end if

			FileClose(li_FileNum)
			
		else
			kst_esito.SQLErrText =  &
					"Errore in generazione archivio con i dati di Ritiro Lotti per SMART in formato JSON. "
		end if
		kst_esito.SQLErrText += " File: '" + k_file + "'"
		
	else
				 
		kst_esito.SQLErrText = "Nessu dato di Ritiro Lotti per SMART estratto."
	end if

	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	SetPointer(kkg.pointer_default)

end try

return kst_esito
end function

public function string get_export_file_name () throws uo_exception;//
string k_file
kuf_base kuf1_base
st_esito kst_esito


try
	SetPointer(kkg.pointer_attesa)
	
	kst_esito = kguo_exception.inizializza(this.classname())

	string k_esito=""
	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base( "smart_pickup_lots")
	if left(k_esito,1) <> "0" then
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.SQLErrText = mid(k_esito,2)
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	k_file = trim(mid(k_esito,2))
	if k_file > " " then
		if left(trim(k_file), 5) <> ".json" then
			k_file += ".json"
		end if
	else
		kst_esito.esito = kkg_esito.no_esecuzione  
		kst_esito.SQLErrText = "Attenzione, manca percorso e nome file di esportazione dati di Ritiro Lotti (SMART)"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_base) then destroy kuf1_base
	SetPointer(kkg.pointer_default)

end try

return k_file
end function

on kuf_xsmart_pickup_lots.create
call super::create
end on

on kuf_xsmart_pickup_lots.destroy
call super::destroy
end on

