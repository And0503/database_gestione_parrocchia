-- ==========================================
-- PACKAGE: pk_gestione_centro
-- Inizializzazione con dati di esempio
-- Procedure per report animatori e animati
-- ==========================================

CREATE OR REPLACE PACKAGE pk_gestione_centro
IS
    PROCEDURE inserisci_valori_iniziali;
    
    PROCEDURE report_animati;
    
    PROCEDURE report_animatori;
    
END pk_gestione_centro;

CREATE OR REPLACE PACKAGE BODY pk_gestione_centro
IS

PROCEDURE valori_iniziali_eventi
IS
	CURSOR cursore IS SELECT* FROM eventi;
	record cursore%ROWTYPE;
	conta number:=0;
BEGIN
	INSERT INTO eventi VALUES(seq_per_eventi.NEXTVAL,'FESTA DI HALLOWEEN','2022-10-31 18:30:00','CENTRO PARROCCHIALE',200,10);
	INSERT INTO eventi VALUES(seq_per_eventi.NEXTVAL,'COLAZIONE DI NATALE','2022-12-23 09:30:00','CENTRO PARROCCHIALE',40,2);
	INSERT INTO eventi VALUES(seq_per_eventi.NEXTVAL,'PARTITA DI CALCIO','2022-12-09 10:30:00','CAMPETTO',0,10);
	INSERT INTO eventi VALUES(seq_per_eventi.NEXTVAL,'GIOCO CON ACG','2022-07-23 18:00:00','CENTRO PARROCCHIALE',0,0);
	INSERT INTO eventi VALUES(seq_per_eventi.NEXTVAL,'FILM','2022-11-23 19:00:00','CINEMA',0,8);

	OPEN cursore;
	DBMS_OUTPUT.PUT_LINE('Tabella EVENTI');
	LOOP
		conta:= conta+1;
		FETCH cursore INTO record;
		EXIT WHEN cursore%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(' Record n. ' || conta ||
				     ' ID '	|| record.id ||
				     ' nome '	|| record.nome ||
				     ' data '	|| record.data ||
				     ' luogo '	|| record.luogo ||
				     ' costo '	|| record.costo ||
				      ' quota '	|| record.quota);
	END LOOP;
	CLOSE cursore;
END;

PROCEDURE valori_iniziali_animatori
IS
	CURSOR cursore IS SELECT* FROM animatori;
	record cursore%ROWTYPE;
	conta number:=0;
BEGIN
	INSERT INTO animatori VALUES(seq_per_animatori.NEXTVAL,'NOME1','COGNOME1','ORDINARIO','2001-03-04','CITTA NASCITA 1','0000000000','VIA ESEMPIO',1,00001,'CITTA 1');
	INSERT INTO animatori VALUES(seq_per_animatori.NEXTVAL,'NOME2','COGNOME2','RESPONSABILE ACR','2000-12-04','CITTA NASCITA 1','1111111111','PIAZZA ESEMPIO',2,00001,'CITTA 1');
	INSERT INTO animatori VALUES(seq_per_animatori.NEXTVAL,'NOME3','COGNOME3','TESORIERE','2000-07-06','CITTA NASCITA 2','2222222222','TRAVERSA ESEMPIO',3,00002,'CITTA 2');
	INSERT INTO animatori VALUES(seq_per_animatori.NEXTVAL,'NOME4','COGNOME4','RESPONSABILE ATTIVITA SPORTIVE','2001-09-17','CITTA NASCITA 3','3333333333','VIA ESEMPIO',4,00003,'CITTA 3');
	INSERT INTO animatori VALUES(seq_per_animatori.NEXTVAL,'NOME5','COGNOME5','SOCIAL MEDIA MANAGER','2002-02-14','CITTA NASCITA 1','4444444444','PIAZZA ESEMPIO',5,00001,'CITTA 1');
	OPEN cursore;
	DBMS_OUTPUT.PUT_LINE('Tabella ANIMATORI');
	LOOP
		conta:= conta+1;
		FETCH cursore INTO record;
		EXIT WHEN cursore%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(' Record n. ' || conta ||
				     ' ID '	|| record.id ||
				     ' nome '	|| record.nome ||
				     ' cognome '	|| record.cognome ||
				     ' ruolo '	|| record.ruolo ||
				     ' data di nascita '	|| record.datanascita ||
				      ' luogo di nascita '	|| record.luogonascita ||
					' telefono '	|| record.telefono ||
					' Via '		|| record.via	||
					' Civico '	|| record.civico ||
					' CAP '		|| record.cap	||
					' Città '		|| record.città);
	END LOOP;
	CLOSE cursore;
END;
PROCEDURE valori_iniziali_animati
IS
	CURSOR cursore IS SELECT* FROM animati;
	record cursore%ROWTYPE;
	conta number:=0;
BEGIN
	INSERT INTO animati VALUES(seq_per_animati.NEXTVAL,'NOME6','COGNOME6','2013-03-05','CITTA NASCITA 6','0000000001','VIA ESEMPIO',6,00001,'CITTA1',4004);
	INSERT INTO animati VALUES(seq_per_animati.NEXTVAL,'NOME7','COGNOME7','2012-12-04','CITTA NASCITA 6','1111111112','PIAZZA ESEMPIO',7,00001,'CITTA1',4005);
	INSERT INTO animati VALUES(seq_per_animati.NEXTVAL,'NOME8','COGNOME8','2011-07-06','CITTA NASCITA 8','2222222223','VIA ESEMPIO',8,00002,'CITTA2',4001);
	INSERT INTO animati VALUES(seq_per_animati.NEXTVAL,'NOME9','COGNOME9','2010-09-16','CITTA NASCITA 7','3333333334','TRAVERSA ESEMPIO',9,00002,'CITTA2',4002);
	INSERT INTO animati VALUES(seq_per_animati.NEXTVAL,'NOME10','COGNOME10','2009-02-14','CITTA NASCITA 6','4444444445','VIA ESEMPIO',10,00003,'CITTA3',4003);

	OPEN cursore;
	DBMS_OUTPUT.PUT_LINE('Tabella ANIMATI');
	LOOP
		conta:= conta+1;
		FETCH cursore INTO record;
		EXIT WHEN cursore%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(' Record n. ' || conta ||
				     ' Codice tessera '	|| record.codicetessera ||
				     ' nome '	|| record.nome ||
				     ' cognome '	|| record.cognome ||
				     ' data di nascita '	|| record.datanascita ||
				      ' luogo di nascita '	|| record.luogonascita ||
					' telefono '	|| record.telefono ||
					' Via '		|| record.via	||
					' Civico '	|| record.civico ||
					' CAP '		|| record.cap	||
					' Città '		|| record.città ||
					' gruppo '	|| record.gruppo);
	END LOOP;
	CLOSE cursore;
END;

PROCEDURE valori_iniziali_associazioni
IS
	CURSOR cursore IS SELECT* FROM associazioni;
	record cursore%ROWTYPE;
	conta number:=0;
BEGIN
	INSERT INTO associazioni VALUES(3001,1001);
	INSERT INTO associazioni VALUES(3002,1002);
	INSERT INTO associazioni VALUES(3003,1002);
	INSERT INTO associazioni VALUES(3003,1004);
	INSERT INTO associazioni VALUES(3005,1004);
	OPEN cursore;
	DBMS_OUTPUT.PUT_LINE('Tabella ASSOCIAZIONI');
	LOOP
		conta:= conta+1;
		FETCH cursore INTO record;
		EXIT WHEN cursore%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(' Record n. ' || conta ||
				     ' Animato '	|| record.animato ||
				     ' Evento '	|| record.evento);
	END LOOP;
	CLOSE cursore;
END;

PROCEDURE valori_iniziali_organizzazioni
IS
	CURSOR cursore IS SELECT* FROM organizzazioni;
	record cursore%ROWTYPE;
	conta number:=0;
BEGIN
	INSERT INTO organizzazioni VALUES(2001,1001);
	INSERT INTO organizzazioni VALUES(2002,1002);
	INSERT INTO organizzazioni VALUES(2003,1003);
	INSERT INTO organizzazioni VALUES(2003,1004);
	INSERT INTO organizzazioni VALUES(2004,1004);
	OPEN cursore;
	DBMS_OUTPUT.PUT_LINE('Tabella ORGANIZZAZIONI');
	LOOP
		conta:= conta+1;
		FETCH cursore INTO record;
		EXIT WHEN cursore%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(' Record n. ' || conta ||
				     ' Animatore ' || record.animatore ||
				     ' Evento '	|| record.evento);
	END LOOP;
	CLOSE cursore;
END;
	
PROCEDURE valori_iniziali_gruppi
IS
	CURSOR cursore IS SELECT* FROM gruppi;
	record cursore%ROWTYPE;
	conta number:=0;
BEGIN
	INSERT INTO gruppi VALUES(seq_per_gruppi.NEXTVAL,'GRUPPO 1',1,'SALA 1',0);
	INSERT INTO gruppi VALUES(seq_per_gruppi.NEXTVAL,'GRUPPO 2',2,'SALA 2',0);
	INSERT INTO gruppi VALUES(seq_per_gruppi.NEXTVAL,'GRUPPO 3',3,'SALA 3',0);
	INSERT INTO gruppi VALUES(seq_per_gruppi.NEXTVAL,'GRUPPO 4',4,'SALA 4',0);
	INSERT INTO gruppi VALUES(seq_per_gruppi.NEXTVAL,'GRUPPO 5',5,'SALA 5',0);

	OPEN cursore;
	DBMS_OUTPUT.PUT_LINE('Tabella GRUPPI');
	LOOP
		conta:= conta+1;
		FETCH cursore INTO record;
		EXIT WHEN cursore%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(' Record n. ' || conta ||
				     ' ID '	|| record.id ||
                    ' nome '	|| record.nome ||
				     ' annata '	|| record.annata ||
				     ' sala '	|| record.sala ||
				     ' numerocomponenti '	|| record.numerocomponenti);
	END LOOP;
	CLOSE cursore;
END;
	
PROCEDURE inserisci_valori_iniziali
IS
BEGIN
	valori_iniziali_eventi;
	valori_iniziali_gruppi;
	valori_iniziali_animatori;
	valori_iniziali_animati;
	valori_iniziali_associazioni;
	valori_iniziali_organizzazioni;
END;

PROCEDURE report_animati
IS
	CURSOR cursore IS
		SELECT a.codicetessera as CODICE,a.nome as NOME,a.cognome as COGNOME,g.nome as GRUPPO,g.annata as ANNATA
		FROM animati a,gruppi g
		WHERE (a.gruppo=g.id)
		ORDER BY a.cognome,a.nome;
	record cursore%ROWTYPE;
BEGIN
	OPEN cursore;
	DBMS_OUTPUT.PUT_LINE('Report animati');
	LOOP
	FETCH cursore INTO record;
	EXIT WHEN cursore%NOTFOUND;
	DBMS_OUTPUT.PUT_LINE(' CODICE '	|| record.codice ||
				' NOME '	|| record.nome ||
				' COGNOME ' || record.cognome ||
				' GRUPPO ' || record.gruppo ||
				' ANNATA ' || record.annata);
	END LOOP;
	CLOSE cursore;
END;

PROCEDURE report_animatori
IS
	CURSOR cursore IS
		SELECT a.id as ID,a.nome as NOME,a.cognome as COGNOME,a.ruolo as RUOLO
		FROM animatori a
		ORDER BY a.id;
	record cursore%ROWTYPE;
BEGIN
	OPEN cursore;
	DBMS_OUTPUT.PUT_LINE('Report animatori');
	LOOP
	FETCH cursore INTO record;
	EXIT WHEN cursore%NOTFOUND;
	DBMS_OUTPUT.PUT_LINE(	' ID '	|| record.id ||
				' NOME '	|| record.nome ||
				' COGNOME ' || record.cognome ||
				' RUOLO ' || record.ruolo);
	END LOOP;
	CLOSE cursore;
END;

END pk_gestione_centro;
