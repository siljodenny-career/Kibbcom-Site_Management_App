import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:site_dashboard/view/widgets/appbar_widget.dart';
import '../theme/app_theme.dart';
import 'dashboard_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateToDashboard(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const DashboardScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0.04, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeOut),
                  ),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: KibbcomAppBar(
        onNavigateToDashboard: () => _navigateToDashboard(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),

              // ── Brand header ──────────────────────────
              _BrandHeader(),

              const SizedBox(height: 18),

              // ── Hero card ─────────────────────────────
              _HeroCard(),

              // ── Dashboard button centered ─────────────
              const Spacer(),

              Center(
                child: _CTAButton(onTap: () => _navigateToDashboard(context)),
              ),

              // ── Footer copyright ──────────────────────
              const Spacer(),

              Center(
                child: Column(
                  children: [
                    Text(
                      '© ${DateTime.now().year} Kibbcom. All rights reserved.',
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Site Management App v1.0.0',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 900.ms, duration: 400.ms),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Brand header ──────────────────────────────────────────────
class _BrandHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppTheme.primary.withValues(alpha: 0.15),
                    border: Border.all(
                      color: AppTheme.primary.withValues(alpha: 0.4),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.location_city_rounded,
                    color: AppTheme.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Kibb',
                        style: TextStyle(
                          color: AppTheme.primary,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      TextSpan(
                        text: 'com',
                        style: TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
            .animate()
            .fadeIn(duration: 500.ms)
            .slideY(begin: -0.1, end: 0, duration: 500.ms),

        const SizedBox(height: 8),

        const Text(
          '''An application that allows managers to monitor 
and manage operational sites in real time.''',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.2,
          ),
        ).animate().fadeIn(delay: 150.ms, duration: 400.ms),
      ],
    );
  }
}

// ── Hero card ─────────────────────────────────────────────────
class _HeroCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppTheme.border, width: 1),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primary.withValues(alpha: 0.18),
                AppTheme.primary.withValues(alpha: 0.06),
                AppTheme.surfaceCard,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: Stack(
            children: [
              // Decorative circles
              Positioned(
                top: -30,
                right: -30,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primary.withValues(alpha: 0.07),
                  ),
                ),
              ),
              Positioned(
                bottom: -20,
                left: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.activeGreen.withValues(alpha: 0.06),
                  ),
                ),
              ),

              // Content
              const Padding(
                padding: EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        _MiniPill(label: 'Active', color: AppTheme.activeGreen),
                        SizedBox(width: 8),
                        _MiniPill(
                          label: 'Maintenance',
                          color: AppTheme.maintOrange,
                        ),
                        SizedBox(width: 8),
                        _MiniPill(label: '6 Sites', color: AppTheme.primary),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Monitor. Manage.\nTake Control.',
                      style: TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'All your sites. One dashboard.',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 500.ms)
        .slideY(begin: 0.06, end: 0, duration: 500.ms, curve: Curves.easeOut);
  }
}

// ── Mini pill ─────────────────────────────────────────────────
class _MiniPill extends StatelessWidget {
  final String label;
  final Color color;

  const _MiniPill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.30), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ── CTA button ────────────────────────────────────────────────
class _CTAButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CTAButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
          width: 200,
          height: 52,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_rounded, size: 18),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(delay: 600.ms, duration: 400.ms)
        .slideY(begin: 0.1, end: 0, duration: 400.ms, curve: Curves.easeOut);
  }
}
