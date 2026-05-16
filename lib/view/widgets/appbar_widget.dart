import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../screens/dashboard_screen.dart';

class KibbcomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onNavigateToDashboard;

  const KibbcomAppBar({
    super.key,
    this.onNavigateToDashboard,
  });

  // ── Required by PreferredSizeWidget ───────────────────────
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  // ── Notification sidebar ───────────────────────────────────
  void _openNotifications(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black.withValues(alpha: 0.5),
        pageBuilder: (_, __, ___) => const _NotificationSidebar(),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            )),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _navigateToDashboard(BuildContext context) {
    if (onNavigateToDashboard != null) {
      onNavigateToDashboard!();
      return;
    }
    // Default navigation if no callback provided
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => const DashboardScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.04, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
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
    return AppBar(
      backgroundColor: AppTheme.background,
      elevation: 0,
      scrolledUnderElevation: 0,

      // ── Logo mark + Kibbcom title ──────────────────────
      title: Row(
        children: [
          
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Kibb',
                  style: TextStyle(
                    color: AppTheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                TextSpan(
                  text: 'com',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      actions: [
        // ── Notification button ──────────────────────────
        _AppBarIconButton(
          icon: Icons.notifications_none_rounded,
          onTap: () => _openNotifications(context),
        ),

        const SizedBox(width: 4),

        // ── Three dot menu ───────────────────────────────
        _ThreeDotMenu(
          onNavigateToDashboard: () => _navigateToDashboard(context),
        ),

        const SizedBox(width: 8),
      ],
    );
  }
}

// ── AppBar icon button ────────────────────────────────────────
class _AppBarIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _AppBarIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppTheme.surfaceCard,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.border, width: 1),
        ),
        child: Icon(icon, color: AppTheme.textSecondary, size: 18),
      ),
    );
  }
}

// ── Three dot dropdown menu ───────────────────────────────────
class _ThreeDotMenu extends StatelessWidget {
  final VoidCallback onNavigateToDashboard;

  const _ThreeDotMenu({required this.onNavigateToDashboard});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppTheme.surfaceCard,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.border, width: 1),
        ),
        child: const Icon(
          Icons.more_vert_rounded,
          color: AppTheme.textSecondary,
          size: 18,
        ),
      ),
      color: AppTheme.surfaceCard,
      elevation: 8,
      shadowColor: Colors.black.withValues(alpha: 0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppTheme.border, width: 1),
      ),
      offset: const Offset(0, 48),
      onSelected: (value) {
        switch (value) {
          case 'dashboard':
            onNavigateToDashboard();
            break;
          case 'about':
            _showAboutDialog(context);
            break;
        }
      },
      itemBuilder: (_) => [
        _menuItem(
          value: 'dashboard',
          icon: Icons.dashboard_rounded,
          label: 'Dashboard',
          color: AppTheme.primary,
        ),
        const PopupMenuDivider(height: 1),
        _menuItem(
          value: 'about',
          icon: Icons.info_outline_rounded,
          label: 'About',
          color: AppTheme.textSecondary,
        ),
      ],
    );
  }

  PopupMenuItem<String> _menuItem({
    required String value,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return PopupMenuItem<String>(
      value: value,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppTheme.surfaceCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppTheme.border, width: 1),
        ),
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Kibb',
                style: TextStyle(
                  color: AppTheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(
                text: 'com',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        content: const Text(
          'Site Management App\nVersion 1.0.0\n\n© 2026 Kibbcom.\nAll rights reserved.',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 13,
            height: 1.6,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(
                color: AppTheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Notification sidebar ──────────────────────────────────────
class _NotificationSidebar extends StatelessWidget {
  const _NotificationSidebar();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: screenWidth * 0.78,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              bottomLeft: Radius.circular(24),
            ),
            border: Border(
              left: BorderSide(color: AppTheme.border, width: 1),
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Sidebar header ─────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 12, 0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.notifications_none_rounded,
                        color: AppTheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Notifications',
                          style: TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceCard,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: AppTheme.border, width: 1),
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            color: AppTheme.textSecondary,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),
                const Divider(color: AppTheme.border, height: 1),

                // ── Empty state ────────────────────────
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.surfaceCard,
                            border: Border.all(
                                color: AppTheme.border, width: 1),
                          ),
                          child: const Icon(
                            Icons.notifications_off_outlined,
                            color: AppTheme.textSecondary,
                            size: 28,
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 400.ms)
                            .scaleXY(
                              begin: 0.8,
                              end: 1.0,
                              duration: 400.ms,
                              curve: Curves.easeOut,
                            ),
                        const SizedBox(height: 16),
                        const Text(
                          'No notifications',
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ).animate().fadeIn(delay: 150.ms, duration: 400.ms),
                        const SizedBox(height: 6),
                        const Text(
                          'You\'re all caught up!',
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 12,
                          ),
                        ).animate().fadeIn(delay: 250.ms, duration: 400.ms),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}