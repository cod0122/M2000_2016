﻿$PBExportHeader$kuf_contratti_dp.sru
forward
global type kuf_contratti_dp from kuf_parent
end type
end forward

global type kuf_contratti_dp from kuf_parent
end type
global kuf_contratti_dp kuf_contratti_dp

type variables
//
//
private constant string kki_form_di_stampa_attuale = "d_contratti_dp_st_ed40718" //"d_contratti_dp_st_ed30516" //"d_contratti_dp_st_ed20915" //"d_contratti_dp_st_ed10512" 
private kuf_esito_operazioni kiuf_esito_operazioni

//---- campo STATO contratto
constant string kki_STATO_nuovo = '1' // nuovo contratto
constant string kki_STATO_riaperto = '2' // contratto Riaperto
constant string kki_STATO_stampato = '3' // contratto stampato definitivamente
constant string kki_STATO_accettato = '5' // contratto Accettato dal cliente
constant string kki_STATO_trasferito = '7' // contratto Trasferito al LISTINO/CONTRATTI
constant string kki_STATO_annullato = '9' // contratto ANNULLATO


//--- campo ATTIVI
constant string kki_ATTIVO_si = 'S' 
constant string kki_ATTIVO_no = 'N' 



end variables

forward prototypes
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_contratti_dp kst_tab_contratti_dp)
public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_contratti_dp kst_tab_contratti_dp)
public function st_esito select_riga (ref st_tab_contratti_dp k_st_tab_contratti_dp)
public function st_esito tb_delete (st_tab_contratti_dp kst_tab_contratti_dp)
public function st_esito get_ultimo_id (ref st_tab_contratti_dp kst_tab_contratti_dp)
public function st_esito get_dati_default (ref st_tab_contratti_dp kst_tab_contratti_dp)
public function st_esito get_ultimo_cliente_anno (ref st_tab_contratti_dp kst_tab_contratti_dp)
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
private function st_esito stampa_documento (st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception
public function st_esito stampa_documento_definitiva (st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception
public function st_esito stampa_documento_prova (st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception
public subroutine if_isnull (ref st_tab_contratti_dp kst_tab_contratti_dp)
private function st_esito stampa_documento_print (ref datastore kds_print)
public function ds_contratti_dp_select get_dati (readonly st_tab_contratti_dp kst_tab_contratti_dp)
public function st_esito set_annulla (st_tab_contratti_dp kst_tab_contratti_dp)
public function st_esito set_attiva (st_tab_contratti_dp kst_tab_contratti_dp)
private function st_esito set_attivo (ref st_tab_contratti_dp kst_tab_contratti_dp)
public function long u_conv_to_conferma_ordine_e_listini (st_tab_contratti_dp kst_tab_contratti_dp, st_contratti_dp_to_listini kst_contratti_dp_to_listini) throws uo_exception
public function integer get_capitolati (string k_capitolati, string k_capitolato[])
private function long u_conv_conferma_ordine_to_listino (ref datastore kds_contratti_dp, st_tab_contratti kst_tab_contratti, st_contratti_dp_to_listini kst_contratti_dp_to_listini) throws uo_exception
private function st_esito set_stato (ref st_tab_contratti_dp kst_tab_contratti_dp)
public function st_esito set_trasferito (st_tab_contratti_dp kst_tab_contratti_dp)
private function st_esito set_ts_esito_operazione (ref st_tab_contratti_dp kst_tab_contratti_dp)
public subroutine log_destroy ()
public subroutine log_inizializza () throws uo_exception
public function st_esito get_id_cliente (ref st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception
public function boolean set_id_docprod (st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception
public function boolean get_form_di_stampa (ref st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception
public function long aggiorna_docprod (ref st_tab_contratti_dp kst_tab_contratti_dp[]) throws uo_exception
public function st_esito get_offerta_data (ref st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception
public function long stampa_esporta_digitale (st_docprod_esporta kst_docprod_esporta) throws uo_exception
public function boolean if_esiste (st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception
private function boolean set_form_di_stampa (readonly st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception
public function boolean get_stato (ref st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception
private function boolean set_data_stampa (readonly st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
end prototypes

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_contratti_dp kst_tab_contratti_dp);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore  di  anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_esito kst_esito
kuf_utility kuf1_utility


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	
	k_return = if_sicurezza(kkg_flag_modalita.anteprima)
	
	if not k_return then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	else
	
		if isvalid(kdw_anteprima)  then
			if kdw_anteprima.dataobject = "d_contratti_dp"  then
				if kdw_anteprima.object.id_contratto_dp[1] = kst_tab_contratti_dp.id_contratto_dp  then
					kst_tab_contratti_dp.id_contratto_dp = 0 
				end if
			end if
		end if
	
		if kst_tab_contratti_dp.id_contratto_dp > 0 then
		
			kdw_anteprima.dataobject = "d_contratti_dp"		
			kdw_anteprima.settransobject(sqlca)
	
			kdw_anteprima.reset()	
			k_rc=kdw_anteprima.retrieve(kst_tab_contratti_dp.id_contratto_dp)
		
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Contratto da visualizzare: ~n~r" + "nessun Codice indicato"
			kst_esito.esito = kkg_esito.bug
			
		end if
	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

end try

return kst_esito

end function

public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_contratti_dp kst_tab_contratti_dp);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.anteprima) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if isvalid(kdw_anteprima)  then
		if kdw_anteprima.dataobject = "d_contratti_dp"  then
			if kdw_anteprima.object.id_contratto_dp[1] = kst_tab_contratti_dp.id_contratto_dp  then
				kst_tab_contratti_dp.id_contratto_dp = 0 
			end if
		end if
	end if

	if kst_tab_contratti_dp.id_contratto_dp > 0 then
	
			kdw_anteprima.dataobject = "d_contratti_dp"		
			kdw_anteprima.settransobject(sqlca)
	
			kuf1_utility = create kuf_utility
			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_contratti_dp.id_contratto_dp)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Contratto da visualizzare: ~n~r" + "nessun Codice indicato"
			kst_esito.esito = kkg_esito.bug
			
		end if
end if


return kst_esito

end function

public function st_esito select_riga (ref st_tab_contratti_dp k_st_tab_contratti_dp);//
//--- Leggo Contratto specifico
//
long k_codice
st_esito kst_esito


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//	k_codice = k_st_tab_contratti.codice
//	
//	select 
//			 mc_co,
//			 sc_cf,
//			 sl_pt,
//			 data,
//			 data_scad,
//			 cod_cli,
//			 descr,
//			 cert_st_dose_min,
//			 cert_st_dose_max,
//			 cert_st_data_ini,
//			 cert_st_data_fin,
//			 cert_st_dati_bolla_in
//			 ,tipo
//			 ,costi_accessori
//	 into 
//			:k_st_tab_contratti.mc_co,
//			:k_st_tab_contratti.sc_cf,
//			:k_st_tab_contratti.sl_pt,
//			:k_st_tab_contratti.data,
//			:k_st_tab_contratti.data_scad,
//			:k_st_tab_contratti.cod_cli,
//			:k_st_tab_contratti.descr,
//			:k_st_tab_contratti.cert_st_dose_min,
//			:k_st_tab_contratti.cert_st_dose_max,
//			:k_st_tab_contratti.cert_st_data_ini,
//			:k_st_tab_contratti.cert_st_data_fin,
//			:k_st_tab_contratti.cert_st_dati_bolla_in
//			,:k_st_tab_contratti.tipo
//			,:k_st_tab_contratti.costi_accessori
//		from contratti
//		where 
//		codice = :k_codice
//		using sqlca;
//
//	
//	if sqlca.sqlcode <> 0 then
//		kst_esito.sqlcode = sqlca.sqlcode
//		kst_esito.SQLErrText = "Tab.Contratti (codice=" + string(k_codice) + ") : " &
//									 + trim(SQLCA.SQLErrText)
//		if sqlca.sqlcode = 100 then
//			kst_esito.esito = "100"
//		else
//			if sqlca.sqlcode > 0 then
//				kst_esito.esito = "2"
//			else	
//				kst_esito.esito = "1"
//			end if
//		end if
//	end if
	
return kst_esito


end function

public function st_esito tb_delete (st_tab_contratti_dp kst_tab_contratti_dp);//
//====================================================================
//=== Cancella il rek dalla tabella contratti_dp 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
st_open_w kst_open_w
st_tab_docprod kst_tab_docprod
kuf_sicurezza kuf1_sicurezza
kuf_docprod kuf1_docprod
kuf_doctipo kuf1_doctipo
boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = get_id_programma(kst_open_w.flag_modalita) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione 'Contratto Conto Deposito' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	try

		if kst_tab_contratti_dp.id_contratto_dp > 0 then
	
			delete from contratti_dp
				where id_contratto_dp = :kst_tab_contratti_dp.id_contratto_dp
				using sqlca;
	
			
			if sqlca.sqlcode < 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Cancellazione 'Contratto Conto Deposito' (contratti_dp):" + trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			else

//--- cancella da docprod	 tutti i riferimenti
				kst_tab_docprod.id_doc = kst_tab_contratti_dp.id_contratto_dp
				kuf1_docprod = create kuf_docprod
				kuf1_doctipo = create kuf_doctipo
				kst_tab_docprod.st_tab_g_0.esegui_commit = "N"
				kuf1_docprod.tb_delete(kst_tab_docprod, kuf1_doctipo.kki_tipo_contr_co )

			end if
			
		end if
		
	catch 	(uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()


	finally
//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_contratti_dp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_dp.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_contratti_dp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_dp.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if
		
		if isvalid(kuf1_docprod) then destroy kuf1_docprod 
		if isvalid(kuf1_doctipo) then destroy kuf1_doctipo 
		
	
	
	end try
	
end if


return kst_esito

end function

public function st_esito get_ultimo_id (ref st_tab_contratti_dp kst_tab_contratti_dp);//
//====================================================================
//=== Torna l'ultimo ID caricato 
//=== 
//=== Input: st_tab_contratti_dp non valorizzata     Output: st_tab_contratti_dp.id_contratto_dp                  
//=== Ritorna ST_ESITO
//=== 
//====================================================================

st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_contratti_dp.id_contratto_dp = 0
	
   SELECT   max(id_contratto_dp)
       into :kst_tab_contratti_dp.id_contratto_dp
		 FROM contratti_dp
			using sqlca;
	
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Contratto Conto Deposito (cercato MAX CODICE) ~n~r:" + trim(sqlca.SQLErrText)
	end if




return kst_esito




end function

public function st_esito get_dati_default (ref st_tab_contratti_dp kst_tab_contratti_dp);//
//====================================================================
//=== Torna l'ultimo dati Contratto di defualt x il caricamento
//=== 
//=== Input: st_tab_contratti_dp.anno      Output: st_tab_contratti_dp.*                  
//=== Ritorna ST_ESITO
//=== 
//====================================================================

st_esito kst_esito


	if kst_tab_contratti_dp.anno = 0 or isnull( kst_tab_contratti_dp.anno) then
		kst_tab_contratti_dp.anno = year(kg_dataoggi) 
	end if
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_contratti_dp.id_contratto_dp = 0
	kst_tab_contratti_dp.stato = kki_STATO_nuovo
	
	  SELECT 
	 	contratti_dp.id_contratto_dp,
	  	contratti_dp.anno,   
         contratti_dp.offerta_data,   
         contratti_dp.offerta_validita,   
         contratti_dp.data_inizio,   
         contratti_dp.data_fine,   
         contratti_dp.oggetto,   
         contratti_dp.id_clie_settore,   
         contratti_dp.gruppo,   
		 consegna_des ,
	    contratti_dp.iva,   
         contratti_dp.fattura_da,  
         contratti_dp.stampa_tradotta ,
		 contratti_dp.consegna_des ,
		  contratti_dp.mis_x_1 ,
		  contratti_dp.mis_y_1 ,
		  contratti_dp.mis_z_1 ,
         contratti_dp.id_listino_pregruppo,   
         contratti_dp.id_listino_voce_1,   
         contratti_dp.id_listino_voce_2,   
         contratti_dp.id_listino_voce_3,   
         contratti_dp.id_listino_voce_4,   
         contratti_dp.id_listino_voce_5,   
         contratti_dp.id_listino_voce_6,   
         contratti_dp.id_listino_voce_7,   
         contratti_dp.id_listino_voce_8,   
         contratti_dp.id_listino_voce_9,   
         contratti_dp.voce_prezzo_1,   
         contratti_dp.voce_prezzo_2,   
         contratti_dp.voce_prezzo_3,   
         contratti_dp.voce_prezzo_4,   
         contratti_dp.voce_prezzo_5,   
         contratti_dp.voce_prezzo_6,   
         contratti_dp.voce_prezzo_7,   
         contratti_dp.voce_prezzo_8,   
         contratti_dp.voce_prezzo_9
    INTO
	 	:kst_tab_contratti_dp.id_contratto_dp,
	 	:kst_tab_contratti_dp.anno,   
         :kst_tab_contratti_dp.offerta_data,   
         :kst_tab_contratti_dp.offerta_validita,   
         :kst_tab_contratti_dp.data_inizio,   
         :kst_tab_contratti_dp.data_fine,   
         :kst_tab_contratti_dp.oggetto,   
         :kst_tab_contratti_dp.id_clie_settore,   
         :kst_tab_contratti_dp.gruppo,   
		 :kst_tab_contratti_dp.consegna_des ,
         :kst_tab_contratti_dp.iva,   
         :kst_tab_contratti_dp.fattura_da , 
         :kst_tab_contratti_dp.stampa_tradotta ,
		 :kst_tab_contratti_dp.consegna_des ,
		  :kst_tab_contratti_dp.mis_x_1 ,
		  :kst_tab_contratti_dp.mis_y_1 ,
		  :kst_tab_contratti_dp.mis_z_1, 
         :kst_tab_contratti_dp.id_listino_pregruppo,   
         :kst_tab_contratti_dp.id_listino_voce_1,   
         :kst_tab_contratti_dp.id_listino_voce_2,   
         :kst_tab_contratti_dp.id_listino_voce_3,   
         :kst_tab_contratti_dp.id_listino_voce_4,   
         :kst_tab_contratti_dp.id_listino_voce_5,   
         :kst_tab_contratti_dp.id_listino_voce_6,   
         :kst_tab_contratti_dp.id_listino_voce_7,   
         :kst_tab_contratti_dp.id_listino_voce_8,   
         :kst_tab_contratti_dp.id_listino_voce_9,   
         :kst_tab_contratti_dp.voce_prezzo_1,   
         :kst_tab_contratti_dp.voce_prezzo_2,   
         :kst_tab_contratti_dp.voce_prezzo_3,   
         :kst_tab_contratti_dp.voce_prezzo_4,   
         :kst_tab_contratti_dp.voce_prezzo_5,   
         :kst_tab_contratti_dp.voce_prezzo_6,   
         :kst_tab_contratti_dp.voce_prezzo_7,   
         :kst_tab_contratti_dp.voce_prezzo_8,   
         :kst_tab_contratti_dp.voce_prezzo_9   
    FROM contratti_dp 
	where id_contratto_dp in 
		 (  SELECT   max(id_contratto_dp)
			 FROM contratti_dp 
			 where anno = :kst_tab_contratti_dp.anno
			 )
		using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_tab_contratti_dp.anno = 0
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Contratto Conto Deposito ~n~r:" + trim(sqlca.SQLErrText)
		end if
	end if




return kst_esito




end function

public function st_esito get_ultimo_cliente_anno (ref st_tab_contratti_dp kst_tab_contratti_dp);//
//====================================================================
//=== Torna l'ultimo Contratto caricato nell'anno x il cliente indicato 
//=== 
//=== Input: st_tab_contratti_dp.anno e id_cliente     Output: st_tab_clienti.id_contratto_dp/offerta_data                  
//=== Ritorna ST_ESITO
//=== 
//====================================================================

st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())
	
   SELECT  offerta_data, max(id_contratto_dp)  
       into :kst_tab_contratti_dp.id_contratto_dp
		 FROM contratti_dp
		 where id_cliente = :kst_tab_contratti_dp.id_cliente
		 	and offerta_data in (select max(offerta_data) from contratti_dp where id_cliente =  :kst_tab_contratti_dp.id_cliente and anno = :kst_tab_contratti_dp.anno)
			 group by offerta_data
			using kguo_sqlca_db_magazzino ;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Contratto di Conto Deposito (cercato Ultimo Documento) ~n~r:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
	end if


return kst_esito




end function

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;//
//=== 
//====================================================================
//=== Attiva LINK cliccato 
//===
//=== Par. Inut: 
//===               datawindow su cui è stato attivato il LINK
//===               nome campo di LINK
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return=true
st_tab_contratti_dp kst_tab_contratti_dp
st_esito kst_esito
uo_exception kuo_exception
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
//kuf_menu_window kuf1_menu_window
//kuf_web kuf1_web
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


choose case a_campo_link

	case "id_contratto_dp"
		kst_tab_contratti_dp.id_contratto_dp = adw_link.getitemnumber(adw_link.getrow(), a_campo_link)
		if kst_tab_contratti_dp.id_contratto_dp > 0 then
			kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_contratti_dp )
			if kst_esito.esito <> kkg_esito.ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Contratto  Conto Deposito  (nr.=" + trim(string(kst_tab_contratti_dp.id_contratto_dp)) + ") " 
		else
			k_return = false
		end if

end choose

if k_return then

	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//=== Parametri : 
	//=== struttura st_open_w
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
//		kuf1_menu_window = create kuf_menu_window 
		kGuf_menu_window.open_w_tabelle(kst_open_w)
//		destroy kuf1_menu_window


	else
		
		kuo_exception = create uo_exception
		kuo_exception.setmessage( "Nessun valore disponibile. " )
		throw kuo_exception
		
		
	end if

end if

SetPointer(kp_oldpointer)



return k_return

end function

private function st_esito stampa_documento (st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception;//====================================================================
//=== 
//=== Prepara e Stampa Contratto 
//===
//=== Par. Inut:    kst_tab_contratti_dp (valorizzare il num. Documento)
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:    Vedi standard
//=== 
//====================================================================
//
//=== 
string k_rcx
long k_rc, k_riga
boolean k_return
//uo_d_std_1 kds_print
datastore kds_print
st_open_w kst_open_w
st_esito kst_esito, kst_esito_armo
st_profilestring_ini kst_profilestring_ini
kuf_sicurezza kuf1_sicurezza
kuf_base kuf1_base



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.stampa) //kkg_id_programma_contratti_dp

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa Documento non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	try

		if kst_tab_contratti_dp.id_contratto_dp > 0 then		
	
	//--- Ricavo il nome del form se Documento gia' stampato
			kst_tab_contratti_dp.data_stampa = KKG.DATA_ZERO 
			get_form_di_stampa(kst_tab_contratti_dp)
			
	
	//--- popola il DW con l'attestato da stampare
			kds_print = create datastore
			
			if len(trim(kst_tab_contratti_dp.form_di_stampa)) > 0 then  //--- se sono in ristampa allora riprendo il form originale
				kds_print.dataobject = trim(kst_tab_contratti_dp.form_di_stampa) 
			else
				kds_print.dataobject = kki_form_di_stampa_attuale
			end if
//--- Imposta  Risorse Grafiche
			if len(trim(kGuo_path.get_risorse())) > 0 then
				k_rcx=kds_print.Modify("p_img.Filename='" + kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img.text"))+ "'") 
				k_rcx=kds_print.Modify("p_img_0.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img_0.text")) + "'")  
				k_rcx=kds_print.Modify("p_img_1.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img_1.text")) + "'") 
				k_rcx=kds_print.Modify("p_img_2.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img_2.text")) + "'") 
			end if
//			ki_path_risorse = kGuo_path.get_risorse() + "\" + "logo_orig_bn.bmp"
//			k_rcx=kds_print.Modify("p_img.Filename='" + ki_path_risorse + "'")
//		
//			if len(trim(kds_print.Describe("txt_p_img_0.text"))) > 0 then
//				ki_path_risorse = kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img_0.text"))   //"logo_iso_certiquality2006.bmp"
//				k_rcx=kds_print.Modify("p_img_0.Filename='" + ki_path_risorse + "'")
//			end if
//			if len(trim(kds_print.Describe("txt_p_img_1.text"))) > 0 then
//				ki_path_risorse = kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img_1.text"))   //"logo_iso_certiquality2006.bmp"
//				k_rcx=kds_print.Modify("p_img_1.Filename='" + ki_path_risorse + "'")
//			end if
//			if len(trim(kds_print.Describe("txt_p_img_2.text"))) > 0 then
//				ki_path_risorse = kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img_2.text"))   //"logo_iso_certiquality2006.bmp"
//				k_rcx=kds_print.Modify("p_img_2.Filename='" + ki_path_risorse + "'")
//			end if


	
			kds_print.settransobject(sqlca)
	
	//--- retrive dell'attestato 
			k_rc=kds_print.retrieve(  kst_tab_contratti_dp.id_contratto_dp )
	
			if kds_print.rowcount() > 0 then
	
	//--- LANCIA LA STAMPA !!!
				stampa_documento_print(kds_print)
	
			end if
			
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessuna stampa eseguita: ~n~r" + "Numero Documento non indicato"
			kst_esito.esito = kkg_esito.bug
			
		end if
		
	catch (uo_exception kuo_exception)
		throw kuo_exception
		
	finally
		destroy kds_print
		
	end try
end if




return kst_esito

end function

public function st_esito stampa_documento_definitiva (st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception;//
//=== 
//====================================================================
//=== 
//=== Aggiorna Tabelle + Prepara + Stampa Contratto Conto Deposito
//===
//=== Par. Inut: kst_tab_contratti_dp (valorizzare il num. Documento)
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:    Vedi standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
datawindow kdw_print
st_tab_contratti_dp kst_tab_contratti_dp_array[]
st_open_w kst_open_w
st_esito kst_esito
st_profilestring_ini kst_profilestring_ini
kuf_sicurezza kuf1_sicurezza
uo_exception kuo_exception



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.modifica) //kkg_id_programma_contratti_dp

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa Definitiva del Documento non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_contratti_dp.id_contratto_dp > 0 then	

		try 
			
			kst_tab_contratti_dp.x_datins = kGuf_data_base.prendi_x_datins()
			kst_tab_contratti_dp.x_utente = kGuf_data_base.prendi_x_utente()
			kst_tab_contratti_dp.stato = kki_STATO_stampato
		
//--- aggiorna archivio
			get_form_di_stampa(kst_tab_contratti_dp)
			if len(trim(kst_tab_contratti_dp.form_di_stampa)) > 0 then 
				kst_tab_contratti_dp.st_tab_g_0.esegui_commit = "N"
				set_form_di_stampa(kst_tab_contratti_dp)
			end if
			kst_tab_contratti_dp.st_tab_g_0.esegui_commit = "N"
			kst_esito = set_stato(kst_tab_contratti_dp)
			if kst_esito.esito = kkg_esito.ok then
				kst_tab_contratti_dp.data_stampa = kg_dataoggi
				set_data_stampa(kst_tab_contratti_dp)
				kst_tab_contratti_dp_array[1] = kst_tab_contratti_dp 
			else
				kst_tab_contratti_dp_array[1].id_contratto_dp = 0  // evita di caricare nell'archivio esporta-pdf
			end if				

//		UPDATE contratti_dp  
//     		SET data_stampa = :kg_dataoggi   
//         		,stato = :kst_tab_contratti_dp.stato
//				,form_di_stampa = :kst_tab_contratti_dp.form_di_stampa	
//				,x_datins =:kst_tab_contratti_dp.x_datins
//				,x_utente = :kst_tab_contratti_dp.x_utente
//   			WHERE contratti_dp.id_contratto_dp = :kst_tab_contratti_dp.id_contratto_dp   
// 			  using sqlca;

//--- LANCIA LA PREPARAZIONE E STAMPA !!!
			stampa_documento(kst_tab_contratti_dp)

		catch (uo_exception kuo_exception1)
			kst_esito = kuo_exception1.get_st_esito( )


		finally
			if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn or  kst_esito.esito = kkg_esito.no_esecuzione then 
				kst_esito = kGuf_data_base.db_commit_1( ) 	
				if kst_esito.esito <> kkg_esito.ok then
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito )
					throw kuo_exception
				end if
			else
				kGuf_data_base.db_rollback_1( )

				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Fallita Registrazione dati per stampa Documento: "+ string(kst_tab_contratti_dp.id_contratto_dp) + "~n~r"&
							 + "Errore: " + trim(sqlca.sqlerrtext)
				kst_esito.esito = kkg_esito.db_ko
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
	
		
		end try
				

		
//--- Aggiunge la riga in DOCPROD x l'esportazione digitale ----------------------------------------------------------------------------------------
		try 

			if kst_tab_contratti_dp_array[1].id_contratto_dp > 0 then
				kst_tab_contratti_dp_array[1].st_tab_g_0.esegui_commit = "S"
				aggiorna_docprod(kst_tab_contratti_dp_array[])
			end if
			
			
		catch (uo_exception kuo_exception2)
			kst_esito = kuo_exception2.get_st_esito( )
			kst_esito.sqlerrtext = "Archivio Contratto R. & D. Aggiornato Correttamente !  Ma si sono verificate le seguenti anonalie: ~n~r" + trim(kst_esito.sqlerrtext)

			
		finally
		
		end try
				
		
		
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna stampa eseguita: ~n~r" + "Numero Documento non indicato, registrazione dati non effettuata."
		kst_esito.esito = kkg_esito.bug
		
	end if
end if


return kst_esito

end function

public function st_esito stampa_documento_prova (st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception;//
//=== 
//====================================================================
//=== 
//===Prova/Duplicato fa Preparazione + Stampa Contratto Conto Deposito (NO AGGIORNAMENTO)
//===
//=== Par. Inut: kst_tab_contratti_dp (valorizzare il num. Documento)
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:    Vedi standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
datawindow kdw_print
st_open_w kst_open_w
st_esito kst_esito
st_profilestring_ini kst_profilestring_ini
kuf_sicurezza kuf1_sicurezza
uo_exception kuo_exception



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.stampa) //kkg_id_programma_contratti_dp

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa (duplicato) Documento non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_contratti_dp.id_contratto_dp > 0 then		

//--- LANCIA LA PREPARAZIONE E STAMPA !!!
		stampa_documento(kst_tab_contratti_dp)

		
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna stampa eseguita: ~n~r" + "Numero Documento non indicato, registrazione dati non effettuata."
		kst_esito.esito = kkg_esito.bug
		
	end if
end if


return kst_esito

end function

public subroutine if_isnull (ref st_tab_contratti_dp kst_tab_contratti_dp);//---
//--- Inizializza i campi della tabella 
//---
if isnull(kst_tab_contratti_dp.id_contratto_dp ) then kst_tab_contratti_dp.id_contratto_dp = 0
//if isnull(kst_tab_contratti_dp.codice ) then kst_tab_contratti_dp.codice = ""
if isnull(kst_tab_contratti_dp.abi ) then kst_tab_contratti_dp.abi = 0
if isnull(kst_tab_contratti_dp.altre_condizioni ) then kst_tab_contratti_dp.altre_condizioni = " "
if isnull(kst_tab_contratti_dp.anno ) then kst_tab_contratti_dp.anno = year(KG_DATAOGGI)
if isnull(kst_tab_contratti_dp.magazzino ) then kst_tab_contratti_dp.magazzino = kkg_magazzino.dep
if isnull(kst_tab_contratti_dp.banca ) then kst_tab_contratti_dp.banca = " "
if isnull(kst_tab_contratti_dp.unita_misura ) then kst_tab_contratti_dp.unita_misura = " "
if isnull(kst_tab_contratti_dp.cab ) then kst_tab_contratti_dp.cab = 0
if isnull(kst_tab_contratti_dp.cod_pag ) then kst_tab_contratti_dp.cod_pag = 0
if isnull(kst_tab_contratti_dp.stampa_tradotta ) then kst_tab_contratti_dp.stampa_tradotta = ""
if isnull(kst_tab_contratti_dp.data_stampa ) then kst_tab_contratti_dp.data_stampa = date(0)
if isnull(kst_tab_contratti_dp.data_fine ) then kst_tab_contratti_dp.data_fine = date(0)
if isnull(kst_tab_contratti_dp.data_inizio ) then kst_tab_contratti_dp.data_inizio = date(0) //date(31, 12, year(KG_DATAOGGI) )
if isnull(kst_tab_contratti_dp.mis_x_1 ) then kst_tab_contratti_dp.mis_x_1 = 0
if isnull(kst_tab_contratti_dp.mis_y_1 ) then kst_tab_contratti_dp.mis_y_1 = 0
if isnull(kst_tab_contratti_dp.mis_z_1 ) then kst_tab_contratti_dp.mis_z_1 = 0
if isnull(kst_tab_contratti_dp.qta_anno ) then kst_tab_contratti_dp.qta_anno = 0.00
if isnull(kst_tab_contratti_dp.qta_max_disponibile ) then kst_tab_contratti_dp.qta_max_disponibile = 0.00
if isnull(kst_tab_contratti_dp.peso_max_kg ) then kst_tab_contratti_dp.peso_max_kg = 0.00
if isnull(kst_tab_contratti_dp.gest_doc_des ) then kst_tab_contratti_dp.gest_doc_des = ""
if isnull(kst_tab_contratti_dp.altre_condizioni ) then kst_tab_contratti_dp.altre_condizioni = ""
if isnull(kst_tab_contratti_dp.fattura_da ) then kst_tab_contratti_dp.fattura_da = ""

if isnull(kst_tab_contratti_dp.id_listino_pregruppo ) then kst_tab_contratti_dp.id_listino_pregruppo = 0
if isnull(kst_tab_contratti_dp.id_listino_voce_1 ) then kst_tab_contratti_dp.id_listino_voce_1 = 0
if isnull(kst_tab_contratti_dp.id_listino_voce_2 ) then kst_tab_contratti_dp.id_listino_voce_2 = 0
if isnull(kst_tab_contratti_dp.id_listino_voce_3 ) then kst_tab_contratti_dp.id_listino_voce_3 = 0
if isnull(kst_tab_contratti_dp.id_listino_voce_4 ) then kst_tab_contratti_dp.id_listino_voce_4 = 0
if isnull(kst_tab_contratti_dp.id_listino_voce_5 ) then kst_tab_contratti_dp.id_listino_voce_5 = 0
if isnull(kst_tab_contratti_dp.id_listino_voce_6 ) then kst_tab_contratti_dp.id_listino_voce_6 = 0
if isnull(kst_tab_contratti_dp.id_listino_voce_7 ) then kst_tab_contratti_dp.id_listino_voce_7 = 0
if isnull(kst_tab_contratti_dp.id_listino_voce_8 ) then kst_tab_contratti_dp.id_listino_voce_8 = 0
if isnull(kst_tab_contratti_dp.id_listino_voce_9 ) then kst_tab_contratti_dp.id_listino_voce_9 = 0
if isnull(kst_tab_contratti_dp.voce_prezzo_1 ) then kst_tab_contratti_dp.voce_prezzo_1 = 0.00
if isnull(kst_tab_contratti_dp.voce_prezzo_2 ) then kst_tab_contratti_dp.voce_prezzo_2 = 0.00
if isnull(kst_tab_contratti_dp.voce_prezzo_3 ) then kst_tab_contratti_dp.voce_prezzo_3 = 0.00
if isnull(kst_tab_contratti_dp.voce_prezzo_4 ) then kst_tab_contratti_dp.voce_prezzo_4 = 0.00
if isnull(kst_tab_contratti_dp.voce_prezzo_5 ) then kst_tab_contratti_dp.voce_prezzo_5 = 0.00
if isnull(kst_tab_contratti_dp.voce_prezzo_6 ) then kst_tab_contratti_dp.voce_prezzo_6 = 0.00
if isnull(kst_tab_contratti_dp.voce_prezzo_7 ) then kst_tab_contratti_dp.voce_prezzo_7 = 0.00
if isnull(kst_tab_contratti_dp.voce_prezzo_8 ) then kst_tab_contratti_dp.voce_prezzo_8 = 0.00
if isnull(kst_tab_contratti_dp.voce_prezzo_9 ) then kst_tab_contratti_dp.voce_prezzo_9 = 0.00

if isnull(kst_tab_contratti_dp.consegna_des ) then kst_tab_contratti_dp.consegna_des = ""

if isnull(kst_tab_contratti_dp.gruppo ) then kst_tab_contratti_dp.gruppo = 0
if isnull(kst_tab_contratti_dp.art ) then kst_tab_contratti_dp.art = ""
if isnull(kst_tab_contratti_dp.id_clie_settore ) then kst_tab_contratti_dp.id_clie_settore = ""
if isnull(kst_tab_contratti_dp.id_cliente ) then kst_tab_contratti_dp.id_cliente = 0
if isnull(kst_tab_contratti_dp.iva ) then kst_tab_contratti_dp.iva = 0
if isnull(kst_tab_contratti_dp.nome_contatto ) then kst_tab_contratti_dp.nome_contatto = " "
if isnull(kst_tab_contratti_dp.note ) then kst_tab_contratti_dp.note = " "
if isnull(kst_tab_contratti_dp.offerta_data ) then kst_tab_contratti_dp.offerta_data = date(0)
if isnull(kst_tab_contratti_dp.offerta_validita ) then kst_tab_contratti_dp.offerta_validita = " "
if isnull(kst_tab_contratti_dp.oggetto ) then kst_tab_contratti_dp.oggetto = " "

if isnull(kst_tab_contratti_dp.x_datins) then kst_tab_contratti_dp.x_datins = datetime(date(0))
if isnull(kst_tab_contratti_dp.x_utente) then kst_tab_contratti_dp.x_utente = " "

end subroutine

private function st_esito stampa_documento_print (ref datastore kds_print);//
//====================================================================
//=== Stampa Contratto Conto Deposito 
//=== per eseguire la stampa lanciare la routine "stampa_documento"
//===
//=== Par. Input:   datawindow da stampare
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:    Vedi standard 
//=== 
//====================================================================
//
int k_errore
string k_rag_soc, k_rcx
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
st_stampe kst_stampe
kuf_sicurezza kuf1_sicurezza
//kuf_base kuf1_base
kuf_utility kuf1_utility

pointer K_oldpointer


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.stampa) //kkg_id_programma_contratti_dp

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa Documento non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kds_print.rowcount() > 0 then

		k_rag_soc = mid(trim(kds_print.object.rag_soc_10[1]),1,8)
		kuf1_utility = create kuf_utility
		k_rag_soc = kuf1_utility.u_stringa_pulisci(k_rag_soc)
		destroy kuf1_utility
		kds_print.Object.DataWindow.Print.DocumentName= "contratto_dpmmerciale_" + trim(string(kds_print.object.id_contratto_dp[1])) + "_" + trim(k_rag_soc) 
		kds_print.setitem(1, "k_marca_stampa",  " - D" + string(kg_dataoggi, "ddmmyy") + ".H" + string(now(), "hh:mm") + ".U" + kGuf_data_base.prendi_x_utente() )


//=== Puntatore Cursore da attesa.....
		K_oldpointer = SetPointer(HourGlass!)

		kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta
		kst_stampe.ds_print = create datastore
		kst_stampe.ds_print.dataobject = kds_print.dataobject
		kds_print.rowscopy( 1, kds_print.rowcount() , primary!, kst_stampe.ds_print, 1, primary!)
//		kst_stampe.ds_print = kds_print
		kst_stampe.titolo = "Stampa Documento nr. " + string(kds_print.object.id_contratto_dp[1])
		kst_stampe.stampante_predefinita = "" 
		kst_stampe.modificafont = kuf_stampe.ki_stampa_modificafont_no

////---- imposta i loghi			
//		if len(trim(kGuo_path.get_risorse())) > 0 then
//			k_rcx=kst_stampe.ds_print.Modify("p_img.Filename='" + kGuo_path.get_risorse() + "\" + trim(kst_stampe.ds_print.Describe("txt_p_img.text"))+ "'") 
//			k_rcx=kst_stampe.ds_print.Modify("p_img_0.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kst_stampe.ds_print.Describe("txt_p_img_0.text")) + "'")  
//			k_rcx=kst_stampe.ds_print.Modify("p_img_1.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kst_stampe.ds_print.Describe("txt_p_img_1.text")) + "'") 
//			k_rcx=kst_stampe.ds_print.Modify("p_img_2.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kst_stampe.ds_print.Describe("txt_p_img_2.text")) + "'") 
//		end if
//
		k_errore = kGuf_data_base.stampa_dw(kst_stampe)
		if k_errore = 0 then
			kst_esito.esito = kkg_esito.OK
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Stampa Documento non effettuata! ~n~r" 
			kst_esito.esito = kkg_esito.bug
		end if

			
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Documento da stampare ~n~r" 
		kst_esito.esito = kkg_esito.bug
		
	end if

	SetPointer(K_oldpointer)

end if



return kst_esito

end function

public function ds_contratti_dp_select get_dati (readonly st_tab_contratti_dp kst_tab_contratti_dp);//
//====================================================================
//=== Torna tutt i dati del record/riga
//=== 
//=== Input: st_tab_contratti_dp.id_contratto_dp
//=== Output: ds ds_contratti_dp_select
//=== Ritorna ST_ESITO
//=== 
//====================================================================

st_esito kst_esito
ds_contratti_dp_select kds_contratti_dp_select

	
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kds_contratti_dp_select = create ds_contratti_dp_select

	if kst_tab_contratti_dp.id_contratto_dp > 0 then
	
		kds_contratti_dp_select.retrieve(kst_tab_contratti_dp.id_contratto_dp )
		
		if kds_contratti_dp_select.kist_esito.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kds_contratti_dp_select.kist_esito.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Contratto Conto Deposito ~n~r:" + trim(kds_contratti_dp_select.kist_esito.SQLErrText)
		end if

	end if


return kds_contratti_dp_select




end function

public function st_esito set_annulla (st_tab_contratti_dp kst_tab_contratti_dp);//
//====================================================================
//=== Annulla il rek dalla tabella contratti_dp 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_tab_contratti_dp.attivo = kki_ATTIVO_no

kst_esito = set_attivo(kst_tab_contratti_dp)

return kst_esito

end function

public function st_esito set_attiva (st_tab_contratti_dp kst_tab_contratti_dp);//
//====================================================================
//=== Ripristina il rek dalla tabella contratti_dp 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_tab_contratti_dp.attivo = kki_ATTIVO_si

kst_esito = set_attivo(kst_tab_contratti_dp)

return kst_esito

end function

private function st_esito set_attivo (ref st_tab_contratti_dp kst_tab_contratti_dp);//
//====================================================================
//=== Set del flag ATTIVO ( x Annullare il rek dalla tabella contratti_dp) 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = get_id_programma (kkg_flag_modalita.cancellazione) //kkg_id_programma_contratti_dp

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Annullo/Ripristino 'Contratto Conto Deposito' non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_contratti_dp.id_contratto_dp > 0 then

		update contratti_dp
		    set attivo = :kst_tab_contratti_dp.attivo
			where id_contratto_dp = :kst_tab_contratti_dp.id_contratto_dp
			using sqlca;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Annullo/Ripristino 'Contratto Conto Deposito' (contratti_dp):" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		
		else
	
//---- COMMIT....	
			if kst_esito.esito = kkg_esito.db_ko then
				if kst_tab_contratti_dp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_dp.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_rollback_1( )
				end if
			else
				if kst_tab_contratti_dp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_dp.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_commit_1( )
				end if
			end if
		end if
	end if
end if


return kst_esito

end function

public function long u_conv_to_conferma_ordine_e_listini (st_tab_contratti_dp kst_tab_contratti_dp, st_contratti_dp_to_listini kst_contratti_dp_to_listini) throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- Alimenta tabella Conferma Ordine (CO) e Listini da Contratto Conto Deposito 
//---
//--- inp: kst_tab_contratti_dp.id_contratto_dp,  st_contratti_dp_to_listini x sapere se simulazione ecc... o meno
//--- out: -
//--- ritorna: nr contratti commerciali Trasferiti
//--- lancia Exception: uo_exception x errore grave
//---
//---
//---------------------------------------------------------------------------------------------------------------------------------------------------
//
long k_ctr_contratti_dp_trasferiti=0
long k_ctr_st_tab_contratti=1, k_ctr=0, k_ctr_contratti_dp_to_listini=0, k_ctr_ins_contratti=0
st_tab_gru kst_tab_gru
st_tab_listino kst_tab_listino
st_tab_contratti kst_tab_contratti[], kst_tab_contratti_select
st_tab_esito_operazioni kst_tab_esito_operazioni
st_esito kst_esito
kuf_sl_pt kuf1_sl_pt
kuf_contratti kuf1_contratti
kuf_ausiliari kuf1_ausiliari
datastore kds_contratti_dp


try 
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kGuo_exception.set_esito(kst_esito) 
	
	kuf1_ausiliari = create kuf_ausiliari
	kuf1_contratti = create kuf_contratti

	

//--- legge i dati del Contratto Conto Deposito
	kds_contratti_dp = create datastore
	kds_contratti_dp.dataobject = "d_contratti_dp"
	kds_contratti_dp.settransobject( sqlca)
	if kds_contratti_dp.retrieve(kst_tab_contratti_dp.id_contratto_dp) > 0 then
	
	
		kst_tab_contratti[k_ctr_st_tab_contratti].codice = 0
		kst_tab_contratti[k_ctr_st_tab_contratti].mc_co = "DEP" + string(kst_tab_contratti_dp.id_contratto_dp) + "/" + string(kds_contratti_dp.getitemdate(1, "data_inizio"), "yyyy")
		
		kst_tab_contratti[k_ctr_st_tab_contratti].cod_cli = kds_contratti_dp.getitemnumber(1, "id_cliente")
		kst_tab_contratti[k_ctr_st_tab_contratti].contratto_co_data_ins = kGuf_data_base.prendi_dataora( )
		kst_tab_contratti[k_ctr_st_tab_contratti].id_contratto_dp = kst_tab_contratti_dp.id_contratto_dp
	
		kst_tab_contratti[k_ctr_st_tab_contratti].data = kds_contratti_dp.getitemdate(1, "data_inizio")
		kst_tab_contratti[k_ctr_st_tab_contratti].data_scad = kds_contratti_dp.getitemdate(1, "data_fine")
	
		kst_tab_contratti[k_ctr_st_tab_contratti].tipo = kuf1_contratti.kki_tipo_deposito
		
//--- aggiunge riga al log
		if kst_contratti_dp_to_listini.k_simulazione = "N"  then // se non sono in simulazione eseguo!
			kiuf_esito_operazioni.tb_add_riga("-----------> Inizio carico trasferimento Contratto Conto Deposito: " + string(kst_tab_contratti_dp.id_contratto_dp) + "; carico in automatico CO / LISTINI<-----------", false)
		else
			if kst_contratti_dp_to_listini.k_simulazione = "S"  then // se sono in simulazione eseguo!
				kiuf_esito_operazioni.tb_add_riga("-----------> Inizio SIMULAZIONE trasferimento Contratto Conto Deposito: " + string(kst_tab_contratti_dp.id_contratto_dp) + "<-----------", false)
			else
				kiuf_esito_operazioni.tb_add_riga("-----------> Inizio ad impostare a 'TRASFERITO' il Contratto Conto Deposito: " + string(kst_tab_contratti_dp.id_contratto_dp) + "; Compito dell'operatore caricare CO e LISTINI<-----------", false)
			end if
		end if


//--- piglio la descrizione del Gruppo
		if kds_contratti_dp.getitemnumber(1, "gruppo") > 0 then
			kst_tab_gru.codice = kds_contratti_dp.getitemnumber(1, "gruppo") 
			kst_esito = kuf1_ausiliari.tb_select(kst_tab_gru)
			if kst_esito.esito = kkg_esito.ok then
				kst_tab_contratti[k_ctr_st_tab_contratti].descr = trim(kst_tab_gru.des ) 
			else
				kst_tab_contratti[k_ctr_st_tab_contratti].descr = "Gruppo " + string(kds_contratti_dp.getitemnumber(1, "gruppo")) + " non trovato "
			end if
		end if
//--- se ho trovato errore Grave lancio eccezione
		if kst_esito.esito = kkg_esito.db_ko then
			kst_esito.sqlerrtext = "Errore durante lettura descrizione Gruppo codice " + string(kst_tab_gru.codice) + " (Contratto non Trasferito a Listino).  ~n~r" + kst_esito.sqlerrtext 
			kGuo_exception.set_esito(kst_esito) 
			kiuf_esito_operazioni.tb_add_riga(kst_esito.sqlerrtext, true) //--- aggiunge riga al log
			throw kGuo_exception
		end if

//--- nessun capitolato e sl-pt previsto				
		kst_tab_contratti[k_ctr_st_tab_contratti].cert_st_dose_min =  "N"
		kst_tab_contratti[k_ctr_st_tab_contratti].sc_cf = ""
		kst_tab_contratti[k_ctr_st_tab_contratti].sl_pt = ""

//--- get Cliente da Contratto Conto Deposito
		kst_tab_contratti[k_ctr_st_tab_contratti].cod_cli = kds_contratti_dp.getitemnumber(1,"id_cliente")

//--- Carico le Conferme Ordine e Listini 
		for  k_ctr_ins_contratti = 1 to k_ctr_st_tab_contratti 
			
			if len(trim(kst_tab_contratti[k_ctr_ins_contratti].mc_co)) > 0 then 
				
				if kst_contratti_dp_to_listini.k_simulazione <> "M" then // se carico arch. MANUALMENTE non fa nulla
				
//--- Controlla l'esistenza del CO se già esiste NON carico
					kst_tab_contratti_select = kst_tab_contratti[k_ctr_ins_contratti]
					kst_tab_contratti[k_ctr_ins_contratti].codice = kuf1_contratti.if_esiste_co_x_mc_co(kst_tab_contratti_select)   // if_esiste_co(kst_tab_contratti_select) 
					if kst_tab_contratti[k_ctr_ins_contratti].codice = 0 then
				
//--- Aggiunge Conferma Ordine  CO
						if kst_contratti_dp_to_listini.k_simulazione = "N"  then // se non sono in simulazione eseguo!
							kst_tab_contratti[k_ctr_ins_contratti].st_tab_g_0.esegui_commit = "N"
							kst_tab_contratti[k_ctr_ins_contratti].codice = kuf1_contratti.tb_add(kst_tab_contratti[k_ctr_ins_contratti]) // ADD DEL CO
						end if
					else
//--- aggiunge riga al log
						kst_esito.esito = "Conferma Ordine già presente (non generata).  ~n~r"
						kiuf_esito_operazioni.tb_add_riga(kst_esito.sqlerrtext, true) //--- aggiunge riga al log
					end if
				
//--- carico LISTINO
					kst_tab_listino.st_tab_g_0.esegui_commit = "N"
					kst_tab_listino.id = this.u_conv_conferma_ordine_to_listino( kds_contratti_dp,  kst_tab_contratti[k_ctr_ins_contratti], kst_contratti_dp_to_listini)  // ADD DEL LISTINO
						
				end if  // fine SE sono in MANUALE
					
//--- Aggiorna lo STATO del Contratto Conto Deposito a TRASFERITO
				if kst_contratti_dp_to_listini.k_simulazione <> "S" then
					
					k_ctr_contratti_dp_trasferiti++  //nr contratti trasferiti
					
					kst_tab_contratti_dp.st_tab_g_0.esegui_commit = "N"
					kst_esito = set_trasferito(kst_tab_contratti_dp)
					if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
						kst_esito.esito = "Contratto Conto Deposito Trasferito a Listino ma 'STATO' non aggiornato.  ~n~r" + kst_esito.esito 
						kGuo_exception.set_esito(kst_esito) 
						kiuf_esito_operazioni.tb_add_riga(kst_esito.sqlerrtext, true) //--- aggiunge riga al log
						throw kGuo_exception
					end if

				else
//--- aggiunge riga al log
					kiuf_esito_operazioni.tb_add_riga("simulazione di carico del Listino corretta ", false)
				end if
				
				
//--- Visto che tutto OK COMMIT			
				if kst_contratti_dp_to_listini.k_simulazione <> "S" then
					kst_esito = kGuf_data_base.db_commit_1( )  //COMMIT
//--- se ho trovato errore Grave lancio eccezione
					if kst_esito.esito = kkg_esito.ok then
						k_ctr_contratti_dp_to_listini ++
//--- aggiunge riga al log
						kiuf_esito_operazioni.tb_add_riga("caricato il Listino codice: " + string(kst_tab_listino.id), false)
					else
						kGuf_data_base.db_rollback_1( )  //ROLLBACK 
						kst_esito.sqlerrtext = "Errore in elaborazione Contratto Conto Deposito nr. " + string(kst_tab_contratti_dp.id_contratto_dp) + " (non Trasferito).  ~n~r" + kst_esito.sqlerrtext 
						kGuo_exception.set_esito(kst_esito) 
						kiuf_esito_operazioni.tb_add_riga(kst_esito.sqlerrtext, true) //--- aggiunge riga al log
						throw kGuo_exception
					end if
				else
//--- aggiunge riga al log
					kiuf_esito_operazioni.tb_add_riga("simulazione di carico Conferma Ordine corretta ", false)
				end if
				
				
			end if
			
		end for
		
	else

//--- contratto NON TROVATO
		kst_esito.sqlerrtext = "Contratto Conto Deposito non Trovato!   " 
		kGuo_exception.set_esito(kst_esito) 
		kiuf_esito_operazioni.tb_add_riga(kst_esito.sqlerrtext, true) //--- aggiunge riga al log
		throw kGuo_exception
		
	end if

//--- SE ERRORE	
catch (uo_exception kuo_exception)
	if kst_contratti_dp_to_listini.k_simulazione <> "S" and k_ctr_contratti_dp_to_listini > 0 then
		kGuf_data_base.db_rollback_1( )  //ROLLBACK 
	end if
	kst_esito = kuo_exception.get_st_esito()
	kst_esito.sqlerrtext = "Errore durante elaborazione del Contratto Conto Deposito nr. " + string(kst_tab_contratti_dp.id_contratto_dp) + ".  ~n~r" + kst_esito.sqlerrtext 
	kuo_exception.set_esito(kst_esito)
	kiuf_esito_operazioni.tb_add_riga(kst_esito.sqlerrtext, true ) //--- aggiunge riga al log
	throw kuo_exception


finally 
	

//--- aggiunge riga FINALE al log
	if kst_contratti_dp_to_listini.k_simulazione = "N"  then // se non sono in simulazione eseguo!
		kiuf_esito_operazioni.tb_add_riga("-----------> Fine carico archivi, trasferito Contratto Conto Deposito: " + string(kst_tab_contratti_dp.id_contratto_dp) + " <----------- ", false)
	else
		if kst_contratti_dp_to_listini.k_simulazione = "S"  then // se sono in simulazione eseguo!
			kiuf_esito_operazioni.tb_add_riga("-----------> Fine SIMULAZIONE trasferimento Contratto Conto Deposito: " + string(kst_tab_contratti_dp.id_contratto_dp) + " <----------- ", false)
		else
			kiuf_esito_operazioni.tb_add_riga("-----------> Fine, archivi non caricati ma 'Trasferito' Contratto Conto Deposito: " + string(kst_tab_contratti_dp.id_contratto_dp) + " <----------- ", false)
		end if
	end if
//--- Scrive LOG esiti su DB
	kst_tab_esito_operazioni.st_tab_g_0.esegui_commit = "S"
	kst_tab_contratti_dp.esito_operazioni_ts_operazione = kiuf_esito_operazioni.tb_add(kst_tab_esito_operazioni)
//--- scrive su Conto Deposito il riferimento all'esito 	
	kst_tab_contratti_dp.st_tab_g_0.esegui_commit = "S"
	this.set_ts_esito_operazione(kst_tab_contratti_dp)

	
	destroy kuf1_contratti
	destroy kuf1_ausiliari
	destroy kds_contratti_dp
	
end try


return k_ctr_contratti_dp_trasferiti

end function

public function integer get_capitolati (string k_capitolati, string k_capitolato[]);//--------------------------------------------------------------------------------------------------------------------------------------------------		
//--- 
//--- Estrae i Capitolati da una stringa quale ad esempio la 'st_contratti_dp.contratti_des'
//--- 
//--- inp: stringa con i cf separati da ';' 
//--- out: array con i cf trovati
//--- rit.: nr dei cf trovati
//--- Lancia EXCEPTION
//---
//--------------------------------------------------------------------------------------------------------------------------------------------------		
//
int k_return = 0



try

//		k_nr_capitolato=0
////--- cerca il carattere separatore  ';' e ' - ' 				
//			k_trova = ";"
//			k_pos = pos(kst_tab_contratti_dp.contratti_des, k_trova, k_start)
//			if k_pos = 0 then
//				k_trova = " - "
//				k_pos=pos(kst_tab_contratti_dp.contratti_des, k_trova, k_start)
//			end if
////--- cerca altri sc-cf				
//			do while k_pos > 0 
//				kst_tab_contratti.sc_cf = trim(mid(kst_tab_contratti_dp.contratti_des, k_start, k_pos - k_start))
//				if len(trim(kst_tab_contratti.sc_cf)) > 0 then
//	//--- esiste il CF estratto?
//					k_nr_capitolato++
//					if NOT kuf1_contratti.if_esiste_sc_cf(kst_tab_contratti) then
//						k_return = tab_1.tabpage_1.text + ": non Trovato il Capitolato (" + string(k_nr_capitolato) + ") cod. " + string(kst_tab_contratti.sc_cf ) + "~n~r" 
//						k_errore = "1"
//						k_nr_errori++
//					end if
//					
//				end if
//				k_start = k_pos +  len(k_trova)
//	//--- cerca il carattere separatore  ';' e ' - ' 				
//				k_trova = ";"
//				k_pos = pos(kst_tab_contratti_dp.contratti_des, k_trova, k_start)
//				if k_pos = 0 then
//					k_trova = " - "
//					k_pos=pos(kst_tab_contratti_dp.contratti_des, k_trova, k_start)
//				end if
//			loop
//	
//	//--- c'e' un altro CF senza chiusura del carattere ';' o ' - '
//					k_pos = len(kst_tab_contratti_dp.contratti_des)
//					kst_tab_contratti.sc_cf = trim(mid(kst_tab_contratti_dp.contratti_des, k_start, k_pos - k_start + 1))
//					if len(kst_tab_contratti.sc_cf) > 0 then
//						k_nr_capitolato++
//						if NOT kuf1_contratti.if_esiste_sc_cf(kst_tab_contratti) then
//							k_return = tab_1.tabpage_1.text + ": non Trovato il Capitolato "  + string(k_nr_capitolato) + " cod. " + string(kst_tab_contratti.sc_cf ) + "~n~r" 
//							k_errore = "1"
//							k_nr_errori++
//						end if
//					end if
//
//				
//				catch (uo_exception kuo_exception)
//					kst_esito = kuo_exception.get_st_esito()
//					k_return = tab_1.tabpage_1.text + ": errore durante lettura Capitolato " + string(kst_tab_contratti.sc_cf ) &
//									+ " err=" + string(kst_esito.sqlcode) + " - " + trim(kst_esito.sqlerrtext) + "~n~r" 
//					k_errore = "1"
//					k_nr_errori++
				
				finally 
//					destroy kuf1_contratti
				end try


return k_return 

end function

private function long u_conv_conferma_ordine_to_listino (ref datastore kds_contratti_dp, st_tab_contratti kst_tab_contratti, st_contratti_dp_to_listini kst_contratti_dp_to_listini) throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- Alimenta tabella Listini da una Conferma Ordine (CO) 
//---
//--- inp:  datastore del contratti_dp (d_contratti_dp)
//---                             ,kst_tab_contratti completamente riempito
//---                             ,st_contratti_dp_to_listini x sapere se simulazione ecc... o meno
//--- out: -
//--- ritorna: id (codice) del LISTINO caricato
//--- lancia Exception: uo_exception x errore grave
//---
//---
//---------------------------------------------------------------------------------------------------------------------------------------------------
//
long k_return = 0
long k_riga
int k_nr_listini_da_add=0, k_nr_listini_add=0
st_tab_base kst_tab_base 
st_tab_listino kst_tab_listino
st_tab_listino_prezzi kst_tab_listino_prezzi
st_esito kst_esito
st_tab_g_0 kst_tab_g_0
kuf_listino kuf1_listino
kuf_listino_link_pregruppi kuf1_listino_link_pregruppi
kuf_listino_prezzi kuf1_listino_prezzi
kuf_base kuf1_base
datastore kds_listino_link_pregruppi, kds_contratti_dp_listino_prezzi


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kGuo_exception.set_esito(kst_esito) 

	kuf1_listino = create kuf_listino
	kuf1_base = create kuf_base

	if len(trim(kst_tab_contratti.mc_co)) > 0 then

//--- prezzi nella tabella listino_link_pregruppi
		kst_tab_listino.attiva_listino_pregruppi = kuf1_listino.kki_attiva_listino_pregruppi_si
		
		kst_tab_listino.prezzo = 0
	
//--- imposta il flag ATTIVO		
		if kst_contratti_dp_to_listini.k_subito_in_vigore = "S" then
			kst_tab_listino.attivo = kuf1_listino.kki_attivo_si
		else
			kst_tab_listino.attivo = kuf1_listino.kki_attivo_da_fare
		end if

		kst_tab_listino.magazzino =  kds_contratti_dp.getitemnumber(1,"magazzino")
		if isnull(kst_tab_listino.magazzino) then
			kst_tab_listino.magazzino = 0
		end if
		kst_tab_listino.peso_kg = kds_contratti_dp.getitemnumber(1,"peso_max_kg")
		if isnull(kst_tab_listino.peso_kg) then
			kst_tab_listino.peso_kg = 0
		end if

//--- riempio i dati del Listino da quelli dei Contratti 
		kst_tab_listino.contratto = kst_tab_contratti.codice
		kst_tab_listino.contratto_co_data_ins = kGuf_data_base.prendi_dataora( )
		kst_tab_listino.id_contratto_co = 0 //kds_contratti_dp.getitemnumber(1,"contratti_dp_id_contratto_dp")
		kst_tab_listino.cod_art = kds_contratti_dp.getitemstring(1,"art")
		kst_tab_listino.cod_cli = kds_contratti_dp.getitemnumber(1,"id_cliente")
		
		
		kst_tab_listino.tipo = kuf1_listino.kki_tipo_prezzo_a_collo

//--- Niente Occupazione Pedana
		kst_tab_listino.occup_ped = 0
//--- Niente dati di LISTINO dal SL_PT
		kst_tab_listino.dose =  0
//		kst_tab_listino.mis_x = 0
//		kst_tab_listino.mis_y = 0
//		kst_tab_listino.mis_z = 0
		kst_tab_listino.mis_x = kds_contratti_dp.getitemnumber(1,"mis_x_1")
		kst_tab_listino.mis_y = kds_contratti_dp.getitemnumber(1,"mis_y_1")
		kst_tab_listino.mis_z = kds_contratti_dp.getitemnumber(1,"mis_z_1")
//--- imposta altri valori di default
		kst_tab_listino.id = 0
		kst_tab_listino.campione ="N"
		kst_tab_listino.m_cubi_f = 0
		kst_tab_listino.travaso = "N"

//--- ADD dei dati nel LISTINO
		if kst_contratti_dp_to_listini.k_simulazione <> "S" then
			kst_tab_listino.st_tab_g_0.esegui_commit = "N"
			kst_tab_listino.id = kuf1_listino.tb_add(kst_tab_listino)
			k_return = kst_tab_listino.id
		end if

//--- Aggiunge i Legame tra Listino e Voce 
		kuf1_listino_link_pregruppi = create kuf_listino_link_pregruppi
		kds_listino_link_pregruppi = create datastore
		kds_listino_link_pregruppi.dataobject = "ds_listino_link_pregruppi"
		kds_listino_link_pregruppi.settransobject( kguo_sqlca_db_magazzino )
		kds_listino_link_pregruppi.insertrow(0)
		kds_listino_link_pregruppi.setitem(1, "id_listino", kst_tab_listino.id)
		kds_listino_link_pregruppi.setitem(1, "id_listino_pregruppo", kds_contratti_dp.getitemnumber(1,"id_listino_pregruppo"))
		kst_tab_g_0 = kst_tab_listino.st_tab_g_0
		kuf1_listino_link_pregruppi.tb_add(kds_listino_link_pregruppi, kst_tab_g_0)

//--- Aggiunge i Prezzi delle Voci al Listino
		kuf1_listino_prezzi = create kuf_listino_prezzi
		kds_contratti_dp_listino_prezzi = create datastore
		kds_contratti_dp_listino_prezzi.dataobject = "ds_contratti_dp_listino_prezzi"
		kds_contratti_dp_listino_prezzi.settransobject( kguo_sqlca_db_magazzino )
		kds_contratti_dp_listino_prezzi.retrieve(kst_tab_contratti.id_contratto_dp )
		for k_riga = 1 to kds_contratti_dp_listino_prezzi.rowcount( )
			
			kst_tab_listino_prezzi.st_tab_g_0 = kst_tab_listino.st_tab_g_0
			kst_tab_listino_prezzi.id_listino_link_pregruppo = kds_listino_link_pregruppi.getitemnumber(1,"id_listino_link_pregruppo")
//			kst_tab_listino_prezzi.id_listino_pregruppo = kds_contratti_dp.getitemnumber(1,"id_listino_pregruppo")
			kst_tab_listino_prezzi.id_listino_voce = kds_contratti_dp_listino_prezzi.getitemnumber(k_riga,"id_listino_voce")
			kst_tab_listino_prezzi.prezzo = kds_contratti_dp_listino_prezzi.getitemnumber(k_riga,"prezzo")
			kst_tab_listino_prezzi.attivo = kuf1_listino_prezzi.kki_attivo_si
			
			if kst_tab_listino_prezzi.id_listino_voce > 0 then
				kuf1_listino_prezzi.tb_add(kst_tab_listino_prezzi)
			end if
			
		end for
	
	end if

catch (uo_exception kuo_exception)	
//--- aggiunge riga al log
	throw kuo_exception
	
	
finally 
	destroy kuf1_listino
	destroy kuf1_base	

end try

return k_return

end function

private function st_esito set_stato (ref st_tab_contratti_dp kst_tab_contratti_dp);//
//====================================================================
//=== Set del flag STATO
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
st_tab_contratti_dp kst_tab_contratti_dp_attuale
boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = get_id_programma (kst_open_w.flag_modalita) //kkg_id_programma_contratti_dp

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Modifica Stato del 'Contratto Conto Deposito' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else
	
	try

		if kst_tab_contratti_dp.id_contratto_dp >= 0 then
	
			
			kst_tab_contratti_dp.x_datins = kGuf_data_base.prendi_x_datins()
			kst_tab_contratti_dp.x_utente = kGuf_data_base.prendi_x_utente()
	

//--- piglia lo stato attuale	
			kst_tab_contratti_dp_attuale = kst_tab_contratti_dp
			get_stato(kst_tab_contratti_dp_attuale)

		
			if len(trim(kst_tab_contratti_dp_attuale.stato)) > 0 then
			else
//--- se nulla forza a 'NUOVO' (il livello più basso)
				kst_tab_contratti_dp_attuale.stato = kki_STATO_nuovo
			end if
		
//--- Imposta lo STATO solo x metterlo a livello superiore MAI inferiore ad eccezione di RIAPERTO
			if kst_tab_contratti_dp.stato > kst_tab_contratti_dp_attuale.stato then

//--- setta lo STATO
				update contratti_dp
						 set stato = :kst_tab_contratti_dp.stato
						 ,x_datins = :kst_tab_contratti_dp.x_datins
						 ,x_utente = :kst_tab_contratti_dp.x_utente
						where id_contratto_dp = :kst_tab_contratti_dp.id_contratto_dp
						using sqlca;
	
			
				if sqlca.sqlcode < 0 then
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.SQLErrText = "Modifica Stato del 'Contratto Conto Deposito'  (contratti_dp):" + trim(sqlca.SQLErrText)
					kst_esito.esito = kkg_esito.db_ko
				end if
			else
				kst_esito.esito = kkg_esito.no_esecuzione
			end if
		
		else
			kst_esito.esito = kkg_esito.no_esecuzione
		end if
		
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		
		
	finally
//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_contratti_dp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_dp.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_contratti_dp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_dp.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if

	
		
	end try
	
end if


return kst_esito

end function

public function st_esito set_trasferito (st_tab_contratti_dp kst_tab_contratti_dp);//
//====================================================================
//=== Imposta il flag stato a Convertito in CO e Listino in tabella contratti_dp 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_tab_contratti_dp.stato = kki_stato_trasferito

kst_esito = set_stato(kst_tab_contratti_dp) 

return kst_esito

end function

private function st_esito set_ts_esito_operazione (ref st_tab_contratti_dp kst_tab_contratti_dp);//
//====================================================================
//=== Set del flag il TimeStamp dell'esito del trasferimento a listino colonna: TS_ESITO_OPERAZIONE
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = get_id_programma (kst_open_w.flag_modalita) //kkg_id_programma_contratti_dp

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Modifica 'data e ora esito' nel 'Contratto Conto Deposito' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_contratti_dp.id_contratto_dp > 0 then

		kst_tab_contratti_dp.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_contratti_dp.x_utente = kGuf_data_base.prendi_x_utente()

		update contratti_dp
		    set esito_operazioni_ts_operazione = :kst_tab_contratti_dp.esito_operazioni_ts_operazione
				 ,x_datins = :kst_tab_contratti_dp.x_datins
				 ,x_utente = :kst_tab_contratti_dp.x_utente
			where id_contratto_dp = :kst_tab_contratti_dp.id_contratto_dp
			using sqlca;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Modifica 'data e ora esito operazione'  del 'Contratto Conto Deposito'  (contratti_dp):" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		
		else
	
//---- COMMIT....	
			if kst_esito.esito = kkg_esito.db_ko then
				if kst_tab_contratti_dp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_dp.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_rollback_1( )
				end if
			else
				if kst_tab_contratti_dp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_dp.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_commit_1( )
				end if
			end if
		end if
	end if
end if


return kst_esito

end function

public subroutine log_destroy ();//
if isvalid(kiuf_esito_operazioni) then destroy kiuf_esito_operazioni


 
end subroutine

public subroutine log_inizializza () throws uo_exception;//
//--- inizializza il log delle operazioni	
	if not isvalid(kiuf_esito_operazioni) then kiuf_esito_operazioni = create kuf_esito_operazioni

	kiuf_esito_operazioni.inizializza( kiuf_esito_operazioni.kki_tipo_operazione_dpco_to_listino)


 
end subroutine

public function st_esito get_id_cliente (ref st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna il Codice Cliente da id_contratto_dp 
//--- 
//--- 
//--- Input: st_tab_contratti_dp.id_contratto_dp
//--- Out: st_tab_contratti_dp.id_cliente
//---
//--- Ritorna tab. ST_ESITO, Esiti:   Vedi standard
//---
//----------------------------------------------------------------------------------------------------------------
//
string k_return = "0 "
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()



	SELECT
				contratti_dp.id_cliente
			into
		         :kst_tab_contratti_dp.id_cliente  
			 FROM contratti_dp  
			 where 
						(id_contratto_dp  = :kst_tab_contratti_dp.id_contratto_dp)					     
				 using sqlca;
		
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante Lettura Contratto Conto Deposito (contratti_dp) id_contratto_dp = " + string(kst_tab_contratti_dp.id_contratto_dp) + " " &
						 + "~n~r" + trim(SQLCA.SQLErrText)
									 
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
	

return kst_esito


end function

public function boolean set_id_docprod (st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------
//--- Imposta a id_docprod del Documento Esportato in Tabella contratti_dp
//--- 
//--- 
//--- Inp: st_tab_contratti_dp.id_contratto_dp  e  id_docprod
//--- Out:        
//--- Ritorna: TRUE = OK
//---           		
//--- Lancia EXCEPTION x errore
//--- 
//---------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito

	

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
	
if kst_tab_contratti_dp.id_contratto_dp > 0 then

	kst_tab_contratti_dp.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_contratti_dp.x_utente = kGuf_data_base.prendi_x_utente()

	UPDATE contratti_dp  
		  SET id_docprod = :kst_tab_contratti_dp.id_docprod
			,x_datins = :kst_tab_contratti_dp.x_datins
			,x_utente = :kst_tab_contratti_dp.x_utente
		WHERE contratti_dp.id_contratto_dp = :kst_tab_contratti_dp.id_contratto_dp
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiorn. 'id Documenti Esportati' sulla tab. Contratti Commerciali. ~n~r" &
					+ "Id: " + string(kst_tab_contratti_dp.id_contratto_dp, "####0") + "  " &
					+ " ~n~rErrore-tab.contratti_dp:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_contratti_dp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_dp.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	else
		if kst_tab_contratti_dp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_dp.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	end if

else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore aggiornamento tab. Contratti Commerciali, Manca Identificativo (id_contratto_dp) !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	

if kst_esito.esito = kkg_esito.err_logico or 	kst_esito.esito = kkg_esito.db_ko then
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

k_return = true

return k_return

end function

public function boolean get_form_di_stampa (ref st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------------------
//--- 
//--- Legge il nome del Dataobject (datawindow) da contratti_dp ad esempio: "d_contratti_dp_stampa_2006"
//--- 
//--- 
//--- Input: st_tab_contratti_dp.id_contratto_dp
//--- Out: id, data_stampa, form_di_stampa
//---
//--- Ritorna true = ok
//---
//--- Lancia EXCEPTION x errore
//---
//----------------------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	select data_stampa, form_di_stampa
	  into :kst_tab_contratti_dp.data_stampa, :kst_tab_contratti_dp.form_di_stampa 
	  from contratti_dp 
	  where id_contratto_dp = :kst_tab_contratti_dp.id_contratto_dp  
	  using sqlca;
	

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Recupero nome Form di stampa Contratto Conto Deposito (tab. contratti_dp id=" + string(kst_tab_contratti_dp.id_contratto_dp) + " " + "): " + trim(SQLCA.SQLErrText)
									 
		kst_esito.esito = kkg_esito.db_ko
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)		
		throw kguo_exception
		
	end if
	
	if len(trim(kst_tab_contratti_dp.form_di_stampa)) > 0 then
	else
		kst_tab_contratti_dp.form_di_stampa = kki_form_di_stampa_attuale
//		kst_tab_contratti_dp.form_di_stampa = ""
	end if
	if isnull(kst_tab_contratti_dp.data_stampa) then
		kst_tab_contratti_dp.data_stampa = KKG.DATA_ZERO
	end if
	
	k_return = true 

return k_return


end function

public function long aggiorna_docprod (ref st_tab_contratti_dp kst_tab_contratti_dp[]) throws uo_exception;//
//--- Aggiorna righe tabelle DOCPROD
//---
//--- input:  array st_tab_contratti_dp con l'elenco dei documenti da aggiornare
//--- out: Numero documenti caricati
//---
//--- Lancia EXCEPTION
//---
long k_return = 0
long k_riga_contratti_dp=0, k_nr_contratti_dp=0, k_nr_doc=0
st_esito kst_esito
st_tab_docprod kst_tab_docprod
kuf_docprod kuf1_docprod


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	k_nr_contratti_dp = upperbound(kst_tab_contratti_dp[])

	if k_nr_contratti_dp > 0 then
		
		
//--- Crea Documenti da Esportare (DOCPROD)
		kuf1_docprod = create kuf_docprod

		for k_riga_contratti_dp = 1 to k_nr_contratti_dp

			try

				if kst_tab_contratti_dp[k_riga_contratti_dp].id_contratto_dp > 0 then
	
					get_offerta_data(kst_tab_contratti_dp[k_riga_contratti_dp])
					kst_tab_docprod.doc_num = kst_tab_contratti_dp[k_riga_contratti_dp].id_contratto_dp
					kst_tab_docprod.doc_data = kst_tab_contratti_dp[k_riga_contratti_dp].offerta_data
					kst_tab_docprod.id_doc = kst_tab_contratti_dp[k_riga_contratti_dp].id_contratto_dp
					
					
					kst_esito = get_id_cliente(kst_tab_contratti_dp[k_riga_contratti_dp])
					if kst_esito.esito = kkg_esito.db_ko then
						if isvalid(kuf1_docprod) then destroy kuf1_docprod
						kguo_exception.inizializza( )
						kguo_exception.set_esito(kst_esito)
						throw kguo_exception
					end if
					
					kst_tab_docprod.id_cliente = kst_tab_contratti_dp[k_riga_contratti_dp].id_cliente
					
					kst_tab_docprod.st_tab_g_0.esegui_commit = kst_tab_contratti_dp[1].st_tab_g_0.esegui_commit 
	
//					kuf1_docprod.tb_add_contratti_dp ( kst_tab_docprod ) // AGGIUNGE IN DOCPROD
					k_nr_doc++
					
				end if		

			catch (uo_exception kuo1_exception)
				throw kuo1_exception
				
			end try
			
		next
	
		if isvalid(kuf1_docprod) then destroy kuf1_docprod
	
		if k_nr_doc > 0 then
			k_return = k_nr_doc
		end if
	
	end if


return k_return

end function

public function st_esito get_offerta_data (ref st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna Data dell'Offerta da Contratto CO 
//--- 
//--- 
//--- Input: st_tab_contratti_dp.id_contratto_dp
//--- Out: st_tab_contratti_dp.offerta_data
//---
//--- Ritorna tab. ST_ESITO, Esiti:   Vedi standard
//---
//----------------------------------------------------------------------------------------------------------------
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()



	SELECT
				contratti_dp.offerta_data
			into
		         :kst_tab_contratti_dp.offerta_data  
			 FROM contratti_dp  
			 where 
						(id_contratto_dp  = :kst_tab_contratti_dp.id_contratto_dp)					     
				 using sqlca;
		
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante Lettura 'Data Offerta' nel Contratto Conto Deposito (contratti_dp) id_contratto_dp = " + string(kst_tab_contratti_dp.id_contratto_dp) + " " &
						 + "): " + trim(SQLCA.SQLErrText)
									 
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
	

return kst_esito


end function

public function long stampa_esporta_digitale (st_docprod_esporta kst_docprod_esporta) throws uo_exception;//---
//---  Esporta in digitale (pdf) i CONTRATTI
//---
boolean k_sicurezza
int k_item_doc, k_rc, k_n_documenti_stampati, k_id_stampa
string k_path_risorse="", k_rcx="", k_esito="", k_stampante_pdf=""
//long k_rc, k_riga
datastore kds_print
st_tab_contratti_dp kst_tab_contratti_dp
st_open_w kst_open_w
st_esito kst_esito, kst_esito_armo
st_profilestring_ini kst_profilestring_ini
kuf_sicurezza kuf1_sicurezza
kuf_base kuf1_base



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.stampa) //kkg_id_programma_contratti_dp

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_sicurezza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa Documento non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut
	
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception

end if
	
try

//--- Piglio il nome della stampante PDF
	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base( "stamp_pdf")
	if left(k_esito,1) <> "0" then
		k_stampante_pdf = ""
	else
		k_stampante_pdf	= trim(mid(k_esito,2))
	end if
	destroy kuf1_base

//--- OK finalmente inizio a lavorare -----------------------------------------------------------------------------

//--- se oggetto dw Contratto NON ancora definito  
      if not isvalid(kds_print) then
         kds_print = create datastore
      end if

      for k_item_doc = 1 to upperbound(kst_docprod_esporta.kst_tab_docprod[])

         kst_tab_contratti_dp.id_contratto_dp = kst_docprod_esporta.kst_tab_docprod[k_item_doc].id_doc
         if kst_tab_contratti_dp.id_contratto_dp > 0 then
         
			if if_esiste(kst_tab_contratti_dp) then   // esiste il documento?
			
//--- Popola area dell'Contratto sul quale sto lavorando
				kst_tab_contratti_dp.id_contratto_dp = kst_docprod_esporta.kst_tab_docprod[k_item_doc].doc_num
				kst_tab_contratti_dp.offerta_data = kst_docprod_esporta.kst_tab_docprod[k_item_doc].doc_data
				kst_tab_contratti_dp.id_cliente = kst_docprod_esporta.kst_tab_docprod[k_item_doc].id_cliente

   //--- Ricavo il nome del form se Documento gia' stampato
				kst_tab_contratti_dp.data_stampa = KKG.DATA_ZERO 
				get_form_di_stampa(kst_tab_contratti_dp)
         
   
   //--- popola il DS con l'Contratto da stampare
				kds_print = create datastore
			
				if len(trim(kst_tab_contratti_dp.form_di_stampa)) > 0 then  //--- se sono in ristampa allora riprendo il form originale
					kds_print.dataobject = trim(kst_tab_contratti_dp.form_di_stampa) 
				else
					kds_print.dataobject = kki_form_di_stampa_attuale
				end if
//--- Imposta  Risorse Grafiche
				if len(trim(kGuo_path.get_risorse())) > 0 then
					k_rcx=kds_print.Modify("p_img.Filename='" + kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img.text"))+ "'") 
					k_rcx=kds_print.Modify("p_img_0.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img_0.text")) + "'")  
					k_rcx=kds_print.Modify("p_img_1.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img_1.text")) + "'") 
					k_rcx=kds_print.Modify("p_img_2.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img_2.text")) + "'") 
				end if
	
				kds_print.settransobject(sqlca)
   
//--- retrive dell'Contratto 
				k_rc=kds_print.retrieve(  kst_tab_contratti_dp.id_contratto_dp )
   
   
//--- Controllo se manca il percorso
				if len(trim( kst_docprod_esporta.path[k_item_doc])) > 0 then 
				
					k_n_documenti_stampati ++

//=== Crea il PDF
//					kds_print.Object.DataWindow.Export.PDF.Method = Distill!
//					kds_print.Object.DataWindow.Printer = k_stampante_pdf   
//					kds_print.Object.DataWindow.Export.PDF.Distill.CustomPostScript="1"
					kds_print.object.DataWindow.Export.PDF.Method = NativePDF!
					k_id_stampa = kds_print.saveas(trim( kst_docprod_esporta.path[k_item_doc]),PDF!, false)   //
				
					if k_id_stampa < 1 then
						
						kst_esito.sqlcode = 0
						kst_esito.SQLErrText = "Contratto digitale su: '" + k_stampante_pdf + "' non generato: ~n~r"  &
																	 + "Documento: " + trim(kst_docprod_esporta.path[k_item_doc]) + " ~n~r" &
																	 + "Funzione fallita per errore: " + string(k_id_stampa)
						kst_esito.esito = kkg_esito.no_esecuzione
						kguo_exception.set_esito(kst_esito)
						throw kguo_exception

					end if

//--- Aggiorna tab      
					kst_tab_contratti_dp.id_contratto_dp = kst_docprod_esporta.kst_tab_docprod[k_item_doc].id_doc
					kst_tab_contratti_dp.id_docprod = kst_docprod_esporta.kst_tab_docprod[k_item_doc].id_docprod
					set_id_docprod(kst_tab_contratti_dp)
				
				end if
			end if      
         end if

	end for
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
	
end try


return k_n_documenti_stampati      

end function

public function boolean if_esiste (st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla esistenza Contratto Conto Deposito da id_contratto_dp
//--- 
//--- 
//--- Inp: st_tab_contratti_dp.id
//--- Out: TRUE = esiste
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
long k_trovato=0
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()


//--- x numero contratti_dpicato			
	SELECT count(*)
			into :k_trovato
			 FROM contratti_dp  
			 where  id_contratto_dp  = :kst_tab_contratti_dp.id_contratto_dp
			 using sqlca;
		
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura Contratto Conto Deposito (contratti_dp) id = " + string(kst_tab_contratti_dp.id_contratto_dp) + " " &
						 + "~n~rErrore: " + trim(SQLCA.SQLErrText)
									 
		kst_esito.esito = kkg_esito.db_ko
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		if k_trovato > 0 then k_return = true
	end if
	

return k_return



end function

private function boolean set_form_di_stampa (readonly st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------
//--- Set del campo FORM_DI_STAMPA
//--- 
//--- Inp: st_tab_contratti_dp.id_contratto_dp
//--- Out:
//--- 
//--- Ritorna TRUE = OK
//---           	
//---  Lancia EXCEPTION
//---           	
//--------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = get_id_programma (kst_open_w.flag_modalita) //kkg_id_programma_contratti_dp

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa del 'Contratto Conto Deposito' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_contratti_dp.id_contratto_dp > 0 then

		
		kst_tab_contratti_dp.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_contratti_dp.x_utente = kGuf_data_base.prendi_x_utente()
	

		update contratti_dp
		    set form_di_stampa = :kst_tab_contratti_dp.form_di_stampa
			 ,x_datins = :kst_tab_contratti_dp.x_datins
			 ,x_utente = :kst_tab_contratti_dp.x_utente
			where id_contratto_dp = :kst_tab_contratti_dp.id_contratto_dp
			using sqlca;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Aggiorna Lay-Out di stampa del 'Contratto Conto Deposito'  (contratti_dp):" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		end if
	
//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_contratti_dp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_dp.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_contratti_dp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_dp.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if

		if kst_esito.esito = kkg_esito.db_ko then
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito )
			throw kguo_exception
			
		else
			
			if kst_esito.esito = kkg_esito.ok then
				k_return = true
			end if
			
		end if

	end if
end if


return k_return


end function

public function boolean get_stato (ref st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------------------
//--- 
//--- Legge lo STATO
//--- 
//--- 
//--- Input: st_tab_contratti_dp.id_contratto_dp
//--- Out: stato
//---
//--- Ritorna true = ok
//---
//--- Lancia EXCEPTION x errore
//---
//----------------------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	select stato
	  into :kst_tab_contratti_dp.stato
	  from contratti_dp 
	  where id_contratto_dp = :kst_tab_contratti_dp.id_contratto_dp  
	  using sqlca;
	

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Legge lo Stato del Contratto Conto Deposito (tab. contratti_dp id=" + string(kst_tab_contratti_dp.id_contratto_dp) + " " + "): " + trim(SQLCA.SQLErrText)
									 
		kst_esito.esito = kkg_esito.db_ko
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)		
		throw kguo_exception
		
	end if
	
	if len(trim(kst_tab_contratti_dp.stato)) > 0 then
	else
		kst_tab_contratti_dp.stato = kki_STATO_nuovo
	end if
	
	k_return = true 

return k_return


end function

private function boolean set_data_stampa (readonly st_tab_contratti_dp kst_tab_contratti_dp) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------
//--- Set del campo DATA_STAMPA (di solito in concomitanza con il cambio di STATO)
//--- 
//--- Inp: st_tab_contratti_dp.id_contratto_dp
//--- Out:
//--- 
//--- Ritorna TRUE = OK
//---           	
//---  Lancia EXCEPTION
//---           	
//--------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = get_id_programma (kst_open_w.flag_modalita) //kkg_id_programma_contratti_dp

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa del 'Contratto Conto Deposito' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_contratti_dp.id_contratto_dp > 0 then

		
		kst_tab_contratti_dp.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_contratti_dp.x_utente = kGuf_data_base.prendi_x_utente()
	

		update contratti_dp
		    set data_stampa = :kst_tab_contratti_dp.data_stampa
			 ,x_datins = :kst_tab_contratti_dp.x_datins
			 ,x_utente = :kst_tab_contratti_dp.x_utente
			where id_contratto_dp = :kst_tab_contratti_dp.id_contratto_dp
			using sqlca;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Aggiorna Lay-Out di stampa del 'Contratto Conto Deposito'  (contratti_dp):" + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
	
//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_contratti_dp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_dp.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_contratti_dp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_dp.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if

		if kst_esito.esito = kkg_esito.db_ko then
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito )
			throw kguo_exception
			
		else
			
			if kst_esito.esito = kkg_esito.ok then
				k_return = true
			end if
			
		end if
		
	else
		kst_esito.esito = kkg_esito.no_esecuzione
	end if
end if


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
long k_nr_righe, k_ctr
int k_riga
string k_tipo_errore="0"
st_tab_contratti_dp kst_tab_contratti_dp
st_tab_gru kst_tab_gru
st_tab_prodotti kst_tab_prodotti
st_tab_listino_pregruppi_voci kst_tab_listino_pregruppi_voci
st_esito kst_esito, kst_esito1
kuf_ausiliari kuf1_ausiliari
kuf_prodotti kuf1_prodotti
kuf_listino_pregruppi_voci kuf1_listino_pregruppi_voci


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
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

	do while k_riga > 0  and k_errori < 10

	
//--- controllo se sono stati caricati Contratti nell'anno x lo stesso cliente		
		if ki_flag_modalita = kkg_flag_modalita.inserimento then
			kst_tab_contratti_dp.id_cliente = ads_inp.getitemnumber(1, "id_cliente")
			kst_tab_contratti_dp.anno = ads_inp.getitemnumber(1, "anno")
			kst_esito = get_ultimo_cliente_anno(kst_tab_contratti_dp)
			if kst_esito.esito = kkg_esito.ok then
				if kst_tab_contratti_dp.id_contratto_dp > 0 then
					k_errori ++
					k_tipo_errore=kkg_esito.DATI_WRN      
					ads_inp.modify("id_cliente.tag = '" + k_tipo_errore + "' ")
					kst_esito.esito = kkg_esito.DATI_WRN
					kst_esito.sqlerrtext =  ": il cliente ha già altri Contratti, es il n. " + string(kst_tab_contratti_dp.id_contratto_dp ) &
												+ " del " + string(kst_tab_contratti_dp.offerta_data, "dd/mm/yyyy" ) + "~n~r" 
				end if
			end if
		end if
		if k_tipo_errore = "4" or k_tipo_errore = kkg_esito.DATI_WRN or k_tipo_errore = "0" then 
//--- check presenza del cod articolo
			kst_tab_contratti_dp.art = ads_inp.getitemstring(1, "art")
			if len(trim(kst_tab_contratti_dp.art)) = 0 or isnull(kst_tab_contratti_dp.art )  then
				k_errori++
				k_tipo_errore = "4"
				kst_esito.esito = kkg_esito.DATI_INSUFF
				kst_esito.sqlerrtext = "Manca valore nel campo " + trim(ads_inp.describe("art_t.text")) +  "~n~r"  + trim(kst_esito.sqlerrtext)
			end if

//--- warning sul cambio di STATO
			if ads_inp.getitemstring( 1, "stato") = kki_STATO_accettato then
				k_errori++
				k_tipo_errore = kkg_esito.DATI_WRN
				kst_esito.esito = kkg_esito.DATI_WRN
				kst_esito.sqlerrtext = "Lo Stato 'ACCETTATO' rende il documento IMMODIFICABILE, controlla meglio.  "  + trim(kst_esito.sqlerrtext)
			end if
		end if

//--- check se Gruppo coerente con il Settore
		kst_tab_contratti_dp.gruppo = ads_inp.getitemnumber(1, "gruppo")
		kst_tab_contratti_dp.id_clie_settore = ads_inp.getitemstring(1, "id_clie_settore")
		if len(trim(kst_tab_contratti_dp.id_clie_settore)) > 0 and kst_tab_contratti_dp.gruppo > 0 then
			kuf1_ausiliari = create kuf_ausiliari  
			kst_tab_gru.codice = kst_tab_contratti_dp.gruppo 
			kst_esito1 = kuf1_ausiliari.tb_gru_get_id_clie_settore( kst_tab_gru )
			destroy kuf1_ausiliari
			if kst_esito1.esito = kkg_esito.ok then
				if trim(kst_tab_gru.id_clie_settore) <> trim(kst_tab_contratti_dp.id_clie_settore) then
					k_errori++
					k_tipo_errore = "1"
					kst_esito.esito = kkg_esito.ERR_LOGICO
					kst_esito.sqlerrtext = "Settore non coerente con il Gruppo scelto (" + string(kst_tab_contratti_dp.gruppo) + ") ~n~r"   + trim(kst_esito.sqlerrtext)
				end if
			else
				if kst_esito1.esito <> kkg_esito.db_ko then
					k_errori++
					k_tipo_errore = "1"
					kst_esito.esito = kkg_esito.DB_KO
					kst_esito.sqlerrtext =  "Errore durante lettura Gruppo " + string(kst_tab_gru.codice ) &
									+ " err=" + string(kst_esito1.sqlcode) + " - " + trim(kst_esito1.sqlerrtext) + "~n~r"   + trim(kst_esito.sqlerrtext)
				end if
			end if
		end if

//--- check se Gruppo coerente con il Prodotto
		kst_tab_contratti_dp.art = ads_inp.getitemstring(1, "art")
		kst_tab_contratti_dp.gruppo = ads_inp.getitemnumber(1, "gruppo")
		if len(trim(kst_tab_contratti_dp.art)) > 0 and kst_tab_contratti_dp.gruppo > 0 then
			kuf1_prodotti = create kuf_prodotti  
			kst_tab_prodotti.codice = kst_tab_contratti_dp.art 
			kst_esito1 = kuf1_prodotti.get_gruppo( kst_tab_prodotti )
			destroy kuf1_prodotti
			if kst_esito1.esito = kkg_esito.ok then
				if kst_tab_prodotti.gruppo <> kst_tab_contratti_dp.gruppo then
					k_errori++
					k_tipo_errore = "1"
					kst_esito.esito = kkg_esito.ERR_LOGICO
					kst_esito.sqlerrtext = "Gruppo non coerente con l'articolo scelto (" + string(kst_tab_contratti_dp.art) + ") ~n~r"   + trim(kst_esito1.sqlerrtext)  + trim(kst_esito.sqlerrtext)
				end if
			else
				if kst_esito1.esito <> kkg_esito.db_ko then
					k_errori++
					k_tipo_errore = "1"
					kst_esito.esito = kkg_esito.DB_KO
					kst_esito.sqlerrtext = "Errore durante lettura Articolo " + string(kst_tab_prodotti.codice ) &
									+ " err=" + string(kst_esito1.sqlcode) + " - " + trim(kst_esito1.sqlerrtext) + "~n~r"   + trim(kst_esito.sqlerrtext)
				end if
			end if
		end if

		kst_tab_contratti_dp.id_listino_pregruppo = ads_inp.getitemnumber(1, "id_listino_pregruppo")
		if kst_tab_contratti_dp.id_listino_pregruppo > 0  then
		else
			k_errori++
			k_tipo_errore = "3"
			kst_esito.esito = kkg_esito.DATI_INSUFF
			kst_esito.sqlerrtext = "Manca valore nel campo " + trim(ads_inp.describe("b_listino_pregruppo.text")) +  "~n~r"    + trim(kst_esito.sqlerrtext)
		end if

//--- check se Stessa Voce Ripetuta più volte
		for k_ctr = 1 to 8
			kst_tab_contratti_dp.id_listino_voce_1 = ads_inp.getitemnumber(1, "id_listino_voce_" + string(k_ctr))
			if kst_tab_contratti_dp.id_listino_voce_1 > 0 then
				for k_riga = k_ctr+1 to 8
			   		if kst_tab_contratti_dp.id_listino_voce_1 = ads_inp.getitemnumber(1, "id_listino_voce_" + string(k_riga)) then
						k_errori++
						k_tipo_errore = "1"
						kst_esito.esito = kkg_esito.ERR_LOGICO
						kst_esito.sqlerrtext = "La Voce " + string(kst_tab_contratti_dp.id_listino_voce_1 ) &
										+ " duplicata nel campo '" +  trim(ads_inp.describe( "id_listino_voce_" + string(k_riga) +"_t.text"))  + "'.  " + "~n~r" + trim(kst_esito.sqlerrtext)
						k_riga = 9  	//forza uscita
						k_ctr = 9		//forza uscita
					end if
				end for

//--- check se la Voce esiste nel Gruppo Listino indicato		
				if kst_tab_contratti_dp.id_listino_pregruppo > 0 and kst_tab_contratti_dp.id_listino_voce_1 > 0 then
					kuf1_listino_pregruppi_voci = create kuf_listino_pregruppi_voci  
					kst_tab_listino_pregruppi_voci.id_listino_voce = kst_tab_contratti_dp.id_listino_voce_1 
					kst_tab_listino_pregruppi_voci.id_listino_pregruppo = kst_tab_contratti_dp.id_listino_pregruppo 
					kst_esito1 = kuf1_listino_pregruppi_voci.get_id_listino_pregruppo_voce(kst_tab_listino_pregruppi_voci)
					if kst_esito1.esito = KKG_ESITO.not_fnd then
						if k_tipo_errore = "4" or k_tipo_errore = kkg_esito.DATI_WRN or k_tipo_errore = "0" then 
							k_errori++
							k_tipo_errore = "1"
							kst_esito.esito = kkg_esito.DATI_WRN
						end if
						kst_esito.sqlerrtext = "La Voce " + string(kst_tab_contratti_dp.id_listino_voce_1 ) &
											+ " non appartiene al '" + trim(ads_inp.describe("id_listino_pregruppo_t.text")) + " " &
											+ string(kst_tab_listino_pregruppi_voci.id_listino_pregruppo) + " ' indicato." + " - " + trim(kst_esito1.sqlerrtext) + "~n~r"  + trim(kst_esito.sqlerrtext)
					end if
				end if
			end if
		end for


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

on kuf_contratti_dp.create
call super::create
end on

on kuf_contratti_dp.destroy
call super::destroy
end on

event destructor;call super::destructor;//
if isvalid(kiuf_esito_operazioni) then destroy kiuf_esito_operazioni

end event

