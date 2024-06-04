import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class CustomTimer extends StatelessWidget {
  const CustomTimer({
    super.key, // Add Key? key here
    required this.seconds,
    this.onEnd,
  });

  final Function()? onEnd;
  final int seconds;

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Text('Please try again in '),
      SizedBox(
        width: 20,
        child: TimerCountdown(
          // colonsTextStyle: ,
          timeTextStyle: TextStyle(color: Colors.blueAccent),
          enableDescriptions: false,
          format: CountDownTimerFormat.secondsOnly,
          spacerWidth: 3,
          endTime: DateTime.now().add(
            Duration(
              seconds: seconds,
            ),
          ),
          onEnd: () {
            onEnd?.call();
          },
        ),
      ),
      Text(' seconds.')
    ]);
  }
}
