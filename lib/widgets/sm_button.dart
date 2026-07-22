import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Button variants matching the style guide:
/// Primary · Secondary · Inverted · Outlined
enum SmButtonVariant { primary, secondary, inverted, outlined }

class SmButton extends StatelessWidget {
  const SmButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = SmButtonVariant.primary,
    this.icon,
    this.loading = false,
    this.expanded = false,
    this.size = SmButtonSize.medium,
  });

  final String label;
  final VoidCallback? onPressed;
  final SmButtonVariant variant;
  final IconData? icon;
  final bool loading;

  /// Stretches the button to full available width.
  final bool expanded;
  final SmButtonSize size;

  // ── Convenience constructors ──────────────────────────────────────────────

  const SmButton.primary({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.expanded = false,
    this.size = SmButtonSize.medium,
  }) : variant = SmButtonVariant.primary;

  const SmButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.expanded = false,
    this.size = SmButtonSize.medium,
  }) : variant = SmButtonVariant.secondary;

  const SmButton.inverted({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.expanded = false,
    this.size = SmButtonSize.medium,
  }) : variant = SmButtonVariant.inverted;

  const SmButton.outlined({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.expanded = false,
    this.size = SmButtonSize.medium,
  }) : variant = SmButtonVariant.outlined;

  // ── Styling helpers ───────────────────────────────────────────────────────

  Color get _bgColor => switch (variant) {
        SmButtonVariant.primary  => AppColors.primary,
        SmButtonVariant.secondary => AppColors.secondary,
        SmButtonVariant.inverted  => AppColors.neutral,
        SmButtonVariant.outlined  => Colors.transparent,
      };

  Color get _fgColor => switch (variant) {
        SmButtonVariant.primary   => Colors.white,
        SmButtonVariant.secondary => Colors.white,
        SmButtonVariant.inverted  => Colors.white,
        SmButtonVariant.outlined  => AppColors.primary,
      };

  BorderSide get _border => variant == SmButtonVariant.outlined
      ? const BorderSide(color: AppColors.primary, width: 1.5)
      : BorderSide.none;

  EdgeInsets get _padding => switch (size) {
        SmButtonSize.small  => const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        SmButtonSize.medium => const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        SmButtonSize.large  => const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      };

  double get _fontSize => switch (size) {
        SmButtonSize.small  => 13,
        SmButtonSize.medium => 14,
        SmButtonSize.large  => 16,
      };

  @override
  Widget build(BuildContext context) {
    final style = ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return AppColors.neutral200;
        return _bgColor;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return AppColors.neutral400;
        return _fgColor;
      }),
      overlayColor: WidgetStateProperty.all(_fgColor.withValues(alpha: 0.08)),
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return const BorderSide(color: AppColors.neutral200);
        }
        return _border;
      }),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      padding: WidgetStateProperty.all(_padding),
      minimumSize: WidgetStateProperty.all(const Size(64, 0)),
      textStyle: WidgetStateProperty.all(
        AppTextStyles.labelLarge.copyWith(fontSize: _fontSize),
      ),
      elevation: WidgetStateProperty.all(0),
    );

    Widget child = loading
        ? SizedBox(
            width: _fontSize + 4,
            height: _fontSize + 4,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: _fgColor,
            ),
          )
        : icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: _fontSize + 2),
                  const SizedBox(width: 8),
                  Text(label),
                ],
              )
            : Text(label);

    final btn = TextButton(
      onPressed: loading ? null : onPressed,
      style: style,
      child: child,
    );

    return expanded
        ? SizedBox(width: double.infinity, child: btn)
        : btn;
  }
}

enum SmButtonSize { small, medium, large }
