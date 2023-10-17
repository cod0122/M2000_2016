$PBExportHeader$kuf_asd_zoom.sru
forward
global type kuf_asd_zoom from kuf_parent
end type
end forward

global type kuf_asd_zoom from kuf_parent
end type
global kuf_asd_zoom kuf_asd_zoom

type variables
//
kuf_asddevice kiuf_asddevice

end variables

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
private function boolean anteprima_x_barcode (ref uo_ds_std_1 kds_anteprima, st_tab_asdrackbarcode kst_tab_asdrackbarcode) throws uo_exception
private function boolean anteprima_x_asddevice (ref uo_ds_std_1 kds_anteprima, st_tab_asdrackcode kst_tab_asdrackcode) throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------
//--- Controlla lasciato a kuf_asddevice
//---------------------------------------------------------------------------------------------------------------------------

return kiuf_asddevice.if_sicurezza(ast_open_w)

end function

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;/*
  Attiva LINK cliccato 
 
  Par. Inut: 
                datawindow su cui è stato attivato il LINK
                nome campo di LINK
  
  Rit: TRUE = ok 
  
*/
  
long k_rc
boolean k_return=true
string k_title, k_rcx
st_tab_asdrackbarcode kst_tab_asdrackbarcode
//st_tab_asddevice kst_tab_asddevice 
st_tab_asdrackcode kst_tab_asdrackcode
st_esito kst_esito
kuf_asdrackcode kuf1_asdrackcode
kuf_elenco kuf1_elenco
uo_ds_std_1 kdsi_elenco_output   //ds da passare alla windows di elenco


try 

	if_sicurezza(kkg_flag_modalita.anteprima)  // verifica sicurezza

	SetPointer(kkg.pointer_attesa)
	kdsi_elenco_output = create uo_ds_std_1

	kst_esito = kguo_exception.inizializza(this.classname())

	choose case a_campo_link
	
		case "b_asdrackbarcode", "b_asdrackbarcode_1"
			a_campo_link = "barcode"
			k_rcx = adw_link.describe(a_campo_link + ".color")
			if k_rcx = "!" or k_rcx = "?" then
				a_campo_link = "barcode_barcode"
				k_rcx = adw_link.describe(a_campo_link + ".color")
			end if			
			if k_rcx = "!" or k_rcx = "?" then
				k_return = false
			else
				kst_tab_asdrackbarcode.barcode = adw_link.getitemstring(adw_link.getrow(), a_campo_link)
				if trim(kst_tab_asdrackbarcode.barcode) > " " then
			
					anteprima_x_barcode ( kdsi_elenco_output, kst_tab_asdrackbarcode )
					k_title = "Rack del Barcode : " + trim(string(kst_tab_asdrackbarcode.barcode,"@@@ @@@@@@@@@")) 
					
				else
					k_return = false
				end if
			end if

		case "id_asdrackcode", "id_asddevice", "id_asdrackbarcode"
			kuf1_asdrackcode = create kuf_asdrackcode
			a_campo_link = "id_asddevice"
			k_rcx = adw_link.describe(a_campo_link + ".color")
			if k_rcx = "!" or k_rcx = "?" then
				a_campo_link = "id_asdrackcode"
				k_rcx = adw_link.describe(a_campo_link + ".color")
				if k_rcx = "!" or k_rcx = "?" then
					a_campo_link = "id_asdrackbarcode"
					k_rcx = adw_link.describe(a_campo_link + ".color")
					if k_rcx = "!" or k_rcx = "?" then
					else
						kst_tab_asdrackbarcode.id_asdrackbarcode = adw_link.getitemnumber(adw_link.getrow(), a_campo_link)
						kst_tab_asdrackcode.id_asddevice = kuf1_asdrackcode.get_id_asddevice_from_id_asdrackbarcode(kst_tab_asdrackbarcode.id_asdrackbarcode)
					end if
				else
					kst_tab_asdrackcode.id_asdrackcode = adw_link.getitemnumber(adw_link.getrow(), a_campo_link)
					kst_tab_asdrackcode.id_asddevice = kuf1_asdrackcode.get_id_asddevice(kst_tab_asdrackcode)
				end if
			else
				kst_tab_asdrackcode.id_asddevice = adw_link.getitemnumber(adw_link.getrow(), a_campo_link)
			end if			

			if kst_tab_asdrackcode.id_asddevice > 0 then
			
				anteprima_x_asddevice ( kdsi_elenco_output, kst_tab_asdrackcode )
				k_title = "Rack del Dispositivo id: " + string(kst_tab_asdrackcode.id_asddevice) 
					
			else
				k_return = false
			end if
	
	end choose
	
	
	if k_return then

		if kdsi_elenco_output.rowcount() > 0 then

			kuf1_elenco = create kuf_elenco
			kuf1_elenco.u_open_zoom(k_title, a_campo_link, kdsi_elenco_output) //CAMPO DI LINK + DATASTORE CON I DATI
	
		else
		
			kguo_exception.setmessage(u_get_errmsg_nontrovato(kkg_flag_modalita.elenco))
			throw kguo_exception
		
		end if

	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally 
	if isvalid(kuf1_asdrackcode) then destroy kuf1_asdrackcode
	if isvalid(kuf1_elenco) then destroy kuf1_elenco
	SetPointer(kkg.pointer_default)
	

end try


return k_return

end function

private function boolean anteprima_x_barcode (ref uo_ds_std_1 kds_anteprima, st_tab_asdrackbarcode kst_tab_asdrackbarcode) throws uo_exception;/*
  Operazione di preparazione datastore dei dati richiesti
 
  Inut:  
                datastore su cui fare l'anteprima
                dati tabella per estrazione dell'anteprima
  Out: datastore di anteprima
  
  Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
                                      2=Errore gestito
                                      3=altro errore
                                      100=Non trovato 
  
*/
long k_rc
boolean k_return


	kguo_exception.inizializza(this.classname())

	//if_sicurezza(kkg_flag_modalita.anteprima)

	if trim(kst_tab_asdrackbarcode.barcode) > " " then

		kds_anteprima.dataobject = "d_asdrackbarcode_l_x_barcode"
		kds_anteprima.settransobject(sqlca)

		kds_anteprima.reset()	
		k_rc=kds_anteprima.retrieve(kst_tab_asdrackbarcode.barcode)
		if k_rc < 0 then
			kguo_exception.kist_esito = kds_anteprima.kist_esito
			kguo_exception.kist_esito.sqlerrtext = "Errore in lettura dati Rack del barcode di lav.: " + trim(kst_tab_asdrackbarcode.barcode) &
			                                    + kkg.acapo + kds_anteprima.kist_esito.sqlerrtext
			throw kguo_exception
		end if
		
		if k_rc > 0 then
			k_return = true
		end if
		
	end if


return k_return

end function

private function boolean anteprima_x_asddevice (ref uo_ds_std_1 kds_anteprima, st_tab_asdrackcode kst_tab_asdrackcode) throws uo_exception;/*
  Operazione di preparazione datastore dei dati richiesti
 
  Inut:  
                datastore su cui fare l'anteprima
                dati tabella per estrazione dell'anteprima
  Out: datastore di anteprima
  
  Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
                                      2=Errore gestito
                                      3=altro errore
                                      100=Non trovato 
  
*/
long k_rc
boolean k_return


	kguo_exception.inizializza(this.classname())

	//if_sicurezza(kkg_flag_modalita.anteprima)

	if kst_tab_asdrackcode.id_asddevice > 0 then

		kds_anteprima.dataobject = "d_asddevice"
		kds_anteprima.settransobject(sqlca)

		kds_anteprima.reset()	
		k_rc=kds_anteprima.retrieve(kst_tab_asdrackcode.id_asddevice)
		if k_rc < 0 then
			kguo_exception.kist_esito = kds_anteprima.kist_esito
			kguo_exception.kist_esito.sqlerrtext = "Errore in lettura Schermatura, Dispositivo id: " + string(kst_tab_asdrackcode.id_asddevice) &
			                                    + kkg.acapo + kds_anteprima.kist_esito.sqlerrtext
			throw kguo_exception
		end if
		
		if k_rc > 0 then
			k_return = true
		end if
		
	end if


return k_return

end function

on kuf_asd_zoom.create
call super::create
end on

on kuf_asd_zoom.destroy
call super::destroy
end on

event destructor;call super::destructor;//
if isvalid(kiuf_asddevice) then destroy kiuf_asddevice

end event

event constructor;call super::constructor;//
kiuf_asddevice = create kuf_asddevice
end event

