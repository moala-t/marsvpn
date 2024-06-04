import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marsvpn/components/horizontal_divider.dart';
import 'package:marsvpn/components/user_profile.dart';
import 'package:marsvpn/themes/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class DrawerListView extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  DrawerListView({super.key});

  @override
  Widget build(BuildContext context) {
    // print(homeController.isLogin.value);
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 246,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Wrap(
                    direction: Axis.vertical,
                    spacing: 16,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      UserProfile(),
                      Obx(() => (homeController.isLogin.value)
                          ? Text(
                              'Anonymous User',
                              style: Theme.of(context).textTheme.headlineMedium,
                            )
                          : RedeemButton(
                              title: 'Redeem',
                            ))
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: CustomHorizontalDivider(
              color: CustomColors.background80,
              thickness: 1,
            ),
          ),
          Column(
            children: [
              CustomListTile(
                  svgSrc: 'assets/icons/user.svg',
                  title: 'Account',
                  onTap: () {
                    homeController.isLogin.value
                        ? Get.toNamed('/account')
                        : Get.toNamed('/vip');
                  }),
              CustomListTile(
                  svgSrc: 'assets/icons/setting.svg',
                  title: 'Setting',
                  onTap: () {
                    Get.toNamed('/settings');
                  }),
              CustomListTile(
                  svgSrc: 'assets/icons/share.svg',
                  title: 'Share',
                  onTap: () {
                    // Get.back();
                    Get.toNamed('/share');
                  }),
              CustomListTile(
                  svgSrc: 'assets/icons/info.svg',
                  title: 'About',
                  onTap: () {
                    Get.toNamed('/about');
                  }),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.svgSrc,
      required this.title,
      required this.onTap});

  final String svgSrc;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 70,
      child: Center(
        child: ListTile(
          // enableFeedback: false,
          dense: true,
          visualDensity: VisualDensity(vertical: 4),

          horizontalTitleGap: 35,
          splashColor: CustomColors.background.withOpacity(0.4),
          contentPadding: EdgeInsets.only(left: 40),
          leading: SvgPicture.asset(
            svgSrc,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              CustomColors.typography,
              BlendMode.srcIn,
            ),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          onTap: () => onTap(),
        ),
      ),
    );
  }
}

class RedeemButton extends StatelessWidget {
  const RedeemButton({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
        activeOpacity: 0.7,
        onTap: () {
          Get.toNamed('/redeem');
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: CustomColors.background80.withOpacity(0.5),
          ),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w400),
          ),
        ));
  }
}
