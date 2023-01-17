$PBExportHeader$kds_e1_f5537001.sru
forward
global type kds_e1_f5537001 from kds_e1_asn
end type
end forward

global type kds_e1_f5537001 from kds_e1_asn
string dataobject = "ds_e1_f5537001"
end type
global kds_e1_f5537001 kds_e1_f5537001

forward prototypes
public function integer u_update () throws uo_exception
end prototypes

public function integer u_update () throws uo_exception;//-------------------------------------------------------------------------------
//--- Registra su tab i dati di lavorazione su E1
//--- 
//--- datastore con i dati da registrare in tabella E1
//--- 
//--- Rit: come UPDATE (-1 = ERRORE GRAVE)
//--- lancia exception x errore grave
//-------------------------------------------------------------------------------
int k_return = 0


try
	this.db_connetti( )
	
	k_return = update( )
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

on kds_e1_f5537001.create
call super::create
end on

on kds_e1_f5537001.destroy
call super::destroy
end on

