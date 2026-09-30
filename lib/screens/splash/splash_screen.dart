import 'package:flutter/material.dart';
import 'package:islami/const/app_colors.dart';
import 'package:islami/screens/home/home_screen.dart';
import 'package:islami/screens/intro/intro_provider.dart';
import 'package:islami/screens/intro/intro_screen.dart';
import 'package:islami/screens/splash/widgets/splash_body.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    // Run the flag check and the 3-second splash delay concurrently.
    // There is no extra startup cost — SharedPreferences.getInstance() is
    // essentially instant relative to the animation delay.
    final results = await Future.wait([
      IntroProvider.instance.checkOnboardingDone(),
      Future<void>.delayed(const Duration(seconds: 3)),
    ]);

    if (!mounted) return;

    final bool onboardingDone = results[0] as bool;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            onboardingDone ? const HomeScreen() : const IntroScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: AppColors.black, body: SplashBody());
  }
}
