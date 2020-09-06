import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WidgetCustomShimmer extends StatelessWidget {
  final Color baseColor;
  final Color highlightColor;
  final Widget child;

  WidgetCustomShimmer({
    this.baseColor = const Color(0xFFEEEEEE),
    this.highlightColor = const Color(0xFFF5F5F5),
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: child,
    );
  }
}
