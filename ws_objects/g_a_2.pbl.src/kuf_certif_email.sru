$PBExportHeader$kuf_certif_email.sru
forward
global type kuf_certif_email from kuf_parent0
end type
end forward

global type kuf_certif_email from kuf_parent0
end type
global kuf_certif_email kuf_certif_email

type variables
//
constant string kki_folder_pdf_e1 = "prepared"

end variables

forward prototypes
public function long u_add_email_invio () throws uo_exception
public function date tb_pulizia () throws uo_exception
public function st_esito u_batch_run () throws uo_exception
public function integer tb_add (ref string k_status) throws uo_exception
public function boolean set_certif_e1_e1doco (st_tab_certif_email kst_tab_certif_email) throws uo_exception
public function long u_add_email_invio_2 (ref st_tab_certif_email ast_tab_certif_email, ref st_tab_email_invio ast_tab_email_invio) throws uo_exception
private function long u_add_email_invio_1 (ref uo_ds_std_1 ads_1, integer a_riga_ds, ref st_tab_email_invio ast_tab_email_invio, ref st_tab_email ast_tab_email, ref kuf_email auf_email, ref st_tab_meca ast_tab_meca, ref kuf_certif_print auf_certif_print) throws uo_exception
private function st_tab_email u_add_email_invio_0_old (ref kuf_email kuf1_email, ref st_tab_email_invio kst_tab_email_invio, string a_cod_funzione) throws uo_exception
end prototypes

public function long u_add_email_invio () throws uo_exception;/*
 Carica email Attestati in tab Email-Invio che non hanno ancora la email (scarta i clienti che non hanno l'indirizzo)
	 Rit: nr di email caricate 
*/
long k_return 
long k_riga, k_righe, k_righe_daelab, k_riga1000, k_riga_ds, k_rc, k_email_inserite
datetime k_datetime
string k_id_nazione_1
//st_tab_certif_email kst_tab_certif_email[], kst_tab_certif_email_vuoto[]
st_tab_meca kst_tab_meca
st_tab_email_invio kst_tab_email_invio, kst_tab_email_invio_void
st_tab_email kst_tab_email
st_esito kst_esito
st_tab_clienti_fatt kst_tab_clienti_fatt
kuf_certif_print kuf1_certif_print
kuf_email kuf1_email
kuf_email_funzioni kuf1_email_funzioni
kuf_email_invio kuf1_email_invio
uo_ds_std_1 kds_1


try
	kst_esito = kguo_exception.inizializza(this.classname())

	kuf1_certif_print = create kuf_certif_print
	kuf1_email_invio = create kuf_email_invio
	kuf1_email = create kuf_email
	
	kds_1 = create uo_ds_std_1
	kds_1.dataobject = "ds_certif_email_noemail"
	kds_1.settransobject( kguo_sqlca_db_magazzino )
	k_righe = kds_1.retrieve() // estrazione avvisi senza ancora il id_email_invio
	if k_righe < 0 then
		kguo_exception.inizializza(this.classname())
		kguo_exception.set_st_esito_err_ds(kds_1, "Errore in lettura email Attestati ancora da inviare. ")
		throw kguo_exception
	end if
	if k_righe = 0 then return 0   // Non fa nulla uscita!
	
	kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()
	kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()	 
	
	//kst_tab_email = u_add_email_invio_0(kuf1_email, kst_tab_email_invio_orig, kuf1_email_funzioni.kki_cod_funzione_attestati) // riempie area st_tab_email_invio comune a queste email
	
	for k_riga = 1 to k_righe
		
//--- Aggiorna non più di 1000 righe alla volta...		
		if (k_righe - k_riga) < 1000 then
			k_righe_daelab = k_righe - k_riga
		else
			k_righe_daelab = 1000 - 1
		end if
		k_riga1000 = k_riga + k_righe_daelab 
		
		k_email_inserite = 0
//		kst_tab_certif_email[] = kst_tab_certif_email_vuoto[]
		
		for k_riga_ds = k_riga to k_riga1000
			
			kst_tab_email_invio = kst_tab_email_invio_void
			k_id_nazione_1 = kds_1.getitemstring( k_riga_ds, "id_nazione_1")
			if k_id_nazione_1 > " " and k_id_nazione_1 <> "IT" and k_id_nazione_1 <> "SM" then
				kst_tab_email_invio.lang = "EN"
			else
				kst_tab_email_invio.lang = ""
			end if
			kst_tab_email_invio.cod_funzione = kuf1_email_funzioni.kki_cod_funzione_attestati
			kst_tab_email = kuf1_email_invio.u_get_st_tab_email_email_invio(kst_tab_email_invio)
		
			//kst_tab_email_invio = kst_tab_email_invio_orig

//--- get degli indirizzi x invio Attestati
			kst_tab_clienti_fatt.email_invio = kds_1.getitemstring(k_riga_ds, "clienti_fatt_email_invio")
			
			//--- email addresses
			kst_tab_email_invio.email = kds_1.getitemstring(k_riga_ds, "clienti_web_email")
			if trim(kst_tab_email.email_to) > " " then
				kst_tab_email_invio.email += ";" + trim(kst_tab_email.email_to) 
			end if
			kst_tab_email_invio.email_cc = trim(kst_tab_email.email_cc) 
			kst_tab_email_invio.email_ccn = trim(kst_tab_email.email_ccn)

			kst_tab_email_invio.id_cliente = kds_1.getitemnumber( k_riga_ds, "clie_3")
			
//--- se e-mail NON impostata sul cliente NON invio nulla!!!
			if trim(kst_tab_email_invio.email) > " " then
								
//--- Add EMAIL - carica il datastore ds_certif_email_noemail
				if u_add_email_invio_1(kds_1, k_riga_ds &
										, kst_tab_email_invio &
										, kst_tab_email &
										, kuf1_email &
										, kst_tab_meca &
										, kuf1_certif_print) > 0 then
					k_email_inserite ++
				end if				
				
			else
				kguo_exception.inizializza( )
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.sqlerrtext =  "Manca indirizzo email per il cliente " + string(kst_tab_email_invio.id_cliente) + ". Generazione email per invio del Certificato non eseguita."
				kguo_exception.set_esito(kst_esito)
				kguo_exception.scrivi_log( )
			end if

		next
		
		k_rc = kds_1.update( )  // AGGIORNA ID_EMAIL_INVIO!!
		if k_rc > 0 then
			kguo_sqlca_db_magazzino.db_commit( )
			k_return += k_email_inserite
		else
			kguo_exception.set_st_esito_err_ds(kds_1, "Errore in caricamento email nuovi Attestati di M2000. " &
													+ kkg.acapo + "Per esempio per l'Attestato id: " &
													+ string(kds_1.getitemnumber(k_riga, "id_certif")) &
													+ " ASN: " + string(kds_1.getitemnumber(k_riga, "id_meca")) &
													+ " Lotto: "  + " ASN: " + string(kds_1.getitemnumber(k_riga, "num_int")) &
													+ " del " + string(kds_1.getitemdate(k_riga, "data_int")) + ". ")
			kguo_sqlca_db_magazzino.db_rollback( )
			throw kguo_exception
		end if
		
		k_riga = k_riga_ds - 1
	next
	
//--- Rimuove le righe vecchie dalla tabella Avvisi Certificati Email
	tb_pulizia( )
	
	
catch (uo_exception kuo_exception) 
	kguo_sqlca_db_magazzino.db_rollback( )
	throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
//	if isvalid(kuf1_clienti) then destroy kuf1_clienti
	if isvalid(kuf1_certif_print) then destroy kuf1_certif_print
	if isvalid(kuf1_email) then destroy kuf1_email
	

end try

		
return k_return
end function

public function date tb_pulizia () throws uo_exception;//
//====================================================================
//=== Rimuove i rek non più utili in 'CERTIF_EMAIL' (pilota email)
//=== 
//=== Inp: 
//=== Ritorna: data di rimozione
//=== Lancia EXCEPTION
//===  
//====================================================================
//
date k_return  
st_tab_certif_email kst_tab_certif_email
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

//--- Fissa la data dalla quale fare la pulizia della tabella
	kst_tab_certif_email.dtins = datetime(relativedate(date(kGuf_data_base.prendi_x_datins()), -180), time(0))
	
	DELETE FROM certif_email  
			where certif_email.dtins < :kst_tab_certif_email.dtins
			using kguo_sqlca_db_magazzino;
		

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Rimozione dati di avviso 'Attestati via Email' caricati dal " + string(kst_tab_certif_email.dtins) + " in errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	
	else
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			
			k_return = date(kst_tab_certif_email.dtins)

		end if
	end if
	
//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		kguo_sqlca_db_magazzino.db_rollback( )
	else
		kguo_sqlca_db_magazzino.db_commit( )
	end if


return k_return

end function

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
int k_ctr_add, k_ctr
string k_status
st_esito kst_esito


try 

	kst_esito = kguo_exception.inizializza(this.classname())

//--- Stored Procedure MSSQL UPDATE per carico tabella CERTIF_EMAIL
	k_ctr_add = tb_add(k_status)

//--- Carica Attestati in tab Email da Inviare
	k_ctr = u_add_email_invio( )
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Caricate in archivio " + string(k_ctr) + " email per l'invio dei 'Certificati'. " 
	else
		kst_esito.SQLErrText = "Nessuna nuova email Certificati aggiunta in archivio."
	end if
	if k_ctr_add > 0 then
		kst_esito.SQLErrText += "Preparati " + string(k_ctr_add) + " Lotti in attesa della stampa del Certificato. " 
	else
		kst_esito.SQLErrText += "Nessun Certificato in preparazione."
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

public function integer tb_add (ref string k_status) throws uo_exception;//
//--- Esecuzione della Stored Procedure MSSQL UPDATE per carico tabella CERTIF_EMAIL
//--- Chiama la sp 
//--- Out: status di come è andata
//--- Rit: 0=nulla, >0 numero righe aggiornate
//
int k_return
int k_rc


try
	kguo_exception.inizializza(this.classname())
	k_status = ""

	DECLARE u_m2000_sp PROCEDURE FOR
			@li_rc = dbo.u_m2000_popola_certif_email
									@k_status varchar(240) = :k_status OUT
		using kguo_sqlca_db_magazzino ;
			
	execute u_m2000_sp;
	
	IF kguo_sqlca_db_magazzino.SQLCode < 0 THEN
		kguo_exception.kist_esito.esito = kkg_esito.db_ko
		kguo_exception.kist_esito.sqlcode = kguo_sqlca_db_magazzino.SQLCode
		kguo_exception.kist_esito.sqlerrtext = "Errore in esecuzione SP 'u_m2000_popola_certif_email': " + trim(kguo_sqlca_db_magazzino.SQLerrtext)
		kguo_exception.scrivi_log( )
		throw kguo_exception
	ELSE
			// Put the return value into the var and close the declaration.
		FETCH u_m2000_sp INTO :k_rc, :k_status;
		IF kguo_sqlca_db_magazzino.SQLCode = 0 THEN
			k_return = k_rc
		else
			k_return = 0
		end if
		CLOSE u_m2000_sp;
		kguo_exception.kist_esito.esito = kkg_esito.ok
		kguo_exception.kist_esito.sqlcode = 0
		kguo_exception.kist_esito.sqlerrtext = "Eseguito SP 'u_m2000_popola_certif_email', esito: " + trim(k_status)
		//kguo_exception.scrivi_log( )
	END IF


catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return
end function

public function boolean set_certif_e1_e1doco (st_tab_certif_email kst_tab_certif_email) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------
//--- Set del WO del Certificato E1
//--- 
//--- 
//--- Inp: st_tab_certif_email.id_certif 
//--- Out:        
//--- Ritorna: TRUE = OK
//---           		
//--- Lancia EXCEPTION x errore
//--- 
//---------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito

	

kst_esito = kguo_exception.inizializza(this.classname( ))
	
if kst_tab_certif_email.id_certif > 0 then

	kst_tab_certif_email.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_certif_email.x_utente = kGuf_data_base.prendi_x_utente()

	UPDATE certif_email  
		  SET certif_e1_e1doco = :kst_tab_certif_email.certif_e1_e1doco
			,x_datins = :kst_tab_certif_email.x_datins
			,x_utente = :kst_tab_certif_email.x_utente
		WHERE certif_email.id_certif = :kst_tab_certif_email.id_certif
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in aggiornamento WO del Certificato E1 in archivio Email Certificati. ~n~r" &
					+ "Id Certificato: " + string(kst_tab_certif_email.id_certif, "#") + "  " &
					+ " ~n~rErrore: "	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_certif_email.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_certif_email.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	else
		if kst_tab_certif_email.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_certif_email.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
	end if

else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore in aggiornamento WO del Certificato E1 in archivio Certificati email. Manca Id del certificato!" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	

if kst_esito.esito = kkg_esito.err_logico or kst_esito.esito = kkg_esito.db_ko then
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

k_return = true

return k_return

end function

public function long u_add_email_invio_2 (ref st_tab_certif_email ast_tab_certif_email, ref st_tab_email_invio ast_tab_email_invio) throws uo_exception;//------------------------------------------------------------------------------------------------------------------------
//--- Fa il Carico nella tabella email-invio 
//--- Inp: st_tab_certif_email valorizzata con i campi necessari
//--- Out: il ID del email_invio
//------------------------------------------------------------------------------------------------------------------------
//
long k_return=0 
kuf_email_invio kuf1_email_invio


try
	kguo_exception.inizializza(this.classname())

	if ast_tab_certif_email.id_certif > 0 then 
	else
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlerrtext =  "Manca id del Certificato. Generazione email non eseguita."
		throw kguo_exception
	end if
	
	kuf1_email_invio = create kuf_email_invio

//--- se la cartella non esiste non genera la email
	if DirectoryExists(ast_tab_email_invio.allegati_cartella) then
	else
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlerrtext = "Attestati: errore durante preparazione e-mail da inviare; cartella allegati Attestati non trovata: " &
									+ "'" + ast_tab_email_invio.allegati_cartella + "'. Verificare il log degli errori per ulteriori informazioni."
		throw kguo_exception
	end if

	ast_tab_email_invio.id_oggetto = ast_tab_certif_email.id_certif 

	k_return = kuf1_email_invio.u_add_email(ast_tab_email_invio)  // Carico EMAIL per l'invio
	
catch (uo_exception kuo_exception)	
	kuo_exception.scrivi_log()
	if kuo_exception.kist_esito.esito = kkg_esito.no_esecuzione then
		k_return = 0
	else
		throw kuo_exception
	end if
	
finally
	if isvalid(kuf1_email_invio) then destroy kuf1_email_invio
	
end try



return k_return

end function

private function long u_add_email_invio_1 (ref uo_ds_std_1 ads_1, integer a_riga_ds, ref st_tab_email_invio ast_tab_email_invio, ref st_tab_email ast_tab_email, ref kuf_email auf_email, ref st_tab_meca ast_tab_meca, ref kuf_certif_print auf_certif_print) throws uo_exception;/*
    Avvisi Certificati Email (E1+M2000) e li carica in tab Email-Invio 
    chiamata da u_add_email_invio
	 	rit: id_email_invio
*/
long k_return
st_tab_clienti kst_tab_clienti
st_tab_certif kst_tab_certif
st_tab_certif_email kst_tab_certif_email


try

//--- get del DDT mandante		
	ast_tab_meca.num_bolla_in = ads_1.getitemstring( a_riga_ds, "num_bolla_in")
	ast_tab_meca.data_bolla_in = ads_1.getitemdate( a_riga_ds, "data_bolla_in")
//--- Composizione dell'OGGETTO: somma alla dicitura del Prototipo il ddt del mandante a anche il Nome quando cliente diverso da mandante
	if ast_tab_meca.num_bolla_in > " " then
		ast_tab_email_invio.oggetto = trim(ast_tab_email_invio.oggetto) + " related to delivery Notes # " + trim(ast_tab_meca.num_bolla_in)
		if ast_tab_meca.data_bolla_in > date(0) then
			ast_tab_email_invio.oggetto += " of " + string(ast_tab_meca.data_bolla_in, "dd mmm yyyy")
		end if
	end if
//		if ast_tab_meca.num_int > 0 then
//			ast_tab_email_invio.oggetto = trim(ast_tab_email_invio.oggetto) + " rif. interno " + string(ast_tab_meca.num_int)
//		end if
	kst_tab_clienti.rag_soc_10 = ads_1.getitemstring( a_riga_ds, "rag_soc_10")
	if trim(kst_tab_clienti.rag_soc_10) > " " then // se cliente mandante diverso aggiungo il nome
		ast_tab_email_invio.oggetto = trim(ast_tab_email_invio.oggetto) + ". Customer '" + trim(kst_tab_clienti.rag_soc_10) + "'"
	end if

	ast_tab_email_invio.note = "Attestato n. " + string(ads_1.getitemnumber(a_riga_ds, "num_certif")) &
				+ ", WO " + string(ads_1.getitemnumber( a_riga_ds, "certif_e1_e1doco")) &
				+ ", Lotto " + string(ads_1.getitemnumber(a_riga_ds,"num_int")) &
				+ "  " +  string(ads_1.getitemdate(a_riga_ds, "data_int")) &
				+ "   id " + string(ads_1.getitemnumber( a_riga_ds, "id_meca")) + " "  

//--- Buidling del path
	kst_tab_certif.id_meca = ads_1.getitemnumber( a_riga_ds, "id_meca")
	ast_tab_email_invio.allegati_cartella = auf_certif_print.get_path_email(kst_tab_certif)			

//--- Prepara l'array per popolare la tabella email
	kst_tab_certif_email.id_certif = ads_1.getitemnumber( a_riga_ds, "id_certif")
	kst_tab_certif_email.id_meca = ads_1.getitemnumber( a_riga_ds, "id_meca")
	kst_tab_certif_email.certif_e1_e1doco = ads_1.getitemnumber( a_riga_ds, "certif_e1_e1doco")
	
	kst_tab_certif_email.st_tab_g_0.esegui_commit = "S" //"N" x temporaltable
	
	kst_tab_certif_email.id_email_invio = u_add_email_invio_2(kst_tab_certif_email, ast_tab_email_invio) // ADD EMAIL
	
	if kst_tab_certif_email.id_email_invio > 0 then
		k_return = kst_tab_certif_email.id_email_invio
//--- Imposta id email invio in tabella Certif email
		ads_1.setitem(a_riga_ds, "id_email_invio", kst_tab_certif_email.id_email_invio)
		ads_1.setitem(a_riga_ds, "x_datins", ast_tab_meca.x_datins)
		ads_1.setitem(a_riga_ds, "x_utente", ast_tab_meca.x_utente)
	end if
	
	
catch (uo_exception kuo_exception) 
	kguo_sqlca_db_magazzino.db_rollback( )
	throw kuo_exception
	
finally

end try

return k_return

end function

private function st_tab_email u_add_email_invio_0_old (ref kuf_email kuf1_email, ref st_tab_email_invio kst_tab_email_invio, string a_cod_funzione) throws uo_exception;//------------------------------------------------------------------------------------------------------------------------
//--- Imposta campi generici di invio email 
//--- Inp: 
//--- Out: st_tab_email_invio
//------------------------------------------------------------------------------------------------------------------------
//
kuf_email_invio kuf1_email_invio
kuf_email_funzioni kuf1_email_funzioni
st_tab_email kst_tab_email
st_tab_email_funzioni kst_tab_email_funzioni


try
	kguo_exception.inizializza(this.classname())

	
	kuf1_email_invio = create kuf_email_invio
	kuf1_email_funzioni = create kuf_email_funzioni
	
	kst_tab_email_invio.flg_allegati = kuf1_email_invio.ki_allegati_si
	kst_tab_email_invio.cod_funzione = a_cod_funzione 

//--- get del Prototipo della e-mail
	kst_tab_email_funzioni.cod_funzione = kst_tab_email_invio.cod_funzione
	kst_tab_email.id_email = kuf1_email_funzioni.get_id_email_xcodfunzione(kst_tab_email_funzioni)
	if kst_tab_email.id_email = 0 then
		kguo_exception.kist_esito.esito = kkg_esito.ko
		kguo_exception.kist_esito.sqlerrtext = "Indicare il Prototipo E-mail da utilizzare per l'invio dei Certificati, codificato come '" &
					+ trim(kst_tab_email_funzioni.cod_funzione) &
					+ "' (" + kuf1_email_funzioni.get_des(kst_tab_email_funzioni) + ")"
		throw kguo_exception
	end if

//--- recupero diversi dati x riempire la tab email-invio			
	kuf1_email.get_riga(kst_tab_email)
	
	//kst_tab_email_invio.oggetto = kst_tab_email.oggetto
	kst_tab_email_invio.link_lettera = kst_tab_email.link_lettera
	kst_tab_email_invio.flg_lettera_html = kst_tab_email.flg_lettera_html
	kst_tab_email_invio.flg_ritorno_ricev = kst_tab_email.flg_ritorno_ricev
	kst_tab_email_invio.email_di_ritorno = kst_tab_email.email_di_ritorno
	kst_tab_email_invio.invio_batch = kst_tab_email.invio_batch
	if kst_tab_email.attached > " " then
		if trim(kst_tab_email_invio.allegati_pathfile) > " " then
			kst_tab_email_invio.allegati_pathfile += ";" + kst_tab_email.attached  // aggiunge allegato a un precedente
		else
			kst_tab_email_invio.allegati_pathfile = kst_tab_email.attached
		end if
	end if
		
	kuf1_email_invio.if_isnull(kst_tab_email_invio)
	
catch (uo_exception kuo_exception)	
	if kuo_exception.kist_esito.esito = kkg_esito.no_esecuzione then
	else
		kuo_exception.scrivi_log()
		throw kuo_exception
	end if
	
finally
	if isvalid(kuf1_email_invio) then destroy kuf1_email_invio
	if isvalid(kuf1_email_funzioni) then destroy kuf1_email_funzioni
	
end try

return kst_tab_email

end function

on kuf_certif_email.create
call super::create
end on

on kuf_certif_email.destroy
call super::destroy
end on

