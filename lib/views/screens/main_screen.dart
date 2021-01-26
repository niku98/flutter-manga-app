import 'package:flutter/material.dart';
import 'package:manga_app/views/screens/explorer_screen.dart';
import 'package:manga_app/views/screens/home_screen.dart';
import 'package:manga_app/views/widgets/bottom_tab_bar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  final List<Tab> tabs = [
    Tab(
        icon: Icon(
      Icons.home_outlined,
      // color: AppColors.dark,
    )),
    Tab(
        icon: Icon(
      Icons.layers_outlined,
      // color: AppColors.dark,
    )),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: TabBarView(
            controller: tabController,
            children: [HomeScreen(), ExplorerScreen()]),
        bottomNavigationBar: BottomTabBar(
          controller: tabController,
          tabs: tabs,
        ),
      ),
    );
  }
}
