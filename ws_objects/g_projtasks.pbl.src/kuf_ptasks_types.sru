$PBExportHeader$kuf_ptasks_types.sru
forward
global type kuf_ptasks_types from kuf_parent0
end type
end forward

global type kuf_ptasks_types from kuf_parent0
end type
global kuf_ptasks_types kuf_ptasks_types

type variables

end variables

forward prototypes
public subroutine _readme ()
public function boolean if_exists (ref st_tab_ptasks_types ast_tab_ptasks_types) throws uo_exception
public subroutine if_isnull (ref st_tab_ptasks_types ast_tab_ptasks_types)
public function boolean tb_delete (st_tab_ptasks_types ast_tab_ptasks_types) throws uo_exception
end prototypes

public subroutine _readme ();//
//--- Associazione tra i Tipi Attività fissi e quelli da usare 
//
end subroutine

public function boolean if_exists (ref st_tab_ptasks_types ast_tab_ptasks_types) throws uo_exception;//
//--- Controlla se riga già esiste per evitare Duplicati
//--- ritorna: TRUE=già esiste su DB; FALSE=non esiste
//---
//--- lancia exception standard
//---
//
boolean k_return
int k_contati
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if trim(ast_tab_ptasks_types.task) > " " then
	select count(*) 
	   into :k_contati
	   from ptasks_types
		where ptasks_types.task = :ast_tab_ptasks_types.task
		using sqlca;

	if sqlca.sqlcode >= 0 then
		if sqlca.sqlcode = 0 and k_contati = 0 then
			k_return=FALSE
		else
			k_return=TRUE // Esiste un record!!!!
		end if
	else
		kst_esito.SQLErrText = "Errore in verifica esistenza Attività '" + trim(ast_tab_ptasks_types.task) &
								+ "' in tab.'ptask_types': " + trim(sqlca.SQLErrText)
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
end if

return k_return

end function

public subroutine if_isnull (ref st_tab_ptasks_types ast_tab_ptasks_types);//---
//--- toglie i NULL ai campi della tabella 
//---
if isnull(ast_tab_ptasks_types.id_ptasks_type) then ast_tab_ptasks_types.id_ptasks_type = 0
if isnull(ast_tab_ptasks_types.descr) then ast_tab_ptasks_types.descr = ""
if isnull(ast_tab_ptasks_types.task) then ast_tab_ptasks_types.task = ""
if isnull(ast_tab_ptasks_types.active) then ast_tab_ptasks_types.active = false
if isnull(ast_tab_ptasks_types.x_utente) then ast_tab_ptasks_types.x_utente = ""
if isnull(ast_tab_ptasks_types.x_datins) then ast_tab_ptasks_types.x_datins = datetime(kkg.data_no)
   
end subroutine

public function boolean tb_delete (st_tab_ptasks_types ast_tab_ptasks_types) throws uo_exception;//
//------------------------------------------------------------------
//--- Cancella il rek dalla tabella Tipi Attività (ptasks_types)
//--- 
//--- inp: st_tab_ptasks_types.id_ptasks_type
//--- rit: true = rimosso
//--- 
//--- 
//------------------------------------------------------------------
boolean k_return
st_esito kst_esito
st_tab_ptasks_types_grp kst_tab_ptasks_types_grp
datastore kds_1

try
	kst_esito = kguo_exception.inizializza(this.classname())

//--- tipo Attività già usata nei Progetti?
	kds_1 = create datastore
	kds_1.dataobject = "ds_ptasks_rows_x_id_ptasks_type" 
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	 
	if kds_1.retrieve(ast_tab_ptasks_types.id_ptasks_type) > 0 then
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlerrtext = "Cancellazione Non Consentita. Tipo Attività '" &
						+ string(ast_tab_ptasks_types.id_ptasks_type) + "' già associata " &
						+ "al Progeto n. " + string(kds_1.getitemnumber(1, "id_ptask")) + "' cliente " &
						+ string(kds_1.getitemnumber(1, "id_cliente")) + "). " 
		kguo_exception.set_esito(kst_esito)							
		throw kguo_exception
	end if

//--- tipo Attività già in un Gruppo?
	kds_1.reset()
	kds_1.dataobject = "ds_ptasks_types_grp_x_id_ptasks_type" 
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	 
	if kds_1.retrieve(ast_tab_ptasks_types.id_ptasks_type) > 0 then
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlerrtext = "Cancellazione Non Consentita. Tipo Attività '" &
						+ string(ast_tab_ptasks_types.id_ptasks_type) + "' già associata " &
						+ "al Gruppo '" + trim(kds_1.getitemstring(1, "descr")) + "' (" &
						+ string(kds_1.getitemnumber(1, "id_ptasks_types_grp")) + "). " &
						+ "Prima di proseguire rimuoverla dal Gruppo indicato."
		kguo_exception.set_esito(kst_esito)							
		throw kguo_exception
	end if
	 
	delete from ptasks_types
		where id_ptasks_type = :ast_tab_ptasks_types.id_ptasks_type 
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in Cancellazione del Tipo Attività '" &
						+ string(ast_tab_ptasks_types.id_ptasks_type) + "': " &
						+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)							
		throw kguo_exception
	end if
	
	if ast_tab_ptasks_types.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_ptasks_types.st_tab_g_0.esegui_commit) then
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

on kuf_ptasks_types.create
call super::create
end on

on kuf_ptasks_types.destroy
call super::destroy
end on

