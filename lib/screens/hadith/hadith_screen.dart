import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islami/const/app_assets.dart';
import 'package:islami/const/app_colors.dart';
import 'package:islami/core/api_service.dart';
import 'package:islami/core/widgets/islami_header.dart';
import 'package:islami/models/hadith.dart';
import 'package:islami/screens/hadith/hadith_detail_screen.dart';

class HadithTab extends StatelessWidget {
  const HadithTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: Image.asset(AppAssets.hadithBackground, fit: BoxFit.cover),
        ),
        // Gradient overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.35, 1.0],
                colors: [
                  AppColors.black.withValues(alpha: 0.4),
                  AppColors.black.withValues(alpha: 0.85),
                  AppColors.black,
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              // Islami logo + mosque header
              const IslamiHeader(),
              const SizedBox(height: 12),
              // Hadith Name bar
              _buildHadithNameBar(),
              const SizedBox(height: 20),
              // Horizontal scrollable hadith cards
              Expanded(
                child: FutureBuilder<List<Hadith>>(
                  future: ApiService.fetchHadiths(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: AppColors.gold),
                      );
                    }
                    if (snapshot.hasError || !snapshot.hasData) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: AppColors.gold,
                              size: 48,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Failed to load hadiths',
                              style: TextStyle(
                                color: AppColors.white.withValues(alpha: 0.7),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    final hadiths = snapshot.data!;
                    return PageView.builder(
                      controller: PageController(viewportFraction: 0.82),
                      padEnds: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: hadiths.length,
                      itemBuilder: (context, index) {
                        final hadith = hadiths[index];
                        return _HadithCard(
                          hadith: hadith,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HadithDetailScreen(
                                hadith: hadith,
                                index: hadith.number,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHadithNameBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gold, width: 1.5),
          borderRadius: BorderRadius.circular(10),
          color: AppColors.black.withValues(alpha: 0.5),
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            SvgPicture.asset(
              AppAssets.bookSvg,
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                AppColors.gold,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Hadith Name',
                style: TextStyle(color: AppColors.white, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HadithCard extends StatelessWidget {
  final Hadith hadith;
  final VoidCallback onTap;

  const _HadithCard({required this.hadith, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.gold,
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Bottom mosque silhouette decoration
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Image.asset(
                AppAssets.bottom,
                fit: BoxFit.fitWidth,
                opacity: const AlwaysStoppedAnimation(0.25),
              ),
            ),
            // Card content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Title with corner decorations
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            AppAssets.borderL,
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          Image.asset(
                            AppAssets.borderR,
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                      Text(
                        hadith.title,
                        style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Hadith content
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Text(
                        hadith.content,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
