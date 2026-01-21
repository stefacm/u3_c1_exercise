import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../core/services/formatting_service.dart';
import '../core/constants/app_constants.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  late Product product;
  final FormattingService _formattingService = FormattingService();

  @override
  void initState() {
    super.initState();
    product = Product.fromMap(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.radiusLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductHeader(),
                  const SizedBox(height: AppConstants.paddingLarge),
                  _buildPriceSection(),
                  const SizedBox(height: AppConstants.radiusLarge),
                  _buildDescriptionSection(),
                  const SizedBox(height: AppConstants.radiusLarge),
                  _buildQuantitySelector(),
                  const SizedBox(height: 100), // Space for floating button
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppConstants.textDark),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(AppConstants.radiusLarge),
              bottomRight: Radius.circular(AppConstants.radiusLarge),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              product.emoji,
              style: const TextStyle(fontSize: 120),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppConstants.textDark,
            height: 1.2,
          ),
        ),
        const SizedBox(height: AppConstants.paddingMedium),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingMedium,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: AppConstants.orange.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, color: AppConstants.orange, size: 18),
              const SizedBox(width: 4),
              Text(
                '${product.rating}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.textDark,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '(248 reseñas)',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppConstants.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppConstants.paddingMedium),
        border: Border.all(
          color: AppConstants.green.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_offer, color: AppConstants.green, size: 24),
          const SizedBox(width: AppConstants.paddingMedium),
          Text(
            _formattingService.formatPrice(product.price),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: AppConstants.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Descripción del Producto',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppConstants.textDark,
          ),
        ),
        const SizedBox(height: AppConstants.paddingMedium),
        Container(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppConstants.paddingMedium),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            product.description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cantidad',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppConstants.textDark,
          ),
        ),
        const SizedBox(height: AppConstants.paddingMedium),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppConstants.paddingMedium),
            border: Border.all(color: Colors.grey[300]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: quantity > 1 ? () => setState(() => quantity--) : null,
                icon: const Icon(Icons.remove),
                color: quantity > 1 ? AppConstants.primaryBlue : Colors.grey[400],
                style: IconButton.styleFrom(
                  backgroundColor: quantity > 1 
                      ? AppConstants.primaryBlue.withValues(alpha: 0.1) 
                      : Colors.grey[100],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: AppConstants.paddingMedium,
                ),
                child: Text(
                  '$quantity',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppConstants.textDark,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => setState(() => quantity++),
                icon: const Icon(Icons.add),
                color: AppConstants.primaryBlue,
                style: IconButton.styleFrom(
                  backgroundColor: AppConstants.primaryBlue.withValues(alpha: 0.1),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: FloatingActionButton.extended(
        onPressed: _addToCart,
        backgroundColor: AppConstants.primaryBlue,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.paddingMedium),
        ),
        icon: const Icon(Icons.add_shopping_cart, color: Colors.white, size: 24),
        label: Text(
          'Agregar $quantity al carrito',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _addToCart() {
    for (int i = 0; i < quantity; i++) {
      context.read<CartProvider>().addItem(product);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: AppConstants.paddingMedium),
            Expanded(
              child: Text('$quantity x ${product.name} agregado al carrito'),
            ),
          ],
        ),
        backgroundColor: AppConstants.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.paddingMedium),
        ),
        margin: const EdgeInsets.all(AppConstants.paddingLarge),
      ),
    );
  }
}