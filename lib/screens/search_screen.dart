import 'package:flutter/material.dart';
import 'package:smart_market/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../models/models.dart';
import '../models/mock_data.dart';
import '../widgets/cards.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  String _query = '';

  List<Product> get _results => _query.isEmpty
      ? []
      : sampleProducts
            .where(
              (p) =>
                  p.name.toLowerCase().contains(_query.toLowerCase()) ||
                  p.category.toLowerCase().contains(_query.toLowerCase()),
            )
            .toList();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: l.searchHint,
            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
            filled: false,
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (v) => setState(() => _query = v),
        ),
        actions: [
          if (_query.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                setState(() => _query = '');
              },
            ),
        ],
      ),
      body: _query.isEmpty
          ? _buildEmptyState(l, theme)
          : _results.isEmpty
          ? _buildNoResults(l, theme)
          : _buildResults(l),
    );
  }

  Widget _buildEmptyState(AppLocalizations l, ThemeData theme) {
    final suggestions = [
      l.searchSuggestionTomatoes,
      l.searchSuggestionMaizeFlour,
      l.searchSuggestionRice,
      l.searchSuggestionSugar,
      l.searchSuggestionCookingOil,
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.searchPopularSearches,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: suggestions
                .map(
                  (s) => ActionChip(
                    label: Text(s),
                    onPressed: () {
                      _controller.text = s;
                      setState(() => _query = s);
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults(AppLocalizations l, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 12),
          Text(
            l.searchNoResults(_query),
            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildResults(AppLocalizations l) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Text(
            l.searchResultCount(_results.length, _query),
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: _results.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, i) => ProductCard(
              product: _results[i],
              onTap: () => context.go('/product/${_results[i].id}'),
            ),
          ),
        ),
      ],
    );
  }
}
