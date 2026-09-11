import 'package:flutter/foundation.dart';

class FlutterBSADCalendarState extends ChangeNotifier {
  late DateTime _selectedDate;
  late List<DateTime> _markedDates;

  FlutterBSADCalendarState() {
    _selectedDate = DateTime.now();
    _markedDates = [];
  }

  DateTime get selectedDate => _selectedDate;

  List<DateTime> get markedDates => _markedDates;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void markDate(DateTime date) {
    if (!_markedDates.contains(date)) {
      _markedDates.add(date);
      notifyListeners();
    }
  }

  void unmarkDate(DateTime date) {
    if (_markedDates.contains(date)) {
      _markedDates.remove(date);
      notifyListeners();
    }
  }
}
