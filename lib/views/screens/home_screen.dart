import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/common/extensions/size_extension.dart';
import 'package:manga_app/domain/models/manga.dart';
import 'package:manga_app/views/components/manga_section_list.dart';
import 'package:manga_app/views/screens/filter_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        HomeHeader(),
        Container(
          child: MangaSectionList(title: "Recommended", mangas: [
            Manga(
                title: "Jimina Ken Sei Wa Sore Demo Saikyoudesu",
                thumb:
                    "https://i0.wp.com/komiku.co.id/wp-content/uploads/Manga-Jimina-Ken-Sei-Wa-Sore-Demo-Saikyoudesu.jpg?resize=450,235&quality=60"),
            Manga(
                title: "Jimina Ken Sei Wa Sore Demo Saikyoudesu",
                thumb:
                    "https://i0.wp.com/komiku.co.id/wp-content/uploads/Manga-Jimina-Ken-Sei-Wa-Sore-Demo-Saikyoudesu.jpg?resize=450,235&quality=60"),
            Manga(
                title: "Jimina Ken Sei Wa Sore Demo Saikyoudesu",
                thumb:
                    "https://i0.wp.com/komiku.co.id/wp-content/uploads/Manga-Jimina-Ken-Sei-Wa-Sore-Demo-Saikyoudesu.jpg?resize=450,235&quality=60"),
            Manga(
                title: "Jimina Ken Sei Wa Sore Demo Saikyoudesu",
                thumb:
                    "https://i0.wp.com/komiku.co.id/wp-content/uploads/Manga-Jimina-Ken-Sei-Wa-Sore-Demo-Saikyoudesu.jpg?resize=450,235&quality=60"),
            Manga(
                title: "Jimina Ken Sei Wa Sore Demo Saikyoudesu",
                thumb:
                    "https://i0.wp.com/komiku.co.id/wp-content/uploads/Manga-Jimina-Ken-Sei-Wa-Sore-Demo-Saikyoudesu.jpg?resize=450,235&quality=60"),
            Manga(
                title: "Jimina Ken Sei Wa Sore Demo Saikyoudesu",
                thumb:
                    "https://i0.wp.com/komiku.co.id/wp-content/uploads/Manga-Jimina-Ken-Sei-Wa-Sore-Demo-Saikyoudesu.jpg?resize=450,235&quality=60"),
            Manga(
                title: "Jimina Ken Sei Wa Sore Demo Saikyoudesu",
                thumb:
                    "https://i0.wp.com/komiku.co.id/wp-content/uploads/Manga-Jimina-Ken-Sei-Wa-Sore-Demo-Saikyoudesu.jpg?resize=450,235&quality=60"),
            Manga(
                title: "Jimina Ken Sei Wa Sore Demo Saikyoudesu",
                thumb:
                    "https://i0.wp.com/komiku.co.id/wp-content/uploads/Manga-Jimina-Ken-Sei-Wa-Sore-Demo-Saikyoudesu.jpg?resize=450,235&quality=60"),
            Manga(
                title: "Jimina Ken Sei Wa Sore Demo Saikyoudesu",
                thumb:
                    "https://i0.wp.com/komiku.co.id/wp-content/uploads/Manga-Jimina-Ken-Sei-Wa-Sore-Demo-Saikyoudesu.jpg?resize=450,235&quality=60"),
          ]),
        )
      ]),
    );
  }
}

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.only(
          top: Sizes.dimen_4.h,
          bottom: Sizes.dimen_8.h,
          left: Sizes.dimen_14.w,
          right: Sizes.dimen_14.w),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Wellcome back",
              style: Theme.of(context).textTheme.headline5,
            ),
            IconButton(
                icon: Icon(
                  Icons.filter_alt,
                  color: Colors.black,
                ),
                onPressed: null)
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FilterScreen()));
          },
          child: Hero(
              tag: "search_bar",
              flightShuttleBuilder: (BuildContext flightContext,
                      Animation<double> animation,
                      HeroFlightDirection flightDirection,
                      BuildContext fromHeroContext,
                      BuildContext toHeroContext) =>
                  Material(child: toHeroContext.widget),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Sizes.dimen_32.w),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5)
                    ],
                    color: Colors.white),
                padding: EdgeInsets.symmetric(
                    vertical: Sizes.dimen_10.w, horizontal: Sizes.dimen_10.w),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: Sizes.dimen_20.w,
                      color: Colors.grey,
                    ),
                    Text(
                      "Search",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: Colors.grey),
                    )
                  ],
                ),
              )),
        )
      ]),
    ));
  }
}
