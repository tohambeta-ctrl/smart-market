import 'package:flutter/material.dart';
import 'package:smart_market/l10n/app_localizations.dart';
import '../main.dart' show localeNotifier;
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/sm_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(l.navProfile)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              color: AppColors.primary,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 44,
                    backgroundColor: AppColors.primary300,
                    child: Icon(Icons.person, size: 44, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Guest User',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Cameroon',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.75),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SmButton.outlined(
                    label: 'Sign In / Register',
                    onPressed: () {},
                    size: SmButtonSize.small,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Menu items
            _MenuSection(
              title: 'Account',
              items: [
                _MenuItem(Icons.person_outline, 'My Profile', () {}),
                _MenuItem(Icons.location_on_outlined, 'Addresses', () {}),
                _MenuItem(Icons.payment_outlined, 'Payment Methods', () {}),
              ],
            ),
            _MenuSection(
              title: 'Shopping',
              items: [
                _MenuItem(Icons.favorite_border, 'Wishlist', () {}),
                _MenuItem(Icons.history_outlined, 'Order History', () {}),
                _MenuItem(Icons.storefront_outlined, 'My Store', () {}),
              ],
            ),
            _MenuSection(
              title: 'Preferences',
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
                _MenuItem(Icons.notifications_outlined, 'Notifications', () {}),
                _MenuItem(Icons.help_outline, 'Help & Support', () {}),
                _MenuItem(Icons.info_outline, 'About Smart Market', () {}),
              ],
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
              child: SmButton.outlined(
                label: 'Sign Out',
                onPressed: () {},
                expanded: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
