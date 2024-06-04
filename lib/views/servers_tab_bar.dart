import 'package:flutter/material.dart';
import 'package:marsvpn/components/group_server_card.dart';
import 'package:marsvpn/components/server_card.dart';
import 'package:marsvpn/themes/colors.dart';
import '../controllers/home_controller.dart';
import 'package:get/get.dart';

class ServersTabBar extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();

  final List servers;
  final String heading1;
  final String heading2;

  ServersTabBar({
    super.key,
    required this.servers,
    required this.heading1,
    required this.heading2,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => servers.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 36),
                child: Text(
                  heading1,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              // SMART SERVER CARDS
              for (var server in homeController.chooseSmartLocations(servers))
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, left: 24, right: 24),
                  child: ServerCard(
                    server: server,
                  ),
                ),
              SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 36),
                child: Text(
                  heading2,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              // GROUPED CARDS
              for (var entry
                  in homeController.getGroupedServers(servers).entries)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, left: 24, right: 24),
                  child: GroupServerCard(
                    isoCode: entry.key,
                    locationNum: entry.value.length,
                    servers: entry.value,
                  ),
                )
            ],
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                  style: TextStyle(
                      color: CustomColors.typographyOverline, fontSize: 14),
                  textAlign: TextAlign.center,
                  'Unable to load servers. Please check your internet connection and try again.'),
            ),
          ));
  }
}
