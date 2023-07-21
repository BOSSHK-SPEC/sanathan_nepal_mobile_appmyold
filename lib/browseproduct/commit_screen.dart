import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:dotted_border/dotted_border.dart';
import '../theme/theme_provider.dart';

class CommitScreen extends StatefulWidget {
  const CommitScreen({Key? key}) : super(key: key);

  @override
  State<CommitScreen> createState() => _CommitScreenState();
}

class _CommitScreenState extends State<CommitScreen> {
  static List<Widget> allPage = <Widget>[
    const Text('data'),
    const Text('datsssa'),
    const Text('data'),
    const Text('datasssssss'),
    const Text('data'),
  ];
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                label: "Home",
                backgroundColor: Colors.white,
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "Search",
                backgroundColor: Colors.white,
                icon: Icon(Icons.search_outlined),
                activeIcon: Icon(Icons.search),
              ),
              BottomNavigationBarItem(
                label: "Menu",
                backgroundColor: Colors.white,
                icon: Icon(Icons.menu_outlined),
                activeIcon: Icon(Icons.menu),
              ),
              BottomNavigationBarItem(
                label: "Favorites",
                backgroundColor: Colors.white,
                icon: Icon(Icons.favorite_border_outlined),
                activeIcon: Icon(Icons.favorite),
              ),
              BottomNavigationBarItem(
                label: "Settings",
                backgroundColor: Colors.white,
                icon: Icon(Icons.settings),
                activeIcon: Icon(Icons.settings),
              ),
            ],
            currentIndex: selectIndex,
            onTap: onTapped,
          ),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 88.0),
            child: Container(
              decoration: BoxDecoration(color: themeProvider.tabBackground),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 44,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(99),
                            color: themeProvider.reviewBackground2),
                        child: Icon(Icons.chat, color: themeProvider.tabColor),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text('No Commits till Now!!',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text('Be the first to leave a comment',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.grey)),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                themeProvider.bookAppointmentBackground,
                            child: Icon(Icons.person_pin,
                                color: themeProvider.gradientTextColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              height: 38,
                              width: 244,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(99),
                                      bottomLeft: Radius.circular(99)),
                                  color:
                                      themeProvider.bookAppointmentBackground,
                                  border: Border.all(
                                    color: themeProvider.corner!,
                                  )),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                  top: 10.0,
                                  left: 10,
                                ),
                                child: Text('Comment..',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                          Container(
                            height: 38,
                            width: 55,
                            decoration: BoxDecoration(
                                border: Border.all(color: themeProvider.corner!),
                                gradient: themeProvider.appBar,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(99),
                                    bottomRight: Radius.circular(99))),
                            child: const Icon(Icons.send),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 33,
                            width: 33,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(99),
                                color: themeProvider.bookAppointmentBackground),
                            child: const Icon(Icons.person_pin),
                          ),
                          const Text('   Ram Bahadur      .   ',
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          const Text('10days ago',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.grey)),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 42.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: themeProvider.bookAppointmentBackground,
                              ),
                              height: 33,
                              child: const Center(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'I want to purchase this product.',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Icon(Icons.share, size: 16),
                          ),
                          const Text('  Reply', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 38.0, top: 12),
                        child: Row(
                          children: [
                            Container(
                              height: 33,
                              width: 33,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(99),
                                  color:
                                      themeProvider.bookAppointmentBackground),
                              child: const Icon(Icons.person_pin),
                            ),
                            const Text('   shyam Thapa      .   ',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            const Text('10days ago',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Colors.grey)),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 80.0, top: 6),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: themeProvider.bookAppointmentBackground,
                              ),
                              height: 33,
                              child: const Center(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Please contact us.Thank You.',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Icon(Icons.share, size: 16),
                          ),
                          const Text('  Reply', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 33,
                            width: 33,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(99),
                                color: themeProvider.bookAppointmentBackground),
                            child: const Icon(Icons.person_pin),
                          ),
                          const Text('   Hari Bahadur      .   ',
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          const Text('10days ago',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.grey)),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 42.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: themeProvider.bookAppointmentBackground,
                              ),
                              height: 33,
                              child: const Center(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Is this original Pearl?.',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Icon(Icons.share, size: 16),
                          ),
                          const Text('  Reply', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                themeProvider.bookAppointmentBackground,
                            child: Icon(Icons.person_pin,
                                color: themeProvider.gradientTextColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              height: 38,
                              width: 244,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(99),
                                      bottomLeft: Radius.circular(99)),
                                  color:
                                      themeProvider.bookAppointmentBackground,
                                  border: Border.all(
                                    color: themeProvider.corner!,
                                  )),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                  top: 10.0,
                                  left: 10,
                                ),
                                child: Text('Comment..',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                          Container(
                            height: 38,
                            width: 55,
                            decoration: BoxDecoration(
                                border: Border.all(color: themeProvider.corner!),
                                gradient: themeProvider.appBar,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(99),
                                    bottomRight: Radius.circular(99))),
                            child: const Icon(Icons.send),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: themeProvider.tabBackground2),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('General',
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          const Divider(),
                          Row(
                            children: const [
                              Text(
                                'Location:   ',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text('Basantapur(New Road),Kathmandu',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: const [
                              Text(
                                'Negotiable:   ',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text('Negotiable',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: const [
                              Text(
                                'Website Link:   ',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text('www.websitedomain.com',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: const [
                              Text(
                                'Ads Posted:   ',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text('7 minutes ago',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: const [
                              Text(
                                'Ads Expiry:   ',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text('2023-06-03',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 580,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: themeProvider.tabBackground2),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Product Videos',
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          const Divider(),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 38.0),
                                child: Container(
                                    height: 344,
                                    width: 255,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.orange)),
                              ),
                              Positioned(
                                top: 266,
                                left: 38,
                                child: Container(
                                  height: 78,
                                  width: 255,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(6),
                                        bottomRight: Radius.circular(6),
                                      ),
                                      color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text('Dr. Uttam Upadhyaya',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Text('@uttam_guru . 1 hour ago',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13)),
                                          ],
                                        ),
                                        leading: const CircleAvatar(),
                                      ),
                                      const Center(
                                          child: Text(
                                        'Valuable gemstone found inside the body of a Mollusc',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 11),
                                      )),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            height: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12,),
                  DottedBorder(
                      borderType: BorderType.RRect,
                      color: themeProvider.corner!,
                      dashPattern: const [8, 4],
                      strokeWidth: 1,
                      radius: const Radius.circular(6),
                      padding: const EdgeInsets.all(6),
                      child: const Text(
                          'Note: we recommend you to Contact the seller and conduct a thorough physical inspection of the product /Services, testing it appropriately, and ontaining detailed information before making any sorts of payment. As a platform for buyers and sellers, we cannot be help liable for any issues that me arise')),
                  const SizedBox(height: 12,),
                  const Text('Similar Products',style: TextStyle(fontWeight: FontWeight.w500),),
                  const Divider(),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border:
                          Border.all(color: themeProvider.corner!),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        height: 220,
                        width: 168,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 4,
                              left: 4,
                              right: 4,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius:
                                      BorderRadius.circular(6)),
                                  width: MediaQuery.of(context)
                                      .size
                                      .width,
                                  height: 99,
                                  child: Image.asset(
                                    'assets/images/taurus 1.png',
                                    fit: BoxFit.contain,
                                    width: 80,
                                    height: 80,
                                  )),
                            ),
                            const Positioned(
                              top: 4,
                              left: 124,
                              right: 2,
                              child: SizedBox(
                                  width: 33,
                                  height: 33,
                                  child: Icon(Icons
                                      .favorite_border_outlined)),
                            ),
                            Positioned(
                              top: 88,
                              left: 4,
                              right: 4,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(6),
                                      bottomLeft: Radius.circular(6)),
                                  color: Colors.grey.shade400,
                                ),
                                height: 18,
                                width:
                                MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4.0),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons
                                                .remove_red_eye_rounded,
                                            size: 8,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 2.0),
                                            child: Text("1,408",
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons
                                              .add_shopping_cart_sharp,
                                          size: 8,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 2.0),
                                          child: Text("1,408",
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight:
                                                  FontWeight
                                                      .bold)),
                                        ),
                                      ],
                                    ),
                                    RatingBar.builder(
                                      itemSize: 8,
                                      initialRating: 4,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      itemBuilder: (context, _) =>
                                      const Icon(
                                        Icons.star,
                                        size: 2,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 104,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    const Text("Cook Chef Needed | Thakali,\nContinental,Korean",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        )),
                                    const Text(
                                      "Cook neede who ara skilled in \npreparing Korean & Thakali cuisine.",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              top: 3.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                  "Rs 50,000 | ",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: themeProvider
                                                          .tabColor)),
                                              SizedBox(
                                                  height: 10,
                                                  width: 8,
                                                  child: VerticalDivider(
                                                      width: 3,
                                                      color: themeProvider
                                                          .tabColor)),
                                              const Text("Brand New",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 3.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.location_on,
                                              color: themeProvider
                                                  .tabColor,
                                              size: 9),
                                          const Text(
                                              "Basantapur (New Road) Kathmandu",
                                              style: TextStyle(
                                                  fontSize: 9)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                        width: 158,
                                        height: 14,
                                        child: Divider()),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: const [
                                        Text("korean Kitchen",
                                            style: TextStyle(
                                                fontSize: 9,
                                                fontWeight:
                                                FontWeight.bold)),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 48.0),
                                          child: Text("4 minutes ago",
                                              style: TextStyle(
                                                  fontSize: 9,color: Colors.grey)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                            Border.all(color: themeProvider.corner!),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          height: 220,
                          width: 168,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 4,
                                left: 4,
                                right: 4,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                        BorderRadius.circular(6)),
                                    width: MediaQuery.of(context)
                                        .size
                                        .width,
                                    height: 99,
                                    child: Image.asset(
                                      'assets/images/taurus 1.png',
                                      fit: BoxFit.contain,
                                      width: 80,
                                      height: 80,
                                    )),
                              ),
                              const Positioned(
                                top: 4,
                                left: 124,
                                right: 2,
                                child: SizedBox(
                                    width: 33,
                                    height: 33,
                                    child: Icon(Icons
                                        .favorite_border_outlined)),
                              ),
                              Positioned(
                                top: 88,
                                left: 4,
                                right: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(6),
                                        bottomLeft: Radius.circular(6)),
                                    color: Colors.grey.shade400,
                                  ),
                                  height: 18,
                                  width:
                                  MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4.0),
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons
                                                  .remove_red_eye_rounded,
                                              size: 8,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 2.0),
                                              child: Text("1,408",
                                                  style: TextStyle(
                                                      fontSize: 8,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons
                                                .add_shopping_cart_sharp,
                                            size: 8,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 2.0),
                                            child: Text("1,408",
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold)),
                                          ),
                                        ],
                                      ),
                                      RatingBar.builder(
                                        itemSize: 8,
                                        initialRating: 4,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) =>
                                        const Icon(
                                          Icons.star,
                                          size: 2,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 104,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const Text("Cook Chef Needed | Thakali,\nContinental,Korean",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                      const Text(
                                        "Cook neede who ara skilled in \npreparing Korean & Thakali cuisine.",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                top: 3.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                    "Rs 50,000 | ",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: themeProvider
                                                            .tabColor)),
                                                SizedBox(
                                                    height: 10,
                                                    width: 8,
                                                    child: VerticalDivider(
                                                        width: 3,
                                                        color: themeProvider
                                                            .tabColor)),
                                                const Text("Brand New",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 3.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.location_on,
                                                color: themeProvider
                                                    .tabColor,
                                                size: 9),
                                            const Text(
                                                "Basantapur (New Road) Kathmandu",
                                                style: TextStyle(
                                                    fontSize: 9)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                          width: 158,
                                          height: 14,
                                          child: Divider()),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: const [
                                          Text("korean Kitchen",
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  fontWeight:
                                                  FontWeight.bold)),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 48.0),
                                            child: Text("4 minutes ago",
                                                style: TextStyle(
                                                    fontSize: 9,color: Colors.grey)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 500,
                  )
                ],
              ),
            ),
          )),
    );
  }

  onTapped(int index) {
    setState(() {
      selectIndex = index;
    });
  }
}
