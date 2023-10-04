$PBExportHeader$kuf_asddevice.sru
forward
global type kuf_asddevice from kuf_parent
end type
end forward

global type kuf_asddevice from kuf_parent
end type
global kuf_asddevice kuf_asddevice

type variables

end variables

forward prototypes
public subroutine _readme ()
public function boolean tb_delete (ref st_tab_asddevice ast_tab_asddevice) throws uo_exception
private function boolean tb_delete_row (ref st_tab_asddevice ast_tab_asddevice) throws uo_exception
public function long get_id_asddevice_last () throws uo_exception
end prototypes

public subroutine _readme ();/*
dispositivi ausiliari di schermatura/auxiliary shielding devices (asd)
*/
end subroutine

public function boolean tb_delete (ref st_tab_asddevice ast_tab_asddevice) throws uo_exception;/*
 Cancella id_asddevice 
 inp: st_tab_asddevice.id_asddevice
 out: true = rimosso
 ret: 
*/
boolean k_return
st_esito kst_esito
st_tab_asdrackcode kst_tab_asdrackcode
kuf_asdrackcode kuf1_asdrackcode


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_asddevice.id_asddevice > 0 then
		
		kuf1_asdrackcode = create kuf_asdrackcode
		kst_tab_asdrackcode.id_asddevice = ast_tab_asddevice.id_asddevice
		kuf1_asdrackcode.tb_delete_all(kst_tab_asdrackcode)
		
		tb_delete_row(ast_tab_asddevice)
		
		k_return = true
		
	else
		
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di cancellazione bloccata, manca id del Device Ausiliario"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally
	if isvalid(kuf1_asdrackcode) then destroy kuf1_asdrackcode

end try


return k_return
end function

private function boolean tb_delete_row (ref st_tab_asddevice ast_tab_asddevice) throws uo_exception;/*
 Cancella id_asddevice 
 inp: st_tab_asddevice.id_asddevice
 out: true = rimosso
 ret: 
*/
boolean k_return
st_esito kst_esito
st_tab_asddevice kst_tab_asddevice


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_asddevice.id_asddevice > 0 then
		
		kst_tab_asddevice.id_asddevice = ast_tab_asddevice.id_asddevice
	
//		if if_exists_for_id_asddevice(kst_tab_asddevice) then
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlerrtext = "Device Ausiliario " + string(ast_tab_asddevice.id_asddevice) + " associato almeno a un Lotto. Rimozione non consentita." &
//										+ "~r~nVedi ad esempio il barcode " + string(kst_tab_asddevice.id_asddevice) + " - " + trim(kst_tab_asddevice.des) 
//			kguo_exception.set_esito(kst_esito)
//			throw kguo_exception
//		end if
	
		delete from asddevice
			where asddevice.id_asddevice = :ast_tab_asddevice.id_asddevice 
			using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Cancellazione Device Ausiliario (asddevice) " + string(ast_tab_asddevice.id_asddevice) &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = KKG_esito.db_ko
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		k_return = true
		
	else
		
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di cancellazione bloccata, manca id del Device Ausiliario"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

public function long get_id_asddevice_last () throws uo_exception;/*
 Torna l'ultimo ID Device (Dispositivo Ausiliario caricato) 
 inp: 
 out: 
 ret: id_asddevice
*/
long k_return
st_tab_asddevice kst_tab_asddevice
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
		
	select max(id_asddevice)
		   into :kst_tab_asddevice.id_asddevice
		   from asddevice
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura dell'ultimo Id Dispositivo Ausiliario caricato in archivio" &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = KKG_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
	if kst_tab_asddevice.id_asddevice > 0 then
		k_return = kst_tab_asddevice.id_asddevice
	end if
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

on kuf_asddevice.create
call super::create
end on

on kuf_asddevice.destroy
call super::destroy
end on

