$PBExportHeader$kuf_e1_wo_f5537001.sru
forward
global type kuf_e1_wo_f5537001 from kuf_parent
end type
end forward

global type kuf_e1_wo_f5537001 from kuf_parent
end type
global kuf_e1_wo_f5537001 kuf_e1_wo_f5537001

type variables

end variables

forward prototypes
public subroutine _readme ()
public function integer u_set_datilav_toe1 () throws uo_exception
public function integer u_allinea_datilav_e1 () throws uo_exception
public function st_esito u_batch_run () throws uo_exception
public function boolean if_esiste (st_tab_e1_wo_f5537001 kst_tab_e1_wo_f5537001) throws uo_exception
public subroutine if_isnull (ref st_tab_e1_wo_f5537001 kst_tab_e1_wo_f5537001)
public function integer set_datilav_f5537001 (st_tab_e1_wo_f5537001 kst_tab_e1_wo_f5537001) throws uo_exception
public function boolean tb_delete (readonly st_tab_e1_wo_f5537001 ast_tab_e1_wo_f5537001) throws uo_exception
public function boolean u_get_e1updts (ref st_tab_e1_wo_f5537001 ast_tab_e1_wo_f5537001) throws uo_exception
end prototypes

public subroutine _readme ();//
//--- Oggetto collettore per lo scambio dati con il Work Order su E1 
//--- passa dati di Lavorazione per il progetto 'Cube Interface' (n.barcode con indicazione GIRI e PADRI)
//--- gestisce la tabella sul db interno 
end subroutine

public function integer u_set_datilav_toe1 () throws uo_exception;//
//------------------------------------------------------------------------------------------------
//--- Invia tutti i dati in sospeso a E1 circa il progetto 'Cube Interface' 
//---        tempi di lavorazione, n.padri ecc...
//--- 
//--- inp: 
//--- out:
//--- Ritorna: nr righe aggiornate
//--- lancia exception x errore grave
//------------------------------------------------------------------------------------------------
int k_return, k_rc
long k_righe_tot, k_riga
string k_string
st_esito kst_esito
st_tab_e1_wo_f5537001 kst_tab_e1_wo_f5537001
st_tab_f5537001 kst_tab_f5537001, kst1_tab_f5537001
kuf_e1_f5537001 kuf1_e1_f5537001
datastore kds_e1_wo_f5537001_l_xe1


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	kuf1_e1_f5537001 = create kuf_e1_f5537001
	
	kds_e1_wo_f5537001_l_xe1 = create datastore
	kds_e1_wo_f5537001_l_xe1.dataobject = "ds_e1_wo_f5537001_l_xe1"
	kds_e1_wo_f5537001_l_xe1.settransobject(kguo_sqlca_db_magazzino)
	k_righe_tot = kds_e1_wo_f5537001_l_xe1.retrieve( )
	
	kst_tab_e1_wo_f5537001.e1updts = kGuf_data_base.prendi_dataora( )
	
	for k_riga = 1 to k_righe_tot

		kst_tab_f5537001.MPDOCO = kds_e1_wo_f5537001_l_xe1.getitemnumber(k_riga, "MPDOCO")		//work order
		kst_tab_f5537001.MPAURST1 = kds_e1_wo_f5537001_l_xe1.getitemstring(k_riga, "MPAURST1") 
		kst_tab_f5537001.MPMMCU = kds_e1_wo_f5537001_l_xe1.getitemstring(k_riga, "MPMMCU") 
		kst_tab_f5537001.MPUORG = kds_e1_wo_f5537001_l_xe1.getitemnumber(k_riga, "MPUORG") 
		kst_tab_f5537001.MPMATH06 = kds_e1_wo_f5537001_l_xe1.getitemnumber(k_riga, "MPMATH06") 
		kst_tab_f5537001.MPMATH07 = kds_e1_wo_f5537001_l_xe1.getitemnumber(k_riga, "MPMATH07") 
		kst_tab_f5537001.MPMATH08 = kds_e1_wo_f5537001_l_xe1.getitemnumber(k_riga, "MPMATH08") 

//--- passo al processo di aggiornamento solo se sono su un record nuovo
		if kst_tab_f5537001.MPDOCO = kst1_tab_f5537001.MPDOCO and kst_tab_f5537001.MPAURST1 = kst1_tab_f5537001.MPAURST1 then
		else			
			kst1_tab_f5537001 = kst_tab_f5537001  // salva i dati per il controllo di cui sopra
				
			if not kuf1_e1_f5537001.if_esiste(kst_tab_f5537001) then
				try
					
					//--- Effettivo aggiornamento dei dati su E1
					kst_tab_f5537001.st_tab_g_0.esegui_commit = "N"
					kuf1_e1_f5537001.set_datilav_f5537001(kst_tab_f5537001)
			
					kds_e1_wo_f5537001_l_xe1.setitem(k_riga, "e1updts", kst_tab_e1_wo_f5537001.e1updts)	//data di aggiornamento a E1
			
					k_rc = kds_e1_wo_f5537001_l_xe1.update()
			
					if k_rc < 0 then
						kst_esito.esito = kkg_esito.db_ko
						kst_esito.sqlcode = k_return
						kst_esito.SQLErrText = "Aggiornamento data fallito in tabella appoggio dati trattamento 'Cube Interface' (n.barcode, giri e padri) per E1 'e1_wo_f5537001' ma dati E1 inviati correttamente. ~n~rWO (MPDOCO): "+string(kst_tab_e1_wo_f5537001.MPDOCO)
						kguo_exception.inizializza()
						kguo_exception.set_esito (kst_esito)
						//throw kguo_exception
					end if
		
				catch (uo_exception kuo1_exception)
					
				
				finally
					kguo_sqlca_db_e1.db_commit( )
					kguo_sqlca_db_magazzino.db_commit( )
					k_return ++
				
				end try
			end if		
		end if		

	end for

	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_e1_f5537001) then destroy kuf1_e1_f5537001
	if isvalid(kds_e1_wo_f5537001_l_xe1) then destroy kds_e1_wo_f5537001_l_xe1
	
end try

return k_return

end function

public function integer u_allinea_datilav_e1 () throws uo_exception;//
//------------------------------------------------------------------------------------------------
//--- Riallinea la data di aggiornamento a E1 rileggendo i dati di Lavorazione inviati a E1
//---            per il Progetto 'Cube Interface'
//--- 
//--- inp: 
//--- out:
//--- Ritorna: nr righe aggiornate
//--- lancia exception x errore grave
//------------------------------------------------------------------------------------------------
int k_return, k_rc, k_gg
long k_righe_tot, k_riga
string k_dato
date k_data_ini
boolean k_aggiorna = false
st_esito kst_esito
st_tab_e1_wo_f5537001 kst_tab_e1_wo_f5537001
st_tab_f5537001 kst_tab_f5537001
kuf_e1_f5537001 kuf1_e1_f5537001
kuf_base kuf1_base
datastore kds_e1_wo_f5537001_l_xdt


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
//--- recupera il num gg indietro da cui partire per l'elaborazione 	
	kuf1_base = create kuf_base
	k_dato = kuf1_base.prendi_dato_base("e1dtlav_allineagg")
	if left(k_dato,1) <> "0" then
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = mid(k_dato,2)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		k_gg	= integer(mid(k_dato,2))
		if k_gg > 30 then // superiore a 30 sembrano un po' troppi!!
			k_gg = 30
		end if
	end if
	if isvalid(kuf1_base) then destroy kuf1_base 

	if k_gg > 0 then
		k_data_ini = relativedate(kguo_g.get_dataoggi( ), (-1 * k_gg))  // levo i giorni indicati in Proprietà
	else
		k_data_ini = kguo_g.get_dataoggi( )
	end if
	
	kuf1_e1_f5537001 = create kuf_e1_f5537001
	
	kds_e1_wo_f5537001_l_xdt = create datastore
	kds_e1_wo_f5537001_l_xdt.dataobject = "ds_e1_wo_f5537001_l_xdt"
	kds_e1_wo_f5537001_l_xdt.settransobject(kguo_sqlca_db_magazzino)
	k_righe_tot = kds_e1_wo_f5537001_l_xdt.retrieve(k_data_ini)
	
	
	for k_riga = 1 to k_righe_tot

		k_aggiorna = false
		kst_tab_e1_wo_f5537001.e1updts = kds_e1_wo_f5537001_l_xdt.getitemdatetime(k_riga, "e1updts")  	//ts di aggiornamento dei dati su E1

		kst_tab_f5537001.MPDOCO = kds_e1_wo_f5537001_l_xdt.getitemnumber(k_riga, "MPDOCO")		//work order
		kst_tab_f5537001.mpaurst1 = kds_e1_wo_f5537001_l_xdt.getitemstring(k_riga, "mpaurst1")		//line A/B/C
//--- Verifica se i dati di lavorazione sono stati passati a E1
		if kuf1_e1_f5537001.if_esiste(kst_tab_f5537001) then
//--- se dati passati e update NON effettuato (mooooolto strano) allora forza l'update in tab M2000		
			if date(kst_tab_e1_wo_f5537001.e1updts) > kkg.DATA_NO then
			else
				k_aggiorna = true
				kst_tab_e1_wo_f5537001.e1updts = kGuf_data_base.prendi_dataora( )  // forza ts adesso!
			end if
		else
//--- se dati NON passati a E1 allora ripulisce il campo di update in tab M2000			
			if date(kst_tab_e1_wo_f5537001.e1updts) > kkg.DATA_NO then
				k_aggiorna = true
				kst_tab_e1_wo_f5537001.e1updts = datetime(date(0))  // forza ts a zero!
			end if
		end if

//--- data da aggiornare?
		if k_aggiorna then
	
			kds_e1_wo_f5537001_l_xdt.setitem(k_riga, "e1updts", kst_tab_e1_wo_f5537001.e1updts)	//data di aggiornamento a E1
	
			k_rc = kds_e1_wo_f5537001_l_xdt.update()
	
			if k_rc < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = k_return
				kst_esito.SQLErrText = "Aggiornamento data fallito in tabella di appoggio dati lavorazione per E1 'e1_wo_F5537001' ma dati E1 inviati correttamente. ~n~rWO (doco): "+string(kst_tab_e1_wo_f5537001.MPDOCO)
				kguo_exception.inizializza()
				kguo_exception.set_esito (kst_esito)
				//throw kguo_exception
			else
				k_return ++ // record aggiornati
			end if


		end if
		
	end for

	kguo_sqlca_db_magazzino.db_commit( )

	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_e1_f5537001) then destroy kuf1_e1_f5537001
	if isvalid(kds_e1_wo_f5537001_l_xdt) then destroy kds_e1_wo_f5537001_l_xdt
	
end try

return k_return

end function

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
int k_ctr
st_esito kst_esito


try 

	kst_esito = kguo_exception.inizializza(this.classname())

//--- Invio dati trattamento/dosimetria a E1
	k_ctr = u_set_datilav_toe1( )
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Operazione conclusa correttamente." &
				+ "Sono stati inviati " + string(k_ctr) + " record dati di n.giri e padri di 'irraggiamento' al Sistema E-ONE" 
	else
		kst_esito.SQLErrText = "Operazione conclusa. Nessun dato (n.giri e padri) di 'irraggiamento' disponibile per E-ONE."
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

public function boolean if_esiste (st_tab_e1_wo_f5537001 kst_tab_e1_wo_f5537001) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla esistenza Record
//--- 
//--- 
//--- Inp: st_tab_e1_wo_f5537001.MPDOCO e kst_tab_e1_wo_f5537001.flag_osev01
//--- Out: TRUE = esiste
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
long k_trovato=0
st_esito kst_esito



	kst_esito = kguo_exception.inizializza(this.classname())

	SELECT count(*)
			into :k_trovato
			 FROM e1_wo_f5537001  
			 where MPDOCO  = :kst_tab_e1_wo_f5537001.MPDOCO
			 using kguo_sqlca_db_magazzino ;
		
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in verifica esistenza del record in tabella e1_wo_f5537001 (wo: '" + string(kst_tab_e1_wo_f5537001.MPDOCO) + "') " &
						 + "~n~rErrore: " + trim(SQLCA.SQLErrText)
									 
		kst_esito.esito = kkg_esito.db_ko
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		if k_trovato > 0 then k_return = true
	end if
	

return k_return



end function

public subroutine if_isnull (ref st_tab_e1_wo_f5537001 kst_tab_e1_wo_f5537001);//
if isnull(kst_tab_e1_wo_f5537001.id_e1_wo_f5537001) then kst_tab_e1_wo_f5537001.id_e1_wo_f5537001 = 0		// ID
if isnull(kst_tab_e1_wo_f5537001.MPDOCO) then kst_tab_e1_wo_f5537001.MPDOCO = 0		//work order
if isnull(kst_tab_e1_wo_f5537001.MPAURST1) then kst_tab_e1_wo_f5537001.MPAURST1 = "" 	
if isnull(kst_tab_e1_wo_f5537001.MPMMCU) then kst_tab_e1_wo_f5537001.MPMMCU = ""	
if isnull(kst_tab_e1_wo_f5537001.MPUORG) then kst_tab_e1_wo_f5537001.MPUORG = 0
if isnull(kst_tab_e1_wo_f5537001.MPMATH06) then kst_tab_e1_wo_f5537001.MPMATH06 = 0
if isnull(kst_tab_e1_wo_f5537001.MPMATH07) then kst_tab_e1_wo_f5537001.MPMATH07 = 0
if isnull(kst_tab_e1_wo_f5537001.MPMATH08) then kst_tab_e1_wo_f5537001.MPMATH08 = 0

end subroutine

public function integer set_datilav_f5537001 (st_tab_e1_wo_f5537001 kst_tab_e1_wo_f5537001) throws uo_exception;//
//------------------------------------------------------------------------------------
//--- Registra i dati per E1 circa il n. barcode + giri +  padre (1=si, 0= no)
//--- 
//--- inp: st_tab_e1_wo_f5537001 
//--- out:
//--- Ritorna: nr righe aggiornate
//--- lancia exception x errore grave
//------------------------------------------------------------------------------------
int k_return
int k_righe
string k_nrusa
st_esito kst_esito
kds_e1_wo_f5537001 kds1_e1_wo_f5537001
kuf_utility kuf1_utility


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	kds1_e1_wo_f5537001 = create kds_e1_wo_f5537001
	kuf1_utility = create kuf_utility
	
	if_isnull(kst_tab_e1_wo_f5537001)
	
	kds1_e1_wo_f5537001.settransobject(kguo_sqlca_db_magazzino)
	
	k_righe = kds1_e1_wo_f5537001.retrieve(kst_tab_e1_wo_f5537001.MPDOCO, kst_tab_e1_wo_f5537001.MPAURST1)
	if k_righe < 0 then
	else
		if k_righe = 0 then
			kds1_e1_wo_f5537001.insertrow(0)
			kds1_e1_wo_f5537001.setitem(1, "id_e1_wo_f5537001", 0)		//ID
		end if
	
		kds1_e1_wo_f5537001.setitem(1, "MPDOCO", kst_tab_e1_wo_f5537001.MPDOCO)		//work order
		kds1_e1_wo_f5537001.setitem(1, "MPUORG", kst_tab_e1_wo_f5537001.MPUORG)  	
		kds1_e1_wo_f5537001.setitem(1, "MPMMCU", kst_tab_e1_wo_f5537001.MPMMCU)		
		kds1_e1_wo_f5537001.setitem(1, "MPAURST1", kst_tab_e1_wo_f5537001.MPAURST1) 	//Tipo CILCI (27002=fila 1 (A)/27005=fila 2 (B)/27006=misti (C))
		kds1_e1_wo_f5537001.setitem(1, "MPMATH06", kst_tab_e1_wo_f5537001.MPMATH06)	//numero di giri
		kds1_e1_wo_f5537001.setitem(1, "MPMATH07", kst_tab_e1_wo_f5537001.MPMATH07)	//tempi ciclo
		kds1_e1_wo_f5537001.setitem(1, "MPMATH08", kst_tab_e1_wo_f5537001.MPMATH08)	//numero padri (tutti, compreso quelli senza figli)
		
		k_righe = kds1_e1_wo_f5537001.u_update()
	end if
	if k_righe < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = k_righe
		kst_esito.SQLErrText = "Aggiornamento fallito in tabella dati lavorazione per E1 'e1_wo_f5537001'. ~n~rWO (doco): "+string(kst_tab_e1_wo_f5537001.MPDOCO)
		kguo_exception.inizializza()
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if

	k_return = k_righe

catch (uo_exception kuo_exception)
	if kst_tab_e1_wo_f5537001.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_e1_wo_f5537001.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception

finally
	if kst_tab_e1_wo_f5537001.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_e1_wo_f5537001.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	if isvalid(kds1_e1_wo_f5537001) then destroy kds1_e1_wo_f5537001
	if isvalid(kuf1_utility) then destroy kuf1_utility
	
end try

return k_return

end function

public function boolean tb_delete (readonly st_tab_e1_wo_f5537001 ast_tab_e1_wo_f5537001) throws uo_exception;//
//------------------------------------------------------------------------------------------------
//--- Rimuove riga dati di trattamento per E1
//--- 
//--- inp: ast_tab_e1_wo_f5537001 MPDOCO, flag_osev01
//--- out: 
//--- Ritorna: TRUE = riga rimossa
//--- lancia exception x errore grave
//------------------------------------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_e1_wo_f5537001.MPDOCO > 0 then

		delete 
		   from e1_wo_f5537001
			where e1_wo_f5537001.MPDOCO = :ast_tab_e1_wo_f5537001.MPDOCO
			using kguo_sqlca_db_magazzino ;
			
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Rimozione riga dati di lavorazione per E1 (tab 'e1_wo_f5537001').~n~r"&
			          + "Codice da rimuovere MPDOCO (WO): " + string(ast_tab_e1_wo_f5537001.MPDOCO) + " " &
						 + string(kguo_sqlca_db_magazzino.sqlcode) + " " + trim(kguo_sqlca_db_magazzino.sqlerrtext)
			kguo_exception.inizializza()
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
		
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			k_return = true
		end if
		
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Rimozione riga dati lavorazione per E1 (tab 'e1_wo_f5537001') non effettuata, manca il codice WO (MPDOCO)."
		kguo_exception.inizializza()
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try

return k_return

end function

public function boolean u_get_e1updts (ref st_tab_e1_wo_f5537001 ast_tab_e1_wo_f5537001) throws uo_exception;//
//------------------------------------------------------------------------------------------------
//--- Recupera la data di aggiornamento dei dati a E1
//--- 
//--- inp: ast_tab_e1_wo_f5537001 wo_MPDOCO
//--- out: ast_tab_e1_wo_f5537001.e1updts
//--- Ritorna: TRUE = data e1updts valorizzata x cui è stato trasferito a E1
//--- lancia exception x errore grave
//------------------------------------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito


try
	kst_esito = kguo_exception.inizializza(this.classname())
	
	if ast_tab_e1_wo_f5537001.MPDOCO > 0 then

		select e1_wo_f5537001.e1updts
		   into :ast_tab_e1_wo_f5537001.e1updts
		   from e1_wo_f5537001
			where e1_wo_f5537001.MPDOCO = :ast_tab_e1_wo_f5537001.MPDOCO
			using kguo_sqlca_db_magazzino ;
			
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettura data di invio a E1 dei dati totali di Trattamento (tab 'e1_wo_F5537001').~n~r"&
			          + "Codice cercato: MPDOCO: " + string(ast_tab_e1_wo_f5537001.MPDOCO) + "~n~r" &
						 + string(kguo_sqlca_db_magazzino.sqlcode) + " " + trim(kguo_sqlca_db_magazzino.sqlerrtext)
			kguo_exception.inizializza()
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
		
		if date(ast_tab_e1_wo_f5537001.e1updts) > kkg.data_zero then
			k_return = true
		end if
		
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Lettura data di invio a E1 dei dati totali di Trattamento (tab 'e1_wo_F5537001') non effettuata, manca il WO (MPDOCO)."
		kguo_exception.inizializza()
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try

return k_return

end function

on kuf_e1_wo_f5537001.create
call super::create
end on

on kuf_e1_wo_f5537001.destroy
call super::destroy
end on

