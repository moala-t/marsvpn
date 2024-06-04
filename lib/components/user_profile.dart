import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marsvpn/themes/colors.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
    this.size = 120,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColors.background60.withOpacity(0.3)),
      child: Center(
        child: Container(
          width: size * 2 / 3,
          height: size,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: CustomColors.background60),
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/user.svg',
              height: size * 0.31875,
              width: size * 0.31875,
              colorFilter: ColorFilter.mode(
                CustomColors.typography,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
