import 'package:flutter/material.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/common/extensions/size_extension.dart';
import 'package:manga_app/views/widgets/section_title.dart';

class Section extends StatelessWidget {
  final String title;
  final Widget child;
  final double contentHeight;
  final double contentWidth;
  final EdgeInsets contentPadding;
  final EdgeInsets margin;

  Section(
      {this.title,
      this.child,
      this.contentHeight,
      this.contentWidth,
      this.contentPadding,
      this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin ?? EdgeInsets.only(top: Sizes.dimen_4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.dimen_6.w),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title != null
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Sizes.dimen_10.w,
                        horizontal: Sizes.dimen_14.w),
                    child: SectionTitle(title),
                  )
                : SizedBox.shrink(),
            Container(
              child: child,
              width: contentWidth,
              height: contentHeight,
              padding: contentPadding ??
                  EdgeInsets.only(
                      left: Sizes.dimen_14.w,
                      right: Sizes.dimen_14.w,
                      bottom: Sizes.dimen_14.w),
            ),
          ],
        ));
  }
}
