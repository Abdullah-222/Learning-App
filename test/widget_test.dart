import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:secure_learning_app/main.dart';
import 'package:secure_learning_app/controllers/settings_controller.dart';
import 'package:secure_learning_app/services/auth_service.dart';
import 'package:secure_learning_app/controllers/auth_controller.dart';

void main() {
  testWidgets('Home screen smoke test', (WidgetTester tester) async {
    // Mock SharedPreferences
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    
    final settingsController = SettingsController(prefs);

    final authService = MockAuthService();
    final authController = AuthController(authService);
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(SecureLearningApp(
      settingsController: settingsController,
      authController: authController, // Added missing dependency
    ));
    
    // Trigger a frame.
    await tester.pumpAndSettle();

    // Verify that "Welcome Back" (Login Screen) is present.
    expect(find.text('Welcome Back'), findsOneWidget);
    
    // Verify that "LOGIN" button is present.
    expect(find.text('LOGIN'), findsOneWidget);
  });
}
