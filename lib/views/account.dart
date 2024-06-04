import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:marsvpn/components/appbar_button.dart';
import 'package:marsvpn/components/custom_app_bar.dart';
import 'package:marsvpn/components/horizontal_divider.dart';
import 'package:marsvpn/components/user_profile.dart';
import 'package:marsvpn/controllers/home_controller.dart';
import 'package:marsvpn/themes/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:intl/intl.dart';

class Account extends StatelessWidget {
  Account({super.key});
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Account'),
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
      body: Padding(
          padding: EdgeInsets.fromLTRB(24, 10, 24, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              SizedBox(
                height: 20,
              ),
              Section(),
              SizedBox(
                height: 20,
              ),
              LogoutButton(
                onTap: homeController.logout,
              ),
              SizedBox(
                height: 20,
              )
            ],
          )),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key, required this.onTap});
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        onTap();
      },
      activeOpacity: 0.8,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border:
                Border.all(width: 1, color: CustomColors.typographyOverline),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 10,
            children: [
              SvgPicture.asset(
                'assets/icons/logout.svg',
                width: 18,
                height: 18,
              ),
              Text(
                'Logout',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserProfile(
            size: 140,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Anonymous User',
            style: Theme.of(context).textTheme.headlineMedium,
          )
        ],
      ),
    );
  }
}

class Section extends StatelessWidget {
  Section({super.key});
  // days_left
  final homeController = Get.find<HomeController>();

  int calculateDaysLeft(endDateStr) {
    if (endDateStr == '') {
      return 0;
    }
    DateTime endDate = DateFormat('yyyy-MM-dd').parse(endDateStr);
    DateTime now = DateTime.now();
    int daysLeft = endDate.difference(now).inDays;
    return daysLeft < 0 ? 0 : daysLeft;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
      child: Container(
            padding: EdgeInsets.all(30),
            height: 304,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 30,
                      offset: Offset(16, 16),
                      spreadRadius: 0,
                      blurStyle: BlurStyle.inner)
                ],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(34),
                color: CustomColors.background80),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PremiumBox(
                      price: homeController.user.value?['active_subscription']
                              ?['pricing_plan']?['price'] ??
                          '',
                      perDays: homeController.user.value?['active_subscription']
                              ?['pricing_plan']?['per_time'] ??
                          '',
                    ),
                    DetailBox(
                        title: calculateDaysLeft(homeController.user
                                    .value?['active_subscription']?['end_date'] ??
                                '')
                            .toString(),
                        detail: 'Days Left')
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomHorizontalDivider(
                    color: CustomColors.background60,
                  ),
                ),
                ActivationCode(
                  activationCode: homeController.user.value?['code'] ?? '',
                ),
                Flexible(child: Container(height: 20)),
                Device(
                  loggedinDevices:
                      homeController.user.value?['loggedin_devices'] ?? [],
                  numOfAllowedDevice:
                      homeController.user.value?['active_subscription']
                              ?['pricing_plan']?['devices'] ??
                          0,
                ),

              ],
            ),
          ),
    ));
  }
}

class PremiumBox extends StatelessWidget {
  const PremiumBox({super.key, required this.price, required this.perDays});
  final String price;
  final String perDays;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        spacing: 8,
        direction: Axis.vertical,
        children: [
          SvgPicture.asset(
            'assets/icons/crown.svg',
            width: 21.85,
            height: 16.66,
          ),
          Text(
            'Premium',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            (price == '' || perDays == '')
                ? 'Subscription Expired'
                : '\$$price / $perDays',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class DetailBox extends StatelessWidget {
  const DetailBox({super.key, required this.title, required this.detail});
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      width: 77,
      height: 72,
      decoration: BoxDecoration(
          color: CustomColors.background60,
          borderRadius: BorderRadius.circular(16)),
      child: Center(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          spacing: 5,
          children: [
            Text(
              textAlign: TextAlign.center,
              title,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Text(detail, style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}

class ActivationCodeController extends GetxController {
  var showCode = false.obs;

  toggleShowCode() {
    showCode.value = !showCode.value;
  }
}

class ActivationCode extends StatelessWidget {
  ActivationCode({super.key, required this.activationCode});
  final String activationCode;

  final activationCodeController = Get.put(ActivationCodeController());
  final view = SvgPicture.asset(
    'assets/icons/view.svg',
    width: 16,
    height: 16,
    colorFilter: ColorFilter.mode(CustomColors.typography, BlendMode.srcIn),
  );
  final hidden = SvgPicture.asset(
    'assets/icons/hidden.svg',
    width: 16,
    height: 16,
    colorFilter: ColorFilter.mode(CustomColors.typography, BlendMode.srcIn),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          // height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.spaceBetween,
                spacing: 20,
                children: [
                  Wrap(
                    direction: Axis.vertical,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/lock.svg',
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                            CustomColors.typography, BlendMode.srcIn),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0), // ffff
                    child: Wrap(
                      spacing: 10,
                      direction: Axis.vertical,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Text(
                          'Activation Code',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  height: 1),
                        ),
                        Text(
                          activationCodeController.showCode.value
                              ? activationCode
                              : activationCode.replaceAll(RegExp(r'.'), '*'),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  height: 1,
                                  letterSpacing: 1),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: Wrap(
                  spacing: 10,
                  direction: Axis.vertical,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    TouchableOpacity(
                      activeOpacity: 0.2,
                      onTap: () {
                        activationCodeController.toggleShowCode();
                      },
                      child: activationCodeController.showCode.value
                          ? view
                          : hidden,
                    ),
                    TouchableOpacity(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: activationCode));
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Copied to clipboard!')));
                      },
                      activeOpacity: 0.2,
                      child: SvgPicture.asset(
                        'assets/icons/copy.svg',
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                            CustomColors.typography, BlendMode.srcIn),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class Device extends StatelessWidget {
  const Device({
    super.key,
    required this.loggedinDevices,
    required this.numOfAllowedDevice,
  });

  final List loggedinDevices;
  final int numOfAllowedDevice;

  @override
  Widget build(BuildContext context) {
    final lenLoggedinDevices = loggedinDevices.length;
    print(loggedinDevices);

    return Container(
      child: Row(
        children: [
          Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.spaceBetween,
            spacing: 20,
            children: [
              Wrap(
                direction: Axis.vertical,
                children: [
                  SvgPicture.asset(
                    'assets/icons/device.svg',
                    width: 22,
                    height: 22,
                    colorFilter: ColorFilter.mode(
                        CustomColors.typography, BlendMode.srcIn),
                  )
                ],
              ),
              Wrap(
                spacing: 10,
                direction: Axis.vertical,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text(
                    'Device ($lenLoggedinDevices/$numOfAllowedDevice)',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400, fontSize: 14, height: 1),
                  ),
                  ...loggedinDevices.map((device) {
                    // final deviceId = device['device_id'];
                    final deviceModel = device['model'];
                    return Text(
                      '$deviceModel', // Adjust according to your actual data structure
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          // fontWeight: FontWeight.w400,
                          // fontSize: 14,
                          height: 0),
                    );
                  }),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
