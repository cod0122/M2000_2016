Step per fare i nuovi statistici via store-procedure anzichè via 'NT'

1) Connettersi al server come utente INFORMIX non come informix_67


2) lanciare u_m2000_inizializzaSoloPrimaVolta.sql
le DROP contenute nel job non sono pericolose in quanto rimuovono solo le VIEW/TABLE relative agli ststistici e che quindi 
sono poi ricreate automaticamente durante le operazioni di creazione statistici;
è utile in quanto la vecchia gestione insisteva sulle tabelle che ora sono invece delle VIEW, pertanto la pulizia è necessaria 
almeno prima del PRIMO LANCIO;
i comandi sql contenuti possono essere lanciati anche da terminale con questo comando:

dbaccess gammarad u_m2000_inizializzaSoloPrimaVolta.sql

entrare in ambiente 'DOS' con il .bat generato al momento della generazione del DB e che di solito si chiama
nomeserver.cmd (ad esempio s67apps1.cmd o gammarad_prs32.cmd) che è sotto la cartella di programmi\IBM informix 


3) lanciare u_m2000_CREA_SPL.bat
ma prima controlla se nella SPL 'u_m2000_get_datetime.spl.sql' c'e' il comando in prima linea di connessione al DB:

CONNECT to 'gammarad@informix_prs64' user 'informix' using 'Gamma67rad';
dove gammarad = dome del DB
informix_prs64 = nome del DB server
'informix' = nome utente
'Gamma67rad' = password 

questo job crea un unica SPL ("u_m2000_z_all.spl.sql") che poi lancia e genera automaticamente TUTTE le SP necessarie 

ovviamente bisogna essere entrati in 'DOS' con il .bat generato al momento della generazione del DB e che di solito si chiama
nomeserver.bat (ad esempio gammarad_prx1.bat o gammarad_prs32.bat)  
si deve lanciarlo dalla cartella che contiene questo file .bat


x) volendo fare un test è possibile eseguire gli statistici lanciando: u_m2000_execute_statatici.bat
ma prima controlla se nella SPL 'u_m2000_execute_statatici.sql' c'e' il comando in prima linea di connessione al DB come indicato sopra

ovviamente bisogna essere entrati in 'DOS' con il .bat generato al momento della generazione del DB e che di solito si chiama
nomeserver.bat (ad esempio gammarad_prx1.bat o gammarad_prs32.bat)  
si deve lanciarlo dalla cartella che contiene questo file .bat


no) il u_m2000_wm_pklist_flag_sped.sql
esegue un riallineamento dei flag di 'spedito' sulle tabelle che però è meglio non lanciare 
se dovesse diventare necessario lo vediamo insieme in quanto la SP esegue una scansione di tutto quanto fin dall'inizio dei tempi!!
