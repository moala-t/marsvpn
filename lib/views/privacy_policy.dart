import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marsvpn/components/appbar_button.dart';
import 'package:marsvpn/components/custom_app_bar.dart';
import 'package:marsvpn/components/main_view.dart';
import 'package:marsvpn/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:marsvpn/themes/colors.dart';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy({super.key});
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Privacy Policy'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2,
            ),
            LastUpdate(date: 'May 27, 2024'),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(privacyPlicy)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

// class Section extends StatelessWidget {
//   const Section({
//     super.key,
//     required this.header,
//     required this.body,
//   });
//   final String? header;
//   final String? body;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 18.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         // direction: Axis.vertical,
//         children: [
//           Text(
//             header ?? '',
//             style: Theme.of(context)
//                 .textTheme
//                 .titleMedium
//                 ?.copyWith(color: CustomColors.secondary),
//           ),
//           SizedBox(
//             height: 14,
//           ),
//           Text(
//             body ?? '',
//             style: Theme.of(context).textTheme.bodyMedium,
//             softWrap: true,
//             overflow: TextOverflow.visible,
//           ),
//         ],
//       ),
//     );
//   }
// }

class LastUpdate extends StatelessWidget {
  const LastUpdate({super.key, required this.date});
  final String date;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      direction: Axis.horizontal,
      spacing: 10,
      children: [
        SvgPicture.asset(
          'assets/icons/calendar.svg',
          width: 12,
          height: 13,
          colorFilter: ColorFilter.mode(
            CustomColors.typography60,
            BlendMode.srcIn,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 1.0),
          child: Text(
            'Last update : $date',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

const String privacyPlicy =
    """This document outlines the privacy practices relevant to all information collected or submitted when you access, install, or use Mars VPN Services.

All definitions and capitalized terms used in this Privacy Policy are specified here or in our General Terms.

By visiting our websites, submitting your personal data, or accessing, installing, and/or using the Services, you acknowledge that you have read and agree to this Privacy Policy. If you do not agree with any part of this Privacy Policy, please refrain from using our Services.

We are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our Services.

We collect various types of information in connection with the Services, including personal information, usage data, and information collected through cookies and tracking technologies.

We use the information we collect for various purposes, including providing and maintaining our Services, improving user experience, and complying with legal obligations.

We do not share your personal information with third parties except with your consent, for legal reasons, or with service providers who assist us in operating our Services.

Depending on your jurisdiction, you may have rights regarding your personal information, such as the right to access, rectify, and delete your data.

We implement appropriate measures to protect your personal data against unauthorized access, loss, or misuse. However, no method of transmission over the internet or method of electronic storage is completely secure.

We retain your personal data only for as long as necessary to fulfill the purposes for which it was collected and to comply with legal requirements.

Your personal data may be transferred to, stored, or processed in a country other than your own. We take steps to ensure that your personal data receives an adequate level of protection.

For additional details specific to certain Mars VPN products or websites, please refer to the links provided within this Privacy Policy.ils specific to certain Mars VPN products or websites, please refer to the links provided within this Privacy Policy.""";
