$PBExportHeader$kuf_response3.sru
forward
global type kuf_response3 from nonvisualobject
end type
end forward

global type kuf_response3 from nonvisualobject
end type
global kuf_response3 kuf_response3

type variables
public:
//--- Varibile di stato che indica la modalita' x la quale sto esponendo le FILE
constant int kki_opt_cancel=0
constant int kki_opt_choosed_1=1
constant int kki_opt_choosed_2=2
constant int kki_opt_choosed_3=2

st_response3 kist_response3

end variables

forward prototypes
public subroutine _readme ()
public function integer u_open ()
end prototypes

public subroutine _readme ();//
//--- Windows RESPONSE con la scelta di 3 opzioni
//--- in apertura passare le opzioni da visualizzare
//--- in chiusura torna l'opzione scelta
//
end subroutine

public function integer u_open ();//
st_open_w k_st_open_w

k_st_open_w.key12_any = this
return openwithparm(w_g_response3, k_st_open_w)

end function

on kuf_response3.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_response3.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

