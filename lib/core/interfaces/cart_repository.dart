import '../../models/cart_item.dart';
import '../../models/product.dart';

abstract class ICartRepository {
  List<CartItem> getItems();
  void addItem(Product product);
  void removeItem(int index);
  void updateQuantity(int index, int quantity);
  void clearCart();
  double getTotal();
}