$PBExportHeader$kuf_barcode_stampa.sru
forward
global type kuf_barcode_stampa from kuf_parent
end type
end forward

global type kuf_barcode_stampa from kuf_parent
end type
global kuf_barcode_stampa kuf_barcode_stampa

type variables
//--- id streamer della stampa etichette
public longlong ki_id_print_etichette=0 
private longlong ki_id_print_etichette_last
public boolean ki_stampa_etichetta_autorizza = false

//--- contatore etichette nella pagina (probabile al max 2 o 4)
private int ki_num_etichetta_in_pag=0 
st_tab_barcode kist_tab_barcode_stampa_save

//--- formato di Stampa
//public constant string barcode_modulo_4xpagina = "4"
//public constant string barcode_modulo_2xpagina = "2"
public constant string barcode_modulo_etich_2019 = "A"

//--- font in uso nelle stampe
//private int ki_font[9,3]
private string ki_font_name[11] 
private st_barcode_stampa kist_barcode_stampa

//--- la stampante originale
private string ki_stampante_originale

//--- Ds di stampa
private ds_barcode_print_label kids_barcode_print_label[], kids_barcode_print_label_NULL[]
//--- Ultimo ID_MECA del barcode stampato
private long ki_id_meca


end variables

forward prototypes
private subroutine stampa_barcode_f (string k_barcode, long k_id_print, integer k_coord_x, integer k_coord_y, integer k_altezza_cb, integer k_id_font)
public subroutine stampa_etichetta_riferimento_autorizza ()
public subroutine stampa_etichetta_riferimento_close ()
public subroutine u_set_font_default ()
public function integer stampa_etichetta_riferimento (string k_barcode, long k_id_meca)
private subroutine stampa_testo_verticale (string a_testo_verticale, integer a_inizio_riga, integer a_inizio_col, integer a_col_riga, integer a_col_col)
private function boolean stampa_etichetta_dosimetro (st_tab_barcode kst_tab_barcode_padre, st_tab_base kst_tab_base, st_tab_sl_pt kst_tab_sl_pt, ref st_barcode_stampa kst_barcode_stampa, ref uo_ds_std_1 ads_meca_dosim_barcode_prg)
private subroutine stampa_barcode (string k_barcode, longlong k_id_print, integer k_coord_x, integer k_coord_y, integer k_altezza_cb)
public function boolean stampa_etichetta_riferimento_open (long a_id_meca, boolean a_ristampa)
public function integer stampa_etichetta_riferimento_campioni (long a_id_meca) throws uo_exception
private function integer u_exec_post_stampa_set_pkl (ref st_tab_barcode ast_tab_barcode)
private subroutine u_exec_post_stampa_set_prezzi (ref st_tab_armo ast_tab_armo)
public subroutine u_exec_post_stampa (st_tab_barcode ast_tab_barcode) throws uo_exception
public function boolean old_stampa_etichetta_riferimento_2xpag (st_barcode_stampa kst_barcode_stampa)
public function boolean old_stampa_etichetta_riferimento_x_2xpag (st_barcode_stampa kst_barcode_stampa)
public function boolean old_stampa_etichetta_riferimento_1_4xpag (st_barcode_stampa kst_barcode_stampa)
public function boolean old_stampa_etichetta_riferimento_x_1_4xp (st_barcode_stampa kst_barcode_stampa)
public function boolean stampa_etichetta_riferimento_r3_2019may (st_barcode_stampa kst_barcode_stampa)
private function boolean stampa_etichetta_dosimetro_rev3 (ref ds_barcode_print_label ads_barcode_print_label, st_tab_meca_dosim kst_tab_meca_dosim, st_tab_barcode kst_tab_barcode_padre, st_tab_base kst_tab_base, st_tab_sl_pt kst_tab_sl_pt, ref st_barcode_stampa kst_barcode_stampa, st_tab_sl_pt_dosimpos kst_tab_sl_pt_dosimpos, ref uo_ds_std_1 ads_meca_dosim_barcode_prg)
public function boolean old_stampa_etichetta_riferimento_r4_2024 (st_barcode_stampa kst_barcode_stampa)
public function integer stampa_etichetta_riferimento_avvertenze (string k_barcode, long k_id_meca)
public function boolean stampa_etichetta_riferimento_avv_rev1 (st_barcode_stampa ast_barcode_stampa, ref uo_ds_std_1 ads_ds_contratti_et_bcode_note_l)
public function boolean stampa_etichetta_riferimento_avv_rev2 (ref ds_barcode_print_label ads_barcode_print_label, st_barcode_stampa ast_barcode_stampa, ref uo_ds_std_1 ads_ds_contratti_et_bcode_note_l)
public function integer stampa_etichetta_riferimento_rev4 (ref ds_barcode_print_label ads_barcode_print_label, st_barcode_stampa ast_barcode_stampa)
private function boolean stampa_etichetta_dosimetro_rev2 (st_tab_meca_dosim kst_tab_meca_dosim, st_tab_barcode kst_tab_barcode_padre, st_tab_base kst_tab_base, st_tab_sl_pt kst_tab_sl_pt, ref st_barcode_stampa kst_barcode_stampa, st_tab_sl_pt_dosimpos kst_tab_sl_pt_dosimpos, ref uo_ds_std_1 ads_meca_dosim_barcode_prg)
private function integer u_get_idx_ds_barcode_print_label (string a_dataobject_x_label, long a_id_meca)
private subroutine u_create_report_barcode_et ()
public function integer stampa_etichetta_riferimento_dastampare (string k_barcode, long k_id_meca) throws uo_exception
end prototypes

private subroutine stampa_barcode_f (string k_barcode, long k_id_print, integer k_coord_x, integer k_coord_y, integer k_altezza_cb, integer k_id_font);//
// stampa codice a barre standard CODE 39
// utilizza il font 
// 3OF9_NEW.TTF (3 of 9 Barcode)
//
// 1'' (inches) = 2,54 cm 
// CODE 3/9:
// lungo 13 caratteri
// ogni carattere è composto da 5 barre e 4 spazi (=9 elementi)
// ogni elemento può essere fine o grosso (narrow o wide)
// 3 dei 9 elementi deve essere wide (ecco xchè si chiama 'code 39')
// la codebar intera è composta da una zona franca di almeno 0,1'' + il carattere di 
// inizio '*' + il codice + il carattere di fine '*' + zona franca di almeno 0,1''
//

string k_open_print="N"
int k_altezza=0, k_coord_y1, k_font_alt=0 
int k_ctr=0



	if k_id_print = 0 or isnull(k_id_print) then
		k_open_print = "S"
	   k_id_print = PrintOpen( )
	end if
	
	if k_coord_x = 0 or isnull(k_coord_x) then
		k_coord_x = 100
	end if
	if k_coord_y = 0 or isnull(k_coord_y) then
		k_coord_y = 100
	end if
	if k_altezza_cb = 0 or isnull(k_altezza_cb) then
		k_font_alt = 24
	else
		k_font_alt = k_altezza_cb
	end if
	k_coord_y1 = k_coord_y 
	
	if k_id_font = 0 or isnull(k_id_font) then
		k_id_font = 1
	end if

	if LenA(trim(k_barcode)) > 0 then

//--- stringa alfanumerica dell'effettivo codice a barre riempita con spazi + uno zero a destra e il crt "*" a inizio e fine
	   k_barcode = "*" + trim(k_barcode) + "*" //fill(" ", (12 - len(trim(k_barcode)))) + "0" + "*"

//--- definizione di un font per la stampa di stringhe
		PrintDefineFont(k_id_print, k_id_font, "3 of 9 Barcode", k_font_alt, 400, Fixed!, Modern!, FALSE, FALSE)

		printtext (k_id_print, k_barcode, k_coord_x, k_coord_y1, 1)
		k_coord_y1 = k_coord_y1 + k_font_alt - 2
		printtext (k_id_print, k_barcode, k_coord_x, k_coord_y1, 1)
		k_coord_y1 = k_coord_y1 + k_font_alt - 2
		printtext (k_id_print, k_barcode, k_coord_x, k_coord_y1, 1)

	end if
	
	if k_open_print = "S" then
		PrintClose(k_id_print)
	end if
	
	u_set_font_default( )  // ripristina i font di default



end subroutine

public subroutine stampa_etichetta_riferimento_autorizza ();//
// stampa dell'etichetta: Controllo Autorizzazione alla stampa 
// return:  set ki_stampa_etichetta_autorizza
//
int k_rc=0
boolean k_abilitato=true
pointer kpointer  // Declares a pointer variable
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w



//=== Puntatore Cursore da attesa.....
	kpointer = SetPointer(HourGlass!)

//
//=== Controlla se funzione Autorizzata o meno 
//
	kst_open_w.id_programma = "stb"
	kst_open_w.flag_modalita = kkg_flag_modalita.stampa
	
	kuf1_sicurezza = create kuf_sicurezza
	k_abilitato = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	if not k_abilitato then
		ki_stampa_etichetta_autorizza = false

		SetPointer(kpointer)
		messagebox("Accesso non Autorizzato", &
					  "La funzione richiesta non e' stata abilitata", &
					  information!)
	else
		ki_stampa_etichetta_autorizza = true
	end if

	SetPointer(kpointer)
	





end subroutine

public subroutine stampa_etichetta_riferimento_close ();//
// stampa dell'etichetta: CLOSE dello streamer di stampa
// return:  set ki_id_print_etichette a zero 
//
int k_rc
int k, k_ds_idx


	SetPointer(kkg.pointer_attesa)

	if ki_id_print_etichette > 0 then   // se streamer stampa Aperto...

//--- In stampa i DS
		u_create_report_barcode_et()
	//		k_ds_idx = upperbound(kids_barcode_print_label[])
	//		for k = 1 to k_ds_idx
	//			PrintDataWindow(ki_id_print_etichette, kids_barcode_print_label[k])
	//		next

		if PrintClose(ki_id_print_etichette) > 0 then
			ki_id_print_etichette = 0
		end if
	end if

	if trim(ki_stampante_originale) > " " then
		k_rc = PrintSetPrinter(ki_stampante_originale)  // Ripristina la stampante originale
		ki_stampante_originale = ""
	end if

	SetPointer(kkg.pointer_default)
	




end subroutine

public subroutine u_set_font_default ();//
//--- Imposta i FONT di DEFAULT 
//

	ki_font_name[1] = "Arial"  
	ki_font_name[2] = "Arial"  
	ki_font_name[3] = "Arial"  
	ki_font_name[4] = "Arial"  
	ki_font_name[5] = "Arial"  
	ki_font_name[6] = "Arial"  
	ki_font_name[7] = "Arial" 
	ki_font_name[8] = "Arial"  
	ki_font_name[9] = "Arial"  
	ki_font_name[10] = "Arial"  
	ki_font_name[11] = "Aachen Vertical"

//---------------------------- nr font --------------------------- size DPI -------------------------- grossezza carattere 400=normale ----
	kist_barcode_stampa.font[1,1] = 1 ; kist_barcode_stampa.font[1,2] = -06 ; kist_barcode_stampa.font[1,3] = 400  
	kist_barcode_stampa.font[2,1] = 2 ; kist_barcode_stampa.font[2,2] = -12 ; kist_barcode_stampa.font[2,3] = 400 
	kist_barcode_stampa.font[3,1] = 3 ; kist_barcode_stampa.font[3,2] = -16 ; kist_barcode_stampa.font[3,3] = 400 //700 
	kist_barcode_stampa.font[4,1] = 4 ; kist_barcode_stampa.font[4,2] = -26 ; kist_barcode_stampa.font[4,3] = 400
	kist_barcode_stampa.font[5,1] = 5 ; kist_barcode_stampa.font[5,2] = -40 ; kist_barcode_stampa.font[5,3] = 500 //700
	kist_barcode_stampa.font[6,1] = 6 ; kist_barcode_stampa.font[6,2] = -32 ; kist_barcode_stampa.font[6,3] = 400 //700  //400=nrmal,700=bold
//
	kist_barcode_stampa.font[7,1] = 7 ; kist_barcode_stampa.font[7,2] = -80 ; kist_barcode_stampa.font[7,3] = 500 //700
	kist_barcode_stampa.font[8,1] = 8 ; kist_barcode_stampa.font[8,2] = -110 ; kist_barcode_stampa.font[8,3] = 400 //600
	kist_barcode_stampa.font[9,1] = 9 ; kist_barcode_stampa.font[9,2] = -10 ; kist_barcode_stampa.font[9,3] = 400  // MA QUESTO NON CREDO FUNZIONI MAX 8!!!
	kist_barcode_stampa.font[10,1] = 10 ; kist_barcode_stampa.font[10,2] = -60 ; kist_barcode_stampa.font[10,3] = 500  // usato ad esempio in 4 etich MAT DA NON TRATTARE
	kist_barcode_stampa.font[11,1] = 11 ; kist_barcode_stampa.font[11,2] = -12 ; kist_barcode_stampa.font[11,3] = 400  // carattere verticale

	
//	if trim(kGuf_data_base.ki_barcode_modulo) = barcode_modulo_4xpagina or trim(kGuf_data_base.ki_barcode_modulo) = barcode_modulo_1etichetta then
//--- definizione di un font per la stampa di stringhe MASSIMO 8
		PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[1,1], ki_font_name[1], kist_barcode_stampa.font[1,2], kist_barcode_stampa.font[1,3], Fixed!, Modern!, FALSE, FALSE) //piccolissimo
		PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[2,1], ki_font_name[2], kist_barcode_stampa.font[2,2], kist_barcode_stampa.font[2,3], Fixed!, Modern!, FALSE, FALSE)
		PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[3,1], ki_font_name[3], kist_barcode_stampa.font[3,2], kist_barcode_stampa.font[3,3], Fixed!, Modern!, FALSE, FALSE)
		PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[4,1], ki_font_name[4], kist_barcode_stampa.font[4,2], kist_barcode_stampa.font[4,3], Fixed!, Modern!, FALSE, FALSE) //grande
		PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[5,1], ki_font_name[5], kist_barcode_stampa.font[5,2], kist_barcode_stampa.font[5,3], Fixed!, Modern!, FALSE, FALSE)
		PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[6,1], ki_font_name[6], kist_barcode_stampa.font[6,2], kist_barcode_stampa.font[6,3], Fixed!, Modern!, FALSE, FALSE)
		PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[7,1], ki_font_name[7], kist_barcode_stampa.font[7,2], kist_barcode_stampa.font[7,3], Fixed!, Modern!, FALSE, FALSE)
		PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[8,1], ki_font_name[8], kist_barcode_stampa.font[8,2], kist_barcode_stampa.font[8,3], Fixed!, Modern!, FALSE, FALSE) //molto grande tipo barcode
		//PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[9,1], ki_font_name[, kist_barcode_stampa.font[9,2], kist_barcode_stampa.font[9,3], Fixed!, Modern!, FALSE, FALSE)
			
//	else		
//
////--- definizione di un font per la stampa di stringhe
//		PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[1,1], ki_font_name[1], kist_barcode_stampa.font[1,2], kist_barcode_stampa.font[1,3], Fixed!, Modern!, FALSE, FALSE)
//		PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[2,1], ki_font_name[2], kist_barcode_stampa.font[2,2], kist_barcode_stampa.font[2,3], Fixed!, Modern!, FALSE, FALSE)
//		PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[3,1], ki_font_name[3], kist_barcode_stampa.font[3,2], kist_barcode_stampa.font[3,3], Fixed!, Modern!, FALSE, FALSE)
//		PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[4,1], ki_font_name[4], kist_barcode_stampa.font[4,2], kist_barcode_stampa.font[4,3], Fixed!, Modern!, FALSE, FALSE)
//		PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[5,1], ki_font_name[5], kist_barcode_stampa.font[5,2], kist_barcode_stampa.font[5,3], Fixed!, Modern!, FALSE, FALSE)
//		PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[6,1], ki_font_name[6], kist_barcode_stampa.font[6,2], kist_barcode_stampa.font[6,3], Fixed!, Modern!, FALSE, FALSE)
//		PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[7,1], ki_font_name[7], kist_barcode_stampa.font[7,2], kist_barcode_stampa.font[7,3], Fixed!, Modern!, FALSE, FALSE)
//		PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[8,1], ki_font_name[8], kist_barcode_stampa.font[8,2], kist_barcode_stampa.font[8,3], Fixed!, Modern!, FALSE, FALSE)
//		//PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[9,1], ki_font_name[9], kist_barcode_stampa.font[9,2], kist_barcode_stampa.font[9,3], Fixed!, Modern!, FALSE, FALSE)
//
//	end if
//

end subroutine

public function integer stampa_etichetta_riferimento (string k_barcode, long k_id_meca);//
// stampa dell'etichetta con il codice a barre di entrata 
// return:  numero di barcode stampati 0=nessuno
//
int k_ds_idx, k
int k_rc=0
string k_nessuna_elab="N"
string k_barcode_x
int k_barcode_altezza=0, k_barcode_coord_x, k_barcode_coord_y
int k_barcode_tot_lotto, k_conta_barcode=0, k_barcode_gia_stampati=0, k_etichette_stampate=0
int k_ctr=0, k_ctr1=0, k_ctr2=0, k_rec_mod=0 //, k_tot_dosimetri
date k_dataoggi 
boolean k_barcode_etichetta_dosimetro_stampata=false
boolean k_chiudi_a_fine_routine
int k_num_righe = 1
int k_num_colonne = 0
//string k_data_cript[0 to 9] = {'A','T','E','L','O','R','I','N','U','S'}
//string k_consegna_data_cript
pointer kpointer  // Declares a pointer variable
kuf_barcode kuf1_barcode
kuf_impianto kuf1_impianto
st_tab_barcode kst_tab_barcode
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_sl_pt kst_tab_sl_pt
st_tab_armo kst_tab_armo
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_contratti kst_tab_contratti
//st_tab_prodotti kst_tab_prodotti
st_tab_base kst_tab_base
st_barcode_stampa kst_barcode_stampa
st_esito kst_esito
uo_ds_std_1 kds_meca_dosim_barcode_prg
datastore kds_dd_sl_pt_tipo


SetPointer(HourGlass!)

declare kc_listview cursor for
	SELECT 
         barcode.id_meca,
         barcode.barcode,
         barcode.barcode_lav,
			barcode.flg_dosimetro,
			barcode.data,
			barcode.pl_barcode,
         barcode.data_stampa,
			barcode.data_lav_ini,
			barcode.data_lav_fin,
			barcode.data_lav_ok,
			barcode.data_sosp,
			armo.dose,
			armo.larg_2,
			armo.lung_2,
			armo.alt_2,
			armo.peso_kg,
			armo.magazzino
    FROM barcode 
			 LEFT OUTER JOIN armo ON 
			 barcode.id_armo = armo.id_armo
    WHERE 
	       barcode.id_meca = :k_id_meca
			 and barcode.barcode like :k_barcode
	 order by
		 barcode.barcode;

//			sl_pt.cod_sl_pt,
//			sl_pt.descr,
//			sl_pt.dosim_et_descr,
//			prodotti.normative
//
//			 LEFT OUTER JOIN sl_pt ON 
//			 armo.cod_sl_pt = sl_pt.cod_sl_pt
//			 LEFT OUTER JOIN prodotti ON 
//			 armo.art = prodotti.codice)

//	       barcode.num_int = meca.num_int and barcode.data_int = meca.data_int)


	declare kc_barcode_conta cursor  for
		SELECT barcode.barcode 
			FROM barcode 
		WHERE barcode.id_meca = :k_id_meca
		order by barcode.barcode using kguo_sqlca_db_magazzino;


try
	
//=== Puntatore Cursore da attesa.....
	kpointer = SetPointer(HourGlass!)

	kuf1_barcode = create kuf_barcode

	k_conta_barcode = 0
	k_barcode_gia_stampati = 0
	k_barcode_tot_lotto = 0
	k_etichette_stampate=0
	kst_tab_barcode.barcode = trim(k_barcode)

	kguo_sqlca_db_magazzino.db_commit( )  // metto anche qui per evitare forse errore in TemporalTable ATTENZIONE LA COMMIT CHIUDE IL CURSOR!!

//=== Controlla se funzione Autorizzata o meno 
	if not ki_stampa_etichetta_autorizza then 
		
		stampa_etichetta_riferimento_autorizza()
		
	end if
	
	if ki_stampa_etichetta_autorizza then

		if isnull(k_barcode) then
			k_barcode = " "
		end if
		
		k_dataoggi = kguo_g.get_dataoggi( )

//---- get dati LOTTO
		SELECT 
					meca.num_int,   
					meca.data_int,   
					meca.data_ent,   
					meca.impianto,
					meca.clie_2, 
					meca.clie_3, 
					meca.num_bolla_in,
					meca.data_bolla_in,
					meca.area_mag,
					meca.consegna_data,
					meca.contratto,
					meca.e1doco,
					meca.e1rorn,
					meca.num_bolla_in,
					meca.data_bolla_in,
					contratti.mc_co,
					contratti.sc_cf,
					contratti.descr,
					contratti.et_bcode_st_dt_rif,
					c2.rag_soc_10,
					c3.rag_soc_10
				into
					 :kst_tab_barcode.num_int   
					 ,:kst_tab_barcode.data_int   
					 ,:kst_tab_meca.data_ent  
					 ,:kst_tab_meca.impianto
					 ,:kst_tab_meca.clie_2  
					 ,:kst_tab_meca.clie_3  
					 ,:kst_tab_meca.num_bolla_in 
					 ,:kst_tab_meca.data_bolla_in 
					 ,:kst_tab_meca.area_mag
					 ,:kst_tab_meca.consegna_data
					 ,:kst_tab_contratti.codice
					 ,:kst_tab_meca.e1doco
					 ,:kst_tab_meca.e1rorn
					 ,:kst_tab_meca.num_bolla_in
					 ,:kst_tab_meca.data_bolla_in
					 ,:kst_tab_contratti.mc_co
					 ,:kst_tab_contratti.sc_cf
					 ,:kst_tab_contratti.descr
					 ,:kst_tab_contratti.et_bcode_st_dt_rif
					 ,:kst_tab_clienti.rag_soc_10 
					 ,:kst_tab_clienti.rag_soc_20 
			 FROM meca
					 LEFT OUTER JOIN clienti c2 ON 
						 meca.clie_2 = c2.codice
					 LEFT OUTER JOIN clienti c3 ON 
						 meca.clie_3 = c3.codice
					 LEFT OUTER JOIN contratti ON 
						meca.contratto = contratti.codice
			 WHERE 
					 meca.id = :k_id_meca
					using kguo_sqlca_db_magazzino;		 
		if kguo_sqlca_db_magazzino.sqlcode < 0 then  
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Lettura Lotto per stampa barcode. Id Lotto " + string(k_id_meca))
			throw kguo_exception
		end if
			
//--- get dati SL_PT
		if kst_tab_meca.impianto = kuf1_impianto.kki_impiantog3 then
			select top(1)
				sl_pt.cod_sl_pt,
				sl_pt.descr,
				sl_pt_g3.dosim_et_descr,
				sl_pt.tipo
			  into :kst_tab_sl_pt.cod_sl_pt 
					 ,:kst_tab_sl_pt.descr 
					 ,:kst_tab_sl_pt.dosim_et_descr 
					 ,:kst_tab_sl_pt.tipo
				from sl_pt inner JOIN sl_pt_g3 on
						sl_pt.cod_sl_pt = sl_pt_g3.cod_sl_pt
							  inner join armo ON 
						armo.cod_sl_pt = sl_pt.cod_sl_pt
							  inner JOIN barcode ON 
						barcode.id_armo = armo.id_armo
				where 	
					 barcode.id_meca = :k_id_meca
				using kguo_sqlca_db_magazzino;
		else
			select top(1)
				sl_pt.cod_sl_pt,
				sl_pt.descr,
				sl_pt.dosim_et_descr,
				sl_pt.tipo
			  into :kst_tab_sl_pt.cod_sl_pt 
					 ,:kst_tab_sl_pt.descr 
					 ,:kst_tab_sl_pt.dosim_et_descr 
					 ,:kst_tab_sl_pt.tipo
				from sl_pt inner JOIN armo ON 
					armo.cod_sl_pt = sl_pt.cod_sl_pt
							  inner JOIN barcode ON 
					barcode.id_armo = armo.id_armo
				where 	
					 barcode.id_meca = :k_id_meca
				using kguo_sqlca_db_magazzino;
		end if
		if kguo_sqlca_db_magazzino.sqlcode < 0 then  
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in Lettura Piano di Trattamento per stampa barcode. Id Lotto " + string(k_id_meca))
			throw kguo_exception
		end if

//--- get descrizione TIPO sl_pt
		if kst_tab_sl_pt.tipo > " " then
			kds_dd_sl_pt_tipo = create datastore
			kds_dd_sl_pt_tipo.dataobject = "dd_sl_pt_tipo"
			k_rc = kds_dd_sl_pt_tipo.find( "tipo = '" + trim(kst_tab_sl_pt.tipo) + "'", 1, kds_dd_sl_pt_tipo.rowcount())
			if k_rc > 0 then
				kst_barcode_stampa.sl_pt_tipo_descr = trim(kds_dd_sl_pt_tipo.getitemstring(k_rc, "descr"))
			end if
		end if
	
//--- Conteggio barcode stampati	
		SELECT count(*)
				into :k_barcode_gia_stampati  
			 FROM barcode 
			 WHERE 
					 barcode.id_meca = :k_id_meca
					 and barcode.data_stampa > convert(date,'01.01.1899') 
					 and (barcode = :k_barcode  or :k_barcode = ' ')
				using kguo_sqlca_db_magazzino;
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			k_barcode_gia_stampati = 0
		end if
	
//--- conto il numero totale di barcode da esporre in etichetta	
		SELECT count(*)
				into :k_barcode_tot_lotto  
			 FROM barcode 
			 WHERE 
					 barcode.id_meca = :k_id_meca 
			 using kguo_sqlca_db_magazzino;

//--- Stampa dell'intero riferimento ?
		k_barcode = trim(k_barcode)
		if LenA(k_barcode) = 0  then
			k_barcode = "%"
		else
//--- se ho richiesto solo la stampa di 1 barcode... faccio solo quella				
//---  e ricavo il numero del barcode in cui sono x fare stampa: n di nn
			open kc_barcode_conta;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				
				do 
					k_conta_barcode++
					fetch kc_barcode_conta into :k_barcode_x;
				loop while trim(k_barcode_x) <> k_barcode and kguo_sqlca_db_magazzino.sqlcode = 0
				
				close kc_barcode_conta;
				
			end if
			
		end if
 
	end if

//--- se query ok e funzione Abilitata
	if kguo_sqlca_db_magazzino.sqlcode = 0 and ki_stampa_etichetta_autorizza then

//--- individuo il tipo modulo x etichette codici a barre da stampare (Revisione dell'etichetta)
		kst_tab_base.barcode_modulo = kGuf_data_base.ki_barcode_modulo  // trim(Mid(kuf1_base.prendi_dato_base( "barcode_modulo"),2))

		open kc_listview;
		
		if kguo_sqlca_db_magazzino.sqlcode = 0 then

			if ki_id_print_etichette = 0 then   // se streamer stampa non ancora open...
				k_chiudi_a_fine_routine = true
				stampa_etichetta_riferimento_open(kst_tab_barcode.id_meca, true)
			end if

			if ki_id_print_etichette = 0 then   // se streamer stampa non open...
				k_nessuna_elab = "S"
			end if
				

			if	k_nessuna_elab <> "S" then
	
//				kst_barcode_stampa.font[1,1] = 1 ; kst_barcode_stampa.font[1,2] = -06 ; kst_barcode_stampa.font[1,3] = 400  
//				kst_barcode_stampa.font[2,1] = 2 ; kst_barcode_stampa.font[2,2] = -12 ; kst_barcode_stampa.font[2,3] = 400 
//				kst_barcode_stampa.font[3,1] = 3 ; kst_barcode_stampa.font[3,2] = -16 ; kst_barcode_stampa.font[3,3] = 400 //700 
//				kst_barcode_stampa.font[4,1] = 4 ; kst_barcode_stampa.font[4,2] = -26 ; kst_barcode_stampa.font[4,3] = 400
//				kst_barcode_stampa.font[5,1] = 5 ; kst_barcode_stampa.font[5,2] = -40 ; kst_barcode_stampa.font[5,3] = 500 //700
//				kst_barcode_stampa.font[6,1] = 6 ; kst_barcode_stampa.font[6,2] = -32 ; kst_barcode_stampa.font[6,3] = 400 //700  //400=nrmal,700=bold
////				kst_barcode_stampa.font[7,1] = 7 ; kst_barcode_stampa.font[7,2] = -86 ; kst_barcode_stampa.font[7,3] = 400 //700
//				kst_barcode_stampa.font[7,1] = 7 ; kst_barcode_stampa.font[7,2] = -80 ; kst_barcode_stampa.font[7,3] = 500 //700
//				kst_barcode_stampa.font[8,1] = 8 ; kst_barcode_stampa.font[8,2] = -110 ; kst_barcode_stampa.font[8,3] = 400 //600
//				kst_barcode_stampa.font[9,1] = 9 ; kst_barcode_stampa.font[9,2] = -10 ; kst_barcode_stampa.font[9,3] = 400  // MA QUESTO NON CREDO FUNZIONI!!!
//				kst_barcode_stampa.font[10,1] = 10 ; kst_barcode_stampa.font[10,2] = -60 ; kst_barcode_stampa.font[10,3] = 500  // MA QUESTO NON CREDO FUNZIONI!!!
//			
////--- definizione dei font per la stampa delle stringhe (MASSIMO 8!!!!!)
//				for k_ctr = 1 to 9
//					
//					PrintDefineFont(ki_id_print_etichette, kst_barcode_stampa.font[k_ctr,1], "Arial", kst_barcode_stampa.font[k_ctr,2], kst_barcode_stampa.font[k_ctr,3], Fixed!, Modern!, FALSE, FALSE) //piccolissimo
//					
//				end for
							
				//????? kds_dd_sl_pt_tipo.retrieve( )
							
				if trim(kst_tab_base.barcode_modulo) = barcode_modulo_etich_2019 then
//--- Imposta i FONT di default
					u_set_font_default( )
					k_barcode_coord_x = (2.0 / 2.54) * 520   //--- (Xcm / coeff di conv x pollici) * migliaia
					k_barcode_coord_y = (7.0 / 2.54) * 580   //--- (Xcm / coeff di conv x pollici) * migliaia
					k_barcode_altezza = (0.6 / 2.54) * 1200   //--- (Xcm / coeff di conv x pollici) * migliaia
				end if

//--- prima lettura fuori ciclo	
				fetch kc_listview 
					into
						  :kst_tab_barcode.id_meca
						 ,:kst_tab_barcode.barcode
						 ,:kst_tab_barcode.barcode_lav
						 ,:kst_tab_barcode.flg_dosimetro
						 ,:kst_tab_barcode.data
						 ,:kst_tab_barcode.pl_barcode 
						 ,:kst_tab_barcode.data_stampa   
						 ,:kst_tab_barcode.data_lav_ini 
						 ,:kst_tab_barcode.data_lav_fin 
						 ,:kst_tab_barcode.data_lav_ok 
						 ,:kst_tab_barcode.data_sosp 
						 ,:kst_tab_armo.dose 
						 ,:kst_tab_armo.larg_2
						 ,:kst_tab_armo.lung_2
						 ,:kst_tab_armo.alt_2
						 ,:kst_tab_armo.peso_kg
						 ,:kst_tab_armo.magazzino
						  ;
//						 ,:kst_tab_sl_pt.cod_sl_pt 
//						 ,:kst_tab_sl_pt.descr 
//						 ,:kst_tab_sl_pt.dosim_et_descr 
//						 ,:kst_tab_prodotti.normative
//						  ;
		
				if isnull(kist_tab_barcode_stampa_save.num_int) then kist_tab_barcode_stampa_save.num_int = 0

				if kguo_sqlca_db_magazzino.sqlcode = 0 then
					//--- recupera le etichette dosimetro per il conteggio
					kds_meca_dosim_barcode_prg = create uo_ds_std_1
					kds_meca_dosim_barcode_prg.dataobject = "ds_meca_dosim_barcode_prg"
					kds_meca_dosim_barcode_prg.settransobject(kguo_sqlca_db_magazzino)
					kds_meca_dosim_barcode_prg.retrieve(kst_tab_barcode.id_meca)
					
				end if
				
//------------------------------------------------------------------------------------------------------------------------------------ CICLO LETTURE
				do while kguo_sqlca_db_magazzino.sqlcode = 0 and k_nessuna_elab <> "S"

//--- contatore delle etichette stampate
					k_etichette_stampate++
				
//--- se ho richiesto la stampa di tutti i barcode
					if k_barcode = "%"  then
						k_conta_barcode++
					end if

					ki_num_etichetta_in_pag ++
						
					k_num_colonne = -150
					k_num_righe = 200

					if isnull(kst_tab_meca.e1doco) then kst_tab_meca.e1doco = 0
					if isnull(kst_tab_meca.e1rorn) then kst_tab_meca.e1rorn = 0

//--- valorizza struttura x stampa etichette
					kst_barcode_stampa.barcode_modulo = trim(kst_tab_base.barcode_modulo)
					kst_barcode_stampa.barcode_tot_lotto = k_barcode_tot_lotto
					kst_barcode_stampa.consegna_data_cript = "" //k_consegna_data_cript
					kst_barcode_stampa.num_colonne = k_num_colonne
					kst_barcode_stampa.num_righe = k_num_righe
					kst_barcode_stampa.conta_barcode = k_conta_barcode
					kst_barcode_stampa.barcode_coord_y = k_barcode_coord_y
					kst_barcode_stampa.barcode_coord_x = k_barcode_coord_x
					kst_barcode_stampa.barcode_altezza = k_barcode_altezza
					kst_barcode_stampa.barcode = trim(kst_tab_barcode.barcode)	
					kst_barcode_stampa.clie_3	= kst_tab_meca.clie_3
					kst_barcode_stampa.clie_2	= kst_tab_meca.clie_2
					kst_barcode_stampa.rag_soc_20 = kst_tab_clienti.rag_soc_20
					kst_barcode_stampa.rag_soc_10 = kst_tab_clienti.rag_soc_10
					kst_barcode_stampa.area_mag =	trim(kst_tab_meca.area_mag)	
					kst_barcode_stampa.num_int = kst_tab_barcode.num_int
					kst_barcode_stampa.data_int = kst_tab_barcode.data_int
					kst_barcode_stampa.data_ent = kst_tab_meca.data_ent
					kst_barcode_stampa.mc_co	= kst_tab_contratti.mc_co	
					kst_barcode_stampa.sc_cf = kst_tab_contratti.sc_cf	
					kst_barcode_stampa.et_bcode_st_dt_rif	= kst_tab_contratti.et_bcode_st_dt_rif
					kst_barcode_stampa.normative = "" //trim(kst_tab_prodotti.normative)	
					kst_barcode_stampa.alt_2 = kst_tab_armo.alt_2	
					kst_barcode_stampa.magazzino = kst_tab_armo.magazzino	
					kst_barcode_stampa.id_meca = kst_tab_barcode.id_meca	
					kst_barcode_stampa.e1doco = kst_tab_meca.e1doco
					kst_barcode_stampa.e1rorn = kst_tab_meca.e1rorn
					kst_barcode_stampa.num_bolla_in = kst_tab_meca.num_bolla_in
					kst_barcode_stampa.data_bolla_in = kst_tab_meca.data_bolla_in
					kst_barcode_stampa.impianto = kst_tab_meca.impianto
						
//--- STAMPA ETICHETTE
					if trim(kst_tab_base.barcode_modulo) = barcode_modulo_etich_2019 then
						
						stampa_etichetta_riferimento_r3_2019may(kst_barcode_stampa)  // rev.3 del 29MAY2019
						
					else		
						
						k_ds_idx = u_get_idx_ds_barcode_print_label("d_barcode_et_rev_4_gen24", k_id_meca)  // recupera il n.array del ds 
						kids_barcode_print_label[k_ds_idx].insertrow(0)
						stampa_etichetta_riferimento_rev4(kids_barcode_print_label[k_ds_idx],kst_barcode_stampa)  // rev.4 del GEN2024
						
						ki_num_etichetta_in_pag = 1
					end if

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//--- Stampare l'etichetta x il DOSIMETRO?					
					if kst_tab_barcode.flg_dosimetro = kuf1_barcode.ki_flg_dosimetro_SI then
						
						k_barcode_etichetta_dosimetro_stampata = true
						if stampa_etichetta_dosimetro(kst_tab_barcode, kst_tab_base, kst_tab_sl_pt, kst_barcode_stampa, kds_meca_dosim_barcode_prg) then
//--- contatore delle etichette stampate
							k_etichette_stampate++
						end if
					end if
					
//--- Aggiorno data di stampa
					kst_tab_barcode.st_tab_g_0.esegui_commit = "N"
					kst_tab_barcode.data_stampa = k_dataoggi
					kuf1_barcode.set_data_stampa(kst_tab_barcode)
//					update barcode
//						set data_stampa = :k_dataoggi
//						 WHERE 
//							 barcode = :kst_tab_barcode.barcode
//						using kguo_sqlca_db_magazzino;
						
//					if kguo_sqlca_db_magazzino.sqlcode >= 0 then
//						kguo_sqlca_db_magazzino.db_commit( )  // metto anche qui per evitare forse errore in TemporalTable
						k_rec_mod++
//					end if

					fetch kc_listview 
							into
						  :kst_tab_barcode.id_meca
						 ,:kst_tab_barcode.barcode
						 ,:kst_tab_barcode.barcode_lav
						 ,:kst_tab_barcode.flg_dosimetro
						 ,:kst_tab_barcode.data
						 ,:kst_tab_barcode.pl_barcode 
						 ,:kst_tab_barcode.data_stampa   
						 ,:kst_tab_barcode.data_lav_ini 
						 ,:kst_tab_barcode.data_lav_fin 
						 ,:kst_tab_barcode.data_lav_ok 
						 ,:kst_tab_barcode.data_sosp 
						 ,:kst_tab_armo.dose 
						 ,:kst_tab_armo.larg_2
						 ,:kst_tab_armo.lung_2
						 ,:kst_tab_armo.alt_2
						 ,:kst_tab_armo.peso_kg
						 ,:kst_tab_armo.magazzino
							;
//						  :kst_tab_barcode.id_meca
//						 ,:kst_tab_barcode.barcode
//						 ,:kst_tab_barcode.barcode_lav
//						 ,:kst_tab_barcode.flg_dosimetro
//						 ,:kst_tab_barcode.data
//						 ,:kst_tab_barcode.pl_barcode 
//						 ,:kst_tab_barcode.num_int   
//						 ,:kst_tab_barcode.data_int   
//					    ,:kst_tab_meca.data_ent
//						 ,:kst_tab_barcode.data_stampa   
//						 ,:kst_tab_barcode.data_lav_ini 
//						 ,:kst_tab_barcode.data_lav_fin 
//						 ,:kst_tab_barcode.data_lav_ok 
//						 ,:kst_tab_barcode.data_sosp 
//						 ,:kst_tab_barcode.impianto
//						 ,:kst_tab_meca.clie_2  
//						 ,:kst_tab_meca.clie_3  
//						 ,:kst_tab_meca.num_bolla_in 
//						 ,:kst_tab_meca.data_bolla_in 
//						 ,:kst_tab_meca.area_mag
// 						 ,:kst_tab_meca.consegna_data
//						 ,:kst_tab_contratti.codice
// 						 ,:kst_tab_meca.e1doco
// 						 ,:kst_tab_meca.e1rorn
// 						 ,:kst_tab_meca.num_bolla_in
// 						 ,:kst_tab_meca.data_bolla_in
//						 ,:kst_tab_contratti.mc_co
//						 ,:kst_tab_contratti.sc_cf
//						 ,:kst_tab_contratti.descr
// 						 ,:kst_tab_contratti.et_bcode_st_dt_rif
//						 ,:kst_tab_clienti.rag_soc_10 
//						 ,:kst_tab_clienti.rag_soc_20 
//						 ,:kst_tab_armo.dose 
//						 ,:kst_tab_armo.larg_2
//						 ,:kst_tab_armo.lung_2
//						 ,:kst_tab_armo.alt_2
//						 ,:kst_tab_armo.peso_kg
//						 ,:kst_tab_armo.magazzino
//						 ;

				loop

////--- se NON ho stampato gia' l'etichetta del Dosimetro allora aggiungo un foglio vuoto se rif cambiato
//				if trim(kst_tab_base.barcode_modulo) = barcode_modulo_etich_2019 then
//					if kist_tab_barcode_stampa_save.num_int <> kst_tab_barcode.num_int then
//						kist_tab_barcode_stampa_save.num_int = kst_tab_barcode.num_int	
//						printtext (ki_id_print_etichette, "-",  1, 1, kist_barcode_stampa.font[1,1])
//						PrintPage ( ki_id_print_etichette )
//					end if
//				end if
			
			end if

////--- In stampa i DS
//			for k = 1 to k_ds_idx
//				PrintDataWindow(ki_id_print_etichette, kids_barcode_print_label[k])
//			next
//
//--- Spedisce la stampa alla dispositivo e chiude la coda se sono in modalita' mono-etichetta
			if k_chiudi_a_fine_routine then
				stampa_etichetta_riferimento_close()
//				PrintClose(ki_id_print_etichette)
			end if

//--- close del CURSORE			
			close kc_listview;
	
			if isvalid(kds_meca_dosim_barcode_prg) then destroy kds_meca_dosim_barcode_prg
	
		end if
		
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

	
finally
//--- se ho aggiornato qls allora commit!
	if k_rec_mod > 0 then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	if isvalid(kds_dd_sl_pt_tipo) then destroy kds_dd_sl_pt_tipo	

	SetPointer(kpointer)
	
end try

return k_etichette_stampate



end function

private subroutine stampa_testo_verticale (string a_testo_verticale, integer a_inizio_riga, integer a_inizio_col, integer a_col_riga, integer a_col_col);//
// stampa testo in verticale
// input: testo, posizioni relative Riga (y),Colonna(X) di inizio e riga,colonna assolute dell'area di stampa 
//
boolean k_flacapo=true
int k_inizio_riga=0, k_inizio_col=0, k_avanza_col=0
string k_testo_verticale = ""
int k_len, k_ind


//--- imposta il font VERTICALE
	PrintDefineFont(ki_id_print_etichette, 8, ki_font_name[11], kist_barcode_stampa.font[11,2], kist_barcode_stampa.font[11,3], Fixed!, Modern!, FALSE, FALSE) //Font Verticale
	k_testo_verticale = a_testo_verticale
	k_len = len(k_testo_verticale)
	k_avanza_col = 190 
	k_flacapo = true
	k_inizio_riga = a_inizio_riga
	k_inizio_col = a_inizio_col
	for k_ind = 1 to k_len 
//--- alla 20' lettera se frase lunga va a capo verticalmente al primo spazio				
		if k_flacapo and k_len > 24 and k_ind > 20 and mid(k_testo_verticale, k_ind, 1) = " " then   
			k_flacapo = false
			k_inizio_riga = a_inizio_riga
			k_inizio_col += k_avanza_col  
		end if
	
		k_inizio_riga -= 140
		printtext (ki_id_print_etichette, mid(k_testo_verticale, k_ind, 1), k_inizio_col+a_col_col, k_inizio_riga + a_col_riga, 8)  // 8=VERTICALE
	next

end subroutine

private function boolean stampa_etichetta_dosimetro (st_tab_barcode kst_tab_barcode_padre, st_tab_base kst_tab_base, st_tab_sl_pt kst_tab_sl_pt, ref st_barcode_stampa kst_barcode_stampa, ref uo_ds_std_1 ads_meca_dosim_barcode_prg);//
// stampa Etichetta Barcode x il Dosimetro da accompagnare a un Barcode di Trattamento
// return:  TRUE = OK stampato
//
boolean k_return=false
int k_rc=0, k_nr_bcode=0, k_ind, k_nr_dosimpos, k_riga
int k_ds_idx
kuf_meca_dosim kuf1_meca_dosim
//kuf_armo kuf1_armo
//st_tab_meca kst_tab_meca
st_tab_meca_dosim kst_tab_meca_dosim[]
st_esito kst_esito
uo_ds_std_1 kds_sl_pt_dosimpos_l
uo_ds_std_1 kdd_dosim_tipo, kdd_flg_tipo_dose
st_tab_sl_pt_dosimpos kst_tab_sl_pt_dosimpos
	
	try

		kuf1_meca_dosim = create kuf_meca_dosim
	
		kds_sl_pt_dosimpos_l = create uo_ds_std_1
		kds_sl_pt_dosimpos_l.dataobject = "ds_sl_pt_dosimpos_l"
		kds_sl_pt_dosimpos_l.settransobject(kguo_sqlca_db_magazzino)
	
		kdd_dosim_tipo = create uo_ds_std_1
		kdd_dosim_tipo.dataobject = "dd_dosim_tipo"
		kdd_dosim_tipo.retrieve( )
	
		kdd_flg_tipo_dose = create uo_ds_std_1
		kdd_flg_tipo_dose.dataobject = "dd_flg_tipo_dose"
		kdd_flg_tipo_dose.retrieve( )
		
//--- Genera il barcode di dosimetria da stampare 
		kst_tab_meca_dosim[1].id_meca = kst_barcode_stampa.id_meca
		kst_tab_meca_dosim[1].barcode_lav = kst_tab_barcode_padre.barcode
		k_nr_bcode = kuf1_meca_dosim.get_barcode(kst_tab_meca_dosim[])   // piglia il n. dosimtri da stampare

		if k_nr_bcode > 0 then
//			kst_tab_meca.id = kst_barcode_stampa.id_meca
//			kuf1_armo = create kuf_armo
//			kst_tab_meca.impianto = kuf1_armo.get_impianto(kst_tab_meca)
			k_nr_dosimpos = kds_sl_pt_dosimpos_l.retrieve(kst_tab_sl_pt.cod_sl_pt, kst_barcode_stampa.impianto)   // recupera le descrizioni 
		end if

//--- Stampa un tot di numero dosimetri per barcode		
		for k_ind = 1 to k_nr_bcode

//--- sostituisce descrizione sl-pt etichetta con quelle impostate nella posizione 
			kst_barcode_stampa.dosimpos_codice=""
			kst_barcode_stampa.dosim_tipo_des = ""
			kst_barcode_stampa.tipo_dose_des = ""
			if k_nr_dosimpos >= k_ind then 
				
				kst_barcode_stampa.dosim_tipo = trim(kds_sl_pt_dosimpos_l.getitemstring( k_ind, "dosim_tipo"))  // tipo dosimetro AMBER, RED....
				if trim(kst_barcode_stampa.dosim_tipo) > " " then
					k_riga = kdd_dosim_tipo.find( "codice = '" + trim(kst_barcode_stampa.dosim_tipo) + "'", 1, kdd_dosim_tipo.rowcount( )) // cerca il codice ...
					if k_riga > 0 then
						kst_barcode_stampa.dosim_tipo_des = trim(kdd_dosim_tipo.getitemstring( k_riga, "descr"))  // descrizione tipo dosimetro AMBER, RED....
					end if
				end if

				kst_barcode_stampa.tipo_dose_des = trim(kds_sl_pt_dosimpos_l.getitemstring( k_ind, "dosim_flg_tipo_dose"))  // tipo dose MASSIMA, MINIMA...
				if trim(kst_barcode_stampa.tipo_dose_des) > " " then
					k_riga = kdd_flg_tipo_dose.find( "stato = '" + trim(kst_barcode_stampa.tipo_dose_des) + "'", 1, kdd_flg_tipo_dose.rowcount( )) // cerca il codice ...
					if k_riga > 0 then
						kst_barcode_stampa.tipo_dose_des = trim(kdd_flg_tipo_dose.getitemstring( k_riga, "descr"))  // descrizione tipo dose MASSIMA, MINIMA...
					end if
				end if
				
				kst_barcode_stampa.dosimpos_codice = trim(kds_sl_pt_dosimpos_l. getitemstring( k_ind, "dosimpos_codice"))  // codice posizione dosimetro
				if kst_barcode_stampa.dosimpos_codice > " " then
				else
					kst_barcode_stampa.dosimpos_codice = "00"
				end if

//--- 19-4-2018 REZIO: le note in stampa devono essere sia quelle su SL-PT in orizzontale che quelle su DOSIMPOS in verticale!!				
				if trim(kds_sl_pt_dosimpos_l.getitemstring( k_ind, "descr")) > " " then
					kst_tab_sl_pt_dosimpos.descr = trim(kds_sl_pt_dosimpos_l.getitemstring( k_ind, "descr"))
				else
					kst_tab_sl_pt_dosimpos.descr = ""
				end if
				if trim(kds_sl_pt_dosimpos_l.getitemstring( k_ind, "descr1")) > " " then
					kst_tab_sl_pt_dosimpos.descr1 = trim(kds_sl_pt_dosimpos_l.getitemstring( k_ind, "descr1"))
				else
					kst_tab_sl_pt_dosimpos.descr1 = ""
				end if
					
			end if

			ki_num_etichetta_in_pag ++
		
//--- stampa etichetta		
			if trim(kst_tab_base.barcode_modulo) = barcode_modulo_etich_2019 then

				stampa_etichetta_dosimetro_rev2(kst_tab_meca_dosim[k_ind], kst_tab_barcode_padre, kst_tab_base, kst_tab_sl_pt &
														,kst_barcode_stampa, kst_tab_sl_pt_dosimpos, ads_meca_dosim_barcode_prg)
			else
						
				k_ds_idx = u_get_idx_ds_barcode_print_label("d_barcode_et_dsm_rev_3_gen24", kst_tab_barcode_padre.id_meca)  // recupera il n.array del ds 
				kids_barcode_print_label[k_ds_idx].insertrow(0)
				stampa_etichetta_dosimetro_rev3(kids_barcode_print_label[k_ds_idx] &
														 ,kst_tab_meca_dosim[k_ind], kst_tab_barcode_padre, kst_tab_base, kst_tab_sl_pt &
														 ,kst_barcode_stampa, kst_tab_sl_pt_dosimpos, ads_meca_dosim_barcode_prg)
						
			end if
		next
		
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito( )
		kuo_exception.messaggio_utente( "Etichetta Barcode Dosimetro non Stampato ", kst_esito.SQLErrText + kkg.acapo + "Lotto: " &
		                               + string(kst_tab_barcode_padre.num_int) + " del " + string(kst_tab_barcode_padre.data_int))

	finally 
		if isvalid(kuf1_meca_dosim) then destroy kuf1_meca_dosim
		if isvalid(kds_sl_pt_dosimpos_l) then destroy kds_sl_pt_dosimpos_l
		if isvalid(kdd_flg_tipo_dose) then destroy kdd_flg_tipo_dose
//		if isvalid(kuf1_armo) then destroy kuf1_armo

	end try
	

	return k_return



end function

private subroutine stampa_barcode (string k_barcode, longlong k_id_print, integer k_coord_x, integer k_coord_y, integer k_altezza_cb);//
// stampa codice a barre standard CODE 39
//
// 1'' (inches) = 2,54 cm 
// ogni carattere è composto da 5 barre e 4 spazi (=9 elementi)
// ogni elemento può essere fine o grosso (narrow o wide)
// 3 dei 9 elementi deve essere wide (ecco xchè si chiama 'code 39')
// la tabella k_caratt_barcode è di 44, ogni stringa contiene 9 caratteri che indicano 
// la sequenza 'sottile' e 'grosso' iniziando dall'elemento barra poi spazio poi barra ecc... 
// la codebar intera è composta da una zona franca di almeno 0,1'' + il carattere di 
// inizio '*' + il codice + il carattere di fine '*' + zona franca di almeno 0,1''
//
string k_caratt_barcode[0 to 44, 0 to 1], k_caratt_bar_sp=""
string k_open_print="N"
int k_spessore=0, k_altezza=0, k_coord_y1, k_font_alt=18, k_max_item=0
double k_coeff_di_spessore = 0.85 
int k_ctr=0, k_ctr1=0, k_ctr2=0


                                  k_caratt_bar_sp='bsbsbsbsb'
k_caratt_barcode[00,0]='0';  k_caratt_barcode[00,1]='nnnwwnwnn'
k_caratt_barcode[01,0]='1';  k_caratt_barcode[01,1]='wnnwnnnnw'
k_caratt_barcode[02,0]='2';  k_caratt_barcode[02,1]='nnwwnnnnw'
k_caratt_barcode[03,0]='3';  k_caratt_barcode[03,1]='wnwwnnnnn'
k_caratt_barcode[04,0]='4';  k_caratt_barcode[04,1]='nnnwwnnnw'
k_caratt_barcode[05,0]='5';  k_caratt_barcode[05,1]='wnnwwnnnn'
k_caratt_barcode[06,0]='6';  k_caratt_barcode[06,1]='nnwwwnnnn'
k_caratt_barcode[07,0]='7';  k_caratt_barcode[07,1]='nnnwnnwnw'
k_caratt_barcode[08,0]='8';  k_caratt_barcode[08,1]='wnnwnnwnn'
k_caratt_barcode[09,0]='9';  k_caratt_barcode[09,1]='nnwwnnwnn'
k_caratt_barcode[10,0]='a';  k_caratt_barcode[10,1]='wnnnnwnnw'
k_caratt_barcode[11,0]='b';  k_caratt_barcode[11,1]='nnwnnwnnw'
k_caratt_barcode[12,0]='c';  k_caratt_barcode[12,1]='wnwnnwnnn'
k_caratt_barcode[13,0]='d';  k_caratt_barcode[13,1]='nnnnwwnnw'
k_caratt_barcode[14,0]='e';  k_caratt_barcode[14,1]='wnnnwwnnn'
k_caratt_barcode[15,0]='f';  k_caratt_barcode[15,1]='nnwnwwnnn'
k_caratt_barcode[16,0]='g';  k_caratt_barcode[16,1]='nnnnnwwnw'
k_caratt_barcode[17,0]='h';  k_caratt_barcode[17,1]='wnnnnwwnn'
k_caratt_barcode[18,0]='i';  k_caratt_barcode[18,1]='nnwnnwwnn'
k_caratt_barcode[19,0]='j';  k_caratt_barcode[19,1]='nnnnwwwnn'
k_caratt_barcode[20,0]='k';  k_caratt_barcode[20,1]='wnnnnnnww'
k_caratt_barcode[21,0]='l';  k_caratt_barcode[21,1]='nnwnnnnww'
k_caratt_barcode[22,0]='m';  k_caratt_barcode[22,1]='wnwnnnnwn'
k_caratt_barcode[23,0]='n';  k_caratt_barcode[23,1]='nnnnwnnww'
k_caratt_barcode[24,0]='o';  k_caratt_barcode[24,1]='wnnnwnnwn'
k_caratt_barcode[25,0]='p';  k_caratt_barcode[25,1]='nnwnwnnwn'
k_caratt_barcode[26,0]='q';  k_caratt_barcode[26,1]='nnnnnnwww'
k_caratt_barcode[27,0]='r';  k_caratt_barcode[27,1]='wnnnnnwwn'
k_caratt_barcode[28,0]='s';  k_caratt_barcode[28,1]='nnwnnnwwn'
k_caratt_barcode[29,0]='t';  k_caratt_barcode[29,1]='nnnnwnwwn'
k_caratt_barcode[30,0]='u';  k_caratt_barcode[30,1]='wwnnnnnnw'
k_caratt_barcode[31,0]='v';  k_caratt_barcode[31,1]='nwwnnnnnw'
k_caratt_barcode[32,0]='w';  k_caratt_barcode[32,1]='wwwnnnnnn'
k_caratt_barcode[33,0]='x';  k_caratt_barcode[33,1]='nwnnwnnnw'
k_caratt_barcode[34,0]='y';  k_caratt_barcode[34,1]='wwnnwnnnn'
k_caratt_barcode[35,0]='z';  k_caratt_barcode[35,1]='nwwnwnnnn'
k_caratt_barcode[36,0]='-';  k_caratt_barcode[36,1]='nwnnnnwnw'
k_caratt_barcode[37,0]='.';  k_caratt_barcode[37,1]='wwnnnnwnn'
k_caratt_barcode[38,0]=' ';  k_caratt_barcode[38,1]='nwwnnnwnn'
k_caratt_barcode[39,0]='*';  k_caratt_barcode[39,1]='nwnnwnwnn'
k_caratt_barcode[40,0]='$';  k_caratt_barcode[40,1]='nwnwnwnnn'
k_caratt_barcode[41,0]='/';  k_caratt_barcode[41,1]='nwnwnnnwn'
k_caratt_barcode[42,0]='+';  k_caratt_barcode[42,1]='nwnnnwnwn'
k_caratt_barcode[43,0]='%';  k_caratt_barcode[43,1]='nnnwnwnwn'
k_caratt_barcode[44,0]=' ';  k_caratt_barcode[44,1]='         '

k_max_item = upperbound(k_caratt_barcode, 1)


	if k_id_print = 0 or isnull(k_id_print) then
		k_open_print = "S"
		k_id_print = PrintOpen( )
	end if
	
	if k_coord_x = 0 or isnull(k_coord_x) then
		k_coord_x = 1170
	end if
	if k_coord_y = 0 or isnull(k_coord_y) then
		k_coord_y = 3500
	end if
	if k_altezza_cb = 0 or isnull(k_altezza_cb) then
		k_altezza_cb = 1600
	end if
	k_coord_y1 = k_coord_y - k_font_alt
	k_altezza = k_altezza_cb + k_coord_y


//--- definizione di un font per la stampa di stringhe
	PrintDefineFont(k_id_print, 1, "Courier 10,12,15", - k_font_alt, 400, Fixed!, Modern!, FALSE, FALSE)
	
//--- carattere di inizio codice a barre
	for k_ctr1 = 1 to 9
		
      if MidA(k_caratt_barcode[39,1],k_ctr1,1) = 'n' then
			k_spessore = 10 * k_coeff_di_spessore
		else
			k_spessore = 25 * k_coeff_di_spessore
		end if

		if k_ctr1 = 5 then   // stampo il carattere per chiarezza
			printtext (k_id_print, MidA(k_caratt_barcode[39,0],k_ctr1,1), k_coord_x, k_coord_y1, 1)
		end if
		
      if MidA(k_caratt_bar_sp,k_ctr1,1) = 'b' then
			Printline(k_id_print, k_coord_x, k_coord_y, k_coord_x, k_altezza, k_spessore)
		end if
		k_coord_x = k_coord_x + k_spessore
		
	next

//--- stringa alfanumerica dell'effettivo codice a barre riempita con zero a destra
   k_barcode = trim(k_barcode) + FillA("0", (13 - LenA(trim(k_barcode)))) 
	
		
	for k_ctr2 = 1 to 13
		
		k_ctr=0
		do while MidA(k_barcode, k_ctr2, 1) = trim(k_caratt_barcode[k_ctr,0]) or k_ctr = k_max_item
			k_ctr++
		loop

//--- se carattere del barcode non trovato in tabella code-39 allora forzo l'uscita!
		if k_ctr = k_max_item then
			k_ctr2 = 14
		end if
		
		for k_ctr1 = 1 to 9
			if MidA(k_caratt_barcode[k_ctr,1],k_ctr1,1) = 'n' then
				k_spessore = 10 * k_coeff_di_spessore
			else
				k_spessore = 25 * k_coeff_di_spessore
			end if
	
			if k_ctr1 = 5 then   // stampo il carattere per chiarezza
			   printtext (k_id_print, MidA(k_caratt_barcode[k_ctr,0],k_ctr1,1), k_coord_x, k_coord_y1, 1)
			end if
				
			if MidA(k_caratt_bar_sp,k_ctr1,1) = 'b' then
				Printline(k_id_print, k_coord_x, k_coord_y, k_coord_x, k_altezza, k_spessore)
			end if
			k_coord_x = k_coord_x + k_spessore
			
		next
	next
	
//--- carattere di fine codice a barre
	for k_ctr1 = 1 to 9
      if MidA(k_caratt_barcode[39,1],k_ctr1,1) = 'n' then
			k_spessore = 10 * k_coeff_di_spessore
		else
			k_spessore = 25 * k_coeff_di_spessore
		end if

		if k_ctr1 = 5 then   // stampo il carattere per chiarezza
			printtext (k_id_print, MidA(k_caratt_barcode[39,0],k_ctr1,1), k_coord_x, k_coord_y1, 1)
		end if
		
      if MidA(k_caratt_bar_sp,k_ctr1,1) = 'b' then
			Printline(k_id_print, k_coord_x, k_coord_y, k_coord_x, k_altezza, k_spessore)
		end if
		k_coord_x = k_coord_x + k_spessore
		
	next


	if k_open_print = "S" then
		PrintClose(k_id_print)
	end if
	




end subroutine

public function boolean stampa_etichetta_riferimento_open (long a_id_meca, boolean a_ristampa);//
// stampa dell'etichetta: Open dello streamer di stampa
// return:  set ki_id_print_etichette
//
int k_rc=0
boolean k_elabora = true
string  k_stampante
kuf_base kuf1_base


	SetPointer(kkg.pointer_attesa)

	ki_stampante_originale = PrintGetPrinter()  // salva la stampante originale impostata

//--- se non sono in ristampa chiedo la stampante
	if not a_ristampa then
		kuf1_base = create kuf_base
		k_stampante = trim(mid(kuf1_base.prendi_dato_base(kuf1_base.kki_base_utenti_codice_stbarcode),2)) // controlla prima la stampante personale dei barcode
		if k_stampante > " " then
		else
			k_stampante = trim(mid(kuf1_base.prendi_dato_base( "stamp_cbarre"),2))  // cerca su tabella generale
		end if
		destroy kuf1_base
	end if
	
	if k_stampante > " " then
		
		if PrintSetPrinter (k_stampante) <= 0 then
			k_elabora = false
		end if
		
	else		

		if printsetup() < 0 then  // se alla fine non è non impostata la chiede
			k_elabora = false
		else
			k_stampante = PrintGetPrinter()  // get della stampante scelta
		end if
		
	end if

	if	k_elabora then
		if ki_id_print_etichette = 0 then   // se streamer stampa non ancora open...
//				ki_id_print_etichette = PrintOpen( ) 
			if isnull(a_id_meca) then a_id_meca = 0
			ki_id_print_etichette = PrintOpen( "barcodeLotto_" + string(a_id_meca), FALSE )
			if ki_id_print_etichette < 0 then
				kguo_exception.inizializza(this.classname())
				kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
				kguo_exception.kist_esito.sqlcode = ki_id_print_etichette 
				kguo_exception.kist_esito.sqlerrtext = "Errore in Stampa Etichette Lotto id/ASN " + string(a_id_meca) + "."&
																	+ " Stampante indicata non connessa: " + kkg.acapo + "'" + trim(k_stampante) + "' "
				kguo_exception.messaggio_utente( )
				ki_id_print_etichette = 0
			else
				ki_num_etichetta_in_pag=0  // contatore etichette nella pagina (probabile al max 2 o 4)
			end if
		end if
	else
		ki_id_print_etichette = 0
	end if

	SetPointer(kkg.pointer_default)
	
return k_elabora
end function

public function integer stampa_etichetta_riferimento_campioni (long a_id_meca) throws uo_exception;/*
 stampa etichette CONTROCAMPIONI 
 return:  numero di barcode stampati 0=nessuno
*/
int k_return
int k_rc=0, k_i, k_row
string k_nessuna_elab="N"
string k_barcode_x
int k_barcode_altezza=0, k_barcode_coord_x, k_barcode_coord_y
int k_barcode_tot_lotto, k_barcode_generati, k_etichette_stampate
int k_ctr=0, k_ctr1=0, k_ctr2=0
date k_dataoggi 
constant int k_num_righe_giu=5800 
constant int k_num_righe_giu_x4=4020  
constant int k_num_col_dx_x4=5450 
boolean k_print_open = false
int k_num_righe = 1, k_inizio_riga=0, k_inizio_col=0
int k_num_colonne = 0, k_len_max
kuf_armo_campioni kuf1_armo_campioni
kuf_base kuf1_base
st_tab_armo_campioni kst_tab_armo_campioni
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti_1, kst_tab_clienti_2
st_tab_base kst_tab_base
uo_ds_std_1 kds_1


try
	SetPointer(kkg.pointer_attesa)

	kuf1_armo_campioni = create kuf_armo_campioni
	kuf1_base = create kuf_base

	if a_id_meca> 0 then
	else
		return 0
	end if

	kds_1 = kuf1_armo_campioni.get_ds_armo_campioni_print(a_id_meca) // torna il datastore con i Campioni da stampare li genera se necessario
	k_barcode_generati = kds_1.rowcount( )
	if k_barcode_generati < 0 then
		kguo_exception.set_esito(kds_1.kist_esito)
		kguo_exception.kist_esito.sqlerrtext = "Stampa etichette Controcampioni: Errore in lettura Barcode Campioni per Lotto id " + string(a_id_meca) + ". " + kkg.acapo + kds_1.kist_esito.sqlerrtext
		throw kguo_exception 
	end if
	if k_barcode_generati > 0 then
	else
		return 0
	end if
	
//--- individuo il tipo modulo x etichette codici a barre da stampare (2 etich x foglio A3 o 4 etic x foglio A4 o su etichettarice...)
	kst_tab_base.barcode_modulo = kGuf_data_base.ki_barcode_modulo // trim(MidA(kuf1_base.prendi_dato_base( "barcode_modulo"),2))

	if ki_id_print_etichette = 0 then   // se streamer stampa non ancora open...
		k_print_open = true
		stampa_etichetta_riferimento_open(a_id_meca, true)
	end if

	if ki_id_print_etichette = 0 then   // se streamer stampa non open...
		return 0
	end if
				
		k_barcode_coord_x = (2.0 / 2.54) * 520   //--- (Xcm / coeff di conv x pollici) * migliaia
		k_barcode_coord_y = (7.0 / 2.54) * 580   //--- (Xcm / coeff di conv x pollici) * migliaia
		k_barcode_altezza = (0.6 / 2.54) * 1200   //--- (Xcm / coeff di conv x pollici) * migliaia
				
//--- Imposta i FONT di default
	u_set_font_default( )
	
//--- personalizza il font 7	
	PrintDefineFont(ki_id_print_etichette, 7, ki_font_name[7], -52, 400, Fixed!, Modern!, FALSE, FALSE)
	
//------------------------------------------------------------------------------------------------------------------------------------ CICLO LETTURE
	for k_etichette_stampate = 1 to k_barcode_generati

		kst_tab_armo_campioni.id_armo_campione = kds_1.getitemnumber(k_etichette_stampate, "id_armo_campione") 
		kst_tab_armo_campioni.id_armo = kds_1.getitemnumber(k_etichette_stampate, "id_armo") 
		kst_tab_armo_campioni.barcode = kds_1.getitemstring(k_etichette_stampate, "barcode") 
		kst_tab_meca.num_int = kds_1.getitemnumber(k_etichette_stampate, "num_int") 
		kst_tab_meca.data_int = kds_1.getitemdate(k_etichette_stampate, "data_int") 
		kst_tab_meca.data_ent = kds_1.getitemdatetime(k_etichette_stampate, "data_ent") 
		kst_tab_meca.clie_1 = kds_1.getitemnumber(k_etichette_stampate, "clie_1") 
		kst_tab_clienti_1.rag_soc_10 = kds_1.getitemstring(k_etichette_stampate, "rag_soc_1") 
		kst_tab_meca.clie_2 = kds_1.getitemnumber(k_etichette_stampate, "clie_2") 
		kst_tab_clienti_2.rag_soc_10 = kds_1.getitemstring(k_etichette_stampate, "rag_soc_2") 
		kst_tab_meca.area_mag = kds_1.getitemstring(k_etichette_stampate, "area_mag") 

		ki_num_etichetta_in_pag ++
				

//--- se sono su etichettatrice 
//			if trim(kst_tab_base.barcode_modulo) = barcode_modulo_1etichetta then
				k_num_colonne = -150
				k_num_righe = 200

// stampa il logo ad inizio foglio
			PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + kkg.path_sep + "et_bcode_x4_avvertenze.bmp", 300+k_num_colonne, 1+ k_num_righe, 0, 0) //2400, 750) 
			PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + kkg.path_sep + "logo_barcode.jpg", 400+k_num_colonne, 25 + k_num_righe, 1600, 500) //2500, 500)

//--- Sezione Anagrafiche Clienti 
			k_inizio_riga = 720
			k_inizio_col = 450
			printtext (ki_id_print_etichette, "Mandante :", k_inizio_col+k_num_colonne, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[1,1])
			printtext (ki_id_print_etichette, "Ricevente :", k_inizio_col+k_num_colonne, k_inizio_riga +300 + k_num_righe, kist_barcode_stampa.font[1,1])
			printtext (ki_id_print_etichette, string(kst_tab_meca.clie_1,"####0") , k_inizio_col+550+k_num_colonne, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[1,1])
			printtext (ki_id_print_etichette, string(kst_tab_meca.clie_2,"####0") , k_inizio_col+550+k_num_colonne, k_inizio_riga + 300 + k_num_righe, kist_barcode_stampa.font[1,1])
			printtext (ki_id_print_etichette, trim(kst_tab_clienti_1.rag_soc_10) , k_inizio_col+850+k_num_colonne, k_inizio_riga - 80 + k_num_righe, kist_barcode_stampa.font[3,1])
			printtext (ki_id_print_etichette, trim(kst_tab_clienti_2.rag_soc_10) , k_inizio_col+850+k_num_colonne, k_inizio_riga + 220 + k_num_righe, kist_barcode_stampa.font[3,1])

//--- Sezione Riferimento
			k_inizio_riga = 1480  //1500
			k_inizio_col = 520   //2750
			printtext (ki_id_print_etichette, "RIF.: ", k_inizio_col+k_num_colonne, k_inizio_riga + 100 + k_num_righe, kist_barcode_stampa.font[2,1])
			printtext (ki_id_print_etichette, string(kst_tab_meca.num_int,"####0") , k_inizio_col + 400+k_num_colonne, k_inizio_riga - 170 + k_num_righe, kist_barcode_stampa.font[5,1])
			printtext (ki_id_print_etichette, string(kst_tab_meca.data_int,"dd/mm/yy") , k_inizio_col+1900+k_num_colonne, k_inizio_riga + 100 + k_num_righe, kist_barcode_stampa.font[2,1])

//--- Sezione Etichetta
			k_inizio_riga = 1480  //1500
			k_inizio_col = 3700   //2750
			printtext (ki_id_print_etichette, "Etichetta: ", k_inizio_col+k_num_colonne, k_inizio_riga + 100 + k_num_righe, kist_barcode_stampa.font[2,1])
			printtext (ki_id_print_etichette, string(k_etichette_stampate,"####0") + "." + string (k_barcode_generati,"####0") &
							, k_inizio_col+900+k_num_colonne, k_inizio_riga -120 + k_num_righe, kist_barcode_stampa.font[6,1])

//--- Sezione NOTE
			k_inizio_riga = 2100
			k_inizio_col = 520 
			printtext (ki_id_print_etichette, "ETICHETTA CONTROCAMPIONI", k_inizio_col+k_num_colonne, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[2,1])

//--- Sezione BARCODE: testo 
			k_inizio_riga = 3200
			k_inizio_col = 620 
			printtext (ki_id_print_etichette, string(trim(kst_tab_armo_campioni.barcode),"@@@ @@@@@"), k_inizio_col+k_num_colonne, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[6,1])

//--- Area di magazzino
			k_inizio_riga = 3450
			k_inizio_col = 3900 
			if trim(kst_tab_meca.area_mag) > " " then
				printtext (ki_id_print_etichette, "Area di Ubicazione: ", k_inizio_col+k_num_colonne, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[1,1])
				printtext (ki_id_print_etichette, string(trim(kst_tab_meca.area_mag),"@@ @@@@@@@@@@"), k_inizio_col+k_num_colonne+800, k_inizio_riga + k_num_righe -50, kist_barcode_stampa.font[2,1])
			end if

//--- Sezione BARCODE: il codice a BARRE
			k_inizio_riga = 2350
			k_inizio_col = 700
			stampa_barcode_f ( kst_tab_armo_campioni.barcode, ki_id_print_etichette, k_inizio_col + k_num_colonne, (k_inizio_riga + k_num_righe), k_barcode_altezza, kist_barcode_stampa.font[1,1] )

//--- se Etichettatrice (1 etich) allora stampo
				PrintPage ( ki_id_print_etichette )  //--- FORZA salto pagina 
				ki_num_etichetta_in_pag = 1
				
		kuf1_armo_campioni.set_ts_stampa(kst_tab_armo_campioni)  // Aggiorna Data e ora stampa etichette
		
		k_return++
	next
	

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
//--- Spedisce la stampa al dispositivo e chiude la coda se sono in modalita' mono-etichetta
	if k_print_open then
		stampa_etichetta_riferimento_close()
	end if
	if isvalid(kuf1_armo_campioni) then destroy kuf1_armo_campioni
	if isvalid(kuf1_base) then destroy kuf1_base

	SetPointer(kkg.pointer_default)

end try

return k_return

end function

private function integer u_exec_post_stampa_set_pkl (ref st_tab_barcode ast_tab_barcode);//
//--- Stampa barcode alla fine set in tab wm_receiptgammarad (pkl)
//--- ret: n. barcode in pkl upd
//
integer k_return = 0
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe
kuf_wm_pklist_inout kuf1_wm_pklist_inout


try
		
	kuf1_wm_pklist_inout = create kuf_wm_pklist_inout

//--- Imposta i Barcode nella PKLIST grezza di WM
	kst_tab_wm_pklist_righe.id_meca = ast_tab_barcode.id_meca
	k_return = kuf1_wm_pklist_inout.set_barcode_in_wm_receiptgammarad(kst_tab_wm_pklist_righe)
		

catch(uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally
	if isvalid(kuf1_wm_pklist_inout) then destroy kuf1_wm_pklist_inout

end try
 
return k_return

end function

private subroutine u_exec_post_stampa_set_prezzi (ref st_tab_armo ast_tab_armo);//
//--- Stampa barcode alla fine set prezzi lotto
//--- inp: ast_tab_armo.id_meca
//--- ret: n. barcode in pkl upd
//
st_esito kst_esito
kuf_armo_inout kuf1_armo_inout


try
		
	kuf1_armo_inout = create kuf_armo_inout

	//--- Carica i PREZZI di Listino per le righe del Lotto (riferimento)
	kuf1_armo_inout.carica_prezzi_lotto(ast_tab_armo)
							

catch(uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally
	if isvalid(kuf1_armo_inout) then destroy kuf1_armo_inout

end try
 

end subroutine

public subroutine u_exec_post_stampa (st_tab_barcode ast_tab_barcode) throws uo_exception;/*
	Alcune operazioni da eseguire al termine della stampa dei barcode
*/
st_tab_armo kst_tab_armo
st_tab_meca_parziali kst_tab_meca_parziali
kuf_meca_parziali kuf1_meca_parziali


	try 
		u_exec_post_stampa_set_pkl(ast_tab_barcode)  // Imposta i Barcode nella PKLIST grezza di WM

		kst_tab_armo.id_meca = ast_tab_barcode.id_meca
		u_exec_post_stampa_set_prezzi(kst_tab_armo)    // Carica i PREZZI di Listino per le righe del Lotto (riferimento)
			
		kuf1_meca_parziali = create kuf_meca_parziali		
		kst_tab_meca_parziali.id_meca = ast_tab_barcode.id_meca
		kuf1_meca_parziali.tb_add(kst_tab_meca_parziali)   // Carica tabella Lotti Parziali 
			
	catch (uo_exception kuo_exception)
		throw kuo_exception
		
	end try					


end subroutine

public function boolean old_stampa_etichetta_riferimento_2xpag (st_barcode_stampa kst_barcode_stampa);//ERA DENTRO a stampa_etichetta_riferimento

////--- MODULO A 2 ETICHETTE ------------------------------------------------------------------------------------- 
//
//						if ki_num_etichetta_in_pag = 2 then
//							k_num_righe = k_num_righe_giu
//						else
//							k_num_righe = 0
////--- salto pagina 
//							if ki_num_etichetta_in_pag > 2 then
//								PrintPage ( ki_id_print_etichette )
//								ki_num_etichetta_in_pag = 1
//							end if
//						end if
//					
//						if isnull(kst_tab_meca.e1doco) then kst_tab_meca.e1doco = 0
//						if isnull(kst_tab_meca.e1rorn) then kst_tab_meca.e1rorn = 0
//
////--- valorizza struttura x stampa etichette
//						kst_barcode_stampa.barcode_modulo = ""
//						kst_barcode_stampa.barcode_tot_lotto = k_barcode_tot_lotto
//						kst_barcode_stampa.consegna_data_cript = k_consegna_data_cript
//						kst_barcode_stampa.num_colonne = 0
//						kst_barcode_stampa.num_righe = k_num_righe
//						kst_barcode_stampa.conta_barcode = k_conta_barcode
//						kst_barcode_stampa.barcode_coord_y = k_barcode_coord_y
//						kst_barcode_stampa.barcode_coord_x = k_barcode_coord_x
//						kst_barcode_stampa.barcode_altezza = k_barcode_altezza
//						kst_barcode_stampa.barcode = trim(kst_tab_barcode.barcode)	
//						kst_barcode_stampa.clie_3	= kst_tab_meca.clie_3
//						kst_barcode_stampa.clie_2	= kst_tab_meca.clie_2
//						kst_barcode_stampa.rag_soc_20 = kst_tab_clienti.rag_soc_20
//						kst_barcode_stampa.rag_soc_10 = kst_tab_clienti.rag_soc_10
//						kst_barcode_stampa.area_mag =	trim(kst_tab_meca.area_mag)	
//						kst_barcode_stampa.num_int = kst_tab_barcode.num_int
//						kst_barcode_stampa.data_int = kst_tab_barcode.data_int
//						kst_barcode_stampa.data_ent = kst_tab_meca.data_ent
//						kst_barcode_stampa.mc_co	= kst_tab_contratti.mc_co	
//						kst_barcode_stampa.sc_cf = kst_tab_contratti.sc_cf	
//						kst_barcode_stampa.et_bcode_st_dt_rif	= kst_tab_contratti.et_bcode_st_dt_rif
//						kst_barcode_stampa.normative = trim(kst_tab_prodotti.normative)	
//						kst_barcode_stampa.alt_2 = kst_tab_armo.alt_2	
//						kst_barcode_stampa.magazzino = kst_tab_armo.magazzino	
//						kst_barcode_stampa.id_meca = kst_tab_barcode.id_meca	
//						kst_barcode_stampa.e1doco = kst_tab_meca.e1doco
//						kst_barcode_stampa.e1rorn = kst_tab_meca.e1rorn
//						//kst_barcode_stampa.flg_dosimetro_contati = k_tot_dosimetri 
//
////--- STAMPA ETICHETTA						
//						if kst_barcode_stampa.magazzino = kuf1_armo.kki_magazzino_datrattare then
//							stampa_etichetta_riferimento_2xpag(kst_barcode_stampa) // lotti da trattare
//						else
//							stampa_etichetta_riferimento_x_2xpag(kst_barcode_stampa)  // conto deposito ecc...
//						end if
//

//
// stampa 2 Etichette x foglio con il  codice a barre 
// return:  TRUE = stampa OK
//
boolean k_return = false
int k_inizio_riga=0, k_inizio_col=0


	SetPointer(kkg.pointer_attesa)

	u_set_font_default( ) //--- Imposta i FONT di default
					
// stampa il logo ad inizio foglio
	PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\et_bcode.bmp", 300, 1 + kst_barcode_stampa.num_righe, 7800, 5750)
	PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\logo_barcode.jpg", 400, 1 + kst_barcode_stampa.num_righe,  2400, 800) //0, 0)
	//PrintBitmap(ki_id_print_etichette, "et_bcode.bmp", 300, 1 + kst_barcode_stampa.num_righe, 7800, 5750)
	//PrintBitmap(ki_id_print_etichette, "logo_barcode.jpg", 400, 1 + kst_barcode_stampa.num_righe,  2400, 800) //0, 0)
	
	//--- Sezione Anagrafiche Clienti 
	printtext (ki_id_print_etichette, "Cliente :", 450, 1150 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	printtext (ki_id_print_etichette, "Ricevente :", 450, 1550 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
//	printtext (ki_id_print_etichette, "Ricevente :", 450, 1800 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.clie_3,"####0") , 1600, 1150 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.clie_2,"####0") , 1600, 1550 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
//	printtext (ki_id_print_etichette, string(kst_barcode_stampa.clie_2,"####0") , 1600, 1800 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	printtext (ki_id_print_etichette, trim(kst_barcode_stampa.rag_soc_20) , 2050, 1050 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[4,1])
	printtext (ki_id_print_etichette, trim(kst_barcode_stampa.rag_soc_10) , 2050, 1450 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[4,1])
//	printtext (ki_id_print_etichette, trim(kst_barcode_stampa.rag_soc_10) , 2050, 1650 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[4,1])

//	printtext (ki_id_print_etichette, "ID lotto :", 450, 1700 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
//	printtext (ki_id_print_etichette, string(kst_barcode_stampa.id_meca) + "   E1-WO :  " &
//											+ string(kst_barcode_stampa.e1doco) + "   E1-SO :  " &
//											+ string(kst_barcode_stampa.e1rorn), 1600, 1700 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	
	//--- Sezione Sinistra Riferimento
	printtext (ki_id_print_etichette, "RIF: ", 450 - 50, 2400 - 20  + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.num_int,"####0") , 1800 - 800, 2300 + kst_barcode_stampa.num_righe - 80, kist_barcode_stampa.font[5,1])
	if isnull(kst_barcode_stampa.et_bcode_st_dt_rif) or kst_barcode_stampa.et_bcode_st_dt_rif <> "N" then
		printtext (ki_id_print_etichette, string(kst_barcode_stampa.data_ent,"dd/mm/yy") , 2950 - 600, 2400 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[3,1])
	end if
	
	//--- Sezione Lotto
	printtext (ki_id_print_etichette, "Lotto: ", 400, 3650 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.conta_barcode,"####0") + "." 	+ string (kst_barcode_stampa.barcode_tot_lotto,"####0") &
				, 920, 3450 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
	//									, 920, 3450 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[5,1])
//	if LenA(trim(kst_barcode_stampa.consegna_data_cript)) > 0 then
//		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.consegna_data_cript), 3150 - 600, 3650 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1]) //data consegna criptata
//	end if
	
	//--- Sezione Destra MC-CC e SC.CF
	k_inizio_col = 3550   
	if LenA(trim(kst_barcode_stampa.mc_co)) > 0 then
		printtext (ki_id_print_etichette, "Contratto Commerciale: ", k_inizio_col +150, 2350 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.mc_co), k_inizio_col +2050, 2300 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[3,1])
	end if
	if LenA(trim(kst_barcode_stampa.sc_cf)) > 0 then
		printtext (ki_id_print_etichette, "Capitolato di Fornitura: ", k_inizio_col+150, 2650 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.sc_cf), k_inizio_col+2050, 2600 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[3,1])
	end if
	if LenA(trim(kst_barcode_stampa.normative)) > 0 then
		printtext (ki_id_print_etichette, "Prodotto: ", k_inizio_col+150, 2950 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.normative), k_inizio_col+900, 2950 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[9,1]) //kist_barcode_stampa.font[3,1])
	end if
	if LenA(trim(kst_barcode_stampa.area_mag)) > 0 then
		printtext (ki_id_print_etichette, "Area di Ubicazione: ", k_inizio_col+150, 3250 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
		printtext (ki_id_print_etichette, string(trim(kst_barcode_stampa.area_mag),"@@ @@@@@@@@@@"), k_inizio_col+2050, 3200 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[3,1])
	end if
	//--- Altezza Pallet...
	if kst_barcode_stampa.alt_2 > 100 then
		printtext (ki_id_print_etichette, "Altezza Pallet: ", k_inizio_col+150, 3550 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
		printtext (ki_id_print_etichette,  string((kst_barcode_stampa.alt_2 / 10),"####0"), k_inizio_col+2050, 3520 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[3,1]) 
	end if
	
	//--- Sezione BARCODE il codice, se il barcode inizia con una lettera debbo togliere lo spazio in mezzo 
	if isnumber(LeftA(kst_barcode_stampa.barcode,1)) then
		printtext (ki_id_print_etichette, string(trim(kst_barcode_stampa.barcode),"@@@ @@@@@"), 280, 3950 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[8,1])
	else
		printtext (ki_id_print_etichette, string(trim(kst_barcode_stampa.barcode),"@@@@@@@@"), 280, 3950 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[8,1])
	end if
	
	//--- Sezione BARCODE il codice a BARRE
	stampa_barcode_f ( kst_barcode_stampa.barcode, ki_id_print_etichette, kst_barcode_stampa.barcode_coord_x, (kst_barcode_stampa.barcode_coord_y + kst_barcode_stampa.num_righe), kst_barcode_stampa.barcode_altezza, kist_barcode_stampa.font[1,1] )
	//PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[1,1], "Arial", kist_barcode_stampa.font[1,2], kist_barcode_stampa.font[1,3], Fixed!, Modern!, FALSE, FALSE) //ripristino il font
	
	

	return k_return



end function

public function boolean old_stampa_etichetta_riferimento_x_2xpag (st_barcode_stampa kst_barcode_stampa);//
// stampa 2 Etichette x foglio A4 di MAT. da NON TRATTARE con codice a barre 
// return:  TRUE = stampa OK
//
boolean k_return = false
int k_inizio_riga=0, k_inizio_col=0
kuf_armo kuf1_armo
					

	SetPointer(kkg.pointer_attesa)
	
	u_set_font_default( ) //--- Imposta i FONT di default
					
// stampa il logo ad inizio foglio
	if kst_barcode_stampa.magazzino = kuf1_armo.kki_magazzino_dp then
		PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\et_bcode_dp.bmp", 300, 1 + kst_barcode_stampa.num_righe, 7800, 5750)
		//PrintBitmap(ki_id_print_etichette, "et_bcode_dp.bmp", 300, 1 + kst_barcode_stampa.num_righe, 7800, 5750)
	else
		PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\et_bcode_rd.bmp", 300, 1 + kst_barcode_stampa.num_righe, 7800, 5750)
		//PrintBitmap(ki_id_print_etichette, "et_bcode_rd.bmp", 300, 1 + kst_barcode_stampa.num_righe, 7800, 5750)
	end if
	//PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\logo_barcode.jpg", 400, 1 + kst_barcode_stampa.num_righe,  2400, 800) //0, 0)
	PrintBitmap(ki_id_print_etichette, "logo_barcode.jpg", 400, 1 + kst_barcode_stampa.num_righe,  2400, 800) //0, 0)
	
	
	//--- Sezione Anagrafiche Clienti 
	printtext (ki_id_print_etichette, "Cliente :", 450, 1200 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	printtext (ki_id_print_etichette, "Ricevente :", 450, 1800 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.clie_3,"####0") , 1600, 1200 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.clie_2,"####0") , 1600, 1800 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	printtext (ki_id_print_etichette, trim(kst_barcode_stampa.rag_soc_20) , 2050, 1050 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[4,1])
	printtext (ki_id_print_etichette, trim(kst_barcode_stampa.rag_soc_10) , 2050, 1650 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[4,1])
	
	//--- Sezione Sinistra Riferimento
	printtext (ki_id_print_etichette, "RIF: ", 450 - 50, 2400 - 20  + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.num_int,"####0") , 1800 - 800, 2300 + kst_barcode_stampa.num_righe - 80, kist_barcode_stampa.font[5,1])
	if isnull(kst_barcode_stampa.et_bcode_st_dt_rif) or kst_barcode_stampa.et_bcode_st_dt_rif <> "N" then
//		printtext (ki_id_print_etichette, string(kst_barcode_stampa.data_int,"dd/mm/yy") , 2950 - 600, 2400 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[3,1])
		printtext (ki_id_print_etichette, string(kst_barcode_stampa.data_ent,"dd/mm/yy") , 2950 - 600, 2400 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[3,1])
	end if
	
	//--- Sezione Lotto
	printtext (ki_id_print_etichette, "Lotto: ", 400, 3650 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.conta_barcode,"####0") + "." 	+ string (kst_barcode_stampa.barcode_tot_lotto,"####0") &
				, 920, 3450 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
	//									, 920, 3450 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[5,1])
//	if LenA(trim(kst_barcode_stampa.consegna_data_cript)) > 0 then
//		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.consegna_data_cript), 3150 - 600, 3650 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1]) //data consegna criptata
//	end if
	
	//--- Sezione Destra MC-CC e SC.CF
	k_inizio_col = 3550   
	if LenA(trim(kst_barcode_stampa.mc_co)) > 0 then
		printtext (ki_id_print_etichette, "Contratto: ", k_inizio_col +150, 2350 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.mc_co), k_inizio_col +2050, 2300 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[3,1])
	end if
//	if LenA(trim(kst_barcode_stampa.sc_cf)) > 0 then
//		printtext (ki_id_print_etichette, "Capitolato di Fornitura: ", k_inizio_col+150, 2650 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
//		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.sc_cf), k_inizio_col+2050, 2600 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[3,1])
//	end if
	if LenA(trim(kst_barcode_stampa.normative)) > 0 then
		printtext (ki_id_print_etichette, "Prodotto: ", k_inizio_col+150, 2950 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.normative), k_inizio_col+900, 2950 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[9,1]) //kist_barcode_stampa.font[3,1])
	end if
	if LenA(trim(kst_barcode_stampa.area_mag)) > 0 then
		printtext (ki_id_print_etichette, "Area di Ubicazione: ", k_inizio_col+150, 3250 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
		printtext (ki_id_print_etichette, string(trim(kst_barcode_stampa.area_mag),"@@ @@@@@@@@@@"), k_inizio_col+2050, 3200 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[3,1])
	end if
	//--- Altezza Pallet...
	if kst_barcode_stampa.alt_2 > 100 then
		printtext (ki_id_print_etichette, "Altezza Pallet: ", k_inizio_col+150, 3550 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
		printtext (ki_id_print_etichette,  string((kst_barcode_stampa.alt_2 / 10),"####0"), k_inizio_col+2050, 3520 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[3,1]) 
	end if
	
	//--- Sezione BARCODE il codice, se il barcode inizia con una lettera debbo togliere lo spazio in mezzo 
	if isnumber(LeftA(kst_barcode_stampa.barcode,1)) then
		printtext (ki_id_print_etichette, string(trim(kst_barcode_stampa.barcode),"@@@ @@@@@"), 280, 3950 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[7,1])
	else
		printtext (ki_id_print_etichette, string(trim(kst_barcode_stampa.barcode),"@@@@@@@@"), 280, 3950 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[7,1])
	end if
	
	//--- Sezione BARCODE il codice a BARRE
	stampa_barcode_f ( kst_barcode_stampa.barcode, ki_id_print_etichette, kst_barcode_stampa.barcode_coord_x, (kst_barcode_stampa.barcode_coord_y + kst_barcode_stampa.num_righe), kst_barcode_stampa.barcode_altezza, kist_barcode_stampa.font[1,1] )
	//PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[1,1], "Arial", kist_barcode_stampa.font[1,2], kist_barcode_stampa.font[1,3], Fixed!, Modern!, FALSE, FALSE) //ripristino il font
	
	

	return k_return



end function

public function boolean old_stampa_etichetta_riferimento_1_4xpag (st_barcode_stampa kst_barcode_stampa);//
// stampa 4 etichette di TRATTAMENTO con il codice a barre  
// return:  TRUE = stampa OK
//
boolean k_return 
//int k_inizio_riga=0, k_inizio_col=0, k_inizio_col_barcode = 0, k_delta_col=0, k_delta_col_barcode
//kuf_armo kuf1_armo
//
//
//	SetPointer(kkg.pointer_attesa)
//
//	u_set_font_default( ) //--- Imposta i FONT di default
//
////--- sposta la stampa di tot colonne 250=circa 10 mm
//	k_delta_col = -185
//	k_delta_col_barcode = -230
//
//// stampa il logo ad inizio foglio
//	k_inizio_riga = 1
//   k_inizio_col = 300 + k_delta_col
//	if trim(kst_barcode_stampa.barcode_modulo) = barcode_modulo_4xpagina then
//		PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\et_bcode_x4.bmp", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, 0, 0) 
//		//PrintBitmap(ki_id_print_etichette, "et_bcode_x4.bmp", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, 0, 0) 
//	else
//		PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\et_bcode_x1.jpg", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, 0, 0) 
//		//PrintBitmap(ki_id_print_etichette, "et_bcode_x1.jpg", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, 0, 0) 
//	end if
//	kst_barcode_stampa.num_righe += 30
//	PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\logo_barcode.jpg", k_inizio_col+ 50 +kst_barcode_stampa.num_colonne, k_inizio_riga - 80 + kst_barcode_stampa.num_righe, 1600, 500)  //2500, 500)
//	//PrintBitmap(ki_id_print_etichette, "logo_barcode.jpg", k_inizio_col+ 50 +kst_barcode_stampa.num_colonne, k_inizio_riga - 80 + kst_barcode_stampa.num_righe, 1600, 500)  //2500, 500)
//
////--- Dicitura TESTATA
//	k_inizio_col = 1730
//	choose case kst_barcode_stampa.magazzino
//		case kuf1_armo.kki_magazzino_DATRATTARE
//			printtext (ki_id_print_etichette, "", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga -100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
////	//--- Sezione Testata 'BOLLINO VIRANTE.....'
////			printtext (ki_id_print_etichette, "BOLLINO VIRANTE", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga -100  + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
////			printtext (ki_id_print_etichette, "Indicatore del trattamento con", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga -50  + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
////			printtext (ki_id_print_etichette, "raggi gamma della merce del lotto", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga -20  + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
//		case kuf1_armo.kki_magazzino_dp
//			printtext (ki_id_print_etichette, "CONTO DEPOSITO", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga -100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
//		case kuf1_armo.kki_magazzino_rd
//			printtext (ki_id_print_etichette, "STUDIO&SVILUPPO", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga -100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
//		case else
//			printtext (ki_id_print_etichette, "MAG.NO TRATTAM.", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga -100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
//	end choose
//
////--- Sezione Anagrafiche Clienti 
//	k_inizio_riga += 520  //720
//	k_inizio_col = 450 + k_delta_col
//	printtext (ki_id_print_etichette, "Cliente :", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//	printtext (ki_id_print_etichette, string(kst_barcode_stampa.clie_3,"####0") , k_inizio_col+550+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//	printtext (ki_id_print_etichette, trim(kst_barcode_stampa.rag_soc_20) , k_inizio_col+850+kst_barcode_stampa.num_colonne, k_inizio_riga - 70 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[3,1])
//	printtext (ki_id_print_etichette, "Ricevente :", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga +200 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//	printtext (ki_id_print_etichette, string(kst_barcode_stampa.clie_2,"####0") , k_inizio_col+550+kst_barcode_stampa.num_colonne, k_inizio_riga + 200 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//	printtext (ki_id_print_etichette, trim(kst_barcode_stampa.rag_soc_10) , k_inizio_col+850+kst_barcode_stampa.num_colonne, k_inizio_riga + 140 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[3,1])
//
////--- Sezione codici Riferimento
//	k_inizio_col =  450 + k_delta_col  //2750
//	k_inizio_riga = 1100 //1480 
//	printtext (ki_id_print_etichette, "RIF: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//	printtext (ki_id_print_etichette, string(kst_barcode_stampa.num_int,"#") , k_inizio_col + 220+kst_barcode_stampa.num_colonne, k_inizio_riga - 150 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[5,1])
////--- Collo 
//	printtext (ki_id_print_etichette, "Collo: ", k_inizio_col+kst_barcode_stampa.num_colonne+1900, k_inizio_riga + 100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//	printtext (ki_id_print_etichette, string(kst_barcode_stampa.conta_barcode,"####0") + "." + string (kst_barcode_stampa.barcode_tot_lotto,"####0") &
//																								   , k_inizio_col+kst_barcode_stampa.num_colonne+2250, k_inizio_riga - 150 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
////--- Sezione codici E1-WO, E1-SO 
//	printtext (ki_id_print_etichette, "WO: ", k_inizio_col+kst_barcode_stampa.num_colonne + 3600, k_inizio_riga + 100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//	printtext (ki_id_print_etichette, string(kst_barcode_stampa.e1doco,"#") , k_inizio_col + 3800+kst_barcode_stampa.num_colonne, k_inizio_riga - 150 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
//	printtext (ki_id_print_etichette, "SO: ", k_inizio_col+kst_barcode_stampa.num_colonne + 3600, k_inizio_riga + 500 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//	printtext (ki_id_print_etichette, string(kst_barcode_stampa.e1rorn,"#") , k_inizio_col + 3800+kst_barcode_stampa.num_colonne, k_inizio_riga + 280 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
//
////--- altri dati del Riferimento
//	k_inizio_col = 2750 + k_delta_col 
//	k_inizio_riga = 1480 
//	if isnull(kst_barcode_stampa.et_bcode_st_dt_rif) or kst_barcode_stampa.et_bcode_st_dt_rif <> "N" then
////		printtext (ki_id_print_etichette, string(kst_barcode_stampa.data_int,"dd/mm/yy") , k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 300+100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
//		printtext (ki_id_print_etichette, string(kst_barcode_stampa.data_ent,"dd/mm/yy") , k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 300+100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
//	end if
//
////--- Sezione Lotto
//	if trim(kst_barcode_stampa.barcode_modulo) = barcode_modulo_1etichetta then
//		k_inizio_col = 2970 + k_delta_col
//	end if 
////	if LenA(trim(kst_barcode_stampa.consegna_data_cript)) > 0 then
////		k_inizio_col -= 200
////		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.consegna_data_cript), k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 770+100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1]) //data consegna criptata
////	end if
//
////--- Sezione NUMERO BARCODE 
//	k_inizio_riga = 2600 //2730
//	if trim(kst_barcode_stampa.barcode_modulo) = barcode_modulo_1etichetta then
//		
//		k_inizio_col_barcode = k_delta_col_barcode + 420 //350
//		printtext (ki_id_print_etichette, string(trim(kst_barcode_stampa.barcode),"@@@ @@@@@"), k_inizio_col_barcode+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[7,1])
//		
//	else		
//		k_inizio_col_barcode = 270 + k_delta_col_barcode 
//		if isnumber(LeftA(kst_barcode_stampa.barcode,1)) then
//			printtext (ki_id_print_etichette, string(trim(kst_barcode_stampa.barcode),"@@@@@@@@"), k_inizio_col_barcode+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[7,1])
//		else							
//			printtext (ki_id_print_etichette, string(trim(kst_barcode_stampa.barcode),"@@@@@@@@"), k_inizio_col_barcode+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[7,1])
//		end if
//	end if
//
////--- Sezione Destra MC-CC e SC.CF
//	k_inizio_riga = 1550
//	k_inizio_col = 3560 + k_delta_col  
//	//4000
//	if LenA(trim(kst_barcode_stampa.mc_co)) > 0 then
//		printtext (ki_id_print_etichette, "Contratto Comm.: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 360 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.mc_co), k_inizio_col+800+kst_barcode_stampa.num_colonne, k_inizio_riga + 300 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
//	end if
//	if LenA(trim(kst_barcode_stampa.sc_cf)) > 0 then
//		printtext (ki_id_print_etichette, "Capitolato di Forn.: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 550 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.sc_cf), k_inizio_col+800+kst_barcode_stampa.num_colonne, k_inizio_riga + 490 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
//	end if
//	if LenA(trim(kst_barcode_stampa.area_mag)) > 0 then
//		printtext (ki_id_print_etichette, "Area di Ubicazione: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 800 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//		printtext (ki_id_print_etichette, string(trim(kst_barcode_stampa.area_mag),"@@ @@@@@@@@@@"), k_inizio_col+800+kst_barcode_stampa.num_colonne, k_inizio_riga + 740 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
//	end if
////--- Prodotto...
//	k_inizio_riga = 2480 //2560
//	k_inizio_col = 450 + k_delta_col
//	if LenA(trim(kst_barcode_stampa.normative)) > 0 then
//		printtext (ki_id_print_etichette, "Prodotto: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 50 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.normative), k_inizio_col+550+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[9,1]) //kist_barcode_stampa.font[2,1])
//	end if
////--- Altezza Pallet...
//	k_inizio_riga = 2480
//	k_inizio_col = 5130 + k_delta_col
//	if kst_barcode_stampa.alt_2 > 100 then
//		printtext (ki_id_print_etichette, "Altezza: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 10 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//		printtext (ki_id_print_etichette,  string((kst_barcode_stampa.alt_2 / 10),"####0"), k_inizio_col+350+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[9,1]) 
//	end if
//
//
////--- Sezione codice modulo e revisione 
//	k_inizio_riga = 3680
//	k_inizio_col = 4300 + k_delta_col
//	printtext (ki_id_print_etichette, "Tag# MN-LT-OPS-001 Rev.2 del 21MAR2018", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//
////--- Linea che chiude il BOX
//	k_inizio_riga = 2670
//   k_inizio_col = 331 + k_delta_col
//	if trim(kst_barcode_stampa.barcode_modulo) = barcode_modulo_4xpagina then
////		PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\et_bcode_x4.bmp", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, 0, 0) 
//	else
//		PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\et_bcode_linea.jpg", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, 0, 0) 
//		//PrintBitmap(ki_id_print_etichette, "et_bcode_linea.jpg", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, 0, 0) 
//	end if
//	
////--- Sezione BARCODE il codice a BARRE
//	k_inizio_col = 50 + k_delta_col 
//	stampa_barcode_f ( kst_barcode_stampa.barcode, ki_id_print_etichette, k_inizio_col +(kst_barcode_stampa.barcode_coord_x+kst_barcode_stampa.num_colonne), (kst_barcode_stampa.barcode_coord_y + kst_barcode_stampa.num_righe), kst_barcode_stampa.barcode_altezza, kist_barcode_stampa.font[1,1] )
//	//PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[1,1], "Arial", kist_barcode_stampa.font[1,2], kist_barcode_stampa.font[1,3], Fixed!, Modern!, FALSE, FALSE) //ripristino il font
//
////--- se Etichettatrice (1 etich) allora stampa
//	if trim(kst_barcode_stampa.barcode_modulo) = barcode_modulo_1etichetta then
//		
//		PrintPage ( ki_id_print_etichette )  //--- FORZA salto pagina 
//		ki_num_etichetta_in_pag = 1
//		
//	end if
//
//	k_return = true

return k_return



end function

public function boolean old_stampa_etichetta_riferimento_x_1_4xp (st_barcode_stampa kst_barcode_stampa);//
// stampa 4 etichette di MAT. DA NON TRATTARE con il codice a barre  
// return:  TRUE = stampa OK
//
boolean k_return 
//int k_inizio_riga=0, k_inizio_col=0
//kuf_armo kuf1_armo
//
//
//	SetPointer(kkg.pointer_attesa)
//
//	u_set_font_default( ) //--- Imposta i FONT di default
//	PrintDefineFont(ki_id_print_etichette, 7, ki_font_name[10] , kist_barcode_stampa.font[10,2], kist_barcode_stampa.font[10,3], Fixed!, Modern!, FALSE, FALSE) // sostituisco il 7
//
//	k_inizio_riga = 80
////--- stampa Etichetta e il logo ad inizio foglio
//	if trim(kst_barcode_stampa.barcode_modulo) = barcode_modulo_4xpagina then
////		if kst_barcode_stampa.magazzino = kuf1_armo.kki_magazzino_dp then
//		PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\et_bcode_nolav_x4.bmp", 300+kst_barcode_stampa.num_colonne, k_inizio_riga+ kst_barcode_stampa.num_righe, 0, 0) 
//		//PrintBitmap(ki_id_print_etichette, "et_bcode_nolav_x4.bmp", 300+kst_barcode_stampa.num_colonne, k_inizio_riga+ kst_barcode_stampa.num_righe, 0, 0) 
////		else
////			PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\et_bcode_rd_x4.bmp", 300+kst_barcode_stampa.num_colonne, k_inizio_riga+ kst_barcode_stampa.num_righe, 0, 0) 
////		end if
//	else
////		if kst_barcode_stampa.magazzino = kuf1_armo.kki_magazzino_dp then
//		PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\et_bcode_nolav_x1.bmp", 300+kst_barcode_stampa.num_colonne, k_inizio_riga+ kst_barcode_stampa.num_righe, 0, 0) 
//		//PrintBitmap(ki_id_print_etichette, "et_bcode_nolav_x1.bmp", 300+kst_barcode_stampa.num_colonne, k_inizio_riga+ kst_barcode_stampa.num_righe, 0, 0) 
////			PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\et_bcode_rd_x1.bmp", 300+kst_barcode_stampa.num_colonne, k_inizio_riga+ kst_barcode_stampa.num_righe, 0, 0) 
////		end if
//	end if
//	PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\logo_barcode.jpg", 400+kst_barcode_stampa.num_colonne, 25 + kst_barcode_stampa.num_righe, 1600, 500)  //2500, 500)
//	//PrintBitmap(ki_id_print_etichette, "logo_barcode.jpg", 400+kst_barcode_stampa.num_colonne, 25 + kst_barcode_stampa.num_righe, 1600, 500)  //2500, 500)
//
////--- Dicitura TESTATA
//	k_inizio_col = 1900
//	choose case kst_barcode_stampa.magazzino
//		case kuf1_armo.kki_magazzino_dp
//			printtext (ki_id_print_etichette, "CONTO DEPOSITO", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
//		case kuf1_armo.kki_magazzino_rd
//			printtext (ki_id_print_etichette, "STUDIO&SVILUPPO", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
//		case else
//			printtext (ki_id_print_etichette, "MAG.NO TRATTAM.", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
//	end choose
//	
////--- Sezione Anagrafiche Clienti 
//	k_inizio_riga += 720
//	k_inizio_col = 450
//	printtext (ki_id_print_etichette, "Cliente :", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//	printtext (ki_id_print_etichette, "Ricevente :", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga +300 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//	printtext (ki_id_print_etichette, string(kst_barcode_stampa.clie_3,"####0") , k_inizio_col+550+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//	printtext (ki_id_print_etichette, string(kst_barcode_stampa.clie_2,"####0") , k_inizio_col+550+kst_barcode_stampa.num_colonne, k_inizio_riga + 300 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//	printtext (ki_id_print_etichette, trim(kst_barcode_stampa.rag_soc_20) , k_inizio_col+850+kst_barcode_stampa.num_colonne, k_inizio_riga - 80 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[3,1])
//	printtext (ki_id_print_etichette, trim(kst_barcode_stampa.rag_soc_10) , k_inizio_col+850+kst_barcode_stampa.num_colonne, k_inizio_riga + 220 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[3,1])
//
////--- Sezione Riferimento
//	k_inizio_col = 2700  
//	k_inizio_riga += 760 
//	printtext (ki_id_print_etichette, "RIF.: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//	printtext (ki_id_print_etichette, string(kst_barcode_stampa.num_int,"####0") , k_inizio_col + 200+kst_barcode_stampa.num_colonne, k_inizio_riga - 150 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[5,1])
//	if isnull(kst_barcode_stampa.et_bcode_st_dt_rif) or kst_barcode_stampa.et_bcode_st_dt_rif <> "N" then
//		printtext (ki_id_print_etichette, string(kst_barcode_stampa.data_int,"dd/mm/yy") , k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 300+100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
//	end if
//
////--- Sezione Lotto
//	if trim(kst_barcode_stampa.barcode_modulo) = barcode_modulo_1etichetta then
//		k_inizio_col = 2900
//	end if 
//	printtext (ki_id_print_etichette, "Collo: ", k_inizio_col+1660+kst_barcode_stampa.num_colonne, k_inizio_riga + 100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//	printtext (ki_id_print_etichette, string(kst_barcode_stampa.conta_barcode,"####0") + "." + string (kst_barcode_stampa.barcode_tot_lotto,"####0") &
//					, k_inizio_col+1890+kst_barcode_stampa.num_colonne, k_inizio_riga -150 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
//	if LenA(trim(kst_barcode_stampa.consegna_data_cript)) > 0 then
//		k_inizio_col -= 200
//		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.consegna_data_cript), k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 770+100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1]) //data consegna criptata
//	end if
//
////--- Sezione Destra MC-CC e SC.CF
//	k_inizio_riga += 70 //1550
//	k_inizio_col = 3550   
//	//4000
//	if LenA(trim(kst_barcode_stampa.mc_co)) > 0 then
//		printtext (ki_id_print_etichette, "Contratto: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 360 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.mc_co), k_inizio_col+800+kst_barcode_stampa.num_colonne, k_inizio_riga + 300 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
//	end if
////	if LenA(trim(kst_barcode_stampa.sc_cf)) > 0 then
////		printtext (ki_id_print_etichette, "Capitolato di Forn.: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 550 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
////		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.sc_cf), k_inizio_col+800+kst_barcode_stampa.num_colonne, k_inizio_riga + 490  + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
////	end if
//	if LenA(trim(kst_barcode_stampa.area_mag)) > 0 then
//		printtext (ki_id_print_etichette, "Area di Ubicazione: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 800 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//		printtext (ki_id_print_etichette, string(trim(kst_barcode_stampa.area_mag),"@@ @@@@@@@@@@"), k_inizio_col+800+kst_barcode_stampa.num_colonne, k_inizio_riga + 740 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
//	end if
////--- Prodotto...
//	k_inizio_riga += 1000 //2560
//	k_inizio_col = 450
//	if LenA(trim(kst_barcode_stampa.normative)) > 0 then
//		printtext (ki_id_print_etichette, "Prodotto: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga +30+ kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.normative), k_inizio_col+550+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[9,1]) //kist_barcode_stampa.font[2,1])
//	end if
////--- Altezza Pallet...
////	k_inizio_riga = 2560
//	k_inizio_col = 5130
//	if kst_barcode_stampa.alt_2 > 100 then
//		printtext (ki_id_print_etichette, "Altezza: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga +30+ kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
//		printtext (ki_id_print_etichette,  string((kst_barcode_stampa.alt_2 / 10),"####0"), k_inizio_col+350+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[9,1]) 
//	end if
//
////--- Sezione BARCODE 
//	k_inizio_riga += 170  //2730
//	if trim(kst_barcode_stampa.barcode_modulo) = barcode_modulo_1etichetta then
//		
//		printtext (ki_id_print_etichette, string(trim(kst_barcode_stampa.barcode),"@@@ @@@@@"), 300+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[7,1])
//		
//	else							
//		if isnumber(LeftA(kst_barcode_stampa.barcode,1)) then
//			printtext (ki_id_print_etichette, string(trim(kst_barcode_stampa.barcode),"@@@@@@@@"), 260+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[7,1])
//		else							
//			printtext (ki_id_print_etichette, string(trim(kst_barcode_stampa.barcode),"@@@@@@@@"), 260+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[7,1])
//		end if
//	end if
//
////--- Sezione BARCODE il codice a BARRE
//	k_inizio_col = 50
//	stampa_barcode_f ( kst_barcode_stampa.barcode, ki_id_print_etichette, k_inizio_col +(kst_barcode_stampa.barcode_coord_x+kst_barcode_stampa.num_colonne), (kst_barcode_stampa.barcode_coord_y + kst_barcode_stampa.num_righe), kst_barcode_stampa.barcode_altezza, kist_barcode_stampa.font[1,1] )
////	PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[1,1], "Arial", kist_barcode_stampa.font[1,2], kist_barcode_stampa.font[1,3], Fixed!, Modern!, FALSE, FALSE) //ripristino il font
//
////--- se Etichettatrice (1 etich) allora stampa
//	if trim(kst_barcode_stampa.barcode_modulo) = barcode_modulo_1etichetta then
//		
//		PrintPage ( ki_id_print_etichette )  //--- FORZA salto pagina 
//		ki_num_etichetta_in_pag = 1
//		
//	end if
//
//	
//	k_return = true

return k_return



end function

public function boolean stampa_etichetta_riferimento_r3_2019may (st_barcode_stampa kst_barcode_stampa);//
// stampa 4 etichette di TRATTAMENTO con il codice a barre  
// return:  TRUE = stampa OK
//
boolean k_return 
int k_inizio_riga=0, k_inizio_col=0, k_inizio_col_barcode = 0, k_delta_col=0, k_delta_col_barcode
kuf_armo kuf1_armo


	SetPointer(kkg.pointer_attesa)

	u_set_font_default( ) //--- Imposta i FONT di default

//--- sposta la stampa di tot colonne 250=circa 10 mm
	k_delta_col = -185
	k_delta_col_barcode = -230

// stampa il logo ad inizio foglio
	k_inizio_riga = 1
   k_inizio_col = 300 + k_delta_col
//	if trim(kst_barcode_stampa.barcode_modulo) = barcode_modulo_4xpagina then
//		PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\et_bcode_x4.bmp", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, 0, 0) 
//	else
		PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\et_bcode_x1.jpg", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, 0, 0) 
//	end if
	kst_barcode_stampa.num_righe += 30
	PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\logo_barcode.jpg", k_inizio_col+ 50 +kst_barcode_stampa.num_colonne, k_inizio_riga - 80 + kst_barcode_stampa.num_righe, 1600, 500)  //2500, 500)
	//PrintBitmap(ki_id_print_etichette, "logo_barcode.jpg", k_inizio_col+ 50 +kst_barcode_stampa.num_colonne, k_inizio_riga - 80 + kst_barcode_stampa.num_righe, 1600, 500)  //2500, 500)

//--- Dicitura TESTATA
	k_inizio_col = 1730
	choose case kst_barcode_stampa.magazzino
		case kuf1_armo.kki_magazzino_DATRATTARE
			printtext (ki_id_print_etichette, "", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga -100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
//	//--- Sezione Testata 'BOLLINO VIRANTE.....'
//			printtext (ki_id_print_etichette, "BOLLINO VIRANTE", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga -100  + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
//			printtext (ki_id_print_etichette, "Indicatore del trattamento con", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga -50  + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
//			printtext (ki_id_print_etichette, "raggi gamma della merce del lotto", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga -20  + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
		case kuf1_armo.kki_magazzino_dp
			printtext (ki_id_print_etichette, "CONTO DEPOSITO", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga -100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
		case kuf1_armo.kki_magazzino_rd
			printtext (ki_id_print_etichette, "STUDIO&SVILUPPO", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga -100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
		case else
			printtext (ki_id_print_etichette, "MAG.NO TRATTAM.", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga -100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
	end choose

//--- Sezione Anagrafiche Clienti 
	k_inizio_riga += 520  //720
	k_inizio_col = 450 + k_delta_col
	printtext (ki_id_print_etichette, "Cliente :", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.clie_3,"####0") , k_inizio_col+550+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
	printtext (ki_id_print_etichette, trim(kst_barcode_stampa.rag_soc_20) , k_inizio_col+850+kst_barcode_stampa.num_colonne, k_inizio_riga - 70 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[3,1])
	printtext (ki_id_print_etichette, "Ricevente :", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga +200 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.clie_2,"####0") , k_inizio_col+550+kst_barcode_stampa.num_colonne, k_inizio_riga + 200 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
	printtext (ki_id_print_etichette, trim(kst_barcode_stampa.rag_soc_10) , k_inizio_col+850+kst_barcode_stampa.num_colonne, k_inizio_riga + 140 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[3,1])

//--- Sezione codici Riferimento
	k_inizio_col =  400 + k_delta_col  //2750
	k_inizio_riga = 1100 //1480 
	printtext (ki_id_print_etichette, "RIF: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 250 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.num_int,"#") , k_inizio_col + 185+kst_barcode_stampa.num_colonne, k_inizio_riga - 150 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[5,1])
//--- Collo 
	printtext (ki_id_print_etichette, "Collo: ", k_inizio_col+kst_barcode_stampa.num_colonne+1700, k_inizio_riga + 250 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.conta_barcode,"####0") + "." + string (kst_barcode_stampa.barcode_tot_lotto,"####0") &
															 , k_inizio_col+kst_barcode_stampa.num_colonne+1965, k_inizio_riga - 55 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
//--- Sezione codici E1-WO, E1-SO 
	printtext (ki_id_print_etichette, "WO: ", k_inizio_col+kst_barcode_stampa.num_colonne + 3080, k_inizio_riga + 200 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.e1doco,"#") , k_inizio_col + 3450+kst_barcode_stampa.num_colonne, k_inizio_riga - 150 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[5,1])
	printtext (ki_id_print_etichette, "SO: ", k_inizio_col+kst_barcode_stampa.num_colonne + 3700, k_inizio_riga + 550 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.e1rorn,"#") , k_inizio_col + 3950+kst_barcode_stampa.num_colonne, k_inizio_riga + 480 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])

//--- altri dati del Riferimento
	k_inizio_col = 2750 + k_delta_col 
	k_inizio_riga = 1480 
	if isnull(kst_barcode_stampa.et_bcode_st_dt_rif) or kst_barcode_stampa.et_bcode_st_dt_rif <> "N" then
//		printtext (ki_id_print_etichette, string(kst_barcode_stampa.data_int,"dd/mm/yy") , k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 300+100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
		printtext (ki_id_print_etichette, string(kst_barcode_stampa.data_ent,"dd/mm/yy") , k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 300+100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	end if

//--- Sezione Lotto
//	if trim(kst_barcode_stampa.barcode_modulo) = barcode_modulo_1etichetta then
		k_inizio_col = 2970 + k_delta_col
//	end if 
//	if LenA(trim(kst_barcode_stampa.consegna_data_cript)) > 0 then
//		k_inizio_col -= 200
//		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.consegna_data_cript), k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 770+100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1]) //data consegna criptata
//	end if

//--- Sezione NUMERO BARCODE 
	k_inizio_riga = 2600 //2730
//	if trim(kst_barcode_stampa.barcode_modulo) = barcode_modulo_1etichetta then	
		k_inizio_col_barcode = k_delta_col_barcode + 420 //350
		printtext (ki_id_print_etichette, string(trim(kst_barcode_stampa.barcode),"@@@ @@@@@"), k_inizio_col_barcode+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[7,1])		
//	else		
//		k_inizio_col_barcode = 270 + k_delta_col_barcode 
//		if isnumber(LeftA(kst_barcode_stampa.barcode,1)) then
//			printtext (ki_id_print_etichette, string(trim(kst_barcode_stampa.barcode),"@@@@@@@@"), k_inizio_col_barcode+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[7,1])
//		else							
//			printtext (ki_id_print_etichette, string(trim(kst_barcode_stampa.barcode),"@@@@@@@@"), k_inizio_col_barcode+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[7,1])
//		end if
//	end if

//--- Sezione Destra MC-CC e SC.CF
	k_inizio_riga = 1550
	k_inizio_col = 3560 + k_delta_col  
	//4000
	if LenA(trim(kst_barcode_stampa.mc_co)) > 0 then
		printtext (ki_id_print_etichette, "Contratto Comm.: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 360 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.mc_co), k_inizio_col+800+kst_barcode_stampa.num_colonne, k_inizio_riga + 300 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	end if
	if LenA(trim(kst_barcode_stampa.sc_cf)) > 0 then
		printtext (ki_id_print_etichette, "Capitolato di Forn.: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 550 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.sc_cf), k_inizio_col+800+kst_barcode_stampa.num_colonne, k_inizio_riga + 490 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	end if
	if LenA(trim(kst_barcode_stampa.area_mag)) > 0 then
		printtext (ki_id_print_etichette, "Area di Ubicazione: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 800 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
		printtext (ki_id_print_etichette, string(trim(kst_barcode_stampa.area_mag),"@@ @@@@@@@@@@"), k_inizio_col+800+kst_barcode_stampa.num_colonne, k_inizio_riga + 740 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	end if
//--- Prodotto...
	k_inizio_riga = 2480 //2560
	k_inizio_col = 450 + k_delta_col
	if LenA(trim(kst_barcode_stampa.normative)) > 0 then
		printtext (ki_id_print_etichette, "Prodotto: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 50 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.normative), k_inizio_col+550+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[9,1]) //kist_barcode_stampa.font[2,1])
	end if
//--- Altezza Pallet...
	k_inizio_riga = 2480
	k_inizio_col = 5130 + k_delta_col
	if kst_barcode_stampa.alt_2 > 100 then
		printtext (ki_id_print_etichette, "Altezza: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 40 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
		printtext (ki_id_print_etichette,  string((kst_barcode_stampa.alt_2 / 10),"####0"), k_inizio_col+350+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[9,1]) 
	end if


//--- Sezione codice modulo e revisione 
	k_inizio_riga = 3680
	k_inizio_col = 4300 + k_delta_col
	printtext (ki_id_print_etichette, "Tag# MN-LT-OPS-001 Rev.3 del 29MAY2019", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])

//--- Linea che chiude il BOX
	k_inizio_riga = 2670
   k_inizio_col = 331 + k_delta_col
//	if trim(kst_barcode_stampa.barcode_modulo) = barcode_modulo_4xpagina then
//		PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\et_bcode_x4.bmp", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, 0, 0) 
//	else
		PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\et_bcode_linea.jpg", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, 0, 0) 
		//PrintBitmap(ki_id_print_etichette, "et_bcode_linea.jpg", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, 0, 0) 
//	end if
	
//--- Sezione BARCODE il codice a BARRE
	k_inizio_col = 50 + k_delta_col 
	stampa_barcode_f ( kst_barcode_stampa.barcode, ki_id_print_etichette, k_inizio_col +(kst_barcode_stampa.barcode_coord_x+kst_barcode_stampa.num_colonne), (kst_barcode_stampa.barcode_coord_y + kst_barcode_stampa.num_righe), kst_barcode_stampa.barcode_altezza, kist_barcode_stampa.font[1,1] )
	//PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[1,1], "Arial", kist_barcode_stampa.font[1,2], kist_barcode_stampa.font[1,3], Fixed!, Modern!, FALSE, FALSE) //ripristino il font

//--- se Etichettatrice (1 etich) allora stampa
//	if trim(kst_barcode_stampa.barcode_modulo) = barcode_modulo_1etichetta then	
		PrintPage ( ki_id_print_etichette )  //--- FORZA salto pagina 
		ki_num_etichetta_in_pag = 1
//	end if

	k_return = true

return k_return



end function

private function boolean stampa_etichetta_dosimetro_rev3 (ref ds_barcode_print_label ads_barcode_print_label, st_tab_meca_dosim kst_tab_meca_dosim, st_tab_barcode kst_tab_barcode_padre, st_tab_base kst_tab_base, st_tab_sl_pt kst_tab_sl_pt, ref st_barcode_stampa kst_barcode_stampa, st_tab_sl_pt_dosimpos kst_tab_sl_pt_dosimpos, ref uo_ds_std_1 ads_meca_dosim_barcode_prg);/*
 Genera Etichetta Barcode di Trattamento

	inp: ds_barcode_print_label  datastore vuoto da riempire con i dati Etichetta
	     .... diversi dati
   out: ds_barcode_print_label  datastore con l'etichetta

	return:  TRUE = ok
*/
boolean k_return
int k_righe=1, k_row_barcode
int k_dosimetro_stampati, k_dosimetro_contati
int k_row
string k_testo_verticale = ""
	
	
	k_row = ads_barcode_print_label.rowcount()
										
	ads_barcode_print_label.object.num_int[k_row] = kst_tab_barcode_padre.num_int
	ads_barcode_print_label.object.data_ent[k_row] = kst_barcode_stampa.data_ent

	ads_barcode_print_label.object.barcode[k_row] = trim(kst_tab_barcode_padre.barcode)
	ads_barcode_print_label.object.barcode_dsm[k_row] = trim(kst_tab_meca_dosim.barcode)

//--- Espone testo avvertenze da PT
	ads_barcode_print_label.object.dosim_et_descr[k_row] = trim(kst_tab_sl_pt.dosim_et_descr)

//--- In VERTICALE
	ads_barcode_print_label.object.dosimpos_codice[k_row] = trim(kst_barcode_stampa.dosimpos_codice) // codice posizione dosimetro es.  POS: 79
	ads_barcode_print_label.object.dosim_tipo_des[k_row] = trim(kst_barcode_stampa.dosim_tipo_des) // Tipo Dosimetro AMBER, RED ....
	ads_barcode_print_label.object.tipo_dose_des[k_row] = trim(kst_barcode_stampa.tipo_dose_des) // Tipo Dose MASSIMA, MINIMA ....
	ads_barcode_print_label.object.dosimpos_descr[k_row] = trim(kst_tab_sl_pt_dosimpos.descr) // I'  riga  della descrizione posizione dosimetri
	ads_barcode_print_label.object.dosimpos_descr1[k_row] = trim(kst_tab_sl_pt_dosimpos.descr1) // II'  riga  della descrizione posizione dosimetri

//--- stampa il nr dosimetro + nr tot dosimetri da stampare
	k_row_barcode = ads_meca_dosim_barcode_prg.find("barcode='" + trim(kst_tab_meca_dosim.barcode) + "'", 1, ads_meca_dosim_barcode_prg.rowcount())
	if k_row_barcode > 0 then
		k_dosimetro_stampati = ads_meca_dosim_barcode_prg.getitemnumber(k_row_barcode, "k_progressivo")
		k_dosimetro_contati = ads_meca_dosim_barcode_prg.getitemnumber(k_row_barcode, "k_contati")
		ads_barcode_print_label.object.dosimetro_stampati[k_row] = k_dosimetro_stampati
		ads_barcode_print_label.object.dosimetro_contati[k_row] = k_dosimetro_contati
	end if
		
//--- stampa 3 righe VERTICALI:l NUM.RIF + WO + COLLI in modo sfasato
	for k_righe = 1 to 3
		choose case k_righe
			case 1
				k_testo_verticale = trim("N: " + string(kst_tab_barcode_padre.num_int) + "  WO: " + string(kst_barcode_stampa.e1doco) &
						  + "  C: " + string(kst_barcode_stampa.conta_barcode,"#") + "." + string (kst_barcode_stampa.barcode_tot_lotto,"#"))
				ads_barcode_print_label.object.rigadati1[k_row] = k_testo_verticale
			case 2
				k_testo_verticale = trim("C: " + string(kst_barcode_stampa.conta_barcode,"#") + "." + string (kst_barcode_stampa.barcode_tot_lotto,"#") &
							+ "  N: " + string(kst_tab_barcode_padre.num_int) + "  WO: " + string(kst_barcode_stampa.e1doco))
				ads_barcode_print_label.object.rigadati2[k_row] = k_testo_verticale
			case else
				k_testo_verticale = trim("WO: " + string(kst_barcode_stampa.e1doco) &
						  + "  C: " + string(kst_barcode_stampa.conta_barcode,"#") + "." + string (kst_barcode_stampa.barcode_tot_lotto,"#") &
						  + "  N: " + string(kst_tab_barcode_padre.num_int) )
				ads_barcode_print_label.object.rigadati3[k_row] = k_testo_verticale
		end choose
	next

//--- se Etichettatrice (1 etich) allora stampa
	ki_num_etichetta_in_pag = 1
		
	k_return = true		
		
	return k_return



end function

public function boolean old_stampa_etichetta_riferimento_r4_2024 (st_barcode_stampa kst_barcode_stampa);//
// stampa 4 etichette di TRATTAMENTO con il codice a barre  
// return:  TRUE = stampa OK
//
boolean k_return 
int k_inizio_riga=0, k_inizio_col=0, k_inizio_col_barcode = 0, k_delta_col=0, k_delta_col_barcode
kuf_armo kuf1_armo


	SetPointer(kkg.pointer_attesa)

	u_set_font_default( ) //--- Imposta i FONT di default

//--- sposta la stampa di tot colonne 250=circa 10 mm
	k_delta_col = -150 //-185
	k_delta_col_barcode = -230

// stampa il logo ad inizio foglio
	k_inizio_riga = 1
   k_inizio_col = 300 + k_delta_col
//	PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + kkg.path_sep + "et_bcode_rev4.jpg", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, 0, 0) 
	kst_barcode_stampa.num_righe += 30
	PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + kkg.path_sep + "logo_barcode.jpg", k_inizio_col+ 50 +kst_barcode_stampa.num_colonne, k_inizio_riga - 80 + kst_barcode_stampa.num_righe, 1600, 500)  //2500, 500)

//--- Testata BOLLINO VIRANTE
	k_inizio_riga = 1  
	k_inizio_col = 3250 + k_delta_col
	printtext (ki_id_print_etichette, "BOLLINO VIRANTE", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	printtext (ki_id_print_etichette, "Indicatore del trattamento con raggi", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 180 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
	printtext (ki_id_print_etichette, "gamma della merce del lotto", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga +180+110 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])


//--- Dicitura TESTATA
	k_inizio_col = 1730
	choose case kst_barcode_stampa.magazzino
		case kuf1_armo.kki_magazzino_DATRATTARE
			printtext (ki_id_print_etichette, "", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga -100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
		case kuf1_armo.kki_magazzino_dp
			printtext (ki_id_print_etichette, "CONTO DEPOSITO", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga -100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
		case kuf1_armo.kki_magazzino_rd
			printtext (ki_id_print_etichette, "STUDIO&SVILUPPO", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga -100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
		case else
			printtext (ki_id_print_etichette, "MAG.NO TRATTAM.", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga -100 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
	end choose

//--- Sezione Anagrafiche Clienti 
	k_inizio_riga = 520  
	k_inizio_col = 400 + k_delta_col
	printtext (ki_id_print_etichette, "Cliente:", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.clie_3,"####0") , k_inizio_col+500+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
	printtext (ki_id_print_etichette, left(trim(kst_barcode_stampa.rag_soc_20),23) , k_inizio_col+750+kst_barcode_stampa.num_colonne, k_inizio_riga - 70 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[3,1])
	printtext (ki_id_print_etichette, "Ricevente:", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga +200 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.clie_2,"####0") , k_inizio_col+500+kst_barcode_stampa.num_colonne, k_inizio_riga + 200 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
	printtext (ki_id_print_etichette, left(trim(kst_barcode_stampa.rag_soc_10),23) , k_inizio_col+750+kst_barcode_stampa.num_colonne, k_inizio_riga + 140 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[3,1])

//--- Sezione DDT 
	k_inizio_riga = 520  
	k_inizio_col = 4300 + k_delta_col	
	printtext (ki_id_print_etichette, "DDT: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.data_bolla_in,"dd mmm yy"), k_inizio_col+500+kst_barcode_stampa.num_colonne, k_inizio_riga - 50 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	printtext (ki_id_print_etichette, left(trim(kst_barcode_stampa.num_bolla_in),18), k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 200 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])

//--- Linea 
	k_inizio_riga = 930  
	k_inizio_col = 340 + k_delta_col	
	PrintLine(ki_id_print_etichette, k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, k_inizio_col+5700+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, 10) 

//--- Sezione codici Riferimento
	k_inizio_riga = 1100 //1480 
	k_inizio_col =  400 + k_delta_col  //2750
	printtext (ki_id_print_etichette, "RIF: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + 200 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.num_int,"#") , k_inizio_col + 185+kst_barcode_stampa.num_colonne, k_inizio_riga - 150 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[5,1])
//--- Collo 
	printtext (ki_id_print_etichette, "Collo: ", k_inizio_col+kst_barcode_stampa.num_colonne+1700, k_inizio_riga + 200 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.conta_barcode,"####0") + "." + string (kst_barcode_stampa.barcode_tot_lotto,"####0") &
															 , k_inizio_col+kst_barcode_stampa.num_colonne+1965, k_inizio_riga - 55 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
//--- Sezione codici E1-WO, E1-SO 
	printtext (ki_id_print_etichette, "WO: ", k_inizio_col+kst_barcode_stampa.num_colonne + 3080, k_inizio_riga + 200 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.e1doco,"#") , k_inizio_col + 3400+kst_barcode_stampa.num_colonne, k_inizio_riga - 150 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[5,1])
	printtext (ki_id_print_etichette, "SO: ", k_inizio_col+kst_barcode_stampa.num_colonne + 3880, k_inizio_riga + 500 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
	printtext (ki_id_print_etichette, string(kst_barcode_stampa.e1rorn,"#") , k_inizio_col + 4100+kst_barcode_stampa.num_colonne, k_inizio_riga + 430 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])

//--- Sezione NUMERO BARCODE 
	k_inizio_riga = 2600 //2730
	k_inizio_col_barcode = k_delta_col_barcode + 420 //350
	printtext (ki_id_print_etichette, string(trim(kst_barcode_stampa.barcode),"@@@ @@@@@"), k_inizio_col_barcode+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[7,1])

//--- Impianto di Trattamento G2/G3	
	if Len(trim(kst_barcode_stampa.area_mag)) > 0 then
		k_inizio_riga = 1600
		k_inizio_col = 2750 + k_delta_col  
		printtext (ki_id_print_etichette, "IMPIANTO: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
		if kst_barcode_stampa.impianto = 3 then
			printtext (ki_id_print_etichette, "Gamma 3", k_inizio_col+520+kst_barcode_stampa.num_colonne, k_inizio_riga - 60 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
		else
			printtext (ki_id_print_etichette, "Gamma 2", k_inizio_col+520+kst_barcode_stampa.num_colonne, k_inizio_riga - 60 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
		end if
	end if

//--- Data di ENTRATA
	k_inizio_riga = 1530 
	k_inizio_col = 5300 + k_delta_col 
	if isnull(kst_barcode_stampa.et_bcode_st_dt_rif) or kst_barcode_stampa.et_bcode_st_dt_rif <> "N" then
		printtext (ki_id_print_etichette, string(kst_barcode_stampa.data_ent,"dd.mmm.yy") , k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	end if
		
//--- Sezione CONTRATTI
	if Len(trim(kst_barcode_stampa.mc_co)) > 0 then
		k_inizio_riga = 1830
		k_inizio_col = 2750 + k_delta_col  
		printtext (ki_id_print_etichette, "CO: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.mc_co), k_inizio_col+250+kst_barcode_stampa.num_colonne, k_inizio_riga -50 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	end if
	if Len(trim(kst_barcode_stampa.sc_cf)) > 0 then
		k_inizio_riga = 1830
		k_inizio_col = 4280 + k_delta_col  
		printtext (ki_id_print_etichette, "CF: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.sc_cf), k_inizio_col+210+kst_barcode_stampa.num_colonne, k_inizio_riga - 50 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[2,1])
	end if
	
//--- UBICAZIONE	
	if Len(trim(kst_barcode_stampa.area_mag)) > 0 then
		k_inizio_riga = 2220
		k_inizio_col = 2750 + k_delta_col  
		printtext (ki_id_print_etichette, "Area di Ubicazione: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
		printtext (ki_id_print_etichette, string(trim(kst_barcode_stampa.area_mag),"@@ @@@@@@@@@@"), k_inizio_col+800+kst_barcode_stampa.num_colonne, k_inizio_riga - 240 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[6,1])
	end if

//--- Prodotto...
	k_inizio_riga = 2500 //2560
	k_inizio_col = 450 + k_delta_col
	if LenA(trim(kst_barcode_stampa.normative)) > 0 then
		printtext (ki_id_print_etichette, "Prodotto: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
		printtext (ki_id_print_etichette, trim(kst_barcode_stampa.normative), k_inizio_col+550+kst_barcode_stampa.num_colonne, k_inizio_riga -50 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[9,1]) //kist_barcode_stampa.font[2,1])
	end if
//--- Altezza Pallet...
	k_inizio_riga = 2500
	k_inizio_col = 5130 + k_delta_col
	if kst_barcode_stampa.alt_2 > 100 then
		printtext (ki_id_print_etichette, "Altezza: ", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])
		printtext (ki_id_print_etichette,  string((kst_barcode_stampa.alt_2 / 10),"####0"), k_inizio_col+350+kst_barcode_stampa.num_colonne, k_inizio_riga -50 + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[9,1]) 
	end if


//--- Sezione codice modulo e revisione 
	k_inizio_riga = 3680
	k_inizio_col = 4300 + k_delta_col
	printtext (ki_id_print_etichette, "Tag# MN-LT-OPS-001 Rev.4 - GEN2024", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])

//--- Linea che chiude il BOX
	k_inizio_riga = 2670
	k_inizio_col = 340 + k_delta_col	
	PrintLine(ki_id_print_etichette, k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, k_inizio_col+5700+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, 10) 
	
//--- Sezione BARCODE il codice a BARRE
	k_inizio_col = 50 + k_delta_col 
	stampa_barcode_f ( kst_barcode_stampa.barcode, ki_id_print_etichette, k_inizio_col +(kst_barcode_stampa.barcode_coord_x+kst_barcode_stampa.num_colonne), (kst_barcode_stampa.barcode_coord_y + kst_barcode_stampa.num_righe), kst_barcode_stampa.barcode_altezza, kist_barcode_stampa.font[1,1] )

//--- se Etichettatrice (1 etich) allora stampa
	PrintPage ( ki_id_print_etichette )  //--- FORZA salto pagina 
	ki_num_etichetta_in_pag = 1

	k_return = true

return k_return



end function

public function integer stampa_etichetta_riferimento_avvertenze (string k_barcode, long k_id_meca);//
// stampa AVVERTENZE dell'etichetta per Barcode di entrata 
// return:  numero di barcode stampati 0=nessuno
//
string k_nessuna_elab="N"
string k_barcode_x
int k_barcode_tot_lotto, k_conta_barcode=0, k_barcode_gia_stampati=0, k_etichette_stampate=0
int k_ds_idx
boolean k_chiudi_a_fine_routine
uo_ds_std_1 kds_ds_contratti_et_bcode_note_l
st_barcode_stampa kst_barcode_stampa
st_tab_contratti kst_tab_contratti
st_tab_base kst_tab_base
pointer kpointer  // Declares a pointer variable


declare kc_listview cursor for
	SELECT 
         barcode.barcode,
         barcode.num_int,   
         meca.data_ent,   
    	   meca.clie_2, 
         meca.clie_3, 
			meca.num_bolla_in,
			meca.data_bolla_in,
			meca.area_mag,
			meca.e1doco,
			meca.e1rorn,
			meca.contratto,
			contratti.mc_co,
			contratti.sc_cf,
			contratti.et_bcode_st_dt_rif,
			c2.rag_soc_10,
			c3.rag_soc_10
    FROM barcode inner JOIN meca ON 
	       barcode.id_meca = meca.id
			 LEFT OUTER JOIN clienti c2 ON 
			 meca.clie_2 = c2.codice
			 LEFT OUTER JOIN clienti c3 ON 
			 meca.clie_3 = c3.codice
			 LEFT OUTER JOIN contratti ON 
			 meca.contratto = contratti.codice
    WHERE 
	       barcode.id_meca = :k_id_meca
			 and barcode.barcode like :k_barcode
	 order by
		 barcode.barcode;
//         barcode.data_stampa,
//			 LEFT OUTER JOIN armo ON 
//			 barcode.id_armo = armo.id_armo)

//			contratti.et_bcode_note,

	declare kc_barcode_conta cursor  for
		SELECT barcode.barcode 
			FROM barcode 
		WHERE barcode.id_meca = :k_id_meca
		order by barcode.barcode using sqlca;

//=== Puntatore Cursore da attesa.....
	kpointer = SetPointer(HourGlass!)

	k_conta_barcode = 0
	k_barcode_gia_stampati = 0
	k_barcode_tot_lotto = 0
	k_etichette_stampate=0
	k_barcode = trim(k_barcode)
//	kst_tab_barcode.barcode = trim(k_barcode)


//
//=== Controlla se funzione Autorizzata o meno 
//
	if not ki_stampa_etichetta_autorizza then 
		
		stampa_etichetta_riferimento_autorizza()
		
	end if
	
	if ki_stampa_etichetta_autorizza then

		if isnull(k_barcode) then
			k_barcode = " "
		end if
		
		SELECT count(*)
			into :k_barcode_gia_stampati  
		 FROM barcode 
		 WHERE 
				 barcode.id_meca = :k_id_meca
				 and barcode.data_stampa > convert(date,'01.01.1899')  
				 and (barcode = :k_barcode  or :k_barcode = ' ')
 		   using sqlca;
		if sqlca.sqlcode <> 0 then
			k_barcode_gia_stampati = 0
		end if
	
//--- conto il numero totale di barcode da esporre in etichetta	
		SELECT count(*)
			into :k_barcode_tot_lotto  
		 FROM barcode 
		 WHERE 
				 barcode.id_meca = :k_id_meca
		 using sqlca;


//--- Stampa dell'intero riferimento ?
		k_barcode = trim(k_barcode)
		if LenA(k_barcode) = 0  then
			k_barcode = "%"
		else
//--- se ho richiesto solo la stampa di 1 barcode... faccio solo quella				
//---  e ricavo il numero del barcode in cui sono x fare stampa: n di nn
			open kc_barcode_conta;
			if sqlca.sqlcode = 0 then
				
				do 
					k_conta_barcode++
					fetch kc_barcode_conta into :k_barcode_x;
				loop while trim(k_barcode_x) <> k_barcode and sqlca.sqlcode = 0
				
				close kc_barcode_conta;
				
			end if
			
		end if
 
	end if

//--- se query ok e funzione Abilitata
	if sqlca.sqlcode = 0 and ki_stampa_etichetta_autorizza then

//--- individuo il tipo modulo x etichette codici a barre da stampare (2 etich x foglio A3 o 4 etic x foglio A4 o su etichettarice...)
		kst_tab_base.barcode_modulo = kGuf_data_base.ki_barcode_modulo // trim(MidA(kuf1_base.prendi_dato_base( "barcode_modulo"),2))

		open kc_listview;
		
		if sqlca.sqlcode = 0 then

			if ki_id_print_etichette = 0 then   // se streamer stampa non ancora open...
			   k_chiudi_a_fine_routine = true
				stampa_etichetta_riferimento_open(k_id_meca, true)
			end if

			if ki_id_print_etichette = 0 then   // se streamer stampa non open...
				k_nessuna_elab = "S"
			end if
				
			if	k_nessuna_elab <> "S" then
				
				if trim(kst_tab_base.barcode_modulo) = barcode_modulo_etich_2019 then
//--- Imposta i FONT di default
					u_set_font_default( )
//--- personalizza il font 7	
					PrintDefineFont(ki_id_print_etichette, 7, ki_font_name[7], -52, 400, Fixed!, Modern!, FALSE, FALSE)
				end if

//--- prima lettura fuori ciclo	
				fetch kc_listview 
					into
						  :kst_barcode_stampa.barcode
						 ,:kst_barcode_stampa.num_int   
						 ,:kst_barcode_stampa.data_ent
						 ,:kst_barcode_stampa.clie_2  
						 ,:kst_barcode_stampa.clie_3  
						 ,:kst_barcode_stampa.num_bolla_in 
						 ,:kst_barcode_stampa.data_bolla_in 
						 ,:kst_barcode_stampa.area_mag
						 ,:kst_barcode_stampa.e1doco
						 ,:kst_barcode_stampa.e1rorn
						 ,:kst_tab_contratti.codice
						 ,:kst_barcode_stampa.mc_co
						 ,:kst_barcode_stampa.sc_cf
 						 ,:kst_barcode_stampa.et_bcode_st_dt_rif
						 ,:kst_barcode_stampa.rag_soc_20 
						 ,:kst_barcode_stampa.rag_soc_10 
						  ;

//--- Legge et_bcode_note splittato dal ';' per fare il 'a capo'
				if kst_tab_contratti.codice > 0 then
					kds_ds_contratti_et_bcode_note_l = create uo_ds_std_1
					kds_ds_contratti_et_bcode_note_l.dataobject = "ds_contratti_et_bcode_note_l"
					kds_ds_contratti_et_bcode_note_l.settransobject(kguo_sqlca_db_magazzino)
					kds_ds_contratti_et_bcode_note_l.retrieve(kst_tab_contratti.codice)
				end if
	
				if isnull(kist_tab_barcode_stampa_save.num_int) then kist_tab_barcode_stampa_save.num_int = 0
		
//------------------------------------------------------------------------------------------------------------------------------------ CICLO LETTURE
//13-07-10 da oggi solo UNA etichetta 				do while sqlca.sqlcode = 0 and k_nessuna_elab <> "S"
				if sqlca.sqlcode = 0 and k_nessuna_elab <> "S" then

//					stampa_etichetta_riferimento_avv_rev1(kst_barcode_stampa)
//--- contatore delle etichette stampate
					k_etichette_stampate++
				
//--- se ho richiesto la stampa di tutti i barcode
					if k_barcode = "%"  then
						k_conta_barcode++
					end if
				
					ki_num_etichetta_in_pag ++
					kst_barcode_stampa.conta_barcode = k_conta_barcode
					kst_barcode_stampa.barcode_tot_lotto = k_barcode_tot_lotto

					if trim(kst_tab_base.barcode_modulo) = barcode_modulo_etich_2019 then
						stampa_etichetta_riferimento_avv_rev1(kst_barcode_stampa, kds_ds_contratti_et_bcode_note_l )
					else
						k_ds_idx = u_get_idx_ds_barcode_print_label("d_barcode_et_avv_rev_2_gen24", k_id_meca)  // recupera il n.array del ds 
						kids_barcode_print_label[k_ds_idx].insertrow(0)
						stampa_etichetta_riferimento_avv_rev2(kids_barcode_print_label[k_ds_idx], kst_barcode_stampa, kds_ds_contratti_et_bcode_note_l)
					end if
					
					ki_num_etichetta_in_pag = 1
	
				end if

			end if

//--- Spedisce la stampa alla dispositivo e chiude la coda 
			if k_chiudi_a_fine_routine then   
				stampa_etichetta_riferimento_close()
//				PrintClose(ki_id_print_etichette)
			end if
			
		end if
		
		close kc_listview;

	end if

	if isvalid(kds_ds_contratti_et_bcode_note_l) then destroy kds_ds_contratti_et_bcode_note_l

	SetPointer(kpointer)
	

	return k_etichette_stampate

end function

public function boolean stampa_etichetta_riferimento_avv_rev1 (st_barcode_stampa ast_barcode_stampa, ref uo_ds_std_1 ads_ds_contratti_et_bcode_note_l);//// stampa AVVERTENZE dell'etichetta per Barcode di entrata 
// return:  numero di barcode stampati 0=nessuno
//
boolean k_return
int k_rc=0, k_i, k_row
st_tab_contratti kst_tab_contratti
int k_num_righe = 1, k_inizio_riga=0, k_inizio_col=0
int k_num_colonne = 0, k_len_max


//--- Imposta i FONT di default
//	u_set_font_default( )

//--- personalizza il font 7	
//	PrintDefineFont(ki_id_print_etichette, 7, ki_font_name[7], -52, 400, Fixed!, Modern!, FALSE, FALSE)

//--- se sono su etichettatrice 
		k_num_colonne = -150
		k_num_righe = 200

// stampa il logo ad inizio foglio
		PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\et_bcode_x4_avvertenze.bmp", 300+k_num_colonne, 1+ k_num_righe, 0, 0) //2400, 750) 
		PrintBitmap(ki_id_print_etichette, kGuo_path.get_risorse() + "\logo_barcode.jpg", 400+k_num_colonne, 25 + k_num_righe, 1600, 500) //2500, 500)

//--- Sezione Anagrafiche Clienti 
		k_inizio_riga = 720
		k_inizio_col = 450
		printtext (ki_id_print_etichette, "Cliente :", k_inizio_col+k_num_colonne, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[1,1])
		printtext (ki_id_print_etichette, "Ricevente :", k_inizio_col+k_num_colonne, k_inizio_riga +300 + k_num_righe, kist_barcode_stampa.font[1,1])
		printtext (ki_id_print_etichette, string(ast_barcode_stampa.clie_3,"####0") , k_inizio_col+550+k_num_colonne, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[1,1])
		printtext (ki_id_print_etichette, string(ast_barcode_stampa.clie_2,"####0") , k_inizio_col+550+k_num_colonne, k_inizio_riga + 300 + k_num_righe, kist_barcode_stampa.font[1,1])
		printtext (ki_id_print_etichette, trim(ast_barcode_stampa.rag_soc_10) , k_inizio_col+850+k_num_colonne, k_inizio_riga - 80 + k_num_righe, kist_barcode_stampa.font[3,1])
		printtext (ki_id_print_etichette, trim(ast_barcode_stampa.rag_soc_20) , k_inizio_col+850+k_num_colonne, k_inizio_riga + 220 + k_num_righe, kist_barcode_stampa.font[3,1])

//--- Sezione Riferimento
		k_inizio_col = 520   //2750
		k_inizio_riga = 1480  //1500
		printtext (ki_id_print_etichette, "RIF.: ", k_inizio_col+k_num_colonne, k_inizio_riga + 100 + k_num_righe, kist_barcode_stampa.font[2,1])
		printtext (ki_id_print_etichette, string(ast_barcode_stampa.num_int,"####0") , k_inizio_col + 400+k_num_colonne, k_inizio_riga - 170 + k_num_righe, kist_barcode_stampa.font[5,1])
		if isnull(ast_barcode_stampa.et_bcode_st_dt_rif) or ast_barcode_stampa.et_bcode_st_dt_rif <> "N" then
			printtext (ki_id_print_etichette, string(ast_barcode_stampa.data_ent,"dd/mm/yy") , k_inizio_col+1800+k_num_colonne, k_inizio_riga + 100 + k_num_righe, kist_barcode_stampa.font[2,1])
		end if

//--- Sezione Lotto
		k_inizio_col = 3200   //2750
		k_inizio_riga = 1480  //1500
		printtext (ki_id_print_etichette, "Lotto: ", k_inizio_col+k_num_colonne, k_inizio_riga + 100 + k_num_righe, kist_barcode_stampa.font[2,1])
		printtext (ki_id_print_etichette, string(ast_barcode_stampa.conta_barcode,"####0") + "." + string (ast_barcode_stampa.barcode_tot_lotto,"####0") &
						, k_inizio_col+700+k_num_colonne, k_inizio_riga -120 + k_num_righe, kist_barcode_stampa.font[6,1])

//--- Sezione Area Ubicazione
		k_inizio_riga = 3400
		k_inizio_col = 3200   
		if LenA(trim(ast_barcode_stampa.area_mag)) > 0 then
			printtext (ki_id_print_etichette, "Area di Ubicazione: ", k_inizio_col+k_num_colonne, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[1,1])
			printtext (ki_id_print_etichette, string(trim(ast_barcode_stampa.area_mag),"@@ @@@@@@@@@@"), k_inizio_col+800+k_num_colonne, k_inizio_riga - 80 + k_num_righe, kist_barcode_stampa.font[2,1])
		end if

//--- Sezione NOTE
		k_inizio_riga = 2200
		for k_row = 1 to ads_ds_contratti_et_bcode_note_l.rowcount( ) 
			kst_tab_contratti.et_bcode_note = trim(ads_ds_contratti_et_bcode_note_l.getitemstring(k_row,"et_bcode_note")) + space(120)
			k_i = 1
			k_len_max = 50
			do while trim(mid(kst_tab_contratti.et_bcode_note, k_i, k_len_max)) > " "
				k_inizio_col = 520 
				printtext (ki_id_print_etichette, trim(mid(kst_tab_contratti.et_bcode_note,k_i,k_len_max)), k_inizio_col+k_num_colonne, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[2,1])
				k_inizio_riga += 300 // next row
				k_i += k_len_max
			loop
		next	

//--- se Etichettatrice (1 etich) allora stampo				
		PrintPage ( ki_id_print_etichette )  //--- FORZA salto pagina 
					
	k_return = true

return k_return

end function

public function boolean stampa_etichetta_riferimento_avv_rev2 (ref ds_barcode_print_label ads_barcode_print_label, st_barcode_stampa ast_barcode_stampa, ref uo_ds_std_1 ads_ds_contratti_et_bcode_note_l);/*
  stampa AVVERTENZE etichetta per Barcode di entrata REV.2
  return:  numero di barcode stampati 0=nessuno
*/
boolean k_return
int k_row, k_row_note
string k_note


	SetPointer(kkg.pointer_attesa)

	k_row = ads_barcode_print_label.rowcount()

//--- Sezione Anagrafiche Clienti 
	ads_barcode_print_label.object.clie_3[k_row] = ast_barcode_stampa.clie_3
	ads_barcode_print_label.object.rag_soc_3[k_row] = trim(ast_barcode_stampa.rag_soc_10)
	ads_barcode_print_label.object.clie_2[k_row] = ast_barcode_stampa.clie_2
	ads_barcode_print_label.object.rag_soc_2[k_row] = trim(ast_barcode_stampa.rag_soc_20)

//--- Sezione Riferimento
	ads_barcode_print_label.object.num_int[k_row] = ast_barcode_stampa.num_int
	if isnull(ast_barcode_stampa.et_bcode_st_dt_rif) or ast_barcode_stampa.et_bcode_st_dt_rif <> "N" then
		ads_barcode_print_label.object.data_ent[k_row] = ast_barcode_stampa.data_ent
	end if

//--- Sezione DDT
	ads_barcode_print_label.object.data_bolla_in[k_row] = ast_barcode_stampa.data_bolla_in
	ads_barcode_print_label.object.num_bolla_in[k_row] = trim(ast_barcode_stampa.num_bolla_in)

//--- Sezione Lotto
	ads_barcode_print_label.object.num_int[k_row] = ast_barcode_stampa.num_int
	ads_barcode_print_label.object.collo_n[k_row] = ast_barcode_stampa.conta_barcode
	ads_barcode_print_label.object.colli_tot[k_row] = ast_barcode_stampa.barcode_tot_lotto
									
//--- Sezione codici E1-WO, E1-SO, CF, CO 
	ads_barcode_print_label.object.e1doco[k_row] = ast_barcode_stampa.e1doco
	ads_barcode_print_label.object.e1rorn[k_row] = ast_barcode_stampa.e1rorn
	ads_barcode_print_label.object.mc_co[k_row] = trim(ast_barcode_stampa.mc_co)
	ads_barcode_print_label.object.sc_cf[k_row] = trim(ast_barcode_stampa.sc_cf)

//--- Impianto di Trattamento G2/G3	
	if ast_barcode_stampa.impianto > 0 then
		if ast_barcode_stampa.impianto = 3 then
			ads_barcode_print_label.object.impianto_descr[k_row] = "Gamma 3"
		else
			ads_barcode_print_label.object.impianto_descr[k_row] = "Gamma 2"
		end if
	else
		ads_barcode_print_label.object.impianto_descr[k_row] = " "
	end if

//--- Sezione Area Ubicazione
	if trim(ast_barcode_stampa.area_mag) > " " then
		ads_barcode_print_label.object.area_mag[k_row] = trim(ast_barcode_stampa.area_mag)
	else
		ads_barcode_print_label.object.area_mag[k_row] = " "
	end if

//--- Sezione NOTE
	ads_barcode_print_label.object.avvertenze[k_row] = " "
	for k_row_note = 1 to ads_ds_contratti_et_bcode_note_l.rowcount( ) 
		k_note += trim(ads_ds_contratti_et_bcode_note_l.getitemstring(k_row_note,"et_bcode_note")) + " "
	next	
	ads_barcode_print_label.object.avvertenze[k_row] = k_note

//--- se Etichettatrice (1 etich) allora stampo				
//	PrintPage ( ki_id_print_etichette )  //--- FORZA salto pagina 
					
	k_return = true

return k_return

end function

public function integer stampa_etichetta_riferimento_rev4 (ref ds_barcode_print_label ads_barcode_print_label, st_barcode_stampa ast_barcode_stampa);/*
 Genera Etichetta Barcode di Trattamento

	inp: ds_barcode_print_label  datastore vuoto da riempire con i dati Etichetta
	     st_barcode_stampa diversi dati
   out: ds_barcode_print_label  datastore con l'etichetta

	return:  numero di riga
*/
int k_return 
int k_row
kuf_armo kuf1_armo


	SetPointer(kkg.pointer_attesa)

	k_row = ads_barcode_print_label.rowcount()
	
//--- Dicitura TESTATA
	choose case ast_barcode_stampa.magazzino
		case kuf1_armo.kki_magazzino_DATRATTARE
			ads_barcode_print_label.object.testata[k_row] = ""
		case kuf1_armo.kki_magazzino_dp
			ads_barcode_print_label.object.testata[k_row] = "CONTO DEPOSITO"
		case kuf1_armo.kki_magazzino_rd
			ads_barcode_print_label.object.testata[k_row] = "STUDIO&SVILUPPO"
		case else
			ads_barcode_print_label.object.testata[k_row] = "MAG.NO TRATTAM."
	end choose

//--- Sezione Anagrafiche Clienti 
	ads_barcode_print_label.object.clie_3[k_row] = ast_barcode_stampa.clie_3
	ads_barcode_print_label.object.rag_soc_3[k_row] = trim(ast_barcode_stampa.rag_soc_20)
	ads_barcode_print_label.object.clie_2[k_row] = ast_barcode_stampa.clie_2
	ads_barcode_print_label.object.rag_soc_2[k_row] = trim(ast_barcode_stampa.rag_soc_10)

//--- Sezione codici Riferimento
	ads_barcode_print_label.object.num_int[k_row] = ast_barcode_stampa.num_int
	if isnull(ast_barcode_stampa.et_bcode_st_dt_rif) or ast_barcode_stampa.et_bcode_st_dt_rif <> "N" then
		ads_barcode_print_label.object.data_ent[k_row] = ast_barcode_stampa.data_ent
	else
		ads_barcode_print_label.object.data_ent[k_row] = date(0)
	end if

//--- Sezione DDT
	ads_barcode_print_label.object.data_bolla_in[k_row] = ast_barcode_stampa.data_bolla_in
	ads_barcode_print_label.object.num_bolla_in[k_row] = trim(ast_barcode_stampa.num_bolla_in)

//--- Colli
	ads_barcode_print_label.object.collo_n[k_row] = ast_barcode_stampa.conta_barcode
	ads_barcode_print_label.object.colli_tot[k_row] = ast_barcode_stampa.barcode_tot_lotto
										
//--- Sezione codici E1-WO, E1-SO 
	ads_barcode_print_label.object.e1doco[k_row] = ast_barcode_stampa.e1doco
	ads_barcode_print_label.object.e1rorn[k_row] = ast_barcode_stampa.e1rorn

//--- Impianto di Trattamento G2/G3	
	if ast_barcode_stampa.impianto > 0 then
		if ast_barcode_stampa.impianto = 3 then
			ads_barcode_print_label.object.impianto_descr[k_row] = "Gamma 3"
		else
			ads_barcode_print_label.object.impianto_descr[k_row] = "Gamma 2"
		end if
	else
		ads_barcode_print_label.object.impianto_descr[k_row] = ""
	end if
		
//--- Sezione CONTRATTI
	if trim(ast_barcode_stampa.mc_co) > " " then
		ads_barcode_print_label.object.mc_co[k_row] = trim(ast_barcode_stampa.mc_co)
	else
		ads_barcode_print_label.object.mc_co[k_row] = ""
	end if
	if trim(ast_barcode_stampa.sc_cf) > " " then
		ads_barcode_print_label.object.sc_cf[k_row] = trim(ast_barcode_stampa.sc_cf)
	else
		ads_barcode_print_label.object.sc_cf[k_row] = ""
	end if
	
//--- UBICAZIONE	
	if trim(ast_barcode_stampa.area_mag) > " " then
		ads_barcode_print_label.object.area_mag[k_row] = trim(ast_barcode_stampa.area_mag)
	else
		ads_barcode_print_label.object.area_mag[k_row] = ""
	end if

//--- Prodotto...
//	if LenA(trim(ast_barcode_stampa.normative)) > 0 then
//		ads_barcode_print_label.object.normative[k_row] = trim(ast_barcode_stampa.normative)
//	else
		ads_barcode_print_label.object.pt_tipo[k_row] = trim(ast_barcode_stampa.sl_pt_tipo_descr)
//	end if
//--- Altezza Pallet...
	if ast_barcode_stampa.alt_2 > 100 then
		ads_barcode_print_label.object.alt_2[k_row] = ast_barcode_stampa.alt_2
	else
		ads_barcode_print_label.object.alt_2[k_row] = 0
	end if

//--- Sezione BARCODE 
	ads_barcode_print_label.object.barcode[k_row] = trim(ast_barcode_stampa.barcode)

	k_return = k_row

return k_return

end function

private function boolean stampa_etichetta_dosimetro_rev2 (st_tab_meca_dosim kst_tab_meca_dosim, st_tab_barcode kst_tab_barcode_padre, st_tab_base kst_tab_base, st_tab_sl_pt kst_tab_sl_pt, ref st_barcode_stampa kst_barcode_stampa, st_tab_sl_pt_dosimpos kst_tab_sl_pt_dosimpos, ref uo_ds_std_1 ads_meca_dosim_barcode_prg);//
// stampa Etichetta Barcode x il Dosimetro da accompagnare a un Barcode di Trattamento
// return:  TRUE = OK stampato
//
boolean k_return=true
boolean k_flacapo=true
//string k_barcode_x
int k_barcode_altezza=0, k_barcode_coord_x, k_barcode_coord_y
//date k_dataoggi 
constant int k_num_righe_giu=5800 
constant int k_num_righe_giu_x4=4020  
constant int k_num_col_dx_x4=5450 
boolean k_monoetichetta = false
int k_num_righe = 1, k_inizio_riga=0, k_inizio_col=0, k_avanza_col=0, k_righe=1
int k_num_colonne = 0, k_row_barcode
int k_dosimetro_stampati, k_dosimetro_contati
string k_testo_verticale = ""
int k_len, k_ind

		
//	if trim(kst_tab_base.barcode_modulo) = barcode_modulo_4xpagina or trim(kst_tab_base.barcode_modulo) = barcode_modulo_1etichetta then
		k_barcode_coord_x = (2.0 / 2.54) * 520   //--- (Xcm / coeff di conv x pollici) * migliaia
		k_barcode_coord_y = (7.0 / 2.54) * 660   //--- (Xcm / coeff di conv x pollici) * migliaia
		k_barcode_altezza = (0.6 / 2.54) * 1200   //--- (Xcm / coeff di conv x pollici) * migliaia
//	else		
//		k_barcode_coord_x = (2.0 / 2.54) * 1000   //--- (Xcm / coeff di conv x pollici) * migliaia
//		k_barcode_coord_y = (7.0 / 2.54) * 1000   //--- (Xcm / coeff di conv x pollici) * migliaia
//		k_barcode_altezza = (0.6 / 2.54) * 1000   //--- (Xcm / coeff di conv x pollici) * migliaia
//	end if

					
//--- MODULO A 4 ETICHETTE OPPURE 1 SU ETICHETTATRICE ----------------------------------------------------------------------------------------------------------------------------------- 
//	if trim(kst_tab_base.barcode_modulo) = barcode_modulo_4xpagina or trim(kst_tab_base.barcode_modulo) = barcode_modulo_1etichetta then

//--- a rottura di riferimento se 4 etichette  salta pagina 
//		if trim(kst_tab_base.barcode_modulo) = barcode_modulo_4xpagina then
//			if kist_tab_barcode_stampa_save.num_int <> kst_tab_barcode_padre.num_int	 then
//				kist_tab_barcode_stampa_save.num_int = kst_tab_barcode_padre.num_int	
//				if ki_num_etichetta_in_pag > 1 then
//					ki_num_etichetta_in_pag = 5         //--- forza salto pagina 			
//				end if
//			end if
//		end if
//--- Numero etichetta?
//		if trim(kst_tab_base.barcode_modulo) = barcode_modulo_4xpagina then
//			choose case ki_num_etichetta_in_pag
//					
//				case 1
//					k_num_colonne = -300
//					k_num_righe = 0
//					
//				case 2
//					k_num_colonne = -300
//					k_num_righe = k_num_righe_giu_x4
//					
//				case 3
//					k_num_colonne = k_num_col_dx_x4
//					k_num_righe = 0
//					
//				case 4
//					k_num_colonne = k_num_col_dx_x4
//					k_num_righe = k_num_righe_giu_x4
//					
//				case else
////--- salto pagina 
//						PrintPage ( ki_id_print_etichette )
//						ki_num_etichetta_in_pag = 1
//						k_num_colonne = -300
//						k_num_righe = 0
//			end choose
//		end if

//--- se sono su etichettatrice 
//		if trim(kst_tab_base.barcode_modulo) = barcode_modulo_1etichetta then
			k_num_colonne = -150
			k_num_righe = 200
//		end if

// stampa il logo ad inizio foglio
		PrintBitmap(ki_id_print_etichette, kguo_path.get_risorse( )+ KKG.PATH_SEP + "logo_barcode.jpg", 400+k_num_colonne, 25 + k_num_righe, 1600, 500)  //2500, 500)

//--- Descrizione
		k_inizio_riga = 690
		k_inizio_col = 450
		printtext (ki_id_print_etichette, "ETICHETTA DOSIMETRO", k_inizio_col+k_num_colonne, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[2,1])

//--- Sezione Riferimento al PADRE 
		k_inizio_riga = 870
		k_inizio_col = 400
		printtext (ki_id_print_etichette, "Associato al collo: ", k_inizio_col + k_num_colonne, k_inizio_riga + 120 + k_num_righe, kist_barcode_stampa.font[1,1])
		printtext (ki_id_print_etichette, string(trim(kst_tab_barcode_padre.barcode), "@@@ @@@@@@@@@@@@@") , k_inizio_col+850+k_num_colonne, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[4,1])
		printtext (ki_id_print_etichette, "RIF: ", k_inizio_col+k_num_colonne, k_inizio_riga + 550 + k_num_righe, kist_barcode_stampa.font[1,1])
		printtext (ki_id_print_etichette, string(kst_tab_barcode_padre.num_int,"####0") , k_inizio_col+500+k_num_colonne, k_inizio_riga + 400 + k_num_righe, kist_barcode_stampa.font[5,1])
		printtext (ki_id_print_etichette, string(kst_tab_barcode_padre.data_int) , k_inizio_col+2400+k_num_colonne, k_inizio_riga + 550 + k_num_righe, kist_barcode_stampa.font[1,1])

//--- Sezione BARCODE 
		k_inizio_riga = 2730
//		if trim(kst_tab_base.barcode_modulo) = barcode_modulo_1etichetta then		
			printtext (ki_id_print_etichette, string(trim(kst_tab_meca_dosim.barcode),"@@@ @@@@@"), 300+k_num_colonne, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[6,1])
//		else							
//			if isnumber(LeftA(kst_tab_meca_dosim.barcode,1)) then
//				printtext (ki_id_print_etichette, string(trim(kst_tab_meca_dosim.barcode),"@@@@@@@@"), 260+k_num_colonne, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[6,1])
//			else							
//				printtext (ki_id_print_etichette, string(trim(kst_tab_meca_dosim.barcode),"@@@@@@@@"), 260+k_num_colonne, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[6,1])
//			end if
//		end if

		kst_tab_sl_pt.dosim_et_descr += space(100)

//--- Espone testo avvertenze da PT
		if trim(kst_tab_sl_pt.dosim_et_descr) > " " then
			k_inizio_riga = 3250 //3500
			k_inizio_col = 500 //200
			printtext (ki_id_print_etichette, left(trim(kst_tab_sl_pt.dosim_et_descr),48), k_inizio_col+k_num_colonne, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[2,1])
			k_inizio_riga = 3450 //3500
			k_inizio_col = 500 //200
			printtext (ki_id_print_etichette, mid(trim(kst_tab_sl_pt.dosim_et_descr),49,48), k_inizio_col+k_num_colonne, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[2,1])
		end if

		//--- Sezione codice modulo e revisione 
		k_inizio_riga = 3680
		k_inizio_col = 350
		printtext (ki_id_print_etichette, "Tag# MN-LT-OPS-002 Rev.2.1 del 22MAY2023", k_inizio_col+kst_barcode_stampa.num_colonne, k_inizio_riga + kst_barcode_stampa.num_righe, kist_barcode_stampa.font[1,1])

//--- Stampa testo in VERTICALE
		k_inizio_col = 3950 
		k_avanza_col = 190 
		k_testo_verticale = "POS:" + trim(kst_barcode_stampa.dosimpos_codice)			// codice posizione dosimetro es.  POS: 79
		stampa_testo_verticale(k_testo_verticale, 3630, k_inizio_col, k_num_righe, k_num_colonne)
		
		k_testo_verticale = trim(kst_barcode_stampa.dosim_tipo_des)							// Tipo Dosimetro AMBER, RED ....
		stampa_testo_verticale(k_testo_verticale, 2300, k_inizio_col, k_num_righe, k_num_colonne)

		k_testo_verticale = trim(kst_barcode_stampa.tipo_dose_des)							// Tipo Dose MASSIMA, MINIMA ....
		k_inizio_col += k_avanza_col 
		stampa_testo_verticale(k_testo_verticale, 2300, k_inizio_col, k_num_righe, k_num_colonne)
		
		k_testo_verticale = left(trim(kst_tab_sl_pt_dosimpos.descr), 20)     // I'  riga  della descrizione posizione dosimetri
		k_inizio_col += k_avanza_col 
		stampa_testo_verticale(k_testo_verticale, 3630, k_inizio_col, k_num_righe, k_num_colonne)
		if len(trim(kst_tab_sl_pt_dosimpos.descr)) > 20 then
			k_testo_verticale = trim(mid(trim(kst_tab_sl_pt_dosimpos.descr), 21))     // I'  riga  della descrizione posizione dosimetri
			k_inizio_col += k_avanza_col 
			stampa_testo_verticale(k_testo_verticale, 3630, k_inizio_col, k_num_righe, k_num_colonne)
		end if
		
		k_testo_verticale = trim(kst_tab_sl_pt_dosimpos.descr1)     // I'  riga  della descrizione posizione dosimetri
		k_inizio_col += k_avanza_col 
		stampa_testo_verticale(k_testo_verticale, 3630, k_inizio_col, k_num_righe, k_num_colonne)

//--- stampa il nr dosimetro + nr tot dosimetri da stampare
		k_row_barcode = ads_meca_dosim_barcode_prg.find("barcode='" + trim(kst_tab_meca_dosim.barcode) + "'", 1, ads_meca_dosim_barcode_prg.rowcount())
		if k_row_barcode > 0 then
			k_dosimetro_stampati = ads_meca_dosim_barcode_prg.getitemnumber(k_row_barcode, "k_progressivo")
			k_dosimetro_contati = ads_meca_dosim_barcode_prg.getitemnumber(k_row_barcode, "k_contati")
			k_testo_verticale = trim("Dosim.: " + string(k_dosimetro_stampati,"#") + "/" + string (k_dosimetro_contati,"#"))
			stampa_testo_verticale(k_testo_verticale, 2800, 4900, k_num_righe, k_num_colonne)
		end if
		
//--- stampa 3 righe VERTICALI:l NUM.RIF + WO + COLLI in modo sfasato
		k_inizio_col = 5200 //5320 
		k_avanza_col = 190 
		for k_righe = 1 to 3
			choose case k_righe
				case 1
					k_testo_verticale = trim("N:" + string(kst_tab_barcode_padre.num_int) + " WO:" + string(kst_barcode_stampa.e1doco) &
						  + " C:" + string(kst_barcode_stampa.conta_barcode,"#") + "/" + string (kst_barcode_stampa.barcode_tot_lotto,"#"))
				case 2
					k_testo_verticale = trim("C:" + string(kst_barcode_stampa.conta_barcode,"#") + "/" + string (kst_barcode_stampa.barcode_tot_lotto,"#") &
							+ " N:" + string(kst_tab_barcode_padre.num_int) + " WO:" + string(kst_barcode_stampa.e1doco))
				case else
					k_testo_verticale = trim("WO:" + string(kst_barcode_stampa.e1doco) &
						  + " C:" + string(kst_barcode_stampa.conta_barcode,"#") + "/" + string (kst_barcode_stampa.barcode_tot_lotto,"#") &
						  + " N:" + string(kst_tab_barcode_padre.num_int) )
			end choose
			stampa_testo_verticale(k_testo_verticale, 3630, k_inizio_col, k_num_righe, k_num_colonne)
			k_inizio_col += k_avanza_col 
		next

//--- Sezione BARCODE il codice a BARRE
		k_inizio_col = 50
		stampa_barcode_f ( kst_tab_meca_dosim.barcode, ki_id_print_etichette, k_inizio_col +(k_barcode_coord_x+k_num_colonne), (k_barcode_coord_y + k_num_righe), k_barcode_altezza, kist_barcode_stampa.font[1,1] )

//--- se Etichettatrice (1 etich) allora stampa
//		if trim(kst_tab_base.barcode_modulo) = barcode_modulo_1etichetta then
			PrintPage ( ki_id_print_etichette )  //--- FORZA salto pagina 
			ki_num_etichetta_in_pag = 1
//		end if

					
//	else	
//		
////----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
////--- MODULO A 2 ETICHETTE  
////----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
//
//		if ki_num_etichetta_in_pag = 2 then
//			k_num_righe = k_num_righe_giu
//		else
//			k_num_righe = 0
////--- salto pagina 
//			if ki_num_etichetta_in_pag > 2 then
//				PrintPage ( ki_id_print_etichette )
//				ki_num_etichetta_in_pag = 1
//			end if
//		end if
//			
//			
//// stampa il logo ad inizio foglio
//		PrintBitmap(ki_id_print_etichette, kguo_path.get_risorse( )+ KKG.PATH_SEP + "et_bcode_dosimetro.bmp", 300, 1 + k_num_righe, 7800, 5750)
//		PrintBitmap(ki_id_print_etichette, kguo_path.get_risorse( )+ KKG.PATH_SEP + "logo_barcode.jpg", 400, 1 + k_num_righe,  2400, 800) //0, 0)
//		//PrintBitmap(ki_id_print_etichette, "et_bcode_dosimetro.bmp", 300, 1 + k_num_righe, 7800, 5750)
//		//PrintBitmap(ki_id_print_etichette, "logo_barcode.jpg", 400, 1 + k_num_righe,  2400, 800) //0, 0)
//
//
//		k_inizio_riga = 1000
//		k_inizio_col = 500
//		printtext (ki_id_print_etichette, "ETICHETTA DOSIMETRO", k_inizio_col+k_num_colonne, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[2,1])
//
//
////--- Sezione Riferimento al PADRE 
//		k_inizio_riga = 1370
//		k_inizio_col = 500
//		printtext (ki_id_print_etichette, "Associato al collo: ", k_inizio_col + k_num_colonne, k_inizio_riga + 120 + k_num_righe, kist_barcode_stampa.font[1,1])
//		printtext (ki_id_print_etichette, string(trim(kst_tab_barcode_padre.barcode), "@@@ @@@@@@@@@@@@@") , k_inizio_col+950+k_num_colonne, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[4,1])
//		printtext (ki_id_print_etichette, "RIF: ", k_inizio_col+k_num_colonne, k_inizio_riga + 700 + k_num_righe, kist_barcode_stampa.font[1,1])
//		printtext (ki_id_print_etichette, string(kst_tab_barcode_padre.num_int,"####0") , k_inizio_col+500+k_num_colonne, k_inizio_riga + 600 + k_num_righe, kist_barcode_stampa.font[5,1])
//		printtext (ki_id_print_etichette, string(kst_tab_barcode_padre.data_int) , k_inizio_col+2400+k_num_colonne, k_inizio_riga + 700 + k_num_righe, kist_barcode_stampa.font[1,1])
//
//
////--- Sezione BARCODE il codice, se il barcode inizia con una lettera debbo togliere lo spazio in mezzo 
//		k_inizio_riga = 3950
//		if isnumber(LeftA(kst_tab_meca_dosim.barcode,1)) then
//			printtext (ki_id_print_etichette, string(trim(kst_tab_meca_dosim.barcode),"@@@ @@@@@"), 280, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[6,1])
//		else
//			printtext (ki_id_print_etichette, string(trim(kst_tab_meca_dosim.barcode),"@@@@@@@@"), 280, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[6,1])
//		end if
//
////--- Espone testo avvertenze da PT
//		if trim(kst_tab_sl_pt.dosim_et_descr) > " " then
//			k_inizio_riga = 4800
//			k_inizio_col = 300
//			printtext (ki_id_print_etichette, left(trim(kst_tab_sl_pt.dosim_et_descr),40), k_inizio_col+k_num_colonne, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[2,1])
//			k_inizio_riga = 5000
//			printtext (ki_id_print_etichette, mid(trim(kst_tab_sl_pt.dosim_et_descr),41), k_inizio_col+k_num_colonne, k_inizio_riga + k_num_righe, kist_barcode_stampa.font[2,1])
//		end if
//		
////--- Sezione BARCODE il codice a BARRE
//		stampa_barcode_f ( kst_tab_meca_dosim.barcode, ki_id_print_etichette, k_barcode_coord_x, (k_barcode_coord_y + k_num_righe), k_barcode_altezza, kist_barcode_stampa.font[1,1] )
////		PrintDefineFont(ki_id_print_etichette, kist_barcode_stampa.font[1,1], "Arial", kist_barcode_stampa.font[1,2], kist_barcode_stampa.font[1,3], Fixed!, Modern!, FALSE, FALSE) //ripristino il font
//
//	end if
			


	return k_return



end function

private function integer u_get_idx_ds_barcode_print_label (string a_dataobject_x_label, long a_id_meca);/*
   torna il nuovo indice del datastore di stampa e se necessario lo crea
	inp: nome del dataobject di stampa, id_meca del barcode instampa
	ret: riga del ds
*/
int k_ds_idx
string k_dataobject


//--- se sono su una nuova stampa allora resetto il DS array 
	if ki_id_print_etichette <> ki_id_print_etichette_last then
		ki_id_print_etichette_last = ki_id_print_etichette
		kids_barcode_print_label[] = kids_barcode_print_label_NULL[]  // RESETTA il DS
	end if
	
//--- se sono su un nuovo Dataobject crea un nuovo elemento DS e add l'indice k_ds_idx da restituire
	k_ds_idx = upperbound(kids_barcode_print_label[])
	if k_ds_idx = 0 then
	else
		k_dataobject = kids_barcode_print_label[k_ds_idx].dataobject
	end if
	
	if k_dataobject <> a_dataobject_x_label or ki_id_meca <> a_id_meca then
		ki_id_meca = a_id_meca
		k_ds_idx ++
		kids_barcode_print_label[k_ds_idx] = create ds_barcode_print_label
		kids_barcode_print_label[k_ds_idx].dataobject = a_dataobject_x_label
	end if

return k_ds_idx
end function

private subroutine u_create_report_barcode_et ();/*
  Gennera il composite report delle etichette da stampare
*/
int k_dw_n, k_y, k_ds_idx
string k_rc
int k_rcn
string k_modify
datastore kds_barcode_et_0
datawindowchild kdwc_1


	kds_barcode_et_0 = create datastore
	kds_barcode_et_0.dataobject = 'd_barcode_et_0'

//--- Genera il Composite
	k_ds_idx = upperbound(kids_barcode_print_label[])
	
	if k_ds_idx = 0 then return  // NON C'E' NULLA ESCE!!!
	
	for k_dw_n = 1 to k_ds_idx
		k_modify = "create report(band=detail dataobject='" + kids_barcode_print_label[k_dw_n].dataobject  &
			+ "' x='0' y='"+ string(k_y) +"' height='100' width='5895' border='0' enabled='0' tooltip.backcolor='134217752' tooltip.delay.initial='0' tooltip.delay.visible='32000' tooltip.enabled='0' tooltip.hasclosebutton='0' tooltip.icon='0' tooltip.isbubble='0' tooltip.maxwidth='0' tooltip.textcolor='134217751' tooltip.transparency='0'  height.autosize=yes criteria='' " &
			+ " newpage = yes trail_footer = yes " &
			+ " name=dw_" + string(k_dw_n) + " visible='1'  slideup=directlyabove )"
		k_rc = kds_barcode_et_0.modify(k_modify)
		k_y += 100
	next

	if k_rc > " " then
	else
		
	//--- Popola i DW
		for k_dw_n = 1 to k_ds_idx
			kds_barcode_et_0.getchild("dw_" + string(k_dw_n), kdwc_1)
			k_rcn = kids_barcode_print_label[k_dw_n].rowscopy(1, kids_barcode_print_label[k_dw_n].rowcount(), primary!, kdwc_1, 1, primary!) 			
			k_rcn = kdwc_1.rowcount( )
			kdwc_1.groupcalc( )
		next
		kds_barcode_et_0.groupcalc( )
		
		PrintDataWindow(ki_id_print_etichette, kds_barcode_et_0)

	end if
	
	destroy kds_barcode_et_0
end subroutine

public function integer stampa_etichetta_riferimento_dastampare (string k_barcode, long k_id_meca) throws uo_exception;/*
 Conta Etichetta ancora da Stampare
 ret:  Numero dei BARCODE ancora da stampare 0=tutti stampati
*/ 
int k_return
int k_barcode_da_stampare
date k_data_no


try
	SetPointer(kkg.pointer_attesa)
	kguo_exception.inizializza(this.classname())
	
	k_data_no = date(kkg.data_no)
	if k_barcode > " " then
		k_barcode = trim(k_barcode)
	else
		k_barcode= ""
	end if

	SELECT count(barcode)
		into :k_barcode_da_stampare  
	 FROM barcode 
	 WHERE 
			 barcode.id_meca = :k_id_meca 
			 and (barcode.data_stampa <= :k_data_no or barcode.data_stampa is null)
			 and (barcode = :k_barcode or :k_barcode = '')
			 using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in verifica se barcode " + k_barcode +  " in ristampa.")
	end if
	
	if k_barcode_da_stampare > 0 then
		k_return = k_barcode_da_stampare
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)

end try

return k_return


end function

on kuf_barcode_stampa.create
call super::create
end on

on kuf_barcode_stampa.destroy
call super::destroy
end on

event constructor;call super::constructor;//
	ki_nomeOggetto = "kuf_barcode" 
	

end event

event destructor;call super::destructor;//	
int k
for k = 1 to upperbound(kids_barcode_print_label)
	if isvalid(kids_barcode_print_label[k]) then destroy kids_barcode_print_label[k]
next


end event

