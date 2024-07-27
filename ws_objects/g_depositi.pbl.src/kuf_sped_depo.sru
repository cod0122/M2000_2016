$PBExportHeader$kuf_sped_depo.sru
forward
global type kuf_sped_depo from kuf_parent
end type
end forward

global type kuf_sped_depo from kuf_parent
end type
global kuf_sped_depo kuf_sped_depo

type variables
public st_tab_arsp_depo kist_tab_arsp_depo
public constant string kki_sped_depo_flg_stampa_bolla_da_stamp="N"
public constant string kki_sped_depo_flg_stampa_bolla_stampata="S"
public constant string kki_sped_depo_flg_stampa_fatturato="F"
 
//--- Causale di Spedizione 
public constant string kki_ddt_st_num_data_in_NO = "N"   //non stampare num e data bolla di entrata

//--- costanti nomi DW 
public constant string kki_d_sped_depo_l_indirizzi = "d_sped_depo_l_indirizzi" 
public constant string kki_dw_elenco_note = "d_sped_depo_note_l" 
public constant string kki_dw_meca_da_sped = "d_merce_da_sped"  

//--- flag A CURA DI
public constant string kki_cura_trasp_Mittente = "M" 
public constant string kki_cura_trasp_Destinatario = "D" 
public constant string kki_cura_trasp_Vettore = "V" 
public constant string kki_cura_trasp_Nessuno = "" 


public constant long kki_num_bolla_out_extra = 9000000   //numero oltre il quale fare ddt 'BIS' o particolari

private datastore kdsi_d_sped_depo_l_indirizzi
end variables

forward prototypes
public subroutine if_isnull_testa (ref st_tab_sped_depo kst_tab_sped_depo)
public function st_esito tb_delete_testa (st_tab_sped_depo kst_tab_sped_depo)
public function st_esito tb_delete_x_rif () throws uo_exception
public function st_esito select_testa (ref st_tab_sped_depo kst_tab_sped_depo)
public function st_esito select_riga (ref st_tab_arsp_depo kst_tab_arsp_depo)
public subroutine if_isnull_riga (ref st_tab_arsp_depo kst_tab_arsp_depo)
public function st_esito anteprima_elenco (datastore kdw_anteprima, st_tab_armo kst_tab_armo)
public function st_esito get_clie (ref st_tab_sped_depo kst_tab_sped_depo)
public function st_esito get_righe (ref st_tab_arsp_depo kst_tab_arsp_depo[])
public function st_esito get_id_da_id_arsp_depo (ref st_tab_arsp_depo ast_tab_arsp_depo)
public function st_esito get_ultimo_doc (ref st_tab_sped_depo kst_tab_sped_depo)
public function st_esito anteprima_righe (datastore kdw_anteprima, st_tab_sped_depo kst_tab_sped_depo)
public function boolean u_open (st_tab_sped_depo kst_tab_sped_depo[], st_open_w kst_open_w)
public function boolean u_open_cancellazione (ref st_tab_sped_depo kst_tab_sped_depo)
public function boolean u_open_inserimento (ref st_tab_sped_depo kst_tab_sped_depo)
public function boolean u_open_modifica (ref st_tab_sped_depo kst_tab_sped_depo)
public function boolean u_open_visualizza (ref st_tab_sped_depo kst_tab_sped_depo)
public function st_esito get_id_riga_da_id_armo (ref st_tab_arsp_depo kst_tab_arsp_depo)
public function st_esito set_righe_stampata (st_tab_arsp_depo kst_tab_arsp_depo)
public function integer get_ddt_da_stampare (ref st_sped_ddt kst_sped_ddt[]) throws uo_exception
public function st_esito anteprima_1 (datastore kdw_anteprima, st_tab_sped_depo kst_tab_sped_depo)
public function st_esito anteprima_1 (datawindow kdw_anteprima, st_tab_sped_depo kst_tab_sped_depo)
public function st_esito anteprima (datastore kds_anteprima, st_tab_sped_depo kst_tab_sped_depo)
public function st_esito anteprima (datawindow kdw_anteprima, st_tab_sped_depo kst_tab_sped_depo)
public function st_esito anteprima_2 (datastore kdw_anteprima, st_tab_sped_depo kst_tab_sped_depo)
public function boolean u_open_stampa (st_tab_sped_depo kst_tab_sped_depo[])
public function boolean if_esiste (st_tab_sped_depo kst_tab_sped_depo) throws uo_exception
public function boolean get_id_armo_max (ref st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception
public function long get_colli_x_id_armo (st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception
public function st_esito get_numero_da_id (ref st_tab_sped_depo kst_tab_sped_depo)
public function boolean get_id_sped_depo_anno (ref st_tab_sped_depo kst_tab_sped_depo) throws uo_exception
public subroutine elenco_note (st_tab_sped_depo kst_tab_sped_depo)
public subroutine elenco_indirizzi_ddt (st_tab_sped_depo kst_tab_sped_depo)
public function boolean if_cancella (st_tab_sped_depo ast_tab_sped_depo) throws uo_exception
public function boolean if_modifica (st_tab_sped_depo ast_tab_sped_depo) throws uo_exception
public function boolean tb_update_numero_data (st_tab_sped_depo kst_tab_sped_depo) throws uo_exception
public function long tb_insert_testa (ref st_tab_sped_depo kst_tab_sped_depo) throws uo_exception
public function integer get_nr_righe (st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception
public function long get_id_armo (st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception
public function string get_stampa (st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception
public function long get_colli (st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception
public function long get_id_sped_depo (st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception
public function boolean tb_delete_riga (st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception
public function long tb_insert_riga (ref st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception
public subroutine tb_update_riga (ref st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception
public subroutine tb_update_testa (ref st_tab_sped_depo kst_tab_sped_depo) throws uo_exception
public subroutine get_note (ref st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception
public function integer get_nr_indirizzi_ddt (st_tab_sped_depo kst_tab_sped_depo)
public function boolean link_call_anteprima (ref datastore ads_link, string a_campo_link) throws uo_exception
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function boolean link_call (ref datastore ads_1, string a_campo_link) throws uo_exception
public function boolean if_sv_call_vettore (st_tab_sped_depo ast_tab_sped_depo) throws uo_exception
public function long get_id_sped_depo_max (string k_numpref_bolla_out) throws uo_exception
public function long get_id_arsp_depo_max () throws uo_exception
public function long get_id_sped_depo (ref st_tab_sped_depo kst_tab_sped_depo) throws uo_exception
public function boolean set_num_bolla_out_all (st_tab_sped_depo kst_tab_sped_depo) throws uo_exception
public function long get_num_bolla_out_ultimo (ref st_tab_sped_depo kst_tab_sped_depo) throws uo_exception
public function long get_numero_nuovo (st_tab_sped_depo ast_tab_sped_depo, integer a_ctr) throws uo_exception
public function long if_num_bolla_out_exists (st_tab_sped_depo kst_tab_sped_depo) throws uo_exception
public function boolean if_ddt_allarme_memo (st_tab_sped_depo kst_tab_sped_depo) throws uo_exception
public function boolean if_stampato (st_tab_sped_depo ast_tab_sped_depo) throws uo_exception
public function string get_cura_trasp (ref st_tab_sped_depo kst_tab_sped_depo) throws uo_exception
private function long u_set_ds_d_sped_depo_l_indirizzi (st_tab_sped_depo kst_tab_sped_depo)
public function st_esito set_sped_stampata (st_tab_sped_depo kst_tab_sped_depo)
public function st_esito get_sped_stampa (ref st_tab_sped_depo kst_tab_sped_depo)
public function long get_colli_x_id_armo_sped (st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception
public function long get_colli_sped (ref st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception
public function long get_colli_sped_lotto (long aid_meca) throws uo_exception
end prototypes

public subroutine if_isnull_testa (ref st_tab_sped_depo kst_tab_sped_depo);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_sped_depo.cura_trasp) then kst_tab_sped_depo.cura_trasp = " "
if isnull(kst_tab_sped_depo.causale) then kst_tab_sped_depo.causale = " "
if isnull(kst_tab_sped_depo.aspetto) then kst_tab_sped_depo.aspetto = " "
if isnull(kst_tab_sped_depo.mezzo) then kst_tab_sped_depo.mezzo = " "
if isnull(kst_tab_sped_depo.porto) then kst_tab_sped_depo.porto = " "
if isnull(kst_tab_sped_depo.note_1) then	kst_tab_sped_depo.note_1 = " "
if isnull(kst_tab_sped_depo.note_2) then	kst_tab_sped_depo.note_2 = " "
if isnull(kst_tab_sped_depo.vett_1) then	kst_tab_sped_depo.vett_1 = " "
if isnull(kst_tab_sped_depo.vett_2) then	kst_tab_sped_depo.vett_2 = " "
if isnull(kst_tab_sped_depo.stampa) then kst_tab_sped_depo.stampa = ""
if isnull(kst_tab_sped_depo.colli) then kst_tab_sped_depo.colli = 0
if isnull(kst_tab_sped_depo.clie_2) then	kst_tab_sped_depo.clie_2 = 0
if isnull(kst_tab_sped_depo.clie_3) then	kst_tab_sped_depo.clie_3 = 0
if isnull(kst_tab_sped_depo.data_rit) then kst_tab_sped_depo.data_rit = date(0)
if isnull(kst_tab_sped_depo.ora_rit) then kst_tab_sped_depo.ora_rit = " "
if isnull(kst_tab_sped_depo.data_uscita) then kst_tab_sped_depo.data_uscita = date(0)
if isnull(kst_tab_sped_depo.sv_call_vettore) then kst_tab_sped_depo.sv_call_vettore = 0

if isnull(kst_tab_sped_depo.rag_soc_1) then kst_tab_sped_depo.rag_soc_1 = ""
if isnull(kst_tab_sped_depo.rag_soc_2) then kst_tab_sped_depo.rag_soc_2 = ""
if isnull(kst_tab_sped_depo.indi) then kst_tab_sped_depo.indi = ""
if isnull(kst_tab_sped_depo.loc) then kst_tab_sped_depo.loc = ""

end subroutine

public function st_esito tb_delete_testa (st_tab_sped_depo kst_tab_sped_depo);//
//====================================================================
//=== Cancella il rek dalla tabella sped_depo-ARSP (Bolle di spedizione) 
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//=== 
//====================================================================
//
int k_resp
boolean k_return
st_esito kst_esito
st_tab_sped_depo kst_tab_sped_depo_1, kst_tab_sped_depo_2[]
st_tab_docprod kst_tab_docprod
kuf_docprod kuf1_docprod
kuf_doctipo kuf1_doctipo
kuf_sped_depo_ddt kuf1_sped_depo_ddt


try
	kst_esito = kguo_exception.inizializza(this.classname())

	if if_sicurezza(kkg_flag_modalita.cancellazione) then  // Controllo se utente autorizzato

//--- se manca piglia ID del ddt
 		if kst_tab_sped_depo.id_sped_depo > 0 then
		else
	//		get_id_sped_depo(kst_tab_sped_depo)
		end if
		
		try
			
			kuf1_sped_depo_ddt = create kuf_sped_depo_ddt
//	
//	//--- Ripristina il flag di righe WMF 			
//				kst_tab_sped_depo_1 = kst_tab_sped_depo
//				kst_tab_sped_depo_1.st_tab_g_0.esegui_commit	= "N"
//				kuf1_sped_depo_ddt.set_wm_pklist_righe_non_spedito(kst_tab_sped_depo_1)
			
			if isvalid(kuf1_sped_depo_ddt) then destroy kuf1_sped_depo_ddt
	
	//--- cancella prima tutte le righe
			delete from arsp_depo
					WHERE id_sped_depo = :kst_tab_sped_depo.id_sped_depo
					using kguo_sqlca_db_magazzino;
					//num_bolla_out = :kst_tab_sped_depo.num_bolla_out
					//		and data_bolla_out = :kst_tab_sped_depo.data_bolla_out;
		
			
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante la cancellazione delle righe del DDT " &
						+ string(kst_tab_sped_depo.num_bolla_out, "####0") + " del " &
						+ string(kst_tab_sped_depo.data_bolla_out, "dd.mm.yyyy") &	
						+ " id " + string(kst_tab_sped_depo.id_sped_depo) &
						+ "~n~rErrore-tab.ARSP:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				
			else

//--- se tutto ok cancella la testata
				delete from sped_depo
						WHERE id_sped_depo = :kst_tab_sped_depo.id_sped_depo
						using kguo_sqlca_db_magazzino;
				
				if kguo_sqlca_db_magazzino.sqlcode <> 0 then
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.SQLErrText = &
		"Errore durante la cancellazione testata del DDT  " &
						+ string(kst_tab_sped_depo.num_bolla_out, "####0") + " del " &
						+ string(kst_tab_sped_depo.data_bolla_out, "dd.mm.yyyy") &	
						+ " id " + string(kst_tab_sped_depo.id_sped_depo) &
						+ " ~n~rErrore-tab.SPED:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
					if kguo_sqlca_db_magazzino.sqlcode = 100 then
						kst_esito.esito = kkg_esito.not_fnd
					else
						if kguo_sqlca_db_magazzino.sqlcode > 0 then
							kst_esito.esito = kkg_esito.db_wrn
						else
							kst_esito.esito = kkg_esito.db_ko
						end if
					end if
//				else
//
////--- cancella da docprod	 tutti i riferimenti
//					kst_tab_docprod.id_doc = kst_tab_sped_depo.id_sped_depo 
//					kuf1_docprod = create kuf_docprod
//					kuf1_doctipo = create kuf_doctipo
//					kst_tab_docprod.st_tab_g_0.esegui_commit = "N"
//					kuf1_docprod.tb_delete(kst_tab_docprod, kuf1_doctipo.kki_tipo_ddt )

				end if
			end if

			if kst_tab_sped_depo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped_depo.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		
		catch 	(uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
			if kst_tab_sped_depo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped_depo.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if


		finally
			
			if isvalid(kuf1_docprod) then destroy kuf1_docprod 
			if isvalid(kuf1_doctipo) then destroy kuf1_doctipo 
		
		end try

	end if
	
catch (uo_exception kuo1_exception)
	kst_esito = kuo1_exception.get_st_esito()
	
end try


return kst_esito

end function

public function st_esito tb_delete_x_rif () throws uo_exception;//
/*
 Cancella il rek dalla tabella arsp_depo e SPED-depo (Spedizioni) 
	con i dati del Riferimento
*/
int k_ctr
boolean k_return
string k_errore
st_esito kst_esito, kst_esito1
st_open_w kst_open_w
st_tab_sped_depo kst_tab_sped_depo
kuf_sicurezza kuf1_sicurezza


	kst_esito = kguo_exception.inizializza(this.classname())

	if_sicurezza(kkg_flag_modalita.cancellazione)

	DECLARE c_arsp CURSOR FOR  
		SELECT arsp_depo.id_sped_depo, sped_depo.num_bolla_out, sped_depo.data_bolla_out
			FROM arsp_depo inner join sped_depo on arsp_depo.id_sped_depo = sped_depo.id_sped_depo
			WHERE id_armo = :kist_tab_arsp_depo.id_armo
			using sqlca;
			
	open c_arsp;
	
	fetch c_arsp into :kist_tab_arsp_depo.id_sped_depo, :kst_tab_sped_depo.num_bolla_out, :kst_tab_sped_depo.data_bolla_out;

	kst_esito1.SQLErrText = " "
	kst_esito1.esito = kkg_esito.ok
	do while sqlca.sqlcode = 0 

		delete from arsp_depo
			WHERE id_armo = :kist_tab_arsp_depo.id_armo
			using sqlca;
			
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
	"Errore durante la cancellazione delle righe Bolla di Spedizione ~n~r" &
					+ string(kst_tab_sped_depo.num_bolla_out, "####0") + " del " &
					+ string(kst_tab_sped_depo.data_bolla_out, "dd.mm.yyyy") &	
					+ " ~n~rErrore-tab.ARSP:"	+ trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		fetch c_arsp into :kist_tab_arsp_depo.id_sped_depo, :kst_tab_sped_depo.num_bolla_out, :kst_tab_sped_depo.data_bolla_out;

	loop

	close c_arsp;

	if kst_esito.esito = kkg_esito.ok then
		kst_esito = kguo_sqlca_db_magazzino.db_commit()
		if kst_esito.esito <> kkg_esito.ok then
			kst_esito.SQLErrText = "Errore in Canc.Righe Spedizione (COMMIT kuf_armo.tb_delete): " + trim(kst_esito.SQLErrText)
		end if
		
	end if
	
//--- se la bolla e' rimasta senza righe allora cancello anche la testata		
	k_ctr = 0
	select count(*) into :k_ctr
		from arsp_depo
		where arsp_depo.id_sped_depo = :kist_tab_arsp_depo.id_sped_depo
				using sqlca;

				
	if sqlca.sqlcode >= 0 and (k_ctr = 0 or isnull(k_ctr)) then

		delete from sped_depo
			where num_bolla_out = :kist_tab_arsp_depo.id_sped_depo
				using sqlca;

		if sqlca.sqlcode < 0 then 
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
	"Errore durante la cancellazione delle Testata Bolla di Spedizione ~n~r" &
					+ string(kst_tab_sped_depo.num_bolla_out, "####0") + " del " &
					+ string(kst_tab_sped_depo.data_bolla_out, "dd.mm.yyyy") &	
					+ " ~n~rErrore-tab.SPED:"	+ trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else
			
			kguo_sqlca_db_magazzino.db_commit()
			
		end if

	end if

return kst_esito

end function

public function st_esito select_testa (ref st_tab_sped_depo kst_tab_sped_depo);//
//--- Leggo Contratto specifico
//
long k_codice
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	if kst_tab_sped_depo.id_sped_depo > 0 then

	  SELECT 
				sped_depo.clie_2,   
				sped_depo.clie_3,   
				trim(sped_depo.cura_trasp),   
				sped_depo.causale,   
				trim(sped_depo.aspetto),   
				trim(sped_depo.porto),   
				trim(sped_depo.mezzo),   
				sped_depo.note_1,   
				sped_depo.note_2,   
				sped_depo.data_rit,   
				trim(sped_depo.ora_rit),   
				trim(sped_depo.vett_1),   
				trim(sped_depo.vett_2),   
				sped_depo.stampa,   
				sped_depo.colli,   
				sped_depo.data_uscita  
		 INTO 
			  :kst_tab_sped_depo.clie_2,   
				:kst_tab_sped_depo.clie_3,   
				:kst_tab_sped_depo.cura_trasp,   
				:kst_tab_sped_depo.causale,   
				:kst_tab_sped_depo.aspetto,   
				:kst_tab_sped_depo.porto,   
				:kst_tab_sped_depo.mezzo,   
				:kst_tab_sped_depo.note_1,   
				:kst_tab_sped_depo.note_2,   
				:kst_tab_sped_depo.data_rit,   
				:kst_tab_sped_depo.ora_rit,   
				:kst_tab_sped_depo.vett_1,   
				:kst_tab_sped_depo.vett_2,   
				:kst_tab_sped_depo.stampa,   
				:kst_tab_sped_depo.colli,   
				:kst_tab_sped_depo.data_uscita  
		 FROM sped_depo  
		WHERE id_sped_depo = :kst_tab_sped_depo.id_sped_depo
				  ;
	else	

	  SELECT 
				sped_depo.clie_2,   
				sped_depo.clie_3,   
				trim(sped_depo.cura_trasp),   
				sped_depo.causale,   
				trim(sped_depo.aspetto),   
				trim(sped_depo.porto),   
				trim(sped_depo.mezzo),   
				sped_depo.note_1,   
				sped_depo.note_2,   
				sped_depo.data_rit,   
				trim(sped_depo.ora_rit),   
				trim(sped_depo.vett_1),   
				trim(sped_depo.vett_2),   
				sped_depo.stampa,   
				sped_depo.colli,   
				sped_depo.data_uscita  
		 INTO 
			  :kst_tab_sped_depo.clie_2,   
				:kst_tab_sped_depo.clie_3,   
				:kst_tab_sped_depo.cura_trasp,   
				:kst_tab_sped_depo.causale,   
				:kst_tab_sped_depo.aspetto,   
				:kst_tab_sped_depo.porto,   
				:kst_tab_sped_depo.mezzo,   
				:kst_tab_sped_depo.note_1,   
				:kst_tab_sped_depo.note_2,   
				:kst_tab_sped_depo.data_rit,   
				:kst_tab_sped_depo.ora_rit,   
				:kst_tab_sped_depo.vett_1,   
				:kst_tab_sped_depo.vett_2,   
				:kst_tab_sped_depo.stampa,   
				:kst_tab_sped_depo.colli,   
				:kst_tab_sped_depo.data_uscita  
		 FROM sped_depo  
		WHERE ( num_bolla_out = :kst_tab_sped_depo.num_bolla_out ) AND  
				( data_bolla_out = :kst_tab_sped_depo.data_bolla_out)   
				  ;
	end if
	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.d.d.t., bolla di sped_depo. (numero=" + string( kst_tab_sped_depo.num_bolla_out) + " del "+ string( kst_tab_sped_depo.data_bolla_out)+") : " &
									 + trim(SQLCA.SQLErrText)
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
	
//return string(sqlca.sqlcode, "0000000000") + trim(sqlca.SQLErrText) + " "
return kst_esito


end function

public function st_esito select_riga (ref st_tab_arsp_depo kst_tab_arsp_depo);//
//--- Leggo Riga di Spedizione  della Bolla e id_armo indicata
//
long k_codice
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

   SELECT arsp_depo.colli,   
         arsp_depo.note_1,   
         arsp_depo.note_2,   
         arsp_depo.note_3,   
         arsp_depo.stampa,   
         arsp_depo.colli_out,   
         arsp_depo.peso_kg_out  
    INTO :kst_tab_arsp_depo.colli,   
         :kst_tab_arsp_depo.note_1,   
         :kst_tab_arsp_depo.note_2,   
         :kst_tab_arsp_depo.note_3,   
         :kst_tab_arsp_depo.stampa,   
         :kst_tab_arsp_depo.colli_out,   
         :kst_tab_arsp_depo.peso_kg_out  
    FROM arsp_depo  
   WHERE ( id_sped_depo = :kst_tab_arsp_depo.id_sped_depo )  and 
         ( id_armo = :kst_tab_arsp_depo.id_armo)   
           ;
	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.d.d.t., riga bolla di spedizione deposito (id=" + string( kst_tab_arsp_depo.id_sped_depo) + " id riga di entrata " + string( kst_tab_arsp_depo.id_armo) + ") : " &
									 + trim(SQLCA.SQLErrText)
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
	
//return string(sqlca.sqlcode, "0000000000") + trim(sqlca.SQLErrText) + " "
return kst_esito

end function

public subroutine if_isnull_riga (ref st_tab_arsp_depo kst_tab_arsp_depo);//---
//--- toglie i NULL ai campi della tabella 

if isnull(kst_tab_arsp_depo.id_sped_depo) then kst_tab_arsp_depo.id_sped_depo = 0
if isnull(kst_tab_arsp_depo.id_armo) then kst_tab_arsp_depo.id_armo = 0
if isnull(kst_tab_arsp_depo.id_arsp_depo) then kst_tab_arsp_depo.id_arsp_depo = 0
if isnull(kst_tab_arsp_depo.nriga) then kst_tab_arsp_depo.nriga = 0
if isnull(kst_tab_arsp_depo.nriga) then kst_tab_arsp_depo.nriga = 0
if isnull(kst_tab_arsp_depo.colli) then kst_tab_arsp_depo.colli = 0
if isnull(kst_tab_arsp_depo.note_1) then	kst_tab_arsp_depo.note_1 = ""
if isnull(kst_tab_arsp_depo.note_2) then	kst_tab_arsp_depo.note_2 = ""
if isnull(kst_tab_arsp_depo.note_3) then	kst_tab_arsp_depo.note_3 = ""
if isnull(kst_tab_arsp_depo.colli_out) then kst_tab_arsp_depo.colli_out = 0
if isnull(kst_tab_arsp_depo.peso_kg_out) then	kst_tab_arsp_depo.peso_kg_out = 0
if isnull(kst_tab_arsp_depo.stampa) then kst_tab_arsp_depo.stampa = kki_sped_depo_flg_stampa_bolla_da_stamp 

end subroutine

public function st_esito anteprima_elenco (datastore kdw_anteprima, st_tab_armo kst_tab_armo);//
//=== 
//====================================================================
//=== Operazione di Anteprima (elenco arsp_depo x id_meca)
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


kst_esito = kguo_exception.inizializza(this.classname())

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)

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

		kdw_anteprima.dataobject = "d_arsp_l_1"		
		kdw_anteprima.settransobject(sqlca)

//		kuf1_utility = create kuf_utility
//		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//		destroy kuf1_utility

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

public function st_esito get_clie (ref st_tab_sped_depo kst_tab_sped_depo);//
//--- Leggo CLIENTI spedizione (ricevente, fatturato)
//
long k_codice, k_anno
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())
	
	if kst_tab_sped_depo.id_sped_depo > 0 then
		
		SELECT 
			sped_depo.clie_2,   
			sped_depo.clie_3  
		 INTO 
		  	:kst_tab_sped_depo.clie_2,   
			:kst_tab_sped_depo.clie_3
	 	FROM sped_depo  
		WHERE id_sped_depo = :kst_tab_sped_depo.id_sped_depo
			  using sqlca;
	
	else
		
		k_anno = year(kst_tab_sped_depo.data_bolla_out)
		
		SELECT 
			sped_depo.clie_2,   
			sped_depo.clie_3  
		 INTO 
		  	:kst_tab_sped_depo.clie_2,   
			:kst_tab_sped_depo.clie_3
	 	FROM sped_depo  
		WHERE ( num_bolla_out = :kst_tab_sped_depo.num_bolla_out ) AND  
			( year(data_bolla_out) = :k_anno)   
			  using sqlca;
	
	end if
	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.d.d.t., bolla di sped_depo. (numero=" + string( kst_tab_sped_depo.num_bolla_out) + " del "+ string( k_anno )+") ~n~r" &
									 + trim(SQLCA.SQLErrText)
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
	
return kst_esito


end function

public function st_esito get_righe (ref st_tab_arsp_depo kst_tab_arsp_depo[]);//
//--- Leggo Righe Bolla di spedizione 
//--- Input: st_tab_arsp_depo[1].id_sped_depo
//--- Out: st_tab_arsp_depo[] con le righe trovate, ST_ESITO
//
int k_ind
st_tab_arsp_depo kst_tab_arsp_depo_app, kst_tab_arsp_depo_null[] 
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	kst_tab_arsp_depo_app.id_sped_depo = kst_tab_arsp_depo[1].id_sped_depo

//--- inizializza la ARRAY da restituire
	kst_tab_arsp_depo[] = kst_tab_arsp_depo_null[] 
		
	DECLARE c_get_righe_arsp CURSOR FOR  
	  SELECT arsp_depo.id_arsp_depo,   
					arsp_depo.id_armo,   
					arsp_depo.colli,   
					arsp_depo.colli_out  
			 FROM arsp_depo
			 WHERE arsp_depo.id_sped_depo = :kst_tab_arsp_depo_app.id_sped_depo
			  using sqlca;

	open  c_get_righe_arsp;
	if sqlca.sqlcode = 0 then

		k_ind=1
		fetch c_get_righe_arsp into 
						:kst_tab_arsp_depo[k_ind].id_arsp_depo
						,:kst_tab_arsp_depo[k_ind].id_armo
						,:kst_tab_arsp_depo[k_ind].colli
						,:kst_tab_arsp_depo[k_ind].colli_out;
		
		do while sqlca.sqlcode = 0
			
			k_ind ++
			fetch c_get_righe_arsp into 
						:kst_tab_arsp_depo[k_ind].id_arsp_depo
						,:kst_tab_arsp_depo[k_ind].id_armo
						,:kst_tab_arsp_depo[k_ind].colli
						,:kst_tab_arsp_depo[k_ind].colli_out;
		loop

		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.d.d.t., Righe bolla deposito (id=" + string( kst_tab_arsp_depo_app.id_sped_depo) + ") : " &
										 + trim(SQLCA.SQLErrText)
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

		close c_get_righe_arsp;
	
	end if
		
return kst_esito


end function

public function st_esito get_id_da_id_arsp_depo (ref st_tab_arsp_depo ast_tab_arsp_depo);//
//--- Piglia il NUMERO e DATA spedizione da id_arsp_depo
//
//--- inp: st_tab_arsp_depo.id_arsp_depo
//--- out: st_esito
//
//
long k_codice
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

SELECT distinct arsp_depo.id_sped_depo
    INTO :ast_tab_arsp_depo.id_sped_depo
    FROM arsp_depo
   WHERE ( id_arsp_depo = :ast_tab_arsp_depo.id_arsp_depo ) 
           using kguo_sqlca_db_magazzino ;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore tab. d.d.t., Riga Bolla di spedizione depoosito (id=" + string(ast_tab_arsp_depo.id_arsp_depo) + "): ~n~r" &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if
	
return kst_esito



end function

public function st_esito get_ultimo_doc (ref st_tab_sped_depo kst_tab_sped_depo);//
//====================================================================
//=== Torna l'ultima Spedizione (Numero e Data) della Anagrafica se impostata 
//=== 
//=== Input : kst_tab_sped_depo.clie_2
//=== Out: kst_tab_sped_depo.numpref_bolla_out + num_bolla_out + data_bolla_out
//=== Ritorna: ST_ESITO					
//===   
//====================================================================
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	kst_tab_sped_depo.numpref_bolla_out = trim(kst_tab_sped_depo.numpref_bolla_out)
	if kst_tab_sped_depo.numpref_bolla_out > " " then

		if kst_tab_sped_depo.clie_2 > 0 then
		else
			kst_tab_sped_depo.clie_2 = 0
		end if
		
		select max(num_bolla_out)
					  ,data_bolla_out
				into :kst_tab_sped_depo.num_bolla_out
					,:kst_tab_sped_depo.data_bolla_out
				from sped_depo  
				where (:kst_tab_sped_depo.clie_2 = 0 or clie_2 = :kst_tab_sped_depo.clie_2 )
						and sped_depo.numpref_bolla_out = :kst_tab_sped_depo.numpref_bolla_out
						and sped_depo.data_bolla_out in (
							select  max(data_bolla_out)
								from sped_depo  
								where  (:kst_tab_sped_depo.clie_2 = 0 or clie_2 = :kst_tab_sped_depo.clie_2 )
									and sped_depo.numpref_bolla_out = :kst_tab_sped_depo.numpref_bolla_out
									)
				group by data_bolla_out
				using kguo_sqlca_db_magazzino;
	end if			
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_tab_sped_depo.num_bolla_out = 0
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = kguo_sqlca_db_magazzino.sqlerrtext
		end if
	end if
	
return kst_esito	

end function

public function st_esito anteprima_righe (datastore kdw_anteprima, st_tab_sped_depo kst_tab_sped_depo);//
//=== 
//====================================================================
//=== Operazione di Anteprima (elenco arsp_depo x num+data sped_depo)
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


kst_esito = kguo_exception.inizializza(this.classname())

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.not_fnd

else

	if kst_tab_sped_depo.num_bolla_out > 0 then

		kdw_anteprima.dataobject = "d_arsp_l_sped"		
		kdw_anteprima.settransobject(sqlca)

//		kuf1_utility = create kuf_utility
//		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//		destroy kuf1_utility

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_sped_depo.data_bolla_out, kst_tab_sped_depo.num_bolla_out)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Riga Lotto da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = kkg_esito.err_logico
		
	end if
end if


return kst_esito

end function

public function boolean u_open (st_tab_sped_depo kst_tab_sped_depo[], st_open_w kst_open_w);//
//--- Chiama la giusta Funzionalità
//---
//--- Input: st_tab_spec con num e data _bolla_out valorizzati se serve,  st_open_w.flag_modalita = tipo funzione da richiamare
//---
//
boolean  k_return = true
integer k_ind
st_esito kst_esito


	k_ind=1 

	choose case kst_open_w.flag_modalita  

////			case kkg_flag_modalita.anteprima
////
////				if kst_tab_sped_depo[k_ind].num_bolla_out > 0 then
////					kst_esito = this.anteprima ( kds_1, kst_tab_sped_depo[k_ind])
////				end if
			
		case kkg_flag_modalita.stampa
			k_return = this.u_open_stampa(kst_tab_sped_depo[])		
			
		case kkg_flag_modalita.cancellazione
			k_return = this.u_open_cancellazione(kst_tab_sped_depo[k_ind])
			
		case kkg_flag_modalita.modifica
			k_return = this.u_open_modifica(kst_tab_sped_depo[k_ind])
			
		case kkg_flag_modalita.inserimento
			k_return = this.u_open_inserimento(kst_tab_sped_depo[k_ind])
			
		case kkg_flag_modalita.visualizzazione
			k_return = this.u_open_visualizza(kst_tab_sped_depo[k_ind])
			
		case else
				
				
	end choose		
 
return k_return

end function

public function boolean u_open_cancellazione (ref st_tab_sped_depo kst_tab_sped_depo);//---
//--- Apre la Window x CANCELLAZIONE 
//---
//--- Input: st_tab_sped_depo.id_sped_depo
//--- Out: TRUE = finestra aperta; FASE=operazione non eseguita
//---


boolean k_return = false
st_esito kst_esito 
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window


if kst_esito.esito = kkg_esito.ok and kst_tab_sped_depo.id_sped_depo > 0 then
	
	k_return = true
	kst_tab_sped_depo.clie_3 = 0
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
	kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)
	kst_open_w.flag_primo_giro = "S"
	kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
	kst_open_w.flag_leggi_dw = " "
	kst_open_w.flag_cerca_in_lista = " "
	kst_open_w.key1 = ""
	kst_open_w.key2 = ""
	kst_open_w.key3 = trim(string(kst_tab_sped_depo.id_sped_depo)) 
	kst_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(kst_open_w)
	destroy kuf1_menu_window


end if

return k_return

end function

public function boolean u_open_inserimento (ref st_tab_sped_depo kst_tab_sped_depo);//---
//--- Apre Window x inserimento 
//---
//---
//---

boolean k_return = true
//
long k_riga=0
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window


kst_tab_sped_depo.num_bolla_out =0
kst_tab_sped_depo.data_bolla_out = kg_dataoggi
//
	

//if dw_lista_0.getrow() > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
	kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)
	kst_open_w.flag_primo_giro = "S"
	kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
	kst_open_w.flag_leggi_dw = " "
	kst_open_w.flag_cerca_in_lista = " "
	kst_open_w.key1 = ""
	kst_open_w.key2 = ""
	kst_open_w.key3 = " " 
	kst_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(kst_open_w)
	destroy kuf1_menu_window

								
//else
//
//	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")
//
//end if


return k_return

end function

public function boolean u_open_modifica (ref st_tab_sped_depo kst_tab_sped_depo);//---
//--- Apre la Window x Modifica sped_depo 
//---
//--- Input: st_tab_sped_depo.id_sped_dep
//--- Out: TRUE = finestra aperta; FASE=operazione non eseguita
//---

boolean k_return = false
st_esito kst_esito 
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window



if kst_tab_sped_depo.num_bolla_out > 0 then
	
	k_return = true
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)
	kst_open_w.flag_primo_giro = "S"
	kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
	kst_open_w.flag_leggi_dw = " "
	kst_open_w.flag_cerca_in_lista = " "
	kst_open_w.key1 = ""
	kst_open_w.key2 = "" //trim(string(kst_tab_sped_depo.data_bolla_out)) 
	kst_open_w.key3 = trim(string(kst_tab_sped_depo.id_sped_depo))
	kst_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(kst_open_w)
	destroy kuf1_menu_window


end if


return k_return


end function

public function boolean u_open_visualizza (ref st_tab_sped_depo kst_tab_sped_depo);//---
//--- Apre la Window x Visualizzazione sped_depo 
//---
//--- Input: st_tab_sped_depo.id_sped_dep
//--- Out: TRUE = finestra aperta; FASE=operazione non eseguita
//---

boolean k_return = false
st_esito kst_esito
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window



if kst_tab_sped_depo.id_sped_depo > 0 then
	
	
	k_return = true
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)
	kst_open_w.flag_primo_giro = "S"
	kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
	kst_open_w.flag_leggi_dw = " "
	kst_open_w.flag_cerca_in_lista = " "
	kst_open_w.key1 = ""
	kst_open_w.key2 = ""
	kst_open_w.key3 = trim(string(kst_tab_sped_depo.id_sped_depo)) 
	kst_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(kst_open_w)
	destroy kuf1_menu_window


end if


return k_return


end function

public function st_esito get_id_riga_da_id_armo (ref st_tab_arsp_depo kst_tab_arsp_depo);//
//--- Piglia il id_arsp_depo spedizione da id_armo
//--- nell'ipotesi di più righe (ma non dovrebbe capitare) piglio la più recente
//---
//--- inp: st_tab_arsp_depo.id_armo
//--- out: st_tab_arsp_depo.id_arsp_depo
//--- ritorna: st_esito   
//
long k_codice
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

SELECT max (id_arsp_depo)
    INTO :kst_tab_arsp_depo.id_arsp_depo 
    FROM arsp_depo  
   WHERE ( id_armo = :kst_tab_arsp_depo.id_armo ) 
           using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore tab. d.d.t., riga bolla di spedizione deposito (id_armo=" + string( kst_tab_arsp_depo.id_armo) + "): ~n~r" &
									 + trim(SQLCA.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		if kst_tab_arsp_depo.id_arsp_depo = 0 then
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Errore tab. d.d.t., riga bolla di spedizione deposito (id_armo=" + string( kst_tab_arsp_depo.id_armo) + ") " 
			kst_esito.esito = kkg_esito.not_fnd
		end if
	end if
	
return kst_esito

end function

public function st_esito set_righe_stampata (st_tab_arsp_depo kst_tab_arsp_depo);//
//====================================================================
//=== Imposta a Stampata tutte le Righe della Bolla di spedizione
//=== 
//=== 
//=== Input: st_arsp_depo.id_sped_depo
//=== Out: ST_ESITO
//===           		
//=== 
//====================================================================
//
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())
		
	if kst_tab_arsp_depo.id_sped_depo > 0 then
	
		kst_tab_arsp_depo.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_arsp_depo.x_utente = kGuf_data_base.prendi_x_utente()
	
		kst_tab_arsp_depo.stampa = kki_sped_depo_flg_stampa_bolla_stampata
		UPDATE arsp_depo
		  SET stampa = :kst_tab_arsp_depo.stampa
		  			,x_datins = :kst_tab_arsp_depo.x_datins
			  		,x_utente = :kst_tab_arsp_depo.x_utente
			WHERE id_sped_depo = :kst_tab_arsp_depo.id_sped_depo
			using sqlca;
	
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore durante aggiorn. righe d.d.t. in stampa~n~r" &
						+ "spedizione deposito id " &
						+ string(kst_tab_arsp_depo.id_sped_depo, "####0")  &	
						+ " ~n~rErrore-tab.ARSP_DEPO:"	+ trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
	
//---- COMMIT o ROLLBACK....	
		if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
			if kst_tab_arsp_depo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arsp_depo.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		else
			if kst_tab_arsp_depo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arsp_depo.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		end if
	
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore tab. righe d.d.t., Manca id della Spedizione deposito (id_sped_depo) !" 
		kst_esito.esito = kkg_esito.err_logico
			
	end if	

return kst_esito

end function

public function integer get_ddt_da_stampare (ref st_sped_ddt kst_sped_ddt[]) throws uo_exception;//
/* Cerca i documenti non ancora Stampati (vedi il flag di "STAMPA")
 inp: array st_sped_ddt[1] numpref_bolla_out
 out: array st_sped_ddt con l'elenco doc da stampare
 rit: num trovati
*/
int k_ctr=0
long k_riga_ddt=0
date k_data_meno6mesi, k_dataoggi
st_tab_sped_depo kst_tab_sped_depo
st_esito kst_esito 
uo_exception kuo_exception


	kst_esito = kguo_exception.inizializza(this.classname())

	kst_tab_sped_depo.numpref_bolla_out = kst_sped_ddt[1].kst_tab_sped_depo.numpref_bolla_out
	kst_tab_sped_depo.stampa = kki_sped_depo_flg_stampa_bolla_da_stamp
	
  	declare  c_get_ddt_da_stampare  cursor for
         SELECT distinct
					id_sped_depo,
					num_bolla_out,   
					data_bolla_out 
				FROM sped_depo 
				 where  numpref_bolla_out = :kst_tab_sped_depo.numpref_bolla_out
				       and data_bolla_out > :k_data_meno6mesi 
						 and (stampa is null or stampa = :kst_tab_sped_depo.stampa)
				 group by 
						 id_sped_depo
						,data_bolla_out 
						,num_bolla_out  
						using sqlca;
	
//--- data oggi
	k_dataoggi = kguo_g.get_dataoggi( )
	
//--- data oggi -6 mesi
	k_data_meno6mesi = relativedate(kg_dataoggi, -185)
	
	open c_get_ddt_da_stampare;

	if sqlca.sqlcode = 0 then

		k_riga_ddt++
		fetch c_get_ddt_da_stampare 
				into
				:kst_sped_ddt[k_riga_ddt].kst_tab_sped_depo.id_sped_depo
				,:kst_sped_ddt[k_riga_ddt].kst_tab_sped_depo.NUM_BOLLA_OUT
				,:kst_sped_ddt[k_riga_ddt].kst_tab_sped_depo.DATA_BOLLA_OUT;
		
		do while sqlca.sqlcode = 0 

			kst_sped_ddt[k_riga_ddt].sel = 1

			if isnull(kst_sped_ddt[k_riga_ddt].kst_tab_sped_depo.NUM_BOLLA_OUT) then kst_sped_ddt[k_riga_ddt].kst_tab_sped_depo.NUM_BOLLA_OUT = 0
			if isnull(kst_sped_ddt[k_riga_ddt].kst_tab_sped_depo.DATA_BOLLA_OUT) then kst_sped_ddt[k_riga_ddt].kst_tab_sped_depo.DATA_BOLLA_OUT = date(0)
			
			kst_tab_sped_depo.num_bolla_out = kst_sped_ddt[k_riga_ddt].kst_tab_sped_depo.NUM_BOLLA_OUT
			kst_tab_sped_depo.data_bolla_out = kst_sped_ddt[k_riga_ddt].kst_tab_sped_depo.DATA_BOLLA_OUT

			k_riga_ddt++
			fetch c_get_ddt_da_stampare 
				into
				:kst_sped_ddt[k_riga_ddt].kst_tab_sped_depo.id_sped_depo
				,:kst_sped_ddt[k_riga_ddt].kst_tab_sped_depo.NUM_BOLLA_OUT
				,:kst_sped_ddt[k_riga_ddt].kst_tab_sped_depo.DATA_BOLLA_OUT;
				
		loop
	
		close c_get_ddt_da_stampare;
		
	end if
	
//--- 
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = &
				"Errore durante lettura DDT da stampare ~n~r" &
							+ "Ultimo ddt letto: " + string(kst_tab_sped_depo.NUM_BOLLA_OUT, "####0") + " del " &
							+ string(kst_tab_sped_depo.DATA_BOLLA_OUT, "dd.mm.yyyy") &	
							+ " ~n~rErrore-tab.SPED:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kuo_exception = create uo_exception
		kuo_exception.set_esito( kst_esito)
		throw kuo_exception
	end if

return k_riga_ddt

end function

public function st_esito anteprima_1 (datastore kdw_anteprima, st_tab_sped_depo kst_tab_sped_depo);//
//=== 
//====================================================================
//=== Operazione di Anteprima (Testata Spedizione)
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


kst_esito = kguo_exception.inizializza(this.classname())

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.not_fnd

else

	if kst_tab_sped_depo.id_sped_depo > 0 then

		kdw_anteprima.dataobject = "d_sped_1"		
		kdw_anteprima.settransobject(sqlca)

//		kuf1_utility = create kuf_utility
//		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//		destroy kuf1_utility

		kdw_anteprima.reset()	
		try
			k_rc=kdw_anteprima.retrieve(kst_tab_sped_depo.id_sped_depo)
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
		end try
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Riga Spedizione da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = kkg_esito.err_logico
		
	end if
end if

return kst_esito

end function

public function st_esito anteprima_1 (datawindow kdw_anteprima, st_tab_sped_depo kst_tab_sped_depo);//
//=== 
//====================================================================
//=== Operazione di Anteprima (Testata Spedizione)
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


kst_esito = kguo_exception.inizializza(this.classname())

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.not_fnd

else

	if kst_tab_sped_depo.id_sped_depo > 0 then

		kdw_anteprima.dataobject = "d_sped_1"		
		kdw_anteprima.settransobject(sqlca)

		kuf1_utility = create kuf_utility
		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
		destroy kuf1_utility

//		k_rc=kdw_anteprima.retrieve(kst_tab_sped_depo.data_bolla_out, kst_tab_sped_depo.num_bolla_out)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Riga Lotto da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = kkg_esito.err_logico
		
	end if
end if

return kst_esito

end function

public function st_esito anteprima (datastore kds_anteprima, st_tab_sped_depo kst_tab_sped_depo);//=== 
//====================================================================
//=== Operazione di Anteprima (Testata Spedizione)
//===
//=== Par. Inut: 
//===               datastore su cui fare l'anteprima
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
long k_n_ddt_stampate=0
st_open_w kst_open_w
st_esito kst_esito
st_ddt_depo_stampa kst_ddt_depo_stampa[]
kuf_sped_depo_ddt kuf1_sped_depo_ddt
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility
datawindow kdw_nullo


kst_esito = kguo_exception.inizializza(this.classname())

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_sped_depo.id_sped_depo > 0 then

//--- retrive dell'attestato 
	
		try 

//---- inizializza x stampa 
			kuf1_sped_depo_ddt = create kuf_sped_depo_ddt

			kst_ddt_depo_stampa[1].num_bolla_out = kst_tab_sped_depo.num_bolla_out
			kst_ddt_depo_stampa[1].data_bolla_out =  kst_tab_sped_depo.data_bolla_out
			kst_ddt_depo_stampa[1].id_sped_depo =  kst_tab_sped_depo.id_sped_depo
			
//--- produce ddt	
			k_n_ddt_stampate = kuf1_sped_depo_ddt.produci_ddt(kst_ddt_depo_stampa[])
		
			if k_n_ddt_stampate > 0 then
				kds_anteprima.dataobject = kuf1_sped_depo_ddt.kids_stampa_ddt.dataobject  //kuf1_sped_depo_ddt.ki_dw_stampa_ddt		
				kds_anteprima.settransobject(sqlca)
		
				kds_anteprima.reset()	

				kuf1_sped_depo_ddt.produci_ddt_set_dw_loghi(kds_anteprima, kdw_nullo)
				kuf1_sped_depo_ddt.kids_stampa_ddt.rowscopy(1,kuf1_sped_depo_ddt.kids_stampa_ddt.rowcount(),Primary!,kds_anteprima,1,Primary!)
			end if
			
		catch (uo_exception kuo_exception)
				kst_esito = kuo_exception.get_st_esito()

		finally
//--- distrugge oggetti x stampa ddt
			if isvalid(kuf1_sped_depo_ddt) then destroy kuf1_sped_depo_ddt
				
		end try
		
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Riga Spedizione da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = kkg_esito.err_logico
		
	end if
end if

return kst_esito

end function

public function st_esito anteprima (datawindow kdw_anteprima, st_tab_sped_depo kst_tab_sped_depo);//
//=== 
//====================================================================
//=== Operazione di Anteprima (Testata Spedizione)
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
long k_n_ddt_stampate=0
boolean k_return
st_ddt_depo_stampa kst_ddt_depo_stampa[]
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility
kuf_sped_depo_ddt kuf1_sped_depo_ddt
datastore kds_nullo


kst_esito = kguo_exception.inizializza(this.classname())

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_sped_depo.num_bolla_out > 0 then

		try 
				
//---- inizializza x stampa ddt
			kuf1_sped_depo_ddt = create kuf_sped_depo_ddt
//			kuf1_sped_depo_ddt.produci_ddt_inizializza(kst_tab_sped_depo)
			
			kst_ddt_depo_stampa[1].num_bolla_out = kst_tab_sped_depo.num_bolla_out
			kst_ddt_depo_stampa[1].data_bolla_out =  kst_tab_sped_depo.data_bolla_out
			kst_ddt_depo_stampa[1].id_sped_depo =  kst_tab_sped_depo.id_sped_depo
			
//--- produci_ddt
			k_n_ddt_stampate = kuf1_sped_depo_ddt.produci_ddt(kst_ddt_depo_stampa[])
		
			if k_n_ddt_stampate > 0 then
				kdw_anteprima.dataobject = kuf1_sped_depo_ddt.kids_stampa_ddt.dataobject  //kuf1_sped_depo_ddt.ki_dw_stampa_ddt		
				kdw_anteprima.settransobject(sqlca)
				kuf1_utility = create kuf_utility
				kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
	
				kdw_anteprima.reset()	

				kuf1_sped_depo_ddt.produci_ddt_set_dw_loghi(kds_nullo, kdw_anteprima)
				kuf1_sped_depo_ddt.kids_stampa_ddt.rowscopy(1,kuf1_sped_depo_ddt.kids_stampa_ddt.rowcount(),Primary!,kdw_anteprima,1,Primary!)
				kGuf_data_base.dw_copia_attributi_generici(kuf1_sped_depo_ddt.kids_stampa_ddt, kdw_anteprima)
			end if
						
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()

		finally
//--- distrugge oggetti x stampa ddt
			if isvalid(kuf1_sped_depo_ddt) then destroy kuf1_sped_depo_ddt
			if isvalid(kuf1_utility) then destroy kuf1_utility
				
		end try

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Riga Spedizione da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = kkg_esito.err_logico
	end if
end if

return kst_esito

end function

public function st_esito anteprima_2 (datastore kdw_anteprima, st_tab_sped_depo kst_tab_sped_depo);//
//=== 
//====================================================================
//=== Operazione di Anteprima (Testata Spedizione)
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


kst_esito = kguo_exception.inizializza(this.classname())

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.not_fnd

else

	if kst_tab_sped_depo.num_bolla_out > 0 then

		kdw_anteprima.dataobject = "d_sped_wm_l"		
		kdw_anteprima.settransobject(sqlca)

//		kuf1_utility = create kuf_utility
//		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//		destroy kuf1_utility

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_sped_depo.num_bolla_out, kst_tab_sped_depo.data_bolla_out)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Riga Spedizione da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = kkg_esito.err_logico
		
	end if
end if

return kst_esito

end function

public function boolean u_open_stampa (st_tab_sped_depo kst_tab_sped_depo[]);//---
//--- Stampa sped_depo
//---
//---
boolean k_return = false
long k_riga=0
integer k_ctr, k_max
st_sped_ddt kst_sped_ddt[]
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window


try 

	this.if_sicurezza(kkg_flag_modalita.stampa)		
		
//--- Cicla fino a che ci sono righe selezionate
	k_riga=0
	k_max = UpperBound(kst_tab_sped_depo)
	for k_ctr = 1 to k_max
		
		if kst_tab_sped_depo[k_ctr].num_bolla_out > 0 then
			k_riga++
			kst_sped_ddt[k_riga].kst_tab_sped_depo.id_sped_depo = kst_tab_sped_depo[k_ctr].id_sped_depo
			kst_sped_ddt[k_riga].kst_tab_sped_depo.num_bolla_out = kst_tab_sped_depo[k_ctr].num_bolla_out
			kst_sped_ddt[k_riga].kst_tab_sped_depo.data_bolla_out = kst_tab_sped_depo[k_ctr].data_bolla_out
			kst_sped_ddt[k_riga].sel = 1
				
		end if								
	next

	if k_riga > 0 then	

		//=== Parametri : 
		//=== struttura st_open_w
		//=== dati particolare programma
		//
		//=== Si potrebbero passare:
		//=== key=codice prodotto;
		kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.stampa)
		Kst_open_w.flag_primo_giro = "S"
		Kst_open_w.flag_modalita = kkg_flag_modalita.stampa
		Kst_open_w.flag_adatta_win = KKG.ADATTA_WIN_NO
		Kst_open_w.flag_leggi_dw = "N"
		kst_open_w.key12_any = kst_sped_ddt[]   // struttura
		kst_open_w.flag_where = " "
			
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window
	
		k_return = true
		
	end if
	
catch (uo_exception kuo_exception1)
	kuo_exception1.messaggio_utente()
	
finally
//	if isvalid(kuf1_sped_depo_ddt) then destroy kuf1_sped_depo_ddt
	
end try


return k_return

end function

public function boolean if_esiste (st_tab_sped_depo kst_tab_sped_depo) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla esistenza DDT da id_sped_depo
//--- 
//--- 
//--- Inp: st_tab_sped_depo.id
//--- Out: TRUE = esiste
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
long k_trovato=0
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

//--- x numero spedicato			
	SELECT count(*)
			into :k_trovato
			 FROM sped  
			 where  id_sped_depo  = :kst_tab_sped_depo.id_sped_depo
           using kguo_sqlca_db_magazzino ;
		
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura DDT (sped) id = " + string(kst_tab_sped_depo.id_sped_depo) + " " &
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

public function boolean get_id_armo_max (ref st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna id_armo piu' alto contenuto in un DDT (da ID di spedizione)
//--- 
//--- 
//--- Inp: st_tab_arsp_depo.id_sped_depo
//--- Out: st_tab_arsp_depo.id_armo
//---
//--- Ritorna: TRUE = ok
//---
//---Lancia EXCEPTION
//---
//----------------------------------------------------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())
	
	if kst_tab_arsp_depo.id_sped_depo > 0 then
		
		SELECT max(id_armo)
		 INTO 
		  	:kst_tab_arsp_depo.id_armo
	 	FROM arsp_depo  
		WHERE  id_sped_depo = :kst_tab_arsp_depo.id_sped_depo 
           using kguo_sqlca_db_magazzino ;
	
	end if

	if isnull(kst_tab_arsp_depo.id_armo) then kst_tab_arsp_depo.id_armo = 0
	
	if sqlca.sqlcode = 0 then
		if kst_tab_arsp_depo.id_armo > 0 then k_return = true
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante in ID movim. di entrata nel ddt di sped_depo., id sped_depo.=" + string(kst_tab_arsp_depo.id_sped_depo) +" ~n~r" &
									 + trim(SQLCA.SQLErrText)
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
	
return k_return

end function

public function long get_colli_x_id_armo (st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Trova colli spediti x id_armo
//---
//--- inp: st_tab_arsp_depo.id_armo 
//--- out: 
//--- Rit: Numero colli
//---
//--- lancia EXCEPTION
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if kst_tab_arsp_depo.id_armo > 0 then
	SELECT sum (arsp_depo.colli)
		 INTO :kst_tab_arsp_depo.colli   
		 FROM arsp_depo  
		WHERE id_armo = :kst_tab_arsp_depo.id_armo
		using kguo_sqlca_db_magazzino ;
				  
	if sqlca.sqlcode <> 0 then
		kst_tab_arsp_depo.colli = 0
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura numero colli x riga lotto. Tab righe ddt, id riga lotto: " + string( kst_tab_arsp_depo.id_armo) + " ~n~r" + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. righe ddt. Manca id Riga Lotto (Riferimento) !" 
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if	
	
if isnull(kst_tab_arsp_depo.colli) then kst_tab_arsp_depo.colli = 0
	
 
return  kst_tab_arsp_depo.colli   	



end function

public function st_esito get_numero_da_id (ref st_tab_sped_depo kst_tab_sped_depo);//
//--- Piglia il NUMERO e DATA spedizione da id_arsp_depo
//
//--- inp: st_tab_arsp_depo.id_arsp_depo
//--- out: st_esito
//
//
long k_codice
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

SELECT distinct sped_depo.num_bolla_out
  			,sped_depo.data_bolla_out   
    INTO :kst_tab_sped_depo.num_bolla_out,   
         :kst_tab_sped_depo.data_bolla_out  
    FROM sped_depo  
   WHERE ( id_sped_depo = :kst_tab_sped_depo.id_sped_depo ) 
           using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore tab. d.d.t., bolla di spedizione deposito (id=" + string( kst_tab_sped_depo.id_sped_depo) + "): ~n~r" &
									 + trim(SQLCA.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if
	
return kst_esito

end function

public function boolean get_id_sped_depo_anno (ref st_tab_sped_depo kst_tab_sped_depo) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna id_sped_depo da numero + anno di data bolla
//--- 
//--- 
//--- Inp: kst_tab_sped_depo.num_bolla_out/data_bolla_out (anno)
//--- Out: kst_tab_sped_depo.id_sped_depo
//---
//--- Ritorna: TRUE = ok
//---
//---Lancia EXCEPTION
//---
//----------------------------------------------------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito
integer k_anno

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
	if kst_tab_sped_depo.num_bolla_out > 0 then
		
		k_anno = year(kst_tab_sped_depo.data_bolla_out)
		
		SELECT id_sped_depo
		 INTO 
		  	:kst_tab_sped_depo.id_sped_depo
	 	FROM sped  
		WHERE ( num_bolla_out = :kst_tab_sped_depo.num_bolla_out ) AND  
						year(data_bolla_out) = :k_anno
			  using sqlca;
	
	end if
	
	if sqlca.sqlcode = 0 then
		if kst_tab_sped_depo.id_sped_depo > 0 then k_return = true
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura ID del ddt di sped_depo., numero/anno=" + string( kst_tab_sped_depo.num_bolla_out) + " / "+ string( kst_tab_sped_depo.data_bolla_out, "yyyy" )+" ~n~r" &
									 + trim(SQLCA.SQLErrText)
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
	
return k_return


end function

public subroutine elenco_note (st_tab_sped_depo kst_tab_sped_depo);//
//--- Fa l'elenco delle NOTE caricate in documenti precedenti
//
st_open_w kst_open_w
string k_nome
kuf_elenco kuf1_elenco
datastore kds_1
pointer kp_oldpointer  // Declares a pointer variable


kp_oldpointer = SetPointer(HourGlass!)

	
	if not isvalid(kds_1) then
		kds_1 = create datastore
	end if
	kds_1.dataobject = kki_dw_elenco_note
	kds_1.settransobject(sqlca) 
	
	if kst_tab_sped_depo.clie_2 > 0 then
		
		kst_tab_sped_depo.data_bolla_out = relativedate(kG_dataoggi, -180)
		
		kds_1.retrieve( kst_tab_sped_depo.clie_2,  kst_tab_sped_depo.data_bolla_out)
	
		if kds_1.rowcount() > 0 then
		
		//--- chiamare la window di elenco
		//
		//=== Parametri : 
		//=== struttura st_open_w
			kuf1_elenco = create kuf_elenco
			kst_open_w.id_programma =kkg_id_programma.elenco
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key1 = "Elenco Note ddt per il Ricevente: " + string( kst_tab_sped_depo.clie_2 ) + " dal " + string(kst_tab_sped_depo.data_bolla_out) //+ " " + trim(k_nome)
			kst_open_w.key2 = trim(kds_1.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key12_any = kds_1
			kst_open_w.key7 = kuf1_elenco.ki_esci_dopo_scelta  // esce subito dopo la scelta
			kuf1_elenco.u_open(kst_open_w)
		
		else
			messagebox("Elenco Note", "Nessun valore disponibile per il Ricevente: " + string( kst_tab_sped_depo.clie_2 ) + " dal " + string(kst_tab_sped_depo.data_bolla_out))
			
		end if
	end if
						
SetPointer(kp_oldpointer)

end subroutine

public subroutine elenco_indirizzi_ddt (st_tab_sped_depo kst_tab_sped_depo);//
//--- Fa l'elenco Indirizzi di spedizione 
//
st_open_w kst_open_w
kuf_elenco kuf1_elenco


	SetPointer(kkg.pointer_attesa)

	if kst_tab_sped_depo.clie_2 > 0 then
	
		if u_set_ds_d_sped_depo_l_indirizzi(kst_tab_sped_depo) > 0 then
		
			kuf1_elenco = create kuf_elenco
			kst_open_w.id_programma =kkg_id_programma_elenco
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key1 = "Elenco Indirizzi per il Ricevente: " + string( kst_tab_sped_depo.clie_2 ) 
			kst_open_w.key2 = trim(kdsi_d_sped_depo_l_indirizzi.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key12_any = kdsi_d_sped_depo_l_indirizzi
			kst_open_w.key7 = kuf1_elenco.ki_esci_dopo_scelta  // esce subito dopo la scelta
			kuf1_elenco.u_open(kst_open_w)
		
		else
			messagebox("Elenco Indirizzi", "Nessun valore disponibile per il Ricevente: " + string( kst_tab_sped_depo.clie_2 ))
		end if
	end if
						
	SetPointer(kkg.pointer_default)

end subroutine

public function boolean if_cancella (st_tab_sped_depo ast_tab_sped_depo) throws uo_exception;//--
//---  Consentire a la cancellazione del Documento? 
//---
//---  input: st_tab_sped_depo.id_sped_depo
//---  otput: boolean   TRUE = utente autorizzato
//---  se ERRORE lancia un Exception
//---
boolean k_return = false


try 

	
//--- autorizzato alla cancellazione?
	if not if_sicurezza(kkg_flag_modalita.cancellazione) then 
		throw kguo_exception
	end if

//--- get del numero e data bolla
	if ast_tab_sped_depo.num_bolla_out > 0 then
	else
		get_numero_da_id(ast_tab_sped_depo)
	end if
	
////--- controlla se lotto chiuso
//	if if_chiuso(ast_tab_sped_depo) then
//		if if_modifica_chiuso() then
//			kguo_exception.inizializza()
//			kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_dati_wrn )
//			kguo_exception.setmessage(  &
//			"Attenzione, il Documento e' ga' Consolidato. Utente Autorizzato alla Cancellazione. ~n~r" + &
//			"(ID Documento cercato:" + string(ast_tab_sped_depo.id_sped_depo) + ") " )
//		else
//			kguo_exception.inizializza()
//			kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_noaut )
//			kguo_exception.setmessage(  &
//			"Mi spiace, il Documento e' ga' Consolidato. Utente non autorizzato alla Cancellazione. ~n~r" + &
//			"(ID Documento cercato:" + string(ast_tab_sped_depo.id_sped_depo) + ") " )
//			throw kguo_exception
//		end if
//	end if

	k_return = true
	
catch (uo_exception kuo_exception)
	throw kuo_exception

end try



return k_return

end function

public function boolean if_modifica (st_tab_sped_depo ast_tab_sped_depo) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla se DDT è modificabile x id_sped_depo
//--- 
//--- 
//--- Inp: st_tab_sped_depo.id_sped_depo
//--- Out: TRUE = si è possibile fare modifiche
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
long k_trovato=0
datastore kds_arsp_nochiuso
st_esito kst_esito
st_tab_sped_depo kst_tab_sped_depo


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()

kds_arsp_nochiuso = create datastore
kds_arsp_nochiuso.dataobject = "ds_arsp_chiuso_x_id_sped_depo"
kds_arsp_nochiuso.settransobject(kguo_sqlca_db_magazzino)

//--- se torna anche solo una riga vuol dire che c'e' almeno un lotto chiuso nel ddt!!!
k_trovato = kds_arsp_nochiuso.retrieve(kst_tab_sped_depo.id_sped_depo)
if k_trovato = 0 then
	k_return = true
else
	if k_trovato < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante verifica se DDT ha lotti chiusi (sped) id = " + string(ast_tab_sped_depo.id_sped_depo) 
		kst_esito.esito = KKG_ESITO.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
end if
		

return k_return



end function

public function boolean tb_update_numero_data (st_tab_sped_depo kst_tab_sped_depo) throws uo_exception;//
//====================================================================
//=== Cambia il numero e data DDT 
//=== 
//=== Input: st_tab_sped_depo  id_sped_depo e i nuovi valori di num_bolla_out e data_bolla_out
//=== Ritorna:       ST_ESITO 
//=== 
//====================================================================
//
boolean k_return=false
int k_resp
st_esito kst_esito
st_tab_ricevute kst_tab_ricevute, kst_tab_ricevute_old
st_tab_prof kst_tab_prof, kst_tab_prof_old
st_open_w kst_open_w


try
	kst_esito = kguo_exception.inizializza(this.classname())

	if if_sicurezza(kkg_flag_modalita.modifica) then

		if kst_tab_sped_depo.id_sped_depo > 0 then

		//--- Modifica TESTATA							
			update sped_depo
				set numpref_bolla_out = :kst_tab_sped_depo.numpref_bolla_out
					 ,num_bolla_out = :kst_tab_sped_depo.num_bolla_out
					 ,data_bolla_out = :kst_tab_sped_depo.data_bolla_out
				WHERE id_sped_depo = :kst_tab_sped_depo.id_sped_depo
				using kguo_sqlca_db_magazzino;
		
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore durante la Modifica della tesatat DDT deposito ~n~r" &
					+ string(kst_tab_sped_depo.num_bolla_out, "####0") + " del " &
					+ string(kst_tab_sped_depo.data_bolla_out, "dd.mm.yyyy") &	
					+ " ~n~rErrore-tab.sped:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

		//---- COMMIT....	
			if kst_esito.esito = kkg_esito.db_ko then
				if kst_tab_sped_depo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped_depo.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_rollback_1( )
				end if
			else
				if kst_tab_sped_depo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped_depo.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_commit_1( )
				end if
			end if
		
			k_return = true // OK!!!!!
		end if
	end if
		
catch (uo_exception kuo_exception)
	throw kguo_exception
	
end try


return k_return

end function

public function long tb_insert_testa (ref st_tab_sped_depo kst_tab_sped_depo) throws uo_exception;//
//--- Inserisce Nuova Testata DDT
//--- torna il ID st_tab_sped_depo.id_sped_depo
//
long k_return = 0
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if if_sicurezza(kkg_flag_modalita.inserimento) then
	
//#--- 19.11.2012 --- legge dato da tab CAUS -----------------------------------
   kst_tab_sped_depo.ddt_st_num_data_in = "S"
   if kst_tab_sped_depo.caus_codice > " " then
      select ddt_st_num_data_in
           into :kst_tab_sped_depo.ddt_st_num_data_in
               from   CAUS
               where  CAUS.CODICE = :kst_tab_sped_depo.caus_codice
			using kguo_sqlca_db_magazzino;
   end if
//#----------------------------------------------------------------------------------------------------

	if_isnull_testa(kst_tab_sped_depo)
	
	kst_tab_sped_depo.stampa = "N" 
	
	kst_tab_sped_depo.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_sped_depo.x_utente = kGuf_data_base.prendi_x_utente()
	kst_tab_sped_depo.note_1 = trim(kst_tab_sped_depo.note_1)
	kst_tab_sped_depo.note_2 = trim(kst_tab_sped_depo.note_2)
	kst_tab_sped_depo.rag_soc_1 = trim(kst_tab_sped_depo.rag_soc_1)
	kst_tab_sped_depo.rag_soc_2 = trim(kst_tab_sped_depo.rag_soc_2)
	kst_tab_sped_depo.indi = trim(kst_tab_sped_depo.indi)
	kst_tab_sped_depo.loc = trim(kst_tab_sped_depo.loc)
	
	// id_sped_depo, 
	INSERT INTO sped  
         (  
           numpref_bolla_out,   
           num_bolla_out,   
           data_bolla_out,   
           clie_2,   
           clie_3,   
           cura_trasp,   
           causale,   
			caus_codice, 
           ddt_st_num_data_in,   
           aspetto,   
           porto,   
           mezzo,   
           note_1,   
           note_2,   
           data_rit,   
           ora_rit,   
           vett_1,   
           vett_2,   
           stampa,   
           colli,   
           data_uscita,   
           rag_soc_1,   
           rag_soc_2,   
           indi,   
           loc,   
           cap,   
           prov,   
           id_nazione,   
           id_docprod,   
			sv_call_vettore,
           form_di_stampa,   
           x_datins,   
           x_utente 
           )  
  VALUES (    
           :kst_tab_sped_depo.numpref_bolla_out,
           :kst_tab_sped_depo.num_bolla_out,   
           :kst_tab_sped_depo.data_bolla_out,   
           :kst_tab_sped_depo.clie_2,   
           :kst_tab_sped_depo.clie_3,   
           :kst_tab_sped_depo.cura_trasp,   
           :kst_tab_sped_depo.causale,   
           :kst_tab_sped_depo.caus_codice,			  
           :kst_tab_sped_depo.ddt_st_num_data_in,   
           :kst_tab_sped_depo.aspetto,   
           :kst_tab_sped_depo.porto,   
           :kst_tab_sped_depo.mezzo,   
           :kst_tab_sped_depo.note_1,   
           :kst_tab_sped_depo.note_2,   
           :kst_tab_sped_depo.data_rit,   
           :kst_tab_sped_depo.ora_rit,   
           :kst_tab_sped_depo.vett_1,   
           :kst_tab_sped_depo.vett_2,   
           :kst_tab_sped_depo.stampa,   
           :kst_tab_sped_depo.colli,   
           :kst_tab_sped_depo.data_uscita,   
           :kst_tab_sped_depo.rag_soc_1,   
           :kst_tab_sped_depo.rag_soc_2,   
           :kst_tab_sped_depo.indi,   
           :kst_tab_sped_depo.loc,   
           :kst_tab_sped_depo.cap,   
           :kst_tab_sped_depo.prov,   
           :kst_tab_sped_depo.id_nazione,   
           :kst_tab_sped_depo.id_docprod,   
			:kst_tab_sped_depo.sv_call_vettore,
			:kst_tab_sped_depo.form_di_stampa,   
           :kst_tab_sped_depo.x_datins,   
           :kst_tab_sped_depo.x_utente   
           )  
			using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in inserim. Tab. DDT. (nr.=" + string(kst_tab_sped_depo.num_bolla_out) + " del "  + string(kst_tab_sped_depo.data_bolla_out) +") : " &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	else
		kst_tab_sped_depo.id_sped_depo = get_id_sped_depo_max(kst_tab_sped_depo.numpref_bolla_out)
		//kst_tab_sped_depo.id_sped_depo = long(kguo_sqlca_db_magazzino.SQLReturnData)
		if kst_tab_sped_depo.id_sped_depo > 0 then
			k_return = kst_tab_sped_depo.id_sped_depo 
		end if
//---- COMMIT....	
		if kst_tab_sped_depo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped_depo.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if

end if

return k_return


end function

public function integer get_nr_righe (st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna numero righe del DDT
//--- 
//--- 
//--- Inp: st_tab_arsp_depo.id_sped_depo
//--- Out: --
//--- Ritorna: numero di righe ddt
//---
//---Lancia EXCEPTION
//---
//----------------------------------------------------------------------------------------------------------------
int k_return=0
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())
	
	if kst_tab_arsp_depo.id_sped_depo > 0 then
		
		SELECT count(id_sped_depo)
		 INTO 
		  	:k_return
	 	FROM arsp_depo  
		WHERE  id_sped_depo = :kst_tab_arsp_depo.id_sped_depo 
			  using kguo_sqlca_db_magazzino;
	
	end if

	if isnull(k_return) then k_return = 0
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante calcolo nr righe ddt di arsp_depo., id ddt " + string(kst_tab_arsp_depo.id_sped_depo) +" ~n~r" &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
	
return k_return


end function

public function long get_id_armo (st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna id_armo della riga
//--- 
//--- 
//--- Inp: st_tab_arsp_depo.id_arsp_depo
//--- Out: --
//---
//--- Ritorna: id_armo
//---
//---Lancia EXCEPTION
//---
//----------------------------------------------------------------------------------------------------------------
long k_return=0
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())
	
	if kst_tab_arsp_depo.id_arsp_depo > 0 then
		
		SELECT id_armo
		 INTO 
		  	:kst_tab_arsp_depo.id_armo
	 	FROM arsp_depo  
		WHERE  id_arsp_depo = :kst_tab_arsp_depo.id_arsp_depo 
			  using kguo_sqlca_db_magazzino;
	
	end if

	if isnull(kst_tab_arsp_depo.id_armo) then kst_tab_arsp_depo.id_armo = 0
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_arsp_depo.id_armo > 0 then k_return = kst_tab_arsp_depo.id_armo
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura ID entrata nella riga ddt di sped_depo., id riga " + string(kst_tab_arsp_depo.id_sped_depo) +" ~n~r" &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
	
return k_return


end function

public function string get_stampa (st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception;//
//--- Torna stampa  
//
//--- inp: st_tab_arsp_depo.id_arsp_depo
//--- Rit: stampa 
//--- Lancia exception st_esito
//
string k_return = ""
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if kst_tab_arsp_depo.id_arsp_depo > 0 then
	
	SELECT arsp_depo.stampa
		 INTO :kst_tab_arsp_depo.stampa   
		 FROM arsp_depo  
		WHERE id_arsp_depo = :kst_tab_arsp_depo.id_arsp_depo
	  using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_tab_arsp_depo.colli = 0
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettrura flag stampa della riga ddt, id riga " + string( kst_tab_arsp_depo.id_arsp_depo) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
		end if
	else
		if isnull(kst_tab_arsp_depo.stampa) then kst_tab_arsp_depo.stampa = kki_sped_depo_flg_stampa_bolla_da_stamp
		k_return = kst_tab_arsp_depo.stampa 
	end if
else
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Errore in lettrura flag stampa della riga ddt, manca id riga lotto! " 
	kst_esito.esito = kkg_esito.err_logico
			
end if	
	
return k_return



end function

public function long get_colli (st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception;//
//--- Torna colli 
//
//--- inp: st_tab_arsp_depo.id_arsp_depo
//--- rit: colli = Numero colli; 0=nessuno
//--- Lancia exception st_esito
//
long k_return = 0
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if kst_tab_arsp_depo.id_arsp_depo > 0 then
	
	SELECT arsp_depo.colli
		 INTO :kst_tab_arsp_depo.colli   
		 FROM arsp_depo  
		WHERE id_arsp_depo = :kst_tab_arsp_depo.id_arsp_depo
	  using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_tab_arsp_depo.colli = 0
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore calcolo colli spediti, id riga " + string( kst_tab_arsp_depo.id_arsp_depo) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
		end if
	else
		if kst_tab_arsp_depo.colli > 0 then
			k_return = kst_tab_arsp_depo.colli 
		end if
	end if
else
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Calcolo colli spediti non eseguito, manca id riga lotto! " 
	kst_esito.esito = kkg_esito.err_logico
			
end if	
	
return k_return

end function

public function long get_id_sped_depo (st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna id_arsp_depo da id riga
//--- 
//--- 
//--- Inp: st_tab_arsp_depo.id_arsp_depo
//--- Rit: kst_tab_arsp_depo.id_sped_depo
//---
//---
//---Lancia EXCEPTION
//---
//----------------------------------------------------------------------------------------------------------------
long k_return=0
int k_anno = 0
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())
	
	if kst_tab_arsp_depo.id_arsp_depo > 0 then
		
		SELECT id_sped_depo
		 INTO 
		  	:kst_tab_arsp_depo.id_sped_depo
	 	FROM arsp_depo  
		WHERE id_arsp_depo = :kst_tab_arsp_depo.id_arsp_depo  
		  using kguo_sqlca_db_magazzino;
	
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_arsp_depo.id_arsp_depo > 0 then k_return = kst_tab_arsp_depo.id_arsp_depo
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura ID del ddt da id riga, id= " + string( kst_tab_arsp_depo.id_arsp_depo) + " ~n~r" &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
	
return k_return


end function

public function boolean tb_delete_riga (st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception;//
//====================================================================
//=== Cancella il rek dalla tabella sped_depo-ARSP_sped (Bolle di spedizione) 
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//=== 
//====================================================================
//
boolean k_return=false
st_esito kst_esito
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe
kuf_armo_prezzi kuf1_armo_prezzi
kuf_wm_pklist_righe kuf1_wm_pklist_righe
st_tab_sped_depo kst_tab_sped_depo


try
	kst_esito = kguo_exception.inizializza(this.classname())

	if if_sicurezza(kkg_flag_modalita.cancellazione) then  // Controllo se utente autorizzato
		
		kst_tab_arsp_depo.ID_ARMO = get_id_armo(kst_tab_arsp_depo)
		kst_tab_arsp_depo.colli = get_colli(kst_tab_arsp_depo)
//		
////--- Ripristina i colli in Prezzi-riga-lotto della riga
//		kst_tab_arsp_depo.STAMPA = get_stampa(kst_tab_arsp_depo)
//		kst_tab_armo_prezzi.id_armo = kst_tab_arsp_depo.ID_ARMO
//		kst_tab_armo_prezzi.item_dafatt = kst_tab_arsp_depo.colli
//		kuf1_armo_prezzi = create kuf_armo_prezzi
//		if kst_tab_arsp_depo.STAMPA = kki_sped_depo_flg_stampa_bolla_stampata then // ripristino sono se 'stampato' 
//			kst_tab_armo_prezzi.st_tab_g_0.esegui_commit	= "N"
//			kuf1_armo_prezzi.esegui_evento_scarico_ripristina(kst_tab_armo_prezzi)		// RIPRISTINA colli 
//		end if

//--- Ripristina il flag di righe WMF 			
		kuf1_wm_pklist_righe = create kuf_wm_pklist_righe
		kst_tab_wm_pklist_righe.id_armo = kst_tab_arsp_depo.ID_ARMO
		kst_esito = kuf1_wm_pklist_righe.if_esiste_in_sped_x_id_armo(kst_tab_wm_pklist_righe)		//Controlla se esiste il PKLIST
//--- se esiste il pk-list aggiorna					
		if kst_esito.esito = kkg_esito.ok then
			kst_esito = kuf1_wm_pklist_righe.set_sped_no_x_id_armo(kst_tab_wm_pklist_righe)		// AGGIORNA PackingList a NON SPEDITO (reset)
		end if

	
	//--- cancella prima tutte le righe
		delete from arsp_depo
			where id_arsp_depo = :kst_tab_arsp_depo.id_arsp_depo
			using kguo_sqlca_db_magazzino; 
			
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = &
		"Errore durante la cancellazione riga del DDT (id riga " &
						+ string(kst_tab_arsp_depo.id_arsp_depo, "####0") &	
						+ " ~n~rErrore-tab.ARSP:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

////--- piglia il ID
//		if kst_tab_sped_depo.id_sped_depo > 0 then
//		else
//			kst_tab_sped_depo.id_sped_depo = get_id_sped_depo(kst_tab_arsp_depo)
//		end if
//
////--- se non trovo righe nel DDT lo rimuovo
//		if kst_tab_sped_depo.id_sped_depo > 0 then
//			if get_nr_righe(kst_tab_arsp_depo) = 0 then		
//				tb_delete_testa(kst_tab_sped_depo)			
//			end if
//		end if
		
//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_arsp_depo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arsp_depo.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		else
			if kst_tab_arsp_depo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arsp_depo.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		end if
				
	end if
	
catch (uo_exception kuo1_exception)
	kst_esito = kuo1_exception.get_st_esito()
	
end try


return k_return

end function

public function long tb_insert_riga (ref st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception;//
//--- Inserisce Nuova Riga DDT
//--- torna il ID della ddt nel st_tab_arsp_depo.id_arsp_depo
//
long k_return = 0
long k_codice
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if if_sicurezza(kkg_flag_modalita.inserimento) then

	if_isnull_riga(kst_tab_arsp_depo)

	kst_tab_arsp_depo.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_arsp_depo.x_utente = kGuf_data_base.prendi_x_utente()
		//id_arsp_depo, 
	  INSERT INTO arsp_depo  
         (   
           id_sped_depo,   
           nriga,   
           colli,   
           note_1,   
           note_2,   
           note_3,   
           stampa,   
           colli_out,   
           peso_kg_out,   
           id_armo,   
           x_datins,   
           x_utente )  
  VALUES (   
            :kst_tab_arsp_depo.id_sped_depo,   
            :kst_tab_arsp_depo.nriga,   
            :kst_tab_arsp_depo.colli,   
            :kst_tab_arsp_depo.note_1,   
            :kst_tab_arsp_depo.note_2,   
            :kst_tab_arsp_depo.note_3,   
            :kst_tab_arsp_depo.stampa,   
            :kst_tab_arsp_depo.colli_out,   
            :kst_tab_arsp_depo.peso_kg_out,   
            :kst_tab_arsp_depo.id_armo,   
            :kst_tab_arsp_depo.x_datins,   
            :kst_tab_arsp_depo.x_utente )  
			using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in inserim. riga DDT. (id =" + string(kst_tab_arsp_depo.id_sped_depo) + " riga lotto "  + string(kst_tab_arsp_depo.id_armo) +") : " &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	else
		kst_tab_arsp_depo.id_arsp_depo = get_id_arsp_depo_max()
		//kst_tab_arsp_depo.id_arsp_depo = long(kguo_sqlca_db_magazzino.SQLReturnData)
		if kst_tab_arsp_depo.id_arsp_depo > 0 then
			k_return = kst_tab_arsp_depo.id_arsp_depo
		end if
//---- COMMIT....	
		if kst_tab_arsp_depo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arsp_depo.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if

end if

return k_return


end function

public subroutine tb_update_riga (ref st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception;//
//--- Aggiorna Riga DDT
//--- torna 
//
long k_codice
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if if_sicurezza(kkg_flag_modalita.inserimento) then

	if_isnull_riga(kst_tab_arsp_depo)

	kst_tab_arsp_depo.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_arsp_depo.x_utente = kGuf_data_base.prendi_x_utente()
		
   update arsp_depo   set  
           id_armo	 =   :kst_tab_arsp_depo.id_armo,   
	        nriga      = :kst_tab_arsp_depo.nriga,
           colli      =  :kst_tab_arsp_depo.colli,   
           note_1  	 =   :kst_tab_arsp_depo.note_1,   
           note_2 	 =   :kst_tab_arsp_depo.note_2,   
           note_3  	 =   :kst_tab_arsp_depo.note_3,   
           stampa  	 =   :kst_tab_arsp_depo.stampa,   
           colli_out  =   :kst_tab_arsp_depo.colli_out,   
           peso_kg_out  =   :kst_tab_arsp_depo.peso_kg_out,  
           id_sped_depo	 =   :kst_tab_arsp_depo.id_sped_depo,   
           x_datins 	 =   :kst_tab_arsp_depo.x_datins,   
           x_utente	 =   :kst_tab_arsp_depo.x_utente  
		where id_arsp_depo = :kst_tab_arsp_depo.id_arsp_depo
			using kguo_sqlca_db_magazzino;

//           id_sped_depo  = :kst_tab_arsp_depo.id_sped_depo,    
//           num_bolla_out =   :kst_tab_arsp_depo.num_bolla_out,, 
//           data_bolla_out =   :kst_tab_arsp_depo.data_bolla_out

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in aggiornamento riga DDT. (id =" + string(kst_tab_arsp_depo.id_sped_depo) + " riga "  + string(kst_tab_arsp_depo.id_arsp_depo) +") : " &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	else
//---- COMMIT....	
		if kst_tab_arsp_depo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arsp_depo.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if

end if



end subroutine

public subroutine tb_update_testa (ref st_tab_sped_depo kst_tab_sped_depo) throws uo_exception;//
//--- Aggiorna Testata DDT
//--- torna 
//
long k_return = 0
long k_codice
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if if_sicurezza(kkg_flag_modalita.inserimento) then

//#--- 19.11.2012 --- legge dato da tab CAUS -----------------------------------
   kst_tab_sped_depo.ddt_st_num_data_in = "S"
   if kst_tab_sped_depo.caus_codice > " " then
      select ddt_st_num_data_in
           into :kst_tab_sped_depo.ddt_st_num_data_in
               from   CAUS
               where  CAUS.CODICE = :kst_tab_sped_depo.caus_codice
			using kguo_sqlca_db_magazzino;
   end if
//#----------------------------------------------------------------------------------------------------
 
	if_isnull_testa(kst_tab_sped_depo)

	kst_tab_sped_depo.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_sped_depo.x_utente = kGuf_data_base.prendi_x_utente()
	
	kst_tab_sped_depo.note_1 = trim(kst_tab_sped_depo.note_1)
	kst_tab_sped_depo.note_2 = trim(kst_tab_sped_depo.note_2)
	kst_tab_sped_depo.rag_soc_1 = trim(kst_tab_sped_depo.rag_soc_1)
	kst_tab_sped_depo.rag_soc_2 = trim(kst_tab_sped_depo.rag_soc_2)
	kst_tab_sped_depo.indi = trim(kst_tab_sped_depo.indi)
	kst_tab_sped_depo.loc = trim(kst_tab_sped_depo.loc)
	
	update sped_depo  set
            clie_2    =   :kst_tab_sped_depo.clie_2,   
            clie_3    =   :kst_tab_sped_depo.clie_3,   
            cura_trasp =   :kst_tab_sped_depo.cura_trasp,   
            causale   =   :kst_tab_sped_depo.causale,   
 	        caus_codice =   :kst_tab_sped_depo.caus_codice,		
            ddt_st_num_data_in = :kst_tab_sped_depo.ddt_st_num_data_in, 
            aspetto    =   :kst_tab_sped_depo.aspetto,   
            porto    =   :kst_tab_sped_depo.porto,   
            mezzo   =   :kst_tab_sped_depo.mezzo,   
            note_1   =   :kst_tab_sped_depo.note_1,   
            note_2   =   :kst_tab_sped_depo.note_2,   
            data_rit  =   :kst_tab_sped_depo.data_rit,   
            ora_rit   =   :kst_tab_sped_depo.ora_rit,   
            vett_1   =   :kst_tab_sped_depo.vett_1,   
            vett_2   =   :kst_tab_sped_depo.vett_2,   
            stampa  =   :kst_tab_sped_depo.stampa,   
            colli  =   :kst_tab_sped_depo.colli,   
            data_uscita =   :kst_tab_sped_depo.data_uscita,   
            rag_soc_1 =   :kst_tab_sped_depo.rag_soc_1,   
            rag_soc_2 =   :kst_tab_sped_depo.rag_soc_2,   
            indi    =   :kst_tab_sped_depo.indi,   
            loc    =   :kst_tab_sped_depo.loc,   
            cap	   =   :kst_tab_sped_depo.cap,   
            prov   =   :kst_tab_sped_depo.prov,   
            id_nazione  =   :kst_tab_sped_depo.id_nazione,   
            id_docprod =   :kst_tab_sped_depo.id_docprod,   
			sv_call_vettore = :kst_tab_sped_depo.sv_call_vettore,
            x_datins  =   :kst_tab_sped_depo.x_datins,   
            x_utente  =   :kst_tab_sped_depo.x_utente   
		 where id_sped_depo = :kst_tab_sped_depo.id_sped_depo
			using kguo_sqlca_db_magazzino;

//            form_di_stampa =   :kst_tab_sped_depo.form_di_stampa,    
//            num_bolla_out =   :kst_tab_sped_depo.num_bolla_out,   
//            data_bolla_out =   :kst_tab_sped_depo.data_bolla_out,    

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in aggiornamento Tab. DDT. (id =" + string(kst_tab_sped_depo.id_sped_depo) +") : " &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	else
//---- COMMIT....	
		if kst_tab_sped_depo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped_depo.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if

end if




end subroutine

public subroutine get_note (ref st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception;//
//--- Torna le NOTE della riga ddt
//
//--- inp: st_tab_arsp_depo.id_arsp_depo
//--- out: note_1/note_2/note_3
//--- Lancia exception st_esito
//
long k_return = 0
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arsp_depo.id_arsp_depo > 0 then
	
	SELECT note_1
	      ,note_2
		  ,note_3
		 INTO :kst_tab_arsp_depo.note_1
		     ,:kst_tab_arsp_depo.note_2
		     ,:kst_tab_arsp_depo.note_3
		 FROM arsp_depo  
		WHERE id_arsp_depo = :kst_tab_arsp_depo.id_arsp_depo
	  using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore nella ricerca delle Note per la riga " + string( kst_tab_arsp_depo.id_arsp_depo) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
		end if
	else
		if isnull(kst_tab_arsp_depo.note_1) then kst_tab_arsp_depo.note_1 = "" 
		if isnull(kst_tab_arsp_depo.note_2) then kst_tab_arsp_depo.note_2 = "" 
		if isnull(kst_tab_arsp_depo.note_3) then kst_tab_arsp_depo.note_3 = "" 
	end if
else
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Errore ricerca Note, manca id riga ddt! " 
	kst_esito.esito = kkg_esito.err_logico
			
end if	
	




end subroutine

public function integer get_nr_indirizzi_ddt (st_tab_sped_depo kst_tab_sped_depo);//
//--- Torna il numero Indirizzi di spedizione utilizzati (-1 = errore)
//
int k_return 


SetPointer(kkg.pointer_attesa)


	if kst_tab_sped_depo.clie_2 > 0 then
	
		k_return = u_set_ds_d_sped_depo_l_indirizzi(kst_tab_sped_depo)
		
	end if
				
SetPointer(kkg.pointer_default)

return k_return 

end function

public function boolean link_call_anteprima (ref datastore ads_link, string a_campo_link) throws uo_exception;//=== 
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
long k_riga=0
boolean k_return=true
string k_dataobject, k_num_x
st_tab_sped_depo kst_tab_sped_depo
st_tab_armo kst_tab_armo
st_esito kst_esito
uo_exception kuo_exception
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
kuf_menu_window kuf1_menu_window
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

if_sicurezza(kkg_flag_modalita.visualizzazione)

kdsi_elenco_output = create datastore
k_riga = ads_link.getrow()

choose case a_campo_link

	case "arsp_lotto" 
		kst_tab_armo.id_meca = ads_link.getitemnumber(ads_link.getrow(), "id_meca")
		if kst_tab_armo.id_meca > 0 then
			kst_open_w.key1 = "Elenco righe DDT di Spedizione  (id lotto=" + trim(string(kst_tab_armo.id_meca)) + ") " 
			//k_id_programma = this.get_id_programma(kkg_flag_modalita.visualizzazione)
		else
			k_return = false
		end if


	case "arsp_sped", "sped", "num_bolla_out", "num_bolla_out_1", "arsp_insped"
		if a_campo_link = "num_bolla_out_1" then
			kst_tab_sped_depo.num_bolla_out = ads_link.getitemnumber(ads_link.getrow(), "num_bolla_out_1")
		else
			kst_tab_sped_depo.num_bolla_out = ads_link.getitemnumber(ads_link.getrow(), "num_bolla_out")
		end if
		k_num_x = ads_link.describe("id_sped_depo.x")
		if isnumber(k_num_x) then
			kst_tab_sped_depo.id_sped_depo = ads_link.getitemnumber(ads_link.getrow(), "id_sped_depo")
		end if
			
		if kst_tab_sped_depo.num_bolla_out > 0 then
			kst_tab_sped_depo.data_bolla_out = ads_link.getitemdate(ads_link.getrow(), "data_bolla_out")
			kst_open_w.key1 = "DDT di spedizione n. " + trim(string(kst_tab_sped_depo.num_bolla_out)) + " del " + trim(string(kst_tab_sped_depo.data_bolla_out)) 
			//k_id_programma = this.get_id_programma(kkg_flag_modalita.visualizzazione)
		else
			k_return = false	
		end if

	case "id_sped_depo"
		kst_tab_sped_depo.id_sped_depo = ads_link.getitemnumber(ads_link.getrow(), a_campo_link)
		get_numero_da_id(kst_tab_sped_depo)
		if kst_tab_sped_depo.num_bolla_out > 0 then
//			kst_tab_sped_depo.data_bolla_out = ads_link.getitemdate(ads_link.getrow(), "data_bolla_out")
			kst_open_w.key1 = "DDT di spedizione n. " + trim(string(kst_tab_sped_depo.num_bolla_out)) + " del " + trim(string(kst_tab_sped_depo.data_bolla_out)) 
			//k_id_programma = this.get_id_programma(kkg_flag_modalita.visualizzazione )
		else
			k_return = false	
		end if



end choose


if k_return then

//	kdsi_elenco_output.dataobject = k_dataobject		
//	kdsi_elenco_output.settransobject(sqlca)
//	kdsi_elenco_output.reset()	
	
	choose case a_campo_link
				
		case "arsp_lotto" 
			kst_esito = anteprima_elenco ( kdsi_elenco_output, kst_tab_armo )
	
		case "sped", "num_bolla_out", "id_sped_depo"
			kst_esito = anteprima ( kdsi_elenco_output, kst_tab_sped_depo )
	
		case "arsp_sped"
			kst_esito = anteprima_righe ( kdsi_elenco_output, kst_tab_sped_depo )
	
		case "num_bolla_out_1"
			kst_esito = anteprima_1 ( kdsi_elenco_output, kst_tab_sped_depo )
	
		case "arsp_insped"
			kst_esito = anteprima_2 ( kdsi_elenco_output, kst_tab_sped_depo )
	
	end choose
	if kst_esito.esito <> kkg_esito.ok then
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
	if isvalid(kdsi_elenco_output) then k_dataobject = kdsi_elenco_output.dataobject

	
	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//=== Parametri : 
	//=== struttura st_open_w
		kst_open_w.id_programma = kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window


	else
		
		kuo_exception = create uo_exception
		kuo_exception.setmessage(u_get_errmsg_nontrovato(kst_open_w.flag_modalita ))
		throw kuo_exception
		
		
	end if

end if

SetPointer(kp_oldpointer)


return k_return

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
boolean k_return=false
datastore kds_1


	kds_1 = create datastore
	kds_1.dataobject = adw_link.dataobject

	if adw_link.rowcount() > 0 then
		adw_link.rowscopy(1, adw_link.rowcount(), primary!, kds_1, 1, primary!)
		if adw_link.getrow() >0 then  
			kds_1.setrow(adw_link.getrow())
			k_return = link_call_anteprima(kds_1, a_campo_link)
		end if
	end if


return k_return 
end function

public function boolean link_call (ref datastore ads_1, string a_campo_link) throws uo_exception;//=== 
//====================================================================
//=== Attiva LINK cliccato 
//===
//=== Par. Inut: 
//===               datastore su cui è stato attivato il LINK
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
boolean k_return=false



	if ads_1.rowcount() > 0 then
		if ads_1.getrow() > 0 then  
			k_return = link_call_anteprima(ads_1, a_campo_link)
		end if
	end if


return k_return 
end function

public function boolean if_sv_call_vettore (st_tab_sped_depo ast_tab_sped_depo) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controllo se è stato applicato il SERVIZIO DI COSTO CHIAMATA VETTORE
//--- 
//--- 
//--- Inp: st_tab_sped_depo.id_sped_depo
//--- Out: TRUE = costo attivato 
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
//
boolean k_return = false
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()

if ast_tab_sped_depo.id_sped_depo > 0 then
	
	SELECT sped_depo.sv_call_vettore
		 INTO :ast_tab_sped_depo.sv_call_vettore   
		 FROM sped_depo  
		WHERE id_sped_depo = :ast_tab_sped_depo.id_sped_depo
	  using kguo_sqlca_db_magazzino;
	  
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if ast_tab_sped_depo.sv_call_vettore = 1 then
			k_return = true
		end if
	else
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			kst_esito.esito = kkg_esito.db_ko  
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = kguo_sqlca_db_magazzino.sqlerrtext
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
else
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Controllo 'Chiamata Vettore' su DDT non eseguito, manca il codice id del DDT! " 
	kst_esito.esito = kkg_esito.err_logico
			
end if	

return k_return

end function

public function long get_id_sped_depo_max (string k_numpref_bolla_out) throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo ID sped_depo inserito 
//--- 
//---  input: numpref_bolla_out
//---  ret: max id_sped_depo
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())
	
	k_numpref_bolla_out = trim(k_numpref_bolla_out)

	SELECT max(id_sped_depo)
		 INTO 
				:k_return
		 FROM sped_depo  
		 where numpref_bolla_out = :k_numpref_bolla_out
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo ID di Spedizione deposito in tabella (SPED_DEPO) per il prefisso " + k_numpref_bolla_out &
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

public function long get_id_arsp_depo_max () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo ID arsp_depo inserito 
//--- 
//---  input: 
//---  ret: max id_arsp_depo
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	SELECT max(id_arsp_depo)
		 INTO 
				:k_return
		 FROM arsp_depo
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo ID riga di Spedizione in tabella (ARSP)" &
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

public function long get_id_sped_depo (ref st_tab_sped_depo kst_tab_sped_depo) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna id_sped_depo da numero/data bolla
//--- 
//--- Inp: kst_tab_sped_depo.num_bolla_out/data_bolla_out
//--- Out: kst_tab_sped_depo.id_sped_depo
//---
//--- Ritorna: Il ID del ddt trovato 
//---
//---Lancia EXCEPTION
//---
//----------------------------------------------------------------------------------------------------------------
long k_return
int k_anno = 0
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
	if kst_tab_sped_depo.num_bolla_out > 0 then
		
		k_anno = year(kst_tab_sped_depo.data_bolla_out)
		
		SELECT id_sped_depo
		 INTO 
		  	:kst_tab_sped_depo.id_sped_depo
	 	FROM sped_depo  
		WHERE ( num_bolla_out = :kst_tab_sped_depo.num_bolla_out ) AND  
						year(data_bolla_out) = :k_anno  
			  using sqlca;
	
	end if
	
	if sqlca.sqlcode = 0 then
		if kst_tab_sped_depo.id_sped_depo > 0 then k_return = kst_tab_sped_depo.id_sped_depo
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ID del ddt di sped_depo., numero  " + string( kst_tab_sped_depo.num_bolla_out) + " del "+ string( kst_tab_sped_depo.data_bolla_out )+" ~n~r" &
									 + trim(SQLCA.SQLErrText)
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
	
return k_return


end function

public function boolean set_num_bolla_out_all (st_tab_sped_depo kst_tab_sped_depo) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------
//--- Aggiorna in nr DDT per id_sped_depo della Testata e delle Righe
//--- 
//--- 
//--- Inp: st_tab_sped_depo.id_sped_depo  e  num_bolla_out
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
	
	
if kst_tab_sped_depo.id_sped_depo > 0 then

	kst_tab_sped_depo.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_sped_depo.x_utente = kGuf_data_base.prendi_x_utente()

	UPDATE sped_depo  
		  SET num_bolla_out = :kst_tab_sped_depo.num_bolla_out
			,x_datins = :kst_tab_sped_depo.x_datins
			,x_utente = :kst_tab_sped_depo.x_utente
		WHERE sped_depo.id_sped_depo = :kst_tab_sped_depo.id_sped_depo
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
	
		UPDATE arsp_depo  
			  SET num_bolla_out = :kst_tab_sped_depo.num_bolla_out
				,x_datins = :kst_tab_sped_depo.x_datins
				,x_utente = :kst_tab_sped_depo.x_utente
			WHERE arsp_depo.id_sped_depo = :kst_tab_sped_depo.id_sped_depo
			using kguo_sqlca_db_magazzino;

	end if

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiornamento del Numero sulla Testata e le Righe del DDT. ~n~r" &
					+ "Id: " + string(kst_tab_sped_depo.id_sped_depo, "#0") + "  " &
					+ "n.: " + string(kst_tab_sped_depo.num_bolla_out, "#0") + "  " &
					+ " ~n~rErrore-tab.SPED:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_sped_depo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped_depo.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	else
		if kst_tab_sped_depo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped_depo.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	end if

else
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Errore tab. DDT, Manca Identificativo (id_sped_depo) !" 
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

public function long get_num_bolla_out_ultimo (ref st_tab_sped_depo kst_tab_sped_depo) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna ultimo  numero x anno inseriti
//--- 
//--- Inp: kst_tab_sped_depo.data_bolla_out + id_sped_depo da escludere (opt)
//--- Out: kst_tab_sped_depo.num_bolla_out
//---
//--- Ritorna: Il ID del ddt trovato 
//---
//---Lancia EXCEPTION
//---
//----------------------------------------------------------------------------------------------------------------
long k_return
long k_num_bolla_out_extra
int k_anno
date k_data_da, k_data_a
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	if kst_tab_sped_depo.data_bolla_out > kkg.data_zero then
		
		k_anno = year(kst_tab_sped_depo.data_bolla_out)
		k_data_da = date(k_anno,01,01)
		k_data_a = date(k_anno,12,31)
		
		if isnull(kst_tab_sped_depo.id_sped_depo) then kst_tab_sped_depo.id_sped_depo = 0
		k_num_bolla_out_extra = kki_num_bolla_out_extra
		
		SELECT max(num_bolla_out)
		 INTO 
		  	:kst_tab_sped_depo.num_bolla_out
	 	FROM sped_depo  
		WHERE  data_bolla_out between :k_data_da and :k_data_a  
		              and id_sped_depo <> :kst_tab_sped_depo.id_sped_depo
						  and num_bolla_out < :k_num_bolla_out_extra
			  using kguo_sqlca_db_magazzino;
	
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_sped_depo.num_bolla_out > 0 then k_return = kst_tab_sped_depo.num_bolla_out
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettura ultimo Numero del ddt di sped_depo. per l'anno " + string(kst_tab_sped_depo.data_bolla_out, "yyyy") +" ~n~r" &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
	
return k_return


end function

public function long get_numero_nuovo (st_tab_sped_depo ast_tab_sped_depo, integer a_ctr) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna il nuovo numero per un nuovo DDT
//--- 
//--- 
//--- Inp: st_tab_sped_depo.data_bolla_out,  ctr = contatore per il auto-rilancio (max 10 volte) 
//--- Rit: numero x fare un nuovo DDT dell'anno
//---
//--- Ritorna: TRUE = ddt trovato e id valorizzato
//---
//---Lancia EXCEPTION
//---
//----------------------------------------------------------------------------------------------------------------
long k_return = 0
long k_num_base, k_num_ddt
string k_dato
date k_data_base
st_tab_sped_depo kst_tab_sped_depo
kuf_base kuf1_base

try

//--- get numero dal contatore se anno in corso
	if year(ast_tab_sped_depo.data_bolla_out) = kguo_g.get_anno( ) then

		kuf1_base = create kuf_base
		k_dato = kuf1_base.prendi_dato_base( "numdata_ddt")
		if left(k_dato, 1) = "0" then
			k_num_base = long(mid(k_dato,2,12))  //ultimo numero DDT preso dalla tabella 
			k_data_base = date(mid(k_dato,15))  //ultima data DDT preso dalla tabella 
			if isnull(k_num_base) then 
				k_num_base = 0
				k_data_base = kkg.data_zero
			end if
		else
			kguo_exception.inizializza( )
			kguo_exception.kist_esito.esito = left(k_dato, 1)
			kguo_exception.kist_esito.sqlerrtext = "Errore in lettura n. ddt da Proprietà Procedura, prego riprovare. ~n~r" + mid(k_dato,2)
			kguo_exception.kist_esito.nome_oggetto = this.classname()
			throw kguo_exception
		end if
		destroy kuf1_base

	end if

	kst_tab_sped_depo.id_sped_depo = ast_tab_sped_depo.id_sped_depo  
	if year(k_data_base) > 1990 then
		kst_tab_sped_depo.data_bolla_out = k_data_base
	else
		kst_tab_sped_depo.data_bolla_out = ast_tab_sped_depo.data_bolla_out  
	end if

//--- get ultimo numero dalla tabella DDT x l'anno indicato
	k_num_ddt = this.get_num_bolla_out_ultimo(kst_tab_sped_depo)	
	if isnull(k_num_ddt) then k_num_ddt = 0
	
//--- torna il num più alto	
	if k_num_ddt > k_num_base then
		k_return = k_num_ddt + 1
	else
		k_return = k_num_base + 1
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
	//--- il DDT a parte la prima deve essere maggiore di 1 quindi ritenta 10 volte
	if k_return < 2 and a_ctr < 10 then
		sleep(1)
		k_return = get_numero_nuovo(ast_tab_sped_depo, (a_ctr + 1))
	end if
	
end try
	
return k_return

end function

public function long if_num_bolla_out_exists (st_tab_sped_depo kst_tab_sped_depo) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna id_sped_depo da numero/data bolla se caricato con id diverso dal passato
//--- 
//--- Inp: kst_tab_sped_depo. id_sped_depo + num_bolla_out + data_bolla_out
//--- Out: 
//---
//--- Ritorna: kst_tab_sped_depo.id_sped_depo se diverso da input 
//---
//---Lancia EXCEPTION
//---
//----------------------------------------------------------------------------------------------------------------
long k_return
int k_anno = 0
date k_data_da, k_data_a
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if kst_tab_sped_depo.num_bolla_out > 0 then
		
		k_anno = year(kst_tab_sped_depo.data_bolla_out)
		k_data_da = date(k_anno,01,01)
		k_data_a = date(k_anno,12,31)

		SELECT max(id_sped_depo)
		 INTO 
		  	:kst_tab_sped_depo.id_sped_depo
	 	FROM sped_depo  
		WHERE num_bolla_out = :kst_tab_sped_depo.num_bolla_out 
						and data_bolla_out between :k_data_da and :k_data_a  
						and id_sped_depo <> :kst_tab_sped_depo.id_sped_depo
			  using sqlca;
	
	end if
	
	if sqlca.sqlcode = 0 then
		if kst_tab_sped_depo.id_sped_depo > 0 then k_return = kst_tab_sped_depo.id_sped_depo
	else
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in ricerca ID del ddt di sped_depo., numero  " + string( kst_tab_sped_depo.num_bolla_out) + " del "+ string( kst_tab_sped_depo.data_bolla_out ) &
															+ " diverso dal ID " + string( kst_tab_sped_depo.id_sped_depo) + " ~n~r" &
										 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
	
return k_return


end function

public function boolean if_ddt_allarme_memo (st_tab_sped_depo kst_tab_sped_depo) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla se DDT ha un allarme MEMO x id_sped_depo
//--- 
//--- 
//--- Inp: st_tab_sped_depo.id_sped_depo
//--- Out: TRUE = ddt in allarme 
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
string k_esito = ""
datastore kds
st_esito kst_esito
kuf_base kuf1_base


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()

if kst_tab_sped_depo.id_sped_depo > 0 then
	kds = create datastore
	kds.dataobject = "ds_ddt_if_allarme_memo"
	kds.settransobject(kguo_sqlca_db_magazzino)
	if kds.retrieve( kst_tab_sped_depo.id_sped_depo) > 0 then
		k_return = true
	end if
else

	kst_esito.esito = kkg_esito.no_esecuzione  
	kst_esito.SQLErrText = "Verifica Allarme MEMO sul DDT non eseguita, id del DDT assente!"
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if


return k_return



end function

public function boolean if_stampato (st_tab_sped_depo ast_tab_sped_depo) throws uo_exception;//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla se DDT stampato x id_sped_depo
//--- 
//--- 
//--- Inp: st_tab_sped_depo.id
//--- Out: TRUE = completamente stampata
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
boolean k_return = true   //default stampata 
long k_trovato=0
st_esito kst_esito
st_tab_sped_depo kst_tab_sped_depo_stampato


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()

kst_tab_sped_depo_stampato.stampa = kki_sped_depo_flg_stampa_bolla_da_stamp

if if_esiste(ast_tab_sped_depo) then

	k_trovato = 0
	SELECT count(*)
			into :k_trovato
			 FROM sped_depo  
			 where  id_sped_depo  = :ast_tab_sped_depo.id_sped_depo 
			    and (stampa is null or stampa = :kst_tab_sped_depo_stampato.stampa)
			 using kguo_sqlca_db_magazzino;
	
	if k_trovato = 0 then
		SELECT count(*)
			into :k_trovato
			 FROM arsp_depo  
			 where  id_sped_depo  = :ast_tab_sped_depo.id_sped_depo 
			    and (stampa is null or stampa = :kst_tab_sped_depo_stampato.stampa)
			 using kguo_sqlca_db_magazzino;
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante ricerca se DDT stampato (sped) id = " + string(ast_tab_sped_depo.id_sped_depo) + " " &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
									 
		kst_esito.esito = KKG_ESITO.db_ko
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		k_return = true  
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			if k_trovato > 0 then 
				k_return = false   //NON è completamente stampata
			end if	
		end if
	end if
	
else
	
end if
	

return k_return



end function

public function string get_cura_trasp (ref st_tab_sped_depo kst_tab_sped_depo) throws uo_exception;//
//--- Torna il flag cura_trasp 
//
//--- inp: st_tab_sped_depo.id_sped_depo
//--- out: cura_trasp
//--- Lancia exception st_esito
//
string k_return 
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_sped_depo.id_sped_depo > 0 then
	
	SELECT cura_trasp
		 INTO :kst_tab_sped_depo.cura_trasp
		 FROM sped_depo  
		WHERE id_sped_depo = :kst_tab_sped_depo.id_sped_depo
	  using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettura dato 'a cura di' del DDT id " + string( kst_tab_sped_depo.id_sped_depo) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
		end if
	else
		if isnull(kst_tab_sped_depo.cura_trasp) then kst_tab_sped_depo.cura_trasp = kki_cura_trasp_Nessuno
		k_return = kst_tab_sped_depo.cura_trasp
	end if
else
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Errore in lettura dato 'a cura di', manca id del DDT! " 
	kst_esito.esito = kkg_esito.err_logico
			
end if	
	
return k_return



end function

private function long u_set_ds_d_sped_depo_l_indirizzi (st_tab_sped_depo kst_tab_sped_depo);//
//--- Fa l'elenco Indirizzi di spedizione 
//--- inp: st_tab_sped_depo.clie_2
//--- out: numero righe
//
string k_clie_2_x
long k_clie_2
long k_return


	if not isvalid(kdsi_d_sped_depo_l_indirizzi) then
		kdsi_d_sped_depo_l_indirizzi = create datastore
		kdsi_d_sped_depo_l_indirizzi.dataobject = kki_d_sped_depo_l_indirizzi 
		kdsi_d_sped_depo_l_indirizzi.settransobject(sqlca) 
	end if
		
	k_clie_2_x = kdsi_d_sped_depo_l_indirizzi.describe("evaluate('arg1', 1)") 
	if isnumber(k_clie_2_x) then
		k_clie_2 = long(k_clie_2_x) 
	end if

	if kst_tab_sped_depo.clie_2 <> k_clie_2 then
		k_return = kdsi_d_sped_depo_l_indirizzi.retrieve(kst_tab_sped_depo.clie_2)
	else
		k_return = kdsi_d_sped_depo_l_indirizzi.rowcount()
	end if

	
return k_return

end function

public function st_esito set_sped_stampata (st_tab_sped_depo kst_tab_sped_depo);//
//====================================================================
//=== Imposta a Stampata la Bolla di spedizione
//=== 
//=== 
//=== Input: st_sped_depo.id_sped_depo
//===        
//=== Out: ST_ESITO
//===           		
//=== 
//====================================================================
//
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())
	
if kst_tab_sped_depo.id_sped_depo > 0 then

	kst_tab_sped_depo.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_sped_depo.x_utente = kGuf_data_base.prendi_x_utente()

	kst_tab_sped_depo.stampa = kki_sped_depo_flg_stampa_bolla_stampata
	UPDATE sped_depo  
		  SET stampa = :kst_tab_sped_depo.stampa
			,data_rit = :kst_tab_sped_depo.data_rit
			,ora_rit =  :kst_tab_sped_depo.ora_rit
			,x_datins = :kst_tab_sped_depo.x_datins
			,x_utente = :kst_tab_sped_depo.x_utente
		WHERE sped_depo.id_sped_depo = :kst_tab_sped_depo.id_sped_depo
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiorn. d.d.t. a stampato ~n~r" &
					+ " Id " + string(kst_tab_sped_depo.num_bolla_out, "####0") &
					+ " ~n~rErrore-tab.SPED:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_sped_depo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped_depo.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	else
		if kst_tab_sped_depo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped_depo.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	end if

else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. d.d.t., Manca Id di Spedizione deposito(id_sped_depo) !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	

return kst_esito

end function

public function st_esito get_sped_stampa (ref st_tab_sped_depo kst_tab_sped_depo);//
//====================================================================
//=== Get del flag Stampa dalla Bolla di spedizione
//=== 
//=== 
//=== Input: st_sped_depo.id_sped_depo
//===          
//=== Out: ST_ESITO
//===           		
//=== 
//====================================================================
//
st_esito kst_esito

	
kst_esito = kguo_exception.inizializza(this.classname())
	
if kst_tab_sped_depo.id_sped_depo > 0 then

	select distinct stampa 
			into :kst_tab_sped_depo.stampa
			from sped_depo  
		WHERE sped_depo.id_sped_depo = :kst_tab_sped_depo.id_sped_depo
           using kguo_sqlca_db_magazzino ;

	if sqlca.sqlcode = 0 then
		
//--- se flag è nullo lo imposto a DA_STAMPARE		
		if isnull(kst_tab_sped_depo.stampa) or len(trim(kst_tab_sped_depo.stampa)) = 0 then
			kst_tab_sped_depo.stampa = kki_sped_depo_flg_stampa_bolla_da_stamp
		end if
		
	else
		
		kst_tab_sped_depo.stampa = ""
		
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore durante lettura d.d.t. (flag stampa) ~n~r" &
						+ " Id Spedizioe deposito: " + string(kst_tab_sped_depo.id_sped_depo, "####0")  &	
						+ " ~n~rErrore-tab.SPED:"	+ trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
	end if
	
else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. d.d.t., Manca il Id della Spedizione deposito !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	

return kst_esito

end function

public function long get_colli_x_id_armo_sped (st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Trova colli spediti fino ad una certa data_bolla_out di id_sped_depo (ESCLUSA) x id_armo 
//---
//--- inp: st_tab_arsp_depo.id_armo / id_sped_depo
//--- out: 
//--- Rit: Numero colli
//---
//--- lancia EXCEPTION
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if kst_tab_arsp_depo.id_armo > 0 then
	SELECT sum (arsp_depo.colli)
		 INTO :kst_tab_arsp_depo.colli   
		 FROM arsp_depo inner join sped_depo on armo_depo.id_sped_depo = sped_depo.id_sped_depo
		WHERE id_armo = :kst_tab_arsp_depo.id_armo
		      and sped_depo.id_sped_depo = :kst_tab_arsp_depo.id_sped_depo
				and sped_depo.data_bolla_out < sped_depo.data_bolla_out 
		using kguo_sqlca_db_magazzino;
				  
	if sqlca.sqlcode <> 0 then
		kst_tab_arsp_depo.colli = 0
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura numero colli x riga lotto. Tab righe ddt, id riga lotto: " + string( kst_tab_arsp_depo.id_armo) + " ~n~r" + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. righe ddt. Manca id Riga Lotto (Riferimento) !" 
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if	
	
if isnull(kst_tab_arsp_depo.colli) then kst_tab_arsp_depo.colli = 0
	
 
return  kst_tab_arsp_depo.colli   	



end function

public function long get_colli_sped (ref st_tab_arsp_depo kst_tab_arsp_depo) throws uo_exception;//
//--- Torna colli spediti x id_armo 
//
//--- inp: st_tab_arsp_depo.id_armo
//--- out: colli = Numero colli spediti; 0=nessuno
//--- Lancia exception st_esito
//
long k_return = 0
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arsp_depo.id_armo > 0 then
	
	SELECT sum (arsp_depo.colli)
		 INTO :kst_tab_arsp_depo.colli   
		 FROM arsp_depo  
		WHERE id_armo = :kst_tab_arsp_depo.id_armo
	  using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_tab_arsp_depo.colli = 0
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore nel calcolo nr. colli spediti per riga lotto id " + string( kst_tab_arsp_depo.id_armo) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
		end if
	else
		if kst_tab_arsp_depo.colli > 0 then
			k_return = kst_tab_arsp_depo.colli 
		end if
	end if
else
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Errore nel calcolo nr. colli spediti, manca id riga lotto! " 
	kst_esito.esito = kkg_esito.err_logico
			
end if	
	
return k_return



end function

public function long get_colli_sped_lotto (long aid_meca) throws uo_exception;//
//--- Torna colli spediti x id_meca 
//
//--- inp: id_meca
//--- out: colli = Numero colli spediti x l'intero Lotto; 0=nessuno
//--- Lancia exception 
//
long k_return = 0
st_tab_arsp_depo kst_tab_arsp_depo
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if aid_meca > 0 then
	
	SELECT sum (arsp_depo.colli)
		 INTO :kst_tab_arsp_depo.colli   
		 FROM arsp_depo  
		WHERE id_armo in
		  ( select distinct id_armo 
		          from armo 
					 where id_meca = :aid_meca)
	  using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_tab_arsp_depo.colli = 0
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore nel calcolo nr. colli spediti per Lotto id " + string(aid_meca) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
		end if
	else
		if kst_tab_arsp_depo.colli > 0 then
			k_return = kst_tab_arsp_depo.colli 
		end if
	end if
else
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Errore nel calcolo nr. colli spediti per Lotto, manca id lotto! " 
	kst_esito.esito = kkg_esito.err_logico
			
end if	
	
return k_return



end function

on kuf_sped_depo.create
call super::create
end on

on kuf_sped_depo.destroy
call super::destroy
end on

event constructor;call super::constructor;//
ki_msgerroggetto = "DDT di spedizione"
end event

event destructor;call super::destructor;//
if isvalid(kdsi_d_sped_depo_l_indirizzi) then destroy kdsi_d_sped_depo_l_indirizzi

end event

