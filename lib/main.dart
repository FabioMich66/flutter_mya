import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/setup_page.dart';
import 'pages/launcher_page.dart';
import 'controllers/config_controller.dart';

void main() {
  runApp(const ProviderScope(child: LauncherApp()));
}

class LauncherApp extends ConsumerWidget {
  const LauncherApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: config.isConfigured
          ? const LauncherPage()
          : const SetupPage(),
    );
  }
}
