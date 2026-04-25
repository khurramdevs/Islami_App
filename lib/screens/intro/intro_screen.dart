import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:islami/const/app_colors.dart';
import 'package:islami/screens/intro/intro_page_data.dart';
import 'package:islami/screens/intro/intro_provider.dart';
import 'package:islami/core/widgets/islami_header.dart';
import 'package:islami/screens/intro/widgets/language_page_content.dart';
import 'package:islami/screens/intro/widgets/content_page_content.dart';
import 'package:islami/screens/intro/widgets/intro_bottom_bar.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IntroProvider>.value(
      value: IntroProvider.instance,
      child: const Scaffold(
        backgroundColor: AppColors.black,
        body: _IntroBody(),
      ),
    );
  }
}

// Root body: orchestrates header, center content, and bottom bar

class _IntroBody extends StatelessWidget {
  const _IntroBody();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      fit: StackFit.expand,
      children: [
        IslamiHeader(positioned: true),
        _CenterContent(),
        IntroBottomBar(),
      ],
    );
  }
}

// Center content: switches between language page and content pages

class _CenterContent extends StatelessWidget {
  const _CenterContent();

  @override
  Widget build(BuildContext context) {
    return Consumer<IntroProvider>(
      builder: (context, provider, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          child: provider.currentPage == 0
              ? const LanguagePageContent(key: ValueKey(0))
              : ContentPageContent(
                  key: ValueKey(provider.currentPage),
                  data: IntroPageData.pages[provider.currentPage - 1],
                ),
        );
      },
    );
  }
}
