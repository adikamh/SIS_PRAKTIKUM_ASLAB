import 'package:flutter/material.dart';
import '../models/drink.dart';
import '../models/cart_item.dart';
import 'home_page.dart';
import 'cart_page.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // State Global Keranjang
  final List<CartItem> _cartItems = [];

  // Data Statis Menu
  final List<Drink> _drinkList = [
    Drink(id: '1', name: 'Espresso', price: 18000, imageUrl: 'assets/espresso.png'),
    Drink(id: '2', name: 'Americano', price: 20000, imageUrl: 'assets/americano.png'),
    Drink(id: '3', name: 'Matcha Latte', price: 25000, imageUrl: 'assets/matcha.png'),
    Drink(id: '4', name: 'Chocolate Frappe', price: 28000, imageUrl: 'assets/choco.png'),
  ];

  void _addToCart(Drink drink, int quantity) {
    setState(() {
      int index = _cartItems.indexWhere((item) => item.drink.id == drink.id);
      if (index != -1) {
        // Jika sudah ada, tambahkan quantity
        _cartItems[index].quantity += quantity;
      } else {
        // Jika belum, buat CartItem baru
        _cartItems.add(CartItem(drink: drink, quantity: quantity));
      }
    });
    
    // Opsional: Tampilkan SnackBar saat berhasil tambah
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${drink.name} ditambahkan ke keranjang')),
    );
  }
  
  void _clearCart() {
  setState(() {
    _cartItems.clear();
  });
}

  void _removeFromCart(String drinkId) {
    setState(() {
      _cartItems.removeWhere((item) => item.drink.id == drinkId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePage(drinkList: _drinkList, onAddToCart: _addToCart),
      CartPage(cartItems: _cartItems, onRemoveFromCart: _removeFromCart
       onClearCart: _clearCart,),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
        ],
      ),
    );
  }
}