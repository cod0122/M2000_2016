$PBExportHeader$ds_pilota_impostazioni.sru
forward
global type ds_pilota_impostazioni from ds_pilota_g2_parent
end type
end forward

global type ds_pilota_impostazioni from ds_pilota_g2_parent
string dataobject = "ds_pilota_impostazioni_x_variabile"
end type
global ds_pilota_impostazioni ds_pilota_impostazioni

forward prototypes
public function integer get_num_intouchable () throws uo_exception
end prototypes

public function integer get_num_intouchable () throws uo_exception;/*
  Get il numero di RISERVE per FILA 1
*/
int k_rows 
int k_num_intouchable
uo_ds_std_1 kds_1


	kguo_exception.inizializza(this.classname())
	
	k_rows = retrieve("num_intouchable" )
  
  	if k_rows < 0 then
		kds_1 = this
		kguo_exception.set_st_esito_err_ds(kds_1 , "Errore in lettura numero pallet in Riserva 'num_intouchable' da Impostazioni G2 dal PILOTA.")
		throw kguo_exception
	end if

	if k_rows > 0 then
		if isnumber(this.getitemstring(1, "valore")) then
			k_num_intouchable = integer(this.getitemstring(1, "valore"))
		end if
	end if

return k_num_intouchable

end function

on ds_pilota_impostazioni.create
call super::create
end on

on ds_pilota_impostazioni.destroy
call super::destroy
end on

