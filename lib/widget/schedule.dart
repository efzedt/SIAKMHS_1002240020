import 'package:flutter/material.dart';

class JadwalKuliahPage extends StatelessWidget {
  const JadwalKuliahPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Contoh data statis
    final List<String> jadwal = [
      "Senin, 17:00 - 19:00 • TI225 - Pembelajaran Mesin",
      "Senin, 19:00 - 21:00 • TI227 - Keamanan Informasi & Jaringan",
      "Selasa, 19:00 - 21:00 • TI2256 - Pemorgraman Back-End",
      "Rabu, 17:00 - 19:00 • TI222 - Keamanan Aplikasi Mobile",
      "Rabu, 19:00 - 20:20 • TI223 - Pengujian Penetrasi Aplikasi Mobile",
      "Kamis, 17:00 - 19:00 • TI224 - Pemrograman Aplikasi Mobile",
      "Jumat, 19:00 - 21:00 • TI228 - Pengujian Perangkat Lunak",
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Jadwal Kuliah",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: jadwal.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.account_circle, color: Colors.blue),
              title: Text(jadwal[index]),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      ),
    );
  }
}
