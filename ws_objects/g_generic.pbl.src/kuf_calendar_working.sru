$PBExportHeader$kuf_calendar_working.sru
forward
global type kuf_calendar_working from nonvisualobject
end type
end forward

global type kuf_calendar_working from nonvisualobject
end type
global kuf_calendar_working kuf_calendar_working

forward prototypes
public function boolean u_exec_sp () throws uo_exception
public function st_esito u_batch_run () throws uo_exception
public function boolean u_update () throws uo_exception
end prototypes

public function boolean u_exec_sp () throws uo_exception;//
//--- Esecuzione della Stored Procedure MSSQL 
//
boolean k_return
string k_status
int k_rc


	DECLARE u_m2000_add_calendar_working PROCEDURE FOR
			@li_rc = dbo.u_m2000_add_calendar_working
									@k_status varchar(8000) = :k_status OUT
		using kguo_sqlca_db_magazzino ;
			
	execute u_m2000_add_calendar_working;
	
	IF kguo_sqlca_db_magazzino.SQLCode < 0 THEN
		k_rc = kguo_sqlca_db_magazzino.SQLCode
	ELSE
			// Put the return value into the var and close the declaration.
		FETCH u_m2000_add_calendar_working INTO :k_rc, :k_status;
		IF kguo_sqlca_db_magazzino.SQLCode = 0 THEN
			k_return = true
		end if
		CLOSE u_m2000_add_calendar_working;
	END IF

	if k_rc < 0 then
		kguo_exception.set_nome_oggetto(this.classname())
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_db_ko)
		kguo_exception.setmessage( "Aggiornamento Calendario Fallita", "Errore in esecuzione (rc=" + string(k_rc) +"): " + trim(k_status))
		throw kguo_exception
	else
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
return k_return
end function

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
boolean k_exec
st_esito kst_esito


try 

	kst_esito = kguo_exception.inizializza(this.classname())

//--- Genera archivi STATISTICI
	k_exec = u_exec_sp( )
	if k_exec then
		kst_esito.SQLErrText = "Operazione conclusa Calendario aggiornato"
	else
		kst_esito.SQLErrText = "Operazione non eseguita. Il Calenario non è stato aggiornato."
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

public function boolean u_update () throws uo_exception;//
boolean k_return


	k_return = u_exec_sp( )


return k_return
end function

on kuf_calendar_working.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_calendar_working.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

