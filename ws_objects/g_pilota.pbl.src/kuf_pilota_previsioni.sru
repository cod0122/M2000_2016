$PBExportHeader$kuf_pilota_previsioni.sru
$PBExportComments$report x movimenti registro articolo 50
forward
global type kuf_pilota_previsioni from nonvisualobject
end type
end forward

global type kuf_pilota_previsioni from nonvisualobject
event u_construct ( )
end type
global kuf_pilota_previsioni kuf_pilota_previsioni

type variables
//
private constant string ki_ds_queue_lav_xfila_dataobject = "ds_queue_lav_xfila"
private constant string ki_ds_pallet_workqueue_dataobject = "ds_pilota_pallet_workqueue"
private constant string ki_ds_prev_data_fine_lav_xdtpl = "ds_pilota_prev_data_fin_lav_xdtpl"

private string ki_temptab_pilota_workqueue // = "vx_MAST_pilota_pallet_workqueue"
private string ki_temptab_pilota_prev_lav //= "vx_MAST_pilota_prev_lav"

private datastore kids_ds_queue_lav_xfila
private datastore kids_barcode_avgtimeplant
private datastore kids_pilota_giri_da_fare_prev

//private kuf_utility kiuf_utility
private kuf_date kiuf_date

private string ki_status
end variables

forward prototypes
public subroutine _readme ()
public function long get_tab_lav_x_lotto_prev () throws uo_exception
private function long u_set_tab_lav_x_lotto_prev () throws uo_exception
public function string get_ki_temptab_pilota_workqueue ()
public function string get_ki_temptab_pilota_prev_lav ()
private function long u_set_dataora_lav_prev_fin () throws uo_exception
private function long u_set_temptable_pilota_prev_lav () throws uo_exception
public function string get_id_programma (string k_flag_modalita)
private subroutine u_set_dataora_lav_prev_fin_1 (ref datastore ads_1, long a_riga) throws uo_exception
public function integer u_esegui_u_m2000_avgtimeplant ()
public function st_pilota_giri_tempi get_giri_tempi_prev () throws uo_exception
private function long u_set_barcode_avgtimeplant () throws uo_exception
private function long u_set_ds_queue_lav_xfila (ref datastore kds_1) throws uo_exception
private subroutine u_set_ds_pilota_queue_data_prev_all (ref datastore ads_queue) throws uo_exception
public subroutine get_time_io_minute (ref st_tab_s_avgtimeplant ast_tab_s_avgtimeplant) throws uo_exception
public function long crea_temptable_pilota_pallet_workqueue () throws uo_exception
public function long crea_temptable_pilota_pallet_in_lav () throws uo_exception
private function uo_ds_std_1 u_set_temptable_pilota_pallet_workqueue () throws uo_exception
private function uo_ds_std_1 u_get_ds_pilota_workqueue_all () throws uo_exception
private function uo_ds_std_1 u_get_ds_pilota_work () throws uo_exception
private function datastore u_append_ds_pallet_workqueue (ref uo_ds_std_1 ads_inp) throws uo_exception
public function uo_ds_std_1 get_ds_pallet_workqueue_by_d_pl_barcode (ref datawindow ads_inp) throws uo_exception
end prototypes

public subroutine _readme ();//
//--- Get dati dal PILOTA insieme ai dati di M2000
//
end subroutine

public function long get_tab_lav_x_lotto_prev () throws uo_exception;//---
//--- Popola temp tab con i barcode in lavoraz. e programmazione nel PILOTA e previsione di inizio e fine lav per Lotto
//---
//
long k_rows

try 
	
	k_rows = u_set_tab_lav_x_lotto_prev( ) 
		

catch (uo_exception kuo_exception)
	throw kguo_exception
	
finally
	
	
end try

return k_rows
end function

private function long u_set_tab_lav_x_lotto_prev () throws uo_exception;//
//----------------------------------------------------------------------------------------
//--- Popola ds data inizio-fine lavorazione previste x Lotto
//---
//----------------------------------------------------------------------------------------
//
long k_righe=0
datastore kds_queue

 	
	try

		u_set_dataora_lav_prev_fin( )	  // imposta data fine lav per rec in lavorazione
		
		kds_queue = u_get_ds_pilota_workqueue_all( )

		u_set_ds_pilota_queue_data_prev_all(kds_queue)	  // imposta data fine lav per rec in lavorazione (WORK) e programmazione (QUEUE)
		
//--- popola pallet in lav e in coda in una tabella di appoggio: #vx_pilota_prev_lav
		k_righe = u_set_temptable_pilota_prev_lav( )
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_righe
	

end function

public function string get_ki_temptab_pilota_workqueue ();	//
	return ki_temptab_pilota_workqueue

end function

public function string get_ki_temptab_pilota_prev_lav ();	//
	return ki_temptab_pilota_prev_lav

end function

private function long u_set_dataora_lav_prev_fin () throws uo_exception;//
//--------------------------------------------------------------------------------------
//--- Aggiorna la data di fine lavorazione in tab 'previsioni' per 
//--- i pallet in lavorazione (WORK)
//--- out: righe lavorate
//--------------------------------------------------------------------------------------
//
//
long k_riga, k_righe
int k_rc
datastore kds_1
	
	
	try

		kds_1 = u_get_ds_pilota_work( )
		
		k_righe = kds_1.rowcount() //retrieve("WORK")  // estrae solo i pallet in lavorazione
		
		if k_righe < 1 then
			
			kguo_exception.inizializza( )
			kguo_exception.kist_esito.esito = kguo_exception.KK_st_uo_exception_tipo_internal_bug
			kguo_exception.kist_esito.sqlerrtext = "Il numero di righe 'in lavorazione sul Pilota' nella tabella dell'oggetto '" + trim(kds_1.dataobject) + "' non può essere a zero!" // ki_temptab_pilota_workqueue
			kguo_exception.kist_esito.nome_oggetto = this.classname( )
			kguo_exception.scrivi_log( )
			throw kguo_exception
			
		end if
		
		for k_riga = 1 to k_righe	
			
			u_set_dataora_lav_prev_fin_1(kds_1, k_riga)  // imposta la data di fine lav prevista

		end for

		k_rc = kds_1.update() 
		
		kguo_sqlca_db_magazzino.db_commit( )

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_righe
	

end function

private function long u_set_temptable_pilota_prev_lav () throws uo_exception;//
//-------------------------------------------------------------------------------------------
//--- Crea la temp table con data inizio-fine lavorazione presunte x Lotto
//--- Out: nr righe inserite in tb
//-------------------------------------------------------------------------------------------
//
//
long k_righe=0, k_riga=0
int k_rc, k_colli
long k_rigainsert
string k_campi
int k_ctr
datastore kds_inp, kds_out
 	
	try
		
//--- popola pallet in lav e in coda in una tabella di appoggio: #vx_pilota_prev_lav

		k_campi = "id_cliente int " &
					 	+ " , id_meca int " &
					 	+ " , num_int int " &
					 	+ " , data_int date " &
						 + ", ciclifila1 smallint " &
						 + ", ciclifila1p smallint " &
						 + ", ciclifila2 smallint " &
						 + ", ciclifila2p smallint " &
					 	+ " , fila tinyint " &
					 	+ " , consegna_data date " & 	 
					 	+ " , pilota_ordine int "  &
					 	+ " , colli_lav_ent char(12) " & 
					 	+ " , note varchar(120) " & 
					 	+ " , prev_dataora_lav_ini datetime " &
					 	+ " , prev_dataora_lav_fin datetime " &
					 	+ " , prev_dataora_lav_fin_min datetime " &
					 	+ " , prev_dataora_lav_fin_max datetime " &
						+ " , avg_time_io_minute int "  
//	   	kguo_sqlca_db_magazzino.db_crea_temp_table_global(ki_temptab_pilota_prev_lav, k_campi, "")      
	   	kguo_sqlca_db_magazzino.db_crea_temp_table(ki_temptab_pilota_prev_lav, k_campi, "")      
//	   	kguo_sqlca_db_magazzino.db_crea_table( ki_temptab_pilota_prev_lav, k_campi)      
				
		kds_out = CREATE datastore
		kds_out.dataobject = "ds_pilota_xlotto_prev_lav"
		k_rc = kds_out.SetTransObject (kguo_sqlca_db_magazzino)
		kguf_data_base.u_set_ds_change_name_tab(kds_out, "vx_MAST_pilota_prev_lav")
				
		kds_inp = CREATE datastore
		kds_inp.dataobject = "ds_pilota_pallet_workqueue_temp"
		k_rc = kds_inp.SetTransObject (kguo_sqlca_db_magazzino)
		kguf_data_base.u_set_ds_change_name_tab(kds_inp, "vx_MAST_pilota_pallet_workqueue")
		
		k_righe = kds_inp.retrieve() // nr totale dei pallet in lavorazione nel pilota
		for k_riga = 1 to k_righe 
			k_rigainsert = kds_out.insertrow( 0 )
			kds_out.setitem( k_rigainsert, "id_cliente", 0 )
			kds_out.setitem( k_rigainsert, "id_meca", kds_inp.getitemnumber(k_riga, "id_meca") )
			kds_out.setitem( k_rigainsert, "ciclifila1", kds_inp.getitemnumber(k_riga, "ciclifila1") )
			kds_out.setitem( k_rigainsert, "ciclifila1p", kds_inp.getitemnumber(k_riga, "ciclifila1p") )
			kds_out.setitem( k_rigainsert, "ciclifila2", kds_inp.getitemnumber(k_riga, "ciclifila2") )
			kds_out.setitem( k_rigainsert, "ciclifila2p", kds_inp.getitemnumber(k_riga, "ciclifila2p") )
			kds_out.setitem( k_rigainsert, "fila", kds_inp.getitemnumber(k_riga, "fila") )
			kds_out.setitem( k_rigainsert, "pilota_ordine", kds_inp.getitemnumber(k_riga, "n_ordine") )
			kds_out.setitem( k_rigainsert, "note", "" )
			kds_out.setitem( k_rigainsert, "prev_dataora_lav_ini", kds_inp.getitemdatetime(k_riga, "dataora_lav_ini") )
			kds_out.setitem( k_rigainsert, "prev_dataora_lav_fin", kds_inp.getitemdatetime(k_riga, "dataora_lav_fin_prev") )
			kds_out.setitem( k_rigainsert, "prev_dataora_lav_fin_min", kds_inp.getitemdatetime(k_riga, "dataora_lav_fin_min_prev") )
			kds_out.setitem( k_rigainsert, "prev_dataora_lav_fin_max", kds_inp.getitemdatetime(k_riga, "dataora_lav_fin_max_prev") )
			kds_out.setitem( k_rigainsert, "avg_time_io_minute", kds_inp.getitemnumber(k_riga, "avg_time_io_minute") )
		end for

		k_rc = kds_out.update() 
		
		kguo_sqlca_db_magazzino.db_commit( )
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally
		if isvalid(kds_inp) then destroy kds_inp
		if isvalid(kds_out) then destroy kds_out

	end try
		

return k_rigainsert
	

end function

public function string get_id_programma (string k_flag_modalita);//
string k_return
kuf_parent kuf1_parent


kuf1_parent = create kuf_parent

kuf1_parent.u_set_ki_nomeoggetto(this)
k_return = kuf1_parent.get_id_programma(k_flag_modalita)

destroy kuf1_parent

return k_return
end function

private subroutine u_set_dataora_lav_prev_fin_1 (ref datastore ads_1, long a_riga) throws uo_exception;//
//--------------------------------------------------------------------------------------
//--- Imposta la data di fine lavorazione nel ds in input 
//--- calcola data fine dalla data inizio che deve esserci
//--- input: datastore previsioni, nr riga 
//--------------------------------------------------------------------------------------
//
//
datetime k_dataora_lav_fin_prev, k_dataora_lav_ini //, k_dataora_lav_fin_min_prev, k_dataora_lav_fin_max_prev
int k_rc
st_tab_s_avgtimeplant kst_tab_s_avgtimeplant_avg //, kst_tab_s_avgtimeplant_min, kst_tab_s_avgtimeplant_max

	
	try

			
		ads_1.setitem(a_riga, "dataora_lav_fin_prev", datetime(date(0)))

		k_dataora_lav_ini = ads_1.getitemdatetime(a_riga, "dataora_lav_ini")
		if date(k_dataora_lav_ini) > kkg.data_no then
				
			kst_tab_s_avgtimeplant_avg.time_io_minute = ads_1.getitemnumber(a_riga, "time_io_minute_avg")
			//kst_tab_s_avgtimeplant_min.time_io_minute = ads_1.getitemnumber(a_riga, "time_io_minute_min")
			//kst_tab_s_avgtimeplant_max.time_io_minute = ads_1.getitemnumber(a_riga, "time_io_minute_max")
			ads_1.setitem(a_riga, "avg_time_io_minute", kst_tab_s_avgtimeplant_avg.time_io_minute)

		//--- calcola le previsioni aggiungendo i minuti previsti in impianto per l'uscita
			k_dataora_lav_fin_prev = kiuf_date.u_datetime_after_minute(k_dataora_lav_ini, kst_tab_s_avgtimeplant_avg.time_io_minute)
			if date(k_dataora_lav_fin_prev) > kkg.data_no then
				
				// se data prev già passata (minore di adesso) allora metto adesso + un tot di minuti
				if k_dataora_lav_fin_prev < kguo_g.get_datetime_current( ) then
					k_dataora_lav_fin_prev = kiuf_date.u_datetime_after_minute(kguo_g.get_datetime_current( ), 30) 
				end if

				// aggiusta calcolo MINIMO e MASSIMO uscita			
				//k_dataora_lav_fin_min_prev = kiuf_date.u_datetime_after_minute(k_dataora_lav_fin_prev, (kst_tab_s_avgtimeplant_min.time_io_minute - kst_tab_s_avgtimeplant_avg.time_io_minute))
				//k_dataora_lav_fin_max_prev = kiuf_date.u_datetime_after_minute(k_dataora_lav_fin_prev, (kst_tab_s_avgtimeplant_max.time_io_minute - kst_tab_s_avgtimeplant_avg.time_io_minute))
							
			end if
					
			ads_1.setitem(a_riga, "dataora_lav_fin_prev", k_dataora_lav_fin_prev)
			//ads_1.setitem(a_riga, "dataora_lav_fin_min_prev", k_dataora_lav_fin_min_prev)
			//ads_1.setitem(a_riga, "dataora_lav_fin_max_prev", k_dataora_lav_fin_max_prev)
					
		end if
		

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

//return k_righe
	

end subroutine

public function integer u_esegui_u_m2000_avgtimeplant ();//
//--- Esecuzione della Stored Procedure MSSQL STATISTICI (DATAWHERHOUSE)
//--- Chiama la sp che scatena tutte le altre
//
int k_return
int k_rc

	ki_status = "" 

	DECLARE u_m2000_avgtimeplant PROCEDURE FOR
			@li_rc = dbo.u_m2000_avgtimeplant
									@k_status varchar(8000) = :ki_status OUT
		using kguo_sqlca_db_magazzino ;
			
	execute u_m2000_avgtimeplant;
	
	IF kguo_sqlca_db_magazzino.SQLCode < 0 THEN
		//ls_msg = SQLCA.SQLErrText
		k_return =  kguo_sqlca_db_magazzino.SQLCode
	ELSE
			// Put the return value into the var and close the declaration.
		FETCH u_m2000_avgtimeplant INTO :k_rc, :ki_status;
		IF kguo_sqlca_db_magazzino.SQLCode = 0 THEN
			k_return = k_rc
		else
			k_return = 0
		end if
		CLOSE u_m2000_avgtimeplant;
	END IF
	
	kguo_sqlca_db_magazzino.db_commit( )

return k_return
end function

public function st_pilota_giri_tempi get_giri_tempi_prev () throws uo_exception;//
//-------------------------------------------------------------------------------------------
//--- Torna il N.giri mancanti in Lav (previsit) e in Coda leggendo dal PILOTA
//--- Out: st_pilota_giri_tempi
//-------------------------------------------------------------------------------------------
//
//
long k_rows=0, k_row=0
int k_rc
st_pilota_giri_tempi	kst_pilota_giri_tempi	
datastore kds_inp

	 
	try
		
		kguo_exception.inizializza(this.classname())
		
//--- preleva i valori dalla band di GROUP dei minuti medi di un giro x fila 1 e 2
		k_rows = kids_barcode_avgtimeplant.rowcount()
		do while (kst_pilota_giri_tempi.avg_time_io_minute_f1 > 0 and kst_pilota_giri_tempi.avg_time_io_minute_f2 > 0) or k_row > k_rows 
			if kst_pilota_giri_tempi.avg_time_io_minute_f1 = 0 and kids_barcode_avgtimeplant.getitemnumber(1, "fila_lav") = 1 then
				kst_pilota_giri_tempi.avg_time_io_minute_f1 = kids_barcode_avgtimeplant.getitemnumber(1, "ktime_io_minute_xgiro_fila")
			else
				if kst_pilota_giri_tempi.avg_time_io_minute_f2 = 0 and kids_barcode_avgtimeplant.getitemnumber(1, "fila_lav") = 2 then
					kst_pilota_giri_tempi.avg_time_io_minute_f2 = kids_barcode_avgtimeplant.getitemnumber(1, "ktime_io_minute_xgiro_fila")
				end if
			end if
		loop	
		if kst_pilota_giri_tempi.avg_time_io_minute_f1 = 0 or kst_pilota_giri_tempi.avg_time_io_minute_f2 = 0 then
			kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_non_eseguito
			kguo_exception.kist_esito.sqlerrtext = "Tempi medi per giro non recuperati, operazione interrotta!"
			throw kguo_exception
		end if
			
//--- Dati Pilota 				
		kds_inp = CREATE datastore
		kds_inp.dataobject = ki_ds_pallet_workqueue_dataobject    
		k_rc = kds_inp.SetTrans (kguo_sqlca_db_pilota)
		k_rows = kds_inp.retrieve((kst_pilota_giri_tempi.avg_time_io_minute_f1 * 2), (kst_pilota_giri_tempi.avg_time_io_minute_f2 * 2) )    // get dal db PILOTA i dati di prev fine lavorazione totali
		
		if k_rows = 0 then
			kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_non_eseguito
			kguo_exception.kist_esito.sqlerrtext = "Tempi di completamento trattamenti mancanti sul Pilota, operazione interrotta!"
			throw kguo_exception
		end if

//--- preleva i valori dalla band di GROUP dei giri ancora da fare x i pallet in lavorazione e in coda
		k_rows = kids_barcode_avgtimeplant.rowcount()
		do while (kst_pilota_giri_tempi.giri_f1_work_prev > 0 and kst_pilota_giri_tempi.giri_f1_queue > 0) or k_row > k_rows 
			if kst_pilota_giri_tempi.giri_f1_work_prev = 0 and kds_inp.getitemstring(1, "stato") = "WORK" then
				kst_pilota_giri_tempi.giri_f1_work_prev = kids_barcode_avgtimeplant.getitemnumber(1, "f1_still_sum")
				kst_pilota_giri_tempi.giri_f2_work_prev = kids_barcode_avgtimeplant.getitemnumber(1, "f2_still_sum")
			else
				if kst_pilota_giri_tempi.giri_f1_queue = 0 and kds_inp.getitemstring(1, "stato") <> "WORK" then
					kst_pilota_giri_tempi.giri_f1_queue = kids_barcode_avgtimeplant.getitemnumber(1, "f1_still_sum")
					kst_pilota_giri_tempi.giri_f2_queue = kids_barcode_avgtimeplant.getitemnumber(1, "f1_still_sum")
				end if
			end if
		loop	
		if kst_pilota_giri_tempi.giri_f1_work_prev = 0 and kst_pilota_giri_tempi.giri_f1_queue = 0 then
			kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_non_eseguito
			kguo_exception.kist_esito.sqlerrtext = "Tempi di completamento trattamenti non recuperati dal Pilota, operazione interrotta!"
			throw kguo_exception
		end if

//--- calcolo la data di termine dell'impianto in Fila 1 e 2 con i dati di trattamento	recuperati
		
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally
		if isvalid(kds_inp) then destroy kds_inp

	end try
		

return kst_pilota_giri_tempi
	

end function

private function long u_set_barcode_avgtimeplant () throws uo_exception;//
//--------------------------------------------------------------------------------------
//--- Imposta i tempi di lavorazione previsti in impianto 
//--------------------------------------------------------------------------------------
//
//
long k_righe

	
	try
		
		kguo_exception.inizializza(this.classname())
		if not isvalid(kids_barcode_avgtimeplant)  then
			kids_barcode_avgtimeplant = create datastore
			kids_barcode_avgtimeplant.dataobject = "ds_barcode_avgtimeplant"
			kids_barcode_avgtimeplant.SetTransObject(kguo_sqlca_db_magazzino)
			k_righe = kids_barcode_avgtimeplant.retrieve()
			if k_righe < 0 then
				kguo_exception.kist_esito.sqlcode = k_righe
				kguo_exception.kist_esito.esito = kkg_esito.db_ko
				kguo_exception.kist_esito.sqlerrtext = "Anomalia in lettura dati tempi medi di trattamento per giro."
				throw kguo_exception
			else
				if k_righe = 0 then
					kguo_exception.kist_esito.sqlcode = k_righe
					kguo_exception.kist_esito.esito = kkg_esito.not_fnd
					kguo_exception.kist_esito.sqlerrtext = "Anomalia in lettura dati tempi medi di trattamento per giro. Nessuna riga presente in tabella."
					kguo_exception.scrivi_log( )
				end if
			end if
		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_righe
	

end function

private function long u_set_ds_queue_lav_xfila (ref datastore kds_1) throws uo_exception;//---
//--- Popola la CODA per il calcolo delle PREVISIONI, datastore: ds_queue_lav_xfila
//--- inp: ds da caricare nella coda
//--- out: nr righe inserite
//---
int k_rc
long k_rows, k_row, k_row_insert
string k_fila
datetime k_dataora_ini, k_dataora_fin


try 
	if not isvalid(kids_ds_queue_lav_xfila) then
		kids_ds_queue_lav_xfila = create datastore
		kids_ds_queue_lav_xfila.dataobject = ki_ds_queue_lav_xfila_dataobject
	end if
	kids_ds_queue_lav_xfila.reset( )

	k_rows = kds_1.rowcount( )
	if k_rows > 0 then	//--- legge barcode in lav su Pilota 

		for k_row = 1 to k_rows
		
			if k_dataora_ini <> kds_1.getitemdatetime( k_row, "dataora_lav_ini") then
				
				k_dataora_ini = kds_1.getitemdatetime( k_row, "dataora_lav_ini")
				k_dataora_fin =  kds_1.getitemdatetime( k_row, "dataora_lav_fin_prev")
				k_fila = string(kds_1.getitemnumber( k_row, "fila"))

				k_row_insert = kids_ds_queue_lav_xfila.insertrow(0)
				kids_ds_queue_lav_xfila.setitem(k_row_insert, "k_dataora_lav_ini", k_dataora_ini)
				kids_ds_queue_lav_xfila.setitem(k_row_insert, "k_dataora_lav_fin", k_dataora_fin)
				kids_ds_queue_lav_xfila.setitem(k_row_insert, "fila", k_fila) 

			end if
			
		end for
		
	end if

	if k_rows < 0 then
		kguo_exception.inizializza( )
		kguo_exception.kist_esito.nome_oggetto = this.classname( )
		kguo_exception.kist_esito.sqlcode = k_rows
		kguo_exception.kist_esito.esito = kkg_esito.db_ko
		kguo_exception.kist_esito.sqlerrtext = "Errore in lettura Fila in lavorazione in impianto: " + string(kguo_sqlca_db_magazzino.sqldbcode)
		throw kguo_exception
	end if


catch (uo_exception kuo_exception)
	throw kguo_exception
	
finally
	
end try

return k_row_insert


end function

private subroutine u_set_ds_pilota_queue_data_prev_all (ref datastore ads_queue) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------
//--- Imposta data inizio-fine lavorazione presunte in tab 'previsioni' temporanea 
//--- dai Pallet in Lavorazione (WORK) ricava in successione la data di fine (dai tempi presunti x umero giri x fila)
//--- poi valorizzare la data di inzio per quelli ancora in Programmazone (QUEUE) e calcola da questa 
//--- la data di fine (dai tempi presunti x umero giri x fila) 
//--------------------------------------------------------------------------------------------------------------------
//
//
boolean k_elabora=true
long k_righe=0, k_riga=0, k_riga_upd, k_ordine_queue, k_n_ordine, k_riga_lav_fin
long k_riga_find 
int k_ctr, k_rc
datetime k_dataora_lav_ini, k_dataora_lav_fin, k_datetime_zero, k_dataora_lav_fin_prev //, k_dataora_lav_fin_min_prev, k_dataora_lav_fin_max_prev //k_dataora_lav_fin_fromdtpl
datetime k_dataora_lav_fin_prev_x_fila_1, k_dataora_lav_fin_prev_x_fila_2
string k_find, k_barcode, k_barcode_x_fila_1, k_barcode_x_fila_2
int k_fila, k_avg_time_io_minute
st_tab_barcode kst_tab_barcode
datastore kds_work //, kds_queue //, kds_prev_dtfin_xdtpl
	
	try

		kds_work = u_get_ds_pilota_work( )
		k_righe = kds_work.rowcount() // kds_work.retrieve("WORK")
		if k_righe < 0 then
			kguo_exception.inizializza(this.classname())
			kguo_exception.kist_esito.esito = kguo_exception.KK_st_uo_exception_tipo_non_eseguito
			kguo_exception.kist_esito.sqlerrtext = "Il numero di righe 'in lavorazione sul Pilota' nella tabella dell'oggetto '" + trim(kds_work.dataobject) + "' non può essere a zero!" // ki_temptab_pilota_workqueue
			kguo_exception.scrivi_log( )
			throw kguo_exception
		end if
		
		for k_riga = 1 to k_righe
			u_set_dataora_lav_prev_fin_1(kds_work, k_riga)  // imposta la data di fine lav prevista x i pallet in lavorazione (WORK)
		end for
	
		u_set_ds_queue_lav_xfila(kds_work)    // popola la temp-table CODA dei pallet x calcolo previsioni 
		
		//ads_queue = u_get_ds_pilota_workqueue_all( )
		
//--- riverso i dati aggiornati da WORK con la data fine lav. nel dw con tutto WORK+QUEUE
		k_righe = kds_work.rowcount( )
		kst_tab_barcode.barcode = ""
		for k_riga = 1 to k_righe	
			if kst_tab_barcode.barcode <> kds_work.getitemstring(k_riga, "barcode") then
				kst_tab_barcode.barcode = kds_work.getitemstring(k_riga, "barcode")
				k_dataora_lav_fin = kds_work.getitemdatetime(k_riga, "dataora_lav_fin_prev")
				k_riga_find = ads_queue.find("barcode = '" + kst_tab_barcode.barcode + "'", 1, ads_queue.rowcount())
				do while k_riga_find > 0
					ads_queue.setitem(k_riga_find, "dataora_lav_fin_prev", k_dataora_lav_fin)  
					 if k_riga_find = ads_queue.rowcount() then exit
					k_riga_find ++ 
					k_riga_find = ads_queue.find("barcode = '" + kst_tab_barcode.barcode + "'", k_riga_find, ads_queue.rowcount()) // ci possono essere anche + barcode uguali in presenza di figli
				loop
			end if
		end for

		k_datetime_zero = datetime(date(0))
		k_dataora_lav_fin_prev_x_fila_1 = datetime(date(0))

//DBG ads_queue.SaveAs("c:\ufo\workqueue_w.csv", CSV!, true)
			
			//k_righe = ads_queue.retrieve("QUEUE") // nr totale dei pallet in coda di programmazione nel pilota
		do while k_elabora

//--- Get Pallet senza DATA INIZIO LAV: riordino i dati x STATO (WORK/QUEUE/ADD) + FILA + DATA LAV INI + N.ORDINE DI ENTRATA // + POSIZIONE (H o B)
			k_rc = ads_queue.update()    // aggiorna i dati su pallet in Programmazione
			ads_queue.setsort( "stato desc, fila, dataora_lav_ini asc, n_ordine asc")
			ads_queue.sort()
			k_righe = ads_queue.rowcount( )
			k_riga_find = ads_queue.find("dataora_lav_ini <= datetime('" + string(k_datetime_zero) + "') " ,1,k_righe )
			if k_riga_find <= 0 then
				
				exit  // chiude xchè ha elaborato tutto
				
			end if
			
			k_fila = ads_queue.getitemnumber(k_riga_find, "fila")
			k_barcode = ads_queue.getitemstring(k_riga_find, "barcode")

//--- Get ll primo Pallet che esce dal PILOTA: ordina i dati x FILA + DATA FINE LAV 
			ads_queue.setsort( "fila, dataora_lav_fin_prev asc")
			ads_queue.sort()
			//k_righe = ads_queue.rowcount( )
			//ads_queue.getitemdatetime(k_riga_find, "dataora_lav_fin_prev")) + "') "
			if k_fila = 1 then
				k_find =  "fila = " + string(k_fila) + " and dataora_lav_fin_prev > datetime('" + string(k_dataora_lav_fin_prev_x_fila_1) + "') and barcode <> '" + k_barcode_x_fila_1 + "'"
				k_riga_lav_fin = ads_queue.find(k_find, 1, k_righe )
				if k_riga_lav_fin > 0 then
					k_dataora_lav_fin_prev_x_fila_1 = ads_queue.getitemdatetime(k_riga_lav_fin, "dataora_lav_fin_prev")
					k_barcode_x_fila_1 = ads_queue.getitemstring(k_riga_lav_fin, "barcode")
				end if
			else
				k_find =  "fila = " + string(k_fila) + " and dataora_lav_fin_prev > datetime('" + string(k_dataora_lav_fin_prev_x_fila_2) + "') and barcode <> '" + k_barcode_x_fila_2 + "'"
				k_riga_lav_fin = ads_queue.find(k_find, 1, k_righe )
				if k_riga_lav_fin > 0 then
					k_dataora_lav_fin_prev_x_fila_2 = ads_queue.getitemdatetime(k_riga_lav_fin, "dataora_lav_fin_prev")
					k_barcode_x_fila_2 = ads_queue.getitemstring(k_riga_lav_fin, "barcode")
				end if
			end if
			if k_riga_lav_fin = 0 then    // MOLTO strano non trovare neanche un barcode con data_lav_fine_prev > 0
				exit   // STRANO NON DVE ANDARE MAI QUI!
			end if				
//--- ritrova la riga da aggiornare
			k_riga_upd = ads_queue.find("barcode = '" + k_barcode + "'", 1, k_righe)
			if k_riga_upd = 0 then
				exit   // ERRORE MAI QUI!
			end if

			k_dataora_lav_fin = ads_queue.getitemdatetime(k_riga_lav_fin, "dataora_lav_fin_prev")
			
//--- add tot minuti x carico	materiale
			k_dataora_lav_fin = kiuf_date.u_datetime_after_minute(k_dataora_lav_fin, 3)

			ads_queue.setitem( k_riga_upd, "dataora_lav_ini", k_dataora_lav_fin)  // aggiorna la data INIZIO lavorazione
			
			u_set_dataora_lav_prev_fin_1(ads_queue, k_riga_upd)  // imposta la data di fine lav prevista

//--- preleva le date appena generate
			k_dataora_lav_ini = ads_queue.getitemdatetime( k_riga_upd, "dataora_lav_ini")
			k_dataora_lav_fin = ads_queue.getitemdatetime( k_riga_upd, "dataora_lav_fin_prev")
					
//--- Aggiorna anche tutte le righe dei pallet in H che in B (Alto+Basso) + di groupage (hanno lo stesso numero 'ordine') 
			k_riga = k_riga_upd
			k_dataora_lav_ini = ads_queue.getitemdatetime(k_riga, "dataora_lav_ini")
			k_dataora_lav_fin_prev = ads_queue.getitemdatetime(k_riga, "dataora_lav_fin_prev")
			//k_dataora_lav_fin_min_prev =  ads_queue.getitemdatetime(k_riga, "dataora_lav_fin_min_prev")
			//k_dataora_lav_fin_max_prev = ads_queue.getitemdatetime(k_riga, "dataora_lav_fin_max_prev")
			k_avg_time_io_minute = ads_queue.getitemnumber(k_riga, "avg_time_io_minute")

			k_ordine_queue = ads_queue.getitemnumber(k_riga, "n_ordine")

		//	ads_queue.saveas("c:\ufo\dbg"+ string(k_ctr) + "B_DOPO_UPDATE.xls",Excel!, true)    //DBG
			
//--- riordina i dati x N.ORDINE
			k_rc = ads_queue.update()    // aggiorna i dati su pallet in Programmazione
			ads_queue.setsort( "n_ordine asc")
			ads_queue.sort()
			k_riga = ads_queue.find("n_ordine = " + string(k_ordine_queue), 1, k_righe)
			//ads_queue.saveas("c:\ufo\dbg"+ string(k_ctr) + "C_DOPO_SORT.xls",Excel!, true)    //DBG
			for k_riga = k_riga to k_righe
				k_n_ordine = ads_queue.getitemnumber(k_riga, "n_ordine")
				if k_ordine_queue = k_n_ordine or (k_ordine_queue + 1) = k_n_ordine then
					
					//u_set_ds_pilota_queue_data_prev_1(k_riga)
					ads_queue.setitem(k_riga, "dataora_lav_ini", k_dataora_lav_ini)
					ads_queue.setitem(k_riga, "dataora_lav_fin_prev", k_dataora_lav_fin_prev)
//					ads_queue.setitem(k_riga, "dataora_lav_fin_min_prev", k_dataora_lav_fin_min_prev)
//					ads_queue.setitem(k_riga, "dataora_lav_fin_max_prev", k_dataora_lav_fin_max_prev)
					ads_queue.setitem(k_riga, "avg_time_io_minute", k_avg_time_io_minute)
					//ads_queue.setitem(k_riga, "dataora_lav_fin_prev_dtpl", ads_queue.getitemdatetime( k_riga - 1, "dataora_lav_fin_prev_dtpl"))
				else
					exit
				end if 
			next
	
		loop
// ads_queue.SaveAs("c:\ufo\workqueue_0.csv", CSV!, true)  //DBG
			
		k_rc = ads_queue.update()    // aggiorna i dati su pallet in Programmazione

		kguo_sqlca_db_magazzino.db_commit( )
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

//		if isvalid(kds_work) then destroy kds_work
//		if isvalid(ads_queue) then destroy ads_queue
//		if isvalid(kds_prev_dtfin_xdtpl) then destroy kds_prev_dtfin_xdtpl

	end try
		

//return ads_queue
	

end subroutine

public subroutine get_time_io_minute (ref st_tab_s_avgtimeplant ast_tab_s_avgtimeplant) throws uo_exception;//
//-------------------------------------------------------------------------------------------
//--- Torna il N.giri mancanti in Lav (previsit) e in Coda leggendo dal PILOTA
//--- Out: st_pilota_giri_tempi
//-------------------------------------------------------------------------------------------
//
//
long k_rows=0, k_row=0
int k_rc
string k_find

	 
	try
		
		kguo_exception.inizializza(this.classname())
		
//--- preleva i valori dalla band di GROUP dei minuti medi di un giro x fila 1 e 2
		k_rows = kids_barcode_avgtimeplant.rowcount()
		
		if isnull(ast_tab_s_avgtimeplant.giri_f1) then ast_tab_s_avgtimeplant.giri_f1 = 0
		if isnull(ast_tab_s_avgtimeplant.giri_f1p) then ast_tab_s_avgtimeplant.giri_f1p = 0
		if isnull(ast_tab_s_avgtimeplant.giri_f2) then ast_tab_s_avgtimeplant.giri_f2 = 0
		if isnull(ast_tab_s_avgtimeplant.giri_f2p) then ast_tab_s_avgtimeplant.giri_f2p = 0
		
		k_find = "giri_f1 = " + string(ast_tab_s_avgtimeplant.giri_f1) &
					+ " and giri_f1p = " + string(ast_tab_s_avgtimeplant.giri_f1p) &
					+ " and giri_f2 = " + string(ast_tab_s_avgtimeplant.giri_f2) &
					+ " and giri_f2p = " + string(ast_tab_s_avgtimeplant.giri_f2p) 
					
		k_row = kids_barcode_avgtimeplant.find(k_find, 1, k_rows)
		
		if k_row > 0 then
			ast_tab_s_avgtimeplant.time_io_minute = kids_barcode_avgtimeplant.getitemnumber(k_row, "time_io_minute") 
		end if
		
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

	

end subroutine

public function long crea_temptable_pilota_pallet_workqueue () throws uo_exception;//---
//--- Popola il ds con i barcode in programmazione nel PILOTA 
//---
//
int k_rc
long k_rows
uo_ds_std_1 kds_temptable_pilota_pallet_workqueue, kds_queue

try  
	
//--- popola tabella temp con i data ini e fin previsti ( tutto quello nel Pilota in Lav e  in Coda di Programmazione) 		
	kds_temptable_pilota_pallet_workqueue = u_set_temptable_pilota_pallet_workqueue( )
	
	k_rows = kds_temptable_pilota_pallet_workqueue.rowcount( )
	if k_rows > 0 then
		kds_queue = u_get_ds_pilota_workqueue_all( )

		u_set_ds_pilota_queue_data_prev_all(kds_queue)	  // imposta data fine lav per rec WORK + QUEUE
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try

return k_rows
end function

public function long crea_temptable_pilota_pallet_in_lav () throws uo_exception;//---
//--- Popola ds con i barcode in lavorazione nel PILOTA e add all data from M2000
//---
//
long k_rows
 
try 

//--- popola tabella temp con i data ini e fin previsti ( tutto quello nel Pilota in Lav e  in Coda di Programmazione) 		
	u_set_temptable_pilota_pallet_workqueue( )

	k_rows = u_set_dataora_lav_prev_fin( )	  // imposta data fine lav per rec in lavorazione


catch (uo_exception kuo_exception)
	throw kguo_exception
	
finally
	
end try

return k_rows
end function

private function uo_ds_std_1 u_set_temptable_pilota_pallet_workqueue () throws uo_exception;//
//-------------------------------------------------------------------------------------------------------
//--- Recupera da PILOTA tutti i pallet in-lav (WORK) e in coda (QUEUE) e crea la TEMP TABLE con i PALLET
//--- Out: datastore con i dati della temp-table
//-------------------------------------------------------------------------------------------------------
//
//
long k_righe=0, k_riga=0
int k_rc
long k_rigainsert
string k_campi, k_stato
string k_sql_orig, k_string, k_stringn
int k_ctr
string k_barcode_figli
st_tab_pilota_pallet kst_tab_pilota_pallet
uo_ds_std_1 kds_out, kds_inp


try
	
//--- popola pallet in lav e in coda in una tabella di appoggio: #vx_pilota_prev_lav

	k_campi = "stato char(6) " &
					+ " , n_ordine int " &
					+ " , barcode char(13) " &
					+ " , barcode_figlio char(13) " &
					+ " , ordine_figlio tinyint " &
					+ " , num_int_figlio int " &
					+ " , posizione tinyint " &
				 	+ " , wrkt_fase tinyint " &
					+ " , fase tinyint " &
					+ " , fila tinyint " &
					 + ", ciclifila1 smallint " &
					 + ", ciclifila1p smallint " &
					 + ", ciclifila2 smallint " &
					 + ", ciclifila2p smallint " &
					 + ", wip_ciclifila1 smallint " &
					 + ", wip_ciclifila1p smallint " &
					 + ", wip_ciclifila2 smallint " &
					 + ", wip_ciclifila2p smallint " &
					 + ", dataora_lav_ini datetime " &
					 + ", dataora_lav_fin_prev datetime " &
					 + ", dataora_lav_fin_min_prev datetime " &
					 + ", dataora_lav_fin_max_prev datetime " &
					 + ", dataora_lav_fin_prev_dtpl datetime " &
					 + ", avg_time_io_minute integer" 
//	   	kguo_sqlca_db_magazzino.db_crea_temp_table_global(ki_temptab_pilota_workqueue, k_campi, "")      
		kguo_sqlca_db_magazzino.db_crea_temp_table(ki_temptab_pilota_workqueue, k_campi, "")      
//	   	kguo_sqlca_db_magazzino.db_crea_table( ki_temptab_pilota_workqueue, k_campi)      
			
	kds_inp = CREATE uo_ds_std_1
	kds_inp.dataobject = ki_ds_pallet_workqueue_dataobject    
	k_rc = kds_inp.SetTrans (kguo_sqlca_db_pilota)

	kds_out = CREATE uo_ds_std_1
	kds_out.dataobject = "ds_pilota_pallet_workqueue_temp"
	k_rc = kds_out.SetTransObject (kguo_sqlca_db_magazzino)

	kguf_data_base.u_set_ds_change_name_tab(kds_out, "vx_MAST_pilota_pallet_workqueue")

	k_righe = kds_inp.retrieve( )    // get dal db PILOTA tutti i PALLET in lavorazione e in coda 
	if k_righe < 0 then
		kguo_exception.set_st_esito_err_ds(kds_inp, "Errore in lettura Pallet in Coda e in Lavorazione sul Gamma2. ")
		kguo_sqlca_db_magazzino.db_rollback( )
		throw kguo_exception
	end if		

	for k_riga = 1 to k_righe 
		k_rigainsert = kds_out.insertrow( 0 )
		
		k_stato = kds_inp.getitemstring(k_riga, "stato")  //stato = WORK (in lav) o QUEUE (in coda)
		kds_out.setitem( k_rigainsert, "stato", k_stato )
		kds_out.setitem( k_rigainsert, "n_ordine", kds_inp.getitemnumber(k_riga, "n_ordine") )
		kds_out.setitem( k_rigainsert, "barcode", kds_inp.getitemstring(k_riga, "barcode") )

//--- Raccoglie figli e dosimetri
		if trim(kds_inp.getitemstring(k_riga, "barcode_figlio")) > " " then
			k_barcode_figli = trim(kds_inp.getitemstring(k_riga, "barcode_figlio"))
		end if
		if trim(kds_inp.getitemstring(k_riga, "padre_barcode_dosimetro")) > " " then
			k_barcode_figli += " " + trim(kds_inp.getitemstring(k_riga, "padre_barcode_dosimetro"))
		end if
		if trim(kds_inp.getitemstring(k_riga, "figlio_barcode_dosimetro")) > " " then
			k_barcode_figli += " " + trim(kds_inp.getitemstring(k_riga, "figlio_barcode_dosimetro"))
		end if
		kds_out.setitem( k_rigainsert, "barcode_figlio", k_barcode_figli )

		//kds_out.setitem( k_rigainsert, "barcode_figlio", kds_inp.getitemstring(k_riga, "barcode_figlio") )
		kds_out.setitem( k_rigainsert, "ordine_figlio", kds_inp.getitemnumber(k_riga, "ordine_figlio") )
		kds_out.setitem( k_rigainsert, "num_int_figlio", integer(kds_inp.getitemstring(k_riga, "lotto_figlio") ))
		kds_out.setitem( k_rigainsert, "posizione", integer(kds_inp.getitemstring(k_riga, "posizione") ))
		
		kst_tab_pilota_pallet.data_entrata = kds_inp.getitemdatetime(k_riga, "k_dataora_lav_ini")
		if k_stato = "WORK" then 
			if kst_tab_pilota_pallet.data_entrata > datetime(date(0)) then
			else
				//--- capita a volte che il PALLET è in LAV ma ancora senza data per un po' allora forza adesso
				kst_tab_pilota_pallet.data_entrata = kguo_g.get_datetime_current( )
			end if
		end if
		kds_out.setitem( k_rigainsert, "dataora_lav_ini", kst_tab_pilota_pallet.data_entrata )
		kds_out.setitem( k_rigainsert, "fase", kds_inp.getitemnumber(k_riga, "fase") )
		int k_fase 
		kds_out.setitem( k_rigainsert, "wrkt_fase", kds_inp.getitemnumber(k_riga, "wrkt_fase") )
		kds_out.setitem( k_rigainsert, "fila", kds_inp.getitemnumber(k_riga, "fila") )
		kds_out.setitem( k_rigainsert, "ciclifila1", kds_inp.getitemnumber(k_riga, "ciclifila1") )
		kds_out.setitem( k_rigainsert, "ciclifila1p", kds_inp.getitemnumber(k_riga, "ciclifila1p") )
		kds_out.setitem( k_rigainsert, "ciclifila2", kds_inp.getitemnumber(k_riga, "ciclifila2") )
		kds_out.setitem( k_rigainsert, "ciclifila2p", kds_inp.getitemnumber(k_riga, "ciclifila2p") )
		kds_out.setitem( k_rigainsert, "wip_ciclifila1", kds_inp.getitemnumber(k_riga, "wip_ciclifila1") )
		kds_out.setitem( k_rigainsert, "wip_ciclifila1p", kds_inp.getitemnumber(k_riga, "wip_ciclifila1p") )
		kds_out.setitem( k_rigainsert, "wip_ciclifila2", kds_inp.getitemnumber(k_riga, "wip_ciclifila2") )
		kds_out.setitem( k_rigainsert, "wip_ciclifila2p", kds_inp.getitemnumber(k_riga, "wip_ciclifila2p") )
	end for

	if kds_out.rowcount() > 0 then
		k_rc = kds_out.update() 
		if k_rc < 0 then
			kguo_exception.set_st_esito_err_ds(kds_out, "Errore in aggiornamento tabella temporanea dei Pallet in Coda e in Lavorazione sul Gamma2. " &
								+ ", il primo Barcode da aggiornare era: " + trim(kds_out.getitemstring(1, "barcode")) + ". ")
			kguo_sqlca_db_magazzino.db_rollback( )
			throw kguo_exception
		end if		
	
		kguo_sqlca_db_magazzino.db_commit( )
	end if		
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log()
	throw kuo_exception

finally
	if isvalid(kds_inp) then destroy kds_inp
	//if isvalid(kds_out) then destroy kds_out

end try
	

return kds_out //k_rigainsert
	

end function

private function uo_ds_std_1 u_get_ds_pilota_workqueue_all () throws uo_exception;//
//--------------------------------------------------------------------------------------
//--- Aggiorna la data di fine lavorazione in tab 'previsioni' per 
//--- i pallet in lavorazione (WORK)
//---
//--------------------------------------------------------------------------------------
//
//
long k_riga, k_righe
int k_rc
uo_ds_std_1 kds_out, kds_1	
	
	try

		kds_out = CREATE uo_ds_std_1
		kds_out.dataobject = "ds_pilota_workqueue_tmp"
		k_rc = kds_out.SetTransObject (kguo_sqlca_db_magazzino)

		kguf_data_base.u_set_ds_change_name_tab(kds_out, "vx_MAST_pilota_pallet_workqueue")
		
		k_righe = kds_out.retrieve("*")
		if k_righe < 1 then //verifica se la tabella temp esiste altrimenti la popola
		
//--- popola tabella temp con i data ini e fin previsti ( tutto quello che c'e' nel Pilota in Lav e  in Coda di Programmazione) 		
			kds_1 = u_set_temptable_pilota_pallet_workqueue( )
			k_righe = kds_1.rowcount( )
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

	end try
		

return kds_out
	

end function

private function uo_ds_std_1 u_get_ds_pilota_work () throws uo_exception;//
//--------------------------------------------------------------------------------------
//--- Aggiorna la data di fine lavorazione in tab 'previsioni' per 
//--- i pallet in lavorazione (WORK)
//---
//--------------------------------------------------------------------------------------
//
//
long k_riga, k_righe
int k_rc
uo_ds_std_1 kds_out, kds_1
	
	try

		kds_out = CREATE uo_ds_std_1
		kds_out.dataobject = "ds_pilota_workqueue_tmp"
		k_rc = kds_out.SetTransObject (kguo_sqlca_db_magazzino)

		kguf_data_base.u_set_ds_change_name_tab(kds_out, "vx_MAST_pilota_pallet_workqueue")
		
		k_righe = kds_out.retrieve("WORK")
		if k_righe < 1 then //verifica se la tabella temp esiste altrimenti la popola
		
//--- popola tabella temp con i data ini e fin previsti ( tutto quello che c'e' nel Pilota in Lav e  in Coda di Programmazione) 		
			kds_1 = u_set_temptable_pilota_pallet_workqueue( )
			k_righe = kds_1.rowcount( )
			if k_righe > 0 then
				k_righe = kds_out.retrieve("WORK")
			end if
		end if
		
		if k_righe < 1 then
			
			kguo_exception.inizializza( )
			kguo_exception.kist_esito.esito = kguo_exception.KK_st_uo_exception_tipo_internal_bug
			kguo_exception.kist_esito.sqlerrtext = "Il numero di righe estratte dalla tab. temp #" + ki_temptab_pilota_workqueue + " non può essere a zero! " &
			                      + kkg.acapo + kds_out.kist_esito.sqlerrtext
			kguo_exception.kist_esito.nome_oggetto = this.classname( )
			kguo_exception.scrivi_log( )
			throw kguo_exception
			
		end if
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return kds_out
	

end function

private function datastore u_append_ds_pallet_workqueue (ref uo_ds_std_1 ads_inp) throws uo_exception;//---
//--- Popola ads_inp con i dati di programmazione inizio-fine lav
//---
//
int k_rc
string k_n_ordine_x
long k_row, k_rows, k_rows_inp, k_n_ordine, k_rows_queue
datetime k_datetime_zero
uo_ds_std_1 kds_temptable_pilota_pallet_workqueue, kds_queue

try  
	

	k_datetime_zero = datetime(date(0))
	
//--- popola tabella temp con i data ini e fin previsti ( tutto quello nel Pilota in Lav e  in Coda di Programmazione) 		
	kds_temptable_pilota_pallet_workqueue = u_set_temptable_pilota_pallet_workqueue( )
	
	if kds_temptable_pilota_pallet_workqueue.rowcount() > 0 then

		kds_queue = u_get_ds_pilota_workqueue_all( )
		k_rows_queue = kds_queue.rowcount()
		
		if isvalid(ads_inp) then 
			k_rows_inp = ads_inp.rowcount()
			if k_rows_inp > 0 then
		
//--- Se ho passato qualcosa imposta il n.ordine e ACCODA ads_inp al kds_queue 
				k_n_ordine_x = kds_queue.describe("evaluate ('max(n_ordine for all)',0)")
				if isnumber(trim(k_n_ordine_x)) then
					k_n_ordine = long(trim(k_n_ordine_x))
					for k_row = 1 to k_rows_inp
						ads_inp.setitem(k_row, "stato", "ADD")
						ads_inp.setitem(k_row, "n_ordine", (k_n_ordine + k_row))
						ads_inp.setitem(k_row, "dataora_lav_ini", k_datetime_zero)
						ads_inp.setitem(k_row, "dataora_lav_fin_prev", k_datetime_zero)
					next
					ads_inp.rowscopy(1, k_rows_inp, primary!, kds_queue, (k_rows_queue + 1), primary!)
					kds_queue.update( )
				end if
			end if

//--- imposta data fine lav per rec WORK + QUEUE + i dati del ads_inp passati	
			u_set_ds_pilota_queue_data_prev_all(kds_queue)	  
//DBG kds_queue.SaveAs("c:\ufo\workqueue_1.csv", CSV!, true)
//			k_rows = kds_queue.rowcount( )
//					for k_row = 1 to k_rows
//						k_barcode = kds_queue.getitemstring(k_row, "barcode")
//						k_fila_1 = kds_queue.getitemnumber(k_row, "ciclifila1")
//						k_fila_2 = kds_queue.getitemnumber(k_row, "ciclifila2")
//						k_fila = kds_queue.getitemnumber(k_row, "fila")
//						k_stato = kds_queue.getitemstring(k_row, "stato")
//						kdataora_lav_ini = kds_queue.getitemdatetime(k_row, "dataora_lav_ini")
//						kdataora_lav_fin_prev = kds_queue.getitemdatetime(k_row, "dataora_lav_fin_prev")
//					next
			
		end if
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try

return kds_queue
end function

public function uo_ds_std_1 get_ds_pallet_workqueue_by_d_pl_barcode (ref datawindow ads_inp) throws uo_exception;//
//--- Restituisce un DS su cui add i dati barcode e fila su cui poi calcolare la data di fine/inizio lav
//--- Input: ds con le colonne: 
//---                      barcode_barcode, barcode_fila_1, barcode_fila_1p, barcode_fila_2, barcode_fila_2p
//--- Out: datastore completo di barcode e data_lav_fin, con le colonne: barcode, 
//---								numero giri fila 1 e fila 2 (ciclifila1+ciclifila1p o ciclifila2+ciclifila2p)
//---
long k_rows, k_row
//st_tab_barcode kst_tab_barcode
st_tab_s_avgtimeplant kst_tab_s_avgtimeplant
uo_ds_std_1 kds_queue_add, kds_queue


try
	kds_queue_add = CREATE uo_ds_std_1
	kds_queue_add.dataobject = "ds_pilota_workqueue_tmp"

	k_rows = ads_inp.rowcount()
	
	if k_rows > 0 then
	
//--- copia i dati del ads_inp nella QUEUE da aggiungere poi ai barcode già in programmazione
		for k_row = 1 to k_rows
			kst_tab_s_avgtimeplant.giri_f1 = ads_inp.getitemnumber(k_row, "barcode_fila_1")
			kst_tab_s_avgtimeplant.giri_f1p = ads_inp.getitemnumber(k_row, "barcode_fila_1p")
			kst_tab_s_avgtimeplant.giri_f2 = ads_inp.getitemnumber(k_row, "barcode_fila_2")
			kst_tab_s_avgtimeplant.giri_f2p = ads_inp.getitemnumber(k_row, "barcode_fila_2p")
			get_time_io_minute(kst_tab_s_avgtimeplant) // get tempo medio x i giri richiesti
			kds_queue_add.insertrow(0)
			kds_queue_add.setitem(k_row, "barcode", ads_inp.getitemstring(k_row, "barcode_barcode"))
			kds_queue_add.setitem(k_row, "ciclifila1", kst_tab_s_avgtimeplant.giri_f1)
			kds_queue_add.setitem(k_row, "ciclifila1p", kst_tab_s_avgtimeplant.giri_f1p)
			kds_queue_add.setitem(k_row, "ciclifila2", kst_tab_s_avgtimeplant.giri_f2)
			kds_queue_add.setitem(k_row, "ciclifila2p", kst_tab_s_avgtimeplant.giri_f2p)
			kds_queue_add.setitem(k_row, "time_io_minute_avg", kst_tab_s_avgtimeplant.time_io_minute)
			kds_queue_add.setitem(k_row, "avg_time_io_minute", kst_tab_s_avgtimeplant.time_io_minute)
			
			if kst_tab_s_avgtimeplant.giri_f1 > 0 then
				kds_queue_add.setitem(k_row, "fila", 1)
			else
				kds_queue_add.setitem(k_row, "fila", 2)
			end if
		next
	
	end if
	
//--- add dati del ads_inp nella QUEUE da aggiungere poi ai barcode già in programmazione
	kds_queue = u_append_ds_pallet_workqueue(kds_queue_add)
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kds_queue_add) then destroy kds_queue_add
	
end try


return kds_queue

end function

on kuf_pilota_previsioni.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_pilota_previsioni.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//
	if isvalid(kids_barcode_avgtimeplant) then destroy kids_barcode_avgtimeplant 
	if isvalid(kids_ds_queue_lav_xfila) then destroy kids_ds_queue_lav_xfila
	if isvalid(kiuf_date) then destroy kiuf_date 


end event

event constructor;//

try
	
	kiuf_date = create kuf_date

	ki_temptab_pilota_workqueue = kguf_data_base.u_change_nometab_xutente( "vx_MAST_pilota_pallet_workqueue")
	ki_temptab_pilota_prev_lav = kguf_data_base.u_change_nometab_xutente( "vx_MAST_pilota_prev_lav")

	u_set_barcode_avgtimeplant( ) //--- popola ds tempi medi impianto

catch (uo_exception kuo_exception)
	
end try

end event

