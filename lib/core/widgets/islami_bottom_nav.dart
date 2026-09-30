import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islami/const/app_colors.dart';

/// Reusable bottom navigation bar styled for the Islami app.
///
/// [currentIndex] is the active tab index.
/// [onTap] is called when a tab is tapped.
/// [items] defines the tabs (icon + label).
class IslamiBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<IslamiNavItem> items;

  const IslamiBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: AppColors.gold,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == currentIndex;
          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: _NavItemWidget(item: item, isSelected: isSelected),
          );
        }),
      ),
    );
  }
}

class _NavItemWidget extends StatelessWidget {
  final IslamiNavItem item;
  final bool isSelected;

  const _NavItemWidget({required this.item, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: isSelected
          ? BoxDecoration(
              color: const Color(0xFF202020),
              borderRadius: BorderRadius.circular(24),
            )
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            item.svgPath,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              isSelected ? AppColors.white : const Color(0xFF202020),
              BlendMode.srcIn,
            ),
          ),
          if (isSelected) ...[
            const SizedBox(height: 4),
            Text(
              item.label,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Data class for a single bottom-nav item.
class IslamiNavItem {
  final String svgPath;
  final String label;

  const IslamiNavItem({required this.svgPath, required this.label});
}
