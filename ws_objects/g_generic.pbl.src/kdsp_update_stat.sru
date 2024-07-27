$PBExportHeader$kdsp_update_stat.sru
forward
global type kdsp_update_stat from ds_db_magazzino_parent
end type
end forward

global type kdsp_update_stat from ds_db_magazzino_parent
string dataobject = "dsp_update_stat"
end type
global kdsp_update_stat kdsp_update_stat

on kdsp_update_stat.create
call super::create
end on

on kdsp_update_stat.destroy
call super::destroy
end on

