import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_market/l10n/app_localizations.dart';
import '../main.dart' show localeNotifier, authNotifier, requireAuth;
import '../models/models.dart';
import '../screens/auth_screen.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/sm_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Rebuild whenever auth state changes
    return ValueListenableBuilder<AppUser?>(
      valueListenable: authNotifier,
      builder: (context, user, _) {
        final l = AppLocalizations.of(context)!;
        final isGuest = user == null;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(title: Text(l.navProfile)),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // ── Header ─────────────────────────────────────────────────
                _ProfileHeader(user: user, l: l),

                const SizedBox(height: 16),

                // ── Account section ────────────────────────────────────────
                _MenuSection(
                  title: l.profileAccount,
                  items: [
                    _MenuItem(
                      Icons.person_outline,
                      l.profileMyProfile,
                      // My Profile always triggers auth
                      () => requireAuth(context),
                    ),
                    _MenuItem(
                      Icons.location_on_outlined,
                      l.profileAddresses,
                      () => requireAuth(context),
                    ),
                    _MenuItem(
                      Icons.payment_outlined,
                      l.profilePaymentMethods,
                      () => requireAuth(context),
                    ),
                  ],
                ),

                // ── Shopping section ───────────────────────────────────────
                _MenuSection(
                  title: l.profileShopping,
                  items: [
                    _MenuItem(
                      Icons.favorite_border,
                      l.profileWishlist,
                      () => requireAuth(context),
                    ),
                    _MenuItem(
                      Icons.history_outlined,
                      l.profileOrderHistory,
                      () => requireAuth(context),
                    ),
                    _MenuItem(
                      Icons.storefront_outlined,
                      l.profileMyStore,
                      () => requireAuth(
                        context,
                        tab: AuthTab.signUp,
                        role: UserRole.seller,
                      ),
                    ),
                  ],
                ),

                // ── Preferences section ────────────────────────────────────
                _MenuSection(
                  title: l.profilePreferences,
                  items: [
                    _MenuItem(
                      Icons.language_outlined,
                      '${l.languageToggleLabel} / Switch Language',
                      () {
                        localeNotifier.value =
                            localeNotifier.value.languageCode == 'en'
                            ? const Locale('fr')
                            : const Locale('en');
                      },
                    ),
                    _MenuItem(
                      Icons.notifications_outlined,
                      l.profileNotifications,
                      () {},
                    ),
                    _MenuItem(Icons.help_outline, l.profileHelpSupport, () {}),
                    _MenuItem(Icons.info_outline, l.profileAbout, () {}),
                  ],
                ),

                // ── Sign out / Sign in button ──────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                  child: isGuest
                      ? SmButton.primary(
                          label: l.profileSignInRegister,
                          onPressed: () => context.push('/login'),
                          expanded: true,
                        )
                      : SmButton.outlined(
                          label: l.profileSignOut,
                          onPressed: () {
                            authNotifier.value = null;
                          },
                          expanded: true,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Profile header — guest vs authenticated
// ─────────────────────────────────────────────────────────────────────────────
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.user, required this.l});
  final AppUser? user;
  final AppLocalizations l;

  @override
  Widget build(BuildContext context) {
    final isGuest = user == null;
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        children: [
          CircleAvatar(
            radius: 44,
            backgroundColor: AppColors.primary300,
            child: isGuest
                ? const Icon(Icons.person, size: 44, color: Colors.white)
                : Text(
                    _initials(user!.name),
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: Colors.white,
                    ),
                  ),
          ),
          const SizedBox(height: 12),
          Text(
            isGuest ? l.profileGuestName : user!.name,
            style: AppTextStyles.titleLarge.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            isGuest
                ? 'Cameroon'
                : (user!.role == UserRole.seller
                      ? l.authRoleSeller
                      : l.authRoleBuyer),
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white.withValues(alpha: 0.75),
            ),
          ),
          if (isGuest) ...[
            const SizedBox(height: 16),
            SmButton.outlined(
              label: l.profileSignInRegister,
              onPressed: () => context.push('/login'),
              size: SmButtonSize.small,
            ),
          ],
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable menu section
// ─────────────────────────────────────────────────────────────────────────────
class _MenuSection extends StatelessWidget {
  const _MenuSection({required this.title, required this.items});
  final String title;
  final List<_MenuItem> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 6),
            child: Text(
              title.toUpperCase(),
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.neutral600,
                letterSpacing: 1.0,
              ),
            ),
          ),
          Material(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.neutral200),
              ),
              child: Column(
                children: List.generate(items.length, (i) {
                  final item = items[i];
                  final isLast = i == items.length - 1;
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          item.icon,
                          color: AppColors.primary,
                          size: 22,
                        ),
                        title: Text(
                          item.label,
                          style: AppTextStyles.bodyMedium,
                        ),
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: AppColors.neutral400,
                          size: 18,
                        ),
                        onTap: item.onTap,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                      if (!isLast)
                        const Divider(
                          height: 1,
                          indent: 52,
                          color: AppColors.neutral200,
                        ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem {
  const _MenuItem(this.icon, this.label, this.onTap);
  final IconData icon;
  final String label;
  final VoidCallback onTap;
}
