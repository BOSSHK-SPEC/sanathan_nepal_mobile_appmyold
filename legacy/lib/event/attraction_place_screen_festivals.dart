import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class AttractionPlaceScreenfestivals extends StatelessWidget {
  const AttractionPlaceScreenfestivals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(6), bottomLeft: Radius.circular(6)),
              color: themeProvider.bookAppointmentBackground,
            ),
            height: 345,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 22, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Text('On this auspicious festival, the devotees visit Ram or Vishnu temples that spread',style: TextStyle(fontSize: 10),),
                      Row(
                        children: [
                          Text('across Nepal. The',style: TextStyle(fontSize: 10),),
                          Text(' Ram Janaki Temple ',style: TextStyle(fontSize: 10,color: themeProvider.tabColor),),
                          Text('in Janakpur will be thronged with devotees',style: TextStyle(fontSize: 10),),
                        ],
                      ),
                      Text('on this day.',style: TextStyle(fontSize: 10),),
                      
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 160,
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6)

                        ),
                        child:Image.asset('assets/images/Rectangle 1059.png') ,
                      ),
                      Container(
                        height: 160,
                        width: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: Image.asset('assets/images/Rectangle 2218.png'),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Other important temples that will be filled with devotees on this festival are:',style: TextStyle(fontSize: 10),),
                      SizedBox(height: 4,),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.circle,
                              size: 5,
                            ),
                            Text(
                                '  Ram Mandir in Battisputali',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                      SizedBox(height: 4,),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.circle,
                              size: 5,
                            ),
                            Text('  Changu Narayan in Bhaktapur',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                      SizedBox(height: 4,),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.circle,
                              size: 5,
                            ),
                            Text(
                                '  Budhanilkantha Temple',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                      SizedBox(height: 4,),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.circle,
                              size: 5,
                            ),
                            Text(
                                '  Ichangu Narayan & Bichangu Narayan in Kathmandu.',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}
