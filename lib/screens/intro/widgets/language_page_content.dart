import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:islami/const/app_assets.dart';
import 'package:islami/const/app_colors.dart';
import 'package:islami/const/app_strings.dart';
import 'package:islami/screens/intro/intro_provider.dart';

/// Page 0: Arabic calligraphy illustration + language chooser.
class LanguagePageContent extends StatelessWidget {
  const LanguagePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        // Calligraphy illustration
        Positioned(
          top: size.height * 0.278,
          left: 0,
          right: 0,
          child: Center(
            child: Image.asset(
              AppAssets.group,
              width: size.width * 0.820,
              fit: BoxFit.contain,
            ),
          ),
        ),
        // Language label + toggle
        Positioned(
          left: 0,
          right: 0,
          bottom: size.height * 0.130,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _ChoseLanguageLabel(),
              SizedBox(height: size.height * 0.044),
              const _LanguageToggle(),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── "Chose Language" label ─────────────────────────────────────────────────

class _ChoseLanguageLabel extends StatelessWidget {
  const _ChoseLanguageLabel();

  @override
  Widget build(BuildContext context) {
    final double fs = MediaQuery.sizeOf(context).width * 0.042;

    return Text(
      AppStrings.choseLanguage,
      style: TextStyle(
        color: AppColors.gold,
        fontSize: fs.clamp(16.0, 24.0),
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
    );
  }
}

// ─── Language toggle (US → English / Pak → Urdu) ─────────────────────────────

class _LanguageToggle extends StatelessWidget {
  const _LanguageToggle();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double containerW = size.width * 0.380;
    final double containerH = size.width * 0.120;
    final double radius = containerH / 2;

    return Consumer<IntroProvider>(
      builder: (context, provider, child) {
        return Container(
          width: containerW,
          height: containerH,
          decoration: BoxDecoration(
            color: const Color(0xFF2E2B25),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: AppColors.gold, width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              children: [
                Expanded(
                  child: _FlagButton(
                    flagAsset: AppAssets.flagUS,
                    isSelected: provider.isEnglishSelected,
                    onTap: () => provider.selectLanguage(IntroLanguage.english),
                    height: containerH - 6,
                    radius: radius - 3,
                  ),
                ),
                const SizedBox(width: 2),
                Expanded(
                  child: _FlagButton(
                    flagAsset: AppAssets.flagPak,
                    isSelected: !provider.isEnglishSelected,
                    onTap: () => provider.selectLanguage(IntroLanguage.urdu),
                    height: containerH - 6,
                    radius: radius - 3,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─── Flag button ─────────────────────────────────────────────────────────────

class _FlagButton extends StatelessWidget {
  const _FlagButton({
    required this.flagAsset,
    required this.isSelected,
    required this.onTap,
    required this.height,
    required this.radius,
  });

  final String flagAsset;
  final bool isSelected;
  final VoidCallback onTap;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final double flagSize = height * 0.70;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gold : Colors.transparent,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: ClipOval(
            child: Image.asset(
              flagAsset,
              width: flagSize,
              height: flagSize,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
