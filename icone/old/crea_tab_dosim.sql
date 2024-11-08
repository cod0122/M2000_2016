drop table 'informix'.meca_dosimdalett;
CREATE TABLE 'informix'.meca_dosimdalett (
id_meca_dosimdalett serial
, id_meca INTEGER NOT NULL
, barcode CHAR(13)
, barcode_dosimetro CHAR(13)
, dosim_data DATE
, dosim_flg_tipo_dose char (1)
, dosim_dose DECIMAL(7,2)
, dosim_assorb INTEGER
, dosim_spessore INTEGER
, dosim_rapp_a_s DECIMAL(6,2)
, dosim_lotto_dosim CHAR(16)
, dosim_temperatura INTEGER
, dosim_umidita INTEGER
, dosim_esito char (1)
, dosim_note varchar(254)
, note varchar(254)
, x_data_dosim_lettura DATETIME YEAR TO FRACTION(5)
, x_utente_dosim_lettura CHAR(12)
, x_data_dosim_verifica DATETIME YEAR TO FRACTION(5)
, x_utente_dosim_verifica CHAR(12)
, x_datins DATETIME YEAR TO FRACTION(5)
, x_utente CHAR(12)) ;
ALTER TABLE 'informix'.meca_dosimdalett ADD CONSTRAINT ( PRIMARY KEY ( id_meca_dosimdalett ) CONSTRAINT meca_dosimdalett_pk ) ;
CREATE INDEX i_meca_dosimdalett ON 'informix'.meca_dosimdalett (id_meca ) ;
CREATE INDEX i_meca_dosimdalett1 ON 'informix'.meca_dosimdalett (barcode) ;