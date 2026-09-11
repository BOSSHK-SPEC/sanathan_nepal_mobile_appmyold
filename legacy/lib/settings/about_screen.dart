import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';
import '../enum/enum.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  Language language = Language.English;
  Themes themes = Themes.Dark;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: themeProvider.whiteLiteContainerBackground,
                        borderRadius: BorderRadius.circular(6)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Text("Gender: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text("Female"),
                                ],
                              ),
                              Row(
                                children: const [
                                  Text("Horoscope: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text("Taurus"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Text("DOB: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text("2054/12/20"),
                                ],
                              ),
                              Row(
                                children: const [
                                  Text("Birth Time: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text("4:12:20 PM"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 8),
                          child: Row(
                            children: const [
                              Text("Birth Place: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text("Hetauda"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 8),
                          child: Row(
                            children: const [
                              Text("Current Address: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text("Kathmandu,Nepal"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 8, bottom: 12),
                          child: Row(
                            children: const [
                              Text("Content: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text("+977 9876543210"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10, top: 2),
                  child: Container(
                    height: 360,
                    decoration: BoxDecoration(
                      gradient: themeProvider.whiteLiteContainerBackground,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 14.0, top: 8),
                          child: Text("Preferences",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/Translate.png',
                                    height: 18,
                                    width: 18,
                                    color:
                                        themeProvider.tabUnSelectedLabelColor,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 4.0),
                                    child: Text("Language"),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 68.0),
                              child: Row(
                                children: [
                                  Radio(
                                    activeColor: themeProvider.tabColor,
                                    value: Language.English,
                                    groupValue: language,
                                    onChanged: (Language? value) {
                                      setState(() {
                                        language = value!;
                                      });
                                    },
                                  ),
                                  const Text("English")
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: Language.Nepal,
                                  groupValue: language,
                                  onChanged: (Language? value) {
                                    setState(() {
                                      language = value!;
                                    });
                                  },
                                ),
                                const Text("Nepal")
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Row(
                                children: const [
                                  Icon(Icons.dark_mode),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4.0),
                                    child: Text("Theme"),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 85.0),
                              child: Row(
                                children: [
                                  Radio(
                                    value: Themes.Dark,
                                    groupValue: themes,
                                    activeColor: themeProvider.tabColor,
                                    onChanged: (Themes? value) {
                                      setState(() {
                                        themes = value!;
                                      });
                                    },
                                  ),
                                  const Text("Dark")
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: Themes.Lite,
                                  groupValue: themes,
                                  onChanged: (Themes? value) {
                                    setState(() {
                                      themes = value!;
                                    });
                                  },
                                ),
                                const Text("Lite")
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Row(
                                children: const [
                                  Icon(Icons.favorite_border_outlined),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4.0),
                                    child: Text("Favourite"),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 33.0),
                              child: Text("Your Favorite Product & Services"),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: themeProvider.corner!)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 1.0, right: 1, top: 4, bottom: 4),
                                  child: Image.asset(
                                      'assets/images/Group 36274.png'),
                                )),
                            const SizedBox(
                              width: 6,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: themeProvider.corner!)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 1.0, right: 1, top: 4, bottom: 4),
                                  child: Image.asset(
                                      'assets/images/Group 36274.png'),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
