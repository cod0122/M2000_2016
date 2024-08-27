$PBExportHeader$ds_storico_mastertimer_g2.sru
forward
global type ds_storico_mastertimer_g2 from ds_pilota_g2_parent
end type
end forward

global type ds_storico_mastertimer_g2 from ds_pilota_g2_parent
string dataobject = "ds_storico_mastertimer_g2"
end type
global ds_storico_mastertimer_g2 ds_storico_mastertimer_g2

forward prototypes
public function time get_tempo (datetime a_data_evento) throws uo_exception
public function integer u_retrieve () throws uo_exception
end prototypes

public function time get_tempo (datetime a_data_evento) throws uo_exception;/*
  Recupera il tempo Impianto: durata su ogni stazione
  	inp: data e ora di entrata in impianto
  	out: torna il tempo in minuti:secondi
  
*/
time k_tempo
int k_rows
uo_ds_std_1 kds_1


	kguo_exception.inizializza(this.classname())

	this.dataobject = "ds_storico_mastertimer_g2"
	this.settransobject( kguo_sqlca_db_pilota )	
	
	if date(a_data_evento) > kkg.data_zero then
	else
		a_data_evento = kguo_g.get_datetime_current( )
	end if
	
	k_rows = retrieve(a_data_evento)
	if k_rows < 0 then
		kds_1 = this
		kguo_exception.set_st_esito_err_ds(kds_1 , "Errore in lettura Tempi Impianto G2 dal PILOTA (" + kguo_sqlca_db_pilota.ki_db_descrizione + ") dalla data: " + string(a_data_evento)+". " )
		throw kguo_exception
	end if

	if k_rows > 0 then
		k_tempo = this.getitemtime(1, "tempo")
	end if


return k_tempo

end function

public function integer u_retrieve () throws uo_exception;/*
  get all tempi impianto
*/
int k_rows 
uo_ds_std_1 kds_1


	kguo_exception.inizializza(this.classname())
	
	this.dataobject = "d_storico_mastertimer_g2"
	this.settransobject( kguo_sqlca_db_pilota )
	
	k_rows = retrieve()
  
  	if k_rows < 0 then
		kds_1 = this
		kguo_exception.set_st_esito_err_ds(kds_1 , "Errore in lettura Tempi Impianto G2 dal Pilota 'storico_mastertimer'.")
		throw kguo_exception
	end if


return k_rows

end function

on ds_storico_mastertimer_g2.create
call super::create
end on

on ds_storico_mastertimer_g2.destroy
call super::destroy
end on

