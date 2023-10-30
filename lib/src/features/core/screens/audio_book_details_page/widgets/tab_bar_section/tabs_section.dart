import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0).h,
      child: Container(
        height: 50.h,
        color: const Color(0x221622FF),
        child: TabBar(
          controller: _tabController,
          unselectedLabelColor: Colors.white,
          labelColor: Colors.green,
          indicatorColor: Colors.white,
          indicatorPadding: const EdgeInsets.only(
            bottom: 8.0,
          ).h,
          dividerColor: const Color(0x2201053C),
          tabs: const [
            Tab(text: 'EPISODES'),
            Tab(text: 'CAST & CREW'),
            Tab(text: 'REVIEWS'),
          ],
        ),
      ),
    );
  }
}