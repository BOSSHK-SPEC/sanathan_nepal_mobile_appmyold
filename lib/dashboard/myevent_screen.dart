import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/calendar/src/eventScreenCalendar.dart';
import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';
import 'package:sanathan_nepal_mobile_app/view/helper/colors.dart';
import 'package:sanathan_nepal_mobile_app/view/helper/styles.dart';
import 'package:sanathan_nepal_mobile_app/view/widgets/boarderdButton.dart';
import 'package:sanathan_nepal_mobile_app/view/widgets/gradienteElevatedButton.dart';

import '../calender/calender.dart';
import 'eventProvider.dart';


class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool showDropdown = false;
  late CustomCalendar customCalendar;
  // CustomCalendar customCalendar = CustomCalendar();
  late CustomCalendarState customCalendarState;
  late Widget calendar;
  late Widget view;
  ThemeProvider? themeProvider;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customCalendar  = CustomCalendar();
    customCalendarState  = customCalendar.createState();
    calendar=customCalendarState.buildCalendarWidget(themeProvider);
    view=customCalendarState.view(themeProvider);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Event',style: TextStyle(color: themeProvider.tabUnSelectedLabelColor)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Radio(
                    activeColor: themeProvider.tabColor,
                      value:  "create_event",
                      groupValue: eventProvider.selectedRadioValue,
                      onChanged: (value) {
                        //print(value);
                        eventProvider.setSelectedRadioValue(value as String?);//selected value
                      }),
                  const Text('create event'),
                  Radio(
                      activeColor: themeProvider.tabColor,

                      value: "event_todo",
                      groupValue: eventProvider.selectedRadioValue,
                      onChanged: (value) {
                        //print(value); //selected value
                        eventProvider.setSelectedRadioValue(value as String?);
                         //eventProvider.setEventMode(true, false);
                      }),
                  const Text('event to-do'),
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'title',
                  hintText: 'title',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  // Handle the value change
                  //print('Input value: $value');
                  eventProvider.setTitle(value);

                },
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Event Date',
                    style: TextStyles.body(),
                  )),
              Row(
                children: [
                  Radio(
                      activeColor: themeProvider.tabColor,

                      value:  'B.S',
                      groupValue:eventProvider.eventDateType,
                      onChanged: (value) {
                        //print(value); //selected value
                        eventProvider.setEventDateType(value!);
                      }),
                  const Text('B.S'),
                  Radio(
                      activeColor: themeProvider.tabColor,

                      value:  'A.D',
                      groupValue: eventProvider.eventDateType,
                      onChanged: (value) {
                        //print(value); //selected value
                        eventProvider.setEventDateType(value!);
                      }),
                  const Text('A.D'),
                  Radio(
                      value:  'Thithi',
                      activeColor: themeProvider.tabColor,
                      groupValue: eventProvider.eventDateType,
                      onChanged: (value) {
                        //print(value); //selected value
                        eventProvider.setEventDateType(value!);
                      }),
                  const Text('Thithi'),
                  const SizedBox(width: 5,),
                  SizedBox(
                    height: 28,
                    width: 138,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: '2079-12-02',
                        hintText: '2079-12-02',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        // Handle the value change
                        //print('Input value: $value');
                        eventProvider.setEventDate(value);
                      },
                    ),
                  ),
                ],
              ),
               SizedBox(
                  height: height*0.4,
                  width: double.infinity,
                  child: const FinalCalendar()),



              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Event Repeat',
                    style: TextStyles.body(),
                  )),
              Row(
                children: [
                  Radio(
                    value: true,
                    groupValue: showDropdown,
                    activeColor: themeProvider.tabColor,

                    onChanged: (value) {
                      setState(() {
                        showDropdown = value!;
                      });
                    },
                  ),
                  const Text('Yes'),
                  Radio(
                    value: false,
                    activeColor: themeProvider.tabColor,

                    groupValue: showDropdown,
                    onChanged: (value) {
                      setState(() {
                        showDropdown = value!;
                      });
                    },
                  ),
                  const Text('No'),
                  const Spacer(),
                  if (showDropdown) // Conditionally show the dropdown
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: eventProvider.dropdownValue,
                                onChanged: (value) {
                                  eventProvider.setDropdownValue(value!);
                                },
                                icon: null,
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Option 1',
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Option 1'),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Option 2',
                                    child: Text('Option 2'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Option 3',
                                    child: Text('Option 3'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(Icons.add),
                  Text(
                    'Add Description',
                    style: TextStyles.body(),
                  ),
                ],
              ),
              SizedBox(
                width: width, // <-- TextField width
                height: height * 0.1, // <-- TextField height
                child:  TextField(
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      filled: true, hintText: 'Enter a message'),
                  onChanged: (value) {
                    // Update the 'desc' value here
                    eventProvider.setDesc(value);
                  },
                ),

              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'To Do List',
                    style: TextStyles.body(),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'add new list item',
                    ),
                    const Spacer(),
                    Container(
                      height: 33,
                      width: 90,
                      decoration: BoxDecoration(
                        gradient: themeProvider.appointmentButtonColor
                      ),
                      child: Center(child: Text('Add',style: TextStyle(color: themeProvider.whiteTextColor),)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
                child: CheckboxListTile(
                  title: const Text('New List item'),
                  value: false,
                  onChanged: (newValue) {
                    // Handle checkbox state change
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: true,
                  contentPadding: const EdgeInsets.all(0.0),
                ),
              ),
              SizedBox(
                height: 30,
                child: CheckboxListTile(
                  title: Text(
                    'New list item (Hover) ',
                    style: TextStyles.smallBody(color: ThemeColors.purpleColor),
                  ),
                  value: false,
                  onChanged: (newValue) {
                    // Handle checkbox state change
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: true,
                  contentPadding: const EdgeInsets.all(0.0),
                ),
              ),
              SizedBox(
                height: 30,
                child: CheckboxListTile(
                  title: const Text('New List item(Done) '),
                  value: false,
                  onChanged: (newValue) {
                    // Handle checkbox state change
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: true,
                  contentPadding: const EdgeInsets.all(0.0),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Location',
                    style: TextStyles.body(),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Event location',
                  hintText: 'Event location',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  // Handle the value change
                  print('Input value: $value');
                  eventProvider.setLocation(value);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Remind me Before',
                    style: TextStyles.body(),
                  ),
                  SizedBox(
                    height: 30,
                    width: 80,
                    child: Center(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'days',
                          hintText: 'days',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          // Handle the value change
                          print('Input value: $value');
                          eventProvider.setRemindBeforeValue(value);
                        },
                      ),
                    ),
                  ),
                  Text(
                    'Days at',
                    style: TextStyles.body(),
                  ),
                  Container(
                    height: 30,
                    width: 80,
                    child: TextFormField(
                      decoration:  const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '12-00 AM',
                        suffix: Icon(
                          Icons.access_alarm_outlined,
                          size: 15,
                        ),

                      ),
                      onChanged: (value) {
                        // Handle the value change
                        //print('Input value: $value');
                        eventProvider.setRemindAtValue(value);
                      },
                    ),
                  ),

                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  /*BorderedButton(
                      onPressed: () {},
                      borderColor: ThemeColors.purpleColor,
                      textColor: ThemeColors.purpleColor,
                      width: 100,
                      height: 40,
                      text: 'cancel',),*/
                  Container(
                    height: 33,
                    width: 90,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.purple,
                        )
                    ),
                    child: Center(child: Text('cancel',style: TextStyle(color: themeProvider.whiteTextColor),)),
                  ),
                  const Spacer(),
                  GestureDetector(
                     onTap: (){
                       eventProvider.createEvent();

                     },
                    child: Container(
                      height: 33,
                      width: 90,
                      decoration: BoxDecoration(
                          gradient: themeProvider.appointmentButtonColor
                      ),
                      child: Center(child: Text('Create',style: TextStyle(color: themeProvider.whiteTextColor),)),
                    ),
                  )
                ],
              ),
              // ElevatedButton(onPressed: (){
              //   Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayScreen()));
              // }, child: Text('hi')),

            ],
          ),
        ),
      ),
    );
  }
}
class DisplayScreen extends StatelessWidget {
  const DisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Display'),
      ),
      body: Center(
        child:
        ListView.builder(
          itemCount: eventProvider.events.length,
          itemBuilder: (context, index) {
            Event event = eventProvider.events[index];
           // String selectedDropdownValue = eventProvider.dropdownValue;

            return Column(
              children: [
                Text(event.title),
                Text(event.selectedRadioValue ?? 'No value selected'),
                Text(event.eventDateType),
                Text(event.eventDate),
                Text( event.dropdownValue),
                Text( event.desc),
                Text( event.location),
                Text( event.remindBeforeValue),
                Text( event.remindAtValue),


                const Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
