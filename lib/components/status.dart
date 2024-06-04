import 'package:flutter/material.dart';
import 'package:marsvpn/themes/colors.dart';

class Status extends StatelessWidget {
  final String status;

  const Status({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      child: () {
        if (status == 'connected') {
          return Wrap(
            spacing: 8,
            direction: Axis.horizontal,
            children: [
              // SvgPicture.asset(
              //   'assets/icons/tick.svg',
              //   width: 14.69,
              //   height: 15.29,
              //   // colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              // ),
              Text(
                'Connected',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: CustomColors.secondary),
              )
            ],
          );
        } else if (status == 'connecting') {
          return Text(
            'Connecting',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: CustomColors.typography),
          );
        } else {
          return Text(
            'Disconnected',
            style: Theme.of(context).textTheme.titleSmall,
          );
        }
      }(),
    );
  }
}
