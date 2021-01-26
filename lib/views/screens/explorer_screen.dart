import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/blocs/genre_list/genre_list_bloc.dart';
import 'package:manga_app/blocs/genre_mangas/genre_mangas_bloc.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/common/extensions/size_extension.dart';
import 'package:manga_app/domain/models/genre.dart';
import 'package:manga_app/domain/models/manga.dart';
import 'package:manga_app/views/themes/app_color.dart';
import 'package:manga_app/views/widgets/manga_card.dart';

class ExplorerScreen extends StatefulWidget {
  @override
  _ExplorerScreenState createState() => _ExplorerScreenState();
}

class _ExplorerScreenState extends State<ExplorerScreen>
    with TickerProviderStateMixin {
  GenreListBloc _genreListBloc;
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _genreListBloc = GenreListBloc();
    _genreListBloc.add(GetGenreList());
    tabController = TabController(length: 0, vsync: this);
    _genreListBloc.listen((state) {
      if (state is GotGenreList) {
        setState(() {
          tabController =
              TabController(length: state.genres.length, vsync: this);
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _genreListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: _genreListBloc,
        child: BlocBuilder<GenreListBloc, GenreListState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Explore Manga",
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.white,
                bottom: TabBar(
                    controller: tabController,
                    isScrollable: true,
                    labelColor: Colors.black,
                    indicatorColor: AppColors.primary,
                    tabs: state is GotGenreList
                        ? state.genres
                            .map((e) => Tab(
                                  text: e.genreName,
                                ))
                            .toList()
                        : []),
              ),
              body: TabBarView(
                  controller: tabController,
                  children: state is GotGenreList
                      ? state.genres.map((e) => GenreMangas(e)).toList()
                      : []),
            );
          },
        ),
      ),
    );
  }
}

class GenreMangas extends StatefulWidget {
  final Genre genre;
  GenreMangas(this.genre);

  @override
  _GenreMangasState createState() => _GenreMangasState();
}

class _GenreMangasState extends State<GenreMangas> {
  GenreMangasBloc genreMangasBloc;
  List<Manga> mangas = [];
  bool loading = false;
  bool canLoadMore = true;

  ScrollController _scrollController;
  int pageNumber = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genreMangasBloc = GenreMangasBloc();
    genreMangasBloc.listen(blocListener);
    loadGenreMangas();
    _scrollController = ScrollController();
    _scrollController.addListener(onEndReach);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    genreMangasBloc.close();
    super.dispose();
  }

  blocListener(GenreMangasState state) {
    if (state is GotGenreMangas) {
      setState(() {
        if (state.mangas.length != 0) {
          mangas.addAll(state.mangas);
          pageNumber++;
        } else {
          canLoadMore = false;
        }
        loading = false;
      });
    } else if (state is LoadingGenreMangas) {
      setState(() {
        loading = true;
      });
    }
  }

  loadGenreMangas() {
    genreMangasBloc
        .add(GetGenreMangas(widget.genre.endpoint, pageNumber: pageNumber));
  }

  onEndReach() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        if (canLoadMore && !loading) {
          loadGenreMangas();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemWidth =
        MediaQuery.of(context).size.width / 2 - Sizes.dimen_14.w * 2;
    return BlocProvider.value(
      value: genreMangasBloc,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(Sizes.dimen_14.w),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return MangaCard(
                  mangas[index],
                  width: itemWidth,
                );
              }, childCount: mangas.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: Sizes.dimen_14.w,
                  mainAxisSpacing: Sizes.dimen_14.w,
                  childAspectRatio:
                      itemWidth / (itemWidth * 3 / 2 + Sizes.dimen_14.w * 2),
                  crossAxisCount: 2),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_14.w),
            sliver: loading == true
                ? SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: Sizes.dimen_14.w,
                        mainAxisSpacing: Sizes.dimen_14.w,
                        childAspectRatio: itemWidth /
                            (itemWidth * 3 / 2 + Sizes.dimen_14.w * 2),
                        crossAxisCount: 2),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return MangaCardLoader(width: itemWidth);
                    }, childCount: 2),
                  )
                : SliverToBoxAdapter(
                    child: SizedBox.shrink(),
                  ),
          ),
        ],
      ),
    );
  }
}
