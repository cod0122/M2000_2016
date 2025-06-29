﻿$PBExportHeader$kuf_meca_set_e1srst.sru
forward
global type kuf_meca_set_e1srst from kuf_parent0
end type
end forward

global type kuf_meca_set_e1srst from kuf_parent0
end type
global kuf_meca_set_e1srst kuf_meca_set_e1srst

type variables
//
kuf_armo kiuf_armo
end variables

forward prototypes
public function long u_set_stato_lotto_da_e1 () throws uo_exception
public function st_esito u_batch_run () throws uo_exception
public function integer u_meca_annulla (st_tab_e1_asn ast_tab_e1_asn[])
end prototypes

public function long u_set_stato_lotto_da_e1 () throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------
//--- Importa STATO lotto da E1 (lotti APERTI e con lo stato non a 95)
//--- 
//--- Input: 
//--- out: 
//--- Rit: numero lotti aggiornati con un valore > di spazio
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
long k_return
long k_righe_ds_1, k_righe_changed_first
long k_righe_daelab, k_rc, k_riga_tab, k_tab_e1_asn_nrows, k_riga_find_ds_1
long k_righe_changed, k_canceled // canceled = Lotti da Annullare (no cancellare)
long k_riga
uo_ds_std_1 kds_1
kuf_e1_asn kuf1_e1_asn
st_tab_e1_asn kst_tab_e1_asn[]
st_tab_e1_asn kst_tab_e1_asn_ann[]
st_tab_meca kst_tab_meca
st_esito kst_esito


try

	kst_esito = kguo_exception.inizializza(this.classname())
	
	kguo_sqlca_db_magazzino.db_commit( )  // forse risolve problema sulle TemporalTable
	
	kuf1_e1_asn = create kuf_e1_asn

	kds_1 = create uo_ds_std_1
	kds_1.dataobject = "ds_meca_aperti_nostato95"
	kds_1.settransobject( kguo_sqlca_db_magazzino )
	k_righe_ds_1 = kds_1.retrieve() // estrazione ID lotti x aggiornare lo STATO
	if k_righe_ds_1 < 0 then
		kguo_exception.set_st_esito_err_ds(kds_1, "Errore in lettura Lotti Aperti per aggiornamento dello STATO da E1 (" + trim(kds_1.dataobject)+"). ")
		throw kguo_exception
	end if

//--- Tratta non più di 600 righe alla volta...		
	if k_righe_ds_1 < 600 then
		k_righe_daelab = k_righe_ds_1 
	else
		k_righe_daelab = 600 
	end if

	for k_riga = 1 to k_righe_daelab
//--- Prepara l'array: imposta ASN (id_meca) x get STATO da E1
		kst_tab_e1_asn[k_riga].wammcu = kguo_g.E1MCU
		kst_tab_e1_asn[k_riga].waapid = string(kds_1.getitemnumber(k_riga, "id"))
	next
		
//--- Get STATO dei ASN da E1
	k_tab_e1_asn_nrows = kuf1_e1_asn.u_get_stato(kst_tab_e1_asn[])
		
	kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()

//--- Imposta STATO del ASN
	k_righe_changed = 0
	for k_riga_tab = 1 to k_righe_daelab
		kst_tab_e1_asn[k_riga_tab].wasrst = trim(kst_tab_e1_asn[k_riga_tab].wasrst)
		if kst_tab_e1_asn[k_riga_tab].wasrst > " " then

			k_riga_find_ds_1 = kds_1.find( "id = " + kst_tab_e1_asn[k_riga_tab].waapid + " ", 1, k_righe_ds_1)
			if k_riga_find_ds_1 > 0 then
					
				if trim(kds_1.getitemstring(k_riga_find_ds_1, "e1srst")) <> kst_tab_e1_asn[k_riga_tab].wasrst then
					
					k_righe_changed ++
					if k_righe_changed_first = 0 then k_righe_changed_first = k_righe_changed
					
					kds_1.setitem(k_riga_find_ds_1, "e1srst", kst_tab_e1_asn[k_riga_tab].wasrst)
					kds_1.setitem(k_riga_find_ds_1, "x_datins", kst_tab_meca.x_datins)
					kds_1.setitem(k_riga_find_ds_1, "x_utente", kst_tab_meca.x_utente)
					
					// se ce ne sono da Annullare....
					if kst_tab_e1_asn[k_riga_tab].wasrst = kuf1_e1_asn.kki_status_canceled then 
						k_canceled++
						kst_tab_e1_asn_ann[k_canceled] = kst_tab_e1_asn[k_riga_tab]
					end if
					
				end if
					
			end if
		end if
		kst_tab_e1_asn[k_riga_tab].wasrst = "" // già trattata la pulisco
	next
		
	if k_righe_changed > 0 then
		k_return = k_righe_changed 

		k_rc = kds_1.update( )  // AGGIORNA STATO!!
		if k_rc < 0 then
			kguo_exception.set_st_esito_err_ds(kds_1, &
							"Errore in aggiornamento da E1 dello 'Stato' di " + string(k_righe_changed) &
							+ " Lotti (MECA). Da cancellare erano " + string(k_canceled) + " Lotti." &
							+ "Il primo ID da aggiornare '" + string(kds_1.getitemnumber(k_righe_changed_first, "id")) + "' ")
			throw kguo_exception
		end if
		kguo_sqlca_db_magazzino.db_commit( )
		
		if k_canceled > 0 then
			u_meca_annulla(kst_tab_e1_asn_ann[])  // ANNULLA LOTTI
		end if
		
	end if		
	
	
catch (uo_exception kuo_exception) 
	throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
	if isvalid(kuf1_e1_asn) then destroy kuf1_e1_asn

end try

return k_return


end function

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
int k_ctr
st_esito kst_esito


try 

	kst_esito = kguo_exception.inizializza(this.classname())

//--- Imposta STATO Lotto di E1 su MECA
	k_ctr = u_set_stato_lotto_da_e1( )
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Operazione conclusa correttamente." &
									+ "Sono stati aggiornati " + string(k_ctr) + " STATI Lotto di E1 (wasrst). Dati ottenuti dal Sistema E-ONE" 
	else
		kst_esito.SQLErrText = "Operazione conclusa. Nessun nuovo STATO Lotto E1  (wasrst) importato da E-ONE."
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

public function integer u_meca_annulla (st_tab_e1_asn ast_tab_e1_asn[]);/*
    Imposta ANNULLATO sul Lotto
	 Inp: st_tab_e1_asn[] elenco lotti da annullare
	 Out: numero lotti annullati
*/
int k_righe_daelab, k_riga_tab
int k_return
st_tab_meca kst_tab_meca
st_esito kst_esito
kuf_armo kuf1_armo


try

	kst_esito = kguo_exception.inizializza(this.classname())

	k_righe_daelab = upperbound(ast_tab_e1_asn[])

	kuf1_armo = create kuf_armo

	kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()
	
//--- se ASN annullato allora ANNULLA anche il Lotto					
	for k_riga_tab = 1 to k_righe_daelab
		if isnumber(ast_tab_e1_asn[k_riga_tab].waapid) then
			kst_tab_meca.id = long(ast_tab_e1_asn[k_riga_tab].waapid)
			kst_tab_meca.st_tab_g_0.esegui_commit = "S"
			kuf1_armo.set_lotto_annullato_no_sr(kst_tab_meca)
			kst_tab_meca.meca_blk_descrizione = ""
			kst_tab_meca.meca_blk_descrizione = kuf1_armo.get_meca_blk_descrizione(kst_tab_meca)
			kst_tab_meca.meca_blk_descrizione = "Lotto ASN/ID = '" + trim(ast_tab_e1_asn[k_riga_tab].waapid) + "'" &
									+ " Annullato in automatico il " + string(kGuf_data_base.prendi_x_datins(), "dd.mmm.yy hh:mm") &
											+ " durante l'importazione dello 'STATO' da E1 "  &
									+ " (stato='" + ast_tab_e1_asn[k_riga_tab].wasrst + "'); " &
									+ trim(kst_tab_meca.meca_blk_descrizione)
			kuf1_armo.set_meca_blk_descrizione(kst_tab_meca)
			
			k_return ++
			
		end if
	next
	
catch (uo_exception kuo_exception) 
	throw kuo_exception
	
finally
	if isvalid(kuf1_armo) then destroy kuf1_armo

end try

return k_return
end function

on kuf_meca_set_e1srst.create
call super::create
end on

on kuf_meca_set_e1srst.destroy
call super::destroy
end on

event constructor;call super::constructor;//
kiuf_armo = create kuf_armo

end event

event destructor;call super::destructor;//
if isvalid(kiuf_armo) then destroy kiuf_armo

end event

