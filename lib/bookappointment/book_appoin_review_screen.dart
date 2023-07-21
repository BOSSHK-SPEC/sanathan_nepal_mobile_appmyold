import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class BookAppoinReviewScreen extends StatefulWidget {
  const BookAppoinReviewScreen({Key? key}) : super(key: key);

  @override
  State<BookAppoinReviewScreen> createState() => _BookAppoinReviewScreenState();
}

class _BookAppoinReviewScreenState extends State<BookAppoinReviewScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: themeProvider.bookAppointmentBackground),
                  height: 333,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      const Text('Customer Reviews',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: RatingBar.builder(
                          itemSize: 16,
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            size: 2,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            //print(rating);
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text('No Customer Review Yet',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, right: 44, left: 44),
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: themeProvider.corner!, //color of border
                                width: 1, //width of border
                              ),
                              borderRadius: BorderRadius.circular(2)),
                          child: const Center(child: Text('WRITE A REVIEW')),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(),
                      ),
                      const Text('Ratings & Reviews (42)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('5'),
                                LinearPercentIndicator(
                                  width: 260.0,
                                  lineHeight: 10.0,
                                  percent: 1,
                                  progressColor: Colors.orangeAccent,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text('4.8',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 19),
                                  child: RatingBar.builder(
                                    itemSize: 16,
                                    initialRating: 1,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 1,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      size: 2,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      //print(rating);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('4'),
                                LinearPercentIndicator(
                                  width: 260.0,
                                  lineHeight: 10.0,
                                  percent: 0.8,
                                  progressColor: Colors.orangeAccent,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8, right: 19),
                                  child: Text('42 Reviews',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.grey)),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('3'),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 85.0),
                                    child: LinearPercentIndicator(
                                      width: 260.0,
                                      lineHeight: 10.0,
                                      percent: 0.6,
                                      progressColor: Colors.orangeAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('2'),
                                LinearPercentIndicator(
                                  width: 260.0,
                                  lineHeight: 10.0,
                                  percent: 0.4,
                                  progressColor: Colors.orangeAccent,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 27, left: 8),
                                  child: Text('98 % ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22)),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('1'),
                                LinearPercentIndicator(
                                  width: 260.0,
                                  lineHeight: 10.0,
                                  percent: 0.2,
                                  progressColor: Colors.orangeAccent,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 11.0),
                                  child: Text('Recommended',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.grey)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Container(
                  color: themeProvider.reviewBackground,
                  height: 333,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 75,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Ratings',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: RatingBar.builder(
                                      itemSize: 33,
                                      initialRating: 0,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        size: 2,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        //print(rating);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 62.0),
                              child: Container(
                                width: 79,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  gradient: themeProvider.gradient2,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: themeProvider.tabColor,
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                    const Text(
                                      'Add your photos',
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 10,
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 44,
                            /*decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey,
                  ),*/
                            child: TextFormField(
                              //obscureText: !_passwordVisible,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                              ],
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 15),
                                hintText: "Title",
                                hintStyle: const TextStyle(color: Colors.grey),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                /*suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          )),*/
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              /*validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Password can't be empty";
                        }
                        if (EmailValidator.validate(text) == true) {
                          return null;
                        }
                        if (text.length < 6) {
                          return "please enter a valid Password";
                        }
                        if (text.length > 49) {
                          return "Password can't be more than 50";
                        }
                        return null;
                    },
                    onChanged: (value) {
                        setState(() {
                          if (value.isNotEmpty) {
                          isTextEmpty = true;
                          } else {
                          isTextEmpty = false;
                          }
                        });
                    },*/
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 10,
                          ),
                          child: SizedBox(
                            height: 99,
                            child: TextFormField(
                              maxLines: 11,
                              //obscureText: !_passwordVisible,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                              ],
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(left: 15, top: 22),
                                hintText: "Review:",
                                hintStyle: const TextStyle(color: Colors.grey),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                /*suffixIcon: IconButton(
                            onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                            },
                            icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            )),*/
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              /*validator: (text) {
                        if (text == null || text.isEmpty) {
                            return "Password can't be empty";
                        }
                        if (EmailValidator.validate(text) == true) {
                            return null;
                        }
                        if (text.length < 6) {
                            return "please enter a valid Password";
                        }
                        if (text.length > 49) {
                            return "Password can't be more than 50";
                        }
                        return null;
                    },
                    onChanged: (value) {
                        setState(() {
                            if (value.isNotEmpty) {
                            isTextEmpty = true;
                            } else {
                            isTextEmpty = false;
                            }
                        });
                    },*/
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 10,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 44,
                            decoration: BoxDecoration(
                                color: themeProvider.bookAppointmentBackground,
                                border: Border.all(
                                  color: themeProvider.corner!, //color of border
                                  width: 1, //width of border
                                ),
                                borderRadius: BorderRadius.circular(2)),
                            child: const Center(
                              child: Text(
                                'SEND REVIEW',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: themeProvider.bookAppointmentBackground,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6))),
                  height: 248,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, right: 8, top: 12),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Column(
                                children: [
                                  Container(
                                      height: 222,
                                      width: 269,
                                      decoration: BoxDecoration(
                                        color: themeProvider.reviewBackground2,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('ShawnZay Koirala',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                RatingBar.builder(
                                                  itemSize: 12,
                                                  initialRating: 3,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemPadding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 4.0),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    size: 2,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    //print(rating);
                                                  },
                                                ),
                                                const Text('2022-03-21'),
                                              ],
                                            ),
                                            const Text(
                                                'One window solutions for all Astro-vedics issues.One window solutions for all Astro-Vedics issues..'),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            SizedBox(
                                              height: 90,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8,
                                                              top: 2,
                                                              bottom: 2),
                                                      child: Image.asset(
                                                          'assets/images/Photo.png')),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8,
                                                              top: 2,
                                                              bottom: 2),
                                                      child: Image.asset(
                                                          'assets/images/Photo (1).png')),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8,
                                                              top: 2,
                                                              bottom: 2),
                                                      child: Image.asset(
                                                          'assets/images/Photo (2).png')),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Column(
                                children: [
                                  Container(
                                      height: 222,
                                      width: 269,
                                      decoration: BoxDecoration(
                                        color: themeProvider.reviewBackground2,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('ShawnZay Koirala',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                RatingBar.builder(
                                                  itemSize: 12,
                                                  initialRating: 3,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemPadding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 4.0),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    size: 2,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    //print(rating);
                                                  },
                                                ),
                                                const Text('2022-03-21'),
                                              ],
                                            ),
                                            const Text(
                                                'One window solutions for all Astro-vedics issues.One window solutions for all Astro-Vedics issues..'),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            SizedBox(
                                              height: 90,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8,
                                                              top: 2,
                                                              bottom: 2),
                                                      child: Image.asset(
                                                          'assets/images/Photo.png')),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8,
                                                              top: 2,
                                                              bottom: 2),
                                                      child: Image.asset(
                                                          'assets/images/Photo (1).png')),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8,
                                                              top: 2,
                                                              bottom: 2),
                                                      child: Image.asset(
                                                          'assets/images/Photo (2).png')),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Column(
                                children: [
                                  Container(
                                      height: 222,
                                      width: 269,
                                      decoration: BoxDecoration(
                                        color: themeProvider.reviewBackground2,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('ShawnZay Koirala',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                RatingBar.builder(
                                                  itemSize: 12,
                                                  initialRating: 3,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemPadding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 4.0),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    size: 2,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    //print(rating);
                                                  },
                                                ),
                                                const Text('2022-03-21'),
                                              ],
                                            ),
                                            const Text(
                                                'One window solutions for all Astro-vedics issues.One window solutions for all Astro-Vedics issues..'),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            SizedBox(
                                              height: 90,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8,
                                                              top: 2,
                                                              bottom: 2),
                                                      child: Image.asset(
                                                          'assets/images/Photo.png')),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8,
                                                              top: 2,
                                                              bottom: 2),
                                                      child: Image.asset(
                                                          'assets/images/Photo (1).png')),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8,
                                                              top: 2,
                                                              bottom: 2),
                                                      child: Image.asset(
                                                          'assets/images/Photo (2).png')),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
