﻿$PBExportHeader$uo_g.sru
forward
global type uo_g from nonvisualobject
end type
end forward

global type uo_g from nonvisualobject
end type
global uo_g uo_g

type prototypes
//
Function Long GetLastError () Library "kernel32.dll"
Function ULong CreateMutex (ULong lpsa, Boolean fInitialOwner, String lpszMutexName) Library "kernel32.dll" Alias for CreateMutexA
Function ulong GetTimeZoneInformation (ref st_TIME_ZONE_INFORMATION lpTimeZoneInformation) Library "kernel32.dll"
Function ulong GetLocalTime (ref st_SYSTEMTIME lpSystemTime) Library "kernel32.dll"
Function ulong TzSpecificLocalTimeToSystemTime (ref st_TIME_ZONE_INFORMATION lpTimeZoneInformation, ref st_SYSTEMTIME lpSystemTime, ref st_SYSTEMTIME lpUniversalTime) Library "kernel32.dll"

end prototypes

type variables
//--- Variabili Globali GENERICHE
private:
longlong IDPROCEDURA=0 // handle della Procedura
//date DATAOGGI   //data oggi
//int ANNO //Anno corrente
//int MESE //Mese corrente
//int GIORNO //giorno corrente
//int ORA //Ora corrente
//int MINUTO //minuto corrente
//int SECONDO //secondo corrente

boolean ATTIVA_SUONI = false  //x attivare i suoni di open ecc... nelle windows
boolean SALVA_LISTE = false  //x attivare lo speed-list ovvero il salvatagio su HD delle DW x visualizz + in fretta
boolean flagZOOMctrl = false  //x attivare lo ZOOM con CLICK + CTRL 

string NOME_COMPUTER = "" // nome del pc da cui si sta lavorando

//--- Codice AZIENDA x accedere al BASE
public string ID_BASE = "A"

//boolean toolbar_window_stato=true //toolbar visibile o meno

//--- per fare la funzione di TROVA
public kuf_trova KGuf_trova
 
//--- windows ATTIVA 
public w_g_tab kGw_attiva 

//--- Struttura x passaggio dati tra window in alternativa alla PARM
public st_open_w kGst_open_w

//--- Array riferimenti alle Window aperte
private w_super kGw_aperte[]

//--- Menu toolbar Attivo (w_menu_tree)
public w_menu_tree kgw_toolbar_programmi

//--- per evitare date(0) che è 21/12/1899 quindi con le date a 01/01/1900 non funziona...
private date ki_datazero

//--- TRACE attiva/disbilitata
public boolean kG_trace_attiva=false
//--- per attivare il TEST ovvero la scrittura massiva su LOG di alcune fuinzioni attiva/disbilitata
public boolean kG_ScriviLog_attiva=false

//--- flag E-ONE: Attivo (come indicato in tab PROPRIETA' azienda)
private boolean kG_e1_enabled=false

//--- Anno impostato in BASE della Procedura
public integer kG_anno_procedura

//--- x reperire Data-ora corrente
private kds_current_datetime kids_current_datetime

//--- Fuso Orario rispetto al GMT (UTC) es. 1 x l'Italia e fuso + ora legale
public integer kG_UTC_fusoBase=1
public integer kG_UTC_fuso=1
//--- Inizio-Fine data Ora Legale
public boolean kG_OraLegale_ON=false
public date kG_OraLegale_dataCorrente=date(0) // al cambio data setta l'ora legale
public date kG_OraLegale_Start
public date kG_OraLegale_End
public boolean kG_OraLegale_InAttenzione=false  

//--- x window oggetti
public st_tab_menu_window_oggetti kGst_tab_menu_window_oggetti[]

//--- Uscita dalla PROCEDURA
public boolean kG_exit_si = false

//--- E1: Codice della facility di Minerbio (         270)
public string E1MCU="         270"

private string ki_column_focus_before_name_colbck[2]     // colonna appena lasciata da focus nome e colore background

//--- Theme applicato (DARK sfondo scuro)
public boolean theme_dark
public string theme

//--- def dei MESI 1=IT, 2=EN
private string kg_month[12,2]

end variables

forward prototypes
public subroutine set_attiva_suoni (boolean a_attiva_suoni)
public subroutine set_salva_liste (boolean a_salva_liste)
public function integer get_anno ()
public function boolean get_attiva_suoni ()
public function date get_dataoggi ()
public function boolean get_salva_liste ()
public function integer get_mese ()
public function integer get_giorno ()
public function string get_descrizione (string a_modalita)
public subroutine set_nome_computer (string a_nome_computer)
public function string get_nome_computer ()
public function integer get_ora ()
public function integer get_minuti ()
public function integer get_secondi ()
public function date get_datazero ()
public subroutine set_e1_enabled (boolean a_enabled)
public function boolean if_e1_enabled ()
public function datetime get_datetime_current ()
public subroutine set_oralegale_utc (datetime a_dataora_oggi) throws uo_exception
public function boolean if_w_toolbar_programmi ()
public subroutine window_aperta_add (ref w_super aw_da_aprire)
public function w_super window_aperta_get (string a_nome_window)
public function boolean window_aperta_if (longlong a_w_handle)
public function w_super window_aperta_get_x_primopiano (string a_primopiano)
public function integer window_aperta_rimuove (ref w_super aw_da_rimuovere)
public function string get_dockingregister ()
public subroutine get_st_w_docking (string a_nome_window)
public function boolean window_aperte_get_all (ref w_super aw_aperte[])
public function datetime get_datetime_zero ()
public function datetime get_datetime_current_old ()
public function integer set_anno_procedura (integer a_anno)
public subroutine set_flagzoomctrl (boolean a_flag)
public function boolean get_flagzoomctrl ()
public function string u_replace (string k_str, string k_str_old, string k_str_new)
public function w_super window_aperta_get_last ()
public function integer get_anno_procedura ()
public function string get_app_release ()
public subroutine set_idprocedura (longlong a_handle)
public function longlong get_idprocedura ()
public subroutine xxxuse_col_background_input_field (ref datawindow adw, string a_col_name)
public function datetime get_datetime_current_local ()
public function string get_month (integer a_month, string a_lang)
private subroutine set_month ()
end prototypes

public subroutine set_attiva_suoni (boolean a_attiva_suoni);
ATTIVA_SUONI = a_ATTIVA_SUONI
end subroutine

public subroutine set_salva_liste (boolean a_salva_liste);
SALVA_LISTE = a_SALVA_LISTE
end subroutine

public function integer get_anno ();
return year(date(get_datetime_current())) 
end function

public function boolean get_attiva_suoni ();
return ATTIVA_SUONI 
end function

public function date get_dataoggi ();
return date(get_datetime_current()) 
end function

public function boolean get_salva_liste ();
return SALVA_LISTE 
end function

public function integer get_mese ();
return month(date(get_datetime_current())) 
end function

public function integer get_giorno ();
return day(date(get_datetime_current())) 
end function

public function string get_descrizione (string a_modalita);//
string k_return = "?"

if a_modalita > " " then
	choose case a_modalita
		case kkg_flag_modalita.ELENCO
			k_return = kkg_flag_modalita.DES_ELENCO
		case kkg_flag_modalita.INSERIMENTO
			k_return = kkg_flag_modalita.DES_INSERIMENTO
		case kkg_flag_modalita.MODIFICA
			k_return = kkg_flag_modalita.DES_MODIFICA
		case kkg_flag_modalita.CANCELLAZIONE
			k_return = kkg_flag_modalita.DES_CANCELLAZIONE
		case kkg_flag_modalita.VISUALIZZAZIONE
			k_return = kkg_flag_modalita.DES_VISUALIZZAZIONE
		case kkg_flag_modalita.STAMPA
			k_return = kkg_flag_modalita.DES_STAMPA
		case kkg_flag_modalita.INTERROGAZIONE
			k_return = kkg_flag_modalita.DES_INTERROGAZIONE
		case kkg_flag_modalita.CHIUDI_PL
			k_return = kkg_flag_modalita.DES_CHIUDI_PL
		case kkg_flag_modalita.NAVIGATORE
			k_return = kkg_flag_modalita.DES_NAVIGATORE
		case kkg_flag_modalita.ANTEPRIMA
			k_return = kkg_flag_modalita.DES_ANTEPRIMA
		case kkg_flag_modalita.BATCH
			k_return = kkg_flag_modalita.DES_BATCH
		case kkg_flag_modalita.ALTRO
			k_return = kkg_flag_modalita.DES_ALTRO
		case else
			k_return = "Modalità " + a_modalita + "."
	end choose
end if

return trim(k_return)






end function

public subroutine set_nome_computer (string a_nome_computer);
NOME_COMPUTER = a_nome_computer
end subroutine

public function string get_nome_computer ();
return trim(NOME_COMPUTER)

end function

public function integer get_ora ();
return hour(time(get_datetime_current())) 
end function

public function integer get_minuti ();
return minute(time(get_datetime_current()))
end function

public function integer get_secondi ();
return second(time(get_datetime_current())) 

end function

public function date get_datazero ();//  
//--- torna la data 01/01/1900 o meglio date(0) + 1

return ki_datazero 
end function

public subroutine set_e1_enabled (boolean a_enabled);//
if a_enabled then
	kG_e1_enabled = true
else
	kG_e1_enabled = false
end if

end subroutine

public function boolean if_e1_enabled ();//
return kG_e1_enabled

end function

public function datetime get_datetime_current ();//
//--- Torna data ora UTC
//
datetime k_return, k_datetime_0
uo_exception kuo_exception

		
	k_datetime_0 = datetime(date(0), time(0))
		
	//--- get dal DB server data ora UTC
	k_return = kids_current_datetime.u_get_current()

	if k_return > k_datetime_0 then
	else
		kuo_exception = create uo_exception
		kuo_exception.kist_esito.esito = kkg_esito.ko
		kuo_exception.kist_esito.sqlerrtext = "ERRORE IN LETTURA DATA-ORA UTC DAL DB !!! PREGO VERIFICARE LA CONNESSIONE"
		kuo_exception.scrivi_log( )
		k_return = datetime(Today(), now())  // ULTIMA SPIAGGIA PIGLIO LA DATA LOCALE
	end if
	

return k_return

end function

public subroutine set_oralegale_utc (datetime a_dataora_oggi) throws uo_exception;//---
//--- Imposta dati Ora Legale e UTC su variabili globali
//--- Input: data-ora del momento
//---

	kG_OraLegale_InAttenzione = false
	kG_OraLegale_dataCorrente = date(a_dataora_oggi) 

//--- se sono in pieno nel priodo dell'ora legale allora somma un ora
	if kG_OraLegale_dataCorrente > kG_OraLegale_Start and kG_OraLegale_dataCorrente <= kG_OraLegale_End then
		kG_UTC_fuso = kguo_g.kG_UTC_fusoBase + 1
	else
		if kG_OraLegale_dataCorrente < kG_OraLegale_Start or kG_OraLegale_dataCorrente > relativedate(kG_OraLegale_End, 1) then
		else
			if kG_OraLegale_dataCorrente = kG_OraLegale_Start then
				if hour(time(a_dataora_oggi)) > 2 then 
					kG_UTC_fuso = kguo_g.kG_UTC_fusoBase + 1 //--- dalle 2 di notte scatta l'ora legale 
				//	kG_UTC_fuso += 1  //--- dalle 2 di notte scatta l'ora legale 
				else
					kG_OraLegale_InAttenzione = true // metto in attenzione fino alle 2 è il giorno del cambio!!
				end if
			else
				// sono il giorno dopo la fine dell'ora legale valida solo fino alle 3
				if hour(time(a_dataora_oggi)) < 3 then 
					kG_UTC_fuso = kguo_g.kG_UTC_fusoBase + 1 //--- dalle 2 di notte scatta l'ora legale 
//					kG_UTC_fuso += 1 
					kG_OraLegale_InAttenzione = true // metto in attenzione fino alle 3 è il giorno del cambio!!
				end if
			end if
		end if
	end if
	
end subroutine

public function boolean if_w_toolbar_programmi ();//
return false

end function

public subroutine window_aperta_add (ref w_super aw_da_aprire);//
//--- add una window all'array delle window aperte
//
int k_ctr=1, k_w_ctr_w_aperte=0


k_w_ctr_w_aperte = upperbound(kGw_aperte[])

for k_ctr = 1 to k_w_ctr_w_aperte

	if isvalid(kGw_aperte[k_ctr]) and not isnull(kGw_aperte[k_ctr]) then
	else
		exit
	end if
	
next

if trim(aw_da_aprire.ki_st_open_w.st_tab_menu_window.primopiano) > " " then
else
	aw_da_aprire.ki_st_open_w.st_tab_menu_window.primopiano = "N" // valore di default!!!
end if
kGw_aperte[k_ctr] = aw_da_aprire


end subroutine

public function w_super window_aperta_get (string a_nome_window);//
//--- torna la prima window dell'array con lo stesso nome se non indicato torna la prima valida
//
w_super kw_aperta
int k_ctr=1, k_w_ctr_w_aperte=0


setnull(kw_aperta)
k_w_ctr_w_aperte = upperbound(kGw_aperte[])
if a_nome_window > " " then
	a_nome_window = trim(a_nome_window)
else
	a_nome_window = ""
end if

for k_ctr = 1 to k_w_ctr_w_aperte

	if isvalid(kGw_aperte[k_ctr]) and not isnull(kGw_aperte[k_ctr]) then
		
		if kGw_aperte[k_ctr].className() = a_nome_window or a_nome_window = "" then
			kw_aperta = kGw_aperte[k_ctr]	
			exit
		end if
	else
		
		window_aperta_rimuove(kGw_aperte[k_ctr])
		
	end if

next

return kw_aperta


end function

public function boolean window_aperta_if (longlong a_w_handle);//
//--- check se windows aperta atraverso il Handle
//
boolean k_return=false
int k_ctr=1, k_w_ctr_w_aperte=0


k_w_ctr_w_aperte = upperbound(kGw_aperte[])

for k_ctr = 1 to k_w_ctr_w_aperte

	if isvalid(kGw_aperte[k_ctr]) then
		if handle(kGw_aperte[k_ctr]) = a_w_handle then
			k_return = true
			exit
		end if
	end if
	
next

return k_return



end function

public function w_super window_aperta_get_x_primopiano (string a_primopiano);//
//--- Torna prima windows aperta per dato 'primopiano' 
//
int k_ctr=1, k_w_ctr_w_aperte=0
w_super kw_super, kw_return


k_w_ctr_w_aperte = upperbound(kGw_aperte[])
setnull(kw_return)
a_primopiano = trim(a_primopiano)

for k_ctr = 1 to k_w_ctr_w_aperte

	if isvalid(kGw_aperte[k_ctr]) then
		kw_super = kGw_aperte[k_ctr]
		if trim(kw_super.ki_st_open_w.st_tab_menu_window.primopiano) = a_primopiano then
			kw_return = kw_super
			exit
		end if
	end if
	
next

return kw_return



end function

public function integer window_aperta_rimuove (ref w_super aw_da_rimuovere);//
//--- Rimuove dall'array la window con lo stesso nome 
//--- Torna il numero window ancora aperte
//
integer k_return
w_super kw_null
int k_ctr, k_w_ctr_w_aperte=0
boolean k_rimossa = false

kw_null = create w_super
setnull(kw_null)

if isvalid(aw_da_rimuovere) and not isnull(aw_da_rimuovere) then

	k_w_ctr_w_aperte = upperbound(kGw_aperte[])
	
	for k_ctr = 1 to k_w_ctr_w_aperte
	
		if isvalid(kGw_aperte[k_ctr]) and not isnull(kGw_aperte[k_ctr]) then
			
			if not k_rimossa and kGw_aperte[k_ctr].className() = aw_da_rimuovere.className() then
				kGw_aperte[k_ctr] = kw_null
				k_rimossa = true
				//exit
			else
				k_return ++
			end if
			
		end if
		
	next
end if

return k_return
end function

public function string get_dockingregister ();//
//--- Torna il nome di base del Docing Register

return "M2000\Docking\"  


end function

public subroutine get_st_w_docking (string a_nome_window);////
////--- torna tipo e nome della window da aprire come docking
////--- st_w_docking.k_type = "" = nessuna window 
////
//st_w_docking kst_w_docking
//int k_ctr=1, k_w_ctr_w
//
//
//kst_w_docking.k_type[k_ctr] = ""
//kst_w_docking.k_Name[k_ctr] = ""
//
//k_w_ctr_w = upperbound(kGst_w_docking.k_Name[])
//if a_nome_window > " " then
//	a_nome_window = trim(a_nome_window)
//else
//	a_nome_window = ""
//end if
//
//for k_ctr = 1 to k_w_ctr_w
//
//	if kGst_w_docking.k_Name[k_ctr] = a_nome_window then
//		kst_w_docking.k_name[1] = kGst_w_docking.k_name[k_ctr]
//		kst_w_docking.k_type[1] = kGst_w_docking.k_type[k_ctr]
//		exit
//	end if
//
//next
//
//return kst_w_docking


end subroutine

public function boolean window_aperte_get_all (ref w_super aw_aperte[]);//
//--- torna array con tutte le window 
//--- Out: false = array window a zero 
//
boolean k_return = false
int k_ctr

k_ctr = upperbound(kGw_aperte[])
if k_ctr > 0 then
	k_return = true
	aw_aperte = kGw_aperte[]
end if

return k_return


end function

public function datetime get_datetime_zero ();//  
//--- torna la data 01/01/1900 + time 00:00:00.000000 (midnight)

return datetime(date(0) )

end function

public function datetime get_datetime_current_old ();//
//--- Torna data ora (per informix)
//
datetime k_return, k_current, k_datetime_0
date k_current_date
time k_current_time
//boolean k_e1_enabled=false
//st_TIME_ZONE_INFORMATION kst_TIME_ZONE_INFORMATION
ulong k_rc
st_systemtime kst_systemtime //, kst_systemtime_out
//kds_current_datetime kds1_current_datetime
st_esito kst_esito


	try
		
		k_datetime_0 = datetime(date(0), time(0))
		
	//--- get dal DB server del date-time
	//	kds1_current_datetime = create kds_current_datetime
		k_current = kids_current_datetime.u_get_current()
	
	//--- 140317 Intercaccia E1 attiva
	//	if isvalid(kguo_g) then
	//		if kguo_g.if_e1_enabled( ) then
	//			if isvalid(kguo_sqlca_db_e1) then
	//				if kguo_sqlca_db_magazzino.if_connesso( ) then
	//					k_e1_enabled = true
	//				end if
	//			end if
	//		end if
	//	end if
	catch (uo_exception kuo_exception)
	
	finally

////--- scrive log per DEBUG 
//		if kguo_g.kG_ScriviLog_attiva then
//			kguo_exception.inizializza( )
//			kst_esito.esito = kkg_esito.ko
//			kst_esito.sqlerrtext = "DEBUG DATETIME 1.4 get_datetime_current  k_current: " + string(k_current)
//			kguo_exception.set_esito(kst_esito)
//		end if
		
		if k_current > k_datetime_0 then
		else
			k_current = datetime(Today(), now())
		end if
		k_current_date = date(k_current)
		k_current_time = time(k_current)
//	if isvalid(kds1_current_datetime) then destroy kds1_current_datetime
	
	end try

//--- 
//if k_e1_enabled then	
								//--- ottiene data+ora UTC ovvero il GMT 
								//	k_rc = GetTimeZoneInformation(kst_TIME_ZONE_INFORMATION)  // get time zone BIAS number
								//	if k_rc > 0 then
									//k_rc = GetLocalTime(kst_systemtime) //ottiene l'orario locale della macchina
	if kG_e1_enabled then		
		
		kst_systemtime.wday = day(k_current_date)
		kst_systemtime.wmonth = month(k_current_date)
		kst_systemtime.wyear = year(k_current_date)
		kst_systemtime.whour = hour(k_current_time)
		kst_systemtime.wminute = minute(k_current_time)
		kst_systemtime.wsecond = second(k_current_time)
		kst_systemtime.wmilliseconds = 0 			//long(string(k_current_time,"ms"))
		kst_systemtime.wdayofweek = DayNumber(k_current_date)
		
//--- scrive log per DEBUG 
//		if kguo_g.kG_ScriviLog_attiva then
//			kguo_exception.inizializza( )
//			kst_esito.esito = kkg_esito.ko
//			kst_esito.sqlerrtext = "DEBUG DATETIME 2.4 get_datetime_current  kst_systemtime: " + string(kst_systemtime.wday) + " "  + string(kst_systemtime.wmonth) + " " + string(kst_systemtime.wyear) 
//			kguo_exception.set_esito(kst_esito)
//		end if

//--- calcolo l'ora GMT 		
										//		k_rc = TzSpecificLocalTimeToSystemTime(kst_TIME_ZONE_INFORMATION, kst_systemtime, kst_systemtime_out) //trasforma l'ora locale in orario UTC+0 (Greenwich)
										//		if k_rc > 0 then
										//			k_return = datetime(date(kst_systemtime_out.wyear, kst_systemtime_out.wmonth, kst_systemtime_out.wday) &
										//							, time(kst_systemtime_out.whour ,kst_systemtime_out.wminute , kst_systemtime_out.wsecond)) 
										//		end if

//--- Se è cambiata la data del giorno oppure se sono nelle ore del cambio dell'ora legale faccio il ricalcolo
		if kG_OraLegale_InAttenzione or kG_OraLegale_dataCorrente <> k_current_date then 
			try
				
				set_oralegale_utc(k_current)
				
			catch (uo_exception kuo1_exception)
			end try
			
		end if
	
		if kst_systemtime.whour > kG_UTC_fuso then  // ho passato la mezzanotte oltre il fuso (ora legale comresa)?
			kst_systemtime.whour -= kG_UTC_fuso
		else		// se sono ad esempio le mezzanotte e 30 invece devo tornare al gg precedente
			kst_systemtime.whour = 24 - kG_UTC_fuso  
			k_current_date = relativedate(k_current_date, -1)
		end if
		k_return = datetime(k_current_date, time(kst_systemtime.whour ,kst_systemtime.wminute , kst_systemtime.wsecond))

//--- scrive log per DEBUG 
//		if kguo_g.kG_ScriviLog_attiva then
//			kguo_exception.inizializza( )
//			kst_esito.esito = kkg_esito.ko
//			kst_esito.sqlerrtext = "DEBUG DATETIME 3.4 get_datetime_current  k_rc + k_return: " + string(k_rc) + "+" + string(k_return)
//			kguo_exception.set_esito(kst_esito)
//		end if

									//	end if
									//	if k_rc = 0 then
									//		k_return = k_current //datetime(Today(), now())
									//	end if
	else
		k_return = k_current //datetime(Today(), now())
	end if
	
	if k_return > k_datetime_0 then
	else
		k_return = datetime(Today(), now())  // ULTIMA SPIAGGIA PIGLIO LA DATA LOCALE
	end if
	
	//--- scrive log per DEBUG 
	//if kguo_g.kG_ScriviLog_attiva then
	//	kguo_exception.inizializza( )
	//	kst_esito.esito = kkg_esito.ko
	//	kst_esito.sqlerrtext = "DEBUG DATETIME 4.4 get_datetime_current  k_return: " + string(k_return)
	//	kguo_exception.set_esito(kst_esito)
	//end if
	

return k_return

end function

public function integer set_anno_procedura (integer a_anno);//--- Memorizza l'anno impostato in tab base (ritorna eventualmente il vecchio valore)
int k_anno


k_anno = kG_anno_procedura

kG_anno_procedura = a_anno

if k_anno > 0 then
else
	k_anno = 0
end if
if kG_anno_procedura > 0 then
else
	kG_anno_procedura = k_anno
end if

return k_anno 
end function

public subroutine set_flagzoomctrl (boolean a_flag);
flagZOOMctrl = a_flag

end subroutine

public function boolean get_flagzoomctrl ();
return flagZOOMctrl 

end function

public function string u_replace (string k_str, string k_str_old, string k_str_new);//
//--- ricopre nella stringa k_str i caratteri k_str_old con k_str_new 
//
string k_return 
int kstart_pos = 1

// Find the first occurrence of old_str.

kstart_pos = pos(k_str, k_str_old, kstart_pos)

// Only enter the loop if you find old_str.

DO WHILE kstart_pos > 0

// Replace old_str with new_str.

    k_str = ReplaceA(k_str, kstart_pos, len(k_str_old), k_str_new)

// Find the next occurrence of old_str.

    kstart_pos = pos(k_str, k_str_old, kstart_pos+len(k_str_new) )

LOOP

k_return = k_str

return k_return
end function

public function w_super window_aperta_get_last ();//
//--- torna la penultima window dell'array
//
w_super kw_aperta
int k_ctr=1, k_w_ctr_w_aperte=0
//boolean k_find


setnull(kw_aperta)
k_w_ctr_w_aperte = upperbound(kGw_aperte[])

for k_ctr = k_w_ctr_w_aperte to 1 step -1

	if isvalid(kGw_aperte[k_ctr]) and not isnull(kGw_aperte[k_ctr]) then
		
		kw_aperta = kGw_aperte[k_ctr]
		exit

	else
		
		window_aperta_rimuove(kGw_aperte[k_ctr])
		
	end if

next

return kw_aperta


end function

public function integer get_anno_procedura ();
return kG_anno_procedura
end function

public function string get_app_release ();
//--- torna la versione del Programma Major Release + Minor Release ovvero MM.mm.mmmm

return trim(kkG.VERSIONE_MAJOR_REL + "." + u_replace(trim(string(kkG.versione, "00.0000")), ",", "."))

end function

public subroutine set_idprocedura (longlong a_handle);//-- es. 2.211.161.833
idprocedura = a_handle
end subroutine

public function longlong get_idprocedura ();
return idprocedura 
end function

public subroutine xxxuse_col_background_input_field (ref datawindow adw, string a_col_name);//
//--- usa il backgrond color de default per segnalare il cursore sul campo
//--- Da chiamare dal event itemfocuschanged di un dw
//--- Inp: datawindow reference + nome colonna su cui si trova il cursore
//
string k_rc, k_style


if isvalid(adw) then
	
//	if ki_column_focus_before_name_colbck[1] > " " then 
//		if adw.Describe("DataWindow.ReadOnly") = "yes" then
//			adw.modify(ki_column_focus_before_name_colbck[1] + ".Background.Color=" + kkg_colore.campo_disattivo + " ")
//		else
//			adw.modify(ki_column_focus_before_name_colbck[1] + ".Background.Color=" + ki_column_focus_before_name_colbck[2] + " ")
//		end if
//	end if
//	if a_col_name > " " then
//		//k_rc = adw.Describe("DataWindow.ReadOnly") 
//		if adw.Describe("DataWindow.ReadOnly") = "yes" then
//		else
//			if adw.Describe(a_col_name + ".TabSequence") > "0" and adw.Describe(a_col_name + ".Protect") <> "1" then
//				k_style = trim(adw.Describe(a_col_name + ".Edit.Style"))
//				if k_style <> "!" and k_style <> "?" and k_style <> "checkbox" and k_style <> "radiobuttons" then //and k_style <> "dddw" and k_style <> "ddlb" then
//					ki_column_focus_before_name_colbck[1] = a_col_name
//					ki_column_focus_before_name_colbck[2] = adw.Describe(a_col_name + ".Background.Color")
//					adw.modify(ki_column_focus_before_name_colbck[1] + ".Background.Color=" + kkg_colore.INPUT_FIELD + " ")
//					//--- ripristina autoselect se impostato
//					k_rc = adw.describe(a_col_name + ".Edit.AutoSelect")
//					if k_rc = 'yes' or k_rc = "?" then
//						adw.SelectText(1, Len(adw.GetText()))
//					end if
//				end if
//			end if
//		end if
//	end if
//--- Riristino del colore di sfondo originale della colonna precedente
	if ki_column_focus_before_name_colbck[1] > " " and ki_column_focus_before_name_colbck[1] <> a_col_name then 
		if adw.Describe("DataWindow.ReadOnly") = "yes" then
			adw.modify(ki_column_focus_before_name_colbck[1] + ".Background.Color=" + kkg_colore.campo_disattivo + " ")
		else
			adw.modify(ki_column_focus_before_name_colbck[1] + ".Background.Color=" + ki_column_focus_before_name_colbck[2] + " ")
		end if
	end if
	
	if a_col_name > " " then
		//k_rc = adw.Describe("DataWindow.ReadOnly") 
		if adw.Describe("DataWindow.ReadOnly") = "yes" then
		else
			if adw.Describe(a_col_name + ".TabSequence") > "0" and adw.Describe(a_col_name + ".Protect") <> "1" then
				
//--- Salva colore di sfondo originale
 				if ki_column_focus_before_name_colbck[1] <> a_col_name then
					ki_column_focus_before_name_colbck[1] = a_col_name
					ki_column_focus_before_name_colbck[2] = adw.Describe(a_col_name + ".Background.Color")
				end if
				
				adw.modify(a_col_name + ".Background.Color=" + kkg_colore.INPUT_FIELD + " ")

				k_style = trim(adw.Describe(a_col_name  + ".Edit.Style"))
				if k_style = "edit" then
				//--- ripristina autoselect se impostato, ma solo se EDIT altrimenti blocca il riempimento come nel dropdowncalendar
					k_rc = adw.describe(a_col_name + ".Edit.AutoSelect")
					if k_rc = 'yes' or k_rc = "?" then
						adw.SelectText(1, Len(adw.GetText()))
					end if
				end if
			end if
		end if
	end if
	
	
end if

end subroutine

public function datetime get_datetime_current_local ();/*
   Torna data ora LOCALE
*/
datetime k_return

		
	k_return = datetime(today(), now())		

return k_return

end function

public function string get_month (integer a_month, string a_lang);//

choose case a_lang
	case "EN"
		return kg_month[a_month, 2]
	case else
		return kg_month[a_month, 1]
end choose


end function

private subroutine set_month ();//
kg_month[1,1] = "Gen"; kg_month[1,2] = "Jan"
kg_month[2,1] = "Feb"; kg_month[2,2] = "Feb"
kg_month[3,1] = "Mar"; kg_month[3,2] = "Mar"
kg_month[4,1] = "Apr"; kg_month[4,2] = "Apr"
kg_month[5,1] = "Mag"; kg_month[5,2] = "May"
kg_month[6,1] = "Giu"; kg_month[6,2] = "Jun"
kg_month[7,1] = "Lug"; kg_month[7,2] = "Jul"
kg_month[8,1] = "Ago"; kg_month[8,2] = "Aug"
kg_month[9,1] = "Set"; kg_month[9,2] = "Sep"
kg_month[10,1] = "Ott"; kg_month[10,2] = "Oct"
kg_month[11,1] = "Nov"; kg_month[11,2] = "Nov"
kg_month[12,1] = "Dic"; kg_month[12,2] = "Dec"

end subroutine

on uo_g.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_g.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;////
//DATAOGGI=today()   //data oggi
//ANNO=year(today()) //Anno corrente
//MESE=month(today()) //Mese corrente
//GIORNO=day(today()) //giorno corrente
//
ki_datazero = relativedate(date(0), 1)
kids_current_datetime = create kds_current_datetime
set_month() // imposta array globale con des breve dei mesi

end event

event destructor;//
if isvalid(kids_current_datetime) then destroy kids_current_datetime

end event

