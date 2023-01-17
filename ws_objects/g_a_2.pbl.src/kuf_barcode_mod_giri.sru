$PBExportHeader$kuf_barcode_mod_giri.sru
forward
global type kuf_barcode_mod_giri from nonvisualobject
end type
end forward

global type kuf_barcode_mod_giri from nonvisualobject
end type
global kuf_barcode_mod_giri kuf_barcode_mod_giri

type variables
public:
//--- Varibile di stato che indica la modalita' x la quale sto esponendo le FILE
constant string ki_modalita_modifica_scelta_fila="0"
constant string ki_modalita_modifica_giri_riga="1"
constant string ki_modalita_modifica_giri_righe="2"
constant string ki_modalita_modifica_giri_visualizza="3"

//--- Variabile dove memorizzo l'autorizzazione alla modifica
string ki_modifica_cicli_enabled ="0"
constant string ki_modifica_cicli_enabled_nulla="0"
constant string ki_modifica_cicli_enabled_modif="1"
constant string ki_modifica_cicli_enabled_visualizzazione="2"

//--- Varibile del tipo di controllo x autorizzare la modifica giri
//int ki_modifica_giri_pianificati = 1 
constant int ki_modifica_giri_pianificati_si = 1 
constant int ki_modifica_giri_pianificati_no = 0 // non consente di modificare i giri x i barcode in pl gia' chiusi

//--- Varibile di stato che indica se modifica 1 barcode solo o tutto il Riferim ancora da trattare
constant int ki_modif_tutto_riferimento_si = 1
constant int ki_modif_tutto_riferimento_no = 0

public st_barcode_mod_giri kist_barcode_mod_giri
end variables

forward prototypes
public subroutine _readme ()
public subroutine u_open (st_barcode_mod_giri ast_barcode_mod_giri)
public function boolean autorizza_modifica_giri (st_tab_barcode ast_tab_barcode, integer a_modifica_giri_pianificati) throws uo_exception
public function boolean autorizza_modifica_giri (integer a_modifica_giri_pianificati) throws uo_exception
end prototypes

public subroutine _readme ();//
//--- Modifica giri barcode
//
end subroutine

public subroutine u_open (st_barcode_mod_giri ast_barcode_mod_giri);//
st_open_w k_st_open_w


kist_barcode_mod_giri = ast_barcode_mod_giri

k_st_open_w.key12_any = this
openwithparm(w_barcode_mod_giri, k_st_open_w)


end subroutine

public function boolean autorizza_modifica_giri (st_tab_barcode ast_tab_barcode, integer a_modifica_giri_pianificati) throws uo_exception;//---
//--- controllo autorizzazione x cambio giri di lavorazione
//--- 
//--- Output:
//---            setta la variabile di stato ki_modifica_cicli_enabled
//---			TRUE=puo' fare qualcose; FALSE=non puo' fare nulla
//---
boolean k_return = true
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility
st_open_w k_st_open_w
kuf_barcode kuf1_barcode


	
	ki_modifica_cicli_enabled = ki_modifica_cicli_enabled_modif
	
	kuf1_utility = create kuf_utility 


//--- abilitazione alla modifica 
	K_st_open_w.id_programma = kkg_id_programma_pt_giri
	K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
	
	kuf1_sicurezza = create kuf_sicurezza 
	if not kuf1_sicurezza.autorizza_funzione(k_st_open_w) then
		
		ki_modifica_cicli_enabled = ki_modifica_cicli_enabled_visualizzazione

//--- provo almeno l'abilitazione alla visualizzazione
		K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
		if not kuf1_sicurezza.autorizza_funzione(k_st_open_w) then
			
			ki_modifica_cicli_enabled =  ki_modifica_cicli_enabled_nulla
			k_return = false

		end if
	else

		if a_modifica_giri_pianificati = ki_modifica_giri_pianificati_no then
			kuf1_barcode = create kuf_barcode
			
			try
//--- se barcode figlio non posso modificare i giri 				
				if not kuf1_barcode.if_barcode_figlio(ast_tab_barcode) then
//--- se giri barcode non modificabili quando gia' in pl chiusi.... 		
					if kuf1_barcode.if_barcode_in_pl_chiuso(ast_tab_barcode) then
//					if kuf1_barcode.if_barcode_in_pl(kist_tab_barcode) then
						k_return = false
					else
						k_return = true
					end if
				else
					k_return = false
				end if
				
			catch (uo_exception kuo_exception)
				throw kuo_exception				
			finally			
				destroy kuf1_barcode
			end try
			
		end if
	end if

	destroy kuf1_sicurezza
	destroy kuf1_utility

return k_return


end function

public function boolean autorizza_modifica_giri (integer a_modifica_giri_pianificati) throws uo_exception;//---
//--- controllo autorizzazione x cambio giri di lavorazione
//--- 
//--- Output:
//---            setta la variabile di stato ki_modifica_cicli_enabled
//---			TRUE=puo' fare qualcose; FALSE=non puo' fare nulla
//---
boolean k_return = true
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility
st_open_w k_st_open_w


	
	ki_modifica_cicli_enabled = ki_modifica_cicli_enabled_modif
	
	kuf1_utility = create kuf_utility 


//--- abilitazione alla modifica 
	K_st_open_w.id_programma = kkg_id_programma_pt_giri
	K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
	
	kuf1_sicurezza = create kuf_sicurezza 
	if not kuf1_sicurezza.autorizza_funzione(k_st_open_w) then
		
		ki_modifica_cicli_enabled = ki_modifica_cicli_enabled_visualizzazione

//--- provo almeno l'abilitazione alla visualizzazione
		K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
		if not kuf1_sicurezza.autorizza_funzione(k_st_open_w) then
			
			ki_modifica_cicli_enabled =  ki_modifica_cicli_enabled_nulla
			k_return = false

		end if
	else

		if a_modifica_giri_pianificati = ki_modifica_giri_pianificati_no then
			k_return = true
		end if
	end if

	destroy kuf1_sicurezza
	destroy kuf1_utility

return k_return


end function

on kuf_barcode_mod_giri.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_barcode_mod_giri.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

