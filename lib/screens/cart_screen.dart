import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../routes/custom_routes.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  String formatPrice(double price) {
    final formatter = NumberFormat('#,###', 'es_CO');
    return '\$${formatter.format(price.toInt())} COP';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF263238)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Consumer<CartProvider>(
          builder: (context, cart, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mi Carrito',
                  style: TextStyle(
                    color: Color(0xFF263238),
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                if (cart.items.isNotEmpty)
                  Text(
                    '${cart.items.length} producto${cart.items.length != 1 ? 's' : ''}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              ],
            );
          },
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              if (cart.items.isEmpty) return const SizedBox();
              return IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        title: const Row(
                          children: [
                            Icon(Icons.delete_outline, color: Color(0xFFD32F2F)),
                            SizedBox(width: 12),
                            Text('Limpiar Carrito'),
                          ],
                        ),
                        content: const Text('¿Estás seguro de que quieres eliminar todos los productos?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Cancelar', style: TextStyle(color: Colors.grey[600])),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              cart.clearCart();
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD32F2F),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Limpiar', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.delete_outline, color: Color(0xFFD32F2F)),
              );
            },
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Tu carrito está vacío',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF263238),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Agrega productos para comenzar tu compra',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                    label: const Text('Explorar Productos', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1565C0),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Cart Items
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(20.0),
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // Product Image
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1565C0).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  item['emoji'],
                                  style: const TextStyle(fontSize: 28),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            
                            // Product Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF263238),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    formatPrice(item['price'].toDouble()),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    formatPrice((item['price'] * item['quantity']).toDouble()),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF388E3C),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Quantity Controls
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF5F7FA),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () => cart.updateQuantity(index, item['quantity'] - 1),
                                        icon: const Icon(Icons.remove, size: 18),
                                        color: const Color(0xFF1565C0),
                                        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Text(
                                          '${item['quantity']}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF263238),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => cart.updateQuantity(index, item['quantity'] + 1),
                                        icon: const Icon(Icons.add, size: 18),
                                        color: const Color(0xFF1565C0),
                                        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                IconButton(
                                  onPressed: () {
                                    cart.removeItem(index);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Row(
                                          children: [
                                            const Icon(Icons.delete_outline, color: Colors.white),
                                            const SizedBox(width: 12),
                                            Text('${item['name']} eliminado'),
                                          ],
                                        ),
                                        backgroundColor: const Color(0xFFD32F2F),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        margin: const EdgeInsets.all(20),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.delete_outline),
                                  color: const Color(0xFFD32F2F),
                                  style: IconButton.styleFrom(
                                    backgroundColor: const Color(0xFFD32F2F).withOpacity(0.1),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Total and Checkout
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total a pagar:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF263238),
                          ),
                        ),
                        Text(
                          formatPrice(cart.total),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF388E3C),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CustomRoutes.slide(CheckoutScreen(total: cart.total)),
                          );
                        },
                        icon: const Icon(Icons.payment, color: Colors.white),
                        label: const Text(
                          'Proceder al Pago',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1565C0),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}