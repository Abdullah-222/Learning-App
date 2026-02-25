import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:secure_learning_app/firebase_options.dart';
import 'package:secure_learning_app/controllers/settings_controller.dart';
import 'package:secure_learning_app/constants.dart';
import 'package:secure_learning_app/services/auth_service.dart';
import 'package:secure_learning_app/services/firebase_auth_service.dart';
import 'package:secure_learning_app/controllers/auth_controller.dart';
import 'package:secure_learning_app/screens/login_screen.dart';

import 'screens/main_shell_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();

  final settingsController = SettingsController(prefs);

  // Initialize Auth
  final authService = FirebaseAuthService();
  final authController = AuthController(authService);
  await authController.checkAuthStatus();

  runApp(SecureLearningApp(
    settingsController: settingsController,
    authController: authController,
  ));
}

class SecureLearningApp extends StatelessWidget {
  const SecureLearningApp({
    super.key, 
    required this.settingsController,
    required this.authController,
  });

  final SettingsController settingsController;
  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: settingsController),
        ChangeNotifierProvider.value(value: authController),
      ],
      child: Consumer<SettingsController>(
        builder: (context, controller, child) {
          return MaterialApp(
            title: 'learning app',
            debugShowCheckedModeBanner: false,
            themeMode: controller.themeMode,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(controller.fontSize),
                ),
                child: child!,
              );
            },
            home: const AuthWrapper(),
          );
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, auth, _) {
        if (auth.isAuthenticated) {
          return const MainShellScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
