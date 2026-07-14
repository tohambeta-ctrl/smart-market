class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final String unit;
  final String location;
  final String sellerName;
  final String sellerId;
  final double rating;
  final int reviewCount;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.unit,
    required this.location,
    required this.sellerName,
    required this.sellerId,
    required this.rating,
    required this.reviewCount,
  });
}

class Seller {
  final String id;
  final String name;
  final String location;
  final String category;
  final double rating;
  final int reviewCount;
  final bool isVerified;
  final String phone;

  const Seller({
    required this.id,
    required this.name,
    required this.location,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.isVerified,
    required this.phone,
  });
}

// Sample data
final sampleProducts = [
  const Product(
    id: '1',
    name: 'Tomatoes (Fresh)',
    category: 'Vegetables',
    price: 2.50,
    unit: 'kg',
    location: 'Nairobi, Kenya',
    sellerName: 'Green Farm Supplies',
    sellerId: 's1',
    rating: 4.5,
    reviewCount: 128,
  ),
  const Product(
    id: '2',
    name: 'Maize Flour (Grade 1)',
    category: 'Grains',
    price: 45.00,
    unit: '2kg bag',
    location: 'Eldoret, Kenya',
    sellerName: 'Rift Valley Millers',
    sellerId: 's2',
    rating: 4.8,
    reviewCount: 312,
  ),
  const Product(
    id: '3',
    name: 'Cooking Oil',
    category: 'Oils & Fats',
    price: 180.00,
    unit: '2L bottle',
    location: 'Mombasa, Kenya',
    sellerName: 'Coast Distributors',
    sellerId: 's3',
    rating: 4.2,
    reviewCount: 87,
  ),
  const Product(
    id: '4',
    name: 'Rice (Pishori)',
    category: 'Grains',
    price: 120.00,
    unit: '2kg',
    location: 'Kisumu, Kenya',
    sellerName: 'Lake Basin Traders',
    sellerId: 's4',
    rating: 4.6,
    reviewCount: 204,
  ),
  const Product(
    id: '5',
    name: 'Onions',
    category: 'Vegetables',
    price: 1.80,
    unit: 'kg',
    location: 'Nairobi, Kenya',
    sellerName: 'Green Farm Supplies',
    sellerId: 's1',
    rating: 4.3,
    reviewCount: 95,
  ),
  const Product(
    id: '6',
    name: 'Sugar (White)',
    category: 'Sweeteners',
    price: 95.00,
    unit: '2kg',
    location: 'Nakuru, Kenya',
    sellerName: 'Nakuru Wholesale',
    sellerId: 's5',
    rating: 4.7,
    reviewCount: 441,
  ),
];

final sampleSellers = [
  const Seller(
    id: 's1',
    name: 'Green Farm Supplies',
    location: 'Nairobi, Kenya',
    category: 'Fresh Produce',
    rating: 4.5,
    reviewCount: 223,
    isVerified: true,
    phone: '+254 700 000 001',
  ),
  const Seller(
    id: 's2',
    name: 'Rift Valley Millers',
    location: 'Eldoret, Kenya',
    category: 'Grains & Flour',
    rating: 4.8,
    reviewCount: 312,
    isVerified: true,
    phone: '+254 700 000 002',
  ),
  const Seller(
    id: 's3',
    name: 'Coast Distributors',
    location: 'Mombasa, Kenya',
    category: 'Oils & Commodities',
    rating: 4.2,
    reviewCount: 87,
    isVerified: false,
    phone: '+254 700 000 003',
  ),
  const Seller(
    id: 's4',
    name: 'Lake Basin Traders',
    location: 'Kisumu, Kenya',
    category: 'Grains & Rice',
    rating: 4.6,
    reviewCount: 204,
    isVerified: true,
    phone: '+254 700 000 004',
  ),
];
