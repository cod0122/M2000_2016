$PBExportHeader$kuf_email_invio.sru
forward
global type kuf_email_invio from kuf_parent
end type
end forward

global type kuf_email_invio from kuf_parent
end type
global kuf_email_invio kuf_email_invio

type variables

//--- flag allegati
 string ki_allegati_si = "S"
 string ki_allegati_no = "N"

//--- in HTML
 string ki_lettera_html_si = "S"
 string ki_lettera_html_no = "N"

//--- Ricevuta di ritorno
 string ki_ricev_ritorno_si = "S"
 string ki_ricev_ritorno_no = "N"

//--- Invio automatico via batch
constant int kki_invio_batch_si = 1
constant int kki_invio_batch_no = 0

private kuf_msg_replace_placeholder kiuf_msg_replace_placeholder

private boolean ki_messagebox_if_error = true
end variables

forward prototypes
public function st_esito anteprima (datastore kdw_anteprima, st_tab_email_invio kst_tab_email_invio)
public function boolean tb_add (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function st_esito get_email (ref st_tab_email_invio kst_tab_email_invio)
public function boolean tb_update (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function boolean set_data_inviato (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function st_esito check_presenza (ref st_tab_email_invio kst_tab_email_invio)
public function integer delete_allegati (st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function boolean get_id_email_invio_minimo_x_data_ins (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function boolean tb_add_autorizzativo (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function boolean tb_update_autorizzativo (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function long get_id_email_invio_max () throws uo_exception
public function boolean u_invio_email (st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function st_esito get_riga (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function long u_invio_batch () throws uo_exception
public function st_esito u_batch_run () throws uo_exception
private function string get_file_lettera_lang (ref st_tab_email_invio kst_tab_email_invio)
private function boolean invio (st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function long u_add_email (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function boolean tb_delete (st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function string get_allegati_cartella (ref st_tab_email_invio kst_tab_email_invio)
public function string get_allegati_pathfile (ref st_tab_email_invio kst_tab_email_invio)
public function long if_presente_x_id_oggetto (st_tab_email_invio kst_tab_email_invio) throws uo_exception
public subroutine if_isnull (ref st_tab_email_invio kst_tab_email_invio)
public function long get_id_meca (st_tab_email_invio ast_tab_email_invio) throws uo_exception
public function string get_cod_funzione (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function long get_id_oggetto (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function string u_anteprima_comunicazone (ref st_tab_email_invio ast_tab_email_invio) throws uo_exception
public function string get_comunicazione (st_tab_email_invio ast_tab_email_invio) throws uo_exception
private function string u_message_replace_placeholder (st_tab_email_invio ast_tab_email_invio, string a_message) throws uo_exception
public subroutine u_comunicazione_modifica (ref st_tab_email_invio ast_tab_email_invio) throws uo_exception
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function st_esito anteprima_rubrica (datastore kdw_anteprima) throws uo_exception
public function boolean get_data_ins (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception
end prototypes

public function st_esito anteprima (datastore kdw_anteprima, st_tab_email_invio kst_tab_email_invio);//
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
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito = kguo_exception.inizializza(this.classname())

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.anteprima) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if isvalid(kdw_anteprima)  then
		if kdw_anteprima.dataobject = "d_email_invio"  then
			if kdw_anteprima.object.id_email_invio[1] = kst_tab_email_invio.id_email_invio  then
				kst_tab_email_invio.id_email_invio = 0
			end if
		end if
	end if

	if kst_tab_email_invio.id_email_invio > 0 then
	
			kdw_anteprima.dataobject = "d_email_invio"		
			kdw_anteprima.settransobject(sqlca)
	
//			kuf1_utility = create kuf_utility
//			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_email_invio.id_email_invio)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessuna Invio E-mail da visualizzare: ~n~r" + "nessun Codice indicato"
			kst_esito.esito = kkg_esito.bug
			
		end if
end if


return kst_esito

end function

public function boolean tb_add (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception;//
//====================================================================
//=== Aggiunge un rek nella tabella email_invio 
//=== 
//=== Ritorna TRUE=ok
//===   
//====================================================================
boolean k_return = true
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())
	
	kst_tab_email_invio.id_email_invio = 0

	kst_tab_email_invio.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_email_invio.x_utente = kGuf_data_base.prendi_x_utente()
	
	kst_esito = get_email(kst_tab_email_invio)
//	if kst_esito.esito = kkg_esito.ok then
//
//		update email_invio
//			set email = :kst_tab_email_invio.email
//				,  data_ins = :kst_tab_email_invio.data_ins
//				,  oggetto = :kst_tab_email_invio.oggetto
//				,  link_lettera = :kst_tab_email_invio.link_lettera
//				,  flg_lettera_html = :kst_tab_email_invio.flg_lettera_html
//				,  flg_allegati = :kst_tab_email_invio.flg_allegati
//				,  allegati_cartella = :kst_tab_email_invio.allegati_cartella
//				,  flg_ritorno_ricev = :kst_tab_email_invio.flg_ritorno_ricev
//				,  x_datins = :kst_tab_email_invio.x_datins
//				,  x_utente = :kst_tab_email_invio.x_utente
//			where id_email_invio = :kst_tab_email_invio.id_email_invio
//			using kguo_sqlca_db_magazzino;
//
//	
//	else
//
//	if kst_esito.esito = kkg_esito.db_not_ok then
	
	kst_tab_email_invio.data_ins = date(kst_tab_email_invio.x_datins) 
	
	if_isnull(kst_tab_email_invio)
	//id_email_invio,   
	
	INSERT INTO email_invio  
				( 
				  cod_funzione,
				  note,   
				  id_oggetto,   
				  id_cliente,   
				  email,   
				  data_ins,   
				  oggetto,   
				  link_lettera,   
				  lettera,   
				  flg_lettera_html,   
				  flg_allegati,   
				  allegati_cartella,   
				  allegati_pathfile,   
				  flg_ritorno_ricev,   
				  email_di_ritorno,
				  invio_batch,
				  lang,   
				  x_datins,   
				  x_utente )
			  VALUES ( 
						  :kst_tab_email_invio.cod_funzione,
						  :kst_tab_email_invio.note,   
						  :kst_tab_email_invio.id_oggetto,   
						  :kst_tab_email_invio.id_cliente,   
						  :kst_tab_email_invio.email,   
						  :kst_tab_email_invio.data_ins,   
						  :kst_tab_email_invio.oggetto,   
						  :kst_tab_email_invio.link_lettera,   
						  :kst_tab_email_invio.lettera,   
						  :kst_tab_email_invio.flg_lettera_html,   
						  :kst_tab_email_invio.flg_allegati,   
						  :kst_tab_email_invio.allegati_cartella,   
						  :kst_tab_email_invio.allegati_pathfile,   
						  :kst_tab_email_invio.flg_ritorno_ricev,   
						  :kst_tab_email_invio.email_di_ritorno,
						  :kst_tab_email_invio.invio_batch,
						  :kst_tab_email_invio.lang,   
						  :kst_tab_email_invio.x_datins,   
						  :kst_tab_email_invio.x_utente 
						  ) 
			using kguo_sqlca_db_magazzino;


	if kguo_sqlca_db_magazzino.sqlCode <> 0 then
		k_return = false

		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante Inserimento Invio Email (email_invio) " + kkg.acapo +  trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.no_esecuzione
		
		if kguo_sqlca_db_magazzino.sqlCode < 0 then
			if kst_tab_email_invio.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_email_invio.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	else
		
//--- Piglia il ID che ha appena associato alla e-mail
		kst_tab_email_invio.id_email_invio = get_id_email_invio_max()
		//kst_tab_email_invio.id_email_invio = long(kguo_sqlca_db_magazzino.SQLReturnData)
		
		if kst_tab_email_invio.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_email_invio.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if

	end if


return k_return
end function

public function st_esito get_email (ref st_tab_email_invio kst_tab_email_invio);//
//====================================================================
//=== 
//=== Leggo tabella e-mail 
//=== 
//=== input: st_tab_email con valorizzato il campo id_email_invio
//=== rit: email
//=== Out: tab. ST_ESITO
//=== 
//====================================================================
//
st_esito kst_esito



kst_esito = kguo_exception.inizializza(this.classname())

if kst_tab_email_invio.id_email_invio > 0 then

  SELECT 
         email_invio.email 
    INTO 
         :kst_tab_email_invio.email  
    FROM email_invio  
	where email_invio.id_email_invio = :kst_tab_email_invio.id_email_invio
	using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Fallita lettura tab. Invio E-mail (email) ~n~r" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if
else
	kst_esito.esito = kkg_esito.no_esecuzione
end if


return kst_esito

end function

public function boolean tb_update (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception;//
//====================================================================
//=== Aggiorna un rek nella tabella email_invio 
//=== 
//=== Ritorna TRUE=ok
//===   
//====================================================================
boolean k_return = true
st_esito kst_esito



	kst_esito = kguo_exception.inizializza(this.classname())

	kst_tab_email_invio.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_email_invio.x_utente = kGuf_data_base.prendi_x_utente()

	kst_tab_email_invio.data_ins = date(kst_tab_email_invio.x_datins)   // aggiorna la data di inserimento 

	setnull(kst_tab_email_invio.data_inviato)

	if_isnull(kst_tab_email_invio)

	update email_invio
			set email = :kst_tab_email_invio.email
			    ,  cod_funzione = :kst_tab_email_invio.cod_funzione
				,  note = :kst_tab_email_invio.note
				,  id_oggetto = :kst_tab_email_invio.id_oggetto
				,  id_cliente = :kst_tab_email_invio.id_cliente
				,  data_ins = :kst_tab_email_invio.data_ins
				,  data_inviato = :kst_tab_email_invio.data_inviato
				,  ora_inviato = ''
				,  oggetto = :kst_tab_email_invio.oggetto
				,  link_lettera = :kst_tab_email_invio.link_lettera
				,  lettera = :kst_tab_email_invio.lettera
				,  flg_lettera_html = :kst_tab_email_invio.flg_lettera_html
				,  flg_allegati = :kst_tab_email_invio.flg_allegati
				,  allegati_cartella = :kst_tab_email_invio.allegati_cartella
				,  flg_ritorno_ricev = :kst_tab_email_invio.flg_ritorno_ricev
				,  email_di_ritorno = :kst_tab_email_invio.email_di_ritorno 
				,  invio_batch = :kst_tab_email_invio.invio_batch 
				,  lang = :kst_tab_email_invio.lang 
				,  allegati_pathfile = :kst_tab_email_invio.allegati_pathfile
				,  x_datins = :kst_tab_email_invio.x_datins
				,  x_utente = :kst_tab_email_invio.x_utente
			where id_email_invio = :kst_tab_email_invio.id_email_invio
			using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlCode <> 0 then
		k_return = false
		
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante Aggiornamento Invio Email (email_invio) ~n~r" +  trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.no_esecuzione
		if kguo_sqlca_db_magazzino.sqlCode < 0 then
		
			if kst_tab_email_invio.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_email_invio.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		end if

	else
		
		if kst_tab_email_invio.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_email_invio.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if

	end if


return k_return
end function

public function boolean set_data_inviato (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception;//
//====================================================================
//=== Aggiorna la data/ora dell'invio nella tabella email_invio 
//=== 
//=== Ritorna TRUE=ok
//===   
//====================================================================
boolean k_return
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	//if_sicurezza(kkg_flag_modalita.inserimento)

	kst_tab_email_invio.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_email_invio.x_utente = kGuf_data_base.prendi_x_utente()

	update email_invio
			set 
				data_inviato = :kst_tab_email_invio.data_inviato
				,  ora_inviato = :kst_tab_email_invio.ora_inviato
				,  x_datins = :kst_tab_email_invio.x_datins
				,  x_utente = :kst_tab_email_invio.x_utente
			where id_email_invio = :kst_tab_email_invio.id_email_invio
			using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlCode < 0 then

		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante Aggiornamento Invio Email (data_inviato) ~n~r" +  trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		
		if kst_tab_email_invio.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_email_invio.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if

		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if
	
	if kguo_sqlca_db_magazzino.sqlCode = 0 then
		
		if kst_tab_email_invio.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_email_invio.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if

		k_return = true
	end if

return k_return
end function

public function st_esito check_presenza (ref st_tab_email_invio kst_tab_email_invio);//
//====================================================================
//=== 
//=== Leggo tabella e-mail x Controllo Presenza del Record
//=== 
//=== input: st_tab_email con valorizzato il campo id_email_invio
//=== rit: id_email_invio
//=== Out: tab. ST_ESITO
//=== 
//====================================================================
//
st_esito kst_esito



kst_esito = kguo_exception.inizializza(this.classname())

if kst_tab_email_invio.id_email_invio > 0 then

  SELECT 
         email_invio.id_email_invio 
    INTO 
         :kst_tab_email_invio.id_email_invio  
    FROM email_invio  
	where email_invio.id_email_invio = :kst_tab_email_invio.id_email_invio
	using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Fallita lettura tab. Invio E-mail (email) ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if
else
	kst_esito.esito = kkg_esito.no_esecuzione
end if


return kst_esito

end function

public function integer delete_allegati (st_tab_email_invio kst_tab_email_invio) throws uo_exception;//---
//--- Cancella gli allegati alla email
//--- input:  st_tab_email_invio.id_email_invio
//--- out: numero di allegati rimossi
//--- se ERRORE grave lanca EXCEPTION 
//---
int k_return=0
boolean k_sicurezza = true
long k_max, k_idx
string k_filename
datastore kds_dirlist
st_esito kst_esito
kuf_file_explorer kuf1_file_explorer


try

	kst_esito = kguo_exception.inizializza(this.classname())
	
	if not if_sicurezza(kkg_flag_modalita.cancellazione) then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Rimozione allegati alla e-mail non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
		
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	
	else
	
		if kst_tab_email_invio.id_email_invio > 0 then
			
			get_allegati_cartella(kst_tab_email_invio)
			if trim(kst_tab_email_invio.allegati_cartella) > " " then
					
				kuf1_file_explorer = create kuf_file_explorer
				kds_dirlist = kuf1_file_explorer.DirList(trim(kst_tab_email_invio.allegati_cartella) + "\*.*")
				k_max = kds_dirlist.rowcount( )
				for k_idx = 1 to k_max
		//--- estrae il file da cancellare
					k_filename = trim(kds_dirlist.getitemstring(k_idx, "nome"))
					if fileDelete(trim(kst_tab_email_invio.allegati_cartella) + "\" + k_filename) then
						k_return ++ 
					end if
				end for
		
		//		RemoveDirectory (trim(kst_tab_email_invio.allegati_cartella))
			
			end if		
	
			get_allegati_pathfile(kst_tab_email_invio)
			if trim(kst_tab_email_invio.allegati_pathfile) > " " then
				if fileDelete(trim(kst_tab_email_invio.allegati_pathfile)) then
					k_return ++ 
				end if
			end if
		end if
		
	end if
		
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kds_dirlist) then destroy kds_dirlist
	if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
	
end try

return k_return

end function

public function boolean get_id_email_invio_minimo_x_data_ins (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception;/*
====================================================================

 Torna ID_EMAIL_INVIO dalla data di ins passata
 
 input: st_tab_email con valorizzato il campo data_ins
 rit: id_email_invio
 Out: TRUE = ok
 
====================================================================
*/
boolean k_return = false
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if kst_tab_email_invio.data_ins > date(0) then

  SELECT 
         min(email_invio.id_email_invio) 
    INTO 
         :kst_tab_email_invio.id_email_invio  
    FROM email_invio  
	where email_invio.data_ins >= :kst_tab_email_invio.data_ins
	using sqlca;

	if sqlca.sqlcode = 0 then
		if isnull(kst_tab_email_invio.id_email_invio) then kst_tab_email_invio.id_email_invio = 0
		k_return = true
	else
		kst_tab_email_invio.id_email_invio = 0
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore in lettura ID Invio E-mail (email) per data " + string(kst_tab_email_invio.data_ins) + "~n~r" + trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
end if


return k_return


end function

public function boolean tb_add_autorizzativo (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception;//
//====================================================================
//=== Aggiunge un rek nella tabella email_invio 
//=== 
//=== Ritorna TRUE=ok
//===   
//====================================================================
boolean k_return = false
boolean k_autorizza
st_esito kst_esito



kst_esito = kguo_exception.inizializza(this.classname())

kst_tab_email_invio.id_email_invio = 0

//--- controlla se utente autorizzato alla funzione in atto
k_autorizza = if_sicurezza(kkg_flag_modalita.inserimento) 

if k_autorizza then

	k_return = tb_add(kst_tab_email_invio)

end if

return k_return
end function

public function boolean tb_update_autorizzativo (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception;//
//====================================================================
//=== Aggiorna un rek nella tabella email_invio 
//=== 
//=== Ritorna TRUE=ok
//===   
//====================================================================
boolean k_return = false
boolean k_autorizza
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

k_autorizza = if_sicurezza(kkg_flag_modalita.inserimento)

if k_autorizza then
	
	k_return = tb_update(kst_tab_email_invio)
	
end if


return k_return
end function

public function long get_id_email_invio_max () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo ID inserito 
//--- 
//---  input: 
//---  ret: max id_email_invio
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	SELECT max(id_email_invio)
		 INTO 
				:k_return
		 FROM email_invio  
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo ID Email in tabella (EMAIL_INVIO)" &
									 + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if isnull(k_return) then k_return = 0
	else
		k_return = 0
	end if
	

return k_return

end function

public function boolean u_invio_email (st_tab_email_invio kst_tab_email_invio) throws uo_exception;//--- 
//--- Invia e-mail e aggiorna tabella
//--- inp: st_tab_email_invio.id_email_invio
//--- out: true x email inviata
//---
boolean k_return
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())

	kst_esito = get_riga(kst_tab_email_invio)   // Legge i dati di dettaglio della EMAIL da inviare
	if kst_esito.esito = kkg_esito.not_fnd then
		kguo_exception.set_esito(kst_esito)
		kguo_exception.kist_esito.sqlerrtext = "Invio email non effettuato. Dati dettaglio email non trovati in archivio. Id: " + string(kst_tab_email_invio.id_email_invio) &
				+ " oggetto: " + trim(kst_tab_email_invio.oggetto) + "~n~r" + trim(kst_esito.sqlerrtext)
		throw kguo_exception
	end if

	if len(trim(kst_tab_email_invio.email)) > 0 then
	else
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlerrtext =  "Invio email non effettuato. Manca indirizzo destinatario.  Id: " + string(kst_tab_email_invio.id_email_invio) &
				+ " oggetto: " + trim(kst_tab_email_invio.oggetto)
		throw kguo_exception
	end if

//--- Invio e-mail	
	if invio(kst_tab_email_invio) then

//--- aggiorna la tab invio_email con la data di invio
		kst_tab_email_invio.data_inviato = today() //date(kGuf_data_base.prendi_x_datins())
		kst_tab_email_invio.ora_inviato = string(now(), "hhmmss")
		set_data_inviato(kst_tab_email_invio)

		k_return = true				
	
	else
		
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlerrtext = "Email non inviata, id: " + string(kst_tab_email_invio.id_email_invio) &
				+ " oggetto: " + trim(kst_tab_email_invio.oggetto) &
				+ " a: " + trim(kst_tab_email_invio.email) &
				+ " note: " + trim(kst_tab_email_invio.note) 
		throw kguo_exception
	
	end if

catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log()
	throw kuo_exception
		
end try


return k_return

end function

public function st_esito get_riga (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception;//
//====================================================================
//=== 
//=== Leggo tabella e-mail 
//=== 
//=== input: st_tab_email con valorizzato il campo id_email
//=== Ritorna tab. ST_ESITO
//=== 
//====================================================================
//
int k_rc
st_esito kst_esito
uo_ds_std_1 kds_email_invio

kst_esito = kguo_exception.inizializza(this.classname())

if kst_tab_email_invio.id_email_invio > 0 then

//  SELECT 
//         email_invio.email,   
//         email_invio.note,   
//         email_invio.id_cliente,   
//         email_invio.data_ins,   
//         email_invio.data_inviato,   
//         email_invio.ora_inviato,   
//         email_invio.oggetto,   
//         email_invio.lettera,   
//         email_invio.link_lettera,   
//         email_invio.lang,   
//         email_invio.allegati_cartella,   
//         email_invio.allegati_pathfile,   
//         email_invio.flg_lettera_html,   
//         email_invio.flg_ritorno_ricev,  
//         email_invio.email_di_ritorno,  
//         email_invio.flg_allegati 
//    INTO 
//         :kst_tab_email_invio.email,   
//         :kst_tab_email_invio.note,   
//         :kst_tab_email_invio.id_cliente,   
//         :kst_tab_email_invio.data_ins,   
//         :kst_tab_email_invio.data_inviato,   
//         :kst_tab_email_invio.ora_inviato,   
//         :kst_tab_email_invio.oggetto,   
//         :kst_tab_email_invio.lettera,   
//         :kst_tab_email_invio.link_lettera,   
//         :kst_tab_email_invio.lang,   
//         :kst_tab_email_invio.allegati_cartella,   
//         :kst_tab_email_invio.allegati_pathfile,   
//         :kst_tab_email_invio.flg_lettera_html,   
//         :kst_tab_email_invio.flg_ritorno_ricev,  
//         :kst_tab_email_invio.email_di_ritorno,  
//         :kst_tab_email_invio.flg_allegati 
//    FROM email_invio  
//	where email_invio.id_email_invio = :kst_tab_email_invio.id_email_invio
//	using sqlca;

	kds_email_invio = create uo_ds_std_1
	kds_email_invio.dataobject = "ds_email_invio"
	kds_email_invio.settransobject(kguo_sqlca_db_magazzino )
	
	k_rc = kds_email_invio.retrieve(kst_tab_email_invio.id_email_invio)

	if k_rc > 0 then
		
		kst_tab_email_invio.email              = kds_email_invio.getitemstring(1, "email")
		kst_tab_email_invio.note               = kds_email_invio.getitemstring(1, "note")
		kst_tab_email_invio.id_cliente         = kds_email_invio.getitemnumber(1, "id_cliente")
		kst_tab_email_invio.data_ins           = kds_email_invio.getitemdate(1, "data_ins")
		kst_tab_email_invio.data_inviato       = kds_email_invio.getitemdate(1, "data_inviato")
		kst_tab_email_invio.ora_inviato        = kds_email_invio.getitemstring(1, "ora_inviato")
		kst_tab_email_invio.oggetto            = kds_email_invio.getitemstring(1, "oggetto")
		kst_tab_email_invio.lettera            = kds_email_invio.getitemstring(1, "lettera")
		kst_tab_email_invio.link_lettera       = kds_email_invio.getitemstring(1, "link_lettera")
		kst_tab_email_invio.lang               = kds_email_invio.getitemstring(1, "lang")
		kst_tab_email_invio.allegati_cartella  = kds_email_invio.getitemstring(1, "allegati_cartella")
		kst_tab_email_invio.allegati_pathfile  = kds_email_invio.getitemstring(1, "allegati_pathfile")
		kst_tab_email_invio.flg_lettera_html   = kds_email_invio.getitemstring(1, "flg_lettera_html")
		kst_tab_email_invio.flg_ritorno_ricev  = kds_email_invio.getitemstring(1, "flg_ritorno_ricev")
		kst_tab_email_invio.email_di_ritorno   = kds_email_invio.getitemstring(1, "email_di_ritorno")
		kst_tab_email_invio.flg_allegati       = kds_email_invio.getitemstring(1, "flg_allegati")		
		
	else
		kst_esito.SQLErrText =  "Fallita lettura tab. Invio E-mail." + kkg.acapo+ "Esito: " + trim(kds_email_invio.kist_esito.SQLErrText)
		kst_esito.sqlcode = kds_email_invio.kist_esito.sqlcode

		if kst_esito.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kst_esito.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
				
			end if
		end if
	end if
else
	kst_esito.esito = kkg_esito.no_esecuzione
end if


return kst_esito

end function

public function long u_invio_batch () throws uo_exception;//
//------------------------------------------------------------------
//--- Invio email con il flag BATCH = 1 
//--- 
//---  input: 
//---  ret: email inviate
//---                                     
//------------------------------------------------------------------
//
long k_return, k_nmailbatch, k_row
st_tab_email_invio kst_tab_email_invio
uo_ds_std_1 kds_email_invio_batch


try
	kguo_exception.inizializza(this.classname())
	
	kds_email_invio_batch = create uo_ds_std_1
	kds_email_invio_batch.dataobject = "ds_email_invio_batch"
	kds_email_invio_batch.settransobject(kguo_sqlca_db_magazzino)
	k_nmailbatch = kds_email_invio_batch.retrieve()

	if k_nmailbatch < 0 then
		kguo_exception.kist_esito = kds_email_invio_batch.kist_esito //k_nmailbatch
		kguo_exception.kist_esito.SQLErrText = "Errore in lettura email da inviare via 'batch' " &
									 + kkg.acapo  + trim(kds_email_invio_batch.kist_esito.sqlerrtext)
		kguo_exception.kist_esito.esito = kkg_esito.db_ko
		throw kguo_exception
	end if

	for k_row = 1 to k_nmailbatch
		
		kst_tab_email_invio.id_email_invio = kds_email_invio_batch.getitemnumber(k_row, "id_email_invio")
		if kst_tab_email_invio.id_email_invio > 0 then
			
			ki_messagebox_if_error = false // non espone il messagebox
			if this.u_invio_email(kst_tab_email_invio) then
				k_return++
			end if
		end if
		
	next

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if isnull(k_return) then k_return = 0
	else
		k_return = 0
	end if
catch (uo_exception kuo_exception) 
	throw kuo_exception
	
finally
	if isvalid(kds_email_invio_batch) then destroy kds_email_invio_batch

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
	k_ctr = u_invio_batch( )
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Operazione conclusa correttamente. " + "Sono stati inviate " + string(k_ctr) + " email." 
	else
		kst_esito.esito = kkg_esito.not_fnd
		kst_esito.SQLErrText = "Operazione conclusa. Nessuna email inviata."
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

private function string get_file_lettera_lang (ref st_tab_email_invio kst_tab_email_invio);//
//--- torna il nome del file della comunicazione da inviare 
//--- verifica la presenza del file in lingua se necessario
//
string k_file
kuf_utility kuf1_utility


if kst_tab_email_invio.lang > " " and kst_tab_email_invio.link_lettera > " " then
	
	kuf1_utility = create kuf_utility
	
	k_file = kuf1_utility.u_file_add_suff(kst_tab_email_invio.link_lettera, kst_tab_email_invio.lang)
	
	if fileexists(k_file) then
		kst_tab_email_invio.link_lettera = k_file
	end if
	
end if

return kst_tab_email_invio.link_lettera
end function

private function boolean invio (st_tab_email_invio kst_tab_email_invio) throws uo_exception;//--- 
//--- Invio e-mail attraverso SMTP
//---
boolean k_return = false
boolean k_flg_ricevuta = false
String ls_body, ls_server, ls_uid, ls_pwd, k_email
String ls_filename, ls_port
Integer li_idx, li_max, k_pos_ini, k_pos_fin
Boolean lb_html
string k_esito=""
string ls_Emp_Input
string k_attached_files[]
int k_idx, k_idx_max
datastore kds_dirlist
st_email_address kst_email_address
st_tab_base kst_tab_base
st_esito kst_esito
kuf_base kuf1_base
kuf_file_explorer kuf1_file_explorer
kuf_email kuf1_email
kuf_utility kuf1_utility
n_smtp gn_smtp


try
	//SetPointer(HourGlass!)
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	kuf1_file_explorer = create kuf_file_explorer
	kuf1_base = create kuf_base
	kuf1_utility = create kuf_utility
	//gn_smtp = create n_smtp
	
	
	//of_setreg("SendName", sle_send_name.text)
	//of_setreg("SendEmail", sle_send_email.text)
	//of_setreg("FromName", sle_from_name.text)
	//of_setreg("FromEmail", sle_from_email.text)
	//of_setreg("Subject", sle_subject.text)
	//of_setreg("Body", mle_body.text)
	//
	//If cbx_sendhtml.checked Then
	//	of_setreg("SendHTML", "Y")
	//Else
	//	of_setreg("SendHTML", "N")
	//End If
	//
	//ls_server = of_getreg("SmtpServer", "")
	//
	//If ls_server = "" Then
	//	MessageBox("Edit Error", &
	//		"You must specify Server on the Settings tab first!")
	//	Return
	//End If
	//
	//If sle_send_email.text = "" Then
	//	MessageBox("Edit Error", &
	//		"To Email is a required field!")
	//	Return
	//End If
	//
	//If sle_from_email.text = "" Then
	//	MessageBox("Edit Error", &
	//		"From Email is a required field!")
	//	Return
	//End If
	//
	//If sle_subject.text = "" Then
	//	MessageBox("Edit Error", &
	//		"Subject is a required field!")
	//	Return
	//End If
	//
	//If mle_body.text = "" Then
	//	MessageBox("Edit Error", &
	//		"Body is a required field!")
	//	Return
	//End If
	
	if kst_tab_email_invio.flg_lettera_html = ki_lettera_html_si then
	//If of_getreg("SendHTML", "N") = "Y" Then
	//	ls_body  = "<html><body bgcolor='#F5F5DC' topmargin=8 leftmargin=8><h2>"
	//	ls_body += of_replaceall(mle_body.text, "~n~r", "<br>") + "</h2>"
	//	If lb_attachments.TotalItems() > 0 Then
	//		ls_body += "<img src='cid:attach.1'>"
	//	End If
	//	ls_body += "</body></html>"
		lb_html = True
	Else
	//	ls_body = mle_body.text
		lb_html = False
	End If
	
	
	k_esito = kuf1_base.prendi_dato_base( "smtp_logfile")
	if left(k_esito,1) <> "0" then
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.SQLErrText = mid(k_esito,2)
	else
		kst_tab_base.smtp_logfile = trim(mid(k_esito,2))
	end if
	if kst_tab_base.smtp_logfile = "S" then
	//If of_getreg("Logfile", "N") = "Y" Then
		gn_smtp.of_SetLogfile(True)
	Else
		gn_smtp.of_SetLogfile(False)
	End If
	gn_smtp.of_DeleteLogfile()
	
	
	k_esito = kuf1_base.prendi_dato_base( "smtp_autorizz_rich")
	if left(k_esito,1) <> "0" then
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.SQLErrText = mid(k_esito,2)
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		kst_tab_base.smtp_autorizz_rich = trim(mid(k_esito,2))
	end if
	
	// set properties
	if kst_tab_base.smtp_autorizz_rich = "S" then
	//If of_getreg("SmtpAuth", "N") = "Y" Then
		k_esito = kuf1_base.prendi_dato_base( "smtp_user")
		if left(k_esito,1) <> "0" then
			kst_esito.esito = kkg_esito.db_ko  
			kst_esito.SQLErrText = mid(k_esito,2)
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		else
			kst_tab_base.smtp_user = trim(mid(k_esito,2))
		end if
		k_esito = kuf1_base.prendi_dato_base( "smtp_pwd")
		if left(k_esito,1) <> "0" then
			kst_esito.esito = kkg_esito.db_ko  
			kst_esito.SQLErrText = mid(k_esito,2)
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		else
			kst_tab_base.smtp_pwd = trim(mid(k_esito,2))
		end if
	
	//	ls_uid = of_getreg("SmtpUserid", "")
	//	ls_pwd = of_getreg("SmtpPassword", "")
		gn_smtp.of_SetLogin(kst_tab_base.smtp_user, kst_tab_base.smtp_pwd)
	End If
	
	k_esito = kuf1_base.prendi_dato_base( "smtp_port")
	if left(k_esito,1) <> "0" then
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.SQLErrText = mid(k_esito,2)
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		kst_tab_base.smtp_port = trim(mid(k_esito,2))
	end if
	//gn_smtp.of_SetPort(Integer(of_getreg("SmtpPort", "25")))
	gn_smtp.of_SetPort(Integer(kst_tab_base.smtp_port))
	
	k_esito = kuf1_base.prendi_dato_base( "smtp_server")
	if left(k_esito,1) <> "0" then
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.SQLErrText = mid(k_esito,2)
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		kst_tab_base.smtp_server = trim(mid(k_esito,2))
	end if
	gn_smtp.of_SetServer(kst_tab_base.smtp_server)
	
	k_esito = kuf1_base.prendi_dato_base( "rag_soc_1")
	if left(k_esito,1) <> "0" then
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.SQLErrText = mid(k_esito,2)
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		kst_tab_base.rag_soc_1 = trim(mid(k_esito,2))
	end if
	k_esito = kuf1_base.prendi_dato_base( "rag_soc_2")
	if left(k_esito,1) <> "0" then
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.SQLErrText = mid(k_esito,2)
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		kst_tab_base.rag_soc_2 = trim(mid(k_esito,2))
	end if
	if isnull(kst_tab_base.rag_soc_1) then kst_tab_base.rag_soc_1 = " "
	if isnull(kst_tab_base.rag_soc_2) then kst_tab_base.rag_soc_2 = " "
	if trim(kst_tab_email_invio.email_di_ritorno) > " " then
	else
		k_esito = kuf1_base.prendi_dato_base( "e_mail")
		if left(k_esito,1) <> "0" then
			kst_esito.esito = kkg_esito.db_ko  
			kst_esito.SQLErrText = mid(k_esito,2)
			kst_tab_email_invio.email_di_ritorno = "email@email.com"   // nel caso la email non si trovi neanche in Proprietà Azienda
		else
			kst_tab_email_invio.email_di_ritorno = trim(mid(k_esito,2))
		end if
	end if
	gn_smtp.of_SetFrom(trim(kst_tab_email_invio.email_di_ritorno), kst_tab_base.rag_soc_1 + " " + kst_tab_base.rag_soc_2 )
	
	if kst_tab_email_invio.flg_ritorno_ricev = ki_ricev_ritorno_si then
		gn_smtp.of_SetReceipt(true)
	else
		gn_smtp.of_SetReceipt(false)
	end if
	
	
	//--- Imposto l'oggetto
	kst_tab_email_invio.oggetto = u_message_replace_placeholder(kst_tab_email_invio, kst_tab_email_invio.oggetto) // sostituisce i segnaposto con i valori
	gn_smtp.of_SetSubject(kst_tab_email_invio.oggetto)
	
	//--- Imposto il corpo della comunicazione da Inviare!!!!!!!
	ls_Emp_Input = get_comunicazione(kst_tab_email_invio) // recupera il messaggio da file o lettera
	ls_Emp_Input = u_message_replace_placeholder(kst_tab_email_invio, ls_Emp_Input) // sostituisce i segnaposto con i valori

	gn_smtp.of_SetBody(ls_Emp_Input, lb_html)
	
	gn_smtp.of_Reset()
	
	//--- Aggiungo gli Indirizzi email separati da ',' o ';' se più di uno nel recipient 
	//---      e Controllo sintassi Indirizzi email				
	try
		kst_email_address.email_all = kst_tab_email_invio.email
		kuf1_email = create kuf_email
		kuf1_email.get_email_from_string(kst_email_address)
		k_idx_max = upperbound(kst_email_address.address[])
		for k_idx = 1 to k_idx_max
			k_email = kst_email_address.address[k_idx]
			if k_email > " " then
				gn_smtp.of_AddTo(k_email, " ")  // potrei mettere IL NOME del destinatario: sle_send_name.text)
			end if
		next
	catch (uo_exception kuo1_exception)
		kst_esito = kuo1_exception.get_st_esito()
		kst_esito.esito = kkg_esito.no_esecuzione  
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	finally
		if isvalid(kuf1_email) then destroy kuf1_email
	end try
	
	
	// add any attachments
	if kst_tab_email_invio.flg_allegati = ki_allegati_si then
		
		if trim(kst_tab_email_invio.allegati_cartella) > " " then	
			if DirectoryExists (trim(kst_tab_email_invio.allegati_cartella)) then
	//--- piglia l'elenco dei file xml contenuti nella cartella
				kds_dirlist = kuf1_file_explorer.DirList(kst_tab_email_invio.allegati_cartella+"\*.*")
				li_max = kds_dirlist.rowcount()
				if right(kst_tab_email_invio.allegati_cartella, 1) = kkg.path_sep then
				else
					kst_tab_email_invio.allegati_cartella += kkg.path_sep
				end if
				for li_idx = 1 to li_max
		//--- estrae il file da allegare
					ls_filename = trim(kds_dirlist.getitemstring(li_idx, "nome"))
					gn_smtp.of_AddFile(kst_tab_email_invio.allegati_cartella + ls_filename) // aggiunge un file 
				end for
			else
	//--- se la cartella non esiste
				kst_esito.esito = kkg_esito.no_esecuzione  
				kst_esito.SQLErrText = "La cartella Allegati (" + trim(kst_tab_email_invio.allegati_cartella) + ") non esiste. Id e-mail " &
						+ string(kst_tab_email_invio.id_email_invio) + " non inviata! "
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
		
//--- invio di singoli file separati da ';' se indicato
		if trim(kst_tab_email_invio.allegati_pathfile) > " " then	
			
			k_attached_files[1] = trim(kst_tab_email_invio.allegati_pathfile)
			li_max = kuf1_utility.u_stringa_split(k_attached_files[], ";")  // divide la stringa in più file separati da ';'
			k_idx = 0
			for li_idx = 1 to li_max
				if k_attached_files[li_idx] > " " then
					k_idx ++
					if k_idx > 10 then 
						kguo_exception.inizializza(this.classname())
						kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_dati_anomali
						
						kguo_exception.kist_esito.sqlerrtext = "Errore in Invio EMAIL id " + string(kst_tab_email_invio.id_email_invio) &
											+ ". Superati i 10 file allegati, questo il primo dei non inviati: " + k_attached_files[li_idx] + ". Prego Verificare!!!" &
											+ " Email inviata ugualmente ma non con tutti gli allegati." 
						exit  // NON ALLEGA PIU' DI 10 FILE !!!!
						
					end if
					gn_smtp.of_AddFile(k_attached_files[li_idx]) // aggiunge un file 
				end if
			end for

		end if
	//li_max = lb_attachments.TotalItems()
	//For li_idx = 1 To li_max
	//	ls_filename = lb_attachments.Text(li_idx)
	//	gn_smtp.of_AddFile(ls_filename)
	//Next
	end if
	
	gn_smtp.of_setmessagebox(ki_messagebox_if_error)   // true = espone un messagebox se c'e' un errore; FALSE=scrive solo log
	
	// send the message
	If gn_smtp.of_SendMail() Then
		k_return = true
	
	//	MessageBox("SendMail", "Mail successfully sent!")
	Else
		k_return = false
	
	//	MessageBox("SendMail Error", gn_smtp.is_msgtext)
	End If

catch (uo_exception kuo_exception)
	throw kuo_exception


finally	
	if isvalid(kds_dirlist) then destroy kds_dirlist
	if isvalid(kuf1_base) then destroy kuf1_base
	if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
	if isvalid(kuf1_utility) then destroy kuf1_utility
	
	
end try

return k_return

end function

public function long u_add_email (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception;//------------------------------------------------------------------------------------------------------------------------
//--- Carica email per l'invio
//--- Inp: st_tab_email_invio id_cliente 
//--- Out: il ID del nuovo email_invio
//------------------------------------------------------------------------------------------------------------------------
//
long k_return=0 
boolean k_upd_email
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())

	if_isnull(kst_tab_email_invio)
	
//--- indirizzi email impostati?
	if trim(kst_tab_email_invio.email) > " " then
	
		if trim(kst_tab_email_invio.allegati_pathfile) > " " or trim(kst_tab_email_invio.allegati_cartella) > " " then
			kst_tab_email_invio.flg_allegati = ki_allegati_si
		else
			kst_tab_email_invio.flg_allegati = ki_allegati_no
		end if
		
//--- Controllo la presenza in elenco della EMAIL
		if kst_tab_email_invio.id_oggetto > 0 then
			kst_tab_email_invio.id_email_invio = if_presente_x_id_oggetto(kst_tab_email_invio)
		end if

//--- CARICO dati nella tabella EMAIL_INVIO	
		k_return = 0
		if kst_tab_email_invio.id_email_invio > 0 then
			k_upd_email = tb_update(kst_tab_email_invio) 
			if k_upd_email then 
				k_return = 0 // solo aggiornamento kst_tab_email_invio.id_email_invio
			end if
		else
			k_upd_email = tb_add(kst_tab_email_invio)
			if k_upd_email then 
				k_return = kst_tab_email_invio.id_email_invio //nuovo!
			end if
		end if		
		if NOT k_upd_email then
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Errore in preparazione e-mail da inviare. Oggetto: " &
					+ trim(kst_tab_email_invio.oggetto) + " (" + kst_tab_email_invio.cod_funzione + ") " &
					+ kkg.acapo + "a: " + trim(kst_tab_email_invio.email)
			kguo_exception.set_esito(kst_esito)
			kguo_exception.scrivi_log( )
		end if
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Errore in preparazione e-mail da inviare. Manca l'indirizzo. " +  kkg.acapo + "Oggetto: " &
				+ trim(kst_tab_email_invio.oggetto) + " (" + kst_tab_email_invio.cod_funzione + ")" 
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
catch (uo_exception kuo_exception)	
	throw kuo_exception
	
finally
	
end try


return k_return

end function

public function boolean tb_delete (st_tab_email_invio kst_tab_email_invio) throws uo_exception;//
//====================================================================
//=== Cancella il rek dalla tabella email_invio 
//=== 
//=== Ritorna ST_ESITO
//===           		
//====================================================================

boolean k_autorizza, k_presente, k_return
long k_cli
st_tab_base kst_tab_base
kuf_base kuf1_base
st_tab_arfa kst_tab_arfa_pdf
st_esito kst_esito
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza


try

	kst_esito = kguo_exception.inizializza(this.classname())
	
	kst_open_w = kst_open_w
	kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
	kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.anteprima) 
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	if not k_autorizza then
	
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Cancellazione Invio E-mail non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	else
		
		delete from email_invio
						where id_email_invio = :kst_tab_email_invio.id_email_invio 
						using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlCode <> 0 then
	
			if kguo_sqlca_db_magazzino.sqlCode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore durante cancellazione Invio Email (email_invio) ~n~r" +  trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.no_esecuzione
				
				if kst_tab_email_invio.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_email_invio.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
				
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		else
			if kst_tab_email_invio.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_email_invio.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
	
			k_return = true
	
			try
					
				delete_allegati(kst_tab_email_invio)
					
			catch	(uo_exception kuo_exception)
			
			end try
	
		end if
	end if
	
catch (uo_exception kuo1_exception)
	throw kuo1_exception

end try

return k_return
end function

public function string get_allegati_cartella (ref st_tab_email_invio kst_tab_email_invio);//
//------------------------------------------------------------------
//--- 
//--- Leggo tabella e-mail x prendere "allegati_cartella"
//--- 
//--- input: st_tab_email con valorizzato il campo id_email_invio
//--- Out: st_tab_email.allegati_cartella
//--- rit: allegati_cartella
//--- 
//------------------------------------------------------------------
//
string k_return 
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())

	if kst_tab_email_invio.id_email_invio > 0 then
	
	  SELECT 
				email_invio.allegati_cartella 
		 INTO 
				:kst_tab_email_invio.allegati_cartella  
		 FROM email_invio  
		where email_invio.id_email_invio = :kst_tab_email_invio.id_email_invio
		using sqlca;
	
		if sqlca.sqlcode = 0 then
			if kst_tab_email_invio.allegati_cartella > " " then
				k_return = kst_tab_email_invio.allegati_cartella  
			end if
		else
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura cartella allegati in tab. Invio E-mail ~n~r" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
			kguo_exception.set_esito(kst_esito)
			if sqlca.sqlcode < 0 then
				throw kguo_exception
			else
				kguo_exception.scrivi_log( )
			end if
		end if
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Errore in lettura cartella allegati in tab. Invio E-mail. Manca codice."
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally

end try

return k_return

end function

public function string get_allegati_pathfile (ref st_tab_email_invio kst_tab_email_invio);//
//------------------------------------------------------------------
//--- 
//--- Leggo tabella e-mail x prendere "allegati_pathfile"
//--- 
//--- input: st_tab_email con valorizzato il campo id_email_invio
//--- Out: st_tab_email.allegati_pathfile
//--- rit: allegati_pathfile
//--- 
//------------------------------------------------------------------
//
string k_return 
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())

	if kst_tab_email_invio.id_email_invio > 0 then
	
	  SELECT 
				trim(email_invio.allegati_pathfile)
		 INTO 
				:kst_tab_email_invio.allegati_pathfile  
		 FROM email_invio  
		where email_invio.id_email_invio = :kst_tab_email_invio.id_email_invio
		using sqlca;
	
		if sqlca.sqlcode = 0 then
			if kst_tab_email_invio.allegati_pathfile > " " then
				k_return = kst_tab_email_invio.allegati_pathfile  
			end if
		else
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura posizione allegato in tab. Invio E-mail. " + kkg.acapo + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
			kguo_exception.set_esito(kst_esito)
			if sqlca.sqlcode < 0 then
				throw kguo_exception
			else
				kguo_exception.scrivi_log( )
			end if
		end if
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Errore in lettura posizione allegato in tab. Invio E-mail. Manca codice."
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally

end try

return k_return

end function

public function long if_presente_x_id_oggetto (st_tab_email_invio kst_tab_email_invio) throws uo_exception;//
//-----------------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna il ID_EMAIL_INVIO più alto per id_oggetto (=id_fattura o id_meca o ...)
//--- 
//--- input: st_tab_email id_oggetto e cod_funzione
//--- 
//--- ritorna: id_email_invio
//--- 
//-----------------------------------------------------------------------------------------------------------------------
//
long k_return = 0
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if kst_tab_email_invio.id_oggetto > 0 then

  	SELECT 
         max(email_invio.id_email_invio) 
	    INTO 
         :kst_tab_email_invio.id_email_invio  
		FROM email_invio  
		where email_invio.id_oggetto = :kst_tab_email_invio.id_oggetto
		        and email_invio.cod_funzione = :kst_tab_email_invio.cod_funzione
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_email_invio.id_email_invio > 0 then
			k_return = kst_tab_email_invio.id_email_invio
		else
			kst_tab_email_invio.id_email_invio = 0
		end if
	else
		kst_tab_email_invio.id_email_invio = 0
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Fallita lettura E-mail inviate (email_invio) per id oggetto " + string(kst_tab_email_invio.id_oggetto) + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
else
	kst_tab_email_invio.id_email_invio = 0
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca id oggetto per la lettura E-mail inviata (email_invio) " 
	kst_esito.esito = kkg_esito.db_ko
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if


return k_return


end function

public subroutine if_isnull (ref st_tab_email_invio kst_tab_email_invio);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_email_invio.id_email_invio) then kst_tab_email_invio.id_email_invio = 0
if isnull(kst_tab_email_invio.cod_funzione) then kst_tab_email_invio.cod_funzione = ""
if isnull(kst_tab_email_invio.note) then kst_tab_email_invio.note= ""
if isnull(kst_tab_email_invio.id_oggetto) then kst_tab_email_invio.id_oggetto = 0
if isnull(kst_tab_email_invio.id_cliente) then kst_tab_email_invio.id_cliente = 0
if isnull(kst_tab_email_invio.data_ins) then kst_tab_email_invio.data_ins= date(0)
if isnull(kst_tab_email_invio.data_inviato) then kst_tab_email_invio.data_inviato= date(0)
if isnull(kst_tab_email_invio.email) then kst_tab_email_invio.email= ""
if isnull(kst_tab_email_invio.ora_inviato) then kst_tab_email_invio.ora_inviato= ""
if isnull(kst_tab_email_invio.allegati_cartella) then kst_tab_email_invio.allegati_cartella = ""
if isnull(kst_tab_email_invio.allegati_pathfile) then kst_tab_email_invio.allegati_pathfile = ""
if isnull(kst_tab_email_invio.flg_allegati) then kst_tab_email_invio.flg_allegati = ""
if isnull(kst_tab_email_invio.oggetto) then kst_tab_email_invio.oggetto = ""
if isnull(kst_tab_email_invio.lettera) then kst_tab_email_invio.lettera = ""
if isnull(kst_tab_email_invio.link_lettera) then kst_tab_email_invio.link_lettera = ""
if isnull(kst_tab_email_invio.lang) then kst_tab_email_invio.lang = ""
if isnull(kst_tab_email_invio.flg_lettera_html) then kst_tab_email_invio.flg_lettera_html = ""
if isnull(kst_tab_email_invio.flg_ritorno_ricev) then kst_tab_email_invio.flg_ritorno_ricev = ""
if isnull(kst_tab_email_invio.email_di_ritorno) then kst_tab_email_invio.email_di_ritorno = ""
if isnull(kst_tab_email_invio.flg_lettera_html) then kst_tab_email_invio.flg_lettera_html = ""
if isnull(kst_tab_email_invio.invio_batch) then kst_tab_email_invio.invio_batch = 0

end subroutine

public function long get_id_meca (st_tab_email_invio ast_tab_email_invio) throws uo_exception;//
//----------------------------------------------------
//--- 
//--- Torna ID_MECA se possibile da email indicata
//--- 
//--- input: st_tab_email_invio. id_email_invio oppure cod_funzione + id_oggetto
//--- out: 
//--- Ritorna long id_meca se trovato
//--- 
//---------------------------------------------------
//
long k_return = 0
st_tab_certif kst_tab_certif
kuf_email_funzioni kuf1_email_funzioni
kuf_certif kuf1_certif


try	
	if ast_tab_email_invio.cod_funzione > " " then
	else
		get_cod_funzione(ast_tab_email_invio)
	end if
	
	if ast_tab_email_invio.id_oggetto > 0 then
	else
		get_id_oggetto(ast_tab_email_invio)
	end if
	
	choose case ast_tab_email_invio.cod_funzione
		
		case kuf1_email_funzioni.kki_cod_funzione_prontoMerce
			k_return = ast_tab_email_invio.id_oggetto
	
		case kuf1_email_funzioni.kki_cod_funzione_Attestati
			kuf1_certif = create kuf_certif
			kst_tab_certif.id = ast_tab_email_invio.id_oggetto
			k_return = kuf1_certif.get_id_meca_da_id(kst_tab_certif)
			
		case kuf1_email_funzioni.kki_cod_funzione_avvGiacenzaLotti
			k_return = 0 // id_oggetto contiene il cliente
			
			//kki_cod_funzione_fatturaNOallegati
			//kki_cod_funzione_fatturaSIallegati
			//
	end choose

catch (uo_exception kuo_exception)
	throw kuo_exception
		
finally 
	if isvalid(kuf1_certif) then destroy kuf1_certif
		
end try


return k_return 

end function

public function string get_cod_funzione (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception;//
//====================================================================
//=== 
//=== Torna il COD_FUNZIONE
//=== 
//=== input: st_tab_email.id_email_invio
//=== rit: cod_funzione
//=== Out: cod_funzione
//=== 
//====================================================================
//
string k_return
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if kst_tab_email_invio.id_email_invio > 0 then

  SELECT cod_funzione
    INTO 
         :kst_tab_email_invio.cod_funzione  
    FROM email_invio  
	where email_invio.id_email_invio = :kst_tab_email_invio.id_email_invio
	using kguo_sqlca_db_magazzino;

	if sqlca.sqlcode = 0 then
		if isnull(kst_tab_email_invio.cod_funzione) then kst_tab_email_invio.cod_funzione = ""
	else
		kst_tab_email_invio.cod_funzione = ""
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Fallita lettura 'cod_funzione' in tab. Invio E-mail. ID " + string(kst_tab_email_invio.id_email_invio) + "~n~r" + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		if sqlca.sqlcode < 0 then
			throw kguo_exception
		else
			kguo_exception.scrivi_log( )
		end if
	end if
	
else	

	kst_esito.SQLErrText = "Errore in lettura 'cod_funzione' tab. Invio E-mail. Manca ID email."
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
	
end if

k_return = trim(kst_tab_email_invio.cod_funzione)

return k_return


end function

public function long get_id_oggetto (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception;//
//====================================================================
//=== 
//=== Torna il ID_OGGETTO
//=== 
//=== input: st_tab_email.id_email_invio
//=== rit: id_oggetto
//=== Out: id_oggetto
//=== 
//====================================================================
//
long k_return
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if kst_tab_email_invio.id_email_invio > 0 then

  SELECT id_oggetto
    INTO 
         :kst_tab_email_invio.id_oggetto  
    FROM email_invio  
	where email_invio.id_email_invio = :kst_tab_email_invio.id_email_invio
	using kguo_sqlca_db_magazzino;

	if sqlca.sqlcode = 0 then
		if isnull(kst_tab_email_invio.id_oggetto) then kst_tab_email_invio.id_oggetto = 0
	else
		kst_tab_email_invio.id_oggetto = 0
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Fallita lettura 'id oggetto' in tab. Invio E-mail. ID " + string(kst_tab_email_invio.id_email_invio) + "~n~r" + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		if sqlca.sqlcode < 0 then
			throw kguo_exception
		else
			kguo_exception.scrivi_log( )
		end if
	end if
	
else	

	kst_esito.SQLErrText = "Errore in lettura 'id oggetto' tab. Invio E-mail. Manca ID email."
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
	
end if

k_return = kst_tab_email_invio.id_oggetto

return k_return


end function

public function string u_anteprima_comunicazone (ref st_tab_email_invio ast_tab_email_invio) throws uo_exception;//
//------------------------------------------------------------------
//--- 
//--- Fa l'anteprima della comunicazione (corpo email)
//--- 
//--- input: st_tab_email.id_email_invio + link_lettera + lettera
//--- Out: 
//--- rit: la comunicazione 
//--- 
//------------------------------------------------------------------
//
string k_file, k_msg, k_path
integer li_FileNum, k_rc
long ll_FLength
st_esito kst_esito
kuf_file_explorer kuf1_file_explorer


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_email_invio.id_email_invio > 0 then
	
		k_msg = get_comunicazione(ast_tab_email_invio) // recupera il messaggio da file o lettera
		k_msg = u_message_replace_placeholder(ast_tab_email_invio, k_msg) // sostituisce i segnaposto con i valori
		
		if k_msg > " " then
			
//--- scrive il messaggio in area temp		
			k_path = kguo_path.get_temp( ) + kkg.path_sep + "email" + string(ast_tab_email_invio.id_email_invio) + ".html"
			li_FileNum = FileOpen(k_path, LineMode!, write!, Shared!, Replace!, EncodingUTF8!)
			k_rc = FileWriteEx(li_FileNum, k_msg)
			FileClose(li_FileNum)
			
			if k_rc > 0 then
				kuf1_file_explorer = create kuf_file_explorer
				// visualizza il file con il pgm appropriato
				if not kuf1_file_explorer.of_execute( k_path ) then
					kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
					kguo_exception.setmessage( "Il file non può essere aperto, forse estensione non riconosciuta: " + k_path)
					throw kguo_exception
				end if
			end if
			
		end if
		
	else	
	
		kst_esito.SQLErrText = "Errore in Anteprima della comunicazione. Manca ID email."
		kst_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally	
	if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
	
end try

return k_msg


end function

public function string get_comunicazione (st_tab_email_invio ast_tab_email_invio) throws uo_exception;//--- 
//--- Torna il corpo del messaggio html/testo con gli eventuali segnaposto 
//---
string k_return
integer li_FileNum
long ll_FLength
st_esito kst_esito
 

try
	//SetPointer(HourGlass!)
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if trim(ast_tab_email_invio.link_lettera) > " " then
		get_file_lettera_lang(ast_tab_email_invio)  // restituisce il nome file eventualmente in lingua

		if fileexists(trim(ast_tab_email_invio.link_lettera)) then
		else
			kst_esito.SQLErrText = "Errore in lettura della comunicazione email. File non trovato: " &
										+ trim(ast_tab_email_invio.link_lettera)
			kst_esito.esito = kkg_esito.no_esecuzione
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		ll_FLength = FileLength64(trim(ast_tab_email_invio.link_lettera))
		if ll_FLength < 32767 THEN
			li_FileNum = FileOpen(trim(ast_tab_email_invio.link_lettera), TextMode!)
			FileReadEx(li_FileNum, k_return)
			FileClose(li_FileNum)
		else
			kst_esito.esito = kkg_esito.no_esecuzione  
			kst_esito.SQLErrText = "Comunicazione email " + ast_tab_email_invio.link_lettera + " troppo grande, occupa " + trim(string(ll_FLength)) + " bytes! E-mail " &
						+ string(ast_tab_email_invio.id_email_invio) + " bloccata! "
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		END IF
	else
		if trim(ast_tab_email_invio.lettera) > " " then
			k_return = trim(ast_tab_email_invio.lettera)
		else
	//--- se la comunicazione non esiste
			kst_esito.esito = kkg_esito.no_esecuzione  
			kst_esito.SQLErrText = "Manca il testo della comunicazione , indicare il file o scrivere un testo se possibile, e-mail " &
						+ string(ast_tab_email_invio.id_email_invio) + " bloccata! "
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception


finally	
	
end try

return k_return

end function

private function string u_message_replace_placeholder (st_tab_email_invio ast_tab_email_invio, string a_message) throws uo_exception;//--- 
//--- Completa la comunicazione email sostituendo i segnaposto con i valori
//--- inp: st_tab_email_invio.lettera + o cod_funzione + id_oggetto o id_email_invio
//--- ret: messaggio con i valori al posto dei segnaposto
//---
st_msg_replace_placeholder kst_msg_replace_placeholder
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())

	kst_msg_replace_placeholder.msg = a_message
	if kiuf_msg_replace_placeholder.u_check_placeholder(kst_msg_replace_placeholder) > 0 then

		kst_msg_replace_placeholder.id_meca = get_id_meca(ast_tab_email_invio)
		if kst_msg_replace_placeholder.id_meca > 0 then
		
			kst_msg_replace_placeholder.msg = kiuf_msg_replace_placeholder.u_message_replace_placeholder(kst_msg_replace_placeholder)
			
		end if
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
		
finally 
		
end try


return kst_msg_replace_placeholder.msg

end function

public subroutine u_comunicazione_modifica (ref st_tab_email_invio ast_tab_email_invio) throws uo_exception;//
//------------------------------------------------------------------
//--- 
//--- Fa la modifica della comunicazione (corpo email)
//--- 
//--- input: st_tab_email.id_email_invio + link_lettera 
//--- Out: 
//--- rit: la comunicazione 
//--- 
//------------------------------------------------------------------
//
st_esito kst_esito
kuf_file_explorer kuf1_file_explorer


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if_sicurezza(kkg_flag_modalita.modifica)
	
	kuf1_file_explorer = create kuf_file_explorer
	
	// visualizza il file con il pgm appropriato
	if not kuf1_file_explorer.of_execute_edit( ast_tab_email_invio.link_lettera, "html" ) then
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
		kguo_exception.setmessage( "La comunicazione non può essere aperta, forse estensione non riconosciuta: " + ast_tab_email_invio.link_lettera)
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally	
	if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
	
end try




end subroutine

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;//
//=== 
//====================================================================
//=== Attiva LINK cliccato 
//===
//=== Par. Inut: 
//===               datawindow su cui è stato attivato il LINK
//===               nome campo di LINK
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc=0, k_riga=0
string k_rcx="", k_titolo
boolean k_return=true
st_esito kst_esito
datastore kdsi_elenco_output  
kuf_elenco kuf1_elenco
kuf_web kuf1_web


	SetPointer(kkg.pointer_attesa)
	
	kdsi_elenco_output = create datastore
	
	kst_esito = kguo_exception.inizializza(this.classname())

	choose case a_campo_link
	
		case "b_email_rubrica"
			kst_esito = this.anteprima_rubrica(kdsi_elenco_output)
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			k_titolo = "Rubrica indirizzi email" 
			
	end choose
	
	if k_return then
	
		if kdsi_elenco_output.rowcount() > 0 then
			kuf1_elenco = create kuf_elenco 
			kuf1_elenco.u_open_zoom(k_titolo, a_campo_link, kdsi_elenco_output) //CAMPO DI LINK + DATASTORE CON I DATI
			destroy kuf1_elenco
		else
			kguo_exception.inizializza()
			kguo_exception.setmessage( "Nessun valore disponibile. " )
			throw kguo_exception
		end if
	end if

	SetPointer(kkg.pointer_default)

return k_return

end function

public function st_esito anteprima_rubrica (datastore kdw_anteprima) throws uo_exception;//
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
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza


	kst_esito = kguo_exception.inizializza(this.classname())

//--- controlla se utente autorizzato alla funzione in atto
	this.if_sicurezza(kkg_flag_modalita.anteprima)

	kdw_anteprima.dataobject = "d_email_rubrica"		
	kdw_anteprima.settransobject(sqlca)

//--- retrive dell'attestato 
	k_rc=kdw_anteprima.retrieve()

	if k_rc < 0 then
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun elenco indirizzi email da visualizzare." // ~n~r" 
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if


return kst_esito

end function

public function boolean get_data_ins (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception;/*
====================================================================

 Torna la data di inserimento
 
 input: st_tab_email con valorizzato il campo il ID_EMAIL_INVIO
 rit: data_ins
 Out: TRUE = ok
 
====================================================================
*/

boolean k_return = false
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if kst_tab_email_invio.id_email_invio > 0 then

  SELECT 
         email_invio.data_ins 
    INTO 
         :kst_tab_email_invio.data_ins 
    FROM email_invio  
	where email_invio.id_email_invio = :kst_tab_email_invio.id_email_invio
	using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if isnull(kst_tab_email_invio.data_ins) then kst_tab_email_invio.data_ins = date(0)
		k_return = true
	else
		kst_tab_email_invio.data_ins = date(0)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore in lettura Data Inserimento Invio E-mail (email) per ID " + string(kst_tab_email_invio.id_email_invio) + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
end if


return k_return


end function

on kuf_email_invio.create
call super::create
end on

on kuf_email_invio.destroy
call super::destroy
end on

event destructor;call super::destructor;//
if isvalid(kiuf_msg_replace_placeholder) then destroy kiuf_msg_replace_placeholder

end event

event constructor;call super::constructor;//
kiuf_msg_replace_placeholder = create kuf_msg_replace_placeholder

end event

