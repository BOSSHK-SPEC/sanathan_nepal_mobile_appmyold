import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/bookappointment/book_appointment_screen.dart';

import '../theme/theme_provider.dart';

class MyAppointmentScreen extends StatefulWidget {
  const MyAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<MyAppointmentScreen> createState() => _MyAppoinmentScreenState();
}

class _MyAppoinmentScreenState extends State<MyAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: themeProvider.whiteLiteContainerBackground,
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(6),
                  bottomLeft: Radius.circular(6))),
          height: 164,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("you don't have an ongoing orders at this time.",
                    style: TextStyle(fontSize: 13)),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const BookAppointmentScreen()));
                },
                child: Container(
                  height: 33,
                  width: 199,
                  decoration: BoxDecoration(
                      gradient: themeProvider.appointmentButtonColor,
                      borderRadius: BorderRadius.circular(33)),
                  child:  Center(
                      child: Text(
                    "Book Your Appointment Now!",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,color: themeProvider.whiteTextColor),
                  )),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8, top: 8),
                child: Divider(),
              ),
              SizedBox(
                height: 44,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text('CHEENA READING APPOINTMENT',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 8),
                          child: Text('Chaitra 16,2076 | 30 Mar,2023,Wednesday',
                              style: TextStyle(
                                  color: themeProvider.horosCopColor, fontSize: 10)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 94.0),
                      child: Container(
                        width: 55,
                        height: 45,
                        decoration: BoxDecoration(
                            gradient: themeProvider.gradient2,
                            borderRadius: BorderRadius.circular(6)),
                        child: Column(
                          children: const [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 8.0, right: 8, top: 4),
                              child:
                                  Text('8:30', style: TextStyle(fontSize: 15)),
                            ),
                            Text('PM'),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'You have Cheena Reading Appointment with Dr.Uttam Upadhyaya.',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
