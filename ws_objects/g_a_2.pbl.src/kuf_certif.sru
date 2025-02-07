$PBExportHeader$kuf_certif.sru
forward
global type kuf_certif from kuf_parent
end type
end forward

global type kuf_certif from kuf_parent
end type
global kuf_certif kuf_certif

type variables
//
private kuf_certif_print kiuf_certif_print

private datastore kids_certif_tree_stampati_xgiornomeseanno
private kds_certif_tree_stampati_xdata kids_certif_tree_stampati_xdata



end variables

forward prototypes
public subroutine if_isnull (ref st_tab_certif kst_tab_certif)
public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_certif kst_tab_certif)
public function st_esito leggi (integer k_tipo, ref st_tab_certif kst_tab_certif)
public function st_esito tb_delete_x_rif (st_tab_certif kst_tab_certif)
public function st_esito tb_aggiorna (st_tab_certif kst_tab_certif)
public function st_esito tb_add (st_tab_certif kst_tab_certif)
public function st_esito consenti_modifica (st_tab_certif kst_tab_certif)
public function st_esito crea_certif (ref st_tab_certif kst_tab_certif)
public function st_esito anteprima_elenco (datastore kdw_anteprima, st_tab_armo kst_tab_armo)
public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_x_mese (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_certif kst_tab_certif)
public function st_esito get_ultimo_doc_ins (ref st_tab_certif kst_tab_certif)
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function boolean get_form_di_stampa (ref st_tab_certif kst_tab_certif) throws uo_exception
public function boolean set_id_docprod (st_tab_certif kst_tab_certif) throws uo_exception
public function st_esito get_id (ref st_tab_certif kst_tab_certif)
public function boolean if_esiste (readonly st_tab_certif kst_tab_certif) throws uo_exception
public function boolean if_crea_certif (st_tab_certif kst_tab_certif) throws uo_exception
public function st_esito tb_delete (st_tab_certif kst_tab_certif) throws uo_exception
public function long get_id_da_nome (string a_nome_file)
public function long get_num_certif_da_nome (string a_nome_file)
public function long get_id_meca (ref st_tab_certif kst_tab_certif) throws uo_exception
public function integer u_tree_riempi_treeview_x_giorno (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function boolean set_flg_ristampa_xddt (st_tab_certif kst_tab_certif) throws uo_exception
public function boolean set_flg_ristampa_xddt_on (st_tab_certif kst_tab_certif) throws uo_exception
public function boolean set_flg_ristampa_xddt_off (st_tab_certif kst_tab_certif) throws uo_exception
public function boolean if_stampato_x_id_meca (ref st_tab_certif kst_tab_certif) throws uo_exception
private function string get_nome_pdf (ref st_tab_certif ast_tab_certif) throws uo_exception
public function long get_id_da_id_meca (ref st_tab_certif kst_tab_certif) throws uo_exception
public function date get_data (ref st_tab_certif kst_tab_certif) throws uo_exception
public function st_esito get_clie (ref st_tab_certif kst_tab_certif) throws uo_exception
public subroutine u_db_crea_view_certif (string a_view_name, long a_id_meca) throws uo_exception
private function st_esito set_e1_wo_f5537001 (st_tab_certif kst_tab_certif) throws uo_exception
private subroutine crea_certif_set_note (ref st_tab_certif kst_tab_certif) throws uo_exception
private subroutine crea_certif_update (ref st_tab_certif kst_tab_certif) throws uo_exception
public subroutine crea_certif_set_st_tab_certif (ref st_tab_certif kst_tab_certif) throws uo_exception
public function long get_id_meca_da_id (ref st_tab_certif kst_tab_certif) throws uo_exception
public function long get_num_certif (ref st_tab_certif kst_tab_certif) throws uo_exception
public function boolean if_stampato (readonly st_tab_certif ast_tab_certif) throws uo_exception
public function date get_data_stampa (ref st_tab_certif ast_tab_certif) throws uo_exception
private subroutine crea_certif_verifica_dosi (ref st_tab_certif ast_tab_certif, ref kuf_meca_dosim auf1_meca_dosim, readonly st_tab_armo ast_tab_armo) throws uo_exception
private subroutine crea_certif_get_dati_x_st (ref st_tab_certif ast_tab_certif, ref st_tab_meca ast_tab_meca, ref st_tab_armo ast_tab_armo) throws uo_exception
private function st_esito set_e1_wo_f5548014_old (st_tab_certif kst_tab_certif) throws uo_exception
end prototypes

public subroutine if_isnull (ref st_tab_certif kst_tab_certif);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_certif.id) then kst_tab_certif.id = 0
if isnull(kst_tab_certif.num_certif) then kst_tab_certif.num_certif = 0
if isnull(kst_tab_certif.data) then kst_tab_certif.data = date(0)
if isnull(kst_tab_certif.ora) then kst_tab_certif.ora = time(0)
kst_tab_certif.data_ora = datetime(kst_tab_certif.data, kst_tab_certif.ora)
if isnull(kst_tab_certif.id_meca) then kst_tab_certif.id_meca = 0
if isnull(kst_tab_certif.data_stampa) then kst_tab_certif.data_stampa = date(0)
if isnull(kst_tab_certif.ora_stampa) then kst_tab_certif.ora_stampa = time(0)
if isnull(kst_tab_certif.lav_data_ini) then	kst_tab_certif.lav_data_ini = date(0)
if isnull(kst_tab_certif.lav_data_fin) then	kst_tab_certif.lav_data_fin = date(0)
if isnull(kst_tab_certif.colli) then kst_tab_certif.colli = 0
if isnull(kst_tab_certif.dose) then kst_tab_certif.dose = 0
if isnull(kst_tab_certif.dose_max) then kst_tab_certif.dose_max = 0
if isnull(kst_tab_certif.dose_min) then kst_tab_certif.dose_min = 0
if isnull(kst_tab_certif.note) then kst_tab_certif.note = " "
if isnull(kst_tab_certif.note_1) then kst_tab_certif.note_1 = " "
if isnull(kst_tab_certif.note_2) then kst_tab_certif.note_2 = " "
if isnull(kst_tab_certif.st_dose_min) then kst_tab_certif.st_dose_min = "N"
if isnull(kst_tab_certif.st_dose_max) then kst_tab_certif.st_dose_max = "N"
if isnull(kst_tab_certif.st_data_ini) then kst_tab_certif.st_data_ini = "N"
if isnull(kst_tab_certif.st_data_fin) then kst_tab_certif.st_data_fin = "N"
if isnull(kst_tab_certif.id_docprod) then kst_tab_certif.id_docprod = 0



end subroutine

public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_certif kst_tab_certif);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   Vedi standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_tab_certif kst_tab_certif_da
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_attestati

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	try
		if kst_tab_certif.num_certif > 0 then
	
			get_form_di_stampa(kst_tab_certif)
			if len(trim(kst_tab_certif.form_di_stampa)) > 0 then
				kdw_anteprima.dataobject = trim(kst_tab_certif.form_di_stampa)		
				kst_tab_certif_da.num_certif = kst_tab_certif.num_certif 
			else
				kdw_anteprima.dataobject = "d_certif"		
				kst_tab_certif_da.num_certif = 0
			end if
	
			kdw_anteprima.settransobject(sqlca)
	
			kuf1_utility = create kuf_utility
			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_certif_da.num_certif ,  kst_tab_certif.num_certif )
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Attestato da visualizzare: ~n~r" + "nessun numero attestato indicato"
			kst_esito.esito = kkg_esito.db_ko
			
		end if
		
		
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		
	end try
	
end if


return kst_esito

end function

public function st_esito leggi (integer k_tipo, ref st_tab_certif kst_tab_certif);//
//====================================================================
//=== 
//=== Legge Tabella Certificati
//=== 
//=== 
//--- Input: tipo 1=attestato
//=== Ritorna tab. ST_ESITO, Esiti:   Vedi standard
//====================================================================
//
string k_return = "0 "
st_esito kst_esito



	kst_esito = kguo_exception.inizializza(this.classname())

	choose case k_tipo

//--- x numero certificato			
//--- o x id meca			
		case 1

			SELECT certif.id,   
					certif.num_certif,   
					certif.id_meca,   
					certif.data,   
					certif.data_stampa,   
					certif.clie_2,   
					certif.colli,   
					certif.dose,   
					certif.dose_min,   
					certif.dose_max,   
					certif.lav_data_ini,   
					certif.lav_data_fin,   
					certif.note,   
					certif.note_1,   
					certif.note_2,   
					certif.x_datins,   
					certif.x_utente  
				into
               :kst_tab_certif.id,   
		         :kst_tab_certif.num_certif,   
		         :kst_tab_certif.id_meca,   
		         :kst_tab_certif.data,   
		         :kst_tab_certif.data_stampa,   
		         :kst_tab_certif.clie_2,   
		         :kst_tab_certif.colli,   
		         :kst_tab_certif.dose,   
		         :kst_tab_certif.dose_min,   
		         :kst_tab_certif.dose_max,   
		         :kst_tab_certif.lav_data_ini,   
		         :kst_tab_certif.lav_data_fin,   
		         :kst_tab_certif.note,   
		         :kst_tab_certif.note_1,   
		         :kst_tab_certif.note_2,   
		         :kst_tab_certif.x_datins,   
		         :kst_tab_certif.x_utente  
			 FROM certif  
			 where 
						(:kst_tab_certif.num_certif > 0 
						 and certif.num_certif = :kst_tab_certif.num_certif)					     
						or (:kst_tab_certif.id_meca > 0 
						 and certif.id_meca = :kst_tab_certif.id_meca)
				 using sqlca;
		
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab.Attestati CERTIF (Numero=" &
								 + string(kst_tab_certif.num_certif) + " " &
								 + "): " + trim(SQLCA.SQLErrText)
											 
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

//--- Tipo????
		case else
			kst_esito.esito = kkg_esito.bug
			kst_esito.sqlcode = 999
			kst_esito.SQLErrText = &
			    "Tab.Attestati CERTIF tipo ricarca non riconosciuto ("&
			    + string(k_tipo) + ") "

	end choose


return kst_esito


end function

public function st_esito tb_delete_x_rif (st_tab_certif kst_tab_certif);//
//====================================================================
//=== Cancella il rek dalla tabella ATTESTATI
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   Vedi standard 
//=== 
//====================================================================
boolean k_autorizza
integer k_sn=0
int k_rek_ok=0
long k_id
st_tab_artr kst_tab_artr
st_esito kst_esito, kst_esito_1
st_open_w kst_open_w
kuf_artr kuf1_artr
kuf_sicurezza kuf1_sicurezza


kst_esito = kguo_exception.inizializza(this.classname())

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = kkg_id_programma_attestati

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione Attestato non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	select distinct num_certif
	   into :kst_tab_certif.num_certif
		from certif
		where id_meca = :kst_tab_certif.id_meca  
		using sqlca;
		
	if sqlca.sqlcode = 0 then

		delete from certif
			where id_meca = :kst_tab_certif.id_meca  
			using sqlca;
	
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Cancellazione Attestato (certif) " &
						 + "~n~rErrore: " + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			if kst_tab_certif.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_certif.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			
		else

//--- Commit
			if kst_tab_certif.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_certif.st_tab_g_0.esegui_commit) then
				kst_esito = kguo_sqlca_db_magazzino.db_commit()
			end if
			
			kst_tab_artr.num_certif = kst_tab_certif.num_certif
			kst_tab_artr.data_st = date(0)
			kuf1_artr = create kuf_artr
			kst_tab_artr.st_tab_g_0.esegui_commit = "S" //"N" x temporaltable
			kst_esito_1=kuf1_artr.aggiorna_data_stampa_attestato(kst_tab_artr)
			destroy kuf1_artr 
			
			if kst_esito_1.sqlcode < 0 then
				kst_esito = kst_esito_1
				
				if kst_tab_certif.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_certif.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
				
			else
				kst_esito.esito = kkg_esito.ok
				if kst_tab_certif.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_certif.st_tab_g_0.esegui_commit) then
					kst_esito = kguo_sqlca_db_magazzino.db_commit()
				end if
			end if
				
		end if
		
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Ricerca e Cancellazione Attestato (certif):" + trim(sqlca.SQLErrText)
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

end if

return kst_esito

end function

public function st_esito tb_aggiorna (st_tab_certif kst_tab_certif);//
//====================================================================
//=== Aggiorna il rek nella tabella ATTESTATI
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:     Vedi standard 
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
long k_id
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	kst_tab_certif.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_certif.x_utente = kGuf_data_base.prendi_x_utente()

	update certif  
			  set id_meca = :kst_tab_certif.id_meca
			  ,data = :kst_tab_certif.DATA
			  ,ora = :kst_tab_certif.ORA
			  ,clie_2 = :kst_tab_certif.CLIE_2
			  ,colli = :kst_tab_certif.colli   
			  ,dose = :kst_tab_certif.DOSE
			  ,lav_data_ini = :kst_tab_certif.lav_data_ini   
			  ,lav_data_fin = :kst_tab_certif.lav_data_fin   
			  ,note = :kst_tab_certif.note 
			  ,note_1 = :kst_tab_certif.note_1   
			  ,note_2 = :kst_tab_certif.note_2
			  ,st_dose_min = :kst_tab_certif.st_dose_min
			  ,st_dose_max = :kst_tab_certif.st_dose_max
			  ,st_data_ini = :kst_tab_certif.st_data_ini
			  ,st_data_fin = :kst_tab_certif.st_data_fin
			  ,st_dati_bolla_in = :kst_tab_certif.st_dati_bolla_in
			  ,x_datins = :kst_tab_certif.x_datins
			  ,x_utente = :kst_tab_certif.x_utente
			  ,dose_min = :kst_tab_certif.dose_min
			  ,dose_max = :kst_tab_certif.dose_max
			  ,impianto = :kst_tab_certif.impianto
			where id = :kst_tab_certif.id
		using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Aggiornamento Attestato (kuf_certif.tb_aggiorna):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
		else
			kst_esito.esito = kkg_esito.db_ko
		end if

	else
		kst_esito.esito = kkg_esito.ok

	end if


	if kst_tab_certif.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_certif.st_tab_g_0.esegui_commit) then

		if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then
			kst_esito = kGuf_data_base.db_commit_1()
		else
			kGuf_data_base.db_rollback_1( )
		end if
		
	end if


return kst_esito

end function

public function st_esito tb_add (st_tab_certif kst_tab_certif);//
//====================================================================
//=== Aggiunge il rek alla tabella ATTESTATI
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:     Vedi standard 
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
long k_id
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	kst_tab_certif.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_certif.x_utente = kGuf_data_base.prendi_x_utente()

//id 	
	INSERT INTO certif  
			(   
			  num_certif
			  ,data   
			  ,ora   
			  ,id_meca
			  ,clie_2   
			  ,colli   
			  ,dose
			  ,dose_min   
			  ,dose_max   
			  ,lav_data_ini   
			  ,lav_data_fin   
			  ,note 
			  ,note_1   
			  ,note_2
			  ,st_dose_min
			  ,st_dose_max
			  ,st_data_ini
			  ,st_data_fin
			  ,st_dati_bolla_in
			  ,form_di_stampa
			  ,impianto
			  ,x_datins
			  ,x_utente
			  )   
	VALUES (    
			  :kst_tab_certif.NUM_CERTIF
			  ,:kst_tab_certif.DATA
			  ,:kst_tab_certif.ORA
			  ,:kst_tab_certif.id_meca
			  ,:kst_tab_certif.CLIE_2
			  ,:kst_tab_certif.colli
			  ,:kst_tab_certif.DOSE
			  ,:kst_tab_certif.DOSE_MIN
			  ,:kst_tab_certif.DOSE_MAX
			  ,:kst_tab_certif.lav_data_ini
			  ,:kst_tab_certif.lav_data_fin
			  ,:kst_tab_certif.note
			  ,:kst_tab_certif.note_1
			  ,:kst_tab_certif.note_2 
			  ,:kst_tab_certif.st_dose_min
			  ,:kst_tab_certif.st_dose_max
			  ,:kst_tab_certif.st_data_ini
			  ,:kst_tab_certif.st_data_fin
			  ,:kst_tab_certif.st_dati_bolla_in
			  ,:kst_tab_certif.form_di_stampa
			  ,:kst_tab_certif.impianto
			  ,:kst_tab_certif.x_datins 
			  ,:kst_tab_certif.x_utente
			  )   
		using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Generazione Nuovo Attestato (kuf_certif.tb_add):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
		else
			kst_esito.esito = kkg_esito.db_ko
		end if

	else
		kst_esito.esito = kkg_esito.ok

	end if


	if kst_tab_certif.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_certif.st_tab_g_0.esegui_commit) then

		if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then
			kst_esito = kGuf_data_base.db_commit_1()
		else
			kGuf_data_base.db_rollback_1( )
		end if
		
	end if

return kst_esito

end function

public function st_esito consenti_modifica (st_tab_certif kst_tab_certif);//---
//--- Funzione: Richiesta se Attestato e' possibile fare Modifica
//--- 
//--- Argomenti: st_certif   riempire il Numero dell'Attestato
//---
//--- Ritorno: Esito (st_esito)   Vedi standard
//---
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo
st_esito kst_esito //, kst_esito_ARMO
kuf_armo kuf1_armo


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kuf1_armo = create kuf_armo

//--- se attestato gia' trattato e NON stampato allora posso modificarlo
	SELECT    min(meca.err_lav_ok)
	         , min(meca.data_lav_fin)
	         , min(certif.data_stampa)
	         , max(armo.magazzino)
		into
                 :kst_tab_meca.err_lav_ok
               , :kst_tab_meca.data_lav_fin
               , :kst_tab_certif.data_stampa
               , :kst_tab_armo.magazzino
		 FROM ((artr inner join armo on
			           artr.id_armo = armo.id_armo)
						  left outer join certif on
						  artr.num_certif = certif.num_certif)
						  inner join meca on
						  armo.id_meca = meca.id
			 where artr.num_certif = :kst_tab_certif.num_certif 
				 using sqlca;
		
	if sqlca.sqlcode = 0 then
		
		kst_esito.esito = kkg_esito.no_aut   // per Default NON autorizzo
		
      	if (kst_tab_certif.data_stampa > KKG.DATA_ZERO and not isnull(kst_tab_certif.data_stampa)) then // stampa già fatta!
		else
         	if kst_tab_armo.magazzino <> 1 then  // puo' essere solo diverso da Magazzino 1
             		if kst_tab_meca.err_lav_ok = '0' or isnull(kst_tab_meca.err_lav_ok) then			// Verifica Dosimetrica non effettuata
				else
					if kst_tab_meca.data_lav_fin <= KKG.DATA_ZERO or isnull(kst_tab_meca.data_lav_fin) then // Lavorazione NON completata

//--- Controllo se effettivamente non e' chiuso poiche' potrebbero aver messo solo ora i barcode da NON TRATTARE							
						if get_id_meca(kst_tab_certif) > 0 then  // piglia ID_MECA
							kst_tab_armo.id_meca = kst_tab_certif.id_meca
							if kuf1_armo.if_lotto_completo( kst_tab_armo ) then // Lotto Chiuso????
								kst_esito.esito = kkg_esito.OK   
							end if
						end if
					else
						kst_esito.esito = kkg_esito.OK
					end if
				end if
			end if
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Attestati CERTIF (num.attestato=" &
						 + string(kst_tab_certif.num_certif) + " " &
						 + "): " + trim(SQLCA.SQLErrText)
									 
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.no_aut
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if

	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally
	if isvalid(kuf1_armo)  then destroy kuf1_armo
	
end try
	

return kst_esito
end function

public function st_esito crea_certif (ref st_tab_certif kst_tab_certif);//
//=== 
//====================================================================
//=== Crea / Aggiorna Attestato di Trattamento
//===
//=== Par. Inut: Numero di certificato
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   Vedi standard
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
int k_ctr
st_esito kst_esito, kst1_esito
st_tab_meca kst_tab_meca 
st_tab_certif kst_tab_certif_1


try

//--- inizializza aree
	kst_esito = kguo_exception.inizializza(this.classname())
	kst_esito.st_tab_g_0 = kst_tab_certif.st_tab_g_0 

//--- conta il numero di Riferimento con lo stesso codice certificato
	select  meca.id, count(distinct meca.id)
		into :kst_tab_meca.id, :k_ctr
		from artr inner join armo on
			  artr.id_armo = armo.id_armo
					  inner join MECA on
				ARMO.id_meca = MECA.id  
		 where
				ARTR.num_certif = :kst_tab_certif.num_certif 
		group by meca.id
		using sqlca; 

	if sqlca.sqlcode <> 0 then 
		if sqlca.sqlcode = 100 then						 
			kst_esito.esito = kkg_esito.OK
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Attestato non trovato (kuf_certif.crea_certif)~n~r" &
									+ "(" + trim(SQLCA.SQLErrText) + ")"
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore durante lettura dell'Attestato (kuf_certif.crea_certif)~n~r" &
									+ "(" + trim(SQLCA.SQLErrText) + ")"
		end if					
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- VINCOLO = 1 riferimento 1 certificato
	if k_ctr > 1 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Preparazione Attestato non permessa. ~n~r" &
							  +"Attestato presente su piu' Lotti.  (kuf_certif.crea_certif)~n~r" &
							  + "(nr." + string(kst_tab_certif.num_certif) + ")"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

		
//--- Get area dati Attestato: st_tab_certif 
	crea_certif_set_st_tab_certif(kst_tab_certif)

//--- Carica/Aggiorna dati Attestato
	crea_certif_update(kst_tab_certif)


catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log()


finally

end try 

return kst_esito


end function

public function st_esito anteprima_elenco (datastore kdw_anteprima, st_tab_armo kst_tab_armo);//
//=== 
//====================================================================
//=== Operazione di Anteprima (elenco CERTIF  x id_meca)
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
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
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_dosimetria

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.not_fnd

else

	if kst_tab_armo.id_meca > 0 then

		kdw_anteprima.dataobject = "d_certif_l_1"		
		kdw_anteprima.settransobject(sqlca)

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_armo.id_meca)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Riga Lotto da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Listview
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_corrente, k_handle_item_rit
integer k_ctr, k_pictureindex
string k_label, k_oggetto_corrente, k_oggetto_padre
int k_ind
string k_campo[16]
alignment k_align[16]
alignment k_align_1
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_tab_treeview kst_tab_treeview
st_treeview_data_any kst_treeview_data_any
st_profilestring_ini kst_profilestring_ini


	
//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_corrente = kst_treeview_data.handle
	
	if k_handle_item_corrente = 0 or isnull(k_handle_item_corrente) then
//--- item di ritorno di default
		k_handle_item_corrente = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
	end if
		
//--- prendo il item padre per settare il ritorno di default
	k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)
	if k_handle_item_padre > 0 then
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
	else
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem) 
	end if
	kst_treeview_data = ktvi_treeviewitem.data  
	k_oggetto_padre = trim(kst_treeview_data.oggetto)

//--- cancello dalla listview tutto
	kuf1_treeview.kilv_lv1.DeleteItems()
		 
	klvi_listviewitem.data = kst_treeview_data
	klvi_listviewitem.label = ".."
	klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
	k_handle_item_rit = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)
		
	if k_handle_item_corrente > 0 then

		kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem)

//--- leggo il primo item dalla treeview per esporlo nella list
		k_handle_item = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_corrente)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  

		kuf1_treeview.kilv_lv1.DeleteColumns ( )
		
//--- 
		kuf1_treeview.kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
		if k_label <> "Attestato" then 

//=== Costruisce e Dimensiona le colonne all'interno della listview
			kuf1_treeview.kilv_lv1.DeleteColumns ( )
			k_ind=1
			k_campo[k_ind] = "Attestato"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Riferimento"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "St.E1"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Entrato"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "W.O."
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "S.O."
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Stampato"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "ore"
			k_align[k_ind] = right!
			k_ind++
			k_campo[k_ind] = "Colli/Dose"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Mand./Ricev./Cliente"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "DDT Mand."
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "CO"
			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "CF"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Contr.(id)"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Dose min-max; Data inizio-fine trattamento "
//			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "generato il"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "ID"
			k_align[k_ind] = right!
			k_ind++
			k_campo[k_ind] = "FINE"
			k_align[k_ind] = left!
			
			k_ind=1
			do while trim(k_campo[k_ind]) <> "FINE"

				kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi 
				kst_profilestring_ini.file = "treeview"
				kst_profilestring_ini.titolo = "treeview"
				kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + k_campo[k_ind]
				kst_profilestring_ini.valore = "0"
				k_rc = integer(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
 
				if kst_profilestring_ini.esito = "0" then
					k_ctr = integer(kst_profilestring_ini.valore)
				end if
				if k_ctr = 0 then
					k_ctr = (kuf1_treeview.kilv_lv1.width) / 4 //50 * len(trim(k_campo[k_ind])) 
				end if
				kuf1_treeview.kilv_lv1.addColumn(trim(k_campo[k_ind]), k_align[k_ind], k_ctr)
				k_ind++
			loop

		end if
//---

		do while k_handle_item > 0

				
			kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
	
			kst_treeview_data = ktvi_treeviewitem.data
			kst_treeview_data_any = kst_treeview_data.struttura
			kst_tab_treeview = kst_treeview_data_any.st_tab_treeview

//--- imposto picture MEMO
			if kst_treeview_data_any.st_tab_memo.id_memo > 0 then
				klvi_listviewitem.pictureindex = kuf1_treeview.u_dammi_pic_tree_alert()
			else
				klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
			end if
	
			klvi_listviewitem.label = kst_treeview_data.label
			klvi_listviewitem.data = kst_treeview_data

			klvi_listviewitem.selected = false

			k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)
			k_ind = 0 
			
			kst_tab_treeview.voce =  &
									  string(kst_treeview_data_any.st_tab_certif.num_certif, "##,##0") + " " 
			if kst_treeview_data_any.st_tab_certif.data > date(0) then
				kst_tab_treeview.voce =  trim(kst_tab_treeview.voce) + "  " &
									  + string(kst_treeview_data_any.st_tab_certif.data, "dd mmm") + "  "
			end if
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )


			kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.num_int, "####0") &
										  + "  " + string(kst_treeview_data_any.st_tab_meca.data_int, "dd mmm yy") 
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce = trim(kst_treeview_data_any.st_tab_meca.e1srst) 
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.data_ent, "dd mmm yyyy") 
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			if kst_treeview_data_any.st_tab_meca.e1doco > 0 then
				kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.e1doco, "#") 
			else
				kst_tab_treeview.voce = "-"
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, kst_tab_treeview.voce)
			kst_tab_treeview.voce = ""
			if kst_treeview_data_any.st_tab_meca.e1rorn > 0 then
				if kst_treeview_data_any.st_tab_memo.id_memo > 0 then
					kst_tab_treeview.voce = "***"
				end if
				kst_tab_treeview.voce += string(kst_treeview_data_any.st_tab_meca.e1rorn, "#") 
			else
				kst_tab_treeview.voce = "-"
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, kst_tab_treeview.voce)

			if kst_treeview_data_any.st_tab_certif.data_stampa > date(0) then
				kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_certif.data_stampa, "dd mmm yy") + "  "
			else
				kst_tab_treeview.voce =  "Non stampato"
			end if
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_certif.ora_stampa, "HH:MM") + "  "
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce =  &
										  string(kst_treeview_data_any.st_tab_certif.colli, "####0") &
										  + " / " + string(kst_treeview_data_any.st_tab_certif.dose, "####0.00")  
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce =  &
											  trim(kst_treeview_data_any.st_tab_clienti.rag_soc_10) &
											  + "  (" + string(kst_treeview_data_any.st_tab_meca.clie_1, "####0") &
											  + ")/ " + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_11) &
											  + "  (" + string(kst_treeview_data_any.st_tab_certif.clie_2, "####0") &
											  + ")/ " + + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_20) &
											  + "  (" + string(kst_treeview_data_any.st_tab_meca.clie_3, "####0") &
											  + ") " 
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce = trim(kst_treeview_data_any.st_tab_meca.num_bolla_in) &
										  + "  " + string(kst_treeview_data_any.st_tab_meca.data_bolla_in, "dd mmm yy") 
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce =  trim(kst_treeview_data_any.st_tab_contratti.mc_co) 
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

//			kst_tab_treeview.voce =  trim(kst_treeview_data_any.st_tab_contratti.sc_cf) 
//			k_ind ++
//			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )
//
//			kst_tab_treeview.voce =  string(kst_treeview_data_any.st_tab_meca.contratto, "#") 
//			k_ind ++
//			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )
//
//			if kst_treeview_data_any.st_tab_certif.st_dose_min = "S" then
//				kst_tab_treeview.voce =  string(kst_treeview_data_any.st_tab_certif.dose_min, "####0.00")  
//			else
//				kst_tab_treeview.voce = "No"
//			end if
//			if kst_treeview_data_any.st_tab_certif.st_dose_max = "S" then
//				kst_tab_treeview.voce = kst_tab_treeview.voce &
//									  + " - " + string(kst_treeview_data_any.st_tab_certif.dose_max, "####0.00")  
//			else
//				kst_tab_treeview.voce = kst_tab_treeview.voce + " - No " 
//			end if
//			if kst_treeview_data_any.st_tab_certif.st_data_ini = "S" then
//				kst_tab_treeview.voce = kst_tab_treeview.voce &
//								+ " / " &
//								 + string(kst_treeview_data_any.st_tab_certif.lav_data_ini, "dd mmm yy")  
//			else
//				kst_tab_treeview.voce = kst_tab_treeview.voce + " / No " 
//			end if
//			if kst_treeview_data_any.st_tab_certif.st_data_fin = "S" then
//				kst_tab_treeview.voce = kst_tab_treeview.voce &
//								 + " - " &
//								 + string(kst_treeview_data_any.st_tab_certif.lav_data_fin, "dd mmm yy")  
//			else
//				kst_tab_treeview.voce = kst_tab_treeview.voce + " - No " 
//			end if
//			k_ind ++
//			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_certif.data_ora, "dd mmm yyyy hh:mm")
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_certif.id)
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )
				
				
			k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)
			
		loop
		
	end if


	if k_handle_item_rit > 0 then
		kst_treeview_data.handle_padre = k_handle_item_corrente
		kst_treeview_data.handle = k_handle_item_padre
		kst_treeview_data.oggetto = k_oggetto_padre
		kst_treeview_data.oggetto_listview = k_tipo_oggetto
		ktvi_treeviewitem.data = kst_treeview_data
		klvi_listviewitem.label = ".."
		klvi_listviewitem.data = kst_treeview_data
		klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
		kuf1_treeview.kilv_lv1.setitem(k_handle_item_rit, klvi_listviewitem)
	end if

return k_return

end function

public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
integer k_ctr, k_pic_list, k_mese, k_anno, k_conta_rec
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
string k_query_select, k_query_where, k_query_order
date k_save_data_int, k_data_0, k_dataoggi 
date k_data_da, k_data_a
boolean k_da_elaborare = false
long k_nr_righe, k_riga
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_armo kst_tab_armo
st_tab_contratti kst_tab_contratti
st_tab_certif kst_tab_certif
st_tab_memo kst_tab_memo
//kuf_certif kuf1_certif


	k_data_0 = date(0)		 


	if isvalid(kids_certif_tree_stampati_xdata) then
		kids_certif_tree_stampati_xdata.setfilter("")
		k_rc = kids_certif_tree_stampati_xdata.filter( )
	else
		kids_certif_tree_stampati_xdata = create kds_certif_tree_stampati_xdata
	end if
	kids_certif_tree_stampati_xdata.settransobject(kguo_sqlca_db_magazzino) 
		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
	
//--- Acchiappo handle dell'item
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle

	if k_handle_item_padre > 0 then
		kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
		kst_treeview_data = ktvi_treeviewitem.data
		k_tipo_oggetto_padre = kst_treeview_data.oggetto
	else
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(RootTreeItem!, 0)
		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
	end if

	k_data_0 = date(0)
	k_data_a = date(0)
	k_data_da = date(0)
	k_dataoggi = kguo_g.get_dataoggi()
	kst_treeview_data_any = kst_treeview_data.struttura

//--- In questo caso la data parte da oggi meno 15 gg
	if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.certif_uff_ddt_dett then
		k_data_da = relativedate(k_dataoggi,-15)
		k_data_a = date(9999,12,31)
	else	
	
//--- Periodo di estrazione, se la data e' a zero allora calcolo in automatico -tot mesi
		if (kst_treeview_data_any.st_tab_certif.data = date (0) or isnull(kst_treeview_data_any.st_tab_certif.data)) then

//--- Ricavo la data da dataoggi e vado indietro per sicurezza di alcuni mesi
			k_data_da = date(string(relativedate(k_dataoggi,-180), "yyyy,mm,01"))

		else
//--- prelevo il periodo da a 
			k_data_da = kst_treeview_data_any.st_tab_certif.data
			k_data_a = kst_treeview_data_any.st_tab_certif.data_stampa
	
		end if
	end if
	
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = "0" then
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
			k_pic_list = kst_tab_treeview.pic_list 
		end if

//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)

		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.certif_st_dett &
					,kuf1_treeview.kist_treeview_oggetto.certif_uff_ddt_dett 
				if k_data_da  <> k_data_a then
					k_nr_righe = kids_certif_tree_stampati_xdata.retrieve(0, k_data_da, k_data_a)
				else
					k_nr_righe = kids_certif_tree_stampati_xdata.retrieve(0, k_data_da, k_data_da)
				end if
//--- in questo caso filtro solo gli attestati non stampati da UFF. SPEDIZIONI
				if k_nr_righe > 0 then
					if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.certif_uff_ddt_dett then
						kids_certif_tree_stampati_xdata.setfilter("flg_ristampa_xddt = 0")
						k_rc = kids_certif_tree_stampati_xdata.filter( )
						k_nr_righe = kids_certif_tree_stampati_xdata.rowcount( )
					end if
				end if
					
			case kuf1_treeview.kist_treeview_oggetto.meca_car_cert_dett
				k_nr_righe = kids_certif_tree_stampati_xdata.retrieve(kst_treeview_data_any.st_tab_certif.num_certif, k_data_da, k_data_da)
//				k_query_where = " where " 
//				k_query_where = k_query_where &
//				+ " certif.num_certif = ? " 
				
			case else
					//k_query_where = " "
					k_nr_righe = 0
	
		end choose
		
		k_conta_rec=0
		
		if k_nr_righe > 0 then

//			kuf1_certif = create kuf_certif
			
			for k_riga = 1 to k_nr_righe

				kst_tab_certif.id = kids_certif_tree_stampati_xdata.getitemnumber(k_riga, "id")
				kst_tab_certif.num_certif	 = kids_certif_tree_stampati_xdata.getitemnumber(k_riga, "num_certif")
				kst_tab_certif.data  = kids_certif_tree_stampati_xdata.getitemdate(k_riga, "data")
				kst_tab_certif.ora  = kids_certif_tree_stampati_xdata.getitemtime(k_riga, "ora")
				kst_tab_certif.id_meca = kids_certif_tree_stampati_xdata.getitemnumber(k_riga, "id_meca")
				kst_tab_certif.data_stampa = kids_certif_tree_stampati_xdata.getitemdate(k_riga, "data_stampa")
				kst_tab_certif.ora_stampa = kids_certif_tree_stampati_xdata.getitemtime(k_riga, "ora_stampa")
				kst_tab_certif.lav_data_ini = kids_certif_tree_stampati_xdata.getitemdate(k_riga, "lav_data_ini")
				kst_tab_certif.lav_data_fin = kids_certif_tree_stampati_xdata.getitemdate(k_riga, "lav_data_fin")
				kst_tab_certif.colli  = kids_certif_tree_stampati_xdata.getitemnumber(k_riga, "colli")
				kst_tab_certif.dose  = kids_certif_tree_stampati_xdata.getitemnumber(k_riga, "dose")
//				kst_tab_certif.dose_min = kids_certif_tree_stampati_xdata.getitemnumber(k_riga, "dose_min")
//				kst_tab_certif.dose_max = kids_certif_tree_stampati_xdata.getitemnumber(k_riga, "dose_max")
//				kst_tab_certif.note = kids_certif_tree_stampati_xdata.getitemstring(k_riga, "note")
//				kst_tab_certif.note_1 = kids_certif_tree_stampati_xdata.getitemstring(k_riga, "note_1")
//				kst_tab_certif.note_2 = kids_certif_tree_stampati_xdata.getitemstring(k_riga, "note_2")
				kst_tab_certif.x_datins = kids_certif_tree_stampati_xdata.getitemdatetime(k_riga, "x_datins")
				kst_tab_meca.num_int = kids_certif_tree_stampati_xdata.getitemnumber(k_riga, "num_int")
				kst_tab_meca.data_int = kids_certif_tree_stampati_xdata.getitemdate(k_riga, "data_int")
				kst_tab_meca.data_ent = kids_certif_tree_stampati_xdata.getitemdatetime(k_riga, "data_ent")
				kst_tab_meca.clie_1 = kids_certif_tree_stampati_xdata.getitemnumber(k_riga, "clie_1")
				kst_tab_certif.clie_2 = kids_certif_tree_stampati_xdata.getitemnumber(k_riga, "clie_2")
				kst_tab_meca.clie_3 = kids_certif_tree_stampati_xdata.getitemnumber(k_riga, "clie_3")
				kst_tab_meca.num_bolla_in = kids_certif_tree_stampati_xdata.getitemstring(k_riga, "num_bolla_in")
				kst_tab_meca.data_bolla_in = kids_certif_tree_stampati_xdata.getitemdate(k_riga, "data_bolla_in")
				kst_tab_meca.contratto = kids_certif_tree_stampati_xdata.getitemnumber(k_riga, "contratto")
				kst_tab_contratti.mc_co = kids_certif_tree_stampati_xdata.getitemstring(k_riga, "mc_co")
//				kst_tab_contratti.sc_cf = kids_certif_tree_stampati_xdata.getitemstring(k_riga, "sc_cf")
				kst_tab_clienti.rag_soc_10 = kids_certif_tree_stampati_xdata.getitemstring(k_riga, "c1_rag_soc_10")
				kst_tab_clienti.rag_soc_11 = kids_certif_tree_stampati_xdata.getitemstring(k_riga, "c2_rag_soc_10")
				kst_tab_clienti.rag_soc_20 = kids_certif_tree_stampati_xdata.getitemstring(k_riga, "c3_rag_soc_10")
				kst_tab_meca.e1doco = kids_certif_tree_stampati_xdata.getitemnumber(k_riga, "e1doco")
				kst_tab_meca.e1rorn = kids_certif_tree_stampati_xdata.getitemnumber(k_riga, "e1rorn")
				kst_tab_memo.id_memo = kids_certif_tree_stampati_xdata.getitemnumber(k_riga, "id_memo")
				kst_tab_meca.e1srst = kids_certif_tree_stampati_xdata.getitemstring(k_riga, "e1srst")
	
//---toglie i NULL dai campi
				if_isnull(kst_tab_certif)
				if isnull(kst_tab_meca.contratto) then kst_tab_meca.contratto = 0
				if isnull(kst_tab_contratti.mc_co) then kst_tab_contratti.mc_co = ""
				if isnull(kst_tab_contratti.sc_cf) then kst_tab_contratti.sc_cf = ""
	
				kst_tab_meca.id = kst_tab_certif.id_meca
				kst_tab_armo.id_meca = kst_tab_certif.id_meca
				kst_tab_armo.num_int = kst_tab_meca.num_int
				kst_tab_armo.data_int = kst_tab_meca.data_int
				
				kst_treeview_data_any.st_tab_certif = kst_tab_certif
				kst_treeview_data_any.st_tab_meca = kst_tab_meca
				kst_treeview_data_any.st_tab_armo = kst_tab_armo
				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
				kst_treeview_data_any.st_tab_contratti = kst_tab_contratti
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
				kst_treeview_data_any.st_tab_memo = kst_tab_memo
				
//--- dati esposti nell'item	
				kst_treeview_data.label = &
											 string(kst_tab_certif.num_certif, "##,##0") &
										  + "  " + string(kst_tab_certif.data, "dd mmm") &
										  + "    (" + string(kst_tab_meca.num_int, "####0") &
										  + "/" + string(kst_tab_meca.data_int, "mmm yy") &
										  + "   " &
										  + string(kst_tab_clienti.rag_soc_11, "@@@@@@@@@@") + ")"

//--- riempo dati tabella dell'item
				kst_treeview_data.struttura = kst_treeview_data_any
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
				kst_treeview_data.handle = k_handle_item_padre
				ktvi_treeviewitem.label = kst_treeview_data.label
				ktvi_treeviewitem.data = kst_treeview_data

//--- Nuovo Item
				ktvi_treeviewitem.selected = false
				k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)

				kst_treeview_data.pic_list = k_pic_list
				
//--- salvo handle del item appena inserito nella stessa struttura
				kst_treeview_data.handle = k_handle_item

//--- inserisco il handle di questa riga tra i dati del item
				ktvi_treeviewitem.data = kst_treeview_data

				kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)

//--- troppi record lista interrotta
				k_conta_rec++
				if k_conta_rec > 2000 then
//--- dati esposti nell'item	
					kst_treeview_data.label = "Troppi record elenco interrotto "
//--- riempo dati tabella dell'item
					kst_treeview_data.struttura = kst_treeview_data_any
					kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
					kst_treeview_data.handle = k_handle_item_padre
					ktvi_treeviewitem.label = kst_treeview_data.label
					ktvi_treeviewitem.data = kst_treeview_data
//--- Nuovo Item
					ktvi_treeviewitem.selected = false
					k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
					kst_treeview_data.pic_list = k_pic_list
//--- salvo handle del item appena inserito nella stessa struttura
					kst_treeview_data.handle = k_handle_item
//--- inserisco il handle di questa riga tra i dati del item
					ktvi_treeviewitem.data = kst_treeview_data
					kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
					exit // forza USCITA CICLO
					//sqlca.sqlcode = 100 // forza USCITA CICLO
				end if
		
	
			//loop
			next
			
//			close kc_treeview;

//			destroy kuf1_certif

		end if

	end if 
 
return k_return


end function

public function integer u_tree_riempi_treeview_x_mese (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0, k_handle_primo=0
long k_totale
integer k_ctr, k_pic_close, k_pic_open, k_pic_list
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
date k_save_data_int, k_data_da
int k_mese, k_anno, k_anno_old
string k_mese_desc [0 to 13]
long k_breakrow, k_nr_righe
any k_value
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_tab_certif kst_tab_certif
st_tab_treeview kst_tab_treeview
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any

 
	
//declare kc_treeview cursor for
//	SELECT 
//         count (*), 
//         month(certif.data) as mese,   
//         year(certif.data) as anno   
//     FROM certif
//    WHERE 
//			 (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.certif_st_mese
//			 )
//			 and (
//			 	 (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.certif_st_mese
//				  and certif.data > '01.01.2003'
//			    )
//			 )
//		 group by  3, 2
//		 order by  3 desc, 2 desc;
//
////			    or
////			    (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.meca_lav_mese_ok
////			     and dosim_assorb > 0 and (meca.err_lav_ok <> "1" or meca.err_lav_ok is null)
////				)

//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
	
//--- Acchiappo handle dell'item
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle

	if k_handle_item_padre > 0 then
		kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
		kst_treeview_data = ktvi_treeviewitem.data
		k_tipo_oggetto_padre = kst_treeview_data.oggetto
	else
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(RootTreeItem!, 0)
		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
	end if
	 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = "0" then
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
			k_pic_list = kst_tab_treeview.pic_list
		end if

//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)

		if not isvalid(kids_certif_tree_stampati_xgiornomeseanno) then 
			kids_certif_tree_stampati_xgiornomeseanno = create datastore
			kids_certif_tree_stampati_xgiornomeseanno.dataobject = "ds_certif_tree_stampati_xgiornomeseanno"
			kids_certif_tree_stampati_xgiornomeseanno.settransobject(kguo_sqlca_db_magazzino) 
		end if

		k_data_da = relativedate(kguo_g.get_dataoggi( ),  -2100)
		k_nr_righe = kids_certif_tree_stampati_xgiornomeseanno.retrieve(k_data_da)
//		open kc_treeview;
		
		
//		if sqlca.sqlcode = 0 then
//			fetch kc_treeview 
//				into
//					  :kst_treeview_data_any.contati
//					 ,:k_mese
//					 ,:k_anno
//					  ;
	
		k_mese_desc[0] = "[Completa]"
		k_mese_desc[1] = "Gennaio"
		k_mese_desc[2] = "Febbraio"
		k_mese_desc[3] = "Marzo"
		k_mese_desc[4] = "Aprile"
		k_mese_desc[5] = "Maggio"
		k_mese_desc[6] = "Giugno"
		k_mese_desc[7] = "Luglio"
		k_mese_desc[8] = "Agosto"
		k_mese_desc[9] = "Settembre"
		k_mese_desc[10] = "Ottobre"
		k_mese_desc[11] = "Novembre"
		k_mese_desc[12] = "Dicembre"
		k_mese_desc[13] = "NON RILEVATO"

		k_totale = 0
		k_anno_old = 0

		if k_nr_righe > 0 then

//--- find where the next group break is and get rownumber
			k_breakrow = kids_certif_tree_stampati_xgiornomeseanno.FindGroupChange(0, 1)
			do while k_breakrow > 0
//			do while sqlca.sqlcode = 0

//--- get the value of the computed field at that row
				k_value = kids_certif_tree_stampati_xgiornomeseanno.object.k_mese_tot[k_breakrow]
				if isnumber(string(k_value)) then
					kst_treeview_data_any.contati = long(k_value)
				end if
				k_mese = kids_certif_tree_stampati_xgiornomeseanno.getitemnumber(k_breakrow, "mese")
				k_anno = kids_certif_tree_stampati_xgiornomeseanno.getitemnumber(k_breakrow, "anno")
	
	
//--- a rottura di anno presenta la riga totale a inizio
				if k_anno <> k_anno_old then
			 
					if k_totale > 0 then
				
//--- Estrazione del primo Item, quello dei totali
						ktvi_treeviewitem.selected = false
						k_handle_item = kuf1_treeview.kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
						kst_treeview_data = ktvi_treeviewitem.data
						kst_treeview_data_any = kst_treeview_data.struttura
						kst_tab_treeview = kst_treeview_data_any.st_tab_treeview

//--- Aggiorno il primo Item con i totali
						kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Attestati presenti"
						k_totale = 0
			
						kst_tab_certif.data = date(k_anno_old,01,01)
						kst_tab_certif.data_stampa = date(k_anno_old+1,01,01)
						
						kst_treeview_data_any.st_tab_certif = kst_tab_certif
						kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
						kst_treeview_data.struttura = kst_treeview_data_any
						ktvi_treeviewitem.data = kst_treeview_data
						
						k_handle_item = kuf1_treeview.kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
					end if
					
					k_anno_old = k_anno // memorizzo l'anno x la rottura
					
					kst_treeview_data.label = k_mese_desc[0] &
													  + "  " &
													  + string(k_anno) 
					kst_tab_treeview.voce = kst_treeview_data.label
					kst_tab_treeview.id = "0"
					kst_tab_treeview.descrizione = "  ...conteggio in esecuzione..."
					kst_tab_treeview.descrizione_tipo = "Attestati " 
					kst_treeview_data.pic_list = k_pic_list
					kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
					kst_treeview_data_any.st_tab_certif = kst_tab_certif
					kst_treeview_data_any.st_tab_certif.data_stampa = date(0)
					kst_treeview_data.struttura = kst_treeview_data_any
					kst_treeview_data.handle = k_handle_item_padre
					ktvi_treeviewitem.label = kst_treeview_data.label
					ktvi_treeviewitem.data = kst_treeview_data
	//--- Nuovo Item
					ktvi_treeviewitem.selected = false
					k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
	//--- salvo handle del item appena inserito nella stessa struttura
					kst_treeview_data.handle = k_handle_item
					k_handle_primo = k_handle_item
	//--- inserisco il handle di questa riga tra i dati del item
					ktvi_treeviewitem.data = kst_treeview_data
					kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
				end if
	
				k_totale = k_totale + kst_treeview_data_any.contati
	
				
				kst_treeview_data.label = &
										  k_mese_desc[k_mese]  &
										  + "  " &
										  + string(k_anno) 
	
				if k_mese = 0 or k_mese > 12 or isnull(k_mese) then
					k_mese = 13
					kst_tab_certif.data = date(k_anno,01,01)
					kst_tab_certif.data_stampa = date(k_anno+1,01,01)
				else			
					kst_tab_certif.data = date(k_anno,k_mese,01)
					k_mese++
					if k_mese > 12 then
						k_mese = 1
						k_anno++
					end if
					kst_tab_certif.data_stampa = date(k_anno, k_mese, 01)
				end if

				kst_tab_treeview.voce = kst_treeview_data.label
				kst_tab_treeview.id = string(k_anno, "0000")  + string(k_mese, "00") 
				if kst_treeview_data_any.contati = 1 then
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  Attestato presente"
				else
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  Attestati presenti"
				end if

				kst_tab_treeview.descrizione_tipo = "Attestati " 
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data_any.st_tab_certif = kst_tab_certif
				kst_treeview_data.struttura = kst_treeview_data_any

				kst_treeview_data.handle = k_handle_item_padre
	
				ktvi_treeviewitem.label = kst_treeview_data.label
				ktvi_treeviewitem.data = kst_treeview_data
										  
//--- Nuovo Item
				ktvi_treeviewitem.selected = false
				k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
				
//--- salvo handle del item appena inserito nella stessa struttura
				kst_treeview_data.handle = k_handle_item

//--- inserisco il handle di questa riga tra i dati del item
				ktvi_treeviewitem.data = kst_treeview_data

				kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)


//				fetch kc_treeview 
//					into
//					  :kst_treeview_data_any.contati
//					 ,:k_mese
//					 ,:k_anno
//					  ;

//--- find where the next group break is and get rownumber
				k_breakrow += 1
				k_breakrow = kids_certif_tree_stampati_xgiornomeseanno.FindGroupChange(k_breakrow, 1)
	
			loop

//--- giro finale per totale anno
			if k_totale > 0 then
		
//--- Estrazione del primo Item, quello dei totali
				ktvi_treeviewitem.selected = false
				k_handle_item = kuf1_treeview.kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
				kst_treeview_data = ktvi_treeviewitem.data
				kst_treeview_data_any = kst_treeview_data.struttura
				kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
//--- Aggiorno il primo Item con i totali
				kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Attestati presenti"
				k_totale = 0
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data.struttura = kst_treeview_data_any
				ktvi_treeviewitem.data = kst_treeview_data
				k_handle_item = kuf1_treeview.kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
			end if
			
//			close kc_treeview;
			
		end if

	end if 
 
return k_return


end function

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_certif kst_tab_certif);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   Vedi standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_tab_certif kst_tab_certif_da
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_attestati

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	try
		
		if kst_tab_certif.num_certif > 0 then
	
			get_form_di_stampa(kst_tab_certif)
			if len(trim(kst_tab_certif.form_di_stampa)) > 0 then
				kdw_anteprima.dataobject = trim(kst_tab_certif.form_di_stampa)		
				kst_tab_certif_da.num_certif = kst_tab_certif.num_certif 
			else
				kdw_anteprima.dataobject = "d_certif"		
				kst_tab_certif_da.num_certif = 0
			end if
	
			kdw_anteprima.settransobject(sqlca)
	
			kdw_anteprima.reset()	
	
//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_certif_da.num_certif,  kst_tab_certif.num_certif )
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Attestato da visualizzare: ~n~r" + "nessun numero attestato indicato"
			kst_esito.esito = kkg_esito.db_ko
			
		end if
		
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		
	end try
	
end if


return kst_esito

end function

public function st_esito get_ultimo_doc_ins (ref st_tab_certif kst_tab_certif);//
//====================================================================
//=== Torna l'ultimo ATTESTATO caricato (Numero e Data) della Anagrafica impostata
//=== 
//=== Input : st_tab_certif.clie_2
//=== Out: st_tab_certif.num_certif + data + id
//=== Ritorna: ST_ESITO					
//===   
//====================================================================
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	select id	
			,num_certif
	        ,data
		into :kst_tab_certif.id
			,:kst_tab_certif.num_certif
			,:kst_tab_certif.data
		from certif  
		where id in 
		(select max(id) from certif 
			where clie_2 = :kst_tab_certif.clie_2 )
		using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_tab_certif.num_certif = 0
		kst_tab_certif.id = 0
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = sqlca.sqlerrtext
		end if
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
st_tab_certif kst_tab_certif, kst1_tab_certif[]
st_esito kst_esito
uo_exception kuo_exception
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
//kuf_menu_window kuf1_menu_window
//kuf_web kuf1_web
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito = kguo_exception.inizializza(this.classname())

choose case a_campo_link

	case "num_certif"
		kst_tab_certif.num_certif = adw_link.getitemnumber(adw_link.getrow(), a_campo_link)
		if kst_tab_certif.num_certif > 0 then
			kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_certif )
			if kst_esito.esito <> kkg_esito.ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Attestato di Trattamento  (nr.=" + trim(string(kst_tab_certif.num_certif)) + ") " 
		else
			k_return = false
		end if


	case "certif_lotto"
		kst_tab_certif.id_meca = adw_link.getitemnumber(adw_link.getrow(), "id_meca")
		if kst_tab_certif.id_meca > 0 then
			get_num_certif (kst_tab_certif)   //  piglia il NUMERO CERTIFICATO
			if kst_tab_certif.num_certif > 0 then
				kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_certif )
				if kst_esito.esito <> kkg_esito.ok then
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito)
					throw kuo_exception
				end if
				kst_open_w.key1 = "Attestato di Trattamento  (nr.=" + trim(string(kst_tab_certif.num_certif)) + ") " 
			end if
		else
			k_return = false
		end if
 
	case "certif_stampa"
		kst_tab_certif.id_meca = adw_link.getitemnumber(adw_link.getrow(), "id_meca")
		if kst_tab_certif.id_meca > 0 then
			get_num_certif (kst_tab_certif)   //  piglia il NUMERO CERTIFICATO
			if kst_tab_certif.num_certif > 0 then
				kst1_tab_certif[1] = kst_tab_certif
				kiuf_certif_print = create kuf_certif_print
				kiuf_certif_print.stampa(kst1_tab_certif[])  // STAMPA!!!
			end if
		else
			k_return = true
		end if

end choose

if k_return and  a_campo_link <> "certif_stampa" then

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
		kuo_exception.setmessage(u_get_errmsg_nontrovato(kst_open_w.flag_modalita))
		throw kuo_exception
		
		
	end if

end if

SetPointer(kp_oldpointer)



return k_return

end function

public function boolean get_form_di_stampa (ref st_tab_certif kst_tab_certif) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------------------
//--- 
//--- Legge il nome del Dataobject (datawindow) del certificato ad esempio: "d_certif_stampa_2006"
//--- 
//--- 
//--- Input: st_tab_certif.num_certif
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



	SELECT
				certif.id
			     ,certif.form_di_stampa   
				 ,data_stampa
				into
		         :kst_tab_certif.id,   
		         :kst_tab_certif.form_di_stampa,  
		         :kst_tab_certif.data_stampa  
			 FROM certif  
			 where num_certif  = :kst_tab_certif.num_certif
				 using sqlca;
		
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Recupero nome Form di stampa Attestato (tab. certif Numero=" + string(kst_tab_certif.num_certif) + " " &
						 + "~n~rErrore: " + trim(SQLCA.SQLErrText)
									 
		kst_esito.esito = kkg_esito.db_ko
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)		
		throw kguo_exception
		
	end if
	
	if len(trim(kst_tab_certif.form_di_stampa)) > 0 then
	else
		kst_tab_certif.form_di_stampa = ""
	end if
	if isnull(kst_tab_certif.data_stampa) then
		kst_tab_certif.data_stampa = kkg.data_zero
	end if
	
	k_return = true 

return k_return


end function

public function boolean set_id_docprod (st_tab_certif kst_tab_certif) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------
//--- Imposta a ID del Documento Esportato in Tabella certif
//--- 
//--- 
//--- Inp: st_tab_certif.id  e  id_docprod
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
	
	
if kst_tab_certif.id > 0 then

	kst_tab_certif.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_certif.x_utente = kGuf_data_base.prendi_x_utente()

	UPDATE certif  
		  SET id_docprod = :kst_tab_certif.id_docprod
			,x_datins = :kst_tab_certif.x_datins
			,x_utente = :kst_tab_certif.x_utente
		WHERE certif.id = :kst_tab_certif.id
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiorn. 'id Documento Esportato' sul Attestato. ~n~r" &
					+ "Id: " + string(kst_tab_certif.id, "####0") + "  " &
					+ " ~n~rErrore-tab.certif:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_certif.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_certif.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	else
		if kst_tab_certif.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_certif.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	end if

else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. Attestati, Manca Identificativo (id) !" 
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

public function st_esito get_id (ref st_tab_certif kst_tab_certif);//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna il ID dal Numero Certificato
//--- 
//--- 
//--- Input: st_tab_certif.num_certif
//--- Out: st_tab_certif.id
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


//--- x numero certificato			
	SELECT
				certif.id
			into
		         :kst_tab_certif.id  
			 FROM certif  
			 where 
						(num_certif  = :kst_tab_certif.num_certif)					     
				 using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante Lettura Attestato (certif) numero = " + string(kst_tab_certif.num_certif) + " " &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
									 
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if
	

return kst_esito


end function

public function boolean if_esiste (readonly st_tab_certif kst_tab_certif) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla esistenza Attestato da id
//--- 
//--- 
//--- Inp: st_tab_certif.id
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


//--- x numero certificato			
	SELECT count(*)
			into :k_trovato
			 FROM certif  
			 where  id  = :kst_tab_certif.id
			 using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura Attestato (certif) id = " + string(kst_tab_certif.id) + " " &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
									 
		kst_esito.esito = kkg_esito.db_ko
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		if k_trovato > 0 then k_return = true
	end if
	

return k_return



end function

public function boolean if_crea_certif (st_tab_certif kst_tab_certif) throws uo_exception;//
//--- Verifica se Attestato gia' da fare/stampare o ancora lotto incompleto ecc...
//--- Inp: st_tab_cerif. num_certif o id_meca
//--- Rit.: TRUE = Ok attestato /  FALSE = attestato non pronto
//--- Lancia EXCEPTION se errore grave
//---
boolean k_return = false
kuf_armo kuf1_armo
kuf_artr kuf1_artr 
st_tab_armo kst_tab_armo
st_tab_meca kst_tab_meca
st_tab_artr kst_tab_artr
st_esito kst_esito



try 

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = " "
	kst_esito.nome_oggetto = this.classname()
	
	kuf1_armo = create kuf_armo
	kuf1_artr = create kuf_artr

//--- recupera id lotto
	if kst_tab_certif.id_meca = 0 or isnull(kst_tab_certif.id_meca) then
		get_id_meca(kst_tab_certif)
	end if

//--- se id_meca non trovato vado su archivio trattati a prendere il id_meca
	if kst_tab_certif.id_meca = 0 or isnull(kst_tab_certif.id_meca) then
		kst_tab_artr.num_certif = kst_tab_certif.num_certif
		kst_tab_armo.id_armo = kuf1_artr.get_id_armo_da_num_certif(kst_tab_artr)
		if kst_tab_armo.id_armo > 0 then
			kuf1_armo.get_id_meca_da_id_armo(kst_tab_armo)
			kst_tab_certif.id_meca = kst_tab_armo.id_meca  
		end if
	end if

//--- spero proprio ci sia altrimenti KO		
	if kst_tab_certif.id_meca > 0 then

//--- lotto Trattato completamente? 
		kst_tab_armo.id_meca = kst_tab_certif.id_meca
		if kuf1_armo.if_lotto_completo( kst_tab_armo ) then 
		
//--- e lotto gia' Convalidato?
			kst_tab_meca.id = kst_tab_certif.id_meca
			if kuf1_armo.if_convalidato( kst_tab_meca ) then 
				k_return = true
			end if
		end if
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception

finally 
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_artr) then destroy kuf1_artr

end try


return k_return

end function

public function st_esito tb_delete (st_tab_certif kst_tab_certif) throws uo_exception;//
//====================================================================
//=== Cancella il rek dalla tabella ATTESTATI
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:     vedi standard
//=== 
//====================================================================
boolean k_autorizza
integer k_sn=0
int k_rek_ok=0
long k_id
st_tab_docprod kst_tab_docprod
st_tab_artr kst_tab_artr
st_tab_meca kst_tab_meca		
st_esito kst_esito, kst_esito1
st_open_w kst_open_w
kuf_artr kuf1_artr
kuf_docprod kuf1_docprod
kuf_doctipo kuf1_doctipo
kuf_sicurezza kuf1_sicurezza
kuf_armo_inout kuf1_armo_inout
 

try 
	kst_esito = kguo_exception.inizializza(this.classname())
	
	select distinct num_certif, data_stampa
		into :kst_tab_certif.num_certif, :kst_tab_certif.data_stampa
		from certif
		where id = :kst_tab_certif.id  
		using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
	
		kst_open_w = kst_open_w
	
		if kst_tab_certif.data_stampa > kguo_g.get_dataoggi( ) then
			kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
		else
			kst_open_w.flag_modalita = kkg_flag_modalita.stampa
		end if
		
		kst_open_w.id_programma = kkg_id_programma_attestati
		
		//--- controlla se utente autorizzato alla funzione in atto
		kuf1_sicurezza = create kuf_sicurezza
		k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
		destroy kuf1_sicurezza
		
		if not k_autorizza then
		
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Cancellazione Attestato non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
			kst_esito.esito = KKG_esito.no_aut
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

//--- get dell'eventuale ID_MECA
		try
			get_id_meca(kst_tab_certif)
		catch (uo_exception kuo_exception)
			
		end try

		delete from certif
			where id = :kst_tab_certif.id  
			using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Cancellazione Attestato (certif) " &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = KKG_esito.db_ko
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	
		if kst_tab_certif.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_commit( )
		end if

//--- inizializza su ARTR data stampa 			
		kst_tab_artr.num_certif = kst_tab_certif.num_certif
		kst_tab_artr.data_st = KKG.DATA_ZERO
		kuf1_artr = create kuf_artr
		kst_tab_artr.st_tab_g_0.esegui_commit = "S" //"N" x temporaltable
		kst_esito1=kuf1_artr.aggiorna_data_stampa_attestato(kst_tab_artr)
		if kst_esito1.sqlcode < 0 then
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito1)
			throw kguo_exception
		end if
			
		try
//--- cancella da docprod	 tutti i riferimenti
			kst_tab_docprod.id_doc = kst_tab_certif.id
			kuf1_docprod = create kuf_docprod
			kuf1_doctipo = create kuf_doctipo
			kst_tab_docprod.st_tab_g_0.esegui_commit = "S" //"N" x temporaltable
			kuf1_docprod.tb_delete(kst_tab_docprod, kuf1_doctipo.kki_tipo_attestati )
		catch (uo_exception kuo1_exception)
			
		end try
		
		try
//--- Altre operazioni tipo il reset x eventuale Quarantena, reset dello Stato dei Prezzi riga Lotto ec.......
//--- Recupera il ID del Lotto di entrata
			if kst_tab_certif.id_meca > 0 then
				kuf1_armo_inout = create kuf_armo_inout
				kst_tab_meca.id = kst_tab_certif.id_meca
				kst_tab_meca.st_tab_g_0.esegui_commit = "S" //"N" x temporaltable
				kuf1_armo_inout.update_post_delete_attestato(kst_tab_meca)
			end if
		catch (uo_exception kuo2_exception)
			
		end try

	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Ricerca e Cancellazione Attestato (certif):" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = KKG_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = KKG_esito.db_wrn
			else
				kst_esito.esito = KKG_esito.db_ko
				kguo_exception.inizializza()
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
	
	if kst_tab_certif.st_tab_g_0.esegui_commit = "N" then
	else
		kguo_sqlca_db_magazzino.db_commit( )
	end if

catch (uo_exception kuo10_exception)
	if kst_tab_certif.st_tab_g_0.esegui_commit = "N" then
	else
		kguo_sqlca_db_magazzino.db_rollback( )
	end if

	throw kuo10_exception

finally
	if isvalid(kuf1_artr) then destroy kuf1_artr 
	if isvalid(kuf1_docprod) then destroy kuf1_docprod 
	if isvalid(kuf1_doctipo) then destroy kuf1_doctipo 
	if isvalid(kuf1_armo_inout) then destroy kuf1_armo_inout 

end try

return kst_esito

end function

public function long get_id_da_nome (string a_nome_file);//
//--- Estrae dal nome file pdf il id es. "att123456_...._id54342.pdf" torna 54342
//---
//--- input: nome file
//--- Rit: id
//---
//--- Lancia EXCEPTION
//---
long k_return
string k_idx
long k_ctr_id, k_ctr_pdf


	if left(a_nome_file,3) = "att" then
		
		k_ctr_id = pos(a_nome_file, "_id", 1)
		if k_ctr_id > 0 then
			k_ctr_id = k_ctr_id + 3
		end if
		
		k_ctr_pdf = pos(a_nome_file, ".", k_ctr_id)
		if k_ctr_pdf > 0 then
			k_idx = mid(a_nome_file, k_ctr_id, k_ctr_pdf - k_ctr_id)
		else
			k_idx = mid(a_nome_file, k_ctr_id)
		end if
	
		if isnumber(trim(k_idx)) then
			k_return = long(k_idx)
		end if
	end if
	
return k_return

end function

public function long get_num_certif_da_nome (string a_nome_file);//
//--- Estrae dal nome file pdf il num_certif es. "att161112_nr123456...._id54342.pdf" torna 123456
//---
//--- input: nome file
//--- Rit: id
//---
//--- Lancia EXCEPTION
//---
long k_return
string k_idx
long k_ctr_num, k_ctr_end


	if left(a_nome_file,3) = "att" then
		
		k_ctr_num = pos(a_nome_file, "_nr", 1)
		if k_ctr_num > 0 then
			k_ctr_num += 3
		end if
		
		k_ctr_end = pos(a_nome_file, "_", k_ctr_num)
		if k_ctr_end > 0 then
			k_idx = mid(a_nome_file, k_ctr_num, k_ctr_end - k_ctr_num)
		else
			k_idx = mid(a_nome_file, k_ctr_num)
		end if
	
		if isnumber(trim(k_idx)) then
			k_return = long(k_idx)
		end if
	end if
	
return k_return

end function

public function long get_id_meca (ref st_tab_certif kst_tab_certif) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna il ID_MECA del Certificato
//--- 
//--- 
//--- Input: st_tab_certif.num_certif
//--- Out: st_tab_certif.id_meca
//--- Ritorna: id_meca
//---
//--- Lancia EXCEPTION
//---
//---------------------------------------------------------------------------------------------------------------------------
ulong k_return
st_esito kst_esito



	kst_esito = kguo_exception.inizializza(this.classname())

//--- x numero certificato			
	SELECT
				certif.id_meca
			into
		         :kst_tab_certif.id_meca  
			FROM certif  
			where 
			    num_certif  = :kst_tab_certif.num_certif
				 using  kguo_sqlca_db_magazzino ;
		
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_certif.id_meca > 0 then
			k_return = kst_tab_certif.id_meca  
		end if

	else
		kst_tab_certif.id_meca = 0
		
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in ricerca ID Lotto nella Tab. Attestati (CERTIF ) numero = " &
						 + string(kst_tab_certif.num_certif) + " " &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
									 
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = KKG_ESITO.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
	end if
	

return k_return


end function

public function integer u_tree_riempi_treeview_x_giorno (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0, k_handle_primo=0
long k_totale
integer k_ctr, k_pic_close, k_pic_open, k_pic_list
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
date k_save_data_int, k_data
string k_mese, k_anno
int  k_giorno, k_annoN, k_meseN //k_anno_old,
string k_giorno_desc [0 to 8], k_mese_desc [0 to 13]
long  k_nr_righe, k_riga
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_tab_certif kst_tab_certif
st_tab_treeview kst_tab_treeview
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any



//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
	
//--- Acchiappo handle dell'item
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle

	if k_handle_item_padre > 0 then
		kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
		kst_treeview_data = ktvi_treeviewitem.data
		k_tipo_oggetto_padre = kst_treeview_data.oggetto
	else
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(RootTreeItem!, 0)
		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
	end if
	 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = "0" then
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
			k_pic_list = kst_tab_treeview.pic_list
		end if

//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)

	
		k_mese_desc[0] = "[Completa]"
		k_mese_desc[1] = "Gennaio"
		k_mese_desc[2] = "Febbraio"
		k_mese_desc[3] = "Marzo"
		k_mese_desc[4] = "Aprile"
		k_mese_desc[5] = "Maggio"
		k_mese_desc[6] = "Giugno"
		k_mese_desc[7] = "Luglio"
		k_mese_desc[8] = "Agosto"
		k_mese_desc[9] = "Settembre"
		k_mese_desc[10] = "Ottobre"
		k_mese_desc[11] = "Novembre"
		k_mese_desc[12] = "Dicembre"
		k_mese_desc[13] = "NON RILEVATO"

		k_giorno_desc[0] = "[MESE]"
		k_giorno_desc[2] = "lunedì"
		k_giorno_desc[3] = "martedì"
		k_giorno_desc[4] = "mercoledì"
		k_giorno_desc[5] = "giovedì"
		k_giorno_desc[6] = "venerdì"
		k_giorno_desc[7] = "sabato"
		k_giorno_desc[1] = "domenica"
		k_giorno_desc[8] = "NON RILEVATO"

		k_totale = 0
//		k_anno_old = 0

//--- Periodo di estrazione, se la data e' a zero allora calcolo in automatico -3 mesi
		kst_treeview_data_any = kst_treeview_data.struttura
//		if (kst_treeview_data_any.st_tab_certif.data = date (0) &
//			 or isnull(kst_treeview_data_any.st_tab_certif.data)) &
//			 then
//
////--- Ricavo la data da dataoggi e vado indietro per sicurezza di alcuni mesi
//			k_data = kguo_g.get_dataoggi()
//			k_data = date(year(relativedate(k_data,-90)), month(relativedate(k_data,-90)),01)
//
//		else
////--- prelevo il periodo da a 
//			//k_data_da = kst_treeview_data_any.st_tab_certif.data 
//			k_data = kst_treeview_data_any.st_tab_certif.data_stampa 
//	
//		end if

		if not isvalid(kids_certif_tree_stampati_xgiornomeseanno) then 
			kids_certif_tree_stampati_xgiornomeseanno = create datastore
			kids_certif_tree_stampati_xgiornomeseanno.dataobject = "ds_certif_tree_stampati_xgiornomeseanno"
			kids_certif_tree_stampati_xgiornomeseanno.settransobject(kguo_sqlca_db_magazzino) 
		end if

		k_nr_righe = kids_certif_tree_stampati_xgiornomeseanno.rowcount()
		if k_nr_righe > 0 then
			k_data = kst_treeview_data_any.st_tab_certif.data
			k_meseN = month(k_data)
			k_annoN = year(k_data)
			k_mese = string(k_meseN)
			k_anno = string(k_annoN)
			k_riga = kids_certif_tree_stampati_xgiornomeseanno.find( "anno = " + k_anno + " and mese = " +  k_mese , 0, k_nr_righe)
		end if

//--- Item totali
		kst_treeview_data.label = "[" + k_mese_desc[k_meseN] + "]" &
										  + "  " &
										  + k_anno 
		kst_tab_treeview.voce = kst_treeview_data.label
		kst_tab_treeview.id = "0"
		kst_tab_treeview.descrizione = "  ...conteggio in esecuzione..."
		kst_tab_treeview.descrizione_tipo = "Attestati " 
		kst_treeview_data.pic_list = k_pic_list
		kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
		kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
		kst_treeview_data_any.st_tab_certif = kst_tab_certif
		kst_treeview_data_any.st_tab_certif.data = date(k_annoN, k_meseN, 01)
		kst_treeview_data.struttura = kst_treeview_data_any
		kst_treeview_data.handle = k_handle_item_padre
		ktvi_treeviewitem.label = kst_treeview_data.label
		ktvi_treeviewitem.data = kst_treeview_data
//--- Nuovo Item
		ktvi_treeviewitem.selected = false
		k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
//--- salvo handle del item appena inserito nella stessa struttura
		kst_treeview_data.handle = k_handle_item
		k_handle_primo = k_handle_item
//--- inserisco il handle di questa riga tra i dati del item
		ktvi_treeviewitem.data = kst_treeview_data
		kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)


		if k_riga > 0 then

//--- find where the next group break is and get rownumber
			do while k_riga > 0

//--- get the value of the computed field at that row
				kst_treeview_data_any.contati = kids_certif_tree_stampati_xgiornomeseanno.getitemnumber(k_riga, "giorno_tot")
				k_giorno = kids_certif_tree_stampati_xgiornomeseanno.getitemnumber(k_riga, "giorno")
	
				k_totale = k_totale + kst_treeview_data_any.contati
				kst_tab_certif.data = date(k_annoN, k_meseN, k_giorno)
				kst_tab_certif.data_stampa = kst_tab_certif.data
				
				kst_treeview_data.label = &
											string(k_giorno) &
										  	+ " (" &
										  	+ k_giorno_desc[DayNumber(kst_tab_certif.data)]  &
										  	+ ")" 
											  
				kst_tab_treeview.voce = kst_treeview_data.label
				kst_tab_treeview.id = string(k_anno, "0000")  + string(k_mese, "00") + string(k_giorno, "00") 
				if kst_treeview_data_any.contati = 1 then
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  Attestato presente"
				else
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  Attestati presenti"
				end if

				kst_tab_treeview.descrizione_tipo = "Attestati " 
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data_any.st_tab_certif = kst_tab_certif
				kst_treeview_data.struttura = kst_treeview_data_any

				kst_treeview_data.handle = k_handle_item_padre
	
				ktvi_treeviewitem.label = kst_treeview_data.label
				ktvi_treeviewitem.data = kst_treeview_data
										  
//--- Nuovo Item
				ktvi_treeviewitem.selected = false
				k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
				
//--- salvo handle del item appena inserito nella stessa struttura
				kst_treeview_data.handle = k_handle_item

//--- inserisco il handle di questa riga tra i dati del item
				ktvi_treeviewitem.data = kst_treeview_data

				kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)


//--- find where the next group break is and get rownumber
				k_riga += 1
				k_riga = kids_certif_tree_stampati_xgiornomeseanno.find( "anno = " + k_anno + " and mese = " +  k_mese , k_riga, k_nr_righe)
	
			loop

//--- giro finale per totale mese
			if k_totale > 0 then
		
//--- Estrazione del primo Item, quello dei totali
				ktvi_treeviewitem.selected = false
				k_handle_item = kuf1_treeview.kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
				kst_treeview_data = ktvi_treeviewitem.data
				kst_treeview_data_any = kst_treeview_data.struttura
				kst_treeview_data_any.st_tab_certif.data = date(k_annoN, k_meseN, 01)
				k_data = relativedate(kst_treeview_data_any.st_tab_certif.data, +31) // data al mese successivo
				kst_treeview_data_any.st_tab_certif.data_stampa = relativedate(date(year(k_data), month(k_data), 01), -1) // si posiziona sull'ultimo gg del mese precedente
				kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
//--- Aggiorno il primo Item con i totali
				kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Attestati presenti"
				k_totale = 0
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data.struttura = kst_treeview_data_any
				ktvi_treeviewitem.data = kst_treeview_data
				k_handle_item = kuf1_treeview.kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
			end if
			
//			close kc_treeview;
			
		end if

	end if 
 
return k_return


end function

public function boolean set_flg_ristampa_xddt (st_tab_certif kst_tab_certif) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------
//--- Set campo flg_ristampa_xddt
//--- 
//--- Inp: st_tab_certif.id  
//--- Out:        
//--- Ritorna: TRUE = OK
//---           		
//--- Lancia EXCEPTION x errore
//--- 
//---------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())
	
if kst_tab_certif.id > 0 then

	kguo_sqlca_db_magazzino.db_commit( ) // x evitare forse problemi con TemporalTable faccio COMMIT

	kst_tab_certif.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_certif.x_utente = kGuf_data_base.prendi_x_utente()

	UPDATE certif  
		  SET flg_ristampa_xddt = :kst_tab_certif.flg_ristampa_xddt
			,x_datins = :kst_tab_certif.x_datins
			,x_utente = :kst_tab_certif.x_utente
		WHERE certif.id = :kst_tab_certif.id
		using kguo_sqlca_db_magazzino ;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in aggiornamento 'flag di Attestato stampato da Ufficio Spedizioni'. "&
					+ "Id: " + string(kst_tab_certif.id, "####0") + " "  + kkg.acapo &
					+ "Errore-tab.certif:" + string(kguo_sqlca_db_magazzino.SQLcode) + ' ' + trim(kguo_sqlca_db_magazzino.SQLErrText) 
		kst_esito.esito = kkg_esito.db_ko
	end if
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_certif.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	else
		if kst_tab_certif.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if

else
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Imposibile aggiornare il flag 'stampa da Ufficio Spedizioni' in tabella Attestati, Manca Identificativo (id) !" 
	kst_esito.esito = kkg_esito.no_esecuzione
			
end if	

k_return = true

return k_return

end function

public function boolean set_flg_ristampa_xddt_on (st_tab_certif kst_tab_certif) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------
//--- Set campo flg_ristampa_xddt a TRUE
//--- 
//--- Inp: st_tab_certif.id  
//--- Out:        
//--- Ritorna: TRUE = OK
//---           		
//--- Lancia EXCEPTION x errore
//--- 
//---------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
	

kst_tab_certif.flg_ristampa_xddt = true
k_return = set_flg_ristampa_xddt(kst_tab_certif)

return k_return

end function

public function boolean set_flg_ristampa_xddt_off (st_tab_certif kst_tab_certif) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------
//--- Set campo flg_ristampa_xddt a FALSE
//--- 
//--- Inp: st_tab_certif.id  
//--- Out:        
//--- Ritorna: TRUE = OK
//---           		
//--- Lancia EXCEPTION x errore
//--- 
//---------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
	

kst_tab_certif.flg_ristampa_xddt = false
k_return = set_flg_ristampa_xddt(kst_tab_certif)

return k_return

end function

public function boolean if_stampato_x_id_meca (ref st_tab_certif kst_tab_certif) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla se Attestato stampato 
//--- 
//--- 
//--- Inp: st_tab_certif.id_meca
//--- Out: TRUE = stampato definitivamente
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito



	kst_esito = kguo_exception.inizializza(this.classname())

//--- x ID certificato			
	SELECT top 1 id
			into :kst_tab_certif.id
			 FROM certif  
			 where  id_meca  = :kst_tab_certif.id_meca and data_stampa > '01.01.1990'
			 using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura Attestato (certif) per id Lotto '" + string(kst_tab_certif.id_meca) + "' " &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
									 
		kst_esito.esito = KKG_ESITO.db_ko
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		if kst_tab_certif.id > 0 then k_return = true
	end if
	

return k_return



end function

private function string get_nome_pdf (ref st_tab_certif ast_tab_certif) throws uo_exception;//
//--- Compone il nome del file 
//---
//--- input: st_tab_certif id, num_certif, data, id_meca; st_tab_meca.clie_2;
//--- Rit: nome file 
//---
//--- Lancia EXCEPTION
//---
string k_return
st_tab_clienti kst_tab_clienti
st_tab_meca kst_tab_meca
st_esito kst_esito
kuf_armo kuf1_armo
kuf_clienti kuf1_clienti


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	if ast_tab_certif.id > 0 and ast_tab_certif.id_meca > 0 then
		
		kuf1_clienti = create kuf_clienti
		kuf1_armo = create kuf_armo

		kst_tab_meca.id = ast_tab_certif.id_meca

		kst_tab_meca.e1doco = kuf1_armo.get_e1doco(kst_tab_meca)
		kst_tab_meca.e1rorn = kuf1_armo.get_e1rorn(kst_tab_meca)
		kst_tab_clienti.codice = ast_tab_certif.clie_2
		kst_tab_clienti.e1ancodrs = kuf1_clienti.get_e1ancodrs(kst_tab_clienti)

		k_return = "att" + string(ast_tab_certif.data, "yymmdd") + "_nr" + string(ast_tab_certif.num_certif, "#") &
		         + "_" + trim(kst_tab_clienti.e1ancodrs) + "_WO" + string(kst_tab_meca.e1doco) &
					+ "_SO" + string(kst_tab_meca.e1rorn) + "_id" + string(ast_tab_certif.id, "#") + ".pdf"

					
	end if		

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	
finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_clienti) then destroy kuf1_clienti
	
end try
			

return k_return

end function

public function long get_id_da_id_meca (ref st_tab_certif kst_tab_certif) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna il ID dal ID lotto
//--- 
//--- 
//--- Input: st_tab_certif.id_meca
//--- Out: st_tab_certif.id
//---
//--- Ritorna tab. st_tab_certif.id
//---
//----------------------------------------------------------------------------------------------------------------
//
st_esito kst_esito


kst_esito =	kguo_exception.inizializza(this.classname( ))

//--- x numero certificato			
	SELECT
				certif.id
			into
		         :kst_tab_certif.id  
			 FROM certif  
			 where 
						(id_meca  = :kst_tab_certif.id_meca)					     
				 using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_tab_certif.id = 0
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Attestato (certif) da ID Lotto = " + string(kst_tab_certif.id_meca) + " " &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
									 
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.set_esito(kst_esito)					
				throw kguo_exception
			end if
		end if
	end if
	
	if isnull(kst_tab_certif.id) then kst_tab_certif.id = 0

return kst_tab_certif.id


end function

public function date get_data (ref st_tab_certif kst_tab_certif) throws uo_exception;//
//====================================================================
//=== 
//=== Torna il Data del Certificato 
//=== 
//=== 
//--- Input: st_tab_certif.id
//---
//--- Ritorna tab. st_tab_certif.id
//---
//====================================================================
//
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()


	SELECT
				certif.data
				into
		         :kst_tab_certif.data
			 FROM certif  
			 where id  = :kst_tab_certif.id
				 using sqlca;
		
	if sqlca.sqlcode <> 0 then
		kst_tab_certif.data = date(0)
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in lettura Data dell'Attestato (CERTIF) id. =" &
						 + string(kst_tab_certif.id) + " " &
						 + "~n~rErrore: " + trim(SQLCA.SQLErrText)
									 
		if sqlca.sqlcode = 100 then
			kst_esito.esito = KKG_ESITO.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = KKG_ESITO.db_wrn
			else	
				kst_esito.esito = KKG_ESITO.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)					
				throw kguo_exception
			end if
		end if
	end if

	if isnull(kst_tab_certif.data) then kst_tab_certif.data = date(0)

return kst_tab_certif.data


end function

public function st_esito get_clie (ref st_tab_certif kst_tab_certif) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna il Codice Cliente dal ID Certificato
//--- 
//--- 
//--- Input: st_tab_certif.id
//--- Out: st_tab_certif.clie_2
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


//--- x numero certificato			
	SELECT
				certif.clie_2
			into
		         :kst_tab_certif.clie_2  
			 FROM certif  
			 where 
						(id  = :kst_tab_certif.id)					     
				 using sqlca;
		
	if sqlca.sqlcode <> 0 then
		kst_tab_certif.clie_2 = 0
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in lettura Cliente in Attestato (certif) id = '" + string(kst_tab_certif.id) + "'" &
									 + "~n~rErrore: " + trim(SQLCA.SQLErrText)
									 
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
	
	if isnull(kst_tab_certif.clie_2) then kst_tab_certif.clie_2 = 0

return kst_esito


end function

public subroutine u_db_crea_view_certif (string a_view_name, long a_id_meca) throws uo_exception;//
//--- crea View
//
int k_ctr
string k_view, k_sql
st_esito kst_esito


	k_view =  kguf_data_base.u_get_nometab_xutente(a_view_name)
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca, colli) AS   " &
	 + "  SELECT certif.id_meca, " &
	              + " certif.colli " &
	 + "    FROM certif  " &
	 + "   WHERE       " &
	 + "    certif.id_meca >= "  + string(a_id_meca) + "  "  

	kst_esito = kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
		kguo_exception.inizializza(this.classname())
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if

end subroutine

private function st_esito set_e1_wo_f5537001 (st_tab_certif kst_tab_certif) throws uo_exception;//
//---------------------------------------------------------------------------------
//--- Popola dati tabella di appoggio e1_wo_f5537001 per E1
//--- da lanciare dopo la "stampa_attestato"
//---
//--- Par. Input: st_tab_certif   
//--- 
//--- Ritorna tab. ST_ESITO, Esiti:    Vedi standard
//--- 
//---------------------------------------------------------------------------------
//
long k_ctr, k_ctr_max
long k_durata_lav_secondi
date k_datainizioanno
int k_giorniafter, k_anno, k_anno_rid
int k_rows, k_row, k_fila
st_esito kst_esito
st_tab_meca kst_tab_meca
st_tab_e1_wo_f5537001 kst_tab_e1_wo_f5537001
st_tab_barcode kst_tab_barcode, kst_tab_barcode_1[]
kuf_barcode kuf1_barcode
kuf_armo kuf1_armo
kuf_e1_wo_f5537001 kuf1_e1_wo_f5537001
kuf_e1 kuf1_e1
datastore kds_barcode_lane_nparents


try  

	kst_esito = kguo_exception.inizializza(this.classname())

//--- alimenta tabella dati trattamento da Inviare a E1
	if kguo_g.if_e1_enabled( ) then
		
		kuf1_e1_wo_f5537001 = create kuf_e1_wo_f5537001
		kuf1_barcode = create kuf_barcode
		kuf1_armo = create kuf_armo
		kuf1_e1 = create kuf_e1
		
		kds_barcode_lane_nparents = create datastore
		kds_barcode_lane_nparents.dataobject = "ds_barcode_lane_nparents"
		kds_barcode_lane_nparents.settransobject(kguo_sqlca_db_magazzino)
		
		kst_tab_meca.id = kst_tab_certif.id_meca
		kst_tab_e1_wo_f5537001.MPDOCO = kuf1_armo.get_e1doco(kst_tab_meca)
		if kst_tab_e1_wo_f5537001.MPDOCO > 0 then
			
			k_rows = kds_barcode_lane_nparents.retrieve(kst_tab_meca.id)
			
			for k_row = 1 to k_rows
			
				//work center
				if k_rows > 1 then
					kst_tab_e1_wo_f5537001.mpmmcu = kuf1_e1.kki_tcicli_mmcu_MISTO  // CICLI MISTI
				else
					if kds_barcode_lane_nparents.getitemstring(k_row, "lane") = "A" then
						kst_tab_e1_wo_f5537001.mpmmcu = kuf1_e1.kki_tcicli_mmcu_fila1  // FILA 1
					else
						kst_tab_e1_wo_f5537001.mpmmcu = kuf1_e1.kki_tcicli_mmcu_fila2  // FILA 2
					end if
				end if
				//lane
				if kds_barcode_lane_nparents.getitemstring(k_row, "lane") = "A" then
					k_fila = 1
					kst_tab_e1_wo_f5537001.mpaurst1 = kuf1_e1.kk1_lane_fila1
				else
					k_fila = 2
					kst_tab_e1_wo_f5537001.mpaurst1 = kuf1_e1.kk1_lane_fila2
				end if
				//n pallets
				kst_tab_e1_wo_f5537001.mpuorg = kds_barcode_lane_nparents.getitemnumber(k_row, "nbarcode")
				//n passes (n.giri per pallet)
				kst_tab_e1_wo_f5537001.mpmath06 = (kds_barcode_lane_nparents.getitemnumber(k_row, "fila_ncycle") / kds_barcode_lane_nparents.getitemnumber(k_row, "nbarcode"))
				//n parents (totale n. pallet meno i figli)
				kst_tab_e1_wo_f5537001.mpmath08 = (kds_barcode_lane_nparents.getitemnumber(k_row, "nbarcode") - kds_barcode_lane_nparents.getitemnumber(k_row, "n_barcode_lav"))
//--- set durata del trattamento							
				kst_tab_barcode.id_meca = kst_tab_meca.id
				k_durata_lav_secondi = kuf1_barcode.get_durata_lav_xfila(kst_tab_barcode, k_fila) //durata lavorazione del singolo barcode x fila 1 o 2
				kst_tab_e1_wo_f5537001.mpmath07 = k_durata_lav_secondi

				kuf1_e1_wo_f5537001.set_datilav_f5537001(kst_tab_e1_wo_f5537001)  // registra i dati su tb di scambio con E-ONE
			next			
		end if
	end if

		
catch (uo_exception kuo_exception1)
	kst_esito = kuo_exception1.get_st_esito( )
	kst_esito.sqlerrtext = "Problemi in aggiornamento dati Attestato per E1 (set_e1_wo_f5537001)~n~r" + trim(kst_esito.sqlerrtext)
	
finally
	if isvalid(kuf1_e1_wo_f5537001) then destroy kuf1_e1_wo_f5537001
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	if isvalid(kuf1_e1) then destroy kuf1_e1
	if isvalid(kds_barcode_lane_nparents) then destroy(kds_barcode_lane_nparents)
	
	
end try
			

return kst_esito

end function

private subroutine crea_certif_set_note (ref st_tab_certif kst_tab_certif) throws uo_exception;//
//=== 
//====================================================================
//=== Compone i dati dell' Attestato di Trattamento
//===
//=== Par. Inp: st_tab_certif il Numero di certificato
//===      Out: st_tab_certif con l'area valorizzata
//=== 
//=== Per errore lancia EXCEPTION
//=== 
//====================================================================
//
boolean k_cursor_CURS_CERT_1_2 = false
int k_len_max
st_esito kst_esito
st_tab_armo kst_tab_armo
st_tab_armo_nt kst_tab_armo_nt
constant string kk_descr_operazione = "durante la generazione dell'Attestato" //~n~r"


try


	kst_esito = kguo_exception.inizializza(this.classname())


	declare CURS_CERT_1_2 cursor for
		select   distinct
					armo.id_armo,
					coalesce(rtrim(ARMO.NOTE_1), '')
					+ coalesce(rtrim(ARMO.NOTE_2), '')
					+ coalesce(rtrim(ARMO.NOTE_3), '') note
					,coalesce(rtrim(ARMO_NT.NOTE_1), '')
					+ coalesce(rtrim(ARMO_NT.NOTE_2), '')
					+ coalesce(rtrim(ARMO_NT.NOTE_3), '')
					+ coalesce(rtrim(ARMO_NT.NOTE_4), '')
					+ coalesce(rtrim(ARMO_NT.NOTE_5), '')
					+ coalesce(rtrim(ARMO_NT.NOTE_6), '')
					+ coalesce(rtrim(ARMO_NT.NOTE_7), '')
					+ coalesce(rtrim(ARMO_NT.NOTE_8), '')
					+ coalesce(rtrim(ARMO_NT.NOTE_9), '')
					+ coalesce(rtrim(ARMO_NT.NOTE_10), '') nt_note
			from artr inner join armo on
				  artr.id_armo = armo.id_armo
						 left outer join armo_nt on
				  armo.id_armo = armo_nt.id_armo
			 where
					ARTR.num_certif    = :kst_tab_certif.num_certif 
			 order by armo.ID_ARMO
			 using kguo_sqlca_db_magazzino;

//--- Carica NOTE
	open CURS_CERT_1_2;
	if sqlca.sqlcode <> 0 then		
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in apertura tabella Note riga Lotto " + kk_descr_operazione &
										+ ". (" + trim(SQLCA.SQLErrText) + ")"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if		

	k_cursor_CURS_CERT_1_2 = true	
				
	kst_tab_certif.note = ""
	kst_tab_certif.note_1 = ""
	kst_tab_certif.note_2 = ""
	fetch CURS_CERT_1_2 into :kst_tab_armo.id_armo,
									 :kst_tab_armo.note_1,
									 :kst_tab_armo_nt.note[1];
	if sqlca.sqlcode < 0 then		
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore inizio lettura tabella Note riga Lotto " + kk_descr_operazione &
										+ ". (" + trim(SQLCA.SQLErrText) + ")"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if		

	do while kguo_sqlca_db_magazzino.sqlcode = 0 
					
		if kst_tab_armo.note_1 > " " then
			kst_tab_certif.note += kst_tab_armo.note_1
		end if
		if kst_tab_armo_nt.note[1] > " " then
			kst_tab_certif.note_2 += kst_tab_armo_nt.note[1]
		end if
					
		fetch CURS_CERT_1_2 into :kst_tab_armo.id_armo,
										 :kst_tab_armo.note_1,
										 :kst_tab_armo_nt.note[1];
	
	loop 
	if sqlca.sqlcode < 0 then		
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in lettura altre Note riga Lotto " + kk_descr_operazione &
										+ ". (" + trim(SQLCA.SQLErrText) + ")"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if		
	
	//verifica le lunghezza massima della colonna su db
	k_len_max = kguo_sqlca_db_magazzino.u_get_col_len( "certif", "note") 
	if len(kst_tab_certif.note) > k_len_max then
		kst_tab_certif.note = left(kst_tab_certif.note, k_len_max)  // tronca se troppo lungo pr il DB
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if k_cursor_CURS_CERT_1_2 then
		close CURS_CERT_1_2;
	end if


end try 




end subroutine

private subroutine crea_certif_update (ref st_tab_certif kst_tab_certif) throws uo_exception;//
//=== 
//====================================================================
//=== Crea / Aggiorna Attestato di Trattamento
//===
//=== Par. Inut: Numero di certificato
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   Vedi standard
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
int k_ctr
st_esito kst_esito, kst1_esito
st_tab_meca kst_tab_meca 
st_tab_certif kst_tab_certif_1


try

//--- inizializza aree
	kst_esito = kguo_exception.inizializza(this.classname())
	
//--- Controllo se Attestato già caricato
	select  id
				 ,ST_DOSE_MIN
				 ,ST_DOSE_MAX
				 ,ST_DATA_INI
				 ,ST_DATA_FIN
				 ,DATA
				 ,dose_min
				 ,dose_max
			into 		:kst_tab_certif.id
						,:kst_tab_certif_1.ST_DOSE_MIN 
						,:kst_tab_certif_1.ST_DOSE_MAX 
						,:kst_tab_certif_1.ST_DATA_INI 
						,:kst_tab_certif_1.ST_DATA_FIN 
						,:kst_tab_certif_1.DATA 
						,:kst_tab_certif_1.dose_min
						,:kst_tab_certif_1.dose_max
			from certif
			 where num_certif = :kst_tab_certif.num_certif 
			using sqlca; 


	if sqlca.sqlcode = 100 then   // se ATTESTATO NUOVO lo carica in tabella

		if not isvalid(kiuf_certif_print) then kiuf_certif_print = create kuf_certif_print 

////--- Decide quale form dell'Attesto utilizzare (Gold/Silver/...)
//		if not kiuf_certif_print.set_attestato(kst_tab_certif) then
//			kst_esito.sqlcode = 0
//			kst_esito.SQLErrText = "Preparazione Attestato: fallita associazione layout di stampa n.: "+ string(kst_tab_certif.num_certif) //+ "~n~r"&
//			kst_esito.esito = kkg_esito.ko
//			kguo_exception.inizializza( )
//			kguo_exception.set_esito(kst_esito)
//			throw kguo_exception
//		end if
//		if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then

			kst_tab_certif.form_di_stampa = trim(kiuf_certif_print.get_form_di_stampa_now())
		
//--- INSERT dell'attestato in tabella
			kst_tab_certif.st_tab_g_0.esegui_commit = "S"
			kst_esito = tb_add(kst_tab_certif)
			if kst_esito.esito <> kkg_esito.ok then
				kst_esito.SQLErrText = "Preparazione Attestato: errore in generazione n.: " + string(kst_tab_certif.num_certif) + "~n~r" + "(" + trim(SQLCA.SQLErrText) + ")"
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			
//		end if
	else
		
//--- AGGIORNA attestato in tabella
		if sqlca.sqlcode = 0 then 
			
//--- Alcuni dati non possono essere modificati in questa fase se già esistente
			if len(kst_tab_certif_1.ST_DOSE_MIN) > 0 then
				kst_tab_certif.ST_DOSE_MIN = kst_tab_certif_1.ST_DOSE_MIN	
			end if
			if len(kst_tab_certif_1.ST_DOSE_MAX) > 0 then
				kst_tab_certif.ST_DOSE_MAX = kst_tab_certif_1.ST_DOSE_MAX	
			end if
			if len(kst_tab_certif_1.ST_DATA_INI) > 0 then
				kst_tab_certif.ST_DATA_INI = kst_tab_certif_1.ST_DATA_INI	
			end if
			if len(kst_tab_certif_1.ST_DATA_FIN) > 0 then
				kst_tab_certif.ST_DATA_FIN = kst_tab_certif_1.ST_DATA_FIN	
			end if
			if kst_tab_certif_1.dose_min > 0 then
				kst_tab_certif.dose_min = kst_tab_certif_1.dose_min	
			end if
			if kst_tab_certif_1.dose_max > 0 then
				kst_tab_certif.dose_max = kst_tab_certif_1.dose_max	
			end if
//22122015 x la data esposta in stampa: tolto aggiornamento ma reintrodotto il 26122023 su richiesta di Rezio:
			if kst_tab_certif_1.DATA > kkg.DATA_NO then
				kst_tab_certif.DATA = kst_tab_certif_1.DATA	
			end if
			
			kst_tab_certif.st_tab_g_0.esegui_commit = "S"
			kst_esito = tb_aggiorna(kst_tab_certif)
			if kst_esito.esito <> kkg_esito.ok then
				kst_esito.SQLErrText = "Preparazione Attestato: errore in aggiornamento n.: " + string(kst_tab_certif.num_certif) + "~n~r" + "(" + trim(SQLCA.SQLErrText) + ")"
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Preparazione Attestato: errore in Lettura archivio n.: " + string(kst_tab_certif.num_certif) + "~n~r" + "(" + trim(SQLCA.SQLErrText) + ")"
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception


finally

end try 



end subroutine

public subroutine crea_certif_set_st_tab_certif (ref st_tab_certif kst_tab_certif) throws uo_exception;//
//=== 
//====================================================================
//=== Compone i dati dell' Attestato di Trattamento
//===
//=== Par. Inp: st_tab_certif il Numero di certificato
//===      Out: st_tab_certif con l'area valorizzata
//=== 
//=== Per errore lancia EXCEPTION
//=== 
//====================================================================
//
boolean k_cursor_CURS_CERT_1_1 = false
boolean k_cursor_crea_certif_amo = false	
boolean k_maxfattcorr_attivo = false
int k_len_max
st_esito kst_esito, kst1_esito
st_tab_meca kst_tab_meca 
st_tab_armo kst_tab_armo
st_tab_armo_nt kst_tab_armo_nt
st_tab_certif kst_tab_certif_1
st_tab_meca_dosim kst_tab_meca_dosim
st_tab_sl_pt kst_tab_sl_pt_MIN, kst_tab_sl_pt_MAX
kuf_meca_dosim kuf1_meca_dosim
//kuf_sl_pt kuf1_sl_pt
constant string kk_descr_operazione = "durante la generazione dell'Attestato" //~n~r"


try

//--- inizializza aree
	kguo_exception.inizializza(this.classname())
	kguo_exception.kist_esito.st_tab_g_0 = kst_tab_certif.st_tab_g_0 

	if kst_tab_certif.NUM_CERTIF > 0 then
	else
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.SQLErrText = "Manca il numero Attestato " + kk_descr_operazione + ". Operazione interrotta."
		throw kguo_exception
	end if

	kuf1_meca_dosim = create kuf_meca_dosim
	//kuf1_sl_pt = create kuf_sl_pt
	//kuf1_wm_pklist_testa = create kuf_wm_pklist_testa
	
//--- se tutto ok, proseguo
	declare CURS_CERT_1_1 cursor for
		  select ARTR.NUM_CERTIF,
				   MECA.NUM_INT,
				   MECA.DATA_INT,
					trim(MAX(armo.cod_sl_pt)),
					min(ARTR.DATA_IN),
					max(ARTR.DATA_FIN),
					sum(ARTR.COLLI),
					max(isnull(ARTR.impianto,2)),
					MECA.ID,
					MECA.NUM_BOLLA_IN,
					MECA.DATA_BOLLA_IN,
					MECA.CLIE_1,
					MECA.CLIE_2,
					MECA.CLIE_3,
					MECA.CONTRATTO, 
					cert_forza_stampa
					,MECA.id_wm_pklist
				from artr inner join armo on artr.id_armo = armo.id_armo
							 inner join MECA on ARMO.id_meca = MECA.id  
				where ARTR.num_certif = :kst_tab_certif.num_certif 
				group by
						ARTR.NUM_CERTIF,
						MECA.NUM_INT,
						MECA.DATA_INT,
						MECA.ID,
						MECA.NUM_BOLLA_IN,
						MECA.DATA_BOLLA_IN,
						MECA.CLIE_1,
						MECA.CLIE_2,
						MECA.CLIE_3,
						MECA.CONTRATTO, 
						cert_forza_stampa
					   ,MECA.id_wm_pklist
				using kguo_sqlca_db_magazzino; 
	
	open CURS_CERT_1_1;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then 
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
					"Errore in accesso ai dati di Lavorazione Lotto " + kk_descr_operazione + ". N. attestato " + string(kst_tab_certif.num_certif))
		throw kguo_exception
	end if

	k_cursor_CURS_CERT_1_1 = true	

//--- leggo dati caratteristici del certificato
	fetch CURS_CERT_1_1    into :kst_tab_certif.NUM_CERTIF,
										 :kst_tab_meca.NUM_INT,
										 :kst_tab_meca.DATA_INT,
										 :kst_tab_armo.cod_sl_pt,
										 :kst_tab_certif.lav_data_ini,
										 :kst_tab_certif.lav_data_fin,
										 :kst_tab_certif.colli,
										 :kst_tab_certif.impianto,
										 :kst_tab_certif.id_meca,
										 :kst_tab_meca.NUM_BOLLA_IN,
										 :kst_tab_meca.DATA_BOLLA_IN,
										 :kst_tab_meca.CLIE_1,
										 :kst_tab_certif.CLIE_2,
										 :kst_tab_meca.CLIE_3,
										 :kst_tab_meca.CONTRATTO,
										 :kst_tab_meca.cert_forza_stampa
										 ,:kst_tab_meca.id_wm_pklist;

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then						 
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
						"Errore in lettura dati di Lavorazione Lotto " + kk_descr_operazione + ". N. attestato " + string(kst_tab_certif.num_certif))
		throw kguo_exception
	end if
			
//--- controllo + dosi presenti per lo stesso certificato				
	declare crea_certif_amo cursor for
			select distinct armo.dose
					from artr inner join armo on
						  artr.id_armo = armo.id_armo
					where 
							ARTR.num_certif = :kst_tab_certif.num_certif   
					using kguo_sqlca_db_magazzino; 

	open crea_certif_amo;
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then		
		
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
						"Errore in accesso dati riga di Entrata Lotto " + kk_descr_operazione + ". N. attestato " + string(kst_tab_certif.num_certif))
		throw kguo_exception

	end if		
	
	k_cursor_crea_certif_amo = true	
	fetch crea_certif_amo into :kst_tab_certif.dose;
	if kguo_sqlca_db_magazzino.sqlcode = 0 then						 
		if kst_tab_meca.cert_forza_stampa <> '1' then 
			fetch crea_certif_amo into :kst_tab_armo.dose;

//--- situazione ambigua, + dosi presenti, non so quale dose pigliare						
			if kguo_sqlca_db_magazzino.sqlcode = 0 then	
				kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
							"Attenzione operazione bloccata " + kk_descr_operazione + ". " &
							+ kkg.acapo + "L'attestato " + string(kst_tab_certif.num_certif) &
							+ " contiene Pianificazioni per DOSI diverse. " &
							+ kkg.acapo + "Prima di proseguire è necessario fare il 'Forza Stampa Attestato'.")
				kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_internal_bug
				throw kguo_exception
			end if
		end if
	end if

//--- Get delle NOTE 
	crea_certif_set_note(kst_tab_certif)

//--- Get dei flag che indicano alcuni dati mettere in stampa 
	crea_certif_get_dati_x_st(kst_tab_certif, kst_tab_meca, kst_tab_armo)

//--- Verifica dose MIN-MAX 
	crea_certif_verifica_dosi(kst_tab_certif, kuf1_meca_dosim, kst_tab_armo)
	
////--- Leggo Dati Contratto Capitolato Fornitura
//	if isnull(kst_tab_meca.CONTRATTO) or kst_tab_meca.CONTRATTO = 0 then
//		kst_tab_meca.CONTRATTO = 0
//	end if
//	kst_tab_certif.ST_DOSE_MIN = "N"
//	kst_tab_certif.ST_DOSE_MAX = "N"
//	kst_tab_certif.ST_DATA_INI = "N"
//	kst_tab_certif.ST_DATA_FIN = "N"
//	kst_tab_certif.ST_DATI_BOLLA_IN = "N"
//	kst_tab_certif.DOSE_MIN = 0.00
//	kst_tab_certif.DOSE_MAX = 0.00
//
//	if trim(kst_tab_armo.cod_sl_pt) > " " then
//		select  distinct
//						  sl_pt.CERT_ST_DOSE_MIN
//						 ,sl_pt.CERT_ST_DOSE_MAX
//						 ,sl_pt.CERT_ST_DATA_INI
//						 ,sl_pt.CERT_ST_DATA_FIN
//						 into
//							:kst_tab_certif.ST_DOSE_MIN 
//							,:kst_tab_certif.ST_DOSE_MAX 
//							,:kst_tab_certif.ST_DATA_INI 
//							,:kst_tab_certif.ST_DATA_FIN 
//						from sl_pt
//						 where
//							sl_pt.cod_sl_pt = :kst_tab_armo.cod_sl_pt 
//						using kguo_sqlca_db_magazzino;
//	end if
//	if kst_tab_meca.CONTRATTO > 0 then
//		select distinct 
//						 CONTRATTI.CERT_ST_DATI_BOLLA_IN
//						 into
//							:kst_tab_certif.ST_DATI_BOLLA_IN 
//						from CONTRATTI
//						 where
//							CONTRATTI.CODICE = :kst_tab_meca.CONTRATTO 
//						using kguo_sqlca_db_magazzino;
//	end if
//	if kguo_sqlca_db_magazzino.sqlcode <> 0 then		
//		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
//						"Errore in lettura delle Indicazioni dei Dati da Esporre " + kk_descr_operazione + ". N. attestato " + string(kst_tab_certif.num_certif))
//		throw kguo_exception
//	end if
//	
////--- Dose MINIMA letta (corretto con eventuale fattore di correzione)
//	kst_tab_sl_pt_MIN.cod_sl_pt = kst_tab_armo.cod_sl_pt
//	kuf1_sl_pt.get_dosetgminfattcorr_ifattivo(kst_tab_sl_pt_MIN)    // get fattore correzione x il minimo
//	kst_tab_meca_dosim.id_meca = kst_tab_certif.id_meca
//	kuf1_meca_dosim.get_dosim_dose_min(kst_tab_meca_dosim) // get dose minima del lotto
//	kst_tab_certif.DOSE_MIN = kst_tab_meca_dosim.dosim_dose * kst_tab_sl_pt_MIN.dosetgminfattcorr 
//	kst_tab_certif.DOSE_MIN = Round(kst_tab_certif.DOSE_MIN, 1) // arrotonda a 1 decimale come standard E1
//	
////--- Dose MASSIMA letta (corretto con eventuale fattore di correzione)
//	kst_tab_sl_pt_MAX.cod_sl_pt = kst_tab_armo.cod_sl_pt
//	k_maxfattcorr_attivo = kuf1_sl_pt.get_dosetgmaxfattcorr_ifattivo(kst_tab_sl_pt_MAX)  // get fattore correzione x il massimo
////19-07-2016 su richiesta di REZIO set DOSE MINIMA al posto della MASSIMA se il FATTORE di CORREZIONE MAX è > zero!!!!!!!
//	kst_tab_meca_dosim.id_meca = kst_tab_certif.id_meca
//	//if kst_tab_sl_pt_MAX.dosetgmaxfattcorr = 1.00 or kst_tab_sl_pt_MAX.dosetgmaxfattcorr = 0.00 then
//	if not k_maxfattcorr_attivo or kst_tab_sl_pt_MAX.dosetgmaxfattcorr = 0.00 then
//		kuf1_meca_dosim.get_dosim_dose_max(kst_tab_meca_dosim)  // get dose max (tra le massime inserite) del lotto
//		kst_tab_certif.DOSE_MAX = kst_tab_meca_dosim.dosim_dose
//	else
//		kuf1_meca_dosim.get_dosim_dosemax_min(kst_tab_meca_dosim)  // get dose max (tra le minime inserite) del lotto  10-4-2017
////		kuf1_meca_dosim.get_dosim_dose_min(kst_tab_meca_dosim) // get dose minima del lotto  19-07-2016
//		kst_tab_certif.DOSE_MAX = kst_tab_meca_dosim.dosim_dose * kst_tab_sl_pt_MAX.dosetgmaxfattcorr 
//	end if
//	kst_tab_certif.DOSE_MAX = Round(kst_tab_certif.DOSE_MAX, 1) // arrotonda a 1 decimale come standard E1
//										
////--- Acchiappo dose minima e max dal SL-PT se necessario
//	if kst_tab_certif.DOSE_MIN > 0 and kst_tab_certif.DOSE_MAX > 0 then
//	else
//		select (SL_PT.DOSE_MIN), (SL_PT.DOSE_MAX)
//				into :kst_tab_sl_pt_MIN.dose, :kst_tab_sl_pt_MAX.dose	
//				 from sl_pt
//				 where sl_pt .cod_sl_pt = :kst_tab_armo.cod_sl_pt
//				using kguo_sqlca_db_magazzino;	
//
//		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
//			kst_tab_sl_pt_MIN.DOSE = 0.00
//			kst_tab_sl_pt_MAX.DOSE = 0.00
//		end if
//		if kst_tab_sl_pt_MIN.DOSE > 0 and kst_tab_certif.DOSE_MIN = 0.00 then
//			kst_tab_certif.DOSE_MIN = kst_tab_sl_pt_MIN.DOSE 
//		end if
//		if kst_tab_sl_pt_MAX.DOSE > 0 and kst_tab_certif.DOSE_MAX = 0.00 then
//			kst_tab_certif.DOSE_MAX = kst_tab_sl_pt_MAX.DOSE 
//		end if
//	end if  
	
//--- Get della data del CERTIFICATO da stampare
	kst_tab_meca_dosim.id_meca = kst_tab_certif.id_meca
	kst_tab_meca_dosim.dosim_data_ora = kuf1_meca_dosim.get_data_x_certif(kst_tab_meca_dosim)
	if kst_tab_meca_dosim.dosim_data_ora > datetime(date(0)) then
		kst_tab_certif.data = date(kst_tab_meca_dosim.dosim_data_ora)
		kst_tab_certif.ora = time(kst_tab_meca_dosim.dosim_data_ora)
	else
		kst_tab_certif.data = date(kGuf_data_base.prendi_x_datins()) //kguo_g.get_dataoggi( ) //se proprio non trova la DATA allora ci mette la data-oggi
		kst_tab_certif.ora = time(kGuf_data_base.prendi_x_datins())
	end if


catch (uo_exception kuo_exception)
//	kst_esito = kuo_exception.get_st_esito()
//	kst_esito.sqlerrtext = "Preparazione dati Attestato n. " + string(kst_tab_certif.num_certif) + ": " + kst_esito.sqlerrtext
//	kGuf_data_base.errori_scrivi_esito("W", kst_esito) 
//	kuo_exception.set_esito(kst_esito)
	kuo_exception.scrivi_log()
	throw kuo_exception

finally
	if k_cursor_crea_certif_amo then
		close crea_certif_amo;
	end if
	if k_cursor_CURS_CERT_1_1 then
		close CURS_CERT_1_1;
	end if

	if isvalid(kuf1_meca_dosim) then destroy kuf1_meca_dosim
	//if isvalid(kuf1_sl_pt) then destroy kuf1_sl_pt

end try 




end subroutine

public function long get_id_meca_da_id (ref st_tab_certif kst_tab_certif) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna il ID_MECA del Certificato da ID
//--- 
//--- 
//--- Input: st_tab_certif.id
//--- Out: st_tab_certif.id_meca
//--- Ritorna: id_meca
//---
//--- Lancia EXCEPTION
//---
//---------------------------------------------------------------------------------------------------------------------------
long k_return 
st_esito kst_esito



	kst_esito = kguo_exception.inizializza(this.classname())

	SELECT
				certif.id_meca
			into
		         :kst_tab_certif.id_meca  
			FROM certif  
			where 
			    id  = :kst_tab_certif.id
				 using  kguo_sqlca_db_magazzino ;
		
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_certif.id_meca > 0 then
			k_return = kst_tab_certif.id_meca
		end if

	else
		kst_tab_certif.id_meca = 0
		
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in ricerca ID Lotto nella Tab. Attestati (CERTIF) id = " &
						 + string(kst_tab_certif.id) + " " &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
									 
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = KKG_ESITO.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
	end if
	

return k_return


end function

public function long get_num_certif (ref st_tab_certif kst_tab_certif) throws uo_exception;/*
  Torna il Numero del Certificato da ID_MECA
  Inp: st_tab_certif.id_meca
  Rit: numero attestato
*/
long k_return 


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
//--- x numero certificato			
	SELECT certif.num_certif
		into :kst_tab_certif.num_certif  
		FROM certif  
		where id_meca  = :kst_tab_certif.id_meca
		using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
					"Errore in lettura del Numero Attestato per Id Lotto " + string(kst_tab_certif.id_meca))
		throw kguo_exception
	end if

	if kst_tab_certif.num_certif > 0 then
		k_return = kst_tab_certif.num_certif
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	if kst_tab_certif.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_certif.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return 


end function

public function boolean if_stampato (readonly st_tab_certif ast_tab_certif) throws uo_exception;/*
 Controlla se Attestato stampato da id
	 Inp: st_tab_certif.id
	 Out: TRUE = stampato definitivamente
*/
boolean k_return 
st_tab_certif kst_tab_certif


	kguo_exception.inizializza(this.classname())

	kst_tab_certif = ast_tab_certif
	if this.get_data_stampa(kst_tab_certif) > kkg.data_no then
		k_return = true
	end if

return k_return



end function

public function date get_data_stampa (ref st_tab_certif ast_tab_certif) throws uo_exception;/*
 Torna DATA e ORA di STAMPA del Certificato
	 Inp: st_tab_certif.num_certif
	 Out: st_tab_certif.data_stampa, ora_stampa
	 Rit: data stampa
*/
date k_return 


	kguo_exception.inizializza(this.classname())

//--- x numero certificato			
	SELECT
				certif.data_stampa
				,certif.ora_stampa
			into
		       :ast_tab_certif.data_stampa  
				,:ast_tab_certif.ora_stampa
			FROM certif  
			where 
			    num_certif  = :ast_tab_certif.num_certif
				 using  kguo_sqlca_db_magazzino ;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
							"Errore in ricerca Data Stampa Attestato n. " + string(ast_tab_certif.num_certif))		
			throw kguo_exception
	end if			
	
	if ast_tab_certif.data > date(0) then
		k_return = ast_tab_certif.data
	else
		k_return = date(0)
	end if
	if ast_tab_certif.data > date(0) then
		k_return = ast_tab_certif.data
	else
		k_return = date(0)
	end if
	

return k_return


end function

private subroutine crea_certif_verifica_dosi (ref st_tab_certif ast_tab_certif, ref kuf_meca_dosim auf1_meca_dosim, readonly st_tab_armo ast_tab_armo) throws uo_exception;/*
  Generazione Attestato: Verifica DOSE Minima-Massima come indicato nel PT
 		Inp: st_tab_certif il Numero di certificato
		     ...
  		Out: st_tab_certif con l'area valorizzata
*/
boolean k_minMINfattcorr_attivo
boolean k_maxMINfattcorr_attivo
boolean k_minMAXfattcorr_attivo
boolean k_maxMAXfattcorr_attivo
st_tab_meca_dosim kst_tab_meca_dosim
st_tab_certif kst_tab_certif_MAX
st_tab_sl_pt kst_tab_sl_pt
kuf_sl_pt kuf1_sl_pt
constant string kk_descr_operazione = "durante la generazione dell'Attestato" //~n~r"


try
	kuf1_sl_pt = create kuf_sl_pt

	ast_tab_certif.DOSE_MIN = 0.00
	ast_tab_certif.DOSE_MAX = 0.00
	kst_tab_certif_MAX.DOSE_MIN = 0.00
	kst_tab_certif_MAX.DOSE_MAX = 0.00

	kst_tab_meca_dosim.id_meca = ast_tab_certif.id_meca
	
//--- Dose MINIMA letta tra i Minimi (corretto con eventuale fattore di correzione)
	kst_tab_sl_pt.impianto = ast_tab_certif.impianto
	kst_tab_sl_pt.cod_sl_pt = ast_tab_armo.cod_sl_pt
	k_minMINfattcorr_attivo = kuf1_sl_pt.get_dosetgminfattcorr_ifattivo(kst_tab_sl_pt)    // get fattore correzione x il minimo tra i Minimi
//--- Dose MASSIMA letta tra i Minimi (corretto con eventuale fattore di correzione)
	kst_tab_sl_pt.impianto = ast_tab_certif.impianto
	kst_tab_sl_pt.cod_sl_pt = ast_tab_armo.cod_sl_pt
	k_maxMINfattcorr_attivo = kuf1_sl_pt.get_dosetgmaxfattcorr_ifattivo(kst_tab_sl_pt)  // get fattore correzione x il Massimo tra i Minimi
//--- Dose MINIMA letta tra i Massimi (corretto con eventuale fattore di correzione)
	kst_tab_sl_pt.impianto = ast_tab_certif.impianto
	kst_tab_sl_pt.cod_sl_pt = ast_tab_armo.cod_sl_pt
	k_minMAXfattcorr_attivo = kuf1_sl_pt.get_dosetgminfattcorr_MAX_ifattivo(kst_tab_sl_pt) 	   // get fattore correzione x il minimo tra i Massimi
//--- Dose MASSIMA letta tra i Massimi (corretto con eventuale fattore di correzione)
	kst_tab_sl_pt.impianto = ast_tab_certif.impianto
	kst_tab_sl_pt.cod_sl_pt = ast_tab_armo.cod_sl_pt
	k_maxMAXfattcorr_attivo = kuf1_sl_pt.get_dosetgmaxfattcorr_MAX_ifattivo(kst_tab_sl_pt) 		 // get fattore correzione x il Massimo tra il Massimo

//--- get delle DOSI caricare nei DOSIMETRI
	auf1_meca_dosim.get_dosim_dose_min(kst_tab_meca_dosim) 			  // get dose minima del lotto tra le Minime
	ast_tab_certif.DOSE_MIN = kst_tab_meca_dosim.dosim_dose

	auf1_meca_dosim.get_dosim_dose_max(kst_tab_meca_dosim) 			  // get dose massima del lotto tra le Minime
	ast_tab_certif.DOSE_MAX = kst_tab_meca_dosim.dosim_dose

	auf1_meca_dosim.get_dosim_dose_min_MAX(kst_tab_meca_dosim) 		  // get dose minima del lotto tra le Massime
	kst_tab_certif_MAX.DOSE_MIN = kst_tab_meca_dosim.dosim_dose 

	auf1_meca_dosim.get_dosim_dose_max_MAX(kst_tab_meca_dosim) 		 // get dose massima del lotto tra le Massime
	kst_tab_certif_MAX.DOSE_MAX = kst_tab_meca_dosim.dosim_dose

//--- Acchiappo dose minima e max dal PIANO 
	kuf1_sl_pt.get_dose_min_max(kst_tab_sl_pt)    

//--- Imposta la DOSE MINIMA su Attestato
	choose case true 
		case k_minMINfattcorr_attivo and ast_tab_certif.DOSE_MIN > 0
			ast_tab_certif.DOSE_MIN = Round(ast_tab_certif.DOSE_MIN * kst_tab_sl_pt.dosetgminfattcorr, 1) 
		case ast_tab_certif.DOSE_MIN > 0
			ast_tab_certif.DOSE_MIN = Round(ast_tab_certif.DOSE_MIN, 1) 
		case else
			if k_minMAXfattcorr_attivo and kst_tab_certif_MAX.DOSE_MIN > 0 then
				ast_tab_certif.DOSE_MIN = Round(kst_tab_certif_MAX.DOSE_MIN * kst_tab_sl_pt.dosetgminfattcorr_MAX, 1) 
			end if
	end choose

//--- Imposta la DOSE MASSIMA su Attestato
	choose case true
		case k_maxMAXfattcorr_attivo and kst_tab_certif_MAX.DOSE_MAX > 0
			ast_tab_certif.DOSE_MAX = Round(kst_tab_certif_MAX.DOSE_MAX * kst_tab_sl_pt.dosetgmaxfattcorr_MAX, 1) 
		case kst_tab_certif_MAX.DOSE_MAX > 0
			ast_tab_certif.DOSE_MAX = Round(kst_tab_certif_MAX.DOSE_MAX, 1) 
		case else
			if k_maxMINfattcorr_attivo then
				if ast_tab_certif.DOSE_MAX > 0 then
					ast_tab_certif.DOSE_MAX = Round(ast_tab_certif.DOSE_MAX * kst_tab_sl_pt.dosetgmaxfattcorr, 1) 
				end if
			else
				ast_tab_certif.DOSE_MAX = Round(kst_tab_sl_pt.dose_max, 1) 
			end if
	end choose
										
//--- Se ancota tutto a zero metto dose minima e max dal SL-PT 
	if ast_tab_certif.DOSE_MIN > 0 and ast_tab_certif.DOSE_MAX > 0 then
	else
		if kst_tab_sl_pt.dose_min > 0 and ast_tab_certif.DOSE_MIN = 0.00 then
			ast_tab_certif.DOSE_MIN = kst_tab_sl_pt.dose_min
		end if
		if kst_tab_sl_pt.dose_max > 0 and ast_tab_certif.DOSE_MAX = 0.00 then
			ast_tab_certif.DOSE_MAX = kst_tab_sl_pt.dose_max 
		end if
	end if  
	

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_sl_pt) then destroy kuf1_sl_pt

end try 




end subroutine

private subroutine crea_certif_get_dati_x_st (ref st_tab_certif ast_tab_certif, ref st_tab_meca ast_tab_meca, ref st_tab_armo ast_tab_armo) throws uo_exception;/*
  Generazione Attestato: recupera i dati da metetre in stampa
 		Inp: st_tab_certif il Numero di certificato
		     st_tab_meca.CONTRATTO
			  st_tab_armo.cod_sl_pt
  		Out: st_tab_certif con l'area valorizzata con i dati ST_....
*/
constant string kk_descr_operazione = "durante la generazione dell'Attestato" //~n~r"


try

//--- Leggo Indicazione Dati PT e Contratto da mettere in Stampa

	if trim(ast_tab_armo.cod_sl_pt) > " " then
		select  distinct
						  isnull(sl_pt.CERT_ST_DOSE_MIN, 'N')
						 ,isnull(sl_pt.CERT_ST_DOSE_MAX, 'N')
						 ,isnull(sl_pt.CERT_ST_DATA_INI, 'N')
						 ,isnull(sl_pt.CERT_ST_DATA_FIN, 'N')
						 into
							:ast_tab_certif.ST_DOSE_MIN 
							,:ast_tab_certif.ST_DOSE_MAX 
							,:ast_tab_certif.ST_DATA_INI 
							,:ast_tab_certif.ST_DATA_FIN 
						from sl_pt
						 where
							sl_pt.cod_sl_pt = :ast_tab_armo.cod_sl_pt 
						using kguo_sqlca_db_magazzino;
	else
		ast_tab_certif.ST_DOSE_MIN = "N"
		ast_tab_certif.ST_DOSE_MAX = "N"
		ast_tab_certif.ST_DATA_INI = "N"
		ast_tab_certif.ST_DATA_FIN = "N"
	end if

	if ast_tab_meca.CONTRATTO > 0 then
		select distinct 
			 isnull(CONTRATTI.CERT_ST_DATI_BOLLA_IN, 'N')
			 into
					:ast_tab_certif.ST_DATI_BOLLA_IN 
			from CONTRATTI
			 where
					CONTRATTI.CODICE = :ast_tab_meca.CONTRATTO 
		using kguo_sqlca_db_magazzino;
	else
		ast_tab_certif.ST_DATI_BOLLA_IN = "N"
		ast_tab_meca.CONTRATTO = 0
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then		
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
						"Errore in lettura delle Indicazioni dei Dati da Esporre " + kk_descr_operazione + ". N. attestato " + string(ast_tab_certif.num_certif))
		throw kguo_exception
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally

end try 




end subroutine

private function st_esito set_e1_wo_f5548014_old (st_tab_certif kst_tab_certif) throws uo_exception;//
//---------------------------------------------------------------------------------
//--- Popola dati tabella di appoggio e1_wo_f5548014 per E1
//--- da lanciare dopo la "stampa_attestato"
//---
//--- Par. Input: st_tab_certif   
//--- 
//--- Ritorna tab. ST_ESITO, Esiti:    Vedi standard
//--- 
//---------------------------------------------------------------------------------
//
long k_ctr, k_ctr_max
long k_durata_lav_secondi
date k_datainizioanno
int k_giorniafter, k_anno, k_anno_rid
st_esito kst_esito
st_tab_meca kst_tab_meca
st_tab_e1_wo_f5548014 kst_tab_e1_wo_f5548014
st_tab_barcode kst_tab_barcode, kst_tab_barcode_1[]
kuf_barcode kuf1_barcode
kuf_armo kuf1_armo
kuf_e1_wo_f5548014 kuf1_e1_wo_f5548014
kuf_e1 kuf1_e1


try  

	kst_esito = kguo_exception.inizializza(this.classname())

//--- alimenta tabella dati trattamento da Inviare a E1
	if kguo_g.if_e1_enabled( ) then
		
		kuf1_e1_wo_f5548014 = create kuf_e1_wo_f5548014
		kuf1_barcode = create kuf_barcode
		kuf1_armo = create kuf_armo
		kuf1_e1 = create kuf_e1
		
		kst_tab_meca.id = kst_tab_certif.id_meca
		kst_tab_e1_wo_f5548014.wo_osdoco = kuf1_armo.get_e1doco(kst_tab_meca)
		if kst_tab_e1_wo_f5548014.wo_osdoco > 0 then
			kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_qtdata
			kst_tab_e1_wo_f5548014.dosemin_os55gs25a = string(kst_tab_certif.dose_min, "#0.00")
			kst_tab_e1_wo_f5548014.dosemax_os55gs25b = string(kst_tab_certif.dose_max, "#0.00")
//--- set durata del trattamento							
			kst_tab_barcode.id_meca = kst_tab_meca.id
			k_durata_lav_secondi = kuf1_barcode.get_durata_lav(kst_tab_barcode) //25-10-2017 durata lavorazione solo di 1 barcode
			kst_tab_e1_wo_f5548014.ciclo_os55gs25c = string(k_durata_lav_secondi) //kst_tab_certif[1].dose, "#0.00")

//--- set num giri del trattamento							
			kst_tab_barcode_1[1].id_meca = kst_tab_barcode.id_meca   				// 25-10-2017 get dei giri di un barcode del lotto
			k_ctr_max = kuf1_barcode.get_barcode_da_id_meca(kst_tab_barcode_1[]) // 25-10-2017 get dei giri di un barcode del lotto
			if k_ctr_max > 0 then 		// 25-10-2017 get dei giri di un barcode del lotto
			
				k_ctr = 1
				do while k_ctr < k_ctr_max and kst_tab_barcode_1[k_ctr].lav_fila_1 = 0 and kst_tab_barcode_1[k_ctr].lav_fila_2 = 0
					k_ctr++
				loop	
				
				if kst_tab_barcode_1[k_ctr].lav_fila_1 > 0 or kst_tab_barcode_1[k_ctr].lav_fila_2 > 0 then // se ho trovato che è stato lavorato...
					kst_tab_e1_wo_f5548014.ngiri_ossetl = kst_tab_barcode_1[k_ctr].lav_fila_1 + kst_tab_barcode_1[k_ctr].lav_fila_1p + kst_tab_barcode_1[k_ctr].lav_fila_2 + kst_tab_barcode_1[k_ctr].lav_fila_2p
				end if
			end if
//--- set fila del trattamento							
			kuf1_barcode.get_lav_fila_tot_x_id_meca(kst_tab_barcode)  // 25-10-2017 calcolo dei giri totali dei barcode per lotto
			kst_tab_e1_wo_f5548014.tcicli_osmmcu = " " 
			if (kst_tab_barcode.lav_fila_1 + kst_tab_barcode.lav_fila_1p) > 0 and (kst_tab_barcode.lav_fila_2 + kst_tab_barcode.lav_fila_2p) > 0 then
				kst_tab_e1_wo_f5548014.tcicli_osmmcu = kuf1_e1.kki_tcicli_mmcu_MISTO  // CICLI MISTI
			else
				if (kst_tab_barcode.lav_fila_1 + kst_tab_barcode.lav_fila_1p) > 0 then
					kst_tab_e1_wo_f5548014.tcicli_osmmcu = kuf1_e1.kki_tcicli_mmcu_fila1  // FILA 1
				else
					if (kst_tab_barcode.lav_fila_2 + kst_tab_barcode.lav_fila_2p) > 0 then
						kst_tab_e1_wo_f5548014.tcicli_osmmcu = kuf1_e1.kki_tcicli_mmcu_fila2  // FILA 2
					end if
				end if
			end if
						
			kst_tab_e1_wo_f5548014.data_osa801 = string(kst_tab_certif.data, "dd/mm/yy")
			k_anno = integer(string(kst_tab_certif.data, "yyyy"))
			k_anno_rid = integer(string(kst_tab_certif.data, "yy"))
			k_datainizioanno = date(k_anno,01,01)
			k_giorniafter = DaysAfter(k_datainizioanno, date(kst_tab_certif.data)) + 1
			kst_tab_e1_wo_f5548014.data_osdee = 100000 + k_anno_rid * 1000 + k_giorniafter
			kst_tab_e1_wo_f5548014.ora_oswwaet = long(kGuf_data_base.get_e1_timeformat(time(kGuf_data_base.prendi_dataora( ))))
			
			kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i dati su tb di scambio con E-ONE
		end if
	end if

		
catch (uo_exception kuo_exception1)
	kst_esito = kuo_exception1.get_st_esito( )
	kst_esito.sqlerrtext = "Problemi in aggiornamento dati Attestato per E1 (set_e1_wo_f5548014)~n~r" + trim(kst_esito.sqlerrtext)
	
finally
	if isvalid(kuf1_e1_wo_f5548014) then destroy kuf1_e1_wo_f5548014
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	if isvalid(kuf1_e1) then destroy kuf1_e1
	
end try
			

return kst_esito

end function

on kuf_certif.create
call super::create
end on

on kuf_certif.destroy
call super::destroy
end on

event destructor;call super::destructor;
//if isvalid(kids_certif_stampa) then destroy kids_certif_stampa
if isvalid(kids_certif_tree_stampati_xgiornomeseanno) then destroy kids_certif_tree_stampati_xgiornomeseanno 
if isvalid(kids_certif_tree_stampati_xdata) then destroy kids_certif_tree_stampati_xdata 

if isvalid(kiuf_certif_print) then destroy kiuf_certif_print 
end event

event constructor;call super::constructor;//
//kids_certif_stampa = create kds_certif_stampa
ki_msgerroggetto = "Attestato"

end event

