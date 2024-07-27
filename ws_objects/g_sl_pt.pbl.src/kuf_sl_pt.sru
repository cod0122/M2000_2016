$PBExportHeader$kuf_sl_pt.sru
forward
global type kuf_sl_pt from kuf_parent
end type
end forward

global type kuf_sl_pt from kuf_parent
end type
global kuf_sl_pt kuf_sl_pt

type variables

//--- Tipi di prodotto
constant string ki_tipo_dispositivo_medico = "1"
constant string ki_tipo_prodotto_farmaceutico = "2"
constant string ki_tipo_prodotto_alimentare = "4"
constant string ki_tipo_altro = "3"

//--- Tipo Cicli di trattamento da mantenere NUMERICO cosi' corrsiponde anche la array 
constant string ki_tipo_cicli_singolo = "0"
constant string ki_tipo_cicli_misto = "2"
constant string ki_tipo_cicli_a_scelta = "1"
string ki_SL_PT_TIPO_CICLI_DESCR[0 to 2]= {"Singolo","Singolo a Scelta","Misto"} 

//--- Tipo Correzione Dose
private constant string kki_dosetgXXXtcalc_Attivo = "S"
private constant string kki_dosetgXXXtcalc_Disab = "N"

//--- Tipo Dosimetro
constant string ki_dosim_tipo_AMBER = "A"
constant string ki_dosim_tipo_RED = "R"


end variables

forward prototypes
public function st_esito select_riga (ref st_tab_sl_pt k_st_tab_sl_pt)
public function boolean abilita_modifica_giri ()
public function st_esito check_formale_giri_in_lav (st_tab_sl_pt kst_tab_sl_pt)
public subroutine if_isnull (st_tab_sl_pt kst_tab_sl_pt)
public function boolean link_call (ref datawindow adw_1, string a_campo_link) throws uo_exception
public function boolean get_descr (ref st_tab_sl_pt ast_tab_sl_pt) throws uo_exception
public subroutine get_misure (ref st_tab_sl_pt kst_tab_sl_pt) throws uo_exception
public subroutine get_dosim_dati (ref st_tab_sl_pt ast_tab_sl_pt) throws uo_exception
public subroutine set_dosim_et_descr (ref st_tab_sl_pt ast_tab_sl_pt) throws uo_exception
public subroutine get_dati_xconvalida (ref st_tab_sl_pt kst_tab_sl_pt) throws uo_exception
public subroutine memo_save (st_tab_sl_pt_memo ast_tab_sl_pt_memo) throws uo_exception
public function st_esito tb_update (ref st_tab_sl_pt_memo ast_tab_sl_pt_memo) throws uo_exception
public function boolean tb_delete (st_tab_sl_pt_memo ast_tab_sl_pt_memo) throws uo_exception
public function boolean tb_delete (st_tab_sl_pt_dosimpos ast_tab_sl_pt_dosimpos) throws uo_exception
public function st_esito anteprima_dosimpos (datastore kdw_anteprima, st_tab_sl_pt kst_tab_sl_pt) throws uo_exception
public function st_esito anteprima (datastore kdw_anteprima, st_tab_sl_pt kst_tab_sl_pt) throws uo_exception
public function long get_id_sl_pt_memo_max () throws uo_exception
public subroutine get_densita (ref st_tab_sl_pt kst_tab_sl_pt) throws uo_exception
public function boolean tb_delete (string k_codice) throws uo_exception
public function integer get_impianto (ref st_tab_sl_pt kst_tab_sl_pt) throws uo_exception
public function boolean get_dosetgminfattcorr_ifattivo (ref st_tab_sl_pt ast_tab_sl_pt) throws uo_exception
public function boolean get_dosetgmaxfattcorr_ifattivo (ref st_tab_sl_pt ast_tab_sl_pt) throws uo_exception
public function boolean get_dosetgmaxfattcorr_max_ifattivo (ref st_tab_sl_pt ast_tab_sl_pt) throws uo_exception
public function boolean get_dosetgminfattcorr_max_ifattivo (ref st_tab_sl_pt ast_tab_sl_pt) throws uo_exception
public subroutine get_dose_min_max (ref st_tab_sl_pt ast_tab_sl_pt) throws uo_exception
end prototypes

public function st_esito select_riga (ref st_tab_sl_pt k_st_tab_sl_pt);//
//====================================================================
//=== 
//=== Leggo Contratto specifico
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//=== 
//====================================================================
//
string k_cod_sl_pt
st_esito kst_esito


k_cod_sl_pt = k_st_tab_sl_pt.cod_sl_pt

kst_esito = kguo_exception.inizializza(this.classname())

if len(trim(k_cod_sl_pt)) > 0 then 
	select descr,
			 tipo_cicli,
			 fila_pref,
			 fila_1,
			 fila_2,
			 fila_1p,
			 fila_2p,
			 densita,
			 dose,
			 dose_min,
			 dose_max,
			 composizione,
			 peso,
			 routine,
			 dosimetrie_spec,
			 note_descr,
			 tipo,
			 magazzino,
			 mis_x,
			 mis_y,
			 mis_z,
			 dosim_delta_bcode,
			 dosim_x_bcode,
			 dosim_et_descr,
			 unitwork,
			 savedosimeter,
			 x_datins,
			 x_utente
	 into :k_st_tab_sl_pt.descr,
			:k_st_tab_sl_pt.tipo_cicli,
			:k_st_tab_sl_pt.fila_pref,
			:k_st_tab_sl_pt.fila_1,
			:k_st_tab_sl_pt.fila_2,
			:k_st_tab_sl_pt.fila_1p,
			:k_st_tab_sl_pt.fila_2p,
			:k_st_tab_sl_pt.densita,
			:k_st_tab_sl_pt.dose,
			:k_st_tab_sl_pt.dose_min,
			:k_st_tab_sl_pt.dose_max,
			:k_st_tab_sl_pt.composizione,
			:k_st_tab_sl_pt.peso,
			:k_st_tab_sl_pt.routine,
			:k_st_tab_sl_pt.dosimetrie_spec,
			:k_st_tab_sl_pt.note_descr,
			:k_st_tab_sl_pt.tipo,
			:k_st_tab_sl_pt.magazzino,
			:k_st_tab_sl_pt.mis_x,
			:k_st_tab_sl_pt.mis_y,
			:k_st_tab_sl_pt.mis_z,
			:k_st_tab_sl_pt.dosim_delta_bcode,
			:k_st_tab_sl_pt.dosim_x_bcode,
			:k_st_tab_sl_pt.dosim_et_descr,
			:k_st_tab_sl_pt.unitwork,
			:k_st_tab_sl_pt.savedosimeter,
			:k_st_tab_sl_pt.x_datins,
			:k_st_tab_sl_pt.x_utente
		from sl_pt
		where 
		cod_sl_pt = :k_cod_sl_pt
		using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore durante lettura Piano di Trattamento (Tab. sl_pt) codice: " + trim(k_cod_sl_pt) + ". ~n~rErrore: "+ trim(kguo_sqlca_db_magazzino.SQLErrText)
			if kguo_sqlca_db_magazzino.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if kguo_sqlca_db_magazzino.sqlcode > 0 then
	//				kst_esito.esito = "2"
					kst_esito.esito = kkg_esito.db_wrn
				else
//					kst_esito.esito = "1"
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		else
			kst_esito.esito = kkg_esito.ok
		end if
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Errore durante lettura Piano di Trattamento (Tab. sl_pt), manca il codice! "
		kst_esito.esito = kkg_esito.not_fnd
	end if

return kst_esito

end function

public function boolean abilita_modifica_giri ();//---
//--- controlla se l'utente ha l'abilitazione alla modifica dei 'giri di lavorazione'
//---
//--- ritorna: true=ok;  false=non abilitato
//---
boolean k_return
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza

	kst_open_w.id_programma = "ptg"
	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	
	kuf1_sicurezza = create kuf_sicurezza
	k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	

return k_return
	
	
end function

public function st_esito check_formale_giri_in_lav (st_tab_sl_pt kst_tab_sl_pt);//---
//--- controlla che i campi dei "giri" siano formalmente e lgicamente corretti per essere
//--- messi in lavorazione sul pilota
//---
//--- ritorna st_esito: "0"=ok;  "1"=errore; 2=avvertimento
//--- in se_esito.errtext il testo dell'errore
//---
st_esito kst_esito

string k_errore_txt = ""
integer k_errore = 0, k_nr_errori=0
int k_riga


	kst_esito = kguo_exception.inizializza(this.classname())

	if isnull(kst_tab_sl_pt.fila_1) then
		kst_tab_sl_pt.fila_1 = 0
	end if
	if isnull(kst_tab_sl_pt.fila_1p) then
		kst_tab_sl_pt.fila_1p = 0
	end if
	if isnull(kst_tab_sl_pt.fila_2) then
		kst_tab_sl_pt.fila_2 = 0
	end if
	if isnull(kst_tab_sl_pt.fila_2p) then
		kst_tab_sl_pt.fila_2p = 0
	end if
	if isnull(kst_tab_sl_pt.tipo_cicli) then
		kst_tab_sl_pt.tipo_cicli = this.ki_tipo_cicli_singolo
	end if


	if kst_tab_sl_pt.tipo_cicli = this.ki_tipo_cicli_singolo then
		if (kst_tab_sl_pt.fila_1 > 0 or kst_tab_sl_pt.fila_1p > 0) &
		   and (kst_tab_sl_pt.fila_2 > 0 or kst_tab_sl_pt.fila_2p > 0) &
		   then
			kst_esito.esito = "1"
			kst_esito.sqlerrtext = "Per questo metodo di Trattamento NON e' consentito valorizzare entrambe le File; " &
						  + "~n~r" 
		else
			if (kst_tab_sl_pt.fila_1 <> kst_tab_sl_pt.fila_1p) &
				or (kst_tab_sl_pt.fila_2 <> kst_tab_sl_pt.fila_2p) &
				then
				kst_esito.esito = "2"
				kst_esito.sqlerrtext = "Indicati n. giri pemutati diversi; " &
							  + "~n~r" 
			end if
		end if						  
	else
		if (kst_tab_sl_pt.fila_1 = 0 and kst_tab_sl_pt.fila_1p = 0) &
		   or (kst_tab_sl_pt.fila_2 = 0 and kst_tab_sl_pt.fila_2p = 0) &
		   then
			kst_esito.esito = "1"
			kst_esito.sqlerrtext = "Per questo metodo di Trattamento e' necessario valorizzare entrambe le File; " &
						  + "~n~r" 
		end if
	end if

	if kst_esito.esito = "0" then
		
		if kst_tab_sl_pt.fila_1 = 0  &
		   and kst_tab_sl_pt.fila_1p = 0  &
		   and kst_tab_sl_pt.fila_2 = 0 &
		   and kst_tab_sl_pt.fila_2p = 0 &
			then
			kst_esito.sqlerrtext = "Nessun giro di lavorazione indicato; " &
			           + "~n~r" 
			kst_esito.esito = "1"
			
		end if
	end if

//

	

return kst_esito
	
	
end function

public subroutine if_isnull (st_tab_sl_pt kst_tab_sl_pt);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_sl_pt.cod_sl_pt) then kst_tab_sl_pt.cod_sl_pt = ""
if isnull(kst_tab_sl_pt.descr) then	kst_tab_sl_pt.descr = ""
if isnull(kst_tab_sl_pt.densita) then kst_tab_sl_pt.densita = 0.0
if isnull(kst_tab_sl_pt.dose) then	kst_tab_sl_pt.dose = 0
if isnull(kst_tab_sl_pt.dose_min) then	kst_tab_sl_pt.dose_min = 0
if isnull(kst_tab_sl_pt.dose_max) then	kst_tab_sl_pt.dose_max = 0
if isnull(kst_tab_sl_pt.tipo_cicli) then	kst_tab_sl_pt.tipo_cicli = ""
if isnull(kst_tab_sl_pt.fila_pref) then kst_tab_sl_pt.fila_pref = ""
if isnull(kst_tab_sl_pt.fila_1) then	kst_tab_sl_pt.fila_1 = 0
if isnull(kst_tab_sl_pt.fila_2) then	kst_tab_sl_pt.fila_2 = 0
if isnull(kst_tab_sl_pt.fila_1p) then	kst_tab_sl_pt.fila_1p = 0
if isnull(kst_tab_sl_pt.fila_2p) then	kst_tab_sl_pt.fila_2p = 0
if isnull(kst_tab_sl_pt.mis_x) then	kst_tab_sl_pt.mis_x = 0
if isnull(kst_tab_sl_pt.mis_y) then	kst_tab_sl_pt.mis_y = 0
if isnull(kst_tab_sl_pt.mis_z) then	kst_tab_sl_pt.mis_z = 0
if isnull(kst_tab_sl_pt.tipo) then kst_tab_sl_pt.tipo = ""
if isnull(kst_tab_sl_pt.proposta_fila_pref) then kst_tab_sl_pt.proposta_fila_pref = ""
if isnull(kst_tab_sl_pt.magazzino) then kst_tab_sl_pt.magazzino = 0
if isnull(kst_tab_sl_pt.composizione) then kst_tab_sl_pt.composizione = ""
if isnull(kst_tab_sl_pt.unitwork) then kst_tab_sl_pt.unitwork = 0
if isnull(kst_tab_sl_pt.savedosimeter) then kst_tab_sl_pt.savedosimeter = 0
if isnull(kst_tab_sl_pt.packingformin_file) then kst_tab_sl_pt.packingformin_file = ""

if isnull(kst_tab_sl_pt.dosim_x_bcode) then kst_tab_sl_pt.dosim_x_bcode = 0
if isnull(kst_tab_sl_pt.dosim_delta_bcode) then kst_tab_sl_pt.dosim_delta_bcode = 0
if isnull(kst_tab_sl_pt.dosim_et_descr) then kst_tab_sl_pt.dosim_et_descr = ""

end subroutine

public function boolean link_call (ref datawindow adw_1, string a_campo_link) throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Attiva LINK cliccato (funzione di ZOOM)
//---
//--- Par. Inut: 
//---               datawindow su cui è stato attivato il LINK
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


st_tab_sl_pt kst_tab_sl_pt
st_esito kst_esito
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito = kguo_exception.inizializza(this.classname())

choose case a_campo_link

	case "cod_sl_pt", "sl_pt"
		kst_tab_sl_pt.cod_sl_pt = adw_1.getitemstring(adw_1.getrow(), a_campo_link )
		if len(trim(kst_tab_sl_pt.cod_sl_pt)) > 0 then

			kst_esito = this.anteprima ( kdsi_elenco_output, kst_tab_sl_pt )
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
			kst_open_w.key1 = "Piano di Trattamento: " + trim(kst_tab_sl_pt.cod_sl_pt) 
		else
			k_return = false
		end if

	case "sl_pt_dosimpos" &
		,"sl_pt_dosimpos_g3"
		kst_tab_sl_pt.cod_sl_pt = adw_1.getitemstring(adw_1.getrow(), "cod_sl_pt" )
		if len(trim(kst_tab_sl_pt.cod_sl_pt)) > 0 then

			kst_esito = this.anteprima_dosimpos ( kdsi_elenco_output, kst_tab_sl_pt )
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
			kst_open_w.key1 = "Dosimetro del Piano di Trattamento: " + trim(kst_tab_sl_pt.cod_sl_pt) 
		else
			k_return = false
		end if

end choose

if k_return then

	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//--- Parametri : 
	//--- struttura st_open_w
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.id_programma = kkg_id_programma_elenco //get_id_programma( kst_open_w.flag_modalita ) //kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kGuf_menu_window.open_w_tabelle(kst_open_w)

	else
		
		kguo_exception.inizializza( )
		kguo_exception.setmessage( "Nessun valore disponibile (" + this.get_id_programma(kst_open_w.flag_modalita) + "). " )
		throw kguo_exception
		
		
	end if

end if

SetPointer(kp_oldpointer)



return k_return

end function

public function boolean get_descr (ref st_tab_sl_pt ast_tab_sl_pt) throws uo_exception;//
//----------------------------------------------------------------------------------------
//--- Torna il Descrizione 
//--- 
//--- 
//---  input: st_tab_sl_pt.cod_sl_pt
//---  out: true = trovata
//---  Rit: descr
//---    
//---   x errore lancia: uo_exception                                  
//----------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	SELECT descr
			 INTO 
					:ast_tab_sl_pt.descr
			 FROM sl_pt
			WHERE sl_pt.cod_sl_pt = :ast_tab_sl_pt.cod_sl_pt 
				 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura PT della descrizione, codice=" + string(ast_tab_sl_pt.cod_sl_pt) + " " &
									 + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			k_return = true
		end if
	end if

	if isnull(ast_tab_sl_pt.descr) then
		ast_tab_sl_pt.descr = ""
	end if

	
return k_return


end function

public subroutine get_misure (ref st_tab_sl_pt kst_tab_sl_pt) throws uo_exception;//
//====================================================================
//=== Torna le misure tipo le dimensioni e la dose 
//=== 
//=== Input: st_tab_sl_pt.cod_sl_pt
//=== Output: st_tab_sl_pt.mis_* + dose
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
boolean k_return=false
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	SELECT 
		mis_x,
		mis_y,
		mis_z,
		dose
	 into 
	 	:kst_tab_sl_pt.mis_x
	 	,:kst_tab_sl_pt.mis_y
	 	,:kst_tab_sl_pt.mis_z
	 	,:kst_tab_sl_pt.dose
		FROM sl_pt
		WHERE (cod_sl_pt = :kst_tab_sl_pt.cod_sl_pt) 
		using kguo_sqlca_db_magazzino;


	if kguo_sqlca_db_magazzino.sqlcode >= 0 then
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura misure del Piano di Lavorazione: " + trim(kst_tab_sl_pt.cod_sl_pt) &
							+ "~n" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if



end subroutine

public subroutine get_dosim_dati (ref st_tab_sl_pt ast_tab_sl_pt) throws uo_exception;/*
 Leggo Dati stampa Etichette Dosimetri in tabella PT x lo specifico codice 
	 Inp: sl_pt.cod_sl_pt + impianto
	 Out: dosim_x_bcode = numero etich. dosimetri per barcode (dove ovviamente è associato) MINIMO 1
	 	   dosim_delta_bcode = x i lotti ove fossero richiesti più barcode con etichetta indicare ogni quanti barcode è richiesta
*/
kuf_impianto kuf1_impianto


	kguo_exception.inizializza(this.classname())
	
	if ast_tab_sl_pt.impianto = kuf1_impianto.kki_impiantoG3 then
		select
			 dosim_x_bcode
			 ,dosim_delta_bcode
			 ,unitwork
			 ,savedosimeter
		 into :ast_tab_sl_pt.dosim_x_bcode
	 			,:ast_tab_sl_pt.dosim_delta_bcode
		 		,:ast_tab_sl_pt.unitwork
	 			,:ast_tab_sl_pt.savedosimeter
		from sl_pt_g3 
		where cod_sl_pt = :ast_tab_sl_pt.cod_sl_pt
		using kguo_sqlca_db_magazzino;
	else
		ast_tab_sl_pt.impianto = kuf1_impianto.kki_impiantoG2
		select
			 dosim_x_bcode
			 ,dosim_delta_bcode
			 ,unitwork
			 ,savedosimeter
		 into :ast_tab_sl_pt.dosim_x_bcode
	 			,:ast_tab_sl_pt.dosim_delta_bcode
		 		,:ast_tab_sl_pt.unitwork
	 			,:ast_tab_sl_pt.savedosimeter
		from sl_pt 
		where cod_sl_pt = :ast_tab_sl_pt.cod_sl_pt
		using kguo_sqlca_db_magazzino;
	end if

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
						"Errore in lettura dati Etichette Dosimetri sul PT '" + trim(ast_tab_sl_pt.cod_sl_pt) &
						+ "', Impianto " + string(ast_tab_sl_pt.impianto))
		throw kguo_exception
	end if
	
	if ast_tab_sl_pt.dosim_x_bcode > 0 then
	else
		ast_tab_sl_pt.dosim_x_bcode = 1   // minimo torna un barcode 
	end if
	if ast_tab_sl_pt.dosim_delta_bcode > 0 then
	else
		ast_tab_sl_pt.dosim_delta_bcode = 0   // attacca la sola etichetta finale
	end if
	if ast_tab_sl_pt.unitwork > 0 then
	else
		ast_tab_sl_pt.unitwork = 100   // default (100%)
	end if
	if ast_tab_sl_pt.savedosimeter > 0 then
	else
		ast_tab_sl_pt.savedosimeter = 0   // No save!
	end if
	


end subroutine

public subroutine set_dosim_et_descr (ref st_tab_sl_pt ast_tab_sl_pt) throws uo_exception;//
//--- Aggiorna la colonna dosim_et_descr 
//--- Inp: sl_pt.cod_sl_pt + dosim_et_descr
//--- Out: 
//--- 	  
//
st_tab_sl_pt kst_tab_sl_pt
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	if_sicurezza(kkg_flag_modalita.modifica)
	
	if trim(ast_tab_sl_pt.cod_sl_pt) > " " then
		
		kst_tab_sl_pt.dosim_et_descr = ast_tab_sl_pt.dosim_et_descr  //NON TRIMMARE il campo è in due parti 40+40
	
		update sl_pt
			 set dosim_et_descr = :kst_tab_sl_pt.dosim_et_descr
		where cod_sl_pt = :ast_tab_sl_pt.cod_sl_pt
		using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode >= 0 then
			if kst_tab_sl_pt.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_magazzino.db_commit()
			end if
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Aggiornamento tab PT per descrizione etich. dosimetro codice=" + trim(ast_tab_sl_pt.cod_sl_pt))
				if kst_tab_sl_pt.st_tab_g_0.esegui_commit = "N" then
				else
					kguo_sqlca_db_magazzino.db_rollback()
				end if
				throw kguo_exception
			end if
		end if
	
	else	
		
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Errore in Aggiornamento tab PT per descrizione etich. dosimetro. Manca il codice! "
		kst_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if


end subroutine

public subroutine get_dati_xconvalida (ref st_tab_sl_pt kst_tab_sl_pt) throws uo_exception;/*
 Leggo dati PT x fare la Convalida della Dosimetria
   Inp: cod_sl_pt + impianto
   Out: st_tab_sl_pt. dose*
*/
kuf_impianto kuf1_impianto

	kguo_exception.inizializza(this.classname())

	if kst_tab_sl_pt.cod_sl_pt > " " then 
	
		if kst_tab_sl_pt.impianto = kuf1_impianto.kki_impiantog3 then
			select 
					 sl_pt_g3.dosetgminmin
					,sl_pt_g3.dosetgminmax
					,sl_pt.dose_min
					,sl_pt.dose_max
			 into   
				 :kst_tab_sl_pt.dosetgminmin
				 ,:kst_tab_sl_pt.dosetgminmax
				 ,:kst_tab_sl_pt.dose_min
				 ,:kst_tab_sl_pt.dose_max
				from sl_pt_g3 inner join sl_pt on sl_pt_g3.cod_sl_pt = sl_pt.cod_sl_pt
				where sl_pt_g3.cod_sl_pt = :kst_tab_sl_pt.cod_sl_pt
				using kguo_sqlca_db_magazzino;
		else
			select 
					 dosetgminmin
					,dosetgminmax
					,dose_min
					,dose_max
			 into   
				 :kst_tab_sl_pt.dosetgminmin
				 ,:kst_tab_sl_pt.dosetgminmax
				 ,:kst_tab_sl_pt.dose_min
				 ,:kst_tab_sl_pt.dose_max
				from sl_pt
				where cod_sl_pt = :kst_tab_sl_pt.cod_sl_pt
				using kguo_sqlca_db_magazzino;
		end if
			
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in lettura dati per Convalida Dosimetria del Piano di Trattamento: " + trim(kst_tab_sl_pt.cod_sl_pt))				
				throw kguo_exception
			end if
			kst_tab_sl_pt.dosetgminmin = 0
			kst_tab_sl_pt.dosetgminmax = 0
			kst_tab_sl_pt.dose_min = 0
			kst_tab_sl_pt.dose_max = 0
		end if
	else
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in lettura dati per Convalida Dosimetria, manca il codice del Piano di Trattamento")				
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		throw kguo_exception
	end if

	if kst_tab_sl_pt.dosetgminmin > 0 then
	else
		kst_tab_sl_pt.dosetgminmin = 0
	end if
	if kst_tab_sl_pt.dosetgminmax > 0 then
	else
		kst_tab_sl_pt.dosetgminmax = 0
	end if
//return kst_esito

end subroutine

public subroutine memo_save (st_tab_sl_pt_memo ast_tab_sl_pt_memo) throws uo_exception;//
//--- Salva dati MEMO perticolari per questo Settore
//
st_esito kst_esito
//kuf_memo_allarme kuf1_memo_allarme


try   

//	if trim(kist_tab_meca_memo.allarme) > " " then
//	else
//		kist_tab_meca_memo.allarme = kuf1_memo_allarme.kki_memo_allarme_no
//	end if
//	kist_tab_meca_memo.id_memo = ast_tab_sl_pt_memo.id_memo
//	kist_tab_meca_memo.st_tab_g_0 = ast_tab_sl_pt_memo.st_tab_g_0
	kst_esito = tb_update(ast_tab_sl_pt_memo)
	if kst_esito.esito <> kkg_esito.ok then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

catch (uo_exception	kuo_exception)
	throw kuo_exception
		
end try
	


end subroutine

public function st_esito tb_update (ref st_tab_sl_pt_memo ast_tab_sl_pt_memo) throws uo_exception;//====================================================================
//=== Aggiunge rek nella tabella DATI di MEMO
//=== 
//=== Input: st_tab_sl_pt_memo 
//=== output: id_sl_pt_memo
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
long k_rcn
boolean k_rc, k_senza_dati
st_esito kst_esito
st_open_w kst_open_w
//st_tab_sl_pt_memo kst_tab_sl_pt_memo


kst_esito = kguo_exception.inizializza(this.classname())

//kuf_sicurezza kuf1_sicurezza

if trim(ast_tab_sl_pt_memo.cod_sl_pt) > " " then
else
	kst_esito.SQLErrText = "Tab.dati MEMO fascicolo pt: nessun dato inserito (codice PT non impostato) "
	kst_esito.esito = kkg_esito.no_esecuzione
	if ast_tab_sl_pt_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_sl_pt_memo.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

//	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
//	kst_open_w.id_programma = kkg_id_programma_anag_memo
//	
//	//--- controlla se utente autorizzato alla funzione in atto
//	try
//		k_rc = if_sicurezza(kst_open_w )
//	catch (uo_exception kuo_exception)
//		
//	end try
//	
//	if not k_rc then
//	
//		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
//		kst_esito.SQLErrText = "Modifica dati Memo non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//		kst_esito.esito = kkg_esito.no_aut
//	
//	else
		
ast_tab_sl_pt_memo.x_datins = kGuf_data_base.prendi_x_datins()
ast_tab_sl_pt_memo.x_utente = kGuf_data_base.prendi_x_utente()
	
//		kst_tab_sl_pt_memo.st_tab_sl_pt_memo = st_tab_sl_pt_memo
//		this.if_isnull( kst_tab_sl_pt_memo )
//		st_tab_sl_pt_memo = kst_tab_sl_pt_memo.st_tab_sl_pt_memo

		k_rcn = 0
		if ast_tab_sl_pt_memo.id_memo > 0 then
			select distinct 1
				into :k_rcn
				from sl_pt_memo
				WHERE id_memo = :ast_tab_sl_pt_memo.id_memo 
				using kguo_sqlca_db_magazzino;
		end if
			
	//--- tento l'insert se manca in arch.
		if kguo_sqlca_db_magazzino.sqlcode  >= 0 then

			if k_rcn > 0 then
				UPDATE sl_pt_memo  
				  		SET cod_sl_pt = :ast_tab_sl_pt_memo.cod_sl_pt
						    ,tipo_sv =  :ast_tab_sl_pt_memo.tipo_sv
							,x_datins = :ast_tab_sl_pt_memo.x_datins
							,x_utente = :ast_tab_sl_pt_memo.x_utente  
							WHERE id_memo = :ast_tab_sl_pt_memo.id_memo 
							using kguo_sqlca_db_magazzino;
			else
				
				if NOT k_senza_dati then
//								id_sl_pt_memo
					INSERT INTO sl_pt_memo  
								(
								id_memo
								,tipo_sv
								,cod_sl_pt
								,x_datins 
								,x_utente 
								 )  
						  VALUES (  
							:ast_tab_sl_pt_memo.id_memo
							,:ast_tab_sl_pt_memo.tipo_sv
							,:ast_tab_sl_pt_memo.cod_sl_pt 
							,:ast_tab_sl_pt_memo.x_datins
							,:ast_tab_sl_pt_memo.x_utente  
							)  
						using kguo_sqlca_db_magazzino;
					if kguo_sqlca_db_magazzino.sqlcode = 0 then
						
						ast_tab_sl_pt_memo.id_sl_pt_memo = get_id_sl_pt_memo_max( )
						//ast_tab_sl_pt_memo.id_sl_pt_memo = long(kguo_sqlca_db_magazzino.SQLReturnData)
	
					end if	
				end if
//								,allarme
//							,:kst_tab_sl_pt_memo.allarme 
//						    ,allarme =  :kst_tab_sl_pt_memo.allarme
					
			end if
			
		end if	
	
	
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Tab.dati Memo:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			if kguo_sqlca_db_magazzino.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if kguo_sqlca_db_magazzino.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
					if ast_tab_sl_pt_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_sl_pt_memo.st_tab_g_0.esegui_commit) then
						kguo_sqlca_db_magazzino.db_rollback( )
					end if
				end if
			end if
		else
			if ast_tab_sl_pt_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_sl_pt_memo.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		end if
	
	
//	end if
	


return kst_esito

end function

public function boolean tb_delete (st_tab_sl_pt_memo ast_tab_sl_pt_memo) throws uo_exception;//
//--------------------------------------------------------------------
//--- Cancella rek nella tabella MEMO
//--- 
//--- Input: st_tab_sl_pt_memo.id_memo
//--- Ritorna  TRUE=OK; 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
boolean k_return = false
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w
//kuf_sicurezza kuf1_sicurezza


kst_esito = kguo_exception.inizializza(this.classname())

if ast_tab_sl_pt_memo.id_memo > 0 then
	

	delete 
			from sl_pt_memo
			WHERE id_memo = :ast_tab_sl_pt_memo.id_memo 
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore Cancellazione fascicolo PT dal MEMO (id memo " + string(ast_tab_sl_pt_memo.id_memo) + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) 

			if ast_tab_sl_pt_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_sl_pt_memo.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if

			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
	else
			
		if ast_tab_sl_pt_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_sl_pt_memo.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if


end if



return k_return

end function

public function boolean tb_delete (st_tab_sl_pt_dosimpos ast_tab_sl_pt_dosimpos) throws uo_exception;//
//--------------------------------------------------------------------
//--- Cancella rek nella tabella Posizione DOSIMETRI sul Pallet
//--- 
//--- Input: ast_tab_sl_pt_dosimpos.id_sl_pt_dosimpos
//--- Ritorna  TRUE=OK; 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
boolean k_return = false
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if ast_tab_sl_pt_dosimpos.id_sl_pt_dosimpos > 0 then
	
	delete 
			from sl_pt_dosimpos
			WHERE id_sl_pt_dosimpos = :ast_tab_sl_pt_dosimpos.id_sl_pt_dosimpos 
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore Cancellazione Posizione Dosimetro del PT (id " + string(ast_tab_sl_pt_dosimpos.id_sl_pt_dosimpos) + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) 

			if ast_tab_sl_pt_dosimpos.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_sl_pt_dosimpos.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if

			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
	else
			
		if ast_tab_sl_pt_dosimpos.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_sl_pt_dosimpos.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if

end if

return k_return

end function

public function st_esito anteprima_dosimpos (datastore kdw_anteprima, st_tab_sl_pt kst_tab_sl_pt) throws uo_exception;//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore di anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
//=== 
//====================================================================
//
//=== 
long k_rc
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

try
	if_sicurezza(kkg_flag_modalita.anteprima)

	if isvalid(kdw_anteprima)  then
		if kdw_anteprima.dataobject = "d_sl_pt_dosimpos"  then
			if kdw_anteprima.object.codice[1] = kst_tab_sl_pt.cod_sl_pt  then
				kst_tab_sl_pt.cod_sl_pt = " " 
			end if
		end if
	end if

	if len(trim(kst_tab_sl_pt.cod_sl_pt)) > 0 then

		kdw_anteprima.dataobject = "d_sl_pt_dosimpos"		
		kdw_anteprima.settransobject(sqlca)

		kdw_anteprima.reset()	
	//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_sl_pt.cod_sl_pt)
	
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun dosimetro da visualizzare: ~n~r" + "nessun Codice Piano di Trattamento indicato."
		kst_esito.esito = kkg_esito.bug
		
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kst_esito.nome_oggetto = this.classname()
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception

finally
	
end try

return kst_esito

end function

public function st_esito anteprima (datastore kdw_anteprima, st_tab_sl_pt kst_tab_sl_pt) throws uo_exception;//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore di anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
//=== 
//====================================================================
//
//=== 
long k_rc
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

try
	if_sicurezza(kkg_flag_modalita.anteprima)

	if isvalid(kdw_anteprima)  then
		if kdw_anteprima.dataobject = "d_sl_pt"  then
			if kdw_anteprima.object.codice[1] = kst_tab_sl_pt.cod_sl_pt  then
				kst_tab_sl_pt.cod_sl_pt = " " 
			end if
		end if
	end if

	if len(trim(kst_tab_sl_pt.cod_sl_pt)) > 0 then
	
		kdw_anteprima.dataobject = "d_sl_pt"		
		kdw_anteprima.settransobject(sqlca)

//			kuf1_utility = create kuf_utility
//			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//			destroy kuf1_utility

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_sl_pt.cod_sl_pt)
	
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Piano da visualizzare: ~n~r" + "nessun Codice indicato"
		kst_esito.esito = kkg_esito.bug
		
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kst_esito.nome_oggetto = this.classname()
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception

finally
	
end try


return kst_esito

end function

public function long get_id_sl_pt_memo_max () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo ID inserito 
//--- 
//---  input: 
//---  ret: max ID_SL_PT_MEMO
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	SELECT max(id_sl_pt_memo)
		 INTO 
				:k_return
		 FROM sl_pt_memo  
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo ID Memo dei Piano di Lavorazione in tabella (SL_PT)" &
									 + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if isnull(k_return) then k_return = 0
	else
		k_return = 0
	end if
	

return k_return

end function

public subroutine get_densita (ref st_tab_sl_pt kst_tab_sl_pt) throws uo_exception;/*
 Torna dati DENSITA 
	 Input: st_tab_sl_pt.cod_sl_pt
	 Output: st_tab_sl_pt.densita/densitamax
*/

	if kst_tab_sl_pt.cod_sl_pt > " " then
		kguo_exception.inizializza(this.classname())
	
		SELECT 
			isnull(densita, 0.0)
			,isnull(densitamax, 0.0)
		 into 
			:kst_tab_sl_pt.densita  
			,:kst_tab_sl_pt.densitamax  
		FROM sl_pt
		WHERE (cod_sl_pt = :kst_tab_sl_pt.cod_sl_pt) 
		using kguo_sqlca_db_magazzino;
	
	
		if kguo_sqlca_db_magazzino.sqlcode >= 0 then
		else
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in lettura dati Densità del Piano di Lavorazione: " + trim(kst_tab_sl_pt.cod_sl_pt))
			throw kguo_exception
		end if
	end if
	

end subroutine

public function boolean tb_delete (string k_codice) throws uo_exception;/*
  Cancella il rek dalla tabella sl_pt e i dati correlati
  Inp: codice cod_sl_pt
  
*/
boolean k_return 
boolean k_open_listino
long k_id_sl_pt_g3
st_tab_listino kst_tab_listino
string k_rag_soc
st_esito kst_esito


try

	kst_esito = kguo_exception.inizializza(this.classname())
	if_sicurezza(kkg_flag_modalita.cancellazione)
	
	//=== Controllo se codice presente su CONTRATTI/LISTINI
	DECLARE listino CURSOR FOR  
			  SELECT isnull(listino.cod_cli, 0),
						isnull(listino.cod_art, ''),
						isnull(clienti.rag_soc_10, ''),
						isnull(listino.id, 0),
						contratti.codice
				FROM contratti LEFT OUTER JOIN listino ON 
					  contratti.codice = listino.contratto  
									 left outer join clienti on 
						listino.cod_cli = clienti.codice
				WHERE contratti.sl_pt = :k_codice 
						using kguo_sqlca_db_magazzino;
	
	
	open listino;
	if kguo_sqlca_db_magazzino.sqlCode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Cancellazione Piano di Trattamento '" + trim(k_codice) + "' " &
														+ ", durante tentativo di lettura del Listino.")
		throw kguo_exception
	end if
	
	k_open_listino = true
	
	fetch listino INTO 
					:kst_tab_listino.cod_cli,
					:kst_tab_listino.cod_art,
					:k_rag_soc,
					:kst_tab_listino.id,
					:kst_tab_listino.contratto
					;
	if kguo_sqlca_db_magazzino.sqlCode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Cancellazione Piano di Trattamento '" + trim(k_codice) + "' " &
														+ ", durante lettura del Listino.")
		throw kguo_exception
	end if
	
	if kguo_sqlca_db_magazzino.sqlCode = 0 then
			
		if kst_tab_listino.id > 0 then
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
										"Piano di Trattamento su Listino '" + string(kst_tab_listino.id) + "', del cliente:  " &
										+ kkg.acapo + 	string(kst_tab_listino.cod_cli, "#") + " - " + trim(k_rag_soc) + " " &
										+ kkg.acapo + "Articolo: " + trim(kst_tab_listino.cod_art) + " " + " " &
										+ kkg.acapo + "attraverso il Contratto CO " + string(kst_tab_listino.contratto) + " " &
										+ kkg.acapo + "per proseguire la cancellazione è necessario rimuovere questa associazione. ")
		else
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
										"Piano di Trattamento è legato al Contratto CO " + string(kst_tab_listino.contratto) + ", per proseguire la canellazione è necessario rimuovere l'associazione. ")
		end if
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		throw kguo_exception
		
	end if

	delete from sl_pt
			where cod_sl_pt = :k_codice 
				using kguo_sqlca_db_magazzino;
	if kguo_sqlca_db_magazzino.sqlCode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Cancellazione Piano di Trattamento '" + trim(k_codice) + "' ")
		throw kguo_exception
	end if
		
//--- Rimuove le posizioni dei dosimetri
	delete 
		from sl_pt_dosimpos
		WHERE cod_sl_pt = :k_codice
		using kguo_sqlca_db_magazzino;
	if kguo_sqlca_db_magazzino.sqlCode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Cancellazione Piano di Trattamento '" + trim(k_codice) + "' " &
														+ ", durante rimozione delle Posizioni dei Dosimetri.")
		throw kguo_exception
	end if

//--- Rimuove dati G3 (testata e dettagli)
	select id_sl_pt_g3
	   into :k_id_sl_pt_g3
		from sl_pt_g3
		WHERE cod_sl_pt = :k_codice
		using kguo_sqlca_db_magazzino;
	if kguo_sqlca_db_magazzino.sqlCode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Cancellazione Piano di Trattamento '" + trim(k_codice) + "' " &
														+ ", durante lettura dati Trattamento Impianto G3.")
		throw kguo_exception
	end if
	if k_id_sl_pt_g3 > 0 then
		delete 
			from sl_pt_g3_lav
			WHERE id_sl_pt_g3 = :k_id_sl_pt_g3
			using kguo_sqlca_db_magazzino;
		if kguo_sqlca_db_magazzino.sqlCode < 0 then
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Cancellazione Piano di Trattamento '" + trim(k_codice) + "' " &
															+ ", durante rimozione dati Trattamenti Impianto G3.")
			throw kguo_exception
		end if
		delete 
			from sl_pt_g3
			WHERE cod_sl_pt = :k_codice
			using kguo_sqlca_db_magazzino;
		if kguo_sqlca_db_magazzino.sqlCode < 0 then
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Cancellazione Piano di Trattamento '" + trim(k_codice) + "' " &
															+ ", durante rimozione dati Impianto G3.")
			throw kguo_exception
		end if
	end if

//--- Rimuove i MEMO
	delete 
		from sl_pt_memo
		WHERE cod_sl_pt = :k_codice
		using kguo_sqlca_db_magazzino;
	if kguo_sqlca_db_magazzino.sqlCode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Cancellazione Piano di Trattamento '" + trim(k_codice) + "' " &
														+ ", durante rimozione dati Memo collegati.")
		throw kguo_exception
	end if

	kguo_sqlca_db_magazzino.db_commit()
	
	k_return = true

catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log()
	
	kguo_sqlca_db_magazzino.db_rollback()
	
	throw kuo_exception
	
finally
	if k_open_listino then
		close listino;
	end if

	
end try

return k_return
end function

public function integer get_impianto (ref st_tab_sl_pt kst_tab_sl_pt) throws uo_exception;/*
 Torna dati IMPIANTO 
   Inp: st_tab_sl_pt.cod_sl_pt
   Out: st_tab_sl_pt.impianto
	rit: impianto (se ZERO torna il default)
*/
int k_return
kuf_impianto kuf1_impianto


	if kst_tab_sl_pt.cod_sl_pt > " " then
		kguo_exception.inizializza(this.classname())
	
		SELECT 
			isnull(impianto, 0)
		 into 
			:kst_tab_sl_pt.impianto
		FROM sl_pt
		WHERE (cod_sl_pt = :kst_tab_sl_pt.cod_sl_pt) 
		using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in lettura codice Impianto del Piano di Lavorazione: " + trim(kst_tab_sl_pt.cod_sl_pt))
			throw kguo_exception
		end if
		
		if kst_tab_sl_pt.impianto > 0 then
		else
			kst_tab_sl_pt.impianto = kuf1_impianto.kki_impiantoDefault
		end if
		k_return = kst_tab_sl_pt.impianto
		
	end if

return k_return

end function

public function boolean get_dosetgminfattcorr_ifattivo (ref st_tab_sl_pt ast_tab_sl_pt) throws uo_exception;/*
	Torna il fattore di correzione dose MINIMA del Minimo se attivo
		Inp: st_tab_sl_pt.cod_sl_pt + impianto
		Out: st_tab_sl_pt.dosetgminfattcorr    (1.000 se non attivo)
*/
boolean k_return=false
kuf_impianto kuf1_impianto


	kguo_exception.inizializza(this.classname())

	if ast_tab_sl_pt.impianto = kuf1_impianto.kki_impiantoG3 then
		SELECT 
			dosetgminfattcorr,
			dosetgmintcalc
		 into 
			:ast_tab_sl_pt.dosetgminfattcorr
			,:ast_tab_sl_pt.dosetgmintcalc
			FROM sl_pt_g3
			WHERE (cod_sl_pt = :ast_tab_sl_pt.cod_sl_pt) 
		using kguo_sqlca_db_magazzino;
	else
		ast_tab_sl_pt.impianto = kuf1_impianto.kki_impiantoG2
		SELECT 
			dosetgminfattcorr,
			dosetgmintcalc
		 into 
			:ast_tab_sl_pt.dosetgminfattcorr
			,:ast_tab_sl_pt.dosetgmintcalc
			FROM sl_pt
			WHERE (cod_sl_pt = :ast_tab_sl_pt.cod_sl_pt) 
		using kguo_sqlca_db_magazzino;
	end if

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
						"Errore in lettura fattore di correzione Dose Minima del Minimo del Piano di Lavorazione: " + trim(ast_tab_sl_pt.cod_sl_pt) & 
						+ ", Impianto " + string(ast_tab_sl_pt.impianto))
		throw kguo_exception
	end if

	if ast_tab_sl_pt.dosetgmintcalc = kki_dosetgXXXtcalc_Attivo then
		k_return = true
	else
		ast_tab_sl_pt.dosetgminfattcorr = 1.000
	end if

return k_return 

end function

public function boolean get_dosetgmaxfattcorr_ifattivo (ref st_tab_sl_pt ast_tab_sl_pt) throws uo_exception;/*
	Torna il fattore di correzione dose MASSIMA del Minimo se attivo
		Inp: st_tab_sl_pt.cod_sl_pt + impianto
		Out: st_tab_sl_pt.dosetgmaxfattcorr    (1.000 se non attivo)
*/
boolean k_return=false
kuf_impianto kuf1_impianto


	kguo_exception.inizializza(this.classname())

	if ast_tab_sl_pt.impianto = kuf1_impianto.kki_impiantoG3 then
		SELECT 
			dosetgmaxfattcorr,
			dosetgmaxtcalc
		 into 
			:ast_tab_sl_pt.dosetgmaxfattcorr
			,:ast_tab_sl_pt.dosetgmaxtcalc
			FROM sl_pt_g3
			WHERE (cod_sl_pt = :ast_tab_sl_pt.cod_sl_pt) 
		using kguo_sqlca_db_magazzino;
	else
		ast_tab_sl_pt.impianto = kuf1_impianto.kki_impiantoG2
		SELECT 
			dosetgmaxfattcorr,
			dosetgmaxtcalc
		 into 
			:ast_tab_sl_pt.dosetgmaxfattcorr
			,:ast_tab_sl_pt.dosetgmaxtcalc
			FROM sl_pt
			WHERE (cod_sl_pt = :ast_tab_sl_pt.cod_sl_pt) 
		using kguo_sqlca_db_magazzino;
	end if

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
						"Errore in lettura fattore di correzione Dose Massima del Minimo del Piano di Lavorazione: " + trim(ast_tab_sl_pt.cod_sl_pt) &
						+ ", Impianto " + string(ast_tab_sl_pt.impianto))
		throw kguo_exception
	end if

	if ast_tab_sl_pt.dosetgmaxtcalc = kki_dosetgXXXtcalc_Attivo then
		k_return = true
	else
		ast_tab_sl_pt.dosetgmaxfattcorr = 1.000
	end if
	
return k_return
end function

public function boolean get_dosetgmaxfattcorr_max_ifattivo (ref st_tab_sl_pt ast_tab_sl_pt) throws uo_exception;/*
	Torna il fattore di correzione dose MASSIMA del Massimo se attivo
		Inp: st_tab_sl_pt.cod_sl_pt + impianto
		Out: st_tab_sl_pt.dosetgmaxfattcorr_MAX    (1.000 se non attivo)
*/
boolean k_return
kuf_impianto kuf1_impianto


	kguo_exception.inizializza(this.classname())

	if ast_tab_sl_pt.impianto = kuf1_impianto.kki_impiantoG3 then
		SELECT 
			dosetgmaxfattcorr_MAX,
			dosetgmaxtcalc_MAX
		 into 
			:ast_tab_sl_pt.dosetgmaxfattcorr_MAX
			,:ast_tab_sl_pt.dosetgmaxtcalc_MAX
			FROM sl_pt_g3
			WHERE (cod_sl_pt = :ast_tab_sl_pt.cod_sl_pt) 
		using kguo_sqlca_db_magazzino;
	else
		ast_tab_sl_pt.impianto = kuf1_impianto.kki_impiantoG2

		SELECT 
			dosetgmaxfattcorr_MAX,
			dosetgmaxtcalc_MAX
		 into 
			:ast_tab_sl_pt.dosetgmaxfattcorr_MAX
			,:ast_tab_sl_pt.dosetgmaxtcalc_MAX
			FROM sl_pt
			WHERE (cod_sl_pt = :ast_tab_sl_pt.cod_sl_pt) 
		using kguo_sqlca_db_magazzino;
		
	end if

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
						"Errore in lettura fattore di correzione Dose Massima del Massimo del Piano di Lavorazione: " + trim(ast_tab_sl_pt.cod_sl_pt) &
						+ ", Impianto " + string(ast_tab_sl_pt.impianto))
		throw kguo_exception
	end if

	if ast_tab_sl_pt.dosetgmaxtcalc_MAX = kki_dosetgXXXtcalc_Attivo then
		k_return = true
	else
		ast_tab_sl_pt.dosetgmaxfattcorr_MAX = 1.000
	end if
	
return k_return
end function

public function boolean get_dosetgminfattcorr_max_ifattivo (ref st_tab_sl_pt ast_tab_sl_pt) throws uo_exception;/*
	Torna il fattore di correzione dose MINIMA del Massimo se attivo
		Inp: st_tab_sl_pt.cod_sl_pt
		Out: st_tab_sl_pt.dosetgminfattcorr_MAX    (1.000 se non attivo)
*/
boolean k_return
kuf_impianto kuf1_impianto


	kguo_exception.inizializza(this.classname())

	if ast_tab_sl_pt.impianto = kuf1_impianto.kki_impiantoG3 then
		SELECT 
			dosetgminfattcorr_MAX,
			dosetgmintcalc_MAX
		 into 
			:ast_tab_sl_pt.dosetgminfattcorr_MAX
			,:ast_tab_sl_pt.dosetgmintcalc_MAX
			FROM sl_pt_g3
			WHERE (cod_sl_pt = :ast_tab_sl_pt.cod_sl_pt) 
		using kguo_sqlca_db_magazzino;
	else
		ast_tab_sl_pt.impianto = kuf1_impianto.kki_impiantoG2
	
		SELECT 
			dosetgminfattcorr_MAX,
			dosetgmintcalc_MAX
		 into 
			:ast_tab_sl_pt.dosetgminfattcorr_MAX
			,:ast_tab_sl_pt.dosetgmintcalc_MAX
			FROM sl_pt
			WHERE (cod_sl_pt = :ast_tab_sl_pt.cod_sl_pt) 
		using kguo_sqlca_db_magazzino;
	end if

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
						"Errore in lettura fattore di correzione Dose Minima del Massimo del Piano di Lavorazione: " + trim(ast_tab_sl_pt.cod_sl_pt) &
						+ ", Impianto " + string(ast_tab_sl_pt.impianto))
		throw kguo_exception
	end if

	if ast_tab_sl_pt.dosetgmintcalc_MAX = kki_dosetgXXXtcalc_Attivo then
		k_return = true
	else
		ast_tab_sl_pt.dosetgminfattcorr_MAX = 1.000
	end if

return k_return 
end function

public subroutine get_dose_min_max (ref st_tab_sl_pt ast_tab_sl_pt) throws uo_exception;/*
 Torna dati DOSE MIN e MAX 
	 Input: st_tab_sl_pt.cod_sl_pt
	 Output: st_tab_sl_pt.dose_min/dose_max
*/

	if ast_tab_sl_pt.cod_sl_pt > " " then
		
		kguo_exception.inizializza(this.classname())
	
		select isnull(SL_PT.DOSE_MIN,0.0), isnull(SL_PT.DOSE_MAX,0.0)
				into :ast_tab_sl_pt.dose_min, :ast_tab_sl_pt.dose_max
				 from sl_pt
				 where sl_pt.cod_sl_pt = :ast_tab_sl_pt.cod_sl_pt
				using kguo_sqlca_db_magazzino;	
	
	
		if kguo_sqlca_db_magazzino.sqlcode >= 0 then
		else
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in lettura dati Dose Minima e Massima del Piano di Lavorazione: " + trim(ast_tab_sl_pt.cod_sl_pt))
			throw kguo_exception
		end if
		
	end if
	

end subroutine

on kuf_sl_pt.create
call super::create
end on

on kuf_sl_pt.destroy
call super::destroy
end on

