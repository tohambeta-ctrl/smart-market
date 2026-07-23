class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final double? originalPrice; // non-null → show SALE badge
  final String unit;
  final String location;
  final String sellerName;
  final String sellerId;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final bool isFeatured;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.originalPrice,
    required this.unit,
    required this.location,
    required this.sellerName,
    required this.sellerId,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    this.isFeatured = false,
  });

  bool get isOnSale => originalPrice != null && originalPrice! > price;
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
