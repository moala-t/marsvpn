import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton({
    super.key,
    required this.svgSrc,
    required this.onTap,
    this.semanticLabel = '',
    this.isLeftIcon = false,
    this.svgWidth = 20,
    this.svgHeight = 17,
  });

  final String semanticLabel;
  final String svgSrc;
  final Function onTap;
  final bool isLeftIcon;
  final double svgWidth;
  final double svgHeight;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
        activeOpacity: 0.8,
        onTap: () => onTap(),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFF4A4A61)),
              child: Center(
                child: SvgPicture.asset(
                  svgSrc,
                  width: svgWidth,
                  height: svgHeight,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              )),
        ));
  }
}
