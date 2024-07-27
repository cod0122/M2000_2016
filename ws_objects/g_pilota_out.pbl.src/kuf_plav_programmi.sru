$PBExportHeader$kuf_plav_programmi.sru
forward
global type kuf_plav_programmi from kuf_parent
end type
end forward

global type kuf_plav_programmi from kuf_parent
end type
global kuf_plav_programmi kuf_plav_programmi

forward prototypes
public function long get_id_programma_last () throws uo_exception
public subroutine _readme ()
private function boolean anteprima (ref ds_programmi_richieste_skeda ads_anteprima, st_plav_programmi ast_plav_programmi) throws uo_exception
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
end prototypes

public function long get_id_programma_last () throws uo_exception;/*
 Torna l'ultimo ID Programma 
 inp: 
 out: 
 ret: id_programma
*/
long k_return


try
	
	kguo_exception.inizializza(this.classname())
			
	select max(id_programma)
		   into :k_return
		   from programmi_richieste
			using kguo_sqlca_db_plav;
	
	if kguo_sqlca_db_plav.sqlcode < 0 then
		kguo_exception.set_st_esito_err_db(kguo_sqlca_db_plav, "Errore in lettura dell'ultimo Id Programma caricato in archivio Richieste Programmazione Impianto.")
		throw kguo_exception
	end if
		
	if k_return > 0 then
	else
		k_return = 0
	end if
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally


end try


return k_return
end function

public subroutine _readme ();/* Tabelle di scambio con il PILOTA

aueste tabelle sono solo utili per avere una descrizione di aluni valori presenti nelle Tabelle OPERATIVE

	TABLE [dbo].[impianti](
		[id_impianto] [char](2) NOT NULL,
		[descrizione] [varchar](80) NULL,

	TABLE [dbo].[impianti_modi](
		[id_impianto] [char](2) NOT NULL,
		[id_modo] [char](2) NOT NULL,
		[descrizione] [varchar](100) NULL,

	TABLE [dbo].[tipi_accessori](
		[id_accessorio] [char](1) NOT NULL,
		[descrizione] [varchar](100) NULL,

	TABLE [dbo].[tipi_richieste](
		[id_tipo_richiesta] [tinyint] NOT NULL,
		[descrizione] [varchar](100) NULL,

	TABLE [dbo].[tipi_stato](
		[id_stato] [tinyint] NOT NULL,
		[descrizione] [varchar](80) NOT NULL



Tabelle OPERATIVE con i valori della Pianificazione delle Lavorazioni in sostituzione del flie TXT:

	contiene i barcode dei dosimetri ed eventualmente altre tipologie di etichette
	questi valori erano nello stesso file dei pallet in groupage (barcode figli) ad esempio 'pp_pilotaNNNN.txt' dove NNNN era referenziato nel 'command_grp.txt'
		TABLE [dbo].[programmi_accessori](
			[id_programma] [int] NOT NULL,                      id della Richiesta
			[barcode_pallet] [char](8) NOT NULL,    			barcode PADRE
			[barcode_accessorio] [char](8) NOT NULL,			etichetta barcode Accessorio (x ora è il Dosimetro)
			[barcode_f] [char](8) NOT NULL,						barcode figlio se l'accessorio è sul figlio
			[id_accessorio] [char](1) NOT NULL,					vedi tab tipi_accessori
			[posizione_accessorio] [char](2) NOT NULL,	        posizione dell'accessorio sul pallet

	contiene i pallet PADRI solo x impiano G2 era nei file 'pp_pilotaNNNN.txt' dove NNNN era referenziato nel 'command.txt' 
		TABLE [dbo].[programmi_dettaglio_g2](
			[id_programma] [int] NOT NULL,						id della Richiesta
			[sequenza] [int] NOT NULL,							sequenza di messa in Lavorazione 
			[id_impianto] [char](2) NOT NULL,					vedi tabella impianti (ma sempre G2)
			[barcode] [char](8) NOT NULL,						barcode PADRE
			[posizione_bilancella] [char](4) NULL,				posizione come ad esempio '2HMM'
			[giri_f1] [int] NOT NULL,
			[giri_f2] [int] NOT NULL,
			[giri_f1p] [int] NOT NULL,
			[giri_f2p] [int] NOT NULL,
			[codice_cliente] [varchar](8) NULL,
			[nome_cliente] [varchar](255) NULL,
			[riferimento] [varchar](12) NULL,
			[locazione] [varchar](24) NULL,						locazione in magazzino ad es.: 'G1C130'

	contiene i pallet PADRI solo x il nuovo impiano G3 
		TABLE [dbo].[programmi_dettaglio_g3](
			[id_programma] [int] NOT NULL,						id della Richiesta
			[sequenza] [int] NOT NULL,							sequenza di messa in Lavorazione 
			[id_impianto] [char](2) NOT NULL,					vedi tabella impianti (ma sempre G3)
			[id_modo] [char](2) NOT NULL,						modo di trattamento vedi tab. impianti_modi
			[barcode] [char](8) NOT NULL,						barcode PADRE
			[giri] [int] NOT NULL,								n. giri
			[ciclo] [varchar](16) NOT NULL,						codice CICLO 
			[codice_cliente] [varchar](8) NULL,
			[nome_cliente] [varchar](255) NULL,
			[riferimento] [varchar](12) NULL,
			[locazione] [varchar](24) NULL,						locazione in magazzino ad es.: 'G1C130'


	contiene i pallet (FIGLI) abbinati a un altro pallet principale (PADRE) 
	questi valori erano nel file dei groupage ad esempio 'pp_pilotaNNNN.txt' dove NNNN era referenziato nel 'command_grp.txt'
		TABLE [dbo].[programmi_groupage](
			[id_programma] [int] NOT NULL,						id della Richiesta
			[barcode_padre] [char](8) NOT NULL,					
			[barcode_figlio] [char](8) NOT NULL,
			[sequenza] [int] NULL,								sequenza di messa in Lavorazione riferita al barcode PADRE
			[f_codice_cliente] [varchar](8) NULL,				codice cliente del barcode FIGLIO
			[f_nome_cliente] [varchar](255) NULL,				nominativo cliente del barcode FIGLIO
			[f_riferimento] [varchar](12) NULL,					numero Riferimento del Lotto del barcode FIGLIO
			[f_locazione] [varchar](24) NULL,					locazione del barcode FIGLIO

 	contiene le Richieste di Pianificazione Lavorazioni che erano nei file 'command.txt' e 'command_grp.txt' ora in un'unica riga
		TABLE [dbo].[programmi_richieste](
			[id_programma] [int] IDENTITY(1,1) NOT NULL,      	id della Richiesta UNIVOCO progressivo (col. autoincrementale Identity) 
			[id_impianto] [char](2) NOT NULL,					vedi tabella impianti
			[id_modo] [char](2) NOT NULL,						modo di trattamento vedi tab. impianti_modi
			[richiesta_data_ora] [datetime] NOT NULL,			
			[id_tipo_richiesta] [tinyint] NOT NULL,				vedi tabella tipi_richieste
			[barcode_prima] [varchar](8) NULL,					se indicato significa il piano va inserito prima di questa barcode che è già stato inviato alla pianificazione
			[id_pl_barcode] [int] NOT NULL,						codice di M2000 relativo alla tabella di Pianificazione dell'utente
			[id_stato] [tinyint] NOT NULL,						vedi tabella tipi_stato
			[esito] [char](4) NOT NULL,							un codice esito libero per segnalare un'anmalia
			[esito_descr] [varchar](255) NULL,
			[esito_data_ora] [datetime] NULL,

 	contiene l'elenco dei codici Work-Order della Procedura che erano nei file 'pp_pilotaNNNNN_WO.txt'
		TABLE [dbo].[programmi_work_orders](
			[id_programma] [int] NOT NULL,						id della Richiesta
			[work_order] [numeric](10, 0) NOT NULL,
			[barcode] [char](8) NOT NULL,						barcode di trattamento (tutti PADRE e FIGLI)
			[abilitazione] [int] NOT NULL,						1=abilitato al trattamento; 0=non trattato
*/
end subroutine

private function boolean anteprima (ref ds_programmi_richieste_skeda ads_anteprima, st_plav_programmi ast_plav_programmi) throws uo_exception;/*
  Operazione di preparazione datastore dei dati richiesti
  Inp: ds_programmi_richieste_skeda su cui fare l'anteprima
       dati tabella per estrazione dell'anteprima
  Out: datastore di anteprima
*/
long k_rc
boolean k_return


	kguo_exception.inizializza(this.classname())

	//if_sicurezza(kkg_flag_modalita.anteprima)

	if ast_plav_programmi.id_programma > 0 then

		ads_anteprima.reset()	
		k_rc=ads_anteprima.retrieve(ast_plav_programmi.id_programma)
		if k_rc < 0 then
			kguo_exception.set_st_esito_err_ds(ads_anteprima, "Errore in lettura Richieste Inviate al Pilota id " + string(ast_plav_programmi.id_programma))
			throw kguo_exception
		end if
		
		if k_rc > 0 then
			k_return = true
		end if
		
	end if

return k_return
	
end function

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;/*
  Attiva LINK cliccato 
  Par. Inut:    datawindow su cui è stato attivato il LINK
                nome campo di LINK
  Rit: TRUE = ok 
*/
long k_rc
boolean k_return=true
string k_title, k_rcx
st_plav_programmi kst_plav_programmi
kuf_elenco kuf1_elenco
kuf_utility kuf1_utility
ds_programmi_richieste_skeda kds_programmi_richieste_skeda
datastore kds_elenco_output   //ds da passare alla windows di elenco


try 

	if_sicurezza(kkg_flag_modalita.anteprima)  // verifica sicurezza

	SetPointer(kkg.pointer_attesa)
	
	kds_programmi_richieste_skeda = create ds_programmi_richieste_skeda

	kguo_exception.inizializza(this.classname())

	choose case a_campo_link
	
		case "programmi_richieste_id_programma"
			k_rcx = adw_link.describe(a_campo_link + ".color")
			if k_rcx = "!" or k_rcx = "?" then
			else
				kst_plav_programmi.id_programma = adw_link.getitemnumber(adw_link.getrow(), a_campo_link)
				if kst_plav_programmi.id_programma > 0 then
			
					anteprima( kds_programmi_richieste_skeda, kst_plav_programmi )
					k_title = "Id Richiesta Pilota: " + string(kst_plav_programmi.id_programma)
					
				else
					k_return = false
				end if
			end if

	end choose
		
	if k_return then

		if kds_programmi_richieste_skeda.rowcount() > 0 then

			kuf1_utility = create kuf_utility
			kds_elenco_output = create datastore
			kds_elenco_output.dataobject = kds_programmi_richieste_skeda.dataobject
			kds_programmi_richieste_skeda.rowscopy(1, kds_programmi_richieste_skeda.rowcount(), primary!, kds_elenco_output, 1, primary!)
			kuf1_utility.u_copy_ds_composite(kds_programmi_richieste_skeda, kds_elenco_output)
			
			kuf1_elenco = create kuf_elenco
			kuf1_elenco.u_open_zoom(k_title, a_campo_link, kds_elenco_output, kguo_sqlca_db_plav.ki_title_id ) //CAMPO DI LINK + DATASTORE CON I DATI
	
		else
		
			kguo_exception.setmessage(u_get_errmsg_nontrovato(kkg_flag_modalita.elenco))
			throw kguo_exception
		
		end if

	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally 
	if isvalid(kuf1_elenco) then destroy kuf1_elenco
	if isvalid(kds_programmi_richieste_skeda) then destroy kds_programmi_richieste_skeda
	if isvalid(kuf1_utility) then destroy kuf1_utility
	SetPointer(kkg.pointer_default)
	

end try


return k_return

end function

on kuf_plav_programmi.create
call super::create
end on

on kuf_plav_programmi.destroy
call super::destroy
end on

