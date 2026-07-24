import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_market/l10n/app_localizations.dart';
import '../main.dart' show requireAuth;
import '../models/models.dart';
import '../models/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/sm_button.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});
  final String productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _activeImage = 0;
  bool _descExpanded = false;
  late final PageController _pageCtrl;

  @override
  void initState() {
    super.initState();
    _pageCtrl = PageController();
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final product = sampleProducts.firstWhere(
      (p) => p.id == widget.productId,
      orElse: () => sampleProducts.first,
    );
    final reviews = sampleReviews
        .where((r) => r.productId == widget.productId)
        .toList();
    final similar = sampleProducts
        .where((p) => p.category == product.category && p.id != product.id)
        .toList();

    // All images: primary + extras
    final allImages = [product.imageUrl, ...product.extraImages];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Scrollable body ──────────────────────────────────────────────
          CustomScrollView(
            slivers: [
              // Image gallery app bar
              SliverToBoxAdapter(
                child: _ImageGallery(
                  images: allImages,
                  activeIndex: _activeImage,
                  pageCtrl: _pageCtrl,
                  category: product.category,
                  onPageChanged: (i) => setState(() => _activeImage = i),
                  onBack: () => context.go('/'),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // ── Price + title ──────────────────────────────────────
                    _PriceHeader(product: product, l: l),
                    const SizedBox(height: 16),

                    // ── Seller row ─────────────────────────────────────────
                    _SellerRow(product: product, l: l),
                    const SizedBox(height: 20),

                    // ── Description ────────────────────────────────────────
                    if (product.description.isNotEmpty) ...[
                      _SectionHeader(
                        product.description.isNotEmpty
                            ? l.productDescription
                            : '',
                      ),
                      const SizedBox(height: 8),
                      _ExpandableText(
                        text: product.description,
                        expanded: _descExpanded,
                        onToggle: () =>
                            setState(() => _descExpanded = !_descExpanded),
                        readMoreLabel: l.productReadMore,
                        readLessLabel: l.productReadLess,
                      ),
                      const SizedBox(height: 20),
                    ],

                    // ── Specifications ─────────────────────────────────────
                    if (product.specs.isNotEmpty) ...[
                      _SectionHeader(l.productSpecifications),
                      const SizedBox(height: 8),
                      _SpecsTable(specs: product.specs),
                      const SizedBox(height: 20),
                    ],

                    // ── Reviews ────────────────────────────────────────────
                    _SectionHeader(l.productReviewsTitle),
                    const SizedBox(height: 8),
                    _RatingSummary(product: product),
                    const SizedBox(height: 12),
                    if (reviews.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          l.productNoReviews,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.neutral600,
                          ),
                        ),
                      )
                    else ...[
                      ...reviews.take(3).map((r) => _ReviewTile(review: r)),
                      if (reviews.length > 3)
                        Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              l.productAllReviews(reviews.length),
                              style: AppTextStyles.labelLarge.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                    ],
                    const SizedBox(height: 20),

                    // ── Price comparison ───────────────────────────────────
                    if (similar.isNotEmpty) ...[
                      _SectionHeader(l.productPriceComparison),
                      const SizedBox(height: 4),
                      Text(
                        l.productOtherSellers(product.category),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.neutral600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...similar.map(
                        (p) => _PriceCompareRow(current: product, other: p),
                      ),
                      const SizedBox(height: 8),
                    ],

                    // Space for bottom bar
                    const SizedBox(height: 90),
                  ]),
                ),
              ),
            ],
          ),

          // ── Fixed bottom action bar ──────────────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _BottomBar(product: product, l: l),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Image gallery with PageView + thumbnail strip + dot indicator
// ─────────────────────────────────────────────────────────────────────────────
class _ImageGallery extends StatelessWidget {
  const _ImageGallery({
    required this.images,
    required this.activeIndex,
    required this.pageCtrl,
    required this.category,
    required this.onPageChanged,
    required this.onBack,
  });

  final List<String> images;
  final int activeIndex;
  final PageController pageCtrl;
  final String category;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main pager
        SizedBox(
          height: 320,
          child: PageView.builder(
            controller: pageCtrl,
            itemCount: images.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, i) {
              final url = images[i];
              if (url.isEmpty) {
                return Container(
                  color: AppColors.primary50,
                  child: CustomPaint(
                    painter: _GalleryDoodlePainter(
                      category: category,
                      seed: i + 1,
                    ),
                  ),
                );
              }
              return CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                placeholder: (context, url2) => Container(
                  color: AppColors.primary50,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, url2, err) => Container(
                  color: AppColors.primary50,
                  child: CustomPaint(
                    painter: _GalleryDoodlePainter(
                      category: category,
                      seed: i + 1,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Back button
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 12,
          child: Material(
            color: Colors.white.withValues(alpha: 0.9),
            shape: const CircleBorder(),
            child: InkWell(
              onTap: onBack,
              customBorder: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: AppColors.neutral,
                ),
              ),
            ),
          ),
        ),

        // Wishlist button
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          right: 12,
          child: Material(
            color: Colors.white.withValues(alpha: 0.9),
            shape: const CircleBorder(),
            child: InkWell(
              onTap: () {},
              customBorder: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.favorite_border,
                  size: 20,
                  color: AppColors.neutral,
                ),
              ),
            ),
          ),
        ),

        // Dot + thumbnail strip at bottom
        Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: Column(
            children: [
              // Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (i) {
                  final active = i == activeIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: active ? 20 : 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: active
                          ? AppColors.primary
                          : Colors.white.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Doodle painter for extra gallery slots — each seed gives a different layout
// ─────────────────────────────────────────────────────────────────────────────
class _GalleryDoodlePainter extends CustomPainter {
  const _GalleryDoodlePainter({required this.category, required this.seed});
  final String category;
  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * (0.18 + seed * 0.04).clamp(0.18, 0.32);

    // Background accent circle
    canvas.drawCircle(
      Offset(cx + (seed.isEven ? 20.0 : -20.0), cy),
      r * 2.2,
      Paint()..color = AppColors.primary100,
    );

    // Category icon
    final icon = _iconFor(category);
    final tp = TextPainter(textDirection: TextDirection.ltr)
      ..text = TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: size.width * 0.22,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: AppColors.primary,
        ),
      )
      ..layout();
    tp.paint(canvas, Offset(cx - tp.width / 2, cy - tp.height / 2));

    // Corner accents vary by seed
    final dot = Paint()..color = AppColors.primary300;
    canvas.drawCircle(
      Offset(
        size.width * (seed.isOdd ? 0.12 : 0.85),
        size.height * (seed % 3 == 0 ? 0.15 : 0.80),
      ),
      6,
      dot,
    );
    canvas.drawCircle(
      Offset(
        size.width * (seed.isEven ? 0.15 : 0.82),
        size.height * (seed % 2 == 0 ? 0.78 : 0.18),
      ),
      4,
      dot..color = AppColors.flagYellow,
    );

    // Small outline circle
    canvas.drawCircle(
      Offset(size.width * 0.78, cy),
      18,
      Paint()
        ..color = AppColors.primary200
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  IconData _iconFor(String cat) {
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
  bool shouldRepaint(covariant _GalleryDoodlePainter old) =>
      old.category != category || old.seed != seed;
}

// ─────────────────────────────────────────────────────────────────────────────
// Price + title header
// ─────────────────────────────────────────────────────────────────────────────
class _PriceHeader extends StatelessWidget {
  const _PriceHeader({required this.product, required this.l});
  final Product product;
  final AppLocalizations l;

  String _fmt(double v) {
    final s = v.toStringAsFixed(0);
    final buf = StringBuffer();
    final chars = s.split('').reversed.toList();
    for (var i = 0; i < chars.length; i++) {
      if (i > 0 && i % 3 == 0) buf.write(',');
      buf.write(chars[i]);
    }
    return buf.toString().split('').reversed.join();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary50,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            product.category.toUpperCase(),
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Name
        Text(product.name, style: AppTextStyles.headlineSmall),
        const SizedBox(height: 10),

        // Price row
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${_fmt(product.price)} XAF',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
                fontSize: 24,
              ),
            ),
            const SizedBox(width: 8),
            if (product.isOnSale) ...[
              Text(
                '${_fmt(product.originalPrice!)} XAF',
                style: AppTextStyles.bodyMedium.copyWith(
                  decoration: TextDecoration.lineThrough,
                  color: AppColors.neutral400,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '-${(((product.originalPrice! - product.price) / product.originalPrice!) * 100).round()}%',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
            const Spacer(),
            // Star + count
            const Icon(Icons.star_rounded, color: Color(0xFFFFC107), size: 18),
            const SizedBox(width: 3),
            Text(
              '${product.rating}',
              style: AppTextStyles.labelLarge.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 4),
            Text('(${product.reviewCount})', style: AppTextStyles.bodySmall),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          l.productPer(product.unit),
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.neutral600),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Seller row
// ─────────────────────────────────────────────────────────────────────────────
class _SellerRow extends StatelessWidget {
  const _SellerRow({required this.product, required this.l});
  final Product product;
  final AppLocalizations l;

  @override
  Widget build(BuildContext context) {
    final seller = sampleSellers.firstWhere(
      (s) => s.id == product.sellerId,
      orElse: () => sampleSellers.first,
    );
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primary50,
            child: Text(
              seller.name[0],
              style: AppTextStyles.titleSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(seller.name, style: AppTextStyles.titleSmall),
                    if (seller.isVerified) ...[
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.verified,
                        size: 14,
                        color: AppColors.primary,
                      ),
                    ],
                  ],
                ),
                Text(
                  seller.location,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.neutral600,
                  ),
                ),
              ],
            ),
          ),
          SmButton.outlined(
            label: l.productViewSellerProfile,
            onPressed: () => context.go('/seller/${seller.id}'),
            size: SmButtonSize.small,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section header
// ─────────────────────────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTextStyles.titleMedium);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Expandable description text
// ─────────────────────────────────────────────────────────────────────────────
class _ExpandableText extends StatelessWidget {
  const _ExpandableText({
    required this.text,
    required this.expanded,
    required this.onToggle,
    required this.readMoreLabel,
    required this.readLessLabel,
  });

  final String text;
  final bool expanded;
  final VoidCallback onToggle;
  final String readMoreLabel;
  final String readLessLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          maxLines: expanded ? null : 3,
          overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.neutral800,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: onToggle,
          child: Text(
            expanded ? readLessLabel : readMoreLabel,
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Specifications table
// ─────────────────────────────────────────────────────────────────────────────
class _SpecsTable extends StatelessWidget {
  const _SpecsTable({required this.specs});
  final List<ProductSpec> specs;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        children: List.generate(specs.length, (i) {
          final spec = specs[i];
          final isLast = i == specs.length - 1;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 11,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 130,
                      child: Text(
                        spec.label,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.neutral600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        spec.value,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                const Divider(
                  height: 1,
                  indent: 14,
                  color: AppColors.neutral200,
                ),
            ],
          );
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Rating summary bar chart
// ─────────────────────────────────────────────────────────────────────────────
class _RatingSummary extends StatelessWidget {
  const _RatingSummary({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Row(
        children: [
          // Big score
          Column(
            children: [
              Text(
                product.rating.toStringAsFixed(1),
                style: AppTextStyles.displaySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: 44,
                ),
              ),
              Row(
                children: List.generate(5, (i) {
                  final full = i < product.rating.floor();
                  final half = !full && i < product.rating;
                  return Icon(
                    full
                        ? Icons.star_rounded
                        : half
                        ? Icons.star_half_rounded
                        : Icons.star_outline_rounded,
                    size: 16,
                    color: const Color(0xFFFFC107),
                  );
                }),
              ),
              const SizedBox(height: 2),
              Text(
                '${product.reviewCount} reviews',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
          const SizedBox(width: 20),
          // Distribution bars (mock distribution)
          Expanded(
            child: Column(
              children: List.generate(5, (i) {
                final star = 5 - i;
                // Mock fill percentages per star
                const fills = [0.65, 0.20, 0.08, 0.04, 0.03];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Text('$star', style: AppTextStyles.labelSmall),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.star_rounded,
                        size: 11,
                        color: Color(0xFFFFC107),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: fills[i],
                            minHeight: 7,
                            backgroundColor: AppColors.neutral200,
                            valueColor: const AlwaysStoppedAnimation(
                              AppColors.primary400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Single review tile
// ─────────────────────────────────────────────────────────────────────────────
class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.review});
  final ProductReview review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.neutral200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.primary50,
                  child: Text(
                    review.reviewerName[0],
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    review.reviewerName,
                    style: AppTextStyles.titleSmall,
                  ),
                ),
                // Stars
                Row(
                  children: List.generate(
                    5,
                    (i) => Icon(
                      i < review.rating.round()
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      size: 14,
                      color: const Color(0xFFFFC107),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review.comment,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.neutral800,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${review.date.day}/${review.date.month}/${review.date.year}',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.neutral400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Price comparison row (unchanged logic, updated styles)
// ─────────────────────────────────────────────────────────────────────────────
class _PriceCompareRow extends StatelessWidget {
  const _PriceCompareRow({required this.current, required this.other});
  final Product current;
  final Product other;

  @override
  Widget build(BuildContext context) {
    final isCheaper = other.price < current.price;
    final diff = ((other.price - current.price) / current.price * 100).abs();
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  other.sellerName,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  other.location,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.neutral600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${other.price.toStringAsFixed(0)} XAF',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isCheaper
                      ? AppColors.success.withValues(alpha: 0.1)
                      : AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${isCheaper ? '↓' : '↑'} ${diff.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 11,
                    color: isCheaper ? AppColors.success : AppColors.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Fixed bottom action bar
// ─────────────────────────────────────────────────────────────────────────────
class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.product, required this.l});
  final Product product;
  final AppLocalizations l;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        12 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.neutral200)),
      ),
      child: Row(
        children: [
          // Add to Cart icon button — requires auth
          GestureDetector(
            onTap: () => requireAuth(context),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.primary,
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Buy Now — requires auth
          Expanded(
            child: SmButton.primary(
              label: l.productBuyNow,
              onPressed: () => requireAuth(context),
              expanded: true,
              size: SmButtonSize.large,
            ),
          ),
        ],
      ),
    );
  }
}
