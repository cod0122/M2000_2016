$PBExportHeader$kuf_e1_f5537001.sru
forward
global type kuf_e1_f5537001 from kuf_parent
end type
end forward

global type kuf_e1_f5537001 from kuf_parent
end type
global kuf_e1_f5537001 kuf_e1_f5537001

type variables
////
////--- Stato richiesto da E1 per la comunicazione del tipo operazione
//constant string kki_stato_ev01_firstLoad = "1"		//primo barcode di inzio lav
//constant string kki_stato_ev01_lastLoad = "2"			//ultimo barcode inizio lav
//constant string kki_stato_ev01_firstUnload = "3" 	//primo barcode trattato
//constant string kki_stato_ev01_lastUnload = "4"  	//ultimo barcode trattato
//constant string kki_stato_ev01_QTdata = "5"   		//dati dosimetrici lotto
//
end variables

forward prototypes
public subroutine _readme ()
public function boolean if_esiste (st_tab_f5537001 kst_tab_f5537001) throws uo_exception
public subroutine if_isnull (ref st_tab_f5537001 kst_tab_f5537001)
public function integer set_datilav_f5537001 (st_tab_f5537001 kst_tab_f5537001) throws uo_exception
end prototypes

public subroutine _readme ();//
//--- Oggetto per configurare i dati di Work Order su E1 
//--- passare dati per il progetto 'Cube Interface' (n. barcode giri e n. padri di Lavorazione)
//
end subroutine

public function boolean if_esiste (st_tab_f5537001 kst_tab_f5537001) throws uo_exception;//
//------------------------------------------------------------------------------------
//--- Verifica la presenza del rec
//--- 
//--- inp: st_tab_f5537001 MPDOCO (WO) 
//--- out:
//--- Ritorna: TRUE = riga trovata
//--- lancia exception x errore grave
//------------------------------------------------------------------------------------
boolean k_return=false
int k_trovato
st_esito kst_esito
kds_e1_f5537001_ifesiste kds1_e1_f5537001_ifesiste


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	kds1_e1_f5537001_ifesiste = create kds_e1_f5537001_ifesiste
	
	kds1_e1_f5537001_ifesiste.db_connetti( )
	
	if kst_tab_f5537001.MPDOCO > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = k_trovato
		kst_esito.SQLErrText = "Verifica presenza in tab. E1 'F5537001' (dati trattamento n. di barcode, giri e padri), mancano i dati per la ricerca del codice WO e tipo operazione'."
		kguo_exception.inizializza()
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if

	k_trovato = kds1_e1_f5537001_ifesiste.retrieve(kst_tab_f5537001.MPDOCO, kst_tab_f5537001.MPAURST1)

	if k_trovato < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = k_trovato
		kst_esito.SQLErrText = "Verifica presenza in tab. E1 'F5537001' (dati trattamento n. di barcode, giri e padri) fallita'. ~n~rWO (MPDOCO): " &
									  + string(kst_tab_f5537001.MPDOCO) + " / " &
									  + trim(kst_tab_f5537001.MPAURST1)
		kguo_exception.inizializza()
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if

	if k_trovato > 0 then
		k_return = true
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kds1_e1_f5537001_ifesiste) then destroy kds1_e1_f5537001_ifesiste
	
end try

return k_return

end function

public subroutine if_isnull (ref st_tab_f5537001 kst_tab_f5537001);//
if isnull(kst_tab_f5537001.MPDOCO) then kst_tab_f5537001.MPDOCO = 0		//work order
if isnull(kst_tab_f5537001.MPAURST1) then kst_tab_f5537001.MPAURST1 = "" 
if isnull(kst_tab_f5537001.MPMMCU) then kst_tab_f5537001.MPMMCU = "" 
if isnull(kst_tab_f5537001.MPUORG) then kst_tab_f5537001.MPUORG = 0
if isnull(kst_tab_f5537001.MPMATH06) then kst_tab_f5537001.MPMATH06 = 0
if isnull(kst_tab_f5537001.MPMATH07) then kst_tab_f5537001.MPMATH07 = 0
if isnull(kst_tab_f5537001.MPMATH08) then kst_tab_f5537001.MPMATH08 = 0

end subroutine

public function integer set_datilav_f5537001 (st_tab_f5537001 kst_tab_f5537001) throws uo_exception;//
//------------------------------------------------------------------------------------
//--- Registra i dati per E1 circa il progetto 'Cube Interface' ovvero
//--- 			tempi di lavorazione n. padri ecc...
//--- 
//--- inp: st_tab_f5537001 
//--- out:
//--- Ritorna: nr righe aggiornate
//--- lancia exception x errore grave
//------------------------------------------------------------------------------------
int k_return
st_esito kst_esito
kds_e1_f5537001 kds1_e1_f5537001


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	kds1_e1_f5537001 = create kds_e1_f5537001
	
	kds1_e1_f5537001.db_connetti( )
	kds1_e1_f5537001.reset( )
	kds1_e1_f5537001.insertrow(0)
	
	if_isnull(kst_tab_f5537001)
	
	kds1_e1_f5537001.setitem(1, "MPDOCO", kst_tab_f5537001.MPDOCO)		//work order
	kds1_e1_f5537001.setitem(1, "MPAURST1", kst_tab_f5537001.MPAURST1)  	
	kds1_e1_f5537001.setitem(1, "MPMMCU", kst_tab_f5537001.MPMMCU)  	
	kds1_e1_f5537001.setitem(1, "MPUORG", kst_tab_f5537001.MPUORG)  	
	kds1_e1_f5537001.setitem(1, "MPMATH06", kst_tab_f5537001.MPMATH06)  	
	kds1_e1_f5537001.setitem(1, "MPMATH07", kst_tab_f5537001.MPMATH07)  	
	kds1_e1_f5537001.setitem(1, "MPMATH08", kst_tab_f5537001.MPMATH08)  	

	k_return = kds1_e1_f5537001.u_update()
	if k_return < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = k_return
		kst_esito.SQLErrText = "Aggiornamento fallito ('Cube Interface') per scambio dati con E1 'F5537001'. ~n~rWO (MPDOCO): "+string(kst_tab_f5537001.MPDOCO)
		kguo_exception.inizializza()
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if
	
	if kst_tab_f5537001.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_f5537001.st_tab_g_0.esegui_commit) then
		kds1_e1_f5537001.db_commit( )
	end if

catch (uo_exception kuo_exception)
	if kst_tab_f5537001.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_f5537001.st_tab_g_0.esegui_commit) then
		kds1_e1_f5537001.db_rollback( )
	end if
	throw kuo_exception

finally
	if isvalid(kds1_e1_f5537001) then destroy kds1_e1_f5537001
	
end try

return k_return

end function

on kuf_e1_f5537001.create
call super::create
end on

on kuf_e1_f5537001.destroy
call super::destroy
end on

