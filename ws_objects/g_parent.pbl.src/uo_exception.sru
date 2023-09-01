$PBExportHeader$uo_exception.sru
forward
global type uo_exception from exception
end type
end forward

global type uo_exception from exception
end type
global uo_exception uo_exception

type variables
//
//--- struttura per errori
private st_uo_exception ki_st_uo_exception
public st_esito kist_esito

//private kuf_file_explorer kiuf_file_explorer

private string ki_titolo = "" // titolo del messaggio 

// valori possibili per TIPO di st_exception: Possibilmente uguali a quelli KKG_ESITO
constant string KK_st_uo_exception_tipo_OK=kkg_esito.ok
constant string KK_st_uo_exception_tipo_db_ko=kkg_esito.db_ko
constant string KK_st_uo_exception_tipo_dati_utente="UT"
constant string KK_st_uo_exception_tipo_allerta="AL"
constant string KK_st_uo_exception_tipo_non_eseguito=kkg_esito.NO_ESECUZIONE
constant string KK_st_uo_exception_tipo_internal_bug=kkg_esito.bug
constant string KK_st_uo_exception_tipo_interr_da_utente="UC"
constant string KK_st_uo_exception_tipo_dati_insufficienti="DI"
constant string KK_st_uo_exception_tipo_dati_insufficienti1 = kkg_esito.DATI_INSUFF 
constant string KK_st_uo_exception_tipo_dati_anomali="AN"
constant string KK_st_uo_exception_tipo_dati_wrn=kkg_esito.DATI_WRN
constant string KK_st_uo_exception_tipo_db_wrn=kkg_esito.DB_WRN
constant string KK_st_uo_exception_tipo_generico="XX"
constant string KK_st_uo_exception_tipo_ko=kkg_esito.KO 
constant string KK_st_uo_exception_tipo_noAUT=kkg_esito.NO_AUT
constant string KK_st_uo_exception_tipo_not_fnd=kkg_esito.NOT_FND
constant string KK_st_uo_exception_tipo_trace=kkg_esito.TRACE
constant string KK_st_uo_exception_tipo_SINO="N"
constant string KK_st_uo_exception_tipo_LOGIN=kkg_esito.LOGIN //Info di Entrata/Uscita Applicazione 
 
//uo_path kiuo_path
end variables

forward prototypes
public subroutine messaggio_utente ()
public function st_esito get_st_esito ()
public function string get_tipo ()
public subroutine set_nome_oggetto (string k_nome_oggetto)
public subroutine setmessage (string newmessage)
public function string getmessage ()
public subroutine scrivi_log ()
public subroutine inizializza ()
public subroutine set_esito (st_esito ast_esito)
public subroutine set_tipo (string a_tipo)
public function string get_errtext ()
public function string get_esito_descrizione (st_esito ast_esito)
public subroutine setmessage (string a_titolo, string newmessage)
public function st_esito inizializza (string a_classname)
public subroutine if_isnull (ref st_esito kst_esito)
public function boolean if_esito_grave (string k_esito)
public function string u_add_esito_and_nwline (string a_esito)
public function boolean if_esito_ok_wrn (string k_esito)
private subroutine set_esito_reset (string a_classname)
private function string u_write_error ()
public function string u_errori_gestione (st_esito ast_esito)
public subroutine scrivi_log (st_esito kst_esito)
private function string u_write_error_touser ()
private function string u_write_error_xml ()
private subroutine u_set_ki_from_st_esito (st_esito ast_esito)
public function string get_errtext (ref uo_d_std_1 adw_1)
private subroutine u_set_uo_path ()
public function integer messaggio_utente (string a_titolo, string a_msg)
public function st_esito set_st_esito_err_db (transaction asqlca, string a_sqlerrtext_add_init)
end prototypes

public subroutine messaggio_utente ();//---
//--- Espone messaggio di errore all'utente
//---
string k_msg, k_titolo
st_esito kst_esito


ki_st_uo_exception.tipo = get_tipo() 


if trim(getmessage()) > " " then
else
	kst_esito = get_st_esito() 
	if trim(kst_esito.sqlerrtext) > " " then
	else
		kst_esito.sqlerrtext = "Programma in anomalia."
	end if
	if kst_esito.sqlcode <> 0 then
		kst_esito.sqlerrtext = trim(kst_esito.sqlerrtext) + " ~r~nCodice: " + string(kst_esito.sqlcode)
	end if
	if trim(kst_esito.nome_oggetto) > " " then
		kst_esito.sqlerrtext = trim(kst_esito.sqlerrtext) + " ~r~nOggetto:  " + trim(kst_esito.nome_oggetto)
	end if
	setmessage(trim(kst_esito.sqlerrtext))
end if

//--- imposta il TITOLO
if ki_titolo > " " then
	k_titolo = ki_titolo
else
	choose case ki_st_uo_exception.tipo
		case KK_st_uo_exception_tipo_generico 
			k_titolo = "Operazione non eseguita"
		case KK_st_uo_exception_tipo_non_eseguito
			k_titolo = "Operazione non eseguita"
		case KK_st_uo_exception_tipo_dati_anomali, KK_st_uo_exception_tipo_dati_wrn
			k_titolo = "Dati Anomali"
		case KK_st_uo_exception_tipo_dati_utente &
			, KK_st_uo_exception_tipo_noAUT
			k_titolo = "Utente non Autorizzato"
		case KK_st_uo_exception_tipo_db_ko
			k_titolo = "Operazione su DB Fallita"
		case KK_st_uo_exception_tipo_ko
			k_titolo = "Esecuzione Fallita"
		case KK_st_uo_exception_tipo_not_fnd
			k_titolo = "Dati non Trovati"
		case KK_st_uo_exception_tipo_internal_bug
			k_titolo = "Errore Interno al Programma"
		case KK_st_uo_exception_tipo_allerta
			k_titolo = "Messaggio di ALLERTA"
		case KK_st_uo_exception_tipo_dati_insufficienti, KK_st_uo_exception_tipo_dati_insufficienti1
			k_titolo = "Dati Insufficienti"
		case KK_st_uo_exception_tipo_OK
			k_titolo = "Operazione Corretta"
		case else
			k_titolo = "Operazione Interrotta"
	end choose
end if
//~n~r~n~r
//--- Espone il msg all'utente
choose case ki_st_uo_exception.tipo
	case KK_st_uo_exception_tipo_generico
		messaggio_utente (k_titolo,  getmessage())
	case KK_st_uo_exception_tipo_non_eseguito
		messaggio_utente (k_titolo,  getmessage())
	case KK_st_uo_exception_tipo_dati_anomali, KK_st_uo_exception_tipo_dati_wrn
		messaggio_utente (k_titolo, getmessage())
	case KK_st_uo_exception_tipo_dati_utente , KK_st_uo_exception_tipo_noAUT
		messaggio_utente (k_titolo, getmessage())
	case KK_st_uo_exception_tipo_db_ko
		messaggio_utente (k_titolo, getmessage())
	case KK_st_uo_exception_tipo_ko
		messaggio_utente (k_titolo, getmessage())
	case KK_st_uo_exception_tipo_not_fnd
		messaggio_utente (k_titolo, getmessage())
	case KK_st_uo_exception_tipo_internal_bug
		messaggio_utente (k_titolo, getmessage())
	case KK_st_uo_exception_tipo_allerta
		messaggio_utente (k_titolo, getmessage())
	case KK_st_uo_exception_tipo_dati_insufficienti, KK_st_uo_exception_tipo_dati_insufficienti1
		messaggio_utente (k_titolo, getmessage())
	case KK_st_uo_exception_tipo_OK
		messaggio_utente (k_titolo,  trim(getmessage()))
	case else
		k_msg = getmessage()
		if LenA(trim(k_msg)) > 0 then 
			messaggio_utente (k_titolo,k_msg)
		else
			messaggio_utente (k_titolo, "Esecuzione anomala la funzione sara' terminata")
		end if
end choose

end subroutine

public function st_esito get_st_esito ();//
//---
//--- Ritorna il tipo di errore
//---
if isnull(kist_esito.esito) then kist_esito.esito = KK_st_uo_exception_tipo_generico

//if isnull(kist_esito.scrivi_log) then kist_esito.scrivi_log = FALSE
	
//if kist_esito.esito = kkg_esito.db_ko &
//		or	kist_esito.esito = kkg_esito.DATI_INSUFF   &
//		or	kist_esito.esito = kkg_esito.NO_ESECUZIONE   &
//		or	kist_esito.esito = kkg_esito.bug   &
//		or	kist_esito.esito = kkg_esito.ERR_LOGICO   &
//		or	kist_esito.esito = kkg_esito.KO   &
//		or	kist_esito.esito = kkg_esito.NO_AUT   &
//		or	kist_esito.esito = kkg_esito.TRACE   then
//if if_esito_grave(kist_esito.esito) then
//	
//	kist_esito.scrivi_log = TRUE
//
//end if

return kist_esito 

end function

public function string get_tipo ();//
//---
//--- Ritorna il tipo di errore
//---
if trim(ki_st_uo_exception.tipo) > " " then
else
	ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_generico
end if
return trim(ki_st_uo_exception.tipo)

end function

public subroutine set_nome_oggetto (string k_nome_oggetto);//
//---
//--- imposta il nome dell'oggetto in cui si è verificato l'errore
//---
if isnull(k_nome_oggetto) then  kist_esito.nome_oggetto = "*non indicato*"
kist_esito.nome_oggetto = k_nome_oggetto

end subroutine

public subroutine setmessage (string newmessage);//
kist_esito.sqlerrtext = trim(newmessage)

if trim(kist_esito.esito) > " " then
else
	kist_esito.esito = this.kk_st_uo_exception_tipo_dati_wrn
end if

u_write_error()
//scrivi_log( )

	

end subroutine

public function string getmessage ();//
	return trim(kist_esito.sqlerrtext)
	

end function

public subroutine scrivi_log ();//
//---
//--- Scrive ESITO nel LOG
//---


	kist_esito.scrivi_log = true

	u_set_ki_from_st_esito(kist_esito)

	u_write_error()



end subroutine

public subroutine inizializza ();//---
//--- ATTENZIONE MEGLIO UTILIZZARE inizializza(this.classname)
//---
inizializza("")


end subroutine

public subroutine set_esito (st_esito ast_esito);//
//---
//--- imposta il tipo di errore nella struttura ESITO
//---
//--- ESEMPIO:
//---			kst_esito = kGuo_exception.inizializza(this.classname())
//---			kst_esito_err.esito = kkg_esito.DB_KO
//---			kst_esito_err.sqlcode = sqlca.sqlcode
//---			kst_esito_err.sqlerrtext = trim(sqlca.sqlerrtext)
//---			kGuo_exception.u_write_error(kst_esito_err) 
st_esito kst_esito

if ast_esito.esito > " " then 
else
	ast_esito.esito = KK_st_uo_exception_tipo_generico
end if

//--- prima lo piazza uguale poi decide puntuale
ki_st_uo_exception.tipo = ast_esito.esito
if ast_esito.esito = kkg_esito.ok then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_OK 
if ast_esito.esito = kkg_esito.DB_KO then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_db_ko 
if ast_esito.esito = kkg_esito.KO then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_ko
if ast_esito.esito = kkg_esito.NOT_FND then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_not_fnd 
if ast_esito.esito = kkg_esito.NO_AUT then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_dati_utente 
if ast_esito.esito = kkg_esito.DB_WRN then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_allerta 
if ast_esito.esito = kkg_esito.BUG then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_internal_bug 
if ast_esito.esito = kkg_esito.NO_ESECUZIONE then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_interr_da_utente 
if ast_esito.esito = kkg_esito.ERR_FORMALE then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_dati_insufficienti 
if ast_esito.esito = kkg_esito.DATI_INSUFF then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_dati_insufficienti 
if ast_esito.esito = kkg_esito.ERR_LOGICO then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_dati_anomali 
if ast_esito.esito = kkg_esito.DATI_WRN then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_dati_wrn 
if ast_esito.esito = kkg_esito.TRACE then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_TRACE 

if isnull(ast_esito.scrivi_log) then ast_esito.scrivi_log = false

//--- recupera descrizione
if ast_esito.descrizione > " " then
else
	kst_esito.esito = ki_st_uo_exception.tipo  //imposta tipo standard
	ast_esito.descrizione = get_esito_descrizione(kst_esito)
end if

//--- ultimi ritocchi alla sqlerrtext
if ast_esito.sqlerrtext > " " then
	ast_esito.sqlerrtext = trim(ast_esito.sqlerrtext) 
else
	if isnull(this.getmessage( )) then
	else
		ast_esito.sqlerrtext = trim(ast_esito.sqlerrtext) + " - " + trim(this.getmessage( ))
	end if
end if

//--- scrive LOG	
kist_esito = ast_esito
u_write_error( )
		


end subroutine

public subroutine set_tipo (string a_tipo);//
//---
//--- imposta il tipo di errore
//---
if isnull(a_tipo) then a_tipo = KK_st_uo_exception_tipo_generico
ki_st_uo_exception.tipo = a_tipo

if len(trim(kist_esito.esito)) = 0 or isnull(kist_esito.esito) then 
	kist_esito.esito = a_tipo

	choose case a_tipo

		case  KK_st_uo_exception_tipo_OK
			kist_esito.esito = kkg_esito.ok

		case  KK_st_uo_exception_tipo_db_ko
			kist_esito.esito = kkg_esito.db_ko
			
		case  KK_st_uo_exception_tipo_dati_utente
			kist_esito.esito = kkg_esito.DATI_INSUFF
			
		case  KK_st_uo_exception_tipo_allerta
			kist_esito.esito = kkg_esito.DATI_WRN
			
		case  KK_st_uo_exception_tipo_non_eseguito
			kist_esito.esito = kkg_esito.NO_ESECUZIONE
			
		case  KK_st_uo_exception_tipo_internal_bug
			kist_esito.esito = kkg_esito.bug
			
		case  KK_st_uo_exception_tipo_interr_da_utente
			kist_esito.esito = kkg_esito.KO
			
		case  KK_st_uo_exception_tipo_dati_insufficienti
			kist_esito.esito = kkg_esito.DATI_INSUFF
			
//		case  KK_st_uo_exception_tipo_dati_insufficienti1
//			kist_esito.esito = kkg_esito.DATI_INSUFF
			
		case  KK_st_uo_exception_tipo_dati_anomali
			kist_esito.esito = kkg_esito.ERR_LOGICO
			
		case  KK_st_uo_exception_tipo_dati_wrn
			kist_esito.esito = kkg_esito.DATI_WRN
			
		case  KK_st_uo_exception_tipo_generico
			kist_esito.esito = kkg_esito.KO
			
		case  KK_st_uo_exception_tipo_ko
			kist_esito.esito = kkg_esito.KO
			
		case  KK_st_uo_exception_tipo_noAUT
			kist_esito.esito = kkg_esito.NO_AUT
			
		case  KK_st_uo_exception_tipo_not_fnd
			kist_esito.esito = kkg_esito.NOT_FND
	
		case else
			kist_esito.esito = kkg_esito.bug

	end choose
	
end if

end subroutine

public function string get_errtext ();//
string k_return=""
		
		
		if kist_esito.sqlerrtext > " " then
			k_return = trim(kist_esito.sqlerrtext)
		else
			k_return = "Errore generico"
		end if

return k_return

end function

public function string get_esito_descrizione (st_esito ast_esito);
//
string k_return=""
		
		
		if isnull(ast_esito.esito) then ast_esito.esito = "?"
		
		choose case  ast_esito.esito
				
			case KK_st_uo_exception_tipo_generico
				k_return = " - Errore generico "
				
			case KK_st_uo_exception_tipo_dati_anomali
				k_return = " - Dati Anomali "
				
			case KK_st_uo_exception_tipo_dati_utente
				k_return = " - Utente non Autorizzato "
				
			case KK_st_uo_exception_tipo_db_ko
				k_return = " - Fallita Operazione su DB  "
				
			case KK_st_uo_exception_tipo_ko
				k_return = " - Errore durante l'esecuzione  "
				
			case KK_st_uo_exception_tipo_not_fnd
				k_return = " - Dati non Trovati "
				
			case KK_st_uo_exception_tipo_internal_bug
				k_return = " - Errore Interno di programmazione "
				
			case KK_st_uo_exception_tipo_allerta
				k_return = " - Allerta, attenzione ai dati "
				
			case KK_st_uo_exception_tipo_dati_insufficienti &
					,KK_st_uo_exception_tipo_dati_insufficienti1
				k_return = " - Dati insufficienti "
				
			case KK_st_uo_exception_tipo_OK
				k_return = " - Operazione Corretta "
				
			case KK_st_uo_exception_tipo_interr_da_utente
				k_return = " - Operazione interrotta da utente"

			case KK_st_uo_exception_tipo_non_eseguito
				k_return = " - Operazione interrotta dal programma. Dati errati o mancanti, impossibile proseguire."
				
			case KK_st_uo_exception_tipo_noAUT
				k_return = " - Accesso non autorizzato "
				
			case KK_st_uo_exception_tipo_LOGIN
				k_return = " - Login "
				
			case KK_st_uo_exception_tipo_TRACE
				k_return = " - Trace "
				
			case KK_st_uo_exception_tipo_dati_wrn &
					,KK_st_uo_exception_tipo_db_wrn
				k_return = " - Errore dati non bloccante "
				
				
			case else
				k_return = " - *** da codificare *** = " + trim(ast_esito.esito)
				
		end choose


return k_return

end function

public subroutine setmessage (string a_titolo, string newmessage);//
ki_titolo = trim(a_titolo)
setmessage(newmessage)
//kist_esito.sqlerrtext = trim(newmessage)


end subroutine

public function st_esito inizializza (string a_classname);//---
//---
//---
ki_titolo = ""
ki_st_uo_exception.tipo = ""
set_esito_reset(a_classname)

return kist_esito
end function

public subroutine if_isnull (ref st_esito kst_esito);//
if isnull(kst_esito.esito) then kst_esito.esito = ""
if isnull(kst_esito.nome_oggetto) then kst_esito.nome_oggetto = ""
if isnull(kst_esito.SQLcode) then kst_esito.SQLcode = 0
if isnull(kst_esito.SQLdbcode) then kst_esito.SQLdbcode = 0
if isnull(kst_esito.SQLErrText) then kst_esito.SQLErrText = ""
if isnull(kst_esito.SQLsyntax) then kst_esito.SQLsyntax = ""

end subroutine

public function boolean if_esito_grave (string k_esito);//
if k_esito > " " and k_esito <> kkg_esito.ok and k_esito <> kkg_esito.db_wrn &
			and k_esito <> kkg_esito.dati_wrn and k_esito <> kkg_esito.not_fnd then
		// and k_esito <> kkg_esito.dati_insuff &
	return true
else
	return false	
end if
end function

public function string u_add_esito_and_nwline (string a_esito);//
//--- carica nel campo ESITO il testo aggiungendo il newline se necessario 
//--- inp: text dell'esito
//--- out: text dell'intero esito compreso i precedenti con il newline
//
if trim(kist_esito.SQLErrText) > " " then 
	kist_esito.SQLErrText += "~n~r" + trim(a_esito)
else
	kist_esito.SQLErrText = trim(a_esito)
end if

return kist_esito.SQLErrText
end function

public function boolean if_esito_ok_wrn (string k_esito);//
if k_esito = kkg_esito.ok or k_esito = kkg_esito.DB_WRN or k_esito = kkg_esito.DATI_WRN &
			 then
	return true
else
	return false	
end if
end function

private subroutine set_esito_reset (string a_classname);//---
//--- Pulisce il campo ESITO dell'oggetto
//---
//---
st_esito kst_esito_null

kist_esito = kst_esito_null
kist_esito.esito = KK_st_uo_exception_tipo_OK
kist_esito.sqlcode = 0
kist_esito.SQLErrText = ""
kist_esito.nome_oggetto = a_classname
kist_esito.scrivi_log = false

end subroutine

private function string u_write_error ();//-------------------------------------------------------------------------------------------------
//---
//--- Scrive su File di LOG
//---
//--- Input: 
//---
//--- Ritorna: 	W se operazioni OK
//---         		1 nessuna operazione riuscita 
//---
//-------------------------------------------------------------------------------------------------
//---			
string k_return = "1"
string k_ret1= "W", k_ret2="W"


if	kguo_g.kG_exit_si then return '1'   // Se uscita da tutta APP allora non faccio più nulla


setpointer(kkg.pointer_attesa)

if (if_esito_grave(kist_esito.esito) and kist_esito.esito <> KK_st_uo_exception_tipo_dati_insufficienti1 and kist_esito.esito <> KK_st_uo_exception_tipo_dati_insufficienti) &
					or kist_esito.scrivi_log or kist_esito.esito = KK_st_uo_exception_tipo_LOGIN then
	k_ret1 = u_write_error_xml()
end if

k_ret2 = u_write_error_touser()

if k_ret1 = "W" and k_ret2 = "W" then k_return = "W"

kist_esito.scrivi_log = false

setpointer(kkg.pointer_default)

return k_return



end function

public function string u_errori_gestione (st_esito ast_esito);//
//---- gestione centralizzata degli errori della procedura
//

u_set_ki_from_st_esito(ast_esito)

u_write_error() 

CHOOSE CASE kist_esito.SQLdbcode

//	CASE -01,-02 
//		MessageBox("Problemi sul DataBase",  &
//			"Collegamento con il DataBase fallito.~n~r" &
//			+ "Prego, provare a riconnettersi")


//informix	case -1811, -349, -1803, -25580 //--- manca connessione 
	case 	-4060, -40197, -40501, -40613, -49918, -49919, -49920, -4221, 10054, 64 //, 121 timeout
		try 
			kist_esito.sqlerrtext = "Tentativo di Ri-connessione al database di Magazzino... " 
			u_write_error()
			//errori_scrivi_esito("W", kst_esito) 
//--- tentativo di connessione al db.....
			if not kguo_sqlca_db_magazzino.db_riconnetti( ) then
				messaggio_utente("Programma non operativo", "Persa la Connessione al database di Magazzino, il programma verrà chiuso.")
				halt close
			else
				kist_esito.esito = kkg_esito.ok
				kist_esito.sqlcode = 0
				kist_esito.sqlerrtext = "Ri-connessione al database di Magazzino conclusa con successo. " 
				u_write_error()
			end if
		catch (uo_exception kuo_exception)
			messaggio_utente("Programma non operativo", "Persa la Connessione al database di Magazzino, prego chiudere e riavviare il programma")
		finally

		end try
		
	case 	12170 // timeout ORACLE
		try 
			kist_esito.sqlerrtext = "Tentativo di Ri-connessione al DB di E1... " 
			u_write_error()
			//errori_scrivi_esito("W", kst_esito) 
//--- tentativo di connessione al db.....
			if not kguo_sqlca_db_e1.db_riconnetti( ) then
				messaggio_utente("Connessione E1", "Persa la Connessione dati al DB di E1, il programma continua senza connessione.")
			else
				kist_esito.esito = kkg_esito.ok
				kist_esito.sqlcode = 0
				kist_esito.sqlerrtext = "Ri-connessione al DB di E1 conclusa con successo. " 
				u_write_error()
			end if
		catch (uo_exception kuo1_exception)
			messaggio_utente("Connessione E1", "Persa la Connessione al DB di E1, tentativo di riconnessione fallito (" + trim(kuo1_exception.getmessage())+").")
		finally
		end try
		
	CASE 121  // errore strano interno
		messaggio_utente("Connessione di rete Interrotta",  &
			"Riconnettersi alla rete e riaprire questa funzione. Altrimenti chiudere il programma.~n~r" &
			+ " Oggetto: " + trim(kist_esito.nome_oggetto)   &
			+ " dbcode: " + string(kist_esito.sqldbcode)  &
			+ " sqlcode: " + string(kist_esito.sqlcode) &
			+ " syntax: " + trim(kist_esito.SQLErrText) + " -> " + trim(kist_esito.sqlsyntax))   
		
	CASE -04  // errore strano interno
		kist_esito.esito = kkg_esito.no_esecuzione
		kist_esito.sqlcode = 0
		kist_esito.sqlerrtext = "Anomalia generica. " &
			+ "Non è possibile proseguire correttamente l'operazione!!~n~r" + trim(kist_esito.SQLErrText)  &
			+ " Oggetto: " + trim(kist_esito.nome_oggetto)   &
			+ " dbcode: " + string(kist_esito.sqldbcode)  &
			+ " sqlcode: " + string(kist_esito.sqlcode) &
			+ " syntax: " + trim(kist_esito.sqlsyntax)
		u_write_error()

	CASE 18456  // LOGIN ERRATO 
		kist_esito.esito = kkg_esito.no_esecuzione
		kist_esito.sqlcode = 0
		kist_esito.sqlerrtext = "Login fallito, utente o password errata." 
		u_write_error()

	case 999
		kist_esito.sqlerrtext = "Errore non riconosciuto. " + kkg.acapo + kist_esito.sqlerrtext
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kist_esito.SQLdbcode = kist_esito.SQLcode then
				kist_esito.SQLcode = kguo_sqlca_db_magazzino.sqlcode
			end if
		end if
		u_write_error()
		messaggio_utente("Programma non operativo", "Errore in comunicazione con il database di Magazzino, il programma verrà chiuso.")
		halt close
	
	case else
		if sqlca.sqlcode >= 0 and kist_esito.SQLdbcode > 0 then
			// niente di grave forse solo un tentativo di connessione fallito
			u_write_error()
		else
			messaggio_utente("Codice programma errato",  &
				"Probabile errore interno di programmazione. " &
				+ "Non è possibile proseguire correttamente l'operazione!!~n~r" + trim(kist_esito.SQLErrText)  &
				+ "- Oggetto: " + trim(kist_esito.nome_oggetto)   &
				+ " dbcode: " + string(kist_esito.sqldbcode)  &
				+ " sqlcode: " + string(kist_esito.sqlcode) &
				+ " syntax: " + trim(kist_esito.sqlsyntax))
	end if

END CHOOSE

return "0"

end function

public subroutine scrivi_log (st_esito kst_esito);//
//---
//--- Scrive ESITO nel LOG
//---

	
	kist_esito = kst_esito
	scrivi_log( )

end subroutine

private function string u_write_error_touser ();//-------------------------------------------------------------------------------------------------
//---
//--- Scrive su File di LOG per Utente in formato testo
//---
//--- Input: 
//---   st_esito	con le indicazioni dell'errore
//---
//--- Ritorna: 	W se operazioni rispettive o OK
//---         		1 nessuna operazione riuscita 
//---
//--- ESEMPIO:
//---			kist_esito = kGuo_exception.inizializza(this.classname())
//---			kist_esito_err.esito = kkg_esito.DB_KO
//---			kist_esito_err.sqlcode = sqlca.sqlcode
//---			kist_esito_err.sqlerrtext = trim(sqlca.sqlerrtext)
//---			kGuo_exception.u_write_error(kist_esito_err) 
//---			
//-------------------------------------------------------------------------------------------------
//---			
int k_file 
int k_bytes, k_ctr, k_ctr_1, k_bytes_f, k_righe
string k_record, k_return = "1", k_errore
string k_path_nome_file
longlong k_filesize

	u_set_uo_path()
	k_path_nome_file = kguo_path.get_nome_file_errori_txt()
	if left(trim(k_path_nome_file), 1) = kkg.path_sep then
		k_path_nome_file = kGuf_data_base.profilestring_leggi_scrivi (1, "temp", " ") + trim(k_path_nome_file)
		if left(trim(k_path_nome_file), 1) = kkg.path_sep then
			k_path_nome_file = "c:" + trim(k_path_nome_file)
		end if
	end if

	if kist_esito.sqlcode = 0 then
		k_errore = trim(kist_esito.SQLErrText) + " - oggetto: " + trim(kist_esito.nome_oggetto)
	else
		k_errore = "Esito cod. (sqlcode)= " + string(kist_esito.sqlcode) + " - " + trim(kist_esito.SQLErrText) + " - oggetto: " + trim(kist_esito.nome_oggetto)
	end if	
//--- Se file troppo grosso lo Salvo e AZZERO il FILE
	k_filesize = FileLength64(k_path_nome_file) //kiuf_file_explorer.u_get_filesize(k_path_nome_file)
	if k_filesize > 160000 or k_filesize = 0 then
		k_file = fileopen( trim(k_path_nome_file), linemode!, write!, lockreadwrite!, Replace!)
		if k_file > 0 then
			if LenA(trim(k_return)) = 0 then
				k_return = " "
			end if
			k_bytes = filewriteEx(k_file, "File LOG creato il: " + string(today()) +"  ore: " +  string(now()) ) //La prima riga!!!
			fileClose(k_file)
		end if
	end if

//--- Scrive record di LOG 
	k_file = fileopen( trim(k_path_nome_file), linemode!, write!, lockreadwrite!, Append!)
	if k_file > 0 then
		
		k_bytes = filewriteEx(k_file, " ") //Una riga vuota
		
		k_record = "Messaggio del " + string(today(),"dd/mm/yyyy") + " ore " + String(Now( ), "hh:mm:ss") + " - Versione Programma " + string(KKG.VERSIONE) + " - Nome device di rete: " + kguo_g.get_nome_computer()
		k_bytes = filewriteEx(k_file, k_record) //scrivo la data dell'errore
		if kist_esito.esito <> kkg_esito.ok then
			k_bytes = filewriteEx(k_file, "Codice Esito (st_esito.esito) = " +  trim(kist_esito.esito)) //scrivo l'errore
		end if
		k_bytes = filewriteEx(k_file, k_errore) //scrivo l'errore
		if trim(kist_esito.descrizione) > " " then
			k_bytes = filewriteEx(k_file, "Descr.: " +  trim(kist_esito.descrizione)) //scrivo l'errore
		end if
		k_bytes = filewriteEx(k_file, " ") //Una riga vuota

		k_return = "W"

		fileclose(k_file)

	end if

//if k_operazione = "D" then //Azzero il file 
//	fileclose(k_file)
//	k_file = fileopen( trim(k_path_nome_file), linemode!, write!, lockreadwrite!, Replace!)
//	if k_file > 0 then
//		if LenA(trim(k_return)) = 0 then
//			k_return = " "
//		end if
//		k_bytes = filewriteEx(k_file, "File LOG creato il: " + string(today()) + "  ore: " + string(now()) ) //La prima riga!!!
//	end if
//end if

//	if k_file > 0 then
//		fileclose(k_file)
//	end if

							
return k_return



end function

private function string u_write_error_xml ();//-------------------------------------------------------------------------------------------------
//---
//--- Scrive su File di LOG
//---
//--- Input: 
//---   st_esito	con le indicazioni dell'errore
//---
//--- Ritorna: 	W se operazioni rispettive o OK
//---         		1 nessuna operazione riuscita 
//---
//--- ESEMPIO:
//---			kst_esito = kGuo_exception.inizializza(this.classname())
//---			kst_esito_err.esito = kkg_esito.DB_KO
//---			kst_esito_err.sqlcode = sqlca.sqlcode
//---			kst_esito_err.sqlerrtext = trim(sqlca.sqlerrtext)
//---			kGuo_exception.u_write_error(kst_esito_err) 
//---			
//-------------------------------------------------------------------------------------------------
//---			
long k_file, k_file_copy
long k_bytes, k_bytes1, k_ctr, k_ctr_1, k_bytes_f, k_start_pos
//, k_righe
longlong k_filesize
string k_record, k_record1, k_return = "1", k_errore, k_path_nome_file
st_esito kst_esito

PBDOM_Document kpbdom_doc
PBDOM_Element kpbdom_el_root, kpbdom_el_node1, kpbdom_el_node11, kpbdom_el_node111 //, kpbdom_el_node1111, kpbdom_el_node11111
PBDOM_PROCESSINGINSTRUCTION kpbdom_proc


try
			
	kst_esito = kist_esito			
			
	kpbdom_doc = CREATE PBDOM_Document
	kpbdom_proc = create PBDOM_PROCESSINGINSTRUCTION
	kpbdom_el_node1 = create PBDOM_Element
	kpbdom_el_node11 = create PBDOM_Element
	kpbdom_el_node111 = create PBDOM_Element
//	kpbdom_el_node1111 = create PBDOM_Element
//	kpbdom_el_node11111 = create PBDOM_Element

	u_set_uo_path()
	k_path_nome_file = trim(kguo_path.get_nome_path_file_errori_xml_noext( ))
	if left(k_path_nome_file, 1) = kkg.path_sep &
		                and mid(k_path_nome_file, 2, 1) <> kkg.path_sep then
// se è ad esempio un path relativo (tipo '\mio_path') ma non un path di rete (quindi tipo '\\') allora aggiunge							 
		k_path_nome_file = kGuf_data_base.profilestring_leggi_scrivi (1, "temp", " ") + trim(k_path_nome_file)
		if left(trim(k_path_nome_file), 1) = kkg.path_sep then
			k_path_nome_file = "c:" + trim(k_path_nome_file)
		end if
	end if

//--- toglie i caratteri di new-line e carriege-return = 'a capo'
	k_start_pos = Pos(kst_esito.sqlerrtext, "~n", 1)
	DO WHILE k_start_pos > 0
		kst_esito.sqlerrtext = Replace(kst_esito.sqlerrtext, k_start_pos, 2, " ")
		k_start_pos = Pos(kst_esito.sqlerrtext, "~n", k_start_pos)
	LOOP
	k_start_pos = Pos(kst_esito.sqlerrtext, "~r", 1)
	DO WHILE k_start_pos > 0
		kst_esito.sqlerrtext = Replace(kst_esito.sqlerrtext, k_start_pos, 2, "- ")
		k_start_pos = Pos(kst_esito.sqlerrtext, "~n~r", k_start_pos)
	LOOP

//--- Se file troppo grosso lo Salvo e AZZERO il FILE
	k_filesize = FileLength64(k_path_nome_file + ".xml") // kiuf_file_explorer.u_get_filesize(k_path_nome_file + ".xml")
//	k_righe = errori_conta_righe(k_path_nome_file)
//	if k_righe > 15000 or k_righe = 0 then 
	if k_filesize > 16000000 or k_filesize = 0 then
		filecopy(trim(k_path_nome_file) + ".xml", trim(k_path_nome_file) + ".save.xml", true)   
		
		k_file = fileopen( trim(k_path_nome_file + ".xml"), linemode!, write!, lockreadwrite!, Replace!, EncodingUTF8!)
		if k_file > 0 then
			if LenA(trim(k_return)) = 0 then
				k_return = " "
			end if
			k_bytes = filewriteex(k_file, "<FileLOGcreato>" + string(today()) + "  " +  string(now()) + "</FileLOGcreato>") //La prima riga!!!
		
		// copio le ultime righe del vecchio sul nuovo file
			k_file_copy = fileopen(trim(k_path_nome_file) + ".save.xml", linemode!, read!, LockRead!, Replace!, EncodingUTF8!)
			FileSeek64(k_file_copy, -160000, FromEnd!)		
			k_bytes = FileReadEx(k_file_copy, k_record) // la prima riga la butto!
			if k_bytes > 0 then
				k_bytes = FileReadEx(k_file_copy, k_record)
				if k_bytes > 0 then
					k_bytes1 = FileReadEx(k_file_copy, k_record1)  // leggo una seconda riga per evitare di scrivere l'ultima che contiene EOF
				end if
				do while k_bytes > 0 and k_bytes1 > 0
					k_bytes = filewriteex(k_file, k_record) //scrivo la data dell'errore
					k_bytes = filewriteex(k_file, k_record1) //scrivo la data dell'errore
					k_bytes = FileReadEx(k_file_copy, k_record)
					if k_bytes > 0 then
						k_bytes1 = FileReadEx(k_file_copy, k_record1)   // leggo una seconda riga per evitare di scrivere l'ultima che contiene EOF
					end if
				loop			
			end if
			fileClose(k_file_copy)
			fileClose(k_file)
			
		end if
	end if
	
	kpbdom_doc.newdocument("x")
	
//--- Scrive record di LOG		TextMode!
	k_file = fileopen( trim(k_path_nome_file + ".xml"), linemode!, write!, Shared!, Append!, EncodingUTF8!)
	if k_file > 0 then
		kpbdom_el_root = kpbdom_doc.getrootelement( )
		
		kpbdom_el_node1.setname("Istanza")
		kpbdom_el_node1.setattribute("id", string(kguo_g.get_idprocedura()))
		kpbdom_el_node1.setattribute("data", string(today(),"dd/mm/yyyy") + " " + String(Now( ))) //, "hh:mm:ss "))
		kpbdom_el_node1.setattribute("M2000", string(KKG.VERSIONE))
		kpbdom_el_root.addcontent(kpbdom_el_node1)

		kpbdom_el_node11.setname("Messaggio")
//--- Scrivo tipo errore grave o meno
		if kst_esito.esito = kkg_esito.ko &
		      or kst_esito.esito = kkg_esito.db_ko &
		      or kst_esito.esito = kkg_esito.NO_AUT &
		      or kst_esito.esito = kkg_esito.bug then
			kpbdom_el_node11.setattribute("tipo", "A")
		else								// Scrivo msg informativo					
			kpbdom_el_node11.setattribute("tipo", "W")
		end if
		kpbdom_el_node1.addcontent(kpbdom_el_node11)
		
		kpbdom_el_node111.setname("NomePC")
		kpbdom_el_node111.addcontent(trim(kguo_g.get_nome_computer()))
		kpbdom_el_node11.addcontent(kpbdom_el_node111)
		
		if isvalid(kpbdom_el_node111) then destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
		kpbdom_el_node111.setname("Utente")
		kpbdom_el_node111.setattribute("id", string(kguo_utente.get_id_utente( )))
		kpbdom_el_node111.addcontent(trim(kguo_utente.get_codice()) + " " + trim(kguo_utente.get_nome( )))
		kpbdom_el_node11.addcontent(kpbdom_el_node111)
		
		if isvalid(kpbdom_el_node111) then destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
		kpbdom_el_node111.setname("Esito")
		if kst_esito.esito <> kkg_esito.ok then
		else
			kst_esito.esito = ""
		end if
		if trim(kst_esito.descrizione) > " " then
		else
			kst_esito.descrizione = ""
		end if
		kpbdom_el_node111.setattribute("cod", trim(kst_esito.esito))
		kpbdom_el_node111.addcontent(trim(kst_esito.descrizione))
		kpbdom_el_node11.addcontent(kpbdom_el_node111)
		
		if trim(kst_esito.SQLErrText) > " " then
			k_errore = trim(kst_esito.SQLErrText) 
		else
			k_errore = "nessuna" 
		end if	
		if isvalid(kpbdom_el_node111) then destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
		kpbdom_el_node111.setname("Segnalazione")
		if kst_esito.sqlcode <> 0 then
		else
			kst_esito.sqlcode = 0
		end if	
		kpbdom_el_node111.setattribute("sqlcode", string(kst_esito.sqlcode))
		if trim(kist_esito.descrizione) > " " then
			k_errore += k_errore + ". Descr.: " +  trim(kist_esito.descrizione) + " - Dbcode " + string(kst_esito.sqldbcode)
		end if
		kpbdom_el_node111.addcontent(trim(k_errore))
		kpbdom_el_node11.addcontent(kpbdom_el_node111)

		if trim(kst_esito.nome_oggetto) > " " then
		else
			kst_esito.nome_oggetto = ""
		end if
		if isvalid(kpbdom_el_node111) then destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
		kpbdom_el_node111.setname("Oggetto")
		kpbdom_el_node111.addcontent(trim(kst_esito.nome_oggetto))
		kpbdom_el_node11.addcontent(kpbdom_el_node111)

//--- Salva l'intero documento su stringa x fare il file TXT			
		k_record = kpbdom_doc.SaveDocumentIntoString() 
		k_record = mid(k_record, 4, len(k_record) - 8)  // salta il tag iniziale <x> e finale </x>

		k_bytes = filewriteex(k_file, k_record) //scrivo la data dell'errore
		k_return = "W"

	end if

CATCH ( PBDOM_Exception pbde )
	
catch (uo_exception kuo_exception) 
//	throw kuo_exception
	
finally
	if k_file > 0 then
		fileclose(k_file)
	end if
	if isvalid(kpbdom_doc) then destroy kpbdom_doc
	if isvalid(kpbdom_el_node1) then destroy kpbdom_el_node1
	if isvalid(kpbdom_el_node11) then destroy kpbdom_el_node11
	if isvalid(kpbdom_el_node111) then destroy kpbdom_el_node111

end try


							
return k_return



end function

private subroutine u_set_ki_from_st_esito (st_esito ast_esito);//
//---- gestione centralizzata degli errori della procedura
//
//
string k_titolo

if_isnull(ast_esito)

kist_esito = ast_esito

if kist_esito.esito > " " then 
else
	kist_esito.esito = kkg_esito.ko
end if

if kist_esito.sqlerrtext > " " then
else
	kist_esito.sqlerrtext = "........NESSUN MESSAGGIO DA SCRIVERE......  (chiamata errata, riempire prima ST_ESITO)"
end if

choose case kist_esito.esito
	case kkg_esito.ok 
		k_titolo = "Information: "
	case kkg_esito.db_wrn	
		k_titolo = "Warning: "
	case else
		k_titolo = "Error: "
end choose
kist_esito.sqlerrtext = k_titolo + trim(kist_esito.sqlerrtext) 
if trim(kist_esito.nome_oggetto) > " " or kist_esito.SQLdbcode <> 0 or kist_esito.sqlcode <> 0 or trim(kist_esito.SQLsyntax) > " " or trim(kGuo_utente.get_codice()) > " " then
	kist_esito.sqlerrtext += " " + kkg.acapo + "("
	if trim(kist_esito.nome_oggetto) > " "  then
		kist_esito.sqlerrtext += "oggetto= " + trim(kist_esito.nome_oggetto) + "; "
	end if
	if kist_esito.SQLdbcode <> 0 then 
		kist_esito.sqlerrtext += "dbcode= " + string(kist_esito.SQLdbcode) + "; "
	end if
	if kist_esito.sqlcode <> 0 then
		kist_esito.sqlerrtext += "sqlcode: " + string(kist_esito.sqlcode) + "; "
	end if
	if trim(kist_esito.SQLsyntax) > " " then
		kist_esito.sqlerrtext += "query= " + trim(kist_esito.SQLsyntax) + "; "
	end if
	if trim(kGuo_utente.get_codice()) > " " then					
		kist_esito.sqlerrtext += "utente= " + trim(kGuo_utente.get_codice()) + "; "
	end if
	kist_esito.sqlerrtext += ")"
end if
						
if ast_esito.sqlcode <> 0 then 
	kist_esito.sqlcode = ast_esito.sqlcode
else
	if sqlca.sqlcode <> 0 then
		kist_esito.sqlcode = sqlca.sqlcode
	else
		if ast_esito.SQLdbcode <> 0 then
			kist_esito.sqlcode = ast_esito.SQLdbcode
		else
			kist_esito.sqlcode = 0
		end if
	end if
end if


end subroutine

public function string get_errtext (ref uo_d_std_1 adw_1);//
string k_return=""


		kist_esito = adw_1.kist_esito
		
		if kist_esito.sqlerrtext > " " then
			k_return = trim(kist_esito.sqlerrtext)
		else
			k_return = "Errore generico"
		end if

return k_return

end function

private subroutine u_set_uo_path ();//
//	if isvalid(kguo_path) then 
//		kiuo_path = kguo_path
//	end if
	if trim(kguo_path.get_base_del_server()) > " " then 
	else
		kguo_path.set_path_base_del_server()
	end if

end subroutine

public function integer messaggio_utente (string a_titolo, string a_msg);//---
//---  Espone messaggio a Video
//---
//--- 
//---
int k_return = 0
st_esito kst_esito


//--- se il campo msg è vuoto allora tento di reperire da quello che ho già
kst_esito = get_st_esito()
if trim(kst_esito.sqlerrtext) > " " then
	if trim(a_msg) > " " then
	else
		a_msg = trim(kst_esito.sqlerrtext)
	end if
	if trim(kst_esito.nome_oggetto) > " " then
		a_msg += " " + kkg.acapo + "(" +  trim(kst_esito.nome_oggetto) + ") "
	end if
end if

if NOT isvalid(kguo_utente) or kguo_utente.if_virtual_user() then  // se oggetto ok oppure Utente virtuale allora salta messaggio
else
	//--- e il tipo x fare l'icona giusta
	choose case get_tipo()
		case KK_st_uo_exception_tipo_generico
				messagebox (a_titolo, a_msg, information!)
		case KK_st_uo_exception_tipo_dati_anomali, KK_st_uo_exception_tipo_dati_wrn
				messagebox (a_titolo, a_msg, stopsign!)
		case KK_st_uo_exception_tipo_dati_utente &
			,KK_st_uo_exception_tipo_noaut
				messagebox (a_titolo, a_msg, StopSign!)
		case KK_st_uo_exception_tipo_db_ko
				messagebox (a_titolo, a_msg, stopsign!)
		case KK_st_uo_exception_tipo_ko
				messagebox (a_titolo, a_msg, stopsign!)
		case KK_st_uo_exception_tipo_not_fnd
				messagebox (a_titolo, a_msg, Exclamation!)
		case KK_st_uo_exception_tipo_internal_bug
				messagebox (a_titolo, a_msg, stopsign!)
		case KK_st_uo_exception_tipo_allerta
				messagebox (a_titolo, a_msg, stopsign!)
		case KK_st_uo_exception_tipo_dati_insufficienti, KK_st_uo_exception_tipo_dati_insufficienti1
				messagebox (a_titolo, a_msg, stopsign!)
		case KK_st_uo_exception_tipo_OK
				messagebox (a_titolo, a_msg, Information!)
		case KK_st_uo_exception_tipo_SINO
				k_return = messagebox (a_titolo, a_msg, Question!, YesNo!, 2)
		case KK_st_uo_exception_tipo_non_eseguito
				messagebox (a_titolo, a_msg, stopsign!)
		case else
				messagebox (a_titolo, a_msg, Information!)
	end choose
end if

//--- se ESITO non ancora impostato...
if trim(kist_esito.esito) > " " then
else
	choose case get_tipo()
		case KK_st_uo_exception_tipo_generico
				kist_esito.esito = kkg_esito.ko
		case KK_st_uo_exception_tipo_dati_anomali
				kist_esito.esito = kkg_esito.ko
		case KK_st_uo_exception_tipo_dati_wrn
				kist_esito.esito = kkg_esito.db_wrn
		case KK_st_uo_exception_tipo_dati_utente &
			,KK_st_uo_exception_tipo_noaut
				kist_esito.esito = kkg_esito.no_aut
		case KK_st_uo_exception_tipo_db_ko
				kist_esito.esito = kkg_esito.db_ko
		case KK_st_uo_exception_tipo_ko
				kist_esito.esito = kkg_esito.ko
		case KK_st_uo_exception_tipo_not_fnd
				kist_esito.esito = kkg_esito.not_fnd
		case KK_st_uo_exception_tipo_internal_bug
				kist_esito.esito = kkg_esito.bug
		case KK_st_uo_exception_tipo_allerta
				kist_esito.esito = kkg_esito.no_esecuzione
		case KK_st_uo_exception_tipo_dati_insufficienti, KK_st_uo_exception_tipo_dati_insufficienti1
				kist_esito.esito = kkg_esito.no_esecuzione
		case KK_st_uo_exception_tipo_OK
				kist_esito.esito = kkg_esito.OK
		case else
				kist_esito.esito = kkg_esito.no_esecuzione
	end choose
end if

kst_esito = get_st_esito()
if kst_esito.scrivi_log then
	u_write_error()
end if


return k_return




end function

public function st_esito set_st_esito_err_db (transaction asqlca, string a_sqlerrtext_add_init);/*
  imposta valori standard per errore da DB 
*/
string k_sqlerrtext

if a_sqlerrtext_add_init > " " then
	a_sqlerrtext_add_init = trim(a_sqlerrtext_add_init) + " " + kkg.acapo
else
	a_sqlerrtext_add_init = ""
end if

if not isvalid(asqlca) then 
	kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_db_ko
	kist_esito.sqlcode = 0
	kist_esito.sqldbcode = 0
	kist_esito.sqlerrtext = a_sqlerrtext_add_init
else	
	kist_esito.sqlcode = asqlca.sqlcode
	kist_esito.sqldbcode = asqlca.sqldbcode
	kist_esito.sqlerrtext = a_sqlerrtext_add_init + string(asqlca.sqlcode) + " " + asqlca.sqlerrtext + " (" + trim(asqlca.classname( )) + " " + trim(sqlca.database) + ")"
	if asqlca.sqlcode > 0 then
		kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_db_wrn
	elseif asqlca.sqlcode < 0 then
		kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_db_ko
	else
		kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ok
	end if
		
end if

return kist_esito

end function

on uo_exception.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_exception.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//
//--- struttura per la gestione degli errori
st_uo_exception kist_uo_exception

//--- costanti x valori del tipo di errore
constant int kk_tipo_ex_generico = 1

//kiuf_file_explorer = create kuf_file_explorer
//kiuo_path = create uo_path

end event

event destructor;//
//	if isvalid(kiuf_file_explorer) then destroy kiuf_file_explorer
//	if isvalid(kiuo_path) then destroy kiuo_path   NON LO DISTRUGGO ALTRIMENTI DISTRUGGE IL KGUO_PATH!!!! NON LA SUA COPIA

end event

