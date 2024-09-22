import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:study/auth/noInternetConnection.dart';
import 'package:study/main.dart';
import 'package:study/provider.dart'; // Update to your main.dart file location

void main() {
  testWidgets('MyApp displays NoConnectionPage when there is no connection', (WidgetTester tester) async {
    // Arrange: Create a mock DataProvider
    final mockProvider = DataProvider();

    // Act: Build the MyApp widget with no connection
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => mockProvider,
        child: MyApp(hasConnection: false), // Pass hasConnection as false
      ),
    );

    // Assert: Check if NoConnectionPage is displayed
    expect(find.byType(NoConnectionPage), findsOneWidget);
  });
}
