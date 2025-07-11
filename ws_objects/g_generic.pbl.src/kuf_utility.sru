﻿$PBExportHeader$kuf_utility.sru
forward
global type kuf_utility from nonvisualobject
end type
end forward

global type kuf_utility from nonvisualobject
end type
global kuf_utility kuf_utility

type prototypes
//=== copia file win32
function boolean CopyFileA (string szExistingFile, string szNewFile, boolean bFail) library "kernel32.DLL" alias for "FileCopy;Ansi"
//=== findwindow 95 e w3.x
function ulong FindWindowA (ulong szclass, string sztitle) library "USER32.DLL" alias for "FindWindowA;Ansi"
function ulong findwindowa3(ulong szclass, string sztitle) library "USER.EXE" alias for "FindWindow;Ansi"
//=== setfocus 95 e w3.x
//function ulong setfocus (uint wWnd) library "user32.dll" alias for "SetFocus"
//function ulong setfocus3(uint wWnd) library "user.exe" alias for "SetFocus"
//=== playsound 95 e w3.x
function uint playsoundA (string szsound, uint homd, ulong dwsound) library "winmm.dll" alias for "PlaySoundA;Ansi"
function uint playsoundA3(string szsound, uint homd, ulong dwsound) library "winmm.exe" alias for "PlaySound;Ansi"
//=== sndplaysound 95 e w 31
FUNCTION boolean sndPlaySoundA (string SoundName, uint Flags) LIBRARY "WINMM.DLL" alias for "sndPlaySoundA;Ansi" 
FUNCTION boolean sndPlaySoundA3 (string SoundName, uint Flags) LIBRARY "WINMM.EXE" alias for "sndPlaySoundA;Ansi" 

//--- Metodo x controllo esistenza della RETE 
FUNCTION boolean IsNetworkAlive(ref int flags) LIBRARY "sensapi.dll"

//--- Metodo x controllo esistenza Tastiera settata su Maiuscolo/Minuscolo 
FUNCTION  INT GetKeyState(int keystatus) LIBRARY "user32.dll"

//--- funzione x lanciare un'applicazione associata all'estensione del programma
FUNCTION long ShellExecuteEx(REF st_shellexecuteinfo lpExecInfo) LIBRARY "shell32.dll" ALIAS FOR ShellExecuteExA

//--- piglia il nome del computer
FUNCTION long GetComputerNameA(ref string compname,ref ulong slength) LIBRARY "kernel32" alias for "GetComputerNameA;Ansi"


end prototypes

type variables

end variables

forward prototypes
public function unsignedinteger u_sound (string k_suono, unsignedinteger k_umodule, unsignedlong k_flag)
public function integer ext_popola_new_tab ()
public function integer ext_popola_contratti ()
public function integer ext_db_esterno ()
public function integer ext_popola_ric_id ()
public function string u_stringa_campi_dw (integer k_tipo, long k_riga, ref datawindow k_dw)
public function string u_dw_copia (integer k_tipo, ref datawindow k_dw_source, ref datawindow k_dw_target)
public function integer u_setfocus (unsignedlong k_hwnd)
public function unsignedlong u_findwindow (unsignedlong k_classe, string k_window)
public subroutine u_ds_toglie_ddw (integer k_tipo, ref datastore k_dw_source)
public subroutine u_dw_toglie_ddw (integer k_tipo, ref datawindow k_dw_source)
public function st_esito errori_visualizza_log (integer k_tipo)
public function st_esito errori_visualizza_log_informix (integer k_tipo)
public function string u_stringa_pulisci (string k_stringa)
public function st_esito u_dw_check_dup_row (ref datawindow kdw_buffer, string k_key[5])
public function string u_nome_computer ()
private subroutine u_stored_procedure ()
public function integer ext_popola_id_meca ()
public function boolean u_check_network ()
public function boolean u_check_caps_on ()
public function integer ext_popola_tab_nazioni ()
public function integer ext_popola_tab_cap ()
public function boolean ext_crea_view ()
public function integer ext_sistema_artr ()
public subroutine u_toolbar_save_toolbartext ()
public subroutine u_toolbar_set_toolbartext ()
public function string u_stringa_pulisci_x_msg (string k_stringa)
public function st_esito u_ddlb_set_item (ref dropdownlistbox kddlb_out, string k_stringa)
public function st_window_size u_window_adatta_size (ref window kwindow)
public function boolean u_window_adatta_a_toolbar (ref st_window_size kst_window_size, ref window kwindow)
public function string u_stringa_numeri (string k_stringa)
public function boolean u_shellexecuteex (ref string k_file, string k_extension)
public function integer u_apri_programma_esterno (string k_tipo_programma)
public function integer ext_popola_sped_indi ()
public function integer u_copia_file (string k_file_source, string k_file_target, boolean k_raplace)
public function integer u_filemovereplace (string k_file_source, string k_file_target)
public function string u_get_nome_file (string k_path_file)
public function integer ext_popola_sd_md ()
public function st_esito u_stop_e_disconnessione (unsignedlong k_classe, window ka_window)
public function string u_stringa_compatta (string k_stringa)
public function string u_stringa_pulisci_asc (string ka_stringa)
public function string u_get_path_file (string k_path_file)
public function integer ext_sistema_prof ()
public function integer ext_popola_id_sped ()
public function blob u_filetoblob (string a_file) throws uo_exception
public function string u_get_ext_file (string k_path_file)
public subroutine u_blobtofile (blob a_blob, string a_file) throws uo_exception
public function boolean u_svuota_temp ()
public subroutine u_stringtofile (string a_string, string a_file) throws uo_exception
public subroutine u_toolbar_restore_old (ref w_super kwindow, integer k_index_par, boolean k_toolbar_window_stato, boolean k_toolbar_window_presente)
public subroutine u_toolbar_save_old (window kwindow)
public function string u_stringa_cmpnovocali (string a_stringa)
public function integer ext_esempio ()
public function string u_num_itatousa (string k_stringa)
public function long u_ds_to_csv (datastore a_ds, string a_file) throws uo_exception
public subroutine u_dw_ddw_retrieve_auto (ref datawindow a_dw_source, transaction a_sqlca)
public function string u_num_itatousa2 (string a_stringa, boolean a_forzaconversione)
public subroutine u_dw_guida_estrazione (ref st_dw_guida_estrazione ast_dw_guida_estrazione) throws uo_exception
public function string u_stringa_alfa (string k_stringa)
public function string u_stringa_tonome (string k_stringa)
public function string u_get_printer () throws uo_exception
public function boolean u_svuota_folder (string a_folder)
public function string u_file_add_suff (string k_path_file, string k_suffisso)
public function string u_get_printer_current () throws uo_exception
public function boolean u_print_file (string a_file) throws uo_exception
public function boolean u_open_app_file (string a_file) throws uo_exception
public function integer u_pdf_merge (string a_pdf_inp[], string a_pdf_out) throws uo_exception
public function boolean u_pdf_decrypt (string a_pdf_inp, string a_pdf_out) throws uo_exception
public function string u_stringa_pulisci_nomefunzione (string k_stringa)
public function string u_get_email_domain ()
public function string u_stringa_alfanum (string k_stringa)
public function string u_xls_create (ref datastore ads_1, string a_path, string a_namefile, string a_namesheet) throws uo_exception
private function st_printer u_get_st_printer () throws uo_exception
public function string u_get_printer_string_current () throws uo_exception
public function string u_set_printer_system (string a_printer) throws uo_exception
public function string u_string_replace (string k_string, readonly string k_str_old, readonly string k_str_new)
private function st_proteggi u_proteggi_set_st_proteggi (character k_operazione)
public subroutine u_proteggi_sproteggi_dw (ref uo_d_std_1 adw_1)
public function string u_get_nome_file_noext (string k_path_file)
public function string u_get_nome_file_add_one_if_exists (string a_file)
public function string u_replace (string k_str, string k_str_old, string k_str_new)
public subroutine u_proteggi_sproteggi_dw_no_protect (ref uo_d_std_1 adw_1)
public function string u_dw_get_protect_evaluate (datawindow adw_1, integer a_field_n)
public function string u_get_tooltip_text (string a_tooltip_tip) throws uo_exception
public function string u_stringa_spezza (string k_stringa)
public function integer u_open_app_files (string a_file) throws uo_exception
public function integer u_stringa_split (ref string a_string[], string a_sep)
public function string u_url_sep_path_by_name (ref string a_url)
public function string u_url_encode (string a_url, boolean a_replace_puls_sign)
public subroutine u_proteggi_dw (character k_operazione, integer k_id_campo, ref uo_d_std_1 k_dw)
private subroutine old_u_dw_set_column_color (ref uo_d_std_1 k_dw)
private subroutine old_u_dw_set_column_color (ref datawindow k_dw)
public subroutine u_proteggi_dw (character k_operazione, string k_txt_campo, ref uo_d_std_1 k_dw)
public function string u_stringa_alfanum_spazio (string k_stringa)
public function boolean u_copy_dw_composite (ref datawindow adw_source, ref datawindow adw_target)
public function boolean u_copy_ds_dw_composite (ref datastore ads_source, ref datawindow adw_target)
public function boolean u_copy_ds_composite (ref datastore ads_source, ref datastore ads_target)
private function string u_ds_get_evaluate_expression_all (ref uo_ds_std_1 ads_1)
public function integer u_rowscopy_ds_to_dw (ref datastore ads_source, ref datawindow adw_target) throws uo_exception
public function integer u_rowscopy_ds_to_ds (ref datastore ads_source, ref uo_ds_std_1 ads_target) throws uo_exception
private function string u_dw_get_evaluate_expression_all (ref datawindow adw_1)
public function integer u_rowscopy_dw_to_dw (ref datawindow adw_source, ref datawindow adw_target) throws uo_exception
private function string u_ds_get_evaluate_expression_all (ref datastore ads_1)
public function integer u_rowscopy_ds_to_ds (ref uo_ds_std_1 ads_source, ref uo_ds_std_1 ads_target) throws uo_exception
public function integer u_rowscopy_ds_to_dw (ref uo_ds_std_1 ads_source, ref datawindow adw_target) throws uo_exception
public function string u_ds_get_evaluate (ref datastore ads_1, string a_field, string a_field_describe, long a_row)
public function string u_dw_get_evaluate (ref datawindow adw_1, string a_field, string a_field_describe, long a_row)
end prototypes

public function unsignedinteger u_sound (string k_suono, unsignedinteger k_umodule, unsignedlong k_flag);//
uint k_return
char k_flag_suoni
kuf_base kuf1_base


	kuf1_base = create kuf_base
	k_flag_suoni = trim(mid(kuf1_base.prendi_dato_base("flag_suoni"), 2))
	destroy kuf1_base
	
	if k_flag_suoni = "S" then

		k_return = playsounda (k_suono,  k_umodule, k_flag)
		
	end if

return k_return
end function

public function integer ext_popola_new_tab ();//
//=== Estemporanea da lanciare una sola volta
//=== Popola campi in tabella
//=== AL TERMINE DEL PROGRAMMA:
//===    ---

int k_errore=0
string k_record
int k_codici_doppi=0, k_codice=0, k_commit=0
st_tab_sped kst_tab_sped
pointer oldpointer  // Declares a pointer variable




if messagebox("Aggiorna id_sped  da tabella SPED alla ARSP~n~r", &
	              "che deve gia' essere stata popolata lanciando ~n~r" + &
	              "l'utility di NT 'AGG_MAG_SPED' !!!!!", &
						exclamation!, yesno!, 1) = 2 then

	MessageBox("Elaborazione non eseguita", &
		           "Elaborazione Interrotta dall'utente", &
						StopSign!)
else

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

	declare c_ext_popola_new_tab cursor for
		select  id_sped, num_bolla_out, data_bolla_out
			from  sped 
			where id_sped > :kst_tab_sped.id_sped
			order by id_sped;

	kst_tab_sped.id_sped = 0
	open c_ext_popola_new_tab;
	
	if sqlca.sqlcode = 0 then
		
	
		fetch c_ext_popola_new_tab into :kst_tab_sped.id_sped, :kst_tab_sped.num_bolla_out, :kst_tab_sped.data_bolla_out;
	
		do while sqlca.sqlcode = 0 
				
			UPDATE arsp 
					set id_sped = :kst_tab_sped.id_sped 
				where num_bolla_out = :kst_tab_sped.num_bolla_out
					and data_bolla_out = :kst_tab_sped.data_bolla_out;
	
			if sqlca.sqlcode = 0 then
				if k_commit > 10000 then
					commit;
					kst_tab_sped.id_sped++
					open c_ext_popola_new_tab;
					k_commit = 0
				end if
				k_commit ++
				k_codice ++
			else
				if sqlca.sqldbcode = -1605 or sqlca.sqldbcode = -239 then
					sqlca.sqlcode = 0
					k_codici_doppi++
				end if
			end if
				
			if sqlca.sqlcode = 0 then
	
				fetch c_ext_popola_new_tab into :kst_tab_sped.id_sped, :kst_tab_sped.num_bolla_out, :kst_tab_sped.data_bolla_out;
	
			else
				k_errore = 1
				SetPointer(oldpointer)
				MessageBox("Stop forzato all'utility (1) ","Errore durante aggiornamento riga:" &
							+ string(sqlca.sqldbcode, "#####") + "; " + string(sqlca.sqlcode, "#####") , &
				StopSign!)
	
			end if	
			
		
		loop

		if sqlca.sqlcode < 0 then
				SetPointer(oldpointer)
				MessageBox("Stop forzato all'utility","Errore durante aggiornamento riga:" &
							+ string(sqlca.sqldbcode, "#####") + "; " + string(sqlca.sqlcode, "#####") &
						   + " " + sqlca.sqlerrtext, StopSign!)
		end if

		close c_ext_popola_new_tab;
	end if		

	SetPointer(oldpointer)

	if k_errore = 0 then
		MessageBox("Conversione Terminata", "Elaborazione OK!, aggiornati rec in arsp:" + string(k_codice, "####"), &
					Information!)
		MessageBox("Aggiornamento Terminato", &
 		           "Elaborazione OK!, ~n~r" &
						+ "Aggiornati rec in arsp:" + string(k_codice, "####") + "~n~r" &
						+ "rec doppi non aggiornati:" + string(k_codici_doppi, "####"), &
					Information!)
	end if
	
end if	
	 
SetPointer(oldpointer)

return k_codice

end function

public function integer ext_popola_contratti ();//
//=== Estemporanea da lanciare una sola volta
//=== Popola la nuova tabella Contratto dalla CAPVAL
//=== AL TERMINE DEL PROGRAMMA:
//===    Cancellare la tabella CAPVAL

int k_errore=0, k_codice, k_codici_doppi
string k_record
long k_contratto=0
string k_sl_pt=" "
datetime k_today
pointer oldpointer  // Declares a pointer variable




if messagebox("Trasferimento dati", &
	              "Copia SL-PT da tabella LISTINO alla CONTRATTI ~n~r" + &
	              " ", &
						exclamation!, yesno!, 1) = 2 then

	MessageBox("Elaborazione non eseguita", &
		           "Elaborazione Interrotta dall'utente", &
						StopSign!)
else

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

	declare c_listino cursor for
		select  contratto, cod_sl_pt
			from  listino
			where contratto > 0 and cod_sl_pt > ' ' 
			order by contratto;

	open c_listino;
	k_codice=0
	k_codici_doppi=0
	k_today = datetime(today())
	
	if sqlca.sqlcode = 0 then
		
		fetch c_listino into :k_contratto, :k_sl_pt;
	
   	do while sqlca.sqlcode = 0 
	
			update contratti 
			           set  sl_pt = :k_sl_pt,     
			                x_datins = :k_today,
								 x_utente = 'batch' 
					where codice = :k_contratto;

			if sqlca.sqlcode = 0 then
				k_codice ++
			else
				sqlca.sqlcode = 0
				k_codici_doppi++
			end if
			
			if sqlca.sqlcode = 0 then

				fetch c_listino into :k_contratto, :k_sl_pt;

			else
				k_errore = 1
				SetPointer(oldpointer)
				MessageBox("Stop forzato all'utility (1) ","Errore durante inserimento riga:" &
							+ string(sqlca.sqldbcode, "#####") + "; " + string(sqlca.sqlcode, "#####") , &
				StopSign!)

			end if	
			
		
		loop

		if sqlca.sqlcode < 0 then
				SetPointer(oldpointer)
				MessageBox("Stop forzato all'utility","Errore durante inserimento riga:" &
							+ string(sqlca.sqldbcode, "#####") + "; " + string(sqlca.sqlcode, "#####") &
						   + " " + sqlca.sqlerrtext, StopSign!)
		end if

		close c_listino;
	end if		

	SetPointer(oldpointer)

	if k_errore = 0 then
		MessageBox("Conversione Terminata", "Elaborazione OK!, upd in CONTRATTI:" + string(k_codice, "####"), &
					Information!)
		MessageBox("Conversione Terminata", &
 		           "Elaborazione OK!, ~n~r" &
						+ "Aggiornati rec CONTRATTI:" + string(k_codice, "####") + "~n~r" &
						+ "rec non trovati(errore) :" + string(k_codici_doppi, "####"), &
					Information!)
	end if
	
end if	
	 
SetPointer(oldpointer)

return k_codice

end function

public function integer ext_db_esterno ();////
////=== Estemporanea da lanciare una sola volta
////=== Popola la nuova tabella SL_PT dal ACCESS
//
//int k_errore=0
//string k_record
//string k_dbms, k_dbparm
//datetime k_today
//string k_sl_pt="", k_impianto="", k_prodotto="", k_Composizione_prodotto=""
//string k_peso="", k_densita="", k_ciclo="" 
//string k_Dosimetrie_speciali="", k_SC_CF="", k_mc_co="", k_note="", k_tipo="", k_routine_rec=""
//string k_Codice_Cliente=""
//datetime k_data 
//date k_data_d
//string k_Dispositivo_medico="", k_Prodotto_farmaceutico="", k_Routine=""
//int k_clie, k_fila1, k_fila2, k_ctr, k_magazzino
int k_nr_rec_scritti=0, k_nr_rec_doppi=0, k_nr_rec_doppi_1=0, k_nr_rec_letti=0, k_nr_rec_scritti_1=0
//string k_dose="", k_dose_minima="", k_dose_max=""
//double k_dose_n, k_dose_minima_n, k_dose_max_n
//pointer oldpointer  // Declares a pointer variable
//transaction k_sqlca_ext
//
//
//
////=== Puntatore Cursore da attesa.....
//oldpointer = SetPointer(HourGlass!)
//
//k_dbms="ODBC"
//k_DbParm="Connectstring='DSN=db_contratti'"
//k_sqlca_ext = create transaction
//k_sqlca_ext.dbms = k_dbms
//k_sqlca_ext.DbParm = k_DbParm
//
//
//	if messagebox("Trasferimento dati da DB Esterno", &
//	              "DB scaricato da SL_PT in ACCESS ~n~r" + &
//					  "popola tabella SL-PT  ~n~r" + &
//	              "Connessione al DB Esterno- Dbms=" + trim(k_dbms) + &
//	 				  " e Dbparm=" + trim(k_dbparm), &
//						exclamation!, yesno!, 1) = 2 then
////					  "popola nuove tabelle SL-PT e CONTRATTI ~n~r" + &
//
//		MessageBox("Elaborazione non eseguita", &
//		           "Elaborazione Interrotta dall'utente", &
//						StopSign!)
//	else
//		
//		connect using k_sqlca_ext;
//
//		declare c_contratti cursor for
//			SELECT 
//					Trattamento.SL_PT, 
//					Trattamento.Data, 
//					Trattamento.Impianto, 
//					Trattamento.Dispositivo_medico,
//					Trattamento.Prodotto_farmaceutico, 
//					Trattamento.Codice_Cliente, 
//					trattamento.Prodotto,
//					trattamento.Dose, 
//					Trattamento.Dose_Minima, 
//					Trattamento.Dose_Max, 
//					Trattamento.Composizione_prodotto, 
//					Trattamento.Peso, 
//					Trattamento.Densita, 
//					Trattamento.Ciclo, 
//					Trattamento.Routine, 
//					Trattamento.Dosimetrie_speciali, 
//					Trattamento.SC_CF, 
//					Trattamento.MC_CO, 
//					Trattamento.Note
//				FROM Trattamento
//				order by 
//					Trattamento.SL_PT
//				using k_sqlca_ext;
//
//		open c_contratti;
//		k_nr_rec_scritti = 0 
//		k_today = datetime(today())
//		
//		if k_sqlca_ext.sqlcode >= 0 then
//		
//			delete from sl_pt;
//		
//			fetch c_contratti into 
//					:k_SL_PT, 
//					:k_Data, 
//					:k_Impianto, 
//					:k_Dispositivo_medico,
//					:k_Prodotto_farmaceutico, 
//					:k_Codice_Cliente, 
//					:k_Prodotto,
//					:k_Dose, 
//					:k_Dose_Minima, 
//					:k_Dose_Max, 
//					:k_Composizione_prodotto, 
//					:k_Peso, 
//					:k_Densita, 
//					:k_Ciclo, 
//					:k_Routine, 
//					:k_Dosimetrie_speciali, 
//					:k_SC_CF, 
//					:k_MC_CO, 
//					:k_Note
//					;
//		
//		
//			do while k_sqlca_ext.sqlcode = 0 and sqlca.sqlcode = 0
//
//				k_nr_rec_letti ++
//
////--- controllo campi a null
//				if isnull(k_data) then 
//					k_data_d=today()
//				else
//					k_data_d=date(k_data)
//				end if
//				k_impianto=mid(k_impianto, 7, 1)
//				if len(trim(k_Impianto)) = 0 or isnull(k_impianto) then 
//					k_impianto="0"
//				end if
//				k_magazzino = integer(k_impianto)
//				
//				k_ctr = Pos(k_Dose, ",", k_ctr)
//				DO WHILE k_ctr > 0
//					k_Dose = Replace(k_Dose, k_ctr, 1, ".")
//					k_ctr = Pos(k_Dose, ",", k_ctr+1)
//				LOOP
//				if len(trim(k_dose)) = 0 or isnull(k_dose) then 
//					k_dose_n=0
//				else
//					k_Dose_n = double(trim(k_Dose))
//				end if
//				if len(trim(k_Composizione_prodotto)) = 0 or isnull(k_Composizione_prodotto) then 
//					k_Composizione_prodotto=" "
//				end if
//				if len(trim(k_Peso)) = 0 or isnull(k_Peso) then 
//					k_Peso=" "
//				end if
//				if len(trim(k_Densita)) = 0 or isnull(k_Densita) then 
//					k_Peso=" "
//				end if
//				if len(trim(k_Ciclo)) = 0 or isnull(k_Ciclo) then 
//					k_Ciclo=" "
//				end if
//				if len(trim(k_Dosimetrie_speciali)) = 0 or isnull(k_Dosimetrie_speciali) then 
//					k_Dosimetrie_speciali=" "
//				end if
//				if len(trim(k_SC_CF)) = 0 or isnull(k_SC_CF) then 
//					k_SC_CF=" "
//				end if
//				if len(trim(k_MC_CO)) = 0 or isnull(k_MC_CO) then 
//					k_MC_CO=" "
//				end if
//				if len(trim(k_Note)) = 0 or isnull(k_Note) then 
//					k_Note=" "
//				end if
//				
////--- conversione dei dati nel formato corretto (modello: 'nn fx')
//				if len(trim(left(k_ciclo, 1))) > 0 then
////--- cerca la scritta F1 = fila uno				
//					k_ctr = Pos(k_ciclo, "F1", 1)
//					if k_ctr > 0 then
//						k_fila1=integer(mid(k_ciclo, 1, k_ctr - 2))
//					else
//						k_fila1=0
//					end if
////--- cerca la scritta F2 = fila due
//					k_ctr = Pos(k_ciclo, "F2", 1)
//					if k_ctr > 0 then
//						k_fila2=integer(mid(k_ciclo, 1, k_ctr - 2))
//					else
//						k_fila2=0
//					end if
//				end if
//
//				
//				if k_routine = "0" then
//					k_routine_rec = " "
//				else
//					k_routine_rec = "S"
//				end if
//				
//				k_tipo = "3"
//				if k_Dispositivo_medico = "1" then
//					k_tipo = "1"
//				end if
//				if k_Prodotto_farmaceutico = "1" then
//					k_tipo = "2"
//				end if
//	
//				if len(trim(k_Codice_Cliente)) > 0 &
//				   and trim(k_Codice_Cliente) > "0" and trim(k_Codice_Cliente) <= "9" then 
//					k_clie=integer(k_Codice_Cliente)
//				else
//					k_clie=0
//				end if
//             
//
//// Find the first occurrence of old_str.
//				k_ctr = Pos(k_Dose_Minima, ",", k_ctr)
//// Only enter the loop if you find old_str.
//				DO WHILE k_ctr > 0
//// Replace old_str with new_str.
//					k_Dose_Minima = Replace(k_Dose_Minima, k_ctr, 1, ".")
//// Find the next occurrence of old_str.
//					k_ctr = Pos(k_Dose_Minima, ",", k_ctr+1)
//				LOOP
//				k_Dose_Minima_n = double(trim(k_Dose_Minima))
//
//// Find the first occurrence of old_str.
//				k_ctr = Pos(k_Dose_Max, ",", k_ctr)
//// Only enter the loop if you find old_str.
//				DO WHILE k_ctr > 0
//// Replace old_str with new_str.
//					k_Dose_Max = Replace(k_Dose_Max, k_ctr, 1, ".")
//// Find the next occurrence of old_str.
//					k_ctr = Pos(k_Dose_Max, ",", k_ctr+1)
//				LOOP
//				k_Dose_Max_n = double(trim(k_Dose_Max))
//
////--- ricostrisce il codice sl-pt con questo fomato: nnn/aa
//				k_ctr = Pos(trim(k_sl_pt), "/", 1)
//				if k_ctr < 4 and k_ctr > 0 then
//					k_sl_pt = fill("0", 4 - k_ctr) + trim(k_sl_pt) 
//				end if
//
////--- ricostrisce il codice mc-co con questo fomato: nnn/aa
//				k_ctr = Pos(trim(k_mc_co), "/", 1)
//				if k_ctr < 4 and k_ctr > 0 then
//					k_mc_co = fill("0", 4 - k_ctr) + trim(k_mc_co) 
//				end if
//
////--- ricostrisce il codice sc-cf con questo fomato: nnn/aa
//				k_ctr = Pos(trim(k_sc_cf), "/", 1)
//				if k_ctr < 4 and k_ctr > 0 then
//					k_sc_cf = fill("0", 4 - k_ctr) + trim(k_sc_cf) 
//				end if
//
//
//	         if len(trim(k_sl_pt)) > 0 then
//					INSERT INTO sl_pt  
//						( cod_sl_pt,   
//						  descr,   
//						  fila_1,   
//						  fila_2,   
//						  densita,   
//						  dose_min,   
//						  dose_max,   
//						  composizione,   
//						  peso,   
//						  routine,   
//						  dosimetrie_spec,   
//						  note_descr,   
//						  tipo,   
//						  magazzino,
//						  x_datins,   
//						  x_utente )  
//			       VALUES ( 
// 						 :k_SL_PT, 
//		 				 :k_Prodotto,
//						 :k_fila1,
//						 :k_fila2,
//						 :k_Densita, 
//						 :k_Dose_Minima_n, 
//						 :k_Dose_Max_n, 
//						 :k_Composizione_prodotto, 
//						 :k_Peso, 
//						 :k_routine_rec,
//						 :k_Dosimetrie_speciali, 
//						 :k_Note,
//						 :k_tipo,
//						 :k_magazzino,
// 				  		 :k_today,
//				  		 'batch'
//				 		) ; 
//					
////					k_Data, 
////					k_Codice_Cliente, 
////					k_Dose, 
////					k_Dimensioni_paletta,
////					k_SC_CF, 
////					k_MC_CO, 
////						 :k_Impianto, 
//
//					if sqlca.sqlcode = 0 then
//						k_nr_rec_scritti ++
//					else
//						if sqlca.sqldbcode = -1605 or sqlca.sqldbcode = -239 then
//							sqlca.sqlcode = 0
//							k_nr_rec_doppi++
//						end if
//					end if
//
//////--- se ok popola tab Contratti
////					if sqlca.sqlcode = 0 then
////						INSERT INTO contratti
////						( mc_co,
////						  sc_cf,
////						  data,
////						  cod_cli,
////						  descr,   
////						  cert_st_dose_min,   
////						  cert_st_dose_max,   
////						  cert_st_data_ini,   
////						  cert_st_data_fin,   
////						  x_datins,   
////						  x_utente )  
////			      	 VALUES ( 
//// 						 :k_mc_co, 
////		 				 :k_sc_cf,
////						 :k_data_d,
////						 :k_clie,
////						 :k_Prodotto, 
////						 'N',
////						 'N',
////						 'N',
////						 'N',
//// 				  		 :k_today,
////				  		 'batch'
////				 		) ; 
////					
////
////						if sqlca.sqlcode = 0 then
////							k_nr_rec_scritti_1 ++
////						else
////							if sqlca.sqldbcode = -1605 or sqlca.sqldbcode = -239 then
////								sqlca.sqlcode = 0
////								k_nr_rec_doppi_1 ++
////							end if
////						end if
////
////					end if	
//				end if	
////
//////--- popola il campo sc-cf (cap.di fornitura) su Contratti
////				if sqlca.sqlcode = 0 then
////					k_sc_cf = trim(k_sc_cf)
////					if len(k_sc_cf) > 0 then
////						update contratti
////						   set sc_cf = :k_sc_cf
////							where mc_co = :k_mc_co;
////					end if
////
//////--- popola il campo mc-co (cap.di fornitura) su LISTINO
////					k_sc_cf = trim(k_sc_cf)
////					if len(k_sc_cf) > 0 then
////						update listino
////						   set sl_pt = :k_sl_pt
////							where mc_co = :k_mc_co;
////					end if
////				end if
//
//				if sqlca.sqlcode = 0 then
//						
//					fetch c_contratti into 
//							:k_SL_PT, 
//							:k_Data, 
//							:k_Impianto, 
//							:k_Dispositivo_medico,
//							:k_Prodotto_farmaceutico, 
//							:k_Codice_Cliente, 
//							:k_Prodotto,
//							:k_Dose, 
//							:k_Dose_Minima, 
//							:k_Dose_Max, 
//							:k_Composizione_prodotto, 
//							:k_Peso, 
//							:k_Densita, 
//							:k_Ciclo, 
//							:k_Routine, 
//							:k_Dosimetrie_speciali, 
//							:k_SC_CF, 
//							:k_MC_CO, 
//							:k_Note
//							;
//				else
//					SetPointer(oldpointer)
//					k_errore = 1
//					MessageBox("Stop forzato all'utility","Errore durante inserimento riga:" + string(sqlca.sqlcode, "#####") , &
//					StopSign!)
//	
//				end if	
//				
//				
//				
//			loop
//	
//			if sqlca.sqlcode < 0 or k_sqlca_ext.sqlcode < 0 then
//				SetPointer(oldpointer)
//				MessageBox("Stop forzato all'utility","Errore durante inserimento riga:" &
//				    + sqlca.sqlerrtext, &
//					   StopSign!)
//			end if
//	
//			close c_contratti;
//		end if		
//   end if
//
//	
//	SetPointer(oldpointer)
//
//	if k_errore = 0 then
//		MessageBox("Migrazione su Informix Terminata", &
// 		           "Controllare archivi SL-PT e CONTRATTI ~n~r" &
//						+ "   Rec letti da ACCESS .......:" + string(k_nr_rec_letti, "####") + "~n~r" &
//						+ "   Inseriti rec su SL-PT .....:" + string(k_nr_rec_scritti, "####") + "~n~r" &
//						+ "      rec doppi non trasferiti:" + string(k_nr_rec_doppi, "####")  + "~n~r" &
//						+ "   Inseriti rec su CONTRATTI .:" + string(k_nr_rec_scritti_1, "####") + "~n~r" &
//						+ "      rec doppi non trasferiti:" + string(k_nr_rec_doppi_1, "####"), &
//					Information!)
//	end if
//	
//	 
//
return k_nr_rec_scritti
//
end function

public function integer ext_popola_ric_id ();//
//=== Estemporanea da lanciare una sola volta
//=== Popola il campo CLIENTE in tab RIC dalla ARFA
//=== AL TERMINE DEL PROGRAMMA:
//===    CREARE LA CONSTRAIN PRIMARY KEY E SERIAL PER IL CAMPO ID

int k_errore=0
string k_record
st_tab_ricevute kst_tab_ric
int k_codice
long k_id, k_num_fatt
//string k_descr, k_descr_l, k_sc_cf, k_sc_cf_l, k_err_str
date k_data_fatt //, k_scad
pointer oldpointer  // Declares a pointer variable




if messagebox("Popola Tabella RIC", &
	              "Inserisce il valore del campo CLIENTE partendo dalla ARFA ~n~r" + &
	              " ", &
						exclamation!, yesno!, 1) = 2 then

	MessageBox("Elaborazione non eseguita", &
		           "Elaborazione Interrotta dall'utente", &
						StopSign!)
else

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

	declare c_RIC cursor  for 
		select  data_fatt, num_fatt 
			from  RIC
			where clie = 0
			order by data_fatt
			;

	open c_RIC;
	k_id = 0
			
	k_codice = 0 
	k_data_fatt = date("2001-12-31")
	
	if sqlca.sqlcode = 0 then
		
		
		fetch c_RIC into :k_data_fatt, :k_num_fatt;
		
		k_id = k_id + 1
	
   	do while sqlca.sqlcode = 0 
			
			k_codice++
			kst_tab_ric.clie = 0
			select distinct clie_3 
				into :kst_tab_ric.clie
					from arfa 
					where 
				   data_fatt = :k_data_fatt
					and num_fatt = :k_num_fatt;
			if kst_tab_ric.clie = 0 or isnull(kst_tab_ric.clie = 0) then
				select distinct clie_3 
					into :kst_tab_ric.clie
						from arfa_v 
						where 
						data_fatt = :k_data_fatt
						and num_fatt = :k_num_fatt;
			end if
			update RIC set clie = :kst_tab_ric.clie
				where 
				   data_fatt = :k_data_fatt
					and num_fatt = :k_num_fatt
					;
					
			if sqlca.sqlcode = 0 then

				
				fetch c_RIC into :k_data_fatt, :k_num_fatt;
				k_id = k_id + 1
	
				if sqlca.sqlcode < 0 then
					k_errore = 1
					SetPointer(oldpointer)
					MessageBox("Stop forzato all'utility","Errore durante lettura riga:" &
							+ string(sqlca.sqldbcode, "#####") + "; " + string(sqlca.sqlcode, "#####") &
						   + " " + sqlca.sqlerrtext, StopSign!)
				end if

			else
				k_errore = 1
				SetPointer(oldpointer)
				MessageBox("Stop forzato all'utility (1) ","Errore durante aggiornamento riga:" &
							+ string(sqlca.sqldbcode, "#####") + "; " + string(sqlca.sqlcode, "#####") , &
				StopSign!)

			end if	
			
		
		loop


		close c_RIC;
	end if		

	SetPointer(oldpointer)

	if k_errore = 0 then
		MessageBox("Conversione Terminata", "Elaborazione OK!, rec Letti da ARFA:" + string(k_codice, "####") + "  aggiornati in RIC:" + string(k_id, "####"), &
					Information!)

	end if
	
end if	
	 
SetPointer(oldpointer)

return k_codice

end function

public function string u_stringa_campi_dw (integer k_tipo, long k_riga, ref datawindow k_dw);//---
//--- Legge tutti i campi della dw e li compatta in un unico campo
//---
//--- parametri di input:
//---    k_tipo tipo elaborazione: 1=stringa tutti campi di 1 riga da dw
//---    k_riga num. riga del dw
//---    k_dw la datawindows da proteggere/sproteggere
//---
//--- parametro di out: stringa con i campi della DW
//---
int k_rc
string  k_item , k_coltype, k_stringa=""
int k_ctr, k_taborder, k_colcount


	k_stringa = trim(k_dw.dataobject)

	k_colcount = integer(k_dw.Describe("DataWindow.Column.Count"))

	for k_ctr = 1 to k_colcount 

		k_taborder=integer(k_dw.Describe("#" + trim(string(k_ctr,"###"))+".TabSequence"))
		if k_taborder > 0 then
				
			k_coltype = k_dw.Describe("#" + trim(string(k_ctr,"###"))+".Coltype")
					
			choose case upper(left(k_coltype,2))
					
				case "CH"
					 k_item  = k_dw.getitemstring(k_riga, k_ctr)
					
				case "DA"
					 k_item  = string(k_dw.getitemdate(k_riga, k_ctr))

				case "TI"
					 k_item  = string(k_dw.getitemtime(k_riga, k_ctr))
	
				case else
					 k_item  = string(k_dw.getitemnumber(k_riga, k_ctr))
					
			end choose

			if isnull( k_item ) then
				 k_item  = ";"
			else
				k_item = trim(k_item) + ";"
			end if
			
			k_stringa += k_item
			
		end if
					
	next


return  k_stringa 

end function

public function string u_dw_copia (integer k_tipo, ref datawindow k_dw_source, ref datawindow k_dw_target);//---
//--- Copia DW in DW mettendo anche le Proprieta' del sorgente
//--- le quali si possono aggiungere man mano che servono 
//---
//--- parametri di input:
//---    k_tipo tipo elaborazione: 1=
//---    k_dw_source  la dw sorgente
//---    k_dw_target  la dw in cui copiare
//---
//--- parametro di out: stringa se ""=OK se <> "" allora errore 
//---
int k_rc
string  k_rcx, k_str, k_string, k_xx, k_nome
int k_ctr, k_colcount
long k_num


	
//--- Copia delle RIGHE
	k_rc = k_dw_source.rowscopy(1,k_dw_source.rowcount(), &
									primary!,k_dw_target,1,primary!)

	k_colcount = integer(k_dw_source.Describe("DataWindow.Column.Count"))

//--- copia Proprieta' PRINT ORIENTATIONE della dw
	k_rcx=k_dw_target.modify("DataWindow.Print.Orientation= '" &
									+ trim(k_dw_source.describe("DataWindow.Print.Orientation")) + "'")
	k_string = k_string + k_rcx 		

	for k_ctr = 1 to k_colcount 

//--- estrae nome colonna
		k_nome = trim(k_dw_source.Describe("#" + trim(string(k_ctr,"###")) + ".name"))

		
//--- copia Proprieta' TESTATA della colonna
		k_rcx=k_dw_target.modify( k_nome &
		                        + "_t" &
		                        + ".visible = " &
		                        + k_dw_source.Describe("#" + trim(string(k_ctr,"###")) + ".visible") &
										+ " " )
		k_string = k_string + k_rcx 										
		
//--- copia Proprieta' TESTO della TESTATA della colonna
		k_xx = k_dw_source.Describe(k_nome + "_t.text")
		k_rcx=k_dw_target.modify( k_nome + "_t" + ".text = " + trim(k_xx) &
										+ " " )
		k_string = k_string + k_rcx 										
		
//--- copia Proprieta' VISIBLE
		k_rcx=k_dw_target.modify("#" + trim(string(k_ctr,"###")) + ".visible = " &
		                        + k_dw_source.Describe("#" + trim(string(k_ctr,"###")) + ".visible") &
										+ " " )
		k_string = k_string + k_rcx 										

//--- copia Proprieta' WIDTH
		k_rcx=k_dw_target.modify("#" + trim(string(k_ctr,"###")) + ".Width = " &
		                        + k_dw_source.Describe("#" + trim(string(k_ctr,"###")) + ".Width") &
										+ " " )
		k_string = k_string + k_rcx 										

//--- copia Proprieta' HEIGHT
		k_rcx=k_dw_target.modify("#" + trim(string(k_ctr,"###")) + ".Height = " &
		                        + k_dw_source.Describe("#" + trim(string(k_ctr,"###")) + ".Height") &
										+ " " )
		k_string = k_string + k_rcx 										
		
	next


return  trim(k_string) 

end function

public function integer u_setfocus (unsignedlong k_hwnd);//
int k_return=0
environment k_env

//
//	if getenvironment(k_env) = 1 then
//
////=== Win 3.xx
//		if k_env.OSMajorRevision = 3 and &
//			k_env.OSMinorRevision <> 95 then
//	
//			k_return = Setfocus3 (k_hwnd)
//		else
////=== Win a 32 bit
//			k_return = Setfocus (k_hwnd)
//		end if
//		
//	else
//		k_return = -1
//	end if		
	
return k_return


end function

public function unsignedlong u_findwindow (unsignedlong k_classe, string k_window);//
ulong k_return=0
environment k_env


	if getenvironment(k_env) = 1 then

//=== Win 3.xx
		if k_env.OSMajorRevision = 3 and &
			k_env.OSMinorRevision <> 95 then
	
			k_return = FindWindowA3 (k_classe, k_window)
		else
//=== Win a 32 bit
			k_return = FindWindowA (k_classe, k_window)
		end if
		
	else
		k_return = 0
	end if		
	
return k_return


end function

public subroutine u_ds_toglie_ddw (integer k_tipo, ref datastore k_dw_source);//---
//--- Toglie le colonne DDW dal datastore solo se NON sono AutoRetrieve
//---
//--- parametri di input:
//---    k_tipo tipo elaborazione: 1=
//---    k_dw_source  la dw sorgente
//---
//---
int k_colcount, k_ctr
string k_rc


	
k_colcount = integer(k_dw_source.Describe("DataWindow.Column.Count"))

for k_ctr = 1 to k_colcount 

	if trim(k_dw_source.describe("#"+trim(string(k_ctr))+".DDDW.Name")) <> "?" then
		if trim(k_dw_source.describe("#"+trim(string(k_ctr))+".DDDW.AutoRetrieve")) = "yes" then
		else
			k_rc = k_dw_source.Modify("#"+trim(string(k_ctr))+".DDDW.Name=' '")
		end if
	end if	

end for


end subroutine

public subroutine u_dw_toglie_ddw (integer k_tipo, ref datawindow k_dw_source);//---
//--- Toglie le colonne DDW dal Datawindow (solo se non sono AutoRetrieve)
//---
//--- parametri di input:
//---    tipologia dell'operazione
//---    k_dw_source  la dw a cui togliere le ddw
//---
//---
int k_colcount, k_ctr
string k_rc


	
k_colcount = integer(k_dw_source.Describe("DataWindow.Column.Count"))

for k_ctr = 1 to k_colcount 

	if trim(k_dw_source.describe("#"+trim(string(k_ctr))+".DDDW.Name")) <> "?" then
		if trim(k_dw_source.describe("#"+trim(string(k_ctr))+".DDDW.AutoRetrieve")) = "yes" then
		else
			k_rc = k_dw_source.Modify("#"+trim(string(k_ctr))+".DDDW.Name=' '")
		end if
	end if	

end for


end subroutine

public function st_esito errori_visualizza_log (integer k_tipo);//===
//=== Legge Errori di M2000
//===
//
string k_file 
//string k_path
st_esito kst_esito
kuf_ole kuf1_ole

 
//=== Clessidra di attesa
	setpointer(hourglass!)

	kst_esito = kguo_exception.inizializza(this.classname())

//	k_path = kGuf_data_base.profilestring_leggi_scrivi (1, "arch_base", " ")

	k_file = kguo_path.get_nome_file_errori_txt()  //trim(k_path) + "\" + kGuf_data_base.ki_nome_file_errori

	if len(trim(k_file)) > 0 then 
	
		kuf1_ole = create kuf_ole
		kst_esito = kuf1_ole.open_txt( k_file )
		if kst_esito.esito <> "0" then
			kst_esito = kuf1_ole.open_doc( k_file )
		end if
		destroy kuf1_ole
			
	end if		
	
	if kst_esito.esito <> "0" then

		kst_esito.sqlerrtext = trim(kst_esito.sqlerrtext) + "~n~r" + "File:" + trim(k_file)
		
	end if		
	
							
return kst_esito


end function

public function st_esito errori_visualizza_log_informix (integer k_tipo);//===
//=== Legge Errori di M2000
//===
//
string k_file 
string k_path
st_esito kst_esito
kuf_ole kuf1_ole


//=== Clessidra di attesa
	setpointer(hourglass!)

	k_path = kGuf_data_base.profilestring_leggi_scrivi (1, "arch_4gi", " ")

	k_file = trim(k_path) + "\errorlog"

	if len(trim(k_file)) > 0 then 
	
		kuf1_ole = create kuf_ole
		kst_esito = kuf1_ole.open_txt( k_file )
		if kst_esito.esito <> "0" then
			kst_esito = kuf1_ole.open_doc( k_file )
		end if
		destroy kuf1_ole
		
	end if
	
	if kst_esito.esito <> "0" then

		kst_esito.sqlerrtext = trim(kst_esito.sqlerrtext) + "~n~r" + "File:" + trim(k_file)
		
	end if		
	
							
return kst_esito


end function

public function string u_stringa_pulisci (string k_stringa);//
//--- restituisce campo stringa senza caratteri speciali
//--- i caratteri:  .'/|\:*spazio~~ e gli  'a capo' come: ~n o ~r o ~t"  diventano: "_", mentre: [(])+-~  li toglie
//
string k_return_stringa
string k_old_str, k_new_str
int k_start_pos

		k_return_stringa = k_stringa
		k_start_pos = 1
		k_old_str = " "
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = ":"
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "\"
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "/"
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "."
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = ","
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "*"
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "'"
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "|"
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "~~"
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "~t"
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "~r"
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "~n"
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "~""
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "("
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = ")"
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "["
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "]"
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "+"
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "-"
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "<"
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = ">"
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP

return k_return_stringa

end function

public function st_esito u_dw_check_dup_row (ref datawindow kdw_buffer, string k_key[5]);//---
//--- Controlla se ci sono righe doppie nel dw
//---
//--- parametri di input:
//---    kdw_buffer = data window sulla quale cercare la riga doppia
//---    k_keyN = nomi campi chiavi univoche sulle quali effettuare la ricerca 
//---
//--- parametri di output: st_esito (0=ok) in sqlcode il nr.riga in cui c'e' il doppio
//---
string k_sort = "", k_filter = ""
int k_ctr
st_esito kst_esito 


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

for k_ctr = 1 to 5 
	if len(trim(k_key[k_ctr])) > 0 then
		if len(trim(k_sort)) > 0 then
			k_sort = k_sort + ", "
		end if
		k_sort = k_sort + trim(k_key[k_ctr]) + " A "
	end if
end for
for k_ctr = 1 to 5 
	if len(trim(k_key[k_ctr])) > 0 then
		if len(trim(k_filter)) > 0 then
			k_filter = k_filter + " and "
		end if
		k_filter = k_filter + trim(k_key[k_ctr]) + " = " + trim(k_key[k_ctr]) + "[-1]"
	end if
end for

//--- sort e filtra solo le righe 
kdw_buffer.setsort(k_sort)
kdw_buffer.sort()
kdw_buffer.setfilter(k_filter)
kdw_buffer.filter()
//--- se ci sono righe allora sono quelle doppie
if kdw_buffer.rowcount() > 0 then
	kst_esito.esito = "1"
	kst_esito.sqlcode = kdw_buffer.getitemnumber(1, "row_num")
end if

return kst_esito
end function

public function string u_nome_computer ();//
//--- torna il nome del PC
//
String ls_name
ulong li_size
long ll_ret

li_size = 255
ls_name = FillA(" ",255)
ll_ret = GetComputerNameA( ls_name , li_size ) 

return ls_name


end function

private subroutine u_stored_procedure ();
//--- 
//=== 
//=== DROP/CREA STORED PROCEDURE SPL  SOLO PRIMA VOLTA 
//===
//===
//=== COPIA + INCOLLA + DECOMMENTA + LANCIA IN AMBIENTE SQL 
//===   
//====================================================================
////string k_sql_d
////st_esito kst_esito
////
////
////kst_esito.esito = kkg_esito.ok
////kst_esito.sqlcode = 0
////kst_esito.SQLErrText = ""
////
//////--- Cancello e ricreo la view
////	k_sql_d = "drop view " + trim(k_view) + "  " 
////	EXECUTE IMMEDIATE :k_sql_d using sqlca;
////	commit using sqlca;
////	EXECUTE IMMEDIATE :k_sql using sqlca;
////
////	kst_esito.sqlerrtext = "Generazione terminata correttamente "
////	if sqlca.sqlcode <> 0 then
////		rollback using sqlca;
////		if sqlca.sqlcode > 0 then
////			kst_esito.esito = kkg_esito.db_wrn
////			kst_esito.sqlcode = sqlca.sqlcode
////			kst_esito.sqlerrtext = "Anomalie durante generazione View '" &
////			                       + trim(k_view) + "' err.:" + trim(SQLCA.SQLErrText)
////		else
////			kst_esito.esito = kkg_esito.db_ko
////			kst_esito.sqlcode = sqlca.sqlcode
////			kst_esito.sqlerrtext = "Generazione View '" &
////			                       + trim(k_view) + "' non riuscita:" + trim(SQLCA.SQLErrText)
////		end if
////	else
////		commit using sqlca;
////	end if
//

////--- SPL utile per la tv
//return kst_esito
//drop procedure tv_meca_artr_dett;
//create procedure tv_meca_artr_dett ( k_data_da date, k_data_a date, k_tipo char(1)  )
//returning
//				  int as num_certif, 
//				  int as colli, 
//				  int as colli_trattati, 
//				  int as colli_groupage, 
//				  int as id_armo, 
//				  int as colli_2, 
//				  int as id, 
//				int as num_int, 
//				date as data_int, 
//				char(1) as area_mag, 
//	         int as clie_1,  
//	         int as clie_2,  
//	         int as clie_3,  
//				int as num_bolla_in, 
//				date as data_bolla_in, 
//	         date as data_lav_fin,    
//        		char(1) as err_lav_fin,     
//	         date as dosim_data,    
//	         real as dosim_dose,    
//	         char(1) as err_lav_ok,    
//		      char(30) as note_lav_ok,   
//		      int   as dosim_assorb,   
//		      int   as dosim_spessore,   
//		      real   as dosim_rapp_a_s,   
//		      char(12)   as dosim_lotto_dosim,   
//		      char(1)   as cert_forza_stampa,   
//				int	as contratto, 
//		      char(40)  as rag_soc_1, 
//		      char(40)   as rag_soc_2, 
//		      char(40)   as rag_soc_3 ;
//
//
//define num_certif, colli, colli_trattati, colli_groupage, id_armo, colli_2, id, num_int, clie_1, clie_2, clie_3, num_bolla_in, dosim_assorb, dosim_spessore, contratto int;
//define data_int, data_bolla_in, data_lav_fin, dosim_data date;
//define err_lav_fin, err_lav_ok, cert_forza_stampa char(1) ; 
//define dosim_dose, dosim_rapp_a_s real;
//define note_lav_ok, rag_soc_1, rag_soc_2, rag_soc_3 char (40);
//define dosim_lotto_dosim, area_mag char(16);
//
//		  	SELECT 
//			      artr.num_certif, 
//			      sum(artr.colli), 
//			      sum(artr.colli_trattati), 
//			      sum(artr.colli_groupage), 
//			      armo.id_armo, 
//			      armo.colli_2, 
//			      meca.id, 
//					meca.num_int, 
//					meca.data_int, 
//					meca.area_mag, 
//		         meca.clie_1,  
//		         meca.clie_2,  
//		         meca.clie_3,  
//					meca.num_bolla_in, 
//					meca.data_bolla_in, 
//		         meca.data_lav_fin,    
//         		meca.err_lav_fin,     
//		         meca_dosim.dosim_data,    
//		         meca_dosim.dosim_dose,    
//		         meca.err_lav_ok,    
//		         meca.note_lav_ok,   
//		         meca_dosim.dosim_assorb,   
//		         meca_dosim.dosim_spessore,   
//		         meca_dosim.dosim_rapp_a_s,   
//		         meca_dosim.dosim_lotto_dosim,   
//		         meca.cert_forza_stampa,   
//					meca.contratto, 
//		         c1.rag_soc_10, 
//		         c2.rag_soc_10, 
//		         c3.rag_soc_10 
//	into
//  				   num_certif, 
//			      colli, 
//			      colli_trattati, 
//			      colli_groupage, 
//			      id_armo, 
//			      colli_2, 
//			      id, 
//					num_int, 
//					data_int, 
//					area_mag, 
//		         clie_1,  
//		         clie_2,  
//		         clie_3,  
//					num_bolla_in, 
//					data_bolla_in, 
//		         data_lav_fin,    
//         		err_lav_fin,     
//		         dosim_data,    
//		         dosim_dose,    
//		         err_lav_ok,    
//		         note_lav_ok,   
//		         dosim_assorb,   
//		         dosim_spessore,   
//		         dosim_rapp_a_s,   
//		         dosim_lotto_dosim,   
//		         cert_forza_stampa,   
//					contratto, 
//		         rag_soc_1, 
//		         rag_soc_2, 
//		         rag_soc_3 	
//
//		    FROM  (((((( 
//			   artr INNER JOIN armo ON  
//				  artr.id_armo = armo.id_armo) 
//		           inner JOIN meca ON  
//			     armo.id_meca = meca.id) 
//					  LEFT OUTER JOIN meca_dosim ON  
//				  meca.id = meca_dosim.id_meca) 
//					  LEFT OUTER JOIN clienti c1 ON  
//				  meca.clie_1 = c1.codice) 
//					  LEFT OUTER JOIN clienti c2 ON  
//				  meca.clie_2 = c2.codice) 
//					  LEFT OUTER JOIN clienti c3 ON  
//				  meca.clie_3 = c3.codice) 
//						 left outer JOIN sl_pt ON  
//						 armo.cod_sl_pt = sl_pt.cod_sl_pt 
//				where  
//					 artr.data_in > '01.06.2003' 
//					 and (artr.data_in >= k_data_da and artr.data_in < k_data_a) and 
//					 (artr.data_st <= k_data_a or artr.data_st is null) 
//					 and (meca_dosim.dosim_data > k_data_da 
//					  and artr.data_fin > k_data_a) 
//					 and (meca.err_lav_ok <> '1' or meca.err_lav_ok is null or meca.cert_forza_stampa = '1') 
//					 and (meca.err_lav_fin <> '1' or meca.err_lav_fin is null or meca.cert_forza_stampa = '1') 
//					 and artr.num_certif > 0 
//					 and ((sl_pt.tipo is null or sl_pt.tipo = k_tipo 
//						  or sl_pt.tipo is null or sl_pt.tipo = k_tipo ) 
//							 or ((sl_pt.tipo = k_tipo and meca.cert_farma_st_ok = '1') 
//							  or (sl_pt.tipo = k_tipo and meca.cert_aliment_st_ok = '1') 
//							   )) 
//									
//			 group by 
//			      artr.num_certif, 
//			      armo.id_armo, 
//			      armo.colli_2, 
//			      meca.id, 
//					meca.num_int, 
//					meca.data_int, 
//					meca.area_mag, 
//		         meca.clie_1,  
//		         meca.clie_2,  
//		         meca.clie_3,  
//					meca.num_bolla_in, 
//					meca.data_bolla_in, 
//		         meca.data_lav_fin,    
//         		meca.err_lav_fin,     
//		         meca_dosim.dosim_data,    
//		         meca_dosim.dosim_dose,    
//		         meca.err_lav_ok,    
//		         meca.note_lav_ok,   
//		         meca_dosim.dosim_assorb,   
//		         meca_dosim.dosim_spessore,   
//		         meca_dosim.dosim_rapp_a_s,   
//		         meca_dosim.dosim_lotto_dosim,   
//		         meca.cert_forza_stampa,   
//					meca.contratto, 
//		         c1.rag_soc_10, 
//		         c2.rag_soc_10, 
//		         c3.rag_soc_10 
//			 order by 
//				 artr.num_certif desc;
//
//
//
//
//return 
//			      num_certif, 
//			      colli, 
//			      colli_trattati, 
//			      colli_groupage, 
//			      id_armo, 
//			      colli_2, 
//			      id, 
//					num_int, 
//					data_int, 
//					area_mag, 
//		         clie_1,  
//		         clie_2,  
//		         clie_3,  
//					num_bolla_in, 
//					data_bolla_in, 
//		         data_lav_fin,    
//         		err_lav_fin,     
//		         dosim_data,    
//		         dosim_dose,    
//		         err_lav_ok,    
//		         note_lav_ok,   
//		         dosim_assorb,   
//		         dosim_spessore,   
//		         dosim_rapp_a_s,   
//		         dosim_lotto_dosim,   
//		         cert_forza_stampa,   
//					contratto, 
//		         rag_soc_1, 
//		         rag_soc_2, 
//		         rag_soc_3 ;
//
//
//end procedure;
//
end subroutine

public function integer ext_popola_id_meca ();//
//=== Estemporanea da lanciare una sola volta
//===
//=== AL TERMINE DEL PROGRAMMA:
//===

int k_errore=0, k_codice=0, k_codici_doppi=0, k_codice_barcode=0
long k_num_int, k_id
date k_data
pointer oldpointer  // Declares a pointer variable




if messagebox("Aggiornamento id_meca in tabella ARMO", &
	              " ~n~r" + &
	              "l'utility di popolamento del ARMO!!!", &
						exclamation!, yesno!, 1) = 2 then

	MessageBox("Elaborazione non eseguita", &
		           "Elaborazione Interrotta dall'utente", &
						StopSign!)
else

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


   declare CURSORE_meca cursor for
		select meca.num_int, meca.data_int, meca.id
			from armo inner join meca on  
			    armo.num_int = meca.num_int and armo.data_int = meca.data_int 
			where (armo.id_meca = 0 or armo.id_meca is null) 
			order by meca.num_int;	

	open cursore_meca;
	
	if sqlca.sqlcode = 0 then
		
		fetch cursore_meca into :k_num_int, :k_data, :k_id;
	
   	do while sqlca.sqlcode = 0 
			
			if k_id > 0 then 

  				update armo
					set id_meca = :K_id
					where num_int = :K_num_int
					and  data_int = :k_data;


				if sqlca.sqlcode = 0 then
					k_codice ++
				else
					if sqlca.sqldbcode = -1605 or sqlca.sqldbcode = -239 then
						sqlca.sqlcode = 0
						k_codici_doppi++
					end if
				end if
			end if
			
			if sqlca.sqlcode = 0 then

				fetch cursore_meca into :k_num_int, :k_data, :k_id;

			else
				k_errore = 1
				SetPointer(oldpointer)
				MessageBox("Stop forzato all'utility (1) ","Errore durante aggiornamento riga:" &
							+ string(sqlca.sqldbcode, "#####") + "; " + string(sqlca.sqlcode, "#####") , &
				StopSign!)

			end if	
			
		
		loop

		if sqlca.sqlcode < 0 then
				SetPointer(oldpointer)
				MessageBox("Stop forzato all'utility","Errore durante aggiornamento riga:" &
							+ string(sqlca.sqldbcode, "#####") + "; " + string(sqlca.sqlcode, "#####") &
						   + " " + sqlca.sqlerrtext, StopSign!)
			rollback using sqlca;
		end if

		close cursore_meca;

		commit using sqlca;
		
	end if		



   declare CURSORE_barcode cursor for
		select meca.num_int, meca.data_int, meca.id
			from barcode inner join meca on  
			    barcode.num_int = meca.num_int and barcode.data_int = meca.data_int 
			where (barcode.id_meca = 0 or barcode.id_meca is null) 
			order by meca.num_int;	

	open cursore_barcode;
	
	if sqlca.sqlcode = 0 then
		
		fetch cursore_barcode into :k_num_int, :k_data, :k_id;
	
   	do while sqlca.sqlcode = 0 
			
			if k_id > 0 then 

  				update barcode
					set id_meca = :K_id
					where num_int = :K_num_int
					and  data_int = :k_data;


				if sqlca.sqlcode = 0 then
					k_codice_barcode ++
				else
					if sqlca.sqldbcode = -1605 or sqlca.sqldbcode = -239 then
						sqlca.sqlcode = 0
						k_codici_doppi++
					end if
				end if
			end if
			
			if sqlca.sqlcode = 0 then

				fetch cursore_barcode into :k_num_int, :k_data, :k_id;

			else
				k_errore = 1
				SetPointer(oldpointer)
				MessageBox("Stop forzato all'utility (1) ","Errore durante aggiornamento riga:" &
							+ string(sqlca.sqldbcode, "#####") + "; " + string(sqlca.sqlcode, "#####") , &
				StopSign!)

			end if	
			
		
		loop

		if sqlca.sqlcode < 0 then
				SetPointer(oldpointer)
				MessageBox("Stop forzato all'utility","Errore durante aggiornamento riga:" &
							+ string(sqlca.sqldbcode, "#####") + "; " + string(sqlca.sqlcode, "#####") &
						   + " " + sqlca.sqlerrtext, StopSign!)
			rollback using sqlca;
		end if

		close cursore_barcode;
		commit using sqlca;
		
	end if		






	SetPointer(oldpointer)

	if k_errore = 0 then
		MessageBox("Elaborazione Terminata", "Elaborazione OK!," &
		          + " aggiornati rec in ARMO/BARCODE:  " + string(k_codice, "###0") &
		          + " / " + string(k_codice_barcode, "###0"), &
					Information!)
	end if
	
end if	
	 
SetPointer(oldpointer)

return k_codice

end function

public function boolean u_check_network ();//---
//---  Controlla se PC connesso alla Rete
//---  Out:  false=non connesso; true=connesso
//---
boolean k_return = true

// The computer has one or more LAN cards that are active.
CONSTANT integer NETWORK_ALIVE_LAN = 1;
// The computer has one or more active RAS connections (internet).
CONSTANT integer NETWORK_ALIVE_WAN = 2;
// Win9x. The computer is connected to the America Online network.
//CONSTANT integer NETWORK_ALIVE_AOL = 4;

OleObject wsh
int networkState, k

try 
	
	// to do the "bitwise AND" later...
	wsh = CREATE OleObject
	if isvalid(wsh) then
		if wsh.ConnectToNewObject( "MSScriptControl.ScriptControl" ) < 0 then
			k_return = false
		else
			
			wsh.language = "vbscript"
			
			
			IF IsNetworkAlive(networkState) THEN
				// check if a network card is active
				k = integer(wsh.Eval( string(networkState) + &
											  " AND " + &
											 string(NETWORK_ALIVE_LAN)))
				IF k = NETWORK_ALIVE_LAN THEN
					k_return = true
				ELSE
					k_return = false
				END IF  
			else
				k_return = false
			end if
		end if
	else
		k_return = false
	end if	
catch (uo_exception kuo_exception)
	k_return = false
//   MessageBox("","no network ?!?")

finally 

	destroy wsh
	
END try

return k_return



end function

public function boolean u_check_caps_on ();//---
//---  Torna a TRUE=tastiera su CAPS ON; FALSE = CAPS OFF
//---
boolean k_return=false
int li_keystate=0


//li_keystate = GetAsyncKeyState(20)
li_keystate = GetKeyState(20)

IF li_keystate = 1 THEN
	k_return = true
//    MessageBox("", "CAPS on")
ELSEIF li_keystate = 0 THEN
	k_return = false
//    MessageBox("", "CAPS off")
END IF

return k_return


 
end function

public function integer ext_popola_tab_nazioni ();//
//=== Carica da File Nazioni (ISO 3166-1) la tabella Nazioni
//=== 
//=== 
//=== 

int k_errore=0
string k_record, k_path, k_nome_file, k_ext
int k_ctr, k_ctr1, k_rc, k_file, k_bytes, k_righe
st_tab_nazioni kst_tab_nazioni
pointer oldpointer  // Declares a pointer variable




if messagebox("Trasferimento dati", &
	              "Carica dal file Nazioni la tabella~n~r" + &
	              " ", &
						exclamation!, yesno!, 1) = 2 then

	MessageBox("Elaborazione non eseguita", &
		           "Elaborazione Interrotta dall'utente", &
						StopSign!)
else

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

	k_rc = GetFileOpenName("Scegli Archivio 'Nazioni'", &
									k_path, k_nome_file, k_ext, "TXT File (*.txt),*.txt") 


	if k_rc <= 0 or len(trim(k_nome_file)) = 0 then
		k_path = " "
		
	else
		k_file = fileopen( trim(k_path), linemode!, read!, lockreadwrite!)
		
		if k_file > 0 then
	
			k_bytes = fileread(k_file, k_record) // legge una riga
			k_righe = 0
			k_ctr = 0
			do while k_bytes <> -100 
				k_bytes = fileread(k_file, k_record) // legge una riga
				
				k_ctr=1
				k_ctr = pos(k_record,  "~t", k_ctr) 
				kst_tab_nazioni.id_nazione = mid(k_record, 1, k_ctr)
				k_ctr++
				k_ctr1 = pos(k_record,  "~t", k_ctr) 
				kst_tab_nazioni.nome = mid(k_record, k_ctr, k_ctr1 - k_ctr)
				k_ctr = k_ctr1 + 1
				kst_tab_nazioni.area = mid(k_record, k_ctr, k_bytes - k_ctr + 1)
				
				if len(trim(kst_tab_nazioni.id_nazione)) > 0 then 
	
					insert into nazioni (
								  id_nazione 
								, nome
								, area 
							 ) values
								( 
								 :kst_tab_nazioni.id_nazione     
								 ,:kst_tab_nazioni.nome     
								 ,:kst_tab_nazioni.area     
							)      ;
	
				
					k_righe++     //conta le righe 
				end if
			loop
			fileclose(k_file)
		end if
	end if		

	SetPointer(oldpointer)

	if k_errore = 0 then
		MessageBox("Conversione Terminata", "Elaborazione OK!, inseriti rec in NAZIONI:" + string(k_righe, "####"), &
					Information!)
	end if
	
end if	
	 
SetPointer(oldpointer)

return k_righe

end function

public function integer ext_popola_tab_cap ();//
//=== Carica da File Nazioni (ISO 3166-1) la tabella Nazioni
//=== 
//=== 
//=== 

int k_errore=0
string k_record, k_path, k_nome_file, k_ext
int k_ctr, k_ctr1, k_rc, k_file, k_bytes, k_righe
st_tab_cap kst_tab_cap, kst_tab_cap_save
pointer oldpointer  // Declares a pointer variable




if messagebox("Trasferimento dati", &
	              "Carica dal file deo CAP postali la tabella~n~r" + &
	              " ", &
						exclamation!, yesno!, 1) = 2 then

	MessageBox("Elaborazione non eseguita", &
		           "Elaborazione Interrotta dall'utente", &
						StopSign!)
else

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

	k_rc = GetFileOpenName("Scegli Archivio 'CAP'", &
									k_path, k_nome_file, k_ext, "TXT File (*.txt),*.txt") 


	if k_rc <= 0 or len(trim(k_nome_file)) = 0 then
		k_path = " "
		
	else
		k_file = fileopen( trim(k_path), linemode!, read!, lockreadwrite!)
		
		if k_file > 0 then
	
			k_bytes = fileread(k_file, k_record) // legge una riga
			k_righe = 0
			k_ctr = 0
			kst_tab_cap_save.cap = " "
//			do while k_bytes <> -100 
//				
//				k_ctr=1
////				k_ctr = pos(k_record,  "~t", k_ctr) 
//				kst_tab_cap.prov = mid(k_record, 1, 2)
//				kst_tab_cap.cap = mid(k_record, 5, 5)
//				kst_tab_cap.localita = " "
//				
//				
//				if trim(kst_tab_cap.cap) <> trim(kst_tab_cap_save.cap) then 
//					
//					kst_tab_cap_save.cap = kst_tab_cap.cap
//	
//					insert into cap (
//								  cap 
//								, prov
//								, localita 
//							 ) values
//								( 
//								 :kst_tab_cap.cap     
//								 ,:kst_tab_cap.prov     
//								 ,:kst_tab_cap.localita     
//							)      ;
//	
//				
//					k_righe++     //conta le righe 
//				end if
//				if mod(k_righe , 1000) = 0 then 
//					commit  using sqlca;
//				end if
//				k_bytes = fileread(k_file, k_record) // legge una riga
//			loop
k_righe = 2
			fileclose(k_file)
			commit using sqlca; 
			if k_righe > 0 then

				k_rc = GetFileOpenName("Scegli Archivio 'CAP_LOCALITA'", &
												k_path, k_nome_file, k_ext, "TXT File (*.txt),*.txt") 
			
			
				if k_rc <= 0 or len(trim(k_nome_file)) = 0 then
					k_path = " "
					
				else
					k_file = fileopen( trim(k_path), linemode!, read!, lockreadwrite!)
					
					if k_file > 0 then
				
						k_bytes = fileread(k_file, k_record) // legge una riga
						k_righe = 0
						k_ctr = 0
						do while k_bytes <> -100 
							kst_tab_cap.cap = mid(k_record, 4, 5)
							kst_tab_cap.localita =  mid(k_record, 10, k_bytes - 9)
							update cap  
								set localita = :kst_tab_cap.localita 
							where cap = :kst_tab_cap.cap 
							using sqlca;
							k_righe++     //conta le righe 
							if mod(k_righe , 1000) = 0 then 
								commit  using sqlca;
							end if

							k_bytes = fileread(k_file, k_record) // legge una riga
						loop
						fileclose(k_file)
					end if
					commit using sqlca; 

					k_rc = GetFileOpenName("Scegli Archivio 'PROVINCE'", &
													k_path, k_nome_file, k_ext, "TXT File (*.txt),*.txt") 
				
				
					if k_rc <= 0 or len(trim(k_nome_file)) = 0 then
						k_path = " "
						
					else
						k_file = fileopen( trim(k_path), linemode!, read!, lockreadwrite!)
						
						if k_file > 0 then
					
							k_bytes = fileread(k_file, k_record) // legge una riga
							k_righe = 0
							k_ctr = 0
							do while k_bytes <> -100 
								kst_tab_cap.prov = mid(k_record, 1, 2)
								kst_tab_cap.localita =  trim(mid(k_record, 4, k_bytes - 3))
								update cap 
									set localita = :kst_tab_cap.localita 
								where prov = :kst_tab_cap.prov and localita = " " 
								using sqlca;
								k_bytes = fileread(k_file, k_record) // legge una riga
							loop
							fileclose(k_file)
						end if
					end if
				end if
			end if
			
		end if
	end if		

	SetPointer(oldpointer)

	if k_errore = 0 then
		MessageBox("Conversione Terminata", "Elaborazione OK!, inseriti rec in CAP:" + string(k_righe, "####"), &
					Information!)
	end if
	
end if	
	 
SetPointer(oldpointer)

return k_righe

end function

public function boolean ext_crea_view ();//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View
//=== 
int k_errore=0
boolean k_codice = true
string k_sql
pointer oldpointer  // Declares a pointer variable




if messagebox("Crea View delle Fattura", &
	              "Genera la view per interrogazione / stampa Fatture~n~r" + &
	              " ", &
						exclamation!, yesno!, 1) = 2 then

	MessageBox("Elaborazione non eseguita", &
		           "Elaborazione Interrotta dall'utente", &
						StopSign!)
else

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

	k_sql = "	CREATE VIEW v_arfa_tot_imponibili  (num_fatt,data_fatt,iva,prezzo_t) AS " &
	 + " select x0.num_fatt ,x0.data_fatt ,x0.iva ,sum( " &
	 + "         x0.prezzo_t ) " &
	  + "  from arfa x0 " &
	+ " 	 group by " &
	+ " 	 x0.num_fatt " &
		+ "  , x0.data_fatt" &
		+ "  ,x0.iva " &
	+ " union all" &
	+ " 	select x1.num_fatt " &
		+ "        ,x1.data_fatt" &
		+ " 	  ,x1.iva " &
		+ " 	  ,sum(x1.prezzo_t )" &
		 + "    from arfa_v x1" &
		+ " 	group by " &
		+ " 	    x1.num_fatt " &
		+ " 	   ,x1.data_fatt " &
		+ " 	   ,x1.iva "  


	EXECUTE IMMEDIATE "drop VIEW v_arfa_tot_imponibili" using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_codice = false
		k_errore = 1
		SetPointer(oldpointer)
		MessageBox("Stop forzato all'utility (1) ","Errore durante creazione View:" &
					+ string(sqlca.sqldbcode, "#####") + "; " + string(sqlca.sqlcode, "#####") , &
		StopSign!)
//	else
//		k_sql = "grant select on V_ARFA_TOT_IMPONIBILI to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_codice = false
//			k_errore = 1
//			SetPointer(oldpointer)
//			MessageBox("Stop forzato all'utility (1) ","Errore durante la GRANT della View:" &
//						+ string(sqlca.sqldbcode, "#####") + "; " + string(sqlca.sqlcode, "#####") , &
//			StopSign!)
//		end if	
	end if	
			

	SetPointer(oldpointer)

	if k_errore = 0 then
		MessageBox("Conversione Terminata", "Elaborazione OK!, View creata correttamente.", &
					Information!)

	end if
	
end if	
	 
SetPointer(oldpointer)

return k_codice

end function

public function integer ext_sistema_artr ();////
////=== Estemporanea da lanciare una sola volta
////=== Sistema da tabella BARCODE la tab. ARTR (colli, trattati, groupage figli)
////=== AL TERMINE DEL PROGRAMMA:
////===    controllare
//
int k_errore=0, k_codice, k_codici_doppi
//string k_record, k_variable
//long k_contratto=0
//string k_sl_pt=" "
//datetime k_today
//integer k_FileNum
//pointer oldpointer  // Declares a pointer variable
//st_tab_artr kst_tab_artr
//st_tab_artr kst_tab_artr1
//st_tab_barcode kst_tab_barcode
//kuf_barcode kuf1_barcode
////uo_exception kuo_exception
//st_esito kst_esito
//
//
//if messagebox("Aggiornamento dati", &
//	              "Sistema da tabella BARCODE la tab. ARTR (colli, trattati, groupage figli) ~n~r" + &
//	              " ", &
//						exclamation!, yesno!, 1) = 2 then
//
//	MessageBox("Elaborazione non eseguita", &
//		           "Elaborazione Interrotta dall'utente", &
//						StopSign!)
//else
//
////=== Puntatore Cursore da attesa.....
//	oldpointer = SetPointer(HourGlass!)
//
//	declare c_ARMO cursor for
//		select colli, colli_trattati, colli_groupage,  id_armo, pl_barcode
//			from  artr
//			where data_fin > '26.10.2006' 
//			order by id_armo;
//
//
//	open c_armo;
//	
//	if sqlca.sqlcode = 0 then
//		
//		
//		k_FileNum = FileOpen("SISTEMA_ARTR.TXT",  LineMode!, Write!, LockWrite!, Replace!)		
//		
//		
//		
//		kuf1_barcode = create kuf_barcode
//		
//		fetch c_armo into :kst_tab_artr.colli,:kst_tab_artr.colli_trattati,:kst_tab_artr.colli_groupage,:kst_tab_artr.id_armo,  :kst_tab_artr.pl_barcode;
//	
//	   	do while sqlca.sqlcode = 0 
//	
//
//			try
//	
//				kst_tab_barcode.id_armo = kst_tab_artr.id_armo
//				kst_tab_barcode.pl_barcode = kst_tab_artr.pl_barcode
//				kst_tab_artr1.colli_groupage = kuf1_barcode.get_conta_barcode_groupage_x_id_armo(kst_tab_barcode)
//				kst_tab_artr1.colli_trattati = kuf1_barcode.get_conta_barcode_x_id_armo_fine_lav(kst_tab_barcode)
//				kst_tab_artr1.colli = kuf1_barcode.get_conta_barcode_x_id_armo_pl_barcode(kst_tab_barcode)
//		
//				
//				if kst_tab_artr1.colli_groupage <> kst_tab_artr.colli_groupage or kst_tab_artr1.colli_trattati <> kst_tab_artr.colli_trattati &
//					or kst_tab_artr1.colli <> kst_tab_artr.colli then
//					
//					k_variable = string(today()) + "; aggiorno ARTR id_armo ;"+string(kst_tab_artr.id_armo)+"; pl ;"+string(kst_tab_artr.pl_barcode)+ "; colli ;" + string(kst_tab_artr.colli) + "; con ;" + string(kst_tab_artr1.colli) &
//										 + ";  trattati ;" + string(kst_tab_artr.colli_trattati) + "; con ;" + string(kst_tab_artr1.colli_trattati) &
//										 + "; groupage figli ;" + string(kst_tab_artr.colli_groupage) + "; con ;" + string(kst_tab_artr1.colli_groupage) + "; "
//				
//					FileWrite ( k_FileNum, k_variable )
//
//		
//					update artr 
//								  set  colli = :kst_tab_artr1.colli,     
//										 colli_trattati = :kst_tab_artr1.colli_trattati,
//								  colli_groupage = :kst_tab_artr1.colli_groupage 
//							where id_armo = :kst_tab_artr.id_armo
//											  and pl_barcode = :kst_tab_artr.pl_barcode
//											  using sqlca;
//		
//					if sqlca.sqlcode = 0 then
//						k_codice ++
//					else
//						sqlca.sqlcode = 0
//						k_codici_doppi++
//	
//					end if
//					
//				end if
//				
//			catch (uo_exception kuo_exception)
//				kst_esito = kuo_exception.get_st_esito()
//				sqlca.sqlcode = kst_esito.sqlcode
//				
//			end try
//			
//			
//			if sqlca.sqlcode = 0 then
//
//				fetch c_armo into :kst_tab_artr.colli,:kst_tab_artr.colli_trattati,:kst_tab_artr.colli_groupage,:kst_tab_artr.id_armo,  :kst_tab_artr.pl_barcode;
//
//			else
//				k_errore = 1
//				SetPointer(oldpointer)
//				MessageBox("Stop forzato all'utility (1) ","Errore durante inserimento riga:" &
//							+ string(sqlca.sqldbcode, "#####") + "; " + string(sqlca.sqlcode, "#####") , &
//				StopSign!)
//
//			end if	
//			
//		
//		loop
//
//		FileClose ( k_FileNum )
//
//		destroy kuf1_barcode
//
//		if sqlca.sqlcode < 0 then
//				SetPointer(oldpointer)
//				MessageBox("Stop forzato all'utility","Errore durante inserimento riga:" &
//							+ string(sqlca.sqldbcode, "#####") + "; " + string(sqlca.sqlcode, "#####") &
//						   + " " + sqlca.sqlerrtext, StopSign!)
//		end if
//
//		close c_armo;
//	end if		
//
//	SetPointer(oldpointer)
//
//	if k_errore = 0 then
//		MessageBox("Operazione aggiornamento Terminata", "Elaborazione OK!, upd in ARTR:" + string(k_codice, "####"), &
//					Information!)
//		MessageBox("Operazione Terminata", &
// 		           "Elaborazione OK!, ~n~r" &
//						+ "Aggiornati rec ARTR:" + string(k_codice, "####") + "~n~r" &
//						+ "rec non trovati(errore) :" + string(k_codici_doppi, "####"), &
//					Information!)
//	end if
//	
//end if	
//	 
//SetPointer(oldpointer)
//
return k_codice
//
end function

public subroutine u_toolbar_save_toolbartext ();//---
//--- Piglia proprieta' TOOLBARTEXT di una toolbar
//---
//--- parametri di input:
//---    kwindow: reference della win
//---
//--- parametro di out: 
//---
// Salva toolbar settings for l'esposizione dei testi sotto l'icona
boolean k_return 
string k_nome, k_rcx
st_profilestring_ini kst_profilestring_ini



	if not KG_application.toolbartext then 
		kst_profilestring_ini.valore = "false" 
	else
		kst_profilestring_ini.valore = "true" 
	end if

	kst_profilestring_ini.operazione = "2"
	kst_profilestring_ini.file = "toolbar" 
	kst_profilestring_ini.titolo = "toolbar" 
     
	kst_profilestring_ini.nome = "toolbartext" 
	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))



end subroutine

public subroutine u_toolbar_set_toolbartext ();//---
//--- Piglia proprieta' TOOLBARTEXT di una toolbar
//---
//--- parametri di input:
//---    kwindow: reference della win
//---
//--- parametro di out: 
//---
// Restore toolbar settings for l'esposizione dei testi sotto l'icona
string k_nome, k_rcx
st_profilestring_ini kst_profilestring_ini




	kst_profilestring_ini.operazione = "1"
	kst_profilestring_ini.file = "toolbar" 
	kst_profilestring_ini.titolo = "toolbar" 
     
	kst_profilestring_ini.nome = "toolbartext" 
	kst_profilestring_ini.valore = "true" 
	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))

	if lower(trim(kst_profilestring_ini.valore)) = "true" then
		KG_application.toolbartext  = true
	else
		KG_application.toolbartext  = false
	end if


end subroutine

public function string u_stringa_pulisci_x_msg (string k_stringa);//
//--- restituisce campo stringa senza caratteri speciale x fare Display
//--- toglie:  '|~ mentre gli 'a capo' come ~n o ~r o ~t diventano spazio
//
string k_return_stringa
string k_old_str, k_new_str
int k_start_pos

		k_return_stringa = k_stringa
//		k_start_pos = 1
//		k_old_str = " "
//		k_new_str = "_"
//		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
//		DO WHILE k_start_pos > 0
//			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
//			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
//		LOOP
//		k_start_pos = 1
//		k_old_str = "\"
//		k_new_str = "_"
//		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
//		DO WHILE k_start_pos > 0
//			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
//			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
//		LOOP
//		k_start_pos = 1
//		k_old_str = "/"
//		k_new_str = "_"
//		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
//		DO WHILE k_start_pos > 0
//			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
//			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
//		LOOP
//		k_start_pos = 1
//		k_old_str = "."
//		k_new_str = "_"
//		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
//		DO WHILE k_start_pos > 0
//			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
//			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
//		LOOP
//		k_start_pos = 1
//		k_old_str = ","
//		k_new_str = "_"
//		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
//		DO WHILE k_start_pos > 0
//			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
//			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
//		LOOP
//		k_start_pos = 1
//		k_old_str = "*"
//		k_new_str = "_"
//		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
//		DO WHILE k_start_pos > 0
//			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
//			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
//		LOOP
		k_start_pos = 1
		k_old_str = "~t"
		k_new_str = " "
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "~r"
		k_new_str = " "
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "~n"
		k_new_str = " "
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP

		k_start_pos = 1
		k_old_str = "'"
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "|"
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "~""
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP

return k_return_stringa

end function

public function st_esito u_ddlb_set_item (ref dropdownlistbox kddlb_out, string k_stringa);//
//--- Riempie un DropDownListBox con i valori contenuti nella stringa (sep da "~t")
//--- 
//--- Input: reference alla DDLB
//---           stringa con i valori separati da "~t"
//--- Output: st_esito
//---
int k_start_pos, k_trovato_pos
st_esito  kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if isnull(k_stringa) or len(trim(k_stringa)) = 0 then 

	kst_esito.sqlcode = 0
	kst_esito.esito = kkg_esito.not_fnd
	kst_esito.sqlerrtext = "Elenco stampanti vuoto"
	kddlb_out.additem(" ")

else
	
	k_start_pos = 1
	k_trovato_pos = pos(k_stringa, "~t",1)
	do while k_trovato_pos > 0
		
		kddlb_out.additem( trim(mid(k_stringa, k_start_pos, (k_trovato_pos - k_start_pos))))
		k_start_pos = k_trovato_pos + 2
		k_trovato_pos = pos(k_stringa, "~t",k_start_pos)
		
	loop

end if

return kst_esito


end function

public function st_window_size u_window_adatta_size (ref window kwindow);//---
//--- Adatta le dimensiona della Window alla MDI
//---
//--- parametri di input:
//---    kwindow: reference della win
//---
//--- parametro di out: 
//---
st_window_size kst_window_size	
	
	
	if IsValid (kwindow) then

		kst_window_size.x = kwindow.x
		kst_window_size.y = kwindow.y
		kst_window_size.w = kwindow.width
		kst_window_size.h = kwindow.height

		kst_window_size.x = 1
		kst_window_size.y = 1
		kst_window_size.w = w_main.WorkSpaceWidth() 
		
//		if isvalid(w_toolbar_programmi) and kguo_g.if_w_toolbar_programmi( ) then
//			if w_toolbar_programmi.visible and w_toolbar_programmi.y > 0 then
////				kwindow.height = w_main.height - (w_toolbar_programmi.height * 1.20)
//				kst_window_size.h = w_toolbar_programmi.y - kst_window_size.y //- (w_toolbar_programmi.height * 1.2)
//			else			
//				kst_window_size.h = w_main.WorkSpaceHeight()
//			end if
//		else
			kst_window_size.h = w_main.WorkSpaceHeight() //.height -300
//		end if

		if u_window_adatta_a_toolbar (kst_window_size, kwindow) then
			
			kwindow.x = kst_window_size.x 
			kwindow.y = kst_window_size.y
			kwindow.width = kst_window_size.w 
			kwindow.height = kst_window_size.h 
		else
			kst_window_size.x = 0
			kst_window_size.y = 0
			kst_window_size.w = 0
			kst_window_size.h = 0
		end if
		
	else
		kst_window_size.x = 0
		kst_window_size.y = 0
		kst_window_size.w = 0
		kst_window_size.h = 0
	end if

	kwindow.SetPosition( topmost! )
	
return kst_window_size


end function

public function boolean u_window_adatta_a_toolbar (ref st_window_size kst_window_size, ref window kwindow);//---
//--- Adatta le dimensiona della Window alle TOOLBAR 
//---
//--- parametri di input:
//---    st_window_size con impostati i parametri di x,y,w,h, kwindow: reference della win da dimensionare
//---
//--- parametro di out: TRUE=ok, FALSE=non va bene
//---
boolean k_return = false	
toolbaralignment k_t_align
integer k_t_ind, k_t_ind_top=0, k_t_x, k_t_y, k_t_w, k_t_h, k_t_x1, k_t_y1, k_t_w1, k_t_h1, k_spessore_tool, k_spessore_tool_vert
boolean k_t_visible

	
	
	if IsValid (kwindow) then

		k_return = true

//--- se toolbar con TEXT ha dimensioni diverse
		if KG_application.toolbartext then 
			k_spessore_tool = 170
			k_spessore_tool_vert = 290
		else
			k_spessore_tool = 110
			k_spessore_tool_vert = 200
		end if
			
//--- sistemo a seconda delle posizioni della TOOLBAR
		for k_t_ind = 1 to 4
			if kwindow.gettoolbar( k_t_ind, k_t_visible, k_t_align)  = 1 then
				if k_t_visible and k_t_align <> Floating!  then
					
//--- strano ma non tornano i dati x, y ecc se toolbar non e' floating.....
					kwindow.getToolbarPos(k_t_ind, k_t_x1, k_t_y1, k_t_w1, k_t_h1)
					
					choose case k_t_align
						case AlignAtTop!
							if k_t_h1 = 0 then // toolbar non posizionata a fianco ma subito sotto 
								k_t_ind_top ++
							end if
							k_t_h = k_spessore_tool * k_t_ind_top 
							k_t_y = k_spessore_tool //* (k_t_ind_top - 1)   
//							if isvalid(w_toolbar_programmi) and kguo_g.if_w_toolbar_programmi( ) then
//								if w_toolbar_programmi.y < (kst_window_size.y + kst_window_size.h + k_t_h) then
//									if w_toolbar_programmi.y > 0 then
//										kst_window_size.h = w_toolbar_programmi.y - kst_window_size.y -  k_t_h 
//									else
//										kst_window_size.h = w_main.WorkSpaceHeight()  * 0.90
//									end if
//								end if
//							else
								if isnull(kst_window_size.h ) then kst_window_size.h = 0
//							end if
						case AlignAtLeft!
							k_t_x = 1 //* k_t_ind_top 
							k_t_w = k_spessore_tool_vert //* (k_t_ind_top - 1) + 1  
							if (w_main.WorkSpaceWidth() - k_t_w) < (kst_window_size.x + kst_window_size.w) then
								kst_window_size.w = w_main.WorkSpaceWidth() - k_t_w //-  (k_t_x + k_t_w)
							end if
						case AlignAtRight!
							k_t_x = w_main.WorkSpaceWidth() - k_spessore_tool_vert  //* k_t_ind_top 
							if (kst_window_size.x + kst_window_size.w) > k_t_x then 
								if kst_window_size.x >  ( (kst_window_size.x + kst_window_size.w) - k_t_x)  then 
									kst_window_size.x = kst_window_size.x - k_t_x - (kst_window_size.x + kst_window_size.w)
								else
									kst_window_size.w =  k_t_x - kst_window_size.x  
								end if
							end if 
						case AlignAtBottom!
							k_t_ind_top ++
							k_t_h = k_spessore_tool * k_t_ind_top 
							k_t_y = k_spessore_tool * (k_t_ind_top - 1)   
							if (kst_window_size.y + kst_window_size.h) > (w_main.height - k_t_y - k_t_h)  then 
								kst_window_size.h = (w_main.height - k_t_y - k_t_h) - kst_window_size.y - 20
							end if 
					end choose
				end if
			end if
		end for		
		
	end if
	
return k_return


end function

public function string u_stringa_numeri (string k_stringa);//
//--- restituisce campo con solo i numeri 
//--- esempio  'fabio 027 / 5'    torna   '0275'
//
string k_return_stringa = ""
int k_start_pos

	for k_start_pos = 1 to len(k_stringa) 
		
		choose case mid(k_stringa, k_start_pos, 1)
			case "0" to "9"
				k_return_stringa += mid(k_stringa, k_start_pos, 1) 
		end choose
	next
	
return k_return_stringa		
			

end function

public function boolean u_shellexecuteex (ref string k_file, string k_extension);//---
//--- Lancia applicazione associata all'estensione con il file indicato
//---
//--- inp: k_file  file da aprire
//---        k_extension = estensione del file da parire (ad es. 'DOC')
//--- rit: TRUE = OK
//--- 
//-----------------------------------------------------------------------------
//--- ESEMPI:
//// Open c:\test.txt with Word or Wordpad 
//of_execute("c:\test.txt", "doc")
//
//// Open c:\test.txt with the default browser
//of_execute("c:\test.txt", "htm")
//-----------------------------------------------------------------------------

CONSTANT long SEE_MASK_CLASSNAME = 1
CONSTANT long SW_NORMAL = 1

string ls_class
long ll_ret
st_shellexecuteinfo kst_shellexecuteinfo
Inet l_Inet



IF lower(k_extension) = "htm" OR lower(k_extension) = "html" THEN
   // Open html file with HyperlinkToURL
   // So, a new browser is launched
   // (with the code using ShellExecuteEx, it is not sure)
   GetContextService("Internet", l_Inet)
   ll_ret = l_Inet.HyperlinkToURL(k_file)
   IF ll_ret = 1 THEN
      RETURN true
   END IF
   RETURN false
END IF

// Search for the classname associated with extension
RegistryGet("HKEY_CLASSES_ROOT\." + k_extension, "", ls_class)
IF isNull(ls_class) OR trim(ls_class) = "" THEN
   // The class is not found, try with .txt (why not ?)
   RegistryGet("HKEY_CLASSES_ROOT\.txt", "", ls_class)
END IF

IF isNull(ls_class) OR Trim(ls_class) = "" THEN
   // No class : error
   RETURN false
END IF

kst_shellexecuteinfo.cbsize = 60
kst_shellexecuteinfo.fMask = SEE_MASK_CLASSNAME  // Use classname
kst_shellexecuteinfo.hwnd = 0
kst_shellexecuteinfo.lpVerb = "open"
kst_shellexecuteinfo.lpfile = k_file
kst_shellexecuteinfo.lpClass = ls_class
kst_shellexecuteinfo.nShow = SW_NORMAL

ll_ret = ShellExecuteEx(kst_shellexecuteinfo)
IF ll_ret = 0 THEN
   // Error
   RETURN false
END IF

RETURN true
end function

public function integer u_apri_programma_esterno (string k_tipo_programma);//
//--- Tenta di aprire il programma associato giusto 
//---
//--- Inp: k_tipo_programma = stringa con il tipo programma e il file da aprire
//---
int k_return 
pointer kp

kp=setpointer(hourglass!)

k_return = run("rundll32.exe url.dll,FileProtocolHandler " + trim(k_tipo_programma))

setpointer(kp)

return k_return


end function

public function integer ext_popola_sped_indi ();//
//=== Estemporanea da lanciare una sola volta
//===
//=== AL TERMINE DEL PROGRAMMA:
//===
//
int k_errore=0, k_codice=0, k_codici_doppi=0, k_codice_barcode=0, k_rec_upd=0
date k_data
st_tab_sped kst_tab_sped
pointer oldpointer  // Declares a pointer variable




if messagebox("Aggiornamento Indirizzi in tabella Bolle di spedizione (SPED)", &
	              " ~n~r" + &
	              "l'utility di popolamento Indirizzi SPED è solo ESTEMPORANEA (1 VOLTA SOLA!!!)!!!", &
						exclamation!, yesno!, 1) = 2 then

	MessageBox("Elaborazione non eseguita", &
		           "Elaborazione Interrotta dall'utente", &
						StopSign!)
else

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


   declare CURSORE_sped cursor for 
		select sped.num_bolla_out, sped.data_bolla_out
		, rag_soc_20
		, rag_soc_21
		, indi_2
		, loc_2
		, prov_2
		, cap_2
		, id_nazione_2
			from sped inner join clienti on  
			    sped.clie_2 = clienti.codice 
			where rag_soc_1 is null;	

	open CURSORE_sped;
	
	if sqlca.sqlcode = 0 then
		
		fetch CURSORE_sped into :kst_tab_sped.num_bolla_out, :kst_tab_sped.data_bolla_out
				, :kst_tab_sped.rag_soc_1
				, :kst_tab_sped.rag_soc_2
				, :kst_tab_sped.indi
				, :kst_tab_sped.loc
				, :kst_tab_sped.prov
				, :kst_tab_sped.cap
				, :kst_tab_sped.id_nazione
				;
	
	   	do while sqlca.sqlcode = 0 
			
  				update sped
					set
						rag_soc_1 = :kst_tab_sped.rag_soc_1
						, rag_soc_2 = :kst_tab_sped.rag_soc_2
						, indi = :kst_tab_sped.indi
						, loc = :kst_tab_sped.loc
						, prov = :kst_tab_sped.prov
						, cap = :kst_tab_sped.cap
						, id_nazione = :kst_tab_sped.id_nazione
					where num_bolla_out = :kst_tab_sped.num_bolla_out
					and  data_bolla_out = :kst_tab_sped.data_bolla_out;


				if sqlca.sqlcode = 0 then
					k_codice ++
					k_rec_upd ++
					if k_rec_upd > 15000 then
						commit;
//						open CURSORE_sped;
						exit;
						k_rec_upd = 0
					end if
				else
					if sqlca.sqldbcode = -1605 or sqlca.sqldbcode = -239 then
						sqlca.sqlcode = 0
						k_codici_doppi++
					end if
				end if
			
				if sqlca.sqlcode = 0 then

					fetch CURSORE_sped into :kst_tab_sped.num_bolla_out, :kst_tab_sped.data_bolla_out
						, :kst_tab_sped.rag_soc_1
						, :kst_tab_sped.rag_soc_2
						, :kst_tab_sped.indi
						, :kst_tab_sped.loc
						, :kst_tab_sped.prov
						, :kst_tab_sped.cap
						, :kst_tab_sped.id_nazione
						;

				else
					k_errore = 1
					SetPointer(oldpointer)
					MessageBox("Stop forzato all'utility (1) ","Errore durante aggiornamento riga: " + string(kst_tab_sped.num_bolla_out) + "; Sqlcode=" &
								+ string(sqlca.sqldbcode, "#####") + "; " + string(sqlca.sqlcode, "#####") , &
					StopSign!)
		
				end if	
			
		
		loop

		if sqlca.sqlcode < 0 then
				SetPointer(oldpointer)
				MessageBox("Stop forzato all'utility","Errore durante aggiornamento riga: " &
							+ string(sqlca.sqldbcode, "#####") + "; " + string(sqlca.sqlcode, "#####") &
						   + " " + sqlca.sqlerrtext, StopSign!)
			rollback using sqlca;
		end if

		close CURSORE_sped;

		commit using sqlca;
		
	end if		




	SetPointer(oldpointer)

	if k_errore = 0 then
		MessageBox("Elaborazione Terminata", "Elaborazione OK!," &
		          + " aggiornati rec in tab SPED:  " + string(k_codice, "###0") &
					,Information!)
	end if
	
end if	
	 
SetPointer(oldpointer)

return k_codice

end function

public function integer u_copia_file (string k_file_source, string k_file_target, boolean k_raplace);//------------------------------------------------------------------------------------------------
//--- Copia un file  
//--- flag di INPUT k_raplace: TRUE=replace, FALSE=non Replace
//--- Ritorna: 1 - Success
//---            -1 - Error opening sourcefile
//---            -2 - Error writing targetfile
//------------------------------------------------------------------------------------------------
//
int k_rc, k_ctr=0

		do 

			k_rc = FileCopy (k_file_source,  k_file_target, k_raplace)
			
			if k_rc < 0 then  // no buono allora attendo.... x rifare
				k_ctr ++ 
				sleep (2) // in pausa x alcuni secondi
			end if
			
		loop while k_rc < 0 and k_ctr < 10   //esce x tutto ok ma fa diversi tentativi

return k_rc
end function

public function integer u_filemovereplace (string k_file_source, string k_file_target);//------------------------------------------------------------------------------------------------
//--- Muove il File da una cartella a un'altra (Ricopre il Vecchio File)
//--- Ritorna: 1 - Success
//---            -1 - Error opening sourcefile
//---            -2 - Error writing targetfile
//---            +9 - Errore in cancellazione dopo la copia
//------------------------------------------------------------------------------------------------
//
int k_rc



		k_rc = FileCopy (k_file_source,  k_file_target, TRUE)
		if k_rc > 0 then
			if not FileDelete(k_file_source) then
				k_rc = 9
			end if
		end if


return k_rc
end function

public function string u_get_nome_file (string k_path_file);//
//--- restituisce solo il nome file + estensione se c'era da un Path completo
//--- es. c:\pippo\pluto\paperino.txt  torna  paperino.txt
//
string k_return_stringa=""
string k_trova_str
int k_start_pos, k_pos

		k_path_file = trim(k_path_file)
		k_start_pos = 1
		k_pos = 1
		k_trova_str = kkg.path_sep // "\"
		k_start_pos = pos(k_path_file, k_trova_str, k_start_pos)
		DO WHILE k_start_pos > 0
			k_pos = k_start_pos + 1
			k_start_pos = pos(k_path_file, k_trova_str, k_pos )
		LOOP
		if k_pos = 1 then
			k_start_pos = 1
			k_trova_str = kkg.path_sep // "/" 
			k_start_pos = pos(k_path_file, k_trova_str, k_start_pos)
			DO WHILE k_start_pos > 0
				k_pos = k_start_pos + 1
				k_start_pos = pos(k_path_file, k_trova_str, k_pos )
			LOOP
		end if

		k_return_stringa = trim(mid(k_path_file, k_pos, len(k_path_file) - k_pos + 1))

return k_return_stringa

end function

public function integer ext_popola_sd_md ();//
//=== Estemporanea da lanciare una sola volta
//=== Popola la nuova tabella Contratto dalla CAPVAL
//=== AL TERMINE DEL PROGRAMMA:
//===    Cancellare la tabella CAPVAL

int k_errore=0, k_codice, k_codici_doppi
string k_record
long k_contratto=0
string k_sl_pt=" "
datetime k_today
st_tab_contratti_co kst_tab_contratti_co
pointer oldpointer  // Declares a pointer variable




if messagebox("Trasferimento dati", &
	              "Copia SD-MD da tabella CONTRATTI_CO a CONTRATTI_CO ~n~r" + &
	              " ", &
						exclamation!, yesno!, 1) = 2 then

	MessageBox("Elaborazione non eseguita", "Elaborazione Interrotta dall'utente", &
						StopSign!)
else

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

	declare contratti_co cursor for
		select sd_md.id_sd_md, contratti_co.id_contratto_co
			from  sd_md inner join contratti_co on sd_md.sd_md = contratti_co.sk_dose_map_codice
			where contratti_co.id_sd_md is null 
			order by contratti_co.id_contratto_co ;

	open contratti_co;
	k_codice=0
	k_codici_doppi=0
	k_today = datetime(now())
	
	if sqlca.sqlcode = 0 then
		
		fetch contratti_co into :kst_tab_contratti_co.id_sd_md, :kst_tab_contratti_co.id_contratto_co;
	
	   	do while sqlca.sqlcode = 0 
	
			update contratti_co 
			           set  id_sd_md = :kst_tab_contratti_co.id_sd_md,     
			                x_datins = :k_today,
						   x_utente = 'batch' 
					where id_contratto_co = :kst_tab_contratti_co.id_contratto_co;

			if sqlca.sqlcode = 0 then
				k_codice ++
			else
				sqlca.sqlcode = 0
				k_codici_doppi++
			end if
			
			if sqlca.sqlcode = 0 then

				fetch contratti_co into :kst_tab_contratti_co.id_sd_md, :kst_tab_contratti_co.id_contratto_co;

			else
				k_errore = 1
				SetPointer(oldpointer)
				MessageBox("Stop forzato all'utility (1) ","Errore durante inserimento riga:" &
							+ string(sqlca.sqldbcode, "#####") + "; " + string(sqlca.sqlcode, "#####") , &
				StopSign!)

			end if	
			
		
		loop

		if sqlca.sqlcode < 0 then
				SetPointer(oldpointer)
				MessageBox("Stop forzato all'utility","Errore durante inserimento riga:" &
							+ string(sqlca.sqldbcode, "#####") + "; " + string(sqlca.sqlcode, "#####") &
						   + " " + sqlca.sqlerrtext, StopSign!)
		end if

		close contratti_co;
		
	end if		

	SetPointer(oldpointer)

	if k_errore = 0 then
		MessageBox("Conversione Terminata", "Elaborazione OK!, upd in CONTRATTI_CO:" + string(k_codice, "####"), &
					Information!)
		MessageBox("Conversione Terminata", &
 		           "Elaborazione OK!, ~n~r" &
						+ "Aggiornati rec CONTRATTI_CO:" + string(k_codice, "####") + "~n~r" &
						+ "rec non trovati(errore) :" + string(k_codici_doppi, "####"), &
					Information!)
	end if
	
end if	
	 
SetPointer(oldpointer)

return k_codice

end function

public function st_esito u_stop_e_disconnessione (unsignedlong k_classe, window ka_window);//
//--- Esce da tutte le windows e eccetto quella passata in argomento e Sconnette il DB
//
st_esito kst_esito
window k_window
//kuf_db kuf1_db


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


k_window = kGuf_data_base.prendi_win_la_prima()
if k_window <> ka_window then
	
	k_window.event close( )
	
end if

//=== Se DB connesso lo CHIUDE
if isvalid(sqlca) then
	if sqlca.DBHandle ( ) > 0 then

//		kuf1_db = create kuf_db
		try
			kguo_sqlca_db_magazzino.db_disconnetti()

		catch (uo_exception kuo_exception1)
			kst_esito = kuo_exception1.get_st_esito()
			kguo_exception.set_esito(kst_esito)
//			messagebox("Problemi durante disconnessione DB~n~r", trim(kst_esito.sqlerrtext ))
			
		finally
//			destroy kuf1_db

		end try

	end if
end if	

//---- Rilancio del DB (stop/start servizio)
if kst_esito.esito = kkg_esito.ok then
	
	run (kguo_path.get_base_del_server_job() + kkg.path_sep + "dbexport_gammarad_prod.bat", Minimized!)
	
end if

//=== Se DB connesso lo CHIUDE
if isvalid(sqlca) then
	if sqlca.DBHandle ( ) > 0 then

//		kuf1_db = create kuf_db
		try
			kguo_sqlca_db_magazzino.db_connetti()

		catch (uo_exception kuo_exception2)
			kst_esito = kuo_exception2.get_st_esito()
			kguo_exception.set_esito(kst_esito)
//			messagebox("Problemi durante Connessione DB~n~r", trim(kst_esito.sqlerrtext ))
			
		finally
//			destroy kguo_sqlca_db_magazzino

		end try

	end if
end if	


	
return kst_esito


end function

public function string u_stringa_compatta (string k_stringa);//
//--- restituisce campo stringa compattato senza caratteri speciali ovvero ad es. "mia sorella_matta" diventa "miasorellamatta" 
//--- tipo .'/|\*spazio~'a capo come ~n o ~r o ~t"
//
string k_return_stringa=""
int k_ind, k_len

		k_len = len(k_stringa)
		for k_ind = 1 to k_len
			 if mid(k_stringa, k_ind, 1) = " " or mid(k_stringa, k_ind, 1) = "\" or mid(k_stringa, k_ind, 1) =  "/" or mid(k_stringa, k_ind, 1) = "." or mid(k_stringa, k_ind, 1) = "," &
			     or mid(k_stringa, k_ind, 1) = "*" or mid(k_stringa, k_ind, 1) = "_" or mid(k_stringa, k_ind, 1) = "|" &
			     or mid(k_stringa, k_ind, 1) = "(" or mid(k_stringa, k_ind, 1) = ")" or mid(k_stringa, k_ind, 1) = "["  or mid(k_stringa, k_ind, 1) = "]" then
			else
				if k_ind < k_len then
					if mid(k_stringa, k_ind, 2) =  "~~" or mid(k_stringa, k_ind, 2) = "~t" or mid(k_stringa, k_ind, 2) = "~r" or mid(k_stringa, k_ind, 2) = "~n" or mid(k_stringa, k_ind, 2) = "~"" then
					else
						k_return_stringa += mid(k_stringa, k_ind, 1) 
					end if
				else
					k_return_stringa += mid(k_stringa, k_ind, 1) 
				end if
			end if
		next

return k_return_stringa

end function

public function string u_stringa_pulisci_asc (string ka_stringa);//
//--- restituisce campo stringa con solo caratteri alfabetici e numeri e qualche altro carattere stampabile
//--- toglie tutto il resto
//
string k_return_stringa = ""
boolean k_forza_spazio=false
string k_char_ok[] = {" ","{","a","b","c","d","e","f","g","h","k","i","j","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","K","I","J","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","1","2","3","4","5","6","7","8","9","0","è","ò","à","ì","ù",".",",",";",":","-","+","'","!","%","&","/","?","@","#","(",")","€","$","£","=","^","<",">","}"}
int k_item, k_item_tot, k_len_stringa, k_item_len
boolean k_char_scrivi = false


	k_len_stringa = len(trim(ka_stringa))
	k_item_tot = upperbound(k_char_ok[])
	
	for k_item_len = 1 to k_len_stringa
		
//--- cerca se il carattere è ok		
		k_char_scrivi = false
//--- se è un semplice spazio salto il controllo ed è subito OK		
		if mid(ka_stringa,k_item_len,1) =  " " then 
			k_char_scrivi = true
		else
			k_item = 1
			do while not k_char_scrivi and k_item < k_item_tot  
				if mid(ka_stringa,k_item_len,1) =  k_char_ok[k_item] then
					k_char_scrivi = true
				else
					k_item ++
				end if
			loop
		end if
		
//--- se ok popolo char x char la stringa di ritorno		
		if k_char_scrivi then 
			k_return_stringa += mid(ka_stringa,k_item_len,1)
			if mid(ka_stringa,k_item_len,1) = " " then
				k_forza_spazio = true
			else
				k_forza_spazio = false
			end if
		else
//--- se char non consentito mette uno spazio ma solo se e' il primo (non a spazi consecutivi)
			if not k_forza_spazio then k_return_stringa += " "
			k_forza_spazio = true
		end if
	end for
	

return trim(k_return_stringa)

end function

public function string u_get_path_file (string k_path_file);//
//--- restituisce solo il PATH del file 
//--- es. c:\pippo\pluto\paperino.txt  torna  c:\pippo\pluto\ 
//
string k_return_stringa="", k_char
int k_pos, k_pos_fin

		k_path_file = trim(k_path_file)
		k_pos = len(k_path_file)
		k_char = mid(k_path_file, k_pos, 1 )
		k_pos --
		DO WHILE k_pos > 0 and k_char <> KKG.PATH_SEP
			k_char = mid(k_path_file, k_pos, 1 )
			k_pos --
		LOOP
		
		if k_char = KKG.PATH_SEP then
			k_return_stringa = left(k_path_file, k_pos + 1)
		end if

return k_return_stringa

end function

public function integer ext_sistema_prof ();//
//=== Estemporanea 
//=== Popola il LISTINO
//=== 
int k_errore=0
int k_rec_letti=0, k_rec_scritti=0, k_rec_scartati=0, k_ctr=0
st_tab_prof kst_tab_prof
transaction k_sqlca_ext
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

	declare c_prof cursor for
			SELECT distinct
					arfa_testa.id_fattura, 
					arfa_testa.num_fatt,
					arfa_testa.data_fatt
				FROM prof inner join arfa_testa on prof.num_fatt = arfa_testa.num_fatt
				     and prof.data_fatt = arfa_testa.data_fatt
				using sqlca;

	open c_prof;
	k_rec_letti = 0; k_rec_scritti = 0
		
	if sqlca.sqlcode = 0 then
			
		fetch c_prof into 
					:kst_tab_prof.id_fattura, 
					:kst_tab_prof.num_fatt,
					:kst_tab_prof.data_fatt
					;
		
		do while sqlca.sqlcode = 0

			k_rec_letti ++


//--- Aggiorna articolo in listino in db
		update prof
			  set id_fattura = :kst_tab_prof.id_fattura
			 where num_fatt = :kst_tab_prof.num_fatt
				and data_fatt = :kst_tab_prof.data_fatt
				using sqlca
				; 
			

		if sqlca.sqlcode = 0 then
			if sqlca.sqlnrows > 0 then
				k_rec_scritti ++
			else
				k_rec_scartati ++
			end if
			
		else
//						if sqlca.sqldbcode = -1605 or sqlca.sqldbcode = -239 then
//							sqlca.sqlcode = 0
//							k_codici_doppi++
//						end if
		end if


		fetch c_prof into 
				:kst_tab_prof.id_fattura, 
				:kst_tab_prof.num_fatt,
				:kst_tab_prof.data_fatt
				;

	loop
	close c_prof;
	
   end if
	
	SetPointer(oldpointer)
	MessageBox("Aggiornamento tabella E-SOLVER Terminata", &
						"Record Letti da FATTURE .....:" + string(k_rec_letti, "####") + "~n~r" &
			 		 + "Record aggiornati su tab PROF:" + string(k_rec_scritti, "####") + "~n~r" &
			 		 + "Record NON aggiornati su tab:" + string(k_rec_scartati, "####") &
					, & 
					Information!)
	
	 

return k_rec_scritti

end function

public function integer ext_popola_id_sped ();//
//=== Estemporanea da lanciare una sola volta
//===
//=== AL TERMINE DEL PROGRAMMA:
//===

int k_errore=0, k_codice=0, k_codici_doppi=0, k_codice_barcode=0
long k_num_bolla_out, k_id
date k_data
pointer oldpointer  // Declares a pointer variable




if messagebox("Aggiornamento id_sped in tabella arsp", &
	              " ~n~r" + &
	              "l'utility di popolamento del ARSP (righe bolla) !!!", &
						exclamation!, yesno!, 1) = 2 then

	MessageBox("Elaborazione non eseguita", &
		           "Elaborazione Interrotta dall'utente", &
						StopSign!)
else

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


   declare CURSORE_sped cursor for
		select sped.num_bolla_out, sped.data_bolla_out, sped.id_sped
			from arsp inner join sped on  
			    arsp.num_bolla_out = sped.num_bolla_out and arsp.data_bolla_out = sped.data_bolla_out 
			where (arsp.id_sped = 0 or arsp.id_sped is null) 
			order by sped.num_bolla_out;	

	open cursore_sped;
	
	if sqlca.sqlcode = 0 then
		
		fetch cursore_sped into :k_num_bolla_out, :k_data, :k_id;
	
   	do while sqlca.sqlcode = 0 
			
			if k_id > 0 then 

  				update arsp
					set id_sped = :K_id
					where num_bolla_out = :K_num_bolla_out
					and  data_bolla_out = :k_data;


				if sqlca.sqlcode = 0 then
					k_codice ++
				else
					if sqlca.sqldbcode = -1605 or sqlca.sqldbcode = -239 then
						sqlca.sqlcode = 0
						k_codici_doppi++
					end if
				end if
			end if
			
			if sqlca.sqlcode = 0 then

				fetch cursore_sped into :k_num_bolla_out, :k_data, :k_id;

			else
				k_errore = 1
				SetPointer(oldpointer)
				MessageBox("Stop forzato all'utility (1) ","Errore durante aggiornamento riga:" &
							+ string(sqlca.sqldbcode, "#####") + "; " + string(sqlca.sqlcode, "#####") , &
				StopSign!)

			end if	
			
		
		loop

		if sqlca.sqlcode < 0 then
				SetPointer(oldpointer)
				MessageBox("Stop forzato all'utility","Errore durante aggiornamento riga:" &
							+ string(sqlca.sqldbcode, "#####") + "; " + string(sqlca.sqlcode, "#####") &
						   + " " + sqlca.sqlerrtext, StopSign!)
			rollback using sqlca;
		end if

		close cursore_sped;

		commit using sqlca;
		
	end if		




	SetPointer(oldpointer)

	if k_errore = 0 then
		MessageBox("Elaborazione Terminata", "Elaborazione OK!, aggiornati rec in ARSP:  " + string(k_codice, "###0"), Information!)
	end if
	
end if	
	 
SetPointer(oldpointer)

return k_codice

end function

public function blob u_filetoblob (string a_file) throws uo_exception;//------------------------------------------------------------------------------------------------
//--- Mette il contenuto di un file in un BLOB 
//--- Input: file di INPUT (path compreso)
//--- Ritorna: contenuto file in un BLOB
//---            
//------------------------------------------------------------------------------------------------
//
blob b, tot_b
long flen, bytes_read, new_pos
integer li_FileNum, loops, i
uo_exception kuo_exception


if not fileexists(a_file) then
	kuo_exception = create uo_exception
	kuo_exception.set_tipo(kuo_exception.kk_st_uo_exception_tipo_not_fnd)
	kuo_exception.setmessage("File non trovato: " + trim(a_file))
	throw kuo_exception
end if

// Get the file length, and open the file
flen = FileLength(a_file)
li_FileNum = FileOpen(a_file, StreamMode!, Read!, Shared!)

if li_FileNum < 1 then	
	kguo_exception.inizializza()
	kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_non_eseguito )
	kguo_exception.setmessage("File " + trim(a_file) + " non riesco ad Importarlo; probabile problemi di accesso/autorizzazione al Documento (u_filetoblob)")
	throw kguo_exception
end if

// Determine how many times to call FileRead
IF flen > 32765 THEN
   IF Mod(flen, 32765) = 0 THEN
      loops = flen/32765
   ELSE
      loops = (flen/32765) + 1
   END IF
ELSE
   loops = 1
END IF

// Read the file
new_pos = 1
FOR i = 1 to loops
   bytes_read = FileRead(li_FileNum, b)
   tot_b = tot_b + b
NEXT

FileClose(li_FileNum)

flen = len(tot_b) //debug


return tot_b
end function

public function string u_get_ext_file (string k_path_file);//
//--- restituisce, da PATH completo, solo l'estensione del file se esiste
//--- es. c:\pippo\pluto\paperino.txt  torna  'txt'
//
string k_return_stringa=""
string k_trova_str
int k_start_pos, k_pos


//--- get del solo nome file
		k_path_file = trim(u_get_nome_file(k_path_file))

//--- estrare l'estensine
		k_start_pos = 1
		k_pos = 1
		k_trova_str = "."
		k_start_pos = pos(k_path_file, k_trova_str, k_start_pos)
		DO WHILE k_start_pos > 0
			k_pos = k_start_pos + 1
			k_start_pos = pos(k_path_file, k_trova_str, k_pos )
		LOOP
		if k_pos > 1 then
			k_return_stringa = trim(mid(k_path_file, k_pos, len(k_path_file) - k_pos + 1))
		else
			k_return_stringa = ""
		end if

return k_return_stringa

end function

public subroutine u_blobtofile (blob a_blob, string a_file) throws uo_exception;//------------------------------------------------------------------------------------------------
//--- Mette il contenuto di un BLOB in un file  
//--- Input: BLOB e su cui copiare (path compreso)
//--- Ritorna: 
//---            
//------------------------------------------------------------------------------------------------
//
blob b, tot_b
long k_filenum
uo_exception kuo_exception


k_filenum=FileOpen(a_file,StreamMode!,Write!,LockWrite!,Replace!,EncodingANSI!) 

if k_filenum > 0 then
	FileWriteEx(k_filenum, a_blob) 

	FileClose(k_filenum) 
	
else
	
	kguo_exception.inizializza()
	kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_non_eseguito )
	kguo_exception.setmessage("File " + trim(a_file) + " non generato, probabile problema di accesso/autorizzazione del file")
	throw kguo_exception
	
end if


end subroutine

public function boolean u_svuota_temp ();//
//--- Cancella i file nella cartella TEMP
//--- es. c:\at_m2000\temp\*.*
//
string k_path_temp
boolean k_return=false
kuf_file_explorer kuf1_file_explorer


	k_path_temp = kguo_path.get_temp( )

//--- crea la TEMP dell'utente se manca
	kuf1_file_explorer = create kuf_file_explorer
	kuf1_file_explorer.u_directory_create(k_path_temp)
	destroy kuf1_file_explorer
	
	if trim(k_path_temp) > " " then
		k_return = u_svuota_folder(k_path_temp)
	end if


return k_return

end function

public subroutine u_stringtofile (string a_string, string a_file) throws uo_exception;//------------------------------------------------------------------------------------------------
//--- Mette il contenuto di un BLOB in un file  
//--- Input: BLOB e su cui copiare (path compreso)
//--- Ritorna: 
//---            
//------------------------------------------------------------------------------------------------
//
long k_filenum
integer li_FileNum, loops, i
uo_exception kuo_exception

k_filenum=FileOpen(a_file,StreamMode!,Write!,LockWrite!,Replace!,EncodingANSI!) 

if k_filenum > 0 then
	FileWriteEx(k_filenum, a_string) 

	FileClose(k_filenum) 
	
else
	
	kguo_exception.inizializza()
	kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_non_eseguito )
	kguo_exception.setmessage("File " + trim(a_file) + " non generato, probabile problemi di accesso/autorizzazione")
	throw kguo_exception
	
end if


end subroutine

public subroutine u_toolbar_restore_old (ref w_super kwindow, integer k_index_par, boolean k_toolbar_window_stato, boolean k_toolbar_window_presente);//---
//--- Ripristina le proprieta' di una toolbar
//---
//--- parametri di input:
//---    kwindow: reference della win
//---    k_index: il numero della toolbar che si vuole ripristinare (0=tutte) 
//---    k_toolbar_window_stato: se visibile o meno
//---
//--- parametro di out: 
//---
// Restore toolbar settings for the passed window
integer k_index,k_index_max, row, offset, x, y, w, h, k_ctr 
boolean visible 
string visstring, alignstring, title, k_file, k_nome, k_rcx 
toolbaralignment alignment  
st_profilestring_ini kst_profilestring_ini



	k_nome = "M2000_toolbar"  //--- Meglio se sempre uguale   trim(kwindow.ClassName())

	kst_profilestring_ini.operazione = "1"
	kst_profilestring_ini.valore = "0"
	kst_profilestring_ini.file = "toolbar" 
	kst_profilestring_ini.titolo = "toolbar" 


//k_nome = "generico." + "toolbar_" + kwindow.ClassName()

//--- se ho passato l'indice Elaboro solo quello!
if k_index_par = 0 then 
	k_index_par = 1
	k_index_max = 4
else
	k_index_max = k_index_par
end if

FOR k_ctr = k_index_par  to k_index_max   
	k_index = k_ctr
	IF kwindow.GetToolbar(k_ctr, visible) = 1 THEN

		if k_index = 1 then
			title = "Toolbar Principale"
			if k_toolbar_window_stato then
				visstring = "true"
			else
				visstring = "false"
			end if
		else
			title = "Toolbar Specifica"
			if k_toolbar_window_presente then
				visstring = "true"
			else
				visstring = "false"
			end if
		end if
		
		kst_profilestring_ini.nome = k_nome + "_" + String(k_index) + "_alignment"
		kst_profilestring_ini.valore = "top" 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		alignstring = lower(trim(kst_profilestring_ini.valore))
		if kst_profilestring_ini.esito <> "0" then
			alignstring = "top" 
		else
//				alignstring = "top" //---- FORZO IL TOP
		end if
		
		kst_profilestring_ini.nome = k_nome + "_" + String(k_index) + "_row"
		kst_profilestring_ini.valore = "1" 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		row = 0
		if trim(kst_profilestring_ini.valore) <> "nullo" then
			row = integer(kst_profilestring_ini.valore)
		end if
		if row = 0 then
			row = 1
		end if

		kst_profilestring_ini.nome = k_nome + "_" + String(k_index) + "_offset"
		kst_profilestring_ini.valore = "0" 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		offset = 0 
		if trim(kst_profilestring_ini.valore) <> "nullo" then
			offset = integer(kst_profilestring_ini.valore)
		end if
		if offset = 0 then
			offset = 1
		end if

		kst_profilestring_ini.nome = k_nome + "_" + String(k_index) + "_x"
		kst_profilestring_ini.valore = "0" 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		x = 0 
		if trim(kst_profilestring_ini.valore) <> "nullo" then
			x = integer(kst_profilestring_ini.valore)
		end if

		kst_profilestring_ini.nome = k_nome + "_" + String(k_index) + "_y"
		kst_profilestring_ini.valore = "0" 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		y = 0 
		if trim(kst_profilestring_ini.valore) <> "nullo" then
			y = integer(kst_profilestring_ini.valore)
		end if

		kst_profilestring_ini.nome = k_nome + "_" + String(k_index) + "_w"
		kst_profilestring_ini.valore = "0" 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		w = 0 
		if trim(kst_profilestring_ini.valore) <> "nullo" then
			w = integer(kst_profilestring_ini.valore)
		end if
		if w = 0 then
			w = 400
		end if

		kst_profilestring_ini.nome = k_nome + "_" + String(k_index) + "_h"
		kst_profilestring_ini.valore = "0" 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		h = 0 
		if trim(kst_profilestring_ini.valore) <> "nullo" then
			h = integer(kst_profilestring_ini.valore)
		end if
		if h = 0 then
			h = 1
		end if

// Convert visstring to a boolean
		CHOOSE CASE visstring
			CASE "true"
				visible = true
			CASE "false"
				visible = false
		END CHOOSE
		
// Convert alignstring to toolbaralignment
         CHOOSE CASE alignstring
				CASE "left"
					alignment = AlignAtLeft!
				CASE "top"
					alignment = AlignAtTop!
				CASE "right"
					alignment = AlignAtRight!
				CASE "bottom"
					alignment = AlignAtBottom!
				CASE "floating"
					alignment = Floating!
				CASE ELSE
					alignment = AlignAtTop!
		END CHOOSE
			
// Setto la posizione solo la PRIMISSIMA volta x le toolbar 
		if not kGuf_data_base.kI_toolbar_2_settata then
			kwindow.SetToolbarPos(k_index, row, offset, false)
			kwindow.SetToolbarPos(k_index, x, y, w, h)
		end if
		kwindow.SetToolbar(k_index, visible, alignment, title)
   END IF
	
//--- se non voglio Toolbar particolari per la window allora lmi fermo, esco dal ciclo
	if not k_toolbar_window_presente then
		k_ctr = k_index_max + 1
	end if
	
NEXT

//--- setto il flag x non rifare il SET delle toolbar
kGuf_data_base.kI_toolbar_2_settata = true

//--- se non voglio Toolbar particolari per la window allora mi fermo, esco dal ciclo
if kwindow.ki_toolbar_window_presente then
//--- se non è MDI visualizza la TOOLBAR
	if kwindow.WindowType <> MDI! and kwindow.WindowType <> MDIHelp! then
		kwindow.SetToolbar(2, true)
	end if
else
	kwindow.SetToolbar(2, false)
end if


end subroutine

public subroutine u_toolbar_save_old (window kwindow);//---
//--- Ripristina le proprieta' di una toolbar
//---
//--- parametri di input:
//---    kwindow: reference della win
//---
//--- parametro di out: 
//---
// Store the toolbar settings for the passed window
integer index, row, offset, x, y, w, h, k_ctr 
boolean visible 
string visstring, alignstring, title, k_nome,k_rcx
toolbaralignment alignment  
st_profilestring_ini kst_profilestring_ini



//k_section = "generico." + "toolbar_" + kwindow.ClassName()

	k_nome =  "M2000_toolbar" //--- meglio se sempre uguale    trim(kwindow.ClassName())

	kst_profilestring_ini.operazione = "2"
	kst_profilestring_ini.valore = "0"
	kst_profilestring_ini.file = "toolbar" 
	kst_profilestring_ini.titolo = "toolbar" 


	

FOR index = 2 to 4     
// Try to get the attributes for the bar.

	IF kwindow.GetToolbar(index, visible, alignment, title)= 1 THEN
// Convert visible to a string    
		CHOOSE CASE visible    
			CASE true       
				visstring = "true"    
			CASE false         
				visstring = "false"       
		END CHOOSE
// Convert alignment to a string        
		CHOOSE CASE alignment          
			CASE AlignAtLeft!             
				alignstring = "left"    
			CASE AlignAtTop!       
				alignstring = "top"          
			CASE AlignAtRight!             
				alignstring = "right"          
			CASE AlignAtBottom!             
				alignstring = "bottom"          
			CASE Floating!             
				alignstring = "floating"    
		END CHOOSE     
			
			
//--- Save the basic attributes       
		kst_profilestring_ini.nome = k_nome + "_" + String(index) + "_visible"
		kst_profilestring_ini.valore = visstring 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		kst_profilestring_ini.nome = k_nome + "_" + String(index) + "_alignment"
		kst_profilestring_ini.valore = alignstring 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		kst_profilestring_ini.nome = k_nome + "_" + String(index) + "_title"
		kst_profilestring_ini.valore = title 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))

//--- Save the fixed position
		kwindow.GetToolbarPos(index, row, offset)
		if row > 0 then
			kst_profilestring_ini.nome = k_nome + "_" + String(index) + "_row"
			kst_profilestring_ini.valore = String(row) 
			k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		end if
		if offset > 0 then
			kst_profilestring_ini.nome = k_nome + "_" + String(index) + "_offset"
			kst_profilestring_ini.valore = String(offset) 
			k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		end if

//--- Save the floating position 
		kwindow.GetToolbarPos(index, x, y, w, h)
		kst_profilestring_ini.nome = k_nome + "_" + String(index) + "_x"
		kst_profilestring_ini.valore = String(x) 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		kst_profilestring_ini.nome = k_nome + "_" + String(index) + "_y"
		kst_profilestring_ini.valore = String(y) 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		if w > 0 then
			kst_profilestring_ini.nome = k_nome + "_" + String(index) + "_w"
			kst_profilestring_ini.valore = String(w) 
			k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		end if
		if h > 0 then
			kst_profilestring_ini.nome = k_nome + "_" + String(index) + "_h"
			kst_profilestring_ini.valore = String(h) 
			k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		end if
	END IF
NEXT

end subroutine

public function string u_stringa_cmpnovocali (string a_stringa);//
//--- restituisce campo stringa compattato con solo CONSONANTI o NUMERI ad es. "mia Sorella_Matta_3" diventa "msrllmtt3" 
//--- toglie anche i char spaciali come ~n o ~r o ~t"
//
string k_stringa
string k_return_stringa=""
int k_ind, k_len


		k_stringa = lower(trim(a_stringa))
		k_len = len(a_stringa)
		for k_ind = 1 to k_len
			if match(upper(mid(k_stringa, k_ind, 1)), '[^BCDFGHJLMNPQRSTVWXYZ0-9]') then  // diverso da CONSONANTI e 0-9
		//	 if mid(k_stringa, k_ind, 1) < " " & 
		//	             or mid(k_stringa, k_ind, 1) = "a" or mid(k_stringa, k_ind, 1) = "e" or mid(k_stringa, k_ind, 1) = "i" or mid(k_stringa, k_ind, 1) = "o" or mid(k_stringa, k_ind, 1) = "u" & 
      //                  or mid(k_stringa, k_ind, 1) = "\" or mid(k_stringa, k_ind, 1) =  "/" or mid(k_stringa, k_ind, 1) = "." or mid(k_stringa, k_ind, 1) = "," or mid(k_stringa, k_ind, 1) = "*" or mid(k_stringa, k_ind, 1) = "_" or mid(k_stringa, k_ind, 1) = "|" &	
		//						then
			else
				if k_ind < k_len then
					if mid(k_stringa, k_ind, 2) =  "~~" or mid(k_stringa, k_ind, 2) = "~t" or mid(k_stringa, k_ind, 2) = "~r" or mid(k_stringa, k_ind, 2) = "~n" or mid(k_stringa, k_ind, 2) = "~"" then
					else
						k_return_stringa += mid(k_stringa, k_ind, 1) 
					end if
				else
					k_return_stringa += mid(k_stringa, k_ind, 1) 
				end if
			end if
		next

return k_return_stringa

end function

public function integer ext_esempio ();//
//=== Estemporanea 
//=== Popola il LISTINO
//=== 
//int k_errore=0
//long k_rec=0, k_righe=0, k_update_righe=100
//datastore kds
//w_utility_bar w1
//
//if messagebox ("Operazione di AGGIORNAMENTO", &
//         "Valorizza Barcode Dosimetro (fittizio) e di Lavorazione in tabella MECA_DOSIM, proseguire?", &
//						 question!, YesNo!, 2) = 1 then
//
//	OpenSheet(w1,w_main, 5, original!)
////=== Puntatore Cursore da attesa.....
//	SetPointer(kkg.pointer_attesa)
//
//
//	kds = create datastore
//
//	kds.dataobject = "dsappo_meca_dosim_l"
//	kds.settransobject(sqlca)
//	k_righe = kds.retrieve()
//	
//	for k_rec = 1 to k_righe 
//		if trim(kds.object.barcode[k_rec]) > " " then
//		else
//			kds.object.barcode[k_rec] = string(k_rec)
//		end if
//		kds.object.barcode_lav[k_rec] = kds.object.barcode_barcode[k_rec] 
//		kds.update( )
//		k_update_righe --
//		if k_update_righe <= 0 then
//			k_update_righe = 100
//			commit;
//		end if
//	end for
//	
//	
////	kds.saveas("myxml.xml", XML!, false)
//	
//	SetPointer(kkg.pointer_default)
//	MessageBox("Elaborazione Terminata", &
//						"Aggiornati " + string(k_rec, "####") + " righe della tabella MECA_DOSIM~n~r" &
//					, & 
//					Information!)
//	
//end if	 

return 0 //k_rec

end function

public function string u_num_itatousa (string k_stringa);//
//--- restituisce campo stringa con numero decimale da formato ITALIA a USA 
//--- esempio: '12,50' diventa '12.50'
//
string k_return_stringa
string k_old_str, k_new_str
int k_start_pos

		k_return_stringa = k_stringa
		k_start_pos = 1
		k_old_str = ","
		k_new_str = "."
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP

return k_return_stringa

end function

public function long u_ds_to_csv (datastore a_ds, string a_file) throws uo_exception;//------------------------------------------------------------------------------------------------
//--- Mette il contenuto di un Datastore in un file CSV 
//--- Input: datastore che contiene le righe e colonne da estrarre e copiare nel file (path compreso)
//--- Ritorna: nr di record scritti
//---            
//------------------------------------------------------------------------------------------------
//
long k_return = 0
string k_record = "", k_record_testata=""
long k_filenum, k_righe, k_colonne, k_ind_r, k_ind_c
string k_data, k_nome_coltesta
uo_exception kuo_exception


k_filenum=FileOpen(a_file, LineMode!, Write!, LockWrite!, Replace!, EncodingANSI!) //EncodingUTF8!) 

if k_filenum > 0 then

	k_righe = a_ds.rowcount()
	k_colonne = long(a_ds.Describe("DataWindow.Column.Count"))
	for k_ind_r = 1 to k_righe
		k_record = ""
		for k_ind_c = 1 to k_colonne
			if a_ds.Describe("#" + trim(string(k_ind_c)) + ".visible") = "1" then
				// se sono oltre la prima Colonna aggiungo il separatore di colonne
				if k_ind_c > 1 then 
					k_record += ";"
					k_record_testata += ";"
				end if
				// se sono sulla prima riga estrazione della testa
				if k_ind_r = 1 then
					k_nome_coltesta = trim(a_ds.Describe("#" + trim(string(k_ind_c)) + ".name"))
					if k_nome_coltesta > " " then
						k_nome_coltesta += "_t"
						k_record_testata += trim(a_ds.Describe(k_nome_coltesta + ".text")) 
					end if
				end if
				k_data = left(a_ds.Describe("#" + trim(string(k_ind_c)) + ".ColType"), 3)
				choose case k_data
					case "cha"
						k_data = a_ds.getitemstring(k_ind_r, k_ind_c)
					case "dat"
						k_data = string(a_ds.getitemdate(k_ind_r, k_ind_c))
					case "dec"
						k_data = string(a_ds.getitemnumber(k_ind_r, k_ind_c))
					case "int"
						k_data = string(a_ds.getitemnumber(k_ind_r, k_ind_c))
					case "lon"
						k_data = string(a_ds.getitemnumber(k_ind_r, k_ind_c))
					case "num"
						k_data = string(a_ds.getitemnumber(k_ind_r, k_ind_c))
					case "ulo"
						k_data = string(a_ds.getitemnumber(k_ind_r, k_ind_c))
					case "tim"
						k_data = string(a_ds.getitemtime(k_ind_r, k_ind_c))
				end choose
				if k_data > " " then // evita i NULL che azzerano il rec
					k_record += trim(k_data) 
				end if
			end if
		next
		if k_ind_r = 1 then  // se sono sul primo rec scrive anche la testata
			//k_record_testata = u_stringa_pulisci_asc(k_record_testata)
			if FileWriteEx(k_filenum, k_record_testata) > 0 then
				FileWriteEx(k_filenum, k_record) 
				k_return ++
			end if
		else
			if FileWriteEx(k_filenum, k_record) > 0 then
				k_return ++
			end if
		end if
	next
	FileClose(k_filenum) 
	
else
	
	kguo_exception.inizializza(this.classname())
	kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_non_eseguito )
	kguo_exception.setmessage("File " + trim(a_file) + " non generato, probabile problema di accesso/autorizzazione di scrittura del file. " &
							+kkg.acapo + "Verificare che il file non sia aperto da qualche altra applicazione, come ad esempio Excel.")
	throw kguo_exception
	
end if

return k_return

end function

public subroutine u_dw_ddw_retrieve_auto (ref datawindow a_dw_source, transaction a_sqlca);//---
//--- Lancia la retrieve delle colonne DDW dove c'è il flag autoretrieve 
//---
//--- parametri di input:
//---    a_dw_source:  la dw sorgente 
//---    Transaction: x fare il set con SETTRANS 
//---
//---
int k_colcount, k_ctr, k_rcn
string k_rc, k_nome
datawindowchild kdwc_1 



k_colcount = integer(a_dw_source.Describe("DataWindow.Column.Count"))

for k_ctr = 1 to k_colcount 

	if trim(a_dw_source.describe("#"+trim(string(k_ctr))+".DDDW.Name")) <> "?" then
		if trim(a_dw_source.describe("#"+trim(string(k_ctr))+".DDDW.AutoRetrieve")) = "yes" then
			k_rc = a_dw_source.modify("#"+trim(string(k_ctr))+".DDDW.AutoRetrieve = 'no' ")
//			k_nome = trim(a_dw_source.describe("#"+trim(string(k_ctr))+".Name"))
			k_rcn = a_dw_source.getchild(k_nome, kdwc_1)
			if isvalid(a_sqlca) then
				k_rcn = kdwc_1.SetTransObject ( a_sqlca )
			else
				k_rcn = kdwc_1.SetTransObject ( sqlca )
			end if
//			if kdwc_1.rowcount() = 0 then
				k_rcn = kdwc_1.retrieve()
//			end if
		end if
	end if	

end for


end subroutine

public function string u_num_itatousa2 (string a_stringa, boolean a_forzaconversione);//
//--- Campo numerico da formato ITA a USA
//--- input: il numero da convertire + TRUE se forzare conversione anche se già il pc è impostato in inglese
//--- Out: il numero convertito
//--- esempio  '-1.127.123,75'    torna   '-1,127,123.75'
//
string k_return = ""
string k_return_stringa = "", k_stringa, k_segno = ""
int k_start_pos, k_len
boolean k_virgola_trovata=false, k_converti = false


//--- se è in amb ENG allora non converte 
	if a_forzaconversione then
		k_converti = true
	else
		//k_stringa = string(1.2, "0.0")
		if string(1.2, "0.0") = "1,2" then
			k_converti = true  // ITA sono settato come separatore decimale con la virgola
		end if
	end if
		
	if k_converti then
		k_stringa = trim(a_stringa)
		k_len = len(k_stringa)
	
		for k_start_pos = k_len to 1 step -1  
			
			choose case mid(k_stringa, k_start_pos, 1)
				case "0" to "9"
					k_return_stringa = mid(k_stringa, k_start_pos, 1) + k_return_stringa
				case ","
					if not k_virgola_trovata then
						k_virgola_trovata=true
						k_return_stringa = "." + k_return_stringa
					end if
				case "-", "+"
					if k_segno > " " then
					else
						k_segno = mid(k_stringa, k_start_pos, 1)
					end if
				case "."
					k_virgola_trovata=true    // non posso trovare una virgola dopo un punto delle migliaia, ovviamente
					k_return_stringa = "," + k_return_stringa
			end choose
		next
		k_return_stringa = k_segno + k_return_stringa
	else
		k_return_stringa = trim(a_stringa)
	end if
	
return k_return_stringa		
			

end function

public subroutine u_dw_guida_estrazione (ref st_dw_guida_estrazione ast_dw_guida_estrazione) throws uo_exception;////---
string k_codice_x, k_numero_x, k_anno_x, k_cliente_x, k_upper, k_ricerca
long k_codice, k_id_cliente
st_tab_armo kst_tab_armo
kuf_armo kuf1_armo
kuf_clienti kuf1_clienti


try
	k_codice_x = trim(ast_dw_guida_estrazione.input)
	
	ast_dw_guida_estrazione.id_cliente = 0
	ast_dw_guida_estrazione.id_meca = 0
	ast_dw_guida_estrazione.output = ""

//--- se la stringa di ricerca è vuota allora mostra tutto			
	if k_codice_x = "" then 	
		
	else
		
//--- se non inzia con un numero potrebbe essere il cliente o il ASN/ID_MECA
		if not isnumber(left(k_codice_x, 1)) then

//--- se inzia subito con "id" e segue un numero allora è il ID_MECA
			if upper(left(k_codice_x,2)) =  "ID" and isnumber(mid(trim(k_codice_x),3)) then
				
				ast_dw_guida_estrazione.id_meca = long(mid(trim(k_codice_x),3))
				k_ricerca = "Lotto n. ASN/ID " + string(ast_dw_guida_estrazione.id_meca) 
				
			else

	//--- se la stringa di ricerca è C poi un numero allora è il codice cliente
				if upper(left(k_codice_x, 1)) = "C" then
					if isnumber(mid(k_codice_x,2)) then
						ast_dw_guida_estrazione.id_cliente = long(mid(k_codice_x,2))
						k_ricerca = "Cliente " + string(ast_dw_guida_estrazione.id_cliente)
					end if
				end if
			
	//--- se ancora niente forse è il nome cliente
				if ast_dw_guida_estrazione.id_cliente = 0 then
					kuf1_clienti = create kuf_clienti
					k_upper = upper(k_codice_x)
					k_id_cliente = kuf1_clienti.get_codice_da_rag_soc(k_upper)
					k_ricerca = "Cliente " + trim(k_upper)
					if k_id_cliente > 0 then
						ast_dw_guida_estrazione.id_cliente = k_id_cliente
						k_cliente_x = string(k_id_cliente)
						k_codice_x = "C" + k_cliente_x
					else
						kguo_exception.inizializza( )
						kguo_exception.setmessage("Testo non riconosciuto", "Digitare: num. lotto o il numero e anno separati da un '/' o il codice ID lotto, o il codice Anagrafica preceduto da una 'C' (es. C37) o il nominativo")
						throw kguo_exception
					end if
				end if

			end if
		else
				
//--- Vediamo se ho passato il Numero o Id del Lotto

//--- Se la stringa di ricerca contiene un '/'
			if pos(k_codice_x, "/", 1) > 1 then
				k_numero_x = trim(left(k_codice_x, pos(k_codice_x, "/", 1) - 1))
				k_anno_x = trim(mid(k_codice_x, pos(k_codice_x, "/", 1) + 1))
				if len(trim(k_anno_x)) = 0 then 
					k_anno_x = string(kguo_g.get_anno( ))
				end if
				if isnumber(k_numero_x) then
					k_codice_x = k_numero_x
				end if
			else
				k_numero_x = k_codice_x
				k_anno_x = string(kguo_g.get_anno())
			end if
			if not isnumber(k_codice_x) or not isnumber(k_numero_x) or not isnumber(k_anno_x) then
				kguo_exception.inizializza( )
				kguo_exception.setmessage("Testo non riconosciuto", "Digitare: num. lotto o il numero e anno separati da un '/' o il codice ID lotto, o il codice Anagrafica preceduto da una 'C' (es. C37) o il nominativo")
				throw kguo_exception
			end if				
			k_ricerca = "Lotto n. " + trim(k_numero_x) + " anno " + k_anno_x
			
//--- valuta in modo empirico se codice è un ID o un numero Lotto
			k_codice = long(k_codice_x)
			if k_codice > 0 and k_codice < 50000 then // se minore di 50 mila sicuramente si tratta di un numero lotto o codice cliente altrimentise > 5000 di un ID lotto 
				kuf1_armo = create kuf_armo
				kst_tab_armo.num_int = k_codice
				kst_tab_armo.data_int = date(integer(k_anno_x), 01, 01)
				kuf1_armo.get_id_meca(kst_tab_armo)
				ast_dw_guida_estrazione.id_meca = kst_tab_armo.id_meca
			else
				ast_dw_guida_estrazione.id_meca = k_codice
				k_ricerca = "Lotto ASN/ID " + string(ast_dw_guida_estrazione.id_meca) 
			end if
			
		end if	
		
//--- se ancora non ho trovato nulla segnalo!
		if ast_dw_guida_estrazione.id_cliente = 0 and ast_dw_guida_estrazione.id_meca = 0 then
			kguo_exception.inizializza( )
			kguo_exception.setmessage("Ricerca non trovata", "La ricerca per " + k_ricerca + " non ha prodotto risultati, per cercare un Cliente ricorda di anteporre una 'C' al codice")
			throw kguo_exception
		end if
	end if

	ast_dw_guida_estrazione.output = k_codice_x
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_clienti) then destroy kuf1_clienti
	if isvalid(kuf1_armo) then destroy kuf1_armo
	
end try


end subroutine

public function string u_stringa_alfa (string k_stringa);//
//--- restituisce campo con solo char alfabetici 
//--- esempio  'fabio 027 / 5'    torna   'fabio'
//
string k_return_stringa = ""
int k_start_pos

	for k_start_pos = 1 to len(k_stringa) 
		
		choose case mid(k_stringa, k_start_pos, 1)
			case "a" to "z" & 
				 ,"A" to "Z"
				k_return_stringa += mid(k_stringa, k_start_pos, 1) 
		end choose
	next
	
return k_return_stringa		
			

end function

public function string u_stringa_tonome (string k_stringa);//
//--- restituisce campo stringa molto commpresso e dovrebbe assomigliare a un nome
//--- toglie i caratteri speciale spazi, '_' e numeri
//
string k_return_stringa
string k_old_str, k_new_str
int k_start_pos

	k_stringa = u_stringa_pulisci_nomefunzione(k_stringa) 	// se contiene il nome della funzione tra <...> la rimuovo
	k_stringa = u_stringa_compatta(k_stringa)
	k_return_stringa = u_stringa_pulisci(k_stringa) // u_stringa_alfa(k_stringa)

return k_return_stringa

end function

public function string u_get_printer () throws uo_exception;//
//---  Torna il nome della stampante scelta
//
string k_return
string k_printer


	
	printsetup()

	k_printer = u_get_printer_current()
	if isnull(k_printer) then 
		k_printer=""
	end if


return k_printer
end function

public function boolean u_svuota_folder (string a_folder);//
//--- Cancella i file nella cartella compreso di sottocartelle (che vengono rimosse)
//--- input: cartella da svuotare es: "c:\at_m2000\temp"
//
string k_nome
boolean k_return=false
datastore kds_dirlist
long k_riga, k_nr_file
kuf_file_explorer kuf1_file_explorer


	if trim(a_folder) > " " then
		a_folder += kkg.path_sep
		
		kuf1_file_explorer = create kuf_file_explorer
		kds_dirlist = kuf1_file_explorer.dirlist(a_folder + "*.*")
		k_nr_file = kds_dirlist.rowcount()
		
		for k_riga = 1 to k_nr_file
			
			k_nome = a_folder + trim(kds_dirlist.getitemstring(k_riga, "nome"))
			if kds_dirlist.getitemstring(k_riga, "tipo") = "c" then // se è una cartella faccio call ricursiva
				u_svuota_folder(k_nome)  // call ricursiva per svuotare la cartella
				kuf1_file_explorer.of_RemoveDirectory(k_nome)  // rimuove cartella vuota
			else
				
				if filedelete(k_nome) then  // rimuove il file 
					k_return = true
				end if
			end if
			
		end for

		if isvalid(kds_dirlist) then destroy kds_dirlist
		if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
		
	end if

return k_return

end function

public function string u_file_add_suff (string k_path_file, string k_suffisso);//
//--- aggiunge a un nome file il suffisso prima dell'estensione
//--- es. k_path_file = c:\pippo\pluto\paperino.txt  
//---     k_suffisso = _WO
//--- torna: c:\pippo\pluto\paperino_WO.txt  
//
string k_return_stringa="", k_file_nome
string k_trova_str
int k_start_pos, k_pos


		k_file_nome = trim(k_path_file)

//--- estrare l'estensine
		k_start_pos = 1
		k_pos = 1
		k_trova_str = "."
		k_start_pos = pos(k_file_nome, k_trova_str, k_start_pos)
		DO WHILE k_start_pos > 0
			k_pos = k_start_pos 
			k_start_pos = pos(k_file_nome, k_trova_str, k_pos+1 )
		LOOP
		if k_pos > 1 then
			k_return_stringa = left(k_file_nome, k_pos - 1) + trim(k_suffisso) + trim(mid(k_file_nome, k_pos)) //file + il suffisso + estensione
		else
			k_return_stringa = trim(k_file_nome) + trim(k_suffisso)  // solo il file + il suffisso
		end if

return k_return_stringa

end function

public function string u_get_printer_current () throws uo_exception;//
//---  Torna il nome della stampante attiva al momento
//
st_printer kst_printer

	kst_printer = u_get_st_printer()


return kst_printer.name
end function

public function boolean u_print_file (string a_file) throws uo_exception;//
//---  Stampa un file con l'appilicazione del sistema
//
boolean k_return = false
string k_ext="", k_printer
kuf_file_explorer kuf1_file_explorer


try
	if len(trim(a_file)) > 0 then
		
		if FileExists(a_file) then
			
			k_printer = u_get_printer_current()
			
			kuf1_file_explorer = create kuf_file_explorer
		
			if kuf1_file_explorer.of_print( a_file, k_printer ) then
				
				k_return = true
				
			else
				
				k_ext = u_get_ext_file(a_file)
				
				kguo_exception.inizializza()
				kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
				kguo_exception.setmessage( "Stampa non eseguita. Il file "+ trim(a_file) + " non può essere stampato, tipo '" + k_ext + "' non riconosciuto o file non trovato" )
				throw kguo_exception
			end if
		else
			kguo_exception.inizializza()
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
			kguo_exception.setmessage( "Stampa non eseguita. File non trovato: "+ trim(a_file) + " " )
			throw kguo_exception
		end if
	end if

catch (uo_exception kuo_exception)
		kuo_exception.scrivi_log( )
		throw kuo_exception
	
finally
	if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
	
end try

return k_return
end function

public function boolean u_open_app_file (string a_file) throws uo_exception;//
//---  Apre un file con l'applicazione del sistema
//
boolean k_return 
string k_ext, k_esito
kuf_file_explorer kuf1_file_explorer


try
	if len(trim(a_file)) > 0 then
		
		kuf1_file_explorer = create kuf_file_explorer
	
		if kuf1_file_explorer.of_execute( a_file ) then
			
			k_return = true
			
		else
			
			if kuf1_file_explorer.ki_esito > " " then
				k_esito = kuf1_file_explorer.ki_esito
			else
				k_ext = u_get_ext_file(a_file)
			   k_esito = "Il tipo '" + k_ext + "' non riconosciuto o non trovato. " 
			end if
			
			
			kguo_exception.inizializza()
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
			kguo_exception.setmessage( "Il file " + kkg.acapo + trim(a_file) + kkg.acapo + "non è stato aperto per il seguente motivo: " &
							+ kkg.acapo + k_esito)
			throw kguo_exception
		end if
//	
//	else
//		kguo_exception.inizializza()
//		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_insufficienti)
//		kguo_exception.setmessage( "Indicare un File da aprire" )
//		throw kguo_exception
		
	end if


finally
	if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
	
end try

return k_return
end function

public function integer u_pdf_merge (string a_pdf_inp[], string a_pdf_out) throws uo_exception;//---
//--- Unisce con il pgm PDFTK più file pdf 
//--- 
//--- Inp: array con path+nome file pdf da unire 
//---         path+nome file pdf di output 
//--- Out: nr di documenti uniti
//---
int k_return
int k_nr_doc, k_ind, k_nr_doc_merged
string k_nomi_file


	k_nr_doc = upperbound(a_pdf_inp)
	for k_ind = 1 to k_nr_doc
		if a_pdf_inp[k_ind] > " " then
			k_nr_doc_merged ++
			k_nomi_file += a_pdf_inp[k_ind] + " "
		end if
	end for

	if k_nr_doc > 0 then
		if Run("pdftk  " + k_nomi_file + " output " + a_pdf_out, Minimized!) > 0 then
			k_return = k_nr_doc_merged
		else
			kguo_exception.inizializza()
			kguo_exception.set_tipo( kguo_exception.KK_st_uo_exception_tipo_non_eseguito )
			kguo_exception.setmessage( "Unione file pdf", "utility 'pdftk' non eseguita, verificare che sia installata nella cartella del programma o sul sistema")
			throw kguo_exception
		end if
	end if
	
return k_return

end function

public function boolean u_pdf_decrypt (string a_pdf_inp, string a_pdf_out) throws uo_exception;//---
//--- Decripta con il pgm QPDF uf file pdf 
//--- usato ad esempio per evitare gli errori di PASSWORD quindo si lancia l'utility pdftk
//--- Inp: path+nome file pdf da trattare 
//---         path+nome file pdf di output 
//---
boolean k_return=false


	if Run("qpdf --decrypt " + a_pdf_inp + " " + a_pdf_out, Minimized!) > 0 then
		k_return = true
	else
		kguo_exception.inizializza()
		kguo_exception.set_tipo( kguo_exception.KK_st_uo_exception_tipo_non_eseguito )
		kguo_exception.setmessage( "Decriptazione file pdf", "utility 'qpdf' non eseguita, verificare che sia installata nella cartella del programma o sul sistema")
		throw kguo_exception
	end if

return k_return

end function

public function string u_stringa_pulisci_nomefunzione (string k_stringa);//
//--- restituisce campo stringa senza il nome della funzione 
//--- esempio "<pl_barcode_l> Elenco piani di lavoro"   diventa  "Elenco piani di lavoro"
//
string k_return
int k_pos_ini, k_pos_fin


	k_return = k_stringa
	k_pos_ini = pos(k_return, "<", 1)
	if k_pos_ini > 0 then
		k_pos_fin = pos(k_return, ">", k_pos_ini)
		if k_pos_fin > 0 then
			k_return = trim(ReplaceA(k_return, k_pos_ini, k_pos_fin - k_pos_ini + 1, ""))
		end if
	end if
		
return k_return

end function

public function string u_get_email_domain ();//
//--- get del dominio pe email es. @sterigenics.com
//
string k_email, k_domain
int k_pos
kuf_base kuf1_base



try

	kuf1_base = create kuf_base

	k_email = trim(mid(kuf1_base.prendi_dato_base("e_mail"), 2))
	
	if trim(k_email) > " " then
			
		k_pos = pos(k_email, "@", 1)
		if k_pos > 0 then
			k_domain = mid(k_email, k_pos)
		end if
			
	end if

catch (uo_exception kuo_execption)
	kguo_exception.set_esito(kuo_execption.get_st_esito() )
	
finally
	if isvalid(kuf1_base) then destroy kuf1_base
	
end try


return k_domain
end function

public function string u_stringa_alfanum (string k_stringa);//
//--- restituisce campo con solo char alfabetici o numerici
//--- esempio  'fabio 027 / 5'    torna   'fabio0275'
//
string k_return_stringa = ""
int k_start_pos

	for k_start_pos = 1 to len(k_stringa) 
		
		choose case mid(k_stringa, k_start_pos, 1)
			case "a" to "z" & 
				 ,"A" to "Z" & 
				 ,"0" to "9"
				k_return_stringa += mid(k_stringa, k_start_pos, 1) 
		end choose
	next
	
return k_return_stringa		
			

end function

public function string u_xls_create (ref datastore ads_1, string a_path, string a_namefile, string a_namesheet) throws uo_exception;//
//---  Genera file XLS da DS
//--- Inp: datastore, file (path+name), name sheet
//--- Out: nome file completo
//
string k_return
string k_pathfilename
n_dwr_service_parm kn_dwr_service_parm
kuf_file_explorer kuf1_file_explorer


try
	
	kguo_exception.inizializza(this.classname())
	
	if isvalid(ads_1) and  trim(a_path) > " " then

		kn_dwr_service_parm = create n_dwr_service_parm
		kuf1_file_explorer = create kuf_file_explorer

		kuf1_file_explorer.u_directory_create(a_path)

		k_pathfilename = trim(a_path) + trim(a_namefile) + ".xls"
		if isnull(a_namesheet) then a_namesheet = string(now(), "dd_mmm_yyyy")

//--- genera XLS
		kn_dwr_service_parm.is_sheet_name = a_namesheet
		kn_dwr_service_parm.il_title_fg_color = kkg_colore.blu_chiaro
		kn_dwr_service_parm.ib_background = false
		kn_dwr_service_parm.ib_background_color = false
		kn_dwr_service_parm.ib_group_header = false   //skip all group headers 
		kn_dwr_service_parm.ib_group_trailer = false  //skip all group trailers 
		kn_dwr_service_parm.ib_summary = false        //skip summary band 
		kn_dwr_service_parm.ib_footer = false         //skip footer band 
		kn_dwr_service_parm.ib_header = true         //skip header band 
		
		if uf_save_ds_as_excel_parm(ads_1, k_pathfilename, kn_dwr_service_parm) < 1 then
			kguo_exception.kist_esito.esito = kkg_esito.ko
			kguo_exception.kist_esito.sqlerrtext = "Errata esportazione XLS, allegato dell'avviso. File: " + a_path + a_namefile //kn_dwr_service_parm.is_sheet_name
			kguo_exception.scrivi_log( )
		else
			k_return = k_pathfilename
		end if
	else			
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlerrtext = "Errata esportazione XLS, allegato dell'avviso. File: " + a_path + a_namefile //kn_dwr_service_parm.is_sheet_name
		kguo_exception.scrivi_log( )
	end if
	
		
catch (uo_exception kuo_exception)
		kuo_exception.scrivi_log( )
		throw kuo_exception
	
finally
	if isvalid(kn_dwr_service_parm) then destroy kn_dwr_service_parm
	if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer

end try

return k_return
end function

private function st_printer u_get_st_printer () throws uo_exception;//
//---  Torna il nome della stampante attiva al momento
//
String ls_fullstring
String ls_temp
Long ll_place
st_printer kst_printer

	ls_fullstring=PrintGetPrinter()

	ll_place=pos (ls_fullstring, "~t")
	if ll_place > 0 then
		kst_printer.name=left(ls_fullstring, ll_place -1)
		ls_temp=mid(ls_fullstring, ll_place +1)
		ll_place=pos (ls_temp, "~t")
		kst_printer.driver=left(ls_temp, ll_place -1)
		kst_printer.port=mid(ls_temp, ll_place +1)
		
		if trim(kst_printer.name) > " " then
		else
			kst_printer.name = ""
		end if
		 //.name + "," + ls_driver + "," + ls_port
	end if


return kst_printer 
end function

public function string u_get_printer_string_current () throws uo_exception;//
//---  Torna il nome+drive+port della stampante attiva al momento
//
string k_return
st_printer kst_printer

	kst_printer = u_get_st_printer()

	k_return = kst_printer.name + "," + kst_printer.driver + "," + kst_printer.port

return k_return
end function

public function string u_set_printer_system (string a_printer) throws uo_exception;//
//--- Imposta la stampante di sistema 
//--- Inp: stampante da modificare
//--- Out: la stampante di origine
//
int k_rc
string k_printer_orig


	k_rc = RegistryGet( 'HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows' , 'Device', RegString!, k_printer_orig)
	k_rc = RegistrySet( 'HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows' , 'Device', RegString!, a_printer)

return k_printer_orig
end function

public function string u_string_replace (string k_string, readonly string k_str_old, readonly string k_str_new);//
//--- restituisce campo stringa con uno o più caratteri ricoperti
//--- inp: stringa da ricoprire
//---      vecchio carattere
//---      nuovo carattere
//
int k_pos=1
int k_len, k_len_in


if k_str_old <> k_str_new then

	k_len = len(k_str_new)
	k_len_in = len(k_str_old)
	
	k_pos = pos(k_string, k_str_old, k_pos)
	do while k_pos > 0 
		
		k_string = replace(k_string, k_pos, k_len_in, k_str_new)
		k_pos += k_len
		k_pos = pos(k_string, k_str_old, k_pos)
		
	loop
	
end if

return k_string

end function

private function st_proteggi u_proteggi_set_st_proteggi (character k_operazione);//---------------------------------------------------------------------------------
//---
//--- Protegge/Sprotegge un campo della dw
//---
//--- parametri di input:
//---    k_operazione se:
//          1=proteggi dw;
//          3=proteggi senza modificare il colore nella dw;
//          5=proteggi senza modificare il Protect dw;
//          0=sproteggi dw; 
//          2=S-proteggi senza modificare il colore nella dw;
//          4=S-proteggi senza modificare il Protect dw;
//--- Out: st_proteggi con impostati i campi
//---------------------------------------------------------------------------------
st_proteggi kst_proteggi


//--- protezione campi per impedire la modifica
	if k_operazione = "1" or k_operazione = "5" then  //proteggi
		kst_proteggi.color_background=string(KKG_COLORE.campo_disattivo) //rgb(192,192,192))
	else   // sproteggi
		if k_operazione = "0" or k_operazione = "4" then  //sproteggi
			kst_proteggi.color_background=string(KKG_COLORE.BIANCO) //rgb(255,255,255))
		end if
	end if

//--- protezione campi per impedire la modifica
	if k_operazione = "1" or k_operazione = "3" or k_operazione = "5" then  //proteggi
		kst_proteggi.protect = "1"
		kst_proteggi.visible="0"
	else
		if k_operazione = "0" or k_operazione = "2" or k_operazione = "4" then  //sproteggi
			kst_proteggi.protect = "0"
			kst_proteggi.visible="1"
		else
			kst_proteggi.protect = "1"
		end if
	end if
		
return kst_proteggi
end function

public subroutine u_proteggi_sproteggi_dw (ref uo_d_std_1 adw_1);/*
Protegge o sproteggi campi del form per i campi con Tab-order > 0
     Input: il datawindow e la proprietà ki_flag_modalita
*/
int k_ctr, k_colcount
string k_tabsequence


choose case adw_1.ki_flag_modalita
		
	case kkg_flag_modalita.visualizzazione &
			,kkg_flag_modalita.cancellazione 
		u_proteggi_dw("1", 0, adw_1) 	//--- protezione di tutto

	case kkg_flag_modalita.inserimento &
			,kkg_flag_modalita.modifica
		k_colcount = integer(adw_1.Describe("DataWindow.Column.Count"))

		for k_ctr = 1 to k_colcount 

//--- estrae Describe("<Columnname>.TabSequence")
			k_tabsequence = trim(adw_1.Describe("#" + trim(string(k_ctr,"###")) + ".TabSequence"))

			if k_tabsequence <> "?" and k_tabsequence <> "!" and k_tabsequence > "0" then
				u_proteggi_dw("0", k_ctr, adw_1) 	//--- Sprotezione del campo
			else
				u_proteggi_dw("1", k_ctr, adw_1) 	//--- Sprotezione del campo
			end if
		
		next

end choose

	

end subroutine

public function string u_get_nome_file_noext (string k_path_file);//
//--- restituisce solo il nome file + estensione se c'era da un Path completo
//--- es. c:\pippo\pluto\paperino.txt  torna  paperino
//
int k_start_pos=1, k_pos=1, k_fin
string k_nome_file


k_nome_file = u_get_nome_file(k_path_file)
if k_nome_file > " "	then
	k_fin = len(k_nome_file)
	k_start_pos = pos(k_nome_file, ".", k_start_pos)
	if k_start_pos > 1 then
		DO WHILE k_start_pos > 0
			k_fin = k_start_pos
			k_pos = k_start_pos + 1
			k_start_pos = pos(k_nome_file, ".", k_pos )
		LOOP
	end if

	return trim(mid(k_nome_file, 1, k_fin - 1))

else
	 return ""
end if

end function

public function string u_get_nome_file_add_one_if_exists (string a_file);//
//--- Torna il nome del file (path+nome file) + suffisso '_'+1 se esiste già 
//--- ret: nome del file (path+nome) completo di suffisso se necessario
//
string k_file_rename
string k_file_name_noext, k_path, k_ext
int k_ctr


k_file_rename = a_file
if fileExists(k_file_rename) then

	k_file_name_noext = u_get_nome_file_noext(a_file)
	k_path = u_get_path_file(a_file)
	k_ext = u_get_ext_file(a_file)

	do
		k_ctr ++
		k_file_rename = k_path + k_file_name_noext + "_" + string(k_ctr, "0") + "." + k_ext
	loop while fileExists(k_file_rename)
	
end if

return k_file_rename

end function

public function string u_replace (string k_str, string k_str_old, string k_str_new);//
//--- ricopre nella stringa str i caratteri char_old con char 
//

return kguo_g.u_replace(k_str, k_str_old, k_str_new)

end function

public subroutine u_proteggi_sproteggi_dw_no_protect (ref uo_d_std_1 adw_1);//
//--- protegge o sproteggi campi del form per i campi con Tab-order > 0
//---          ma non imposta il Protect
//--- Inpu: il datawindow e la proprietà ki_flag_modalita
//---
int k_ctr, k_colcount
string k_tabsequence, k_protect
string k_name


choose case adw_1.ki_flag_modalita
		
	case kkg_flag_modalita.visualizzazione &
			,kkg_flag_modalita.cancellazione 
		u_proteggi_dw("5", 0, adw_1) 	//--- protezione di tutto

	case kkg_flag_modalita.inserimento &
			,kkg_flag_modalita.modifica
		k_colcount = integer(adw_1.Describe("DataWindow.Column.Count"))

		for k_ctr = 1 to k_colcount 

//--- estrae Describe("<Columnname>.TabSequence")
			k_protect = u_dw_get_protect_evaluate(adw_1, k_ctr)
			k_name = trim(adw_1.Describe("#" + trim(string(k_ctr,"###")) + ".name"))

			if k_protect <> "?" and k_protect <> "!" and k_protect = "0" then
				k_tabsequence = trim(adw_1.Describe("#" + trim(string(k_ctr,"###")) + ".TabSequence"))

				if k_tabsequence <> "?" and k_tabsequence <> "!" and k_tabsequence > "0" then
					u_proteggi_dw("4", k_ctr, adw_1) 	//--- Sprotezione del campo
				else
					u_proteggi_dw("5", k_ctr, adw_1) 	//--- Protezione del campo
				end if
			else
				u_proteggi_dw("5", k_ctr, adw_1) 	//--- Protezione del campo
			end if
		
		next

end choose

	

end subroutine

public function string u_dw_get_protect_evaluate (datawindow adw_1, integer a_field_n);string ls_protect, ls_eval
long ll_row

ll_row = adw_1.GetRow()
ls_protect = adw_1.describe("#" + trim(string(a_field_n)) + ".Protect")

IF NOT IsNumber(ls_protect) THEN   

	if ll_row > 0 then
	// Get the expression following the tab (~t)   
		ls_protect = Right(ls_protect, Len(ls_protect) - Pos(ls_protect, "~t"))   
	
	// Build string for Describe. Include a leading   
	// quote to match the trailing quote that remains
		ls_eval = "Evaluate(~"" + ls_protect + ", " + String(ll_row) + ")"   

		ls_protect = adw_1.Describe(ls_eval)
		
	else
		
		ls_protect = "!" //"!"
		
	end if

END IF

return ls_protect

end function

public function string u_get_tooltip_text (string a_tooltip_tip) throws uo_exception;//
//---  Torna il testo del TIP dal TOOLTIP string
//
String k_return
String ls_temp
int ll_place


	ll_place = pos(a_tooltip_tip, '~~"')
	if ll_place > 0 then
		ls_temp=mid(a_tooltip_tip, ll_place +2)
		ll_place = pos(ls_temp, '~~"')
		k_return = left(ls_temp, ll_place -1)
	end if

return k_return 
end function

public function string u_stringa_spezza (string k_stringa);//
//--- restituisce campo stringa con uno spazio tra parole troppo lunghe (ogni 24 char) spezza dove trova un '-' o simile 
//---     es. "31482203-31482201-31482204-31482205-31482202-31482206-31482207-31482208-31483780-31483781-31483779-31483783-31483782" 
//---     diventa
//---         "31482203-31482201-31482204- 31482205-31482202-31482206- 31482207-31482208-31483780- 31483781-31483779-31483783- 31483782" 
//--- tipo .'/|\*spazio~'a capo come ~n o ~r o ~t"
//
string k_return_stringa, k_char
int k_ind, k_len, k_cntr


	k_len = len(k_stringa)
	for k_ind = 1 to k_len
		k_char = mid(k_stringa, k_ind, 1)
		if k_char = " " then
			k_cntr = 0 	
		else
			k_cntr ++
		end if
		if k_cntr >= 24 then
			if k_char = "-" &
					or k_char = "\" or k_char =  "/" or k_char = "." or k_char = "," &
					or k_char = "*" or k_char = "_" or k_char = "|" &
					or k_char = "(" or k_char = ")" or k_char = "["  or k_char = "]" then
					
				k_cntr = 0 	
				k_char += " " // SPEZZA: aggiungo il carattere SPAZIO
				
			end if
		end if
		
		k_return_stringa += k_char   // aggiungo un carattere alla volta
		
	next

return k_return_stringa

end function

public function integer u_open_app_files (string a_file) throws uo_exception;//
//---  Apre più file separati da ';' con l'applicazione del sistema
//
string k_files[]
int k_idx_max, k_idx, k_n_files


	a_file = trim(a_file)

	if a_file > " " then
		
		k_files[1] = a_file + ";"   // almeno un ';' finale deve esserci
		
		k_idx_max = u_stringa_split(k_files[], ";")
		
		for k_idx = 1 to k_idx_max
			
			if k_files[k_idx] > " " then
				
				if u_open_app_file( k_files[k_idx] ) then
					k_n_files++
				end if
				
			end if
			
		next		
		
	end if

return k_n_files
end function

public function integer u_stringa_split (ref string a_string[], string a_sep);/*
 Splitta in diverse stringhe separate da un carattere
     inp: array a_string[1] il primo elemento è la stringa da separare 
	     : carattere separatore come ad esempio "," ";" ":"....
     out: array a_string[] con i tronconi
	  Ret: numero di spezzoni
*/
string k_string
int k_str_split_idx
int k_pos, k_i, k_len_sep


if upperbound(a_string[]) > 0 then
	
	k_string = trim(a_string[1])

	if k_string > " " then
		a_string[1] = ""
	
		k_len_sep = len(a_sep)
	
		k_i = 1
		k_pos = pos(k_string, a_sep, k_i)
		do while k_pos > 0
			k_str_split_idx ++
			a_string[k_str_split_idx] = mid(k_string, k_i, k_pos - k_i) 
				
			k_i = k_pos + k_len_sep
			k_pos = pos(k_string, a_sep, k_i)
			
		loop
		
		if k_str_split_idx > 0 then
			if k_i < len(k_string) then 
				k_str_split_idx ++
				a_string[k_str_split_idx] = mid(k_string, k_i, len(k_string) - k_i + 1) 
			end if
		else
			k_str_split_idx = 1
			a_string[1] = k_string   // nessun separatore trovato, rimette il valore originale
		end if
		
	end if

end if

return k_str_split_idx

end function

public function string u_url_sep_path_by_name (ref string a_url);/*
  Separa dal URL il path dal nome 
  Inp: url completo
  Out: url senza nome
  Ret: nome file
*/
string k_return_name
string k_trova_str
int k_start_pos, k_pos


		a_url = trim(a_url)
		k_start_pos = 1
		k_pos = 1
		k_trova_str = "/"
		k_start_pos = pos(a_url, k_trova_str, k_start_pos)
		DO WHILE k_start_pos > 0
			k_pos = k_start_pos + 1
			k_start_pos = pos(a_url, k_trova_str, k_pos )
		LOOP

		k_return_name = trim(mid(a_url, k_pos, len(a_url) - k_pos + 1))
		a_url = trim(left(a_url, k_pos - 1))

return k_return_name

end function

public function string u_url_encode (string a_url, boolean a_replace_puls_sign);/*
 Codifica URL 
 Inp: url da decodificare
      TRUE = per sostituire il '+' con '%20' che sembra più corretto nella maggior parte dei casi  
*/

Blob k_blob
String k_url_encode

k_blob = Blob(a_url, EncodingUTF8!) //, EncodingANSI!)

CoderObject lnv_CoderObject
lnv_CoderObject = Create CoderObject

k_url_encode = lnv_CoderObject.UrlEncode(k_blob)

if a_replace_puls_sign then
	
	k_url_encode = u_replace( k_url_encode, "+", "%20")
	
end if

return k_url_encode
end function

public subroutine u_proteggi_dw (character k_operazione, integer k_id_campo, ref uo_d_std_1 k_dw);//---
//--- meglio usare: u_proteggi_sproteggi_dw

//---
//--- Protegge/Sprotegge campi della dw
//---
//--- parametri di input:
//---    k_operazione se:
//          1=proteggi dw;
//          3=proteggi senza modificare il colore nella dw;
//          5=proteggi senza modificare il Protect dw;
//          0=sproteggi dw; 
//          2=S-proteggi senza modificare il colore nella dw;
//          4=S-proteggi senza modificare il Protect dw;
//--- 
//---    k_id_campo se 0=tutta la dw; >0 solo il numero campo indicato
//---    k_dw la datawindows da proteggere/sproteggere
//---
int k_rc
string k_style, k_type, k_num_colonne, k_campo, k_appo
int k_ctr, k_TabSequence, k_num_colonne_nr
string k_rcx 
string k_modify
st_proteggi kst_proteggi


	k_dw.setredraw(false)

	if k_id_campo = 0 and (k_operazione = "1" or k_operazione = "5") then   // protegge tutta la dw
		k_modify = "DataWindow.ReadOnly=yes "
	else
		k_modify = "DataWindow.ReadOnly=no "
	end if

//--- imposta i campi Colore, Protetto ....
	kst_proteggi = u_proteggi_set_st_proteggi(k_operazione)

	if k_id_campo > 0 then
		// FACCIO solo 1 campo
		k_ctr = k_id_campo
		k_num_colonne_nr = k_id_campo
	else
		// FACCIO TUTTA LA DW
		k_ctr=1

		k_num_colonne = k_dw.Object.DataWindow.Column.Count
		if isnumber(k_num_colonne) then
			k_num_colonne_nr = integer(k_num_colonne)
		else
			k_num_colonne_nr = 99
		end if
	end if
	
	do 

		k_campo = trim(string(k_ctr,"###"))
		//k_appo = k_dw.Describe("#" + k_campo + ".Name")

		k_type = lower(trim(k_dw.Describe("#" + k_campo + ".Type")))
		
		k_TabSequence=integer(k_dw.Describe("#" + trim(string(k_ctr,"###"))+".TabSequence"))
		if k_TabSequence > 0 then
				
			k_style = trim(k_dw.Describe("#" + k_campo + ".Edit.Style"))
			if k_style <> "checkbox" and k_style <> "radiobuttons" then
			
				if k_operazione <> "2" and k_operazione <> "3" then  //2 o 3 fai senza mod il colore
				
					k_rcx = trim(k_dw.Describe("#" + k_campo + ".Background.Color"))
					if k_rcx <> "!" and k_rcx <> "?" then
						k_modify += "#" + k_campo+".Background.Color='" + kst_proteggi.color_background + "' " 
					end if
					
					if k_type = "column" then
						k_rcx = trim(k_dw.Describe("#" + k_campo + ".Background.Transparency"))
						if k_rcx <> "!" and k_rcx <> "?" and k_rcx <> "0" then
					   	k_modify += "#" + k_campo+".Background.Transparency=1" + " "  //imposta OPACO (100=trasparente)
						end if
					end if
					//k_rcx = k_dw.Modify("#" + k_campo+".Background.Color="+kst_proteggi.color+" " &
				     //                  +"#" + k_campo+".Background.Transparency=1") 

				end if
				
			end if
				
		end if

		if k_operazione <> "4" and k_operazione <> "5" then  //4 o 5 fai senza mod il Protect
			if k_type = "column" then
				k_rcx = trim(k_dw.Describe("#" + k_campo + ".Protect"))
				if k_rcx <> "!" and k_rcx <> "?" then
					k_modify += "#" + k_campo + ".Protect='"+trim(kst_proteggi.protect)+"'" + " "
				end if
			end if
		end if
		
		//k_rcx=k_dw.Modify("#" + k_campo + ".Protect='"+trim(kst_proteggi.protect)+"'")
		k_ctr = k_ctr + 1 

	loop while k_ctr <= k_num_colonne_nr and k_id_campo = 0

	k_rcx=k_dw.Modify(k_modify)
	k_dw.u_set_column_color()   // imposta il colore del testo nelle colonne

	k_dw.setredraw(true)


end subroutine

private subroutine old_u_dw_set_column_color (ref uo_d_std_1 k_dw);/*
   Imposta il COLOR del testo a seconda del background
*/
int k_rc
string k_style, k_type, k_num_colonne, k_campo, k_appo
int k_ctr, k_num_colonne_nr
string k_rcx , k_color_black, k_color_white
string k_modify
long k_backgroundColor, k_n


	k_dw.setredraw(false)
	
	k_color_black = string(kkg_colore.nero)
	k_color_white = string(kkg_colore.bianco)

	k_num_colonne = k_dw.Object.DataWindow.Column.Count
	if isnumber(k_num_colonne) then
		k_num_colonne_nr = integer(k_num_colonne)
	else
		k_num_colonne_nr = 99
	end if
	do 

		k_campo = trim(string(k_ctr,"###"))
		//k_appo = k_dw.Describe("#" + k_campo + ".Name")

		k_style = trim(k_dw.Describe("#" + k_campo + ".Edit.Style"))
		if k_style <> "!" and k_style <> "?" and k_style <> "checkbox" and k_style <> "radiobuttons" then //and k_style <> "dddw" and k_style <> "ddlb" then
			
			k_type = lower(trim(k_dw.Describe("#" + k_campo + ".Type")))
		
			k_backgroundColor = long(k_dw.Describe("#" + trim(string(k_ctr,"###")) + ".Background.Color"))
			if k_backgroundColor = 0 then  // se il colore sfondo è zero (presuppongo sia TRANSPARENT) allora piglia il colore di sffondo del DE
				k_backgroundColor = long(k_dw.Describe("DataWindow.Color"))
			end if				
			if k_backgroundColor <= kkg_colore.bianco then
				//k_n = kkg_colore.SFONDO_SCURO_n
				if k_backgroundColor >= kkg_colore.SFONDO_SCURO_n then
					k_modify += "#" + k_campo+".Color='" + k_color_black + "' "
				else
					k_modify += "#" + k_campo+".Color='" + k_color_white + "' "
				end if
			end if				
		end if
		k_ctr = k_ctr + 1 

	loop while k_ctr <= k_num_colonne_nr //and k_id_campo = 0

	k_rcx=k_dw.Modify(k_modify)

	k_dw.setredraw(true)


end subroutine

private subroutine old_u_dw_set_column_color (ref datawindow k_dw);/*
   Imposta il COLOR del testo a seconda del background
*/
int k_rc
string k_style, k_type, k_num_colonne, k_campo, k_appo
int k_ctr, k_num_colonne_nr
string k_rcx , k_color_black, k_color_white
string k_modify
long k_backgroundColor, k_n


	k_dw.setredraw(false)
	
	k_color_black = string(kkg_colore.nero)
	k_color_white = string(kkg_colore.bianco)

	k_num_colonne = k_dw.Object.DataWindow.Column.Count
	if isnumber(k_num_colonne) then
		k_num_colonne_nr = integer(k_num_colonne)
	else
		k_num_colonne_nr = 99
	end if
	do 

		k_campo = trim(string(k_ctr,"###"))
		//k_appo = k_dw.Describe("#" + k_campo + ".Name")

		k_style = trim(k_dw.Describe("#" + k_campo + ".Edit.Style"))
		if k_style <> "!" and k_style <> "?" and k_style <> "checkbox" and k_style <> "radiobuttons" then //and k_style <> "dddw" and k_style <> "ddlb" then
			
			k_type = lower(trim(k_dw.Describe("#" + k_campo + ".Type")))
		
			k_backgroundColor = long(k_dw.Describe("#" + trim(string(k_ctr,"###")) + ".Background.Color"))
			if k_backgroundColor = 0 then  // se il colore sfondo è zero (presuppongo sia TRANSPARENT) allora piglia il colore di sffondo del DE
				k_backgroundColor = long(k_dw.Describe("DataWindow.Color"))
			end if				
			if k_backgroundColor <= kkg_colore.bianco then
				//k_n = kkg_colore.SFONDO_SCURO_n
				if k_backgroundColor >= kkg_colore.SFONDO_SCURO_n then
					k_modify += "#" + k_campo+".Color='" + k_color_black + "' "
				else
					k_modify += "#" + k_campo+".Color='" + k_color_white + "' "
				end if
			end if				
		end if
		k_ctr = k_ctr + 1 

	loop while k_ctr <= k_num_colonne_nr //and k_id_campo = 0

	k_rcx=k_dw.Modify(k_modify)

	k_dw.setredraw(true)


end subroutine

public subroutine u_proteggi_dw (character k_operazione, string k_txt_campo, ref uo_d_std_1 k_dw);//---
//--- meglio usare: u_proteggi_sproteggi_dw

//--- Protegge/Sprotegge un campo della dw
//---
//--- parametri di input:
//---    k_operazione se:
//          1=proteggi dw;
//          3=proteggi senza modificare il colore nella dw;
//          5=proteggi senza modificare il Protect dw;
//          0=sproteggi dw; 
//          2=S-proteggi senza modificare il colore nella dw;
//          4=S-proteggi senza modificare il Protect dw;
//--- 
//---    k_txt_campo = "nome_campo" solo il campo indicato se non è una colonna viene nascosto (visible=0)
//---    k_dw la datawindows da proteggere/sproteggere
//---
int k_rc
string k_id_campox
int k_id_campo
//string k_style
//string k_type
//string k_visible="1"
//int k_ctr
//string k_rcx, k_modify
//st_proteggi kst_proteggi


if trim(k_txt_campo) > " " then

	k_id_campox = trim(k_dw.Describe( trim(k_txt_campo) + ".ID"))
	if IsNumber (k_id_campox) then
		k_id_campo = integer(k_id_campox)

		u_proteggi_dw(k_operazione, k_id_campo, k_dw)
	end if 

//	if k_operazione = "0" or k_operazione = "2" then  //proteggi 
//		k_modify = "DataWindow.ReadOnly=no "
//	end if
//	
////--- imposta i campi Colore, Protetto ....
//	kst_proteggi = u_proteggi_set_st_proteggi(k_operazione)
//
//	if trim(k_txt_campo) > " " then
//		k_ctr=0
//	else
//		k_ctr=1
//	end if
//
//	k_type = trim(k_dw.Describe(" " + trim(k_txt_campo)+".Type"))
//	if k_type = "column" then
//		
//		if k_operazione <> "4" and k_operazione <> "5" then  //4 o 5 fai senza mod il Protect
//			k_modify += " " + trim(k_txt_campo) + ".Protect='" + trim(kst_proteggi.protect)+"'"
//		end if
//		
//		k_style=trim(k_dw.Describe(" " + trim(k_txt_campo)+".Edit.Style"))
//		if k_style <> "checkbox" and k_style <> "radiobuttons" then
//			
//			if k_operazione <> "2" and k_operazione <> "3" then  //fai senza mod il colore
//			
//				k_modify += trim(k_txt_campo)+".Background.Color='"+kst_proteggi.color+"'" &
//				          + trim(k_txt_campo)+".Background.Transparency=1"
//			end if
//			
//		end if
//
//	else
//		
//		k_modify += " " + trim(k_txt_campo)+".Visible='"+trim(k_visible)+"'"
//
//	end if
//	
//	if k_modify > " " then
//		
//		k_rcx = k_dw.Modify(k_modify)
//		u_dw_set_column_color(k_dw)   // imposta il colore del testo nelle colonne	
//		
//	end if
	
else
	u_proteggi_dw(k_operazione, 0, k_dw)
end if

end subroutine

public function string u_stringa_alfanum_spazio (string k_stringa);//
//--- restituisce campo con solo char alfabetici o numerici o spazio (o'_' che diventa spazio)
//--- esempio  'fabio 027 / 5_cinque'    torna   'fabio 027 5 cinque'
//
string k_return_stringa = ""
int k_start_pos

	for k_start_pos = 1 to len(k_stringa) 
		
		choose case mid(k_stringa, k_start_pos, 1)
			case "a" to "z" & 
				 ,"A" to "Z" & 
				 ,"0" to "9" &
				 ," " &
				 ,"_" 
				if mid(k_stringa, k_start_pos, 1) = "_" then 
					k_return_stringa += " "
				else
					k_return_stringa += mid(k_stringa, k_start_pos, 1) 
				end if
		end choose
	next
	
return k_return_stringa
			

end function

public function boolean u_copy_dw_composite (ref datawindow adw_source, ref datawindow adw_target);/*
 Copia dal DW source Composite al DW target composite solo i dw child (composite)
  Inp: dw_source  la dw sorgente
  Out: dw_target  la dw in cui copiare 
  Rit: true = copia eseguita
*/
boolean k_return
int k_rc
string k_name, k_objects[]
string k_Processing
int k_ctr
int k_colcount
datawindowchild kdwc_source, kdwc_target


/* get del tipo DW che possono essere:
0 -- (Default) Form, group, n-up, or tabular
1 -- Grid
2 -- Label
3 -- Graph
4 -- Crosstab
5 -- Composite
6 -- OLE
7 -- RichText
8 -- TreeView
9 -- TreeView with Grid
*/
	k_Processing = trim(adw_source.Describe("DataWindow.Processing"))
	if k_Processing <> "5" then return false

//	k_colcount = this.u_dw_get_objects(adw_source, k_objects[])
	k_objects[1] = trim(adw_source.Describe("DataWindow.Objects")) 
	k_colcount = kgn_string.u_stringa_split(k_objects[], "~t")	

	for k_ctr = 1 to k_colcount
		k_name = trim(adw_source.Describe(k_objects[k_ctr] + ".name"))
		if k_name <> "!" then 
		
			if adw_source.GetChild(k_name, kdwc_source) > 0 then
				adw_target.GetChild(k_name, kdwc_target) 
	
	//--- Copia le RIGHE del composite
				k_rc = kdwc_source.rowscopy(1, kdwc_source.rowcount(), primary!, kdwc_target, 1 ,primary!)
				
				k_rc = kdwc_target.rowcount()
	
				k_return = true
			end if
		
		end if
	next

return k_return 

end function

public function boolean u_copy_ds_dw_composite (ref datastore ads_source, ref datawindow adw_target);/*
 Copia dal DS source Composite al DW target composite solo i dw child (composite)
  Inp: dw_source  la dw sorgente
  Out: dw_target  la dw in cui copiare 
  Rit: true = copia eseguita
*/
boolean k_return
int k_rc
string k_name, k_objects[]
string k_Processing
int k_ctr
int k_colcount
datawindowchild kdwc_source, kdwc_target


/* get del tipo DW che possono essere:
0 -- (Default) Form, group, n-up, or tabular
1 -- Grid
2 -- Label
3 -- Graph
4 -- Crosstab
5 -- Composite
6 -- OLE
7 -- RichText
8 -- TreeView
9 -- TreeView with Grid
*/
	k_Processing = trim(ads_source.Describe("DataWindow.Processing"))
	if k_Processing <> "5" then return false

	//k_colcount = this.u_ds_get_objects(ads_source, k_objects[])
	k_objects[1] = trim(ads_source.Describe("DataWindow.Objects")) 
	k_colcount = kgn_string.u_stringa_split(k_objects[], "~t")	

	for k_ctr = 1 to k_colcount
		k_name = trim(ads_source.Describe(k_objects[k_ctr] + ".name"))
		if k_name <> "!" then 
		
			if ads_source.GetChild(k_name, kdwc_source) > 0 then
				adw_target.GetChild(k_name, kdwc_target) 
	
	//--- Copia le RIGHE del composite
				k_rc = kdwc_source.rowscopy(1, kdwc_source.rowcount(), primary!, kdwc_target, 1 ,primary!)
				
				k_rc = kdwc_target.rowcount()
	
				k_return = true
			end if
		
		end if
	next

return k_return 

end function

public function boolean u_copy_ds_composite (ref datastore ads_source, ref datastore ads_target);/*
 Copia dal DS source Composite al DW source composite solo i dw child (composite)
  Inp: dw_source  la dw sorgente
  Out: dw_target  la dw in cui copiare 
  Rit: true = copia eseguita
*/
boolean k_return
int k_rc
string k_name, k_objects[]
string k_Processing
int k_ctr
int k_colcount
datawindowchild kdwc_source, kdwc_target


/* get del tipo DW che possono essere:
0 -- (Default) Form, group, n-up, or tabular
1 -- Grid
2 -- Label
3 -- Graph
4 -- Crosstab
5 -- Composite
6 -- OLE
7 -- RichText
8 -- TreeView
9 -- TreeView with Grid
*/
	k_Processing = trim(ads_source.Describe("DataWindow.Processing"))
	if k_Processing <> "5" then return false

	//k_colcount = this.u_ds_get_objects(ads_source, k_objects[])
	k_objects[1] = trim(ads_source.Describe("DataWindow.Objects")) 
	k_colcount = kgn_string.u_stringa_split(k_objects[], "~t") //"~t")	

	for k_ctr = 1 to k_colcount
		k_name = trim(ads_source.Describe(k_objects[k_ctr] + ".name"))
		if k_name <> "!" then 
		
			if ads_source.GetChild(k_name, kdwc_source) > 0 then
				ads_target.GetChild(k_name, kdwc_target) 
	
	//--- Copia le RIGHE del composite
				k_rc = kdwc_source.rowscopy(1, kdwc_source.rowcount(), primary!, kdwc_target, 1 ,primary!)
				
				k_rc = kdwc_target.rowcount()
	
				k_return = true
			end if
		
		end if
	next

return k_return 

end function

private function string u_ds_get_evaluate_expression_all (ref uo_ds_std_1 ads_1);/*
   Estrae i Valori contenuti/calcolati nelle EXPRESSION dei tipi COMPUTE e TEXT
	Rit: la string contiene il MODIFY da applicare
*/
int k_ctr, k_colcount
string k_value, k_type, k_col, k_modify, k_rcx, k_band
string k_objects[]


	//k_colcount = u_ds_get_objects(ads_1, k_objects[])
	k_objects[1] = trim(ads_1.Describe("DataWindow.Objects")) 
	k_colcount = kgn_string.u_stringa_split(k_objects[], "~t")	

	for k_ctr = 1 to k_colcount 

		// get the BAND: Detail, Footer, Summary, Header, Trailer, Tree.Level, foreground, background
		k_col = k_objects[k_ctr]
		k_band = left(ads_1.Describe(k_col + ".band"), 4)
		if k_band <> "deta" and k_band <> "tree" then
			
			k_type = ads_1.Describe(k_col + ".type")
			choose case upper(left(k_type,4))
				case "COMP"
					k_value = ads_1.u_get_evaluate(k_col, "Expression", 0)
					if k_value > " " then
						k_modify += k_col + ".expression=~"string('" + k_value + "')~" " 		
					end if
				case "TEXT"
					k_value = ads_1.u_get_evaluate(k_col, "Text", 0)
					if k_value > " " then
						k_modify += k_col + ".text = '" + k_value + "' " 		
					end if
				case else
					k_value = ""
			end choose		
		end if
	next
	
return k_modify
	

end function

public function integer u_rowscopy_ds_to_dw (ref datastore ads_source, ref datawindow adw_target) throws uo_exception;/*
  Copia righe e expression oltre ai report composite
  rit: 1 = Ok
*/
int k_return
string k_modify, k_rcx
 
 
	k_return = ads_source.RowsCopy(1, ads_source.RowCount(), Primary!, adw_target, 1, Primary!)
	k_modify = u_ds_get_evaluate_expression_all(ads_source)
	k_modify = kgn_string.u_string_replace(k_modify, "''", "~~''")
	k_rcx = adw_target.modify(k_modify)
	u_copy_ds_dw_composite( ads_source, adw_target )
	
return k_return 	
end function

public function integer u_rowscopy_ds_to_ds (ref datastore ads_source, ref uo_ds_std_1 ads_target) throws uo_exception;/*
  Copia righe e expression oltre ai report composite
  rit: 1 = ok
*/
int k_return
string k_modify, k_rcx
 

	k_return = ads_source.RowsCopy(1, ads_source.RowCount(), Primary!, ads_target, 1, Primary!)
	if k_return = 1 then
		k_modify = u_ds_get_evaluate_expression_all(ads_source)
		k_modify = kgn_string.u_string_replace(k_modify, "''", "~~''")
		k_rcx = ads_target.modify(k_modify)
		u_copy_ds_composite( ads_source, ads_target )
	end if	
	
return k_return	
end function

private function string u_dw_get_evaluate_expression_all (ref datawindow adw_1);/*
   Estrae i Valori contenuti/calcolati nelle EXPRESSION dei tipi COMPUTE e TEXT
	Rit: la string contiene il MODIFY da applicare
*/
int k_ctr, k_colcount
string k_value, k_type, k_col, k_modify, k_rcx, k_band
string k_objects[]


	//k_colcount = u_ds_get_objects(adw_1, k_objects[])
	k_objects[1] = trim(adw_1.Describe("DataWindow.Objects")) 
	k_colcount = kgn_string.u_stringa_split(k_objects[], "~t")	

	for k_ctr = 1 to k_colcount 

		
		// get the BAND: Detail, Footer, Summary, Header, Trailer, Tree.Level
		k_col = k_objects[k_ctr]
		k_band = adw_1.Describe(k_col + ".band")
		if k_band <> "deta" and k_band <> "tree" then
			
			k_type = adw_1.Describe(k_col + ".type")
			choose case upper(left(k_type,4))
				case "COMP"
					k_value = u_dw_get_evaluate(adw_1, k_col, "Expression", 0)
					if k_value > " " then
						k_modify += k_col + ".expression=~"string('" + k_value + "')~" " 		
					end if
				case "TEXT"
					k_value = u_dw_get_evaluate(adw_1, k_col, "Text", 0)
					if k_value > " " then
						k_modify += k_col + ".text = '" + k_value + "' " 		
					end if
				case else
					k_value = ""
			end choose		
		end if
	next
	
return k_modify
	

end function

public function integer u_rowscopy_dw_to_dw (ref datawindow adw_source, ref datawindow adw_target) throws uo_exception;/*
  Copia righe e expression oltre ai report composite
  rit: 1 = Ok
*/
int k_return
string k_modify, k_rcx
 

	k_return = adw_source.RowsCopy(1, adw_source.RowCount(), Primary!, adw_target, 1, Primary!)
	k_modify = u_dw_get_evaluate_expression_all(adw_source)
	k_modify = kgn_string.u_string_replace(k_modify, "''", "~~''")
	k_rcx = adw_target.modify(k_modify)
	u_copy_dw_composite( adw_source, adw_target )
	
return k_return 	
end function

private function string u_ds_get_evaluate_expression_all (ref datastore ads_1);/*
   Estrae i Valori contenuti/calcolati nelle EXPRESSION dei tipi COMPUTE e TEXT
	Rit: la string contiene il MODIFY da applicare
*/
int k_ctr, k_colcount
string k_value, k_type, k_col, k_modify, k_rcx, k_band
string k_objects[]


	//k_colcount = u_ds_get_objects(ads_1, k_objects[])
	k_objects[1] = trim(ads_1.Describe("DataWindow.Objects")) 
	k_colcount = kgn_string.u_stringa_split(k_objects[], "~t")	

	for k_ctr = 1 to k_colcount 

		// get the BAND: Detail, Footer, Summary, Header, Trailer, Tree.Level
		k_col = k_objects[k_ctr]
		k_band = ads_1.Describe(k_col + ".band")
		if k_band <> "deta" and k_band <> "tree" then
	
			k_type = ads_1.Describe(k_col + ".type")
			choose case upper(left(k_type,4))
				case "COMP"
					k_value = u_ds_get_evaluate(ads_1, k_col, "Expression", 0)
					if k_value > " " then
						k_modify += k_col + ".expression=~"string('" + k_value + "')~" " 		
					end if
				case "TEXT"
					k_value = u_ds_get_evaluate(ads_1, k_col, "Text", 0)
					if k_value > " " then
						k_modify += k_col + ".text = '" + k_value + "' " 		
					end if
				case else
					k_value = ""
			end choose		
			
		end if

	next
	
return k_modify
	

end function

public function integer u_rowscopy_ds_to_ds (ref uo_ds_std_1 ads_source, ref uo_ds_std_1 ads_target) throws uo_exception;/*
  Copia righe e expression oltre ai report composite
  rit: 1 = ok
*/
int k_return
string k_modify, k_rcx
 

	k_return = ads_source.RowsCopy(1, ads_source.RowCount(), Primary!, ads_target, 1, Primary!)
	if k_return = 1 then
		k_modify = u_ds_get_evaluate_expression_all(ads_source)
		k_modify = kgn_string.u_string_replace(k_modify, "''", "~~''")
		k_rcx = ads_target.modify(k_modify)
		u_copy_ds_composite( ads_source, ads_target )
	end if	
	
return k_return	
end function

public function integer u_rowscopy_ds_to_dw (ref uo_ds_std_1 ads_source, ref datawindow adw_target) throws uo_exception;/*
  Copia righe e expression oltre ai report composite
  rit: 1 = Ok
*/
int k_return
string k_modify, k_rcx
 

	k_return = ads_source.RowsCopy(1, ads_source.RowCount(), Primary!, adw_target, 1, Primary!)
	k_modify = u_ds_get_evaluate_expression_all(ads_source)
	k_modify = kgn_string.u_string_replace(k_modify, "''", "~~''")
	k_rcx = adw_target.modify(k_modify)
	u_copy_ds_dw_composite( ads_source, adw_target )
	
return k_return 	
end function

public function string u_ds_get_evaluate (ref datastore ads_1, string a_field, string a_field_describe, long a_row);/*
   torna il valore calcolato da EXPRESSION
	inp: datastore: da cui estrarre il valore
	     field: nome campo
	     filed_describe: es. background.color
		  row: riga se però è una testata si può passare zero
*/
string ls_expression, ls_value, ls_eval
int k_pos


a_field = trim(a_field)

IF IsNumber(a_field) THEN   
	ls_expression = trim(ads_1.describe("#" + a_field + "." + a_field_describe))
else
	ls_expression = trim(ads_1.describe(a_field + "." + a_field_describe))
end if

IF ls_expression > " " THEN   
else
	return ""   // ESCE con nulla
end if

// Get the expression following the tab (~t) 
ls_expression = trim(Right(ls_expression, Len(ls_expression) - Pos(ls_expression, "~t")))

//--- se NON c'è una parentesi è poco probabile che sia una expression 
if Pos(ls_expression, "(") = 0 then return ""     // ESCE con nulla

//--- rimuove i doppi apici
k_pos = Pos(ls_expression, '~"', 1)
do while k_pos > 0 
	ls_expression = replace(ls_expression, k_pos, 1, "'")
	k_pos = Pos(ls_expression, '~"', k_pos)
loop
k_pos = Pos(ls_expression, "~~", 1)
do while k_pos > 0 
	ls_expression = replace(ls_expression, k_pos, 1, "")
	k_pos = Pos(ls_expression, "~~", k_pos)
loop

if left(ls_expression, 1) = "'" then
	ls_expression = trim(mid(ls_expression, 2))
end if
if mid(ls_expression, Len(ls_expression), 1) = "'" then
	ls_expression = left(ls_expression, Len(ls_expression) -1)
end if

IF ls_expression > " " THEN   
else
	return ""   // ESCE con nulla
end if

// Build string for Describe. Include a leading   
// quote to match the trailing quote that remains
ls_eval = "Evaluate(~"" + ls_expression + "~", " + String(a_row) + ")"   

ls_value = ads_1.Describe(ls_eval)

//--- se errore Torna nulla
if ls_value = "!" then return ""
		
return trim(ls_value)

end function

public function string u_dw_get_evaluate (ref datawindow adw_1, string a_field, string a_field_describe, long a_row);/*
   torna il valore calcolato da EXPRESSION
	inp: datastore: da cui estrarre il valore
	     field: nome campo
	     filed_describe: es. background.color
		  row: riga se però è una testata si può passare zero
*/
string ls_expression, ls_value, ls_eval
int k_pos


a_field = trim(a_field)

IF IsNumber(a_field) THEN   
	ls_expression = trim(adw_1.describe("#" + a_field + "." + a_field_describe))
else
	ls_expression = trim(adw_1.describe(a_field + "." + a_field_describe))
end if

IF ls_expression > " " THEN   
else
	return ""   // ESCE con nulla
end if

// Get the expression following the tab (~t) 
ls_expression = trim(Right(ls_expression, Len(ls_expression) - Pos(ls_expression, "~t")))

//--- se NON c'è una parentesi è poco probabile che sia una expression 
if Pos(ls_expression, "(") = 0 then return ""     // ESCE con nulla

//--- rimuove i doppi apici
k_pos = Pos(ls_expression, '~"', 1)
do while k_pos > 0 
	ls_expression = replace(ls_expression, k_pos, 1, "'")
	k_pos = Pos(ls_expression, '~"', k_pos)
loop
k_pos = Pos(ls_expression, "~~", 1)
do while k_pos > 0 
	ls_expression = replace(ls_expression, k_pos, 1, "")
	k_pos = Pos(ls_expression, "~~", k_pos)
loop

if left(ls_expression, 1) = "'" then
	ls_expression = trim(mid(ls_expression, 2))
end if
if mid(ls_expression, Len(ls_expression), 1) = "'" then
	ls_expression = left(ls_expression, Len(ls_expression) -1)
end if

IF ls_expression > " " THEN   
else
	return ""   // ESCE con nulla
end if

// Build string for Describe. Include a leading   
// quote to match the trailing quote that remains
ls_eval = "Evaluate(~"" + ls_expression + "~", " + String(a_row) + ")"   

adw_1.modify("DataWindow.NoUserPrompt='Yes'")
ls_value = adw_1.Describe(ls_eval)
adw_1.modify("DataWindow.NoUserPrompt='No'")

//--- se errore Torna nulla
if ls_value = "!" then return ""
		
return trim(ls_value)

end function

on kuf_utility.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_utility.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

