$PBExportHeader$kuf_programmi.sru
forward
global type kuf_programmi from kuf_parent0
end type
end forward

global type kuf_programmi from kuf_parent0
end type
global kuf_programmi kuf_programmi

forward prototypes
public function long get_id_programma_last () throws uo_exception
public subroutine _readme ()
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

public subroutine _readme ();/* Tabelle AUSILIARIE di configurazione

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

on kuf_programmi.create
call super::create
end on

on kuf_programmi.destroy
call super::destroy
end on

