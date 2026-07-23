import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_market/l10n/app_localizations.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/sell_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/sellers_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/seller_profile_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'widgets/sm_bottom_nav.dart';

void main() => runApp(const SmartMarketApp());

// ── Routes ──────────────────────────────────────────────────────────────────
final _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, _) => const SplashScreen()),
    GoRoute(path: '/onboarding', builder: (context, _) => const OnboardingScreen()),
    GoRoute(path: '/search', builder: (context, _) => const _SearchRedirect()),

    // Main shell — 5-tab nav
    ShellRoute(
      builder: (context, state, child) => _ScaffoldWithNav(child: child),
      routes: [
        GoRoute(path: '/', builder: (context, _) => const HomeScreen()),
        GoRoute(
          path: '/categories',
          builder: (context, _) => const CategoriesScreen(),
        ),
        GoRoute(path: '/sell', builder: (context, _) => const SellScreen()),
        GoRoute(path: '/orders', builder: (context, _) => const OrdersScreen()),
        GoRoute(path: '/profile', builder: (context, _) => const ProfileScreen()),
        // Sellers stays accessible via category/profile deep links
        GoRoute(path: '/sellers', builder: (context, _) => const SellersScreen()),
      ],
    ),

    // Detail routes (outside shell — no bottom nav)
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

// ── Global locale notifier ───────────────────────────────────────────────────
final localeNotifier = ValueNotifier<Locale>(const Locale('en'));

// ── App root ─────────────────────────────────────────────────────────────────
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

// ── Shell scaffold with 5-tab bottom nav ────────────────────────────────────
class _ScaffoldWithNav extends StatelessWidget {
  const _ScaffoldWithNav({required this.child});

  final Widget child;

  static const _tabs = ['/', '/categories', '/sell', '/orders', '/profile'];

  int _currentIndex(BuildContext context) {
    final loc = GoRouterState.of(context).uri.toString();
    final idx = _tabs.indexWhere((t) => t == loc);
    return idx < 0 ? 0 : idx;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final current = _currentIndex(context);

    return Scaffold(
      body: child,
      // Sell tab gets a special FAB-style centre button
      floatingActionButton: current == 2
          ? null // handled by nav item press
          : null,
      bottomNavigationBar: SmBottomNav(
        currentIndex: current,
        onTap: (i) => context.go(_tabs[i]),
        items: [
          SmBottomNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: l.navMarket,
          ),
          SmBottomNavItem(
            icon: Icons.grid_view_outlined,
            activeIcon: Icons.grid_view,
            label: l.navCategories,
          ),
          SmBottomNavItem(
            icon: Icons.add_circle_outline,
            activeIcon: Icons.add_circle,
            label: l.navSell,
            isAccent: true,
          ),
          SmBottomNavItem(
            icon: Icons.receipt_long_outlined,
            activeIcon: Icons.receipt_long,
            label: l.navOrders,
          ),
          SmBottomNavItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: l.navProfile,
          ),
        ],
      ),
    );
  }
}

// Redirect placeholder — /search is no longer a shell tab but may be
// reached from the search bar inside home; we keep the route pointing
// back to home for now.
class _SearchRedirect extends StatelessWidget {
  const _SearchRedirect();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => context.go('/'));
    return const SizedBox.shrink();
  }
}
