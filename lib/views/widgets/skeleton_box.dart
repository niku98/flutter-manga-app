import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double borderRadius;

  SkeletonBox(
      {@required this.width,
      @required this.height,
      this.borderRadius = 3,
      this.color});

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: color ?? Colors.grey[200],
            borderRadius: BorderRadius.circular(borderRadius)),
      ),
    );
  }
}
