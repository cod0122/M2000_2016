$PBExportHeader$kuf_wm_pklist_camion.sru
forward
global type kuf_wm_pklist_camion from kuf_parent
end type
end forward

global type kuf_wm_pklist_camion from kuf_parent
end type
global kuf_wm_pklist_camion kuf_wm_pklist_camion

forward prototypes
public subroutine _readme ()
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function long importa_wm_pklist_camion () throws uo_exception
private function integer get_file_wm_pklist_camion (ref st_wm_pkl_camion kst_wm_pkl_camion[]) throws uo_exception
private function integer set_ds_wm_pklist_camion (readonly st_tab_wm_pklist_camion ast_wm_tab_pklist_camion[], ref uo_ds_std_1 ads_wm_pklist_camion) throws uo_exception
private function long get_wm_pklist_camion (ref st_wm_pkl_camion ast_wm_pkl_camion_file, ref st_tab_wm_pklist_camion ast_tab_wm_pklist_camion[]) throws uo_exception
public function boolean tb_delete (st_tab_wm_pklist_camion ast_tab_wm_pklist_camion) throws uo_exception
public function boolean tb_delete_x_idpkl (st_tab_wm_pklist_camion ast_tab_wm_pklist_camion) throws uo_exception
public function st_esito u_batch_run () throws uo_exception
public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_wm_pklist_camion kst_tab_wm_pklist_camion)
private function long u_tree_stampa_esegui (date a_dataarrivo, long a_id_cliente) throws uo_exception
private function integer u_tree_stampa (st_treeview_data_any kst_treeview_data_any) throws uo_exception
public function integer u_tree_open_anteprima (st_treeview_data_any kst_treeview_data_any, ref datawindow kdw_anteprima) throws uo_exception
public function integer u_tree_open_stampa (st_treeview_data_any kst_treeview_data_any) throws uo_exception
end prototypes

public subroutine _readme ();/* gestione tabella wm_pklist_camion
   data-cliente-camion --> pk list
	linl del pklist e il camion di trasporto
*/	
end subroutine

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//	
boolean k_return
kuf_wm_pklist kuf1_wm_pklist


try
	kuf1_wm_pklist = create kuf_wm_pklist	
	
	k_return = kuf1_wm_pklist.if_sicurezza(ast_open_w)
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	throw kuo_exception
	
finally
	if isvalid(kuf1_wm_pklist) then destroy kuf1_wm_pklist

end try

return k_return

end function

public function long importa_wm_pklist_camion () throws uo_exception;/*
  Importa dati Composizioni Camion da file json
	 inp: 
	 rit: nr. dei righe Camion importate 
*/
long k_return
long k_rows_wm_pkl_camion, k_n_file_tot, k_n_file
long k_rc, k_ctr
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
st_wm_pkl_camion kst_wm_pkl_camion, kst_wm_pkl_camion_file[]
st_tab_wm_pklist_camion kst_tab_wm_pklist_camion[], kst_tab_wm_pklist_camion_delete, kst_tab_wm_pklist_camion_void[]
kuf_file_explorer kuf1_file_explorer //kuf_utility kuf1_utility
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
uo_ds_std_1 kds_wm_pklist_camion


try

	kuf1_file_explorer = create kuf_file_explorer
	kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg
	
	kds_wm_pklist_camion = create uo_ds_std_1
	kds_wm_pklist_camion.dataobject = "ds_wm_pklist_camion"
	kds_wm_pklist_camion.settransobject( kguo_sqlca_db_magazzino )

//--- leggo configurazione x lo scambio dati
	if kuf1_wm_pklist_cfg.get_wm_pklist_cfg(kst_tab_wm_pklist_cfg) then
		
//--- parte l'importazione solo se Operazione di Importazione PACKING-LIST Attiva
		if kst_tab_wm_pklist_cfg.blocca_importa = kuf1_wm_pklist_cfg.ki_blocca_importa_dam2000 then
			
//--- Leggo i nomi dei file da importare
			kst_wm_pkl_camion_file[200].nome_file = " "   // x sicurezza crea intanto una tabellina grande 200 elementi 
			k_n_file_tot = get_file_wm_pklist_camion(kst_wm_pkl_camion_file[]) 

			for k_n_file = 1 to k_n_file_tot 
				
				try 
					kst_wm_pkl_camion.nome_file = kst_wm_pkl_camion_file[k_n_file].nome_file
					kst_wm_pkl_camion.path_file = kst_wm_pkl_camion_file[k_n_file].path_file
				
					if len(trim(kst_wm_pkl_camion.nome_file)) > 0 then   // se c'e' un file....
							
			//--- muove il file CAMION nella cartella dei flussi 'IN LAVORAZIONE'
						if not DirectoryExists (kst_wm_pkl_camion.path_file + kkg.path_sep + "inLav") then CreateDirectory (kst_wm_pkl_camion.path_file+"\inLav") 
						kuf1_file_explorer.u_filemove( kst_wm_pkl_camion.path_file + kkg.path_sep + kst_wm_pkl_camion.nome_file  &
																,kst_wm_pkl_camion.path_file + kkg.path_sep + "inLav" + kkg.path_sep + kst_wm_pkl_camion.nome_file &
																,true)
						kst_wm_pkl_camion.path_file = kst_wm_pkl_camion.path_file + kkg.path_sep + "inLav"
								
			//--- Legge i dati CAMION dal file in formato JSON
						kst_tab_wm_pklist_camion[] = kst_tab_wm_pklist_camion_void[]
						get_wm_pklist_camion(kst_wm_pkl_camion, kst_tab_wm_pklist_camion[])
						if upperbound(kst_tab_wm_pklist_camion[]) > 0 then
							// popola il DS con i dati da caricare dei pklist del file
							k_rows_wm_pkl_camion = set_ds_wm_pklist_camion(kst_tab_wm_pklist_camion[] , kds_wm_pklist_camion) 
							if k_rows_wm_pkl_camion > 0 then
								
			//--- rimuove i dati di IDPKL precedenti per ricaricarli perchè può essere cambiata la composizione del CAMION
								kst_tab_wm_pklist_camion_delete.idpkl = kds_wm_pklist_camion.getitemnumber(1, "idpkl")
								kst_tab_wm_pklist_camion_delete.st_tab_g_0.esegui_commit = "N"
								tb_delete_x_idpkl(kst_tab_wm_pklist_camion_delete)
								for k_ctr = 2 to k_rows_wm_pkl_camion
									if kds_wm_pklist_camion.getitemnumber(k_ctr - 1, "idpkl") &
												<> kds_wm_pklist_camion.getitemnumber(k_ctr, "idpkl") then
										kst_tab_wm_pklist_camion_delete.idpkl = kds_wm_pklist_camion.getitemnumber(k_ctr, "idpkl")
										kst_tab_wm_pklist_camion_delete.st_tab_g_0.esegui_commit = "N"
										tb_delete_x_idpkl(kst_tab_wm_pklist_camion_delete)
									end if
								next
								k_ctr = kds_wm_pklist_camion.update( )  // aggiorna
								if k_ctr < 0 then
									kguo_exception.set_st_esito_err_ds(kds_wm_pklist_camion, "Errore in aggiornamento dati Composizione Camion. " &
														+ kkg.acapo + "File: '" + trim(kst_wm_pkl_camion_file[k_n_file].nome_file) + "' è stato scartato!" &
														+ kkg.acapo + "La prima riga da aggiornare ha data di arrivo " + string(kds_wm_pklist_camion.getitemdate(1, "dataarrivo")) &
														+ ", Id Packing List sul file " + string(kds_wm_pklist_camion.getitemnumber(1, "idpkl")) + ". ")
									throw kguo_exception
								end if
								kguo_sqlca_db_magazzino.db_commit( )
								
								k_return += kds_wm_pklist_camion.rowcount()
								
							end if
						end if
						
//--- muove il file nella cartella dei flussi IMPORTATI	
						kst_wm_pkl_camion.path_file = kst_wm_pkl_camion_file[k_n_file].path_file
						if not DirectoryExists (kst_wm_pkl_camion.path_file + kkg.path_sep + "importato") then CreateDirectory (kst_wm_pkl_camion.path_file + kkg.path_sep + "importato") 
						kuf1_file_explorer.u_filemove( kst_wm_pkl_camion.path_file + kkg.path_sep + "inLav" + kkg.path_sep + kst_wm_pkl_camion.nome_file  &
																,kst_wm_pkl_camion.path_file + kkg.path_sep + "importato" + kkg.path_sep + kst_wm_pkl_camion.nome_file &
																,true)
						
					end if
					
				catch (uo_exception kuo1_exception)
					kuo1_exception.scrivi_log()
//--- muove il file CAMION nella cartella dei flussi 'IN LAVORAZIONE'
					if not DirectoryExists (kst_wm_pkl_camion.path_file + kkg.path_sep + "scartati") then CreateDirectory (kst_wm_pkl_camion.path_file+"\scartati") 
					kuf1_file_explorer.u_filemove(kst_wm_pkl_camion_file[k_n_file].path_file + kkg.path_sep + "inLav" + kkg.path_sep + kst_wm_pkl_camion_file[k_n_file].nome_file &
														,kst_wm_pkl_camion_file[k_n_file].path_file + kkg.path_sep + "scartati" + kkg.path_sep + kst_wm_pkl_camion_file[k_n_file].nome_file &
														,true)
				end try
	
			end for
		else
			kguo_exception.inizializza( )
			kguo_exception.set_tipo( kguo_exception.KK_st_uo_exception_tipo_non_eseguito )
			kguo_exception.setmessage( "NON eseguito. Se si vuole importare i dati di Composizione dei Camion, Attivare le Operazioni in Proprietà Packing-List da Proprietà della Procedura.")
			throw kguo_exception
		end if
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log()
	throw kuo_exception
	
finally
	if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
	if isvalid(kuf1_wm_pklist_cfg) then destroy kuf1_wm_pklist_cfg
	if isvalid(kds_wm_pklist_camion) then destroy kds_wm_pklist_camion
	
end try


return k_return


end function

private function integer get_file_wm_pklist_camion (ref st_wm_pkl_camion kst_wm_pkl_camion[]) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Trova i nomi file di dati CAMION presenti nella cartella di importazione
//---	inp: st_wm_pkl_camion vuoto
//---	out: st_wm_pkl_camion array con il path e il nome da importare
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
kuf_file_explorer kuf1_file_explorer
 
 
	try
		kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg
		kuf1_file_explorer = create kuf_file_explorer

//--- piglia il path di dove sono i Packing-list Web
		kuf1_wm_pklist_cfg.get_wm_pklist_cfg(kst_tab_wm_pklist_cfg)

//--- piglia l'elenco dei file xml contenuti nella cartella
		kds_dirlist = kuf1_file_explorer.DirList( &
					kuf1_file_explorer.u_add_path_and_filename(kst_tab_wm_pklist_cfg.cartella_pkl_camion, "*.json"))
			
		k_nr_file_dirlist = kds_dirlist.rowcount( )

		k_max_array = upperbound(kst_wm_pkl_camion[])
		if k_max_array = 0 then k_max_array = 200
		if k_nr_file_dirlist > k_max_array then k_nr_file_dirlist = k_max_array // meglio non superare la dim dell'array

		for k_file_ind = 1 to k_nr_file_dirlist
		
			kst_wm_pkl_camion[k_file_ind].nome_file = trim(kds_dirlist.getitemstring(k_file_ind, "nome"))
			kst_wm_pkl_camion[k_file_ind].path_file = kst_tab_wm_pklist_cfg.cartella_pkl_camion
			
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

private function integer set_ds_wm_pklist_camion (readonly st_tab_wm_pklist_camion ast_wm_tab_pklist_camion[], ref uo_ds_std_1 ads_wm_pklist_camion) throws uo_exception;/*
 Imposta i dati dei camion
 inp: st_wm_pklist_camion[]  array elenco 
      ds_wm_pklist_camion    datastore da popolare (out)
 rit: n. di righe del ds
*/
long k_row, k_rows, k_row_ds


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

	ads_wm_pklist_camion.reset()
	
	k_rows = upperbound(ast_wm_tab_pklist_camion)
	for k_row = 1 to k_rows
			
		if ast_wm_tab_pklist_camion[k_row].idpkl > 0 then
			k_row_ds = ads_wm_pklist_camion.insertrow(0)
			ads_wm_pklist_camion.setitem(k_row_ds, "id_wm_pklist_camion", 0)
			ads_wm_pklist_camion.setitem(k_row_ds, "idpkl", ast_wm_tab_pklist_camion[k_row].idpkl)
			ads_wm_pklist_camion.setitem(k_row_ds, "dataarrivo", ast_wm_tab_pklist_camion[k_row].dataarrivo)
			ads_wm_pklist_camion.setitem(k_row_ds, "seqcamion", ast_wm_tab_pklist_camion[k_row].seqcamion)
			ads_wm_pklist_camion.setitem(k_row_ds, "totpallet", ast_wm_tab_pklist_camion[k_row].totpallet)
			ads_wm_pklist_camion.setitem(k_row_ds, "id_cliente", ast_wm_tab_pklist_camion[k_row].id_cliente)
			ads_wm_pklist_camion.setitem(k_row_ds, "x_utente", kguf_data_base.prendi_x_utente( ))
			ads_wm_pklist_camion.setitem(k_row_ds, "x_datins", kguf_data_base.prendi_x_datins( ))
		end if
		
	end for
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_row_ds

end function

private function long get_wm_pklist_camion (ref st_wm_pkl_camion ast_wm_pkl_camion_file, ref st_tab_wm_pklist_camion ast_tab_wm_pklist_camion[]) throws uo_exception;/*
Riempie Packing-List Web nalla struct array st_wm_pkl_camion[] 
	inp: st_wm_pkl_camion + _file: nome del file contenente i dati
	out: st_wm_pkl_camion + _out[]: array con i dati dei Camion 
	rit: nr pkl caricati nell'array
*/
long k_row, k_return
long k_root, k_item_root, k_item
long k_n_root, k_n_clienti, k_n_arrivi, k_n_camion, k_n_packinglist
long k_item_camion, k_item_cliente, k_item_packinglist
long k_loop1,k_loop2,k_loop3, k_loop4, k_loop5, k_loop6
string ls_key, k_value
string k_error
st_wm_pkl_camion kst_wm_pkl_camion
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
JsonParser kJsonParser  
 
	try
		
		kguo_exception.inizializza(this.classname())

		kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg
		kJsonParser = create JsonParser

//--- piglia il path di dove sono i dati CAMION
		kuf1_wm_pklist_cfg.get_wm_pklist_cfg(kst_tab_wm_pklist_cfg)

//--- Carica i dati dal file JSON da importare
		k_error = kJsonParser.loadfile(ast_wm_pkl_camion_file.path_file + kkg.path_sep + ast_wm_pkl_camion_file.nome_file) 
		if len(k_error) > 0 then
			kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
			kguo_exception.kist_esito.sqlerrtext = "Errore in lettura del file dati dei Camion dei packing-list " &
										+ kkg.acapo + "Errore: " + k_error &
										+ kkg.acapo + "File: " + ast_wm_pkl_camion_file.path_file + kkg.path_sep + ast_wm_pkl_camion_file.nome_file
			throw kguo_exception
		end if

		kst_wm_pkl_camion.nome_file = ast_wm_pkl_camion_file.nome_file
		kst_wm_pkl_camion.path_file = ast_wm_pkl_camion_file.path_file

		k_row = 1

		k_root = kJsonParser.getrootitem( ) // Obtains the handle of root item

//-- forse ci possono essere più oggetti in un unico file
		for k_loop1 = 1 to kJsonParser.getchildcount(k_root)   // dataArrivo

//Obtains the other column data in a loop
			k_item_root = kjsonparser.getchilditem( k_root, k_loop1)
			k_n_root = kjsonparser.getchildcount( k_item_root)
			for k_loop2 = 1 to k_n_root
         	k_item = kjsonparser.getchilditem( k_item_root, k_loop2)
           	ls_key = kjsonparser.getchildkey( k_item_root, k_loop2)
				if lower(ls_key) = "dataarrivo" then
					ast_tab_wm_pklist_camion[k_row].dataarrivo = date(trim(kjsonparser.getitemstring(k_item_root,ls_key)))
				end if

				if lower(ls_key) = "arrivi" then
					k_item = kjsonparser.GetItemArray(k_item_root, ls_key)
					k_n_arrivi = kjsonparser.getchildcount(k_item)
					for k_loop3 = 1 to k_n_arrivi
						k_item = kjsonparser.getchilditem( k_item, k_loop3)
		           	ls_key = kjsonparser.getchildkey( k_item, k_loop3)
						  
						if lower(ls_key) = "clienti" then
							k_item_cliente = kjsonparser.GetItemArray(k_item, ls_key)
							k_n_clienti = kjsonparser.getchildcount(k_item_cliente)
							for k_loop4 = 1 to k_n_clienti
								k_item = kjsonparser.getchilditem( k_item_cliente, k_loop4)
								ls_key = kjsonparser.getchildkey( k_item, k_loop4)
								if lower(ls_key) = "idcliente" then
									ast_tab_wm_pklist_camion[k_row].id_cliente = long(trim(kjsonparser.getitemstring(k_item,ls_key)))
								end if
								
								k_item_camion = kjsonparser.GetItemArray(k_item, "camion")
								k_n_camion = kjsonparser.getchildcount(k_item_camion)
								for k_loop5 = 1 to k_n_camion
									k_item = kjsonparser.getchilditem( k_item_camion, k_loop5)
									ls_key = kjsonparser.getchildkey( k_item, k_loop5)
									if lower(ls_key) = "seqcamion" then
										ast_tab_wm_pklist_camion[k_row].seqCamion = integer(trim(kjsonparser.getitemstring(k_item,ls_key)))
									end if
									
									k_item_packinglist = kjsonparser.GetItemArray(k_item, "packinglist")
									k_n_packinglist = kjsonparser.getchildcount(k_item_packinglist)
									for k_loop6 = 1 to k_n_packinglist
										
										// prepara un eventuale altra riga
										ast_tab_wm_pklist_camion[k_row + 1] = ast_tab_wm_pklist_camion[k_row] 

										k_item = kjsonparser.getchilditem( k_item_packinglist, k_loop6)
               					k_value = trim(kjsonparser.GetItemString(k_item, "idpkl"))
										if k_value > " " then
											ast_tab_wm_pklist_camion[k_row].idpkl = long(k_value)
										end if
									   k_value = trim(kjsonparser.GetItemString(k_item, "totpallet"))
										if k_value > " " then
											ast_tab_wm_pklist_camion[k_row].totPallet = integer(k_value)
										end if
										
										k_row ++
										
									next
									
								next
							next
						end if
					next
				end if
			next //Finish processing one row
		next//Start processing next row//		
	
		if k_row > 0 then
			k_return = k_row -1  // torna il nr delle righe del packing
		end if

//----------------------------------------------------------------------------------------------------------------------------------------------------------	
	
	catch (uo_exception kuo_exception)
		throw kuo_exception
		
		
	finally
		destroy kuf1_wm_pklist_cfg
		if isvalid(kJsonParser) then destroy kJsonParser
		
	end try			

return k_return


end function

public function boolean tb_delete (st_tab_wm_pklist_camion ast_tab_wm_pklist_camion) throws uo_exception;/*
 Cancella il rek dalla tabella
	inp: st_tab_wm_pklist_camion.id_wm_pklist_camion
	rit: true = rimosso
*/
boolean k_return


try
	kguo_exception.inizializza(this.classname())

	delete from wm_pklist_camion
		where id_wm_pklist_camion = :ast_tab_wm_pklist_camion.id_wm_pklist_camion 
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
						"Errore in Cancellazione dati Composizione del Camion id " + string(ast_tab_wm_pklist_camion.id_wm_pklist_camion))		
		throw kguo_exception
	end if
	
	if ast_tab_wm_pklist_camion.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_wm_pklist_camion.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if

	k_return = true
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally

	
end try

return k_return

end function

public function boolean tb_delete_x_idpkl (st_tab_wm_pklist_camion ast_tab_wm_pklist_camion) throws uo_exception;/*
 Cancella tutti le righe dalla tabella per IDPKL (id indicato nel file)
	inp: st_tab_wm_pklist_camion.idpkl
	rit: true = rimosse
*/
boolean k_return


try
	kguo_exception.inizializza(this.classname())

	delete from wm_pklist_camion
		where idpkl = :ast_tab_wm_pklist_camion.idpkl
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
						"Errore in Cancellazione dati Composizione del Camion per il valore idPkl " + string(ast_tab_wm_pklist_camion.idpkl))		
		throw kguo_exception
	end if
	
	if ast_tab_wm_pklist_camion.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_wm_pklist_camion.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if

	k_return = true
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally

	
end try

return k_return

end function

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
st_esito kst_esito
long k_ctr


try 

	kst_esito = kguo_exception.inizializza(this.classname())

// call della routine che esegue il batch
	k_ctr = this.importa_wm_pklist_camion( )
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Operazione conclusa correttamente." + "Sono state caricate " + string(k_ctr) + " righe dai file di Composizione Camion dei Packing-List. Funzione: " + this.get_id_programma(kkg_flag_modalita.batch)
	else
		kst_esito.SQLErrText = "Operazione conclusa. Nessun file di Composizione Camion dei Packing-List da importare. Funzione: " + this.get_id_programma(kkg_flag_modalita.batch)
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try

return kst_esito
end function

public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0, k_rows=0, k_row=0
integer k_pic_open, k_pic_close
string k_tipo_oggetto_padre
string k_oggetto_corrente, k_tipo_oggetto_figlio
string k_alfa
integer k_ctr
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_wm_pklist_camion kst_tab_wm_pklist_camion
st_tab_clienti kst_tab_clienti
st_tab_meca kst_tab_meca
st_tab_treeview kst_tab_treeview
treeviewitem ktvi_treeviewitem
uo_ds_std_1 kds_wm_pklist_camion


//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
	
//--- Acchiappo handle dell'item
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle

	if k_handle_item_padre > 0 then
		kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
		kst_treeview_data = ktvi_treeviewitem.data
		k_tipo_oggetto_padre = kst_treeview_data.oggetto
	else
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(RootTreeItem!, 0)
		k_tipo_oggetto_padre = k_tipo_oggetto
	end if


//--- Lettera di Estrazione		
   kst_treeview_data_any = kst_treeview_data.struttura 
   kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
	k_alfa = upper(trim(kst_tab_treeview.id))
	if k_alfa > " " then
		if isdate(k_alfa) then
			kst_tab_wm_pklist_camion.dataarrivo = date(k_alfa)
		end if
	else
	   kst_tab_wm_pklist_camion.dataarrivo = RelativeDate(today(), -365)
	end if

	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto_padre, kuf1_treeview.kist_treeview_oggetto)
	
//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = "0" then
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open
		end if

//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)
			 
		kds_wm_pklist_camion = create uo_ds_std_1
		kds_wm_pklist_camion.dataobject = "ds_wm_pklist_camion_l"
		kds_wm_pklist_camion.settransobject(kguo_sqlca_db_magazzino)
		k_rows = kds_wm_pklist_camion.retrieve(kst_tab_wm_pklist_camion.dataarrivo)


			for k_row = 1 to k_rows
//			do while sqlca.sqlcode = 0
				kst_tab_wm_pklist_camion.id_wm_pklist_camion = kds_wm_pklist_camion.getitemnumber( k_row, "id_wm_pklist_camion")
				kst_tab_wm_pklist_camion.idpkl = kds_wm_pklist_camion.getitemnumber( k_row, "idpkl")
				kst_tab_wm_pklist_camion.dataarrivo = kds_wm_pklist_camion.getitemdate( k_row, "dataarrivo")
				kst_tab_wm_pklist_camion.id_cliente = kds_wm_pklist_camion.getitemnumber( k_row, "pklist_id_cliente") 
				kst_tab_wm_pklist_camion.seqcamion = kds_wm_pklist_camion.getitemnumber( k_row, "seqcamion")
				kst_tab_wm_pklist_camion.totpallet = kds_wm_pklist_camion.getitemnumber( k_row, "totpallet")
				kst_tab_clienti.codice = kds_wm_pklist_camion.getitemnumber( k_row, "clie_3")
				kst_tab_clienti.rag_soc_10 = kds_wm_pklist_camion.getitemstring( k_row, "rag_soc_10")
				kst_tab_clienti.e1ancodrs = kds_wm_pklist_camion.getitemstring( k_row, "e1ancodrs")
				kst_tab_meca.id = kds_wm_pklist_camion.getitemnumber( k_row, "id_meca")
				kst_tab_meca.num_int = kds_wm_pklist_camion.getitemnumber( k_row, "num_int")
				kst_tab_meca.data_int = kds_wm_pklist_camion.getitemdate( k_row, "data_int")
				kst_tab_meca.data_ent = kds_wm_pklist_camion.getitemdatetime( k_row, "data_ent")
				kst_tab_meca.clie_1 = kds_wm_pklist_camion.getitemnumber( k_row, "clie_1")
				kst_tab_meca.clie_2 = kds_wm_pklist_camion.getitemnumber( k_row, "clie_2")
				kst_tab_meca.clie_3 = kds_wm_pklist_camion.getitemnumber( k_row, "clie_3")
			
				kst_treeview_data.handle = 0
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio
				kst_treeview_data.struttura = kst_treeview_data_any

//			   klvi_listviewitem.data = kst_treeview_data

//				this.if_isnull(kst_tab_wm_pklist_camion)
		
				kst_treeview_data_any.st_tab_wm_pklist_camion = kst_tab_wm_pklist_camion
				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
				kst_treeview_data_any.st_tab_meca = kst_tab_meca
				
				kst_treeview_data.struttura = kst_treeview_data_any
				
				kst_treeview_data.label = & 
					                  string(kst_tab_wm_pklist_camion.dataarrivo, "dd mmm yy") &
											+ " - " + string(kst_tab_wm_pklist_camion.idpkl)

				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
				kst_treeview_data.handle = k_handle_item_padre
	
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

			next
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
st_tab_wm_pklist_camion kst_tab_wm_pklist_camion
st_tab_clienti kst_tab_clienti, kst_tab_clienti_ricev
st_tab_meca kst_tab_meca
st_tab_treeview kst_tab_treeview
kuf_clienti kuf1_clienti
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_profilestring_ini kst_profilestring_ini



try		 
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
		k_campo[k_ind] = "Codice Pk-List (Mandante)"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Data Camion "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Camion "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Id "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "colli "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Caricato da "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "stato "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Lotto "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Id ASN "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Cliente "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "nominativo cliente"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Mandante "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Ricevente "
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

			kst_tab_wm_pklist_camion = kst_treeview_data_any.st_tab_wm_pklist_camion
			kst_tab_meca = kst_treeview_data_any.st_tab_meca
			kst_tab_clienti = kst_treeview_data_any.st_tab_clienti

			klvi_listviewitem.data = kst_treeview_data

			klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
			
			klvi_listviewitem.selected = false
			
			k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)

			k_ind=1
			kuf1_treeview.u_kilv_lv1_setitem(k_ctr, k_ind, string(kst_tab_wm_pklist_camion.idpkl) + "/" + trim(kst_tab_clienti.e1ancodrs))
			k_ind++
			kuf1_treeview.u_kilv_lv1_setitem(k_ctr, k_ind, string(kst_tab_wm_pklist_camion.dataarrivo, "dd mmm yy" ))
			k_ind++
			kuf1_treeview.u_kilv_lv1_setitem(k_ctr, k_ind, string(kst_tab_wm_pklist_camion.seqcamion))
			k_ind++
			kuf1_treeview.u_kilv_lv1_setitem(k_ctr, k_ind, string(kst_tab_wm_pklist_camion.id_wm_pklist_camion))
			k_ind++
			kuf1_treeview.u_kilv_lv1_setitem(k_ctr, k_ind, string(kst_tab_wm_pklist_camion.totpallet, "#" ))
			k_ind++
			kuf1_treeview.u_kilv_lv1_setitem(k_ctr, k_ind, string(kst_tab_wm_pklist_camion.id_cliente, "#" ))

			k_ind++
			if kst_tab_meca.id > 0 then
				if date(kst_tab_meca.data_ent) > kkg.data_zero then
					k_stato = "Già Entrato "
				else
					k_stato = "In Attesa "
				end if
			else
				k_stato = "Non Entrato "
			end if
			kuf1_treeview.u_kilv_lv1_setitem(k_ctr, k_ind, k_stato)
			
			k_ind++
			kuf1_treeview.u_kilv_lv1_setitem(k_ctr, k_ind, string(kst_tab_meca.num_int) + "/" + string(kst_tab_meca.data_int, "yyyy"))
			k_ind++
			kuf1_treeview.u_kilv_lv1_setitem(k_ctr, k_ind, string(kst_tab_meca.id, "#" ))
			
			k_ind++
			kuf1_treeview.u_kilv_lv1_setitem(k_ctr, k_ind, string(kst_tab_clienti.codice, "#" ))
			k_ind++
			kuf1_treeview.u_kilv_lv1_setitem(k_ctr, k_ind, trim(kst_tab_clienti.rag_soc_10))
			k_ind++
			kuf1_treeview.u_kilv_lv1_setitem(k_ctr, k_ind, string(kst_tab_meca.clie_1, "#"))

			k_ind++
			kuf1_treeview.u_kilv_lv1_setitem(k_ctr, k_ind, string(kst_tab_meca.clie_2, "#"))

			if kst_tab_meca.clie_2 <> kst_tab_meca.clie_3 then
				kst_tab_clienti_ricev.rag_soc_10 = ""
				kst_tab_clienti_ricev.codice = kst_tab_meca.clie_2
				kuf1_clienti.get_nome(kst_tab_clienti_ricev)
			else
				kst_tab_clienti_ricev.rag_soc_10 = kst_tab_clienti.rag_soc_10
			end if
			k_ind++
			kuf1_treeview.u_kilv_lv1_setitem(k_ctr, k_ind, trim(kst_tab_clienti_ricev.rag_soc_10))
						
//--- Leggo rec next dalla tree				
			k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)

		loop
		
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
		
catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()

finally 
//	if isvalid(kuf1_clienti) then	destroy kuf1_clienti
	
end try

return k_return

end function

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_wm_pklist_camion kst_tab_wm_pklist_camion);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore  di  anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility

try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
	this.if_sicurezza(kkg_flag_modalita.anteprima)

	if kst_tab_wm_pklist_camion.id_wm_pklist_camion > 0 then
	
		kdw_anteprima.dataobject = "d_wm_pklist_camion_1"		
		kdw_anteprima.settransobject(sqlca)

		k_rc=kdw_anteprima.retrieve(kst_tab_wm_pklist_camion.id_wm_pklist_camion )

	else
		kguo_exception.kist_esito.sqlcode = 0
		kguo_exception.kist_esito.SQLErrText = "Nessun Camion da Packing-List da visualizzare: ~n~r" + "nessun Codice indicato"
		kguo_exception.kist_esito.esito = kkg_esito.bug
		
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )	
	
finally
	SetPointer(kkg.pointer_default)

end try


return kguo_exception.kist_esito

end function

private function long u_tree_stampa_esegui (date a_dataarrivo, long a_id_cliente) throws uo_exception;//
string k_errore
long k_return
st_stampe kst_stampe
long k_row
uo_ds_std_1 kds_1


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

	if a_id_cliente > 0 and a_dataarrivo > kkg.data_no then
	else
		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_dati_insufficienti
		kguo_exception.kist_esito.sqlerrtext = "Manca codice cliente o data di arrivo, stampa interrotta!"
		throw kguo_exception
	end if

	kds_1 = create uo_ds_std_1
	kds_1.dataobject = "d_wm_pklist_camion_etichetta"
	kds_1.settransobject( kguo_sqlca_db_magazzino )
	k_row = kds_1.retrieve(a_dataarrivo, a_id_cliente)
	
	if k_row < 0 then
		kguo_exception.inizializza(this.classname())
		kguo_exception.set_st_esito_err_ds(kds_1, "Errore in lettura Paking-List Camion per la stampa Avvisi Camion in arrivo, data arrivo: " &
								+ string(a_dataarrivo) + ", codice cliente: " + string(a_id_cliente))
		throw kguo_exception
	end if
	
//--- STAMPA
	kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore
	kst_stampe.ds_print = kds_1
	kst_stampe.titolo = "Stampa Avvisi Camion"

	k_errore = string(kGuf_data_base.stampa_dw(kst_stampe))
		
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)
	if isvalid(kds_1) then destroy kds_1

end try

return k_return

end function

private function integer u_tree_stampa (st_treeview_data_any kst_treeview_data_any) throws uo_exception;/*
   Stampa Etichette per verifica Camion
*/
integer k_return


try
	kguo_exception.inizializza(this.classname())

	k_return = u_tree_stampa_esegui(kst_treeview_data_any.st_tab_wm_pklist_camion.dataarrivo, &
									kst_treeview_data_any.st_tab_meca.clie_3) 
		

catch(uo_exception kuo_exception)
	throw kguo_exception

finally
	
end try

 
return k_return

end function

public function integer u_tree_open_anteprima (st_treeview_data_any kst_treeview_data_any, ref datawindow kdw_anteprima) throws uo_exception;//
//--- Chiama applicazioni di dettaglio
//
integer k_return = 0
datastore kds_1


if kst_treeview_data_any.st_tab_wm_pklist_camion.id_wm_pklist_camion > 0 then

	kds_1 = create datastore
	kguo_exception.kist_esito = anteprima ( kds_1, kst_treeview_data_any.st_tab_wm_pklist_camion)
	if kguo_exception.kist_esito.esito = kkg_esito.db_ko then
		throw kguo_exception  //.messaggio_utente( )
	else

		kdw_anteprima.dataobject = kds_1.dataobject
		kds_1.rowscopy( 1, kds_1.rowcount( ) , primary!, kdw_anteprima, 1, primary!)
		
	end if
	destroy kds_1

end if	
 
 
return k_return

end function

public function integer u_tree_open_stampa (st_treeview_data_any kst_treeview_data_any) throws uo_exception;//
//--- Chiama applicazioni di dettaglio
//
integer k_return = 0, k_rc = 0
datastore kds_1


if kst_treeview_data_any.st_tab_wm_pklist_camion.id_wm_pklist_camion > 0 then

	u_tree_stampa(kst_treeview_data_any)

//			if not this.u_open( kst_open_w.flag_modalita ) then  //Apre le Varie Funzioni
//				k_return = 1
//				
//				kguo_exception.setmessage( "Operazione di Accesso al Camion del Packing List fallita. ")
//				kguo_exception.messaggio_utente( )
//			end if
				
					
end if	
 
 
return k_return

end function

on kuf_wm_pklist_camion.create
call super::create
end on

on kuf_wm_pklist_camion.destroy
call super::destroy
end on

