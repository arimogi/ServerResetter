#!/bin/bash

# NODE_ID="netics"
# NODE_ID="rog_01"
# NODE_ID="rog_02"
# NODE_ID="rog_03"
# NODE_ID="rog_04"
# NODE_ID="lab_220"
NODE_ID="lab_s3"
URL="https://kutuju.com/reset.php"
LOG_FILE="/var/log/status_reset_check.log"

# Fungsi untuk mencatat log
log_message() {
    local MESSAGE="$1"
    echo "[$(date "+%Y-%m-%d %H:%M:%S %Z")] $MESSAGE" | tee -a "$LOG_FILE"
}

# Cek curl
if ! command -v curl &> /dev/null; then
    log_message "ERROR: curl belum terpasang"
    exit 1
fi

# Ambil konten halaman
RESPONSE=$(curl -s -f -m 10 "$URL")
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




