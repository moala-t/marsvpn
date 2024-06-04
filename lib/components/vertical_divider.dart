import 'package:flutter/material.dart';

class CustomVerticalDivider extends StatelessWidget {
  final double width;
  final double thickness;
  final Color color;
  final double indent;
  final double endIndent;

  const CustomVerticalDivider({
    super.key,
    this.width = 1.0,
    this.thickness = 1.0,
    this.color = Colors.black,
    this.indent = 0.0,
    this.endIndent = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: thickness,
      height: double.infinity,
      margin: EdgeInsets.only(top: indent, bottom: endIndent),
      color: color,
    );
  }
}
