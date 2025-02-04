$PBExportHeader$n_adobeapi.sru
forward
global type n_adobeapi from nonvisualobject
end type
end forward

global type n_adobeapi from nonvisualobject
end type
global n_adobeapi n_adobeapi

type variables
public:
boolean ki_credential_enabled
n_ocrLanguage kin_ocrLanguage


Private:

String is_clientId
String is_clientSecret
String is_accessToken

end variables

forward prototypes
public function string of_getaccesstoken ()
public function string of_fetchstatus (string as_location)
public function string of_decrypt (string as_data)
private function boolean u_get_credential ()
public function integer of_exporttodocx (string as_frompdfpath, string as_todocxpath, n_enum an_ocrlanguage) throws uo_exception
public function string of_retrieveaccesstoken () throws uo_exception
public function string of_uploadasset (string as_assetpath) throws uo_exception
public function string of_exportpdf (string as_assetid, n_enum an_fileformat, n_enum an_ocrlanguage) throws uo_exception
public subroutine of_downloadasset (string as_downloaduri, string as_saveasfullpath) throws uo_exception
end prototypes

public function string of_getaccesstoken ();Return This.is_accessToken
end function

public function string of_fetchstatus (string as_location);//--VARIABLES
String ls_url
String ls_response
String ls_status
String ls_asset
String ls_assetID
String ls_downloadUri
String ls_error
Integer li_errorStatus
String ls_errorCode
String ls_errorMsg
Integer li_rc
HttpClient ln_httpClient
JsonPackage ln_jsonPackage
Integer li_count
//--

ln_httpClient = create HttpClient
ln_jsonPackage = create JsonPackage

ls_url = as_location

//Sets the request header
ln_httpClient.SetRequestHeader("Authorization", "bearer " + This.of_getAccessToken())
ln_httpClient.SetRequestHeader("x-api-key", is_clientId)

Do
	//Fetch the status
	li_rc = ln_httpClient.SendRequest("GET", ls_url, ls_response)
	
	//The GET request method is unsuccessful  
	If li_rc <> 1 Then
	
		ls_errorCode = "unknown"
		ls_errorMsg = "Powerbuilder get method failed."
		
		//	Throw exception
		
	//The GET request method is successful  
	Else
		
		//Obtain the response body
		ln_httpClient.GetResponseBody(ls_response)
		
		//Load the body response json
		ln_jsonPackage.LoadString(ls_response)
		
		//Error response
		If ln_httpClient.getresponsestatuscode() <> 200 Then
			
			If ln_jsonPackage.ContainsKey("error") Then
				ls_error = ln_jsonPackage.GetValue("error")
				
				ln_jsonPackage.LoadString(ls_error)
				
				ls_errorCode = ln_jsonPackage.GetValue("code")
				ls_errorMsg = ln_jsonPackage.GetValue("message")
			End If
			
			If IsNull(ls_errorCode) OR ls_errorCode = "" Then ls_errorCode = "unknown"
			If IsNull(ls_errorMsg) OR ls_errorMsg = "" Then ls_errorMsg = "It is impossible to read the response body."
			
			//	Throw exception
			
			//Throw lex_http
			
		//200 response
		Else
			
			//Assign the status to the status variable
			If ln_jsonPackage.ContainsKey("status") Then
				ls_status = ln_jsonPackage.GetValueString("status")
			Else
				//	Throw exception
			End If
			
			Choose Case ls_status
				Case "failed"

					If ln_jsonPackage.ContainsKey("error") Then
						ls_error = ln_jsonPackage.GetValue("error")
						
						ln_jsonPackage.LoadString(ls_error)
						
						li_errorStatus = ln_jsonPackage.GetValueNumber("status")
						ls_errorCode = ln_jsonPackage.GetValue("code")
						ls_errorMsg = ln_jsonPackage.GetValue("message")
					Else
						//	Throw exception
					End If
					
					If IsNull(li_errorStatus) OR li_errorStatus = 0 Then li_errorStatus = -1
					If IsNull(ls_errorCode) OR ls_errorCode = "" Then ls_errorCode = "unknown"
					If IsNull(ls_errorMsg) OR ls_errorMsg = "" Then ls_errorMsg = "It is impossible to read the response body."
					
					///	Throw exception

				Case "done"
					
					If ln_jsonPackage.ContainsKey("asset") Then
						ls_asset = ln_jsonPackage.GetValue("asset")
						
						ln_jsonPackage.LoadString(ls_asset)
						
						ls_downloadUri = ln_jsonPackage.GetValue("downloadUri")
						ls_assetID = ln_jsonPackage.GetValue("assetID")
					Else
						//	Throw exception
					End If
					
				Case "in progress"
					li_count += 1
					//retry
			End Choose
			
		End If
	
	End If
Loop While ls_status =  "in progress"

Destroy ln_httpClient
Destroy ln_jsonPackage

Return ls_downloadUri
/**/
end function

public function string of_decrypt (string as_data);/*decrypt*/
CrypterObject ln_Crypt
CoderObject ln_CoderObject
Blob lb_key
Blob lb_data
Blob lb_decrypt
String ls_data

ln_Crypt = create CrypterObject
ln_CoderObject = create CoderObject

lb_key = Blob("key", EncodingUTF8!)
lb_data = ln_CoderObject.Base64Decode(as_data)

lb_decrypt = ln_Crypt.SymmetricDecrypt( AES!, lb_data, lb_key)
ls_data = String(lb_decrypt, EncodingUTF8!)

destroy (ln_Crypt)
destroy (ln_CoderObject)

Return ls_data
/**/
end function

private function boolean u_get_credential ();//
kuf_base kuf1_base

//--- leggo API KEY e Secret dio ADOBE
  	kuf1_base = create kuf_base
	is_clientId = trim(mid(kuf1_base.prendi_dato_base( "adobe_clientid"),2))
	is_clientSecret = trim(mid(kuf1_base.prendi_dato_base( "adobe_secret"),2))
	destroy kuf1_base

	if is_clientId > " " and is_clientSecret > " " then
		return true
	else
		return false
	end if

end function

public function integer of_exporttodocx (string as_frompdfpath, string as_todocxpath, n_enum an_ocrlanguage) throws uo_exception;//--VARIABLES
String ls_assetPath
String ls_accessToken
String ls_assetID
String ls_location
String ls_downloadUri

n_fileFormat ln_fileFormat
n_enum ln_ocrLanguage
//--

ls_assetPath = as_fromPdfPath
ln_ocrLanguage = an_ocrLanguage

ln_fileFormat = create n_fileFormat

Try
	ls_accessToken = This.of_retrieveAccessToken()
	ls_assetID = This.of_uploadAsset(ls_assetPath)
	ls_location = This.of_exportPdf(ls_assetID, ln_fileFormat.DOCX, ln_ocrLanguage)
	ls_downloadUri = This.of_fetchStatus(ls_location)
	This.of_downloadAsset(ls_downloadUri, as_toDocxPath)
Catch (uo_exception kuo_exception)
	throw kuo_exception
End Try

if isvalid(ln_fileFormat) then destroy ln_fileFormat 


Return 1
/**/
end function

public function string of_retrieveaccesstoken () throws uo_exception;//--VARIABLES
String ls_url
String ls_body
String ls_response
String ls_accessToken
String ls_error
//String ls_errorCode
//String ls_errorMsg
Integer li_rc
HttpClient ln_httpClient
JsonPackage ln_jsonPackage


try
	kguo_exception.inizializza(this.classname())

	ln_httpClient = create HttpClient
	ln_jsonPackage = create JsonPackage

//select the url for sending the post request from db
//SELECT url INTO :ls__url;

	ls_url = "https://pdf-services.adobe.io/token"  // tolto commento

//Sets the request header
	ln_httpClient.SetRequestHeaders("Content-Type:application/x-www-form-urlencoded")

//Set the body
	ls_body = "client_id=" + is_clientId + "&client_secret=" + is_clientSecret

// Sends request using POST method (to add the string data to the body and set to the Content-Length header)
	li_rc = ln_httpClient.SendRequest("POST", ls_url, ls_body)

//The POST request method is unsuccessful
	If li_rc <> 1 Then
		//ls_errorCode = "unknown"
		//ls_errorMsg = "Powerbuilder post method failed."
		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
		kguo_exception.kist_esito.sqlcode = li_rc
		kguo_exception.kist_esito.sqlerrtext = "Richiesta autorizzazione ADOBE fallita (" + ls_url + "). "
		Throw kguo_exception
	end if

//The POST request method is successful  
	
	//Obtains the response data
	ln_httpClient.GetResponseBody(ls_response)
	
	//Load the body response json
	ln_jsonPackage.LoadString(ls_response)
	
	//Error response
	If ln_httpClient.getresponsestatuscode() <> 200 Then

		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
		kguo_exception.kist_esito.sqlerrtext = "Errore in autorizzazione alla conversione del documento da ADOBE. " 

		If ln_jsonPackage.ContainsKey("error") Then
			ls_error = ln_jsonPackage.GetValue("error")
			ln_jsonPackage.LoadString(ls_error)
			
			kguo_exception.kist_esito.sqlerrtext += " " + kkg.acapo + ln_jsonPackage.GetValue("message") + ". Code: " + ln_jsonPackage.GetValue("code")
			//ls_errorCode = ln_jsonPackage.GetValue("code")
			//ls_errorMsg = ln_jsonPackage.GetValue("message")
		End If
//		If IsNull(ls_errorCode) OR ls_errorCode = "" Then ls_errorCode = "unknown"
//		If IsNull(ls_errorMsg) OR ls_errorMsg = "" Then ls_errorMsg = "It is impossible to read the response body."
		Throw kguo_exception
		//Throw lex_http
		
	end if
	//200 response

	//Assign the access token to the instance variable
	If ln_jsonPackage.ContainsKey("access_token") Then
		ls_accessToken =  ln_jsonPackage.GetValueString("access_token")
		is_accessToken = ls_accessToken
	Else
		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
		kguo_exception.kist_esito.sqlerrtext = "Errore in autorizzazione alla conversione del documento da ADOBE, Token non generato! " 
		//	Throw exception
	End If
	
	
catch (uo_exception kuo_exception)
	Throw kuo_exception

finally
	if isvalid(ln_httpClient) then destroy ln_httpClient
	if isvalid(ln_jsonPackage) then destroy ln_jsonPackage
	
End try

Return ls_accessToken
/**/
end function

public function string of_uploadasset (string as_assetpath) throws uo_exception;//--VARIABLES
String ls_url
String ls_body
String ls_response
String ls_assetID
String ls_uploadURI
String ls_error
//String ls_errorCode
//String ls_errorMsg
Integer li_rc
Integer li_fileNum
Long ll_bytes
Blob lb_file
HttpClient ln_httpClient
JsonPackage ln_jsonPackage
//--


try
	kguo_exception.inizializza(this.classname())

	ln_httpClient = create HttpClient
	ln_jsonPackage = create JsonPackage
	
	
	//Check if the file to upload exists
	If FileExists(as_assetPath) Then
		//read the pdf file to upload and put it in a blob variable
		li_fileNum = FileOpen(as_assetPath, StreamMode!, Read!, LockReadWrite!, Append!, EncodingANSI!)
		ll_bytes = FileReadEx(li_fileNum, lb_file)
		FileClose (li_fileNum)
	Else
		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
		kguo_exception.kist_esito.sqlerrtext = "Errore in conversione file da ADOBE, file non trovato " + kkg.acapo + as_assetPath + ". "
		Throw kguo_exception
	End If
	
	/*getting the pre-signed uri*/
	//select the url for sending the post request from the path table
	//SELECT url
	//INTO :ls_url
	
	
	ls_url = "https://pdf-services-ue1.adobe.io/assets" // tolto commento
	
	//log
	
	//Sets the request header
	ln_httpClient.SetRequestHeader("Authorization", "bearer " + This.of_getAccessToken())
	ln_httpClient.SetRequestHeader("Content-Type", "application/json")
	ln_httpClient.SetRequestHeader("x-api-key", is_clientId)
	
	//Set the body
	ls_body = '{"mediaType":"application/pdf"}'
	
	//Get an upload pre-signed URI
	li_rc = ln_httpClient.SendRequest("POST", ls_url, ls_body)
	
	//The POST request method is unsuccessful  
	If li_rc <> 1 Then
		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
		kguo_exception.kist_esito.sqlcode = li_rc
		kguo_exception.kist_esito.sqlerrtext = "Richiesta definizione Asset ADOBE fallita (" + ls_url + "). "
		Throw kguo_exception
	end if
//The POST request method is successful  
		
	//Obtains the response data
	ln_httpClient.GetResponseBody(ls_response)
	
	//Load the body response json
	ln_jsonPackage.LoadString(ls_response)
	
	//Error response
	If ln_httpClient.getResponseStatusCode() <> 200 Then
		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
		kguo_exception.kist_esito.sqlerrtext = "Errore in definizione Asset ADOBE per la conversione del documento. " 
		If ln_jsonPackage.ContainsKey("error") Then
			ls_error = ln_jsonPackage.GetValue("error")
			ln_jsonPackage.LoadString(ls_error)
			kguo_exception.kist_esito.sqlerrtext += " " + kkg.acapo + ln_jsonPackage.GetValue("message") + ". Code: " + ln_jsonPackage.GetValue("code")
		End If
		Throw kguo_exception
	end if
//200 response
		
	//Assign the assetID to the instance variable
	If ln_jsonPackage.ContainsKey("assetID") Then
		ls_assetID = ln_jsonPackage.GetValueString("assetID")
	Else
		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
		kguo_exception.kist_esito.sqlerrtext = "Errore in definizione Asset ADOBE per la conversione del documento, 'assetID' non generato! " 
		Throw kguo_exception
	End If
	
	//Assign the uploadUri to the local variable
	If ln_jsonPackage.ContainsKey("uploadUri") Then
		ls_uploadURI = ln_jsonPackage.GetValueString("uploadUri")
	Else
		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
		kguo_exception.kist_esito.sqlerrtext = "Errore in definizione Asset ADOBE per la conversione del documento, 'uploadUri' non generata! " 
		Throw kguo_exception
	End If

	/*end getting the pre-signed uri*/
	
	/*uploading the asset*/
	//Clear the restClient headers
	ln_httpClient.ClearRequestHeaders( )
	
	//f_log(gn_log.SetApp("SENDING  PUT REQUEST TO: " + ls_uploadURI, "n_adobeApi.of_uploadAsset"))
	
	ln_httpClient.setRequestHeader("Content-Type", "application/pdf")
	li_rc = ln_httpClient.SendRequest( "PUT", ls_uploadURI, lb_file)
	
	//The PUT request method is unsuccessful  
	If li_rc <> 1 Then
		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
		kguo_exception.kist_esito.sqlcode = li_rc
		kguo_exception.kist_esito.sqlerrtext = "Richiesta Upload Asset ADOBE fallita (" + ls_uploadURI + "). "
		Throw kguo_exception
	end if

//The PUT request method is successful  
		
	//Load the body response json
	ln_jsonPackage.LoadString(ls_response)
	
	//Error response
	If ln_httpClient.getresponsestatuscode() <> 200 Then
		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
		kguo_exception.kist_esito.sqlerrtext = "Errore in Upload Asset ADOBE per la conversione del documento. " 
		If ln_jsonPackage.ContainsKey("error") Then
			ls_error = ln_jsonPackage.GetValue("error")
			ln_jsonPackage.LoadString(ls_error)
			kguo_exception.kist_esito.sqlerrtext += " " + kkg.acapo + ln_jsonPackage.GetValue("message") + ". Code: " + ln_jsonPackage.GetValue("code")
		End If
		Throw kguo_exception
	End If

//200 response
		
/*end uploading the asset*/
		
catch (uo_exception kuo_exception)
	Throw kuo_exception

finally
	if isvalid(ln_httpClient) then destroy ln_httpClient
	if isvalid(ln_jsonPackage) then destroy ln_jsonPackage
	
End try

Return ls_assetID
/**/
end function

public function string of_exportpdf (string as_assetid, n_enum an_fileformat, n_enum an_ocrlanguage) throws uo_exception;//--VARIABLES
String ls_url
String ls_body
String ls_response 
String ls_fileFormat
String ls_ocrLanguage
String ls_location
String ls_error
String ls_errorCode
String ls_errorMsg
Integer li_rc
HttpClient ln_httpClient
JsonPackage ln_jsonPackage
//--

ln_httpClient = create HttpClient
ln_jsonPackage = create JsonPackage


ls_fileFormat = an_fileFormat.of_getName()
ls_ocrLanguage = an_ocrLanguage.of_getName()

//select the url for sending the post request from the path table
//SELECT url
//INTO :ls_url

ls_url = "https://pdf-services-ue1.adobe.io/operation/exportpdf" // tolto commento

//log
//gn_log.SetApp("SENDING POST REQUEST TO: " + ls_url, "n_adobeApi.of_exportPdf"))

//Sets the request header
ln_httpClient.SetRequestHeader("Authorization", "bearer " + This.of_getAccessToken())
ln_httpClient.SetRequestHeader("Content-Type", "application/json")
ln_httpClient.SetRequestHeader("x-api-key", is_clientId)

//Set the body
ls_body = '{"assetID": "' + as_assetID + '","targetFormat": "' + ls_fileFormat + '"}'//'","ocrLang": "' + ls_ocrLanguage + '"}'

//Get an upload pre-signed URI
li_rc = ln_httpClient.SendRequest("POST", ls_url, ls_body)

//The POST request method is unsuccessful  
If li_rc <> 1 Then

	ls_errorCode = "unknown"
	ls_errorMsg = "Powerbuilder post method failed."
	
	//	Throw exception
	
//The POST request method is successful  
Else
	
	//Obtain the response
	ln_httpClient.GetResponseBody(ls_response)
	
	//Load the body response json
	ln_jsonPackage.LoadString(ls_response)
	
	//Error response
	If ln_httpClient.getResponseStatusCode() <> 201 Then
		
		If ln_jsonPackage.ContainsKey("error") Then
			ls_error = ln_jsonPackage.GetValue("error")
			
			ln_jsonPackage.LoadString(ls_error)
			
			ls_errorCode = ln_jsonPackage.GetValue("code")
			ls_errorMsg = ln_jsonPackage.GetValue("message")
		End If
		
		If IsNull(ls_errorCode) OR ls_errorCode = "" Then ls_errorCode = "unknown"
		If IsNull(ls_errorMsg) OR ls_errorMsg = "" Then ls_errorMsg = "It is impossible to read the response body."
		
		If ln_httpClient.getResponseStatusCode() = 429 AND ls_errorCode = "INSUFFICIENT_QUOTA" Then
			//	Throw exception
		Else
			//	Throw exception
		End If
		
		//Throw lex_http
		
	//201 response
	Else
		
		//Assign the location to the local variable
		ls_location = ln_httpClient.GetResponseHeader("location")
		
		If IsNull(ls_location) OR ls_location = "" Then 
			
			//	Throw exception
		End If
		
	End If

End If

Destroy ln_httpClient
Destroy ln_jsonPackage

Return ls_location
/**/
end function

public subroutine of_downloadasset (string as_downloaduri, string as_saveasfullpath) throws uo_exception;//--VARIABLES
Dec{0} ldc_length
Long ll_len
Long ll_fileNum
Long ll_loop
Blob lb_temp

String ls_url
String ls_length
String ls_response
String ls_error
String ls_errorStatus
String ls_errorCode
String ls_errorMsg
Integer li_rc
HttpClient ln_httpClient
JsonPackage ln_jsonPackage
//--


try
	kguo_exception.inizializza(this.classname())
	
	ln_httpClient = create HttpClient
	ln_jsonPackage = create JsonPackage

//Set the URL
	ls_url  = as_downloaduri

// Do not read data automatically after sending request (default is true)
	ln_httpClient.autoreaddata = false

//log

//Get the converted file
	li_rc = ln_httpClient.SendRequest("GET", ls_url)

//The GET request method is unsuccessful  
	If li_rc <> 1 Then
		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
		kguo_exception.kist_esito.sqlcode = li_rc
		kguo_exception.kist_esito.sqlerrtext = "Richiesta di scarico del documento da ADOBE fallita (" + ls_url + "). "
		Throw kguo_exception
	end if
	
//The GET request method is successful  
	
	//Error response
	If ln_httpClient.getresponsestatuscode() <> 200 Then

		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
		kguo_exception.kist_esito.sqlerrtext = "Errore in scarico documento convertito da ADOBE. Url: " + kkg.acapo + ls_url + ". " 
		ln_jsonPackage.LoadString(ls_response) //Load the body response json
		If ln_jsonPackage.ContainsKey("error") Then
			ls_error = ln_jsonPackage.GetValue("error")
			ln_jsonPackage.LoadString(ls_error)
			kguo_exception.kist_esito.sqlerrtext += " " + kkg.acapo + ln_jsonPackage.GetValue("message") + ". Code: " + ln_jsonPackage.GetValue("code")
		End If
		Throw kguo_exception
	end if
		
//200 response

	//Get the file length
	ls_length = ln_httpClient.GetResponseHeader("Content-Length")
	ldc_length = Dec (ls_length)
	
	If ldc_length <= 0 Then
		
		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
		kguo_exception.kist_esito.sqlerrtext = "Errore in conversione file da ADOBE, file generato non corretto, prego riprovare. "
		Throw kguo_exception

	End If
	
	//Receive 16KB data every time
	ll_loop = 1024 * 16
	
	//Write data to the file, because the blob variable is not suitable for large data
	ll_FileNum = FileOpen(as_saveAsFullPath, StreamMode!, Write!, LockWrite!, Replace!)
	
	//if the FileOpen method is unsuccessful
	If ll_FileNum = -1 Then
		
		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
		kguo_exception.kist_esito.sqlerrtext = "Errore in conversione file da ADOBE, file scaricato non corretto: " &
								+ kkg.acapo + as_saveAsFullPath + " " + kkg.acapo + "Prego riprovare. "
		Throw kguo_exception
		
	//if the FileOpen method is successful
	end if
	
	Do While (li_rc = 1)
		lb_temp = Blob("")
		li_rc = ln_httpClient.ReadData(lb_temp, ll_loop)
		FileWrite(ll_fileNum, lb_temp)
	Loop
	
	FileClose(ll_fileNum)


catch (uo_exception kuo_exception)
	Throw kuo_exception

finally
	if isvalid(ln_httpClient) then destroy ln_httpClient
	if isvalid(ln_jsonPackage) then destroy ln_jsonPackage
	
End try
/**/
end subroutine

on n_adobeapi.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_adobeapi.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
//If Len(ls_error) > 0 Then
	//log
//End If
ki_credential_enabled = u_get_credential( ) // get from db

kin_ocrLanguage = create n_ocrLanguage

// in test non ho bisogno di decrypt
//This.is_clientId = of_decrypt(ls_clientId)
//This.is_clientSecret = of_decrypt(ls_clientSecret)
//This.is_clientId = (ls_clientId)
//This.is_clientSecret = (ls_clientSecret)
//
/**/
end event

event destructor;//
if isvalid(kin_ocrLanguage) then destroy kin_ocrLanguage

end event

