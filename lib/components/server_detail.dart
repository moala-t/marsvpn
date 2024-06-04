import 'package:flutter/material.dart';

class ServerDetail extends StatelessWidget {
  const ServerDetail(
      {super.key,
      required this.ping,
      required this.city,
      required this.tunnelled,
      this.textStyle,
      this.pingSize = 6});

  final int? ping;
  final String? city;
  final TextStyle? textStyle;
  final double pingSize;
  final bool tunnelled;

  @override
  Widget build(BuildContext context) {
    final tunnelledText = tunnelled ? '- Tunnelled' : '';
    return Row(
      children: [
        Container(
          width: pingSize,
          height: pingSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF23B65D),
          ),
        ),
        SizedBox(width: pingSize),
        Text(
          '$ping ms - $city $tunnelledText',
          style: textStyle ?? Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }
}
