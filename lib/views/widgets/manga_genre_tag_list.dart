import 'package:flutter/material.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/common/extensions/size_extension.dart';
import 'package:manga_app/views/themes/app_color.dart';
import 'package:manga_app/views/widgets/skeleton_box.dart';

class MangaGenreTagList extends StatelessWidget {
  final List<String> tags;

  MangaGenreTagList(this.tags);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Sizes.dimen_8.w,
      runSpacing: Sizes.dimen_8.w,
      children: [for (var tag in tags) GenreTag(tag)],
    );
  }
}

class GenreTag extends StatelessWidget {
  final String title;

  GenreTag(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Sizes.dimen_8.w,
        horizontal: Sizes.dimen_14.w,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.dimen_20.w),
          color: AppColors.secondary),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

class MangaGenreTagListLoader extends StatelessWidget {
  MangaGenreTagListLoader();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (var i = 0; i < 4; i++)
          Padding(
              padding: EdgeInsets.symmetric(
                vertical: Sizes.dimen_8.w,
                horizontal: Sizes.dimen_4.w,
              ),
              child: SkeletonBox(
                width: Sizes.dimen_70.w,
                height: Sizes.dimen_12.h,
                borderRadius: Sizes.dimen_20.w,
              ))
      ],
    );
  }
}
