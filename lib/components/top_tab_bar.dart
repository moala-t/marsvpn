import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marsvpn/controllers/home_controller.dart';

class TopTabBar extends StatelessWidget {
  TopTabBar({super.key, required this.tabController});
  final TabController tabController;
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFF4A4A61),
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      child: TabBar(
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,

        // padding: EdgeInsets.all(5),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(
            12,
          ),
          color: Color(0xFF5C5C7E),
        ),

        labelColor: Colors.white,
        labelStyle: Theme.of(context).textTheme.titleMedium,
        unselectedLabelColor: Colors.white,
        tabs: [
          Tab(
            text: 'Country',
          ),
          
          Tab(
            text: 'Premium',
          ),
        ],
      ),
    );
  }
}
