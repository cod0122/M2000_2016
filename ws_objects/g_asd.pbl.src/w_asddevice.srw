$PBExportHeader$w_asddevice.srw
forward
global type w_asddevice from w_g_tab0
end type
type dw_asdrackcode from uo_d_std_1 within w_asddevice
end type
end forward

global type w_asddevice from w_g_tab0
integer width = 2994
integer height = 1984
string title = "_"
boolean maxbox = false
windowanimationstyle openanimation = topslide!
boolean ki_toolbar_window_presente = true
boolean ki_reset_dopo_save_ok = false
boolean ki_consenti_duplica = true
dw_asdrackcode dw_asdrackcode
end type
global w_asddevice w_asddevice

type variables
//
private kuf_asddevice kiuf_asddevice
private kuf_asdrackcode kiuf_asdrackcode
private boolean ki_rileggi_asdtype

end variables

forward prototypes
public function string inizializza ()
private function string cancella ()
protected function integer visualizza ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
protected function integer inserisci ()
private function integer modifica ()
protected subroutine open_start_window ()
private subroutine u_set_rackcode ()
public subroutine u_run_w_asdtype ()
public function boolean u_duplica () throws uo_exception
public subroutine u_resize_1 ()
protected function boolean dati_modif_1 ()
protected function string check_dati ()
public subroutine pulizia_righe ()
protected subroutine riempi_id ()
protected function boolean aggiorna_tabelle_altre () throws uo_exception
public subroutine u_run_w_asdslpt ()
public subroutine cancella_rackcode (integer a_row)
public subroutine u_run_w_asdrackbarcode (integer a_row)
end prototypes

public function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
//string k_key
long k_riga
int k_importa = 0


	setpointer(kkg.pointer_attesa)

//--- Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima 
		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)
	
	end if
			
		
	if k_importa <= 0 then // Nessuna importazione eseguita
	
		if dw_lista_0.retrieve() < 1 then
				
			k_return = "1Nessun Dispositivo Ausiliario trovato"

			setpointer(kkg.pointer_default)
			messagebox("Lista 'Dispositivi Ausiliarii' Vuota", "Nesun Codice Trovato per la richiesta fatta")
			
		else
				
			if ki_st_open_w.flag_primo_giro = "S" then 
				k_riga = 1
				//if len(trim(ki_st_tab_contratti_arg.sc_cf)) > 0 then
				//	k_riga = dw_lista_0.find( "codice = '" + string(ki_st_tab_contratti_arg.sc_cf) + "' ", 1, dw_lista_0.rowcount( ) )
				//end if
				//if k_riga > 0 then 
					dw_lista_0.selectrow( 0, false)
					dw_lista_0.scrolltorow( k_riga)
					dw_lista_0.setrow( k_riga)
					dw_lista_0.selectrow( k_riga, true)
				//end if
				
//--- se entro per modificare allora....
				if ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.modifica then 
					cb_modifica.postevent(clicked!)
				end if
			end if

		end if		
	end if

	setpointer(kkg.pointer_default)
	
return k_return



end function

private function string cancella ();//
string k_return="0 "
string k_errore = "0 "
long k_riga
st_tab_asddevice kst_tab_asddevice


try
	//=== Controllo se sul dettaglio c'e' qualche cosa
	k_riga = dw_lista_0.GetSelectedRow(0)
	if k_riga = 0 then
		k_riga = dw_lista_0.getrow()	
	end if
	if k_riga > 0 then
		kst_tab_asddevice.id_asddevice = dw_lista_0.getitemnumber(k_riga, "id_asddevice")
		kst_tab_asddevice.des = trim(dw_lista_0.getitemstring(k_riga, "des"))
	end if
	if isnull(kst_tab_asddevice.des) = true or trim(kst_tab_asddevice.des) = "" then
		kst_tab_asddevice.des = "Device Ausiliario senza descrizione" 
	end if
	
	if k_riga > 0 and not isnull(kst_tab_asddevice.id_asddevice) then	
		
	//=== Richiesta di conferma della eliminazione del rek
	
		if messagebox("Elimina Dispositivo Ausiliario", "Sei sicuro di voler Cancellare : ~n~r" &
						 + trim(kst_tab_asddevice.des) &
						 + " (" + string(kst_tab_asddevice.id_asddevice) + ")", &
					question!, yesno!, 2) = 1 then
	 
	//=== Cancella la riga dal data windows di lista
			kiuf_asddevice.tb_delete( kst_tab_asddevice )  

			kguo_sqlca_db_magazzino.db_commit()
	
	//--- cancello riga a video
			dw_lista_0.deleterow(k_riga)
	
			dw_lista_0.setfocus()
	
			attiva_tasti()
	
		else
			messagebox("Cancellazione", "Operazione Annullata !!")
		end if
	
		dw_lista_0.setcolumn(1)
	
	end if
	
catch (uo_exception kuo_exception)
		k_return = "1Errore in cancellazione. ~n~r" + kuo_exception.get_errtext( )
		kguo_sqlca_db_magazzino.db_rollback( )
	
end try

return(k_return)
//

end function

protected function integer visualizza ();//
int k_return, k_rc
long k_key
kuf_utility kuf1_utility


	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_asddevice")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione 

	k_return = dw_dett_0.retrieve( k_key ) 

//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility
	dw_dett_0.ki_flag_modalita = ki_st_open_w.flag_modalita
   kuf1_utility.u_proteggi_sproteggi_dw(dw_dett_0)

	dw_asdrackcode.ki_flag_modalita = ki_st_open_w.flag_modalita
	dw_asdrackcode.retrieve( k_key ) 
   kuf1_utility.u_proteggi_sproteggi_dw(dw_asdrackcode)

	attiva_tasti()

	dw_dett_0.SetColumn(2)

	destroy kuf1_utility

return k_return

end function

protected subroutine attiva_menu ();/*
 Attiva/Dis. Voci di menu personalizzate
*/
		
	m_main.m_strumenti.m_fin_gest_libero1.text = "Piani di Trattamento"
	m_main.m_strumenti.m_fin_gest_libero1.microhelp = &
	"Associazioni ai Piani di Trattamento"
	m_main.m_strumenti.m_fin_gest_libero1.visible = true
	m_main.m_strumenti.m_fin_gest_libero1.enabled = true
	m_main.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
	m_main.m_strumenti.m_fin_gest_libero1.toolbaritemText = "PT,"+m_main.m_strumenti.m_fin_gest_libero1.text
	m_main.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Custom093_2!"
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2

	m_main.m_strumenti.m_fin_gest_libero2.text = "Tipi Dispositivi"
	m_main.m_strumenti.m_fin_gest_libero2.microhelp = &
	"Gestione Tipi Dispositivi Ausiliari (raggruppamento)"
	m_main.m_strumenti.m_fin_gest_libero2.visible = true
	m_main.m_strumenti.m_fin_gest_libero2.enabled = (cb_inserisci.enabled or cb_modifica.enabled)
	m_main.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
	m_main.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Tipi,"+m_main.m_strumenti.m_fin_gest_libero2.text
	m_main.m_strumenti.m_fin_gest_libero2.toolbaritemName = "SelectApplication1!"
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2


//---
	super::attiva_menu()


end subroutine

protected subroutine smista_funz (string k_par_in);//

choose case k_par_in

	case KKG_FLAG_RICHIESTA.libero1
		u_run_w_asdslpt( )

	case KKG_FLAG_RICHIESTA.libero2
		u_run_w_asdtype( )

	case else
		super::smista_funz(k_par_in)

end choose



end subroutine

protected function integer inserisci ();//
int k_rc, k_ctr, k_taborder
string k_rc1, k_style
long k_riga
st_tab_clienti kst_tab_clienti
kuf_clienti kuf1_clienti
st_esito kst_esito
datawindowchild kdwc_clienti_d



	dw_dett_0.reset()

	ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento 
	
	dw_dett_0.insertrow(0)
	dw_dett_0.setcolumn(1)
	
	dw_dett_0.setitem(1, "enabled", 1)
	dw_dett_0.setitem(1, "inuso", 0)

	dw_asdrackcode.ki_flag_modalita = ki_st_open_w.flag_modalita
	dw_asdrackcode.reset()

	attiva_tasti()

	dw_dett_0.ResetUpdate ( ) 
	dw_dett_0.setfocus() 


return (0)


end function

private function integer modifica ();//
int k_return, k_rc
long k_key
kuf_utility kuf1_utility


	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_asddevice")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 

	k_return = dw_dett_0.retrieve( k_key ) 

//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility
	dw_dett_0.ki_flag_modalita = ki_st_open_w.flag_modalita
   kuf1_utility.u_proteggi_sproteggi_dw(dw_dett_0)

//--- elenco RACK code
	dw_asdrackcode.ki_flag_modalita = ki_st_open_w.flag_modalita
	k_rc = dw_asdrackcode.retrieve( k_key ) 
   kuf1_utility.u_proteggi_sproteggi_dw(dw_asdrackcode)

	attiva_tasti()

	dw_dett_0.SetColumn(2)

	destroy kuf1_utility

return k_return

end function

protected subroutine open_start_window ();//---


	kiuf_asddevice = create kuf_asddevice
	kiuf_asdrackcode = create kuf_asdrackcode
	
	dw_dett_0.event u_asdtype_retrieve()
	
end subroutine

private subroutine u_set_rackcode ();/* 
Genera un rackcode nuovo e lo imposta
*/
string k_rackcode[]
int k_row, k_ctr
int k_n_rackcode
string k_rackcode_last
//st_asdrackcode kst_asdrackcode


try

	k_n_rackcode = dw_dett_0.getitemnumber( 1, "n_rackcode") - dw_asdrackcode.rowcount( )
	
	k_rackcode_last = dw_asdrackcode.getitemstring(dw_asdrackcode.rowcount(), "rackcode")
	
	kiuf_asdrackcode.u_rackcode_generate(k_rackcode_last, k_n_rackcode, k_rackcode[] )
	
	for k_ctr = 1 to k_n_rackcode
		k_row = dw_asdrackcode.insertrow(0)
		dw_asdrackcode.setitem(k_row, "rackcode", k_rackcode[k_ctr])
		dw_asdrackcode.setitem(k_row, "enabled", 1)
	next

	attiva_tasti( )

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try
end subroutine

public subroutine u_run_w_asdtype ();//
kuf_asdtype kuf1_asdtype

ki_rileggi_asdtype = true

kuf1_asdtype = create kuf_asdtype

kuf1_asdtype.u_open(kkg_flag_modalita.visualizzazione)

destroy kuf1_asdtype
end subroutine

public function boolean u_duplica () throws uo_exception;//
//--- Operazioni di duplica che sono particolari per ogni funzione
//
int k_return, k_rc
long k_key
kuf_utility kuf1_utility


try

	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_asddevice")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento 

	k_return = dw_dett_0.retrieve( k_key ) 
	dw_dett_0.setitem(1, "id_asddevice", 0)
	dw_dett_0.setitem(1, "n_rackcode", 0)
	dw_dett_0.setitem(1, "inuso", 0)
	
	dw_dett_0.setitemstatus(1, 0, primary!, newmodified!)

//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility
	dw_dett_0.ki_flag_modalita = ki_st_open_w.flag_modalita 
   kuf1_utility.u_proteggi_sproteggi_dw(dw_dett_0)

//--- elenco RACK code
	dw_asdrackcode.ki_flag_modalita = ki_st_open_w.flag_modalita
	k_rc = dw_asdrackcode.reset( )
   kuf1_utility.u_proteggi_sproteggi_dw(dw_asdrackcode)

	destroy kuf1_utility

	ki_resize_dw_dett = true
	u_resize()
	dw_dett_0.setfocus()		
	u_personalizza_dw ()
	attiva_tasti()
	dw_dett_0.SetColumn("des")
	
catch (uo_exception kuo_exception)
	
finally
	
end try

return true
end function

public subroutine u_resize_1 ();//---
long k_height=0, k_guida_height=0, k_guida_y=0
long k_dock_x = 0, k_dock_y = -0

	
	
	this.setredraw(false)

	k_height = this.WorkSpaceHeight()

	st_orizzontal.x = 1
	st_orizzontal.height = 30
	st_orizzontal.width =	this.WorkSpaceWidth()
	if st_orizzontal.y = 0 then
		st_orizzontal.y = this.WorkSpaceHeight() * 0.9 * (1 / 2) 
	end if

//--- se tutte due le dw sono visibili allora....
	if ki_resize_dw_dett and (dw_lista_0.visible or dw_lista_0.ki_dw_visibile_in_open_window) then

		dw_lista_0.x = 1 //st_orizzontal.x 
		dw_lista_0.y = 0
		dw_dett_0.y = st_orizzontal.y + st_orizzontal.height 
		dw_dett_0.x = st_orizzontal.x
			
		dw_lista_0.height = st_orizzontal.y  - dw_lista_0.y 
		dw_dett_0.height =  k_height - st_orizzontal.y - st_orizzontal.height 
		dw_lista_0.width = st_orizzontal.width
		dw_dett_0.width = st_orizzontal.width * 0.55 - 10

		dw_asdrackcode.x = dw_dett_0.x + dw_dett_0.width + 10
		dw_asdrackcode.y = dw_dett_0.y
		dw_asdrackcode.height = dw_dett_0.height
		dw_asdrackcode.width = st_orizzontal.width * 0.55

		st_orizzontal.visible = true

	else
//--- se visibile solo una dw allora...

		st_orizzontal.visible = false
		
//--- se solo la Lista e' visibile allora....
		if dw_lista_0.visible or dw_lista_0.ki_dw_visibile_in_open_window then
			dw_lista_0.x = 1 //st_orizzontal.x 
			dw_lista_0.y = k_guida_height + k_guida_y + 5 
			dw_lista_0.width = st_orizzontal.width
			dw_lista_0.height = k_height
			
		else
//--- se solo il dettaglio e' visibile allora....
			if ki_resize_dw_dett or dw_dett_0.ki_dw_visibile_in_open_window then
				ki_resize_dw_dett = true
				dw_dett_0.x = 1 //st_orizzontal.x 
				dw_dett_0.y = k_guida_height + k_guida_y //+ 1
				dw_dett_0.width = st_orizzontal.width
				dw_dett_0.height = k_height  

				dw_asdrackcode.x = dw_dett_0.x + dw_dett_0.width + 10
				dw_asdrackcode.y = dw_dett_0.y
				dw_asdrackcode.height = dw_dett_0.height
				dw_asdrackcode.width = st_orizzontal.width * 0.45
				

			end if
		end if
	end if

	dw_dett_0.visible=ki_resize_dw_dett
	dw_asdrackcode.visible=dw_dett_0.visible

	this.setredraw(true)




end subroutine

protected function boolean dati_modif_1 ();//
//--- dati modificati?
//--- true=si; false=no
//
boolean k_boolean = false


	dati_modif_accept( )

	if dw_dett_0.u_dati_modificati() then
		k_boolean = true
	else
		if dw_asdrackcode.u_dati_modificati() then
			k_boolean = true
		end if
	end if
			
			
return k_boolean
			

end function

protected function string check_dati ();/*------------------------------------------------------------------------------------------------------
  Controllo dati 
------------------------------------------------------------------------------------------------------
*/
string k_return = " "
string k_errore = "0"
int k_err = 0
int k_row, k_rc
string k_tipo_errore="0"
int k_n_rackcode
st_tab_asdrackcode kst_tab_asdrackcode
st_esito kst_esito
//kuf_asdrackcode kuf1_asdrackcode



try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	k_err = 0
	k_row = 1

	if trim(dw_dett_0.getitemstring(k_row, "des")) > " " then
	else
		k_err ++
		k_tipo_errore="3"      // errore in questo campo: dati insuff.
		dw_dett_0.modify("des.tag = '" + k_tipo_errore + "' ")
		kst_esito.esito = kkg_esito.DATI_INSUFF
		kst_esito.sqlerrtext = "Indicare un valore nel campo '" &
				+ trim(dw_dett_0.describe(dw_dett_0.describe("des.name") + "_t.text")) &
				+ "'~n~r"  
	end if
	if dw_dett_0.getitemnumber(k_row, "id_asdtype") > 0 then
	else
		k_err ++
		k_tipo_errore="3"      // errore in questo campo: dati insuff.
		dw_dett_0.modify("id_asdtype.tag = '" + k_tipo_errore + "' ")
		kst_esito.esito = kkg_esito.DATI_INSUFF
		kst_esito.sqlerrtext = "Indicare un valore nel campo '" &
				+ trim(dw_dett_0.describe(dw_dett_0.describe("id_asdtype.name") + "_t.text")) &
				+ "'~n~r"  
	end if

	kst_tab_asdrackcode.id_asddevice = dw_dett_0.getitemnumber(k_row, "id_asddevice")
	if kst_tab_asdrackcode.id_asddevice > 0 then
//		kuf1_asdrackcode = create kuf_asdrackcode
		k_n_rackcode = dw_asdrackcode.rowcount( ) // kuf1_asdrackcode.get_rackcode_count(kst_tab_asdrackcode)
		if k_n_rackcode > dw_dett_0.getitemnumber(k_row, "n_rackcode") then
			k_err ++
			k_tipo_errore="1"
			dw_dett_0.modify("n_rackcode.tag = '" + k_tipo_errore + "' ")
			kst_esito.esito = kkg_esito.err_logico
			kst_esito.sqlerrtext = "Numero dei Rack minore dei codici rack presenti, rimuoverne " + string(k_n_rackcode - dw_dett_0.getitemnumber(k_row, "n_rackcode")) +  " se possibile!"  &
					+ "~n~r"  
		end if
	end if	
//	if dw_dett_0.getitemnumber(k_row, "package_min") > 0 and dw_dett_0.getitemnumber(k_row, "package_max") > 0 then
//		if dw_dett_0.getitemnumber(k_row, "package_min") > dw_dett_0.getitemnumber(k_row, "package_max") then
//			k_err ++
//			k_tipo_errore="1" 
//			dw_dett_0.modify("package_min.tag = '" + k_tipo_errore + "' ")
//			kst_esito.esito = kkg_esito.err_logico
//			kst_esito.sqlerrtext = "Valori incongruenti, '" &
//					+ trim(dw_dett_0.describe(dw_dett_0.describe("package_min.name") + "_t.text")) &
//					+ " maggiore del valore indicato in " + trim(dw_dett_0.describe(dw_dett_0.describe("package_max.name") + "_t.text")) &
//					+ "'~n~r"  
//		end if
//	end if

	if kst_esito.esito = kkg_esito.OK or kst_esito.esito = kkg_esito.DATI_WRN then
		if (dw_dett_0.getitemnumber(1, "n_rackcode") - dw_asdrackcode.rowcount()) > 0 then
			if messagebox("Codici Rack mancanti", "Vuoi generare subito i barcode?", question!, yesno!, 2) = 1 then
				u_set_rackcode( )
			end if
		end if
	end if
	
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

finally
//	if isnull(kuf1_asdrackcode) then destroy kuf1_asdrackcode
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

public subroutine pulizia_righe ();//
long k_row, k_rows
	
	k_rows = dw_asdrackcode.rowcount( )

	for k_row = k_rows to 1 step -1

		if dw_asdrackcode.getitemnumber(k_row, "id_asdrackcode") > 0 &
				 or trim(dw_asdrackcode.getitemstring(k_row, "rackcode")) > " " then
		else
			dw_asdrackcode.deleterow(k_row)
		end if
		if dw_asdrackcode.rowcount( ) = 0 then
			dw_asdrackcode.resetupdate( )
		end if
	next
	
	k_rows = dw_dett_0.rowcount( )

	for k_row = k_rows to 1 step -1

		if dw_dett_0.getitemnumber(k_row, "id_asddevice") > 0 &
				 or trim(dw_dett_0.getitemstring(k_row, "des")) > " " then
		else
			dw_dett_0.deleterow(k_row)
		end if
		
		if dw_dett_0.rowcount( ) = 0 then
			dw_dett_0.resetupdate( )
		end if
	next

end subroutine

protected subroutine riempi_id ();/*
Imposta valori nelle colonne prima di fare UPDATE/INSERT
*/
string k_rcx
long k_row


k_row = dw_asdrackcode.getnextmodified( k_row, primary!)
do while k_row > 0

//imposta x_datins e x_utente solitamente presenti in tutte le tabelle
	dw_asdrackcode.setitem(k_row, "x_datins", kGuf_data_base.prendi_x_datins())
	dw_asdrackcode.setitem(k_row, "x_utente", kGuf_data_base.prendi_x_utente())
	
	k_row = dw_asdrackcode.getnextmodified( k_row, primary!)
loop

k_row = dw_dett_0.getnextmodified( k_row, primary!)
do while k_row > 0

//imposta x_datins e x_utente solitamente presenti in tutte le tabelle
	dw_dett_0.setitem(k_row, "x_datins", kGuf_data_base.prendi_x_datins())
	dw_dett_0.setitem(k_row, "x_utente", kGuf_data_base.prendi_x_utente())
	
	k_row = dw_dett_0.getnextmodified( k_row, primary!)
loop
	
end subroutine

protected function boolean aggiorna_tabelle_altre () throws uo_exception;//
//=== Update delle Tabelle
boolean k_return
string k_err
//string k_return = "0 "
long k_id_asddevice
int k_row, k_n_rackcode, k_rows
st_tab_asdrackcode kst_tab_asdrackcode


// recupera il id 
		k_n_rackcode = dw_asdrackcode.rowcount( )
		k_id_asddevice = dw_dett_0.getitemnumber(1, "id_asddevice")
		if k_id_asddevice = 0 &
			   and ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
			k_id_asddevice = kiuf_asddevice.get_id_asddevice_last()
			dw_dett_0.setitem(1, "id_asddevice", k_id_asddevice)
		end if
		for k_row = 1 to k_n_rackcode
			dw_asdrackcode.setitem(k_row, "id_asddevice", k_id_asddevice)
		next
		
//--- Cancella i Rack 
		k_rows = dw_asdrackcode.DeletedCount ( )
		for k_row = k_rows to 1 step -1
			try
				kst_tab_asdrackcode.id_asdrackcode = dw_asdrackcode.getitemnumber(k_row, "id_asdrackcode", Delete!, true) 
				kst_tab_asdrackcode.rackcode = dw_asdrackcode.getitemstring(k_row, "rackcode", Delete!, true) 
				if not kiuf_asdrackcode.if_rackcode_del(kst_tab_asdrackcode) then
					kguo_exception.inizializza(this.classname())
					kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
					kguo_exception.kist_esito.sqlerrtext = "Il Rack '" + kst_tab_asdrackcode.rackcode &
								+"' è già stato associato a Barcode di Lavorazione, rimozione non consentita!"
					throw kguo_exception
				end if
				//kiuf_asdrackcode.tb_delete(kst_tab_asdrackcode)  // verifica e cancella
				//dw_asdrackcode.SetItemStatus(k_row, 0, Delete!, NotModified!)
			catch (uo_exception kuo_exception)
				dw_asdrackcode.rowsmove( k_row, 1, Delete!, dw_asdrackcode, k_n_rackcode + 1, primary!)
				kuo_exception.messaggio_utente()
			finally
				k_return = true
			end try
		next

		if dw_asdrackcode.update() <> 1 then
			kguo_exception.set_esito(dw_asdrackcode.kist_esito)			
			throw kguo_exception
		else
			dw_asdrackcode.resetupdate( )
			k_return = true
		end if

//	if k_return then
//		dw_asdrackcode.resetupdate( )
//		dw_dett_0.resetupdate( )
//	end if


return k_return



end function

public subroutine u_run_w_asdslpt ();//
kuf_asdslpt kuf1_asdslpt
st_open_w kst_open_w


kuf1_asdslpt = create kuf_asdslpt

if dw_dett_0.getrow( ) > 0 then
	kst_open_w.key1 = string(dw_dett_0.getitemnumber(dw_dett_0.getrow( ), "id_asddevice"))
	kst_open_w.flag_modalita = dw_dett_0.ki_flag_modalita
else
	if dw_lista_0.getrow( ) > 0 then
		kst_open_w.key1 = string(dw_lista_0.getitemnumber(dw_lista_0.getrow( ), "id_asddevice"))
		kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	end if
end if
		
if trim(kst_open_w.key1) > " " then		
	kuf1_asdslpt.u_open(kst_open_w)
end if

destroy kuf1_asdslpt
end subroutine

public subroutine cancella_rackcode (integer a_row);//
string k_return="0 "
int k_rows
st_tab_asdrackcode kst_tab_asdrackcode


try

	if a_row > 0 then
		
		kst_tab_asdrackcode.id_asdrackcode = dw_asdrackcode.getitemnumber(a_row, "id_asdrackcode") 
		k_rows = kiuf_asdrackcode.get_n_barcode_is_uso(kst_tab_asdrackcode)
		
		//--- se ci sono delle righe ancora in uso allora non si può rimuovere
		if k_rows > 0 then
			kst_tab_asdrackcode.rackcode = dw_asdrackcode.getitemstring(a_row, "asdrackcode") 
			messagebox("Rimozione Rack Bloccata", "Il Rack '" + kst_tab_asdrackcode.rackcode &
								+"' è associato a dei Barcode che non hanno completato la lavorazione, rimozione non consentita!", stopsign!)
		else
			
			dw_asdrackcode.deleterow(a_row)
			
			attiva_tasti( )
			
		end if
		
	end if
	
catch (uo_exception kuo_exception)
	kguo_exception.set_esito(kuo_exception.get_st_esito())
	kguo_exception.inizializza(this.classname())
	kguo_exception.kist_esito.sqlerrtext = "Rimozione del Rack '" + kst_tab_asdrackcode.rackcode + "' in errore durante il controllo ~n~r " &
										+ kuo_exception.kist_esito.sqlerrtext + " (" + string(kuo_exception.kist_esito.sqlcode) + ")"
	kguo_exception.messaggio_utente( )
	
end try




end subroutine

public subroutine u_run_w_asdrackbarcode (integer a_row);//
kuf_asdrackbarcode kuf1_asdrackbarcode
st_open_w kst_open_w


kuf1_asdrackbarcode = create kuf_asdrackbarcode

if a_row > 0 then
	kst_open_w.key1 = string(dw_asdrackcode.getitemnumber(a_row, "id_asdrackcode"))
//	if this.ki_flag_modalita = kkg_flag_modalita.inserimento or this.ki_flag_modalita = kkg_flag_modalita.modifica then
		kst_open_w.flag_modalita = dw_asdrackcode.ki_flag_modalita
//	else
//		kst_open_w.flag_modalita = dw_asdrackcode.ki_flag_modalita
//	end if
end if
		
if trim(kst_open_w.key1) > " " then		
	kuf1_asdrackbarcode.u_open(kst_open_w)
end if

destroy kuf1_asdrackbarcode
end subroutine

on w_asddevice.create
int iCurrent
call super::create
this.dw_asdrackcode=create dw_asdrackcode
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_asdrackcode
end on

on w_asddevice.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_asdrackcode)
end on

event close;call super::close;//
if isvalid(kiuf_asddevice) then destroy kiuf_asddevice
if isvalid(kiuf_asdrackcode) then destroy kiuf_asdrackcode

end event

event u_activate;call super::u_activate;//
	dw_dett_0.event u_asdtype_retrieve()

end event

type dw_print_0 from w_g_tab0`dw_print_0 within w_asddevice
end type

type st_ritorna from w_g_tab0`st_ritorna within w_asddevice
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_asddevice
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_asddevice
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_asddevice
integer x = 2350
integer y = 1348
end type

type st_stampa from w_g_tab0`st_stampa within w_asddevice
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_asddevice
integer x = 2350
integer y = 656
end type

type cb_modifica from w_g_tab0`cb_modifica within w_asddevice
integer x = 2350
integer y = 908
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_asddevice
integer x = 2350
integer y = 1200
end type

type cb_cancella from w_g_tab0`cb_cancella within w_asddevice
integer x = 2350
integer y = 1052
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_asddevice
integer x = 2350
integer y = 768
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_asddevice
event u_asdtype_retrieve ( )
integer x = 0
integer y = 832
integer width = 2272
integer height = 888
boolean enabled = true
string dataobject = "d_asddevice"
end type

event dw_dett_0::u_asdtype_retrieve();//
int k_rc
datawindowchild  kdwc_1


	ki_rileggi_asdtype = false

	this.getchild("id_asdtype", kdwc_1)
	k_rc = kdwc_1.settransobject(sqlca)
	kdwc_1.retrieve()
	k_rc = kdwc_1.insertrow(1)


end event

event dw_dett_0::clicked;call super::clicked;//
	choose case dwo.name

		case "b_n_rackcode_generate" 
			if this.ki_flag_modalita = kkg_flag_modalita.inserimento or this.ki_flag_modalita = kkg_flag_modalita.modifica then
				this.accepttext( )
				u_set_rackcode()
			end if

		case "p_add_asdtype" 
			//if this.ki_flag_modalita = kkg_flag_modalita.inserimento or this.ki_flag_modalita = kkg_flag_modalita.modifica then
				u_run_w_asdtype( )
			//end if

		case "b_asdslpt_l"
			u_run_w_asdslpt( )

	end choose

end event

event dw_dett_0::getfocus;call super::getfocus;//

if ki_rileggi_asdtype then
	
	this.event u_asdtype_retrieve( )
	
end if

end event

event dw_dett_0::buttonclicked;//

end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_asddevice
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_asddevice
integer x = 0
integer y = 0
integer width = 2866
integer height = 864
string dataobject = "d_asddevice_l"
end type

type dw_guida from w_g_tab0`dw_guida within w_asddevice
end type

type st_duplica from w_g_tab0`st_duplica within w_asddevice
end type

type dw_asdrackcode from uo_d_std_1 within w_asddevice
integer x = 2235
integer y = 804
integer height = 2000
integer taborder = 20
boolean bringtotop = true
boolean enabled = true
string dataobject = "d_asdrackcode_l"
boolean hsplitscroll = false
end type

event clicked;call super::clicked;//
string k_name


k_name = dwo.name

choose case dwo.name

	case "b_canc"  &
		, "p_canc"
		if this.ki_flag_modalita = kkg_flag_modalita.inserimento or this.ki_flag_modalita = kkg_flag_modalita.modifica then
			cancella_rackcode(row)
//			if this.getitemnumber(row, "k_associati") > 0 then
//				messagebox("Operazione bloccata", "Il Rack ha dei Brcode da trattare associati.")
//			else
//				this.deleterow(row)
//			end if
		end if

	case "b_rackbarcode"  &
		, "p_rackbarcode"
		if this.getitemnumber(row, "id_asdrackcode") > 0 then
			u_run_w_asdrackbarcode(row)			
		else
			messagebox("Operazione bloccata", "Id non generato, prima confermare il codice Rack.")
		end if

end choose

end event

event doubleclicked;//
end event

