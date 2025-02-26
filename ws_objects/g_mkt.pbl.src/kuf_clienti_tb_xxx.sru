$PBExportHeader$kuf_clienti_tb_xxx.sru
forward
global type kuf_clienti_tb_xxx from kuf_parent0
end type
end forward

global type kuf_clienti_tb_xxx from kuf_parent0
end type
global kuf_clienti_tb_xxx kuf_clienti_tb_xxx

type variables
//
private kuf_clienti kiuf_clienti
end variables

forward prototypes
public function boolean tb_delete (st_tab_clienti_memo ast_tab_clienti_memo) throws uo_exception
public function boolean tb_update (ref st_tab_clienti_altro kst_tab_clienti_altro) throws uo_exception
public function boolean tb_update (st_tab_clienti_fatt kst_tab_clienti_fatt) throws uo_exception
private function boolean tb_delete_ind_comm (st_tab_ind_comm kst_tab_ind_comm) throws uo_exception
public function string tb_delete (st_tab_clienti ast_tab_clienti) throws uo_exception
private function boolean tb_delete_altri (st_tab_clienti ast_tab_clienti) throws uo_exception
public function boolean tb_delete (st_tab_clienti_fatt kst_tab_clienti_fatt) throws uo_exception
public function boolean tb_delete_all_memo (st_tab_clienti_memo ast_tab_clienti_memo) throws uo_exception
private function boolean tb_delete (st_tab_clienti_mkt ast_tab_clienti_mkt) throws uo_exception
public function boolean tb_delete_m_r_f (st_tab_clienti_m_r_f ast_tab_clienti_m_r_f)
private function boolean tb_delete_m_r_f_all_x_cliente (st_tab_clienti_m_r_f ast_tab_clienti_m_r_f)
private function boolean tb_delete (st_tab_clienti_web ast_tab_clienti_web) throws uo_exception
private function boolean tb_delete (st_tab_clienti_altro ast_tab_clienti_altro) throws uo_exception
private function boolean tb_delete (st_tab_clienti_cntdep_cfg ast_tab_clienti_cntdep_cfg) throws uo_exception
public subroutine _readme ()
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public subroutine memo_save (st_tab_clienti_memo ast_tab_clienti_memo) throws uo_exception
public function boolean tb_update (st_tab_clienti_mkt ast_tab_clienti_mkt) throws uo_exception
public function boolean tb_update_ind_comm (st_tab_ind_comm kst_tab_ind_comm) throws uo_exception
public function boolean tb_update (st_tab_clienti_web kst_tab_clienti_web) throws uo_exception
public function boolean tb_update (ref st_tab_clienti_memo ast_tab_clienti_memo) throws uo_exception
private subroutine tb_update_json_field (ref st_tab_clienti_mkt ast_tab_clienti_mkt, ref string a_json_key, string a_json_val) throws uo_exception
private function st_esito tb_update_json (ref st_tab_clienti_mkt ast_tab_clienti_mkt) throws uo_exception
public function st_esito tb_ufo (st_tab_clienti_mkt kst_tab_clienti_mkt) throws uo_exception
public function boolean tb_dd_clienti_mkt_vuota (ref st_tab_clienti_mkt ast_tab_clienti_mkt) throws uo_exception
public subroutine if_isnull ()
public subroutine if_isnull_clienti_mkt (ref st_tab_clienti_mkt ast_tab_clienti_mkt)
end prototypes

public function boolean tb_delete (st_tab_clienti_memo ast_tab_clienti_memo) throws uo_exception;/*
   Cancella rek nella tabella CLIENTI_MEMO
*/
boolean k_return


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
//	if_sicurezza(kkg_flag_modalita.cancellazione)
	
	delete 
			from clienti_memo
			WHERE id_memo = :ast_tab_clienti_memo.id_memo 
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
							"Errore in Cancellazione dal Cliente del MEMO " + string(ast_tab_clienti_memo.id_memo))	
		throw kguo_exception 
	end if

	if ast_tab_clienti_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_memo.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	if ast_tab_clienti_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_memo.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return

end function

public function boolean tb_update (ref st_tab_clienti_altro kst_tab_clienti_altro) throws uo_exception;//------------------------------------------------------------------
//--- Aggiorna rek nella tabella altri DATI Cliente
//--- 
//--- Input: st_tab_clienti_altro con i dati x key id_cliente
//--- output: 
//--- Ritorna true = aggiornato 
//--- 
//------------------------------------------------------------------
boolean k_return
kuf_clienti_altro kuf1_clienti_altro


try

	kuf1_clienti_altro = create kuf_clienti_altro
	
	k_return = kuf1_clienti_altro.u_aggiona(kst_tab_clienti_altro)
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_clienti_altro) then destroy kuf1_clienti_altro
	
end try

return k_return

end function

public function boolean tb_update (st_tab_clienti_fatt kst_tab_clienti_fatt) throws uo_exception;//
//====================================================================
//=== Aggiunge rek nella tabella DATI di FATTURAZIONE
//=== 
//=== Inp: st_tab_clienti_fatt 
//=== Rit: true = ok aggiornato
//=== 
//====================================================================
long k_rcn
boolean k_return



kguo_exception.inizializza(this.classname())

if kst_tab_clienti_fatt.id_cliente > 0 then
	
	kst_tab_clienti_fatt.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_clienti_fatt.x_utente = kGuf_data_base.prendi_x_utente()

	if isnull(kst_tab_clienti_fatt.fattura_da) then
		kst_tab_clienti_fatt.fattura_da = kiuf_clienti.kki_fattura_da_bolla
	end if
	if isnull(kst_tab_clienti_fatt.note_1) then
		kst_tab_clienti_fatt.note_1 = " "
	end if
	if isnull(kst_tab_clienti_fatt.note_2) then
		kst_tab_clienti_fatt.note_2 = " "
	end if
	if isnull(kst_tab_clienti_fatt.fattura_per) then
		kst_tab_clienti_fatt.fattura_per = " "
	end if
	
	k_rcn = 0
	select distinct 1
		into :k_rcn
		from clienti_fatt
		WHERE clienti_fatt.id_cliente = :kst_tab_clienti_fatt.id_cliente 
		using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
					"Errore in Aggiornamento dati Fatturazione del cliente " + string(kst_tab_clienti_fatt.id_cliente)&
					+ ". Ricerca del codice fallita!" )
		throw kguo_exception
	end if
			
//--- tento l'insert se manca in arch.
	if k_rcn > 0 then
		UPDATE clienti_fatt  
		  SET fattura_da = :kst_tab_clienti_fatt.fattura_da,   
				note_1 = :kst_tab_clienti_fatt.note_1,   
				note_2 = :kst_tab_clienti_fatt.note_2 , 
				modo_stampa = :kst_tab_clienti_fatt.modo_stampa , 
				modo_email = :kst_tab_clienti_fatt.modo_email , 
				email_invio = :kst_tab_clienti_fatt.email_invio , 
				impon_minimo = :kst_tab_clienti_fatt.impon_minimo , 
				codice_ipa = :kst_tab_clienti_fatt.codice_ipa , 
				fattura_per = :kst_tab_clienti_fatt.fattura_per , 
				x_datins = :kst_tab_clienti_fatt.x_datins,  
				x_utente = :kst_tab_clienti_fatt.x_utente  
			WHERE id_cliente = :kst_tab_clienti_fatt.id_cliente 
			using  kguo_sqlca_db_magazzino ;
			
	else
		
		INSERT INTO clienti_fatt  
					( id_cliente,   
					  fattura_da,   
					  note_1,   
					  note_2,   
					  modo_stampa,   
					  modo_email,   
					  email_invio,   
					  impon_minimo,   
					  codice_ipa,
					  fattura_per,
					  x_datins,   
					  x_utente )  
			  VALUES ( :kst_tab_clienti_fatt.id_cliente,   
					  :kst_tab_clienti_fatt.fattura_da,   
					  :kst_tab_clienti_fatt.note_1,   
					  :kst_tab_clienti_fatt.note_2,   
					  :kst_tab_clienti_fatt.modo_stampa,   
					  :kst_tab_clienti_fatt.modo_email,   
					  :kst_tab_clienti_fatt.email_invio,   
					  :kst_tab_clienti_fatt.impon_minimo,   
					  :kst_tab_clienti_fatt.codice_ipa,   
					  :kst_tab_clienti_fatt.fattura_per,   
					  :kst_tab_clienti_fatt.x_datins,   
					  :kst_tab_clienti_fatt.x_utente )  
			using  kguo_sqlca_db_magazzino ;
	end if
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
						"Errore in Aggiornamento dati Fatturazione del cliente " + string(kst_tab_clienti_fatt.id_cliente))
		throw kguo_exception
	end if

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	
		if kst_tab_clienti_fatt.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_fatt.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if

else
	kguo_exception.kist_esito.SQLErrText = "Aggiornamento dati Fatturazione cliente non eseguito, manca il codice cliente"
	kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
	throw kguo_exception
end if

return k_return

end function

private function boolean tb_delete_ind_comm (st_tab_ind_comm kst_tab_ind_comm) throws uo_exception;/*
  Cancella il rek dalla tabella INDIRIZZI clienti
*/
boolean k_return 


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
	delete from ind_comm
			where clie_c = :kst_tab_ind_comm.clie_c 
		using  kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Cancellazione Indirizzi Anagrafica " + string(kst_tab_ind_comm.clie_c))
		throw kguo_exception 
	end if
	
	if kst_tab_ind_comm.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_ind_comm.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	if kst_tab_ind_comm.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_ind_comm.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return
end function

public function string tb_delete (st_tab_clienti ast_tab_clienti) throws uo_exception;/*
   Cancella il rek dalla tabella Clienti e tabelle correlate
*/
string k_return = "0 "
boolean k_rc
long k_num
date k_data_meno7anni, k_data_int
long k_id_cliente_rit
st_tab_clienti kst_tab_clienti
 

try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
	if_sicurezza(kkg_flag_modalita.cancellazione)
	
	k_data_meno7anni = RelativeDate(today(), -365*7) 
	
	
//=== Controllo ENTRATE del cliente
	DECLARE entrate CURSOR FOR  
		  SELECT num_int,
					data_int
			 FROM meca
			WHERE data_int > :k_data_meno7anni
					and (clie_1 = :ast_tab_clienti.codice OR
						clie_2 = :ast_tab_clienti.codice OR
						clie_3 = :ast_tab_clienti.codice)
		union all
		  SELECT num_int,
					data_int
			 FROM o_armo
			WHERE data_int > :k_data_meno7anni
					and (clie_1 = :ast_tab_clienti.codice OR
						clie_2 = :ast_tab_clienti.codice OR
						clie_3 = :ast_tab_clienti.codice)
		using kguo_sqlca_db_magazzino;

	open entrate;
	if kguo_sqlca_db_magazzino.sqlCode = 0 then
		fetch entrate INTO :k_num, :k_data_int ;
		if kguo_sqlca_db_magazzino.sqlCode = 0 then
			close entrate;
			kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
			kguo_exception.kist_esito.sqlerrtext = "Rimozione non consentita, anagrafica '" + string(ast_tab_clienti) + "' già movimentata come nel Lotto n. " &
										 + string(k_num, "#") + " del " + string(k_data_int, "dd mmm yyyy") + "." 	
			throw kguo_exception 
		end if
		close entrate;
	end if
	
	kst_tab_clienti = ast_tab_clienti
	kst_tab_clienti.st_tab_g_0.esegui_commit = "N"
	tb_delete_altri(kst_tab_clienti) // DELETE altre tabelle correlate		

//--- Cancella ANAGRAFICA
	delete from clienti
			where codice = :ast_tab_clienti.codice 
		using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlCode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Cancellazione dell Anagrafica " + string(ast_tab_clienti.codice))			
	end if
			
	if ast_tab_clienti.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if

	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	if ast_tab_clienti.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try


return k_return
end function

private function boolean tb_delete_altri (st_tab_clienti ast_tab_clienti) throws uo_exception;/*
    Cancella i dati Cliente dalle altre tabelle correlate
*/
boolean k_return 
st_tab_clienti_fatt kst_tab_clienti_fatt
st_tab_ind_comm kst_tab_ind_comm
st_tab_clienti_mkt kst_tab_clienti_mkt
st_tab_clienti_web kst_tab_clienti_web
st_tab_clienti_memo kst_tab_clienti_memo
st_tab_clienti_m_r_f kst_tab_clienti_m_r_f
st_tab_clienti_altro kst_tab_clienti_altro
st_tab_clienti_cntdep_cfg kst_tab_clienti_cntdep_cfg


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

	//if_sicurezza(kkg_flag_modalita.cancellazione)

//--- cancella indirizzi
	kst_tab_ind_comm.st_tab_g_0.esegui_commit = ast_tab_clienti.st_tab_g_0.esegui_commit
	kst_tab_ind_comm.clie_c = ast_tab_clienti.codice
	tb_delete_ind_comm(kst_tab_ind_comm)

//--- cancella dati di fatturazione
	kst_tab_clienti_fatt.st_tab_g_0.esegui_commit = ast_tab_clienti.st_tab_g_0.esegui_commit
	kst_tab_clienti_fatt.id_cliente = ast_tab_clienti.codice
	tb_delete(kst_tab_clienti_fatt)

//--- cancella dati di MKT
	kst_tab_clienti_mkt.st_tab_g_0.esegui_commit = ast_tab_clienti.st_tab_g_0.esegui_commit
	kst_tab_clienti_mkt.id_cliente = ast_tab_clienti.codice
	tb_delete(kst_tab_clienti_mkt)

//--- cancella dati di WEB
	kst_tab_clienti_web.st_tab_g_0.esegui_commit = ast_tab_clienti.st_tab_g_0.esegui_commit
	kst_tab_clienti_web.id_cliente = ast_tab_clienti.codice
	tb_delete(kst_tab_clienti_web)

//--- cancella dati MEMO
	kst_tab_clienti_memo.st_tab_g_0.esegui_commit = ast_tab_clienti.st_tab_g_0.esegui_commit
	kst_tab_clienti_memo.id_cliente = ast_tab_clienti.codice
	tb_delete_all_memo(kst_tab_clienti_memo)

//--- cancella Legami per Cliente
	kst_tab_clienti_m_r_f.st_tab_g_0.esegui_commit = ast_tab_clienti.st_tab_g_0.esegui_commit
	kst_tab_clienti_m_r_f.clie_3 = ast_tab_clienti.codice
	tb_delete_m_r_f_all_x_cliente(kst_tab_clienti_m_r_f)

//--- cancella dati ALTRI
	kst_tab_clienti_altro.st_tab_g_0.esegui_commit = ast_tab_clienti.st_tab_g_0.esegui_commit
	kst_tab_clienti_altro.id_cliente = ast_tab_clienti.codice
	tb_delete(kst_tab_clienti_altro)

//--- cancella dati CONF.CONTO DEPOSITO
	kst_tab_clienti_cntdep_cfg.st_tab_g_0.esegui_commit = ast_tab_clienti.st_tab_g_0.esegui_commit
	kst_tab_clienti_cntdep_cfg.id_cliente = ast_tab_clienti.codice
	tb_delete(kst_tab_clienti_cntdep_cfg)

//--- COMMIT
	if ast_tab_clienti.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	k_return = true
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	if ast_tab_clienti.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return
end function

public function boolean tb_delete (st_tab_clienti_fatt kst_tab_clienti_fatt) throws uo_exception;/*
   Cancella rek nella tabella DATI di FATTURAZIONE
*/
boolean k_return


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
	if_sicurezza(kkg_flag_modalita.cancellazione)
	
	delete 
		from clienti_fatt
		WHERE clienti_fatt.id_cliente = :kst_tab_clienti_fatt.id_cliente 
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
							"Errore in Cancellazione dati Fatturazione del Cliente" + string(kst_tab_clienti_fatt.id_cliente))	
		throw kguo_exception 
	end if

	if kst_tab_clienti_fatt.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_fatt.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	if kst_tab_clienti_fatt.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_fatt.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return
end function

public function boolean tb_delete_all_memo (st_tab_clienti_memo ast_tab_clienti_memo) throws uo_exception;/*
   Cancella rek nella tabella tutti i MEMO nella CLIENTI_MEMO x Cliente
*/
boolean k_return


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
	if_sicurezza(kkg_flag_modalita.cancellazione)
	
	delete 
			from clienti_memo
			WHERE id_cliente = :ast_tab_clienti_memo.id_cliente
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
							"Errore in Cancellazione di Tutti i MEMO dal Cliente " + string(ast_tab_clienti_memo.id_cliente))	
		throw kguo_exception 
	end if

	if ast_tab_clienti_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_memo.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	if ast_tab_clienti_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_memo.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return

end function

private function boolean tb_delete (st_tab_clienti_mkt ast_tab_clienti_mkt) throws uo_exception;/*
   Cancella rek nella tabella DATI di MARKETING
*/
boolean k_return


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
//	if_sicurezza(kkg_flag_modalita.cancellazione)
	
	delete 
			from clienti_memo
			WHERE id_memo = :ast_tab_clienti_mkt.id_cliente 
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
							"Errore in Cancellazione dati Marketing dell'Anagrafica " + string(ast_tab_clienti_mkt.id_cliente))	
		throw kguo_exception 
	end if

	if ast_tab_clienti_mkt.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_mkt.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	if ast_tab_clienti_mkt.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_mkt.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return

end function

public function boolean tb_delete_m_r_f (st_tab_clienti_m_r_f ast_tab_clienti_m_r_f);/*
  Cancella il in tabella M-R-F il legame delle Anagrafiche
*/
boolean k_return 


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
	if_sicurezza(kkg_flag_modalita.cancellazione)
	
	delete from m_r_f
			where  clie_1 = :ast_tab_clienti_m_r_f.clie_1
			     and clie_2 = :ast_tab_clienti_m_r_f.clie_2
			     and clie_3 = :ast_tab_clienti_m_r_f.clie_3
		using  kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Cancellazione Legame Anagrafiche: " &
						+ string(ast_tab_clienti_m_r_f.clie_1) + "->" + string(ast_tab_clienti_m_r_f.clie_2) + "->" + string(ast_tab_clienti_m_r_f.clie_3))
		throw kguo_exception 
	end if
	
	if ast_tab_clienti_m_r_f.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_m_r_f.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	if ast_tab_clienti_m_r_f.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_m_r_f.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return


end function

private function boolean tb_delete_m_r_f_all_x_cliente (st_tab_clienti_m_r_f ast_tab_clienti_m_r_f);/*
  Cancella il in tabella M-R-F tutti i legami associati al Cliente
*/
boolean k_return 


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
	delete from m_r_f
			where clie_3 = :ast_tab_clienti_m_r_f.clie_3
		using  kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Cancellazione di tutti i Legami del Cliente " &
						+ string(ast_tab_clienti_m_r_f.clie_3))
		throw kguo_exception 
	end if
	
	if ast_tab_clienti_m_r_f.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_m_r_f.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	if ast_tab_clienti_m_r_f.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_m_r_f.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return


end function

private function boolean tb_delete (st_tab_clienti_web ast_tab_clienti_web) throws uo_exception;/*
   Cancella rek nella tabella 'DATI WEB'
*/
boolean k_return


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
		
	delete 
			from clienti_web
			WHERE id_cliente = :ast_tab_clienti_web.id_cliente 
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
							"Errore in Cancellazione dati 'Web' dell'Anagrafica " + string(ast_tab_clienti_web.id_cliente))	
		throw kguo_exception 
	end if

	if ast_tab_clienti_web.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_web.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	if ast_tab_clienti_web.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_web.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return

end function

private function boolean tb_delete (st_tab_clienti_altro ast_tab_clienti_altro) throws uo_exception;/*
   Cancella rek nella tabella 'ALTRI'
*/
boolean k_return


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
		
	delete 
			from clienti_altro
			WHERE id_cliente = :ast_tab_clienti_altro.id_cliente 
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
							"Errore in Cancellazione dati 'generici' dell'Anagrafica " + string(ast_tab_clienti_altro.id_cliente))	
		throw kguo_exception 
	end if

	if ast_tab_clienti_altro.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_altro.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	if ast_tab_clienti_altro.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_altro.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return

end function

private function boolean tb_delete (st_tab_clienti_cntdep_cfg ast_tab_clienti_cntdep_cfg) throws uo_exception;/*
   Cancella rek nella tabella 'Config. Conto Deposito'
*/
boolean k_return


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
		
	delete 
			from clienti_altro
			WHERE id_cliente = :ast_tab_clienti_cntdep_cfg.id_cliente 
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
							"Errore in Cancellazione dati 'Config. del Conto Deposito' dell'Anagrafica " + string(ast_tab_clienti_cntdep_cfg.id_cliente))	
		throw kguo_exception 
	end if

	if ast_tab_clienti_cntdep_cfg.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_cntdep_cfg.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	if ast_tab_clienti_cntdep_cfg.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_cntdep_cfg.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return

end function

public subroutine _readme ();/*
  per operazioni di INSERT, UPDATE , DELETE
*/

end subroutine

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return kiuf_clienti.if_sicurezza(ast_open_w)

end function

public subroutine memo_save (st_tab_clienti_memo ast_tab_clienti_memo) throws uo_exception;//
//--- Fascicola il MEMO sul Cliente 
//
st_esito kst_esito
kuf_memo_allarme kuf1_memo_allarme

try   

	if trim(ast_tab_clienti_memo.allarme) > " " then
	else
		ast_tab_clienti_memo.allarme = kuf1_memo_allarme.kki_memo_allarme_no
	end if

	tb_update(ast_tab_clienti_memo)

catch (uo_exception	kuo_exception)
	throw kuo_exception
		
end try
	


end subroutine

public function boolean tb_update (st_tab_clienti_mkt ast_tab_clienti_mkt) throws uo_exception;/*
    Aggiorna DATI di MARKETING
*/
boolean k_return
long k_rcn
boolean k_rc, k_senza_dati=false


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
//	if_sicurezza(kkg_flag_modalita.cancellazione)

	if ast_tab_clienti_mkt.id_cliente > 0 then
	else
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.SQLErrText = "Aggiornamento dati Marketing cliente non eseguito, manca il codice cliente"
		throw kguo_exception
	end if
	
	ast_tab_clienti_mkt.x_datins = kGuf_data_base.prendi_x_datins()
	ast_tab_clienti_mkt.x_utente = kGuf_data_base.prendi_x_utente()

	if_isnull_clienti_mkt( ast_tab_clienti_mkt )

	k_rcn = 0
	select distinct 1
		into :k_rcn
		from clienti_mkt
		WHERE id_cliente = :ast_tab_clienti_mkt.id_cliente 
		using kguo_sqlca_db_magazzino;
		
			
//--- tento l'insert se manca in arch.
	if kguo_sqlca_db_magazzino.sqlcode  >= 0 then

//				or trim(kst_tab_clienti.kst_tab_clienti_mkt.contatto_1_qualif)) > 0 & 
//				or trim(kst_tab_clienti.kst_tab_clienti_mkt.contatto_2_qualif)) > 0 &
//				or trim(kst_tab_clienti.kst_tab_clienti_mkt.contatto_3_qualif)) > 0 &
//				or trim(kst_tab_clienti.kst_tab_clienti_mkt.contatto_4_qualif)) > 0 &
//				or trim(kst_tab_clienti.kst_tab_clienti_mkt.contatto_5_qualif)) > 0 &
//				or kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_1 <> 0 &
//				or kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_2 <> 0  &
//				or kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_3  <> 0 &
//				or kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_4  <> 0 &
//				or kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_5  <> 0 &
//
//--- controllo se ci sono dati
		if trim(ast_tab_clienti_mkt.altra_sede) > " " & 
			  or trim(ast_tab_clienti_mkt.tipo_rapporto) > " " & 
			  or trim(ast_tab_clienti_mkt.cod_atecori) > " " & 
				or ast_tab_clienti_mkt.id_cliente_link  <> 0 &
				or trim(ast_tab_clienti_mkt.note_attivita) > " " &
				or trim(ast_tab_clienti_mkt.note_prodotti) > " " & 
				or ast_tab_clienti_mkt.gruppo > 0 & 
				or trim(ast_tab_clienti_mkt.doc_esporta) > " " & 
				or trim(ast_tab_clienti_mkt.doc_esporta_prefpath) > " " & 
				or trim(ast_tab_clienti_mkt.qualifica) > " " &
				or trim(ast_tab_clienti_mkt.for_cobalt_rload) = "S" &
				or trim(ast_tab_clienti_mkt.for_price_cntct) = "S" &
				or trim(ast_tab_clienti_mkt.for_qa_italy) = "S" &
				or trim(ast_tab_clienti_mkt.cell) > " " &
				or trim(ast_tab_clienti_mkt.categ) > " " &
				then
		
			k_senza_dati = false
		else
			k_senza_dati = true
		end if
		
		if k_rcn > 0 then
			
			if k_senza_dati then //allora non serve quindi DELETE
				delete from clienti_mkt  
					WHERE id_cliente = :ast_tab_clienti_mkt.id_cliente 
					using kguo_sqlca_db_magazzino;
			else
//						,contatto_1_qualif = :ast_tab_clienti_mkt.contatto_1_qualif
//						,contatto_2_qualif = :ast_tab_clienti_mkt.contatto_2_qualif
//						,contatto_3_qualif = :ast_tab_clienti_mkt.contatto_3_qualif 
//						,contatto_4_qualif = :ast_tab_clienti_mkt.contatto_4_qualif 
//						,contatto_5_qualif = :ast_tab_clienti_mkt.contatto_5_qualif 
//						,id_contatto_1 = :ast_tab_clienti_mkt.id_contatto_1 
//						,id_contatto_2 = :ast_tab_clienti_mkt.id_contatto_2 
//						,id_contatto_3 = :ast_tab_clienti_mkt.id_contatto_3 
//						,id_contatto_4 = :ast_tab_clienti_mkt.id_contatto_4 
//						,id_contatto_5 = :ast_tab_clienti_mkt.id_contatto_5 
//				
				UPDATE clienti_mkt  
				  SET 
						altra_sede = :ast_tab_clienti_mkt.altra_sede 
						,cod_atecori = :ast_tab_clienti_mkt.cod_atecori 
						,tipo_rapporto = :ast_tab_clienti_mkt.tipo_rapporto 
						,id_cliente_link = :ast_tab_clienti_mkt.id_cliente_link 
						,note_attivita = :ast_tab_clienti_mkt.note_attivita 
						,note_prodotti = :ast_tab_clienti_mkt.note_prodotti 
						,qualifica = :ast_tab_clienti_mkt.qualifica 
						,gruppo = :ast_tab_clienti_mkt.gruppo 
						,doc_esporta = :ast_tab_clienti_mkt.doc_esporta 
						,doc_esporta_prefpath = :ast_tab_clienti_mkt.doc_esporta_prefpath
						,x_datins = :ast_tab_clienti_mkt.x_datins
						,x_utente = :ast_tab_clienti_mkt.x_utente  
					WHERE id_cliente = :ast_tab_clienti_mkt.id_cliente 
					using kguo_sqlca_db_magazzino;
			end if						
		else
			
			if NOT k_senza_dati then //registra solo se contiene dati
				INSERT INTO clienti_mkt 
						(
						id_cliente
						,altra_sede 
						,tipo_rapporto
						,cod_atecori
						,contatto_1_qualif
						,contatto_2_qualif
						,contatto_3_qualif 
						,contatto_4_qualif 
						,contatto_5_qualif 
						,id_contatto_1
						,id_contatto_2 
						,id_contatto_3 
						,id_contatto_4 
						,id_contatto_5 
						,id_cliente_link 
						,note_attivita 
						,note_prodotti 
						,qualifica 
						,gruppo 
						,doc_esporta
						,doc_esporta_prefpath
						,x_datins 
						,x_utente 
						 )  
				  VALUES ( 
					 :ast_tab_clienti_mkt.id_cliente 
					,:ast_tab_clienti_mkt.altra_sede 
					,:ast_tab_clienti_mkt.tipo_rapporto 
					,:ast_tab_clienti_mkt.cod_atecori 
					,''
					,''
					,''
					,''
					,''
					,0
					,0
					,0
					,0
					,0
					,:ast_tab_clienti_mkt.id_cliente_link 
					,:ast_tab_clienti_mkt.note_attivita 
					,:ast_tab_clienti_mkt.note_prodotti 
					,:ast_tab_clienti_mkt.qualifica 
					,:ast_tab_clienti_mkt.gruppo 
					,:ast_tab_clienti_mkt.doc_esporta 
					,:ast_tab_clienti_mkt.doc_esporta_prefpath
					,:ast_tab_clienti_mkt.x_datins
					,:ast_tab_clienti_mkt.x_utente  
						  )  
				using kguo_sqlca_db_magazzino;

//					,'':ast_tab_clienti_mkt.contatto_1_qualif
//					,'':ast_tab_clienti_mkt.contatto_2_qualif
//					,'':ast_tab_clienti_mkt.contatto_3_qualif 
//					,'':ast_tab_clienti_mkt.contatto_4_qualif 
//					,'':ast_tab_clienti_mkt.contatto_5_qualif 
//					,0:ast_tab_clienti_mkt.id_contatto_1 
//					,0:ast_tab_clienti_mkt.id_contatto_2 
//					,0:ast_tab_clienti_mkt.id_contatto_3 
//					,0:ast_tab_clienti_mkt.id_contatto_4 
//					,0:ast_tab_clienti_mkt.id_contatto_5 
				
			end if
		end if
		
	end if	

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
							"Errore in Aggiornamento dati Marketing dell'Anagrafica " + string(ast_tab_clienti_mkt.id_cliente))	
		throw kguo_exception 
	end if

	tb_update_json(ast_tab_clienti_mkt)  // Aggiorna i dati Json della tabella

	if ast_tab_clienti_mkt.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_mkt.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	if ast_tab_clienti_mkt.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_mkt.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return

end function

public function boolean tb_update_ind_comm (st_tab_ind_comm kst_tab_ind_comm) throws uo_exception;/*
  Aggiorna dati Indirizzi
*/
boolean k_return
long k_rcn


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
	if kst_tab_ind_comm.clie_c > 0 then
	else
		kguo_exception.kist_esito.SQLErrText = "Aggiornamento dati Ind.Commerciali cliente non eseguito, manca il codice cliente"
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		throw kguo_exception
	end if		
	
	kst_tab_ind_comm.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_ind_comm.x_utente = kGuf_data_base.prendi_x_utente()

	if isnull(kst_tab_ind_comm.rag_soc_1_c) then
		kst_tab_ind_comm.rag_soc_1_c = " "
	end if
	if isnull(kst_tab_ind_comm.rag_soc_2_c) then
		kst_tab_ind_comm.rag_soc_2_c = " "
	end if
	if isnull(kst_tab_ind_comm.indi_c) then
		kst_tab_ind_comm.indi_c = " "
	end if
	if isnull(kst_tab_ind_comm.loc_c) then
		kst_tab_ind_comm.loc_c = " "
	end if
	if isnull(kst_tab_ind_comm.cap_c) then
		kst_tab_ind_comm.cap_c = " "
	end if
	if isnull(kst_tab_ind_comm.prov_c) then
		kst_tab_ind_comm.prov_c = " "
	end if
	if isnull(kst_tab_ind_comm.id_nazione_c ) then
		kst_tab_ind_comm.id_nazione_c = ""
	end if

	if_sicurezza(kkg_flag_modalita.modifica)	
			
	select distinct clie_c
			into :k_rcn
			from ind_comm
			WHERE ind_comm.clie_c = :kst_tab_ind_comm.clie_c 
			using kguo_sqlca_db_magazzino;
			
				
//--- Update o Insert

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		
		UPDATE ind_comm  
			  SET rag_soc_1_c = :kst_tab_ind_comm.rag_soc_1_c,   
					rag_soc_2_c = :kst_tab_ind_comm.rag_soc_2_c,   
					indi_c = :kst_tab_ind_comm.indi_c,   
					loc_c = :kst_tab_ind_comm.loc_c,   
					cap_c = :kst_tab_ind_comm.cap_c,   
					prov_c = :kst_tab_ind_comm.prov_c,  
					id_nazione_c = :kst_tab_ind_comm.id_nazione_c,  
					x_datins = :kst_tab_ind_comm.x_datins,  
					x_utente = :kst_tab_ind_comm.x_utente  
				WHERE ind_comm.clie_c = :kst_tab_ind_comm.clie_c 
				using kguo_sqlca_db_magazzino;
				
	else
			
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			INSERT INTO ind_comm  
						( clie_c,   
						  rag_soc_1_c,   
						  rag_soc_2_c,   
						  indi_c,   
						  loc_c,   
						  cap_c,   
						  prov_c,   
						  id_nazione_c,
						  x_datins,   
						  x_utente )  
				  VALUES ( :kst_tab_ind_comm.clie_c,   
						  :kst_tab_ind_comm.rag_soc_1_c,   
						  :kst_tab_ind_comm.rag_soc_2_c,   
						  :kst_tab_ind_comm.indi_c,   
						  :kst_tab_ind_comm.loc_c,   
						  :kst_tab_ind_comm.cap_c,   
						  :kst_tab_ind_comm.prov_c,   
						  :kst_tab_ind_comm.id_nazione_c,
						  :kst_tab_ind_comm.x_datins,   
						  :kst_tab_ind_comm.x_utente )  
				using kguo_sqlca_db_magazzino;
		end if
	end if	
		

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
							"Errore in Aggiornamento dati dati Indirizzi Commerciali dell'Anagrafica " + string(kst_tab_ind_comm.clie_c))	
		throw kguo_exception 
	end if

	if kst_tab_ind_comm.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_ind_comm.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	end if
		
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	if kst_tab_ind_comm.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_ind_comm.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return
end function

public function boolean tb_update (st_tab_clienti_web kst_tab_clienti_web) throws uo_exception;/*
  Aggiorna dati DATI di WEB
*/
boolean k_return
long k_rcn
boolean k_rc, k_senza_dati
st_tab_clienti kst_tab_clienti


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
		
	if kst_tab_clienti_web.id_cliente > 0 then
	else
		kguo_exception.kist_esito.SQLErrText = "Aggiornamento dati Web cliente non eseguito, manca il codice cliente"
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		throw kguo_exception
	end if

	kst_tab_clienti_web.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_clienti_web.x_utente = kGuf_data_base.prendi_x_utente()

	kst_tab_clienti.kst_tab_clienti_web = kst_tab_clienti_web
	kiuf_clienti.if_isnull( kst_tab_clienti )
	kst_tab_clienti_web = kst_tab_clienti.kst_tab_clienti_web

	k_rcn = 0
	select distinct 1
		into :k_rcn
		from clienti_web
		WHERE id_cliente = :kst_tab_clienti_web.id_cliente 
		using sqlca;
		
			
//--- tento l'insert se manca in arch.
	if sqlca.sqlcode  >= 0 then

//--- controllo se ci sono dati
		if len(trim(kst_tab_clienti.kst_tab_clienti_web.blog_web)) > 0 & 
			  or len(trim(kst_tab_clienti.kst_tab_clienti_web.blog_web1)) > 0 & 
			  or len(trim(kst_tab_clienti.kst_tab_clienti_web.email)) > 0 & 
			  or len(trim(kst_tab_clienti.kst_tab_clienti_web.email1)) > 0 & 
			  or len(trim(kst_tab_clienti.kst_tab_clienti_web.email2)) > 0 & 
			  or len(trim(kst_tab_clienti.kst_tab_clienti_web.email3)) > 0 & 
			  or kst_tab_clienti.kst_tab_clienti_web.email_prontomerce > 0 &
			  or len(trim(kst_tab_clienti.kst_tab_clienti_web.note)) > 0 & 
			  or len(trim(kst_tab_clienti.kst_tab_clienti_web.sito_web)) > 0 & 
			  or len(trim(kst_tab_clienti.kst_tab_clienti_web.sito_web1)) > 0 & 
			  or kst_tab_clienti_web.email_send_certif_off > 0 &
				 then
		
			k_senza_dati = false
		else
			k_senza_dati = true
		end if
		
		
		if k_rcn > 0 then
			UPDATE clienti_web  
			  SET 
					blog_web = :kst_tab_clienti_web.blog_web 
					,blog_web1 = :kst_tab_clienti_web.blog_web1 
					,email = :kst_tab_clienti_web.email 
					,email1 = :kst_tab_clienti_web.email1 
					,email2 = :kst_tab_clienti_web.email2 
					,email3 = :kst_tab_clienti_web.email3
					,email_prontomerce = :kst_tab_clienti_web.email_prontomerce
					,note = :kst_tab_clienti_web.note 
					,sito_web = :kst_tab_clienti_web.sito_web 
					,sito_web1 = :kst_tab_clienti_web.sito_web1 
					,email_send_certif_off = :kst_tab_clienti_web.email_send_certif_off
					,x_datins = :kst_tab_clienti_web.x_datins
					,x_utente = :kst_tab_clienti_web.x_utente  
				WHERE id_cliente = :kst_tab_clienti_web.id_cliente 
				using sqlca;
				
		else
			
			INSERT INTO clienti_web  
						(
						id_cliente
						,blog_web 
						,blog_web1 
						,email 
						,email1  
						,email2 
						,email3 
						,email_prontomerce
						,note 
						,sito_web 
						,sito_web1 
						,email_send_certif_off
						,x_datins 
						,x_utente 
						 )  
				  VALUES ( 
					 :kst_tab_clienti_web.id_cliente 
					,:kst_tab_clienti_web.blog_web 
					,:kst_tab_clienti_web.blog_web1 
					,:kst_tab_clienti_web.email 
					,:kst_tab_clienti_web.email1
					,:kst_tab_clienti_web.email2
					,:kst_tab_clienti_web.email3
					,:kst_tab_clienti_web.email_prontomerce
					,:kst_tab_clienti_web.note 
					,:kst_tab_clienti_web.sito_web 
					,:kst_tab_clienti_web.sito_web1 
					,:kst_tab_clienti_web.email_send_certif_off
					,:kst_tab_clienti_web.x_datins
					,:kst_tab_clienti_web.x_utente  
						  )  
				using sqlca;
		end if
		
	end if	
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
							"Errore in Aggiornamento dati 'Web' dell'Anagrafica " + string(kst_tab_clienti_web.id_cliente))	
		throw kguo_exception 
	end if

	if kst_tab_clienti_web.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_web.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	if kst_tab_clienti_web.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_web.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return

end function

public function boolean tb_update (ref st_tab_clienti_memo ast_tab_clienti_memo) throws uo_exception;//====================================================================
//=== Aggiunge rek nella tabella DATI di MEMO
//=== 
//=== Input: st_tab_clienti_memo
//=== output: id_cliente_memo
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
long k_rcn
boolean k_rc, k_senza_dati
st_esito kst_esito
boolean k_return


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
//	if_sicurezza(kkg_flag_modalita.cancellazione)
	
	if ast_tab_clienti_memo.id_cliente > 0 then
	else
		kguo_exception.kist_esito.SQLErrText = "Aggiornamento dati Avvisi MEMO clienti non eseguito, manca il codice cliente"
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		throw kguo_exception
	end if
	
	ast_tab_clienti_memo.x_datins = kGuf_data_base.prendi_x_datins()
	ast_tab_clienti_memo.x_utente = kGuf_data_base.prendi_x_utente()
		
	k_rcn = 0
	if ast_tab_clienti_memo.id_memo > 0 then
		select distinct 1
			into :k_rcn
			from clienti_memo
			WHERE id_memo = :ast_tab_clienti_memo.id_memo 
			using kguo_sqlca_db_magazzino;
	end if			
		
	//--- tento l'insert se manca in arch.
	if kguo_sqlca_db_magazzino.sqlcode  >= 0 then

		if k_rcn > 0 then
			UPDATE clienti_memo  
					SET id_cliente = :ast_tab_clienti_memo.id_cliente
						 ,tipo_sv =  :ast_tab_clienti_memo.tipo_sv
						 ,allarme = :ast_tab_clienti_memo.allarme
						 ,xclie_1 = :ast_tab_clienti_memo.xclie_1
						 ,xclie_2 = :ast_tab_clienti_memo.xclie_2
						 ,xclie_3 = :ast_tab_clienti_memo.xclie_3
						,x_datins = :ast_tab_clienti_memo.x_datins
						,x_utente = :ast_tab_clienti_memo.x_utente  
						WHERE id_memo = :ast_tab_clienti_memo.id_memo 
						using kguo_sqlca_db_magazzino;
		else
			
			if NOT k_senza_dati then
				//id_cliente_memo
				INSERT INTO clienti_memo  
							(
							tipo_sv
							,id_memo
							,id_cliente
							 ,allarme
							 ,xclie_1
							 ,xclie_2
							 ,xclie_3
							,x_datins 
							,x_utente 
							 )  
					  VALUES ( 
						:ast_tab_clienti_memo.tipo_sv
						,:ast_tab_clienti_memo.id_memo 
						,:ast_tab_clienti_memo.id_cliente 
						,:ast_tab_clienti_memo.allarme 
						,:ast_tab_clienti_memo.xclie_1
						,:ast_tab_clienti_memo.xclie_2
						,:ast_tab_clienti_memo.xclie_3
						,:ast_tab_clienti_memo.x_datins
						,:ast_tab_clienti_memo.x_utente  
						)  
					using kguo_sqlca_db_magazzino;
					
				if kguo_sqlca_db_magazzino.sqlcode = 0 then
					ast_tab_clienti_memo.id_cliente_memo = kiuf_clienti.get_id_cliente_memo_max()
				end if	
			end if
					
		end if
			
	end if	
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
							"Errore in Aggiornamento Avviso MEMO " + string(ast_tab_clienti_memo.id_memo))	
		throw kguo_exception 
	end if

	if ast_tab_clienti_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_memo.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	if ast_tab_clienti_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_memo.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return
end function

private subroutine tb_update_json_field (ref st_tab_clienti_mkt ast_tab_clienti_mkt, ref string a_json_key, string a_json_val) throws uo_exception;/*
 Aggiorna campo JSON in tabella
	inp: st_tab_clienti_mkt.id_cliente
		  json_key e json_valore
*/

try
	kguo_exception.inizializza(this.classname())
	
	if ast_tab_clienti_mkt.id_cliente > 0 then

		update clienti_mkt
				 set data_json = replace(JSON_MODIFY(data_json, :a_json_key, :a_json_val), '\/', '/')
				where id_cliente = :ast_tab_clienti_mkt.id_cliente
				using kguo_sqlca_db_magazzino ;
			
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Fallito Aggiornamento dati Marketing Cliente " + string(ast_tab_clienti_mkt.id_cliente) &
								+ ", campo: " + a_json_key + "' " &
								+ "valore: '"+ a_json_val + "' (tab.clienti_mkt). ")
			if isnull(a_json_val) then a_json_val = "NULLO"
			throw kguo_exception
		end if

		if ast_tab_clienti_mkt.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_mkt.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		
	end if
	
catch	(uo_exception kuo_exception)
	if kuo_exception.kist_esito.esito = kkg_esito.db_ko then
		if ast_tab_clienti_mkt.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_mkt.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		kuo_exception.scrivi_log( )
	end if
	throw kuo_exception

finally


end try

end subroutine

private function st_esito tb_update_json (ref st_tab_clienti_mkt ast_tab_clienti_mkt) throws uo_exception;/*
 Update/Insert the row in  clienti_mkt campo JSON
    Inp: st_tab_clienti_mkt.id_cliente + con i campi jsoc
*/
int k_idx, k_idx_max
string k_json_key[100]
string k_json_val[100], k_json_val_old[100]
st_tab_clienti_mkt kst_tab_clienti_mkt
constant int kk_for_qa_italy = 1
constant int kk_for_cobalt_rload = 2
constant int kk_for_price_cntct = 3
constant int kk_cell = 4
constant int kk_categ = 5


	try
		kguo_exception.inizializza(this.classname())
//		kuf1_utility = create kuf_utility
		
		if ast_tab_clienti_mkt.id_cliente > 0 then
		else
			return kguo_exception.kist_esito
		end if

	//--- Legge i valori attuali
		select isnull(clienti_mkt.data_json,'')
				,isnull(trim(JSON_VALUE(clienti_mkt.data_json ,'$.for_qa_italy')),'') for_qa_italy
				,isnull(trim(JSON_VALUE(clienti_mkt.data_json ,'$.for_cobalt_rload')),'') for_cobalt_rload
				,isnull(trim(JSON_VALUE(clienti_mkt.data_json ,'$.for_price_cntct')),'') for_price_cntct
				,isnull(trim(JSON_VALUE(clienti_mkt.data_json ,'$.cell')),'') cell 
				,isnull(trim(JSON_VALUE(clienti_mkt.data_json ,'$.categ')),'') categ 
			into :kst_tab_clienti_mkt.data_json
				  ,:k_json_val_old[kk_for_qa_italy]
				  ,:k_json_val_old[kk_for_cobalt_rload]
				  ,:k_json_val_old[kk_for_price_cntct]
			     ,:k_json_val_old[kk_cell]
			     ,:k_json_val_old[kk_categ]
			FROM clienti_mkt
			where id_cliente = :ast_tab_clienti_mkt.id_cliente
					using kguo_sqlca_db_magazzino ;
					
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			tb_dd_clienti_mkt_vuota(ast_tab_clienti_mkt)
//			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
//							"Dati Marketing non esistenti fallito aggiornamento dell'Anagrafica " + string(ast_tab_clienti_mkt.id_cliente) + " fallito! ")
//			throw kguo_exception
		else
			if trim(kst_tab_clienti_mkt.data_json) = '' then
				update clienti_mkt
	 				 set data_json = '{}'
  						where id_cliente = :ast_tab_clienti_mkt.id_cliente
						using kguo_sqlca_db_magazzino ;
			end if
		end if

		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
							"Fallita lettura dati Marketing (clienti_mkt json) dell'Anagrafica " + string(ast_tab_clienti_mkt.id_cliente))
			throw kguo_exception
		end if
		
//--- compone i campi JSON					
		k_idx_max = 0
		k_idx_max ++; k_json_key[kk_for_qa_italy] = "$." + "for_qa_italy"; k_json_val[kk_for_qa_italy] = trim(ast_tab_clienti_mkt.for_qa_italy)
		k_idx_max ++; k_json_key[kk_for_cobalt_rload] = "$." + "for_cobalt_rload"; k_json_val[kk_for_cobalt_rload] = trim(ast_tab_clienti_mkt.for_cobalt_rload)
		k_idx_max ++; k_json_key[kk_for_price_cntct] = "$." + "for_price_cntct"; k_json_val[kk_for_price_cntct] = trim(ast_tab_clienti_mkt.for_price_cntct)
		k_idx_max ++; k_json_key[kk_cell] = "$." + "cell"; k_json_val[kk_cell] = trim(ast_tab_clienti_mkt.cell)
		k_idx_max ++; k_json_key[kk_categ] = "$." + "categ"; k_json_val[kk_categ] = trim(ast_tab_clienti_mkt.categ)

		kguo_sqlca_db_magazzino.sqlcode = 0
		k_idx = 0
		do while k_idx < k_idx_max and kguo_sqlca_db_magazzino.sqlcode = 0 
			k_idx ++
			
			if k_json_val[k_idx] <> k_json_val_old[k_idx] then
				if k_json_val[k_idx] > " " then
				else
					setnull(k_json_val[k_idx])
				end if
				update clienti_mkt
						 set data_json = replace(JSON_MODIFY(data_json, :k_json_key[k_idx], :k_json_val[k_idx]), '\/', '/')
					where id_cliente = :ast_tab_clienti_mkt.id_cliente
					using kguo_sqlca_db_magazzino ;
			end if
			
		loop
		
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
					"Fallito Aggiornamento dati Marketing (clienti_mkt) dell'Anagrafica  " + string(ast_tab_clienti_mkt.id_cliente) &
							+ ", campo: " + k_json_key[k_idx] &
							+ " valore: "+ k_json_val[k_idx] + ". ")
			throw kguo_exception
		end if

		if ast_tab_clienti_mkt.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_mkt.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		
	catch	(uo_exception kuo_exception)
		kuo_exception.scrivi_log( )
		if kuo_exception.kist_esito.esito = kkg_esito.db_ko then
			if ast_tab_clienti_mkt.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_mkt.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		end if
		throw kuo_exception
	
	finally
//		if isvalid(kuf1_utility) then destroy kuf1_utility
	
	end try

return kguo_exception.kist_esito

end function

public function st_esito tb_ufo (st_tab_clienti_mkt kst_tab_clienti_mkt) throws uo_exception;//
	return tb_update_json(kst_tab_clienti_mkt)

end function

public function boolean tb_dd_clienti_mkt_vuota (ref st_tab_clienti_mkt ast_tab_clienti_mkt) throws uo_exception;/*
 Aggiunge una riga alla tabella MKT
 
   Inp: st_tab_clienti_mkt
   Out: id_cliente
*/
boolean k_return
st_esito kst_esito
uo_ds_std_1 kds_1


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
//	if_sicurezza(kkg_flag_modalita.cancellazione)
	
	if ast_tab_clienti_mkt.id_cliente > 0 then
	else
		kguo_exception.kist_esito.SQLErrText = "Aggiornamento dati Avvisi Marketing, manca il codice cliente"
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		throw kguo_exception
	end if
	
	ast_tab_clienti_mkt.x_datins = kGuf_data_base.prendi_x_datins()
	ast_tab_clienti_mkt.x_utente = kGuf_data_base.prendi_x_utente()
	
	kds_1 = create uo_ds_std_1
	kds_1.dataobject = "ds_clienti_mkt"	
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	
	if kds_1.insertrow(0) > 0 then
		kds_1.setitem(1, "id_cliente", ast_tab_clienti_mkt.id_cliente)
		kds_1.setitem(1, "data_json", "{}")
		kds_1.setitem(1, "x_datins", ast_tab_clienti_mkt.x_datins)
		kds_1.setitem(1, "x_utente", ast_tab_clienti_mkt.x_utente)
		if kds_1.update( ) > 0 then
			if ast_tab_clienti_mkt.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_mkt.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		else
			kguo_exception.set_st_esito_err_ds(kds_1, &
								"Errore in Aggiornamento dati Marketing Cliente " + string(ast_tab_clienti_mkt.id_cliente))	
			throw kguo_exception 
		end if
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return
end function

public subroutine if_isnull ();
end subroutine

public subroutine if_isnull_clienti_mkt (ref st_tab_clienti_mkt ast_tab_clienti_mkt);//
st_tab_clienti kst_tab_clienti 

	kst_tab_clienti.kst_tab_clienti_mkt = ast_tab_clienti_mkt
	kiuf_clienti.if_isnull( kst_tab_clienti )
	ast_tab_clienti_mkt = kst_tab_clienti.kst_tab_clienti_mkt

end subroutine

on kuf_clienti_tb_xxx.create
call super::create
end on

on kuf_clienti_tb_xxx.destroy
call super::destroy
end on

event constructor;call super::constructor;//
kiuf_clienti = create kuf_clienti
end event

event destructor;call super::destructor;//
if isvalid(kiuf_clienti) then destroy kiuf_clienti
end event

