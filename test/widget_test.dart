import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wm_app/app.dart';

void main() {
  testWidgets('WmApp smoke test initializes', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: WmApp(),
      ),
    );
    expect(find.byType(WmApp), findsOneWidget);
  });
}
