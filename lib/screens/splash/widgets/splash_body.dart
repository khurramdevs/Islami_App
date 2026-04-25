import 'package:flutter/material.dart';
import 'package:islami/const/app_assets.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        _Background(),
        _LeftOrnament(),
        _RightOrnament(),
        _HangingLamp(),
        _MosqueOutline(),
        _MosqueLogo(),
        _IslamiWordmark(),
      ],
    );
  }
}

// Background

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(AppAssets.background, fit: BoxFit.cover),
    );
  }
}

class _LeftOrnament extends StatelessWidget {
  const _LeftOrnament();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Positioned(
      top: size.height * 0.231,
      left: 0,
      width: size.width * 0.203,
      child: Image.asset(AppAssets.shape2, fit: BoxFit.contain),
    );
  }
}

class _RightOrnament extends StatelessWidget {
  const _RightOrnament();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Positioned(
      bottom: size.height * 0.114,
      right: 0,
      width: size.width * 0.236,
      child: Image.asset(AppAssets.shape1, fit: BoxFit.contain),
    );
  }
}

class _HangingLamp extends StatelessWidget {
  const _HangingLamp();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Positioned(
      top: 0,
      right: size.width * 0.02,
      width: size.width * 0.18,
      height: size.height * 0.36,
      child: Image.asset(
        AppAssets.lamp,
        fit: BoxFit.contain,
        alignment: Alignment.topCenter,
      ),
    );
  }
}

class _MosqueOutline extends StatelessWidget {
  const _MosqueOutline();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Positioned(
      top: size.height * 0.062,
      left: 0,
      right: 0,
      child: Center(
        child: Image.asset(
          AppAssets.mosque,
          width: size.width * 0.680,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

// Mosque logo

class _MosqueLogo extends StatelessWidget {
  const _MosqueLogo();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Positioned(
      top: size.height * 0.368,
      left: 0,
      right: 0,
      child: Center(
        child: Image.asset(
          AppAssets.object,
          width: size.width * 0.406,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

// Islami wordmark

class _IslamiWordmark extends StatelessWidget {
  const _IslamiWordmark();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Positioned(
      top: size.height * 0.536,
      left: 0,
      right: 0,
      child: Center(
        child: Image.asset(
          AppAssets.islami,
          width: size.width * 0.388,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
