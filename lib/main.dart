import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_portfolio/common/splash/light_splash.dart';
import 'package:my_portfolio/features/authentication/services/authentication_service.dart';
import 'package:my_portfolio/common/themes/dark_theme.dart';
import 'package:my_portfolio/common/firebase_options.dart';
import 'package:my_portfolio/common/themes/light_theme.dart';
import 'package:my_portfolio/features/authentication/controllers/obscure_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  // Ensure that the Flutter framework is initialized before calling SystemChrome
  WidgetsFlutterBinding.ensureInitialized();
  // Hide the status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthenticationService()),
          ChangeNotifierProvider(create: (_) => ObscureProvider()),
        ],
        child: MaterialApp(
            title: 'Portfolio',
            theme: lightTheme,
            darkTheme: customDarkTheme,
            themeMode: ThemeMode.light,
            home: SplashLight()));
  }
}
