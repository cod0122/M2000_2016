﻿$PBExportHeader$kuf_sr_sicurezza.sru
forward
global type kuf_sr_sicurezza from kuf_parent
end type
end forward

global type kuf_sr_sicurezza from kuf_parent
end type
global kuf_sr_sicurezza kuf_sr_sicurezza

type variables
//
public constant string kki_anteprima_dw_utenti = "d_sr_utenti_1"
public constant string kki_anteprima_dw_settori_utenti_l = "d_sr_utenti_settori_profili_l"

private:
//--- Tipo Modalita operativa su cui opera la windows carattere funzione
constant string ki_ELENCO="e"         
constant string ki_INSERIMENTO="i"     
constant string ki_MODIFICA="m"       
constant string ki_CANCELLAZIONE="c"   
constant string ki_VISUALIZZAZIONE="v"
constant string ki_INTERROGAZIONE="q" 
constant string ki_STAMPA="s" 
constant string ki_CHIUDI_PL="p"      
constant string ki_AUTORIZZATO="a"      
constant string ki_NAVIGATORE="n" 
constant string ki_ANTEPRIMA="v" //"t" 
constant string ki_BATCH="b" 

//--- Campo PERMESSI della tabella sr_settori_profili
public constant int ki_permessi_nessuno = 0
public constant int ki_permessi_lettura = 2
public constant int ki_permessi_scrittura = 4
public constant int ki_permessi_completo = 9

end variables

forward prototypes
public function st_esito tb_delete_sr_prof_funz (st_tab_sr_prof_funz kst_tab_sr_prof_funz)
public function st_esito tb_delete_sr_prof_utenti (st_tab_sr_prof_utenti kst_tab_sr_prof_utenti)
public function st_esito tb_insert_sr_prof_utenti (st_tab_sr_prof_utenti kst_tab_sr_prof_utenti)
public function st_esito tb_insert_sr_prof_funz (st_tab_sr_prof_funz kst_tab_sr_prof_funz)
public function st_esito tb_delete_sr_funzioni (st_tab_sr_funzioni kst_tab_sr_funzioni)
public function st_esito tb_delete_sr_profili (st_tab_sr_profili kst_tab_sr_profili)
public function st_esito tb_sr_funzioni_conta_id_programma (ref st_tab_sr_funzioni kst_tab_sr_funzioni)
public function st_esito tb_sr_funzioni_assegna_nome (ref st_tab_sr_funzioni kst_tab_sr_funzioni)
public function boolean autorizza_funzione (ref st_open_w kst_open_w)
public function st_esito u_esporta_password ()
public function st_esito u_importa_password ()
public function string get_funzione_f (string a_flag_modalita)
public function boolean link_call (ref datawindow adw_1, string a_campo_link) throws uo_exception
public function string check_password (ref string a_password)
public function st_esito tb_delete_sr_settori_profili (st_tab_sr_settori_profili kst_tab_sr_settori_profili)
public function integer if_presente_sr_settore (st_tab_sr_settori_profili ast_tab_sr_settori_profili) throws uo_exception
public function string get_sr_settore (string a_id_menu_window) throws uo_exception
public function boolean autorizza_utente_settore (long a_id_utente, string a_sr_settore, integer a_permessi, string a_modalita) throws uo_exception
public function st_esito anteprima_sr_settore_utenti (datastore kdw_anteprima, st_tab_sr_settori kst_tab_sr_settori) throws uo_exception
public function st_esito anteprima_tab_menu_window_l (datastore kdw_anteprima, st_tab_menu_window kst_tab_menu_window) throws uo_exception
public function st_esito anteprima (datastore kdw_anteprima, st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public function long get_id (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public function long tb_duplica (st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public function integer tb_duplica_prof_utenti (st_tab_sr_utenti kst_tab_sr_utenti_dup, st_tab_sr_utenti kst_tab_sr_utenti_new) throws uo_exception
end prototypes

public function st_esito tb_delete_sr_prof_funz (st_tab_sr_prof_funz kst_tab_sr_prof_funz);//
//====================================================================
//=== Cancella il rek dalla tabella Associazioni Profili-Funzioni Utenti
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
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	if kst_tab_sr_prof_funz.id > 0 then
	
		delete from sr_prof_funz
			where id = :kst_tab_sr_prof_funz.id  
			using sqlca;
	else
		if kst_tab_sr_prof_funz.id_profili > 0 then
	
			delete from sr_prof_funz
				where id_profili = :kst_tab_sr_prof_funz.id_profili  
				using sqlca;

		else

			if kst_tab_sr_prof_funz.id_funzioni > 0 then
		
				delete from sr_prof_funz
					where id_funzioni = :kst_tab_sr_prof_funz.id_funzioni  
					using sqlca;
			end if
		end if
	end if
			

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in cancellazione Funzioni e Profili (Sicurezza): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
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
		kguo_sqlca_db_magazzino.db_commit( )
	end if


return kst_esito

end function

public function st_esito tb_delete_sr_prof_utenti (st_tab_sr_prof_utenti kst_tab_sr_prof_utenti);//
//====================================================================
//=== Cancella il rek dalla tabella Associazioni Profili-Utenti
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
st_esito kst_esito


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 


	delete from sr_prof_utenti
		where id = :kst_tab_sr_prof_utenti.id  
		using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Sicurezza Profili-Utenti:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = "100"
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = "2"
			else
				kst_esito.esito = "1"
			end if
		end if
	else
		kst_esito.esito = "0"
		kguo_sqlca_db_magazzino.db_commit( )
	end if





return kst_esito

end function

public function st_esito tb_insert_sr_prof_utenti (st_tab_sr_prof_utenti kst_tab_sr_prof_utenti);//
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
st_esito kst_esito


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 


	select id
		 into :kst_tab_sr_prof_utenti.id
		 from sr_prof_utenti
			where id_profili = :kst_tab_sr_prof_utenti.id_profili
			      and id_utenti = :kst_tab_sr_prof_utenti.id_utenti
			using sqlca;

	if sqlca.sqlcode = 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Associazione gia' presente nella Tab.Sicurezza Profili-Utenti:~n~r" &
		                       + trim(sqlca.SQLErrText)
		kst_esito.esito = "2"

	else

		kst_tab_sr_prof_utenti.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_sr_prof_utenti.x_utente = kGuf_data_base.prendi_x_utente()
		// id,   
		INSERT INTO sr_prof_utenti  
				(
				  id_profili,   
				  id_utenti,   
				  x_datins,   
				  x_utente )  
			VALUES ( 
						:kst_tab_sr_prof_utenti.id_profili,   
						:kst_tab_sr_prof_utenti.id_utenti,   
						:kst_tab_sr_prof_utenti.x_datins,   
						:kst_tab_sr_prof_utenti.x_utente )  
			using sqlca;

		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Sicurezza Profili-Utenti:" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = "100"
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = "2"
				else
					kst_esito.esito = "1"
				end if
			end if
		else
			commit using sqlca;
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab.Sicurezza Profili-Utenti:" + trim(sqlca.SQLErrText)
			else
				kst_esito.esito = "0"
			end if
		end if
	end if





return kst_esito

end function

public function st_esito tb_insert_sr_prof_funz (st_tab_sr_prof_funz kst_tab_sr_prof_funz);//
//====================================================================
//=== Aggiunge rek nella tabella Associazioni Profili-Funzioni Utenti
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
st_esito kst_esito


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 


	select id
		 into :kst_tab_sr_prof_funz.id
		 from sr_prof_funz
			where id_profili = :kst_tab_sr_prof_funz.id_profili
			      and id_funzioni = :kst_tab_sr_prof_funz.id_funzioni
			using sqlca;

	if sqlca.sqlcode = 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Associazione gia' presente in Tabella~n~r" &
		                       + "Sicurezza Profili-Funzioni (id=" &
									  + string(kst_tab_sr_prof_funz.id) + ")" &
									  + ":~n~r" &
		                       + trim(sqlca.SQLErrText)
		kst_esito.esito = "2"

	else

		kst_tab_sr_prof_funz.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_sr_prof_funz.x_utente = kGuf_data_base.prendi_x_utente()
		// id,   
		INSERT INTO sr_prof_funz  
				(
				  id_profili,   
				  id_funzioni,   
				  x_datins,   
				  x_utente )  
			VALUES ( 
						:kst_tab_sr_prof_funz.id_profili,   
						:kst_tab_sr_prof_funz.id_funzioni,   
						:kst_tab_sr_prof_funz.x_datins,   
						:kst_tab_sr_prof_funz.x_utente )  
			using sqlca;

		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Sicurezza Profili-Funzioni:" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = "100"
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = "2"
				else
					kst_esito.esito = "1"
				end if
			end if
		else
			commit using sqlca;
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab.Sicurezza Profili-Funzioni:" + trim(sqlca.SQLErrText)
			else
				kst_esito.esito = "0"
			end if
		end if
	end if




return kst_esito

end function

public function st_esito tb_delete_sr_funzioni (st_tab_sr_funzioni kst_tab_sr_funzioni);//
//====================================================================
//=== Cancella il rek dalla tabella Sicurezza Funzioni
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
st_esito kst_esito, kst_esito1
st_tab_sr_prof_funz kst_tab_sr_prof_funz


kst_esito = kguo_exception.inizializza(this.classname())

select count(*)
      into :kst_tab_sr_funzioni.contatore
		from sr_prof_funz
		where id_funzioni = :kst_tab_sr_funzioni.id ;
		
	
if kst_tab_sr_funzioni.contatore > 0 then
	if messagebox("Rimuove Funzione '" + trim(kst_tab_sr_funzioni.nome) + "'",&
			"La funzione è presente in " + string (kst_tab_sr_funzioni.contatore) + " Profili utenti~n~r" + &
			"Proseguire con la cancellazione ?"  &
			, question!, yesno!) = 2 then
			
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Elaborazione interrotta dall'utente, funzione '" + trim(kst_tab_sr_funzioni.nome) + "' non cancellata." 
	end if
end if

if kst_esito.esito = kkg_esito.ok then

	delete from sr_funzioni
		where id = :kst_tab_sr_funzioni.id  
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in cancellazione Funzione (Sicurezza) '" + trim(kst_tab_sr_funzioni.nome) + "': " + trim(kguo_sqlca_db_magazzino.SQLErrText)
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
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then
		if kst_tab_sr_funzioni.contatore > 0 then
			kst_tab_sr_prof_funz.id_funzioni = kst_tab_sr_funzioni.id  
			kst_esito1 = tb_delete_sr_prof_funz(kst_tab_sr_prof_funz)		
			if kst_esito1.esito = kkg_esito.db_ko then
				kst_esito = kst_esito1
			end if
		end if
	end if
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then
		kguo_sqlca_db_magazzino.db_commit( )
	else
		kguo_sqlca_db_magazzino.db_rollback( )
	end if

end if

return kst_esito

end function

public function st_esito tb_delete_sr_profili (st_tab_sr_profili kst_tab_sr_profili);//
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

integer k_sn=0
int k_rek_ok=0
long k_id
st_esito kst_esito, kst_esito1
st_tab_sr_prof_funz kst_tab_sr_prof_funz


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 

declare c_prof_utenti cursor for
	select id
		from sr_prof_utenti
		where id_profili = :kst_tab_sr_profili.id ;
declare c_prof_funzioni cursor for
	select id
		from sr_prof_funz
		where id_profili = :kst_tab_sr_profili.id ;

		
open c_prof_utenti;
if sqlca.sqlcode = 0 then
	fetch c_prof_utenti into :k_id;
	if sqlca.sqlcode = 0 then
		k_rek_ok = 1
	end if
	close c_prof_utenti;
end if
	
if k_rek_ok = 1 then
	messagebox("Cancellazione Profilo: " + trim(kst_tab_sr_profili.nome) + &
	      " non consentita",&
			"Profilo ancora associato a Utenti e/o Funzioni~n~r" + &
			"Occorre prima cancellare tutte le associazioni ancora presenti"  &
			, stopsign!, ok!) 
	kst_esito.esito = "2"
	kst_esito.SQLErrText = "Tab.Sicurezza-Profili, elaborazione non Consentita: codice associato a Utenti/Funzioni" 
else

	open c_prof_funzioni;
	if sqlca.sqlcode = 0 then
		fetch c_prof_funzioni into :k_id;
		if sqlca.sqlcode = 0 then
			k_rek_ok = 1
		end if
		close c_prof_funzioni;
	end if

	
	if k_rek_ok = 1 then
		if messagebox("Cancellazione Profilo: " + trim(kst_tab_sr_profili.nome), &
			"Il Codice e' ancora presente nelle Funzioni~n~r" + &
			"Cancello anche tutte le Associazioni presenti?"  &
			, question!, yesno!) = 2 then
			
			kst_esito.esito = "2"
			kst_esito.SQLErrText = "Tab.Sicurezza-Profili, elaborazione non Consentita: codice ancora in Funzioni" 
		else

			kst_esito.esito = "0"
		
		end if
	end if

	if kst_esito.esito = "0" then

		delete from sr_profili
			where id = :kst_tab_sr_profili.id  
			using sqlca;
	
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Sicurezza-Profili:" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = "100"
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = "2"
				else
					kst_esito.esito = "1"
				end if
			end if
		else
			kst_tab_sr_prof_funz.id = 0
			kst_tab_sr_prof_funz.id_funzioni = 0
			kst_tab_sr_prof_funz.id_profili = kst_tab_sr_profili.id  
			kst_esito1 = tb_delete_sr_prof_funz(kst_tab_sr_prof_funz)		
			if sqlca.sqlcode < 0 then
				kst_esito.esito = "2"
				kst_esito = kst_esito1
			else
				kst_esito.esito = "0"
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		end if
	
	end if
end if



return kst_esito

end function

public function st_esito tb_sr_funzioni_conta_id_programma (ref st_tab_sr_funzioni kst_tab_sr_funzioni);//
//====================================================================
//=== Legge il rek dalla tabella Sicurezza Funzioni con id_programma
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
st_esito kst_esito


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	select count(*)
	   into :kst_tab_sr_funzioni.contatore
		from sr_funzioni
		where id_programma = :kst_tab_sr_funzioni.id_programma 
		      and funzioni = :kst_tab_sr_funzioni.funzioni
		      and (id <> :kst_tab_sr_funzioni.id
				     or :kst_tab_sr_funzioni.id = 0)
		using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Sicurezza-Funzioni:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = "100"
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = "2"
			else
				kst_esito.esito = "1"
			end if
		end if
	else
		kst_esito.esito = "0"
	end if






return kst_esito

end function

public function st_esito tb_sr_funzioni_assegna_nome (ref st_tab_sr_funzioni kst_tab_sr_funzioni);//
//====================================================================
//=== Legge il rek dalla tabella Sicurezza Funzioni con id_programma
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

string k_nome=""
int k_ctr
st_esito kst_esito


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


	k_nome = kst_tab_sr_funzioni.nome			

	select count(*)
		into :kst_tab_sr_funzioni.contatore
		from sr_funzioni
		where nome = :k_nome
		using sqlca;
			
//--- controllo se nome già caricato
	k_ctr = 0
	do while kst_tab_sr_funzioni.contatore > 0 

//--- se è così ne formo uno nuovo 
		k_ctr++
		k_nome = kst_tab_sr_funzioni.nome + "#" + string(k_ctr)			
		
		select count(*)
			into :kst_tab_sr_funzioni.contatore
			from sr_funzioni
			where nome = :k_nome
			using sqlca;
			
	loop

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Sicurezza-Funzioni:" + trim(sqlca.SQLErrText)
	else
		kst_tab_sr_funzioni.nome = trim(k_nome)
		kst_esito.esito = "0"
	end if


return kst_esito

end function

public function boolean autorizza_funzione (ref st_open_w kst_open_w);//
//=== Controlla se funzione Autorizzata o meno 
//
boolean k_return
kuf_sicurezza kuf1_sicurezza


kuf1_sicurezza = create kuf_sicurezza

k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)

if isvalid(kuf1_sicurezza) then destroy kuf1_sicurezza

//
//boolean k_return = false
//long k_ctr, k_ctr_idx, k_ctr_save
//
//
//
////--- trovo le autorizzazioni del programma
//k_ctr = 1
//k_ctr_idx = UpperBound(kGst_tab_menu_window[])
//do while k_ctr <= k_ctr_idx 
//	if trim(kst_open_w.id_programma) = trim(kGst_tab_menu_window[k_ctr].id) then
//		kst_open_w.operazioni_autorizzate = trim(kGst_tab_menu_window[k_ctr].funzioni)
//		exit
//	end if
//	k_ctr++
//loop
//
//if k_ctr <= k_ctr_idx then
//
////--- funzione ANTEPRIMA e VISUALIZZAIONE e STAMPA sono state equiparate			
////	if kst_open_w.flag_modalita = kkg_flag_modalita.anteprima or kst_open_w.flag_modalita = kkg_flag_modalita.stampa then
////		kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
////	end if
//
//	choose case kst_open_w.flag_modalita
//			
//////--- funzione ELENCO e NAVIGAZIONE  sono state equiparate		
////		case kkg_flag_modalita.elenco
////			k_ctr_save = k_ctr
////			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_elenco)  )
////			if k_ctr = 0 then
////				k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_navigatore)  )
////			end if
//			
////--- funzione ANTEPRIMA, VISUALIZZAIONE, ELENCO, NAVIGAZIONE e STAMPA sono state equiparate			
//		case kkg_flag_modalita.visualizzazione
//		case kkg_flag_modalita.anteprima
//		case kkg_flag_modalita.navigatore
//		case kkg_flag_modalita.stampa
//		case kkg_flag_modalita.elenco
//			k_ctr_save = k_ctr
//			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_visualizzazione)  )
//			if k_ctr = 0 then
//				k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_anteprima)  )
//				if k_ctr = 0 then
//					k_ctr = PosA ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_navigatore ) )
//					if k_ctr = 0 then
//						k_ctr = PosA ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_stampa ) )
//						if k_ctr = 0 then //--- se sono autorizzato a Modificare lo sono anche per Visualizzare, nooo?
//							k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_modifica) )
//						end if
//					end if
//				end if
//			end if
//			
//		case kkg_flag_modalita.modifica
//			k_ctr_save = k_ctr
//			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_modifica)  )
//			if k_ctr = 0 then //--- se sono autorizzato a cancellare lo sono anche per modificare, nooo?
//				k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_cancellazione) )
//			end if
//			
//		case kkg_flag_modalita.inserimento
//			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_inserimento)  )
//
//		case kkg_flag_modalita.duplica
//			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_inserimento)  )
//			
//		case kkg_flag_modalita.cancellazione
//			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_cancellazione) )
//			
////		case kkg_flag_modalita.stampa
////			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_stampa)  )
//			
//		case kkg_flag_modalita.chiudi_pl
//			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_chiudi_pl)  )
//			
//		case kkg_flag_modalita.BATCH
//			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_BATCH)  )
//		
//////--- funzione NAVIGATORE è simile a ELENCO, VISUALIZZAZIONE			
////		case kkg_flag_modalita.navigatore
////			k_ctr_save = k_ctr
////			k_ctr = PosA ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_navigatore ) )
////			if k_ctr = 0 then
////				k_ctr = PosA ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_visualizzazione ) )
////				if k_ctr = 0 then
////					k_ctr = PosA ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_elenco ) )
////				end if
////			end if
//			
//			
//	end choose
//
//	if k_ctr > 0 then
//		k_return = true
//	end if
//
//end if


return k_return

end function

public function st_esito u_esporta_password ();//====================================================================
//=== Controlla la Utente e Password 
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave DB
//===                                 2=errore > 0
//=== 
//====================================================================

string  k_record, k_path
long k_bytes
int k_file, k_ctr
st_esito kst_esito, kst_esito1
st_tab_sr_utenti kst_tab_sr_utenti_1, kst_tab_sr_utenti 
kuf_cripta kuf1_cripta
kuf_base kuf1_base


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	declare  kc_sicurezza_esporta_pasword cursor for 
		SELECT 
				 sr_utenti.id
				,sr_utenti.password
		 FROM sr_utenti 
		 using sqlca;

	k_path = kguo_path.get_temp( ) //kGuf_data_base.profilestring_leggi_scrivi (1, "temp", " ")
	
	k_file = fileopen( trim(k_path) + "\" + "pm2000", linemode!, write!, lockreadwrite!,Replace! )
	
	if k_file > 0 then
			
		open kc_sicurezza_esporta_pasword;
		if sqlca.sqlcode = 0 then
		
			fetch kc_sicurezza_esporta_pasword INTO 
				 :kst_tab_sr_utenti.id
				,:kst_tab_sr_utenti_1.password;
	
			do while sqlca.sqlcode = 0 
			
				if LenA(trim(kst_tab_sr_utenti_1.password)) > 0 then
	
//--- decripta la password				
					kuf1_cripta = create kuf_cripta
					kst_tab_sr_utenti.password = kuf1_cripta.of_decrypt(trim(kst_tab_sr_utenti_1.password))
					destroy kuf1_cripta
				else
					kst_tab_sr_utenti_1.password = " "
					kst_tab_sr_utenti.password = " "
				end if

//--- scrive password
				k_record = string(kst_tab_sr_utenti.id, "0000")+trim(kst_tab_sr_utenti.password)
				k_bytes = filewrite(k_file, k_record) 
				if k_bytes > 0 then
					k_ctr++
				end if
		
				fetch kc_sicurezza_esporta_pasword INTO 
						 :kst_tab_sr_utenti.id
						,:kst_tab_sr_utenti_1.password;
						
			loop

		end if
		
		fileclose (k_file)
		
	end if

	if k_ctr > 0 then
		kst_esito.SQLErrText = string(k_ctr)
	end if
	
return kst_esito


end function

public function st_esito u_importa_password ();//====================================================================
//=== Controlla la Utente e Password 
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave DB
//===                                 2=errore > 0
//=== 
//====================================================================

string  k_record, k_path
long k_bytes
int k_file, k_ctr
st_esito kst_esito, kst_esito1
st_tab_sr_utenti kst_tab_sr_utenti_1, kst_tab_sr_utenti 
kuf_cripta kuf1_cripta
kuf_base kuf1_base


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_path = kguo_path.get_temp( )
	
	k_file = fileopen( trim(k_path) + "\" + "pm2000", linemode!, read!, lockreadwrite!)
	
	if k_file > 0 then
			
		k_bytes = fileread(k_file, k_record) 
		if k_bytes > 0 then
		
			do while k_bytes > 0 
			
				kst_tab_sr_utenti.id = long(left(k_record,4))
				kst_tab_sr_utenti_1.password = mid(k_record,5)
	
				if LenA(trim(kst_tab_sr_utenti_1.password)) > 0 then
				
//--- se password c'e' un '*' allora resetto la password 
					if trim(kst_tab_sr_utenti_1.password) <> "*" then
	
//--- decripta la password				
						kuf1_cripta = create kuf_cripta
						kst_tab_sr_utenti.password = kuf1_cripta.of_set( trim(kst_tab_sr_utenti_1.password))
						destroy kuf1_cripta

					else
						kst_tab_sr_utenti_1.password = "" 
						
					end if
					
//--- scrive password
					update sr_utenti
							 set password = :kst_tab_sr_utenti.password
							 where id = :kst_tab_sr_utenti.id
							 using sqlca;

					 if sqlca.sqlcode = 0 then
						k_ctr++
					end if
				end if
				
				k_bytes = fileread(k_file, k_record) 
						
			loop

		end if
		
		fileclose (k_file)
		
	end if

	if k_ctr > 0 then
		kst_esito.SQLErrText = string(k_ctr)
	end if
	
return kst_esito


end function

public function string get_funzione_f (string a_flag_modalita);//
//--- torna il giusto flag della modalità richiesta 
//
string k_return=""


choose case a_flag_modalita
		
	case kkg_flag_modalita.inserimento
		k_return = ki_inserimento
		
	case kkg_flag_modalita.modifica
		k_return = ki_modifica
		
	case kkg_flag_modalita.cancellazione
		k_return = ki_cancellazione
		
	case kkg_flag_modalita.visualizzazione
		k_return = ki_visualizzazione
		
	case kkg_flag_modalita.stampa
		k_return = ki_stampa
		
	case kkg_flag_modalita.elenco
		k_return = ki_elenco
		
end choose


return k_return
end function

public function boolean link_call (ref datawindow adw_1, string a_campo_link) throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Attiva LINK cliccato (funzione di ZOOM)
//---
//--- Par. Inut: 
//---               datawindow su cui è stato attivato il LINK
//---               nome campo di LINK
//--- 
//--- Ritorna TRUE tutto OK - FALSE: link non effettuato
//---
//--- Lancia EXCEPTION con  ST_ESITO  standard
//---
//----------------------------------------------------------------------------------------------------------------
// 
long k_rc
boolean k_return=true
string k_coltype=""
st_tab_sr_utenti kst_tab_sr_utenti
st_tab_sr_settori kst_tab_sr_settori
st_tab_menu_window kst_tab_menu_window
st_esito kst_esito
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
pointer kp_oldpointer


kp_oldpointer = SetPointer(hourglass!)

kdsi_elenco_output = create datastore

kst_esito =	kguo_exception.inizializza(this.classname( ))

choose case a_campo_link

	case "x_utente" &
		, "x_utente_cert_alim" &
		, "x_utente_cert_farm" &
		, "x_utente_cert_f_st" &
		, "id_sr_utente" &
		, "id_utenti"

		k_coltype = adw_1.Describe(a_campo_link+".Coltype")
		choose case upper(left(k_coltype,2))
			case 'CH'
				if isnumber(trim(adw_1.getitemstring(adw_1.getrow(), a_campo_link))) then
					kst_tab_sr_utenti.id = integer(adw_1.getitemstring(adw_1.getrow(), a_campo_link))
				else
					kst_tab_sr_utenti.id = 0
				end if
			case else
				kst_tab_sr_utenti.id = adw_1.getitemnumber(adw_1.getrow(), a_campo_link)
		end choose
			
		if kst_tab_sr_utenti.id > 0 then
	
			kst_esito = this.anteprima ( kdsi_elenco_output, kst_tab_sr_utenti )
			kst_open_w.key1 = "Utente: " + string(kst_tab_sr_utenti.id)
		else
			k_return = true //evita il messaggio di errore
		end if


	case  "b_menu_window"   // elenco 
			kst_esito = this.anteprima_tab_menu_window_l( kdsi_elenco_output, kst_tab_menu_window )
			kst_open_w.key1 = "Elenco Programmi Procedura "  
	

	case  "sr_settori_utenti_l"   // elenco utenti del settore
	case  "sr_settore"   
	case  "sr_settore_1"   
			kst_tab_sr_settori.sr_settore = adw_1.getitemstring(adw_1.getrow(), "sr_settore")
			kst_esito = this.anteprima_sr_settore_utenti( kdsi_elenco_output, kst_tab_sr_settori )
			kst_open_w.key1 = "Elenco Utenti del Settore " + trim(kst_tab_sr_settori.sr_settore)

end choose

if k_return then

	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//--- Parametri : 
	//--- struttura st_open_w
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.id_programma = kkg_id_programma.elenco //get_id_programma( kst_open_w.flag_modalita ) //kkg_id_programma.elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key7 = "S"   // EXIT dopo scelta
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kGuf_menu_window.open_w_tabelle(kst_open_w)

	else
		
		kguo_exception.inizializza( )
		kguo_exception.setmessage( "Nessun valore disponibile (" + this.get_id_programma(kst_open_w.flag_modalita) + "). " )
		throw kguo_exception
		
		
	end if

end if

SetPointer(kp_oldpointer)



return k_return

end function

public function string check_password (ref string a_password);//
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Controlla la Lunghezza e Caratteri della Password 
//---
//--- Inpit: string della pwd
//--- 
//--- Ritorna: OK=OK, NOLT=mancano lettere o segni, NONUM=manca almeno un numero, NOCHR=carattere non ammesso, NOLEN=troppo corta
//--- 
//---------------------------------------------------------------------------------------------------------------------------------------------------------
string k_return = "OK"
string k_char
int k_ctr
boolean k_numero_ok, k_lettera_ok, k_char_ko
st_tab_sr_utenti kst_tab_sr_utenti1


	a_password = upper(trim(a_password))
				
	//--- la password deve essere + lunga di 8 caratteri 
	if len(a_password) > 7 then
	
	//--- la password deve contere "lettere (o char particolari) e numeri"
		k_numero_ok = false
		k_lettera_ok = false
		k_char_ko = false
		k_ctr = len(a_password) 
		do while (not k_numero_ok or not k_lettera_ok) and k_ctr > 0
	
			k_char = Mid(a_password, k_ctr, 1)
	
			if isnumber(k_char) then
				k_numero_ok = true
			else
				if k_char = "%"  or k_char = "*" or k_char = "?" or k_char ="!" or k_char = "^" or k_char = "~"" or k_char = "'" then
					k_char_ko = true
				else
					k_lettera_ok = true
				end if
			end if
			k_ctr --
		loop
		if not k_lettera_ok then
			k_return = "NOLT"
		end if
		if not k_numero_ok then
			k_return = "NONUM"
		end if
		if  k_char_ko then
			k_return = "NOCHR"
		end if
	else
		k_return = "NOLEN"
	end if
				
	
return k_return


end function

public function st_esito tb_delete_sr_settori_profili (st_tab_sr_settori_profili kst_tab_sr_settori_profili);//
//====================================================================
//=== Cancella il rek dalla tabella Associazioni Settori- Profili
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
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 


	delete from sr_settori_profili
		where id_sr_settore_profilo = :kst_tab_sr_settori_profili.id_sr_settore_profilo
		using kGuo_sqlca_db_magazzino;

	if kGuo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kGuo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Tab.Sicurezza Profili-Utenti:" + trim(kGuo_sqlca_db_magazzino.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito =  kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito =  kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		kst_esito.esito = kkg_esito.ok
		kguo_sqlca_db_magazzino.db_commit( )
	end if





return kst_esito

end function

public function integer if_presente_sr_settore (st_tab_sr_settori_profili ast_tab_sr_settori_profili) throws uo_exception;//
//====================================================================
//=== Torna > 0 se CODICE SETTORE trovato su alemeno 1 record 
//=== 
//=== Input: st_tab_sr_settori_profili con valorizzato sr_settore    Output: 0=non usato >0 usato                  
//=== Lancia errore UE_EXCEPTION
//=== 
//====================================================================
int k_return = 0
st_esito kst_esito
uo_exception kuo_exception



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
   SELECT distinct  1
       into :k_return
		 FROM sr_settori_profili
		 where sr_settore = :ast_tab_sr_settori_profili.sr_settore
			using sqlca;
	
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Tab. Sicurezza Settori Profili ~n~r:" + trim(sqlca.SQLErrText)
		kuo_exception = create uo_exception
		kuo_exception.set_esito( kst_esito )
		throw kuo_exception
	end if


if isnull(k_return) then k_return = 0

return k_return





end function

public function string get_sr_settore (string a_id_menu_window) throws uo_exception;//====================================================================
//=== Torna il settore per utente+funzione
//=== 
//=== Inp: id_programma
//=== Out: sr_settore
//=== Lancia Exception 
//=== 
//====================================================================
string k_return=""
long k_id_utente 
datastore kds_get_sr_settore
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	if a_id_menu_window > " " then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Settore non reperibile. Manca il codice funzione! "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	k_id_utente = kguo_utente.get_id_utente( )
	
	kds_get_sr_settore = create datastore
	kds_get_sr_settore.dataobject = "ds_get_sr_settore"
	kds_get_sr_settore.settransobject(kguo_sqlca_db_magazzino)

	if kds_get_sr_settore.retrieve(k_id_utente, a_id_menu_window) > 0 then
		
		k_return = kds_get_sr_settore.getitemstring( 1, "sr_settore")

	end if
	
	if isnull(k_return) then k_return = ""

return k_return

end function

public function boolean autorizza_utente_settore (long a_id_utente, string a_sr_settore, integer a_permessi, string a_modalita) throws uo_exception;//
//====================================================================
//=== Torna TRUE se Utente appartiene al SETTORE con il permesso giusto
//=== 
//=== Input: a_id_utente = codice dell'utente che vuole acceder,
//===           a_sr_settore = settore del documento a cui accedere
//===           a_permessi = permessi di accesso al documento (0=nessuno, 2=in lettura, 4=scrittura, 9=completo)
//===           a_modalita = tipo di accesso al documento vi=visual, mo=modifica ecc... (vedi flag_modalita)
//=== Lancia errore UE_EXCEPTION
//=== 
//====================================================================
boolean k_return = false
int k_trovato=0
int k_modalita_permessi=0
st_tab_sr_utenti kst_tab_sr_utenti
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	if len(trim(a_sr_settore)) > 0 then
	else
		a_sr_settore = ""    // se settore a null o "  "
	end if
	if isnull(a_permessi) then
		a_permessi = 4    // x default lettura-scrittura
	end if
	if isnull(a_id_utente) then
		a_id_utente = kguo_utente.get_id_utente( )  // def utente connesso
	end if

//--- se PERMESSI è ZERO non posso fare nulla sul documento
	if a_permessi = 0 then
	
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Autorizzazione per " + kguo_g.get_descrizione(a_modalita)  + " Non Concessa. " + " ~n~r" & 
									  + "Nessun permesso a nessun Utente (eccetto il redigente) concesso da questo Documento " 
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	
	end if

//--- converte codice MODALITA di accesso nel codice PERMESSO
	choose case a_modalita
		case kkg_flag_modalita.cancellazione
			k_modalita_permessi = ki_permessi_completo
		case kkg_flag_modalita.modifica
			k_modalita_permessi = ki_permessi_scrittura
		case kkg_flag_modalita.inserimento
			k_modalita_permessi = ki_permessi_scrittura
		case else
			k_modalita_permessi = ki_permessi_lettura
	end choose


//--- Il PERMESSO sul documento deve essere migliore o uguale all'operazione che voglio compiere, 
//---            ad esempio NON posso CANCELLARE (=9) se sul documento ho al massimo il permesso di SCRIVERE (=4)
	if a_permessi < k_modalita_permessi then
		kst_esito.esito = kkg_esito.no_aut
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Autorizzazione per questo tipo di operazione (" + kguo_g.get_descrizione(a_modalita)  + ") Non Concessa. " + " ~n~r" & 
									 + "Documento del Settore "+ trim(a_sr_settore)   
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception

	end if


	if a_sr_settore = "" or a_id_utente = 0 then
		k_trovato = 1	
	else
		
//		kst_tab_sr_utenti.codice = a_utente_codice
//		this.get_id(kst_tab_sr_utenti)
		kst_tab_sr_utenti.id = a_id_utente
		
		if kst_tab_sr_utenti.id > 0 then

//--- controlla se Per il SETTORE indicato l'utente ha il permesso di accessedere nella modalità indicata 		
			SELECT distinct  1
				 into :k_trovato
				 FROM sr_settori_profili inner join sr_prof_utenti on 
							sr_settori_profili.id_sr_profilo = sr_prof_utenti.id_profili 
				 where sr_settori_profili.sr_settore = :a_sr_settore
							  and sr_prof_utenti.id_utenti = :kst_tab_sr_utenti.id
							  and sr_settori_profili.permessi >= :k_modalita_permessi
					using sqlca;
			
			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore in Autorizzazione Utente " + string(a_id_utente) + " per il Settore '" + trim(a_sr_settore) + "' ~n~r:" + trim(sqlca.SQLErrText)
				kguo_exception.set_esito( kst_esito )
				throw kguo_exception
			end if
		end if
	end if

	if k_trovato = 1 then
		k_return = TRUE
	else  
		kst_esito.esito = kkg_esito.no_aut
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Autorizzazione per " + kguo_g.get_descrizione(a_modalita)  + " Non Concessa. " + " ~n~r" & 
									 + "Documento del Settore '"+ trim(a_sr_settore) + "' non autorizzato per il tuo Utente (cod='" + string(a_id_utente) + "') "  
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if

return k_return


end function

public function st_esito anteprima_sr_settore_utenti (datastore kdw_anteprima, st_tab_sr_settori kst_tab_sr_settori) throws uo_exception;//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: STANDARD
//=== 
//====================================================================
//
//=== 
long k_rc
st_esito kst_esito
kuf_sr_settori kuf1_sr_settori


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kuf1_sr_settori = create kuf_sr_settori
	kuf1_sr_settori.if_sicurezza(kkg_flag_modalita.anteprima)
	
	if kst_tab_sr_settori.sr_settore > " " then

		kdw_anteprima.dataobject = kki_anteprima_dw_settori_utenti_l		
		kdw_anteprima.settransobject(kguo_sqlca_db_magazzino)
	
		kdw_anteprima.reset()	
		k_rc=kdw_anteprima.retrieve(kst_tab_sr_settori.sr_settore)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Utente del Settore da visualizzare: ~n~r" + "nessun codice Settore indicato"
		kst_esito.esito = kkg_esito.not_fnd
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_sr_settori) then destroy kuf1_sr_settori
	
end try


return kst_esito

end function

public function st_esito anteprima_tab_menu_window_l (datastore kdw_anteprima, st_tab_menu_window kst_tab_menu_window) throws uo_exception;//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: STANDARD
//=== 
//====================================================================
//
//=== 
long k_rc
st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	kdw_anteprima.dataobject = "d_menu_window_l"
	kdw_anteprima.settransobject(sqlca)

	kdw_anteprima.reset()	
	k_rc=kdw_anteprima.retrieve()


return kst_esito

end function

public function st_esito anteprima (datastore kdw_anteprima, st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: STANDARD
//=== 
//====================================================================
//
//=== 
long k_rc
st_esito kst_esito
kuf_sr_utenti kuf1_sr_utenti


try
	kst_esito =	kguo_exception.inizializza(this.classname( ))

	kuf1_sr_utenti = create kuf_sr_utenti
	kuf1_sr_utenti.if_sicurezza(kkg_flag_modalita.anteprima)

	if kst_tab_sr_utenti.id > 0 then

		if kst_tab_sr_utenti.id < 9990 then
	
			kdw_anteprima.dataobject = kki_anteprima_dw_utenti		
			kdw_anteprima.settransobject(kguo_sqlca_db_magazzino)
	
			kdw_anteprima.reset()	
			k_rc=kdw_anteprima.retrieve(kst_tab_sr_utenti.id)

		else
			
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Utente speciale " + string(kst_tab_sr_utenti.id) + ", in uso solo ai fini di sviluppo/controllo del software"
			kst_esito.esito = kkg_esito.not_fnd
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		end if
	
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Utente da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_sr_utenti) then destroy kuf1_sr_utenti
	
end try

return kst_esito

end function

public function long get_id (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//====================================================================
//=== Legge id sr_utenti
//=== 
//=== Inp: st_tab_sr_utenti.codice
//=== Out: st_tab_sr_utenti.id
//=== Lancia Exception 
//=== 
//====================================================================
string k_codice_up, k_codice_lo, k_return
kuf_base kuf1_base
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	k_codice_up = upper(kst_tab_sr_utenti.codice)
	k_codice_lo = lower(kst_tab_sr_utenti.codice)

	SELECT 
	      sr_utenti.id
    INTO 
	      :kst_tab_sr_utenti.id
    FROM sr_utenti  
	 where codice = :k_codice_up or codice = :k_codice_lo
	 using kguo_sqlca_db_magazzino ;

	if kguo_sqlca_db_magazzino.sqlcode < 0 or kguo_sqlca_db_magazzino.sqlcode = 100 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_tab_sr_utenti.id = 0
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.SQLErrText = "Ricerca ID utente di " + trim(kst_tab_sr_utenti.codice) + " in Tab. Sicurezza-Utenti " + " ~n~r:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
	
	if isnull(kst_tab_sr_utenti.id) then kst_tab_sr_utenti.id = 0

return kst_tab_sr_utenti.id
end function

public function long tb_duplica (st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//====================================================================
//=== Duplica Utente
//=== 
//=== Inp: st_tab_sr_utenti.id da duplicare
//=== Rit: nuovo ID utente
//=== Lancia Exception 
//=== 
//====================================================================
long k_return
st_tab_sr_utenti kst_tab_sr_utenti_new
st_esito kst_esito
datastore kds_1

try

	kst_esito = kguo_exception.inizializza(this.classname())

	if kst_tab_sr_utenti.id > 0 then
		
		kds_1 = create datastore
		kds_1.dataobject = "d_sr_utenti"
		kds_1.settransobject(kguo_sqlca_db_magazzino)
		if kds_1.retrieve(kst_tab_sr_utenti.id) > 0 then

			kst_tab_sr_utenti_new.codice = "X" + string(now(), "yyyymmddhhmmss")
			
			kds_1.setitem(1, "id", 0)
			kds_1.setitem(1, "stato", "2")
			kds_1.setitem(1, "nome", "nuovo")
			kds_1.setitem(1, "email", "")
			kds_1.setitem(1, "codice", kst_tab_sr_utenti_new.codice)
			kds_1.setitem(1, "dthr_last_access", datetime(date(0), time(0)))
			kds_1.setitem(1, "dt_ultima_modifica", date(0))
			kds_1.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente())
			kds_1.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins())
			
			kds_1.resetupdate( )
			kds_1.setitemstatus( 1, 0, primary!, NewModified!)
			if kds_1.update() = 1 then
				kguo_sqlca_db_magazzino.db_commit()
				
				get_id(kst_tab_sr_utenti_new)
				
				tb_duplica_prof_utenti(kst_tab_sr_utenti, kst_tab_sr_utenti_new) // duplica i Profili
				
			else
				kguo_sqlca_db_magazzino.db_rollback()
				kst_esito.sqlcode = -1
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.SQLErrText = "Nuovo Utente non caricato, operazione fallita!"
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
		
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
	
end try

return k_return
end function

public function integer tb_duplica_prof_utenti (st_tab_sr_utenti kst_tab_sr_utenti_dup, st_tab_sr_utenti kst_tab_sr_utenti_new) throws uo_exception;//------------------------------------------------------------------
//--- Duplica Utente
//--- 
//--- Inp: st_tab_sr_utenti_dup.id da duplicare e 
//---		  st_tab_sr_utenti_new.id nuovo
//--- Rit: numero profili duplicati
//--- Lancia Exception 
//--- 
//------------------------------------------------------------------
int k_rows, k_row
st_esito kst_esito
datastore kds_1

try

	kst_esito = kguo_exception.inizializza(this.classname())

	if kst_tab_sr_utenti_dup.id > 0 and kst_tab_sr_utenti_new.id > 0 then
		
		kds_1 = create datastore
		kds_1.dataobject = "ds_sr_prof_utenti_l"
		kds_1.settransobject(kguo_sqlca_db_magazzino)
		k_rows = kds_1.retrieve(kst_tab_sr_utenti_dup.id)
		kds_1.resetupdate( )
		for k_row = 1 to k_rows

			kds_1.setitem(k_row, "id", 0)
			kds_1.setitem(k_row, "id_utenti", kst_tab_sr_utenti_new.id)
			kds_1.setitem(k_row, "x_utente", kGuf_data_base.prendi_x_utente())
			kds_1.setitem(k_row, "x_datins", kGuf_data_base.prendi_x_datins())
			
			kds_1.setitemstatus(k_row, 0, primary!, NewModified!)
			
		next
		if k_rows > 0 then
			if kds_1.update() = 1 then
				kguo_sqlca_db_magazzino.db_commit()
			else
				kguo_sqlca_db_magazzino.db_rollback()
				kst_esito.sqlcode = -1
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.SQLErrText = "Profili id Utente '" + string(kst_tab_sr_utenti_new.id) + "' non caricati, operazione fallita!"
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
		
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
	
end try

return k_rows
end function

on kuf_sr_sicurezza.create
call super::create
end on

on kuf_sr_sicurezza.destroy
call super::destroy
end on

