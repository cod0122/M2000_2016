$PBExportHeader$kuf_sped_addr_excl.sru
forward
global type kuf_sped_addr_excl from kuf_parent
end type
end forward

global type kuf_sped_addr_excl from kuf_parent
end type
global kuf_sped_addr_excl kuf_sped_addr_excl

forward prototypes
public subroutine _readme ()
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function long u_aggiorna (st_tab_sped_addr_excl ast_tab_sped_addr_excl) throws uo_exception
public function long get_last_id_sped_addr_excl () throws uo_exception
public function long tb_add (st_tab_sped_addr_excl ast_tab_sped_addr_excl) throws uo_exception
public function long tb_delete (st_tab_sped_addr_excl ast_tab_sped_addr_excl) throws uo_exception
end prototypes

public subroutine _readme ();//
//--- Esclude indirizzi DDT
//
end subroutine

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
boolean k_return
kuf_sped kuf1_sped


try
	kuf1_sped = create kuf_sped
	
	k_return = kuf1_sped.if_sicurezza(ast_open_w)

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally 
	destroy kuf1_sped
	
end try

return k_return
end function

public function long u_aggiorna (st_tab_sped_addr_excl ast_tab_sped_addr_excl) throws uo_exception;//
//--- Inserisce/Rimuove riga in tabella
//--- Inp: st_tab_sped_addr_excl.id_sped_addr_excl + st_tab_sped_addr_excl.* valorizzata tranne x_datins/x_utente
//--- Out: st_tab_sped_addr_excl.id_sped_addr_excl rimosso o inserito
//
long k_return
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname( ))
	
	
	if ast_tab_sped_addr_excl.id_sped_addr_excl > 0 then

		tb_delete(ast_tab_sped_addr_excl)
		
	else

		k_return = tb_add(ast_tab_sped_addr_excl)
		
	end if
	
catch(uo_exception kuo_exception)
	throw kuo_exception
	
end try


return k_return 
end function

public function long get_last_id_sped_addr_excl () throws uo_exception;//
//====================================================================
//=== Torna ultima ID caricato
//=== 
//=== Input :
//=== Out: 
//=== Ritorna: ID 
//===   
//====================================================================
st_tab_sped_addr_excl kst_tab_sped_addr_excl
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())

	select max(id_sped_addr_excl)
			into :kst_tab_sped_addr_excl.id_sped_addr_excl
			from sped_addr_excl  
		using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo ID caricato in tabella Indirizzi DDT da escludere. " &
						+ trim(kguo_sqlca_db_magazzino.sqlerrtext)
	end if
	
	if kst_tab_sped_addr_excl.id_sped_addr_excl > 0 then
	else
		kst_tab_sped_addr_excl.id_sped_addr_excl = 0
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try
	
return kst_tab_sped_addr_excl.id_sped_addr_excl	

end function

public function long tb_add (st_tab_sped_addr_excl ast_tab_sped_addr_excl) throws uo_exception;//
//------------------------------------------------------------------
//--- Aggiunge riga alla tabella 
//--- 
//--- Ritorna: id_sped_addr_excl aggiunto 
//--- 
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())

	if_sicurezza(kkg_flag_modalita.modifica)  // Controllo se utente autorizzato

	ast_tab_sped_addr_excl.id_sped_addr_excl = 0
	ast_tab_sped_addr_excl.x_datins = kGuf_data_base.prendi_x_datins()
	ast_tab_sped_addr_excl.x_utente = kGuf_data_base.prendi_x_utente()

 //id_sped_addr_excl,
//:ast_tab_sped_addr_excl.id_sped_addr_excl,

	INSERT INTO sped_addr_excl  
         (  
			  id_cliente,
           rag_soc_1,   
           rag_soc_2,   
           indi,   
           loc,   
           cap,   
           prov,   
           id_nazione,   
           x_datins,   
           x_utente 
           )  
  VALUES (   
           :ast_tab_sped_addr_excl.id_cliente,   
           :ast_tab_sped_addr_excl.rag_soc_1,   
           :ast_tab_sped_addr_excl.rag_soc_2,   
           :ast_tab_sped_addr_excl.indi,   
           :ast_tab_sped_addr_excl.loc,   
           :ast_tab_sped_addr_excl.cap,   
           :ast_tab_sped_addr_excl.prov,   
           :ast_tab_sped_addr_excl.id_nazione,   
           :ast_tab_sped_addr_excl.x_datins,   
           :ast_tab_sped_addr_excl.x_utente   
           )  
		using kguo_sqlca_db_magazzino; 
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = &
		"Errore in inserimento nuova riga di 'Esclusione Indirizzo DDT' " &	
						+ "~n~rErrore:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//---- COMMIT....	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if ast_tab_sped_addr_excl.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_sped_addr_excl.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	
		k_return = get_last_id_sped_addr_excl( )
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

public function long tb_delete (st_tab_sped_addr_excl ast_tab_sped_addr_excl) throws uo_exception;//
//------------------------------------------------------------------
//--- Cancella riga dalla tabella 
//--- 
//--- Ritorna: il ID rimosso
//--- 
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())

	if_sicurezza(kkg_flag_modalita.modifica)  // Controllo se utente autorizzato

	delete from sped_addr_excl
			where id_sped_addr_excl = :ast_tab_sped_addr_excl.id_sped_addr_excl
		using kguo_sqlca_db_magazzino; 
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = &
		"Errore in cancellazione riga di 'Esclusione Indirizzo DDT' (id " &
						+ string(ast_tab_sped_addr_excl.id_sped_addr_excl, "0") &	
						+ ")~n~rErrore:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//---- COMMIT....	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if ast_tab_sped_addr_excl.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_sped_addr_excl.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	
		k_return = ast_tab_sped_addr_excl.id_sped_addr_excl	
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

on kuf_sped_addr_excl.create
call super::create
end on

on kuf_sped_addr_excl.destroy
call super::destroy
end on

