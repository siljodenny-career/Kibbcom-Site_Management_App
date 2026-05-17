import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:site_dashboard/viewmodel/site_provider.dart';

import '../theme/app_theme.dart';

class StatusSummaryCards extends ConsumerWidget {
  const StatusSummaryCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final siteState = ref.watch(siteProvider);

    // Shows '00' during loading, real count after fetch
    final activeCount = siteState.isLoading
        ? '00'
        : siteState.activeCount.toString().padLeft(2, '0');

    final maintenanceCount = siteState.isLoading
        ? '00'
        : siteState.maintenanceCount.toString().padLeft(2, '0');

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Row(
        children: [
          Expanded(
            child: _SummaryCard(
              label: 'Active',
              count: activeCount,
              icon: Icons.check_circle_outline_rounded,
              topColor: AppTheme.activeGreen,
              delay: 0,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _SummaryCard(
              label: 'Maintenance',
              count: maintenanceCount,
              icon: Icons.build_circle_outlined,
              topColor: AppTheme.maintOrange,
              delay: 120,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String count;
  final IconData icon;
  final Color topColor;
  final int delay;

  const _SummaryCard({
    required this.label,
    required this.count,
    required this.icon,
    required this.topColor,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: topColor.withValues(alpha: 0.25),
              width: 1,
            ),
            // Gradient fades from accent color at top to dark card at bottom
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                topColor.withValues(alpha: 0.22),
                topColor.withValues(alpha: 0.10),
                AppTheme.surfaceCard,
              ],
              stops: const [0.0, 0.45, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: topColor.withValues(alpha: 0.12),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Top row: icon + label
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: topColor.withValues(alpha: 0.15),
                        border: Border.all(
                          color: topColor.withValues(alpha: 0.35),
                          width: 1,
                        ),
                      ),
                      child: Icon(icon, color: topColor, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        label,
                        style: TextStyle(
                          color: topColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
    
                //Count
                Text(
                      count,
                      style: TextStyle(
                        color: topColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                        height: 1,
                      ),
                    )
                    .animate(onPlay: (c) => c.forward())
                    .fadeIn(
                      delay: Duration(milliseconds: delay),
                      duration: 500.ms,
                    )
                    .slideY(
                      begin: 0.3,
                      end: 0,
                      delay: Duration(milliseconds: delay),
                      duration: 500.ms,
                      curve: Curves.easeOut,
                    ),
    
                //Subtitle
                Text(
                  'Total Sites',
                  style: TextStyle(
                    color: topColor.withValues(alpha: 0.55),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: delay),
          duration: 400.ms,
        )
        .slideY(
          begin: 0.06,
          end: 0,
          delay: Duration(milliseconds: delay),
          duration: 400.ms,
          curve: Curves.easeOut,
        );
  }
}
