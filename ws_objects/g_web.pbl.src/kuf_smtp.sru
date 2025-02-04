$PBExportHeader$kuf_smtp.sru
forward
global type kuf_smtp from smtpclient
end type
end forward

global type kuf_smtp from smtpclient
end type
global kuf_smtp kuf_smtp

type variables
//
private:
string ki_rag_soc_azienda, ki_email_di_ritorno

public:
boolean ki_sendAsync_result = true
string ki_send_error_text
int ki_send_error_code
end variables

forward prototypes
public subroutine invio (ref st_tab_email_invio ast_tab_email_invio, ref string a_message) throws uo_exception
end prototypes

public subroutine invio (ref st_tab_email_invio ast_tab_email_invio, ref string a_message) throws uo_exception;/* 
Invio e-mail attraverso SMTP
	inp: st_tab_email_invio.*
	     messaggio (testo o html) del body
	out: true = Mail sent successfully	
*/
String ls_filename, k_email
Integer li_idx, li_max, k_pos_ini, k_pos_fin, k_rc
string k_attached_files[]
int k_idx, k_idx_max
datastore kds_dirlist
st_email_address kst_email_address
kuf_file_explorer kuf1_file_explorer
kuf_email kuf1_email
kuf_email_invio kuf1_email_invio


try
	//SetPointer(HourGlass!)
	
	if not ki_sendAsync_result then return   // se SEND fallita non esegue
	
	kguo_exception.inizializza(this.classname())
	
	kuf1_email = create kuf_email

	kuf1_file_explorer = create kuf_file_explorer

	this.message.reset( )
	
	this.Message.Encoding = "UTF-8"

	if trim(ast_tab_email_invio.email_di_ritorno) > " " then
	else
		ast_tab_email_invio.email_di_ritorno = ki_email_di_ritorno
	end if
	this.message.setsender(trim(ast_tab_email_invio.email_di_ritorno), ki_rag_soc_azienda)
	
//ad oggi dic-2024 non è prevista questa proprietà
//	if ast_tab_email_invio.flg_ritorno_ricev = ki_ricev_ritorno_si then
//		gn_smtp.of_SetReceipt(true)
//	else
//		gn_smtp.of_SetReceipt(false)
//	end if

//--- Imposto l'oggetto
	this.message.Subject = ast_tab_email_invio.oggetto
	
//--- Imposto il corpo della comunicazione da Inviare!!!!!!!
	if ast_tab_email_invio.flg_lettera_html = kuf1_email_invio.ki_lettera_html_si then
		this.message.HTMLBody = a_message
	else
		this.message.TextBody = a_message
	end if
		
//--- Aggiungo gli Indirizzi email separati da ',' o ';' se più di uno nel recipient 
//      e Controllo sintassi Indirizzi email				
	try
		kst_email_address.email_all = ast_tab_email_invio.email
		kuf1_email.get_email_from_string(kst_email_address)
		k_idx_max = upperbound(kst_email_address.address[])
		for k_idx = 1 to k_idx_max
			k_email = kst_email_address.address[k_idx]
			if k_email > " " then
				this.message.AddRecipient(k_email, " ")  // potrei mettere IL NOME del destinatario: sle_send_name.text)
			end if
		next
		kst_email_address.email_all = ast_tab_email_invio.email_cc
		kuf1_email.get_email_from_string(kst_email_address)
		k_idx_max = upperbound(kst_email_address.address[])
		for k_idx = 1 to k_idx_max
			k_email = kst_email_address.address[k_idx]
			if k_email > " " then
				this.message.AddCc(k_email, " ")  // potrei mettere IL NOME del destinatario: sle_send_name.text)
			end if
		next
		kst_email_address.email_all = ast_tab_email_invio.email_ccn
		kuf1_email.get_email_from_string(kst_email_address)
		k_idx_max = upperbound(kst_email_address.address[])
		for k_idx = 1 to k_idx_max
			k_email = kst_email_address.address[k_idx]
			if k_email > " " then
				this.message.AddBcc(k_email, " ")  // potrei mettere IL NOME del destinatario: sle_send_name.text)
			end if
		next
	catch (uo_exception kuo1_exception)
		kguo_exception.kist_esito = kuo1_exception.get_st_esito()
		kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione  
		throw kguo_exception
	end try
	
// add any attachments
	if ast_tab_email_invio.flg_allegati = kuf1_email_invio.ki_allegati_si then
		
		if trim(ast_tab_email_invio.allegati_cartella) > " " then	
			if DirectoryExists (trim(ast_tab_email_invio.allegati_cartella)) then
//--- piglia l'elenco dei file xml contenuti nella cartella
				kds_dirlist = kuf1_file_explorer.DirList(ast_tab_email_invio.allegati_cartella+"\*.*")
				li_max = kds_dirlist.rowcount()
				if right(ast_tab_email_invio.allegati_cartella, 1) = kkg.path_sep then
				else
					ast_tab_email_invio.allegati_cartella += kkg.path_sep
				end if
				for li_idx = 1 to li_max
//--- estrae il file da allegare
					ls_filename = trim(kds_dirlist.getitemstring(li_idx, "nome"))
					this.message.AddAttachment(ast_tab_email_invio.allegati_cartella + ls_filename) // aggiunge un file 
				end for
			else
//--- se la cartella non esiste
				kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione  
				kguo_exception.kist_esito.SQLErrText = "La cartella Allegati (" + trim(ast_tab_email_invio.allegati_cartella) + ") non esiste. Id e-mail " &
						+ string(ast_tab_email_invio.id_email_invio) + " non inviata! "
				throw kguo_exception
			end if
		end if
		
//--- invio di singoli file separati da ';' se indicato
		if trim(ast_tab_email_invio.allegati_pathfile) > " " then	
			k_attached_files[1] = trim(ast_tab_email_invio.allegati_pathfile)
			li_max = kgn_string.u_stringa_split(k_attached_files[], ";")  // divide la stringa in più file separati da ';'
			k_idx = 0
			for li_idx = 1 to li_max
				if k_attached_files[li_idx] > " " then
					k_idx ++
					if k_idx > 10 then 
						kguo_exception.inizializza(this.classname())
						kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_dati_anomali
						
						kguo_exception.kist_esito.sqlerrtext = "Errore in Invio EMAIL id " + string(ast_tab_email_invio.id_email_invio) &
											+ ". Superati i 10 file allegati, questo il primo dei non inviati: " + k_attached_files[li_idx] + ". Prego Verificare!!!" &
											+ " Email inviata ugualmente ma non con tutti gli allegati." 
						exit  // NON ALLEGA PIU' DI 10 FILE !!!!
						
					end if
					this.message.AddAttachment(k_attached_files[li_idx]) // aggiunge un file 
				end if
			end for

		end if
	//li_max = lb_attachments.TotalItems()
	//For li_idx = 1 To li_max
	//	ls_filename = lb_attachments.Text(li_idx)
	//	gn_smtp.of_AddFile(ls_filename)
	//Next
	end if
	
//	gn_smtp.of_setmessagebox(ki_messagebox_if_error)   // true = espone un messagebox se c'e' un errore; FALSE=scrive solo log
	
// send the message
	this.SendAsync()    //Sends the email asynchronously, Check the OnSendFinished EVENT for result
//	k_rc = this.Send( )
//	if k_rc < 0 then
//		kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
//		kguo_exception.kist_esito.sqlcode = k_rc
//		kguo_exception.kist_esito.sqlerrtext = "Fallito invio email " + string(ast_tab_email_invio.id_email_invio)
//		throw kguo_exception
//	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally	
	if isvalid(kuf1_email) then destroy kuf1_email
	if isvalid(kds_dirlist) then destroy kds_dirlist
	if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
	
	
end try


end subroutine

on kuf_smtp.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_smtp.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//
string k_esito
kuf_base kuf1_base


	kguo_exception.inizializza(this.classname())

	kuf1_base = create kuf_base
	
	this.EnableTLS = false //True
	
	k_esito = kuf1_base.prendi_dato_base( "smtp_logfile")
	if left(k_esito,1) <> "0" then
		kguo_exception.kist_esito.esito = kkg_esito.ko  
		kguo_exception.kist_esito.SQLErrText = mid(k_esito,2)
	else
		kuf1_base.kist_tab_base.smtp_logfile = trim(mid(k_esito,2))
	end if
	if kuf1_base.kist_tab_base.smtp_logfile = "S" then
		this.Logfile(kguo_path.get_TEMP() + kkg.path_sep + "mail.log")
	End If
	FileDelete(kguo_path.get_TEMP() + kkg.path_sep + "mail.log")
	
	k_esito = kuf1_base.prendi_dato_base( "smtp_autorizz_rich")
	if left(k_esito,1) <> "0" then
		kguo_exception.kist_esito.esito = kkg_esito.ko  
		kguo_exception.kist_esito.SQLErrText = mid(k_esito,2)
//		throw kguo_exception
	else
		kuf1_base.kist_tab_base.smtp_autorizz_rich = trim(mid(k_esito,2))
	end if

	if kuf1_base.kist_tab_base.smtp_autorizz_rich = "S" then
	//If of_getreg("SmtpAuth", "N") = "Y" Then
		k_esito = kuf1_base.prendi_dato_base( "smtp_user")
		if left(k_esito,1) <> "0" then
			kguo_exception.kist_esito.esito = kkg_esito.ko  
			kguo_exception.kist_esito.SQLErrText = mid(k_esito,2)
//			throw kguo_exception
		else
			kuf1_base.kist_tab_base.smtp_user = trim(mid(k_esito,2))
			this.Username = kuf1_base.kist_tab_base.smtp_user
		end if

		k_esito = kuf1_base.prendi_dato_base( "smtp_pwd")
		if left(k_esito,1) <> "0" then
			kguo_exception.kist_esito.esito = kkg_esito.ko  
			kguo_exception.kist_esito.SQLErrText = mid(k_esito,2)
//			throw kguo_exception
		else
			kuf1_base.kist_tab_base.smtp_pwd = trim(mid(k_esito,2))
			this.password = kuf1_base.kist_tab_base.smtp_pwd		
		end if
	End If

	k_esito = kuf1_base.prendi_dato_base( "smtp_port")
	if left(k_esito,1) <> "0" then
		kguo_exception.kist_esito.esito = kkg_esito.ko  
		kguo_exception.kist_esito.SQLErrText = mid(k_esito,2)
//		throw kguo_exception
	else
		if isnumber(trim(mid(k_esito,2))) then
			kuf1_base.kist_tab_base.smtp_port = trim(mid(k_esito,2))
			this.port = integer(kuf1_base.kist_tab_base.smtp_port)
		end if
	end if
	
	k_esito = kuf1_base.prendi_dato_base( "smtp_server")
	if left(k_esito,1) <> "0" then
		kguo_exception.kist_esito.esito = kkg_esito.ko  
		kguo_exception.kist_esito.SQLErrText = mid(k_esito,2)
//		throw kguo_exception
	else
		kuf1_base.kist_tab_base.smtp_server = trim(mid(k_esito,2))
		this.host = kuf1_base.kist_tab_base.smtp_server
	end if
//	gn_smtp.of_SetServer(kst_tab_base.smtp_server)

	k_esito = kuf1_base.prendi_dato_base( "rag_soc_1")
	if left(k_esito,1) <> "0" then
		kguo_exception.kist_esito.esito = kkg_esito.ko  
		kguo_exception.kist_esito.SQLErrText = mid(k_esito,2)
//		throw kguo_exception
	else
		kuf1_base.kist_tab_base.rag_soc_1 = trim(mid(k_esito,2))
	end if
	k_esito = kuf1_base.prendi_dato_base( "rag_soc_2")
	if left(k_esito,1) <> "0" then
		kguo_exception.kist_esito.esito = kkg_esito.ko  
		kguo_exception.kist_esito.SQLErrText = mid(k_esito,2)
//		throw kguo_exception
	else
		kuf1_base.kist_tab_base.rag_soc_2 = trim(mid(k_esito,2))
	end if
	if isnull(kuf1_base.kist_tab_base.rag_soc_1) then kuf1_base.kist_tab_base.rag_soc_1 = ""
	if isnull(kuf1_base.kist_tab_base.rag_soc_2) then kuf1_base.kist_tab_base.rag_soc_2 = ""
	ki_rag_soc_azienda = kuf1_base.kist_tab_base.rag_soc_1 + " " + kuf1_base.kist_tab_base.rag_soc_2

	k_esito = kuf1_base.prendi_dato_base( "e_mail")
	if left(k_esito,1) <> "0" then
		kguo_exception.kist_esito.esito = kkg_esito.ko  
		kguo_exception.kist_esito.SQLErrText = mid(k_esito,2)
		ki_email_di_ritorno = "email@email.com"   // nel caso la email non si trovi neanche in Proprietà Azienda
	else
		ki_email_di_ritorno = trim(mid(k_esito,2))
	end if

end event

event onsendfinished;//

kguo_exception.inizializza(this.classname())

if errornumber = 1 then
	ki_sendAsync_result = true
else
	ki_sendAsync_result = false
	ki_send_error_code = errornumber
	ki_send_error_text = errortext
	kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_ko
	kguo_exception.kist_esito.sqlcode = errornumber
	kguo_exception.kist_esito.sqlerrtext = errortext
	kguo_exception.messaggio_utente( )
end if


end event

