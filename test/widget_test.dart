import 'package:flutter_test/flutter_test.dart';

import 'package:coo_app_flutter/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CoownableApp());
    await tester.pump();
  });
}
