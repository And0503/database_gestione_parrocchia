-- ==========================================
-- PACKAGE: pk_gestione_centro_app
-- Sistema applicativo per la gestione di eventi parrocchiali
--
-- Include funzionalità per:
-- - Inserimento di eventi, animatori, animati e gruppi
-- - Associazione tra partecipanti ed eventi
-- - Report di spese, entrate e bilancio
-- - Analisi di affluenza e partecipazione
--
-- ==========================================


CREATE OR REPLACE PACKAGE pk_gestione_centro_app
IS
PROCEDURE inserisci_evento(nome_evento IN varchar,data_evento IN varchar,luogo_evento IN varchar,costo_evento IN number,quota_evento IN number,nome_animatore IN varchar,cognome_animatore IN varchar);
/* Inserisci un evento e l'animatore che lo propone nella tabella organizzazioni */	

PROCEDURE inserisci_animato(nome_animato IN varchar,cognome_animato IN varchar,data_animato IN varchar,luogo_animato IN varchar,telefono_animato IN varchar,via_animato IN varchar,civico_animato IN number,cap_animato IN number,citta_animato IN varchar,gruppo_animato IN varchar);
/* Inserisci un animato specificando il nome del gruppo invece del codice id */

PROCEDURE inserisci_gruppo(nomegruppo IN varchar, annatagruppo IN NUMBER, salagruppo IN varchar);
	/* Inserisci gruppo fissando numerocomponenti uguale a 0 */	
	
	PROCEDURE aggiungi_animatore_evento(nome_evento IN varchar,nome_animatore IN varchar,cognome_animatore IN varchar);
	--Aggiungi ad un evento già inserito un altro animatore che lo organizza 

PROCEDURE aggiungi_animato_evento(nome_evento IN varchar,nome_animato IN varchar,cognome_animato IN varchar);
	--Aggiungi ad un evento già inserito un animato che ci partecipa

FUNCTION report_spese_eventi(da_data IN varchar,a_data IN varchar) RETURN NUMBER;
--Calcola la spesa per organizzare gli eventi da “da_data” a “a_data”

FUNCTION report_guadagni_eventi(da_data IN varchar,a_data IN varchar) RETURN NUMBER;
----Calcola le entrate ricavate dagli eventi da “da_data” a “a_data”
	PROCEDURE report_bilancio_eventi(da_data IN varchar,a_data IN varchar);
	----Calcola il bilancio relativo agli eventi da “da_data” a “a_data”
	PROCEDURE affluenza_max_evento;
	--Determina l’evento con maggiore affluenza
	PROCEDURE animato_max_partecipazione;
	--Determina l’animato che ha partecipato a più eventi
	PROCEDURE animatore_max_organizzazione;
	--Determina l’animatore che ha organizzato più eventi

END pk_gestione_centro_app;

CREATE OR REPLACE PACKAGE BODY pk_gestione_centro_app
IS

PROCEDURE inserisci_evento(nome_evento IN varchar,data_evento IN varchar,luogo_evento IN varchar,costo_evento IN number,quota_evento IN number,nome_animatore IN varchar,cognome_animatore IN varchar)
IS
	fk_animatore NUMBER;
BEGIN
	SELECT a.id INTO fk_animatore FROM animatori a
	WHERE(a.nome=nome_animatore AND a.cognome=cognome_animatore);
	INSERT INTO eventi VALUES (seq_per_eventi.NEXTVAL,nome_evento,data_evento,luogo_evento,costo_evento,quota_evento);
	INSERT INTO organizzazioni VALUES (fk_animatore,seq_per_eventi.CURRVAL);
END;
PROCEDURE inserisci_animato(nome_animato IN varchar,cognome_animato IN varchar,data_animato IN varchar,luogo_animato IN varchar,telefono_animato IN varchar,via_animato IN varchar,civico_animato IN number,cap_animato IN number,citta_animato IN varchar,gruppo_animato IN varchar)
IS
	fk_gruppo NUMBER;
BEGIN
	SELECT g.id INTO fk_gruppo FROM gruppi g
	WHERE(g.nome=UPPER(gruppo_animato));
	INSERT INTO animati VALUES(seq_per_animati.NEXTVAL,nome_animato,cognome_animato,data_animato,luogo_animato,telefono_animato,via_animato,civico_animato,cap_animato,citta_animato,fk_gruppo);
END;

PROCEDURE aggiungi_animatore_evento(nome_evento IN varchar,nome_animatore IN varchar,cognome_animatore IN varchar)
IS
	fk_animatore NUMBER;
	fk_evento NUMBER;
BEGIN
	SELECT a.id INTO fk_animatore FROM animatori a
	WHERE(a.nome=nome_animatore AND a.cognome=cognome_animatore);

	SELECT e.id INTO fk_evento FROM eventi e
	WHERE(e.nome=UPPER(nome_evento));

	INSERT INTO organizzazioni VALUES (fk_animatore,fk_evento);
END;

PROCEDURE aggiungi_animato_evento(nome_evento IN varchar,nome_animato IN varchar,cognome_animato IN varchar)
IS
	fk_animato NUMBER;
	fk_evento NUMBER;
BEGIN
	SELECT a.codicetessera INTO fk_animato FROM animati a
	WHERE(a.nome=nome_animato AND a.cognome=cognome_animato);

	SELECT e.id INTO fk_evento FROM eventi e
	WHERE(e.nome=UPPER(nome_evento));

	INSERT INTO associazioni VALUES (fk_animato,fk_evento);
END;

FUNCTION converti(datastringa IN VARCHAR) RETURN DATE
is
   data DATE;
BEGIN
   data := to_date(datastringa,'yyyy-mm-dd hh24:mi:ss'); 
   RETURN data;
END;

PROCEDURE controlla_date(da_data IN VARCHAR, a_data IN VARCHAR)
IS
    data_inizio DATE;
    data_fine DATE;
    cont_eventi NUMBER;
    intervallo_errato EXCEPTION;
    noncisono_eventi EXCEPTION;

BEGIN
    IF  (converti(da_data)>=converti(a_data))
        THEN RAISE intervallo_errato;
    END IF; 

    data_inizio := converti(da_data);
    data_fine := converti(a_data);

    SELECT COUNT(*) INTO cont_eventi
           FROM eventi e
           WHERE to_date(e.data,'yyyy-mm-dd hh24:mi:ss') BETWEEN data_inizio AND data_fine;
    IF (cont_eventi = 0)
        THEN RAISE noncisono_eventi;
    END IF;                    

EXCEPTION
    WHEN intervallo_errato 
         THEN DBMS_OUTPUT.PUT_LINE('Intervallo date errato');
              raise_application_error(-20001,'Errore inserimento date'); 
    WHEN noncisono_eventi 
         THEN DBMS_OUTPUT.PUT_LINE('Nell''intervallo non esistono eventi');
              raise_application_error(-20002,'Intervallo dato non contiene eventi'); 
END;

FUNCTION report_spese_eventi(da_data IN varchar,a_data IN varchar) RETURN NUMBER
IS 
	spesa_totale NUMBER;
	data_inizio DATE;
	data_fine DATE;
BEGIN
	controlla_date(da_data,a_data);
	data_inizio:=converti(da_data);
	data_fine:=converti(a_data);

	SELECT SUM(e.costo) INTO spesa_totale FROM eventi e
	WHERE(to_date(e.data,'yyyy-mm-dd hh24:mi:ss') BETWEEN data_inizio AND data_fine);
	DBMS_OUTPUT.PUT_LINE('Dal ' || da_data || ' a ' || a_data || ' la spesa totale è pari a ' || spesa_totale);
	RETURN spesa_totale;
END;

FUNCTION report_guadagni_eventi(da_data IN varchar,a_data IN varchar) RETURN NUMBER
IS
	guadagno_totale NUMBER;
	data_inizio DATE;
	data_fine DATE;	
BEGIN
	controlla_date(da_data,a_data);
	data_inizio:=converti(da_data);
	data_fine:=converti(a_data);

	SELECT SUM(e.quota) INTO guadagno_totale FROM eventi e JOIN associazioni a ON e.id=a.evento
	WHERE(to_date(e.data,'yyyy-mm-dd hh24:mi:ss') BETWEEN data_inizio AND data_fine);
	DBMS_OUTPUT.PUT_LINE('Dal ' || da_data || ' a ' || a_data || ' il guadagno totale è pari a ' || guadagno_totale);
	RETURN guadagno_totale;
END;

PROCEDURE report_bilancio_eventi(da_data IN varchar,a_data IN varchar)
IS
	spesa NUMBER;
	guadagno NUMBER;
	bilancio NUMBER;
BEGIN
	spesa:=report_spese_eventi(da_data,a_data);
	guadagno:=report_guadagni_eventi(da_data,a_data);
	bilancio:=guadagno-spesa;
	DBMS_OUTPUT.PUT_LINE('Dal ' || da_data || ' a ' || a_data || ' il bilancio è pari a ' || bilancio);
END;

PROCEDURE inserisci_gruppo(nomegruppo IN varchar, annatagruppo IN NUMBER, salagruppo IN varchar)
IS 
BEGIN
  INSERT INTO gruppi VALUES(seq_per_gruppi.NEXTVAL,nomegruppo,annatagruppo,salagruppo,0);
END;

PROCEDURE affluenza_max_evento
IS
    CURSOR cursore IS
        SELECT e.id, e.nome, COUNT(a.animato) AS affluenza
        FROM eventi e JOIN associazioni a ON e.id=a.evento
        GROUP BY e.id, e.nome
        HAVING COUNT (a.animato)>=ALL(
            SELECT COUNT(a1.animato) FROM associazioni a1
            GROUP BY a1.evento);
    record cursore%ROWTYPE;
BEGIN
    OPEN cursore;
	DBMS_OUTPUT.PUT_LINE('Evento con la massima affluenza');
    LOOP
	FETCH cursore INTO record;
	EXIT WHEN cursore%NOTFOUND;
	DBMS_OUTPUT.PUT_LINE(' ID '	|| record.id ||
				' NOME ' || record.nome ||
				' AFFLUENZA ' || record.affluenza);
	END LOOP;
	CLOSE cursore;

END;

PROCEDURE animato_max_partecipazione
IS
    CURSOR cursore IS
        SELECT an.codicetessera, an.nome, an.cognome, COUNT(ass.evento) AS partecipazioni
        FROM animati an JOIN associazioni ass ON an.codicetessera=ass.animato
        GROUP BY an.codicetessera, an.nome, an.cognome
        HAVING COUNT (ass.evento)>=ALL(
            SELECT COUNT(ass1.evento) FROM associazioni ass1
            GROUP BY ass1.evento);
        record cursore%ROWTYPE;
BEGIN
    OPEN cursore;
	DBMS_OUTPUT.PUT_LINE('Animato che ha partecipato a più eventi');
    LOOP
	FETCH cursore INTO record;
	EXIT WHEN cursore%NOTFOUND;
	DBMS_OUTPUT.PUT_LINE(' CODICE TESSERA '	|| record.codicetessera ||
				' NOME ' || record.nome ||
				' COGNOME ' || record.cognome ||
                ' PARTECIPAZIONI ' || record.partecipazioni);
	END LOOP;
	CLOSE cursore;
END;

PROCEDURE animatore_max_organizzazione
IS
    CURSOR cursore IS 
        SELECT a.id,a.nome, a.cognome, COUNT(o.evento) AS organizzazioni
        FROM animatori a JOIN organizzazioni o ON a.id=o.animatore
        GROUP BY a.id,a.nome, a.cognome
        HAVING COUNT (o.evento)>=ALL(
            SELECT COUNT(o1.evento) FROM organizzazioni o1
            GROUP BY o1.evento);
    record cursore%ROWTYPE;
BEGIN
	OPEN cursore;
	DBMS_OUTPUT.PUT_LINE('Animatore che ha organizzato più eventi');
    LOOP
	FETCH cursore INTO record;
	EXIT WHEN cursore%NOTFOUND;
	DBMS_OUTPUT.PUT_LINE(' NOME '	|| record.nome ||
				' COGNOME ' || record.cognome ||
				' ORGANIZZAZIONI ' || record.organizzazioni);
	END LOOP;
	CLOSE cursore;
END;

END pk_gestione_centro_app;
