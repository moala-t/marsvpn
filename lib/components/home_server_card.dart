import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'show_country.dart';
import 'dart:math' as math;

class HomeServerCard extends StatelessWidget {
  const HomeServerCard({
    super.key,
    required this.server,
  });

  final Map? server;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      activeOpacity: 0.8,
      onTap: () {
        Get.toNamed('/servers');
      },
      child: Container(
        height: 88,
        width: 327,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.background,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFF4A4A61)),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            server != null
                ? ShowCountry(
                    isoCode: server?['next_server']?['country'] ??
                        server?['country'],
                    // locationNum: 11,
                    ping: server?['ping']['number'].toInt(),
                    city: server?['next_server']?['city'] ?? server?['city'],
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 38.0),
                    child: Text('Choose Country'),
                  ),
            Transform.rotate(
              angle: -math.pi / 2,
              child: Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                    color: Color(0xff3a3a4d), shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: SvgPicture.asset(
                    'assets/icons/arrow-down.svg',
                    semanticsLabel: 'Arrow Icon',
                    fit: BoxFit.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SmartLocation extends StatelessWidget {
  const SmartLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/globe-gold.svg',
          width: 48,
          height: 30,
        ),
        SizedBox(
          width: 12,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Smart Location",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              "Fastest Server",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}
