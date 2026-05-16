import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:site_dashboard/view/screens/splash_screen.dart';
import 'view/theme/app_theme.dart';

void main() {

    WidgetsFlutterBinding.ensureInitialized();

  // ── Get real physical screen width before app builds ──
  final view = WidgetsBinding.instance.platformDispatcher.views.first;
  final physicalWidth = view.physicalSize.width;
  final devicePixelRatio = view.devicePixelRatio;
  final logicalWidth = physicalWidth / devicePixelRatio;

  runApp(
    DevicePreview(
      enabled: _shouldEnableDevicePreview(logicalWidth),
      builder: (context) => const ProviderScope(child: SiteDashboardApp()),
    ),
  );
}

bool _shouldEnableDevicePreview(double logicalWidth) {
  // Never show on native mobile platforms regardless of screen size
  if (!kIsWeb) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return false;

      case TargetPlatform.windows:
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
        return true;
    }
  }
  //LAptop Screen size
  return logicalWidth >= 1024;
}

class SiteDashboardApp extends StatelessWidget {
  const SiteDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Site Dashboard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      //Required for DevicePreview to work properly
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: const SplashScreen(),
    );
  }
}
