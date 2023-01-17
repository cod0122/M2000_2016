$PBExportHeader$kuf_asdtype.sru
forward
global type kuf_asdtype from kuf_parent
end type
end forward

global type kuf_asdtype from kuf_parent
end type
global kuf_asdtype kuf_asdtype

type variables
//
kuf_asddevice kiuf_asddevice
end variables

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
public function boolean if_exists_in_asddevice (ref st_tab_asddevice ast_tab_asddevice) throws uo_exception
public function boolean tb_delete (ref st_tab_asdtype ast_tab_asdtype) throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return kiuf_asddevice.if_sicurezza(ast_open_w)

end function

public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception;/*------------------------------------------------------------------------------------------------------
  Controllo dati 
  inp: datastore con i dati da controllare
  out: datastore con  	ads_inp.object.<nome campo>.tag che può valere:
											0=tutto OK (kkg_esito.ok); 
											1=errore logico (bloccante) (kkg_esito.ERR_LOGICO); 
												2=errore forma  (bloccante) (kkg_esito.err_formale);
												3=dati insufficienti  (bloccante) (kkg_esito.DATI_INSUFF);
												4=KO ma errore non grave  (NON bloccante) (kkg_esito.DB_WRN);
							              	W=OK con degli avvertimenti (NON bloccante) (kkg_esito.DATI_WRN);
  rit: 

  per errore lancia EXCEPTION anche x i warning
------------------------------------------------------------------------------------------------------
*/
int k_err = 0
int k_row
string k_tipo_errore="0"
st_esito kst_esito



try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	k_err = 0
	k_row =ads_inp.getnextmodified(0, primary!)

	do while k_row > 0 and k_err < 99

		if ads_inp.getitemnumber(k_row, "id_asdtype") > 0 &
				 or trim(ads_inp.getitemstring(k_row, "des")) > " " or trim(ads_inp.getitemstring(k_row, "code")) > " " then
				 
			if trim(ads_inp.getitemstring(k_row, "des")) > " " then
			else
				k_err ++
				k_tipo_errore="3"      // errore in questo campo: dati insuff.
				ads_inp.modify("des.tag = '" + k_tipo_errore + "' ")
				kst_esito.esito = kkg_esito.DATI_INSUFF
				kst_esito.sqlerrtext = "Indicare un valore nel campo '" &
						+ trim(ads_inp.describe(ads_inp.describe("des.name") + "_t.text")) &
						+ "' alla riga " + string(k_row) &
						+ "~n~r"  
			end if
			if trim(ads_inp.getitemstring(k_row, "code")) > " " then
			else
				k_err ++
				k_tipo_errore="3"      // errore in questo campo: dati insuff.
				ads_inp.modify("code.tag = '" + k_tipo_errore + "' ")
				kst_esito.esito = kkg_esito.DATI_INSUFF
				kst_esito.sqlerrtext = "Indicare un valore nel campo '" &
						+ trim(ads_inp.describe(ads_inp.describe("code.name") + "_t.text")) &
						+ "' alla riga " + string(k_row) &
						+ "~n~r"  
			end if
				
		end if		

		k_row++
		k_row = ads_inp.getnextmodified(k_row, primary!)

	loop
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally

	
end try


return kst_esito
 
 
 
end function

public function boolean if_exists_in_asddevice (ref st_tab_asddevice ast_tab_asddevice) throws uo_exception;/*
 Verifica se id_asdtype è già usato 
 inp: st_tab_asddevice.id_asdtype
 out: true = già usato
 ret: st_tab_asddevice.id_asddevice / des maggiore 
*/
boolean k_return
long k_rows
uo_ds_std_1 kds_1
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_asddevice.id_asdtype > 0 then
	
		kds_1 = create uo_ds_std_1
		kds_1.settransobject( kguo_sqlca_db_magazzino )
		kds_1.dataobject = "d_asddevice_l_x_id_asdtype"
		
		k_rows = kds_1.retrieve(ast_tab_asddevice.id_asdtype)
		if k_rows < 0 then
			kst_esito = kds_1.kist_esito
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlerrtext = "Errore in verifica se tipo di Device Ausiliario " &
										+ string(ast_tab_asddevice.id_asdtype) + " è già associato a un Device." &
										+ "~n~r" + "Esito: " + kds_1.kist_esito.sqlerrtext
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		else
			if k_rows > 0 then
				k_return = true
				ast_tab_asddevice.id_asddevice = kds_1.getitemnumber( 1, "id_asddevice")
				ast_tab_asddevice.des = kds_1.getitemstring( 1, "des")
			end if
		end if
	
	else
		
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione bloccata, manca id del tipo di Device Ausiliario"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally
	if isvalid(kds_1) then destroy kds_1


end try


return k_return
end function

public function boolean tb_delete (ref st_tab_asdtype ast_tab_asdtype) throws uo_exception;/*
 Cancella id_asdtype 
 inp: st_tab_asdtype.id_asdtype
 out: true = rimosso
 ret: 
*/
boolean k_return
st_esito kst_esito
st_tab_asddevice kst_tab_asddevice


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_asdtype.id_asdtype > 0 then
		
		kst_tab_asddevice.id_asdtype = ast_tab_asdtype.id_asdtype
	
		if if_exists_in_asddevice(kst_tab_asddevice) then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlerrtext = "Tipo di Device Ausiliario " + string(ast_tab_asdtype.id_asdtype) + " associato almeno a un Device. Rimozione non consentita." &
										+ "~r~nVedi ad esempio il Device " + string(kst_tab_asddevice.id_asddevice) + " - " + trim(kst_tab_asddevice.des) 
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	
		delete from asdtype
			where asdtype.id_asdtype = :ast_tab_asdtype.id_asdtype 
			using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Cancellazione Tipo di Device Ausiliario (asdtype) " + string(ast_tab_asdtype.id_asdtype) &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = KKG_esito.db_ko
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		k_return = true
		
	else
		
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di cancellazione bloccata, manca id del tipo di Device Ausiliario"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

event constructor;call super::constructor;//
kiuf_asddevice = create kuf_asddevice
end event

event destructor;call super::destructor;//
if isvalid(kiuf_asddevice) then destroy kiuf_asddevice

end event

on kuf_asdtype.create
call super::create
end on

on kuf_asdtype.destroy
call super::destroy
end on

