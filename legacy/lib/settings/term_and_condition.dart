import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class TermAndCondition extends StatelessWidget {
  const TermAndCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title:  Text('Term And Condition',
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
                  const Text('Welcome to Nepali Calendar!'),
                  const SizedBox(
                    height: 22,
                  ),
                  const Text(
                      'These terms & conditions outline the rules & regulations for the use of Nepali Calendar.\n'),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      'By using this app we assume you accept these terms and \n'
                      'conditions. Do not continue to use Nepali Calendar if you \n'
                      'do not agree to take all of the terms and conditions \n'
                      'stated on this page.'),
                  const SizedBox(
                    height: 18,
                  ),
                  const Text(
                    '1. Definitions',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text('For the purposes of these Terms and Conditions:'),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 6.0),
                        child: Icon(
                          Icons.circle,
                          size: 6,
                        ),
                      ),
                      Text('   Application',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('  means the Nepali Calendar App.'),
                    ],
                  ),
                  const Text(
                      '       downloaded by You on any electronic device.'),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 6.0),
                        child: Icon(
                          Icons.circle,
                          size: 6,
                        ),
                      ),
                      Text('   Application Store',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('  means the digital distribution'),
                    ],
                  ),
                  const Text(
                      '       service operated and developed by Apple Inc. (Apple\n'
                      '       App Store) or Google Inc. (Google Play Store) in which\n'
                      '       the Application has been downloaded.'),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 6.0),
                        child: Icon(
                          Icons.circle,
                          size: 6,
                        ),
                      ),
                      Text('   Country',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('  refers to: Nepal'),
                    ],
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 6.0),
                        child: Icon(
                          Icons.circle,
                          size: 6,
                        ),
                      ),
                      Text('   Company',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('  (referred to as either "We", "Us" or "Our" in'),
                    ],
                  ),
                  const Text(
                      '       this Agreement) refers to Nepali Calendar.'),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 6.0),
                        child: Icon(
                          Icons.circle,
                          size: 6,
                        ),
                      ),
                      Text('   Device',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('  means any device that can access the Service'),
                    ],
                  ),
                  const Text('       such as a cellphone or a digital tablet.'),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 6.0),
                        child: Icon(
                          Icons.circle,
                          size: 6,
                        ),
                      ),
                      Text('   Service',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('  refers to the Application.'),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 6.0),
                        child: Icon(
                          Icons.circle,
                          size: 6,
                        ),
                      ),
                      Text('   Terms and Conditions',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('  (also referred as "Terms") mean'),
                    ],
                  ),
                  const Text(
                      '       these Terms and Conditions that form the entire\n'
                      '       agreement between You and the Company regarding\n'
                      '       the use of the Service.'),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 6.0),
                        child: Icon(
                          Icons.circle,
                          size: 6,
                        ),
                      ),
                      Text('   You',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('  means the individual accessing or using our App'),
                    ],
                  ),
                  const Text(
                      '       on behalf of which such individual is accessing or\n'
                      '       using the Service, as applicable.'),
                  const SizedBox(
                    height: 22,
                  ),
                  const Text(
                    '2. Users’ Accounts and membership',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'We do not own any data, information or material\n'
                    '(collectively, “Content”) that you submit in the Mobile App\n'
                    'in the course of using the Service. You shall have sole\n'
                    'responsibility for the accuracy, quality, integrity, legality,\n'
                    'reliability, appropriateness, & intellectual property\n'
                    'ownership or right to use of all submitted Content. We\n'
                    'may monitor and review the Content in the Mobile App\n'
                    'submitted or created using our Services by you. You grant\n'
                    'us permission to access, copy, distribute, store, transmit,\n'
                    'reformat, display and perform the Content of your user\n'
                    'account solely as required for the purpose of providing the\n'
                    'Services to you. Without limiting any of those warranties,\n'
                    'we have the right, though not the obligation, to, in our\n'
                    'own sole discretion, refuse or remove any Content that, in\n'
                    'our reasonable opinion, violates any of our policies or is in\n'
                    'any way harmful or objectionable. Unless specifically\n'
                    'permitted by you, your use of the Mobile Application and\n'
                    'Services does not grant us the license to use, reproduce,\n'
                    'adapt, modify, publish or distribute the Content created\n'
                    'by you or stored in your user account for commercial,\n'
                    'marketing or any similar purpose.',
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  const Text('3. Backups of the Users’ information',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'We perform regular backups of the Content and will do\n'
                    'our best to ensure completeness and accuracy of these\n'
                    'backups. In the event of the hardware failure or data loss\n'
                    'we will restore backups automatically to minimize the\n'
                    'impact and downtime.',
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  const Text('4. Links to other resources',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'Although the Mobile Application and Services may link to other resources (such as websites, mobile applications, etc.), we are not, directly or indirectly, implying any approval, association, sponsorship, or endorsement with any linked resource, unless specifically stated herein. We are not responsible for examining or evaluating, and we do not warrant the offerings of, any businesses or individuals or the content of their resources. We do not assume any responsibility or liability for the actions, products, services, and content of any other third parties. You should carefully review the legal statements and other conditions of use of any resource which you access through a link in the Mobile Application. Your linking to any other off-site resources is at your own risk.',
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  const Text('5. Intellectual property rights',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text('” means all present and future rights conferred by statute, common law or equity in or in relation to any copyright and related rights, trademarks, designs, patents, goodwill and the right to sue for passing off, rights to inventions, rights to use, and all other intellectual property rights, in each case whether registered or unregistered and including all applications and rights to apply for and be granted, rights to claim priority from, such rights and all similar or equivalent rights or forms of protection and any other results of intellectual activity which subsist or will subsist now or in the future in any part of the world. This Agreement does not transfer to you any intellectual property owned by the Operator, and all rights, titles, and interests in and to such property will remain (as between the parties) solely with the Operator. All trademarks, service marks, graphics and logos used in connection with the Mobile App and Services, are registered trademarks of the Operator or its licensors. Your use of the Mobile Application and Services grants you no right or license to reproduce or otherwise use any of the Operator or trademarks.'),
                  const SizedBox(
                    height: 22,
                  ),
                  const Text('6. Termination',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      'We may terminate or suspend Your access immediately, without prior notice, for any reason whatsoever, including without limitation if You breach these Terms & Conditions'),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                      'Upon termination, Your right to use the Service will cease immediately.'),
                  const SizedBox(
                    height: 22,
                  ),
                  const Text('7. Changes and amendments',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      'We reserve the right to modify this terms related to the Mobile App and Services at any time at our discretion. When we do, we will post a notification in the Mobile Application. We may also provide notice to you in other ways at our discretion, such as through the contact information you have provided'),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                      'An updated version of this Agreement will be effective immediately upon the posting of the revised Agreement unless otherwise specified. Your continued use of the Mobile Application and Services after the effective date of the revised Agreement (or such other act specified at that time) will constitute your consent to those changes.'),
                  const SizedBox(
                    height: 22,
                  ),
                  const Text('8. Acceptance of these terms',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      'You acknowledge that you have read this Agreement and agree to all its terms and conditions. By accessing and using the Mobile Application and Services you agree to be bound by this Agreement. If you do not agree to abide by the terms of this Agreement, you are not authorized to access or use the Mobile Application and Services.'),
                  const SizedBox(
                    height: 22,
                  ),
                  const Text('9. Contact Us',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      'If you have any questions, concerns, or complaints regarding this Agreement, we encourage you to contact us '),
                  Row(
                    children: [
                      const Text('at '),
                      Text(
                        'info@ourvirtualtribes.com.',
                        style: TextStyle(
                            color: themeProvider.tabColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                      'This document was last updated on April 11, 2023'),
                  const SizedBox(
                    height: 8,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
