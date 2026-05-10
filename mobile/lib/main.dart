import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'screens/main_navigation_screen.dart';
import 'services/api_service.dart';
import 'services/auth_service.dart';
import 'screens/landing_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ProxyProvider<AuthService, ApiService>(
          update: (context, auth, apiService) => ApiService(authToken: auth.token),
        ),
      ],
      child: const LokalLinkApp(),
    ),
  );
}

class ThemeService extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class LokalLinkApp extends StatelessWidget {
  const LokalLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final authService = Provider.of<AuthService>(context);
    
    if (!authService.isInitialized) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark(),
        home: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp(
      key: ValueKey("${authService.isAuthenticated}_${authService.showAuth}_${authService.showRegister}"),
      debugShowCheckedModeBanner: false,
      title: 'LOKL',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeService.themeMode,
      home: _getHome(authService),
    );
  }
Widget _getHome(AuthService auth) {
  if (auth.isAuthenticated) {
    return const MainNavigationScreen();
  }

  // If user specifically requested Login/Register
  if (auth.showAuth) {
    return auth.showRegister ? const RegisterScreen() : const LoginScreen();
  }

  return FutureBuilder<bool>(
    future: auth.hasSeenLandingOnce(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      final hasSeenLanding = snapshot.data ?? false;

      // If never logged in and not in auth flow -> show landing
      if (!hasSeenLanding) {
        return const LandingScreen();
      }

      // Returning user -> show login
      return const LoginScreen();
    },
  );
}}
