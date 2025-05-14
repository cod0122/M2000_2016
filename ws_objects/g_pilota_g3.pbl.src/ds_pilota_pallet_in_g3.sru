$PBExportHeader$ds_pilota_pallet_in_g3.sru
forward
global type ds_pilota_pallet_in_g3 from ds_pilota_g3_parent
end type
end forward

global type ds_pilota_pallet_in_g3 from ds_pilota_g3_parent
string dataobject = "ds_pilota_pallet_in_g3"
end type
global ds_pilota_pallet_in_g3 ds_pilota_pallet_in_g3

forward prototypes
public function long u_retrieve (date a_data_ini_da, long a_work_order) throws uo_exception
end prototypes

public function long u_retrieve (date a_data_ini_da, long a_work_order) throws uo_exception;/*
  Elenco dei Pallet che hanno Iniziato il Trattamento nel G3
  inp: data di inizio ricerca
  rit: numero righe trovate
*/
long k_rows
uo_ds_std_1 kds_1


	kguo_exception.inizializza( this.classname())

	k_rows = this.retrieve(a_data_ini_da, a_work_order)

	if k_rows < 0 then
		kds_1 = this
		kguo_exception.set_st_esito_err_ds( kds_1, &
					"Errore durante ricerca per Importazione dati di Inizio Lavorazione dall'impianto PILOTA G3. " &
					+ kkg.acapo + "Parametri dal " + string(a_data_ini_da) + " e WO n. " + string(a_work_order))
		throw kguo_exception
	end if


return k_rows
end function

on ds_pilota_pallet_in_g3.create
call super::create
end on

on ds_pilota_pallet_in_g3.destroy
call super::destroy
end on

