import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // [Keamanan 1] Inisialisasi Secure Storage untuk menyimpan sesi pengguna dengan enkripsi OS
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final String _dummyUsername = 'admin';
  final String _dummyPassword = 'password123';

  // Ubah menjadi async untuk penggunaan secure storage
  void _login() async {
    // [Keamanan 2] Validasi input: Mencegah error/bypass jika field kosong
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username dan Password tidak boleh kosong!'),
          backgroundColor: Colors.orange,
        ),
      );
      return; // Hentikan eksekusi jika kosong
    }

    if (_usernameController.text == _dummyUsername &&
        _passwordController.text == _dummyPassword) {
      String dummyToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.dummy_payload';
      await _secureStorage.write(key: 'auth_token', value: dummyToken);

      if (!mounted) return;

      // Notifikasi sukses
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Berhasil! Sesi diamankan.'),
          backgroundColor: Colors.green,
        ),
      );

      // Pindah ke HomePage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username atau Password salah!'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Login",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // Tambahan: Agar layar tidak overflow saat keyboard muncul
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // PERBAIKAN: Pastikan folder assets ada di luar folder lib dan terdaftar di pubspec.yaml
              const Image(
                  image: AssetImage('./lib/assets/clip-message-sent 1.png'),
                  width: 300,
                  height: 300),
              const SizedBox(height: 10),
              const Text(
                "Selamat Datang! Silahkan Login untuk Mengakses Sistem Akademik Mahasiswa",
                textAlign: TextAlign.center, // Tambahan: Agar teks rata tengah
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 25),

              // TextField Username
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),

              // TextField Password
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 30),

              // Tombol Login
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _login,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Login", style: TextStyle(fontSize: 16)),
                      SizedBox(width: 10),
                      Icon(Icons.login),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
