import 'package:country_picker/country_picker.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Country? countryName;
  Currency? name;
  Currency? nepalName;
  double? rate;
  double amountFrom = 0.0;
  double amountTo = 0.0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Column(
              children: [
//                 Padding(
//                   padding: const EdgeInsets.all(22.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         gradient: themeProvider.gradient2
//                     ),
//                     child: ExpansionTileCard(
//                       elevation: 9,
//                       expandedColor: Colors.yellow,
//                       baseColor: Colors.green,
//
//                       expandedTextColor: Colors.red,
//                       leading: const CircleAvatar(child: Text('B')),
//                       title: const Text('Tap me!'),
//                       subtitle: const Text('I expand, too!'),
//                       children: <Widget>[
//                         const Divider(
//                           thickness: 1.0,
//                           height: 1.0,
//                         ),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16.0,
//                               vertical: 8.0,
//                             ),
//                             child: Text(
//                               """Hi there, I'm a drop-in replacement for Flutter's ExpansionTile.
//
// Use me any time you think your app could benefit from being just a bit more Material.
//
// These buttons control the card above!""",
//
//                             ),
//                           ),
//                         ),
//                         ButtonBar(
//                           alignment: MainAxisAlignment.spaceAround,
//                           buttonHeight: 52.0,
//                           buttonMinWidth: 90.0,
//                           children: <Widget>[
//                             Text('data'),
//                             Text('data'),
//                             Text('data'),
//
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

                const SizedBox(
                  height: 33,
                ),

                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: themeProvider.gradient2),
                  child: ExpansionCard(
                    margin: const EdgeInsets.only(bottom: 12, top: 8),
                    trailing: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 4),
                      child: SizedBox(
                          width: 11,
                          child: Divider(
                            color: themeProvider.tabColor,
                            thickness: 2,
                          )),
                    ),
                    title: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Foreign Exchange ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: themeProvider
                                          .tabUnSelectedLabelColor)),
                              Text('USD 130.85 | UK 130.85 | AUD 130.85',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: themeProvider
                                          .tabUnSelectedLabelColor)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('U.S. DOLLAR - TREND',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color:
                                        themeProvider.tabUnSelectedLabelColor)),
                            Text('Falgun 15, 2079 (27 February, 2023)',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: themeProvider
                                        .bookAppointmentIconColors)),
                          ],
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 33,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: themeProvider.corner!),
                                  ),
                                  child: Center(
                                    child: Row(
                                      children: const [
                                        Text('    Select date range'),
                                        Icon(Icons.arrow_drop_down),
                                      ],
                                    ),
                                  ),
                                ),
                                Text('   1W',
                                    style: TextStyle(
                                        color: themeProvider
                                            .bookAppointmentIconColors)),
                                const Text('   1M'),
                                const Text('   1Y  '),
                                Row(
                                  children: [
                                    Icon(Icons.circle,
                                        size: 10,
                                        color: themeProvider.tabColor),
                                    const Text(' Buying  ',
                                        style: TextStyle(fontSize: 11)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: themeProvider
                                          .bookAppointmentIconColors,
                                    ),
                                    const Text(' Selling',
                                        style: TextStyle(fontSize: 11)),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    SizedBox(
                                      height: 22,
                                    ),
                                    Text('134'),
                                    SizedBox(
                                      height: 33,
                                    ),
                                    Text('132'),
                                    SizedBox(
                                      height: 33,
                                    ),
                                    Text('130'),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 22.0, left: 8),
                                  child: Dash(
                                      direction: Axis.vertical,
                                      length: 108,
                                      dashLength: 8,
                                      dashColor: Colors.grey),
                                ),
                                Column(
                                  children: const [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                        width: 270,
                                        child: Divider(
                                          color: Colors.grey,
                                          thickness: 1,
                                        )),
                                    SizedBox(
                                      height: 38,
                                    ),
                                    SizedBox(
                                        width: 270,
                                        child: Divider(
                                          color: Colors.grey,
                                          thickness: 1,
                                        )),
                                    SizedBox(
                                      height: 38,
                                    ),
                                    SizedBox(
                                        width: 270,
                                        child: Divider(
                                          color: Colors.grey,
                                          thickness: 1,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Row(
                                children: const [
                                  Text('Mar 1   '),
                                  Text('Mar 2   '),
                                  Text('Mar 3   '),
                                  Text('Mar 4   '),
                                  Text('Mar 5   '),
                                  Text('Mar 6   '),
                                  Text('Mar 7'),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 33,
                            ),
                            Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: themeProvider.gradient2),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 22.0, top: 12, right: 22),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Currency conversion',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/images/usa-icon.png',
                                          height: 22,
                                          width: 22,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 26.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              showCurrencyPicker(
                                                context: context,
                                                showFlag: true,
                                                showCurrencyName: true,
                                                showCurrencyCode: true,
                                                //showSearchField: true,
                                                onSelect: (Currency currency) {
                                                  setState(() {
                                                    name = currency;
                                                  });
                                                },
                                              );

                                              /*showCountryPicker(
                                                context: context,
                                                showPhoneCode: true, // optional. Shows phone code before the country name.
                                                onSelect: (Country country) {
                                                  setState(() {
                                                    name=country;
                                                  });
                                                  print('Select country: ${country.displayName}');
                                                },
                                              );*/
                                            },
                                            child: Container(
                                              height: 25,
                                              width: 130,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                    color:
                                                        themeProvider.corner!),
                                              ),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '  ${name?.name ?? ''}',
                                                      style: const TextStyle(
                                                          fontSize: 11),
                                                    ),
                                                    const Icon(
                                                        Icons.arrow_drop_down),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                  width: 88,
                                                  child: TextField(
                                                    onSubmitted: (val) async {
                                                      //rate = await getRate(from,to);
                                                    },
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/images/nepal_icon.png',
                                          height: 22,
                                          width: 22,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              showCurrencyPicker(
                                                context: context,
                                                showFlag: true,
                                                showCurrencyName: true,
                                                showCurrencyCode: true,
                                                //showSearchField: true,
                                                onSelect: (Currency currency) {
                                                  setState(() {
                                                    nepalName = currency;
                                                  });
                                                  print('Select currency: ${currency.name}');
                                                },
                                              );
                                            },
                                            child: Container(
                                              height: 25,
                                              width: 130,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                    color:
                                                        themeProvider.corner!),
                                              ),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        '   ${nepalName?.name ?? ""}',
                                                        style: const TextStyle(
                                                            fontSize: 11)),
                                                    const Icon(Icons.arrow_drop_down),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: const [
                                            Text('Buy',
                                                style: TextStyle(fontSize: 10)),
                                            Text('130.85'),
                                            SizedBox(
                                                width: 30,
                                                child: Divider(
                                                  color: Colors.grey,
                                                  thickness: 1,
                                                )),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: const [
                                            Text('Sell',
                                                style: TextStyle(fontSize: 10)),
                                            Text('131.45'),
                                            SizedBox(
                                                width: 30,
                                                child: Divider(
                                                  color: Colors.grey,
                                                  thickness: 1,
                                                )),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 33,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: themeProvider
                                          .bookAppointmentBackground,
                                    ),
                                    child: Row(
                                      children: const [
                                        Text('                       Currency'),
                                        Text('                Buy'),
                                        Text('                Sell'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 22.0),
                                          child: Image.asset(
                                            'assets/images/usa-icon.png',
                                            height: 22,
                                            width: 22,
                                          ),
                                        ),
                                        const Text('        U.S.doller'),
                                        const Text('           130.85'),
                                        const Text('           131.45'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      showCountryPicker(
                                        context: context,
                                        showPhoneCode:
                                            true, // optional. Shows phone code before the country name.
                                        onSelect: (Country country) {
                                          setState(() {
                                            countryName = country;
                                          });
                                          print(
                                              'Select country: ${country.flagEmoji}');
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 33,
                                      width: 172,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: themeProvider.corner!),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('   ${countryName?.name??''}'),
                                          Text(' ${countryName?.flagEmoji??""}'),
                                          const Icon(Icons.arrow_drop_down_sharp),
                                        ],
                                      )
                                    ),
                                  ),
                                  Text(
                                    'More Currency Information',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: themeProvider
                                            .bookAppointmentIconColors),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                    ],
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
