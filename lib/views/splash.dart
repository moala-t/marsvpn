import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marsvpn/components/gradient_text.dart';
import 'package:marsvpn/themes/colors.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/map2.png'),
            colorFilter: ColorFilter.mode(Color(0xFF3A3A4D), BlendMode.srcIn),
            fit: BoxFit.cover, // Adjust this according to your needs
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/app.svg',
                width: 160,
                height: 190,
              ),
              GradientText(
                'MARS VPN',
                style: Theme.of(context).textTheme.displaySmall,
                gradient: LinearGradient(colors: [
                  CustomColors.goldGradientStart,
                  CustomColors.goldGradientEnd,
                ]),
              ),
              GradientText(
                'Best VPN APP',
                style: Theme.of(context).textTheme.bodyMedium,
                gradient: LinearGradient(colors: [
                  CustomColors.typographyOverline,
                  CustomColors.typography60,
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
