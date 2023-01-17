$PBExportHeader$kuf_ptasks_types_grp.sru
forward
global type kuf_ptasks_types_grp from kuf_parent
end type
end forward

global type kuf_ptasks_types_grp from kuf_parent
end type
global kuf_ptasks_types_grp kuf_ptasks_types_grp

forward prototypes
public function boolean tb_delete (st_tab_ptasks_types_grp ast_tab_ptasks_types_grp) throws uo_exception
private subroutine tb_update_json (ref st_tab_ptasks_types_grp ast_tab_ptasks_types_grp) throws uo_exception
public subroutine tb_update (ref st_tab_ptasks_types_grp ast_tab_ptasks_types_grp) throws uo_exception
public subroutine if_isnull (ref st_tab_ptasks_types_grp ast_tab_ptasks_types_grp)
public subroutine tb_insert (ref st_tab_ptasks_types_grp ast_tab_ptasks_types_grp) throws uo_exception
public function long get_ultimo_id () throws uo_exception
end prototypes

public function boolean tb_delete (st_tab_ptasks_types_grp ast_tab_ptasks_types_grp) throws uo_exception;//------------------------------------------------------------------
//--- Cancella il rek dalla tabella Gruppi Tipi Attività (ptasks_types_grp)
//--- 
//--- inp: ast_tab_ptasks_types_grp.id_ptasks_type_grp
//--- rit: true = rimosso
//--- 
//--- 
//------------------------------------------------------------------
boolean k_return
st_esito kst_esito
datastore kds_1


try
	kst_esito = kguo_exception.inizializza(this.classname())

	kds_1 = create datastore
	kds_1.dataobject = "ds_ptasks_x_id_ptasks_types_grp" 
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	 
	if kds_1.retrieve(ast_tab_ptasks_types_grp.id_ptasks_types_grp) > 0 then
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlerrtext = "Cancellazione Non Consentita. Gruppo Attività Progetti n. '" &
						+ string(ast_tab_ptasks_types_grp.id_ptasks_types_grp) + "' già associato " &
						+ "al Progetto '" + string(kds_1.getitemnumber(1, "id_ptasks")) + "' " &
						+ "di " + trim(kds_1.getitemstring(1, "rag_soc_10")) + "'" &
						 + ". " &
						+ "Prima di proseguire rimuoverlo dal Progetto indicato."
		kguo_exception.set_esito(kst_esito)							
		throw kguo_exception
	end if
	 
	delete from ptasks_types_grp
		where id_ptasks_types_grp = :ast_tab_ptasks_types_grp.id_ptasks_types_grp 
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in Cancellazione del Gruppo Attività Progetti '" &
						+ string(ast_tab_ptasks_types_grp.id_ptasks_types_grp) + "': " &
						+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)							
		throw kguo_exception
	end if
	
	if ast_tab_ptasks_types_grp.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_ptasks_types_grp.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if

	k_return = true
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
	
end try

return k_return

end function

private subroutine tb_update_json (ref st_tab_ptasks_types_grp ast_tab_ptasks_types_grp) throws uo_exception;//
//------------------------------------------------------------------
//--- Update/Insert the row in  ptasks_types_grp  campo JSON
//--- 
//--- Inp:  ptasks_types_json  formattato json es. "{[1,5,6]}"
//---           	          (elenco id_ptasks_type del gruppo)
//---           	
//------------------------------------------------------------------
//
st_esito kst_esito


	try
		kst_esito = kguo_exception.inizializza(this.classname())
		
		if ast_tab_ptasks_types_grp.id_ptasks_types_grp > 0 then
	
	//--- pulizia di tutto il campo JSON
//						 set ptasks_types_json = JSON_MODIFY(ptasks_types_json, '$.voci', NULL)
			update ptasks_types_grp
				 set ptasks_types_json = '{}'
						where id_ptasks_types_grp = :ast_tab_ptasks_types_grp.id_ptasks_types_grp
						using kguo_sqlca_db_magazzino ;
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Fallito Aggiornamento 'Gruppo Attività Progetti' n. " + string(ast_tab_ptasks_types_grp.id_ptasks_types_grp) &
							+ ", pulizia area dati json (ptasks_types_grp): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

	//--- compone i campi JSON		
			update ptasks_types_grp
				 set ptasks_types_json 
				     = JSON_MODIFY(ptasks_types_json, '$.id_ptasks_type', JSON_QUERY(:ast_tab_ptasks_types_grp.ptasks_types_json))
				where id_ptasks_types_grp = :ast_tab_ptasks_types_grp.id_ptasks_types_grp
				using kguo_sqlca_db_magazzino ;

			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Fallito Aggiornamento Tipi Attività in 'Gruppo Attività Progetti' n. " + string(ast_tab_ptasks_types_grp.id_ptasks_types_grp) &
								+ ", campo: ptasks_types_json " &
								+ " valore: "+ ast_tab_ptasks_types_grp.ptasks_types_json + " (ptasks_types_grp). " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

			if ast_tab_ptasks_types_grp.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_ptasks_types_grp.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			
		end if
		
	catch	(uo_exception kuo_exception)
		if kuo_exception.kist_esito.esito = kkg_esito.db_ko then
			if ast_tab_ptasks_types_grp.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_ptasks_types_grp.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			kguo_exception.scrivi_log( )
		end if
		throw kuo_exception
	
	finally
	
	end try
		

end subroutine

public subroutine tb_update (ref st_tab_ptasks_types_grp ast_tab_ptasks_types_grp) throws uo_exception;//
//====================================================================
//=== Update the row in  ptasks_types_grp 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
st_tab_ptasks_types_grp kst_tab_ptasks_types_grp


	try
		kst_esito = kguo_exception.inizializza(this.classname())
	
//--- controlla se utente autorizzato alla funzione in atto
		if_sicurezza(kkg_flag_modalita.modifica )
	
		if ast_tab_ptasks_types_grp.id_ptasks_types_grp > 0 then
	
			ast_tab_ptasks_types_grp.x_datins = kGuf_data_base.prendi_x_datins()
			ast_tab_ptasks_types_grp.x_utente = kGuf_data_base.prendi_x_utente()

			if_isnull(ast_tab_ptasks_types_grp)

//--- aggiorna i dati del Contratto (JSON)
			kst_tab_ptasks_types_grp = ast_tab_ptasks_types_grp
			kst_tab_ptasks_types_grp.st_tab_g_0.esegui_commit = "N"
			tb_update_json(kst_tab_ptasks_types_grp)
			
			kst_tab_ptasks_types_grp.st_tab_g_0.esegui_commit = ast_tab_ptasks_types_grp.st_tab_g_0.esegui_commit
			ast_tab_ptasks_types_grp = kst_tab_ptasks_types_grp

//--- aggiorna altri dati non JSON 
			update ptasks_types_grp
					 set 
					  	descr = :ast_tab_ptasks_types_grp.descr
					 	, x_datins = :ast_tab_ptasks_types_grp.x_datins
						, x_utente = :ast_tab_ptasks_types_grp.x_utente
					where id_ptasks_types_grp = :ast_tab_ptasks_types_grp.id_ptasks_types_grp
					using kguo_sqlca_db_magazzino ;
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Fallito Aggiornamento 'Gruppo Attività Progetti' " + string(ast_tab_ptasks_types_grp.id_ptasks_types_grp) &
								+ ", dati vari e di ultimo aggiornamento (ptasks_types_grp): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

			if ast_tab_ptasks_types_grp.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_ptasks_types_grp.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			
		end if
		
	catch	(uo_exception kuo_exception)
		if kuo_exception.kist_esito.esito = kkg_esito.db_ko then
			if ast_tab_ptasks_types_grp.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_ptasks_types_grp.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			kguo_exception.scrivi_log( )
		end if
		throw kuo_exception
	
	finally
	
	end try
		

end subroutine

public subroutine if_isnull (ref st_tab_ptasks_types_grp ast_tab_ptasks_types_grp);//---
//--- Inizializza i campi della tabella 
//---

if isnull(ast_tab_ptasks_types_grp.id_ptasks_types_grp ) then ast_tab_ptasks_types_grp.id_ptasks_types_grp = 0
if isnull(ast_tab_ptasks_types_grp.descr ) then ast_tab_ptasks_types_grp.descr = ""
if isnull(ast_tab_ptasks_types_grp.ptasks_types_json ) then ast_tab_ptasks_types_grp.ptasks_types_json = ""

if isnull(ast_tab_ptasks_types_grp.x_datins) then ast_tab_ptasks_types_grp.x_datins = datetime(date(0))
if isnull(ast_tab_ptasks_types_grp.x_utente) then ast_tab_ptasks_types_grp.x_utente = " "

end subroutine

public subroutine tb_insert (ref st_tab_ptasks_types_grp ast_tab_ptasks_types_grp) throws uo_exception;//
//====================================================================
//=== Insert new row in  ptasks_types_grp 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
st_tab_ptasks_types_grp kst_tab_ptasks_types_grp


	try
		kst_esito = kguo_exception.inizializza(this.classname())
	
//--- controlla se utente autorizzato alla funzione in atto
		if_sicurezza(kkg_flag_modalita.inserimento )

		ast_tab_ptasks_types_grp.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_ptasks_types_grp.x_utente = kGuf_data_base.prendi_x_utente()
	
		if_isnull(ast_tab_ptasks_types_grp)

//--- aggiorna altri dati non JSON 
		insert into ptasks_types_grp
					  	(descr 
					 	, x_datins 
						, x_utente )
					values (
					  	:ast_tab_ptasks_types_grp.descr
					 	, :ast_tab_ptasks_types_grp.x_datins
						, :ast_tab_ptasks_types_grp.x_utente)
					using kguo_sqlca_db_magazzino ;
					
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Fallito Inserimento nuova 'Gruppo Attività Progetti' " &
							+ ", dati generici (ptasks_types_grp): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		//select SCOPE_IDENTITY() into :ast_tab_ptasks_types_grp.id_ptasks_types_grp from ptasks_types_grp
		//			using kguo_sqlca_db_magazzino ;
		ast_tab_ptasks_types_grp.id_ptasks_types_grp = get_ultimo_id()
					
//--- aggiorna i dati del Contratto (JSON)
		kst_tab_ptasks_types_grp = ast_tab_ptasks_types_grp
		kst_tab_ptasks_types_grp.st_tab_g_0.esegui_commit = "N"
		tb_update_json(kst_tab_ptasks_types_grp)

		kst_tab_ptasks_types_grp.st_tab_g_0.esegui_commit = ast_tab_ptasks_types_grp.st_tab_g_0.esegui_commit
		ast_tab_ptasks_types_grp = kst_tab_ptasks_types_grp

		if ast_tab_ptasks_types_grp.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_ptasks_types_grp.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
			
	catch	(uo_exception kuo_exception)
		if kuo_exception.kist_esito.esito = kkg_esito.db_ko then
			if ast_tab_ptasks_types_grp.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_ptasks_types_grp.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			kguo_exception.scrivi_log( )
		end if
		throw kuo_exception
	
	finally
	
	end try
		

end subroutine

public function long get_ultimo_id () throws uo_exception;//
//====================================================================
//=== Torna l'ultimo ID caricato 
//=== 
//=== Ritorna: ultimo id caricato
//=== 
//====================================================================
long k_return
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

   SELECT max(id_ptasks_types_grp)
       into :k_return
		 FROM ptasks_types_grp
			using kguo_sqlca_db_magazzino ;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Gruppo Attività Progetti (cercato ultimo ID caricato) ~n~r:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception 
	end if

return k_return




end function

on kuf_ptasks_types_grp.create
call super::create
end on

on kuf_ptasks_types_grp.destroy
call super::destroy
end on

