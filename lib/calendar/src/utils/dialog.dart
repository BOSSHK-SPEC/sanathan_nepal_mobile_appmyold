
import 'package:flutter/material.dart';

import '../calendar.dart';
import 'enum_type.dart';



Future<DateTime?> showFlutterBSADCalendarDialog({
  required BuildContext context,
  CalendarType? calendarType,
  List<DateTime?> value = const [],
  BorderRadius? borderRadius,
  bool useRootNavigator = true,
  bool barrierDismissible = true,
  Color? barrierColor = Colors.black54,
  bool useSafeArea = true,
  Color? dialogBackgroundColor,
  RouteSettings? routeSettings,
  String? barrierLabel,
}) {
  var dialog = Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
    backgroundColor: dialogBackgroundColor ?? Theme.of(context).canvasColor,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(10),
    ),
    clipBehavior: Clip.antiAlias,
    child: Container(
      height: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: FlutterBSADCalendar(
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime(2024),
        calendarType: calendarType ?? CalendarType.bs,
        onDateSelected: (date, events) => Navigator.of(context).pop(date),
      ),
    ),
  );

  return showDialog<DateTime?>(
    context: context,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    builder: (BuildContext context) => dialog,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    barrierLabel: barrierLabel,
    useSafeArea: useSafeArea,
  );
}
