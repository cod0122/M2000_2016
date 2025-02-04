$PBExportHeader$kuf_alarm_pltparz_email.sru
forward
global type kuf_alarm_pltparz_email from kuf_parent
end type
end forward

global type kuf_alarm_pltparz_email from kuf_parent
end type
global kuf_alarm_pltparz_email kuf_alarm_pltparz_email

type variables
//--- attivo
constant string kki_attivo_si = "S"
constant string kki_attivo_no = "N"

//--- cartella allegati email avvisi interni
private string ki_path_alarm = ""

//--- modo di calcolo dei tempi di Giacenza: ki_calc_stocktime
constant int ki_calc_stocktime_by_data_ent = 1
constant int ki_calc_stocktime_by_certif_data = 5

end variables

forward prototypes
public subroutine _readme ()
public function integer u_add_email () throws uo_exception
private function boolean u_if_email_parzialecolli_warning (ref kuf_email_invio kuf1_email_invio, ref st_tab_email_invio kst_tab_email_invio, ref kuf_clienti_altro kuf1_clienti_altro) throws uo_exception
public function st_esito u_batch_run () throws uo_exception
end prototypes

public subroutine _readme ();//
//--- Email generate degli avvisi per PALLET PARZIALI 
end subroutine

public function integer u_add_email () throws uo_exception;//---
//--- Carico Avvisi tra le email da inviare
//---
int k_return
int k_rows, k_row
datetime k_today
st_tab_email_invio kst_tab_email_invio, kst_tab_email_invio_void
st_tab_email_funzioni kst_tab_email_funzioni
st_tab_email kst_tab_email
st_msg_replace_placeholder kst_msg_replace_placeholder
kuf_email kuf1_email
kuf_email_funzioni kuf1_email_funzioni
kuf_email_invio kuf1_email_invio
uo_ds_std_1 kds_pilota_avvisi
kuf_clienti_altro kuf1_clienti_altro
kuf_msg_replace_placeholder kuf1_msg_replace_placeholder


try 

	kguo_exception.inizializza(this.classname())

	kuf1_email = create kuf_email
	kuf1_email_funzioni = create kuf_email_funzioni
	kuf1_email_invio = create kuf_email_invio
	kuf1_clienti_altro = create kuf_clienti_altro
	kuf1_msg_replace_placeholder = create kuf_msg_replace_placeholder

	if not kuf1_email.if_presente_x_cod_funzione(kuf1_email_funzioni.kki_cod_funzione_avvLottoPltParziale) then
		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_non_eseguito
		kguo_exception.kist_esito.sqlerrtext = "Manca la Configurazione email Avvisi Lotti per pallet Parziali."
		throw kguo_exception
	end if

	kds_pilota_avvisi = create uo_ds_std_1
	kds_pilota_avvisi.dataobject = "ds_alarm_pltparz_noemail"
	kds_pilota_avvisi.settransobject(kguo_sqlca_db_magazzino)
	
	k_rows = kds_pilota_avvisi.retrieve()  // recupera dalla View gli Avvisi da inviare
	if k_rows < 0 then
		kguo_exception.set_st_esito_err_ds(kds_pilota_avvisi, "Errore in recupero Avvisi Lotti con pallet Parziali. ")
		throw kguo_exception
	end if

	k_today = datetime(today(),now())

	for k_row = 1 to k_rows
		
	//--- verifica se Avviso da fare
		kst_tab_email_invio = kst_tab_email_invio_void
		kst_tab_email_invio.cod_funzione = kuf1_email_funzioni.kki_cod_funzione_avvLottoPltParziale
		kst_tab_email_invio.id_cliente = kds_pilota_avvisi.getitemnumber(k_row, "clie_3")
		kst_tab_email_invio.id_oggetto = kds_pilota_avvisi.getitemnumber(k_row, "id_meca")
		if u_if_email_parzialecolli_warning(kuf1_email_invio, kst_tab_email_invio, kuf1_clienti_altro) then
		
			kst_tab_email = kuf1_email_invio.u_get_st_tab_email_email_invio(kst_tab_email_invio)
			
			if trim(kst_tab_email_invio.oggetto) > " " then
//--- Composizione dell'OGGETTO: 
				kst_tab_email_invio.oggetto += " (gen." + string(k_today, "ddmmyyyy hh:mm:ss") + ")"
			else
				kst_tab_email_invio.oggetto = kst_tab_email.oggetto + " (gen." + string(k_today, "ddmmyyyy hh:mm:ss") &
						+ " " + string(kst_tab_email_funzioni.id_email_funzione) + ")"
			end if
			kst_msg_replace_placeholder.msg = kst_tab_email_invio.oggetto
			kst_msg_replace_placeholder.id_meca = kst_tab_email_invio.id_oggetto
			if kst_msg_replace_placeholder.id_meca > 0 then
				kst_tab_email_invio.oggetto = kuf1_msg_replace_placeholder.u_message_replace_placeholder(kst_msg_replace_placeholder)
			end if
			
//--- run email
			kst_tab_email_invio.note = "Avviso '" + trim(kst_tab_email_invio.cod_funzione) + "' " + kst_tab_email_invio.oggetto
			kst_tab_email_invio.st_tab_g_0.esegui_commit = "S"
			kuf1_email_invio.u_add_email(kst_tab_email_invio)
			
			if kst_tab_email_invio.id_email_invio > 0 then
				k_return++
			end if
			
		end if
	next

catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log()
	throw kuo_exception
	
finally
	if isvalid(kds_pilota_avvisi) then destroy kds_pilota_avvisi
	if isvalid(kuf1_email_funzioni) then destroy kuf1_email_funzioni
	if isvalid(kuf1_email_invio) then destroy kuf1_email_invio
	if isvalid(kuf1_email) then destroy kuf1_email
	if isvalid(kuf1_clienti_altro) then destroy kuf1_clienti_altro
	if isvalid(kuf1_msg_replace_placeholder) then destroy kuf1_msg_replace_placeholder
	
end try


return k_return
end function

private function boolean u_if_email_parzialecolli_warning (ref kuf_email_invio kuf1_email_invio, ref st_tab_email_invio kst_tab_email_invio, ref kuf_clienti_altro kuf1_clienti_altro) throws uo_exception;/*
Routine di verifica se Avviso email è da fare
   rit: TRUE = Avviso da fare
*/
boolean k_return = true
st_tab_clienti_altro kst_tab_clienti_altro


	kguo_exception.inizializza(this.classname())

//--- verifica se è la prima volta da 1 anno
	if kuf1_email_invio.if_presente_x_id_cliente_last_year(kst_tab_email_invio) > 0 then
	
//--- verifica se x il cliente è previsto che invii tutte le volte l'avviso
		kst_tab_clienti_altro.id_cliente = kst_tab_email_invio.id_cliente
		if not kuf1_clienti_altro.if_parzialecolli_warning_si(kst_tab_clienti_altro) then
			k_return = false
		end if
	end if

return k_return
end function

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
int k_ctr


try 

	kguo_exception.inizializza(this.classname())

//--- call della routine che esegue il batch
	k_ctr = u_add_email() 
	if k_ctr > 0 then
		kguo_exception.kist_esito.SQLErrText = "Operazione conclusa correttamente. " + "Sono stati caricati " + string(k_ctr) + " Avvisi email." 
	else
		kguo_exception.kist_esito.esito = kkg_esito.not_fnd
		kguo_exception.kist_esito.SQLErrText = "Operazione conclusa. Nessun Lotto estratto e nessun Avviso generato."
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kguo_exception.kist_esito
end function

on kuf_alarm_pltparz_email.create
call super::create
end on

on kuf_alarm_pltparz_email.destroy
call super::destroy
end on

event constructor;call super::constructor;//
ki_path_alarm = kguo_path.get_doc_root( ) + kkg.path_sep + "alarm" + kkg.path_sep
end event

