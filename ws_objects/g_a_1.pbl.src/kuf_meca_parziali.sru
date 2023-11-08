$PBExportHeader$kuf_meca_parziali.sru
forward
global type kuf_meca_parziali from kuf_parent
end type
end forward

global type kuf_meca_parziali from kuf_parent
end type
global kuf_meca_parziali kuf_meca_parziali

type variables
//
kuf_armo kiuf_armo

end variables

forward prototypes
public subroutine _readme ()
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
end prototypes

public subroutine _readme ();/*
  Tabellina con indicazioni per la gestione dei Lotti Parziali 
*/
end subroutine

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return kiuf_armo.if_sicurezza(ast_open_w)



end function

public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception;//------------------------------------------------------------------------------------------------------
//---  Controllo dati utente
//---  inp: datastore con i dati da controllare
//---  out: datastore con  	ads_inp.object.<nome campo>.tag che può valere:
//												0=tutto OK (kkg_esito.ok); 
//												1=errore logico (bloccante) (kkg_esito.ERR_LOGICO); 
//												2=errore forma  (bloccante) (kkg_esito.err_formale);
//												3=dati insufficienti  (bloccante) (kkg_esito.DATI_INSUFF);
//												4=KO ma errore non grave  (NON bloccante) (kkg_esito.DB_WRN);
//---							               	W=OK con degli avvertimenti (NON bloccante) (kkg_esito.DATI_WRN);
//---  rit: 
//---
//---  per errore lancia EXCEPTION anche x i warning
//---
//---  CONSIGLIO DI COPIARE DA QUESTO ESTENDENDO I CONTROLLI
//---
//------------------------------------------------------------------------------------------------------
//
int k_errori = 0
long k_rows
int k_row
string k_tipo_errore="0", k_type, k_valore
st_esito kst_esito
st_tab_meca_parziali kst_tab_meca_parziali
DataWindowChild kdwc_1


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
// ESEMPIO
//	if trim(ads_inp.object.descr) > " "  then
//	else
//		k_errori ++
//		k_tipo_errore="3"      // errore in questo campo: dati insuff.
//		ads_inp.object.descr.tag = k_tipo_errore 
//		kst_esito.esito = kkg_esito.err_formale
//		kst_esito.sqlerrtext = "Manca descrizione nel campo " + trim(ads_inp.object.descr_t.text) +  "~n~r"  
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if
	ads_inp.GetChild ("stato", kdwc_1)
	
	k_rows =ads_inp.rowcount()
	k_errori = 0
	k_row =ads_inp.getnextmodified(0, primary!)

	do while k_row > 0  and k_errori < 99

		kst_tab_meca_parziali.id_meca = ads_inp.getitemnumber(k_row, "id_meca")
		if kst_tab_meca_parziali.id_meca > 0 and ads_inp.getitemnumber(k_row, "stato") = 0 then
			k_tipo_errore="1"
			ads_inp.modify("stato.tag = '" + k_tipo_errore + "' ")
			kst_esito.esito = kkg_esito.err_logico
			if k_errori > 0 then kst_esito.sqlerrtext += kkg.acapo
			kst_esito.sqlerrtext = "Stato '" + kdwc_1.getitemstring(kdwc_1.getrow(), "descr") + "' non compatibile. " &
					+ "Vedi alla riga " + string(k_row) 
			k_errori ++
		end if

		if k_tipo_errore <> "0"  and k_tipo_errore <> "4" and k_tipo_errore <> kkg_esito.DATI_WRN then
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		k_row++
		k_row = ads_inp.getnextmodified(k_row, primary!)

	loop
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if k_errori > 0 then
		
	end if
	
end try


return kst_esito
 
 
 
end function

event constructor;call super::constructor;//
kiuf_armo = create kuf_armo

end event

event destructor;call super::destructor;//
if isvalid(kiuf_armo) then destroy kiuf_armo

end event

on kuf_meca_parziali.create
call super::create
end on

on kuf_meca_parziali.destroy
call super::destroy
end on

