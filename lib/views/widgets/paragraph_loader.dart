import 'package:flutter/material.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/common/extensions/size_extension.dart';
import 'package:manga_app/views/widgets/skeleton_box.dart';

class ParagraphLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SkeletonBox(width: Sizes.dimen_140.w, height: Sizes.dimen_6.h),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SkeletonBox(width: Sizes.dimen_300.w, height: Sizes.dimen_6.h),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SkeletonBox(width: Sizes.dimen_80.w, height: Sizes.dimen_6.h),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SkeletonBox(width: Sizes.dimen_230.w, height: Sizes.dimen_6.h),
        ),
      ],
    );
  }
}
