import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marsvpn/components/appbar_button.dart';
import 'package:marsvpn/components/custom_app_bar.dart';
import 'package:marsvpn/components/drawer.dart';
import 'package:marsvpn/controllers/home_controller.dart';
import 'package:marsvpn/themes/colors.dart';
import '../components/connecting_time.dart';
import '../components/home_server_card.dart';
import '../components/status.dart';
import '../components/vip_button.dart';
// import '../components/monitor.dart';
import '../components/power_button.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: Text(
          'MARS VPN',
        ),
        titleTextStyle: Theme.of(context).textTheme.headlineLarge,
        actions: [
          VipButton(),
        ],
        leading: Builder(builder: (context) {
          return AppBarButton(
            semanticLabel: 'Humberger Button',
            svgSrc: 'assets/icons/humberger.svg',
            onTap: () => Scaffold.of(context).openDrawer(),
            isLeftIcon: true,
            svgWidth: 17.63,
            svgHeight: 15.13,
          );
        }),
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
        ),
        shadowColor: Color(0x7F000000),
        elevation: 0,
        backgroundColor: CustomColors.background.withOpacity(0.8),
        child: DrawerListView(),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/map.png'),
            colorFilter: ColorFilter.mode(Color(0xFF3A3A4D), BlendMode.srcIn),
            fit: BoxFit.cover, // Adjust this according to your needs
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          // top: false,
          // minimum: EdgeInsets.only(top: 40),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ConnectingTime(
                  timer: homeController.vpnTimer,
                ),
                Obx(() => HomeServerCard(
                      server: homeController.selectedServer.value,
                    )),
                // Monitor(),
  
                Obx(() => PowerButton(
                    size: 200,
                    status: homeController.vpnStatus.value,
                    onPressed: homeController.toggleVpnStatus)),
                Obx(() =>
                    Status(status: homeController.vpnStatus.value.toString())),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
