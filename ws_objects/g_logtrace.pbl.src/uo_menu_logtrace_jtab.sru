$PBExportHeader$uo_menu_logtrace_jtab.sru
forward
global type uo_menu_logtrace_jtab from uo_ds_std_1
end type
end forward

global type uo_menu_logtrace_jtab from uo_ds_std_1
string dataobject = "ds_menu_logtrace_jtab"
end type
global uo_menu_logtrace_jtab uo_menu_logtrace_jtab

type variables
private uo_ds_std_1 kids_menu_logtrace

end variables

forward prototypes
public function boolean u_type_id_if_numeric ()
private function string u_import_jtab (string a_id_menu_window)
public function string u_set_jtab (string a_id_menu_window)
end prototypes

public function boolean u_type_id_if_numeric ();/*
 Verifica il valore della colonna TYPE_ID se NUMERO
 rit: TRUE dw con un id numerico
*/

if kids_menu_logtrace.rowcount( ) > 0 then
	if kids_menu_logtrace.getitemstring(1, "type_id") = "N" then
		return true
	end if
end if

return false
end function

private function string u_import_jtab (string a_id_menu_window);/*
 Importa i dati dalla colonna Json JTAB della tabella menu_logtrace
 inp: a_id_menu_window = codice da estrarre da menu_logtrace
 ret: stringa con i dati JSON 
 */
string k_return
int k_rc

if not isvalid(kids_menu_logtrace) then 
	kids_menu_logtrace = create uo_ds_std_1
	kids_menu_logtrace.dataobject = "ds_menu_logtrace"
	kids_menu_logtrace.settransobject(kguo_sqlca_db_magazzino)
end if

if a_id_menu_window > " " then
	k_rc = kids_menu_logtrace.retrieve(a_id_menu_window)
	if k_rc < 0 then
		kguo_exception.kist_esito = kids_menu_logtrace.kist_esito
		kguo_exception.kist_esito.sqlerrtext = "Errore in lettura tabella MENU_LOGTRACE pcon il codice: " + a_id_menu_window + " " + kkg.acapo + kguo_exception.kist_esito.sqlerrtext
		kguo_exception.scrivi_log( )
	else
		if k_rc > 0 then
			k_return = kids_menu_logtrace.getitemstring(1, "jtab")
		end if
	end if
end if

return k_return
end function

public function string u_set_jtab (string a_id_menu_window);/*
 Popola i dati dalla colonna Json JTAB della tabella menu_logtrace nel DS spacchettandoli
 inp: a_id_menu_window = codice da estrarre da menu_logtrace
 ret: errore (cod+descr): se vuoto OK!
                     0 -- When all of the data in the JSON string is null or the JSON string only contains data for DataWindowChild.
							1 -- General error.
							2 -- No row is supplied or the startrow value supplied is greater than the number of rows in the JSON data.
							3 -- Invalid argument.
							4 -- Invalid JSON.
							5 -- JSON format error.
							6 -- Unsupported DataWindow presentation style for import.
							7 -- Error resolving DataWindow nesting.
							8 -- Unsupported mapping-method value.
 */
string k_json, k_error
int k_rc

//this.retrieve( )
//k_json = this.exportjson( )

kguo_exception.inizializza(this.classname())

if a_id_menu_window > " " then
	
	k_json = u_import_jtab(a_id_menu_window)
	
	k_rc = this.importjson( k_json, k_error )
	if k_error > " " then
		choose case k_rc
			case 0 
				k_error += kkg.acapo + "0When all of the data in the JSON string is null or the JSON string only contains data for DataWindowChild."
			case 1 
				k_error += kkg.acapo + "1General error."
			case 2 
				k_error += kkg.acapo + "2No row is supplied or the startrow value supplied is greater than the number of rows in the JSON data."
			case 3 
				k_error += kkg.acapo + "3Invalid argument."
			case 4 
				k_error += kkg.acapo + "4Invalid JSON."
			case 5 
				k_error += kkg.acapo + "5JSON format error."
			case 6 
				k_error += kkg.acapo + "6Unsupported DataWindow presentation style for import."
			case 7 
				k_error += kkg.acapo + "7Error resolving DataWindow nesting."
			case 8 
				k_error += kkg.acapo + "8Unsupported mapping-method value."
		end choose

		kguo_exception.kist_esito.esito = kkg_esito.ko
		kguo_exception.kist_esito.sqlerrtext = "Errore in importazione dati JSON dopo lettura tabella MENU_LOGTRACE con il codice: " + a_id_menu_window + " " + kkg.acapo + k_error
		kguo_exception.scrivi_log( )
		
	end if
end if

return k_error
end function

on uo_menu_logtrace_jtab.create
call super::create
end on

on uo_menu_logtrace_jtab.destroy
call super::destroy
end on

event destructor;call super::destructor;//
if isvalid(kids_menu_logtrace) then destroy kids_menu_logtrace 

end event

