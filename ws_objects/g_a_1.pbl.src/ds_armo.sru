$PBExportHeader$ds_armo.sru
forward
global type ds_armo from ds_db_magazzino_parent
end type
end forward

global type ds_armo from ds_db_magazzino_parent
string dataobject = "ds_armo"
end type
global ds_armo ds_armo

forward prototypes
public function long u_retrieve (ref st_tab_armo ast_tab_armo) throws uo_exception
end prototypes

public function long u_retrieve (ref st_tab_armo ast_tab_armo) throws uo_exception;//
long k_row 
date k_data_da 
uo_ds_std_1 kds_1


if ast_tab_armo.id_armo > 0 then
	k_row = this.retrieve(ast_tab_armo.id_armo)
	if k_row < 0 then
		kds_1 = this
		kguo_exception.inizializza(this.classname())
		kguo_exception.set_st_esito_err_ds(kds_1, "Errore in lettura Riga Lotto id " + string(ast_tab_armo.id_armo))
		throw kguo_exception
	end if

	if k_row > 0 then
		ast_tab_armo.id_meca	    = this.getitemnumber(1, "id_meca")
      ast_tab_armo.id_armo     = this.getitemnumber(1, "id_armo")
      ast_tab_armo.num_int     = this.getitemnumber(1, "num_int")
      ast_tab_armo.data_int    = this.getitemdate(1, "data_int")
      ast_tab_armo.id_listino  = this.getitemnumber(1, "id_listino")
      ast_tab_armo.art         = this.getitemstring(1, "art"       )
      ast_tab_armo.dose        = this.getitemnumber(1, "dose"      )
      ast_tab_armo.note_1      = this.getitemstring(1, "note_1"    )
      ast_tab_armo.note_2      = this.getitemstring(1, "note_2"    )
      ast_tab_armo.note_3      = this.getitemstring(1, "note_3"    )
      ast_tab_armo.larg_1      = this.getitemnumber(1, "larg_1"    )
      ast_tab_armo.lung_1      = this.getitemnumber(1, "lung_1"    )
      ast_tab_armo.alt_1       = this.getitemnumber(1, "alt_1"     )
      ast_tab_armo.colli_1     = this.getitemnumber(1, "colli_1"   )
      ast_tab_armo.travaso     = this.getitemstring(1, "travaso"   )
      ast_tab_armo.larg_2      = this.getitemnumber(1, "larg_2"    )
      ast_tab_armo.lung_2      = this.getitemnumber(1, "lung_2"    )
      ast_tab_armo.alt_2       = this.getitemnumber(1, "alt_2"     )
      ast_tab_armo.colli_2     = this.getitemnumber(1, "colli_2"   )
      ast_tab_armo.m_cubi      = this.getitemnumber(1, "m_cubi"    )
      ast_tab_armo.peso_kg     = this.getitemnumber(1, "peso_kg"   )
      ast_tab_armo.colli_fatt  = this.getitemnumber(1, "colli_fatt")
      ast_tab_armo.magazzino   = this.getitemnumber(1, "magazzino" )
      ast_tab_armo.pedane      = this.getitemnumber(1, "pedane"    )
      ast_tab_armo.campione    = this.getitemstring(1, "campione"  )
      ast_tab_armo.cod_sl_pt   = this.getitemstring(1, "cod_sl_pt" )
      ast_tab_armo.stato       = this.getitemnumber(1, "stato"     )
      ast_tab_armo.x_datins    = this.getitemdatetime(1, "x_datins")
      ast_tab_armo.x_utente    = this.getitemstring(1, "x_utente" )
      //ast_tab_armo.parziale    = this.getitemnumber(1, "parziale")
      ast_tab_armo.campionecolli = this.getitemnumber(1, "campionecolli")
      ast_tab_armo.parzialecolli = this.getitemnumber(1, "parzialecolli")
  	end if	
end if

return k_row 

end function

on ds_armo.create
call super::create
end on

on ds_armo.destroy
call super::destroy
end on

