import '../models/product.dart';

class ProductData {
  static List<Product> getElectronicsProducts() {
    return [
      const Product(
        name: 'Laptop Empresarial',
        price: 2500000,
        emoji: '💻',
        description: 'Laptop de alta gama para uso empresarial con procesador Intel i7, 16GB RAM y SSD de 512GB.',
        rating: 4.8,
      ),
      const Product(
        name: 'Monitor 4K',
        price: 800000,
        emoji: '🖥️',
        description: 'Monitor profesional 4K de 27 pulgadas con tecnología IPS y calibración de color.',
        rating: 4.6,
      ),
      const Product(
        name: 'Teclado Mecánico',
        price: 350000,
        emoji: '⌨️',
        description: 'Teclado mecánico profesional con switches Cherry MX y retroiluminación RGB.',
        rating: 4.7,
      ),
      const Product(
        name: 'Mouse Ergonómico',
        price: 150000,
        emoji: '🖱️',
        description: 'Mouse ergonómico inalámbrico con sensor óptico de alta precisión.',
        rating: 4.5,
      ),
    ];
  }

  static List<Product> getOfficeProducts() {
    return [
      const Product(
        name: 'Silla Ejecutiva',
        price: 1200000,
        emoji: '🪑',
        description: 'Silla ejecutiva ergonómica con soporte lumbar y ajuste de altura.',
        rating: 4.9,
      ),
      const Product(
        name: 'Escritorio Moderno',
        price: 800000,
        emoji: '🗃️',
        description: 'Escritorio moderno con superficie amplia y organizadores integrados.',
        rating: 4.4,
      ),
    ];
  }

  static List<Product> getCategories() {
    return [
      const Product(
        name: 'Electrónicos',
        price: 0,
        emoji: '💻',
        description: 'Dispositivos electrónicos y tecnología',
      ),
      const Product(
        name: 'Oficina',
        price: 0,
        emoji: '🏢',
        description: 'Mobiliario y suministros de oficina',
      ),
      const Product(
        name: 'Comunicaciones',
        price: 0,
        emoji: '📱',
        description: 'Equipos de comunicación empresarial',
      ),
      const Product(
        name: 'Seguridad',
        price: 0,
        emoji: '🔒',
        description: 'Sistemas de seguridad corporativa',
      ),
      const Product(
        name: 'Software',
        price: 0,
        emoji: '💾',
        description: 'Licencias y software empresarial',
      ),
      const Product(
        name: 'Servicios',
        price: 0,
        emoji: '🛠️',
        description: 'Servicios profesionales y consultoría',
      ),
    ];
  }
}