import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_market/l10n/app_localizations.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/sellers_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/seller_profile_screen.dart';
import 'screens/splash_screen.dart';

void main() => runApp(const SmartMarketApp());

final _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, _) => const SplashScreen()),
    ShellRoute(
      builder: (context, state, child) => _ScaffoldWithNav(child: child),
      routes: [
        GoRoute(path: '/', builder: (context, route) => const HomeScreen()),
        GoRoute(
          path: '/search',
          builder: (context, route) => const SearchScreen(),
        ),
        GoRoute(
          path: '/sellers',
          builder: (context, route) => const SellersScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/product/:id',
      builder: (_, state) =>
          ProductDetailScreen(productId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/seller/:id',
      builder: (_, state) =>
          SellerProfileScreen(sellerId: state.pathParameters['id']!),
    ),
  ],
);

// Global notifier so any widget can trigger a locale switch.
final localeNotifier = ValueNotifier<Locale>(const Locale('en'));

class SmartMarketApp extends StatelessWidget {
  const SmartMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (context, locale, _) {
        return MaterialApp.router(
          title: 'Smart Market',
          theme: AppTheme.light,
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
          locale: locale,
          supportedLocales: const [Locale('en'), Locale('fr')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
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
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex(context),
        onDestinationSelected: (i) => context.go(_tabs[i]),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: l.navMarket,
          ),
          NavigationDestination(
            icon: const Icon(Icons.search),
            label: l.navSearch,
          ),
          NavigationDestination(
            icon: const Icon(Icons.storefront_outlined),
            selectedIcon: const Icon(Icons.storefront),
            label: l.navSellers,
          ),
        ],
      ),
    );
  }
}
