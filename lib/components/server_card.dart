import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'show_country.dart';
import '../controllers/home_controller.dart';
import 'package:get/get.dart';

class ServerCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  ServerCard({
    super.key,
    required this.server,
  });
  // final double width;
  final Map server;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TouchableOpacity(
        activeOpacity: 0.8,
        onTap: () {
          homeController.setSelectedServer(server);
        },
        child: Container(

          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          decoration: ShapeDecoration(
            color: (homeController.selectedServer.value?['id'] == server['id'])
                ? Theme.of(context).colorScheme.secondary.withOpacity(0.09)
                : Theme.of(context).colorScheme.background,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 1,
                  color: (homeController.selectedServer.value?['id'] ==
                          server['id'])
                      ? Theme.of(context).colorScheme.secondary
                      : Color(0xFF4A4A61)),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShowCountry(
                isoCode: server['next_server']?['country'] ?? server['country'],
                ping: server['ping']['number'].toInt(),
                city: server['next_server']?['city'] ?? server['city'],
                tunnelled: server['next_server'] != null,
              ),
              SizedBox(
                width: 28,
                height: 28,
                child: Radio(
                  value: server['id'],
                  groupValue: homeController.selectedServer.value?['id'],
                  activeColor: Theme.of(context).colorScheme.secondary,
                  onChanged: (value) => homeController.setSelectedServer(server),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
