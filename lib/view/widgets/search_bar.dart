import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodel/providers/search_provider.dart';
import '../theme/app_theme.dart';

class SiteSearchBar extends ConsumerWidget {
  const SiteSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: TextField(
        onChanged: (val) => ref.read(searchQueryProvider.notifier).state = val,
        style: const TextStyle(color: AppTheme.textPrimary, fontSize: 15),
        cursorColor: AppTheme.primary,
        decoration: InputDecoration(
          hintText: 'Search sites...',
          hintStyle: const TextStyle(color: AppTheme.textSecondary),
          prefixIcon: const Icon(Icons.search, color: AppTheme.textSecondary, size: 20),
          filled: true,
          fillColor: AppTheme.surfaceCard,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppTheme.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppTheme.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppTheme.primary, width: 1.5),
          ),
        ),
      ),
    );
  }
}
