class Product {
  final String name;
  final int price;
  final String emoji;
  final String description;
  final double rating;

  const Product({
    required this.name,
    required this.price,
    required this.emoji,
    required this.description,
    this.rating = 4.5,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'emoji': emoji,
      'description': description,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      price: map['price'] ?? 0,
      emoji: map['emoji'] ?? '📦',
      description: map['description'] ?? '',
      rating: map['rating']?.toDouble() ?? 4.5,
    );
  }
}