$PBExportHeader$w_g_sort.srw
forward
global type w_g_sort from w_super
end type
type ddlb_3 from dropdownlistbox within w_g_sort
end type
type rb_a3 from radiobutton within w_g_sort
end type
type rb_d3 from radiobutton within w_g_sort
end type
type ddlb_2 from dropdownlistbox within w_g_sort
end type
type rb_a2 from radiobutton within w_g_sort
end type
type rb_d2 from radiobutton within w_g_sort
end type
type rb_d1 from radiobutton within w_g_sort
end type
type rb_a1 from radiobutton within w_g_sort
end type
type cb_cancle from commandbutton within w_g_sort
end type
type cb_ok from commandbutton within w_g_sort
end type
type ddlb_1 from dropdownlistbox within w_g_sort
end type
type gb_1 from groupbox within w_g_sort
end type
type gb_2 from groupbox within w_g_sort
end type
type gb_3 from groupbox within w_g_sort
end type
end forward

global type w_g_sort from w_super
integer width = 1760
integer height = 912
string title = "Ordina"
windowtype windowtype = response!
long backcolor = 32567536
boolean clientedge = true
boolean center = true
ddlb_3 ddlb_3
rb_a3 rb_a3
rb_d3 rb_d3
ddlb_2 ddlb_2
rb_a2 rb_a2
rb_d2 rb_d2
rb_d1 rb_d1
rb_a1 rb_a1
cb_cancle cb_cancle
cb_ok cb_ok
ddlb_1 ddlb_1
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_g_sort w_g_sort

type variables
//====================================================================
// Declare: Instance Variables()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: (none)
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

datawindow    idw_Parent
string  is_Columns[],is_ColTitle[]
end variables

on w_g_sort.create
int iCurrent
call super::create
this.ddlb_3=create ddlb_3
this.rb_a3=create rb_a3
this.rb_d3=create rb_d3
this.ddlb_2=create ddlb_2
this.rb_a2=create rb_a2
this.rb_d2=create rb_d2
this.rb_d1=create rb_d1
this.rb_a1=create rb_a1
this.cb_cancle=create cb_cancle
this.cb_ok=create cb_ok
this.ddlb_1=create ddlb_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_3
this.Control[iCurrent+2]=this.rb_a3
this.Control[iCurrent+3]=this.rb_d3
this.Control[iCurrent+4]=this.ddlb_2
this.Control[iCurrent+5]=this.rb_a2
this.Control[iCurrent+6]=this.rb_d2
this.Control[iCurrent+7]=this.rb_d1
this.Control[iCurrent+8]=this.rb_a1
this.Control[iCurrent+9]=this.cb_cancle
this.Control[iCurrent+10]=this.cb_ok
this.Control[iCurrent+11]=this.ddlb_1
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_2
this.Control[iCurrent+14]=this.gb_3
end on

on w_g_sort.destroy
call super::destroy
destroy(this.ddlb_3)
destroy(this.rb_a3)
destroy(this.rb_d3)
destroy(this.ddlb_2)
destroy(this.rb_a2)
destroy(this.rb_d2)
destroy(this.rb_d1)
destroy(this.rb_a1)
destroy(this.cb_cancle)
destroy(this.cb_ok)
destroy(this.ddlb_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event u_open_preliminari;call super::u_open_preliminari;//====================================================================
// Event: open()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: long [pbm_open]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Integer	 li_i,li_TotalCols,li_Count
String	ls_ColName,ls_Title

idw_Parent = ki_st_open_w.key12_any
If Not IsValid(idw_Parent) Then
	CLOSE(This)
	Return
End If
// Add the [None] option 	first.
ddlb_1.AddItem ("(none)")
ddlb_2.AddItem ("(none)")
ddlb_3.AddItem ("(none)")

// Populate the listbox with the column names.
// Convert the first column of the Current Sort to its display name.
li_TotalCols = Integer(idw_Parent.Describe("datawindow.column.count"))
For li_i = 1 To li_TotalCols
	// Populate the listbox with the column names.	
	ls_ColName = idw_Parent.Describe("#"+String(li_i)+".name")
	ls_Title = idw_Parent.Describe(ls_ColName+"_t.text")
	If ls_Title = '' Or ls_Title = '!' Or ls_Title = '?' Then Continue
	li_Count ++
	is_Columns[li_Count] = ls_ColName
	is_ColTitle[li_Count] = ls_Title
	ddlb_1.AddItem (ls_Title)
	ddlb_2.AddItem (ls_Title)
	ddlb_3.AddItem (ls_Title)
Next
//this.x = w_main.x + (w_main.width - this.width) / 2
//this.y = w_main.y + (w_main.height - this.height) / 3
this.visible = true

end event

event open;//
//this.move(29998, 30000)   // nasconde la window
	
//--- Recupera i parametri passati con il WITHPARM
	if isvalid(message.powerobjectparm) then 
		ki_st_open_w = message.powerobjectparm
	else
		ki_st_open_w.flag_adatta_win = kkg.adatta_win
		ki_st_open_w.flag_modalita = "" 
	end if
//--- Imposta il flag di Giro di 'prima Volta' x evitare alcuni controlli 
	ki_st_open_w.flag_primo_giro = "S"

	if ki_st_open_w.st_tab_menu_window.salva_controlli = "S" then
		ki_salva_controlli = true
	end if

	ki_nome_save = trim(this.ClassName())

//	post u_win_open( )

//--- Importante: personalizzazione x i figli	
	event u_open_preliminari()   

end event

type ddlb_3 from dropdownlistbox within w_g_sort
integer x = 82
integer y = 492
integer width = 539
integer height = 404
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32567536
boolean autohscroll = true
boolean sorted = false
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type rb_a3 from radiobutton within w_g_sort
integer x = 654
integer y = 496
integer width = 507
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8421504
long backcolor = 553648127
string text = "Ascendente"
boolean checked = true
end type

type rb_d3 from radiobutton within w_g_sort
integer x = 1161
integer y = 500
integer width = 535
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8421504
long backcolor = 553648127
string text = "Discendente"
end type

type ddlb_2 from dropdownlistbox within w_g_sort
integer x = 82
integer y = 276
integer width = 539
integer height = 404
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32567536
boolean autohscroll = true
boolean sorted = false
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type rb_a2 from radiobutton within w_g_sort
integer x = 654
integer y = 288
integer width = 507
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8421504
long backcolor = 553648127
string text = "Ascendente"
boolean checked = true
end type

type rb_d2 from radiobutton within w_g_sort
integer x = 1161
integer y = 288
integer width = 517
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8421504
long backcolor = 553648127
string text = "Discendente"
end type

type rb_d1 from radiobutton within w_g_sort
integer x = 1161
integer y = 100
integer width = 517
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8421504
long backcolor = 553648127
string text = "Discendente"
end type

type rb_a1 from radiobutton within w_g_sort
integer x = 654
integer y = 96
integer width = 507
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8421504
long backcolor = 553648127
string text = "Ascendente"
boolean checked = true
end type

type cb_cancle from commandbutton within w_g_sort
integer x = 1207
integer y = 652
integer width = 448
integer height = 120
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Annulla"
boolean cancel = true
end type

event clicked;//====================================================================
// Event: clicked()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: long [pbm_bnclicked]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Closewithreturn(parent ,"-1")
end event

type cb_ok from commandbutton within w_g_sort
integer x = 745
integer y = 652
integer width = 448
integer height = 120
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Esegui"
boolean default = true
end type

event clicked;//====================================================================
// Event: clicked()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: long [pbm_bnclicked]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

String 	ls_Sort[3],ls_SortStr
String	ls_Column[3]
Integer	li_i,li_Control, li_max_row
radiobutton   lrb_a[3]
dropdownlistbox  lddlb[3]

lrb_a[1]  = rb_a1
lrb_a[2]  = rb_a2
lrb_a[3]  = rb_a3
lddlb[1] = ddlb_1
lddlb[2] = ddlb_2
lddlb[3] = ddlb_3

For li_Control = 1 To 3
	// Get the new column to sort (if any)
	ls_Column[li_Control] = lddlb[li_Control].Text
	
	If ls_Column[li_Control] = '(none)' Or ls_Column[li_Control] = "" Then
		// None was picked.
		If li_Control = 1 Then
			MessageBox("Sort","The sort reference is not valid. Make sure that the first Sort By box isn't blank.",exclamation!)
			Return
		ElseIf li_Control = 2 Then
			If ddlb_3.Text <> '(none)' And ddlb_3.Text <> '' Then
				MessageBox("Sort","The sort reference is not valid. Make sure that the second Sort By box isn't blank.",exclamation!)
				Return
			End If
		End If
		Continue
		
		ls_Sort[li_Control] = ""
	Else
		For li_i = 1 To UpperBound(is_Columns)
			If ls_Column[li_Control] = is_ColTitle[li_i] Then
				ls_Column[li_Control] = is_Columns[li_i]
				Exit
			End If
		Next
		
		If li_Control = 2 Then
			If ls_Column[2]  = ls_Column[1] Then
				MessageBox("Sort","The sort reference is not valid. Make sure that the first and second Sort By boxes aren't the same.",exclamation!)
				Return
			End If
		ElseIf li_Control = 3 Then
			If ls_Column[3]  = ls_Column[1]  Then
				MessageBox("Sort","The sort reference is not valid. Make sure that the first and third Sort By boxes aren't the same.",exclamation!)
				Return
			ElseIf ls_Column[3]  = ls_Column[2]  Then
				MessageBox("Sort","The sort reference is not valid. Make sure that the second and third Sort By boxes aren't the same.",exclamation!)
				Return
			End If
		End If
		// An actual column was picked.
		ls_Sort[li_Control] = ls_Column[li_Control] + " "
		// Ascending or Descending?
		If lrb_a[li_Control].Checked = True Then
			ls_Sort[li_Control] = ls_Sort[li_Control] + "A"
		Else
			ls_Sort[li_Control] = ls_Sort[li_Control] + "D"
		End If
	End If
	ls_SortStr += ls_Sort[li_Control]+","
Next

If Right(ls_SortStr,1) = ',' Then
	ls_SortStr = Left(ls_SortStr,Len(ls_SortStr) - 1)
End If

idw_Parent.SetSort(ls_SortStr)
idw_Parent.Sort()

//li_i = f_get_selectedrow(idw_Parent)
li_max_row = idw_Parent.RowCount()
for li_i = 1 to li_max_row
	If idw_Parent.IsSelected(li_i) Then
		exit
	end if
Next
If idw_Parent.IsSelected(li_i) Then
	idw_Parent.ScrollToRow(li_i)
else
	idw_Parent.ScrollToRow(1)
end if
CloseWithReturn(Parent ,ls_SortStr)

end event

type ddlb_1 from dropdownlistbox within w_g_sort
integer x = 82
integer y = 84
integer width = 539
integer height = 404
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32567536
boolean autohscroll = true
boolean sorted = false
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_g_sort
integer x = 41
integer y = 20
integer width = 1623
integer height = 188
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 553648127
string text = " Ordina per "
end type

type gb_2 from groupbox within w_g_sort
integer x = 41
integer y = 212
integer width = 1623
integer height = 188
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 553648127
string text = " poi per "
end type

type gb_3 from groupbox within w_g_sort
integer x = 41
integer y = 428
integer width = 1623
integer height = 188
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 553648127
string text = " poi per "
end type

