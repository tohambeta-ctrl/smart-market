/// Roles a registered user can hold.
enum UserRole { buyer, seller }

/// Lightweight in-memory user model.
/// Replace fields / persistence once a real backend is wired up.
class AppUser {
  final String id;
  final String name;
  final String emailOrPhone;
  final UserRole role;

  const AppUser({
    required this.id,
    required this.name,
    required this.emailOrPhone,
    required this.role,
  });
}

// ─────────────────────────────────────────────────────────────────────────────

class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final double? originalPrice;
  final String unit;
  final String location;
  final String sellerName;
  final String sellerId;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final bool isFeatured;
  final String description;
  final List<ProductSpec> specs;

  /// Additional image URLs beyond the primary one.
  /// These are doodle placeholders for now (empty string = generate doodle).
  final List<String> extraImages;

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
    this.description = '',
    this.specs = const [],
    this.extraImages = const [],
  });

  bool get isOnSale => originalPrice != null && originalPrice! > price;
}

class ProductSpec {
  final String label;
  final String value;
  const ProductSpec(this.label, this.value);
}

class ProductReview {
  final String id;
  final String productId;
  final String reviewerName;
  final double rating;
  final String comment;
  final DateTime date;

  const ProductReview({
    required this.id,
    required this.productId,
    required this.reviewerName,
    required this.rating,
    required this.comment,
    required this.date,
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
