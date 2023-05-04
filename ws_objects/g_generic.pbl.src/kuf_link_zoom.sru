$PBExportHeader$kuf_link_zoom.sru
forward
global type kuf_link_zoom from nonvisualobject
end type
end forward

global type kuf_link_zoom from nonvisualobject
end type
global kuf_link_zoom kuf_link_zoom

forward prototypes
public function string get_link_da_button (string a_button)
public subroutine link_standard_imposta_p (readonly datawindow adw_1)
public function boolean link_standard_call_p (ref datawindow adw_link, string a_nome_link) throws uo_exception
private function integer get_len_nome (string k_nome_cliccato)
end prototypes

public function string get_link_da_button (string a_button);//-----------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- Converte il link del BUTTON in un link riconosciuto come funzione da attivare
//--- Input:   a_button    = button pigiato
//---             
//--- Output: Link riconosciuto
//---             spazio = nesuna funzione riconosciuta
//---
//-----------------------------------------------------------------------------------------------------------------------------------------------
//
string k_return = " "


if left(a_button, 6) = "p_img_" or left(a_button, 4) = "img_" then
	a_button = replace(a_button, 1, 6, "b_")
end if

choose case a_button
		
	case "b_meca", "b_id_meca"
		k_return = "id_meca"
		
	case "b_barcode_dett"		
		k_return = "barcode"

//	case "b_barcode_figli"		
//		k_return = "barcode_figli"
		
	case "b_barcode" 
		k_return = "b_barcode_lotto"

	case "b_armo"
		k_return = "id_armo"

	case "b_arsp" 
		k_return = "b_arsp_lotto"
		
	case "b_arfa" 
		k_return = "b_arfa_lotto"
		
	case "b_fatt"
		k_return = "num_fatt"
		
//	case "b_fatt_righe"
//		k_return = "b_fatt_righe"
		
	case "b_certif" 
		k_return = "b_certif_lotto"
		
	case "b_cliente" 
		k_return = "id_cliente" 
		
//	case "b_clie_1" 
//		k_return = "clie_1" 
//	case "b_clie_2" 
//		k_return = "clie_2" 
//	case "b_clie_3" 
//		k_return = "clie_3" 
	
//	case "b_sl_pt" 
//		k_return = "sl_pt"
		
	case "b_contratto" 
		k_return = "contratti_codice"

//	case "b_sc_cf" 
//		k_return = "sc_cf"
//
//	case "b_art" 
//		k_return = "art"

	case "b_listino" 
		k_return = "id_listino"

	case "b_utente" 
		k_return = "x_utente"
		
	case "b_ric" 
		k_return = "id_ric"

	case "b_sped" 
		k_return = "num_bolla_out"
		
	case "b_contratto_rd" 
		k_return = "id_contratto_rd"
		
	case "b_gruppo"
		k_return = "gruppo"
		
	case "b_listino_pregruppo"
		k_return = "id_listino_pregruppo"

//	case "b_qtna_note"
//		k_return = "b_qtna_note"

//	case "b_id_meca_righe", "b_sl_pt_dosimpos", "b_meca_reportpilota_id_meca", "b_sr_settore_utenti_l" 
//		k_return = mid(a_button,3)
//
//	case "b_meca_dosim_barcode"
//		k_return = "meca_dosim_barcode"
//
//	case "b_flg_dosimetro"  
//		k_return = "flg_dosimetro"
//
//	case "b_flg_dosimetro"  
//		k_return = "flg_dosimetro"

	case "b_ric_lotto", "b_cap_l",  "b_nazioni_l",  "b_clie_settori",  "b_clie_classi", "b_contab", "b_cliente_mkt", "b_cliente_web", "b_armo_prezzi" & 
		, "b_arsp_sped", "b_m_r_f", "b_elenco_clienti_del_contatto", "b_wm_pklist_righe", "b_docprod", "b_listino_link_pregruppi", "b_listino_pregruppi"&
		, "b_contratti", "b_contratti_l" &
		, "b_meca_causali_l", "b_art_l", "p_memo", "p_memo_link", "b_clienti","p_clienti_memo_elenco", "p_meca_memo_elenco"&
		, "p_id_memo", "p_id_memo_no" &
		, "b_arfalistaxcontr", "b_qtna_note" &
		, "b_barcode_dosim_l", "b_meca_dosim_barcode_l", "b_dosim_lotto_dosim_l" &
		, "b_asn", "b_e1doco_lav", "b_e1apid_dett", "b_certif_stampa", "b_contratto_doc_dettaglio" &
		, "p_memo_alarm_certif" &
		, "p_memo_alarm_ddt" &
		, "cb_clienti_cntdep_l" &
		, "b_clie_1_l" , "b_clie_2_l", "b_clie_3_l" &
		, "b_email_rubrica" &
	   , "b_asdrackbarcode", "b_asdrackbarcode_1"
		k_return = a_button
		
		
	case else
		if left(a_button,2) = "b_" then
			k_return = mid(a_button,3)
		else
			k_return = ""
		end if
		
end choose

return k_return


end function

public subroutine link_standard_imposta_p (readonly datawindow adw_1);//
//--- link_standard_imposta
//--- Imposta nel DW i "Link Standard" ovvero il campo blu sottolinato con "manina" come cursore
//
//---
int k_num_colonne_nr, k_ctr=1, k_len
string k_num_colonne, k_nome, k_nome_orig


	k_num_colonne = adw_1.Object.DataWindow.Column.Count
	if isnumber(k_num_colonne) then
		k_num_colonne_nr = integer(k_num_colonne)
	else
		k_num_colonne_nr = 99
	end if
	do 
			k_nome_orig=trim(lower(adw_1.Describe("#" + trim(string(k_ctr,"###"))+".name")))
			
			k_len = get_len_nome(k_nome_orig)
			k_nome = mid(k_nome_orig, 1, k_len)
			choose case k_nome

//--- se LINK standard (sottolinea il campo)
				case "clie", "cod_cli", "id_cliente", "id_cliente_link" &
					, "id_contatto" &   
					 ,"barcode","barcode_lav", "cod_sl_pt", "sl_pt" &
					 ,"contratto", "id_contratto", "sc_cf", "mc_co" &
					 ,"barcode_figli" &
					 ,"art", "cod_art" &
					 ,"id_listino", "id_listino_voce" &
					 ,"id_meca", "meca_id", "lotto_id" &
					 ,"id_armo" &
					 ,"x_utente"  &
					, "x_utente_cert_alim" &
					, "x_utente_cert_farm" &
					, "x_utente_cert_f_st" &
					, "id_ric" &
					, "num_bolla_out" &
					, "id_sped" &
					, "email", "sito_web" &
					, "id_contratto_rd" &
					, "id_contratto_co" &
					, "id_contratto_doc" &
					, "id_wm_pklist" &
					, "id_wm_pklist_padre" &
					, "idpkl" &
					, "esito_operazioni_ts_operazione"  &
					, "gruppo" &
					, "id_clie_settore" &
					, "gru" &
					, "num_certif"  &
					, "id_docprod"  &
					, "id_armo_prezzo" & 
					, "id_listino_pregruppo" &
					, "listino_id_parent" &
					, "id_memo" & 
					, "e1doco" & 
					, "e1rorn" &
					, "packinglistcode" &
					, "allegati_cartella" &
					,"doc_root" &
					,"fgrp_out_path" &
					,"dir_report_pilota" &
					,"report_export_dir" &
					,"aco_exp_regcdp_dir" &
					,"e1_certif_saved_dir", "dir_cust_packing_in", "url_cust_packing_in", "k_packingformin_pathfile" &
					,"smart_pickup_lots_dir" &
					,"path_centrale" &
					,"dir_fatt" &
					,"path_file_pilota" &
					,"clie_1_l" , "clie_2_l", "clie_3_l" &
					,"sr_settore_utenti_l", "sr_settore", "id_sr_utente", "id_utenti" &
					,"n_ptask", "n_ptask_x", "id_ptask" &
					,"b_asdslpt_l", "p_add_asdtype"  &
					,"id_asddevice" &
					,"k_hyperlink", "url"
					
					
//--- se e' del tipo grid o tabular link sul valore alrimenti sul testo		
					if adw_1.Object.DataWindow.Type <> "Form" then
						
//						adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
//									  ".Font.Underline = 1")
						adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
									  ".Color = '" + string(kkg_colore.link)+"' ")
						adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
									  ".pointer = 'HyperLink!' " )
					else
//--- ..... alrimenti sul testo		
//						adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//									  ".Font.Underline = 1")
						adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
									  ".Color = '" + string(kkg_colore.link)+"' ")
						adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
									  ".pointer = 'HyperLink!' " )
					end if

				case  "mc_co",  "contratti_codice", "id_contratto"
					
					if adw_1.Object.DataWindow.Type <> "Form" then
						if trim(adw_1.Describe("contratti_codice.x")) <> "!" &
							or trim(adw_1.Describe("id_contratto.x")) <> "!" then 
							adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kkg_colore.link)+"' ")
							adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					else
						if trim(adw_1.Describe("contratti_codice_t.x")) <> "!" &
								or trim(adw_1.Describe("id_contratto_t.x")) <> "!" then 
							adw_1.Modify(k_nome+ "_t" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kkg_colore.link)+"' ")
							adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					end if

				
				case "num_int"
//--- per farlo diventare un link ho bisogno anche del campo "id_meca"

					if adw_1.Object.DataWindow.Type <> "Form" then
						if trim(adw_1.Describe("id_meca.x")) <> "!" then 
//							adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
//										  ".Font.Underline = 1")
							adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kkg_colore.link)+"' ")
							adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					else
						if trim(adw_1.Describe("num_int_t.x")) <> "!" then 
//							adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//										  ".Font.Underline = 1")
							adw_1.Modify(k_nome+ "_t" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kkg_colore.link)+"' ")
							adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					end if
					
				case "num_fatt"  //, "data_fatt" 
					if adw_1.Object.DataWindow.Type <> "Form" then
						if trim(adw_1.Describe("num_fatt.x"))  <> "!" then 
//							adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
//										  ".Font.Underline = 1")
							adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kkg_colore.link)+"' ")
							adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					else
						if trim(adw_1.Describe("num_fatt.x"))  <> "!" then 
//							adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//										  ".Font.Underline = 1")
							adw_1.Modify(k_nome+ "_t" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kkg_colore.link)+"' ")
							adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					end if
					

				
			end choose

		k_ctr = k_ctr + 1 

	loop while k_ctr <= k_num_colonne_nr 
end subroutine

public function boolean link_standard_call_p (ref datawindow adw_link, string a_nome_link) throws uo_exception;//
//--- Chiama le window con funzione standard di consultazione
//--- Input:   	adw_link   		= data_window su cui ho fatto click e quindi dalla quale prelevare i dati ad esmpio il 'ID' del record 
//---				a_nome_link  	= tipo di funzione standard da chiamare
//---             
//--- Output: boolean TRUE = ok e' entrato in funzione; FALSE=non ha fatto niente
//
boolean k_return=true
string k_nome_link
int k_len
kuf_parent kuf1_parent
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)

st_open_w kst_open_w 
datastore kdsi_elenco_output   //ds da passare alla windows di elenco


if NOT isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore //destroy kdsi_elenco_output

k_len = get_len_nome(a_nome_link)
k_nome_link = mid(a_nome_link, 1, k_len)

choose case k_nome_link
		
	case "barcode", "barcode_t", "barcode_lav" &
		,"barcode_figli", "barcode_figli_t" &
		,"b_barcode_lotto" &
		,"grp"
		kuf1_parent = create using "kuf_barcode_tree"
		
	case "num_int", "num_int_t", "id_meca", "b_armo", "id_armo", "id_meca_righe", "b_armo_prezzi", "id_armo_prezzo", "p_meca_memo_elenco" &
			, "b_armo_prezzi_xstato", "meca_id", "lotto_id" &
			, "meca_1_print"
		kuf1_parent = create using "kuf_armo_tree"

	case "b_qtna_note"
		kuf1_parent = create using "kuf_meca_qtna"
		
	case "b_arfa_lotto", "num_fatt", "b_fatt_righe", "b_arfalistaxcontr"
		kuf1_parent = create using "kuf_fatt"

	case "b_arsp_lotto", "b_arsp_sped", "num_bolla_out", "num_bolla_out_1", "arsp_insped", "id_sped"
		kuf1_parent = create using "kuf_sped"
		
	case "clie", "cod_cli", "id_cliente", "id_cliente_1", "id_cliente_link", "b_cliente_mkt", "b_cliente_web", "b_m_r_f", "id_contatto", "b_elenco_clienti_del_contatto" &    
			,"email", "sito_web", "b_clienti", "p_clienti_memo_elenco" &
			, "b_clie_1_l" , "b_clie_2_l", "b_clie_3_l" &
			, "clie_1_l" , "clie_2_l", "clie_3_l" 
		kuf1_parent = create using "kuf_clienti"
		
	case "id_contratto_rd" 
		kuf1_parent = create using "kuf_contratti_rd"
		
	case "id_contratto_co" 
		kuf1_parent = create using "kuf_contratti_co"
		
	case "id_contratto_doc", "b_contratto_doc_dettaglio" 
		kuf1_parent = create using "kuf_contratti_doc"
		
	case "num_certif"  &
			,"b_certif_lotto" &
			,"b_certif_stampa"
		kuf1_parent = create using "kuf_certif"
		
	case "cod_sl_pt", "sl_pt", "sl_pt_dosimpos"
		kuf1_parent = create using "kuf_sl_pt"

	case "id_listino", "id_listino_voce" &
			,"id_listino_voce" &
			,"listino_id_parent"
		kuf1_parent = create using "kuf_listino"

	case "b_listino_link_pregruppi" 
		kuf1_parent = create using "kuf_listino_link_pregruppi"

	case "b_listino_pregruppi", "id_listino_pregruppo" 
		kuf1_parent = create using "kuf_listino_pregruppo"

	case "contratto", "mc_co", "contratti_codice",  "sc_cf", "cf", "b_contratti", "b_contratti_l", "id_contratto"
		kuf1_parent = create using "kuf_contratti"

	case "art", "cod_art", "b_art_l"
		kuf1_parent = create using "kuf_prodotti"

	case "x_utente" &
		, "x_utente_cert_alim" &
		, "x_utente_cert_farm" &
		, "x_utente_cert_f_st" &
		, "sr_settore_utenti_l" &
		, "sr_settore" &
		, "id_sr_utente", "id_utenti" 
		kuf1_parent = create using "kuf_sr_sicurezza"

	case "id_ric", "b_ric_lotto" 
		kuf1_parent = create using "kuf_ricevute"
		
	case "b_contab" 
		kuf1_parent = create using "kuf_prof"

	case "id_wm_pklist", "b_wm_pklist_righe", "id_wm_pklist_riga", "id_wm_pklist_padre", "idpkl"
		kuf1_parent = create using "kuf_wm_pklist"

	case "esito_operazioni_ts_operazione" 
		kuf1_parent = create using "kuf_esito_operazioni"

	case "id_docprod", "b_docprod", "id_docprod_file" 
		kuf1_parent = create using "kuf_docprod"

	case "p_memo", "id_memo", "p_id_memo_no", "p_id_memo", "p_memo_x"
		kuf1_parent = create using "kuf_memo"

	case "id_meca_memo"
		kuf1_parent = create using "kuf_meca_memo"
		
	case "p_memo_alarm_certif", "p_memo_alarm_ddt"
		kuf1_parent = create using "kuf_memo_allarme"
		
	case "p_memo_link", "id_memo_link"
		kuf1_parent = create using "kuf_memo_link"
		
	case "b_barcode_dosim_l", "b_meca_dosim_barcode_l", "meca_dosim_barcode" &
			, "b_meca_dosim_barcode", "flg_dosimetro" 
		kuf1_parent = create using "kuf_meca_dosim"

	case "b_cap_l", "b_clie_settori", "b_clie_classi", "b_nazioni_l", "gruppo", "id_clie_settore" &
			,"b_meca_causali_l", "b_dosim_lotto_dosim_l" 
		kuf1_parent = create using "kuf_ausiliari"

	case "b_asn", "e1doco", "e1rorn", "b_e1doco_lav", "b_e1apid_dett"
		kuf1_parent = create using "kuf_e1"
		
	case "packinglistcode"
		kuf1_parent = create using "kuf_wm_receiptgammarad"
		
	case "meca_reportpilota_id_meca"
		kuf1_parent = create using "kuf_meca_reportpilota"
		
	case "cb_clienti_cntdep_l"
		kuf1_parent = create using "kuf_clienti_cntdep"
		
	case "sv_eventi_sked"
		kuf1_parent = create using "kuf_sv_skedula"
		
	case "allegati_cartella" &
			,"doc_root" &
			,"fgrp_out_path" &
			,"dir_report_pilota" &
			,"report_export_dir" &
			,"aco_exp_regcdp_dir" &
			,"e1_certif_saved_dir" &
			,"smart_pickup_lots_dir", "dir_cust_packing_in", "k_packingformin_pathfile" &
			,"path_centrale" &
			,"dir_fatt" &
			,"path_file" &
			,"file_errorlog"
		kuf1_parent = create using "kuf_folder_open"

	case "meca_ddt_in_view_all", "meca_ddt_in_add"
		kuf1_parent = create using "kuf_meca_ddt_in"
		
	case "b_email_rubrica"
		kuf1_parent = create using "kuf_email_invio"
		
	case "n_ptask", "n_ptask_x", "id_ptask"
		kuf1_parent = create using "kuf_ptasks"
		
	case "b_asdrackbarcode", "b_asdrackbarcode_1" &
	 	, "id_asdrackcode", "id_asddevice", "id_asdrackbarcode"
		kuf1_parent = create using "kuf_asd_zoom"
		
	case "k_hyperlink", "url_cust_packing_in", "url"
		kuf1_parent = create using "kuf_webbrowser"

	case else
		k_return = false
		
end choose

if k_return then
	k_return = kuf1_parent.link_call( adw_link, a_nome_link )
end if
	
SetPointer(kp_oldpointer)

	
return k_return


end function

private function integer get_len_nome (string k_nome_cliccato);//
//--- calcola quanto c'è da prendere dalla stringa es. "id_meca_1" torna la lunghezza per "id_meca" ovvero 7
//
int k_len


	if left(k_nome_cliccato, 9) = "path_file" then // se inizia per "path_file" allora accorcia
		k_len = 9
	else
		k_len = len(k_nome_cliccato)
		if isnumber(mid(k_nome_cliccato, k_len, 1)) then // se con un numero allora accorcia
			k_len --
			if isnumber(mid(k_nome_cliccato, k_len, 1)) then // se con un numero allora accorcia
				k_len --
			end if
			if mid(k_nome_cliccato, k_len, 1) = "_" then // se c'e' un "_" (underscore) allora accorcia
				k_len --
			end if
		end if
	end if

return k_len
end function

on kuf_link_zoom.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_link_zoom.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

