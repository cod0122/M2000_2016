$PBExportHeader$w_email_invio.srw
forward
global type w_email_invio from w_g_tab0
end type
type dw_segnaposto_l from uo_d_std_1 within w_email_invio
end type
end forward

global type w_email_invio from w_g_tab0
integer width = 2994
integer height = 1984
string title = ""
boolean maxbox = false
boolean ki_toolbar_window_presente = true
dw_segnaposto_l dw_segnaposto_l
end type
global w_email_invio w_email_invio

type variables
//
private kuf_email_invio kiuf_email_invio
private st_tab_email_invio ki_st_tab_email_invio, ki_st_tab_email_invio_1, ki_st_tab_email_invio_2
private string ki_path_centrale =""

private string ki_mostra_nascondi_in_lista = "S"

private long ki_ultimo_clie_3_cercato=999999
private string ki_guida_da_cercare

end variables

forward prototypes
public function string inizializza ()
private function string check_dati ()
private function string cancella ()
protected function integer visualizza ()
protected subroutine attiva_menu ()
public subroutine mostra_nascondi_in_lista ()
protected subroutine smista_funz (string k_par_in)
protected function integer inserisci ()
private function integer modifica ()
protected subroutine open_start_window ()
private subroutine get_path_lettera ()
private subroutine get_path_allegati ()
private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti)
public subroutine set_iniz_dati_cliente (ref st_tab_clienti kst_tab_clienti)
public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti)
protected subroutine set_titolo_window_personalizza ()
public function long invio_email ()
protected subroutine riempi_id ()
private subroutine get_allegati_file ()
private subroutine u_vedi_lettera () throws uo_exception
public subroutine u_placeholder_show ()
private subroutine u_modifica_comunicazione () throws uo_exception
public subroutine u_open_files_allegati (string k_files)
public subroutine u_open_path_allegati (string k_path)
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
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


//	if ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.inserimento then 
//		
//		cb_inserisci.postevent(clicked!)
//		
//	else

//=== Legge le righe del dw salvate l'ultima volta (importfile)
		if ki_st_open_w.flag_primo_giro = "S" then 
	
			k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)
	
		end if
			
		
		if k_importa <= 0 then // Nessuna importazione eseguita
	
			if dw_lista_0.retrieve( ki_st_tab_email_invio_1.id_email_invio, ki_st_tab_email_invio_1.cod_funzione, ki_st_tab_email_invio_2.cod_funzione ) < 1 then

				k_return = "1Email Non trovate  "
	
				SetPointer(oldpointer)
				if ki_st_open_w.flag_primo_giro = "S" then 
					messagebox("Lista 'E-mail' Vuota", "Nesun Codice Trovato per la richiesta fatta")
				end if
			else
				
				if ki_st_open_w.flag_primo_giro = "S" then 
					k_riga = 1
//--- se ho passato anche il ID allora....
					if ki_st_tab_email_invio.id_email_invio > 0 then
						k_riga = dw_lista_0.find( "id_email_invio = " + string(ki_st_tab_email_invio.id_email_invio) + " ", 1, dw_lista_0.rowcount( ) )
					end if
					if k_riga > 0 then 
						dw_lista_0.selectrow( 0, false)
						dw_lista_0.scrolltorow( k_riga)
						dw_lista_0.setrow( k_riga)
						dw_lista_0.selectrow( k_riga, true)
					end if
					
//--- se entro per modificare allora....
					if ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.modifica then 
						cb_modifica.postevent(clicked!)
					end if
				end if
	
			end if		
		end if
	
//	end if
	attiva_tasti()
	
 	SetPointer(oldpointer)
	
return k_return



end function

private function string check_dati ();//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===                : 3=dati insufficienti; 4=OK con errori non gravi
//===                      : 5=OK con avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
//=== Controllo dati inseriti
string k_return = ""
string k_errore = "0"
int k_rc=0
long k_riga
string k_descr=""
kuf_email kuf1_email
st_tab_email_invio kst_tab_email_invio
st_email_address kst_email_address
st_esito kst_esito

		
   k_riga = dw_dett_0.getrow()

   kst_tab_email_invio.email = dw_dett_0.getitemstring ( k_riga, "email") 
   if trim(kst_tab_email_invio.email) > " " then
		
//--- Controllo sintassi Indirizzi email				
		kst_email_address.email_all = kst_tab_email_invio.email
		if len(trim(kst_email_address.email_all)) > 0 then
			try
				kuf1_email = create kuf_email
				if kuf1_email.get_email_from_string(kst_email_address) > 0 then
					dw_dett_0.setitem(k_riga, "email", kst_email_address.email_all)
				end if
			catch (uo_exception kuo_exception)
				kst_esito = kuo_exception.get_st_esito()
				k_return = trim(k_return) + "Indirizzo e-mail non corretto: " &
				+"~n~r" + kst_esito.sqlerrtext + "~n~r" 
				k_errore = "4"
			finally 
				if isvalid(kuf1_email) then destroy kuf1_email
			end try
		end if

	else
      k_return = k_return + "Manca indirizzo e-mail" + "~n~r"
      k_errore = "3"

   end if

   
//--- errori diversi
   if trim(k_errore) = "0" or trim(k_errore) = "4"  or trim(k_errore) = "5" then
      if dw_dett_0.getitemstring ( k_riga, "flg_allegati") = "N" then
		else
         if trim(dw_dett_0.getitemstring(dw_dett_0.getrow(), "allegati_cartella")) > " " &
					  		or trim(dw_dett_0.getitemstring(dw_dett_0.getrow(), "allegati_pathfile")) > " " then 
			else
            k_return = k_return + "Indicata la presenza di allegati ma manca la Cartella o l'Archivio" + "~n~r" 
            k_errore = "3"
			end if
      end if

      if isnull(dw_dett_0.getitemstring(dw_dett_0.getrow(), "oggetto")) & 
               or len(trim(dw_dett_0.getitemstring(dw_dett_0.getrow(), "oggetto"))) = 0 then 
         k_return = k_return + "Manca Oggetto " + "~n~r" 
         k_errore = "3"
      end if

      if trim(dw_dett_0.getitemstring(dw_dett_0.getrow(), "link_lettera")) > " " & 
               or trim(dw_dett_0.getitemstring(dw_dett_0.getrow(), "lettera")) > " " then 
		else
         k_return = k_return + "Manca il corpo della Comunicazione " + "~n~r" 
         k_errore = "3"
      end if
      
   end if


//--- se nessun errore grave
   if trim(k_errore) > "3" or trim(k_errore) = "0"then

//--- Non tollerati i campo a NULL
      if isnull(dw_dett_0.getitemstring(k_riga, "flg_allegati")) then
         k_rc=dw_dett_0.setitem(k_riga, "flg_allegati", kiuf_email_invio.ki_allegati_no )
      end if
      if isnull(dw_dett_0.getitemstring(k_riga, "flg_lettera_html")) then
         k_rc=dw_dett_0.setitem(k_riga, "flg_lettera_html", kiuf_email_invio.ki_lettera_html_no )
      end if
      if isnull(dw_dett_0.getitemstring(k_riga, "flg_ritorno_ricev")) then
         k_rc=dw_dett_0.setitem(k_riga, "flg_ritorno_ricev", kiuf_email_invio.ki_ricev_ritorno_si )
      end if


   end if
   

return trim(k_errore) + trim(k_return)


end function

private function string cancella ();//
//--- Cancellazione rekord dal DB
//--- Ritorna : "0"=OK "1...."=KO 
//
string k_return=""
string k_errore = "0 "
long k_riga, k_righe, k_riga_last, k_row_deleted
string k_descr
string k_codice
st_tab_email_invio kst_tab_email_invio
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

//--- quante righe da cancellare?
k_riga = 0
k_riga = dw_lista_0.getselectedrow(k_riga)	
do while k_riga > 0

	k_righe ++
	k_riga_last = k_riga
	k_riga = dw_lista_0.getselectedrow(k_riga)	

loop

k_riga = dw_lista_0.getselectedrow(0)	
if k_riga > 0 then
	k_codice = string(dw_lista_0.getitemnumber(k_riga, "id_email_invio"))
	k_descr = "Cliente " + string(dw_lista_0.getitemnumber(k_riga, "id_cliente")) &
					+ " " + trim(dw_lista_0.getitemstring(k_riga, "rag_soc_10")) & 
					+ ", email: " + trim(dw_lista_0.getitemstring(k_riga, "email"))
end if

if isnull(k_codice) then
	k_codice = ". "
end if
if isnull(k_descr) = true or trim(k_descr) = "" then
	k_descr = ". " 
end if

if k_righe > 1 then
	k_descr = "ATTENZIONE Cancellare: " + string(k_righe) + " email." + "~n~r " &
					+ "Primo codice " + trim(k_codice) &
	            + " e ultimo codice " + string(dw_lista_0.getitemnumber(k_riga_last, "id_email_invio")) 
else
	k_descr = "Sei sicuro di voler Cancellare: il CODICE : " + trim(k_codice) + "~n~r " &
	             + trim(k_descr)
end if

if k_riga > 0 and isnull(k_codice) = false then	
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina Email" , k_descr, &
				question!, yesno!, 2) = 1 then

		try 
 
//--- quante righe da cancellare?
			kst_tab_email_invio.st_tab_g_0.esegui_commit = "N"
			k_riga = 0
			k_riga = dw_lista_0.getselectedrow(k_riga)	
			do while k_riga > 0 and kst_esito.esito = kkg_esito.ok
	
				kst_tab_email_invio.id_email_invio = dw_lista_0.getitemnumber(k_riga, "id_email_invio") 
	
				if kst_tab_email_invio.id_email_invio > 0 then
					if kiuf_email_invio.tb_delete(kst_tab_email_invio) then  //--- DELETE
						k_row_deleted ++
					end if
				end if
				k_riga = dw_lista_0.getselectedrow(k_riga)	
				
			loop
				
			if k_row_deleted > 0 then
	//--- Se tutto OK faccio la COMMIT		
				kguo_sqlca_db_magazzino.db_commit()
	
				k_riga = 0
				k_riga = dw_lista_0.getselectedrow(k_riga)	
				do while k_riga > 0 
					dw_lista_0.deleterow(k_riga)
					k_riga = dw_lista_0.getselectedrow(k_riga - 1)	
				loop
			end if
	
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
			k_errore = "1Operazione fallita!! ~n~rErrore: " + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
			kguo_sqlca_db_magazzino.db_rollback()
				
			messagebox("Problemi durante Cancellazione", MidA(k_errore, 2) ) 	

		end try

		attiva_tasti()
		dw_lista_0.setfocus()

	else
		messagebox("Elimina Email" , "Operazione Annullata.")
	end if
	dw_dett_0.setcolumn(1)
	
else
	messagebox("Elimina Email" , "Selezionare un EMAIL da cancellare!")

end if

k_return = k_errore

return(k_return)
//

end function

protected function integer visualizza ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_rc, k_taborder
long k_key
datawindowchild kdwc_clienti_d
kuf_utility kuf1_utility


	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_email_invio")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione

	k_return = dw_dett_0.retrieve( k_key ) 

//
//--- protezione campi per impedire la modifica
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
//	kuf1_utility.u_proteggi_dw("1", "b_path_lettera", dw_dett_0)
	destroy kuf1_utility

	attiva_tasti()

return k_return

end function

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu


//
//--- Attiva/Dis. Voci di menu personalizzate
//

//	if not ki_menu.m_strumenti.m_fin_gest_libero2.visible then
//		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Mostra/Nascondi E-mail Inviate"
//		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Mostra o Nasconde le E-mail Inviate"
//		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
//		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = true
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Nascondi,"+ki_menu.m_strumenti.m_fin_gest_libero2.text
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "DeleteRow!"
////		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
//	end if	

	if not m_main.m_strumenti.m_fin_gest_libero4.visible then
//		ki_menu.m_strumenti.m_fin_gest_libero4.text = "-"
//		ki_menu.m_strumenti.m_fin_gest_libero4.microhelp = ""
//		ki_menu.m_strumenti.m_fin_gest_libero4.visible = true
//		ki_menu.m_strumenti.m_fin_gest_libero4.enabled = false
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = true
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemText = ""
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName = ""
////		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2

		m_main.m_strumenti.m_fin_gest_libero5.text = "Invia E-mail"
		m_main.m_strumenti.m_fin_gest_libero5.microhelp = "Invia E-mail selezionate"
		m_main.m_strumenti.m_fin_gest_libero5.visible = true
		m_main.m_strumenti.m_fin_gest_libero5.enabled = true
		m_main.m_strumenti.m_fin_gest_libero5.toolbaritemVisible = true
		m_main.m_strumenti.m_fin_gest_libero5.toolbaritemText = "Invia,"+m_main.m_strumenti.m_fin_gest_libero5.text
		m_main.m_strumenti.m_fin_gest_libero5.toolbaritemName = "VCRNext!"
//		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritembarindex=2
	end if	

//---
	super::attiva_menu()



end subroutine

public subroutine mostra_nascondi_in_lista ();//
string k_filtro
boolean k_rc
kuf_base kuf1_base

	
	dw_lista_0.setredraw(false)
	
	if ki_mostra_nascondi_in_lista = "N" then	
		leggi_liste()
		k_filtro = "(data_inviato = date('1899.01.01') or isnull(data_inviato))"
	elseif ki_mostra_nascondi_in_lista = "*" then	
		leggi_liste()
		k_filtro = "data_inviato > date('1900.01.01')"
	else
		leggi_liste()
	end if
	if ki_st_tab_email_invio.id_cliente > 0 then
		if k_filtro > " " then k_filtro += " and "
		k_filtro += "id_cliente = " + string(ki_st_tab_email_invio.id_cliente)
	end if
	k_rc = dw_lista_0.u_filtra_record(k_filtro) 



end subroutine

protected subroutine smista_funz (string k_par_in);//
//===

choose case LeftA(k_par_in, 2) 



	case KKG_FLAG_RICHIESTA.libero2		//Mostra/Nascondi righe
		mostra_nascondi_in_lista()

	case KKG_FLAG_RICHIESTA.libero5		//Invio EMAIL
		invio_email()

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
kuf_utility kuf1_utility
st_esito kst_esito
datawindowchild kdwc_clienti_d



	ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento 

	dw_dett_0.reset()
	dw_dett_0.insertrow(0)
	
	dw_dett_0.setitem(dw_dett_0.getrow(), "id_email_invio", 0 )
	dw_dett_0.setitem(dw_dett_0.getrow(), "data_ins", kg_dataoggi )
	dw_dett_0.setitem(dw_dett_0.getrow(), "flg_allegati", kiuf_email_invio.ki_allegati_no )
	dw_dett_0.setitem(dw_dett_0.getrow(), "link_lettera", "" )
	dw_dett_0.setitem(dw_dett_0.getrow(), "flg_lettera_html", kiuf_email_invio.ki_lettera_html_no )
	dw_dett_0.setitem(dw_dett_0.getrow(), "flg_ritorno_ricev", kiuf_email_invio.ki_ricev_ritorno_si )

	dw_dett_0.setcolumn(1)
	
//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
//	kuf1_utility.u_proteggi_dw("0", "b_path_lettera", dw_dett_0)
	destroy kuf1_utility  

	attiva_tasti()

//=== Posiziona il cursore sul Data Windows
	dw_dett_0.ResetUpdate ( ) 
	dw_dett_0.setfocus() 


return (0)


end function

private function integer modifica ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_rc,  k_ctr, k_taborder
string k_style, k_rc1
long k_key
datawindowchild kdwc_clienti_d
kuf_utility kuf1_utility


	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_email_invio")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 

	k_return = dw_dett_0.retrieve( k_key ) 


//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility
   	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
		kuf1_utility.u_proteggi_dw("1", 1, dw_dett_0)
//		kuf1_utility.u_proteggi_dw("0", "b_path_lettera", dw_dett_0)
	end if


	attiva_tasti()

//=== Posiziona il cursore sul Data Windows
	dw_dett_0.SetColumn(1)
	dw_dett_0.ResetUpdate ( ) 
	dw_dett_0.setfocus() 


return k_return

end function

protected subroutine open_start_window ();//---
string k_esito
int k_rc
kuf_base kuf1_base
//st_tab_email_invio kst_tab_email_invio
datawindowchild kdwc_clienti_des, kdwc_clienti, kdwc_cliente_guida, kdwc_clie_settori
datawindowchild kdwc_gru, kdwc_clie_tipo, kdwc_iva, kdwc_pag, kdwc_oggetto
kuf_email_funzioni kuf1_email_funzioni


	kiuf_email_invio = create kuf_email_invio

	ki_toolbar_window_presente=true

//--- get la path centrale
	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base( "path_centrale")
	if left(k_esito,1) <> "0" then
		ki_path_centrale = ""
//		kst_esito.esito = kkg_esito.db_ko  
//		kst_esito.sqlcode = 0
//		kst_esito.SQLErrText = "Errore in lettura archivio BASE (get 'path_centrale') "
	else
		ki_path_centrale = trim(mid(k_esito,2))
	end if
	destroy kuf1_base

//--- Salva Argomenti programma chiamante
	if isnumber(trim(ki_st_open_w.key1)) then // ID su cui posizionarsi
		ki_st_tab_email_invio.id_email_invio = long(trim(ki_st_open_w.key1))
	else
		ki_st_tab_email_invio.id_email_invio = 0
	end if
	if trim(ki_st_open_w.key2) > " " then  // Indirizzo E-Mail 
		ki_st_tab_email_invio.email  = trim(ki_st_open_w.key2)
	else
		ki_st_tab_email_invio.email = ""
	end if
	try
		if isnumber(trim(ki_st_open_w.key3)) then // ID da cui iniziare a far vedere l'elenco
			ki_st_tab_email_invio_1.id_email_invio = long(trim(ki_st_open_w.key3))
			kiuf_email_invio.get_data_ins(ki_st_tab_email_invio_1)
		else
			ki_st_tab_email_invio_1.data_ins = relativedate(kg_dataoggi, -365)
			kiuf_email_invio.get_id_email_invio_minimo_x_data_ins(ki_st_tab_email_invio_1)	
			//ki_st_tab_email_invio_1.id_email_invio = kst_tab_email_invio.id_email_invio
		end if
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		ki_st_tab_email_invio_1.id_email_invio = 0
	end try

	if trim(ki_st_open_w.key4) > " " then // Funzione di provenienza da elencare
//--- se ho richiesto EMAIL di tipo FATTURA allora set dei due flag possibili		
		if trim(ki_st_open_w.key4) = kuf1_email_funzioni.kki_cod_funzione_fatturasiallegati or trim(ki_st_open_w.key4) = kuf1_email_funzioni.kki_cod_funzione_fatturaNOallegati then
			ki_st_tab_email_invio_1.cod_funzione = kuf1_email_funzioni.kki_cod_funzione_fatturasiallegati
			ki_st_tab_email_invio_2.cod_funzione = kuf1_email_funzioni.kki_cod_funzione_fatturanoallegati
		else
			ki_st_tab_email_invio_1.cod_funzione = trim(ki_st_open_w.key4)
			ki_st_tab_email_invio_2.cod_funzione = trim(ki_st_open_w.key4)
		end if
	else
		ki_st_tab_email_invio_1.cod_funzione = kuf1_email_funzioni.kki_cod_funzione_fatturasiallegati
		ki_st_tab_email_invio_2.cod_funzione = kuf1_email_funzioni.kki_cod_funzione_fatturanoallegati
	end if

	dw_guida.insertrow(0)
	dw_guida.getchild("rag_soc_1", kdwc_cliente_guida)
	dw_guida.setitem(1, "mostra", ki_mostra_nascondi_in_lista)
	kdwc_cliente_guida.settransobject( sqlca)
	kdwc_cliente_guida.retrieve("%")
	kdwc_cliente_guida.insertrow(1)

//--- Attivo dw archivio Clienti
	k_rc = dw_dett_0.getchild("id_cliente", kdwc_clienti)
	k_rc = kdwc_clienti.settransobject(sqlca)
	k_rc = kdwc_clienti.insertrow(1)

	k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_clienti_des)
	k_rc = kdwc_clienti_des.settransobject(sqlca)
	k_rc = kdwc_clienti_des.insertrow(1)

	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
		if kdwc_clienti.rowcount() < 2 then
			//kdwc_clienti.retrieve("%")
			kdwc_cliente_guida.RowsCopy(kdwc_cliente_guida.GetRow(), kdwc_cliente_guida.RowCount(), Primary!, kdwc_clienti, 1, Primary!)			
			kdwc_clienti.RowsCopy(kdwc_clienti.GetRow(), kdwc_clienti.RowCount(), Primary!, kdwc_clienti_des, 1, Primary!)
			kdwc_clienti.setsort( "id_cliente A")
			kdwc_clienti.sort( )
			//k_rc = kdwc_clienti.insertrow(1)
			//k_rc = kdwc_clienti_des.insertrow(1)
		end if
	end if
	
	
end subroutine

private subroutine get_path_lettera ();//
string k_file="", k_path_file="", k_path
int k_ret


k_file = dw_dett_0.getitemstring (1, "link_lettera")
if len(trim(k_file)) > 0 then
else
	k_file=""
end if

k_path = trim(ki_path_centrale) 
k_ret = GetFileOpenName ( "Scegliere la Comunicazione", k_path_file, k_file, "", " Comunicazioni (*.*), *.*" , k_path, 8)

if k_ret = 1 then
	dw_dett_0.setitem(1, "link_lettera", trim(k_path_file))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

private subroutine get_path_allegati ();//
string k_file=""
int k_ret
long ll_p
kuf_base  kuf1_base
string k_esito




k_file = dw_dett_0.getitemstring (1, "allegati_cartella")
if len(trim(k_file)) > 0 then
else
	kuf1_base = create kuf_base

	k_esito = kuf1_base.prendi_dato_base( "dir_fatt")
	if left(k_esito,1) <> "0" then
//		kst_esito.esito = kkg_esito.db_ko  
//		kst_esito.sqlcode = 0
//		kst_esito.SQLErrText = mid(k_esito,2)
	else
		k_file	= trim(mid(k_esito,2))
	end if
	destroy kuf1_base
	
end if

k_ret = GetFolder ( "Scegliere la Cartella con i documenti da allegare", k_file )

if k_ret = 1 then
	dw_dett_0.setitem(1, "allegati_cartella", trim(k_file))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente 
//


dw_dett_0.modify( "id_cliente.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
dw_dett_0.modify( "rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 

dw_dett_0.setitem( 1, "id_cliente", kst_tab_clienti.codice)
dw_dett_0.setitem( 1, "rag_soc_10", kst_tab_clienti.rag_soc_10 )

//attiva_tasti()


end subroutine

public subroutine set_iniz_dati_cliente (ref st_tab_clienti kst_tab_clienti);//			
kst_tab_clienti.codice = 0
kst_tab_clienti.rag_soc_10 = " "

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

protected subroutine set_titolo_window_personalizza ();//

super::set_titolo_window_personalizza()

choose case ki_mostra_nascondi_in_lista
   case 'N'  // solo i NON inviati
      this.title += " -  elenco solo e-mail Non ancora Inviate "
   case '*'  // solo  inviati
      this.title += " -  elenco solo e-mail Inviate "
   case else //faccio vedere tutto
      this.title += " -  elenco di Tutte le e-mail prodotte "
end choose

this.title +=  "dal " + string(ki_st_tab_email_invio_1.data_ins, "dd mmm yyyy")

end subroutine

public function long invio_email ();//
//--- Invia e-mail
//
long k_nr_invii=0, k_riga=0, k_ctr_invio=0, k_righe_sel=0, k_email_inviate = 0
string k_mail_no="", k_testo_msg=""
st_tab_email_invio kst_tab_email_invio
//st_esito kst_esito


try

	kguo_exception.inizializza(this.classname())

//--- calcola il nr di righe selezionate
	k_righe_sel = 0
	k_email_inviate = 0
	k_ctr_invio = dw_lista_0.getselectedrow(k_ctr_invio)
	do while k_ctr_invio > 0 
		k_righe_sel++
		if dw_lista_0.getitemdate(k_ctr_invio, "data_inviato") > date(1990,01,01) then 
			k_email_inviate++
		end if
		k_ctr_invio = dw_lista_0.getselectedrow(k_ctr_invio)
	loop 
	
	if dw_lista_0.getselectedrow(0) = 0 then
		
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_insufficienti )
		kguo_exception.setmessage("Nessun Invio effettuato, selezionare almeno una riga" )
		kguo_exception.messaggio_utente( )
		
	else

		k_testo_msg = "Vuoi inviare "
		if k_righe_sel > 1 then
			k_testo_msg += "le  " + string (k_righe_sel) + "  e-mail selezionate? "
		else
			k_testo_msg += "la e-mail selezionata? "
		end if
		if k_email_inviate > 0 then
			k_testo_msg += kkg.acapo + "Ma ATTENZIONE ce ne sono " + string(k_email_inviate) + " segnate come gia' INVIATE!! "
		end if
		
		if messagebox("Invio e-mail", k_testo_msg, Question!, YesNo!, 2) = 1 then
	
//--- INVIO delle email selezionate!	
			k_riga = dw_lista_0.getselectedrow(0)
			do while k_riga > 0 
		
				kst_tab_email_invio.id_email_invio = dw_lista_0.getitemnumber(k_riga, "id_email_invio") 
				
				try
					
//--- INVIO e-mail	
					if kiuf_email_invio.u_invio_email(kst_tab_email_invio) then
						k_nr_invii ++
					end if
					
				catch (uo_exception kuo1_exception)
					k_mail_no += trim(kuo1_exception.kist_esito.sqlerrtext) + "~n~r"
					
				end try
				
				k_riga = dw_lista_0.getselectedrow(k_riga)
			loop

		end if
	end if

	if k_nr_invii > 0 then
		
		leggi_liste()
		if trim(k_mail_no) > " " then
//--- scrivo sul log			
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
			kguo_exception.setmessage(" Msg anomalie e-mail: "  + trim(k_mail_no ))
			kguo_exception.scrivi_log( )
//msg utente			 
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ok )
			kguo_exception.setmessage("Sono state inviate " + string(k_nr_invii) + " e-mail.  Ma ci sono anomalie, vedi sotto: " + kkg.acapo + k_mail_no )
		else
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ok )
			kguo_exception.setmessage("Sono state inviate  " + string(k_nr_invii) + "  e-mail " )
		end if
	else
		kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_non_eseguito)
		kguo_exception.setmessage("Non sono state inviate e-mail " )
	end if
	kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ok )
	kguo_exception.messaggio_utente( )

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )
	
end try


return k_nr_invii


end function

protected subroutine riempi_id ();//
if dw_dett_0.rowcount() > 0 then
	dw_dett_0.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins())
	dw_dett_0.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente())
end if
end subroutine

private subroutine get_allegati_file ();//
string k_file="", k_path_file="", k_path
int k_ret
kuf_utility kuf1_utility


kuf1_utility = create kuf_utility

k_path_file = dw_dett_0.getitemstring (1, "allegati_pathfile")
if trim(k_path_file) > " " then
	k_file = kuf1_utility.u_get_nome_file(k_path_file)
	k_path = kuf1_utility.u_get_path_file(k_path_file)
end if

k_ret = GetFileOpenName ( "Scegliere il documento da allegare", k_path_file, k_file, "", "(*.*), *.*" , k_path, 8)

if k_ret = 1 then
	dw_dett_0.setitem(1, "allegati_pathfile", trim(k_path_file))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if

if isvalid(kuf1_utility) then destroy kuf1_utility
end subroutine

private subroutine u_vedi_lettera () throws uo_exception;//
st_tab_email_invio kst_tab_email_invio


kst_tab_email_invio.id_email_invio = dw_dett_0.getitemnumber(1, "id_email_invio")
kst_tab_email_invio.link_lettera = trim(dw_dett_0.getitemstring(1, "link_lettera"))
kst_tab_email_invio.lettera = trim(dw_dett_0.getitemstring(1, "lettera"))
kiuf_email_invio.u_anteprima_comunicazone(kst_tab_email_invio)



end subroutine

public subroutine u_placeholder_show ();//
setpointer(kkg.pointer_attesa)
dw_segnaposto_l.retrieve()
dw_segnaposto_l.move(this.width / 3 - dw_segnaposto_l.width / 2, this.height / 5)
dw_segnaposto_l.visible = true
dw_segnaposto_l.enabled = true
dw_segnaposto_l.setfocus()
setpointer(kkg.pointer_default)


end subroutine

private subroutine u_modifica_comunicazione () throws uo_exception;//
st_tab_email_invio kst_tab_email_invio


kst_tab_email_invio.link_lettera = trim(dw_dett_0.getitemstring(1, "link_lettera"))
kiuf_email_invio.u_comunicazione_modifica(kst_tab_email_invio)



end subroutine

public subroutine u_open_files_allegati (string k_files);//
kuf_utility kuf1_utility

					
	try
		kuf1_utility = create kuf_utility
		if k_files > " " then
			kuf1_utility.u_open_app_files(k_files)
		end if
		
	catch(uo_exception kuo_exception)
		kguo_exception.kist_esito = kuo_exception.get_st_esito()
		kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_non_eseguito)
		kguo_exception.setmessage( "Apertura documento Fallita: " +	kkg.acapo + k_files +	kkg.acapo + trim(kguo_exception.kist_esito.sqlerrtext))
		kguo_exception.messaggio_utente( )

	finally
		if isvalid(kuf1_utility) then destroy kuf1_utility
		
	end try

end subroutine

public subroutine u_open_path_allegati (string k_path);//
kuf_utility kuf1_utility

					
	try
		kuf1_utility = create kuf_utility
		if k_path > " " then
			kuf1_utility.u_open_app_file(k_path)
		end if
		
	catch(uo_exception kuo_exception)
		kguo_exception.kist_esito = kuo_exception.get_st_esito()
		kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_non_eseguito)
		kguo_exception.setmessage( "Apertura della cartella Fallita: " +	kkg.acapo + k_path +	kkg.acapo + trim(kguo_exception.kist_esito.sqlerrtext))
		kguo_exception.messaggio_utente( )

	finally
		if isvalid(kuf1_utility) then destroy kuf1_utility
		
	end try

end subroutine

on w_email_invio.create
int iCurrent
call super::create
this.dw_segnaposto_l=create dw_segnaposto_l
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_segnaposto_l
end on

on w_email_invio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_segnaposto_l)
end on

event close;call super::close;//
if isvalid(kiuf_email_invio) then destroy kiuf_email_invio

end event

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
int k_return
long k_riga_zoom
st_esito kst_esito
string k_email_add, k_email


if isvalid(kst_open_w) then

//--- Dalla finestra di ZOOM
	if (ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.modifica or ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.inserimento) & 
				and kst_open_w.id_programma = kkg_id_programma_elenco then
	
		if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore
	
		kdsi_elenco_input = kst_open_w.key12_any 
	
		k_riga_zoom = 0
		if isnumber(kst_open_w.key3) then k_riga_zoom = long(kst_open_w.key3)

		if kdsi_elenco_input.rowcount() > 0 and k_riga_zoom > 0  then

			k_return = k_riga_zoom
			
	 		if kst_open_w.key6 = "b_email_rubrica"  then  
		
				k_email_add = trim(kdsi_elenco_input.getitemstring(k_riga_zoom, "email"))  + ","
				k_email = trim(dw_dett_0.getitemstring( 1, "email"))
				if right(k_email,1) = ";" or right(k_email,1) = "," then
					k_email += k_email_add
				else
					k_email += "," + k_email_add
				end if
				dw_dett_0.setitem( 1, "email", k_email)
				post attiva_tasti( )
			end if
	
		end if

	end if

end if

return k_return


end event

type dw_print_0 from w_g_tab0`dw_print_0 within w_email_invio
end type

type st_ritorna from w_g_tab0`st_ritorna within w_email_invio
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_email_invio
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_email_invio
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_email_invio
integer x = 2350
integer y = 1348
end type

type st_stampa from w_g_tab0`st_stampa within w_email_invio
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_email_invio
integer x = 2350
integer y = 656
end type

type cb_modifica from w_g_tab0`cb_modifica within w_email_invio
integer x = 2350
integer y = 908
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_email_invio
integer x = 2350
integer y = 1200
end type

type cb_cancella from w_g_tab0`cb_cancella within w_email_invio
integer x = 2350
integer y = 1052
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_email_invio
integer x = 2350
integer y = 768
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_email_invio
integer y = 1032
integer width = 2747
integer height = 688
boolean enabled = true
string dataobject = "d_email_invio"
boolean border = true
string icon = "AppIcon!"
borderstyle borderstyle = styleraised!
boolean ki_link_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
end type

event dw_dett_0::editchanged;//soppressione codice del padre
end event

event dw_dett_0::buttonclicked;call super::buttonclicked;//

try
	if this.ki_flag_modalita = KKG_FLAG_RICHIESTA.modifica or this.ki_flag_modalita = KKG_FLAG_RICHIESTA.inserimento then 
		choose case dwo.name
				
			case "b_path_lettera" 
				get_path_lettera()
			
			case "b_path_allegati" 
				get_path_allegati()
				
			case "b_file_allegati"
				get_allegati_file()
		
		end choose
	end if
	
	choose case dwo.name
	
		case "p_img_lettera_vedi" 
			u_vedi_lettera()
	
		case "p_img_lettera_edit" 
			u_modifica_comunicazione( )
			
		case "b_vedi_allegati_pathfile"
			u_open_files_allegati(trim(this.getitemstring(1, "allegati_pathfile")))
	
		case "b_segnaposto_l"
			u_placeholder_show( )
	
	end choose

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

end try

end event

event dw_dett_0::itemchanged;call super::itemchanged;//
int k_errore=0
long k_riga, k_rc
st_esito kst_esito
st_tab_clienti kst_tab_clienti
datawindowchild kdwc_1



choose case 	lower(dwo.name)


	case "rag_soc_10" 
		if len(trim(data)) > 0 then 
			dw_dett_0.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "rag_soc_1 like '" + trim(data) + "%" +"'" , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = kdwc_1.getitemnumber( k_riga, "id_cliente")
				get_dati_cliente(kst_tab_clienti)
				post put_video_cliente(kst_tab_clienti)
			else
				dw_dett_0.object.id_cliente[1] = 0
				dw_dett_0.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
			end if
		else
			set_iniz_dati_cliente(kst_tab_clienti)
			post put_video_cliente(kst_tab_clienti)
		end if

	case "id_cliente" 
		if len(trim(data)) > 0 then 
			dw_dett_0.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "id_cliente = " + trim(data) + " " , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = long(trim(data))
				get_dati_cliente(kst_tab_clienti)
				post put_video_cliente(kst_tab_clienti)
			else
				dw_dett_0.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
			end if
		else
			set_iniz_dati_cliente(kst_tab_clienti)
			post put_video_cliente(kst_tab_clienti)
		end if


end choose 



return k_errore
	
end event

event dw_dett_0::itemfocuschanged;call super::itemfocuschanged;int k_rc
datawindowchild  kdwc_x, kdwc_x_des


choose case lower(dwo.name)


//--- Attivo dw archivio CLIENTI
	case "rag_soc_10", "id_cliente"
		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
			k_rc = this.getchild("id_cliente", kdwc_x)
			if kdwc_x.rowcount() < 2 then
				kdwc_x.retrieve("%")
				k_rc = this.getchild("rag_soc_10", kdwc_x_des)
				kdwc_x.RowsCopy(kdwc_x.GetRow(), kdwc_x.RowCount(), Primary!, kdwc_x_des, 1, Primary!)
				kdwc_x.setsort( "id_cliente A")
				kdwc_x.sort( )
				k_rc = kdwc_x.insertrow(1)
				k_rc = kdwc_x_des.insertrow(1)
			end if	
		end if

end choose

attiva_tasti()

end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_email_invio
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_email_invio
integer y = 32
integer width = 2866
integer height = 864
string dataobject = "d_email_invio_l"
boolean ki_link_standard_sempre_possibile = true
end type

event dw_lista_0::clicked;call super::clicked;//
if row > 0 then
	if mid(dwo.name,2,7) = "_attach" or dwo.name = "allegati_cartella" then
		if trim(this.getitemstring(row, "allegati_cartella")) > " " then
			u_open_path_allegati(trim(this.getitemstring(row, "allegati_cartella")))
		end if
	end if
	if mid(dwo.name,2,7) = "_attach" or dwo.name = "allegati_pathfile" then
		if trim(this.getitemstring(row, "allegati_pathfile")) > " " then
			u_open_files_allegati(trim(this.getitemstring(row, "allegati_pathfile")))
		end if
	end if
end if


end event

type dw_guida from w_g_tab0`dw_guida within w_email_invio
event u_search_reset ( )
event u_clear ( )
event ue_itemchanged ( string a_nome,  string a_dato )
integer width = 2802
integer height = 108
boolean enabled = true
string dataobject = "d_email_invio_guida"
end type

event dw_guida::u_search_reset();//
	ki_ultimo_clie_3_cercato = 999999
	ki_st_tab_email_invio.id_cliente = 0

end event

event dw_guida::u_clear();//
	this.setitem(1, "rag_soc_1", "")
	event u_search_reset()

end event

event dw_guida::ue_itemchanged(string a_nome, string a_dato);//
int k_errore=0
long k_riga
string k_rag_soc
st_stat_fatt kst_stat_fatt
st_tab_clienti kst_tab_clienti
kuf_clienti kuf1_clienti
datawindowchild kdwc_cliente, kdwc_prodotti

try
		
	choose case a_nome 
	
		case "rag_soc_1" 
			k_rag_soc = a_dato
			if LenA(k_rag_soc) > 0 then
				this.getchild("rag_soc_1", kdwc_cliente)
				if kdwc_cliente.rowcount() < 2 then
					kdwc_cliente.retrieve("%")
					kdwc_cliente.insertrow(1)
				end if
				k_riga=kdwc_cliente.find("upper(rag_soc_1) like '%"+upper(trim(k_rag_soc))+"%'",&
										0, kdwc_cliente.rowcount())
				if k_riga > 0 then
					this.post setitem(1, "id_cliente",	kdwc_cliente.getitemnumber(k_riga, "id_cliente"))
					this.post setitem(1, "rag_soc_1", 	trim(kdwc_cliente.getitemstring(k_riga, "rag_soc_1")))
				else
					this.post setitem(1, "rag_soc_1","Non trovato")
					this.post setitem(1, "id_cliente",0)
				end if
				k_errore = 1
			else
				this.post setitem(1, "id_cliente",0)
			end if
	
		case "id_cliente" 
			if isnumber(a_dato) then
				kst_stat_fatt.k_id_cliente = long(a_dato)
				if kst_stat_fatt.k_id_cliente > 0 then
					this.getchild("rag_soc_1", kdwc_cliente)
					if kdwc_cliente.rowcount() < 2 then
						kdwc_cliente.retrieve("%")
						kdwc_cliente.insertrow(1)
					end if
					k_riga=kdwc_cliente.find("id_cliente = "+string(kst_stat_fatt.k_id_cliente)+" ", 0, kdwc_cliente.rowcount())
					if k_riga > 0 then
						this.post setitem(1, "id_cliente",	kdwc_cliente.getitemnumber(k_riga, "id_cliente"))
						this.post setitem(1, "rag_soc_1", trim(kdwc_cliente.getitemstring(k_riga, "rag_soc_1")))
					else
						this.post setitem(1, "rag_soc_1","Nessun Listino caricato per questo cliente")
						this.post setitem(1, "id_cliente",kst_stat_fatt.k_id_cliente)
					end if
					k_errore = 1
				else
					this.post setitem(1, "id_cliente",0)
				end if
			end if
	
		case "e1an" 
			if isnumber(a_dato) then
				kuf1_clienti = create kuf_clienti
				kst_tab_clienti.e1an = long(a_dato)
				kst_stat_fatt.k_id_cliente = kuf1_clienti.get_codice_da_e1an(kst_tab_clienti)
				if kst_stat_fatt.k_id_cliente > 0 then
					this.getchild("rag_soc_1", kdwc_cliente)
					if kdwc_cliente.rowcount() < 2 then
						kdwc_cliente.retrieve("%")
						kdwc_cliente.insertrow(1)
					end if
					k_riga=kdwc_cliente.find("id_cliente = "+string(kst_stat_fatt.k_id_cliente)+" ", 0, kdwc_cliente.rowcount())
					if k_riga > 0 then
						this.post setitem(1, "id_cliente",	kdwc_cliente.getitemnumber(k_riga, "id_cliente"))
						this.post setitem(1, "rag_soc_1", trim(kdwc_cliente.getitemstring(k_riga, "rag_soc_1")))
					else
						this.post setitem(1, "rag_soc_1","Nessun Listino caricato per questo cliente")
						this.post setitem(1, "id_cliente",kst_stat_fatt.k_id_cliente)
					end if
					k_errore = 1
				else
					this.post setitem(1, "id_cliente",0)
				end if
			end if
	
	end choose 
	
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	if isvalid(kuf1_clienti) then destroy kuf1_clienti
	
end try

	



end event

event dw_guida::ue_buttonclicked;call super::ue_buttonclicked;//---
boolean k_elabora=true
string k_dacercare


	k_dacercare = trim(dw_guida.getitemstring(1, "rag_soc_1"))

	if ki_guida_da_cercare <> k_dacercare and k_dacercare > " " then
		ki_guida_da_cercare = k_dacercare
			
		if isnumber(k_dacercare) then
			this.event ue_itemchanged( "id_cliente", k_dacercare)
		else
			if left(k_dacercare,2) = "E1" then
				this.event ue_itemchanged( "e1an", mid(k_dacercare,3))
			else
				this.event ue_itemchanged( "rag_soc_1", k_dacercare)
			end if		
		end if
		ki_st_tab_email_invio.id_cliente = dw_guida.getitemnumber(1, "id_cliente")
	else
		if trim(k_dacercare) = "" then
			ki_st_tab_email_invio.id_cliente = dw_guida.setitem(1, "id_cliente", 0)
		end if		
	end if
	
//--- se cliente non trovato (quindi digitato ma il codice e' rimasto a zero), non faccio la retrieve
   if ki_st_tab_email_invio.id_cliente = 0 and k_dacercare > " " then
		dw_lista_0.reset( )
	else
//--- parte la query solo se ricerco un cliente diverso oppure sono ambiati i flag di ricerca
      if ki_ultimo_clie_3_cercato <> ki_st_tab_email_invio.id_cliente &
				or ki_mostra_nascondi_in_lista <> this.getitemstring(1, "mostra") &
			then

         ki_ultimo_clie_3_cercato = ki_st_tab_email_invio.id_cliente
			ki_mostra_nascondi_in_lista = this.getitemstring(1, "mostra")
			
			mostra_nascondi_in_lista( ) // legge dati
			
      end if
   end if

end event

event dw_guida::itemchanged;call super::itemchanged;//
if dwo.name = "mostra" then
	this.post event ue_buttonclicked("default")
end if
end event

event dw_guida::clicked;call super::clicked;//
if dwo.name = "b_clear" then
	event u_clear()
end if
end event

type st_duplica from w_g_tab0`st_duplica within w_email_invio
end type

type dw_segnaposto_l from uo_d_std_1 within w_email_invio
integer x = 32000
integer width = 1641
integer height = 1808
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "Segnaposti disponibili"
string dataobject = "d_placeholder_l"
boolean controlmenu = true
boolean resizable = true
boolean hsplitscroll = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_dw_visibile_in_open_window = false
end type

