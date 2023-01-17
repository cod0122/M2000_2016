$PBExportHeader$w_g_response3.srw
forward
global type w_g_response3 from w_super
end type
type rb_opt3 from radiobutton within w_g_response3
end type
type rb_opt2 from radiobutton within w_g_response3
end type
type rb_opt1 from radiobutton within w_g_response3
end type
type cb_cancel from commandbutton within w_g_response3
end type
type cb_ok from commandbutton within w_g_response3
end type
type gb_opt from groupbox within w_g_response3
end type
end forward

global type w_g_response3 from w_super
integer width = 1847
integer height = 768
string menuname = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 32567536
boolean center = true
integer transparency = 10
integer animationtime = 50
rb_opt3 rb_opt3
rb_opt2 rb_opt2
rb_opt1 rb_opt1
cb_cancel cb_cancel
cb_ok cb_ok
gb_opt gb_opt
end type
global w_g_response3 w_g_response3

type variables
//
kuf_response3 kiuf_response3

end variables

forward prototypes
protected subroutine u_resize_1 ()
end prototypes

protected subroutine u_resize_1 ();//
gb_opt.x = 1
gb_opt.y = 1
gb_opt.width = this.width //- 90
gb_opt.height = this.height //- 90

end subroutine

on w_g_response3.create
int iCurrent
call super::create
this.rb_opt3=create rb_opt3
this.rb_opt2=create rb_opt2
this.rb_opt1=create rb_opt1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.gb_opt=create gb_opt
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_opt3
this.Control[iCurrent+2]=this.rb_opt2
this.Control[iCurrent+3]=this.rb_opt1
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.gb_opt
end on

on w_g_response3.destroy
call super::destroy
destroy(this.rb_opt3)
destroy(this.rb_opt2)
destroy(this.rb_opt1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.gb_opt)
end on

event u_open_preliminari;call super::u_open_preliminari;//====================================================================
// Event: open()
//====================================================================
//
	kiuf_response3 = ki_st_open_w.key12_any

//Integer	 li_i,li_TotalCols,li_Count
//String	ls_ColName,ls_Title
//
//idw_Parent = ki_st_open_w.key12_any
//If Not IsValid(idw_Parent) Then
//	CLOSE(This)
//	Return
//End If
//// Add the [None] option 	first.
//ddlb_1.AddItem ("(none)")
//ddlb_2.AddItem ("(none)")
//ddlb_3.AddItem ("(none)")
//
//// Populate the listbox with the column names.
//// Convert the first column of the Current Sort to its display name.
//li_TotalCols = Integer(idw_Parent.Describe("datawindow.column.count"))
//For li_i = 1 To li_TotalCols
//	// Populate the listbox with the column names.	
//	ls_ColName = idw_Parent.Describe("#"+String(li_i)+".name")
//	ls_Title = idw_Parent.Describe(ls_ColName+"_t.text")
//	If ls_Title = '' Or ls_Title = '!' Or ls_Title = '?' Then Continue
//	li_Count ++
//	is_Columns[li_Count] = ls_ColName
//	is_ColTitle[li_Count] = ls_Title
//	ddlb_1.AddItem (ls_Title)
//	ddlb_2.AddItem (ls_Title)
//	ddlb_3.AddItem (ls_Title)
//Next
////this.x = w_main.x + (w_main.width - this.width) / 2
////this.y = w_main.y + (w_main.height - this.height) / 3
//this.visible = true

end event

event u_open;call super::u_open;//
environment kenv
integer k_rtn


	this.title = kiuf_response3.kist_response3.title
	if kiuf_response3.kist_response3.option_1 > " " then
		rb_opt1.text = kiuf_response3.kist_response3.option_1
		rb_opt1.visible = true
	end if
	if kiuf_response3.kist_response3.option_2 > " " then
		rb_opt2.text = kiuf_response3.kist_response3.option_2
		rb_opt2.visible = true
	end if
	if kiuf_response3.kist_response3.option_3 > " " then
		rb_opt3.text = kiuf_response3.kist_response3.option_3
		rb_opt3.visible = true
	end if

	if kiuf_response3.kist_response3.option_default > 0 then
		choose case kiuf_response3.kist_response3.option_default
			case 1
				rb_opt1.checked = true
			case 2
				rb_opt2.checked = true
			case 3
				rb_opt3.checked = true
		end choose
	end if
	
	if kiuf_response3.kist_response3.b_cancel > " " then
		cb_cancel.text = cb_cancel.text + kiuf_response3.kist_response3.b_cancel
		cb_cancel.visible = true
	end if
	if kiuf_response3.kist_response3.b_ok > " " then
		cb_ok.text = "&" + kiuf_response3.kist_response3.b_ok
	end if
	cb_ok.visible = true
	
	k_rtn = GetEnvironment(kenv)
	if k_rtn = 1 then
//		this.x = (PixelsToUnits(kenv.ScreenWidth, XPixelsToUnits!) - this.width) / 2 
//		this.y = (PixelsToUnits(kenv.ScreenHeight, YPixelsToUnits!) - this.height) / 2 
      this.x = w_main.x + (w_main.width - this.width) / 2
      this.y = w_main.y + (w_main.Height - this.height) / 2
	else
		this.move( 1, 1)
	end if
	this.visible = true
	this.bringtotop = true



end event

type rb_opt3 from radiobutton within w_g_response3
boolean visible = false
integer x = 105
integer y = 360
integer width = 1481
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8421504
long backcolor = 553648127
string text = "Option 3"
end type

type rb_opt2 from radiobutton within w_g_response3
boolean visible = false
integer x = 105
integer y = 228
integer width = 1481
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8421504
long backcolor = 553648127
string text = "Option 2"
end type

type rb_opt1 from radiobutton within w_g_response3
boolean visible = false
integer x = 105
integer y = 96
integer width = 1481
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8421504
long backcolor = 553648127
string text = "Option 1"
end type

type cb_cancel from commandbutton within w_g_response3
boolean visible = false
integer x = 489
integer y = 532
integer width = 448
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&"
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

kiuf_response3.kist_response3.option_choosed = kiuf_response3.kki_opt_cancel

Closewithreturn(parent , string(kiuf_response3.kist_response3.option_choosed))
end event

type cb_ok from commandbutton within w_g_response3
boolean visible = false
integer x = 27
integer y = 532
integer width = 448
integer height = 104
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Ok"
boolean default = true
end type

event clicked;//====================================================================
// Event: clicked()
//====================================================================

Integer	li_Control
radiobutton   lrb[3]

lrb[1]  = rb_opt1
lrb[2]  = rb_opt2
lrb[3]  = rb_opt3

For li_Control = 1 To 3
	
	If lrb[li_Control].Checked Then
		kiuf_response3.kist_response3.option_choosed = li_Control
	end if
Next

CloseWithReturn(Parent ,kiuf_response3.kist_response3.option_choosed)

end event

type gb_opt from groupbox within w_g_response3
boolean visible = false
integer x = 14
integer width = 1806
integer height = 492
integer taborder = 10
integer transparency = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 553648127
end type

