import 'package:flutter/material.dart';
import 'package:islami/const/app_assets.dart';
import 'package:islami/const/app_colors.dart';
import 'package:islami/models/hadith.dart';

class HadithDetailScreen extends StatelessWidget {
  final Hadith hadith;
  final int index;

  const HadithDetailScreen({
    super.key,
    required this.hadith,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // App bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.gold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Hadith $index',
                        style: const TextStyle(
                          color: AppColors.gold,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Decorative borders + Arabic title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        AppAssets.borderL,
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        hadith.title,
                        style: const TextStyle(
                          color: AppColors.gold,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image.asset(
                        AppAssets.borderR,
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      hadith.content,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.gold,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
            // Bottom image
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: IgnorePointer(
                child: Image.asset(AppAssets.bottom, fit: BoxFit.fitWidth),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
