$PBExportHeader$kds_sl_pt_g3_lav_if_datilav_ok.sru
forward
global type kds_sl_pt_g3_lav_if_datilav_ok from ds_db_magazzino_parent
end type
end forward

global type kds_sl_pt_g3_lav_if_datilav_ok from ds_db_magazzino_parent
string dataobject = "ds_sl_pt_g3_lav_if_datilav_ok"
end type
global kds_sl_pt_g3_lav_if_datilav_ok kds_sl_pt_g3_lav_if_datilav_ok

forward prototypes
public function long get_datilav_x_ciclo (long a_id_armo, integer a_g3npass, integer a_g3ngiri, integer a_g3ciclo) throws uo_exception
end prototypes

public function long get_datilav_x_ciclo (long a_id_armo, integer a_g3npass, integer a_g3ngiri, integer a_g3ciclo) throws uo_exception;/*
Verifica che i dati passati abbiano un Trattamento Associato compatibile e ATTIVO
Inp: ID_ARMO + NPASS + NGIRI + CILCO DI RIFERIMENTO
Out: lo stesso datastore con i dati di trattamento trovati
Out: id_sl_pt_g3_lav
*/
long k_return 
int k_row

	
		k_row = this.retrieve(a_id_armo, a_g3npass, a_g3ngiri, a_g3ciclo)
		
		if k_row < 0 then
			kguo_exception.inizializza(this.classname())
			kguo_exception.set_esito(this.kist_esito)
			kguo_exception.kist_esito.sqlerrtext = "Errore in lettura Lavorazione G3 id riga Lotto: " + string(a_id_armo) &
											+ " Pass: " + string(a_g3npass) &
											+ " N. Giri: " + string(a_g3ngiri) &
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

on kds_sl_pt_g3_lav_if_datilav_ok.create
call super::create
end on

on kds_sl_pt_g3_lav_if_datilav_ok.destroy
call super::destroy
end on

