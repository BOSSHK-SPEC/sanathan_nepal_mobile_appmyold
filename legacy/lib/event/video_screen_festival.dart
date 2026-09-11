import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';

class VideoScreenFestivals extends StatelessWidget {
  const VideoScreenFestivals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(child:Scaffold(
      body: Wrap(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft: Radius.circular(6)),
                  color:themeProvider.bookAppointmentBackground,
                ),
                height: 244,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                          ),
                        ),
                        child: Image.asset('assets/images/Rectangle 1059 (2).png',fit: BoxFit.cover,width: 344),
                      ),
                    )
                  ],
                )
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
