import 'drink.dart';

class CartItem {
  final Drink drink;
  int quantity;
  String selectedModel;
  String selectedColor;

  CartItem({
    required this.drink,
    required this.quantity,
    this.selectedModel = 'iPhone 15 Pro',
    this.selectedColor = 'Midnight Black',
  });
}
