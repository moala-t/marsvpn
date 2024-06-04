import 'package:flutter/material.dart';

class CustomHorizontalDivider extends StatelessWidget {
  final double thickness;
  final Color color;
  final double indent;
  final double endIndent;

  const CustomHorizontalDivider({
    super.key,
    this.thickness = 1.0,
    this.color = Colors.black,
    this.indent = 0.0,
    this.endIndent = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness,
      color: color,
      indent: indent,
      endIndent: endIndent,
    );
  }
}