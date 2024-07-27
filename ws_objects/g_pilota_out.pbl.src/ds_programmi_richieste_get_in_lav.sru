$PBExportHeader$ds_programmi_richieste_get_in_lav.sru
forward
global type ds_programmi_richieste_get_in_lav from ds_plav_parent
end type
end forward

global type ds_programmi_richieste_get_in_lav from ds_plav_parent
string dataobject = "ds_programmi_richieste_get_in_lav"
end type
global ds_programmi_richieste_get_in_lav ds_programmi_richieste_get_in_lav

forward prototypes
public function boolean if_richieste_in_lav () throws uo_exception
end prototypes

public function boolean if_richieste_in_lav () throws uo_exception;/*
 Verifica se nelle ultime ore ci sono delle richieste ancora in Attesa di essere Evase dal Pilota
 
 Ret: TRUE: Presenti Richieste inviate e ancora da evadere
 
*/
boolean k_return 
string k_dt  //formato: 2024-02-27T12:09:22.0002024-02-27T12:09:22.000
long k_row


	if now() > time(04,01,00) then 
		k_dt = string(datetime(today(), relativetime(now(), -1 * (60*60*4))), "yyyy-mm-ddThh:mm:ss")   // toglie 4 ore 
	else
		k_dt = string(datetime(relativedate(today(), - 1), relativetime(time(23,59,00), -1 * (60*60*4))), "dd-mm-yyyy hh:mm:ss") // toglie 4 ore dalla mezzanotte
	end if
	
	k_row = this.retrieve(k_dt)
	if k_row < 0 then
		kguo_exception.inizializza(this.classname())
		kguo_exception.set_esito(this.kist_esito)
		kguo_exception.kist_esito.sqlerrtext = "Errore in lettura Richieste ancora da Evadere dal " + string(k_dt) + ". " + kkg.acapo + this.kist_esito.sqlerrtext
		kguo_exception.scrivi_log( )
		throw kguo_exception
	end if
	
	if k_row > 0 then
		k_return = true
	end if

return k_return
end function

on ds_programmi_richieste_get_in_lav.create
call super::create
end on

on ds_programmi_richieste_get_in_lav.destroy
call super::destroy
end on

