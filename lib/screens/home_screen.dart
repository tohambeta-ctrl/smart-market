import 'package:flutter/material.dart';
import 'package:smart_market/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../main.dart' show localeNotifier;
import '../models/models.dart';
import '../widgets/cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Key is the ARB category key; display label resolved at build time.
  String _selectedCategoryKey = 'all';

  static const _categoryKeys = [
    'all',
    'vegetables',
    'grains',
    'oilsFats',
    'sweeteners',
  ];

  String _categoryLabel(AppLocalizations l, String key) {
    switch (key) {
      case 'vegetables':
        return l.homeCategoryVegetables;
      case 'grains':
        return l.homeCategoryGrains;
      case 'oilsFats':
        return l.homeCategoryOilsFats;
      case 'sweeteners':
        return l.homeCategorySweeteners;
      default:
        return l.homeCategoryAll;
    }
  }

  // Map category key → original English value used in sample data
  static const _categoryDataValue = {
    'all': 'All',
    'vegetables': 'Vegetables',
    'grains': 'Grains',
    'oilsFats': 'Oils & Fats',
    'sweeteners': 'Sweeteners',
  };

  List<Product> _filtered() {
    final dataVal = _categoryDataValue[_selectedCategoryKey]!;
    return dataVal == 'All'
        ? sampleProducts
        : sampleProducts.where((p) => p.category == dataVal).toList();
  }

  void _toggleLocale() {
    localeNotifier.value = localeNotifier.value.languageCode == 'en'
        ? const Locale('fr')
        : const Locale('en');
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final filtered = _filtered();

    return Scaffold(
      appBar: AppBar(
        title: Text(l.appTitle),
        actions: [
          // Language toggle button
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: GestureDetector(
                onTap: () => context.go('/search'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey.shade500),
                      const SizedBox(width: 8),
                      Text(
                        l.homeSearchHint,
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    selectedColor: theme.colorScheme.primary,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : null,
                      fontWeight: selected ? FontWeight.w600 : null,
                    ),
                  );
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            sliver: SliverToBoxAdapter(
              child: Text(
                l.homeMarketPrices,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, i) => ProductCard(
                  product: filtered[i],
                  onTap: () => context.go('/product/${filtered[i].id}'),
                ),
                childCount: filtered.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.82,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }
}
