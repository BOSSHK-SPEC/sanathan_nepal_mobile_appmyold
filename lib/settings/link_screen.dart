import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/settings/privacy_policy.dart';
import 'package:sanathan_nepal_mobile_app/settings/term_and_condition.dart';
import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';

class LinkScreen extends StatefulWidget {
  const LinkScreen({Key? key}) : super(key: key);

  @override
  State<LinkScreen> createState() => _LinkScreenState();
}

class _LinkScreenState extends State<LinkScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: themeProvider.whiteLiteContainerBackground
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 20.0, left: 20, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Useful Links',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.notifications_none,size: 22),
                              Text('  Help & Support',
                                  style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500)),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>const TermAndCondition()));
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.indeterminate_check_box_outlined,size: 21),
                                Text('  Terms & Condition',
                                    style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500)),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>const PrivacyPolicy()));
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.privacy_tip_outlined,size: 21),
                                Text('  Privacy Policy',
                                    style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500)),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    )
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
