import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/blocs/genre_list/genre_list_bloc.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/domain/enums/checkbox_group_orientation.dart';
import 'package:manga_app/domain/models/option.dart';
import 'package:manga_app/views/widgets/checkbox_group.dart';
import 'package:manga_app/common/extensions/size_extension.dart';
import 'package:manga_app/views/themes/app_color.dart';

class AdvancedFilterScreen extends StatefulWidget {
  @override
  _AdvancedFilterScreenState createState() => _AdvancedFilterScreenState();
}

class _AdvancedFilterScreenState extends State<AdvancedFilterScreen> {
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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: Sizes.dimen_40.w,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: Sizes.dimen_6.w,
        title: Text(
          "Lọc theo thể loại",
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
              child: BlocProvider<GenreListBloc>.value(
            value: _genreListBloc,
            child: BlocBuilder<GenreListBloc, GenreListState>(
              builder: (context, state) {
                if (state is GotGenreList) {
                  final options = state.genres
                      .map((e) => Option(label: e.genreName, value: e.endpoint))
                      .toList();
                  return CheckboxGroup(
                    options: options,
                    orientation: CheckboxGroupOrientation.VERTICAL,
                    childAspectRatio: 4,
                    onChange: (selected) {
                      print(selected);
                    },
                  );
                }

                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )),
        ],
      ),
    ));
  }
}
