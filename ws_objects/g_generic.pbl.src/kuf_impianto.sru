$PBExportHeader$kuf_impianto.sru
forward
global type kuf_impianto from nonvisualobject
end type
end forward

global type kuf_impianto from nonvisualobject
end type
global kuf_impianto kuf_impianto

type variables

//--- Impianto di Trattamento
constant integer kki_impiantoG2 = 2  // Gamma 2
constant integer kki_impiantoG3 = 3  // Gamma 3
constant integer kki_impiantoDefault = 2

//--- Modalità Trattamento
constant integer kki_npass_2 = 2  // 2-Pass
constant integer kki_npass_4 = 4  // 4-Pass
constant integer kki_npass_default = 4


end variables

forward prototypes
public function string get_descr (integer a_impianto)
end prototypes

public function string get_descr (integer a_impianto);//		
string k_return
int k_rc
datastore kds_1


	kds_1 = create datastore
	kds_1.dataobject = "dd_impianto"
	kds_1.retrieve( )
	if kds_1.rowcount() > 0 then
		k_rc = kds_1.find("impianto = " + string(a_impianto), 1, kds_1.rowcount())
		if k_rc > 0 then
			k_return = kds_1.getitemstring(k_rc, "descr")
		end if
	end if
	if isvalid(kds_1) then destroy kds_1
	
return trim(k_return)

end function

on kuf_impianto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_impianto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

