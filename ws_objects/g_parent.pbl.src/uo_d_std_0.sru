$PBExportHeader$uo_d_std_0.sru
forward
global type uo_d_std_0 from datawindow
end type
end forward

global type uo_d_std_0 from datawindow
integer width = 686
integer height = 400
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type
global uo_d_std_0 uo_d_std_0

type variables
//--- variabile gestione x errori DB
public:
st_esito kist_esito
public string ki_flag_modalita = ""  // Operazione a cui e' sottoposta la dw (x default è Visualizzazione)
private boolean ki_flag_mantieni_colore = false  // true= mantiene il colore della colonna in protezione/sprotezione
protected string ki_column_background_before_active[2]     // need to background focus column 
end variables

forward prototypes
public function string u_get_evaluate (string a_field, string a_field_describe)
public function string u_get_evaluate_protect (integer a_field_n)
protected subroutine u_set_color_column_on_cursor (string a_col_name, boolean a_remake)
private function st_proteggi u_proteggi_set_st_proteggi (character k_operazione)
public subroutine u_proteggi_sproteggi_dw ()
protected function string u_proteggi_dw_get_modify (character k_operazione, integer k_id_campo, string a_modify)
public subroutine u_proteggi_dw (character k_operazione, string k_txt_campo)
public subroutine u_proteggi_dw (character k_operazione, integer k_id_campo)
public subroutine u_proteggi_sproteggi_dw_no_protect ()
public subroutine u_proteggi_sproteggi_dw (string a_modalità)
public subroutine u_proteggi_sproteggi_dw (string a_modalità, boolean a_mantieni_colore)
end prototypes

public function string u_get_evaluate (string a_field, string a_field_describe);/*
   torna il valore dopo si un EXPRESSION
*/

string ls_value, ls_eval
long ll_row

ll_row = this.GetRow()
ls_value = this.describe(a_field + "." + a_field_describe)

IF NOT IsNumber(ls_value) THEN   

	if ll_row > 0 then
	// Get the expression following the tab (~t)   
		ls_value = Right(ls_value, Len(ls_value) - Pos(ls_value, "~t"))   
	
	// Build string for Describe. Include a leading   
	// quote to match the trailing quote that remains
		ls_eval = "Evaluate(~"" + ls_value + ", " + String(ll_row) + ")"   

		ls_value = this.Describe(ls_eval)
		
		IF NOT IsNumber(ls_value) THEN   
			ls_value = "0" //"!"
		end if
		
	else
		
		ls_value = "0" //"!"
		
	end if

END IF

return ls_value

end function

public function string u_get_evaluate_protect (integer a_field_n);string ls_protect, ls_eval
long ll_row

ll_row = this.GetRow()
ls_protect = this.describe("#" + trim(string(a_field_n)) + ".Protect")

IF NOT IsNumber(ls_protect) THEN   

	if ll_row > 0 then
	// Get the expression following the tab (~t)   
		ls_protect = Right(ls_protect, Len(ls_protect) - Pos(ls_protect, "~t"))   
	
	// Build string for Describe. Include a leading   
	// quote to match the trailing quote that remains
		ls_eval = "Evaluate(~"" + ls_protect + ", " + String(ll_row) + ")"   

		ls_protect = this.Describe(ls_eval)
		
	else
		
		ls_protect = "!" //"!"
		
	end if

END IF

return ls_protect

end function

protected subroutine u_set_color_column_on_cursor (string a_col_name, boolean a_remake);/*
 usa il backgrond color di default per segnalare il cursore sul campo
      Da chiamare dal event itemfocuschanged di un dw
      Inp: a_col_name = nome colonna su cui si trova il cursore
		     a_remake = TRUE rifa la colonna come Attiva 
*/
string k_rc
string k_style, k_modify


	if a_remake then
		if a_col_name > " " then
		else
			if ki_column_background_before_active[1] > " " then
				a_col_name = ki_column_background_before_active[1]
			end if
		end if
		ki_column_background_before_active[2] = ""
		ki_column_background_before_active[1] = ""
	else
		if ki_column_background_before_active[1] = a_col_name then
			return
		end if
	end if

//--- fa solo se ci sono le condizioni altrimenti via!
//	if this.rowcount() = 0 or this.Describe("DataWindow.ReadOnly") = "yes" or (this.ki_flag_modalita <> kkg_flag_modalita.modifica and this.ki_flag_modalita <> kkg_flag_modalita.inserimento) then
	if this.Describe("DataWindow.ReadOnly") = "yes" or (this.ki_flag_modalita <> kkg_flag_modalita.modifica and this.ki_flag_modalita <> kkg_flag_modalita.inserimento) then
		return 
	end if

//--- fa solo se ci sono le condizioni altrimenti via!
//	if this.Object.DataWindow.Processing <> kki_tipo_processing_form then
//		return 
//	end if

//--- Riristino del colore di sfondo originale della colonna precedente
	if ki_column_background_before_active[1] > " " and ki_column_background_before_active[1] <> a_col_name then 
		if this.Describe("DataWindow.ReadOnly") = "yes" then
			k_modify = ki_column_background_before_active[1] + ".Background.Color=" + kkg_colore.campo_disattivo + " "
		else
			k_modify = ki_column_background_before_active[1] + ".Background.Color=" + ki_column_background_before_active[2] + " "
		end if
	end if

	if this.Describe("DataWindow.ReadOnly") = "yes" then
	else
	
		if a_col_name > " " then
			if this.Describe(a_col_name + ".TabSequence") > "0" and this.Describe("Evaluate("+a_col_name + ".Protect"+")") <> "1" then
					
	//--- Salva colore di sfondo originale
				if ki_column_background_before_active[1] <> a_col_name then
					ki_column_background_before_active[1] = a_col_name
					ki_column_background_before_active[2] = u_get_evaluate( a_col_name, "Background.Color")
				end if
			
				k_modify += a_col_name + ".Background.Mode='0' " + a_col_name + ".Background.Color='" + ki_column_background_before_active[2] &
								+ "~t IF ( getrow() = currentRow()," + kkg_colore.INPUT_FIELD + "," + ki_column_background_before_active[2] + ")'"   
				
				if k_modify > " " then
					k_rc = this.modify(k_modify)
					k_modify = ""
				end if	
				
				k_style = trim(this.Describe(a_col_name  + ".Edit.Style"))
				if k_style = "edit" then
				//--- ripristina autoselect se impostato, ma solo se EDIT altrimenti blocca il riempimento come nel dropdowncalendar
					k_rc = this.describe(a_col_name + ".Edit.AutoSelect")
					if k_rc = 'yes' or k_rc = "?" then
						this.SelectText(1, Len(this.GetText()))
					end if
				end if
			end if
		end if
	end if

	if k_modify > " " then
		k_rc = this.modify(k_modify)
	end if
end subroutine

private function st_proteggi u_proteggi_set_st_proteggi (character k_operazione);//---------------------------------------------------------------------------------
//---
//--- Protegge/Sprotegge un campo della dw
//---
//--- parametri di input:
//---    k_operazione se:
//          1=proteggi dw;
//          3=proteggi senza modificare il colore nella dw;
//          5=proteggi senza modificare il Protect dw;
//          0=sproteggi dw; 
//          2=S-proteggi senza modificare il colore nella dw;
//          4=S-proteggi senza modificare il Protect dw;
//--- Out: st_proteggi con impostati i campi
//---------------------------------------------------------------------------------
st_proteggi kst_proteggi


//--- protezione campi per impedire la modifica
	if k_operazione = "1" or k_operazione = "5" then  //proteggi
		kst_proteggi.color_background=string(KKG_COLORE.campo_disattivo) //rgb(192,192,192))
		kst_proteggi.color_text=string(KKG_COLORE.campo_disattivo_text) //rgb(192,192,192))
	else   // sproteggi
		if k_operazione = "0" or k_operazione = "4" then  //sproteggi
			kst_proteggi.color_background=string(KKG_COLORE.CAMPO_ATTIVO) //rgb(255,255,255))
			kst_proteggi.color_text=string(KKG_COLORE.campo_attivo_text) //rgb(192,192,192))
		end if
	end if

//--- protezione campi per impedire la modifica
	if k_operazione = "1" or k_operazione = "3" or k_operazione = "5" then  //proteggi
		kst_proteggi.protect = "1"
		kst_proteggi.visible="0"
	else
		if k_operazione = "0" or k_operazione = "2" or k_operazione = "4" then  //sproteggi
			kst_proteggi.protect = "0"
			kst_proteggi.visible="1"
		else
			kst_proteggi.protect = "1"
		end if
	end if
		
return kst_proteggi
end function

public subroutine u_proteggi_sproteggi_dw ();//
//--- protegge o sproteggi campi del form per i campi con Tab-order > 0
//--- Inpu: impostare nel datawindow la proprietà ki_flag_modalita
//---
int k_ctr, k_colcount
string k_tabsequence, k_name, k_modify, k_rcx, k_operazione_proteggi, k_operazione_sproteggi


//--- definisce l'operazione in caso di manetenimento del colore
if ki_flag_mantieni_colore then
	k_operazione_proteggi = "3"    
	k_operazione_sproteggi = "2"
else
	k_operazione_proteggi = "1"
	k_operazione_sproteggi = "0"
end if			

choose case this.ki_flag_modalita
		
	case kkg_flag_modalita.visualizzazione &
			,kkg_flag_modalita.cancellazione 
		k_modify = u_proteggi_dw_get_modify(k_operazione_proteggi, 0, "") 	//--- protezione di tutto

	case kkg_flag_modalita.inserimento &
			,kkg_flag_modalita.modifica
		k_colcount = integer(this.Describe("DataWindow.Column.Count"))

		for k_ctr = 1 to k_colcount 

			k_name = this.Describe("#" + trim(string(k_ctr,"###")) + ".name")
			if k_name = "?" or k_name = "!" then
				
			else

				k_tabsequence = trim(this.Describe(k_name + ".TabSequence"))
	
				if k_tabsequence > "0" then
					k_modify = u_proteggi_dw_get_modify(k_operazione_sproteggi, k_ctr, k_modify) 	//--- Sprotezione del campo
				else
					k_modify = u_proteggi_dw_get_modify(k_operazione_proteggi, k_ctr, k_modify) 	//--- Protezione del campo
				end if
				
			end if
			
		next
		
end choose

if k_modify > " " then
	k_rcx = this.Modify(k_modify)
	this.setredraw(true)
	k_rcx = ""
end if

u_set_color_column_on_cursor("", true)  // Reimposta il colore di sfondo della colonna (forza se lo era già)
							

end subroutine

protected function string u_proteggi_dw_get_modify (character k_operazione, integer k_id_campo, string a_modify);/*
 Protegge/Sprotegge campi della dw

 Out: stringa da applicare con MODIFY del dw
 Inp:
    k_operazione se:
          1=proteggi dw;
          3=proteggi senza modificare il colore nella dw;
          5=proteggi senza modificare il Protect dw;
          0=sproteggi dw; 
          2=S-proteggi senza modificare il colore nella dw;
          4=S-proteggi senza modificare il Protect dw;
 
   k_id_campo se 0=tutta la dw; >0 solo il numero campo indicato
	
	a_modify stringa con i valori MODIFY da aggiungere a questa
	
*/
int k_rc
string k_style, k_type, k_num_colonne, k_campo, k_name, k_x
int k_ctr, k_TabSequence, k_num_colonne_nr
string k_rcx //, k_bgkc 
string k_modify
st_proteggi kst_proteggi


	if a_modify > " " then
		
		k_modify = a_modify + " "
		
	else
//--- cose da fare solo la prima volta		
		if k_id_campo = 0 and (k_operazione = "1" or k_operazione = "5") then   // protegge tutta la dw
			k_modify = "DataWindow.ReadOnly=yes "
		else
			k_modify = "DataWindow.ReadOnly=no "
		end if
	end if

//--- imposta i campi Colore, Protetto ....
	kst_proteggi = u_proteggi_set_st_proteggi(k_operazione)

	if k_id_campo > 0 then
		// FACCIO solo 1 campo
		k_ctr = k_id_campo
		k_num_colonne_nr = k_id_campo

	else
		// FACCIO TUTTA LA DW
		k_ctr=1
		k_num_colonne = this.Object.DataWindow.Column.Count
		if isnumber(k_num_colonne) then
			k_num_colonne_nr = integer(k_num_colonne)
		else
			k_num_colonne_nr = 99
		end if
		
	end if

	do 

		k_campo = trim(string(k_ctr,"###"))

		k_x = lower(trim(this.Describe("#" + k_campo + ".x"))) // inutile se è un campo non a video
		if k_x = "!" or k_x = "?" then
			
		else
			k_name = this.Describe("#" + k_campo + ".Name")
			
			k_TabSequence=integer(this.Describe(k_name + ".TabSequence"))
			if k_TabSequence > 0 then
				
				k_type = lower(trim(this.Describe("#" + k_campo + ".Type")))
					
				k_style = trim(this.Describe(k_name  + ".Edit.Style"))
				if k_style = "checkbox" or k_style = "radiobuttons" then
					if k_operazione <> "2" and k_operazione <> "3" then  //2 o 3 fai senza mod il colore
						k_modify += k_name +".color='" + kst_proteggi.color_text + "' " 
					end if
					
				else
					if k_operazione <> "2" and k_operazione <> "3" then  //2 o 3 fai senza mod il colore
					
						k_modify += k_name + ".Background.Mode='0' " &
 											+ k_name +".Background.Color='" + kst_proteggi.color_background + "' "  &
				           			   + k_name +".color='" + kst_proteggi.color_text + "' " 
							
						if k_type = "column" then
							k_rcx = trim(this.Describe(k_name  + ".Background.Transparency"))
							if k_rcx <> "!" and k_rcx <> "?" and k_rcx <> "0" then
								k_modify += k_name +".Background.Transparency=1" + " "  //imposta OPACO (100=trasparente)
							end if
						end if
						
					end if
					
				end if
				
			end if

			if k_operazione <> "4" and k_operazione <> "5" then  //4 o 5 fai senza mod il Protect
				if k_type = "column" then
					k_modify += k_name + ".Protect='"+trim(kst_proteggi.protect)+"'" + " "
				end if
			end if
			
		end if
		
		//k_rcx=k_dw.Modify("#" + k_campo + ".Protect='"+trim(kst_proteggi.protect)+"'")
		k_ctr = k_ctr + 1 

	loop while k_ctr <= k_num_colonne_nr and k_id_campo = 0


return k_modify


end function

public subroutine u_proteggi_dw (character k_operazione, string k_txt_campo);/*

 meglio usare: u_proteggi_sproteggi_dw e questa solo per le particolarità

 Protegge/Sprotegge campi della dw

 Out: stringa da applicare con MODIFY del dw
 Inp:
    k_operazione se:
          1=proteggi dw;
          3=proteggi senza modificare il colore nella dw;
          5=proteggi senza modificare il Protect dw;
          0=sproteggi dw; 
          2=S-proteggi senza modificare il colore nella dw;
          4=S-proteggi senza modificare il Protect dw;
 
   k_txt_campo = "nome_campo" solo il campo indicato se non è una colonna viene nascosto (visible=0)
	
*/
int k_rc
string k_id_campox
int k_id_campo


if trim(k_txt_campo) > " " then

	k_id_campox = trim(this.Describe( trim(k_txt_campo) + ".ID"))
	if IsNumber (k_id_campox) then
		k_id_campo = integer(k_id_campox)

		u_proteggi_dw(k_operazione, k_id_campo)
	end if 
	
else
	u_proteggi_dw(k_operazione, 0)
end if

end subroutine

public subroutine u_proteggi_dw (character k_operazione, integer k_id_campo);/*

 meglio usare: u_proteggi_sproteggi_dw e questa solo per le particolarità

 Protegge/Sprotegge campi della dw

 Out: stringa da applicare con MODIFY del dw
 Inp:
    k_operazione se:
          1=proteggi dw;
          3=proteggi senza modificare il colore nella dw;
          5=proteggi senza modificare il Protect dw;
          0=sproteggi dw; 
          2=S-proteggi senza modificare il colore nella dw;
          4=S-proteggi senza modificare il Protect dw;
 
   k_id_campo se 0=tutta la dw; >0 solo il numero campo indicato
	
*/
string k_rcx 
string k_modify


	k_modify = u_proteggi_dw_get_modify(k_operazione, k_id_campo, "")

	if k_modify > " " then
		k_rcx = this.Modify(k_modify)
		k_rcx = ""
	end if



end subroutine

public subroutine u_proteggi_sproteggi_dw_no_protect ();//
//--- protegge o sproteggi campi del form per i campi con Tab-order > 0
//---          ma non imposta il Protect
//--- Inpu: nel datawindow la proprietà ki_flag_modalita
//---
int k_ctr, k_colcount
string k_tabsequence, k_name, k_modify, k_rcx, k_protect


choose case this.ki_flag_modalita
		
	case kkg_flag_modalita.visualizzazione &
			,kkg_flag_modalita.cancellazione 
		k_modify = u_proteggi_dw_get_modify("5", 0, "") 	//--- protezione di tutto

	case kkg_flag_modalita.inserimento &
			,kkg_flag_modalita.modifica
		k_colcount = integer(this.Describe("DataWindow.Column.Count"))

		for k_ctr = 1 to k_colcount 

//--- estrae Describe("<Columnname>.TabSequence")
			k_name = this.Describe("#" + trim(string(k_ctr,"###")) + ".name")
			if k_name = "?" or k_name = "!" then
			else
				
				k_protect = u_get_evaluate_protect(k_ctr)

				if k_protect = "0" then
					k_tabsequence = trim(this.Describe(k_name + ".TabSequence"))
	
					if k_tabsequence <> "?" and k_tabsequence <> "!" and k_tabsequence > "0" then
						k_modify = u_proteggi_dw_get_modify("4", k_ctr, k_modify) 	//--- Sprotezione del campo
					else
						k_modify = u_proteggi_dw_get_modify("5", k_ctr, k_modify) 	//--- Protezione del campo
					end if
				else
					k_modify = u_proteggi_dw_get_modify("5", k_ctr, k_modify) 	//--- Protezione del campo
				end if
				
			end if
		
		next

	//	u_set_color_column_dw()   // imposta il colore del testo nelle colonne	

end choose

if k_modify > " " then
	k_rcx = this.Modify(k_modify)
	k_rcx = ""
end if

end subroutine

public subroutine u_proteggi_sproteggi_dw (string a_modalità);	//
	this.ki_flag_modalita = a_modalità
	
	u_proteggi_sproteggi_dw( )
end subroutine

public subroutine u_proteggi_sproteggi_dw (string a_modalità, boolean a_mantieni_colore);	//
	this.ki_flag_modalita = a_modalità
	this.ki_flag_mantieni_colore = a_mantieni_colore
	
	u_proteggi_sproteggi_dw( )
end subroutine

on uo_d_std_0.create
end on

on uo_d_std_0.destroy
end on

event getfocus;//
if this.getcolumnname() > " " then

	u_set_color_column_on_cursor(this.getcolumnname(), false)  // imposta colore di sfondo della colonna
	
end if

end event

event itemfocuschanged;//
u_set_color_column_on_cursor(dwo.name, false)  // imposta colore di sfondo della colonna

end event

