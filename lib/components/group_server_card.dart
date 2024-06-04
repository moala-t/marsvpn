import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marsvpn/components/arrow_down.dart';
import 'package:marsvpn/components/server_detail.dart';
import 'package:marsvpn/controllers/home_controller.dart';
import 'package:marsvpn/themes/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'show_country.dart';

class GroupServerCardController extends GetxController {
  var isExpanded = false.obs;

  void toggleExpand() {
    isExpanded.value = !isExpanded.value;
  }
}

class GroupServerCard extends StatelessWidget {
  final String isoCode;
  final int locationNum;
  final List<dynamic> servers;

  GroupServerCard({
    Key? key,
    required this.isoCode,
    required this.locationNum,
    required this.servers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return ExpandedGroupCard(
      homeController: homeController,
      isoCode: isoCode,
      locationNum: locationNum,
      servers: servers,
    );
  }
}

class ExpandedGroupCard extends StatelessWidget {
  ExpandedGroupCard({
    Key? key,
    required this.isoCode,
    required this.locationNum,
    required this.servers,
    required this.homeController,
  }) : super(key: key);

  final HomeController homeController;
  final List servers;
  final String isoCode;
  final int locationNum;

  @override
  Widget build(BuildContext context) {
    // Create a unique controller for each instance
    final GroupServerCardController groupServerCardController =
        Get.put(GroupServerCardController(), permanent: true, tag: isoCode);
    return Obx(() {
      return AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: GestureDetector(
          onTap: groupServerCardController.toggleExpand,
          child: Container(
            decoration: ShapeDecoration(
              color: Theme.of(context).colorScheme.background,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Color(0xFF4A4A61)),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Column(
              children: [
                // ShowCountry and ArrowDown
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShowCountry(
                        isoCode: servers[0]?['next_server']?['country'] ?? isoCode,
                        locationNum: locationNum,
                      ),
                      AnimatedRotation(
                        turns: groupServerCardController.isExpanded.value
                            ? 0.5
                            : 0,
                        duration: Duration(milliseconds: 300),
                        child: ArrowDown(),
                      ),
                    ],
                  ),
                ),
                // Divider
                if (groupServerCardController.isExpanded.value)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 0),
                    color: CustomColors.typographyOverline,
                    width: double.infinity,
                    height: 0.1,
                  ),
                if (groupServerCardController.isExpanded.value)
                  for (var server in servers)
                    ServerItem(
                      isLast: server['id'] == servers.last['id'],
                      server: server,
                      homeController: homeController,
                    ),
                if (groupServerCardController.isExpanded.value)
                  Obx(() => Container(
                        height: 10,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: homeController.selectedServer.value?['id'] ==
                                    servers.last['id']
                                ? Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.09)
                                : Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12))),
                      )),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class ServerItem extends StatelessWidget {
  const ServerItem({
    Key? key,
    required this.server,
    required this.homeController,
    required this.isLast,
  }) : super(key: key);

  final bool isLast;
  final HomeController homeController;
  final Map server;

  @override
  Widget build(BuildContext context) {
    return Obx(() => TouchableOpacity(
          onTap: () => homeController.setSelectedServer(server),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            color: (homeController.selectedServer.value?['id'] == server['id'])
                ? Theme.of(context).colorScheme.secondary.withOpacity(0.09)
                : Theme.of(context).colorScheme.background,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ServerDetail(
                    pingSize: 8,
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: CustomColors.typographyOverline),
                    ping: server['ping']['number'].toInt(),
                    city: server['next_server']?['city'] ?? server['city'],
                    tunnelled: server['next_server'] != null,),
                    
                SizedBox(
                  width: 23,
                  height: 28,
                  child: Radio(
                    value: server['id'],
                    groupValue: homeController.selectedServer.value?['id'],
                    activeColor: Theme.of(context).colorScheme.secondary,
                    onChanged: (value) =>
                        homeController.setSelectedServer(server),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class GroupCard extends StatelessWidget {
  const GroupCard({
    Key? key,
    required this.isoCode,
    required this.locationNum,
  }) : super(key: key);

  final String isoCode;
  final int locationNum;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      activeOpacity: 0.8,
      onTap: () {
      },
      child: Container(
        height: 75,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.background,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFF4A4A61)),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShowCountry(
              isoCode: isoCode,
              locationNum: locationNum,
            ),
            ArrowDown(),
          ],
        ),
      ),
    );
  }
}
