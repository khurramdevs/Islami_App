import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:islami/const/app_assets.dart';
import 'package:islami/const/app_colors.dart';
import 'package:islami/core/widgets/islami_bottom_nav.dart';
import 'package:islami/screens/hadith/hadith_screen.dart';
import 'package:islami/screens/home/home_provider.dart';
import 'package:islami/screens/home/widgets/home_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    HomeProvider.instance.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>.value(
      value: HomeProvider.instance,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Consumer<HomeProvider>(
          builder: (context, provider, _) {
            return _buildBody(provider.currentTab);
          },
        ),
        bottomNavigationBar: Consumer<HomeProvider>(
          builder: (context, provider, _) {
            return IslamiBottomNav(
              currentIndex: provider.currentTab,
              onTap: provider.setTab,
              items: const [
                IslamiNavItem(svgPath: AppAssets.quranSvg, label: 'Quran'),
                IslamiNavItem(svgPath: AppAssets.bookSvg, label: 'Hadith'),
                IslamiNavItem(svgPath: AppAssets.necklaceSvg, label: 'Sebha'),
                IslamiNavItem(svgPath: AppAssets.radioSvg, label: 'Radio'),
                IslamiNavItem(svgPath: AppAssets.vectorSvg, label: 'Time'),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(int tab) {
    switch (tab) {
      case 0:
        return const HomeBody();
      case 1:
        return const HadithTab();
      default:
        return const HomeBody();
    }
  }
}
