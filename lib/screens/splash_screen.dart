import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  // Three staggered ripple controllers
  late final List<AnimationController> _rippleControllers;
  late final List<Animation<double>> _rippleScales;
  late final List<Animation<double>> _rippleOpacities;

  // Fade-in for the logo + text content
  late final AnimationController _contentController;
  late final Animation<double> _contentFade;
  late final Animation<Offset> _contentSlide;

  static const _primaryGreen = Color(0xFF1A5C2A);
  static const _lightGreen = Color(0xFFE8F5E9);
  static const _rippleColor = Color(0xFF1A5C2A);

  @override
  void initState() {
    super.initState();

    // Content fade + slide up
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _contentFade = CurvedAnimation(parent: _contentController, curve: Curves.easeOut);
    _contentSlide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _contentController, curve: Curves.easeOut));

    // Three ripple rings with staggered starts
    _rippleControllers = List.generate(3, (i) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 2000),
      );
    });

    _rippleScales = _rippleControllers
        .map((c) => Tween<double>(begin: 0.6, end: 2.2).animate(
              CurvedAnimation(parent: c, curve: Curves.easeOut),
            ))
        .toList();

    _rippleOpacities = _rippleControllers
        .map((c) => Tween<double>(begin: 0.55, end: 0.0).animate(
              CurvedAnimation(parent: c, curve: Curves.easeOut),
            ))
        .toList();

    _startAnimations();
  }

  Future<void> _startAnimations() async {
    // Fade in content first
    _contentController.forward();

    // Stagger ripple rings: 0ms, 600ms, 1200ms
    for (var i = 0; i < _rippleControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 600), () {
        if (mounted) _rippleControllers[i].repeat();
      });
    }

    // Navigate to home after 3.2 seconds
    await Future.delayed(const Duration(milliseconds: 3200));
    if (mounted) context.go('/');
  }

  @override
  void dispose() {
    _contentController.dispose();
    for (final c in _rippleControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _contentFade,
          child: SlideTransition(
            position: _contentSlide,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo with ripple rings
                SizedBox(
                  width: 220,
                  height: 220,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Ripple rings (behind the logo)
                      for (var i = 0; i < 3; i++)
                        AnimatedBuilder(
                          animation: _rippleControllers[i],
                          builder: (context, _) {
                            return Transform.scale(
                              scale: _rippleScales[i].value,
                              child: Opacity(
                                opacity: _rippleOpacities[i].value,
                                child: Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: _rippleColor,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                      // Logo circle background
                      Container(
                        width: 110,
                        height: 110,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: _lightGreen,
                        ),
                      ),

                      // Logo image
                      ClipOval(
                        child: Image.asset(
                          'assets/icons/sm-logo.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Title
                const Text(
                  'Smart Marketplace',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _primaryGreen,
                    letterSpacing: -0.3,
                  ),
                ),

                const SizedBox(height: 10),

                // Subtitle
                const Text(
                  'Connecting Buyers and Sellers with\nConfidence.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF555555),
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 16),

                // Tagline chips
                const Text(
                  'FRESH  •  LOCAL  •  SECURE',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFFAAAAAA),
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 14),

                // "Powered by Cameroon" row
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Flag dots
                    _dot(const Color(0xFF007A5E)), // green
                    const SizedBox(width: 5),
                    _dot(const Color(0xFFCE1126)), // red
                    const SizedBox(width: 5),
                    _dot(const Color(0xFFFCD116)), // yellow
                    const SizedBox(width: 10),
                    const Text(
                      'POWERED BY SECURE237',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF333333),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Bottom green bar
                Container(
                  width: 120,
                  height: 3,
                  decoration: BoxDecoration(
                    color: _primaryGreen,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
