$PBExportHeader$kuf_listino_duplica_massiva.sru
forward
global type kuf_listino_duplica_massiva from kuf_parent
end type
end forward

global type kuf_listino_duplica_massiva from kuf_parent
end type
global kuf_listino_duplica_massiva kuf_listino_duplica_massiva

type variables
private kuf_listino kiuf_listino
private kuf_esito_operazioni kiuf_esito_operazioni
end variables

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public subroutine log_destroy ()
public function kuf_esito_operazioni log_inizializza () throws uo_exception
public function long u_duplica_listini (ref st_listino_duplica ast_listino_duplica[]) throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
if ast_open_w.flag_modalita > " " then
else
	ast_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
end if

//--- le autorizzazioni sono le stesse del LISTINO
ast_open_w.id_programma = kiuf_listino.get_id_programma(ast_open_w.flag_modalita)
return kiuf_listino.if_sicurezza(ast_open_w)


end function

public subroutine log_destroy ();//
if isvalid(kiuf_esito_operazioni) then destroy kiuf_esito_operazioni


 
end subroutine

public function kuf_esito_operazioni log_inizializza () throws uo_exception;//
//--- inizializza il log delle operazioni	
	if not isvalid(kiuf_esito_operazioni) then kiuf_esito_operazioni = create kuf_esito_operazioni

	kiuf_esito_operazioni.inizializza( kiuf_esito_operazioni.kki_tipo_operazione_dup_listini )


 return kiuf_esito_operazioni
end function

public function long u_duplica_listini (ref st_listino_duplica ast_listino_duplica[]) throws uo_exception;//
//--- Duplica listini
//--- input:  st_listino_duplica = id_listino (da duplicare) + dati da cambiare rispetto agli originali
//--- Out: id_listino[] nuovi
//--- rit: Numero duplicati
//---
boolean k_stampato=true, k_sicurezza=true
int k_ctr=0, k_nr_duplicati=0, k_nr_da_duplicare, k_riga
st_tab_listino kst_tab_listino, kst_tab_listino_nuovo, kst_tab_listino_nullo
st_tab_contratti kst_tab_contratti
st_esito kst_esito 
kuf_contratti kuf1_contratti


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	
	
	if if_sicurezza(kkg_flag_modalita.inserimento) then
	
		k_nr_da_duplicare = upperbound(ast_listino_duplica[]) 
	
		for k_riga = 1 to k_nr_da_duplicare
	
			if ast_listino_duplica[k_riga].id_listino > 0 then
				
				kst_tab_listino = kst_tab_listino_nullo
				kst_tab_listino.id = ast_listino_duplica[k_riga].id_listino
				kst_tab_listino.prezzo = ast_listino_duplica[k_riga].prezzo
				kst_tab_listino.prezzo_2 = ast_listino_duplica[k_riga].prezzo_2
				kst_tab_listino.prezzo_3 = ast_listino_duplica[k_riga].prezzo_3
				kst_tab_listino.attivo = ast_listino_duplica[k_riga].attivo
				kst_tab_listino.dt_start = ast_listino_duplica[k_riga].dt_start
				kst_tab_listino.dt_end = ast_listino_duplica[k_riga].dt_end
	
				kst_tab_listino_nuovo.id_parent = ast_listino_duplica[k_riga].id_listino
	
	//--- DUPLICA
				ast_listino_duplica[k_riga].id_listino = kiuf_listino.tb_duplica(kst_tab_listino)  // DUPLICA LISTINO
				if ast_listino_duplica[k_riga].id_listino > 0 then
					
					if ast_listino_duplica[k_riga].dt_start > date(0) then
						kst_tab_listino_nuovo.dt_start = ast_listino_duplica[k_riga].dt_start
						kst_tab_listino_nuovo.id = ast_listino_duplica[k_riga].id_listino // nuovo ID
						kiuf_listino.set_dt_end_parent(kst_tab_listino_nuovo)  // aggiusta la data di fine validità nel Listino originale
					end if
					
					kuf1_contratti = create kuf_contratti
					kst_tab_listino_nuovo.id = ast_listino_duplica[k_riga].id_listino // nuovo ID
					kst_tab_listino.contratto = kiuf_listino.get_contratto(kst_tab_listino_nuovo)
					if kst_tab_listino.contratto > 0 then
						kuf1_contratti = create kuf_contratti
						kst_tab_contratti.codice = kst_tab_listino.contratto
						kuf1_contratti.get_data_scad(kst_tab_contratti)
						if ast_listino_duplica[k_riga].dt_end > kst_tab_contratti.data_scad then
							kst_tab_contratti.data_scad = ast_listino_duplica[k_riga].dt_end
							kuf1_contratti.set_data_scad(kst_tab_contratti) // aggiusta la data scadenza CO
						end if
					end if
					
					k_nr_duplicati ++
				end if
	
			end if
			
		next
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_contratti) then destroy kuf1_contratti
	
end try

return k_nr_duplicati

end function

on kuf_listino_duplica_massiva.create
call super::create
end on

on kuf_listino_duplica_massiva.destroy
call super::destroy
end on

event constructor;call super::constructor;//
kiuf_listino = create kuf_listino

end event

