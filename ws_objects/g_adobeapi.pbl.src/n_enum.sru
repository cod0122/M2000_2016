$PBExportHeader$n_enum.sru
forward
global type n_enum from nonvisualobject
end type
end forward

global type n_enum from nonvisualobject
end type
global n_enum n_enum

type variables
PRIVATE:
string name
integer code 
end variables

forward prototypes
public function string of_getname ()
public subroutine of_constructor (string as_name, integer ai_code)
public function integer of_getcode ()
end prototypes

public function string of_getname ();Return This.name
end function

public subroutine of_constructor (string as_name, integer ai_code);This.name = as_name
This.code = ai_code
end subroutine

public function integer of_getcode ();Return This.code
end function

on n_enum.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_enum.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

