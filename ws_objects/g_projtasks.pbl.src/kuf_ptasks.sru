$PBExportHeader$kuf_ptasks.sru
forward
global type kuf_ptasks from kuf_parent
end type
end forward

global type kuf_ptasks from kuf_parent
end type
global kuf_ptasks kuf_ptasks

type variables
//
string kki_status_APERTO = "O"
string kki_status_SOSPESO = "S"
string kki_status_ANNULLATO = "A"
string kki_status_CHIUSO = "D"

end variables

forward prototypes
public subroutine _readme ()
public function boolean if_exists_cntr_val (ref st_tab_ptasks ast_tab_ptasks) throws uo_exception
public subroutine if_isnull (ref st_tab_ptasks ast_tab_ptasks)
public function boolean tb_delete (st_tab_ptasks ast_tab_ptasks) throws uo_exception
public function long get_id_ptask_max () throws uo_exception
public subroutine tb_update_json (ref st_tab_ptasks ast_tab_ptasks) throws uo_exception
public subroutine set_id_meca (st_tab_ptasks kst_tab_ptasks) throws uo_exception
public function long get_n_ptask_max () throws uo_exception
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
end prototypes

public subroutine _readme ();//
//--- Progetti Attività
//
end subroutine

public function boolean if_exists_cntr_val (ref st_tab_ptasks ast_tab_ptasks) throws uo_exception;//--- 
//--- Controlla se riga già esiste pr lo stesso contratto
//--- Inp: st_tab_ptasks.cntr_val
//--- rit: TRUE=già esiste su DB; FALSE=non esiste
//---
//--- lancia exception standard
//---
//
boolean k_return
int k_contati
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if trim(ast_tab_ptasks.cntr_val) > " " then
	
	select count(*) 
	   into :k_contati
	   from ptasks
		where ptasks.cntr_val = :ast_tab_ptasks.cntr_val
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode >= 0 then
		if kguo_sqlca_db_magazzino.sqlcode = 0 and k_contati = 0 then
			k_return=FALSE
		else
			k_return=TRUE // Esiste un record!!!!
		end if
	else
		kst_esito.SQLErrText = "Errore in verifica nei Progetti del Contratto: " + trim(ast_tab_ptasks.cntr_val) &
								+ "' in tab.'ptask': " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
end if

return k_return

end function

public subroutine if_isnull (ref st_tab_ptasks ast_tab_ptasks);//---
//--- toglie i NULL ai campi della tabella 
//---
if isnull(ast_tab_ptasks.id_ptask) then ast_tab_ptasks.id_ptask = 0
if isnull(ast_tab_ptasks.id_ptasks_types_grp) then ast_tab_ptasks.id_ptasks_types_grp = 0
if isnull(ast_tab_ptasks.id_cliente) then ast_tab_ptasks.id_cliente = 0
if isnull(ast_tab_ptasks.cntr_val) then ast_tab_ptasks.cntr_val = ""
if isnull(ast_tab_ptasks.cntr_descr) then ast_tab_ptasks.cntr_descr = ""
if isnull(ast_tab_ptasks.user_ins) then ast_tab_ptasks.user_ins = ""
if isnull(ast_tab_ptasks.date_ins) then ast_tab_ptasks.date_ins = datetime(kkg.data_no)
if isnull(ast_tab_ptasks.x_utente) then ast_tab_ptasks.x_utente = ""
if isnull(ast_tab_ptasks.x_datins) then ast_tab_ptasks.x_datins = datetime(kkg.data_no)
   
end subroutine

public function boolean tb_delete (st_tab_ptasks ast_tab_ptasks) throws uo_exception;/*
 Cancella il rek dalla tabella Progetti Attività (ptasks)
	inp: st_tab_ptasks.id_ptask
	rit: true = rimosso
*/
boolean k_return
st_tab_ptasks_rows kst_tab_ptasks_rows
kuf_ptasks_rows kuf1_ptasks_rows


try
	kguo_exception.inizializza(this.classname())

	delete from ptasks
		where id_ptask = :ast_tab_ptasks.id_ptask 
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
						"Errore in Cancellazione del Progetto id " + string(ast_tab_ptasks.id_ptask))		
		throw kguo_exception
	end if

//--- cancellare le righe
	kuf1_ptasks_rows = create kuf_ptasks_rows
	kst_tab_ptasks_rows.id_ptask = ast_tab_ptasks.id_ptask 
 	kuf1_ptasks_rows.tb_delete_x_id_ptask(kst_tab_ptasks_rows)
	
	if ast_tab_ptasks.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_ptasks.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if

	k_return = true
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_ptasks_rows) then destroy kuf1_ptasks_rows
	
end try

return k_return

end function

public function long get_id_ptask_max () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo ID_PTASK inserito 
//--- 
//---  input: 
//---  ret: max ID_ptask
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	SELECT max(ID_ptask)
		 INTO 
				:k_return
		 FROM ptasks  
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo ID Progetto in tabella (ptasks)" &
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

public subroutine tb_update_json (ref st_tab_ptasks ast_tab_ptasks) throws uo_exception;//
//------------------------------------------------------------------
//--- Update/Insert the row in  ptasks  campo JSON
//--- 
//--- Inp:  ptasks_types_json  formattato json es. "{[1,5,6]}"
//---           	          (elenco id_ptasks_type del Progetto)
//---           	
//------------------------------------------------------------------
//
st_esito kst_esito


	try
		kst_esito = kguo_exception.inizializza(this.classname())
		
		if ast_tab_ptasks.id_ptask > 0 then
	
	//--- pulizia di tutto il campo JSON
//						 set ptasks_types_json = JSON_MODIFY(ptasks_types_json, '$.voci', NULL)
			update ptasks
				 set ptasks_types_json = '{}'
						where id_ptask = :ast_tab_ptasks.id_ptask
						using kguo_sqlca_db_magazzino ;
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Fallito Aggiornamento Tipi Attività nel Progetto n. " + string(ast_tab_ptasks.id_ptask) &
							+ ", pulizia area dati json (ptasks): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

	//--- compone i campi JSON		
			update ptasks
				 set ptasks_types_json 
				     = JSON_MODIFY(ptasks_types_json, '$.id_ptasks_type', JSON_QUERY(:ast_tab_ptasks.ptasks_types_json))
				where id_ptask = :ast_tab_ptasks.id_ptask
				using kguo_sqlca_db_magazzino ;

			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Fallito Aggiornamento Tipi Attività nel Progetto n. " + string(ast_tab_ptasks.id_ptask) &
								+ ", campo: ptasks_types_json " &
								+ " valore: "+ ast_tab_ptasks.ptasks_types_json + " (ptasks). " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

			if ast_tab_ptasks.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_ptasks.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			
		end if
		
	catch	(uo_exception kuo_exception)
		if kuo_exception.kist_esito.esito = kkg_esito.db_ko then
			if ast_tab_ptasks.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_ptasks.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			kguo_exception.scrivi_log( )
		end if
		throw kuo_exception
	
	finally
	
	end try
		

end subroutine

public subroutine set_id_meca (st_tab_ptasks kst_tab_ptasks) throws uo_exception;//
//====================================================================
//=== Imposta  campo  id_meca
//=== 
//=== Input: st_tab_ptasks.id_ptask, id_meca
//=== out: TRUE = ok                                 
//===
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
st_esito kst_esito
uo_exception kuo_exception


kst_esito = kguo_exception.inizializza(this.classname())

if kst_tab_ptasks.id_ptask > 0 then
	
	update ptasks
				set
					id_meca   = :kst_tab_ptasks.id_meca
				where id_ptask = :kst_tab_ptasks.id_ptask
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiornamento Id Lotto sul Progetto n.: "+ string(kst_tab_ptasks.id_ptask) + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
	//---- COMMIT....	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_ptasks.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_ptasks.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if

end if
		


end subroutine

public function long get_n_ptask_max () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo ID_PTASK inserito 
//--- 
//---  input: 
//---  ret: max N_PTASK
//---                                     
//------------------------------------------------------------------
//
long k_return
int k_anno
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	k_anno = kguo_g.get_anno( )
	if k_anno > 0 then
	else
		kst_esito.SQLErrText = "Errore in lettura ultimo N. Progetto. Anno in corso mancante."
		kst_esito.esito = kkg_esito.ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	SELECT max(N_PTASK)
		 INTO 
				:k_return
		 FROM ptasks  
		 where year(date_ins) = :k_anno
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo N. Progetto in tabella (ptasks)" &
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
string k_rcx
boolean k_return=true

st_tab_ptasks kst_tab_ptasks
st_esito kst_esito
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito  = kguo_exception.inizializza(this.classname())


choose case a_campo_link

	case "n_ptask", "id_ptask", "n_ptask_x"
		k_rcx = adw_link.describe("id_ptask.dbName")
		if k_rcx <> "!" and k_rcx <> "?" then
				
			kst_tab_ptasks.id_ptask = adw_link.getitemnumber(adw_link.getrow(), "id_ptask")
			if kst_tab_ptasks.id_ptask > 0 then
		
			else
				k_return = false
			end if
		else
			k_return = false
			kguo_exception.set_tipo( kkg_esito_no_esecuzione )
			kguo_exception.setmessage( "Link Fallito", "Accesso al Progetto fallito per mancanza del id, campo di link '" + trim(a_campo_link) + "' " )
			kguo_exception.scrivi_log( )
		end if

end choose

if k_return then

	kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)
	kst_open_w.key1 = string(kst_tab_ptasks.id_ptask)
	u_open(kst_open_w)

else
		
	kguo_exception.inizializza( )
	kguo_exception.setmessage( "Nessun valore disponibile (" + this.get_id_programma(kst_open_w.flag_modalita) + "). " )
	throw kguo_exception
		
end if

SetPointer(kp_oldpointer)



return k_return

end function

on kuf_ptasks.create
call super::create
end on

on kuf_ptasks.destroy
call super::destroy
end on

