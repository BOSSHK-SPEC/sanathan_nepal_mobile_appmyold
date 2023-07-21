import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/calendar/src/model/event.dart';
import '../../theme/theme_provider.dart';
import '../calendar/pages/event_calendar.dart';
import '../calendar/src/calendar.dart';
import '../calendar/src/utils/enum_type.dart';
import 'event_bs_ad_calender.dart';




class EventCalender extends StatefulWidget {
  const EventCalender({Key? key}) : super(key: key);

  @override
  State<EventCalender> createState() => EventCalenderState();
}

class EventCalenderState extends State<EventCalender> {
  late CalendarType _calendarType;
  late List<DateTime> _holidays;
  DateTime? _selectedDate;
  late List<Event> _events;
  List<Event>? _selectedDateEvents;
  late List<Event2> _events2;


  @override
  void initState() {
    super.initState();
    _calendarType = CalendarType.bs;
    _holidays = [
      DateTime(2023, 04, 15),
      DateTime(2023, 05, 02),
      DateTime(2023, 05, 13),
      DateTime(2023, 05, 27),
      DateTime(2023, 05, 29),
      DateTime(2023, 07, 22),
      DateTime(2023, 08, 20),
      DateTime(2023, 08, 21),
      DateTime(2023, 08, 19),
      DateTime(2023, 09, 09),
      DateTime(2023, 09, 18),
      DateTime(2023, 09, 27),

    ];
    _events = _getEvents();
    _events2 = _getEvents2();
  }
  List<Event> _getEvents() {
    return [
      Event(
        date: DateTime(2023, 04, 14),
        event: Content(title: 'Event'),
      ),
      Event(
        date: DateTime(2023, 04, 16),
        event: Content(title: 'Event 01'),
      ),
      Event(
        date: DateTime(2023, 05, 01),
        event: Content(title: 'Event 02'),
      ),
      Event(
        date: DateTime(2023, 05, 14),
        event: Content(title: 'Event 03'),
      ),
      Event(
        date: DateTime(2023, 05, 26),
        event: Content(title: 'Event 04'),
      ),
      Event(
        date: DateTime(2023, 05, 29),
        event: Content(title: 'Event 05'),
      ),
      Event(
        date: DateTime(2023, 07, 21),
        event: Content(title: 'Event 06'),
      ),
      Event(
        date: DateTime(2023, 08, 22),
        event: Content(title: 'Event 07'),
      ),
      Event(
        date: DateTime(2023, 08, 23),
        event: Content(title: 'Event 08'),
      ),
      Event(
        date: DateTime(2023, 08, 30),
        event: Content(title: 'Event 09'),
      ),
    ];
  }
  List<Event2> _getEvents2() {
    return [
      Event2(
        date: DateTime(2023, 04, 13),
        event: Content(title: 'Event'),
      ),
      Event2(
        date: DateTime(2023, 04, 12),
        event: Content(title: 'Event 01'),
      ),
      Event2(
        date: DateTime(2023, 05, 03),
        event: Content(title: 'Event 02'),
      ),
      Event2(
        date: DateTime(2023, 05, 15),
        event: Content(title: 'Event 03'),
      ),
      Event2(
        date: DateTime(2023, 05, 27),
        event: Content(title: 'Event 04'),
      ),
      Event2(
        date: DateTime(2023, 05, 29),
        event: Content(title: 'Event 05'),
      ),
      Event2(
        date: DateTime(2023, 07, 27),
        event: Content(title: 'Event 06'),
      ),
      Event2(
        date: DateTime(2023, 08, 23),
        event: Content(title: 'Event 07'),
      ),
      Event2(
        date: DateTime(2023, 08, 25),
        event: Content(title: 'Event 08'),
      ),
      Event2(
        date: DateTime(2023, 08, 27),
        event: Content(title: 'Event 09'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              EventBSADCalender(
                calendarType: _calendarType,
                initialDate: DateTime.now(),
                firstDate: DateTime(1970),
                lastDate: DateTime(2024),
                mondayWeek: false, // true is for Monday, false is  for Sunday
                weekendDays: const [
                  DateTime.saturday,
                ],
                holidays: _holidays,
                primaryColor: themeProvider.tabUnSelectedLabelColor,
                // weekColor: Colors.black,
                eventColor: themeProvider.eventcolor,
                events: _events,
                events2: _events2,
                event2Color: themeProvider.event2color,
                holidayColor: themeProvider.tabColor,
                todayDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  color: themeProvider.selectedtodaycolor,
                  shape: BoxShape.rectangle,
                ),
                selectedDayDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  color: themeProvider.todayColor,
                  shape: BoxShape.rectangle,
                ),
                onMonthChanged: (date, events) {
                  setState(() {
                    _selectedDate = date;
                    _selectedDateEvents = events;
                  });
                },
                onDateSelected: (date, events) {
                  setState(() {
                    _selectedDate = date;
                    _selectedDateEvents = events;
                  });
                },
              ),
              Positioned(
                top:  MediaQuery.of(context).size.height*0.32,
                left: MediaQuery.of(context).size.width*0.01,
                bottom: 0,
                child: SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'deafult calender view',
                        style: TextStyle(fontSize: 10),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'BS',
                        style: TextStyle(fontSize: 10),
                      ),

                      Radio<CalendarType>(
                        activeColor: themeProvider.tabColor,
                        value: CalendarType.bs,
                        groupValue: _calendarType,
                        onChanged: (value) {
                          setState(() => _calendarType = value!);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      const Text(
                        'AD',
                        style: TextStyle(fontSize: 10),
                      ),
                      Radio<CalendarType>(
                        activeColor: themeProvider.tabColor,
                        value: CalendarType.ad,
                        groupValue: _calendarType,
                        onChanged: (value) {
                          setState(() => _calendarType = value!);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}