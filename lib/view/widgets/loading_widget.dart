import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20,),
        //Shimmer skeleton cards
        ..._buildSkeletonCards(),
      ],
    );
  }

  List<Widget> _buildSkeletonCards() {
    return List.generate(4, (i) => _SkeletonCard(index: i));
  }
}

// ── Single shimmer skeleton card ──────────────────────────────
class _SkeletonCard extends StatelessWidget {
  final int index;
  const _SkeletonCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppTheme.surfaceCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.border, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _ShimmerBox(
                    width: 8,
                    height: 8,
                    radius: 4,
                    delay: Duration(milliseconds: 100 * index),
                  ),
                  const SizedBox(width: 10),
                  _ShimmerBox(
                    width: 160,
                    height: 14,
                    radius: 6,
                    delay: Duration(milliseconds: 100 * index + 50),
                  ),
                  const Spacer(),
                  _ShimmerBox(
                    width: 44,
                    height: 24,
                    radius: 12,
                    delay: Duration(milliseconds: 100 * index + 80),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  _ShimmerBox(
                    width: 12,
                    height: 12,
                    radius: 3,
                    delay: Duration(milliseconds: 100 * index + 100),
                  ),
                  const SizedBox(width: 6),
                  _ShimmerBox(
                    width: 110,
                    height: 11,
                    radius: 5,
                    delay: Duration(milliseconds: 100 * index + 120),
                  ),
                  const Spacer(),
                  _ShimmerBox(
                    width: 72,
                    height: 22,
                    radius: 11,
                    delay: Duration(milliseconds: 100 * index + 140),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  _ShimmerBox(
                    width: 12,
                    height: 12,
                    radius: 3,
                    delay: Duration(milliseconds: 100 * index + 160),
                  ),
                  const SizedBox(width: 6),
                  _ShimmerBox(
                    width: 90,
                    height: 11,
                    radius: 5,
                    delay: Duration(milliseconds: 100 * index + 180),
                  ),
                ],
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 80 * index),
          duration: 400.ms,
        )
        .slideY(
          begin: 0.06,
          end: 0,
          delay: Duration(milliseconds: 80 * index),
          duration: 400.ms,
        );
  }
}

// ── Shimmer box primitive ─────────────────────────────────────
class _ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Duration delay;

  const _ShimmerBox({
    required this.width,
    required this.height,
    required this.radius,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppTheme.border,
            borderRadius: BorderRadius.circular(radius),
          ),
        )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .shimmer(
          delay: delay,
          duration: 1200.ms,
          color: AppTheme.textSecondary.withOpacity(0.15),
        );
  }
}
