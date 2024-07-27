$PBExportHeader$kuf_pilota_previsioni_g3.sru
$PBExportComments$report x movimenti registro articolo 50
forward
global type kuf_pilota_previsioni_g3 from nonvisualobject
end type
end forward

global type kuf_pilota_previsioni_g3 from nonvisualobject
end type
global kuf_pilota_previsioni_g3 kuf_pilota_previsioni_g3

type variables
//
//private constant string ki_ds_queue_lav_xfila_dataobject = "ds_queue_lav_xfila"
///private constant string ki_ds_pallet_workqueue_dataobject = "ds_pilota_pallet_workqueue_g3"
//private constant string ki_ds_prev_data_fine_lav_xdtpl = "ds_pilota_prev_data_fin_lav_xdtpl"

private string ki_temptab_pilota_workqueue // = "vx_MAST_pilota_pallet_workqueue"
private string ki_temptab_pilota_prev_lav //= "vx_MAST_pilota_prev_lav"

//private datastore kids_ds_queue_lav_xfila
//private datastore kids_barcode_avgtimeplant
//private datastore kids_pilota_giri_da_fare_prev

//private kuf_date kiuf_date

//private string ki_status
end variables

forward prototypes
public subroutine _readme ()
private function long u_set_tab_lav_x_lotto_prev () throws uo_exception
private function datastore u_get_ds_pilota_workqueue_all () throws uo_exception
public function long crea_temptable_pilota_pallet_workqueue () throws uo_exception
private function long u_set_temptable_pilota_workqueue (uo_ds_std_1 ads_pilota_pallet_workqueue_temp_g3) throws uo_exception
public function long crea_temptable_pilota_pallet_in_lav () throws uo_exception
end prototypes

public subroutine _readme ();//
//--- Get dati dal PILOTA GAMMA3 insieme ai dati di M2000
//

end subroutine

private function long u_set_tab_lav_x_lotto_prev () throws uo_exception;//
//----------------------------------------------------------------------------------------
//--- Popola ds data inizio-fine lavorazione previste x Lotto
//---
//----------------------------------------------------------------------------------------
//
long k_righe=0
datastore kds_queue

 	
	try

//		u_set_dataora_lav_prev_fin( )	  // imposta data fine lav per rec in lavorazione
		
//		kds_queue = u_get_ds_pilota_workqueue_all( )

//		u_set_ds_pilota_queue_data_prev_all(kds_queue)	  // imposta data fine lav per rec in lavorazione (WORK) e programmazione (QUEUE)
		
//--- popola pallet in lav e in coda in una tabella di appoggio: #vx_pilota_prev_lav
//		k_righe = u_set_temptable_pilota_prev_lav( )
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_righe
	

end function

private function datastore u_get_ds_pilota_workqueue_all () throws uo_exception;//
//--------------------------------------------------------------------------------------
//--- Aggiorna la data di fine lavorazione in tab 'previsioni' per 
//--- i pallet in lavorazione (WORK)
//---
//--------------------------------------------------------------------------------------
//
//
long k_riga, k_righe
int k_rc
uo_ds_std_1 kds_out	
ds_pilota_pallet_workqueue_temp_g3 kds_pilota_pallet_workqueue_temp_g3

	try

		kds_out = CREATE uo_ds_std_1
		kds_out.dataobject = "ds_pilota_workqueue_tmp_g3"
		k_rc = kds_out.SetTransObject (kguo_sqlca_db_magazzino)

		kguf_data_base.u_set_ds_change_name_tab(kds_out, "vx_MAST_pilota_pallet_workqueue_g3")
		
		k_righe = kds_out.retrieve("*")
		if k_righe < 1 then //verifica se la tabella temp esiste altrimenti la popola
		
//--- popola tabella temp con i data ini e fin previsti ( tutto quello che c'e' nel Pilota in Lav e  in Coda di Programmazione) 		
			kds_pilota_pallet_workqueue_temp_g3 = CREATE ds_pilota_pallet_workqueue_temp_g3
			k_righe = u_set_temptable_pilota_workqueue(kds_pilota_pallet_workqueue_temp_g3)
			if k_righe > 0 then
				k_righe = kds_out.retrieve("*")
			end if

		end if
		
		if k_righe < 1 then
			
			kguo_exception.inizializza( )
			kguo_exception.kist_esito.esito = kguo_exception.KK_st_uo_exception_tipo_internal_bug
			kguo_exception.kist_esito.sqlerrtext = "Il numero di righe estratte dalla tab. temp #" + ki_temptab_pilota_workqueue + " non può essere a zero!"
			kguo_exception.kist_esito.nome_oggetto = this.classname( )
			kguo_exception.scrivi_log( )
			throw kguo_exception
			
		end if
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally
		if isvalid(kds_pilota_pallet_workqueue_temp_g3) then destroy kds_pilota_pallet_workqueue_temp_g3

	end try
		

return kds_out
	

end function

public function long crea_temptable_pilota_pallet_workqueue () throws uo_exception;//---
//--- Popola il ds con i barcode in programmazione nel PILOTA 
//---
//
int k_rc
long k_rows
datastore kds_temp_table_by_pilota, kds_queue
ds_pilota_pallet_workqueue_temp_g3 kds_pilota_pallet_workqueue_temp_g3

try  
	
//--- popola tabella temp con i data ini e fin previsti ( tutto quello nel Pilota in Lav e  in Coda di Programmazione) 		
	kds_pilota_pallet_workqueue_temp_g3 = CREATE ds_pilota_pallet_workqueue_temp_g3
	k_rows = u_set_temptable_pilota_workqueue(kds_pilota_pallet_workqueue_temp_g3)
//	kds_temp_table_by_pilota = u_set_temptable_pilota_workqueue( )
//	k_rows = kds_temp_table_by_pilota.rowcount( )
	if k_rows > 0 then

		kds_queue = u_get_ds_pilota_workqueue_all( )

//		u_set_ds_pilota_queue_data_prev_all(kds_queue)	  // imposta data fine lav per rec WORK + QUEUE
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kds_pilota_pallet_workqueue_temp_g3) then destroy kds_pilota_pallet_workqueue_temp_g3
	
end try

return k_rows
end function

private function long u_set_temptable_pilota_workqueue (uo_ds_std_1 ads_pilota_pallet_workqueue_temp_g3) throws uo_exception;/*
  Recupera da PILOTA Gamma3 tutti i pallet in-lav (WORK) e in coda (QUEUE) 
      e crea la TEMP TABLE con i PALLET 
  Out: datastore con i dati della temp-table
  Rit: numero dei record caricati
*/
long k_return
long k_righe=0, k_riga=0
int k_rc
string k_rcx
long k_rigainsert
string k_campi, k_stato
string k_sql_orig, k_string, k_stringn
int k_ctr
st_tab_pilota_pallet kst_tab_pilota_pallet
ds_pilota_pallet_workqueue_g3	kds_pilota_pallet_workqueue_g3


	try
		
//--- popola pallet in lav e in coda in una tabella di appoggio: #vx_pilota_prev_lav

		k_campi = "stato char(6) " &
					 	+ " , n_ordine int " &
					 	+ " , barcode char(13) " &
					 	+ " , barcode_figlio char(13) " &
					 	+ " , ordine_figlio tinyint " &
					 	+ " , num_int_figlio int " &
					 	+ " , carrier int " &
					 	+ " , fase tinyint " &
						 + ", id_modo char(2) " &
						 + ", ciclo varchar(16) " &
						 + ", giri smallint " &
						 + ", giri_eseguiti smallint " &
					 	 + ", dataora_lav_ini datetime " &
					 	 + ", dataora_lav_fin_prev datetime " &
 					 	 + ", dataora_lav_fin_min_prev datetime " &
					 	 + ", dataora_lav_fin_max_prev datetime " &
					 	 + ", dataora_lav_fin_prev_dtpl datetime " &
						 + ", avg_time_io_minute integer" 
	   kguo_sqlca_db_magazzino.db_crea_temp_table(ki_temptab_pilota_workqueue, k_campi, "")      
				
		kds_pilota_pallet_workqueue_g3 = CREATE ds_pilota_pallet_workqueue_g3

		kguf_data_base.u_set_ds_change_name_tab(ads_pilota_pallet_workqueue_temp_g3, "vx_MAST_pilota_pallet_workqueue_g3")

		k_righe = kds_pilota_pallet_workqueue_g3.retrieve( )    // get dal db PILOTA tutti i PALLET in lavorazione e in coda 

		for k_riga = 1 to k_righe 
			k_rigainsert = ads_pilota_pallet_workqueue_temp_g3.insertrow( 0 )
			
//			k_rcx = ads_pilota_pallet_workqueue_temp_g3.dataobject
//			k_rcx = ads_pilota_pallet_workqueue_temp_g3.describe("#1.Name")
//			k_rcx = ads_pilota_pallet_workqueue_temp_g3.describe("#2.Name")
//			k_rcx = ads_pilota_pallet_workqueue_temp_g3.describe("#3.Name")
//			k_rcx = ads_pilota_pallet_workqueue_temp_g3.describe("DataWindow.Syntax.Data")
			
			k_stato = kds_pilota_pallet_workqueue_g3.getitemstring(k_riga, "stato")  //stato = WORK (in lav) o QUEUE (in coda)
			ads_pilota_pallet_workqueue_temp_g3.setitem( k_rigainsert, "stato", k_stato )
			ads_pilota_pallet_workqueue_temp_g3.setitem( k_rigainsert, "n_ordine", kds_pilota_pallet_workqueue_g3.getitemnumber(k_riga, "n_ordine") )
			ads_pilota_pallet_workqueue_temp_g3.setitem( k_rigainsert, "barcode", kds_pilota_pallet_workqueue_g3.getitemstring(k_riga, "barcode") )
			ads_pilota_pallet_workqueue_temp_g3.setitem( k_rigainsert, "barcode_figlio", kds_pilota_pallet_workqueue_g3.getitemstring(k_riga, "barcode_figlio") )
			ads_pilota_pallet_workqueue_temp_g3.setitem( k_rigainsert, "ordine_figlio", kds_pilota_pallet_workqueue_g3.getitemnumber(k_riga, "ordine_figlio") )
			ads_pilota_pallet_workqueue_temp_g3.setitem( k_rigainsert, "num_int_figlio", integer(kds_pilota_pallet_workqueue_g3.getitemstring(k_riga, "lotto_figlio") ))
			ads_pilota_pallet_workqueue_temp_g3.setitem( k_rigainsert, "carrier", integer(kds_pilota_pallet_workqueue_g3.getitemnumber(k_riga, "carrier") ))
			
			kst_tab_pilota_pallet.data_entrata = kds_pilota_pallet_workqueue_g3.getitemdatetime(k_riga, "k_dataora_lav_ini")
			if k_stato = "WORK" then 
				if kst_tab_pilota_pallet.data_entrata > datetime(date(0)) then
				else
					//--- capita a volte che il PALLET è in LAV ma ancora senza data per un po' allora forza adesso
					kst_tab_pilota_pallet.data_entrata = kguo_g.get_datetime_current( )
				end if
			end if
			ads_pilota_pallet_workqueue_temp_g3.setitem( k_rigainsert, "dataora_lav_ini", kst_tab_pilota_pallet.data_entrata )
			
			ads_pilota_pallet_workqueue_temp_g3.setitem( k_rigainsert, "fase", kds_pilota_pallet_workqueue_g3.getitemnumber(k_riga, "fase"))
			ads_pilota_pallet_workqueue_temp_g3.setitem( k_rigainsert, "id_modo", trim(kds_pilota_pallet_workqueue_g3.getitemstring(k_riga, "id_modo")))
			ads_pilota_pallet_workqueue_temp_g3.setitem( k_rigainsert, "ciclo", trim(kds_pilota_pallet_workqueue_g3.getitemstring(k_riga, "ciclo")))
			ads_pilota_pallet_workqueue_temp_g3.setitem( k_rigainsert, "giri", kds_pilota_pallet_workqueue_g3.getitemnumber(k_riga, "giri"))
			ads_pilota_pallet_workqueue_temp_g3.setitem( k_rigainsert, "giri_eseguiti", kds_pilota_pallet_workqueue_g3.getitemnumber(k_riga, "giri_eseguiti"))
		end for

		k_rc = ads_pilota_pallet_workqueue_temp_g3.update() 
		if k_rc < 0 then
			kguo_exception.inizializza(this.classname())
			kguo_exception.set_esito(ads_pilota_pallet_workqueue_temp_g3.kist_esito)
			kguo_exception.kist_esito.sqlerrtext = "Errore in aggiornamento tabella temporanea dei Pallet in Coda e in Lavorazione sul Gamma3. " &
								+ "Ordine: " + string(ads_pilota_pallet_workqueue_temp_g3.getitemnumber(k_riga, "n_ordine")) &
								+ ", Barcode: " + trim(ads_pilota_pallet_workqueue_temp_g3.getitemstring(k_riga, "barcode")) + ". " &
								+ kkg.acapo + ads_pilota_pallet_workqueue_temp_g3.kist_esito.sqlerrtext
			kguo_sqlca_db_magazzino.db_rollback( )
			throw kguo_exception
		end if
		
		kguo_sqlca_db_magazzino.db_commit( )
		
		k_return = ads_pilota_pallet_workqueue_temp_g3.rowcount()
		
	catch (uo_exception kuo_exception)
		kuo_exception.scrivi_log()
		throw kuo_exception

	finally
		if isvalid(kds_pilota_pallet_workqueue_g3) then destroy kds_pilota_pallet_workqueue_g3

	end try
		
return k_return 
	

end function

public function long crea_temptable_pilota_pallet_in_lav () throws uo_exception;//---
//--- Popola ds con i barcode in lavorazione nel PILOTA e add all data from M2000
//---
//
int k_rc
long k_rows
datastore kds_temp_table_by_pilota, kds_queue
ds_pilota_pallet_workqueue_temp_g3 kds_pilota_pallet_workqueue_temp_g3

try  
	
//--- popola tabella temp con i data ini e fin previsti ( tutto quello nel Pilota in Lav e  in Coda di Programmazione) 		
	kds_pilota_pallet_workqueue_temp_g3 = CREATE ds_pilota_pallet_workqueue_temp_g3
	k_rows = u_set_temptable_pilota_workqueue(kds_pilota_pallet_workqueue_temp_g3)
 
//	k_rows = u_set_dataora_lav_prev_fin( )	  // imposta data fine lav per rec in lavorazione


catch (uo_exception kuo_exception)
	throw kguo_exception
	
finally
	
end try

return k_rows
end function

on kuf_pilota_previsioni_g3.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_pilota_previsioni_g3.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//

try
	
//	kiuf_date = create kuf_date

	ki_temptab_pilota_workqueue = kguf_data_base.u_change_nometab_xutente( "vx_MAST_pilota_pallet_workqueue_g3")
	ki_temptab_pilota_prev_lav = kguf_data_base.u_change_nometab_xutente( "vx_MAST_pilota_prev_lav_g3")

//	u_set_barcode_avgtimeplant( ) //--- popola ds tempi medi impianto

catch (uo_exception kuo_exception)
	
end try

end event

event destructor;//
//	if isvalid(kids_barcode_avgtimeplant) then destroy kids_barcode_avgtimeplant 
//	if isvalid(kids_ds_queue_lav_xfila) then destroy kids_ds_queue_lav_xfila
//	if isvalid(kiuf_date) then destroy kiuf_date 


end event

