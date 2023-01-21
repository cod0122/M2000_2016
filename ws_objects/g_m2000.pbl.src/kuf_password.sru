$PBExportHeader$kuf_password.sru
forward
global type kuf_password from kuf_parent0
end type
end forward

global type kuf_password from kuf_parent0
string ki_msgerroggetto = "valore"
end type
global kuf_password kuf_password

type variables
//
public:
boolean ki_user_autenticato 

end variables
forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function st_esito u_open ()
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return true
end function

public function st_esito u_open ();//
//--- Chiama la OPEN senza particolari funzioni
//---
//--- Input: 
//---
//
boolean  k_return = true
st_tab_g_0 kst_tab_g_0[]
st_open_w kst_open_w
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""

	kst_tab_g_0[1].id = 0
	
	//k_return = this.u_open_applicazione(kst_tab_g_0[1], kkg_flag_modalita.visualizzazione)
 
 	if not k_return then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Funzione richiesta non Eseguita: (id programma: " &
			               + trim(lower(get_id_programma(kkg_flag_modalita.visualizzazione)))+ ", modalita: " + trim(kkg_flag_modalita.visualizzazione) + ")~n~r"
	end if	
		

return kst_esito

end function

on kuf_password.create
call super::create
end on

on kuf_password.destroy
call super::destroy
end on

