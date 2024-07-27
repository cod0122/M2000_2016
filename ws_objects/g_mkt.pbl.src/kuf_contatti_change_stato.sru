$PBExportHeader$kuf_contatti_change_stato.sru
forward
global type kuf_contatti_change_stato from kuf_parent
end type
end forward

global type kuf_contatti_change_stato from kuf_parent
end type
global kuf_contatti_change_stato kuf_contatti_change_stato

type variables
//
kuf_clienti kiuf_clienti
end variables

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function integer u_update_stato_to_estinto () throws uo_exception
public function st_esito u_batch_run () throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return kiuf_clienti.if_sicurezza(ast_open_w)

end function

public function integer u_update_stato_to_estinto () throws uo_exception;/*
   Cambia lo stato a ESTINTO per i Clienti senza Listini Attivi
*/
int k_return
int k_rows, k_rc
uo_ds_std_1 kds_contatti_l_no_listino
st_tab_clienti kst_tab_clienti
kuf_clienti kuf1_clienti


try
	kguo_exception.inizializza(this.classname())
	
	kds_contatti_l_no_listino = create uo_ds_std_1 
	kds_contatti_l_no_listino.dataobject = "ds_contatti_l_no_listino" 
	kds_contatti_l_no_listino.settransobject(kguo_sqlca_db_magazzino)
	
	k_rows = kds_contatti_l_no_listino.retrieve()
	if k_rows < 0 then
		kguo_exception.inizializza(this.classname())
		kguo_exception.set_st_esito_err_ds(kds_contatti_l_no_listino, "Errore in lettura Contatti senza Listini Attivi.")
		throw kguo_exception
	end if

//--- mette lo stato a esitinto
	if k_rows > 0 then
		for k_rc = 1 to k_rows
			kds_contatti_l_no_listino.object.stato.primary[k_rc] = kuf1_clienti.kki_cliente_stato_estinto
			kds_contatti_l_no_listino.object.x_datins.primary[k_rc] = kguf_data_base.prendi_x_datins( )
			kds_contatti_l_no_listino.object.x_utente.primary[k_rc] = kguf_data_base.prendi_x_utente( )
		next
		k_rc = kds_contatti_l_no_listino.update()
		if k_rc < 0 then
			kguo_exception.inizializza(this.classname())
			kguo_exception.set_st_esito_err_ds(kds_contatti_l_no_listino, "Errore in aggiornamento Stato a ESTINTO dei Contatti senza Listini Attivi.")
			kguo_sqlca_db_magazzino.db_rollback( )
			throw kguo_exception
		end if
		kguo_sqlca_db_magazzino.db_commit( )
		k_return = k_rows
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kds_contatti_l_no_listino) then destroy kds_contatti_l_no_listino
	
end try

return k_return

end function

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
long k_ctr
st_esito kst_esito


try 

	kst_esito = kguo_exception.inizializza(this.classname())

// call della routine che esegue il batch
	k_ctr = this.u_update_stato_to_estinto( )
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Operazione conclusa correttamente." + "Sono stati Estinti " + string(k_ctr) + " Contatti senza Listini Attivi.  " 
	else
		kst_esito.SQLErrText = "Operazione conclusa. Nessun Contatto è stato modificato." 
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

event constructor;call super::constructor;//
kiuf_clienti = create kuf_clienti
end event

event destructor;call super::destructor;//
if isvalid(kiuf_clienti) then destroy kiuf_clienti

end event

on kuf_contatti_change_stato.create
call super::create
end on

on kuf_contatti_change_stato.destroy
call super::destroy
end on

