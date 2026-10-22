import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartPage extends StatelessWidget {
  final List<CartItem> cartItems;
  final Function(String) onRemoveFromCart;

  CartPage({required this.cartItems, required this.onRemoveFromCart});

  @override
  Widget build(BuildContext context) {
    // Hitung total harga
    int totalPrice = 0;
    for (var item in cartItems) {
      totalPrice += item.drink.price * item.quantity;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Keranjang Anda'),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Text(
                'Keranjang Anda kosong.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: Image.asset(
                            item.drink.imageUrl,
                            width: 40,
                            height: 40,
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.local_cafe),
                          ),
                          title: Text(item.drink.name, style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('${item.quantity} x Rp ${item.drink.price}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Rp ${item.drink.price * item.quantity}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  onRemoveFromCart(item.drink.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                // Bagian Total dan Checkout
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('Rp $totalPrice', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                        ],
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: Colors.blue[50],
                            foregroundColor: Colors.blue,
                            elevation: 0,
                          ),
                          onPressed: () {
                            // Dialog Checkout Sukses
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Checkout Berhasil'),
                                  content: Text('Anda telah berhasil checkout dengan total harga Rp $totalPrice'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('Checkout', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}