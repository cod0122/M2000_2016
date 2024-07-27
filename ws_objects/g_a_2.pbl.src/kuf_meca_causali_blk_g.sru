$PBExportHeader$kuf_meca_causali_blk_g.sru
forward
global type kuf_meca_causali_blk_g from kuf_parent0
end type
end forward

global type kuf_meca_causali_blk_g from kuf_parent0
end type
global kuf_meca_causali_blk_g kuf_meca_causali_blk_g

type variables
//
//--- Questo oggetto serve x abilitare lo sblocco del Lotto per 'RICH_ATORIZZ = M'   (materiale medicale)
//
//public string ki_rich_autorizz_Materiale_Medicale = 'M'
end variables

on kuf_meca_causali_blk_g.create
call super::create
end on

on kuf_meca_causali_blk_g.destroy
call super::destroy
end on

