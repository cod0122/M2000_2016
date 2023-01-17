$PBExportHeader$kuf_listino_disattivo_massivo.sru
forward
global type kuf_listino_disattivo_massivo from kuf_parent0
end type
end forward

global type kuf_listino_disattivo_massivo from kuf_parent0
end type
global kuf_listino_disattivo_massivo kuf_listino_disattivo_massivo

type variables
private kuf_listino kiuf_listino

end variables

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function st_esito u_batch_run () throws uo_exception
public function integer u_disattivo_massivo (date k_data_fino_a) throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
boolean k_return

if ast_open_w.flag_modalita > " " then
else
	ast_open_w.flag_modalita = kkg_flag_modalita.modifica
end if

try
	k_return = super::if_sicurezza(ast_open_w)

catch (uo_exception kuo_exception)
	
//--- Se non sono autorizzato a questo allora vedo come le autorizzazioni del LISTINO
	ast_open_w.id_programma = kiuf_listino.get_id_programma(ast_open_w.flag_modalita)
	k_return = kiuf_listino.if_sicurezza(ast_open_w)

end try

return k_return 

end function

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
long k_ctr
st_esito kst_esito
date k_data_fino_a


try 

	kst_esito = kguo_exception.inizializza(this.classname())

	k_data_fino_a = relativedate(kguo_g.get_dataoggi( ), -62)

// call della routine che esegue il batch
	k_ctr = this.u_disattivo_massivo(k_data_fino_a) 
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Operazione conclusa correttamente." + "Sono stati Annullati " + string(k_ctr) + " Listini, scaduti fino al " + string(k_data_fino_a) + ".  " 
	else
		kst_esito.SQLErrText = "Operazione conclusa. Nessun Listino scaduto al " + string(k_data_fino_a) + " da annullare. Funzione: " + this.get_id_programma(kkg_flag_modalita.modifica)
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

public function integer u_disattivo_massivo (date k_data_fino_a) throws uo_exception;//
//-----------------------------------------------------------------------------------------------------
//--- DISATTIVA vecchi listini scaduti
//--- 
//--- Inp: data fino alla quale disattivare i listini scaduti
//---        
//--- Ritorna: numero listini disattivati
//--- Lancia EXCEPTION
//---  
//-----------------------------------------------------------------------------------------------------
//
int k_return
st_tab_listino kst_tab_listino, kst_tab_listino_orig
st_esito kst_esito


try

	kst_esito = kguo_exception.inizializza(this.classname())

	if_sicurezza(kkg_flag_modalita.modifica)

//--- imposto dati utente e data aggiornamento
	kst_tab_listino.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_listino.x_utente = kGuf_data_base.prendi_x_utente()
	kst_tab_listino.attivo = kiuf_listino.kki_attivo_NO
	kst_tab_listino_orig.attivo = kiuf_listino.kki_attivo_SI

//--- conta le righe da disattivare
	select count(*)
	   into :k_return
		from listino
		where attivo = :kst_tab_listino_orig.attivo
			and dt_end <= :k_data_fino_a
		 using kguo_sqlca_db_magazzino;
	
//--- disattiva	
	update listino 
			set attivo = :kst_tab_listino.attivo
				 ,x_datins = :kst_tab_listino.x_datins 
				 ,x_utente = :kst_tab_listino.x_utente 
		where attivo = :kst_tab_listino_orig.attivo
			and dt_end <= :k_data_fino_a
		 using kguo_sqlca_db_magazzino;
		

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in Annullo 'Listini' fino alla data del '" + string(k_data_fino_a) + "', errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)	
		throw kguo_exception
	end if

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		kguo_sqlca_db_magazzino.db_commit( )
	end if

	if isnull(k_return) then
		k_return = 0
	end if

	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally

end try

return k_return

end function

on kuf_listino_disattivo_massivo.create
call super::create
end on

on kuf_listino_disattivo_massivo.destroy
call super::destroy
end on

event constructor;call super::constructor;//
kiuf_listino = create kuf_listino

end event

