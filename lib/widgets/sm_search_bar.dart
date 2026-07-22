import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Tappable search bar (read-only, navigates on tap) or
/// interactive text field when [onChanged] is provided.
class SmSearchBar extends StatelessWidget {
  const SmSearchBar({
    super.key,
    this.hint = 'Search…',
    this.onTap,
    this.onChanged,
    this.onClear,
    this.controller,
    this.autofocus = false,
    this.readOnly = false,
    this.query = '',
  });

  final String hint;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final TextEditingController? controller;
  final bool autofocus;

  /// When true the field is not editable — tapping fires [onTap].
  final bool readOnly;
  final String query;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: readOnly ? onTap : null,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.tertiary,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.neutral200),
        ),
        child: readOnly
            ? _ReadOnlyContent(hint: hint)
            : _EditableContent(
                hint: hint,
                controller: controller,
                autofocus: autofocus,
                onChanged: onChanged,
                onClear: onClear,
                query: query,
              ),
      ),
    );
  }
}

class _ReadOnlyContent extends StatelessWidget {
  const _ReadOnlyContent({required this.hint});
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 12),
        const Icon(Icons.search, size: 20, color: AppColors.neutral400),
        const SizedBox(width: 8),
        Text(hint, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.neutral400)),
      ],
    );
  }
}

class _EditableContent extends StatelessWidget {
  const _EditableContent({
    required this.hint,
    required this.controller,
    required this.autofocus,
    required this.onChanged,
    required this.onClear,
    required this.query,
  });

  final String hint;
  final TextEditingController? controller;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final String query;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 12),
        const Icon(Icons.search, size: 20, color: AppColors.neutral400),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: controller,
            autofocus: autofocus,
            onChanged: onChanged,
            style: AppTextStyles.bodyMedium,
            cursorColor: AppColors.primary,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.neutral400),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
              filled: false,
            ),
          ),
        ),
        if (query.isNotEmpty && onClear != null)
          GestureDetector(
            onTap: onClear,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.close, size: 18, color: AppColors.neutral600),
            ),
          )
        else
          const SizedBox(width: 12),
      ],
    );
  }
}
