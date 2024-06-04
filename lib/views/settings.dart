import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:marsvpn/components/appbar_button.dart';
import 'package:marsvpn/components/custom_app_bar.dart';
import 'package:marsvpn/components/horizontal_divider.dart';
import 'package:marsvpn/controllers/home_controller.dart';
import 'package:marsvpn/themes/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import '../components/main_view.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Setting'),
        leading: AppBarButton(
          semanticLabel: 'Back Button',
          svgSrc: 'assets/icons/arrow-back.svg',
          onTap: () {
            Get.back();
          },
          isLeftIcon: true,
          svgWidth: 10,
          svgHeight: 16,
        ),
      ),
      body: MainView(
        child: Obx(() => ListView(
              children: [
                SizedBox(height: 10),
                DropDownListTile(
                  title: 'Connection mode',
                ),
                CustomHorizontalDivider(
                  thickness: 1,
                  color: CustomColors.background80,
                ),
                SwitchListTile(
                  title: 'Anonymous statistics',
                  value: homeController.isAnonymouStatistics.value,
                  onChange: () {
                    homeController.isAnonymouStatistics.value =
                        !homeController.isAnonymouStatistics.value;
                  },
                ),
                CustomHorizontalDivider(
                  thickness: 1,
                  color: CustomColors.background80,
                ),
                SwitchListTile(
                  title: 'Show notification',
                  value: homeController.showNotification.value,
                  onChange: () {
                    homeController.showNotification.value =
                        !homeController.showNotification.value;
                  },
                ),
                CustomHorizontalDivider(
                  thickness: 1,
                  color: CustomColors.background80,
                ),
                SwitchListTile(
                  title: 'Connect when app starts',
                  value: homeController.connectWhenAppStarts.value,
                  onChange: () {
                    homeController.connectWhenAppStarts.value =
                        !homeController.connectWhenAppStarts.value;
                  },
                ),
                CustomHorizontalDivider(
                  thickness: 1,
                  color: CustomColors.background80,
                ),
                SwitchListTile(
                  title: 'Improve connection stability',
                  value: homeController.improveConncetionStability.value,
                  onChange: () {
                    homeController.improveConncetionStability.value =
                        !homeController.improveConncetionStability.value;
                  },
                ),
                CustomHorizontalDivider(
                  thickness: 1,
                  color: CustomColors.background80,
                ),
                PageListTile(
                    title: 'Term of Service',
                    onTap: () {
                      Get.toNamed('/settings/termsOfService');
                    }),
                CustomHorizontalDivider(
                  thickness: 1,
                  color: CustomColors.background80,
                ),
                PageListTile(
                    title: 'Privacy Policy',
                    onTap: () {
                      Get.toNamed('/settings/privacyPolicy');
                    }),
                CustomHorizontalDivider(
                  thickness: 1,
                  color: CustomColors.background80,
                ),
                PageListTile(
                    title: 'About',
                    onTap: () {
                      Get.toNamed('/settings/about');
                    }),
                SizedBox(height: 2),
              ],
            )),
      ),
    );
  }
}

class SwitchListTile extends StatelessWidget {
  const SwitchListTile(
      {super.key,
      required this.title,
      required this.value,
      required this.onChange});
  final bool value;
  final Function onChange;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Switch(
            value: value,
            onChanged: (value) {
              onChange();
            },
            activeTrackColor: CustomColors.primary20,
            inactiveTrackColor: CustomColors.background60,
            inactiveThumbColor: CustomColors.typography60,
            activeColor: CustomColors.secondary,
            trackOutlineWidth: MaterialStateProperty.all(0),
            trackOutlineColor:
                MaterialStatePropertyAll(CustomColors.background),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}

class PageListTile extends StatelessWidget {
  const PageListTile({super.key, required this.title, required this.onTap});
  final Function onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SvgPicture.asset(
              'assets/icons/arrow-right.svg',
              width: 10,
              height: 16,
              colorFilter: ColorFilter.mode(
                CustomColors.typographyOverline,
                BlendMode.srcIn,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DropDownListTile extends StatelessWidget {
  const DropDownListTile({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            'WireGuard',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: CustomColors.typographyOverline),
          ),
        ],
      ),
    );
  }
}
