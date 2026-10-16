import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const Color kuning = Color(0xFFFFC928);
const Color ikonKuning = Color(0xFFD6A000);
const Color judulCokelat = Color(0xFF6B5200);
const Color borderKuning = Color(0xFFE8D9A8);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Form Registrasi',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: kuning,
          foregroundColor: judulCokelat,
          centerTitle: true,
          elevation: 2,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          prefixIconColor: ikonKuning,
          labelStyle: const TextStyle(
            color: Color(0xFF8A6D1D),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(
              color: borderKuning,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(
              color: ikonKuning,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kuning,
            foregroundColor: judulCokelat,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
          ),
        ),
      ),
      home: const RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() =>
      _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  final TextEditingController _namaController =
      TextEditingController();
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();

  final FocusNode _namaFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  String? _jenisKelamin;
  String? _programStudi;
  bool _setuju = false;

  final List<String> _daftarProdi = [
    'Sistem Informasi',
    'Administrasi Bisnis',
    'Manajemen',
    'Matematika',
  ];

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    _namaFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();

    super.dispose();
  }

  void _daftar() {
    FocusScope.of(context).unfocus();

    // Tampilkan peringatan jika checkbox belum dicentang.
    if (!_setuju) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Silakan setujui Syarat & Ketentuan terlebih dahulu.',
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color(0xFF9A7B13),
        ),
      );
      return;
    }

    // Jalankan semua validator dalam Form.
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_jenisKelamin == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih jenis kelamin.'),
        ),
      );
      return;
    }

    // Program studi divalidasi melalui DropdownButtonFormField.
    _tampilkanKonfirmasi();
  }

  void _tampilkanKonfirmasi() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Konfirmasi Registrasi',
            style: TextStyle(
              color: judulCokelat,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _barisData(
                  'Nama Lengkap',
                  _namaController.text.trim(),
                ),
                _barisData(
                  'Email',
                  _emailController.text.trim(),
                ),
                _barisData(
                  'Jenis Kelamin',
                  _jenisKelamin!,
                ),
                _barisData(
                  'Program Studi',
                  _programStudi!,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Apakah data registrasi sudah benar?',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Kembali',
                style: TextStyle(color: judulCokelat),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: const Row(
      children: [
        Icon(
          Icons.check_circle,
          color: Color(0xFF6B5200),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            'Registrasi berhasil dikonfirmasi!',
            style: TextStyle(
              color: Color(0xFF6B5200),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
    backgroundColor: const Color(0xFFFFD966),
    behavior: SnackBarBehavior.floating,
    elevation: 4,
    margin: const EdgeInsets.all(12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    duration: const Duration(seconds: 3),
  ),
);

              },
              child: const Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }

  Widget _barisData(String label, String nilai) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: ikonKuning,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            nilai,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: judulCokelat,
            ),
          ),
        ],
      ),
    );
  }

  Widget _judulBagian(String teks) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 10,
      ),
      child: Text(
        teks,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: judulCokelat,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Form Registrasi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 620,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.app_registration,
                      color: ikonKuning,
                      size: 48,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Registrasi Pengguna',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),

                    _judulBagian('Data Diri'),

                    // NAMA LENGKAP
                    TextFormField(
                      controller: _namaController,
                      focusNode: _namaFocus,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap',
                        hintText: 'Masukkan nama lengkap',
                        prefixIcon: Icon(Icons.person),
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(
                          _emailFocus,
                        );
                      },
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty) {
                          return 'Nama lengkap wajib diisi';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // EMAIL: VALIDASI TANDA @
                    TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocus,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Email harus mengandung "@"',
                        prefixIcon: Icon(Icons.email),
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(
                          _passwordFocus,
                        );
                      },
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty) {
                          return 'Email wajib diisi';
                        }

                        if (!value.trim().contains('@')) {
                          return 'Email harus mengandung tanda @';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // PASSWORD: MINIMAL 6 KARAKTER
                    TextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Minimal 6 karakter',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).unfocus();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password wajib diisi';
                        }

                        if (value.length < 6) {
                          return 'Password minimal 6 karakter';
                        }

                        return null;
                      },
                    ),

                    _judulBagian('Jenis Kelamin'),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(color: borderKuning),
                      ),
                      child: Column(
                        children: [
                          RadioListTile<String>(
                            title: const Text('Laki-laki'),
                            value: 'Laki-laki',
                            groupValue: _jenisKelamin,
                            activeColor: ikonKuning,
                            onChanged: (value) {
                              setState(() {
                                _jenisKelamin = value;
                              });
                            },
                          ),
                          RadioListTile<String>(
                            title: const Text('Perempuan'),
                            value: 'Perempuan',
                            groupValue: _jenisKelamin,
                            activeColor: ikonKuning,
                            onChanged: (value) {
                              setState(() {
                                _jenisKelamin = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    _judulBagian('Program Studi'),

                    DropdownButtonFormField<String>(
                      value: _programStudi,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Pilih Program Studi',
                        prefixIcon: Icon(Icons.school),
                      ),
                      items: _daftarProdi.map((prodi) {
                        return DropdownMenuItem<String>(
                          value: prodi,
                          child: Text(prodi),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _programStudi = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Silakan pilih program studi';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    CheckboxListTile(
                      value: _setuju,
                      activeColor: ikonKuning,
                      controlAffinity:
                          ListTileControlAffinity.leading,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8),
                      title: const Text(
                        'Saya setuju dengan Syarat & Ketentuan',
                        style: TextStyle(fontSize: 14),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _setuju = value ?? false;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _daftar,
                        child: const Text(
                          'Daftar',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Pastikan data yang dimasukkan sudah benar.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9A8B61),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
