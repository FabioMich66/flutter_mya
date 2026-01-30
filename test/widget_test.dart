import 'package:flutter_test/flutter_test.dart';
import 'package:launcher_flutter/main.dart';

void main() {
  testWidgets('LauncherApp loads', (tester) async {
    await tester.pumpWidget(const LauncherApp());
    expect(find.byType(LauncherApp), findsOneWidget);
  });
}

