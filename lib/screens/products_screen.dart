import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../core/services/navigation_service.dart';
import '../core/services/formatting_service.dart';
import '../core/constants/app_constants.dart';
import '../models/product.dart';
import '../utils/product_data.dart';
import '../widgets/custom_button.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart';

class ProductsScreen extends StatelessWidget {
  final String category;
  
  const ProductsScreen({super.key, required this.category});

  List<Product> get products {
    if (category == 'Electrónicos') {
      return ProductData.getElectronicsProducts();
    } else if (category == 'Oficina') {
      return ProductData.getOfficeProducts();
    }
    // Default products for other categories
    return [
      Product(
        name: 'Solución Premium $category',
        price: 299990,
        description: 'Producto premium de $category con excelente calidad y soporte técnico.',
        rating: 4.8,
        emoji: '⭐',
      ),
      Product(
        name: 'Paquete Empresarial $category',
        price: 449990,
        description: 'Paquete empresarial de $category diseñado para grandes organizaciones.',
        rating: 4.9,
        emoji: '💼',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final navigationService = NavigationService();
    final formattingService = FormattingService();
    
    return Scaffold(
      backgroundColor: AppConstants.background,
      appBar: _buildAppBar(context, navigationService),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return _ProductCard(
              product: product,
              formattingService: formattingService,
              navigationService: navigationService,
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, NavigationService navigationService) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppConstants.textDark),
        onPressed: () => Navigator.pop(context),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: const TextStyle(
              color: AppConstants.textDark,
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
        _buildCartButton(navigationService),
      ],
    );
  }

  Widget _buildCartButton(NavigationService navigationService) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined, color: AppConstants.primaryBlue),
              onPressed: () => navigationService.navigateToWithSlide(const CartScreen()),
            ),
            if (cart.itemCount > 0)
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
                    '${cart.itemCount}',
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
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  final FormattingService formattingService;
  final NavigationService navigationService;

  const _ProductCard({
    required this.product,
    required this.formattingService,
    required this.navigationService,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.paddingMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildProductInfo(context),
          _buildAddToCartSection(context),
        ],
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return InkWell(
      onTap: () => navigationService.navigateToWithSlide(
        ProductDetailScreen(product: product.toMap()),
      ),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(AppConstants.paddingMedium),
        topRight: Radius.circular(AppConstants.paddingMedium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppConstants.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppConstants.paddingMedium),
              ),
              child: Center(
                child: Text(
                  product.emoji,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            ),
            const SizedBox(width: AppConstants.paddingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppConstants.textDark,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.paddingSmall,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppConstants.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppConstants.paddingMedium),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: AppConstants.orange, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '${product.rating}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppConstants.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingSmall),
                  Text(
                    formattingService.formatPrice(product.price),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppConstants.green,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingSmall),
              decoration: BoxDecoration(
                color: AppConstants.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppConstants.paddingSmall),
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: AppConstants.primaryBlue,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddToCartSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: const BoxDecoration(
        color: AppConstants.background,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppConstants.paddingMedium),
          bottomRight: Radius.circular(AppConstants.paddingMedium),
        ),
      ),
      child: CustomButton(
        text: 'Agregar al Carrito',
        icon: Icons.add_shopping_cart,
        width: double.infinity,
        onPressed: () => _addToCart(context),
      ),
    );
  }

  void _addToCart(BuildContext context) {
    context.read<CartProvider>().addItem(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: AppConstants.paddingMedium),
            Expanded(
              child: Text('${product.name} agregado al carrito'),
            ),
          ],
        ),
        backgroundColor: AppConstants.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.paddingSmall),
        ),
        margin: const EdgeInsets.all(AppConstants.paddingLarge),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}