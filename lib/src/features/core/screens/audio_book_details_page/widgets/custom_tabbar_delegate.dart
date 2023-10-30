import 'package:flutter/material.dart';

import '../imports.dart';

class CustomTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;

  CustomTabBarDelegate(this.tabController);

  @override
  double get minExtent => kToolbarHeight;

  @override
  double get maxExtent => kToolbarHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return TabBarWidget(tabController: tabController);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}