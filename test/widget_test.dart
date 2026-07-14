import 'package:flutter_test/flutter_test.dart';
import 'package:smart_market/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SmartMarketApp());
    expect(find.text('Smart Market'), findsOneWidget);
  });
}
