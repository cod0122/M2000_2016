$PBExportHeader$kuf_meca_ddt_in.sru
forward
global type kuf_meca_ddt_in from kuf_parent
end type
end forward

global type kuf_meca_ddt_in from kuf_parent
end type
global kuf_meca_ddt_in kuf_meca_ddt_in

type variables
//
private constant string kki_profile_ini_path = "path_import_ddt_in"

end variables

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
private function any get_docpath () throws uo_exception
private function any get_path_all (ref st_tab_meca_ddt_in ast_tab_meca_ddt_in) throws uo_exception
public function long get_id_meca (ref st_tab_meca_ddt_in ast_tab_meca_ddt_in) throws uo_exception
public function boolean if_exists_x_id_meca (ref st_tab_meca_ddt_in ast_tab_meca_ddt_in) throws uo_exception
public function boolean if_exists_x_file_name (st_tab_meca_ddt_in ast_tab_meca_ddt_in, string a_nome_file) throws uo_exception
public function long get_id_memo (ref st_tab_meca_ddt_in ast_tab_meca_ddt_in) throws uo_exception
private function string u_build_file_relative_path (st_tab_meca_ddt_in ast_tab_meca_ddt_in) throws uo_exception
public subroutine tb_delete_x_id_meca (st_tab_meca_ddt_in ast_tab_meca_ddt_in) throws uo_exception
public subroutine tb_add (st_tab_meca_ddt_in ast_tab_meca_ddt_in) throws uo_exception
public subroutine tb_delete_x_id_memo (st_tab_meca_ddt_in ast_tab_meca_ddt_in) throws uo_exception
private function any u_import_file_change_name (string a_file[], string a_file_name_dest_init) throws uo_exception
private function any u_import_get_file (string a_path) throws uo_exception
private function string u_import_to_path (st_tab_meca_ddt_in kst_tab_meca_ddt_in) throws uo_exception
public subroutine _readme ()
private function string u_import_choose_path () throws uo_exception
public function any import_file_to_folder (st_tab_meca_ddt_in ast_tab_meca_ddt_in, string a_file_import[]) throws uo_exception
public function any import_folder_choosen (st_tab_meca_ddt_in kst_tab_meca_ddt_in) throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
boolean k_return
kuf_armo kuf1_armo


try
	kuf1_armo = create kuf_armo
	
	k_return = kuf1_armo.if_sicurezza(ast_open_w)
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally 
	destroy kuf1_armo

end try

return k_return

end function

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;//
//=== 
//====================================================================
//=== Attiva LINK cliccato 
//===
//=== Par. Inut: 
//===               datawindow su cui è stato attivato il LINK
//===               nome campo di LINK
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
long k_rc
string k_rcx
boolean k_return=false
string k_path[], k_file_opened[], k_path_dst
int k_nfile_opened
st_tab_meca_ddt_in kst_tab_meca_ddt_in
st_tab_memo_link kst_tab_memo_link
st_esito kst_esito
datastore kdsi_elenco_output, kds_1   //ds da passare alla windows di elenco
st_open_w kst_open_w 
kuf_menu_window kuf1_menu_window
kuf_memo_link kuf1_memo_link


try
	SetPointer(kkg.pointer_attesa)

	k_return = if_sicurezza(kkg_flag_modalita.visualizzazione)

	//kdsi_elenco_output = create datastore
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if adw_link.getrow() = 0 then
	else
		choose case a_campo_link
	
			case "meca_ddt_in_view_all"
				if adw_link.describe("id_meca.x") <> "!" then
					kst_tab_meca_ddt_in.id_meca = adw_link.getitemnumber(adw_link.getrow(), "id_meca")
					if kst_tab_meca_ddt_in.id_meca > 0 then
						k_return = true
					end if
				end if
	
			case "meca_ddt_in_add"
				if adw_link.describe("id_meca.x") <> "!" then
					kst_tab_meca_ddt_in.id_meca = adw_link.getitemnumber(adw_link.getrow(), "id_meca")
					if kst_tab_meca_ddt_in.id_meca > 0 then
						k_return = true
					end if
				end if
		end choose
	end if
	
	
	if k_return then
	
	
		if k_return then
		
			choose case a_campo_link
						
				case "meca_ddt_in_view_all"
					kuf1_memo_link[] = create kuf_memo_link
					kst_tab_memo_link.id_memo = get_id_memo(kst_tab_meca_ddt_in)
					k_file_opened[] = kuf1_memo_link.open_app_file_all(kst_tab_memo_link)
					k_nfile_opened = upperbound(k_file_opened[])
					if k_nfile_opened = 0 then 
						kst_esito.esito = kkg_esito.no_esecuzione  
						kst_esito.SQLErrText = "Nessun documento trovato da aprire per il MEMO con id " &
												+ string(kst_tab_memo_link.id_memo) & 
												+ ". Per il Lotto con id " + string(kst_tab_meca_ddt_in.id_meca) //~n~r" 
						kGuo_exception.set_esito(kst_esito)
						throw kGuo_exception   
					end if
					
	//				k_rc=kdsi_elenco_output.retrieve(kst_tab_meca_ddt_in.id_meca)
			
				case "meca_ddt_in_add" 
					k_file_opened[] = import_folder_choosen(kst_tab_meca_ddt_in)
					k_nfile_opened = upperbound(k_file_opened[])
					if k_nfile_opened = 0 then 
						kst_esito.esito = kkg_esito.no_esecuzione  
						kst_esito.SQLErrText = "Nessu documento importato per il Lotto con id " &
												+ string(kst_tab_meca_ddt_in.id_meca) //~n~r" 
						kGuo_exception.set_esito(kst_esito)
						throw kGuo_exception   
					end if
			
			end choose
	
		end if
		
	
//		if kdsi_elenco_output.rowcount() > 0 then
//		
//			
//		//--- chiamare la window di elenco
//		//
//		//=== Parametri : 
//		//=== struttura st_open_w
//			kst_open_w.id_programma = kkg_id_programma.elenco  //kkg_id_programma_elenco
//			kst_open_w.flag_primo_giro = "S"
//			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
//			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
//			kst_open_w.flag_leggi_dw = " "
//			kst_open_w.flag_cerca_in_lista = " "
//			kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
//			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
//			kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
//			kst_open_w.key12_any = kdsi_elenco_output
//			kst_open_w.flag_where = " "
//			kuf1_menu_window = create kuf_menu_window 
//			kuf1_menu_window.open_w_tabelle(kst_open_w)
//			destroy kuf1_menu_window
	
	
	//	else
	//		
	//		kguo_exception.inizializza()
	//		kguo_exception.setmessage(u_get_errmsg_nontrovato(kst_open_w.flag_modalita ))
	//		throw kguo_exception
	//		
			
//		end if
//	
	end if
	
	SetPointer(kkg.pointer_default)

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_memo_link) then destroy kuf1_memo_link

end try

return k_return

end function

private function any get_docpath () throws uo_exception;//----------------------------------------------------------------------
//--- Torna i PATH definiti in tabella per i DDT di entrata Lotto
//---
//--- input: 
//--- Rit: string array = path 
//---
//--- Lancia EXCEPTION
//---
//----------------------------------------------------------------------
string k_return[20]
kuf_docpath kuf1_docpath
kuf_doctipo kuf1_doctipo


try

	kuf1_docpath = create kuf_docpath

	k_return = kuf1_docpath.get_docpath_relative(kuf1_doctipo.kki_tipo_ddt_in)

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	
finally
	if isvalid(kuf1_docpath) then destroy kuf1_docpath
	
end try
			

return k_return[]

end function

private function any get_path_all (ref st_tab_meca_ddt_in ast_tab_meca_ddt_in) throws uo_exception;//----------------------------------------------------------------------
//--- Torna i PATH (array) dei file DDT di entrata Lotto
//---
//--- input: st_tab_meca_ddt_in.id_meca
//--- Rit: string array = path 
//---
//--- Lancia EXCEPTION
//---
//----------------------------------------------------------------------
string k_return[20]
string k_path[20]


try

//	k_path = get_docpath()   // get dalla tabella il percorso 'root'
//
//	get_file_path(ast_tab_meca_ddt_in) // get del path 'relativo' del Report
//
//	k_return = u_build_path_all(k_path, ast_tab_meca_ddt_in)  // aggiunge al percorso di root quello relativo
			

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	
finally
	
end try
			

return k_return[]

end function

public function long get_id_meca (ref st_tab_meca_ddt_in ast_tab_meca_ddt_in) throws uo_exception;//--------------------------------------------------------------------------------------
//--- Torna id lotto
//---
//--- inp: st_tab_meca_ddt_in.id_memo
//--- Out: st_tab_meca_ddt_in.id_meco
//---
//--------------------------------------------------------------------------------------
long k_return 
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_meca_ddt_in.id_memo > 0 then

		select meca_ddt_in.id_meca 
			into
				  :ast_tab_meca_ddt_in.id_meca
			  from meca_ddt_in  
			  where id_memo = :ast_tab_meca_ddt_in.id_memo
			  using kguo_sqlca_db_magazzino;
	  
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura id Lotto, da 'id memo': " + string(ast_tab_meca_ddt_in.id_memo) + "~n~r" + trim(sqlca.SQLErrText) 
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		else
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				if ast_tab_meca_ddt_in.id_meca > 0 then
					k_return = ast_tab_meca_ddt_in.id_meca
				end if
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
end try


return k_return

end function

public function boolean if_exists_x_id_meca (ref st_tab_meca_ddt_in ast_tab_meca_ddt_in) throws uo_exception;//--------------------------------------------------------------------------------------
//--- Verifica se esiste qualcosa come DDT caricato per il lotto indicato
//---
//--- inp: st_tab_meca_ddt_in.id_meca
//--- Out: true = esiste il memo
//---
//--------------------------------------------------------------------------------------
boolean k_return 
int k_ctr
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_meca_ddt_in.id_meca > 0 then

		select count(meca_ddt_in.id_meca)
			into :k_ctr
			  from meca_ddt_in  
			  where id_meca = :ast_tab_meca_ddt_in.id_meca
			  using kguo_sqlca_db_magazzino;
	  
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in verifica presenza DDT di entrata Lotto, id: " + string(ast_tab_meca_ddt_in.id_meca) + "~n~r" + trim(sqlca.SQLErrText) 
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			if k_ctr > 0 then
				k_return = true
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
end try


return k_return

end function

public function boolean if_exists_x_file_name (st_tab_meca_ddt_in ast_tab_meca_ddt_in, string a_nome_file) throws uo_exception;//--------------------------------------------------------------------------------------
//--- Verifica se documento già caricato come DDT per il lotto indicato
//---
//--- inp: st_tab_meca_ddt_in.id_meca /  a_nome_file
//--- Out: true = esiste il memo
//---
//--------------------------------------------------------------------------------------
boolean k_return 
int k_rows, k_row
string k_file
datastore kds_1
st_esito kst_esito
kuf_utility kuf1_utility


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_meca_ddt_in.id_meca > 0 then
		
		kds_1 = create datastore
		kds_1.dataobject = "ds_meca_ddt_in_memo"
		kds_1.settransobject( kguo_sqlca_db_magazzino )
		k_rows = kds_1.retrieve(ast_tab_meca_ddt_in.id_meca)
		if k_rows > 0 then
			kuf1_utility = create kuf_utility
			
			if k_rows > 0 then
				for k_row = 1 to k_rows
					k_file = kds_1.getitemstring(k_row, "link")
					if k_file > " " then
						if trim(a_nome_file) = kuf1_utility.u_get_nome_file(k_file) then
							k_return = true
							exit
						end if
					end if
				next
			end if

		else
	  
			if k_rows < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = k_rows
				kst_esito.SQLErrText = "Errore in verifica presenza DDT di entrata Lotto, id: " &
												+ string(ast_tab_meca_ddt_in.id_meca) &
												+ " del file '" + trim(a_nome_file) + "' " &
												+ "~n~r" + trim(sqlca.SQLErrText) 
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
finally 
	if isvalid(kuf1_utility) then destroy kuf1_utility
	if isvalid(kds_1) then destroy kds_1
	
end try


return k_return

end function

public function long get_id_memo (ref st_tab_meca_ddt_in ast_tab_meca_ddt_in) throws uo_exception;//--------------------------------------------------------------------------------------
//--- Torna id del memo
//---
//--- inp: st_tab_meca_ddt_in.id_meca
//--- Out: ast_tab_meca_ddt_in.id_memo
//---
//--------------------------------------------------------------------------------------
long k_return 
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_meca_ddt_in.id_meca > 0 then

		select meca_ddt_in.id_memo
			into
				  :ast_tab_meca_ddt_in.id_memo
			  from meca_ddt_in  
			  where id_meca = :ast_tab_meca_ddt_in.id_meca
			  using kguo_sqlca_db_magazzino;
	  
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura id memo, da id Lotto: " + string(ast_tab_meca_ddt_in.id_meca) + "~n~r" + trim(sqlca.SQLErrText) 
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		else
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				if ast_tab_meca_ddt_in.id_memo > 0 then
					k_return = ast_tab_meca_ddt_in.id_memo
				end if
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
end try


return k_return

end function

private function string u_build_file_relative_path (st_tab_meca_ddt_in ast_tab_meca_ddt_in) throws uo_exception;//----------------------------------------------------------------------
//--- Costruisce il PATH (relativo) dei file DDT entrati
//---
//--- inp: st_tab_meca_ddt_in.id_meca
//--- Out:
//--- Rit: string path del report pilota
//---
//--- Lancia EXCEPTION
//---
//----------------------------------------------------------------------
string k_return
date k_data
st_tab_meca kst_tab_meca
st_esito kst_esito
kuf_armo kuf1_armo
kuf_docpath kuf1_docpath


try

	kst_esito = kguo_exception.inizializza(this.classname())

	if ast_tab_meca_ddt_in.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Manca id Lotto per completare il nome della cartella interna per i DDT entrati, operazione non eseguita!"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- get dati lotto da usare per il path	
	kuf1_armo = create kuf_armo
	kst_tab_meca.id = ast_tab_meca_ddt_in.id_meca
	kuf1_armo.get_dati_rid(kst_tab_meca )
	
//--- get del path da innestare sul path root del documento
	kuf1_docpath = create kuf_docpath
	k_data = date(kst_tab_meca.data_ent)
	if k_data > kkg.data_no then
	else
		k_data = kst_tab_meca.data_int
	end if
	
	k_return = kuf1_docpath.get_path_suff_generale(kst_tab_meca.clie_1, k_data )

//	kkg.path_sep  + string(kst_tab_meca.data_ent, "yyyy") + kkg.path_sep &
//									+ string(kst_tab_meca.clie_3, "00000") + kkg.path_sep &
//									+ string(kst_tab_meca.data_ent, "mm")  &
//									+ kkg.path_sep 


catch (uo_exception kuo1_exception)
	throw kuo1_exception
	
finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf_docpath) then destroy kuf_docpath
	
end try
			

return k_return

end function

public subroutine tb_delete_x_id_meca (st_tab_meca_ddt_in ast_tab_meca_ddt_in) throws uo_exception;//--------------------------------------------------------------------------------------
//--- Cancella la riga MECA-MEMO per ID Lotto
//---
//--- inp: st_tab_meca_ddt_in.id_meca
//--- Rit: 
//---
//--------------------------------------------------------------------------------------
int k_nr_doc
st_esito kst_esito
 

try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_meca_ddt_in.id_meca > 0 then

		delete from meca_ddt_in
					WHERE id_meca = :ast_tab_meca_ddt_in.id_meca
					using kguo_sqlca_db_magazzino;


		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in rimozione legame DDT mittente e Lotto con ID " &
											+ string(ast_tab_meca_ddt_in.id_meca) &
											+ " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kGuo_exception.set_esito(kst_esito)
			if ast_tab_meca_ddt_in.st_tab_g_0. esegui_commit <> "N" or isnull(ast_tab_meca_ddt_in.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			throw kGuo_exception   
		end if
		
		if ast_tab_meca_ddt_in.st_tab_g_0. esegui_commit <> "N" or isnull(ast_tab_meca_ddt_in.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		
	end if
		
catch (uo_exception kuo_exception)
	throw kuo_exception 

finally

	
end try



end subroutine

public subroutine tb_add (st_tab_meca_ddt_in ast_tab_meca_ddt_in) throws uo_exception;//--------------------------------------------------------------------------------------
//--- ADD nuova riga in tab
//---
//--- inp: st_tab_meca_ddt_in.id_meca
//--- Rit: 
//---
//--------------------------------------------------------------------------------------
int k_nr_doc
st_esito kst_esito
datastore kds_meca_ddt_in
 

try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_meca_ddt_in.id_meca > 0 then

		kds_meca_ddt_in = create datastore
		kds_meca_ddt_in.dataobject = "ds_meca_ddt_in"
		kds_meca_ddt_in.settransobject( kguo_sqlca_db_magazzino )
		
		k_nr_doc = kds_meca_ddt_in.insertrow(0)
		kds_meca_ddt_in.setitem(k_nr_doc, "id_meca_ddt_in", 0)
		kds_meca_ddt_in.setitem(k_nr_doc, "id_meca", ast_tab_meca_ddt_in.id_meca)
		kds_meca_ddt_in.setitem(k_nr_doc, "id_memo", ast_tab_meca_ddt_in.id_memo)
		kds_meca_ddt_in.setitem(k_nr_doc, "x_datins", kGuf_data_base.prendi_x_datins())
		kds_meca_ddt_in.setitem(k_nr_doc, "x_utente", kGuf_data_base.prendi_x_utente())

		k_nr_doc = kds_meca_ddt_in.update( )
		if k_nr_doc > 0 then  // Salva i dati in meca_ddt_in
			kguo_sqlca_db_magazzino.db_commit( )
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = k_nr_doc
			kst_esito.SQLErrText = "Errore in generazione legame DDT mittente e Lotto con ID " &
											+ string(ast_tab_meca_ddt_in.id_meca) &
											+ " per il MEMO con id " + string(ast_tab_meca_ddt_in.id_memo)
			kGuo_exception.set_esito(kst_esito)
			throw kGuo_exception   
		end if
		
	end if
		
catch (uo_exception kuo_exception)
	throw kuo_exception 

finally
	if isvalid(kds_meca_ddt_in) then destroy kds_meca_ddt_in
	
end try



end subroutine

public subroutine tb_delete_x_id_memo (st_tab_meca_ddt_in ast_tab_meca_ddt_in) throws uo_exception;//--------------------------------------------------------------------------------------
//--- Cancella la riga MECA-MEMO per ID MEMO
//---
//--- inp: st_tab_meca_ddt_in.id_meca
//--- Rit: 
//---
//--------------------------------------------------------------------------------------
int k_nr_doc
st_esito kst_esito
 

try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_meca_ddt_in.id_memo > 0 then

		delete from meca_ddt_in
					WHERE id_memo = :ast_tab_meca_ddt_in.id_memo
					using kguo_sqlca_db_magazzino;

 
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in rimozione legame DDT mittente e Lotto per il MEMO con ID " &
											+ string(ast_tab_meca_ddt_in.id_memo) &
											+ " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kGuo_exception.set_esito(kst_esito)
			if ast_tab_meca_ddt_in.st_tab_g_0. esegui_commit <> "N" or isnull(ast_tab_meca_ddt_in.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			throw kGuo_exception   
		end if
		
		if ast_tab_meca_ddt_in.st_tab_g_0. esegui_commit <> "N" or isnull(ast_tab_meca_ddt_in.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		
	end if
		
catch (uo_exception kuo_exception)
	throw kuo_exception 

finally

	
end try



end subroutine

private function any u_import_file_change_name (string a_file[], string a_file_name_dest_init) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Cambia il nome ai faile da importare 
//---	inp: array elenco file + nuovo nome del primo file (se di più poi sarà aggiunto un numero x distinguerli)
//---	out: 
//---	rit: nr file trovati
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
string k_nome_file_dest
string k_file_rename, k_file
int k_rcn, k_file_ind=0
long k_n_file_import
st_esito kst_esito
kuf_utility kuf1_utility 
kuf_file_explorer kuf1_file_explorer

 
	try

		kst_esito = kguo_exception.inizializza(this.classname())

		kuf1_utility = create kuf_utility 
		kuf1_file_explorer = create kuf_file_explorer
		
		k_n_file_import = upperbound(a_file[])

//--- cambio nome ai file di origine
		for k_file_ind = 1 to k_n_file_import

//--- estrae il file da importare		
			k_file = trim(a_file[k_file_ind])
			if k_file > " " then
				
				k_file_rename = kuf1_utility.u_get_nome_file_add_one_if_exists(&
										kuf1_utility.u_get_path_file(k_file) &
										+ a_file_name_dest_init &
										+ "." + kuf1_utility.u_get_ext_file(k_file))
				
				if k_file <> k_file_rename then
					k_rcn = kuf1_file_explorer.u_filemove(k_file, k_file_rename, true)
					if k_rcn < 0 then
						kst_esito.esito = kkg_esito.no_esecuzione  
						kst_esito.sqlcode = 0
						kst_esito.SQLErrText = "Errore in importazione del DDT di entrata merce durante " & 
														+ "la rinomina del file: '" + a_file[k_file_ind] &
														+ "' in: '" + k_file_rename &
														+ "' Operazione Interrotta!"   //~n~r" &
						kGuo_exception.inizializza( )
						kGuo_exception.set_esito(kst_esito)
						throw kGuo_exception   
					end if
					fileDelete(k_file)  // DELETE del file di origine
				
					a_file[k_file_ind] = k_file_rename  //sostituisco il vecchio nome con il nuovo
					
				end if

			end if

		end for
		
		
	catch (uo_exception kuo_exception)
		throw kuo_exception
		
		
	finally
		if isvalid(kuf1_utility) then destroy kuf1_utility 
		if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer 
	
	end try
			


return a_file[]


end function

private function any u_import_get_file (string a_path) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Get elenco dei file da Importare
//---	inp: 
//---	out: 
//---	rit: string array con i file: root path + nome
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
string k_file[]
string k_file_find
int k_nr_file_dirlist, k_row, k_file_ind
datastore kds_dirlist
st_esito kst_esito
kuf_file_explorer kuf1_file_explorer

 
	try

		kst_esito = kguo_exception.inizializza(this.classname())

		kds_dirlist = create datastore 
		kuf1_file_explorer = create kuf_file_explorer

//--- piglia l'elenco dei file contenuti nella cartella indicata 
		k_file_find = a_path + kkg.path_sep + "*.*"
		kds_dirlist = kuf1_file_explorer.DirList(k_file_find)
		k_nr_file_dirlist = kds_dirlist.rowcount( )
		
		for k_row = 1 to k_nr_file_dirlist
			if trim(kds_dirlist.getitemstring(k_row, "nome")) > " " then
				k_file_ind ++
				k_file[k_file_ind] = a_path + kkg.path_sep + trim(kds_dirlist.getitemstring(k_row, "nome"))
			end if
		next
				

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
	finally
		if isvalid(kds_dirlist) then destroy kds_dirlist
	
	end try
			


return k_file[]


end function

private function string u_import_to_path (st_tab_meca_ddt_in kst_tab_meca_ddt_in) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Costruisce il PATH in cui copiare il file 
//---	inp: kst_tab_meca_ddt_in.id_meca
//---	out: 
//---	rit: il path completo di root 
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
string k_path_relative, k_path[]
int k_npath_tot
st_esito kst_esito

 
	try

		kst_esito = kguo_exception.inizializza(this.classname())
		
//--- legge i path nei quali copiare i file
		k_path[] = get_docpath ( )
		k_npath_tot = upperbound(k_path[])
		if k_npath_tot = 0  then 
			kst_esito.esito = kkg_esito.no_esecuzione  
			kst_esito.SQLErrText = "Manca in Proprietà la cartella per salvare i DDT di entrata merce" //~n~r" 
			kGuo_exception.set_esito(kst_esito)
			throw kGuo_exception   
		end if
			
		k_path_relative = u_build_file_relative_path(kst_tab_meca_ddt_in) // get del path 'relativo' del file
	
		return k_path[1] + k_path_relative

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
		
	finally
	
	end try
			



end function

public subroutine _readme ();//---
//--- Gestione DDT di entrata merce
//---
end subroutine

private function string u_import_choose_path () throws uo_exception;//
//-------------------------------------------------------------------------------
//---
//---	Get cartella dei file da Importare (Richiesta interattiva all'operatore)
//---	inp: 
//---	out: 
//---	rit: string array con i file: root path + nome
//---	x ERRORE lancia UO_EXCEPTION
//---
//-------------------------------------------------------------------------------
//
string k_path = ".."
integer k_result
st_esito kst_esito


try

	kst_esito = kguo_exception.inizializza(this.classname())

	k_path = kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_leggi, kki_profile_ini_path)
	k_result = GetFolder( "Selezionare la cartella con i DDT da Importare", k_path )
	if k_result > 0 then
		
		kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_scrivi, kki_profile_ini_path, k_path)
		
	else
		
		if k_result = 0 then
			kst_esito.esito = kkg_esito.ok  
			kst_esito.SQLErrText = "Operazione interrotta dall'utente. Selezione cartella con i doucumenti del DDT da importare." //~n~r"
			kGuo_exception.set_esito(kst_esito)
			throw kGuo_exception   
		else
			kst_esito.esito = kkg_esito.no_esecuzione  
			kst_esito.SQLErrText = "Errore in selezione della cartella con i doucumenti del DDT da importare! (" + string(k_result) + ")" //~n~r"
			kGuo_exception.set_esito(kst_esito)
			throw kGuo_exception   
		end if
	end if

	return k_path


catch (uo_exception kuo_exception)
	throw kuo_exception
		
finally

	
end try
			





end function

public function any import_file_to_folder (st_tab_meca_ddt_in ast_tab_meca_ddt_in, string a_file_import[]) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Importa i file indicati tra i parametri
//---	inp: ast_tab_meca_ddt_in.id_meca + array con i nomi dei file da importare
//---	out: 
//---	rit: array dei file importati 
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
string k_nome_file_dest_base, k_num_bolla_in_cleared
int k_ctr
long k_ind, k_id_memo_esistente
st_esito kst_esito
st_tab_meca kst_tab_meca		
st_memo kst_memo
kuf_memo kuf1_memo
kuf_armo kuf1_armo
kuf_memo_inout kuf1_memo_inout 
kuf_utility kuf1_utility

 
	try
		
		setpointer(kkg.pointer_attesa)

		kst_esito = kguo_exception.inizializza(this.classname())

			
//--- get dati DDT x costruire il nome del file
		kuf1_armo = create kuf_armo
		kst_tab_meca.id = ast_tab_meca_ddt_in.id_meca
		kuf1_armo.get_num_bolla_in(kst_tab_meca)
//--- get dati mittente x costruire il nome del file
		kuf1_armo.get_clie(kst_tab_meca)
		
		kuf1_utility = create kuf_utility
		k_num_bolla_in_cleared = kuf1_utility.u_stringa_pulisci(trim(kst_tab_meca.num_bolla_in)) // toglie char strani dal n.bolla
		if k_num_bolla_in_cleared > " " then
			k_nome_file_dest_base = "ddt_" + string(kst_tab_meca.data_bolla_in, "yyyymmdd") + "_n" &
											+ k_num_bolla_in_cleared + "_c" + string(kst_tab_meca.clie_1,"0") 
		else
			k_nome_file_dest_base = "ddt_attached"  &
											+ "_c" + string(kst_tab_meca.clie_1,"0") 
		end if
		
		kuf1_memo_inout = create kuf_memo_inout

//--- get del ID_MEMO se esiste già x questo lotto
		k_id_memo_esistente = get_id_memo(ast_tab_meca_ddt_in)

//--- cambia il nome ai file da importare, per essere più riconoscibili
		a_file_import[] = u_import_file_change_name(a_file_import[], k_nome_file_dest_base)

//--- Aggiorna il MEMO e carica i file
		kst_memo.st_tab_memo_link[1].link = u_import_to_path(ast_tab_meca_ddt_in) //u_build_file_relative_path(ast_tab_meca_ddt_in)
		kst_memo.st_tab_meca_memo.id_meca = ast_tab_meca_ddt_in.id_meca
		ast_tab_meca_ddt_in.id_memo = kuf1_memo_inout.crea_memo_meca_ddt_in(kst_memo, a_file_import[])

//--- carica la tabella pilota meca ddt - memo
		if k_id_memo_esistente > 0 then
		else
			tb_add(ast_tab_meca_ddt_in)
			kguo_sqlca_db_magazzino.db_commit( )
		end if

//--- DELETE dei file importati
		k_ctr = upperbound(a_file_import[])
		for k_ind = 1 to k_ctr
			fileDelete(a_file_import[k_ind]) 
		next
		

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
		
	finally
		if isvalid(kuf1_memo_inout) then destroy kuf1_memo_inout
		if isvalid(kuf1_armo) then destroy kuf1_armo
		if isvalid(kuf1_utility) then destroy kuf1_utility

		setpointer(kkg.pointer_default)

	end try
			


return a_file_import[]


end function

public function any import_folder_choosen (st_tab_meca_ddt_in kst_tab_meca_ddt_in) throws uo_exception;//
//-------------------------------------------------------------------------------
//---
//---	Importa i file ddt: mostra box per la scelta della cartella 
//---	inp: kst_tab_meca_ddt_in.id_meca
//---	out: 
//---	rit: arry dei file importati
//---	x ERRORE lancia UO_EXCEPTION
//---
//-------------------------------------------------------------------------------
//
string k_file[], k_path
int k_n_file_importatim, k_rc
st_esito kst_esito
string k_file_imported[], k_msg, k_msg1
 
 
	try

		kst_esito = kguo_exception.inizializza(this.classname())

		k_path = u_import_choose_path()	// richiesta del path dei file da importare

		k_file[] = u_import_get_file(k_path)  // get dei file da importare dalla cartella indicata
		
		if upperbound(k_file[]) > 3 then
			k_msg = " molti documenti, in tutto "
			k_msg1 = " "
		else
			k_msg = " "
			k_msg1 = " documenti "
		end if
			
		if upperbound(k_file[]) = 0 then
			
			kst_esito.esito = kkg_esito.ok  
			kst_esito.SQLErrText = "Non ci sono documenti del DDT da importare dalla cartella selezionata: " + k_path
			kGuo_exception.set_esito(kst_esito)
			throw kGuo_exception   
			
		end if
			
		if messagebox("Importa DDT", "Sono stati selezionati" + k_msg +  string(upperbound(k_file[])) &
						+ k_msg1 + "da importare, dalla cartella: " &
						+ k_path &
						+ " Confermare l'operazione?", question!, yesno!, 2) = 2 then
			kst_esito.esito = kkg_esito.ok  
			kst_esito.SQLErrText = "Operazione interrotta dall'utente. Era di importazione di " + string(upperbound(k_file[])) + " documenti del DDT di entrata merce." //~n~r"
			kGuo_exception.set_esito(kst_esito)
			throw kGuo_exception   
		end if

		k_file_imported[] = import_file_to_folder(kst_tab_meca_ddt_in, k_file[])  // importa i file scelti sul MEMO
		
		messagebox("Importa DDT", "Operazione terminata sono stati importati " &
					+ string(upperbound(k_file_imported[])) + " documenti." &
					 , information!)
		

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
		
	finally
	
	end try
			


return k_file_imported[]


end function

on kuf_meca_ddt_in.create
call super::create
end on

on kuf_meca_ddt_in.destroy
call super::destroy
end on

event constructor;call super::constructor;//--- solo per autorizzazione a FORZARE LA CONVALIDA Lotto anche con letture parziali dei dosimetri
//--- 

ki_msgErrDescr="Forza Convalida Lotto"
end event

