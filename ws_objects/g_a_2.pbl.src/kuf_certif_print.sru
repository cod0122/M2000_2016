$PBExportHeader$kuf_certif_print.sru
forward
global type kuf_certif_print from kuf_parent
end type
end forward

global type kuf_certif_print from kuf_parent
end type
global kuf_certif_print kuf_certif_print

type variables
//
private kuf_certif kiuf_certif
private kuf_armo_inout kiuf_armo_inout
private kuf_file_explorer kiuf_file_explorer
private kuf_armo kiuf_armo
private kuf_stampe kiuf_stampe
private kuf_base kiuf_base
private kuf_utility kiuf_utility
private kuf_meca_reportpilota kiuf_meca_reportpilota
private kuf_pdf kiuf_pdf 
private kuf_clienti kiuf_clienti
private kuf_docpath kiuf_docpath

private kds_certif_stampa kids_certif_stampa
private kds_certif_stampa_completa kids_certif_stampa_completa
private kds_certif_stampa_allegati kids_certif_stampa_allegati

public st_tab_certif kist_tab_certif
public boolean ki_flag_stampa_di_test = true
public string ki_stampante[2] 
public boolean ki_flg_ristampa_xddt

end variables

forward prototypes
public function st_esito leggi (integer k_tipo, ref st_tab_certif kst_tab_certif)
public function long aggiorna_docprod (ref st_tab_certif kst_tab_certif[]) throws uo_exception
public function boolean if_stampato (readonly st_tab_certif kst_tab_certif) throws uo_exception
private function boolean stampa_attestato_set_printer () throws uo_exception
private function boolean stampa_attestato_prepara () throws uo_exception
private function integer stampa_attestato_allegati () throws uo_exception
public function long stampa_digitale_esporta (ref st_docprod_esporta kst_docprod_esporta) throws uo_exception
private function long stampa_digitale () throws uo_exception
private function boolean stampa_1 (ref st_tab_certif ast_tab_certif) throws uo_exception
public function boolean if_stampato_x_id_meca (ref st_tab_certif kst_tab_certif) throws uo_exception
private function integer get_path_root (ref st_tab_docpath ast_tab_docpath[]) throws uo_exception
public function string get_path_email (ref st_tab_certif ast_tab_certif) throws uo_exception
private function string get_nome_pdf (ref st_tab_certif ast_tab_certif) throws uo_exception
private function any stampa_attestato_get_nome_pdf (ref st_tab_certif ast_tab_certif, boolean a_ristampa) throws uo_exception
public function boolean stampa_digitale_esporta_1 (string a_path_pdf) throws uo_exception
public function any get_path_doc (ref st_tab_certif ast_tab_certif, boolean a_ristampa) throws uo_exception
private function st_esito set_e1_wo_f5548014 (st_tab_certif kst_tab_certif) throws uo_exception
private function st_esito set_e1_wo_f5537001 (st_tab_certif kst_tab_certif) throws uo_exception
private function boolean stampa_attestato_x_con_allegati () throws uo_exception
private function boolean stampa_attestato_x_singolo () throws uo_exception
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function st_esito stampa_tb_update (ref st_tab_certif kst_tab_certif) throws uo_exception
public function string get_form_di_stampa_now ()
public function boolean set_attestato (st_tab_certif ast_tab_certif) throws uo_exception
public function integer stampa_digitale_rimuove (string a_path_pdf) throws uo_exception
public function integer stampa (ref st_tab_certif ast_tab_certif[]) throws uo_exception
private function boolean stampa_update () throws uo_exception
public function boolean u_get_flag_ristampa ()
end prototypes

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



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


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

public function long aggiorna_docprod (ref st_tab_certif kst_tab_certif[]) throws uo_exception;//
//--- Aggiorna righe tabelle DOCPROD
//---
//--- input:  array st_tab_certif con l'elenco dei documenti da aggiornare
//--- out: Numero documenti caricati
//---
//--- Lancia EXCEPTION
//---
long k_return = 0
long k_riga_certif=0, k_nr_certif=0, k_nr_doc=0, k_righe, k_riga
string k_nome, k_nome_file
string k_path_nomefile[]
st_esito kst_esito
st_tab_docprod kst_tab_docprod
st_tab_meca kst_tab_meca
st_docprod_esporta kst_docprod_esporta
st_tab_clienti kst_tab_clienti
kuf_docprod kuf1_docprod
kuf_armo kuf1_armo
kuf_clienti kuf1_clienti


	kst_esito = kguo_exception.inizializza(this.classname())

	if not isvalid(kiuf_certif) then kiuf_certif = create kuf_certif

	k_nr_certif = upperbound(kst_tab_certif[])

	if k_nr_certif > 0 then
		
		
//--- Crea Documenti da Esportare (DOCPROD)
		kuf1_docprod = create kuf_docprod
		kuf1_clienti = create kuf_clienti
		kuf1_armo = create kuf_armo

		for k_riga_certif = 1 to k_nr_certif

			try

				if kst_tab_certif[k_riga_certif].id > 0 then
	
					kst_tab_docprod.doc_num = kst_tab_certif[k_riga_certif].num_certif
					kst_tab_docprod.doc_data = kst_tab_certif[k_riga_certif].data
					kst_tab_docprod.id_doc = kst_tab_certif[k_riga_certif].id
					
//--- Recupera il ID del Lotto di entrata
					kiuf_certif.get_id_meca(kst_tab_certif[k_riga_certif]) 
					
//--- Recupera il codice CLIENTE fatturato
					kst_tab_meca.id = kst_tab_certif[k_riga_certif].id_meca
					kuf1_armo.get_clie_listino(kst_tab_meca)
					kst_tab_docprod.id_cliente = kst_tab_meca.clie_3

					kst_tab_docprod.st_tab_g_0.esegui_commit = kst_tab_certif[1].st_tab_g_0.esegui_commit 
	
//---			kst_docprod_esporta.flg_img_bn[]
					kst_docprod_esporta.path[] = stampa_attestato_get_nome_pdf(kst_tab_certif[k_riga_certif], false)	// recupera il nome del path+file 
					k_righe = upperbound(kst_docprod_esporta.path[])
					if k_righe > 0 then
						if kst_docprod_esporta.path[1] > " " then 
							kst_docprod_esporta.kst_tab_docprod[1] = kst_tab_docprod

							kuf1_docprod.tb_add_certif ( kst_tab_docprod, true ) // AGGIUNGE IN DOCPROD e lo ESPORTA subito

							k_nr_doc++
						end if
					end if
					
				end if		

			catch (uo_exception kuo1_exception)
				throw kuo1_exception
				
			end try
			
		next
	
		if isvalid(kuf1_docprod) then destroy kuf1_docprod
		if isvalid(kuf1_armo) then destroy kuf1_armo
		if isvalid(kuf1_clienti) then destroy kuf1_clienti
		
		if k_nr_doc > 0 then
			k_return = k_nr_doc
		end if
	
	end if


return k_return

end function

public function boolean if_stampato (readonly st_tab_certif kst_tab_certif) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla se Attestato stampato da id
//--- 
//--- 
//--- Inp: st_tab_certif.id
//--- Out: TRUE = stampato definitivamente
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


//--- x ID certificato			
	SELECT count(*)
			into :k_trovato
			 FROM certif  
			 where  id  = :kst_tab_certif.id and data_stampa > '01.01.1990'
			 using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura Attestato (certif) id = " + string(kst_tab_certif.id) + " " &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
									 
		kst_esito.esito = KKG_ESITO.db_ko
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		if k_trovato > 0 then k_return = true
	end if
	

return k_return



end function

private function boolean stampa_attestato_set_printer () throws uo_exception;
/*
 Stampa Attestato di Trattamento
 qui ricava le stampanti su cui fare il documento e gli allegati
	 Out: ki_stampanti[] [1]=il documento, [2]=gli allegati
	 Rit: TRUE stampante 1 impostata
*/
boolean k_return=false
string k_stampante
int k_rc


try
	
	kguo_exception.inizializza(this.classname())
	
//--- se stampante già impostata ESCE con OK!
	if ki_stampante[1] > " " then return true
		
	if not isvalid(kiuf_stampe) then kiuf_stampe = create kuf_stampe
	if not isvalid(kiuf_base) then kiuf_base = create kuf_base

//--- get della stampante 1 quella principale			
	ki_stampante[1] = trim(mid(kiuf_base.prendi_dato_base(kiuf_base.kki_base_utenti_codice_stcert1),2)) // controlla prima la stampante personale
	if ki_stampante[1] > " " then
	else
		ki_stampante[1] = trim(mid(kiuf_base.prendi_dato_base("stamp_attestato"),2)) // get stampante da proprietà generale
	end if
	if ki_stampante[1] > " " then
		k_stampante = trim(ki_stampante[1])
		ki_stampante[1] = kiuf_stampe.get_stampante_da_nome(ki_stampante[1])
		if ki_stampante[1] > " " then
		else
			kguo_exception.inizializza( )
			kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_dati_insufficienti)
			k_rc = kguo_exception.messaggio_utente( "Stampante Attestato", &
							"Stampante '" + k_stampante + "' indicata in 'Proprietà' non è stata riconosciuta. Scegliere una stampante dal prossimo elenco")
		end if
	else
		
		kguo_exception.inizializza( )
		kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_dati_insufficienti)
		k_rc = kguo_exception.messaggio_utente( "Stampante Attestato non indicata", &
							"Manca in 'Proprietà' il nome delle stampante principale. Scegliere temporaneamente un'unica stampante dal prossimo elenco")
	end if

//--- se stampante non indicata o non riconosciuta la chiede
	if ki_stampante[1] > " " then
	else
		if printsetup() > 0 then
			ki_stampante[1] = trim(PrintGetPrinter ( ))
		else
			kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_interr_da_utente )
			kguo_exception.setmessage ("Stampa Annullata dall'utente") 
			throw kguo_exception
		end if
	end if

	k_return = true

//--- get altra stampante
	ki_stampante[2] = trim(mid(kiuf_base.prendi_dato_base(kiuf_base.kki_base_utenti_codice_stcert2),2)) // controlla prima la stampante personale
	if ki_stampante[2] > " " then
	else
		ki_stampante[2] = trim(mid(kiuf_base.prendi_dato_base("stamp_attestato2"),2)) // get stampante da proprietà generale
	end if
	if ki_stampante[2] > " " then
		ki_stampante[2] = kiuf_stampe.get_stampante_da_nome(ki_stampante[2])
	else
		ki_stampante[2] = "" // se non ancora impostata allora niente stampa!! ki_stampante[1]
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception

finally	
//	SetPointer(kkg.pointer_default)
	
end try


return k_return 

end function

private function boolean stampa_attestato_prepara () throws uo_exception;//
//====================================================================
//=== Preparazione alla Stampa Attestato di Trattamento
//=== per eseguire la stampa lanciare la routine "stampa"
//===
//=== Par. Inut: datawindow da popolare 
//===                variabile intero oggetto: kist_tab_certif (valorizzare il num. certificato)
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:    Vedi standard
//=== 
//====================================================================
//
//=== 
boolean k_return = false
string k_dataoggi, k_path_risorse, k_rcx, k_path_risorse_OLD
string k_file, k_flg_img_bn
//long k_rc, k_riga, k_riga_ds
int k_row

//datastore kds_appo
st_open_w kst_open_w
st_esito kst_esito, kst_esito_armo
st_profilestring_ini kst_profilestring_ini
st_tab_meca kst_tab_meca


try

	kst_esito = kguo_exception.inizializza(this.classname())

	if not isvalid(kiuf_certif) then kiuf_certif = create kuf_certif

//--- piglia l'ID
	select id
			  into  :kist_tab_certif.id 
			  from certif 
			  where num_certif = :kist_tab_certif.num_certif  
			  using sqlca;

//--- esiste?
	if sqlca.sqlcode = 100 then
		kist_tab_certif.id = 0
	else
		if kst_esito.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Fallita lettura per stampa Attestato n.: "+ string(kist_tab_certif.num_certif) + "~n~r"&
						 + "Errore: " + trim(sqlca.sqlerrtext)
			kst_esito.esito = KKG_ESITO.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if

	if kids_certif_stampa.ki_flag_ristampa then
		
		if kist_tab_certif.id = 0 then
			kst_esito.SQLErrText = "Ristampa Attestato n. " + string(kist_tab_certif.num_certif) + " non trovato in archivio, controllare se è nei 'da stampare' " // "~n~r"&
			kst_esito.esito = KKG_ESITO.no_esecuzione
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
	else
		kist_tab_certif.data_stampa = kkg.data_zero
				
	//--- Attestato pronto?	
		if not kiuf_certif.if_crea_certif(kist_tab_certif) then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Attestato n. "+ string(kist_tab_certif.num_certif) + " non pronto (Lotto non trattato / Dosimetria non rilevata). ~n~r"
			kst_esito.esito = kkg_esito.no_esecuzione
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
	//--- crea attestato
		kst_esito = kiuf_certif.crea_certif(kist_tab_certif)
		if kst_esito.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Fallita generazione Attestato n.: "+ string(kist_tab_certif.num_certif) + "~n~r"&
						 + "Errore: " + trim(sqlca.sqlerrtext)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
	end if
//		kds_appo = create datastore
//		kds_appo.dataobject = kids_certif_stampa.dataobject	
//		k_rc=kds_appo.settransobject(sqlca)
		
//		kds_appo.reset()	
//--- retrive dell'attestato 
//		k_rc=kds_appo.retrieve(  &
//										kist_tab_certif.num_certif &
//										,kist_tab_certif.num_certif )

//--- retrive dell'attestato 
	k_row=kids_certif_stampa.retrieve(kist_tab_certif.num_certif, kist_tab_certif.num_certif )
	
//--- deve produrre una sola riga se oltre qualcosa non va!	
	if k_row > 1 then
		kguo_exception.kist_esito.SQLErrText = "Anomalia in generazione Attestato n.: "+ string(kist_tab_certif.num_certif) + "~n~r"&
					 + "Errore: Sono state prodotte " + string(k_row) + " pagine anzichè una! La stampa prosegue ma verificare i dati del documento."
		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_dati_anomali
		kguo_exception.messaggio_utente( )
		//throw kguo_exception
	end if											

//--- setta ON/OFF attestato di test	
//		kids_certif_stampa.u_set_test(ki_flag_stampa_di_test)

//		if kds_appo.rowcount() > 0 then
	
//--- copia il ds nel ds passato come argomento
//			k_riga_ds = kds_appo.RowCount()
//			k_riga = kids_certif_stampa.RowCount() + 1
//			k_rc = kds_appo.RowsCopy(kds_appo.GetRow(), kds_appo.RowCount(), Primary!, kids_certif_stampa, k_riga, Primary!)
//			k_rc = kids_certif_stampa.rowcount()


////031016//--- controllo se materiale farmaceutico
////			kuf1_armo = create kuf_armo
////			kst_tab_meca.id = kist_tab_certif.id_meca
////			if kuf1_armo.if_lotto_farmaceutico(kst_tab_meca) then //se mat farmaceutico 
////				kds_attestato.setitem(kds_attestato.getrow(), "k_mat_farmaceutico", "1")
////			else
////				kds_attestato.setitem(kds_attestato.getrow(), "k_mat_farmaceutico", "0")
////			end if
//
////--- Imposta immagini e risorse grafiche della stampa 
////			stampa_attestato_set_img(kds_attestato)
			
//		end if
		
	k_return= true
		

catch(uo_exception kuo_exception)
	throw kuo_exception

finally
//	if isvalid(kuf1_armo) then destroy kuf1_armo
//	if isvalid(kds_appo) then destroy kds_appo
	
end try



return k_return

end function

private function integer stampa_attestato_allegati () throws uo_exception;//
//-----------------------------------------------------------------------
//--- Stampa gli Allegati all'Attestato di Trattamento
//--- per eseguire la stampa lanciare prima la routine "stampa_attestato"
//---
//--- Par. Input: kids_certif_stampa ppolare   
//--- 
//--- Ritorna tab. ST_ESITO, Esiti:    Vedi standard 
//--- 
//-----------------------------------------------------------------------
//
int k_return=0
int k_errore  
string k_old_str, k_new_str
int k_start_pos
long k_rc
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
		
	if not isvalid(kids_certif_stampa_allegati) then kids_certif_stampa_allegati = create kds_certif_stampa_allegati
	
	if kids_certif_stampa_allegati.u_retrieve(kist_tab_certif) > 0 then   // se ottengo gli 'Allegati'
	
		kids_certif_stampa_allegati.Object.DataWindow.Print.DocumentName = kids_certif_stampa_allegati.u_get_nome_doc( )
	
//--- ricava la stampante-certificato solo se Stampa vera e stampante non impostata
		if ki_stampante[2] > " " then
			if PrintSetPrinter (ki_stampante[2]) > 0 then
				SetPointer(kkg.pointer_attesa)
	//--- stampa dw direttamente sulla stampante indicata				
				if kids_certif_stampa_allegati.print() > 0 then
					kst_esito.esito = kkg_esito.OK
					k_return ++
				else
					kst_esito.sqlcode = 0
//					kst_esito.SQLErrText = "Errore durante la stampa Allegati dell'Attestato: " + string(kist_tab_certif.num_certif) + "~n~r" 
					kst_esito.SQLErrText = "Errore seconda STAMPANTE '" + kkg.acapo &
												+ trim(ki_stampante[2]) + kkg.acapo &
												+ "', in stampa Allegati dell'Attestato: " + string(kist_tab_certif.num_certif) 
					kst_esito.esito = kkg_esito.bug
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
			else	
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Allegati dell'Attestato n. " + string(kist_tab_certif.num_certif) + " non sono stati stampati~n~r" 
				kst_esito.esito = kkg_esito.bug
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally	
	SetPointer(kkg.pointer_default)
	
end try


return k_return 

end function

public function long stampa_digitale_esporta (ref st_docprod_esporta kst_docprod_esporta) throws uo_exception;//---
//---  Esporta in digitale (pdf) gli ATTESTATI
//--- inp: 	kst_docprod_esporta.kst_tab_docprod[].id_doc
//---			kst_docprod_esporta.kst_tab_docprod[].doc_num
//---			kst_docprod_esporta.kst_tab_docprod[].doc_data
//---			kst_docprod_esporta.flg_img_bn[]
//---			kst_docprod_esporta.path[]
//---			kst_docprod_esporta.kst_tab_docprod[].id_docprod  0=nessuna registrazione in tab DOCPROD
//---			
//---
long k_return=0
int k_n_documenti_emessi=0, k_id_stampa, k_righe_certif
string k_esito="", k_path
int k_item_attestato=0, k_pos, k_end, k_n_attestati, k_n_pdf_exp_tot, k_n_pdf_exp
st_esito kst_esito
boolean k_sicurezza=false
st_tab_certif kst_tab_certif
uo_exception kuo1_exception


try
	
	kst_esito = kguo_exception.inizializza(this.classname())

	if not isvalid(kiuf_certif) then kiuf_certif = create kuf_certif
	
	if_sicurezza(kkg_flag_modalita.stampa)

//--- OK finalmente inizio a lavorare -----------------------------------------------------------------------------

//--- se oggetto dw attestato NON ancora definito	
//	if not isvalid(kdw_attestato) then
//		kdw_attestato = create datastore
//	end if
	if not isvalid(kids_certif_stampa) then
//--- CREA oggetto stampa-attestato GOLD/SILVER...
		kids_certif_stampa = create kds_certif_stampa 
	end if

	k_n_attestati = upperbound(kst_docprod_esporta.kst_tab_docprod[])
	for k_item_attestato = 1 to k_n_attestati

		kist_tab_certif.id = kst_docprod_esporta.kst_tab_docprod[k_item_attestato].id_doc
		if kist_tab_certif.id > 0 then		
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Numero Attestato assente nell'elemento trattato n. " + string(k_item_attestato) + "."//: ~n~r" + "nessun numero attestato indicato"
			kst_esito.esito = kkg_esito.bug
			kuo1_exception = create uo_exception
			kuo1_exception.set_esito(kst_esito)
			throw kuo1_exception
		end if
			
//--- Popola area dell'attestato sul quale sto lavorando
		kist_tab_certif.num_certif = kst_docprod_esporta.kst_tab_docprod[k_item_attestato].doc_num
		kist_tab_certif.data = kst_docprod_esporta.kst_tab_docprod[k_item_attestato].doc_data

//--- piglia il Ricevente			
		kiuf_certif.get_clie(kist_tab_certif)

//--- Decide quale form dell'Attesto utilizzare (Gold/Silver/...) o RISTAMPA
		kids_certif_stampa.set_attestato(kist_tab_certif) 
		
//--- retrive dell'attestato 
		k_righe_certif = kids_certif_stampa.retrieve(kist_tab_certif.num_certif, kist_tab_certif.num_certif )
	
		if k_righe_certif > 0 then

//--- Imposta immagini e risorse grafiche della stampa 
			kids_certif_stampa.u_set_img()

			kids_certif_stampa.object.k_test[1] = '0' // evita la banda TEST
		
			k_n_pdf_exp_tot = upperbound(kst_docprod_esporta.path[])
			
			for k_n_pdf_exp = 1 to k_n_pdf_exp_tot
				
//--- Rimuove documenti precedenti
				try
					stampa_digitale_rimuove(kst_docprod_esporta.path[k_n_pdf_exp])
				catch (uo_exception kuo2_exception)
					kuo2_exception.scrivi_log()
				end try

//--- Registrazione documento digitali
				if stampa_digitale_esporta_1(kst_docprod_esporta.path[k_n_pdf_exp]) then
					k_n_documenti_emessi ++
				end if
				
			next
			k_return += k_n_documenti_emessi

//--- Aggiorna tab Attestato		
			if kst_docprod_esporta.kst_tab_docprod[k_item_attestato].id_docprod > 0 then
				kst_tab_certif.id = kst_docprod_esporta.kst_tab_docprod[k_item_attestato].id_doc
				kst_tab_certif.id_docprod = kst_docprod_esporta.kst_tab_docprod[k_item_attestato].id_docprod
				kiuf_certif.set_id_docprod(kst_tab_certif)
			end if
			
		end if
			
	end for

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try
		
return k_return		

end function

private function long stampa_digitale () throws uo_exception;//
//--- Emissione e Aggiornamento Attestati pdf nella tabella DOCPROD
//---
//--- input: array st_tab_certif con l'elenco dei documenti da emettere/aggiornare
//--- out: Numero documenti trattati
//---
//--- Lancia EXCEPTION
//---
long k_return = 0
long k_nr_doc=0, k_righe
st_esito kst_esito
st_tab_meca kst_tab_meca
st_docprod_esporta kst_docprod_esporta
st_tab_certif kst_tab_certif


try

	kst_esito = kguo_exception.inizializza(this.classname())

	if not isvalid(kiuf_armo) then kiuf_armo = create kuf_armo

	kst_tab_certif.id = kids_certif_stampa.getitemnumber(1, "certif_id")
	kst_tab_certif.num_certif = kids_certif_stampa.getitemnumber(1, "certif_num_certif")
	kst_tab_certif.data = kids_certif_stampa.getitemdate(1, "certif_data")
	kst_tab_certif.id_meca = kids_certif_stampa.getitemnumber(1, "id_meca")
	
	if kst_tab_certif.id > 0 then
	
//--- Recupera i codici cliente del Lotto
		kst_tab_meca.id = kst_tab_certif.id_meca
		kiuf_armo.get_clie(kst_tab_meca)

//--- Recupera il ID del Lotto di entrata
//		get_id_meca(kst_tab_certif) 
					
//--- Recupera il codice CLIENTE fatturato
//--- 
		kst_docprod_esporta.kst_tab_docprod[1].id_doc = kst_tab_certif.id
		kst_docprod_esporta.kst_tab_docprod[1].doc_num = kst_tab_certif.num_certif
		kst_docprod_esporta.kst_tab_docprod[1].doc_data = kst_tab_certif.data
		kst_docprod_esporta.kst_tab_docprod[1].id_cliente = kst_tab_meca.clie_3
		kst_docprod_esporta.flg_img_bn[1] = false 

		kst_docprod_esporta.path[] = stampa_attestato_get_nome_pdf(kst_tab_certif, kids_certif_stampa.ki_flag_ristampa)	// recupera il nome documento path+file 
				
		k_righe = upperbound(kst_docprod_esporta.path[])
		if k_righe > 1 then
			k_nr_doc = stampa_digitale_esporta(kst_docprod_esporta)  // Emissione documenti digitali nelle cartelle indicate
		end if
				
	end if		
	
	
catch (uo_exception kuo1_exception)
	throw kuo1_exception

finally
	if k_nr_doc > 0 then
		k_return = k_nr_doc
	end if
	
end try
			


return k_return

end function

private function boolean stampa_1 (ref st_tab_certif ast_tab_certif) throws uo_exception;//---
//---  Stampa ATTESTATO
//---
boolean k_return=false
int k_item_attestato=0


try
	
	kguo_exception.inizializza(this.classname())

	kist_tab_certif = ast_tab_certif // attestato sul quale sto lavorando

//--- Decide quale form dell'Attesto utilizzare (Gold/Silver/...) o RISTAMPA
	if not kids_certif_stampa.set_attestato(kist_tab_certif) then
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ko )
		kguo_exception.setmessage("Fallita associazione Formato di stampa per l'Attestato: "+ string(kist_tab_certif.num_certif))
		throw kguo_exception
	end if
	
	if NOT stampa_attestato_prepara () then   // prepara il ds kids_certif_stampa
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ko)
		kguo_exception.setmessage("Fallita Operazione di preparazione 'Stampa Attestato' " + string( kist_tab_certif.num_certif ))
		throw kguo_exception
	end if
	
	if kids_certif_stampa.rowcount( ) = 0 then
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_not_fnd )
		kguo_exception.setmessage ("Nessun Attestato trovato da stampare (" + string(kist_tab_certif.num_certif ) + ") ") 
		throw kguo_exception
	end if
			
//--- Controlli in sicurezza 
	if kids_certif_stampa.ki_flag_ristampa then
//--- Se sono in RI-STAMPA controll 'leggeri' in sicurezza 
		if_sicurezza(kkg_flag_modalita.visualizzazione) 
	else
//--- Se sono in STAMPA (no ristampa) controllo puntuale in sicurezza 
		if_sicurezza(kkg_flag_modalita.stampa) 
	end if

	ki_flag_stampa_di_test = false

	if trim(ki_stampante[1]) > " " then
	else

		stampa_attestato_set_printer( )   // imposta le stampanti ki_stampante[]
		
	end if 
	
	if not kids_certif_stampa.ki_flag_ristampa then
		k_return = stampa_attestato_x_con_allegati()  		// STAMPA ATTESTATO CON ALLEGATI!!
	else	
		k_return = stampa_attestato_x_singolo()				// RI-STAMPA SINGOLA DELL'ATTESTATO !!
	end if

	if k_return then
		stampa_digitale() // EMISSIONE DIGITALE DELL'ATTESTATO
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try
		
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



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()


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

private function integer get_path_root (ref st_tab_docpath ast_tab_docpath[]) throws uo_exception;//
//--- Get del PATH root prefisso da aggiunere al path definitivo
//--- Out: riempie array kst_tab_docpath[]
//--- Rit: numero path trovati
//---
//--- Lancia EXCEPTION
//---
int k_return
st_tab_doctipo kst_tab_doctipo
st_esito kst_esito
kuf_docpath kuf1_docpath
kuf_doctipo kuf1_doctipo


try

	kst_esito = kguo_exception.inizializza(this.classname())
	
	kuf1_docpath = create kuf_docpath
	kuf1_doctipo = create kuf_doctipo

	kst_tab_doctipo.tipo = kuf1_doctipo.kki_tipo_attestati
	ast_tab_docpath[1].id_doctipo = kuf1_doctipo.get_id_doctipo_da_tipo(kst_tab_doctipo)
	if ast_tab_docpath[1].id_doctipo > 0 then 
			
		k_return = kuf1_docpath.get_path_x_tipo(ast_tab_docpath[])

	end if
	
catch (uo_exception kuo1_exception)
	throw kuo1_exception
	
finally
	if isvalid(kuf1_docpath) then destroy kuf1_docpath
	if isvalid(kuf1_doctipo) then destroy kuf1_doctipo
	
end try
			

return k_return

end function

public function string get_path_email (ref st_tab_certif ast_tab_certif) throws uo_exception;//
//--- Get del PATH (senza nome file) di dove mettere i documenti da inviare via email
//---
//--- inp: st_tab_certif.id_meca
//--- Rit: string = path completo root + personalizzazioni NO il nome file 
//---
//--- Lancia EXCEPTION
//---
string k_return
int k_righe, k_rc
string k_path_interno, k_path_suffisso
datastore kds_1
st_tab_docpath kst_tab_docpath[]
st_esito kst_esito

try

	kst_esito = kguo_exception.inizializza(this.classname())

	if ast_tab_certif.id_meca > 0 then
		
		kds_1 = create datastore
		kds_1.dataobject = "ds_certif_path_email"
		kds_1.settransobject(kguo_sqlca_db_magazzino)
		
		k_rc = kds_1.retrieve(ast_tab_certif.id_meca) 
		
		if k_rc > 0 then

			k_righe = get_path_root(kst_tab_docpath[])

			if k_righe > 0 then
				
//--- Path x uso interno sempre presente 
				k_path_interno = kguo_path.get_doc_root_interno() 
					
				k_path_suffisso = kkg.path_sep  &
										+ string(year(kds_1.getitemdate(1 , "certif_data"))) &
										+ kkg.path_sep &
										+ "email"  &
										+ kkg.path_sep &
										+ "c" &
										+ string(kds_1.getitemnumber(1 , "clie_3"), "#") &
										+ kkg.path_sep &
										+ "lot" & 
										+ string(kds_1.getitemnumber(1 , "id_meca"), "#") &
										+ kkg.path_sep 
										
				k_return = k_path_interno &
										+ kkg.path_sep + kst_tab_docpath[1].path &
										+ k_path_suffisso
			else
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.sqlerrtext = "Lettura path email del Certificato non trovata, path generale interno non indicato o non richiesto. Id Lotto: " + string(ast_tab_certif.id_meca) 
				kguo_exception.set_esito(kst_esito)
			end if
		else
			if k_rc < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlerrtext = "Errore in lettura path email del Certificato id Lotto: " + string(ast_tab_certif.id_meca) 
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Lettura path email del Certificato non eseguita manca id Lotto"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if		

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
	
end try
			

return k_return[]

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

	kst_esito = kguo_exception.inizializza(this.classname())

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

private function any stampa_attestato_get_nome_pdf (ref st_tab_certif ast_tab_certif, boolean a_ristampa) throws uo_exception;//
//--- Compone il nome del file compreso di PATH
//---
//--- input: st_tab_certif id, num_certif, data, id_meca; st_tab_meca.clie_3;   TRUE=ristampa del documento, FALSE=stampa nuova
//--- Rit: string array = path + nome file il primo trovato (può essercene più di 1)
//---
//--- Lancia EXCEPTION
//---
string k_return[]
string k_nome_file
string k_path_nomefile[]
int k_righe, k_riga
st_esito kst_esito

try

	kst_esito = kguo_exception.inizializza(this.classname())

	if ast_tab_certif.id > 0 then

		k_nome_file = get_nome_pdf(ast_tab_certif)	// recupera il nome del file 
		k_path_nomefile[] = get_path_doc(ast_tab_certif, a_ristampa)
		
		k_righe = upperbound(k_path_nomefile)
		for k_riga = 1 to k_righe
			if k_path_nomefile[1] > " " then 
				k_return[k_riga] = k_path_nomefile[k_riga] + k_nome_file
			end if
		end for
		
	end if		

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	
finally
	
end try
			

return k_return[]

end function

public function boolean stampa_digitale_esporta_1 (string a_path_pdf) throws uo_exception;//---
//--- Esporta in digitale (pdf) l'ATTESTATI indicato
//--- inp: 	a_path_pdf il nome file con il percorso da salvare
//---	rit: TRUE = documento emesso
//---
boolean k_return
int k_n_documenti_stampati=0, k_id_stampa
string k_path
long k_pos, k_end
st_esito kst_esito


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if not isvalid(kiuf_file_explorer) then kiuf_file_explorer = create kuf_file_explorer
	
	a_path_pdf = trim(a_path_pdf)
	
//--- Controllo se indicato un percorso
	if a_path_pdf > " " then 

		k_n_documenti_stampati ++
				
//--- estrazione del solo path senza nome file
		k_path = trim(a_path_pdf)
		k_pos = 0
		do 
			k_pos = pos(k_path, kkg.path_sep, k_pos + 1)
			if k_pos > 0 then
				k_end = k_pos
			end if
		loop while k_pos > 0
		k_path = left(k_path, k_end)
		kiuf_file_explorer.u_directory_create(k_path)

//=== Crea il PDF
//					kids_certif_stampa.Object.DataWindow.Export.PDF.Distill.CustomPostScript = "1"
		kids_certif_stampa.object.DataWindow.Export.PDF.Method = NativePDF!
//					kids_certif_stampa.Object.DataWindow.Export.PDF.NativePDF.ImageFormat = "0"  //BMP
		k_id_stampa = kids_certif_stampa.saveas(a_path_pdf,PDF!, false)   //

		if k_id_stampa < 1 then
						
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Emissione Attestato digitale non generato nella cartella:~n~r"  &
														 + a_path_pdf + " ~n~r" &
														 + "Esportazione fallita per errore: " + string(k_id_stampa)
			kst_esito.esito = kkg_esito.no_esecuzione
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception

		end if
		
		k_return = true

	end if	

			

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try
		
return k_return		

end function

public function any get_path_doc (ref st_tab_certif ast_tab_certif, boolean a_ristampa) throws uo_exception;//
//--- Get del PATH senza nome file
//---
//--- input: st_tab_certif.id_meca   TRUE=ristampa del documento, FALSE=stampa nuova
//--- Rit: string array = recupera i path completi di root e personalizzazioni (NO il nome file) + il barra finale
//---
//--- Lancia EXCEPTION
//---
string k_return[]
int k_righe, k_riga, k_path_riga
string k_path[], k_esito, k_path_interno, k_path_esterno, k_path_suffisso, k_path_email
date k_dataoggi
st_tab_docpath kst_tab_docpath[]
st_tab_doctipo kst_tab_doctipo
st_tab_meca kst_tab_meca
st_tab_clienti_web kst_tab_clienti_web
st_esito kst_esito


try

	kst_esito = kguo_exception.inizializza(this.classname())

	if ast_tab_certif.id_meca > 0 then
		
		if not isvalid(kiuf_docpath) then kiuf_docpath = create kuf_docpath

		k_righe = get_path_root(kst_tab_docpath[])

		if k_righe > 0 then
				
//--- get dati lotto da usare per il path	
//			kuf1_armo.get_clie(ast_tab_meca )
//			kuf1_armo.get_data_ent(ast_tab_meca)

//--- Path x uso interno sempre presente 
			k_path_interno = kguo_path.get_doc_root_interno() 
					
//--- valuto se PATH anche x documento Uso Esterno
			if kiuf_docpath.if_uso_esterno(kst_tab_docpath[1]) then 
				k_path_esterno = kguo_path.get_doc_root_esterno()
			end if
			
			k_dataoggi = kguo_g.get_dataoggi( )
			k_path_suffisso = kkg.path_sep  &
										+ string(kg_dataoggi, "yyyy") &
										+ kkg.path_sep &
										+ string(kg_dataoggi, "mm")  &
										+ kkg.path_sep & 
										+ string(kg_dataoggi, "dd")  &
										+ kkg.path_sep 
			k_path_riga = 0
			for k_riga = 1 to k_righe
				k_path_riga++   
				k_path[k_path_riga] = k_path_interno &
										+ kkg.path_sep + kst_tab_docpath[k_riga].path &
										+ k_path_suffisso
				if a_ristampa then
					k_path[k_path_riga] += "ristampe" +  kkg.path_sep 
				else
					if k_path_esterno > " " then
						k_path_riga++
						k_path[k_path_riga] = k_path_esterno &
											+ kkg.path_sep + kst_tab_docpath[k_riga].path &
											+ k_path_suffisso
					end if
				end if
			next
			
			// aggiunge la cartella per le email
			if not a_ristampa then
				if not isvalid(kiuf_armo) then kiuf_armo = create kuf_armo
				if not isvalid(kiuf_clienti) then kiuf_clienti = create kuf_clienti
				
				kst_tab_meca.id = ast_tab_certif.id_meca
				kiuf_armo.get_clie(kst_tab_meca)
				
				//--- verifica che l'invio email non sia stato inibito sul cliente
				kst_tab_clienti_web.id_cliente = kst_tab_meca.clie_3
				if kiuf_clienti.get_email_send_certif_off(kst_tab_clienti_web) = 0 then
				
					k_path_email = get_path_email(ast_tab_certif)
					if k_path_email > " " then
						k_path_riga++
						k_path[k_path_riga] = k_path_email
					end if
				end if
			end if
			
			k_return[] = k_path
				
		end if
					
	end if		

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	
finally

	
end try
			

return k_return[]

end function

private function st_esito set_e1_wo_f5548014 (st_tab_certif kst_tab_certif) throws uo_exception;//
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

private function boolean stampa_attestato_x_con_allegati () throws uo_exception;//
//--------------------------------------------------------------------------------
//--- Stampa Attestato di Trattamento e Allegati
//--- per eseguire la stampa lanciare prima la routine "stampa_attestato_prepara"
//---
//--- Par. Input:  preparare il kids_certif_stampa 
//--- 
//--- Ritorna: TRUE attestato stampato
//--- 
//--------------------------------------------------------------------------------
//
boolean k_return
string k_str, k_printer
long k_rc
int k_nr_doc_printed, k_nr_doc_aggiunti
string k_attestato_pdf, k_nome_report_pilota, k_path_appoggio
st_tab_meca_reportpilota kst_tab_meca_reportpilota
st_esito kst_esito


try

	SetPointer(kkg.pointer_attesa)

	kst_esito = kguo_exception.inizializza(this.classname())

	if not isvalid(kiuf_utility) then kiuf_utility = create kuf_utility

	kids_certif_stampa.u_set_test(ki_flag_stampa_di_test) // stampa/non stampa il testo 'TEST TEST'

//--- prepara il datastore composite di stampa
	if isvalid(kids_certif_stampa_completa) then destroy kids_certif_stampa_completa
	kids_certif_stampa_completa = create kds_certif_stampa_completa
	if NOT kids_certif_stampa_completa.u_compone_attestato(kids_certif_stampa) then
		kst_esito.SQLErrText = "Attestato n. " + string(kist_tab_certif.num_certif) + " non trovato durante l'operazione di stampa" //~n~r" 
		kst_esito.esito = KKG_ESITO.no_esecuzione
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if	

	if ki_stampante[1] <= " " then
		kst_esito.SQLErrText = "Nessuna stampante indicata per la stampa Attestati (n. " + string(kist_tab_certif.num_certif) + "). Stampa interrotta" 
		kst_esito.esito = KKG_ESITO.no_esecuzione
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	if PrintSetPrinter (ki_stampante[1]) < 1 then
		k_str = kiuf_utility.u_stringa_pulisci_asc(ki_stampante[1])
		kst_esito.SQLErrText = "Stampante '" + k_str + "' non trovata, Attestato n. " + string(kist_tab_certif.num_certif) + " non stampato" 
		kst_esito.esito = KKG_ESITO.no_esecuzione
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		k_printer = PrintGetPrinter()
	end if
		
		
//--- Genera i PDF e li accumula per la stampa finale
	if not isvalid(kiuf_meca_reportpilota) then kiuf_meca_reportpilota = create kuf_meca_reportpilota
	if not isvalid(kiuf_pdf) then kiuf_pdf = create kuf_pdf
	
	kiuf_pdf.u_inizializza()  // inizializza l'array che conterrà i pdf da stampare
	
	k_path_appoggio = kguo_path.get_temp( ) 
	
	k_attestato_pdf = k_path_appoggio + kkg.path_sep + "Attestato_" + string(kist_tab_certif.num_certif) + ".pdf"
	kids_certif_stampa_completa.object.DataWindow.Export.PDF.Method = NativePDF!
	//kids_certif_stampa_completa.Object.DataWindow.Export.PDF.NativePDF.ImageFormat = "0"  //BMP
	if kids_certif_stampa_completa.saveas(k_attestato_pdf, PDF!, false) < 0 then  // fa PDF per ATTESTATO+DATI LOTTO 
		kst_esito.SQLErrText = "Errore in preparazione PDF dell'Attestato e Dati Lotto n. " + string(kist_tab_certif.num_certif) // ~n~r"   
		kst_esito.esito = KKG_ESITO.ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	if kiuf_pdf.u_add_file(k_attestato_pdf) > 0 then
		k_nr_doc_aggiunti ++
	end if

	kst_tab_meca_reportpilota.id_meca = kist_tab_certif.id_meca
	k_nome_report_pilota = kiuf_meca_reportpilota.u_get_path_nomereport(kst_tab_meca_reportpilota) // get REPORT-PILOTA in PDF
	if trim(k_nome_report_pilota) > " " then
		if not FileExists(k_nome_report_pilota) then
			kst_esito.esito = kkg_esito.ko
			kst_esito.sqlerrtext = "Stampa Attestato n. " + string(kist_tab_certif.num_certif) &
									+ ": Report Pilota non trovato nella cartella '" + k_nome_report_pilota &
									+ "'. La stampa prosegue comunque senza questo report."
			kguo_exception.set_esito(kst_esito)		
		else
			if kiuf_pdf.u_add_file(k_nome_report_pilota) > 0 then // add REPORT-PILOTA in PDF
				k_nr_doc_aggiunti ++
			end if
		end if
	end if

////--- accoda una seconda copia del solo Attestato	
//	k_attestato_pdf = k_path_appoggio + kkg.path_sep + "Attestato_" + string(kist_tab_certif.num_certif) + "_CopiaSingola.pdf"
//	kids_certif_stampa.object.DataWindow.Export.PDF.Method = NativePDF!
//	if kids_certif_stampa.saveas(k_attestato_pdf, PDF!, false) < 0 then  // fa PDF del solo ATTESTATO 
//		kst_esito.SQLErrText = "Errore in preparazione PDF dell'Attestato n. " + string(kist_tab_certif.num_certif) // ~n~r"   
//		kst_esito.esito = KKG_ESITO.ko
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if
//	kuf1_pdf.u_add_file(k_attestato_pdf) 
// k_nr_doc_aggiunti ++

	
	k_nr_doc_printed = kiuf_pdf.u_print_pdf( )  // stampa i file PDF accantonati:  ATTESTATO + DATI LOTTO + REPORT PILOTA
	if k_nr_doc_printed <> k_nr_doc_aggiunti then
		kst_esito.SQLErrText = "Errore in stampa Attestato n. " + string(kist_tab_certif.num_certif) &
		      + ". Sono stati stampati " + string(k_nr_doc_printed) &
				+ " documenti invece di "  + string(k_nr_doc_aggiunti)  // ~n~r"   
		kst_esito.esito = KKG_ESITO.ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	kst_esito.esito = KKG_ESITO.OK
	k_return = true

catch (uo_exception kuo_exception)
	throw kuo_exception

finally	
	SetPointer(kkg.pointer_default)
	
end try


return k_return 

end function

private function boolean stampa_attestato_x_singolo () throws uo_exception;//
//--------------------------------------------------------------------------------
//--- Stampa il foglio dell'Attestato di Trattamento
//--- per eseguire la stampa lanciare prima la routine "stampa_attestato_prepara"
//---
//--- Par. Input:  preparare il kids_certif_stampa 
//--- 
//--- Ritorna: TRUE attestato stampato
//--- 
//--------------------------------------------------------------------------------
//
boolean k_return
int k_errore  
string k_old_str, k_new_str, k_stampante
int k_start_pos
long k_rc
st_esito kst_esito


try

	kst_esito = kguo_exception.inizializza(this.classname())

	if not isvalid(kids_certif_stampa) then kids_certif_stampa = create kds_certif_stampa

	if kids_certif_stampa.rowcount() > 0 then 

		kids_certif_stampa.u_set_img()
		kids_certif_stampa.u_set_test(ki_flag_stampa_di_test)
		kids_certif_stampa.Object.DataWindow.Print.DocumentName = kids_certif_stampa.u_get_nome_doc( )

		if kids_certif_stampa.ki_flag_ristampa then
			k_stampante = trim(ki_stampante[1])
		else
			k_stampante = trim(ki_stampante[2])
		end if

//--- ricava la stampante-certificato solo se Stampa vera e stampante non impostata
		if k_stampante > " " then
			if PrintSetPrinter (k_stampante) > 0 then
			else
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Errore in connessione alla stampante indicata: " + kkg.acapo + "'" + k_stampante + "' " &
				                     + kkg.acapo +" Stampa singola dell'Attestato " + string(kist_tab_certif.num_certif) + " non eseguita. " & 
											+ kkg.acapo + "Verificare la connessione alla stampante."
				kst_esito.esito = kkg_esito.no_esecuzione
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		else
			if PrintSetup() > 0 then  // scegli la stmpante se non indicata
				k_stampante = PrintGetPrinter()
			end if
		end if
		
		if k_stampante > " " then
			SetPointer(kkg.pointer_attesa)
			
	//--- stampa dw direttamente sulla stampante indicata				
			if kids_certif_stampa.print(false, false) > 0 then
				
				kst_esito.esito = kkg_esito.OK
				k_return = true
				
			else
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Errore durante la stampa singola dell'Attestato: " + string(kist_tab_certif.num_certif) & 
									+ ". Verificare la correttezza della stampante indicata: " + kkg.acapo + "'" + k_stampante + "' "
				kst_esito.esito = kkg_esito.bug
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally	

	SetPointer(kkg.pointer_default)
	
end try


return k_return 

end function

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//

if not isvalid(kiuf_certif) then kiuf_certif = create kuf_certif

return kiuf_certif.if_sicurezza(ast_open_w)
end function

public function st_esito stampa_tb_update (ref st_tab_certif kst_tab_certif) throws uo_exception;//
//====================================================================
//=== Aggiorna Data di stampa nella tabella ATTESTATI
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   vedi standard 
//===                               
//=== 
//====================================================================
boolean k_autorizza
int k_sn=0
int k_rek_ok=0
long k_id
st_tab_artr kst_tab_artr
st_esito kst_esito, kst_esito_1
kuf_artr kuf1_artr


kst_esito = kguo_exception.inizializza(this.classname())

if if_sicurezza(kkg_flag_modalita.stampa) then

	kst_tab_certif.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_certif.x_utente = kGuf_data_base.prendi_x_utente()

	kst_tab_certif.id = 0
	if kst_tab_certif.num_certif > 0 then
		kst_esito = kiuf_certif.get_id(kst_tab_certif )   			// recupera il ID dell'attestato
	end if
		
	if kst_esito.esito = kkg_esito.ok and kst_tab_certif.id > 0 then

		try

			if isnull(kst_tab_certif.id_docprod) then kst_tab_certif.id_docprod = 0
	
			update certif 
				set form_di_stampa =  :kst_tab_certif.form_di_stampa,
					 data_stampa = :kst_tab_certif.data_stampa,
					 ora_stampa = :kst_tab_certif.ora_stampa,
					id_docprod = :kst_tab_certif.id_docprod, 
					 x_datins = :kst_tab_certif.x_datins,
					 x_utente = :kst_tab_certif.x_utente
				where id = :kst_tab_certif.id  
				using sqlca;
		
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore in Aggiornamento Attestato (certif):" + trim(sqlca.SQLErrText)
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
			else
				
	//--- la data su ARTR è meglio quella di emissione		
				kiuf_certif.get_data(kst_tab_certif)
				kst_tab_artr.num_certif = kst_tab_certif.num_certif
				kst_tab_artr.data_st = kst_tab_certif.data
				kuf1_artr = create kuf_artr
				kst_tab_artr.st_tab_g_0.esegui_commit = "S" //"N" x temporaltable
				kst_esito_1 = kuf1_artr.aggiorna_data_stampa_attestato(kst_tab_artr)
				destroy kuf1_artr 
				
				if kst_esito_1.sqlcode < 0 then
					kst_esito = kst_esito_1
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				else
		
					kst_esito.esito = kkg_esito.OK
					
				end if
					
			end if
			
			if kst_tab_certif.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_magazzino.db_commit( )
			end if

		catch (uo_exception kuo_exception)
			if kst_tab_certif.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			throw kuo_exception
	
		finally
	
		end try
	end if
end if

return kst_esito

end function

public function string get_form_di_stampa_now ();//
//--- Get del nome del formd di stampa attuale
//---
//--- input: 
//--- Rit: nome del dataobject
//---
//--- Lancia EXCEPTION
//---


	if not isvalid(kids_certif_stampa) then kids_certif_stampa = create kds_certif_stampa 

return trim(kids_certif_stampa.dataobject)

end function

public function boolean set_attestato (st_tab_certif ast_tab_certif) throws uo_exception;//
//--- Get del nome del formd di stampa attuale
//---
//--- inp: st_tab_certif.num_certif, id_meca facoltatvo
//--- out:
//--- rit.: true = ok impostato
//---
//--- Lancia EXCEPTION
//---


	if not isvalid(kids_certif_stampa) then kids_certif_stampa = create kds_certif_stampa 

return kids_certif_stampa.set_attestato(ast_tab_certif)

end function

public function integer stampa_digitale_rimuove (string a_path_pdf) throws uo_exception;/*
 Cancella Attestati (pdf) precedentemente prodotti dalla cartella indicata (nome file parziale)
     inp: a_path_pdf il nome file con il percorso da cancellare 
          dal nome viebne tolto l'ID così da rimuovere solo i 'precedenti' documenti
     rit: Numero documenti rimossi
*/
int k_return
boolean k_rc
string k_path, k_filename, k_filedelete
int k_pos, k_end, k_row, k_rows
st_esito kst_esito
datastore kds_dirlist


try
	
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if not isvalid(kiuf_file_explorer) then kiuf_file_explorer = create kuf_file_explorer
	
	a_path_pdf = trim(a_path_pdf)
	
//--- Controllo se indicato un percorso
	if a_path_pdf > " " then 

//--- estrazione del solo path senza nome file
		k_path = a_path_pdf
		k_pos = 0
		do 
			k_pos = pos(k_path, kkg.path_sep, k_pos + 1)
			if k_pos > 0 then
				k_end = k_pos
			end if
		loop while k_pos > 0
		k_path = left(k_path, k_end)
		
		k_filename = mid(a_path_pdf, k_end+1 ) //get nome file
		// estrae il nome file fino a id.....pdf che dovrebbe essere il prefisso del documento precedente. 
		//      noe file es: att220407_nr245988__WO3094263_SO3014859_id265620.pdf
		k_pos = pos(k_filename, ".pdf", 1)
		if k_pos > 0 then
			k_pos += -12 // torna indietro di 12 caratteri
			if k_pos > 0 then
				k_pos = pos(k_filename, "id", k_pos)
				if k_pos > 0 then
					k_filename = left(k_filename, k_pos) + "*.pdf"
					kds_dirlist = kiuf_file_explorer.dirlist_path_search( k_path, k_filename)

					if isvalid(kds_dirlist) then
						
				//--- Cancella il PDF
						k_rows = kds_dirlist.rowcount( )
						for k_row = 1 to k_rows
				
							if trim(kds_dirlist.getitemstring(k_row, "nome")) > " " then
								k_filedelete = k_path + trim(kds_dirlist.getitemstring(k_row, "nome"))
								
								k_rc = filedelete(k_filedelete)
								if k_rc then
									
									k_return ++ // doc cancellati
									
								else
												
									kst_esito.sqlcode = 0
									kst_esito.SQLErrText = "Errore in Rimozione Attestato generato precedentemente. Nome file: ~n~r"  &
																				 + k_filedelete 
									kst_esito.esito = kkg_esito.no_esecuzione
									kguo_exception.set_esito(kst_esito)
									throw kguo_exception
						
								end if
								
							end if
							
						next
					
					end if
				end if
			end if
		end if		
	end if	

			

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kds_dirlist) then destroy kds_dirlist
	
end try
		
return k_return		

end function

public function integer stampa (ref st_tab_certif ast_tab_certif[]) throws uo_exception;/*
   Stampa ATTESTATI
		inp: 	ast_tab_certif[] array con gli attestati da stampare
		rit: numero attestati stampati
*/
int k_return
boolean k_stampato
int k_item_attestato=0, k_n_attestati_max
string k_printer 
st_esito kst_esito


try
	
	kguo_exception.inizializza(this.classname())

//--- cattura la stampante impostata
	k_printer = PrintGetPrinter( )

	ki_stampante[1] = ""
	ki_stampante[2] = ""
	
	k_n_attestati_max = upperbound(ast_tab_certif[])
	if k_n_attestati_max > 0 then	
		kist_tab_certif = ast_tab_certif[1]
	end if

	if kist_tab_certif.num_certif > 0 then		
	else
		kguo_exception.kist_esito.SQLErrText = "Nessun Attestato stampato, manca il Numero."
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
		throw kguo_exception
	end if

//--- CREA oggetto di configurazione stampa-attestato come Formato, Ristampa...
	if not isvalid(kids_certif_stampa) then kids_certif_stampa = create kds_certif_stampa 

	for k_item_attestato = 1 to k_n_attestati_max
		
		if ast_tab_certif[k_item_attestato].num_certif = 0 then
			continue  // passa al prossimo
		end if
			
		if k_return > 0 then sleep(1) //--- introduco un delayed precauzionale per evitare problemi con la generazione del PDF
			
		k_stampato = stampa_1(ast_tab_certif[k_item_attestato])  // STAMPA ATTESTATO			
		if not k_stampato then
			continue  // passa al prossimo
		end if

//--- se NON sono in ristampa registro definitivamente l'attestato in archivio 								
		if NOT kids_certif_stampa.ki_flag_ristampa then
			stampa_update()
		end if				

//--- Imposta flag per far vedere l'attestato all'ufficio DDT					
		if ki_flg_ristampa_xddt then
			kiuf_certif.set_flg_ristampa_xddt_on(ast_tab_certif[k_item_attestato])
		end if

		k_return ++
		
	end for

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if trim(k_printer) > " " then
		PrintSetPrinter(k_printer)  //--- ripristina la stampante impostata
	end if
	
end try
		
return k_return		

end function

private function boolean stampa_update () throws uo_exception;/*
 Registra definitivamente in archivio la Stampa Attestato di Trattamento
	 da lanciare dopo la routine "stampa_attestato"
		 Par. Input: kist_tab_certif   
*/
boolean k_return
st_tab_certif kst_tab_certif
st_tab_meca kst_tab_meca


kguo_exception.inizializza(this.classname())

if not isvalid(kiuf_certif) then kiuf_certif = create kuf_certif

if_sicurezza(kkg_flag_modalita.stampa) 

try 

//--- registra la data di stampa in attestato rendendolo definitivo
	kist_tab_certif.data_stampa = kguo_g.get_dataoggi( )  // kg_dataoggi
	kist_tab_certif.ora_stampa = time(kguo_g.get_datetime_current( )) // ora di stampa
	kist_tab_certif.form_di_stampa = trim(kids_certif_stampa.dataobject	) // il form di stampa definitivo	
	kst_tab_certif = kist_tab_certif
	kst_tab_certif.st_tab_g_0.esegui_commit = "S"
	stampa_tb_update(kst_tab_certif)

//--- Recupera il ID del Lotto di entrata
	if kiuf_certif.get_id_meca(kst_tab_certif) > 0 then

//--- alimenta tabella dati trattamento da Inviare a E1
		set_e1_wo_f5548014(kst_tab_certif)
//--- alimenta tabella dati trattamento (giri/padri) da Inviare a E1
		set_e1_wo_f5537001(kst_tab_certif)
		
//--- Esegue diverse operazioni post stampa Attestato ----------------------------------------------------------------------------------------------
		kst_tab_meca.id = kst_tab_certif.id_meca

		if not isvalid(kiuf_armo_inout) then kiuf_armo_inout = create kuf_armo_inout
		kiuf_armo_inout.update_post_stampa_attestato(kst_tab_meca) // chiude Quarantena, set Voci da Fatturare ecc....
		
	end if

	k_return = true
	
//--- DISTATTIVA LA REGISTRAZIONE SU TAB DOCPROD ORA SOLO STAMPA!!!					Aggiunge la riga in DOCPROD x l'esportazione digitale ----------------------------------------------------------------------------------------
//			kst_tab_certif[1].st_tab_g_0.esegui_commit = "S"
//			aggiorna_docprod(kst_tab_certif[])
	
catch (uo_exception kuo_exception)
	kuo_exception.kist_esito.sqlerrtext = "Errore in aggiornamento dati dopo la stampa dell'Attestato n. " + string(kist_tab_certif.num_certif) + " " &
											+ kkg.acapo + "Errore: " + kuo_exception.get_errtext( )
	throw kuo_exception		
	
finally
	
end try			

return k_return

end function

public function boolean u_get_flag_ristampa ();//
return kids_certif_stampa.ki_flag_ristampa

end function

on kuf_certif_print.create
call super::create
end on

on kuf_certif_print.destroy
call super::destroy
end on

event destructor;call super::destructor;
if isvalid(kids_certif_stampa) then destroy kids_certif_stampa
if isvalid(kids_certif_stampa_completa) then destroy kids_certif_stampa_completa 
if isvalid(kids_certif_stampa_allegati) then destroy kids_certif_stampa_allegati 

if isvalid(kiuf_certif) then destroy kiuf_certif
if isvalid(kiuf_armo_inout) then destroy kiuf_armo_inout
if isvalid(kiuf_file_explorer) then destroy kiuf_file_explorer
if isvalid(kiuf_armo) then destroy kiuf_armo
if isvalid(kiuf_stampe) then destroy kiuf_stampe
if isvalid(kiuf_base) then destroy kiuf_base
if isvalid(kiuf_utility) then destroy kiuf_utility 
if isvalid(kiuf_meca_reportpilota) then destroy kiuf_meca_reportpilota 
if isvalid(kiuf_pdf) then destroy kiuf_pdf 
if isvalid(kiuf_clienti) then destroy kiuf_clienti 
if isvalid(kiuf_docpath) then destroy kiuf_docpath 
end event

event constructor;call super::constructor;//
//kids_certif_stampa = create kds_certif_stampa
ki_msgerroggetto = "Attestato"

kiuf_certif = create kuf_certif
end event

