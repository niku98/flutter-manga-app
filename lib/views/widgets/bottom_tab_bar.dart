import 'package:flutter/material.dart';
import 'package:manga_app/views/themes/app_color.dart';

class BottomTabBar extends StatefulWidget {
  final TabController controller;
  final int initialIndex;
  final List<Tab> tabs;
  final Function(int) onTap;

  const BottomTabBar(
      {this.controller,
      this.initialIndex = 0,
      @required this.tabs,
      this.onTap});

  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = widget.controller != null
        ? widget.controller
        : TabController(
            length: widget.tabs.length,
            vsync: this,
            initialIndex: widget.initialIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: AppColors.dark.withOpacity(0.05),
            offset: Offset(0, 0),
            blurRadius: 10),
      ], color: Colors.white),
      child: TabBar(
        controller: _tabController,
        tabs: widget.tabs,
        onTap: widget.onTap,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.dark,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: AppColors.primary,
        indicator: CircleTabIndicator(color: AppColors.primary, radius: 3),
        labelPadding: EdgeInsets.symmetric(vertical: 5),
      ),
    ));
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({@required Color color, @required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size.width / 2, cfg.size.height - radius - 5);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
