$PBExportHeader$kuf_parent.sru
forward
global type kuf_parent from kuf_parent0
end type
end forward

global type kuf_parent from kuf_parent0
end type
global kuf_parent kuf_parent

type variables

end variables

forward prototypes
public function boolean u_open_applicazione (ref st_tab_g_0 kst_tab_g_0, string k_flag_modalita)
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
public function boolean u_open_ds (st_open_w ast_open_w) throws uo_exception
public subroutine _readme ()
public function boolean link_call (ref datastore ads_1, string a_campo_link) throws uo_exception
public function st_esito u_open ()
public function st_esito u_open (ref st_open_w ast_open_w)
public function st_esito u_open (string a_modalita)
public function st_esito u_open (st_tab_g_0 kst_tab_g_0[], st_open_w kst_open_w)
end prototypes

public function boolean u_open_applicazione (ref st_tab_g_0 kst_tab_g_0, string k_flag_modalita);//---
//--- Apre la Window x le diverse funzioni
//---
//--- Input: st_tab_wm_pklist.id_wm_pklist
//--- Out: TRUE = finestra aperta; FASE=operazione non eseguita
//---
boolean k_return = false
st_esito kst_esito 
st_open_w k_st_open_w


	if isnull(kst_tab_g_0.id) and k_flag_modalita = kkg_flag_modalita.elenco then
		kst_tab_g_0.id = 0
	end if
	
	if k_flag_modalita = kkg_flag_modalita.inserimento then
		kst_tab_g_0.id = 0
		kst_tab_g_0.idx = ""
	end if

	if not isnull(kst_tab_g_0.id) then 
		
	//=== Parametri : 
	//=== struttura st_open_w
	//=== dati particolare programma
		K_st_open_w.id_programma = get_id_programma( k_flag_modalita )
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = k_flag_modalita
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = " "
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = trim(string(kst_tab_g_0.id)) // id generico
		K_st_open_w.key2 = trim(kst_tab_g_0.idx) // id alfanumerico generico
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " " 
		K_st_open_w.flag_where = " "
	
		K_st_open_w.key12_any = this			// questo oggetto di gestione del trovo
	
		kGuf_menu_window.open_w_tabelle(k_st_open_w)
	
		k_return = true
	end if




return k_return


end function

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;//
//--- 
//--------------------------------------------------------------------------------------------------------------
//--- Funzione di ZOOM: attiva LINK cliccato 
//---
//--- Par. Inut: 
//---               datawindow con i dati da visualizzare oppure su cui è stato attivato il LINK
//---               nome campo di LINK 
//--- 
//--- Ritorna TRUE tutto OK - FALSE: link non effettuato
//---
//--- Lancia EXCEPTION con  ST_ESITO  standard
//---
//----------------------------------------------------------------------------------------------------------------
// 
long k_rc
boolean k_return=true
kuf_elenco kuf1_elenco
datastore kds_elenco_output   //ds da passare alla windows di elenco

//---  esempio:
//st_tab_certif kst_tab_certif
//st_esito kst_esito
st_open_w kst_open_w 


try
	
	SetPointer(kkg.pointer_attesa)

//---- le righe che seguono sono di un esempio personalizzato da un erede x sfruttare il nome campo del link passato
//kdsi_elenco_output = create datastore
//kst_esito.esito = kkg_esito.ok
//kst_esito.sqlcode = 0
//kst_esito.SQLErrText = ""
//kst_esito.nome_oggetto = this.classname()
//
//
//choose case k_campo_link
//
//	case "num_certif"
//		kst_tab_certif.num_certif = adw_link.getitemnumber(adw_link.getrow(), a_campo_link)
//		if kst_tab_certif.num_certif > 0 then
//			kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_certif )
//			if kst_esito.esito <> kkg_esito.ok then
//				kguo_exception.inizializza( )
//				kguo_exception.set_esito( kst_esito)
//				throw kguo_exception
//			end if
//			kst_open_w.key1 = "Attestato di Trattamento  (nr.=" + trim(string(kst_tab_certif.num_certif)) + ") " 
//		else
//			k_return = false
//		end if
//
//
//	case "b_certif_lotto"
//		kst_tab_certif.id_meca = adw_link.getitemnumber(adw_link.getrow(), "id_meca")
//		if kst_tab_certif.id_meca > 0 then
//			get_num_certif (kst_tab_certif)   //  piglia il NUMERO CERTIFICATO
//			kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_certif )
//			if kst_esito.esito <> kkg_esito.ok then
//				kguo_exception.inizializza( )
//				kguo_exception.set_esito( kst_esito)
//				throw kguo_exception
//			end if
//			kst_open_w.key1 = "Attestato di Trattamento  (nr.=" + trim(string(kst_tab_certif.num_certif)) + ") " 
//		else
//			k_return = false
//		end if
//
//end choose
//
//if k_return then
	kds_elenco_output = create datastore
	kds_elenco_output.dataobject = adw_link.dataobject
	adw_link.rowscopy(1,adw_link.rowcount(),Primary!,kds_elenco_output,1,Primary!)

	if kds_elenco_output.rowcount() > 0 then
	
//--- chiamare la window di elenco
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.key2 = trim(kds_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kds_elenco_output
		kuf1_elenco = create kuf_elenco
		kuf1_elenco.u_open(kst_open_w)

	else
		
		kguo_exception.inizializza( )
		kguo_exception.setmessage(u_get_errmsg_nontrovato(kst_open_w.flag_modalita) )
		throw kguo_exception
		
	end if

//end if
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_elenco) then destroy kuf1_elenco
	SetPointer(kkg.pointer_default)

end try


return k_return

end function

public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception;//------------------------------------------------------------------------------------------------------
//---  Controllo dati utente
//---  inp: datastore con i dati da controllare
//---  out: datastore con  	ads_inp.object.<nome campo>.tag che può valere:
//												0=tutto OK (kkg_esito.ok); 
//												1=errore logico (bloccante) (kkg_esito.ERR_LOGICO); 
//												2=errore forma  (bloccante) (kkg_esito.err_formale);
//												3=dati insufficienti  (bloccante) (kkg_esito.DATI_INSUFF);
//												4=KO ma errore non grave  (NON bloccante) (kkg_esito.DB_WRN);
//---							               	W=OK con degli avvertimenti (NON bloccante) (kkg_esito.DATI_WRN);
//---  rit: 
//---
//---  per errore lancia EXCEPTION anche x i warning
//---
//---  CONSIGLIO DI COPIARE DA QUESTO ESTENDENDO I CONTROLLI
//---
//------------------------------------------------------------------------------------------------------
//
int k_errori = 0
long k_nr_righe
int k_riga
string k_tipo_errore="0", k_type, k_valore
st_esito kst_esito



try
	kst_esito = kguo_exception.inizializza(this.classname())
	
// ESEMPIO
//	if trim(ads_inp.object.descr) > " "  then
//	else
//		k_errori ++
//		k_tipo_errore="3"      // errore in questo campo: dati insuff.
//		ads_inp.object.descr.tag = k_tipo_errore 
//		kst_esito.esito = kkg_esito.err_formale
//		kst_esito.sqlerrtext = "Manca descrizione nel campo " + trim(ads_inp.object.descr_t.text) +  "~n~r"  
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if
	
	k_nr_righe =ads_inp.rowcount()
	k_errori = 0
	k_riga =ads_inp.getnextmodified(0, primary!)

	do while k_riga > 0  and k_errori < 99

		k_type = ads_inp.Describe("#1.Coltype")
		if left(k_type,4) = 'char' then
			k_valore = trim(ads_inp.getitemstring ( k_riga, 1)) // presuppone un codice alfanumerico
		else
			k_valore = string(ads_inp.getitemnumber ( k_riga, 1), "#") // presuppone un codice numerico intero
		end if
		if k_valore > " " then  
			k_type = ads_inp.Describe("#2.Coltype")
			if left(k_type,4) = 'char' then
				k_valore = ads_inp.getitemstring ( k_riga, 2)
			else
				k_valore = string(ads_inp.getitemnumber ( k_riga, 1), "#") // presuppone un codice numerico intero
			end if
			if k_valore > " " then  // presuppone ci sia la descrizione
			else
				k_tipo_errore="3"      // errore in questo campo: dati insuff.
				ads_inp.modify("#2.tag = '" + k_tipo_errore + "' ")
				kst_esito.esito = kkg_esito.DATI_INSUFF
				if k_errori > 0 then kst_esito.sqlerrtext += kkg.acapo
				kst_esito.sqlerrtext = "Manca valore nel campo '" &
						+ trim(ads_inp.describe(ads_inp.describe("#2.name") + "_t.text")) &
						+ "' alla riga " + string(k_riga)
				k_errori ++
			end if
		else
			k_tipo_errore="3"      // errore in questo campo: dati insuff.
			ads_inp.modify("#1.tag = '" + k_tipo_errore + "' ")
			kst_esito.esito = kkg_esito.DATI_INSUFF
			if k_errori > 0 then kst_esito.sqlerrtext += kkg.acapo
			kst_esito.sqlerrtext = "Manca valore nel campo '" &
						+ trim(ads_inp.describe(ads_inp.describe("#1.name") + "_t.text")) &
						+ "' alla riga " + string(k_riga) 
			k_errori ++
		end if

		if k_tipo_errore = "0" or k_tipo_errore = "4" or k_tipo_errore = kkg_esito.DATI_WRN  then
			if ads_inp.find("#1 = '" + k_valore  + "'", k_riga, k_nr_righe) > 0 then
				k_tipo_errore="1"      // errore in questo campo: logico
				ads_inp.modify("#1.tag = '" + k_tipo_errore + "' ")
				kst_esito.esito = kkg_esito.ERR_LOGICO
				if k_errori > 0 then kst_esito.sqlerrtext += kkg.acapo
				kst_esito.sqlerrtext = "Codice " + k_valore + " già in elenco " 
				k_errori ++
			end if
		end if

		if k_tipo_errore <> "0"  and k_tipo_errore <> "4" and k_tipo_errore <> kkg_esito.DATI_WRN then
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		k_riga++
		k_riga = ads_inp.getnextmodified(k_riga, primary!)

	loop

	
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if k_errori > 0 then
		
	end if
	
end try


return kst_esito
 
 
 
end function

public function boolean u_open_ds (st_open_w ast_open_w) throws uo_exception;//
//--- Chiama la OPEN con nel key11 il ds con dentro i dati e key9 in nime del campo "id" della tabella 
//--- (se ci sono particolarità è meglio ereditarla e modificarla)
//---
//--- Input: st_open_w
//---
//
boolean k_return = false
boolean k_sicurezza = false 
long k_riga = 0
string k_type
//kuf_menu_window kuf1_menu_window


ast_open_w.id_programma = get_id_programma(ast_open_w.flag_modalita) //trim(ast_open_w.id_programma)

if ast_open_w.id_programma > " " then
	
	k_sicurezza = if_sicurezza(ast_open_w)
	if k_sicurezza then
		
		if ast_open_w.key9 > " " and ast_open_w.key11_ds.rowcount() > 0 then
			if ast_open_w.flag_modalita <> kkg_flag_modalita.inserimento then
				k_riga = ast_open_w.key11_ds.getrow()
				if k_riga = 0 then k_riga = 1
				k_type = left(ast_open_w.key11_ds.Describe( trim(ast_open_w.key9) + ".ColType"),4)
				if k_type = "!" then  //campo trovato?
					ast_open_w.key1 = ""
				else
					if k_type = "char" then  //tipo di dato, alfanum o numerico?
						ast_open_w.key1 = ast_open_w.key11_ds.getitemstring(k_riga, trim(ast_open_w.key9))
					else
						ast_open_w.key1 = string(ast_open_w.key11_ds.getitemnumber(k_riga, trim(ast_open_w.key9)))
					end if
				end if
			end if
		end if
		if ast_open_w.key1 > " " or ast_open_w.flag_modalita = kkg_flag_modalita.inserimento then
				
			k_return = true
			
			ast_open_w.flag_primo_giro = "S"
			
			//kuf1_menu_window = create kuf_menu_window 
			kGuf_menu_window.open_w_tabelle(ast_open_w)
				
		end if
		
	end if
end if


return k_return



end function

public subroutine _readme ();//-------------------------------------------------------------------------------------
//--- Questa non è una funziona ma solo un documento di spiegazione dell'oggetto
//-------------------------------------------------------------------------------------
//---
//--- Questo è l'oggetto PADRE di quasi tutti gli oggetti della Procedura
//--- 
//--- get_descrizione e get_id_programma: dalle tabelle menu_window e menu_window_oggetti
//--- if_sicurezza: verifica l'accesso dell'oggetto rispetto all'utente che lo sta usando - dalle tabelle della sicurezza sr_...
//--- u_open: lancio dell'ogetto se richiede di aprire una window ecc...

end subroutine

public function boolean link_call (ref datastore ads_1, string a_campo_link) throws uo_exception;//
//--- 
//--------------------------------------------------------------------------------------------------------------
//--- Funzione di ZOOM: attiva LINK cliccato 
//---
//--- Par. Inut: 
//---               datawindow con i dati da visualizzare oppure su cui è stato attivato il LINK
//---               nome campo di LINK 
//--- 
//--- Ritorna TRUE tutto OK - FALSE: link non effettuato
//---
//--- Lancia EXCEPTION con  ST_ESITO  standard
//---
//----------------------------------------------------------------------------------------------------------------
// 
long k_rc
boolean k_return=true
kuf_elenco kuf1_elenco
datastore kds_elenco_output   //ds da passare alla windows di elenco

//---  esempio:
//st_tab_certif kst_tab_certif
//st_esito kst_esito
st_open_w kst_open_w 


try
	
	SetPointer(kkg.pointer_attesa)

//---- le righe che seguono sono di un esempio personalizzato da un erede x sfruttare il nome campo del link passato
//kdsi_elenco_output = create datastore
//kst_esito.esito = kkg_esito.ok
//kst_esito.sqlcode = 0
//kst_esito.SQLErrText = ""
//kst_esito.nome_oggetto = this.classname()
//
//
//choose case k_campo_link
//
//	case "num_certif"
//		kst_tab_certif.num_certif = ads_1.getitemnumber(ads_1.getrow(), a_campo_link)
//		if kst_tab_certif.num_certif > 0 then
//			kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_certif )
//			if kst_esito.esito <> kkg_esito.ok then
//				kguo_exception.inizializza( )
//				kguo_exception.set_esito( kst_esito)
//				throw kguo_exception
//			end if
//			kst_open_w.key1 = "Attestato di Trattamento  (nr.=" + trim(string(kst_tab_certif.num_certif)) + ") " 
//		else
//			k_return = false
//		end if
//
//
//	case "b_certif_lotto"
//		kst_tab_certif.id_meca = ads_1.getitemnumber(ads_1.getrow(), "id_meca")
//		if kst_tab_certif.id_meca > 0 then
//			get_num_certif (kst_tab_certif)   //  piglia il NUMERO CERTIFICATO
//			kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_certif )
//			if kst_esito.esito <> kkg_esito.ok then
//				kguo_exception.inizializza( )
//				kguo_exception.set_esito( kst_esito)
//				throw kguo_exception
//			end if
//			kst_open_w.key1 = "Attestato di Trattamento  (nr.=" + trim(string(kst_tab_certif.num_certif)) + ") " 
//		else
//			k_return = false
//		end if
//
//end choose
//
//if k_return then
	kds_elenco_output = create datastore
	kds_elenco_output.dataobject = ads_1.dataobject
	ads_1.rowscopy(1,ads_1.rowcount(),Primary!,kds_elenco_output,1,Primary!)

	if kds_elenco_output.rowcount() > 0 then
	
//--- chiamare la window di elenco
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.key2 = trim(kds_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kds_elenco_output
		kuf1_elenco = create kuf_elenco
		kuf1_elenco.u_open(kst_open_w)

	else
		
		kguo_exception.inizializza( )
		kguo_exception.setmessage(u_get_errmsg_nontrovato(kst_open_w.flag_modalita) )
		throw kguo_exception
		
	end if

//end if
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_elenco) then destroy kuf1_elenco
	SetPointer(kkg.pointer_default)

end try


return k_return

end function

public function st_esito u_open ();//
//--- Chiama la OPEN senza particolari funzioni
//---
//--- Input: 
//---
//
boolean  k_return = true
st_tab_g_0 kst_tab_g_0[]
st_open_w kst_open_w
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""

	kst_tab_g_0[1].id = 0
	
	k_return = this.u_open_applicazione(kst_tab_g_0[1], kkg_flag_modalita.visualizzazione)
 
 	if not k_return then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Funzione richiesta non Eseguita: (id programma: " &
			               + trim(lower(get_id_programma(kkg_flag_modalita.visualizzazione)))+ ", modalita: " + trim(kkg_flag_modalita.visualizzazione) + ")~n~r"
	end if	
		

return kst_esito

end function

public function st_esito u_open (ref st_open_w ast_open_w);//---
//--- Apre la Window x le diverse funzioni
//---
//--- Input: st_open_w
//--- Out: TRUE = finestra aperta; FASE=operazione non eseguita
//---
//boolean k_return = false
string k_rc = ""
st_esito kst_esito 
//kuf_menu_window kuf1_menu_window


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""

	if trim(ast_open_w.flag_modalita) > " " then
	else
		ast_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	end if
	ast_open_w.id_programma = get_id_programma( ast_open_w.flag_modalita )
	ast_open_w.flag_primo_giro = "S"
	if trim(ast_open_w.flag_adatta_win) > " " then 
	else
		ast_open_w.flag_adatta_win = KKG.ADATTA_WIN
	end if
	if not isvalid(ast_open_w.key12_any) then ast_open_w.key12_any = this			// questo oggetto di gestione del trova

	//kuf1_menu_window = create kuf_menu_window 
	kGuf_menu_window.open_w_tabelle(ast_open_w)
	//destroy kuf1_menu_window
	//if k_rc = "1" then	
	//	k_return = true
	//end if


return kst_esito


end function

public function st_esito u_open (string a_modalita);//---
//--- Apre la Window x le diverse funzioni
//---
//--- Input: st_open_w
//--- Out: TRUE = finestra aperta; FASE=operazione non eseguita
//---
boolean k_return = false
st_open_w kst_open_w
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""

	kst_open_w.flag_modalita = a_modalita

	kst_esito = u_open(kst_open_w)


return kst_esito

end function

public function st_esito u_open (st_tab_g_0 kst_tab_g_0[], st_open_w kst_open_w);//
//--- Chiama la giusta Funzionalità
//---
//--- Input: st_tab_.... con ID valorizzato se serve,  st_open_w.flag_modalita = tipo funzione da richiamare
//---
//
//boolean  k_return = true
integer k_ind
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""


	k_ind=1 

		choose case kst_open_w.flag_modalita  
				

			case kkg_flag_modalita.stampa
//				this.u_open_vmcs(kst_tab_sped[])		
				
			case kkg_flag_modalita.cancellazione
				this.u_open_applicazione(kst_tab_g_0[k_ind], kkg_flag_modalita.cancellazione)
				
			case kkg_flag_modalita.modifica
				this.u_open_applicazione(kst_tab_g_0[k_ind], kkg_flag_modalita.modifica)
				
			case kkg_flag_modalita.inserimento
				this.u_open_applicazione(kst_tab_g_0[k_ind], kkg_flag_modalita.inserimento)
				
			case kkg_flag_modalita.visualizzazione
				this.u_open_applicazione(kst_tab_g_0[k_ind], kkg_flag_modalita.visualizzazione)
				
			case else
					
					
			end choose		
			
 
 
return kst_esito

end function

on kuf_parent.create
call super::create
end on

on kuf_parent.destroy
call super::destroy
end on

