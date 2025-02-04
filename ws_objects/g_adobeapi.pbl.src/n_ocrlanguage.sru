$PBExportHeader$n_ocrlanguage.sru
forward
global type n_ocrlanguage from nonvisualobject
end type
end forward

global type n_ocrlanguage from nonvisualobject
end type
global n_ocrlanguage n_ocrlanguage

type variables
PUBLIC:
n_enum GB
n_enum US
n_enum NL
n_enum FR
n_enum DE
n_enum IT
n_enum ES
n_enum SE
n_enum DK
n_enum FI
n_enum NO
n_enum BR
n_enum PT
n_enum CA
n_enum NN
n_enum CH
n_enum JP
n_enum BG
n_enum HR
n_enum CZ
n_enum EE
n_enum GR
n_enum HU
n_enum LV
n_enum LT
n_enum PL
n_enum RO
n_enum RU
n_enum CN
n_enum SI
n_enum HANT
n_enum TR
n_enum KR
n_enum SK
n_enum EU_ES
n_enum GL_ES
n_enum MK
n_enum MT
n_enum SR
n_enum UA
n_enum IL

end variables

event constructor;//
GB = create n_enum
US = create n_enum
NL = create n_enum
FR = create n_enum
DE = create n_enum
IT = create n_enum
ES = create n_enum
SE = create n_enum
DK = create n_enum
FI = create n_enum
NO = create n_enum
BR = create n_enum
PT = create n_enum
CA = create n_enum
NO = create n_enum
CH = create n_enum
JP = create n_enum
BG = create n_enum
HR = create n_enum
CZ = create n_enum
EE = create n_enum
GR = create n_enum
HU = create n_enum
LV = create n_enum
LT = create n_enum
PL = create n_enum
RO = create n_enum
RU = create n_enum
CN = create n_enum
SI = create n_enum
HANT = create n_enum
TR = create n_enum
KR = create n_enum
SK = create n_enum
EU_ES = create n_enum
GL_ES = create n_enum
MK = create n_enum
MT = create n_enum
SR = create n_enum
UA = create n_enum
IL = create n_enum

GB.of_constructor("en-GB", 1)
US.of_constructor("en-US", 2)
NL.of_constructor("nl-NL", 3)
FR.of_constructor("fr-FR", 4)
DE.of_constructor("de-DE", 5)
IT.of_constructor("it-IT", 6)
ES.of_constructor("es-ES", 7)
SE.of_constructor("sv-SE", 8)
DK.of_constructor("da-DK", 9)
FI.of_constructor("fi-FI", 10)
NO.of_constructor("nb-NO", 11)
BR.of_constructor("pt-BR", 12)
PT.of_constructor("pt-PT", 13)
CA.of_constructor("ca-CA", 14)
NO.of_constructor("nn-NO", 15)
CH.of_constructor("de-CH", 16)
JP.of_constructor("ja-JP", 17)
BG.of_constructor("bg-BG", 18)
HR.of_constructor("hr-HR", 19)
CZ.of_constructor("cs-CZ", 20)
EE.of_constructor("et-EE", 21)
GR.of_constructor("el-GR", 22)
HU.of_constructor("hu-HU", 23)
LV.of_constructor("lv-LV", 24)
LT.of_constructor("lt-LT", 25)
PL.of_constructor("pl-PL", 26)
RO.of_constructor("ro-RO", 27)
RU.of_constructor("ru-RU", 28)
CN.of_constructor("zh-CN", 29)
SI.of_constructor("sl-SI", 30)
HANT.of_constructor("zh-Hant", 31)
TR.of_constructor("tr-TR", 32)
KR.of_constructor("ko-KR", 33)
SK.of_constructor("sk-SK", 34)
EU_ES.of_constructor("eu-ES", 35)
GL_ES.of_constructor("gl-ES", 36)
MK.of_constructor("mk-MK", 37)
MT.of_constructor("mt-MT", 38)
SR.of_constructor("sr-SR", 39)
UA.of_constructor("uk-UA", 40)
IL.of_constructor("iw-IL", 41)
end event

on n_ocrlanguage.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_ocrlanguage.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

