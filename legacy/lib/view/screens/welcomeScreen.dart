/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sanathan_nepal_mobile_app/view/helper/styles.dart';
import 'package:sanathan_nepal_mobile_app/view/widgets/button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _languageValue = 0;
  int _themeValue = 0;

  void _setLanguageValue(int? value) {
    setState(() {
      _languageValue = value ?? 0;
    });
  }

  void _setThemeValue(int? value) {
    setState(() {
      _themeValue = value ?? 0;
      if (_themeValue == 0) {
        // Set dark theme
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ));
      } else {
        // Set light theme
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
        ));
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.2,
              ),
              Text(
                'Welcome to Sanathan Nepal',
                style: TextStyles.heading,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                'Select language',
                style: TextStyles.subheading,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 0,
                        groupValue: _languageValue,
                        onChanged: _setLanguageValue,
                      ),
                      Text('Nepali')
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _languageValue,
                        onChanged: _setLanguageValue,
                      ),
                      Text('English')
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 50.0, right: 50.0),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                'Select Theme',
                style: TextStyles.subheading,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 0,
                        groupValue: _themeValue,
                        onChanged: _setThemeValue,
                      ),
                      Text('Dark')
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _themeValue,
                        onChanged: _setThemeValue,
                      ),
                      Text('Light')
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width * 0.2,
                  ),
                  GradientButton(
                    text: 'Continue',
                    onPressed: () {
                      Navigator.pushNamed(context, '/SignupOrLoginScreen');
                    },
                    width: width / 3,
                  ),
                  SizedBox(
                    width: width * 0.12,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'SKIP',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/view/screens/signupOrLoginScreen.dart';
import '../../theme/theme_provider.dart';
import '../helper/styles.dart';
import '../widgets/button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.2,
            ),
            const Text('   Welcome To Sanathan Nepal', style: TextStyle(fontWeight: FontWeight.bold,fontSize:22)),
            SizedBox(
              height: height * 0.03,
            ),
            Text('Select language', style: TextStyles.subheading()),
            SizedBox(
              height: height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Radio(
                      activeColor: themeProvider.tabColor,
                      value: 0,
                      groupValue: 0,
                      onChanged: (value) {},
                    ),
                    const Text('Nepali')
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: 0,
                      onChanged: (value) {},
                    ),
                    const Text('English')
                  ],
                ),
              ],
            ),
            SizedBox(
              height: height * 0.03,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 50.0, right: 50.0),
              child: Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Text('Select Theme', style: TextStyles.subheading()),
            SizedBox(
              height: height * 0.03,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<bool>(
                  activeColor: themeProvider.tabColor,
                  value: false,
                  groupValue: !themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                    if (value!) {
                      themeProvider.toggleTheme();
                    }
                  },
                ),
                const Text('Dark Theme'),
                Radio<bool>(
                  value: false,
                  activeColor: themeProvider.tabColor,
                  groupValue: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                    if (value!) {
                      themeProvider.toggleTheme();
                    }
                  },
                ),
                const Text('Light Theme'),
              ],
            ),
            SizedBox(
              height: height * 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * 0.2,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const SignupOrLoginScreen()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(33),
                      gradient: themeProvider.appointmentButtonColor
                    ),
                    height: 44,
                    width: 133,
                    child:  Center(child: Text('Continue',style: TextStyle(color: themeProvider.whiteTextColor),)),
                  ),
                ),
                SizedBox(
                  width: width * 0.12,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
