import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'view/screens/dashboard_screen.dart';
import 'view/theme/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: SiteDashboardApp(),
    ),
  );
}

class SiteDashboardApp extends StatelessWidget {
  const SiteDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Site Dashboard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const DashboardScreen(),
    );
  }
}
