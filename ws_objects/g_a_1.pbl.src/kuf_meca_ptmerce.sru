$PBExportHeader$kuf_meca_ptmerce.sru
forward
global type kuf_meca_ptmerce from kuf_parent
end type
end forward

global type kuf_meca_ptmerce from kuf_parent
end type
global kuf_meca_ptmerce kuf_meca_ptmerce

type variables
//
private kuf_armo kiuf_armo
private kuf_email_invio kiuf_email_invio
private kuf_email_funzioni kiuf_email_funzioni
private kuf_email kiuf_email
private kuf_clienti kiuf_clienti 
private kuf_ausiliari kiuf1_ausiliari
private kuf_msg_replace_placeholder kiuf_msg_replace_placeholder


end variables

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function datetime tb_add (st_tab_meca_ptmerce ast_tab_meca_ptmerce) throws uo_exception
public function long get_id_email_invio (st_tab_meca_ptmerce ast_tab_meca_ptmerce) throws uo_exception
public subroutine set_id_email_invio (st_tab_meca_ptmerce ast_tab_meca_ptmerce) throws uo_exception
public function long u_add_email_invio () throws uo_exception
public function date tb_pulizia () throws uo_exception
public function boolean if_esiste (st_tab_meca_ptmerce ast_tab_meca_ptmerce) throws uo_exception
public function boolean tb_delete (st_tab_meca_ptmerce ast_tab_meca_ptmerce) throws uo_exception
public function st_esito u_batch_run () throws uo_exception
private function long u_add_email_invio_1 (ref st_tab_meca ast_tab_meca) throws uo_exception
private subroutine u_create_kuif ()
private function string get_path_email_ptmerce () throws uo_exception
private function string u_build_email_attach_label (st_tab_meca ast_tab_meca) throws uo_exception
private function string u_get_oggetto_no_placeholder (st_tab_meca ast_tab_meca, st_tab_email_invio ast_tab_email_invio) throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return true

 
end function

public function datetime tb_add (st_tab_meca_ptmerce ast_tab_meca_ptmerce) throws uo_exception;//
//====================================================================
//=== Aggiunge il rek nella tabella 'PRONTO MERCE'  MECA_PTMERCE 
//=== 
//=== Inp: ast_tab_meca_ptmerce id_meca
//=== Ritorna: data ora di inserimento 
//=== Lancia EXCEPTION
//===  
//====================================================================
//
datetime k_return 
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

//	if_sicurezza(kkg_flag_modalita.inserimento)

	if ast_tab_meca_ptmerce.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Generazione avviso nel 'Pronto Merce' interrotta, manca ID del Lotto"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if if_esiste(ast_tab_meca_ptmerce) then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Avviso 'Pronto Merce' scartato perchè già registrato in archivio (Lotto id " + string(ast_tab_meca_ptmerce.id_meca) + ")."
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	ast_tab_meca_ptmerce.id_email_invio = 0 
	ast_tab_meca_ptmerce.dtins = kGuf_data_base.prendi_x_datins()
	
//--- imposto dati utente e data aggiornamento
	ast_tab_meca_ptmerce.x_datins = kGuf_data_base.prendi_x_datins()
	ast_tab_meca_ptmerce.x_utente = kGuf_data_base.prendi_x_utente()
	
	INSERT INTO meca_ptmerce  
				( id_meca,   
				  id_email_invio,   
				  dtins,   
				  x_datins,   
				  x_utente )  
		VALUES (    
				  :ast_tab_meca_ptmerce.id_meca
				  ,:ast_tab_meca_ptmerce.id_email_invio
				  ,:ast_tab_meca_ptmerce.dtins
				  ,:ast_tab_meca_ptmerce.x_datins   
				  ,:ast_tab_meca_ptmerce.x_utente ) 
			using kguo_sqlca_db_magazzino;
		

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Inserimento 'Pronto Merce' in errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	
	else
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			
			k_return = ast_tab_meca_ptmerce.dtins

		end if
	end if
	
//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		if ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
	else
		if ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if
	
	

return k_return

end function

public function long get_id_email_invio (st_tab_meca_ptmerce ast_tab_meca_ptmerce) throws uo_exception;//
//====================================================================
//=== Legge id_email_invio in tabella 'PRONTO MERCE'  MECA_PTMERCE 
//=== 
//=== Inp: ast_tab_meca_ptmerce id_meca 
//=== Ritorna: id_email_invio
//=== Lancia EXCEPTION
//===  
//====================================================================
//
long k_return 
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	if_sicurezza(kkg_flag_modalita.modifica)

	if ast_tab_meca_ptmerce.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di lettura in 'Pronto Merce' del ID di invio email interrotta, manca ID del Lotto"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	select id_email_invio
	   into :ast_tab_meca_ptmerce.id_email_invio
		from meca_ptmerce  
		where id_meca = :ast_tab_meca_ptmerce.id_meca
			using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura in 'Pronto Merce' del valore 'ID di invio email' in errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	
	else
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			if ast_tab_meca_ptmerce.id_email_invio > 0 then
				k_return = ast_tab_meca_ptmerce.id_email_invio
			end if
		end if
	end if


return k_return

end function

public subroutine set_id_email_invio (st_tab_meca_ptmerce ast_tab_meca_ptmerce) throws uo_exception;//
//====================================================================
//=== Imposta id_email_invio in tabella 'PRONTO MERCE'  MECA_PTMERCE 
//=== 
//=== Inp: ast_tab_meca_ptmerce id_meca e id_email_invio
//=== Ritorna: 
//=== Lancia EXCEPTION
//===  
//====================================================================
//
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	if_sicurezza(kkg_flag_modalita.modifica)

	if ast_tab_meca_ptmerce.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di inserimento in 'Pronto Merce' del ID di invio email interrotta, manca ID del Lotto"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	if ast_tab_meca_ptmerce.id_email_invio > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di inserimento in 'Pronto Merce' del ID di invio email interrotta, manca ID invio email"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- imposto dati utente e data aggiornamento
	ast_tab_meca_ptmerce.x_datins = kGuf_data_base.prendi_x_datins()
	ast_tab_meca_ptmerce.x_utente = kGuf_data_base.prendi_x_utente()
	
	update meca_ptmerce  
				  set id_email_invio = :ast_tab_meca_ptmerce.id_email_invio
		where id_meca = :ast_tab_meca_ptmerce.id_meca
			using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Aggiornamento in 'Pronto Merce' del valore 'ID di invio email' in errore " + "~n~r" &
		                                  + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	
	end if
	
//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		if ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
	else
		if ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if



end subroutine

public function long u_add_email_invio () throws uo_exception;/*
 Carica Avvisi del Pronto Merce tab Email-Invio che non hanno ancora la email (scarta i clienti che non hanno l'indirizzo)
	 Rit: nr di email caricate 
*/
long k_return 
long k_row, k_righe, k_righe_daelab, k_row100, k_row_ds, k_rc, k_row_ptmerce
datetime k_datetime
boolean k_ds_1_to_update
st_tab_meca_ptmerce kst_tab_meca_ptmerce[], kst_tab_meca_ptmerce_vuoto[]
st_tab_meca kst_tab_meca
uo_ds_std_1 kds_1


try
	kguo_exception.inizializza(this.classname())
	
	kds_1 = create uo_ds_std_1
	kds_1.dataobject = "ds_meca_ptmerce_noemail"
	kds_1.settransobject( kguo_sqlca_db_magazzino )
	k_righe = kds_1.retrieve() // estrazione avvisi senza ancora il id_email_invio
	
	for k_row = 1 to k_righe
		
//--- Aggiorna non più di 100 righe alla volta...		
		if (k_righe - k_row) < 100 then
			k_righe_daelab = k_righe - k_row
		else
			k_righe_daelab = 100 - 1
		end if
		k_row100 = k_row + k_righe_daelab 
		
		k_row_ptmerce = 0
		kst_tab_meca_ptmerce[] = kst_tab_meca_ptmerce_vuoto[]
		
		for k_row_ds = k_row to k_row100
			
			k_row_ptmerce ++
//--- Prepara l'array per popolare la tabella email
			kst_tab_meca_ptmerce[k_row_ptmerce].id_meca = kds_1.getitemnumber( k_row_ds, "id_meca")
			
			kst_tab_meca.id =  kst_tab_meca_ptmerce[k_row_ptmerce].id_meca
			kst_tab_meca_ptmerce[k_row_ptmerce].st_tab_g_0.esegui_commit = "N"
			kst_tab_meca_ptmerce[k_row_ptmerce].id_email_invio = u_add_email_invio_1(kst_tab_meca) // ADD EMAIL
			
		next
		
//--- Imposta id email invio in pronto merce 
		k_ds_1_to_update = false
		k_row_ptmerce = 0
		for k_row_ds = k_row to k_row100
			k_row_ptmerce ++
			if kst_tab_meca_ptmerce[k_row_ptmerce].id_email_invio > 0 then  // ID invio email valorizzato?
				k_ds_1_to_update = true
				k_return ++
				kds_1.setitem(k_row_ds, "id_email_invio", kst_tab_meca_ptmerce[k_row_ptmerce].id_email_invio)
				kds_1.setitem(k_row_ds, "x_datins", kGuf_data_base.prendi_x_datins())
				kds_1.setitem(k_row_ds, "x_utente", kGuf_data_base.prendi_x_utente())
			//else
			//	kds_1.setitem(k_row_ds, "id_email_invio", 0)
			end if
		next
		
		if k_ds_1_to_update then
			k_rc = kds_1.update( )  // AGGIORNA ID_EMAIL_INVIO!!
			if k_rc > 0 then
				kguo_sqlca_db_magazzino.db_commit( )
			else
				kguo_exception.set_st_esito_err_ds(kds_1, "Errore in caricamento nuove avviso email di Pronto Merce. Il primo ID Lotto era " + string(kds_1.getitemnumber(k_row, "id_meca")))
				kguo_sqlca_db_magazzino.db_rollback( )
				throw kguo_exception
			end if
		end if
		
		k_row = k_row_ds - 1
	next
	
//--- Rimuove le righe vecchie dalla tabella Avvisi
	tb_pulizia( )
	
	
catch (uo_exception kuo_exception) 
	kguo_sqlca_db_magazzino.db_rollback( )
	throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1

end try

		
return k_return
end function

public function date tb_pulizia () throws uo_exception;//
//====================================================================
//=== Rimuove i rek non più utili dal 'PRONTO MERCE'  MECA_PTMERCE 
//=== 
//=== Inp: 
//=== Ritorna: data di rimozione
//=== Lancia EXCEPTION
//===  
//====================================================================
//
date k_return  
st_tab_meca_ptmerce kst_tab_meca_ptmerce
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())
//	if_sicurezza(kkg_flag_modalita.inserimento)

//--- Fissa la data datta quale fare la pulizia della tabella
	kst_tab_meca_ptmerce.dtins = datetime(relativedate(date(kGuf_data_base.prendi_x_datins()), -180), time(0))

	DELETE FROM meca_ptmerce  
			where dtins < :kst_tab_meca_ptmerce.dtins
			using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Rimozione dati 'Pronto Merce' dal " + string(kst_tab_meca_ptmerce.dtins) + " in errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko

	else
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			
			k_return = date(kst_tab_meca_ptmerce.dtins)

		end if
	end if
	
//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		kguo_sqlca_db_magazzino.db_rollback( )
	else
		kguo_sqlca_db_magazzino.db_commit( )
	end if


return k_return

end function

public function boolean if_esiste (st_tab_meca_ptmerce ast_tab_meca_ptmerce) throws uo_exception;//
//====================================================================
//=== Verifica se Lotto già in tabella 'PRONTO MERCE'  MECA_PTMERCE 
//=== 
//=== Inp: ast_tab_meca_ptmerce id_meca 
//=== Ritorna: TRUE = presente, FALSE = assente
//=== Lancia EXCEPTION
//===  
//====================================================================
//
boolean k_return = false
st_esito kst_esito
st_tab_meca_ptmerce kst_tab_meca_ptmerce


	kst_esito = kguo_exception.inizializza(this.classname())

//	if_sicurezza(kkg_flag_modalita.modifica)

	if ast_tab_meca_ptmerce.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di verifica esistenza in 'Pronto Merce' interrotta, manca ID del Lotto"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	select id_meca
	   into :kst_tab_meca_ptmerce.id_meca
	   from meca_ptmerce  
		where id_meca = :ast_tab_meca_ptmerce.id_meca
		using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	else
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			k_return = false
		else
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Verifica presenza in 'Pronto Merce' del Lotto con ID: "+ string(ast_tab_meca_ptmerce.id_meca) + " errore " + "~n~r" &
														 + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
	end if

return k_return 

end function

public function boolean tb_delete (st_tab_meca_ptmerce ast_tab_meca_ptmerce) throws uo_exception;//
//====================================================================
//=== Rimuove il rek nella tabella 'PRONTO MERCE'  MECA_PTMERCE 
//=== 
//=== Inp: ast_tab_meca_ptmerce id_meca
//=== Ritorna: TRUE = OK
//=== Lancia EXCEPTION
//===  
//====================================================================
//
boolean k_return 
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//	if_sicurezza(kkg_flag_modalita.inserimento)

	if ast_tab_meca_ptmerce.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di Rimozione 'Pronto Merce' interrotta, manca ID del Lotto"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	DELETE FROM meca_ptmerce  
			where id_meca = :ast_tab_meca_ptmerce.id_meca
			using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Rimozione 'Pronto Merce' del Lotto id " + string(ast_tab_meca_ptmerce.id_meca) + " in errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	
	else
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			
			k_return = true

		end if
	end if
	
//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		if ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
	else
		if ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if
	
	
return k_return

end function

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
int k_ctr
st_esito kst_esito


try 

	kst_esito = kguo_exception.inizializza(this.classname())

//--- Carica Avvisi Pronto Merce tab Email da Inviare
	k_ctr = u_add_email_invio( )
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Operazione conclusa correttamente." &
									+ "Sono stati caricati " + string(k_ctr) + " avvisi di 'Pronto Merce' in tabella 'email da inviare'." 
	else
		kst_esito.SQLErrText = "Operazione conclusa.  Nessuno nuovo Avviso di Pronto Merce caricato in tabella 'email da inviare'."
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

private function long u_add_email_invio_1 (ref st_tab_meca ast_tab_meca) throws uo_exception;//------------------------------------------------------------------------------------------------------------------------
//--- Fa il Carico nella tabella email-invio 
//--- Inp: st_tab_meca valorizzata con i campi necessari
//--- Out: il ID del email_invio se nuovo altrimenti ZERO
//------------------------------------------------------------------------------------------------------------------------
//
long k_return=0 
string k_file_attached
boolean k_pagamento_anticipato
st_tab_clienti kst_tab_clienti
st_tab_clienti_web kst_tab_clienti_web
st_tab_email_invio kst_tab_email_invio
st_tab_email kst_tab_email
st_tab_email_funzioni kst_tab_email_funzioni
st_msg_replace_placeholder kst_msg_replace_placeholder
st_tab_pagam kst_tab_pagam
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())

	u_create_kuif( ) // create oggetti kuf di istanza

	if ast_tab_meca.id > 0 then 
	else
		kguo_exception.inizializza( )
		kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_non_eseguito )
		kguo_exception.set_nome_oggetto(this.classname( ) )
		kguo_exception.setmessage( "Manca id Lotto. Generazione e-mail non eseguita. ")
		throw kguo_exception
	end if

//--- get dei codici clienti + num_int ecc... + dati E1 tipo WO, SO, ...
	kiuf_armo.get_dati_rid(ast_tab_meca)

//--- get dell'indirizzo e-mail del cliente
	kst_tab_clienti_web.id_cliente = ast_tab_meca.clie_3
	
	//--- email addresses
	kst_tab_email_invio.email = kiuf_clienti.get_email_prontomerce(kst_tab_clienti_web)
	if trim(kst_tab_email.email_to) > " " then
		kst_tab_email_invio.email += ";" + trim(kst_tab_email.email_to) 
	end if
	kst_tab_email_invio.email_cc = trim(kst_tab_email.email_cc) 
	kst_tab_email_invio.email_ccn = trim(kst_tab_email.email_ccn)

	kst_tab_clienti.codice = ast_tab_meca.clie_3

	kiuf_clienti.get_id_nazione(kst_tab_clienti)
	if kst_tab_clienti.id_nazione_1 > " " and kst_tab_clienti.id_nazione_1 <> "IT" and kst_tab_clienti.id_nazione_1 <> "SM" then
		kst_tab_email_invio.lang = "EN"
	else
		kst_tab_email_invio.lang = ""
	end if
	
//--- se e-mail NON impostata sul cliente NON invio nulla!!!
	if trim(kst_tab_email_invio.email) > " " then
		
		kst_tab_email_invio.id_cliente =  ast_tab_meca.clie_3
		kst_tab_email_invio.allegati_cartella = ""			
		kst_tab_email_invio.cod_funzione = kiuf_email_funzioni.kki_cod_funzione_prontomerce  // INFO che è un PRONTO MERCE
	
//--- get del Prototipo della e-mail
		kst_tab_email_funzioni.cod_funzione = kst_tab_email_invio.cod_funzione
		kst_tab_email.id_email = kiuf_email_funzioni.get_id_email_xcodfunzione(kst_tab_email_funzioni)
		if kst_tab_email.id_email = 0 then
			kguo_exception.inizializza(this.classname() )
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_not_fnd )
			kguo_exception.setmessage( "Impostare da 'Proprietà della Procedura' il Prototipo e-mail da utilizzare per l'invio codificato come '" &
						+ trim(kst_tab_email_funzioni.cod_funzione) &
						+ " '(" + kiuf_email_funzioni.get_des(kst_tab_email_funzioni) + ")")
			//kguo_exception.setmessage( "Impostare da 'Proprietà della Procedura' il Prototipo e-mail da utilizzare per l'invio funzionale '" + trim(kst_tab_email_funzioni.cod_funzione)+"' (Pronto merce)")
			throw kguo_exception
		end if

//quiii		k_file_attached = u_build_email_attach_label(ast_tab_meca) //  label con barcode da allegare alla email		
		if trim(k_file_attached) > " " then
			kst_tab_email_invio.allegati_pathfile = trim(k_file_attached)
		end if
	
//--- recupero diversi dati x riempire la tab email-invio			
		kiuf_email.get_riga(kst_tab_email)
		
		if kst_tab_email_invio.lang = "EN" then
			kst_tab_email_invio.oggetto = kst_tab_email.oggetto_lang
		else
			kst_tab_email_invio.oggetto = kst_tab_email.oggetto
		end if
		kst_tab_email_invio.link_lettera = kst_tab_email.link_lettera
		kst_tab_email_invio.flg_lettera_html = kst_tab_email.flg_lettera_html
		kst_tab_email_invio.flg_ritorno_ricev = kst_tab_email.flg_ritorno_ricev
		kst_tab_email_invio.email_di_ritorno = kst_tab_email.email_di_ritorno
		kst_tab_email_invio.invio_batch = kst_tab_email.invio_batch
		kst_tab_email_invio.id_oggetto = ast_tab_meca.id
		if kst_tab_email.attached > " " then
			if trim(kst_tab_email_invio.allegati_pathfile) > " " then
				kst_tab_email_invio.allegati_pathfile += ";" + kst_tab_email.attached  // aggiunge allegato a un precedente
			else
				kst_tab_email_invio.allegati_pathfile = kst_tab_email.attached
			end if
		end if
		
		if trim(kst_tab_email_invio.allegati_pathfile) > " " then
			kst_tab_email_invio.flg_allegati = kiuf_email_invio.ki_allegati_si
		else
			kst_tab_email_invio.flg_allegati = kiuf_email_invio.ki_allegati_no
		end if
		
		kiuf_email_invio.if_isnull(kst_tab_email_invio)

//--- get del DDT mandante		
		kiuf_armo.get_num_bolla_in(ast_tab_meca)
		
//--- Composizione dell'OGGETTO: 
		kst_msg_replace_placeholder.msg = kst_tab_email_invio.oggetto
		if kiuf_msg_replace_placeholder.u_check_placeholder(kst_msg_replace_placeholder) = 0 then
//--- Se non ci sono segnaposti, somma alla dicitura del Prototipo il ddt del mandante a anche il Nome del Ricevente quando cliente diverso 
			kst_tab_email_invio.oggetto = u_get_oggetto_no_placeholder(ast_tab_meca, kst_tab_email_invio)
		else
			kst_msg_replace_placeholder.id_meca = ast_tab_meca.id
			if kst_msg_replace_placeholder.id_meca > 0 then
				kst_tab_email_invio.oggetto = kiuf_msg_replace_placeholder.u_message_replace_placeholder(kst_msg_replace_placeholder)
			end if
		end if

//--- verifica se il cliente ha un pagamento ANTICIPATO xchè è da segnalare
		if not isvalid(kiuf1_ausiliari) then kiuf1_ausiliari = create kuf_ausiliari
		kiuf_clienti.get_cod_pag(kst_tab_clienti)
		if kst_tab_clienti.COD_PAG > 0 then
			kst_tab_pagam.codice = kst_tab_clienti.COD_PAG
			if kiuf1_ausiliari.tb_pagam_if_pag_anticipato(kst_tab_pagam) then
				kst_tab_email_invio.note = "RICHIESTO PAGAMENTO ANTICIPATO (" + string(kst_tab_pagam.codice) + ") per "
			end if
		end if

//--- note interne
		kst_tab_email_invio.note = "Lotto " + string(ast_tab_meca.num_int) + "  " +  string(ast_tab_meca.data_int) + "   id " + string(ast_tab_meca.id) + " "  
		if kst_tab_email_invio.id_cliente <> ast_tab_meca.clie_1 and ast_tab_meca.clie_1 > 0 then // se cliente mandante diverso aggiungo il nome
			kst_tab_clienti.codice = ast_tab_meca.clie_1
			kiuf_clienti.get_nome(kst_tab_clienti)
			kst_tab_email_invio.note += ", Mand. " + trim(kst_tab_clienti.rag_soc_10) + " (" + string(ast_tab_meca.clie_1) + ")"
		end if
		kst_tab_email_invio.note += " (generato dalla Convalida dosimetrica)."
		                              
		kst_tab_email_invio.st_tab_g_0.esegui_commit = ast_tab_meca.st_tab_g_0.esegui_commit
		
		k_return = kiuf_email_invio.u_add_email(kst_tab_email_invio)  // Carico EMAIL per l'invio

	end if
	
catch (uo_exception kuo_exception)	
	kuo_exception.scrivi_log()
	throw kuo_exception
	
finally
	
end try



return k_return

end function

private subroutine u_create_kuif ();//	
	if NOT isvalid(kiuf_armo) then kiuf_armo = create kuf_armo
	if NOT isvalid(kiuf_email_invio) then kiuf_email_invio = create kuf_email_invio
	if NOT isvalid(kiuf_email) then kiuf_email = create kuf_email
	if NOT isvalid(kiuf_email_funzioni) then kiuf_email_funzioni = create kuf_email_funzioni
	if NOT isvalid(kiuf_clienti) then kiuf_clienti = create kuf_clienti
	if NOT isvalid(kiuf_msg_replace_placeholder) then kiuf_msg_replace_placeholder = create kuf_msg_replace_placeholder

end subroutine

private function string get_path_email_ptmerce () throws uo_exception;//----------------------------------------------------------------------
//--- Torna il PATH per allegati al Pronto Merce
//---
//--- input: 
//--- Rit: string array = path 
//---
//--- Lancia EXCEPTION
//---
//----------------------------------------------------------------------
string k_return
string k_path_interno
st_esito kst_esito


try

	kst_esito = kguo_exception.inizializza(this.classname())

//--- Path x uso interno sempre presente 
	k_path_interno = kguo_path.get_doc_root_interno() 
					
	k_return = k_path_interno + KKG.PATH_SEP + "ptmerce"

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	
finally
	
end try
			

return k_return[]

end function

private function string u_build_email_attach_label (st_tab_meca ast_tab_meca) throws uo_exception;//
//--- Fabbrica l'allegato alla email (label con barcode)
//--- inp: st_tab_meca.id
//--- out: file (path compreso) dell'allegato
//
string k_return
string k_path_attach_label_email, k_filename_attach_label_email
int k_rc
datastore kds_d_meca_ptmerce_labelaccept
kuf_file_explorer kuf1_file_explorer


try
	
	kguo_exception.inizializza(this.classname())
	
	if ast_tab_meca.id > 0 then

		kds_d_meca_ptmerce_labelaccept = create datastore
		kds_d_meca_ptmerce_labelaccept.dataobject = "d_meca_ptmerce_labelaccept"
		kds_d_meca_ptmerce_labelaccept.settransobject(kguo_sqlca_db_magazzino)

//--- dimensiona la label
		kds_d_meca_ptmerce_labelaccept.Object.DataWindow.Export.PDF.NativePDF.UsePrintSpec = 'No'
		kds_d_meca_ptmerce_labelaccept.Object.DataWindow.Export.PDF.Method = NativePDF!
		kds_d_meca_ptmerce_labelaccept.Object.DataWindow.Export.PDF.NativePDF.ImageFormat = '1' //BMP
		kds_d_meca_ptmerce_labelaccept.Modify("DataWindow.Print.Paper.Size=256") // 256 = in cm, 255= in inch
		kds_d_meca_ptmerce_labelaccept.Modify("DataWindow.Print.CustomPage.Length=110") //es. 11,2 cm
		kds_d_meca_ptmerce_labelaccept.Modify("DataWindow.Print.CustomPage.Width=120") 	

//--- Produce allegato
		k_rc = kds_d_meca_ptmerce_labelaccept.retrieve(ast_tab_meca.id)
		if k_rc <= 0 then
			kguo_exception.kist_esito.sqlcode = k_rc
			kguo_exception.kist_esito.sqlerrtext = "Errore in fabbricazione label per il Pronto Merce dal ds: '" &
			                         + trim(kds_d_meca_ptmerce_labelaccept.dataobject) + "' per ID Lotto " &
											 + string(ast_tab_meca.id)
			kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_db_ko
			throw kguo_exception
		end if
	
//--- path per l'allegato alla email
		k_path_attach_label_email = get_path_email_ptmerce( )
		k_filename_attach_label_email = "labelpickup_" + string(ast_tab_meca.num_int, "#") + "_" + string(kguo_g.get_datetime_current( ), "yyyymmddhhmm") + ".pdf"

		kuf1_file_explorer = create kuf_file_explorer
		if not kuf1_file_explorer.u_directory_create(k_path_attach_label_email) then
			kguo_exception.kist_esito.sqlcode = k_rc
			kguo_exception.kist_esito.sqlerrtext = "Errore in accesso cartella per registrare l'allegato al Pronto Merce. Cartella '" &
			                         + trim(k_path_attach_label_email) + "' per ID Lotto " &
											 + string(ast_tab_meca.id)
			kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_non_eseguito
			throw kguo_exception
		end if

		k_return = k_path_attach_label_email + kkg.path_sep + k_filename_attach_label_email

		if kds_d_meca_ptmerce_labelaccept.saveas(k_return, PDF!, true) > 0 then
		else
			kguo_exception.kist_esito.sqlcode = k_rc
			kguo_exception.kist_esito.sqlerrtext = "Errore in generazione allegato (pdf) al Pronto Merce. File '" &
			                         + trim(k_return) + "' per ID Lotto " &
											 + string(ast_tab_meca.id)
			kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_non_eseguito
			throw kguo_exception
		end if
		
	end if

catch (uo_exception kuo_exception)
	k_return = ""
	kuo_exception.scrivi_log( )
	
finally
	if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
	
end try
	
return k_return	
end function

private function string u_get_oggetto_no_placeholder (st_tab_meca ast_tab_meca, st_tab_email_invio ast_tab_email_invio) throws uo_exception;//------------------------------------------------------------------------------------------------------------------------
//--- Fa il Carico nella tabella email-invio 
//--- Inp: st_tab_meca e st_tab_email_invio valorizzate con i campi necessari
//--- Rit: Oggetto compilato
//------------------------------------------------------------------------------------------------------------------------
//
string k_return
st_tab_clienti kst_tab_clienti
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())

	u_create_kuif( ) // create oggetti kuf di istanza se necessario

//--- Composizione dell'OGGETTO: somma alla dicitura del Prototipo il ddt del mandante a anche il Nome del Ricevente quando cliente diverso 
	if ast_tab_meca.num_bolla_in > " " then
		if ast_tab_email_invio.lang = "EN" then
			ast_tab_email_invio.oggetto += " related to delivery Notes # "
		else
			ast_tab_email_invio.oggetto += " D.D.T. n. "
		end if
		ast_tab_email_invio.oggetto += trim(ast_tab_meca.num_bolla_in)
		if ast_tab_meca.data_bolla_in > date(0) then
			if ast_tab_email_invio.lang = "EN" then
				ast_tab_email_invio.oggetto += " of "
			else
				ast_tab_email_invio.oggetto += " del "
			end if
			ast_tab_email_invio.oggetto += string(ast_tab_meca.data_bolla_in, "dd mmm yyyy")
		end if
	end if
	if ast_tab_meca.num_int > 0 then
		if ast_tab_email_invio.lang = "EN" then
			ast_tab_email_invio.oggetto += " reference "
		else
			ast_tab_email_invio.oggetto += " rif. interno " 
		end if
		ast_tab_email_invio.oggetto += string(ast_tab_meca.num_int) //20201117 + " (" + string(ast_tab_meca.clie_2) + ")"
	end if
	if ast_tab_email_invio.id_cliente <> ast_tab_meca.clie_2 then // se cliente ricevente diverso aggiungo il nome
		kst_tab_clienti.codice = ast_tab_meca.clie_2
		kiuf_clienti.get_nome(kst_tab_clienti)
		if ast_tab_email_invio.lang = "EN" then
			ast_tab_email_invio.oggetto += ". Customer "
		else
			ast_tab_email_invio.oggetto += ". Ricevente "
		end if
		ast_tab_email_invio.oggetto += "'" + trim(kst_tab_clienti.rag_soc_10) + "'"
	end if

	k_return = ast_tab_email_invio.oggetto
	
catch (uo_exception kuo_exception)	
	throw kuo_exception
	
finally
	
end try

return k_return

end function

on kuf_meca_ptmerce.create
call super::create
end on

on kuf_meca_ptmerce.destroy
call super::destroy
end on

event destructor;call super::destructor;//
	if isvalid(kiuf_armo) then destroy kiuf_armo
	if isvalid(kiuf_clienti) then destroy kiuf_clienti
	if isvalid(kiuf_email_invio) then destroy kiuf_email_invio
	if isvalid(kiuf_email) then destroy kiuf_email
	if isvalid(kiuf_email_funzioni) then destroy kiuf_email_funzioni
	if isvalid(kiuf_msg_replace_placeholder) then destroy kiuf_msg_replace_placeholder
	if isvalid(kiuf1_ausiliari) then destroy kiuf1_ausiliari
	
end event

