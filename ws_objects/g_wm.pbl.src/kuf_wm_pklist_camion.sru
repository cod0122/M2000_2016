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
st_tab_wm_pklist_camion kst_tab_wm_pklist_camion[], kst_tab_wm_pklist_camion_delete
kuf_utility kuf1_utility
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
uo_ds_std_1 kds_wm_pklist_camion


try

	kuf1_utility = create kuf_utility
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
						if not DirectoryExists (kst_wm_pkl_camion.path_file+"\inLav") then CreateDirectory (kst_wm_pkl_camion.path_file+"\inLav") 
						kuf1_utility.u_filemovereplace( kst_wm_pkl_camion.path_file +"\"+  kst_wm_pkl_camion.nome_file,  &
																							 kst_wm_pkl_camion.path_file+"\inLav\"+kst_wm_pkl_camion.nome_file)
						kst_wm_pkl_camion.path_file = kst_wm_pkl_camion.path_file+"\inLav"
								
			//--- Legge i dati CAMION dal file in formato JSON
						get_wm_pklist_camion(kst_wm_pkl_camion, kst_tab_wm_pklist_camion[])
						if upperbound(kst_tab_wm_pklist_camion[]) > 0 then
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
								k_ctr = kds_wm_pklist_camion.update( )
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
						if not DirectoryExists (kst_wm_pkl_camion.path_file+"\importato") then CreateDirectory (kst_wm_pkl_camion.path_file+"\importato") 
						kuf1_utility.u_filemovereplace( kst_wm_pkl_camion.path_file +"\inLav\"+kst_wm_pkl_camion.nome_file,  &
																				 kst_wm_pkl_camion.path_file+"\importato\"+kst_wm_pkl_camion.nome_file)
						
					end if
					
				catch (uo_exception kuo1_exception)
					kuo1_exception.scrivi_log()
					kuf1_utility.u_filemovereplace(kst_wm_pkl_camion_file[k_n_file].path_file +"\inLav\"+kst_wm_pkl_camion_file[k_n_file].nome_file,  &
																				 kst_wm_pkl_camion_file[k_n_file].path_file+"\scartati\"+kst_wm_pkl_camion_file[k_n_file].nome_file)
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
	if isvalid(kuf1_utility) then destroy kuf1_utility
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

on kuf_wm_pklist_camion.create
call super::create
end on

on kuf_wm_pklist_camion.destroy
call super::destroy
end on

