/*
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart' show DateFormat, NepaliDateFormat, Language;

import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_date_picker/nepali_date_picker.dart';

import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:provider/provider.dart';

import '../../theme/theme_provider.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  picker.NepaliDateTime _currentDate = picker.NepaliDateTime.now();
  bool _isBsFormat = true;
  late picker.NepaliDateTime today;
  late picker.NepaliDateTime initialToday;
  String initialWeekName = '';
  List<String> monthNames = [];
  late String monthName;
  String monthNameAd = '';
  String yearAd = '';

  @override
  void initState() {
    super.initState();

    initialToday = picker.NepaliDateTime.now();
    today = picker.NepaliDateTime.now();

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
      String monthName = NepaliDateFormat('MMMM')
          .format(NepaliDateTime(_currentDate.year, month));
      names.add(monthName);
    }
    return names;
  }

  List<Map<String, dynamic>> _generateCalendarData() {
    final int bsYear = _currentDate.year;
    final int bsMonth = _currentDate.month;

    final int bsFirstDayOfMonth =
        picker.NepaliDateTime(bsYear, bsMonth).weekday;
    final int daysInMonth = _getDaysInNepaliMonth(bsYear, bsMonth);

    final List<Map<String, dynamic>> calendarData = [];

    int currentDayInMonth = 1;
    bool isCurrentMonth = false;

    for (int row = 0; row < 6; row++) {
      for (int column = 0; column < 7; column++) {
        final Map<String, dynamic> cellData = {};

        if (!isCurrentMonth && column >= bsFirstDayOfMonth) {
          isCurrentMonth = true;
        }

        if (isCurrentMonth && currentDayInMonth <= daysInMonth) {
          cellData['bsDate'] = currentDayInMonth.toString();
          DateTime adDateTime =
              picker.NepaliDateTime(bsYear, bsMonth, currentDayInMonth)
                  .toDateTime();
          cellData['adDate'] = DateFormat.d().format(adDateTime);

          currentDayInMonth++;
        }

        calendarData.add(cellData);
      }
    }

    return calendarData;
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
      case 1:
        return 'Sunday';
      case 2:
        return 'Monday';
      case 3:
        return 'Tuesday';
      case 4:
        return 'Wednesday';
      case 5:
        return 'Thursday';
      case 6:
        return 'Friday';
      case 7:
        return 'Saturday';
      default:
        return '';
    }
  }

  String _getNarrowWeekday(int weekday) {
    switch (weekday) {
      case 0:
        return 'S';
      case 1:
        return 'M';
      case 2:
        return 'T';
      case 3:
        return 'W';
      case 4:
        return 'T';
      case 5:
        return 'F';
      case 6:
        return 'S';
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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    today = picker.NepaliDateTime.now();
    final DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd').format(DateTime.now());
    String formattedWeekName = DateFormat('EEEE').format(DateTime.now());

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Container(
                height: 200,
                width: 160,
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      _isBsFormat
                          ? '${monthNames[_currentDate.month - 1]} $yearAd'
                          : '$monthNameAd $yearAd',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Material(
                      elevation: 22,
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: themeProvider.containerBackground,
                            borderRadius: BorderRadius.circular(6)),
                        height: 90,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 22.0,left: 8),
                              child: Column(
                                children: [
                                  Text(
                                    _isBsFormat
                                        ? '${initialToday.day}'
                                        : formattedDate,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    _isBsFormat
                                        ? initialWeekName
                                        : formattedWeekName,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: const [
                                  Icon(Icons.wb_sunny,size: 18),
                                  Text('6:30 AM'),
                                  Icon(Icons.nightlight_round,size: 18),
                                  Text('6:45 PM'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Material(
                      elevation: 22,
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: themeProvider.containerBackground,
                            borderRadius: BorderRadius.circular(6)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    'assets/images/pngimg 1.png',
                                    height: 30,
                                    width: 30,
                                  ),
                                  const Text('4500'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    'assets/images/PngItem_6159570 1.png',
                                    height: 30,
                                    width: 30,
                                  ),
                                  const Text('4500'),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 200,
                  width: 240,
                  child: Table(
                    children: [
                      TableRow(
                        children: List.generate(7, (index) {
                          final int weekday = (index + 1) % 7;
                          return TableCell(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  _isBsFormat
                                      ? _getNarrowWeekday(weekday)
                                      : DateFormat.E()
                                          .format(
                                              now.add(Duration(days: index)))
                                          .substring(0, 1),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
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

                            final int totalDays =
                                daysInMonth + bsFirstDayOfMonth - 1;

                            final int currentIndex = row * 7 + column;
                            final int currentDayInMonth =
                                currentIndex - bsFirstDayOfMonth + 2;

                            if (currentDayInMonth >= 1 &&
                                currentDayInMonth <= totalDays) {
                              DateTime dateTime = _isBsFormat
                                  ? picker.NepaliDateTime(
                                          bsYear, bsMonth, currentDayInMonth)
                                      .toDateTime()
                                  : now.add(Duration(
                                      days: currentDayInMonth -
                                          bsFirstDayOfMonth));

                              return TableCell(
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      _isBsFormat
                                          ? currentDayInMonth.toString()
                                          : DateFormat.d().format(dateTime),
                                      style: TextStyle(
                                        fontWeight: currentDayInMonth ==
                                                _currentDate.day
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return TableCell(
                                child: Container(),
                              );
                            }
                          }),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('View'),
              Radio(
                value: true,
                activeColor: themeProvider.tabColor,
                focusColor: themeProvider.tabColor,
                groupValue: _isBsFormat,
                onChanged: (value) {
                  setState(() {
                    _isBsFormat = value!;
                    _currentDate = _isBsFormat
                        ? picker.NepaliDateTime.now()
                        : picker.NepaliDateTime.fromDateTime(DateTime.now());
                  });
                },
              ),
              const Text('BS'),
              Radio(
                value: false,
                activeColor: themeProvider.tabColor,
                groupValue: _isBsFormat,
                onChanged: (value) {
                  setState(() {
                    _isBsFormat = value!;
                    _currentDate = _isBsFormat
                        ? picker.NepaliDateTime.now()
                        : picker.NepaliDateTime.fromDateTime(DateTime.now());
                  });
                },
              ),
              const Text('AD'),
              IconButton(
                onPressed: _goToPreviousMonth,
                icon: const Icon(Icons.arrow_back),
              ),
              IconButton(
                onPressed: _refreshCalendar,
                icon: const Icon(Icons.refresh),
              ),
              IconButton(
                onPressed: _goToNextMonth,
                icon: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
*/
