import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_market/l10n/app_localizations.dart';
import '../main.dart' show localeNotifier;
import '../models/mock_data.dart';
import '../models/models.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/cards.dart';
import '../widgets/sm_button.dart';
import '../widgets/sm_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategoryKey = 'all';

  static const _categoryKeys = [
    'all',
    'electronics',
    'fashion',
    'home',
    'sports',
    'beauty',
    'food',
  ];

  static const _categoryDataValue = {
    'all': 'All',
    'electronics': 'Electronics',
    'fashion': 'Fashion',
    'home': 'Home',
    'sports': 'Sports',
    'beauty': 'Beauty',
    'food': 'Food',
  };

  String _categoryLabel(AppLocalizations l, String key) {
    switch (key) {
      case 'electronics':
        return 'Electronics';
      case 'fashion':
        return 'Fashion';
      case 'home':
        return 'Home';
      case 'sports':
        return 'Sports';
      case 'beauty':
        return 'Beauty';
      case 'food':
        return 'Food';
      default:
        return l.homeCategoryAll;
    }
  }

  List<Product> get _filtered {
    final val = _categoryDataValue[_selectedCategoryKey]!;
    return val == 'All'
        ? sampleProducts
        : sampleProducts.where((p) => p.category == val).toList();
  }

  void _toggleLocale() {
    localeNotifier.value = localeNotifier.value.languageCode == 'en'
        ? const Locale('fr')
        : const Locale('en');
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l.appTitle),
        actions: [
          TextButton(
            onPressed: _toggleLocale,
            child: Text(
              l.languageToggleLabel,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // ── Search bar ──────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: SmSearchBar(
                hint: l.homeSearchHint,
                readOnly: true,
                onTap: () => context.go('/search'),
              ),
            ),
          ),

          // ── Category chips ──────────────────────────────────────────────
          SliverToBoxAdapter(
            child: SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                itemCount: _categoryKeys.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final key = _categoryKeys[i];
                  final selected = key == _selectedCategoryKey;
                  return ChoiceChip(
                    label: Text(_categoryLabel(l, key)),
                    selected: selected,
                    onSelected: (_) =>
                        setState(() => _selectedCategoryKey = key),
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.surface,
                    side: BorderSide(
                      color: selected
                          ? AppColors.primary
                          : AppColors.neutral200,
                    ),
                    labelStyle: AppTextStyles.labelMedium.copyWith(
                      color: selected ? Colors.white : AppColors.neutral,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                  );
                },
              ),
            ),
          ),

          // ── Banner hero ─────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: _BannerCard(
                title: l.homeBannerTitle,
                subtitle: l.homeBannerSubtitle,
              ),
            ),
          ),

          // ── "Recommended for You" header ────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l.homeRecommended,
                      style: AppTextStyles.titleMedium,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          l.homeViewAll,
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(
                          Icons.arrow_forward,
                          size: 14,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Product grid ────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, i) => ProductCard(
                  product: _filtered[i],
                  onTap: () => context.go('/product/${_filtered[i].id}'),
                  onAddToCart: () {},
                ),
                childCount: _filtered.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
            ),
          ),

          // ── Sell CTA section ────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: _SellCtaCard(
                title: l.homeSellTitle,
                body: l.homeSellBody,
                ctaLabel: l.homeSellCta,
                onTap: () => context.go('/sell'),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Banner hero card with doodle background painter
// ─────────────────────────────────────────────────────────────────────────────
class _BannerCard extends StatelessWidget {
  const _BannerCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 160,
        child: Stack(
          children: [
            // Doodle background
            Positioned.fill(child: CustomPaint(painter: _BannerPainter())),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.88),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BannerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Green gradient base
    final grad = Paint()
      ..shader = const LinearGradient(
        colors: [AppColors.primary, AppColors.primary600],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), grad);

    // Decorative circles (right side illustration feel)
    final light = Paint()..color = Colors.white.withValues(alpha: 0.07);
    canvas.drawCircle(Offset(size.width * 0.78, size.height * 0.2), 90, light);
    canvas.drawCircle(Offset(size.width * 0.92, size.height * 0.85), 60, light);

    // Doodle product icon (right side)
    final iconArea = Offset(size.width * 0.75, size.height * 0.5);
    _drawShoppingBag(canvas, iconArea, 52);

    // Small accent stars
    _drawStar(
      canvas,
      Offset(size.width * 0.62, size.height * 0.18),
      7,
      Colors.white.withValues(alpha: 0.5),
    );
    _drawStar(
      canvas,
      Offset(size.width * 0.88, size.height * 0.30),
      5,
      Colors.white.withValues(alpha: 0.4),
    );
  }

  void _drawShoppingBag(Canvas canvas, Offset center, double size) {
    final p = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;
    final stroke = Paint()
      ..color = Colors.white.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Bag body
    final body = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center + Offset(0, size * 0.1),
        width: size,
        height: size * 0.8,
      ),
      const Radius.circular(10),
    );
    canvas.drawRRect(body, p);
    canvas.drawRRect(body, stroke);

    // Handle
    final handlePath = Path()
      ..moveTo(center.dx - size * 0.22, center.dy - size * 0.28)
      ..cubicTo(
        center.dx - size * 0.22,
        center.dy - size * 0.62,
        center.dx + size * 0.22,
        center.dy - size * 0.62,
        center.dx + size * 0.22,
        center.dy - size * 0.28,
      );
    canvas.drawPath(handlePath, stroke);
  }

  void _drawStar(Canvas canvas, Offset center, double size, Color color) {
    final p = Paint()..color = color;
    final path = Path();
    for (var i = 0; i < 4; i++) {
      final angle = i * 3.14159 / 2;
      final ox = center.dx + size * _cos(angle);
      final oy = center.dy + size * _sin(angle);
      final ia = angle + 3.14159 / 4;
      final ix = center.dx + size * 0.4 * _cos(ia);
      final iy = center.dy + size * 0.4 * _sin(ia);
      if (i == 0) {
        path.moveTo(ox, oy);
      } else {
        path.lineTo(ox, oy);
      }
      path.lineTo(ix, iy);
    }
    path.close();
    canvas.drawPath(path, p);
  }

  double _cos(double x) {
    x = x % (2 * 3.14159265);
    double r = 1, t = 1;
    for (var i = 1; i <= 8; i++) {
      t *= -x * x / ((2 * i - 1) * (2 * i));
      r += t;
    }
    return r;
  }

  double _sin(double x) {
    x = x % (2 * 3.14159265);
    double r = x, t = x;
    for (var i = 1; i <= 8; i++) {
      t *= -x * x / ((2 * i) * (2 * i + 1));
      r += t;
    }
    return r;
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Sell CTA card
// ─────────────────────────────────────────────────────────────────────────────
class _SellCtaCard extends StatelessWidget {
  const _SellCtaCard({
    required this.title,
    required this.body,
    required this.ctaLabel,
    required this.onTap,
  });

  final String title;
  final String body;
  final String ctaLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary100),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.neutral600,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          SmButton.primary(
            label: ctaLabel,
            onPressed: onTap,
            size: SmButtonSize.medium,
          ),
        ],
      ),
    );
  }
}
