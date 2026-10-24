#!/bin/bash

# Lokasi file log
LOG_FILE="/var/log/restart.log"

# Ambil waktu saat ini
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S %Z")

# Tulis catatan ke log
echo "Sistem direstart pada: $TIMESTAMP" >> "$LOG_FILE"
