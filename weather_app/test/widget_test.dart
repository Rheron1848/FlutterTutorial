import 'package:flutter_test/flutter_test.dart';

import 'package:weather_app/main.dart';

void main() {
  testWidgets('应用启动后显示天气查询页面', (tester) async {
    await tester.pumpWidget(const WeatherApp());

    expect(find.text('天气查询'), findsOneWidget);
  });
}
