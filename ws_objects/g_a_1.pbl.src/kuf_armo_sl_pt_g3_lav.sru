$PBExportHeader$kuf_armo_sl_pt_g3_lav.sru
forward
global type kuf_armo_sl_pt_g3_lav from kuf_parent
end type
end forward

global type kuf_armo_sl_pt_g3_lav from kuf_parent
end type
global kuf_armo_sl_pt_g3_lav kuf_armo_sl_pt_g3_lav

type variables
//
public st_tab_armo_sl_pt_g3_lav kist_tab_armo_sl_pt_g3_lav

end variables

forward prototypes
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
public subroutine if_isnull (st_tab_armo_sl_pt_g3_lav ast_tab_armo_sl_pt_g3_lav)
public function boolean tb_delete (st_tab_armo_sl_pt_g3_lav ast_tab_armo_sl_pt_g3_lav) throws uo_exception
public subroutine _readme ()
public function long get_id_armo_sl_pt_g3_lav_max () throws uo_exception
public function long tb_add (ref st_tab_armo_sl_pt_g3_lav ast_tab_armo_sl_pt_g3_lav) throws uo_exception
public function boolean tb_update (ref st_tab_armo_sl_pt_g3_lav ast_tab_armo_sl_pt_g3_lav) throws uo_exception
public function long set_armo_sl_pt_g3_lav (ref st_tab_armo_sl_pt_g3_lav ast_tab_armo_sl_pt_g3_lav) throws uo_exception
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
end prototypes

public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception;//------------------------------------------------------------------------------------------------------
//---  Controllo dati utente
//---  inp: datastore con i dati da controllare
//---  out: datastore con  	ads_inp.object.<nome campo>.tag che può valere:
//												0=tutto OK (kkg_esito.ok); 
//												1=errore logico (bloccante) (kkg_esito.ERR_LOGICO); 
//												2=errore forma  (bloccante) (kkg_esito.err_formale);
//												3=dati insufficienti  (bloccante) (kkg_esito.DATI_INSUFF);
//												4=KO ma errore non grave  (NON bloccante) (kkg_esito.DB_WRN);
//---							               	5=OK con degli avvertimenti (NON bloccante) (kkg_esito.DATI_WRN);
//---  rit: 
//---
//---  per errore lancia EXCEPTION anche x i warning
//---
//------------------------------------------------------------------------------------------------------
//
int k_errori = 0
long k_nr_righe
int k_riga
string k_tipo_errore="0"
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if trim(ads_inp.object.ngiri[1]) > " "  then
	else
		k_errori ++
		k_tipo_errore="3"      // errore in questo campo: dati insuff.
		ads_inp.object.descr.tag = k_tipo_errore 
		kst_esito.esito = kkg_esito.err_formale
		kst_esito.sqlerrtext = "Manca il valore nel campo " + trim(ads_inp.object.ngiri_t.text) + kkg.acapo
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if	
	if trim(ads_inp.object.ciclo_target[1]) > " "  then
	else
		k_errori ++
		k_tipo_errore="3"      // errore in questo campo: dati insuff.
		ads_inp.object.descr.tag = k_tipo_errore 
		kst_esito.esito = kkg_esito.err_formale
		kst_esito.sqlerrtext = "Manca il valore nel campo " + trim(ads_inp.object.ciclo_target_t.text) + kkg.acapo
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if	

	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if k_errori > 0 then
		
	end if
	
end try


return kst_esito


 
 
 
end function

public subroutine if_isnull (st_tab_armo_sl_pt_g3_lav ast_tab_armo_sl_pt_g3_lav);
if isnull(ast_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav  ) then ast_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav = 0
if isnull(ast_tab_armo_sl_pt_g3_lav.id_armo  ) then ast_tab_armo_sl_pt_g3_lav.id_armo = 0
if isnull(ast_tab_armo_sl_pt_g3_lav.id_sl_pt_g3_lav  ) then ast_tab_armo_sl_pt_g3_lav.id_sl_pt_g3_lav = 0
if isnull(ast_tab_armo_sl_pt_g3_lav.descr  ) then ast_tab_armo_sl_pt_g3_lav.descr = ""
if isnull(ast_tab_armo_sl_pt_g3_lav.x_datins  ) then ast_tab_armo_sl_pt_g3_lav.x_datins = datetime(date(0))
if isnull(ast_tab_armo_sl_pt_g3_lav.x_utente  ) then ast_tab_armo_sl_pt_g3_lav.x_utente = ""

end subroutine

public function boolean tb_delete (st_tab_armo_sl_pt_g3_lav ast_tab_armo_sl_pt_g3_lav) throws uo_exception;/*
  Cancella il rek dalla tabella
     Inp:  st_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav
	  Rit:  TRUE = operazione effettuata
*/
boolean k_return = false


	kguo_exception.inizializza(this.classname())

	this.if_sicurezza(kkg_flag_modalita.cancellazione) // Verifica di Sicurezza
	
	if ast_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav > 0 then
	else
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlerrtext = "Cancellazione del Piano di Trattamento in Deroga Non Effettuata. Manca ID."
		throw kguo_exception
	end if
		
//--- CANCELLA --------------------------------------------------------------------------------------------------------------------------------------------------------
		
	delete from armo_sl_pt_g3_lav
				where id_armo_sl_pt_g3_lav = :ast_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav
				using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
					"Errore in Cancellazione del Piano di Trattamento in Deroga, Id " + string(ast_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav))		
		if ast_tab_armo_sl_pt_g3_lav.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		throw kguo_exception
	end if

	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if ast_tab_armo_sl_pt_g3_lav.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		
		k_return = true
	end if
		

return k_return

end function

public subroutine _readme ();// Tabella con i dati in deroga sui dati di Trattamento G3 per una determinata riga Lotto
end subroutine

public function long get_id_armo_sl_pt_g3_lav_max () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo id inserito 
//--- 
//---  input: 
//---  ret: max id_armo_sl_pt_g3_lav
//---                                     
//------------------------------------------------------------------
//
long k_return


	kguo_exception.inizializza(this.classname())

	SELECT coalesce(max(id_armo_sl_pt_g3_lav), 0)
		 INTO 
				:k_return
		 FROM armo_sl_pt_g3_lav  
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in lettura ultimo Id in tabella dati Trattamento in Deroga.")	
		throw kguo_exception
	end if

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
	else
		k_return = 0
	end if
	
return k_return

end function

public function long tb_add (ref st_tab_armo_sl_pt_g3_lav ast_tab_armo_sl_pt_g3_lav) throws uo_exception;/*
  Inserisce il rek in tabella
     Inp:  st_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav + dati 
	  Rit:  TRUE = operazione effettuata
*/
long k_return 


	kguo_exception.inizializza(this.classname())

	this.if_sicurezza(kkg_flag_modalita.modifica) // Verifica di Sicurezza
	
	if ast_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav > 0 then
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlerrtext = "Inserimento del Piano di Trattamento in Deroga non effettuata. ID già in archivio: " + string(ast_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav)
		throw kguo_exception
	end if
		
	ast_tab_armo_sl_pt_g3_lav.x_datins = kGuf_data_base.prendi_x_datins()
	ast_tab_armo_sl_pt_g3_lav.x_utente = kGuf_data_base.prendi_x_utente()
	
	if_isnull(ast_tab_armo_sl_pt_g3_lav)
	
	insert into armo_sl_pt_g3_lav
	    (id_armo 
		    ,id_sl_pt_g3_lav 
		    ,ciclo_target 
		    ,ngiri 
		    ,descr 
			 ,x_datins 
			 ,x_utente 
			)
			values
			(
		 	:ast_tab_armo_sl_pt_g3_lav.id_armo
			,:ast_tab_armo_sl_pt_g3_lav.id_sl_pt_g3_lav
			,:ast_tab_armo_sl_pt_g3_lav.ciclo_target
			,:ast_tab_armo_sl_pt_g3_lav.ngiri
			,:ast_tab_armo_sl_pt_g3_lav.descr
			,:ast_tab_armo_sl_pt_g3_lav.x_datins
			,:ast_tab_armo_sl_pt_g3_lav.x_utente
			)
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
					"Errore in Inserimento del Piano di Trattamento in Deroga, " &
							+ kkg.acapo + "Id riga Lotto: " + string(ast_tab_armo_sl_pt_g3_lav.id_armo) &
							+ ", Id PT G3: " + string(ast_tab_armo_sl_pt_g3_lav.id_sl_pt_g3_lav) &
							+ ", Ciclo e Numero Giri: " + string(ast_tab_armo_sl_pt_g3_lav.ciclo_target) &
							+ " e " + string(ast_tab_armo_sl_pt_g3_lav.ngiri) + ". ")		
		if ast_tab_armo_sl_pt_g3_lav.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		throw kguo_exception
	end if

	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if ast_tab_armo_sl_pt_g3_lav.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		
		ast_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav = get_id_armo_sl_pt_g3_lav_max()
		k_return = ast_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav
	end if
		

return k_return

end function

public function boolean tb_update (ref st_tab_armo_sl_pt_g3_lav ast_tab_armo_sl_pt_g3_lav) throws uo_exception;/*
  Aggiorna il rek in tabella
     Inp:  st_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav + dati 
	  Rit:  TRUE = operazione effettuata
*/
boolean k_return = false


	kguo_exception.inizializza(this.classname())

	this.if_sicurezza(kkg_flag_modalita.modifica) // Verifica di Sicurezza
	
	if ast_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav > 0 then
	else
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlerrtext = "Modifica del Piano di Trattamento in Deroga non effettuata. Manca ID."
		throw kguo_exception
	end if
		
	ast_tab_armo_sl_pt_g3_lav.x_datins = kGuf_data_base.prendi_x_datins()
	ast_tab_armo_sl_pt_g3_lav.x_utente = kGuf_data_base.prendi_x_utente()
	
	if_isnull(ast_tab_armo_sl_pt_g3_lav)
	
	update armo_sl_pt_g3_lav
	    set id_armo = :ast_tab_armo_sl_pt_g3_lav.id_armo
		    ,id_sl_pt_g3_lav = :ast_tab_armo_sl_pt_g3_lav.id_sl_pt_g3_lav
		    ,ciclo_target = :ast_tab_armo_sl_pt_g3_lav.ciclo_target
		    ,ngiri = :ast_tab_armo_sl_pt_g3_lav.ngiri
		    ,descr = :ast_tab_armo_sl_pt_g3_lav.descr
			 ,x_datins = :ast_tab_armo_sl_pt_g3_lav.x_datins
			 ,x_utente = :ast_tab_armo_sl_pt_g3_lav.x_utente
			where id_armo_sl_pt_g3_lav = :ast_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
					"Errore in Aggiornamento del Piano di Trattamento in Deroga, Id " + string(ast_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav))		
		if ast_tab_armo_sl_pt_g3_lav.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		throw kguo_exception
	end if

	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if ast_tab_armo_sl_pt_g3_lav.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		
		k_return = true
	end if
		

return k_return

end function

public function long set_armo_sl_pt_g3_lav (ref st_tab_armo_sl_pt_g3_lav ast_tab_armo_sl_pt_g3_lav) throws uo_exception;/*
  Inserisce/Aggiorna il rek in tabella
     Inp:  st_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav + dati 
	  Rit:  ID
*/
long k_return 


	if ast_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav > 0 then
		
		tb_update(ast_tab_armo_sl_pt_g3_lav)
		
	else
		
		tb_add(ast_tab_armo_sl_pt_g3_lav)
		
	end if
		
	k_return = ast_tab_armo_sl_pt_g3_lav.id_armo_sl_pt_g3_lav

return k_return

end function

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
boolean k_return 
kuf_barcode_mod_giri kuf1_barcode_mod_giri


try
	kuf1_barcode_mod_giri = create kuf_barcode_mod_giri

	k_return = kuf1_barcode_mod_giri.if_sicurezza(ast_open_w)

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_barcode_mod_giri) then destroy kuf1_barcode_mod_giri

end try	
	
return k_return	

end function

on kuf_armo_sl_pt_g3_lav.create
call super::create
end on

on kuf_armo_sl_pt_g3_lav.destroy
call super::destroy
end on

