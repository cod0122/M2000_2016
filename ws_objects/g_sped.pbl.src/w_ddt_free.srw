﻿$PBExportHeader$w_ddt_free.srw
forward
global type w_ddt_free from w_g_tab_3
end type
type dw_periodo from uo_dw_periodo within w_ddt_free
end type
end forward

global type w_ddt_free from w_g_tab_3
integer x = 169
integer y = 148
integer width = 3447
integer height = 2000
string title = "DDT"
windowanimationstyle closeanimation = topslide!
boolean ki_toolbar_window_presente = true
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_attiva_tasti_vmi = true
boolean ki_consenti_duplica = true
dw_periodo dw_periodo
end type
global w_ddt_free w_ddt_free

type variables
//
private kuf_sped_free kiuf_sped_free
private st_tab_sped_free kist_tab_sped_free, kist_tab_sped_free_orig

protected kuf_clienti kiuf_clienti

private string ki_win_titolo_orig_save

private boolean ki_updated=true
private long ki_list_id_selected
end variables

forward prototypes
private subroutine pulizia_righe ()
protected function string aggiorna ()
protected function integer cancella ()
protected function string check_dati ()
private subroutine riempi_id ()
protected function string inizializza ()
protected function integer inserisci ()
protected subroutine open_start_window ()
private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti)
public subroutine set_iniz_dati_cliente (ref st_tab_clienti kst_tab_clienti)
public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti)
protected subroutine leggi_liste ()
public function boolean u_duplica () throws uo_exception
public function st_tab_sped_free u_set_st_tab_from_dw () throws uo_exception
public subroutine u_calcola_colli ()
protected subroutine inizializza_1 () throws uo_exception
protected subroutine attiva_menu ()
protected subroutine attiva_tasti_0 ()
protected function string dati_modif (string k_titolo)
public function boolean stampa_ddt ()
protected function integer visualizza ()
protected subroutine modifica ()
public subroutine smista_funz (string k_par_in)
private subroutine cambia_periodo_elenco ()
end prototypes

private subroutine pulizia_righe ();//
tab_1.tabpage_2.dw_2.accepttext()

//if tab_1.tabpage_2.dw_2.rowcount( ) > 0 then
//	if tab_1.tabpage_2.dw_2.getitemnumber(1, "id_cliente") > 0 then
//	else
//		tab_1.tabpage_2.dw_2.reset( )
//	end if
//end if

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
st_tab_sped_free kst_tab_sped_free


choose case tab_1.selectedtab 

	case 2

		//=== Aggiorna, se modificato, la TAB_1/2	
		if tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 then
		
			try 
				kst_tab_sped_free = u_set_st_tab_from_dw( )   // popola st contratti
				kst_tab_sped_free.id_sped_free = tab_1.tabpage_2.dw_2.getitemnumber(1, "id_sped_free")
				kst_tab_sped_free.st_tab_g_0.esegui_commit = "S"
				//--- aggiorna
				if kst_tab_sped_free.id_sped_free > 0 then
					kiuf_sped_free.tb_update(kst_tab_sped_free)
				else
				//--- nuovo
					kiuf_sped_free.tb_insert(kst_tab_sped_free)
					tab_1.tabpage_2.dw_2.setitem(1, "id_sped_free", kst_tab_sped_free.id_sped_free)
				end if

				tab_1.tabpage_2.dw_2.resetupdate( )
				k_return ="0 "
				
//--- aggiorna su Proprietà il n.ddt				
				kst_tab_sped_free.num_bolla_out = tab_1.tabpage_2.dw_2.getitemstring(1, "sped_free_num_bolla_out")
				kst_tab_sped_free.data_bolla_out = tab_1.tabpage_2.dw_2.getitemdate(1, "sped_free_data_bolla_out")
				kiuf_sped_free.set_num_bolla_out_in_base(kst_tab_sped_free)
				
				//proteggi_campi()
				
				ki_updated = true // aggiornato x rifare poi l'elenco
				
				//inizializza( )  // torna sull'elenco
				
				ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
				tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.modifica
				
			catch (uo_exception kuo_exception)
				k_return="1Fallito aggiornamento in archivio '" &
							+ tab_1.tabpage_1.text + "' ~n~r" &
							+ kguo_exception.get_errtext( )
				messagebox("Aggiornamento non eseguito", mid(k_return,2), stopsign!)
			finally
				
			end try
		end if

end choose



return k_return

end function

protected function integer cancella ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
long k_riga
st_tab_clienti kst_tab_clienti
st_tab_sped_free kst_tab_sped_free
st_esito kst_esito



//=== 
choose case tab_1.selectedtab 
	case 1 

		//=== Controllo se sul dettaglio c'e' qualche cosa
		k_riga = tab_1.tabpage_1.dw_1.getselectedrow(0)
		if k_riga > 0 then
			kst_tab_sped_free.id_sped_free = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_sped_free")
			kst_tab_sped_free.num_bolla_out = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "sped_free_num_bolla_out")
			kst_tab_sped_free.data_bolla_out = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "sped_free_data_bolla_out")
		end if
		
		if k_riga > 0 and kst_tab_sped_free.id_sped_free > 0 then	
			if kst_tab_sped_free.num_bolla_out > " " then
			else
				kst_tab_sped_free.num_bolla_out = "*** DDT senza numero ***" 
			end if
			
		//=== Richiesta di conferma della eliminazione del rek
		
			if messagebox("Elimina DDT", "Sei sicuro di voler Cancellare : ~n~r" + &
						string(kst_tab_sped_free.id_sped_free, "####0") + " n. " + trim(kst_tab_sped_free.num_bolla_out) &
						+ " del " + string(kst_tab_sped_free.data_bolla_out, "dd mmm yyyy"), &
						question!, yesno!, 2) = 1 then
		 
			
		//=== Cancella 
				try
					kst_tab_sped_free.st_tab_g_0.esegui_commit = "S"
					kiuf_sped_free.tb_delete( kst_tab_sped_free ) 
				
					tab_1.tabpage_1.dw_1.deleterow(k_riga)

				catch (uo_exception kuo_exception)
					kst_esito = kuo_exception.get_st_esito()

					messagebox("Errore in Cancellazione" &
								,"Controllare i dati.~n~r" + trim(kst_esito.sqlerrtext) &
								,stopsign!)
					k_return = 1		
					tab_1.tabpage_1.dw_1.setfocus()
				end try
		
			else
				k_return = 1
				messagebox("Elimina DDT", "Operazione Annullata !!")
			end if
		
			tab_1.tabpage_2.dw_2.setcolumn(1)
		else
			messagebox("Elimina DDT", "Selezionare una riga dall'elenco")
		end if


	case 3 

end choose	


choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_2.dw_2.setfocus()
		tab_1.tabpage_2.dw_2.setcolumn(1)
//	case 3
//		tab_1.tabpage_3.dw_3.setfocus()
//		tab_1.tabpage_3.dw_3.setcolumn(1)
end choose	


		
attiva_tasti()


return k_return

end function

protected function string check_dati ();//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK ma errore non grave
//===                : 5=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
//
string k_return 
int k_errori = 0
int k_anno
string k_errore
st_esito kst_esito
st_tab_sped_free kst_tab_sped_free, kst1_tab_sped_free


try
	kst_esito = kguo_exception.inizializza(this.classname())

//--- inserimento: verifica il numero ordine e l'anno 
	if tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.inserimento then
		kst_tab_sped_free.data_bolla_out = tab_1.tabpage_2.dw_2.getitemdate(1, "sped_free_data_bolla_out")
		kst_tab_sped_free.num_bolla_out = tab_1.tabpage_2.dw_2.getitemstring(1, "sped_free_num_bolla_out")
		if isnumber(kst_tab_sped_free.num_bolla_out) then
			k_anno = kiuf_sped_free.get_num_bolla_out_next(kst1_tab_sped_free)
			if k_anno = year(kst_tab_sped_free.data_bolla_out) and k_anno > 0 and kst1_tab_sped_free.num_bolla_out > " " then
				if trim(kst_tab_sped_free.num_bolla_out) <> trim(kst1_tab_sped_free.num_bolla_out) then
					tab_1.tabpage_2.dw_2.setitem(1, "sped_free_num_bolla_out", kst1_tab_sped_free.num_bolla_out)
					k_errori ++
					kst_esito.esito = kkg_esito.DATI_WRN 
					kst_esito.sqlerrtext = "Il numero indicato '" + trim(kst_tab_sped_free.num_bolla_out) &
								+ "' è stato ricoperto dal '" + trim(kst1_tab_sped_free.num_bolla_out) + "' quello proposto in automatico. " &
								+ "Prego verificare la correttezza."  
								//+ trim(tab_1.tabpage_2.dw_2.object.descr_t.text) +  "~n~r"  
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
			end if
		end if
	end if
	
	
catch (uo_exception kuo_exception)
	//throw kuo_exception
	kuo_exception.messaggio_utente()

	
finally
	choose case kst_esito.esito
		case kkg_esito.OK
			k_errore = "0"
		case kkg_esito.ERR_LOGICO
			k_errore = "1"
		case kkg_esito.err_formale
			k_errore = "2"
		case kkg_esito.DATI_INSUFF
			k_errore = "3"
		case kkg_esito.DB_WRN
			k_errore = "4"
		case kkg_esito.DATI_WRN
			k_errore = "5"
		case else
			k_errore = "1"
	end choose

	k_return = trim(kst_esito.sqlerrtext)
//--- Attenzione se ho interesse di conoscere i campi in errore scorrere i TAG di ciascun campo nel DATASTORE dove c'e' il tipo di errore riscontrato 	
	
end try


return k_errore + k_return


end function

private subroutine riempi_id ();//
//
long k_ctr = 0
st_tab_sped_free kst_tab_sped_free



	k_ctr = tab_1.tabpage_2.dw_2.getrow()
	
	if k_ctr > 0 then
	
		kst_tab_sped_free.id_sped_free = tab_1.tabpage_2.dw_2.getitemnumber(k_ctr, "id_sped_free")
	
////=== Se non sono in caricamento allora prelevo l'ID dalla dw
//		if tab_1.tabpage_2.dw_2.getitemstatus(k_ctr, 0, primary!) <> newmodified! then
//			kst_tab_sped_free.id_sped_free = tab_1.tabpage_2.dw_2.getitemnumber(k_ctr, "id_sped")
//		end if
	
		if isnull(kst_tab_sped_free.id_sped_free) or kst_tab_sped_free.id_sped_free = 0 then				
			tab_1.tabpage_2.dw_2.setitem(k_ctr, "id_sped_free", 0)
		end if
		
	end if


end subroutine

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
string k_ricevente
int k_importa = 0, k_righe
st_tab_sped_free kst_tab_sped_free
kuf_listino kuf1_listino


	SetPointer(kkg.pointer_attesa)
	
	tab_1.tabpage_1.dw_1.ki_flag_modalita = kkg_flag_modalita.visualizzazione
	ki_st_open_w.flag_modalita = tab_1.tabpage_1.dw_1.ki_flag_modalita
	
	if ki_updated or tab_1.tabpage_1.dw_1.rowcount( ) = 0 then
		ki_updated = false
		
		if len(trim(ki_st_open_w.key1)) > 0 then 
			k_ricevente = "Ricevente codice " + trim(ki_st_open_w.key1)
			kst_tab_sped_free.clie_2 = long(trim(ki_st_open_w.key1))
		else
			k_ricevente = ""
			kst_tab_sped_free.clie_2 = 0
		end if

		k_righe = tab_1.tabpage_1.dw_1.retrieve(dw_periodo.ki_data_ini, dw_periodo.ki_data_fin, kst_tab_sped_free.clie_2)
		if k_righe < 1 then
			k_return = "1Nessuna Spedizione per il periodo: " + string(dw_periodo.ki_data_ini, "dd mmm yy") + " - " + string(dw_periodo.ki_data_fin, "dd mmm yy") + " " + k_ricevente
	
			SetPointer(kkg.pointer_default)
			messagebox("Elenco ddt", &
					"Nessuna Spedizione per il periodo: " + string(dw_periodo.ki_data_ini, "dd mmm yy") + " - " + string(dw_periodo.ki_data_fin, "dd mmm yy") + " " + k_ricevente)
		else
			
			tab_1.tabpage_1.dw_1.event u_set_selected_row()
			
		end if		
	end if		

	tab_1.selecttab(1)
	
	attiva_tasti()
	tab_1.tabpage_2.event u_set_tab_title()
	
	SetPointer(kkg.pointer_default)

return k_return


end function

protected function integer inserisci ();//
int k_return=1, k_anno
long k_riga


try 
//=== Aggiunge una riga al data windows
	choose case tab_1.selectedtab 
		case  1, 2 

//--- legge tiutte le DWC			
			leggi_liste()			
			
			k_riga = 1
			if tab_1.tabpage_2.dw_2.rowcount() > 0 then
				
				kist_tab_sped_free.data_bolla_out = tab_1.tabpage_2.dw_2.getitemdate(k_riga, "sped_free_data_bolla_out")
				kist_tab_sped_free.aspetto = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "aspetto")
				kist_tab_sped_free.porto = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "porto")
				
				tab_1.tabpage_2.dw_2.reset() 
			else
				kist_tab_sped_free.data_bolla_out = kguo_g.get_dataoggi( )
			end if
			
			tab_1.tabpage_2.dw_2.insertrow(0)
			tab_1.tabpage_2.enabled = true
			
			//tab_1.tabpage_2.dw_2.setcolumn("oggetto")
			
			tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.inserimento
			ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento

			k_anno = kiuf_sped_free.get_num_bolla_out_next(kist_tab_sped_free)
			if kist_tab_sped_free.num_bolla_out > " " then
				if k_anno = year(kist_tab_sped_free.data_bolla_out) then
					tab_1.tabpage_2.dw_2.setitem(1, "sped_free_num_bolla_out", kist_tab_sped_free.num_bolla_out)
				else
					tab_1.tabpage_2.dw_2.setitem(1, "sped_free_num_bolla_out", "")
					messagebox("DDT Libero", "Anno '" + string(k_anno) + "' indicato in 'Proprietà Azienda' " &
									+ "non coincide con l'anno del DDT '" + string(year(kist_tab_sped_free.data_bolla_out)) + "', " &
									+ "impossibile recuperare il nuovo numero del DDT in automatico.", information!)
				end if
			end if
			tab_1.tabpage_2.dw_2.setitem(1, "sped_free_data_bolla_out", kist_tab_sped_free.data_bolla_out)
			tab_1.tabpage_2.dw_2.setitem(1, "aspetto", kist_tab_sped_free.aspetto)
			tab_1.tabpage_2.dw_2.setitem(1, "porto", kist_tab_sped_free.porto)

//--- S-protezione campi per abilitare l'inserimento
			tab_1.tabpage_2.dw_2.u_proteggi_sproteggi_dw()
		
			tab_1.tabpage_2.dw_2.event u_init_display_form( )
			tab_1.tabpage_2.event u_set_tab_title()
			
			tab_1.tabpage_2.dw_2.SetItemStatus( 1, 0, Primary!, NotModified!)

	end choose	

//	attiva_tasti()

	k_return = 0

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return (k_return)



end function

protected subroutine open_start_window ();//
int k_rc


	kiuf_sped_free = create kuf_sped_free
//	kiuf_clienti = create kuf_clienti

//--- Acquisisce i dati da passati in Argomento
	if LenA(trim(ki_st_open_w.key1)) = 0 then
		kist_tab_sped_free.id_sped_free = 0
	else
		kist_tab_sped_free.id_sped_free = long(trim(ki_st_open_w.key1))
	end if

	ki_win_titolo_orig_save = trim(tab_1.tabpage_1.dw_1.title)

	tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.inserimento

//--- Argomenti:  KEY2= Data Inizio -   KEY3 = Data Fine 
	if trim(ki_st_open_w.key2) > " " then
		if isdate(trim(ki_st_open_w.key2)) then
			dw_periodo.ki_data_ini = date(trim(ki_st_open_w.key2))
		else
			dw_periodo.ki_data_ini = relativedate(kg_dataoggi, -180)
		end if
	else
		dw_periodo.ki_data_ini = relativedate(kg_dataoggi, -180)
	end if
	if trim(ki_st_open_w.key3) > " " then
		if isdate(trim(ki_st_open_w.key3)) then
			dw_periodo.ki_data_fin = date(trim(ki_st_open_w.key3))
		else
			dw_periodo.ki_data_fin = date(year(kg_dataoggi), 12, 31)
		end if
	else
		dw_periodo.ki_data_fin = date(year(kg_dataoggi), 12, 31)
	end if
	
	dw_periodo.kiw_parent = this

end subroutine

private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente 
//
long k_riga=0
st_esito kst_esito
datawindowchild kdwc_1


//tab_1.tabpage_2.dw_2.modify( "id_cliente.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
//tab_1.tabpage_2.dw_2.modify( "clienti_rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
////tab_1.tabpage_2.dw_2.modify( "p_iva.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
////tab_1.tabpage_2.dw_2.modify( "cf.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
//tab_1.tabpage_2.dw_2.modify( "id_nazione.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
//tab_1.tabpage_2.dw_2.setitem( 1, "clienti_id_nazione_1", kst_tab_clienti.id_nazione_1 )
//
//tab_1.tabpage_2.dw_2.setitem( 1, "id_cliente", kst_tab_clienti.codice)
//tab_1.tabpage_2.dw_2.setitem( 1, "clienti_rag_soc_10", kst_tab_clienti.rag_soc_10 )
////tab_1.tabpage_2.dw_2.setitem( 1, "p_iva", trim(kst_tab_clienti.p_iva) )
////tab_1.tabpage_2.dw_2.setitem( 1, "cf", trim(kst_tab_clienti.cf) )
//tab_1.tabpage_2.dw_2.setitem( 1, "clienti_loc_1", kst_tab_clienti.loc_1 )
//tab_1.tabpage_2.dw_2.setitem( 1, "clienti_prov_1", trim(kst_tab_clienti.prov_1) )
//tab_1.tabpage_2.dw_2.setitem( 1, "clienti_id_nazione_1", kst_tab_clienti.id_nazione_1 )
//
//tab_1.tabpage_2.dw_2.setitem( 1, "iva", kst_tab_clienti.iva )
//tab_1.tabpage_2.dw_2.getchild( "iva", kdwc_1)
//k_riga = kdwc_1.find("codice="+trim(string(kst_tab_clienti.iva)),0,kdwc_1.rowcount())
//if k_riga > 0 then
//	tab_1.tabpage_2.dw_2.setitem(1, "iva_aliq", kdwc_1.getitemnumber(k_riga,"aliq") )
//	tab_1.tabpage_2.dw_2.setitem(1, "iva_des", kdwc_1.getitemstring(k_riga,"des") )
//end if
//
//tab_1.tabpage_2.dw_2.setitem( 1, "cod_pag", kst_tab_clienti.cod_pag )
//tab_1.tabpage_2.dw_2.getchild( "cod_pag", kdwc_1)
//k_riga = kdwc_1.find("codice="+trim(string(kst_tab_clienti.cod_pag)),0,kdwc_1.rowcount())
//if k_riga > 0 then
//	tab_1.tabpage_2.dw_2.setitem(1, "pagam_des", kdwc_1.getitemstring(k_riga,"des") )
//end if
//tab_1.tabpage_2.dw_2.setitem( 1, "banca", kst_tab_clienti.banca )
//tab_1.tabpage_2.dw_2.setitem( 1, "abi", kst_tab_clienti.abi )
//tab_1.tabpage_2.dw_2.setitem( 1, "cab", kst_tab_clienti.cab )

end subroutine

public subroutine set_iniz_dati_cliente (ref st_tab_clienti kst_tab_clienti);//			
kst_tab_clienti.codice = 0
kst_tab_clienti.rag_soc_10 = " "
kst_tab_clienti.p_iva = " "
kst_tab_clienti.cf = " "
kst_tab_clienti.id_nazione_1 = " "
kst_tab_clienti.cadenza_fattura = " "
kst_tab_clienti.loc_1 = " "
kst_tab_clienti.prov_1 = " "
kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c  = " "
kst_tab_clienti.kst_tab_ind_comm.rag_soc_2_c  = " "
kst_tab_clienti.kst_tab_ind_comm.indi_c  = " "
kst_tab_clienti.kst_tab_ind_comm.cap_c  = " "
kst_tab_clienti.kst_tab_ind_comm.loc_c  = " "
kst_tab_clienti.kst_tab_ind_comm.prov_c  = " "
kst_tab_clienti.kst_tab_clienti_fatt.fattura_da  = " "
kst_tab_clienti.iva  = 0
kst_tab_clienti.kst_tab_clienti_fatt.note_1 = " "
kst_tab_clienti.kst_tab_clienti_fatt.note_2 = " "

end subroutine

public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti);//
boolean k_return = false
st_esito kst_esito
kuf_clienti kuf1_clienti


try
	
//	kuf1_clienti = create kuf_clienti

	k_return = kiuf_clienti.leggi (kst_tab_clienti)

	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	

finally
//	destroy kuf1_clienti
	
end try

return k_return


end function

protected subroutine leggi_liste ();////
//int k_rc
//datawindowchild  kdwc_clienti_des, kdwc_clienti, kdwc_clie_settori, kdwc_gru, kdwc_clie_tipo, kdwc_iva, kdwc_pag, kdwc_oggetto, kdwc_fattura_da, kdwc_1, kdwc_2
//
////--- Attivo dw archivio Clienti
//	k_rc = tab_1.tabpage_2.dw_2.getchild("id_cliente", kdwc_clienti)
//	k_rc = kdwc_clienti.settransobject(sqlca)
//	k_rc = kdwc_clienti.retrieve("%")
//	k_rc = kdwc_clienti.insertrow(1)
//	kdwc_clienti_des.setsort( "id_cliente asc")
//	kdwc_clienti_des.sort( )
//
//	k_rc = tab_1.tabpage_2.dw_2.getchild("clienti_rag_soc_10", kdwc_clienti_des)
//	k_rc = kdwc_clienti_des.settransobject(sqlca)
//
//	kdwc_clienti.RowsCopy(kdwc_clienti.GetRow(), kdwc_clienti.RowCount(), Primary!, kdwc_clienti_des, 1, Primary!)
//	kdwc_clienti_des.setsort( "rag_soc_1 asc")
//	kdwc_clienti_des.sort( )
//
////--- Attivo dw elenco Descrizioni  già usati
//	k_rc = tab_1.tabpage_2.dw_2.getchild("oggetto", kdwc_oggetto)
//	k_rc = kdwc_oggetto.settransobject(sqlca)
//	k_rc = kdwc_oggetto.retrieve()
//	k_rc = kdwc_oggetto.insertrow(1)
////--- 
//	k_rc = tab_1.tabpage_2.dw_2.getchild("fattura_da", kdwc_fattura_da)
//	k_rc = kdwc_fattura_da.settransobject(sqlca)
//	k_rc = kdwc_fattura_da.retrieve()
//	k_rc = kdwc_fattura_da.insertrow(1)
////--- Attivo dw archivio Clienti-contatti
////	k_rc = tab_1.tabpage_2.dw_2.getchild("nome_contatto", kdwc_clie_tipo)
////	k_rc = kdwc_clie_tipo.settransobject(sqlca)
////	k_rc = kdwc_clie_tipo.retrieve()
////	k_rc = kdwc_clie_tipo.insertrow(1)
////--- Attivo dw archivio Settori
//	k_rc = tab_1.tabpage_2.dw_2.getchild("id_clie_settore", kdwc_clie_settori)
//	k_rc = kdwc_clie_settori.settransobject(sqlca)
//	k_rc = kdwc_clie_settori.retrieve()
//	k_rc = kdwc_clie_settori.insertrow(1)
////--- Attivo dw archivio Gruppi
//	k_rc = tab_1.tabpage_2.dw_2.getchild("gruppo", kdwc_gru)
//	k_rc = kdwc_gru.settransobject(sqlca)
////--- piglio il codice del settore xchè la query va fatta con il codice
//	if tab_1.tabpage_2.dw_2.rowcount( ) > 0 then
//		kist_tab_contratti_doc.id_clie_settore = tab_1.tabpage_2.dw_2.getitemstring(1, "id_clie_settore")
//		if len(trim(kist_tab_contratti_doc.id_clie_settore)) > 0 then
//			k_rc = kdwc_gru.retrieve(kist_tab_contratti_doc.id_clie_settore)
//		else
//			kdwc_gru.reset()
//		end if
//	end if
//	k_rc = kdwc_gru.insertrow(1)
////--- Attivo dw archivio IVA
//	k_rc = tab_1.tabpage_2.dw_2.getchild("iva", kdwc_iva)
//	k_rc = kdwc_iva.settransobject(sqlca)
//	k_rc = kdwc_iva.retrieve()
//	k_rc = kdwc_iva.insertrow(1)
////--- Attivo dw archivio Pagamenti
//	k_rc = tab_1.tabpage_2.dw_2.getchild("cod_pag", kdwc_pag)
//	k_rc = kdwc_pag.settransobject(sqlca)
//	k_rc = kdwc_pag.retrieve()
//	k_rc = kdwc_pag.insertrow(1)
// 	k_rc = tab_1.tabpage_2.dw_2.getchild("acconto_cod_pag", kdwc_2)
//	k_rc = kdwc_pag.ShareData( kdwc_2)			
//
////--- Attivo dw archivio Gruppo-Prezzi
//	k_rc = tab_1.tabpage_2.dw_2.getchild("id_listino_pregruppo", kdwc_1)
//	k_rc = kdwc_1.settransobject(sqlca)
//	k_rc = kdwc_1.retrieve(0)
//	k_rc = kdwc_1.insertrow(1)
//
//
end subroutine

public function boolean u_duplica () throws uo_exception;//
//--- Duplica documento 
//
long k_id_sped_free
int k_row


try
	
	if tab_1.selectedtab = 1 then
		k_row = kguf_data_base.u_getlistselectedrow(tab_1.tabpage_1.dw_1)
		k_id_sped_free = tab_1.tabpage_1.dw_1.getitemnumber(k_row, "id_sped_free")
	else
		if tab_1.tabpage_2.dw_2.rowcount( ) > 0 then
			k_row = 1
			k_id_sped_free = tab_1.tabpage_2.dw_2.getitemnumber(k_row, "id_sped_free")
		end if
	end if
	
	if k_row > 0 then
		//=== Richiesta di conferma operazione
		if messagebox("Duplica DDT", "Genera il nuovo DDT copiando i dati da questo " &
					+ "id " + string(k_id_sped_free),  &
					question!, yesno!, 2) = 1 then
					
			ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
			tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.inserimento
			
			if tab_1.selectedtab = 1 then
				k_row = tab_1.tabpage_2.dw_2.retrieve(k_id_sped_free)
			end if
			
			tab_1.tabpage_2.dw_2.setitem(k_row, "sped_free_num_bolla_out", '')
			tab_1.tabpage_2.dw_2.setitem(k_row, "id_sped_free", 0)
			tab_1.tabpage_2.dw_2.resetupdate()
			
			tab_1.selecttab(2)
			
		end if	
	end if	
	
catch (uo_exception kuo_exception)
	
finally
	
end try

return true
end function

public function st_tab_sped_free u_set_st_tab_from_dw () throws uo_exception;//
int k_idx, k_rc, k_idx_max
st_tab_sped_free kst_tab_sped_free


kst_tab_sped_free.id_sped_free = tab_1.tabpage_2.dw_2.getitemnumber( 1, "id_sped_free")						

kst_tab_sped_free.data_bolla_out   	= tab_1.tabpage_2.dw_2.getitemdate( 1, "sped_free_data_bolla_out")
kst_tab_sped_free.num_bolla_out  	= tab_1.tabpage_2.dw_2.getitemstring( 1, "sped_free_num_bolla_out")
kst_tab_sped_free.causale   			= tab_1.tabpage_2.dw_2.getitemstring( 1, "causale")
kst_tab_sped_free.clie_2   			= tab_1.tabpage_2.dw_2.getitemnumber( 1, "clie_2")
kst_tab_sped_free.clie_3		   	= tab_1.tabpage_2.dw_2.getitemnumber( 1, "clie_3")


kst_tab_sped_free.stampa           = tab_1.tabpage_2.dw_2.getitemstring( 1, "stampa")
kst_tab_sped_free.form_di_stampa   = tab_1.tabpage_2.dw_2.getitemstring( 1, "form_di_stampa")
kst_tab_sped_free.aspetto          = tab_1.tabpage_2.dw_2.getitemstring( 1, "aspetto")   
kst_tab_sped_free.causale          = tab_1.tabpage_2.dw_2.getitemstring( 1, "causale") 
kst_tab_sped_free.colli            = tab_1.tabpage_2.dw_2.getitemstring( 1, "colli") 
kst_tab_sped_free.consegna         = tab_1.tabpage_2.dw_2.getitemstring( 1, "consegna") 
kst_tab_sped_free.data_ora_rit     = tab_1.tabpage_2.dw_2.getitemstring( 1, "data_ora_rit") 

k_idx_max = upperbound(kst_tab_sped_free.Indirizzo_riga[])
for k_idx = 1 to k_idx_max
	kst_tab_sped_free.Indirizzo_riga[k_idx] = tab_1.tabpage_2.dw_2.getitemstring( 1, "Indirizzo_riga_" + string(k_idx, "#"))
next
k_idx_max = upperbound(kst_tab_sped_free.descr[])
for k_idx = 1 to k_idx_max
	kst_tab_sped_free.descr[k_idx]  = tab_1.tabpage_2.dw_2.getitemstring( 1, "descr_" + string(k_idx, "#")) 
	kst_tab_sped_free.kgy[k_idx]    = tab_1.tabpage_2.dw_2.getitemstring( 1, "kgy_" + string(k_idx, "#")) 
	kst_tab_sped_free.qta[k_idx]    = tab_1.tabpage_2.dw_2.getitemstring( 1, "qta_" + string(k_idx, "#")) 
next
k_idx_max = upperbound(kst_tab_sped_free.note[])
for k_idx = 1 to k_idx_max
	kst_tab_sped_free.note[k_idx]           = tab_1.tabpage_2.dw_2.getitemstring( 1, "note_" + string(k_idx, "#")) 
next

kst_tab_sped_free.dicit_ind_intest = tab_1.tabpage_2.dw_2.getitemstring( 1, "dicit_ind_intest")   
kst_tab_sped_free.dicit_ind_sped   = tab_1.tabpage_2.dw_2.getitemstring( 1, "dicit_ind_sped") 
kst_tab_sped_free.intestazione     = tab_1.tabpage_2.dw_2.getitemstring( 1, "intestazione") 
k_idx_max = upperbound(kst_tab_sped_free.intestazione_ind[])
for k_idx = 1 to k_idx_max
	kst_tab_sped_free.intestazione_ind[k_idx] = tab_1.tabpage_2.dw_2.getitemstring( 1, "intestazione_ind" + string(k_idx, "#")) 
next
kst_tab_sped_free.peso_kg          = tab_1.tabpage_2.dw_2.getitemstring( 1, "peso_kg") 
kst_tab_sped_free.porto            = tab_1.tabpage_2.dw_2.getitemstring( 1, "porto") 
kst_tab_sped_free.sped_note        = tab_1.tabpage_2.dw_2.getitemstring( 1, "sped_note") 
kst_tab_sped_free.tipo_copia       = tab_1.tabpage_2.dw_2.getitemstring( 1, "tipo_copia") 
kst_tab_sped_free.trasporto        = tab_1.tabpage_2.dw_2.getitemstring( 1, "trasporto") 
kst_tab_sped_free.vett_1           = tab_1.tabpage_2.dw_2.getitemstring( 1, "vett_1")  
//kst_tab_sped_free.vett_2           = tab_1.tabpage_2.dw_2.getitemstring( 1, "vett_2") 
kst_tab_sped_free.resa             = tab_1.tabpage_2.dw_2.getitemstring( 1, "resa") 
kst_tab_sped_free.annotazioni      = tab_1.tabpage_2.dw_2.getitemstring( 1, "annotazioni") 

return kst_tab_sped_free
end function

public subroutine u_calcola_colli ();//
//--- calcola Importo riga 
//		
int k_idx, k_idx_max
int k_qta_sum
st_tab_sped_free kst_tab_sped_free


	if tab_1.tabpage_2.dw_2.rowcount( ) > 0 then
		
		k_idx_max = upperbound(kst_tab_sped_free.qta[])
		for k_idx = 1 to k_idx_max	
			kst_tab_sped_free.qta[k_idx] = trim(tab_1.tabpage_2.dw_2.getitemstring(1, "qta_" + string(k_idx, "#")))
			if IsNumber(kst_tab_sped_free.qta[k_idx]) then 
				k_qta_sum += integer(kst_tab_sped_free.qta[k_idx])
			end if
		next		
		
		if k_qta_sum > 0 then
			tab_1.tabpage_2.dw_2.setitem(1, "colli", string(k_qta_sum, "#"))
		end if
		
	end if
end subroutine

protected subroutine inizializza_1 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
int k_rc 
st_tab_sped_free kst_tab_sped_free
st_esito kst_esito
//kuf_utility kuf1_utility
uo_exception kuo_exception


	ki_st_open_w.flag_modalita = tab_1.tabpage_2.dw_2.ki_flag_modalita
 
	SetPointer(kkg.pointer_attesa)
	tab_1.tabpage_2.enabled = true
	tab_1.tabpage_2.dw_2.enabled = true

	if tab_1.tabpage_2.dw_2.ki_flag_modalita <> kkg_flag_modalita.inserimento then
		k_rc = tab_1.tabpage_2.dw_2.retrieve(kist_tab_sped_free.id_sped_free) 
		
		choose case k_rc
			case is < 0		
				SetPointer(kkg.pointer_default)
				kguo_exception.set_st_esito_err_dw(tab_1.tabpage_2.dw_2, &
							"Errore in lettura DDT libero id " + string(kist_tab_sped_free.id_sped_free))
				kguo_exception.post messaggio_utente( )	

			case 100
				SetPointer(kkg.pointer_default)
				kguo_exception.set_st_esito_err_dw(tab_1.tabpage_2.dw_2, &
							"Il DDT libero cercato non è in archivio, id " + string(kist_tab_sped_free.id_sped_free))
				kguo_exception.post messaggio_utente( )	

			case is > 0	
				kist_tab_sped_free_orig.id_sped_free = kist_tab_sped_free.id_sped_free
				kist_tab_sped_free_orig.num_bolla_out = tab_1.tabpage_2.dw_2.getitemstring(1, "sped_free_num_bolla_out")
				kist_tab_sped_free_orig.data_bolla_out = tab_1.tabpage_2.dw_2.getitemdate(1, "sped_free_data_bolla_out")
				kist_tab_sped_free.num_bolla_out = kist_tab_sped_free_orig.num_bolla_out
				kist_tab_sped_free.data_bolla_out = kist_tab_sped_free_orig.data_bolla_out
				
				tab_1.tabpage_2.dw_2.setfocus()
//				tab_1.tabpage_2.dw_2.setcolumn("fat1_note_1")
				tab_1.tabpage_2.dw_2.visible = true
				tab_1.tabpage_2.dw_2.SetItemStatus( 1, 0, Primary!, NotModified!)
				
		end choose
		
		tab_1.tabpage_2.dw_2.event u_init_display_form()  // sistema il form
		
	end if
	
	u_resize_1( )
	
	if tab_1.tabpage_2.dw_2.rowcount() = 0 then
		
		SetPointer(kkg.pointer_attesa)
	
		ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
		tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.inserimento
		
		inserisci()
		
	end if

	tab_1.tabpage_2.event u_set_tab_title()


	
end subroutine

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu


//
//--- Attiva/Dis. Voci di menu personalizzate
//
	m_main.m_strumenti.m_fin_gest_libero1.text = "Cambia il periodo di estrazione elenco ddt"
	m_main.m_strumenti.m_fin_gest_libero1.microhelp =  "Cambia il periodo di estrazione elenco ddt"
	m_main.m_strumenti.m_fin_gest_libero1.visible = true
	m_main.m_strumenti.m_fin_gest_libero1.enabled = true
	m_main.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Periodo,"+m_main.m_strumenti.m_fin_gest_libero1.text
	m_main.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Custom015!"
	m_main.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
	m_main.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true

	if not m_main.m_strumenti.m_fin_gest_libero5.visible then
		m_main.m_strumenti.m_fin_gest_libero5.text = "Stampa ddt selezionate"
		m_main.m_strumenti.m_fin_gest_libero5.microhelp =  "Stampa ddt selezionate"
		m_main.m_strumenti.m_fin_gest_libero5.visible = true
		m_main.m_strumenti.m_fin_gest_libero5.enabled = true
		m_main.m_strumenti.m_fin_gest_libero5.toolbaritemText = "Stampa,"+m_main.m_strumenti.m_fin_gest_libero5.text
		m_main.m_strumenti.m_fin_gest_libero5.toolbaritemName = "printa16.png"
		m_main.m_strumenti.m_fin_gest_libero5.toolbaritembarindex=2
		m_main.m_strumenti.m_fin_gest_libero5.toolbaritemVisible = true
	end if	
	
//---
	super::attiva_menu()



end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================


super::attiva_tasti_0()


//=== Nr righe ne DW lista
if tab_1.tabpage_1.dw_1.rowcount() > 0 then

	if tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_2") > 0 then
		tab_1.tabpage_4.enabled = true
	end if
	
	choose case ki_tab_1_index_new  //tab_1.selectedtab
		case 1
			st_aggiorna_lista.enabled = true
			st_ordina_lista.enabled = true
			cb_modifica.enabled = true
			cb_visualizza.enabled = true
			cb_cancella.enabled = true
			cb_inserisci.enabled = true
		case 2 //DETTAGLIO
			cb_cancella.enabled = false
	end choose

else
	
	cb_inserisci.enabled = true
	cb_inserisci.default = true
	
end if

//if ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione or ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then
//	cb_inserisci.enabled = false
//	cb_aggiorna.enabled = false
//	cb_cancella.enabled = false
//	cb_modifica.enabled = false
//end if





end subroutine

protected function string dati_modif (string k_titolo);//
//=== Controllo se ci sono state modifiche di dati sui DW
string k_return="0 "
//boolean k_return
int k_msg=0
int k_row


//=== Toglie le righe eventualmente da non registrare
//	pulizia_righe()
	
	if (tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0  & 
				or tab_1.tabpage_2.dw_2.deletedcount() > 0) then 

		if tab_1.tabpage_2.dw_2.rowcount( ) > 0  then
	
			k_msg = messagebox("Aggiorna DDT", "Dati Modificati, vuoi Salvare gli Aggiornamenti ?", &
								question!, yesnocancel!, 1) 
		
			if k_msg = 1 then
//				k_return = true
				k_return = "1Dati Modificati"	
			else
				k_return = string(k_msg)			
			end if
		end if
	end if


return k_return
end function

public function boolean stampa_ddt ();//
boolean k_return = false
string k_errore = "0"
int k_row, k_row_print
st_tab_sped_free kst_tab_sped_free[] 


try

	//--- Controllo se ho modificato dei dati nella DW DETTAGLIO
	if left(dati_modif(""), 1) = "1" then //Richisto Aggiornamento
	
	//=== Controllo congruenza dei dati caricati e Aggiornamento  
	//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
	//===                : 2=errore non grave dati aggiornati;
	//===			         : 3=LIBERO
	//===      il resto della stringa contiene la descrizione dell'errore   
		k_errore = aggiorna_dati()
	
	end if
	
	
	if left(k_errore, 1) = "0" then
		
//=== 
	choose case tab_1.selectedtab 
		case 1 
			k_row = tab_1.tabpage_1.dw_1.getselectedrow(0)
			do while k_row > 0
				k_row_print ++
				kst_tab_sped_free[k_row_print].id_sped_free = tab_1.tabpage_1.dw_1.getitemnumber(k_row, "id_sped_free")
				kst_tab_sped_free[k_row_print].num_bolla_out = tab_1.tabpage_1.dw_1.getitemstring(k_row, "sped_free_num_bolla_out")
				k_row = tab_1.tabpage_1.dw_1.getselectedrow(k_row)
			loop
		case 2
			if tab_1.tabpage_2.dw_2.getitemnumber(1, "id_sped_free") > 0 then
				k_row_print = 1
				kst_tab_sped_free[k_row_print].id_sped_free = tab_1.tabpage_2.dw_2.getitemnumber(1, "id_sped_free")
				kst_tab_sped_free[k_row_print].num_bolla_out = tab_1.tabpage_2.dw_2.getitemstring(1, "sped_free_num_bolla_out")
			end if
			
	end choose
		
	//--- stampa DDT
		if k_row_print > 0 then
			
			k_return = kiuf_sped_free.u_open_stampa(kst_tab_sped_free[])
			
		else
			messagebox("Stampa DDT", "Selezionare dall'elenco un DDT da Stampare")
		end if
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return k_return

end function

protected function integer visualizza ();//---
//--- personalizza routine di visualizzazione
//---
int k_row


try

	kist_tab_sped_free.id_sped_free = 0
	if tab_1.selectedtab = 1 then
		kist_tab_sped_free.id_sped_free = tab_1.tabpage_1.dw_1.event u_get_id_sped_free_selected( )
		if kist_tab_sped_free.id_sped_free = 0 then
			messagebox("Visualizza DDT", "Prego, selezionare una riga dall'elenco")
		end if
	end if
	
	if tab_1.selectedtab = 2 or kist_tab_sped_free.id_sped_free > 0 then
		ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
		tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.visualizzazione 

	//--- salvo il ID della lista per poi riproporlo dopo
		ki_list_id_selected = tab_1.tabpage_1.dw_1.event u_get_id_sped_free_selected( )
		
		tab_1.selecttab(2)
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return(0)

end function

protected subroutine modifica ();//---
//--- personalizza routine di visualizzazione
//


try

	kist_tab_sped_free.id_sped_free = 0
	if tab_1.selectedtab = 1 then
		kist_tab_sped_free.id_sped_free = tab_1.tabpage_1.dw_1.event u_get_id_sped_free_selected( )
		if kist_tab_sped_free.id_sped_free = 0 then
			messagebox("Modifica DDT", "Prego, selezionare una riga dall'elenco")
		end if
	end if
	
	if tab_1.selectedtab = 2 or kist_tab_sped_free.id_sped_free > 0 then
		ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
		tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.modifica 
		
	//--- salvo il ID della lista per poi riproporlo dopo
		ki_list_id_selected = tab_1.tabpage_1.dw_1.event u_get_id_sped_free_selected( )
		
		tab_1.tabpage_2.dw_2.u_proteggi_sproteggi_dw( )
		tab_1.tabpage_2.dw_2.event u_init_display_form( )
		tab_1.tabpage_2.event u_set_tab_title()
		
		tab_1.selecttab(2)
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

end subroutine

public subroutine smista_funz (string k_par_in);//
//===

choose case LeftA(k_par_in, 2) 

	case KKG_FLAG_RICHIESTA.libero1		//cambia date di estrazione
		cambia_periodo_elenco()

	case KKG_FLAG_RICHIESTA.libero5		//stampa ddt
		stampa_ddt()

	case else
		super::smista_funz(k_par_in)

end choose

end subroutine

private subroutine cambia_periodo_elenco ();//---
//--- Visualizza il box x il cambio del Periodo di elenco ddt 
//---


//dw_periodo.event post ue_visibile
dw_periodo.event ue_visible( )
end subroutine

on w_ddt_free.create
int iCurrent
call super::create
this.dw_periodo=create dw_periodo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_periodo
end on

on w_ddt_free.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_periodo)
end on

event close;call super::close;//
if isvalid(kiuf_sped_free) then destroy kiuf_sped_free
if isvalid(kiuf_clienti) then destroy 	kiuf_clienti



end event

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
int k_return
int k_rc
st_tab_clienti kst_tab_clienti



if isvalid(kst_open_w) then

//--- Dalla finestra di Elenco Valori
	if kst_open_w.id_programma = kkg_id_programma_elenco &
					and long(kst_open_w.key3) > 0 then
	
		if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore
		kdsi_elenco_input = kst_open_w.key12_any 
		
		if kdsi_elenco_input.rowcount() > 0 then
		
			choose case kst_open_w.key6 // nome campo di link
	
				case "clie_2_l" 
					if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
						k_return = 1
				
						tab_1.tabpage_2.dw_2.setitem(1, "clie_2", &
											 kdsi_elenco_input.getitemnumber(long(kst_open_w.key3), "id_cliente"))
						tab_1.tabpage_2.dw_2.setitem(1, "intestazione", &
											 kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "rag_soc_1"))
						tab_1.tabpage_2.dw_2.setitem(1, "intestazione_ind1", &
												trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "indirizzo")))
						tab_1.tabpage_2.dw_2.setitem(1, "intestazione_ind2", &
												trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "localita")) &
												+ " (" + trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "prov")) + ")")
						tab_1.tabpage_2.dw_2.setitem(1, "intestazione_ind3", &
												trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "nazione_nome"))) 
						tab_1.tabpage_2.dw_2.setitem(1, "intestazione_ind4", " ")
					end if		
								
				case "clie_3_l" 
					if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
						k_return = 1
				
						tab_1.tabpage_2.dw_2.setitem(1, "clie_3", &
											 kdsi_elenco_input.getitemnumber(long(kst_open_w.key3), "id_cliente"))
								

					end if		

			end choose 
		end if
							
	end if

end if

return k_return


end event

type dw_print_0 from w_g_tab_3`dw_print_0 within w_ddt_free
end type

type st_ritorna from w_g_tab_3`st_ritorna within w_ddt_free
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_ddt_free
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_ddt_free
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_ddt_free
integer x = 2711
integer y = 1468
end type

type st_stampa from w_g_tab_3`st_stampa within w_ddt_free
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_ddt_free
integer x = 1179
integer y = 1472
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_ddt_free
integer x = 645
integer y = 1468
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_ddt_free
integer x = 1970
integer y = 1468
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_ddt_free
integer x = 2341
integer y = 1468
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_ddt_free
integer x = 1600
integer y = 1468
boolean enabled = false
end type

event cb_inserisci::clicked;//
//=== 
string k_errore="0"

//=== Nuovo 
	choose case tab_1.selectedtab 
		case  1, 2 
			
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
	
		tab_1.selecttab(2)  // si posiziona sul tab dettaglio
	end if

end event

type tab_1 from w_g_tab_3`tab_1 within w_ddt_free
integer y = 28
integer width = 3255
integer height = 1384
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

event tab_1::u_constructor; //
							// 1     2     3     4     5      6      7       8     9   
ki_tabpage_enabled = {true, true, false, false, false, false, false, false, false} // disabilita alcune tabpage
super::event u_constructor( )

end event

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 3218
integer height = 1256
long backcolor = 32172778
string text = "Elenco DDT"
string picturename = "Window!"
long picturemaskcolor = 553648127
string powertiptext = "Elenco DDT a contenuto libero (non scarica il magazzino)"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
event type long u_get_id_sped_free_selected ( )
event type long u_set_selected_row ( )
integer width = 3173
integer height = 1220
string title = "elenco DDT a cotenuto libero"
string dataobject = "d_sped_free_l"
boolean hsplitscroll = false
boolean livescroll = false
borderstyle borderstyle = styleshadowbox!
string ki_flag_modalita = "el"
boolean ki_link_standard_sempre_possibile = true
end type

event type long dw_1::u_get_id_sped_free_selected();//
long k_row


	k_row = kguf_data_base.u_getlistselectedrow(tab_1.tabpage_1.dw_1)
	if k_row > 0 then
		return tab_1.tabpage_1.dw_1.getitemnumber(k_row, "id_sped_free")
	else
		return 0
	end if


end event

event type long dw_1::u_set_selected_row();//
long k_row


	if this.rowcount( ) > 0 then
		if ki_list_id_selected > 0 then
			k_row = this.find("id_sped_free = " + string(ki_list_id_selected), 1, this.rowcount( ) )
			ki_list_id_selected = 0
		end if
		if k_row = 0 then
			k_row = 1
		end if

		this.setrow(k_row)
		this.selectrow(0, false)
		this.selectrow(k_row, true)
		this.scrolltorow(k_row)
		return k_row
		
	else
		
		return 0
		
	end if


end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
event u_set_tab_title ( )
integer width = 3218
integer height = 1256
string text = "DDT"
string powertiptext = "Dettaglio dati"
end type

event tabpage_2::u_set_tab_title();//
if this.dw_2.ki_flag_modalita = kkg_flag_modalita.inserimento then
	this.text = "Nuovo DDT "
elseif this.dw_2.ki_flag_modalita = kkg_flag_modalita.modifica then
	this.text = "Modifica DDT "
elseif this.dw_2.ki_flag_modalita = kkg_flag_modalita.visualizzazione then
	this.text = "Visualizza DDT "
else
	this.text = "DDT "
end if
if this.dw_2.rowcount( ) > 0 then
	//if trim(this.dw_2.getitemstring(1, "sped_free_num_bolla_out")) > " " then 
	if trim(kist_tab_sped_free.num_bolla_out) > " " then
//		this.text += trim(this.dw_2.getitemstring(1, "sped_free_num_bolla_out")) + "/" &
		this.text += trim(kist_tab_sped_free.num_bolla_out) + "/" &
								+ string(this.dw_2.getitemdate(1, "sped_free_data_bolla_out"), "yyyy") 
	end if
end if
end event

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
event type long u_get_id_sped_free ( )
event u_itemchanged_num_data_bolla ( )
event u_proteggi_campi ( )
event u_set_background_color ( )
event u_init_display_form ( )
event u_set_tab_title ( )
event u_set_data_bolla_out_color ( )
integer x = 5
integer y = 20
integer width = 2981
integer height = 1228
string dataobject = "d_ddt_st_ed7_10_2019f"
string ki_flag_modalita = "vi"
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
boolean ki_dw_visibile_in_open_window = false
end type

event type long dw_2::u_get_id_sped_free();//
long k_return
string k_num
int k_anno


	if this.rowcount( ) = 0 then return 0
	
	k_num = this.getitemstring(1, "sped_free_num_bolla_out")
	k_anno = year(this.getitemdate(1, "sped_free_data_bolla_out"))

	select id_sped_free
	    into :k_return
		 from sped_free
		 where num_bolla_out = :k_num and year(data_bolla_out) = :k_anno
		 using kguo_sqlca_db_magazzino;
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		return 0
	else
		return k_return
	end if


end event

event dw_2::u_itemchanged_num_data_bolla();//
st_tab_sped_free kst_tab_sped_free

try		
	kst_tab_sped_free.id_sped_free = event u_get_id_sped_free( )
	if kst_tab_sped_free.id_sped_free > 0 then
		ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
		this.ki_flag_modalita = kkg_flag_modalita.modifica 
		ki_list_id_selected = kst_tab_sped_free.id_sped_free
		kist_tab_sped_free.id_sped_free = kst_tab_sped_free.id_sped_free
		inizializza_1( )
	end if
	tab_1.tabpage_2.event u_set_tab_title()

catch (exception kuo_exception)
	throw kuo_exception
	
end try
end event

event dw_2::u_proteggi_campi();//
//--- Protegge o meno a seconda dei casi
//

	this.setredraw(false)

//--- se NO inserimento leggo DW-CHILD
	if this.ki_flag_modalita = kkg_flag_modalita.inserimento or this.ki_flag_modalita = kkg_flag_modalita.modifica then
		this.u_proteggi_dw("1", "id_sped_free")
//--- S-protezione campi 
		this.u_proteggi_dw("0", 0)
	else
//--- Protezione tutti i campi 
		this.u_proteggi_dw("1", 0)
		this.u_proteggi_dw("1", "id_sped_free")
	end if			

	this.setredraw(true)
	
end event

event dw_2::u_set_background_color();//
//<DW Control Name>.Modify("<Columnname>.Border='<0 - None, 1- Shadow, 2 - Box, 3 - Resize, 4 - Underline, 5 - 3D Lowered, 6 - 3D Raised>'")
string k_border 
string k_rc
int k_idx
string k_color


tab_1.tabpage_2.dw_2.setredraw(false)

if this.ki_flag_modalita = kkg_flag_modalita.modifica &
					or this.ki_flag_modalita = kkg_flag_modalita.inserimento then
	k_border = "6"
	k_color = string(rgb(205,238,255))
else
	k_border = "0"
end if
//k_rc = tab_1.tabpage_2.dw_2.modify("dicit_ind_intest.border='" + k_border &
//									+ "' intestazione.border=' " + k_border &
//									+ "' intestazione_ind.border='" + k_border &
//									+ "' dicit_ind_sped.border='" + k_border &
//									+ "' indirizzo_riga_1.border='" + k_border &
//									+ "' indirizzo_riga_2.border='" + k_border &
//									+ "' indirizzo_riga_3.border='" + k_border &
//									+ "' indirizzo_riga_4.border='" + k_border &
//									+ "' indirizzo_riga_5.border='" + k_border &
//									+ "' ")
k_rc = tab_1.tabpage_2.dw_2.modify("dicit_ind_intest.Background.Color='" + k_color &
									+ "' intestazione.Background.Color=' " + k_color &
									+ "' intestazione_ind1.Background.Color='" + k_color &
									+ "' intestazione_ind2.Background.Color='" + k_color &
									+ "' intestazione_ind3.Background.Color='" + k_color &
									+ "' intestazione_ind4.Background.Color='" + k_color &
									+ "' dicit_ind_sped.Background.Color='" + k_color &
									+ "' indirizzo_riga_1.Background.Color='" + k_color &
									+ "' indirizzo_riga_2.Background.Color='" + k_color &
									+ "' indirizzo_riga_3.Background.Color='" + k_color &
									+ "' indirizzo_riga_4.Background.Color='" + k_color &
									+ "' indirizzo_riga_5.Background.Color='" + k_color &
									+ "' sped_free_data_bolla_out.Background.Color='" + k_color &
									+ "' sped_free_num_bolla_out.Background.Color='" + k_color &
									+ "' ")
k_rc = tab_1.tabpage_2.dw_2.modify( "causale.Background.Color='" + k_color &
									+ "' sped_note.Background.Color='" + k_color &
									+ "' aspetto.Background.Color='" + k_color &
									+ "' resa.Background.Color='" + k_color &
									+ "' colli.Background.Color='" + k_color &
									+ "' peso_kg.Background.Color='" + k_color &
									+ "' porto.Background.Color='" + k_color &
									+ "' trasporto.Background.Color='" + k_color &
									+ "' data_ora_rit.Background.Color='" + k_color &
									+ "' vett_1.Background.Color='" + k_color &
									+ "' annotazioni.Background.Color='" + k_color &
									+ "' ")

for k_idx = 1 to 19
	k_rc = tab_1.tabpage_2.dw_2.modify("qta_" + string(k_idx, "#") + ".Background.Color='" + k_color &
											+ "' descr_" + string(k_idx, "#") + ".Background.Color=' " + k_color &
											+ "' kgy_" + string(k_idx, "#") + ".Background.Color=' " + k_color &
									+ "' ")
next
																		
tab_1.tabpage_2.dw_2.setredraw(true)

k_rc = ""
end event

event dw_2::u_init_display_form();// Varie operazioni di visualizzazione del form

	event u_personalizza_dw() // propone i link
	modify("b_clie_2_l.visible='1' b_clie_3_l.visible='1'") 
//--- protegge/sprotegge campi
	event u_proteggi_campi()
//--- colora i campi modificabili
	event u_set_Background_Color()
//--- mette data in attenzione
	event u_set_data_bolla_out_color( )

	this.visible = true
	this.setfocus()

end event

event dw_2::u_set_data_bolla_out_color();//
string k_modify 

if this.rowcount( ) = 0 then return

if (this.ki_flag_modalita = kkg_flag_modalita.inserimento or this.ki_flag_modalita = kkg_flag_modalita.modifica) &
		and this.getitemdate(1, "sped_free_data_bolla_out") <> date(today()) then
	k_modify = "sped_free_data_bolla_out.color = " + string(fx_get_color('TXTHIGHLIGHTED'))
else 
	k_modify = "sped_free_data_bolla_out.color = " + describe('sped_free_num_bolla_out.color')
end if

this.modify(k_modify)


end event

event dw_2::itemchanged;call super::itemchanged;//
string k_codice, k_nome
int k_errore


try
	
	k_nome = lower(dwo.name)
	
	if left(k_nome,4) = "qta_" then
		post u_calcola_colli()
	elseif k_nome = "sped_free_num_bolla_out" or k_nome = "sped_free_data_bolla_out" then
		event post u_itemchanged_num_data_bolla( )

		event post u_set_data_bolla_out_color( ) // mette data in attenzione
	end if	
	
// fino a che non e' a posto il bug che la funzione non viene lanciata da u_d_std_1
//	post attiva_tasti()
	
catch (uo_exception kuo_exception)
	kuo_exception.post messaggio_utente()
	k_errore = 2
	
end try

return k_errore

end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
integer x = 594
integer y = 136
integer height = 144
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer width = 3218
integer height = 1256
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 3218
integer height = 1256
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 3218
integer height = 1256
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 3218
integer height = 1256
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3218
integer height = 1256
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3218
integer height = 1256
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3218
integer height = 1256
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type st_duplica from w_g_tab_3`st_duplica within w_ddt_free
end type

type dw_periodo from uo_dw_periodo within w_ddt_free
integer x = 114
integer y = 868
integer width = 955
integer height = 504
integer taborder = 70
boolean bringtotop = true
boolean enabled = true
end type

event ue_clicked;call super::ue_clicked;//
	this.accepttext( )
	this.visible = false
	
	dw_periodo.ki_data_ini  = this.getitemdate( 1, "data_dal")
	dw_periodo.ki_data_fin  = this.getitemdate( 1, "data_al")

	ki_updated = true   // forza la rilettura dell'elenco
	inizializza()

end event

event ue_visible;call super::ue_visible;////
//int k_rc
//
//	this.width = long(this.object.data_al.x) + long(this.object.data_al.width) + 100
//	this.height = long(this.object.b_ok.y) + long(this.object.b_ok.height) + 160
//
//	this.x = (kiw_this_window.width  - this.width) / 4
//	this.y = (kiw_this_window.height - this.height) / 4
//
//	this.reset()
//	k_rc = this.insertrow(0)
//	k_rc = this.setitem(1, "data_dal", ki_data_ini)
//	k_rc = this.setitem(1, "data_al", ki_data_fin)
//	this.visible = true
//	this.setfocus()


end event

