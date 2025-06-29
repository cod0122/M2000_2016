﻿$PBExportHeader$kuf_update_stat_batch.sru
forward
global type kuf_update_stat_batch from kuf_parent0
end type
end forward

global type kuf_update_stat_batch from kuf_parent0
end type
global kuf_update_stat_batch kuf_update_stat_batch

forward prototypes
public function string run_update_stat () throws uo_exception
public function st_esito u_batch_run () throws uo_exception
end prototypes

public function string run_update_stat () throws uo_exception;//
string k_return = ""
string k_esito = ""
integer k_rc
st_esito kst_esito
kuf_sp_update_stat kuf1_sp_update_stat


try	

	kst_esito = kguo_exception.inizializza(this.classname())

//--- lancio spl (datastore)
	kuf1_sp_update_stat = create kuf_sp_update_stat
	k_rc = kuf1_sp_update_stat.u_esegui( )
//	kdsp1_stat_start = create kdsp_stat_start 
//	kdsp1_stat_start.db_connetti()
//	k_rc = kdsp1_stat_start.retrieve( )
//	if k_rc > 0 then
	k_esito = trim(kuf1_sp_update_stat.ki_status)
		//k_esito = kdsp1_stat_start.getitemstring( 1, "esito")
//	end if			

	if k_rc < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = -1
		kst_esito.sqlerrtext = "Errore in Ottimizzazione DB: '" &
									  + k_esito + "': esito " + string (k_rc) 
	else
		if k_rc = 0 then
			kst_esito.esito = kkg_esito.ko
			kst_esito.sqlcode = 0
			kst_esito.sqlerrtext = "Anomalia in Ottimizzazione DB ' " &
										  + k_esito + " Nessun dato estratto! "
		else
			kst_esito.esito = kkg_esito.ok
			kst_esito.sqlcode = 0
			kst_esito.sqlerrtext = "Ottimizzazione DB terminata correttamente: " + k_esito

		end if
	end if
//			if left(k_esito,2) <> "Ok" then
//				kst_esito.esito = kkg_esito.ko
//				kst_esito.sqlcode = 0
//				kst_esito.sqlerrtext = "Anomalie in generazione Statistici ' " &
//											  + trim(kdsp1_stat_start.dataobject) + "' err.:" + trim(k_esito)
//			else
//			end if

//--- scrive l'errore su LOG
		kguo_exception.scrivi_log(kst_esito)
				
	
catch(uo_exception kuo_exception)
	throw kuo_exception

finally
//	if isvalid(kdsp1_stat_start) then destroy kdsp1_stat_start
	if isvalid(kuf1_sp_update_stat) then destroy kuf1_sp_update_stat
	
	k_return = kst_esito.sqlerrtext 

end try

return k_return

end function

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
string k_string
st_esito kst_esito


try 

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- Ottimizza DB (update statistics ecc...)
	k_string = run_update_stat( ) 
	if len(trim(k_string)) > 0 then
		kst_esito.SQLErrText = "Operazione conclusa. " + k_string
	else
		kst_esito.SQLErrText = "Operazione non eseguita. Nessuna Ottimizzazione del DB effettuata."
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

on kuf_update_stat_batch.create
call super::create
end on

on kuf_update_stat_batch.destroy
call super::destroy
end on

