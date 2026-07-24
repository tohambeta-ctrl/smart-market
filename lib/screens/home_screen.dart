import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_market/l10n/app_localizations.dart';
import '../main.dart' show localeNotifier, requireAuth;
import '../models/models.dart';
import '../models/mock_data.dart';
import '../screens/auth_screen.dart' show AuthTab;
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
              child: PromoBannerCard(
                title: l.homeBannerTitle,
                ctaLabel: l.homeBannerCta,
                onCtaTap: () {},
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
                childAspectRatio: 0.65,
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
                onTap: () => requireAuth(
                  context,
                  tab: AuthTab.signUp,
                  role: UserRole.seller,
                ),
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
