import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/sellers_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/seller_profile_screen.dart';

void main() => runApp(const SmartMarketApp());

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => _ScaffoldWithNav(child: child),
      routes: [
        GoRoute(path: '/', builder: (context, route) => const HomeScreen()),
        GoRoute(path: '/search', builder: (context, route) => const SearchScreen()),
        GoRoute(path: '/sellers', builder: (context, route) => const SellersScreen()),
      ],
    ),
    GoRoute(
      path: '/product/:id',
      builder: (_, state) => ProductDetailScreen(productId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/seller/:id',
      builder: (_, state) => SellerProfileScreen(sellerId: state.pathParameters['id']!),
    ),
  ],
);

class SmartMarketApp extends StatelessWidget {
  const SmartMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Smart Market',
      theme: AppTheme.light,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class _ScaffoldWithNav extends StatelessWidget {
  final Widget child;
  const _ScaffoldWithNav({required this.child});

  static const _tabs = ['/', '/search', '/sellers'];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final idx = _tabs.indexWhere((t) => t == location);
    return idx < 0 ? 0 : idx;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex(context),
        onDestinationSelected: (i) => context.go(_tabs[i]),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Market'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.storefront_outlined), selectedIcon: Icon(Icons.storefront), label: 'Sellers'),
        ],
      ),
    );
  }
}
