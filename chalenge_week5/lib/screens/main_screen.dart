import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/drink.dart';
import '../utils/app_theme.dart';
import '../utils/page_transitions.dart';
import 'cart_page.dart';
import 'home_page.dart';
import 'add_product.dart';
import 'edit_product.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<CartItem> _cartItems = [];

  // Koleksi Awal Produk Casing Toko CH
  final List<Drink> _drinkList = [
    Drink(
      id: 'ch1',
      name: 'Clear Magnetic MagSafe Case',
      price: 49000,
      imageUrl: 'https://images.unsplash.com/photo-1601593346740-925612772716?w=500',
      category: 'MagSafe',
      description:
          'Casing bening kristal dengan teknologi anti-kuning (anti-yellowing) dan ring magnetik kuat untuk aksesoris & charger MagSafe.',
      rating: 4.9,
      compatibleModels: 'iPhone 11 - 15 Pro Max',
    ),
    Drink(
      id: 'ch2',
      name: 'Silicone Matte Soft Touch Case',
      price: 35000,
      imageUrl: 'https://images.unsplash.com/photo-1586105251261-72a756497a11?w=500',
      category: 'Silicone',
      description:
          'Bahan liquid silicone premium yang lembut seperti sutra, anti sidik jari (anti-fingerprint), dan perlindungan kamera penuh.',
      rating: 4.8,
      compatibleModels: 'iPhone / Samsung / Xiaomi / Oppo',
    ),
    Drink(
      id: 'ch3',
      name: 'Aesthetic Hologram Wave Glow',
      price: 59000,
      imageUrl: 'https://images.unsplash.com/photo-1541877944-ac82a091518a?w=500',
      category: 'Aesthetic',
      description:
          'Efek pantulan cahaya pelangi hologram dengan bezel gelombang ergonomis yang trendi dan estetik untuk cermin selfie.',
      rating: 4.9,
      compatibleModels: 'iPhone 13 / 14 / 15 Series',
    ),
    Drink(
      id: 'ch4',
      name: 'Rugged Heavy Duty Armor Bumper',
      price: 69000,
      imageUrl: 'https://images.unsplash.com/photo-1580910051074-3eb694886505?w=500',
      category: 'Armor',
      description:
          'Perlindungan standar militer drop test 3 meter. Dilengkapi 4 corner air cushion bumper tahan banting dan kickstand lipat.',
      rating: 4.7,
      compatibleModels: 'Samsung Galaxy & iPhone Series',
    ),
    Drink(
      id: 'ch5',
      name: 'Luxury Leather Wallet Flip Case',
      price: 89000,
      imageUrl: 'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?w=500',
      category: 'Leather',
      description:
          'Kulit sintetis PU kualitas tinggi dengan 3 slot kartu, proteksi RFID, dan tekstur jahitan mewah elegan.',
      rating: 4.9,
      compatibleModels: 'All Flagship Smartphones',
    ),
    Drink(
      id: 'ch6',
      name: 'Cyberpunk Frosted Mecha Case',
      price: 79000,
      imageUrl: 'https://images.unsplash.com/photo-1616469829941-c7200edec809?w=500',
      category: 'Mecha',
      description:
          'Aksen garis futuristik semi-transparan dengan tombol metalik clicky tactile premium dan ventilasi disipasi panas.',
      rating: 4.8,
      compatibleModels: 'iPhone 14/15, ROG Phone, POCO',
    ),
  ];

  void _addProduct(Drink newDrink) {
    setState(() {
      _drinkList.add(newDrink);
    });
  }

  void _updateProduct(Drink updatedDrink) {
    setState(() {
      final index = _drinkList.indexWhere(
        (drink) => drink.id == updatedDrink.id,
      );
      if (index != -1) {
        _drinkList[index] = updatedDrink;
      }
    });
  }

  void _deleteProduct(String id) {
    setState(() {
      _drinkList.removeWhere((drink) => drink.id == id);
    });
  }

  void _navigateToAddPage(BuildContext context) {
    Navigator.push(
      context,
      AppPageRoute.slideUp(
        AddProductPage(
          onSave: (Drink newDrink) {
            _addProduct(newDrink);
          },
        ),
      ),
    );
  }

  void _navigateToEditPage(BuildContext context, Drink drinkToEdit) {
    Navigator.push(
      context,
      AppPageRoute.slideUp(
        EditProductPage(
          existingDrink: drinkToEdit,
          onSave: (Drink updatedDrink) {
            _updateProduct(updatedDrink);
          },
        ),
      ),
    );
  }

  void _addToCart(Drink drink, int quantity) {
    setState(() {
      final existingIndex = _cartItems.indexWhere(
        (item) => item.drink.id == drink.id,
      );

      if (existingIndex != -1) {
        _cartItems[existingIndex].quantity += quantity;
      } else {
        _cartItems.add(CartItem(drink: drink, quantity: quantity));
      }
    });
  }

  void _removeFromCart(String drinkId) {
    setState(() {
      _cartItems.removeWhere((item) => item.drink.id == drinkId);
    });
  }

  void _clearCart() {
    setState(() {
      _cartItems.clear();
    });
  }

  List<Widget> _buildPages() {
    return [
      HomePage(
        drinkList: _drinkList,
        onAddToCart: _addToCart,
        onAdd: () => _navigateToAddPage(context),
        onEdit: (Drink drink) => _navigateToEditPage(context, drink),
        onDelete: _deleteProduct,
      ),
      CartPage(
        cartItems: _cartItems,
        onRemoveFromCart: _removeFromCart,
        onClearCart: _clearCart,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = _buildPages();
    final totalCartQuantity = _cartItems.fold<int>(0, (sum, item) => sum + item.quantity);

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        child: pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              selectedItemColor: AppTheme.primary,
              unselectedItemColor: const Color(0xFF94A3B8),
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              items: <BottomNavigationBarItem>[
                const BottomNavigationBarItem(
                  icon: Icon(Icons.grid_view_rounded),
                  activeIcon: Icon(Icons.grid_view_rounded, size: 28),
                  label: 'Katalog CH',
                ),
                BottomNavigationBarItem(
                  icon: Badge(
                    label: Text(
                      totalCartQuantity.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    isLabelVisible: _cartItems.isNotEmpty,
                    backgroundColor: const Color(0xFFEF4444),
                    child: const Icon(Icons.shopping_bag_outlined),
                  ),
                  activeIcon: Badge(
                    label: Text(
                      totalCartQuantity.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    isLabelVisible: _cartItems.isNotEmpty,
                    backgroundColor: const Color(0xFFEF4444),
                    child: const Icon(Icons.shopping_bag_rounded, size: 28),
                  ),
                  label: 'Keranjang',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
