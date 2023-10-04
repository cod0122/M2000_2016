$PBExportHeader$kuo_sqlca_db_pilota.sru
forward
global type kuo_sqlca_db_pilota from kuo_sqlca_db_0
end type
end forward

global type kuo_sqlca_db_pilota from kuo_sqlca_db_0
end type
global kuo_sqlca_db_pilota kuo_sqlca_db_pilota

forward prototypes
private subroutine x_db_profilo () throws uo_exception
end prototypes

private subroutine x_db_profilo () throws uo_exception;//
//--- Imposta i parametri di connessione su questo oggetto
//--- Solleva una ECCEZIONE x errore
//
boolean k_return = true
string k_file, k_sezione
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
kuf_pilota_cmd kuf1_pilota_cmd
kuo_sqlca_db_pilota kuo1_sqlca_db_pilota


try

//--- Puntatore Cursore da attesa.....
		oldpointer = SetPointer(HourGlass!)
		
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = ""
		kst_esito.nome_oggetto = this.classname()
	
	
		kuf1_pilota_cmd = create kuf_pilota_cmd
		
		kuo1_sqlca_db_pilota = kuf1_pilota_cmd.get_profilo_db()
		
		this.dbms = kuo1_sqlca_db_pilota.dbms
		this.dbparm = kuo1_sqlca_db_pilota.dbparm
		this.AutoCommit = kuo1_sqlca_db_pilota.AutoCommit
		
		
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
		if isvalid(kuo1_sqlca_db_pilota) then destroy kuo1_sqlca_db_pilota
		if isvalid(kuf1_pilota_cmd) then destroy kuf1_pilota_cmd 

		SetPointer(oldpointer)

end try




end subroutine

on kuo_sqlca_db_pilota.create
call super::create
end on

on kuo_sqlca_db_pilota.destroy
call super::destroy
end on

event constructor;call super::constructor;//
	ki_db_descrizione = "DB del PILOTA IMPIANTO"
	ki_title_id = "db_pilota"
end event

