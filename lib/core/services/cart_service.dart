import '../interfaces/cart_repository.dart';
import '../../models/cart_item.dart';
import '../../models/product.dart';

class CartService implements ICartRepository {
  final List<CartItem> _items = [];

  @override
  List<CartItem> getItems() => List.unmodifiable(_items);

  @override
  void addItem(Product product) {
    final existingIndex = _items.indexWhere((item) => item.product.name == product.name);
    
    if (existingIndex >= 0) {
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + 1,
      );
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }
  }

  @override
  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
    }
  }

  @override
  void updateQuantity(int index, int quantity) {
    if (index >= 0 && index < _items.length) {
      if (quantity <= 0) {
        removeItem(index);
      } else {
        _items[index] = _items[index].copyWith(quantity: quantity);
      }
    }
  }

  @override
  void clearCart() {
    _items.clear();
  }

  @override
  double getTotal() {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }
}