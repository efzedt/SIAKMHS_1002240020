import 'package:flutter/material.dart';
import 'schedule.dart'; // Pastikan file ini ada
import 'profile.dart'; // Pastikan file ini ada

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sistem Akademik Mahasiswa",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, Faizal Aldiansyah 👋',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Selamat Datang di LMS ITTS',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.5,
                  children: [
                    _buildStatBox('Tugas', '1'),
                    _buildStatBox('Kuis/Ujian', '3'),
                    _buildStatBox('Forum', '0'),
                    _buildStatBox('Vidcon', '1'),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Jadwal",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons
                .security), // Mengganti icon agar lebih pas dengan konsep OTP
            label: "Profil",
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const JadwalKuliahPage()),
            );
          } else if (index == 2) {
            // [Keamanan] Mencegah akses langsung, arahkan ke Halaman OTP dulu
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OtpVerificationPage()),
            );
          }
        },
      ),
    );
  }

  Widget _buildStatBox(String title, String count) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// HALAMAN VERIFIKASI OTP (Supplementary Auth)
// ==========================================
class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController _otpController = TextEditingController();

  // Data dummy OTP untuk keperluan simulasi
  final String _dummyOtp = '123456';

  void _verifyOtp() {
    if (_otpController.text == _dummyOtp) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verifikasi Berhasil!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      // Jika salah, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kode OTP Salah. Coba lagi!'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifikasi Keamanan'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // Warna icon back dan teks menjadi hitam
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_person, size: 80, color: Colors.blueAccent),
            const SizedBox(height: 20),
            const Text(
              'Masukkan Kode OTP',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Untuk melindungi data pribadimu, masukkan 6 digit kode OTP (Dummy: 123456) sebelum masuk ke halaman Profil.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Input OTP
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number, // Memunculkan keyboard angka
              maxLength: 6, // Membatasi maksimal 6 karakter
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 24,
                  letterSpacing: 8.0,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                counterText:
                    "", // Menghilangkan teks penghitung karakter di bawah form
                hintText: "------",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Tombol Verifikasi
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _verifyOtp,
                child: const Text('Verifikasi',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
