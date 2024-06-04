import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ConnectingTime extends StatelessWidget {
  const ConnectingTime({super.key, required this.timer});
  final StopWatchTimer timer;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 9,
      children: [
        Text(
          'Connecting Time',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        TimerCountUp(timer: timer)
        // CounterUpTimer(
        //   controller: controller,
        // ),
      ],
    );
  }
}

class TimerCountUp extends StatelessWidget {
  const TimerCountUp({super.key, required this.timer});
  final StopWatchTimer timer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: timer.rawTime,
      initialData: 0,
      builder: (context, snap) {
        final value = snap.data;
        final hour = StopWatchTimer.getDisplayTimeHours(value!);
        final minute = StopWatchTimer.getDisplayTimeMinute(value);
        final seconds = StopWatchTimer.getDisplayTimeSecond(value);
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '$hour:$minute:$seconds',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ],
        );
      },
    );
  }
}

void startTimer(StopWatchTimer timer, {presetSeconds = 0}) {
  timer.setPresetSecondTime(presetSeconds);
  timer.onStartTimer();
}

void stopTimer(StopWatchTimer timer, {reset = true, presetSeconds = 0}) {
  timer.clearPresetTime();
  timer.onResetTimer();
  timer.onStopTimer();
}
