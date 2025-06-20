﻿$PBExportHeader$kuf_barcode.sru
forward
global type kuf_barcode from kuf_parent
end type
end forward

global type kuf_barcode from kuf_parent
end type
global kuf_barcode kuf_barcode

type variables
//--- causali
public constant string ki_causale_non_trattare="T"  // barcode da NON trattare

//--- valori del campo FLG_DOSIMETRO
public constant string ki_flg_dosimetro_SI ="1"  // dosimetro accoppiato al barcode
public constant string ki_flg_dosimetro_NO ="0"

//--- variabile di stato campo errore
public constant string ki_err_lav_fin_ko ="1"
public constant string ki_err_lav_fin_ok ="0"

////--- id streamer della stampa etichette
//public long ki_id_print_etichette=0 
//public boolean ki_stampa_etichetta_autorizza = false
//
////--- contatore etichette nella pagina (probabile al max 2 o 4)
//private int ki_num_etichetta_in_pag=0 
//st_tab_barcode kist_tab_barcode_stampa_save

//--- Datasore elenco Figli del Barcode
public string ki_ds_barcode_figli_elenco = "ds_barcode_figli_elenco"
public string ki_ds_barcode_figli_elenco_sl_pt = "ds_barcode_figli_elenco_sl_pt"

//--- Datawindow elenco Figli e Padri potenziali
public constant string kk_dw_nome_barcode_l_padri_potenziali = "d_barcode_l_padri"  
public constant string kk_dw_nome_barcode_l_figli_potenziali = "d_barcode_l_figli_potenziali"  

//--- Flag Groupage
public constant string ki_barcode_groupage_SI = "S"
public constant string ki_barcode_groupage_NO = "N"

//--- valori del campo FLG_CAMPIONE
public constant int ki_flg_campione_SI = 1  // controcampioni accoppiati al barcode
public constant int ki_flg_campione_NO = 0

////--- formato di Stampa
//public constant string barcode_modulo_4xpagina = "4"
//public constant string barcode_modulo_2xpagina = "2"
//public constant string barcode_modulo_1etichetta = "A"


public st_tab_barcode kist_tab_barcode

//DECLARE kicursor_barcode_1 CURSOR FOR 
//                SELECT barcode.barcode
//					       ,barcode.pl_barcode
//						FROM barcode
//					   where 
//							  barcode.barcode = :kist_tab_barcode.barcode 
//							   or 
//							  (
//							   :kist_tab_barcode.barcode = '*'
//								    and (:kist_tab_barcode.pl_barcode = 0
//								         or barcode.pl_barcode = :kist_tab_barcode.pl_barcode 
//								         or barcode.pl_barcode is null
//											or barcode.pl_barcode = 0)
//								  and barcode.num_int = :kist_tab_barcode.num_int
//								  and barcode.data_int = :kist_tab_barcode.data_int 
//								  and (barcode.fila_1 = :kist_tab_barcode.fila_1
//								   or (barcode.fila_1 is null and :kist_tab_barcode.fila_1 = 999))
//								  and (barcode.fila_1p = :kist_tab_barcode.fila_1p
//								   or (barcode.fila_1p is null and :kist_tab_barcode.fila_1p = 999))
//								  and (barcode.fila_2 = :kist_tab_barcode.fila_2
//								   or (barcode.fila_2 is null and :kist_tab_barcode.fila_2 = 999))
//								  and (barcode.fila_2p = :kist_tab_barcode.fila_2p
//								   or (barcode.fila_2p is null and :kist_tab_barcode.fila_2p = 999))
//								) ; 

//--- estrazione dei barcode non lavorati e in pl_barcode specifico
// declare kicursor_barcode_2 cursor for
//   SELECT 
//         barcode.data_int,   
//         barcode.num_int,   
//         barcode.tipo_cicli,   
//         barcode.fila_1,   
//         barcode.fila_2,   
//         barcode.fila_1p,   
//         barcode.fila_2p   
//    FROM barcode 
//   WHERE barcode.num_int = :kist_tab_barcode.num_int 
//         and barcode.data_int >= :kist_tab_barcode.data_int  
//		  and ((barcode.pl_barcode = 0 or barcode.pl_barcode is null) 
//			 or (:kist_tab_barcode.pl_barcode > 0 
//			     and barcode.pl_barcode = :kist_tab_barcode.pl_barcode)) 
//		  and (barcode.barcode_lav is null or barcode.barcode_lav = '')
//		  and barcode.data_stampa > 0 
//		  and (barcode.data_sosp = convert(date,'01.01.1899') or barcode.data_sosp is null)  ;
		  
		  
	

end variables

forward prototypes
public function string togli_pl_barcode (ref st_tab_barcode kst_tab_barcode)
public function string togli_pl_barcode_all (ref st_tab_barcode kst_tab_barcode)
public function st_esito togli_pl_barcode_chiuso (st_tab_barcode kst_tab_barcode)
public function st_esito tb_prendi_campo (ref st_tab_barcode kst_tab_barcode, string k_campo)
public function st_esito tb_update_campo (st_tab_barcode kst_tab_barcode, string k_campo)
public subroutine if_isnull (ref st_tab_barcode kst_tab_barcode)
public function st_esito tb_delete_x_rif (ref st_tab_barcode kst_tab_barcode)
public function st_tab_barcode get_primo_barcode_in_lav () throws uo_exception
public subroutine check_anomalie_lavorazione (ref st_tab_barcode kst_tab_barcode) throws uo_exception
public subroutine togli_pl_barcode_non_chiuso (st_tab_barcode kst_tab_barcode) throws uo_exception
public function boolean if_barcode_trattato (st_tab_barcode kst_tab_barcode) throws uo_exception
public function boolean if_barcode_in_pl_chiuso (st_tab_barcode kst_tab_barcode) throws uo_exception
public function st_esito tb_aggiungi_figlio (st_tab_barcode kst_tab_barcode)
public function long get_conta_figli (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function st_esito tb_togli_figli_tutti (st_tab_barcode kst_tab_barcode)
public function boolean get_padre (ref st_tab_barcode kst_tab_barcode) throws uo_exception
public function st_esito tb_set_padre (st_tab_barcode kst_tab_barcode)
public function st_esito tb_togli_figlio_al_padre (st_tab_barcode kst_tab_barcode)
public function long get_conta_barcode_x_id_armo_fine_lav (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function long get_conta_barcode_groupage_x_id_armo (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function date get_data_lav_ini_x_id_armo (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function date get_data_lav_fin_x_id_armo (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function st_tab_barcode get_ultimo_barcode_importato () throws uo_exception
public function long get_nr_barcode_da_non_trattare (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function long get_nr_barcode_trattati (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function st_esito get_padre_id_meca (ref st_tab_barcode kst_tab_barcode)
public function st_esito set_num_data_int (st_tab_barcode kst_tab_barcode)
public function boolean if_essere_barcode_padre_con_giri_figlio (st_tab_barcode kst_tab_barcode_figlio, st_tab_barcode kst_tab_barcode_padre) throws uo_exception
public function boolean if_essere_barcode_padre (st_tab_barcode kst_tab_barcode_padre) throws uo_exception
public function st_esito tb_togli_da_groupage (st_tab_barcode kst_tab_barcode)
public function boolean if_barcode_padre_no_trattati (st_tab_barcode kst_tab_barcode) throws uo_exception
public function boolean if_barcode_padre (st_tab_barcode kst_tab_barcode) throws uo_exception
public function date get_data_lav_ini (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function long get_nr_barcode (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function boolean if_esiste (st_tab_barcode kst_tab_barcode) throws uo_exception
public function st_esito set_pl_barcode (ref st_tab_barcode kst_tab_barcode, string k_tipo)
public function long get_nr_barcode_in_lav_x_pl (st_tab_barcode kst_tab_barcode) throws uo_exception
public function long get_conta_barcode_x_id_armo_pl_barcode (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function long get_nr_barcode_da_non_trattare_x_id_armo (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function string get_barcode_lav (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function long get_nr_barcode_x_id_armo (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public subroutine set_flg_dosimetro_reset (st_tab_barcode ast_tab_barcode) throws uo_exception
public function long get_nr_barcode_stampati (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
private function st_esito tb_delete_barcode (ref st_tab_barcode kst_tab_barcode)
public function st_esito tb_delete (ref st_tab_barcode kst_tab_barcode)
public function boolean if_da_trattare_no_pl_barcode (st_tab_barcode kst_tab_barcode) throws uo_exception
public function boolean if_dosimetro_gia_accoppiato (ref st_tab_barcode ast_tab_barcode) throws uo_exception
public function integer get_nr_barcode_trattati_x_id_meca (st_tab_barcode kst_tab_barcode) throws uo_exception
public function integer get_nr_barcode_da_trattare_x_id_meca (st_tab_barcode kst_tab_barcode) throws uo_exception
public function integer get_nr_barcode_lav_ini (st_tab_barcode kst_tab_barcode) throws uo_exception
public function integer get_nr_barcode_no_lav_ini_x_id_meca (st_tab_barcode kst_tab_barcode) throws uo_exception
public function st_tab_barcode get_data_lav_ini_fin (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function long get_durata_lav (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function integer get_conta_dosimetri (st_tab_barcode kst_tab_barcode) throws uo_exception
public function boolean tb_add (st_tab_barcode ast_tab_barcode) throws uo_exception
public function long get_durata_lav_old (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public subroutine get_lav_fila_tot_x_id_meca (ref st_tab_barcode kst_tab_barcode) throws uo_exception
public subroutine get_fila_tot_x_id_meca (ref st_tab_barcode kst_tab_barcode) throws uo_exception
public function long get_barcode_da_id_meca (ref st_tab_barcode kst_tab_barcode[]) throws uo_exception
public function boolean if_barcode_figlio (ref st_tab_barcode ast_tab_barcode) throws uo_exception
public function boolean if_da_trattare (st_tab_barcode ast_tab_barcode) throws uo_exception
public function long get_pl_barcode (st_tab_barcode kst_tab_barcode) throws uo_exception
public function integer set_flg_dosimetro_all (st_tab_barcode ast_tab_barcode) throws uo_exception
public function integer set_flg_dosimetro_rigenera (st_tab_barcode ast_tab_barcode) throws uo_exception
public subroutine set_flg_dosimetro_reset_all (st_tab_barcode ast_tab_barcode) throws uo_exception
public subroutine u_db_crea_view_danontrattare (string a_view_name, long a_id_meca) throws uo_exception
private function long get_imptime_sec_x_id_meca (st_tab_barcode kst_tab_barcode) throws uo_exception
private function long get_imptime_sec_x_id_meca_fila (st_tab_barcode kst_tab_barcode, integer k_nfila) throws uo_exception
public function long get_durata_lav_xfila (readonly st_tab_barcode kst_tab_barcode, integer k_nfila) throws uo_exception
public function long get_id_meca (ref st_tab_barcode kst_tab_barcode) throws uo_exception
public function boolean if_barcode_in_pl (ref st_tab_barcode ast_tab_barcode) throws uo_exception
public function uo_ds_std_1 get_figli_barcode (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function uo_ds_std_1 get_figli_barcode_uguale_sl_pt (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function st_esito get_barcode_dati_trattamento (ref st_tab_barcode kst_tab_barcode) throws uo_exception
public function boolean if_barcode_exists (readonly st_tab_barcode ast_tab_barcode) throws uo_exception
public function integer set_flg_dosimetro (ref st_tab_barcode ast_tab_barcode, ref uo_ds_std_1 ads_1) throws uo_exception
public function boolean set_data_stampa (st_tab_barcode ast_tab_barcode) throws uo_exception
public subroutine set_flg_campione_reset (st_tab_barcode ast_tab_barcode) throws uo_exception
public subroutine set_flg_campione (st_tab_barcode ast_tab_barcode) throws uo_exception
public subroutine set_flg_campione_si (st_tab_barcode ast_tab_barcode) throws uo_exception
public function boolean if_essere_barcode_figlio_g2 (st_tab_barcode kst_tab_barcode_figlio, st_tab_barcode kst_tab_barcode_padre) throws uo_exception
public function boolean tb_update_g3_reset (st_tab_barcode ast_tab_barcode) throws uo_exception
private subroutine tb_update_g3_update (ref st_tab_barcode ast_tab_barcode) throws uo_exception
public subroutine tb_update_g3 (ref st_tab_barcode ast_tab_barcode) throws uo_exception
public subroutine tb_update_g2 (ref st_tab_barcode ast_tab_barcode) throws uo_exception
public function string get_tipo_cicli (ref st_tab_barcode kst_tab_barcode) throws uo_exception
public function integer get_impianto (ref st_tab_barcode kst_tab_barcode) throws uo_exception
public function integer get_g3npass (ref st_tab_barcode kst_tab_barcode) throws uo_exception
public function boolean if_essere_barcode_figlio (st_tab_barcode kst_tab_barcode_figlio, st_tab_barcode kst_tab_barcode_padre) throws uo_exception
public subroutine get_fila_altri (ref st_tab_barcode kst_tab_barcode) throws uo_exception
public subroutine get_lav_fila (ref st_tab_barcode kst_tab_barcode) throws uo_exception
public function boolean select_barcode (ref st_tab_barcode ast_tab_barcode) throws uo_exception
public subroutine check_anomalie_lavorazione_g3 (ref st_tab_barcode ast_tab_barcode) throws uo_exception
public function integer get_impianto_x_id_armo_pl_barcode (ref st_tab_barcode ast_tab_barcode) throws uo_exception
public function long set_imptime_second_g3 (st_tab_barcode ast_tab_barcode) throws uo_exception
public function long set_imptime_second_g2 (st_tab_barcode ast_tab_barcode) throws uo_exception
public function boolean set_imptime_second (ref st_tab_barcode ast_tab_barcode) throws uo_exception
public function long get_g3lav_ciclo_firstbarcode (ref st_tab_barcode ast_tab_barcode) throws uo_exception
public function date get_data_lav_fin (ref st_tab_barcode kst_tab_barcode) throws uo_exception
private function st_esito tb_update_json (ref st_tab_barcode ast_tab_barcode) throws uo_exception
public subroutine u_update_campo (ref st_tab_barcode kst_tab_barcode, string k_campo) throws uo_exception
end prototypes

public function string togli_pl_barcode (ref st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Toglie il codice di P.L.
//=== 
//=== Input: Passare sia il BARCODE che il PL_BARCODE
//===
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "
int k_rek_ok=0
string k_codice
st_tab_pl_barcode kst_tab_pl_barcode
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if trim(kst_tab_barcode.barcode) > " " then
	
	k_codice = trim(kst_tab_barcode.barcode)

	select data_chiuso
	   into :kst_tab_pl_barcode.data_chiuso
	   from pl_barcode
		where codice = :kst_tab_barcode.pl_barcode 
		using sqlca;
	
	
	if sqlca.sqlcode = 0 then
		if kst_tab_pl_barcode.data_chiuso > date(0) then
	
			k_rek_ok = 1
	
			messagebox("Operazione non disponibile",&
				"P.L. già chiuso in data " + string(kst_tab_pl_barcode.data_chiuso, "dd/mm/yyyy"), &
				StopSign!) 
		else
			
			
			select data_lav_ini, data_lav_fin, data_lav_ok 
				into  :kst_tab_barcode.data_lav_ini
					  ,:kst_tab_barcode.data_lav_fin
					  ,:kst_tab_barcode.data_lav_ok
				from barcode
				where barcode = :k_codice
				using sqlca;
			
			choose case true
	
	
				case  kst_tab_barcode.data_lav_ok > date(0) 
	
					k_rek_ok = 0
					  
					messagebox("Attenzione",&
						"BARCODE già esitato il " + string(kst_tab_barcode.data_lav_ok, "dd/mm/yyyy") + ". Barcode " + k_codice, StopSign!) 
	
					
				case  kst_tab_barcode.data_lav_fin > date(0) 
	
					k_rek_ok = 1
					  
					messagebox("Operazione non disponibile",&
						"BARCODE già trattato, lavorazione conclusa il " + string(kst_tab_barcode.data_lav_fin, "dd/mm/yyyy") + ". Barcode " + k_codice,  &
						StopSign!) 
	
					
				case  kst_tab_barcode.data_lav_ini > date(0) 
					  
					k_rek_ok = 1
	
					messagebox("Operazione non disponibile",&
						"BARCODE in lavorazione dal " + string(kst_tab_barcode.data_lav_ini, "dd/mm/yyyy")  + ". Barcode " + k_codice,  &
						StopSign!) 
					
			end choose
	
		end if
	
		
		if k_rek_ok = 0 then
	
			update barcode 
				set 
					pl_barcode = 0, 
					data_lav_ini = convert(date,'01.01.1899')
				where barcode = :k_codice
				using kguo_sqlca_db_magazzino;
				
			if kguo_sqlca_db_magazzino.sqlcode >= 0 then
				kguo_sqlca_db_magazzino.db_commit( )
			else
				kguo_sqlca_db_magazzino.db_rollback( )
				k_return = "1" + SQLCA.SQLErrText
				kst_esito.esito = kkg_esito.ok
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.sqlerrtext = sqlca.sqlerrtext
			end if
			
		else	
	
			k_return = "2" + "Operazione non eseguita, errore gestito" 
	
		end if
	else
		k_return = "1" + SQLCA.SQLErrText
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = sqlca.sqlerrtext
	end if
else	

	messagebox("Operazione non possibile", "BARCODE non indicato", StopSign!) 

	kst_esito.esito = kkg_esito.no_esecuzione
	k_return = "2" + "Operazione non eseguita, manca il codice P.L.. Errore gestito" 

end if

if left(k_return, 1) <> "0" then kGuf_data_base.errori_scrivi_esito("W", kst_esito) // scrivi LOG


return k_return

end function

public function string togli_pl_barcode_all (ref st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Toglie il codice di P.L.
//=== 
//=== Input: Passare sia il BARCODE che il PL_BARCODE
//===
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "
int k_rek_ok=0
long k_codice
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_barcode kst1_tab_barcode 
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if kst_tab_barcode.pl_barcode > 0 then
	
	k_codice = kst_tab_barcode.pl_barcode

	select distinct data_chiuso
	   into :kst_tab_pl_barcode.data_chiuso
	   from pl_barcode
		where codice = :kst_tab_barcode.pl_barcode 
		using kguo_sqlca_db_magazzino;
	
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		
		if kst_tab_pl_barcode.data_chiuso > date(0) then
	
			k_rek_ok = 1
	
			messagebox("Operazione bloccata",&
				"P.L. è già stato chiuso in data " + string(kst_tab_pl_barcode.data_chiuso, "dd/mm/yyyy"), &
				StopSign!) 
		else
			
//--- sistemazione 27-10-2015		
			select distinct max(data_lav_ini), max(data_lav_fin), max(data_lav_ok) 
				into  :kst_tab_barcode.data_lav_ini
					  ,:kst_tab_barcode.data_lav_fin
					  ,:kst_tab_barcode.data_lav_ok
				from barcode
				where pl_barcode = :k_codice
				using kguo_sqlca_db_magazzino;
			
			choose case true
	
				case &
					  kst_tab_barcode.data_lav_ok > date(0) 
	
					k_rek_ok = 0 // era 1 ma capita che una parte sia già trattata
					  
					messagebox("Attenzione",&
						"Un BARCODE è già 'esitato' il " + string(kst_tab_barcode.data_lav_ok, "dd/mm/yyyy")  &
						+ " probabile Lotto trattato parzialmente.", &
						StopSign!) 
					
				case  &
					  kst_tab_barcode.data_lav_fin > date(0) 
	
					k_rek_ok = 1
					  
					messagebox("Operazione bloccata",&
						"Almeno un BARCODE è già trattato, lavorazione conclusa il " + string(kst_tab_barcode.data_lav_fin, "dd/mm/yyyy"),  &
						StopSign!) 
					
				case  &
					  kst_tab_barcode.data_lav_ini > date(0) 
					  
					k_rek_ok = 1
	
					messagebox("Operazione bloccata",&
						"Almeno un BARCODE è già in lavorazione dal " + string(kst_tab_barcode.data_lav_ini, "dd/mm/yyyy"),  &
						StopSign!) 
					
			end choose

		end if

		
		if k_rek_ok = 0 then
	
			kst1_tab_barcode.data_lav_ini = date(0)
			update barcode 
				set 
					pl_barcode = 0, 
					pl_barcode_progr = 0, 
					data_lav_ini = :kst1_tab_barcode.data_lav_ini
				where pl_barcode = :k_codice
				using kguo_sqlca_db_magazzino;
				
			if kguo_sqlca_db_magazzino.sqlcode >= 0 then
				kguo_sqlca_db_magazzino.db_commit( )
			else
				kguo_sqlca_db_magazzino.db_rollback( )
				k_return = "1" + kguo_sqlca_db_magazzino.SQLErrText
				kst_esito.esito = kkg_esito.ok
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.sqlerrtext = kguo_sqlca_db_magazzino.sqlerrtext
			end if
			
		else	
	
			k_return = "2" + "Operazione non eseguita, errore gestito" 
	
		end if

	else
		k_return = "1" + kguo_sqlca_db_magazzino.SQLErrText
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.sqlerrtext = kguo_sqlca_db_magazzino.sqlerrtext
		
	end if
		
else	

	kst_esito.esito = kkg_esito.no_esecuzione
	k_return = "2" + "Operazione non eseguita, manca il codice P.L.. Errore gestito" 

end if

if left(k_return, 1) <> "0" then kGuf_data_base.errori_scrivi_esito("W", kst_esito) // scrivi LOG

return k_return
end function

public function st_esito togli_pl_barcode_chiuso (st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Toglie il codice di P.L. da BARCODE gia' chiusi
//=== 
//=== Input: Passare il PL_BARCODE
//===
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Non trovato 
//===                                     2=Errore Grave
//===                                     3=altro errore
//====================================================================
//
date k_data_0
st_esito kst_esito
st_tab_armo kst_tab_armo
//st_tab_barcode kst_tab_barcode
kuf_armo kuf1_armo


	kst_esito = kguo_exception.inizializza(this.classname())

	kst_tab_barcode.ora_lav_ini = time("00:00")
	k_data_0 = date(0)

	update barcode 
		set 
			lav_fila_1 = 0
			,lav_fila_2 = 0
			,lav_fila_1p = 0
			,lav_fila_2p = 0
			,data_lav_ini = :k_data_0
			,ora_lav_ini = :kst_tab_barcode.ora_lav_ini
			,data_lav_fin = :k_data_0
			,ora_lav_fin = :kst_tab_barcode.ora_lav_ini
			,data_lav_ok = :k_data_0
			,note_lav_fin = " "
			,err_lav_fin = " "
		where pl_barcode = :kst_tab_barcode.pl_barcode
		using kguo_sqlca_db_magazzino;
				
		if kguo_sqlca_db_magazzino.sqlcode >= 0 then
			kguo_sqlca_db_magazzino.db_commit( )
		else
			kguo_sqlca_db_magazzino.db_rollback( )

			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Barcode: " + trim(SQLCA.SQLErrText)
			kst_esito.esito = "2"
	end if


return kst_esito

end function

public function st_esito tb_prendi_campo (ref st_tab_barcode kst_tab_barcode, string k_campo);//
//====================================================================
//=== Prende un campo del rek Barcode
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//====================================================================

st_esito kst_esito 
kuf_base kuf1_base


	kst_esito = kguo_exception.inizializza(this.classname())

	if trim(k_campo) > " " then

		kst_tab_barcode.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_barcode.x_utente = kGuf_data_base.prendi_x_utente()

		choose case k_campo


			case "fila_1_e_fila_2"
				
				select sl_pt.tipo_cicli,
				       sl_pt.fila_1, 
						 sl_pt.fila_2,
				       sl_pt.fila_1p, 
						 sl_pt.fila_2p
					into :kst_tab_barcode.tipo_cicli,
					     :kst_tab_barcode.fila_1,
						  :kst_tab_barcode.fila_2,
					     :kst_tab_barcode.fila_1p,
						  :kst_tab_barcode.fila_2p
					from (barcode inner join armo on
						  barcode.id_armo = armo.id_armo)
						  inner join sl_pt on
						  armo.cod_sl_pt = sl_pt.cod_sl_pt
					where barcode.barcode = :kst_tab_barcode.barcode;
						
				if sqlca.sqlcode <> 0 then
					kst_esito.esito = "1"
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.sqlerrtext = "SL-PT del Barcode " + trim(kst_tab_barcode.barcode) &
					            + " non trovato (Errore=" &
								  + string (sqlca.sqlcode, "#####") + " " + trim(sqlca.sqlerrtext) + ")"
				else													  

					if isnull(kst_tab_barcode.tipo_cicli) then
						kst_tab_barcode.tipo_cicli = " "
					end if
					if isnull(kst_tab_barcode.fila_1) then
						kst_tab_barcode.fila_1 = 0
					end if
					if isnull(kst_tab_barcode.fila_1p) then
						kst_tab_barcode.fila_1p = 0
					end if
					if isnull(kst_tab_barcode.fila_2) then
						kst_tab_barcode.fila_2 = 0
					end if
					if isnull(kst_tab_barcode.fila_2p) then
						kst_tab_barcode.fila_2p = 0
					end if
						
				end if
				
				
//			case "conta_groupage_id_armo"
			case "conta_barcode_pl_id_armo"
				
				kst_tab_barcode.contati = 0
				select count(*) 
					into :kst_tab_barcode.contati
					from barcode 
					where (barcode.pl_barcode = :kst_tab_barcode.pl_barcode 
					       or :kst_tab_barcode.pl_barcode = 0)
					      and barcode.id_armo = :kst_tab_barcode.id_armo;
						
				if sqlca.sqlcode <> 0 then
					kst_esito.esito = "1"
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.sqlerrtext = "Piano di Lavoro " + string(kst_tab_barcode.pl_barcode) &
					           + " non trovato in tab. Barcode (Errore=" &
								  + string (sqlca.sqlcode, "#####") + " " + trim(sqlca.sqlerrtext) + ")"
				end if

				if isnull(kst_tab_barcode.contati) then
					kst_tab_barcode.contati = 0
				end if

			case else 
				kst_esito.esito = "1"
				kst_esito.sqlcode = 0
				kst_esito.sqlerrtext = "Errore Interno, sbagliato parametro di programma:" + string(k_campo) 
				
		end choose


	end if

return kst_esito

end function

public function st_esito tb_update_campo (st_tab_barcode kst_tab_barcode, string k_campo);/*
     ATTENZIONE USARE U_UPDATE_CAMPO CHE LANCIA UN EXCEPTION !!!!
*/

//====================================================================
//=== Update un campo del rek Piano Lavorazione Barcode
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//=== 
//====================================================================
date k_data_NO
st_esito kst_esito 
kuf_base kuf1_base



	kst_esito = kguo_exception.inizializza(this.classname())
	kst_esito.st_tab_g_0 = kst_tab_barcode.st_tab_g_0 

	if trim(k_campo) > " " then
	
		kst_tab_barcode.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_barcode.x_utente = kGuf_data_base.prendi_x_utente()
						
		choose case k_campo
				
			case "data_lav_ini"
				
				if isnull(kst_tab_barcode.lav_fila_1) then kst_tab_barcode.lav_fila_1 = 0
				if isnull(kst_tab_barcode.lav_fila_2) then kst_tab_barcode.lav_fila_2 = 0
				if isnull(kst_tab_barcode.lav_fila_1p) then kst_tab_barcode.lav_fila_1p = 0
				if isnull(kst_tab_barcode.lav_fila_2p) then kst_tab_barcode.lav_fila_2p = 0
				if isnull(kst_tab_barcode.posizione) then	kst_tab_barcode.posizione = " "
				if isnull(kst_tab_barcode.bilancella) then kst_tab_barcode.bilancella = 0
				if isnull(kst_tab_barcode.ora_lav_ini) then kst_tab_barcode.ora_lav_ini = time("00:00")

				if isnull(kst_tab_barcode.g3lav_ngiri) then kst_tab_barcode.g3lav_ngiri = 0
				if isnull(kst_tab_barcode.g3lav_ciclo) then kst_tab_barcode.g3lav_ciclo = 0
				if isnull(kst_tab_barcode.g3lav_npass) then kst_tab_barcode.g3lav_npass = 0
								
				update barcode set 	 
						 lav_fila_1 = :kst_tab_barcode.lav_fila_1,
						 lav_fila_2 = :kst_tab_barcode.lav_fila_2,
						 lav_fila_1p = :kst_tab_barcode.lav_fila_1p,
						 lav_fila_2p = :kst_tab_barcode.lav_fila_2p,
						 ora_lav_ini = :kst_tab_barcode.ora_lav_ini,
						 data_lav_ini = :kst_tab_barcode.data_lav_ini,
						 err_lav_fin  = :kst_tab_barcode.err_lav_fin,
						 posizione = :kst_tab_barcode.posizione,
						 bilancella = :kst_tab_barcode.bilancella,
						 g3lav_ngiri = :kst_tab_barcode.g3lav_ngiri,
						 g3lav_ciclo = :kst_tab_barcode.g3lav_ciclo,
						 g3lav_npass = :kst_tab_barcode.g3lav_npass,
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where barcode = :kst_tab_barcode.barcode
					using kguo_sqlca_db_magazzino;


//--- aggiorna giri nel barcode				
			case "barcode_update_giri"
				
				kst_tab_barcode.modgiri_data = kGuf_data_base.prendi_x_datins()
				kst_tab_barcode.modgiri_utente = kGuf_data_base.prendi_x_utente()
				
				if isnull(kst_tab_barcode.tipo_cicli) then kst_tab_barcode.tipo_cicli = " " 
				if isnull(kst_tab_barcode.lav_fila_1) then kst_tab_barcode.lav_fila_1 = 0
				if isnull(kst_tab_barcode.lav_fila_2) then kst_tab_barcode.lav_fila_2 = 0
				if isnull(kst_tab_barcode.lav_fila_1p) then kst_tab_barcode.lav_fila_1p = 0
				if isnull(kst_tab_barcode.lav_fila_2p) then kst_tab_barcode.lav_fila_2p = 0

				update barcode set 	 
						 tipo_cicli = :kst_tab_barcode.tipo_cicli,
						 fila_1 = :kst_tab_barcode.fila_1,
						 fila_2 = :kst_tab_barcode.fila_2,
						 fila_1p = :kst_tab_barcode.fila_1p,
						 fila_2p = :kst_tab_barcode.fila_2p,
						 modgiri_data = :kst_tab_barcode.modgiri_data,
						 modgiri_utente = :kst_tab_barcode.modgiri_utente,
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where barcode = :kst_tab_barcode.barcode
					using kguo_sqlca_db_magazzino;
				
	
//--- aggiorna giri G3 nel barcode				
			case "barcode_update_giri_g3"
				
				kst_tab_barcode.modgiri_data = kGuf_data_base.prendi_x_datins()
				kst_tab_barcode.modgiri_utente = kGuf_data_base.prendi_x_utente()
				
				if isnull(kst_tab_barcode.g3lav_ngiri) then kst_tab_barcode.g3lav_ngiri = 0
				if isnull(kst_tab_barcode.g3lav_ciclo) then kst_tab_barcode.g3lav_ciclo = 0
				if isnull(kst_tab_barcode.g3lav_npass) then kst_tab_barcode.g3lav_npass = 0

				update barcode set 	 
						 g3lav_ngiri = :kst_tab_barcode.g3lav_ngiri,
						 g3lav_ciclo = :kst_tab_barcode.g3lav_ciclo,
						 g3lav_npass = :kst_tab_barcode.g3lav_npass,
						 modgiri_data = :kst_tab_barcode.modgiri_data,
						 modgiri_utente = :kst_tab_barcode.modgiri_utente,
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where barcode = :kst_tab_barcode.barcode
					using kguo_sqlca_db_magazzino;
				

			case "ripri_pl_barcode"
				
				update barcode set 	 
						 pl_barcode = 0,
						 pl_barcode_progr = 0,
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where barcode = :kst_tab_barcode.barcode
					using kguo_sqlca_db_magazzino;
				
				

			case "ripri_fila_orig"
//				
					select sl_pt.tipo_cicli, 
					       sl_pt.fila_1, 
					       sl_pt.fila_2,
							 sl_pt.fila_1p, 
					       sl_pt.fila_2p
					   into 
						     :kst_tab_barcode.tipo_cicli,
						     :kst_tab_barcode.fila_1,
						     :kst_tab_barcode.fila_2,
					        :kst_tab_barcode.fila_1p,
						     :kst_tab_barcode.fila_2p
					   from (barcode inner join armo on
						     barcode.id_armo = armo.id_armo)
							  inner join sl_pt on
							  armo.cod_sl_pt = sl_pt.cod_sl_pt
					   where barcode.barcode = :kst_tab_barcode.barcode;
						
					if kguo_sqlca_db_magazzino.sqlcode <> 0 then
						kst_esito.esito = kkg_esito.not_fnd
						kst_esito.sqlerrtext = "Piano di Lavorazione (SL-PT) non trovato (Errore=" &
						           + string (kguo_sqlca_db_magazzino.sqlcode, "#####") + " " + trim(kguo_sqlca_db_magazzino.sqlerrtext) + ")"
					else													  
	
						kst_tab_barcode.modgiri_data = kGuf_data_base.prendi_x_datins()
						kst_tab_barcode.modgiri_utente = kGuf_data_base.prendi_x_utente()
						
						if isnull(kst_tab_barcode.fila_1) then
							kst_tab_barcode.fila_1 = 0
						end if
						if isnull(kst_tab_barcode.fila_2) then
							kst_tab_barcode.fila_2 = 0
						end if
						
						update barcode set 	 
							 tipo_cicli = :kst_tab_barcode.tipo_cicli,
							 fila_1 = :kst_tab_barcode.fila_1,
							 fila_2 = :kst_tab_barcode.fila_2,
							 fila_1p = :kst_tab_barcode.fila_1p,
							 fila_2p = :kst_tab_barcode.fila_2p,
							 modgiri_data = :kst_tab_barcode.modgiri_data,
							 modgiri_utente = :kst_tab_barcode.modgiri_utente,
							 x_datins = :kst_tab_barcode.x_datins,
							 x_utente = :kst_tab_barcode.x_utente
						where barcode = :kst_tab_barcode.barcode
						using kguo_sqlca_db_magazzino;
					end if
				
				
			case "data_lav_fin"
				
				if isnull(kst_tab_barcode.ora_lav_fin) then
					kst_tab_barcode.ora_lav_fin = time("00:00")
				end if

				update barcode set 	 
						 data_lav_fin = :kst_tab_barcode.data_lav_fin,
						 ora_lav_fin = :kst_tab_barcode.ora_lav_fin,
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where barcode = :kst_tab_barcode.barcode
					using kguo_sqlca_db_magazzino;
				


			case "data_lav_ini_fin"
				
				if trim(kst_tab_barcode.err_lav_fin) > " " then
				else
					kst_tab_barcode.err_lav_fin = "0"
				end if

				if isnull(kst_tab_barcode.lav_fila_1) then kst_tab_barcode.lav_fila_1 = 0
				if isnull(kst_tab_barcode.lav_fila_2) then kst_tab_barcode.lav_fila_2 = 0
				if isnull(kst_tab_barcode.lav_fila_1p) then kst_tab_barcode.lav_fila_1p = 0
				if isnull(kst_tab_barcode.lav_fila_2p) then kst_tab_barcode.lav_fila_2p = 0
				if isnull(kst_tab_barcode.posizione) then	kst_tab_barcode.posizione = " "
				if isnull(kst_tab_barcode.bilancella) then kst_tab_barcode.bilancella = 0
				if isnull(kst_tab_barcode.ora_lav_ini) then kst_tab_barcode.ora_lav_ini = time("00:00")
				if isnull(kst_tab_barcode.ora_lav_fin) then kst_tab_barcode.ora_lav_fin = time("00:00")
				if trim(kst_tab_barcode.note_lav_fin) > " " then
					kst_tab_barcode.note_lav_fin = trim(kst_tab_barcode.note_lav_fin)
				else
					kst_tab_barcode.note_lav_fin = ""
				end if
				if trim(kst_tab_barcode.note_lav_ok) > " " then
					kst_tab_barcode.note_lav_ok = trim(kst_tab_barcode.note_lav_ok)
				else
					kst_tab_barcode.note_lav_ok = ""
				end if
				
				if isnull(kst_tab_barcode.g3lav_ngiri) then kst_tab_barcode.g3lav_ngiri = 0
				if isnull(kst_tab_barcode.g3lav_ciclo) then kst_tab_barcode.g3lav_ciclo = 0
				if isnull(kst_tab_barcode.g3lav_npass) then kst_tab_barcode.g3lav_npass = 0
				
				update barcode set 	 
						 lav_fila_1 = :kst_tab_barcode.lav_fila_1,
						 lav_fila_2 = :kst_tab_barcode.lav_fila_2,
						 lav_fila_1p = :kst_tab_barcode.lav_fila_1p,
						 lav_fila_2p = :kst_tab_barcode.lav_fila_2p,
						 ora_lav_ini = :kst_tab_barcode.ora_lav_ini,
						 ora_lav_fin = :kst_tab_barcode.ora_lav_fin,
						 data_lav_ini = :kst_tab_barcode.data_lav_ini,
						 data_lav_fin = :kst_tab_barcode.data_lav_fin,
						 err_lav_fin  = :kst_tab_barcode.err_lav_fin,
						 note_lav_fin = :kst_tab_barcode.note_lav_fin,
						 upd_data_fin = :kst_tab_barcode.x_datins,
						 upd_utente_fin = :kst_tab_barcode.x_utente,
						 posizione = :kst_tab_barcode.posizione,
						 bilancella = :kst_tab_barcode.bilancella,
						 g3lav_ngiri = :kst_tab_barcode.g3lav_ngiri,
						 g3lav_ciclo = :kst_tab_barcode.g3lav_ciclo,
						 g3lav_npass = :kst_tab_barcode.g3lav_npass,
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where barcode = :kst_tab_barcode.barcode
					using kguo_sqlca_db_magazzino;


			case "data_lav_ok_x_rif"
				
				if isnull(kst_tab_barcode.err_lav_ok) or LenA(trim(kst_tab_barcode.err_lav_ok)) = 0 then
					kst_tab_barcode.err_lav_ok = "0"
				end if
				
				kst_tab_barcode.causale = ki_causale_non_trattare
				update barcode set 	 
			          data_lav_ok  = :kst_tab_barcode.data_lav_ok,   
						 err_lav_ok  = :kst_tab_barcode.err_lav_ok,
						 note_lav_ok = :kst_tab_barcode.note_lav_ok,
	                upd_data_ok  = :kst_tab_barcode.x_datins,   
                   upd_utente_ok  = :kst_tab_barcode.x_utente,
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where num_int = :kst_tab_barcode.num_int
					      and data_int = :kst_tab_barcode.data_int
			 			   and (causale is null or causale <> :kst_tab_barcode.causale)
					using kguo_sqlca_db_magazzino;


			case "data_lav_ok_x_barcode"
				
				if trim(kst_tab_barcode.barcode) > " " then
					update barcode set 	 
							 data_lav_ok  = :kst_tab_barcode.data_lav_ok,   
							 err_lav_ok  = :kst_tab_barcode.err_lav_ok,
							 note_lav_ok = :kst_tab_barcode.note_lav_ok,
							 upd_data_ok  = :kst_tab_barcode.x_datins,   
							 upd_utente_ok  = :kst_tab_barcode.x_utente,
							 x_datins = :kst_tab_barcode.x_datins,
							 x_utente = :kst_tab_barcode.x_utente
						where barcode = :kst_tab_barcode.barcode
						using kguo_sqlca_db_magazzino;
				else
					kst_esito.esito = kkg_esito.no_esecuzione
					kst_esito.sqlerrtext = "Errore Interno, manca il codice barcode per impostare la data Convalida"
				end if
	

			case "data_lav_ok_x_id_meca_barcode_altri"
				k_data_no = kkg.DATA_NO
				kst_tab_barcode.causale = ki_causale_non_trattare
				if kst_tab_barcode.id_meca > 0 then
					update barcode set 	 
							 data_lav_ok  = :kst_tab_barcode.data_lav_ok,   
							 err_lav_ok  = :kst_tab_barcode.err_lav_ok,
							 note_lav_ok = :kst_tab_barcode.note_lav_ok,
							 upd_data_ok  = :kst_tab_barcode.x_datins,   
							 upd_utente_ok  = :kst_tab_barcode.x_utente,
							 x_datins = :kst_tab_barcode.x_datins,
							 x_utente = :kst_tab_barcode.x_utente
						where id_meca = :kst_tab_barcode.id_meca
								 and (data_lav_ok is null or data_lav_ok < :k_data_no)
								 and (causale is null or causale <> :kst_tab_barcode.causale)
						using kguo_sqlca_db_magazzino;
					else
						kst_esito.esito = kkg_esito.no_esecuzione
						kst_esito.sqlerrtext = "Errore Interno, manca il ID del Lotto per impostare la data Convalida sui barcode"
					end if


			case else 
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.sqlerrtext = "Errore Interno, sbagliato parametro di programma:" + string(k_campo) 
				
		end choose


		if kst_esito.esito = kkg_esito.ok then
			if kguo_sqlca_db_magazzino.sqlcode >= 0 then
				if kst_esito.st_tab_g_0.esegui_commit = "N" then
				else
					kguo_sqlca_db_magazzino.db_commit( )
				end if
			else
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.sqlerrtext = "Errore aggiornamento (" + k_campo + ") Barcode " + trim(kst_tab_barcode.barcode) &
											+ "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
				if kst_esito.st_tab_g_0.esegui_commit = "N" then
				else
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
			end if
		end if

	end if

return kst_esito


end function

public subroutine if_isnull (ref st_tab_barcode kst_tab_barcode);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_barcode.barcode) then	kst_tab_barcode.barcode = ""
if isnull(kst_tab_barcode.fila_1) then	kst_tab_barcode.fila_1 = 0
if isnull(kst_tab_barcode.fila_1p) then	kst_tab_barcode.fila_1p = 0
if isnull(kst_tab_barcode.fila_2) then	kst_tab_barcode.fila_2 = 0
if isnull(kst_tab_barcode.fila_2p) then	kst_tab_barcode.fila_2p = 0
if isnull(kst_tab_barcode.lav_fila_1) then kst_tab_barcode.lav_fila_1 = 0
if isnull(kst_tab_barcode.lav_fila_1p) then kst_tab_barcode.lav_fila_1p = 0
if isnull(kst_tab_barcode.lav_fila_2) then kst_tab_barcode.lav_fila_2 = 0
if isnull(kst_tab_barcode.lav_fila_2p) then kst_tab_barcode.lav_fila_2p = 0
if isnull(kst_tab_barcode.note_lav_fin) then	kst_tab_barcode.note_lav_fin = ""
if isnull(kst_tab_barcode.err_lav_fin) then kst_tab_barcode.err_lav_fin = "0"
if isnull(kst_tab_barcode.data_lav_fin) then	kst_tab_barcode.data_lav_fin = date(0)
if isnull(kst_tab_barcode.flg_dosimetro ) then kst_tab_barcode.flg_dosimetro = ki_flg_dosimetro_NO

if isnull(kst_tab_barcode.data) then kst_tab_barcode.data = date(0)
if isnull(kst_tab_barcode.BARCODE_lav) then	 kst_tab_barcode.BARCODE_lav = ""
if isnull(kst_tab_barcode.groupage) then kst_tab_barcode.groupage = ""
if isnull(kst_tab_barcode.id_armo) then	kst_tab_barcode.id_armo = 0
if isnull(kst_tab_barcode.tipo_cicli) then kst_tab_barcode.tipo_cicli = ""
if isnull(kst_tab_barcode.id_armo) then	kst_tab_barcode.id_armo = 0
if isnull(kst_tab_barcode.pl_barcode) then	kst_tab_barcode.pl_barcode = 0
if isnull(kst_tab_barcode.pl_barcode_progr) then	kst_tab_barcode.pl_barcode_progr = 0
if isnull(kst_tab_barcode.id_meca) then	kst_tab_barcode.id_meca = 0
if isnull(kst_tab_barcode.num_int) then	kst_tab_barcode.num_int = 0
if isnull(kst_tab_barcode.data_int) then kst_tab_barcode.data_int = date(0)
if isnull(kst_tab_barcode.causale) then kst_tab_barcode.causale = ""
if isnull(kst_tab_barcode.data_stampa) then kst_tab_barcode.data_stampa = date(0)
if isnull(kst_tab_barcode.data_lav_ini) then kst_tab_barcode.data_lav_ini = date(0)
if isnull(kst_tab_barcode.data_lav_ok) then kst_tab_barcode.data_lav_ok = date(0)
if isnull(kst_tab_barcode.data_sosp) then kst_tab_barcode.data_sosp = date(0)
if isnull(kst_tab_barcode.ora_lav_ini) then kst_tab_barcode.ora_lav_ini = time(0)
if isnull(kst_tab_barcode.ora_lav_fin) then kst_tab_barcode.ora_lav_fin = time(0)
if isnull(kst_tab_barcode.ora_lav_ini) then kst_tab_barcode.ora_lav_ini = time(0)
if isnull(kst_tab_barcode.err_lav_ok) then kst_tab_barcode.err_lav_ok = ""
if isnull(kst_tab_barcode.note_lav_ok) then kst_tab_barcode.note_lav_ok = ""
if isnull(kst_tab_barcode.posizione) then kst_tab_barcode.posizione = ""
if isnull(kst_tab_barcode.bilancella) then kst_tab_barcode.bilancella = 0
if isnull(kst_tab_barcode.lav_dose) then	kst_tab_barcode.lav_dose = 0.00
if isnull(kst_tab_barcode.upd_data_fin) then kst_tab_barcode.upd_data_fin = datetime(date(0))
if isnull(kst_tab_barcode.upd_utente_fin) then kst_tab_barcode.upd_utente_fin = ""
if isnull(kst_tab_barcode.upd_data_ok) then kst_tab_barcode.upd_data_ok = datetime(date(0))
if isnull(kst_tab_barcode.upd_utente_ok) then kst_tab_barcode.upd_utente_ok = ""
if isnull(kst_tab_barcode.modgiri_data) then kst_tab_barcode.modgiri_data = datetime(date(0))
if isnull(kst_tab_barcode.modgiri_utente) then kst_tab_barcode.modgiri_utente = ""
if isnull(kst_tab_barcode.x_datins) then kst_tab_barcode.x_datins = datetime(date(0))
if isnull(kst_tab_barcode.x_utente) then kst_tab_barcode.x_utente = ""
if isnull(kst_tab_barcode.imptime_second) then kst_tab_barcode.imptime_second = 0

if isnull(kst_tab_barcode.g3ngiri) then kst_tab_barcode.g3ngiri = 0
if isnull(kst_tab_barcode.id_sl_pt_g3_lav) then kst_tab_barcode.id_sl_pt_g3_lav = 0
if isnull(kst_tab_barcode.g3ciclo) then kst_tab_barcode.g3ciclo = 0
if isnull(kst_tab_barcode.g3npass) then kst_tab_barcode.g3npass = 0
if isnull(kst_tab_barcode.g3lav_ngiri) then kst_tab_barcode.g3lav_ngiri = 0
if isnull(kst_tab_barcode.g3lav_ciclo) then kst_tab_barcode.g3lav_ciclo = 0
if isnull(kst_tab_barcode.g3lav_npass) then kst_tab_barcode.g3lav_npass = 0

  
end subroutine

public function st_esito tb_delete_x_rif (ref st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Cancella i rek dalla tabella BARCODE con l'id del RIFERIMENTO
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================
boolean k_sicurezza
st_esito kst_esito
//st_open_w kst_open_w
st_tab_barcode kst1_tab_barcode
//kuf_sicurezza kuf1_sicurezza


kst_esito = kguo_exception.inizializza(this.classname())

//kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
//kst_open_w.id_programma = kkg_id_programma_barcode
//
////--- controlla se utente autorizzato alla funzione in atto
//kuf1_sicurezza = create kuf_sicurezza
//k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza
try
	k_sicurezza = if_sicurezza(kkg_flag_modalita.cancellazione)

//if not k_sicurezza then
//
//	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
//	kst_esito.SQLErrText = "Cancellazione dei Barcode non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//	kst_esito.esito = "1"
//
//else

//--- evito la commit all'interno di ogni barcode xche' la faccio dopo sull'intero riferimento
	//kst1_tab_barcode.st_tab_g_0.esegui_commit = "N"     // meglio non fare x TemporalTable?

	delete from barcode
			where id_meca = :kst_tab_barcode.id_meca
			using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito = kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in cancellazione di tutti i Barcode del Lotto id " +  string(kst_tab_barcode.id_meca))
	end if


//	declare  c_barcode_tb_delete_x_rif cursor for
//		select barcode from barcode
//			where id_meca = :kst_tab_barcode.id_meca
//			using kguo_sqlca_db_magazzino;
//
////--- ciclo di cancellazione barcode x barcode
//	open c_barcode_tb_delete_x_rif;
//	fetch c_barcode_tb_delete_x_rif into :kst1_tab_barcode.barcode;
//	do while kguo_sqlca_db_magazzino.sqlcode = 0 and kst_esito.esito = kkg_esito.ok
//	
//		kst_esito = tb_delete_barcode(kst1_tab_barcode) // RIMOZIONE BARCODE
//	
//		fetch c_barcode_tb_delete_x_rif into :kst1_tab_barcode.barcode;
//	
//	loop

	if kst_esito.esito = kkg_esito.db_ko then
//		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
//		kst_esito.SQLErrText = &
//					"Errore durante la cancellazione dei Barcode (id_meca =" &
//					+ string(kst_tab_barcode.id_meca, "####0") + ") " &
//					+ " ~n~rErrore-tab.BARCODE:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kst_tab_barcode.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
	else
		if kst_tab_barcode.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	
end try



return kst_esito
end function

public function st_tab_barcode get_primo_barcode_in_lav () throws uo_exception;//
//====================================================================
//=== Estrae barcode e data del piu' vecchio ancora in lavorazione (da una certa data ad oggi)  
//=== 
//=== Input: nulla
//=== Output: la struttura st_tab_barcode con la DATA_lav_ini valorizzata
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
st_tab_barcode kst_tab_barcode
string k_dataoggi_x
kuf_base kuf1_base
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	kuf1_base = create kuf_base
	k_dataoggi_x = MidA(kuf1_base.prendi_dato_base("dataoggi"),2)
	if isdate(k_dataoggi_x) then
		kst_tab_barcode.data_lav_ini = relativedate (date(k_dataoggi_x), -30)  //indietro di 1 mese
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Errore in Lettura Data-oggi:  " + k_dataoggi_x
		kst_esito.esito = kkg_esito.err_formale
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if

	select distinct min(barcode)
	         ,data_lav_ini
		into
	          :kst_tab_barcode.barcode,
			 :kst_tab_barcode.data_lav_ini
		from barcode
		where data_lav_ini = :kst_tab_barcode.data_lav_ini
		group by barcode.data_lav_ini
		using sqlca;


	if sqlca.sqlcode >= 0 then
		if sqlca.sqlcode > 0 then
			kst_tab_barcode.barcode = " "
			kst_tab_barcode.data_lav_ini = date(0)
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Barcode: " + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if


return kst_tab_barcode

end function

public subroutine check_anomalie_lavorazione (ref st_tab_barcode kst_tab_barcode) throws uo_exception;//
//=== Controlla dati di LAVORAZIONE 
//--- 
//--- Input: reference della struttura st_tab_barcode con i dati di trattamento valorizzati
//--- Output: struttura st_tab_barcode con i dati di esito valorizzati
//---
//--- Lancia un EXCEPTION se si verificano errore gravi
//---
//---
//--- Estrae da archivio Pilota di out
//---
//--- k_errore: 2=interrotto da utente/dati insuff 1=errore programma 
//
string k_barcode_esito="0", k_flag_esponi_gia_lavorato
st_esito kst_esito
kuf_armo kuf1_armo
kuf_sl_pt kuf1_sl_pt
st_tab_sl_pt kst_tab_sl_pt, kst_tab_sl_pt_vuota
st_tab_armo kst_tab_armo, kst1_tab_armo, kst_tab_armo_vuota


try
	SetPointer(kkg.pointer_attesa)

	kst_esito = kguo_exception.inizializza(this.classname())
		
	//---- x default esito POSITIVO
	kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ok
	
			
	kuf1_sl_pt = create kuf_sl_pt
	kuf1_armo = create kuf_armo
	
	//--- pulizia campi di appoggio
	kst_tab_sl_pt.fila_1 = 0
	kst_tab_sl_pt.fila_2 = 0
	kst_tab_sl_pt.fila_1p = 0
	kst_tab_sl_pt.fila_2p = 0
	kst_tab_barcode.note_lav_fin = ""
	
	if kst_tab_barcode.id_armo > 0 then
	
	//--- legge tab ARMO x prendere cod sl-pt
		kst_tab_armo = kst_tab_armo_vuota
		kst_tab_armo.id_armo = kst_tab_barcode.id_armo
		kst_esito = kuf1_armo.leggi_riga("1", kst_tab_armo)
	
		if kst_esito.esito = kkg_esito.ok and kst_tab_armo.num_int > 0 then
	
	//--- legge tab ARMO x prendere totale colli del riferimento 
			kst1_tab_armo = kst_tab_armo_vuota
			kst1_tab_armo.id_armo = kst_tab_barcode.id_armo
			kst_esito = kuf1_armo.leggi_riga("R", kst1_tab_armo)
			if kst_esito.esito <> kkg_esito.ok then
				kst1_tab_armo.colli_2 = 0
			end if
							
	//--- legge tab SL PT x prendere cod GIRI FILA
			if not isnull(kst_tab_armo.cod_sl_pt) and &
				LenA(trim(kst_tab_armo.cod_sl_pt)) > 0 then
				
				kst_tab_sl_pt = kst_tab_sl_pt_vuota
				kst_tab_sl_pt.cod_sl_pt = kst_tab_armo.cod_sl_pt 
				kst_esito = kuf1_sl_pt.select_riga(kst_tab_sl_pt)
				if kst_esito.esito <> kkg_esito.ok then
					kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
					kst_tab_barcode.note_lav_fin += "SL-PT non Trovato - "
				else
					
					if (kst_tab_sl_pt.fila_1 = 0 or isnull(kst_tab_sl_pt.fila_1)) &
						and (kst_tab_sl_pt.fila_2 = 0 or isnull(kst_tab_sl_pt.fila_2)) &
						and (kst_tab_sl_pt.fila_1p = 0 or isnull(kst_tab_sl_pt.fila_1p)) &
						and (kst_tab_sl_pt.fila_2p = 0 or isnull(kst_tab_sl_pt.fila_2p)) &
						then
						kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
						kst_tab_barcode.note_lav_fin +=  "Cicli Non Impostati su SL-PT - "
					end if
								
				end if
			else
				kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
				kst_tab_barcode.note_lav_fin +=  "SL-PT non Impostato in Entrata (vedi riferimento) - " 
				kst_tab_sl_pt.cod_sl_pt = " "
				kst_tab_sl_pt.descr = " "
			end if
		else
			kst_tab_barcode.note_lav_fin +=  "Riga Entrata merce non Trovata - " 
		end if
	else
		kst_tab_barcode.note_lav_fin +=  "Riga Entrata sconosciuta - " 
	end if
		
	if kst_esito.esito = kkg_esito.db_ko then // errore grave SQL
		kGuo_exception.set_esito (kst_esito)
		throw kGuo_exception
	end if
		
	//--- controllo valori dei Cicli	del PILOTA con quelli presenti sul BARCODE		
	if isnull(kst_tab_barcode.fila_1) then kst_tab_barcode.fila_1 = 0  
	if isnull(kst_tab_barcode.fila_2) then kst_tab_barcode.fila_2 = 0  
	if isnull(kst_tab_barcode.fila_1p) then kst_tab_barcode.fila_1p = 0  
	if isnull(kst_tab_barcode.fila_2p) then kst_tab_barcode.fila_2p = 0  
	if isnull(kst_tab_sl_pt.fila_1) then kst_tab_sl_pt.fila_1 = 0  
	if isnull(kst_tab_sl_pt.fila_2) then kst_tab_sl_pt.fila_2 = 0  
	if isnull(kst_tab_sl_pt.fila_1p) then	kst_tab_sl_pt.fila_1p = 0  
	if isnull(kst_tab_sl_pt.fila_2p) then kst_tab_sl_pt.fila_2p = 0  
						
	//--- controllo se cicli impostati almeno sul piano di lavorazione 
	if kst_tab_sl_pt.fila_1 = 0 and kst_tab_barcode.fila_1 = 0 &
		and kst_tab_sl_pt.fila_2 = 0 and kst_tab_barcode.fila_2 = 0 &
		and kst_tab_sl_pt.fila_1p = 0 and kst_tab_barcode.fila_1p = 0 &
		and kst_tab_sl_pt.fila_2p = 0 and kst_tab_barcode.fila_2p = 0 then
		kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
		kst_tab_barcode.note_lav_fin +=   "PT e Pianificazione Lav. senza Cicli - " 
	else
	
	//--- confronto tra cicli pianificati nel barcode con quelli su Sl-PT
		if kst_tab_sl_pt.fila_1 <> kst_tab_barcode.fila_1 then
			if kst_tab_sl_pt.tipo_cicli <> kuf1_sl_pt.ki_tipo_cicli_a_scelta then
				kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
				kst_tab_barcode.note_lav_fin +=   "Impostati Cicli diversi tra PT (F1=" & 
										 + trim(string(kst_tab_sl_pt.fila_1)) + ") " &
										 + "e Pianificazione Lav. (F1=" &
										 + trim(string(kst_tab_barcode.fila_1)) + ") "
	//			k_barcode_esito_txt = k_barcode_esito_txt + "Impostati Cicli diversi tra SL-PT (F1=" &
			else
	//--- se tipo cicli "a scelta" controllo se diverso anche fila 2
				if kst_tab_sl_pt.fila_2 <> kst_tab_barcode.fila_2 then
					kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
					kst_tab_barcode.note_lav_fin +=    "Impostati Cicli diversi tra PT (F1/2=" & 
										 + trim(string(kst_tab_sl_pt.fila_1)) + "/" &
										 + trim(string(kst_tab_sl_pt.fila_2)) + ") " &
										 + "e Pianinicazione Lav. (F1/2=" &
										 + trim(string(kst_tab_barcode.fila_1)) + "/" &
										 + trim(string(kst_tab_barcode.fila_2)) + ") "
	//				k_barcode_esito_txt = k_barcode_esito_txt + "Impostati Cicli diversi tra SL-PT (F1/2=" &
				end if	
			end if	
		end if
		if kst_tab_sl_pt.fila_1p <> kst_tab_barcode.fila_1p then
			if kst_tab_sl_pt.tipo_cicli <> kuf1_sl_pt.ki_tipo_cicli_a_scelta then
				kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
				kst_tab_barcode.note_lav_fin +=  "Impostati Cicli permutati diversi tra PT (F1p=" & 
									 + trim(string(kst_tab_sl_pt.fila_1p)) + ") " &
									 + "e Pianificazione Lav. (F1p=" &
									 + trim(string(kst_tab_barcode.fila_1p)) + ") "
	//			k_barcode_esito_txt = k_barcode_esito_txt + "Impostati Cicli permutati diversi tra SL-PT (F1p=" &
			else
	//--- se tipo cicli "a scelta" controllo se diverso anche fila 2
				if kst_tab_sl_pt.fila_2p <> kst_tab_barcode.fila_2p then
					kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
					kst_tab_barcode.note_lav_fin += "Impostati Cicli permutati diversi tra PT (F1p/2p="  & 
										 + trim(string(kst_tab_sl_pt.fila_1p)) + "/" &
										 + trim(string(kst_tab_sl_pt.fila_2p)) + ") " &
										 + "e Pianificazione Lav. (F1p/2p=" &
										 + trim(string(kst_tab_barcode.fila_1p)) + "/" &
										 + trim(string(kst_tab_barcode.fila_2p)) + ") "
	//				k_barcode_esito_txt = k_barcode_esito_txt + "Impostati Cicli permutati diversi tra SL-PT (F1p/2p=" &
				end if	
			end if	
		end if
		if kst_tab_sl_pt.tipo_cicli <> kuf1_sl_pt.ki_tipo_cicli_a_scelta then
			if kst_tab_sl_pt.fila_2 <> kst_tab_barcode.fila_2 then
				kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
				kst_tab_barcode.note_lav_fin += "Impostati Cicli diversi tra PT (F2="  & 
											 + trim(string(kst_tab_sl_pt.fila_2)) + ") " &
											 + "e Pianificazione Lav. (F2=" &
											 + trim(string(kst_tab_barcode.fila_2)) + ") "
	//			k_barcode_esito_txt = k_barcode_esito_txt + "Impostati Cicli diversi tra SL-PT (F2=" &
			end if
			if kst_tab_sl_pt.fila_2p <> kst_tab_barcode.fila_2p then
				kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
				kst_tab_barcode.note_lav_fin += "Impostati Cicli permutati diversi tra PT (F2p="  & 
											 + trim(string(kst_tab_sl_pt.fila_2p)) + ") " &
											 + "e Pianificazione Lav. (F2p=" &
											 + trim(string(kst_tab_barcode.fila_2p)) + ") "
	//			k_barcode_esito_txt = k_barcode_esito_txt + "Impostati Cicli permutati diversi tra SL-PT (F2p=" &
			end if
		end if
	
	//--- Se Barcode senza cicli pianificati li prendo dal sl-pt
		if kst_tab_barcode.fila_1 = 0 and kst_tab_barcode.fila_2 = 0 &
			and kst_tab_barcode.fila_1p = 0 and kst_tab_barcode.fila_2p = 0 then
			kst_tab_barcode.note_lav_fin += "Cicli letti dal PT - " 
	//		k_barcode_esito_txt = k_barcode_esito_txt + "Cicli letti dal SL-PT - " 
			kst_tab_barcode.fila_1 = kst_tab_sl_pt.fila_1  
			kst_tab_barcode.fila_2 = kst_tab_sl_pt.fila_2 
			kst_tab_barcode.fila_1p = kst_tab_sl_pt.fila_1p  
			kst_tab_barcode.fila_2p = kst_tab_sl_pt.fila_2p 
		end if
	end if
						
	//--- Finalmente!! controllo se Cicli trattati uguali a quelli Pianificati	nel barcode	
	if kst_tab_barcode.fila_1 = kst_tab_barcode.lav_fila_1 &
		and kst_tab_barcode.fila_2 = kst_tab_barcode.lav_fila_2  &
		and kst_tab_barcode.fila_1p = kst_tab_barcode.lav_fila_1p &
		and kst_tab_barcode.fila_2p = kst_tab_barcode.lav_fila_2p  &
		then
		
		kst_tab_barcode.note_lav_fin +="Verifica Cicli Corretta. - "
	//	k_barcode_esito_txt = k_barcode_esito_txt + "Verifica Cicli Corretta. - "
							
	else
		if k_barcode_esito = kkg_esito.ok then
			kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
	//		k_barcode_esito = "2"
		end if
		
		kst_tab_barcode.note_lav_fin = "Cicli Pianificati: F1=" &
									  + string(kst_tab_barcode.fila_1) &
									  + "+" + string(kst_tab_barcode.fila_1p) &
									  + ",  F2=" + string(kst_tab_barcode.fila_2) &
									  + "+" + string(kst_tab_barcode.fila_2p) &
									  + " - " + trim(kst_tab_barcode.note_lav_fin)
	end if
				
	//--- controllo se PL presente			
	if isnull(kst_tab_barcode.pl_barcode) or kst_tab_barcode.pl_barcode = 0 then
		kst_tab_barcode.pl_barcode = 0
		kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
		kst_tab_barcode.note_lav_fin = "Barcode senza Piano di Lavoro"  &
									 + " - " + trim(kst_tab_barcode.note_lav_fin)
	end if	
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	if kst_tab_barcode.st_tab_g_0.esegui_commit = "N" then
	else
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_sl_pt) then destroy kuf1_sl_pt

end try
end subroutine

public subroutine togli_pl_barcode_non_chiuso (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Toglie dal BARCODE i dati di P.L. 
//=== 
//=== Input: Passare il BARCODE 
//===
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

select distinct data_lav_ini, data_lav_fin, data_lav_ok 
	into  :kst_tab_barcode.data_lav_ini
		  ,:kst_tab_barcode.data_lav_fin
		  ,:kst_tab_barcode.data_lav_ok
	from barcode
	where barcode = :kst_tab_barcode.barcode
	using sqlca;

if sqlca.sqlcode <> 0 then

	kguo_exception.set_tipo (kguo_exception.KK_st_uo_exception_tipo_db_ko)
	kst_esito.nome_oggetto = this.classname()
	kst_esito.esito = kkg_esito.db_ko
	kst_esito.sqlcode = sqlca.sqlcode

	if sqlca.sqlcode = 100 then
		kst_esito.sqlerrtext = "Barcode " + trim(kst_tab_barcode.barcode) + " non Trovato. Operazione non eseguita.  ~n~r"  + trim(sqlca.sqlerrtext)
	else
		kst_esito.sqlerrtext = "Errore durante la Ricerca x la rimozione del Barcode " + trim(kst_tab_barcode.barcode) + " dal P.L.  ~n~r"  + trim(sqlca.sqlerrtext)
	end if
	
	kguo_exception.set_esito (kst_esito )
	throw kguo_exception
	
else
	
	choose case true
	
		case &
			  kst_tab_barcode.data_lav_ok > date(0) 
			
			kGuo_exception.set_tipo (kGuo_exception.KK_st_uo_exception_tipo_dati_anomali)
			kGuo_exception.setmessage ( "Informazione: lotto del BARCODE "+ trim(kst_tab_barcode.barcode) +" risulta già Convalidato il " + string(kst_tab_barcode.data_lav_ok, "dd/mm/yyyy")  )
			kGuo_exception.messaggio_utente( )
//			throw kuo_exception
									
		case  &
			  kst_tab_barcode.data_lav_fin > date(0) 
			  
			kguo_exception.set_tipo (kguo_exception.KK_st_uo_exception_tipo_dati_anomali)
			kguo_exception.setmessage ( "BARCODE "+ trim(kst_tab_barcode.barcode) +" già trattato, lavorazione conclusa il " + string(kst_tab_barcode.data_lav_fin, "dd/mm/yyyy")  )
			throw kguo_exception
			
	end choose
	
	
	kst_tab_barcode.data_lav_ini = date(0)
	update barcode 
		set 
			pl_barcode = 0, 
			data_lav_ini = :kst_tab_barcode.data_lav_ini
	
		where barcode = :kst_tab_barcode.barcode
		using kguo_sqlca_db_magazzino;
				
	if kguo_sqlca_db_magazzino.sqlcode >= 0 then
		kguo_sqlca_db_magazzino.db_commit( )
	else
		kguo_sqlca_db_magazzino.db_rollback( )
		kguo_exception.set_tipo (kguo_exception.KK_st_uo_exception_tipo_db_ko)
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante rimozione del Barcode " + trim(kst_tab_barcode.barcode) + " dal P.L.  ~n~r"  + trim(sqlca.sqlerrtext)
		kguo_exception.set_esito (kst_esito )
		throw kguo_exception
	end if
	
end if

end subroutine

public function boolean if_barcode_trattato (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Controlla se Barcode gia' con fine Lavorazione
//=== 
//=== Ritorna: TRUE gia' trattato
//===              FALSE non ha finito il trattamento
//===                                   
//====================================================================
boolean k_return = false
long k_ctr
date k_data

	
	kguo_exception.inizializza(this.classname())

	if trim(kst_tab_barcode.barcode) > " " then

		kst_tab_barcode.barcode = trim(kst_tab_barcode.barcode)

		k_data = kkg.data_no
		select 1
				into :k_ctr
				from barcode 
				where barcode.barcode = :kst_tab_barcode.barcode
						and data_lav_fin > :k_data
				using kguo_sqlca_db_magazzino;
						
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Lettura Barcode " + trim(kst_tab_barcode.barcode))	
			throw kguo_exception
		else													  
			if k_ctr > 0 then
				k_return = true
			else
				k_return = false
			end if
		end if
	end if

return k_return

end function

public function boolean if_barcode_in_pl_chiuso (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Controlla se Barcode gia' in Piano di Lavorazione Chiuso 
//=== 
//=== Ritorna: TRUE gia' in PL chiuso
//===              FALSE non in PL chiuso
//===                                   
//====================================================================
boolean k_return = false
long k_ctr
uo_exception kuo_exception
st_esito kst_esito 


	
	
	kst_esito = kguo_exception.inizializza(this.classname())

	if not isnull(kst_tab_barcode.barcode) and LenA(trim(kst_tab_barcode.barcode)) > 0 then

		select count(*)
				into :k_ctr
				from barcode inner join pl_barcode on barcode.pl_barcode = pl_barcode.codice 
				where barcode.barcode = :kst_tab_barcode.barcode
						and pl_barcode.data_chiuso > '01.01.1990' 
				using sqlca;
						
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.sqlerrtext = "Errore durante lettura Barcode " + trim(kst_tab_barcode.barcode) &
							+ " non trovato (Errore=" &
						  + string (sqlca.sqlcode, "#####") + " " + trim(sqlca.sqlerrtext) + ")"
			kuo_exception = create uo_exception
			kuo_exception.set_esito(kst_esito)
			throw kuo_exception
			
		else													  

			if k_ctr > 0 then
				k_return = true    // GIA' CHIUSO!!!!!!!!!!!!!!!!!
			end if
			
		end if
	else
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Manca il Barcode, parametro non passato al controllo "
		kuo_exception = create uo_exception
		kuo_exception.set_esito(kst_esito)
		throw kuo_exception
	end if

return k_return

end function

public function st_esito tb_aggiungi_figlio (st_tab_barcode kst_tab_barcode);/*
====================================================================
Aggiunge  un figlio al Barcode
 
 Input:  st_tab_barcode con campo Barcode il figlio e Barcode_Lav il Padre 
 Ritorna tab. ST_ESITO, come da standard
 
====================================================================
*/

st_esito kst_esito 
kuf_base kuf1_base
st_tab_barcode kst_tab_barcode_padre

 
try
	kst_esito = kguo_exception.inizializza(this.classname())

	if LenA(trim(kst_tab_barcode.barcode)) > 0 &
		and LenA(trim(kst_tab_barcode.barcode_lav)) > 0 then
	
		kst_tab_barcode_padre.barcode = trim(kst_tab_barcode.barcode_lav)
		get_barcode_dati_trattamento (kst_tab_barcode_padre)
		if isnull(kst_tab_barcode_padre.pl_barcode) then
			kst_tab_barcode_padre.pl_barcode = 0
		end if
	
		kst_tab_barcode.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_barcode.x_utente = kGuf_data_base.prendi_x_utente()

		kst_tab_barcode.groupage = ki_barcode_groupage_SI
				
		update barcode set 	 
						 groupage = :kst_tab_barcode.groupage,
						 barcode_lav = :kst_tab_barcode.barcode_lav,
						 pl_barcode = :kst_tab_barcode_padre.pl_barcode,
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where barcode = :kst_tab_barcode.barcode
					using kguo_sqlca_db_magazzino;

	
//--- se OK allora mette il padre in Groupage
		if kguo_sqlca_db_magazzino.sqlcode >= 0 then
			update barcode set 	 
						 groupage = :kst_tab_barcode.groupage,
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where barcode = :kst_tab_barcode_padre.barcode
					using kguo_sqlca_db_magazzino;
		end if			
			
		if kguo_sqlca_db_magazzino.sqlcode >= 0 then
			if kst_esito.st_tab_g_0.esegui_commit = "N" then
			else
				kst_esito = kguo_sqlca_db_magazzino.db_commit()
			end if
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito = kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in aggiunta Barcode padre '" + kst_tab_barcode_padre.barcode &
										+ "' al Figlio '" + kst_tab_barcode.barcode + "' ")
				kguo_exception.scrivi_log( )						
				if kst_esito.st_tab_g_0.esegui_commit = "N" then
				else
					kguo_sqlca_db_magazzino.db_rollback()
				end if
			end if
		end if

	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

end try

return kst_esito


end function

public function long get_conta_figli (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Conta il numero figli x Barcode richiesto
//=== 
//=== Input: st_tab_barcode.barcode
//=== Output: long con il contatore
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
long k_return=0
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT count(*) into :k_return
		 FROM barcode
		WHERE (barcode_lav = :kst_tab_barcode.barcode) 
		using sqlca;


	if sqlca.sqlcode >= 0 then
		if sqlca.sqlcode > 0 then
			k_return = 0
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Barcode: " + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if


	if isnull(k_return) then k_return = 0

return k_return

end function

public function st_esito tb_togli_figli_tutti (st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Toglie  il Barcode Padre da tutti i Figli ad esso associato
//=== 
//=== Input:  st_tab_barcode con campo Barcode Padre
//===
//=== Ritorna tab. ST_ESITO, come da standard
//=== 
//====================================================================

st_esito kst_esito 
kuf_base kuf1_base


	kst_esito = kguo_exception.inizializza(this.classname())
	kst_esito.st_tab_g_0 = kst_tab_barcode.st_tab_g_0 

	if trim(kst_tab_barcode.barcode) > " "  then
	
		kst_tab_barcode.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_barcode.x_utente = kGuf_data_base.prendi_x_utente()

		kst_tab_barcode.groupage = ki_barcode_groupage_NO
		kst_tab_barcode.barcode_lav = ""		
		kst_tab_barcode.pl_barcode = 0
		kst_tab_barcode.data_lav_ini = date(0)
				
		update barcode set 	 
						 groupage = :kst_tab_barcode.groupage,
						 barcode_lav = :kst_tab_barcode.barcode_lav,
						 pl_barcode = :kst_tab_barcode.pl_barcode,
						 data_lav_ini = :kst_tab_barcode.data_lav_ini, 
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where barcode_lav = :kst_tab_barcode.barcode
					using sqlca;

	
		if sqlca.sqlcode >= 0 then
			if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
				kst_esito = kGuf_data_base.db_commit_1()
			end if
		else
			if sqlca.sqlcode <> 0 then
				kst_esito.esito = "2"
				kst_esito.sqlcode = SQLCA.sqlcode
				kst_esito.sqlerrtext = "tab.Barcode: " + trim(SQLCA.SQLErrText)
				if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
					kst_esito = kGuf_data_base.db_rollback_1()
				end if
			end if
		end if

	end if

return kst_esito

end function

public function boolean get_padre (ref st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Torna il Padre di un Barcode (se c'e' ovviamante!)
//=== 
//=== Input: st_tab_barcode.barcode
//=== Output: st_tab_barcode.barcode_lav
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
boolean k_return=false
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT barcode_lav into :kst_tab_barcode.barcode_lav
		 FROM barcode
		WHERE (barcode = :kst_tab_barcode.barcode) 
		using sqlca;


	if sqlca.sqlcode >= 0 then
		if trim(kst_tab_barcode.barcode_lav) > " " then
			k_return = true
		end if
	else
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura barcode padre dal figlio '" + kst_tab_barcode.barcode + "' in tab Barcode: " + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
	end if


return k_return

end function

public function st_esito tb_set_padre (st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Imposta il flag di Groupage sul Barcode 'PADRE'
//=== 
//=== Input:  st_tab_barcode con campo Barcode Padre 
//===
//=== Ritorna tab. ST_ESITO, come da standard
//=== 
//====================================================================

st_esito kst_esito 
kuf_base kuf1_base


	kst_esito = kguo_exception.inizializza(this.classname())
	kst_esito.st_tab_g_0 = kst_tab_barcode.st_tab_g_0 

	if trim(kst_tab_barcode.barcode) > " "	then
	
		kst_tab_barcode.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_barcode.x_utente = kGuf_data_base.prendi_x_utente()

		kst_tab_barcode.groupage = ki_barcode_groupage_SI
				
		update barcode set 	 
						 groupage = :kst_tab_barcode.groupage,
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where barcode = :kst_tab_barcode.barcode
					using sqlca;

	
		if sqlca.sqlcode >= 0 then
			if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
				kst_esito = kGuf_data_base.db_commit_1()
			end if
		else
			if sqlca.sqlcode <> 0 then
				kst_esito.esito = "2"
				kst_esito.sqlcode = SQLCA.sqlcode
				kst_esito.sqlerrtext = "tab.Barcode: " + trim(SQLCA.SQLErrText)
				if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
					kst_esito = kGuf_data_base.db_rollback_1()
				end if
			end if
		end if

	end if



return kst_esito


end function

public function st_esito tb_togli_figlio_al_padre (st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Toglie al PADRE il legame con il Figlio (ovvero se non + figli allora resetta il flag groupage)  
//=== 
//=== Input:  st_tab_barcode con campo Barcode Padre
//===
//=== Ritorna tab. ST_ESITO, come da standard
//=== 
//====================================================================
long k_ctr
st_esito kst_esito 
kuf_base kuf1_base


	kst_esito = kguo_exception.inizializza(this.classname())
	kst_esito.st_tab_g_0 = kst_tab_barcode.st_tab_g_0 

	if trim(kst_tab_barcode.barcode) > " " then

//--- conta i fligli rimasti	
		try
			k_ctr = get_conta_figli(kst_tab_barcode)


//--- se padre senza figli allora....	
			if k_ctr = 0 then
				
				kst_tab_barcode.x_datins = kGuf_data_base.prendi_x_datins()
				kst_tab_barcode.x_utente = kGuf_data_base.prendi_x_utente()
		
				kst_tab_barcode.groupage = ki_barcode_groupage_NO
						
				update barcode set 	 
								 groupage = :kst_tab_barcode.groupage,
								 x_datins = :kst_tab_barcode.x_datins,
								 x_utente = :kst_tab_barcode.x_utente
							where barcode = :kst_tab_barcode.barcode
							using sqlca;
		
			
				if sqlca.sqlcode >= 0 then
					if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
						kst_esito = kGuf_data_base.db_commit_1()
					end if
				else
					if sqlca.sqlcode <> 0 then
						kst_esito.esito = "2"
						kst_esito.sqlcode = SQLCA.sqlcode
						kst_esito.sqlerrtext = "tab.Barcode: " + trim(SQLCA.SQLErrText)
						if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
							kst_esito = kGuf_data_base.db_rollback_1()
						end if
					end if
					
				end if
			end if
				
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
		end try
			
	end if





return kst_esito


end function

public function long get_conta_barcode_x_id_armo_fine_lav (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Conta il numero dei Barcode  FINE TRATTAMENTO  per codice PL e il ID_ARMO
//=== 
//=== Input: st_tab_barcode.id_armo e pl_barcode
//=== Output: long con il contatore
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
//date k_data_da
long k_return
st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()



	SELECT count(*) into :k_return
		 FROM barcode
		WHERE (id_armo = :kst_tab_barcode.id_armo and pl_barcode = :kst_tab_barcode.pl_barcode
		            and data_lav_fin > '01.01.2000'  )
		using sqlca;


	if sqlca.sqlcode >= 0 then
		if sqlca.sqlcode > 0 then
			k_return = 0
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Barcode: " + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if
	
	if isnull(k_return) then
		k_return = 0
	end if



return k_return

end function

public function long get_conta_barcode_groupage_x_id_armo (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Conta il numero dei Barcode  IN GROUPAGE COME FIGLI CHE SONO STATI MESSI IN PL 
//=== per codice PL e il ID_ARMO
//=== 
//=== Input: st_tab_barcode.id_armo e pl_barcode
//=== Output: long con il contatore
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
long k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT count(*) into :k_return
		 FROM barcode
		WHERE (id_armo = :kst_tab_barcode.id_armo and pl_barcode = :kst_tab_barcode.pl_barcode
		             and barcode_lav <> ' ' and barcode_lav is not null) 
		using sqlca;
//and data_lav_ini > date(0)		


	if sqlca.sqlcode >= 0 then
		if sqlca.sqlcode > 0 then
			k_return = 0
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Barcode: " + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if

	if isnull(k_return) then
		k_return = 0
	end if


return k_return

end function

public function date get_data_lav_ini_x_id_armo (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Estrae data di inizio lav piu' vecchia per id_armo  
//=== 
//=== Input: la struttura st_tab_barcode con data id_armo ed eventalmente pl_parcode
//=== Output: la struttura st_tab_barcode con la DATA_lav_ini valorizzata
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
string k_dataoggi_x
kuf_base kuf1_base
st_esito kst_esito
st_tab_barcode kst_tab_barcode1


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if kst_tab_barcode.pl_barcode > 0 then
		select distinct
					min(data_lav_ini)
			into
				 :kst_tab_barcode1.data_lav_ini
			from barcode
			where id_armo = :kst_tab_barcode.id_armo 
				and pl_barcode =  :kst_tab_barcode.pl_barcode 
				and data_lav_ini > '01.01.2000'
			using sqlca;
	else
		select distinct
					min(data_lav_ini)
			into
				 :kst_tab_barcode1.data_lav_ini
			from barcode
			where id_armo = :kst_tab_barcode.id_armo 
				and data_lav_ini > '01.01.2000'
			using sqlca;
	end if			

	if sqlca.sqlcode <> 0 then
		if sqlca.sqlcode > 0 then
			kst_tab_barcode1.data_lav_ini = date(0)
		else
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Lettura tab.Barcode: " + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
	end if

return kst_tab_barcode1.data_lav_ini


end function

public function date get_data_lav_fin_x_id_armo (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Estrae data di Fine lav piu' vecchia per id_armo  
//=== 
//=== Input: la struttura st_tab_barcode con data id_armo ed eventalmente pl_parcode
//=== Output: la struttura st_tab_barcode con la data_lav_fin valorizzata
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
string k_dataoggi_x
kuf_base kuf1_base
st_esito kst_esito
st_tab_barcode kst_tab_barcode1

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if kst_tab_barcode.pl_barcode > 0 then
		select distinct
					max(data_lav_fin)
			into
				 :kst_tab_barcode1.data_lav_fin
			from barcode
			where id_armo = :kst_tab_barcode.id_armo 
				and pl_barcode =  :kst_tab_barcode.pl_barcode 
			using sqlca;
	else
		select distinct
					max(data_lav_fin)
			into
				 :kst_tab_barcode1.data_lav_fin
			from barcode
			where id_armo = :kst_tab_barcode.id_armo 
			using sqlca;
	end if			

	if sqlca.sqlcode <> 0 then
		if sqlca.sqlcode > 0 then
			kst_tab_barcode1.data_lav_fin = date(0)
		else
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura data fine lavorazione barcode per id riga lotto '" + string(kst_tab_barcode.id_armo) + "' " + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
	end if

return kst_tab_barcode1.data_lav_fin


end function

public function st_tab_barcode get_ultimo_barcode_importato () throws uo_exception;//
//====================================================================
//=== Estrae l'ultimo barcode importato dal PILOTA come Fine Lavorazione
//=== 
//=== Input: nulla
//=== Output: la struttura st_tab_barcode con la DATA_lav_fin e ORA_LAV_FIN valorizzati
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
st_tab_barcode kst_tab_barcode
string k_dataoggi_x
kuf_base kuf1_base
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	kuf1_base = create kuf_base
	k_dataoggi_x = MidA(kuf1_base.prendi_dato_base("dataoggi"),2)
	if isdate(k_dataoggi_x) then
		kst_tab_barcode.data_lav_fin = relativedate (date(k_dataoggi_x), -30)  //indietro di 1 mese
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Errore in Lettura Data-oggi:  " + k_dataoggi_x
		kst_esito.esito = kkg_esito.err_formale
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if

	select distinct data_lav_fin, max(ora_lav_fin)
		into
	          :kst_tab_barcode.data_lav_fin
			 ,:kst_tab_barcode.ora_lav_fin
			from barcode
			where data_lav_fin in (
				select distinct max(data_lav_fin)
						from barcode
						where data > :kst_tab_barcode.data_lav_fin )
		group by data_lav_fin
		using sqlca;


	if sqlca.sqlcode >= 0 then
		if sqlca.sqlcode > 0 then
			kst_tab_barcode.barcode = " "
			kst_tab_barcode.data_lav_ini = date(0)
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Barcode: " + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if


return kst_tab_barcode

end function

public function long get_nr_barcode_da_non_trattare (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Conta il numero dei Barcode  da NON TRATTARE  per  ID_MECA
//=== 
//=== Input: st_tab_barcode.ID_MECA 
//=== Output: long con il contatore
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
string k_causale
long k_return=0
st_esito kst_esito

	
	kst_esito = kguo_exception.inizializza(this.classname())

	k_causale = ki_causale_non_trattare

//--- conta il numero colli da-non-lavorare
	select count(*)
			into :k_return
			from barcode 
			where barcode.id_meca = :kst_tab_barcode.id_meca
					and (barcode.causale = :k_causale)
			using kguo_sqlca_db_magazzino;
			

	if kguo_sqlca_db_magazzino.sqlcode >= 0 then
		if kguo_sqlca_db_magazzino.sqlcode > 0 then
			k_return = 0
		end if
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante conteggio barcode da non trattare per lotto (" + &
		          string(kst_tab_barcode.id_meca ) + ") in tab. Barcode. ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if
	
	if isnull(k_return) then
		k_return = 0
	end if



return k_return

end function

public function long get_nr_barcode_trattati (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Conta il numero dei Barcode  FINE TRATTAMENTO  per  ID_ARMO
//=== 
//=== Input: st_tab_barcode.id_armo 
//=== Output: long con il contatore
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
//date k_data_da
long k_return=0
st_esito kst_esito



	kst_esito = kguo_exception.inizializza(this.classname())

	SELECT count(*) into :k_return
		 FROM barcode
		WHERE (id_armo = :kst_tab_barcode.id_armo 
		            and data_lav_fin > '01.01.1990' ) 
		using kguo_sqlca_db_magazzino;


	if kguo_sqlca_db_magazzino.sqlcode >= 0 then
		if kguo_sqlca_db_magazzino.sqlcode > 0 then
			k_return = 0
		end if
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante conteggio barcode trattati per riga lotto (" + &
		          string(kst_tab_barcode.id_armo ) + ") in tab. Barcode. ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if
	
	if isnull(k_return) then
		k_return = 0
	end if



return k_return

end function

public function st_esito get_padre_id_meca (ref st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Torna il ID LOTTO del Barcode 
//=== 
//=== Input: st_tab_barcode.barcode
//=== Output: st_tab_barcode.id_meca
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT id_meca into :kst_tab_barcode.id_meca
		 FROM barcode
		WHERE (barcode = :kst_tab_barcode.barcode) 
		using sqlca;


	if sqlca.sqlcode <> 0 then
		if sqlca.sqlcode = 100 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Barcode non Trovato durante lettura ID lotto: " + "~n~r" + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.not_fnd
		else
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Tab.Barcode durante lettura ID lotto: " + "~n~r" + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if

	end if


return kst_esito

end function

public function st_esito set_num_data_int (st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Aggiorna x ID LOTTO il numero/data
//=== 
//=== Input: st_tab_barcode.id_meca, num_int, data_int
//=== Ritorna: st_esito
//===             
//===
//====================================================================
//
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if kst_tab_barcode.ID_MECA > 0 then

	kst_tab_barcode.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_barcode.x_utente = kGuf_data_base.prendi_x_utente()

	update barcode
				set NUM_INT = :kst_tab_barcode.num_int
				, DATA_INT = :kst_tab_barcode.data_int
				,x_datins = :kst_tab_barcode.x_datins
				,x_utente = :kst_tab_barcode.x_utente
			where ID_MECA = :kst_tab_barcode.ID_MECA
			using kguo_sqlca_db_magazzino;


	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Barcode non Trovato durante lettura ID lotto: " + string(kst_tab_barcode.ID_MECA) + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.not_fnd
		else
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Tab.Barcode durante aggiornamento Lotto x ID: "+ string(kst_tab_barcode.ID_MECA) + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if

	end if

	if sqlca.sqlcode >= 0 then
		if kst_tab_barcode.st_tab_g_0.esegui_commit = "N" then
		else
			kst_esito = kguo_sqlca_db_magazzino.db_commit( )
		end if
	else
		if sqlca.sqlcode < 0 then
			if kst_tab_barcode.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		end if
	end if
				
end if

return kst_esito

end function

public function boolean if_essere_barcode_padre_con_giri_figlio (st_tab_barcode kst_tab_barcode_figlio, st_tab_barcode kst_tab_barcode_padre) throws uo_exception;//
//====================================================================
//=== Controlla se Barcode puo' diventare Padre
//=== 
//=== 
//=== Input:  kst_tab_barcode_padre    con  Barcode e File valorizzate (opzionale)
//=== 	       kst_tab_barcode_figlio      con  Barcode e File valorizzate (opzionale)
//=== 
//=== Ritorna: TRUE=ok x PADRE; FALSE=non abile
//=== Lancia EXCEPTION       
//===                                   
//====================================================================
boolean k_return=FALSE
long k_ctr
string k_causale_non_trattare
st_tab_barcode kst_tab_barcode
st_esito kst_esito 


try	
	kst_esito = kguo_exception.inizializza(this.classname())

	k_causale_non_trattare = ki_causale_non_trattare
	
//--- controlli generici sul PADRE!!!!	
	if if_essere_barcode_padre( kst_tab_barcode_padre ) then

//--- barcode filgio e padre uguali? 
		if kst_tab_barcode_figlio.barcode =  kst_tab_barcode_padre.barcode then
			kst_esito.esito = kkg_esito.err_logico
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.sqlerrtext = "Barcode " + trim(kst_tab_barcode_figlio.barcode) +" e' lo stesso del Padre. "
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	
		//--- Azzera i valori a NULL
		if isnull(kst_tab_barcode_padre.fila_1) then kst_tab_barcode_padre.fila_1 = 0
		if isnull(kst_tab_barcode_padre.fila_1p) then kst_tab_barcode_padre.fila_1p = 0
		if isnull(kst_tab_barcode_padre.fila_2) then kst_tab_barcode_padre.fila_2 = 0
		if isnull(kst_tab_barcode_padre.fila_2p) then kst_tab_barcode_padre.fila_2p = 0
		if isnull(kst_tab_barcode_figlio.fila_1) then kst_tab_barcode_figlio.fila_1 = 0
		if isnull(kst_tab_barcode_figlio.fila_1p) then kst_tab_barcode_figlio.fila_1p = 0
		if isnull(kst_tab_barcode_figlio.fila_2) then kst_tab_barcode_figlio.fila_2 = 0
		if isnull(kst_tab_barcode_figlio.fila_2p) then kst_tab_barcode_figlio.fila_2p = 0
	
		if (kst_tab_barcode_padre.fila_1 <> kst_tab_barcode_figlio.fila_1) &
				or (kst_tab_barcode_padre.fila_1p <> kst_tab_barcode_figlio.fila_1p) &
				or (kst_tab_barcode_padre.fila_2 <> kst_tab_barcode_figlio.fila_2)  &
				or (kst_tab_barcode_padre.fila_2p <> kst_tab_barcode_figlio.fila_2p) then
			kst_esito.esito = kkg_esito.err_logico
			kst_esito.sqlcode = 0
			kst_esito.sqlerrtext = "Giri del barcode figlio " + trim(kst_tab_barcode_figlio.barcode) + " diversi dal barcode padre "  + trim(kst_tab_barcode_padre.barcode)
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	
	//--- OK IL BARCODE PUO' DIVENTARE PADRE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!		
		k_return = true

	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try
			
			
return k_return

end function

public function boolean if_essere_barcode_padre (st_tab_barcode kst_tab_barcode_padre) throws uo_exception;//
//====================================================================
//=== Controlla se Barcode puo' diventare Padre
//=== 
//=== 
//=== Input:  kst_tab_barcode_padre.barcode 
//=== 
//=== Ritorna: TRUE=ok x PADRE; FALSE=non abile
//=== Lancia EXCEPTION       
//===                                   
//====================================================================
boolean k_return=FALSE
long k_ctr
//string k_causale_non_trattare
st_tab_barcode kst_tab_barcode
kuf_armo kuf1_armo
kuf_e1_asn kuf1_e1_asn
st_tab_meca kst_tab_meca
st_esito kst_esito 
	
	
try
	kst_esito = kguo_exception.inizializza(this.classname())

	//k_causale_non_trattare = ki_causale_non_trattare
	
	if isnull(kst_tab_barcode_padre.barcode) or Len(trim(kst_tab_barcode_padre.barcode)) = 0 then
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Barcode non indicato in verifica se puo' essere 'padre'. Operazione non eseguita."
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- barcode in piano di lav gia' chiuso?
	kst_tab_barcode.barcode = kst_tab_barcode_padre.barcode 
	if if_barcode_in_pl_chiuso(kst_tab_barcode) then
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "il Barcode " + trim(kst_tab_barcode.barcode) + " (Padre) già Pianificato, operazione interrotta"   + ". "
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- leggo il barcode PADRE			
	kst_tab_barcode.barcode = kst_tab_barcode_padre.barcode
	select barcode_lav
	     ,data_stampa
		  ,data_sosp
		  ,causale
		  ,id_meca
		  ,fila_1
		  ,fila_1p
		  ,fila_2
		  ,fila_2p
		into 
			:kst_tab_barcode.barcode_lav
			,:kst_tab_barcode.data_stampa
			,:kst_tab_barcode.data_sosp
			,:kst_tab_barcode.causale
			,:kst_tab_barcode.id_meca
			,:kst_tab_barcode.fila_1
			,:kst_tab_barcode.fila_1p
			,:kst_tab_barcode.fila_2
			,:kst_tab_barcode.fila_2p
		from barcode
		where barcode = :kst_tab_barcode.barcode
		using kguo_sqlca_db_magazzino;
	if kguo_sqlca_db_magazzino.sqlcode < 0 then	
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in verifica se barcode puo' essere 'padre' codice  " + trim(kst_tab_barcode_padre.barcode))	
		throw kguo_exception
	end if

//--- Lotto nello STATO E1 giusto?
	kuf1_e1_asn = create kuf_e1_asn
	kuf1_armo = create kuf_armo
	kst_tab_meca.id = kst_tab_barcode.id_meca
	if NOT kuf1_armo.if_lotto_associato(kst_tab_meca) then
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlerrtext = "Il Lotto del Barcode " + trim(kst_tab_barcode.barcode) + " (padre) è nello Stato E1 '" &
					+ trim(kst_tab_meca.e1srst) + "' invece deve essere a '" + kuf1_e1_asn.kki_status_ready_toschedule + "' (" &
					+ kuf1_e1_asn.u_get_stato_descr(kuf1_e1_asn.kki_status_ready_toschedule) + "). "
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
//--- se FILE barcode PADRE NON passate ci metto quelle lette da tabella 
	if (kst_tab_barcode_padre.fila_1 = 0 or isnull(kst_tab_barcode_padre.fila_1)) and (kst_tab_barcode_padre.fila_1p = 0 or isnull(kst_tab_barcode_padre.fila_1p)) &
			and (kst_tab_barcode_padre.fila_2 = 0 or isnull(kst_tab_barcode_padre.fila_2)) and (kst_tab_barcode_padre.fila_2p = 0 or isnull(kst_tab_barcode_padre.fila_2p)) then
		kst_tab_barcode_padre.fila_1 = kst_tab_barcode.fila_1
		kst_tab_barcode_padre.fila_1p = kst_tab_barcode.fila_1p
		kst_tab_barcode_padre.fila_2 = kst_tab_barcode.fila_2
		kst_tab_barcode_padre.fila_2p = kst_tab_barcode.fila_2p
	end if
					
	if trim(kst_tab_barcode.barcode_lav) > " " then
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Barcode " + trim(kst_tab_barcode.barcode) + " è già figlio del Barcode " + trim(kst_tab_barcode.barcode_lav) + " non può essere anche 'padre'"

		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kst_tab_barcode.data_stampa <= date(0) or isnull(kst_tab_barcode.data_stampa) then
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Barcode " + trim(kst_tab_barcode.barcode) + " risulta ancora da stampare. Operazione bloccata."  
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
	if kst_tab_barcode.data_sosp > date(0) then
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Barcode " + trim(kst_tab_barcode.barcode) + " nello stato di sospeso. Operazione bloccata." 
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kst_tab_barcode.causale = ki_causale_non_trattare then
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Barcode " + trim(kst_tab_barcode.barcode) + " nello stato da 'non trattare'.  Operazione bloccata." 
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if


//--- OK IL BARCODE PUO' DIVENTARE PADRE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!		
	k_return = true

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_e1_asn) then destroy kuf1_e1_asn
	
end try
			
			
return k_return

end function

public function st_esito tb_togli_da_groupage (st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Toglie il Barcode figlio o padre dal groupage
//=== 
//=== Input:  st_tab_barcode con campo Barcode da aggiornare
//===
//=== Ritorna tab. ST_ESITO, come da standard
//=== 
//====================================================================

st_esito kst_esito 
kuf_base kuf1_base


	kst_esito = kguo_exception.inizializza(this.classname())
	kst_esito.st_tab_g_0 = kst_tab_barcode.st_tab_g_0 

	if trim(kst_tab_barcode.barcode) > " " then
	
		kst_tab_barcode.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_barcode.x_utente = kGuf_data_base.prendi_x_utente()

		kst_tab_barcode.barcode_lav = ""		
		kst_tab_barcode.pl_barcode = 0
		kst_tab_barcode.data_lav_ini = date(0)
			
		try 	
//--- controlla se BARCODE è padre 			
			if if_barcode_padre_no_trattati(kst_tab_barcode) then
				kst_tab_barcode.groupage = ki_barcode_groupage_SI
			else
				kst_tab_barcode.groupage = ki_barcode_groupage_NO
			end if
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito( )
		end try
				
		if kst_esito.esito = kkg_esito.ok then		
			
			update barcode set 	 
							 groupage = :kst_tab_barcode.groupage,
							 barcode_lav = :kst_tab_barcode.barcode_lav,
							 pl_barcode = :kst_tab_barcode.pl_barcode,
							 data_lav_ini = :kst_tab_barcode.data_lav_ini, 
							 x_datins = :kst_tab_barcode.x_datins,
							 x_utente = :kst_tab_barcode.x_utente
						where barcode = :kst_tab_barcode.barcode
						using sqlca;
	
		
			if sqlca.sqlcode >= 0 then
				if kst_tab_barcode.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_barcode.st_tab_g_0.esegui_commit) then
					kst_esito = kGuf_data_base.db_commit_1()
				end if
			else
				if sqlca.sqlcode < 0 then
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = SQLCA.sqlcode
					kst_esito.sqlerrtext = "tab.Barcode: " + trim(SQLCA.SQLErrText)
					if kst_tab_barcode.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_barcode.st_tab_g_0.esegui_commit) then
						kst_esito = kGuf_data_base.db_rollback_1()
					end if
				end if
			end if
		end if

	end if





return kst_esito


end function

public function boolean if_barcode_padre_no_trattati (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Controlla se Barcode è PADRE tra i barcode non trattati 
//=== 
//=== Ritorna: TRUE è PADRE
//===              FALSE non è padre
//===                                   
//====================================================================
boolean k_return = false
long k_ctr=0
uo_exception kuo_exception
st_esito kst_esito 


	
	kst_esito = kguo_exception.inizializza(this.classname())

	if Len(trim(kst_tab_barcode.barcode)) > 0 then

		kst_tab_barcode.data_lav_ini = date(0)

		select distinct 1
				into :k_ctr
				from barcode 
				where barcode.barcode_lav = :kst_tab_barcode.barcode
						and (barcode.data_lav_ini is null or barcode.data_lav_ini = :kst_tab_barcode.data_lav_ini)
				using sqlca;
						
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.sqlerrtext = "Errore durante lettura Barcode " + trim(kst_tab_barcode.barcode) &
							+ " non trovato (Errore=" &
						  + string (sqlca.sqlcode, "#####") + " " + trim(sqlca.sqlerrtext) + ")"
			kuo_exception = create uo_exception
			kuo_exception.set_esito(kst_esito)
			throw kuo_exception
			
		else													  

			if k_ctr > 0 then
				k_return = true
			else
				k_return = false
			end if
			
		end if
	end if

return k_return

end function

public function boolean if_barcode_padre (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Controlla se Barcode è PADRE 
//=== 
//=== Ritorna: TRUE è PADRE
//===              FALSE non è padre
//===                                   
//====================================================================
boolean k_return = false
long k_ctr=0
st_esito kst_esito 


	kst_esito = kguo_exception.inizializza(this.classname())

	if Len(trim(kst_tab_barcode.barcode)) > 0 then

		select distinct 1
				into :k_ctr
				from barcode 
				where barcode.barcode_lav = :kst_tab_barcode.barcode
				using sqlca;
						
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.sqlerrtext = "Errore durante verifica se 'padre' del Barcode " + trim(kst_tab_barcode.barcode) &
							+ " (Errore=" &
						  + string (sqlca.sqlcode, "#####") + " " + trim(sqlca.sqlerrtext) + ")"
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else													  

			if k_ctr > 0 then
				k_return = true
			else
				k_return = false
			end if
			
		end if
	end if

return k_return

end function

public function date get_data_lav_ini (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//--------------------------------------------------------------------
//--- Estrae data di Inizio lav piu' vecchia per id_meca  
//--- 
//--- Inp: st_tab_barcode con data id_meca ed eventalmente pl_parcode
//--- Out: st_tab_barcode.data_lav_ini 
//---             
//---             
//--- Lancia un ECCEZIONE se Errore grave
//-------------------------------------------------------------------
//
string k_dataoggi_x
kuf_base kuf1_base
st_esito kst_esito
st_tab_barcode kst_tab_barcode1

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if kst_tab_barcode.pl_barcode > 0 then
		select distinct
					min(data_lav_ini)
			into
				 :kst_tab_barcode1.data_lav_ini
			from barcode
			where id_meca = :kst_tab_barcode.id_meca 
				and pl_barcode =  :kst_tab_barcode.pl_barcode 
				and data_lav_ini > '01.01.2000'
			using kguo_sqlca_db_magazzino;
	else
		select distinct
					min(data_lav_ini)
			into
				 :kst_tab_barcode1.data_lav_ini
			from barcode
			where id_meca = :kst_tab_barcode.id_meca 
				and data_lav_ini > '01.01.2000'
			using kguo_sqlca_db_magazzino;
	end if			

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode > 0 then
			kst_tab_barcode1.data_lav_ini = date(0)
		else
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Lettura tab.Barcode: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza()
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
	end if

return kst_tab_barcode1.data_lav_ini


end function

public function long get_nr_barcode (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Conta il numero dei Barcode  per  ID_MECA
//=== 
//=== Input: st_tab_barcode.id_meca 
//=== Output: long con il numero barcode
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
//date k_data_da
long k_return=0
st_esito kst_esito


kst_esito = kguo_exception.inizializza(this.classname())

if kst_tab_barcode.id_meca > 0 then

	SELECT count(*) into :k_return
		 FROM barcode
		WHERE id_meca = :kst_tab_barcode.id_meca 
		using kguo_sqlca_db_magazzino;


	if kguo_sqlca_db_magazzino.sqlcode >= 0 then
		if kguo_sqlca_db_magazzino.sqlcode > 0 then
			k_return = 0
		end if
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in Conteggio numero Barcode del Lotto. Errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if
	
	if isnull(k_return) then
		k_return = 0
	end if

end if

return k_return

end function

public function boolean if_esiste (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Controllo se esiste gia' il Barcode 
//=== 
//=== Inp: barcode    --, id_meca (se omesso assume zero)
//=== Out: 
//=== Ritorna BOOLEAN : TRUE=ESISTE, FALSE=NON ESISTE;
//===   
//====================================================================
boolean k_return=false
st_esito kst_esito
int k_ctr


kst_esito.esito = KKG_ESITO.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if len(trim(kst_tab_barcode.barcode)) > 0 then
	
	if isnull(kst_tab_barcode.id_meca) then kst_tab_barcode.id_meca = 0
	
	select 1
		into :k_ctr
		from barcode 
		where barcode.barcode = :kst_tab_barcode.barcode 
		using sqlca;
		//and barcode.id_meca > :kst_tab_barcode.id_meca
		
	if sqlca.sqlcode = 0 then

		if k_ctr = 1 then
			k_return = true
		end if
		
	else
		if sqlca.sqlcode = 100 then
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore durante verifica esistenza Barcode Dosimetria (barcode): " + kst_tab_barcode.barcode  + " ~n~r " + sqlca.sqlerrtext
			kguo_exception.inizializza()
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
		end if
	end if
end if
	
	
return k_return


end function

public function st_esito set_pl_barcode (ref st_tab_barcode kst_tab_barcode, string k_tipo);//
//====================================================================
//=== Update rek Barcode con i dati del P.L.
//=== 
//=== Ritorna 1 char : 0=OK; 1=not found; 2=errore grave; 
//===           		: 3=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================
string k_return = "0 "
string k_barcode
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	k_barcode = trim(kst_tab_barcode.barcode)
	 
	if isnull(kst_tab_barcode.pl_barcode) or kst_tab_barcode.pl_barcode = 0 then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Errore interno. Manca il codice del Piano per aggiornare il Barcode " + k_barcode 
	end if
	if isnull(kst_tab_barcode.pl_barcode_progr) or kst_tab_barcode.pl_barcode_progr = 0 then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Errore interno. Manca il progressivo del Piano per aggiornare il Barcode " + k_barcode 
	end if

	if kst_esito.esito = kkg_esito.ok then
		
		kst_tab_barcode.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_barcode.x_utente = kGuf_data_base.prendi_x_utente()
	  
		update barcode set  
			 pl_barcode = :kst_tab_barcode.pl_barcode,
			 pl_barcode_progr = :kst_tab_barcode.pl_barcode_progr,
			 x_datins = :kst_tab_barcode.x_datins,
			 x_utente = :kst_tab_barcode.x_utente
		where barcode = :k_barcode
		using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				if kguo_sqlca_db_magazzino.sqlcode = 100 then
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.SQLErrText = "Errore in aggiornamento del numero del Piano di Lav. " + string(kst_tab_barcode.pl_barcode) + "/" + string(kst_tab_barcode.pl_barcode_progr) &
											+ " sul Barcode '" + trim(k_barcode) + "' non Trovato! " &
											+ kkg.acapo + "Errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
					kst_esito.esito = kkg_esito.not_fnd
				else
					kst_esito.esito = kkg_esito.db_wrn
				end if
			else
				kst_esito.SQLErrText = "Errore in aggiornamento del numero del Piano di Lav. " + string(kst_tab_barcode.pl_barcode) + "/" + string(kst_tab_barcode.pl_barcode_progr) &
											+ " sul Barcode '" + trim(k_barcode) + "' " &
											+ kkg.acapo + "Errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			end if
			if kst_tab_barcode.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		else
			kst_esito.esito = kkg_esito.ok
			if kst_tab_barcode.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		end if
		
	end if

return kst_esito

end function

public function long get_nr_barcode_in_lav_x_pl (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Conta il numero dei Barcode  che hanno almeno iniziato il TRATTAMENTO  per  PL_BARCODE
//=== 
//=== Input: st_tab_barcode.pl_barcode 
//=== Output: long con il contatore
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
//date k_data_da
long k_return
st_esito kst_esito



	kst_esito = kguo_exception.inizializza(this.classname())

	kst_tab_barcode.data_lav_ini = KKG.DATA_ZERO

	SELECT count(*) into :k_return
		 FROM barcode
		WHERE (pl_barcode = :kst_tab_barcode.pl_barcode 
		            and data_lav_ini > :kst_tab_barcode.data_lav_ini ) 
		using sqlca;


	if sqlca.sqlcode >= 0 then
		if sqlca.sqlcode > 0 then
			k_return = 0
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in conteggio barcode che hanno iniziato la lavorazione (Barcode) x P.L.: " + string(kst_tab_barcode.pl_barcode) + ". Errore: " + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if
	
	if isnull(k_return) then
		k_return = 0
	end if



return k_return

end function

public function long get_conta_barcode_x_id_armo_pl_barcode (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;/*
 Conta il numero dei Barcode  CHE SONO STATI MESSI IN PL x codice PL e il ID_ARMO
	 Inp: st_tab_barcode.id_armo e pl_barcode
	 Out: long con il contatore
*/
long k_return


	kguo_exception.inizializza(this.classname())

	SELECT count(*) into :k_return
		 FROM barcode
		WHERE (id_armo = :kst_tab_barcode.id_armo and pl_barcode = :kst_tab_barcode.pl_barcode)
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
				"Errore in Conteggio barcode in trattamento sul Piano di Lavorazione n. " + string(kst_tab_barcode.pl_barcode) &
				  + " della riga Lotto n. " + string(kst_tab_barcode.id_armo))
		throw kguo_exception
	end if

	if k_return > 0 then
	else
		k_return = 0
	end if

return k_return

end function

public function long get_nr_barcode_da_non_trattare_x_id_armo (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Conta il numero dei Barcode  da NON TRATTARE  per  ID_ARMO
//=== 
//=== Input: st_tab_barcode.id_armo 
//=== Output: long con il contatore
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
string k_causale
long k_return=0
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	k_causale = ki_causale_non_trattare

//--- conta il numero colli da-non-lavorare
	select count(*)
			into :k_return
			from barcode 
			where barcode.id_armo = :kst_tab_barcode.id_armo
					and (barcode.causale = :k_causale)
			using kguo_sqlca_db_magazzino;
			

	if kguo_sqlca_db_magazzino.sqlcode >= 0 then
		if kguo_sqlca_db_magazzino.sqlcode > 0 then
			k_return = 0
		end if
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante conteggio barcode da non trattare per riga lotto (" + &
		          string(kst_tab_barcode.id_armo ) + ") in tab. Barcode. ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if
	
	if isnull(k_return) then
		k_return = 0
	end if



return k_return

end function

public function string get_barcode_lav (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Estrae barcode PADRE   
//=== 
//=== Input: codice st_tab_barcode.barcode
//=== Rit: barcode padre altrimenti ""
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
string k_return = ""
st_esito kst_esito
st_tab_barcode kst_tab_barcode1


	kst_esito = kguo_exception.inizializza(this.classname())

	if trim(kst_tab_barcode.barcode) > " " then
		select distinct
					barcode_lav
			into
				 :kst_tab_barcode1.barcode_lav
			from barcode
			where barcode = :kst_tab_barcode.barcode 
			using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode >= 0 then
			if trim(kst_tab_barcode1.barcode_lav) > " " then
				k_return = kst_tab_barcode1.barcode_lav
			end if
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore in lettura Barcode 'padre'. Barcode 'figlio': " + kst_tab_barcode.barcode + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito (kst_esito)
				throw kguo_exception
			end if
		end if
	end if

return k_return


end function

public function long get_nr_barcode_x_id_armo (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Conta il numero dei Barcode  per  ID_ARMO
//=== 
//=== Input: st_tab_barcode.id_meca 
//=== Output: long con il contatore
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
//date k_data_da
long k_return
st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()



	SELECT count(*) into :k_return
		 FROM barcode
		WHERE id_armo = :kst_tab_barcode.id_armo 
 
		using kguo_sqlca_db_magazzino;


	if kguo_sqlca_db_magazzino.sqlcode >= 0 then
		if kguo_sqlca_db_magazzino.sqlcode > 0 then
			k_return = 0
		end if
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Cconteggio barcode per riga lotto (barcode). Errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if
	
	if isnull(k_return) then
		k_return = 0
	end if



return k_return

end function

public subroutine set_flg_dosimetro_reset (st_tab_barcode ast_tab_barcode) throws uo_exception;//
//====================================================================
//=== Resetta il flag_dosimetro per il Barcode puntuale
//=== 
//=== Input:  st_tab_barcode.barcode 
//===
//=== lancia EXCEPTION
//=== 
//====================================================================
//
//st_tab_meca_dosim kst_tab_meca_dosim
//kuf_meca_dosim kuf1_meca_dosim
st_esito kst_esito 


try

	kst_esito = kguo_exception.inizializza(this.classname())

	kst_esito.st_tab_g_0 = ast_tab_barcode.st_tab_g_0 

	if trim(ast_tab_barcode.barcode) > " " then 
	
		ast_tab_barcode.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_barcode.x_utente = kGuf_data_base.prendi_x_utente()
		ast_tab_barcode.flg_dosimetro = ki_flg_dosimetro_no
		update barcode set 	 
					 FLG_DOSIMETRO = :ast_tab_barcode.flg_dosimetro
					 ,x_datins = :ast_tab_barcode.x_datins
					 ,x_utente = :ast_tab_barcode.x_utente
		   where barcode = :ast_tab_barcode.barcode
		   using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Reset dell'indicatore Dosimetro sul Barcode " + trim(ast_tab_barcode.barcode) + " in errore.")
			if ast_tab_barcode.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_magazzino.db_rollback()
			end if
			throw kguo_exception
		end if
		
		if ast_tab_barcode.st_tab_g_0.esegui_commit = "N" then
		else
			kst_esito = kguo_sqlca_db_magazzino.db_commit()
		end if
		
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Reset indicatore dosimetro Barcode non eseguito, codice non indicato"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	//kst_esito = kuo_exception.get_st_esito()
	kuo_exception.scrivi_log()
	
finally					
//	if isvalid(kuf1_meca_dosim) then destroy kuf1_meca_dosim

end try




end subroutine

public function long get_nr_barcode_stampati (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Conta il numero dei Barcode STAMPATI per  ID_MECA
//=== 
//=== Input: st_tab_barcode.id_meca 
//=== Output: long con il numero barcode
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
//date k_data_da
long k_return
st_esito kst_esito
date k_datazero


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	k_datazero = kkg.data_no
	SELECT count(*) into :k_return
		 FROM barcode
		WHERE id_meca = :kst_tab_barcode.id_meca and data_stampa > :k_datazero
		using kguo_sqlca_db_magazzino;


	if kguo_sqlca_db_magazzino.sqlcode >= 0 then
		if kguo_sqlca_db_magazzino.sqlcode > 0 then
			k_return = 0
		end if
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Conta Barcode Stampati per Lotto. Errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if
	
	if isnull(k_return) then
		k_return = 0
	end if



return k_return

end function

private function st_esito tb_delete_barcode (ref st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Cancella il rek dalla tabella BARCODE
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================
st_tab_meca_dosim kst_tab_meca_dosim
kuf_meca_dosim kuf1_meca_dosim
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	kst_esito.st_tab_g_0 = kst_tab_barcode.st_tab_g_0 

	kst_tab_barcode.barcode = trim(kst_tab_barcode.barcode)
	
	if if_barcode_in_pl(kst_tab_barcode) then
		
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Barcode già Pianificato al Trattamento. Rimozione non consentita. "
		
	else
	
		delete from barcode
			where barcode = :kst_tab_barcode.barcode
			using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode >= 0 then
	
			// toglie i figli da questo barcode
			kst_esito = tb_togli_figli_tutti(kst_tab_barcode)  
			if kst_esito.esito = kkg_esito.db_ko  then
			else
				
				
				kuf1_meca_dosim = create kuf_meca_dosim
				// toglie i Dosimetri da questo barcode
				kst_tab_meca_dosim.barcode_lav = kst_tab_barcode.barcode 
				kst_tab_meca_dosim.st_tab_g_0.esegui_commit = kst_tab_barcode.st_tab_g_0.esegui_commit
				kuf1_meca_dosim.tb_delete_x_barcode_lav(kst_tab_meca_dosim)  

			end if

			if kst_esito.esito = kkg_esito.db_ko  then
				
				if kst_tab_barcode.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_barcode.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
			else
				kst_esito.esito = kkg_esito.ok  // torna OK!
				if kst_tab_barcode.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_barcode.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_commit( )
				end if
				
			end if
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlerrtext = "Errore durante cancellazione Barcode: " + trim( kguo_sqlca_db_magazzino.SQLErrText	) 
		end if
	end if


catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

finally					
	if isvalid(kuf1_meca_dosim) then destroy kuf1_meca_dosim
					

end try

return kst_esito
end function

public function st_esito tb_delete (ref st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Cancella il rek dalla tabella BARCODE
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================
boolean k_sicurezza
st_esito kst_esito


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kst_esito.st_tab_g_0 = kst_tab_barcode.st_tab_g_0 

	k_sicurezza = if_sicurezza(kkg_flag_modalita.cancellazione)

	kst_esito = tb_delete_barcode(kst_tab_barcode)  // rimozione barcode

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	
end try

return kst_esito
end function

public function boolean if_da_trattare_no_pl_barcode (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Controlla se Barcode è da trattare 
//=== (senza controllare il PL_BARCODE come ad esempio in 'MODIFICA PROGRAMMAZIONE', 
//===        altrimenti usa if_da_trattare)
//=== 
//=== Ritorna: TRUE da trattare 
//===          FALSE non è possibile trattarlo 
//===                                   
//====================================================================
boolean k_return = false
long k_ctr=0
st_esito kst_esito 

	
	kst_esito = kguo_exception.inizializza(this.classname())

	if kst_tab_barcode.barcode > " " then

		kst_tab_barcode.data_lav_ini = kkg.DATA_NO 
		kst_tab_barcode.causale = ki_causale_non_trattare

//--- se il barcode ha causale a T (non trattare) oppure ha iniziato il trattamento oppure NON è dentro 
//---        a un piano di lavorazione chiuso
		select 1
				into :k_ctr
				from barcode left outer join pl_barcode on
				      barcode.pl_barcode = pl_barcode.codice
				where barcode.barcode = :kst_tab_barcode.barcode
				      and (barcode.causale = :kst_tab_barcode.causale
				             or barcode.data_lav_ini > :kst_tab_barcode.data_lav_ini 
				             )
				using kguo_sqlca_db_magazzino;
						
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore durante verifica se Barcode Trattato: " + trim(kst_tab_barcode.barcode))
			throw kguo_exception
		else													  

			if k_ctr > 0 then
				k_return = false
			else
				k_return = true
			end if
		end if
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Controllo se Barcode da trattare non eseguito, manca il codice (if_da_trattare_no_pl_barcode) "
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

return k_return

end function

public function boolean if_dosimetro_gia_accoppiato (ref st_tab_barcode ast_tab_barcode) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------------------
//--- Controlla se il LOTTO ha qlc altro Barcode gia' accoppiato a un Dosimetro 
//--- 
//--- Inp.: st_tab_barcode id_meca, barcode (opzionale) 
//--- Out:  st_tab_barcode se TRUE torna un barcode accoppiato Trovato (attenzione e' diverso da quello in Input)
//--- Ritorna: TRUE Lotto gia' accoppiato a un barcode differente da quello passato
//---          FALSE non accoppiato ad altri barcode
//---                                   
//----------------------------------------------------------------------------------------------------------------------------
boolean k_return = false
long k_ctr
st_esito kst_esito  
st_tab_barcode kst_tab_barcode

	
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	if ast_tab_barcode.id_meca > 0 then

		kst_tab_barcode.flg_dosimetro = ki_flg_dosimetro_SI
		
		select max(barcode)
				into :ast_tab_barcode.barcode
				from barcode 
				where barcode.id_meca = :ast_tab_barcode.id_meca
						and barcode.barcode <> :ast_tab_barcode.barcode
						and barcode.flg_dosimetro = :kst_tab_barcode.flg_dosimetro
				using kguo_sqlca_db_magazzino;
						
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = "Errore in lettura max Barcode dal " + trim(ast_tab_barcode.barcode) &
							+ " (Errore=" &
						  + string (kguo_sqlca_db_magazzino.sqlcode, "#####") + " " + trim(kguo_sqlca_db_magazzino.sqlerrtext) + ")"
		 	kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else													  

			if trim(ast_tab_barcode.barcode) > " " then
				k_return = true
			else
				k_return = false
			end if
		end if
	end if

return k_return

end function

public function integer get_nr_barcode_trattati_x_id_meca (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Torna nr Barcode che hanno il fine Lavorazione
//=== 
//=== 
//=== input: st_tab_barcode.id_meca
//=== Ritorna: numero dei barcode
//===             zero = nessu barcode trattato
//===                                   
//====================================================================
int k_return = 0
int k_ctr
st_esito kst_esito 
	

	kst_esito = kguo_exception.inizializza(this.classname())

	if kst_tab_barcode.id_meca > 0 then

		kst_tab_barcode.data_lav_fin = kkg.data_zero
		select count(*)
				into :k_ctr
				from barcode 
				where barcode.id_meca = :kst_tab_barcode.id_meca
						and barcode.data_lav_fin > :kst_tab_barcode.data_lav_fin
				using kguo_sqlca_db_magazzino;
						
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = "1"
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = "Errore durante conteggio Barcode per Lotto (id = " + string(kst_tab_barcode.id_meca) &
							+ " Errore=" &
						  + string (kguo_sqlca_db_magazzino.sqlcode, "#####") + " " + trim(kguo_sqlca_db_magazzino.sqlerrtext) + ")"
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else													  

			if k_ctr > 0 then
				k_return = k_ctr
			end if
		end if
	end if

return k_return

end function

public function integer get_nr_barcode_da_trattare_x_id_meca (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Torna nr Barcode da trattare
//=== 
//=== 
//=== input: st_tab_barcode.id_meca
//=== Ritorna: numero dei barcode da Trattare
//===             zero = nessun barcode da trattare (o tutti trattati o nessuno da trattare)
//===                                   
//====================================================================
int k_return = 0
int k_ctr = 0
st_esito kst_esito 


	kst_esito = kguo_exception.inizializza(this.classname())

	if kst_tab_barcode.id_meca > 0 then

//--- conta barcode che non hanno la data di fine lavorazione e che sono da trattare
		kst_tab_barcode.causale = ki_causale_non_trattare
		kst_tab_barcode.data_lav_fin = kkg.data_zero
		select count(*)
				into :k_ctr
				from barcode 
				where barcode.id_meca = :kst_tab_barcode.id_meca
						and (barcode.data_lav_fin <= :kst_tab_barcode.data_lav_fin or barcode.data_lav_fin is null) 
						and barcode.causale <> :kst_tab_barcode.causale
				using kguo_sqlca_db_magazzino;
						
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = "Errore durante conteggio Barcode da Trattare per Lotto (id = " + string(kst_tab_barcode.id_meca) &
							+ " Errore=" &
						  + string (kguo_sqlca_db_magazzino.sqlcode, "#####") + " " + trim(kguo_sqlca_db_magazzino.sqlerrtext) + ")"
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else													  

			if k_ctr > 0 then
				k_return = k_ctr
			end if
		end if
	end if

return k_return

end function

public function integer get_nr_barcode_lav_ini (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//------------------------------------------------------------------
//--- Conteggia Barcode che hanno almeno iniziato la lavorazione
//--- 
//--- Inp: st_tab_barcode.id_meca
//--- Rit: numero di barcode che hanno la data_ini_lav valorizzata 
//---              
//--- lancia EXCEPTION                                   
//------------------------------------------------------------------
int k_return = 0
long k_ctr
st_esito kst_esito 

	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if kst_tab_barcode.id_meca > 0 then

		kst_tab_barcode.data_lav_ini = kkg.data_zero
//		select distinct 1
		select count(*)
				into :k_ctr
				from barcode 
				where barcode.id_meca = :kst_tab_barcode.id_meca
				      and barcode.data_lav_ini > :kst_tab_barcode.data_lav_ini
				using kguo_sqlca_db_magazzino;
						
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = "Errore in conteggio Barcode che hanno almeno iniziato il trattamento, per id lotto " + string(kst_tab_barcode.id_meca) &
							+ " non trovato (Errore=" &
						  + string (kguo_sqlca_db_magazzino.sqlcode, "#####") + " " + trim(kguo_sqlca_db_magazzino.sqlerrtext) + ")"
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else													  

			if k_ctr > 0 then
				k_return = k_ctr
			end if
		end if
	else
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Manca id lotto, conteggio barcode che hanno data inizio trattamento non effettuato"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

return k_return

end function

public function integer get_nr_barcode_no_lav_ini_x_id_meca (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//------------------------------------------------------------------
//--- Torna nr Barcode mettere in lavorazione per lotto
//--- 
//--- 
//--- input: st_tab_barcode.id_meca
//--- Ritorna: numero dei barcode non ancora messi in impianto
//---          zero = nessun barcode (o tutti trattati o nessuno da trattare)
//---                                   
//------------------------------------------------------------------
int k_return = 0
int k_ctr = 0
st_esito kst_esito 


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if kst_tab_barcode.id_meca > 0 then

//--- conta barcode che non hanno la data di inizio lavorazione e che sono da trattare
		kst_tab_barcode.causale = ki_causale_non_trattare
		kst_tab_barcode.data_lav_ini = kkg.data_zero
		select count(*)
				into :k_ctr
				from barcode 
				where barcode.id_meca = :kst_tab_barcode.id_meca
						and (barcode.data_lav_ini <= :kst_tab_barcode.data_lav_ini or barcode.data_lav_ini is null) 
						and barcode.causale <> :kst_tab_barcode.causale
				using kguo_sqlca_db_magazzino;
						
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = "Errore in conteggio Barcode da mettere in lavorazione per Lotto (id = " + string(kst_tab_barcode.id_meca) &
							+ " Errore=" &
						  + string (kguo_sqlca_db_magazzino.sqlcode, "#####") + " " + trim(kguo_sqlca_db_magazzino.sqlerrtext) + ")"
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else													  

			if k_ctr > 0 then
				k_return = k_ctr
			end if
		end if
	end if

return k_return

end function

public function st_tab_barcode get_data_lav_ini_fin (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//------------------------------------------------------------------------------
//--- Estrae data di Inizio e Fine lavorazione
//--- 
//--- Inp: st_tab_barcode con id_meca 
//--- Out: st_tab_barcode con data_lav_ini /_fin e ora_ini / _fin  valorizzati
//---             
//---             
//--- Lancia un ECCEZIONE se Errore grave
//------------------------------------------------------------------------------
//
string k_dataoggi_x
kuf_base kuf1_base
st_esito kst_esito
st_tab_barcode kst_tab_barcode_return


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	select  min(data_lav_ini)
			 ,max(data_lav_fin) 
		into
			 :kst_tab_barcode_return.data_lav_ini
			 ,:kst_tab_barcode_return.data_lav_fin
			from barcode
		where id_meca = :kst_tab_barcode.id_meca 
			and data_lav_ini > '01.01.2000'
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode = 0 and kst_tab_barcode_return.data_lav_ini > kkg.data_zero then
		select 
					min(ora_lav_ini)
			into
				 :kst_tab_barcode_return.ora_lav_ini
			from barcode
			where id_meca = :kst_tab_barcode.id_meca 
				and data_lav_ini = :kst_tab_barcode_return.data_lav_ini
			using kguo_sqlca_db_magazzino;
	else
		kst_tab_barcode_return.data_lav_ini = date(0)
		kst_tab_barcode_return.data_lav_fin = date(0)
	end if
	if kguo_sqlca_db_magazzino.sqlcode = 0 and kst_tab_barcode_return.data_lav_fin > kkg.data_zero then
		select 
					max(ora_lav_fin)
			into
				 :kst_tab_barcode_return.ora_lav_fin
			from barcode
			where id_meca = :kst_tab_barcode.id_meca 
				and data_lav_fin = :kst_tab_barcode_return.data_lav_fin
			using kguo_sqlca_db_magazzino;
	else
		kst_tab_barcode_return.data_lav_fin = date(0)
	end if

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura Inizio-Fine lavorazione su Barcode: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza()
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return kst_tab_barcode_return 


end function

public function long get_durata_lav (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//------------------------------------------------------------------------------
//--- Calcola in secondi la durata di Trattamento del Lotto di un singolo barcode
//--- 
//--- Inp: st_tab_barcode con id_meca 
//--- Out: durata in secondi 
//---             
//---             
//--- Lancia un ECCEZIONE se Errore grave
//------------------------------------------------------------------------------
//
long k_return = 0
long k_secondi_durata
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())

	k_secondi_durata = get_imptime_sec_x_id_meca(kst_tab_barcode)
	
	if k_secondi_durata > 0 then
			
		k_return = k_secondi_durata
			
	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kst_esito.SQLErrText = "Errore in calcolo durata lavorazione dell'intero Lotto.~n~r" + kst_esito.SQLErrText
	kguo_exception.inizializza()
	kguo_exception.set_esito (kst_esito)
	throw kguo_exception

end try

return k_secondi_durata


end function

public function integer get_conta_dosimetri (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Conta il numero DOSIMETRI presenti sul Lotto
//=== 
//=== Input: st_tab_barcode.id_meca
//=== Output: il numero dei dosimetri (flg_dosimetro)
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
int k_return=0
int k_ctr=0
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_barcode.flg_dosimetro = ki_flg_dosimetro_SI

	SELECT count(*) into :k_ctr
		from meca_dosim
		where barcode_lav in 
	  (select barcode
		 FROM barcode
		WHERE id_meca = :kst_tab_barcode.id_meca
		     and flg_dosimetro = :kst_tab_barcode.flg_dosimetro)
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if k_ctr > 0 then
			k_return = k_ctr
		end if
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in conteggio dosimetri in tab. barcode lotto id=" + string(kst_tab_barcode.id_meca) + ". Errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
	end if

return k_return

end function

public function boolean tb_add (st_tab_barcode ast_tab_barcode) throws uo_exception;//
//------------------------------------------------------------------
//--- Aggiunge Barcode
//--- 
//--- Input:  st_tab_barcode *
//--- Rit: TRUE=inserito, FALSE=non inserito già in archivio/non indicato
//--- lancia EXCEPTION
//--- 
//------------------------------------------------------------------
//
boolean k_return=false
st_esito kst_esito 

	kst_esito = kguo_exception.inizializza(this.classname())
	kst_esito.st_tab_g_0 = ast_tab_barcode.st_tab_g_0 

	if_sicurezza(kkg_flag_modalita.inserimento) 

	if trim(ast_tab_barcode.barcode) > " " then 

//--- se barcode già caricato no INSERT! 	
		if if_esiste(ast_tab_barcode) then
			
//			kst_esito.esito = kkg_esito.no_esecuzione
//			kst_esito.sqlcode = 0
//			kst_esito.sqlerrtext = "Barcode " + trim(ast_tab_barcode.barcode) + " già in archivio, inserimento non eseguito!" //~n~r
//			kguo_exception.inizializza()
//			kguo_exception.set_esito(kst_esito)
//			throw kguo_exception

		else
	
			if_isnull(ast_tab_barcode)
			
			ast_tab_barcode.x_datins = kGuf_data_base.prendi_x_datins()
			ast_tab_barcode.x_utente = kGuf_data_base.prendi_x_utente()
					
			insert into BARCODE
                               (barcode
                               ,data
                               ,BARCODE_lav
                               ,groupage
                               ,id_armo
                               ,tipo_cicli
                               ,fila_1
                               ,fila_2
                               ,fila_1p
                               ,fila_2p
                               ,pl_barcode
                               ,pl_barcode_progr
                               ,id_meca
                               ,num_int
                               ,data_int
                               ,FLG_DOSIMETRO
                               ,causale
                               ,x_datins
                               ,x_utente)
                           values
								(
                             :ast_tab_barcode.barcode
                             ,:ast_tab_barcode.data
                             ,:ast_tab_barcode.BARCODE_lav
                             ,:ast_tab_barcode.groupage
                             ,:ast_tab_barcode.id_armo
                             ,:ast_tab_barcode.tipo_cicli
                             ,:ast_tab_barcode.fila_1
                             ,:ast_tab_barcode.fila_2
                             ,:ast_tab_barcode.fila_1p
                             ,:ast_tab_barcode.fila_2p
                             ,:ast_tab_barcode.pl_barcode
                             ,:ast_tab_barcode.pl_barcode_progr
                             ,:ast_tab_barcode.id_meca
                             ,:ast_tab_barcode.num_int
                             ,:ast_tab_barcode.data_int
                             ,:ast_tab_barcode.FLG_DOSIMETRO
                             ,:ast_tab_barcode.causale
                             ,:ast_tab_barcode.x_datins
                             ,:ast_tab_barcode.x_utente
								)
					using kguo_sqlca_db_magazzino;


			if kguo_sqlca_db_magazzino.sqlcode >= 0 then
				if ast_tab_barcode.st_tab_g_0.esegui_commit = "N" then
				else
					kst_esito = kguo_sqlca_db_magazzino.db_commit()
				end if
				
				k_return = true
				
			else
				if kguo_sqlca_db_magazzino.sqlcode < 0 then
					kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Inserimento Barcode '" + string(ast_tab_barcode.barcode) + "' in errore.")
					if ast_tab_barcode.st_tab_g_0.esegui_commit = "N" then
					else
						kguo_sqlca_db_magazzino.db_rollback()
					end if
					throw kguo_exception
				end if
			end if
		end if

//	else
//		kst_esito.esito = kkg_esito.no_esecuzione
//		kst_esito.sqlcode = 0
//		kst_esito.sqlerrtext = "Inserimento Barcode non eseguito, codice non indicato"
//		kguo_exception.inizializza()
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
	end if

return k_return 




end function

public function long get_durata_lav_old (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//------------------------------------------------------------------------------
//--- Calcola in secondi la durata di Inizio e Fine lavorazione
//--- 
//--- Inp: st_tab_barcode con id_meca 
//--- Out: durata in secondi 
//---             
//---             
//--- Lancia un ECCEZIONE se Errore grave
//------------------------------------------------------------------------------
//
long k_return = 0
int k_giorniafter
long k_secondiafter_entrato, k_secondiafter_uscito, k_secondi_durata
st_esito kst_esito
st_tab_barcode kst1_tab_barcode


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst1_tab_barcode = get_data_lav_ini_fin(kst_tab_barcode)

	if not isnull(kst1_tab_barcode.ora_lav_ini) then

		if not isnull(kst1_tab_barcode.ora_lav_fin) then
			
			if kst1_tab_barcode.data_lav_ini = kst1_tab_barcode.data_lav_fin then  // se è entrato e uscito la giornata stessa allora contagia solo i secondi
				k_secondi_durata = SecondsAfter ( kst1_tab_barcode.ora_lav_ini, kst1_tab_barcode.ora_lav_fin )
			else // se è rimsto in lav per un giorno e più allora sommo ai giorni i secondi dell'ultimo giorno
				k_giorniafter = DaysAfter(kst1_tab_barcode.data_lav_ini, kst1_tab_barcode.data_lav_fin)
				k_secondiafter_entrato = SecondsAfter ( kst1_tab_barcode.ora_lav_ini, time(23,59,59) )
				k_secondiafter_uscito = SecondsAfter ( time(00,00,00), kst1_tab_barcode.ora_lav_fin )
				k_secondi_durata = k_secondiafter_entrato + k_secondiafter_uscito
				k_secondi_durata += k_giorniafter * 24 * 60 
			end if
			
			k_return = k_secondi_durata
			
		end if
	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kst_esito.SQLErrText += "Errore in calcolo durata lavorazione dell'intero Lotto"
	kguo_exception.inizializza()
	kguo_exception.set_esito (kst_esito)
	throw kguo_exception

end try

return k_secondi_durata


end function

public subroutine get_lav_fila_tot_x_id_meca (ref st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Estrae totale giri lav di fila 1 e fila 2 x Lotto
//=== 
//=== Input: id_meca
//=== Output: la struttura st_tab_barcode con lav_fila_* valorizzati
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
kuf_base kuf1_base
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_barcode.lav_fila_1 = 0
	kst_tab_barcode.lav_fila_2 = 0
	kst_tab_barcode.lav_fila_1p = 0
	kst_tab_barcode.lav_fila_2p = 0

	if kst_tab_barcode.id_meca > 0 then
		select sum(lav_fila_1)
		       ,sum(lav_fila_2)
		       ,sum(lav_fila_1p)
		       ,sum(lav_fila_2p)
			into
				 :kst_tab_barcode.lav_fila_1
				 ,:kst_tab_barcode.lav_fila_2
				 ,:kst_tab_barcode.lav_fila_1p
				 ,:kst_tab_barcode.lav_fila_2p
			from barcode
			where barcode.id_meca = :kst_tab_barcode.id_meca
			using kguo_sqlca_db_magazzino;
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Operazione di lettura totale Giri trattati per Lotto in tab. Barcode non eseguita, manca ID Lotto"
		kst_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if			

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettura totale Giri trattati per Lotto in tab. Barcode (ID=" + string(kst_tab_barcode.id_meca)+ ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
	end if

	if isnull(kst_tab_barcode.lav_fila_1) then kst_tab_barcode.lav_fila_1 = 0
	if isnull(kst_tab_barcode.lav_fila_2) then kst_tab_barcode.lav_fila_2 = 0
	if isnull(kst_tab_barcode.lav_fila_1p) then kst_tab_barcode.lav_fila_1p = 0
	if isnull(kst_tab_barcode.lav_fila_2p) then kst_tab_barcode.lav_fila_2p = 0


end subroutine

public subroutine get_fila_tot_x_id_meca (ref st_tab_barcode kst_tab_barcode) throws uo_exception;/*
 Estrae totale giri pianificati di fila 1 e fila 2 x Lotto
   Inp: st_barcode.id_meca
   Out: st_tab_barcode con fila_* valorizzati
*/
	kguo_exception.inizializza(this.classname())
	kst_tab_barcode.fila_1 = 0
	kst_tab_barcode.fila_2 = 0
	kst_tab_barcode.fila_1p = 0
	kst_tab_barcode.fila_2p = 0
	kst_tab_barcode.g3ngiri = 0

	if kst_tab_barcode.id_meca > 0 then
	else
		kguo_exception.kist_esito.SQLErrText = "Operazione di lettura totale Giri pianificati per Lotto in tab. Barcode non eseguita, manca ID Lotto"
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		throw kguo_exception
	end if
	
	select sum(fila_1)
		       ,sum(fila_2)
		       ,sum(fila_1p)
		       ,sum(fila_2p)
		       ,sum(g3ngiri)
			into
				 :kst_tab_barcode.fila_1
				 ,:kst_tab_barcode.fila_2
				 ,:kst_tab_barcode.fila_1p
				 ,:kst_tab_barcode.fila_2p
				 ,:kst_tab_barcode.g3ngiri
			from barcode
			where barcode.id_meca = :kst_tab_barcode.id_meca
			using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if isnull(kst_tab_barcode.fila_1) then kst_tab_barcode.fila_1 = 0
		if isnull(kst_tab_barcode.fila_2) then kst_tab_barcode.fila_2 = 0
		if isnull(kst_tab_barcode.fila_1p) then kst_tab_barcode.fila_1p = 0
		if isnull(kst_tab_barcode.fila_2p) then kst_tab_barcode.fila_2p = 0
		if isnull(kst_tab_barcode.g3ngiri) then kst_tab_barcode.g3ngiri = 0
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in lettura totale Giri pianificati per Lotto in tab. Barcode (ID Lotto " + string(kst_tab_barcode.id_meca)+ ") ")	
			throw kguo_exception
		end if
	end if

end subroutine

public function long get_barcode_da_id_meca (ref st_tab_barcode kst_tab_barcode[]) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Torna array dei BARCODE del ID-Riferimento indicato 
//---	inp: st_tab_wm_barcode[1].id_meca
//---	out: st_tab_wm_barcode[].barcode 
//---	rit: numero barcode trovato 0=nessuno trovato
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
long k_return
int k_rcn
long k_ind
st_esito kst_esito
datastore kds_barcode

try
	kds_barcode = create datastore

	kds_barcode.dataobject = "d_barcode_l_barcode_x_id_meca"
	k_rcn = kds_barcode.settransobject(sqlca)
	if k_rcn >= 0 then
		k_rcn = kds_barcode.retrieve(kst_tab_barcode[1].id_meca)
	end if
	if k_rcn < 0 then
		kst_esito.esito = kkg_esito.bug
		kst_esito.sqlcode = k_rcn
		kst_esito.SQLErrText = "Estrazione 'Barcode' del 'Riferimento' id= " + string(kst_tab_barcode[1].id_meca) + " fallito!  ~n~r "  
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
			
	if kds_barcode.rowcount( ) > 0 then
		
		for k_ind = 1 to  kds_barcode.rowcount( )
			
			kst_tab_barcode[k_ind].barcode = kds_barcode.getitemstring( k_ind, "barcode") 
			kst_tab_barcode[k_ind].lav_fila_1 = kds_barcode.getitemnumber( k_ind, "lav_fila_1")
			kst_tab_barcode[k_ind].lav_fila_1p = kds_barcode.getitemnumber( k_ind, "lav_fila_1p") 
			kst_tab_barcode[k_ind].lav_fila_2 = kds_barcode.getitemnumber( k_ind, "lav_fila_2")  
			kst_tab_barcode[k_ind].lav_fila_2p = kds_barcode.getitemnumber( k_ind, "lav_fila_2p")

			k_return ++
		end for
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	destroy kds_barcode
	
end try

return k_return


end function

public function boolean if_barcode_figlio (ref st_tab_barcode ast_tab_barcode) throws uo_exception;//
//---------------------------------------------------------------------
//--- Controlla se Barcode è figlio
//--- 
//--- Inp: st_tab_barcode.barcode
//--- Out: st_tab_barcode.barcode_lav (padre)
//--- Ritorna: TRUE è figlio
//---          FALSE non è figlio (non è associato a un PADRE)
//---                                   
//---------------------------------------------------------------------
boolean k_return = false
st_tab_barcode kst_tab_barcode
st_esito kst_esito 

	
	
	kst_esito = kguo_exception.inizializza(this.classname())

	kst_tab_barcode.barcode_lav = ""

	if trim(ast_tab_barcode.barcode) > " " then

//		ast_tab_barcode.groupage = ki_barcode_groupage_SI

		select barcode.barcode_lav
				into :kst_tab_barcode.barcode_lav
				from barcode 
				where barcode.barcode = :ast_tab_barcode.barcode
						and barcode.barcode_lav > ' '
				using kguo_sqlca_db_magazzino;

						//and barcode.barcode_lav is not null and barcode.barcode_lav <> ''
						
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = "1"
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = "Errore in verifica Barcode " + trim(ast_tab_barcode.barcode) &
							+ " è figlio (Errore=" &
						  + string (kguo_sqlca_db_magazzino.sqlcode, "#####") + " " + trim(kguo_sqlca_db_magazzino.sqlerrtext) + ")"
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else													  

			if trim(kst_tab_barcode.barcode_lav) > " " then
				ast_tab_barcode.barcode_lav = trim(kst_tab_barcode.barcode_lav)
				k_return = true
			end if
		end if
	end if

return k_return

end function

public function boolean if_da_trattare (st_tab_barcode ast_tab_barcode) throws uo_exception;//
//====================================================================
//=== Controlla se Barcode è da trattare 
//=== 
//=== Ritorna: TRUE da trattare 
//===          FALSE non è possibile trattarlo 
//===                                   
//====================================================================
boolean k_return = false
long k_ctr=0
st_esito kst_esito 
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_barcode kst_tab_barcode

	
	kst_esito = kguo_exception.inizializza(this.classname())

	if ast_tab_barcode.barcode > " " then

		if not if_barcode_exists(ast_tab_barcode) then
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.sqlerrtext = "Barcode non trovato durante il controllo se è da trattare. Operazione bloccata."
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		kst_tab_barcode.data_lav_ini = kkg.DATA_NO 
		kst_tab_barcode.causale = ki_causale_non_trattare
		kst_tab_pl_barcode.data_chiuso = kkg.DATA_NO 

//--- se il barcode ha causale a T (non trattare) oppure ha iniziato il trattamento oppure è dentro 
//---        a un piano di lavorazione chiuso
		select 1
				into :k_ctr 
				from barcode left outer join pl_barcode on
				      barcode.pl_barcode = pl_barcode.codice
				where barcode.barcode = :ast_tab_barcode.barcode
				      and (barcode.causale = :kst_tab_barcode.causale
				             or barcode.data_lav_ini > :kst_tab_barcode.data_lav_ini 
				             or (barcode.pl_barcode > 0 and pl_barcode.data_chiuso > :kst_tab_pl_barcode.data_chiuso)
				             )
				using kguo_sqlca_db_magazzino;
			
						
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = "Errore in verifica se Barcode da Trattare: " + trim(ast_tab_barcode.barcode) &
							+ " (Errore=" &
						  + string (kguo_sqlca_db_magazzino.sqlcode, "#####") + " " + trim(kguo_sqlca_db_magazzino.sqlerrtext) + ")"
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		end if													  

		if k_ctr > 0 then
			k_return = false
		else
			k_return = true
		end if
		
	else
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Controllo se Barcode e' da trattare ma Manca il codice, parametro non passato al controllo ('if_da_trattare')"
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

return k_return

end function

public function long get_pl_barcode (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Select il codice PL_BARCODE del Barcode richeisto
//=== 
//=== arg: st_tab_barcode.barcode
//=== rit.: st_tab_barcode.pl_barcode
//=== Ritorna:pl_barcode
//=== 
//====================================================================
//
long k_return 



try

	select 
			 pl_barcode
		into
			 :kst_tab_barcode.pl_barcode
		from barcode
		where barcode = :kst_tab_barcode.barcode
		using kguo_sqlca_db_magazzino;


	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.inizializza( )
		kguo_exception.kist_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kguo_exception.kist_esito.SQLErrText = "Errore in lettura codice PL da tab.Barcode: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.kist_esito.esito = kkg_esito.db_ko
		kguo_exception.kist_esito.nome_oggetto = this.classname()
		throw kguo_exception
	end if

	if isnull(kst_tab_barcode.pl_barcode) then kst_tab_barcode.pl_barcode = 0
	
	k_return = kst_tab_barcode.pl_barcode

catch (uo_exception  kuo_exception)
	throw kuo_exception
	
	
end try
	

return k_return
end function

public function integer set_flg_dosimetro_all (st_tab_barcode ast_tab_barcode) throws uo_exception;//
//====================================================================
//=== Imposta in automatico il flag_dosimetro sul Barcode x Lotto
//=== 
//=== Input:  st_tab_barcode.id_meca 
//=== out:
//=== ret:  nr dosimetri impostati 
//===
//=== lancia EXCEPTION
//=== 
//====================================================================
//
long k_righe_barcode
int k_ctr, k_nr_dosimetri
string K_barcode_update=""
st_esito kst_esito 
uo_ds_std_1 kds_1


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	kst_esito.st_tab_g_0 = ast_tab_barcode.st_tab_g_0 

//	if_sicurezza(kkg_flag_modalita.inserimento) 

	if ast_tab_barcode.id_meca > 0 then 
               
//--- 20/7/15 leggo i barcode del lotto x impostare il flag del dosimetro
		kds_1 = create uo_ds_std_1
		kds_1.dataobject = "ds_barcode_set_flg_dosimetro"
		kds_1.settransobject(kguo_sqlca_db_magazzino)
		k_righe_barcode = kds_1.retrieve(ast_tab_barcode.id_meca)

	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Impostazione indicatori Dosimetro sul Barcode per l'intero Lotto non eseguito, id Lotto non indicato"
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	if k_righe_barcode > 0 then

		k_nr_dosimetri = set_flg_dosimetro(ast_tab_barcode, kds_1)

		if k_nr_dosimetri > 0 then
	 
			k_ctr = kds_1.update( )			// AGGIORNA I FLAG!!!
			
			if k_ctr >= 0 then
				if ast_tab_barcode.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_barcode.st_tab_g_0.esegui_commit) then
					kst_esito = kguo_sqlca_db_magazzino.db_commit()
				end if
			else
				kst_esito = kds_1.kist_esito
				kst_esito.sqlerrtext = "Errore in aggiornamento indicatori presenza Dosimetro sui Barcode per Id Lotto: " + string(ast_tab_barcode.id_meca) + " " &
				                        + kkg.acapo + kst_esito.sqlerrtext
				if ast_tab_barcode.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_barcode.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback()
				end if
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
	 
		end if

	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Impostazione indicatori Dosimetri Barcode non necessario per Id Lotto: " + string(ast_tab_barcode.id_meca)
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception    // il problema non scatena un messaggio di errore poichè probabilmente NON è un errore
	end if

	
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kds_1) then destroy kds_1

end try

return k_nr_dosimetri


end function

public function integer set_flg_dosimetro_rigenera (st_tab_barcode ast_tab_barcode) throws uo_exception;//
//====================================================================
//=== Reimposta i flag_dosimetro sul Barcode x l'intero Lotto
//=== 
//=== Input:  st_tab_barcode.id_meca 
//=== out:
//=== ret:  nr dosimetri impostati 
//===
//=== lancia EXCEPTION
//=== 
//====================================================================
//
long k_righe_barcode
int k_ctr, k_nr_dosimetri
string K_barcode_update=""
st_esito kst_esito 
datastore kds_1


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	kst_esito.st_tab_g_0 = ast_tab_barcode.st_tab_g_0 

//	if_sicurezza(kkg_flag_modalita.inserimento) 

	if ast_tab_barcode.id_meca > 0 then 
               
		set_flg_dosimetro_reset_all(ast_tab_barcode)
		
		k_nr_dosimetri = set_flg_dosimetro_all(ast_tab_barcode)

	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Rigenerazione indicatori Dosimetro sui Barcode per l'intero Lotto non eseguito. Id Lotto non indicato."
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception    // il problema non scatena un messaggio di errore poichè probabilmente NON è un errore
	end if

	
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kds_1) then destroy kds_1

end try

return k_nr_dosimetri


end function

public subroutine set_flg_dosimetro_reset_all (st_tab_barcode ast_tab_barcode) throws uo_exception;//
//====================================================================
//=== Resetta i flag_dosimetro Barcode per l'intero Lotto
//=== 
//=== Input:  st_tab_barcode.id_meca 
//===
//=== lancia EXCEPTION
//=== 
//====================================================================
//
st_esito kst_esito 


try
	kst_esito = kguo_exception.inizializza(this.classname())

	if ast_tab_barcode.id_meca > 0 then 
	
		ast_tab_barcode.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_barcode.x_utente = kGuf_data_base.prendi_x_utente()
		ast_tab_barcode.flg_dosimetro = ki_flg_dosimetro_no
		update barcode set 	 
					 FLG_DOSIMETRO = :ast_tab_barcode.flg_dosimetro
					 ,x_datins = :ast_tab_barcode.x_datins
					 ,x_utente = :ast_tab_barcode.x_utente
		   where id_meca = :ast_tab_barcode.id_meca
		   using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in ripristinto indicatore Dosimetro sui Barcode per Id Lotto" + string(ast_tab_barcode.id_meca))
			if ast_tab_barcode.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_magazzino.db_rollback()
			end if
			throw kguo_exception
		end if

		if ast_tab_barcode.st_tab_g_0.esegui_commit = "N" then
		else
			kst_esito = kguo_sqlca_db_magazzino.db_commit()
		end if

	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Ripristinto indicatore Dosimetro sui Barcode non eseguito, Id Lotto non indicato"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	
finally					

end try




end subroutine

public subroutine u_db_crea_view_danontrattare (string a_view_name, long a_id_meca) throws uo_exception;//
//--- crea View
//
int k_ctr
string k_view, k_sql
st_esito kst_esito


	k_view =  kguf_data_base.u_get_nometab_xutente(a_view_name)
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca, id_armo, colli_daNonTrattare) AS   " &
	 + "  SELECT barcode.id_meca,   " &
	              + " barcode.id_armo,   " &
	              + " count(barcode)  " &
	 + "    FROM barcode  " &
	 + "   WHERE       " &
	 + "    barcode.id_meca >= "  + string(a_id_meca) + "  "     &
	 + "	and  barcode.causale =  '" + trim(ki_causale_non_trattare ) + "' " &
	 + "	   group by barcode.id_meca, barcode.id_armo  " 

	kst_esito = kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
		kguo_exception.inizializza(this.classname())
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if

end subroutine

private function long get_imptime_sec_x_id_meca (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Estrae il totale Lotto dei tempi impiegati in lav dei barcode
//=== 
//=== Input: id_meca
//=== Rit: imptime_second di un singolo barcode (modifica del 25-10-2017 MALAGUTI)
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
long k_return
kuf_base kuf1_base
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	if kst_tab_barcode.id_meca > 0 then
		select sum(imptime_second) / count(id_meca)
			into
				 :kst_tab_barcode.imptime_second
			from barcode
			where id_meca = :kst_tab_barcode.id_meca 
			    and imptime_second > 0
			using kguo_sqlca_db_magazzino;
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Non effettuato il calcolo totale Tempo Impiegato per il trattamento del Lotto su Barcode, manca ID Lotto"
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if			

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if isnull(kst_tab_barcode.imptime_second) then kst_tab_barcode.imptime_second = 0
		k_return = kst_tab_barcode.imptime_second 
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettura Tempo totale Impiegato per il trattamento del Lotto su Barcode (Id Lotto=" + string(kst_tab_barcode.id_meca)+ ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
	end if

return k_return


end function

private function long get_imptime_sec_x_id_meca_fila (st_tab_barcode kst_tab_barcode, integer k_nfila) throws uo_exception;//
//====================================================================
//=== Estrae il totale Lotto dei tempi impiegati in lav dei barcode
//=== 
//=== Input: id_meca + fila (1 o 2)
//=== Rit: imptime_second di un singolo barcode (modifica del 25-10-2017 MALAGUTI)
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
long k_return
kuf_base kuf1_base
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	if kst_tab_barcode.id_meca > 0 then
		if k_nfila = 1 then
			// calcola tempi solo per fila 1
			select sum(imptime_second) / count(id_meca)
				into
					 :kst_tab_barcode.imptime_second
				from barcode
				where id_meca = :kst_tab_barcode.id_meca 
					 and imptime_second > 0
					 and (barcode.lav_fila_1 + barcode.lav_fila_1p) > 0
				using kguo_sqlca_db_magazzino;
		else
			// calcola tempi solo per fila 2
			select sum(imptime_second) / count(id_meca)
				into
					 :kst_tab_barcode.imptime_second
				from barcode
				where id_meca = :kst_tab_barcode.id_meca 
					 and imptime_second > 0
					 and (barcode.lav_fila_2 + barcode.lav_fila_2p) > 0
				using kguo_sqlca_db_magazzino;
		end if
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Non effettuato il calcolo totale Tempo Impiegato per il trattamento del Lotto su Barcode, manca ID Lotto"
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if			

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if isnull(kst_tab_barcode.imptime_second) then kst_tab_barcode.imptime_second = 0
		k_return = kst_tab_barcode.imptime_second 
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettura Tempo totale Impiegato per il trattamento del Lotto su Barcode (Id Lotto=" + string(kst_tab_barcode.id_meca)+ ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
	end if

return k_return


end function

public function long get_durata_lav_xfila (readonly st_tab_barcode kst_tab_barcode, integer k_nfila) throws uo_exception;//
//---------------------------------------------------------------------------------------------
//--- Calcola in secondi la durata di Trattamento del Lotto di un singolo barcode x fila 1 o 2
//--- 
//--- Inp: st_tab_barcode con id_meca + n. fila (1 o 2)
//--- Out: durata in secondi 
//---             
//---             
//--- Lancia un ECCEZIONE se Errore grave
//---------------------------------------------------------------------------------------------
//
long k_return = 0
long k_secondi_durata
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())

	k_secondi_durata = get_imptime_sec_x_id_meca_fila(kst_tab_barcode, k_nfila)
	
	if k_secondi_durata > 0 then
			
		k_return = k_secondi_durata
			
	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kst_esito.SQLErrText = "Errore in calcolo durata lavorazione dell'intero Lotto.~n~r" + kst_esito.SQLErrText
	kguo_exception.inizializza()
	kguo_exception.set_esito (kst_esito)
	throw kguo_exception

end try

return k_secondi_durata


end function

public function long get_id_meca (ref st_tab_barcode kst_tab_barcode) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Torna ID_MECA (+id_armo) del Lotto x il barcode indicato
//---
//---	inp: st_tab_barcode.barcode
//---	out: st_tab_barcode.id_meca / id_armo
//---	rit: st_tab_barcode.id_meca
//---
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	if len(trim(kst_tab_barcode.barcode)) > 0 then
		select distinct
				id_meca
				,id_armo
			into
				 :kst_tab_barcode.id_meca
				 ,:kst_tab_barcode.id_armo
			from barcode
			where barcode = :kst_tab_barcode.barcode
			using kguo_sqlca_db_magazzino ;
		

		if sqlca.sqlcode = 0 then
			k_return=kst_tab_barcode.id_meca
		else
			if sqlca.sqlcode > 0 then
				kst_tab_barcode.id_meca = 0
			else
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore in lettura ID Lotto da tab. Barcode (cod='" +trim(kst_tab_barcode.barcode)+"'): " + trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	
	end if			


return k_return


end function

public function boolean if_barcode_in_pl (ref st_tab_barcode ast_tab_barcode) throws uo_exception;/*
  Controlla se Barcode gia' in Piano di Lavorazione  

  inp: ast_tab_barcode.barcode
  out: ast_tab_barcode.pl_barcode, id_meca ...
  Rit: TRUE gia' in PL 
*/
boolean k_return = false
long k_rows
st_esito kst_esito 
uo_ds_std_1 kuo_ds_std_1


try
	kst_esito = kguo_exception.inizializza(this.classname())

	if trim(ast_tab_barcode.barcode) > " " then

		kuo_ds_std_1 = create uo_ds_std_1
		kuo_ds_std_1.dataobject = "ds_if_barcode_pianificato"
		kuo_ds_std_1.settransobject(kguo_sqlca_db_magazzino)
		
//		select count(*)
//				into :k_ctr
//				from barcode inner join pl_barcode on barcode.pl_barcode = pl_barcode.codice 
//				where barcode.barcode = :kst_tab_barcode.barcode
//				using kguo_sqlca_db_magazzino;
		k_rows = kuo_ds_std_1.retrieve(ast_tab_barcode.barcode)
						
		if k_rows < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kuo_ds_std_1.kist_esito.sqlcode
			kst_esito.sqlerrtext = "Errore in verifica se Barcode '" + trim(ast_tab_barcode.barcode) + "' pianificato. "  &
						  + kkg.acapo + "(Errore: " + string(kuo_ds_std_1.kist_esito.sqlcode, "#####") + " " + trim(kuo_ds_std_1.kist_esito.sqlerrtext) + ")"
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		end if													  

		if k_rows > 0 then
			k_return = true
			ast_tab_barcode.pl_barcode = kuo_ds_std_1.getitemnumber(1, "pl_barcode")
			ast_tab_barcode.id_meca = kuo_ds_std_1.getitemnumber(1, "id_meca")
			ast_tab_barcode.id_armo = kuo_ds_std_1.getitemnumber(1, "id_armo")
			ast_tab_barcode.data_lav_ini = kuo_ds_std_1.getitemdate(1, "data_lav_ini")
			ast_tab_barcode.data_lav_fin = kuo_ds_std_1.getitemdate(1, "data_lav_fin")
		end if
	else
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlerrtext = "Verifica se barcode Pianificato, operazione bloccata, manca il Barcode!"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally
	if isvalid(kuo_ds_std_1) then destroy kuo_ds_std_1
	

end try


return k_return

end function

public function uo_ds_std_1 get_figli_barcode (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Torna elenco figli x Barcode richiesto
//=== 
//=== Input: st_tab_barcode.barcode
//=== Output: datastore ds_barcode_figli_elenco
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
int k_rc
uo_ds_std_1 kds_1
st_esito kst_esito

try
	kst_esito = kguo_exception.inizializza(this.classname())

	kds_1 = create uo_ds_std_1
	kds_1.dataobject = ki_ds_barcode_figli_elenco
	kds_1.settransobject( sqlca)
	
	kst_tab_barcode.barcode = trim(kst_tab_barcode.barcode)
	
	if kst_tab_barcode.barcode > " " then
		k_rc = kds_1.retrieve(kst_tab_barcode.barcode)
	
		if k_rc < 0 then
			kst_esito.sqlcode = uo_d_std_1.kist_esito.sqlcode
			kst_esito.SQLErrText = "Errore in lettura Figli del Barcode '" &
									+ kst_tab_barcode.barcode &
									+ "'" + kkg.acapo + "(" + trim(kds_1.dataobject ) + "). Errore: " + trim(uo_d_std_1.kist_esito.sqlerrtext)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
//	if isvalid(kds_1) then destroy kds_1

end try

return kds_1

end function

public function uo_ds_std_1 get_figli_barcode_uguale_sl_pt (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Torna elenco figli x Barcode richiesto che hanno lo stesso SL-PT
//=== 
//=== Input: st_tab_barcode.barcode
//=== Output: datastore ds_barcode_figli_elenco
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
int k_rc
uo_ds_std_1 kds_1
st_esito kst_esito


try 

	kst_esito = kguo_exception.inizializza(this.classname())
	
	kds_1 = create uo_ds_std_1
	kds_1.dataobject = ki_ds_barcode_figli_elenco_sl_pt
	kds_1.settransobject( sqlca)
	
	if LenA(trim(kst_tab_barcode.barcode)) > 0 then
		k_rc = kds_1.retrieve(kst_tab_barcode.barcode)
	
		if k_rc < 0 then
			kst_esito.sqlcode = kds_1.kist_esito.sqlcode
			kst_esito.SQLErrText = "Elenco Figli da tab.Barcode (datastore: " + trim(kds_1.dataobject ) + ") per lo stesso PT" &
			    + kkg.acapo + "Errore: " + trim(kds_1.kist_esito.sqlerrtext) 
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	//if isvalid(kds_1) then destroy kds_1
	
end try 
	
return kds_1

end function

public function st_esito get_barcode_dati_trattamento (ref st_tab_barcode kst_tab_barcode) throws uo_exception;/*
 Select Dati di Trattamento Barcode
 
 Ritorna tab. ST_ESITO, Esiti: 0=OK; 100=not found
                                     1=errore grave
                                     2=errore > 0
 
*/
string k_return = "0 "
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	select 
	       barcode_lav,
			 id_armo,
			 id_meca,
			 pl_barcode,
			 tipo_cicli,
			 fila_1,
			 fila_2,
			 fila_1p,
			 fila_2p,
			 lav_fila_1,
			 lav_fila_2,
			 lav_fila_1p,
			 lav_fila_2p
		into
	       :kst_tab_barcode.barcode_lav,
			 :kst_tab_barcode.id_armo,
			 :kst_tab_barcode.id_meca,
			 :kst_tab_barcode.pl_barcode,
			 :kst_tab_barcode.tipo_cicli,
			 :kst_tab_barcode.fila_1,
			 :kst_tab_barcode.fila_2,
			 :kst_tab_barcode.fila_1p,
			 :kst_tab_barcode.fila_2p,
			 :kst_tab_barcode.lav_fila_1,
			 :kst_tab_barcode.lav_fila_2,
			 :kst_tab_barcode.lav_fila_1p,
			 :kst_tab_barcode.lav_fila_2p
		from barcode
		where barcode = :kst_tab_barcode.barcode
		using kguo_sqlca_db_magazzino;


	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_tab_barcode.id_armo = 0
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.sqlerrtext = "Lettura dati di trattamento Barcode: " + trim(kst_tab_barcode.barcode) &
									+ kkg.acapo  + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_tab_barcode.id_armo = 0
			kst_esito.esito = kkg_esito.not_fnd
		end if	
	end if


return kst_esito
end function

public function boolean if_barcode_exists (readonly st_tab_barcode ast_tab_barcode) throws uo_exception;//
//---------------------------------------------------------------------
//--- Controlla se Barcode esiste
//--- 
//--- Inp: st_tab_barcode.barcode
//--- Out:
//--- Ritorna: TRUE esiste
//---                                   
//---------------------------------------------------------------------
boolean k_return 
st_esito kst_esito 
st_tab_barcode kst_tab_barcode

	
	kst_esito = kguo_exception.inizializza(this.classname())

	if trim(ast_tab_barcode.barcode) > " " then

		select barcode.barcode
			into :kst_tab_barcode.barcode
			from barcode 
			where barcode.barcode = :ast_tab_barcode.barcode
			using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = "Errore in verifica esistenza Barcode " + trim(ast_tab_barcode.barcode) &
						  + kkg.acapo + "Errore: " + string(kguo_sqlca_db_magazzino.sqlcode, "#") + " " + trim(kguo_sqlca_db_magazzino.sqlerrtext) + ")"
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if													  
		
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			k_return = true
		end if
		
	end if

return k_return

end function

public function integer set_flg_dosimetro (ref st_tab_barcode ast_tab_barcode, ref uo_ds_std_1 ads_1) throws uo_exception;//
//====================================================================
//=== Imposta in automatico il flag_dosimetro sul Barcode x Lotto
//=== 
//=== Input:  st_tab_barcode.id_meca, datastore = 'ds_barcode_set_flg_dosimetro' 
//=== out: ds ds_barcode_set_flg_dosimetro tutti i barcode con impostato la col flg_dosimetro
//=== ret: nr dosimetri impostati 
//===
//=== lancia EXCEPTION
//=== 
//====================================================================
//
integer k_return, k_resto
//decimal{2} k_resto                    
int k_num, k_riga_flegga_barcode, k_righe_barcode, k_riga_flegga_barcode_ultimo
decimal{1} k_unita_ditrattamento = 0.0
kuf_armo kuf1_armo
kuf_sl_pt kuf1_sl_pt
st_tab_sl_pt kst_tab_sl_pt
st_tab_armo kst_tab_armo
st_esito kst_esito 


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	kst_esito.st_tab_g_0 = ast_tab_barcode.st_tab_g_0 

	k_righe_barcode = ads_1.rowcount()

	if k_righe_barcode > 0 then

//--- get del codice PT per leggere i dati di dove mettere i Dosimetri
		kuf1_armo = create kuf_armo
		kst_tab_armo.id_armo = ads_1.getitemnumber(1, "id_armo")
		kst_tab_sl_pt.impianto = ads_1.getitemnumber(1, "meca_impianto")
		kst_tab_sl_pt.cod_sl_pt = kuf1_armo.get_cod_sl_pt(kst_tab_armo)
//--- get dei dati da PT circa il nr dosimetri per barcode ecc... x IMPIANTO		
		if trim(kst_tab_sl_pt.cod_sl_pt) > " " then
			kuf1_sl_pt = create kuf_sl_pt
			kuf1_sl_pt.get_dosim_dati(kst_tab_sl_pt)
		else
			kst_tab_sl_pt.dosim_delta_bcode = 0 
		end if

		if kst_tab_sl_pt.unitwork > 0.0 then
			k_unita_ditrattamento = (100 / kst_tab_sl_pt.unitwork)
		else
			k_unita_ditrattamento = 1.0
		end if

//--- piazza il dosimetro ogni tot di barcode 
		if kst_tab_sl_pt.dosim_delta_bcode > 0 then
//--- ricalcola il delta con l'unità di trattamento 
			kst_tab_sl_pt.dosim_delta_bcode = k_unita_ditrattamento * kst_tab_sl_pt.dosim_delta_bcode
			
			k_riga_flegga_barcode = 1
			do while k_riga_flegga_barcode <= k_righe_barcode
				ads_1.setitem(k_riga_flegga_barcode, "flg_dosimetro", ki_flg_dosimetro_si)    // flegga il dosimetro
				ads_1.setitem(k_riga_flegga_barcode, "x_datins", kGuf_data_base.prendi_x_datins())
				ads_1.setitem(k_riga_flegga_barcode, "x_utente", kGuf_data_base.prendi_x_utente())
				
				k_return += kst_tab_sl_pt.dosim_x_bcode  // i dosimetri x barcode possono essere anche più di 1
				k_riga_flegga_barcode += kst_tab_sl_pt.dosim_delta_bcode
			loop
			k_riga_flegga_barcode -= kst_tab_sl_pt.dosim_delta_bcode
		end if

		if k_righe_barcode = 1 and k_riga_flegga_barcode = 0 then
			k_riga_flegga_barcode = 1
		else
//--- dosimetro se attivato il risparmio in ultimo pallet condizionato
			if kst_tab_sl_pt.savedosimeter = 1 then
				//--- se il n. dei barcode rimasti è minore del numero dell'unità di trattamento indicata allora no dosimetro
				if (k_righe_barcode - k_riga_flegga_barcode) > int(k_unita_ditrattamento)  then
					k_riga_flegga_barcode = k_righe_barcode   	// flegga dosimetro sull'ultima riga
				else
					k_riga_flegga_barcode = 0   //no dosimetro
				end if
			else				
//--- 27/8/2019 deprecato (REZIO): 20/7/2010 se il numero colli e' pari o dispari? devo mettere il dosimetro sull'ultimo pari
//--- 27/8/2019				k_resto = mod(k_righe_barcode, 2)
//--- 27/8/2019				if k_resto = 0 then  // pari
					k_riga_flegga_barcode = k_righe_barcode		//flegga dosimetro sull'ultima riga
//--- 27/8/2019				else
//--- 27/8/2019					k_riga_flegga_barcode = k_righe_barcode - 1		// flegga il dosimetro sul penultimo
//--- 27/8/2019				end if
			end if
		end if

//--- controllo se è già stato marcato
		if k_riga_flegga_barcode > 0 then
			if ads_1.getitemstring(k_riga_flegga_barcode, "flg_dosimetro") = ki_flg_dosimetro_si then
			else
				ads_1.setitem(k_riga_flegga_barcode, "flg_dosimetro", ki_flg_dosimetro_si)    
				ads_1.setitem(k_riga_flegga_barcode, "x_datins", kGuf_data_base.prendi_x_datins())
				ads_1.setitem(k_riga_flegga_barcode, "x_utente", kGuf_data_base.prendi_x_utente())
				k_return += kst_tab_sl_pt.dosim_x_bcode  // incrementa i dosimetri sul barcode finale
			end if		
		end if

	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_sl_pt) then destroy kuf_sl_pt
	if isvalid(kuf1_armo) then destroy kuf1_armo

end try


return k_return 
end function

public function boolean set_data_stampa (st_tab_barcode ast_tab_barcode) throws uo_exception;//
//------------------------------------------------------------------------
//--- Aggiorna la data di stampa
//--- 
//--- Input: st_tab_barcode.barcode e data_stampa
//---
//--- lancia EXCEPTION
//--- 
//------------------------------------------------------------------------
//
boolean k_return


try
	
	kguo_exception.inizializza(this.classname())

	if trim(ast_tab_barcode.barcode) > " " then 

		ast_tab_barcode.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_barcode.x_utente = kGuf_data_base.prendi_x_utente()
		
		update barcode set 	 
					 data_stampa = :ast_tab_barcode.data_stampa
					,x_datins = :ast_tab_barcode.x_datins  
					,x_utente = :ast_tab_barcode.x_utente 
				where barcode = :ast_tab_barcode.barcode
				using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			k_return = true
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in aggiornamento Data Stampa sul Barcode " + trim(ast_tab_barcode.barcode))
				if ast_tab_barcode.st_tab_g_0.esegui_commit = "N" then
				else
					kguo_sqlca_db_magazzino.db_rollback()
				end if
				throw kguo_exception
			else
				kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in aggiornamento Data Stampa (2) sul Barcode " + trim(ast_tab_barcode.barcode))
				kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_db_wrn
				kguo_exception.scrivi_log( )
			end if
		end if
		if ast_tab_barcode.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_commit()
		end if
	else
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlerrtext = "Aggiornamento Data Stampa su Barcode non eseguito, codice non indicato"
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	

finally					

end try

return k_return


end function

public subroutine set_flg_campione_reset (st_tab_barcode ast_tab_barcode) throws uo_exception;/*
 Resetta il flag_campione per il Barcode 
    Input:  st_tab_barcode.barcode 
*/
st_esito kst_esito 


try

	kst_esito = kguo_exception.inizializza(this.classname())

	if trim(ast_tab_barcode.barcode) > " " then 
	
		ast_tab_barcode.flg_campione = ki_flg_campione_no
		
		set_flg_campione(ast_tab_barcode)
		
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Reset indicatore Campione del Barcode  non eseguito, codice non indicato"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally					

end try




end subroutine

public subroutine set_flg_campione (st_tab_barcode ast_tab_barcode) throws uo_exception;/*
 Update del flag_campione per il Barcode 
    Input: st_tab_barcode.barcode flag_campione
*/
st_esito kst_esito 


try

	kst_esito = kguo_exception.inizializza(this.classname())

	if trim(ast_tab_barcode.barcode) > " " then 
	
		ast_tab_barcode.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_barcode.x_utente = kGuf_data_base.prendi_x_utente()
		update barcode set 	 
					 FLG_campione = :ast_tab_barcode.flg_campione
					 ,x_datins = :ast_tab_barcode.x_datins
					 ,x_utente = :ast_tab_barcode.x_utente
		   where barcode = :ast_tab_barcode.barcode
		   using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in aggiornamento indicatore di Campione sul Barcode " + trim(ast_tab_barcode.barcode) + ". ")
			if ast_tab_barcode.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_magazzino.db_rollback()
			end if
			throw kguo_exception
		end if
		
		if ast_tab_barcode.st_tab_g_0.esegui_commit = "N" then
		else
			kst_esito = kguo_sqlca_db_magazzino.db_commit()
		end if
		
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Aggiornamento indicatore di Campione sul Barcode non eseguito, codice non indicato"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log()
	throw kuo_exception
	
finally					


end try




end subroutine

public subroutine set_flg_campione_si (st_tab_barcode ast_tab_barcode) throws uo_exception;/*
 Resetta il flag_campione per il Barcode 
    Input:  st_tab_barcode.barcode 
*/
st_esito kst_esito 


try

	kst_esito = kguo_exception.inizializza(this.classname())

	if trim(ast_tab_barcode.barcode) > " " then 
	
		ast_tab_barcode.flg_campione = ki_flg_campione_si
		
		set_flg_campione(ast_tab_barcode)
		
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Attivazione indicatore Campione del Barcode non eseguito, codice non indicato"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally					

end try




end subroutine

public function boolean if_essere_barcode_figlio_g2 (st_tab_barcode kst_tab_barcode_figlio, st_tab_barcode kst_tab_barcode_padre) throws uo_exception;//
//====================================================================
//=== Controlla se Barcode puo' diventare Figlio per G2
//=== 
//=== 
//=== Input:  kst_tab_barcode_padre    con  Barcode e File valorizzate (opzionale)
//=== 	     kst_tab_barcode_figlio   con  Barcode e File valorizzate (opzionale)
//=== 
//=== 
//=== Ritorna: TRUE=ok x PADRE; FALSE=non abile
//=== Lancia EXCEPTION       
//===                                   
//====================================================================
boolean k_return=FALSE
st_esito kst_esito 

	
try 	
	kst_esito = kguo_exception.inizializza(this.classname())

	if_essere_barcode_figlio(kst_tab_barcode_figlio, kst_tab_barcode_padre)  // prima verifica valido anche x il G3

//--- se FILE del padre non passate leggo!										
	if (kst_tab_barcode_padre.fila_1 = 0 or isnull(kst_tab_barcode_padre.fila_1)) and (kst_tab_barcode_padre.fila_1p = 0 or isnull(kst_tab_barcode_padre.fila_1p)) &
			and (kst_tab_barcode_padre.fila_2 = 0 or isnull(kst_tab_barcode_padre.fila_2)) and (kst_tab_barcode_padre.fila_2p = 0 or isnull(kst_tab_barcode_padre.fila_2p)) then
		
	//	kst_esito = select_barcode(kst_tab_barcode_padre)
		select 
			  id_meca
			  ,fila_1
			  ,fila_1p
			  ,fila_2
			  ,fila_2p
			into 
				:kst_tab_barcode_padre.id_meca
				,:kst_tab_barcode_padre.fila_1
				,:kst_tab_barcode_padre.fila_1p
				,:kst_tab_barcode_padre.fila_2
				,:kst_tab_barcode_padre.fila_2p
			from barcode
			where barcode = :kst_tab_barcode_padre.barcode
			using kguo_sqlca_db_magazzino;
		if kguo_sqlca_db_magazzino.sqlcode < 0 then	
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in verifica se barcode puo' essere 'figlio' codice barcode padre " + trim(kst_tab_barcode_padre.barcode))	
			throw kguo_exception
		end if
	
	end if

//--- se FILE barcode FIGLIO NON passate ci metto quelle lette su tabella 
	if (kst_tab_barcode_figlio.fila_1 = 0 or isnull(kst_tab_barcode_figlio.fila_1)) and (kst_tab_barcode_figlio.fila_1p = 0 or isnull(kst_tab_barcode_figlio.fila_1p)) &
			and (kst_tab_barcode_figlio.fila_2 = 0 or isnull(kst_tab_barcode_figlio.fila_2)) and (kst_tab_barcode_figlio.fila_2p = 0 or isnull(kst_tab_barcode_figlio.fila_2p)) then
		kst_tab_barcode_figlio.fila_1 = kst_tab_barcode_padre.fila_1
		kst_tab_barcode_figlio.fila_1p = kst_tab_barcode_padre.fila_1p
		kst_tab_barcode_figlio.fila_2 = kst_tab_barcode_padre.fila_2
		kst_tab_barcode_figlio.fila_2p = kst_tab_barcode_padre.fila_2p
	end if
	
//--- Azzera i valori a NULL
	if isnull(kst_tab_barcode_padre.fila_1) then kst_tab_barcode_padre.fila_1 = 0
	if isnull(kst_tab_barcode_padre.fila_1p) then kst_tab_barcode_padre.fila_1p = 0
	if isnull(kst_tab_barcode_padre.fila_2) then kst_tab_barcode_padre.fila_2 = 0
	if isnull(kst_tab_barcode_padre.fila_2p) then kst_tab_barcode_padre.fila_2p = 0
	if isnull(kst_tab_barcode_figlio.fila_1) then kst_tab_barcode_figlio.fila_1 = 0
	if isnull(kst_tab_barcode_figlio.fila_1p) then kst_tab_barcode_figlio.fila_1p = 0
	if isnull(kst_tab_barcode_figlio.fila_2) then kst_tab_barcode_figlio.fila_2 = 0
	if isnull(kst_tab_barcode_figlio.fila_2p) then kst_tab_barcode_figlio.fila_2p = 0

	if (kst_tab_barcode_padre.fila_1 <> kst_tab_barcode_figlio.fila_1) &
			or (kst_tab_barcode_padre.fila_1p <> kst_tab_barcode_figlio.fila_1p) &
			or (kst_tab_barcode_padre.fila_2 <> kst_tab_barcode_figlio.fila_2)  &
			or (kst_tab_barcode_padre.fila_2p <> kst_tab_barcode_figlio.fila_2p) then
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Giri del barcode Figlio " + trim(kst_tab_barcode_figlio.barcode) + " diversi dal barcode Padre "  + trim(kst_tab_barcode_padre.barcode)
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- OK IL BARCODE PUO' DIVENTARE FIGLIO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!		
	k_return = TRUE

catch (uo_exception kuo_exception)
	throw kuo_exception

finally

end try

			
return k_return

end function

public function boolean tb_update_g3_reset (st_tab_barcode ast_tab_barcode) throws uo_exception;/*
   Reset dati Programmazione se necassario
	inp: st_tab_barcode.barcode
	out: 
	rit: true=resettato su DB, false=non necessario
*/
boolean k_return


	kguo_exception.inizializza(this.classname())

	ast_tab_barcode.barcode = trim(ast_tab_barcode.barcode)
	if trim(ast_tab_barcode.barcode) > " " then
	else
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.SQLErrText = "Errore interno. Manca il codice Barcode per inizializzare i dati di Progrmazione Imianto G3."
		throw kguo_exception
	end if
	
	if get_pl_barcode(ast_tab_barcode) > 0 then
	 
		ast_tab_barcode.pl_barcode = 0
		ast_tab_barcode.pl_barcode_progr = 0
		ast_tab_barcode.g3ciclo = 0
		ast_tab_barcode.g3ngiri = 0
		ast_tab_barcode.g3npass = 0
		ast_tab_barcode.id_sl_pt_g3_lav = 0
		
		tb_update_g3_update(ast_tab_barcode)   // UPDATE
		
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
					"Errore in pulizia dati Impianto G3 del barcode " + ast_tab_barcode.barcode)
			if ast_tab_barcode.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			throw kguo_exception
		end if
	
		if ast_tab_barcode.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		
		k_return = true		
		
	end if		

return k_return

end function

private subroutine tb_update_g3_update (ref st_tab_barcode ast_tab_barcode) throws uo_exception;/*
   Update dati Programmazione
	inp: st_tab_barcode.barcode + diversi dati di Pianificazione G3
	out: st_tab_barcode.x_datins + x_utente
	rit:
*/
	kguo_exception.inizializza(this.classname())

	ast_tab_barcode.barcode = trim(ast_tab_barcode.barcode)
	if trim(ast_tab_barcode.barcode) > " " then
	else
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.SQLErrText = "Errore interno. Manca il codice Barcode per aggiornare i dati di Progrmmazione Impianto G3."
		throw kguo_exception
	end if

	ast_tab_barcode.x_datins = kGuf_data_base.prendi_x_datins()
	ast_tab_barcode.x_utente = kGuf_data_base.prendi_x_utente()
	  
	update barcode set  
			 impianto = :ast_tab_barcode.impianto,
			 pl_barcode = :ast_tab_barcode.pl_barcode,
			 pl_barcode_progr = :ast_tab_barcode.pl_barcode_progr,
			 g3ciclo = :ast_tab_barcode.g3ciclo,
			 g3ngiri = :ast_tab_barcode.g3ngiri,
			 g3npass = :ast_tab_barcode.g3npass,
			 id_sl_pt_g3_lav = :ast_tab_barcode.id_sl_pt_g3_lav,
			 x_datins = :ast_tab_barcode.x_datins,
			 x_utente = :ast_tab_barcode.x_utente
		where barcode = :ast_tab_barcode.barcode
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
				"Errore in Aggiornamento dati Impianto G3 del barcode " + ast_tab_barcode.barcode)
		if ast_tab_barcode.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		throw kguo_exception
	end if

	if ast_tab_barcode.st_tab_g_0.esegui_commit = "N" then
	else
		kguo_sqlca_db_magazzino.db_commit( )
	end if
		
		

end subroutine

public subroutine tb_update_g3 (ref st_tab_barcode ast_tab_barcode) throws uo_exception;/*
   Update dati Programmazione
	inp: st_tab_barcode.barcode + diversi dati G3
	out: st_tab_barcode.x_datins + x_utente
	rit:
*/


	kguo_exception.inizializza(this.classname())

	ast_tab_barcode.barcode = trim(ast_tab_barcode.barcode)
	 
	if trim(ast_tab_barcode.barcode) > " " then
	else
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.SQLErrText = "Errore interno. Manca il codice Barcode per aggiornare i dati di Programmazione Impianto G3."
		throw kguo_exception
	end if
	if isnull(ast_tab_barcode.pl_barcode) or ast_tab_barcode.pl_barcode = 0 then
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.SQLErrText = "Errore interno. Manca il codice del Piano per aggiornare il Barcode " + ast_tab_barcode.barcode + " con i dati di lavorazione Impianto G3."
		throw kguo_exception
	end if
	if isnull(ast_tab_barcode.pl_barcode_progr) or ast_tab_barcode.pl_barcode_progr = 0 then
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.SQLErrText = "Errore interno. Manca il progressivo del Piano per aggiornare il Barcode " + ast_tab_barcode.barcode + " con i dati di lavorazione Impianto G3."
		throw kguo_exception
	end if
	if isnull(ast_tab_barcode.g3npass) or ast_tab_barcode.g3npass = 0 then
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.SQLErrText = "Errore interno. Manca il numero Pass di Trattamento per aggiornare il Barcode " + ast_tab_barcode.barcode + " con i dati di lavorazione Impianto G3."
		throw kguo_exception
	end if
	if isnull(ast_tab_barcode.g3ngiri) or ast_tab_barcode.g3ngiri = 0 then
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.SQLErrText = "Errore interno. Manca il numero Giri di Trattamento per aggiornare il Barcode " + ast_tab_barcode.barcode + " con i dati di lavorazione Impianto G3."
		throw kguo_exception
	end if
	if isnull(ast_tab_barcode.g3ciclo) or ast_tab_barcode.g3ciclo = 0 then
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.SQLErrText = "Errore interno. Manca il Ciclo di Trattamento per aggiornare il Barcode " + ast_tab_barcode.barcode + " con i dati di lavorazione Impianto G3."
		throw kguo_exception
	end if
	if isnull(ast_tab_barcode.id_sl_pt_g3_lav) or ast_tab_barcode.id_sl_pt_g3_lav = 0 then
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.SQLErrText = "Errore interno. Manca ID del Piano di Trattamento per aggiornare il Barcode " + ast_tab_barcode.barcode + " con i dati di lavorazione Impianto G3."
		throw kguo_exception
	end if

	tb_update_g3_update(ast_tab_barcode)  // UPDATE
	

end subroutine

public subroutine tb_update_g2 (ref st_tab_barcode ast_tab_barcode) throws uo_exception;/*
   Update dati Programmazione
	inp: st_tab_barcode.barcode + diversi dati di Pianificazione G2
	out: st_tab_barcode.x_datins + x_utente
	rit:
*/

	kguo_exception.inizializza(this.classname())

	ast_tab_barcode.barcode = trim(ast_tab_barcode.barcode)
	 
	if trim(ast_tab_barcode.barcode) > " " then
	else
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.SQLErrText = "Errore interno. Manca il codice Barcode per aggiornare i dati di Programmazione Impianto G2."
		throw kguo_exception
	end if
	if isnull(ast_tab_barcode.pl_barcode) or ast_tab_barcode.pl_barcode = 0 then
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.SQLErrText = "Errore interno. Manca il codice del Piano per aggiornare il Barcode " + ast_tab_barcode.barcode + " con i dati di lavorazione Impianto G2."
		throw kguo_exception
	end if
	if isnull(ast_tab_barcode.pl_barcode_progr) or ast_tab_barcode.pl_barcode_progr = 0 then
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.SQLErrText = "Errore interno. Manca il progressivo del Piano per aggiornare il Barcode " + ast_tab_barcode.barcode + " con i dati di lavorazione Impianto G2."
		throw kguo_exception
	end if
	
	ast_tab_barcode.x_datins = kGuf_data_base.prendi_x_datins()
	ast_tab_barcode.x_utente = kGuf_data_base.prendi_x_utente()
	  
	update barcode set  
			 impianto = :ast_tab_barcode.impianto,
			 pl_barcode = :ast_tab_barcode.pl_barcode,
			 pl_barcode_progr = :ast_tab_barcode.pl_barcode_progr,
			 x_datins = :ast_tab_barcode.x_datins,
			 x_utente = :ast_tab_barcode.x_utente
		where barcode = :ast_tab_barcode.barcode
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
				"Errore in Aggiornamento dati Impianto G2 del barcode " + ast_tab_barcode.barcode)
		if ast_tab_barcode.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		throw kguo_exception
	end if

	if ast_tab_barcode.st_tab_g_0.esegui_commit = "N" then
	else
		kguo_sqlca_db_magazzino.db_commit( )
	end if
		
		

end subroutine

public function string get_tipo_cicli (ref st_tab_barcode kst_tab_barcode) throws uo_exception;/*
 Torna il Tipo_Cicli di un Barcode 
   Inp: st_tab_barcode.barcode
   Out: st_tab_barcode.tipo_cicli
*/
string k_return


	kguo_exception.inizializza(this.classname())

	SELECT tipo_cicli
		into :kst_tab_barcode.tipo_cicli
		FROM barcode
		WHERE (barcode = :kst_tab_barcode.barcode) 
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode >= 0 then
		if kst_tab_barcode.tipo_cicli > " " then
			k_return = kst_tab_barcode.tipo_cicli
		end if			
	else
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in lettura Tipo Cilo del Barcode " + trim(kst_tab_barcode.barcode))		
		throw kguo_exception
	end if


return k_return

end function

public function integer get_impianto (ref st_tab_barcode kst_tab_barcode) throws uo_exception;/*
 Torna il Tipo_Cicli di un Barcode 
   Inp: st_tab_barcode.barcode
   Out: st_tab_barcode.impianto
*/
integer k_return


	kguo_exception.inizializza(this.classname())

	SELECT impianto
		into :kst_tab_barcode.impianto
		FROM barcode
		WHERE (barcode = :kst_tab_barcode.barcode) 
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode >= 0 then
		if kst_tab_barcode.tipo_cicli > " " then
			k_return = kst_tab_barcode.impianto
		end if			
	else
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in lettura Impianto del Barcode " + trim(kst_tab_barcode.barcode))		
		throw kguo_exception
	end if


return k_return

end function

public function integer get_g3npass (ref st_tab_barcode kst_tab_barcode) throws uo_exception;/*
 Estrae totale giri pianificati di fila 1 e fila 2 x Lotto
   Inp: st_barcode.barcode
   Out: st_tab_barcode.g3npass
*/
	kguo_exception.inizializza(this.classname())

	kst_tab_barcode.g3npass = 0

	if trim(kst_tab_barcode.barcode) > " " then
	else
		kguo_exception.kist_esito.SQLErrText = "Operazione di lettura N.Pass pianificato del Barcode non eseguita, manca il codice."
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		throw kguo_exception
	end if
	
	select isnull(g3npass, 0)
			into
				 :kst_tab_barcode.g3npass
			from barcode
			where barcode.barcode = :kst_tab_barcode.barcode
			using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in lettura N.Pass pianificato il Barcode " + trim(kst_tab_barcode.barcode)+ ") ")	
		throw kguo_exception
	end if

return kst_tab_barcode.g3npass
end function

public function boolean if_essere_barcode_figlio (st_tab_barcode kst_tab_barcode_figlio, st_tab_barcode kst_tab_barcode_padre) throws uo_exception;//
//====================================================================
//=== Controlla se Barcode puo' diventare Figlio
//=== 
//=== 
//=== Input:  kst_tab_barcode_padre    con  Barcode e File valorizzate (opzionale)
//=== 	     kst_tab_barcode_figlio   con  Barcode e File valorizzate (opzionale)
//=== 
//=== 
//=== Ritorna: TRUE=ok x PADRE; FALSE=non abile
//=== Lancia EXCEPTION       
//===                                   
//====================================================================
boolean k_return=FALSE
long k_ctr
string k_causale_non_trattare
kuf_armo kuf1_armo
st_tab_meca kst_tab_meca
st_tab_barcode kst_tab_barcode
st_esito kst_esito 

	
try 	
	kst_esito = kguo_exception.inizializza(this.classname())

	k_causale_non_trattare = ki_causale_non_trattare

	if len(trim(kst_tab_barcode_figlio.barcode)) = 0 or Len(trim(kst_tab_barcode_padre.barcode)) = 0 then
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Barcode figlio non indicato "
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- barcode figlio e padre uguali? 
	if kst_tab_barcode_figlio.barcode =  kst_tab_barcode_padre.barcode then
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Anomalia: barcode Figlio e Padre uguali (" + trim(kst_tab_barcode_figlio.barcode) +"). "
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if


//--- barcode già in piano chiuso? 
	kst_tab_barcode.barcode = kst_tab_barcode_figlio.barcode
	if if_barcode_in_pl_chiuso (kst_tab_barcode) then
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Anomalia: barcode " + trim(kst_tab_barcode.barcode) + " (Figlio) già Pianificato"   + ". "
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
//--- Leggo barcode FIGLIO
	kst_tab_barcode.barcode = kst_tab_barcode_figlio.barcode
	select barcode_lav
	     ,data_stampa
		  ,data_sosp
		  ,causale
		  ,id_meca
		into 
			:kst_tab_barcode.barcode_lav
			,:kst_tab_barcode.data_stampa
			,:kst_tab_barcode.data_sosp
			,:kst_tab_barcode.causale
			,:kst_tab_barcode.id_meca
		from barcode
		where barcode = :kst_tab_barcode.barcode
		using kguo_sqlca_db_magazzino;
	if kguo_sqlca_db_magazzino.sqlcode < 0 then	
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in lettura barcode figlio  " + trim(kst_tab_barcode_figlio.barcode))	
		throw kguo_exception
	end if

//--- Lotto nello STATO E1 giusto?
	kuf1_armo = create kuf_armo
	kst_tab_meca.id = kst_tab_barcode.id_meca
	if NOT kuf1_armo.if_lotto_associato(kst_tab_meca) then
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlerrtext = "Il Lotto del Barcode " + trim(kst_tab_barcode.barcode) + " (figlio) è nello Stato E1 '" &
					+ trim(kst_tab_meca.e1srst) + "' deve invece essere come 'Associato'. "
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
	if LenA(trim(kst_tab_barcode.barcode_lav)) > 0 then
		if trim(kst_tab_barcode.barcode_lav) <> trim(kst_tab_barcode_padre.barcode) then
			kst_esito.esito = kkg_esito.err_logico   //kkg_esito.db_wrn
			kst_esito.sqlcode = 0
			kst_esito.sqlerrtext = "Anomalia: barcode " + trim(kst_tab_barcode.barcode) + " è già figlio del Barcode " + trim(kst_tab_barcode.barcode_lav)
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if

	if kst_tab_barcode.data_stampa <= date(0) or isnull(kst_tab_barcode.data_stampa) then
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Anomalia: barcode " + trim(kst_tab_barcode.barcode) + " non ancora stampato. " 
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
	if kst_tab_barcode.data_sosp > date(0) then
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Anomalia: barcode " + trim(kst_tab_barcode.barcode) + " sospeso. " 
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kst_tab_barcode.causale = ki_causale_non_trattare then
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Anomalia: barcode " + trim(kst_tab_barcode.barcode) + " da 'non trattare'. " 
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- OK IL BARCODE PUO' DIVENTARE FIGLIO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!		
	k_return = TRUE

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_armo) then destroy kuf1_armo

end try

			
return k_return

end function

public subroutine get_fila_altri (ref st_tab_barcode kst_tab_barcode) throws uo_exception;/*
 Estrae giri lav di fila 1 e fila 2 e altri dati
   Inp: st_tab_barcode.barcode
   Out: st_tab_barcode.fila_* e altri dati
*/

	kguo_exception.inizializza(this.classname())

	if trim(kst_tab_barcode.barcode) > " " then
		
		select isnull(fila_1, 0)
		       ,isnull(fila_2, 0)
		       ,isnull(fila_1p, 0)
		       ,isnull(fila_2p, 0)
				 ,isnull(barcode_lav, '')
				 ,isnull(groupage, '')
				 ,num_int
				 ,id_meca				 
			into
				 :kst_tab_barcode.fila_1
				 ,:kst_tab_barcode.fila_2
				 ,:kst_tab_barcode.fila_1p
				 ,:kst_tab_barcode.fila_2p
				 ,:kst_tab_barcode.barcode_lav
				 ,:kst_tab_barcode.groupage
				 ,:kst_tab_barcode.num_int
				 ,:kst_tab_barcode.id_meca
			from barcode
			where barcode = :kst_tab_barcode.barcode 
			using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in lettura n. Giri Pianificati in tab. Barcode " + string(kst_tab_barcode.barcode))
			throw kguo_exception
		end if
		
	else
		
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlerrtext = "Lettura n. Giri Pianificati in tab. Barcode non eseguita, manca il codice."
		throw kguo_exception
		
	end if			

end subroutine

public subroutine get_lav_fila (ref st_tab_barcode kst_tab_barcode) throws uo_exception;/*
 Estrae giri lav di fila 1 e fila 2
   Inp: st_tab_barcode.barcode
   Out: st_tab_barcode.fila_*
*/

	kguo_exception.inizializza(this.classname())

	if trim(kst_tab_barcode.barcode) > " " then
		
		select isnull(fila_1, 0)
		       ,isnull(fila_2, 0)
		       ,isnull(fila_1p, 0)
		       ,isnull(fila_2p, 0)
			into
				 :kst_tab_barcode.fila_1
				 ,:kst_tab_barcode.fila_2
				 ,:kst_tab_barcode.fila_1p
				 ,:kst_tab_barcode.fila_2p
			from barcode
			where barcode = :kst_tab_barcode.barcode 
			using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in lettura n. Giri Trattati in tab. Barcode " + string(kst_tab_barcode.barcode))
			throw kguo_exception
		end if
		
	else
		
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlerrtext = "Lettura n. Giri Trattati in tab. Barcode non eseguita, manca il codice."
		throw kguo_exception
		
	end if			

end subroutine

public function boolean select_barcode (ref st_tab_barcode ast_tab_barcode) throws uo_exception;/*
 Select Barcode
 inp: st_tab_barcode.barcode
 out: st_tab_barcode.*
 ret: TRUE = trovato
*/
boolean k_return
st_tab_barcode kst_tab_barcode, kst_tab_barcode_vuota


	kguo_exception.inizializza(this.classname())

	kst_tab_barcode.barcode = trim(ast_tab_barcode.barcode)

	select 
	       data,
	       barcode_lav,
			 id_armo,
			 pl_barcode,
			 groupage,
			 pl_barcode_progr,
			 num_int,
			 data_int,
			 data_stampa,
			 data_lav_ini,
			 data_lav_fin,
			 data_lav_ok,
			 data_sosp,
			 tipo_cicli,
			 fila_1,
			 fila_2,
			 fila_1p,
			 fila_2p,
			 posizione,
			 bilancella,
			 id_meca,
			 ora_lav_ini,
			 ora_lav_fin,
			 lav_fila_1,
			 lav_fila_2,
			 lav_fila_1p,
			 lav_fila_2p,
			 err_lav_fin,
			 err_lav_ok
			,g3ngiri 
			,id_sl_pt_g3_lav
			,g3ciclo 
			,g3npass 
			,g3lav_ngiri
			,g3lav_ciclo
			,g3lav_npass 	 
			,impianto 	 
			,x_datins
			,x_utente
		into
	       :kst_tab_barcode.data,
	       :kst_tab_barcode.barcode_lav,
			 :kst_tab_barcode.id_armo,
			 :kst_tab_barcode.pl_barcode,
			 :kst_tab_barcode.groupage,
			 :kst_tab_barcode.pl_barcode_progr,
			 :kst_tab_barcode.num_int,
			 :kst_tab_barcode.data_int,
			 :kst_tab_barcode.data_stampa,
			 :kst_tab_barcode.data_lav_ini,
			 :kst_tab_barcode.data_lav_fin,
			 :kst_tab_barcode.data_lav_ok,
			 :kst_tab_barcode.data_sosp,
			 :kst_tab_barcode.tipo_cicli,
			 :kst_tab_barcode.fila_1,
			 :kst_tab_barcode.fila_2,
			 :kst_tab_barcode.fila_1p,
			 :kst_tab_barcode.fila_2p,
			 :kst_tab_barcode.posizione,
			 :kst_tab_barcode.bilancella,
			 :kst_tab_barcode.id_meca,
			 :kst_tab_barcode.ora_lav_ini,
			 :kst_tab_barcode.ora_lav_fin,
			 :kst_tab_barcode.lav_fila_1,
			 :kst_tab_barcode.lav_fila_2,
			 :kst_tab_barcode.lav_fila_1p,
			 :kst_tab_barcode.lav_fila_2p,
			 :kst_tab_barcode.err_lav_fin,
			 :kst_tab_barcode.err_lav_ok
			,:kst_tab_barcode.g3ngiri 
			,:kst_tab_barcode.id_sl_pt_g3_lav
			,:kst_tab_barcode.g3ciclo 
			,:kst_tab_barcode.g3npass 
			,:kst_tab_barcode.g3lav_ngiri
			,:kst_tab_barcode.g3lav_ciclo
			,:kst_tab_barcode.g3lav_npass 
			,:kst_tab_barcode.impianto
			,:kst_tab_barcode.x_datins
			,:kst_tab_barcode.x_utente
		from barcode
		where barcode = :kst_tab_barcode.barcode
		using kguo_sqlca_db_magazzino;


	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in lettura del Barcode " + trim(kst_tab_barcode.barcode))
		throw kguo_exception
	end if

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
		ast_tab_barcode = kst_tab_barcode
	else
		ast_tab_barcode = kst_tab_barcode_vuota  // svuota l'area
		ast_tab_barcode.barcode = kst_tab_barcode.barcode
	end if
	
return k_return	
end function

public subroutine check_anomalie_lavorazione_g3 (ref st_tab_barcode ast_tab_barcode) throws uo_exception;/*
  Controllo dati di LAVORAZIONE GAMMA 3
     Inp: st_tab_barcode con i dati di trattamento valorizzati tra i quali id_sl_pt_g3_lav
     Out: st_tab_barcode con i dati di esito valorizzati
*/
string k_barcode_esito="0", k_flag_esponi_gia_lavorato
st_esito kst_esito
kuf_armo kuf1_armo
kuf_sl_pt_g3 kuf1_sl_pt_g3
st_tab_sl_pt_g3_lav kst_tab_sl_pt_g3_lav
//st_tab_sl_pt kst_tab_sl_pt, kst_tab_sl_pt_vuota
st_tab_armo kst_tab_armo, kst1_tab_armo, kst_tab_armo_vuota


try
	SetPointer(kkg.pointer_attesa)

	kguo_exception.inizializza(this.classname())
			
	ast_tab_barcode.err_lav_fin = ki_err_lav_fin_ok  //---- x default esito POSITIVO
			
	kuf1_armo = create kuf_armo
	kuf1_sl_pt_g3 = create kuf_sl_pt_g3
	
	//--- pulizia campi di appoggio
	kst_tab_sl_pt_g3_lav.ngiri = 0
	kst_tab_sl_pt_g3_lav.ciclo_max = 0
	kst_tab_sl_pt_g3_lav.ciclo_min = 0
	kst_tab_sl_pt_g3_lav.g3npass = 0
	ast_tab_barcode.note_lav_fin = ""
	
	if ast_tab_barcode.id_armo > 0 then
	
	//--- legge tab ARMO x prendere cod sl-pt
		kst_tab_armo = kst_tab_armo_vuota
		kst_tab_armo.id_armo = ast_tab_barcode.id_armo
		kuf1_armo.get_cod_sl_pt(kst_tab_armo)   //leggi_riga("1",kst_tab_armo)
	
		if trim(kst_tab_armo.cod_sl_pt) > " " then
	
	//--- legge tab ARMO x prendere totale colli della riga del Riferimento 
			kst1_tab_armo = kst_tab_armo_vuota
			kst1_tab_armo.id_armo = ast_tab_barcode.id_armo
			kuf1_armo.get_colli_pedane(kst_tab_armo)			//leggi_riga("R", kst1_tab_armo)
							
	//--- legge tab SL PT G3 LAV x prendere GIRI e altri dati di Lav
			if ast_tab_barcode.id_sl_pt_g3_lav > 0 then
				
				//kst_tab_sl_pt = kst_tab_sl_pt_vuota
				//kst_tab_sl_pt.cod_sl_pt = kst_tab_armo.cod_sl_pt 
				kst_tab_sl_pt_g3_lav.id_sl_pt_g3_lav = ast_tab_barcode.id_sl_pt_g3_lav
				if kuf1_sl_pt_g3.get_g3_lav_ngiri_altri(kst_tab_sl_pt_g3_lav) = 0 then // select_riga(kst_tab_sl_pt)
					ast_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
					ast_tab_barcode.note_lav_fin += "Dati PT-G3 non Trovati - "
				else
					
					if kst_tab_sl_pt_g3_lav.ngiri = 0  &
								and kst_tab_sl_pt_g3_lav.g3npass = 0  &
								and kst_tab_sl_pt_g3_lav.ciclo_min = 0  &
								and kst_tab_sl_pt_g3_lav.ciclo_max = 0  &
								then
						ast_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
						ast_tab_barcode.note_lav_fin +=  "Dati PT-G3 Non Impostati - "
					end if
								
				end if
			else
				ast_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
				ast_tab_barcode.note_lav_fin +=  "Id del PT-G3 non Impostato sul barcode '" + trim(ast_tab_barcode.barcode) + "' - " 
			end if
		else
			ast_tab_barcode.note_lav_fin +=  "Dati per la Verifica non recuparati dal Piano di Trattamento, codice PT non Trovato sulla Riga " + string(ast_tab_barcode.id_armo) + " di Entrata Lotto - " 
		end if
	else
		ast_tab_barcode.note_lav_fin +=  "Riga di Entrata Lotto Non Riconosciuta. Dati per la Verifica non recuparati dal Piano di Trattamento - " 
	end if
		
	//--- Toglie NULL
	if isnull(ast_tab_barcode.g3npass) then ast_tab_barcode.g3npass = 0  
	if isnull(ast_tab_barcode.g3ciclo) then ast_tab_barcode.g3ciclo = 0  
	if isnull(ast_tab_barcode.g3ngiri) then ast_tab_barcode.g3ngiri = 0  

	//--- controllo se cicli impostati almeno sul piano di lavorazione 
	if ast_tab_barcode.g3npass = 0 &
				and ast_tab_barcode.g3ciclo = 0 &
				and ast_tab_barcode.g3ngiri = 0 then
			
		ast_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
		ast_tab_barcode.note_lav_fin += "Recuperati dal PT-G3 i dati di Pianificazione Lavorazione non presenti sul Barcode - " 

		ast_tab_barcode.g3npass = kst_tab_sl_pt_g3_lav.g3npass  
		ast_tab_barcode.g3ciclo = kst_tab_sl_pt_g3_lav.ciclo_target 
		ast_tab_barcode.g3ngiri = kst_tab_sl_pt_g3_lav.ngiri  
	end if							

	//--- Controllo Dati di trattatamento e quelli Pianificati sul barcode	
	if ast_tab_barcode.g3lav_npass <> ast_tab_barcode.g3npass then
		ast_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
		ast_tab_barcode.note_lav_fin += "Lavorazione n.PASS " + string(ast_tab_barcode.g3lav_npass) &
									 + " diversa con quella Pianificata a " & 
									 + string(ast_tab_barcode.g3npass) + " - "
	end if
//31-07-2024 Rezio non sa ancora come controllare i cicli	
//	if kst_tab_sl_pt_g3_lav.ciclo_min > ast_tab_barcode.g3lav_ciclo then
//		ast_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
//		ast_tab_barcode.note_lav_fin +=  "Ciclo di Lavorazione " + trim(string(ast_tab_barcode.g3lav_ciclo)) &
//								+ " Minore del consentito dal PT " & 
//								 + trim(string(kst_tab_sl_pt_g3_lav.ciclo_min)) + " - " 
//	end if
//	if kst_tab_sl_pt_g3_lav.ciclo_max < ast_tab_barcode.g3lav_ciclo then
//		ast_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
//		ast_tab_barcode.note_lav_fin +=  "Ciclo di Lavorazione " + trim(string(ast_tab_barcode.g3lav_ciclo)) &
//								+ " Maggiore del consentito dal PT " & 
//								 + trim(string(kst_tab_sl_pt_g3_lav.ciclo_max)) + " - " 
//	end if
	if ast_tab_barcode.g3lav_ngiri <> ast_tab_barcode.g3ngiri then
		ast_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
		ast_tab_barcode.note_lav_fin +=  "Numero Giri " + trim(string(ast_tab_barcode.g3lav_ngiri)) &
								+ " Lavorati diversi dai " & 
								 + trim(string(kst_tab_sl_pt_g3_lav.ngiri)) + " Pianificati - " 
	end if
	
					
	if ast_tab_barcode.err_lav_fin = ki_err_lav_fin_ok then
	
	//--- confronto tra cicli pianificati nel barcode con quelli su Sl-PT
		if kst_tab_sl_pt_g3_lav.g3npass <> ast_tab_barcode.g3npass then
			ast_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
			ast_tab_barcode.note_lav_fin += "Impostati sul barcode in Pianificazione n.PASS " + string(ast_tab_barcode.g3npass) &
										 + " diversi dai " & 
										 + string(kst_tab_sl_pt_g3_lav.g3npass) + " del PT - "
		end if
//31-07-2024 Rezio non sa ancora come controllare i cicli	
//		if kst_tab_sl_pt_g3_lav.ciclo_min > ast_tab_barcode.g3ciclo then
//			ast_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
//			ast_tab_barcode.note_lav_fin +=  "Ciclo " + trim(string(ast_tab_barcode.g3ciclo)) &
//									+ " impostato sul barcode in Pianificazione Minore del consentito dal PT " & 
//									 + trim(string(kst_tab_sl_pt_g3_lav.ciclo_min)) + " - " 
//		end if
//		if kst_tab_sl_pt_g3_lav.ciclo_max < ast_tab_barcode.g3ciclo then
//			ast_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
//			ast_tab_barcode.note_lav_fin +=  "Ciclo " + trim(string(ast_tab_barcode.g3ciclo)) &
//									+ " impostato sul barcode in Pianificazione Maggiore del consentito dal PT " & 
//									 + trim(string(kst_tab_sl_pt_g3_lav.ciclo_max)) + " - " 
//		end if
		if kst_tab_sl_pt_g3_lav.ngiri <> ast_tab_barcode.g3ngiri then
			ast_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
			ast_tab_barcode.note_lav_fin +=  "Numero Giri " + trim(string(ast_tab_barcode.g3ngiri)) &
									 + " impostati sul barcode in Pianificazione diversi dai " & 
									 + trim(string(kst_tab_sl_pt_g3_lav.ngiri)) + " del PT  - " 
		end if
	end if
	
	
	if ast_tab_barcode.err_lav_fin = ki_err_lav_fin_ok then
		
		ast_tab_barcode.note_lav_fin +="Verifica Lavorazione Corretta."
							
	else
		
		ast_tab_barcode.note_lav_fin = "Dati Pianificati: N.Pass: " &
									  + string(ast_tab_barcode.g3npass) &
									  + ", Ciclo: " + string(ast_tab_barcode.g3ciclo) &
									  + ", Giri: " + string(ast_tab_barcode.g3ngiri) &
									  + " - " + trim(ast_tab_barcode.note_lav_fin)
	end if
				
	//--- controllo se PL presente			
	if isnull(ast_tab_barcode.pl_barcode) or ast_tab_barcode.pl_barcode = 0 then
		ast_tab_barcode.pl_barcode = 0
		ast_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
		ast_tab_barcode.note_lav_fin = "Barcode senza Piano di Lavorazione"  &
									 + " - " + trim(ast_tab_barcode.note_lav_fin)
	end if	
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	if ast_tab_barcode.st_tab_g_0.esegui_commit = "N" then
	else
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_sl_pt_g3) then destroy kuf1_sl_pt_g3
	

end try
end subroutine

public function integer get_impianto_x_id_armo_pl_barcode (ref st_tab_barcode ast_tab_barcode) throws uo_exception;/*
 Torna l'impiantodi trattamento dei Barcode x codice PL e il ID_ARMO
	 Inp: st_tab_barcode.id_armo e pl_barcode
	 Out: Impianto
*/

	kguo_exception.inizializza(this.classname())

	SELECT distinct isnull(impianto, 2) 
	    into :ast_tab_barcode.impianto
		 FROM barcode
		WHERE (id_armo = :ast_tab_barcode.id_armo and pl_barcode = :ast_tab_barcode.pl_barcode)
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
				"Errore in lettura Impianto di trattamentodei barcode sul Piano di Lavorazione n. " + string(ast_tab_barcode.pl_barcode) &
				  + " della riga Lotto n. " + string(ast_tab_barcode.id_armo))
		throw kguo_exception
	end if

	if ast_tab_barcode.impianto > 0 then
	else
		ast_tab_barcode.impianto = 2
	end if

return ast_tab_barcode.impianto

end function

public function long set_imptime_second_g3 (st_tab_barcode ast_tab_barcode) throws uo_exception;/*
 Imposta il tempo (secondi) impiegato dal barcode nell'irraggiamento 
 	Inp: st_tab_barcode.barcode + g3lav_ngiri
*/
long k_return
long k_giro_insecondi, k_time_fila_1, k_time_fila_2


try
	
	kguo_exception.inizializza(this.classname())

//	if_sicurezza(kkg_flag_modalita.inserimento) 

	if trim(ast_tab_barcode.barcode) > " " then 

		if ast_tab_barcode.g3lav_ngiri > 0 then
			
//--- get del CICLO (tempo in sec) del primo barcode entrato 
			get_g3lav_ciclo_firstbarcode(ast_tab_barcode)

//--- calcolo del tempo totale impiegato dal barcode per compiere un giro di trattamento in impianto (Tempo CICLO * GIRI * 36 stazioni)
			ast_tab_barcode.imptime_second = ast_tab_barcode.g3lav_ciclo * ast_tab_barcode.g3lav_ngiri * 36  

			set_imptime_second(ast_tab_barcode)  // UPDATE!
				
		end if
		
	else
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlerrtext = "Aggiornamento Tempi Impianto G3 sul Barcode non eseguito, codice non indicato"
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kguo_exception

finally					

end try

return k_return


end function

public function long set_imptime_second_g2 (st_tab_barcode ast_tab_barcode) throws uo_exception;//
//------------------------------------------------------------------------
//--- Imposta il tempo (secondi) impiegato dal barcode nell'irraggiamento 
//--- 
//--- Input:  st_tab_barcode.barcode 
//---
//--- lancia EXCEPTION
//--- 
//------------------------------------------------------------------------
//
long k_return
long k_giro_insecondi, k_time_fila_1, k_time_fila_2
st_esito kst_esito
st_tab_imptime kst_tab_imptime
st_tab_barcode kst_tab_barcode 
kuf_ausiliari kuf1_ausiliari


try
	
	kguo_exception.inizializza(this.classname())
	kst_esito.st_tab_g_0 = ast_tab_barcode.st_tab_g_0 

//	if_sicurezza(kkg_flag_modalita.inserimento) 

	if trim(ast_tab_barcode.barcode) > " " then 

		kst_tab_barcode = ast_tab_barcode

//--- get del numero giri effettuato dal barcode
		get_lav_fila(kst_tab_barcode) 
		
		if kst_tab_barcode.lav_fila_1 > 0 or kst_tab_barcode.lav_fila_2 > 0 then
			
//--- get della data di fine lavorazione
			kst_tab_imptime.data_ini = get_data_lav_fin(kst_tab_barcode)

//--- get dei tempi impiegati in impianto per UN ciclo
			kuf1_ausiliari = create kuf_ausiliari
			if kuf1_ausiliari.tb_imptime_get(kst_tab_imptime) then
			
//--- modificato il 18-9-17 //--- calcolo del tempo totale impiegato dal barcode per compiere il trattamento in impianto ((GiriF1 * C1 * 8 * Tbase)  + (GiriF2 * C2 *8 * Tbase))
//--- modificato il 18-9-17 
//--- calcolo del tempo totale impiegato dal barcode per compiere un giro di trattamento in impianto ((C1 * Tbase)  + (C2 * Tbase))
				k_giro_insecondi = kst_tab_imptime.tminute * 60 + kst_tab_imptime.tsecond 
				k_time_fila_1 = (kst_tab_barcode.lav_fila_1 + kst_tab_barcode.lav_fila_1p) * k_giro_insecondi * kst_tab_imptime.fila_1_tcoeff //18-9-17 * 8
				k_time_fila_2 = (kst_tab_barcode.lav_fila_2 + kst_tab_barcode.lav_fila_2p) * k_giro_insecondi * kst_tab_imptime.fila_2_tcoeff //18-9-17 * 8
//--- 18-9-17 calcolo del tempo medio impiegato dal barcode per compiere il trattamento in impianto x uno step 
//				k_time_fila_1 = k_giro_insecondi * kst_tab_imptime.fila_1_tcoeff * 8
//				k_time_fila_2 = 0
				kst_tab_barcode.imptime_second = long((k_time_fila_1 + k_time_fila_2) &
				     / (kst_tab_barcode.lav_fila_1 + kst_tab_barcode.lav_fila_1p + kst_tab_barcode.lav_fila_2 + kst_tab_barcode.lav_fila_2p))
				
				set_imptime_second(kst_tab_barcode)  // UPDATE!
				
			end if
		end if
		
	else
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlerrtext = "Aggiornamento Tempi Impianto Barcode non eseguito, codice non indicato"
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kguo_exception
	
finally					
	if isvalid(kuf1_ausiliari) then destroy kuf1_ausiliari

end try

return k_return


end function

public function boolean set_imptime_second (ref st_tab_barcode ast_tab_barcode) throws uo_exception;/*
 Aggiorna imptime_second in tabella
 	Inp: st_tab_barcode.barcode + imptime_second
*/
boolean k_return


try
	
	kguo_exception.inizializza(this.classname())

//	if_sicurezza(kkg_flag_modalita.inserimento) 

	if trim(ast_tab_barcode.barcode) > " " then 

		ast_tab_barcode.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_barcode.x_utente = kGuf_data_base.prendi_x_utente()
		
		update barcode set 	 
					 imptime_second = :ast_tab_barcode.imptime_second
					,x_datins = :ast_tab_barcode.x_datins  
					,x_utente = :ast_tab_barcode.x_utente 
				where barcode = :ast_tab_barcode.barcode
				using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
						"Errore in aggiornamento Tempi Impianto di lavorazione sul Barcode " + trim(ast_tab_barcode.barcode) &
						+ ", tempo " + string(ast_tab_barcode.imptime_second))
			kguo_sqlca_db_magazzino.db_rollback()
			throw kguo_exception
		end if
			
		if ast_tab_barcode.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_barcode.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit()
		end if
		
		k_return = true
	else
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.kist_esito.sqlerrtext = "Aggiornamento Tempi Impianto Barcode non eseguito, codice non indicato"
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally					

end try

return k_return


end function

public function long get_g3lav_ciclo_firstbarcode (ref st_tab_barcode ast_tab_barcode) throws uo_exception;/*
 Estrae g3lav_ciclo del primo barcode che ha iniziato il trattamento
	Inp: st_tab_barcode id_meca 
	Out/Rit: st_tab_barcode g3lav_ciclo
*/
long k_return 


	kguo_exception.inizializza(this.classname())

	if ast_tab_barcode.id_meca > 0 then

		select top(1) g3lav_ciclo
			into :ast_tab_barcode.g3lav_ciclo
			from barcode
			where id_meca = :ast_tab_barcode.id_meca 
					and CAST(barcode.data_lav_ini AS datetime) + CAST(barcode.ora_lav_ini AS datetime) = 
					  (select min(CAST(b1.data_lav_ini AS datetime) + CAST(b1.ora_lav_ini AS datetime) ) from barcode b1 
					          where b1.id_meca = :ast_tab_barcode.id_meca 
										 and b1.data_lav_ini > '01.01.2000')
			using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in lettura Tempi Ciclo del primo Barcode entrato in lavorazione, id Lotto " + string(ast_tab_barcode.id_meca))
			throw kguo_exception
		end if
		
		k_return = ast_tab_barcode.g3lav_ciclo
		
	end if			

return k_return

end function

public function date get_data_lav_fin (ref st_tab_barcode kst_tab_barcode) throws uo_exception;/*
 Estrae data di Fine lav piu' vecchia per id_meca  
	Inp: st_tab_barcode id_meca ed eventalmente pl_parcode
	Out/Rit: st_tab_barcode la data_lav_fin 
*/

	kguo_exception.inizializza(this.classname())

	if kst_tab_barcode.pl_barcode > 0 then
		select distinct
					max(data_lav_fin)
			into
				 :kst_tab_barcode.data_lav_fin
			from barcode
			where id_meca = :kst_tab_barcode.id_meca 
				and pl_barcode =  :kst_tab_barcode.pl_barcode 
				and data_lav_fin > '01.01.2000'
			using kguo_sqlca_db_magazzino;
	else
		select distinct
					max(data_lav_fin)
			into
				 :kst_tab_barcode.data_lav_fin
			from barcode
			where id_meca = :kst_tab_barcode.id_meca 
				and data_lav_fin > '01.01.2000'
			using kguo_sqlca_db_magazzino;
	end if			

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in lettura dati tab BARCODE, id Lotto " + string(kst_tab_barcode.id_meca))
		throw kguo_exception
	end if
		
	if kst_tab_barcode.data_lav_fin > date(2000,01,01) then
	else			
		kst_tab_barcode.data_lav_fin = date(0)	
	end if		

return kst_tab_barcode.data_lav_fin


end function

private function st_esito tb_update_json (ref st_tab_barcode ast_tab_barcode) throws uo_exception;/*
 Update/Insert the row in Barcode campo JSON: data_json
    Inp: st_tab_barcode.barcode + con i campi jsoc
*/
int k_idx, k_idx_max
string k_json_key[100]
string k_json_val[100]


	try
		kguo_exception.inizializza(this.classname())
		
		if ast_tab_barcode.barcode > " " then
	
	//--- pulizia di tutto il campo JSON
			update barcode
				 set data_json = '{}'
						where barcode = :ast_tab_barcode.barcode and (data_json = '' or data_json is null)
						using kguo_sqlca_db_magazzino ;
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
							"Fallita pulizia area dati vari (data_json) del Barcode " + string(ast_tab_barcode.barcode))
				throw kguo_exception
			end if

	//--- compone i campi JSON					
			k_idx_max = 0
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "g3lav_cicloin"; k_json_val[k_idx_max] = string(ast_tab_barcode.g3lav_cicloin, "#0")
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "g3lav_cicloout"; k_json_val[k_idx_max] = string(ast_tab_barcode.g3lav_cicloout, "#0")

			kguo_sqlca_db_magazzino.sqlcode = 0
			k_idx = 0
			do while k_idx < k_idx_max and kguo_sqlca_db_magazzino.sqlcode = 0 
				k_idx ++
				
				if not isnull(k_json_val[k_idx]) then
					update barcode
						 set data_json = replace(JSON_MODIFY(data_json, :k_json_key[k_idx], :k_json_val[k_idx]), '\/', '/')
						where barcode = :ast_tab_barcode.barcode
						using kguo_sqlca_db_magazzino ;
				end if
				
			loop
			
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, &
							"Fallito Aggiornamento area dati vari (data_json) del Barcode " + string(ast_tab_barcode.barcode) &
								+ ", campo: " + k_json_key[k_idx] &
								+ " valore: "+ k_json_val[k_idx] + ". ")
				throw kguo_exception
			end if

			if ast_tab_barcode.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_barcode.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			
		end if
		
	catch	(uo_exception kuo_exception)
		kuo_exception.scrivi_log( )
		if kuo_exception.kist_esito.esito = kkg_esito.db_ko then
			if ast_tab_barcode.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_barcode.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		end if
		throw kuo_exception
	
	finally
	
	end try
		


return kguo_exception.kist_esito

end function

public subroutine u_update_campo (ref st_tab_barcode kst_tab_barcode, string k_campo) throws uo_exception;/*
    Update un campo del rek Piano Lavorazione Barcode
*/
st_esito kst_esito


	kst_esito = tb_update_campo(kst_tab_barcode, k_campo)

	if kst_esito.esito = kkg_esito.ok and k_campo = "data_lav_ini" then
		if kst_tab_barcode.g3lav_ciclo > 0 then
			tb_update_json(kst_tab_barcode)  // aggiorna i campi JSON
		end if
	end if

//--- se verificato errore					
	if kst_esito.esito = kkg_esito.db_ko &
					or kst_esito.esito = kkg_esito.no_esecuzione then
		
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_barcode.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		end if
		
		kguo_exception.inizializza(this.classname())
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
			
	end if
	

end subroutine

on kuf_barcode.create
call super::create
end on

on kuf_barcode.destroy
call super::destroy
end on

event constructor;call super::constructor;//
ki_msgerroggetto = "Barcode"

end event

