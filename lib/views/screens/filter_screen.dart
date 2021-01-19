import 'package:flutter/material.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/common/extensions/size_extension.dart';
import 'package:manga_app/views/screens/advanced_filter_screen.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  getGenresFiltered() async {
    final genresFiltered = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => AdvancedFilterScreen()));
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
                    BackButton(
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
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
                        onPressed: getGenresFiltered)
                  ],
                ),
              )),
        ]),
      ),
    );
  }
}
