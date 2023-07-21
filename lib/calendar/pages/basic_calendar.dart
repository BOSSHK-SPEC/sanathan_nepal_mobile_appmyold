import 'package:flutter/material.dart';

import '../src/calendar.dart';
import '../src/utils/enum_type.dart';


class BasicCalendar extends StatefulWidget {
  const BasicCalendar({Key? key}) : super(key: key);

  @override
  State<BasicCalendar> createState() => _BasicCalendarState();
}

class _BasicCalendarState extends State<BasicCalendar> {
  late CalendarType _calendarType;
  DateTime? _selectedDate;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarType = CalendarType.ad;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Calendar'),
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
