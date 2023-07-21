import 'package:flutter/material.dart';

import 'package:intl/intl.dart' show DateFormat, NepaliDateFormat, Language;

import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_date_picker/nepali_date_picker.dart';

import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_utils/nepali_utils.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/view/helper/colors.dart';
import 'package:sanathan_nepal_mobile_app/view/helper/styles.dart';

import '../theme/theme_provider.dart';

class   CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  CustomCalendarState createState() => CustomCalendarState();
}

class CustomCalendarState extends State<CustomCalendar> {
  picker.NepaliDateTime _currentDate = picker.NepaliDateTime.now();
  bool _isBsFormat = true;
  late picker.NepaliDateTime today;
  // late picker.NepaliDateTime initialToday;
  String initialWeekName = '';
  List<String> monthNames = [];
  late String monthName;
  String monthNameAd = '';
  String yearAd = '';
  String yearBs = '';
  String initialToday = '';

  List<DateTime> eventDates = [
    DateTime(2023, 6, 1),
    DateTime(2023, 6, 5),
    DateTime(2023, 6, 10),
  ];
  List<DateTime> eventDates2 = [
    DateTime(2023, 6, 2),
    DateTime(2023, 6, 7),
    DateTime(2023, 6, 13),
  ];
  @override
  void initState() {
    super.initState();
    today = picker.NepaliDateTime.now();
    initialToday = NepaliDateFormat('dd', Language.nepali).format(today);

    initialWeekName = _getNepaliWeekday(_currentDate.weekday);
    _currentDate = _isBsFormat
        ? picker.NepaliDateTime.now()
        : picker.NepaliDateTime.fromDateTime(DateTime.now());

    monthNames = _generateMonthNames();
    monthName = DateFormat.MMMM().format(DateTime.now());
    updateMonthNameAd();
  }

  void updateMonthNameAd() {
    DateTime adDateTime = _currentDate.toDateTime();
    monthNameAd = DateFormat.MMMM().format(adDateTime);
    yearAd = _getFormattedYear(_currentDate);
    NepaliDateTime nepaliDateTime = NepaliDateTime.fromDateTime(adDateTime);

    yearBs = NepaliDateFormat('yyyy', Language.nepali).format(nepaliDateTime);
  }

  void _goToNextMonth() {
    setState(() {
      int daysInMonth =
          _getDaysInNepaliMonth(_currentDate.year, _currentDate.month);
      _currentDate = _isBsFormat
          ? _currentDate.add(Duration(days: daysInMonth))
          : picker.NepaliDateTime.fromDateTime(
              _currentDate.toDateTime().add(Duration(days: daysInMonth)));

      // Update month name for AD format
      if (!_isBsFormat) {
        updateMonthNameAd();
      }
    });
  }

  void _goToPreviousMonth() {
    setState(() {
      int daysInMonth =
          _getDaysInNepaliMonth(_currentDate.year, _currentDate.month);
      _currentDate = _isBsFormat
          ? _currentDate.subtract(Duration(days: daysInMonth))
          : picker.NepaliDateTime.fromDateTime(
              _currentDate.toDateTime().subtract(Duration(days: daysInMonth)));

      // Update month name for AD format
      if (!_isBsFormat) {
        updateMonthNameAd();
      }
    });
  }

  void _refreshCalendar() {
    setState(() {
      _currentDate = picker.NepaliDateTime.now();

      // Update month name for AD format
      updateMonthNameAd();
    });
  }

  List<String> _generateMonthNames() {
    List<String> names = [];
    for (int month = 1; month <= 12; month++) {
      NepaliDateFormat formatter = NepaliDateFormat('MMMM', Language.nepali);
      NepaliDateTime nepaliDateTime = NepaliDateTime(_currentDate.year, month);
      String monthName = formatter.format(nepaliDateTime);
      names.add(monthName);
    }
    return names;
  }

  String _getFormattedYear(picker.NepaliDateTime date) {
    if (_isBsFormat) {
      return NepaliDateFormat("y").format(date);
    } else {
      return DateFormat.y().format(date.toDateTime());
    }
  }

  String _getNepaliWeekday(int weekday) {
    switch (weekday) {
      case 0:
        return 'सोमबार'; // Monday
      case 1:
        return 'मङ्गलबार'; // Tuesday
      case 2:
        return 'बुधबार'; // Wednesday
      case 3:
        return 'बिहिबार'; // Thursday
      case 4:
        return 'शुक्रबार'; // Friday
      case 5:
        return 'शनिबार'; // Saturday
      case 6:
        return 'आइतबार'; // Sunday
      default:
        return '';
    }
  }

  String _getNarrowWeekday(int weekday) {
    switch (weekday) {
      case 0:
        return 'श';
      case 1:
        return 'आ';
      case 2:
        return 'सो';
      case 3:
        return 'मं';
      case 4:
        return 'बु';
      case 5:
        return 'वि';
      case 6:
        return 'शु';
      default:
        return '';
    }
  }

  int _getDaysInNepaliMonth(int year, int month) {
    final picker.NepaliDateTime startOfMonth =
        picker.NepaliDateTime(year, month);
    final picker.NepaliDateTime endOfMonth =
        picker.NepaliDateTime(year, month + 1);
    final int daysInMonth = endOfMonth.difference(startOfMonth).inDays;
    return daysInMonth;
  }

  Widget buildCalendarWidget(ThemeProvider? themeProvider) {
    DateTime now = DateTime.now();
    return Expanded(
      child: SizedBox(
        height: 250,
        width: 250,
        child: Table(
          border: TableBorder.all(
            //color: themeProvider.whiteLiteContainerBackground,
           color: Colors.grey.shade700,
            width: 1.0,
          ),
          children: [
            TableRow(
              children: List.generate(7, (index) {
                final int weekday = (index + 1) % 7 == 0 ? 7 : (index + 1) % 7;
                final int adjustedIndex =
                    (weekday + 3) % 7; // Adjust the index to start from Monday
                return TableCell(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        _isBsFormat
                            ? _getNarrowWeekday((weekday + 1) % 7)
                            : DateFormat.E()
                                .format(now.add(Duration(days: adjustedIndex)))
                                .substring(0, 1),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }),
            ),
            for (int row = 0; row < 6; row++)
              TableRow(
                children: List.generate(7, (column) {
                  final int bsYear = _currentDate.year;
                  final int bsMonth = _currentDate.month;

                  final int bsFirstDayOfMonth =
                      picker.NepaliDateTime(bsYear, bsMonth).weekday;
                  final int daysInMonth =
                      _getDaysInNepaliMonth(bsYear, bsMonth);

                  final int totalDays = daysInMonth + bsFirstDayOfMonth - 1;

                  final int currentIndex = row * 7 + column;
                  final int currentDayInMonth =
                      currentIndex - bsFirstDayOfMonth + 2;

                  int displayedDay;
                  if (currentDayInMonth >= 1 &&
                      currentDayInMonth <= totalDays) {
                    displayedDay = currentDayInMonth;
                  } else if (currentDayInMonth < 1) {
                    final int prevMonthDays =
                        _getDaysInNepaliMonth(bsYear, bsMonth - 1);
                    displayedDay = prevMonthDays + currentDayInMonth;
                  } else {
                    displayedDay = currentDayInMonth - totalDays;
                  }

                  DateTime dateTime;
                  if (_isBsFormat) {
                    dateTime = picker.NepaliDateTime(
                      bsYear,
                      bsMonth,
                      displayedDay,
                    ).toDateTime();
                  } else {
                    dateTime = now.add(Duration(
                      days: displayedDay - bsFirstDayOfMonth,
                    ));
                  }

                  bool isEventDate = eventDates.contains(dateTime);
                  bool isEventDate2 = eventDates2.contains(dateTime);

                  String bsDate = displayedDay.toString();
                  String adDate = DateFormat.d().format(dateTime);

                  if (_isBsFormat) {
                    ///This is English Language
                    NepaliDateFormat nepaliDateFormat =
                        NepaliDateFormat("dd", Language.nepali);
                    String formattedBsDate = nepaliDateFormat.format(
                        picker.NepaliDateTime(bsYear, bsMonth, displayedDay));
                    return TableCell(
                      child: Container(
                        height: 35,
                        width: 60,
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Center(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  adDate,
                                  style: TextStyle(
                                    fontWeight: displayedDay == _currentDate.day
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  formattedBsDate,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    // Format Nepali date
                    NepaliDateFormat nepaliDateFormat =
                        NepaliDateFormat("dd", Language.nepali);
                    String formattedBsDate = nepaliDateFormat.format(
                        picker.NepaliDateTime(bsYear, bsMonth, displayedDay));

                    return TableCell(
                      child: Container(
                        height: 35,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          color: isEventDate
                              ? ThemeColors.lightGreen
                              : isEventDate2
                                  ? ThemeColors.lightRed
                                  : null,
                        ),
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Center(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  formattedBsDate,
                                  style: TextStyle(
                                    fontWeight: displayedDay == _currentDate.day
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  adDate,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }),
              ),
          ],
        ),
      ),
    );
  }

  Widget view(ThemeProvider? themeProvider) {
    return Expanded(
      child: SizedBox(
        height: 22,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'Default calender View',
                style: TextStyle(fontSize: 10),
              ),
            ),
            Radio(
              value: true,
              groupValue: _isBsFormat,
              activeColor: themeProvider?.tabColor,
              onChanged: (value) {
                setState(() {
                  _isBsFormat = value!;
                  _currentDate = _isBsFormat
                      ? picker.NepaliDateTime.now()
                      : picker.NepaliDateTime.fromDateTime(DateTime.now());
                });
              },
            ),
            const Text('BS', style: TextStyle(fontSize: 10)),
            Radio(
              value: false,
              groupValue: _isBsFormat,
              activeColor: themeProvider?.tabColor,
              onChanged: (value) {
                setState(() {
                  _isBsFormat = value!;
                  _currentDate = _isBsFormat
                      ? picker.NepaliDateTime.now()
                      : picker.NepaliDateTime.fromDateTime(DateTime.now());
                });
              },
            ),
            const Text('AD', style: TextStyle(fontSize: 10)),
            Text(
              _isBsFormat
                  ? '' //'${monthNames[_currentDate.month - 1]} ${yearBs}'
                  : '$monthNameAd $yearAd',
              style: TextStyles.smallBody(),
            ),
            const SizedBox(
              width: 6,
            ),
            const SizedBox(
              width: 4,
            ),
            const Icon(Icons.keyboard_arrow_down_sharp, size: 12),
            const SizedBox(
              width: 6,
            ),
            GestureDetector(
                onTap: _goToPreviousMonth,
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 16,
                )),
            const SizedBox(
              width: 6,
            ),
            GestureDetector(
                onTap: _refreshCalendar,
                child: const Icon(Icons.refresh, size: 16)),
            const SizedBox(
              width: 6,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                  onTap: _goToNextMonth,
                  child: const Icon(Icons.arrow_forward_ios_sharp, size: 16)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    today = picker.NepaliDateTime.now();
    final DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd').format(DateTime.now());
    String formattedWeekName = DateFormat('EEEE').format(DateTime.now());

    String month = DateFormat.MMMM().format(now); // Month name (e.g., January)
    String date = DateFormat.d().format(now); // Date (e.g., 14)
    String year = DateFormat.y().format(now); // Year (e.g., 2023)
    String time = DateFormat.jm().format(now); // Time (e.g., 9:37 AM)

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Container(
                height: 260,
                width: 120,
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        _isBsFormat
                            ? '$monthNameAd $yearAd'
                            : '${monthNames[_currentDate.month - 1]} ${yearBs}',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                        height: 87,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: themeProvider.whiteLiteContainerBackground,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 80,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  Text(
                                    _isBsFormat ? formattedDate : initialToday,
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: themeProvider.gradientTextColor),
                                  ),
                                  Text(
                                    _isBsFormat
                                        ? formattedWeekName
                                        : initialWeekName,
                                    style: TextStyles.smallBody(),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Image.asset(
                                      'assets/images/icon _sunrise_.png',color: themeProvider.iconColorWhiteAndBlack),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Text('6:29',
                                      style: TextStyle(fontSize: 8)),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Image.asset(
                                      'assets/images/sunset.png',color: themeProvider.iconColorWhiteAndBlack,),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Text('6:29',
                                      style: TextStyle(fontSize: 8)),
                                ],
                              ),
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 6,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '$month $date $year\n $time',
                        style: TextStyle(
                            fontSize: 13,
                            color: themeProvider.panchangBackground),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        height: 60,
                        width: 96,
                        decoration: BoxDecoration(
                          gradient: themeProvider.whiteLiteContainerBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 6),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/pngimg 1.png',
                                      height: 24, width: 24),
                                  Text(
                                    '   4500',
                                    style: TextStyles.smallBody(),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                      'assets/images/PngItem_6159570 1.png',
                                      height: 22,
                                      width: 22),
                                  Text(
                                    '    4500',
                                    style: TextStyles.smallBody(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              buildCalendarWidget(themeProvider),
            ],
          ),
          view(themeProvider),
        ],
      ),
    );
  }
}
