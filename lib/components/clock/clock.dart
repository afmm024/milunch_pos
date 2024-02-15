import 'package:flutter/material.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class Clock extends StatelessWidget {
  const Clock({super.key});
  @override
  Widget build(BuildContext context) {
    return DigitalClock(
      hourMinuteDigitTextStyle:
          Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black),
      secondDigitTextStyle:
          Theme.of(context).textTheme.caption!.copyWith(color: Colors.black),
      colon: Text(
        ":",
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: Colors.black),
      ),
    );
  }
}
