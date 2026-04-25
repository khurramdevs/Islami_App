import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:islami/const/app_assets.dart';
import 'package:islami/const/app_colors.dart';
import 'package:islami/core/widgets/islami_header.dart';
import 'package:islami/screens/home/home_provider.dart';
import 'package:islami/models/sura.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(AppAssets.tajMahl, fit: BoxFit.cover),
            ),
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
                  // Search bar
                  _buildSearchBar(provider),
                  const SizedBox(height: 16),
                  // Scrollable content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Most Recently section
                          _buildMostRecently(provider),
                          const SizedBox(height: 16),
                          // Suras List header
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Suras List',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Suras list
                          _buildSurasList(provider),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchBar(HomeProvider provider) {
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
              AppAssets.quranSvg,
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                AppColors.gold,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                onChanged: provider.updateSearch,
                style: const TextStyle(color: AppColors.white, fontSize: 15),
                decoration: const InputDecoration(
                  hintText: 'Sura Name',
                  hintStyle: TextStyle(color: AppColors.white, fontSize: 15),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Most Recently Section

  Widget _buildMostRecently(HomeProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Most Recently',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: provider.recentSuras.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final sura = provider.recentSuras[index];
              return _RecentSuraCard(sura: sura);
            },
          ),
        ),
      ],
    );
  }

  // Suras List

  Widget _buildSurasList(HomeProvider provider) {
    final suras = provider.filteredSuras;
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: suras.length,
      separatorBuilder: (_, __) => Divider(
        color: AppColors.gold.withValues(alpha: 0.25),
        height: 1,
        thickness: 0.5,
      ),
      itemBuilder: (context, index) {
        final sura = suras[index];
        return _SuraListTile(sura: sura);
      },
    );
  }
}

// Recent Sura Card

class _RecentSuraCard extends StatelessWidget {
  final Sura sura;
  const _RecentSuraCard({required this.sura});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 283,
      height: 150,
      decoration: BoxDecoration(
        color: AppColors.gold,
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage(AppAssets.rectanglePng),
          fit: BoxFit.cover,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Book / Quran illustration
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: Image.asset(
              AppAssets.rectanglePng,
              fit: BoxFit.contain,
              height: 136,
            ),
          ),
          // Text content
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  sura.nameEn,
                  style: const TextStyle(
                    color: Color(0xFF2C2C2C),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  sura.nameAr,
                  style: const TextStyle(
                    color: Color(0xFF4A4A4A),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${sura.verses} Verses',
                  style: const TextStyle(
                    color: Color(0xFF5A5A5A),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SuraListTile extends StatelessWidget {
  final Sura sura;
  const _SuraListTile({required this.sura});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // Number inside SVG frame
          SizedBox(
            width: 42,
            height: 42,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.numberFrameSvg,
                  width: 42,
                  height: 42,
                  colorFilter: const ColorFilter.mode(
                    AppColors.gold,
                    BlendMode.srcIn,
                  ),
                ),
                Text(
                  '${sura.number}',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          // English name and verse count
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sura.nameEn,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${sura.verses} Verses',
                  style: TextStyle(
                    color: AppColors.white.withValues(alpha: 0.55),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Arabic name
          Text(
            sura.nameAr,
            style: const TextStyle(
              color: AppColors.gold,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
