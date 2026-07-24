import 'package:flutter/material.dart';
import 'package:smart_market/l10n/app_localizations.dart';
import '../main.dart' show requireAuth;
import '../models/models.dart';
import '../screens/auth_screen.dart' show AuthTab;
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/sm_button.dart';

class SellScreen extends StatelessWidget {
  const SellScreen({super.key});

  static const _steps = [
    _StepItem(
      Icons.storefront_outlined,
      'Create Your Store',
      'Set up your seller profile in minutes.',
    ),
    _StepItem(
      Icons.add_photo_alternate_outlined,
      'List Your Products',
      'Add photos, prices and descriptions.',
    ),
    _StepItem(
      Icons.people_outline,
      'Reach Buyers',
      'Get discovered by thousands of buyers across Cameroon.',
    ),
    _StepItem(
      Icons.payments_outlined,
      'Get Paid',
      'Secure, fast payouts directly to your Mobile Money account.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(l.navSell)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Illustration
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: AppColors.primary50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const CustomPaint(painter: _SellIllustrationPainter()),
            ),
            const SizedBox(height: 28),
            Text(
              l.homeSellTitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.headlineSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              l.homeSellBody,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.neutral600,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),

            // Steps
            ...List.generate(
              _steps.length,
              (i) => _StepTile(step: i + 1, item: _steps[i]),
            ),

            const SizedBox(height: 32),
            SmButton.primary(
              label: l.homeSellCta,
              onPressed: () => requireAuth(
                context,
                tab: AuthTab.signUp,
                role: UserRole.seller,
              ),
              expanded: true,
              size: SmButtonSize.large,
            ),
            const SizedBox(height: 12),
            SmButton.outlined(
              label: 'Learn More',
              onPressed: () {},
              expanded: true,
              size: SmButtonSize.large,
            ),
          ],
        ),
      ),
    );
  }
}

class _StepItem {
  const _StepItem(this.icon, this.title, this.description);
  final IconData icon;
  final String title;
  final String description;
}

class _StepTile extends StatelessWidget {
  const _StepTile({required this.step, required this.item});
  final int step;
  final _StepItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$step',
                style: AppTextStyles.titleSmall.copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: AppTextStyles.titleSmall),
                const SizedBox(height: 3),
                Text(
                  item.description,
                  style: AppTextStyles.bodySmall.copyWith(height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SellIllustrationPainter extends CustomPainter {
  const _SellIllustrationPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Store front doodle
    final fill = Paint()..color = AppColors.primary100;
    final stroke = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Building body
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, cy + 10), width: 120, height: 90),
        const Radius.circular(8),
      ),
      fill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, cy + 10), width: 120, height: 90),
        const Radius.circular(8),
      ),
      stroke,
    );

    // Awning
    final awning = Paint()..color = AppColors.primary;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - 60, cy - 38, 120, 22),
        const Radius.circular(4),
      ),
      awning,
    );
    // Awning stripes
    final stripe = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..strokeWidth = 8;
    for (var i = 0; i < 5; i++) {
      final x = cx - 50 + i * 24.0;
      canvas.drawLine(Offset(x, cy - 38), Offset(x + 10, cy - 16), stripe);
    }

    // Door
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - 15, cy + 16, 30, 44),
        const Radius.circular(4),
      ),
      Paint()..color = AppColors.primary200,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - 15, cy + 16, 30, 44),
        const Radius.circular(4),
      ),
      stroke,
    );

    // Windows
    for (var i = 0; i < 2; i++) {
      final wx = cx - 40 + i * 64.0;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(wx, cy - 10, 24, 20),
          const Radius.circular(3),
        ),
        Paint()..color = AppColors.primary200,
      );
    }

    // Accent stars
    _dot(canvas, Offset(cx - 70, cy - 50), 5, AppColors.flagYellow);
    _dot(canvas, Offset(cx + 72, cy - 30), 4, AppColors.primary300);
    _dot(canvas, Offset(cx + 60, cy + 50), 6, AppColors.primary200);
  }

  void _dot(Canvas canvas, Offset c, double r, Color color) {
    canvas.drawCircle(c, r, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}
