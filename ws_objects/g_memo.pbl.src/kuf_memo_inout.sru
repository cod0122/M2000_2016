$PBExportHeader$kuf_memo_inout.sru
forward
global type kuf_memo_inout from kuf_parent
end type
end forward

global type kuf_memo_inout from kuf_parent
end type
global kuf_memo_inout kuf_memo_inout

type variables
//
private kuf_sr_sicurezza kiuf_sr_sicurezza
private kuf_armo kiuf_armo
private kuf_clienti kiuf_clienti
private kuf_memo kiuf_memo
private kuf_utility kiuf_utility
private kuf_memo_link kiuf_memo_link

end variables

forward prototypes
public subroutine memo_xmeca (ref st_tab_meca_memo ast_tab_meca_memo, ref st_tab_memo ast_tab_memo) throws uo_exception
public subroutine memo_xcliente (ref st_tab_clienti_memo ast_tab_clienti_memo, ref st_tab_memo ast_tab_memo) throws uo_exception
public function long crea_memo_meca (ref st_memo ast_memo, string a_file[]) throws uo_exception
public function long crea_memo_cliente (ref st_memo ast_memo, string a_file[]) throws uo_exception
public function long crea_memo (ref st_memo ast_memo, st_open_w ast_open_w, string a_file[]) throws uo_exception
public function long crea_memo_meca_ddt_in (ref st_memo ast_memo, string a_file[]) throws uo_exception
public subroutine memo_xmeca_ddt_in (ref st_tab_meca_memo ast_tab_meca_memo, ref st_tab_memo ast_tab_memo) throws uo_exception
end prototypes

public subroutine memo_xmeca (ref st_tab_meca_memo ast_tab_meca_memo, ref st_tab_memo ast_tab_memo) throws uo_exception;//
//--- imposta campi x MECA
//---
//--- Inp: st_tab_meca_memo.id_meca, st_tab_memo
//
string k_settore
st_tab_meca kst_tab_meca 
st_tab_clienti kst_tab_clienti
kuf_armo kuf1_armo
kuf_armo_inout kuf1_armo_inout
kuf_clienti kuf1_clienti
datastore kds_sr_settori


try   

	kds_sr_settori = create datastore
	kds_sr_settori.dataobject = "ds_sr_settori"
	kds_sr_settori.settransobject(kguo_sqlca_db_magazzino)

	kuf1_armo = create kuf_armo
	kuf1_armo_inout = create kuf_armo_inout
	kuf1_clienti = create kuf_clienti
	
	if ast_tab_meca_memo.id_meca_memo > 0 then
		kuf1_armo_inout.get_id_memo(ast_tab_meca_memo)
	else
		ast_tab_meca_memo.id_memo = 0
	end if
		
	if ast_tab_meca_memo.id_meca  > 0 then
		
		kst_tab_meca.id = ast_tab_meca_memo.id_meca
		kuf1_armo.get_num_int(kst_tab_meca)
		kuf1_armo.get_clie(kst_tab_meca)
		if kst_tab_meca.clie_1 > 0 then
			kst_tab_clienti.codice = kst_tab_meca.clie_1
			kuf1_clienti.get_nome(kst_tab_clienti)
		end if
		
		k_settore = ""
		ast_tab_memo.tipo_sv = ast_tab_meca_memo.tipo_sv
		if trim(ast_tab_meca_memo.tipo_sv) > " " then
			if kds_sr_settori.retrieve(ast_tab_meca_memo.tipo_sv) > 0 then
				k_settore = kds_sr_settori.getitemstring(1, "descr")
			end if
		end if
//		if ast_tab_meca_memo.tipo_sv > " " then
//			ast_tab_memo.titolo = "Informazioni dal dip. '" + ast_tab_meca_memo.tipo_sv + "' per il Lotto " + string(kst_tab_meca.num_int) + " / " + string(kst_tab_meca.data_int)
//		else
//			ast_tab_memo.titolo = "Informazioni  per il Lotto " + string(kst_tab_meca.num_int) + " / " + string(kst_tab_meca.data_int)
//		end if
		if kst_tab_meca.clie_1 > 0 then
			ast_tab_memo.titolo = "Da " + trim(kguo_utente.get_nome( )) &
											+ ". Lotto " + string(kst_tab_meca.num_int) + " " + string(kst_tab_meca.data_int, "dd mmm yy") &
											+ " " + trim(kst_tab_clienti.rag_soc_10) + " (" + string(kst_tab_clienti.codice) + ")"
		else
			ast_tab_memo.titolo = "Informazioni Lotto " + string(kst_tab_meca.num_int) + " del " + string(kst_tab_meca.data_int)
		end if
		if k_settore > " " then
			ast_tab_memo.note = "Note dal dip. '" + k_settore + "'. Lotto id " &
										+ string(kst_tab_meca.id) + " nr. " + string(kst_tab_meca.num_int) + " " + string(kst_tab_meca.data_int, "dd mmm yy") 
		else
			ast_tab_memo.note = "Note Lotto id " + string(kst_tab_meca.id) &
									+ " nr. " + string(kst_tab_meca.num_int) + " " + string(kst_tab_meca.data_int, "dd mmm yy") 
		end if
		
		ast_tab_memo.id_memo = ast_tab_meca_memo.id_memo
		
		
//		kst_memo.st_tab_memo = ast_tab_memo
//		kst_memo.st_tab_meca_memo = ast_tab_meca_memo
		
	end if
		 
catch (uo_exception	kuo_exception)
	throw kuo_exception
		
end try
	
//return kst_memo


end subroutine

public subroutine memo_xcliente (ref st_tab_clienti_memo ast_tab_clienti_memo, ref st_tab_memo ast_tab_memo) throws uo_exception;//
//--- imposta campi x ANAGRAFICHE
//---
//--- Inp: st_tab_clienti_memo, st_tab_memo
//
string k_settore
st_tab_clienti_memo kst_tab_clienti_memo 
st_tab_clienti kst_tab_clienti 
//st_tab_memo ast_tab_memo
datastore kds_sr_settori
kuf_clienti kuf1_clienti 
st_memo kst_memo

try   

	if ast_tab_clienti_memo.id_cliente  > 0 then

//--- imposta i dati di default del memo
		kst_memo.st_tab_clienti_memo = ast_tab_clienti_memo

		kuf1_clienti = create kuf_clienti
	
		kst_tab_clienti_memo = kst_memo.st_tab_clienti_memo
	
		kds_sr_settori = create datastore
		kds_sr_settori.dataobject = "ds_sr_settori"
		kds_sr_settori.settransobject(kguo_sqlca_db_magazzino)
		
		if kst_tab_clienti_memo.id_cliente_memo > 0 then
			kuf1_clienti.get_id_memo(kst_tab_clienti_memo)
		else
			kst_tab_clienti_memo.id_memo = 0
		end if
			
		kst_tab_clienti.codice = kst_tab_clienti_memo.id_cliente
		kuf1_clienti.get_nome(kst_tab_clienti)
		
		k_settore = ""
		ast_tab_memo.tipo_sv = kst_tab_clienti_memo.tipo_sv
		if trim(kst_tab_clienti_memo.tipo_sv) > " " then
			if kds_sr_settori.retrieve(kst_tab_clienti_memo.tipo_sv) > 0 then
				k_settore = kds_sr_settori.getitemstring(1, "descr")
			end if
		end if
//		if kst_tab_clienti_memo.tipo_sv > " " then
//			ast_tab_memo.titolo = "Informazioni da '" + kst_tab_clienti_memo.tipo_sv + "' per " + trim(kst_tab_clienti.rag_soc_10 )
//		else
			ast_tab_memo.titolo = "Da " + trim(kguo_utente.get_nome( )) + " per " + trim(kst_tab_clienti.rag_soc_10) + " " + trim(kst_tab_clienti.rag_soc_11) + " (" + string(kst_tab_clienti.codice) + ")"
//			ast_tab_memo.titolo = "Informazioni per " + trim(kst_tab_clienti.rag_soc_10 )
//		end if
		if k_settore > " " then
			ast_tab_memo.note = "Note dal dip. '" + k_settore + "' per " + string(kst_tab_clienti_memo.id_cliente) + " " + trim(kst_tab_clienti.rag_soc_10 ) 
		else
			ast_tab_memo.note = "Note per il " + string(kst_tab_clienti_memo.id_cliente) + " " + trim(kst_tab_clienti.rag_soc_10 ) 
		end if
		
		ast_tab_memo.id_memo = kst_tab_clienti_memo.id_memo
		
//		kst_memo.st_tab_memo = ast_tab_memo
//		kst_memo.st_tab_clienti_memo = kst_tab_clienti_memo
		
	end if
		
catch (uo_exception	kuo_exception)
	throw kuo_exception
		
end try
	
//return kst_memo

end subroutine

public function long crea_memo_meca (ref st_memo ast_memo, string a_file[]) throws uo_exception;//
//--- Crea in automatico un MEMO fascicolato x il LOTTO con anche gli allegati
//---
//--- Inp: st_memo.st_tab_meca_memo.id_meca + a_file[...] (i doc allegati)
//--- Out: st_memo valorizzata
//--- Rit: id_memo caricato
//
long k_return = 0
st_tab_clienti kst_tab_clienti 
st_tab_memo_link kst_tab_memo_link
st_tab_meca kst_tab_meca


try   

	if ast_memo.st_tab_meca_memo.id_meca > 0 then

		if NOT isvalid(kiuf_clienti) then kiuf_clienti = create kuf_clienti 
		if NOT isvalid(kiuf_armo) then kiuf_armo = create kuf_armo 
		if NOT isvalid(kiuf_memo) then kiuf_memo = create kuf_memo 
		if NOT isvalid(kiuf_memo_link) then kiuf_memo_link = create kuf_memo_link 
		
		memo_xmeca(ast_memo.st_tab_meca_memo, ast_memo.st_tab_memo)   	// imposta dati standard del memo 

		ast_memo.st_tab_memo.permessi = kiuf_sr_sicurezza.ki_permessi_scrittura 

		kst_tab_meca.id = ast_memo.st_tab_meca_memo.id_meca
		kiuf_armo.get_dati_rid(kst_tab_meca)
		kst_tab_clienti.codice = kst_tab_meca.clie_3
		kiuf_clienti.get_nome(kst_tab_clienti)
		ast_memo.st_tab_memo.memo = blob("{\rtf1\ansi Memo generato in automatico, settore '" + ast_memo.st_tab_memo.tipo_sv + "' " + " Lotto " + string(kst_tab_meca.num_int) + " " + string(kst_tab_meca.data_int) + " cliente " + " " + trim(kst_tab_clienti.rag_soc_10 ) + " (" + string(kst_tab_meca.clie_3) + "), leggere la sezione 'Allegati' \par }")
		
		ast_memo.st_tab_memo.id_memo = kiuf_memo.aggiorna(ast_memo)		// inserisce il memo su DB

		kst_tab_memo_link.id_memo = ast_memo.st_tab_memo.id_memo 
		kst_tab_memo_link.memo_link_load = ast_memo.st_tab_memo_link[1].memo_link_load 
		
		kiuf_memo_link.u_add_memo_link(kst_tab_memo_link, a_file[])

		k_return = ast_memo.st_tab_memo.id_memo 

	end if
		
		
catch (uo_exception	kuo_exception)
	throw kuo_exception
		
end try
	
	
return k_return 

end function

public function long crea_memo_cliente (ref st_memo ast_memo, string a_file[]) throws uo_exception;//
//--- Crea in automatico un MEMO fascicolato x il CLIENTE con anche gli allegati
//---
//--- Inp: st_memo.st_tab_clienti_memo.id_cliente + a_file[...] (i doc allegati)
//--- Out: st_memo valorizzata
//--- Rit: TRUE = OK caricato
//
long k_return = 0
//int a_file_nr, k_riga, k_nr_allegati=0
st_tab_clienti kst_tab_clienti 
st_tab_memo_link kst_tab_memo_link
st_memo kst_memo


try   

	if ast_memo.st_tab_clienti_memo.id_cliente > 0 then

		if NOT isvalid(kiuf_clienti) then kiuf_clienti = create kuf_clienti 
		if NOT isvalid(kiuf_memo) then kiuf_memo = create kuf_memo 
		if NOT isvalid(kiuf_memo_link) then kiuf_memo_link = create kuf_memo_link 
		if NOT isvalid(kiuf_utility) then kiuf_utility = create kuf_utility 
		
		memo_xcliente(ast_memo.st_tab_clienti_memo, ast_memo.st_tab_memo)   	// imposta dati standard del memo 

		ast_memo.st_tab_memo.permessi = kiuf_sr_sicurezza.ki_permessi_scrittura 

		kst_tab_clienti.codice = ast_memo.st_tab_clienti_memo.id_cliente
		kiuf_clienti.get_nome(kst_tab_clienti)
		ast_memo.st_tab_memo.memo = blob("{\rtf1\ansi Memo generato in automatico, settore '" + ast_memo.st_tab_memo.tipo_sv + "' per " + " " + trim(kst_tab_clienti.rag_soc_10 ) + " (" + string(ast_memo.st_tab_clienti_memo.id_cliente) + "), leggere la sezione 'Allegati' \par }")
		
		ast_memo.st_tab_memo.id_memo = kiuf_memo.aggiorna(ast_memo)		// inserisce il memo su DB

		//kst_tab_memo_link[] = ast_memo.st_tab_memo_link[]

		kst_tab_memo_link.id_memo = ast_memo.st_tab_memo.id_memo 
		kst_tab_memo_link.memo_link_load = ast_memo.st_tab_memo_link[1].memo_link_load 
		kst_tab_memo_link.link = ast_memo.st_tab_memo_link[1].link
		
		kiuf_memo_link.u_add_memo_link(kst_tab_memo_link, a_file[])
		
		k_return = ast_memo.st_tab_memo.id_memo
		
//		a_file_nr = upperbound(ast_memo.st_tab_memo_link[])
//		for k_riga = 1 to a_file_nr
//			
//			kst_tab_memo_link[k_riga].id_memo_link = 0
//			kst_tab_memo_link[k_riga].id_memo = ast_memo.st_tab_memo.id_memo
//			kst_tab_memo_link[k_riga].tipo_memo_link = kiuf_utility.u_get_ext_file(kst_tab_memo_link[k_riga].link)
//			kst_tab_memo_link[k_riga].nome = kiuf_utility.u_get_nome_file(kst_tab_memo_link[k_riga].link)
//			kst_tab_memo_link[k_riga].titolo = "Allegato " + kst_tab_memo_link[k_riga].nome
//			
//		next
//		if a_file_nr > 0 then
//			k_nr_allegati = kiuf_memo_link.crea_memo_link(kst_tab_memo_link[])  // aggiunge gli allegati
//		end if
//		if a_file_nr = k_nr_allegati then
//			k_return = true
//		end if
		
	end if
		
		
catch (uo_exception	kuo_exception)
	throw kuo_exception
		
end try
	
	
return k_return 

end function

public function long crea_memo (ref st_memo ast_memo, st_open_w ast_open_w, string a_file[]) throws uo_exception;//
//--- Crea in automatico un MEMO per un Oggetto non ancora identificato
//---
//--- Inp: st_memo riempita con le aree st_tab_meca_link[...] + a_file (file da linkare)
//---     st_open_w.id_programma + key11_ds con il ds caricato con il dato ad esempio id_meca da estrarre
//--- Out: st_memo valorizzata
//--- Rit: TRUE = OK caricato
//
long k_return = 0


try   

	if NOT isvalid(kiuf_sr_sicurezza) then kiuf_sr_sicurezza = create kuf_sr_sicurezza 
	if NOT isvalid(kiuf_armo) then kiuf_armo = create kuf_armo 
	if NOT isvalid(kiuf_clienti) then kiuf_clienti = create kuf_clienti 

	choose case ast_open_w.id_programma
	
		case kiuf_armo.get_id_programma(kkg_flag_modalita.visualizzazione )
			ast_memo.st_tab_meca_memo.id_meca = ast_open_w.key11_ds.object.id_meca[1] // id meca
			ast_memo.st_tab_meca_memo.tipo_sv = kiuf_sr_sicurezza.get_sr_settore(ast_open_w.id_programma)
			k_return = crea_memo_meca(ast_memo, a_file[])

		case kiuf_clienti.get_id_programma(kkg_flag_modalita.visualizzazione )
			ast_memo.st_tab_clienti_memo.id_cliente = ast_open_w.key11_ds.object.codice[1] // id cliente
			ast_memo.st_tab_clienti_memo.tipo_sv = kiuf_sr_sicurezza.get_sr_settore(ast_open_w.id_programma)
			k_return = crea_memo_cliente(ast_memo, a_file[])
			
	end choose

		
catch (uo_exception	kuo_exception)
	throw kuo_exception

		
end try
	
	
return k_return 

end function

public function long crea_memo_meca_ddt_in (ref st_memo ast_memo, string a_file[]) throws uo_exception;//
//--- Crea in automatico un MEMO fascicolato x il LOTTO con anche gli allegati
//---
//--- Inp: st_memo.st_tab_meca_memo.id_meca
//---                , .id_memo	solo se esiste già
//---                , .st_tab_memo_link[1].link (path parziale, opzionale)
//---    								+ a_file[...] (i doc allegati)
//--- Out: st_memo valorizzata
//--- Rit: id_memo caricato
//
long k_return = 0
string k_memo_descr
st_tab_clienti kst_tab_clienti 
st_tab_memo_link kst_tab_memo_link
st_tab_meca kst_tab_meca


try   

	if ast_memo.st_tab_meca_memo.id_meca > 0 then

		if NOT isvalid(kiuf_clienti) then kiuf_clienti = create kuf_clienti 
		if NOT isvalid(kiuf_armo) then kiuf_armo = create kuf_armo 
		if NOT isvalid(kiuf_memo) then kiuf_memo = create kuf_memo 
		if NOT isvalid(kiuf_memo_link) then kiuf_memo_link = create kuf_memo_link 
		
		memo_xmeca_ddt_in(ast_memo.st_tab_meca_memo, ast_memo.st_tab_memo)   	// imposta dati standard del memo 

		ast_memo.st_tab_memo.permessi = kiuf_sr_sicurezza.ki_permessi_scrittura 

		kst_tab_meca.id = ast_memo.st_tab_meca_memo.id_meca
		kiuf_armo.get_dati_rid(kst_tab_meca)
		kiuf_armo.get_num_bolla_in(kst_tab_meca)
		kst_tab_clienti.codice = kst_tab_meca.clie_1
		kiuf_clienti.get_nome(kst_tab_clienti)
		k_memo_descr = "{\rtf1\ansi DDT di entrata merce n. \b " + trim(kst_tab_meca.num_bolla_in) + "\b0  del \b  " + string(kst_tab_meca.data_bolla_in, "dd mmm yyyy") &
					+ "\b0  di " + trim(kst_tab_clienti.rag_soc_10 ) + " (" + string(kst_tab_meca.clie_1) + ") " &
					+ "caricato in automatico." &
					+ "\line Lotto " + string(kst_tab_meca.num_int) + " - " + string(kst_tab_meca.data_int, "dd mmm yyyy")

		if kst_tab_meca.clie_1 <> kst_tab_meca.clie_3 then
			kst_tab_clienti.codice = kst_tab_meca.clie_3
			kiuf_clienti.get_nome(kst_tab_clienti)
			k_memo_descr += "del cliente " + " " + trim(kst_tab_clienti.rag_soc_10) + " (" + string(kst_tab_meca.clie_3) + ")"
		end if
		
		k_memo_descr += ".\line Prego, leggere la sezione 'Allegati' \par }"
		
		ast_memo.st_tab_memo.memo += blob(k_memo_descr)
		ast_memo.st_tab_memo.id_memo = kiuf_memo.aggiorna(ast_memo)		// inserisce/aggiorna il memo su DB

		kst_tab_memo_link = ast_memo.st_tab_memo_link[1] 
		kst_tab_memo_link.id_memo = ast_memo.st_tab_memo.id_memo 
		//kst_tab_memo_link.memo_link_load = ast_memo.st_tab_memo_link[1].memo_link_load 
		
		kiuf_memo_link.u_add_memo_link(kst_tab_memo_link, a_file[])

		k_return = ast_memo.st_tab_memo.id_memo 

	end if
		
		
catch (uo_exception	kuo_exception)
	throw kuo_exception
		
end try
	
	
return k_return 

end function

public subroutine memo_xmeca_ddt_in (ref st_tab_meca_memo ast_tab_meca_memo, ref st_tab_memo ast_tab_memo) throws uo_exception;//
//--- imposta campi x MECA_DDT_IN
//---
//--- Inp: st_tab_meca_memo + st_tab_memo
//
//string k_settore
st_tab_meca kst_tab_meca 
st_tab_clienti kst_tab_clienti
kuf_armo kuf1_armo
kuf_armo_inout kuf1_armo_inout
kuf_clienti kuf1_clienti
//datastore kds_sr_settori


try   

//	kds_sr_settori = create datastore
//	kds_sr_settori.dataobject = "ds_sr_settori"
//	kds_sr_settori.settransobject(kguo_sqlca_db_magazzino)

	kuf1_armo = create kuf_armo
	kuf1_armo_inout = create kuf_armo_inout
	kuf1_clienti = create kuf_clienti
	
	if ast_tab_meca_memo.id_meca_memo > 0 then
		kuf1_armo_inout.get_id_memo(ast_tab_meca_memo)
	else
		ast_tab_meca_memo.id_memo = 0
	end if
		
	if ast_tab_meca_memo.id_meca  > 0 then
		
		kst_tab_meca.id = ast_tab_meca_memo.id_meca
		kuf1_armo.get_num_int(kst_tab_meca)
		kuf1_armo.get_clie(kst_tab_meca)
		if kst_tab_meca.clie_1 > 0 then
			kst_tab_clienti.codice = kst_tab_meca.clie_1
			kuf1_clienti.get_nome(kst_tab_clienti)
		end if
		
//		k_settore = ""
		ast_tab_memo.tipo_sv = ast_tab_meca_memo.tipo_sv
//		if trim(ast_tab_meca_memo.tipo_sv) > " " then
//			if kds_sr_settori.retrieve(ast_tab_meca_memo.tipo_sv) > 0 then
//				k_settore = kds_sr_settori.getitemstring(1, "descr")
//			end if
//		end if

		kuf1_armo.get_num_bolla_in(kst_tab_meca)

		if trim(kst_tab_meca.num_bolla_in) > " " then
			ast_tab_memo.titolo = "DDT n. " + trim(kst_tab_meca.num_bolla_in) &
										+ " del " + string(kst_tab_meca.data_bolla_in, "dd mmm yy") &
										+ ", Lotto " + string(kst_tab_meca.num_int) + " " + string(kst_tab_meca.data_int, "dd mmm yy") 
										//+ " di " + trim(kguo_utente.get_nome( )) &
		else
			ast_tab_memo.titolo = "Informazioni Lotto " + string(kst_tab_meca.num_int) + " del " + string(kst_tab_meca.data_int)
		end if
		
		ast_tab_memo.note = "DDT n. " + trim(kst_tab_meca.num_bolla_in) &
										+ " del " + string(kst_tab_meca.data_bolla_in, "dd mmm yy") &
										+ " di " + trim(kst_tab_clienti.rag_soc_10) + " (" + string(kst_tab_clienti.codice) + ")"
		
		ast_tab_memo.id_memo = ast_tab_meca_memo.id_memo
		
		
//		kst_memo.st_tab_memo = ast_tab_memo
//		kst_memo.st_tab_meca_memo = ast_tab_meca_memo
		
	end if
		 
catch (uo_exception	kuo_exception)
	throw kuo_exception
		
end try
	
//return kst_memo


end subroutine

on kuf_memo_inout.create
call super::create
end on

on kuf_memo_inout.destroy
call super::destroy
end on

event destructor;call super::destructor;//
	if isvalid(kiuf_sr_sicurezza) then destroy kiuf_sr_sicurezza
	if isvalid(kiuf_armo) then destroy kiuf_armo
	if isvalid(kiuf_clienti) then destroy kiuf_clienti
	if isvalid(kiuf_memo) then destroy kiuf_memo
	if isvalid(kiuf_memo_link) then destroy kiuf_memo_link
	if isvalid(kiuf_utility) then destroy kiuf_utility
	


end event

