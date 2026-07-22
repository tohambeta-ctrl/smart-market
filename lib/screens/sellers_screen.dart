import 'package:flutter/material.dart';
import 'package:smart_market/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../models/models.dart';
import '../widgets/cards.dart';

class SellersScreen extends StatefulWidget {
  const SellersScreen({super.key});

  @override
  State<SellersScreen> createState() => _SellersScreenState();
}

class _SellersScreenState extends State<SellersScreen> {
  bool _verifiedOnly = false;

  List<Seller> get _filtered => _verifiedOnly
      ? sampleSellers.where((s) => s.isVerified).toList()
      : sampleSellers;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l.sellersTitle),
        actions: [
          Row(
            children: [
              Text(
                l.sellersVerified,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 13,
                ),
              ),
              Switch(
                value: _verifiedOnly,
                onChanged: (v) => setState(() => _verifiedOnly = v),
                activeThumbColor: Colors.white,
                activeTrackColor: theme.colorScheme.secondary,
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              children: [
                Text(
                  l.sellersFoundCount(_filtered.length),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _filtered.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, i) => SellerCard(
                seller: _filtered[i],
                onTap: () => context.go('/seller/${_filtered[i].id}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
