import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/blocs/genre_list/genre_list_bloc.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/common/extensions/size_extension.dart';
import 'package:manga_app/domain/enums/checkbox_group_orientation.dart';
import 'package:manga_app/domain/models/option.dart';
import 'package:manga_app/views/components/checkbox_group.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  GenreListBloc _genreListBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _genreListBloc = new GenreListBloc();
    _genreListBloc.add(GetGenreList());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _genreListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Hero(
              tag: "search_bar",
              child: Container(
                decoration: BoxDecoration(boxShadow: [], color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_10.w),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Sizes.dimen_4.w),
                          child: Icon(
                            Icons.arrow_back,
                            size: Sizes.dimen_24.w,
                            color: Colors.black,
                          ),
                        )),
                    Icon(
                      Icons.search,
                      size: Sizes.dimen_24.w,
                      color: Colors.grey,
                    ),
                    Expanded(
                        child: TextField(
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
                                )))),
                    IconButton(
                        icon: Icon(
                          Icons.filter_alt,
                          color: Colors.black,
                        ),
                        onPressed: null)
                  ],
                ),
              )),
          Container(
              color: Colors.white,
              height: 50,
              width: double.infinity,
              child: BlocProvider<GenreListBloc>.value(
                value: _genreListBloc,
                child: BlocBuilder<GenreListBloc, GenreListState>(
                  builder: (context, state) {
                    if (state is GotGenreList) {
                      final options = state.genres
                          .map((e) =>
                              Option(label: e.genreName, value: e.endpoint))
                          .toList();
                      return CheckboxGroup(
                        options: options,
                        orientation: CheckboxGroupOrientation.HORIZONTAL,
                        onChange: (selected) {
                          print(selected);
                        },
                      );
                    }

                    return SizedBox.shrink();
                  },
                ),
              ))
        ]),
      ),
    );
  }
}
