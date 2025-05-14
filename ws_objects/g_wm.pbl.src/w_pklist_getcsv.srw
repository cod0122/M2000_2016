$PBExportHeader$w_pklist_getcsv.srw
forward
global type w_pklist_getcsv from w_g_tab0
end type
end forward

global type w_pklist_getcsv from w_g_tab0
integer width = 3150
integer height = 2180
end type
global w_pklist_getcsv w_pklist_getcsv

type prototypes
//
subroutine DragAcceptFiles(long l_hWnd,boolean fAccept) library "shell32.dll"
subroutine DragFinish(long hDrop) library "shell32.dll"
function int DragQueryFileW(long hDrop,int iFile,ref string szFileName,int cb) library "shell32.dll"

end prototypes

type variables
//
private:
kuf_pklist_aptar kiuf_pklist_aptar
kuf_file_dragdrop kiuf_file_dragdrop


end variables

forward prototypes
protected subroutine open_start_window ()
protected function string inizializza () throws uo_exception
protected subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
public function long u_genera_pklist ()
public function long u_drop_file (integer a_k_tipo_drag, long a_handle)
public function long u_import_csv2dw_lista (string a_filename) throws uo_exception
public function integer u_import (string a_filename)
end prototypes

protected subroutine open_start_window ();//
kiuf_pklist_aptar = create kuf_pklist_aptar
kiuf_file_dragdrop = create kuf_file_dragdrop 

end subroutine

protected function string inizializza () throws uo_exception;//

	if dw_lista_0.rowcount( ) = 0 then 

		dw_lista_0.dataobject = "d_dragdrop_file_csvtxt"
		
	end if


//--- attiva eventuale Drag&Drop di files da Windows	Explorer
	kiuf_file_dragdrop.u_attiva(handle(dw_lista_0))
	kiuf_file_dragdrop.u_attiva(handle(dw_dett_0))


return "0"
end function

protected subroutine smista_funz (string k_par_in);//
//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===
string k_return="0 "


choose case LeftA(k_par_in, 2) 

	case "l1"		//Estrazione...
		u_import("")
		
	case "l2"		//Genera pklist
		u_genera_pklist()
		
	case else
		super::smista_funz(k_par_in)

end choose

end subroutine

protected subroutine attiva_menu ();//
//--- Attiva/Dis. Voci di menu


m_main.m_strumenti.m_fin_gest_libero1.visible = true
m_main.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
m_main.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
m_main.m_strumenti.m_fin_gest_libero1.text = "Carica dati del paking-list da file in formato CSV "
m_main.m_strumenti.m_fin_gest_libero1.microhelp = "Carica dati da CSV"
m_main.m_strumenti.m_fin_gest_libero1.enabled = true
m_main.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Carica,"+m_main.m_strumenti.m_fin_gest_libero1.text
m_main.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Insert!"

m_main.m_strumenti.m_fin_gest_libero2.visible = true
m_main.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
m_main.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
m_main.m_strumenti.m_fin_gest_libero2.text = "Genera paking-list dai dati in elenco da importare nell'applicazione. "
m_main.m_strumenti.m_fin_gest_libero2.microhelp = "Genera paking-list"
if dw_lista_0.rowcount( ) > 0 then
	m_main.m_strumenti.m_fin_gest_libero2.enabled = true
else
	m_main.m_strumenti.m_fin_gest_libero2.enabled = false
end if
m_main.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Genera,"+m_main.m_strumenti.m_fin_gest_libero2.text
m_main.m_strumenti.m_fin_gest_libero2.toolbaritemName = "join1!"

super::attiva_menu()


end subroutine

public function long u_genera_pklist ();//
long k_pklist_imported_n 
uo_ds_std_1 kds_csv


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

	kds_csv = create uo_ds_std_1
	kds_csv.dataobject = dw_lista_0.dataobject

	dw_lista_0.rowscopy(1, dw_lista_0.rowcount( ), primary!, kds_csv, 1, primary!)

	k_pklist_imported_n = kiuf_pklist_aptar.u_build_pklist(kds_csv) // GENERA PACKING-LIST
	
	if k_pklist_imported_n = 0 then 
		kguo_exception.kist_esito.sqlerrtext = "Nessun dato rilevato per la generazione del paking-list."
		throw kguo_exception
	end if
	
	if k_pklist_imported_n = 1 then 
		kguo_exception.kist_esito.sqlerrtext = "Un nuovo Packing-list importato con successo. "
	else
		kguo_exception.kist_esito.sqlerrtext = "Sono stati importati " + String(k_pklist_imported_n) + " nuovi Packing-list. " 
	end if			
	kguo_exception.messaggio_utente( )		
	messagebox("Operazione completata", kguo_exception.kist_esito.sqlerrtext)
	dw_lista_0.reset()
	dw_dett_0.reset()
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	if isvalid(kds_csv) then destroy kds_csv
	SetPointer(kkg.pointer_default)

end try

return k_pklist_imported_n
end function

public function long u_drop_file (integer a_k_tipo_drag, long a_handle);//
long k_file_nr
string k_file_drop[], k_modalita_descr


k_file_nr = kiuf_file_dragdrop.u_get_file(a_k_tipo_drag, a_handle, k_file_drop[])
if k_file_nr > 0 then	
	
	if upperbound(k_file_drop[]) > 0 then
		if k_file_drop[1] > " " then
	
			u_import(k_file_drop[1])
			
		end if
	end if
end if


return k_file_nr
end function

public function long u_import_csv2dw_lista (string a_filename) throws uo_exception;//
long k_return 
uo_ds_std_1 ads_csv


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
	ads_csv = kiuf_pklist_aptar.u_csv_import(a_filename)
	if not isvalid(ads_csv) then return k_return
	
	if ads_csv.rowcount( ) > 0 then
		dw_lista_0.dataobject = "d_xls_pklist_aptar" 
		ads_csv.rowscopy( 1, ads_csv.rowcount( ) , primary!, dw_lista_0, 1, primary!)
	else
		dw_lista_0.reset( )
	end if
	k_return = dw_lista_0.rowcount()
		
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return
end function

public function integer u_import (string a_filename);//
int k_return
string k_contract
kuf_clienti kuf1_clienti
st_tab_clienti kst_tab_clienti


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

	if isnull(a_filename) then a_filename = ""

	k_return = u_import_csv2dw_lista(a_filename)
	if k_return > 0 then
	
		k_contract = dw_lista_0.getitemstring(1, "contract_number")	
		kst_tab_clienti.e1ancodrs = left(k_contract, pos(k_contract, "_") - 1)
		
		kuf1_clienti = create kuf_clienti
		kuf1_clienti.get_codice_da_e1ancodrs(kst_tab_clienti)
		
		if kst_tab_clienti.codice > 0 then
			dw_dett_0.retrieve(kst_tab_clienti.codice)
			dw_dett_0.selectrow( 1, true)
		else
			dw_dett_0.reset()
		end if
	
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	SetPointer(kkg.pointer_default)
	if isvalid(kuf1_clienti) then destroy kuf_clienti

end try

return k_return 
end function

on w_pklist_getcsv.create
call super::create
end on

on w_pklist_getcsv.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_pklist_aptar) then destroy kiuf_pklist_aptar
end event

type dw_print_0 from w_g_tab0`dw_print_0 within w_pklist_getcsv
end type

type st_ritorna from w_g_tab0`st_ritorna within w_pklist_getcsv
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_pklist_getcsv
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_pklist_getcsv
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_pklist_getcsv
end type

type st_stampa from w_g_tab0`st_stampa within w_pklist_getcsv
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_pklist_getcsv
end type

type cb_modifica from w_g_tab0`cb_modifica within w_pklist_getcsv
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_pklist_getcsv
end type

type cb_cancella from w_g_tab0`cb_cancella within w_pklist_getcsv
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_pklist_getcsv
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_pklist_getcsv
event u_dropfiles pbm_dropfiles
boolean visible = true
integer x = 27
integer y = 1160
boolean enabled = true
string dataobject = "d_m_r_f_l_3"
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = true
boolean ki_d_std_1_attiva_cerca = true
boolean ki_select_multirows = false
boolean ki_attiva_dragdrop_solo_ins_mod = false
boolean ki_dw_visibile_in_open_window = true
end type

event dw_dett_0::u_dropfiles;//
int k_file_nr=0


k_file_nr = u_drop_file(kiuf_file_dragdrop.kki_tipo_drag_dragdrop, handle)

DragFinish (handle) 

return k_file_nr




end event

event dw_dett_0::rowfocuschanged;call super::rowfocuschanged;//
long k_clie_1, k_clie_2, k_clie_3 

if currentrow > 0 then
	k_clie_1 = this.getitemnumber(currentrow, "clie_1")
	k_clie_2 = this.getitemnumber(currentrow, "clie_2")
	k_clie_3 = this.getitemnumber(currentrow, "clie_3")
	
	dw_lista_0.event u_set_clienti_all(k_clie_1, k_clie_2, k_clie_3)
end if
end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_pklist_getcsv
boolean visible = true
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_pklist_getcsv
event u_set_clienti_all ( long a_clie_1,  long a_clie_2,  long a_clie_3 )
event u_dropfiles pbm_dropfiles
string dataobject = "d_xls_pklist_aptar"
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_select_multirows = false
boolean ki_attiva_dragdrop_solo_ins_mod = false
end type

event dw_lista_0::u_set_clienti_all(long a_clie_1, long a_clie_2, long a_clie_3);//
long k_row, k_rows


k_rows = this.rowcount( )

for k_row = 1 to k_rows
	
	this.setitem( k_row, "clie_1", a_clie_1)
	this.setitem( k_row, "clie_2", a_clie_2)
	this.setitem( k_row, "clie_3", a_clie_3)
	
next

end event

event dw_lista_0::u_dropfiles;//
int k_file_nr=0


k_file_nr = u_drop_file(kiuf_file_dragdrop.kki_tipo_drag_dragdrop, handle)

DragFinish (handle) 

return k_file_nr




end event

type dw_guida from w_g_tab0`dw_guida within w_pklist_getcsv
end type

type st_duplica from w_g_tab0`st_duplica within w_pklist_getcsv
end type

