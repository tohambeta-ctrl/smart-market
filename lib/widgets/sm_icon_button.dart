import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Icon button variants shown in the style guide:
///
/// - [SmIconButton]           — standalone square icon button
/// - [SmLabeledIconButton]    — icon + text label side by side
/// - [SmIconButtonGroup]      — horizontal row of icon buttons (e.g. edit/share/tag/delete)
enum SmIconButtonVariant {
  /// Green filled background
  primary,

  /// Dark/neutral filled background
  neutral,

  /// Danger / destructive (red)
  danger,
}

class SmIconButton extends StatelessWidget {
  const SmIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.variant = SmIconButtonVariant.neutral,
    this.tooltip,
    this.size = 40,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final SmIconButtonVariant variant;
  final String? tooltip;
  final double size;

  Color get _bg => switch (variant) {
        SmIconButtonVariant.primary => AppColors.primary,
        SmIconButtonVariant.neutral => AppColors.secondary,
        SmIconButtonVariant.danger  => AppColors.error,
      };

  @override
  Widget build(BuildContext context) {
    final btn = Material(
      color: _bg,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(icon, color: Colors.white, size: size * 0.45),
        ),
      ),
    );

    return tooltip != null
        ? Tooltip(message: tooltip!, child: btn)
        : btn;
  }
}

/// Icon button with a text label to the right (as seen in the style guide).
class SmLabeledIconButton extends StatelessWidget {
  const SmLabeledIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.variant = SmIconButtonVariant.primary,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final SmIconButtonVariant variant;

  Color get _bg => switch (variant) {
        SmIconButtonVariant.primary => AppColors.primary,
        SmIconButtonVariant.neutral => AppColors.secondary,
        SmIconButtonVariant.danger  => AppColors.error,
      };

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _bg,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 16),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A horizontal strip of [SmIconButton]s — mirrors the action row in the
/// style guide (edit · share · tag · delete).
class SmIconButtonGroup extends StatelessWidget {
  const SmIconButtonGroup({super.key, required this.actions});

  final List<SmIconButtonAction> actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: actions
          .map(
            (a) => Padding(
              padding: const EdgeInsets.only(right: 6),
              child: SmIconButton(
                icon: a.icon,
                onPressed: a.onPressed,
                variant: a.variant,
                tooltip: a.tooltip,
              ),
            ),
          )
          .toList(),
    );
  }
}

/// Data class for a single action inside [SmIconButtonGroup].
class SmIconButtonAction {
  const SmIconButtonAction({
    required this.icon,
    required this.onPressed,
    this.variant = SmIconButtonVariant.neutral,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final SmIconButtonVariant variant;
  final String? tooltip;
}
