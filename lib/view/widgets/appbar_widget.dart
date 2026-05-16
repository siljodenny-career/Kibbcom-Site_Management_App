import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../screens/dashboard_screen.dart';

class KibbcomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onNavigateToDashboard;
  final bool showDashboardMenu;

  const KibbcomAppBar({
    super.key,
    this.onNavigateToDashboard,
    this.showDashboardMenu = true,
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
            position:
                Tween<Offset>(
                  begin: const Offset(1.0, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                ),
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
          showDashboardMenu: showDashboardMenu,
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
  final bool showDashboardMenu;

  const _ThreeDotMenu({
    required this.onNavigateToDashboard,
    this.showDashboardMenu = true,
  });

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
        // Dashboard item — only on HomeScreen
        if (showDashboardMenu) ...[
          _menuItem(
            value: 'dashboard',
            icon: Icons.dashboard_rounded,
            label: 'Dashboard',
            color: AppTheme.primary,
          ),
          const PopupMenuDivider(height: 1),
        ],

        // About — always visible on every screen
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

class _NotificationSidebar extends StatelessWidget {
  const _NotificationSidebar();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Material(
      // ← ADD THIS
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: screenWidth * 0.78,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28),
                bottomLeft: Radius.circular(28),
              ),
              border: Border(
                left: BorderSide(color: AppTheme.border, width: 1),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SidebarHeader(),

                  const SizedBox(height: 8),
                  const Divider(
                    color: AppTheme.border,
                    height: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  const Expanded(child: _EmptyState()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Sidebar header ────────────────────────────────────────────
class _SidebarHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Icon badge
              Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primary.withValues(alpha: 0.12),
                      border: Border.all(
                        color: AppTheme.primary.withValues(alpha: 0.35),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      color: AppTheme.primary,
                      size: 20,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 300.ms)
                  .scaleXY(
                    begin: 0.7,
                    end: 1.0,
                    duration: 400.ms,
                    curve: Curves.easeOutBack,
                  ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                          'Notifications',
                          style: TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 100.ms, duration: 300.ms)
                        .slideX(begin: 0.1, end: 0),

                    const Text(
                      'Stay up to date',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ).animate().fadeIn(delay: 150.ms, duration: 300.ms),
                  ],
                ),
              ),

              // Close button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceCard,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.border, width: 1),
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: AppTheme.textSecondary,
                    size: 16,
                  ),
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 300.ms),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Layered circle illustration
          Stack(
                alignment: Alignment.center,
                children: [
                  // Outer glow ring
                  Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.primary.withValues(alpha: 0.04),
                          border: Border.all(
                            color: AppTheme.primary.withValues(alpha: 0.08),
                            width: 1,
                          ),
                        ),
                      )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .scaleXY(
                        begin: 0.95,
                        end: 1.05,
                        duration: 2000.ms,
                        curve: Curves.easeInOut,
                      ),

                  // Middle ring
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primary.withValues(alpha: 0.07),
                      border: Border.all(
                        color: AppTheme.primary.withValues(alpha: 0.15),
                        width: 1,
                      ),
                    ),
                  ),

                  // Inner icon circle
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.surfaceCard,
                      border: Border.all(color: AppTheme.border, width: 1),
                    ),
                    child: const Icon(
                      Icons.notifications_off_outlined,
                      color: AppTheme.textSecondary,
                      size: 24,
                    ),
                  ),
                ],
              )
              .animate()
              .fadeIn(delay: 200.ms, duration: 400.ms)
              .scaleXY(
                begin: 0.8,
                end: 1.0,
                delay: 200.ms,
                duration: 500.ms,
                curve: Curves.easeOutBack,
              ),

          const SizedBox(height: 24),

          // Title
          const Text(
                'No notifications',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                ),
              )
              .animate()
              .fadeIn(delay: 300.ms, duration: 400.ms)
              .slideY(begin: 0.2, end: 0, delay: 300.ms, duration: 400.ms),

          const SizedBox(height: 6),

          // Subtitle
          const Text(
            "You're all caught up!\nNo new updates at the moment.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 12,
              height: 1.6,
            ),
          ).animate().fadeIn(delay: 380.ms, duration: 400.ms),
        ],
      ),
    );
  }
}
