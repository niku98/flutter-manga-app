import 'package:flutter/material.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/common/extensions/size_extension.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        Container(
          height: 2,
          width: Sizes.dimen_48.w,
          margin: EdgeInsets.only(left: Sizes.dimen_2.w),
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(Sizes.dimen_2.w)),
        )
      ],
    );
  }
}
