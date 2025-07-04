﻿$PBExportHeader$w_contratti.srw
forward
global type w_contratti from w_g_tab0
end type
type dw_data_change from uo_d_std_1 within w_contratti
end type
end forward

global type w_contratti from w_g_tab0
integer width = 3634
integer height = 2100
string title = "Elenco CO"
long backcolor = 32501743
string icon = "AppIcon!"
windowanimationstyle closeanimation = rightslide!
boolean ki_toolbar_window_presente = true
dw_data_change dw_data_change
end type
global w_contratti w_contratti

type variables
//
private kuf_contratti kiuf_contratti
private kuf_clienti kiuf_clienti

private st_tab_contratti ki_st_tab_contratti_arg
private st_tab_contratti ki_st_tab_contratti_insert
private date ki_data_scad

private string ki_ultimo_codice_cercato="*********"

end variables

forward prototypes
public function string inizializza ()
private function string cancella ()
protected function integer inserisci ()
private function integer check_rek (string k_mc_co)
private function integer check_rek_sc_cf (string k_sc_cf)
protected function integer modifica ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
protected function string check_dati ()
private function integer visualizza ()
protected subroutine riempi_id ()
protected subroutine open_start_window ()
public subroutine legge_dwc ()
protected subroutine set_titolo_window_personalizza ()
public subroutine call_listini ()
public subroutine posiziona_su_codice ()
public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti)
private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti)
public function integer u_retrieve_dw_lista ()
private subroutine u_modifica_massiva_data_scad ()
private function long u_modifica_massiva_data_scad_esegue () throws uo_exception
private subroutine call_logtrace ()
protected subroutine u_set_dw_guida ()
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
int k_rc


	SetPointer(kkg.pointer_attesa )

	choose case true
		case ki_st_open_w.flag_primo_giro = "S" 

			u_set_dw_guida( )

			choose case true
				case ki_st_tab_contratti_arg.codice > 0 &
						,ki_st_tab_contratti_arg.cod_cli > 0 &
						,ki_st_tab_contratti_arg.mc_co > " "
						
					k_rc = u_retrieve_dw_lista()
					if k_rc = 1 then
						ki_st_tab_contratti_arg.codice = dw_lista_0.getitemnumber(1, "codice")
						post posiziona_su_codice( )   // si posizione e apre il CODICE indicato
					end if
					
				case else
					dw_guida.bringtotop = true
					dw_guida.setfocus( )
						
			end choose
			
		case dw_lista_0.rowcount() = 0 
			k_rc = u_retrieve_dw_lista()
			
	end choose			

	if k_rc < 1 then
			
		k_return = "1Nessun Contratto Trovato "

	end if		
				
	SetPointer(kkg.pointer_default)

return k_return



end function

private function string cancella ();//
string k_return="0 "
string k_descr
long k_codice
string k_mc_co
string k_errore = "0 ", k_errore1 = "0 "
long k_riga


//=== Controllo se sul dettaglio c'e' qualche cosa
k_riga = dw_dett_0.rowcount()	
if k_riga > 0 then
	k_codice = dw_dett_0.getitemnumber(1, "codice")
	k_mc_co = dw_dett_0.getitemstring(1, "mc_co")
	k_descr = dw_dett_0.getitemstring(1, "descr")
end if
//=== Se sul dw non c'e' nessuna riga o nessun codice allora pesco dalla lista
if k_riga <= 0 or isnull(k_codice) then
	k_riga = dw_lista_0.getselectedrow(0)	
	if k_riga > 0 then
		k_codice = dw_lista_0.getitemnumber(k_riga, "codice")
		k_mc_co = dw_lista_0.getitemstring(k_riga, "mc_co")
		k_descr = dw_lista_0.getitemstring(k_riga, "descr")
	end if
end if

if isnull(k_mc_co) then
	k_mc_co = ". "
end if
if isnull(k_descr) = true or trim(k_descr) = "" then
	k_descr = "Contratto senza descrizione" 
end if

if k_riga > 0 and isnull(k_codice) = false then	
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina Contratto", "Sei sicuro di voler Cancellare il ~n~r" + &
				string(k_codice, "####0") + " MC-CO:" + trim(k_mc_co) + " " + trim(k_descr), &
				question!, yesno!, 2) = 1 then
 
		
//=== Cancella la riga dal data windows di lista
		k_errore = kiuf_contratti.tb_delete(k_codice) 
		if LeftA(k_errore, 1) = "0" then

			k_errore = kGuf_data_base.db_commit()
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + MidA(k_errore, 2))

			else

//--- cancello riga a video
				k_codice = 0
				k_riga = dw_dett_0.rowcount()	
				if k_riga > 0 then
					k_codice = dw_dett_0.getitemnumber(1, "codice")
					dw_dett_0.deleterow(k_riga)
				end if
				if k_riga <= 0 or isnull(k_codice) then
					k_riga = dw_lista_0.getselectedrow(0)	
					if k_riga > 0 then
						dw_lista_0.deleterow(k_riga)
					end if
				end if

			end if

			dw_dett_0.setfocus()

		else
			k_errore1 = k_errore
			k_errore = kGuf_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							MidA(k_errore1, 2) ) 	
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi durante il recupero dell'errore !!", &
					"Controllare i dati. " + MidA(k_errore, 2))
			end if

			attiva_tasti()
	

		end if


	else
		messagebox("Elimina Contratto", "Operazione Annullata !!")
	end if

	dw_dett_0.setcolumn(1)

end if

return(k_return)
end function

protected function integer inserisci ();//
int k_rc, k_ctr, k_taborder
long k_riga
string k_rc1, k_style
st_tab_clienti kst_tab_clienti
kuf_clienti kuf1_clienti
kuf_utility kuf1_utility
st_esito kst_esito
datawindowchild kdwc_clienti_d


	dw_dett_0.reset()

	ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento 

//--- legge i DWC
	legge_dwc()

//=== Aggiunge una riga al data windows
	dw_dett_0.scrolltorow(dw_dett_0.insertrow(dw_dett_0.getrow() + 1))
	dw_dett_0.setcolumn(1)

//--- imposta il cliente se impostato tra gli Argomenti iniziali
	if ki_st_tab_contratti_arg.cod_cli > 0 then
		dw_dett_0.setitem(1, "cod_cli", ki_st_tab_contratti_arg.cod_cli)
		k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_clienti_d)
		if kdwc_clienti_d.rowcount( ) > 1 then
			k_riga = kdwc_clienti_d.find("id_cliente = " + string(ki_st_tab_contratti_arg.cod_cli), 1, dw_dett_0.rowcount( ) )
			if k_riga > 0 then
				 dw_dett_0.setitem(1, "rag_soc_10", kdwc_clienti_d.getitemstring( k_riga, "rag_soc_1") )
			end if
		else
			if ki_st_tab_contratti_arg.cod_cli > 0 then
				try
					kuf1_clienti = create kuf_clienti
					kst_tab_clienti.codice = ki_st_tab_contratti_arg.cod_cli
					kuf1_clienti.get_nome( kst_tab_clienti )
					dw_dett_0.setitem(1, "rag_soc_10", kst_tab_clienti.rag_soc_10 )
				catch (uo_exception kuo_exception)
					kuo_exception.messaggio_utente()
				finally	 
					if isvalid(kuf1_clienti) then destroy kuf1_clienti
				end try
			end if
		end if 
	end if

//--- Imposta dati di DEFAULT
//	dw_dett_0.setitem(1, "flg_acconto", kiuf_contratti.kki_flg_acconto_no)
	dw_dett_0.setitem(1, "tipo", kiuf_contratti.kki_TIPO_standard)
	dw_dett_0.setitem(1, "et_dosimetro", kiuf_contratti.kki_et_dosimetro_default )
	if ki_st_tab_contratti_insert.data > date (0) then
		dw_dett_0.setitem(1, "data",  ki_st_tab_contratti_insert.data)
	else
		dw_dett_0.setitem(1, "data",  kg_dataoggi)
	end if
	if ki_st_tab_contratti_insert.data_scad > date (0) then
		dw_dett_0.setitem(1, "data_scad",  ki_st_tab_contratti_insert.data_scad)
	else
		dw_dett_0.setitem(1, "data_scad",  date(year(kg_dataoggi), 12, 31) )
	end if
	
	dw_dett_0.ResetUpdate ( ) 
	
//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility 
	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
	destroy kuf1_utility	

	attiva_tasti()
	
//=== Posiziona il cursore sul Data Windows
	dw_dett_0.setfocus() 

return (0)


end function

private function integer check_rek (string k_mc_co);//
int k_return = 0
int k_anno
string k_descr, k_sc_cf = ""
long k_codice, k_codice_1


	k_codice_1 = dw_dett_0.getitemnumber(1, "codice")  

	if trim(k_mc_co) > " " then 

		select 
			contratti.codice, 
			contratti.descr,
			contratti.sc_cf
		 INTO :k_codice,
				:k_descr,
				:k_sc_cf
			FROM contratti 
			where contratti.codice in
			(
		SELECT 
			max(contratti.codice) 
		FROM contratti 
		WHERE mc_co = :k_mc_co and codice <> :k_codice_1)
		using kguo_sqlca_db_magazzino ;

		if kguo_sqlca_db_magazzino.sqlcode = 0 then 
			
				
			if trim(k_sc_cf) > " " then 
				k_sc_cf = "Capitolato di Fornitura: " + trim(k_sc_cf)
			else
				k_sc_cf = "senza Capitolato di Fornitura "
			end if
			
			if messagebox("Conferma Ordine gia' in Archivio", & 
						"Trovato Contratto con codice: " + string(k_codice,"#####") + "~n~r" &
						+ "Capitolato " + trim(k_sc_cf) + " - " + trim(k_descr) + "~n~r" + &
						"Vuoi proseguire ugualmente?", question!, yesno!, 2) = 2 then
			
	
				dw_dett_0.reset()
			
				k_return = 1
			end if
		end if
	end if  


return k_return


end function

private function integer check_rek_sc_cf (string k_sc_cf);//
int k_return = 0
int k_anno
string k_descr, k_mc_co = ""
long k_codice, k_codice_1


	k_codice_1 = dw_dett_0.getitemnumber(1, "codice")  

	if trim(k_sc_cf) > " " then 
		
		SELECT 
				contratti.codice, 
				contratti.descr,
				contratti.mc_co
			 INTO :k_codice,
					:k_descr,
					:k_mc_co
			FROM contratti 
			where contratti.codice in
				 	 (SELECT 
		 						max(contratti.codice)
					   from contratti
						WHERE sc_cf = :k_sc_cf and codice <> :k_codice_1)
			using kguo_sqlca_db_magazzino ;

		if kguo_sqlca_db_magazzino.sqlcode = 0 then 
			
			if LenA(trim(k_mc_co)) = 0 then 
				k_mc_co = " "
			else
				k_mc_co = "MC-CO " + trim(k_sc_cf)
			end if
			
			if messagebox("Capitolato già in Archivio", & 
						"Trovato Contratto con codice: " + string(k_codice,"#####") + "~n~r" &
						+ trim(k_mc_co) + " - " + trim(k_descr) + "~n~r" + &
						"Vuoi proseguire ugualmente?", question!, yesno!, 2) = 2 then
			
	
				dw_dett_0.reset()
	//			inizializza()
			
				k_return = 1
			end if
		end if  
	end if  

//	attiva_tasti()



return k_return


end function

protected function integer modifica ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_rc,  k_ctr, k_taborder
string k_style, k_rc1
long k_key
kuf_utility kuf1_utility	


//--- legge i DWC
	legge_dwc()

	if not dw_lista_0.enabled then
		k_key = ki_st_tab_contratti_arg.codice
	else
		k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "codice")
	end if
	ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 

	k_return = dw_dett_0.retrieve( k_key ) 

//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility 
	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
//--- disabilita la modifica sul codice
	kuf1_utility.u_proteggi_dw("2", 1, dw_dett_0)
	destroy kuf1_utility	

	attiva_tasti()

	dw_dett_0.SetColumn(9)


return k_return

end function

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu

//
//--- Attiva/Dis. Voci di menu personalizzate
//
//	if not m_main.m_strumenti.m_fin_gest_libero1.visible then
//		m_main.m_strumenti.m_fin_gest_libero1.text = "Mostra/Nascondi righe Scadute"
//		m_main.m_strumenti.m_fin_gest_libero1.microhelp = "Mostra o Nasconde i Contratti non piu' Attivi"
//		m_main.m_strumenti.m_fin_gest_libero1.visible = true
//		m_main.m_strumenti.m_fin_gest_libero1.enabled = true
//		m_main.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
//		m_main.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Mostra,"+m_main.m_strumenti.m_fin_gest_libero1.text
//		m_main.m_strumenti.m_fin_gest_libero1.toolbaritemName = "DeleteRow!"
////		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
//	end if

	if not m_main.m_strumenti.m_fin_gest_libero3.Visible then
		m_main.m_strumenti.m_fin_gest_libero3.text = "Listini Contratto"
		m_main.m_strumenti.m_fin_gest_libero3.microhelp = "Listini,Elenco Listini del Contratto selezionato"
		m_main.m_strumenti.m_fin_gest_libero3.enabled = true
		m_main.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true
		m_main.m_strumenti.m_fin_gest_libero3.toolbaritemText = "Listini, Elenco Listini del Contratto selezionato"
		m_main.m_strumenti.m_fin_gest_libero3.toolbaritemName = "FormatDollar!"
//		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
		m_main.m_strumenti.m_fin_gest_libero3.visible = true
	end if
	
//	if not m_main.m_strumenti.m_fin_gest_libero4.visible then
//		m_main.m_strumenti.m_fin_gest_libero4.text = "Cambia data estrazione scadenze "
//		m_main.m_strumenti.m_fin_gest_libero4.microhelp = "Cambia data estrazione scadenze "
//		m_main.m_strumenti.m_fin_gest_libero4.enabled = true
//		m_main.m_strumenti.m_fin_gest_libero4.toolbaritemText = "data,"+m_main.m_strumenti.m_fin_gest_libero4.text
//		m_main.m_strumenti.m_fin_gest_libero4.toolbaritemName = "Custom015!"
////		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2
//		m_main.m_strumenti.m_fin_gest_libero4.visible = true
//		m_main.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = true
//	end if	
	
	if not m_main.m_strumenti.m_fin_gest_libero5.visible then
		m_main.m_strumenti.m_fin_gest_libero5.text = "Modifica massiva della data di scadenza "
		m_main.m_strumenti.m_fin_gest_libero5.microhelp = "Modifica massiva della data di scadenza "
		m_main.m_strumenti.m_fin_gest_libero5.enabled = true
		m_main.m_strumenti.m_fin_gest_libero5.toolbaritemText = "Scad.,"+m_main.m_strumenti.m_fin_gest_libero5.text
		m_main.m_strumenti.m_fin_gest_libero5.toolbaritemName = "EditMask5!"
//		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritembarindex=2
		m_main.m_strumenti.m_fin_gest_libero5.visible = true
		m_main.m_strumenti.m_fin_gest_libero5.toolbaritemVisible = true
	end if	

//--- Vedi LOG da TemporalTable
	if not m_main.m_strumenti.m_fin_gest_libero8.toolbaritemvisible or ki_st_open_w.flag_primo_giro = 'S' then
		m_main.m_strumenti.m_fin_gest_libero8.text = "Visualizza dati Storici (Log Trace)"
		m_main.m_strumenti.m_fin_gest_libero8.microhelp = "Visualizza dati Storici"
		m_main.m_strumenti.m_fin_gest_libero8.enabled = true
		m_main.m_strumenti.m_fin_gest_libero8.toolbaritemtext =  "Log,"+ m_main.m_strumenti.m_fin_gest_libero8.text
		m_main.m_strumenti.m_fin_gest_libero8.toolbaritemvisible = true
		m_main.m_strumenti.m_fin_gest_libero8.visible = true
		m_main.m_strumenti.m_fin_gest_libero8.toolbaritemname = "history16.png"
	end if


//---
	super::attiva_menu()
	
end subroutine

protected subroutine smista_funz (string k_par_in);//===

choose case LeftA(k_par_in, 2) 


//	case KKG_FLAG_RICHIESTA.libero1		//Mostra nasconde attivi/disattivi
//		mostra_nascondi_in_lista()

	case KKG_FLAG_RICHIESTA.libero3		//chiama LISTINI
		call_listini( )

	case KKG_FLAG_RICHIESTA.libero5		//modifica massiva data scadenze
		u_modifica_massiva_data_scad( )
		
//--- vedi LOG TRACE
	case kkg_flag_richiesta.libero8
		call_logtrace()	
		
	case else
		super::smista_funz(k_par_in)

end choose



end subroutine

protected function string check_dati ();//
//=== Controllo dati inseriti
string k_return = ""
string k_errore = "0"
int k_rc=0
long k_riga, k_find_riga
string k_key, k_rag_soc_10
string k_descr, k_mc_co = "", k_sc_cf="", k_sl_pt=""
long k_codice, k_codice_1, k_clie
string k_rag_soc
st_tab_clienti kst_tab_clienti
st_tab_contratti kst_tab_contratti
st_esito kst_esito
kuf_clienti kuf1_clienti
datawindowchild kdwc_clienti_d
datastore kds_contratti_listini_l_scad_err


try
	setpointer(kkg.pointer_attesa)

	k_riga = dw_dett_0.getrow()


//--- Attivo dw archivio Clienti e imposto il codice su dw per aggiornamento
	k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_clienti_d)
	k_rc = kdwc_clienti_d.settransobject(kguo_sqlca_db_magazzino)
	k_rag_soc_10=dw_dett_0.getitemstring(k_riga, "rag_soc_10")
	if not isnull(k_rag_soc_10) then
		
		if kdwc_clienti_d.rowcount() < 2 then
			kdwc_clienti_d.retrieve("%")
			kdwc_clienti_d.insertrow(1)
		end if

		k_find_riga=kdwc_clienti_d.find("rag_soc_1=~""+trim(k_rag_soc_10) + "~"" &
		 				 + " and id_cliente = " + string(dw_dett_0.getitemnumber(k_riga, "cod_cli")) &
						 , 0, kdwc_clienti_d.rowcount())
		if k_find_riga > 0 then
		else
			k_find_riga=kdwc_clienti_d.find("rag_soc_1=~"" + trim(k_rag_soc_10) + "~"" , 0, kdwc_clienti_d.rowcount())
			if k_find_riga > 0 then
				dw_dett_0.setitem(k_riga, "cod_cli", kdwc_clienti_d.getitemnumber(k_find_riga, "id_cliente"))
			else
				//dw_dett_0.setitem(k_riga, "cod_cli", 0)
				k_return += "Cliente " + trim(k_rag_soc_10) + " non Trovato o non ATTIVO!" + " ~n~r"
				k_errore = "3"
			end if
		end if
	end if


	if isnull(dw_dett_0.getitemstring ( k_riga, "descr")) = true then
		k_return += "Manca il dato '" + trim(dw_dett_0.object.descr_t.text) + "'~n~r" 
		k_errore = "3"
	end if


//--- controllo SL-PT se impostato nel CAPITOLATO allora lo prendo dal li (se diverso setto l'errore grave)
	kst_tab_contratti.sc_cf = dw_dett_0.getitemstring(k_riga, "sc_cf")
	if trim(kst_tab_contratti.sc_cf) > " " then
		kst_esito = kiuf_contratti.get_sc_cf_pt(kst_tab_contratti)   // legge dati contratto
		if kst_esito.esito = kkg_esito.ok then
			if trim(kst_tab_contratti.sl_pt) > " " then
				k_sl_pt =  dw_dett_0.getitemstring(k_riga, "sl_pt") 
				if trim(k_sl_pt) > " " then
					if trim(kst_tab_contratti.sl_pt) <> trim(k_sl_pt) then
						k_return += "Indicato il Piano di Trattamento '" + trim(k_sl_pt) + "' diverso da quello del Capitolato, "  &
															  + "~n~r" + "impostare il '" + trim(kst_tab_contratti.sl_pt) + "' ~n~r"
											//	  +  trim(dw_dett_0.object.sl_pt_t.text) + "'~n~r" 
						k_errore = "3"
					end if
				else
//--- imposto il sl_pt che sta sul CAPITOLATO
					k_rc = dw_dett_0.setitem(k_riga, "sl_pt", trim(kst_tab_contratti.sl_pt))
					
				end if
			end if
		else
			if kst_esito.esito = kkg_esito.not_fnd then
				k_return += "Capitolato '"  + trim(kst_tab_contratti.sc_cf) + "' non trovato in archivio ~n~r"
				k_errore = "3"
			else
				k_return += "Errore in lettura del Capitolato '"  + trim(kst_tab_contratti.sc_cf) + "' ~n~r" + string(kst_esito.sqlcode) + " - " + trim(kst_esito.sqlerrtext)  + " ~n~r" 
				k_errore = "1"
			end if
		end if
	end if
	
	if k_errore <> "1" and k_errore <> "3"  then
//--- codice sl-pt obbligatorio se tipo=STANDARD
		if trim(dw_dett_0.getitemstring ( k_riga, "sl_pt"))  > " " then
		else
			if dw_dett_0.getitemstring ( k_riga, "tipo") = kiuf_contratti.kki_tipo_deposito then
			else
				k_return += "Manca il dato '" +  trim(dw_dett_0.object.sl_pt_t.text) + "'~n~r" 
				k_errore = "3"
			end if
		end if
	end if

			
//--- errori diversi
   if trim(k_errore) = "0" then

		if (dw_dett_0.getitemdate(k_riga, "data")) > (dw_dett_0.getitemdate(k_riga, "data_scad")) then
	
			k_return += "data Decorrenza "+ string(dw_dett_0.getitemdate(k_riga, "data"), "dd mmm yy") +" maggiore della data di Scadenza " + string(dw_dett_0.getitemdate(k_riga, "data_scad"), "dd mmm yy") + "~n~r" 
			k_errore = "1"

		end if

		k_mc_co = trim(dw_dett_0.getitemstring(k_riga, "mc_co"))
		if isnull(k_mc_co) then k_mc_co = ""
		k_codice_1 = dw_dett_0.getitemnumber(k_riga, "codice")  
		kst_tab_contratti.cod_cli = dw_dett_0.getitemnumber(k_riga, "cod_cli")  

		if kst_tab_contratti.cod_cli > 0 then
			
			kst_tab_clienti.stato = kuf1_clienti.kki_cliente_stato_attivo
	
			declare c_contratti_clie cursor  for
				SELECT distinct 
					contratti.codice, 
					contratti.descr,
					contratti.sc_cf, 
					clienti.rag_soc_10,
					clienti.codice
				FROM (contratti inner join  clienti on
						contratti.cod_cli = clienti.codice)
				WHERE contratti.mc_co = :k_mc_co and contratti.codice <> :k_codice_1 
						and contratti.cod_cli <> :kst_tab_contratti.cod_cli 
						and clienti.stato = :kst_tab_clienti.stato 
						using kguo_sqlca_db_magazzino ;
	
			open c_contratti_clie;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then 
				fetch c_contratti_clie
					 INTO :k_codice,
							:k_descr,
							:k_sc_cf,
							:k_rag_soc,
							:k_clie;
			
				if kguo_sqlca_db_magazzino.sqlcode = 0 then 
					
					if trim(k_sc_cf) > " " then 
						k_sc_cf = ", Capitolato " + trim(k_sc_cf) + " - "
					else
						k_sc_cf = ", "
					end if
					
					k_return += & 
								"Lo stesso Contratto commerciale " + k_mc_co + " trovato anche nella Conferma Ordine n. " + string(k_codice,"#####") & 
							+ "~n~rCapitolato " + trim(k_sc_cf) + " - " + trim(k_descr) +"~n~r" &
							+ "associato al cliente " + trim (k_rag_soc) + " (" + string(k_clie,"#####") + ")~n~r" &
							+ "diverso da quello corrente (" + string(kst_tab_contratti.cod_cli) + ")~n~r"
				
					k_errore = "5"  // OK con avvertimento!!
					
				end if
				close c_contratti_clie;
			end if
		end if
	end if  

//--- verifica data SCADENZA
	kst_tab_contratti.codice = dw_dett_0.getitemnumber(k_riga, "codice")   
	kst_tab_contratti.data_scad = dw_dett_0.getitemdate(k_riga, "data_scad")   
	if kst_tab_contratti.data_scad > kkg.data_no then
		kds_contratti_listini_l_scad_err = create datastore
		kds_contratti_listini_l_scad_err.dataobject = "ds_contratti_listini_l_scad_err"
		kds_contratti_listini_l_scad_err.settransobject(kguo_sqlca_db_magazzino)
		k_rc = kds_contratti_listini_l_scad_err.retrieve(kst_tab_contratti.codice, kst_tab_contratti.data_scad)
		if k_rc > 0 then
			k_return += "La Scadenza non deve essere minore a quella indicata nei Listini, quale ad esempio nel id " + &
						 + string(kds_contratti_listini_l_scad_err.getitemnumber(1, "listino_id")) &
						 + " in vigore fino al " + string(kds_contratti_listini_l_scad_err.getitemdate(1, "listino_dt_end"), "dd mmm yy") &
						 + " di " + trim(kds_contratti_listini_l_scad_err.getitemstring(1, "rag_soc_10")) &
						 +  "; " + &
						 + "~n~r" 
			k_errore = "1"
		end if
	end if


//--- errori meno gravi
   if trim(k_errore) = "0" then
		
		k_key = dw_dett_0.getitemstring ( k_riga, "mc_co") 
		if trim(k_key) > " " then
		else
			if dw_dett_0.getitemstring ( k_riga, "tipo") = kiuf_contratti.kki_tipo_deposito then
			else
				k_return += "Manca il Codice Conferma Ordine " + "~n~r"
				k_errore = "4"
			end if
		end if

//--- c'e' gia' il Capitolato in qualche altro contratto ancora valido quando parte questo?
		k_sc_cf = trim(dw_dett_0.getitemstring(k_riga, "sc_cf"))  
		if trim(k_sc_cf) > " " then
			k_codice_1 = dw_dett_0.getitemnumber(k_riga, "codice")  
			kst_tab_contratti.data = dw_dett_0.getitemdate(k_riga, "data")  

			SELECT 
				contratti.codice, 
				contratti.descr,
				contratti.mc_co
			 INTO :k_codice,
					:k_descr,
					:k_mc_co
			FROM contratti 
			where contratti.codice in
				 	 (SELECT 
		 						max(contratti.codice)
					   from contratti
						WHERE sc_cf = :k_sc_cf and codice <> :k_codice_1
						         and data_scad > :kst_tab_contratti.data)
			using kguo_sqlca_db_magazzino ;

			if kguo_sqlca_db_magazzino.sqlcode = 0 then 
				
				if trim(k_mc_co) > " " then 
					k_mc_co = "Conferma Ordine: " + trim(k_mc_co)
				else
					k_mc_co = "senza Conferma Ordine "
				end if
		
				k_return += "Capitolato di Fornitura gia' associato anche al contratto ~n~r" + &
											 "codice: " + string(k_codice,"#####") +  "; " + &
											+ trim(k_mc_co) + " - " + trim(k_descr) + "~n~r" 
				k_errore = "4"
		
			end if		
		end if

//--- c'e' gia' il Contr.Commerciale in qualche altro contratto ancora valido quando parte questo?
		k_mc_co = trim(dw_dett_0.getitemstring(k_riga, "mc_co"))
		if trim(k_mc_co) > " " then
			k_codice_1 = dw_dett_0.getitemnumber(k_riga, "codice")  
			kst_tab_contratti.data = dw_dett_0.getitemdate(k_riga, "data")  

			select 
				contratti.codice, 
				contratti.descr,
				contratti.sc_cf
			 INTO :k_codice,
					:k_descr,
					:k_sc_cf
				FROM contratti 
				where contratti.codice in
				(
			SELECT 
				max(contratti.codice) 
			FROM contratti 
			WHERE mc_co = :k_mc_co and codice <> :k_codice_1
						         and data_scad > :kst_tab_contratti.data)
			using kguo_sqlca_db_magazzino ;

			if kguo_sqlca_db_magazzino.sqlcode = 0 then 
				
				if trim(k_sc_cf) > " " then 
					k_sc_cf = "Capitolato di Fornitura: " + trim(k_sc_cf)
				else
					k_sc_cf = "senza Capitolato di Fornitura "
				end if
		
				k_return += "Conferma Ordine già associato al contratto ~n~r" + &
											 "codice: " + string(k_codice,"#####") +  "; " + &
											+ trim(k_sc_cf) + " - " + trim(k_descr) + "~n~r" 
				k_errore = "4"
			end if	
		end if
	end if
	
	if dw_dett_0.getitemnumber(k_riga, "cod_cli") > 0 then 
	else
		k_return += "Manca Cliente del Contratto " + "~n~r" 
		if trim(k_errore) = "0" then
			k_errore = "5"
		end if
	end if

//--- Se nessun errore grave allora imposto i dati di default
	if trim(k_errore) = "0" or trim(k_errore) = "4" or trim(k_errore) = "5 "then


//--- Valore di default	
		if trim(dw_dett_0.getitemstring(k_riga, "flag_bolla_in_dett")) > " " then
		else
			dw_dett_0.setitem(k_riga, "flag_bolla_in_dett", "0")
		end if
		if dw_dett_0.getitemnumber(k_riga, "et_dosimetro") > 0 then
		else
			dw_dett_0.setitem(k_riga, "et_dosimetro", kiuf_contratti.kki_et_dosimetro_default )
		end if

//--- se "inserimento" forzo a zero il codice, cosi' puo essere valorizzato automaticamente 
//--- da informix (campo serial)
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
			dw_dett_0.setitem(k_riga, "codice", 0)
		end if

	end if

//--- 	
	if k_return = "" then k_return = "0"
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally
	if isvalid(kds_contratti_listini_l_scad_err) then destroy kds_contratti_listini_l_scad_err
	setpointer(kkg.pointer_default)

end try

return trim(k_errore) + (k_return)


end function

private function integer visualizza ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_rc, k_taborder
long k_key
int k_ctr
string k_rc1="", k_style, k_colore
kuf_utility kuf1_utility



	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "codice")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione 

	k_return = dw_dett_0.retrieve( k_key ) 

//--- protezione campi per visual
	kuf1_utility = create kuf_utility 
	kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
	destroy kuf1_utility	

//	attiva_tasti()


return k_return


end function

protected subroutine riempi_id ();//
long k_riga=0
st_tab_contratti kst_tab_contratti


//--- Imposta valori di default
	k_riga = dw_dett_0.rowcount( )
	if k_riga > 0 then
		
//		kst_tab_contratti.flg_acconto = dw_dett_0.getitemstring(1, "flg_acconto")  
//		if trim(kst_tab_contratti.flg_acconto) > " " then
//		else
//			dw_dett_0.setitem(1, "flg_acconto", kiuf_contratti.kki_flg_acconto_no)
//		end if
		
		kst_tab_contratti.tipo = dw_dett_0.getitemstring(1, "tipo")  
		if trim(kst_tab_contratti.tipo) > " " then
		else
			dw_dett_0.setitem(1, "tipo", kiuf_contratti.kki_TIPO_standard)
		end if
		
//		kst_tab_contratti.flg_fatt_dopo_valid = dw_dett_0.getitemstring(1, "flg_fatt_dopo_valid")  
//		if trim(kst_tab_contratti.flg_fatt_dopo_valid) > " " then
//		else
//			dw_dett_0.setitem(1, "flg_fatt_dopo_valid", kiuf_contratti.kki_flg_fatt_dopo_valid_no)
//		end if

	end if

	if isnull(dw_dett_0.getitemdate(k_riga, "data")) then 
		dw_dett_0.setitem(k_riga, "data", kguo_g.get_dataoggi() )
	end if

	dw_dett_0.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
	dw_dett_0.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())

//--- salva valori x ricordarli come valori di default	
	 ki_st_tab_contratti_insert.data = dw_dett_0.getitemdate(1, "data")
	 ki_st_tab_contratti_insert.data_scad = dw_dett_0.getitemdate(1, "data_scad")

end subroutine

protected subroutine open_start_window ();//---
int k_rc


	kiuf_contratti = create  kuf_contratti
	kiuf_clienti = create kuf_clienti

	dw_guida.insertrow(0)



end subroutine

public subroutine legge_dwc ();//--- legge i DWC presenti
int k_rc=0
datawindowchild  kdwc_clienti_des, kdwc_sc_cf_d, kdwc_sl_pt_d, kdwc_clienti 
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

////--- Attivo dw archivio Clienti
//	k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_clienti_d)
//	k_rc = kdwc_clienti_d.settransobject(sqlca)
//	if kdwc_clienti_d.rowcount() < 2 then
//		kdwc_clienti_d.retrieve("%")
//		kdwc_clienti_d.insertrow(1)
//	end if
//--- Attivo dw archivio Clienti
	k_rc = dw_dett_0.getchild("cod_cli", kdwc_clienti)
	k_rc = kdwc_clienti.settransobject(sqlca)
	k_rc = kdwc_clienti.insertrow(1)

	k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_clienti_des)
	k_rc = kdwc_clienti_des.settransobject(sqlca)
	k_rc = kdwc_clienti_des.insertrow(1)

//	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
		if kdwc_clienti.rowcount() < 2 then
			kdwc_clienti.retrieve("%")
			kdwc_clienti.RowsCopy(kdwc_clienti.GetRow(), kdwc_clienti.RowCount(), Primary!, kdwc_clienti_des, 1, Primary!)
			kdwc_clienti.setsort( "id_cliente A")
			kdwc_clienti.sort( )
			k_rc = kdwc_clienti.insertrow(1)
			k_rc = kdwc_clienti_des.insertrow(1)
		end if
//	end if

	
//--- Attivo dw archivio SC_CF
	k_rc = dw_dett_0.getchild("sc_cf", kdwc_sc_cf_d)
	k_rc = kdwc_sc_cf_d.settransobject(sqlca)
//	kdwc_sc_cf_d.reset() 
//--- Attivo dw archivio Capitolati
	k_rc = dw_dett_0.getchild("sc_cf", kdwc_sc_cf_d)
	if kdwc_sc_cf_d.rowcount() < 2 then
		kdwc_sc_cf_d.retrieve(0, "S")
		kdwc_sc_cf_d.insertrow(1)
	end if


//--- Attivo dw archivio SL-PT
	k_rc = dw_dett_0.getchild("sl_pt", kdwc_sl_pt_d)
	k_rc = kdwc_sl_pt_d.settransobject(sqlca)
//	kdwc_sl_pt_d.reset()
//--- Attivo dw archivio PT
	k_rc = dw_dett_0.getchild("sl_pt", kdwc_sl_pt_d)
	if kdwc_sl_pt_d.rowcount() < 2 then
		kdwc_sl_pt_d.retrieve()
		kdwc_sl_pt_d.insertrow(1)
	end if


//--- Attivo dw chiild NOTE etichette
	k_rc = dw_dett_0.getchild("et_bcode_note", kdwc_sl_pt_d)
	k_rc = kdwc_sl_pt_d.settransobject(sqlca)
	kdwc_sl_pt_d.reset() 
	kdwc_sl_pt_d.retrieve()
	kdwc_sl_pt_d.insertrow(0)
	
//--- Attivo dw child Descrizione
	k_rc = dw_dett_0.getchild("descr", kdwc_sl_pt_d)
	k_rc = kdwc_sl_pt_d.settransobject(sqlca)
	kdwc_sl_pt_d.reset() 
	kdwc_sl_pt_d.retrieve()
	kdwc_sl_pt_d.insertrow(0)

//--- Attivo dw archivio CAUSALI
	k_rc = dw_dett_0.getchild("id_meca_causale", kdwc_sl_pt_d)
	k_rc = kdwc_sl_pt_d.settransobject(sqlca)
	kdwc_sl_pt_d.reset() 
	kdwc_sl_pt_d.retrieve()
	kdwc_sl_pt_d.insertrow(1)
	
	SetPointer(oldpointer)
	
	

end subroutine

protected subroutine set_titolo_window_personalizza ();
super::set_titolo_window_personalizza()

if dw_guida.rowcount() > 0 then
	this.title += " - elenco Contratti in Scadenza oltre il " + dw_guida.getitemstring(1, "datascad")
end if


end subroutine

public subroutine call_listini ();//---
st_tab_listino kst_tab_listino
kuf_listino kuf1_listino
st_open_w kst_open_w

try

	if dw_lista_0.getselectedrow(0) > 0 then
		kst_tab_listino.contratto = dw_lista_0.getitemnumber(dw_lista_0.getselectedrow(0), "codice")
	
//--- protezione campi per visual
		kuf1_listino = create kuf_listino 
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kuf1_listino.link_call_imvc(kst_tab_listino, kst_open_w)
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	if isvalid(kuf1_listino) then destroy kuf1_listino	
	
	
end try 

end subroutine

public subroutine posiziona_su_codice ();//
long k_riga


//--- se ho passato anche il codice contratto allora....
	k_riga = dw_lista_0.find( "codice = " + string(ki_st_tab_contratti_arg.codice), 1, dw_lista_0.rowcount( ) )
	if k_riga > 0 then 
		dw_lista_0.selectrow( 0, false)
		dw_lista_0.setrow( k_riga)

//--- se entro per fare qls sulla riga allora....
		u_lancia_funzione_imvc(ki_st_open_w)	
		
		dw_lista_0.selectrow( k_riga, true)
		dw_lista_0.scrolltorow( k_riga)
		
	end if

end subroutine

public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti);//
boolean k_return = false
st_esito kst_esito
kuf_clienti kuf1_clienti


try
	
	kuf1_clienti = create kuf_clienti

	k_return = kuf1_clienti.leggi (kst_tab_clienti)

	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	

finally
	destroy kuf1_clienti
	
end try

return k_return


end function

private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente 
//
long k_riga=1

dw_dett_0.modify( "id_cliente.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
dw_dett_0.modify( "clienti_rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
dw_dett_0.setitem(k_riga, "rag_soc_10", kst_tab_clienti.rag_soc_10)
dw_dett_0.setitem(k_riga, "cod_cli", kst_tab_clienti.codice)

end subroutine

public function integer u_retrieve_dw_lista ();//---
//---  Fa la Retrieve
//---
long k_return=0	
st_tab_contratti kst_tab_contratti


	if ki_st_tab_contratti_arg.cod_cli > 0 then
		kst_tab_contratti.cod_cli = ki_st_tab_contratti_arg.cod_cli
	else
		kst_tab_contratti.cod_cli = 0
	end if
	if trim(ki_st_tab_contratti_arg.mc_co) > " " then
		kst_tab_contratti.mc_co = "%" + trim(ki_st_tab_contratti_arg.mc_co) + "%"
	else
		kst_tab_contratti.mc_co = "*"
	end if
	if isnull(ki_data_scad) then
		ki_data_scad = date(0)
	end if
	if ki_st_tab_contratti_arg.codice > 0 then
		kst_tab_contratti.codice = ki_st_tab_contratti_arg.codice
	else
		kst_tab_contratti.codice = 0
	end if
	
	dw_lista_0.reset()
	dw_lista_0.u_filtra_record("") 
	k_return = dw_lista_0.retrieve(kst_tab_contratti.cod_cli &
											, kst_tab_contratti.mc_co &
											, ki_data_scad &
											, kst_tab_contratti.codice) 
	if k_return < 1 then
		dw_guida.setitem(1, "testo", "Codice non Trovato per la richiesta fatta (" &
									+ "cliente '" + string(ki_st_tab_contratti_arg.cod_cli) + "' / " &
									+ " codice '" + trim(ki_st_tab_contratti_arg.mc_co) + "' " &
									+ ". In scadenza oltre il " + string(ki_data_scad, "dd mmm yy")+") ")
	else
		
		dw_guida.setitem(1,  "testo", "Trovati " + string(dw_lista_0.rowcount()) + " Contratti. ")
		
//--- seleziona almeno una riga
		if dw_lista_0.rowcount() > 0 then
			
			if dw_lista_0.getselectedrow(0) = 0 then
				if dw_lista_0.getrow() = 0 then
					dw_lista_0.setrow(1)
					dw_lista_0.selectrow( 1, true)
				else
					dw_lista_0.selectrow(dw_lista_0.getrow(), true)
				end if
			end if	
		end if
									
		dw_lista_0.setfocus( )
		attiva_tasti( )
		
	end if
	
	
return k_return
	

end function

private subroutine u_modifica_massiva_data_scad ();//---
//--- Visualizza il box x il cambio DATA
//---


dw_data_change.triggerevent("ue_visibile")

end subroutine

private function long u_modifica_massiva_data_scad_esegue () throws uo_exception;//---
//--- Cambia le date di scadenza in elenco
//---
long k_return
long k_riga, k_riga_max, k_update
st_tab_contratti kst_tab_contratti


try

	if dw_data_change.rowcount( ) > 0 then
	
		kst_tab_contratti.data_scad = dw_data_change.getitemdate(1, "kdata")

		kst_tab_contratti.st_tab_g_0.esegui_commit = "N"
		
		k_riga_max = dw_lista_0.rowcount()
		for k_riga = 1 to k_riga_max
			kst_tab_contratti.codice = dw_lista_0.getitemnumber(k_riga, "codice")
			if kst_tab_contratti.codice > 0 then
				
				kiuf_contratti.set_data_scad(kst_tab_contratti)
				k_update ++
				
			end if
			
		next
		
		if k_update > 0 then
			
			kguo_sqlca_db_magazzino.db_commit( )
			k_return = k_update
			for k_riga = 1 to k_riga_max
				kst_tab_contratti.codice = dw_lista_0.getitemnumber(k_riga, "codice")
				if kst_tab_contratti.codice > 0 then
					dw_lista_0.setitem(k_riga, "data_scad", kst_tab_contratti.data_scad)
				end if
			next
			
		end if
		
	end if
	
catch (uo_exception kuo_exception)
	kguo_sqlca_db_magazzino.db_rollback( )
	throw kuo_exception
	
finally
	
end try

return k_return

end function

private subroutine call_logtrace ();//
//=== Open Window LogTrace MECA
long k_riga
st_tab_contratti kst_tab_contratti
st_open_w kst_open_w
kuf_logtrace_meca kuf1_logtrace_meca


try   
	
	k_riga = dw_dett_0.getrow()
	if k_riga > 0 then
		kst_tab_contratti.codice = (dw_dett_0.getitemnumber(1, "codice" ))
	else
		k_riga = dw_lista_0.getselectedrow(0)
		if k_riga > 0 then
			kst_tab_contratti.codice = (dw_lista_0.getitemnumber(1, "codice" ))
		end if
	end if

	if kst_tab_contratti.codice > 0 then
		kuf1_logtrace_meca = create kuf_logtrace_meca
		
		kst_open_w.key1 = string(kst_tab_contratti.codice)
		kst_open_w.key2 = kiuf_contratti.get_id_programma(kkg_flag_modalita.visualizzazione )
		kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
		kuf1_logtrace_meca.u_open(kst_open_w) 

	end if
		
catch (uo_exception	kuo_exception)
	kuo_exception.messaggio_utente()

finally

		
end try
	


end subroutine

protected subroutine u_set_dw_guida ();//---
int k_rc
//datawindowchild  kdwc_clienti_d, kdwc_sc_cf_d, kdwc_sl_pt_d 
kuf_elenco kuf1_elenco


	SetPointer(kkg.pointer_attesa)

	kuf1_elenco = create kuf_elenco

	ki_st_tab_contratti_arg.cod_cli = 0
	ki_st_tab_contratti_arg.mc_co = ""
	ki_st_tab_contratti_arg.codice = 0
	ki_data_scad = kkg.data_zero

	if trim(ki_st_open_w.id_programma_chiamante) = kuf1_elenco.get_id_programma(kkg_flag_modalita.elenco ) then

		ki_st_tab_contratti_arg.mc_co  = trim(ki_st_open_w.key1) // CODICE CONTRATTO COMMERCIALE
		dw_guida.event u_put_codice("CO", ki_st_tab_contratti_arg.mc_co)
		
	else
		if isnumber(trim(ki_st_open_w.key1)) then // CODICE CLIENTE
			ki_st_tab_contratti_arg.cod_cli = long(trim(ki_st_open_w.key1))
			dw_guida.event u_put_codice("CLIENTE", string(ki_st_tab_contratti_arg.cod_cli))
		end if
		if trim(ki_st_open_w.key2) > " "  then  // CODICE CONTRATTO COMMERCIALE
			ki_st_tab_contratti_arg.mc_co  = trim(ki_st_open_w.key2)
			dw_guida.event u_put_codice("CO", ki_st_tab_contratti_arg.mc_co)
		end if
		if trim(ki_st_open_w.key3) > " " or isnull(trim(ki_st_open_w.key3)) then  // CODICE CONTRATTO ID
			ki_st_tab_contratti_arg.codice  = long(trim(ki_st_open_w.key3))
			dw_guida.event u_put_codice("ID", string(ki_st_tab_contratti_arg.codice))
		end if
		if trim(ki_st_open_w.key5) > " " then				// DA QUALE DATA SCADENZA?
			if isdate(trim(ki_st_open_w.key5)) then
				ki_data_scad = date(trim(ki_st_open_w.key5))
			end if
		end if
		dw_guida.event u_put_codice("DATASCAD", string(ki_data_scad))
		
	end if

	if isvalid(kuf1_elenco) then destroy kuf1_elenco

	dw_guida.event u_dwc_retrieve()
	dw_guida.setitem(1, "rag_soc_1", "")

	SetPointer(kkg.pointer_default)



end subroutine

on w_contratti.create
int iCurrent
call super::create
this.dw_data_change=create dw_data_change
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_data_change
end on

on w_contratti.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_data_change)
end on

event close;call super::close;//
if isvalid(kiuf_contratti)  then destroy kiuf_contratti
if isvalid(kiuf_clienti)  then destroy kiuf_clienti

end event

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
int k_return
long k_riga_zoom
st_esito kst_esito
st_tab_contratti  kst_tab_contratti


if isvalid(kst_open_w) then

//--- Dalla finestra di Elenco Valori
	if kst_open_w.id_programma = kkg_id_programma_elenco then
	
		if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore
	
		kdsi_elenco_input = kst_open_w.key12_any 
	
		k_riga_zoom = 0
		if isnumber(kst_open_w.key3) then k_riga_zoom = long(kst_open_w.key3)

		if kdsi_elenco_input.rowcount() > 0 and k_riga_zoom > 0  then

			k_return = k_riga_zoom
			
	 		if kst_open_w.key6 = "b_et_bcode_note"  then  
		
				kst_tab_contratti.et_bcode_note = kdsi_elenco_input.getitemstring(k_riga_zoom, "et_bcode_note")
				dw_dett_0.setitem( 1, "et_bcode_note", kst_tab_contratti.et_bcode_note)
				attiva_tasti( )
			end if
	
		end if

	end if

end if

return k_return


end event

type dw_print_0 from w_g_tab0`dw_print_0 within w_contratti
end type

type st_ritorna from w_g_tab0`st_ritorna within w_contratti
integer x = 2821
integer y = 980
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_contratti
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_contratti
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_contratti
integer x = 2880
integer y = 1768
end type

type st_stampa from w_g_tab0`st_stampa within w_contratti
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_contratti
integer x = 2834
integer y = 1664
end type

type cb_modifica from w_g_tab0`cb_modifica within w_contratti
integer x = 2926
integer y = 1240
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_contratti
integer x = 2894
integer y = 1536
end type

type cb_cancella from w_g_tab0`cb_cancella within w_contratti
integer x = 2880
integer y = 1384
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_contratti
integer x = 2907
integer y = 1092
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_contratti
event u_note_calc_len ( string a_data )
integer x = 5
integer y = 792
integer width = 2784
integer height = 1148
boolean enabled = true
string dataobject = "d_contratti"
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_sort = false
end type

event dw_dett_0::u_note_calc_len(string a_data);//
int k_len[10], k_ini=1, k_last_pos=0
int k_i = 1, k_ctr
string k_str


	k_ini = pos(a_data, ';', k_ini)
	do while k_ini > 0 and k_i < 10

		k_len[k_i] = k_ini - k_last_pos - 1
		k_i++
		k_last_pos = k_ini

		k_ini++
		k_ini = pos(a_data, ';', k_ini)
			
	loop

	k_len[k_i] = len(trim(a_data)) - k_last_pos 
	
	if k_len[1] > 0 then
			k_str = "lungh.righe=" 
		for k_ctr = 1 to k_i 
			if k_len[k_ctr] > 0 then
				k_str += string(k_len[k_ctr]) + ";" 
			end if
		next
	end if
	this.setitem(1, "ket_bcode_note_len", k_str)


end event

event dw_dett_0::itemchanged;//
string k_rag_soc, k_sc_cf, k_sl_pt, k_sl_pt_dwc
long k_rc, k_riga=0
integer k_return=0, k_id_meca_causale
st_tab_clienti kst_tab_clienti
datawindowchild kdwc_x, kdwc_x_sl_pt


choose case upper(dwo.name)

	case "RAG_SOC_10" 
		if isnull(data) = false and Len(trim(data)) > 0 then
			k_rc = this.getchild("rag_soc_10", kdwc_x)
			k_rag_soc = Trim(data)
			if isnumber(k_rag_soc) then
				k_riga = kdwc_x.find("id_cliente = " + k_rag_soc + " ",0,kdwc_x.rowcount())
				if k_riga > 0  then
					k_rag_soc = kdwc_x.getitemstring(k_riga, "rag_soc_1")
				end if
				k_riga = kdwc_x.find("rag_soc_1 =~""+ trim(k_rag_soc)+"~"",0,kdwc_x.rowcount())
			else
				k_riga = kdwc_x.find("rag_soc_1 like ~"%"+trim(k_rag_soc)+"%~"",0,kdwc_x.rowcount())
				if k_riga <= 0 or isnull(k_riga) then
					k_riga = kdwc_x.find("rag_soc_1 like ~"%"+trim(k_rag_soc)+"%~"",0,kdwc_x.rowcount()) // seconda ricerca approssimativa
				end if
			end if
		
			if k_riga <= 0 or isnull(k_riga) then
				k_return = 2
				this.setitem(row, "rag_soc_10", (k_rag_soc)+" - NON TROVATO -")
				this.setitem(row, "cod_cli", 0)
			else

//				this.setitem(row, "rag_soc_10", kdwc_x.getitemstring(k_riga, "rag_soc_1"))
//				this.setitem(row, "cod_cli", kdwc_x.getitemnumber(k_riga, "id_cliente"))
				kst_tab_clienti.rag_soc_10 = kdwc_x.getitemstring(k_riga, "rag_soc_1")
				kst_tab_clienti.codice = kdwc_x.getitemnumber(k_riga, "id_cliente")
				post put_video_cliente(kst_tab_clienti)
			end if
		else
			this.setitem(row, "rag_soc_10", "")
			this.setitem(row, "cod_cli", 0)
		end if

//		k_rag_soc = RightTrim(data)
//		if isnull(k_rag_soc) = false and LenA(trim(k_rag_soc)) > 0 then
//			
//			k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_x)
//			k_rc = kdwc_x.find("rag_soc_1 like ~""+k_rag_soc+"%~"",0,kdwc_x.rowcount())
//			k_riga = k_rc
//			if k_riga <= 0 or isnull(k_riga) then
//				k_return = 2
//				dw_dett_0.setitem(row, "rag_soc_10", (k_rag_soc)+" - NON TROVATO -")
//				dw_dett_0.setitem(row, "cod_cli", 0)
//			else
//				kst_tab_clienti.rag_soc_10 = kdwc_x.getitemstring(k_riga, "rag_soc_1")
//				kst_tab_clienti.codice = kdwc_x.getitemnumber(k_riga, "id_cliente")
//				post put_video_cliente(kst_tab_clienti)
//			end if
//		end if
//		

	case "COD_CLI" 
		if len(trim(data)) > 0 and isnumber(trim(data)) then 
			dw_dett_0.getchild(dwo.name, kdwc_x)
			k_riga = kdwc_x.find( "id_cliente = " + trim(data) + " " , 1, kdwc_x.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = long(trim(data))
				get_dati_cliente(kst_tab_clienti)
				post put_video_cliente(kst_tab_clienti)
			else
				dw_dett_0.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
			end if
		else
			kst_tab_clienti.codice = 0
			kst_tab_clienti.rag_soc_10 = ""
			post put_video_cliente(kst_tab_clienti)
		end if

		
	case "SC_CF" 
		k_sc_cf = RightTrim(trim(data))
		if isnull(k_sc_cf) = false and LenA(trim(k_sc_cf)) > 0 then
			
			k_rc = dw_dett_0.getchild("sl_pt", kdwc_x_sl_pt) 
			k_rc = dw_dett_0.getchild("sc_cf", kdwc_x)
			k_riga = kdwc_x.rowcount()
			k_rc = kdwc_x.find("codice = '"+trim(k_sc_cf)+"' ",0,k_riga)
			k_riga = k_rc
			if k_riga <= 0 or isnull(k_riga) then
				k_return = 2
				dw_dett_0.setitem(row, "sc_cf_descr", "NON TROVATO (" + string(k_riga)+ ") ")
			else
				k_return = 2
				k_rc = dw_dett_0.setitem(row, "sc_cf", kdwc_x.getitemstring(k_riga, "codice"))
				k_rc = dw_dett_0.setitem(row, "sc_cf_descr", kdwc_x.getitemstring(k_riga, "descr"))
//--- se il codice CAPITOLATO contiene il SL-PT allora è quello da impostare 
				k_sl_pt =  dw_dett_0.getitemstring(row, "sl_pt")
				k_sl_pt_dwc =  kdwc_x.getitemstring(k_riga, "sl_pt")
				if not isnull(k_sl_pt_dwc) and Len(trim(k_sl_pt)) > 0 then
					if isnull(k_sl_pt) or Len(trim(k_sl_pt)) = 0 then
						k_rc = dw_dett_0.setitem(row, "sl_pt", k_sl_pt_dwc)
					end if
					//---- filtro da lista sl_pt quelli con il sc_cf impostato
					k_rc = kdwc_x_sl_pt.SetFilter("sc_cf = '" + trim(k_sc_cf) + "' ")
					k_rc = kdwc_x_sl_pt.Filter()
					if kdwc_x_sl_pt.rowcount() = 0 then
						k_rc = kdwc_x_sl_pt.SetFilter("")
						k_rc = kdwc_x_sl_pt.Filter()
					end if
				else
					k_rc = kdwc_x_sl_pt.SetFilter("")
					k_rc = kdwc_x_sl_pt.Filter()
				end if
			end if
		end if
			
		
	case "SL_PT" 

		k_sl_pt = RightTrim(trim(data))
		if isnull(k_sl_pt) = false and LenA(trim(k_sl_pt)) > 0 then
			
			k_rc = dw_dett_0.getchild("sl_pt", kdwc_x)
			k_rc = kdwc_x.find("cod_sl_pt =~""+(k_sl_pt)+"~"",0,kdwc_x.rowcount())
			k_riga = k_rc
			if k_riga <= 0 or isnull(k_riga) then
				k_return = 2
				dw_dett_0.setitem(row, "sl_pt_descr", "NON TROVATO")
			else
				k_return = 2
				dw_dett_0.setitem(row, "sl_pt", kdwc_x.getitemstring(k_riga, "cod_sl_pt"))
				dw_dett_0.setitem(row, "sl_pt_descr", kdwc_x.getitemstring(k_riga, "sl_pt_descr"))
			end if
			
		end if

		
	case "ID_MECA_CAUSALE" 

		if isnumber (trim(data)) then
			
			k_id_meca_causale = integer(trim(data))
			if isnull(k_id_meca_causale) = false and (k_id_meca_causale) > 0 then
				
				k_rc = dw_dett_0.getchild("id_meca_causale", kdwc_x)
				k_rc = kdwc_x.find("id_meca_causale = "+ string(k_id_meca_causale)+" ",0,kdwc_x.rowcount())
				k_riga = k_rc
				if k_riga <= 0 or isnull(k_riga) then
					k_return = 2
					dw_dett_0.setitem(row, "meca_causali_descrizione", "NON TROVATO")
				else
					k_return = 2
					dw_dett_0.setitem(row, "id_meca_causale", kdwc_x.getitemnumber(k_riga, "id_meca_causale"))
					dw_dett_0.setitem(row, "meca_causali_descrizione", kdwc_x.getitemstring(k_riga, "descrizione"))
				end if
				
			end if
		end if


end choose

return k_return



end event

event dw_dett_0::itemfocuschanged;call super::itemfocuschanged;//
long k_rc, k_riga
string k_sl_pt, k_sc_cf, k_dwc_sl_pt
datawindowchild kdwc_x, kdwc_x_sc_cf, kdwc_x_des


if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then

	choose case upper(dwo.name)

		case "RAG_SOC_10", "COD_CLI"  

//--- Attivo dw archivio Clienti
			k_rc = this.getchild("cod_cli", kdwc_x)
			if kdwc_x.rowcount() < 2 then
				kdwc_x.retrieve("%")
				k_rc = this.getchild("rag_soc_10", kdwc_x_des)
				kdwc_x.RowsCopy(kdwc_x.GetRow(), kdwc_x.RowCount(), Primary!, kdwc_x_des, 1, Primary!)
				kdwc_x.setsort( "id_cliente A")
				kdwc_x.sort( )
				k_rc = kdwc_x.insertrow(1)
				k_rc = kdwc_x_des.insertrow(1)
			end if	
//			k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_x)
//			if kdwc_x.rowcount() < 2 then
//				kdwc_x.retrieve("%")
//				kdwc_x.insertrow(1)
//			end if

		case "SC_CF" 

//--- Attivo dw archivio Capitolati
			k_rc = dw_dett_0.getchild("sc_cf", kdwc_x)
			if kdwc_x.rowcount() < 2 then
				kdwc_x.retrieve(0, "S")
				kdwc_x.insertrow(1)
			end if


		case "SL_PT" 

//--- Attivo dw archivio PT
			k_rc = dw_dett_0.getchild("sl_pt", kdwc_x)
			if kdwc_x.rowcount() < 2 then
				kdwc_x.retrieve()
				kdwc_x.insertrow(1)
			end if

//--- se il codice CAPITOLATO contiene il SL-PT allora è quello da impostare 
			k_sc_cf = dw_dett_0.getitemstring(row, "sc_cf")
			if not isnull(k_sc_cf) and Len(trim(k_sc_cf)) > 0 then
//				k_rc = dw_dett_0.getchild("sc_cf", kdwc_x)
//--- Attivo dw archivio Capitolati
				k_rc = dw_dett_0.getchild("sc_cf", kdwc_x_sc_cf)
				if kdwc_x_sc_cf.rowcount() < 2 then
					kdwc_x_sc_cf.retrieve(0, "S")
					kdwc_x_sc_cf.insertrow(1)
				end if
				k_riga = kdwc_x.find("sc_cf = '" + trim(k_sc_cf) + "' ", 1, kdwc_x.RowCount())
				if k_riga > 0 then
					k_dwc_sl_pt =  kdwc_x.getitemstring(k_riga, "cod_sl_pt")
					if not isnull(k_dwc_sl_pt) and Len(trim(k_dwc_sl_pt)) > 0 then
						k_sl_pt =  dw_dett_0.getitemstring(row, "sl_pt")
						if isnull(k_sl_pt) or Len(trim(k_sl_pt)) = 0 then
							k_rc = dw_dett_0.setitem(row, "sl_pt", trim(k_dwc_sl_pt))
						end if
						//---- filtro da lista sl_pt quelli con il sc_cf impostato
						k_rc = kdwc_x.SetFilter("sc_cf = '" + trim(k_sc_cf) + "' ")
						k_rc = kdwc_x.Filter()
						if kdwc_x.rowcount() = 0 then
							k_rc = kdwc_x.SetFilter("")
							k_rc = kdwc_x.Filter()
						end if
					else
						k_rc = kdwc_x.SetFilter("")
						k_rc = kdwc_x.Filter()
						
					end if
				end if
			end if

		case "ID_MECA_CAUSALE" 

//--- Attivo dw archivio CAUSALI
			k_rc = dw_dett_0.getchild("id_meca_causale", kdwc_x)
			if kdwc_x.rowcount() < 2 then
				kdwc_x.retrieve()
				kdwc_x.insertrow(1)
			end if

	end choose
end if

end event

event dw_dett_0::buttonclicked;call super::buttonclicked;//
string k_errore
int k_rc
st_esito kst_esito
st_open_w kst_open_w 


SetPointer(kkg.pointer_attesa)

choose case dwo.name

	case "b_et_bcode_note"
		
		if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore

		kdsi_elenco_output.dataobject = "d_contratti_l_et_bcode_note" 
		kdsi_elenco_output.settransobject ( kguo_sqlca_db_magazzino )
		kdsi_elenco_output.retrieve() 

		kst_open_w.key1 = "Elenco Note Etichette Dosimetri " 

		if kdsi_elenco_output.rowcount() > 0 then
			
			kdsi_elenco_output.insertrow(1) 
			kst_open_w.id_programma =kkg_id_programma_elenco
			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
			kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = trim(kiw_this_window.title)   //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key6 = dwo.name    //--- nome del campo cliccato
			kst_open_w.key7 = "S"    //--- chiude Window dopo scelta
			kst_open_w.key12_any = kdsi_elenco_output
			kst_open_w.key10_window_chiamante = kiw_this_window
			kGuf_menu_window.open_w_tabelle(kst_open_w)
		else
			messagebox(kst_open_w.key1, "Nessun valore disponibile. ")
		end if

end choose


SetPointer(kkg.pointer_default)

end event

event dw_dett_0::editchanged;call super::editchanged;//
int k_len[10], k_ini=1, k_last_pos=1
int k_i = 1, k_ctr
string k_str


if dwo.name = "et_bcode_note" then
	
	this.post event u_note_calc_len(data)

end if


end event

event dw_dett_0::retrieveend;call super::retrieveend;//
if this.rowcount( ) > 0 then
	event u_note_calc_len(trim(this.getitemstring(1, "et_bcode_note")))
end if
end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_contratti
integer x = 0
integer y = 744
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_contratti
integer y = 176
integer width = 3291
integer height = 732
string dataobject = "d_contratti_l"
boolean ki_link_standard_sempre_possibile = true
end type

type dw_guida from w_g_tab0`dw_guida within w_contratti
event u_put_codice ( string a_tipo,  string a_codice )
event u_clear ( )
event u_dwc_retrieve ( )
event type long u_get_id_cliente ( string a_dacercare )
boolean visible = true
integer x = 0
integer y = 0
integer width = 3342
integer height = 124
boolean enabled = true
string dataobject = "d_contratti_guida"
end type

event dw_guida::u_put_codice(string a_tipo, string a_codice);/*
  carica il codice sulla stringa di ricerca
*/
string k_tipo


choose case a_tipo
	case "DATASCAD"
		dw_guida.setitem(1, "datascad", date(trim(a_codice)))
	case else
		choose case a_tipo
			case "CO"
				k_tipo = "CO"
			case "CLIENTE"
				k_tipo = "C"
			case "ID"
				k_tipo = "ID"
		end choose
		this.setitem(1, "rag_soc_1", k_tipo+trim(a_codice))
end choose


end event

event dw_guida::u_clear();//
	this.setitem(1, "rag_soc_1", "")
	this.setitem(1, "id_cliente", 0)


end event

event dw_guida::u_dwc_retrieve();//
datawindowchild kdwc_1


if this.getchild("rag_soc_1", kdwc_1) > 0 then 
	if kdwc_1.rowcount( ) = 0 then
		kdwc_1.settransobject(kguo_sqlca_db_magazzino)
		if kdwc_1.retrieve() > 0 then
			kdwc_1.insertrow(0)
		end if
	end if
end if


end event

event type long dw_guida::u_get_id_cliente(string a_dacercare);//
long k_row
datawindowchild kdwc_1


if this.getchild("rag_soc_1", kdwc_1) < 0 then 
	this.setitem(1, "rag_soc_1", "ERRORE IN RICERCA DI: " + a_dacercare)
	return 0
end if

choose case true
	case isnumber(a_dacercare)
		k_row = kdwc_1.find( "id_cliente = "+a_dacercare, 1, kdwc_1.rowcount())
		if k_row > 0 then
			this.setitem(1, "rag_soc_1", kdwc_1.getitemstring(k_row, "rag_soc_1"))
		else
			this.setitem(1, "rag_soc_1", "CODICE NON TROVATO: " + a_dacercare)
		end if			
		return long(a_dacercare)
		
	case else
		k_row = kdwc_1.getrow( )
		if k_row = 0 then
			k_row = kdwc_1.find( "rag_soc_1 like '"+a_dacercare+"%'", 1, kdwc_1.rowcount())
		end if
		if k_row > 0 then
			this.setitem(1, "rag_soc_1", kdwc_1.getitemstring(k_row, "rag_soc_1"))
			return kdwc_1.getitemnumber(k_row, "id_cliente")
		else
			this.setitem(1, "rag_soc_1", "NON TROVATO: " + a_dacercare)
			return 0
		end if
end choose

end event

event dw_guida::ue_buttonclicked;//---	
//--- 
//---
st_esito kst_esito
string k_dacercare
long k_row


try
	kst_esito =	kguo_exception.inizializza( this.classname())
	
	ki_st_tab_contratti_arg.mc_co = ""
	ki_st_tab_contratti_arg.cod_cli = 0
	ki_st_tab_contratti_arg.codice = 0
	
	k_dacercare = upper(trim(dw_guida.getitemstring(1, "rag_soc_1")))
	
	choose case true
		case left(k_dacercare,2) = "ID" and isnumber(mid(k_dacercare,3))
			ki_st_tab_contratti_arg.codice = long(mid(k_dacercare,3))
		case left(k_dacercare,3) = "CO:" 
			ki_st_tab_contratti_arg.mc_co = mid(k_dacercare,4)
		case k_dacercare > " "
			ki_st_tab_contratti_arg.cod_cli = this.event u_get_id_cliente(k_dacercare)
			if ki_st_tab_contratti_arg.cod_cli > 0 then
			else
				kst_esito.esito = kkg_esito.no_esecuzione
			end if
		case else
			ki_st_tab_contratti_arg.cod_cli = 0  // TUTTI I CONTRATTI
	end choose

	this.setitem(1, "id_cliente", ki_st_tab_contratti_arg.cod_cli)
			
	if kst_esito.esito = kkg_esito.ok then
		
		ki_data_scad =  dw_guida.getitemdate(1, "datascad")
		k_dacercare += string(ki_data_scad)
	
	//--- solo se ricerco un cliente diverso o altro parametro cambiato
		if ki_ultimo_codice_cercato <> k_dacercare then
			ki_ultimo_codice_cercato = k_dacercare
			u_retrieve_dw_lista()
		end if
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try
end event

event dw_guida::clicked;call super::clicked;//
if dwo.name = "b_clear" then
	event u_clear()
end if

end event

event dw_guida::losefocus;/*
   INIBITO PERCHE' FA CASINO CON IL DROPBOX DELLA DATA
*/
if this.getcolumnname() = "rag_soc_1" then
	super::event losefocus( )
end if

end event

event dw_guida::getfocus;/*
   INIBITO PERCHE' FA CASINO CON IL DROPBOX DELLA DATA
*/
if this.getcolumnname() = "rag_soc_1" then
	super::event getfocus( )
end if


end event

event dw_guida::itemfocuschanged;//
end event

type st_duplica from w_g_tab0`st_duplica within w_contratti
end type

type dw_data_change from uo_d_std_1 within w_contratti
integer x = 814
integer y = 360
integer width = 2610
integer height = 700
integer taborder = 80
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "MODIFICA MASSIVA DELLA DATA DI SCADENZA"
string dataobject = "d_contratti_data_change"
boolean controlmenu = true
boolean hsplitscroll = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;//
st_stampe kst_stampe
int k_msg
long k_upd
date k_data, k_data_min
pointer oldpointer  // Declares a pointer variable

	
//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)
	

if dwo.name = "b_ok" then
	
	this.visible = false
	
	k_data_min = relativedate(kguo_g.get_dataoggi( ), -2)
	k_data  = this.getitemdate( 1, "kdata")
	if k_data > k_data_min and dw_lista_0.rowcount() > 0 then 
		k_msg = messagebox("Modifica Contratti", "Confermare il cambio della data di scadenza al " + string(k_data, "dd mmm yy") + " di tutti i " + string(dw_lista_0.rowcount()) + " Contratti presenti in elenco", question!, yesno!, 2) 
		if k_msg = 1 then
			try 
				k_upd = u_modifica_massiva_data_scad_esegue()
				if k_upd > 0 then
					inizializza()
					messagebox("Operazione Completata", "Sono state cambiate " + string(k_upd) + " date di scadenza al "  + string(k_data, "dd mmm yy") + " in modo corretto.", information!)
				else
					messagebox("Aggiornamento Incompleto", "Non è stata cambiata alcuna data di scadenza, prego controllare.", stopsign!)
				end if
			catch (uo_exception kuo_exception)
				messagebox("Aggiornamento Fallito", "Si sono verificati errori durante l'operazione di aggiornamento delle fate di scadenza. Errore: " + kguo_exception.get_errtext( ), stopsign!)
			end try				
		end if
	else
		messagebox("Modifica Contratti", "Cambio data di scadenza non possibile, indicare una data superiore al "  + string(k_data_min, "dd mmm yy") + " e almeno un Contratto in elenco!", stopsign!)
	end if

else
	if dwo.name = "b_annulla" then

		this.visible = false
	
	end if
end if

SetPointer(oldpointer)


end event

event ue_visibile;call super::ue_visibile;//
int k_rc
	
	if this.visible then
		this.visible = false
		return
	end if

	this.width = long(this.object.k_titolo_t.x) + long(this.object.k_titolo_t.width) + 100
	this.height = long(this.object.b_ok.y) + long(this.object.b_ok.height) * 1.5 + 160

	this.x = (kiw_this_window.width  - this.width) / 4
	this.y = (kiw_this_window.height - this.height) / 4

	this.reset()
	k_rc = this.insertrow(0)
	k_rc = this.setitem(1, "kdata", ki_data_scad)
	k_rc = this.setitem(1, "knco", dw_lista_0.rowcount( ) )
	this.visible = true
	this.setfocus()
end event

