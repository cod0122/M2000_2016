$PBExportHeader$kuf_plav.sru
forward
global type kuf_plav from kuf_parent0
end type
end forward

global type kuf_plav from kuf_parent0
end type
global kuf_plav kuf_plav

type variables
//
private st_tab_plav_conn_cfg kist_tab_plav_conn_cfg

//--- valori della colonna id_impianto
public constant string kki_id_impianto_G2 = "G2"
public constant string kki_id_impianto_G3 = "G3"
//--- valori della colonna id_modo impianto G3
public constant string kki_id_modo_G3_4pass = "01"
public constant string kki_id_modo_G3_2pass = "02"
//--- valori della colonna id_accessorio
public constant string kki_id_accessorio_DOSIMETRO = "D"
public constant string kki_id_accessorio_CONTROCAMPIONE = "C"
public constant string kki_id_accessorio_SCHERMATURA = "S"

//--- valori della colonna richieste.stato 
public constant int kki_richieste_stato_IN_PREPARAZIONE = 1
public constant int kki_richieste_stato_PRONTA = 2
public constant int kki_richieste_stato_IN_RICEZIONE_IMPIANTO = 5
public constant int kki_richieste_stato_RICEZIONE_IMPIANTO_OK = 6
public constant int kki_richieste_stato_RICEZIONE_IMPIANTO_KO = 9

//--- valori della colonna richieste.Tipo_Richiesta 
public constant int kki_richieste_tipo_richiesta_NUOVO = 1
public constant int kki_richieste_tipo_richiesta_NUOVO_PRIMADELBARCODE = 2
public constant int kki_richieste_tipo_richiesta_SOSTITUZIONE = 3
public constant int kki_richieste_tipo_richiesta_PULISCI = 99




end variables

forward prototypes
public function integer job_genera_piano_lavoro () throws uo_exception
private function boolean job_genera_piano_lavoro_esegui (ref st_tab_pl_barcode ast_tab_pl_barcode) throws uo_exception
public function st_esito u_batch_run () throws uo_exception
private function long u_pilota_programmi_richieste (ref st_tab_programmi ast_tab_programmi) throws uo_exception
private function long u_pilota_programmi_work_orders (st_tab_programmi ast_tab_programmi, st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception
private function integer u_pilota_programmi_dettaglio_g2 (st_tab_programmi ast_tab_programmi, ref ds_pl_barcode ads_pl_barcode) throws uo_exception
private function integer u_pilota_programmi_groupage (st_tab_programmi ast_tab_programmi, ref ds_pl_barcode ads_pl_barcode) throws uo_exception
private function long u_pilota_programmi_accessori_dosimetri (st_tab_programmi ast_tab_programmi, ref ds_pl_barcode ads_pl_barcode) throws uo_exception
public function boolean job_sostituzione_piano_lavoro (ds_pl_barcode ads_pl_barcode) throws uo_exception
end prototypes

public function integer job_genera_piano_lavoro () throws uo_exception;/*
   Generazione Nuovo Piano di Lavorazione per il Pilota
   Out: Numero Richieste evase
*/

int k_return
long k_row, k_rows
uo_ds_std_1 kds_pl_da_inviare
st_tab_pilota_queue kst_tab_pilota_queue   // da aggiornare quando ho il DB PILOTA NUOVO
kuf_pilota_cmd kuf1_pilota_cmd             // da aggiornare quando ho il DB PILOTA NUOVO
st_tab_pl_barcode kst_tab_pl_barcode, kst_tab_pl_barcode_clear
kuf_pl_barcode kuf1_pl_barcode
st_tab_plav_conn_cfg kst_tab_plav_conn_cfg
kuf_plav_conn_cfg kuf1_plav_conn_cfg
uo_exception kuo1_exception


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
//--- Connessione Bloccata?
	kuf1_plav_conn_cfg = create kuf_plav_conn_cfg
	kuf1_plav_conn_cfg.get_plav_conn_cfg(kst_tab_plav_conn_cfg)
	if kuf1_plav_conn_cfg.if_conn_bloccata(kst_tab_plav_conn_cfg) then
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlerrtext = "Connessione al DB '" + kguo_sqlca_db_plav.ki_title_id + "' " &
													+ kguo_sqlca_db_plav.ki_db_descrizione + " è Bloccata. " &
													+ kkg.acapo + "Per proseguire, l'operazione di Generazione nuovo Piano da inviare al Pilota, disattivare il blocco in Proprietà della Connessione. " 
		throw kguo_exception
	end if		
		
	kuf1_pl_barcode = create kuf_pl_barcode

//--- Verifica se c'e' un nuovo Piano da Inviare al Pilota (STATO_PL=CHIUSO)
	kds_pl_da_inviare = kuf1_pl_barcode.get_pl_barcode_da_inviare_g2g3(7) 
	if isvalid(kds_pl_da_inviare) and kds_pl_da_inviare.rowcount( ) > 0 then
		k_rows = kds_pl_da_inviare.rowcount()

		try 
			for k_row = 1 to k_rows
				kst_tab_pl_barcode = kst_tab_pl_barcode_clear
			
				kst_tab_pl_barcode.codice = kds_pl_da_inviare.getitemnumber(k_row, "codice") 
				
				if kst_tab_pl_barcode.codice > 0 then	
	
	//--- Imposta la STATO in elaborazione così da evitare che sia riutilizzato
					kst_tab_pl_barcode.stato_pl = kuf1_pl_barcode.ki_stato_pl_inelab
					kst_tab_pl_barcode.id_programma = 0
					kst_tab_pl_barcode.st_tab_g_0.esegui_commit = "S"
					kuf1_pl_barcode.set_pl_barcode_stato_pl_id_programma(kst_tab_pl_barcode) 
	
		//--- Se indicato come PL URGENTE allora valorizza "prima_del_barcode' preso dal DB del PILOTA VECCHIO!!!!!!!!
					if kuf1_pl_barcode.if_pl_barcode_priorita_urgente(kst_tab_pl_barcode) then
						kuf1_pilota_cmd = create kuf_pilota_cmd
						kst_tab_pilota_queue=kuf1_pilota_cmd.get_pilota_pilota_barcode_h_primo_queue()
						kst_tab_pl_barcode.prima_del_barcode = kst_tab_pilota_queue.barcode
					end if
					if trim(kst_tab_pl_barcode.prima_del_barcode) > " " then
					else
						kst_tab_pl_barcode.prima_del_barcode = trim(kds_pl_da_inviare.getitemstring(k_row, "prima_del_barcode")) // prima di un barcode già inviato al PILOTA (ma non entrato in impianto)
					end if
					if trim(kst_tab_pl_barcode.prima_del_barcode) > " " then
					else
						kst_tab_pl_barcode.prima_del_barcode = ""
					end if
						
	//--- PRODUZIONE FILE PER IL PILOTA ------------------------------------------------------------------
					if job_genera_piano_lavoro_esegui(kst_tab_pl_barcode)	then
						k_return++
					end if
						
	//--- Set nuovo STATO e id programma nel Piano di Lavorazione
					kst_tab_pl_barcode.stato_pl = kuf1_pl_barcode.ki_stato_pl_inviato
					kst_tab_pl_barcode.id_programma = kst_tab_pl_barcode.id_programma
					kst_tab_pl_barcode.st_tab_g_0.esegui_commit = "S"
					kuf1_pl_barcode.set_pl_barcode_stato_pl_id_programma(kst_tab_pl_barcode) 
				
				end if
				
			next	
			
		catch (uo_exception kuo_exception)
			kuo1_exception = create uo_exception
			kuo1_exception.set_esito(kuo_exception.kist_esito)
			kuo1_exception.scrivi_log()
		
			//--- Set nuovo STATO in ERRORE nel Piano di Lavorazione
			try
				kst_tab_pl_barcode.stato_pl = kuf1_pl_barcode.ki_stato_pl_inerrore
				kst_tab_pl_barcode.id_programma = 0
				kst_tab_pl_barcode.st_tab_g_0.esegui_commit = "S"
				kuf1_pl_barcode.set_pl_barcode_stato_pl_id_programma(kst_tab_pl_barcode) 
			catch (uo_exception kuo_exception2)
				kuo_exception2.scrivi_log()
			end try
		
			throw kuo1_exception
		
		end try
			
	end if

catch (uo_exception kuo2_exception)
	kuo2_exception.scrivi_log()
	throw kuo2_exception

finally
	
	if isvalid(kuf1_plav_conn_cfg) then destroy kuf1_plav_conn_cfg
	if isvalid(kuf1_pilota_cmd) then destroy kuf1_pilota_cmd

	destroy kuf1_pl_barcode
	SetPointer(kkg.pointer_default)

end try


return k_return

end function

private function boolean job_genera_piano_lavoro_esegui (ref st_tab_pl_barcode ast_tab_pl_barcode) throws uo_exception;/*
   Generazione Nuovo Piano di Lavorazione per il Pilota
	Inp: st_tab_pl_barcode.codice
	                      .prima_del_barcode
	Out: ast_tab_pl_barcode.id_programma
   Rit: TRUE=richiesta caricata e pronta per il PILOTA
*/
boolean k_return
long k_rows
int k_rc
st_tab_programmi kst_tab_programmi
ds_pl_barcode kds_pl_barcode
ds_programmi_richieste_id_stato_update kds_programmi_richieste_id_stato_update


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
	kds_pl_barcode = create ds_pl_barcode
	kds_programmi_richieste_id_stato_update = create ds_programmi_richieste_id_stato_update

//--- Piglia elenco barcode del PL da Inviare al PILOTA
	k_rows = kds_pl_barcode.retrieve(ast_tab_pl_barcode.codice) 
	if k_rows < 0 then
		kguo_exception.set_esito(kds_pl_barcode.kist_esito)
		kguo_exception.kist_esito.sqlerrtext = "Errore in lettura Barcode del PL " + string(ast_tab_pl_barcode.codice) &
								+ " in preparazione invio del Piano al Pilota. " + kkg.acapo + kds_pl_barcode.kist_esito.sqlerrtext
		throw kguo_exception
	end if

	if k_rows > 0 then

//--- INIZIO PRODUZIONE FILE PER IL PILOTA ------------------------------------------------------------------
		
//--- Crea la RICHIESTA		
		kst_tab_programmi.id_pl_barcode = ast_tab_pl_barcode.codice
		kst_tab_programmi.id_impianto = kki_id_impianto_G2  // Qui sempre G2
		kst_tab_programmi.id_modo = ""  // il G2 lavora sempre con la stessa modalità
		kst_tab_programmi.barcode = ast_tab_pl_barcode.prima_del_barcode
		if kst_tab_programmi.barcode > " " then  
			kst_tab_programmi.id_tipo_richiesta = kki_richieste_tipo_richiesta_nuovo_primadelbarcode
		else
			kst_tab_programmi.id_tipo_richiesta = kki_richieste_tipo_richiesta_nuovo
		end if
		u_pilota_programmi_richieste(kst_tab_programmi)  

//--- Popola tabella barcode PADRI
		kst_tab_programmi.st_tab_g_0.esegui_commit = "N"
		u_pilota_programmi_dettaglio_g2(kst_tab_programmi, kds_pl_barcode)
		 
//--- Popola tabella WO
		kst_tab_programmi.st_tab_g_0.esegui_commit = "N"
		u_pilota_programmi_work_orders(kst_tab_programmi, ast_tab_pl_barcode)

//--- popola il file x il Pilota con i groupage (barcode figli)
		kst_tab_programmi.st_tab_g_0.esegui_commit = "N"
		u_pilota_programmi_groupage(kst_tab_programmi, kds_pl_barcode)

//--- popola il file x il Pilota con i DOSIMETRI presenti sui barcode padri 
		kst_tab_programmi.st_tab_g_0.esegui_commit = "N"
		u_pilota_programmi_accessori_dosimetri(kst_tab_programmi, kds_pl_barcode)
	
		kguo_sqlca_db_plav.db_commit( )
			
//--- Set nuovo STATO su RICHIESTA a pronto per il PILOTA
		if kds_programmi_richieste_id_stato_update.retrieve(kst_tab_programmi.id_programma) > 0 then
			kds_programmi_richieste_id_stato_update.setitem(1, "richiesta_data_ora", kguo_g.get_datetime_current_local( ) )
			kds_programmi_richieste_id_stato_update.setitem(1, "id_stato", kki_richieste_stato_pronta )
			
//---- Update STATO RICHIESTA
			k_rc = kds_programmi_richieste_id_stato_update.update( )
			if k_rc < 0 then
				kguo_exception.inizializza(this.classname())
				kguo_exception.set_esito(kds_programmi_richieste_id_stato_update.kist_esito)
				kguo_exception.kist_esito.sqlerrtext = "Errore in Aggiornamento STATO della Richiesta Piano di Lavoro per il Pilota (update)! " &
															+ kkg.acapo + "Id Programma " + string(kst_tab_programmi.id_programma) + " " &
															+ "stato a '" + string(kki_richieste_stato_pronta) + "' " &
															+ kkg.acapo + kds_programmi_richieste_id_stato_update.kist_esito.sqlerrtext
				kguo_sqlca_db_plav.db_rollback( )
				throw kguo_exception
			end if
			if k_rc > 0 then
				kguo_sqlca_db_plav.db_commit( )
			end if
			
		end if
				
//--- FINE PRODUZIONE FILE PER IL PILOTA ------------------------------------------------------------------

		ast_tab_pl_barcode.id_programma = kst_tab_programmi.id_programma
	
		k_return = true
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kds_pl_barcode) then destroy kds_pl_barcode
	if isvalid(kds_programmi_richieste_id_stato_update) then destroy kds_programmi_richieste_id_stato_update

	SetPointer(kkg.pointer_default)

end try


return k_return

end function

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
int k_richieste_evase
st_esito kst_esito
kuo_sqlca_db_plav kuo1_sqlca_db_plav


try 
	kst_esito = kguo_exception.inizializza(this.classname())

	kuo1_sqlca_db_plav = create kuo_sqlca_db_plav
	if kuo1_sqlca_db_plav.if_connessione_bloccata( ) then
		kst_esito.SQLErrText = "Operazione non eseguita correttamente. " &
										+ "La Connessione alle tabelle Pilota è BLOCCATA da Proprietè Azienda." 
	end if	
	
	k_richieste_evase = job_genera_piano_lavoro( )
	if k_richieste_evase > 0 then
		kst_esito.SQLErrText = "Operazione conclusa correttamente. " &
									+ string(k_richieste_evase) + " Piani di Lavoro inviati nelle tabelle di scambio con il 'PILOTA'." 
	else			
		kst_esito.SQLErrText = "Operazione conclusa. Nessun Piano di Lavorazione Chiuso da inviare al Pilota trovato."
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuo1_sqlca_db_plav) then destroy kuo1_sqlca_db_plav
	
end try


return kst_esito
end function

private function long u_pilota_programmi_richieste (ref st_tab_programmi ast_tab_programmi) throws uo_exception;/*
   Popola la tabella programmi_RICHIESTE 
	inp: st_tab_programmi.id_impianto
	     st_tab_programmi.id_modo
		  st_tab_programmi.tipo	richiesta vedi kki_richieste_tipo_richiesta_...
		  st_tab_programmi.id_pl_barcode
		  st_tab_programmi.barcode  // prima del barcode..
   rit: ID_PROGRAMMA
	out: ast_tab_programmi.ID_PROGRAMMA
	
*/
long k_return
int k_rc
long k_row
ds_programmi_richieste_update kds_programmi_richieste_update
kuf_programmi kuf1_programmi


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
	kds_programmi_richieste_update = create ds_programmi_richieste_update
	kuf1_programmi = create kuf_programmi
	
	k_row = kds_programmi_richieste_update.insertrow(0)
	if k_row > 0 then
		kds_programmi_richieste_update.setitem(k_row, "id_pl_barcode", ast_tab_programmi.id_pl_barcode)
		kds_programmi_richieste_update.setitem(k_row, "id_impianto", ast_tab_programmi.id_impianto)
		kds_programmi_richieste_update.setitem(k_row, "id_modo", ast_tab_programmi.id_modo)
		kds_programmi_richieste_update.setitem(k_row, "id_tipo_richiesta", ast_tab_programmi.id_tipo_richiesta)
		kds_programmi_richieste_update.setitem(k_row, "barcode_prima", ast_tab_programmi.barcode)  // prima del barcode...
		kds_programmi_richieste_update.setitem(k_row, "id_stato", kki_richieste_stato_IN_PREPARAZIONE) 
		kds_programmi_richieste_update.setitem(k_row, "esito", "") 
		kds_programmi_richieste_update.setitem(k_row, "richiesta_data_ora", kguo_g.get_datetime_current_local()) 
	else
		kguo_exception.inizializza(this.classname())
		kguo_exception.set_esito(kds_programmi_richieste_update.kist_esito)
		kguo_exception.kist_esito.sqlerrtext = "Errore in Generazione Richiesta Piano di Lavoro per il Pilota (insert)! " &
														+ kkg.acapo + "Id Impianto " + string(ast_tab_programmi.id_impianto) + " " &
														+ "Modalità " + string(ast_tab_programmi.id_modo) + " " &
														+ "Tipo Richiesta " + string(ast_tab_programmi.id_tipo_richiesta) + " " &
														+ "Codice Piano di Lavorazione " + string(ast_tab_programmi.id_pl_barcode) + " " &
														+ kkg.acapo + kds_programmi_richieste_update.kist_esito.sqlerrtext
		throw kguo_exception
	end if
	
//	//--- Compone il record del file Richieste
//	if kst_txt_pilota_cmd.codice_richiesta = kki_tipo_richiesta_invio_nuovo_pl_padri or kst_txt_pilota_cmd.codice_richiesta = kki_tipo_richiesta_sost_pl_padri then
//		k_record = string(kst_txt_pilota_cmd.progressivo_richiesta, "000000") &
//						+ k_sep + string(kst_txt_pilota_cmd.codice_richiesta, "000000") &
//						+ k_sep + trim(kst_txt_pilota_cmd.path_fl_pilota) &
//						+ k_sep + trim(kst_txt_pilota_cmd.prima_del_barcode) &
//						+ k_sep + trim(kst_txt_pilota_cmd.utente) 
//	else
//		if kst_txt_pilota_cmd.codice_richiesta = kki_tipo_richiesta_invio_nuovo_pl_figli or kst_txt_pilota_cmd.codice_richiesta = kki_tipo_richiesta_sost_pl_figli then  
//			k_record = string(kst_txt_pilota_cmd.progressivo_richiesta, "000000") &
//							+ k_sep + string(kst_txt_pilota_cmd.codice_richiesta, "000000") &
//							+ k_sep + trim(kst_txt_pilota_cmd.path_fl_pilota) &
//							+ k_sep + trim(kst_txt_pilota_cmd.utente) 
//	end if				

	if k_row > 0 then
//---- Update tabella RICHIESTE
		k_rc = kds_programmi_richieste_update.update( )
		if k_rc < 0 then
			kguo_exception.inizializza(this.classname())
			kguo_exception.set_esito(kds_programmi_richieste_update.kist_esito)
			kguo_exception.kist_esito.sqlerrtext = "Errore in Generazione Richiesta Piano di Lavoro per il Pilota (update)! " &
														+ kkg.acapo + "Id Impianto " + string(ast_tab_programmi.id_impianto) + " " &
														+ "Modalità " + string(ast_tab_programmi.id_modo) + " " &
														+ "Tipo Richiesta " + string(ast_tab_programmi.id_tipo_richiesta) + " " &
														+ kkg.acapo + kds_programmi_richieste_update.kist_esito.sqlerrtext
			if ast_tab_programmi.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_plav.db_rollback( )
			end if
			throw kguo_exception
		end if
		if k_rc > 0 then
			
			if ast_tab_programmi.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_plav.db_commit( )
			end if
			
			ast_tab_programmi.id_programma = kuf1_programmi.get_id_programma_last( ) // Recupera ID del programma
			
			k_return = ast_tab_programmi.id_programma
		end if
	end if
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

	if isvalid(kds_programmi_richieste_update) then destroy kds_programmi_richieste_update
	if isvalid(kuf1_programmi) then destroy kuf1_programmi

end try

return k_return

end function

private function long u_pilota_programmi_work_orders (st_tab_programmi ast_tab_programmi, st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception;/*
   Popola la tabella programmi_work_orders (ex PP_PILOTA_WO.TXT)
	inp: ast_tab_programmi.id_programma
	     st_tab_pl_barcode.codice numero del Piano da inviare
   rit: numero ri WO caricati
	out: 
	
*/
long k_return
long k_row, k_rows, k_row_ins
int k_rc
st_tab_barcode kst_tab_barcode
ds_programmi_work_orders_update kds_programmi_work_orders_update
uo_ds_std_1 kds_pl_barcode_wo_id_meca
kuf_barcode kuf1_barcode

	
try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
	kds_programmi_work_orders_update = create ds_programmi_work_orders_update

	kds_pl_barcode_wo_id_meca = create uo_ds_std_1
	kds_pl_barcode_wo_id_meca.dataobject = "ds_pl_barcode_wo_id_meca"
	kds_pl_barcode_wo_id_meca.settransobject(kguo_sqlca_db_magazzino)
	
	k_rows = kds_pl_barcode_wo_id_meca.retrieve(kst_tab_pl_barcode.codice) // get elenco WO

	if k_rows < 1 then
		kguo_exception.inizializza(this.classname())
		kguo_exception.set_esito(kds_programmi_work_orders_update.kist_esito)
		kguo_exception.kist_esito.sqlerrtext = "Errore in lettura elenco Work Order durante preparazione del Carico in Generazione Piano per il Pilota! " &
														+ kkg.acapo + "Id Programma " + string(ast_tab_programmi.id_programma) + " " &
														+ "Piano di Lavoro codice " + string(kst_tab_pl_barcode.codice) + " " &
														+ kkg.acapo + kds_programmi_work_orders_update.kist_esito.sqlerrtext
		throw kguo_exception
	end if
	
	for k_row = 1 to k_rows
		
		k_row_ins = kds_programmi_work_orders_update.insertrow(0)
		if k_row_ins < 1 then
			kguo_exception.inizializza(this.classname())
			kguo_exception.set_esito(kds_programmi_work_orders_update.kist_esito)
			kguo_exception.kist_esito.sqlerrtext = "Errore in preparazione Carico Work Order in Generazione Piano per il Pilota! " &
															+ kkg.acapo + "Id Programma " + string(ast_tab_programmi.id_programma) + " " &
															+ "Piano di Lavoro codice " + string(kst_tab_pl_barcode.codice) + " " &
															+ kkg.acapo + kds_programmi_work_orders_update.kist_esito.sqlerrtext
			throw kguo_exception
		end if
		
		kds_programmi_work_orders_update.setitem(k_row_ins, "id_programma", ast_tab_programmi.id_programma)
		kds_programmi_work_orders_update.setitem(k_row_ins, "work_order", kds_pl_barcode_wo_id_meca.object.meca_e1doco[k_row])
		kds_programmi_work_orders_update.setitem(k_row_ins, "barcode", trim(kds_pl_barcode_wo_id_meca.object.barcode_barcode[k_row]))

		kst_tab_barcode.causale = trim(kds_pl_barcode_wo_id_meca.object.barcode_causale[k_row])
		if kst_tab_barcode.causale = kuf1_barcode.ki_causale_non_trattare then
			kds_programmi_work_orders_update.setitem(k_row_ins, "abilitazione", "0")
		else
			kds_programmi_work_orders_update.setitem(k_row_ins, "abilitazione", "1")
		end if			

	next

	if k_row_ins > 0 then
//---- Popola tabella BARCODE PADRI
		k_rc = kds_programmi_work_orders_update.update( )
		if k_rc < 0 then
			kguo_exception.inizializza(this.classname())
			kguo_exception.set_esito(kds_programmi_work_orders_update.kist_esito)
			kguo_exception.kist_esito.sqlerrtext = "Errore in Carico Work Order in Generazione Piano per il Pilota! " &
															+ kkg.acapo + "Id Programma " + string(ast_tab_programmi.id_programma) + " " &
															+ "Piano di Lavoro codice " + string(kst_tab_pl_barcode.codice) + " " &
															+ kkg.acapo + kds_programmi_work_orders_update.kist_esito.sqlerrtext
			if ast_tab_programmi.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_plav.db_rollback( )
			end if
			throw kguo_exception
		end if
		if k_rc > 0 then
			
			if ast_tab_programmi.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_plav.db_commit( )
			end if
			
			k_return = kds_programmi_work_orders_update.rowcount( )
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kds_programmi_work_orders_update) then destroy kds_programmi_work_orders_update
	if isvalid(kds_pl_barcode_wo_id_meca) then destroy kds_pl_barcode_wo_id_meca
	SetPointer(kkg.pointer_default)

end try

return k_return

end function

private function integer u_pilota_programmi_dettaglio_g2 (st_tab_programmi ast_tab_programmi, ref ds_pl_barcode ads_pl_barcode) throws uo_exception;/*
   Popola la tabella programmi_dettaglio dei barcode padri
	inp: ast_tab_programmi.id_programma 
	     ast_tab_programmi.id_impianto
	     ads_pl_barcode = elenco barcode del PL
	rit: numero barcode inseriti
	
*/
long k_return
int k_rc
long k_row, k_rows, k_row_ins, k_ctr
string k_alto_basso
constant string k_cost_alto = "2HMM", k_cost_basso = "2BMM" //, k_cost_fine = "NN"
ds_programmi_dettaglio_g2_update kds_programmi_dettaglio_g2_update
st_tab_barcode kst_tab_barcode
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
//st_tab_pl_barcode kst_tab_pl_barcode
kuf_barcode kuf1_barcode
kuf_utility kuf1_utility


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

	kuf1_utility = create kuf_utility
	kds_programmi_dettaglio_g2_update = create ds_programmi_dettaglio_g2_update
	
	k_rows = ads_pl_barcode.rowcount() 
//	if k_rows > 0 then
//		kst_tab_pl_barcode.codice = ads_pl_barcode.object.pl_barcode[1]
//	end if

	for k_row = 1 to k_rows 
	
		kst_tab_barcode.barcode_lav = ads_pl_barcode.object.barcode_lav[k_row]
		if trim(kst_tab_barcode.barcode_lav) > " " then 
			// scarta filgli
		else
//--- tratta solo i barcode PADRI (quindi barcode_lav vuoto)
			kst_tab_barcode.pl_barcode = ads_pl_barcode.object.pl_barcode[k_row]
			kst_tab_barcode.pl_barcode_progr = ads_pl_barcode.object.pl_barcode_progr[k_row]
			kst_tab_barcode.barcode = ads_pl_barcode.object.barcode[k_row]
			kst_tab_barcode.groupage = ads_pl_barcode.object.groupage[k_row]
			kst_tab_barcode.fila_1 = ads_pl_barcode.object.fila_1[k_row]
			kst_tab_barcode.fila_2 = ads_pl_barcode.object.fila_2[k_row]
			kst_tab_barcode.fila_1p = ads_pl_barcode.object.fila_1p[k_row]
			kst_tab_barcode.fila_2p = ads_pl_barcode.object.fila_2p[k_row]
			kst_tab_meca.num_int = ads_pl_barcode.object.num_int[k_row]
			kst_tab_meca.data_int = ads_pl_barcode.object.data_int[k_row]
			kst_tab_meca.clie_2 = ads_pl_barcode.object.clie_2[k_row]
			kst_tab_meca.area_mag = ads_pl_barcode.object.area_mag[k_row]
			kst_tab_clienti.rag_soc_10 = ads_pl_barcode.object.rag_soc_10[k_row]
			
			if isnull(kst_tab_barcode.fila_1) then
				kst_tab_barcode.fila_1 = 0
			end if
			if isnull(kst_tab_barcode.fila_2) then
				kst_tab_barcode.fila_2 = 0
			end if
			if isnull(kst_tab_barcode.fila_1p) then
				kst_tab_barcode.fila_1p = 0
			end if
			if isnull(kst_tab_barcode.fila_2p) then
				kst_tab_barcode.fila_2p = 0
			end if
			if isnull(kst_tab_barcode.barcode) then
				kst_tab_barcode.barcode = " "
			end if
			if isnull(kst_tab_barcode.pl_barcode) then
				kst_tab_barcode.pl_barcode = 0
			end if
			if isnull(kst_tab_meca.clie_2) then
				kst_tab_meca.clie_2 = 0
			end if
			if isnull(kst_tab_meca.num_int) then
				kst_tab_meca.num_int = 0
			end if
			if isnull(kst_tab_meca.area_mag) then
				kst_tab_meca.area_mag = " "
			end if
			if isnull(kst_tab_clienti.rag_soc_10) then
				kst_tab_clienti.rag_soc_10 = " "
			end if
			
//--- Toglie char come virgola apostrofo asterisco ...  dalla Ragione Sociale	
			kst_tab_clienti.rag_soc_10 = kuf1_utility.u_stringa_alfanum_spazio(kst_tab_clienti.rag_soc_10)

//--- compone il record da scrivere
			k_row_ins = kds_programmi_dettaglio_g2_update.insertrow(0)
			if k_row_ins < 0 then
				kguo_exception.inizializza(this.classname())
				kguo_exception.set_esito(kds_programmi_dettaglio_g2_update.kist_esito)
				kguo_exception.kist_esito.sqlerrtext = "Errore in preparazione Carico Barcode di Lavoro in Generazione Piano per il Pilota " &
																+ kkg.acapo + "Id Programma " + string(ast_tab_programmi.id_programma) + " " &
																+ "Barcode " + kst_tab_barcode.barcode + " " &
																+ "al n. di sequenza " + string(k_row_ins) + " " &
																+ kkg.acapo + kds_programmi_dettaglio_g2_update.kist_esito.sqlerrtext
				throw kguo_exception
			end if
			
//--- quando record e' dispari pallet Alto altrimenti Basso
			if mod(k_row_ins, 2) = 0 then 
				k_alto_basso = k_cost_basso
			else
				k_alto_basso = k_cost_alto
			end if
			
			kds_programmi_dettaglio_g2_update.setitem(k_row_ins, "id_programma", ast_tab_programmi.id_programma) 
			kds_programmi_dettaglio_g2_update.setitem(k_row_ins, "sequenza", k_row_ins) 
			kds_programmi_dettaglio_g2_update.setitem(k_row_ins, "id_impianto", ast_tab_programmi.id_impianto) 
			kds_programmi_dettaglio_g2_update.setitem(k_row_ins, "barcode", kst_tab_barcode.barcode) 
			kds_programmi_dettaglio_g2_update.setitem(k_row_ins, "posizione_bilancella", k_alto_basso) 
			kds_programmi_dettaglio_g2_update.setitem(k_row_ins, "giri_f1", kst_tab_barcode.fila_1) 
			kds_programmi_dettaglio_g2_update.setitem(k_row_ins, "giri_f2", kst_tab_barcode.fila_2) 
			kds_programmi_dettaglio_g2_update.setitem(k_row_ins, "giri_f1p", kst_tab_barcode.fila_1p) 
			kds_programmi_dettaglio_g2_update.setitem(k_row_ins, "giri_f2p", kst_tab_barcode.fila_2p) 
			kds_programmi_dettaglio_g2_update.setitem(k_row_ins, "codice_cliente", string(kst_tab_meca.clie_2,"#####0")) 
			kds_programmi_dettaglio_g2_update.setitem(k_row_ins, "nome_cliente", trim(kst_tab_clienti.rag_soc_10)) 
			kds_programmi_dettaglio_g2_update.setitem(k_row_ins, "riferimento", trim(string(kst_tab_meca.num_int,"#####0")) &
																							   + "/"+string(kst_tab_meca.data_int,"yyyy")) 
			kds_programmi_dettaglio_g2_update.setitem(k_row_ins, "locazione", trim(kst_tab_meca.area_mag)) 
			
//			k_record = trim(kst_tab_barcode.barcode) + k_alto_basso + k_giri + k_giri_p + k_cost_fine  &
//								 + trim(string(kst_tab_barcode.pl_barcode,"0000000000")) & 
//								 + k_sep+trim(string(kst_tab_meca.clie_2,"#####0")) & 
//								 + k_sep+trim(kst_tab_clienti.rag_soc_10) + " " &
//								 + k_sep+trim(string(kst_tab_meca.num_int,"#####0")) & 
//								 		  + "/"+string(kst_tab_meca.data_int,"yyyy") & 
//								 + k_sep+trim(kst_tab_meca.area_mag) + " "
			

		end if
		
	next  

	if k_row_ins > 0 then
//---- Popola tabella BARCODE PADRI
		k_rc = kds_programmi_dettaglio_g2_update.update( )
		if k_rc < 0 then
			kguo_exception.inizializza(this.classname())
			kguo_exception.set_esito(kds_programmi_dettaglio_g2_update.kist_esito)
			kguo_exception.kist_esito.sqlerrtext = "Errore in Carico Barcode di Lavoro in Generazione Piano per il Pilota " &
															+ kkg.acapo + "Id Programma " + string(ast_tab_programmi.id_programma) + " " &
															+ kkg.acapo + kds_programmi_dettaglio_g2_update.kist_esito.sqlerrtext
			throw kguo_exception
		end if
		if k_rc > 0 then
			
			if ast_tab_programmi.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_plav.db_commit( )
			end if
			
			k_return = kds_programmi_dettaglio_g2_update.rowcount( )
		end if
	end if

	//		k_return = true
  
//--- Se Piano deriva da un P.L. allora aggiorna..
//	if kst_tab_pl_barcode.codice > 0 then

//		if kst_esito.esito = kkg_esito.ok then

//--- Aggiornamenti nella tabella P.L. 
//			kst_tab_pl_barcode.path_file_pilota = trim(k_file_temp)
//			tb_update_campo(kst_tab_pl_barcode, "path_file_pilota")
			
//		end if

//--- Controlla se il numero dei Barcode prodotti e' giusto
//		 k_ctr = conta_barcode_no_figli(kst_tab_pl_barcode)
//		if k_row_ins <>  k_ctr then
//			kst_esito.esito = kkg_esito.err_logico
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.SQLErrText = "Errore: numero Barcode 'scaricati' diverso da quelli presenti nel P.L. ~n~r" &
//				+ "Scaricati: " + string(k_row_ins) &
//				+ "   Presenti nel P.L. " + string(kst_tab_pl_barcode.codice) + ": " + string(k_ctr) + "~n~r" &
//				+ "Prego controllare nel file:~n~r" //+ trim(k_file_temp)
//				
//		end if
//	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally

	if isvalid(kuf1_utility) then destroy kuf1_utility
	if isvalid(kds_programmi_dettaglio_g2_update) then destroy kds_programmi_dettaglio_g2_update

//=== riprisino Puntatore
	SetPointer(kkg.pointer_default)

end try

return k_return

end function

private function integer u_pilota_programmi_groupage (st_tab_programmi ast_tab_programmi, ref ds_pl_barcode ads_pl_barcode) throws uo_exception;/*
   Popola la tabella programmi_groupage dei barcode padri e figli associati
	inp: ast_tab_programmi.id_programma 
	     ads_pl_barcode = elenco barcode del PL
	rit: numero barcode inseriti
	
*/
long k_return
int k_rc
long k_row, k_rows, k_row_ins, k_ctr
ds_programmi_groupage_update kds_programmi_groupage_update
st_tab_barcode kst_tab_barcode
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
kuf_utility kuf1_utility



try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

	kuf1_utility = create kuf_utility
	kds_programmi_groupage_update = create ds_programmi_groupage_update
	
	k_rows = ads_pl_barcode.rowcount() 
	if k_rows > 0 then
		ads_pl_barcode.SetSort("padre_pl_barcode_progr A, barcode_lav D")
		ads_pl_barcode.sort()
	end if

	for k_row = 1 to k_rows 

		kst_tab_barcode.barcode_lav = ads_pl_barcode.object.barcode_lav[k_row]
	
//--- tratta solo i barcode FIGLI (quindi deve esserci il barcode_lav)
		if trim(kst_tab_barcode.barcode_lav) > " " then 

			kst_tab_barcode.pl_barcode = ads_pl_barcode.object.pl_barcode[k_row]
			kst_tab_barcode.pl_barcode_progr = ads_pl_barcode.object.padre_pl_barcode_progr[k_row]
			kst_tab_barcode.barcode = ads_pl_barcode.object.barcode[k_row]
			kst_tab_meca.num_int = ads_pl_barcode.object.num_int[k_row]
			kst_tab_meca.data_int = ads_pl_barcode.object.data_int[k_row]
			kst_tab_meca.clie_2 = ads_pl_barcode.object.clie_2[k_row]
			kst_tab_meca.area_mag = ads_pl_barcode.object.area_mag[k_row]
			kst_tab_clienti.rag_soc_10 = ads_pl_barcode.object.rag_soc_10[k_row]
			
			if isnull(kst_tab_meca.clie_2) then
				kst_tab_meca.clie_2 = 0
			end if
			if isnull(kst_tab_meca.num_int) then
				kst_tab_meca.num_int = 0
			end if
			if isnull(kst_tab_meca.area_mag) then
				kst_tab_meca.area_mag = " "
			end if
			if isnull(kst_tab_clienti.rag_soc_10) then
				kst_tab_clienti.rag_soc_10 = " "
			end if
			
//--- Toglie char come virgola apostrofo asterisco ...  dalla Ragione Sociale	
			kst_tab_clienti.rag_soc_10 = kuf1_utility.u_stringa_alfanum_spazio(kst_tab_clienti.rag_soc_10)

//--- compone il record da scrivere
			k_row_ins = kds_programmi_groupage_update.insertrow(0)
			if k_row_ins < 0 then
				kguo_exception.inizializza(this.classname())
				kguo_exception.set_esito(kds_programmi_groupage_update.kist_esito)
				kguo_exception.kist_esito.sqlerrtext = "Errore in preparazione Carico Barcode FIGLI in Generazione Piano per il Pilota " &
																+ kkg.acapo + "Id Programma " + string(ast_tab_programmi.id_programma) + " " &
																+ "Barcode " + kst_tab_barcode.barcode + " " &
																+ "Barcode Padre " + kst_tab_barcode.barcode_lav + " " &
																+ "al n. di sequenza " + string(k_row_ins) + " " &
																+ kkg.acapo + kds_programmi_groupage_update.kist_esito.sqlerrtext
				throw kguo_exception
			end if
			kds_programmi_groupage_update.setitem(k_row_ins, "id_programma", ast_tab_programmi.id_programma) 
			kds_programmi_groupage_update.setitem(k_row_ins, "sequenza", k_row_ins) 
			kds_programmi_groupage_update.setitem(k_row_ins, "barcode_padre", kst_tab_barcode.barcode_lav) 
			kds_programmi_groupage_update.setitem(k_row_ins, "barcode_figlio", kst_tab_barcode.barcode) 
			kds_programmi_groupage_update.setitem(k_row_ins, "f_codice_cliente", string(kst_tab_meca.clie_2,"#####0")) 
			kds_programmi_groupage_update.setitem(k_row_ins, "f_nome_cliente", trim(kst_tab_clienti.rag_soc_10)) 
			kds_programmi_groupage_update.setitem(k_row_ins, "f_riferimento", trim(string(kst_tab_meca.num_int,"#####0")) &
																							   + "/"+string(kst_tab_meca.data_int,"yyyy")) 
			kds_programmi_groupage_update.setitem(k_row_ins, "f_locazione", trim(kst_tab_meca.area_mag)) 
			
		end if
		
	next  

	if k_row_ins > 0 then
//---- Popola tabella BARCODE FIGLI
		k_rc = kds_programmi_groupage_update.update( )
		if k_rc < 0 then
			kguo_exception.inizializza(this.classname())
			kguo_exception.set_esito(kds_programmi_groupage_update.kist_esito)
			kguo_exception.kist_esito.sqlerrtext = "Errore in Carico Barcode FIGLI in Generazione Piano per il Pilota " &
															+ kkg.acapo + "Id Programma " + string(ast_tab_programmi.id_programma) + " " &
															+ kkg.acapo + kds_programmi_groupage_update.kist_esito.sqlerrtext
			throw kguo_exception
		end if
		if k_rc > 0 then
			
			if ast_tab_programmi.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_plav.db_commit( )
			end if
			
			k_return = kds_programmi_groupage_update.rowcount( )
		end if
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally

	if isvalid(kuf1_utility) then destroy kuf1_utility
	if isvalid(kds_programmi_groupage_update) then destroy kds_programmi_groupage_update

	SetPointer(kkg.pointer_default)

end try

return k_return

end function

private function long u_pilota_programmi_accessori_dosimetri (st_tab_programmi ast_tab_programmi, ref ds_pl_barcode ads_pl_barcode) throws uo_exception;/*
   Popola la tabella programmi_groupage dei barcode
	inp: ast_tab_programmi.id_programma 
	     ads_pl_barcode = elenco barcode ma per elab solo quelli con il flag dosimetro
	rit: numero barcode inseriti
	
*/
long k_return
int k_rc
long k_row, k_rows, k_row_ins, k_ind, k_nr_meca_dosim
string k_barcode_pallet, k_codice_posizione, k_barcode_figlio
ds_programmi_accessori_update kds_programmi_accessori_update
uo_ds_std_1 kds_meca_dosim_x_barcode_lav
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode
kuf_ausiliari kuf1_ausiliari


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

	kds_programmi_accessori_update = create ds_programmi_accessori_update
	
//--- datastore con i dati dei dosimetri accoppiati al barcode di trattamento
	kds_meca_dosim_x_barcode_lav = create uo_ds_std_1
	kds_meca_dosim_x_barcode_lav.dataobject = "ds_meca_dosim_x_barcode_lav"
	kds_meca_dosim_x_barcode_lav.settransobject(kguo_sqlca_db_magazzino)
	
	k_rows = ads_pl_barcode.rowcount() 

	for k_row = 1 to k_rows 

		kst_tab_barcode.barcode = trim(ads_pl_barcode.object.barcode[k_row])
		kst_tab_barcode.barcode_lav = trim(ads_pl_barcode.object.barcode_lav[k_row])

	//--- Se il BARCODE ha ACCOPPIATO un DOSIMETRO allora fingo sia un barcode FIGLIO quindi scrive
		kst_tab_barcode.flg_dosimetro = ads_pl_barcode.object.flg_dosimetro[k_row]
		if trim(kst_tab_barcode.flg_dosimetro) = kuf1_barcode.ki_flg_dosimetro_si then

//--- recupera i barcode DOSIMETRI e le posizioni sortati per 'sequenza'  
			k_nr_meca_dosim = kds_meca_dosim_x_barcode_lav.retrieve(kst_tab_barcode.barcode)
			for k_ind = 1 to k_nr_meca_dosim
				
//--- Se è un barcode Figlio e contiene il dosimetro allora mette il PADRE e POSIZIONE non 'precisa' (DISABILITATA)
				if trim(kst_tab_barcode.barcode_lav) > " " then
					k_barcode_pallet = trim(kst_tab_barcode.barcode_lav) 
					k_barcode_figlio = trim(kst_tab_barcode.barcode)  
					//--- Posizione FORZATO a disabilitato in quanto barcode figlio 	
					k_codice_posizione = kuf1_ausiliari.kki_dosimpos_codice_disabilitato99    // POSIZIONE DISABILITATA
				else
					k_barcode_pallet = trim(kst_tab_barcode.barcode) 
					k_barcode_figlio = ""
					
					//--- Posizione se non indicata FORZA a disabilitato 	
					k_codice_posizione = kds_meca_dosim_x_barcode_lav.getitemstring(k_ind, "dosimpos_codice")
					if trim(k_codice_posizione) > " " then
					else
						k_codice_posizione = kuf1_ausiliari.kki_dosimpos_codice_disabilitato00    // POSIZIONE DISABILITATA
					end if
					
				end if

//						k_record += k_sep + trim(kst_tab_meca_dosim[k_ind].barcode) & 
//												  + k_sep+trim(kst_tab_clienti.rag_soc_10) + " " &
//												  + k_sep+trim(string(kst_tab_meca.num_int,"#####0")) 

//--- compone il record da scrivere
				k_row_ins = kds_programmi_accessori_update.insertrow(0)
				if k_row_ins < 0 then
					kguo_exception.inizializza(this.classname())
					kguo_exception.set_esito(kds_programmi_accessori_update.kist_esito)
					kguo_exception.kist_esito.sqlerrtext = "Errore in preparazione Carico Accessori Dosimetri in Generazione Piano per il Pilota " &
																	+ kkg.acapo + "Id Programma " + string(ast_tab_programmi.id_programma) + " " &
																	+ "Barcode " + k_barcode_pallet + " " &
																	+ "Barcode Accessorio " + trim(kds_meca_dosim_x_barcode_lav.getitemstring(k_ind, "barcode")) + " " &
																	+ kkg.acapo + kds_programmi_accessori_update.kist_esito.sqlerrtext
					throw kguo_exception
				end if
				kds_programmi_accessori_update.setitem(k_row_ins, "id_programma", ast_tab_programmi.id_programma) 
				kds_programmi_accessori_update.setitem(k_row_ins, "barcode_pallet", k_barcode_pallet) 
				kds_programmi_accessori_update.setitem(k_row_ins, "barcode_f", k_barcode_figlio) 				
				kds_programmi_accessori_update.setitem(k_row_ins, "barcode_accessorio", trim(kds_meca_dosim_x_barcode_lav.getitemstring(k_ind, "barcode"))) 
				kds_programmi_accessori_update.setitem(k_row_ins, "id_accessorio", kki_id_accessorio_DOSIMETRO) 
				kds_programmi_accessori_update.setitem(k_row_ins, "posizione_accessorio", trim(k_codice_posizione)) 
				
			next

		end if
		
	next  

	if k_row_ins > 0 then
//---- Popola tabella BARCODE padri
		k_rc = kds_programmi_accessori_update.update( )
		if k_rc < 0 then
			kguo_exception.inizializza(this.classname())
			kguo_exception.set_esito(kds_programmi_accessori_update.kist_esito)
			kguo_exception.kist_esito.sqlerrtext = "Errore in Carico Accessori Dosimetri in Generazione Piano per il Pilota " &
															+ kkg.acapo + "Id Programma " + string(ast_tab_programmi.id_programma) + " " &
															+ kkg.acapo + kds_programmi_accessori_update.kist_esito.sqlerrtext
			throw kguo_exception
		end if
		if k_rc > 0 then
			
			if ast_tab_programmi.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_plav.db_commit( )
			end if
			
			k_return = kds_programmi_accessori_update.rowcount( )
		end if
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally

	if isvalid(kds_meca_dosim_x_barcode_lav) then destroy kds_meca_dosim_x_barcode_lav
	if isvalid(kds_programmi_accessori_update) then destroy kds_programmi_accessori_update

	SetPointer(kkg.pointer_default)

end try

return k_return

end function

public function boolean job_sostituzione_piano_lavoro (ds_pl_barcode ads_pl_barcode) throws uo_exception;/*
   Sostituzione completa Piano di Lavorazione per il Pilota 
	inp: ds_pl_barcode  tutti i barcode della Pianificazione compresi gli 'intoccabili'
   Out: true = richiesta completata
*/

boolean k_return
long k_row, k_rows, k_rows_inavase
int k_rc
st_tab_programmi kst_tab_programmi
ds_programmi_richieste_id_stato_update kds_programmi_richieste_id_stato_update
uo_ds_std_1 kds_programmi_richieste_inevase, kds_pl_da_inviare

st_tab_pilota_queue kst_tab_pilota_queue   // da aggiornare quando ho il DB PILOTA NUOVO
kuf_pilota_cmd kuf1_pilota_cmd             // da aggiornare quando ho il DB PILOTA NUOVO
st_tab_plav_conn_cfg kst_tab_plav_conn_cfg
kuf_plav_conn_cfg kuf1_plav_conn_cfg
uo_exception kuo1_exception


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
//--- Connessione Bloccata?
	kuf1_plav_conn_cfg = create kuf_plav_conn_cfg
	kuf1_plav_conn_cfg.get_plav_conn_cfg(kst_tab_plav_conn_cfg)
	if kuf1_plav_conn_cfg.if_conn_bloccata(kst_tab_plav_conn_cfg) then
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlerrtext = "Connessione al DB '" + kguo_sqlca_db_plav.ki_title_id + "' " &
													+ kguo_sqlca_db_plav.ki_db_descrizione + " è Bloccata. " &
													+ kkg.acapo + "Per proseguire, l'operazione di Sostituzione della Pianificazione sul Pilota, disattivare il blocco in Proprietà della Connessione. " 
		throw kguo_exception
	end if		
		
//--- Verifica se ci sono ancora Piani da evadere NON ce ne devono essere!!
	kds_programmi_richieste_inevase = create uo_ds_std_1
	kds_programmi_richieste_inevase.dataobject = "kds_programmi_richieste_inevase"
	k_rows_inavase = kds_programmi_richieste_inevase.retrieve(0)
	if k_rows_inavase > 0 then
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlerrtext = "Errore Generazione Richiesta di SOSTITUZIONE Piano di Lavoro per il Pilota. " &
													+ kkg.acapo + "Attenzione, ci sono ancora " + string(k_rows_inavase) + " " &
													+ "Richieste nello stato di inevase! " + &
													+ kkg.acapo + "Attendere il loro completamento o forzarle a concluse o errate. " 
		throw kguo_exception
	else
		if k_rows_inavase < 0 then
			kguo_exception.set_esito(kds_programmi_richieste_inevase.kist_esito)
			kguo_exception.kist_esito.sqlerrtext = "Errore Generazione Richiesta di SOSTITUZIONE Piano di Lavoro per il Pilota. " &
														+ kkg.acapo + "Errore: " + kds_programmi_richieste_inevase.kist_esito.sqlerrtext
			throw kguo_exception
		end if
	end if
	
					
	kds_programmi_richieste_id_stato_update = create ds_programmi_richieste_id_stato_update

//--- INIZIO PRODUZIONE DATI PER IL PILOTA ------------------------------------------------------------------
		
//--- Crea la RICHIESTA		
	kst_tab_programmi.id_pl_barcode = 0
	kst_tab_programmi.id_impianto = kki_id_impianto_G2  // Qui sempre G2
	kst_tab_programmi.id_modo = ""  // il G2 lavora sempre con la stessa modalità
	kst_tab_programmi.barcode = ""  // nulla in questo caso
	kst_tab_programmi.id_tipo_richiesta = kki_richieste_tipo_richiesta_sostituzione
	u_pilota_programmi_richieste(kst_tab_programmi)  

//--- Popola tabella barcode PADRI
	kst_tab_programmi.st_tab_g_0.esegui_commit = "N"
	u_pilota_programmi_dettaglio_g2(kst_tab_programmi, ads_pl_barcode)
	 
//--- popola il file x il Pilota con i groupage (barcode figli)
	kst_tab_programmi.st_tab_g_0.esegui_commit = "N"
	u_pilota_programmi_groupage(kst_tab_programmi, ads_pl_barcode)

//--- popola il file x il Pilota con i DOSIMETRI presenti sui barcode padri 
	kst_tab_programmi.st_tab_g_0.esegui_commit = "N"
	u_pilota_programmi_accessori_dosimetri(kst_tab_programmi, ads_pl_barcode)

	kguo_sqlca_db_plav.db_commit( )
		
//--- Set nuovo STATO su RICHIESTA a pronto per il PILOTA
	if kds_programmi_richieste_id_stato_update.retrieve(kst_tab_programmi.id_programma) > 0 then
		kds_programmi_richieste_id_stato_update.setitem(1, "richiesta_data_ora", kguo_g.get_datetime_current_local( ) )
		kds_programmi_richieste_id_stato_update.setitem(1, "id_stato", kki_richieste_stato_pronta )
		
//---- Update STATO RICHIESTA
		k_rc = kds_programmi_richieste_id_stato_update.update( )
		if k_rc < 0 then
			kguo_exception.inizializza(this.classname())
			kguo_exception.set_esito(kds_programmi_richieste_id_stato_update.kist_esito)
			kguo_exception.kist_esito.sqlerrtext = "Errore in Aggiornamento STATO della Richiesta Piano di Lavoro per il Pilota (update)! " &
														+ kkg.acapo + "Id Programma " + string(kst_tab_programmi.id_programma) + " " &
														+ "stato a '" + string(kki_richieste_stato_pronta) + "' " &
														+ kkg.acapo + kds_programmi_richieste_id_stato_update.kist_esito.sqlerrtext
			kguo_sqlca_db_plav.db_rollback( )
			throw kguo_exception
		end if
		if k_rc > 0 then
			kguo_sqlca_db_plav.db_commit( )
		end if
		
	end if

//--- FINE PRODUZIONE FILE PER IL PILOTA ------------------------------------------------------------------

		k_return = true
		

catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log()
	throw kuo_exception

finally
	if isvalid(kuf1_plav_conn_cfg) then destroy kuf1_plav_conn_cfg
	if isvalid(kds_programmi_richieste_inevase) then destroy kds_programmi_richieste_inevase
	if isvalid(kds_programmi_richieste_id_stato_update) then destroy kds_programmi_richieste_id_stato_update	
	
	SetPointer(kkg.pointer_default)

end try


return k_return

end function

on kuf_plav.create
call super::create
end on

on kuf_plav.destroy
call super::destroy
end on

