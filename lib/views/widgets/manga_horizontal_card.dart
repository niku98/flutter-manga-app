import 'package:flutter/material.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/common/extensions/size_extension.dart';
import 'package:manga_app/views/widgets/cache_image_with_skeleton.dart';

class MangaHorizontalCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.clip,
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Sizes.dimen_10.w),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 3),
              ]),
          padding: EdgeInsets.only(
            left: Sizes.dimen_24.w,
            top: Sizes.dimen_14.w,
            bottom: Sizes.dimen_14.w,
            right: Sizes.dimen_14.w,
          ),
          alignment: Alignment.topLeft,
          width: double.infinity,
          height: MediaQuery.of(context).size.width / 3 - Sizes.dimen_10.w * 2,
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 3 - Sizes.dimen_14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Testf asf asdf asdf asdf asdf asdf asdf asdf asdf asdf",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                "Manga",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.grey),
              ),
              Text(
                "Update at",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.dimen_10.w),
              boxShadow: [
                BoxShadow(color: Colors.black38, blurRadius: 3),
              ]),
          child: CacheImageWithSkeleton(
            "https://i0.wp.com/komiku.co.id/wp-content/uploads/Manga-Komi-san-wa-Komyushou-Desu.png?resize=450,235&quality=60",
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.width / 3,
          ),
        )
      ],
    );
  }
}
