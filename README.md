# Anggota Kelompok :
1. Aulia Aziizah Fauziyyah - 221511004
2. Jonanda Pantas Agitha Brahmana - 221511015
3. Paulina Lestari Simatupang - 221511026

# Deskripsi Aplikasi
Aplikasi EduAssess merupakan aplikasi yang dapat membantu kepala sekolah dalam mengelola proses penilaian kinerja guru yang dilakukan secara digital. Aplikasi ini dibangun dengan menggunakan teknologi Flutter, sebuah framework pengembangan aplikasi mobile yang memungkinkan pengembangan aplikasi secara cepat dan multi-platform agar pengguna bisa mengakses diperangkat atau lingkungan tanpa terbatas pada platform tertentu. Dengan hadirnya aplikasi EduAsses, diharapkan kepala sekolah dan pihak terkait dapat dengan mudah melakukan evaluasi kinerja guru secara terstruktur, transparan, dan efisien. Aplikasi ini juga memungkinkan untuk mendokumentasikan hasil evaluasi, memberikan umpan balik kepada guru, serta merancang rencana pengembangan profesional berdasarkan hasil evaluasi yang didapatkan.

# Instalansi Visual Sstudio Code (Pada Windows)
1. Kunjungsi situs resmi VIsual Studio Code
2. Klik Tombol "Download"
3. Buka file installer yang sudah diunduh
4. Ikuti pentunjuk pada layar untuk menyelesaikan proses instalansi
5. Buka VSCode 

# Instalansi XAMPP
1. Kunjungi situs resmi XAMPP dan unduh versi terbaru XAMPP
2. Buka installer yang telah diunduh dan mulai proses instalansi
3. Konfigurasi server web Apache
4. Untuk mengakses, dapat membuat 'http://localhost/phpmyadmin''

# Instalansi FLutter SDK (Pada Windows)
1. Kunjungi situs resmi Flutter di flutter.dev
2. Klik "Windows" dan unduh file zip FLutter SDK
3. Ekstrak file zip ke direktori yang diinginkan
4. Buka Control Panel > System and Security > System > Advanced system settings.
5. Klik tombol Environment Variables.
6. Di bagian User variables, temukan variabel Path dan klik Edit.
7. Klik New dan tambahkan jalur ke folder bin 
Flutter, misalnya C:\src\flutter\bin.
8. Klik OK untuk menyimpan perubahan.

# Cara Instalansi Proyek 
1. Install Visual Studio Code 
2. Install Flutter SDK
3. Buka XAMPP, lalu aktifkan dengan menekan 'Start' pada Apache dan MySQL
4. Download proyek pada git, gunakan perintah git clone https://github.com/nama_pengguna/nama_proyek.git
5. Sesuaikan nama database yang ada pada .env dengan DB_DATABASE=teachereval
7. Jalankan perintah 'php artisan migrate'
8. Jalankan perintah 'php artisan db:seed'
9. Jalankan 'php artisan serve'
10. Masuk pada folder front-end pada proyek dengan menjalankan perintan 'cd front-end'
11. Jalankan 'flutter pub get' pada terminal powershell 
13. Jalankan perintah 'flutter run'

# Cara akses aplikasi
1. Aplikasi ini terbagi menjadi 2 role yaitu kepala sekolah dan guru
2. Jika ingin login sebagai kepala sekolah, nip yang dimasukkan yaitu '1234567' dan password yang dimasukkan yaitu 'kepsek123'
3. Jika ingin login sebagai guru, nip dan password yang dapat dimasukkan yaitu
   a. nip = '221511004' dengan password = 'aulia123'
   b. nip = '221511015' dengan password = 'jonanda123'
   c. nip = '221511026' dengan password = 'paulina123'
4. Jika ingin menambahkan akses untuk guru lainnya dapat dengan masuk terlebih dahulu sebagai kepala sekolah dan tambah data guru. Maka guru tersebut otomatis mendapatkan akses kepada aplikasi karena proses registrasi guru hanya dapat dilakukan oleh kepala sekolah
