import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_awesome, size: 80, color: AppColors.gold),
            const SizedBox(height: 24),
            Text(
              "Falsal",
              style: TextStyle(
                color: AppColors.gold,
                fontSize: 36,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Geleceğini keşfet!",
              style: TextStyle(
                color: AppColors.lightGrey,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 