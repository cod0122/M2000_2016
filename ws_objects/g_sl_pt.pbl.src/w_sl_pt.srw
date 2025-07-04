﻿$PBExportHeader$w_sl_pt.srw
forward
global type w_sl_pt from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_sl_pt from w_g_tab_3
integer width = 5038
integer height = 8180
string title = "Piano di Trattamento SL-PT"
boolean ki_toolbar_window_presente = true
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_fai_inizializza_dopo_update = true
end type
global w_sl_pt w_sl_pt

type variables
//
private boolean ki_cambio_giri_autorizzato=false
private boolean ki_b_reset_proposta=false
private st_tab_sl_pt kist_tab_sl_pt_orig
private kuf_sl_pt kiuf_sl_pt
private kuf_sl_pt_g3 kiuf_sl_pt_g3

end variables

forward prototypes
private function integer inserisci ()
private subroutine riempi_id ()
protected function integer cancella ()
private subroutine leggi_altre_tab ()
private function integer check_rek (string k_codice)
protected subroutine inizializza_1 ()
protected function string aggiorna ()
protected function string inizializza ()
protected function string check_dati ()
protected subroutine open_start_window ()
public subroutine trattamento_proposta_reset ()
public subroutine trattamento_proposta_sposta ()
private subroutine u_open_esempio_st_dosim ()
public function boolean u_get_dati_cliente (ref st_tab_clienti kst_tab_clienti)
private subroutine u_put_video_cliente (st_tab_clienti kst_tab_clienti)
private function boolean if_anag_attiva (st_tab_clienti ast_tab_clienti)
public subroutine u_set_dw_clienti_child ()
protected subroutine attiva_tasti_0 ()
protected subroutine pulizia_righe ()
protected subroutine u_pulizia_righe_dosimpos ()
private subroutine u_get_path_packingformin_file ()
private subroutine u_open_packingformin_file ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
private subroutine call_logtrace ()
protected subroutine inizializza_6 () throws uo_exception
protected subroutine inizializza_4 () throws uo_exception
protected subroutine inizializza_3 () throws uo_exception
protected subroutine u_pulizia_righe_g3 ()
public subroutine u_copy_g2_to_g3 ()
public subroutine u_copy_g3_to_g2 ()
protected subroutine inizializza_7 () throws uo_exception
end prototypes

private function integer inserisci ();//
int k_return=1, k_ctr
long k_row


	attiva_tasti()

//=== Aggiunge una riga al data windows
	choose case tab_1.selectedtab 
		case  1 
			tab_1.tabpage_1.dw_1.insertrow(0)
			tab_1.tabpage_1.dw_1.setcolumn(1)
			
		case 2 // posizioni dosimetri
			k_row = tab_1.tabpage_2.dw_2.insertrow(0)
			tab_1.tabpage_2.dw_2.setitem(k_row, "seq", k_row*10)
			tab_1.tabpage_2.dw_2.setcolumn("dosimpos_codice")
			
		case 4 // Impianto G3
			k_row = tab_1.tabpage_4.dw_4.insertrow(0)
			tab_1.tabpage_4.dw_4.setitem(k_row, "cod_sl_pt", tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt"))
			tab_1.tabpage_4.dw_4.setcolumn("g3npass")
			
	end choose	

	k_return = 0


return (k_return)



end function

private subroutine riempi_id ();//
//=== Imposta gli Effettivi ID degli archivi
string k_codice_1, k_codice
long k_riga, k_riga_max
int k_impianto, k_seq_base
st_tab_sl_pt kst_tab_sl_pt


//=== Salvo ID del rec originale x piu' avanti
	k_codice_1 = tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt")

//=== Se non sono in caricamento allora prelevo l'ID dalla dw
	if tab_1.tabpage_1.dw_1.getitemstatus(1, 0, primary!) <> newmodified! then
		k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt")
	end if
	
	if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 then
		kst_tab_sl_pt.proposta_tipo_cicli = tab_1.tabpage_1.dw_1.getitemstring(1, "proposta_tipo_cicli")
		if trim(kst_tab_sl_pt.proposta_tipo_cicli) > " " then
			if kist_tab_sl_pt_orig.proposta_tipo_cicli <> tab_1.tabpage_1.dw_1.getitemstring(1, "proposta_tipo_cicli") &
						or kist_tab_sl_pt_orig.proposta_fila_1 <> tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_1") &
						or kist_tab_sl_pt_orig.proposta_fila_1p <> tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_1p") &
						or kist_tab_sl_pt_orig.proposta_fila_2 <> tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_2") &
						or kist_tab_sl_pt_orig.proposta_fila_2p <> tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_2p") then
				
				tab_1.tabpage_1.dw_1.setitem( 1, "proposta_utente", kGuf_data_base.prendi_x_utente( ) )
				tab_1.tabpage_1.dw_1.setitem( 1, "proposta_data", kGuf_data_base.prendi_x_datins( ) )
				
			end if
	//--- se tipo ciclo non è a scelta pulizia della preferenza
			if kist_tab_sl_pt_orig.proposta_tipo_cicli <> kiuf_sl_pt.ki_tipo_cicli_a_scelta then
				tab_1.tabpage_1.dw_1.setitem( 1, "proposta_fila_pref"," ")
			end if
		else
			tab_1.tabpage_1.dw_1.setitem( 1, "proposta_utente", "" )
			tab_1.tabpage_1.dw_1.setitem( 1, "proposta_data", datetime(date(0)) )
		end if
	end if

//--- dati Posizioni Dosimetri	
	k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt")
	if trim(k_codice) > " " then
		k_riga = tab_1.tabpage_2.dw_2.getnextmodified(0, primary!)
		do while k_riga > 0  
			if tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_sl_pt_dosimpos") > 0 then
			else
				tab_1.tabpage_2.dw_2.setitem(k_riga, "id_sl_pt_dosimpos", 0)
			end if
			if tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "posxcm") > 0 then
			else
				tab_1.tabpage_2.dw_2.setitem(k_riga, "posxcm", 0)
			end if
			if tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "posycm") > 0 then
			else
				tab_1.tabpage_2.dw_2.setitem(k_riga, "posycm", 0)
			end if
			if tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "poszcm") > 0 then
			else
				tab_1.tabpage_2.dw_2.setitem(k_riga, "poszcm", 0)
			end if
			if tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_dosimpos") > 0 then
			else
				tab_1.tabpage_2.dw_2.setitem(k_riga, "id_dosimpos", 0)
			end if
			if trim(tab_1.tabpage_2.dw_2.getitemstring(k_riga, "dosim_tipo")) > " " then
			else
				tab_1.tabpage_2.dw_2.setitem(k_riga, "dosim_tipo", "")
			end if
			if trim(tab_1.tabpage_2.dw_2.getitemstring(k_riga, "dosim_flg_tipo_dose")) > " " then
			else
				tab_1.tabpage_2.dw_2.setitem(k_riga, "dosim_flg_tipo_dose", "")
			end if
			if trim(tab_1.tabpage_2.dw_2.getitemstring(k_riga, "descr1")) > " " then
			else
				tab_1.tabpage_2.dw_2.setitem(k_riga, "descr1", "")
			end if
			tab_1.tabpage_2.dw_2.setitem(k_riga, "cod_sl_pt", k_codice)
			tab_1.tabpage_2.dw_2.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
			tab_1.tabpage_2.dw_2.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
			k_riga = tab_1.tabpage_2.dw_2.getnextmodified(k_riga, primary!)
		loop
		//--- risistema il progressivo sequenza
		tab_1.tabpage_2.dw_2.setsort("cod_sl_pt asc, impianto asc, seq asc")
		tab_1.tabpage_2.dw_2.sort()
		k_seq_base = 0
		k_riga_max = tab_1.tabpage_2.dw_2.rowcount( )
		for k_riga = 1 to k_riga_max
			if tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "impianto") <> k_impianto then
				k_impianto = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "impianto")
				k_seq_base = 0 
			end if
			k_seq_base ++
			if (k_seq_base * 10) <> tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "seq") then
				tab_1.tabpage_2.dw_2.setitem(k_riga, "seq", k_seq_base * 10)
			end if
		next
	end if
	
//--- dati Trattamenti Impianto G3	
	k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt")
	if trim(k_codice) > " " then
		k_riga = tab_1.tabpage_4.dw_4.getnextmodified(0, primary!)
		do while k_riga > 0  
			tab_1.tabpage_4.dw_4.setitem(k_riga, "cod_sl_pt", k_codice)

			if tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_sl_pt_g3_lav") > 0 then
			else
				tab_1.tabpage_4.dw_4.setitem(k_riga, "id_sl_pt_g3_lav", 0)
			end if
			if tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "g3npass") > 0 then
			else
				tab_1.tabpage_4.dw_4.setitem(k_riga, "g3npass", 0)
			end if
			if tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "ciclo_target") > 0 then
			else
				tab_1.tabpage_4.dw_4.setitem(k_riga, "ciclo_target", 0)
			end if
			if tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "ngiri") > 0 then
			else
				tab_1.tabpage_4.dw_4.setitem(k_riga, "ngiri", 0)
			end if
			if tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "ciclo_min") > 0 then
			else
				tab_1.tabpage_4.dw_4.setitem(k_riga, "ciclo_min", 0)
			end if
			if tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "ciclo_max") > 0 then
			else
				tab_1.tabpage_4.dw_4.setitem(k_riga, "ciclo_max", 0)
			end if
			if trim(tab_1.tabpage_4.dw_4.getitemstring(k_riga, "descr")) > " " then
			else
				tab_1.tabpage_4.dw_4.setitem(k_riga, "descr", "")
			end if
			
			tab_1.tabpage_4.dw_4.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
			tab_1.tabpage_4.dw_4.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
			
			k_riga = tab_1.tabpage_4.dw_4.getnextmodified(k_riga, primary!)
		loop
	end if

	
	
end subroutine

protected function integer cancella ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_desc, k_record, k_record_1, k_key = " "
long  k_nro=0, k_id_fase
string k_errore = "0 ", k_errore1 = "0 ", k_nro_fatt
long k_riga, k_seq
date k_data


choose case tab_1.selectedtab 
	case 1 
		k_record = " Piano di Trattamento (PT) "
		k_riga = tab_1.tabpage_1.dw_1.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "cod_sl_pt")
				k_desc = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "descr")
				if isnull(k_desc) = true or trim(k_desc) = "" then
					k_desc = "senza descrizione" 
				end if
				k_record_1 = &
					"Sei sicuro di voler eliminare il Piano di Trattamento '" + &
					trim(k_key) +  "' " &
					+ kkg.acapo + trim(k_desc) + " ?"
			else
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
			end if
		end if

end choose	

		
//=== Se righe in lista
if k_riga > 0 and trim(k_key) > " " then
		
	//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Cancellare " + k_record, k_record_1, question!, yesno!, 1) = 1 then
	 
	 	try
	//=== Cancella la riga dal data windows di lista
			choose case tab_1.selectedtab 
				case 1 
					kiuf_sl_pt.tb_delete(k_key) 
	//			case 2
	//				k_errore = kuf1_sl_pt.tb_delete_ind_comm(k_key) 
			end choose	
			
			kGuf_data_base.db_commit()
			
			choose case tab_1.selectedtab 
				case 1 
					tab_1.tabpage_1.dw_1.deleterow(k_riga)
//					case 2
//						tab_1.tabpage_2.dw_2.deleterow(k_riga)
			end choose	
					
		catch (uo_exception kuo_exception)
			
			k_errore = "1" + kuo_exception.kist_esito.sqlerrtext + " (" + string(kuo_exception.kist_esito.sqlcode) + ") " 
			k_return = 1
			messagebox("Cancellazione in errore", MidA(k_errore, 2))
	
		end try
	
		attiva_tasti()
	
	else
		messagebox("Cancellazione" + k_record,  "Operazione Annullata !!")
		k_return = 2
	end if
end if
	
choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_1.dw_1.setfocus()
		tab_1.tabpage_1.dw_1.setcolumn(1)
//	case 2
//		tab_1.tabpage_2.dw_2.setfocus()
//		tab_1.tabpage_2.dw_2.setcolumn(1)
end choose	
	

return k_return

end function

private subroutine leggi_altre_tab ();
end subroutine

private function integer check_rek (string k_codice);//
int k_return = 0
int k_anno
string k_descr
long k_codice_1



if trim(k_codice) > " " then
	
	SELECT 
         sl_pt.descr  
   	 INTO 
      	   :k_descr  
    	FROM sl_pt 
   	WHERE cod_sl_pt = :k_codice
		using kguo_sqlca_db_magazzino ;

	if kguo_sqlca_db_magazzino.sqlcode = 0 then

		if messagebox("Piano già in Archivio", & 
					"Vuoi modificare il codice del Piano di Trattamento: "  &
					+ kkg.acapo + trim(k_codice) + " " +trim(k_descr), question!, yesno!, 2) = 1 then
		
			tab_1.tabpage_2.dw_2.reset()
			tab_1.tabpage_4.dw_4.reset()

			ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
			ki_st_open_w.key1 = trim(k_codice) 

			tab_1.tabpage_1.dw_1.reset()
			
			inizializza()
			
		else
			k_return = 1
		end if

	else			
		
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			tab_1.tabpage_2.dw_2.enabled = false
			tab_1.tabpage_4.dw_4.enabled = false
			messagebox("Lettura Codice Piano", & 
				"Si è verificato un errore in lettura del Piano: " + trim(k_codice) + " " &
				+ kkg.acapo + "Errore: " + string(kguo_sqlca_db_magazzino.sqlcode) + " - " &
				+ trim(kguo_sqlca_db_magazzino.sqlerrtext), stopsign!)
			k_return = 1
		else
			tab_1.tabpage_2.enabled = true
			tab_1.tabpage_4.enabled = true
		end if
	end if

else

	tab_1.tabpage_2.dw_2.reset()
	tab_1.tabpage_4.dw_4.reset()
	tab_1.tabpage_2.enabled = false
	tab_1.tabpage_4.enabled = false
	
end if

attiva_tasti()


return k_return


end function

protected subroutine inizializza_1 ();//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_codice, k_rc
int k_dosim_x_bcode, k_ctr, k_righe


	u_pulizia_righe_dosimpos()	

	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt")  
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"dosim_x_bcode") > 0 then
			k_dosim_x_bcode = tab_1.tabpage_1.dw_1.getitemnumber(1,"dosim_x_bcode")
		end if	
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosim_x_bcode") > 0 then
			k_dosim_x_bcode += tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosim_x_bcode")
		end if	
		
		if trim(k_codice) > " " then 
		
	//=== Se le righe presenti non c'entrano con il codice della prima mappa allora resetto		
			if tab_1.tabpage_2.dw_2.rowcount() > 0 then
				if tab_1.tabpage_2.dw_2.getitemstring(1, "cod_sl_pt") <> k_codice then 
					tab_1.tabpage_2.dw_2.reset()
				end if
			end if
	
			k_righe = tab_1.tabpage_2.dw_2.rowcount()
			if k_righe = 0 then
				k_righe = tab_1.tabpage_2.dw_2.retrieve(k_codice) 
			end if
			
			for k_ctr = (k_righe + 1) to k_dosim_x_bcode
				inserisci()
			next

			if tab_1.tabpage_2.dw_2.rowcount() > 0 then
				k_rc = tab_1.tabpage_2.dw_2.modify( "k_dosim_x_bcode=" + string(k_dosim_x_bcode))
			end if
	
			attiva_tasti()
			tab_1.tabpage_2.dw_2.setfocus()
				
		end if		
	end if
	tab_1.tabpage_2.dw_2.ki_flag_modalita = tab_1.tabpage_1.dw_1.ki_flag_modalita
	tab_1.tabpage_2.dw_2.u_proteggi_sproteggi_dw( )
	



end subroutine

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================
//
string k_return="0 ", k_errore="0 ", k_errore1="0 "
int k_rc, k_rows, k_row, k_associato
st_tab_sl_pt kst_tab_sl_pt
kuf_asdslpt kuf1_asdslpt
st_tab_asdslpt kst_tab_asdslpt
st_tab_sl_pt_g3 kst_tab_sl_pt_g3
st_tab_g_0 kst_tab_g_0
uo_ds_std_1 kds_1


try

//=== Aggiorna, se modificato, la TAB_1	
	if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 OR &
		tab_1.tabpage_1.dw_1.getnextmodified(0, delete!) > 0 & 
		then
	
	//--- Tratto il CAMPO et_descr in modo particolare (diviso in 2 parti)
		if isnull(tab_1.tabpage_1.dw_1.getitemstring(1, "dosim_et_descr")) then tab_1.tabpage_1.dw_1.setitem(1, "dosim_et_descr", " ")
		kst_tab_sl_pt.dosim_et_descr = tab_1.tabpage_1.dw_1.getitemstring(1, "dosim_et_descr") + space(40)
		if isnull(tab_1.tabpage_1.dw_1.getitemstring(1, "dosim_et_descr_1")) then tab_1.tabpage_1.dw_1.setitem(1, "dosim_et_descr_1", " ")
		kst_tab_sl_pt.dosim_et_descr = left(kst_tab_sl_pt.dosim_et_descr,40) + tab_1.tabpage_1.dw_1.getitemstring(1, "dosim_et_descr_1")
		if trim(kst_tab_sl_pt.dosim_et_descr) = "" then kst_tab_sl_pt.dosim_et_descr = "" 
	
		tab_1.tabpage_1.dw_1.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins())
		tab_1.tabpage_1.dw_1.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente())

		if tab_1.tabpage_1.dw_1.update() = 1 then

//--- aggiorna manualmente anche la descrizione che è spezzata in due
			kst_tab_sl_pt.cod_sl_pt = tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt") 
			kiuf_sl_pt.set_dosim_et_descr(kst_tab_sl_pt)

//--- aggiorna la parte G3
			if tab_1.tabpage_1.dw_1.getitemstring(1, "g3_cod_sl_pt") > " " then
			else
				tab_1.tabpage_1.dw_1.setitem(1, "g3_cod_sl_pt", kst_tab_sl_pt.cod_sl_pt)
			end if
			kds_1 = create uo_ds_std_1
			kds_1.dataobject = "d_sl_pt"
			k_rc = tab_1.tabpage_1.dw_1.rowscopy(1, 1, primary!, kds_1, 1, primary!)
			kiuf_sl_pt_g3.tb_update(kst_tab_g_0, kds_1)				

			if kds_1.getitemnumber(1, "id_sl_pt_g3") > 0 then
				tab_1.tabpage_1.dw_1.setitem(1, "id_sl_pt_g3", kds_1.getitemnumber(1, "id_sl_pt_g3"))
			end if
			
			kguo_sqlca_db_magazzino.db_commit()

			tab_1.tabpage_1.dw_1.resetupdate( )
		else
		
			kguo_sqlca_db_magazzino.db_rollback()
			k_return="1Fallito aggiornamento archivio '" + tab_1.tabpage_1.text + "' " + kkg.acapo 
			
		end if
		
	end if

//=== Aggiorna, se modificato, la TABPAGE_2
	if (tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 OR &
		 tab_1.tabpage_2.dw_2.getnextmodified(0, delete!) > 0 OR &
		 tab_1.tabpage_2.dw_2.deletedcount( ) > 0) &
		and tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt") > " " then
			
	//--- update dati dosimetri			
		k_rc = tab_1.tabpage_2.dw_2.update()
		
		if k_rc < 0 then
			kguo_sqlca_db_magazzino.db_rollback()
			kguo_exception.inizializza(this.classname())
			kguo_exception.kist_esito.esito = kkg_esito.db_ko
			kguo_exception.kist_esito.sqlerrtext = &
					  "Fallito aggiornamento archivio '" + tab_1.tabpage_2.text + "' " + kkg.acapo &
						+ "Errore: " + trim(tab_1.tabpage_2.dw_2.kist_esito.sqlerrtext) &
						+ " (" + string(tab_1.tabpage_2.dw_2.kist_esito.sqlcode) + ")"
			throw kguo_exception
		end if

		kguo_sqlca_db_magazzino.db_commit()
		k_rc = tab_1.tabpage_2.dw_2.resetupdate()
		
	end if

//=== Aggiorna, se modificato, la TABPAGE_4
	kst_tab_sl_pt_g3.id_sl_pt_g3 = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_sl_pt_g3")
	if (tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0 OR &
		tab_1.tabpage_4.dw_4.getnextmodified(0, delete!) > 0 OR &
		tab_1.tabpage_4.dw_4.deletedcount( ) > 0 ) &
		and tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt") > " " &
		and kst_tab_sl_pt_g3.id_sl_pt_g3 > 0 then

		k_row = tab_1.tabpage_4.dw_4.getnextmodified(0, primary!)
		do while k_row > 0  
			//--- se sono in inserimento set ID del G3 e lo STATUS a PROPOSTA
			if tab_1.tabpage_4.dw_4.getitemnumber(k_row, "id_sl_pt_g3") > 0 then
			else
				tab_1.tabpage_4.dw_4.setitem(k_row, "id_sl_pt_g3", kst_tab_sl_pt_g3.id_sl_pt_g3)
				tab_1.tabpage_4.dw_4.setitem(k_row, "g3status", kiuf_sl_pt_g3.kki_g3status_Proposto)
				tab_1.tabpage_4.dw_4.setitem(k_row, "proposta_data", kGuf_data_base.prendi_x_datins())
				tab_1.tabpage_4.dw_4.setitem(k_row, "proposta_utente", kGuf_data_base.prendi_x_utente())
			end if
			k_row = tab_1.tabpage_4.dw_4.getnextmodified(k_row, primary!)
		loop
			
	//--- update dati Trattamenti G3			
		k_rc = tab_1.tabpage_4.dw_4.update()
		
		if k_rc < 0 then
			kguo_sqlca_db_magazzino.db_rollback()
			kguo_exception.inizializza(this.classname())
			kguo_exception.kist_esito.esito = kkg_esito.db_ko
			kguo_exception.kist_esito.sqlerrtext = &
					  "Fallito aggiornamento archivio '" + tab_1.tabpage_4.text + "' " + kkg.acapo &
						+ "Errore: " + trim(tab_1.tabpage_4.dw_4.kist_esito.sqlerrtext) &
						+ " (" + string(tab_1.tabpage_4.dw_4.kist_esito.sqlcode) + ")"
			throw kguo_exception
		end if
		
		kguo_sqlca_db_magazzino.db_commit()
		k_rc = tab_1.tabpage_4.dw_4.resetupdate()
	end if
	
	//=== Aggiorna, se modificato, la TABPAGE_5
	if tab_1.tabpage_5.dw_5.getnextmodified(0, primary!) > 0 OR &
		tab_1.tabpage_5.dw_5.getnextmodified(0, delete!) > 0 OR &
		tab_1.tabpage_5.dw_5.deletedcount( ) > 0 then
	
		kuf1_asdslpt = create kuf_asdslpt
		
		k_rows = tab_1.tabpage_5.dw_5.rowcount( )
	
		for k_row = 1 to k_rows
			
			kst_tab_asdslpt.id_asdslpt = tab_1.tabpage_5.dw_5.getitemnumber(k_row, "id_asdslpt")
			
			k_associato = tab_1.tabpage_5.dw_5.getitemnumber(k_row, "k_associato")
			
			if kst_tab_asdslpt.id_asdslpt > 0 then
				if k_associato = 0 then  // associazione da rimuovere 
				
					kuf1_asdslpt.tb_delete(kst_tab_asdslpt)
						
				end if
			else
				if k_associato = 1 then  // associazione da caricare
				
					kst_tab_asdslpt.cod_sl_pt = tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt")
					kst_tab_asdslpt.id_asddevice = tab_1.tabpage_5.dw_5.getitemnumber(k_row, "id_asddevice")
					kuf1_asdslpt.u_add(kst_tab_asdslpt)
				
				end if
			end if
			
		next
	
		tab_1.tabpage_5.dw_5.ResetUpdate()


	end if


	kguo_sqlca_db_magazzino.db_commit()


catch (uo_exception kuo_exception)
	kguo_sqlca_db_magazzino.db_rollback()
	kuo_exception.messaggio_utente()
	k_return="1Errore in aggiornamento archivi: " + kuo_exception.kist_esito.sqlerrtext + " ~n~r" 


finally
	if isvalid(kuf1_asdslpt) then destroy kuf1_asdslpt
	
	
end try

return k_return

end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta
string k_stato = "0"
string  k_key
string k_fine_ciclo=""
int k_ctr=0
int k_err_ins, k_rc
//kuf_utility kuf1_utility
kuf_sl_pt_cambio_giri kuf1_sl_pt_cambio_giri


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	k_key = trim(ki_st_open_w.key1)

	if LenA(k_key) = 0 then
		
		k_err_ins = inserisci()
		tab_1.tabpage_1.dw_1.setfocus()
	else

		k_rc = tab_1.tabpage_1.dw_1.retrieve(k_key) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(Codice ricercato:" + trim(k_key) + ")~n~r" )
				cb_ritorna.postevent(clicked!)


			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				if k_scelta = kkg_flag_modalita.modifica then
					messagebox("Ricerca fallita", &
						"Mi spiace ma il SL-PT non e' in Archivio ~n~r" + &
						"(Codice ricercato:" + trim(k_key) + ")~n~r" )

					cb_ritorna.triggerevent("clicked!")
					
				else
					k_err_ins = inserisci()
					tab_1.tabpage_1.dw_1.setfocus()
				end if
				
				
			case is > 0		

				if k_scelta = "in" then
					
					messagebox("Trovata Anagrafica", &
							"Il PT e' gia' in archivio  ( Codice ricercato : " + trim(k_key) + " )~n~r" )
			
	           		ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
					
					kist_tab_sl_pt_orig.proposta_tipo_cicli = tab_1.tabpage_1.dw_1.getitemstring(1, "proposta_tipo_cicli")
					kist_tab_sl_pt_orig.proposta_fila_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_1")
					kist_tab_sl_pt_orig.proposta_fila_1p = tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_1p")
					kist_tab_sl_pt_orig.proposta_fila_2 = tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_2")
					kist_tab_sl_pt_orig.proposta_fila_2p = tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_2p")
					
				end if

				tab_1.tabpage_1.dw_1.setcolumn(1)
				tab_1.tabpage_1.dw_1.setfocus()
				
				attiva_tasti()
		
		end choose

	end if

else
	attiva_tasti()
end if

//--- enable tab correlati a TRUE/FALSE
if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	tab_1.tabpage_2.enabled = false
	tab_1.tabpage_4.enabled = false
else	
	if trim(tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt")) > " " then
		tab_1.tabpage_2.enabled = true
//		if tab_1.tabpage_1.dw_1.getitemnumber(1, "id_sl_pt_g3") > 0 then
			tab_1.tabpage_4.enabled = true
//		end if		
	else	
		tab_1.tabpage_2.enabled = false
		tab_1.tabpage_4.enabled = false
	end if
end if

ki_cambio_giri_autorizzato = false
ki_b_reset_proposta = false

tab_1.tabpage_1.dw_1.ki_flag_modalita = ki_st_open_w.flag_modalita
tab_1.tabpage_1.dw_1.u_proteggi_sproteggi_dw( )
//--- Inabilita campi alla modifica se Vsualizzazione
if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.cancellazione then

else		
//--- popola dw child dw clienti 
	u_set_dw_clienti_child()
	
	ki_b_reset_proposta = true

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
		tab_1.tabpage_1.dw_1.u_proteggi_dw( "1", 1)
	end if

	try
	
		if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.cancellazione then
//--- Utente autorizzato al cambio GIRI ?
			kuf1_sl_pt_cambio_giri = create kuf_sl_pt_cambio_giri
			ki_cambio_giri_autorizzato = kuf1_sl_pt_cambio_giri.if_sicurezza(kkg_flag_modalita.modifica )
		end if
			
	catch (uo_exception kuo_exception)
//			kuo_exception.messaggio_utente()
	
	end try

end if


return "0"

end function

protected function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_return = ""
string k_errore = "0"
int k_rows
int k_row, k_row_next, k_row_find
int k_num_file=0, k_num_file_p=0, k_num_diff_giri_fila1, k_num_diff_giri_fila2
int k_nr_errori
int k_dosim_x_bcode_g2, k_dosim_x_bcode_g3
string k_key_str, k_rcx
string k_stato, k_tipo
string k_key
st_tab_sl_pt_g3 kst_tab_sl_pt_g3



//=== Controllo il primo tab
	k_rows = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_row = 1

	k_key = tab_1.tabpage_1.dw_1.getitemstring ( k_row, "cod_sl_pt") 
	if isnull(k_key) or LenA(trim(k_key)) = 0 then
		k_return = tab_1.tabpage_1.text + ": Manca il codice SL-PT! " + kkg.acapo
		k_errore = "3"
		k_nr_errori++
	end if
	if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_row, "descr")) = true then
		k_return = k_return + tab_1.tabpage_1.text + ": Manca la descrizione; " + kkg.acapo 
		k_errore = "3"
		k_nr_errori++
	end if

	if k_errore = "0" or k_errore = "4" then
		if tab_1.tabpage_1.dw_1.getitemnumber(k_row, "dose_min") > 0 and tab_1.tabpage_1.dw_1.getitemnumber(k_row, "dose_max") > 0 then
		   if tab_1.tabpage_1.dw_1.getitemnumber( k_row, "dose_min") > tab_1.tabpage_1.dw_1.getitemnumber( k_row, "dose_max") then
				k_return = k_return + tab_1.tabpage_1.text + ": Dose Massima minore della Minima; " &
			           + kkg.acapo 
				k_errore = "1"
				k_nr_errori++
			end if
		end if
	end if
//--- G2	
	if k_errore = "0" or k_errore = "4" then
		if tab_1.tabpage_1.dw_1.getitemnumber( k_row, "dosetgminmin") > 0 and tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "dosetgminmax") > 0 then		
			if tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "dosetgminmax") > 0 &
			   		and tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "dosetgminmin") > tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "dosetgminmax") then
				k_return = k_return + tab_1.tabpage_1.text + " G2: valore Massimo di 'Dose Target Minima' minore del Minimo; " &
			           + kkg.acapo 
				k_errore = "1"
				k_nr_errori++
			end if
			if tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "dosetgmaxmax") > 0 &
						and tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "dosetgmaxmin") > tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "dosetgmaxmax") then
				k_return = k_return + tab_1.tabpage_1.text + " G2: valore Massimo di 'Dose Target Massima' minore del Minimo; " &
			   		      + kkg.acapo 
				k_errore = "1"
				k_nr_errori++
			end if
		end if
	end if
	if k_errore = "0" or k_errore = "4" then
		if tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "densita") > 0 and tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "densitamax") > 0 &
			   and tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "densita") > tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "densitamax") then
			k_return = k_return + tab_1.tabpage_1.text + " G2: Densità massima minore della minima; " &
			           + kkg.acapo 
			k_errore = "1"
			k_nr_errori++
		end if
	end if
	
//--- G3
	if k_errore = "0" or k_errore = "4" then
		if tab_1.tabpage_1.dw_1.getitemnumber( k_row, "g3_dosetgminmin") > 0 and tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "g3_dosetgminmax") > 0 then		
			if tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "g3_dosetgminmax") > 0 &
			   		and tab_1.tabpage_1.dw_1.getitemnumber( k_row, "g3_dosetgminmin") > tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "g3_dosetgminmax") then
				k_return = k_return + tab_1.tabpage_1.text + " G3: valore Massimo di 'Dose Target Minima' minore del Minimo; " &
			           + kkg.acapo 
				k_errore = "1"
				k_nr_errori++
			end if
			if tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "g3_dosetgmaxmax") > 0 &
						and tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "g3_dosetgmaxmin") > tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "g3_dosetgmaxmax") then
				k_return = k_return + tab_1.tabpage_1.text + " G3: valore Massimo di 'Dose Target Massima' minore del Minimo; " &
							+ kkg.acapo 
				k_errore = "1"
				k_nr_errori++
			end if
		end if
	end if
	if k_errore = "0" or k_errore = "4" then
		if tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "g3_densita") > 0 and tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "g3_densitamax") > 0 &
			   and tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "g3_densita") > tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "g3_densitamax") then
			k_return = k_return + tab_1.tabpage_1.text + " G3: Densità massima minore della minima; " &
			           + kkg.acapo 
			k_errore = "1"
			k_nr_errori++
		end if
	end if

//--- il file deve iniziare con il BARRA di inizio cartella, se non c'è l'aggiunge
	k_rcx = trim(tab_1.tabpage_1.dw_1.getitemstring ( k_row, "packingformin_file"))
   if k_rcx> " " then
	   if left(k_rcx, 1) = kkg.path_sep then
		else
	      tab_1.tabpage_1.dw_1.setitem( k_row, "packingformin_file", (kkg.path_sep + k_rcx)) 
		end if
	end if

//--- Tipo cicli di trattamento congruente?
	if k_errore = "0" or k_errore = "4" then
		k_num_file = 0           // numero file valorizzate
		k_num_file_p = 0         // numero file permutate valorizzate 
		if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_row, "tipo_cicli")) = true then
			tab_1.tabpage_1.dw_1.setitem( k_row, "tipo_cicli", "0") 
		end if
//--- quante 'file' sono valorizzate?		
		if tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "fila_1") > 0 then
			k_num_file++
		   if isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "fila_1p")) then
				tab_1.tabpage_1.dw_1.setitem( k_row, "fila_1p", tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "fila_1"))
			end if
		else
			if tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "fila_1p") > 0 &
		      and (isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "fila_1")) &
		       or tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "fila_1") = 0) then
				tab_1.tabpage_1.dw_1.setitem( k_row, "fila_1", 0)
			else
				tab_1.tabpage_1.dw_1.setitem( k_row, "fila_1", 0)
				tab_1.tabpage_1.dw_1.setitem( k_row, "fila_1p", 0)
			end if
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "fila_2") > 0 then
			k_num_file++
		   if isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "fila_2p")) then
				tab_1.tabpage_1.dw_1.setitem( k_row, "fila_2p", tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "fila_2"))
			end if
		else
			if tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "fila_2p") > 0 &
		      and (isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "fila_2")) &
		       or tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "fila_2") = 0) then
				tab_1.tabpage_1.dw_1.setitem( k_row, "fila_2", 0)
			else
				tab_1.tabpage_1.dw_1.setitem( k_row, "fila_2", 0)
				tab_1.tabpage_1.dw_1.setitem( k_row, "fila_2p", 0)
			end if
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "fila_1p") > 0 then
			k_num_file_p++
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber ( k_row, "fila_2p") > 0 then
			k_num_file_p++
		end if

		choose case tab_1.tabpage_1.dw_1.getitemstring ( k_row, "tipo_cicli")
//--- ciclo normale ( valorizza fila 1 o fila 2) //???? con permutazione identica )
			case "0"
				if (k_num_file > 1 or k_num_file_p > 1) then
					k_return = k_return + tab_1.tabpage_1.text + ": Per Trattamento modalita' '" &
					       + trim(MidA (tab_1.tabpage_1.dw_1.getvalue("tipo_cicli",1), 1, PosA(tab_1.tabpage_1.dw_1.getvalue("tipo_cicli",1), "~t", 1) - 1)) &
					       + "' impostare solo Giri in Fila 1 o 2; " &
							 + kkg.acapo 
					k_errore = "1"
					k_nr_errori++
				end if 
//--- ciclo normale a scelta ( valorizza fila 1 e fila 2 ) //???con permutazione identica )
			case "1", "2"
				if k_errore = "0" or k_errore = "4" then
					if (k_num_file = 1 and k_num_file_p = 1) then
						k_return = k_return + tab_1.tabpage_1.text + ": E' più opportuno impostare la modalita' di Trattamento a '" &
							 + trim(MidA(tab_1.tabpage_1.dw_1.getvalue("tipo_cicli",1), 1, PosA(tab_1.tabpage_1.dw_1.getvalue("tipo_cicli",1), "~t", 1) - 1)) &
							 + "'; " &
							 + kkg.acapo 
						k_errore = "4"
						//k_nr_errori++
					end if
				end if
		end choose
	end if


//=== Controllo Posizioni dosimetri
	k_row = tab_1.tabpage_2.dw_2.getnextmodified(0, primary!)
	k_rows = tab_1.tabpage_2.dw_2.rowcount( )
	if tab_1.tabpage_1.dw_1.getitemnumber(1,"dosim_x_bcode") > 0 then
		k_dosim_x_bcode_g2 = tab_1.tabpage_1.dw_1.getitemnumber(1,"dosim_x_bcode")
	end if	
	if tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosim_x_bcode") > 0 then
		k_dosim_x_bcode_g3 = tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosim_x_bcode")
	end if	
	do while k_row > 0 and k_nr_errori < 10

		if tab_1.tabpage_2.dw_2.getitemnumber (k_row, "impianto") > 0 then
			if tab_1.tabpage_2.dw_2.getitemnumber (k_row, "impianto") = 2 then
				k_dosim_x_bcode_g2 --
			else
				if tab_1.tabpage_2.dw_2.getitemnumber (k_row, "impianto") = 3 then
					k_dosim_x_bcode_g3 --
				end if
			end if
		else
			k_return += tab_1.tabpage_2.text + ": Manca il numero Impianto! " &
															+ "Vedi alla riga " + string(k_row)  &
															+ kkg.acapo
			k_errore = "3"
			k_nr_errori++
		end if

		k_row = tab_1.tabpage_2.dw_2.getnextmodified(k_row, primary!)
	loop
	if k_rows > 0 then
		if k_dosim_x_bcode_g2 < 0 then
			if	tab_1.tabpage_1.dw_1.getitemnumber(1,"dosim_x_bcode") > 0 then
				k_return += tab_1.tabpage_2.text + ": Ci sono " + string(k_dosim_x_bcode_g2 * -1) + " Dosimetri G2 in più di quelli indicati in Testata! " &
															+ kkg.acapo
			else
				k_return += tab_1.tabpage_2.text + ": Togliere i " + string(k_dosim_x_bcode_g2 * -1) + " Dosimetri G2 non sono stati indicati in Testata! " &
															+ kkg.acapo
			end if
			k_errore = "1"
			k_nr_errori++
		end if
		if k_dosim_x_bcode_g3 < 0 then
			if	tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosim_x_bcode") > 0 then
				k_return += tab_1.tabpage_2.text + ": Ci sono " + string(k_dosim_x_bcode_g3 * -1) + " Dosimetri G3 in più di quelli indicati in Testata! " &
															+ kkg.acapo
			else
				k_return += tab_1.tabpage_2.text + ": Togliere i " + string(k_dosim_x_bcode_g3 * -1) + " Dosimetri G3 non sono stati indicati in Testata! " &
															+ kkg.acapo
			end if
			k_errore = "1"
			k_nr_errori++
		end if
	end if


//=== Controllo Trattamenti Impianto G3
	k_row = tab_1.tabpage_4.dw_4.getnextmodified(0, primary!)
	k_rows = tab_1.tabpage_4.dw_4.rowcount( )
	do while k_row > 0  and k_nr_errori < 10

		if tab_1.tabpage_4.dw_4.getitemnumber (k_row, "ciclo_target") > 0 then
			if tab_1.tabpage_4.dw_4.getitemnumber (k_row, "ciclo_min") > 0 &
					and tab_1.tabpage_4.dw_4.getitemnumber (k_row, "ciclo_target") < tab_1.tabpage_4.dw_4.getitemnumber (k_row, "ciclo_min") then  
				k_return += tab_1.tabpage_4.text + ": Attenzione, Ciclo Target " + string(tab_1.tabpage_4.dw_4.getitemnumber (k_row, "ciclo_target")) &
															+ " minore del Minimo " +string(tab_1.tabpage_4.dw_4.getitemnumber (k_row, "ciclo_min")) + "." &
															+ "Vedi alla riga " + string(k_row)  &
															+ kkg.acapo
				k_errore = "3"
				k_nr_errori++
			elseif tab_1.tabpage_4.dw_4.getitemnumber (k_row, "ciclo_max") > 0 &
							and tab_1.tabpage_4.dw_4.getitemnumber (k_row, "ciclo_target") > tab_1.tabpage_4.dw_4.getitemnumber (k_row, "ciclo_max") then  
				k_return += tab_1.tabpage_4.text + ": Attenzione, Ciclo Target " + string(tab_1.tabpage_4.dw_4.getitemnumber (k_row, "ciclo_target")) &
															+ " maggiore del Massimo " +string(tab_1.tabpage_4.dw_4.getitemnumber (k_row, "ciclo_max")) + "." &
															+ "Vedi alla riga " + string(k_row)  &
															+ kkg.acapo
				k_errore = "3"
				k_nr_errori++
			end if
		end if
		if tab_1.tabpage_4.dw_4.getitemnumber (k_row, "ciclo_min") > 0 and tab_1.tabpage_4.dw_4.getitemnumber (k_row, "ciclo_max") > 0 &
					and tab_1.tabpage_4.dw_4.getitemnumber (k_row, "ciclo_max") < tab_1.tabpage_4.dw_4.getitemnumber (k_row, "ciclo_min") then  
				k_return += tab_1.tabpage_4.text + ": Attenzione, Ciclo Massimo " + string(tab_1.tabpage_4.dw_4.getitemnumber (k_row, "ciclo_max")) &
															+ " minore del Minimo " +string(tab_1.tabpage_4.dw_4.getitemnumber (k_row, "ciclo_min")) + "." &
															+ "Vedi alla riga " + string(k_row)  &
															+ kkg.acapo
			k_errore = "3"
			k_nr_errori++
		end if			

		k_row = tab_1.tabpage_4.dw_4.getnextmodified(k_row, primary!)
	loop
	
return k_errore + k_return


end function

protected subroutine open_start_window ();//
kiuf_sl_pt = create kuf_sl_pt
kiuf_sl_pt_g3 = create kuf_sl_pt_g3

tab_1.tabpage_2.dw_2.modify( "k_delete.visible=1")
tab_1.tabpage_2.dw_2.modify( "b_delete.visible=1")

tab_1.tabpage_4.dw_4.modify( "k_delete.visible=1")
tab_1.tabpage_4.dw_4.modify( "b_delete.visible=1")


end subroutine

public subroutine trattamento_proposta_reset ();//
//--- Cancella il trattamento PROPOSTA
//
st_tab_sl_pt kst_tab_sl_pt

	if ki_b_reset_proposta then

//--- azzera proposta
		kst_tab_sl_pt.proposta_tipo_cicli = ""
		kst_tab_sl_pt.proposta_fila_1 = 0
		kst_tab_sl_pt.proposta_fila_1p = 0
		kst_tab_sl_pt.proposta_fila_2 = 0
		kst_tab_sl_pt.proposta_fila_2p = 0
		tab_1.tabpage_1.dw_1.setitem( 1, "proposta_tipo_cicli", kst_tab_sl_pt.proposta_tipo_cicli )
		tab_1.tabpage_1.dw_1.setitem( 1, "proposta_fila_1", kst_tab_sl_pt.proposta_fila_1)
		tab_1.tabpage_1.dw_1.setitem( 1, "proposta_fila_1p", kst_tab_sl_pt.proposta_fila_1p)
		tab_1.tabpage_1.dw_1.setitem( 1, "proposta_fila_2", kst_tab_sl_pt.proposta_fila_2)
		tab_1.tabpage_1.dw_1.setitem( 1, "proposta_fila_2p", kst_tab_sl_pt.proposta_fila_2p)

	end if

	attiva_tasti( )
	
end subroutine

public subroutine trattamento_proposta_sposta ();//
//--- sposta il trattamento da PROPOSTA a EFFETTIVO
//
st_tab_sl_pt kst_tab_sl_pt

if ki_cambio_giri_autorizzato then

	tab_1.tabpage_1.dw_1.accepttext( )

//--- copia proposta in effettivo	
	kst_tab_sl_pt.proposta_tipo_cicli = tab_1.tabpage_1.dw_1.getitemstring(1, "proposta_tipo_cicli")
	kst_tab_sl_pt.proposta_fila_pref = tab_1.tabpage_1.dw_1.getitemstring(1, "proposta_fila_pref")
	kst_tab_sl_pt.proposta_fila_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_1")
	kst_tab_sl_pt.proposta_fila_1p = tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_1p")
	kst_tab_sl_pt.proposta_fila_2 = tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_2")
	kst_tab_sl_pt.proposta_fila_2p = tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_2p")
	if len(trim(kst_tab_sl_pt.proposta_tipo_cicli)) > 0 then
		tab_1.tabpage_1.dw_1.setitem( 1, "tipo_cicli", kst_tab_sl_pt.proposta_tipo_cicli )
		tab_1.tabpage_1.dw_1.setitem( 1, "fila_pref", kst_tab_sl_pt.proposta_fila_pref)
		tab_1.tabpage_1.dw_1.setitem( 1, "fila_1", kst_tab_sl_pt.proposta_fila_1)
		tab_1.tabpage_1.dw_1.setitem( 1, "fila_1p", kst_tab_sl_pt.proposta_fila_1p)
		tab_1.tabpage_1.dw_1.setitem( 1, "fila_2", kst_tab_sl_pt.proposta_fila_2)
		tab_1.tabpage_1.dw_1.setitem( 1, "fila_2p", kst_tab_sl_pt.proposta_fila_2p)
	end if
	
//--- azzera proposta
	trattamento_proposta_reset( )

end if

end subroutine

private subroutine u_open_esempio_st_dosim ();//
string k_path 
kuf_file_explorer kuf1_file_explorer


	k_path = kguo_path.get_risorse( ) + kkg.path_sep + "dosimetroesempio.png"
	SetPointer(kkg.pointer_attesa)
	kuf1_file_explorer = create kuf_file_explorer
	kuf1_file_explorer.of_execute( k_path )
	destroy kuf1_file_explorer

end subroutine

public function boolean u_get_dati_cliente (ref st_tab_clienti kst_tab_clienti);//
boolean k_return = false
st_esito kst_esito
kuf_clienti kuf1_clienti

////---- scrive Trace su LOG---------
//PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
//u_write_trace()  
////-------------------------------------


try
	
	kuf1_clienti = create kuf_clienti

	k_return = kuf1_clienti.leggi (kst_tab_clienti)
	
//--- Gestione di Allert per il cliente 	
//	u_allarme_cliente(kst_tab_clienti)
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	

finally
	if isvalid(kuf1_clienti) then destroy kuf1_clienti
////---- scrive Trace su LOG---------
//PopulateError(2, "fattura") //x popolare systemerror con i vari dati automatici 
//u_write_trace()  
////-------------------------------------

	
end try

return k_return


end function

private subroutine u_put_video_cliente (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente 
//

tab_1.tabpage_1.dw_1.modify( "id_cliente.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "id_cliente", kst_tab_clienti.codice )
tab_1.tabpage_1.dw_1.modify( "rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "rag_soc_10", trim(kst_tab_clienti.rag_soc_10) )

tab_1.tabpage_1.dw_1.setitem( 1, "id_cliente", kst_tab_clienti.codice)
tab_1.tabpage_1.dw_1.setitem( 1, "rag_soc_10", kst_tab_clienti.rag_soc_10 )

attiva_tasti()


end subroutine

private function boolean if_anag_attiva (st_tab_clienti ast_tab_clienti);//
//--- Verifica se l'angrafica è attiva
//
boolean k_return = false
kuf_clienti kiuf_clienti


try
	setPointer(kkg.pointer_attesa)

	kiuf_clienti = create kuf_clienti
	if ast_tab_clienti.codice > 0 then

		k_return = kiuf_clienti.if_attivo(ast_tab_clienti)
		if not k_return then
			messagebox("Anagrafica non attiva", &
			    "Il cliente "+ string(ast_tab_clienti.codice) + " non è Attivo in Anagrafe, per utilizzarlo prima procedere con il cambio di stato", information!)
		end if
		
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	if isvalid(kiuf_clienti) then destroy kiuf_clienti
	SetPointer(kkg.pointer_default)

end try
	
return k_return

end function

public subroutine u_set_dw_clienti_child ();//
int k_rc
string k_cadenza_fattura="", k_x=""
datawindowchild  kdwc_1, kdwc_2


//	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		
		tab_1.tabpage_1.dw_1.getchild("id_cliente", kdwc_1)
		kdwc_1.settransobject(sqlca)
		
//--- se non avevo letto nulla allora faccio il ripopolamento delle DW
		if kdwc_1.rowcount() = 0 then
			kdwc_1.reset() 
			kdwc_1.retrieve("%")
			kdwc_1.SetSort("id_cliente A")
			kdwc_1.sort( )
			kdwc_1.insertrow(1)
			
			tab_1.tabpage_1.dw_1.getchild("rag_soc_10", kdwc_2)
			kdwc_2.settransobject(sqlca)
			kdwc_2.reset() 
//			kdwc_2.retrieve("%")
			k_rc = kdwc_1.RowsCopy(1, kdwc_1.RowCount(), Primary!, kdwc_2, 1, Primary!)
			k_rc = kdwc_2.SetSort("rag_soc_1 A")
			k_rc = kdwc_2.sort( )
		end if		
		
//	end if


end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

long k_riga = 0
string k_codice = ""


super::attiva_tasti_0()

cb_ritorna.enabled = true
cb_ritorna.default = false
cb_inserisci.default = false
cb_aggiorna.default = false
cb_cancella.default = false

//--- pulsante che fa vedere un esempio di stampa, sempre ebilitato
tab_1.tabpage_1.dw_1.modify("p_img_dosimesempio.enabled = '1'")

//--- inabilito le mofidifice sulla dw
if ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione or ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then
	
	cb_inserisci.enabled = false
	cb_aggiorna.enabled = false
	cb_cancella.enabled = false
	tab_1.tabpage_1.dw_1.modify( "b_reset_proposta.enabled=0")
	tab_1.tabpage_1.dw_1.modify( "b_trattamento_effettivo.enabled=0")
	tab_1.tabpage_4.dw_4.u_proteggi_dw( "0", "g3status") // sproteggi autorizza conferma trattamento

else
	
	cb_inserisci.enabled = true
	cb_aggiorna.enabled = true
	cb_cancella.enabled = true

//=== Nr righe ne DW lista
	choose case tab_1.selectedtab
		case 1
			k_riga = tab_1.tabpage_1.dw_1.getrow()
			if k_riga > 0 then
				k_codice = trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga,"cod_sl_pt"))
			end if
			if k_riga <= 0 or LenA(k_codice) = 0 or isnull(k_codice) then
				cb_inserisci.enabled = false
				cb_inserisci.default = false
				cb_cancella.enabled = false
				cb_aggiorna.enabled = false
			end if

//---  pulsante x Trasferimento in effettivo dei GIRI modificati proposti
			if ki_cambio_giri_autorizzato then
				tab_1.tabpage_1.dw_1.modify( "b_trattamento_effettivo.enabled=1")
				tab_1.tabpage_4.dw_4.u_proteggi_dw( "1", "g3status")  // proteggi autorizza conferma trattamento
			else
				tab_1.tabpage_1.dw_1.modify( "b_trattamento_effettivo.enabled=0")
				tab_1.tabpage_4.dw_4.u_proteggi_dw( "0", "g3status") // sproteggi autorizza conferma trattamento
			end if
//---  pulsante x reset dei GIRI modificati proposti
			if ki_b_reset_proposta then
				tab_1.tabpage_1.dw_1.modify( "b_reset_proposta.enabled=1")
			else
				tab_1.tabpage_1.dw_1.modify( "b_reset_proposta.enabled=0")
			end if

		case 2
			k_riga = tab_1.tabpage_2.dw_2.getrow()
			if k_riga <= 0 then
				cb_inserisci.enabled = false
				cb_inserisci.default = false
				cb_cancella.enabled = false
				cb_aggiorna.enabled = false
			end if
			if cb_aggiorna.enabled then
				tab_1.tabpage_2.dw_2.modify("b_delete.enabled=1") 
			else
				tab_1.tabpage_2.dw_2.modify("b_delete.enabled=0") 
			end if

		case 4
			k_riga = tab_1.tabpage_4.dw_4.getrow()
			if k_riga <= 0 then
				cb_inserisci.enabled = false
				cb_inserisci.default = false
				cb_cancella.enabled = false
				cb_aggiorna.enabled = false
			end if
			if cb_aggiorna.enabled then
				tab_1.tabpage_4.dw_4.modify("b_delete.enabled=1") 
			else
				tab_1.tabpage_4.dw_4.modify("b_delete.enabled=0") 
			end if

		case 5
				cb_inserisci.enabled = false
				cb_inserisci.default = false
				//cb_aggiorna.enabled = false
				cb_cancella.enabled = false

		case 7
				cb_inserisci.enabled = false
				cb_inserisci.default = false
				cb_aggiorna.enabled = false
				cb_cancella.enabled = false
	end choose

end if

end subroutine

protected subroutine pulizia_righe ();//=== toglie righe da non UPDATE
//

u_pulizia_righe_dosimpos()
u_pulizia_righe_g3()

end subroutine

protected subroutine u_pulizia_righe_dosimpos ();//--- Toglie righe da non UPDATE
string k_key
long k_rows, k_row



k_rows = tab_1.tabpage_2.dw_2.rowcount ( )
for k_row = k_rows to 1 step -1

	if tab_1.tabpage_2.dw_2.getitemstatus(k_row, 0, primary!) = newmodified! then 
		if trim(tab_1.tabpage_2.dw_2.getitemstring(k_row, "dosimpos_codice")) > " " then
		else
			tab_1.tabpage_2.dw_2.deleterow(k_row)
		end if
	end if
next


end subroutine

private subroutine u_get_path_packingformin_file ();//
string k_root, k_path_file, k_file, k_path
int k_ret
int k_pos


k_root = trim(tab_1.tabpage_1.dw_1.getitemstring (1, "dir_cust_packing_in"))
if k_root > " " then

	k_path = trim(tab_1.tabpage_1.dw_1.getitemstring (1, "packingformin_file"))
	if k_path > " " then
		if left(k_path, 1) = kkg.path_sep then // se ha già il barrra non lo aggiungo
		else
			k_path = kkg.path_sep + k_path
		end if
		k_path = k_root + k_path
	else
		k_path = k_root
	end if
		
	k_ret = GetFileOpenName ( "Scegliere il documento con il formato del packing del Lotto in entrata", k_path_file, k_file, "pdf", " Tutti i file (*.*),*.*" , k_root, 18) //32784)
	
	if k_ret = 1 then
		k_pos = pos(k_path_file, k_root)
		if k_pos > 0 then
// rimuove la ROOT dalla scelta
			k_file = trim(mid(k_path_file, len(k_root) + 1))
			
			if k_file > " " then
				tab_1.tabpage_1.dw_1.setitem(1, "packingformin_file", trim(k_file))
			end if
			
		else
			messagebox("Scelta Errata", "Il Documento deve essere all'interno della cartella '" + k_root + "', operazione scartata", stopsign!)
		end if		
	else
		if k_ret < 0 then
	//--- ERRORE	
		end if
	end if

else
	messagebox("Scelta Documento", "Manca l'indicazione della cartella radice sulle Proprietà Azienda, operazione bloccata", stopsign!)
	k_path=".."
end if



end subroutine

private subroutine u_open_packingformin_file ();//
string k_file_path, k_root
boolean k_ret
long ll_p
kuf_file_explorer kuf1_file_explorer


k_file_path = trim(tab_1.tabpage_1.dw_1.getitemstring (1, "packingformin_file"))

if k_file_path > " " then

	if left(k_file_path, 1) = kkg.path_sep then
	else
		k_file_path = kkg.path_sep + k_file_path
	end if

	k_root = trim(tab_1.tabpage_1.dw_1.getitemstring (1, "dir_cust_packing_in"))
	k_file_path = k_root + k_file_path

	kuf1_file_explorer = create kuf_file_explorer

	if not kuf1_file_explorer.of_execute( k_file_path ) then
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
		kguo_exception.setmessage( "Il documento non può essere aperto, forse estensione non riconosciuta o file non raggiungibile: " &
		 							+ kkg.acapo + k_file_path)
		kguo_exception.messaggio_utente( )
	end if

	destroy kuf1_file_explorer

end if



end subroutine

protected subroutine attiva_menu ();
//--- Vedi LOG da TemporalTable
	if not m_main.m_strumenti.m_fin_gest_libero8.toolbaritemvisible or ki_st_open_w.flag_primo_giro = 'S' then
		m_main.m_strumenti.m_fin_gest_libero8.text = "Visualizza dati Storici (Log Trace)"
		m_main.m_strumenti.m_fin_gest_libero8.microhelp = "Visualizza dati Storici"
		m_main.m_strumenti.m_fin_gest_libero8.enabled = true
		m_main.m_strumenti.m_fin_gest_libero8.toolbaritemtext =  "Log,"+ m_main.m_strumenti.m_fin_gest_libero8.text
		m_main.m_strumenti.m_fin_gest_libero8.toolbaritemvisible = true
		m_main.m_strumenti.m_fin_gest_libero8.visible = true
		m_main.m_strumenti.m_fin_gest_libero8.toolbaritemname = "history16.png"
	end if


	super::attiva_menu()

end subroutine

protected subroutine smista_funz (string k_par_in);/*
 Smista le chiamate esterne alla window a seconda delle funzionalita' richieste
 Usata per esempio dal menu popup
 Par. input: stringa k_par_in 
*/

choose case trim(left(k_par_in, 3))
		
//--- vedi LOG TRACE
	case kkg_flag_richiesta.libero8
		call_logtrace()	
	
	case else // standard
		super::smista_funz(k_par_in)
		
end choose



end subroutine

private subroutine call_logtrace ();//
//=== Open Window LogTrace MECA
long k_riga
st_tab_sl_pt kst_tab_sl_pt
st_open_w kst_open_w
kuf_logtrace_meca kuf1_logtrace_meca


try   
	k_riga = tab_1.tabpage_1.dw_1.getrow()
	if k_riga > 0 then

		kuf1_logtrace_meca = create kuf_logtrace_meca
	
		kst_tab_sl_pt.cod_sl_pt = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt" ))
			
		if kst_tab_sl_pt.cod_sl_pt > " " then
			
			kst_open_w.key1 = kst_tab_sl_pt.cod_sl_pt		
			kst_open_w.key2 = kiuf_sl_pt.get_id_programma(kkg_flag_modalita.visualizzazione )
			kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
			kuf1_logtrace_meca.u_open(kst_open_w) 

		end if
	end if 
		
catch (uo_exception	kuo_exception)
	kuo_exception.messaggio_utente()
		
end try
	


end subroutine

protected subroutine inizializza_6 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 7 controllandone i valori se gia' presenti
//======================================================================
//
string k_codice


	if tab_1.tabpage_1.dw_1.rowcount() > 0 then

		if tab_1.tabpage_7.dw_7.rowcount() > 0 then
			k_codice = trim(tab_1.tabpage_7.dw_7.getitemstring(1, "sl_pt"))
		end if
	
//--- se codice cambiato lo devo rileggere
		if k_codice <> trim(tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt")) then
			
			k_codice = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt"))
			if tab_1.tabpage_7.dw_7.retrieve(0, date(0), k_codice, 0) < 0 then
				kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Lettura elenco Listini per il PT codice=" + k_codice)	
				kguo_exception.messaggio_utente()
			else
				attiva_tasti()
			end if				
		else
			attiva_tasti()
		end if
	
		tab_1.tabpage_7.dw_7.setfocus()
		
	end if
	



end subroutine

protected subroutine inizializza_4 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_codice, k_rc
int k_ctr, k_righe
string k_show_all 


	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt")  
		
		if trim(k_codice) > " " then 
		
	//=== Se le righe presenti non c'entrano con il codice della prima mappa allora resetto		
			if tab_1.tabpage_5.dw_5.rowcount() > 0 then
				if tab_1.tabpage_5.dw_5.getitemstring(1, "cod_sl_pt") <> k_codice then 
					tab_1.tabpage_5.dw_5.reset()
				end if
			end if
	
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
				k_show_all = "S"
			else
				k_show_all = "N"
			end if
				
			k_righe = tab_1.tabpage_5.dw_5.rowcount()
			if k_righe = 0 or tab_1.tabpage_5.dw_5.ki_flag_modalita <> ki_st_open_w.flag_modalita then
				tab_1.tabpage_5.dw_5.ki_flag_modalita = ki_st_open_w.flag_modalita
				k_righe = tab_1.tabpage_5.dw_5.retrieve(k_codice, k_show_all) 
			end if

			kuf_utility kuf1_utility
			kuf1_utility = create kuf_utility 
			kuf1_utility.u_proteggi_sproteggi_dw(tab_1.tabpage_5.dw_5)
			destroy kuf1_utility

			attiva_tasti()
			tab_1.tabpage_5.dw_5.setfocus()
				
		end if
	
		
	end if
	



end subroutine

protected subroutine inizializza_3 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_codice
int k_rows, k_rc


	u_pulizia_righe_g3()	

	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		k_codice = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt"))
		if k_codice > " " then 
		
	//=== Se le righe presenti non c'entrano con il codice della prima mappa allora resetto		
			if tab_1.tabpage_4.dw_4.rowcount() > 0 then
				if tab_1.tabpage_4.dw_4.getitemstring(1, "cod_sl_pt") <> k_codice then 
					tab_1.tabpage_4.dw_4.reset()
				end if
			end if
	
			k_rows = tab_1.tabpage_4.dw_4.rowcount()
			if k_rows = 0 then
				k_rows = tab_1.tabpage_4.dw_4.retrieve(k_codice) 
			end if

			attiva_tasti()
			
			if  tab_1.tabpage_4.dw_4.rowcount() = 0 and ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
				inserisci()
			end if

			tab_1.tabpage_4.dw_4.setfocus()
				
		end if
	end if

	tab_1.tabpage_4.dw_4.ki_flag_modalita = tab_1.tabpage_1.dw_1.ki_flag_modalita
	tab_1.tabpage_4.dw_4.u_proteggi_sproteggi_dw( )
	

end subroutine

protected subroutine u_pulizia_righe_g3 ();//--- Toglie righe da non UPDATE
string k_key
long k_rows, k_row



k_rows = tab_1.tabpage_4.dw_4.rowcount ( )
for k_row = k_rows to 1 step -1

	if tab_1.tabpage_4.dw_4.getitemstatus(k_row, 0, primary!) = newmodified! then 
		if tab_1.tabpage_4.dw_4.getitemnumber(k_row, "id_sl_pt_g3_lav") > 0 then
		else
			if tab_1.tabpage_4.dw_4.getitemnumber(k_row, "g3npass") > 0 or tab_1.tabpage_4.dw_4.getitemnumber(k_row, "ciclo_target") > 0 then
			else
				tab_1.tabpage_4.dw_4.deleterow(k_row)
			end if
		end if
	end if
next


end subroutine

public subroutine u_copy_g2_to_g3 ();//
		if tab_1.tabpage_1.dw_1.getitemstring(1,"g3_peso") > " " then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_peso", tab_1.tabpage_1.dw_1.getitemstring(1,"peso"))
		end if
		if tab_1.tabpage_1.dw_1.getitemstring(1,"g3_pesomax") > " " then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_pesomax", tab_1.tabpage_1.dw_1.getitemstring(1,"pesomax"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_mis_x") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_mis_x", tab_1.tabpage_1.dw_1.getitemnumber(1,"mis_x"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_mis_y") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_mis_y", tab_1.tabpage_1.dw_1.getitemnumber(1,"mis_y"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_mis_z") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_mis_z", tab_1.tabpage_1.dw_1.getitemnumber(1,"mis_z"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosim_x_bcode") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_dosim_x_bcode", tab_1.tabpage_1.dw_1.getitemnumber(1,"dosim_x_bcode"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosim_delta_bcode") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_dosim_delta_bcode", tab_1.tabpage_1.dw_1.getitemnumber(1,"dosim_delta_bcode"))
		end if
		if tab_1.tabpage_1.dw_1.getitemstring(1,"g3_dosim_et_descr") > " " then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_dosim_et_descr"  , tab_1.tabpage_1.dw_1.getitemstring(1,"dosim_et_descr"))
		end if
		if tab_1.tabpage_1.dw_1.getitemstring(1,"g3_dosim_et_descr_1") > " " then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_dosim_et_descr_1" , tab_1.tabpage_1.dw_1.getitemstring(1,"dosim_et_descr_1"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosetgminmin") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_dosetgminmin", tab_1.tabpage_1.dw_1.getitemnumber(1,"dosetgminmin"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosetgminmax") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_dosetgminmax", tab_1.tabpage_1.dw_1.getitemnumber(1,"dosetgminmax"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosetgmaxmin") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_dosetgmaxmin", tab_1.tabpage_1.dw_1.getitemnumber(1,"dosetgmaxmin"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosetgmaxmax") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_dosetgmaxmax", tab_1.tabpage_1.dw_1.getitemnumber(1,"dosetgmaxmax"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosetgminfattcorr") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_dosetgminfattcorr", tab_1.tabpage_1.dw_1.getitemnumber(1,"dosetgminfattcorr"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosetgmaxfattcorr") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_dosetgmaxfattcorr", tab_1.tabpage_1.dw_1.getitemnumber(1,"dosetgmaxfattcorr"))
		end if
		if tab_1.tabpage_1.dw_1.getitemstring(1,"g3_dosetgmintcalc") > " " then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_dosetgmintcalc", tab_1.tabpage_1.dw_1.getitemstring(1,"dosetgmintcalc"))
		end if
		if tab_1.tabpage_1.dw_1.getitemstring(1,"g3_dosetgmaxtcalc") > " " then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_dosetgmaxtcalc", tab_1.tabpage_1.dw_1.getitemstring(1,"dosetgmaxtcalc"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosetgminfattcorr_max") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_dosetgminfattcorr_max", tab_1.tabpage_1.dw_1.getitemnumber(1,"dosetgminfattcorr_max"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosetgmaxfattcorr_max") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_dosetgmaxfattcorr_max", tab_1.tabpage_1.dw_1.getitemnumber(1,"dosetgmaxfattcorr_max"))
		end if
		if tab_1.tabpage_1.dw_1.getitemstring(1,"g3_dosetgmintcalc_max") > " " then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_dosetgmintcalc_max", tab_1.tabpage_1.dw_1.getitemstring(1,"dosetgmintcalc_max"))
		end if
		if tab_1.tabpage_1.dw_1.getitemstring(1,"g3_dosetgmaxtcalc_max") > " " then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_dosetgmaxtcalc_max", tab_1.tabpage_1.dw_1.getitemstring(1,"dosetgmaxtcalc_max"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_unitwork") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_unitwork", tab_1.tabpage_1.dw_1.getitemnumber(1,"unitwork"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_savedosimeter") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_savedosimeter", tab_1.tabpage_1.dw_1.getitemnumber(1,"savedosimeter"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_densita") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_densita", tab_1.tabpage_1.dw_1.getitemnumber(1,"densita"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_densitamax") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_densitamax", tab_1.tabpage_1.dw_1.getitemnumber(1,"densitamax"))
		end if
		if tab_1.tabpage_1.dw_1.getitemstring(1,"g3_notecliente") > " " then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_notecliente", tab_1.tabpage_1.dw_1.getitemstring(1,"notecliente"))
		end if
		if tab_1.tabpage_1.dw_1.getitemstring(1,"g3_note_descr") > " " then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"g3_note_descr", tab_1.tabpage_1.dw_1.getitemstring(1,"note_descr"))
		end if

	attiva_tasti()
	
end subroutine

public subroutine u_copy_g3_to_g2 ();//
		if tab_1.tabpage_1.dw_1.getitemstring(1,"peso") > " " then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"peso", tab_1.tabpage_1.dw_1.getitemstring(1,"g3_peso"))
		end if
		if tab_1.tabpage_1.dw_1.getitemstring(1,"pesomax") > " " then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"pesomax", tab_1.tabpage_1.dw_1.getitemstring(1,"g3_pesomax"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"mis_x") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"mis_x", tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_mis_x"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"mis_y") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"mis_y", tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_mis_y"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"mis_z") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"mis_z", tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_mis_z"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"dosim_x_bcode") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"dosim_x_bcode", tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosim_x_bcode"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"dosim_delta_bcode") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"dosim_delta_bcode", tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosim_delta_bcode"))
		end if
		if tab_1.tabpage_1.dw_1.getitemstring(1,"dosim_et_descr") > " " then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"dosim_et_descr"  , tab_1.tabpage_1.dw_1.getitemstring(1,"g3_dosim_et_descr"))
		end if
		if tab_1.tabpage_1.dw_1.getitemstring(1,"dosim_et_descr_1") > " " then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"dosim_et_descr_1" , tab_1.tabpage_1.dw_1.getitemstring(1,"g3_dosim_et_descr_1"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"dosetgminmin") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"dosetgminmin", tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosetgminmin"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"dosetgminmax") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"dosetgminmax", tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosetgminmax"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"dosetgmaxmin") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"dosetgmaxmin", tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosetgmaxmin"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"dosetgmaxmax") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"dosetgmaxmax", tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosetgmaxmax"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"dosetgminfattcorr") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"dosetgminfattcorr", tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosetgminfattcorr"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"dosetgmaxfattcorr") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"dosetgmaxfattcorr", tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosetgmaxfattcorr"))
		end if
		if tab_1.tabpage_1.dw_1.getitemstring(1,"dosetgmintcalc") > " " then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"dosetgmintcalc", tab_1.tabpage_1.dw_1.getitemstring(1,"g3_dosetgmintcalc"))
		end if
		if tab_1.tabpage_1.dw_1.getitemstring(1,"dosetgmaxtcalc") > " " then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"dosetgmaxtcalc", tab_1.tabpage_1.dw_1.getitemstring(1,"g3_dosetgmaxtcalc"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"dosetgminfattcorr_max") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"dosetgminfattcorr_max", tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosetgminfattcorr_max"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"dosetgmaxfattcorr_max") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"dosetgmaxfattcorr_max", tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_dosetgmaxfattcorr_max"))
		end if
		if tab_1.tabpage_1.dw_1.getitemstring(1,"dosetgmintcalc_max") > " " then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"dosetgmintcalc_max", tab_1.tabpage_1.dw_1.getitemstring(1,"g3_dosetgmintcalc_max"))
		end if
		if tab_1.tabpage_1.dw_1.getitemstring(1,"dosetgmaxtcalc_max") > " " then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"dosetgmaxtcalc_max", tab_1.tabpage_1.dw_1.getitemstring(1,"g3_dosetgmaxtcalc_max"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"unitwork") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"unitwork", tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_unitwork"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"savedosimeter") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"savedosimeter", tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_savedosimeter"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"densita") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"densita", tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_densita"))
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(1,"densitamax") > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"densitamax", tab_1.tabpage_1.dw_1.getitemnumber(1,"g3_densitamax"))
		end if
		if tab_1.tabpage_1.dw_1.getitemstring(1,"notecliente") > " " then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"notecliente", tab_1.tabpage_1.dw_1.getitemstring(1,"g3_notecliente"))
		end if
		if tab_1.tabpage_1.dw_1.getitemstring(1,"note_descr") > " " then
		else
			tab_1.tabpage_1.dw_1.setitem(1,"note_descr", tab_1.tabpage_1.dw_1.getitemstring(1,"g3_note_descr"))
		end if

	attiva_tasti()
	
end subroutine

protected subroutine inizializza_7 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 8 controllandone i valori se gia' presenti
//======================================================================
//
string k_codice


	if tab_1.tabpage_1.dw_1.rowcount() > 0 then

		if tab_1.tabpage_8.dw_8.rowcount() > 0 then
			k_codice = trim(tab_1.tabpage_8.dw_8.getitemstring(1, "cod_sl_pt"))
		end if
	
//--- se codice cambiato lo devo rileggere
		if k_codice <> trim(tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt")) then
			
			k_codice = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt"))
			if tab_1.tabpage_8.dw_8.retrieve(k_codice) < 0 then
				kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Lettura elenco Lotti per il PT codice=" + k_codice)	
				kguo_exception.messaggio_utente()
			end if

		end if
	
		tab_1.tabpage_8.dw_8.setfocus()
		
	end if
	



end subroutine

on w_sl_pt.create
int iCurrent
call super::create
end on

on w_sl_pt.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_sl_pt_g3) then destroy kiuf_sl_pt_g3
if isvalid(kiuf_sl_pt) then destroy kiuf_sl_pt

end event

type dw_print_0 from w_g_tab_3`dw_print_0 within w_sl_pt
end type

type st_ritorna from w_g_tab_3`st_ritorna within w_sl_pt
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_sl_pt
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_sl_pt
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_sl_pt
integer x = 2711
integer y = 1424
end type

type st_stampa from w_g_tab_3`st_stampa within w_sl_pt
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_sl_pt
integer x = 1152
integer y = 1440
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_sl_pt
integer x = 768
integer y = 1440
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_sl_pt
integer x = 1970
integer y = 1424
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_sl_pt
integer x = 2341
integer y = 1424
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_sl_pt
integer x = 1600
integer y = 1424
boolean enabled = false
end type

event cb_inserisci::clicked;//
//=== 
string k_errore="0"

//=== Nuovo Rekord
	choose case tab_1.selectedtab 
		case  1, 3 
	
			k_errore = LeftA(dati_modif(parent.title), 1)

//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
			if k_errore = "1" then //Fare gli aggiornamenti

//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
//===	              : 2=Errore Non grave dati aggiornati
//===               : 3=
				k_errore = aggiorna_dati()		

			else

				if k_errore = "2" then //Aggiornamento non richiesto
					k_errore = "0"
				end if

			end if
			
	end choose
	
	if LeftA(k_errore, 1) = "0" then 
		inserisci()
	end if

end event

type tab_1 from w_g_tab_3`tab_1 within w_sl_pt
integer x = 0
integer y = 4
integer width = 3227
end type

on tab_1.create
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9}
end on

on tab_1.destroy
call super::destroy
end on

event tab_1::u_constructor;//
							// 1     2     3     4     5     6     7     8     9   
ki_tabpage_enabled = {true, true, true, true, true, true, true, true, false} // disabilita alcune tabpage
super::event u_constructor( )

end event

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 3191
long backcolor = 32238571
string text = "Testata"
long tabbackcolor = 32435950
long picturemaskcolor = 31646434
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer y = 28
integer width = 2967
integer height = 1244
string dataobject = "d_sl_pt"
boolean hsplitscroll = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_1::itemchanged;call super::itemchanged;//
string k_codice, k_descr
int k_errore=0
long k_riga
st_tab_clienti kst_tab_clienti
datawindowchild kdwc_1


choose case dwo.name 
		
	case "cod_sl_pt" 
	   k_codice = upper(trim(data))
		if trim(k_codice) > " " then
			k_errore = check_rek( k_codice ) 
		end if

	case "rag_soc_10" 
		this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.BIANCO) + "' ") 
		if len(trim(data)) > 0 then 
			this.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "rag_soc_1 like '" + trim(data) + "%" +"'" , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = kdwc_1.getitemnumber( k_riga, "id_cliente")
				if if_anag_attiva(kst_tab_clienti) then
					u_get_dati_cliente(kst_tab_clienti)
					post u_put_video_cliente(kst_tab_clienti)
				else
					this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				end if
			else
				this.object.id_cliente[1] = 0
				this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
			end if
		else
			kst_tab_clienti.codice = 0
			kst_tab_clienti.rag_soc_10 = ""
			post u_put_video_cliente(kst_tab_clienti)
		end if

	case "id_cliente" 
		this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.BIANCO) + "' ") 
		if trim(data) > "0" then 
			this.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "id_cliente = " + trim(data) + " " , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = long(trim(data))
				if if_anag_attiva(kst_tab_clienti) then
					u_get_dati_cliente(kst_tab_clienti)
					post u_put_video_cliente(kst_tab_clienti)
				else
					this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				end if
			else
				this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
			end if
		else
			kst_tab_clienti.codice = 0
			kst_tab_clienti.rag_soc_10 = ""
			post u_put_video_cliente(kst_tab_clienti)
		end if


end choose 

if k_errore = 1 then
	return 2
end if
	
end event

event dw_1::clicked;//

choose case dwo.name 
	case "b_trattamento_effettivo" 
		trattamento_proposta_sposta()
		
	case "b_reset_proposta"
		trattamento_proposta_reset( )
		
	case "p_img_dosimesempio"
		u_open_esempio_st_dosim( )

	case "b_packingformin_file" 
	   if (ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica) then
			u_get_path_packingformin_file()
		end if
		
	case "p_img_packingformin_file_vedi" 
		u_open_packingformin_file()
				
	case "b_sl_pt_dosimpos" &
		 ,"b_sl_pt_dosimpos_g3" 
		tab_1.selecttab(2)
		
	case "b_sl_pt_g3" 
		tab_1.selecttab(4)
		
	case "b_copia_da_g2"
	   if (ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica) then
			u_copy_g2_to_g3( )
		end if		
	case "b_copia_da_g3"
	   if (ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica) then
			u_copy_g3_to_g2( )
		end if		
		
	case else
		super::event clicked(xpos, ypos, row, dwo)
		
end choose
	

end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 3191
long backcolor = 16777215
string text = "Posizioni Dosimetri"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer width = 2981
integer height = 1228
boolean enabled = true
string dataobject = "d_sl_pt_dosimpos_1"
end type

event dw_2::itemchanged;call super::itemchanged;//
string k_x
long k_riga, k_n
datawindowchild kdwc_1


choose case dwo.name

	case "dosimpos_codice" 
		if trim(data) > " " then 
			
			if len(trim(data)) = 1 and isnumber(trim(data)) then
				data = "0" + trim(data)  //normalizza, ad es.  '1' diventa '01'
			end if
			
			this.getchild(dwo.name, kdwc_1)
			
			k_riga = kdwc_1.find("dosimpos_codice = '" + trim(data) + "'", 0, kdwc_1.rowcount())
			
			if trim(data) = kdwc_1.getitemstring(kdwc_1.getrow(), "codice") then
				k_riga = kdwc_1.getrow()  //priorità alla riga scelta nel DDW
			end if
			
			if k_riga > 0 then
				k_n = kdwc_1.getitemnumber(k_riga, "id_dosimpos")
				if k_n > 0 then
					this.setitem( row, "id_dosimpos", k_n)
				end if

//				if trim(this.getitemstring( row, "descr")) > " " then
//				if trim(this.object.descr.original[row]) > " " then
//				else
					k_x = kdwc_1.getitemstring(kdwc_1.getrow(), "descr")
					if trim(k_x) > " " then
						this.setitem( row, "descr", k_x)
					else
						this.setitem( row, "descr", "")
					end if
//				end if
//				if trim(this.getitemstring( row, "descr1")) > " " then
//				if trim(this.object.descr1.original[row]) > " " then
//				else
					k_x = kdwc_1.getitemstring(kdwc_1.getrow(), "descr1")
					if trim(k_x) > " " then
						this.setitem( row, "descr1", k_x)
					else
						this.setitem( row, "descr1", "")
					end if
//				end if
			end if
		end if
		
		if k_riga > 0 then
		else
			this.setitem( row, "id_dosimpos", 0)
		end if

end choose
end event

event dw_2::buttonclicked;call super::buttonclicked;//
if dwo.name = "b_delete" then
	this.deleterow(row)
	attiva_tasti()
end if
	

end event

event dw_2::getfocus;call super::getfocus;//
tab_1.tabpage_1.dw_1.accepttext( )

end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer width = 3191
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
integer y = 44
integer width = 2967
integer height = 1232
boolean ki_link_standard_sempre_possibile = true
end type

event dw_3::doubleclicked;call super::doubleclicked;//
// disattiva evento
end event

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean visible = true
integer width = 3191
boolean enabled = true
string text = "Impianto G3"
ln_1 ln_1
end type

on tabpage_4.create
this.ln_1=create ln_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ln_1
end on

on tabpage_4.destroy
call super::destroy
destroy(this.ln_1)
end on

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
boolean visible = true
integer y = 16
integer width = 2939
integer height = 1116
integer taborder = 10
boolean enabled = true
string dataobject = "d_sl_pt_g3_lav_l"
boolean ki_select_multirows = false
end type

event dw_4::itemchanged;call super::itemchanged;//
string k_codice


if dwo.name = "g3status" then
	
	if trim(data) = "5" then  // Se passo a AUTORIZZATO...
		
		if this.getitemnumber( row, "g3npass") > 0 &
			and this.getitemnumber( row, "ciclo_target") > 0 & 
			and this.getitemnumber( row, "ciclo_min") > 0 & 
			and this.getitemnumber( row, "ciclo_max") > 0 & 
			and this.getitemnumber( row, "ciclo_max") >= this.getitemnumber( row, "ciclo_min") & 
			and this.getitemnumber( row, "ciclo_target") >= this.getitemnumber( row, "ciclo_min") & 
			and this.getitemnumber( row, "ciclo_target") <= this.getitemnumber( row, "ciclo_max") & 
			then
		else
			
			messagebox("Autorizzazione Respinta", "Attenzione verificare i dati N. Pass e del Cicli impostati, devono essere tutti indicati e il Cilco Minimo non maggiore al Massimo e il Target compreso tra il Minimo e il Massimo.", stopsign!) 
			
			this.post setitem(row, "g3status", 0)
			//return 2  // Reject
			
		end if
	
	end if
	
end if
	
end event

event dw_4::buttonclicked;call super::buttonclicked;//
string k_msg

if dwo.name = "b_delete" then
	if this.getitemnumber(row, "id_sl_pt_g3") > 0 then
		try
			if not kiuf_sl_pt_g3.if_delete(this.getitemnumber(row, "id_sl_pt_g3"), k_msg) then
				messagebox("Cancellazione bloccata", k_msg, stopsign!)
				return 0
			end if
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
			return 0
		end try
	end if
	this.deleterow(row)
	attiva_tasti()
end if
	

end event

event dw_4::getfocus;call super::getfocus;//
tab_1.tabpage_1.dw_1.accepttext( )

end event

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
boolean visible = true
integer width = 3191
boolean enabled = true
string text = "Disp.Ausiliari"
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
boolean visible = true
integer width = 2935
integer height = 1172
boolean enabled = true
string dataobject = "d_asddevice_l_x_cod_sl_pt"
end type

event dw_5::doubleclicked;call super::doubleclicked;//
// disattiva evento
end event

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 3191
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
boolean visible = true
integer width = 3191
boolean enabled = true
string text = "Listini"
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
boolean visible = true
boolean enabled = true
string dataobject = "d_clienti_listino_sl_pt"
end type

event dw_7::rowfocuschanged;call super::rowfocuschanged;////
//This.SelectRow(0, FALSE)
//this.SelectRow(currentrow, TRUE)
//
end event

event dw_7::ue_dwnkey;//

end event

event dw_7::getfocus;call super::getfocus;//getfocus
if This.getSelectedRow(0) <= 0 then
	This.SelectRow(1, TRUE)
end if
//

end event

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
boolean visible = true
integer width = 3191
boolean enabled = true
string text = "Movimenti"
string powertiptext = "Elenco lotti"
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
boolean visible = true
boolean enabled = true
string dataobject = "d_sl_pt_meca_l"
boolean ki_link_standard_sempre_possibile = true
boolean ki_attiva_dragdrop_solo_ins_mod = false
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3191
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type st_duplica from w_g_tab_3`st_duplica within w_sl_pt
end type

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

