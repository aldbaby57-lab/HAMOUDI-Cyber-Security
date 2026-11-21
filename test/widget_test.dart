import 'package:flutter_test/flutter_test.dart';
import 'package:hamoudi_cyber_security/main.dart';

void main() {
  testWidgets('HAMOUDI app starts', (WidgetTester tester) async {
    await tester.pumpWidget(const HamoudiApp());

    expect(find.byType(HamoudiApp), findsOneWidget);
  });
}