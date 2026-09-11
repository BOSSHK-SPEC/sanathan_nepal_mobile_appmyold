import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';

class HowToCelebrateScreenfestivals extends StatelessWidget {
  const HowToCelebrateScreenfestivals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
        child: Scaffold(
      body: Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
          color: themeProvider.bookAppointmentBackground,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0, right: 8, left: 8),
          child: Column(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
               ),
                child:  Center(
                  child: Image.asset('assets/images/Rectangle 1059 (1).png')
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.circle,
                    size: 5,
                  ),
                  Text(
                      '  You can bathe and dress up miniature idols of Lord Ram and place them in a',
                      style: TextStyle(fontSize: 11)),
                ],
              ),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '      cradle to mark his birth',
                    style: TextStyle(fontSize: 11),
                  )),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.circle,
                    size: 5,
                  ),
                  Text('  You can light a lamp in front of the idol',
                      style: TextStyle(fontSize: 11)),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.circle,
                    size: 5,
                  ),
                  Text(
                      '  You can also celebrate this day by providing food to the needy.',
                      style: TextStyle(fontSize: 11)),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.circle,
                    size: 5,
                  ),
                  Text(
                      '  If you want to delve deep into this ritual, you can even invite nine girls at home,',
                      style: TextStyle(fontSize: 11)),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      '    shower them with respect and offer them prashad in the form of halwa and',
                      style: TextStyle(fontSize: 11))),
              const SizedBox(
                height: 4,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '    puri. This is popularly known as the Kanya Puja ritual, where girls are believed',
                    style: TextStyle(fontSize: 11),
                  )),
              const SizedBox(
                height: 4,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '    to be the manifestation of Indian Goddesses',
                    style: TextStyle(fontSize: 11),
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
