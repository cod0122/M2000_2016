$PBExportHeader$kuf_alarm_instock_email.sru
forward
global type kuf_alarm_instock_email from kuf_parent
end type
end forward

global type kuf_alarm_instock_email from kuf_parent
end type
global kuf_alarm_instock_email kuf_alarm_instock_email

type variables
//--- attivo
constant string kki_attivo_si = "S"
constant string kki_attivo_no = "N"

//--- cartella allegati email avvisi interni
private string ki_path_alarm = ""

//--- modo di calcolo dei tempi di Giacenza: ki_calc_stocktime
constant int ki_calc_stocktime_by_data_ent = 1
constant int ki_calc_stocktime_by_certif_data = 5

end variables

forward prototypes
public subroutine _readme ()
public function long get_id_meca (ref st_tab_alarm_instock_email kst_tab_alarm_instock_email) throws uo_exception
public function datetime get_id_meca_last_generate (st_tab_alarm_instock_email kst_tab_alarm_instock_email) throws uo_exception
public subroutine if_isnull (ref st_tab_alarm_instock_email kst_tab_alarm_instock_email)
public function boolean tb_delete (st_tab_alarm_instock_email kst_tab_alarm_instock_email) throws uo_exception
public function long get_id_alarm_instock_email () throws uo_exception
public function long tb_add (ref st_tab_alarm_instock_email kst_tab_alarm_instock_email) throws uo_exception
public function boolean set_generated (ref st_tab_alarm_instock_email ast_tab_alarm_instock_email) throws uo_exception
public function boolean if_exists_x_id_meca (st_tab_alarm_instock_email ast_tab_alarm_instock_email) throws uo_exception
public subroutine tb_clear () throws uo_exception
end prototypes

public subroutine _readme ();//
//--- Contiene l'indice delle email generate degli avvisi di giacenza per evitare di riproporli
end subroutine

public function long get_id_meca (ref st_tab_alarm_instock_email kst_tab_alarm_instock_email) throws uo_exception;//
//---------------------------------------------------------------------------------
//--- 
//--- Leggo tabella alarm_instock_email per prendere il campo ID_MECA
//--- 
//--- input: st_tab_alarm_instock_email con valorizzato il campo id_alarm_instock_email
//--- out: id_meca
//--- Ritorna tab. ST_ESITO
//--- 
//---------------------------------------------------------------------------------
//
long k_return
st_esito kst_esito



kst_esito = kguo_exception.inizializza(this.classname())

if kst_tab_alarm_instock_email.id_alarm_instock_email > 0 then

  SELECT
         id_meca 
    INTO 
         :kst_tab_alarm_instock_email.id_meca 
    FROM alarm_instock_email  
	where id_alarm_instock_email = :kst_tab_alarm_instock_email.id_alarm_instock_email
	using kguo_sqlca_db_magazzino ;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
					"Errore in lettura id Lotto dalla tab. Avvisi per Lotti in Giacenza, id " &
					+ string(kst_tab_alarm_instock_email.id_alarm_instock_email))
		throw kguo_exception
	end if

	if kst_tab_alarm_instock_email.id_meca > 0 then
		k_return = kst_tab_alarm_instock_email.id_meca
	end if

end if


return k_return

end function

public function datetime get_id_meca_last_generate (st_tab_alarm_instock_email kst_tab_alarm_instock_email) throws uo_exception;//
//------------------------------------------------------------------------------
//--- 
//--- Presenza della riga in tabelle per ID
//--- 
//--- input: st_tab_alarm_instock_email con valorizzato il campo id_alarm_instock
//--- out: 
//--- Ritorna: l'ulima data di carico
//--- 
//------------------------------------------------------------------------------
//
datetime k_return
st_esito kst_esito



kst_esito = kguo_exception.inizializza(this.classname())

if kst_tab_alarm_instock_email.id_alarm_instock > 0 then
	SELECT max(generated)
	    INTO :kst_tab_alarm_instock_email.generated
   	 	FROM alarm_instock_email  
		where alarm_instock_email.id_alarm_instock = :kst_tab_alarm_instock_email.id_alarm_instock
		using kguo_sqlca_db_magazzino;
//		where alarm_instock_email.id_meca = :kst_tab_alarm_instock_email.id_meca

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultima generazione email di Allarme Giacenza Lotto id '" + string(kst_tab_alarm_instock_email.id_meca) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	if kst_tab_alarm_instock_email.generated > datetime(date(0), time(0)) then 
		k_return = kst_tab_alarm_instock_email.generated
	end if
else
	kst_esito.SQLErrText = "Manca id per leggere l'ultima generazione email di Allarme Giacenza Lotto, operazione non eseguita ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if


return k_return

end function

public subroutine if_isnull (ref st_tab_alarm_instock_email kst_tab_alarm_instock_email);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_alarm_instock_email.id_alarm_instock_email) then kst_tab_alarm_instock_email.id_alarm_instock_email = 0
if isnull(kst_tab_alarm_instock_email.id_alarm_instock) then kst_tab_alarm_instock_email.id_alarm_instock = 0
if isnull(kst_tab_alarm_instock_email.id_meca) then kst_tab_alarm_instock_email.id_meca = 0


end subroutine

public function boolean tb_delete (st_tab_alarm_instock_email kst_tab_alarm_instock_email) throws uo_exception;//
//------------------------------------------------------------------
//--- Cancella il rek in tabella 
//--- 
//--- Ritorna: true = cancellato
//---   
//------------------------------------------------------------------
boolean k_return
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	//if_sicurezza(kkg_flag_modalita.cancellazione)
	
	delete from st_tab_alarm_instock_email
			where id_alarm_instock_email = :kst_tab_alarm_instock_email.id_alarm_instock_email
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlCode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in cancellazione Avviso Giacenza Lotto id '" + string(kst_tab_alarm_instock_email.id_alarm_instock_email) + " ~n~r" +  trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		if kst_tab_alarm_instock_email.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_alarm_instock_email.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
				
	if kguo_sqlca_db_magazzino.sqlCode = 0 then
		if kst_tab_alarm_instock_email.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_alarm_instock_email.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		k_return = true
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
		
end try

return k_return
end function

public function long get_id_alarm_instock_email () throws uo_exception;/*
 Torna l'ultimo ID inserito 
 	inp: 
   ret: max id
*/
long k_return


	kguo_exception.inizializza(this.classname())

	SELECT max(id_alarm_instock_email)
		 INTO 
				:k_return
		 FROM alarm_instock_email  
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
						 "Errore in lettura ultimo ID Avviso di Giacenza Lotti (alarm_instock_email)")
		throw kguo_exception
	end if

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if isnull(k_return) then k_return = 0
	else
		k_return = 0
	end if
	

return k_return

end function

public function long tb_add (ref st_tab_alarm_instock_email kst_tab_alarm_instock_email) throws uo_exception;//
//------------------------------------------------------------------
//--- Add rek in tabella 
//--- 
//--- Ritorna: id
//---   
//------------------------------------------------------------------
long k_return
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if_isnull(kst_tab_alarm_instock_email)
	
	//if_sicurezza(kkg_flag_modalita.cancellazione)
	
	kst_tab_alarm_instock_email.generated = kGuf_data_base.prendi_x_datins()

	kst_tab_alarm_instock_email.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_alarm_instock_email.x_utente = kGuf_data_base.prendi_x_utente()
	
   INSERT INTO alarm_instock_email  
         ( 
           id_alarm_instock,   
           id_meca,   
           generated,   
           x_datins,   
           x_utente )  
  VALUES ( 
           :kst_tab_alarm_instock_email.id_alarm_instock,   
           :kst_tab_alarm_instock_email.id_meca,   
           :kst_tab_alarm_instock_email.generated,   
           :kst_tab_alarm_instock_email.x_datins,   
           :kst_tab_alarm_instock_email.x_utente ) 
	  using kguo_sqlca_db_magazzino ;

	if kguo_sqlca_db_magazzino.sqlCode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in inserimento Avviso Giacenza Lotto id '" &
														+ string(kst_tab_alarm_instock_email.id_meca) + "', id allarme: '" &
														+ string(kst_tab_alarm_instock_email.id_alarm_instock_email) + "' " &
														+ kkg.acapo +  trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		if kst_tab_alarm_instock_email.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_alarm_instock_email.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
				
	if kguo_sqlca_db_magazzino.sqlCode = 0 then
		if kst_tab_alarm_instock_email.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_alarm_instock_email.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		kst_tab_alarm_instock_email.id_alarm_instock_email = get_id_alarm_instock_email()
		if kst_tab_alarm_instock_email.id_alarm_instock_email > 0 then
			k_return = kst_tab_alarm_instock_email.id_alarm_instock_email 
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
		
end try

return k_return
end function

public function boolean set_generated (ref st_tab_alarm_instock_email ast_tab_alarm_instock_email) throws uo_exception;//
//====================================================================
//=== Aggiorna la data/ora dell'invio nella tabella email_invio 
//=== 
//=== Ritorna TRUE=ok
//===   
//====================================================================
boolean k_return
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	//if_sicurezza(kkg_flag_modalita.inserimento)

	ast_tab_alarm_instock_email.generated = kGuf_data_base.prendi_x_datins()
	ast_tab_alarm_instock_email.x_datins = kGuf_data_base.prendi_x_datins()
	ast_tab_alarm_instock_email.x_utente = kGuf_data_base.prendi_x_utente()

	update alarm_instock_email
			set generated = :ast_tab_alarm_instock_email.generated
				,  x_datins = :ast_tab_alarm_instock_email.x_datins
				,  x_utente = :ast_tab_alarm_instock_email.x_utente
			where id_alarm_instock = :ast_tab_alarm_instock_email.id_alarm_instock
			using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlCode < 0 then

		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante Aggiornamento data di generazione Email di Giacenza Lotto (id alarm: " &
								+ string(ast_tab_alarm_instock_email.id_alarm_instock) &
								+ ").~n~r" +  trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		
		if ast_tab_alarm_instock_email.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_alarm_instock_email.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if

		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if
	
	if kguo_sqlca_db_magazzino.sqlCode = 0 then
		
		if ast_tab_alarm_instock_email.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_alarm_instock_email.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if

		k_return = true
	end if

return k_return
end function

public function boolean if_exists_x_id_meca (st_tab_alarm_instock_email ast_tab_alarm_instock_email) throws uo_exception;//
//------------------------------------------------------------------------------
//--- 
//--- Veirifica se già generato ID LOTTO e ALARM
//--- 
//--- input: st_tab_alarm_instock_email con valorizzato il campo id_meca + id_alarm_instock
//--- out: 
//--- Ritorna: l'ulima data di carico
//--- 
//------------------------------------------------------------------------------
//
boolean k_return
integer w_ok
st_esito kst_esito



kst_esito = kguo_exception.inizializza(this.classname())

if ast_tab_alarm_instock_email.id_meca > 0 then
	SELECT 1
	    INTO :w_ok
   	 	FROM alarm_instock_email  
		where alarm_instock_email.id_alarm_instock = :ast_tab_alarm_instock_email.id_alarm_instock
					and alarm_instock_email.id_meca = :ast_tab_alarm_instock_email.id_meca
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in verifica esistenza generazione email di Allarme Giacenza Lotto id Lotto '" &
									+ string(ast_tab_alarm_instock_email.id_meca) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) &
									+ " per id Alarm '" + string(ast_tab_alarm_instock_email.id_alarm_instock) &
									+ "' ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	if w_ok > 0 then 
		k_return = true
	end if
else
	kst_esito.SQLErrText = "Manca id Lotto per in verifica esistenza email di Allarme Giacenza Lotto, operazione non eseguita ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if


return k_return

end function

public subroutine tb_clear () throws uo_exception;//
//------------------------------------------------------------------
//--- Pulisce tabella dei record inutili
//--- 
//--- Ritorna: true = cancellato
//---   
//------------------------------------------------------------------
datetime k_datetime


try
	kguo_exception.inizializza(this.classname())
	k_datetime = datetime(relativedate(today(), - 90))
	
	delete from st_tab_alarm_instock_email
			where x_datins < :k_datetime
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlCode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore durante pulizia righe inutili dalla tabella Avvisi di Giacenza Lotti.")
		throw kguo_exception
	end if
				
	if kguo_sqlca_db_magazzino.sqlCode = 0 then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
		
end try


end subroutine

on kuf_alarm_instock_email.create
call super::create
end on

on kuf_alarm_instock_email.destroy
call super::destroy
end on

event constructor;call super::constructor;//
ki_path_alarm = kguo_path.get_doc_root( ) + kkg.path_sep + "alarm" + kkg.path_sep
end event

