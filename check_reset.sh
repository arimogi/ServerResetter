#!/bin/bash

NODE_ID="lab_s3"
URL="https://kutuju.com/reset.php"

if ! command -v curl &> /dev/null; then
    echo "Error: curl belum terpasang"
    exit 1
fi

RESPONSE=$(curl -s -f -m 10 "$URL")
if [ $? -ne 0 ]; then
    echo "Error: Gagal mengakses $URL"
    exit 1
fi

# Pola lebih fleksibel: mengabaikan spasi di sekitar tanda =
if echo "$RESPONSE" | grep -qE "${NODE_ID}[[:space:]]*=[[:space:]]*true"; then
    echo "TRUE"
fi
