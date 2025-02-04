$PBExportHeader$kuf_dw2xls.sru
forward
global type kuf_dw2xls from nonvisualobject
end type
end forward

global type kuf_dw2xls from nonvisualobject
end type
global kuf_dw2xls kuf_dw2xls

type variables
//
public:
string ki_is_sheet_name 
long ki_il_title_fg_color
boolean ki_ib_header = true
boolean ki_ib_background = false
boolean ki_ib_background_color = false
boolean ki_ib_group_header = false   //skip all group headers 
boolean ki_ib_group_trailer = false  //skip all group trailers 
boolean ki_ib_summary = false        //skip summary band 
boolean ki_ib_footer = false         //skip footer band 
boolean ki_ib_export_invisible = false //Switch On/Off export of invisible objects. Default is false
boolean ki_ib_show_progress = true 	//A boolean value which determines whether or not the progress bar should be displayed. Default is true.
boolean ki_ib_pictures = true 		//If true, then will export pictures. For OOXML format only. Default is false.

private:
n_dwr_service_parm kin_dwr_service_parm

end variables

forward prototypes
private subroutine u_set_parameter ()
public function boolean u_dw2xlsx (ref datawindow adw_1, string a_filename)
public function boolean u_ds2xlsx (ref datastore ads_1, string a_filename)
end prototypes

private subroutine u_set_parameter ();//
kin_dwr_service_parm.is_version = "OOXML"

kin_dwr_service_parm.ib_header = ki_ib_header
kin_dwr_service_parm.is_sheet_name = ki_is_sheet_name
kin_dwr_service_parm.il_title_fg_color = ki_il_title_fg_color
kin_dwr_service_parm.ib_background = ki_ib_background
kin_dwr_service_parm.ib_background_color = ki_ib_background_color
kin_dwr_service_parm.ib_group_header = ki_ib_group_header   //skip all group headers 
kin_dwr_service_parm.ib_group_trailer = ki_ib_group_trailer  //skip all group trailers 
kin_dwr_service_parm.ib_summary = ki_ib_summary        //skip summary band 
kin_dwr_service_parm.ib_footer = ki_ib_footer         //skip footer band 
kin_dwr_service_parm.ib_export_invisible = ki_ib_export_invisible //Switch On/Off export of invisible objects. Default is false
kin_dwr_service_parm.ib_show_progress = ki_ib_show_progress  //A boolean value which determines whether or not the progress bar should be displayed. Default is true.
kin_dwr_service_parm.ib_pictures = ki_ib_pictures        //If true, then will export pictures. For OOXML format only. Default is false.

end subroutine

public function boolean u_dw2xlsx (ref datawindow adw_1, string a_filename);/*
Genera XLSX da datastore
	Inp: ds con i dati da esportare
	Out: true = file generato
*/

	kguo_exception.inizializza(this.classname())

	u_set_parameter( )

//--- esportazione in EXCEL attraverso prodotto di terzi			
	if uf_save_dw_as_excel_parm(adw_1, a_filename, kin_dwr_service_parm) > 0 then
		return true
	else
		return false
	end if

end function

public function boolean u_ds2xlsx (ref datastore ads_1, string a_filename);/*
Genera XLSX da datastore
	Inp: ds con i dati da esportare
	Out: true = file generato
*/

	kguo_exception.inizializza(this.classname())

	u_set_parameter( )

//--- esportazione in EXCEL attraverso prodotto di terzi			
	if uf_save_ds_as_excel_parm(ads_1, a_filename, kin_dwr_service_parm) > 0 then
		return true
	else
		return false
	end if

end function

event constructor;//
ki_il_title_fg_color = kkg_colore.GIALLOSCURO
ki_is_sheet_name = "foglio_del_" + string(today(), "ddmmmyy") + "_ore_" + String(Now(), "hh:mm")

kin_dwr_service_parm = create n_dwr_service_parm
end event

on kuf_dw2xls.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_dw2xls.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//
if isvalid(kin_dwr_service_parm) then destroy kin_dwr_service_parm

end event

