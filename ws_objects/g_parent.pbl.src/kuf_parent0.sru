$PBExportHeader$kuf_parent0.sru
forward
global type kuf_parent0 from nonvisualobject
end type
end forward

global type kuf_parent0 from nonvisualobject
end type
global kuf_parent0 kuf_parent0

type variables
//
protected string ki_nomeOggetto=""		 	// Nome Oggetto da Utilizzare x la tabella MENU_WINDOW_OGGETTI ovvero per costruire la funzione da Chiamare

protected string ki_msgErrOggetto="valore" 	// testo utilizzato x costruire i messaggi di errore valorizzare ad esempio con "Lotto" o "Attestato" ...
protected string ki_msgErrDescr          		// testo utilizzato x costruire la descrizioone del messaggio di errore es. "Riapertura Lotto"

public string ki_flag_modalita = ""  			// esempio: kkg_flag_modalita.inserimento


end variables

forward prototypes
public function string get_id_programma (string k_flag_modalita)
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function boolean if_sicurezza (string aflag_modalita) throws uo_exception
public function string u_get_errmsg_nontrovato (string a_modalita)
public subroutine _readme ()
public subroutine u_set_ki_nomeoggetto (any a_any)
public function st_esito u_batch_run () throws uo_exception
public function string get_descrizione (string a_modalita)
end prototypes

public function string get_id_programma (string k_flag_modalita);//
string k_return=""
st_tab_menu_window_oggetti kst_tab_menu_window_oggetti


	kst_tab_menu_window_oggetti.funzione = trim(k_flag_modalita)
	kst_tab_menu_window_oggetti.nome_oggetto = ki_nomeOggetto
	if kguf_menu_window.get_id_menu_window(kst_tab_menu_window_oggetti) then

		k_return = trim(kst_tab_menu_window_oggetti.id_menu_window)
	else
		k_return = this.classname( )
	end if

return k_return
end function

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;/*
---------------------------------------------------------------------------------------------------------------------------
  Controlla se funzione autorizzata

    Inp: st_open_w   flag_modalita (se manca assume VISUALIZZAZIONE); id_programma (facoltativo); 
							key1 = descriz.funzione (prima parte, facoltativo)  
    Out: 
    Ritorna: TRUE=autorizzata; FALSE=non autorizzata

---------------------------------------------------------------------------------------------------------------------------
*/
boolean k_return = false
string k_msg1
kuf_sicurezza kuf1_sicurezza


try
	kguo_exception.inizializza(this.classname())

	if trim(ast_open_w.flag_modalita) > " " then
	else
		ast_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	end if
	if trim(ast_open_w.id_programma) > " " then 
	else
		ast_open_w.id_programma = get_id_programma(ast_open_w.flag_modalita) // dovrebbe sempre fare così!
		if trim(ast_open_w.id_programma) > " " then 
		else
			ast_open_w.id_programma = ""
		end if
	end if
	
//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_return = kuf1_sicurezza.autorizza_funzione(ast_open_w)
	
	if not k_return then

//--- compone il msg di errore
		k_msg1 = kguo_g.get_descrizione(ast_open_w.flag_modalita)
		
		if trim(ast_open_w.key1) > " " then // qui eventuale descrizione della funzione
			k_msg1 += " '" + trim(ast_open_w.key1) + "' "
		end if
		if trim(ki_msgErrDescr) > " " then
			k_msg1 = ki_msgErrDescr + " (" + trim(k_msg1) + ") "
		end if
	
		if isnull(kuf1_sicurezza.ki_sr_titolo) then kuf1_sicurezza.ki_sr_titolo = ""
	
		//kguo_exception.st_esito.sqlcode = sqlca.sqlcode
		if trim(ast_open_w.id_programma) > " " or trim(ast_open_w.flag_modalita) > " " then
			kguo_exception.kist_esito.SQLErrText =  "Utente non Autorizzato. " + kkg.acapo + "La funzione di " + k_msg1 + " non e' stata abilitata " &
									+ kkg.acapo + "(" + kuf1_sicurezza.ki_sr_titolo + " id: " + trim(ast_open_w.id_programma)  &
		                     + " in " + kguo_g.get_descrizione(ast_open_w.flag_modalita) + " - " + trim(ast_open_w.flag_modalita)  &
									+ " per l'utente: " + kguo_utente.get_codice( ) + "). "
		else
			kguo_exception.kist_esito.SQLErrText = "Utente non Autorizzato.  La funzione di " + k_msg1 + " non e' stata abilitata. " &
									+ kkg.acapo + "(" + " Id utente: " + kguo_utente.get_codice( ) + "). " 
		end if
		kguo_exception.kist_esito.esito = kguo_exception.KK_st_uo_exception_tipo_noAUT
		throw kguo_exception	
	end if  
		
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_sicurezza) then destroy kuf1_sicurezza
	
	
end try



return k_return

end function

public function boolean if_sicurezza (string aflag_modalita) throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------
//--- Controlla se funzione autorizzata (RIDOTTA)
//---
//--- Inp:   solo il  flag_modalita (se manca assume VISUALIZZAZIONE)
//--- Out: 
//--- Ritorna: TRUE=autorizzata; FALSE=non autorizzata
//---
//---------------------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_open_w kst_open_w


try

	kst_open_w.flag_modalita = trim(aflag_modalita)
	k_return = if_sicurezza(kst_open_w)
		
catch	(uo_exception kuo_exception)
	throw kuo_exception

finally
	
	
end try



return k_return

end function

public function string u_get_errmsg_nontrovato (string a_modalita);//
//--- torna descrizione di errore per valori non trovati
//--- impostare la variabile ki_msgErrOggetto per un msg personalizzato
//--- passare la modalita altrimenti nulla
//
if trim(a_modalita) > " " then
	return "Nessun " + ki_msgErrOggetto + " disponibile. <" + this.get_id_programma(a_modalita) + "> " 
else
	return "Nessun " + ki_msgErrOggetto + " disponibile. " 
end if

end function

public subroutine _readme ();//-------------------------------------------------------------------------------------
//--- Questa non è una funziona ma solo un documento di spiegazione dell'oggetto
//-------------------------------------------------------------------------------------
//---
//--- Questo è l'oggetto PADRE di quasi tutti gli oggetti (User Object)  della Procedura
//--- 
//--- get_descrizione e get_id_programma: dalle tabelle menu_window e menu_window_oggetti
//--- if_sicurezza: verifica l'accesso dell'oggetto rispetto all'utente che lo sta usando - dalle tabelle della sicurezza sr_...
//--- u_batch_run: lancio di una funzione batch

end subroutine

public subroutine u_set_ki_nomeoggetto (any a_any);//
kuf_parent0 kuf1_parent0


kuf1_parent0 = a_any
ki_nomeoggetto = trim(kuf1_parent0.classname())

end subroutine

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
st_esito kst_esito


try 

	kst_esito = kguo_exception.inizializza(this.classname())

// call della routine che esegue il batch
//	k_ctr = this.eseguie_batch( ) 
//	if k_ctr > 0 then
//		kst_esito.SQLErrText = "Operazione conclusa correttamente." + "Sono stati caricati " + string(k_ctr) + " Packing-List da WM.  " 
//	else
//		kst_esito.SQLErrText = "Operazione conclusa. Nessun Packing-List da importare da WM. Funzione: " + kst_open_w.id_programma
//	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

public function string get_descrizione (string a_modalita);//
string k_return=""

	k_return = kguf_menu_window.get_descr(get_id_programma(a_modalita)) 

	if isnull(k_return) then k_return = ""

return k_return
end function

on kuf_parent0.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_parent0.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//
//--- operazioni iniziali
//
//ki_nomeOggetto = trim(this.classname( ))
u_set_ki_nomeoggetto(this)
end event

event destructor;//
//--- operazioni finali
//
end event

