$PBExportHeader$kuf_armo_campioni.sru
forward
global type kuf_armo_campioni from kuf_parent
end type
end forward

global type kuf_armo_campioni from kuf_parent
end type
global kuf_armo_campioni kuf_armo_campioni

type variables
 ////--- flag campo Stato della Dosimetrica SPOSTATI NEL KUF_MECA_DOSIM
public constant string ki_err_lav_ok_da_conv = " "
public constant string ki_err_lav_ok_conv_ko_da_aut = "K"
public constant string ki_err_lav_ok_conv_da_aut = "A"
public constant string ki_err_lav_ok_conv_aut_ok = "2"
public constant string ki_err_lav_ok_conv_ko_bloc = "B"
public constant string ki_err_lav_ok_conv_ko_sbloc = "1"

public constant string ki_dosim_flg_tipo_dose_MINIMA = "M"
public constant string ki_dosim_flg_tipo_dose_MASSIMA = "X"
public constant string ki_dosim_flg_tipo_dose_ALTRO = "A"

end variables

forward prototypes
public function string get_ultimo_numero_barcode_da_tab (string k_inizio_barcode) throws uo_exception
public function integer if_gia_usato_barcode (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
public function integer get_barcode (ref st_tab_meca_dosim kst_tab_meca_dosim[]) throws uo_exception
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
private function string get_ultimo_numero_barcode_da_base () throws uo_exception
private function string genera_barcode () throws uo_exception
public function long get_id_armo_da_barcode (ref st_tab_armo_campioni ast_tab_armo_campioni) throws uo_exception
public function boolean if_esiste (st_tab_armo_campioni ast_tab_armo_campioni) throws uo_exception
public function boolean if_esiste_barcode (st_tab_armo_campioni ast_tab_armo_campioni, long a_id_meca) throws uo_exception
public function integer if_esiste_barcode_lav (st_tab_armo_campioni ast_tab_armo_campioni) throws uo_exception
public function boolean set_ultimo_collicampioni_barcode_in_base (st_tab_armo_campioni ast_tab_armo_campioni) throws uo_exception
public subroutine set_barcode_lav (st_tab_armo_campioni ast_tab_armo_campioni) throws uo_exception
public function boolean tb_add_barcode (st_tab_armo_campioni ast_tab_armo_campioni) throws uo_exception
public subroutine tb_delete (st_tab_armo_campioni ast_tab_armo_campioni) throws uo_exception
public subroutine tb_delete_completa (st_tab_armo_campioni ast_tab_armo_campioni) throws uo_exception
public function uo_ds_std_1 get_ds_armo_campioni_print (long a_id_meca) throws uo_exception
public subroutine if_isnull (ref st_tab_armo_campioni ast_tab_armo_campioni)
public function int tb_delete_x_id_meca (long a_id_meca, st_tab_g_0 ast_tab_g_0) throws uo_exception
public function integer get_nr_barcode (long a_id_meca) throws uo_exception
public function st_esito anteprima_x_barcode_lav (ref uo_ds_std_1 ads_anteprima, st_tab_armo_campioni ast_tab_armo_campioni)
public function st_esito anteprima (ref uo_ds_std_1 ads_anteprima, long a_id_meca)
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function integer u_genera_barcode_lotto (long a_id_meca, st_tab_g_0 ast_tab_g_0) throws uo_exception
public function string get_ultimo_numero_barcode () throws uo_exception
public subroutine set_ts_stampa (st_tab_armo_campioni ast_tab_armo_campioni) throws uo_exception
public function integer get_nr_barcode_x_id_armo (long a_id_armo) throws uo_exception
end prototypes

public function string get_ultimo_numero_barcode_da_tab (string k_inizio_barcode) throws uo_exception;/*
 Torna obbligatoriamente l'ultimo progressivo del BARCODE registrato in tabella
     Ritorna: STRINGA 	con ultimo progr Barcode trovato
*/
string k_return=""
string k_barcode_progr
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	if len(trim(k_inizio_barcode)) = 3 then
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura ultimo barcode Campioni "  + kkg.acapo + "Attenzione, mancano i primi 3 caratteri identificativi del barcode, operazione interrotta."
		kst_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
		
	end if

	SELECT max(substring(barcode,4,5))
				 INTO :k_barcode_progr
				 FROM armo_campioni  
				where substring(barcode,1,3) = :k_inizio_barcode
					 using kguo_sqlca_db_magazzino ;
				
	if kguo_sqlca_db_magazzino.sqlcode >= 0 then
	
		if k_barcode_progr > " " then
		else
			k_barcode_progr = "AA000"
		end if
	
	else
		
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
		
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in lettura Numero massimo a cui è giunto il barcode Campioni " + trim(k_inizio_barcode))
			throw kguo_exception
			
		end if
	end if

	if trim(k_barcode_progr) > " " then
		k_return = trim(k_barcode_progr)
	end if

return k_return

end function

public function integer if_gia_usato_barcode (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception;//---
//--- Controlla se codice Barcode x il Dosimetro è già stato usato in passato (ultimo anno)
//---
//--- Inp.: st_tab_meca_dosim id_meca (facoltativo) = quello attuale da escludere dalla conta, barcode = da controllare
//--- Out.: 
//--- Ritorna: int numero di volte  Utlizzato
//--- Lancia excpetion se errore
//--- 
int k_return= 0
date k_data_meno1anno
long k_contati=0
st_esito kst_esito
uo_exception kuo_exception


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	try
		
		k_data_meno1anno = relativedate(kg_dataoggi, -365)

		select count(*)
				into :k_contati
				from meca_dosim inner join meca on meca_dosim.id_meca = meca.id
			where meca_dosim.id_meca <> :kst_tab_meca_dosim.id_meca
					  and meca.data_int > :k_data_meno1anno
					  and barcode = :kst_tab_meca_dosim.barcode
			using sqlca;

		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura Tab.Convalida Dosimetrie per barcode (cod=" + trim(kst_tab_meca_dosim.barcode) + ")   ~n~r" + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
			kuo_exception.set_esito( kst_esito )
			throw kuo_exception
		end if

//--- se ho trovato dei codici allora torna TRUE
		if k_contati > 0 then
			k_return = k_contati
		end if

	catch (uo_exception kuo1_exception)
		throw kuo1_exception
	
	end try
	

return k_return




end function

public function integer get_barcode (ref st_tab_meca_dosim kst_tab_meca_dosim[]) throws uo_exception;//
//----------------------------------------------------------------------------------------------------
//--- Torna array di codici Barcode di Dosimetro (ce ne possono essere + di 1 x barcode di lavorazione)
//--- 
//--- Input : kst_tab_meca_dosim_dosim.id_meca e barcode_lav
//--- Out: kst_tab_meca_dosim_dosim[n].barcode 
//--- Ritorna: numero di barcode di dosimetria trovati
//---					
//--- Exception se erore con st_esito valorizzato
//---					
//---   
//-----------------------------------------------------------------------------------------------------
int k_return = 0
int k_ind=0
st_esito kst_esito


	kst_esito = kguo_exception.inizializza(this.classname())

	kst_tab_meca_dosim[1].barcode = ""

	if kst_tab_meca_dosim[1].id_meca > 0 then
	
		declare  c_get_barcode cursor for
			select barcode
				from meca_dosim 
				where meca_dosim.id_meca = :kst_tab_meca_dosim[1].id_meca
				    and meca_dosim.barcode_lav = :kst_tab_meca_dosim[1].barcode_lav
					 group by barcode
					 order by barcode
				using kguo_sqlca_db_magazzino;

		open c_get_barcode;	
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			k_ind = 1

			fetch c_get_barcode into :kst_tab_meca_dosim[k_ind].barcode;
			do while kguo_sqlca_db_magazzino.sqlcode = 0
				k_ind ++
				fetch c_get_barcode into :kst_tab_meca_dosim[k_ind].barcode;
			loop

		end if
		close c_get_barcode;	
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_tab_meca_dosim[1].barcode = ""
			
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettura del Dosimetro (del barcode '" + trim(kst_tab_meca_dosim[1].barcode_lav) + "') " + trim(kguo_sqlca_db_magazzino.sqlerrtext)
			kguo_exception.inizializza()
			kguo_exception.set_esito( kst_esito )
			throw  kguo_exception
		end if
		
		if k_ind > 0 then
			k_return = k_ind - 1
		else
			kst_tab_meca_dosim[1].barcode = ""
		end if
	end if

	
return k_return


end function

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;//====================================================================
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
string k_rcx
boolean k_return=false
string k_dataobject
long k_id_meca
int k_rows
st_tab_armo_campioni kst_tab_armo_campioni
st_esito kst_esito
uo_ds_std_1 kdsi_elenco_output, kds_1   //ds da passare alla windows di elenco
st_open_w kst_open_w 
kuf_menu_window kuf1_menu_window
kuf_barcode_stampa kuf1_barcode_stampa


SetPointer(kkg.pointer_attesa)

kdsi_elenco_output = create uo_ds_std_1

kst_esito = kguo_exception.inizializza(this.classname())

if adw_link.getrow() = 0 then
else
	choose case a_campo_link
	
		case "armo_colli_campioni_barcode_lav"
			if trim(adw_link.Describe("id_armo.x")) = "!" and trim(adw_link.Describe("barcode.x")) = "!" then 
				kst_esito.esito = kguo_exception.kk_st_uo_exception_tipo_internal_bug
				kst_esito.sqlerrtext = "Errore programma interno, nome colonna 'id_armo' o 'barcode' mancante. Anteprima inevasa."
				kguo_exception.set_esito(kst_esito)
				kguo_exception.scrivi_log( )
			else
				kst_tab_armo_campioni.id_armo = adw_link.getitemnumber(adw_link.getrow(), "id_armo")
				kst_tab_armo_campioni.barcode_lav = adw_link.getitemstring(adw_link.getrow(), "barcode")
				if kst_tab_armo_campioni.id_armo > 0 and kst_tab_armo_campioni.barcode_lav > " " then
					k_return = true
				end if
			end if
	
		case "armo_colli_campioni" &
			  ,"campionecolli_lotto"
			if trim(adw_link.Describe("id_meca.x")) = "!" then 
				kst_esito.esito = kguo_exception.kk_st_uo_exception_tipo_internal_bug
				kst_esito.sqlerrtext = "Errore programma interno, nome colonna 'id_meca' mancante. Anteprima inevasa."
				kguo_exception.set_esito(kst_esito)
				kguo_exception.scrivi_log( )
			else
				k_id_meca = adw_link.getitemnumber(adw_link.getrow(), "id_meca")
				if k_id_meca > 0 then
					k_return = true
				end if
			end if
			
		case "campionecolli_print"
			if trim(adw_link.Describe("id_meca.x")) = "!" then 
				kst_esito.esito = kguo_exception.kk_st_uo_exception_tipo_internal_bug
				kst_esito.sqlerrtext = "Errore programma interno, nome colonna 'id_meca' mancante. Elaborazione di stampa inevasa."
				kguo_exception.set_esito(kst_esito)
				kguo_exception.scrivi_log( )
			else
				k_id_meca = adw_link.getitemnumber(adw_link.getrow(), "id_meca")
				if k_id_meca > 0 then
					kguo_exception.inizializza(this.classname())
					kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_SINO)
					if kguo_exception.messaggio_utente("Controcampioni", "Eseguira la stampa delle Etichette?") = 1 then
						k_return = true
					end if 
				end if 
			end if 
	end choose
end if


if k_return then

	try
		k_return = if_sicurezza(kkg_flag_modalita.elenco)
	catch (uo_exception kuo_exception)
		throw kuo_exception
	end try

	if not k_return then
	
	else
//		kdsi_elenco_output.dataobject = k_dataobject		
//		kdsi_elenco_output.settransobject(sqlca)

		kdsi_elenco_output.reset()	
		
		choose case a_campo_link
					
			case "armo_colli_campioni_barcode_lav"
//				k_rc=kdsi_elenco_output.retrieve(kst_tab_armo_campioni.barcode_lav)
				kst_esito = this.anteprima_x_barcode_lav(kdsi_elenco_output, kst_tab_armo_campioni)
				if kst_esito.esito <> kkg_esito.ok then
					kguo_exception.inizializza( )
					kguo_exception.set_esito( kst_esito)
					throw kguo_exception
				end if
				kst_open_w.key1 = "Etichette Colli Controcampioni (id riga Lotto=" + trim(string(kst_tab_armo_campioni.id_armo)) + ") " 
					
			case "armo_colli_campioni_lotto" &
			     ,"campionecolli_lotto"
//				k_rc=kdsi_elenco_output.retrieve(kst_tab_armo_campioni.barcode_lav)
				kst_esito = this.anteprima( kdsi_elenco_output, k_id_meca)
				if kst_esito.esito <> kkg_esito.ok then
					kguo_exception.inizializza( )
					kguo_exception.set_esito( kst_esito)
					throw kguo_exception
				end if
				kst_open_w.key1 = "Etichette Colli Controcampioni (id riga Lotto=" + trim(string(kst_tab_armo_campioni.id_armo)) + ") " 
				
			case "campionecolli_print"
				kuf1_barcode_stampa = create kuf_barcode_stampa
				k_rows = kuf1_barcode_stampa.stampa_etichetta_riferimento_campioni(k_id_meca)
				
		end choose

	end if
	

	if a_campo_link = "b_campionecolli_print" then
		if isvalid(kuf1_barcode_stampa) then destroy kuf1_barcode_stampa
		if k_rows > 0 then 
			kguo_exception.messaggio_utente("Controcampioni", "Sono state inviate alla stampante " + string(k_rows) + " etichette.")
		else
			kguo_exception.messaggio_utente("Controcampioni", "Stampa non eseguita, nessuna etichetta da stampare o stampa annullata.")
		end if
	else
	
		if kdsi_elenco_output.rowcount() > 0 then
			
			kst_open_w.id_programma = kkg_id_programma.elenco  //kkg_id_programma_elenco
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
			kguo_exception.messaggio_utente("Controcampioni", "Nessun dato disponibile.")
		end if
	end if

end if

SetPointer(kkg.pointer_default)



return k_return

end function

private function string get_ultimo_numero_barcode_da_base () throws uo_exception;/*
 Torna ultimo progressivo del BARCODE 
   Ritorna: STRINGA 	con l'ultimo progr Barcode impostato sul BASE es 'DSM+progressivo'                                     
*/
string k_return=""
st_tab_base kst_tab_base
st_esito kst_esito
kuf_base kuf1_base


try
	kst_esito = kguo_exception.inizializza(this.classname())

  	kuf1_base = create kuf_base

//--- piglia i primi 3 caratteri che identifcano il barcode
	kst_tab_base.collicampioni_barcode_mask = trim(mid(kuf1_base.prendi_dato_base( "collicampioni_barcode_mask"),2))
	if trim(kst_tab_base.dosimetro_barcode_mask) > " " then
	else
		kst_tab_base.collicampioni_barcode_mask = "XCC"
	end if

//--- piglia suffisso ultimo barcode impostato sul BASE
   kst_tab_base.collicampioni_ult_barcode = trim(mid(kuf1_base.prendi_dato_base( "collicampioni_ult_barcode"),2))

//--- se tutto ok torna il Barcode
	if trim(kst_tab_base.collicampioni_ult_barcode) > " "  then
       k_return = trim(kst_tab_base.collicampioni_barcode_mask) + trim(kst_tab_base.collicampioni_ult_barcode)
	else
       k_return = trim(kst_tab_base.collicampioni_barcode_mask) + "AA000"
	end if
   
catch (uo_exception kuo_exception)
	throw kuo_exception


finally 
  	destroy kuf1_base

end try

return k_return

end function

private function string genera_barcode () throws uo_exception;/*
 Torna il nuovo BARCODE 
    Ritorna: STRINGA 	con il valore del nuovo Barcode
*/
string k_return=""
string k_barcode_intero, k_barcode_generati[]
boolean k_barcode_ok= false
date k_data_meno90gg
st_tab_base kst_tab_base
st_tab_armo_campioni kst_tab_armo_campioni
st_tab_armo kst_tab_armo
st_esito kst_esito
kuf_armo kuf1_armo
pointer kpointer  // Declares a pointer variable

 
try
	
//--- Puntatore Cursore da attesa.....
	kpointer = SetPointer(HourGlass!)

	kst_esito = kguo_exception.inizializza(this.classname())

	kuf1_armo = create kuf_armo
	k_data_meno90gg = relativedate(kg_dataoggi, -90)
	kst_tab_armo.data_int = k_data_meno90gg
	kst_esito = kuf1_armo.get_id_meca_da_data(kst_tab_armo)  // becca il primo id lotto ad una certa data
	if kst_esito.esito = kkg_esito.ok then
	else
		kst_tab_armo.id_meca = 0
	end if

//--- piglia ultimo barcode generato
	k_barcode_intero = get_ultimo_numero_barcode( )  // Ultimo Barcode caricato

	do while not k_barcode_ok
		
		k_barcode_intero = kguf_data_base.u_barcode_build(k_barcode_intero, 1, k_barcode_generati[])   // GENERA IL BARCODE

//---controllo se i barcode esistono gia'	in tab BARCODE e armo_campioni
		if kst_tab_armo_campioni.id_armo = 0 then
			k_barcode_ok = true   // OK BUONO !!!
		else
			kst_tab_armo_campioni.barcode = k_barcode_intero //trim(kst_tab_base.dosimetro_barcode_mask) + trim(k_barcode_pref) + string(k_barcode_num,"000")
			if not if_esiste_barcode(kst_tab_armo_campioni, kst_tab_armo.id_meca) then
				k_barcode_ok = true   // OK BUONO !!!
			end if
		end if
			
	loop
   
  	if k_barcode_ok then
		k_return = k_barcode_intero //trim(kst_tab_base.dosimetro_barcode_mask) + trim(k_barcode_pref) + string(k_barcode_num,"000")
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	SetPointer(kpointer)
	
end try

return k_return

end function

public function long get_id_armo_da_barcode (ref st_tab_armo_campioni ast_tab_armo_campioni) throws uo_exception;/*====================================================================
 Trova ID riga dal Barcode 
 Inp: barcode
 Out: id_armo
 Ritorna id_armo se ZERO non esiste
*/
long k_return
long k_rows
st_esito kst_esito
uo_ds_std_1 kds_1


try
	kguo_exception.inizializza(this.classname())

	if trim(ast_tab_armo_campioni.barcode) > " " then

		kds_1 = create uo_ds_std_1
		kds_1.dataobject = "ds_armo_campioni_x_barcode"
		kds_1.settransobject(kguo_sqlca_db_magazzino)
		
		k_rows = kds_1.retrieve(ast_tab_armo_campioni.barcode)
		
		if k_rows = 1 then
	
			ast_tab_armo_campioni.id_armo = kds_1.getitemnumber(1, "id_armo")
			k_return = ast_tab_armo_campioni.id_armo
			
		elseif k_rows < 0 then
			kst_esito = kds_1.kist_esito
			kst_esito.SQLErrText = "Errore in lettura ID Lotto da Barcode Dosimetrio '" + ast_tab_armo_campioni.barcode  + "' (meca_dosim) " &
				                    + kkg.acapo + kds_1.kist_esito.sqlerrtext
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
		elseif k_rows > 1 then
			kst_esito.esito = kkg_esito_ok
			kst_esito.SQLErrText = "ATTENZIONE: Barcode Campione '" + ast_tab_armo_campioni.barcode  + "' presente su più righe Lotto ad esempio in questo id/ASN: " &
								+ kkg.acapo + string(kds_1.getitemnumber(1, "id_meca")) + " riga " + string(kds_1.getitemnumber(1, "id_armo")) + " e " &
								+ string(kds_1.getitemnumber(2, "id_meca"))  + " riga " + string(kds_1.getitemnumber(2, "id_armo")) &
								+ kkg.acapo + ", prego verificare e rigenerare o eliminarlo da uno delle due righe Lotto."
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
	
end try

	
return k_return


end function

public function boolean if_esiste (st_tab_armo_campioni ast_tab_armo_campioni) throws uo_exception;/*
 Controllo se Etichetta barcode già in tabella
    Inp: barcode
    Ritorna: TRUE = esiste
*/
boolean k_return=false
st_esito kst_esito
int k_ctr


kst_esito = kguo_exception.inizializza(this.classname())

if trim(ast_tab_armo_campioni.barcode) > " " then

	select 1
		into :k_ctr
		from armo_campioni 
		where barcode = :ast_tab_armo_campioni.barcode
		using kguo_sqlca_db_magazzino ;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in verifica esistenza Barcode Controcampione: " + ast_tab_armo_campioni.barcode)
		throw kguo_exception
	end if
		
else
	kst_esito.esito = kkg_esito.ko
	kst_esito.SQLErrText = "Errore interno. Manca codice barcode x identificarlo, operazione bloccata! "
	kguo_exception.inizializza()
	kguo_exception.set_esito( kst_esito )
	throw kguo_exception
end if

if k_ctr > 0 then

	k_return = true
		
end if
	
	
return k_return


end function

public function boolean if_esiste_barcode (st_tab_armo_campioni ast_tab_armo_campioni, long a_id_meca) throws uo_exception;/*
 Controllo se esiste gia' lo stesso Barcode Dosimetria sia in tabella BARCODE che nella armo_campioni
 
   Inp: barcode, id_meca (se omesso assume zero)
   Ritorna BOOLEAN : TRUE=ESISTE, FALSE=NON ESISTE;
*/
boolean k_return=false
st_esito kst_esito
int k_ctr
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode


kst_esito = kguo_exception.inizializza(this.classname())

try

	kuf1_barcode = create kuf_barcode

	if trim(ast_tab_armo_campioni.barcode) > " " then
		
		if isnull(a_id_meca) then a_id_meca = 0

//--- controllo prima di tutto se esiste gia' un Barcode di Trattamento in tabella 
		kst_tab_barcode.barcode = ast_tab_armo_campioni.barcode
		kst_tab_barcode.id_meca = a_id_meca	
		if not kuf1_barcode.if_esiste( kst_tab_barcode ) then

//--- Se non esiste allora cerco in tabella armo_campioni			
			select 1
				into :k_ctr
				from armo_campioni inner join armo on armo_campioni.id_armo = armo.id_armo 
				where armo.id_meca <> :a_id_meca and armo_campioni.barcode = :ast_tab_armo_campioni.barcode
				using sqlca;
				

			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore durante verifica esistenza Barcode Controcampione (armo_campioni): " + ast_tab_armo_campioni.barcode)
				throw kguo_exception
			end if
			
			if sqlca.sqlcode = 100 then
			else
				if k_ctr = 1 then
					k_return = true
				end if
			end if
				
		end if
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	

finally
	if isvalid(kuf1_barcode) then destroy kuf1_barcode

end try	
	
return k_return


end function

public function integer if_esiste_barcode_lav (st_tab_armo_campioni ast_tab_armo_campioni) throws uo_exception;/*
 Controllo se Esiste x BARCODE_LAV
    Inp: barcode_lav
    Ritorna Numero di barcode trovati 
*/
int k_return=0
st_esito kst_esito
int k_ctr


kst_esito = kguo_exception.inizializza(this.classname())

if trim(ast_tab_armo_campioni.barcode_lav) > " " then

	select count(*)
		into :k_ctr
		from armo_campioni 
		where barcode_lav = :ast_tab_armo_campioni.barcode_lav
		using kguo_sqlca_db_magazzino ;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in verifica esistenza Barcode Controcampione per barcode di trattamento: " + ast_tab_armo_campioni.barcode_lav)
		throw kguo_exception
	end if
		
else
	kst_esito.esito = kkg_esito.ko
	kst_esito.SQLErrText = "Errore interno. Manca barcode di Trattamento per verifica del Controcampione x identificarlo, operazione bloccata! "
	kguo_exception.inizializza()
	kguo_exception.set_esito( kst_esito )
	throw kguo_exception
end if

if k_ctr > 0 and kguo_sqlca_db_magazzino.sqlcode = 0 then

	k_return = k_ctr
		
end if
	
	
return k_return


end function

public function boolean set_ultimo_collicampioni_barcode_in_base (st_tab_armo_campioni ast_tab_armo_campioni) throws uo_exception;/*
 Imposta ultimo  BARCODE  sul BASE
    input: barcode
    Ritorna: STRINGA 	con lultimo progr Barcode trovato
*/
boolean k_return=false
st_tab_base kst_tab_base
st_esito kst_esito
kuf_base kuf1_base


try
	kst_esito = kguo_exception.inizializza(this.classname())

  	kuf1_base = create kuf_base

	kst_tab_base.collicampioni_barcode_mask = left(trim(ast_tab_armo_campioni.barcode),3)
	kst_tab_base.collicampioni_ult_barcode = mid(trim(ast_tab_armo_campioni.barcode),4)

//--- Setta i primi 3 caratteri che identifcano il barcode
	kst_tab_base.st_tab_g_0.esegui_commit = "S" //"N"
	kst_tab_base.key = "collicampioni_barcode_mask"
	kst_tab_base.key1 = kst_tab_base.collicampioni_barcode_mask
	kst_esito  = kuf1_base.metti_dato_base(kst_tab_base)

//--- piglia l'ultimo barcode generato dal BASE
	if kst_esito.esito = kkg_esito.ok then
		kst_tab_base.st_tab_g_0.esegui_commit = ast_tab_armo_campioni.st_tab_g_0.esegui_commit 
		kst_tab_base.key = "collicampioni_ult_barcode"
		kst_tab_base.key1 = kst_tab_base.collicampioni_ult_barcode
		kst_esito = kuf1_base.metti_dato_base(kst_tab_base)
	end if
	
	if kst_esito.esito <> kkg_esito.ok then
		kst_esito.esito = kkg_esito.ko
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Errore durante registrazione ultimo codice Barcode Campione in tabella (BASE)."
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
   
	k_return = true 
	
catch (uo_exception kuo_exception)
	throw kuo_exception


finally 
   if isvalid(kuf1_base) then destroy kuf1_base

end try

return k_return

end function

public subroutine set_barcode_lav (st_tab_armo_campioni ast_tab_armo_campioni) throws uo_exception;/*
  Aggiorna barcode di trattamento
     input: st_tab_armo_campioni.id_armo_campione e barcode_lav
*/
st_esito kst_esito 


try
	kst_esito = kguo_exception.inizializza(this.classname())

	//if trim(ast_tab_armo_campioni.barcode) > " " then
	if ast_tab_armo_campioni.id_armo_campione > 0 then
	else
		kst_esito.esito = kkg_esito.dati_insuff
		kst_esito.sqlcode = 0 
		kst_esito.SQLErrText = "Aggiornamento Barcode di Lavorazione in tabella Campioni non eseguito, manca Id Campione. " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	ast_tab_armo_campioni.x_datins = kGuf_data_base.prendi_x_datins() 
	ast_tab_armo_campioni.x_utente = kGuf_data_base.prendi_x_utente() 

//--- Aggiorna lo stato e le note della rilevazione dosimetrica	
	update armo_campioni set 	 
			 barcode_lav = :ast_tab_armo_campioni.barcode_lav
			 ,x_datins = :ast_tab_armo_campioni.x_datins
			 ,x_utente = :ast_tab_armo_campioni.x_utente
		where id_armo_campione = :ast_tab_armo_campioni.id_armo_campione
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore durante aggiornamento Barcode di Lavorazione " &
												+ string(ast_tab_armo_campioni.barcode_lav) + " in tabella Campioni id " &
										 	   + string(ast_tab_armo_campioni.id_armo_campione))
		if ast_tab_armo_campioni.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		throw kguo_exception
	end if	

//---- COMMIT....	
	if ast_tab_armo_campioni.st_tab_g_0.esegui_commit = "N" then
	else
		kguo_sqlca_db_magazzino.db_commit( )
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception


end try
		


end subroutine

public function boolean tb_add_barcode (st_tab_armo_campioni ast_tab_armo_campioni) throws uo_exception;/*
 Aggiunge Barcode in tabella armo_campioni
 
  Input: ast_tab_armo_campioni: id_armo, barcode, barcode_lav
	 Out: TRUE=tutto OK
*/
boolean k_return=false
boolean k_sicurezza=true
st_esito kst_esito
st_open_w kst_open_w
kuf_barcode kuf1_barcode
kuf_sicurezza kuf1_sicurezza


	kst_esito = kguo_exception.inizializza(this.classname())
	
	ast_tab_armo_campioni.x_datins = kGuf_data_base.prendi_x_datins()
	ast_tab_armo_campioni.x_utente = kGuf_data_base.prendi_x_utente()

	ast_tab_armo_campioni.ts_ins = ast_tab_armo_campioni.x_datins

	if_isnull(ast_tab_armo_campioni)

	if ast_tab_armo_campioni.id_armo > 0 then
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Manca id riga Lotto, inserimento nuovo barcode Campione non eseguito!"
		kst_esito.esito = kkg_esito.ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito )		
		throw kguo_exception
	end if		
		
//--- 160715: esiste già il barcode? 
	if if_esiste(ast_tab_armo_campioni) then
				
		update armo_campioni
					 	set barcode_lav = :ast_tab_armo_campioni.barcode_lav,
						x_datins = :ast_tab_armo_campioni.x_datins, 
						x_utente =	:ast_tab_armo_campioni.x_utente   
					where barcode = :ast_tab_armo_campioni.barcode
					using kguo_sqlca_db_magazzino;
					
	else

		INSERT INTO armo_campioni
						( 
						  barcode,
						  barcode_lav,
						  id_armo,   
						  ts_ins,
						  x_datins,
						  x_utente
						)  
				  VALUES 
							( 
							:ast_tab_armo_campioni.barcode,   
							:ast_tab_armo_campioni.barcode_lav,   
							:ast_tab_armo_campioni.id_armo,   
							:ast_tab_armo_campioni.ts_ins,   
							:ast_tab_armo_campioni.x_datins,   
							:ast_tab_armo_campioni.x_utente   
							)  
							using kguo_sqlca_db_magazzino;
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in aggiornamento dati Barcode Campione (armo_campioni): " + ast_tab_armo_campioni.barcode)
		if ast_tab_armo_campioni.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		throw kguo_exception
			
	else
		
		if ast_tab_armo_campioni.st_tab_g_0.esegui_commit = "N" then
		else
			kst_esito = kguo_sqlca_db_magazzino.db_commit( )
		end if
		if kst_esito.esito = kkg_esito.ok then
			k_return = TRUE
		end if
		
	end if


return k_return

end function

public subroutine tb_delete (st_tab_armo_campioni ast_tab_armo_campioni) throws uo_exception;/*
 Cancella barcode
    Inp: barcode/barcode_lav/id_armo
*/
boolean k_sicurezza
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())

//	k_sicurezza = if_sicurezza(kkg_flag_modalita.cancellazione)

	if trim(ast_tab_armo_campioni.barcode) > " " or trim(ast_tab_armo_campioni.barcode_lav) > " "  or ast_tab_armo_campioni.id_armo > 0 then
		
		if trim(ast_tab_armo_campioni.barcode) > " " then
			delete from armo_campioni
				where barcode = :ast_tab_armo_campioni.barcode
				using kguo_sqlca_db_magazzino;
		elseif trim(ast_tab_armo_campioni.barcode_lav) > " " then
			delete from armo_campioni
					where barcode_lav = :ast_tab_armo_campioni.barcode_lav
					using kguo_sqlca_db_magazzino;
		elseif ast_tab_armo_campioni.id_armo > 0 then
			delete from armo_campioni
					where id_armo = :ast_tab_armo_campioni.id_armo
					using kguo_sqlca_db_magazzino;
		end if
	
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in cancellazione Barcode Campione (armo_campioni). " &
												+ kkg.acapo + "codice Campione: " + ast_tab_armo_campioni.barcode &
												+ kkg.acapo + "barcode di Trattamento: " + ast_tab_armo_campioni.barcode_lav &
												+ kkg.acapo + "riga Lotto: " + string(ast_tab_armo_campioni.id_armo) &
												)
			if ast_tab_armo_campioni.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			throw kguo_exception
		end if

		if ast_tab_armo_campioni.st_tab_g_0.esegui_commit = "N" then
		else
			kst_esito = kguo_sqlca_db_magazzino.db_commit( )
		end if
		
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally

	
end try
		
		




end subroutine

public subroutine tb_delete_completa (st_tab_armo_campioni ast_tab_armo_campioni) throws uo_exception;/*
  Cancella barcodeCampione se non ancora in PL e nel caso 
          reset flag sul barcode
  Inp: barcode, barcode_lav
*/
boolean k_sicurezza
st_esito kst_esito
st_tab_barcode kst_tab_barcode 
kuf_barcode kuf1_barcode


try
	kst_esito = kguo_exception.inizializza(this.classname())

//	k_sicurezza = if_sicurezza(kkg_flag_modalita.cancellazione)

	if trim(ast_tab_armo_campioni.barcode) > " " then
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Operazione di cancellazione Campione interrotta, manca il codice! " 
		kst_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- verifica che il barcode di lavorazione non sia stato pianificato
	if trim(ast_tab_armo_campioni.barcode_lav) > " " then
		kst_tab_barcode.barcode = ast_tab_armo_campioni.barcode_lav
		kuf1_barcode = create kuf_barcode
		if kuf1_barcode.if_barcode_in_pl(kst_tab_barcode) then
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Il barcode Campione " + trim(ast_tab_armo_campioni.barcode) + " non può essere rimosso, "  &
										+ kkg.acapo + "barcode " + trim(kst_tab_barcode.barcode) + " già trattato o pianificato."
			kst_esito.esito = kkg_esito.no_esecuzione
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if

//---- Cancellazione 									
	delete from armo_campioni
		where barcode = :ast_tab_armo_campioni.barcode
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore in cancellazione completa del Barcode Campione (armo_campioni). " &
											+  "Codice Campione: " + ast_tab_armo_campioni.barcode &
											)
		if ast_tab_armo_campioni.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		throw kguo_exception
		
	else

		if trim(ast_tab_armo_campioni.barcode_lav) > " " then
			if if_esiste_barcode_lav(ast_tab_armo_campioni) = 0 then // se non ci sono più campioni 
//--- reset del flag campione sul barcode
				kuf1_barcode = create kuf_barcode
				kst_tab_barcode.barcode = ast_tab_armo_campioni.barcode_lav
				kuf1_barcode.set_flg_campione_reset(kst_tab_barcode)
			end if
		end if

		if ast_tab_armo_campioni.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_campioni.st_tab_g_0.esegui_commit) then
			kst_esito = kguo_sqlca_db_magazzino.db_commit( )
		end if
	
	end if

catch (uo_exception kuo_exception)
	if ast_tab_armo_campioni.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_campioni.st_tab_g_0.esegui_commit) then
		kst_esito = kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	
end try
		
		




end subroutine

public function uo_ds_std_1 get_ds_armo_campioni_print (long a_id_meca) throws uo_exception;/*
 Torna il datastore con le etichette campioni del Lotto, le genera se necessario
     inp: long id_meca
     Ritorna: ds ds_armo_campioni_print_barcode con i barcode del lotto
*/
int k_barcode_generati
st_esito kst_esito
uo_ds_std_1 kds_1
st_tab_g_0 kst_tab_g_0


try
	
	kst_esito = kguo_exception.inizializza(this.classname())

	kds_1 = create uo_ds_std_1
	kds_1.dataobject = "ds_armo_campioni_print_barcode"

	if a_id_meca > 0 then
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura etichette Controcampioni non effettuato manca Id/ASN del Lotto, operazione interrotta."
		kst_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
		
	end if

	kds_1.settransobject(kguo_sqlca_db_magazzino)
	k_barcode_generati = kds_1.retrieve(a_id_meca)
	if k_barcode_generati < 0 then
		kguo_exception.set_esito(kds_1.kist_esito)
		kguo_exception.kist_esito.sqlerrtext = "Lettura etichette Controcampioni: Errore in lettura per Id/ASN del Lotto " + string(a_id_meca) + ". " + kkg.acapo + kds_1.kist_esito.sqlerrtext
		throw kguo_exception 
	end if
	if k_barcode_generati > 0 then
	else
		
		if u_genera_barcode_lotto(a_id_meca, kst_tab_g_0) > 0 then
			k_barcode_generati = kds_1.retrieve(a_id_meca)
			if k_barcode_generati < 0 then
				kguo_exception.set_esito(kds_1.kist_esito)
				kguo_exception.kist_esito.sqlerrtext = "Etichette Controcampioni: Errore in rilettura per Id/ASN del Lotto " + string(a_id_meca) + ". " + kkg.acapo + kds_1.kist_esito.sqlerrtext
				throw kguo_exception 
			end if
		end if
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally

	
end try

return kds_1

end function

public subroutine if_isnull (ref st_tab_armo_campioni ast_tab_armo_campioni);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(ast_tab_armo_campioni.ts_ins) then	ast_tab_armo_campioni.ts_ins = datetime(date(0))
if isnull(ast_tab_armo_campioni.x_datins) then	ast_tab_armo_campioni.x_datins = datetime(date(0))
if isnull(ast_tab_armo_campioni.x_utente) then	ast_tab_armo_campioni.x_utente = ""
if isnull(ast_tab_armo_campioni.id_armo)  then ast_tab_armo_campioni.id_armo = 0
if isnull(ast_tab_armo_campioni.barcode)  then ast_tab_armo_campioni.barcode = ""
if isnull(ast_tab_armo_campioni.barcode_lav)  then ast_tab_armo_campioni.barcode_lav = ""




end subroutine

public function int tb_delete_x_id_meca (long a_id_meca, st_tab_g_0 ast_tab_g_0) throws uo_exception;/*
 Rimuove tutti i Barcode campioni del Lotto
     inp: id_meca, st_tab_g_0.esegui_commit
     Ritorna: num barcode rimossi
*/
int k_return
int k_rc
long k_row, k_rows
st_esito kst_esito
uo_ds_std_1 kds_1


	kst_esito = kguo_exception.inizializza(this.classname())

	kds_1 = create uo_ds_std_1
	kds_1.dataobject = "ds_armo_campioni_del_x_id_meca"

	if a_id_meca > 0 then
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Rimozione etichette Controcampioni non effettuata manca Id/ASN del Lotto, operazione interrotta."
		kst_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
		
	end if

	kds_1.settransobject(kguo_sqlca_db_magazzino)
	k_rows = kds_1.retrieve(a_id_meca)
	if k_rows < 0 then
		kguo_exception.set_esito(kds_1.kist_esito)
		kguo_exception.kist_esito.sqlerrtext = "Rimozione etichette Controcampioni: Errore in lettura per Id/ASN del Lotto " + string(a_id_meca) + ". " + kkg.acapo + kds_1.kist_esito.sqlerrtext
		throw kguo_exception 
	end if
	if k_rows > 0 then
		
		for k_row = k_rows to 1 step -1
			kds_1.deleterow(k_row)
		next	
		if kds_1.update() < 0 then
			kguo_exception.kist_esito = kds_1.kist_esito
			kguo_exception.kist_esito.sqlerrtext = "Rimozione etichette Controcampioni: Errore in cancellazione dati, Id/ASN del Lotto " + string(a_id_meca) + ". " + kkg.acapo + kds_1.kist_esito.sqlerrtext
			throw kguo_exception 
		else
			k_return = k_rows
		end if			
		
	end if
		
return k_return

end function

public function integer get_nr_barcode (long a_id_meca) throws uo_exception;/*
 Torna il numero dei barcode generati
    input: st_tab_armo_campioni.id_meca
     		  se passato il barcode allora fa solo quello
    out: numero bcode generati
*/
int k_return
long k_rows
uo_ds_std_1 kds_1


try
	
	kguo_exception.inizializza(this.classname())

	if a_id_meca > 0 then 
		kds_1 = create uo_ds_std_1
		kds_1.dataobject = "ds_armo_campioni_x_id_meca"
		kds_1.settransobject(kguo_sqlca_db_magazzino)
		k_rows = kds_1.retrieve(a_id_meca)
		if k_rows < 0 then
			kguo_exception.set_esito(kds_1.kist_esito)
			kguo_exception.kist_esito.sqlerrtext = "Errore in lettura barcode Campioni dal Lotto id " + string(a_id_meca) + ". " + kkg.acapo + kds_1.kist_esito.sqlerrtext
			throw kguo_exception 
		end if
		
		k_return = k_rows
		
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
	
end try

return k_return

end function

public function st_esito anteprima_x_barcode_lav (ref uo_ds_std_1 ads_anteprima, st_tab_armo_campioni ast_tab_armo_campioni);//
//====================================================================
//=== Operazione di Anteprima 
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
long k_rc
boolean k_return
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_armo_campioni.id_armo > 0 and ast_tab_armo_campioni.barcode_lav > " " then

		ads_anteprima.dataobject = "d_armo_campioni_x_barcode_lav" 
		ads_anteprima.settransobject(sqlca)

		ads_anteprima.reset()
		
		k_rc=ads_anteprima.retrieve(ast_tab_armo_campioni.id_armo, ast_tab_armo_campioni.barcode_lav)
		if k_rc < 0 then
			kguo_exception.set_esito(ads_anteprima.kist_esito)
			throw kguo_exception
		end if

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Barcode Controcampioni: nessun id riga Lotto e/o Barcode di lavorazione indicati"
		kst_esito.esito = "1"
		
	end if

catch(uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

end try


return kst_esito

end function

public function st_esito anteprima (ref uo_ds_std_1 ads_anteprima, long a_id_meca);//
//====================================================================
//=== Operazione di Anteprima 
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
long k_rc
boolean k_return
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if a_id_meca > 0 then

		ads_anteprima.dataobject = "d_armo_campioni_x_id_meca" 
		ads_anteprima.settransobject(sqlca)

		ads_anteprima.reset()
		
		k_rc=ads_anteprima.retrieve(a_id_meca)
		if k_rc < 0 then
			kguo_exception.set_esito(ads_anteprima.kist_esito)
			throw kguo_exception
		end if

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Barcode Controcampioni: nessun id Lotto indicato"
		kst_esito.esito = "1"
		
	end if

catch(uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

end try


return kst_esito

end function

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return true
end function

public function integer u_genera_barcode_lotto (long a_id_meca, st_tab_g_0 ast_tab_g_0) throws uo_exception;/*
 Genera barcode Controcampioni
    input: id_meca
    out: numero bcode generati
*/
int k_return
long k_nr_barcode, k_rows, k_row, k_ind 
uo_ds_std_1 kds_1
st_tab_armo_campioni kst_tab_armo_campioni, kst_tab_armo_campioni_ultimo, kst_tab_armo_campioni_delete
st_tab_armo kst_tab_armo
st_esito kst_esito 


try
	
	kst_esito = kguo_exception.inizializza(this.classname())

//	if_sicurezza(kkg_flag_modalita.inserimento) 

	if a_id_meca > 0 then 
		kds_1 = create uo_ds_std_1
		kds_1.dataobject = "ds_armo_campioni_count_x_id_meca"
		kds_1.settransobject(kguo_sqlca_db_magazzino)
		k_rows = kds_1.retrieve(a_id_meca)
		if k_rows < 0 then
			kguo_exception.set_esito(kds_1.kist_esito)
			kguo_exception.kist_esito.sqlerrtext = "Errore in lettura conteggio Campioni in riga Lotto id " + string(a_id_meca) + ". " + kkg.acapo + kds_1.kist_esito.sqlerrtext
			throw kguo_exception 
		end if
		for k_row = 1 to k_rows
			
			k_nr_barcode = kds_1.getitemnumber(k_row, "campionecolli") - kds_1.getitemnumber(k_row, "contati")  // n.barcode da stampare
	
			if k_nr_barcode > 0 then
	
				for k_ind = 1 to k_nr_barcode
									
				//--- genera uno o più barcode per etichetta
					kst_tab_armo_campioni.id_armo = kds_1.getitemnumber(k_row, "id_armo")
					kst_tab_armo_campioni.barcode = genera_barcode( )  // genera il barcode 
					kst_tab_armo_campioni.st_tab_g_0.esegui_commit = ast_tab_g_0.esegui_commit 
					if tb_add_barcode(kst_tab_armo_campioni) then // insert barcode in tabella
						k_return ++
						kst_tab_armo_campioni_ultimo = kst_tab_armo_campioni
					end if									
					
				next
			
			end if
		next
		
		if kst_tab_armo_campioni_ultimo.barcode > " " then
			set_ultimo_collicampioni_barcode_in_base(kst_tab_armo_campioni_ultimo)			// AGGIORNA ANCHE TAB BASE				
		end if
		
	else
		if k_nr_barcode < 0 then
			
			kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_dati_anomali
			kguo_exception.kist_esito.sqlerrtext = "Attenzione sono state prodotte " + string(kds_1.getitemnumber(1, "contati")) + " etichette CONTROCAMPIONI, ma " &
																+ kkg.acapo + "sul Lotto ne sono stati indicate " + string(kds_1.getitemnumber(1, "campionecolli")) + "!!! " &
																+ kkg.acapo + "Prego correggere il numero colli Campioni o rimuovere i barcode prodotti."
			throw kguo_exception
		end if
		
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
	
end try

return k_return

end function

public function string get_ultimo_numero_barcode () throws uo_exception;/*
 Torna ultimo progressivo del BARCODE 
     Ritorna: STRINGA con ultimo progr Barcode trovato                                     
//--------------------------------------------------------------------------------------------
*/
string k_return=""
string k_barcode_intero=""
st_tab_base kst_tab_base
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())

//--- cerca ultimo barcode nelBASE
	k_barcode_intero = get_ultimo_numero_barcode_da_base( )
	
//--- se non trovato cerca in tabella 
	kst_tab_base.dosimetro_ult_barcode = get_ultimo_numero_barcode_da_tab(left(trim(k_barcode_intero),3) )  // Ultimo Barcode caricato in TABELLA
	if len(trim(kst_tab_base.dosimetro_ult_barcode)) > 0  then
		k_barcode_intero = left(trim(k_barcode_intero),3) + trim(kst_tab_base.dosimetro_ult_barcode)
	end if		

//--- se OK torna il Barcode
	if len(trim(k_barcode_intero)) > 3  then
      k_return = trim(k_barcode_intero)
	else
      k_return = trim(k_barcode_intero) + "AA000"
	end if
   
catch (uo_exception kuo_exception)
	throw kuo_exception


finally 

end try

return k_return

end function

public subroutine set_ts_stampa (st_tab_armo_campioni ast_tab_armo_campioni) throws uo_exception;/*
  Aggiorna data e ora di stampa Etichette
     input: st_tab_armo_campioni.id_armo_campione 
*/
st_esito kst_esito 


try
	kst_esito = kguo_exception.inizializza(this.classname())

	if ast_tab_armo_campioni.id_armo_campione > 0 then
	else
		kst_esito.esito = kkg_esito.dati_insuff
		kst_esito.sqlcode = 0 
		kst_esito.SQLErrText = "Aggiornamento Data e ora di stampa etichetta in tabella Campioni non eseguito, manca Id Campione. " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	ast_tab_armo_campioni.ts_stampa = kGuf_data_base.prendi_x_datins() 
	ast_tab_armo_campioni.x_datins = kGuf_data_base.prendi_x_datins() 
	ast_tab_armo_campioni.x_utente = kGuf_data_base.prendi_x_utente() 

//--- Aggiorna lo stato e le note della rilevazione dosimetrica	
	update armo_campioni set 	 
			 ts_stampa = :ast_tab_armo_campioni.ts_stampa
			 ,x_datins = :ast_tab_armo_campioni.x_datins
			 ,x_utente = :ast_tab_armo_campioni.x_utente
		where id_armo_campione = :ast_tab_armo_campioni.id_armo_campione
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_magazzino, "Errore durante aggiornamento Data e ora di stampa etichetta a " &
												+ string(ast_tab_armo_campioni.ts_stampa) + " in tabella Campioni id " &
										 	   + string(ast_tab_armo_campioni.id_armo_campione))
		if ast_tab_armo_campioni.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		throw kguo_exception
	end if	

//---- COMMIT....	
	if ast_tab_armo_campioni.st_tab_g_0.esegui_commit = "N" then
	else
		kguo_sqlca_db_magazzino.db_commit( )
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception


end try
		


end subroutine

public function integer get_nr_barcode_x_id_armo (long a_id_armo) throws uo_exception;/*
 Torna il numero dei barcode generati
    input: id_armo
    out: numero bcode generati
*/
int k_return
long k_rows
uo_ds_std_1 kds_1


try
	
	kguo_exception.inizializza(this.classname())

	if a_id_armo > 0 then 
		kds_1 = create uo_ds_std_1
		kds_1.dataobject = "ds_armo_campioni_x_id_armo"
		kds_1.settransobject(kguo_sqlca_db_magazzino)
		k_rows = kds_1.retrieve(a_id_armo)
		if k_rows < 0 then
			kguo_exception.set_esito(kds_1.kist_esito)
			kguo_exception.kist_esito.sqlerrtext = "Errore in lettura barcode Campioni dal Lotto id Riga " + string(a_id_armo) + ". " + kkg.acapo + kds_1.kist_esito.sqlerrtext
			throw kguo_exception 
		end if
		
		k_return = k_rows
		
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
	
end try

return k_return

end function

on kuf_armo_campioni.create
call super::create
end on

on kuf_armo_campioni.destroy
call super::destroy
end on

