﻿$PBExportHeader$kuf_certif_e1_pdf.sru
forward
global type kuf_certif_e1_pdf from kuf_parent
end type
end forward

global type kuf_certif_e1_pdf from kuf_parent
end type
global kuf_certif_e1_pdf kuf_certif_e1_pdf

type variables
//
constant string kki_certif_e1_pdf_folder_ok = "prepared"
constant string kki_certif_e1_pdf_folder_anomalie = "faults"
private datastore kids_file_pdf_orig 

end variables

forward prototypes
public function st_esito u_batch_run () throws uo_exception
private function string get_e1_certif_saved_dir () throws uo_exception
private function st_esito u_extract_certif_from_e1_file () throws uo_exception
private function integer u_copy_pdf_to_emailfolder_exec () throws uo_exception
private function st_esito u_copy_to_emailfolder () throws uo_exception
private function integer u_delete_pdf_from_folder () throws uo_exception
private function integer u_set_list_file_pdf () throws uo_exception
private function integer u_copy_pdf_to_attestatifolder_exec () throws uo_exception
private function st_esito u_copy_to_attestatifolder () throws uo_exception
end prototypes

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
int k_ctr, k_del, k_n_file_pdf
st_esito kst_esito, kst_esito1, kst_esito2


try 

	kst_esito = kguo_exception.inizializza(this.classname( ))

//--- Estrae Certificati E1 dal file pdf di stampa 
	kst_esito = this.u_extract_certif_from_e1_file( )

//--- Popola il datastore con i file PDF appena estratti
	k_n_file_pdf = u_set_list_file_pdf()
	
	if k_n_file_pdf > 0 then
		
//--- Copia Certificati E1 nella cartella da Inviare via email
		kst_esito1 = this.u_copy_to_emailfolder( )
		kst_esito.sqlerrtext += "; " + kst_esito1.sqlerrtext
		
//--- Copia Certificati E1 nella cartella degli Attestati di M2000
		kst_esito2 = this.u_copy_to_attestatifolder( )
		kst_esito.sqlerrtext += "; " + kst_esito2.sqlerrtext

//--- Cancella Certificati E1 dalla cartella di origine
		k_del = this.u_delete_pdf_from_folder( )
	
		kst_esito.esito = kkg_esito.ok
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

private function string get_e1_certif_saved_dir () throws uo_exception;//
//--- Legge il path di salvataggio delle stampe in pdf dei Certificati E1
//--- Ret: path
//
string k_return
string k_esito
kuf_base kuf1_base
st_tab_base kst_tab_base
st_esito kst_esito 


kst_esito = kguo_exception.inizializza(this.classname( ))

try
	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base( "e1_certif_saved_dir")
	if left(k_esito,1) <> "0" then
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.SQLErrText = "Errore lettura in Proprietà della 'Cartella di salvataggio Certificati di E1'; " + mid(k_esito,2)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		kst_tab_base.e1_certif_saved_dir = trim(mid(k_esito,2))
	end if
	
	if kst_tab_base.e1_certif_saved_dir > " " then
		k_return = kst_tab_base.e1_certif_saved_dir
	else
		kst_esito.esito = kkg_esito.no_esecuzione  
		kst_esito.SQLErrText = "'Cartella di salvataggio Certificati di E1' assenete in Proprietà, operazione interrotta."
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally
	if isvalid(kuf1_base) then destroy(kuf1_base) 
	
	
end try

return k_return
end function

private function st_esito u_extract_certif_from_e1_file () throws uo_exception;//---
//--- Lancio programma python di Estrazione Certif E1 dai file pdf  
//---
int k_rc
string k_path_filepdf, k_cmd, k_path_pgm
kuf_file_run kuf1_file_run
kuf_file_explorer kuf1_file_explorer
st_esito kst_esito


try  

	kst_esito = kguo_exception.inizializza(this.classname( ))

	kuf1_file_run = create kuf_file_run

	k_path_filepdf = get_e1_certif_saved_dir( )  // recupera il path di dove sono i file pdf con i Certif E1

	kuf1_file_explorer = create kuf_file_explorer
	if kuf1_file_explorer.u_get_n_list_file(k_path_filepdf, "*.pdf") > 0 then // verfica se ci sono PDF da scorporare

		k_path_pgm = kguo_path.get_app_extract_certif_E1_pdf()
		if not FileExists(k_path_pgm) then
			kst_esito.esito = kkg_esito.ko
			kst_esito.SQLErrText = "Estrazione Certificati E1 dai file PDF non eseguita, programma estrattore non trovato in: " + k_path_pgm 
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if		
		
	//--- Estrazione Certificati E1 dalle stampe su file PD
		k_cmd = k_path_pgm + " -s ~"" + k_path_filepdf + "~""
	//	k_rc = run(k_cmd, Minimized!)
	
		k_rc = kuf1_file_run.of_run(k_cmd, Minimized!)
	
	//--- check return code
		CHOOSE CASE k_rc
			CASE kuf1_file_run.WAIT_COMPLETE
			//case k_rc > 0	
				kst_esito.SQLErrText = "Estrazione Certificati E1 dai file PDF terminata correttamente." &
											+ " Comando eseguito: '" + k_cmd + "'"
			CASE kuf1_file_run.WAIT_TIMEOUT
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.SQLErrText = "Time Out. Estrazione Certificati E1 dai file PDF dalla cartella '" + k_path_filepdf &
											+ "', interrotta, perchè oltre il tempo prestabilito." &
											+ " Comando eseguito: '" + k_cmd + "'"
			CASE ELSE
				kst_esito.esito = kkg_esito.ko
				kst_esito.SQLErrText = "Estrazione Certificati E1 dai file PDF terminata con codice errore: " + String(k_rc) &
										  + ". Comando eseguito: '" + k_cmd + "'"
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
		END CHOOSE

	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_file_run) then destroy kuf1_file_run
	
end try


return kst_esito
end function

private function integer u_copy_pdf_to_emailfolder_exec () throws uo_exception;//
//--- Copia i PDF (Certif di E1) nella cartella dei Certificati da inviare in email
//--- Ret: n. file spostati
//
int k_return
string k_esito
string k_folder_pdf_src, k_folder_pdf_dst, k_file_pdf, k_wo, k_path, k_folder_pdf_dst_anomalie
int k_riga, k_righe, k_rc_fileCopy
st_tab_meca kst_tab_meca
st_tab_certif kst_tab_certif
st_tab_certif_email kst_tab_certif_email
st_esito kst_esito
kuf_certif_print kuf1_certif_print
kuf_certif kuf1_certif
kuf_certif_email kuf1_certif_email
kuf_armo kuf1_armo
kuf_file_explorer kuf1_file_explorer


try
	
	k_path = get_e1_certif_saved_dir( )  // recupera il path di dove sono i file pdf con i Certif E1
	k_folder_pdf_dst_anomalie = k_path + kkg.path_sep + kki_certif_e1_pdf_folder_anomalie + kkg.path_sep

	kuf1_armo = create kuf_armo
	kuf1_certif = create kuf_certif
	kuf1_certif_print = create kuf_certif_print
	kuf1_certif_email = create kuf_certif_email
	kuf1_file_explorer = create kuf_file_explorer

	k_righe = kids_file_pdf_orig.rowcount( )
	for k_riga = 1 to k_righe
		
		k_folder_pdf_src = trim(kids_file_pdf_orig.getitemstring(k_riga, "path")) // path
		k_file_pdf = trim(kids_file_pdf_orig.getitemstring(k_riga, "nome")) // WOnnnnn.pdf
		k_wo = mid(k_file_pdf, 3, len(k_file_pdf) - 6) // rimuove WO e .pdf
		if isnumber(k_wo) then
			kst_tab_meca.e1doco = long(k_wo) // get del WO
			kuf1_armo.get_id_meca_da_e1doco(kst_tab_meca)
		else
			kst_tab_meca.e1doco = 0
			kst_tab_meca.id = 0
		end if
		if kst_tab_meca.id > 0 then
			kst_tab_certif.id_meca = kst_tab_meca.id
			k_folder_pdf_dst = kuf1_certif_print.get_path_email(kst_tab_certif)
			
			k_return ++
		else
			k_folder_pdf_dst = k_folder_pdf_dst_anomalie
				
			kguo_exception.inizializza(this.classname( ))
			kguo_exception.kist_esito.esito = kkg_esito.dati_wrn
			kguo_exception.kist_esito.sqlerrtext = "Routine '" + trim(this.classname( )) + "' in ERRORE, Certificato E1 copiato nella cartella delle Anomalie: " &
															+ k_folder_pdf_dst &
															+ ". Non trovalo il n. id Lotto dal WO n. '" + string(kst_tab_meca.e1doco) + "' in archivio di M2000!"
			kguo_exception.scrivi_log( )
		end if
		kuf1_file_explorer.u_directory_create(k_folder_pdf_dst)  // crea la cartella se non esiste
			
		k_rc_fileCopy = filecopy(k_folder_pdf_src + kkg.path_sep + k_file_pdf, k_folder_pdf_dst + k_file_pdf, true) // sposta i pdf in anomalie folder
		if k_rc_fileCopy <> 1 then
			kguo_exception.inizializza(this.classname( ))
			kguo_exception.kist_esito.esito = kkg_esito.ko
			kguo_exception.kist_esito.sqlerrtext = "Routine '" + trim(this.classname( )) + "' in ERRORE durante copia Certificato E1 da '" &
															+ k_folder_pdf_src + kkg.path_sep + k_file_pdf + "' a '" &
															+ k_folder_pdf_dst + k_file_pdf &
															+ "'. "
			choose case k_rc_fileCopy
				case -1
					kguo_exception.kist_esito.sqlerrtext += "Dovuto alla cartella sorgente (accesso occupato o non autorizzato)!" 
				case -2
					kguo_exception.kist_esito.sqlerrtext += "Dovuto alla cartella di destinazione (accesso occupato o non autorizzato)!" 
//				case -3
//					kguo_exception.kist_esito.sqlerrtext += "Il file pdf del Certificato è stato copiato ma non è stato rimosso della cartella di lavoro ('" + k_folder_pdf_src + kkg.path_sep + k_file_pdf + "')."
			end choose
			throw kguo_exception
		end if
		
		if kst_tab_meca.id > 0 then
			//--- get id_certificato
			kst_tab_certif.id_meca = kst_tab_meca.id
			kuf1_certif.get_id_da_id_meca(kst_tab_certif)
			if kst_tab_certif.id > 0 then
				kst_tab_certif_email.id_certif = kst_tab_certif.id
				kst_tab_certif_email.certif_e1_e1doco = kst_tab_meca.e1doco
				kuf1_certif_email.set_certif_e1_e1doco(kst_tab_certif_email)   // Aggiorna in certif_email il WO
			else
				kguo_exception.inizializza(this.classname())
				kguo_exception.kist_esito.esito = kkg_esito.ko
				kguo_exception.kist_esito.sqlerrtext = "Routine '" + trim(this.classname( )) + "' in ERRORE, non è stato trovato ID dell'Attestato di M2000 " & 
															+ "dal id Lotto (ASN): " + string(kst_tab_certif.id_meca) &
															+ ". WO: " + string(kst_tab_meca.e1doco) + "!"
				kguo_exception.scrivi_log( )
			end if
		end if
		
	next
	
//--- per errore grave interrompe elaborazione e segnala	
	if kguo_exception.kist_esito.esito = kkg_esito.ko then
		throw kguo_exception
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally
	if isvalid(kuf1_armo) then destroy(kuf1_armo)
	if isvalid(kuf1_certif) then destroy(kuf1_certif)
	if isvalid(kuf1_certif_print) then destroy(kuf1_certif_print)
	if isvalid(kuf1_certif_email) then destroy(kuf1_certif_email)
	if isvalid(kuf1_file_explorer) then destroy(kuf1_file_explorer)
	
	
end try

return k_return
end function

private function st_esito u_copy_to_emailfolder () throws uo_exception;//---
//--- Copia i Certif estratti nel path di invio delle email
//---
int k_ctr
st_esito kst_esito


try 

	kst_esito = kguo_exception.inizializza(this.classname( ))

//--- copia Certif pdf in email folder
	k_ctr = this.u_copy_pdf_to_emailfolder_exec( )
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Operazione conclusa correttamente. " &
									+ "Sono stati copiati " + string(k_ctr) + " 'Certificati E1' (pdf) nelle cartelle degli Allegati da inviare via email." 
	else
		kst_esito.SQLErrText = "Operazione conclusa. Nessuno nuovo 'Certificato E1' da inviare via email come allegato."
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

private function integer u_delete_pdf_from_folder () throws uo_exception;//
//--- Cancella i file PDF (Certif di E1) dalla cartella
//--- Ret: n. file cancellati
//
int k_return
string k_folder_pdf_src, k_file_pdf
int k_riga, k_righe


try

	k_righe = kids_file_pdf_orig.rowcount( )
	for k_riga = 1 to k_righe
		
		k_folder_pdf_src = trim(kids_file_pdf_orig.getitemstring(k_riga, "path"))
		k_file_pdf = trim(kids_file_pdf_orig.getitemstring(k_riga, "nome"))
		
		if fileDelete(k_folder_pdf_src + kkg.path_sep + k_file_pdf) then // remove pdf
			k_return ++
		end if
		
	next
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally
	
	
end try

return k_return
end function

private function integer u_set_list_file_pdf () throws uo_exception;//
//--- Popola datastore con l'elenco dei file PDF
//--- Ret: n. file trovati
//
int k_return
string k_folder_pdf_src, k_path
kuf_file_explorer kuf1_file_explorer


try
	
	k_path = get_e1_certif_saved_dir( )  // recupera il path di dove sono i file pdf con i Certif E1
	
	if k_path > " " then
		k_folder_pdf_src = k_path + kkg.path_sep + kki_certif_e1_pdf_folder_ok

		kuf1_file_explorer = create kuf_file_explorer
		if isvalid(kids_file_pdf_orig) then kids_file_pdf_orig.reset( )
		kids_file_pdf_orig = kuf1_file_explorer.dirlist_path_search(k_folder_pdf_src, "*.pdf")

		k_return = kids_file_pdf_orig.rowcount( )
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally
	if isvalid(kuf1_file_explorer) then destroy(kuf1_file_explorer)
	
	
end try

return k_return
end function

private function integer u_copy_pdf_to_attestatifolder_exec () throws uo_exception;//
//--- copia i PDF (Certif di E1) nella cartella degli Attestati di M2000
//--- Ret: n. file spostati
//
int k_return
string k_esito
string k_folder_pdf_src, k_folder_pdf_dst[], k_file_pdf, k_wo, k_path, k_folder_pdf_dst_anomalie
int k_riga, k_righe, k_rc_fileCopy
st_tab_meca kst_tab_meca
st_tab_certif kst_tab_certif
st_esito kst_esito
kuf_certif_print kuf1_certif_print
kuf_armo kuf1_armo
kuf_file_explorer kuf1_file_explorer


try
	
	kuf1_certif_print = create kuf_certif_print
	kuf1_file_explorer = create kuf_file_explorer
	kuf1_armo = create kuf_armo

	k_righe = kids_file_pdf_orig.rowcount( )
	for k_riga = 1 to k_righe
		
		k_folder_pdf_src = trim(kids_file_pdf_orig.getitemstring(k_riga, "path")) // path
		k_file_pdf = trim(kids_file_pdf_orig.getitemstring(k_riga, "nome")) // WOnnnnn.pdf
		k_wo = mid(k_file_pdf, 3, len(k_file_pdf) - 6) // rimuove WO e .pdf
		if isnumber(k_wo) then
			kst_tab_meca.e1doco = long(k_wo) // get del WO
			kuf1_armo.get_id_meca_da_e1doco(kst_tab_meca)
		else
			kst_tab_meca.e1doco = 0
			kst_tab_meca.id = 0
		end if
		if kst_tab_meca.id > 0 then
			kst_tab_certif.id_meca = kst_tab_meca.id
			k_folder_pdf_dst[] = kuf1_certif_print.get_path_doc(kst_tab_certif, false)
			
			kuf1_file_explorer.u_directory_create(k_folder_pdf_dst[1])  // crea la cartella se non esiste
			
			k_rc_fileCopy = filecopy(k_folder_pdf_src + kkg.path_sep + k_file_pdf, k_folder_pdf_dst[1] + k_file_pdf, true) // sposta i pdf in anomalie folder
			if k_rc_fileCopy = 1 then
				k_return ++
			else
				kguo_exception.inizializza( )
				kguo_exception.kist_esito.nome_oggetto = this.classname( )
				kguo_exception.kist_esito.esito = kkg_esito.ko
				kguo_exception.kist_esito.sqlerrtext = "Errore routine '" + trim(this.classname( )) + "' in copia Certificato E1 da '" &
																+ k_folder_pdf_src + kkg.path_sep + k_file_pdf + "' a '" &
																+ k_folder_pdf_dst[1] + k_file_pdf &
																+ "'. "
				choose case k_rc_fileCopy
					case -1
						kguo_exception.kist_esito.sqlerrtext += "Dovuto alla cartella sorgente (accesso occupato o non autorizzato)!" 
					case -2
						kguo_exception.kist_esito.sqlerrtext += "Dovuto alla cartella di destinazione (accesso occupato o non autorizzato)!" 
	//				case -3
	//					kguo_exception.kist_esito.sqlerrtext += "Il file pdf del Certificato è stato copiato ma non è stato rimosso della cartella di lavoro ('" + k_folder_pdf_src + kkg.path_sep + k_file_pdf + "')."
				end choose
				kguo_exception.scrivi_log( )
			end if

		end if
		
	next
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally
	if isvalid(kuf1_armo) then destroy(kuf1_armo)
	if isvalid(kuf1_certif_print) then destroy(kuf1_certif_print)
	if isvalid(kuf1_file_explorer) then destroy(kuf1_file_explorer)
	
	
end try

return k_return
end function

private function st_esito u_copy_to_attestatifolder () throws uo_exception;//---
//--- Copia i Certif estratti nel path degli altri Attestati di M2000
//---
int k_ctr
st_esito kst_esito


try 

	kst_esito = kguo_exception.inizializza(this.classname( ))

//--- copia Certif pdf 
	k_ctr = this.u_copy_pdf_to_attestatifolder_exec( )
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Operazione conclusa correttamente. " &
									+ "Sono stati copiati " + string(k_ctr) + " 'Certificati E1' (pdf) nelle cartelle di Archivio degli Attestati." 
	else
		kst_esito.SQLErrText = "Operazione conclusa. Nessuno nuovo 'Certificato E1' copiato nelle cartelle degli Attestati."
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

on kuf_certif_e1_pdf.create
call super::create
end on

on kuf_certif_e1_pdf.destroy
call super::destroy
end on

event destructor;call super::destructor;//
if isvalid(kids_file_pdf_orig) then destroy kids_file_pdf_orig

end event

