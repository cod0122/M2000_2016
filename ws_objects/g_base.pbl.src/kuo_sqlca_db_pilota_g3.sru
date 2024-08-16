$PBExportHeader$kuo_sqlca_db_pilota_g3.sru
forward
global type kuo_sqlca_db_pilota_g3 from kuo_sqlca_db_0
end type
end forward

global type kuo_sqlca_db_pilota_g3 from kuo_sqlca_db_0
end type
global kuo_sqlca_db_pilota_g3 kuo_sqlca_db_pilota_g3

forward prototypes
protected subroutine x_db_profilo () throws uo_exception
end prototypes

protected subroutine x_db_profilo () throws uo_exception;//
//--- Imposta i parametri di connessione su questo oggetto
//--- Solleva una ECCEZIONE x errore
//
boolean k_return = true
string k_file, k_sezione
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
kuf_pilota_g3_cfg kuf1_pilota_g3_cfg
kuo_sqlca_db_pilota_g3 kuo1_sqlca_db_pilota_g3


try

//--- Puntatore Cursore da attesa.....
		oldpointer = SetPointer(HourGlass!)
		
		kst_esito = kguo_exception.inizializza(this.classname())
	
		kuf1_pilota_g3_cfg = create kuf_pilota_g3_cfg
		
		kuf1_pilota_g3_cfg.get_profilo_db(kuo1_sqlca_db_pilota_g3)
		
		this.dbms = kuo1_sqlca_db_pilota_g3.dbms
		this.dbparm = kuo1_sqlca_db_pilota_g3.dbparm
		this.AutoCommit = kuo1_sqlca_db_pilota_g3.AutoCommit
		
		
		if trim(this.dbms) = "nessuno"  then
			k_return = false
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText =  "Non trovata definizione del 'DB Pilota' in 'Proprietà Pilota' "+ &
						+ kkg.acapo + "Impossibile stabilire la connessione con il DB: ~n~r" +  &
						"(" + trim(this.dbms) + " DbParm " + &
						trim(this.dbparm) + ") " & 
						+ kkg.acapo + "Definizione cercata nella Tabella: PILOTA_CFG " &
						+ kkg.acapo + "Non sara' possibile operare sugli archivi del Server dell'Impianto (il Pilota) ~n~r" 
						
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		
		end if

	catch (uo_exception k1uo_exception)
		throw k1uo_exception
	
	finally
		if isvalid(kuo1_sqlca_db_pilota_g3) then destroy kuo1_sqlca_db_pilota_g3
		if isvalid(kuf1_pilota_g3_cfg) then destroy kuf1_pilota_g3_cfg 

		SetPointer(oldpointer)

end try




end subroutine

on kuo_sqlca_db_pilota_g3.create
call super::create
end on

on kuo_sqlca_db_pilota_g3.destroy
call super::destroy
end on

event constructor;call super::constructor;//
	ki_db_descrizione = "DB dati di Lavorazione dal PILOTA Impianto G3"
	ki_title_id = "db_pilota"
end event

