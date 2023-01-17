$PBExportHeader$kuf_barcode_asd.sru
forward
global type kuf_barcode_asd from kuf_parent0
end type
end forward

global type kuf_barcode_asd from kuf_parent0
end type
global kuf_barcode_asd kuf_barcode_asd

forward prototypes
public function uo_ds_std_1 get_barcode_rackcode_not_in_pl_barcode (st_tab_barcode ast_tab_barcode) throws uo_exception
end prototypes

public function uo_ds_std_1 get_barcode_rackcode_not_in_pl_barcode (st_tab_barcode ast_tab_barcode) throws uo_exception;/*
Torna un DS con i barcode associati al Rack senza Pianificazione 
inp: st_tab_barcode.pl_barcode 
rit: datastore con elenco barcode ancora da mettere sul PL (fare if isvalid(kds_1) prima di verificare)
*/
int k_rows
uo_ds_std_1 kds_1


try
	kds_1 = create uo_ds_std_1
	kds_1.dataobject = "ds_get_barcode_rackcode_not_in_pl_barcode"

	if ast_tab_barcode.pl_barcode > 0 then
		kds_1.settransobject( kguo_sqlca_db_magazzino )
		
		k_rows = kds_1.retrieve( ast_tab_barcode.pl_barcode)
		
		//--- se ci sono righe allora ci sono barcode ancora fuori pianificazione
		if k_rows > 0 then
			
				
		else
			
			if k_rows < 0 then
				
				kguo_exception.inizializza(this.classname())
				kguo_exception.kist_esito.esito = kkg_esito.db_ko
				kguo_exception.kist_esito.sqlerrtext = "Errore in Lettura dei Barcode asscociati al Rack ma a cui manca la Pianificazione id '" + string(ast_tab_barcode.pl_barcode) + "' " &
								+ kds_1.kist_esito.sqlerrtext + " (" + string(kds_1.kist_esito.sqlcode) + ")"
				throw kguo_exception

			end if
			
		end if
		
	end if
	
catch (uo_exception kuo_exception)
		throw kuo_exception
	
finally
	//if isvalid(kds_1) then destroy kds_1
	
end try

return kds_1 

end function

on kuf_barcode_asd.create
call super::create
end on

on kuf_barcode_asd.destroy
call super::destroy
end on

