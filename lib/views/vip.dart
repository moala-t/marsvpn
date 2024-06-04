import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:marsvpn/components/appbar_button.dart';
import 'package:marsvpn/components/custom_app_bar.dart';
import 'package:marsvpn/components/main_view.dart';
import 'package:marsvpn/components/public_icon.dart';
import 'package:marsvpn/components/toast.dart';
import 'package:marsvpn/controllers/home_controller.dart';
import 'package:marsvpn/themes/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class Vip extends StatelessWidget {
  Vip({super.key});
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Premium'),
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
      body: MainView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(),
            Spacer(
              flex: 6,
            ),
            Features2(),
            Spacer(
              flex: 6,
            ),
            ...homeController.pricingPlans.asMap().entries.map((entry) {
              int idx = entry.key;
              var pricingPlan = entry.value;
              return [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: PricingPlanCard(
                    pricingPlan: pricingPlan,
                    homeController: homeController,
                  ),
                ),
                if (idx != homeController.pricingPlans.length - 1)
                  Spacer(
                    flex: 2,
                  ),
              ];
            }).expand((widget) => widget),
            Spacer(
              flex: 6,
            ),
            PremiumButton(
              onTap: () {
                showToast('Loading', 'loading', homeController.fToast);
              },
            ),
            Spacer(
              flex: 1,
            ),
            SizedBox(
              height: 4,
            ),
            RestoreButton(),
            Spacer(
              flex: 1,
            ),
            SizedBox(
              height: 4,
            )
          ],
        ),
      ),
    );
  }
}

class PremiumButton extends StatelessWidget {
  final Function onTap;
  const PremiumButton({super.key, required this.onTap});

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
            shape: BoxShape.rectangle,
            gradient: LinearGradient(
              begin: Alignment(1.00, 0.00),
              end: Alignment(-1, 0),
              colors: [
                CustomColors.goldGradientEnd,
                CustomColors.goldGradientStart,
              ],
            ),
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            'Upgrade to Premium Now',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}

class RestoreButton extends StatelessWidget {
  const RestoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        Get.toNamed('/redeem');
      },
      activeOpacity: 0.8,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          gradient: LinearGradient(
            begin: Alignment(1.00, 0.00),
            end: Alignment(-1, 0),
            colors: [
              Color(0xFF4e4e67),
              // Color(0xFF45455b),
              CustomColors.background80,
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            'Restore Previous Purchase',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
      ),
    );
  }
}

class PricingPlanCard extends StatelessWidget {
  const PricingPlanCard({
    super.key,
    required this.pricingPlan,
    required this.homeController,
  });
  // final double width;
  final Map pricingPlan;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    var devices = pricingPlan['devices'];
    var price = pricingPlan['price'];
    var perTime = pricingPlan['per_time'];
    return Obx(
      () => TouchableOpacity(
        activeOpacity: 0.8,
        onTap: () {
          homeController.setSelectedPricingPlan(pricingPlan);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          decoration: ShapeDecoration(
            color: (homeController.selectedPricingPlan.value?['id'] ==
                    pricingPlan['id'])
                ? Theme.of(context).colorScheme.secondary.withOpacity(0.09)
                : Theme.of(context).colorScheme.background,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 1,
                  color: (homeController.selectedPricingPlan.value?['id'] ==
                          pricingPlan['id'])
                      ? Theme.of(context).colorScheme.secondary
                      : Color(0xFF4A4A61)),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pricingPlan['time_str'].toString().toUpperCase(),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text('Link up to $devices Device',
                              style: Theme.of(context).textTheme.labelSmall),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$$price',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w400, height: 0.8),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text('/ $perTime',
                              style: Theme.of(context).textTheme.labelSmall),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 28,
                height: 28,
                child: Radio(
                  value: pricingPlan['id'],
                  groupValue: homeController.selectedPricingPlan.value?['id'],
                  activeColor: Theme.of(context).colorScheme.secondary,
                  onChanged: (value) =>
                      homeController.setSelectedPricingPlan(pricingPlan),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Features extends StatelessWidget {
  const Features({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0),
      child: Column(
        children: [
          FeatureCard(
            title: 'No Ads',
            detail: 'Enjoy surfing without annoying ads',
            svgSrc: 'assets/icons/prohibited.svg',
          ),
          FeatureCard(
            title: 'Fast',
            detail: 'Increase connection speed',
            svgSrc: 'assets/icons/rocket.svg',
          ),
          FeatureCard(
            title: 'All Servers',
            detail: 'Access all server worldwide',
            svgSrc: 'assets/icons/world.svg',
          ),
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  const FeatureCard(
      {super.key,
      required this.title,
      required this.detail,
      required this.svgSrc});
  final String title;
  final String detail;
  final String svgSrc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        // direction: Axis.horizontal,

        children: [
          Container(
            width: 48,
            height: 48,
            decoration: ShapeDecoration(
              color: CustomColors.background80,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                svgSrc,
                width: 24,
                height: 24,
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Wrap(
            direction: Axis.vertical,
            spacing: 14,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                detail,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          )
        ],
      ),
    );
  }
}

class Features2 extends StatelessWidget {
  const Features2({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FeatureCard2(
          title: 'No Ads',
          svgSrc: 'assets/icons/prohibited.svg',
        ),
        FeatureCard2(
          title: 'Fast',
          svgSrc: 'assets/icons/rocket.svg',
        ),
        FeatureCard2(
          title: 'All Servers',
          svgSrc: 'assets/icons/world.svg',
        ),
      ],
    );
  }
}

class FeatureCard2 extends StatelessWidget {
  const FeatureCard2({super.key, required this.title, required this.svgSrc});
  final String title;
  final String svgSrc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 90,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: ShapeDecoration(
                color: CustomColors.background80,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  svgSrc,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Wrap(
              direction: Axis.vertical,
              spacing: 14,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            )
          ],
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
        children: [
          PublicIcon(
            svgSrc: 'assets/icons/crown.svg',
            svgWidth: 37,
            svgHeight: 28,
          ),
          MediaQuery.of(context).size.height >= 685
              ? Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Upgrade to Premium Now',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Access all servers worldwide, fast and powerful',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
