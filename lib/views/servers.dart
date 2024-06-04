import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marsvpn/components/custom_app_bar.dart';
import 'package:marsvpn/components/top_tab_bar.dart';
import 'package:marsvpn/controllers/home_controller.dart';
import 'package:marsvpn/views/servers_tab_bar.dart';
import '../components/appbar_button.dart';

class Servers extends StatefulWidget {
  const Servers({super.key});

  // final homeController = Get.find<HomeController>();

  @override
  ServersState createState() => ServersState();
}

class ServersState extends State<Servers> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final homeController = Get.find<HomeController>();
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Location'),
        actions: [
          AppBarButton(
            semanticLabel: 'Refresh Button',
            svgSrc: 'assets/icons/refresh.svg',
            onTap: () {
              homeController.fetchFreeServers();
              homeController.fetchPremiumServers();
            },
            isLeftIcon: false,
            svgWidth: 19.16,
            svgHeight: 17.62,
          )
        ],
        leading: AppBarButton(
          semanticLabel: 'Back Button',
          svgSrc: 'assets/icons/arrow-back.svg',
          onTap: Get.back,
          isLeftIcon: true,
          svgWidth: 10,
          svgHeight: 16,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TopTabBar(
              tabController: _tabController,
            ),
          ),
          // tab bar view here
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // First Screen
                ServersTabBar(
                    servers: homeController.freeServers,
                    heading1: 'Smart Location',
                    heading2: 'All Servers'),

                ServersTabBar(
                    servers: homeController.premiumServers,
                    heading1: 'Smart Location',
                    heading2: 'All Servers'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
