import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';

import '../src/calendar.dart';
import '../src/utils/enum_type.dart';

class DynamicCalendar extends StatefulWidget {
  const DynamicCalendar({Key? key}) : super(key: key);

  @override
  State<DynamicCalendar> createState() => _DynamicCalendarState();
}

class _DynamicCalendarState extends State<DynamicCalendar> {
  late CalendarType _calendarType;
  DateTime? _selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _calendarType = CalendarType.ad;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Calendar'),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (_calendarType == CalendarType.ad) {
                setState(() => _calendarType = CalendarType.bs);
              } else {
                setState(() => _calendarType = CalendarType.ad);
              }
            },
            child: Text(_calendarType == CalendarType.bs ? 'En' : 'ने'),
          ),
        ],
      ),
      body: FlutterBSADCalendar(
        initialDate: DateTime.now(),
        calendarType: _calendarType,
        firstDate: DateTime(1970),
        lastDate: DateTime(2024),
        onMonthChanged: (date, events) {
          setState(() {
            _selectedDate = date;
          });
        },
        onDateSelected: (date, events) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }
}
