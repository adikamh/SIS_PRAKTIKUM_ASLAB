import 'package:flutter/material.dart';
import '../models/drink.dart';
import '../utils/app_theme.dart';
import '../widgets/case_image_widget.dart';

class AddProductPage extends StatefulWidget {
  final Function(Drink) onSave;

  const AddProductPage({Key? key, required this.onSave}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController(text: 'assets/espresso.png');
  String _selectedCategory = 'Silicone';

  final List<String> _categories = [
    'Silicone',
    'MagSafe',
    'Aesthetic',
    'Armor',
    'Leather',
    'Mecha',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final price = int.parse(_priceController.text.trim());
      final imageUrl = _imageUrlController.text.trim();

      final newDrink = Drink(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        price: price,
        imageUrl: imageUrl,
        category: _selectedCategory,
        description: 'Casing premium $_selectedCategory dengan perlindungan maksimal dan desain stylish dari Toko CH.',
      );

      widget.onSave(newDrink);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_outline, color: Colors.white),
              const SizedBox(width: 8),
              Text('Casing "$name" berhasil ditambahkan ke katalog!'),
            ],
          ),
          backgroundColor: const Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );

      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Validasi Gagal! Silakan periksa kolom formulir.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Tambah Casing Baru',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Live Preview Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CaseImageWidget(
                    imageUrl: _imageUrlController.text,
                    title: _nameController.text.isEmpty ? 'Casing Baru' : _nameController.text,
                    width: 75,
                    height: 85,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEF2FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _selectedCategory.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4F46E5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _nameController.text.isEmpty ? 'Nama Casing HP' : _nameController.text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _priceController.text.isEmpty
                              ? 'Rp 0'
                              : 'Rp ${_priceController.text}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF10B981),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Form Input Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Nama Produk
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nama Casing / Produk',
                        hintText: 'Contoh: MagSafe Armor Case iPhone 15',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                        prefixIcon: const Icon(Icons.phone_android_rounded),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                      ),
                      onChanged: (val) => setState(() {}),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nama produk tidak boleh kosong.';
                        }
                        if (value.trim().length < 3) {
                          return 'Nama produk minimal 3 karakter.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Kategori Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: InputDecoration(
                        labelText: 'Kategori Casing',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                        prefixIcon: const Icon(Icons.category_outlined),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                      ),
                      items: _categories.map((cat) {
                        return DropdownMenuItem<String>(
                          value: cat,
                          child: Text(cat),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _selectedCategory = val;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Harga
                    TextFormField(
                      controller: _priceController,
                      decoration: InputDecoration(
                        labelText: 'Harga',
                        prefixText: 'Rp ',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                        prefixIcon: const Icon(Icons.payments_outlined),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => setState(() {}),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Harga tidak boleh kosong.';
                        }
                        final price = int.tryParse(value.trim());
                        if (price == null) {
                          return 'Masukkan harga dalam bentuk angka.';
                        }
                        if (price <= 0) {
                          return 'Harga harus lebih dari 0.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Image Path
                    TextFormField(
                      controller: _imageUrlController,
                      decoration: InputDecoration(
                        labelText: 'Path Aset / URL Gambar',
                        hintText: 'assets/espresso.png atau https://...',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                        prefixIcon: const Icon(Icons.image_outlined),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                      ),
                      onChanged: (val) => setState(() {}),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Path gambar tidak boleh kosong.';
                        }
                        final trimmed = value.trim();
                        final isAsset = trimmed.startsWith('assets/');
                        final isWeb = trimmed.startsWith('http://') || trimmed.startsWith('https://');
                        if (!isAsset && !isWeb) {
                          return "Path harus dimulai dengan 'assets/' atau URL web.";
                        }
                        if (isAsset &&
                            !trimmed.endsWith('.png') &&
                            !trimmed.endsWith('.jpg') &&
                            !trimmed.endsWith('.jpeg')) {
                          return 'Path harus berupa file gambar (.png, .jpg, .jpeg).';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Submit Button
                    Container(
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: AppTheme.accentGradient,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primary.withOpacity(0.35),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: _submitForm,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.save_rounded, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Simpan Casing ke Katalog',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
