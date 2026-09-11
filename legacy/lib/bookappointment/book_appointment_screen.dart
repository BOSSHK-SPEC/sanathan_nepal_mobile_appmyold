import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/bookappointment/book_appoin_products_screen.dart';

import '../theme/theme_provider.dart';
import 'book_appoin_about_screen.dart';
import 'book_appoin_content_screen.dart';
import 'book_appoin_review_screen.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(gradient: themeProvider.appBar),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topLeft,
                  children: [
                    Positioned(
                      left:8,
                        top: 42,
                        child: Icon(Icons.arrow_back,color: themeProvider.whiteTextColor,)),
                     Positioned(
                        top: 44,
                        left: 99,
                        child: Text('Book An Appointment',
                            style: TextStyle(
                            color: themeProvider.whiteTextColor,
                                fontWeight: FontWeight.bold, fontSize: 20))),
                    Positioned(
                        top: 133,
                        left: 120,
                        child: Row(
                          children:  [
                            Text('Dr.Uttam Upadhayaya',
                                style: TextStyle(
                                    color: themeProvider.whiteTextColor,
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            Text('(Astrologer)',style: TextStyle(color: themeProvider.whiteTextColor,),)
                          ],
                        )),
                     Positioned(
                        top: 154,
                        left: 120,
                        child: Text('Astrology & Vaastu Expert',style: TextStyle(color: themeProvider.whiteTextColor,),)),
                    Positioned(
                      top: 172,
                      left: 114,
                      child: Row(
                        children: [
                          RatingBar.builder(
                            itemSize: 14,
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              size: 1,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              //print(rating);
                            },
                          ),
                           Text(
                            '116K followers',
                            style: TextStyle(fontSize: 12,color: themeProvider.whiteTextColor,),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                        top: 165,
                        right: 9,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(33),
                                border:
                                    Border.all(color: themeProvider.corner!)),
                            height: 22,
                            width: 22,
                            child: CircleAvatar(
                              backgroundColor: themeProvider.panchangBackground,
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 14,
                              ),
                            ))),
                    Positioned(
                        top: 110,
                        left: 0,
                        child: Image.asset('assets/images/Ellipse 6.png')),
                    Positioned(
                        top: 204,
                        right: 9,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        themeProvider.bookAppointmentBackground,
                                    borderRadius: BorderRadius.circular(3)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6.0, right: 6, top: 2, bottom: 2),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.add,
                                        size: 14,
                                      ),
                                      Text('Follow',
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: themeProvider
                                        .bookAppointmentBackground),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6.0, right: 6, top: 2, bottom: 2),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.messenger_outline_rounded,
                                        size: 14,
                                      ),
                                      Text('Message',
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: themeProvider
                                        .bookAppointmentBackground),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6.0, right: 6, top: 2, bottom: 2),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.language_sharp,
                                        size: 14,
                                      ),
                                      Text('Website',
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                )),
            const SizedBox(
              height: 33,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Container(
                    height: 26,
                    width: 350,
                    decoration: BoxDecoration(
                        color: themeProvider.bookAppointmentBackground,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6))),
                    child: TabBar(
                      controller: _tabController,
                      //indicatorPadding: EdgeInsets.only(left: 28,right: 28),
                      indicatorColor: themeProvider.tabColor,
                      labelColor: themeProvider.tabUnSelectedLabelColor,
                      unselectedLabelColor: Colors.grey,
                      tabs: const [
                        Tab(
                            child:
                                Text('About', style: TextStyle(fontSize: 7))),
                        Tab(
                            child: Text(
                          'Products&Services',
                          style: TextStyle(fontSize: 7),
                        )),
                        Tab(
                            child: Text(
                          'Reviews',
                          style: TextStyle(fontSize: 8),
                        )),
                        Tab(
                            child: Text(
                          'Content',
                          style: TextStyle(fontSize: 8),
                        )),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: Container(
                    height: 26,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(6)),
                        color: themeProvider.bookAppointmentBackground),
                    child: Image.asset('assets/images/icon _edit_.png'),
                  ),
                )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 6),
              child: SizedBox(
                height: 550,
                width: MediaQuery.of(context).size.width,
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    BookAppoinAboutScreen(),
                    BookAppoinProductsScreen(),
                    BookAppoinReviewScreen(),
                    BookAppoinContentScreen()
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
