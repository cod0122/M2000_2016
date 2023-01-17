$PBExportHeader$kuf_msword.sru
forward
global type kuf_msword from nonvisualobject
end type
end forward

global type kuf_msword from nonvisualobject
end type
global kuf_msword kuf_msword

type variables
//
private oleobject kiole_word
private string ki_file_name 

end variables

forward prototypes
public subroutine _readme ()
public subroutine u_exit_word ()
public subroutine u_doc_save () throws uo_exception
public subroutine u_doc_close () throws uo_exception
public subroutine u_doc_open (string k_file) throws uo_exception
public subroutine u_doc_set_bookmakers (datastore kds_msword_bookmarks) throws uo_exception
end prototypes

public subroutine _readme ();//
//--- Gestione di un documento MS-WORD (es. .docx) 
//--- ad esempio: generazione di un doc da un file docx 'modello' con i BOOKMARK impostati 
//
end subroutine

public subroutine u_exit_word ();//
//--- Exit from Word
//

	SetPointer(kkg.pointer_attesa)

	if isvalid(kiole_word) then
	   kiole_word.quit()
	end if



end subroutine

public subroutine u_doc_save () throws uo_exception;//
//--- Close Doc Word
//
int k_rc


try
	SetPointer(kkg.pointer_attesa)

	if isvalid(kiole_word.Documents) then
		
	   k_rc = kiole_word.Documents.save
		
		if k_rc < 0 then
			
			kguo_exception.inizializza(this.classname())
			kguo_exception.kist_esito.sqlcode = k_rc
			kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
			kguo_exception.kist_esito.sqlerrtext = "Errore in registrazione del documento Word '" + ki_file_name + "'"
			throw kguo_exception

		end if
		
	end if

catch(uo_exception kuo_exception)
	throw kuo_exception

finally
	SetPointer(kkg.pointer_default)
	
end try



end subroutine

public subroutine u_doc_close () throws uo_exception;//
//--- Close Doc Word
//
int k_rc


try
	SetPointer(kkg.pointer_attesa)

	if isvalid(kiole_word.Documents) then
		
	   k_rc = kiole_word.Documents.close
		
		if k_rc < 0 then
			
			kguo_exception.inizializza(this.classname())
			kguo_exception.kist_esito.sqlcode = k_rc
			kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
			kguo_exception.kist_esito.sqlerrtext = "Errore in chiusura del documento Word '" + ki_file_name + "'"
			throw kguo_exception
			
		end if
		
	end if

catch(uo_exception kuo_exception)
	throw kuo_exception

finally
	SetPointer(kkg.pointer_default)
	
end try

end subroutine

public subroutine u_doc_open (string k_file) throws uo_exception;//
//--- Open Documento Word
//
//
int k_rc
st_esito kst_esito


try

	SetPointer(kkg.pointer_attesa)

	kst_esito = kguo_exception.inizializza(this.classname())

	if FileExists( trim(k_file) ) then

		if not isvalid(kiole_word) then kiole_word = create oleobject

		k_rc = kiole_word.ConnectToNewObject("word.application")
		if k_rc = 0 then
			
			k_rc = kiole_word.documents.open(k_file)
			if k_rc < 0 then
				kst_esito.esito = kkg_esito.ko
				kst_esito.sqlcode = k_rc
				kst_esito.SQLErrText = "Errore apertura in Word del file '" + trim(k_file) + "'"
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			
			ki_file_name = trim(k_file)
			//kiole_word.visible = true
		
		else
			kst_esito.esito = kkg_esito.ko
			kst_esito.sqlcode = k_rc
			kst_esito.SQLErrText = "Applicazione Microsoft Word non Trovata"
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		end if
	else
		kst_esito.esito = kkg_esito.ko
		kst_esito.sqlcode = k_rc
		kst_esito.SQLErrText = "File non presente o aperto da altro utente."
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally 
	SetPointer(kkg.pointer_default)
	
end try


end subroutine

public subroutine u_doc_set_bookmakers (datastore kds_msword_bookmarks) throws uo_exception;//
//--- Popola i 'BOOKMAKER' impostati nel Doc Word
//--- input: datastore ds_msword_bookmarks
//
int k_rc
int k_row, k_rows


try
	SetPointer(kkg.pointer_attesa)

	if isvalid(kiole_word.Documents) then
		k_rows = kds_msword_bookmarks.rowcount()
		for k_row = 1 to k_rows
			if trim(kds_msword_bookmarks.getitemstring(k_row, "bookmark_name"))	> " " then
		
				k_rc = kiole_word.ActiveDocument.Bookmarks.item(trim(kds_msword_bookmarks.getitemstring(k_row, "bookmark_value"))).Select
				
				if k_rc < 0 then
					kguo_exception.inizializza(this.classname())
					kguo_exception.kist_esito.sqlcode = k_rc
					kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
					kguo_exception.kist_esito.sqlerrtext = "Errore nel documento Word '" + ki_file_name &
							+ "' in ricerca del bookmark '" + kds_msword_bookmarks.getitemstring(k_row, "bookmark_name") &
							+ "' (valore '" + kds_msword_bookmarks.getitemstring(k_row, "bookmark_value") + "')"
					throw kguo_exception
				end if
				
				k_rc = kiole_word.Selection.typetext(trim(kds_msword_bookmarks.getitemstring(k_row, "bookmark_value")))
				if k_rc < 0 then
					kguo_exception.inizializza(this.classname())
					kguo_exception.kist_esito.sqlcode = k_rc
					kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
					kguo_exception.kist_esito.sqlerrtext = "Errore nel documento Word '" + ki_file_name &
							+ "' in impostazione del bookmark '" + kds_msword_bookmarks.getitemstring(k_row, "bookmark_name") &
							+ "' del valore '" + trim(kds_msword_bookmarks.getitemstring(k_row, "bookmark_value")) + "'"
					throw kguo_exception
				end if
				
			end if
		end for
	end if

catch(uo_exception kuo_exception)
	throw kuo_exception

finally
	SetPointer(kkg.pointer_default)
	
end try

end subroutine

on kuf_msword.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_msword.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//
	if isvalid(kiole_word) then 
		kiole_word.disconnectobject()
		destroy kiole_word
	end if

end event

