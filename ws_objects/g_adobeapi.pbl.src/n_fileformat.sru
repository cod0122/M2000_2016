$PBExportHeader$n_fileformat.sru
forward
global type n_fileformat from nonvisualobject
end type
end forward

global type n_fileformat from nonvisualobject
end type
global n_fileformat n_fileformat

type variables
PUBLIC:
n_enum DOCX
n_enum DOC
n_enum PPTX
n_enum XLSX
n_enum RTF
end variables

event constructor;//
DOCX = create n_enum
DOC = create n_enum
PPTX = create n_enum
XLSX = create n_enum
RTF = create n_enum


DOCX.of_constructor("docx", 1)
DOC.of_constructor("doc", 2)
PPTX.of_constructor("pptx", 3)
XLSX.of_constructor("xlsx", 4)
RTF.of_constructor("rtf", 5)
end event

on n_fileformat.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_fileformat.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

