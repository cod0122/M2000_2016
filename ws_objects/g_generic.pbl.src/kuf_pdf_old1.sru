﻿$PBExportHeader$kuf_pdf_old1.sru
forward
global type kuf_pdf_old1 from nonvisualobject
end type
end forward

global type kuf_pdf_old1 from nonvisualobject
end type
global kuf_pdf_old1 kuf_pdf_old1

type prototypes
//
//FUNCTION int fi_pdfUtils_merge ( string input1, string input2, string output ) LIBRARY "PDFUtils.dll"
end prototypes

type variables
//
private string ki_stampa_pdf[]
private int ki_stampa_pdf_idx

end variables

forward prototypes
public subroutine u_inizializza ()
public function integer u_print_pdf () throws uo_exception
private function boolean u_print_esegui (string a_file) throws uo_exception
public function integer u_add_file (string a_path_file)
end prototypes

public subroutine u_inizializza ();//
string k_stampa_pdf_vuota[]

//--- riporta il path nella directory di base (es. c:\at_m2000)
kGuf_data_base.setta_path_default ()

ki_stampa_pdf_idx = 0
ki_stampa_pdf[] = k_stampa_pdf_vuota[]


end subroutine

public function integer u_print_pdf () throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Esegue la Stampa dei pdf indicati nell'array  instance:  ki_stampa_pdf[]
//--- 
//--- Input: 
//--- out: 
//--- Rit: numero di documenti stampati
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
int k_return 
int k_nr_doc, k_ind, k_nr_doc_printed


try

	kguo_exception.inizializza()
	kguo_exception.kist_esito.nome_oggetto = this.classname()

	if ki_stampa_pdf_idx > upperbound(ki_stampa_pdf) then
		k_nr_doc = upperbound(ki_stampa_pdf)  // Mooolto strano questa sforamento della tabella!!!
		kguo_exception.kist_esito.esito = kkg_esito.ko
		kguo_exception.kist_esito.SQLErrText = "Stampa PDF, indice interno " + string(ki_stampa_pdf_idx) + " stranamente maggiore della tabella " + string(k_nr_doc) + " !!! Non blocco l'esecuzione."
	else
		k_nr_doc = ki_stampa_pdf_idx
	end if
			
		
	for k_ind = 1 to k_nr_doc
		try
			if ki_stampa_pdf[k_ind] > " " then
				if fileExists(ki_stampa_pdf[k_ind]) then
									//if k_ind > 1 then sleep(2)
					if this.u_print_esegui(ki_stampa_pdf[k_ind]) then
						k_nr_doc_printed ++
					else
//--- non blocca l'esecuzione ma segnala nel log		
						kguo_exception.kist_esito.esito = kkg_esito.ko
						kguo_exception.kist_esito.sqlerrtext = "Stampa del file '" + ki_stampa_pdf[k_ind] + "' non effettuata,~n~r" & 
																+ "verificare se il file è corretto o presente." 
					end if
				else
//--- non blocca l'esecuzione ma segnala nel log		
					kguo_exception.kist_esito.esito = kkg_esito.ko
					kguo_exception.kist_esito.sqlerrtext = "File '" + ki_stampa_pdf[k_ind] + "' non trovato, stampa non effettuata. " 
				end if
			end if
		catch (uo_exception kuo_exception)
//--- non blocca l'esecuzione ma segnala nel log		
			kguo_exception.kist_esito = kuo_exception.kist_esito
		end try

//--- 20201109: TEST UFOUFO DEBUG: POI SARA' DA TOGLIERE
		if kguo_exception.kist_esito.esito = kkg_esito.ok then
			kguo_exception.kist_esito.sqlerrtext = "TUTTO OK Stampa del file PDF: '" + ki_stampa_pdf[k_ind] + "' " 
			//kguo_exception.scrivi_log( )
		end if
		
	end for

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
//kuf_utility kuf1_utility
kuf_file_run kuf1_file_run


try

	//kuf1_utility = create kuf_utility 
	kuf1_file_run = create kuf_file_run
	
	//k_return = kuf1_utility.u_print_file(a_file)
	k_return = kuf1_file_run.u_shellprint(a_file)
	
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

on kuf_pdf_old1.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_pdf_old1.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

