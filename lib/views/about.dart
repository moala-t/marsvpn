import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marsvpn/components/appbar_button.dart';
import 'package:marsvpn/components/custom_app_bar.dart';
import 'package:marsvpn/components/main_view.dart';
import 'package:marsvpn/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:marsvpn/themes/colors.dart';

class About extends StatelessWidget {
  About({super.key});
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('About'),
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: IconWithDetail(),
          ),
        ),
      ),
    );
  }
}

class IconWithDetail extends StatelessWidget {
  const IconWithDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/app.svg',
          width: 100,
          height: 118,
        ),
        Text(
          'MARS VPN',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: CustomColors.secondary),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Version 1.0.0',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: CustomColors.typography60),
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          'Build 1',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: CustomColors.typography60),
        ),
        Flexible(
            child: Container(
          height: 160,
        )),
        Text(
          'www.marsvpn.com\nCopyright 2024 All Rights Reserved',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: CustomColors.typography60),
        ),
      ],
    );
  }
}
