import 'package:flutter/material.dart';
import '../providers/cart_provider.dart';
import '../core/services/formatting_service.dart';
import '../core/services/navigation_service.dart';
import '../core/constants/app_constants.dart';
import '../widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formattingService = FormattingService();
    final navigationService = NavigationService();
    
    return Scaffold(
      backgroundColor: AppConstants.background,
      appBar: _buildAppBar(context),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return _buildEmptyCart(context);
          }
          return _buildCartContent(context, cart, formattingService, navigationService);
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppConstants.textDark),
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
                  color: AppConstants.textDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              if (cart.items.isNotEmpty)
                Text(
                  '${cart.itemCount} producto${cart.itemCount != 1 ? 's' : ''}',
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
              onPressed: () => _showClearCartDialog(context, cart),
              icon: const Icon(Icons.delete_outline, color: Color(0xFFD32F2F)),
            );
          },
        ),
      ],
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.paddingXLarge),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
            ),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: AppConstants.radiusLarge),
          const Text(
            'Tu carrito está vacío',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppConstants.textDark,
            ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(
            'Agrega productos para comenzar tu compra',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.paddingXLarge),
          CustomButton(
            text: 'Explorar Productos',
            icon: Icons.shopping_bag_outlined,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, CartProvider cart, FormattingService formattingService, NavigationService navigationService) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(AppConstants.paddingLarge),
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final item = cart.items[index];
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
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.paddingMedium),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: AppConstants.primaryBlue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppConstants.paddingMedium),
                        ),
                        child: Center(
                          child: Text(
                            item.product.emoji,
                            style: const TextStyle(fontSize: 28),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppConstants.paddingMedium),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.product.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppConstants.textDark,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              formattingService.formatPrice(item.product.price),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: AppConstants.paddingSmall),
                            Text(
                              formattingService.formatCurrency(item.totalPrice),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppConstants.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildQuantityControls(context, cart, index, item),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        _buildCheckoutSection(context, cart, formattingService, navigationService),
      ],
    );
  }

  Widget _buildQuantityControls(BuildContext context, CartProvider cart, int index, item) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppConstants.background,
            borderRadius: BorderRadius.circular(AppConstants.paddingSmall),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => cart.updateQuantity(index, item.quantity - 1),
                icon: const Icon(Icons.remove, size: 18),
                color: AppConstants.primaryBlue,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingSmall),
                child: Text(
                  '${item.quantity}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppConstants.textDark,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => cart.updateQuantity(index, item.quantity + 1),
                icon: const Icon(Icons.add, size: 18),
                color: AppConstants.primaryBlue,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.paddingSmall),
        IconButton(
          onPressed: () => _removeItem(context, cart, index, item),
          icon: const Icon(Icons.delete_outline),
          color: const Color(0xFFD32F2F),
          style: IconButton.styleFrom(
            backgroundColor: const Color(0xFFD32F2F).withValues(alpha: 0.1),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutSection(BuildContext context, CartProvider cart, FormattingService formattingService, NavigationService navigationService) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.radiusLarge),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppConstants.radiusLarge),
          topRight: Radius.circular(AppConstants.radiusLarge),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
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
                  color: AppConstants.textDark,
                ),
              ),
              Text(
                formattingService.formatCurrency(cart.total),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppConstants.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          CustomButton(
            text: 'Proceder al Pago',
            icon: Icons.payment,
            width: double.infinity,
            onPressed: () => navigationService.navigateToWithSlide(
              CheckoutScreen(total: cart.total),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearCartDialog(BuildContext context, CartProvider cart) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.paddingMedium)),
          title: const Row(
            children: [
              Icon(Icons.delete_outline, color: Color(0xFFD32F2F)),
              SizedBox(width: AppConstants.paddingMedium),
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.paddingSmall)),
              ),
              child: const Text('Limpiar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _removeItem(BuildContext context, CartProvider cart, int index, item) {
    cart.removeItem(index);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.delete_outline, color: Colors.white),
            const SizedBox(width: AppConstants.paddingMedium),
            Text('${item.product.name} eliminado'),
          ],
        ),
        backgroundColor: const Color(0xFFD32F2F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.paddingSmall)),
        margin: const EdgeInsets.all(AppConstants.paddingLarge),
      ),
    );
  }
}