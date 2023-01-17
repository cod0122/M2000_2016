$PBExportHeader$kuf_dosimetrie.sru
forward
global type kuf_dosimetrie from kuf_parent0
end type
end forward

global type kuf_dosimetrie from kuf_parent0
end type
global kuf_dosimetrie kuf_dosimetrie

forward prototypes
private subroutine tb_delete_from_date (st_tab_dosimetrie ast_tab_dosimetrie) throws uo_exception
public subroutine tb_move_to_history (st_tab_dosimetrie ast_tab_dosimetrie) throws uo_exception
private subroutine tb_insert_h_from_date (st_tab_dosimetrie ast_tab_dosimetrie) throws uo_exception
end prototypes

private subroutine tb_delete_from_date (st_tab_dosimetrie ast_tab_dosimetrie) throws uo_exception;//
//--- Cancella i dosimetri dalla data e non attivi
//---
//--- inp: st_tab_dosimetrie.data   data da cui storicizzare 
//---
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	delete
	   from dosimetrie
		where data < :ast_tab_dosimetrie.data
		       and attivo = 'N'
	using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if ast_tab_dosimetrie.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_dosimetrie.st_tab_g_0.esegui_commit) then
			kst_esito = kguo_sqlca_db_magazzino.db_commit()
		end if
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.sqlerrtext = "Errore in Cancellazione dati 'Curva Dosimetrica' precedenti alla data del " &
							+ string(ast_tab_dosimetrie.data) + ". Errore: " + trim(kguo_sqlca_db_magazzino.sqlerrtext)
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

end subroutine

public subroutine tb_move_to_history (st_tab_dosimetrie ast_tab_dosimetrie) throws uo_exception;//
//--- storicizza la tabella i dosimetri per data e non attivi
//---
//--- inp: st_tab_dosimetrie.data   data da cui storicizzare 
//---

tb_insert_h_from_date(ast_tab_dosimetrie)
tb_delete_from_date(ast_tab_dosimetrie)

end subroutine

private subroutine tb_insert_h_from_date (st_tab_dosimetrie ast_tab_dosimetrie) throws uo_exception;//
//--- storicizza la tabella solo i dosimetri non attivi
//---
//--- inp: st_tab_dosimetrie.data   data da cui storicizzare 
//---
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

ast_tab_dosimetrie.x_datins = kGuf_data_base.prendi_x_datins()  // data di storicizzazione
ast_tab_dosimetrie.x_utente = kGuf_data_base.prendi_x_utente()  // utente di storicizzazione

INSERT INTO dosimetrie_h  
         ( id,   
           dose,   
           lotto_dosim,   
           data,   
           attivo,   
           dosim_tipo,   
           coeff_a_s,   
           note,   
           x_datins,   
           x_utente,
           x_datins_h,   
           x_utente_h
			)  
   (select 
  			 id,   
           dose,   
           lotto_dosim,   
           data,   
           attivo,   
           dosim_tipo,   
           coeff_a_s,   
           note,   
           x_datins,   
           x_utente,
			  :ast_tab_dosimetrie.x_datins,
			  :ast_tab_dosimetrie.x_utente
	   from dosimetrie
		where data < :ast_tab_dosimetrie.data
		       and attivo = 'N'
			  )  
	using kguo_sqlca_db_magazzino;

if kguo_sqlca_db_magazzino.sqlcode = 0 then
	if ast_tab_dosimetrie.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_dosimetrie.st_tab_g_0.esegui_commit) then
		kst_esito = kguo_sqlca_db_magazzino.db_commit()
	end if
end if

if kguo_sqlca_db_magazzino.sqlcode < 0 then
	kst_esito.esito = kkg_esito.db_ko
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.sqlerrtext = "Errore in storicizzazione dati 'Curva Dosimetrica' precedenti alla data del " &
						+ string(ast_tab_dosimetrie.data) + ". Errore: " + trim(kguo_sqlca_db_magazzino.sqlerrtext)
	kguo_exception.inizializza()
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

//--- rimuove i record STORICIZZATI
if kguo_sqlca_db_magazzino.sqlcode = 0 then
	delete
	   from dosimetrie
		where data < :ast_tab_dosimetrie.data
	using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if ast_tab_dosimetrie.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_dosimetrie.st_tab_g_0.esegui_commit) then
			kst_esito = kguo_sqlca_db_magazzino.db_commit()
		end if
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.sqlerrtext = "Errore in Cancellazione dati 'Curva Dosimetrica' precedenti alla data del " &
							+ string(ast_tab_dosimetrie.data) + ". Errore: " + trim(kguo_sqlca_db_magazzino.sqlerrtext)
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
end if
end subroutine

on kuf_dosimetrie.create
call super::create
end on

on kuf_dosimetrie.destroy
call super::destroy
end on

