$PBExportHeader$kuf_recover_e1_data.sru
forward
global type kuf_recover_e1_data from kuf_parent
end type
end forward

global type kuf_recover_e1_data from kuf_parent
end type
global kuf_recover_e1_data kuf_recover_e1_data

type variables
//
kuf_e1_asn kiuf_e1_asn



end variables

forward prototypes
public function boolean tb_delete (st_tab_depositi ast_tab_depositi) throws uo_exception
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function long u_run_recover_cube_data (ref uo_ds_std_1 ads_recover_e1_data) throws uo_exception
end prototypes

public function boolean tb_delete (st_tab_depositi ast_tab_depositi) throws uo_exception;/*
 Cancellazione virtuale dei dati nella tabella DEPOSITI
	inp: st_tab_deposito.id_deposito
	rit: true = aggiornato arimosso
*/
boolean k_return


try
	kguo_exception.inizializza(this.classname())

//	update DEPOSITI
//	     set deleted = 'S'
//		where id_deposito = :ast_tab_depositi.id_deposito 
//		using kguo_sqlca_db_magazzino;
//
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
						"Errore in Cancellazione del Deposito id " + string(ast_tab_depositi.id_deposito))		
		throw kguo_exception
	end if

	if ast_tab_depositi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_depositi.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if

	k_return = true
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try

return k_return

end function

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//

return kiuf_e1_asn.if_sicurezza(ast_open_w)

end function

public function long u_run_recover_cube_data (ref uo_ds_std_1 ads_recover_e1_data) throws uo_exception;/*
  Recupera i dati per CUBE tab e1_wo_f5537001
	  inp: ds 'ds_recover_e1_data'
	  ret: numero di Lotti trovati 
*/
long k_return
st_tab_certif kst_tab_certif
st_tab_meca kst_tab_meca
long k_row, k_rows
date k_data_da, k_data_a
string k_escludi_lotti_prsesenti, k_clie_3_x
uo_ds_std_1 kds_ds_meca_x_recover_e1_data
kuf_certif_print kuf1_certif_print


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

	if ads_recover_e1_data.rowcount() > 0 then
	else
		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_dati_insufficienti
		kguo_exception.kist_esito.sqlerrtext = "Recupero dati da fornire a E1 per CUBE. Operazione interrotta, mancano i dati di filtro. "
		throw kguo_exception
	end if

	k_data_da = ads_recover_e1_data.getitemdate(1, "data_da")
	k_data_a = ads_recover_e1_data.getitemdate(1, "data_a")
	k_clie_3_x = trim(ads_recover_e1_data.getitemstring( 1, "clie_3_rag_soc_10"))
	if isnumber(k_clie_3_x) then
		kst_tab_meca.clie_3 = long(k_clie_3_x)
	end if
	kst_tab_meca.impianto = ads_recover_e1_data.getitemnumber( 1, "impianto")
	if ads_recover_e1_data.getitemstring( 1, "escludi") = "S" then
		k_escludi_lotti_prsesenti = "S"
	end if

	kds_ds_meca_x_recover_e1_data = create uo_ds_std_1
	kds_ds_meca_x_recover_e1_data.dataobject = "ds_meca_x_recover_e1_data"
	kds_ds_meca_x_recover_e1_data.settransobject( kguo_sqlca_db_magazzino )
	
	k_rows = kds_ds_meca_x_recover_e1_data.retrieve(k_data_da, k_data_a, kst_tab_meca.clie_3, kst_tab_meca.impianto, k_escludi_lotti_prsesenti)
	if k_rows < 0 then
		kguo_exception.set_st_esito_err_ds(kds_ds_meca_x_recover_e1_data, "Errore in lettura Lotti da recuperare dati E1 per Cube. Ricerca periodo: " &
								+ string(k_data_da) + " - " + string(k_data_da) &
								+ "; cliente: "  + string(kst_tab_meca.clie_3) + "; Impianto: " + string(kst_tab_meca.impianto))
		throw kguo_exception
	end if
	
	kuf1_certif_print = create kuf_certif_print
	
	for k_row = 1 to k_rows
		
//--- Recupera il ID del Lotto di entrata
		kst_tab_certif.id_meca = kds_ds_meca_x_recover_e1_data.getitemnumber(k_row, "id_meca") 
		
//--- alimenta tabella dati trattamento (giri/padri) da Inviare a E1
		kuf1_certif_print.set_e1_wo_f5537001(kst_tab_certif)
				
		k_return ++
	next
		
catch (uo_exception kuo_exception)
	kuo_exception.kist_esito.sqlerrtext = "Errore in recupero dati E1 "
	if k_row > 0 and k_row <= k_rows then
		kuo_exception.kist_esito.sqlerrtext += "dopo il Lotto " + string(kst_tab_certif.id_meca) + " " 
	end if
	kuo_exception.kist_esito.sqlerrtext += kkg.acapo + "Errore: " + kuo_exception.get_errtext( )
	throw kuo_exception		
	
finally
	if isvalid(kuf1_certif_print) then destroy kuf1_certif_print
	if isvalid(kds_ds_meca_x_recover_e1_data) then destroy kds_ds_meca_x_recover_e1_data
	
	SetPointer(kkg.pointer_default)
	
end try			

return k_return

end function

on kuf_recover_e1_data.create
call super::create
end on

on kuf_recover_e1_data.destroy
call super::destroy
end on

event constructor;call super::constructor;//
kiuf_e1_asn = create kuf_e1_asn

end event

event destructor;call super::destructor;//
if isvalid(kiuf_e1_asn) then destroy kiuf_e1_asn

end event

