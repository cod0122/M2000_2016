﻿$PBExportHeader$kuf_meca_memo.sru
forward
global type kuf_meca_memo from kuf_parent
end type
end forward

global type kuf_meca_memo from kuf_parent
end type
global kuf_meca_memo kuf_meca_memo

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function boolean u_open_applicazione (ref st_tab_g_0 kst_tab_g_0, string k_flag_modalita)
public function boolean if_sicurezza (string aflag_modalita) throws uo_exception
public function boolean if_esiste (st_tab_meca_memo ast_tab_meca_memo) throws uo_exception
public function long get_id_meca_memo_max () throws uo_exception
public function long get_id_meca (ref st_tab_meca_memo kst_tab_meca_memo) throws uo_exception
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
//--- sempre OK in sicurezza
return true

end function

public function boolean u_open_applicazione (ref st_tab_g_0 kst_tab_g_0, string k_flag_modalita);//
kuf_menu_window kuf1_menu_window
st_open_w Kst_open_w


	Kst_open_w.flag_modalita = k_flag_modalita
	Kst_open_w.id_programma = this.get_id_programma(Kst_open_w.flag_modalita)
	Kst_open_w.flag_primo_giro = "S"
	Kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
	Kst_open_w.flag_leggi_dw = " "
	Kst_open_w.flag_cerca_in_lista = " "

	Kst_open_w.key1 = string(kst_tab_g_0.id) 	// id meca
	Kst_open_w.key2 = "4" 	// elenco dei letti e da leggere
	Kst_open_w.key12_any = this			// questo oggetto di gestione del trovo
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(kst_open_w)
	destroy kuf1_menu_window
				
				
return true
end function

public function boolean if_sicurezza (string aflag_modalita) throws uo_exception;//
//--- sempre OK in sicurezza
return true

end function

public function boolean if_esiste (st_tab_meca_memo ast_tab_meca_memo) throws uo_exception;//
//====================================================================
//=== Verifica se esiste almeno un MEMO x questo LOTTO
//=== 
//=== Input: st_tab_meca_memo.id_meca
//=== Output:                   
//=== Ritorna: 
//===           		  
//====================================================================
boolean k_return = false
string k_string = ""
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT distinct '1'
INTO :k_string
FROM meca_memo
where id_meca = :ast_tab_meca_memo.id_meca
using kguo_sqlca_db_magazzino;


 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in rilevazione esistenza MEMO x Lotto id=" + string(ast_tab_meca_memo.id_meca) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
end if

if k_string = "1" then k_return = true

return k_return



end function

public function long get_id_meca_memo_max () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo ID inserito 
//--- 
//---  input: 
//---  ret: max ID_MECA_MEMO
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	SELECT max(id_meca_memo)
		 INTO 
				:k_return
		 FROM meca_memo  
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo ID in tabella Lotto-Memo (MECA_MEMO)" &
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

public function long get_id_meca (ref st_tab_meca_memo kst_tab_meca_memo) throws uo_exception;//
//--------------------------------------------------------------------
//--- Torna il campo ID_MECA
//--- 
//--- Input: st_tab_clienti_memo.id_meca_memo 
//--- Ritorna  id_meca 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
long k_return = 0
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_meca_memo.id_meca_memo > 0 then
	
	select id_meca 
	    into :kst_tab_meca_memo.id_meca
			from meca_memo
			WHERE id_meca_memo = :kst_tab_meca_memo.id_meca_memo
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore lettura codice 'Lotto' da avviso MEMO LOTTI (id " + string(kst_tab_meca_memo.id_meca_memo) + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) 

			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
	else
		if kst_tab_meca_memo.id_meca_memo > 0 then
			k_return = kst_tab_meca_memo.id_meca_memo
		end if
	end if
end if		


return k_return

end function

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
boolean k_return=false
st_esito kst_esito
st_tab_meca_memo kst_tab_meca_memo
kuf_memo kuf1_memo
kuf_armo_tree ku1_armo_tree


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	choose case a_campo_link
	
	//--- Elenco o Nuovo MEMO
		case "id_meca_memo"
			kst_tab_meca_memo.id_meca_memo = adw_link.getitemnumber(adw_link.getrow(), "id_meca_memo")
			if kst_tab_meca_memo.id_meca_memo > 0 then
				ku1_armo_tree = create kuf_armo_tree
				k_return = ku1_armo_tree.link_call(adw_link, "p_meca_memo_elenco")
			else
				kuf1_memo = create kuf_memo
				k_return = kuf1_memo.link_call(adw_link, "p_id_memo_no")
			end if
			 
			
	end choose


catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally
	if isvalid(ku1_armo_tree) then destroy ku1_armo_tree
	if isvalid(kuf1_memo) then destroy kuf1_memo

end try

return k_return

end function

on kuf_meca_memo.create
call super::create
end on

on kuf_meca_memo.destroy
call super::destroy
end on

