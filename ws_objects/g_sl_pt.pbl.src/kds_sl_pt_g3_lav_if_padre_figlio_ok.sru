$PBExportHeader$kds_sl_pt_g3_lav_if_padre_figlio_ok.sru
forward
global type kds_sl_pt_g3_lav_if_padre_figlio_ok from kds_db_magazzino
end type
end forward

global type kds_sl_pt_g3_lav_if_padre_figlio_ok from kds_db_magazzino
string dataobject = "ds_sl_pt_g3_lav_if_padre_figlio_ok"
end type
global kds_sl_pt_g3_lav_if_padre_figlio_ok kds_sl_pt_g3_lav_if_padre_figlio_ok

forward prototypes
public function long get_datilav_figlio_if_ok (string a_barcode_figlio, long a_id_sl_pt_g3_lav_padre, integer a_g3ciclo) throws uo_exception
end prototypes

public function long get_datilav_figlio_if_ok (string a_barcode_figlio, long a_id_sl_pt_g3_lav_padre, integer a_g3ciclo) throws uo_exception;/*
Verifica che il barcode figlio passato abbia un Trattamento Associato compatibile con il PADRE
Inp: Barcode figlio + id_sl_pt_g3_lav del PADRE + CILCO DI RIFERIMENTO (se manca cerca in modo APPROSSIMATIVO) 
Out: lo stesso datastore con i dati di trattamento trovati
Out: id_sl_pt_g3_lav del figlio
*/
long k_return 
int k_row

	
		k_row = this.retrieve(a_barcode_figlio, a_id_sl_pt_g3_lav_padre, a_g3ciclo)
		
		if k_row < 0 then
			kguo_exception.inizializza(this.classname())
			kguo_exception.set_esito(this.kist_esito)
			kguo_exception.kist_esito.sqlerrtext = "Errore in verifica e lettura Lavorazione G3 del barcode figlio: " + trim(a_barcode_figlio) &
											+ " id lavorazione del Padre: " + string(a_id_sl_pt_g3_lav_padre) &
											+ " Ciclo: " + string(a_g3ciclo) &
											+ kkg.acapo + this.kist_esito.sqlerrtext
			kguo_exception.scrivi_log( )
			throw kguo_exception
		end if

		if k_row > 0 then
			if this.getitemnumber(1, "id_sl_pt_g3_lav") > 0 then
				k_return = this.getitemnumber(1, "id_sl_pt_g3_lav") 
			end if
		end if

return k_return 
      
end function

on kds_sl_pt_g3_lav_if_padre_figlio_ok.create
call super::create
end on

on kds_sl_pt_g3_lav_if_padre_figlio_ok.destroy
call super::destroy
end on

event constructor;call super::constructor;//
this.post settransobject( kguo_sqlca_db_magazzino )

end event

