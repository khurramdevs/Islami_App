import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:islami/const/app_assets.dart';
import 'package:islami/const/app_colors.dart';
import 'package:islami/screens/home/home_provider.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        return Container(
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.black,
            border: Border(
              top: BorderSide(
                color: AppColors.gold.withValues(alpha: 0.3),
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                svgPath: AppAssets.quranSvg,
                label: 'Quran',
                isSelected: provider.currentTab == 0,
                onTap: () => provider.setTab(0),
              ),
              _NavItem(
                svgPath: AppAssets.bookSvg,
                label: 'Hadith',
                isSelected: provider.currentTab == 1,
                onTap: () => provider.setTab(1),
              ),
              _NavItem(
                svgPath: AppAssets.necklaceSvg,
                label: 'Sebha',
                isSelected: provider.currentTab == 2,
                onTap: () => provider.setTab(2),
              ),
              _NavItem(
                svgPath: AppAssets.radioSvg,
                label: 'Radio',
                isSelected: provider.currentTab == 3,
                onTap: () => provider.setTab(3),
              ),
              _NavItem(
                svgPath: AppAssets.vectorSvg,
                label: 'Time',
                isSelected: provider.currentTab == 4,
                onTap: () => provider.setTab(4),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  final String svgPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.svgPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.gold : AppColors.gray;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            if (isSelected) ...[
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
