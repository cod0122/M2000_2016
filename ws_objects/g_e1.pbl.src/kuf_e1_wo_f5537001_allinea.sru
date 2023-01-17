$PBExportHeader$kuf_e1_wo_f5537001_allinea.sru
forward
global type kuf_e1_wo_f5537001_allinea from kuf_e1_wo_f5537001
end type
end forward

global type kuf_e1_wo_f5537001_allinea from kuf_e1_wo_f5537001
end type
global kuf_e1_wo_f5537001_allinea kuf_e1_wo_f5537001_allinea

forward prototypes
public function st_esito u_batch_run () throws uo_exception
end prototypes

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
int k_ctr
st_esito kst_esito


try 

	kst_esito = kguo_exception.inizializza(this.classname())

//--- Allinea dati trattamento/dosimetria con E1
	k_ctr = u_allinea_datilav_e1( )
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Operazione conclusa correttamente." &
					+ "Sono stati ripristinati " + string(k_ctr) + " record dati in tabella di appoggio 'Cube Interface' (n.giri e padri di irraggiamento) inviati in precedenza al Sistema E-ONE" 
	else
		kst_esito.SQLErrText = "Operazione conclusa. Nessun dato di n.giri e padri di 'irraggiamento' inviato per ripristino a E-ONE."
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

on kuf_e1_wo_f5537001_allinea.create
call super::create
end on

on kuf_e1_wo_f5537001_allinea.destroy
call super::destroy
end on

