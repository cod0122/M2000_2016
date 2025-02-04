$PBExportHeader$kuf_email.sru
forward
global type kuf_email from kuf_parent
end type
end forward

global type kuf_email from kuf_parent
end type
global kuf_email kuf_email

type variables

//--- path dove risiedono le comunicazioni
 string kki_path_email = kkg.path_sep + "email"

//--- stato
 string ki_stato_attivo = "A"
 string ki_stato_sospeso = "S"

//--- in HTML
 string ki_lettera_html_si = "S"
 string ki_lettera_html_no = "N"

//--- Ricevuta di ritorno
 string ki_ricev_ritorno_si = "S"
 string ki_ricev_ritorno_no = "N"



end variables

forward prototypes
public function st_esito tb_delete (st_tab_email kst_tab_email)
public function st_esito anteprima (datastore kdw_anteprima, st_tab_email kst_tab_email)
public function boolean if_presente (st_tab_email kst_tab_email) throws uo_exception
public function boolean if_sintassi_email_ok (string kst_email)
public function integer get_email_from_string (ref st_email_address ast_email_address) throws uo_exception
private function string u_uniform_email_separator (string k_email_all)
private function any u_get_email_array (ref string k_email_all)
public subroutine if_isnull (ref st_tab_email kst_tab_email)
public function string get_link_lettera (ref st_tab_email kst_tab_email) throws uo_exception
public function string get_attached (ref st_tab_email kst_tab_email) throws uo_exception
public function string get_riga (ref st_tab_email kst_tab_email) throws uo_exception
public function string get_oggetto (ref st_tab_email kst_tab_email) throws uo_exception
public function boolean if_presente_x_cod_funzione (string a_cod_funzione) throws uo_exception
end prototypes

public function st_esito tb_delete (st_tab_email kst_tab_email);//
//====================================================================
//=== Cancella il rek dalla tabella EMAIL 
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

boolean k_autorizza, k_presente
long k_cli
st_tab_email_funzioni kst_tab_email_funzioni
kuf_email_funzioni kuf1_email_funzioni
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

try
	k_autorizza = if_sicurezza(kkg_flag_modalita.cancellazione)
	if k_autorizza then
	
		kuf1_email_funzioni = create kuf_email_funzioni
		
		kst_tab_email_funzioni.id_email = kst_tab_email.id_email 	
		k_presente = kuf1_email_funzioni.if_presente(kst_tab_email_funzioni)
		
		destroy kuf1_email_funzioni
	
		if k_presente then
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Email già presente tra le Proprietà della Procedura  ~n~r" 
			kst_esito.esito = kkg_esito.no_esecuzione
		end if

		if not k_presente then
			
			delete from email
					where id_email = :kst_tab_email.id_email 
					using kguo_sqlca_db_magazzino;
		
			if kguo_sqlca_db_magazzino.sqlCode <> 0 then
		
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore durante cancellazione Email ~n~r" +  trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.no_esecuzione
				
				if kst_tab_email.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_email.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
	
			else
				
				if kst_tab_email.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_email.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_commit( )
				end if
		
			end if
		end if
	end if

	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	
finally
	if isvalid(kuf1_email_funzioni) then destroy kuf1_email_funzioni
		
end try

return kst_esito
end function

public function st_esito anteprima (datastore kdw_anteprima, st_tab_email kst_tab_email);//
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


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

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
		if kdw_anteprima.dataobject = "d_email"  then
			if kdw_anteprima.object.id_email[1] = kst_tab_email.id_email  then
				kst_tab_email.id_email = 0
			end if
		end if
	end if

	if kst_tab_email.id_email > 0 then
	
			kdw_anteprima.dataobject = "d_email"		
			kdw_anteprima.settransobject(sqlca)
	
//			kuf1_utility = create kuf_utility
//			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_email.id_email)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessuna configurazione E-mail da visualizzare: ~n~r" + "nessun Codice indicato"
			kst_esito.esito = kkg_esito.bug
			
		end if
end if


return kst_esito

end function

public function boolean if_presente (st_tab_email kst_tab_email) throws uo_exception;/*
Presenza della riga e-mail per ID
	inp: st_tab_email con valorizzato il campo id_email
	out: 
	rit: TRUE = presente
*/
boolean k_return
string k_trovato = ""


kguo_exception.inizializza(this.classname())

if kst_tab_email.id_email > 0 then
	k_trovato = ""
	SELECT distinct "1"
	    INTO 
         :k_trovato
   	 	FROM email  
		where email.id_email = :kst_tab_email.id_email
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
					"Fallita lettura tabella Configurazione e-mail, id " + string(kst_tab_email.id_email))		
		throw kguo_exception
	end if
else
	kguo_exception.kist_esito.SQLErrText = "Manca id per leggere la Configurazione E-mail."
	kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
	throw kguo_exception
end if

if k_trovato = "1" then k_return = true   // TROVATO!!!

return k_return

end function

public function boolean if_sintassi_email_ok (string kst_email);//---
//--- Controllo sintassi E-MAIL
//---
//--- Input: st_web.email valorizzato
//--- Out: TRUE=ok, False=indirizzo errato

kst_email = trim(kst_email)

return match(kst_email, "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+$")
//								"[a-zA-z0-9]+[-.]*[a-zA-z0-9]*[@][a-zA-z0-9]+[-.][a-zA-z0-9]+[a-zA-z0-9]$")
//                      '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z][a-zA-Z][a-zA-Z]*[a-zA-Z]*$'
//    						"[a-zA-Z0-9_\.]+@[a-zA-Z0-9-]+\.[a-zA-Z]{0,4}"

end function

public function integer get_email_from_string (ref st_email_address ast_email_address) throws uo_exception;//
//--- trova gli indirizzi email da una stringa
//--- inp: ast_email_address.email_all stringa con email
//--- out: kst_email_address.address[] array con le email trovate nella string
//--- rit: n.email trovate 
//
int k_email_n_max, k_email_idx
st_esito kst_esito
st_email_address kst_email_address


	kst_esito = kguo_exception.inizializza(this.classname())

	kst_email_address.email_all = trim(ast_email_address.email_all)

//--- estrae gli Indirizzi email separati da ',' o ';' o ....
	kst_email_address.address = u_get_email_array(kst_email_address.email_all)

	k_email_n_max = UpperBound(kst_email_address.address)
	for k_email_idx = 1 to k_email_n_max
		
		if not if_sintassi_email_ok(kst_email_address.address[k_email_idx]) then
				  
			kst_esito.esito = kkg_esito.ko
			if kst_esito.sqlerrtext = "" then
				kst_esito.sqlerrtext = "Fallita verifica indirizzo email: " + kst_email_address.address[k_email_idx] 
			else
				kst_esito.sqlerrtext += ", " + kst_email_address.address[k_email_idx] 
			end if
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
							  
		end if
	next
	
	ast_email_address.address[] = kst_email_address.address[]
	ast_email_address.email_all = kst_email_address.email_all


return k_email_n_max



end function

private function string u_uniform_email_separator (string k_email_all);//
//--- Uniforma i separatori a ","
//
//--- inp: stringa con tutte le email separate da un carattere tipo "," ";" ":"...
//---     
//--- out: string con tutte le email e un separatore uguale (",") per tutte
//
int k_idx
char k_separator[3] = {";", ":", "#" }
kuf_utility kuf1_utility


	kuf1_utility = create kuf_utility

	for k_idx = 1 to 3
		
		k_email_all = kuf1_utility.u_string_replace(k_email_all, k_separator[k_idx], ",")
		
	next

	destroy kuf1_utility
	
return k_email_all

end function

private function any u_get_email_array (ref string k_email_all);//
//--- Estrazione elenco email da stringa 
//
//--- inp: stringa con tutte le email separate da un carattere tipo "," ";" ":"....
//--- out: any = array con elenco email
//
long k_pos_start, k_pos_end, k_len, k_email_idx
string k_email_address[], k_email


//--- normalizza la stringa con le email con un solo separatore 
	k_email_all = u_uniform_email_separator(k_email_all)

//--- legge il primo indirizzo	
	k_pos_start = 1
	k_pos_end = pos(k_email_all, ",", k_pos_start)
	
	do while k_pos_end > 1
		
		k_len = k_pos_end - k_pos_start  
		k_email = trim(mid(k_email_all, k_pos_start, k_len))
		if k_email > " " then
			k_email_idx ++
			k_email_address[k_email_idx] = k_email
		end if
		
//--- legge il successivo indirizzo		
		k_pos_start = k_pos_end + 1
		k_pos_end = pos(k_email_all, ",", k_pos_start)
		
	loop

//--- accoda l'ultima email se non ha il separatore
	k_pos_end = len(k_email_all)
	if k_pos_end > k_pos_start then
		k_len = k_pos_end - k_pos_start  + 1
		k_email = trim(mid(k_email_all, k_pos_start, k_len))
		if k_email > " " then
			k_email_idx ++
			k_email_address[k_email_idx] = k_email
		end if
	end if

	
	return k_email_address

end function

public subroutine if_isnull (ref st_tab_email kst_tab_email);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_email.id_email) then kst_tab_email.id_email = 0
if isnull(kst_tab_email.stato) then kst_tab_email.stato = ""
if isnull(kst_tab_email.codice) then kst_tab_email.codice = ""
if isnull(kst_tab_email.des) then kst_tab_email.des = ""
if isnull(kst_tab_email.oggetto) then kst_tab_email.oggetto = ""
if isnull(kst_tab_email.link_lettera) then kst_tab_email.link_lettera = ""
if isnull(kst_tab_email.flg_lettera_html) then kst_tab_email.flg_lettera_html = ""
if isnull(kst_tab_email.flg_ritorno_ricev) then kst_tab_email.flg_ritorno_ricev = ""
if isnull(kst_tab_email.flg_lettera_html) then kst_tab_email.flg_lettera_html = ""
if isnull(kst_tab_email.email_di_ritorno) then kst_tab_email.email_di_ritorno = ""
if isnull(kst_tab_email.invio_batch) then kst_tab_email.invio_batch = 0


end subroutine

public function string get_link_lettera (ref st_tab_email kst_tab_email) throws uo_exception;/*
--------------------------------------------------------------------
 Leggo tabella e-mail per prendere il campo link_lettera

   input: st_tab_email con valorizzato il campo id_email
     out: st_tab_email.link_lettera
 Ritorna: link_lettera
--------------------------------------------------------------------
*/
string k_return 

kguo_exception.inizializza(this.classname())

kst_tab_email.link_lettera = ""

if kst_tab_email.id_email > 0 then

  SELECT
         email.link_lettera 
    INTO 
         :kst_tab_email.link_lettera 
    FROM email  
	where email.id_email = :kst_tab_email.id_email
	using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.kist_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kguo_exception.kist_esito.SQLErrText = "Fallita lettura posizione della Comunicazione e-mail Id '" &
									+ string(kst_tab_email.id_email) + "' (link_lettera)! " + kkg.acapo + "Esito: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_db_ko
		throw kguo_exception
	end if
	
	if trim(kst_tab_email.link_lettera) > " " then
		k_return = trim(kst_tab_email.link_lettera)
	end if
	
else
	kguo_exception.kist_esito.SQLErrText = "Lettura posizione della Comunicazione e-mail (link_lettera) non eseguito, manca Id di configurazione email! "
	kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_non_eseguito
	throw kguo_exception
end if

return k_return

end function

public function string get_attached (ref st_tab_email kst_tab_email) throws uo_exception;/*
--------------------------------------------------------------------
 Leggo tabella e-mail per prendere il path dell'Allegato

   input: st_tab_email con valorizzato il campo id_email
     out: st_tab_email.attached
 Ritorna: attached
--------------------------------------------------------------------
*/
string k_return 

kguo_exception.inizializza(this.classname())

kst_tab_email.attached = ""

if kst_tab_email.id_email > 0 then

  SELECT
         email.attached 
    INTO 
         :kst_tab_email.attached 
    FROM email  
	where email.id_email = :kst_tab_email.id_email
	using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.kist_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kguo_exception.kist_esito.SQLErrText = "Fallita lettura posizione dell'Allegato alla comunicazione e-mail Id '" &
									+ string(kst_tab_email.id_email) + "' (attached)! " + kkg.acapo + "Esito: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_db_ko
		throw kguo_exception
	end if
	
	if trim(kst_tab_email.attached) > " " then
		k_return = trim(kst_tab_email.attached)
	end if
	
else
	kguo_exception.kist_esito.SQLErrText = "Lettura posizione dell'Allegato alla comunicazione e-mail (attached) non eseguito, manca Id di configurazione email! "
	kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_non_eseguito
	throw kguo_exception
end if

return k_return

end function

public function string get_riga (ref st_tab_email kst_tab_email) throws uo_exception;/*
--------------------------------------------------------------------
 Leggo tabella e-mail per prendere tutti i dati di configurazione

   input: st_tab_email con valorizzato il campo id_email
     out: st_tab_email.*
 Ritorna: codice
--------------------------------------------------------------------
*/
string k_return


kguo_exception.inizializza(this.classname())

if kst_tab_email.id_email > 0 then

  SELECT trim(email.codice),   
         trim(email.stato),   
         trim(email.des),   
         trim(email.oggetto),   
         case
				when trim(email.oggetto_lang) > ' ' then trim(email.oggetto_lang)
				else trim(email.oggetto) 
			end, 
         trim(email.link_lettera),   
         trim(email.flg_lettera_html),   
         trim(email.flg_ritorno_ricev),  
         trim(email.email_di_ritorno)  
         ,trim(coalesce(email.attached,''))
         ,trim(coalesce(email.email_to,''))  
         ,trim(coalesce(email.email_cc,''))  
         ,trim(coalesce(email.email_ccn,''))  
	      ,coalesce(email.invio_batch,0) invio_batch
    INTO :kst_tab_email.codice,   
         :kst_tab_email.stato,   
         :kst_tab_email.des,   
         :kst_tab_email.oggetto,   
         :kst_tab_email.oggetto_lang,   
         :kst_tab_email.link_lettera,   
         :kst_tab_email.flg_lettera_html,   
         :kst_tab_email.flg_ritorno_ricev, 
			:kst_tab_email.email_di_ritorno 
		  ,:kst_tab_email.attached
		  ,:kst_tab_email.email_to
		  ,:kst_tab_email.email_cc
		  ,:kst_tab_email.email_ccn
		  ,:kst_tab_email.invio_batch
    FROM email  
	where email.id_email = :kst_tab_email.id_email
	using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Fallita lettura dati di Configurazione e-mail, id '" + string(kst_tab_email.id_email) + "' (email)! ")
		throw kguo_exception
	end if
	
	if trim(kst_tab_email.codice) > " " then
		k_return = trim(kst_tab_email.codice)
	end if
	
else
	kguo_exception.kist_esito.SQLErrText = "Lettura dati di Configurazione e-mail (email) non eseguito, manca id di configurazione email! "
	kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_non_eseguito
	throw kguo_exception
end if

return k_return

end function

public function string get_oggetto (ref st_tab_email kst_tab_email) throws uo_exception;/*
Leggo tabella e-mail per prendere il campo OGGETTO
	inp: st_tab_emai.id_email
	out: st_tab_email.oggetto e oggetto_lang
	rit: Oggetto (in italiano)
*/
string k_return


kguo_exception.inizializza(this.classname())

if kst_tab_email.id_email > 0 then

  SELECT
         trim(isnull(email.oggetto,'')),   
         case
				when trim(email.oggetto_lang) > ' ' then trim(email.oggetto_lang)
				else trim(isnull(email.oggetto,''))
			end
    INTO 
         :kst_tab_email.oggetto 
         ,:kst_tab_email.oggetto_lang
    FROM email  
	where email.id_email = :kst_tab_email.id_email
	using sqlca;

	if sqlca.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
					"Errore in lettura Oggetto da tabella di Configurazione email, id " + string(kst_tab_email.id_email))		
		throw kguo_exception
	end if

	if kst_tab_email.oggetto > " " then k_return = kst_tab_email.oggetto

end if

return k_return

end function

public function boolean if_presente_x_cod_funzione (string a_cod_funzione) throws uo_exception;/*
Presenza della riga e-mail per ID
	inp: st_tab_email con valorizzato il campo id_email
	out: 
	rit: TRUE = presente
*/
boolean k_return
string k_trovato = ""


kguo_exception.inizializza(this.classname())

if a_cod_funzione > " " then
	k_trovato = ""
	SELECT distinct "1"
	    INTO :k_trovato
    		FROM email_funzioni inner join email on email_funzioni.id_email = email.id_email
		where email_funzioni.cod_funzione = :a_cod_funzione
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
					"Fallita lettura tabella Configurazione e-mail, codice " + trim(a_cod_funzione))		
		throw kguo_exception
	end if
else
	kguo_exception.kist_esito.SQLErrText = "Manca codice funzione per leggere la Configurazione e-mail."
	kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
	throw kguo_exception
end if

if k_trovato = "1" then k_return = true   // TROVATO!!!

return k_return

end function

on kuf_email.create
call super::create
end on

on kuf_email.destroy
call super::destroy
end on

