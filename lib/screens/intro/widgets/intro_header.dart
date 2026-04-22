import 'package:flutter/material.dart';
import 'package:islami/const/app_assets.dart';

/// Shared header across all intro pages: mosque silhouette + Islami wordmark.
class IntroHeader extends StatelessWidget {
  const IntroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double mosqueTop = size.height * 0.043;
    final double mosqueW = size.width * 0.677;
    final double islaTop = size.height * 0.123;
    final double islaW = size.width * 0.386;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: size.height * 0.22,
      child: Stack(
        children: [
          Positioned(
            top: mosqueTop,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                AppAssets.mosque,
                width: mosqueW,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: islaTop,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                AppAssets.islami,
                width: islaW,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
