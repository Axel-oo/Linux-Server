#!/bin/bash
# Indica che questo script deve essere eseguito usando bash

# Configurazione
USER_HOME="/home/$USER"           # Percorso della home directory dell'utente attuale
BACKUP_DIR="/opt/backup"          # Directory dove verranno salvati i backup
DATE=$(date +%Y-%m-%d)            # Data attuale in formato YYYY-MM-DD (es. 2025-05-19)

DEST="$BACKUP_DIR/backup-$DATE.tar.gz"   # Nome completo del file di backup
LOG_FILE="$BACKUP_DIR/backup.log"        # File di log per tracciare le operazioni

# Crea la cartella di backup se non esiste
mkdir -p "$BACKUP_DIR"            # Crea la directory /opt/backup se non esiste già

# Crea l'archivio compresso della home directory
tar -czf "$DEST" "$USER_HOME" 2>> "$LOG_FILE"
# tar -czf = crea un archivio compresso .tar.gz
# "$DEST" è il nome del file di backup che verrà creato
# "$USER_HOME" è la directory da comprimere (la home dell'utente)
# 2>> "$LOG_FILE" serve a scrivere eventuali errori nel file di log

# Rimuove i backup più vecchi di 6 giorni (così ne restano sempre massimo 7)
find "$BACKUP_DIR" -name "backup-*.tar.gz" -mtime +6 -exec rm {} \;
# find = cerca tutti i file nel backup con nome backup-*.tar.gz
# -mtime +6 = modificati più di 6 giorni fa
# -exec rm {} \; = esegue rm (rimozione) per ciascun file trovato

# Scrive nel log che il backup è stato completato
echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup completato: $DEST" >> "$LOG_FILE"
# Scrive la data e l'ora attuale, più il nome del backup creato, nel file di log
