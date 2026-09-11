import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/view/helper/styles.dart';

import '../../theme/theme_provider.dart';
import '../widgets/signUpWithNumber.dart';

class SignupOrLoginScreen extends StatefulWidget {
  const SignupOrLoginScreen({super.key});

  @override
  State<SignupOrLoginScreen> createState() => _SignupOrLoginScreenState();
}

class _SignupOrLoginScreenState extends State<SignupOrLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final alertDialogHelper = SignUpWithNumber();
    return Scaffold(
      body: Stack(
        children: [
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.6,
            child: Container(
              decoration: BoxDecoration(
                gradient: themeProvider.signAndLoginBackground,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(22.0),
                  bottomRight: Radius.circular(22.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 308.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    gradient: themeProvider.loginContainerBack,
                    borderRadius: BorderRadius.circular(18)),
                height: 388,
                width: 320,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 48.0,
                      ),
                      child: Text(
                        'Welcome to Sanatan Nepal Family!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    const Text('Log In',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25)),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(6),
                        elevation: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: themeProvider.signUpBackground),
                          height: 65,
                          width: double.infinity,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Image.asset('assets/images/googleLogo.png'),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Continue with Google',
                                style:
                                    TextStyles.subheading(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(6),
                        elevation: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: themeProvider.signUpBackground,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          height: 65,
                          width: double.infinity,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Image.asset('assets/images/googleLogo.png'),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Continue with Apple',
                                style:
                                    TextStyles.subheading(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: themeProvider.signUpBackground),
                          height: 65,
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () {
                              alertDialogHelper.showAlertDialog(
                                  context, themeProvider);
                            },
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                const Icon(Icons.mobile_screen_share_sharp,
                                    color: Colors.grey, size: 26),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Continue with Number',
                                  style: TextStyles.subheading(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> _showAlertDialog(context) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog( // <-- SEE HERE
  //         title: const Text('Cancel booking'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: const <Widget>[
  //               Text('Are you sure want to cancel booking?'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('No'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: const Text('Yes'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
