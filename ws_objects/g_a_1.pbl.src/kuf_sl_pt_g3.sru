﻿$PBExportHeader$kuf_sl_pt_g3.sru
forward
global type kuf_sl_pt_g3 from kuf_parent
end type
end forward

global type kuf_sl_pt_g3 from kuf_parent
end type
global kuf_sl_pt_g3 kuf_sl_pt_g3

type variables
//
kuf_sl_pt kiuf_sl_pt
end variables

forward prototypes
public function boolean tb_delete (st_tab_sl_pt_g3 ast_tab_sl_pt_g3) throws uo_exception
public function st_esito anteprima (datastore kdw_anteprima, st_tab_sl_pt_g3 ast_tab_sl_pt_g3) throws uo_exception
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function boolean if_delete (long a_id_sl_pt_g3, ref string o_msg) throws uo_exception
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
		if kdw_anteprima.dataobject = "d_sl_pt_g3_l"  then
			if kdw_anteprima.object.codice[1] = ast_tab_sl_pt_g3.cod_sl_pt  then
				ast_tab_sl_pt_g3.cod_sl_pt = " " 
			end if
		end if
	end if

	if trim(ast_tab_sl_pt_g3.cod_sl_pt) > " " then
	
		kdw_anteprima.dataobject = "d_sl_pt_g3_l"		
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
	
		case "b_sl_pt_g3"
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
