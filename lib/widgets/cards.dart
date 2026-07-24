import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smart_market/l10n/app_localizations.dart';
import '../main.dart' show requireAuth;
import '../models/models.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ProductCard — matches the screenshot design:
//   • Network image top half (CachedNetworkImage with doodle fallback)
//   • SALE badge when isOnSale
//   • Wishlist heart top-right
//   • Category label (small caps)
//   • Product name
//   • Price + optional strikethrough original
//   • Cart icon button
// ─────────────────────────────────────────────────────────────────────────────
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
  });

  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.neutral200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image section ─────────────────────────────────────────────
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(14),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          _ProductImagePlaceholder(category: product.category),
                      errorWidget: (context, url, error) =>
                          _ProductImagePlaceholder(category: product.category),
                    ),
                  ),

                  // SALE badge
                  if (product.isOnSale)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          l.homeSaleBadge,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),

                  // Wishlist heart — requires auth
                  Positioned(
                    top: 6,
                    right: 6,
                    child: GestureDetector(
                      onTap: () => requireAuth(context),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.92),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.favorite_border,
                          size: 16,
                          color: AppColors.neutral600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Info section ──────────────────────────────────────────────
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Category
                    Text(
                      product.category.toUpperCase(),
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.neutral600,
                        letterSpacing: 0.6,
                        fontSize: 10,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),

                    // Star rating
                    Row(
                      children: [
                        ...List.generate(5, (i) {
                          final full = i < product.rating.floor();
                          final half = !full && i < product.rating;
                          return Icon(
                            full
                                ? Icons.star_rounded
                                : half
                                ? Icons.star_half_rounded
                                : Icons.star_outline_rounded,
                            size: 11,
                            color: const Color(0xFFFFC107),
                          );
                        }),
                        const SizedBox(width: 3),
                        Text(
                          product.rating.toStringAsFixed(1),
                          style: AppTextStyles.labelSmall.copyWith(
                            fontSize: 10,
                            color: AppColors.neutral600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),

                    // Name
                    Text(
                      product.name,
                      style: AppTextStyles.titleSmall.copyWith(
                        fontSize: 12,
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Price row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Current price
                              Text(
                                '${_formatPrice(product.price)} FCFA',
                                style: AppTextStyles.titleSmall.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                ),
                              ),
                              // Original price (strikethrough)
                              if (product.isOnSale)
                                Text(
                                  '${_formatPrice(product.originalPrice!)} FCFA',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: AppColors.neutral400,
                                    fontSize: 10,
                                  ),
                                ),
                            ],
                          ),
                        ),

                        // Cart button — requires auth
                        GestureDetector(
                          onTap: () => requireAuth(context),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.shopping_basket_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    if (price >= 1000) {
      final formatted = price.toStringAsFixed(0);
      // Insert thousands separator
      final buf = StringBuffer();
      final chars = formatted.split('').reversed.toList();
      for (var i = 0; i < chars.length; i++) {
        if (i > 0 && i % 3 == 0) buf.write(',');
        buf.write(chars[i]);
      }
      return buf.toString().split('').reversed.join();
    }
    return price.toStringAsFixed(0);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Doodle placeholder shown while image loads or on error
// ─────────────────────────────────────────────────────────────────────────────
class _ProductImagePlaceholder extends StatelessWidget {
  const _ProductImagePlaceholder({required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary50,
      child: CustomPaint(
        painter: _DoodlePainter(category: category),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _DoodlePainter extends CustomPainter {
  const _DoodlePainter({required this.category});

  final String category;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Soft background circle
    canvas.drawCircle(
      Offset(cx, cy),
      size.width * 0.32,
      Paint()..color = AppColors.primary100,
    );

    final icon = _iconForCategory(category);
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontSize: size.width * 0.28,
        fontFamily: icon.fontFamily,
        package: icon.fontPackage,
        color: AppColors.primary,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(cx - textPainter.width / 2, cy - textPainter.height / 2),
    );

    // Small accent dots
    final dot = Paint()..color = AppColors.primary200;
    canvas.drawCircle(Offset(size.width * 0.15, size.height * 0.2), 4, dot);
    canvas.drawCircle(Offset(size.width * 0.82, size.height * 0.75), 5, dot);
    canvas.drawCircle(
      Offset(size.width * 0.78, size.height * 0.18),
      3,
      dot..color = AppColors.primary300,
    );
  }

  IconData _iconForCategory(String cat) {
    switch (cat.toLowerCase()) {
      case 'electronics':
        return Icons.devices_outlined;
      case 'fashion':
        return Icons.checkroom_outlined;
      case 'home':
        return Icons.home_outlined;
      case 'sports':
        return Icons.sports_basketball_outlined;
      case 'beauty':
        return Icons.spa_outlined;
      case 'food':
        return Icons.local_grocery_store_outlined;
      default:
        return Icons.inventory_2_outlined;
    }
  }

  @override
  bool shouldRepaint(covariant _DoodlePainter old) => old.category != category;
}

// ─────────────────────────────────────────────────────────────────────────────
// SellerCard — unchanged layout, updated to use design tokens
// ─────────────────────────────────────────────────────────────────────────────
class SellerCard extends StatelessWidget {
  const SellerCard({super.key, required this.seller, this.onTap});

  final Seller seller;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primary50,
                child: Text(
                  seller.name[0],
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            seller.name,
                            style: AppTextStyles.titleSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (seller.isVerified)
                          const Icon(
                            Icons.verified,
                            size: 16,
                            color: AppColors.primary,
                          ),
                      ],
                    ),
                    Text(seller.category, style: AppTextStyles.bodySmall),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 12,
                          color: AppColors.neutral600,
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            seller.location,
                            style: AppTextStyles.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(
                          Icons.star,
                          size: 12,
                          color: Color(0xFFFFC107),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${seller.rating} (${seller.reviewCount})',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: AppColors.neutral400),
            ],
          ),
        ),
      ),
    );
  }
}
