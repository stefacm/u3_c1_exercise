import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  double get total => _items.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));

  void addItem(Map<String, dynamic> product) {
    final existingIndex = _items.indexWhere((item) => item['name'] == product['name']);
    
    if (existingIndex >= 0) {
      _items[existingIndex]['quantity']++;
    } else {
      _items.add({
        'name': product['name'],
        'price': product['price'],
        'quantity': 1,
        'emoji': product['emoji'] ?? '📦',
      });
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void updateQuantity(int index, int quantity) {
    if (quantity <= 0) {
      removeItem(index);
    } else {
      _items[index]['quantity'] = quantity;
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}