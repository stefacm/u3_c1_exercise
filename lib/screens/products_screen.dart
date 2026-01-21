import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../routes/custom_routes.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart';

class ProductsScreen extends StatelessWidget {
  final String category;
  
  const ProductsScreen({super.key, required this.category});

  List<Map<String, dynamic>> get products => [
    {
      'name': 'Solución Premium $category',
      'price': 299990,
      'description': 'Producto premium de $category con excelente calidad y soporte técnico.',
      'rating': 4.8,
      'emoji': '⭐',
    },
    {
      'name': 'Paquete Empresarial $category',
      'price': 449990,
      'description': 'Paquete empresarial de $category diseñado para grandes organizaciones.',
      'rating': 4.9,
      'emoji': '💼',
    },
    {
      'name': 'Estándar $category',
      'price': 199990,
      'description': 'Solución estándar de $category con excelente relación calidad-precio.',
      'rating': 4.7,
      'emoji': '✅',
    },
    {
      'name': 'Edición Corporativa $category',
      'price': 599990,
      'description': 'Edición corporativa de $category con funciones avanzadas y soporte 24/7.',
      'rating': 5.0,
      'emoji': '🏆',
    },
  ];

  String formatPrice(int price) {
    final formatter = NumberFormat('#,###', 'es_CO');
    return '\$${formatter.format(price)} COP';
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: const TextStyle(
                color: Color(0xFF263238),
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            Text(
              '${products.length} productos disponibles',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFF1565C0)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CustomRoutes.slide(const CartScreen()),
                      );
                    },
                  ),
                  if (cart.items.isNotEmpty)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD32F2F),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                        child: Text(
                          '${cart.items.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
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
              child: Column(
                children: [
                  // Main Product Info - Tappable
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CustomRoutes.slide(ProductDetailScreen(product: product)),
                      );
                    },
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // Product Image
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1565C0).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                product['emoji'],
                                style: const TextStyle(fontSize: 32),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          
                          // Product Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF263238),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFA726).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.star, color: Color(0xFFFFA726), size: 14),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${product['rating']}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF263238),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  formatPrice(product['price']),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF388E3C),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // View Details Arrow
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1565C0).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF1565C0),
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Add to Cart Button
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context.read<CartProvider>().addItem(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(Icons.check_circle, color: Colors.white),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text('${product['name']} agregado al carrito'),
                                  ),
                                ],
                              ),
                              backgroundColor: const Color(0xFF388E3C),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              margin: const EdgeInsets.all(20),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add_shopping_cart, color: Colors.white, size: 20),
                        label: const Text(
                          'Agregar al Carrito',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1565C0),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}