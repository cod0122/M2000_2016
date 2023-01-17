$PBExportHeader$kuf_asdslpt.sru
forward
global type kuf_asdslpt from kuf_parent
end type
end forward

global type kuf_asdslpt from kuf_parent
end type
global kuf_asdslpt kuf_asdslpt

type variables
//

end variables

forward prototypes
public subroutine _readme ()
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function string get_cod_sl_pt (ref st_tab_asdslpt ast_tab_asdslpt) throws uo_exception
public function integer get_cod_sl_pt_count_x_id_asddevice (readonly st_tab_asdslpt ast_tab_asdslpt) throws uo_exception
public function boolean tb_delete (ref st_tab_asdslpt ast_tab_asdslpt) throws uo_exception
public function boolean tb_delete_all_x_id_asddevice (ref st_tab_asdslpt ast_tab_asdslpt) throws uo_exception
public function boolean tb_delete_all_x_cod_sl_pt (ref st_tab_asdslpt ast_tab_asdslpt) throws uo_exception
public function long get_id_asdslpt_last () throws uo_exception
public function long u_add (ref st_tab_asdslpt ast_tab_asdslpt) throws uo_exception
end prototypes

public subroutine _readme ();/*
SL_PT associati al dispositivo ausiliario di schermatura/auxiliary shielding Dispositivos (asd)
*/
end subroutine

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
boolean k_return


try
	kuf_asddevice kuf1_asddevice

	k_return = kuf1_asddevice.if_sicurezza(ast_open_w)

catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally
	if isvalid(kuf1_asddevice) then destroy kuf1_asddevice
	
	
end try


return k_return


end function

public function string get_cod_sl_pt (ref st_tab_asdslpt ast_tab_asdslpt) throws uo_exception;/*
 Torna il codice del Piano di Trattamento 
 inp: st_tab_asdslpt.id_asdslpt
 out: cod_sl_pt
 ret: cod_sl_pt
*/
string k_return
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_asdslpt.id_asdslpt > 0 then
		
		select cod_sl_pt
		   into :ast_tab_asdslpt.cod_sl_pt
		   from asdslpt
			where asdslpt.id_asdslpt = :ast_tab_asdslpt.id_asdslpt 
			using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettura asscociazione tra Piano di Trattamento e Dispositivo Ausiliario (asdslpt) id " + string(ast_tab_asdslpt.id_asdslpt) &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = KKG_esito.db_ko
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		if ast_tab_asdslpt.cod_sl_pt > " " then
			k_return = ast_tab_asdslpt.cod_sl_pt
		end if
		
	else
		
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di lettura asscociazione tra Piano di Trattamento e Dispositivo Ausiliario, bloccata, manca id dell'associazione"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

public function integer get_cod_sl_pt_count_x_id_asddevice (readonly st_tab_asdslpt ast_tab_asdslpt) throws uo_exception;/*
 Torna il numero dei codici PT presenti per ID_ASDDEVICE
 inp: st_tab_asdslpt.id_asddevice
 out: numero dei slpt
 ret: 
*/
int k_return
st_esito kst_esito
st_tab_asdslpt kst_tab_asdslpt


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_asdslpt.id_asddevice > 0 then
		
		select count(asdslpt.id_asdslpt)
		   into :k_return
		   from asdslpt
			where asdslpt.id_asddevice = :ast_tab_asdslpt.id_asddevice 
			using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in conteggio associazioni tra Piani di Trattamento e Dispositivo Ausiliario (asdslpt) id " + string(ast_tab_asdslpt.id_asddevice) &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = KKG_esito.db_ko
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
	else
		
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di conteggio associazioni Piani di Trattamento, manca id del Dispositivo Ausiliario (asdslpt)"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

public function boolean tb_delete (ref st_tab_asdslpt ast_tab_asdslpt) throws uo_exception;/*
 Cancella Riga 
 inp: st_tab_asdslpt.id_asdslpt
 out: true = rimosso
 ret: 
*/
boolean k_return
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_asdslpt.id_asdslpt > 0 then
		
//		kst_tab_asdslpt.id_asdslpt = ast_tab_asdslpt.id_asdslpt
//		if if_exists_for_id_asdslpt(kst_tab_asdslpt) then
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlerrtext = "rackcode id '" + string(ast_tab_asdslpt.id_asdslpt) + "' del Dispositivo Ausiliario associato almeno a un Lotto. Rimozione non consentita." &
//										+ "~r~nVedi ad esempio il rackcode " + string(kst_tab_asdslpt.id_asdslpt) + " - " + trim(kst_tab_asdslpt.des) 
//			kguo_exception.set_esito(kst_esito)
//			throw kguo_exception
//		end if
	
		delete from asdslpt
			where asdslpt.id_asdslpt = :ast_tab_asdslpt.id_asdslpt 
			using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Cancellazione Associazione tra Piano del Trattamento e Dispositivo Ausiliario (asdslpt) id " + string(ast_tab_asdslpt.id_asdslpt) &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = KKG_esito.db_ko
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		k_return = true
		
	else
		
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di cancellazione Associazione del Piano del Trattamento, bloccata, manca ID dell'associazione"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

public function boolean tb_delete_all_x_id_asddevice (ref st_tab_asdslpt ast_tab_asdslpt) throws uo_exception;/*
 Cancella tutte le associazioni del Dispositivo
 inp: st_tab_asdbarcode.id_asddevice
 out: true = rimosso
 ret: 
*/
boolean k_return
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_asdslpt.id_asddevice > 0 then
		
//		kst_tab_asdbarcode.id_asdbarcode = ast_tab_asdbarcode.id_asdbarcode
//		if if_exists_for_id_asdbarcode(kst_tab_asdbarcode) then
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlerrtext = "Barcode id '" + string(ast_tab_asdbarcode.id_asdbarcode) + "' del Dispositivo Ausiliario associato almeno a un Lotto. Rimozione non consentita." &
//										+ "~r~nVedi ad esempio il barcode " + string(kst_tab_asdbarcode.id_asdbarcode) + " - " + trim(kst_tab_asdbarcode.des) 
//			kguo_exception.set_esito(kst_esito)
//			throw kguo_exception
//		end if
	
		delete from asdslpt
			where asdslpt.id_asddevice = :ast_tab_asdslpt.id_asddevice 
			using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Cancellazione di tutte le associazione del Piano di Trattamento del Dispositivo Ausiliario (asdslpt) id " + string(ast_tab_asdslpt.id_asddevice) &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = KKG_esito.db_ko
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		k_return = true
		
	else
		
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di cancellazione di tutte le associazione del Piano di Trattamento del Dispositivo bloccata, manca id del Dispositivo Ausiliario"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

public function boolean tb_delete_all_x_cod_sl_pt (ref st_tab_asdslpt ast_tab_asdslpt) throws uo_exception;/*
 Cancella associazioni Piano di Trattamento
 inp: st_tab_asdslpt.cod_sl_pt
 out: true = rimosso
 ret: 
*/
boolean k_return
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if trim(ast_tab_asdslpt.cod_sl_pt) > " " then
		
		delete from asdslpt
			where asdslpt.cod_sl_pt = :ast_tab_asdslpt.cod_sl_pt
			using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Cancellazione associazioni del Piano di Trattamento del Dispositivo Ausiliario (asdslpt): " + trim(ast_tab_asdslpt.cod_sl_pt) &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = KKG_esito.db_ko
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		k_return = true
		
	else
		
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di cancellazione associazioni del Piano di Trattamento del Dispositivo Ausiliario, bloccata, manca codice del Piano di Trattamento"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

public function long get_id_asdslpt_last () throws uo_exception;/*
 Torna l'ultimo ID dell'associazione al codice del Piano di Trattamento 
 inp: 
 out: 
 ret: id_asdslpt
*/
long k_return
st_tab_asdslpt kst_tab_asdslpt
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
		
	select max(id_asdslpt)
		   into :kst_tab_asdslpt.id_asdslpt
		   from asdslpt
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura dell'ultimo ID di associazione tra Piano di Trattamento e Dispositivo Ausiliario" &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = KKG_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
	if kst_tab_asdslpt.id_asdslpt > 0 then
		k_return = kst_tab_asdslpt.id_asdslpt
	end if
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

public function long u_add (ref st_tab_asdslpt ast_tab_asdslpt) throws uo_exception;/*
 Aggiunge associazione il id_asddevice+cod_sl_pt 
 inp: st_tab_asdslpt.id_asddevice + cod_sl_pt
 out: id_asdlspt
 ret: id_asdlspt
*/
long k_return
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_asdslpt.id_asddevice > 0 and trim(ast_tab_asdslpt.cod_sl_pt) > " " then

		ast_tab_asdslpt.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_asdslpt.x_utente = kGuf_data_base.prendi_x_utente()
		
		insert into asdslpt
			 (cod_sl_pt
			   ,id_asddevice
			   ,x_datins 
				,x_utente
				)
			values
				(:ast_tab_asdslpt.cod_sl_pt
				,:ast_tab_asdslpt.id_asddevice
				,:ast_tab_asdslpt.x_datins
				,:ast_tab_asdslpt.x_utente		
				)
			using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in inserimento Associazione tra Piano di Trattamento e Dispositivo Ausiliario (asdslpt)" &
						 + " (PT: '" + trim(ast_tab_asdslpt.cod_sl_pt) &
						 + "' e Disp.: '" + string(ast_tab_asdslpt.id_asddevice) + "'" &
						 + " ~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = KKG_esito.db_ko
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	
		ast_tab_asdslpt.id_asdslpt = get_id_asdslpt_last( )
		
		if ast_tab_asdslpt.id_asdslpt > 0 then
			k_return = ast_tab_asdslpt.id_asdslpt
		end if
			
	else
		
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di inserimento Associazione del Piano di Trattamento bloccata, manca codice ID del Dispositivo Ausiliario o del Piano."
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

on kuf_asdslpt.create
call super::create
end on

on kuf_asdslpt.destroy
call super::destroy
end on

