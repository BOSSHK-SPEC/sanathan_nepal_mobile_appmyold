import 'package:flutter/foundation.dart';

class EventProvider with ChangeNotifier {
  String title = '';
  String? selectedRadioValue;
  bool isCreateEvent = true;
  bool isEventToDo = false;
  String eventDateType = '';
  String eventDate = '';
  bool showDropdown = false;
  String dropdownValue = 'Option 1';
  String description = '';
  String location = '';
  String remindBeforeValue = '';
  String remindAtValue = '';
  List<Event> events = [];
  String desc = '';

  void setTitle(String value) {
    title = value;
    notifyListeners();
  }

  void setDesc(String value) {
    desc = value;
    notifyListeners();
  }

  void setEventMode(bool isCreate, bool isToDo) {
    isCreateEvent = isCreate;
    isEventToDo = isToDo;
    notifyListeners();
  }

  void setEventDateType(String value) {
    eventDateType = value;
    notifyListeners();
  }

  void setEventDate(String value) {
    eventDate = value;
    notifyListeners();
  }

  void setShowDropdown(bool value) {
    showDropdown = value;
    notifyListeners();
  }

  void setDropdownValue(String value) {
    dropdownValue = value;
    notifyListeners();
  }

  void setDescription(String value) {
    description = value;
    notifyListeners();
  }

  void setLocation(String value) {
    location = value;
    notifyListeners();
  }

  void setRemindBeforeValue(String value) {
    remindBeforeValue = value;
    notifyListeners();
  }

  void setRemindAtValue(String value) {
    remindAtValue = value;
    notifyListeners();
  }

  void setSelectedRadioValue(String? value) {
    selectedRadioValue = value;
    notifyListeners();
  }

  void createEvent() {
    Event newEvent = Event(
        title: title,
        date: eventDate,
        selectedRadioValue: selectedRadioValue,
        eventDateType: eventDateType,
        eventDate: eventDate,
        dropdownValue: dropdownValue,
        desc: desc,
        location: location,
        remindAtValue: remindAtValue,
        remindBeforeValue: remindBeforeValue);
    events.add(newEvent);
    notifyListeners();
  }
}

class Event {
  String title;
  String date;
  String? selectedRadioValue;
  String eventDateType;
  String eventDate;
  String dropdownValue;
  String desc;
  String location;
  String remindAtValue;
  String remindBeforeValue;

  Event({
    required this.dropdownValue,
    required this.title,
    required this.date,
    required this.selectedRadioValue,
    required this.eventDateType,
    required this.eventDate,
    required this.desc,
    required this.location,
    required this.remindAtValue,
    required this.remindBeforeValue,
  });
}
