import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';

class BookAppoinAboutScreen extends StatelessWidget {
  const BookAppoinAboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(6),
                bottomLeft: Radius.circular(6)),
            color: themeProvider.bookAppointmentBackground,
          ),
          height: 128,
          child: Stack(
            children: [
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 5.0,
                        ),
                        child: Text('Renowed Astrogy & Vaastu Expert in Nepal',
                            style: TextStyle(fontSize: 13)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.language_sharp,
                                size: 14,
                                color: themeProvider.bookAppointmentIconColors),
                            const Text(' www.sarvajyotish.com',
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Row(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.call,
                                        size: 14,
                                        color: themeProvider
                                            .bookAppointmentIconColors),
                                    const Text(
                                        ' +977-985-107-1080,+977-985-107-1080  ',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Image.asset('assets/images/whatapp_icon.png')
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Row(
                          children: [
                            Icon(Icons.email,
                                size: 14,
                                color: themeProvider.bookAppointmentIconColors),
                            const Text(' vaastulochan@gmail.com',
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Row(
                          children: [
                            Icon(Icons.location_on,
                                size: 14,
                                color: themeProvider.bookAppointmentIconColors),
                            const Text(
                                ' Pashupatinath ,Kailash Paking \nKathmandu,Nepal',
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 34,
                right: 8,
                child: SizedBox(
                    width: 149,
                    height: 90,
                    child: Image.asset(
                        'assets/images/lochan astrology google map 2.png')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
