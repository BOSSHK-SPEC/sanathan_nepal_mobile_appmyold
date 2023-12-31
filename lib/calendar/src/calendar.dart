import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/calendar/pages/feature_calendar.dart';
import 'package:sanathan_nepal_mobile_app/calendar/src/model/event.dart';
import 'package:sanathan_nepal_mobile_app/calendar/src/utils/calendar_utils.dart';
import 'package:sanathan_nepal_mobile_app/calendar/src/utils/enum_type.dart';
import 'package:sanathan_nepal_mobile_app/calendar/src/utils/utils.dart';
import 'package:sanathan_nepal_mobile_app/calendar/src/widgets/day_buider.dart';
import 'package:sanathan_nepal_mobile_app/calendar/src/widgets/month_name.dart';
import 'package:sanathan_nepal_mobile_app/calendar/src/widgets/nepali_year_picker.dart';

import '../../theme/theme_provider.dart';

const Duration _monthScrollDuration = Duration(milliseconds: 200);

typedef OnSelectedDate<T> = Function(T selectedDate, List<Event>? events);
typedef OnMonthChanged<T> = Function(T selectedDate, List<Event>? events);

class FlutterBSADCalendar<T> extends StatefulWidget {
  FlutterBSADCalendar({
    super.key,
    this.calendarType = CalendarType.bs,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    this.holidays,
    this.mondayWeek = false,
    this.weekendDays = const [DateTime.saturday],
    this.events,
    this.events2,

    this.primaryColor,
    this.weekColor,
    this.holidayColor,
    this.eventColor,
    this.event2Color,
    this.todayDecoration,
    this.selectedDayDecoration,
    this.dayBuilder,
    required this.onDateSelected,
    this.onMonthChanged,
  })  : initialDate = DateUtils.dateOnly(initialDate),
        firstDate = DateUtils.dateOnly(firstDate),
        lastDate = DateUtils.dateOnly(lastDate) {
    assert(
      !this.lastDate.isBefore(this.firstDate),
      'lastDate ${this.lastDate} must be on or after firstDate ${this.firstDate}.',
    );
    assert(
      !this.initialDate.isBefore(this.firstDate),
      'initialDate ${this.initialDate} must be on or after firstDate ${this.firstDate}.',
    );
    assert(
      !this.initialDate.isAfter(this.lastDate),
      'initialDate ${this.initialDate} must be on or before lastDate ${this.lastDate}.',
    );
  }

  /// The [CalendarType] displayed in the calendar.
  final CalendarType calendarType;

  /// The initially selected [DateTime] that the picker should display.
  final DateTime initialDate;

  /// The earliest date the user is permitted to pick [lastDate].
  final DateTime firstDate;

  /// The latest date the user is permitted to pick [firstDate].
  final DateTime lastDate;

  /// The List of holiday dates.
  final List<DateTime>? holidays;

  /// List of events assigned to a specified day.
  final List<Event>? events;

  final List<Event2>? events2;

  /// Weather Start of the week is [Sunday] or [Monday].
  final bool mondayWeek;

  /// List of days in week to be considered as weekend.
  /// Use built-in [DateTime] weekday constants (e.g '1' is for 'DateTime.monday')
  final List<int> weekendDays;

  /// Primary calendar theme color
  final Color? primaryColor;

  /// Week name color
  final Color? weekColor;

  /// Holiday calendar theme color
  final Color? holidayColor;

  /// Event calendar theme color
  final Color? eventColor;
  final Color? event2Color;

  /// Decoration for today's cell.
  final BoxDecoration? todayDecoration;

  /// Decoration for selected day's cell.
  final BoxDecoration? selectedDayDecoration;

  /// Builds the widget for particular day.
  final Widget Function(DateTime)? dayBuilder;

  /// Called when the user picks a day.
  final OnSelectedDate onDateSelected;

  /// Called when the user changes month.
  final OnMonthChanged? onMonthChanged;

  @override
  State<FlutterBSADCalendar> createState() => FlutterBSADCalendarState();
}

class FlutterBSADCalendarState extends State<FlutterBSADCalendar> {
  final GlobalKey<FlutterBSADCalendarState> calendarKey =
      GlobalKey<FlutterBSADCalendarState>();

  late CalendarType _calendarType;
  late PageController _pageController;
  late List<DateTime> _daysInMonth;
  late DateTime _selectedDate;
  late DateTime _focusedDate;
  late int _currentMonthIndex;
  late DatePickerMode _displayType;

  late Map<int, List<int>> _nepaliMonthDays;

  @override
  void initState() {
    super.initState();
    _calendarType = CalendarType.bs;

    NepaliUtils(Language.nepali);
    _displayType = DatePickerMode.day;
    _daysInMonth = [];
    _selectedDate = DateTime.now();
    _focusedDate = widget.initialDate;
    _nepaliMonthDays = initializeDaysInMonths();
    _currentMonthIndex = widget.initialDate.month - 1;
    _pageController = PageController(initialPage: _currentMonthIndex);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.animateToPage(
        DateTime.now().month - 1,
        duration: _monthScrollDuration,
        curve: Curves.easeInOut,
      );
    });
  }

  /// Get the days in the month in english calendar
  List<DateTime> _englishDaysInMonth(DateTime date) {
    final first = Utils.firstDayOfMonth(date);
    final daysBefore =
        (widget.mondayWeek ? first.weekday - 1 : first.weekday) % 7;
    final firstToDisplay = first.subtract(Duration(days: daysBefore));
    final last = Utils.lastDayOfMonth(date);
    var daysAfter = 7 - (widget.mondayWeek ? last.weekday - 1 : last.weekday);
    if (daysAfter == 0) {
      daysAfter = 7;
    }

    final lastToDisplay = last.add(Duration(days: daysAfter));
    return Utils.daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  /// Get the days in the month in nepali calendar
  List<DateTime> _nepaliDaysInMonth(DateTime date) {
    NepaliDateTime nepalitDate = date.toNepaliDateTime();
    DateTime first =
        NepaliDateTime(nepalitDate.year, nepalitDate.month, 1).toDateTime();
    DateTime last = NepaliDateTime(nepalitDate.year, nepalitDate.month,
            _nepaliMonthDays[nepalitDate.year]![nepalitDate.month])
        .toDateTime();
    final daysBefore =
        (widget.mondayWeek ? first.weekday - 1 : first.weekday) % 7;
    final firstToDisplay = first.subtract(Duration(days: daysBefore));

    var daysAfter = 7 - (widget.mondayWeek ? last.weekday - 1 : last.weekday);
    if (daysAfter == 0) {
      daysAfter = 7;
    }

    final lastToDisplay = last.add(Duration(days: daysAfter));
    return Utils.daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  void _handleDisplayTypeChanged() {
    setState(() {
      _displayType = _displayType == DatePickerMode.day
          ? DatePickerMode.year
          : DatePickerMode.day;
    });
  }

  // callend on page changed
  void _handleMonthPageChanged(int monthPage) {
    if (monthPage > _currentMonthIndex) {
      int year =
          _focusedDate.month == 12 ? _focusedDate.year + 1 : _focusedDate.year;
      int month = _focusedDate.month == 12 ? 1 : _focusedDate.month + 1;
      _focusedDate = DateTime(year, month, _focusedDate.day);
      _currentMonthIndex = monthPage == 12 ? 0 : monthPage;
    } else {
      int year =
          _focusedDate.month == 1 ? _focusedDate.year - 1 : _focusedDate.year;
      int month = _focusedDate.month == 1 ? 12 : _focusedDate.month - 1;
      _focusedDate = DateTime(year, month, _focusedDate.day);
      _currentMonthIndex = monthPage == 0 ? 12 : monthPage;
    }
    _handleMonthChanged(_focusedDate);
    setState(() {});
  }

  // on year changed
  void _handleYearChanged(DateTime value) {
    if (value.isBefore(widget.firstDate)) {
      value = widget.firstDate;
    } else if (value.isAfter(widget.lastDate)) {
      value = widget.lastDate;
    }
    _displayType = DatePickerMode.day;
    _focusedDate = value;
    _selectedDate = value;
    _handleMonthChanged(value);
    setState(() {});
  }

  // on month changed
  void _handleMonthChanged(DateTime currentDate) {
    if (_focusedDate.year != currentDate.year ||
        _focusedDate.month != currentDate.month) {
      var date = widget.calendarType == CalendarType.ad
          ? currentDate
          : currentDate.toNepaliDateTime();
      List<Event>? monthsEvents = widget.events
          ?.where((item) => item.date?.month == currentDate.month)
          .toList();
      widget.onMonthChanged?.call(date, monthsEvents);
    }
  }

  // on date selected
  void _handleDateSelected(DateTime currentDate) {
    var date = widget.calendarType == CalendarType.ad
        ? currentDate
        : currentDate.toNepaliDateTime();

    List<Event>? todaysEvents = widget.events
        ?.where((item) => item.date?.difference(currentDate).inDays == 0)
        .toList();
    _selectedDate = currentDate;
    widget.onDateSelected.call(date, todaysEvents);
    setState(() {});
  }

  // check if event exist in the selected date
  bool _checkEventOnDate(DateTime day) {
    if (widget.events != null) {
      for (Event event in widget.events!) {
        if (event.date?.difference(day).inDays == 0) {
          if (widget.calendarType == CalendarType.ad &&
              day.month == _focusedDate.month) {
            return true;
          } else if (widget.calendarType == CalendarType.bs &&
              day.toNepaliDateTime().month ==
                  _focusedDate.toNepaliDateTime().month) {
            return true;
          }
        }
      }
    }
    return false;
  }
  bool _checkEvent2OnDate(DateTime day) {
    if (widget.events2 != null) {
      for (Event2 event2 in widget.events2!) {
        if (event2.date?.difference(day).inDays == 0) {
          if (widget.calendarType == CalendarType.ad &&
              day.month == _focusedDate.month) {
            return true;
          } else if (widget.calendarType == CalendarType.bs &&
              day.toNepaliDateTime().month ==
                  _focusedDate.toNepaliDateTime().month) {
            return true;
          }
        }
      }
    }
    return false;
  }

  Widget buildWeekRow(BuildContext context, int index) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    _daysInMonth = widget.calendarType == CalendarType.bs
        ? _nepaliDaysInMonth(_focusedDate)
        : _englishDaysInMonth(_focusedDate);

    List weeks = [];
    if (widget.mondayWeek) {
      weeks = widget.calendarType == CalendarType.bs
          ? Utils.nepaliMondayWeek
          : Utils.englishMondayWeek;
    } else {
      weeks = widget.calendarType == CalendarType.bs
          ? Utils.nepaliWeek
          : Utils.englishWeek;
    }

    return Column(
      children: [
        Table(
          border: TableBorder.all(
              color: themeProvider.tabUnSelectedLabelColor ?? Colors.black,
              width: 0.3),
          children: <TableRow>[
            TableRow(
              children: weeks
                  .map(
                    (day) => Center(
                      child: Text(
                        day,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: widget.weekColor ??
                                Theme.of(context).textTheme.titleSmall?.color),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.all(
              color: themeProvider.tabUnSelectedLabelColor ?? Colors.black,
              width: 0.3),
          children: List<TableRow>.generate(
            _daysInMonth.length ~/ 7,
            (rowIndex) {
              int startIndex = rowIndex * 7;
              int endIndex = startIndex + 7;
              return TableRow(
                children: List<Widget>.generate(
                  7,
                  (columnIndex) {
                    int dayIndex = startIndex + columnIndex;
                    if (dayIndex < _daysInMonth.length) {
                      DateTime dayToBuild = _daysInMonth[dayIndex];
                      Color? mainDayColor;
                      Color? secondaryDayColor =
                          Theme.of(context).textTheme.bodyMedium?.color;
                      BoxDecoration decoration = const BoxDecoration();

                      if (Utils.isSameDay(dayToBuild, _selectedDate) &&
                          Utils.isSameMonth(
                              widget.calendarType, _focusedDate, dayToBuild)) {
                        mainDayColor = Colors.white;
                        decoration = widget.selectedDayDecoration ??
                            BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              border: Border.all(
                                color: Theme.of(context).dividerColor,
                              ),
                              shape: BoxShape.circle,
                            );
                      } else if (Utils.isToday(dayToBuild)) {
                        mainDayColor = Theme.of(context).primaryColorDark;
                        decoration = widget.todayDecoration ??
                            BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              shape: BoxShape.circle,
                            );
                      } else if (!Utils.isSameMonth(
                          widget.calendarType, _focusedDate, dayToBuild)) {
                        mainDayColor = Colors.grey.withOpacity(0.5);
                        secondaryDayColor = Colors.grey.withOpacity(0.5);
                      } else if (Utils.isWeekend(dayToBuild,
                          weekendDays: widget.weekendDays)) {
                        mainDayColor = widget.holidayColor ??
                            Theme.of(context).colorScheme.secondary;
                      } else if (Utils.holidays(dayToBuild, widget.holidays)) {
                        mainDayColor = widget.holidayColor ??
                            Theme.of(context).colorScheme.secondary;
                      } else {
                        mainDayColor =
                            Theme.of(context).textTheme.bodyMedium?.color;
                      }

                      return GestureDetector(
                        onTap: () {
                          if (Utils.isSameMonth(
                              widget.calendarType, _focusedDate, dayToBuild)) {
                            _handleDateSelected(dayToBuild);
                          }
                        },
                        child: Container(
                          height: 35,
                          decoration: decoration,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 3.0,
                            vertical: 2.0,
                          ),
                          child: Stack(
                            children: [
                              Container(
                                color: _checkEventOnDate(dayToBuild)
                                    ? widget.eventColor ??
                                        Theme.of(context).colorScheme.secondary
                                    : (_checkEvent2OnDate(dayToBuild)
                                    ? themeProvider.bottomNavigationIconColor
                                    : Colors.transparent),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Visibility(
                                    visible: _checkEventOnDate(dayToBuild),
                                    child: Container(
                                      width: 5.0,
                                      height: 20.0,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 10.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: widget.eventColor ??
                                            Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(1000.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              widget.dayBuilder == null
                                  ? DayBuilder(
                                      dayToBuild: dayToBuild,
                                      calendarType: widget.calendarType,
                                      dayColor: mainDayColor,
                                      secondaryDayColor: secondaryDayColor,
                                    )
                                  : widget.dayBuilder!(dayToBuild),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container(); // Empty container for remaining cells
                    }
                  },
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildYearPicker() {
    switch (widget.calendarType) {
      case CalendarType.ad:
        return YearPicker(
          currentDate: _selectedDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          initialDate: _focusedDate,
          selectedDate: _selectedDate,
          onChanged: _handleYearChanged,
        );
      case CalendarType.bs:
        return NepaliYearPicker(
          currentDate: _selectedDate.toNepaliDateTime(),
          firstDate: widget.firstDate.toNepaliDateTime(),
          lastDate: widget.lastDate.toNepaliDateTime(),
          initialDate: _focusedDate.toNepaliDateTime(),
          selectedDate: _selectedDate.toNepaliDateTime(),
          onChanged: (date) => _handleYearChanged(date.toDateTime()),
        );
    }
  }

  void _refreshCalendar() {
    setState(() {
      _focusedDate = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // today = picker.NepaliDateTime.now();
    final DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd').format(DateTime.now());
    String formattedWeekName = DateFormat('EEEE').format(DateTime.now());

    String month = DateFormat.MMMM().format(now); // Month name (e.g., January)
    String date = DateFormat.d().format(now); // Date (e.g., 14)
    String year = DateFormat.y().format(now); // Year (e.g., 2023)
    String time = DateFormat.jm().format(now);
    final currentDate = DateTime.now();
    final weekName = NepaliDateFormat.EEEE().format(NepaliDateTime.now());
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _displayType == DatePickerMode.day
            ? SizedBox(
                height: MediaQuery.of(context).size.height * 0.32,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                            child: MonthName(
                              date: _focusedDate,
                              primaryColor: widget.primaryColor,
                              calendarType: widget.calendarType,
                            ),
                          ),
                          DateAndWeekname(
                            date: _focusedDate,
                            calendarType: widget.calendarType,
                            primaryColor: widget.primaryColor,
                          ),
                          SizedBox(height: 8,),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              '$month $date $year\n $time',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold,color:Colors.grey),
                            ),
                          ),
                          SizedBox(height: 8,),

                          Card(
                            color: Colors.transparent,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              height: 40,
                              width: 89,
                              decoration: BoxDecoration(
                                gradient: themeProvider.gradient2,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: Image.asset(
                                                'assets/images/pngimg 1.png')),
                                        const Text(
                                          ' रू 101,000',
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: Image.asset(
                                                'assets/images/PngItem_6159570 1.png')),
                                        const Text(
                                          ' रू 1,220',
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
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
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: DateUtils.monthDelta(
                                widget.firstDate, widget.lastDate) +
                            1,
                        itemBuilder: buildWeekRow,
                        onPageChanged: _handleMonthPageChanged,
                      ),
                    ),
                  ],
                ),
              )
            : Expanded(
                child: _buildYearPicker(),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              // onTap: _handleDisplayTypeChanged,
              child: MonthName(
                date: _focusedDate,
                primaryColor: widget.primaryColor,
                calendarType: widget.calendarType,
              ),
            ),
            Visibility(
              visible: _displayType == DatePickerMode.day,
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                    child: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        size: 25.0,
                        color: widget.primaryColor ??
                            Theme.of(context).primaryColor,
                      ),
                      onPressed: () => Utils.isDisplayingFirstMonth(
                              widget.firstDate, _selectedDate)
                          ? null
                          : _handleMonthPageChanged(_currentMonthIndex - 1),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    child: IconButton(
                      icon: const Icon(
                        Icons.refresh,
                        size: 25,
                      ),
                      onPressed: _refreshCalendar,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    child: IconButton(
                      icon: Icon(
                        Icons.chevron_right,
                        size: 25.0,
                        color: widget.primaryColor ??
                            Theme.of(context).primaryColor,
                      ),
                      onPressed: () => Utils.isDisplayingLastMonth(
                              widget.lastDate, _selectedDate)
                          ? null
                          : _handleMonthPageChanged(_currentMonthIndex + 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
