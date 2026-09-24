Berikut file konfigurasi rotasi log yang siap salin dan gunakan:

---

## Langkah 1 — Buat File Konfigurasi
Buat file:
```bash
sudo nano /etc/logrotate.d/status_reset_check
```

Salin isi di bawah ini:
```
/var/log/status_reset_check.log {
    daily
    rotate 30
    compress
    delaycompress
    missingok
    notifempty
    create 0644 root root
    su root root
}
```

Simpan & keluar: `Ctrl+O` → `Enter` → `Ctrl+X`

---

## Penjelasan Setiap Pengaturan
| Pengaturan | Keterangan |
|---|---|
| `daily` | Rotasi dilakukan setiap hari |
| `rotate 30` | Menyimpan log lama selama 30 hari sebelum dihapus |
| `compress` | Log lama dikompres (hemat ruang disk) |
| `delaycompress` | Kompres ditunda hari berikutnya agar log kemarin masih mudah dibaca |
| `missingok` | Jika file log belum ada, tidak dianggap error |
| `notifempty` | Tidak membuat file kosong jika tidak ada isi baru |
| `create 0644 root root` | Log baru dibuat dengan izin dan pemilik yang benar |
| `su root root` | Proses rotasi berjalan sebagai root — cocok untuk crontab/sudo |

---

## Langkah 2 — Verifikasi Konfigurasi
Cek apakah format benar:
```bash
sudo logrotate -d /etc/logrotate.d/status_reset_check
```
- `-d` = mode uji coba (tanpa mengubah apa pun)
- Jika tidak muncul pesan error → konfigurasi benar

---

## Langkah 3 — Uji Coba Jalankan Sekarang
```bash
sudo logrotate -f /etc/logrotate.d/status_reset_check
```
- `-f` = paksa rotasi meskipun belum waktunya
- Cek hasilnya:
```bash
ls -l /var/log/status_reset_check.log*
```
Akan terlihat file baru dan file lama yang sudah dikompres.

---

## Catatan Tambahan
- Logrotate berjalan otomatis lewat sistem — tidak perlu menambah ke crontab
- Jika ingin jangka waktu lain, ganti `daily` dengan:
  - `weekly` → setiap minggu
  - `monthly` → setiap bulan
- Ubah angka `rotate 30` sesuai kebutuhan berapa lama log disimpan

Apakah ingin saya sesuaikan jangka waktu penyimpanan atau format log-nya?