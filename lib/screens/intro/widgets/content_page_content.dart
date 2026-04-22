import 'package:flutter/material.dart';
import 'package:islami/const/app_colors.dart';
import 'package:islami/screens/intro/intro_page_data.dart';

/// Pages 1–4: full-screen illustration with title + subtitle text.
class ContentPageContent extends StatelessWidget {
  const ContentPageContent({super.key, required this.data});

  final IntroPageData data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double titleFs = size.width * 0.056; // ≈24 on 430
    final double subtitleFs = size.width * 0.037; // ≈16 on 430

    return Stack(
      fit: StackFit.expand,
      children: [
        // Page illustration
        Positioned(
          top: size.height * 0.240,
          left: 0,
          right: 0,
          bottom: size.height * 0.300,
          child: Center(child: Image.asset(data.image, fit: BoxFit.contain)),
        ),
        // Title + subtitle
        Positioned(
          left: size.width * 0.08,
          right: size.width * 0.08,
          bottom: size.height * 0.130,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                data.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.gold,
                  fontSize: titleFs.clamp(20.0, 30.0),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: size.height * 0.016),
              Text(
                data.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.gold,
                  fontSize: subtitleFs.clamp(13.0, 18.0),
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
