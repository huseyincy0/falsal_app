import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/splash_screen.dart';
import 'features/home/home_screen.dart';

void main() {
  runApp(const FalsalApp());
}

class FalsalApp extends StatelessWidget {
  const FalsalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Falsal',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
