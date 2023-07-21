import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/browseproduct/commit_screen.dart';
import 'package:sanathan_nepal_mobile_app/browseproduct/description_screen.dart';
import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';

class MyOrderBrowseProduct extends StatefulWidget {
  const MyOrderBrowseProduct({Key? key}) : super(key: key);

  @override
  State<MyOrderBrowseProduct> createState() => _MyOrderBrowseProductState();
}

class _MyOrderBrowseProductState extends State<MyOrderBrowseProduct>
    with SingleTickerProviderStateMixin{


  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              color: themeProvider.tabBackground,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(0),
                            bottom: Radius.circular(150),
                          ),
                          gradient: themeProvider.appBar),
                      height: 222,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  const Positioned(
                      top: 22,
                      left: 8,
                      child: Icon(Icons.arrow_back_ios_new_outlined)),
                  const Positioned(
                    top: 22,
                    right: 8,
                    child: Icon(Icons.shopping_bag_outlined),
                  ),
                  Positioned(
                    top: 66,
                    right: 18,
                    left: 18,
                    child: SizedBox(
                      height: 266,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white),
                            child: const Center(child: Text('data'))),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 333,
                    left: 6,
                    right: 6,
                    child: SizedBox(
                      height: 88,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            SizedBox(
                                height: 88,
                                width: 77,
                                child:
                                    Card(child: Center(child: Text('data')))),
                            SizedBox(
                                height: 88,
                                width: 77,
                                child:
                                    Card(child: Center(child: Text('data')))),
                            SizedBox(
                                height: 88,
                                width: 77,
                                child:
                                    Card(child: Center(child: Text('data')))),
                            SizedBox(
                                height: 88,
                                width: 77,
                                child:
                                    Card(child: Center(child: Text('data')))),
                            SizedBox(
                                height: 88,
                                width: 77,
                                child:
                                    Card(child: Center(child: Text('data')))),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 411,
                      right: 6,
                      left: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 14.0, top: 8),
                                child: Text('Dr.Uttam Upadhyaya',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 122.0, top: 8),
                                child: Row(
                                  children: const [
                                    Icon(Icons.remove_red_eye_outlined,
                                        size: 16),
                                    Padding(
                                      padding: EdgeInsets.only(top: 1.0),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 1.0),
                                        child: Text('1,408',
                                            style: TextStyle(fontSize: 11)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 6, top: 8.0,right: 15),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.shopping_cart_outlined,
                                      size: 13,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 1.0),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 1.0),
                                        child: Text('400',
                                            style: TextStyle(fontSize: 11)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only( left: 14),
                                  child: Row(
                                    children: [
                                      Text('Rs,10,000 - 20,000 |',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: themeProvider.tabColor)),
                                      const Text(' Used'),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: RatingBar.builder(
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
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 14.0, top: 4),
                            child: Text(
                              'Iphone 14 Pro Max 245GB, 5G',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 12,),
                          Row(
                            children: [
                              SizedBox(
                                height: 26,
                                width: 180,
                                child: TabBar(
                                  controller: _tabController,
                                  indicatorColor: themeProvider.tabColor,
                                  indicatorPadding: const EdgeInsets.only(left: 16,right: 16),
                                  labelColor: themeProvider.tabUnSelectedLabelColor,
                                  unselectedLabelColor: Colors.grey,
                                  tabs: const [
                                    Tab(
                                        child: Text('Description',
                                            style: TextStyle(fontSize: 12))),
                                    Tab(
                                        child: Text(
                                          'Comments',
                                          style: TextStyle(fontSize: 12),
                                        )),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  height: 26,
                                  width: 65,
                                  decoration: BoxDecoration(
                                    gradient: themeProvider.appBar,
                                    borderRadius: BorderRadius.circular(2)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 14.0),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.call,size: 13,),
                                        Padding(
                                          padding: EdgeInsets.only(left: 2.0),
                                          child: Text('Call',style: TextStyle(fontSize: 13),),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  height: 26,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      gradient: themeProvider.appBar,
                                    borderRadius: BorderRadius.circular(2)
                                  ),
                                  child: Row(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(left: 12.0),
                                        child: Icon(Icons.add_shopping_cart,size: 13),
                                      ),
                                      Text(' Order',style: TextStyle(fontSize: 13)),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0,right: 10),
                            child: SizedBox(
                              height:MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: TabBarView(
                                controller: _tabController,
                                children: const [
                                  DescriptionScreen(),
                                  CommitScreen(),

                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
