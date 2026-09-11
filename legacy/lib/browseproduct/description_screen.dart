import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class DescriptionScreen extends StatelessWidget {
  const DescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: themeProvider.tabBackground),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Pearl is a natural,white to somewhat blue dart shaded,valuable gemstone delivered inside the body of a living \ncreature  "Mollusc".',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 2,
                ),
                Text('Caret: 7 / 8 / 9',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Metal: Gold / Silver',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.grey),
                ),
                SizedBox(
                  height: 2,
                ),
                Text('Design: send us your design',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
