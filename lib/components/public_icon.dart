import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marsvpn/themes/colors.dart';

class PublicIcon extends StatelessWidget {
  const PublicIcon({
    super.key,
    required this.svgSrc,
    required this.svgWidth,
    required this.svgHeight,
  });

  final String svgSrc;
  final double svgWidth;
  final double svgHeight;

  static const Color goldGradientStart = Color(0xFFB88400);
  static const Color goldGradientEnd = Color(0xFFD6A21E);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: ShapeDecoration(
        color: CustomColors.primary10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Center(
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [goldGradientStart, goldGradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcIn,
          child: SvgPicture.asset(
            svgSrc,
            width: svgWidth,
            height: svgHeight,
            colorFilter: ColorFilter.mode(Colors.white,
                BlendMode.srcIn), // Necessary to apply the gradient correctly
          ),
        ),
      ),
    );
  }
}
