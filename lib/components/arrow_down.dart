import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marsvpn/themes/colors.dart';

class ArrowDown extends StatelessWidget {
  const ArrowDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        color: CustomColors.background80,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        'assets/icons/arrow-down.svg',
        semanticsLabel: 'Arrow Icon',
        fit: BoxFit.none,
      ),
    );
  }
}
