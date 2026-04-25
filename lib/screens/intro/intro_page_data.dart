import 'package:islami/const/app_assets.dart';
import 'package:islami/const/app_strings.dart';

// Data model for a single intro content page (pages 1 to 4).

class IntroPageData {
  const IntroPageData({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;

  // The four content pages that follow the language-selection page.
  static const List<IntroPageData> pages = [
    IntroPageData(
      image: AppAssets.kabba,
      title: AppStrings.welcomeTitle,
      subtitle: AppStrings.welcomeSubtitle,
    ),
    IntroPageData(
      image: AppAssets.welcome,
      title: AppStrings.quranTitle,
      subtitle: AppStrings.quranSubtitle,
    ),
    IntroPageData(
      image: AppAssets.bearish,
      title: AppStrings.bearishTitle,
      subtitle: AppStrings.bearishSubtitle,
    ),
    IntroPageData(
      image: AppAssets.radio,
      title: AppStrings.radioTitle,
      subtitle: AppStrings.radioSubtitle,
    ),
  ];
}
