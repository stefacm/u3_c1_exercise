import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../core/services/navigation_service.dart';
import '../core/constants/app_constants.dart';
import '../widgets/custom_card.dart';
import 'categories_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationService = NavigationService();
    
    return Scaffold(
      backgroundColor: AppConstants.background,
      appBar: _buildAppBar(context, navigationService),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(),
            const SizedBox(height: AppConstants.paddingXLarge),
            _buildFeaturedBanner(),
            const SizedBox(height: AppConstants.paddingXLarge),
            _buildActionCards(navigationService),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, NavigationService navigationService) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: const Text(
        'CORPORATE',
        style: TextStyle(
          color: AppConstants.textDark,
          fontWeight: FontWeight.w600,
          fontSize: 20,
          letterSpacing: 2,
        ),
      ),
      actions: [
        _buildCartButton(context, navigationService),
        const SizedBox(width: AppConstants.paddingSmall),
      ],
    );
  }

  Widget _buildCartButton(BuildContext context, NavigationService navigationService) {
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
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
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

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bienvenido',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppConstants.textDark,
          ),
        ),
        const SizedBox(height: AppConstants.paddingSmall),
        Text(
          'Explora nuestro catálogo empresarial',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedBanner() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppConstants.primaryBlue, AppConstants.lightBlue],
        ),
        borderRadius: BorderRadius.circular(AppConstants.paddingMedium),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryBlue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.radiusLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppConstants.paddingMedium),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppConstants.paddingMedium),
                  ),
                  child: const Icon(
                    Icons.trending_up,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppConstants.paddingMedium),
                const Text(
                  'Ofertas Corporativas',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppConstants.paddingSmall),
                Text(
                  'Descuentos especiales para empresas',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCards(NavigationService navigationService) {
    return Column(
      children: [
        _ActionCard(
          title: 'Explorar Categorías',
          subtitle: 'Descubre nuestros productos',
          icon: Icons.category_outlined,
          color: AppConstants.primaryBlue,
          onTap: () => navigationService.navigateToWithSlide(const CategoriesScreen()),
        ),
        const SizedBox(height: AppConstants.paddingMedium),
        Consumer<CartProvider>(
          builder: (context, cart, child) {
            return _ActionCard(
              title: 'Mi Carrito (${cart.itemCount})',
              subtitle: 'Revisa tus productos seleccionados',
              icon: Icons.shopping_cart_outlined,
              color: AppConstants.green,
              onTap: () => navigationService.navigateToWithSlide(const CartScreen()),
            );
          },
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.paddingMedium),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: AppConstants.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppConstants.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: color,
            size: 18,
          ),
        ],
      ),
    );
  }
}