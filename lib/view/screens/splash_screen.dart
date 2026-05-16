import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  // ── "Kibb" fade + slide down ──────────────────────────────
  late final AnimationController _kibbController;
  late final Animation<double>   _kibbFade;
  late final Animation<Offset>   _kibbSlide;

  // ── "com" slide from left + fade ──────────────────────────
  late final AnimationController _comController;
  late final Animation<double>   _comFade;
  late final Animation<Offset>   _comSlide;

  // ── Breathing (whole word scales) ─────────────────────────
  late final AnimationController _breathController;
  late final Animation<double>   _breathScale;

  // ── Logo icon fade ────────────────────────────────────────
  late final AnimationController _iconController;

  // ── Subtitle fade ─────────────────────────────────────────
  late final AnimationController _subtitleController;

  @override
  void initState() {
    super.initState();
    _setupControllers();
    _runSequence();
  }

  void _setupControllers() {
    // Icon
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // "Kibb"
    _kibbController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _kibbFade = CurvedAnimation(
      parent: _kibbController,
      curve: Curves.easeOut,
    );
    _kibbSlide = Tween<Offset>(
      begin: const Offset(0, -0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _kibbController, curve: Curves.easeOutCubic),
    );

    // "com"
    _comController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _comFade = CurvedAnimation(
      parent: _comController,
      curve: Curves.easeOut,
    );
    _comSlide = Tween<Offset>(
      begin: const Offset(-0.8, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _comController, curve: Curves.easeOutCubic),
    );

    // Breathing
    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _breathScale = Tween<double>(begin: 1.0, end: 1.07).animate(
      CurvedAnimation(parent: _breathController, curve: Curves.easeInOut),
    );

    // Subtitle
    _subtitleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  Future<void> _runSequence() async {
    // Step 1 — icon pops in
    await Future.delayed(const Duration(milliseconds: 200));
    _iconController.forward();

    // Step 2 — "Kibb" slides down + fades in
    await Future.delayed(const Duration(milliseconds: 400));
    _kibbController.forward();

    // Step 3 — "com" slides from behind "Kibb"
    await Future.delayed(const Duration(milliseconds: 500));
    _comController.forward();

    // Step 4 — subtitle fades in
    await Future.delayed(const Duration(milliseconds: 400));
    _subtitleController.forward();

    // Step 5 — breathing starts, loops
    await Future.delayed(const Duration(milliseconds: 200));
    _breathController.repeat(reverse: true);

    // Step 6 — wait then navigate
    await Future.delayed(const Duration(milliseconds: 1200));
    _navigateToHome();
  }

  void _navigateToHome() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const HomeScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  void dispose() {
    _iconController.dispose();
    _kibbController.dispose();
    _comController.dispose();
    _breathController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            

            // ── Kibb + com row with breathing wrapper ────
            AnimatedBuilder(
              animation: _breathController,
              builder: (_, child) => Transform.scale(
                scale: _breathScale.value,
                child: child,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [

                  // "Kibb" — slides from top, fades in
                  AnimatedBuilder(
                    animation: _kibbController,
                    builder: (_, __) => FadeTransition(
                      opacity: _kibbFade,
                      child: SlideTransition(
                        position: _kibbSlide,
                        child: const Text(
                          'Kibb',
                          style: TextStyle(
                            color: AppTheme.primary,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -1.5,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // "com" — slides from left behind "Kibb", fades in
                  ClipRect(
                    child: AnimatedBuilder(
                      animation: _comController,
                      builder: (_, __) => FadeTransition(
                        opacity: _comFade,
                        child: SlideTransition(
                          position: _comSlide,
                          child: const Text(
                            'com',
                            style: TextStyle(
                              color: AppTheme.textPrimary,
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1.5,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            

            
          ],
        ),
      ),
    );
  }
}