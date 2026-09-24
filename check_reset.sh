#!/bin/bash

# NODE_ID="netics"
# NODE_ID="rog_01"
# NODE_ID="rog_02"
# NODE_ID="rog_03"
# NODE_ID="rog_04"
# NODE_ID="lab_220"
# NODE_ID="lab_s3"

# Lokasi file .env
FILE_ENV=".env"

# Muat nilai dari .env
if [ -f "$FILE_ENV" ]; then
    # Ekstrak nilai NODE_ID dari file
    NODE_ID=$(grep -E '^NODE_ID=' "$FILE_ENV" | sed 's/^NODE_ID=//' | tr -d '"' | tr -d "'")
else
    echo "ERROR: File $FILE_ENV tidak ditemukan!"
    exit 1
fi

# Pastikan NODE_ID tidak kosong
if [ -z "$NODE_ID" ]; then
    echo "ERROR: NODE_ID tidak ditemukan atau kosong di $FILE_ENV!"
    exit 1
fi

URL="https://kutuju.com/reset.php"
LOG_FILE="/var/log/status_reset_check.log"
CURL1="/home/disertasi/anaconda3/bin/curl"
CURL2="/usr/bin/curl"

# Fungsi untuk mencatat log
log_message() {
    local MESSAGE="$1"
    echo "[$(date "+%Y-%m-%d %H:%M:%S %Z")] $MESSAGE" | tee -a "$LOG_FILE"
}

# Cek curl — salah satu harus ada
if [ ! -x "$CURL1" ] && [ ! -x "$CURL2" ]; then
    log_message "ERROR: curl belum terpasang"
    exit 1
fi

# Pilih curl yang tersedia
if [ -x "$CURL1" ]; then
    CURL="$CURL1"
else
    CURL="$CURL2"
fi

# Ambil konten halaman
RESPONSE=$("$CURL" -s -f -m 10 "$URL")
if [ $? -ne 0 ]; then
    log_message "ERROR: Gagal mengakses $URL"
    exit 1
fi

# Cek kondisi
if echo "$RESPONSE" | grep -qE "${NODE_ID}[[:space:]]*=[[:space:]]*true"; then
    log_message "Nilai adalah TRUE. Server akan melakukan reset..."
    
    # Jalankan reboot, cek hasilnya
    if sudo reboot; then
        log_message "Reboot perintah dikirim ke sistem"
    else
        log_message "ERROR: Gagal melakukan reboot"
    fi
else
    log_message "Nilai adalah FALSE. Tidak ada reset yang dilakukan."
fi




