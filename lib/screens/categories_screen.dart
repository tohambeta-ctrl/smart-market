import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_market/l10n/app_localizations.dart';
import '../models/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/cards.dart';
import '../widgets/sm_search_bar.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const _categories = [
    _CategoryItem('Electronics', Icons.devices_outlined, AppColors.info),
    _CategoryItem('Fashion', Icons.checkroom_outlined, Color(0xFF7B1FA2)),
    _CategoryItem('Home', Icons.home_outlined, AppColors.warning),
    _CategoryItem('Sports', Icons.sports_basketball_outlined, AppColors.error),
    _CategoryItem('Beauty', Icons.spa_outlined, Color(0xFFE91E63)),
    _CategoryItem(
      'Food',
      Icons.local_grocery_store_outlined,
      AppColors.success,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(l.appTitle)),
      body: CustomScrollView(
        slivers: [
          // ── Search bar ───────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: SmSearchBar(
                hint: l.categoriesSearchHint,
                readOnly: true,
                onTap: () => context.push('/search'),
              ),
            ),
          ),
          // ── Promo banner ─────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: PromoBannerCard(
                badge: l.categoriesBannerBadge,
                title: l.categoriesBannerTitle,
                ctaLabel: l.categoriesShopNow,
                onCtaTap: () {},
              ),
            ),
          ),
          // ── "Explore Categories" heading ─────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            sliver: SliverToBoxAdapter(
              child: Text(
                l.categoriesExplore,
                style: AppTextStyles.titleMedium,
              ),
            ),
          ),
          // ── Category grid ────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, i) => _CategoryTile(item: _categories[i]),
                childCount: _categories.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.4,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Text(l.homeRecommended, style: AppTextStyles.titleMedium),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SellerCard(
                    seller: sampleSellers[i],
                    onTap: () => context.go('/seller/${sampleSellers[i].id}'),
                  ),
                ),
                childCount: sampleSellers.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _CategoryItem {
  const _CategoryItem(this.label, this.icon, this.color);
  final String label;
  final IconData icon;
  final Color color;
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.item});
  final _CategoryItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.neutral200),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: item.color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(item.icon, color: item.color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              item.label,
              style: AppTextStyles.labelMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
