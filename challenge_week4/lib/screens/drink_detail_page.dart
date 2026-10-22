import 'package:flutter/material.dart';
import '../models/drink.dart';

class DrinkDetailPage extends StatefulWidget {
  final Drink drink;
  final Function(Drink, int) onAddToCart;

  DrinkDetailPage({required this.drink, required this.onAddToCart});

  @override
  State<DrinkDetailPage> createState() => _DrinkDetailPageState();
}

class _DrinkDetailPageState extends State<DrinkDetailPage> {
  int _quantity = 1;

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Berhasil Ditambahkan'),
          content: Text('Anda telah menambahkan ${widget.drink.name} ($_quantity) ke keranjang'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drink.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gambar Menu
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                widget.drink.imageUrl,
                width: 100,
                height: 100,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.local_cafe, size: 100, color: Colors.brown),
              ),
            ),
            SizedBox(height: 20),
            
            // Info Menu
            Text(
              widget.drink.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Harga: Rp ${widget.drink.price}',
              style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 40),
            
            // Counter
            Text('Jumlah:', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (_quantity > 1) {
                      setState(() => _quantity--);
                    }
                  },
                  icon: Icon(Icons.remove_circle, color: Colors.red, size: 40),
                ),
                Text(
                  '$_quantity',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    setState(() => _quantity++);
                  },
                  icon: Icon(Icons.add_circle, color: Colors.green, size: 40),
                ),
              ],
            ),
            SizedBox(height: 50),
            
            // Button Tambah ke Keranjang
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.blue[50],
                foregroundColor: Colors.blue,
                elevation: 0,
              ),
              onPressed: () {
                widget.onAddToCart(widget.drink, _quantity);
                _showSuccessDialog();
              },
              child: Text('Tambah ke Keranjang', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}