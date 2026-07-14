import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/models.dart';
import '../widgets/cards.dart';

class SellerProfileScreen extends StatelessWidget {
  final String sellerId;

  const SellerProfileScreen({super.key, required this.sellerId});

  @override
  Widget build(BuildContext context) {
    final seller = sampleSellers.firstWhere(
      (s) => s.id == sellerId,
      orElse: () => sampleSellers.first,
    );
    final products = sampleProducts.where((p) => p.sellerId == sellerId).toList();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(seller.name),
        leading: BackButton(onPressed: () => context.go('/sellers')),
      ),
      body: ListView(
        children: [
          // Header
          Container(
            color: theme.colorScheme.primary,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  child: Text(
                    seller.name[0],
                    style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(seller.name, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    if (seller.isVerified) ...[
                      const SizedBox(width: 6),
                      const Icon(Icons.verified, color: Colors.white, size: 18),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(seller.category, style: TextStyle(color: Colors.white.withValues(alpha: 0.8))),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _StatChip(Icons.star, '${seller.rating}', 'Rating'),
                    const SizedBox(width: 16),
                    _StatChip(Icons.rate_review_outlined, '${seller.reviewCount}', 'Reviews'),
                    const SizedBox(width: 16),
                    _StatChip(Icons.inventory_2_outlined, '${products.length}', 'Products'),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Contact info
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _InfoTile(Icons.location_on_outlined, 'Location', seller.location),
                        const Divider(height: 20),
                        _InfoTile(Icons.phone_outlined, 'Phone', seller.phone),
                        if (seller.isVerified) ...[
                          const Divider(height: 20),
                          _InfoTile(Icons.verified_outlined, 'Status', 'Verified Seller'),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Contact button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.phone_outlined),
                    label: Text('Call ${seller.name}'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.message_outlined),
                    label: const Text('Send Message'),
                  ),
                ),
                const SizedBox(height: 20),

                // Products
                if (products.isNotEmpty) ...[
                  Text('Listed Products', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...products.map((p) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ProductCard(
                          product: p,
                          onTap: () => context.go('/product/${p.id}'),
                        ),
                      )),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _StatChip(this.icon, this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white, size: 14),
            const SizedBox(width: 4),
            Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
        Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11)),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoTile(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade600),
        const SizedBox(width: 10),
        Text('$label: ', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
        Expanded(child: Text(value, style: Theme.of(context).textTheme.bodyMedium, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
