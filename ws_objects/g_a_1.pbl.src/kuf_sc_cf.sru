$PBExportHeader$kuf_sc_cf.sru
forward
global type kuf_sc_cf from kuf_parent
end type
end forward

global type kuf_sc_cf from kuf_parent
end type
global kuf_sc_cf kuf_sc_cf

forward prototypes
public function date get_data_scad (ref st_tab_sc_cf kst_tab_sc_cf) throws uo_exception
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_sc_cf kst_tab_sc_cf)
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_sc_cf kst_tab_sc_cf)
public function st_esito anteprima_l (ref datastore kdw_anteprima, st_tab_sc_cf kst_tab_sc_cf)
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public subroutine if_isnull (ref st_tab_sc_cf kst_tab_sc_cf)
public function boolean if_scaduto_sc_cf (st_tab_sc_cf kst_tab_sc_cf) throws uo_exception
public function st_esito set_attivo_x_data (ref date k_data_da, date k_data_a, string k_attivo)
public function boolean u_open_ds (st_open_w ast_open_w) throws uo_exception
end prototypes

public function date get_data_scad (ref st_tab_sc_cf kst_tab_sc_cf) throws uo_exception;//
//--- Leggo Data Scadenza in tabella SC_CF x lo specifico codice sc_cf
//
date k_return=date(0)
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())
	
	select distinct
			 data_scad
	 into :kst_tab_sc_cf.data_scad
		from sc_cf
		where codice = :kst_tab_sc_cf.codice
		using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura data scadenza del Contratto CF (codice=" + trim(kst_tab_sc_cf.codice) + ")" &
							+ "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_sc_cf.data_scad > date(0) then
			k_return = kst_tab_sc_cf.data_scad
		end if
	end if
	
return k_return


end function

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
kuf_contratti kuf1_contratti

try
	if ast_open_w.flag_modalita > " " then
		ast_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	end if
	
	//--- le autorizzazioni sono le stesse del LISTINO
	kuf1_contratti = create kuf_contratti
	ast_open_w.id_programma = kuf1_contratti.get_id_programma(ast_open_w.flag_modalita)
	return kuf1_contratti.if_sicurezza(ast_open_w)
catch (uo_exception kuo_exception)
	throw kuo_exception
finally
	if isvalid(kuf1_contratti) then destroy kuf1_contratti
end try

end function

public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_sc_cf kst_tab_sc_cf);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
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
kst_open_w.id_programma = kkg_id_programma_sc_cf

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
		if kdw_anteprima.dataobject = "d_sc_cf"  then
			if kdw_anteprima.object.sc_cf[1] = kst_tab_sc_cf.codice  then
				kst_tab_sc_cf.codice = " " 
			end if
		end if
	end if

	if LenA(trim(kst_tab_sc_cf.codice)) > 0 then
	
			kdw_anteprima.dataobject = "d_sc_cf"		
			kdw_anteprima.settransobject(sqlca)
	
			kuf1_utility = create kuf_utility
			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_sc_cf.codice)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Capitolato di Fornitura da visualizzare: ~n~r" + "nessun Codice CF indicato"
			kst_esito.esito = kkg_esito.bug
			
		end if
end if


return kst_esito

end function

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_sc_cf kst_tab_sc_cf);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore su cui fare l'anteprima
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
kst_open_w.id_programma = kkg_id_programma_sc_cf

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
		if kdw_anteprima.dataobject = "d_sc_cf"  then
			if kdw_anteprima.object.sc_cf[1] = kst_tab_sc_cf.codice then
				kst_tab_sc_cf.codice = " " 
			end if
		end if
	end if

	if trim(kst_tab_sc_cf.codice) > " " then
	
			kdw_anteprima.dataobject = "d_sc_cf"		
			kdw_anteprima.settransobject(sqlca)
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_sc_cf.codice)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Capitolato di Fornitura da visualizzare: ~n~r" + "nessun Codice CF indicato"
			kst_esito.esito = kkg_esito.bug
			
		end if
end if


return kst_esito

end function

public function st_esito anteprima_l (ref datastore kdw_anteprima, st_tab_sc_cf kst_tab_sc_cf);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore su cui fare l'anteprima
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
kst_open_w.id_programma = kkg_id_programma_sc_cf

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

		kdw_anteprima.dataobject = "d_sc_cf_l"		
		kdw_anteprima.settransobject(sqlca)

		if kst_tab_sc_cf.cod_cli > 0 then
		else
			kst_tab_sc_cf.cod_cli = 0
		end if
		if trim(kst_tab_sc_cf.attivo) > " " then
		else
			kst_tab_sc_cf.attivo = "*"
		end if
		
		kdw_anteprima.reset()	
	//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_sc_cf.cod_cli, kst_tab_sc_cf.attivo)
	
end if


return kst_esito

end function

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;//--------------------------------------------------------------------------------------------------------------
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


st_tab_sc_cf kst_tab_sc_cf
st_esito kst_esito
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


choose case a_campo_link

	case "sc_cf", "cf"
		kst_tab_sc_cf.codice = adw_link.getitemstring(adw_link.getrow(), a_campo_link)
		if trim(kst_tab_sc_cf.codice) > " " then
	
			kst_esito = this.anteprima ( kdsi_elenco_output, kst_tab_sc_cf )
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
			kst_open_w.key1 = "Capitolato: " + trim(kst_tab_sc_cf.codice)
		else
			k_return = false
		end if

	case "b_sc_cf_l"
		kst_tab_sc_cf.cod_cli = 0
		kst_tab_sc_cf.attivo = ""
		kst_esito = this.anteprima_l( kdsi_elenco_output, kst_tab_sc_cf )
		if kst_esito.esito <> kkg_esito.ok then
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
		kst_open_w.key1 = "Elenco Capitolati"

end choose

if k_return then

	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//--- Parametri : 
	//--- struttura st_open_w
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.id_programma = kkg_id_programma_elenco //get_id_programma( kst_open_w.flag_modalita ) //kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
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

public subroutine if_isnull (ref st_tab_sc_cf kst_tab_sc_cf);//---
//--- Inizializza i campi della tabella 
//---

if isnull(kst_tab_sc_cf.codice) then kst_tab_sc_cf.codice = " "
if isnull(kst_tab_sc_cf.sl_pt) then kst_tab_sc_cf.sl_pt = ""
if isnull(kst_tab_sc_cf.data) then kst_tab_sc_cf.data = date(0)
if isnull(kst_tab_sc_cf.data_scad) then kst_tab_sc_cf.data_scad = date(0)
if isnull(kst_tab_sc_cf.cod_cli) then kst_tab_sc_cf.cod_cli = 0
if isnull(kst_tab_sc_cf.descr) then kst_tab_sc_cf.descr = ""

if isnull(kst_tab_sc_cf.x_datins) then kst_tab_sc_cf.x_datins = datetime(date(0))
if isnull(kst_tab_sc_cf.x_utente) then kst_tab_sc_cf.x_utente = ""

end subroutine

public function boolean if_scaduto_sc_cf (st_tab_sc_cf kst_tab_sc_cf) throws uo_exception;//
//--- Controllo se Capitolato di Fornitura Scaduto
//--- inp: st_tab_sc_cf.codice / data_scad (se non indicata mette data oggi)
//--- out: boolean true=trovato; false = non trovato
//--- lancia EXCEPTION se errore sql
//
boolean k_return=false
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if kst_tab_sc_cf.data_scad > kkg.data_zero then
	else
		kst_tab_sc_cf.data_scad = kguo_g.get_dataoggi( )
	end if
	
	if trim(kst_tab_sc_cf.codice) > " " then
		if get_data_scad(kst_tab_sc_cf) < kst_tab_sc_cf.data_scad then
		else
			k_return = true
		end if
	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito( /*st_esito ast_esito */)
	kst_esito.SQLErrText = "Errore in valutazione se Capitolato di Fornitura '" + trim(kst_tab_sc_cf.codice) + "' scaduto prima del " + string(kst_tab_sc_cf.data_scad) &
									 + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
	kuo_exception.set_esito( kst_esito )
	throw kuo_exception

end try
	
return k_return


end function

public function st_esito set_attivo_x_data (ref date k_data_da, date k_data_a, string k_attivo);//
//--- Aggiorna CF flag attivo
//
st_tab_sc_cf kst_tab_sc_cf
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	kst_tab_sc_cf.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_sc_cf.x_utente = kGuf_data_base.prendi_x_utente()

	update sc_cf  
			  set attivo = :k_attivo
			  ,x_datins = :kst_tab_sc_cf.x_datins
			  ,x_utente = :kst_tab_sc_cf.x_utente
			where data_scad between :k_data_da and :k_data_a
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Aggiornamento Capitolati di Fornitura (flag 'attivo'): " + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		
		if kst_tab_sc_cf.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sc_cf.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback()
		end if

	else
		kst_esito.esito = kkg_esito.ok

		if kst_tab_sc_cf.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sc_cf.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit()
		end if

	end if


return kst_esito

end function

public function boolean u_open_ds (st_open_w ast_open_w) throws uo_exception;//
//--- Chiama la OPEN con nel key11 il ds con dentro i dati e key9 in nime del campo "id" della tabella 
//--- (se ci sono particolarità è meglio ereditarla e modificarla)
//---
//--- Input: st_open_w
//---
//
boolean k_return = false
boolean k_sicurezza = false 
long k_riga = 0
string k_type
//kuf_menu_window kuf1_menu_window


ast_open_w.id_programma = get_id_programma(ast_open_w.flag_modalita) //trim(ast_open_w.id_programma)

if ast_open_w.id_programma > " " then
	
	k_sicurezza = if_sicurezza(ast_open_w)
	if k_sicurezza then
		
		if ast_open_w.key9 > " " and ast_open_w.key11_ds.rowcount() > 0 then
			if ast_open_w.flag_modalita <> kkg_flag_modalita.inserimento then
				k_riga = ast_open_w.key11_ds.getrow()
				if k_riga = 0 then k_riga = 1
				k_type = left(ast_open_w.key11_ds.Describe( trim(ast_open_w.key9) + ".ColType"),4)
				if k_type = "!" then  //campo trovato?
					ast_open_w.key1 = ""
				else
					if k_type = "char" then  //tipo di dato, alfanum o numerico?
						ast_open_w.key3 = ast_open_w.key11_ds.getitemstring(k_riga, trim(ast_open_w.key9))
					else
						ast_open_w.key3 = string(ast_open_w.key11_ds.getitemnumber(k_riga, trim(ast_open_w.key9)))
					end if
				end if
			end if
		end if
		if ast_open_w.key3 > " " or ast_open_w.flag_modalita = kkg_flag_modalita.inserimento then
				
			k_return = true
			
			ast_open_w.flag_primo_giro = "S"
			
			//kuf1_menu_window = create kuf_menu_window 
			kGuf_menu_window.open_w_tabelle(ast_open_w)
				
		end if
		
	end if
end if


return k_return



end function

on kuf_sc_cf.create
call super::create
end on

on kuf_sc_cf.destroy
call super::destroy
end on

