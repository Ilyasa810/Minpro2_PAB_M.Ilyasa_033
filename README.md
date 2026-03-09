# ⚽ Football Team Catalog App
### Mini Project 2 - Praktikum Pemrograman Aplikasi Bergerak

---

## 👤 Identitas Mahasiswa

| Keterangan | Data |
|-------------|-------------|
| **Nama** | Muhammad Ilyasa' Izzuddin |
| **NIM** | 2409116033 |
| **Kelas** | Sistem Informasi A 2024 |

---

# 📱 Deskripsi Aplikasi

**Football Team Catalog App** adalah aplikasi mobile berbasis **Flutter** yang digunakan untuk menyimpan dan mengelola data tim sepakbola dalam bentuk katalog digital.

Aplikasi ini merupakan pengembangan dari **Mini Project 1** dengan beberapa peningkatan fitur seperti **integrasi database menggunakan Supabase** serta **fitur Light Mode dan Dark Mode**.

Melalui aplikasi ini pengguna dapat melakukan pengelolaan data tim sepakbola secara online dan melihat tampilan aplikasi dengan dua mode tema yang berbeda.

---

# ✨ Fitur Aplikasi

Aplikasi ini memiliki beberapa fitur utama sebagai berikut:

### ➕ Create (Tambah Data)

Pengguna dapat menambahkan data tim sepakbola ke database melalui form input.

Data yang dimasukkan akan tersimpan pada **database Supabase**.

---

### 📋 Read (Menampilkan Data)

Aplikasi menampilkan daftar tim sepakbola yang telah tersimpan di database Supabase dalam bentuk **list katalog**.

---

### 📄 Detail Data

Pengguna dapat melihat **detail informasi tim sepakbola** yang dipilih.

---

### ✏ Update (Edit Data)

Pengguna dapat memperbarui data tim yang sudah tersimpan di database.

---

### 🗑 Delete (Hapus Data)

Pengguna dapat menghapus data tim dari database Supabase.

---

### 🌙 Dark Mode & ☀ Light Mode

Aplikasi menyediakan dua mode tampilan:

- **Light Mode** untuk tampilan terang
- **Dark Mode** untuk tampilan gelap

Pengguna dapat mengganti mode tampilan sesuai preferensi.

---

# 🧠 Konsep Flutter yang Digunakan

Aplikasi ini mengimplementasikan beberapa konsep penting dalam Flutter, antara lain:

- StatelessWidget
- StatefulWidget
- State Management menggunakan Provider
- Navigasi menggunakan Navigator
- Input Form menggunakan TextField
- List data menggunakan ListView
- Theme Management (Light Mode & Dark Mode)
- Integrasi API dan Database menggunakan Supabase

---

# 🧩 Widget Flutter yang Digunakan

Beberapa widget Flutter yang digunakan dalam aplikasi ini:

- MaterialApp
- Scaffold
- AppBar
- Text
- TextField
- ElevatedButton
- ListView
- ListTile
- Column
- Row
- Container
- Icon
- FloatingActionButton
- Navigator
- Card
- Switch / Toggle untuk Theme Mode

---

# 🗄 Backend dan Database

Aplikasi ini menggunakan **Supabase** sebagai backend service.

Supabase digunakan untuk:

- Menyimpan data tim sepakbola
- Mengambil data tim
- Mengupdate data tim
- Menghapus data tim

Supabase merupakan layanan **Backend as a Service (BaaS)** yang menyediakan database berbasis PostgreSQL dan API otomatis.

---

# 📁 Struktur Project

Struktur folder project disusun agar kode lebih terorganisir.

```bash
MINPRO2_PAB_M.Ilyasa_033
│
├── lib
│
│   ├── models
│   │   └── team.dart
│   │
│   ├── pages
│   │   ├── home_page.dart
│   │   ├── team_form_page.dart
│   │   └── team_detail_page.dart
│   │
│   ├── providers
│   │   ├── team_provider.dart
│   │   └── theme_provider.dart
│   │
│   └── main.dart
│
└── pubspec.yaml
```

Penjelasan:

| Folder | Fungsi |
|------|------|
| models | Struktur data tim |
| pages | Halaman UI aplikasi |
| providers | State management |
| main.dart | Entry point aplikasi |

---

# 🚀 Cara Menjalankan Project

Clone repository dari GitHub

```bash
git clone https://github.com/Ilyasa810/Minpro2_PAB_M.Ilyasa_033.git
```

Masuk ke folder project

```bash
cd Minpro2_PAB_M.Ilyasa_033
```

Install dependencies

```bash
flutter pub get
```

Jalankan aplikasi menggunakan Chrome

```bash
flutter run -d chrome
```

---

# 💻 Teknologi yang Digunakan

Teknologi yang digunakan dalam pengembangan aplikasi ini:

- Flutter
- Dart
- Supabase
- Visual Studio Code
- Git
- GitHub

---

# Struktur Table Database di Supabase

<img width="960" height="511" alt="{8E6B3965-E6D5-4289-882D-F65A20BD9707}" src="https://github.com/user-attachments/assets/07ba1fa8-1eac-488f-b9d3-84598085bb17" />

---
# 📷 Tampilan UI Aplikasi

### 🌙 Dark Mode & ☀ Light Mode

Fitur Dark mode dan light mode

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/561c98e2-cccc-4148-964e-39c7fd96b51b" />

---

### 🏠 Halaman Home

Menampilkan daftar katalog tim sepakbola yang tersimpan dalam database.

<img width="960" height="540" alt="{8934B7E6-B7C1-45BD-B209-ADA9F38FD549}" src="https://github.com/user-attachments/assets/4c170351-9a84-4eb0-ac4b-fba5e86efa2a" />

## Tampilan di Supabase

<img width="960" height="470" alt="{6D71EA8D-A886-458C-AFF0-5CEB6CB2C634}" src="https://github.com/user-attachments/assets/b10fe8d9-a132-42ef-a996-159be55821b3" />

---

### ➕ Halaman Tambah Tim

Digunakan untuk menambahkan data tim baru ke database Supabase.

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/ad662fdc-624e-43d5-b214-4d104f062498" />


## Tampilan di Supabase

<img width="960" height="472" alt="{EE9220B2-39BA-41CB-9A87-2A4D101C5029}" src="https://github.com/user-attachments/assets/e4eb4ae7-818f-4246-ade6-88b187b26e12" />

---

### 📄 Halaman Detail Tim

Menampilkan detail informasi dari tim sepakbola yang dipilih.

<img width="960" height="540" alt="{9AF70F23-464D-4511-99D8-1313339FC440}" src="https://github.com/user-attachments/assets/cae368c8-3141-455c-ae27-b950d72a3029" />

---

### ✏ Halaman Edit Tim

Digunakan untuk memperbarui data tim yang sudah ada.

<img width="960" height="540" alt="{0B9480F2-068E-4F75-87E5-B834C4E6024A}" src="https://github.com/user-attachments/assets/d996bee7-77ab-4817-b4a9-058c0943999a" />

---

# 📌 Kesimpulan

Football Team Catalog App merupakan aplikasi katalog tim sepakbola berbasis **Flutter** yang mengimplementasikan konsep **CRUD, integrasi database Supabase, navigasi antar halaman, serta pengaturan tema aplikasi (Light Mode dan Dark Mode)**.

Melalui proyek ini mahasiswa dapat memahami bagaimana membangun aplikasi mobile dengan **backend service, state management, dan pengelolaan tampilan aplikasi yang lebih modern**.
