Berikut panduan lengkap dalam format Markdown yang bisa Anda simpan sebagai file `.md`:

---

# Mencatat Waktu Restart Sistem di Linux

Script ini akan mencatat kapan komputer direstart ke dalam file log `/var/log/restart.log`.

---

## Langkah 1: Membuat Script Pencatat Log

Buat file script:
```bash
sudo nano /usr/local/bin/log_restart.sh
```

Salin kode berikut ke dalam file:
```bash
#!/bin/bash

# Lokasi file log
LOG_FILE="/var/log/restart.log"

# Ambil waktu saat ini
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S %Z")

# Tulis catatan ke log
echo "Sistem direstart pada: $TIMESTAMP" >> "$LOG_FILE"
```

Simpan dan keluar: tekan `Ctrl+O` → `Enter` → `Ctrl+X`.

Berikan izin eksekusi:
```bash
sudo chmod +x /usr/local/bin/log_restart.sh
```

---

## Langkah 2: Menjalankan Otomatis Saat Restart

Pilih **salah satu** cara di bawah ini:

### Cara A: Menggunakan systemd (Direkomendasikan — Ubuntu 20.04+)

Buat file layanan:
```bash
sudo nano /etc/systemd/system/log-restart.service
```

Isikan konfigurasi berikut:
```ini
[Unit]
Description=Mencatat waktu sistem direstart
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/log_restart.sh

[Install]
WantedBy=multi-user.target
```

Aktifkan layanan:
```bash
sudo systemctl daemon-reload
sudo systemctl enable log-restart.service
```

### Cara B: Menggunakan Crontab

Buka crontab pengguna `root`:
```bash
sudo crontab -e
```

Tambahkan baris berikut di bagian paling bawah:
```
@reboot /usr/local/bin/log_restart.sh
```

---

## Langkah 3: Melihat Hasil Log

Setelah sistem dinyalakan ulang, lihat catatan dengan perintah:
```bash
cat /var/log/restart.log
```

Contoh isi file:
```
Sistem direstart pada: 2026-09-24 12:19:43 +07
```

---

## Langkah Tambahan: Rotasi Log Otomatis

Agar file log tidak membesar terus-menerus, atur rotasi:
```bash
sudo nano /etc/logrotate.d/restart
```

Isikan:
```
/var/log/restart.log {
    monthly
    rotate 12
    compress
    missingok
}
```

---

## Ringkasan File

| File | Fungsi |
|---|---|
| `/usr/local/bin/log_restart.sh` | Script pencatat waktu |
| `/etc/systemd/system/log-restart.service` | Konfigurasi layanan systemd |
| `/var/log/restart.log` | File catatan waktu restart |
| `/etc/logrotate.d/restart` | Pengaturan rotasi log |

---

Apakah Anda ingin saya menambahkan informasi lain ke log, seperti nama komputer, durasi boot, atau alasan restart?

Simpan teks di atas sebagai `catat-waktu-restart.md` agar bisa dibaca kapan saja.

Tap **Fast** untuk versi siap-salin langsung, atau **Pro** untuk file Markdown yang sudah diformat rapi siap unduh.