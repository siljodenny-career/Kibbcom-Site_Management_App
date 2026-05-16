import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/models/site_model.dart';
import '../theme/app_theme.dart';

class SiteDetailSheet extends StatelessWidget {
  final SiteModel site;

  const SiteDetailSheet({super.key, required this.site});

  static void show(BuildContext context, SiteModel site) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => SiteDetailSheet(site: site),
    );
  }

  Future<void> _callManager() async {
    final uri = Uri(scheme: 'tel', path: site.managerContact);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final isActive = site.status == SiteStatus.active;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: AppTheme.border,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Text(site.name, style: Theme.of(context).textTheme.titleLarge),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppTheme.activeGreen.withValues(alpha: 0.09)
                      : AppTheme.maintOrange.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isActive ? '● Active' : '● Maintenance',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isActive ? AppTheme.activeGreen : AppTheme.maintOrange,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _InfoRow(icon: Icons.location_on_outlined, label: 'Location', value: site.location),
          _InfoRow(icon: Icons.person_outlined,      label: 'Manager',  value: site.managerName),
          _InfoRow(icon: Icons.phone_outlined,        label: 'Contact',  value: site.managerContact),
          _InfoRow(icon: Icons.gps_fixed,             label: 'Latitude', value: site.gpsLat),
          _InfoRow(icon: Icons.gps_not_fixed,         label: 'Longitude',value: site.gpsLng),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.call_outlined, size: 18),
              label: const Text('Contact Manager',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: _callManager,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppTheme.primary),
          const SizedBox(width: 12),
          Text('$label  ', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    color: AppTheme.textPrimary, fontSize: 14, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
