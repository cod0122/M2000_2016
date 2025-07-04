﻿$PBExportHeader$uo_d_std_1.sru
forward
global type uo_d_std_1 from uo_d_std_0
end type
end forward

shared variables

end variables

global type uo_d_std_1 from uo_d_std_0
boolean visible = false
integer width = 1344
integer height = 836
boolean enabled = false
string dataobject = "d_nulla"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
event ue_dwnkey pbm_dwnkey
event u_doppio_click ( long a_row )
event u_pigiato_enter pbm_dwnprocessenter
event rbuttonup pbm_rbuttonup
event ue_visibile ( boolean k_visibile )
event u_personalizza_dw ( )
event ue_timer pbm_timer
event type long ue_dropfromsame ( long k_droprow,  uo_d_std_1 kdw_source )
event type long ue_dropfromthis ( long k_droprow,  uo_d_std_1 kdw_source )
event ue_dragleave_post ( )
event type long ue_drop_out ( long k_droprow,  uo_d_std_1 kdw_source )
event ue_dwnmousemove pbm_dwnmousemove
event ue_lbuttondown pbm_lbuttondown
event ue_dragdrop_end ( )
event type long ue_drag_out ( long k_droprow,  uo_d_std_1 kdw_target )
event ue_aggiungi_riga ( long a_riga )
event u_constructor ( )
event u_set_powerfilter ( )
event ue_leftbuttonup pbm_dwnlbuttonup
event u_modifica_set_color ( )
event type string ue_get_display_dddw ( string a_col_name )
event u_dragdrop_mouse_pos ( )
event u_constructor_post ( )
event u_dragging ( )
end type
global uo_d_std_1 uo_d_std_1

type variables
//
//--- Riferimento a questo oggetto
protected uo_d_std_1 kidw_this

pointer kipointer_orig

//--- Icone per la dw selezionata nelle window
public string ki_icona_normale =   "Application5!"
public string ki_icona_selezionata = "UserObject5!"

//--- disattiva moment.la funz.'aggiorna' fino a che non mod.un dato
public boolean ki_disattiva_moment_cb_aggiorna = true


//--- attiva/disattiva i LINK
private kuf_link_zoom kiuf_link_zoom
public boolean ki_link_standard_sempre_possibile = false
public boolean ki_link_standard_attivi = true
public boolean ki_button_standard_attivi = true
private string ki_last_dataobject
private string ki_last_modalita
protected int ki_transparency
protected boolean ki_border
//private any ki_borderstyle //'any' non va bene

//--- attiva colore in background in Evidenza x riga aggiornata di recente
public boolean ki_colora_riga_aggiornata = true

public string ki_clicked_colname
//public string ki_SQLsyntax = " "
//public string ki_SQLErrText = " "
//public long ki_SQLdbcode = 0

public integer ki_riga_rbuttondown=0
public dwobject kidwo_1

//--- serve x evitare che siano selezionate automaticamente le righe come nell'evento rowfocuschanged
public boolean ki_attiva_standard_select_row=true
public boolean ki_d_std_1_primo_giro=false

//--- Attiva/disattiva il SORT - ordina righe se premuto campo di testata colonna
public boolean ki_d_std_1_attiva_SORT = true

//--- Attiva/disattiva il Cerca....
public boolean ki_d_std_1_attiva_CERCA = true

//--- Attiva selezione MULTIPLA delle righe
public boolean ki_select_multirows = true

//--- ultima riga selezionatatrsa
public long ki_UltRigaSel = 0

//------------------------------------------------------------------------------------------------------------------------
//--- Drag & Drop....
public boolean ki_attiva_DRAGDROP_solo_INS_MOD = true // Abilitazione DRAG&DROP come indicato solo se in INSERIMENTO e MODIFICA
public boolean ki_attiva_DRAGDROP = false // Abilitazione al DRAG&DROP
public boolean ki_attiva_DRAGDROP_self = false // Abilitazione al DRAG&DROP sulla stessa DW
public boolean ki_in_DRAG = false     // dragging in corso....
//public string ki_dragdrop_display 
private int ki_mouse_down_x = 0
private int ki_mouse_down_y = 0  
private long ki_riga_dragwithin = 0
private long ki_lbuttondown_row=0
//private string ki_dw_name_lbuttondown
private string ki_drag_colname = ""
private boolean ki_drag_scroll=false
private boolean ki_u_drag_scroll_lanciata=false
private string ki_dragicon1 = " "
private string ki_dragicon2 = " "

private boolean ki_dragging_label_created
private string ki_dragging_label_colname
private string ki_dragging_label_value
private string ki_dragging_label_height
private string ki_dragging_label_width
private uo_d_std_1 kidw_dragdrop_source
//------------------------------------------------------------------------------------------------------------------------

private long ki_clicked_row = 0
private long ki_clicked_row_sel = 0

//--- variabile gestione x errori DB
//public st_esito kist_esito

//--- tipo datawindow (Processing)
public constant string kki_tipo_processing_form="0"
public constant string kki_tipo_processing_grid="1"
public constant string kki_tipo_processing_tree="8"
public constant string kki_tipo_processing_rtf="7"
public constant string kki_tipo_processing_altro="9"
//0 – (Default) Form, group, n-up, or tabular
//1 – Grid
//2 – Label
//3 – Graph
//4 – Crosstab
//5 – Composite
//6 – OLE
//7 – RichText
//8 – TreeView
//9 – TreeView with Grid


//
public boolean ki_abilita_ddw_proposta=false
private kuf_ddw_grid kiuf_ddw_grid

//--- nome dw old x evitare di rifare il link delle immagini x lo stesso dw
private string ki_personalizza_dw_name = ""

// indica se fare 'settransobject' 
protected boolean ki_db_conn_standard = true   // 'settransobject' su 'sqlca' in automatico su dw standard
protected boolean ki_db_conn_plav = false   // 'settransobject' su db 'plav' (Interfaccia Pilota)

public boolean ki_dw_visibile_in_open_window = true   // indica se la dw è visibile subito appena aperta la window

//--- gestione filitri tipo EXCEL
n_cst_PowerFilter kin_cst_PowerFilter

private kuf_menu_popup kiuf_menu_popup

//--- dataoggi set in constuct
//private string ki_dataoggi_x

private uo_exception kiuo_exception

//private string ki_column_background_before_active[2]     // colore sfondo colonna appena prime del focus (salva nome e colore background)

end variables

forward prototypes
public function boolean u_filtra_record (string k_filtro)
private subroutine link_standard_imposta ()
public subroutine set_flag_modalita (string a_flag_modalita)
private function long u_set_immagini (string a_nomeimgdacercare)
public function boolean u_dati_modificati ()
private subroutine u_set_immagini ()
public function string u_get_tipo ()
private subroutine u_sleep (integer a_sec)
public subroutine u_menu_popup (integer a_xpos, ref integer a_ypos)
public function long u_get_band_pointer ()
private function string modifica_set_color ()
public subroutine u_fine_primo_giro ()
public function boolean u_group_ricalc ()
public function boolean u_rowscopy_form_ds (datastore kds_1)
public function boolean u_sort (readonly string a_name_header)
private function string u_sort_get_type (readonly string k_colname, string k_coltype)
private subroutine u_set_riga_new ()
public function boolean if_link_enabled ()
public subroutine u_set_column_color ()
public subroutine u_proteggi ()
public function long u_get_riga_atpointer (ref string k_nome_campo)
public function long u_getrow (long a_if_noone_row)
private subroutine u_drag_scroll (long a_row)
private subroutine u_dragging_label_destroy ()
private function string u_dragging_label_show ()
private function boolean u_if_in_dragging ()
public function long u_selectrow_onclick (readonly long a_row)
public function long u_set_ki_lbuttondown_row ()
public function long u_getselectedrows (long a_row)
public function string u_getitemstring (string a_colonna, long a_riga)
private function string link_standard_call_if (string a_nome_link, long a_riga) throws uo_exception
private function boolean link_standard_call (string a_nome_link, long a_riga) throws uo_exception
public function string u_get_ctrl_c_value ()
private function boolean u_colmodified (long al_row, string as_col, dwbuffer a_buf)
private function boolean u_colmodified (string as_col)
private function boolean u_rowmodified (long al_row, dwbuffer a_buf)
private function boolean u_rowmodified (long al_row)
private function boolean u_rowmodified ()
end prototypes

event ue_dwnkey;//
long k_riga
//string k_bands=""

//kguo_exception.kist_esito.sqlerrtext = "UE_DOWNKEY: " + string(KEY) + " - " + string(keyflags)
//kguo_exception.scrivi_log( )

//--- se tasto ESC provo l'undo
if key = KeyESCape! then
	setpointer(kkg.pointer_default)
	
//--- chiude eventuali DRAG & GDROP
	if u_if_in_dragging() then
		event ue_dragdrop_end( )
	else

//--- se tasto ESC provo l'undo
//--- Undelete
		IF this.CanUndo() THEN
			this.Undo()
		end if
	end if
	
else

	this.setredraw(false)

//--- sono in TREEVIEW ?
	if (this.Object.DataWindow.Processing = kki_tipo_processing_grid or this.Object.DataWindow.Processing = kki_tipo_processing_tree or this.Object.DataWindow.Processing = kki_tipo_processing_altro) then

		k_riga = this.GetRow()
		IF k_riga > 0 THEN
		
			IF keyflags = 1 THEN //con SHIFT
				IF key = KeyUpArrow! THEN
					if k_riga > 1 then
						if IsSelected ( k_riga - 1) then
							ki_UltRigaSel = k_riga 
							//ki_UltRigaSel = k_riga - 1
						else
							ki_UltRigaSel = k_riga - 1
						end if
						SelectRow(ki_UltRigaSel, TRUE)
					end if
				elseIF key = KeyDownArrow! THEN
					if k_riga < this.rowcount() then
						if IsSelected ( k_riga + 1 ) then
							ki_UltRigaSel = k_riga 
							//ki_UltRigaSel = k_riga + 1 
						else
							ki_UltRigaSel = k_riga + 1
						end if
						SelectRow(ki_UltRigaSel, TRUE)
					end if
				END IF
				
			ELSEIF keyflags = 2 THEN // con CTRL
				
				IF key = KeyDownArrow! THEN
					ScrollToRow(k_riga )
				END IF
				IF key = KeyUpArrow! THEN
					ScrollToRow(k_riga )
				END IF
	
			ELSEIF keyflags = 0 THEN  // solo il tasto premuto

//			k_bands=this.Describe("DataWindow.Bands") 
////--- verifica se sono sul Banda HEADER (probabile in treeeview) deseleziono tutto
//			if pos(k_bands, "header") > 1 then
//				SelectRow(0, false)	
//			end if

				IF key = KeyUpArrow! THEN
					this.selectrow( 0, false)
					IF k_riga  > 1 THEN
						ki_UltRigaSel = k_riga - 1
					else
						ki_UltRigaSel = 1
					END IF
					SelectRow(ki_UltRigaSel, TRUE)	
				ElseIF key = KeyDownArrow! THEN
					this.selectrow( 0, false)
					IF k_riga < this.RowCount() THEN
						ki_UltRigaSel = k_riga + 1
					else
						ki_UltRigaSel = this.RowCount()
					END IF
					SelectRow(ki_UltRigaSel, TRUE)	
				END IF
			
			END IF
			

		END IF
		
	end if

	this.setredraw(true)

//	if ki_UltRigaSel = 0 then
//		ki_UltRigaSel = this.getselectedrow ( 0 )
//		if ki_UltRigaSel = 0 then
//			ki_UltRigaSel = this.GetRow()
//		end if
//	end if

end if


return 0


end event

event u_doppio_click(long a_row);//
w_g_tab_3 kw_g_tab_3

if this.Object.DataWindow.Processing = kki_tipo_processing_grid then // dw tipo GRID

	setpointer(kkg.pointer_attesa)

//--- esempio di cosa fare in questa funzione
	long ll_count
	FOR ll_count = 1 to UpperBound(kguo_g.kgw_attiva.Control[])
		if TypeOf(kguo_g.kgw_attiva.Control[ll_count]) = CommandButton! then
			if classname(kguo_g.kgw_attiva.Control[ll_count]) = "cb_visualizza" then
				kguo_g.kgw_attiva.Control[ll_count].postevent(clicked!)
				exit
			end if
		end if
	NEXT

	setpointer(kkg.pointer_default)

end if
end event

event u_pigiato_enter;//
//--- trasforma l'ENTER in un TAB
//
send (Handle(this),256,9,long(0,0)) 

return 1 


end event

event rbuttonup;//
long k_riga
int k_xpos, k_ypos
string k_nome_col
//datawindow kdw
//kdw = this

	if ki_riga_rbuttondown > 0 then

		k_nome_col = getcolumnname( )

//--- seleziona la riga su cui si trova 		
		if ki_attiva_standard_select_row and not ki_d_std_1_primo_giro then
			k_riga = u_selectrow_onclick(ki_riga_rbuttondown)
		end if
		
		k_xpos = xpos + this.x  
		k_ypos = ypos + this.y 
		u_menu_popup(k_xpos, k_ypos)
			
	else
		k_xpos = xpos + this.x  
		k_ypos = ypos + this.y 
		u_menu_popup(xpos, ypos)
//		parent.dynamic event rbuttonup(flags, xpos, ypos)
//		parent.triggerevent("rbuttonup")
	end if
	
	return 1


end event

event ue_visibile(boolean k_visibile);//
//--- usato come evento "di entrata" ovvero ad esempio x rendere visible la dw e posizionarla o fare delle operazioni iniziali prima di visualizzarla
//--- vedi ad esmpio nella W_MECA_1 
//
//
//		this.visible = k_visible
	
end event

event u_personalizza_dw();//
//---- imposta i link standard se attivi e memorizza l'ultimo dataobject cliccato          
	if this.dataobject > " " and this.dataobject <> "d_nulla" and  ki_link_standard_attivi &
			and ((ki_flag_modalita <> kkg_flag_modalita.modifica and ki_flag_modalita <> KKG_FLAG_RICHIESTA.inserimento) &
				or ki_link_standard_sempre_possibile) then
		
		try
			u_set_riga_new()  // colora la riga se x_datins = dataoggi
			
			if ki_last_dataobject <> this.dataobject or ki_last_modalita <> ki_flag_modalita then //kkg_flag_modalita.modifica then
				link_standard_imposta() // imposta i link graficamente
	
				ki_last_modalita = ki_flag_modalita
				
			end if

		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
		end try
		
	end if

//--- imposta le immagini degli oggetti del dw tipo png icone ecc..
	u_set_immagini( )
	

end event

event ue_timer;//
//
//// --- diamo spazio a eventuali eventi in coda 
//Yield()
//
end event

event type long ue_dropfromsame(long k_droprow, uo_d_std_1 kdw_source);//
// Dragged da un DW che ha lo stesso Dataobject del nostro

Long		k_row=0

// ---

if isvalid(kdw_source) and ki_attiva_DRAGDROP_self then
	
	// Go Through all selected Rows And Copy Them to the destination Datawindow
	k_row = kdw_source.GetSelectedRow(k_row)
	DO
		kdw_source.RowsMove(k_row, k_row, primary!, this, k_droprow, primary!)

//--- attiva lo status del DW a modificato
		if this.ki_flag_modalita = kkg_flag_modalita.modifica &
				or this.ki_flag_modalita = kkg_flag_modalita.inserimento then
			this.setitemstatus(1, 0, Primary!, DataModified!)
		end if
//---  Fire Drop Row Event
	//		this.EVENT ue_AfterDropRow(k_droprow)
		k_row --
		k_droprow ++
		
		k_row = kdw_source.GetSelectedRow(k_row)
		
	LOOP WHILE k_row > 0
	
end if

RETURN 1
end event

event type long ue_dropfromthis(long k_droprow, uo_d_std_1 kdw_source);
// We Dragged From this... we Drop to this...

Long		l_row=0, l_selectedRows=0, l_rowSave[], l_index, l_rowCount, l_getRow, l_indexMoved
long 		l_rowMoved[], l_selectedRowsMoved[]
Long		l_subRows=0
boolean  k_moved

// ---

//Go Through all selected Rows And Move Them to the destination Datawindow (this)


l_rowCount = this.RowCount()
l_getRow = kdw_source.GetRow()
if isvalid(kdw_source) and k_droprow > 0 and l_rowCount > 1 then
//IF (l_getRow <> k_droprow OR k_droprow = l_rowCount OR k_droprow = 1) AND ki_UltRigaSel <> k_droprow  THEN
	
	// Move all Selected Rows To the Back
	l_row = kdw_source.GetSelectedRow(l_row)
	DO
		l_selectedRows ++
		l_rowSave[l_selectedRows] = l_row			
		l_row = kdw_source.GetSelectedRow(l_row)
	LOOP WHILE l_row > 0
	
	FOR l_index = UpperBound(l_rowSave[]) TO 1 STEP - 1
		k_moved = true
		kdw_source.RowsMove(l_rowSave[l_index], l_rowSave[l_index], primary!, this, l_rowCount + 1, primary!)
	NEXT
	
	FOR l_index = 1 TO UpperBound(l_rowSave[])
	// Change Move To Row.. All Rows wich was selected before have to be substracted
		IF k_droprow > l_rowSave[l_index] THEN
			l_subRows ++
		END IF
	NEXT
	
	k_dropRow -= l_subRows
		
	FOR l_index = 0 TO l_selectedRows - 1
		k_moved = true
		l_rowMoved[l_index+1] = k_dropRow + l_index
		kdw_source.RowsMove(l_rowCount, l_rowCount, primary!, this, l_rowMoved[l_index+1], primary!)
		
		l_indexMoved ++
		l_selectedRowsMoved[l_indexMoved] = l_rowMoved[l_index+1]
		// Fire Drop Row Event
//		this.EVENT ue_AfterDropRow(k_droprow + l_index)
	NEXT
	
//--- rimetto il SELECTED sulle righe spostate	
	this.selectrow( 0, false)
	//FOR l_index = 1 TO UpperBound(l_rowMoved[])
	//	l_rowMoved[l_index] = k_dropRow + l_index
	//	kdw_source.selectrow(l_rowMoved[l_index], true)
	for l_index = 1 to upperbound(l_selectedRowsMoved[])
		this.post selectrow(l_selectedRowsMoved[l_index], true)
	NEXT
	
//--- CurrentRow Should Be Dragged Row now
	ki_UltRigaSel 	= k_dropRow
	
//--- attiva lo status del DW a modificato sulla prima riga
	if k_moved then
		if this.ki_flag_modalita = kkg_flag_modalita.modifica &
					or this.ki_flag_modalita = kkg_flag_modalita.inserimento then
			this.setitemstatus(1, 0, Primary!, DataModified!)
		end if
	end if
	
END IF


RETURN 1

end event

event ue_dragleave_post();//
//--- quando supera i confini del dw in dragging
end event

event type long ue_drop_out(long k_droprow, uo_d_std_1 kdw_source);//
//--- Questo Evento serve a 'Gestire' i DROP provenienti da DW esterne
//---  dopo questa è lanciata anche la UE_DRAG_OUT nel DW sorgente
//

//--- DA PERSONALIZZARE

//
RETURN 1
end event

event ue_dwnmousemove;//
//---- Muove il mouse con il tasto left premuto allora posso attivare il DRAG&DROP
//
//long k_riga
string k_rcx
string k_value, k_colname
int k_rc


u_set_ki_lbuttondown_row( )  // imposta il ki_lbuttondown_row

//--- Attiva il Drag&Drop se ho indicato di attivarlo e sono in Modifica o Inserimento a meno che non abbia in gla che lo concede anche in Visualizzazione
if (this.ki_attiva_DRAGDROP or this.ki_attiva_DRAGDROP_self) &
			and (not ki_attiva_DRAGDROP_solo_INS_MOD &
					or (this.ki_flag_modalita = kkg_flag_modalita.inserimento or this.ki_flag_modalita = kkg_flag_modalita.modifica)) &
	and ki_lbuttondown_row > 0 then
	

//-- se sono in DRAG
	if u_if_in_dragging( ) then
		
		//k_rcx = u_dragging_label_show() 
		
	else
	
		if keydown(keyleftbutton!) then // and not keydown(keycontrol!) then
			
//--- se ho trascinato il mouse x un po' da una colonna....
//			if (Abs(PointerX() - ki_mouse_down_x) > 50) OR (Abs(PointerY() - ki_mouse_down_y) > 50) OR (PointerX() = 0) OR (PointerY() = 0) THEN  
//			if dwo.type = "column" or dwo.type = "compute" or dwo.type = "text" then

				if ki_lbuttondown_row > 0 and row > 0 then
					k_colname = trim(dwo.name)
					k_rcx = dwo.type 
					choose case k_rcx
						case "column"
						case "compute"
							k_value = trim(string(dwo.Primary[ki_lbuttondown_row]))
					end choose
				end if

	//kguo_exception.u_write_x_debug(this.classname(), "ue_dwnmousemove k_colname: " + string(k_colname)+" POINTER: " + string(abs(PointerX()))+"-"+string(ki_mouse_down_x)+","+string(Abs(PointerY()))+"-"+string(ki_mouse_down_y) )
				if ki_mouse_down_x > 0 and ki_mouse_down_y > 0 &
						and (abs(PointerX() - ki_mouse_down_x) > 100 OR Abs(PointerY() - ki_mouse_down_y) > 100) then //OR xpos = 0 OR ypos = 0 THEN  
	//				k_riga = ki_lbuttondown_row //this.getselectedrow(0) 
					if ki_lbuttondown_row > 0 then

						ki_in_DRAG = true		 
						kidw_dragdrop_source = this
						
//	TROPPO LENTO			//--- Mostra un'etichetta con un valore durante il dragging
//						ki_dragging_label_colname = k_colname
//						ki_dragging_label_height = this.describe(dwo.name + ".height")
//						ki_dragging_label_width = this.describe(dwo.name + ".width")
//						if k_value > " " then
//							ki_dragging_label_value = k_value
//						else
//							if ki_dragging_label_colname > " " then
//							else
//								ki_dragging_label_colname = trim(this.describe("#1.name"))
//							end if
//							ki_dragging_label_value = trim(string(this.object.data[ki_lbuttondown_row,integer(this.describe(ki_dragging_label_colname + ".id"))]))
//						end if
//						k_rcx = u_dragging_label_show() 
				
						if this.getselectedrow(ki_lbuttondown_row) > 0 then
	//						this.dragicon = kGuo_path.get_risorse() + "\drag2.ico"
							this.dragicon = ki_dragicon2   
						else
		//					this.dragicon = kGuo_path.get_risorse() + "\drag1.ico"
							this.dragicon = ki_dragicon1
						end if
								
						this.drag(begin!)
					end if
					
				end if
			//end if
		end if
		
	end if
end if

end event

event ue_lbuttondown;//
int k_pos
long k_row
string k_col_name, k_col_pointer
String k_band, k_row_x



if this.ki_attiva_DRAGDROP or this.ki_attiva_dragdrop_self then
	
	k_band = this.GetBandAtPointer()
	
	if left(k_band,6) = "detail" then
		
		k_col_pointer = this.GetObjectAtPointer()
		k_pos = pos(k_col_pointer, "~t")
		
		k_row_x = trim(mid(k_col_pointer, k_pos + 1))
		if isnumber(k_row_x) then 
			//ki_lbuttondown_row = long(k_row_x)
			k_row = long(k_row_x)
		end if
		//ki_dw_name_lbuttondown = this.classname( )

		if flags = 1 or keydown( keyshift! ) then  //flags = 1 left button
			if (this.Object.DataWindow.Processing = kki_tipo_processing_grid or this.Object.DataWindow.Processing = kki_tipo_processing_tree &
					or this.Object.DataWindow.Processing = kki_tipo_processing_altro) then
	
				if k_row > 0 then
					ki_mouse_down_x = PointerX() //xpos // original coordinates of pointer x fare il drag&drop 
					ki_mouse_down_y = PointerY() //ypos // original coordinates of pointer x fare il drag&drop  			
	//kguo_exception.u_write_x_debug(this.classname(), "ue_lbuttondown ki_mouse_down_y: " + string(ki_mouse_down_y))

					if not this.isselected(k_row) then
						this.selectrow ( 0, false )
						this.selectrow ( k_row, true )
						this.setrow (k_row)
					end if
				end if
			end if
		end if		
		
		ki_lbuttondown_row = k_row
		
//	else
//		ki_lbuttondown_row = 0
//		ki_dw_name_lbuttondown = ""
	end if
end if

end event

event ue_dragdrop_end();//
//	st_barcode.visible = false
	this.ki_mouse_down_x = 0
	this.ki_mouse_down_y = 0
	this.ki_lbuttondown_row = 0
	this.ki_riga_dragwithin = 0
	this.ki_in_DRAG = false		 
	this.drag(end!)
	this.ki_drag_scroll=false	
	this.dragicon = ""
	this.modify("k_dragdrop_row.Expression='0' ")
//	this.u_dragging_label_destroy()
	
//--- devo chiudere anche il drag&drop anche sul sorgente
	if isvalid(kidw_dragdrop_source) then
		if this <> kidw_dragdrop_source then
			kidw_dragdrop_source.event ue_dragdrop_end( )
		end if
	end if

end event

event type long ue_drag_out(long k_droprow, uo_d_std_1 kdw_target);//
//--- Questo Evento serve a 'Gestire' il DRAG dopo che è stato eseuito il DROP sul dw sorgente (esterno)
//---  quindi prima di ques è stato lanciatao il UE_DROP_OUT nel DW target
//

//--- DA PERSONALIZZARE

//
RETURN 1
end event

event ue_aggiungi_riga(long a_riga);//
//--- utilizzata x spostare righe da un dw ad un altro specie nello ZOOM (w_g_tab_elenco)
//
end event

event u_constructor();//
int k_rc

if this.dataobject > " " and this.dataobject <> "d_nulla" then
	if ki_db_conn_standard then
 		SetTransObject(kguo_sqlca_db_magazzino)
	elseif ki_db_conn_plav then
		try
			kguo_sqlca_db_plav.db_connetti( ) // tenta la connessione al volo
 			k_rc = SetTransObject(kguo_sqlca_db_plav)
		catch(uo_exception kuo_exception)
		end try
	end if
	ki_personalizza_dw_name = ""
	event u_personalizza_dw()
end if

end event

event u_set_powerfilter();//

kin_cst_PowerFilter.checked = NOT kin_cst_PowerFilter.checked
kin_cst_PowerFilter.of_setdw(this)
if NOT kin_cst_PowerFilter.checked then
	kin_cst_PowerFilter.u_resetoriginalfilter()  // reset per poi ripristinare l'elenco
end if
kin_cst_PowerFilter.event ue_clicked()

end event

event ue_leftbuttonup;//
//--- rilascio del mouse nel dw
//
if isvalid(kin_cst_PowerFilter) then
	if kin_cst_PowerFilter.checked then
		kin_cst_PowerFilter.event post ue_buttonclicked(dwo.type,dwo.name)
	end if
end if

//
//long k_row, k_row_new
int k_pos
string k_col_name, k_col_pointer
String k_band //, k_row_x

k_band = this.GetBandAtPointer()

if left(k_band,6) = "detail" then

//	k_col_pointer = this.GetObjectAtPointer()
	//k_pos = pos(k_col_pointer, "~t")

	if (this.Object.DataWindow.Processing = kki_tipo_processing_grid or this.Object.DataWindow.Processing = kki_tipo_processing_tree &
				or this.Object.DataWindow.Processing = kki_tipo_processing_altro) then

//		k_row_x = trim(mid(k_col_pointer, k_pos + 1))
//		if isnumber(k_row_x) then k_row = long(k_row_x)

		//if row > 0 and ki_lbuttondown_row = row and not this.ki_in_DRAG and ki_dw_name_lbuttondown = this.classname( ) &
		//if row > 0 and not this.ki_in_DRAG and ki_attiva_standard_select_row then
		if row > 0 and not u_if_in_dragging( ) and ki_attiva_standard_select_row then

		
	//--- ctrl+click	per seleziona/deseleziona riga ma non devo essere il DRAG&DROP
			if keydown( keycontrol! ) then
				
			//	k_row = this.getrow()
				
				if this.isselected( row) then
					this.selectrow ( row, false )
				else
					this.selectrow ( row, true )
				end if
				
			elseIF not KeyDown ( KeyShift! ) then
	
	//--- se button up e riga sel allora deseleziono tutto tranne questa
				if this.isselected(row) then
					this.setredraw(false)
					this.selectrow ( 0, false )
					this.selectrow ( row, true )
					this.setredraw(true)
				end if
				
			end if		
		end if		
	end if		
	
	ki_mouse_down_x = 0
	ki_mouse_down_y = 0

end if	

if u_if_in_dragging( ) then
	this.event ue_dragdrop_end()
end if



end event

event u_modifica_set_color();//
//---- imposta colori background colonne x modifica / inserimento      

		try
			modifica_set_color( )
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
		end try
		
	

end event

event type string ue_get_display_dddw(string a_col_name);//
//--- Get del valore 'DISPLAY' di una colonna DDDW 
//
string k_return 

if this.getrow() > 0 then
	k_return = trim( &
					this.Describe &
     				 ("Evaluate('LookupDisplay(" + trim(a_col_name) + ")', " + String(this.getrow()) + ")") )
//     				 ("Evaluate('LookupDisplay(task)', " + String(this.getrow()) + ")") )
end if						
if k_return > " " then
	return k_return
else
	return ""
end if

end event

event u_constructor_post();//
ki_transparency = this.transparency
ki_border = this.border
//ki_borderstyle = this.borderstyle
end event

public function boolean u_filtra_record (string k_filtro);//
//--- filtra le righe cosi':
//---             k_filtro = la codizione di filtro
//
boolean k_return
long k_ctr, k_rc



	this.setredraw(false)
	
	k_rc=this.setfilter("") // rimuovo vecchi filtri

	if this.setfilter(k_filtro) < 1 then
		k_return = false
	else
		k_rc=this.filter()
		
		if k_rc > 0 then
			k_return = u_group_ricalc()
		end if
		
	end if
	
	this.setredraw(true)
	this.setfocus()
		
		
return k_return

end function

private subroutine link_standard_imposta ();//-----------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- link_standard_imposta
//--- Imposta nel DW i "Link Standard" ovvero mette il campo in blu con "manina" come cursore
//---
//-----------------------------------------------------------------------------------------------------------------------------------------------

//--- Se NON sono in modalita' Inserimento/Modifica oppure ho indicato LINK SEMPRE POSSIBILE 
	if if_link_enabled( ) then
			
		kiuf_link_zoom.link_standard_imposta_p(kidw_this) // configura graficamente i campi per il LINK

	end if
	kiuf_link_zoom.link_standard_imposta_hyperlink(kidw_this) // mette il puntatore a manina sui LINK

end subroutine

public subroutine set_flag_modalita (string a_flag_modalita);//

ki_flag_modalita = a_flag_modalita

end subroutine

private function long u_set_immagini (string a_nomeimgdacercare);//
string k_dw_syntax = "", k_filename="", k_nome_oggetto="", k_path, k_str_modify=""
long k_len_max=0, k_oggettiTrovati=0, k_ctr, k_ctr1, k_ctr2, k_ctr3, k_ctr4


//--- controlla se ci sono delle immagini da fare vedere----------------------------------------
//--- estrazione dell'intero contenuto del dw
	k_dw_syntax = this.describe("DataWindow.Syntax")
	k_len_max = len(k_dw_syntax)
//--- estrazione dei nomi dei txt
	k_path =  kguo_path.get_risorse( ) //+ kkg.path_sep
	k_ctr = 1
	k_ctr = pos(k_dw_syntax, "(name=", k_ctr)    //cerca stringa 'name' ovvero tutti gli oggetti nel dw 
	
	DO WHILE k_ctr > 0 and k_oggettiTrovati < 100
		k_ctr1 = k_ctr + 6
		if k_ctr1 < k_len_max then
		//	k_ctr1 = k_ctr1 + 6
			k_ctr2 = pos(k_dw_syntax, a_nomeImgDaCercare, k_ctr1)
			if k_ctr2 > 0 then
				k_ctr = k_ctr2
				k_ctr2 = pos(k_dw_syntax, "_", k_ctr2)  + 1  // piglia la pos di "_" che segue txt
				k_ctr4 = pos(k_dw_syntax, "~"", k_ctr2) - k_ctr2   // piglia len del "p_img_" es. "p_img_lente" se carattere doppi apici
				k_ctr3 = pos(k_dw_syntax, " ", k_ctr2) - k_ctr2   // piglia len del "p_img_" es. "p_img_lente"
				if k_ctr3 > k_ctr4 then k_ctr3 = k_ctr4  // se c'e' prima doppi apici allora sistema la posizione
				k_nome_oggetto = mid(k_dw_syntax, k_ctr2, k_ctr3 ) // carica il nome del file jpg o bmp o ecc....
//--- recupera il nome dell'immagine
				k_filename = trim(this.Describe('txt_' + k_nome_oggetto + ".Text"))
				if k_filename > " " and k_filename <> "!" and k_filename <> "?"  then
//--- visualizza l'immagine
					if left(k_filename,1) = kkg.path_sep then // se c'e' una BARRA a inzio del nome allora add il PATH altrimenti se nome della risorsa 'secca' nel file PBR
						k_str_modify += (k_nome_oggetto + ".Filename='" + k_path + k_filename + "'") + " "
					else
						k_str_modify += (k_nome_oggetto + ".Filename='" + k_filename + "'") + " "
					end if
				end if
				k_oggettiTrovati++
			else
				exit
			end if
			
		end if
		k_ctr++
		k_ctr = pos(k_dw_syntax, "(name=", k_ctr)
	LOOP	
	
//--- se ho trovato qls applica le modifiche tutte insieme	
	if k_oggettiTrovati > 0 then 
		this.Modify(k_str_modify)
	end if
	
return k_oggettiTrovati

end function

public function boolean u_dati_modificati ();//
//--- Compiute modifice nel dw?
//--- true=si; false=no
//
boolean k_return = false	
string k_rc

	
	if this.enabled then

		this.accepttext()
		
		if this.visible then
			k_rc = this.describe("DataWindow.Name") 
			if k_rc > " " and k_rc <> "!" then
				if isvalid(this.Object.DataWindow) then
					if this.Object.DataWindow.Table.UpdateTable <> " " then
						 //if this.getnextmodified(0, primary!) > 0 or this.getnextmodified(0, delete!) > 0 or this.ModifiedCount ( ) > 0 or this.deletedcount() > 0 then
							k_return = u_rowmodified()
						//end if
					end if
				end if
			end if
		end if
	end if
	
return k_return
	
end function

private subroutine u_set_immagini ();//
string k_nomeImgDaCercare = ""


//--- imposta le icone e grafiche png ecc... negli oggetti del dw
	if ki_personalizza_dw_name <> this.dataobject then
		ki_personalizza_dw_name = this.dataobject  // x evitare di impostare più volte lo stesso oggetto

		k_nomeImgDaCercare = "txt_p_img"   // uso oboleto
		u_set_immagini(k_nomeImgDaCercare)
		
		k_nomeImgDaCercare = "txt_p_"   // uso oboleto
		u_set_immagini(k_nomeImgDaCercare)

		k_nomeImgDaCercare = "txt_img_"  //--- nuovo standard: usare txt_img_..... che può essere p o b o quello che si vuole
		u_set_immagini(k_nomeImgDaCercare)
		
	end if	

end subroutine

public function string u_get_tipo ();//---
//--- torna il tipo di datawindow catturato da Processing 
//---

choose case this.Object.DataWindow.Processing
		
	case "0"
		return kki_tipo_processing_form		
		
	case "1"
		return kki_tipo_processing_grid		
		
	case "8" 
	case "9" 
		return kki_tipo_processing_tree
		
	case "7"	// Rich Text
		return kki_tipo_processing_rtf	

	case else
		return kki_tipo_processing_altro
		
end choose

end function

private subroutine u_sleep (integer a_sec);//
sleep (a_sec)

end subroutine

public subroutine u_menu_popup (integer a_xpos, ref integer a_ypos);//

 	
	if not isvalid(kiuf_menu_popup) then kiuf_menu_popup = create kuf_menu_popup
	
	kiuf_menu_popup.u_popup(a_xpos, a_ypos)
	

end subroutine

public function long u_get_band_pointer ();//
//--- tenta di trovare il numero di riga (utile ad esempio in un datawindow TREEVIEW)
//
long ll_row
long ll_pos
string ls_band
string ls_bandatpointer
 
 
ls_bandatpointer = this.GetBandAtPointer()
ll_pos = Pos ( ls_bandatpointer , "~t" )
if ll_pos > 0 then
    ls_band = Left(ls_bandatpointer , ll_pos - 1)
    ll_row =  long (Mid ( ls_bandatpointer, ll_pos + 1 ) )
end if


return ll_row


end function

private function string modifica_set_color ();//
//--- Mette le colonne da modificare in bianco e le altre in grigio
//--- usato in operazioni di INSERIMENTO/MODIFICA
//
//---
long k_num_colonne_nr, k_ctr=1, k_pos
string k_ret, k_style
string k_num_colonne, k_colore, k_str, k_str_modify=""



k_ret= this.Describe("DataWindow.Column.Count")
if k_ret = "!" or k_ret = "?" then
else
	k_num_colonne = this.Object.DataWindow.Column.Count
	if isnumber(k_num_colonne) then
		k_num_colonne_nr = integer(k_num_colonne)
	else
		k_num_colonne_nr = 99
	end if
	
	do 
		k_style = trim(this.Describe("#" + string(k_ctr,"#") + ".Edit.Style"))
		if k_style <> "!" and k_style <> "?" and k_style <> "checkbox" and k_style <> "radiobuttons" then //and k_style <> "dddw" and k_style <> "ddlb" then
		
			if this.Describe("#" + string(k_ctr,"#")+".TabSequence") > "0" and this.Describe("#" + string(k_ctr,"#") + ".Protect") <> "1" then
				k_colore = string(KKG_COLORE.bianco)
			else
				k_colore = string(KKG_COLORE.campo_disattivo)
			end if
			
			k_str = "#" + trim(string(k_ctr,"###"))+".background.color= '" + k_colore + "'" //~""
						
			k_str_modify += k_str + " "
		end if
		
		k_ctr ++

	loop while k_ctr <= k_num_colonne_nr 
		
//--- se ho trovato qls applica le modifiche tutte insieme	
	if k_str_modify > " " then 
		k_ret = this.Modify(k_str_modify)
	end if
end if

return k_ret

end function

public subroutine u_fine_primo_giro ();//
ki_d_std_1_primo_giro = false

end subroutine

public function boolean u_group_ricalc ();//
//--- filtra le righe cosi':
//---             k_filtro = la codizione di filtro
//
boolean k_return
long k_ctr, k_rc


	k_rc=this.GroupCalc()
	this.setfocus()
	if k_rc > 0 then
		k_return = true
	else
		k_return = false
	end if

		
return k_return

end function

public function boolean u_rowscopy_form_ds (datastore kds_1);//
//--- Copia le righe da un Datastore
//---             
//
boolean k_return
long k_ctr, k_rc



	this.setredraw(false)
	
	k_rc = kds_1.rowscopy(1, kds_1.rowcount(), primary!, this, 1, primary!)
	if k_rc > 0 then
		k_return = u_group_ricalc()
	end if	
	this.setredraw(true)
	this.setfocus()
		
		
return k_return

end function

public function boolean u_sort (readonly string a_name_header);//---
//--- Ordina le righe x la colonna pigiata (click su campo di testata)
//---
boolean k_return = true
string k_tipo_sort, k_name_Header
string k_color_orig
string k_colType, k_colName

if this.rowcount( ) > 1 then

	setpointer(kkg.pointer_attesa)

	this.transparency = 50
	this.enabled = false
	
	k_name_Header = trim(a_name_header)	
	k_colName = Left(k_name_Header, Len(k_name_Header) - 2) //--- tolgo la '_t' dal nome campo

//	k_x = integer(this.describe(trim(k_nome_campo)+".x"))  + integer(this.describe(trim(a_nome_campo)+".width"))
//	k_x_1 = PixelsToUnits(xpos, XPixelsToUnits!)
	k_color_orig = this.Describe(k_name_Header + ".color")
	this.Modify(k_name_Header + ".color = '" + string(kkg_colore.rosso) + "' " ) 

	
//--- se campo gia' sortato discendente lo faccio ascendente
	if trim(this.Describe(k_name_Header + ".tag")) = "D" then 
		k_tipo_sort = "A"
	else
		if trim(this.Describe(k_name_Header + ".tag")) = "A" then 
			k_tipo_sort = "D"
		end if
	end if

//--- se SORT non ancora chiamo routine di valutazione 
	if k_tipo_sort > " " then
	else
		k_colType = lower(this.Describe(k_colName + ".colType"))
		k_tipo_sort = u_sort_get_type(k_colname, k_coltype)
	end if
	
//--- se SORT non ancora deciso e campo char sort ascendente
	if k_tipo_sort > " " then
	else
		if left(k_colType,4) = "char" then
			k_tipo_sort = "A"
		else
			k_tipo_sort = "D"
		end if
	end if
	
	this.modify(k_name_Header + ".tag='" + k_tipo_sort + "'") 


	this.SetRedraw(false)
	This.SetSort(k_colName + " " + k_tipo_sort)
	This.Sort()
	this.GroupCalc()

	if this.getselectedrow(0) > 0 then
		this.scrolltorow(this.getselectedrow(0))
	end if

	this.SetRedraw(true)

	this.Modify(k_name_Header + ".color = '" + k_color_orig + "' " ) 


	this.enabled = true
	
	setpointer(kkg.pointer_default)
	
	this.transparency = ki_transparency
	
end if
	
return k_return

end function

private function string u_sort_get_type (readonly string k_colname, string k_coltype);//---
//--- Cerca di capire come fare l'ordine
//--- return: Tipo di SORT A/D/ o spazio
//---
string k_return
string k_sortType, k_sortType_temp
long k_rows, k_row

	k_rows = this.rowcount( ) 
	if k_rows > 10 then k_rows = 11
	
	k_rows --
	
	choose case lower(Left(trim(k_colType),3))
			
		case "cha"
			for k_row = 1 to k_rows
				if this.getitemstring(1, k_colName) > this.getitemstring(1, k_colName) then
					k_sortType_temp = "D"
				else
					if this.getitemstring(1, k_colName) < this.getitemstring(1, k_colName) then
						k_sortType_temp = "A"
					end if
				end if
				if k_sortType > " " and k_sortType <> k_sortType_temp then  // se il tipo sort cambia allora resetto ed esco
					exit
				else
					k_sortType = k_sortType_temp
				end if
			next
			
		case "dat"
			if k_colType = "datetime" then
				for k_row = 1 to k_rows
					if this.getitemdatetime(1, k_colName) > this.getitemdatetime(1, k_colName) then
						k_sortType_temp = "D"
					else
						if this.getitemdatetime(1, k_colName) < this.getitemdatetime(1, k_colName) then
							k_sortType_temp = "A"
						end if
					end if
					if k_sortType > " " and k_sortType <> k_sortType_temp then  // se il tipo sort cambia allora resetto ed esco
						exit
					else
						k_sortType = k_sortType_temp
					end if
				next
			else
				for k_row = 1 to k_rows
					if this.getitemdate(1, k_colName) > this.getitemdate(1, k_colName) then
						k_sortType_temp = "D"
					else
						if this.getitemdate(1, k_colName) < this.getitemdate(1, k_colName) then
							k_sortType_temp = "A"
						end if
					end if
					if k_sortType > " " and k_sortType <> k_sortType_temp then  // se il tipo sort cambia allora resetto ed esco
						exit
					else
						k_sortType = k_sortType_temp
					end if
				next 
			end if
			
		case "tim"
			if k_colType = "datetime" then
			else
				for k_row = 1 to k_rows
					if this.getitemtime(1, k_colName) > this.getitemtime(1, k_colName) then
						k_sortType_temp = "D"
					else
						if this.getitemtime(1, k_colName) < this.getitemtime(1, k_colName) then
							k_sortType_temp = "A"
						end if
					end if
					if k_sortType > " " and k_sortType <> k_sortType_temp then  // se il tipo sort cambia allora resetto ed esco
						exit
					else
						k_sortType = k_sortType_temp
					end if
				next
			end if
			
		case "int"
		case "lon"
		case "num"
		case "dec"
		case "rea"
		case "ulo"
			for k_row = 1 to k_rows
				if this.getitemnumber(1, k_colName) > this.getitemnumber(1, k_colName) then
					k_sortType_temp = "D"
				else
					if this.getitemnumber(1, k_colName) < this.getitemnumber(1, k_colName) then
						k_sortType_temp = "A"
					end if
				end if
				if k_sortType > " " and k_sortType <> k_sortType_temp then  // se il tipo sort cambia allora resetto ed esco
					exit
				else
					k_sortType = k_sortType_temp
				end if
			next
			
		case else
			kguo_exception.inizializza(this.classname())
			kguo_exception.kist_esito.esito = kkg_esito.ko
			kguo_exception.kist_esito.sqlerrtext="Errore in SORT del DW, coltype = '" + trim(k_coltype) + "' e colname = '" + trim(k_colname) + "'"
			kguo_exception.scrivi_log( )
			
	end choose
		
	if k_sortType = k_sortType_temp then
		k_return = k_sortType
	end if	
	
return k_return

end function

private subroutine u_set_riga_new ();/*
    Colore la riga in DW se colonna 'x_datins' = DATAOGGI
*/
long k_num_colonne_nr, k_ctr=1, k_pos
string k_num_colonne, k_colore, K_RET, k_str, k_colore_orig, k_str_modify=""
string k_dataoggi_x


	if not ki_colora_riga_aggiornata then
		return
	end if

//---- Mette Colore BACKCOLOR x le righe aggiornate di recente
	if this.Object.DataWindow.Processing = "1" and isnumber(this.Describe("x_datins.x")) then
	
		k_dataoggi_x = string(kguo_g.get_dataoggi( ))
	
		k_num_colonne = this.Object.DataWindow.Column.Count
		if isnumber(k_num_colonne) then
			k_num_colonne_nr = integer(k_num_colonne)
		else
			k_num_colonne_nr = 99
		end if
		do 
			k_colore = trim(this.Describe("#" + trim(string(k_ctr,"###"))+".background.color"))
			
//--- controllo di NON avere già registrato l'espressione... 
			k_pos = pos(k_colore, "if( date(x_datins) = date(", 1) 
			if k_pos <= 0 then 
			
//--- controllo se nella dw c'e' gia' una EXPRESSION
				k_pos = pos(k_colore, "~t", 1) 
				if k_pos > 0 then 
//--- piglia l'espressione senza le Virgolette
					k_colore_orig = mid(k_colore, k_pos, len(k_colore) - k_pos  )
					k_str = "#" + trim(string(k_ctr,"###"))+".background.color=~" 0"   &
							+"~tif( date(x_datins) =  date('" + k_dataoggi_x + "'),"+ KKG_COLORE.REC_UPDX + "," +k_colore_orig + ") ~""  //kGuo_g.get_dataoggi()) +"'),"+ KKG_COLORE.REC_UPDX + "," +k_colore_orig + ") ~"" //~""
				else
					k_str = "#" + trim(string(k_ctr,"###"))+".background.color=~" 0"  &
							+"~tif( date(x_datins) = date('" + k_dataoggi_x +"'),"+ KKG_COLORE.REC_UPDX + "," +k_colore + ") ~""//string(kGuo_g.get_dataoggi()) +"'),"+ KKG_COLORE.REC_UPDX + "," +k_colore + ") ~"" //~""
				end if
				
				k_str_modify += k_str + " "
				
			end if
			k_ctr ++

		loop while k_ctr <= k_num_colonne_nr 
	end if
	
//--- se ho trovato qls applica le modifiche tutte insieme	
	if k_str_modify > " " then 
		k_ret = this.Modify(k_str_modify)
		u_set_column_color() // imposta il colore delle colonne 
	end if


		
			
end subroutine

public function boolean if_link_enabled ();//
//--- TRUE = ok imposta i LINK
if (ki_flag_modalita <> kkg_flag_modalita.modifica and ki_flag_modalita <> KKG_FLAG_RICHIESTA.inserimento) or ki_link_standard_sempre_possibile  then
	return true
else
	return false
end if
end function

public subroutine u_set_column_color ();/*
   Imposta il COLOR del testo a seconda del background
*/
int k_rc
string k_style, k_type, k_num_colonne, k_campo, k_appo
int k_ctr, k_num_colonne_nr
string k_rcx , k_color_black, k_color_white
string k_modify
long k_backgroundColor, k_n


	this.setredraw(false)
	
	k_color_black = string(kkg_colore.nero)
	k_color_white = string(kkg_colore.bianco)

	k_num_colonne = this.Object.DataWindow.Column.Count
	if isnumber(k_num_colonne) then
		k_num_colonne_nr = integer(k_num_colonne)
	else
		k_num_colonne_nr = 99
	end if
	do 

		k_campo = trim(string(k_ctr,"###"))
		//k_appo = this.Describe("#" + k_campo + ".Name")

		k_style = trim(this.Describe("#" + k_campo + ".Edit.Style"))
		if k_style <> "!" and k_style <> "?" and k_style <> "checkbox" and k_style <> "radiobuttons" then //and k_style <> "dddw" and k_style <> "ddlb" then
			
			k_type = lower(trim(this.Describe("#" + k_campo + ".Type")))
		
			k_backgroundColor = long(this.Describe("#" + trim(string(k_ctr,"###")) + ".Background.Color"))
			if k_backgroundColor = 0 then  // se il colore sfondo è zero (presuppongo sia TRANSPARENT) allora piglia il colore di sffondo del DE
				k_backgroundColor = long(this.Describe("DataWindow.Color"))
			end if				
			if k_backgroundColor <= kkg_colore.bianco then
				//k_n = kkg_colore.SFONDO_SCURO_n
				if k_backgroundColor >= kkg_colore.SFONDO_SCURO_n then
					k_modify += "#" + k_campo+".Color='" + k_color_black + "' "
				else
					k_modify += "#" + k_campo+".Color='" + k_color_white + "' "
				end if
			end if				
		end if
		k_ctr = k_ctr + 1 

	loop while k_ctr <= k_num_colonne_nr //and k_id_campo = 0

	k_rcx=this.Modify(k_modify)

	this.setredraw(true)


end subroutine

public subroutine u_proteggi ();/*
Protegge o sproteggi campi del form per i campi con Tab-order > 0
     Input: il datawindow e la proprietà ki_flag_modalita
*/
int k_ctr, k_colcount
string k_tabsequence


choose case this.ki_flag_modalita
		
	case kkg_flag_modalita.visualizzazione &
			,kkg_flag_modalita.cancellazione 
//		u_proteggi_dw("1", 0, adw_1) 	//--- protezione di tutto

	case kkg_flag_modalita.inserimento &
			,kkg_flag_modalita.modifica
		k_colcount = integer(this.Describe("DataWindow.Column.Count"))

		for k_ctr = 1 to k_colcount 

//--- estrae Describe("<Columnname>.TabSequence")
			k_tabsequence = trim(this.Describe("#" + trim(string(k_ctr,"###")) + ".TabSequence"))

			if k_tabsequence <> "?" and k_tabsequence <> "!" and k_tabsequence > "0" then
	//			u_proteggi_dw("0", k_ctr, adw_1) 	//--- Sprotezione del campo
			else
	//			u_proteggi_dw("1", k_ctr, adw_1) 	//--- Sprotezione del campo
			end if
		
		next

end choose


end subroutine

public function long u_get_riga_atpointer (ref string k_nome_campo);/*
   tenta di trovare il numero di riga con o senza nome-campo sul quale è il puntatore
	inp: nome_campo il nome della colonna se manca prova a impostarlo dal puntatore
	out: nome_campo se era lasciato vuoto
	ret: numero di riga
*/
long k_riga=0
string k_rigax


//--- potrebbe essere un tree per cui prendo il NUMERO RIGA se ho premuto su un NODO
	k_rigax = trim(this.GetObjectAtPointer())  // torna ad esempio: id_meca~t23   colonna id_meca riga 23 o  id_meca_t~t15 campo in testata e la riga 15 è la prima visibile sotto 
	if k_rigax > " " then
		
		if trim(k_nome_campo) > " " then
			k_rigax = Replace ( k_rigax, pos( k_rigax,trim(k_nome_campo), 1), len(trim(k_nome_campo)) , space(len(trim(k_nome_campo))) )
		else
			k_nome_campo = left(k_rigax, pos(k_rigax, "~t") - 1)
			k_rigax = right(k_rigax, len(k_rigax) - pos(k_rigax, "~t"))
		end if
		if isnumber(trim(k_rigax)) then 
			k_riga = long(trim(k_rigax))
		else
			k_riga = 0
		end if
	
	end if

return k_riga


end function

public function long u_getrow (long a_if_noone_row);/*
  Torna la riga selezionata o la riga con il fuoco o la riga indicata (opzionale)
  inp: riga = torna questa come ultima istanza piuttosto che zero (se ce ne sono) altrimenti zero
  rit: la riga 
*/
long k_row


if this.rowcount( ) > 0 then
	
	k_row = this.getselectedrow(0)
	if k_row > 0 then return k_row
	
	k_row = this.getrow()
	if k_row > 0 then return k_row

	if a_if_noone_row > 0 then 
		if this.rowcount( ) > a_if_noone_row then
			return a_if_noone_row
		else
			return this.rowcount( )
		end if
	end if
	
end if

return 0  // non ci sono righe o nessuna con il fuoco
end function

private subroutine u_drag_scroll (long a_row);//---
//--- scroll delle righe visibili mentre si fa il DRAG&DROP 
//---

long k_rows_tot, k_last_row, k_first_row
int k_col_n, k_row_scroll = 2, i
string k_rc
string k_col_pointer, k_col_name
string k_mod_string

	
//if ki_attiva_DRAGDROP and ki_in_DRAG and NOT ki_u_drag_scroll_lanciata then
//if ki_in_DRAG and NOT ki_u_drag_scroll_lanciata then
if NOT ki_u_drag_scroll_lanciata then
	ki_u_drag_scroll_lanciata=true
	
	k_rows_tot = this.rowcount() 
	//k_row_scroll = 2
//	do while ki_drag_scroll //and k_row_scroll <  k_rows_tot and k_row_scroll > 1
		
		k_rc = this.describe("k_dragdrop_row.x")
		if k_rc <> "0" then
			k_mod_string = "Create compute(band=header alignment='0' expression='0'enabled='0' border='0' color='0' x='0' y='0' height='60' width='183' format='[GENERAL]' html.valueishtml='0' " &
							+ "name=k_dragdrop_row visible='0'  font.face='Arial' font.height='-9' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' background.transparency='0' background.gradient.color='8421504' background.gradient.transparency='0' background.gradient.angle='0' background.brushmode='0' background.gradient.repetition.mode='0' background.gradient.repetition.count='0' background.gradient.repetition.length='100' background.gradient.focus='0' background.gradient.scale='100' background.gradient.spread='100' tooltip.backcolor='134217752' tooltip.delay.initial='0' tooltip.delay.visible='32000' tooltip.enabled='0' tooltip.hasclosebutton='0' tooltip.icon='0' tooltip.isbubble='0' tooltip.maxwidth='0' tooltip.textcolor='134217751' tooltip.transparency='0' transparency='0' )"
			k_rc = this.modify(k_mod_string)
		end if
		k_rc = this.modify("k_dragdrop_row.Expression='"+ string(a_row)+"' ")
		if ki_drag_colname = "" then
			k_col_pointer = this.GetObjectAtPointer()
			if k_col_pointer > " " and pos(k_col_pointer, "~t") > 0 then
				k_col_name = mid(k_col_pointer, 1, pos(k_col_pointer, "~t") - 1)
			else
				k_col_n = 0
				k_rc = ""
				k_col_name = ""
				// il n.colonna deve esistere
				do while k_col_name = "" and (k_rc = "" or k_rc = "1" or k_rc = "0")
					k_col_n ++
					k_rc = this.describe("#" + string(k_col_n, "#")+".visible") 
					if k_rc = "1" then
						if this.describe("#" + string(k_col_n, "#")+".type") = "column" &
									or this.describe("#" + string(k_col_n, "#")+".type") = "compute" then 
							k_col_name = this.describe("#" + string(k_col_n, "#")+".name")
						end if
					end if
				loop
			end if
			if k_col_name > " " then
				//--- mette una colonna in ITALIC + UDERLINE durante il movimento
				k_rc = k_col_name + ".Font.italic='0~tif( getrow() = k_dragdrop_row, 1,0)' " &
				          + k_col_name + ".Font.Underline='0~tif( getrow() = k_dragdrop_row, 1,0)'"
				k_rc = this.modify(k_rc)	
				ki_drag_colname = k_col_name
			end if
		end if
		
//--- Scorre l'elenco in automatico
		k_last_row = long(this.describe("DataWindow.LastRowOnPage")) 
		k_first_row = long(this.describe("DataWindow.FirstRowOnPage")) 
//		if (k_last_row - k_first_row) > 20 then
//			k_row_scroll = 5
//		elseif (k_last_row - k_first_row) > 12 then
//			k_row_scroll = 3
//		elseif (k_last_row - k_first_row) > 7 then
//			k_row_scroll = 2
//		else
//			k_row_scroll = 1
//		end if
		if k_last_row < k_rows_tot or k_first_row > 1 then
			if a_row > (k_last_row - k_row_scroll) then
				for i = 1 to k_row_scroll
					this.ScrollNextRow( )
				next
//				if (k_last_row + k_row_scroll) > k_rows_tot then 
					//this.scrolltorow(k_rows_tot) 
//				else
//					this.scrolltorow(k_last_row + k_row_scroll)
//				end if
			else
				if a_row < (k_first_row + k_row_scroll) then
					for i = 1 to k_row_scroll
						this.ScrollPriorRow( )
					next
//					if (k_first_row - k_row_scroll) > 1 then 
//						this.scrolltorow(k_first_row - k_row_scroll)
//					else
//						this.scrolltorow(1) 
//					end if
				end if
			end if	
		end if	
		
		this.setredraw( true)
		
//		yield()

//	loop 

	ki_u_drag_scroll_lanciata=false
end if
end subroutine

private subroutine u_dragging_label_destroy ();//
//if ki_dragging_label_created then
	ki_dragging_label_created = false
	if not isvalid(kidw_dragdrop_source) then return
	if not isnull(kidw_dragdrop_source) then return

	this.modify("destroy x_marker_" + kidw_dragdrop_source.ki_dragging_label_colname + " ")
		
//end if

end subroutine

private function string u_dragging_label_show ();//
string k_modify
string k_rcx

if isvalid(kidw_dragdrop_source) then
	if kidw_dragdrop_source.ki_dragging_label_colname > " " then
		
		ki_dragging_label_value = kgn_string.u_replace(kidw_dragdrop_source.ki_dragging_label_value, "'", "")  // rimuove il carattere APICE che può creare confusione
		
		if not this.ki_dragging_label_created then
		
			this.ki_dragging_label_created = true
		
			k_modify = "create text(band=Foreground " &
				+ "color='" + string(rgb(245,0,0)) + "' alignment='0' border='4' " &
				+ "height.autosize=No pointer='Arrow!' moveable=1 resizeable=0 " &
				+ "x='" + string(this.PointerX()+40) + "' y='" + string(this.PointerY()-10) + "' " &
				+ "height='" + kidw_dragdrop_source.ki_dragging_label_height + "' width='" + kidw_dragdrop_source.ki_dragging_label_width + "' " &
				+ "name=x_marker_" + kidw_dragdrop_source.ki_dragging_label_colname+ " " &
				+ "text='" + kidw_dragdrop_source.ki_dragging_label_value +  "' "  +  &
				+ "tag='' font.face='VERDANA' font.height='-10' font.weight='400' font.family='0' font.pitch='0' font.charset='1' font.italic='0' font.strikethrough='0' " &
				+ "font.underline='0' background.mode='0.8' background.color='" + string(rgb(255,255,255)) + "') " 
		
		//	k_modify = "create compute(band=Foreground "  +  &
		//		+ "color='" + string(rgb(245,0,0)) + "' alignment='0' border='4' " &
		//		+ "height.autosize=No pointer='Arrow!' moveable=1 resizeable=0 " &
		//		+ "x='" + string(this.PointerX()+40) + "' y='" + string(this.PointerY()-10) + "' " &
		//		+ "height='" + a_height + "' width='" + ki_dragging_label_width + "' " &
		//		+ "name=x_marker_" + ki_dragging_label_colname+ " " &
		//		+ "Expression=~t'PIPPO' " & 
		//		+ "format='[general]' " &
		//		+ "tag='' font.face='VERDANA' font.height='-10' font.weight='400' font.family='0' font.pitch='0' font.charset='1' font.italic='0' font.strikethrough='0' " &
		//		+ "font.underline='0' background.mode='0.8' background.color='" + string(rgb(255,255,255)) + "') " 
		//		+ "color='" + string(rgb(245,0,0)) + "' alignment='0' border='4' " &
		//		+ "height.autosize=Yes pointer='Arrow!' moveable=1 resizeable=0 " &
		//		+ "x='" + string(this.PointerX()+40) + "' y='" + string(this.PointerY()-10) + "' height='" + a_height + "' width='" + ki_dragging_label_width &
		//		+ "' name=x_marker_" + ki_dragging_label_colname+ " " &
		//		+ "tag='' font.face='VERDANA' font.height='-10' font.weight='400' font.family='0' font.pitch='0' font.charset='1' font.italic='0' font.strikethrough='0' " &
		//		+ "font.underline='0' background.mode='0.8' background.color='" + string(rgb(255,255,255)) + "' " &
		//		+ "format='[general]' " &
		//		+ "expression='" + ki_dragging_label_value +  "') "  
		//		+ "Width.Autosize=yes " &
				//+ "Width.AutoSize=1 Visible='1' " + &    aurosize='1' da errore!
		else
	
			k_modify = "x_marker_" + kidw_dragdrop_source.ki_dragging_label_colname + ".x='" + string(this.PointerX()+40) + "' " + "x_marker_" + kidw_dragdrop_source.ki_dragging_label_colname + ".y='" + string(this.PointerY()-10) + "' " &
							+ "text='" + kidw_dragdrop_source.ki_dragging_label_value +  "' "  
	
		end if
	
		k_rcx = this.modify(k_modify)
					//	kguo_exception.kist_esito.esito = kkg_esito.ko
					//	kguo_exception.kist_esito.sqlerrtext = k_modify
					//	kguo_exception.scrivi_log( )
		
	end if
	
end if
return k_rcx

end function

private function boolean u_if_in_dragging ();//
if isvalid(kidw_dragdrop_source) then
	if kidw_dragdrop_source.ki_in_drag then
		return true
	end if
end if

return false
end function

public function long u_selectrow_onclick (readonly long a_row);//
//long k_return=0
long k_row_ctr //, k_riga_ini, k_riga_fin, k_riga_select
//int k_ctr



//--- seleziona le righe del DW solo x i tipi GRID
if (this.Object.DataWindow.Processing = kki_tipo_processing_grid or this.Object.DataWindow.Processing = kki_tipo_processing_tree or this.Object.DataWindow.Processing = kki_tipo_processing_altro) then
	
	if not ki_select_multirows then
		This.SetRow(a_row)
		This.SelectRow(0, FALSE)
		if a_row > 0 then
			This.SelectRow(a_row, TRUE)
		end if
	
		return a_row   // EXIT
	end if
	
	
//--- ctrl+click	per seleziona/deseleziona riga
	if keydown( keycontrol! ) then
		
//		if a_row > 0 then 
//			if this.isselected( a_row) then
//				this.selectrow ( a_row, false )
//			else
//				this.selectrow ( a_row, true )
//			end if
//		end if
		
	else
		 
//--- shift+click	per selezionare tutte le righe comprese tra
		if keydown( keyshift! ) then 
//			this.setredraw ( false )
//			if this.getselectedrow ( 0 ) = 0 then
//				k_riga_ini = a_row
//			else
//				k_riga_ini = this.getrow()
//			end if
//			k_riga_fin = a_row
//			ki_UltRigaSel = a_row
//			if k_riga_ini > k_riga_fin then
//				for k_row_ctr = k_riga_ini to k_riga_fin step -1 
//					this.selectrow ( k_row_ctr, true )
//				next
//			else
//				for k_row_ctr = k_riga_ini to k_riga_fin 
//					this.selectrow ( k_row_ctr, true )
//				next
//			end if
//			this.setredraw ( true )
			if ki_UltRigaSel = 0 then ki_UltRigaSel = this.getselectedrow(0)
			if ki_UltRigaSel < a_row then
				for k_row_ctr = ki_UltRigaSel to a_row step 1
					this.selectrow ( k_row_ctr, true )
				next
			else
				for k_row_ctr = ki_UltRigaSel to a_row step -1
					this.selectrow ( k_row_ctr, true )
				next
			end if
			
		else
	
	//--- solo click		
			if a_row > 0 then
				//if not this.isselected(a_row) then
					this.selectrow ( 0, false )
					this.selectrow ( a_row, true )
				//end if
			end if 
		end if 
		
	end if

	if a_row > 0 then
		ki_UltRigaSel = a_row
		this.setrow(a_row)
	end if
	
end if


////this.setrow( a_row )
//if a_row > 0 then
//	k_return = a_row
//end if

return ki_UltRigaSel 
end function

public function long u_set_ki_lbuttondown_row ();//

if this.ki_lbuttondown_row > 0 then return this.ki_lbuttondown_row

if isvalid(kidw_dragdrop_source) then
	if kidw_dragdrop_source.dataobject > " " then
		this.ki_lbuttondown_row = kidw_dragdrop_source.ki_lbuttondown_row
	end if
end if


end function

public function long u_getselectedrows (long a_row);/*
Comteggio delle righe selezionate
  inp: row dalla qualse si vuole partire nel conteggio
  rit: nr delle righe selezionate
*/
long k_return

		
	a_row = this.getselectedrow(a_row)
	do while a_row > 0

		k_return ++
		
		a_row = this.getselectedrow(a_row)
	loop

return k_return
end function

public function string u_getitemstring (string a_colonna, long a_riga);//
//=== Torna Valore String da una colonna di DW
string k_return=""
string k_tipo=""

	
	if a_riga > 0 and trim(a_colonna) > " " then
		k_tipo = this.Describe(a_colonna + ".ColType")
		choose case lower(left(k_tipo, 3))
			case "cha"
				k_return = trim(this.getitemstring(a_riga, a_colonna))
			case "lon", "dec", "num", "int", "ulo"
				if dec(string(this.getitemnumber(a_riga, a_colonna), "#0.00")) > 0 then
					k_return = string(this.getitemnumber(a_riga, a_colonna))
				end if
			case "dat"
		    	if k_tipo = "datetime" then
					if date(this.getitemdatetime(a_riga, a_colonna)) > kkg.data_no then
						k_return = string(this.getitemdatetime(a_riga, a_colonna))
					end if
				else
					if this.getitemdate(a_riga, a_colonna) > kkg.data_no then
						k_return = string(this.getitemdate(a_riga, a_colonna))
					end if
				end if
			case "tim"
				if this.getitemtime(a_riga, a_colonna) > time(0,0,0) then
					k_return = string(this.getitemtime(a_riga, a_colonna))
				end if
		end choose
 		if isnull(k_return) then k_return = ""
	end if	

return k_return


end function

private function string link_standard_call_if (string a_nome_link, long a_riga) throws uo_exception;/*
 Verifica se Attivare lo ZOOM (premuto un campo di link e attivabile)
   Inp: a_nome_link = nome del campo o button cliccato  
        a_riga = numero riga
   Out: OK=torna il nome del campo da linkare;  NO=vuoto
*/
string k_nome_link_button
string k_taborder, k_valore
boolean k_press_KeyControl



	if a_nome_link > " " then  
	else
		return "" // senza NOME del campo di Link non fare nulla
	end if

//--- Ho un VALORE e Ho attivato i flag x fare lo ZOOM?
	if not (ki_button_standard_attivi or ki_link_standard_attivi) then
		return "" // non fare nulla
	end if

	setpointer (kkg.pointer_attesa)	
		
//--- se ho cliccato su un BUTTON o SIMILARE converto nel link tradizionale 
	k_nome_link_button = kiuf_link_zoom.get_link_da_button (a_nome_link)
	if k_nome_link_button > " " then  // se è un button allora allora ZOOM ok
		return trim(k_nome_link_button)   // campo di LINK
	end if

	if KeyDown(KeyControl!) then k_press_KeyControl = true

	if kguo_g.get_flagZOOMctrl() and not k_press_KeyControl then // se richiesto il tasto CTRL ma non premuto
		return "" // non fare nulla
	end if
			
	if not k_press_KeyControl and NOT ki_link_standard_attivi then // se NO link standard attivo allora ok
		return "" // non fare nulla
	end if
			
	if a_riga > 0 then  // se campo di dettaglio
		k_valore = trim(u_getitemstring(a_nome_link, a_riga))
		if k_valore > " " then
			if not k_press_KeyControl then
				if NOT this.u_get_protect(a_nome_link) then // campo protetto?
					k_taborder = this.Describe(a_nome_link + ".TabSequence")
					if isnumber(k_taborder) then 
						if integer(k_taborder) > 0 then
							return ""  // campo di INPUT ATTIVO non faccio ZOOM altrimenti e' un casino x l'utente 
						end if
					end if
				end if
			end if
		else
			return ""  // campo di INPUT ATTIVO non faccio ZOOM altrimenti e' un casino x l'utente 
		end if
	end if

return a_nome_link
	


end function

private function boolean link_standard_call (string a_nome_link, long a_riga) throws uo_exception;//
//--- Verifica se è stato premuto un link (button o campo)
//--- Input: a_nome_link  = nome del campo o button cliccato
//---        a_riga = numero riga
//---            
//--- Output: boolean TRUE = ok e' entrato in funzione; FALSE=non ha fatto niente
//
boolean k_return=false
string k_nome_link
uo_d_std_1 kdw_link

try 

	k_nome_link = link_standard_call_if(a_nome_link, a_riga)  // Verifica ZOOM possibile
	if k_nome_link > " " then

		setpointer (kkg.pointer_attesa)	
		
		kdw_link = this
		k_return = kiuf_link_zoom.link_standard_call_p (kdw_link, k_nome_link) // attiva i tasti con il LINK

	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally	
	setpointer (kkg.pointer_default)	

end try
	
return k_return


end function

public function string u_get_ctrl_c_value ();/*
  Tenta di mettere il testo del CONTRL+C nel Clipboard altrimenti torna solo il testo
*/
string k_val
int k_rc
		
		
//--- prima tenta il Ctrl+C diretto con il COPY (campi di edit)
	if	this.copy() > 0 then  
		return ""
	end if

//--- poi tenta se testo selezionato (su campi protetti ma con Mouse-selection attivo)
	k_val = trim(this.Describe("DataWindow.Selected.Data"))
	if k_val > " " then
		return k_val
	end if

//--- poi tenta con il nome della colonna di prendere il valore del campo su cui è
	if this.getrow() > 0 then
		if trim(this.ki_clicked_colname) > " " then
			k_val = trim(this.u_getitemstring(this.ki_clicked_colname, this.getrow()))
			if k_val > " " then
				return k_val
			end if
		end if
	end if

return ""

end function

private function boolean u_colmodified (long al_row, string as_col, dwbuffer a_buf);/**********************************************************************************************************************
Dscr:         Reports if the passed column has been modified, i.e. its value has been changed since the row was
            retrieved/inserted/updated, but not been saved yet. If the value was changed, but later the original value
            was restored, the field is NOT considered modified regardless its DWItemStatus.
           
            If your script deals only with the current record of the Primary! buffer (i.e. it's a FORM DW),
            then you can use the overloaded version with 2 arguments (this & as_col).
***********************************************************************************************************************
Arg:        DataWindow   this
            long         al_row
            string      as_col
            DWBuffer      a_buf
***********************************************************************************************************************
Ret:         boolean (true - has been changed, false - has NOT been changed)
***********************************************************************************************************************
Developer:   Michael Zuskin -  http://linkedin.com/in/zuskin | http://code.intfast.ca/
*/
string         ls_col_type
string         ls_old
string         ls_new
DWItemStatus   l_col_status

//l_col_status = this.GetItemStatus(al_row, as_col, a_buf)
//if l_col_status = NotModified! then
//   return false
//end if

// If this code reached, it's DataModified!. That does not guarantee that the column has actually been
// modified - user could change its value (making it DataModified!), but restore
// the original value later (unfortunately, that doesn't rollback the status to NotModified!).
// So, we will compare the original and the current values.

ls_col_type = Lower(Left(this.Describe(as_col + ".coltype"), 5))
choose case ls_col_type
case "numbe", "long", "ulong", "real", "int", "decim"
   ls_old = String(this.GetItemNumber(al_row, as_col, a_buf, true))
   ls_new = String(this.GetItemNumber(al_row, as_col, a_buf, false))
case "char(", "char"
   ls_old = this.GetItemString(al_row, as_col, a_buf, true)
   ls_new = this.GetItemString(al_row, as_col, a_buf, false)
case "datet", "times"
   ls_old = String(this.GetItemDateTime(al_row, as_col, a_buf, true))
   ls_new = String(this.GetItemDateTime(al_row, as_col, a_buf, false))
case "date"
   ls_old = String(this.GetItemDate(al_row, as_col, a_buf, true))
   ls_new = String(this.GetItemDate(al_row, as_col, a_buf, false))
case "time"
   ls_old = String(this.GetItemTime(al_row, as_col, a_buf, true))
   ls_new = String(this.GetItemTime(al_row, as_col, a_buf, false))
end choose

if IsNull(ls_old) and IsNull(ls_new) then return false
if IsNull(ls_old) and not IsNull(ls_new) then return true
if not IsNull(ls_old) and IsNull(ls_new) then return true

return (ls_new <> ls_old)
end function

private function boolean u_colmodified (string as_col);//
return u_colmodified(this.GetRow(), as_col, Primary!)
end function

private function boolean u_rowmodified (long al_row, dwbuffer a_buf);/**********************************************************************************************************************
Dscr:         Reports if the passed row has been modified, i.e. at least one of its columns has been changed.
            A column is considered modified if its value has been changed since the row was retrieved/inserted/updated,
            but that change has not been saved yet. If the value was changed, but later the original value was restored,
            the column is NOT considered modified regardless its DWItemStatus.
           
            If your script deals only with the current record of the Primary! buffer (i.e. it's a FORM DW),
            then you can use the overloaded version with 1 argument only (this).
***********************************************************************************************************************
Arg:        
            al_row         long
            DWBuffer         a_buf
***********************************************************************************************************************
Ret:         boolean
***********************************************************************************************************************
Developer:   Michael Zuskin -  http://linkedin.com/in/zuskin | http://code.intfast.ca/
**********************************************************************************************************************/
int            i
int            li_col_count
string         as_col
DWItemStatus   l_row_status
//
l_row_status = this.GetItemStatus(al_row, 0 /* get the status of the whole row */, a_buf)
choose case l_row_status
//case New!, NotModified!
//   return false
case NewModified!, DataModified!
   return true
end choose

// If this code reached, it's NewModified! or DataModified!. That does not guarantee that the row has actually been
// modified - user could change a column in the row (marking it as NewModified! or DataModified!), but restore
// the original value later (unfortunately, that doesn't rollback the status to New! or NotModified!).
// So, we will utilize uf_col_modified() which compares the original and the current values.

li_col_count = Integer(this.Describe("datawindow.column.count"))
for i = 1 to li_col_count
   as_col = this.Describe("#"+ String(i) + ".Name")
   if u_colmodified(al_row, as_col, a_buf) then
      return true
   end if
next

return false
end function

private function boolean u_rowmodified (long al_row);//
return u_rowmodified(al_row, primary!)
end function

private function boolean u_rowmodified ();//
long k_row, k_rows

k_rows = this.rowcount( )
for k_row = 1 to k_rows
	if u_rowmodified(k_row, primary!) then return true
next

return false
end function

on uo_d_std_1.create
call super::create
end on

on uo_d_std_1.destroy
call super::destroy
end on

event clicked;//
string k_name
long k_row 
boolean k_sort


k_name = trim(dwo.Name)

if row > 0 then

	if ki_attiva_standard_select_row and not ki_d_std_1_primo_giro then
		
		k_row = u_selectrow_onclick (row)

	end if

else

	if (this.Object.DataWindow.Processing = kki_tipo_processing_tree or this.Object.DataWindow.Processing = kki_tipo_processing_altro) then
		k_row = u_selectrow_onclick (0)
	end if
	
//--- Ordina righe se il campo di testata colonna finisce x '_t' ed è formato testo
//	if left(k_bands, 4) = "head" then
	if ki_d_std_1_attiva_sort then
		if this.rowcount( ) > 1 then
			IF dwo.Type = "text" and right(k_name, 1) = "t" THEN
				
				this.selectrow(0, false)
				u_sort(k_name)   // Esegue il SORT
				this.setrow(1)
				this.scrolltorow(1)
	
			end if
		end if
	end if
//	end if

end if

//--- funzione di ZOOM
if not k_sort then
	if (ki_link_standard_attivi or ki_button_standard_attivi)  then
		if (ki_link_standard_attivi or ki_button_standard_attivi)  then
			try
				if row = 0 then 
					if this.rowcount() > 0 then
						row = 1
					end if
				end if
				
				link_standard_call(k_name, row)   // lancia link standard
			catch (uo_exception kuo_exception)
				kuo_exception.messaggio_utente()
			end try
		end if
	end if
end if


return 0
end event

event doubleclicked;//

this.accepttext()

if row > 0 then

	if not keydown( keycontrol! ) and not keydown( keyshift! ) then 

		event u_doppio_click(row)	
		
	end if

else
	return 1
end if


end event

event getfocus;//
long k_riga=0


if trim(ki_icona_selezionata) > " " then
	this.icon = ki_icona_selezionata
end if

// se abilitato imposta la gestione di mostrare mentre si digita il primo valore completo che trova nel ddw
if ki_abilita_ddw_proposta then
	kiuf_ddw_grid.u_set_current_dw(kidw_this)
end if

if ki_attiva_standard_select_row  and not ki_d_std_1_primo_giro then
	k_riga = This.getSelectedRow(0) 
	if  k_riga > 0 then
 //--- riga con il fuoco e' selezionata?
		if isSelected(This.getRow()) then
		else
 //--- cerco di far coincidere la riga selezionata con quella con il fuoco
			if setrow(This.getSelectedRow(This.getRow())) > 0 then
			else
				setrow(k_riga)
			end if
		end if
	else
		k_riga=u_selectrow_onclick (0)
		if k_riga > 0 then
			this.setrow(k_riga)
		end if
	end if
end if

if this.Object.DataWindow.Processing = kki_tipo_processing_form and this.getrow() > 0 &
			and (this.ki_flag_modalita = kkg_flag_modalita.modifica or this.ki_flag_modalita = kkg_flag_modalita.inserimento) then

//	kguo_g.use_col_background_input_field(kidw_this, this.getcolumnname())
	u_set_color_column_on_cursor(this.getcolumnname(), false)  // imposta colore di sfondo della colonna
	
end if

end event

event rbuttondown;//
//	datawindow kdw
//	kdw = this


	ki_riga_rbuttondown = row
	kidwo_1 = dwo

//--- Calendario
//	if row > 0 then
//		if dwo.type = "column" then
//			if lower(mid(dwo.coltype,1,4)) = "date" &
//				and integer(this.Describe(trim(dwo.name)+".TabSequence")) > 0 &
//				and this.Describe(trim(dwo.name)+".Protect") = "0" & 
//				and this.Describe(trim(dwo.name)+".edit.DisplayOnly") <> "yes"   & 
//				then
//				gf_dw_pop_calendar(kdw,dwo.name,dwo.coltype,row)
//			else
//				parent.triggerevent(rbuttondown!)
//			end if
//		else
//			parent.triggerevent(rbuttondown!)
//		end if
//	else
//		parent.triggerevent(rbuttondown!)
//	end if
	


end event

event dberror;//

if isvalid(kiuo_exception) then
else
	kiuo_exception = create uo_exception
end if
kist_esito = kiuo_exception.inizializza(this.classname())

if isvalid(parent) then 
	kist_esito.nome_oggetto = parent.classname()
else
	kist_esito.nome_oggetto = classname()
end if
kist_esito.nome_oggetto += " (dataobject: " + this.dataobject + ")"
kist_esito.sqlsyntax = trim(sqlsyntax)
kist_esito.sqlerrtext = trim(sqlerrtext)
kist_esito.sqldbcode = sqldbcode
kist_esito.sqlcode = sqldbcode

if trim(kist_esito.esito) > " " then
else
	kist_esito.esito = kkg_esito.db_ko
end if

kiuo_exception.u_errori_gestione(kist_esito)

if isvalid(kguo_exception) then kguo_exception.set_esito(kist_esito)


RETURN 1 // Do not display system error message

end event

event itemerror;//
//0 (Default) Reject the data value and show an error message box
//1 Reject the data value with no message box
//2 Accept the data value
//3 Reject the data value but allow focus to change
//
string k_data_x
int k_rc


	k_data_x = dwo.coltype

	if dwo.coltype = "date" then 
//		k_data_x = trim(data)
//		if k_data_x = "" or left(k_data_x,2) = "00" then
//			return 2  // OK
//		elseif len(k_data_x) < 3 and isnumber(k_data_x) then
//			k_data_x = trim(k_data_x) + "/" + string(today(), "mmm/yyyy")
//		elseif len(k_data_x) = 4 and isnumber(k_data_x) then
//			k_data_x = left(k_data_x,2) + "/" + mid(k_data_x,3,2) + "/" + string(today(), "yyyy") 
//		elseif len(k_data_x) = 5 and not isnumber(mid(k_data_x,3,1)) then 
//			k_data_x = left(k_data_x,2) + "/" + mid(k_data_x,4,2) + "/" + string(today(), "yyyy") 
//		end if
//		if isdate(k_data_x) then 
//			return 2 // OK
//		else
			k_rc = 3
//		end if			

	else
		
//		if dwo.coltype = "Number" or dwo.coltype = "Long" or dwo.coltype = "Int" then
		if dwo.coltype = "Int" or dwo.coltype = "Long" or dwo.coltype = "Number" or left(dwo.coltype,3) = "Dec" or dwo.coltype = "Ulong" then
			if not isnumber(trim(data)) then
				this.post setitem(row, integer(dwo.id), 0)
				return 2 // OK
			end if
//			k_data_x = trim(data)
//			if k_data_x = "" then
//				return 2 // OK
//			else
//				k_rc = 3
//			end if
		else
//			if left(dwo.coltype, 3) = "dec" then
//				k_data_x = trim(data)
//				if k_data_x = "" then
//					return 2 // OK
//				else
//					k_rc = 3
//				end if
//			else
				return 1 // KO senza errore
//			end if
			
		end if
	end if

	if k_rc = 3 then
		if isnull(k_data_x) then k_data_x = "nullo"
		messagebox("Verifica digitazione", "Dato '" + trim(string(k_data_x)) + "' non consentito", stopsign!)
		return k_rc // KO senza errore
	end if
	

end event

event itemchanged;//
//0 (Default) Accept the data value
//1 Reject the data value and do not allow focus to change (triggers itemerror)
//2 Reject the data value but allow the focus to change (triggers itemerror)
//
int k_return=0
//string k_codice, k_data_x
//date k_data, k_dataoggi
//string k_style, k_ddw_campo, k_type, k_valore
//long k_find_riga=0, K_RC 
//datawindowchild  kdwc_1
//
//
////--- sui campi data tento correzioni --------------------------------------------
//	if dwo.coltype = "date" then 
//		k_dataoggi = kguo_g.get_dataoggi( )
//		k_data_x = trim(data)
////--- se è una data ok prosegue		
//		if isdate(k_data_x) then
//			
////--- se a spazio metto data 01.01.1899		
//		elseif k_data_x = "" then
//			k_data_x = string(date(0))
////--- se è una dattipo yyyy-mm-dd è bella e fatta
//		elseif isnumber(left(k_data_x,4)) and isnumber(mid(k_data_x,6,2)) and isnumber(mid(k_data_x,9,2)) then
//			k_data_x = mid(k_data_x,9,2) + "/" + mid(k_data_x,6,2) + "/" +  left(k_data_x,4)
////--- se a ZERO metto data 01.01.1899		
//		elseif left(k_data_x,2) = '00' then
//			k_data_x = string(date(0))
////--- se a indicato un numero tipo 5 o 23 metto lo considero il giorno
//		elseif len(k_data_x) < 3 and isnumber(k_data_x) then
//			k_data_x = string(date(string(k_dataoggi, "yyyy/mm/") + k_data_x))
//		elseif len(k_data_x) = 4 and isnumber(k_data_x) then
//			k_data_x = string(date(string(k_dataoggi, "yyyy/") + mid(k_data_x,3,2) + "/" + left(k_data_x,2)))
//		elseif len(k_data_x) = 5 and not isnumber(mid(k_data_x,3,1)) then 
//			k_data_x = string(date(string(k_dataoggi, "yyyy/") + mid(k_data_x,4,2) + "/" + left(k_data_x,2)))
//		else
//			k_data_x = string(date(0))
//		end if			
//		if isdate(k_data_x) then
//			k_data = date(k_data_x)
//		else
//			k_data = date(0)
//		end if
//		k_rc=this.setitem(row, integer(dwo.id), k_data)
//	end if			
////-----------------------------------------------------------------------------------------------------------
//
////--- sui campi Numerici se vuoto forza ZERO --------------------------------------------
//	if dwo.coltype = "Int" or dwo.coltype = "Long" or dwo.coltype = "Number" or left(dwo.coltype,3) = "Dec" or dwo.coltype = "Ulong" then
//		if trim(data) = "" then
//			this.setitem(row, integer(dwo.id), 0)
//		end if
//	end if
////-----------------------------------------------------------------------------------------------------------
//
//
////--- Controllo se valori immessi nella ddw
////--- Sono su un campo DDW?
////	k_style=this.Describe("#" + trim(dwo.id)+".Edit.Style")
////	if k_style = "dddw" and trim(data) > " " then
////		
//////--- Attivo dw 
////		this.getchild(dwo.name, kdwc_1)
////		if isvalid(kdwc_1) then 
////	
////			if ki_db_conn_standard then
////				kdwc_1.settransobject(sqlca)
////			end if
////		
////			if kdwc_1.rowcount() > 0 then
////	
////				k_type = dwo.coltype
////				
////	//--- se i campi "data" e "display" della dddw sono uguali procede 		
////				if this.Describe(dwo.name +".DDDW.DataColumn") = this.Describe(dwo.name +".DDDW.DisplayColumn") then
////					k_return = 1
////					
////					k_ddw_campo = this.Describe(dwo.name +".DDDW.DataColumn")
////					if trim(k_ddw_campo) > " " then
////		//--- cerco se c'e' un valore simile a quello digitato
////						if Left(k_type,2) <> "ch" then
////							if isnull(data) then 
////								k_valore = "0"
////							else
////								k_valore = trim(data)
////							end if
////							k_find_riga=kdwc_1.Find ( k_ddw_campo + "="+k_valore, 1, kdwc_1.rowcount() )
////		//--- se non ho trovato un valore allora cerco per approssimazione
////							if k_find_riga <= 0 then
////								k_find_riga=kdwc_1.Find ( k_ddw_campo + ">="+k_valore, 1, kdwc_1.rowcount() )
////							end if
////						else
////							if isnull(data) then 
////								k_valore = " "
////							else
////								k_valore = trim(data)
////							end if
////							k_find_riga=kdwc_1.Find( k_ddw_campo + "=~""+k_valore+"~"", 1, kdwc_1.rowcount() )
////		//--- se non ho trovato un valore allora cerco per approssimazione
////							if k_find_riga <= 0 then
////								k_find_riga=kdwc_1.Find( k_ddw_campo + ">=~""+k_valore+"~"", 1, kdwc_1.rowcount() )
////							end if
////						end if
////		//--- se ho trovato un valore allora ok
////						if k_find_riga > 0 then
////							k_return = 2
////							if LeftA(k_type,2) <> "ch" then
////								k_rc=this.settext(trim(string(kdwc_1.getitemnumber(k_find_riga, k_ddw_campo))))
////								k_rc=this.setitem(row, integer(dwo.id), kdwc_1.getitemnumber(k_find_riga, k_ddw_campo))
////							else
////								k_valore = trim(kdwc_1.getitemstring(k_find_riga, k_ddw_campo))
////								k_rc=this.setitem(row, integer(dwo.id), k_valore)
////								k_rc=this.settext(k_valore)
////							end if
////						end if
////					end if
////				end if
////			end if
////			
////		end if
////
////	end if
//
//

	return k_return



end event

event losefocus;//
this.icon = ki_icona_normale
////
//
//if this.ki_attiva_DRAGDROP then 
//
////	st_barcode.visible = false
////	ki_dragdrop = false
//	this.drag(cancel!)
//	ki_in_DRAG = false		 
//	ki_riga_selected = 0	
//
//end if
//
end event

event constructor;//
kiuo_exception = create uo_exception
if trim(ki_icona_normale) > " " then
	this.icon = ki_icona_normale
end if
kidw_this = this

//ki_dataoggi_x = string(today())
ki_dragicon1 = "drag1.ico" //kGuo_path.get_risorse() + kkg.path_sep + "drag1.ico"
ki_dragicon2 = "drag2.ico" //kGuo_path.get_risorse() + kkg.path_sep + "drag2.ico"
this.dragicon = ""

set_flag_modalita(kkg_flag_modalita.visualizzazione)

if isvalid(parent) then
	kist_esito.nome_oggetto = parent.classname()
end if
kist_esito.sqlsyntax = ""
kist_esito.sqlerrtext = ""
kist_esito.sqldbcode = 0 

kiuf_ddw_grid = create kuf_ddw_grid
kiuf_link_zoom = create kuf_link_zoom

//--- costruisce oggetto x effetto EXCEL
kin_cst_PowerFilter = create n_cst_PowerFilter  
kin_cst_PowerFilter.of_SetLanguage(3)  //0-english, 1-French, 2-German, 3-Italian, 4-Brazilian Portuguese, 5-Russian 

//post event u_constructor()
event u_constructor()

post event u_constructor_post( )

end event

event dragdrop;//
string k_nome
long k_row, k_ret
//DragObject		do_control


//--- chiude eventuali DRAG & GDROP
if keydown(KeyEscape!) then
	event ue_dragdrop_end( )
end if

if TypeOf(source) <> datawindow! then return 0
kidw_dragdrop_source = source

if u_if_in_dragging( ) then
	
	if kidw_dragdrop_source.ki_UltRigaSel > 0 then
		k_row = kidw_dragdrop_source.ki_UltRigaSel
	else
		k_row = 1
	end if
	//this.scrolltorow( k_row)
					
//--- Drop qlc il quale non e' dal ns Datawindow
	IF kidw_dragdrop_source <> this THEN
		
//--- DataObjects  sono uguali (drop x DW UGUALI)
		IF Lower(kidw_dragdrop_source.dataobject) = Lower(this.dataobject) THEN
			k_ret = this.EVENT ue_DropFromSame(ki_riga_dragwithin, kidw_dragdrop_source)
		ELSE
//--- Noi Copiamo da un altro DW.. l'utente deve fare Copy stuff (drop ESTERNO)
			k_ret = this.event ue_drop_out(k_row, kidw_dragdrop_source) 
			if k_ret = 1 then
				kidw_dragdrop_source.event ue_drag_out(k_row, this)	
			end if
					
		END IF

	ELSE
//--- Drop stesso Datawindow (drop INTERNO )
		if ki_attiva_DRAGDROP_self and ki_riga_dragwithin > 0 then 
			k_ret = this.EVENT ue_DropFromThis(ki_riga_dragwithin, kidw_dragdrop_source)	
		end if
					
	END IF
end if

if ki_riga_dragwithin > 0 then 
	this.setrow(ki_riga_dragwithin)
end if
		
//--- AfterDrop e' sempre Fired
//	this.EVENT ue_AfterDrop(k_row)
//--- pulisco area del drag&drop
event ue_dragdrop_end( )

this.SetRedraw(true)



end event

event dragleave;//
//	if this.ki_attiva_DRAGDROP then 

		u_dragging_label_destroy()
		
		this.event ue_dragleave_post()

//	end if
		

end event

event dragwithin;//
string k_rcx

	
//if TypeOf(source) <> datawindow! then return 0
//kidw_dragdrop_source = source

//if u_if_in_dragging( ) then
	
	k_rcx = u_dragging_label_show() 
	
	if row = 0 then
	
	else
		
	//	if this = kidw_dragdrop_source then  // se dragging all'interno della stessa dw
			ki_riga_dragwithin = row
	
	//		if ki_attiva_DRAGDROP_self then
				u_drag_scroll(row) // scroll rows to show the dragging
	//		end if
	//	else
	//		u_drag_scroll(row) // scroll rows to show the dragging
	//	end if
	end if
//end if
		
	

end event

event retrievestart;//
//this.border = true
//this.borderstyle = StyleLowered!

this.transparency = 50

event u_personalizza_dw()

ki_last_dataobject = this.dataobject 

kipointer_orig = setpointer(HourGlass!)


end event

event retrieveend;//

this.transparency = ki_transparency
//this.border = ki_border
//this.borderstyle = StyleBox! //ki_borderstyle 

setpointer(kipointer_orig)


end event

event destructor;
//--- Se sono nel ciclo ciclo Drag&Drop cerca prima di uscire da quello poi Distrugge 
if ki_drag_scroll  then
	ki_drag_scroll=false
	post u_sleep(1)
end if
if isvalid(kin_cst_PowerFilter) then destroy kin_cst_PowerFilter
if isvalid(kiuf_menu_popup) then destroy kiuf_menu_popup
if isvalid(kiuo_exception) then destroy kiuo_exception

end event

event rowfocuschanged;//
// NON METTERE NIENTE QUIIIII!!!!
// MA SE SI DEVE LANCIARE LA SELEZIONE DELLA RIGA PENSARE COME AVVIENE E FARLO IN QUEl POSTO (NON PENSARE MALE!)

//u_selectrow (currentrow) questa istruzione fa casino!!

end event

event editchanged;//
// se abilitato mostra mentre si digita il primo valore completo che trova nel ddw
if ki_abilita_ddw_proposta then
	if len(trim(data)) > 2 then
		if isvalid(kiuf_ddw_grid) then kiuf_ddw_grid.u_editchanged(row, dwo, data)
	end if
end if

end event

event itemfocuschanged;// se abilitato mostra mentre si digita il primo valore completo che trova nel ddw
if ki_abilita_ddw_proposta then
	if isvalid(kiuf_ddw_grid) then kiuf_ddw_grid.u_itemfocuschanged(row, dwo)
end if

if this.Object.DataWindow.Processing = kki_tipo_processing_form and row > 0 &
			and (this.ki_flag_modalita = kkg_flag_modalita.modifica or this.ki_flag_modalita = kkg_flag_modalita.inserimento) then

	u_set_color_column_on_cursor(dwo.name, false)  // imposta colore di sfondo della colonna
	
end if
	
	
end event

event resize;//
if isvalid(kin_cst_PowerFilter) then
	if kin_cst_PowerFilter.checked then
		kin_cst_PowerFilter.event ue_positionbuttons()	
	end if
end if

post u_fine_primo_giro( )
//int k
//k=0
end event

event buttonclicked;//

this.accepttext()

end event

event error;//
if isvalid(kiuo_exception) then
else
	kiuo_exception = create uo_exception
end if
kist_esito = kiuo_exception.inizializza(this.classname())

if isvalid(this.getparent()) then
	kist_esito.nome_oggetto = parent.classname()
else
	kist_esito.nome_oggetto = classname()
end if
if errorobject > " " then 
	kist_esito.nome_oggetto += " Errorobject: " + trim(errorobject)
end if
kist_esito.nome_oggetto += " (dataobject: " + this.dataobject + ")"
kist_esito.sqlsyntax = trim(errortext)
kist_esito.sqlerrtext = trim(errortext) + " " + errorscript + " Line " + string(errorline)
kist_esito.sqldbcode = errornumber
kist_esito.sqlcode = -1

kist_esito.esito = kkg_esito.ko

kiuo_exception.u_errori_gestione(kist_esito)

if isvalid(kguo_exception) then kguo_exception.set_esito(kist_esito)

end event

