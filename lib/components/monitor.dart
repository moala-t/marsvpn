import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Monitor extends StatelessWidget {
  const Monitor({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Wrap(
        spacing: 50,
        children: <Widget>[
          MonitorItem(
            label: 'Download',
            metered: '112 KB/s',
            iconSrc: 'assets/icons/download.svg',
          ),
          Container(
            width: 0.4, // The width of the vertical line
            height: 34, // The height of the vertical line
            color: Colors.white, // The color of the vertical line
          ),
          MonitorItem(
              label: 'Upload',
              metered: '245 KB/s',
              iconSrc: 'assets/icons/upload.svg'),
        ],
      ),
    );
  }
}

class MonitorItem extends StatelessWidget {
  final String iconSrc;
  final String metered;
  final String label;

  const MonitorItem(
      {super.key,
      required this.label,
      required this.metered,
      required this.iconSrc});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
      children: <Widget>[
        SvgPicture.asset(
          iconSrc,
          semanticsLabel: 'Power Icon',
          height: 20,
          width: 20,
          colorFilter: ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
        Wrap(
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.start,
          alignment: WrapAlignment.center,
          direction: Axis.vertical,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Wrap(
              children: [
                Text(
                  metered,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
