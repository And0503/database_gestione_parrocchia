# database_gestione_parrocchia

## Descrizione del progetto
Sistema di gestione di eventi parrocchiali sviluppato in PL/SQL per Oracle Database, con modellazione relazionale, vincoli di integrità, trigger e package procedurali per la gestione di animatori e partecipanti.  Include funzionalità di reportistica su affluenza e spese degli eventi.

## SCHEMA

#EVENTO
  Definizione: Attività organizzata dagli animatori per gli animati
  Proprietà:
    -Nome
    -Data 
    -Luogo
    -Costo (spesa per organizzare l’evento)

#ANIMATORE
  Definizione: Colui che organizza gli eventi
  Proprietà: 
    -Codice fiscale
    -Nome
    -Cognome
    -Ruolo
    -Data di nascita
    -Luogo di nascita
    -Indirizzo

#ANIMATO
  Definizione: Colui che partecipa agli eventi.
  Proprietà: 
    -Codice tessera
    -Nome
    -Cognome
    -Data di nascita
    -Luogo di nascita
    -Telefono
    -Indirizzo

  #GRUPPO
    Definizione: Insieme di animati derivante da una suddivisione organizzativa.
    Proprietà: 
      -Nome
      -Annata
      -Numero componenti
      -Sala


    
