$PBExportHeader$kuf_deposito_anag.sru
forward
global type kuf_deposito_anag from kuf_parent
end type
end forward

global type kuf_deposito_anag from kuf_parent
end type
global kuf_deposito_anag kuf_deposito_anag

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function boolean tb_delete (st_tab_deposito_anag ast_tab_deposito_anag) throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
boolean k_return 
kuf_depositi kuf1_depositi 


kuf1_depositi  = create kuf_depositi
k_return = kuf1_depositi.if_sicurezza(ast_open_w)

return k_return
end function

public function boolean tb_delete (st_tab_deposito_anag ast_tab_deposito_anag) throws uo_exception;/*
 Cancellazione virtuale dei dati nella tabella DEPOSITO_ANAG
	inp: st_tab_deposito.id_deposito_anag
	rit: true = rimosso
*/
boolean k_return


try
	kguo_exception.inizializza(this.classname())

	update DEPOSITO_ANAG
	     set deleted = 'S'
		where id_deposito_anag = :ast_tab_DEPOSITO_ANAG.id_deposito_anag 
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
						"Errore in aggiornamento a Cancellazione dell'Anagrafica di Deposito id " + string(ast_tab_DEPOSITO_ANAG.id_deposito_anag))		
		throw kguo_exception
	end if

	if ast_tab_DEPOSITO_ANAG.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_DEPOSITO_ANAG.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if

	k_return = true
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try

return k_return

end function

on kuf_deposito_anag.create
call super::create
end on

on kuf_deposito_anag.destroy
call super::destroy
end on

