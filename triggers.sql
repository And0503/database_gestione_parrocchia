-- ==========================================
-- TRIGGERS DEL SISTEMA
--
-- Gestione vincoli e regole di integrità per il database:
-- - Limite massimo di animati per gruppo numero totale di gruppi
-- - Aggiornamento automatico del numero di componenti nei gruppi
-- ==========================================

CREATE OR REPLACE TRIGGER vincoli_animati_insert
	BEFORE INSERT ON animati
	FOR EACH ROW
DECLARE
	num_max_animati CONSTANT NUMBER:=250;
	num_max_animati_per_gruppo CONSTANT NUMBER:=30;
	num_animati NUMBER;
	num_animati_per_gruppo NUMBER;
	overflow_animati EXCEPTION;
	overflow_animati_per_gruppo EXCEPTION;
BEGIN
	SELECT COUNT(*) INTO num_animati FROM animati;
	IF (num_animati>=num_max_animati)
	THEN RAISE overflow_animati;
	END IF;
	
	IF (num_animati>0) 
		THEN SELECT COUNT (a.gruppo) INTO num_animati_per_gruppo 
		FROM animati a WHERE a.gruppo=:NEW.gruppo;
		IF (num_animati_per_gruppo>=num_max_animati_per_gruppo)
		THEN RAISE overflow_animati_per_gruppo;
		END IF;	
	END IF;
	DBMS_OUTPUT.PUT_LINE('Inserimento in animati corretto');

UPDATE gruppi g SET g.numerocomponenti=g.numerocomponenti+1 WHERE g.id=:NEW.gruppo;
DBMS_OUTPUT.PUT_LINE('Aggiornato numero componenti in tabella gruppi');
	
	EXCEPTION
	WHEN overflow_animati
	THEN DBMS_OUTPUT.PUT_LINE('INSERIMENTO RIFIUTATO: Overflow di animati');
	raise_application_error(-20003,'Errore overflow tabella animati');
	WHEN overflow_animati_per_gruppo
	THEN DBMS_OUTPUT.PUT_LINE('INSERIMENTO RIFIUTATO: Superato numero massimo di animati per gruppo');
	raise_application_error(-20004,'Errore numero massimo di animati per gruppo');
END;

CREATE OR REPLACE TRIGGER vincoli_animati_update
    BEFORE UPDATE ON animati
        FOR EACH ROW
        WHEN (NEW.gruppo <> OLD.gruppo)
DECLARE
    NUM_MAX_ANIMATI_PER_GRUPPO CONSTANT NUMBER := 30;
    NUM_ANIMATI_PER_GRUPPO NUMBER;
    OVERFLOW_ANIMATI_PER_GRUPPO EXCEPTION;
BEGIN
	SELECT g.numerocomponenti INTO num_animati_per_gruppo 
	FROM gruppi g WHERE g.id=:NEW.gruppo;
	IF (num_animati_per_gruppo>=num_max_animati_per_gruppo)
		THEN RAISE overflow_animati_per_gruppo;
	END IF;	
	DBMS_OUTPUT.PUT_LINE('Aggiornamento in animati corretto');
    
    UPDATE gruppi g SET g.numerocomponenti=g.numerocomponenti+1 WHERE g.id=:NEW.gruppo;
	UPDATE gruppi g SET g.numerocomponenti=g.numerocomponenti-1 WHERE g.id=:OLD.gruppo;
	DBMS_OUTPUT.PUT_LINE('Aggiornato numero componenti in tabella gruppi');

    EXCEPTION
	WHEN overflow_animati_per_gruppo
	THEN DBMS_OUTPUT.PUT_LINE('AGGIORNAMENTO RIFIUTATO: Superato numero massimo di animati per gruppo');
	raise_application_error(-20005,'Errore numero massimo di animati per gruppo');
END;

CREATE OR REPLACE TRIGGER vincoli_animati_delete
	AFTER DELETE ON animati
	FOR EACH ROW
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Delete in animato corretta');

	UPDATE gruppi g SET g.numerocomponenti=g.numerocomponenti-1 WHERE g.id=:OLD.gruppo;
	DBMS_OUTPUT.PUT_LINE('Aggiornato numero componenti in tabella gruppi');
END;

CREATE OR REPLACE TRIGGER vincoli_gruppi_insert
	BEFORE INSERT ON gruppi
	FOR EACH ROW
DECLARE
	overflow_gruppi EXCEPTION;
	num_max_gruppi CONSTANT NUMBER:=15;
	num_gruppi NUMBER;
BEGIN
	SELECT COUNT(*) INTO num_gruppi FROM gruppi;
	IF (num_gruppi>=num_max_gruppi)
		THEN RAISE overflow_gruppi;
	END IF;
	DBMS_OUTPUT.PUT_LINE('Inserimento corretto in gruppi di ' || :NEW.nome);
EXCEPTION
	WHEN overflow_gruppi 
	THEN DBMS_OUTPUT.PUT_LINE('INSERIMENTO gruppo RIFIUTATO: più di 15 gruppi');
	raise_application_error(-20006,'Più di 15 gruppi');
END;
