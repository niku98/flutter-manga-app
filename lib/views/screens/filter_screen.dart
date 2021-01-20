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
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        leadingWidth: Sizes.dimen_24.w,
        backgroundColor: Colors.white,
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
      body: SafeArea(
        child: ListView(children: []),
      ),
    );
  }
}
