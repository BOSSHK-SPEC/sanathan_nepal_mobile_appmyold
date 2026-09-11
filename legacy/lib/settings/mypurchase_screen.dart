import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';

class MyPurchaseScreen extends StatelessWidget {
  const MyPurchaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: themeProvider.tabBackground2),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Container(
                  height: 94,
                  decoration: BoxDecoration(
                      gradient: themeProvider.gradient2,
                      borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0, top: 4),
                            child: Text('Order Placed !',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 13)),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 99.0, top: 4),
                            child: Text('5 days',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0, top: 8),
                            child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: themeProvider.corner!),
                                    borderRadius: BorderRadius.circular(2)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, right: 4, top: 2, bottom: 2),
                                  child: Text('Cancel Order',
                                      style: TextStyle(
                                          color: themeProvider.tabColor,
                                          fontSize: 12)),
                                )),
                          ),
                        ],
                      ),
                      ListTile(
                        leading: Image.asset('assets/images/image 4.png'),
                        title: const Text('Iphone 14 Pro Max 245GB,5G',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rs.10,000',
                                style: TextStyle(
                                    color: themeProvider.tabColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('From: Uttam Upadhayay',
                                    style: TextStyle(fontSize: 12)),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          gradient: themeProvider.appointmentButtonColor,
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6.0,
                                            right: 6,
                                            top: 5,
                                            bottom: 5),
                                        child: Row(
                                          children: const [
                                            Icon(Icons.call, size: 12),
                                            Text('Call',
                                                style: TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            gradient: themeProvider.appointmentButtonColor),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4.0,
                                              right: 4,
                                              top: 5,
                                              bottom: 5),
                                          child: Row(
                                            children: const [
                                              Icon(
                                                  Icons
                                                      .messenger_outline_rounded,
                                                  size: 12),
                                              Text('Chat',
                                                  style:
                                                      TextStyle(fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 94,
                  decoration: BoxDecoration(
                      gradient: themeProvider.gradient2,
                      borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 16.0, top: 4),
                            child: Text('Order Approved by Seller !',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 13)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 44.0, top: 4),
                            child: Text('4 days',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0, top: 2),
                            child: Card(
                                color: Colors.grey,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(2),
                                        bottomLeft: Radius.circular(2),
                                        bottomRight: Radius.circular(2),
                                        topRight: Radius.circular(2))),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 6.0, right: 6, top: 2, bottom: 2),
                                  child: Text('Processing',
                                      style: TextStyle(fontSize: 12)),
                                )),
                          ),
                        ],
                      ),
                      ListTile(
                        leading: Image.asset('assets/images/image 4.png'),
                        title: const Text('Iphone 14 Pro Max 245GB,5G',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rs.10,000',
                                style: TextStyle(
                                    color: themeProvider.tabColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('From: Uttam Upadhayay',
                                    style: TextStyle(fontSize: 11)),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          gradient: themeProvider.appointmentButtonColor,
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6.0,
                                            right: 6,
                                            top: 5,
                                            bottom: 5),
                                        child: Row(
                                          children: const [
                                            Icon(Icons.call, size: 12),
                                            Text('Call',
                                                style: TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            gradient: themeProvider.appointmentButtonColor),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4.0,
                                              right: 4,
                                              top: 5,
                                              bottom: 5),
                                          child: Row(
                                            children: const [
                                              Icon(
                                                  Icons
                                                      .messenger_outline_rounded,
                                                  size: 12),
                                              Text('Chat',
                                                  style:
                                                      TextStyle(fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 94,
                  decoration: BoxDecoration(
                      gradient: themeProvider.gradient2,
                      borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 16.0,
                              top: 4,
                            ),
                            child: Text('Product Purchase Completed !',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 22.0, top: 4),
                            child: Text('3 days',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 8.0, top: 2),
                            child: Card(
                                color: Colors.green,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(2),
                                        bottomLeft: Radius.circular(2),
                                        bottomRight: Radius.circular(2),
                                        topRight: Radius.circular(2))),
                                 child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 6.0, right: 6, top: 2, bottom: 2),
                                  child: Text('Completed',
                                      style: TextStyle(fontSize: 11)),
                                )),
                          ),
                        ],
                      ),
                      ListTile(
                        leading: Image.asset('assets/images/image 4.png'),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('Iphone 14 Pro Max 245GB,5G',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                Padding(
                                  padding: const EdgeInsets.only(left: 14.0),
                                  child: Text('Visit Seller Profile',
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: themeProvider.tabColor)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Row(
                              children: [
                                const Text('Rate this Products:',
                                    style: TextStyle(fontSize: 12)),
                                Row(
                                  children: [
                                    RatingBar.builder(
                                      itemSize: 14,
                                      initialRating: 4,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        size: 1,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        //print(rating);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
