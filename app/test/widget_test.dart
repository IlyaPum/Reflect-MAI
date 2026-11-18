// Базовый smoke-тест главного экрана Reflect.
import 'package:flutter_test/flutter_test.dart';

import 'package:reflect_app/main.dart';

void main() {
  testWidgets('Главный экран показывает заглушку карты и кнопку съёмки',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ReflectApp());

    expect(find.text('Reflect'), findsOneWidget);
    expect(find.text('Снять здание'), findsOneWidget);
    expect(find.text('Здесь будет офлайн-карта кампуса МАИ'), findsOneWidget);
  });
}
