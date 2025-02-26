$PBExportHeader$kkg_colore.sru
$PBExportComments$Colori standard utilizzati
forward
global type kkg_colore from nonvisualobject
end type
end forward

global type kkg_colore from nonvisualobject
end type
global kkg_colore kkg_colore

type variables
//--- in numero:  calcolo colore (blue),(green),(red)
constant long NERO=1
constant long BIANCO=65536 * (255) + 256 * (255) + (255) - 1 
constant long GRIGIO=65536 * (210) + 256 * (210) + 210
constant long GRIGIO_CHIARO=65536 * (240) + 256 * (240) + (240) 
constant long GRIGIO_CHIARO_CHIARO=65536 * (250) + 256 * (250) + (250) 
constant long GRIGIO_SCURO=65536 * (110) + 256 * (110) + (110) 
constant long ROSSO=65536 * (0) + 256 * (0) + (255) 
constant long ROSSO_CHIARO=65536 * (136) + 256 * (136) + (255) 
constant long GRANATA=65536 * (62) + 256 * (0) + (132) 
constant long BLU_SCURO=65536 * (113) + 256 * (0) + (0) 
constant long BLU=65536 * (255) + 256 * (0) + (0) 
constant long BLU_CHIARO=65536 * (255) + 256 * (211) + (168) 
constant long GIALLO=65536 * 128 + 256 * (255) + (255) 
constant long GIALLOCHIARO=(rgb(255,255,100)) 
constant long GIALLOSCURO=(rgb(55,55,0)) 
constant long OLIVE=65536 * 128 + 256 * (128) + (64) 
constant long VIOLAXDARK=rgb(182, 148, 246) 
constant long VIOLAXSTD=rgb(58, 12, 144)
constant long VERDEXDARK=rgb(176, 239, 59)
constant long VERDEXSTD=rgb(39, 58, 4)
constant long VERDE=65536 * 64 + 256 * (128) + (0) 

constant string NEROX="1"
constant string BIANCOX = string(BIANCO)
constant string GRIGIOX = string(GRIGIO)
constant string GRIGIO_CHIAROX = string(GRIGIO_CHIARO)
constant string GRIGIO_CHIARO_CHIAROX = string(GRIGIO_CHIARO_CHIARO)
constant string ROSSOX = string(ROSSO)
constant string ROSSO_CHIAROX = string(ROSSO_CHIARO)
constant string GRANATAX = string(GRANATA)
constant string BLU_SCUROX = string(BLU_SCURO)
constant string BLUX = string(BLU)
constant string BLU_CHIAROX = string(BLU_CHIARO)
constant string GIALLOX = string(GIALLO)
constant string GIALLOCHIAROX = string(GIALLOCHIARO)
constant string GIALLOSCUROX = string(GIALLOSCURO)
constant string OLIVEX = string(OLIVE)
constant string VIOLAXDARKX = string(VIOLAXDARK)
constant string VIOLAXSTDX = string(VIOLAXSTD)
constant string VERDEXDARKX = string(VERDEXDARK)
constant string VERDEXSTDX = string(VERDEXSTD)
constant string VERDEXa=string(VERDEXSTD)

constant string LINK=string(65536 * (255) + 256 * (128) + (0))
constant string ERR_DATO=string(65536 * (217) + 256 * (217) + (255))
constant string INPUT_FIELD=string(65536 * (253) + (247) * 256 + (157))
constant string REC_UPDx =string(65536 * (230) + 256 * (230) + (255)) 

constant long SFONDO_SCURO_n=(65536 * (13) + 256 * (28) + 28) 
constant string SFONDO_SCURO=string(SFONDO_SCURO_n) 

constant long KO=RGB(180,0,0)
constant long OK=RGB(0,100,0)

constant long CAMPO_DISATTIVON=(RGB(223,223,223))  //background
constant long CAMPO_DISATTIVO_TEXTN=1 //(65536 * (0) + 255 * (0) + (1)) 
constant long CAMPO_ATTIVON=(RGB(250,250,250)) // -1) //rgb(0,0,0)) //background
constant long CAMPO_ATTIVO_TEXTN=65536 * (36) + 256 * (36) + 17 // 1 

constant string CAMPO_ATTIVO=string(CAMPO_ATTIVON) //(65536 * (255) + 256 * (255) + (255) - 1) 
constant string CAMPO_ATTIVO_TEXT=string(CAMPO_ATTIVO_TEXTN) 
constant string CAMPO_DISATTIVO=string(CAMPO_DISATTIVON) 
constant string CAMPO_DISATTIVO_TEXT=string(CAMPO_ATTIVO_TEXTN) 

end variables

on kkg_colore.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kkg_colore.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

