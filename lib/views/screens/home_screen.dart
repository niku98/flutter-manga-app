import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/blocs/manhua_manga/manhua_manga_bloc.dart';
import 'package:manga_app/blocs/manhwa_manga/manhwa_manga_bloc.dart';
import 'package:manga_app/blocs/recommended_manga/recommended_manga_bloc.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/common/extensions/size_extension.dart';
import 'package:manga_app/views/widgets/bottom_tab_bar.dart';
import 'package:manga_app/views/widgets/manga_section_list.dart';
import 'package:manga_app/views/screens/filter_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RecommendedMangaBloc _recommendedMangaBloc;
  ManhuaMangaBloc _manhuaMangaBloc;
  ManhwaMangaBloc _manhwaMangaBloc;
  Completer<void> _refreshCompleter;

  bool recommendRefreshing = false;
  bool manhuaRefreshing = false;
  bool manhwaRefreshing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recommendedMangaBloc = new RecommendedMangaBloc();
    _manhuaMangaBloc = new ManhuaMangaBloc();
    _manhwaMangaBloc = new ManhwaMangaBloc();
    _refreshCompleter = new Completer();

    _recommendedMangaBloc.listen((state) {
      if (state is GotRecommendedManga) {
        setState(() {
          recommendRefreshing = false;
          if (!manhuaRefreshing && !manhwaRefreshing) {
            print('Refresh done');
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }
        });
      }
    });
    _manhuaMangaBloc.listen((state) {
      if (state is GotManhuaManga) {
        setState(() {
          manhuaRefreshing = false;
          if (!recommendRefreshing && !manhwaRefreshing) {
            print('Refresh done');
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }
        });
      }
    });

    _manhwaMangaBloc.listen((state) {
      if (state is GotManhwaManga) {
        setState(() {
          manhwaRefreshing = false;
          if (!manhuaRefreshing && !recommendRefreshing) {
            print('Refresh done');
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }
        });
      }
    });

    loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _recommendedMangaBloc.close();
    _manhuaMangaBloc.close();
    _manhwaMangaBloc.close();
    super.dispose();
  }

  loadData() {
    recommendRefreshing = true;
    manhuaRefreshing = true;
    manhwaRefreshing = true;

    _recommendedMangaBloc.add(new GetRecommendedManga());
    _manhuaMangaBloc.add(new GetManhuaManga());
    _manhwaMangaBloc.add(new GetManhwaManga());
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     statusBarIconBrightness: Brightness.dark));

    return Scaffold(
      body: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: _recommendedMangaBloc),
            BlocProvider.value(value: _manhuaMangaBloc),
            BlocProvider.value(value: _manhwaMangaBloc),
          ],
          child: RefreshIndicator(
              child: ListView(children: [
                HomeHeader(),
                RecommendedMangaSection(),
                ManhuaSection(),
                ManhwaSection()
              ]),
              onRefresh: () {
                loadData();
                return _refreshCompleter.future;
              })),
      bottomNavigationBar: BottomTabBar(),
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
        Padding(
          padding: EdgeInsets.symmetric(vertical: Sizes.dimen_14.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Wellcome back",
                style: Theme.of(context).textTheme.headline5,
              ),
              // IconButton(
              //     icon: Icon(
              //       Icons.filter_alt,
              //       color: Colors.black,
              //     ),
              //     onPressed: null)
            ],
          ),
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

class RecommendedMangaSection extends StatefulWidget {
  @override
  _RecommendedMangaSectionState createState() =>
      _RecommendedMangaSectionState();
}

class _RecommendedMangaSectionState extends State<RecommendedMangaSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendedMangaBloc, RecommendedMangaState>(
        builder: (context, state) {
      if (state is GotRecommendedManga) {
        return Container(
          child: MangaSectionList(title: "Recommended", mangas: state.mangas),
        );
      }

      return MangaSectionListLoader();
    });
  }
}

class ManhuaSection extends StatefulWidget {
  @override
  _ManhuaSectionState createState() => _ManhuaSectionState();
}

class _ManhuaSectionState extends State<ManhuaSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManhuaMangaBloc, ManhuaMangaState>(
        builder: (context, state) {
      if (state is GotManhuaManga) {
        return Container(
          child: MangaSectionList(title: "Manhua", mangas: state.mangas),
        );
      }

      return MangaSectionListLoader();
    });
  }
}

class ManhwaSection extends StatefulWidget {
  @override
  _ManhwaSectionState createState() => _ManhwaSectionState();
}

class _ManhwaSectionState extends State<ManhwaSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManhwaMangaBloc, ManhwaMangaState>(
        builder: (context, state) {
      if (state is GotManhwaManga) {
        return Container(
          child: MangaSectionList(title: "Manhwa", mangas: state.mangas),
        );
      }

      return MangaSectionListLoader();
    });
  }
}
