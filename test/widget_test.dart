import 'package:flutter_test/flutter_test.dart';
import 'package:islami/main.dart';
import 'package:islami/screens/splash/splash_screen.dart';

void main() {
  testWidgets('SplashScreen renders inside IslamiApp', (WidgetTester tester) async {
    await tester.pumpWidget(const IslamiApp());
    expect(find.byType(SplashScreen), findsOneWidget);
  });
}
