$PBExportHeader$kuf_alarm_instock.sru
forward
global type kuf_alarm_instock from kuf_parent
end type
end forward

global type kuf_alarm_instock from kuf_parent
end type
global kuf_alarm_instock kuf_alarm_instock

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
public function st_esito anteprima (datastore kdw_anteprima, st_tab_alarm_instock kst_tab_alarm_instock) throws uo_exception
public function string get_email (ref st_tab_alarm_instock kst_tab_alarm_instock) throws uo_exception
public function boolean if_presente (st_tab_alarm_instock kst_tab_alarm_instock) throws uo_exception
public function boolean tb_delete (st_tab_alarm_instock kst_tab_alarm_instock) throws uo_exception
public function st_esito u_batch_run () throws uo_exception
public function integer u_add_email () throws uo_exception
public subroutine if_isnull (ref st_tab_alarm_instock kst_tab_alarm_instock)
end prototypes

public function st_esito anteprima (datastore kdw_anteprima, st_tab_alarm_instock kst_tab_alarm_instock) throws uo_exception;//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore di anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try 
	if_sicurezza(kkg_flag_modalita.anteprima)

	if isvalid(kdw_anteprima)  then
		if kdw_anteprima.dataobject = "d_alarm_instock"  then
			if kdw_anteprima.object.alarm_instock[1] = kst_tab_alarm_instock.id_alarm_instock  then
				kst_tab_alarm_instock.id_alarm_instock = 0
			end if
		end if
	end if

	if kst_tab_alarm_instock.id_alarm_instock > 0 then
	
		kdw_anteprima.dataobject = "d_alarm_instock"		
		kdw_anteprima.settransobject(sqlca)

		kdw_anteprima.reset()	
//--- retrive 
		k_rc=kdw_anteprima.retrieve(kst_tab_alarm_instock.id_alarm_instock)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna configurazione Allarme Lotti non Trattati da visualizzare: ~n~r" + "nessun Codice indicato"
		kst_esito.esito = kkg_esito.bug
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return kst_esito

end function

public function string get_email (ref st_tab_alarm_instock kst_tab_alarm_instock) throws uo_exception;//
//---------------------------------------------------------------------------------
//--- 
//--- Leggo tabella alarm_instock per prendere il campo EMAIL
//--- 
//--- input: st_tab_alarm_instock con valorizzato il campo id_alarm_instock
//--- out: email
//--- Ritorna tab. ST_ESITO
//--- 
//---------------------------------------------------------------------------------
//
string k_return
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_alarm_instock.id_alarm_instock > 0 then

  SELECT
         email 
    INTO 
         :kst_tab_alarm_instock.email 
    FROM alarm_instock  
	where id_alarm_instock = :kst_tab_alarm_instock.id_alarm_instock
	using kguo_sqlca_db_magazzino ;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura email dalla tab. Allarmi per Lotti non ancora Trattati ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if trim(kst_tab_alarm_instock.email) > " " then
		k_return = trim(kst_tab_alarm_instock.email)
	end if

end if


return k_return

end function

public function boolean if_presente (st_tab_alarm_instock kst_tab_alarm_instock) throws uo_exception;//
//====================================================================
//=== 
//=== Presenza della riga in tabelle per ID
//=== 
//=== input: st_tab_alarm_instock con valorizzato il campo id_alarm_instock
//=== out: 
//=== Ritorna: TRUE = presente
//=== 
//====================================================================
//
boolean k_return = false
int k_trovato = 0
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_alarm_instock.id_alarm_instock > 0 then
	SELECT distinct 1
	    INTO 
         :k_trovato
   	 	FROM alarm_instock  
		where alarm_instock.id_alarm_instock = :kst_tab_alarm_instock.id_alarm_instock
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in verifica presenza Allarme Lotto non trattato id '" + string(kst_tab_alarm_instock.id_alarm_instock) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	if k_trovato = 1 then k_return = true   // TROVATO!!!
else
	kst_esito.SQLErrText = "Manca id Allarme Lotto non trattato, operazione non eseguita ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if


return k_return

end function

public function boolean tb_delete (st_tab_alarm_instock kst_tab_alarm_instock) throws uo_exception;//
//------------------------------------------------------------------
//--- Cancella il rek in tabella 
//--- 
//--- Ritorna: true = cancellato
//---   
//------------------------------------------------------------------
boolean k_return
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try
	if_sicurezza(kkg_flag_modalita.cancellazione)
	
	delete from st_tab_alarm_instock
			where id_alarm_instock = :kst_tab_alarm_instock.id_alarm_instock
			using kguo_sqlca_db_magazzino;
	if kguo_sqlca_db_magazzino.sqlCode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in cancellazione Allarme Lotto non trattato id '" + string(kst_tab_alarm_instock.id_alarm_instock) + " ~n~r" +  trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		if kst_tab_alarm_instock.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_alarm_instock.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
				
	if kguo_sqlca_db_magazzino.sqlCode = 0 then
		if kst_tab_alarm_instock.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_alarm_instock.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		k_return = true
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
		
end try

return k_return
end function

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
int k_ctr
st_esito kst_esito


try 

	kst_esito = kguo_exception.inizializza(this.classname())

//--- call della routine che esegue il batch
	k_ctr = u_add_email() 
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Operazione conclusa correttamente. " + "Sono stati caricati " + string(k_ctr) + " Avvisi email." 
	else
		kst_esito.esito = kkg_esito.not_fnd
		kst_esito.SQLErrText = "Operazione conclusa. Nessun Lotto estratto e nessun Avviso generato."
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

public function integer u_add_email () throws uo_exception;//---
//--- Carico email da inviare
//---
int k_return
string k_nomefile_attach
int k_rows, k_row, k_row_id_meca
datetime k_today
st_esito kst_esito
st_tab_alarm_instock kst_tab_alarm_instock
st_tab_email_invio kst_tab_email_invio
st_tab_email_funzioni kst_tab_email_funzioni
st_tab_email kst_tab_email
st_tab_alarm_instock_email kst_tab_alarm_instock_email
kuf_email_funzioni kuf1_email_funzioni
kuf_email kuf1_email
kuf_email_invio kuf1_email_invio
kuf_alarm_instock_email kuf1_alarm_instock_email
kuf_utility kuf1_utility
datastore kds_pilota_avvisi, kds_d_alarm_instocktosend_meca_l, kds_d_alarm_instock


try 

	kst_esito = kguo_exception.inizializza(this.classname())

	kuf1_utility = create kuf_utility
	kuf1_email_funzioni = create kuf_email_funzioni
	kuf1_email = create kuf_email
	kuf1_email_invio = create kuf_email_invio
	kuf1_alarm_instock_email = create kuf_alarm_instock_email

	kds_pilota_avvisi = create datastore
	kds_pilota_avvisi.dataobject = "ds_alarm_instock_email"
	kds_pilota_avvisi.settransobject(kguo_sqlca_db_magazzino)
	
	kds_d_alarm_instocktosend_meca_l = create datastore
	kds_d_alarm_instocktosend_meca_l.dataobject = "d_alarm_instocktosend_meca_l"
	kds_d_alarm_instocktosend_meca_l.settransobject(kguo_sqlca_db_magazzino)
	
	kds_d_alarm_instock = create datastore
	kds_d_alarm_instock.dataobject = "d_alarm_instock"
	kds_d_alarm_instock.settransobject(kguo_sqlca_db_magazzino)
	
	k_rows = kds_pilota_avvisi.retrieve()  // recupera dalla View gli Avvisi da inviare

	for k_row = 1 to k_rows
		k_today = datetime(today(), now())
		kst_tab_alarm_instock.id_alarm_instock = kds_pilota_avvisi.getitemnumber(k_row, "id_alarm_instock")
		k_nomefile_attach = "Alarm" + string(kst_tab_alarm_instock.id_alarm_instock, "00000") + "_"+string(k_today, "yyyymmddhhmm")
		
		if kds_d_alarm_instock.retrieve(kst_tab_alarm_instock.id_alarm_instock) > 0 then  // legge dati del Alarm

			kst_tab_email_funzioni.id_email_funzione = kds_d_alarm_instock.getitemnumber(1, "id_email_funzione")

			kst_tab_email_invio.lettera = trim(kds_d_alarm_instock.getitemstring(1, "lettera"))
			kst_tab_email_invio.oggetto = trim(kds_d_alarm_instock.getitemstring(1, "oggetto"))
			
			//--- se c'è già la lettera non leggo il prototipo
			if kst_tab_email_invio.lettera > " " and kst_tab_email_invio.oggetto > " " then
			else
				if kst_tab_email_funzioni.id_email_funzione > 0 then
					kst_tab_email.id_email = kuf1_email_funzioni.get_id_email(kst_tab_email_funzioni)	
					kst_tab_email_invio.cod_funzione = kuf1_email_funzioni.get_cod_funzione(kst_tab_email_funzioni)
					kuf1_email.get_riga(kst_tab_email)  // dati conf email
				end if
			end if
			if trim(kst_tab_email_invio.cod_funzione) > " " then
			else
				kst_tab_email_invio.cod_funzione = kuf1_email_funzioni.kki_cod_funzione_avvGiacenzaLotti
			end if
			
			if trim(kst_tab_email_invio.oggetto) > " " then
				kst_tab_email_invio.oggetto += " (gen." + string(k_today, "ddmmyyyy hh:mm:ss") + ")"
			else
				kst_tab_email_invio.oggetto = kst_tab_email.oggetto + " (gen." + string(k_today, "ddmmyyyy hh:mm:ss") &
						+ " " + string(kst_tab_email_funzioni.id_email_funzione) + ")"
			end if
			if trim(kst_tab_email_invio.lettera) > " " then
			else
				kst_tab_email_invio.link_lettera = kst_tab_email.link_lettera
			end if
			kst_tab_email_invio.flg_lettera_html = kst_tab_email.flg_lettera_html
			kst_tab_email_invio.flg_ritorno_ricev = kst_tab_email.flg_ritorno_ricev
			kst_tab_email_invio.email_di_ritorno = kst_tab_email.email_di_ritorno
			kst_tab_email_invio.id_cliente = kds_d_alarm_instock.getitemnumber(1, "id_cliente")
			kst_tab_email_invio.invio_batch = kds_d_alarm_instock.getitemnumber(1, "invio_batch")
			kst_tab_email_invio.id_oggetto = kst_tab_alarm_instock.id_alarm_instock
			kst_tab_email_invio.email = kds_pilota_avvisi.getitemstring(k_row, "email") // email addresses
			
			if kds_d_alarm_instocktosend_meca_l.retrieve(kst_tab_alarm_instock.id_alarm_instock) > 0 then
	//--- genera allegato XLS
				kst_tab_email_invio.allegati_pathfile = kuf1_utility.u_xls_create(kds_d_alarm_instocktosend_meca_l, ki_path_alarm, k_nomefile_attach, "Avviso" + string(kst_tab_alarm_instock.id_alarm_instock, "00000") + "_" + string(k_today, "yyyymmddhhmm"))
			end if
			
//--- run email
			kst_tab_email_invio.note = "Avviso del " + string(k_today, "dd mmm yyyy hh:mm") + " '" + trim(kds_d_alarm_instock.getitemstring(1, "des")) + "' "  
			kst_tab_email_invio.st_tab_g_0.esegui_commit = "S"
			kuf1_email_invio.u_add_email(kst_tab_email_invio)
			
			if kst_tab_email_invio.id_email_invio > 0 then
				
           	kst_tab_alarm_instock_email.id_alarm_instock = kst_tab_alarm_instock.id_alarm_instock
				for k_row_id_meca = 1 to kds_d_alarm_instocktosend_meca_l.rowcount( )
				
	           	kst_tab_alarm_instock_email.id_meca = kds_d_alarm_instocktosend_meca_l.getitemnumber(k_row_id_meca, "meca_id") 
					
					if kuf1_alarm_instock_email.if_exists_x_id_meca(kst_tab_alarm_instock_email) then
						kuf1_alarm_instock_email.set_generated(kst_tab_alarm_instock_email)  // aggiorna la data di generazione
					else
						kuf1_alarm_instock_email.tb_add(kst_tab_alarm_instock_email)	// aggiunge il record
					end if
					
				next
				
				k_return++
			end if
			
		end if
	next

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kds_pilota_avvisi) then destroy kds_pilota_avvisi
	if isvalid(kds_d_alarm_instocktosend_meca_l) then destroy kds_d_alarm_instocktosend_meca_l
	if isvalid(kuf1_utility) then destroy kuf1_utility
	if isvalid(kuf1_email_funzioni) then destroy kuf1_email_funzioni
	if isvalid(kuf1_email) then destroy kuf1_email
	if isvalid(kuf1_email_invio) then destroy kuf1_email_invio
	if isvalid(kuf1_alarm_instock_email) then destroy kuf1_alarm_instock_email
	
end try


return k_return
end function

public subroutine if_isnull (ref st_tab_alarm_instock kst_tab_alarm_instock);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_alarm_instock.id_alarm_instock) then kst_tab_alarm_instock.id_alarm_instock = 0
if isnull(kst_tab_alarm_instock.id_cliente) then kst_tab_alarm_instock.id_cliente = 0
if isnull(kst_tab_alarm_instock.contratto) then kst_tab_alarm_instock.contratto = 0
if isnull(kst_tab_alarm_instock.des) then kst_tab_alarm_instock.des = ""
if isnull(kst_tab_alarm_instock.email ) then kst_tab_alarm_instock.email = ""
if isnull(kst_tab_alarm_instock.id_email_funzione ) then kst_tab_alarm_instock.id_email_funzione = 0
if isnull(kst_tab_alarm_instock.email_nday_elapsed ) then kst_tab_alarm_instock.email_nday_elapsed = 0
if isnull(kst_tab_alarm_instock.sr_settore ) then kst_tab_alarm_instock.sr_settore = ""
if isnull(kst_tab_alarm_instock.attivo ) then kst_tab_alarm_instock.attivo = ""
if isnull(kst_tab_alarm_instock.nday_instock ) then kst_tab_alarm_instock.nday_instock = 0


end subroutine

on kuf_alarm_instock.create
call super::create
end on

on kuf_alarm_instock.destroy
call super::destroy
end on

event constructor;call super::constructor;//
ki_path_alarm = kguo_path.get_doc_root( ) + kkg.path_sep + "alarm" + kkg.path_sep
end event

