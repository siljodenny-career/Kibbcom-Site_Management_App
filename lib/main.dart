import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:site_dashboard/view/screens/splash_screen.dart';
import 'view/theme/app_theme.dart';

void main() {
  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: true,
        backgroundColor: Colors.black,
        builder: (context) => const SiteDashboardApp(),
      ),
    ),
  );
}

class SiteDashboardApp extends StatelessWidget {
  const SiteDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Site Dashboard',

      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const SplashScreen(),
    );
  }
}
