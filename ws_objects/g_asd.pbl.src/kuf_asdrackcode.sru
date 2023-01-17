$PBExportHeader$kuf_asdrackcode.sru
forward
global type kuf_asdrackcode from kuf_parent
end type
end forward

global type kuf_asdrackcode from kuf_parent
end type
global kuf_asdrackcode kuf_asdrackcode

type variables
//
private string kki_rackcode_pref = "ASD"    // fisso questo prefisso per distinguere i Disp.Ausiliari

end variables

forward prototypes
public subroutine _readme ()
public function boolean tb_delete (ref st_tab_asdrackcode ast_tab_asdrackcode) throws uo_exception
public function boolean tb_delete_all (ref st_tab_asdrackcode ast_tab_asdrackcode) throws uo_exception
public function integer get_rackcode_count (readonly st_tab_asdrackcode ast_tab_asdrackcode) throws uo_exception
public function string get_rackcode_last () throws uo_exception
public function string u_rackcode_generate (string a_rackcode_last, integer a_n_rackcode, ref string a_rackcode[]) throws uo_exception
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function boolean if_rackcode_exists (string a_rackcode)
public function boolean if_rackcode_del (st_tab_asdrackcode ast_tab_asdrackcode) throws uo_exception
public function string get_rackcode (ref st_tab_asdrackcode ast_tab_asdrackcode) throws uo_exception
public function boolean if_rackcode_in_use (st_tab_asdrackcode ast_tab_asdrackcode) throws uo_exception
public function long get_id_asddevice (ref st_tab_asdrackcode ast_tab_asdrackcode) throws uo_exception
public function integer get_n_barcode_is_uso (st_tab_asdrackcode ast_tab_asdrackcode) throws uo_exception
public function boolean if_rackcode_in_lav (st_tab_asdrackcode ast_tab_asdrackcode) throws uo_exception
public function long get_id_asddevice_from_id_asdrackbarcode (long k_id_asdrackbarcode) throws uo_exception
end prototypes

public subroutine _readme ();/*
Rack associato al dispositivo ausiliario di schermatura/auxiliary shielding Dispositivos (asd)
*/
end subroutine

public function boolean tb_delete (ref st_tab_asdrackcode ast_tab_asdrackcode) throws uo_exception;/*
 Cancella Rack 
 inp: st_tab_asdrackcode.id_asdrackcode
 out: true = rimosso
 ret: 
*/
boolean k_return
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_asdrackcode.id_asdrackcode > 0 then

		if not if_rackcode_del(ast_tab_asdrackcode) then
			if trim(ast_tab_asdrackcode.rackcode) > " " then
			else
				get_rackcode(ast_tab_asdrackcode)
			end if
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Il Rack '" + ast_tab_asdrackcode.rackcode &
								+"' è associato a dei Barcode che non hanno completato la lavorazione, rimozione non consentita!"
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	
		delete from asdrackcode
			where asdrackcode.id_asdrackcode = :ast_tab_asdrackcode.id_asdrackcode 
			using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Cancellazione codice Rack del Dispositivo Ausiliario (asdrackcode) id " + string(ast_tab_asdrackcode.id_asdrackcode) &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = KKG_esito.db_ko
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		k_return = true
		
	else
		
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di cancellazione bloccata, manca codice ID Rack del Dispositivo Ausiliario"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

public function boolean tb_delete_all (ref st_tab_asdrackcode ast_tab_asdrackcode) throws uo_exception;/*
 Cancella tutti i codici Rack del Dispositivo
 inp: st_tab_asdbarcode.id_asddevice
 out: true = rimosso
 ret: 
*/
boolean k_return
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_asdrackcode.id_asddevice > 0 then
		
//		kst_tab_asdbarcode.id_asdbarcode = ast_tab_asdbarcode.id_asdbarcode
//		if if_exists_for_id_asdbarcode(kst_tab_asdbarcode) then
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlerrtext = "Barcode id '" + string(ast_tab_asdbarcode.id_asdbarcode) + "' del Dispositivo Ausiliario associato almeno a un Lotto. Rimozione non consentita." &
//										+ "~r~nVedi ad esempio il barcode " + string(kst_tab_asdbarcode.id_asdbarcode) + " - " + trim(kst_tab_asdbarcode.des) 
//			kguo_exception.set_esito(kst_esito)
//			throw kguo_exception
//		end if
	
		delete from asdrackcode
			where asdrackcode.id_asddevice = :ast_tab_asdrackcode.id_asddevice 
			using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Cancellazione di tutti i codici Rack del Dispositivo Ausiliario (asdrackcode) id " + string(ast_tab_asdrackcode.id_asddevice) &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = KKG_esito.db_ko
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		k_return = true
		
	else
		
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di cancellazione di tutti i codici Rack del Dispositivo bloccata, manca id del Dispositivo Ausiliario"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

public function integer get_rackcode_count (readonly st_tab_asdrackcode ast_tab_asdrackcode) throws uo_exception;/*
 Torna il numero dei codici Rack presenti per ID_ASDDEVICE
 inp: st_tab_asdrackcode.id_asddevice
 out: numero dei rackcode
 ret: 
*/
int k_return
st_esito kst_esito
st_tab_asdrackcode kst_tab_asdrackcode


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_asdrackcode.id_asddevice > 0 then
		
		select count(asdrackcode.id_asdrackcode)
		   into :k_return
		   from asdrackcode
			where asdrackcode.id_asddevice = :ast_tab_asdrackcode.id_asddevice 
			using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in conteggio codici Rack presenti del Dispositivo Ausiliario (asdrackcode) id " + string(ast_tab_asdrackcode.id_asddevice) &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = KKG_esito.db_ko
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
	else
		
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di conteggio codici Rack bloccata, manca id del Dispositivo Ausiliario"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

public function string get_rackcode_last () throws uo_exception;/*
 Torna l'ultimo rackcode in archivio
 inp: 
 out: ultimo rackcode
 ret: 
*/
string k_return
st_esito kst_esito
//st_tab_asdrackcode kst_tab_asdrackcode


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	select coalesce(max(asdrackcode.rackcode), '')
		into :k_return
		from asdrackcode
		where substring(asdrackcode.rackcode, 1, 3) = :kki_rackcode_pref
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura del massimo codice Rack del Dispositivo Ausiliario (asdrackcode) prefisso '" + trim( kki_rackcode_pref ) + "'" &
					 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = KKG_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
	if k_return > " " then
	else
		k_return = kki_rackcode_pref
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

public function string u_rackcode_generate (string a_rackcode_last, integer a_n_rackcode, ref string a_rackcode[]) throws uo_exception;/*
Genera rackcode univoci per Dispositivo Ausiliario
	
	inp: rackcode che potrebbe essere il più grande, numero rackcode da generare, array vuoto
	out: --, array di nuovi rackcode
	rit: l'ultimo rackcode genrato

*/
string k_return
string k_rackcode_iniziale 
	
	k_rackcode_iniziale = get_rackcode_last( )
	if k_rackcode_iniziale < a_rackcode_last then
		k_rackcode_iniziale = a_rackcode_last
	end if
	
	k_return = kguf_data_base.u_barcode_build(k_rackcode_iniziale, a_n_rackcode, a_rackcode[])

return k_return
end function

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

public function boolean if_rackcode_exists (string a_rackcode);/*
  Verifica che il codice rackcode sia Univoco		
  inp: rackcode da controllare
  ret: true = rackcode già usato, FALSE = univoco
*/ 
boolean k_return
int k_rc
st_tab_meca_dosim kst_tab_meca_dosim
kuf_meca_dosim kuf1_meca_dosim
uo_ds_std_1 kuo_ds_std_1


try
	
	kguo_exception.inizializza(this.classname())
	
	// verifica sui dispositivi
	kuo_ds_std_1 = create uo_ds_std_1
	kuo_ds_std_1.dataobject = "ds_asdrackcode_if_esiste"
	kuo_ds_std_1.settransobject( kguo_sqlca_db_magazzino )
	k_rc = kuo_ds_std_1.retrieve(a_rackcode)
	if k_rc < 1 then
		// verifica tra i Lotti 	
		kuo_ds_std_1.dataobject = "ds_barcode_rid"
		kuo_ds_std_1.settransobject( kguo_sqlca_db_magazzino )
		k_rc = kuo_ds_std_1.retrieve(a_rackcode)
		if k_rc < 1 then
			// verifica tra i dosimetri
			kuf1_meca_dosim = create kuf_meca_dosim
			kst_tab_meca_dosim.barcode = a_rackcode
			if kuf1_meca_dosim.if_esiste_barcode(kst_tab_meca_dosim) then
				
				k_return = true   
				
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuo_ds_std_1) then destroy kuo_ds_std_1
	if isvalid(kuf1_meca_dosim) then destroy kuf1_meca_dosim
	
end try
	
return k_return
end function

public function boolean if_rackcode_del (st_tab_asdrackcode ast_tab_asdrackcode) throws uo_exception;/*
Verifica se Rack è cancellabile dalla tabella
inp: ast_tab_asdrackcode.id_asdrackcode
rit: true = cancellabile
*/
boolean k_return


try

	if ast_tab_asdrackcode.id_asdrackcode > 0 then
		
		if if_rackcode_in_use(ast_tab_asdrackcode) then
		else
			k_return = true				
		end if
			
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return 

end function

public function string get_rackcode (ref st_tab_asdrackcode ast_tab_asdrackcode) throws uo_exception;/*
 Torna il rackcode
 inp: st_tab_asdrackcode.id_asdrackcode
 out: st_tab_asdrackcode.rackcode
 ret: st_tab_asdrackcode.rackcode
*/
string k_return
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	select coalesce(asdrackcode.rackcode, '')
		into :ast_tab_asdrackcode.rackcode
		from asdrackcode
		where asdrackcode.id_asdrackcode = :ast_tab_asdrackcode.id_asdrackcode
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura del codice Rack del Dispositivo Ausiliario (asdrackcode). Id Rack " + string( ast_tab_asdrackcode.id_asdrackcode ) + " " &
					 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = KKG_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
	if ast_tab_asdrackcode.rackcode > " " then
		k_return = ast_tab_asdrackcode.rackcode
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

public function boolean if_rackcode_in_use (st_tab_asdrackcode ast_tab_asdrackcode) throws uo_exception;/*
Verifica se Rack è ancora 'in uso'
inp: ast_tab_asdrackcode.id_asdrackcode
rit: true = IN USO
*/
boolean k_return
int k_rows


try

	if ast_tab_asdrackcode.id_asdrackcode > 0 then
		
		k_rows = get_n_barcode_is_uso(ast_tab_asdrackcode)
		
		//--- se ci sono delle righe ancora in uso allora non si può rimuovere
		if k_rows > 0 then
			
			k_return = true
			
		end if
		
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
		
finally
	
end try

return k_return 

end function

public function long get_id_asddevice (ref st_tab_asdrackcode ast_tab_asdrackcode) throws uo_exception;/*
 Torna il asddevice
 inp: st_tab_asdrackcode.id_asdrackcode
 out: st_tab_asdrackcode.id_asddevice
 ret: st_tab_asdrackcode.id_asddevice
*/
long k_return
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	select coalesce(asdrackcode.id_asddevice, 0)
		into :ast_tab_asdrackcode.id_asddevice
		from asdrackcode
		where asdrackcode.id_asdrackcode = :ast_tab_asdrackcode.id_asdrackcode
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura del id Dispositivo Ausiliario dal Rack (asdrackcode), Id " + string( ast_tab_asdrackcode.id_asdrackcode ) + " " &
					 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = KKG_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
	if ast_tab_asdrackcode.id_asddevice > 0 then
		k_return = ast_tab_asdrackcode.id_asddevice
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

public function integer get_n_barcode_is_uso (st_tab_asdrackcode ast_tab_asdrackcode) throws uo_exception;/*
 Torna il numero barcode che 'usano' il Raccode (ssociati e non con fine lavorazione)
 inp: st_tab_asdrackcode.id_asdrackcode
 out: 
 ret: numero barcode ancora nel RACK 
*/
long k_return
int k_row, k_rows
st_esito kst_esito
uo_ds_std_1 kds_1
st_tab_asdrackcode kst_tab_asdrackcode


try
	kst_esito = kguo_exception.inizializza(this.classname())

	if ast_tab_asdrackcode.id_asdrackcode > 0 then
		
	else
		
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di verifica se Rack occupato da barcode da trattare bloccata, manca codice ID del Rackcode del Dispositivo"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if

	kds_1 = create uo_ds_std_1
	kds_1.dataobject = "ds_asdrackcode_in_use_no_lav"
	kds_1.settransobject( kguo_sqlca_db_magazzino )
	
	k_rows = kds_1.retrieve(ast_tab_asdrackcode.id_asdrackcode)   //estrae tutti i barcode non Trattati
	if k_rows > 0 then  // Rack 'OCCUPATO' con barcode da trattare
	
		k_return = k_rows
			
	else
		if k_rows = 0 then  // Rack 'LIBERO' senza barcode da trattare

		else
			
			kguo_exception.inizializza(this.classname())
			kguo_exception.kist_esito.esito = kkg_esito.db_ko
			kguo_exception.kist_esito = kds_1.kist_esito
			kguo_exception.kist_esito.sqlerrtext = "Errore in verifica se il Rack id '" + trim(ast_tab_asdrackcode.rackcode) + "' è in uso (associato a qualche barcode ancora da trattare)."  &
									+ kkg.acapo + "(" + trim(kds_1.dataobject) + ") " + kds_1.kist_esito.sqlerrtext + " (" + string(kds_1.kist_esito.sqlcode) + ")"
			throw kguo_exception

		end if
		
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1

end try


return k_return
end function

public function boolean if_rackcode_in_lav (st_tab_asdrackcode ast_tab_asdrackcode) throws uo_exception;/*
Verifica se Rack è IN LAVORAZIONE
inp: ast_tab_asdrackcode.id_asdrackcode
rit: true = IN LAV
*/
boolean k_return
int k_rows
uo_ds_std_1 kds_1


try

	if ast_tab_asdrackcode.id_asdrackcode > 0 then
		
		kds_1 = create uo_ds_std_1
		kds_1.dataobject = "ds_asdrackcode_in_use_in_lav"
		kds_1.settransobject( kguo_sqlca_db_magazzino )
		
		k_rows = kds_1.retrieve(ast_tab_asdrackcode.id_asdrackcode)
		
		//--- se ci sono delle righe ancora in trattamento 
		if k_rows > 0 then
			
			k_return = true
			
		else
			
			if k_rows < 0 then
				
				kguo_exception.inizializza(this.classname())
				kguo_exception.kist_esito.esito = kkg_esito.db_ko
				kguo_exception.kist_esito.sqlerrtext = "Errore in verifica se il Rack '" + string(ast_tab_asdrackcode.id_asdrackcode) + "' è in Lavorazione. " &
										+ kkg.acapo + kds_1.kist_esito.sqlerrtext + " (" + string(kds_1.kist_esito.sqlcode) + ")"
				throw kguo_exception

			end if
			
		end if
		
	end if
	
catch (uo_exception kuo_exception)
		throw kuo_exception
		
finally
	if isvalid(kds_1) then destroy kds_1
	
end try

return k_return 

end function

public function long get_id_asddevice_from_id_asdrackbarcode (long k_id_asdrackbarcode) throws uo_exception;/*
 Torna il asddevice da ID_ASDRACKBARCODE
 inp: id_asdrackbarcode
 out: 
 ret: st_tab_asdrackcode.id_asddevice
*/
long k_return
st_tab_asdrackcode kst_tab_asdrackcode
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	select coalesce(asdrackcode.id_asddevice, 0)
		into :kst_tab_asdrackcode.id_asddevice
		from asdrackcode inner join asdrackbarcode on asdrackcode.id_asdrackcode = asdrackbarcode.id_asdrackcode
		where asdrackbarcode.id_asdrackbarcode = :k_id_asdrackbarcode
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura del id Dispositivo Ausiliario dal Rackcode (asdrackcode), Id " + string( k_id_asdrackbarcode ) + " " &
					 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = KKG_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
	if kst_tab_asdrackcode.id_asddevice > 0 then
		k_return = kst_tab_asdrackcode.id_asddevice
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

on kuf_asdrackcode.create
call super::create
end on

on kuf_asdrackcode.destroy
call super::destroy
end on

