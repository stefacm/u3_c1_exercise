import 'package:flutter/material.dart';
import '../core/interfaces/cart_repository.dart';
import '../core/services/cart_service.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final ICartRepository _cartRepository;

  CartProvider({ICartRepository? cartRepository}) 
      : _cartRepository = cartRepository ?? CartService();

  List<CartItem> get items => _cartRepository.getItems();
  double get total => _cartRepository.getTotal();
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  void addItem(Product product) {
    _cartRepository.addItem(product);
    notifyListeners();
  }

  void removeItem(int index) {
    _cartRepository.removeItem(index);
    notifyListeners();
  }

  void updateQuantity(int index, int quantity) {
    _cartRepository.updateQuantity(index, quantity);
    notifyListeners();
  }

  void clearCart() {
    _cartRepository.clearCart();
    notifyListeners();
  }
}