import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class BookAppoinContentScreen extends StatelessWidget {
  const BookAppoinContentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: themeProvider.bookAppointmentBackground,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6))),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.email,
                            size: 18,
                            color: themeProvider.bottomNavigationIconColor),
                        const Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Text('vaastulochan@gmail.com',
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 33.0),
                      child: Container(
                        height: 29,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: themeProvider.bookAppointmentBackground,
                            border: Border.all(
                                width: 1, color: themeProvider.bottomNavigationIconColor!),
                            borderRadius: BorderRadius.circular(6)),
                        child: Row(
                          children: [
                            Icon(Icons.call,
                                size: 18,
                                color: themeProvider.bottomNavigationIconColor),
                            const Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: Text(
                                  '+977-9851086213,+977-9851071080,01-5241133',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Center(
                            child: Icon(Icons.location_on,
                                size: 18,
                                color:
                                    themeProvider.bottomNavigationIconColor)),
                        const Text('Pashupati,Kailash Parking Kathmandu,Nepal',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Your name'),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Your email'),
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Your message'),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 140,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: themeProvider.luckyDetail),
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 14.0),
                                child: Icon(Icons.send, size: 20),
                              ),
                              Text('  Send Message')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
