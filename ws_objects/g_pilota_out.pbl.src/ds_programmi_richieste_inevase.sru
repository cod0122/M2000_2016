$PBExportHeader$ds_programmi_richieste_inevase.sru
forward
global type ds_programmi_richieste_inevase from ds_plav_parent
end type
end forward

global type ds_programmi_richieste_inevase from ds_plav_parent
string dataobject = "ds_programmi_richieste_inevase"
end type
global ds_programmi_richieste_inevase ds_programmi_richieste_inevase

forward prototypes
public function long u_retrieve (long a_pl_barcode) throws uo_exception
end prototypes

public function long u_retrieve (long a_pl_barcode) throws uo_exception;//
long k_rows_inavase
uo_ds_std_1 kds_1
	
	k_rows_inavase = this.retrieve(a_pl_barcode)
	if k_rows_inavase < 0 then
		kds_1 = this
		kguo_exception.set_st_esito_err_ds(kds_1, "Errore in Ricerca Piani di Lavoro Inevasi ovvero l'operazione di invio al Pilota non conclusa, dal Codice PL " + string(a_pl_barcode) + ". ")
		throw kguo_exception
	end if

return k_rows_inavase
end function

on ds_programmi_richieste_inevase.create
call super::create
end on

on ds_programmi_richieste_inevase.destroy
call super::destroy
end on

