import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/models/site_model.dart';
import '../../viewmodel/providers/site_provider.dart';
import '../theme/app_theme.dart';

class SiteCard extends ConsumerWidget {
  final SiteModel site;
  final int index;
  final VoidCallback onTap;

  const SiteCard({
    super.key,
    required this.site,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = site.status == SiteStatus.active;

    return Animate(
      effects: [
        FadeEffect(
          delay: Duration(milliseconds: 80 * index),
          duration: 400.ms,
        ),
        SlideEffect(
          delay: Duration(milliseconds: 80 * index),
          duration: 400.ms,
          begin: const Offset(0, 0.08),
          end: Offset.zero,
        ),
      ],
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.surfaceCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.border, width: 1),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            splashColor: AppTheme.primary.withValues(alpha: 0.08),
            highlightColor: AppTheme.primary.withValues(alpha: 0.04),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(right: 10, top: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive
                              ? AppTheme.activeGreen
                              : AppTheme.maintOrange,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          site.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Switch(
                        value: isActive,
                        activeThumbColor: AppTheme.activeGreen,
                        inactiveThumbColor: AppTheme.maintOrange,
                        inactiveTrackColor: AppTheme.maintOrange.withValues(
                          alpha: 0.25,
                        ),
                        activeTrackColor: AppTheme.activeGreen.withValues(
                          alpha: 0.25,
                        ),
                        onChanged: (_) {
                          ref.read(siteProvider.notifier).toggleStatus(site.id);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 14,
                        color: AppTheme.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        site.managerName,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: AppTheme.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        site.location,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppTheme.activeGreen.withValues(alpha: 0.05)
                              : AppTheme.maintOrange.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          isActive ? 'Active' : 'Maintenance',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: isActive
                                ? AppTheme.activeGreen
                                : AppTheme.maintOrange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
