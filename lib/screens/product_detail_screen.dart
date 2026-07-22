import 'package:flutter/material.dart';
import 'package:smart_market/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../models/models.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final product = sampleProducts.firstWhere(
      (p) => p.id == productId,
      orElse: () => sampleProducts.first,
    );
    final similar = sampleProducts
        .where((p) => p.category == product.category && p.id != product.id)
        .toList();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        leading: BackButton(onPressed: () => context.go('/')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Price hero
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.category,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'XAF ${product.price.toStringAsFixed(0)}',
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  l.productPer(product.unit),
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Seller info
          _SectionTitle(l.productSellerInfo),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _InfoRow(
                    Icons.storefront_outlined,
                    l.productSeller,
                    product.sellerName,
                  ),
                  const Divider(height: 20),
                  _InfoRow(
                    Icons.location_on_outlined,
                    l.productLocation,
                    product.location,
                  ),
                  const Divider(height: 20),
                  _InfoRow(
                    Icons.star_outline,
                    l.productRating,
                    '${product.rating} (${l.productReviews(product.reviewCount)})',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Price comparison
          if (similar.isNotEmpty) ...[
            _SectionTitle(l.productPriceComparison),
            Text(
              l.productOtherSellers(product.category),
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            ...similar.map((p) => _PriceCompareRow(current: product, other: p)),
            const SizedBox(height: 16),
          ],

          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                final seller = sampleSellers.firstWhere(
                  (s) => s.id == product.sellerId,
                  orElse: () => sampleSellers.first,
                );
                context.go('/seller/${seller.id}');
              },
              icon: const Icon(Icons.person_outline),
              label: Text(l.productViewSellerProfile),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.phone_outlined),
              label: Text(l.productContactSeller),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _PriceCompareRow extends StatelessWidget {
  final Product current;
  final Product other;
  const _PriceCompareRow({required this.current, required this.other});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCheaper = other.price < current.price;
    final diff = ((other.price - current.price) / current.price * 100).abs();

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    other.sellerName,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    other.location,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'XAF ${other.price.toStringAsFixed(0)}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isCheaper
                        ? Colors.green.shade50
                        : Colors.red.shade50,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${isCheaper ? '↓' : '↑'} ${diff.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: 11,
                      color: isCheaper
                          ? Colors.green.shade700
                          : Colors.red.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
