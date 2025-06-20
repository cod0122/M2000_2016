﻿$PBExportHeader$uo_utente.sru
forward
global type uo_utente from nonvisualobject
end type
end forward

global type uo_utente from nonvisualobject
end type
global uo_utente uo_utente

type variables
//--- sicurezza
private:
string ki_NOME="SCONOSCIUTO " //nome utente attivo
string ki_CODICE="*VUOTO*" //inizialmente          obsoleto  "MASTER" //User dell'utente
string ki_COMP="MAST" //User compatto, prendo solo 4 lettere senza char strani
long ki_ID_UTENTE=0 //
int ki_PWD=0 //Livello di Privilegio OBSOLETO solo x compatibilita' con il passato
int ki_virtual_user = 0 // 1=utente virtuale es. Console
public:
string Ki_DOMAIN //Domain di connessione Active Directoty / LDAP


end variables
forward prototypes
public subroutine set_nome (string a_nome)
public subroutine set_codice (string a_codice)
public subroutine set_pwd (integer a_pwd)
public function string get_codice ()
public function string get_nome ()
public function string get_comp ()
public function integer get_pwd ()
public subroutine set_comp ()
public subroutine set_id_utente (long a_id_utente)
public function long get_id_utente ()
public function boolean if_master ()
public subroutine set_virtual_user (integer a_virtual_user)
public function boolean if_virtual_user ()
end prototypes

public subroutine set_nome (string a_nome);
ki_nome = trim(a_nome)

end subroutine

public subroutine set_codice (string a_codice);
ki_codice = trim(a_codice)

end subroutine

public subroutine set_pwd (integer a_pwd);
ki_pwd = a_pwd

end subroutine

public function string get_codice ();
//if trim(ki_codice) = "MASTER" then
//	return "9999"
//else
	return trim(ki_codice)
//end if

end function

public function string get_nome ();
return trim(ki_nome)

end function

public function string get_comp ();
return trim(ki_comp)

end function

public function integer get_pwd ();
return ki_pwd

end function

public subroutine set_comp ();//---
//---   Compatta il KG_UTENTE_CODICE in modo da poterlo usare anche nelle VIEW
//---   toglie char strani e lo trasforma in una stringa di 4 caratteri
//---
string k_utente
string k_return_stringa
string k_old_str
int k_start_pos, k_ini_pos, k_fin_pos


	k_utente = ki_CODICE
	
	//--- se e' minore di 4 aggiunge se stesso 
	if len(trim(k_utente)) < 5 then
		
		do while len(trim(k_utente)) < 5
			k_utente = trim(k_utente) + trim(k_utente)
		loop
	
	end if

	k_return_stringa = k_utente

	k_start_pos = 1
	k_old_str = " "
	k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
	DO WHILE k_start_pos > 0
		k_ini_pos = k_start_pos - 1
		k_fin_pos = k_start_pos + 1
		 k_return_stringa = left (k_return_stringa, k_ini_pos) + mid(k_return_stringa,k_start_pos + 1, len(k_return_stringa) - k_fin_pos)
		 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+1)
	LOOP

	k_start_pos = 1
	k_old_str = "."
	k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
	DO WHILE k_start_pos > 0
		k_ini_pos = k_start_pos - 1
		k_fin_pos = k_start_pos + 1
		 k_return_stringa = left (k_return_stringa, k_ini_pos) + mid(k_return_stringa,k_start_pos + 1, len(k_return_stringa) - k_fin_pos)
		 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+1)
	LOOP

	k_start_pos = 1
	k_old_str = "-"
	k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
	DO WHILE k_start_pos > 0
		k_ini_pos = k_start_pos - 1
		k_fin_pos = k_start_pos + 1
		 k_return_stringa = left (k_return_stringa, k_ini_pos) + mid(k_return_stringa,k_start_pos + 1, len(k_return_stringa) - k_fin_pos)
		 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+1)
	LOOP

	k_start_pos = 1
	k_old_str = "_"
	k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
	DO WHILE k_start_pos > 0
		k_ini_pos = k_start_pos - 1
		k_fin_pos = k_start_pos + 1
		 k_return_stringa = left (k_return_stringa, k_ini_pos) + mid(k_return_stringa,k_start_pos + 1, len(k_return_stringa) - k_fin_pos)
		 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+1)
	LOOP
	
	k_start_pos = 1
	k_old_str = "@"
	k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
	DO WHILE k_start_pos > 0
		k_ini_pos = k_start_pos - 1
		k_fin_pos = k_start_pos + 1
		 k_return_stringa = left (k_return_stringa, k_ini_pos) + mid(k_return_stringa,k_start_pos + 1, len(k_return_stringa) - k_fin_pos)
		 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+1)
	LOOP
	
	k_start_pos = 1
	k_old_str = "#"
	k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
	DO WHILE k_start_pos > 0
		k_ini_pos = k_start_pos - 1
		k_fin_pos = k_start_pos + 1
		 k_return_stringa = left (k_return_stringa, k_ini_pos) + mid(k_return_stringa,k_start_pos + 1, len(k_return_stringa) - k_fin_pos)
		 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+1)
	LOOP
	
	k_start_pos = 1
	k_old_str = ";"
	k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
	DO WHILE k_start_pos > 0
		k_ini_pos = k_start_pos - 1
		k_fin_pos = k_start_pos + 1
		 k_return_stringa = left (k_return_stringa, k_ini_pos) + mid(k_return_stringa,k_start_pos + 1, len(k_return_stringa) - k_fin_pos)
		 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+1)
	LOOP
	
	k_start_pos = 1
	k_old_str = ","
	k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
	DO WHILE k_start_pos > 0
		k_ini_pos = k_start_pos - 1
		k_fin_pos = k_start_pos + 1
		 k_return_stringa = left (k_return_stringa, k_ini_pos) + mid(k_return_stringa,k_start_pos + 1, len(k_return_stringa) - k_fin_pos)
		 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+1)
	LOOP
	
	k_start_pos = 1
	k_old_str = "&"
	k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
	DO WHILE k_start_pos > 0
		k_ini_pos = k_start_pos - 1
		k_fin_pos = k_start_pos + 1
		 k_return_stringa = left (k_return_stringa, k_ini_pos) + mid(k_return_stringa,k_start_pos + 1, len(k_return_stringa) - k_fin_pos)
		 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+1)
	LOOP


	ki_comp = left(k_return_stringa, 4)
	


end subroutine

public subroutine set_id_utente (long a_id_utente);
if isnull(a_id_utente) then a_id_utente = 0
ki_ID_UTENTE = a_id_utente

end subroutine

public function long get_id_utente ();
	return ki_ID_UTENTE

end function

public function boolean if_master ();//
//--- torna se user è MASTER (speciale per il PROGRAMMATORE)
//
if ki_ID_UTENTE = 9999 then
	return true
else
	return false
end if
end function

public subroutine set_virtual_user (integer a_virtual_user);
if isnull(a_virtual_user) then a_virtual_user = 0
ki_virtual_user = a_virtual_user

end subroutine

public function boolean if_virtual_user ();//
//--- torna se utente VIRTUALE (es. Console)
//
if ki_virtual_user = 1 then
	return true
else
	return false
end if
end function

on uo_utente.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_utente.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

