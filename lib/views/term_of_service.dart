import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marsvpn/components/appbar_button.dart';
import 'package:marsvpn/components/custom_app_bar.dart';
import 'package:marsvpn/components/main_view.dart';
import 'package:marsvpn/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:marsvpn/themes/colors.dart';

class TermOfService extends StatelessWidget {
  TermOfService({super.key});
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Term of Services'),
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
                  for (var section in termOfService)
                    Section(header: section['header'], body: section['body']),
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

class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.header,
    required this.body,
  });
  final String? header;
  final String? body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // direction: Axis.vertical,
        children: [
          Text(
            header ?? '',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: CustomColors.secondary),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            body ?? '',
            style: Theme.of(context).textTheme.bodyMedium,
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }
}

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

const List<Map<String, String>> termOfService = [
  {
    "header": "1. Agreement with MARS VPN",
    "body":
        """Additional Conditions. Our Services may be subject to additional conditions ("Additional Conditions"). If there is any inconsistency between the terms in the General Terms and the Additional Conditions, the Additional Conditions will prevail for that Service."""
  },
  {
    "header": "2. Our Offerings",
    "body":
        """To access any of our Services, you must create an account. You are solely responsible for all activities on your account, including any unauthorized use or access by others."""
  },
  {
    "header": "3. Licensing Terms",
    "body":
        """Subject to the terms and conditions of these Terms, we grant you a limited, revocable, non-exclusive, personal, non-transferable, non-sublicensable license to: (1) download and use a copy of our software; and (2) utilize the Services, including the products and services available through our software or website. No other rights or licenses, whether express or implied, are granted to you under these Terms. This license remains in effect until terminated. Failure to comply with these Terms will result in automatic termination of this license."""
  }
];
