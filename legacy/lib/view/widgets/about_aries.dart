import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_provider.dart';

class AboutAries extends StatelessWidget {
  const AboutAries({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ListView(
      children: [
        SizedBox(
          height: 8,
        ),
        const Text(
          'An Aries mans day start even before the dawn with lots of new things to explore. He is a man filled with amazing leadership quantities, charisma.,magnetism and energy. An Aries mans resembles extreme natural force, impulsive and stubborn strength to take up the whole universe in his hand and win in his own style.',),
        SizedBox(height: 8,),

        Column(
          children: [
            Row(
              children: [
                Text('Money : ',
                    style: TextStyle(
                        color: themeProvider.horosCopColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
                Text('Aries born man are caution and intuitive in their')
              ],
            ),
            Text('investment More than money, he is more concerned about his independence and freedom.')
          ],
        ),
        SizedBox(height: 8,),
        Column(
          children: [
            Row(
              children: [
                Text(
                  'Health : ',
                  style: TextStyle(
                      color: themeProvider.horosCopColor, fontWeight: FontWeight.bold,fontSize: 13),
                ),
                Text('With exercise and healthy diet he keeps up his')
              ],
            ),
          ],
        ),
        const Text(
            'high energy alive. However sinus head congestion and migraines are few commonly occurring health issues.'),
        SizedBox(height: 8,),

        Column(
          children: [
            Row(
              children: [
                Text(
                  'Career : ',
                  style: TextStyle(
                      color: themeProvider.horosCopColor, fontWeight: FontWeight.bold,fontSize: 13),
                ),
                Text('As inborn leader, they love to handle new'),
              ],
            ),
          ],
        ),
        const Text(
            ' new project and always hate doing repetitive things. They can be traced as athlete, stock broker, lawyer, dentist or doctor.'),
        SizedBox(height: 8,),

        Column(
          children: [
            Row(
              children: [
                Text(
                  'Relationship : ',
                  style: TextStyle(
                      color: themeProvider.horosCopColor, fontWeight: FontWeight.bold,fontSize: 13),
                ),
                Text('Aries man enjoy the process of meeting')
              ],
            ),
          ],
        ),
        const Text(
            'new people and getting close to them. Aries man will be ready to shower advice but not really interested in receiving them.'),
      ],
    );
  }
}
