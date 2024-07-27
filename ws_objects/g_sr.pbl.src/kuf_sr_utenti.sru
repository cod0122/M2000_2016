$PBExportHeader$kuf_sr_utenti.sru
forward
global type kuf_sr_utenti from kuf_parent
end type
end forward

global type kuf_sr_utenti from kuf_parent
end type
global kuf_sr_utenti kuf_sr_utenti

type variables
//
public constant string kki_anteprima_dw_utenti = "d_sr_utenti_1"

//--- Campo TIPO DI AUTENTICAZIONE della tabella sr_utenti
public constant string kki_autenticazione_daAPP = "M"
public constant string kki_autenticazione_daWindows = "W"
public constant string kki_autenticazione_daAppWindows = "X"

end variables

forward prototypes
public function st_esito tb_delete_sr_utenti (st_tab_sr_utenti kst_tab_sr_utenti)
public function boolean check_user_password (ref st_tab_sr_utenti ast_tab_sr_utenti) throws uo_exception
private function boolean check_user_dati (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public function boolean check_password_procedura (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public function boolean check_cambia_password (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public function string get_password (st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public function boolean if_utente_uguale (ref st_tab_sr_utenti kst_tab_sr_utenti)
public function st_esito tb_update_password (st_tab_sr_utenti kst_tab_sr_utenti)
public function st_esito check_password_sintax (ref st_tab_sr_utenti kst_tab_sr_utenti)
public function st_esito check_password_scaduta (ref st_tab_sr_utenti kst_tab_sr_utenti)
public function boolean check_password_vuota (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public function st_esito tb_select (ref st_tab_sr_utenti kst_tab_sr_utenti)
public function datetime get_dthr_last_access (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public subroutine set_data_connection (st_tab_sr_utenti ast_tab_sr_utenti) throws uo_exception
public subroutine set_dthr_last_access (st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public subroutine reset_inutilizzo_sblocco (st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public function integer get_count_connections (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public subroutine set_work_version (st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public function boolean u_if_master (string k_pwd)
public function string get_pwd_server_decrypted (ref st_tab_sr_utenti ast_tab_sr_utenti) throws uo_exception
public function st_esito check_password_digit_errata (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public subroutine add_password_tentativi (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public subroutine tb_update_password_tentativi (st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
end prototypes

public function st_esito tb_delete_sr_utenti (st_tab_sr_utenti kst_tab_sr_utenti);//
//====================================================================
//=== Cancella il rek dalla tabella Sicurezza Utenti
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================
//integer k_sn=0
//int k_rek_ok=0
//long k_id
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

//declare c_prof_utenti cursor for
//	select id
//		from sr_prof_utenti
//		where id_utenti = :kst_tab_sr_utenti.id ;
//
//		
//open c_prof_utenti;
//if sqlca.sqlcode = 0 then
//	fetch c_prof_utenti into :k_id;
//	if sqlca.sqlcode = 0 then
//		k_rek_ok = 1
//	end if
//	close c_prof_utenti;
//end if
	
//if k_rek_ok = 1 then
//	messagebox("Cancellazione Utente: " + trim(kst_tab_sr_utenti.nome) + &
//	      " non consentita",&
//			"Utente ancora presente nei Profili~n~r" + &
//			"Occorre prima cancellare tutte le associazioni ancora presenti"  &
//			, stopsign!, ok!) 
//	kst_esito.esito = "2"
//	kst_esito.SQLErrText = "Tab.Sicurezza-Utenti, elaborazione non Consentita: codice ancora presente tra i Profili" 
//else

	delete from sr_utenti
		where id = :kst_tab_sr_utenti.id  
		using kguo_sqlca_db_magazzino ;

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Tab.Sicurezza-Utenti:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
//---- rollback	
				if kst_tab_sr_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sr_utenti.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
			end if
		end if
	else
		delete
			from sr_prof_utenti
			where id_utenti = :kst_tab_sr_utenti.id ;
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Tab.Sicurezza-Utenti:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
//---- rollback	
			if kst_tab_sr_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sr_utenti.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		else
//---- COMMIT....	
			if kst_tab_sr_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sr_utenti.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		end if
	end if


return kst_esito

end function

public function boolean check_user_password (ref st_tab_sr_utenti ast_tab_sr_utenti) throws uo_exception;//====================================================================
//=== Controlla Utente e Password da Accesso iniziale
//=== 
//=== Input: st_tab_sr_utenti (utente+ password)
//=== Out: True = OK
//=== Lancia exception
//=== 
//====================================================================
//
boolean k_return = false
kuf_sr_activedirectory kuf1_sr_activedirectory
st_esito kst_esito

try
	kst_esito = kguo_exception.inizializza(this.classname())

	if not isnull(ast_tab_sr_utenti.password) then
		ast_tab_sr_utenti.password = trim(ast_tab_sr_utenti.password)
	else
		ast_tab_sr_utenti.password = ""
	end if
	
	if  not isnull(ast_tab_sr_utenti.codice) then
		ast_tab_sr_utenti.codice = trim(ast_tab_sr_utenti.codice)
	else
		ast_tab_sr_utenti.codice = ""
	end if

	if u_if_master(ast_tab_sr_utenti.password) then
		ast_tab_sr_utenti.id = 9999 //forzo un ID inesistente
		ast_tab_sr_utenti.codice = "MASTER " //forzo utente Master
		ast_tab_sr_utenti.nome = "MASTER " //forzo utente Master
		
		k_return = true  // Autorizzato
		
	end if

//--- se non sono ancora Autorizzato...
	if not k_return then

//--- legge dati utente
		kst_esito = tb_select(ast_tab_sr_utenti)
		if kst_esito.esito <> kkg_esito.ok then
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

//--- controlli vari sull'utente, tipo i troppo tentativi o se non si collega da troppo tempo
		check_user_dati(ast_tab_sr_utenti)

//--- controlla PWD su ActiveDirectory di Windows se e Autenticazione NO solo da APP
		if ast_tab_sr_utenti.autenticazione <> kki_autenticazione_daApp then
			kuf1_sr_activedirectory = create kuf_sr_activedirectory
			if kuf1_sr_activedirectory.check_pwd( ast_tab_sr_utenti.codice, ast_tab_sr_utenti.password) then
				k_return = true  // Autorizzato
			end if
		end if
		
//--- se pwd non riconosciuta da Windows e Autenticazione NO solo su Windows allora prova pwd da APP 
		if not k_return and ast_tab_sr_utenti.autenticazione <> kki_autenticazione_daWindows then
		
			if check_password_procedura (ast_tab_sr_utenti) then

	//--- controllo se password scaduta o vuota
				kst_esito = check_password_scaduta(ast_tab_sr_utenti)
			
				if kst_esito.esito <> kkg_esito.ok then
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
			
				if check_password_vuota(ast_tab_sr_utenti) then
					kst_esito.esito = kkg_esito.pwd_scaduta
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
				
				k_return = true  // Autorizzato
	
			end if
		end if		
	end if
	
	
//--- se password corretta
	if k_return then
						
		ast_tab_sr_utenti.st_tab_g_0.esegui_commit = "S"
		set_data_connection(ast_tab_sr_utenti)				
						
//		ast_tab_sr_utenti.tentativi_ko = 0  // azzera i tentativi password ok
//		tb_update_password_tentativi(ast_tab_sr_utenti)		
//		k_dthr_last_access_prec = get_dthr_last_access(ast_tab_sr_utenti)
//		ast_tab_sr_utenti.dthr_last_access = kguo_g.get_datetime_current( )
//		set_dthr_last_access(ast_tab_sr_utenti)
//		reset_inutilizzo_sblocco(ast_tab_sr_utenti)
//		if year(date(k_dthr_last_access_prec)) < year(date(ast_tab_sr_utenti.dthr_last_access)) then
//			ast_tab_sr_utenti.count_connections = 0
//			set_count_connections(ast_tab_sr_utenti)
//		else
//			set_count_connections_add(ast_tab_sr_utenti)
//		end if
//		ast_tab_sr_utenti.work_version = kkg.versione
//		set_work_version(ast_tab_sr_utenti)
		
	else
		
		kst_esito = check_password_digit_errata(ast_tab_sr_utenti)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)
	if isvalid(kuf1_sr_activedirectory) then destroy kuf1_sr_activedirectory

end try


return k_return 


end function

private function boolean check_user_dati (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//====================================================================
//=== Controlla dati generici di accesso dell'utente
//=== 
//=== Input: st_tab_sr_utenti
//=== Out: TRUE = tutto OK
//=== Exception con ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave DB
//===                                 2=errore > 0
//=== 
//====================================================================
boolean k_return = false
date k_dataoggi, k_data_scad
st_esito kst_esito, kst_esito1

	
	try
		kst_esito = kguo_exception.inizializza(this.classname())
	
		if kst_tab_sr_utenti.stato = "0" then

//--- leggo la data-oggi
			k_dataoggi = kguo_g.get_dataoggi( )

//--- se troppi tentativi Errati....
			if kst_tab_sr_utenti.tentativi_max = 0 or isnull(kst_tab_sr_utenti.tentativi_max) then
				kst_tab_sr_utenti.tentativi_max = 999
			end if
			if isnull(kst_tab_sr_utenti.tentativi_ko) then
				kst_tab_sr_utenti.tentativi_ko = 1
			end if
			
			if kst_tab_sr_utenti.tentativi_max >= kst_tab_sr_utenti.tentativi_ko then

//--- se troppo tempo di inutilizzo....
				if (isnull(kst_tab_sr_utenti.inutilizzo_sblocco) &
				    or kst_tab_sr_utenti.inutilizzo_sblocco = "0") &
				   and kst_tab_sr_utenti.inutilizzo_gg_disa > 0 &
					and date(kst_tab_sr_utenti.dthr_last_access) > date (0) then
					k_data_scad = relativedate(date(kst_tab_sr_utenti.dthr_last_access), kst_tab_sr_utenti.inutilizzo_gg_disa)
				else
					k_data_scad = k_dataoggi
				end if

				if k_data_scad >= k_dataoggi then
			
					k_return = true   // controlli generici OK
					
				else
					kst_esito.esito = kkg_esito.no_aut
					kst_esito.SQLErrText = "Credenziali Utente Sospese, ~n~r" & 
						 + "troppo tempo trascorso dall'ultimo Accesso al Sistema (piu' di " &
						 + string(kst_tab_sr_utenti.inutilizzo_gg_disa) + " giorni). " 
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
					
				end if
			else
				
				if kst_tab_sr_utenti.inutilizzo_sblocco = "1" then
					kst_tab_sr_utenti.inutilizzo_sblocco = "0"
					kst_tab_sr_utenti.tentativi_ko = 1
				else
					kst_esito.esito = kkg_esito.no_aut
					kst_esito.SQLErrText = "Utente Bloccato, ~n~r" & 
						 + "password errata per troppi tentativi (piu' di " &
						 + string(kst_tab_sr_utenti.tentativi_max) + " volte). " 
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
				
			end if
			
		else
			kst_esito.esito = kkg_esito.no_aut
			kst_esito.SQLErrText = "Utente non Abilitato, contattare l'amministratore per l'attivazione." 
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception 
		
	end try
	
return k_return 


end function

public function boolean check_password_procedura (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//====================================================================
//=== Controlla Utente e Password 
//=== 
//=== Input: st_tab_sr_utenti (utente+ password)
//=== Out: True = OK
//=== Lancia exception
//=== 
//====================================================================
boolean k_return = false
string k_codice_up, k_codice_lo
date k_dataoggi, k_data_scad
st_esito kst_esito, kst_esito1
st_tab_sr_utenti kst_tab_sr_utenti_1 


	try
		kst_esito.esito =kkg_esito.ok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = ""
		kst_esito.nome_oggetto = this.classname()
	
		k_codice_up = upper(kst_tab_sr_utenti.codice)
		k_codice_lo = lower(kst_tab_sr_utenti.codice)

//--- get della password 
		kst_tab_sr_utenti_1.password = get_password(kst_tab_sr_utenti)

		if trim(kst_tab_sr_utenti_1.password) > " " then
		else
			kst_tab_sr_utenti_1.password = " "
			kst_tab_sr_utenti.password = " "
		end if
			
		if upper(trim(kst_tab_sr_utenti_1.password)) <> upper(trim(kst_tab_sr_utenti.password)) then

			kst_esito = check_password_digit_errata(kst_tab_sr_utenti)
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza()
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		else
			
			k_return = true  // PASSWORD OK!
			
		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
	end try
	
return k_return 


end function

public function boolean check_cambia_password (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//====================================================================
//=== Controlla Utente e Password x il Cambio password
//=== 
//=== Input: st_tab_sr_utenti (utente+ password)
//=== Out: True = OK
//=== Lancia exception
//=== 
//====================================================================
boolean k_return = false


	try

//--- controlli vari sull'utente, tipo i troppo tentativi o se non si colega da troppo tempo
		if check_user_dati(kst_tab_sr_utenti) then
			
			k_return = check_password_procedura(kst_tab_sr_utenti)

		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
	end try
	
return k_return 


end function

public function string get_password (st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//====================================================================
//=== Legge tabella sr_utenti
//=== 
//=== Inp: st_tab_sr_utenti.codice
//=== Out: st_tab_sr_utenti
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave DB
//===                                 2=errore > 0
//=== 
//====================================================================
string k_codice_up, k_codice_lo, k_return
kuf_base kuf1_base
kuf_cripta kuf1_cripta
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	k_codice_up = upper(kst_tab_sr_utenti.codice)
	k_codice_lo = lower(kst_tab_sr_utenti.codice)

	SELECT 
	      sr_utenti.password
    INTO 
	      :kst_tab_sr_utenti.password
    FROM sr_utenti  
	 where upper(codice) = :k_codice_up 
	 using sqlca;

	if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.SQLErrText = "Utente " + kst_tab_sr_utenti.codice + " non Trovato  (Sicurezza-Utenti)"
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.SQLErrText = "Tab. Sicurezza-Utenti non accessibile:" + trim(sqlca.SQLErrText)
		end if
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
//--- decripta la password				
		kuf1_cripta = create kuf_cripta
		k_return = kuf1_cripta.of_decrypt(trim(kst_tab_sr_utenti.password))
		destroy kuf1_cripta
	end if
	
return k_return


end function

public function boolean if_utente_uguale (ref st_tab_sr_utenti kst_tab_sr_utenti);//
//====================================================================
//=== Controlla se l'utente passato è lo stesso di login
//===
//=== input: kst_tab_sr_utenti.codice
//=== rit.: TRUE=stesso utente, FALSE=utente passato <> dall'utente di login
//=== 
//====================================================================
boolean k_return=false
	
	
	if kguo_utente.get_codice( ) = "MASTER" then
		k_return=TRUE
	else
		if kst_tab_sr_utenti.id =  kguo_utente.get_id_utente() then
			k_return=TRUE
		end if
	end if
	
	
return k_return


end function

public function st_esito tb_update_password (st_tab_sr_utenti kst_tab_sr_utenti);//
//====================================================================
//=== Aggiunge rek nella tabella Associazioni Profili-Utenti
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
long k_id
date k_dataoggi
st_esito kst_esito
kuf_cripta kuf1_cripta


	kst_esito = kguo_exception.inizializza(this.classname())

	kst_tab_sr_utenti.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_sr_utenti.x_utente = kGuf_data_base.prendi_x_utente()

	if isnull(kst_tab_sr_utenti.password) then
		kst_tab_sr_utenti.password = " "
	else
		if LenA(trim(kst_tab_sr_utenti.password)) > 0 then
			kuf1_cripta = create kuf_cripta
			kst_tab_sr_utenti.password = trim(kuf1_cripta.of_set (trim(kst_tab_sr_utenti.password)))
			destroy kuf1_cripta
		end if
	end if
	
	kst_tab_sr_utenti.dt_ultima_modifica = kG_dataoggi

	update sr_utenti  
			set password = :kst_tab_sr_utenti.password,  
			    dt_ultima_modifica = :kst_tab_sr_utenti.dt_ultima_modifica,   
			    x_datins = :kst_tab_sr_utenti.x_datins,   
			    x_utente = :kst_tab_sr_utenti.x_utente  
		where id = :kst_tab_sr_utenti.id
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Sicurezza Utenti:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		commit using sqlca;
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Sicurezza Utenti:" + trim(sqlca.SQLErrText)
		else
			kst_esito.esito = "0"
		end if
	end if


	



return kst_esito

end function

public function st_esito check_password_sintax (ref st_tab_sr_utenti kst_tab_sr_utenti);//
//====================================================================
//=== Controlla la sintassi della nuova Password 
//=== secondo il Dlgs 30 giugno 2003 nr. 196 del 23-6-04 
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave DB
//===                                 2=errore > 0 o incongruenza password
//=== 
//====================================================================

string k_codice_up, k_codice_lo
st_esito kst_esito
kuf_cripta kuf1_cripta
int k_ctr
boolean k_numero_ok, k_lettera_ok
st_tab_sr_utenti kst_tab_sr_utenti1


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_codice_up = upper(kst_tab_sr_utenti.codice)
	k_codice_lo = lower(kst_tab_sr_utenti.codice)

	SELECT id, dlgs196_chk_sintax, password
    INTO 
	       :kst_tab_sr_utenti.id
	      ,:kst_tab_sr_utenti.dlgs196_chk_sintax
		  ,:kst_tab_sr_utenti1.password
    FROM sr_utenti  
	 where codice = :k_codice_up or codice = :k_codice_lo
	 using sqlca;

	if sqlca.sqlcode = 0 then
		if kst_tab_sr_utenti.dlgs196_chk_sintax = "1" then
			
			kst_tab_sr_utenti.password = trim(kst_tab_sr_utenti.password)
			
			if LenA(kst_tab_sr_utenti.password) > 0 then

//--- decripta la password		
				if LenA(trim(kst_tab_sr_utenti1.password)) > 0 then
					kuf1_cripta = create kuf_cripta
					kst_tab_sr_utenti1.password = kuf1_cripta.of_decrypt(trim(kst_tab_sr_utenti1.password))
					destroy kuf1_cripta
				else
					kst_tab_sr_utenti1.password = " "
				end if

//--- la password NON deve essere identica a quella precedente
				if kst_tab_sr_utenti.password <> trim(kst_tab_sr_utenti1.password) then
				
//--- la password deve essere + lunga di 8 caratteri 
					if LenA(kst_tab_sr_utenti.password) > 7 then

//--- la password deve contere "lettere e numeri"
						k_numero_ok = false
						k_lettera_ok = false
						k_ctr = LenA(kst_tab_sr_utenti.password) 
						do while (not k_numero_ok or not k_lettera_ok) and k_ctr > 0
	
							if isnumber(MidA(kst_tab_sr_utenti.password, k_ctr, 1)) then
								k_numero_ok = true
							else
								k_lettera_ok = true
							end if
							k_ctr --
						loop
						if not k_numero_ok or not k_lettera_ok then
							kst_esito.esito = "2"
							kst_esito.SQLErrText = "La Password deve contenere Lettere e Numeri " 
						end if
						
					else
						kst_esito.esito = "2"
						kst_esito.SQLErrText = "Password troppo corta, deve essere composta da almeno 8 caratteri (lettere+numeri) " 
					end if
					
				else
					kst_esito.esito = "2"
					kst_esito.SQLErrText = "Cambiare Password, non puo' essere uguale alla precedente " 
				end if
			else
				kst_esito.esito = "2"
				kst_esito.SQLErrText = "Password vuota, deve essere contenere almeno 8 caratteri " 
				
			end if
			
		else
			kst_esito.esito = "0"
			kst_esito.SQLErrText = "Nessun controllo sulla Password " 
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_esito.esito = "100"
			kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: Utente " &
	 		                       + kst_tab_sr_utenti.codice + " non Trovato"
		else
			if sqlca.sqlcode < 0 then
				kst_esito.esito = "1"
				kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: Errore grave in lettura ~n~r" + trim(sqlca.SQLErrText)
			else
				kst_esito.esito = "2"
				kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: problemi in lettura, prego riprovare ~n~r" + trim(sqlca.SQLErrText)
			end if
		end if
	end if
	
return kst_esito


end function

public function st_esito check_password_scaduta (ref st_tab_sr_utenti kst_tab_sr_utenti);//
//====================================================================
//=== Controlla se password scaduta o Vuota
//=== secondo il Dlgs 30 giugno 2003 nr. 196 del 23-6-04 
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave DB
//===                                 2=errore > 0 o incongruenza password
//=== 
//====================================================================

string k_codice_up, k_codice_lo
st_esito kst_esito
kuf_cripta kuf1_cripta
int k_ctr, k_gg
boolean k_numero_ok, k_lettera_ok
date k_dataoggi, k_data_scad, k_data_inscadenza
kuf_base kuf1_base



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_codice_up = upper(kst_tab_sr_utenti.codice)
	k_codice_lo = lower(kst_tab_sr_utenti.codice)

	SELECT id, scade_dopo_gg, password, dt_ultima_modifica 
    INTO 
	       :kst_tab_sr_utenti.id
	      ,:kst_tab_sr_utenti.scade_dopo_gg
	      ,:kst_tab_sr_utenti.password
	      ,:kst_tab_sr_utenti.dt_ultima_modifica
    FROM sr_utenti  
	 where codice = :k_codice_up or codice = :k_codice_lo
	 using sqlca;

	if sqlca.sqlcode = 0 then
		
//--- leggo la data-oggi
		kuf1_base = create kuf_base
		k_dataoggi = date(MidA(kuf1_base.prendi_dato_base("dataoggi"),2))
		destroy kuf1_base
		
//--- se password e' scaduta
		if isnull(kst_tab_sr_utenti.dt_ultima_modifica) then
			kst_tab_sr_utenti.dt_ultima_modifica = k_dataoggi
		end if
		if kst_tab_sr_utenti.scade_dopo_gg > 0 then
			k_data_scad = relativedate(kst_tab_sr_utenti.dt_ultima_modifica, kst_tab_sr_utenti.scade_dopo_gg)
			k_data_inscadenza =  relativedate(k_data_scad, -7)
		else
			k_data_scad = k_dataoggi
			k_data_inscadenza = k_data_scad
		end if
		if k_data_scad < k_dataoggi then
			kst_esito.esito = kkg_esito.pwd_scaduta
			kst_esito.SQLErrText = "Modificare la Password scaduta il " + string(k_data_scad) + " "  
		else
			if k_data_inscadenza < k_dataoggi then
				kst_esito.esito = kkg_esito.pwd_inscad
				k_gg = DaysAfter(k_dataoggi, k_data_scad)
				if k_gg > 1 then
					kst_esito.SQLErrText = "Attenzione la Password scade tra  " + string(k_gg) + "  giorni! "  
				else
					kst_esito.SQLErrText = "Attenzione la Password scade tra appena " + string(k_gg) + "  giorno! "  
				end if
			end if
		end if					
		
	else
		
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: Utente " &
	 		                       + kst_tab_sr_utenti.codice + " non Trovato"
		else
			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: Errore grave in lettura ~n~r" + trim(sqlca.SQLErrText)
			else
				kst_esito.esito = kkg_esito.db_wrn
				kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: problemi in lettura, prego riprovare ~n~r" + trim(sqlca.SQLErrText)
			end if
		end if
		
	end if
	
return kst_esito


end function

public function boolean check_password_vuota (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//
//====================================================================
//=== Controlla se Password Vuota 
//===
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   Come da standard
//=== 
//====================================================================
boolean k_return = false
string k_codice_up, k_codice_lo
st_esito kst_esito
//kuf_cripta kuf1_cripta
//int k_ctr
boolean k_numero_ok, k_lettera_ok


	kst_esito.esito =kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_codice_up = upper(kst_tab_sr_utenti.codice)
	k_codice_lo = lower(kst_tab_sr_utenti.codice)

	SELECT id, dlgs196_chk_sintax, password
    INTO 
	 	:kst_tab_sr_utenti.id
	   	,:kst_tab_sr_utenti.dlgs196_chk_sintax
		,:kst_tab_sr_utenti.password
    FROM sr_utenti  
	 where codice = :k_codice_up or codice = :k_codice_lo
	 using sqlca;

	if sqlca.sqlcode = 0 then
		if kst_tab_sr_utenti.dlgs196_chk_sintax = "1" then
			
			kst_tab_sr_utenti.password = trim(kst_tab_sr_utenti.password)
			
			if LenA(kst_tab_sr_utenti.password) = 0 then

				k_return = true
//				kst_esito.esito = kkg_esito.err_logico
//				kst_esito.SQLErrText = "Password vuota, deve essere contenere almeno 8 caratteri " 
				
			end if
			
		else
			kst_esito.SQLErrText = "Nessun controllo sulla Password " 
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: Utente " &
	 		                       + kst_tab_sr_utenti.codice + " non Trovato"
		else
			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: Errore grave in lettura ~n~r" + trim(sqlca.SQLErrText)
			else
				kst_esito.esito = kkg_esito.db_wrn
				kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: problemi in lettura, prego riprovare ~n~r" + trim(sqlca.SQLErrText)
			end if
		end if
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
return k_return


end function

public function st_esito tb_select (ref st_tab_sr_utenti kst_tab_sr_utenti);//====================================================================
//=== Legge tabella sr_utenti
//=== 
//=== Inp: st_tab_sr_utenti.codice
//=== Out: st_tab_sr_utenti
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave DB
//===                                 2=errore > 0
//=== 
//====================================================================
string k_codice_up, k_codice_lo
kuf_base kuf1_base


	st_esito kst_esito, kst_esito1

	kst_esito = kguo_exception.inizializza(this.classname())

	k_codice_up = upper(kst_tab_sr_utenti.codice)
	k_codice_lo = lower(kst_tab_sr_utenti.codice)

	SELECT 
	      sr_utenti.id
	     ,sr_utenti.nome
         ,sr_utenti.stato
         ,coalesce(sr_utenti.autenticazione, "X")
		,sr_utenti.scade_dopo_gg
		,sr_utenti.tentativi_max
		,sr_utenti.tentativi_ko
		,sr_utenti.inutilizzo_gg_disa
		,sr_utenti.inutilizzo_sblocco
		,sr_utenti.dthr_last_access
		,sr_utenti.virtual_user
    INTO 
	      :kst_tab_sr_utenti.id
	     ,:kst_tab_sr_utenti.nome
	     ,:kst_tab_sr_utenti.stato
         ,:kst_tab_sr_utenti.autenticazione
		,:kst_tab_sr_utenti.scade_dopo_gg
		,:kst_tab_sr_utenti.tentativi_max
		,:kst_tab_sr_utenti.tentativi_ko
		,:kst_tab_sr_utenti.inutilizzo_gg_disa
		,:kst_tab_sr_utenti.inutilizzo_sblocco
		,:kst_tab_sr_utenti.dthr_last_access
		,:kst_tab_sr_utenti.virtual_user
    FROM sr_utenti  
	 where codice = :k_codice_up or codice = :k_codice_lo
	 using sqlca;

	if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.SQLErrText = "Utente " + kst_tab_sr_utenti.codice + " non Trovato  (Sicurezza-Utenti)"
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.SQLErrText = "Tab. Sicurezza-Utenti non accessibile:" + trim(sqlca.SQLErrText)
		end if
	end if
	
return kst_esito


end function

public function datetime get_dthr_last_access (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//
//------------------------------------------------------------------
//--- Legge Data Ultimo Accesso OK in Tab.Utente
//--- 
//--- inp: st_tab_sr_utenti.id 
//--- Out: dthr_last_access
//--- 
//------------------------------------------------------------------
//
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())

	if kst_tab_sr_utenti.id > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione  
		kst_esito.SQLErrText = "Errore in lettura della data di ultimo accesso sull'utente. Manca ID utente"
		kGuo_exception.set_esito( kst_esito )
		throw kGuo_exception
	end if

	select dthr_last_access 
		into :kst_tab_sr_utenti.dthr_last_access 
		from sr_utenti  
		where id = :kst_tab_sr_utenti.id
		using kguo_sqlca_db_magazzino;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.SQLErrText = "Errore in lettura della data di ultimo accesso sull'utente " &
										+ string(kst_tab_sr_utenti.dthr_last_access) &
									   + ". " + trim(sqlca.SQLErrText)
	end if

	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return kst_tab_sr_utenti.dthr_last_access

end function

public subroutine set_data_connection (st_tab_sr_utenti ast_tab_sr_utenti) throws uo_exception;/*------------------------------------------------------------------
   Connessiona all'Applicazione aggiorna dati di connessione
      - resetta il contatore di inutilizzo della procedura
 
   inp: st_tab_sr_utenti.id 
------------------------------------------------------------------
*/
st_esito kst_esito
kuf_cripta kuf1_cripta
string k_pwd_server_crypt


try
	kst_esito = kguo_exception.inizializza(this.classname())

	if ast_tab_sr_utenti.id > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione  
		kst_esito.SQLErrText = "Errore in aggiornamento dati di Avvenuta Connessione. Manca ID utente"
		kGuo_exception.set_esito( kst_esito )
		throw kGuo_exception
	end if

//--- decripta la password				
	kuf1_cripta = create kuf_cripta
	k_pwd_server_crypt = kuf1_cripta.of_set(trim(ast_tab_sr_utenti.password))

	ast_tab_sr_utenti.dthr_last_access = kguo_g.get_datetime_current( )
	
	if year(date(kguo_g.get_datetime_current( ))) < year(date(ast_tab_sr_utenti.dthr_last_access)) then
		ast_tab_sr_utenti.count_connections = 0
	else
		get_count_connections(ast_tab_sr_utenti)
		ast_tab_sr_utenti.count_connections ++
	end if

	ast_tab_sr_utenti.work_version = kkg.versione
	ast_tab_sr_utenti.device_last = kguo_g.get_nome_computer()

	update sr_utenti  
			set tentativi_ko = 0  
			, inutilizzo_sblocco = "0"
			, dthr_last_access = :ast_tab_sr_utenti.dthr_last_access 
			, count_connections = :ast_tab_sr_utenti.count_connections
			, work_version = :ast_tab_sr_utenti.work_version
			, device_last = :ast_tab_sr_utenti.device_last
			, pwd_server = :k_pwd_server_crypt
		where id = :ast_tab_sr_utenti.id
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in reset del n.giorni di inutilizzo programma sull'utente " + string(ast_tab_sr_utenti.id))
		if ast_tab_sr_utenti.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		throw kguo_exception 
	end if

	if ast_tab_sr_utenti.st_tab_g_0.esegui_commit = "N" then
	else
		kguo_sqlca_db_magazzino.db_commit( )
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_cripta) then destroy kuf1_cripta 
		
end try



end subroutine

public subroutine set_dthr_last_access (st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//
//------------------------------------------------------------------
//--- Aggiorna Data Ultimo Accesso OK in Tab.Utente
//--- 
//--- inp: st_tab_sr_utenti.id e dthr_last_access
//--- 
//------------------------------------------------------------------
//
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())

	if kst_tab_sr_utenti.id > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione  
		kst_esito.SQLErrText = "Errore in aggiornamento della data di ultimo accesso sull'utente. Manca ID utente"
		kGuo_exception.set_esito( kst_esito )
		throw kGuo_exception
	end if
 
	update sr_utenti  
			set dthr_last_access = :kst_tab_sr_utenti.dthr_last_access 
		where id = :kst_tab_sr_utenti.id
		using kguo_sqlca_db_magazzino;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.SQLErrText = "Errore in aggiornamento della data di ultimo accesso sull'utente " &
										+ string(kst_tab_sr_utenti.dthr_last_access) &
									   + ". " + trim(sqlca.SQLErrText)
		kGuo_exception.set_esito( kst_esito )
		throw kGuo_exception
	end if

	if kst_tab_sr_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sr_utenti.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
catch (uo_exception kuo_exception)
	if kst_tab_sr_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sr_utenti.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
end try



end subroutine

public subroutine reset_inutilizzo_sblocco (st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//
//------------------------------------------------------------------
//--- Resetta il contatore di inutilizzo della procedura
//--- 
//--- inp: st_tab_sr_utenti.id 
//--- 
//------------------------------------------------------------------
//
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())

	if kst_tab_sr_utenti.id > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione  
		kst_esito.SQLErrText = "Errore in reset del n.giorni di inutilizzo programma sull'utente. Manca ID utente"
		kGuo_exception.set_esito( kst_esito )
		throw kGuo_exception
	end if

	update sr_utenti  
			set inutilizzo_sblocco = "0"
		where id = :kst_tab_sr_utenti.id
		using kguo_sqlca_db_magazzino;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.SQLErrText = "Errore in reset del n.giorni di inutilizzo programma sull'utente " &
										+ string(kst_tab_sr_utenti.id) &
									   + ". " + trim(sqlca.SQLErrText)
		kGuo_exception.set_esito( kst_esito )
		throw kGuo_exception
	end if

	if kst_tab_sr_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sr_utenti.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
catch (uo_exception kuo_exception)
	if kst_tab_sr_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sr_utenti.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
end try



end subroutine

public function integer get_count_connections (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//
//------------------------------------------------------------------
//--- Legge Contatore di accessi in Tab.Utente
//--- 
//--- inp: st_tab_sr_utenti.id 
//--- Out: dt_ultimo_accesso
//--- 
//------------------------------------------------------------------
//
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())

	if kst_tab_sr_utenti.id > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione  
		kst_esito.SQLErrText = "Errore in lettura del contatore accessi sull'utente. Manca ID utente"
		kGuo_exception.set_esito( kst_esito )
		throw kGuo_exception
	end if

	select coalesce(count_connections, 0)
		into :kst_tab_sr_utenti.count_connections 
		from sr_utenti  
		where id = :kst_tab_sr_utenti.id
		using kguo_sqlca_db_magazzino;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.SQLErrText = "Errore in lettura del contatore accessi sull'utente " &
										+ string(kst_tab_sr_utenti.id) &
									   + ". " + trim(sqlca.SQLErrText)
	end if

	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return kst_tab_sr_utenti.count_connections

end function

public subroutine set_work_version (st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//
//------------------------------------------------------------------
//--- Aggiorna la versione con cui lavora l'utente
//--- 
//--- inp: st_tab_sr_utenti.id e work_version
//--- 
//------------------------------------------------------------------
//
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())

	if kst_tab_sr_utenti.id > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione  
		kst_esito.SQLErrText = "Errore in aggiornamento della versione di lavoro dell'utente. Manca ID utente"
		kGuo_exception.set_esito( kst_esito )
		throw kGuo_exception
	end if

	update sr_utenti  
			set work_version = :kst_tab_sr_utenti.work_version
		where id = :kst_tab_sr_utenti.id
		using kguo_sqlca_db_magazzino;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.SQLErrText = "Errore in aggiornamento della versione di lavoro sull'utente " &
										+ string(kst_tab_sr_utenti.id) &
									   + ". " + trim(sqlca.SQLErrText)
		kGuo_exception.set_esito( kst_esito )
		throw kGuo_exception
	end if

	if kst_tab_sr_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sr_utenti.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
catch (uo_exception kuo_exception)
	if kst_tab_sr_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sr_utenti.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
end try

end subroutine

public function boolean u_if_master (string k_pwd);//
boolean k_return
uo_crypter kuo_Crypter

kuo_Crypter = Create uo_crypter

k_return = kuo_crypter.u_if_app_user_is_master(k_pwd)

destroy kuo_crypter

return k_return


end function

public function string get_pwd_server_decrypted (ref st_tab_sr_utenti ast_tab_sr_utenti) throws uo_exception;/*
 Legge la Password del Server salvata e decriptata
   inp: st_tab_sr_utenti.id 
   Out: password del server 
   Rit: password del server decrypt
*/
string k_return
st_esito kst_esito
kuf_cripta kuf1_cripta


try
	kst_esito = kguo_exception.inizializza(this.classname())

	if ast_tab_sr_utenti.id > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione  
		kst_esito.SQLErrText = "Errore in lettura dati di autenticazione utente. Manca ID utente"
		kGuo_exception.set_esito( kst_esito )
		throw kGuo_exception
	end if

	select coalesce(trim(pwd_server), '')
		into :ast_tab_sr_utenti.pwd_server 
		from sr_utenti  
		where id = :ast_tab_sr_utenti.id
		using kguo_sqlca_db_magazzino;

	if sqlca.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
					"Errore in Lettura dati di autenticazione utente, codice=" + string(ast_tab_sr_utenti.id))
		throw kguo_exception
	end if

	if ast_tab_sr_utenti.pwd_server > " " then
//--- decripta la password				
		kuf1_cripta = create kuf_cripta
		k_return = kuf1_cripta.of_decrypt(trim(ast_tab_sr_utenti.pwd_server))
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_cripta) then destroy kuf1_cripta

end try

return k_return

end function

public function st_esito check_password_digit_errata (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//====================================================================
//=== Password ERRATA 
//=== 
//=== fa le cose da fare compreso il lancio del messaggio
//=== 
//====================================================================
string k_pwd_last_ok
st_esito kst_esito, kst_esito1


	kst_esito = kguo_exception.inizializza(this.classname())
			
	kst_esito.esito = kkg_esito.no_aut
	if trim(kst_tab_sr_utenti.password) = "" then
		kst_esito.SQLErrText = "Digitare la Password  " 
	else
		
		k_pwd_last_ok = get_pwd_server_decrypted(kst_tab_sr_utenti) // get dell'ultima pwd corretta
		if trim(k_pwd_last_ok) > " " and trim(kst_tab_sr_utenti.password) = trim(k_pwd_last_ok) then // se erano uguali allora è probabile che sia SCADUTA SUL SERVER
			kst_esito.SQLErrText = "Attenzione la password potrebbe essere scaduta o è stata modificata sul Server, prego verificare prima di riprovare. " &
									+ "Tentativo " + string(kst_tab_sr_utenti.tentativi_ko) + "."
		else
			
			add_password_tentativi(kst_tab_sr_utenti)
		
			kst_esito.SQLErrText = "Digitata password errata. "  
			kst_esito.SQLErrText += "Tentativo " + string(kst_tab_sr_utenti.tentativi_ko) &
											 + " di " + string(kst_tab_sr_utenti.tentativi_max) + ". "  
		end if
	end if
	
return kst_esito

end function

public subroutine add_password_tentativi (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//
			
	kst_tab_sr_utenti.tentativi_ko ++
	tb_update_password_tentativi(kst_tab_sr_utenti)
	

end subroutine

public subroutine tb_update_password_tentativi (st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;/*
   Aggiorna contatore password
*/


	kguo_exception.inizializza(this.classname())

//	kst_tab_sr_utenti.x_datins = kGuf_data_base.prendi_x_datins()
//	kst_tab_sr_utenti.x_utente = kGuf_data_base.prendi_x_utente()
	
	update sr_utenti  
			set tentativi_ko = :kst_tab_sr_utenti.tentativi_ko  
		where id = :kst_tab_sr_utenti.id
		using sqlca;

	if sqlca.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
							"Errore in Aggiornamento Tentativi digitazione password, utente id " + string(kst_tab_sr_utenti.id))
		throw kguo_exception		
	end if

	kguo_sqlca_db_magazzino.db_commit( )


end subroutine

on kuf_sr_utenti.create
call super::create
end on

on kuf_sr_utenti.destroy
call super::destroy
end on

