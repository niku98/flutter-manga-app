import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/blocs/search_manga/search_manga_bloc.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/common/extensions/size_extension.dart';
import 'package:manga_app/views/screens/advanced_filter_screen.dart';
import 'package:manga_app/views/widgets/manga_horizontal_card.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  SearchMangaBloc searchMangaBloc;
  Completer refreshCompleter;
  final TextEditingController searchFieldController = TextEditingController();
  String searchText;
  Timer debounce;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchMangaBloc = SearchMangaBloc();
    refreshCompleter = Completer();
    searchFieldController.addListener(onSearch);
    searchMangaBloc.listen((state) {
      if (state is SearchMangaLoaded) {
        refreshCompleter.complete();
        refreshCompleter = Completer();
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchFieldController.dispose();
    searchMangaBloc.close();
    super.dispose();
  }

  onSearch() {
    if (debounce?.isActive ?? false) {
      debounce.cancel();
    }

    debounce = Timer(const Duration(milliseconds: 500), () {
      searchManga();
    });
  }

  searchManga({bool isRefresh = false}) {
    if ((searchFieldController.text != "" &&
            searchFieldController.text != searchText) ||
        isRefresh == true) {
      setState(() {
        searchText = searchFieldController.text;
      });

      searchMangaBloc.add(SearchManga(searchFieldController.text));
    } else {
      Timer(Duration(milliseconds: 100), () {
        refreshCompleter.complete();
        refreshCompleter = Completer();
      });
    }

    return refreshCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: searchMangaBloc,
        child: RefreshIndicator(
          onRefresh: () {
            return searchManga(isRefresh: true);
          },
          child: Scaffold(
              appBar: AppBar(
                leading: BackButton(
                  color: Colors.black,
                ),
                leadingWidth: Sizes.dimen_24.w,
                backgroundColor: Colors.white,
                elevation: 3,
                shadowColor: Colors.black12,
                title: Hero(
                    tag: "search_bar",
                    child: Container(
                      child: Row(children: [
                        Icon(
                          Icons.search,
                          size: Sizes.dimen_24.w,
                          color: Colors.grey,
                        ),
                        Expanded(
                            child: TextField(
                                controller: searchFieldController,
                                autofocus: true,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    hintText: 'Search',
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: Sizes.dimen_4.w,
                                    ))))
                      ]),
                    )),
              ),
              body: BlocBuilder<SearchMangaBloc, SearchMangaState>(
                builder: (context, state) {
                  if (state is SearchMangaLoaded) {
                    return ListView.separated(
                        padding: EdgeInsets.all(Sizes.dimen_14.w),
                        itemBuilder: (context, index) {
                          return MangaHorizontalCard(state.mangas[index]);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: Sizes.dimen_4.h,
                          );
                        },
                        itemCount: state.mangas.length);
                  } else if (state is SearchingManga) {
                    return ListView.separated(
                        padding: EdgeInsets.all(Sizes.dimen_14.w),
                        itemBuilder: (context, index) {
                          return MangaHorizontalCardLoader();
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: Sizes.dimen_4.h,
                          );
                        },
                        itemCount: 6);
                  }
                  return SizedBox.shrink();
                },
              )),
        ),
      ),
    );
  }
}
