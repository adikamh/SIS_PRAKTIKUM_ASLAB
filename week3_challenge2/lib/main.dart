import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Warung IS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goToNavigateToHome();
  }

  Future<void> _goToNavigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/cafe.png'),
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> foodlist = [
    'Espresso',
    'Americano',
    'Matcha Latte',
    'Chocolate Frappe',
  ];

  String searchText = "";

  @override
  Widget build(BuildContext context) {
    final search = searchText.toLowerCase();
    final items = foodlist.where((food) => food.toLowerCase().contains(search)).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        title: const Text(
          'Welcome',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                labelText: 'Cari Minuman',
                labelStyle: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              children: items.map((food) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6.0),
                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFBCE0FD),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
                    leading: const Icon(
                      Icons.food_bank_rounded,
                      color: Color(0xFF37474F),
                      size: 26,
                    ),
                    title: Text(
                      food,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 1. Tombol Detail (Flat TextButton warna biru keunguan)
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DrinkDetailPage(
                                  drinkName: food,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Detail',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF5C6BC0),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // 2. Tombol Pesan (Pill shape putih dengan tulisan biru keunguan)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF5C6BC0),
                            elevation: 0.5,
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            _showConfirmationDialog(context, food);
                          },
                          child: const Text(
                            'Pesan',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF5C6BC0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String foodName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Pesanan'),
          content: Text('Apakah Anda yakin ingin memesan $foodName?'),
          actions: [
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ya'),
              onPressed: () {
                Navigator.of(context).pop();
                _showSuccessDialog(context, foodName);
              },
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, String foodName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pesanan Berhasil'),
          content: Text('Anda telah memesan $foodName.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

/// 2. Halaman Detail Minuman (DrinkDetailPage)
class DrinkDetailPage extends StatefulWidget {
  final String drinkName;

  const DrinkDetailPage({super.key, required this.drinkName});

  @override
  State<DrinkDetailPage> createState() => _DrinkDetailPageState();
}

class _DrinkDetailPageState extends State<DrinkDetailPage> {
  // 4. Counter penghitung kuantitas
  int _counter = 1;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      if (_counter > 1) {
        _counter--;
      }
    });
  }

  // 5. AlertDialog konfirmasi pesanan sesuai screenshot
  void _showOrderSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Pesanan Berhasil'),
          content: Text('Anda telah memesan ${widget.drinkName} sebanyak $_counter cup'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.drinkName),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 3. Tata Letak DrinkDetailPage (Bagian Atas)
              // Card kotak melengkung putih berisi Logo Menu Kopi Cokelat dan Nama Minuman
              Container(
                width: 145,
                padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9FB),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.local_cafe,
                      size: 54,
                      color: Color(0xFF6D4C41), // Warna cokelat cangkir kopi
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.drinkName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // 4. Fungsionalitas Kuantitas (Bagian Tengah)
              // Label "Jumlah:"
              const Text(
                'Jumlah:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),

              // Kontrol Counter: (-) [Angka] (+)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tombol Decrement (-) Lingkaran Merah
                  InkWell(
                    onTap: _decrement,
                    borderRadius: BorderRadius.circular(16),
                    child: const Icon(
                      Icons.remove_circle,
                      color: Color(0xFFE53935),
                      size: 32,
                    ),
                  ),
                  // Angka Counter
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      '$_counter',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  // Tombol Increment (+) Lingkaran Hijau
                  InkWell(
                    onTap: _increment,
                    borderRadius: BorderRadius.circular(16),
                    child: const Icon(
                      Icons.add_circle,
                      color: Color(0xFF4CAF50),
                      size: 32,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // 5. Aksi Pesanan (Bagian Bawah)
              // Button "Tambah Pesanan" kapsul/oval abu-abu muda dengan tulisan biru keunguan
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF7F7FA),
                  foregroundColor: const Color(0xFF5C6BC0),
                  elevation: 0.5,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadowColor: Colors.black.withOpacity(0.08),
                ),
                onPressed: _showOrderSuccessDialog,
                child: const Text(
                  'Tambah Pesanan',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF5C6BC0),
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
