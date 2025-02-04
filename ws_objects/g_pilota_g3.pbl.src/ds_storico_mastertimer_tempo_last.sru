$PBExportHeader$ds_storico_mastertimer_tempo_last.sru
forward
global type ds_storico_mastertimer_tempo_last from ds_pilota_g3_parent
end type
end forward

global type ds_storico_mastertimer_tempo_last from ds_pilota_g3_parent
string dataobject = "ds_storico_mastertimer_tempo_last"
end type
global ds_storico_mastertimer_tempo_last ds_storico_mastertimer_tempo_last

on ds_storico_mastertimer_tempo_last.create
call super::create
end on

on ds_storico_mastertimer_tempo_last.destroy
call super::destroy
end on

