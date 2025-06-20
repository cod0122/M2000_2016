﻿$PBExportHeader$kuf_wm_pklist_web.sru
forward
global type kuf_wm_pklist_web from kuf_wm_pklist
end type
end forward

global type kuf_wm_pklist_web from kuf_wm_pklist
end type
global kuf_wm_pklist_web kuf_wm_pklist_web

forward prototypes
public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function st_esito tb_delete (ref st_wm_pkl_web kst_wm_pkl_web)
public function integer u_tree_open (string k_modalita, st_wm_pklist kst_wm_pklist[], ref datawindow kdw_anteprima)
public function long importa_wm_pklist_web () throws uo_exception
private function long set_wm_pklist_web_to_wm_tab (ref st_wm_pkl_web kst_wm_pkl_web[], ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]) throws uo_exception
public function integer get_file_wm_pklist_web (ref st_wm_pkl_web kst_wm_pkl_web[]) throws uo_exception
public function long get_wm_pklist_web_xml (ref st_wm_pkl_web kst_wm_pkl_web_file, ref st_wm_pkl_web kst_wm_pkl_web_out[]) throws uo_exception
end prototypes

public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto);//
//--- Visualizza Treeview: Testata Fatture
//
integer k_return = 0, k_rc
long k_handle_item=0, k_handle_item_padre=0, k_handle_item_figlio=0, k_handle_item_nonno=0, k_handle_item_rit
integer k_pic_open, k_pic_close, k_mese, k_anno
string k_dataoggix, k_stato, k_tipo_oggetto_figlio, k_tipo_oggetto_nonno
string k_query_select, k_query_where, k_query_order
datetime k_data_da, k_data_a, k_data_0, k_data_meno3mesi
boolean k_x_mese=true
int k_ind, k_nr_file_xml, k_ctr_file_xml, k_nr_wm_pkl_web
string k_label
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
st_tab_clienti kst_tab_clienti
st_wm_pkl_web kst_wm_pkl_web[], kst_wm_pkl_web_file[], kst_wm_pkl_web_da_imp[]



	k_data_0 = datetime(date(0)	)

		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
		 
//--- Ricavo il handle del Padre e il tipo Oggetto
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle

//--- .... altrimenti lo ricavo dalla tree
	if k_handle_item_padre = 0 or isnull(k_handle_item_padre) then	
//--- item di ritorno di default
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
	end if

	k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
	kst_treeview_data = ktvi_treeviewitem.data  

	k_data_da = datetime(date(0))
		
//--- Ricavo la data da dataoggi
	k_data_da = datetime(RelativeDate(kG_dataoggi, - 60) )
	
		 
	k_handle_item_nonno = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_padre)

	k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_nonno, ktvi_treeviewitem) 
	kst_treeview_data = ktvi_treeviewitem.data  
	k_tipo_oggetto_nonno = kst_treeview_data.oggetto
		 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = kkg_esito.ok then
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
//			k_pic_list = kst_tab_treeview.pic_close
		end if
	
//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)


		ktvi_treeviewitem.selected = false


		try
		
			choose case k_tipo_oggetto
					
				case kuf1_treeview.kist_treeview_oggetto.pklist_wm_da_web_dett
	//--- Leggo elenco file pkl-web della cartella FTP 
					k_nr_file_xml = get_file_wm_pklist_web(kst_wm_pkl_web_file[]) 
			
				case else
					k_nr_file_xml = 0
	
			end choose
	
			if k_nr_file_xml > 0 then
				
				for k_ctr_file_xml = 1 to k_nr_file_xml
			
					if len(trim(kst_wm_pkl_web_file[k_ctr_file_xml].nome_file)) > 0 then   // se c'e' un file....

						k_nr_wm_pkl_web = get_wm_pklist_web_xml( kst_wm_pkl_web_file[k_ctr_file_xml], kst_wm_pkl_web_da_imp[]) 
						if  k_nr_wm_pkl_web > 0 then
					
							kst_treeview_data.flag = k_x_mese
							
							kst_treeview_data.handle = 0
							kst_treeview_data.oggetto = k_tipo_oggetto_figlio
							kst_treeview_data.oggetto_padre = k_tipo_oggetto
							kst_treeview_data.struttura = kst_treeview_data_any
			
			//				if isnull(kst_tab_clienti.rag_soc_10) then	kst_tab_clienti.rag_soc_10 = " "
							
							kst_treeview_data_any.st_wm_pkl_web = kst_wm_pkl_web_da_imp[1]
			//				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
							kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
							
							kst_treeview_data.struttura = kst_treeview_data_any
							
							kst_treeview_data.label = &
														  string(kst_wm_pkl_web_da_imp[1].idpkl) &
														  + " - " + string(kst_wm_pkl_web_da_imp[1].data_invio, "dd.mmm") &
														  + "   (" + string(kst_wm_pkl_web_da_imp[1].mandante) + ") "
			
							kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
							kst_treeview_data.handle = k_handle_item_padre
							kst_treeview_data.pic_list = kst_tab_treeview.pic_list
				
							ktvi_treeviewitem.label = kst_treeview_data.label
							ktvi_treeviewitem.data = kst_treeview_data
													  
			//--- Nuovo Item
							ktvi_treeviewitem.selected = false
							k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
							
			//--- salvo handle del item appena inserito nella stessa struttura
							kst_treeview_data.handle = k_handle_item
			
			//--- inserisco il handle di questa riga tra i dati del item
							ktvi_treeviewitem.data = kst_treeview_data
			
							kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
	
						end if
					end if
				end for	
				
			end if
		
		catch(uo_exception kuo_exception)
			kGuo_exception.set_esito(kuo_exception.get_st_esito())
			
		end try
		
	end if
 
 
return k_return


end function

public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle, k_handle_item_corrente, k_handle_item_rit
integer k_ctr
date k_save_data_int, k_data_bolla_in, k_data_da, k_data_a
long k_clie_2=0
string k_rag_soc_10 , k_label, k_oggetto_corrente, k_stato_barcode="", k_tipo_oggetto_padre, k_tipo_doc, k_stato
int k_ind, k_mese, k_anno
string k_campo[15]
alignment k_align[15]
alignment k_align_1
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_wm_pkl_web kst_wm_pkl_web
st_tab_clienti kst_tab_clienti, kst_tab_clienti_fatt
st_tab_treeview kst_tab_treeview
kuf_clienti kuf1_clienti
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_profilestring_ini kst_profilestring_ini



		 
//--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione

//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item = kst_treeview_data.handle
	
	if k_handle_item > 0 then

//--- prendo il item padre per settare il ritorno di default
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item)

	end if
	
//--- .... altrimenti lo ricavo dalla tree
	if k_handle_item = 0 or isnull(k_handle_item) then	
	
//--- item di ritorno di default
		k_handle_item = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  
		
	end if
	k_handle_item_corrente = k_handle_item

//--- item di ritorno di default
	k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
	kst_treeview_data = ktvi_treeviewitem.data  
	k_tipo_oggetto_padre = kst_treeview_data.oggetto	

//--- cancello dalla listview tutto
	kuf1_treeview.kilv_lv1.DeleteItems()
		 
//--- item di ritorno (vedi anche alla fine)
	if k_handle_item_padre > 0 then
		klvi_listviewitem.data = kst_treeview_data
		klvi_listviewitem.label = ".."
		klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
		k_handle_item_rit = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)
	end if
		
	if k_handle_item > 0 then

		kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)

		kst_treeview_data = ktvi_treeviewitem.data

		k_handle_item = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  
				 

		kuf1_treeview.kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
					

//=== Costruisce e Dimensiona le colonne all'interno della listview
		k_ind=1
		k_campo[k_ind] = "Pk-List Web"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "prodotto il "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Mandante codice "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "nr. d.d.t."
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "data d.d.t."
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "colli "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "id Contratto"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Contr.Commerciale"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Capitolato"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Ricevente codice "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Cliente codice "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "note lotto "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "posizione documento "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "FINE"
		k_align[k_ind] = left!
			
	
		k_ind=1
		kuf1_treeview.kilv_lv1.getColumn(k_ind, k_label, k_align_1, k_ctr) 
		if trim(k_label) <> trim(k_campo[k_ind]) then 
			kuf1_treeview.kilv_lv1.DeleteColumns ( )
	
			k_ind=1
			do while trim(k_campo[k_ind]) <> "FINE"
	
				kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi 
				kst_profilestring_ini.file = "treeview"
				kst_profilestring_ini.titolo = "treeview"
				kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + k_campo[k_ind]
				kst_profilestring_ini.valore = "0"
				k_rc = integer(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	
				if kst_profilestring_ini.esito = "0" then
					k_ctr = integer(kst_profilestring_ini.valore)
				end if
				if k_ctr = 0 then
					k_ctr = (kuf1_treeview.kilv_lv1.width) / 4 //50 * len(trim(k_campo[k_ind])) 
				end if
				kuf1_treeview.kilv_lv1.addColumn(trim(k_campo[k_ind]), k_align[k_ind], k_ctr)
				k_ind++
			loop
	
		end if
	
	
//--- imposto il pic corretto
//		k_handle = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
//		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//		k_oggetto_corrente = trim(kst_treeview_data.oggetto)
//		k_pictureindex = u_dammi_pic_tree_list(k_oggetto_corrente)			

	
		kuf1_clienti = create kuf_clienti

		do while k_handle_item > 0
				
			kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
	
			kst_treeview_data = ktvi_treeviewitem.data

			klvi_listviewitem.label = kst_treeview_data.label
			
			klvi_listviewitem.data = kst_treeview_data

			kst_treeview_data_any = kst_treeview_data.struttura

			kst_wm_pkl_web = kst_treeview_data_any.st_wm_pkl_web
			kst_tab_clienti = kst_treeview_data_any.st_tab_clienti

			klvi_listviewitem.data = kst_treeview_data

			klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
			
			klvi_listviewitem.selected = false
			
			k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)


//			kst_tab_clienti_fatt.codice = kst_wm_pkl_web.clie_3
//			kst_esito = kuf1_clienti.get_nome(kst_tab_clienti_fatt)
//			if kst_esito.esito <> kkg_esito.ok then
//				kst_tab_clienti_fatt.rag_soc_10 = "???non Trovato???"
//			end if

			k_ind=1
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_wm_pkl_web.idpkl))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_web.data_invio ) +" " + trim(kst_wm_pkl_web.ora_invio ))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_web.mandante ))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_web.nrddt ))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_wm_pkl_web.dtddt ))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_wm_pkl_web.colliddt ))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_web.id_contratto ))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_web.mc_co ))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_web.sc_cf ))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_web.ricevente ))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_web.fatturato ))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_web.codice_lotto ))
			k_ind++
			if isnull(kst_wm_pkl_web.path_file )  then kst_wm_pkl_web.path_file  = ""
			if isnull(kst_wm_pkl_web.nome_file )  then kst_wm_pkl_web.nome_file  = ""
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_web.path_file ) +"\" + trim(kst_wm_pkl_web.nome_file ))
			
			
//--- Leggo rec next dalla tree				
			k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)

		loop
		
		destroy kuf1_clienti
		
	end if
 
 
//---- item di ritorno
	if k_handle_item_rit > 0 then
		kst_treeview_data.handle_padre = k_handle_item_corrente
		kst_treeview_data.handle = k_handle_item_padre
		kst_treeview_data.oggetto_listview = k_tipo_oggetto
		kst_treeview_data.oggetto = k_tipo_oggetto_padre
		ktvi_treeviewitem.data = kst_treeview_data
		klvi_listviewitem.label = ".."
		klvi_listviewitem.data = kst_treeview_data
		klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
		k_ctr = kuf1_treeview.kilv_lv1.setitem(k_handle_item_rit, klvi_listviewitem)
	end if
		 
	if kuf1_treeview.kilv_lv1.totalitems() > 1 then
		
//--- Attivo Drag and Drop 
		kuf1_treeview.kilv_lv1.DragAuto = True 

//--- Attivo multi-selezione delle righe 
		kuf1_treeview.kilv_lv1.extendedselect = true 
			
	end if


 
return k_return

 
 
 


end function

public function st_esito tb_delete (ref st_wm_pkl_web kst_wm_pkl_web);//
//====================================================================
//=== Cancella il rek dalla tabella Receiptgammarad (tutte le righe della bolla di pkl)
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
int k_rc
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility
st_open_w kst_open_w
boolean k_autorizza


kst_esito.esito = kkg_esito.ok 
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = this.get_id_programma(kkg_flag_modalita.CANCELLAZIONE) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione documento 'Packing List Web' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if len(trim(kst_wm_pkl_web.nome_file)) > 0 then

		try
	
			kuf1_utility = create kuf_utility
			if not DirectoryExists (kst_wm_pkl_web.path_file+"\Rimossi") then CreateDirectory (kst_wm_pkl_web.path_file+"\Rimossi") 
			k_rc = kuf1_utility.u_filemovereplace( kst_wm_pkl_web.path_file +"\"+  kst_wm_pkl_web.nome_file,  &
			                                              kst_wm_pkl_web.path_file+"\Rimossi\"+kst_wm_pkl_web.nome_file)
			
			if k_rc < 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Cancellazione 'Packing List Web' file=" +trim(kst_wm_pkl_web.nome_file) + " non riuscita! "
				sqlca.sqlcode = 0 
				kst_esito.esito = kkg_esito.no_esecuzione
	
			end if
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()

		finally
			destroy kuf1_utility
			
		end try
		
	end if
end if


return kst_esito

end function

public function integer u_tree_open (string k_modalita, st_wm_pklist kst_wm_pklist[], ref datawindow kdw_anteprima);//
//--- Chiama applicazioni di dettaglio
//
integer k_return = 0, k_rc = 0, k_index=0
datastore kds_1
st_esito kst_esito
st_open_w kst_open_w
st_tab_g_0 kst_tab_g_0[]


kst_esito.esito = kkg_esito.ok 
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if upperbound(kst_wm_pklist) > 0 then

   choose case k_modalita  

      case kkg_flag_modalita.anteprima

//       if len(trim(kst_tab_wm_pklist.st_wm_pkl_web[1].idpkl )) > 0 then
//          kds_1 = create datastore
//          kst_esito = anteprima ( kds_1, kst_tab_wm_pklist.st_wm_pkl_web[1])
//          if kst_esito.esito = kkg_esito.db_ko then
//             k_return = 1
//             kguo_exception.set_esito( kst_esito )
//             kguo_exception.messaggio_utente( )
//          else
//
//             kdw_anteprima.dataobject = kds_1.dataobject
//             kds_1.rowscopy( 1, kds_1.rowcount( ) , primary!, kdw_anteprima, 1, primary!)
//             
//          end if
//          destroy kds_1
//       end if

//--- Cancellazione
      case kkg_flag_modalita.cancellazione

         for k_index = 1 to upperbound(kst_wm_pklist)    

            if len(trim(kst_wm_pklist[k_index].st_wm_pkl_web.nome_file)) > 0 then
               this.tb_delete(kst_wm_pklist[k_index].st_wm_pkl_web)
            end if
         
         end for
      
      case else

         kst_open_w.flag_modalita = k_modalita        
         kst_tab_g_0[1].id = kst_wm_pklist[1].st_wm_pkl_web.idpkl
         kst_esito = this.u_open( kst_tab_g_0[], kst_open_w )   //Apre le Varie Funzioni
         if kst_esito.esito = kkg_esito.ok then 
            k_return = 1
            
            kguo_exception.setmessage( "Operazione di Accesso al Packing List Web fallita. ")
            kguo_exception.messaggio_utente( )
         end if
            
            
   end choose     


end if   
 
 
return k_return

end function

public function long importa_wm_pklist_web () throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//--- Importa Packing-List da file XML nella Tabella 'grezza' ReceiptGammarad
//---	
//---
//---	inp: kst_tab_wm_receiptgammarad. 
//---	out: 
//---	rit: nr. dei Pcking Importati 
//---   Lancia EXCEPTION se errore
//------------------------------------------------------------------------------------------------------------------------------------
//
long k_return=0
long k_id_wm_pklist_importato=0, k_nr_file_xml=0, k_ind_file=0, k_nr_ws_receiptgammarad=0, k_ctr_ws_receiptgammarad=0, k_nr_wm_pkl_web=0
long k_rc
string k_nome_file=""
st_esito kst_esito
st_wm_pklist kst_wm_pklist
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
st_wm_pkl_web kst_wm_pkl_web, kst_wm_pkl_web_file[], kst_wm_pkl_web_da_imp[], kst_wm_pkl_web_da_imp_NULLA[]
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad [], kst_tab_wm_receiptgammarad_NULLA[]
kuf_utility kuf1_utility
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
kuf_wm_receiptgammarad kuf1_wm_receiptgammarad

					
try
	kst_esito = kguo_exception.inizializza(this.classname())

	kuf1_utility = create kuf_utility
	kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg
	kuf1_wm_receiptgammarad = create kuf_wm_receiptgammarad
			
//--- leggo configurazione x lo scambio dati
	if not kuf1_wm_pklist_cfg.get_wm_pklist_cfg(kst_tab_wm_pklist_cfg) then
		return 0
	end if

//--- parte l'importazione solo se Operazione di Importazione PACKING-LIST Attiva
	if kst_tab_wm_pklist_cfg.blocca_importa = kuf1_wm_pklist_cfg.ki_blocca_importa_dam2000 then
		
//--- Leggo i nomi dei file da importare
		kst_wm_pkl_web_file[100].nome_file = " "   // x sicurezza crea intanto una tabellina grande 100 elementi 
		k_nr_file_xml = get_file_wm_pklist_web(kst_wm_pkl_web_file[]) 

		for k_ind_file = 1 to k_nr_file_xml 
			
			kst_wm_pkl_web.nome_file = kst_wm_pkl_web_file[k_ind_file].nome_file

			if len(trim(kst_wm_pkl_web.nome_file)) > 0 then   // se c'e' un file....
	//--- muove il file XML nella cartella dei flussi 'IN LAVORAZIONE'
				if not DirectoryExists (kst_wm_pkl_web_file[k_ind_file].path_file+"\inLav") then CreateDirectory (kst_wm_pkl_web_file[k_ind_file].path_file+"\inLav") 
				kuf1_utility.u_filemovereplace( kst_wm_pkl_web_file[k_ind_file].path_file +"\"+  kst_wm_pkl_web_file[k_ind_file].nome_file,  &
																			 kst_wm_pkl_web_file[k_ind_file].path_file+"\inLav\"+kst_wm_pkl_web_file[k_ind_file].nome_file)
				kst_wm_pkl_web.path_file = kst_wm_pkl_web_file[k_ind_file].path_file+"\inLav"
				
	//--- Legge le Packing-list in formato XML 
				kst_wm_pkl_web_da_imp[] = kst_wm_pkl_web_da_imp_NULLA[]
				k_nr_wm_pkl_web = get_wm_pklist_web_xml( kst_wm_pkl_web, kst_wm_pkl_web_da_imp[]) 
				if k_nr_wm_pkl_web > 0 then
					
//--- Imposta area ReceiptGammarad il Packing-list in formato XML 
					kst_tab_wm_receiptgammarad[] = kst_tab_wm_receiptgammarad_NULLA[]
					k_nr_ws_receiptgammarad = set_wm_pklist_web_to_wm_tab( kst_wm_pkl_web_da_imp[], kst_tab_wm_receiptgammarad[]) 
				
//--- Se Esiste già, SCARTA
					k_rc = kuf1_wm_receiptgammarad.if_exists_packinglistcode(kst_tab_wm_receiptgammarad[1])
					if k_rc > 0 then

//--- muove il file nella cartella dei flussi SCARTATI			
						if not DirectoryExists (kst_wm_pkl_web_file[k_ind_file].path_file+"\scartati") then CreateDirectory (kst_wm_pkl_web_file[k_ind_file].path_file+"\scartati") 
						kuf1_utility.u_filemovereplace( kst_wm_pkl_web_file[k_ind_file].path_file +"\inLav\"+kst_wm_pkl_web_file[k_ind_file].nome_file,  &
																					 kst_wm_pkl_web_file[k_ind_file].path_file+"\scartati\"+kst_wm_pkl_web_file[k_ind_file].nome_file)
		
						kguo_exception.set_tipo( kguo_exception.KK_st_uo_exception_tipo_non_eseguito )
						kguo_exception.kist_esito.sqlerrtext = "Packing List: " + kst_tab_wm_receiptgammarad[1].packinglistcode &
																	+ " SCARTATO perchè già Presente con ID " + string(k_rc) &
																	+ ".~n~rFile scartato: " + kst_wm_pkl_web_file[k_ind_file].nome_file
						throw kguo_exception
					end if

//--- INSERT nella tabella di PACKING-LIST
					k_rc = kuf1_wm_receiptgammarad.add( k_nr_ws_receiptgammarad, kst_tab_wm_receiptgammarad[] )
					if k_rc > 0 then
						k_return ++
					end if

//--- muove il file XML nella cartella dei flussi IMPORTATI			
					if not DirectoryExists (kst_wm_pkl_web_file[k_ind_file].path_file+"\importato") then CreateDirectory (kst_wm_pkl_web_file[k_ind_file].path_file+"\importato") 
					kuf1_utility.u_filemovereplace( kst_wm_pkl_web_file[k_ind_file].path_file +"\inLav\"+kst_wm_pkl_web_file[k_ind_file].nome_file,  &
																				 kst_wm_pkl_web_file[k_ind_file].path_file+"\importato\"+kst_wm_pkl_web_file[k_ind_file].nome_file)
	
					
				end if
			end if
					
		end for
	else
		kguo_exception.set_tipo( kguo_exception.KK_st_uo_exception_tipo_non_eseguito )
		kguo_exception.setmessage( "NON eseguito. Se si vuole importare i Pkl Web del Cliente, Attivare le Operazioni in Proprietà Packing-List da Proprietà della Procedura.")
		throw kguo_exception
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_utility) then destroy kuf1_utility
	if isvalid(kuf1_wm_pklist_cfg) then destroy kuf1_wm_pklist_cfg	
	if isvalid(kuf1_wm_receiptgammarad) then destroy kuf1_wm_receiptgammarad
	
end try


return k_return


end function

private function long set_wm_pklist_web_to_wm_tab (ref st_wm_pkl_web kst_wm_pkl_web[], ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Converte i Packing-List Web nalla struct array kst_tab_wm_receiptgammarad []
//---	inp: st_wm_pkl_web.nome_file è il nome file da importare 
//---	out: kst_tab_wm_receiptgammarad[]: array con le righe del packing-list letto
//---	rit: nr pkl trovati
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
long k_return=0
string k_rc, k_file=""
int k_rcn, k_file_ind, k_anno, k_mese, k_giorno
long k_ind=0
boolean k_trovate_note_lotto = false
datetime k_datetime_current
st_esito kst_esito
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad_null
kuf_wm_receiptgammarad kuf1_wm_receiptgammarad
 
 
	try

		kuf1_wm_receiptgammarad = create kuf_wm_receiptgammarad

		k_datetime_current = kguo_g.get_datetime_current( )
		
//--- preparo la struct a NULL		
		kuf1_wm_receiptgammarad.set_null(kst_tab_wm_receiptgammarad_null)
		
		for k_file_ind = 1 to upperbound(kst_wm_pkl_web[])

			if kst_wm_pkl_web[k_file_ind].idpkl > 0 then
				
				if len(trim( kst_wm_pkl_web[k_file_ind].barcode)) > 0 then
					
					k_ind++

//--- inizializzo la riga				
					kst_tab_wm_receiptgammarad[k_ind] = kst_tab_wm_receiptgammarad_null
				
//--- riempie le righe con il Packing-list WEB da importare

					kst_tab_wm_receiptgammarad[k_ind].idpkl = kst_wm_pkl_web[k_file_ind].idpkl  // id del pklist

//--- codice packing-list
					if trim(kst_wm_pkl_web[k_file_ind].tipo_invio) = "FTP" then // se questo campo è valorizzato a FTP allora compongo il codice packing-list fregandomene del codice_pl
						kst_tab_wm_receiptgammarad[k_ind].packinglistcode = "ftp_" +string(kst_wm_pkl_web[k_file_ind].id_cliente)+"_"+ string(kst_wm_pkl_web[k_file_ind].idpkl) 
					else
						if len(trim(kst_wm_pkl_web[k_file_ind].codice_pl)) > 0 then // come richiesto da Zanetti+Mario se questo campo è val allora metto questo codice
							kst_tab_wm_receiptgammarad[k_ind].packinglistcode = trim(kst_wm_pkl_web[k_file_ind].codice_pl)
						else
							kst_tab_wm_receiptgammarad[k_ind].packinglistcode = "www_" +string(kst_wm_pkl_web[k_file_ind].id_cliente)+"_"+ string(kst_wm_pkl_web[k_file_ind].idpkl) 
						end if
					end if

//--- converte la data di invio
					if len(trim(kst_wm_pkl_web[k_file_ind].data_invio)) > 0 then
						k_giorno = integer(mid(trim(kst_wm_pkl_web[k_file_ind].data_invio),1,2))
						k_mese = integer(mid(trim(kst_wm_pkl_web[k_file_ind].data_invio),4,2))
						k_anno = integer(mid(trim(kst_wm_pkl_web[k_file_ind].data_invio),7,4))
						kst_tab_wm_receiptgammarad[k_ind].transmissiondate = datetime(date(k_anno,k_mese,k_giorno), time(kst_wm_pkl_web[k_file_ind].ora_invio))
					else
						kst_tab_wm_receiptgammarad[k_ind].transmissiondate = k_datetime_current // datetime(date(today()),time(now()))
					end if
	
					kst_tab_wm_receiptgammarad[k_ind].receiptdate = k_datetime_current //datetime(date(today()),time(now()))
					kst_tab_wm_receiptgammarad[k_ind].ddtcode	= upper(kst_wm_pkl_web[k_file_ind].nrddt)
					kst_tab_wm_receiptgammarad[k_ind].ddtdate = datetime(date(kst_wm_pkl_web[k_file_ind].dtddt ))	
					kst_tab_wm_receiptgammarad[k_ind].mandatorcustomercode	= trim(kst_wm_pkl_web[k_file_ind].mandante)
					kst_tab_wm_receiptgammarad[k_ind].receivercustomercode = trim(kst_wm_pkl_web[k_file_ind].ricevente)	
					kst_tab_wm_receiptgammarad[k_ind].invoicecustomercode = trim(kst_wm_pkl_web[k_file_ind].fatturato)
					kst_tab_wm_receiptgammarad[k_ind].specification = upper(kst_wm_pkl_web[k_file_ind].sc_cf)
					kst_tab_wm_receiptgammarad[k_ind].contract	= upper(kst_wm_pkl_web[k_file_ind].mc_co)
					kst_tab_wm_receiptgammarad[k_ind].externalpalletcode = upper(kst_wm_pkl_web[k_file_ind].barcode)
					kst_tab_wm_receiptgammarad[k_ind].palletlength = len(trim(kst_tab_wm_receiptgammarad[k_ind].externalpalletcode))
//---25.06.2009 su rich di Zanetti					kst_tab_wm_receiptgammarad[k_ind].palletquantity = 1	
					if kst_wm_pkl_web[k_file_ind].barcode_qta_scatole > 0 then
						kst_tab_wm_receiptgammarad[k_ind].palletquantity = kst_wm_pkl_web[k_file_ind].barcode_qta_scatole 
					else
						kst_tab_wm_receiptgammarad[k_ind].palletquantity = 1	
					end if

//--- quando arriva via Internet viene riempito il tab <codice_lotto> mentre dal cliente ARAN il tag <barcode_lotto> 
					if len(trim(kst_wm_pkl_web[k_file_ind].codice_lotto )) > 0 then
						kst_tab_wm_receiptgammarad[k_ind].customerlot = upper(trim(kst_wm_pkl_web[k_file_ind].codice_lotto ))
					else
						if len(trim(kst_wm_pkl_web[k_file_ind].barcode_lotto )) > 0 then
							kst_tab_wm_receiptgammarad[k_ind].customerlot = upper(trim(kst_wm_pkl_web[k_file_ind].barcode_lotto ))
						else
							kst_tab_wm_receiptgammarad[k_ind].customerlot = upper(kst_tab_wm_receiptgammarad[k_ind].packinglistcode)
						end if
					end if
					kst_tab_wm_receiptgammarad[k_ind].orderdate = k_datetime_current //datetime(date(today()),time(now()))

//--- altri dati circa il singolo barcode
					kst_tab_wm_receiptgammarad[k_ind].customerItem = upper(trim(kst_wm_pkl_web[k_file_ind].barcode_item ))
//??????					kst_tab_wm_receiptgammarad[k_ind].customerLot = trim(kst_wm_pkl_web[k_file_ind].barcode_note )
					kst_tab_wm_receiptgammarad[k_ind].PesoNetto = kst_wm_pkl_web[k_file_ind].barcode_peso_netto
					kst_tab_wm_receiptgammarad[k_ind].PesoLordo = kst_wm_pkl_web[k_file_ind].barcode_peso_lordo
					kst_tab_wm_receiptgammarad[k_ind].QuantitaSacchi = kst_wm_pkl_web[k_file_ind].barcode_qta_pezzi 
					kst_tab_wm_receiptgammarad[k_ind].barcodewo = upper(trim(kst_wm_pkl_web[k_file_ind].barcode_wo ))

					
//--- scompatta il campo note, carica le NOTE del cliente solo sulla prima riga del Lotto!
					kst_tab_wm_receiptgammarad[k_ind].note_1 = ""
					kst_tab_wm_receiptgammarad[k_ind].note_2 = ""
					kst_tab_wm_receiptgammarad[k_ind].note_3 = ""
					if not k_trovate_note_lotto then
						if (kst_wm_pkl_web[k_file_ind].note_lotto ) > " " then
							k_trovate_note_lotto = true
							kst_tab_wm_receiptgammarad[1].note_1 = trim(kst_wm_pkl_web[k_file_ind].note_lotto)
						end if
					end if
					
				end if				
			end if				
		end for
	
		k_return = k_ind
		
	catch (uo_exception kuo_exception)
//		kst_esito.esito = kkg_esito.bug
//		kst_esito.sqlcode = k_rcn
//		kst_esito.SQLErrText = "Importazione Nuovi 'Packing-List' fallito!  ~n~r "  
//		kguo_exception.set_esito(kst_esito)
		throw kuo_exception
		
		
	finally
		destroy kuf1_wm_receiptgammarad			
		
	end try
			


return k_return


end function

public function integer get_file_wm_pklist_web (ref st_wm_pkl_web kst_wm_pkl_web[]) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Trova i nomi file di Packing-List Web presenti nella cartella di importazione
//---	inp: st_wm_pkl_web vuoto
//---	out: st_wm_pkl_web array con il path e il nome da importare
//---	rit: nr file da importare
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
integer k_return=0
boolean k_b=false
string k_rc
int k_rcn, k_file_ind, k_max_array
int k_ind, k_nr_file_dirlist
datastore kds_dirlist
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
//listbox klistbox
kuf_file_explorer kuf1_file_explorer
 
 
	try
		kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg
		kuf1_file_explorer = create kuf_file_explorer

//--- piglia il path di dove sono i Packing-list Web
		kuf1_wm_pklist_cfg.get_wm_pklist_cfg(kst_tab_wm_pklist_cfg)

//--- piglia l'elenco dei file xml contenuti nella cartella
		kds_dirlist = kuf1_file_explorer.DirList( &
					kuf1_file_explorer.u_add_path_and_filename(kst_tab_wm_pklist_cfg.cartella_pkl_da_web, "*.xml"))
			
		k_nr_file_dirlist = kds_dirlist.rowcount( )

		k_max_array = upperbound(kst_wm_pkl_web[])
		if k_max_array = 0 then k_max_array = 100
		if k_nr_file_dirlist > k_max_array then k_nr_file_dirlist = k_max_array // meglio non superare la dim dell'array

		for k_file_ind = 1 to k_nr_file_dirlist
		
//			k_file_wm_pklist_web[k_file_ind] = kst_tab_wm_pklist_cfg.cartella_pkl_da_web + "\" + k_file
			kst_wm_pkl_web[k_file_ind].nome_file = trim(kds_dirlist.getitemstring(k_file_ind, "nome"))
			kst_wm_pkl_web[k_file_ind].path_file = kst_tab_wm_pklist_cfg.cartella_pkl_da_web
			
		end for

		k_return = k_nr_file_dirlist

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
		
		finally
			if isvalid(kds_dirlist) then destroy kds_dirlist
			if isvalid(kuf1_wm_pklist_cfg) then destroy kuf1_wm_pklist_cfg
			if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
		
	end try
			


return k_return


end function

public function long get_wm_pklist_web_xml (ref st_wm_pkl_web kst_wm_pkl_web_file, ref st_wm_pkl_web kst_wm_pkl_web_out[]) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Riempie Packing-List Web nalla struct array st_wm_pkl_web[] 
//---	inp: kst_wm_pkl_web_file: nome del file contenente il pkl
//---	out: st_wm_pkl_web_out[]: array con le righe del packing-list-web lette
//---	rit: nr pkl trovati
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
long k_return=0, k_ind_rec=0, k_ind_pkl_etichette=0
string k_rc, k_nome_tag, k_x
int k_rcn
long k_ind, k_nr_tag, k_nr_livello, k_ind_liv1, k_ind_liv2, k_nr_tag_liv1, k_nr_tag_liv2, k_nr_etichetta
st_esito kst_esito
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
st_wm_pkl_web kst_wm_pkl_web, kst_wm_pkl_web_dett[] 
st_tab_contratti kst_tab_contratti
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
kuf_utility kuf1_utility
kuf_contratti kuf1_contratti
kuf_wm_pbdom_xml_pkl_web kuf1_wm_pbdom_xml_pkl_web

 
	try
		kuf1_contratti = create kuf_contratti
		kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg
		kuf1_utility = create kuf_utility
		kuf1_wm_pbdom_xml_pkl_web = create kuf_wm_pbdom_xml_pkl_web

//--- piglia il path di dove sono i Packing-list Web
		kuf1_wm_pklist_cfg.get_wm_pklist_cfg(kst_tab_wm_pklist_cfg)

//---Crea il modello di importazione del XML e imposta il file da importare
		//kuf1_wm_pbdom_xml_pkl_web.crea_object( )
		kuf1_wm_pbdom_xml_pkl_web.set_xml( kst_wm_pkl_web_file.path_file + kkg.path_sep + kst_wm_pkl_web_file.nome_file) 

		kst_wm_pkl_web.nome_file = kst_wm_pkl_web_file.nome_file
		kst_wm_pkl_web.path_file = kst_wm_pkl_web_file.path_file

//--- piglio il numero di tag da leggere
		kuf1_wm_pbdom_xml_pkl_web.set_root( )
		
//--- popolo le righe del st_wm_pkl_web  - Ci sono al massimo per ora 2 livelli nel file XML
		for k_nr_livello = 1 to 2
					
//--- piglio il nome del tag
			k_nome_tag = kuf1_wm_pbdom_xml_pkl_web.get_tag_root(k_nr_livello)
					
//--- quale tag devo riempire
			choose case lower(k_nome_tag)

//--- Questa è la root poi deve fare tutti i TAG a livello 1
				case "pkl"
//--- puglio l'attributo
					kst_wm_pkl_web.idpkl = long(kuf1_wm_pbdom_xml_pkl_web.get_attributo("id", k_nr_livello))

					kuf1_wm_pbdom_xml_pkl_web.set_figlio_liv1() //--- Imposto il livello 1

//--- Ciclo Livello 1
					k_nr_tag_liv1 = kuf1_wm_pbdom_xml_pkl_web.get_nr_tag_liv1( )
					for k_ind_liv1 = 1 to k_nr_tag_liv1
					
						k_nome_tag = kuf1_wm_pbdom_xml_pkl_web.get_tag_liv1(k_ind_liv1) //--- piglio il nome del tag
					
						choose case lower(k_nome_tag)

			//				case "id_utente"
			//				case "stato"
			//				case "data_inserimento_utente"
			//				case "ragione_sociale_utente"
			//				case "indirizzo_utente"
			//				case "cap_utente"
			//				case "localita_utente"
			//				case "provincia_utente"
			//				case "nazione_utente"
			//				case "email_utente"
			//				case "email1_utente"
			//				case "email2_utente"
			//				case "note_utente"
			
							case "#text"			//--- tag non valido
								// niente
								
							case "tipo_invio"
								kst_wm_pkl_web.tipo_invio = kuf1_wm_pbdom_xml_pkl_web.get_valore_liv1(k_ind_liv1) 
							case "id_cliente"
								if isnumber(trim(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv1(k_ind_liv1) )) then
									kst_wm_pkl_web.id_cliente = long(trim(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv1(k_ind_liv1)))
								end if
							case "mandante"
								kst_wm_pkl_web.mandante = kuf1_wm_pbdom_xml_pkl_web.get_valore_liv1(k_ind_liv1)
							case "id_contratto"
								kst_wm_pkl_web.id_contratto = kuf1_wm_pbdom_xml_pkl_web.get_valore_liv1(k_ind_liv1)
							case "data_invio"
								kst_wm_pkl_web.data_invio = kuf1_wm_pbdom_xml_pkl_web.get_valore_liv1(k_ind_liv1)
							case "ora_invio"
								kst_wm_pkl_web.ora_invio = kuf1_wm_pbdom_xml_pkl_web.get_valore_liv1(k_ind_liv1)
							case "contratto_commerciale"
								kst_wm_pkl_web.mc_co = upper(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv1(k_ind_liv1))
							case "capitolato_fornitura"
								kst_wm_pkl_web.sc_cf = upper(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv1(k_ind_liv1))
							case "nr_ddt"
								kst_wm_pkl_web.nrddt = kuf1_wm_pbdom_xml_pkl_web.get_valore_liv1(k_ind_liv1)
							case "data_ddt"
								kst_wm_pkl_web.dtddt = kuf1_wm_pbdom_xml_pkl_web.get_valore_liv1(k_ind_liv1)
							case "nr_tot_colli"
								if isnumber(trim(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv1(k_ind_liv1) )) then
									kst_wm_pkl_web.colliddt = long(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv1(k_ind_liv1))
								end if
							case "ricevente_merce"
								kst_wm_pkl_web.ricevente = upper(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv1(k_ind_liv1))
							case "ricevente_fattura"
								kst_wm_pkl_web.fatturato = upper(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv1(k_ind_liv1)) 
							case "codice_pl"
								kst_wm_pkl_web.codice_pl = upper(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv1(k_ind_liv1)) 
							case "codice_lotto"
								kst_wm_pkl_web.codice_lotto = kuf1_wm_pbdom_xml_pkl_web.get_valore_liv1(k_ind_liv1) 
								kst_wm_pkl_web.codice_lotto = kuf1_utility.u_stringa_pulisci_asc(kst_wm_pkl_web.codice_lotto)  // pulisce la stringa
							case "note_lotto"
								kst_wm_pkl_web.note_lotto = kuf1_wm_pbdom_xml_pkl_web.get_valore_liv1(k_ind_liv1) 
								kst_wm_pkl_web.note_lotto = kuf1_utility.u_stringa_pulisci_asc(kst_wm_pkl_web.note_lotto)  // pulisce la stringa
					
//--- Questo TAG di <no_etichette> è alternativo al tag <pkl_etichette>					
							case "no_etichette"
									k_ind_pkl_etichette++
									kst_wm_pkl_web_dett[k_ind_pkl_etichette].barcode = ""
									kst_wm_pkl_web_dett[k_ind_pkl_etichette].nr_barcode = 0

					
//--- per fare il ramo pkl_etichette	a livello 2				
							case "pkl_etichette"

//---------------------------------------------------------------------------------------------------------------
								k_ind_pkl_etichette++ //--- indice di tutti i dettgli PKL_ETICHETTE
//---------------------------------------------------------------------------------------------------------------

								kuf1_wm_pbdom_xml_pkl_web.set_figlio_liv2() //--- Imposto il livello 2
//--- Ciclo Livello 2
								k_nr_tag_liv2 = kuf1_wm_pbdom_xml_pkl_web.get_nr_tag_liv2( )
								for k_ind_liv2 = 1 to k_nr_tag_liv2
					
									k_nome_tag = kuf1_wm_pbdom_xml_pkl_web.get_tag_liv2(k_ind_liv2) //--- piglio il nome del tag
					
									choose case lower(k_nome_tag)
							
										case "#text"			//--- tag non valido
											// niente
											
										case "nr_barcode"
											if isnumber(trim(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv2(k_ind_liv2) )) then
												kst_wm_pkl_web_dett[k_ind_pkl_etichette].nr_barcode = long(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv2(k_ind_liv2) )
											end if

										case "barcode_item"
											if len(trim(upper(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv2(k_ind_liv2)) )) > 0 then
												kst_wm_pkl_web_dett[k_ind_pkl_etichette].barcode_item = trim(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv2(k_ind_liv2) )
											end if

										case "barcode_lotto"
											if len(trim(upper(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv2(k_ind_liv2)) )) > 0 then
												kst_wm_pkl_web_dett[k_ind_pkl_etichette].barcode_lotto = trim(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv2(k_ind_liv2) )
												kst_wm_pkl_web_dett[k_ind_pkl_etichette].barcode_lotto = kuf1_utility.u_stringa_pulisci_asc(kst_wm_pkl_web_dett[k_ind_pkl_etichette].barcode_lotto)  // pulisce la stringa
											end if

										case "barcode_note"
											if len(trim(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv2(k_ind_liv2) )) > 0 then
												kst_wm_pkl_web_dett[k_ind_pkl_etichette].barcode_note = trim(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv2(k_ind_liv2) )
												kst_wm_pkl_web_dett[k_ind_pkl_etichette].barcode_note = kuf1_utility.u_stringa_pulisci_asc(kst_wm_pkl_web_dett[k_ind_pkl_etichette].barcode_note)  // pulisce la stringa
												
											end if

										case "barcode_peso_netto"
											if len(trim(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv2(k_ind_liv2) )) > 0 then
												k_x = trim(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv2(k_ind_liv2) )
												k_x = kgn_string.u_num_itatousa2(k_x, false)
//												k_ind = pos(k_x, ".")
//												k_x = replace(k_x, k_ind, 1,",")
												if isnumber(k_x) then
													kst_wm_pkl_web_dett[k_ind_pkl_etichette].barcode_peso_netto = dec(k_x)
												end if
											end if

										case "barcode_peso_lordo"
											if len(trim(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv2(k_ind_liv2) )) > 0 then
												k_x = trim(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv2(k_ind_liv2) )
												k_x = kgn_string.u_num_itatousa2(k_x, false)
//												k_ind = pos(k_x, ".")
//												k_x = replace(k_x, k_ind, 1,",")
												if isnumber(k_x) then
													kst_wm_pkl_web_dett[k_ind_pkl_etichette].barcode_peso_lordo = dec(k_x)
												end if
											end if

										case "barcode_qta_scatole"
											if len(trim(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv2(k_ind_liv2) )) > 0 then
												k_x = trim(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv2(k_ind_liv2) )
												k_x = kgn_string.u_num_itatousa2(k_x, false)
//												k_ind = pos(k_x, ".")
//												k_x = replace(k_x, k_ind, 1,",")
												if isnumber(k_x) then
													kst_wm_pkl_web_dett[k_ind_pkl_etichette].barcode_qta_scatole = dec(k_x)
												end if
											end if

										case "barcode_qta_pezzi"
											if len(trim(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv2(k_ind_liv2) )) > 0 then
												k_x = trim(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv2(k_ind_liv2) )
												k_x = kgn_string.u_num_itatousa2(k_x, false)
//												k_ind = pos(k_x, ".")
//												k_x = replace(k_x, k_ind, 1,",")
												if isnumber(k_x) then
													kst_wm_pkl_web_dett[k_ind_pkl_etichette].barcode_qta_pezzi = dec(k_x)
												end if
											end if

										case "barcode_wo"
											if len(trim(upper(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv2(k_ind_liv2)) )) > 0 then
												kst_wm_pkl_web_dett[k_ind_pkl_etichette].barcode_wo = trim(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv2(k_ind_liv2) )
											end if

										case "barcode"
											kst_wm_pkl_web_dett[k_ind_pkl_etichette].barcode = upper(kuf1_wm_pbdom_xml_pkl_web.get_valore_liv2(k_ind_liv2)) 
											
//---------------------------------------------------------------------------------------------------------------
									
																				
									end choose

									
								end for // chiude il ciclo del livello 2
								
						end choose
					end for  // chiude il ciclo del livello 1
					
			end choose


		end for  // chiude il ciclo del livello 0 (xml root)
		

//----------------------------------------------------------------------------------------------------------------------------------------------------------	
//--- Riempie finalmente la ARRAY dei dati del Packing-List
//----------------------------------------------------------------------------------------------------------------------------------------------------------	

		for k_nr_etichetta = 1 to k_ind_pkl_etichette
				
//--- Riempie dati generici
			if isnull(kst_wm_pkl_web.mandante) or len(kst_wm_pkl_web.mandante) = 0 then
				if kst_wm_pkl_web.id_cliente > 0 then
					kst_wm_pkl_web.mandante = string(kst_wm_pkl_web.id_cliente)
				else
					kst_wm_pkl_web.mandante = ""
				end if
			end if
			if isnull(kst_wm_pkl_web.ricevente) or len(kst_wm_pkl_web.ricevente) = 0  then
				kst_wm_pkl_web.ricevente = kst_wm_pkl_web.mandante
			end if
			if isnull(kst_wm_pkl_web.fatturato) or len(kst_wm_pkl_web.fatturato) = 0  then
				kst_wm_pkl_web.fatturato = kst_wm_pkl_web.mandante
			end if
			if isnull(kst_wm_pkl_web.data_invio) or not isdate(kst_wm_pkl_web.data_invio) then
				kst_wm_pkl_web.data_invio = string(kg_dataoggi)
			end if
			if isnull(kst_wm_pkl_web.ora_invio) or not istime(kst_wm_pkl_web.ora_invio) then
				kst_wm_pkl_web.ora_invio = "12:00"
			end if
			if isnull(kst_wm_pkl_web.dtddt) or not isdate(kst_wm_pkl_web.dtddt) then
				kst_wm_pkl_web.dtddt = string(kg_dataoggi)
			end if
			
			if isnull(kst_wm_pkl_web.barcode) or len(kst_wm_pkl_web.barcode) = 0 then
				kst_wm_pkl_web.barcode = ""
			end if
		//--- se è stato indicato il id contratto leggo per prendere il sc-cf e mc-co				
			if len(kst_wm_pkl_web.id_contratto) > 0 and kst_wm_pkl_web.id_contratto <> "0" then
				if isnumber(trim(kst_wm_pkl_web.id_contratto)) then
					kst_tab_contratti.codice = long(kst_wm_pkl_web.id_contratto)
					kst_esito = kuf1_contratti.get_co_cf_pt(kst_tab_contratti)
					if kst_esito.esito = kkg_esito.ok then 
						kst_wm_pkl_web.mc_co = trim(kst_tab_contratti.mc_co )
						kst_wm_pkl_web.sc_cf = trim(kst_tab_contratti.sc_cf )
					end if
				end if
			end if

//--- Dati di dettaglio 
			kst_wm_pkl_web.nr_barcode = kst_wm_pkl_web_dett[k_nr_etichetta].nr_barcode
			kst_wm_pkl_web.barcode_item = kst_wm_pkl_web_dett[k_nr_etichetta].barcode_item
			kst_wm_pkl_web.barcode_lotto = kst_wm_pkl_web_dett[k_nr_etichetta].barcode_lotto
			kst_wm_pkl_web.barcode_note = kst_wm_pkl_web_dett[k_nr_etichetta].barcode_note
			kst_wm_pkl_web.barcode_peso_netto = kst_wm_pkl_web_dett[k_nr_etichetta].barcode_peso_netto
			kst_wm_pkl_web.barcode_peso_lordo = kst_wm_pkl_web_dett[k_nr_etichetta].barcode_peso_lordo
			kst_wm_pkl_web.barcode_qta_scatole = kst_wm_pkl_web_dett[k_nr_etichetta].barcode_qta_scatole
			kst_wm_pkl_web.barcode_qta_pezzi = kst_wm_pkl_web_dett[k_nr_etichetta].barcode_qta_pezzi
			kst_wm_pkl_web.barcode_wo = kst_wm_pkl_web_dett[k_nr_etichetta].barcode_wo
			kst_wm_pkl_web.barcode = kst_wm_pkl_web_dett[k_nr_etichetta].barcode
			

//--- riempio l'array da ritornare
			k_ind_rec++
			kst_wm_pkl_web_out[k_ind_rec] = kst_wm_pkl_web
		
		end for
	
		k_return = k_ind_rec  // torna il nr delle righe del packing

//----------------------------------------------------------------------------------------------------------------------------------------------------------	
	
	catch (uo_exception kuo_exception)
		kst_esito.esito = kkg_esito.bug
		kst_esito.sqlcode = k_rcn
		kst_esito.SQLErrText = "Importazione Nuovi 'Packing-List' XML fallito! (" + string(k_rcn) + ") file: " &
		                         + trim(kst_wm_pkl_web_file.path_file + kkg.path_sep + kst_wm_pkl_web_file.nome_file) // ~n~r "  
		kguo_exception.set_esito(kst_esito)
		throw kuo_exception
		
		
	finally
		destroy kuf1_contratti
		destroy kuf1_wm_pklist_cfg
		destroy kuf1_utility
		destroy kuf1_wm_pbdom_xml_pkl_web
		
	end try
			

return k_return


end function

on kuf_wm_pklist_web.create
call super::create
end on

on kuf_wm_pklist_web.destroy
call super::destroy
end on

event constructor;call super::constructor;//
//--- operazioni iniziali
//
ki_nomeOggetto = trim(this.classname( ))

end event

