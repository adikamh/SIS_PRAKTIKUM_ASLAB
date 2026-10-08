import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => const MyApp(),
    ),
  );
}

// Slide 22: MaterialApp & StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Aplikasi Daftar Nama',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue, // Tema warna sesuai Slide 22
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

// Slide 6: StatefulWidget (Class 1: Widget)
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Slide 6: State (Class 2: State)
class _MyHomePageState extends State<MyHomePage> {
  // Slide 14: GlobalKey untuk validasi Form
  final _formKey = GlobalKey<FormState>();

  // Slide 12: TextEditingController untuk membaca & mengatur isi TextField
  final TextEditingController _namaController = TextEditingController();

  // Slide 20 & 21: List data nama
  final List<String> _daftarNama = ['Ani', 'Budi', 'Citra'];

  // Slide 15 & 21: Fungsi tambah dengan validasi dan setState()
  void _tambahNama() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _daftarNama.add(_namaController.text);
        _namaController.clear();
      });
    }
  }

  // Slide 12: Dispose controller saat widget dihancurkan
  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Daftar Nama'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Slide 14: Form & TextFormField
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Slide 11 & 14: TextFormField dengan InputDecoration dan Validator
                  TextFormField(
                    controller: _namaController,
                    decoration: const InputDecoration(
                      labelText: 'Nama',
                      hintText: 'Masukkan nama lengkap',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Nama wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  // Slide 7 & 15: ElevatedButton untuk submit/tambah
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _tambahNama,
                      icon: const Icon(Icons.add),
                      label: const Text('Tambah'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            // Slide 18 & 20: ListView.builder, Card, dan ListTile
            Expanded(
              child: _daftarNama.isEmpty
                  ? const Center(
                      child: Text('Belum ada data nama'),
                    )
                  : ListView.builder(
                      itemCount: _daftarNama.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text('${index + 1}'),
                            ),
                            title: Text(
                              _daftarNama[index],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _daftarNama.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
