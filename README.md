# Database_gestione_parrocchia

## Descrizione del progetto
Sistema di gestione di eventi parrocchiali sviluppato in PL/SQL per Oracle Database, con modellazione relazionale, vincoli di integrità, trigger e package procedurali.

Include funzionalità di reportistica su affluenza e spese degli eventi.

---

## 📌 Schema

### 🧱 Entità del sistema

---

#### 🔹 Evento
Definizione: attività organizzata dagli animatori per gli animati.

**Proprietà**
- Nome
- Data
- Luogo
- Costo

---

#### 🔹 Animatore
Definizione: colui che organizza gli eventi.

**Proprietà**
- Codice fiscale
- Nome
- Cognome
- Ruolo
- Data di nascita
- Luogo di nascita
- Indirizzo

---

#### 🔹 Animato
Definizione: partecipante agli eventi.

**Proprietà**
- Codice tessera
- Nome
- Cognome
- Data di nascita
- Telefono
- Indirizzo

---

#### 🔹 Gruppo
Definizione: insieme organizzativo di animati.

**Proprietà**
- Nome
- Annata
- Numero componenti
- Sala
