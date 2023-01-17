$PBExportHeader$uo_crypter.sru
forward
global type uo_crypter from crypterobject
end type
end forward

global type uo_crypter from crypterobject
end type
global uo_crypter uo_crypter

type variables
//
blob ki_secret_key 
						

end variables

forward prototypes
public function boolean u_if_app_user_is_master (string k_pwd)
public function string u_encrypt_aes (string a_string)
public function string u_decrypt_aes (string a_string) throws uo_exception
public function string u_decrypt_aes_to_txt (string a_code_aes) throws uo_exception
public function string u_encrypt_aes_to_txt (string a_string)
end prototypes

public function boolean u_if_app_user_is_master (string k_pwd);//
string k_hash_pwd
Blob lblb_data
Blob lblb_md5

lblb_data = Blob(lower(k_pwd), EncodingANSI!)

// Encrypt with MD5
lblb_md5 = this.MD5(lblb_data)
k_hash_pwd = string(lblb_md5)

if k_hash_pwd = "蓭豩鿌濮睠瘣഻衾" then 
	return true
else
	return false
end if


end function

public function string u_encrypt_aes (string a_string);/*
Encrypt string with AES algorithm
inp: stringa da criptare
out: stringa criptata in formato BASE64
test su internet ad esempio: https://www.devglan.com/online-tools/aes-encryption-decryption
*/
string k_return
Blob lb_crypted, lb_Data
Integer li_Return


lb_Data = Blob(trim(a_string), EncodingUTF8!)
lb_crypted = this.SymmetricEncrypt( AES!, lb_Data, ki_secret_key)
k_Return = String(lb_crypted, EncodingUTF8!)

return k_return


end function

public function string u_decrypt_aes (string a_string) throws uo_exception;/*
Decrypt string via AES algorithm
inp: stringa da decriptare
out: stringa decriptata in formato BASE64
test su internet ad esempio: https://www.devglan.com/online-tools/aes-encryption-decryption
*/
string k_return
Blob lb_Decrypt, lb_Data
Integer li_Return

try
	lb_Data = Blob(trim(a_string), EncodingUTF8!)
	lb_Decrypt = this.SymmetricDecrypt( AES!, lb_Data, ki_secret_key)
	k_Return = String(lb_Decrypt, EncodingUTF8!)
	
catch (uo_exception kuo_exception)
	kuo_exception.kist_esito.nome_oggetto  = this.classname( )
	kuo_exception.kist_esito.esito = kkg_esito_ko
	kuo_exception.kist_esito.sqlerrtext = kuo_exception.getmessage( ) + kuo_exception.text
	throw kuo_exception
	
end try

return k_return


end function

public function string u_decrypt_aes_to_txt (string a_code_aes) throws uo_exception;/*
Decrypt string via AES algorithm
inp: stringa da decriptare
out: stringa decriptata in formato stringa lineare
test su internet ad esempio: https://www.devglan.com/online-tools/aes-encryption-decryption
*/
string k_return
string k_code_aes_base64
Blob lb_Decrypt, lb_Data
Integer li_Return
CoderObject kCoderObject


try
	kCoderObject = Create CoderObject
	lb_Data = kCoderObject.base64decode(trim(a_code_aes))
	lb_Decrypt = this.SymmetricDecrypt( AES!, lb_Data, ki_secret_key)
	k_Return = String(lb_Decrypt, EncodingUTF8!)
	
catch (uo_exception kuo_exception)
	kuo_exception.kist_esito.nome_oggetto  = this.classname( )
	kuo_exception.kist_esito.esito = kkg_esito_ko
	kuo_exception.kist_esito.sqlerrtext = kuo_exception.getmessage( ) + kuo_exception.text
	throw kuo_exception
	
finally
	destroy kCoderObject
	
end try

return k_return


end function

public function string u_encrypt_aes_to_txt (string a_string);/*
Encrypt string with AES algorithm
inp: stringa da criptare
out: stringa criptata in formato stringa lineare
test su internet ad esempio: https://www.devglan.com/online-tools/aes-encryption-decryption
*/
string k_return
Blob lb_crypted, lb_cryptedBase64, lb_Data
Integer li_Return
CoderObject kCoderObject


kCoderObject = Create CoderObject
lb_Data = Blob(trim(a_string), EncodingUTF8!)
lb_cryptedBase64 = this.SymmetricEncrypt( AES!, lb_Data, ki_secret_key)
k_Return = kCoderObject.base64encode(lb_cryptedBase64)
destroy kCoderObject

return k_return


end function

on uo_crypter.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_crypter.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//
ki_secret_key = Blob("DBsterigenics270", EncodingUTF8!)

end event

