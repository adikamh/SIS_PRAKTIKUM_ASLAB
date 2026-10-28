import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final Function(String) onRemoveFromCart;
  final Function() onClearCart;

  const CartPage({
    Key? key,
    required this.cartItems,
    required this.onRemoveFromCart,
    required this.onClearCart,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _tableController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _tableController.dispose();
    super.dispose();
  }

  int _calculateTotal() {
    int total = 0;
    for (var item in widget.cartItems) {
      total += item.drink.price * item.quantity;
    }
    return total;
  }

  void _showCheckoutDialog(
    BuildContext context,
    int totalAmount,
    String customerName,
    String tableNumber,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Checkout Berhasil'),
          content: Text(
            'Pesanan atas nama: $customerName\nNomor Meja: $tableNumber\nTotal Belanja: Rp $totalAmount',
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                widget.onClearCart();
                _nameController.clear();
                _tableController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final int total = _calculateTotal();

    return Scaffold(
      appBar: AppBar(title: Text('Keranjang Anda')),
      body: widget.cartItems.isEmpty
          ? Center(
              child: Text(
                'Keranjang Anda kosong.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.cartItems[index];
                      return ListTile(
                        leading: Image.asset(
                          item.drink.imageUrl,
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.local_cafe),
                        ),
                        title: Text(item.drink.name),
                        subtitle: Text(
                          '${item.quantity} x Rp ${item.drink.price}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Rp ${item.drink.price * item.quantity}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                widget.onRemoveFromCart(item.drink.id);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(15),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  labelText: 'Nama Pemesan',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.person),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nama Pemesan tidak boleh kosong';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _tableController,
                                decoration: const InputDecoration(
                                  labelText: 'Nomor Meja',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.table_bar),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nomor Meja tidak boleh kosong';
                                  }
                                  final int? meja = int.tryParse(value);
                                  if (meja == null) {
                                    return 'Nomor Meja harus berupa angka';
                                  }
                                  if (meja < 1 || meja > 20) {
                                    return 'Nomor Meja harus antara 1-20';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total:',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              'Rp $total',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final String customerName =
                                  _nameController.text;
                              final String tableNumber =
                                  _tableController.text;
                              _showCheckoutDialog(
                                context,
                                total,
                                customerName,
                                tableNumber,
                              );
                            }
                          },
                          child: Text('Checkout'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}