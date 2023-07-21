import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class BookAppoinProductsScreen extends StatelessWidget {
  const BookAppoinProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: themeProvider.bookAppointmentBackground,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6)),
              ),
              height: 530,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  ListView(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 12.0,right: 12,top: 12),
                        child: Text(
                          'Post Product & Services,Once you create and publish any Product.Product Tab and your Products will be visible.Else This service tab will be hidden',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(

                              onPressed: () {},
                              child: Row(
                                children:  [
                                  Icon(Icons.add,color: themeProvider.bookAppointmentIconColors),
                                  Text('Add New Product',style: TextStyle(color: themeProvider.bookAppointmentIconColors)),
                                ],
                              )),
                          TextButton(
                              onPressed: () {},
                              child: Row(
                                children:  [
                                  Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: themeProvider.bookAppointmentIconColors,
                                  ),
                                  Text(' Edit / Delete',style:TextStyle(
                                    color: themeProvider.bookAppointmentIconColors,
                                  )),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 8),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(right: 12),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 90,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Image.asset('assets/images/Group 2.png'),
                                        ),
                                        const SizedBox(height: 2),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0),
                                          child: Text('Gem Stones',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                color: themeProvider.tabColor
                                              ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(right: 12),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 90,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Image.asset('assets/images/Group 2 (1).png'),
                                        ),
                                        const SizedBox(height: 2),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 2.0),
                                          child: Text('Rudraksha',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.w500)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(right: 12),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 90,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Image.asset('assets/images/Group 2 (2).png'),
                                        ),
                                        const SizedBox(height: 2),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 2.0),
                                          child: Text('Vaastu Yantra',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.w500)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(right: 12),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 90,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Image.asset('assets/images/Group 2 (3).png'),
                                        ),
                                        const SizedBox(height: 2),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 2.0),
                                          child: Text('Vaastu Yantra',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.w500)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(right: 12),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.indigoAccent,
                                          ),
                                          child: const CircleAvatar(
                                              child: Icon(Icons.person)),
                                        ),
                                        const SizedBox(height: 2),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 2.0),
                                          child: Text('Vaastu Yantra',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.w500)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(left:4.0,right: 4),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0,right: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('All Products & Services',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,)),
                              Text('4 products found',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 12,)),

                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 10,),

                              Image.asset('assets/images/Group 36270.png'),

                              Image.asset('assets/images/Group 36271 (1).png'),
                             /* Padding(
                                padding: const EdgeInsets.only(left: 4.0,right: 4),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border:
                                    Border.all(color: themeProvider.corner),
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  height: 198,
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
                                                    child: Text("400",
                                                        style: TextStyle(
                                                            fontSize: 8,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,)),
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
                                              const Text("Blue Sapphire",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              const Text(
                                                "Blue Sapphire (Neelam Stone) is a profoundly \nvaluable..",
                                                style: TextStyle(fontSize: 8),
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
                                                            "Rs 10,000 - 20,000",
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
                                                  Text("Dr.Uttam Upadhyaya",
                                                      style: TextStyle(
                                                          fontSize: 9,
                                                          fontWeight:
                                                          FontWeight.bold)),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 30.0),
                                                    child: Text("4 minutes ago",
                                                        style: TextStyle(
                                                            fontSize: 9)),
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
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border:
                                    Border.all(color: themeProvider.corner),
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  height: 198,
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
                                                    child: Text("400",
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
                                              const Text("Blue Sapphire",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              const Text(
                                                "Blue Sapphire (Neelam Stone) is a profoundly \nvaluable..",
                                                style: TextStyle(fontSize: 8),
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
                                                            "Rs 10,000 - 20,000",
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
                                                  Text("Dr.Uttam Upadhyaya",
                                                      style: TextStyle(
                                                          fontSize: 9,
                                                          fontWeight:
                                                          FontWeight.bold)),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 30.0),
                                                    child: Text("4 minutes ago",
                                                        style: TextStyle(
                                                            fontSize: 9)),
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
                              ),*/
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 10,),

                              Image.asset('assets/images/Group 36273.png'),

                              Image.asset('assets/images/Group 36272.png'),
                              /*Padding(
                                padding: const EdgeInsets.only(left: 4.0,right: 4,top: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border:
                                    Border.all(color: themeProvider.corner),
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  height: 198,
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
                                                    child: Text("400",
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
                                              const Text("Blue Sapphire",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              const Text(
                                                "Blue Sapphire (Neelam Stone) is a profoundly \nvaluable..",
                                                style: TextStyle(fontSize: 8),
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
                                                            "Rs 10,000 - 20,000",
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
                                                  Text("Dr.Uttam Upadhyaya",
                                                      style: TextStyle(
                                                          fontSize: 9,
                                                          fontWeight:
                                                          FontWeight.bold)),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 30.0),
                                                    child: Text("4 minutes ago",
                                                        style: TextStyle(
                                                            fontSize: 9)),
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
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0,top: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border:
                                    Border.all(color: themeProvider.corner),
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  height: 198,
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
                                                    child: Text("400",
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
                                              const Text("Blue Sapphire",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              const Text(
                                                "Blue Sapphire (Neelam Stone) is a profoundly \nvaluable..",
                                                style: TextStyle(fontSize: 8),
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
                                                            "Rs 10,000 - 20,000",
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
                                                  Text("Dr.Uttam Upadhyaya",
                                                      style: TextStyle(
                                                          fontSize: 9,
                                                          fontWeight:
                                                          FontWeight.bold)),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 30.0),
                                                    child: Text("4 minutes ago",
                                                        style: TextStyle(
                                                            fontSize: 9)),
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
                              ),*/
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
