$PBExportHeader$kuf_sl_pt_g3.sru
forward
global type kuf_sl_pt_g3 from kuf_parent
end type
end forward

global type kuf_sl_pt_g3 from kuf_parent
end type
global kuf_sl_pt_g3 kuf_sl_pt_g3

type variables
//
public:
int kki_g3status_Proposto = 0
int kki_g3status_Autorizzato = 5
int kki_g3status_Disattivato = 9

private kuf_sl_pt kiuf_sl_pt
end variables

forward prototypes
public function boolean tb_delete (st_tab_sl_pt_g3 ast_tab_sl_pt_g3) throws uo_exception
public function st_esito anteprima (datastore kdw_anteprima, st_tab_sl_pt_g3 ast_tab_sl_pt_g3) throws uo_exception
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function boolean if_delete (long a_id_sl_pt_g3, ref string o_msg) throws uo_exception
public function long get_id_sl_pt_g3_last () throws uo_exception
public function long tb_update (st_tab_g_0 ast_tab_g_0, ref uo_ds_std_1 ads_inp) throws uo_exception
public function long get_g3_lav_ngiri_altri (ref st_tab_sl_pt_g3_lav ast_tab_sl_pt_g3_lav) throws uo_exception
public function long get_id_sl_pt_g3_lav_x_dati_lav (st_tab_sl_pt_g3_lav ast_tab_sl_pt_g3_lav) throws uo_exception
public function long get_id_sl_pt_g3_x_cod_sl_pt (st_tab_sl_pt_g3 ast_tab_sl_pt_g3) throws uo_exception
end prototypes

public function boolean tb_delete (st_tab_sl_pt_g3 ast_tab_sl_pt_g3) throws uo_exception;/*
 Cancella rek nella tabella Trattamenti Impianto G3
 Inp: st_tab_sl_pt_g3.id_sl_pt_g3
 Rit:  TRUE=OK; 
*/
boolean k_return
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if ast_tab_sl_pt_g3.id_sl_pt_g3 > 0 then
	
	delete 
			from sl_pt_g3
			WHERE id_sl_pt_g3 = :ast_tab_sl_pt_g3.id_sl_pt_g3 
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
						"Errore in Cancellazione dati Trattamento Impianto G3, Id " + string(ast_tab_sl_pt_g3.id_sl_pt_g3))
		if ast_tab_sl_pt_g3.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_sl_pt_g3.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if

		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
		
	if ast_tab_sl_pt_g3.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_sl_pt_g3.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if

	k_return = true

end if

return k_return

end function

public function st_esito anteprima (datastore kdw_anteprima, st_tab_sl_pt_g3 ast_tab_sl_pt_g3) throws uo_exception;//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore di anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
//=== 
//====================================================================
//
//=== 
long k_rc
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

try
	if_sicurezza(kkg_flag_modalita.anteprima)

	if isvalid(kdw_anteprima)  then
		if kdw_anteprima.dataobject = "d_sl_pt_g3_lav_l"  then
			if kdw_anteprima.object.codice[1] = ast_tab_sl_pt_g3.cod_sl_pt  then
				ast_tab_sl_pt_g3.cod_sl_pt = " " 
			end if
		end if
	end if

	if trim(ast_tab_sl_pt_g3.cod_sl_pt) > " " then
	
		kdw_anteprima.dataobject = "d_sl_pt_g3_lav_l"		
		kdw_anteprima.settransobject(sqlca)

		k_rc=kdw_anteprima.retrieve(ast_tab_sl_pt_g3.cod_sl_pt)
	
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Trattamento Impianto G3 da visualizzare: ~n~r" + "nessun Codice PT indicato"
		kst_esito.esito = kkg_esito.bug
		
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kst_esito.nome_oggetto = this.classname()
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception

finally
	
end try


return kst_esito

end function

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return kiuf_sl_pt.if_sicurezza(ast_open_w)

end function

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Attiva LINK cliccato (funzione di ZOOM)
//---
//--- Par. Inut: 
//---               datawindow su cui è stato attivato il LINK
//---               nome campo di LINK
//--- 
//--- Ritorna TRUE tutto OK - FALSE: link non effettuato
//---
//--- Lancia EXCEPTION con  ST_ESITO  standard
//---
//----------------------------------------------------------------------------------------------------------------
// 
long k_rc
boolean k_return=true
string k_title
kuf_elenco kuf1_elenco
st_tab_sl_pt_g3 kst_tab_sl_pt_g3
st_esito kst_esito
datastore kdsi_elenco_output   //ds da passare alla windows di elenco


try
	if_sicurezza(kkg_flag_modalita.anteprima)  // verifica sicurezza
	
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza( )
	
	kdsi_elenco_output = create datastore
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	choose case a_campo_link
	
		case "sl_pt_g3"
			kst_tab_sl_pt_g3.cod_sl_pt = adw_link.getitemstring(adw_link.getrow(), "cod_sl_pt" )
			if trim(kst_tab_sl_pt_g3.cod_sl_pt) > " " then
				kst_esito = this.anteprima ( kdsi_elenco_output, kst_tab_sl_pt_g3 )
				if kst_esito.esito <> kkg_esito.ok then
					kguo_exception.inizializza( )
					kguo_exception.set_esito( kst_esito)
					throw kguo_exception
				end if
				k_title = "Trattamenti Impianto G3 per il Piano: " + trim(kst_tab_sl_pt_g3.cod_sl_pt) 
			else
				k_return = false
			end if
	
	end choose
	
	if k_return then
	
		if kdsi_elenco_output.rowcount() > 0 then
			
			kuf1_elenco = create kuf_elenco
			kuf1_elenco.u_open_zoom(k_title, a_campo_link, kdsi_elenco_output) //CAMPO DI LINK + DATASTORE CON I DATI
	
		else
			
			kguo_exception.setmessage(u_get_errmsg_nontrovato(kkg_flag_modalita.elenco))
			throw kguo_exception
					
		end if
	
	end if
	

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally 
	if isvalid(kuf1_elenco) then destroy kuf1_elenco
	SetPointer(kkg.pointer_default)
	
end try


return k_return

end function

public function boolean if_delete (long a_id_sl_pt_g3, ref string o_msg) throws uo_exception;/*
  Verifica se possibile cancellare la riga in tabella
  inp: id_sl_pt_g3  da cancellare
  out: messaggio di output (eventuale motivo per non cancellare) 
  ret: TRUE = cancellabile
*/
boolean k_return
int k_row, k_rows
uo_ds_std_1 kds_1


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
	kds_1 = create uo_ds_std_1
	kds_1.dataobject = "ds_barcode_l_x_id_sl_pt_g3"
	k_rows = kds_1.retrieve(a_id_sl_pt_g3)
	
	if k_rows < 0 then
		kguo_exception.inizializza(this.classname())
		kguo_exception.set_esito(kds_1.kist_esito)
		kguo_exception.kist_esito.sqlerrtext = "Errore in verifica cancellazione Piano di Trattamento G3 in tabella Barcode, id Piano " + string(a_id_sl_pt_g3) + ". " + kkg.acapo + kds_1.kist_esito.sqlerrtext
		kguo_exception.messaggio_utente( )
		throw kguo_exception
	end if

	if k_row > 0 then
		
		o_msg = "Non è possibile rimuovere il Piano di Trattamento Impianto G3 id " + + string(a_id_sl_pt_g3) + ", già utilizzato nei barcode come questi " &
				+ kkg.acapo 
				
		if k_rows > 10 then k_rows = 10
		for k_row = 1 to k_rows - 1
			o_msg = o_msg + trim(kds_1.getitemstring(k_row, "barcode"))	+ ", "
		next
		o_msg = o_msg + trim(kds_1.getitemstring(k_row, "barcode"))	
		
	else
		
		k_return = true
		
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
	SetPointer(kkg.pointer_default)

end try


return k_return
end function

public function long get_id_sl_pt_g3_last () throws uo_exception;/*
    Torna l'ultimo id caricato
    inp: 
    Out:
    Rit: ID
*/
long k_id


	kguo_exception.inizializza(this.classname())

	select max(id_sl_pt_g3)
		 into :k_id
		from sl_pt_g3
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Lettura ultimo ID caricato in tabella Piani di Trattamento G3. ")
		throw kguo_exception
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode > 0 then
		k_id = 0
	else
		if isnull(k_id) then k_id = 0
	end if
	
return k_id


end function

public function long tb_update (st_tab_g_0 ast_tab_g_0, ref uo_ds_std_1 ads_inp) throws uo_exception;/*
  Carica o Aggiorna dati PT del G3
  Inp: st_tab_g_0 info se fare la commit
       ds con la TESTATA del PT (d_sl_pt) o cmq coi i campi che inziano con il nome g3_
  Out: ds eventualemente aggiornato
  Rit: zero nessun aggiornamento altrimenti id_sl_pt_g3
*/
long k_return 
uo_ds_std_1 kds_1
int k_row, k_rc


try
	SetPointer(kkg.pointer_attesa)

	kguo_exception.inizializza(this.classname())

	if not isvalid(ads_inp) then
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlerrtext ="Errore in lettura Piano di Trattamento G3, dati non presenti/leggibili !" 
		throw kguo_exception
	end if
	
	if ads_inp.rowcount() > 0 and ads_inp.getitemstring(1,"g3_cod_sl_pt") >"" then
	else
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlerrtext ="Errore in lettura Piano di Trattamento G3, codice Piano non presente !" 
		throw kguo_exception
	end if

	kds_1 = create uo_ds_std_1
	kds_1.dataobject ="ds_sl_pt_g3"
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	if ads_inp.getitemnumber(1,"id_sl_pt_g3") > 0 then
		k_row = kds_1.retrieve(ads_inp.getitemnumber(1,"id_sl_pt_g3"))
		if k_row < 0 then
			kguo_exception.set_esito(kds_1.kist_esito)
			kguo_exception.kist_esito.sqlerrtext ="Errore in lettura Piano di Trattamento G3 '" + trim(ads_inp.getitemstring(1,"g3_cod_sl_pt")) +"'." + kkg.acapo + kds_1.kist_esito.sqlerrtext
			throw kguo_exception
		end if
	end if

	if k_row = 0 then
		k_row = kds_1.insertrow(0)
	end if

	if k_row > 0 then
	
		kds_1.setitem(k_row,"cod_sl_pt", ads_inp.getitemstring(1,"g3_cod_sl_pt"))
		kds_1.setitem(k_row,"peso", ads_inp.getitemstring(1,"g3_peso"))
		kds_1.setitem(k_row,"pesomax", ads_inp.getitemstring(1,"g3_pesomax"))
		kds_1.setitem(k_row,"mis_x", ads_inp.getitemnumber(1,"g3_mis_x"))
		kds_1.setitem(k_row,"mis_y", ads_inp.getitemnumber(1,"g3_mis_y"))
		kds_1.setitem(k_row,"mis_z", ads_inp.getitemnumber(1,"g3_mis_z"))
		kds_1.setitem(k_row,"dosim_x_bcode", ads_inp.getitemnumber(1,"g3_dosim_x_bcode"))
		kds_1.setitem(k_row,"dosim_delta_bcode", ads_inp.getitemnumber(1,"g3_dosim_delta_bcode"))
		kds_1.setitem(k_row,"dosim_et_descr"  , ads_inp.getitemstring(1,"g3_dosim_et_descr"))
		kds_1.setitem(k_row,"dosim_et_descr_1" , ads_inp.getitemstring(1,"g3_dosim_et_descr_1"))
		kds_1.setitem(k_row,"dosetgminmin", ads_inp.getitemnumber(1,"g3_dosetgminmin"))
		kds_1.setitem(k_row,"dosetgminmax", ads_inp.getitemnumber(1,"g3_dosetgminmax"))
		kds_1.setitem(k_row,"dosetgmaxmin", ads_inp.getitemnumber(1,"g3_dosetgmaxmin"))
		kds_1.setitem(k_row,"dosetgmaxmax", ads_inp.getitemnumber(1,"g3_dosetgmaxmax"))
		kds_1.setitem(k_row,"dosetgminfattcorr", ads_inp.getitemnumber(1,"g3_dosetgminfattcorr"))
		kds_1.setitem(k_row,"dosetgmaxfattcorr", ads_inp.getitemnumber(1,"g3_dosetgmaxfattcorr"))
		kds_1.setitem(k_row,"dosetgmintcalc", ads_inp.getitemstring(1,"g3_dosetgmintcalc"))
		kds_1.setitem(k_row,"dosetgmaxtcalc", ads_inp.getitemstring(1,"g3_dosetgmaxtcalc"))
		kds_1.setitem(k_row,"dosetgminfattcorr_max", ads_inp.getitemnumber(1,"g3_dosetgminfattcorr_max"))
		kds_1.setitem(k_row,"dosetgmaxfattcorr_max", ads_inp.getitemnumber(1,"g3_dosetgmaxfattcorr_max"))
		kds_1.setitem(k_row,"dosetgmintcalc_max", ads_inp.getitemstring(1,"g3_dosetgmintcalc_max"))
		kds_1.setitem(k_row,"dosetgmaxtcalc_max", ads_inp.getitemstring(1,"g3_dosetgmaxtcalc_max"))
		kds_1.setitem(k_row,"unitwork", ads_inp.getitemnumber(1,"g3_unitwork"))
		kds_1.setitem(k_row,"savedosimeter", ads_inp.getitemnumber(1,"g3_savedosimeter"))
		kds_1.setitem(k_row,"densita", ads_inp.getitemnumber(1,"g3_densita"))
		kds_1.setitem(k_row,"densitamax", ads_inp.getitemnumber(1,"g3_densitamax"))
		kds_1.setitem(k_row,"notecliente", ads_inp.getitemstring(1,"g3_notecliente"))
		kds_1.setitem(k_row,"note_descr", ads_inp.getitemstring(1,"g3_note_descr"))

		if kds_1.getnextmodified(0, Primary!) > 0 then

			kds_1.setitem(k_row,"x_datins", kGuf_data_base.prendi_x_datins())
			kds_1.setitem(k_row,"x_utente", kGuf_data_base.prendi_x_utente())

			k_rc = kds_1.update( )
			if k_rc > 0 then
				
				if ast_tab_g_0.esegui_commit ="N" then
				else
					kguo_sqlca_db_magazzino.db_commit()
				end if
				
				if kds_1.getitemnumber(1,"id_sl_pt_g3") > 0 then
				else
					kds_1.setitem(k_row,"id_sl_pt_g3", get_id_sl_pt_g3_last( ))  // recupera ID ultimo caricato
				end if
				
				ads_inp.setitem(k_row,"id_sl_pt_g3", kds_1.getitemnumber(1,"id_sl_pt_g3"))
				ads_inp.setitem(k_row,"x_datins", kds_1.getitemdatetime(1,"x_datins"))
				ads_inp.setitem(k_row,"x_utente", kds_1.getitemstring(1,"x_utente"))
				
				k_return = kds_1.getitemnumber(1,"id_sl_pt_g3")
				
			else
				kguo_exception.inizializza(this.classname())
				kguo_exception.set_st_esito_err_ds(kds_1, "Errore in Aggiornamento Piano di Trattamento G3 '" + trim(ads_inp.getitemstring(1,"g3_cod_sl_pt")) + ". ")
				throw kguo_exception
			end if
			
		end if	
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1

	SetPointer(kkg.pointer_default)

end try
	
return k_return
end function

public function long get_g3_lav_ngiri_altri (ref st_tab_sl_pt_g3_lav ast_tab_sl_pt_g3_lav) throws uo_exception;/*
    Torna dati del Trattamento
    inp: st_tab_sl_pt_g3_lav.id_sl_pt_g3_lav
    Out:st_tab_sl_pt_g3_lav dati di trattamento
    Rit: ngiri
*/
long k_id


	kguo_exception.inizializza(this.classname())

	select isnull(ngiri, 0),
	 		 isnull(g3npass, 0),
			 isnull(ciclo_min, 0), 
			 isnull(ciclo_max, 0),
			 isnull(ciclo_target, 0)
		 into :ast_tab_sl_pt_g3_lav.ngiri
		     ,:ast_tab_sl_pt_g3_lav.g3npass
			  ,:ast_tab_sl_pt_g3_lav.ciclo_min
			  ,:ast_tab_sl_pt_g3_lav.ciclo_max		
			  ,:ast_tab_sl_pt_g3_lav.ciclo_target
		from sl_pt_g3_lav
		where sl_pt_g3_lav.id_sl_pt_g3_lav = :ast_tab_sl_pt_g3_lav.id_sl_pt_g3_lav
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Lettura dati Lavorazione in tabella Piani di Trattamento G3 (sl_pt_g3_lav). Id " + string(ast_tab_sl_pt_g3_lav.id_sl_pt_g3_lav))
		throw kguo_exception
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_id = ast_tab_sl_pt_g3_lav.ngiri
	end if
	
return k_id


end function

public function long get_id_sl_pt_g3_lav_x_dati_lav (st_tab_sl_pt_g3_lav ast_tab_sl_pt_g3_lav) throws uo_exception;/*
    Torna id_sl_pt_g3_lav attivo
    inp: st_tab_sl_pt_g3_lav.id_sl_pt_g3, g3npass, ngiri, ciclo_target (ciclo compreso tra min e max)
    Out:
    Rit: ID
*/


	kguo_exception.inizializza(this.classname())

	select id_sl_pt_g3_lav
	   into :ast_tab_sl_pt_g3_lav.id_sl_pt_g3_lav
	   from sl_pt_g3_lav 
		where sl_pt_g3_lav.id_sl_pt_g3 = :ast_tab_sl_pt_g3_lav.id_sl_pt_g3 
	     and sl_pt_g3_lav.g3npass = :ast_tab_sl_pt_g3_lav.g3npass
		  and sl_pt_g3_lav.ngiri = :ast_tab_sl_pt_g3_lav.ngiri
		  and sl_pt_g3_lav.g3status = '5' 
 		  and :ast_tab_sl_pt_g3_lav.ciclo_target between sl_pt_g3_lav.ciclo_min and sl_pt_g3_lav.ciclo_max
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
						"Errore in Lettura ID del Piani di Trattamento G3 da dati di " &
						+ kkg.acapo + "N.pass. " + string(ast_tab_sl_pt_g3_lav.g3npass) & 
						+ ", N.Giri " + string(ast_tab_sl_pt_g3_lav.g3npass) & 
						+ ", Ciclo " + string(ast_tab_sl_pt_g3_lav.ciclo_target) & 
						+ ", id G3 "  + string(ast_tab_sl_pt_g3_lav.id_sl_pt_g3) + ".")
		throw kguo_exception
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode > 0 then
		ast_tab_sl_pt_g3_lav.id_sl_pt_g3_lav = 0
	else
		if isnull(ast_tab_sl_pt_g3_lav.id_sl_pt_g3_lav) then ast_tab_sl_pt_g3_lav.id_sl_pt_g3_lav = 0
	end if
	
return ast_tab_sl_pt_g3_lav.id_sl_pt_g3_lav


end function

public function long get_id_sl_pt_g3_x_cod_sl_pt (st_tab_sl_pt_g3 ast_tab_sl_pt_g3) throws uo_exception;/*
    Torna id_sl_pt_g3
    inp: st_tab_sl_pt_g3.cod_sl_pt
    Out:
    Rit: ID
*/


	kguo_exception.inizializza(this.classname())

	select id_sl_pt_g3
	   into :ast_tab_sl_pt_g3.id_sl_pt_g3
	   from sl_pt_g3 
		where sl_pt_g3.cod_sl_pt = :ast_tab_sl_pt_g3.cod_sl_pt 
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
						"Errore in Lettura ID del Piani di Trattamento G3 dal Codice " &
						+ string(ast_tab_sl_pt_g3.cod_sl_pt)+ ".")
		throw kguo_exception
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode > 0 then
		ast_tab_sl_pt_g3.id_sl_pt_g3 = 0
	else
		if isnull(ast_tab_sl_pt_g3.id_sl_pt_g3) then ast_tab_sl_pt_g3.id_sl_pt_g3 = 0
	end if
	
return ast_tab_sl_pt_g3.id_sl_pt_g3


end function

on kuf_sl_pt_g3.create
call super::create
end on

on kuf_sl_pt_g3.destroy
call super::destroy
end on

event constructor;call super::constructor;//
kiuf_sl_pt = create kuf_sl_pt
end event

event destructor;call super::destructor;//
if isvalid(kiuf_sl_pt) then destroy kiuf_sl_pt

end event

