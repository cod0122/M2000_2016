$PBExportHeader$ds_programmi_richieste_l.sru
forward
global type ds_programmi_richieste_l from ds_plav_parent
end type
end forward

global type ds_programmi_richieste_l from ds_plav_parent
string dataobject = "d_programmi_richieste_l"
end type
global ds_programmi_richieste_l ds_programmi_richieste_l

forward prototypes
public function long u_retrieve (date a_richiesta_data_ora) throws uo_exception
end prototypes

public function long u_retrieve (date a_richiesta_data_ora) throws uo_exception;/*
  get all tempi impianto
*/
int k_rows 
uo_ds_std_1 kds_1


	kguo_exception.inizializza(this.classname())
	
	if a_richiesta_data_ora > date(0) then
	else
		a_richiesta_data_ora = date(0) // datetime(date(0), time(0))
	end if

	k_rows = retrieve(a_richiesta_data_ora)
  
  	if k_rows < 0 then
		kds_1 = this
		kguo_exception.set_st_esito_err_ds(kds_1 , "Errore in lettura Programmi Inviati al Pilota (tab.'Programmi_Richieste') dal " + string(a_richiesta_data_ora) + ".")
		throw kguo_exception
	end if


return k_rows

end function

on ds_programmi_richieste_l.create
call super::create
end on

on ds_programmi_richieste_l.destroy
call super::destroy
end on

