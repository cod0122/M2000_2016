$PBExportHeader$kuf_data_base.sru
$PBExportComments$operazioni generiche sul DB (connect, commit ...)
forward
global type kuf_data_base from nonvisualobject
end type
end forward

global type kuf_data_base from nonvisualobject
end type
global kuf_data_base kuf_data_base

type prototypes

end prototypes

type variables

//--- file di configurazione 
constant string KKi_NOME_PROFILE_BASE = "confdb.ini"
constant string KKi_NOME_PROFILE_BASE_LOGIN = "confLogin.ini"
constant string KKi_NOME_PROFILE_BASE_USER = "confUser.ini"
constant string KKi_NOME_PROFILE_BASE_PRN = "confSta.ini"
constant string KKi_NOME_PROFILE_BASE_WIN = "confWin.ini"
constant string KKi_NOME_PROFILE_BASE_TOOLBAR = "confTool.ini"
constant string KKi_NOME_PROFILE_BASE_TREEVIEW = "confTrVw.ini"
constant string KKi_THEME = ".\themes\m2000_200430"
//
public constant string ki_profilestring_operazione_leggi = "1"
public constant string ki_profilestring_operazione_scrivi = "2"
public constant string ki_profilestring_operazione_inizializza = "3"
public constant string ki_profilestring_operazione_leggi_iniz = "4"


//--- per gestire il rientro in window da funzione esterna 
private string ki_window_funzione_open
private boolean ki_window_funzione_aggiornata

//--- Trace ATTIVA
public boolean ki_trace_attiva=false

//--- Variabili Globali
public string KI_barcode_modulo="A" //form di stampa del barcode (etichette del lotto/riferimento)
public boolean kI_toolbar_2_settata=false  //dopo il primo set e' messa a TRUE

//public w_super kiw_attiva //contiene la window 'attiva' in modo da fare ad esempio funzionare il toobar 


end variables

forward prototypes
public function string db_commit ()
public function string db_rollback ()
public function window prendi_win_prec ()
public function string errorlog_riempi_dw (ref datawindow kdw_1, integer k_riga, integer k_col)
public function window prendi_win_x_uguale_titolo (string k_titolo)
public function object u_getfocus_typeof ()
public function string prendi_path_corrente ()
public function window prendi_win_la_prima ()
public function window prendi_win_la_ultima ()
public function string u_getfocus_nome ()
public function integer dw_importfile (string k_argomenti, ref datawindow k_dw_import)
public function window prendi_win_next ()
public function window prendi_win_attiva ()
public function integer prendi_num_win_uguale (string k_nome_win)
public function datetime prendi_x_datins ()
public function datetime prendi_dataora ()
public function string prendi_path_corrente_da_registro ()
public function integer suona_motivo (string k_file_motivo, unsignedinteger k_flag)
public function string setta_path_default ()
public function string prendi_x_utente ()
public function st_esito db_commit_1 ()
public function st_esito db_rollback_1 ()
public function window prendi_win_uguale_handle (long k_handle)
public function boolean u_listview_scroll (listview klv_1, integer k_riga)
public function integer dw_saveas (string k_argomenti, readonly datawindow k_dw_save)
public function string prendi_win_attiva_titolo ()
public function integer dw_importfile_set_row (string k_argomenti, ref datawindow k_dw_import)
public subroutine mostra_windows_attiva ()
public function string dw_copia_attributi_generici (ref datastore k_ds_source, datawindow k_dw_target)
public function uo_d_std_1 u_getfocus_dw ()
public function integer errori_conta_righe (string k_path_nome_file)
public function long dw_setta_riga (string k_argomenti, ref datawindow k_dw)
public function integer dw_importfile (st_open_w kst_open_w, ref datawindow kdw_import)
public function window prendi_win_x_id_programma (string a_id_programma)
public subroutine u_toolbar_nascondi ()
public subroutine u_toolbar_mostra ()
public subroutine u_toolbar_programmi_avviso_allarme (boolean a_avviso_allarme)
private function integer u_toolbar_programmi (st_toolbar_programmi kst_toolbar_programmi, window k_window)
public function integer u_toolbar_programmi_aggiungi (window k_window)
public function integer u_toolbar_programmi_cancella (window k_window)
public function integer u_toolbar_programmi_attiva (window k_window)
public function integer u_dbg_trace_open (boolean a_attiva)
public function string get_e1_dateformat (date a_date)
public function string get_e1_timeformat (time a_time)
public function string get_e1_dateformat (datetime a_date)
public function string get_e1_timeformat (datetime a_time)
public subroutine set_focus (longlong a_handle)
public subroutine setfocus_handle (longlong k_handle)
public function date u_get_datefromjuliandate (string a_datajuliana)
public function string profilestring_ini (ref st_profilestring_ini kst_profilestring_ini)
public function integer stampa_dw (st_stampe kst_stampe)
public subroutine u_if_profile_base_exists () throws uo_exception
public function st_esito u_open_confdb_ini (integer k_tipo)
public function string get_nome_profile_base ()
public function boolean u_if_run_dev_mode ()
public function string u_change_nometab_xutente (string k_nome_tab) throws uo_exception
public subroutine u_set_ds_change_name_tab (ref datastore kds_1, string k_nome_tab) throws uo_exception
public function string u_get_nometab_xutente (string k_nome_tab_suffisso) throws uo_exception
private function string u_change_nometab_xutente_1 (string k_nome_tab, string k_id_utente) throws uo_exception
public function string u_change_nometab_xutente (string k_nome_tab, string k_id_utente) throws uo_exception
private subroutine u_set_ds_change_name_tab_1 (ref datawindow kdw_1, string k_nome_tab, string k_nome_tab_new) throws uo_exception
public subroutine u_set_ds_change_name_tab (ref datawindow kdw_1, string k_nome_tab) throws uo_exception
public subroutine u_set_ds_change_name_tab (ref datawindow kdw_1, string k_nome_tab, string k_id_utente) throws uo_exception
public subroutine u_dw_extend_col_to_edge (datawindow a_dw, string a_column)
public function long u_getlistselectedrow (datawindow kdw_1)
public function boolean u_theme_apply ()
public subroutine errori_scrivi_esito (string k_operazione, st_esito kst_esito)
public subroutine errori_scrivi_esito (st_esito kst_esito)
public function string profilestring_leggi_scrivi (string k_key, string k_key_1)
public function string profilestring_leggi_scrivi (string k_key, string k_key_1, string k_key_2)
public function string u_barcode_build (string a_barcode_init, integer a_n_barcode, ref string a_barcode[])
public function integer dw_salva_righe (string k_argomenti, readonly datastore kds_save, string k_titolo)
public function integer dw_salva_righe (string k_argomenti, readonly datawindow kdw_save, string k_titolo)
public function integer dw_salva_righe_reset (string k_argomenti, datawindow kdw_save, string k_titolo)
private function integer dw_salva_arg (string k_nome_file, string k_argomenti, long k_riga_posizione, string k_sort)
private function integer dw_salva_arg_0 (string k_argomenti, readonly datawindow kdw_save)
public function string dw_salva_arg_get_nome_file (string k_dw_dataobject, string k_titolo)
public function integer dw_ripri_righe (string k_argomenti, string k_titolo, ref datastore kds_import, ref datetime k_datetime_saved)
public function string profilestring_leggi_scrivi (readonly integer k_key, string k_key_1, string k_key_2)
public function integer dw_ripri_righe (string k_argomenti, string k_titolo, ref datawindow kdw_import, ref datetime k_datetime_saved)
public subroutine u_set_uo_sqlca_db_magazzino () throws uo_exception
public subroutine u_set_ds_change_name_tab_suff (ref datawindow kdw_1, string k_nome_tab, string k_nome_suff) throws uo_exception
public subroutine u_set_ds_change_name_tab_name (ref datawindow kdw_1, string k_nome_tab, string k_nome_new) throws uo_exception
public function string profilestring_crea_file (string k_path, string k_nome_file)
private function string profilestring_get_filename (ref st_profilestring_ini kst_profilestring_ini)
private function string profilestring_build_file (ref string a_path, string a_filename) throws uo_exception
end prototypes

public function string db_commit ();//---
//--- OBSOLETA:
//---	x compatibilità e riamasta questa funzione meglio chiamare direttamente la db_commit come sotto
//---
//---
//---	Ritorna 1 char : 0=OK; 1=errore non confermate operazioni sul DB
//---     da 2 char in poi descrizione errore 
//---
string k_return = "0"
st_esito kst_esito

kst_esito = kguo_sqlca_db_magazzino.db_commit( )

if kst_esito.esito <> kkg_esito.ok then
	k_return = "1" + kst_esito.esito + " " + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext)
end if

return k_return


end function

public function string db_rollback ();//---
//--- OBSOLETA:
//---	x compatibilità e riamasta questa funzione meglio chiamare direttamente la db_commit come sotto
//---
//---
//---	Ritorna 1 char : 0=OK; 1=errore non confermate operazioni sul DB
//---     da 2 char in poi descrizione errore 
//---
string k_return = "0"
st_esito kst_esito

kst_esito = kguo_sqlca_db_magazzino.db_rollback( )

if kst_esito.esito <> kkg_esito.ok then
	k_return = "1" + kst_esito.esito + " " + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext)
end if

return k_return


end function

public function window prendi_win_prec ();//
//=== Torna oggetto window, la window precedente a quella attiva
window k_return, k_window


	setnull(k_return)

	k_window = w_main.getfirstsheet()

	if isvalid(k_window) then
		
		k_return = k_window

		k_window = w_main.getnextsheet(k_window)
		
		if isvalid(k_window) then
			
			k_return = k_window
			
		end if
	end if


return k_return

end function

public function string errorlog_riempi_dw (ref datawindow kdw_1, integer k_riga, integer k_col);//===
//=== Legge ERRORLOG scritto da Infomrmix-4gl
//===
int k_file, k_rc 
int k_bytes, k_ctr, k_ctr_1, k_bytes_f, k_righe
string k_record, k_return = "1"
string k_path


//=== Clessidra di attesa
setpointer(hourglass!)

	k_path = profilestring_leggi_scrivi (ki_profilestring_operazione_leggi, "arch_4gi")

	k_file = fileopen( trim(k_path) + "\errorlog", linemode!, read!, lockreadwrite!)

	if k_file > 0 then
		
//=== Conto il nr. di Errori presenti		
		k_bytes = fileread(k_file, k_record) // legge una riga
		k_righe = 0
		k_ctr = 0
		do while k_bytes <> -100 
			k_bytes = fileread(k_file, k_record) // legge una riga
			
			k_righe++     //conta le righe 
		loop
		fileclose(k_file)


		if k_righe > 0 then 
			k_ctr_1=0
			k_file = fileopen( trim(k_path) + "\errorlog", linemode!, read!, lockreadwrite!)

			k_bytes = fileread(k_file, k_record) // legge una riga

//=== Se piu' di 1000 righe sono troppe
			if k_righe > 5000 then 

				k_ctr_1 = 5000
	
				k_ctr = k_righe
				do while k_ctr_1 < k_ctr // Posizionamento sull'ultimo errore (ultimi 4 rek?) 
					k_bytes = fileread(k_file, k_record) // legge una riga
					k_ctr = k_ctr - 1
				loop
			
			end if
		
			k_record = LeftA(k_record, k_bytes)
			k_rc = kdw_1.setitem (k_riga, k_col, trim(k_record) + "~n~r")

			do while k_bytes > 0 // Leggo le righe dell'errore 
					
				k_bytes = fileread(k_file, k_record) // legge una riga
				if k_bytes <= 0 then
					k_record = " "
				end if

				if LenA(trim(k_record)) > 0 then
					k_rc = kdw_1.setitem (k_riga, k_col, kdw_1.getitemstring (k_riga, k_col) + trim(k_record) + "~n~r")
				end if
				
			loop
			
			fileclose(k_file)

		end if

		k_return = "0"
	else
		k_return = "1"
		
		
	end if

							
return k_return


end function

public function window prendi_win_x_uguale_titolo (string k_titolo);//
//--- Torna oggetto Window uguale x TITOLO (obsolesto) o x ID_PROGRAMMA (consigliato!)
//---
//--- inpu: stringa con il ID_PROGRAMMA   o  il    TITOLO della Window (obsoleto!) 
//
w_super k_return, k_window
string k_sn = "X"


	setnull(k_return)

	k_window = w_main.getfirstsheet()

	if isvalid(k_window) <> false then
		
		if trim(k_window.title) = trim(k_titolo) then

			k_sn = "S"		
		else
			
			do while k_sn = "X"
	
				k_window = w_main.getnextsheet(k_window)
		
				if isvalid(k_window) <> false then
					if trim(k_window.title) = trim(k_titolo) then
						k_sn = "S"		
					end if
				else
					k_sn = "N"		
				end if
			loop
			
		end if
	else
		k_sn = "N"		
	end if

	if k_sn = "S" then		
		k_return = k_window
	else
		
//--- cerca X ID_PROGRAMMA		
		k_return = prendi_win_x_id_programma(trim(k_titolo))
	end if

return k_return

end function

public function object u_getfocus_typeof ();//
//=== Torna il tipo oggetto attivo
object k_typeof
//window kw_1
//
//
//kw_1 = prendi_win_attiva( )
//kw_1.event activate( )

GraphicObject k_which_control

k_which_control = GetFocus()

if isvalid(k_which_control) then

	k_typeof = TypeOf(k_which_control)
else
	setnull(k_typeof)

end if 

return k_typeof



end function

public function string prendi_path_corrente ();//
string k_return 

	
	k_return = trim(GetCurrentDirectory( ) )

  

return k_return




end function

public function window prendi_win_la_prima ();//
//=== Torna oggetto window, la prima window dopo la MDI
//w_g_tab k_window
window k_window

if isvalid(w_main) and not isnull(w_main) then
	k_window = w_main.GetFirstSheet()
	if isvalid(k_window) = false then
		setnull(k_window)
//	else
//		if k_window.title = "w_toolbar_programmi" then
//			setnull(k_window)
//		end if
	end if
end if

return k_window

end function

public function window prendi_win_la_ultima ();//
//=== Torna oggetto window, l'ultima window aperta nella MDI
//w_g_tab k_window, k_window1
window k_window, k_window1

	setnull(k_window)

	if isvalid(w_main) and not isnull(w_main) then
		k_window1 = w_main.GetFirstSheet()
		do while isvalid(k_window1)
			k_window = k_window1
			k_window1 = w_main.GetNextSheet(k_window) 
		loop 
	end if

return k_window

end function

public function string u_getfocus_nome ();//
//=== Torna nome oggetto attivo
string k_nome
//window kw_1
//
//
//kw_1 = prendi_win_attiva( )
//kw_1.event activate( )

GraphicObject k_which_control

k_which_control = GetFocus()

if isvalid(k_which_control) then

	k_nome = k_which_control.classname()
else
	k_nome = " "

end if 

return k_nome


end function

public function integer dw_importfile (string k_argomenti, ref datawindow k_dw_import);//
//--- FUNZIONE SOSPESA: PENSARE DI FARLA CON LE NUOVE FUNZIONI DEL DW


//=== Importa righe nel DW se gli argomenti passati nella dw_saveas sono rimasti uguali
//=== Input: 
//===   k_argomenti  argomenti della dw
//===   k_dw_import  data window su cui fare l'importa righe 
//=== Ritorna: 0 o < 0=Errore, >0=OK
long k_return=0
pointer kp



//---- Se in archivio BASE e' abilitato il flag SPEED_LISTE....
if kGuo_g.get_salva_liste()  then

//	kp=setpointer(hourglass!)

//	k_return = dw_ripri_righe(k_argomenti, k_dw_import)	
	
//	setpointer(kp)
	
end if


return k_return

end function

public function window prendi_win_next ();//
//=== Torna oggetto window, la window successiva a quella attiva
window k_return, k_window


	setnull(k_return)

	k_window = w_main.getnextsheet(k_window)
		
	if isvalid(k_window) then
			
		k_return = k_window
			
	end if


return k_return

end function

public function window prendi_win_attiva ();//
//=== Torna oggetto window, la window attiva
//w_g_tab k_window
window kwindow

	
	//k_window = w_main.getactivesheet()
	kwindow = kGuo_g.kgw_attiva
	if isvalid(kwindow) = false then
		setnull(kwindow)
	end if

return kwindow

end function

public function integer prendi_num_win_uguale (string k_nome_win);//
//=== Torna il numero di window trovatr aperte con lo stesso nome
string k_sn=" "
long k_handle=0
int k_ctr = 0
window kw_window



	kw_window = w_main.getfirstsheet()

	
	do while isvalid(kw_window)

		if upper(kw_window.ClassName( )) = upper(trim(k_nome_win)) then
			k_ctr ++
		end if
		kw_window = w_main.getnextsheet(kw_window)
		
	loop 


return k_ctr

end function

public function datetime prendi_x_datins ();//
//=== Torna data x campo standard x_datins
//



return prendi_dataora()

end function

public function datetime prendi_dataora ();//
//--- Torna data ora
//
datetime k_return
int k_anno
kuf_base kuf1_base



k_return = kguo_g.get_datetime_current( )   // get la data corrente dal DB SERVER

//--- Controllo se data congruente!!!!
if kguo_g.kg_anno_procedura > 0 then
	
	k_anno = year(date(k_return)) 
	if k_anno = kguo_g.kg_anno_procedura then
	else
		
		kuf1_base = create kuf_base

		kguo_g.set_anno_procedura(integer(mid(kuf1_base.prendi_dato_base("anno"),2)))
		
		if isvalid(kuf1_base) then destroy kuf1_base
		
	end if
	
	if k_anno = kguo_g.kg_anno_procedura then
	else
		
		if k_anno < kguo_g.kg_anno_procedura then
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ko)
			kguo_exception.setmessage("Data Errata" , "Attenzione la data rilevata dal tuo PC " + string(k_return) &
							 + " non è coincidente con l'anno " + string(kguo_g.kg_anno_procedura) + " indicato in Proprietà dell'Applicazione. " &
							 + kkg.acapo + "Entrare per la sola CONSULTAZIONE, si sconsiglano operazioni di inserimento e modifica dei dati")
			kguo_exception.messaggio_utente( )
		else
			if (k_anno + 1) = kguo_g.kg_anno_procedura then
			else
				kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ko)
				kguo_exception.setmessage("Data Errata" , "Attenzione la data rilevata dal tuo PC " + string(k_return) + " maggiore dell'anno di esercizio (" + string(kguo_g.kg_anno_procedura) + ") indicato in Proprietà Azienda. " &
											 + kkg.acapo + "Entrare per la sola CONSULTAZIONE, si sconsiglano operazioni di inserimento e modifica dei dati")
				kguo_exception.messaggio_utente( )
			end if
		end if
	end if
end if

return k_return

end function

public function string prendi_path_corrente_da_registro ();//
string k_return, k_file, k_ext 
int k_nrc
long k_pos



//--- Leggo dal registro di sistema il valore della PATH del CONFDB.INI
	k_nrc = RegistryGet( "HKEY_LOCAL_MACHINE" +  kkg.path_sep + "Software" + kkg.path_sep + "ATREBBI" +  kkg.path_sep + "M2000.Settings" + kkg.path_sep + "Confdb", &
	             "Path", RegString!, k_return)

	
	if LenA(trim(k_return)) > 0 then
//--- Verifico l'esisenza del file INI
		if not FileExists ( k_return ) then
			k_nrc = -1
		end if
	end if

//--- Chiave non trovata
	if k_nrc < 0 or LenA(trim(k_return)) > 0 then
		
		k_pos = Pos(kki_nome_profile_base,  kkg.path_sep, 1)
		if k_pos > 0 then
			k_file = Replace (kki_nome_profile_base, k_pos, 1, " ")
		end if
		k_file = trim(k_file)
		
		do 
		
			k_nrc = GetFileOpenName("Selezionare la cartella con il file di Configurazione", &
											k_return, k_file, "ini", &
											 k_file &
											+ "," + k_file + ",") 
								
			if k_nrc <= 0 then
				k_return = " "
			else
				
				k_file =  kkg.path_sep + trim(k_file)
				if upper(trim(k_file)) <> upper(trim(kki_nome_profile_base)) then
					k_return = " "
					k_nrc = -1
				else

//--- Scrivo sul registro di sistema il valore della PATH
					RegistrySet( "HKEY_LOCAL_MACHINE" + kkg.path_sep + "Software" + kkg.path_sep + "ATREBBI" + kkg.path_sep + "M2000.Settings" + kkg.path_sep + "Confdb", &
                            "Path", RegString!, k_return)
					
				end if
	
			end if
			
		loop while k_nrc < 0

	end if
  

return k_return




end function

public function integer suona_motivo (string k_file_motivo, unsignedinteger k_flag);////
////=== Suona il motivo richiesto
////
// 
////=== valori del flags (K_FLAG) possono essere (mmsystem.h) 
////#define SND_SYNC			0x0000  /* suona in modo sincrono (DEFAULT)
////#define SND_ASYNC			0x0001  /* suona in modo asincrono
////#define SND_NODEFAULT		0x0002  /* non usa il suono di default 
////#define SND_MEMORY			0x0004  /* lpszsound punta a memory file
////#define SND_LOOP			0x0008  /* in loop fino al prossimo sndplaysound
////#define SND_NOSTOP			0x0010  /* non si ferma mai
//
//string k_path_risorse
uint k_numdevs
int k_return=0

yield()
if kGuo_g.get_attiva_suoni() then
	
	k_numdevs = waveOutGetNumDevs()
	 
	if k_numdevs > 0 then
		if isnull(k_flag) then
			k_flag = 0
		end if
		
	//	k_path_risorse = trim(kGuf_data_base.profilestring_leggi_scrivi(1, "arch_graf"))
		
		sndPlaySoundA(trim(kGuo_path.get_risorse()) + "\" + trim(k_file_motivo), 0)
		
		k_return = 0
	else
		k_return = 1
	end if
end if

return k_return			

end function

public function string setta_path_default ();//
string k_app


	k_app = trim(kGuo_path.get_path_app())

	if k_app > " " then
		
		if DirectoryExists(k_app) then
			
			ChangeDirectory(k_app) 
			
		else
			messagebox("Cartella dell'Applicazione non Trovata",&
			           "Non è stato trovato il percorso dove risiedono i file di configurazione dell'applicazione." &
						  + "Cartella cercata:" + k_app, &
						  information!)
		end if
	else
		k_app = ""
		messagebox("Cartella dell'Applicazione non Trovata",&
			        "Nessun percorso di residenza dei file dell'applicazione trovato per l'accesso." &
						  + "Si possono verificare anomalie inaspettate, chiudere l'applicazione appena possibile.", &
						  stopsign!)
	end if

return k_app




end function

public function string prendi_x_utente ();//
//=== Torna Codice Utente x campo standard x_utente
//



return trim(string(kGuo_utente.get_pwd()))  

end function

public function st_esito db_commit_1 ();//---
//--- OBSOLETA:
//---	x compatibilità e riamasta questa funzione meglio chiamare direttamente la db_commit come sotto
//---

return kguo_sqlca_db_magazzino.db_commit( )




end function

public function st_esito db_rollback_1 ();//---
//--- OBSOLETA:
//---	x compatibilità e riamasta questa funzione meglio chiamare direttamente la db_commit come sotto
//---

return kguo_sqlca_db_magazzino.db_rollback( )


end function

public function window prendi_win_uguale_handle (long k_handle);//
//=== Torna oggetto window, la window precedente a quella attiva
window k_return, k_window
string k_sn = "X"


	setnull(k_return)

	k_window = w_main.getfirstsheet()

	if isvalid(k_window) <> false then
		
		if handle(k_window) = k_handle then

			k_sn = "S"		
		else
			
			do while k_sn = "X"
	
				k_window = w_main.getnextsheet(k_window)
		
				if isvalid(k_window) <> false then
					if handle(k_window) = k_handle then
						k_sn = "S"		
					end if
				else
					k_sn = "N"		
				end if
			loop
			
		end if
	else
		k_sn = "N"		
	end if

	if k_sn = "S" then		
		k_return = k_window
	else
		setnull(k_return)
	end if

return k_return

end function

public function boolean u_listview_scroll (listview klv_1, integer k_riga);//---
//--- Scroll di una Listview fino alla riga indicata
//--- ritorno: TRUE = ok; FALSE =KO
//---
long k_rc
boolean k_return
CONSTANT int k_LVM_FIRST = 4096
CONSTANT int k_LVM_ENSUREVISIBLE = k_LVM_FIRST  + 19

	if k_riga < 0 then k_riga = 1		
	if k_riga > klv_1.totalitems() then
		k_riga = klv_1.totalitems()
	end if
	if k_riga > 1 then k_riga -= 1      //--- posizionamento piu' in alto rispetto alla riga trovata
	k_rc = Send(Handle(klv_1), k_LVM_ENSUREVISIBLE ,k_riga,0)
	if k_rc < 0 or isnull(k_rc) then
		k_return = false
	else
		k_return = true
	end if

return k_return
end function

public function integer dw_saveas (string k_argomenti, readonly datawindow k_dw_save);//
//=== Salva i dati del DW e gli argomenti passati
//=== Input: 
//===   k_argomenti  argomenti della dw
//===   k_dw_save  data window
//=== Ritorna: 1=Errore, 0=OK
int k_return


	k_return = dw_salva_arg_0 (k_argomenti, k_dw_save)

return k_return

end function

public function string prendi_win_attiva_titolo ();//
//=== Torna oggetto window, la window attiva
//w_g_tab k_window
window k_window
string titolo = " "

	
//	k_window = w_main.getactivesheet()
	k_window = kGuo_g.kgw_attiva
	if isvalid(k_window)  then
		titolo = k_window.title
	end if

return titolo

end function

public function integer dw_importfile_set_row (string k_argomenti, ref datawindow k_dw_import);//
//=== SETTA la RIGA 
//=== nel DW se gli argomenti passati nella dw_saveas sono rimasti uguali
//=== Input: 
//===   k_argomenti  argomenti della dw
//===   k_dw_import  data window su cui fare l'importa righe 
//=== Ritorna: 0 o < 0=Errore, >0=OK
//
pointer kpointer
int k_file 
int k_bytes //, k_ctr
long k_return=0, k_riga_scroll
string k_path, k_nome_file, k_argomenti_sav,  k_argomenti_sav_chiave, k_sort
long k_argomenti_sav_setrow
string k_flag



kpointer = setpointer(hourglass!)


k_path = trim(profilestring_leggi_scrivi(ki_profilestring_operazione_leggi, "arch_saveas"))
//k_path = profilestring ( kGuo_path.get_procedura() + KK_NOME_PROFILE_BASE, "ambiente", "arch_saveas", "\at_com\saveas")

if isnull(k_dw_import.title) or LenA(trim(k_dw_import.title)) = 0 or trim(k_dw_import.title) = "none" then
	k_nome_file = trim(k_dw_import.dataobject) + "_1"
else
	k_nome_file = trim(k_dw_import.dataobject)+trim(k_dw_import.title)
end if

k_file = fileopen( trim(k_path) + "\" + k_nome_file + ".arg", linemode!, read!, lockreadwrite!)
if k_file < 1 then
	k_return = 0

else
	
	if isnull(k_argomenti) or k_argomenti = "" then
		k_argomenti = " "
	else
		k_argomenti = trim(k_argomenti)
	end if

	k_bytes = fileread(k_file, k_sort) //leggo SORT del dw salvati in prec

//=== Cerco il rek con gli argomenti uguali 
	k_bytes = fileread(k_file, k_argomenti_sav) //leggo argomenti del numero riga x setrow
	k_argomenti_sav_setrow = long(k_argomenti_sav)
		
	k_bytes = fileread(k_file, k_argomenti_sav) //leggo argomenti circa la CHIAVE di lettura
	k_argomenti_sav_chiave = (k_argomenti_sav)
	
	if isnull(k_argomenti_sav_chiave) or k_argomenti_sav_chiave = "" then
		k_argomenti_sav_chiave = " "
	end if
	
	do  while k_argomenti <> k_argomenti_sav_chiave and k_bytes > 0 
		k_bytes = fileread(k_file, k_argomenti_sav) //leggo argomenti del dw salvati in prec
		if k_bytes > 0 then
			k_argomenti_sav_chiave += "~h0D" +"~h0A" + k_argomenti_sav  //dovrebbe 0A=newLine; 0D=ret.Carr.
		end if
	loop
	k_argomenti_sav_chiave += "~h0D" +"~h0A" 

	if k_argomenti = k_argomenti_sav_chiave or k_argomenti = " " then
		if k_argomenti_sav_setrow > 1 and k_dw_import.rowcount() >= k_argomenti_sav_setrow then
			
			k_return = k_argomenti_sav_setrow
			
			k_dw_import.selectrow(0, false)
			k_dw_import.selectrow(k_argomenti_sav_setrow, true)
			if k_argomenti_sav_setrow > 5 then
				k_riga_scroll = k_argomenti_sav_setrow - 5
			else
				k_riga_scroll = 1
			end if
			k_dw_import.scrolltorow(k_riga_scroll)
			k_dw_import.setrow(k_argomenti_sav_setrow)
			
		end if

	else
		k_return = 0
	end if

	k_file = fileclose(k_file)
	
end if

setpointer(kpointer)


return k_return


end function

public subroutine mostra_windows_attiva ();//---
//--- Mostra la Windows Attiva
//---
w_g_tab w1_g_tab

w1_g_tab = this.prendi_win_attiva( )

if isvalid(w1_g_tab) then 
	w1_g_tab.show( )
	w1_g_tab.setfocus( )
	w1_g_tab.bringtotop = true
end if

	

end subroutine

public function string dw_copia_attributi_generici (ref datastore k_ds_source, datawindow k_dw_target);//---
//--- Copia da DS a DW gli attributi come il VISIBLE
//--- 
//---
//--- parametri di input:
//--- 
//---    k_ds_source  la ds sorgente
//---    k_dw_target  la dw in cui copiare
//---
//--- parametro di out: true=ok
//---
string k_return
string  k_rcx, k_string, k_nome 
int k_ciclo_ctr



//--- copia Proprieta' PRINT ORIENTATIONE della dw
	k_rcx=k_dw_target.modify("DataWindow.Print.Orientation= '" + trim(k_ds_source.describe("DataWindow.Print.Orientation")) + "'")

	k_string = k_string + k_rcx 		

//--- 
	k_ciclo_ctr = 1
	k_nome=k_dw_target.describe("#"+trim(string(k_ciclo_ctr))+".name")
	do while k_nome<>"!" // len(trim(ki_tab_nome_oggetto[k_ciclo_ctr, 1])) > 0  

		
//--- copia Proprieta' VISIBLE
		k_rcx=k_dw_target.modify(k_nome + ".Visible = " + k_ds_source.Describe(k_nome + ".Visible") + " " )

		k_string = k_string + k_rcx 		
		
		k_ciclo_ctr++
		k_nome=k_dw_target.describe("#"+trim(string(k_ciclo_ctr))+".name")

	loop


return  trim(k_string) 

end function

public function uo_d_std_1 u_getfocus_dw ();//
//=== Torna il tipo oggetto attivo
uo_d_std_1 k_typeof
//window kw_1
//
//
//kw_1 = prendi_win_attiva( )
//kw_1.event activate( )

GraphicObject k_which_control

k_which_control = GetFocus()

if isvalid(k_which_control) then

	if k_which_control.typeof( ) = DataWindow! then
		k_typeof = k_which_control
	else
		setnull(k_typeof)
	end if
else
	setnull(k_typeof)

end if 

return k_typeof



end function

public function integer errori_conta_righe (string k_path_nome_file);//=======================================================================================
//===
//=== Conta le righe su File di LOG
//===
//=== Input: 
//===   File			nome file (compreso di path) 
//===
//=== Ritorna: 	il numero di righe trovate
//===
//=== ESEMPIO:
//===			kst_esito_err.esito = kkg_esito.DB_KO
//===			kst_esito_err.sqlcode = sqlca.sqlcode
//===			kst_esito_err.sqlerrtext = trim(sqlca.sqlerrtext)
//===			kGuf_data_base.errori_conta_righe(k_nome_file) 
//===			
//=======================================================================================
//===			
int k_file 
int k_bytes, k_ctr, k_righe
string k_record



//=== Clessidra di attesa
setpointer(hourglass!)


	k_righe = 0

	k_file = fileopen( trim(k_path_nome_file), linemode!, read!, lockreadwrite!)

	if k_file > 0 then
		
//=== Conto il nr. di Errori presenti		
		k_bytes = fileread(k_file, k_record) // legge una riga
		k_ctr = 0
		do while k_bytes <> -100 

			k_righe++     //conta le righe 
			k_bytes = fileread(k_file, k_record) // legge una riga
			
		loop

		fileclose(k_file)
		
	end if

							
return k_righe



end function

public function long dw_setta_riga (string k_argomenti, ref datawindow k_dw);//
//=== Cerca la riga nel DW su cui ero settato nell'ultimo SAVE_DW se 
//=== gli argomenti passati nella dw_saveas sono rimasti uguali
//=== Input: 
//===   k_argomenti  argomenti della dw
//===   k_ds_import  data window su cui fare l'importa righe 
//===
//===
//=== Ritorna: la riga da SETTARE sul DW se c'è
//
int k_file 
int k_bytes //, k_ctr
long k_return=0
string k_path, k_nome_file, k_argomenti_sav,  k_argomenti_sav_chiave, k_sort, k_titolo
long k_argomenti_sav_setrow
kuf_utility kuf1_utility
pointer kp



	kp=setpointer(hourglass!)
	
	k_path = trim(profilestring_leggi_scrivi(ki_profilestring_operazione_leggi, "arch_saveas")) 
//	k_path = profilestring ( kGuo_path.get_procedura() + KK_NOME_PROFILE_BASE, "ambiente", "arch_saveas", "save_dw\")
	
	//k_len_name = len(dw_save.DataObject)
	//	k_nome_file = mid(k_ds_import.DataObject,4,7) + right(k_ds_import.DataObject,1)
	//	k_nome_file = trim(k_ds_import.DataObject)
	
	k_titolo = k_dw.title
	if isnull(k_titolo) or LenA(trim(k_titolo)) = 0 or trim(k_titolo) = "none" then
		k_nome_file = trim(k_dw.dataobject) + "_1"
	else
		k_nome_file = trim(k_dw.dataobject)+trim(k_titolo)
	end if

	kuf1_utility = create kuf_utility
	k_nome_file = kuf1_utility.u_stringa_cmpnovocali(k_nome_file)   // cmpatta il nome file 

	k_file = fileopen( trim(k_path) + "\" + k_nome_file + ".arg", linemode!, read!, lockreadwrite!)
	
	if k_file < 1 then
	
		k_return = 0
	
	else
	
		if isnull(k_argomenti) or k_argomenti = "" then
			k_argomenti = " "
		else
			k_argomenti = trim(k_argomenti)
		end if
	
		k_bytes = fileread(k_file, k_sort) //leggo SORT del dw salvati in prec
	
	//=== Cerco il rek con gli argomenti uguali 
		k_bytes = fileread(k_file, k_argomenti_sav) //leggo argomenti del numero riga x setrow
		k_argomenti_sav_setrow = long(trim(k_argomenti_sav))
			
		k_bytes = fileread(k_file, k_argomenti_sav) //leggo argomenti circa la CHIAVE di lettura
		k_argomenti_sav_chiave = (k_argomenti_sav)
		
		if isnull(k_argomenti_sav_chiave) or k_argomenti_sav_chiave = "" then
			k_argomenti_sav_chiave = " "
		end if
		
		do  while trim(k_argomenti) <> trim(k_argomenti_sav_chiave) and k_bytes > 0 
	
			k_bytes = fileread(k_file, k_argomenti_sav) //leggo argomenti del dw salvati in prec
			if k_bytes > 0 then
//				k_argomenti_sav_chiave += "~h0D" +"~h0A" + k_argomenti_sav  //dovrebbe 0A=newLine; 0D=ret.Carr.
				k_argomenti_sav_chiave += "~h0D" + k_argomenti_sav  //dovrebbe 0A=newLine; 0D=ret.Carr.
			end if
		loop
		if trim(k_argomenti) <> trim(k_argomenti_sav_chiave) then
			k_argomenti_sav_chiave += "~h0D" //+"~h0A" 
		end if
	
		if k_argomenti = k_argomenti_sav_chiave or k_argomenti = " " then

			if k_argomenti_sav_setrow > 0 then
				k_return = k_argomenti_sav_setrow   // nr riga su cui era posizionato (setrow())
			else
				k_return = 0
			end if
	
		else
			
			k_return = 0
			
		end if

	
		k_file = fileclose(k_file)
	end if	 
	
	setpointer(kp)
	


return k_return

end function

public function integer dw_importfile (st_open_w kst_open_w, ref datawindow kdw_import);//
//=== Importa righe nel DW se gli argomenti passati nella dw_saveas sono rimasti uguali
//=== Input: st_open_w  con keyN valorizzato 
//===  		 k_dw_import  data window su cui fare l'importa righe 
//=== Ritorna: 0 o < 0=Errore, >0=OK
long k_return=0
string k_key=""



//---- Se in archivio BASE e' abilitato il flag SPEED_LISTE....
if kGuo_g.get_salva_liste()  then

		k_key = trim(kst_open_w.key1)+trim(kst_open_w.key2)+trim(kst_open_w.key3) &
	      		  +trim(kst_open_w.key4)+trim(kst_open_w.key5)+trim(kst_open_w.key6) &
		  		  +trim(kst_open_w.key7)+trim(kst_open_w.key8)+trim(kst_open_w.key9)
		
		k_return = kGuf_data_base.dw_importfile(trim(k_key), kdw_import)
	
end if


return k_return

end function

public function window prendi_win_x_id_programma (string a_id_programma);//
//--- Torna oggetto Window uguale x ID_PROGRAMMA (consigliato!) quella x TITOLO è OBSOLETA!!!!!!!!!!!
//---
//--- inpu: stringa con il ID_PROGRAMMA  
//
w_super k_return, k_window
string k_sn = "X"


	setnull(k_return)

	k_window = w_main.getfirstsheet()

	if isvalid(k_window) <> false then
		
		if k_window.get_id_programma() = trim(a_id_programma)then

			k_sn = "S"		
		else
			
			do while k_sn = "X"
	
				k_window = w_main.getnextsheet(k_window)
		
				if isvalid(k_window) <> false then
					if trim(k_window.get_id_programma( ) ) = trim(a_id_programma) then
						k_sn = "S"		
					end if
				else
					k_sn = "N"		
				end if
			loop
			
		end if
	else
		k_sn = "N"		
	end if

	if k_sn = "S" then		
		k_return = k_window
	else
		setnull(k_return)
	end if

return k_return

end function

public subroutine u_toolbar_nascondi ();//---
//--- chiama la funzione per nascondere la toolbar dei programmi aperti
//---
//---

#if defined PBNATIVE then
if kguo_g.if_w_toolbar_programmi( ) then  //la gestione della vecchia toolbar finta è attiva?
	w_toolbar_programmi.visible = false
end if
#end if




end subroutine

public subroutine u_toolbar_mostra ();//---
//--- chiama la funzione per nascondere la toolbar dei programmi aperti
//---

#if defined PBNATIVE then
if kguo_g.if_w_toolbar_programmi( ) then  //la gestione della vecchia toolbar finta è attiva?
	w_toolbar_programmi.visible = true
end if
#end if



end subroutine

public subroutine u_toolbar_programmi_avviso_allarme (boolean a_avviso_allarme);//---
//--- Imposta l'avviso di ALLERT sulla toolbar dei programmi 
//---
w_toolbar_programmi.toolbar_programmi.kist_toolbar_programmi.posizione_tab = 0

if kguo_g.if_w_toolbar_programmi( ) then

	if isvalid(w_toolbar_programmi) then
		w_toolbar_programmi.set_p_memo(a_avviso_allarme)
	end if

end if



end subroutine

private function integer u_toolbar_programmi (st_toolbar_programmi kst_toolbar_programmi, window k_window);//---
//--- chiama la funzione per aggiungere una voce alla toolbar dei programmi aperti
//---
//--- torna la Posizione della Voce nei tabulatori (0=not ok)
//---


	w_toolbar_programmi.toolbar_programmi.kist_toolbar_programmi.posizione_tab = 0

	if isvalid(k_window) then
	else
		k_window = prendi_win_attiva()  //altrimenti piglia la prima attiva
	end if
	if isnull(k_window) then
		w_toolbar_programmi.toolbar_programmi.kist_toolbar_programmi.titolo = "APP.NON RICONOSCIUTA"
		w_toolbar_programmi.toolbar_programmi.kist_toolbar_programmi.handle = 0
	else
		w_toolbar_programmi.toolbar_programmi.kist_toolbar_programmi.titolo = k_window.title
		w_toolbar_programmi.toolbar_programmi.kist_toolbar_programmi.handle = handle(k_window)
	end if
	if w_toolbar_programmi.toolbar_programmi.kist_toolbar_programmi.handle > 0 then
		choose case true
			case kst_toolbar_programmi.metodo_aggiungi_voce		
				w_toolbar_programmi.toolbar_programmi.aggiungi_voce()
			case kst_toolbar_programmi.metodo_cancella_voce		
				w_toolbar_programmi.toolbar_programmi.cancella_voce()
			case kst_toolbar_programmi.metodo_attiva_voce		
				w_toolbar_programmi.toolbar_programmi.attiva_voce()
		end choose
	end if



return w_toolbar_programmi.toolbar_programmi.kist_toolbar_programmi.posizione_tab



end function

public function integer u_toolbar_programmi_aggiungi (window k_window);//---
//--- chiama la funzione per aggiungere una voce alla toolbar dei programmi aperti
//---
//--- torna la Posizione della Voce nei tabulatori (0=not ok)
//---
int k_return=1

#if defined PBNATIVE then

if kguo_g.if_w_toolbar_programmi( ) then
	st_toolbar_programmi kst_toolbar_programmi
	
	kst_toolbar_programmi.metodo_aggiungi_voce = true
	
	k_return = u_toolbar_programmi(kst_toolbar_programmi, k_window)
end if
#end if

return k_return



end function

public function integer u_toolbar_programmi_cancella (window k_window);//---
//--- chiama la funzione per Cancellare una voce alla toolbar dei programmi aperti
//---
//--- torna la Posizione della Voce cancellata nei tabulatori (0=not ok)
//---
int k_return=1

#if defined PBNATIVE then

if kguo_g.if_w_toolbar_programmi( ) then
	st_toolbar_programmi kst_toolbar_programmi
	
	kst_toolbar_programmi.metodo_cancella_voce = true
	
	k_return = u_toolbar_programmi(kst_toolbar_programmi, k_window)
end if
#end if

return k_return



end function

public function integer u_toolbar_programmi_attiva (window k_window);//---
//--- chiama la funzione per ATTIVARE una voce nella toolbar dei programmi aperti
//---
//--- torna la Posizione della Voce cancellata nei tabulatori (0=not ok)
//---
int k_return

#if defined PBNATIVE then

if kguo_g.if_w_toolbar_programmi( ) then
	st_toolbar_programmi kst_toolbar_programmi
	
	kst_toolbar_programmi.metodo_attiva_voce = true
	
	k_return = u_toolbar_programmi(kst_toolbar_programmi, k_window)
end if
#end if

return k_return



end function

public function integer u_dbg_trace_open (boolean a_attiva);//
int k_return = 0
errorreturn k_rcx
TimerKind ltk_kind
//CHOOSE 	CASE text
//	CASE "None"    
//		ltk_kind = TimerNone!
//	CASE "Clock" 
ltk_kind = Clock!
//	CASE "Process"   
//ltk_kind = Process!
//	CASE "Thread"      ltk_kind = Thread!
//END CHOOSE

if a_attiva = ki_trace_attiva then
else
	
	if ki_trace_attiva then
		TraceEnd()
		TraceClose()
		k_return = 2 // CHIUSA
	else
	
		k_rcx = TraceOpen(kguo_path.get_base( ) + "\m2000.trace.pbp",ltk_kind)
		
		if k_rcx = Success!  then 
			// Enable trace activities. Enabling ActLine!
			// enables ActRoutine! implicitly
			TraceEnableActivity(ActESQL!)
			TraceEnableActivity(ActUser!)
			TraceEnableActivity(ActError!)
			TraceEnableActivity(ActLine!)
			TraceEnableActivity(ActObjectCreate!)
			TraceEnableActivity(ActObjectDestroy!)
			TraceEnableActivity(ActGarbageCollect!)
			
			k_rcx = TraceBegin("Trace_M2000")
			
			if k_rcx <> FileNotOpenError! then 
				ki_trace_attiva=true
				k_return = 1 // APERTA
			end if
		end if		
	end if		
end if

return k_return

end function

public function string get_e1_dateformat (date a_date);//
//=== Torna data nel formato richiesto da E1
//


return string(a_date, "mmddyyyy")

end function

public function string get_e1_timeformat (time a_time);//
//=== Torna time nel formato richiesto da E1
//


return string(a_time, "hhmmss")

end function

public function string get_e1_dateformat (datetime a_date);//
//=== Torna data nel formato richiesto da E1
//


return string(a_date, "mmddyyyy")

end function

public function string get_e1_timeformat (datetime a_time);//
//=== Torna time nel formato richiesto da E1
//


return string(a_time, "hhmmss")

end function

public subroutine set_focus (longlong a_handle);//
//=== Setta il Focus, utile per dare il fuoco da Windows a un oggetto PB
//

//SetFocus(a_handle)  // This function gets the handle from PB. 


end subroutine

public subroutine setfocus_handle (longlong k_handle);//
//=== Attiva Window conoscendo l'handle
//
window kw_window


	kw_window = w_main.getfirstsheet()

	if isvalid(kw_window) then
		
		do while k_handle <> handle(kw_window)  

			kw_window = w_main.getnextsheet(kw_window)
			if not isvalid(kw_window) then
				exit
			end if

		loop 

		if k_handle = handle(kw_window) and isvalid(kw_window) then
			kw_window.setfocus()
		end if
	end if



end subroutine

public function date u_get_datefromjuliandate (string a_datajuliana);//
//=== Torna date dal formato data Juliano:  1 secolo + anno + nr giorno dell'anno
//
date k_return = date(0)
string k_datajx
int k_secolo
int k_anno
int k_gg

k_datajx = trim(a_datajuliana)
if len(k_datajx) = 6 and isnumber(k_datajx)then
	k_secolo = integer(left(k_datajx,1)) - 1  // secolo 1 = 2000, 2=2100, 3=2200 ....
	k_anno = 2000 + 100 * k_secolo + integer(mid(k_datajx,2,2))
	k_gg = integer(mid(k_datajx,4,3)) - 1

	k_return = relativedate(date(k_anno, 01, 01), k_gg)
end if

return k_return

end function

public function string profilestring_ini (ref st_profilestring_ini kst_profilestring_ini);//---
//---
//--- Legge e Scrive archivio .ini 
//---
//--- Inp/Out: st_profilestring_ini
//---					utente     	= utente di login (x defautl è il codice_utente di lavoro)
//---					file    		= nome logico del file (indicare solo se non è standard) 
//---					titolo   	= label nel file ini (x default imposta = "ambiente")
//---					nome    		= nome del campo che contiene il valore
//---					valore     	= valore di lettura/scrittura 
//---             operazione 	= 	ki_profilestring_operazione_leggi (1)  		x leggere il valore è il default se valore non indicato
//---										ki_profilestring_operazione_scrivi (2)			x scrivere il valore è il default se valore Indicato (aggiunge a quello vecchio)
//---										ki_profilestring_operazione_inizializza (3)	x inizializzare a " " 
//---										ki_profilestring_operazione_leggi_iniz (4)	x legge il valore e se manca lo inizializzare a VALORE indicato 
//---             esito   	 	= torna 0 = OK, W=ok ma nessun valore, 1=ERRORE GRAVE, 2=non autorizzato all'accesso al file 
//---
//---  Ret: Torna descrizione dell'errore
//---
string k_return = ""   
string k_key_3
int k_rc
string k_valore_iniz

	
try
	kguo_exception.inizializza(this.classname())

	kst_profilestring_ini.esito = "0"
		
//--- Imposta i valori di default come se manca il nome file allora lo sostituisco con il nome titolo 	
	if trim(kst_profilestring_ini.titolo) > " " then
	else
		kst_profilestring_ini.titolo = "ambiente"
	end if
	if trim(kst_profilestring_ini.operazione) > " " then
	else
		if trim(kst_profilestring_ini.valore) > " " then
			kst_profilestring_ini.operazione = ki_profilestring_operazione_scrivi 
		else
			kst_profilestring_ini.operazione = ki_profilestring_operazione_leggi 
		end if
	end if
	if trim(kst_profilestring_ini.file) > " " then
	else
		kst_profilestring_ini.file = kst_profilestring_ini.titolo
	end if

	if kst_profilestring_ini.operazione = ki_profilestring_operazione_inizializza then
		k_valore_iniz = ""
	else				
		k_valore_iniz = trim(kst_profilestring_ini.valore)
	end if

//--- imposta e verifica il nome del file
	profilestring_get_filename(kst_profilestring_ini)	

//--- se tutto ok
	if kst_profilestring_ini.esito = "0" then

		if kst_profilestring_ini.operazione = ki_profilestring_operazione_leggi &
		         or kst_profilestring_ini.operazione = ki_profilestring_operazione_leggi_iniz then 
			k_RETURN = trim(profilestring &
													( kst_profilestring_ini.path &
													  + kst_profilestring_ini.nome_file, &
													  trim(kst_profilestring_ini.titolo), & 
													  trim(kst_profilestring_ini.nome), &
													  "nullo"))
			if k_return = "" or k_return = "nullo" then
				kst_profilestring_ini.esito = "W"
				kst_profilestring_ini.valore = " "
				k_return = "Nessun Valore trovato in lettura archivio di Configurazione Base: " + kkg.acapo &
					  + kst_profilestring_ini.path+kst_profilestring_ini.nome_file 
			else
				kst_profilestring_ini.valore = k_return
				// se avevo chiesto la inizializz ma tutto ok allora la EVITO
		      if kst_profilestring_ini.operazione = ki_profilestring_operazione_leggi_iniz then 
					kst_profilestring_ini.operazione = ki_profilestring_operazione_leggi
				end if
			end if
		end if

		if kst_profilestring_ini.operazione = ki_profilestring_operazione_scrivi & 
					or lower(k_return) = "nullo" then
			k_rc = SetProfileString &
													( kst_profilestring_ini.path &
													  + kst_profilestring_ini.nome_file, &
													  trim(kst_profilestring_ini.titolo), & 
													  trim(kst_profilestring_ini.nome), &
													  trim(kst_profilestring_ini.valore) ) 
			if k_rc = -1 then
				kst_profilestring_ini.esito = "2"
				k_return = "Accesso in scrittura in archivio di Configurazione FALLITO: " + kkg.acapo &
					  + kst_profilestring_ini.path+kst_profilestring_ini.nome_file + ": " + kkg.acapo &
					  +	 "Etichetta: [" +  trim(kst_profilestring_ini.titolo) + "] " & 
					  +	 "campo: '" + trim(kst_profilestring_ini.nome) + "' " &
					  + "valore: '" + trim(kst_profilestring_ini.valore) + "' " 
				kguo_exception.kist_esito.sqlerrtext = k_return
				kguo_exception.kist_esito.esito = kkg_esito.ko
				throw kguo_exception		
			end if
													  
		end if

		if kst_profilestring_ini.operazione = ki_profilestring_operazione_inizializza & 
		         or kst_profilestring_ini.operazione = ki_profilestring_operazione_leggi_iniz then 

			k_rc = SetProfileString &
													( kst_profilestring_ini.path &
													  + kst_profilestring_ini.nome_file, &
													  trim(kst_profilestring_ini.titolo), & 
													  trim(kst_profilestring_ini.nome), &
													  k_valore_iniz ) 
			if k_rc = -1 then
				kst_profilestring_ini.esito = "2"
				k_return = "Accesso archivio di Configurazione per inizializzazione FALLITO: " + kkg.acapo &
					  + kst_profilestring_ini.path+kst_profilestring_ini.nome_file 
				kguo_exception.kist_esito.sqlerrtext = k_return
				kguo_exception.kist_esito.esito = kkg_esito.ko
				throw kguo_exception		
			end if
		end if											  


	end if	

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	
end try

return k_return



end function

public function integer stampa_dw (st_stampe kst_stampe);//
//--- Inp: la struttura st_stampe
//--- Rit: 0 = OK,  1 = ERRORE
//
int k_return = 0
int k_file, k_rcn=0 
int k_bytes, k_pos_start
string k_path
string k_nome_file, k_riga, k_argomenti, k_file_completo
st_open_w kst_open_w
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
kuf_menu_window kuf1_menu_window
kuf_utility kuf1_utility
kuf_file_explorer kuf1_file_explorer


//=== Puntatore Cursore da attesa.....
//oldpointer = SetPointer(HourGlass!)

	kst_esito = kguo_exception.inizializza(this.classname())

	kuf1_utility = create kuf_utility
	kuf1_file_explorer = create kuf_file_explorer

//--- SALVO I DATI DEL DW (o DS) CON I PARAMETRI DI ENTRATA --------------------------------------------------------------------------------------------------
	k_path = trim(profilestring_leggi_scrivi(ki_profilestring_operazione_leggi, "arch_saveas")) 
	//k_path = trim(profilestring ( kGuo_path.get_procedura() + kkg.path_sep + "confdb.ini", "ambiente", "arch_saveas", "save_dw"))

	if right(k_path, 1) <> "\" and right(k_path, 1) <> "/" then k_path += kkg.path_sep
		
//--- Crea il path, se non esiste
	if len(k_path) > 0 then
		kuf1_file_explorer.u_directory_create(k_path)
	end if
		 
	if trim(kst_stampe.DataObject) > " " then
	else
		if (kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_dw_diretta or kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datawindow &
		                        or kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_dw_rtf) &
						and isvalid(kst_stampe.dw_print) then
			kst_stampe.DataObject = kst_stampe.dw_print.dataobject
		else
			if (kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta or kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore &
			                 or kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta_BATCH or kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_pdf_BATCH) &
						and isvalid(kst_stampe.ds_print) then
				kst_stampe.DataObject = kst_stampe.ds_print.dataobject
			end if
		end if
	end if
		
	k_nome_file = trim(kst_stampe.DataObject)
	k_nome_file = kuf1_utility.u_stringa_cmpnovocali(k_nome_file)   // cmpatta il nome file 

	k_file = fileopen( trim(k_path) + k_nome_file + ".arg", linemode!, write!, lockreadwrite!,replace!)

	if k_file < 1 then
		
		kst_esito.sqlerrtext ="Errore in lettura file ~n~r" + trim(k_path) + k_nome_file + ".arg"
		kst_esito.sqlcode = k_file
		kGuo_exception.set_esito (kst_esito)

		k_return = 1

	else

//--- se tipo non indicato, imposto il default....
		if kst_stampe.tipo > " " then
		else
			kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datawindow
		end if
		
//--- Aggiungo agli argomenti la riga su cui ero posizionato 			
		if kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_dw_diretta or kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datawindow &
		                        or kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_dw_rtf then
			if isvalid(kst_stampe.dw_print) then
				k_riga = string(kst_stampe.dw_print.getrow(), "0000000000")
			else
				k_riga = "0000000000"
			end if
		else
			if kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta or kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore &
			                 or kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta_BATCH or kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_pdf_BATCH then
				if isvalid(kst_stampe.ds_print) then
					k_riga = string(kst_stampe.ds_print.getrow(), "0000000000")
				else
					k_riga = "0000000000"
				end if
			end if
		end if
		if isnull(k_riga) then
			k_riga = "0000000000"
		end if
		k_argomenti = k_riga + "stampa" 

		k_bytes = filewrite(k_file, trim(k_argomenti)) //Riscrivo il vecchio fle

		if k_bytes < 1 then
			k_return = 1
			
			kst_esito.sqlerrtext ="Errore in scrittura file (argomenti)~n~r" + trim(k_path) + k_nome_file + ".arg"
			kst_esito.sqlcode = k_bytes
			kGuo_exception.set_esito (kst_esito)

		else
			k_file_completo = trim(k_path) + k_nome_file + ".txt"

			if kst_stampe.tipo <> kuf_stampe.ki_stampa_tipo_datastore and kst_stampe.tipo <> kuf_stampe.ki_stampa_tipo_datastore_diretta &
			           and kst_stampe.tipo <> kuf_stampe.ki_stampa_tipo_datastore_diretta_BATCH and kst_stampe.tipo <> kuf_stampe.ki_stampa_tipo_datastore_pdf_BATCH then
				
				if isvalid(kst_stampe.dw_print) then
					k_rcn = kst_stampe.dw_print.saveas(k_file_completo, text!, false) 
					if k_rcn < 0 then
						k_return = 1
					end if
				end if
			else
				if isvalid(kst_stampe.ds_print) then
					k_rcn = kst_stampe.ds_print.saveas(k_file_completo, text!, false)
					if k_rcn < 0 then
						k_return = 1
					end if
				end if
			end if
				
			if k_return = 1 then
				kst_esito.sqlerrtext ="Errore in scrittura file ~n~r" + k_file_completo
				kst_esito.sqlcode = k_rcn
				kGuo_exception.set_esito (kst_esito)
			end if
			
		end if

		k_file = fileclose(k_file)

	end if
//--- FINE: SALVO I DATI DEL DW (o DS) CON I PARAMETRI DI ENTRATA --------------------------------------------------------------------------------------------------



//--- S=possibilità di scegliere da pag. a pag.
	if trim(kst_stampe.scegli_pagina) > " " then
	else
		kst_stampe.scegli_pagina = "S"
	end if
//--- titolo stampa
	if trim(kst_stampe.titolo) > " " then
		kst_stampe.titolo = trim(kst_stampe.titolo) //+ ",    u: " + lower(trim (kGuo_utente.get_nome()))
	else
		kst_stampe.titolo = "" //"Stampa per l'utente: " + lower(trim (kGuo_utente.get_nome())) + " "
	end if
//--- Nome del DW
	if trim(kst_stampe.dataobject) > " " then
	else
		if kst_stampe.tipo <> kuf_stampe.ki_stampa_tipo_datastore &
				and kst_stampe.tipo <> kuf_stampe.ki_stampa_tipo_datastore_diretta &
				and kst_stampe.tipo <> kuf_stampe.ki_stampa_tipo_datastore_diretta_BATCH &
				and kst_stampe.tipo <> kuf_stampe.ki_stampa_tipo_datastore_pdf_BATCH then
			kst_stampe.dataobject = kst_stampe.dw_print.dataobject
		else
			kst_stampe.dataobject = kst_stampe.ds_print.dataobject
		end if
	end if
//--- Stampante predefinita
	if trim(kst_stampe.stampante_predefinita) > " " then
	else
		kst_stampe.stampante_predefinita = ""
	end if

	if kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta_BATCH &
			or kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_pdf_BATCH then
		kst_stampe.ds_print.modify("Print.documentname = '"+kst_stampe.titolo+"'")
		if kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta_BATCH then
			if kst_stampe.ds_print.print() < 0 then
				k_return = 1			
			end if
		else
			if kst_stampe.pathfile > " " then
				kst_stampe.ds_print.object.DataWindow.Export.PDF.Method = NativePDF!
				if kst_stampe.ds_print.saveas(kst_stampe.pathfile, PDF!, false) < 0 then
					k_return = 1			
				end if
			end if
		end if

		if k_return = 0 then
			if kst_stampe.pathfile > " " and kst_stampe.ask_if_open then
				if messagebox("Operazione terminata correttamente",  "Vuoi aprire subito il file " + kkg.acapo + trim(k_file_completo), Question!, yesno!, 1) = 1 then
					SetPointer(kkg.pointer_attesa)
					kuf1_file_explorer.of_execute(kst_stampe.pathfile)
				end if
			end if
		end if
		
	else

//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
		Kst_open_w.id_programma = kkg_id_programma.stampa
		Kst_open_w.flag_primo_giro = "S"
		Kst_open_w.flag_modalita = kkg_flag_modalita.stampa
		Kst_open_w.flag_adatta_win = KKG.ADATTA_WIN_NO
		Kst_open_w.flag_leggi_dw = "N"
		kst_open_w.key12_any = kst_stampe   // dati da stampare
		kst_open_w.flag_where = " "
		
			
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window
	end if
	
	
	if isvalid(kuf1_utility) then destroy kuf1_utility
	if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
				
return k_return


end function

public subroutine u_if_profile_base_exists () throws uo_exception;//---
//--- Verifica l'esistenza del file di configurazione di base (confdb.ini)
//---
//--- se assente lancia un uo_exception
//---
string k_file 


k_file = kGuo_path.get_path_app() + KKG.PATH_SEP + KKi_NOME_PROFILE_BASE
if not FileExists (k_file) then
	kguo_exception.inizializza( )
	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_not_fnd )
	kguo_exception.setmessage( "Configurazione Assente", "Non è stato trovato il file di configurazione del programma: " + k_file)
end if


end subroutine

public function st_esito u_open_confdb_ini (integer k_tipo);//===
//=== Legge Errori di M2000
//===
//
string k_file 
st_esito kst_esito
kuf_ole kuf1_ole


//=== Clessidra di attesa
	setpointer(kkg.pointer_attesa)

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""


	k_file = trim(kguo_path.get_path_app( ) + kkg.path_sep + KKI_NOME_PROFILE_BASE)

	if len(trim(k_file)) > 0 then 
	
		kuf1_ole = create kuf_ole
		kst_esito = kuf1_ole.open_txt( k_file )
		if kst_esito.esito <> "0" then
			kst_esito = kuf1_ole.open_doc( k_file )
		end if
		destroy kuf1_ole
			
	end if		
	
	if kst_esito.esito <> kkg_esito.ok then

		kst_esito.sqlerrtext = trim(kst_esito.sqlerrtext) + "~n~r" + "File:" + trim(k_file)
		
	end if		
	
	setpointer(kkg.pointer_default)
							
return kst_esito


end function

public function string get_nome_profile_base ();//---
//--- Verifica l'esistenza del file di configurazione di base (confdb.ini)
//---
//--- out: path + nome file base 
//---
string k_return 


k_return = kGuo_path.get_path_app() + KKG.PATH_SEP + KKi_NOME_PROFILE_BASE
if isnull(k_return) then 
	k_return = ""
end if

return k_return

end function

public function boolean u_if_run_dev_mode ();//---
//--- Verifica se sta girando in dev mode (da IDE) o nomale
//---
if Handle(GetApplication()) = 0 then
	return true
else
	return false
end if


end function

public function string u_change_nometab_xutente (string k_nome_tab) throws uo_exception;//
//--------------------------------------------------------------------------------------
//--- Cambia il nome della tabella da utente standard a utente vero
//--- es.  vx_MAST_tabella_esempio ---> vx_0037_tabella_esempio
//---     vx_ = prefisso del nome tabella quasi sempre fisso così
//---     MAST = parte da cambiare x utente 37 
//---     _nomeTabella = suffisso del nome tabella
//--- Inp: nome tab completa ex "vx_MAST_nomeTabella"
//--------------------------------------------------------------------------------------
//
//
string k_return


	k_return = u_change_nometab_xutente_1(k_nome_tab, string(kguo_utente.get_id_utente( )) )

		
return k_return 	

end function

public subroutine u_set_ds_change_name_tab (ref datastore kds_1, string k_nome_tab) throws uo_exception;//
//--------------------------------------------------------------------------------------
//--- Cambia il nome della tabella nel ds come da standard
//--- es.  vx_MAST_tabella_esempio ---> vx_0001_tabella_esempio
//---     vx_ = prefisso del nome tabella quasi sempre fisso così
//---     MAST = parte da cambiare
//---     _nomeTabella = suffisso del nome tabella
//--- Inp: datastore, nome tab completa es "vx_MAST_nomeTabella"
//--------------------------------------------------------------------------------------
//
//
long k_rc, k_ctr
string k_sql_orig, k_string, k_stringn
	
	try

		k_stringn = u_change_nometab_xutente(k_nome_tab)  // get del nuovo nome tab x utente 
		k_string = k_nome_tab

		k_sql_orig = kds_1.Object.DataWindow.Table.Select 
		k_ctr = Pos(k_sql_orig, k_string, 1)
		DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
			k_sql_orig = Replace(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
			k_ctr = Pos(k_sql_orig, k_string, k_ctr+LenA(k_string))
		LOOP
		kds_1.Object.DataWindow.Table.Select = k_sql_orig
		
		k_sql_orig = kds_1.Object.DataWindow.Table.update
		if k_sql_orig <> "?" then
			k_ctr = Pos(k_sql_orig, k_string, 1)
			if k_ctr > 0 then
				k_sql_orig = Replace(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
				kds_1.Object.DataWindow.Table.update = k_sql_orig	
			end if
		end if
	
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		
	

end subroutine

public function string u_get_nometab_xutente (string k_nome_tab_suffisso) throws uo_exception;//
//--------------------------------------------------------------------------------------
//--- Torna il nome della tabella/view standard personalizzata utente 
//--- es.  vx_0037_tabella_esempio
//---     vx_ = prefisso del nome tabella standard
//---     0037 = x utente 37 
//---     _tabella_esempio = suffisso del nome tabella
//--- Inp: nome tab suffisso della tabella es: "tabella_esempio"
//--------------------------------------------------------------------------------------
//
//
string k_return
	
	try

		if trim(k_nome_tab_suffisso) > " " then
			k_return =  "vx_"  + string(kguo_utente.get_id_utente( )) + "_" + trim(k_nome_tab_suffisso)
		else
			kguo_exception.inizializza( )
			kguo_exception.kist_esito.nome_oggetto = this.classname( )
			kguo_exception.kist_esito.esito = kguo_exception.KK_st_uo_exception_tipo_internal_bug
			kguo_exception.kist_esito.sqlerrtext = "Fallita composizione nome tabella utente, manca il nome suffisso"
			throw kguo_exception
		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		
return k_return 	

end function

private function string u_change_nometab_xutente_1 (string k_nome_tab, string k_id_utente) throws uo_exception;//
//--------------------------------------------------------------------------------------
//--- Cambia il nome della tabella da utente standard a utente vero
//--- es.  vx_MAST_tabella_esempio ---> vx_0037_tabella_esempio
//---     vx_ = prefisso del nome tabella quasi sempre fisso così
//---     MAST = parte da cambiare x utente 37 
//---     _nomeTabella = suffisso del nome tabella
//--- Inp: nome tab completa ex "vx_MAST_nomeTabella"
//---         id utente 'vero' da sostituire a quello finto 'standard' 
//--------------------------------------------------------------------------------------
//
//
long k_rc, k_ctr1, k_ctr2
string k_return
	
	try

		k_ctr1 = pos(k_nome_tab, "_", 1)
		if k_ctr1 > 0 then
			k_ctr2 = pos(k_nome_tab, "_", k_ctr1 +1)
			if k_ctr2 > 0 then
				k_return =  left(k_nome_tab, k_ctr1)  + k_id_utente  + mid(k_nome_tab, k_ctr2) // string(kguo_utente.get_id_utente( )) + mid(k_nome_tab, k_ctr2)
			end if
		end if
		if k_ctr1 = 0 or k_ctr2 = 0 then 
			kguo_exception.inizializza( )
			kguo_exception.kist_esito.nome_oggetto = this.classname( )
			kguo_exception.kist_esito.esito = kguo_exception.KK_st_uo_exception_tipo_internal_bug
			kguo_exception.kist_esito.sqlerrtext = "Fallita normalizzazione nome tabella utente, nome passato: " + k_nome_tab
			throw kguo_exception
		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		
return k_return 	

end function

public function string u_change_nometab_xutente (string k_nome_tab, string k_id_utente) throws uo_exception;//
//--------------------------------------------------------------------------------------
//--- Cambia il nome della tabella da utente standard a utente vero
//--- es.  vx_MAST_tabella_esempio ---> vx_0037_tabella_esempio
//---     vx_ = prefisso del nome tabella quasi sempre fisso così
//---     MAST = parte da cambiare x utente 37 
//---     _nomeTabella = suffisso del nome tabella
//--- Inp: nome tab completa ex "vx_MAST_nomeTabella"
//---         id utente 'vero' da sostituire a quello finto 'standard' 
//--------------------------------------------------------------------------------------
//
//
string k_return


	k_return = u_change_nometab_xutente_1(k_nome_tab, k_id_utente)

		
return k_return 	

end function

private subroutine u_set_ds_change_name_tab_1 (ref datawindow kdw_1, string k_nome_tab, string k_nome_tab_new) throws uo_exception;//--------------------------------------------------------------------------------------
//--- Cambia il nome della tabella nel ds come da standard
//--- es.  vx_MAST_tabella_esempio ---> vx_0001_tabella_esempio
//---     vx_ = prefisso del nome tabella quasi sempre fisso così
//---     MAST = parte da cambiare
//---     _nomeTabella = suffisso del nome tabella
//--- Inp: datastore, nome tab da cambiare, nome tab nuovo
//--------------------------------------------------------------------------------------
//
//
long k_rc, k_ctr
string k_sql_orig, k_string, k_stringn
	
	try

		k_stringn = k_nome_tab_new
		k_string =  k_nome_tab

		k_sql_orig = kdw_1.Object.DataWindow.Table.Select 
		k_ctr = Pos(k_sql_orig, k_string, 1)
		DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
			k_sql_orig = Replace(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
			k_ctr = Pos(k_sql_orig, k_string, k_ctr+LenA(k_string))
		LOOP
		kdw_1.Object.DataWindow.Table.Select = k_sql_orig
		
		k_sql_orig = kdw_1.Object.DataWindow.Table.update
		if k_sql_orig <> "?" then
			k_ctr = Pos(k_sql_orig, k_string, 1)
			if k_ctr > 0 then
				k_sql_orig = Replace(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
				kdw_1.Object.DataWindow.Table.update = k_sql_orig	
			end if
		end if
	
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		
	

end subroutine

public subroutine u_set_ds_change_name_tab (ref datawindow kdw_1, string k_nome_tab) throws uo_exception;//--------------------------------------------------------------------------------------
//--- Cambia il nome della tabella nel ds come da standard
//--- es.  vx_MAST_tabella_esempio ---> vx_0001_tabella_esempio
//---     vx_ = prefisso del nome tabella quasi sempre fisso così
//---     MAST = parte da cambiare
//---     _nomeTabella = suffisso del nome tabella
//--- Inp: datastore, nome tab completa ex "nomeTabella"
//--------------------------------------------------------------------------------------
//
//
string k_nome_tab_new
	
	
	try

		k_nome_tab_new = u_change_nometab_xutente(k_nome_tab)  // ritorna il nuovo nome tab x utente 

		u_set_ds_change_name_tab_1(kdw_1, k_nome_tab, k_nome_tab_new)
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		
	

end subroutine

public subroutine u_set_ds_change_name_tab (ref datawindow kdw_1, string k_nome_tab, string k_id_utente) throws uo_exception;/*
 Cambia il nome della tabella nel DW come da standard
   es.  vx_MAST_tabella_esempio ---> vx_0001_tabella_esempio
	 il nome è diviso in 3 spezzoni dal '_': 
      1-  vx = prefisso del nome tabella quasi sempre fisso così ma può essere differente
      2-  MAST = parte da sostituire con il codice utente
      3-  nomeTabella = nome fisso della 'tabella'
  Inp: dw, nome da sostituire, id utente che sostituisce il 2' spezzone ad esempio MAST
*/
string k_nome_tab_new
	
	
	try

		k_nome_tab_new = u_change_nometab_xutente(k_nome_tab, k_id_utente)  // ritorna il nuovo nome tab x utente 

		u_set_ds_change_name_tab_1(kdw_1, k_nome_tab, k_nome_tab_new)
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		
	

end subroutine

public subroutine u_dw_extend_col_to_edge (datawindow a_dw, string a_column);//
//--- Estende la colonna fino al bordo finale
//--- Inp: dw and column name
//
long k_width


k_width = a_dw.width - long(a_dw.describe(a_column + ".x")) - 105 //105=scrollbar
if k_width > 0 then
	a_dw.Modify(a_column +".Width='"+ String(k_width) +"' ")
end if

end subroutine

public function long u_getlistselectedrow (datawindow kdw_1);//
//--- Torna la prima riga selezionata nel datawindow
//
long k_row


	k_row = kdw_1.getselectedrow(0)
	if k_row = 0 then
		if kdw_1.rowcount( ) = 1 then
			k_row = 1
		end if
	end if
	
return k_row


end function

public function boolean u_theme_apply ();//
//--- Applica il Thema 
//
boolean k_return
kuf_base kuf1_base


kuf1_base = create kuf_base
if kuf1_base.if_thema_attivo( ) then
//	ApplyTheme ("m2000t")
	//ApplyTheme ("Flat Design Blue")
	if ApplyTheme (KKi_THEME) > 0 then
		k_return = true
	end if
end if	

if isvalid(kuf1_base) then destroy kuf1_base

return k_return
end function

public subroutine errori_scrivi_esito (string k_operazione, st_esito kst_esito);//---
//--- OBSOLETA CHIAMARE LA kguo_exception.u_write_error(kst_esito)
//---
//--- Gestione scrittura/lettura Errori su file LOG
//--- Input: 
//---   		Operazione obsoleto
//---   		struttura  ST_ESITO
//--- Ritorna: "W" se operazioni rispettive o OK
//---          "1"  nessuna operazione riuscita 
//---
//--- ESEMPIO:
//---			kst_esito.nome_oggetto = this.classname()
//---			kst_esito_err.esito = kkg_esito.DB_KO
//---			kst_esito_err.sqlcode = sqlca.sqlcode
//---			kst_esito_err.sqlerrtext = trim(sqlca.sqlerrtext)
//---			kGuf_data_base.errori_scrivi_esito("W", kst_esito_err) 
//---			
//string k_return = "1"


	kguo_exception.scrivi_log(kst_esito)
						
//return k_return



end subroutine

public subroutine errori_scrivi_esito (st_esito kst_esito);//---
//--- OBSOLETA CHIAMARE LA kguo_exception.u_write_error(kst_esito)
//---
//--- Gestione scrittura/lettura Errori su file LOG
//--- Input: 
//---   		struttura  ST_ESITO
//--- Ritorna: "W" se operazioni rispettive o OK
//---          "1"  nessuna operazione riuscita 
//---
//--- ESEMPIO:
//---			kst_esito.nome_oggetto = this.classname()
//---			kst_esito_err.esito = kkg_esito.DB_KO
//---			kst_esito_err.sqlcode = sqlca.sqlcode
//---			kst_esito_err.sqlerrtext = trim(sqlca.sqlerrtext)
//---			kGuf_data_base.errori_scrivi_esito("W", kst_esito_err) 
//---			
//string k_return = "1"


	kguo_exception.scrivi_log(kst_esito)
						
//return k_return

end subroutine

public function string profilestring_leggi_scrivi (string k_key, string k_key_1);//---
//--- Scrive sul file CONFDB.INI  
//---
//--- inp: 	k_key = '1' x lettura, '2' x scrittura o meglio:
//---				ki_profilestring_operazione_leggi
//---				ki_profilestring_operazione_scrivi
//--- 			k_key_1 = nome dato da leggere/scrivere
//--- 			
//--- out: valore estratto (se lettura)
string k_str

return profilestring_leggi_scrivi(integer(k_key),k_key_1,k_str)



end function

public function string profilestring_leggi_scrivi (string k_key, string k_key_1, string k_key_2);//---
//--- Scrive sul file CONFDB.INI  
//---
//--- inp: 	k_key = '1' x lettura, '2' x scrittura o meglio:
//---				ki_profilestring_operazione_leggi
//---				ki_profilestring_operazione_scrivi
//--- 			k_key_1 = nome dato da leggere/scrivere
//--- 			k_key_2 = valore eventualmente da scrivere 
//--- out: valore estratto (se lettura)

return profilestring_leggi_scrivi(integer(k_key),k_key_1,k_key_2)



end function

public function string u_barcode_build (string a_barcode_init, integer a_n_barcode, ref string a_barcode[]);/*
--------------------------------------------------------------------------------------------
 Fabbrica un nuovo BARCODE partendo da uno passato

    inp: barcode da cui partire, numero di barcode da generare, array vuoto
    Out: array con i barcode prodotti
    Rit: ultimo nuovo barcode                    

 Il barcode qui generato è composto cosi':
    e' un code-39 di 8 caratteri 'cccxxnnn'
    ccc  = codice di 3 deciso nelle Proprietà se non ho messo nulla imposta DSM
    xx   = progressivo alfanumerico
    nnn = progressivo 0-999 numerico

--------------------------------------------------------------------------------------------
*/
string k_return=""
string k_barcode_mask, k_barcode_progr, k_barcode_alfa, k_barcode_pref, k_barcode_inizio
string K_ALFA, K_ALFA1, K_BARC_CLIENTE_ALFA[0 to 30] 
int K_ALFA1_LENGTH, K_ALFA_LENGTH
int k_barcode_num=0, K_CTR1
int k_ind


	if isnull(a_barcode_init) then a_barcode_init = ""
	
//--- divide il barcode in due ALFA (mask di 3) + PROGRESSIVO (2 alfa + 3 numerici)
	k_barcode_mask = left(trim(a_barcode_init),3)
	k_barcode_progr = mid(trim(a_barcode_init),4)
	if trim(k_barcode_progr) > " " and isnumber(mid(k_barcode_progr,3,3)) then
		k_barcode_pref = left(k_barcode_progr,2) 
		k_barcode_num = integer(mid(k_barcode_progr,3,3))
	else
		k_barcode_pref = "AA"
		k_barcode_num = 0
	end if
			
//--- Prepara array x incremento prima parte del barcode 1 e 2 carattere
	K_ALFA  = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	K_ALFA_LENGTH = len(trim(K_ALFA)) - 2
	K_ALFA1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	K_ALFA1_LENGTH = len(trim(K_ALFA1)) - 2
	K_BARC_CLIENTE_ALFA [0] = "A"
	K_BARC_CLIENTE_ALFA [1] = "B"
	K_BARC_CLIENTE_ALFA [2] = "C"
	K_BARC_CLIENTE_ALFA [3] = "D"
	K_BARC_CLIENTE_ALFA [4] = "E"
	K_BARC_CLIENTE_ALFA [5] = "F"
	K_BARC_CLIENTE_ALFA [6] = "G"
	K_BARC_CLIENTE_ALFA [7] = "H"
	K_BARC_CLIENTE_ALFA [8] = "I"
	K_BARC_CLIENTE_ALFA [9] = "J"
	K_BARC_CLIENTE_ALFA [10] = "K"
	K_BARC_CLIENTE_ALFA [11] = "L"
	K_BARC_CLIENTE_ALFA [12] = "M"
	K_BARC_CLIENTE_ALFA [13] = "N"
	K_BARC_CLIENTE_ALFA [14] = "O"
	K_BARC_CLIENTE_ALFA [15] = "P"
	K_BARC_CLIENTE_ALFA [16] = "Q"
	K_BARC_CLIENTE_ALFA [17] = "R"
	K_BARC_CLIENTE_ALFA [18] = "S"
	K_BARC_CLIENTE_ALFA [19] = "T"
	K_BARC_CLIENTE_ALFA [20] = "U"
	K_BARC_CLIENTE_ALFA [21] = "V"
	K_BARC_CLIENTE_ALFA [22] = "W"
	K_BARC_CLIENTE_ALFA [23] = "X"
	K_BARC_CLIENTE_ALFA [24] = "Y"
	K_BARC_CLIENTE_ALFA [25] = "Z"

	for k_ind = 1 to a_n_barcode
		if k_barcode_num < 999 then
			k_barcode_num = k_barcode_num + 1
		else
			k_barcode_num = 001 
			
			for K_CTR1 = 1 to K_ALFA1_LENGTH
				if mid(k_barcode_pref,2,1) = mid(K_ALFA1,K_CTR1,1) then  
					exit 
				end if 
			end for 
				
			if mid(k_barcode_pref,2,1) <> mid(K_ALFA1,K_CTR1,1) then  
				k_barcode_pref = replace(k_barcode_pref,2,1, mid(K_ALFA1,1,1)) 
			
				for K_CTR1 = 1 to K_ALFA_LENGTH
					if mid(k_barcode_pref,1,1) = mid(K_ALFA,K_CTR1,1) then  
						exit 
					end if
				end for 
				
				if mid(k_barcode_pref,1,1) <> mid(K_ALFA,K_CTR1,1) then  
					k_barcode_pref = replace(k_barcode_pref,1,1,mid(K_ALFA,1,1))
				else
					K_CTR1 = K_CTR1 + 1
					k_barcode_pref = replace(k_barcode_pref,1,1,mid(K_ALFA,K_CTR1,1))
				end if
			else
				K_CTR1 = K_CTR1 + 1
				k_barcode_pref = replace(k_barcode_pref,2,1,mid(K_ALFA1,K_CTR1,1))
			end if 
		end if
		
		a_barcode[k_ind] = trim(k_barcode_mask) + trim(k_barcode_pref) + string(k_barcode_num,"000")			
		
	next
	
	k_return = trim(k_barcode_mask) + trim(k_barcode_pref) + string(k_barcode_num,"000")	

return k_return

end function

public function integer dw_salva_righe (string k_argomenti, readonly datastore kds_save, string k_titolo);/*
 Salva i dati del DATASTORE e gli argomenti passati
  Input: 
     k_argomenti  argomenti della dw
     kds_save  	datastore da salvare
     k_titolo     titolo x comporre il nome-file
  Ritorna: 1=Errore, 0=OK
*/  
int k_return
int k_rc
string k_nome_file


	if kds_save.rowcount() > 0  then
	
		k_nome_file = dw_salva_arg_get_nome_file(trim(kds_save.dataobject), k_titolo)
		if k_nome_file > " " then

			k_rc=dw_salva_arg(k_nome_file &
										, k_argomenti &
										, 1 &
										, trim(kds_save.Object.DataWindow.Table.Sort)) 
			if k_rc < 1 then
				k_return = 1
			else	
				if kds_save.saveas(k_nome_file + ".txt", text!, false) < 0 then
					k_return = 1
				end if
			end if			
			
		end if
		setpointer(kkg.pointer_default)
	else
		k_return = 1
	end if	 

return k_return

end function

public function integer dw_salva_righe (string k_argomenti, readonly datawindow kdw_save, string k_titolo);/*
 Salva i dati del DW e gli argomenti passati
  Input: 
     k_argomenti  argomenti della dw
     kds_save  	dw da salvare
     k_titolo     titolo x comporre il nome-file
  Ritorna: 1=Errore, 0=OK
*/  

int k_return
int k_rc
string k_nome_file
long k_riga


if isvalid(kdw_save) then
	setpointer(kkg.pointer_attesa)

	if trim(k_titolo) > " " then
	else
		k_titolo = trim(kdw_save.title)
	end if
	k_nome_file = dw_salva_arg_get_nome_file(trim(kdw_save.dataobject), k_titolo)
	if k_nome_file > " " then
		
		k_riga = kdw_save.getrow()
		if k_riga > 0 then
		else
			if kdw_save.rowcount() > 0 then
				k_riga = 1
			end if
		end if
		
		k_rc=dw_salva_arg(k_nome_file &
										, k_argomenti &
										, k_riga &
										, trim(kdw_save.Object.DataWindow.Table.Sort)) 

		if k_rc = 0 then
	
			if kdw_save.saveas(k_nome_file + ".txt", text!, false) < 0 then
				k_return = 1
			end if
			
		else
			k_return = 1
		end if
					
	else
		k_return = 1
	end if	 
	setpointer(kkg.pointer_default)
else
	k_return = 1
end if	 


return k_return

end function

public function integer dw_salva_righe_reset (string k_argomenti, datawindow kdw_save, string k_titolo);/*
   Reset i dati salvati sul file del DW per gli argomenti passati
   Input: 
      k_argomenti  argomenti della dw
		kdw_1 datawindow solo x il titolo (dataobject)
      k_titolo  titolo x comporre il nome-file
   Ritorna: 1=Errore, 0=OK
*/
int k_return
int k_file_dw, k_rc
int k_bytes
string k_nome_file


if isvalid(kdw_save) then

	if trim(k_titolo) > " " then
	else
		k_titolo = trim(kdw_save.title)
	end if
	k_nome_file = dw_salva_arg_get_nome_file(trim(kdw_save.dataobject), k_titolo)
	if k_nome_file > " " then
		
		k_rc=dw_salva_arg(k_nome_file &
										, k_argomenti &
										, 0 &
										, " ") 

		if k_rc = 0 then
			filedelete(k_nome_file + ".txt")
//			k_file_dw = fileopen(k_nome_file + ".txt", linemode!, write!, lockreadwrite!,replace!)
//			if k_file_dw > 0 then
//				k_bytes = filewrite(k_file_dw, " ") //nessun dato
//				fileclose(k_file_dw)
//			end if
		end if
	end if	 

	if k_file_dw < 0 or k_bytes < 0 then
		k_return = 1
	end if
else
	k_return = 1
end if

return k_return

end function

private function integer dw_salva_arg (string k_nome_file, string k_argomenti, long k_riga_posizione, string k_sort);//
//---	Salva  'argomenti' passati con il DW
//---	Input: 
//--- Nome_file: path+nomefile no estensione
//---	k_argomenti  argomenti della dw
//---	k_ds_save  datastore
//---	Titolo usato x comporre il nome-file
//---	Ritorna: 1=Errore, 0=OK
//
int k_file 
int k_bytes, k_pos_start
long k_return=0


	if k_nome_file > " " then
		
		setpointer(kkg.pointer_attesa)
	
		k_file = fileopen( k_nome_file + ".arg", linemode!, write!, lockreadwrite!,replace!)
		if k_file > 0 then
		
//--- Scrivo il SORT
			if k_sort > " " and k_sort <> "?" then
			else
				k_sort = " "
			end if
			k_bytes = filewrite(k_file, k_sort) //scrivo i parametri di sort
			if k_bytes > 0 then
	
//--- scrive num riga con il fuoco
				k_bytes = filewrite(k_file, string(k_riga_posizione, "0000000000")) //Scrive il nr riga di getrow
				if k_bytes > 0 then

//--- scrive data e ora del backup
					k_bytes = filewrite(k_file, string(datetime(today(),now()))) 
					if k_bytes > 0 then
	
//--- scrive Argomenti
						if trim(k_argomenti) > " " then
							k_bytes = filewrite(k_file, trim(k_argomenti))
						else
							k_bytes = filewrite(k_file, " ") 
						end if
					
					end if
				end if
			end if
			fileclose(k_file)
		end if
		if k_bytes < 1 or k_file < 1 then
			k_return = 1
		end if

		setpointer(kkg.pointer_default)
	else
		k_return = 1
	end if	


return k_return

end function

private function integer dw_salva_arg_0 (string k_argomenti, readonly datawindow kdw_save);//
//=== Salva  'argomenti' passati con il DW
//=== Input: 
//===   k_argomenti  argomenti della dw
//===   k_dw_save  data window
//=== Ritorna: 1=Errore, 0=OK
int k_return
long k_riga
string k_nome_file


//kp=setpointer(hourglass!)

if isvalid(kdw_save) then

	k_nome_file = dw_salva_arg_get_nome_file(trim(kdw_save.dataobject),trim(kdw_save.title))
	if k_nome_file > " " then
		
		k_riga = kdw_save.getrow()
		if k_riga > 0 then
		else
			if kdw_save.rowcount() > 0 then
				k_riga = 1
			end if
		end if
		
		if k_nome_file > " " then
			k_return=dw_salva_arg(k_nome_file &
										, k_argomenti &
										, k_riga &
										, trim(kdw_save.Object.DataWindow.Table.Sort)) 
		end if

	else
		k_return = 1
	end if
else
	k_return = 1
end if

//setpointer(kp)

return k_return

end function

public function string dw_salva_arg_get_nome_file (string k_dw_dataobject, string k_titolo);// build  nome file path compreso

kuf_utility kuf1_utility
string k_nome_file
string k_path


k_path = trim(profilestring_leggi_scrivi(ki_profilestring_operazione_leggi, "arch_saveas")) 
if k_path > " " then

	if k_titolo > " " and k_titolo <> "none" then
		k_nome_file = k_dw_dataobject+k_titolo
	else
		k_nome_file = k_dw_dataobject + "_1"
	end if
	
	kuf1_utility = create kuf_utility
	k_nome_file = kuf1_utility.u_stringa_cmpnovocali(k_nome_file)   // cmpatta il nome file 

	k_nome_file = trim(k_path) + kkg.path_sep + k_nome_file
	
end if

return k_nome_file
end function

public function integer dw_ripri_righe (string k_argomenti, string k_titolo, ref datastore kds_import, ref datetime k_datetime_saved);/*
 Importa righe nel DATASTORE se gli argomenti passati nella dw_saveas sono rimasti uguali
   Input: 
     k_argomenti       argomenti della dw 
	  k_titolo          uguale a quello passato in dw_salva_righe
	Out:  
     kds_import        ritorna datastore con i dati
     k_datetime_saved  ritorna data e ora del backup
   Ritorna: 0 o < 0=Errore, >0=OK

*/
int k_file 
int k_bytes //, k_ctr
long k_return=0
string k_nome_file, k_record,  k_argomenti_sav_chiave, k_sort
long k_setrow
kuf_utility kuf1_utility


setpointer(kkg.pointer_attesa)

k_nome_file = dw_salva_arg_get_nome_file(trim(kds_import.dataobject), k_titolo )
if k_nome_file > " " then
	
	k_file = fileopen(k_nome_file + ".arg", linemode!, read!, lockreadwrite!)
	
	if k_file < 1 then
	
		k_return = 0
	
	else
	
		if isnull(k_argomenti) or k_argomenti = "" then
			k_argomenti = " "
		else
			k_argomenti = trim(k_argomenti)
		end if
	
		k_bytes = fileread(k_file, k_sort) //leggo SORT del dw salvati in prec
	
		k_bytes = fileread(k_file, k_record) //leggo numero riga x setrow
		if k_bytes > 0 then
			if isnumber((trim(k_record))) then
				k_setrow = long(trim(k_record))
			end if
		end if

		k_bytes = fileread(k_file, k_record) //leggo data e ora del backup
		k_datetime_saved = datetime(trim(k_record))
		if isnull(k_datetime_saved) then
			k_datetime_saved = datetime(kkg_data_no)
		end if

	//=== Cerco il rek con gli argomenti uguali 
		k_bytes = fileread(k_file, k_record) //leggo argomenti circa la CHIAVE di lettura
		if k_bytes > 0 then
			k_argomenti_sav_chiave = (k_record)
		
			if isnull(k_argomenti_sav_chiave) or k_argomenti_sav_chiave = "" then
				k_argomenti_sav_chiave = " "
			end if
		else
			k_argomenti_sav_chiave = " "
		end if
		do while trim(k_argomenti) <> trim(k_argomenti_sav_chiave) and k_bytes > 0 
			k_bytes = fileread(k_file, k_record) //leggo argomenti del dw salvati in prec
			if k_bytes > 0 then
				k_argomenti_sav_chiave += "~h0D" +"~h0A" + k_record  //dovrebbe 0A=newLine; 0D=ret.Carr.
			end if
		loop
		if trim(k_argomenti) <> trim(k_argomenti_sav_chiave) then
			k_argomenti_sav_chiave += "~h0D" +"~h0A" 
		end if
	
		if k_argomenti = k_argomenti_sav_chiave or k_argomenti = " " then
	
//--- importa i dati file nel datastore	
			k_return = kds_import.importfile(k_nome_file + ".txt")
	
			if k_return < 1 then
				k_return = 0
			else
				if k_setrow > 0 then
					k_return = k_setrow   // nr riga su cui era posizionato (setrow())
				else
					k_return = 1
				end if
	
				if LenA(trim(k_sort)) > 0 then
					kds_import.setsort (k_sort)
					kds_import.sort ()
				end if
	
				kds_import.triggerevent(retrieveend!)
				
				kds_import.resetupdate()
			end if	
				
		else
			
			k_return = 0
			
		end if

	
		k_file = fileclose(k_file)
	end if	 

end if	
setpointer(kkg.pointer_default)
	


return k_return

end function

public function string profilestring_leggi_scrivi (readonly integer k_key, string k_key_1, string k_key_2);//
//--- Parametri passati :  k_key = 1 x lettura, 2 x scrittura
//--- 							k_key_1 = nome dato da leggere/scrivere
//--- 							k_key_2 = valore eventualmente da scrivere 
//--- Out: valore trovato 
//
string k_return = ""   
string k_key_3, k_file
int k_leggi=1, k_scrivi=2, k_rc
st_profilestring_ini kst_profilestring_ini
	

try

	if LeftA(k_key_1, 9) = "generico." then
		k_key_3 = MidA(k_key_1, 10) 
		k_key_1 = "generico." 
	end if
	
	k_key_1 = trim(k_key_1)
	k_key_2 = trim(k_key_2)
	
//--- se sto personalizzando un campo del 'navigatore' ovvero inizia per tv_larg_campo_
	if LeftA(k_key_1, 14) = "tv_larg_campo_" then
		kst_profilestring_ini.file = "autogestiti"
		k_file = profilestring_get_filename(kst_profilestring_ini)	//--- imposta e verifica il nome del file

//--- salvo le dimensioni delle colonne della treeview
		if k_key = k_leggi then 
			k_RETURN = trim(profilestring ( k_file, "autogestiti", k_key_1, "nullo"))
			if k_return = "nullo" then
				k_return = "0"
				k_rc = SetProfileString(k_file, "autogestiti", k_key_1, trim(k_return))
			end if
		else
			k_return = trim(string(SetProfileString(k_file, "autogestiti", k_key_1, k_key_2)))
		end if
	
	else
		
		choose case lower(k_key_1)

//			case "arch_base"
//				if fileexists(k_file) then
//					if k_key = k_leggi then 
//						k_RETURN = trim(profilestring ( k_file, "ambiente", "arch_base", "nullo"))
//						if k_return = "nullo" then
//							k_return = trim(GetCurrentDirectory ( )) + "\db"
//							k_rc = SetProfileString(k_file, "ambiente", "arch_base", trim(k_return))
//						end if
//					else
//						k_return = string(SetProfileString(k_file, "ambiente", "arch_base", k_key_2))
//					end if
//				else
//					k_return = "NF"
//				end if
	
			case "arch_saveas"
				k_return = kguo_path.get_path_arch_saveas()
//				if fileexists(k_file) then
//					if k_key = k_leggi then 
//						k_RETURN = trim(profilestring ( k_file, "ambiente", "arch_saveas", "nullo"))
//						if k_return = "nullo" then
//							k_return = trim(GetCurrentDirectory ( )) + "\save_dw"
//							k_rc = SetProfileString(k_file, "ambiente", "arch_saveas", trim(k_return))
//						end if
//					else
//						k_return = string(SetProfileString(k_file, "ambiente", "arch_saveas", k_key_2))
//					end if
//				else
//					k_return = "NF"
//				end if
	
//			case "path_db"
//				if fileexists(k_file) then
//					k_return = profilestring ( k_file, "ambiente", "arch_base", ".")
//				else
//					k_return = "NF"
//				end if
	
//			case "path_help"
//				if fileexists(k_file) then
//					k_return = profilestring ( k_file, "ambiente", "pathHelp", "nullo")
//					if k_return = "nullo" then
//						k_return = trim(GetCurrentDirectory ( )) + "\help"
//					end if
//				else
//					k_return = "NF"
//				end if
				
			case "arch_riba"
				kst_profilestring_ini.file = "ambiente"
				k_file = profilestring_get_filename(kst_profilestring_ini)	//--- imposta e verifica il nome del file
					
				if k_key = k_leggi then 
					k_RETURN = trim(profilestring ( k_file, "ambiente", "arch_riba", "nullo"))
					if k_return = "nullo" then
						k_return = trim(GetCurrentDirectory ( )) + "\riba.txt"
						k_rc = SetProfileString(k_file, "ambiente", "arch_riba", trim(k_return))
					end if
				else
					k_return = string(SetProfileString(k_file, "ambiente", "arch_riba", k_key_2))
				end if
	
			case "arch_pilota"
				kst_profilestring_ini.file = "ambiente"
				k_file = profilestring_get_filename(kst_profilestring_ini)	//--- imposta e verifica il nome del file
				
				if k_key = k_leggi then 
					k_RETURN = trim(profilestring ( k_file, "ambiente", "arch_pilota", "nullo"))
					if k_return = "nullo" then
						k_return = trim(GetCurrentDirectory ( )) + "\fpilota"
						k_rc = SetProfileString(k_file, "ambiente", "arch_pilota", trim(k_return))
					end if
				else
					k_return = string(SetProfileString(k_file, "ambiente", "arch_pilota", k_key_2))
				end if
	
			case "arch_graf"
				kst_profilestring_ini.file = "login"
				k_file = profilestring_get_filename(kst_profilestring_ini)	//--- imposta e verifica il nome del file
				
//				if fileexists(k_file) then
//					if k_key = k_leggi then 
//						k_RETURN = trim(profilestring ( k_file, "ambiente", "arch_graf", "nullo"))
//						if k_return = "nullo" then
							k_return = kguo_path.get_base_del_server( )
							if k_return > " " then
								k_return += "\ICONE"
								k_rc = SetProfileString(k_file, "ambiente", "arch_graf", trim(k_return))
							else
								k_return = kguo_path.get_path_app() + kkg.path_sep + "ICONE"
							end if
							
//						end if
//					else
//						k_return = string(SetProfileString(k_file, "ambiente", "arch_graf", k_key_2))
//					end if
//				else
//					k_return = "NF"
//				end if
	
//			case "arch_4gi"
//				if fileexists(k_file) then
//					if k_key = k_leggi then 
//						k_RETURN = trim(profilestring ( k_file, "ambiente", "arch_4gi", "nullo"))
//						if k_return = "nullo" then
//							k_return = trim(GetCurrentDirectory ( ))
//							k_rc = SetProfileString(k_file, "ambiente", "arch_4gi", trim(k_return))
//						end if
//					else
//						k_return = string(SetProfileString(k_file, "ambiente", "arch_4gi", k_key_2))
//					end if
//				else
//					k_return = "NF"
//				end if
	
			case "temp" //OBSOPLETO chiamare direttamente kguo_path.get_temp( )  
				k_return = kguo_path.get_temp( ) 
//				if fileexists(k_file) then
//					if k_key = k_leggi then 
//						k_RETURN = trim(profilestring ( k_file, "ambiente", "temp", "nullo"))
//						if k_return = "nullo" then
//							k_return = trim(GetCurrentDirectory ( )) + "\temp"
//							k_rc = SetProfileString(k_file, "ambiente", "temp", trim(k_return))
//						end if
//					else
//						k_return = string(SetProfileString(k_file, "ambiente", "temp", k_key_2))
//					end if
//				else
//					k_return = "NF"
//				end if
	
			case "temp_server" //temporaneo sul server
				kst_profilestring_ini.file = "ambiente"
				k_file = profilestring_get_filename(kst_profilestring_ini)	//--- imposta e verifica il nome del file
				
				if k_key = k_leggi then 
					k_RETURN = trim(profilestring ( k_file, "ambiente", "temp_server", "nullo"))
					if k_return = "nullo" then
						k_return = kGuo_path.get_path_app() + "\temp"
						k_rc = SetProfileString(k_file, "ambiente", "temp_server", trim(k_return))
					end if
				else
					k_return = string(SetProfileString(k_file, "ambiente", "temp_server", k_key_2))
				end if
	
			case "pathfileaccessname"
				kst_profilestring_ini.file = "database"
				k_file = profilestring_get_filename(kst_profilestring_ini)	//--- imposta e verifica il nome del file
				
				if k_key = k_leggi then 
					k_RETURN = trim(profilestring ( k_file, "Database", "pathfileaccessname", "nullo"))
					if k_return = "nullo" then
						k_return = ""
						k_rc = SetProfileString(k_file, "Database", "pathfileaccessname", trim(k_return))
					end if
				end if
	
			case "servername"
				kst_profilestring_ini.file = "database"
				k_file = profilestring_get_filename(kst_profilestring_ini)	//--- imposta e verifica il nome del file

				if k_key = k_leggi then 
					k_RETURN = trim(profilestring ( k_file, "Database", "servername", "nullo"))
					if k_return = "nullo" then
						k_return = "1"
						k_rc = SetProfileString(k_file, "Database", "servername", trim(k_return))
					end if
				else
					k_return = string(SetProfileString(k_file, "Database", "servername", k_key_2))
				end if
	
			case "nascondi_treeview"
				kst_profilestring_ini.file = "treeview"
				k_file = profilestring_get_filename(kst_profilestring_ini)	//--- imposta e verifica il nome del file
				
				if k_key = k_leggi then 
					k_RETURN = trim(profilestring ( k_file, "treeview", "nascondi_treeview", "nullo"))
					if k_return = "nullo" then
						k_return = "1"
						k_rc = SetProfileString(k_file, "treeview", "nascondi_treeview", trim(k_return))
					end if
				else
					k_return = string(SetProfileString(k_file, "treeview", "nascondi_treeview", k_key_2))
				end if
	
			case "listview_view"
				kst_profilestring_ini.file = "treeview"
				k_file = profilestring_get_filename(kst_profilestring_ini)	//--- imposta e verifica il nome del file
				
				if k_key = k_leggi then 
					k_RETURN = trim(profilestring ( k_file, "treeview", "listview_view", "nullo"))
					if k_return = "nullo" then
						k_return = "0"
						k_rc = SetProfileString(k_file, "treeview", "listview_view", trim(k_return))
					end if
				else
					k_return = string(SetProfileString(k_file, "treeview", "listview_view", k_key_2))
				end if

			case "treeview_listview_dim"
				kst_profilestring_ini.file = "treeview"
				k_file = profilestring_get_filename(kst_profilestring_ini)	//--- imposta e verifica il nome del file
				
				if k_key = k_leggi then 
					k_RETURN = trim(profilestring ( k_file, "treeview", "treeview_listview_dim", "nullo"))
					if k_return = "nullo" then
						k_return = "0"
						k_rc = SetProfileString(k_file, "treeview", "treeview_listview_dim", trim(k_return))
					end if
				else
					k_return = string(SetProfileString(k_file, "treeview", "treeview_listview_dim", k_key_2))
				end if
	
			case "moduli" //dimensione stampa 
				kst_profilestring_ini.file = "moduli"
				k_file = profilestring_get_filename(kst_profilestring_ini)	//--- imposta e verifica il nome del file
				
				if k_key = k_leggi then 
					k_RETURN = trim(profilestring ( k_file, "moduli", "tabulato", "nullo"))
					if k_return = "nullo" then
						k_return = "1"
						k_rc = SetProfileString(k_file, "moduli", "tabulato", trim(k_return))
					end if
				else
					k_return = string(SetProfileString(k_file, "moduli", "tabulato", k_key_2))
				end if

			case "generico."
				kst_profilestring_ini.file = "generico"
				k_file = profilestring_get_filename(kst_profilestring_ini)	//--- imposta e verifica il nome del file
				
				if k_key = k_leggi then 
					k_RETURN = trim(profilestring ( k_file, LeftA(k_key_3, 8), MidA(k_key_3, 9), "nullo"))
					if k_return = "nullo" then
						k_return = k_key_2
						k_rc = SetProfileString(k_file, LeftA(k_key_3, 8), MidA(k_key_3, 9), k_key_2)
					end if
				else
					k_return = string(SetProfileString(k_file, LeftA(k_key_3, 8), MidA(k_key_3, 9), k_key_2))
				end if

//--- generico, ovvero il nome passato (k_key_1) diventa anche il tag nel config nella sezione AMBIENTE
			case else
				kst_profilestring_ini.file = "ambiente"
				k_file = profilestring_get_filename(kst_profilestring_ini)	//--- imposta e verifica il nome del file
				
				if k_key = k_leggi then 
					k_RETURN = trim(profilestring ( k_file, "ambiente", k_key_1, "nullo"))
					if k_return = "nullo" then
						k_return = ""
						if k_key_2 > " " and k_key_2 <> "nullo" then 
							k_rc = SetProfileString(k_file, "ambiente",  k_key_1, k_key_2)
						else
							k_rc = SetProfileString(k_file, "ambiente",  k_key_1, "")
						end if
					end if
				else
					k_return = string(SetProfileString(k_file, "ambiente", k_key_1, k_key_2))
				end if
				
		end choose
	
	end if

catch (uo_exception kuo_exception)
	k_return = "NF"
	k_file = kst_profilestring_ini.file
	
end try

if k_return = "NF" then
	k_return = ""
	messagebox ( "Fallito Accesso in Archivio di Configurazione", &
					 "Archivio non trovato: " + kkg.acapo + trim(k_file) + kkg.acapo + &
					 "Prego, Uscire dall'Applicazione.", &
					 stopsign!)
end if

if k_key = k_leggi then 
	k_key_2 = k_return 
end if
	

return trim(k_return)



end function

public function integer dw_ripri_righe (string k_argomenti, string k_titolo, ref datawindow kdw_import, ref datetime k_datetime_saved);/*
 Importa righe nel DW se gli argomenti passati nella dw_saveas sono rimasti uguali
   Input: 
     k_argomenti       argomenti della dw 
	  k_titolo          uguale a quello passato in dw_salva_righe
	Out:  
     kdw_import        ritorna dw con i dati
     k_datetime_saved  ritorna data e ora del backup
   Ritorna: 0 o < 0=Errore, >0=OK

*/
int k_return
datastore kds_1
pointer kp


	kp=setpointer(hourglass!)
	
	kds_1 = create datastore
	kds_1.dataobject = kdw_import.dataobject
	
	if k_titolo > " " then
	else
		k_titolo = kdw_import.title 
	end if
	
	k_return=dw_ripri_righe(k_argomenti, k_titolo, kds_1, k_datetime_saved)

	if kds_1.rowcount() > 0 then
		kds_1.rowscopy ( 1, kds_1.rowcount() , primary!, kdw_import, 1, primary! )
	end if
	
	destroy kds_1
	
	setpointer(kp)
	
return k_return

end function

public subroutine u_set_uo_sqlca_db_magazzino () throws uo_exception;/*
  Imposta la connessione al DB principale di AVVIO
*/
	if isvalid(kguo_path) then 
		kguo_path.set_server_name()   // set nome SERVER dal confdb
		kguo_path.set_file_access_name()  // set nome file di configurazione connessione ecc... DB dal confdb
		if not isvalid(KGuo_sqlca_db_magazzino) then 
			KGuo_sqlca_db_magazzino = create Kuo_sqlca_db_magazzino
			SQLCA = KGuo_sqlca_db_magazzino
		end if
		KGuo_sqlca_db_magazzino.inizializza( )   // recupera i dati di connessione al DB
	else
		kguo_exception.inizializza(this.classname())
		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_non_eseguito
		kguo_exception.kist_esito.sqlerrtext = "Impostazione della Connessione al DB principale non eseguita, ambiente 'PATH' non inizializzato. Rilanciare l'Applicazione."
	end if

end subroutine

public subroutine u_set_ds_change_name_tab_suff (ref datawindow kdw_1, string k_nome_tab, string k_nome_suff) throws uo_exception;/*
 Cambia il nome della tabella nel DW come da standard
   es.  vx_MAST_tabella_esempio ---> vx_0001_tabella_esempio23
	 il nome è diviso in 3 spezzoni dal '_': 
      1-  vx = prefisso del nome tabella quasi sempre fisso così ma può essere differente
      2-  MAST = parte da sostituire con il codice utente
      3-  nomeTabella = nome fisso della 'tabella'
  Inp: DW,  Nome da sostituire, Suffisso da aggiungere al nome es '23 
*/
string k_nome_tab_new
	
	
	try

		k_nome_tab_new = u_change_nometab_xutente(k_nome_tab)  // ritorna il nuovo nome tab x utente 
		k_nome_tab_new += trim(k_nome_suff)

		u_set_ds_change_name_tab_1(kdw_1, k_nome_tab, k_nome_tab_new)
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		
	

end subroutine

public subroutine u_set_ds_change_name_tab_name (ref datawindow kdw_1, string k_nome_tab, string k_nome_new) throws uo_exception;/*
 Cambia il nome della tabella nel DW come da standard
   es.  vx_MAST_tabella_esempio ---> vx_0001_tabella_esempio
  Inp: DW,  Nome da sostituire, Nome nuovo
*/
	
	
	try

		u_set_ds_change_name_tab_1(kdw_1, k_nome_tab, k_nome_new)
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		
	

end subroutine

public function string profilestring_crea_file (string k_path, string k_nome_file);//===
//=== Crea Nuovo File Vuoto
//=== Input: 
//===   Nome file comprensivo del path
//===              I=Aggiungi messaggio Informativo
//=== 
//===
//===   Ritorna: 1 = Operazione non riuscita
//===
int k_file 
int k_bytes, k_ctr, k_ctr_1, k_bytes_f, k_righe
string k_record, k_return = "1"

	
	SetPointer(kkg.pointer_attesa)

	if not (FileExists(k_path + k_nome_file)) then		
			
		k_file = fileopen(k_path + k_nome_file, linemode!, Write! , LockWrite! )
	
		if k_file > 0 then
			
			k_bytes = filewrite(k_file, "File creato in automatico il " + string(now(), "dd mmm yyyy hh:mm:ss"))
			
			k_bytes = filewrite(k_file, " ") //Una riga vuota

			k_return = "0"

			fileclose(k_file)
	
		end if
	end if	

	SetPointer(kkg.pointer_default)

return k_return

end function

private function string profilestring_get_filename (ref st_profilestring_ini kst_profilestring_ini);/*
 Imposta il nome archivio .ini 
	Inp/Out: st_profilestring_ini
				utente     	= utente di login (x defautl è il codice_utente di lavoro)
				file    		= nome logico del file (indicare solo se non è standard) 
            esito   	 	= torna 0 = OK, 1=ERRORE GRAVE, 2=non autorizzato all'accesso al file 
				nome_file	= in OUTPUT, nome del file 
				path        = cartella del nome file con il \ alla fine 
	rit:
*/
string k_PathUser


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
	kst_profilestring_ini.esito = "0"
	if trim(kst_profilestring_ini.utente) > " " then
	else
		kst_profilestring_ini.utente = string(kGuo_utente.get_id_utente(),"0")
	end if
	
	kst_profilestring_ini.path = trim(kGuo_path.get_base()) // cartella dei file .INI 	
	k_PathUser = KKG.PATH_SEP + trim(kst_profilestring_ini.utente) + KKG.PATH_SEP 

	choose case lower(trim(kst_profilestring_ini.file))
			
		case "database"
			kst_profilestring_ini.nome_file = trim(KKI_NOME_PROFILE_BASE) 
			k_PathUser = KKG.PATH_SEP
			kst_profilestring_ini.path = trim(kGuo_path.get_path_app()) // Eccezione questo file è nella cartella dell'APP
//--- il File esiste nella cartella radice?
			if not FileExists (kst_profilestring_ini.path + k_PathUser + kst_profilestring_ini.nome_file ) then
				kst_profilestring_ini.esito = "1"
				kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
				kguo_exception.kist_esito.sqlerrtext = "Archivio di Configurazione " &
							+ kkg.acapo + kst_profilestring_ini.path + k_PathUser + kst_profilestring_ini.nome_file + " " &
							+ kkg.acapo + "non trovato. " 
				kguo_exception.kist_esito.esito = kkg_esito.ko
				throw kguo_exception		
			end if
			
		case "ambiente"
			kst_profilestring_ini.nome_file = trim(KKi_NOME_PROFILE_BASE_USER) 	
			
		case "base_personale"
			kst_profilestring_ini.nome_file = trim(KKi_NOME_PROFILE_BASE_USER) 	
			
		case "login"
			kst_profilestring_ini.nome_file = trim(KKi_NOME_PROFILE_BASE_LOGIN) 	
			
		case "login0"
			k_PathUser = KKG.PATH_SEP + "0" + KKG.PATH_SEP
			kst_profilestring_ini.nome_file = trim(KKi_NOME_PROFILE_BASE_LOGIN) 	
	
		case "treeview"
			kst_profilestring_ini.nome_file = trim(KKi_NOME_PROFILE_BASE_TREEVIEW) 	
	
		case "window"
			kst_profilestring_ini.nome_file = trim(KKi_NOME_PROFILE_BASE_WIN) 	
	
		case "toolbar"
			kst_profilestring_ini.nome_file = trim(KKi_NOME_PROFILE_BASE_TOOLBAR) 	
	
		case "stampe"
			kst_profilestring_ini.nome_file = trim(KKi_NOME_PROFILE_BASE_PRN) 	
	
		case "risorse_grafiche"
			kst_profilestring_ini.titolo = "ambiente"
			kst_profilestring_ini.nome_file = trim(KKi_NOME_PROFILE_BASE_USER) 	
			
		case else
			kst_profilestring_ini.nome_file = trim(KKi_NOME_PROFILE_BASE_USER) 	
	
	end choose
	
	kst_profilestring_ini.path += k_PathUser 
	profilestring_build_file(kst_profilestring_ini.path, kst_profilestring_ini.nome_file )
	
catch (uo_exception kuo_exception)
	kst_profilestring_ini.esito = "1"
	kuo_exception.scrivi_log( )
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return kst_profilestring_ini.path + kst_profilestring_ini.nome_file 



end function

private function string profilestring_build_file (ref string a_path, string a_filename) throws uo_exception;/*
 Genera o copia il file .ini 
	Inp: path radice dove mettere i file INI
	     path_user path per distinfuere gli INI utenti
		  nome file
	Out: st_profilestring_ini
            esito   	 	= torna 0 = OK, 1=ERRORE GRAVE, 2=non autorizzato all'accesso al file 
				errortext
	rit:
*/
kuf_file_explorer kuf1_file_explorer


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
//--- verifica se esiste il file nella cartella BASE (esempio 'path_app+\db') 	
	if not FileExists(a_path + a_filename ) then 

//--- Crea la cartella se non esiste
		if not (DirectoryExists(a_path)) then		
			kuf1_file_explorer = create kuf_file_explorer
			kuf1_file_explorer.u_directory_create(a_path)
			if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
		end if
		
//--- altrimenti verfica che il file sia sul path dell'APP
		if FileExists (kGuo_path.get_path_app() + KKG.PATH_SEP + a_filename ) then
			
			if Filecopy (kGuo_path.get_path_app() + KKG.PATH_SEP + a_filename, &
							a_path + a_filename, false) = -1 then
				kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
				kguo_exception.kist_esito.sqlerrtext = "Archivio di configurazione delle personalizzazioni dell'Applicazione " &
						+ kkg.acapo + kGuo_path.get_path_app() + KKG.PATH_SEP + a_filename + " " &
						+ kkg.acapo + "non copiato nella cartella " &
						+ kkg.acapo + a_path + a_filename + " " 
				throw kguo_exception
			end if
		else
//--- se non esiste lo CREA VUOTO
			kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_dati_wrn
			kguo_exception.kist_esito.sqlerrtext = "Genera Archivio di Configurazione " &
							+ kkg.acapo + a_path + a_filename + " " &
							+ kkg.acapo + "perchè non trovato. " 
			kguo_exception.scrivi_log( )
//---- crea nuovo file vuoto
			profilestring_crea_file(a_path, a_filename)
			
		end if
	end if

catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return a_filename



end function

on kuf_data_base.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_data_base.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//
if ki_trace_attiva then
	TraceEnd()
	TraceClose()
end if

end event

