import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marsvpn/components/appbar_button.dart';
import 'package:marsvpn/components/custom_app_bar.dart';
import 'package:marsvpn/components/public_icon.dart';
import 'package:marsvpn/components/custom_timer.dart';
import 'package:marsvpn/controllers/home_controller.dart';
import '../components/main_view.dart';
import '../components/otp_input.dart';

Color accentPurpleColor = Color(0xFF6A53A1);
Color primaryColor = Color(0xFF121212);
Color accentPinkColor = Color(0xFFF99BBD);
Color accentDarkGreenColor = Color(0xFF115C49);
Color accentYellowColor = Color(0xFFFFB612);
Color accentOrangeColor = Color(0xFFEA7A3B);

class Redeem extends StatelessWidget {
  Redeem({super.key});
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    homeController.pingPong();
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Redeem'),
        leading: AppBarButton(
          semanticLabel: 'Back Button',
          svgSrc: 'assets/icons/arrow-back.svg',
          onTap: () {
            Get.back();
            // homeController.setSelectedPricingPlan(null);
          },
          isLeftIcon: true,
          svgWidth: 10,
          svgHeight: 16,
        ),
      ),
      body: Obx(() => MainView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(),
                SizedBox(
                  height: 32,
                ),
                Center(
                  child: OTPInput(
                    enabled: homeController.loginTimer.value == null,
                    authenticate: homeController.login,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                (homeController.loginTimer.value is int)
                    ? Center(
                        child: CustomTimer(
                          seconds: homeController.loginTimer.value!,
                          onEnd: () {
                            homeController.loginTimer.value = null;
                          },
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  height: 2,
                )
              ],
            ),
          )),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          PublicIcon(
            svgSrc: 'assets/icons/gift-box.svg',
            svgWidth: 36,
            svgHeight: 36,
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 216,
            child: Text(
              'Redeem your Purchase by now',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}
