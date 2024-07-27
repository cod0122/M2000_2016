$PBExportHeader$w_lettore_grp.srw
forward
global type w_lettore_grp from w_g_tab0
end type
type dw_modifica from uo_dw_modifica_giri_barcode within w_lettore_grp
end type
end forward

global type w_lettore_grp from w_g_tab0
integer width = 3570
integer height = 1612
string title = "Groupage da Palmare"
boolean ki_toolbar_window_presente = true
dw_modifica dw_modifica
end type
global w_lettore_grp w_lettore_grp

type variables
//
kuf_lettore_grp kiuf1_lettore_grp
private string ki_mostra_nascondi_in_lista = "S" 
private boolean ki_modifica_giri = false
private datawindow kidw_x_modifica_giri
private kuf_barcode_mod_giri kiuf_barcode_mod_giri
private string ki_modifica_cicli_enabled ="0"
private kuf_barcode kiuf_barcode
private kuf_asdrackbarcode kiuf_asdrackbarcode
end variables

forward prototypes
public function string inizializza ()
private function string cancella ()
private function integer visualizza ()
protected function string check_dati ()
protected function integer modifica ()
protected subroutine open_start_window ()
protected subroutine riempi_id ()
private subroutine modifica_giri (string k_modalita_modifica_file)
protected subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
private subroutine abilita_modifica_giri ()
public function integer u_delete_file_all ()
private function integer u_crea_groupage_rack ()
private function integer u_crea_rack (long k_row_dw_lista_0, ref string k_barcode[100]) throws uo_exception
private function integer u_crea_groupage_di_lav (long a_riga_dw_lista) throws uo_exception
private function boolean u_crea_groupage_scarta_barcode (long a_riga_dw_lista, ref string a_barcode[100])
protected subroutine u_svuota ()
private subroutine u_crea_groupage_check (long a_riga_dw_lista) throws uo_exception
private function integer u_crea_groupage_campioni (long a_riga_dw_lista) throws uo_exception
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
string k_return="0 ", k_key = " "
string k_codice 


//--- eventualmente ho passato il Barcode
	if trim(ki_st_open_w.key1) > " " then
		k_codice = trim(ki_st_open_w.key1)
	end if

	SetPointer(kkg.pointer_attesa)

//--- provo ad importare i nuovi Groupage dalla Cartella comune con il lettore
	kiuf1_lettore_grp.popola_tab_lettore_grp()

	if dw_lista_0.retrieve()  < 1 then 
		k_return = "1Nessun Groupage Trovato "

		SetPointer(kkg.pointer_default)
		
		if k_codice = "" then k_codice = "tutto"
		messagebox("Lista barcode Groupage inviati da Lettore", &
				"Nessun Codice Trovato per la richiesta fatta (" + k_codice + ") ")
	end if

	SetPointer(kkg.pointer_default)

return k_return



end function

private function string cancella ();//
string k_return="0 "
string k_descr
long k_codice
long k_riga, k_rows, k_row_pos
st_esito kst_esito
st_tab_lettore_grp kst_tab_lettore_grp


//--- cancello tutto il grp se il 'fuoco' e sul primo dw 
k_riga = dw_dett_0.rowcount()	
if k_riga = 0 then
	k_riga = dw_lista_0.rowcount()	
end if
if k_riga > 0 then
	if kidw_selezionata.dataobject = "d_lettore_grp_l" then
		dw_lista_0.setrow(dw_lista_0.getselectedrow( 0 ))
		k_row_pos = dw_lista_0.getrow( )
		if k_row_pos > 0 then
			kst_tab_lettore_grp.id = 0
			if dw_lista_0.getselectedrow( k_row_pos ) > 0 then
				k_riga = dw_lista_0.getselectedrow( 0 ) 
				do while k_riga > 0
					k_rows ++
					k_riga = dw_lista_0.getselectedrow( k_riga ) 
				loop
				k_descr = "Tutte le " + string(k_rows) + " righe selezionate " 
			else
				kst_tab_lettore_grp.padre = dw_lista_0.getitemstring(k_row_pos, "barcode")
				kst_tab_lettore_grp.timestamp_inizio = dw_lista_0.getitemstring(k_row_pos, "timestamp_inizio")
				k_descr = "L'intero Groupade del Barcode padre " +  kst_tab_lettore_grp.padre
			end if
		end if
	else
		dw_dett_0.setrow(dw_dett_0.getselectedrow( 0 ))
		k_row_pos = dw_dett_0.getrow( )
		kst_tab_lettore_grp.id = dw_dett_0.getitemnumber(k_row_pos, "id")
		kst_tab_lettore_grp.padre = ""
		kst_tab_lettore_grp.timestamp_inizio = ""
		k_descr = "il solo Barcode Figlio " +  dw_dett_0.getitemstring(k_row_pos, "barcode")
	end if
end if

if isnull(k_descr) = true or trim(k_descr) = "" then
	k_descr = "Nessuna denominazione" 
end if

if k_row_pos > 0 and isnull(k_codice) = false then	
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina Groupage", "Sei sicuro di voler Cancellare il~n~r" &
				+ "~n~r" + trim(k_descr), &
				question!, yesno!, 2) = 1 then

		try
	 		setpointer(kkg.pointer_attesa)
		 
//=== Cancella !!!
			if kst_tab_lettore_grp.id > 0 then
				kiuf1_lettore_grp.tb_delete(kst_tab_lettore_grp) 
			else
				
				k_riga = dw_lista_0.getselectedrow( 0 ) 
				do while k_riga > 0
					kst_tab_lettore_grp.padre = dw_lista_0.getitemstring(k_riga, "barcode")
					kst_tab_lettore_grp.timestamp_inizio = dw_lista_0.getitemstring(k_riga, "timestamp_inizio")
	
					kiuf1_lettore_grp.tb_delete_all(kst_tab_lettore_grp) 
					
					k_riga = dw_lista_0.getselectedrow( k_riga ) 
				loop
				
			end if

			if kidw_selezionata.dataobject = "d_lettore_grp_l" then
				
//--- cancello riga a video
				dw_lista_0.retrieve( ) 
				dw_dett_0.reset()
//				for k_riga = dw_lista_0.rowcount() to 1 step -1
//					
//					if kst_tab_lettore_grp.padre = dw_lista_0.getitemstring(k_riga, "barcode") then
//						k_riga_del = k_riga
//						dw_lista_0.deleterow(k_riga_del)
//					end if
//					
//				next
				dw_lista_0.selectrow(0, false)
				if k_row_pos > dw_lista_0.rowcount() then
					k_row_pos = dw_lista_0.rowcount()
				else
					k_riga = k_row_pos
				end if
				if k_riga > 0 then
					dw_lista_0.selectrow(k_riga, true)
					dw_lista_0.setrow(k_riga)
					dw_lista_0.scrolltorow(k_riga)
					dw_lista_0.setfocus()
				end if
				//dw_dett_0.reset( )

			else
				
				if k_row_pos > 0 then
					dw_dett_0.deleterow(k_row_pos)
				end if
				if dw_dett_0.rowcount() > 0 then
					if k_row_pos > dw_dett_0.rowcount() then
						k_riga = dw_dett_0.rowcount()
					else
						k_riga = k_row_pos
					end if
					if k_riga > 0 then
						dw_dett_0.selectrow(k_riga, true)
						dw_dett_0.setrow( k_riga)
					end if
					dw_dett_0.setfocus( )
				else
					dw_lista_0.setfocus( )
				end if
			end if

		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
	
			k_return = "1"
			messagebox("Errore in Cancellazione", &
								"Operazione fallita. Errore (" + string(kst_esito.esito) + ")" + kkg.acapo + trim(kst_esito.sqlerrtext), &
								stopsign!) 	

		finally
			attiva_tasti()
	
			setpointer(kkg.pointer_default)
			
		end try

	else
		messagebox("Elimina Groupage", "Operazione Annullata !!")
	end if

//	dw_dett_0.setcolumn(1)

end if

return(k_return)
end function

private function integer visualizza ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return
st_tab_lettore_grp kst_tab_lettore_grp
kuf_utility kuf1_utility


	kst_tab_lettore_grp.padre = dw_lista_0.getitemstring(dw_lista_0.getrow(), "barcode")
	kst_tab_lettore_grp.timestamp_inizio = dw_lista_0.getitemstring(dw_lista_0.getrow(), "timestamp_inizio")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 

	dw_dett_0.reset( )
	k_return = dw_dett_0.retrieve( kst_tab_lettore_grp.padre, kst_tab_lettore_grp.timestamp_inizio  ) 
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione 

//--- protezione campi per visual
	kuf1_utility = create kuf_utility 
	kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
	destroy kuf1_utility	

	attiva_tasti() 

return k_return

end function

protected function string check_dati ();//
//=== Controllo dati inseriti
string k_return = ""
string k_errore = "0"
int k_rc=0
long k_riga
//string k_key, k_rag_soc_10
//string k_descr, k_mc_co = "", k_sc_cf=""
//long k_codice, k_codice_1, k_clie
//string k_rag_soc




	k_riga = dw_dett_0.getrow()



	if isnull(dw_dett_0.getitemstring ( k_riga, "barcode")) then
		k_return = k_return + "Manca il barcode figlio '" + &
		             trim(dw_dett_0.object.descr_t.text) + "'~n~r" 
		k_errore = "3"
	end if


//--- 	
	if k_return = "" or isnull(k_return) then
		k_return = "  "
	end if

return trim(k_errore) + trim(k_return)


end function

protected function integer modifica ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_rc,  k_ctr, k_taborder
string k_style, k_rc1
long k_key
st_tab_lettore_grp kst_tab_lettore_grp
kuf_utility kuf1_utility	

//datawindowchild kdwc_clienti_d

	kst_tab_lettore_grp.padre = dw_lista_0.getitemstring(dw_lista_0.getrow(), "barcode")
	kst_tab_lettore_grp.timestamp_inizio = dw_lista_0.getitemstring(dw_lista_0.getrow(), "timestamp_inizio")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 

	k_return = dw_dett_0.retrieve( kst_tab_lettore_grp.padre, kst_tab_lettore_grp.timestamp_inizio  ) 

//--- Attivo ddw 
	datawindowchild kdwc_1
	k_rc = dw_dett_0.getchild("barcode", kdwc_1)
	k_rc = kdwc_1.settransobject(sqlca)
	if kdwc_1.rowcount() = 0 then
		kdwc_1.retrieve("*", 0, 0, 0, 0)
	end if

//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility 
	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
//--- disabilita la modifica sul codice
	kuf1_utility.u_proteggi_dw("1", 1, dw_dett_0)
	destroy kuf1_utility	

	attiva_tasti()

	dw_dett_0.SetColumn(9)


return k_return

end function

protected subroutine open_start_window ();//
kiuf1_lettore_grp = create kuf_lettore_grp
kiuf_barcode_mod_giri = create kuf_barcode_mod_giri
kiuf_barcode = create kuf_barcode
kiuf_asdrackbarcode = create kuf_asdrackbarcode

//--- abilito la mod dei giri su barcode?
abilita_modifica_giri()




end subroutine

protected subroutine riempi_id ();//
long k_riga=0
int k_rc

//--- imposta campi automatici
if dw_dett_0.rowcount( ) > 0 then
	k_riga = dw_dett_0.getselectedrow( 0 )
	if k_riga = 0 then
		k_riga = 1
		dw_dett_0.selectrow( k_riga, true)
	end if
	k_rc=dw_dett_0.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
	k_rc=dw_dett_0.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
end if


end subroutine

private subroutine modifica_giri (string k_modalita_modifica_file);//
//--- k_modalita_modifica_file: 1=modalità modifica giri fila 1 e 2 
//
integer k_rec, k_riga
string k_dw_fuoco_nome
string k_aggiorna_rif
line kline_1
st_esito kst_esito
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode
datawindow kidw_barcode_da_non_modificare


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())

//--- valorizza la dw sulla quale fare la modifica
	kidw_x_modifica_giri = kidw_selezionata
	setnull(kidw_barcode_da_non_modificare)

	dw_modifica.ki_modif_tutto_riferimento = kiuf_barcode_mod_giri.ki_modif_tutto_riferimento_no
	
	k_dw_fuoco_nome = kidw_selezionata.dataobject 

	choose case k_dw_fuoco_nome

		//case "d_lettore_grp_padri_l"
		case "d_lettore_grp_l"
			k_riga = dw_lista_0.getselectedrow( 0)
			if k_riga > 0 then
				kst_tab_barcode.barcode = dw_lista_0.object.barcode[k_riga]
			end if
			
		case "d_lettore_grp_figli_l"
			k_riga = dw_dett_0.getselectedrow( 0)
			if k_riga > 0 then
				kst_tab_barcode.barcode = dw_dett_0.object.barcode[k_riga]
			end if

	end choose

//--- leggo barcode				
	kiuf_barcode.select_barcode (kst_tab_barcode)

	if k_riga > 0 then

		dw_modifica.modifica_giri(&
										kst_tab_barcode &
										,k_modalita_modifica_file &
										,dw_modifica.ki_modif_tutto_riferimento &
										,kidw_x_modifica_giri &
										,kidw_barcode_da_non_modificare &
										)
										
		
	else
		messagebox("Modifica Cicli di Trattamento", &
						"Selezionare una riga nella lista")
	end if	

catch (uo_exception kuo_exception)
	messagebox("Modifica Giri in errore", &
					"Si è verificato un errore in elaborazione dati. " + kkg.acapo + kuo_exception.kist_esito.sqlerrtext)
	
finally
	SetPointer(kkg.pointer_default)

end try

end subroutine

protected subroutine smista_funz (string k_par_in);//---
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===

choose case LeftA(k_par_in, 2) 


	case KKG_FLAG_RICHIESTA.libero1		//Importa i nuovi GRP
		leggi_liste()


	case KKG_FLAG_RICHIESTA.libero2		//modifica i cilci del riferimento
		modifica_giri(kiuf_barcode_mod_giri.ki_modalita_modifica_giri_riga)

	case KKG_FLAG_RICHIESTA.libero5		//rigenera tabella e delete all file
		u_svuota( )

	case KKG_FLAG_RICHIESTA.libero8		//Mette i Barcode in GRP o su Rack
		u_crea_groupage_rack()



	case else // standard
		super::smista_funz(k_par_in)
		
end choose



end subroutine

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu


//--- ricopre lo standard
	if not m_main.m_finestra.m_fin_dettaglio.enabled then
		m_main.m_finestra.m_fin_dettaglio.enabled = true
		m_main.m_finestra.m_fin_dettaglio.toolbaritemvisible = true
	end if


//
//--- Attiva/Dis. Voci di menu personalizzate
//
//if not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
//	ki_menu.m_strumenti.m_fin_gest_libero1.text = "Importa nuovi Groupage del Palmare"
//	ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = "Importa nuovi Groupage del Palmare"
//	ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
//	ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
//	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
//	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Importa,Importa nuovi Groupage del Palmare"+ki_menu.m_strumenti.m_fin_gest_libero1.text
//	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Regenerate!"
//	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
//end if	

if not m_main.m_strumenti.m_fin_gest_libero2.visible then
	m_main.m_strumenti.m_fin_gest_libero2.text = "&Cicli di Lavorazione"
	m_main.m_strumenti.m_fin_gest_libero2.microhelp = 	"Visualizza/Modifica i cicli di trattamento del Barcode/intero Riferimento di Entrata   "
	m_main.m_strumenti.m_fin_gest_libero2.enabled = ki_modifica_giri
	m_main.m_strumenti.m_fin_gest_libero2.toolbaritemtext = "Giri,"+ m_main.m_strumenti.m_fin_gest_libero2.text
	m_main.m_strumenti.m_fin_gest_libero2.toolbaritemvisible = true
	m_main.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
	//ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemname = kGuo_path.get_risorse() + "\cicli.bmp"
	m_main.m_strumenti.m_fin_gest_libero2.toolbaritemname = "cicli16.png"
	m_main.m_strumenti.m_fin_gest_libero2.visible = true
end if

if not m_main.m_strumenti.m_fin_gest_libero5.visible then
	m_main.m_strumenti.m_fin_gest_libero5.text = "&Svuota Tabella e Cartella dei file"
	m_main.m_strumenti.m_fin_gest_libero5.microhelp = "Svuota elenco e cancella i file dalla cartella dei Groupage generati dai lettori di barcode"
	m_main.m_strumenti.m_fin_gest_libero5.enabled = true
	m_main.m_strumenti.m_fin_gest_libero5.toolbaritemtext = "Svuota,"+ m_main.m_strumenti.m_fin_gest_libero5.text
	m_main.m_strumenti.m_fin_gest_libero5.toolbaritemvisible = true
	m_main.m_strumenti.m_fin_gest_libero5.toolbaritembarindex=2
	//ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemname = kGuo_path.get_risorse() + "\cicli.bmp"
	m_main.m_strumenti.m_fin_gest_libero5.toolbaritemname = "Delete_2!"
	m_main.m_strumenti.m_fin_gest_libero5.visible = true
end if

if not m_main.m_strumenti.m_fin_gest_libero8.visible then
	m_main.m_strumenti.m_fin_gest_libero8.text = "Crea il Groupage e Rack, aggiorna i Barcode "
	m_main.m_strumenti.m_fin_gest_libero8.microhelp =  "Crea il Groupage e associa eventuale Schermatura (aggiorna i Barcode)"
	m_main.m_strumenti.m_fin_gest_libero8.visible = true
	m_main.m_strumenti.m_fin_gest_libero8.enabled = true
	m_main.m_strumenti.m_fin_gest_libero8.toolbaritemVisible = true
	m_main.m_strumenti.m_fin_gest_libero8.toolbaritemText = "Crea,"+m_main.m_strumenti.m_fin_gest_libero8.text
	m_main.m_strumenti.m_fin_gest_libero8.toolbaritemName = "Group_2!"
	m_main.m_strumenti.m_fin_gest_libero8.toolbaritembarindex=2
end if	


//---
	super::attiva_menu()



end subroutine

private subroutine abilita_modifica_giri ();//
//--- controllo autorizzazione x cambio giri di lavorazione
//

	try 

		ki_modifica_giri = kiuf_barcode_mod_giri.autorizza_modifica_giri(dw_modifica.ki_modifica_giri_pianificati)
	
		if ki_modifica_cicli_enabled = kiuf_barcode_mod_giri.ki_modifica_cicli_enabled_modif &
			and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.inserimento &
			and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.modifica then
			ki_modifica_cicli_enabled = kiuf_barcode_mod_giri.ki_modifica_cicli_enabled_visualizzazione
		end if


	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()			
		ki_modifica_giri = false
		ki_modifica_cicli_enabled = kiuf_barcode_mod_giri.ki_modifica_cicli_enabled_visualizzazione
		
	finally			
	end try

end subroutine

public function integer u_delete_file_all ();//
int k_return
int k_resp, k_file_deleted


try
	

	setpointer(kkg.pointer_attesa)

	k_file_deleted = kiuf1_lettore_grp.u_delete_file_all( )
	
	setpointer(kkg.pointer_default)
	
	k_return = k_file_deleted
	

catch(uo_exception kuo_exception)
	setpointer(kkg.pointer_default)
	messagebox("Operazione Interrotta", "Si sono verificati degli errori durante la cancellazione dei file di groupage. Errore: " + trim(kuo_exception.get_errtext( )) , information!)

end try

return k_return

end function

private function integer u_crea_groupage_rack ();/*
 Costruisce Groupage e Rack con i Barcode passati dal Lettore esterno
 rit: numero associazioni
*/
integer k_return = 0
long k_riga_dw_lista=0 
integer k_nr_bcode, k_nr_bcode_rack, k_nr_bcode_campioni
string k_barcode_ok_from_rack[100]
string k_msg
st_tab_asdrackbarcode kst_tab_asdrackbarcode
st_tab_lettore_grp kst_tab_lettore_grp
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	k_riga_dw_lista = dw_lista_0.getselectedrow(0)
	if k_riga_dw_lista > 0 then
	
	else
		kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_generico )
		kguo_exception.setmessage( "Selezionare almeno una riga dall'elenco ")
		throw kguo_exception
	end if
	
	do while k_riga_dw_lista > 0 

		dw_lista_0.setrow( k_riga_dw_lista )  //--- mette il fuoco x fare il VISUALIZZA()
		
		if visualizza( ) > 0 then  // legge il Groupage (barcode e eventuali rack)
		
			kst_tab_lettore_grp.padre = trim(dw_lista_0.object.barcode[k_riga_dw_lista])
			kst_tab_lettore_grp.timestamp_inizio = trim(dw_lista_0.object.timestamp_inizio[k_riga_dw_lista])
		
			//--- Verifica bontà del GROUPAGE 
			u_crea_groupage_check(k_riga_dw_lista)
		
			//--- scopre se il GRP contiene il codice RACK 
			if dw_dett_0.find("id_asdrackcode > 0", 0, dw_dett_0.rowcount()) > 0 then
				k_nr_bcode_rack += u_crea_rack(k_riga_dw_lista, k_barcode_ok_from_rack[])  // associa barcode e rack
				if k_barcode_ok_from_rack[1] > " " then
					u_crea_groupage_scarta_barcode(k_riga_dw_lista, k_barcode_ok_from_rack[])  // scarta i Barcode non coerenti con il Rack
				end if
			end if
		
			//--- scopre se il GRP contiene i codici CAMPIONI 
			if dw_dett_0.find("id_armo_campione > 0", 0, dw_dett_0.rowcount()) > 0 then
				k_nr_bcode_campioni += u_crea_groupage_campioni(k_riga_dw_lista)   // associa barcode Controcampioni
			end if

		//--- genera il 'classico' GRP
			k_nr_bcode += u_crea_groupage_di_lav(k_riga_dw_lista)   // BUILD GROUPAGE DI BARCODE DI LAVORAZIONE
			
			dw_lista_0.setitem(k_riga_dw_lista, "k_importato", 1)  // mostra ope OK!
			dw_lista_0.setitem(k_riga_dw_lista, "k_esito", "Barcode elaborati correttamente" )  // mostra esito di errore

		end if
			
//--- Toglie dall'archivio  LETTORE_GRP  il GRP  appena  impostato nei Barcode
		kst_tab_lettore_grp.st_tab_g_0.esegui_commit = "S"
		kiuf1_lettore_grp.tb_delete_all(kst_tab_lettore_grp)

//--- Rimuove il groupage di barcode già importati (OVVERO CON LO STESO PADRE + TIMESTAMP)
		k_riga_dw_lista = dw_lista_0.find("barcode = '" + kst_tab_lettore_grp.padre + "' and timestamp_inizio = '" + string(kst_tab_lettore_grp.timestamp_inizio) + "'", 0, dw_lista_0.rowcount( ))
		do while k_riga_dw_lista > 0
			dw_lista_0.deleterow(k_riga_dw_lista)
			k_riga_dw_lista = dw_lista_0.find("barcode = '" + kst_tab_lettore_grp.padre + "' and timestamp_inizio = '" + string(kst_tab_lettore_grp.timestamp_inizio) + "'", 0, dw_lista_0.rowcount( ))
		loop
			
		k_riga_dw_lista = dw_lista_0.getselectedrow( 0 )
	
	loop
	
	if k_nr_bcode > 0 or k_nr_bcode_rack > 0 or k_nr_bcode_campioni > 0 then
		k_msg = "Sono stati associati: " 
		if k_nr_bcode > 0  then
			k_msg += kkg.acapo + string(k_nr_bcode) + " Barcode di Lavorazione in Groupage; " 
		end if
		if k_nr_bcode_rack > 0 then
			k_msg += kkg.acapo + string(k_nr_bcode_rack) + " Schermature (rackcode); "
		end if
		if k_nr_bcode_campioni > 0 then
			k_msg += kkg.acapo + string(k_nr_bcode_campioni) + " Controcampioni "
		end if
	else
		k_msg = "Nessun Barcode di lavorazione è stato associato a Groupage e/o Schermato e/o a colli Campione." 
	end if
	messagebox("Operazione Conclusa", k_msg)

	k_return = k_nr_bcode + k_nr_bcode_rack + k_nr_bcode_campioni

catch (uo_exception kuo_exception)
	if k_riga_dw_lista > 0 then
		dw_lista_0.setitem(k_riga_dw_lista, "k_importato", 2)  // mostra ope in errore
		dw_lista_0.setitem(k_riga_dw_lista, "k_esito", kuo_exception.get_errtext( ) )  // mostra esito di errore
	end if
	kuo_exception.messaggio_utente( )
	
end try

return k_return


end function

private function integer u_crea_rack (long k_row_dw_lista_0, ref string k_barcode[100]) throws uo_exception;/*
 Crea il RACK con i Barcode di Lavorazione (se tutto ok!)
    Out: array dei barcode da mettere in Groupage (k_barcode)
    ret: nr. barcode associati ai Rack  
*/
integer k_return
int k_rows_rack, k_rows_barcode, k_rows_add, k_row_rack, k_row_barcode, k_row_barcode_ok
boolean k_barcode_ok
st_tab_lettore_grp kst_tab_lettore_grp
st_tab_asdrackbarcode kst_tab_asdrackbarcode[], kst_tab_asdrackbarcode1
st_tab_asddevice kst_tab_asddevice
st_esito kst_esito
uo_ds_std_1 kds_1, kds_2


try 
		
	kds_1 = create uo_ds_std_1
	kds_1.dataobject = "ds_lettore_grp_rack_l"
	kds_1.settransobject( kguo_sqlca_db_magazzino )

	kds_2 = create uo_ds_std_1
	kds_2.dataobject = "ds_lettore_grp_barcode_rack_l"
	kds_2.settransobject( kguo_sqlca_db_magazzino )
		
	kst_tab_lettore_grp.timestamp_inizio = trim(dw_lista_0.object.timestamp_inizio[k_row_dw_lista_0])
	kst_tab_lettore_grp.padre = trim(dw_lista_0.object.barcode[k_row_dw_lista_0])
	
	k_rows_rack = kds_1.retrieve(kst_tab_lettore_grp.padre, kst_tab_lettore_grp.timestamp_inizio) // recupero i Rack dal groupage
	k_rows_barcode = kds_2.retrieve(kst_tab_lettore_grp.padre, kst_tab_lettore_grp.timestamp_inizio) // recupero i barcode del groupage (rack compresi)
	

	for k_row_barcode = 1 to k_rows_barcode // scorre i barcode da mettere nel Rack
			
		if kds_2.getitemnumber(k_row_barcode, "id_asdrackcode") > 0 or kds_2.getitemnumber(k_row_barcode, "id_armo_campione") > 0 then // Scarta il RACK e i CAMPIONI stesso
		else

			kst_tab_asdrackbarcode1.barcode = kds_2.getitemstring(k_row_barcode, "barcode")  // get barcode di lav

			k_barcode_ok = true   // barcode coerente con il rack?
			for k_row_rack = 1 to k_rows_rack // CONTROLLO RACK-Barcode: scorre i Rack presenti nel groupage

				kst_tab_asdrackbarcode1.id_asdrackcode = kds_1.getitemnumber(k_row_rack, "id_asdrackcode") // recupero il RACK
			
//--- controllo se il barcode di lav coerente con il Rack e quindi può essere aggiunto 
				if not kiuf_asdrackbarcode.if_add_barcode(kst_tab_asdrackbarcode1) then
					k_barcode_ok = false // bacode NON coerente con i Rack
					kst_tab_asddevice.id_asddevice = kds_1.getitemnumber(k_row_rack, "id_asddevice") // recupera ID del Dispositivo
					kguo_exception.inizializza( this.classname())
					kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_non_eseguito)
					kguo_exception.setmessage( "Genera Rack", "Operazione interrotta, Schermatura (id disp." &
										+ string(kst_tab_asddevice.id_asddevice) + ") associata al barcode '" & 
										+ trim(kst_tab_asdrackbarcode1.barcode) + "' non prevista o errata dal Piano di Trattamento!")
					throw kguo_exception
					//exit
	
				end if
			
			next
			if k_barcode_ok then 
				k_row_barcode_ok ++
				if k_row_barcode_ok > 100 then 
					kguo_exception.inizializza( this.classname())
					kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_non_eseguito)
					kguo_exception.setmessage( "Genera Rack", "Operazione interrotta, superato il limite (" + string(k_row_barcode_ok) + ") del numero dei Barcode del groupage! " &
										+ " Ultimo barcode caricato " + trim(k_barcode[k_row_barcode_ok - 1]) )
					kguo_exception.scrivi_log( )
					exit
				end if
				
				k_barcode[k_row_barcode_ok] = kst_tab_asdrackbarcode1.barcode  // Carica in array il barcode verificato del Groupage
				for k_row_rack = 1 to k_rows_rack // CARICA array: scorre i Rack presenti nel groupage
					kst_tab_asdrackbarcode1.id_asdrackcode = kds_1.getitemnumber(k_row_rack, "id_asdrackcode") // recupero il RACK
					k_rows_add ++
					kst_tab_asdrackbarcode[k_rows_add] = kst_tab_asdrackbarcode1  // salva i barcode da aggiungere al Rack e al Groupage
				next
			end if
		end if
		
	next		
	
	if k_rows_add > 0 then
		
		if kiuf_asdrackbarcode.u_add_barcode(kst_tab_asdrackbarcode[]) then   // ADD join rack-barcode al rack nel DB
			k_return = k_rows_add
		end if
		
	end if

//	//--- Toglie dall'archivio  LETTORE_GRP la riga appena elaborata
//		kst_tab_lettore_grp.padre = ""
//		kst_tab_lettore_grp.timestamp_inizio = kst_tab_lettore_grp.timestamp_inizio
//		kst_tab_lettore_grp.st_tab_g_0.esegui_commit = "N"
//		kst_esito = kiuf1_lettore_grp.tb_delete_all(kst_tab_lettore_grp)

	
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kds_1) then destroy kds_1
	if isvalid(kds_2) then destroy kds_2
	
end try


return k_return


end function

private function integer u_crea_groupage_di_lav (long a_riga_dw_lista) throws uo_exception;//---
//--- Mette in Groupage i Barcode di Lavorazione (se tutto ok!)
//---
integer k_return = 0
long k_row, k_rows
integer k_nr_bcode
st_tab_barcode kst_tab_barcode_figlio, kst_tab_barcode_padre
st_esito kst_esito


try

	kst_esito = kguo_exception.inizializza(this.classname())

	kst_tab_barcode_padre.pl_barcode = dw_lista_0.object.pl_barcode[a_riga_dw_lista]
	kst_tab_barcode_padre.barcode = trim(dw_lista_0.object.barcode[a_riga_dw_lista])

//--- Se tutto OK aggiunge il GRP
	k_rows = dw_dett_0.rowcount( )
	for k_row = 1 to k_rows

		// i RACK e i CONTROCAMPIONI qui li scarta NON VANNO IN GRP
		if dw_dett_0.object.id_asdrackcode[k_row] > 0 &
						or dw_dett_0.getitemnumber(k_row, "id_armo_campione") > 0 then
		else
				
			kst_tab_barcode_figlio.barcode = trim(dw_dett_0.object.barcode[k_row])
			kst_tab_barcode_figlio.barcode_lav = kst_tab_barcode_padre.barcode
			
			kst_esito = kiuf_barcode.tb_aggiungi_figlio(kst_tab_barcode_figlio) // AGGIUNGE BARCODE AL GRP
			if kst_esito.esito = kkg_esito.ok then
				k_nr_bcode++  // semplicemente il nr barcode associati correttamente al PADRE						
			else
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if

	end for
	
	if k_nr_bcode > 0 then

		kguo_sqlca_db_magazzino.db_commit( )
		
	end if
	
catch (uo_exception kuo_exception)
	//if a_riga_dw_lista > 0 then
		//dw_lista_0.setitem(a_riga_dw_lista, "k_importato", 2)  // mostra ope in errore
	//end if
	//kuo_exception.messaggio_utente()
	kguo_sqlca_db_magazzino.db_rollback( )
	throw kuo_exception


finally
	dw_dett_0.reset( )
	

end try


return k_nr_bcode


end function

private function boolean u_crea_groupage_scarta_barcode (long a_riga_dw_lista, ref string a_barcode[100]);//---
//--- Rimuove dal Groupage i Barcode non presenti nell'array 
//--- Inp: array dei barcode che OK se Rack
//--- ret: true = ok ci sono barcode da mettere in groupage
//---
boolean k_return 
long k_riga_figli=0
integer k_row_barcode
st_tab_barcode kst_tab_barcode_figlio, kst_tab_barcode_padre
boolean k_barcode_ok


try
	kst_tab_barcode_padre.pl_barcode = dw_lista_0.object.pl_barcode[a_riga_dw_lista]
	kst_tab_barcode_padre.barcode = trim(dw_lista_0.object.barcode[a_riga_dw_lista])

//--- controllo presenza del barcode PADRE 
	for k_row_barcode = 1 to 100
		if a_barcode[k_row_barcode] > " " then
			if trim(a_barcode[k_row_barcode]) = trim(kst_tab_barcode_padre.barcode) then
				k_barcode_ok = true
				exit
			end if
		else
			exit
		end if
	next

	if k_barcode_ok then 
		
//--- piglia i dati del padre
		kiuf_barcode.get_barcode_dati_trattamento(kst_tab_barcode_padre)

//--- controllo presenza del barcode FIGLI
		for k_riga_figli = 1 to dw_dett_0.rowcount( )
		
			if dw_dett_0.object.id_asdrackcode[k_riga_figli] > 0 then // i RACK qui li scarta NON VANNO IN GRP
				dw_dett_0.deleterow(k_riga_figli)
				k_riga_figli --
			elseif dw_dett_0.object.id_armo_campione[k_riga_figli] > 0 then // i CAMPIONI qui non li considera. SCARTA
			else
		// elabora i barcode di LAVVORAZIONE FIGLI
				kst_tab_barcode_figlio.barcode = dw_dett_0.object.barcode[k_riga_figli]

//--- controllo presenza del barcode FIGLIO
				k_barcode_ok = false
				for k_row_barcode = 1 to 100
					if a_barcode[k_row_barcode] > " " then
						if trim(a_barcode[k_row_barcode]) = trim(kst_tab_barcode_figlio.barcode) then
							k_return = true
							k_barcode_ok = true
							exit
						end if
					else
						exit
					end if
				next
				if not k_barcode_ok then 					
					dw_dett_0.deleterow(k_riga_figli)
					k_riga_figli --
				end if
			end if
		next

	end if
	
catch (uo_exception kuo_exception)
	//kst_esito = kuo_exception.get_st_esito()

end try
	
	
return k_return


end function

protected subroutine u_svuota ();//
//--- svuota la tabella e Cartella dei Groupage importati dai lettori del Groupage
//
int k_resp, k_file_deleted
string k_msg


try

	k_resp = messagebox("Svuota area dati da Lettore Groupage", "Procedere con la rimozione di TUTTI i dati dei Groupage importati dal Lettore (Tabella e File).~r~n" &
						+ "Nel caso, bisogna rileggere con il Lettore i Groupage cancellati ma non ancora elaborati.", question!, yesno!, 2) 
	if k_resp = 1 then

		kiuf1_lettore_grp.tb_truncate( )	
		
		k_file_deleted = u_delete_file_all( )

		if k_file_deleted > 0 then
			messagebox("Operazione Conclusa", "Inizializzazione della tabella eseguita correttamente.~r~nInoltre, Sono stati cancellati " + string(k_file_deleted) + " file.", information!)
		else
			messagebox("Operazione Conclusa", "Inizializzazione della tabella eseguita correttamente.~r~nNon sono stati trovati file da cancellare.", information!)
		end if
	
		dw_lista_0.retrieve( )
		dw_dett_0.reset()
	
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try



end subroutine

private subroutine u_crea_groupage_check (long a_riga_dw_lista) throws uo_exception;//---
//--- Controllo se tutto ok per fare il Groupage 
//---
long k_row, k_rows
st_tab_barcode kst_tab_barcode_figlio, kst_tab_barcode_padre
st_esito kst_esito


try

	kst_esito = kguo_exception.inizializza(this.classname())

	kst_tab_barcode_padre.pl_barcode = dw_lista_0.object.pl_barcode[a_riga_dw_lista]
	kst_tab_barcode_padre.barcode = trim(dw_lista_0.object.barcode[a_riga_dw_lista])
		
	if not kiuf_barcode.if_da_trattare(kst_tab_barcode_padre) then
		kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_not_fnd )
		kguo_exception.setmessage( "Il Barcode padre '" + trim(kst_tab_barcode_padre.barcode) + "' non è tra quelli ancora da Trattare. Operazione interrotta")
		throw kguo_exception
	end if

//--- controllo se il barcode può essere PADRE 
	if not kiuf_barcode.if_essere_barcode_padre(kst_tab_barcode_padre) then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlerrtext = "Barcode Padre non possibile: " + kst_tab_barcode_padre.barcode 
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
				
//--- piglia i dati del padre
	kiuf_barcode.get_barcode_dati_trattamento(kst_tab_barcode_padre)

//--- controlla se GRP possibile			
	k_rows = dw_dett_0.rowcount( )
	for k_row = 1 to k_rows
		
		if dw_dett_0.object.id_asdrackcode[k_row] > 0 then // i RACK qui li scarta NON VANNO IN GRP
		elseif dw_dett_0.object.id_armo_campione[k_row] > 0 then // qui controlla i CONTROCAMPIONI 
		
			// il Controcampione deve appartenere al Lotto del PADRE
			if dw_dett_0.object.armo_campioni_id_armo[k_row] <> dw_dett_0.object.id_armo[k_row] then
				kst_esito.esito = kkg_esito.ko
				kst_esito.sqlerrtext = "Controcampione " + trim(kst_tab_barcode_figlio.barcode) &
									+ " non appartiene al Lotto del barcode PADRE " &
									+ trim(kst_tab_barcode_padre.barcode) &
									+ " (" + string(dw_dett_0.object.armo_campioni_id_armo[k_row]) + "<>" + string(dw_dett_0.object.id_armo[k_row]) + ")" &
									+ ", associazione non consentita! " 
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		
		else  // infine Controlla i barcode da TRATTARE

			kst_tab_barcode_figlio.barcode = trim(dw_dett_0.object.barcode[k_row])
			kst_tab_barcode_figlio.tipo_cicli = dw_dett_0.object.barcode_tipo_cicli[k_row]
			kst_tab_barcode_figlio.pl_barcode = dw_dett_0.object.pl_barcode[k_row]
			kst_tab_barcode_figlio.fila_1 = dw_dett_0.object.barcode_fila_1[k_row]
			kst_tab_barcode_figlio.fila_1p = dw_dett_0.object.barcode_fila_1p[k_row]
			kst_tab_barcode_figlio.fila_2 = dw_dett_0.object.barcode_fila_2[k_row]
			kst_tab_barcode_figlio.fila_2p = dw_dett_0.object.barcode_fila_2p[k_row]

//--- controllo se i barcode possono diventare PADRE e FIGLIO 
			if NOT kiuf_barcode.if_essere_barcode_figlio_g2(kst_tab_barcode_figlio, kst_tab_barcode_padre) then
				kst_esito.esito = kkg_esito.ko
				kst_esito.sqlerrtext = "Asscociazione con il barcode Figlio " + trim(kst_tab_barcode_figlio.barcode) &
									+ " non consentita! " 
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if

	end for

	
catch (uo_exception kuo_exception)
	throw kuo_exception


finally
	

end try




end subroutine

private function integer u_crea_groupage_campioni (long a_riga_dw_lista) throws uo_exception;/*
 Associa il Barcode di Lavorazione al Controcampione
*/
integer k_return = 0
long k_row, k_rows
integer k_nr_bcode
st_tab_barcode kst_tab_barcode
st_tab_armo_campioni kst_tab_armo_campioni
st_esito kst_esito
kuf_armo_campioni kuf1_armo_campioni
kuf_barcode kuf1_barcode


try

	kst_esito = kguo_exception.inizializza(this.classname())
	kuf1_armo_campioni = create kuf_armo_campioni
	kuf1_barcode = create kuf_barcode


	//kst_tab_barcode_padre.pl_barcode = dw_lista_0.object.pl_barcode[a_riga_dw_lista]
	kst_tab_armo_campioni.barcode_lav = trim(dw_lista_0.object.barcode[a_riga_dw_lista])
	
	k_rows = dw_dett_0.rowcount( )  // lavora sul dw ottenuto (VISUALIZZA)
	for k_row = 1 to k_rows
	
		if dw_dett_0.object.id_asdrackcode[k_row] > 0 then // Un Controcampione non può contenere RACK scarta!
		else
					
			kst_tab_armo_campioni.id_armo_campione = dw_dett_0.getitemnumber(k_row, "id_armo_campione")
			if kst_tab_armo_campioni.id_armo_campione > 0 then // E' un Controcampione provo a lavorarlo!
			
				kst_tab_armo_campioni.barcode = trim(dw_dett_0.object.barcode[k_row])
					
				kuf1_armo_campioni.set_barcode_lav(kst_tab_armo_campioni) // AGGIUNGE BARCODE DI LAV SUL CAMPIONE
				kst_tab_barcode.barcode = kst_tab_armo_campioni.barcode_lav 
				kuf1_barcode.set_flg_campione_si(kst_tab_barcode) // Set su BACRCODE del Flag CAMPIONE
				
				k_nr_bcode++  // nr Campioni associati correttamente al PADRE						
					
			end if
		end if
	
	end for
		
	if k_nr_bcode > 0 then

		kguo_sqlca_db_magazzino.db_commit( )
		
	end if
	
catch (uo_exception kuo_exception)
	kguo_sqlca_db_magazzino.db_rollback( )
	throw kuo_exception

finally
	if isvalid(kuf1_armo_campioni) then destroy kuf1_armo_campioni
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	
end try


return k_nr_bcode


end function

on w_lettore_grp.create
int iCurrent
call super::create
this.dw_modifica=create dw_modifica
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_modifica
end on

on w_lettore_grp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_modifica)
end on

event close;call super::close;//
if isvalid(kiuf1_lettore_grp) then destroy kiuf1_lettore_grp
if isvalid(kiuf_barcode_mod_giri) then destroy kiuf_barcode_mod_giri
if isvalid(kiuf_barcode) then destroy kiuf_barcode
if isvalid(kiuf_asdrackbarcode) then destroy kiuf_asdrackbarcode


end event

type dw_print_0 from w_g_tab0`dw_print_0 within w_lettore_grp
end type

type st_ritorna from w_g_tab0`st_ritorna within w_lettore_grp
integer x = 2821
integer y = 980
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_lettore_grp
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_lettore_grp
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_lettore_grp
integer x = 2880
integer y = 1768
end type

type st_stampa from w_g_tab0`st_stampa within w_lettore_grp
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_lettore_grp
integer x = 2834
integer y = 1664
end type

type cb_modifica from w_g_tab0`cb_modifica within w_lettore_grp
integer x = 2926
integer y = 1240
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_lettore_grp
integer x = 2894
integer y = 1536
end type

type cb_cancella from w_g_tab0`cb_cancella within w_lettore_grp
integer x = 2880
integer y = 1384
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_lettore_grp
integer x = 2907
integer y = 1092
boolean enabled = false
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_lettore_grp
integer y = 1116
integer width = 2779
integer height = 768
boolean enabled = true
string dataobject = "d_lettore_grp_figli_l"
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_attiva_standard_select_row = true
boolean ki_d_std_1_attiva_cerca = true
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_lettore_grp
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_lettore_grp
integer y = 20
integer width = 3291
integer height = 1024
string dataobject = "d_lettore_grp_l"
boolean hscrollbar = false
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_sempre_possibile = true
end type

type dw_guida from w_g_tab0`dw_guida within w_lettore_grp
end type

type st_duplica from w_g_tab0`st_duplica within w_lettore_grp
end type

type dw_modifica from uo_dw_modifica_giri_barcode within w_lettore_grp
integer x = 23
integer y = 320
integer width = 3479
integer height = 688
integer taborder = 110
boolean bringtotop = true
boolean enabled = true
end type

