$PBExportHeader$kuf_depositi.sru
forward
global type kuf_depositi from kuf_parent
end type
end forward

global type kuf_depositi from kuf_parent
end type
global kuf_depositi kuf_depositi

forward prototypes
public function boolean tb_delete (st_tab_depositi ast_tab_depositi) throws uo_exception
end prototypes

public function boolean tb_delete (st_tab_depositi ast_tab_depositi) throws uo_exception;/*
 Cancellazione virtuale dei dati nella tabella DEPOSITI
	inp: st_tab_deposito.id_deposito
	rit: true = aggiornato arimosso
*/
boolean k_return


try
	kguo_exception.inizializza(this.classname())

	update DEPOSITI
	     set deleted = 'S'
		where id_deposito = :ast_tab_depositi.id_deposito 
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
						"Errore in Cancellazione del Deposito id " + string(ast_tab_depositi.id_deposito))		
		throw kguo_exception
	end if

	if ast_tab_depositi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_depositi.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if

	k_return = true
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try

return k_return

end function

on kuf_depositi.create
call super::create
end on

on kuf_depositi.destroy
call super::destroy
end on

