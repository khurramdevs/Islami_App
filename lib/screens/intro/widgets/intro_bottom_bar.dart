import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:islami/const/app_colors.dart';
import 'package:islami/screens/intro/intro_provider.dart';
import 'package:islami/screens/home/home_screen.dart';

class IntroBottomBar extends StatelessWidget {
  const IntroBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double hPad = size.width * 0.065;

    return Positioned(
      left: 0,
      right: 0,
      bottom: size.height * 0.030,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: hPad),
        child: Consumer<IntroProvider>(
          builder: (context, provider, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _NavTextButton(
                  label: 'Back',
                  visible: !provider.isFirstPage,
                  onTap: provider.goToPreviousPage,
                ),
                const _PageIndicatorDots(),
                _NavTextButton(
                  label: provider.isLastPage ? 'Finish' : 'Next',
                  visible: true,
                  onTap: provider.isLastPage
                      ? () {
                          // Write the flag without awaiting — it completes in
                          // the background during the page transition animation.
                          // ignore: discarded_futures
                          IntroProvider.instance.completeOnboarding();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                        }
                      : provider.goToNextPage,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _NavTextButton extends StatelessWidget {
  const _NavTextButton({
    required this.label,
    required this.visible,
    required this.onTap,
  });

  final String label;
  final bool visible;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final double fs = MediaQuery.sizeOf(context).width * 0.042;

    return Opacity(
      opacity: visible ? 1.0 : 0.0,
      child: IgnorePointer(
        ignoring: !visible,
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.gold,
              fontSize: fs.clamp(14.0, 22.0),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

class _PageIndicatorDots extends StatelessWidget {
  const _PageIndicatorDots();

  @override
  Widget build(BuildContext context) {
    final double dotH = MediaQuery.sizeOf(context).height * 0.0086;

    return Consumer<IntroProvider>(
      builder: (context, provider, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(IntroProvider.totalPages, (index) {
            return _Dot(
              isActive: provider.currentPage == index,
              dotHeight: dotH.clamp(6.0, 10.0),
            );
          }),
        );
      },
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.isActive, required this.dotHeight});

  final bool isActive;
  final double dotHeight;

  @override
  Widget build(BuildContext context) {
    final double activeW = dotHeight * 3.14;
    final double inactiveW = dotHeight;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 5.5),
      width: isActive ? activeW : inactiveW,
      height: dotHeight,
      decoration: BoxDecoration(
        color: isActive ? AppColors.gold : AppColors.gray,
        borderRadius: BorderRadius.circular(dotHeight / 2),
      ),
    );
  }
}
