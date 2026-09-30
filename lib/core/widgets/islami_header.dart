import 'package:flutter/material.dart';
import 'package:islami/const/app_assets.dart';

/* Reusable header widget showing the mosque silhouette and Islami wordmark.

 Can be used as a direct child inside a [Stack] (positioned mode) or as a
 normal widget inside a [Column] / [SliverToBoxAdapter].
 When [positioned] is `true` (default) the header wraps itself in a
 [Positioned] widget suitable for a parent [Stack] (used in the intro screen).
 Set [positioned] to `false` to use it as a regular box widget (home screen).*/

class IslamiHeader extends StatelessWidget {
  /// If `true`, wraps the header in a [Positioned] widget.
  final bool positioned;

  const IslamiHeader({super.key, this.positioned = false});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double headerH = size.height * 0.22;
    final double mosqueTop = size.height * 0.025;
    final double mosqueW = size.width * 0.677;
    final double islaTop = size.height * 0.105;
    final double islaW = size.width * 0.386;

    final child = SizedBox(
      height: headerH,
      child: Stack(
        children: [
          Positioned(
            top: mosqueTop,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                AppAssets.mosque,
                width: mosqueW,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: islaTop,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                AppAssets.islami,
                width: islaW,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );

    if (positioned) {
      return Positioned(
        top: 0,
        left: 0,
        right: 0,
        height: headerH,
        child: child,
      );
    }

    return child;
  }
}
