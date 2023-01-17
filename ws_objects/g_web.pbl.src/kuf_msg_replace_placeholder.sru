$PBExportHeader$kuf_msg_replace_placeholder.sru
forward
global type kuf_msg_replace_placeholder from nonvisualobject
end type
end forward

global type kuf_msg_replace_placeholder from nonvisualobject
end type
global kuf_msg_replace_placeholder kuf_msg_replace_placeholder

type variables
//
private datastore kids_placeholder_l

end variables

forward prototypes
public subroutine _readme ()
public function string u_message_replace_placeholder (st_msg_replace_placeholder kst_msg_replace_placeholder) throws uo_exception
private function string u_get_url_to_pickup_lot (long a_id_meca)
public function integer u_check_placeholder (st_msg_replace_placeholder kst_msg_replace_placeholder) throws uo_exception
public function string u_set_placeholder_to_lower (string a_message) throws uo_exception
private function string u_get_url_barcode_by_code (string a_code)
end prototypes

public subroutine _readme ();//---
//--- Oggetto per completare un messaggio sostituendo i segnaposto contenuti con i valori es.[idLotto] 
//---
end subroutine

public function string u_message_replace_placeholder (st_msg_replace_placeholder kst_msg_replace_placeholder) throws uo_exception;//--- 
//--- Completa la comunicazione email sostituendo i segnaposto con i valori
//--- inp: st_msg_replace_placeholder.msg + id_meca
//--- out: il nuovo messaggio 
//---
string k_return
int k_n_placeholder_max, k_n_placeholder, k_rc
string k_placeholder, k_value, k_url
kuf_armo kuf1_armo
st_tab_meca kst_tab_meca
st_esito kst_esito
datastore kds_placeholder_meca



try
	kst_esito = kguo_exception.inizializza(this.classname())

	if kst_msg_replace_placeholder.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione		
		kst_esito.sqlerrtext = "Errore in sostituzione nel messaggio dei segnaposto. Manca ID del Lotto"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- recupera i valori disponibili per i segnaposto
	kds_placeholder_meca = create datastore
	kds_placeholder_meca.dataobject = "ds_placeholder_meca"
	kds_placeholder_meca.settransobject(kguo_sqlca_db_magazzino)
	k_rc = kds_placeholder_meca.retrieve(kst_msg_replace_placeholder.id_meca)
	
	if k_rc > 0 then
		
		kuf1_armo = create kuf_armo
		kst_tab_meca.id = kst_msg_replace_placeholder.id_meca
		
		//--- converte i segnaposto nel messaggio in lowercase
		k_return = u_set_placeholder_to_lower(trim(kst_msg_replace_placeholder.msg)) 
		
		k_n_placeholder_max = kids_placeholder_l.rowcount() // max segnaposti disponibili	
		
		for k_n_placeholder = 1 to k_n_placeholder_max
			
			k_value = ""
			k_placeholder = kids_placeholder_l.getitemstring(k_n_placeholder, "code") //nome segnaposto
			choose case k_placeholder
					
				case "lottoritirolink" 
	//--- recupera il prefisso del link al url per il Ritiro Lotto	
					k_value = u_get_url_to_pickup_lot(kst_msg_replace_placeholder.id_meca)
					
				case "barcodeso" 
	//--- recupera il url al fabbricatore di barcode: SalesOrder di E1
					if kst_msg_replace_placeholder.id_meca > 0 then
						kuf1_armo.get_e1rorn(kst_tab_meca)
						if kst_tab_meca.e1rorn > 0 then						
							k_value = u_get_url_barcode_by_code(string(kst_tab_meca.e1rorn, "#"))
						end if
					end if
					
				case "barcodewo" 
	//--- recupera il url al fabbricatore di barcode: WorkOrder di E1
					if kst_msg_replace_placeholder.id_meca > 0 then
						kuf1_armo.get_e1doco(kst_tab_meca)
						if kst_tab_meca.e1doco > 0 then						
							k_value = u_get_url_barcode_by_code(string(kst_tab_meca.e1doco, "#"))
						end if
					end if
					
				case "barcodeidlottolink" 
	//--- recupera il url al fabbricatore di barcode: id lotto
					if kst_msg_replace_placeholder.id_meca > 0 then
						k_value = u_get_url_barcode_by_code(string(kst_msg_replace_placeholder.id_meca, "#"))
					end if
					
				case else
	//--- recupera il vaore dei segnaposto 'normali'
					k_value = kds_placeholder_meca.getitemstring(1, k_placeholder)
					
			end choose
	//--- sostituisce se esiste nel messaggio il valore nel segnaposto indicato 
			k_return = kguo_g.u_replace(k_return, "[" + k_placeholder + "]", trim(k_value))
		
		next
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = k_rc
		kst_esito.sqlerrtext = "Errore in sostituzione nel messaggio dei segnaposto, id Lotto: " &
									+ string(kst_msg_replace_placeholder.id_meca) &
									+ " non Trovato"  
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log()
	throw kuo_exception
	
finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
		
end try

return k_return

end function

private function string u_get_url_to_pickup_lot (long a_id_meca);//--- recupera il prefisso del link al url per il Ritiro Lotto	
string k_return
string k_esito_base, k_url, k_key
st_esito kst_esito
kuf_base kuf1_base


try
	kuf1_base = create kuf_base
	k_esito_base = kuf1_base.prendi_dato_base( "smart_pickup_lots_url_xbook")
	if left(k_esito_base,1) <> "0" then
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.SQLErrText = "Errore in lettura url per Ritiro Lotti. Errore: " + mid(k_esito_base,2)
		kguo_exception.set_esito(kst_esito)
	else
		k_url = trim(mid(k_esito_base,2))
	end if
	if k_url > " " then
		k_esito_base = kuf1_base.prendi_dato_base( "smart_pickup_lots_sha_key")
		if left(k_esito_base,1) <> "0" then
			kst_esito.esito = kkg_esito.db_ko  
			kst_esito.SQLErrText = "Errore in lettura chiave SHA per Ritiro Lotti. Errore: " + mid(k_esito_base,2)
			kguo_exception.set_esito(kst_esito)
		else
			k_key = trim(mid(k_esito_base,2))
		end if
		k_return = k_url + string(a_id_meca, "#") + "&check=" + k_key
	end if	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_base) then destroy kuf1_base
	
end try

return k_return 
end function

public function integer u_check_placeholder (st_msg_replace_placeholder kst_msg_replace_placeholder) throws uo_exception;//--- 
//--- Verifica e conta i segnaposto del messaggio
//--- inp: st_msg_replace_placeholder.msg 
//--- out: 
//--- Ret.: n. segnaposti trovati
//--- exception: lancia esception per segnaposto non corretti
//---
int k_return
string k_err_placeholder
string k_placeholder, k_placeholder_name
int k_pos_start, k_pos_fin, k_placeholder_nrows, k_find_row
st_esito kst_esito



try
	kst_esito = kguo_exception.inizializza(this.classname())

	k_placeholder_nrows = kids_placeholder_l.rowcount()
	if k_placeholder_nrows > 0 then
	
		k_pos_start = pos(kst_msg_replace_placeholder.msg, "[", 1) 
		do while k_pos_start > 0
			if k_pos_start > 0 then
				k_pos_fin = k_pos_start + 1
				k_pos_fin = pos(kst_msg_replace_placeholder.msg, "]", k_pos_fin) 
				if k_pos_fin > 0 then
					k_placeholder = (&
						mid(kst_msg_replace_placeholder.msg, k_pos_start, k_pos_fin - k_pos_start + 1))
					k_placeholder_name = lower(&
						mid(kst_msg_replace_placeholder.msg, k_pos_start + 1, k_pos_fin - k_pos_start - 1)) // toglie parentesi
					//--- verifica se esiste il segnaposto tra quelli previsti
					k_find_row = kids_placeholder_l.find("code = '" + k_placeholder_name + "'", 1, k_placeholder_nrows)
					if k_find_row > 0 then
						k_return ++
					else
						k_err_placeholder += k_placeholder + "; "
					end if
				end if
			end if
			k_pos_start = pos(kst_msg_replace_placeholder.msg, "[", (k_pos_fin + 1)) 
		loop
	
		if k_err_placeholder > " " then
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Attenzione segnaposto errato: " + k_err_placeholder
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
	else
		kst_esito.esito = kkg_esito.not_fnd
		kst_esito.sqlerrtext = "Attenzione nessun segnaposto trovato"
		kguo_exception.set_esito(kst_esito)
		kguo_exception.scrivi_log()
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log()
	throw kuo_exception
		
end try


return k_return

end function

public function string u_set_placeholder_to_lower (string a_message) throws uo_exception;//--- 
//--- Converte i segnaposto del messaggio in lowercase
//--- inp: messaggio
//--- out: 
//--- Ret.: messaggio con i segnaposto in lowercase
//--- exception: lancia esception per segnaposto non corretti
//---
string k_return
string k_err_placeholder
string k_placeholder
int k_pos_start, k_pos_fin, k_rc
st_esito kst_esito



try
	kst_esito = kguo_exception.inizializza(this.classname())

	k_rc = kids_placeholder_l.rowcount()
	if k_rc > 0 then
		k_pos_start = pos(a_message, "[", 1) 
		do while k_pos_start > 0
			if k_pos_start > 0 then
				k_pos_fin = k_pos_start + 1
				k_pos_fin = pos(a_message, "]", k_pos_fin) 
				if k_pos_fin > 0 then
					k_placeholder = lower(&
						mid(a_message, k_pos_start, k_pos_fin - k_pos_start + 1))
					//--- verifica se esiste il segnaposto tra quelli previsti
					a_message = replace(a_message, k_pos_start, k_pos_fin - k_pos_start + 1, k_placeholder)
				end if
			end if
			k_pos_start = pos(a_message, "[", (k_pos_fin + 1)) 
		loop
		
		k_return = a_message
		
	else
		kst_esito.esito = kkg_esito.not_fnd
		kst_esito.sqlerrtext = "Attenzione nessun segnaposto trovato: " + string(k_rc)
		kguo_exception.set_esito(kst_esito)
		kguo_exception.scrivi_log()
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
		
end try


return k_return

end function

private function string u_get_url_barcode_by_code (string a_code);//
//--- Compone il link a un sito che fabbrica barcode da una stringa
string k_return


try

	if trim(a_code) > " " then
	
		k_return = "https://www.barcodesinc.com/generator/image.php?code=" &
					+ trim(a_code) &
					+ "&style=196&type=C39&width=500&height=300&xres=3&font=5"

	end if	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
//	if isvalid(kuf1_base) then destroy kuf1_base
	
end try

return k_return 
end function

on kuf_msg_replace_placeholder.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_msg_replace_placeholder.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//
kids_placeholder_l = create datastore
kids_placeholder_l.dataobject = "d_placeholder_l"
//kids_placeholder_l.retrieve()
end event

event destructor;//
if isvalid(kids_placeholder_l) then destroy kids_placeholder_l
end event

