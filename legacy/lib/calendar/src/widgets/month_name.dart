import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:provider/provider.dart';
import '../../../theme/theme_provider.dart';
import '../utils/enum_type.dart';

class MonthName extends StatelessWidget {
  const MonthName({
    super.key,
    required this.date,
    required this.calendarType,
    required this.primaryColor,
  });

  final DateTime date;
  final CalendarType calendarType;
  final Color? primaryColor;

  @override
  Widget build(BuildContext context) {
    TextStyle? titleStyle = Theme.of(context)
        .textTheme
        .titleSmall
        ?.copyWith(color: primaryColor ?? Theme.of(context).primaryColor);

    TextStyle? subTitleStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
        fontSize: 10.0, color: primaryColor ?? Theme.of(context).primaryColor);

    return SizedBox(
      height: 35.0,
      child: calendarType == CalendarType.bs
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  NepaliDateFormat('MMMM yyyy').format(date.toNepaliDateTime()),
                  style: titleStyle,
                ),
                // Text(
                //   '${DateFormat.MMMM().format(date)}/${DateFormat.MMMM().format(date.add(const Duration(days: 32)))}',
                //   style: subTitleStyle,
                // ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  DateFormat('MMMM yyyy').format(date),
                  style: titleStyle,
                ),
                // Text(
                //   '${NepaliDateFormat.MMMM().format(date.toNepaliDateTime())}/${NepaliDateFormat.MMMM().format(date.add(const Duration(days: 32)).toNepaliDateTime())}',
                //   style: subTitleStyle,
                // ),
              ],
            ),
    );
  }
}

class DateAndWeekname extends StatelessWidget {
  const DateAndWeekname({
    super.key,
    required this.date,
    required this.calendarType,
    required this.primaryColor,
  });

  final DateTime date;
  final CalendarType calendarType;
  final Color? primaryColor;


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    TextStyle? titleStyle = Theme.of(context)
        .textTheme
        .titleSmall
        ?.copyWith(color: primaryColor ?? Theme.of(context).primaryColor);

    TextStyle? subTitleStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
        fontSize: 10.0, color: primaryColor ?? Theme.of(context).primaryColor);
    DateTime currentDate = DateTime.now();
    NepaliDateTime nepalicurrentDate = NepaliDateTime.now();
    NepaliDateTime adjustedDate = nepalicurrentDate.subtract(const Duration(days: 2));

    String formattedDate = NepaliDateFormat('dd').format(adjustedDate);
    String formattedWeekName = NepaliDateFormat.EEEE().format(adjustedDate);
    return Padding(
      padding: const EdgeInsets.only(right: 2.0),
      child: Card(
        color: Colors.transparent,
        elevation: 3,
        child: calendarType == CalendarType.bs
            ? Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: themeProvider.gradient2,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              NepaliDateFormat('dd').format(date.toNepaliDateTime()),
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: themeProvider.gradientTextColor),
                            ),
                            Text(
                                // _isBsFormat
                                //  ? initialWeekName
                                formattedWeekName,
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Image.asset('assets/images/icon _sunrise_.png',color: themeProvider.tabUnSelectedLabelColor,),
                          const Text(
                            '6:30',
                            style: TextStyle(fontSize: 8),
                          ),
                          SizedBox(height: 6,),
                          Image.asset('assets/images/icon _sunrise_.png',color: themeProvider.tabUnSelectedLabelColor,),
                          const Text(
                            '6:45',
                            style: TextStyle(fontSize: 8),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: themeProvider.gradient2,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                            DateFormat('dd').format(currentDate),
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: themeProvider.gradientTextColor),
                            ),
                            Text(
                                // _isBsFormat
                                //  ? initialWeekName
                                DateFormat('EEEE').format(currentDate),

                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Image.asset('assets/images/icon _sunrise_.png',color: themeProvider.tabUnSelectedLabelColor,),
                          const Text(
                            '6:30',
                            style: TextStyle(fontSize: 8),
                          ),
                          Image.asset('assets/images/icon _sunrise_.png',color: themeProvider.tabUnSelectedLabelColor,),
                          const Text(
                            '6:45',
                            style: TextStyle(fontSize: 8),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
