--==============================
--      CREAZIONE TABELLE
--==============================


CREATE TABLE eventi(
id NUMBER,
nome VARCHAR(50) NOT NULL,
data VARCHAR(20) NOT NULL,
luogo VARCHAR(40) NOT NULL,
costo NUMBER NULL,
quota NUMBER NULL,
CONSTRAINT chiave_eventi PRIMARY KEY(id));

CREATE SEQUENCE seq_per_eventi MINVALUE 1000 START WITH 1000 NOCACHE;

CREATE TABLE animatori(
id NUMBER,
nome VARCHAR(30) NOT NULL,
cognome VARCHAR(30) NOT NULL,
ruolo VARCHAR(30) NOT NULL,
datanascita VARCHAR(20) NULL,
luogonascita VARCHAR(40) NULL,
telefono VARCHAR(20) NULL,
via VARCHAR(40) NULL,
civico NUMBER NULL,
cap NUMBER NULL,
città VARCHAR(40) NULL,
CONSTRAINT chiave_animatori PRIMARY KEY(id));

CREATE SEQUENCE seq_per_animatori MINVALUE 2000 START WITH 2000 NOCACHE;
CREATE TABLE animati(
codicetessera NUMBER,
nome VARCHAR(30) NOT NULL,
cognome VARCHAR(30) NOT NULL,
datanascita VARCHAR(20) NULL,
luogonascita VARCHAR(40) NULL,
telefono VARCHAR(20) NULL,
via VARCHAR(40) NULL,
civico NUMBER NULL,
cap NUMBER NULL,
città VARCHAR(40) NULL,
gruppo NUMBER NOT NULL,
CONSTRAINT chiave_animati PRIMARY KEY(codicetessera));

CREATE SEQUENCE seq_per_animati MINVALUE 3000 START WITH 3000 NOCACHE;

CREATE TABLE gruppi(
id NUMBER,
nome VARCHAR(30) NOT NULL,
annata NUMBER NOT NULL,
sala VARCHAR(30) NOT NULL,
numerocomponenti NUMBER DEFAULT 0,
CONSTRAINT chiave_gruppi PRIMARY KEY(id),
CONSTRAINT ctrl_annata CHECK( annata>=1 AND annata<=5));

CREATE SEQUENCE seq_per_gruppi MINVALUE 4000 START WITH 4000 NOCACHE;

CREATE TABLE associazioni(
animato NUMBER,
evento NUMBER,
CONSTRAINT chiave_associazioni PRIMARY KEY(animato,evento));

CREATE TABLE organizzazioni(
animatore NUMBER,
evento NUMBER,
CONSTRAINT chiave_organizzazioni PRIMARY KEY(animatore,evento));


--==============================
--  VINCOLI DI CHIAVI ESTERNE
--==============================


ALTER TABLE animati ADD CONSTRAINT forkey_animati FOREIGN KEY(gruppo) REFERENCES gruppi(id) ON DELETE CASCADE;

ALTER TABLE associazioni ADD CONSTRAINT forkey_associazioni1 FOREIGN KEY(animato) REFERENCES animati(codicetessera) ON DELETE CASCADE ; 

ALTER TABLE associazioni ADD CONSTRAINT forkey_associazioni2 FOREIGN KEY(evento) REFERENCES eventi(id) ON DELETE CASCADE ; 

ALTER TABLE organizzazioni ADD CONSTRAINT forkey_organizzazioni1 FOREIGN KEY(animatore) REFERENCES animatori(id) ON DELETE CASCADE ; 

ALTER TABLE organizzazioni ADD CONSTRAINT forkey_organizzazioni2 FOREIGN KEY(evento) REFERENCES eventi(id) ON DELETE CASCADE ;


