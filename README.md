# soal-shift-sisop-modul-1-A01-2021
## Nama Anggota
```
-Erki Kadhafi Rosyid              05111940000050
-Muhammad Valda Rizky Nur Firdaus 05111940000115
-Ahdan Amanullah Irfan Muzhaffar  05111940000197
```
## Soal dan Penjelasan Jawaban
### Soal No.1
Ryujin baru saja diterima sebagai IT support di perusahaan Bukapedia. Dia diberikan tugas untuk membuat laporan harian untuk aplikasi internal perusahaan, ticky. Terdapat 2 laporan yang harus dia buat, yaitu laporan daftar peringkat pesan error terbanyak yang dibuat oleh ticky dan laporan penggunaan user pada aplikasi ticky. Untuk membuat laporan tersebut, Ryujin harus melakukan beberapa hal berikut:

**a.** Mengumpulkan informasi dari log aplikasi yang terdapat pada file syslog.log. Informasi yang diperlukan antara lain: jenis log (ERROR/INFO), pesan log, dan username pada setiap baris lognya. Karena Ryujin merasa kesulitan jika harus memeriksa satu per satu baris secara manual, dia menggunakan regex untuk mempermudah pekerjaannya. Bantulah Ryujin membuat regex tersebut.

**b.** Kemudian, Ryujin harus menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.

**c.** Ryujin juga harus dapat menampilkan jumlah kemunculan log ERROR dan INFO untuk setiap user-nya.

Setelah semua informasi yang diperlukan telah disiapkan, kini saatnya Ryujin menuliskan semua informasi tersebut ke dalam laporan dengan format file csv.

**d.** Semua informasi yang didapatkan pada poin b dituliskan ke dalam file error_message.csv dengan header Error,Count yang kemudian diikuti oleh daftar pesan error dan jumlah kemunculannya diurutkan berdasarkan jumlah kemunculan pesan error dari yang terbanyak.

```
Contoh:
Error,Count
Permission denied,5
File not found,3
Failed to connect to DB,2
```

**e.** Semua informasi yang didapatkan pada poin c dituliskan ke dalam file user_statistic.csv dengan header Username,INFO,ERROR diurutkan berdasarkan username secara ascending.

```
Contoh:
Username,INFO,ERROR
kaori02,6,0
kousei01,2,2
ryujin.1203,1,3
```
**Catatan**:
- Setiap baris pada file syslog.log mengikuti pola berikut:

```
<time> <hostname> <app_name>: <log_type> <log_message> (<username>)
```
- Tidak boleh menggunakan AWK
### Soal No.2 
Steven dan Manis mendirikan sebuah startup bernama “TokoShiSop”. Sedangkan kamu dan Clemong adalah karyawan pertama dari TokoShiSop. Setelah tiga tahun bekerja, Clemong diangkat menjadi manajer penjualan TokoShiSop, sedangkan kamu menjadi kepala gudang yang mengatur keluar masuknya barang.

Tiap tahunnya, TokoShiSop mengadakan Rapat Kerja yang membahas bagaimana hasil penjualan dan strategi kedepannya yang akan diterapkan. Kamu sudah sangat menyiapkan sangat matang untuk raker tahun ini. Tetapi tiba-tiba, Steven, Manis, dan Clemong meminta kamu untuk mencari beberapa kesimpulan dari data penjualan “Laporan-TokoShiSop.tsv”.

**a.** Steven ingin mengapresiasi kinerja karyawannya selama ini dengan mengetahui Row ID dan profit percentage terbesar (jika hasil profit percentage terbesar lebih dari 1, maka ambil Row ID yang paling besar). Karena kamu bingung, Clemong memberikan definisi dari profit percentage, yaitu:

```
Profit Percentage = (Profit Cost Price) 100
```

Cost Price didapatkan dari pengurangan Sales dengan Profit. (Quantity diabaikan).

**b.** Clemong memiliki rencana promosi di Albuquerque menggunakan metode MLM. Oleh karena itu, Clemong membutuhkan daftar nama customer pada transaksi tahun 2017 di Albuquerque.

**c.** TokoShiSop berfokus tiga segment customer, antara lain: Home Office, Customer, dan Corporate. Clemong ingin meningkatkan penjualan pada segmen customer yang paling sedikit. Oleh karena itu, Clemong membutuhkan segment customer dan jumlah transaksinya yang paling sedikit.

**d.** TokoShiSop membagi wilayah bagian (region) penjualan menjadi empat bagian, antara lain: Central, East, South, dan West. Manis ingin mencari wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit dan total keuntungan wilayah tersebut.

Agar mudah dibaca oleh Manis, Clemong, dan Steven, (e) kamu diharapkan bisa membuat sebuah script yang akan menghasilkan file “hasil.txt” yang memiliki format sebagai berikut:
```
Transaksi terakhir dengan profit percentage terbesar yaitu *ID Transaksi* dengan persentase *Profit Percentage*%.

Daftar nama customer di Albuquerque pada tahun 2017 antara lain:
*Nama Customer1*
*Nama Customer2* dst

Tipe segmen customer yang penjualannya paling sedikit adalah *Tipe Segment* dengan *Total Transaksi* transaksi.

Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah *Nama Region* dengan total keuntungan *Total Keuntungan (Profit)*
```
**Catatan**:
- Gunakan bash, AWK, dan command pendukung
- Script pada poin (e) memiliki nama file ‘soal2_generate_laporan_ihir_shisop.sh’
### Jawaban No.2
**a.** Untuk Soal 2a karena diminta untuk mencari pemilik (id transaksi) dan nilai max dari profit percentage (dijelaskan di soal). Oleh karena itu, pertama meng-inisialisasi di awal nilai `max = 0` lalu memulai program awk:
```bash
awk -F "\t" 'BEGIN {max=0} 
```
untuk pengecekan per barisnya akan dilakukan :
```bash
if(NR!=1)
{
    cost = ($21/($18 - $21)*100);
    if(cost >= max){max = cost;ROWID = $1;ORDID=$2}
} 
```
`if(NR!=1)` diberikan agar tidak membaca baris pertama dari tabel karena berisi nama kolom bukan value yang dicari.

Setelah `cost` dari tiap baris didapatkan akan dibandingkan dengan max yang ada, jika lebih atau sama dengan dari max maka `ORDID` akan diambil dari kolom 2 baris tersebut.

Akhirnya diberikan `END` dan hasilnya akan di masukkan ke `hasil.txt` :
```bash
END {
    print "Transaksi terakhir dengan profit percentage terbesar yaitu",ORDID,"dengan persentase",max,"%\n"
}' Laporan-TokoShiSop.tsv > hasil.txt
```
`>` dipakai untuk membuat membuat file baru/menimpa file yang sudah ada `hasil.txt`

**b.** Pertama, memberikan perintah `BEGIN` untuk print apa yang diinstruksikan di soal:
```bash
awk -F "\t" 'BEGIN {
    print "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:"
    } 
```
Lalu untuk mencari data transaksi yang terjadi pada tahun 2017 maka digunakan:
```bash
$3 ~ /[0-9][0-9]-[0-9][0-9]-17/ 
```
Kode diatas bermaksud mengecek kolom ke-3 (waktu transaksi) dan mengeceknya apakah terjadi di tahun 2017 (yang dicocokan hanya pada tahun 2017 nya. Tanggal dan bulannya bebas).

Lalu apabila transaksi tersebut terjadi di tahun 2017 maka dilakukan :
```bash
{
    if($10 == "Albuquerque")
    a[$7]++
}
```
untuk memfilter apakah customer berada di Albuquerque. Jiak iya maka nama customer (kolom ke-7) akan ditambahkan ke dalam array `a[]`.

Lalu setelah semua difilter maka nantinya customer yang telah ditambahkan akan diprint siapa saja yang melakukan transaksi pada tahun 2017 dan berada di Albuquerque:
```bash
END { 
    for (b in a) 
    { 
        print b
    }
}' Laporan-TokoShiSop.tsv >> hasil.txt
```
Perulangan tersebut hanya mengeluarkan nama yang telah dimasukkan **1 kali** sehingga tidak berulang. Hasilnya akan ditambahkan ke `hasil.txt`

**c.** Untuk menghitung jumlah segmen transaksi yang paling sedikit maka akan dihitung setiap barisnya sehingga akan didapatkan jumlah dari setiap segmen :
```bash
awk -F "\t" '{
    if(NR!=1)a[$8]++
    }
```
Tiap baris, kolom ke-8 (segmen) akan ditambahkan ke array masing-masing sehingga dapat diketahui banyak tiap segmen

Lalu array dari tiap segmen akan dibandingkan sehingga didapatkan jumlah minimalnya:
```bash
END {
    min = a["Consumer"];
    tag = "Customer"
    for(b in a)
        if(a[b] < min) {
            min = a[b];
            tag = b;
        }
    print "\nTipe segmen customer yang penjualannya paling sedikit adalah",tag,"dengan",min,"transaksi.\n"
}' Laporan-TokoShiSop.tsv >> hasil.txt
```
Hasilnya akan ditambahkan ke `hasil.txt`

**d.** Untuk mendapatkan wilayah yang mendapatkan keuntungan terkecil caranya hampir sama seperti 2c namun nantinya tiap array dari masing-masing wilayah akan ditambahkan dengan nilai profitnya (bukan banyak wilayah) :
```bash
awk -F "\t" '{
    if(NR!=1)a[$13]+=$21
    }
```
Kolom ke-21 `$21` akan ditambahkan ke array dari wilayah yang discan di baris tersebut (`$13`).

lalu untuk membandingkan wilayah mana yang mempunyai keuntungan terkecil caranya seperti yang tertera di no.`2c`
```bash
END {
    min = a["South"];
    tag = "South"
    for(b in a)
        if(a[b] < min){
            min = a[b];
            tag = b;
    }
    printf "Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %f",tag,min
}' Laporan-TokoShiSop.tsv >> hasil.txt
```
Hasilnya akan ditambahkan ke `hasil.txt`
