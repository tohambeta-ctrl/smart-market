import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_market/l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/sm_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;
  static const _total = 3;

  void _next() {
    if (_page < _total - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 380),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  void _finish() => context.go('/');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final isLast = _page == _total - 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Skip ──────────────────────────────────────────────────────
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 24, 0),
                child: TextButton(
                  onPressed: _finish,
                  child: Text(
                    l.onboardingSkip,
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),

            // ── Pages ─────────────────────────────────────────────────────
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                children: [
                  _OnboardingPage(
                    painter: _FindComparePainter(),
                    title: l.onboarding1Title,
                    body: l.onboarding1Body,
                  ),
                  _OnboardingPage(
                    painter: _ConnectSellersPainter(),
                    title: l.onboarding2Title,
                    body: l.onboarding2Body,
                  ),
                  _OnboardingPage(
                    painter: _StayInformedPainter(),
                    title: l.onboarding3Title,
                    body: l.onboarding3Body,
                  ),
                ],
              ),
            ),

            // ── Dot indicator ─────────────────────────────────────────────
            _DotIndicator(current: _page, total: _total),
            const SizedBox(height: 24),

            // ── Next / Get Started button ─────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
              child: SmButton.primary(
                label: isLast ? l.onboardingGetStarted : l.onboardingNext,
                onPressed: _next,
                expanded: true,
                icon: isLast ? null : Icons.arrow_forward,
                size: SmButtonSize.large,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Single page layout
// ─────────────────────────────────────────────────────────────────────────────
class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.painter,
    required this.title,
    required this.body,
  });

  final CustomPainter painter;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Illustration card
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.neutral200),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.06),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: CustomPaint(
                  painter: painter,
                  child: const SizedBox.expand(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 36),
          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          // Body
          Text(
            body,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.neutral600,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Dot page indicator
// ─────────────────────────────────────────────────────────────────────────────
class _DotIndicator extends StatelessWidget {
  const _DotIndicator({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? AppColors.primary : AppColors.neutral400,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Painter 1 – Find & Compare
// A sketchy phone showing a price comparison list with accent marks
// ─────────────────────────────────────────────────────────────────────────────
class _FindComparePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Background blob
    final blobPaint = Paint()
      ..color = AppColors.primary50
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy - 10),
        width: size.width * 0.72,
        height: size.height * 0.60,
      ),
      blobPaint,
    );

    // ── Phone body ────────────────────────────────────────────────────────
    final phonePaint = Paint()
      ..color = AppColors.neutral
      ..style = PaintingStyle.fill;
    final phoneStroke = Paint()
      ..color = AppColors.neutral
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final phoneW = size.width * 0.38;
    final phoneH = size.height * 0.62;
    final phoneLeft = cx - phoneW / 2 + 10;
    final phoneTop = cy - phoneH / 2 - 10;
    final phoneRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(phoneLeft, phoneTop, phoneW, phoneH),
      const Radius.circular(18),
    );

    // Shadow
    canvas.drawRRect(
      phoneRect.shift(const Offset(4, 6)),
      Paint()..color = AppColors.primary.withValues(alpha: 0.15),
    );
    // Body fill
    canvas.drawRRect(phoneRect, Paint()..color = Colors.white);
    // Outline
    canvas.drawRRect(phoneRect, phoneStroke);

    // Screen area
    final screenL = phoneLeft + 4;
    final screenT = phoneTop + 22;
    final screenW = phoneW - 8;
    final screenH = phoneH - 44;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(screenL, screenT, screenW, screenH),
        const Radius.circular(10),
      ),
      Paint()..color = AppColors.primary50,
    );

    // Notch
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - 14, phoneTop + 8, 28, 7),
        const Radius.circular(4),
      ),
      phonePaint,
    );
    // Home bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - 16, phoneTop + phoneH - 12, 32, 4),
        const Radius.circular(2),
      ),
      phonePaint,
    );

    // ── App header bar inside screen ──────────────────────────────────────
    final hdrPaint = Paint()..color = AppColors.primary;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(screenL, screenT, screenW, 20),
        const Radius.circular(10),
      ),
      hdrPaint,
    );

    // Header text lines (white dashes)
    final whiteStroke = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(screenL + 6, screenT + 8),
      Offset(screenL + 36, screenT + 8),
      whiteStroke,
    );
    canvas.drawLine(
      Offset(screenL + 6, screenT + 14),
      Offset(screenL + 24, screenT + 14),
      whiteStroke..color = Colors.white.withValues(alpha: 0.5),
    );

    // ── Price rows ────────────────────────────────────────────────────────
    final rowPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final rowStroke = Paint()
      ..color = AppColors.neutral200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final textLine = Paint()
      ..color = AppColors.neutral400
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    final greenLine = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    final badgePaint = Paint()..color = AppColors.primary;

    for (var i = 0; i < 4; i++) {
      final rowTop = screenT + 24 + i * (screenH - 28) / 4;
      final rowRect = Rect.fromLTWH(
        screenL + 4,
        rowTop,
        screenW - 8,
        (screenH - 32) / 4 - 2,
      );
      canvas.drawRect(rowRect, rowPaint);
      canvas.drawRect(rowRect, rowStroke);

      // Item icon circle
      canvas.drawCircle(
        Offset(rowRect.left + 10, rowRect.center.dy),
        7,
        Paint()..color = AppColors.primary50,
      );
      canvas.drawCircle(
        Offset(rowRect.left + 10, rowRect.center.dy),
        7,
        Paint()
          ..color = AppColors.primary
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );

      // Name line
      canvas.drawLine(
        Offset(rowRect.left + 22, rowRect.top + 7),
        Offset(rowRect.left + 22 + rowRect.width * 0.38, rowRect.top + 7),
        textLine,
      );
      // Price line
      canvas.drawLine(
        Offset(rowRect.left + 22, rowRect.top + 13),
        Offset(rowRect.left + 22 + rowRect.width * 0.24, rowRect.top + 13),
        greenLine,
      );

      // Compare badge (last two rows have it)
      if (i >= 1) {
        final badgeRect = RRect.fromRectAndRadius(
          Rect.fromLTWH(rowRect.right - 28, rowRect.center.dy - 6, 26, 12),
          const Radius.circular(4),
        );
        canvas.drawRRect(badgeRect, badgePaint);
      }
    }

    // ── Floating accent marks ─────────────────────────────────────────────
    _drawStar(
      canvas,
      Offset(phoneLeft - 28, phoneTop + 30),
      10,
      AppColors.primary,
    );
    _drawStar(
      canvas,
      Offset(phoneLeft + phoneW + 22, phoneTop + 60),
      7,
      AppColors.secondary300,
    );
    _drawDiamond(
      canvas,
      Offset(phoneLeft - 18, phoneTop + phoneH - 30),
      9,
      AppColors.primary300,
    );
    _drawCircleOutline(
      canvas,
      Offset(phoneLeft + phoneW + 30, phoneTop + phoneH - 50),
      10,
      AppColors.primary200,
    );

    // Sparkle dots
    final sparkle = Paint()..color = AppColors.flagYellow;
    canvas.drawCircle(
      Offset(phoneLeft - 10, phoneTop + phoneH / 2),
      4,
      sparkle,
    );
    canvas.drawCircle(
      Offset(phoneLeft + phoneW + 12, phoneTop + 20),
      3,
      sparkle..color = AppColors.primary400,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Painter 2 – Connect with Sellers
// Two avatars connected by a dashed arc, chat bubbles, verified badge
// ─────────────────────────────────────────────────────────────────────────────
class _ConnectSellersPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Background blob
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy),
        width: size.width * 0.75,
        height: size.height * 0.58,
      ),
      Paint()..color = AppColors.secondary50,
    );

    // ── Left avatar (buyer) ───────────────────────────────────────────────
    final buyerCenter = Offset(cx - size.width * 0.22, cy + 10);
    _drawAvatar(canvas, buyerCenter, 34, AppColors.primary, 'B');

    // ── Right avatar (seller) ─────────────────────────────────────────────
    final sellerCenter = Offset(cx + size.width * 0.22, cy + 10);
    _drawAvatar(canvas, sellerCenter, 34, AppColors.secondary, 'S');

    // Verified tick on seller
    final tickBg = Paint()..color = AppColors.primary;
    canvas.drawCircle(sellerCenter + const Offset(24, 24), 11, tickBg);
    final tickPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    final tp = sellerCenter + const Offset(24, 24);
    final path = Path()
      ..moveTo(tp.dx - 6, tp.dy)
      ..lineTo(tp.dx - 1, tp.dy + 5)
      ..lineTo(tp.dx + 6, tp.dy - 5);
    canvas.drawPath(path, tickPaint);

    // ── Dashed connection arc ─────────────────────────────────────────────
    final arcPaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    _drawDashedArc(canvas, buyerCenter, sellerCenter, arcPaint);

    // ── Chat bubble (from buyer) ──────────────────────────────────────────
    _drawChatBubble(
      canvas,
      Offset(buyerCenter.dx - 20, buyerCenter.dy - 72),
      80,
      38,
      AppColors.primary,
      fromLeft: true,
    );
    // Lines inside bubble
    final wl = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(buyerCenter.dx - 44, buyerCenter.dy - 60),
      Offset(buyerCenter.dx + 18, buyerCenter.dy - 60),
      wl,
    );
    canvas.drawLine(
      Offset(buyerCenter.dx - 44, buyerCenter.dy - 52),
      Offset(buyerCenter.dx + 4, buyerCenter.dy - 52),
      wl..color = Colors.white.withValues(alpha: 0.5),
    );

    // ── Chat bubble (from seller) ─────────────────────────────────────────
    _drawChatBubble(
      canvas,
      Offset(sellerCenter.dx - 60, sellerCenter.dy - 72),
      80,
      38,
      AppColors.secondary,
      fromLeft: false,
    );
    final wl2 = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(sellerCenter.dx - 56, sellerCenter.dy - 60),
      Offset(sellerCenter.dx + 8, sellerCenter.dy - 60),
      wl2,
    );
    canvas.drawLine(
      Offset(sellerCenter.dx - 56, sellerCenter.dy - 52),
      Offset(sellerCenter.dx - 4, sellerCenter.dy - 52),
      wl2..color = Colors.white.withValues(alpha: 0.5),
    );

    // ── Store icon above seller ───────────────────────────────────────────
    _drawStoreIcon(
      canvas,
      Offset(cx + size.width * 0.22, cy - size.height * 0.22),
      22,
    );

    // ── Map pin above buyer ───────────────────────────────────────────────
    _drawMapPin(
      canvas,
      Offset(cx - size.width * 0.22, cy - size.height * 0.22),
      22,
    );

    // Accent marks
    _drawStar(
      canvas,
      Offset(cx - size.width * 0.38, cy - size.height * 0.20),
      8,
      AppColors.flagYellow,
    );
    _drawStar(
      canvas,
      Offset(cx + size.width * 0.38, cy - size.height * 0.15),
      6,
      AppColors.primary300,
    );
    _drawDiamond(
      canvas,
      Offset(cx + size.width * 0.36, cy + size.height * 0.22),
      8,
      AppColors.secondary300,
    );
    _drawCircleOutline(
      canvas,
      Offset(cx - size.width * 0.36, cy + size.height * 0.20),
      9,
      AppColors.primary200,
    );
  }

  void _drawAvatar(
    Canvas canvas,
    Offset center,
    double r,
    Color color,
    String letter,
  ) {
    canvas.drawCircle(
      center,
      r + 4,
      Paint()..color = color.withValues(alpha: 0.15),
    );
    canvas.drawCircle(center, r, Paint()..color = color);
    final tp = TextPainter(
      text: TextSpan(
        text: letter,
        style: TextStyle(
          color: Colors.white,
          fontSize: r * 0.9,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  void _drawDashedArc(Canvas canvas, Offset a, Offset b, Paint paint) {
    final mid = Offset((a.dx + b.dx) / 2, (a.dy + b.dy) / 2 - 40);
    final path = Path()
      ..moveTo(a.dx, a.dy)
      ..quadraticBezierTo(mid.dx, mid.dy, b.dx, b.dy);
    final metrics = path.computeMetrics().first;
    final total = metrics.length;
    const dash = 8.0;
    const gap = 5.0;
    var dist = 0.0;
    while (dist < total) {
      final end = (dist + dash).clamp(0.0, total);
      canvas.drawPath(metrics.extractPath(dist, end), paint);
      dist += dash + gap;
    }
  }

  void _drawChatBubble(
    Canvas canvas,
    Offset topLeft,
    double w,
    double h,
    Color color, {
    required bool fromLeft,
  }) {
    final r = 10.0;
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(topLeft.dx, topLeft.dy, w, h),
      Radius.circular(r),
    );
    canvas.drawRRect(rect, Paint()..color = color);
    // Tail
    final tailPath = Path();
    if (fromLeft) {
      tailPath.moveTo(topLeft.dx + 12, topLeft.dy + h);
      tailPath.lineTo(topLeft.dx + 4, topLeft.dy + h + 10);
      tailPath.lineTo(topLeft.dx + 22, topLeft.dy + h);
    } else {
      tailPath.moveTo(topLeft.dx + w - 12, topLeft.dy + h);
      tailPath.lineTo(topLeft.dx + w - 4, topLeft.dy + h + 10);
      tailPath.lineTo(topLeft.dx + w - 22, topLeft.dy + h);
    }
    tailPath.close();
    canvas.drawPath(tailPath, Paint()..color = color);
  }

  void _drawStoreIcon(Canvas canvas, Offset center, double size) {
    final p = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final bg = Paint()..color = AppColors.primary50;
    canvas.drawCircle(center, size * 1.1, bg);
    // Awning
    final awning = Path()
      ..moveTo(center.dx - size * 0.7, center.dy - size * 0.1)
      ..lineTo(center.dx - size * 0.5, center.dy - size * 0.6)
      ..lineTo(center.dx + size * 0.5, center.dy - size * 0.6)
      ..lineTo(center.dx + size * 0.7, center.dy - size * 0.1)
      ..close();
    canvas.drawPath(awning, Paint()..color = AppColors.primary);
    // Body
    canvas.drawRect(
      Rect.fromLTWH(
        center.dx - size * 0.5,
        center.dy - size * 0.1,
        size,
        size * 0.7,
      ),
      p
        ..style = PaintingStyle.fill
        ..color = Colors.white,
    );
    canvas.drawRect(
      Rect.fromLTWH(
        center.dx - size * 0.5,
        center.dy - size * 0.1,
        size,
        size * 0.7,
      ),
      p
        ..style = PaintingStyle.stroke
        ..color = AppColors.primary,
    );
    // Door
    canvas.drawRect(
      Rect.fromLTWH(
        center.dx - size * 0.15,
        center.dy + size * 0.1,
        size * 0.3,
        size * 0.5,
      ),
      Paint()..color = AppColors.primary50,
    );
  }

  void _drawMapPin(Canvas canvas, Offset center, double size) {
    final bg = Paint()..color = AppColors.secondary50;
    canvas.drawCircle(center, size * 1.1, bg);
    final p = Paint()
      ..color = AppColors.secondary
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(center.dx, center.dy + size * 0.7)
      ..cubicTo(
        center.dx - size * 0.1,
        center.dy + size * 0.3,
        center.dx - size * 0.6,
        center.dy,
        center.dx - size * 0.6,
        center.dy - size * 0.3,
      )
      ..arcToPoint(
        Offset(center.dx + size * 0.6, center.dy - size * 0.3),
        radius: Radius.circular(size * 0.6),
      )
      ..cubicTo(
        center.dx + size * 0.6,
        center.dy,
        center.dx + size * 0.1,
        center.dy + size * 0.3,
        center.dx,
        center.dy + size * 0.7,
      )
      ..close();
    canvas.drawPath(path, p);
    canvas.drawCircle(
      Offset(center.dx, center.dy - size * 0.3),
      size * 0.22,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Painter 3 – Stay Informed
// A line chart with price trend, notification bell, alert badges
// ─────────────────────────────────────────────────────────────────────────────
class _StayInformedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Background blob
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy),
        width: size.width * 0.78,
        height: size.height * 0.62,
      ),
      Paint()..color = AppColors.primary50,
    );

    // ── Chart card ────────────────────────────────────────────────────────
    final cardL = cx - size.width * 0.34;
    final cardT = cy - size.height * 0.28;
    final cardW = size.width * 0.68;
    final cardH = size.height * 0.40;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cardL, cardT, cardW, cardH),
        const Radius.circular(16),
      ),
      Paint()..color = Colors.white,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cardL, cardT, cardW, cardH),
        const Radius.circular(16),
      ),
      Paint()
        ..color = AppColors.neutral200
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    // Chart title line
    final tl = Paint()
      ..color = AppColors.neutral400
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(cardL + 12, cardT + 14),
      Offset(cardL + 60, cardT + 14),
      tl,
    );
    canvas.drawLine(
      Offset(cardL + 12, cardT + 22),
      Offset(cardL + 42, cardT + 22),
      tl..color = AppColors.neutral200,
    );

    // Grid lines
    final gridPaint = Paint()
      ..color = AppColors.neutral200
      ..strokeWidth = 0.8;
    for (var i = 1; i <= 3; i++) {
      final y = cardT + 32 + i * (cardH - 44) / 4;
      canvas.drawLine(
        Offset(cardL + 8, y),
        Offset(cardL + cardW - 8, y),
        gridPaint,
      );
    }

    // ── Area fill under chart line ────────────────────────────────────────
    final chartPoints = _chartPoints(cardL, cardT, cardW, cardH);
    final areaPath = Path()..moveTo(chartPoints.first.dx, cardT + cardH - 12);
    for (final p in chartPoints) {
      areaPath.lineTo(p.dx, p.dy);
    }
    areaPath.lineTo(chartPoints.last.dx, cardT + cardH - 12);
    areaPath.close();
    canvas.drawPath(
      areaPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary.withValues(alpha: 0.18),
            AppColors.primary.withValues(alpha: 0.0),
          ],
        ).createShader(Rect.fromLTWH(cardL, cardT, cardW, cardH)),
    );

    // Chart line
    final linePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    final linePath = Path()..moveTo(chartPoints.first.dx, chartPoints.first.dy);
    for (var i = 1; i < chartPoints.length; i++) {
      final prev = chartPoints[i - 1];
      final curr = chartPoints[i];
      final midX = (prev.dx + curr.dx) / 2;
      linePath.cubicTo(midX, prev.dy, midX, curr.dy, curr.dx, curr.dy);
    }
    canvas.drawPath(linePath, linePaint);

    // Highlight dot on peak
    final peak = chartPoints[2];
    canvas.drawCircle(peak, 6, Paint()..color = AppColors.primary);
    canvas.drawCircle(peak, 3.5, Paint()..color = Colors.white);

    // ── Price alert badge ─────────────────────────────────────────────────
    final badgeCenter = Offset(peak.dx + 2, peak.dy - 22);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: badgeCenter, width: 52, height: 20),
        const Radius.circular(6),
      ),
      Paint()..color = AppColors.primary,
    );
    final badgeLine = Paint()
      ..color = Colors.white.withValues(alpha: 0.85)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(badgeCenter.dx - 18, badgeCenter.dy),
      Offset(badgeCenter.dx + 18, badgeCenter.dy),
      badgeLine,
    );

    // ── Notification bell card ────────────────────────────────────────────
    final bellCardCenter = Offset(
      cx + size.width * 0.28,
      cy + size.height * 0.12,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: bellCardCenter, width: 52, height: 52),
        const Radius.circular(14),
      ),
      Paint()..color = Colors.white,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: bellCardCenter, width: 52, height: 52),
        const Radius.circular(14),
      ),
      Paint()
        ..color = AppColors.neutral200
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
    _drawBell(canvas, bellCardCenter, 14);

    // Notification dot
    canvas.drawCircle(
      bellCardCenter + const Offset(9, -9),
      6,
      Paint()..color = AppColors.error,
    );

    // ── Trend up/down chips below chart ───────────────────────────────────
    final chipY = cardT + cardH + 18;
    _drawTrendChip(canvas, Offset(cx - 44, chipY), '▲ 12%', AppColors.success);
    _drawTrendChip(canvas, Offset(cx + 14, chipY), '▼ 5%', AppColors.error);

    // Accent marks
    _drawStar(canvas, Offset(cardL - 24, cardT + 20), 9, AppColors.flagYellow);
    _drawStar(
      canvas,
      Offset(cardL + cardW + 18, cardT + 30),
      6,
      AppColors.primary300,
    );
    _drawDiamond(
      canvas,
      Offset(cardL - 18, cardT + cardH - 10),
      8,
      AppColors.secondary300,
    );
    _drawCircleOutline(
      canvas,
      Offset(cardL + cardW + 28, cardT + cardH - 20),
      10,
      AppColors.primary200,
    );
  }

  List<Offset> _chartPoints(double l, double t, double w, double h) {
    final bottom = t + h - 16;
    final range = h * 0.42;
    final xs = [0.06, 0.20, 0.38, 0.55, 0.70, 0.85, 0.94];
    final ys = [0.55, 0.70, 0.20, 0.50, 0.35, 0.62, 0.45];
    return List.generate(
      xs.length,
      (i) => Offset(l + w * xs[i], bottom - range * (1 - ys[i])),
    );
  }

  void _drawBell(Canvas canvas, Offset center, double size) {
    final p = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(center.dx, center.dy - size * 0.8)
      ..cubicTo(
        center.dx - size * 0.6,
        center.dy - size * 0.8,
        center.dx - size * 0.8,
        center.dy - size * 0.2,
        center.dx - size * 0.8,
        center.dy + size * 0.2,
      )
      ..lineTo(center.dx - size, center.dy + size * 0.4)
      ..lineTo(center.dx + size, center.dy + size * 0.4)
      ..lineTo(center.dx + size * 0.8, center.dy + size * 0.2)
      ..cubicTo(
        center.dx + size * 0.8,
        center.dy - size * 0.2,
        center.dx + size * 0.6,
        center.dy - size * 0.8,
        center.dx,
        center.dy - size * 0.8,
      )
      ..close();
    canvas.drawPath(path, p);
    canvas.drawCircle(
      Offset(center.dx, center.dy + size * 0.6),
      size * 0.28,
      p,
    );
  }

  void _drawTrendChip(Canvas canvas, Offset topLeft, String text, Color color) {
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(topLeft.dx, topLeft.dy, 54, 24),
      const Radius.circular(6),
    );
    canvas.drawRRect(rect, Paint()..color = color.withValues(alpha: 0.12));
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(
      canvas,
      topLeft + Offset((54 - tp.width) / 2, (24 - tp.height) / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared accent shape helpers (free functions used by all painters)
// ─────────────────────────────────────────────────────────────────────────────

void _drawStar(Canvas canvas, Offset center, double size, Color color) {
  final paint = Paint()
    ..color = color
    ..style = PaintingStyle.fill;
  final path = Path();
  for (var i = 0; i < 4; i++) {
    final angle = i * 3.14159 / 2;
    final outer = Offset(
      center.dx + size * _cos(angle),
      center.dy + size * _sin(angle),
    );
    final innerAngle = angle + 3.14159 / 4;
    final inner = Offset(
      center.dx + size * 0.4 * _cos(innerAngle),
      center.dy + size * 0.4 * _sin(innerAngle),
    );
    if (i == 0) {
      path.moveTo(outer.dx, outer.dy);
    } else {
      path.lineTo(outer.dx, outer.dy);
    }
    path.lineTo(inner.dx, inner.dy);
  }
  path.close();
  canvas.drawPath(path, paint);
}

void _drawDiamond(Canvas canvas, Offset center, double size, Color color) {
  final paint = Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.8;
  final path = Path()
    ..moveTo(center.dx, center.dy - size)
    ..lineTo(center.dx + size * 0.6, center.dy)
    ..lineTo(center.dx, center.dy + size)
    ..lineTo(center.dx - size * 0.6, center.dy)
    ..close();
  canvas.drawPath(path, paint);
}

void _drawCircleOutline(
  Canvas canvas,
  Offset center,
  double radius,
  Color color,
) {
  canvas.drawCircle(
    center,
    radius,
    Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8,
  );
}

double _cos(double angle) => _mathCos(angle);
double _sin(double angle) => _mathSin(angle);

double _mathCos(double x) {
  // Simple Taylor approximation good enough for 0..2π
  x = x % (2 * 3.14159265);
  double r = 1, t = 1;
  for (var i = 1; i <= 8; i++) {
    t *= -x * x / ((2 * i - 1) * (2 * i));
    r += t;
  }
  return r;
}

double _mathSin(double x) {
  x = x % (2 * 3.14159265);
  double r = x, t = x;
  for (var i = 1; i <= 8; i++) {
    t *= -x * x / ((2 * i) * (2 * i + 1));
    r += t;
  }
  return r;
}
