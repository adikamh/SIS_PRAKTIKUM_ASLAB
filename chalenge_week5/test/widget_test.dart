import 'package:device_preview/device_preview.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chalenge_week5/main.dart';

void main() {
  testWidgets('Smoke test Toko CH app launch', (WidgetTester tester) async {
    await tester.pumpWidget(
      DevicePreview(
        enabled: false,
        builder: (context) => const MyApp(),
      ),
    );
    expect(find.byType(MyApp), findsOneWidget);
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });
}
