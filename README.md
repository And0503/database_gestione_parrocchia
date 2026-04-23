# Database_gestione_parrocchia

## Descrizione del progetto
Sistema di gestione di eventi parrocchiali sviluppato in PL/SQL per Oracle Database, con modellazione relazionale, vincoli di integrità, trigger e package procedurali.

Include funzionalità di reportistica su affluenza e spese degli eventi.

---

## 📌 ENTITÀ

---

#### 🔹 Evento
Definizione: attività organizzata dagli animatori per gli animati.

**Proprietà**
- Nome
- Data
- Luogo
- Costo
- Quota
---

#### 🔹 Animatore
Definizione: colui che organizza gli eventi.

**Proprietà**
- Nome
- Cognome
- Ruolo
- Data di nascita
- Luogo di nascita
- Telefono  
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

---

## 📌 Schema scheletro

<img width="567" height="532" alt="raffinamento" src="https://github.com/user-attachments/assets/efa57907-01b8-4f87-8f4c-29fa4da27373" />

---

---

## 📌 Modello Entità-Relazione

<img width="719" height="720" alt="modello ER" src="https://github.com/user-attachments/assets/a1f68815-70ea-41fa-9520-590c5c8e8b1a" />

---

---

## 📌 Traduzione nel modello logico
- L’associazione «Appartenenza», essendo di tipo uno a molti, si traduce inserendo nella relazione «Animati» l’identificatore dell’entità «Gruppo» come attributo.
- L’associazione «Associazione», essendo di tipo molti a molti, si traduce in una relazione «Associazioni» avente come attributi gli identificatori delle due entità «Animato» ed «Evento». L’insieme di tali identificatori costituisce la chiave primaria della relazione.
- L’associazione «Organizzazione», essendo di tipo molti a molti, si traduce in una relazione «Organizzazioni» avente come attributi gli identificatori delle due entità «Animatore» ed «Evento». L’insieme di tali identificatori costituisce la chiave primaria della relazione.
- Risoluzione dell’attributo composto «Indirizzo» delle entità «Animato» e «Animatore» negli attributi «Via», «Civico», «CAP» e «Città» inseriti nelle rispettive relazioni.

---

---

## 📌 Modello logico
- **ANIMATI**(Codice tessera, Nome, Cognome, Data di nascita, Luogo di nascita, Telefono, Via, Civico, CAP, Città, Gruppo:GRUPPI)
- **ANIMATORI**(Id, Ruolo, Nome, Cognome, Data di nascita, Luogo di nascita, Telefono, Via, Civico, CAP, Città)
- **GRUPPI**(Id, Nome, Annata, Numero Componenti, Sala)
- **EVENTI**(Id, Nome, Data, Luogo, Costo, Quota)
- **ASSOCIAZIONI**(Animato:ANIMATI, Evento:EVENTI)
- **ORGANIZZAZIONI**(Animatore:ANIMATORI, Evento:EVENTI)

---

---

## 📌 Schema della base dati

<img width="1478" height="853" alt="schema base di dati" src="https://github.com/user-attachments/assets/57fe6d27-9f6e-417a-adf3-713e0df7f933" />

---

---

## 📌 Vincoli

| codice    | descrizione                                             |
|-----------|---------------------------------------------------------|
| v1        | un animatore può organizzare uno o più eventi           |
| v2        | un evento può essere organizzato da uno o più animatori |
| v3        | un animato può partecipare ad uno o più eventi          |
| v4        | ad un evento possono partecipare uno o più animati      |
| v5        | un animato appartiene ad uno ed un solo gruppo          |
| v6        | ad un gruppo appartengono uno o più animati             |

---

---

## 📌 Dimensionamento

| Entità    | Numero massimo occorrenze |
|-----------|----------------------------|
| Animatori | 30                         |
| Animati   | max 250                    |
| Gruppi    | 15                         |

---

---

## 📌 Vincoli di integrità referenziale

| Tra       | Di             | E              | Di        |
|-----------|----------------|----------------|-----------|
| gruppo    | animati        | id             | gruppi    |
| animato   | associazioni   | codice tessera | animati   |
| evento    | associazioni   | id             | eventi    |
| animatore | organizzazioni | id             | animatori |      
| evento    | organizzazioni | id             | eventi    |

---
