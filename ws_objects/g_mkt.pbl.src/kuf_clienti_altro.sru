$PBExportHeader$kuf_clienti_altro.sru
forward
global type kuf_clienti_altro from kuf_parent0
end type
end forward

global type kuf_clienti_altro from kuf_parent0
end type
global kuf_clienti_altro kuf_clienti_altro

type variables
//
public constant integer kki_e1_asn_ehvr01_nrord_si = 1

end variables

forward prototypes
public subroutine _readme ()
public function boolean tb_add (ref st_tab_clienti_altro kst_tab_clienti_altro) throws uo_exception
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function boolean tb_update (st_tab_clienti_altro kst_tab_clienti_altro) throws uo_exception
public subroutine if_isnull (st_tab_clienti_altro kst_tab_clienti_altro)
public function boolean if_esiste (st_tab_clienti_altro kst_tab_clienti_altro) throws uo_exception
public function boolean u_aggiona (st_tab_clienti_altro kst_tab_clienti_altro) throws uo_exception
public function boolean tb_delete (ref st_tab_clienti_altro kst_tab_clienti_altro) throws uo_exception
public function integer get_e1_asn_ehvr01 (ref st_tab_clienti_altro kst_tab_clienti_altro) throws uo_exception
public function boolean if_e1_asn_ehvr01_nrord_si (ref st_tab_clienti_altro kst_tab_clienti_altro) throws uo_exception
end prototypes

public subroutine _readme ();//
// tabella di integrazione dei CLIENTI, campi vari
end subroutine

public function boolean tb_add (ref st_tab_clienti_altro kst_tab_clienti_altro) throws uo_exception;// funzione che fa l'insert sulla tabella clienti_altro
boolean	k_return = false
st_esito kst_esito

	
try
	kst_esito = kguo_exception.inizializza(this.classname())

	if_sicurezza(kkg_flag_modalita.inserimento)

//--- imposto dati utente e data aggiornamento
	kst_tab_clienti_altro.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_clienti_altro.x_utente = kGuf_data_base.prendi_x_utente()
	
//--- toglie valori NULL
	if_isnull(kst_tab_clienti_altro)
	  
  	INSERT INTO clienti_altro  
			( id_cliente,   
			  e1_asn_ehvr01,   
			  x_datins,   
			  x_utente)  
  		VALUES ( 
			  :kst_tab_clienti_altro.id_cliente,   
			  :kst_tab_clienti_altro.e1_asn_ehvr01,   
			  :kst_tab_clienti_altro.x_datins,   
			  :kst_tab_clienti_altro.x_utente )  
		USING kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in inserimento dati di supporto cliente, cod. " + string(kst_tab_clienti_altro.id_cliente) + " (clienti_altro)~n~r" + trim(sqlca.SQLErrText) 
			kguo_exception.set_esito( kst_esito)
			if kst_tab_clienti_altro.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_altro.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if				
			throw kguo_exception
		end if
	else
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			if kst_tab_clienti_altro.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_altro.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			k_return = true
		end if
	end if

	
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
end try


return k_return

end function

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
boolean k_return
kuf_clienti kuf1_clienti

try
	kuf1_clienti = create kuf_clienti
	
	k_return = kuf1_clienti.if_sicurezza(ast_open_w)

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_clienti) then destroy kuf1_clienti
	
end try

return k_return
end function

public function boolean tb_update (st_tab_clienti_altro kst_tab_clienti_altro) throws uo_exception;//
//--- funzione che fa update sulla tabella clienti_altro
//
boolean	k_return = false
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())

	if_sicurezza(kkg_flag_modalita.modifica)

//--- imposto dati utente e data aggiornamento
	kst_tab_clienti_altro.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_clienti_altro.x_utente = kGuf_data_base.prendi_x_utente()

//--- toglie valori NULL
	if_isnull(kst_tab_clienti_altro)
  
	update clienti_altro  
	  set e1_asn_ehvr01 = :kst_tab_clienti_altro.e1_asn_ehvr01   
		  ,x_datins = :kst_tab_clienti_altro.x_datins
		  ,x_utente = :kst_tab_clienti_altro.x_utente 
		USING kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in aggiornamento dati di supporto cliente, cod. " + string(kst_tab_clienti_altro.id_cliente) + " (clienti_altro)~n~r" + trim(sqlca.SQLErrText) 
			kguo_exception.set_esito( kst_esito)
			if kst_tab_clienti_altro.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_altro.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if				
			throw kguo_exception
		end if
	else
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			if kst_tab_clienti_altro.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_altro.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			k_return = true
		end if
	end if

	
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
end try


return k_return

end function

public subroutine if_isnull (st_tab_clienti_altro kst_tab_clienti_altro);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_clienti_altro.id_cliente) then kst_tab_clienti_altro.id_cliente = 0
if isnull(kst_tab_clienti_altro.e1_asn_ehvr01) then kst_tab_clienti_altro.e1_asn_ehvr01 = 0

end subroutine

public function boolean if_esiste (st_tab_clienti_altro kst_tab_clienti_altro) throws uo_exception;// funzione che verifica l'esistenza del rek
boolean	k_return = false
int k_uno
st_esito kst_esito

	
try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if kst_tab_clienti_altro.id_cliente > 0 then

		select 1 
			into
				  :k_uno
			  from clienti_altro  
			  where id_cliente = :kst_tab_clienti_altro.id_cliente
			  using kguo_sqlca_db_magazzino;
	  
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in controllo esistenza dati di supporto cliente cod. " + string(kst_tab_clienti_altro.id_cliente) + " (clienti_altro)~n~r" + trim(sqlca.SQLErrText) 
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		else
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				if k_uno = 1 then
					k_return = true
				end if
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
end try


return k_return

end function

public function boolean u_aggiona (st_tab_clienti_altro kst_tab_clienti_altro) throws uo_exception;//
// Aggiorna dati
// insert / update /delete
//
boolean k_return 
st_esito kst_esito

	
try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if kst_tab_clienti_altro.id_cliente > 0 then

		if if_esiste(kst_tab_clienti_altro) then
			
			if kst_tab_clienti_altro.e1_asn_ehvr01 > 0 then
	  			k_return = tb_update(kst_tab_clienti_altro)
			else
				k_return = tb_delete(kst_tab_clienti_altro)
			end if
		else
			if kst_tab_clienti_altro.e1_asn_ehvr01 > 0 then
	  			k_return = tb_add(kst_tab_clienti_altro)
			end if
		end if
		
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Aggiornamento dati di supporto cliente non eseguita, manca il codice cliente."
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
end try


return k_return

end function

public function boolean tb_delete (ref st_tab_clienti_altro kst_tab_clienti_altro) throws uo_exception;//
//--- Cancellazione riga ina tabella clienti_altro
//
boolean	k_return = false
st_esito kst_esito

	
try
	kst_esito = kguo_exception.inizializza(this.classname())

	if_sicurezza(kkg_flag_modalita.modifica)
	  
  	delete from clienti_altro  
		where	id_cliente = :kst_tab_clienti_altro.id_cliente
		USING kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in cancellazione dati di supporto cliente, cod. " + string(kst_tab_clienti_altro.id_cliente) + " (clienti_altro)~n~r" + trim(sqlca.SQLErrText) 
			kguo_exception.set_esito( kst_esito)
			if kst_tab_clienti_altro.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_altro.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if				
			throw kguo_exception
		end if
	else
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			if kst_tab_clienti_altro.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_altro.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			k_return = true
		end if
	end if

	
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
end try


return k_return

end function

public function integer get_e1_asn_ehvr01 (ref st_tab_clienti_altro kst_tab_clienti_altro) throws uo_exception;//
//====================================================================
//=== Legge e1_asn_ehvr01 (dato da passare a E1) in tabella clienti_altro 
//=== 
//=== Input: st_tab_clienti_altro.id_cliente
//=== Out: st_tab_clienti_altro.e1_asn_ehvr01       
//=== Ritorna: e1_asn_ehvr01  
//=== 
//====================================================================
st_esito kst_esito
int k_return = 0


	kst_esito = kguo_exception.inizializza(this.classname())

  	SELECT
		  e1_asn_ehvr01
    INTO 
	 	  :kst_tab_clienti_altro.e1_asn_ehvr01
        FROM clienti_altro
        WHERE id_cliente = :kst_tab_clienti_altro.id_cliente
		using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura del tipo dati da passare a E1 in Altri dati Cliente codice " +string(kst_tab_clienti_altro.id_cliente) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
else
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_clienti_altro.e1_asn_ehvr01 > 0 then
			k_return =  kst_tab_clienti_altro.e1_asn_ehvr01
		end if
	end if
end if


return k_return



end function

public function boolean if_e1_asn_ehvr01_nrord_si (ref st_tab_clienti_altro kst_tab_clienti_altro) throws uo_exception;//
//------------------------------------------------------------------
//--- Verifica se passare a E1 il 'Numero Ordine'
//--- 
//--- Input: st_tab_clienti_altro.id_cliente
//--- Out:      
//--- Ritorna: TRUE ok passare il numero ordine  
//--- 
//------------------------------------------------------------------
boolean k_return


	get_e1_asn_ehvr01(kst_tab_clienti_altro)

	if kst_tab_clienti_altro.e1_asn_ehvr01 = kki_e1_asn_ehvr01_nrord_si then
		k_return = true
	end if


return k_return

end function

on kuf_clienti_altro.create
call super::create
end on

on kuf_clienti_altro.destroy
call super::destroy
end on

