$PBExportHeader$kuf_utility.sru
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
public function int u_open_app_files (string a_file) throws uo_exception
public function integer u_stringa_split (ref string a_string[], string a_sep)
public function string u_url_sep_path_by_name (ref string a_url)
public function string u_url_encode (string a_url, boolean a_replace_puls_sign)
public subroutine u_proteggi_dw (character k_operazione, integer k_id_campo, ref uo_d_std_1 k_dw)
private subroutine old_u_dw_set_column_color (ref uo_d_std_1 k_dw)
private subroutine old_u_dw_set_column_color (ref datawindow k_dw)
public subroutine u_proteggi_dw (character k_operazione, string k_txt_campo, ref uo_d_std_1 k_dw)
public function string u_stringa_alfanum_spazio (string k_stringa)
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

on kuf_utility.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_utility.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

