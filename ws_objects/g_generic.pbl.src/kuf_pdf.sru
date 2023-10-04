$PBExportHeader$kuf_pdf.sru
forward
global type kuf_pdf from nonvisualobject
end type
end forward

global type kuf_pdf from nonvisualobject
end type
global kuf_pdf kuf_pdf

type prototypes
//
//FUNCTION int fi_pdfUtils_merge ( string input1, string input2, string output ) LIBRARY "PDFUtils.dll"
end prototypes

type variables
//
private string ki_stampa_pdf[]
private int ki_stampa_pdf_idx
private PDFDocument kiPDFDocument

end variables

forward prototypes
public subroutine u_inizializza ()
public function integer u_print_pdf () throws uo_exception
private function boolean u_print_esegui (string a_file) throws uo_exception
public function integer u_add_file (string a_path_file)
private function string get_pdf_err_descr (integer a_error)
end prototypes

public subroutine u_inizializza ();//
string k_stampa_pdf_vuota[]

//--- riporta il path nella directory di base (es. c:\at_m2000)
kGuf_data_base.setta_path_default ()

ki_stampa_pdf_idx = 0
ki_stampa_pdf[] = k_stampa_pdf_vuota[]

if isvalid(kiPDFDocument) then destroy kiPDFDocument

kiPDFDocument = create PDFDocument  // nuovo documento altrimenti li somma
end subroutine

public function integer u_print_pdf () throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Esegue la Stampa dei pdf indicati nell'array:  ki_stampa_pdf[]
//--- 
//--- Input: 
//--- out: 
//--- Rit: numero di documenti stampati
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
int k_return 
int k_nr_doc, k_ind, k_nr_doc_printed, k_ind1
int k_err26_doc[], k_err26_idx
long k_rc
string k_pdf_name



try

	kguo_exception.inizializza(this.classname())

	if ki_stampa_pdf_idx > upperbound(ki_stampa_pdf) then
		k_nr_doc = upperbound(ki_stampa_pdf)  // Mooolto strano questa sforamento della tabella!!!
		kguo_exception.kist_esito.esito = kkg_esito.ko
		kguo_exception.kist_esito.SQLErrText = "Stampa PDF, indice interno " + string(ki_stampa_pdf_idx) + " stranamente maggiore della tabella " + string(k_nr_doc) + " !!! Non blocco l'esecuzione."
	else
		k_nr_doc = ki_stampa_pdf_idx
	end if
			
		
	if k_nr_doc > 0 then
		for k_ind = 1 to k_nr_doc
			try
				if ki_stampa_pdf[k_ind] > " " then
					
					if fileExists(ki_stampa_pdf[k_ind]) then

						//--- aggiunge il file 
						k_rc = kiPDFDocument.importpdf(ki_stampa_pdf[k_ind])
						if k_rc = 1 then
							k_nr_doc_printed ++
						else

//--- Il documento potrebbe essere Protetto quindi prova a stamparlo da solo alla fine
							if k_rc = -26 then
								k_err26_idx++
								k_err26_doc[k_err26_idx] = k_ind
							else
//--- Errore in importazione del file PDF
								kguo_exception.kist_esito.esito = kkg_esito.ko
								kguo_exception.kist_esito.sqlerrtext = "Errore in generazione di un unico documento PDF da stampare. " &
																	+ kkg.acapo + "File '" + ki_stampa_pdf[k_ind] + "', " &
																	+ kkg.acapo + "Errore: " + get_pdf_err_descr(k_rc) & 
																	+ kkg.acapo + "Verificare se il file è corretto o presente." 
							end if											
						end if
						
					else
	//--- non blocca l'esecuzione ma segnala nel log		
						kguo_exception.kist_esito.esito = kkg_esito.ko
						kguo_exception.kist_esito.sqlerrtext = "Stampa preparata senza il documento " + kkg.acapo + ki_stampa_pdf[k_ind] + kkg.acapo + "perchè non trovato. " 
					end if
				end if
			catch (uo_exception kuo_exception)
	//--- non blocca l'esecuzione ma segnala nel log		
				kguo_exception.kist_esito = kuo_exception.kist_esito
			end try
	
//	//--- 20201109: TEST UFOUFO DEBUG: POI SARA' DA TOGLIERE
//			if kguo_exception.kist_esito.esito = kkg_esito.ok then
//				kguo_exception.kist_esito.sqlerrtext = "TUTTO OK Stampa del file PDF: '" + ki_stampa_pdf[k_ind] + "' " 
//				//kguo_exception.scrivi_log( )
//			end if
			
		end for
		
//--- esegue la stampa
		k_pdf_name = kguo_path.get_temp( )+ kkg.path_sep + "f" + string(kguo_g.get_datetime_current( ),"yymmdd_hhmmss") + ".pdf"
		k_rc = kiPDFDocument.save(k_pdf_name) // salva in un file temporaneo e poi lancia la stampa
		if this.u_print_esegui(k_pdf_name) then
			
//--- Se ce ne sono prova ad eseguire la stampa dei documenti con errore -26 (forse protetti)			
			if k_err26_idx > 0 then
				for k_ind = 1 to k_err26_idx
					k_ind1 = k_err26_doc[k_ind]
					if this.u_print_esegui(ki_stampa_pdf[k_ind1]) then // in stampa x conto suo del doc che aveva dato err -26
						k_nr_doc_printed ++
					else
						kguo_exception.kist_esito.esito = kkg_esito.ko
						kguo_exception.kist_esito.sqlerrtext = "Tentativo di stampare separatamente il documento " &
													+ kkg.acapo + ki_stampa_pdf[k_ind] + " " &
													+ kkg.acapo + "fallita. " & 
													+ kkg.acapo + "Verificare se il file è corretto o presente." 
					end if
				next
			end if
			
		else
//--- non blocca l'esecuzione ma segnala nel log		
			kguo_exception.kist_esito.esito = kkg_esito.ko
			kguo_exception.kist_esito.sqlerrtext = "Stampa del documento " &
													+ kkg.acapo + ki_stampa_pdf[k_ind] + " " &
													+ kkg.acapo + "non effettuata, errore " + string(k_rc) & 
													+ kkg.acapo + "Verificare se il file è corretto o presente." 
		end if
	
	else
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
 		kguo_exception.kist_esito.sqlerrtext = "Lanciata la richiesta ma nessun documento PDF da stampare! "
	end if

//--- Segnala solo nel log		
	if kguo_exception.kist_esito.esito <> kkg_esito.ok then
		kguo_exception.scrivi_log( )
	end if

	k_return = k_nr_doc_printed

catch (uo_exception kuo1_exception)
		throw kuo1_exception
	
finally
	
	
end try

return k_return
end function

private function boolean u_print_esegui (string a_file) throws uo_exception;//
//---  Stampa un file con l'appilicazione del sistema
//
boolean k_return = false
long k_rcn
kuf_file_run kuf1_file_run

try
	kguo_exception.inizializza(this.classname())

	kuf1_file_run = create kuf_file_run
	try
		
		k_return = kuf1_file_run.u_shellprint(a_file)
		
	catch (uo_exception kuo1_exception)
		if fileExists("PDFtoPrinter.exe") then
			k_rcn = kuf1_file_run.of_run("PDFtoPrinter.exe " + '"' + a_file + '" /s', Minimized!)  // tenta con il progammino
			if k_rcn = -1 or k_rcn = 258 then
				kguo_exception.kist_esito.esito = kkg_esito.ko
				kguo_exception.kist_esito.sqlerrtext = "Processo di stampa del file " + kkg.acapo + a_file + " " + kkg.acapo + "in errore!" &
				               + kkg.acapo + "Applicazione di stampa PDF non trovata dal tuo Sistema Operativo."
				throw kguo_exception
			else
				k_return = true
			end if
		else
			throw kuo1_exception
		end if
		
	end try
	
catch (uo_exception kuo_exception)
		kuo_exception.scrivi_log( )
		throw kuo_exception
	
finally
//	if isvalid(kuf1_utility) then destroy kuf1_utility
	if isvalid(kuf1_file_run) then destroy kuf1_file_run
	
end try

return k_return	

end function

public function integer u_add_file (string a_path_file);//
ki_stampa_pdf_idx ++
ki_stampa_pdf[ki_stampa_pdf_idx] = a_path_file

return ki_stampa_pdf_idx
end function

private function string get_pdf_err_descr (integer a_error);//
choose case a_error
	case -1 
	    return trim("Common error.")  
	case -2 
	    return trim("Invalid object.")  
	case -3 
	    return trim("Invalid document object.")  
	case -4 
	    return trim("Invalid page object.")  
	case -5 
	    return trim("Invalid text object.")  
	case -6
	    return trim("Invalid multi-line text object.") 
	case -7  
	    return trim("Invalid rich text object. ")
	case -8  
	    return trim("Invalid image object. ")
	case -9  
	    return trim("Invalid font object. ")
	case -10 
	    return trim("Invalid layer object. ")
	case -11 
	    return trim("Invalid layer container. ")
	case -12 
	    return trim("Invalid layer assembly object. ")
	case -13 
	    return trim("Invalid index. ")
	case -14 
	    return trim("Invalid argument. ")
	case -15 
	    return trim("Invalid object to be imported. ")
	case -16 
	    return trim("Invalid starting index. ")
	case -17 
	    return trim("Invalid index scope. ")
	case -18 
	    return trim("Invalid object name. ")
	case -19 
	    return trim("Invalid file name. ")
	case -20 
	    return trim("Invalid font name. ")
	case -21 
	    return trim("Invalid visible object. ")
	case -22 
	    return trim("Invalid password; the main password and user password cannot be null and cannot be the same.") 
	case -23 
	    return trim("Invalid document property object. ")
	case -24 
	    return trim("Invalid handler. ")
	case -25 
	    return trim("Abnormal operation. ")
	case -26 
	    return trim("Failed to open the PDF document. ")
	case -27 
	    return trim("Failed to create the PDF document. ")
	case -28 
	    return trim("Failed to create the multi-line text. ")
	case -29 
	    return trim("Failed to load the font. ")
	case -30 
	    return trim("Failed to load the image. ")
	case -31 
	    return trim("Failed to locate the object in the page.") 
	case -32 
	    return trim("Object does not exist. ")
	case -33 
	    return trim("Object already has an owner. ")
	case -34 
	    return trim("Read-only object cannot be modified. ")
	case -35 
	    return trim("Failed to perform the XML serialization.") 
	case -36 
	    return trim("Object not applicable to the current document format.") 
	case -37 
	    return trim("Width not specified. ")
	case -38 
	    return trim("Failed to initialize the dummy builder. ")
	case -39 
	    return trim("Unsupported operation. ")
	case -40 
	    return trim("Invalid folder name. ")
	case -41 
	    return trim("Failed to instantiate the object. ")
	case -42 
	    return trim("Failed to write in the file. ")
	case -43 
	    return trim("Failed to load the file. ")
	case -44 
	    return trim("Invalid file path. ")
	case -45 
	    return trim("Protocol not recognized. ")
	case -46 
	    return trim("Watermark incompatible with the attachment.")
end choose

return ""
end function

on kuf_pdf.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_pdf.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//
if isvalid(kiPDFDocument) then destroy kiPDFDocument

end event

