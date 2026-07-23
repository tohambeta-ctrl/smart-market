import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class SmBottomNav extends StatelessWidget {
  const SmBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<SmBottomNavItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.neutral200)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(items.length, (i) {
              final item = items[i];
              final selected = i == currentIndex;
              return Expanded(
                child: item.isAccent
                    ? _AccentNavItem(
                        item: item,
                        selected: selected,
                        onTap: () => onTap(i),
                      )
                    : _NavItem(
                        item: item,
                        selected: selected,
                        onTap: () => onTap(i),
                      ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ── Regular nav item ─────────────────────────────────────────────────────────
class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final SmBottomNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.neutral600;
    final icon = selected ? (item.activeIcon ?? item.icon) : item.icon;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            width: 56,
            height: 32,
            decoration: BoxDecoration(
              color: selected ? AppColors.primary50 : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 2),
          Text(
            item.label,
            style: AppTextStyles.labelSmall.copyWith(
              color: color,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Accent "Sell" nav item — raised green circle ──────────────────────────────
class _AccentNavItem extends StatelessWidget {
  const _AccentNavItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final SmBottomNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Circle constrained to fit within the bar
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.30),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              selected ? (item.activeIcon ?? item.icon) : item.icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            item.label,
            style: AppTextStyles.labelSmall.copyWith(
              color: selected ? AppColors.primary : AppColors.neutral600,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Data class ────────────────────────────────────────────────────────────────
class SmBottomNavItem {
  const SmBottomNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.isAccent = false,
  });

  final IconData icon;
  final IconData? activeIcon;
  final String label;

  /// When true renders as a raised accent circle (for the "Sell" tab).
  final bool isAccent;
}
