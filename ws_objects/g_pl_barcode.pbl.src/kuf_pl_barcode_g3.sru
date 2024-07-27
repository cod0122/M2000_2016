$PBExportHeader$kuf_pl_barcode_g3.sru
forward
global type kuf_pl_barcode_g3 from kuf_parent
end type
end forward

global type kuf_pl_barcode_g3 from kuf_parent
end type
global kuf_pl_barcode_g3 kuf_pl_barcode_g3

type variables
//
kuf_pl_barcode kiuf_pl_barcode
end variables

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function st_tab_e1_wo_f5548014 u_get_e1_ws_f5548014_pianif (st_tab_barcode ast_tab_barcode) throws uo_exception
private subroutine u_set_tab_barcode (readonly uo_ds_std_1 kds_pilota_pallet_in_g3, ref st_tab_barcode kst_tab_barcode)
private subroutine importa_trattati_pilota_g3_e1 (ref ds_pilota_pallet_out_g3 ads_pilota_pallet_out_g3, ref st_tab_barcode kst_tab_barcode, ref kuf_e1_wo_f5548014 kuf1_e1_wo_f5548014, ref kuf_barcode kuf1_barcode, ref st_tab_meca ast_tab_meca) throws uo_exception
public function integer importa_inizio_lav_pilota_g3 () throws uo_exception
private function integer importa_trattati_pilota_g3_1 (ds_pilota_pallet_out_g3 ads_pilota_pallet_out_g3, kuf_barcode auf1_barcode) throws uo_exception
public function integer importa_trattati_pilota_g3 () throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return kiuf_pl_barcode.if_sicurezza(ast_open_w)

end function

public function st_tab_e1_wo_f5548014 u_get_e1_ws_f5548014_pianif (st_tab_barcode ast_tab_barcode) throws uo_exception;/*
  Imposta alcuni dati circa la pianificazione dei barcode da passare a E1
  Inp: ast_tab_barcode.id_meca ast_tab_barcode.barcode
  Out: st_tab_e1_wo_f5548014 ciclo_os55gs25c, ngiri_ossetl, tcicli_osmmcu
*/  
st_tab_barcode kst_tab_barcode_padre
st_tab_e1_wo_f5548014 kst_tab_e1_wo_f5548014
kuf_barcode kuf1_barcode
kuf_e1 kuf1_e1
kuf_impianto kuf1_impianto


	try  

		kguo_exception.inizializza(this.classname())

		kuf1_barcode = create kuf_barcode
//		kuf1_e1_wo_f5548014 = create kuf_e1_wo_f5548014
		kuf1_e1 = create kuf_e1

		kst_tab_barcode_padre = ast_tab_barcode
		if trim(ast_tab_barcode.barcode_lav) > " " then
			kst_tab_barcode_padre.barcode = ast_tab_barcode.barcode_lav // mette il BARCODE PADRE
		end if

//--- set num giri del trattamento							
		kuf1_barcode.get_fila_tot_x_id_meca(ast_tab_barcode)  // calcolo dei giri totali pianificati dei barcode per lotto
		kst_tab_e1_wo_f5548014.ngiri_ossetl = ast_tab_barcode.g3ngiri

//--- set workcenters del trattamento						
		kuf1_barcode.get_g3npass(kst_tab_barcode_padre)  // N.Pass pianificati presi dal barcode 
		kst_tab_e1_wo_f5548014.tcicli_osmmcu = " " 
		if kst_tab_barcode_padre.g3npass = kuf1_impianto.kki_npass_2 then
			kst_tab_e1_wo_f5548014.tcicli_osmmcu = kuf1_e1.kki_tcicli_mmcu_2pass  // MODO 2 PASS
		else
			if kst_tab_barcode_padre.g3npass = kuf1_impianto.kki_npass_4 then
				kst_tab_e1_wo_f5548014.tcicli_osmmcu = kuf1_e1.kki_tcicli_mmcu_4pass  // MODO 4 PASS
			end if
		end if

	catch (uo_exception kuo_exception)
		kuo_exception.kist_esito.sqlerrtext = "Errore durante estrazione dati pianificati di Trattamento Gamma 3 per E1 " &
									+ kkg.acapo + trim(kuo_exception.kist_esito.sqlerrtext)
		throw kuo_exception
		
	finally
		if isvalid(kuf1_barcode) then destroy kuf1_barcode
		if isvalid(kuf1_e1) then destroy kuf1_e1

end try

return kst_tab_e1_wo_f5548014
end function

private subroutine u_set_tab_barcode (readonly uo_ds_std_1 kds_pilota_pallet_in_g3, ref st_tab_barcode kst_tab_barcode);//
//--- copia i campi dalla struttura pilota_pallet a barcode
//--- inp: ds_pilota_pallet_in_g3
//--- Out: st_tab_barcode
//

		kst_tab_barcode.data_lav_ini = date(kds_pilota_pallet_in_g3.getitemdatetime(1, "data_entrata"))
		kst_tab_barcode.ora_lav_ini = time(kds_pilota_pallet_in_g3.getitemdatetime(1, "data_entrata"))
		
		if date(kds_pilota_pallet_in_g3.getitemdatetime(1, "data_uscita")) > kkg.data_zero then
			kst_tab_barcode.data_lav_fin = date(kds_pilota_pallet_in_g3.getitemdatetime(1, "data_uscita"))
			kst_tab_barcode.ora_lav_fin = time(kds_pilota_pallet_in_g3.getitemdatetime(1, "data_uscita"))
		end if		
		
		if isnumber(trim(kds_pilota_pallet_in_g3.getitemstring(1, "id_modo"))) then
			kst_tab_barcode.g3lav_npass = integer(trim(kds_pilota_pallet_in_g3.getitemstring(1, "id_modo")))
		else
			kst_tab_barcode.g3lav_npass = 0
		end if
		if isnumber(trim(kds_pilota_pallet_in_g3.getitemstring(1, "ciclo"))) then
			kst_tab_barcode.g3lav_ciclo = integer(trim(kds_pilota_pallet_in_g3.getitemstring(1, "ciclo")))
		else
			kst_tab_barcode.g3lav_ciclo = 0
		end if
		if not isnull(kds_pilota_pallet_in_g3.getitemnumber(1, "giri")) then
			kst_tab_barcode.g3lav_ngiri = kds_pilota_pallet_in_g3.getitemnumber(1, "giri")
		else
			kst_tab_barcode.g3lav_ngiri = 0
		end if

		kst_tab_barcode.Bilancella = kds_pilota_pallet_in_g3.getitemnumber(1, "carrier")  //???



end subroutine

private subroutine importa_trattati_pilota_g3_e1 (ref ds_pilota_pallet_out_g3 ads_pilota_pallet_out_g3, ref st_tab_barcode kst_tab_barcode, ref kuf_e1_wo_f5548014 kuf1_e1_wo_f5548014, ref kuf_barcode kuf1_barcode, ref st_tab_meca ast_tab_meca) throws uo_exception;/*
 Carica i dati nella tabella di appoggio 'e1_wo_f5548014' per scambio con E1
*/
long k_riga_impo=0, k_ctr, k_righe_pallet_tot=0, k_riga_pallet
date k_datainizioanno
int k_giorniafter, k_anno, k_anno_rid
long k_rc
st_tab_e1_wo_f5548014 kst_tab_e1_wo_f5548014, kst_tab_e1_wo_f5548014_appo



	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

	kst_tab_e1_wo_f5548014.wo_osdoco = ast_tab_meca.e1doco
	if kst_tab_e1_wo_f5548014.wo_osdoco > 0 then

//--- verifica se è il primo/ultimo barcode del trattamento e lo salva in e1_wo_f5548014 per poi comunicarlo a E1
		kst_tab_e1_wo_f5548014.data_osa801 = string(ads_pilota_pallet_out_g3.getitemdatetime(k_riga_pallet, "Data_Entrata"), "dd/mm/yy")
		k_anno = integer(string(ads_pilota_pallet_out_g3.getitemdatetime(k_riga_pallet, "Data_Entrata"), "yyyy"))
		k_anno_rid = integer(string(ads_pilota_pallet_out_g3.getitemdatetime(k_riga_pallet, "Data_Entrata"), "yy"))
		k_datainizioanno = date(k_anno,01,01)
		k_giorniafter = DaysAfter(k_datainizioanno, date(ads_pilota_pallet_out_g3.getitemdatetime(k_riga_pallet, "Data_Entrata"))) + 1
		kst_tab_e1_wo_f5548014.data_osdee = 100000 + k_anno_rid * 1000 + k_giorniafter
		kst_tab_e1_wo_f5548014.ora_oswwaet = long(kGuf_data_base.get_e1_timeformat(ads_pilota_pallet_out_g3.getitemdatetime(k_riga_pallet, "Data_Entrata")))
		if kuf1_barcode.get_nr_barcode_lav_ini(kst_tab_barcode) = 0 then
			kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_firstload
			kst_tab_e1_wo_f5548014.tcicli_osmmcu = ""
			kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit = "S"
			kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i tempi come prima entrata x E1
		end if
		if kuf1_barcode.get_nr_barcode_no_lav_ini_x_id_meca(kst_tab_barcode) = 1 then
			kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_lastload
			kst_tab_e1_wo_f5548014_appo = u_get_e1_ws_f5548014_pianif(kst_tab_barcode) //kst_tab_meca)  // get del tipo ciclo pianificato
			kst_tab_e1_wo_f5548014.tcicli_osmmcu = kst_tab_e1_wo_f5548014_appo.tcicli_osmmcu
			kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit = "S"
			kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i tempi come ultimo entrato x E1
		end if

//--- verifica se è il primo/ultimo barcode deil trattamento e lo salva in e1_wo_f5548014 per poi comunicarlo a E1
		kst_tab_e1_wo_f5548014.data_osa801 = string(ads_pilota_pallet_out_g3.getitemdatetime(k_riga_pallet, "data_uscita"), "dd/mm/yy")
		k_anno = integer(string(ads_pilota_pallet_out_g3.getitemdatetime(k_riga_pallet, "data_uscita"), "yyyy"))
		k_anno_rid = integer(string(ads_pilota_pallet_out_g3.getitemdatetime(k_riga_pallet, "data_uscita"), "yy"))
		k_datainizioanno = date(k_anno,01,01)
		k_giorniafter = DaysAfter(k_datainizioanno, date(ads_pilota_pallet_out_g3.getitemdatetime(k_riga_pallet, "data_uscita"))) + 1
		kst_tab_e1_wo_f5548014.data_osdee = 100000 + k_anno_rid * 1000 + k_giorniafter
		kst_tab_e1_wo_f5548014.ora_oswwaet = long(kGuf_data_base.get_e1_timeformat(ads_pilota_pallet_out_g3.getitemdatetime(k_riga_pallet, "data_uscita")))

		if kuf1_barcode.get_nr_barcode_trattati_x_id_meca(kst_tab_barcode) = 0 then
			kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_firstunload
			kst_tab_e1_wo_f5548014.tcicli_osmmcu = ""
			kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit = "S"
			kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i tempi per E1 primo pallet uscito 
		end if
		if kuf1_barcode.get_nr_barcode_da_trattare_x_id_meca(kst_tab_barcode) = 1 then
			kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_lastunload
			kst_tab_e1_wo_f5548014.tcicli_osmmcu = ""
			kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit = "S"
			kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i tempi su E1 ultimo pallet uscito 
		end if
	end if

						

end subroutine

public function integer importa_inizio_lav_pilota_g3 () throws uo_exception;/*
 Importa dati di Inizio LAVORAZIONE IMPIANTO G3 e aggiorna le tabelle
 
 Input: Simulazione Si/No   false=fa aggiornamenti, true=simula e non aggiorna nulla
 Output: Numero di righe aggiornate
 Tabelle PILOTA coinvolte: PALLET
 */
long k_riga_impo=0, k_ctr=0, k_righe_pallet_tot=0, k_riga_pallet, k_rc
date k_data_ultima, k_data_da=date(0), k_Data_Entrata_da, k_datainizioanno
int k_giorniafter, k_anno, k_anno_rid
boolean k_e1_enabled
st_tab_barcode kst_tab_barcode_figlio
kuf_barcode kuf1_barcode
kuf_armo kuf1_armo
kuf_sv_skedula kuf1_sv_skedula
kuf_e1_wo_f5548014 kuf1_e1_wo_f5548014
kuf_artr kuf1_artr
uo_ds_std_1 kds_1
st_esito kst_esito
st_tab_base kst_tab_base
st_tab_barcode kst_tab_barcode, kst_tab_barcode_vuota
st_tab_meca kst_tab_meca
st_tab_e1_wo_f5548014 kst_tab_e1_wo_f5548014, kst_tab_e1_wo_f5548014_appo
st_tab_artr kst_tab_artr
ds_pilota_pallet_in_g3 kds_pilota_pallet_in_g3


try
 
//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa )
		
	kguo_exception.inizializza(this.classname())

	k_e1_enabled = kguo_g.if_e1_enabled( )			// interfaccia E1 attiva?

	kds_pilota_pallet_in_g3 = create ds_pilota_pallet_in_g3  // Connessione al DB PILOTA IMPIANTO G3

	k_Data_Entrata_da = relativedate(kguo_g.get_dataoggi( ), -30)
	k_righe_pallet_tot = kds_pilota_pallet_in_g3.retrieve(k_Data_Entrata_da)
	if k_righe_pallet_tot < 0 then 
		kguo_exception.set_st_esito_err_ds(kds_pilota_pallet_in_g3, "Errore in ricerca Importazioni di Inizio Lavorazione dal " + string(k_Data_Entrata_da, "dd mmm yy") + " dall'impianto GAMMA 3")
		throw kguo_exception
	end if

	if k_righe_pallet_tot = 0 then 
		kguo_exception.kist_esito.esito = kkg_esito.not_fnd
		kguo_exception.kist_esito.SQLErrText = "Nessun Lotto da Importare di Inizio Lavorazione dal " + string(k_Data_Entrata_da, "dd mmm yy") + " dall'impianto GAMMA 3" //:~n~r" + trim(kguo_sqlca_db_pilota.SQLErrText)
		throw kguo_exception
	end if

	kuf1_barcode = create kuf_barcode
	kuf1_armo = create kuf_armo
	kuf1_e1_wo_f5548014 = create kuf_e1_wo_f5548014
	kuf1_artr = create kuf_artr
	
	SetPointer(kkg.pointer_attesa )
	
	for k_riga_pallet = 1 to k_righe_pallet_tot
		
//--- popola struttura da datastore elenco PALLET con data FINE LAVORAZIONE
//		kst_tab_pilota_pallet.Data_Entrata = kds_pilota_pallet_in_g3.getitemdatetime(k_riga_pallet, "Data_Entrata")   
//		kst_tab_pilota_pallet.Data_Uscita = kds_pilota_pallet_in_g3.getitemdatetime(k_riga_pallet, "Data_Uscita")
//		kst_tab_pilota_pallet.Pallet_Code = kds_pilota_pallet_in_g3.getitemstring(k_riga_pallet, "barcode") 
//		kst_tab_pilota_pallet. = kds_pilota_pallet_in_g3.getitemstring(k_riga_pallet, "F1AVP")
//		kst_tab_pilota_pallet.F2AVP = kds_pilota_pallet_in_g3.getitemstring(k_riga_pallet, "F2AVP")
//		kst_tab_pilota_pallet.F1APP = kds_pilota_pallet_in_g3.getitemstring(k_riga_pallet, "F1APP")
//		kst_tab_pilota_pallet.F2APP = kds_pilota_pallet_in_g3.getitemstring(k_riga_pallet, "F2APP")
//		kst_tab_pilota_pallet.Posizione = kds_pilota_pallet_in_g3.getitemstring(k_riga_pallet, "Posizione")
//		kst_tab_pilota_pallet.Bilancella = kds_pilota_pallet_in_g3.getitemnumber(k_riga_pallet, "Bilancella")
	
//--- piccolo lasso di tempo a favore di altre cose usato x  tasto 'interrompi'
		yield ()

		kst_tab_barcode = kst_tab_barcode_vuota

		kst_tab_barcode.barcode = trim(kds_pilota_pallet_in_g3.getitemstring(k_riga_pallet, "barcode"))

//--- legge Barcode x prendere id armo e vede se gia' lavorato
		
		
//--- se Barcode TROVATO
		if kuf1_barcode.select_barcode(kst_tab_barcode) then

//--- se già messo in lavorazione evito di ri-aggiornare
			if kst_tab_barcode.data_lav_ini > kkg.data_zero then
				
				//--- già messo in lavorazione
				
			else
				
				try
	//--- verifica se è il primo/ultimo barcode che finisce il trattamento e lo salva in e1_wo_f5548014 per poi comunicarlo a E1
					kst_tab_e1_wo_f5548014.wo_osdoco = 0 
					if k_e1_enabled then
						kst_tab_meca.id = kst_tab_barcode.id_meca
						kst_tab_e1_wo_f5548014.wo_osdoco = kuf1_armo.get_e1doco(kst_tab_meca)
						if kst_tab_e1_wo_f5548014.wo_osdoco > 0 then
							kst_tab_e1_wo_f5548014.data_osa801 = string(kds_pilota_pallet_in_g3.getitemdatetime(k_riga_pallet, "Data_Entrata"), "dd/mm/yy")
							k_anno = integer(string(kds_pilota_pallet_in_g3.getitemdatetime(k_riga_pallet, "Data_Entrata"), "yyyy"))
							k_anno_rid = integer(string(kds_pilota_pallet_in_g3.getitemdatetime(k_riga_pallet, "Data_Entrata"), "yy"))
							k_datainizioanno = date(k_anno,01,01)
							k_giorniafter = DaysAfter(k_datainizioanno, date(kds_pilota_pallet_in_g3.getitemdatetime(k_riga_pallet, "Data_Entrata"))) + 1
							kst_tab_e1_wo_f5548014.data_osdee = 100000 + k_anno_rid * 1000 + k_giorniafter
							kst_tab_e1_wo_f5548014.ora_oswwaet = long(kGuf_data_base.get_e1_timeformat(kds_pilota_pallet_in_g3.getitemdatetime(k_riga_pallet, "Data_Entrata")))
							if kuf1_barcode.get_nr_barcode_lav_ini(kst_tab_barcode) = 0 then
								kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_firstload
								kst_tab_e1_wo_f5548014.tcicli_osmmcu = ""
								kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit = "S"    //"N" x temporaltable
								kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i tempi come prima entrata x E1
							end if
							if kuf1_barcode.get_nr_barcode_no_lav_ini_x_id_meca(kst_tab_barcode) = 1 then
								kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_lastload
								kst_tab_e1_wo_f5548014_appo = u_get_e1_ws_f5548014_pianif(kst_tab_barcode)  // get del tipo ciclo pianificato
								kst_tab_e1_wo_f5548014.tcicli_osmmcu = kst_tab_e1_wo_f5548014_appo.tcicli_osmmcu
								kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit = "S"    //"N" x temporaltable
								kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i tempi come ultimo entrato x E1
							end if
						end if
					end if

				//--- popola area TAB_BARCODE padre	
					u_set_tab_barcode(kds_pilota_pallet_in_g3, kst_tab_barcode)
						
				//--- Aggiorna gli archivi con i dati di Lavorazione ------------------------------------------------------
					kst_tab_barcode.st_tab_g_0.esegui_commit = "S"    //"N" x temporaltable
					kuf1_barcode.u_update_campo(kst_tab_barcode, "data_lav_ini")
		
		//--- inserisce collo in ARTR
					setnull(kst_tab_artr.data_fin) 
					kst_tab_artr.pl_barcode = kst_tab_barcode.pl_barcode
					kst_tab_artr.id_armo = kst_tab_barcode.id_armo
					kst_tab_artr.st_tab_g_0.esegui_commit =  "S"    //"N" x temporaltable 
					kuf1_artr.apri_lavorazione(kst_tab_artr)

					kguo_sqlca_db_magazzino.db_commit( )  //06072016
		
		//--- Tratta eventuali Figli
					kds_1 = kuf1_barcode.get_figli_barcode(kst_tab_barcode)
		
					for k_ctr = 1 to kds_1.rowcount( ) 
						
						kst_tab_barcode_figlio.barcode = kds_1.object.barcode[k_ctr]
//--- legge Barcode figlio
						kuf1_barcode.select_barcode(kst_tab_barcode_figlio)
						
//--- imposta i dati di trattamento uguali a quelli del PADRE		
						u_set_tab_barcode(kds_pilota_pallet_in_g3, kst_tab_barcode_figlio)

//--- verifica se è il primo/ultimo barcode figlio che finisce il trattamento e lo salva in e1_wo_f5548014 per poi comunicarlo a E1
						kst_tab_e1_wo_f5548014.wo_osdoco = 0
						if k_e1_enabled then
							kst_tab_meca.id = kst_tab_barcode_figlio.id_meca
							kst_tab_e1_wo_f5548014.wo_osdoco = kuf1_armo.get_e1doco(kst_tab_meca)
							if kst_tab_e1_wo_f5548014.wo_osdoco > 0 then
								kst_tab_e1_wo_f5548014.data_osa801 = string(kds_pilota_pallet_in_g3.getitemdatetime(k_riga_pallet, "Data_Entrata"), "dd/mm/yy")
								k_anno = integer(string(kds_pilota_pallet_in_g3.getitemdatetime(k_riga_pallet, "Data_Entrata"), "yyyy"))
								k_anno_rid = integer(string(kds_pilota_pallet_in_g3.getitemdatetime(k_riga_pallet, "Data_Entrata"), "yy"))
								k_datainizioanno = date(k_anno,01,01)
								k_giorniafter = DaysAfter(k_datainizioanno, date(kds_pilota_pallet_in_g3.getitemdatetime(k_riga_pallet, "Data_Entrata"))) + 1
								kst_tab_e1_wo_f5548014.data_osdee = 100000 + k_anno_rid * 1000 + k_giorniafter
								kst_tab_e1_wo_f5548014.ora_oswwaet = long(kGuf_data_base.get_e1_timeformat(kds_pilota_pallet_in_g3.getitemdatetime(k_riga_pallet, "Data_Entrata")))
								if kuf1_barcode.get_nr_barcode_lav_ini(kst_tab_barcode_figlio) = 0 then
									kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_firstload
									kst_tab_e1_wo_f5548014.tcicli_osmmcu = ""
									kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit = "S"    //"N" x temporaltable
									kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i tempi come prima entrata x E1
								end if
								if kuf1_barcode.get_nr_barcode_no_lav_ini_x_id_meca(kst_tab_barcode_figlio) = 1 then
									kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_lastload
									kst_tab_e1_wo_f5548014_appo = u_get_e1_ws_f5548014_pianif(kst_tab_barcode)  // get del tipo ciclo pianificato
									kst_tab_e1_wo_f5548014.tcicli_osmmcu = kst_tab_e1_wo_f5548014_appo.tcicli_osmmcu
									kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit = "S"    //"N" x temporaltable
									kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i tempi come ultimo entrato x E1
								end if
							end if
						end if
						
//--- apre il Trattamento del Figlio
						kst_tab_barcode.st_tab_g_0.esegui_commit = "S"    //"N" x temporaltable
						kuf1_barcode.u_update_campo(kst_tab_barcode_figlio, "data_lav_ini")

//--- inserisce collo in ARTR
						setnull(kst_tab_artr.data_fin) 
						kst_tab_artr.pl_barcode = kst_tab_barcode_figlio.pl_barcode
						kst_tab_artr.id_armo = kst_tab_barcode_figlio.id_armo
						kst_tab_artr.st_tab_g_0.esegui_commit = "S"    //"N" x temporaltable 
						kuf1_artr.apri_lavorazione(kst_tab_artr)

						kguo_sqlca_db_magazzino.db_commit( )  //06072016
					end for
				
//--- conta i barcode importati in trattatamento
					k_riga_impo	++
						
				catch (uo_exception kuo5_exception)
					//--- qls va male nella registrazione su E1

				finally
//--- COMMIT consolido su DB Tradizionale e E1
					kguo_sqlca_db_magazzino.db_commit( )
											
				end try
			
			end if					
		end if
//-------------------------------------------------------------------------------------------------------------
		
	end for
	
		
//end if


catch (uo_exception kuo4_exception) 
	kst_esito = kuo4_exception.get_st_esito()
	if kst_esito.esito = kkg_esito.db_ko then
		throw kuo4_exception
	end if

finally

	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kds_pilota_pallet_in_g3) then destroy kds_pilota_pallet_in_g3
	if isvalid(kuf1_e1_wo_f5548014) then destroy kuf1_e1_wo_f5548014
	if isvalid(kds_1) then destroy kds_1
	if isvalid(kuf1_artr) then destroy kuf1_artr

	SetPointer(kkg.pointer_default)

end try


return k_riga_impo

end function

private function integer importa_trattati_pilota_g3_1 (ds_pilota_pallet_out_g3 ads_pilota_pallet_out_g3, kuf_barcode auf1_barcode) throws uo_exception;/*
 Importa dati LAVORAZIONE dal Pilota e aggiorna le tabelle
    Inp: ds_pilota_pallet_out_g3   dati barcode da trattare
	      kuf_barcode 
	 chiamato dal importa_trattati_pilota_g3
*/
long k_riga_impo=0, k_ctr, k_righe_pallet_tot=0, k_riga_pallet
boolean k_e1_enabled=false
date k_datainizioanno
int k_giorniafter, k_anno, k_anno_rid
long k_rc
kuf_pl_barcode kuf1_pl_barcode
kuf_artr kuf1_artr
kuf_armo kuf1_armo 
kuf_e1_wo_f5548014 kuf1_e1_wo_f5548014
uo_ds_std_1 kds_1
st_esito kst_esito
st_tab_base kst_tab_base
st_tab_artr kst_tab_artr, kst_tab_artr_vuota
st_tab_barcode kst_tab_barcode, kst_tab_barcode_vuota, kst_tab_barcode_figlio
st_tab_meca kst_tab_meca
st_tab_e1_wo_f5548014 kst_tab_e1_wo_f5548014, kst_tab_e1_wo_f5548014_appo



try
	SetPointer(kkg.pointer_attesa)
	
	kguo_exception.inizializza(this.classname())

	k_e1_enabled = kguo_g.if_e1_enabled( )			// interfaccia E1 attiva?

	kuf1_artr = create kuf_artr
	kuf1_pl_barcode = create kuf_pl_barcode
	kuf1_armo = create kuf_armo
	kuf1_e1_wo_f5548014 = create kuf_e1_wo_f5548014
	
	k_righe_pallet_tot = ads_pilota_pallet_out_g3.rowcount( )
	for k_riga_pallet = 1 to k_righe_pallet_tot
			
//	//--- popola struttura da datastore elenco PALLET con data FINE LAVORAZIONE
//			ads_pilota_pallet_out_g3.getitemdatetime(k_riga_pallet, "Data_Entrata") = ads_pilota_pallet_out_g3.getitemdatetime(k_riga_pallet, "Data_Entrata")   
//			ads_pilota_pallet_out_g3.getitemdatetime(k_riga_pallet, "data_uscita") = ads_pilota_pallet_out_g3.getitemdatetime(k_riga_pallet, "Data_Uscita")
//			kst_tab_pilota_pallet.Pallet_Code = ads_pilota_pallet_out_g3.getitemstring(k_riga_pallet, "Pallet_Code") 
//			kst_tab_pilota_pallet.F1AVP = ads_pilota_pallet_out_g3.getitemstring(k_riga_pallet, "F1AVP")
//			kst_tab_pilota_pallet.F2AVP = ads_pilota_pallet_out_g3.getitemstring(k_riga_pallet, "F2AVP")
//			kst_tab_pilota_pallet.F1APP = ads_pilota_pallet_out_g3.getitemstring(k_riga_pallet, "F1APP")
//			kst_tab_pilota_pallet.F2APP = ads_pilota_pallet_out_g3.getitemstring(k_riga_pallet, "F2APP")
//			kst_tab_pilota_pallet.Posizione = ads_pilota_pallet_out_g3.getitemstring(k_riga_pallet, "Posizione")
//			kst_tab_pilota_pallet.Bilancella = ads_pilota_pallet_out_g3.getitemnumber(k_riga_pallet, "Bilancella")
//	
//--- piccolo lasso di tempo a favore di altre cose usato x  tasto 'interrompi'
			yield ()
	
			kst_tab_barcode = kst_tab_barcode_vuota
	
//--- Estrazione del BARCODE 
			kst_tab_barcode.barcode = ads_pilota_pallet_out_g3.getitemstring(k_riga_pallet, "barcode") 
	
//--- legge Barcode x prendere id armo e vede se gia' lavorato
			auf1_barcode.select_barcode(kst_tab_barcode)
				
//--- se ancora da chiudere in lavorazione...			
			if kst_tab_barcode.data_lav_fin > kkg.data_zero then
				//--- già chiuso!!
			else

//--- Carica i dati nella tabella di appoggio 'e1_wo_f5548014' per scambio con E1
				kst_tab_e1_wo_f5548014.wo_osdoco = 0 
				if k_e1_enabled then
					kst_tab_meca.id = kst_tab_barcode.id_meca
					kuf1_armo.get_e1doco(kst_tab_meca)
					
					//--- carica dati in E1
					importa_trattati_pilota_g3_e1(ads_pilota_pallet_out_g3, kst_tab_barcode, kuf1_e1_wo_f5548014, auf1_barcode, kst_tab_meca)
					
				end if

		//--- popola campi per chiudere il barcode					
				u_set_tab_barcode(ads_pilota_pallet_out_g3, kst_tab_barcode)
					
		//--- verifica la lavorazione se ci sono anomalie
				auf1_barcode.check_anomalie_lavorazione_g3(kst_tab_barcode)
			
		//--- Aggiorna gli archivi con i dati di Lavorazione ------------------------------------------------------
				kst_tab_barcode.st_tab_g_0.esegui_commit = "S" 
				auf1_barcode.u_update_campo(kst_tab_barcode, "data_lav_ini_fin") //AGGIORNA TAB
			
		//--- se Anomalia....
				if kst_tab_barcode.err_lav_fin = auf1_barcode.ki_err_lav_fin_ko then
					kst_tab_meca.id = kst_tab_barcode.id_meca 
					kst_tab_meca.err_lav_fin = kst_tab_barcode.err_lav_fin 
								
					kst_tab_meca.st_tab_g_0.esegui_commit = "S" 
					kuf1_armo.setta_errore_lav(kst_tab_meca)  // AGGIORNA ERRORE SU MECA
				end if
			
		//--- Chiude lavorazione del Barcode su ARTR 
				kst_esito.esito = kkg_esito.ok 
				kst_tab_artr = kst_tab_artr_vuota
				kst_tab_artr.id_armo = kst_tab_barcode.id_armo 
				kst_tab_artr.pl_barcode = kst_tab_barcode.pl_barcode
			
		//--- se elaborazione NO di simulazione...
				kst_tab_artr.st_tab_g_0.esegui_commit = "S" 
				kuf1_artr.chiudi_lavorazione(kst_tab_artr)
			
				kst_tab_artr.num_certif = 0
						
	//--- Crea ATTESTATO su ARTR - ritorna il num certificato  
				kst_tab_artr.st_tab_g_0.esegui_commit = "S" 
				kuf1_artr.crea_attestato_dettaglio(kst_tab_artr)

	//--- Imposta i Tempi Impianto di trattamento sul BARCODE
				kst_tab_barcode.st_tab_g_0.esegui_commit = "S" 
				k_rc = auf1_barcode.set_imptime_second(kst_tab_barcode)
							
				kguo_sqlca_db_magazzino.db_commit( )  //06072016

	//--- conta i barcode importati trattati
				k_riga_impo	++

	//--- Piglia gli eventuali Figli
				kds_1 = auf1_barcode.get_figli_barcode(kst_tab_barcode)

				for k_ctr = 1 to kds_1.rowcount( ) 
								
					kst_tab_barcode_figlio.barcode = kds_1.object.barcode[k_ctr]
//--- legge Barcode figlio
					auf1_barcode.select_barcode(kst_tab_barcode_figlio)

//--- imposta i dati di trattamento uguali a quelli del PADRE
					u_set_tab_barcode(ads_pilota_pallet_out_g3, kst_tab_barcode_figlio)

//--- verifica la lavorazione se ci sono anomalie
					auf1_barcode.check_anomalie_lavorazione_g3(kst_tab_barcode_figlio)
						
//--- Carica i dati nella tabella di scambio per E1
					kst_tab_e1_wo_f5548014.wo_osdoco = 0 
					if k_e1_enabled then
						kst_tab_meca.id = kst_tab_barcode_figlio.id_meca
						kst_tab_e1_wo_f5548014.wo_osdoco = kuf1_armo.get_e1doco(kst_tab_meca)
						
						//--- carica dati Figlio in E1 
						importa_trattati_pilota_g3_e1(ads_pilota_pallet_out_g3, kst_tab_barcode_figlio, kuf1_e1_wo_f5548014, auf1_barcode, kst_tab_meca)

					end if

//--- chiude il Trattamento del Figlio
					kuf1_pl_barcode.chiudi_lav_barcode_figlio_g2g3(kst_tab_barcode_figlio)

//--- Imposta i Tempi Impianto di trattamento sul BARCODE figlio
					kst_tab_barcode_figlio.st_tab_g_0.esegui_commit = "S" 
					k_rc = auf1_barcode.set_imptime_second(kst_tab_barcode_figlio)
	
					kguo_sqlca_db_magazzino.db_commit( )  

				end for
							
	//--- provo a chiudere lavorazione sul Lotto MECA
				kst_tab_meca.id = kst_tab_barcode.id_meca
				kst_tab_meca.data_lav_fin = kst_tab_barcode.data_lav_fin
				kst_tab_meca.st_tab_g_0.esegui_commit = "S"
				kuf1_armo.chiudi_lavorazione(kst_tab_meca)
			
			end if
	//-------------------------------------------------------------------------------------------------------------
			
		end for
		
//--- consolido su DB -------------------------------------------------------------------------
		kguo_sqlca_db_magazzino.db_commit( )
//------------------------------------------------------------------------------------------------	
	

//--- Se ERRORE ---------------------------------------------------------------------------
	catch (uo_exception k2uo_exception)
		if k2uo_exception.kist_esito.esito <> kkg_esito.ok then
			kguo_sqlca_db_magazzino.db_rollback( )
			throw k2uo_exception
		end if
		
//--- FINE -----------------------------------------------------------------------------------
	finally 	
		if isvalid(kuf1_artr) then destroy kuf1_artr
		if isvalid(kuf1_pl_barcode) then destroy kuf1_pl_barcode
		if isvalid(kuf1_armo) then destroy kuf1_armo
		if isvalid(kuf1_e1_wo_f5548014) then destroy kuf1_e1_wo_f5548014
		if isvalid(kds_1) then destroy kds_1

		SetPointer(kkg.pointer_default)

end try	
	


return k_riga_impo

end function

public function integer importa_trattati_pilota_g3 () throws uo_exception;/*
 Importa dati LAVORAZIONE dal Pilota e aggiorna le tabelle
    rit: numero di pallet importati
*/
long k_riga_impo=0, k_ctr, k_righe_pallet_tot
date k_data_ultima, k_data_da=date(0)
boolean k_e1_enabled=false
long k_rc
kuf_barcode kuf1_barcode
kuf_base kuf1_base
st_esito kst_esito
st_tab_base kst_tab_base
st_tab_barcode kst_tab_barcode
ds_pilota_pallet_out_g3 kds_pilota_pallet_out_g3



try
	SetPointer(kkg.pointer_attesa)
	
	kguo_exception.inizializza(this.classname())
	
	k_e1_enabled = kguo_g.if_e1_enabled( )			// interfaccia E1 attiva?

	//--- Estrazione data da cui fare l'estrazione 
	kuf1_barcode = create kuf_barcode
	kst_tab_barcode = kuf1_barcode.get_primo_barcode_in_lav()
	k_data_da = kst_tab_barcode.data_lav_ini

	kds_pilota_pallet_out_g3 = create ds_pilota_pallet_out_g3
	k_righe_pallet_tot = kds_pilota_pallet_out_g3.retrieve(k_data_da) // LETTURA PALLET CON DATA FINE LAV IMPOSTATA
	if k_righe_pallet_tot < 0 then
		kguo_exception.set_esito(kds_pilota_pallet_out_g3.kist_esito)
		kguo_exception.kist_esito.sqlerrtext = "Errore durante Importazione dati Trattatamento dal Sistema PILOTA, dal " + string(k_data_da) + ". " + kkg.acapo + kds_pilota_pallet_out_g3.kist_esito.sqlerrtext
		throw kguo_exception
	end if

	if k_righe_pallet_tot > 0 then
		
//--- Importa TRATTATI
		k_riga_impo = importa_trattati_pilota_g3_1(kds_pilota_pallet_out_g3, kuf1_barcode)
		
//--- aggiorna BASE	
		kuf1_barcode = create kuf_barcode
		kst_tab_barcode = kuf1_barcode.get_ultimo_barcode_importato( )
		k_data_ultima = kst_tab_barcode.data_lav_fin
		destroy kuf1_barcode

		kuf1_base = create kuf_base

		kst_tab_base.st_tab_g_0.esegui_commit = "S"
		kst_tab_base.key = "data_ultima_estrazione_pilota_out" 
		kst_tab_base.key1 = string(kst_tab_barcode.data_lav_fin)
		kst_esito  = kuf1_base.metti_dato_base(kst_tab_base)
		if kst_esito.esito  = kkg_esito.db_ko then
			kst_esito.sqlerrtext =  "Archivio Azienda: Aggiornamento Data Fine estrazione dal flusso 'Esiti Pilota' fallito:~n~r" + string(kst_esito.sqlcode) + " - " + trim(kst_esito.sqlerrtext) + "~n~r" 
			kguo_exception.inizializza()
			kguo_exception.set_esito (kst_esito)
		end if
		kst_tab_base.st_tab_g_0.esegui_commit = "S"
		kst_tab_base.key = "ora_ultima_estrazione_pilota_out"
		kst_tab_base.key1 = string(kst_tab_barcode.ora_lav_fin)
		kst_esito  = kuf1_base.metti_dato_base(kst_tab_base)
		if kst_esito.esito  = kkg_esito.db_ko then
			kst_esito.sqlerrtext = "Archivio Azienda: Aggiornamento Ora Fine estrazione dal flusso 'Esiti Pilota' fallito:~n~r" + string(kst_esito.sqlcode) + " - " + trim(kst_esito.sqlerrtext) + "~n~r" 
			kguo_exception.inizializza()
			kguo_exception.set_esito (kst_esito)
		end if

	else
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = k_righe_pallet_tot
		kst_esito.SQLErrText = "Nessun barcode Trattato da importare dal Sistema PILOTA" //:~n~r" + trim(kguo_sqlca_db_pilota.SQLErrText)
	end if	

//--- Se ERRORE ---------------------------------------------------------------------------
	catch (uo_exception kuo_exception)
		if kuo_exception.kist_esito.esito <> kkg_esito.ok then
			throw kuo_exception
		end if
		
	
//--- FINE -----------------------------------------------------------------------------------
	finally 	
		
//--- distruzione oggetti		
		if isvalid(kuf1_barcode) then destroy kuf1_barcode
		if isvalid(kds_pilota_pallet_out_g3) then destroy kds_pilota_pallet_out_g3
		if isvalid(kuf1_base) then destroy kuf1_base

		SetPointer(kkg.pointer_default)

end try	
	


return k_riga_impo

end function

on kuf_pl_barcode_g3.create
call super::create
end on

on kuf_pl_barcode_g3.destroy
call super::destroy
end on

event constructor;call super::constructor;//
kiuf_pl_barcode = create kuf_pl_barcode
end event

event destructor;call super::destructor;//
if isvalid(kiuf_pl_barcode) then destroy kiuf_pl_barcode
end event

