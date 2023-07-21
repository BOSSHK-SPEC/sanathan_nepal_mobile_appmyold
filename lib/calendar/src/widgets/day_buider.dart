
import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';

import '../utils/enum_type.dart';

class DayBuilder extends StatelessWidget {
  const DayBuilder({
    Key? key,
    required this.dayToBuild,
    required this.calendarType,
    required this.dayColor,
    required this.secondaryDayColor,
  }) : super(key: key);

  final DateTime dayToBuild;
  final CalendarType calendarType;
  final Color? dayColor;
  final Color? secondaryDayColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            calendarType == CalendarType.bs
                ? NepaliDateFormat.d().format(dayToBuild.toNepaliDateTime())
                : '${dayToBuild.day}',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: dayColor),
          ),
        ),
        Positioned(
          right: 0.0,
          bottom: 0.0,
          child: Text(
            calendarType == CalendarType.bs
                ? '${dayToBuild.day}'
                : NepaliDateFormat.d().format(dayToBuild.toNepaliDateTime()),
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(fontSize: 8.0, color: secondaryDayColor),
          ),
        ),
      ],
    );
  }
}
