import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title:  Text('Privacy Policy',
                style: TextStyle(
                  fontSize: 14,
                  color: themeProvider.tabUnSelectedLabelColor
                ),),
            centerTitle: true),
        body: ListView(
          children: [
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Last updated: April 10, 2023',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  const Text(
                      'one of our main priorities is the privacy of our visitors. Nepali Calendar may sometimes use Your Personal data to provide & improve the Service. By using our Service, You agree to the collection and use of information in accordance with this Privacy Policy. This Privacy Policy document contains types of information that is collected and recorded by Nepali Calendar and how we use it.'),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                      ' If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.'),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    '1. What  Information Do We Collect?',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text('1.1 Personal information you disclose to us',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                      'While using Our app, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text('  Email Address'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text('  First name and last name'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text('  Phone number'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text(
                            '  Address, State, Province, ZIP/Postal code, City'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    '1.2 Information automatically collected',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                      'We automatically collect certain information when you visit, use, or navigate the App. This information does not reveal your specific identity (like your name or contact information) but may include device and usage information, such as you'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text('  IP address'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text('  Browser and device characteristics'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text('  Operating system'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text('  Language preferences'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text('  Device name, Location'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text('  and other technical information.'),
                      ],
                    ),
                  ),
                  const Text(
                      'This information is primarily needed to maintain the security and operation of our Services, and for our internal analytics and reporting purposes.'),
                  const SizedBox(
                    height: 22,
                  ),
                  const Text(
                    '2. Purpose of use of Information',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                      'The Company may use Personal Data for the following purposes:'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text('  To provide and maintain our Service,',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(' including to'),
                      ],
                    ),
                  ),
                  const Text('        monitor the usage of our Service.'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text('  To manage Your Account:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(' to manage Your'),
                      ],
                    ),
                  ),
                  const Text(
                      '        registration as a user of the Service. The Personal Data\n'
                      '        You provide can give You access to different\n'
                      '        functionalities of the Service that are available to You\n'
                      '        as a registered user.'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text('  To contact You:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(' To contact You by email, telephone '),
                      ],
                    ),
                  ),
                  const Text(
                      '       calls, SMS, or other equivalent forms of electronic \n'
                      '       communication, such as a mobile application s push \n'
                      '       notifications regarding updates or informative \n'
                      '       communications related to the functionalities, products or \n'
                      '       contracted services, including the security updates, when \n'
                      '       necessary or reasonable for their implementation.'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text('  To provide',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(' You with news, special offers and general '),
                      ],
                    ),
                  ),
                  const Text(
                    '       information about other services and events which we \n'
                    '       offer that are similar to those that you have already \n'
                    '       enquired about unless You have opted not to receive \n'
                    '       such information. \n',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text('  For other purposes:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(' We may use Your information for '),
                      ],
                    ),
                  ),
                  const Text(
                    '       other purposes, such as data analysis, identifying \n'
                    '       usage trends, and to evaluate and improve our App, \n'
                    '       products, services, and your user experience. \n',
                  ),
                  const Text(
                    '3. How Long do we keep your information?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                      'Nepali Calendar will retain Your Personal Data only for as long as is necessary for the purposes set out in Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations, resolve disputes, & enforce our legal agreements & policies.'),
                  const SizedBox(
                    height: 22,
                  ),
                  const Text(
                      'Nepali Calendar will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of Our Service, or We are legally obligated to retain this data for longer time periods.'),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    '4. Transfer of the Users’ information',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                      'Your information, including Personal Data, is processed at the Companys operating offices and in any other places where the parties involved in the processing are located.'),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                      'Your consent to this Privacy Policy followed by Your submission of such information represents Your agreement to that transfer.'),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    '5. Delete Users’ Personal Data',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                      'Our App may give You the ability to delete certain information about You from within the Service.You may update, amend, or delete Your information at any time by signing in to Your Account, if you have one, and visiting the account settings section that allows you to manage Your personal information. You may also contact Us to request access to, correct, or delete any personal information that You have provided to Us.Please note, however, that We may need to retain certain information when we have a legal obligation or lawful basis to do so.'),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    '6. Disclosure of Users’ Personal Data',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                      'Nepali Calendar may disclose Your Personal Data in the good faith belief that such action is necessary to:'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text('  Comply with a legal obligation '),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text(
                            '  Protect and defend the rights or property of the '),
                      ],
                    ),
                  ),
                  const Text('       Company'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text(
                            '  Prevent or investigate possible wrongdoing in '),
                      ],
                    ),
                  ),
                  const Text('       connection with the Service'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text(
                            '  Protect the personal safety of Users of the Service or '),
                      ],
                    ),
                  ),
                  const Text('       the public'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text('  Protect against legal liability'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    '7. Changes to this Privacy Policy',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                      'We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.We will let You know via email and/or a prominent notice on Our App, prior to the change becoming effective and update the "Last updated" date at the top of this Privacy Policy.Changes to this Privacy Policy are effective when they are posted on this page.'),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    '8. Security measures for Users’ information',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                      'The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security.'),
                  const SizedBox(height: 16),
                  const Text(
                    '9. Contact Us,',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      'If you have any questions about our Privacy Policy, do not hesitate to contact us at '),
                  Row(
                    children: [
                      const Text('at '),
                      Text(
                        ' info@ourvirtualtribes.com.',
                        style: TextStyle(
                            color: themeProvider.tabColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
