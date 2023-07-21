import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enum/enum.dart';
import '../theme/theme_provider.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({Key? key}) : super(key: key);

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  Email email = Email.Onlyme;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text('EDIT YOUR DETAILS',style: TextStyle(fontSize: 14,color: themeProvider.tabUnSelectedLabelColor)),
          centerTitle: true,
          actions: [
            Image.asset('assets/images/cancel.png'),
          ],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text('Full Name',style:TextStyle(fontWeight: FontWeight.w500),),
                      Text('*',style: TextStyle(color: Colors.red),)
                    ],
                  ),
                  const SizedBox(height: 4,),
                  Container(
                    height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: themeProvider.bookAppointmentBackground,
                        border: Border.all(
                          color: themeProvider.corner!
                        )
                      ),
                      child: CupertinoTextFormFieldRow(
                        padding: const EdgeInsets.all(2),
                      )),
                  const SizedBox(height: 14,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Text('Email',style:TextStyle(fontWeight: FontWeight.w500),),
                          Text('*',style: TextStyle(color: Colors.red),),

                        ],
                      ),
                      Row(
                        children: [
                          const Text('View: ',style: TextStyle(fontSize: 11),),
                       Icon(Icons.radio_button_checked_sharp,color: themeProvider.tabColor,size: 12,),
                          const Text(' Only me   ',style: TextStyle(fontSize: 11)),
                          const Icon(Icons.radio_button_off,size: 12),
                          const Text(' Public',style: TextStyle(fontSize: 11)),
                       /*   Radio(
                            activeColor: themeProvider.tabColor,
                              value: Email.Onlyme, groupValue: email, onChanged: (Email? val){
                            setState(() {
                              email=val!;
                            });
                          }),
                          const Text("Onlyme"),
                          Radio(value: Email.Public, groupValue: email, onChanged: (Email? val){
                            setState(() {
                              email=val!;
                            });
                          }),
                          const Text("Public"),*/

                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 4,),
                  Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: themeProvider.bookAppointmentBackground,
                          border: Border.all(
                              color: themeProvider.corner!
                          )
                      ),
                      child: CupertinoTextFormFieldRow(
                        padding: const EdgeInsets.all(2),
                      )),
                  Row(
                    children: [
                      const SizedBox(height: 12,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12,),
                          const Text('Gender'),
                          const SizedBox(height: 4,),
                          Container(
                              height: 45,
                              width: 168,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: themeProvider.bookAppointmentBackground,
                                  border: Border.all(
                                      color: themeProvider.corner!
                                  )
                              ),
                              child: CupertinoTextFormFieldRow(
                                padding: const EdgeInsets.all(2),
                              )),


                        ],
                      ),
                      const SizedBox(width: 16,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12,),
                          const Text('Horoscope'),
                          const SizedBox(height: 4,),
                          Container(
                              height: 45,
                              width: 168,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: themeProvider.bookAppointmentBackground,
                                  border: Border.all(
                                      color: themeProvider.corner!
                                  )
                              ),
                              child: CupertinoTextFormFieldRow(
                                padding: const EdgeInsets.all(2),
                              )),


                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14,),
                  Row(
                    children: const [
                      Text('Religion',style:TextStyle(fontWeight: FontWeight.w500),),
                      Text('*',style: TextStyle(color: Colors.red),)
                    ],
                  ),
                  const SizedBox(height: 4,),
                  Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: themeProvider.bookAppointmentBackground,
                          border: Border.all(
                              color: themeProvider.corner!
                          )
                      ),
                      child: CupertinoTextFormFieldRow(
                        padding: const EdgeInsets.all(2),
                      )),
                  const SizedBox(height: 14,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Text('Current Address',style:TextStyle(fontWeight: FontWeight.w500),),
                          Text('*',style: TextStyle(color: Colors.red),),

                        ],
                      ),
                      Row(
                        children: [
                          const Text('View: ',style: TextStyle(fontSize: 11),),
                          Icon(Icons.radio_button_checked_sharp,color: themeProvider.tabColor,size: 12,),
                          const Text(' Only me   ',style: TextStyle(fontSize: 11)),
                          const Icon(Icons.radio_button_off,size: 12),
                          const Text(' Public',style: TextStyle(fontSize: 11)),
                          /*   Radio(
                            activeColor: themeProvider.tabColor,
                              value: Email.Onlyme, groupValue: email, onChanged: (Email? val){
                            setState(() {
                              email=val!;
                            });
                          }),
                          const Text("Onlyme"),
                          Radio(value: Email.Public, groupValue: email, onChanged: (Email? val){
                            setState(() {
                              email=val!;
                            });
                          }),
                          const Text("Public"),*/

                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 4,),
                  Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: themeProvider.bookAppointmentBackground,
                          border: Border.all(
                              color: themeProvider.corner!
                          )
                      ),
                      child: CupertinoTextFormFieldRow(
                        padding: const EdgeInsets.all(2),
                      )),
                  const SizedBox(height: 14,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Text('Phone Number',style:TextStyle(fontWeight: FontWeight.w500),),
                          Text('*',style: TextStyle(color: Colors.red),),

                        ],
                      ),
                      Row(
                        children: [
                          const Text('View: ',style: TextStyle(fontSize: 11),),
                          Icon(Icons.radio_button_checked_sharp,color: themeProvider.tabColor,size: 12,),
                          const Text(' Only me   ',style: TextStyle(fontSize: 11)),
                          const Icon(Icons.radio_button_off,size: 12),
                          const Text(' Public',style: TextStyle(fontSize: 11)),
                          /*   Radio(
                            activeColor: themeProvider.tabColor,
                              value: Email.Onlyme, groupValue: email, onChanged: (Email? val){
                            setState(() {
                              email=val!;
                            });
                          }),
                          const Text("Onlyme"),
                          Radio(value: Email.Public, groupValue: email, onChanged: (Email? val){
                            setState(() {
                              email=val!;
                            });
                          }),
                          const Text("Public"),*/

                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 4,),
                  Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: themeProvider.bookAppointmentBackground,
                          border: Border.all(
                              color: themeProvider.corner!
                          )
                      ),
                      child: CupertinoTextFormFieldRow(
                        padding: const EdgeInsets.all(2),
                      )),
                  const SizedBox(height: 14,),

                  Row(
                    children: const [
                      Text('Profile photo',style:TextStyle(fontWeight: FontWeight.w500),),
                      Text('*',style: TextStyle(color: Colors.red),)
                    ],
                  ),
                  const SizedBox(height: 4,),

                  Row(
                    children: [
                      Container(
                        height: 45,
                        width: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: themeProvider.bookAppointmentBackground,
                          border: Border.all(
                            color: themeProvider.corner!
                          )
                        ),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('    no files choosen'),
                        ),
                      ),
                      Container(
                        height: 45,
                        width: 72,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            gradient: themeProvider.appBar,
                            border: Border.all(
                                color: themeProvider.corner!
                            )
                        ),
                        child: const Center(
                          child: Icon(Icons.camera_alt,size: 18,),
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 14,),
                  Container(
                    height: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: themeProvider.gradient2
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text('*',style: TextStyle(color: Colors.red),),
                              Text('If you are married, we will remind you about your anniversary date',style: TextStyle(fontSize: 12),)
                            ],
                          ),
                          const SizedBox(height: 4,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('so that you can surprise your loved ones.',style: TextStyle(fontSize: 12)),
                              Text('*',style: TextStyle(color: Colors.red)),

                            ],
                          ),
                          const SizedBox(height: 22,),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Relationship Status',style:TextStyle(fontWeight: FontWeight.w500),),
                                Row(
                                  children: [
                                    const Text('View: ',style: TextStyle(fontSize: 11),),
                                    Icon(Icons.radio_button_checked_sharp,color: themeProvider.tabColor,size: 12,),
                                    const Text(' Only me   ',style: TextStyle(fontSize: 11)),
                                    const Icon(Icons.radio_button_off,size: 12),
                                    const Text(' Public',style: TextStyle(fontSize: 11)),
                                    /*   Radio(
                              activeColor: themeProvider.tabColor,
                                value: Email.Onlyme, groupValue: email, onChanged: (Email? val){
                              setState(() {
                                email=val!;
                              });
                            }),
                            const Text("Onlyme"),
                            Radio(value: Email.Public, groupValue: email, onChanged: (Email? val){
                              setState(() {
                                email=val!;
                              });
                            }),
                            const Text("Public"),*/

                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 14,),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                Icon(Icons.radio_button_checked_sharp,color: themeProvider.tabColor,size: 12,),
                                const Text(' Married  ',style: TextStyle(fontSize: 11)),
                                const Icon(Icons.radio_button_off,size: 12),
                                const Text(' Unmarried',style: TextStyle(fontSize: 11)),
                                /*   Radio(
                                activeColor: themeProvider.tabColor,
                                  value: Email.Onlyme, groupValue: email, onChanged: (Email? val){
                                setState(() {
                                  email=val!;
                                });
                              }),
                              const Text("Onlyme"),
                              Radio(value: Email.Public, groupValue: email, onChanged: (Email? val){
                                setState(() {
                                  email=val!;
                                });
                              }),
                              const Text("Public"),*/

                              ],
                            ),
                          ),
                          const SizedBox(height: 14,),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                const Text('Since',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                const SizedBox(width: 12,),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: themeProvider.bookAppointmentBackground,
                                    border: Border.all(
                                      color: themeProvider.corner!
                                    )
                                  ),
                                  height: 33,
                                  width: 84,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text('  Year'),
                                      Icon(Icons.arrow_drop_down_rounded)
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12,),

                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: themeProvider.bookAppointmentBackground,
                                      border: Border.all(
                                          color: themeProvider.corner!
                                      )
                                  ),
                                  height: 33,
                                  width: 84,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text('  Year'),
                                      Icon(Icons.arrow_drop_down_rounded)
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12,),


                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: themeProvider.bookAppointmentBackground,
                                      border: Border.all(
                                          color: themeProvider.corner!
                                      )
                                  ),
                                  height: 33,
                                  width: 84,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text('  Year'),
                                      Icon(Icons.arrow_drop_down_rounded)
                                    ],
                                  ),
                                )

                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Work Status',style:TextStyle(fontWeight: FontWeight.w500),),
                      Row(
                        children: [
                          const Text('View: ',style: TextStyle(fontSize: 11),),
                          Icon(Icons.radio_button_checked_sharp,color: themeProvider.tabColor,size: 12,),
                          const Text(' Only me   ',style: TextStyle(fontSize: 11)),
                          const Icon(Icons.radio_button_off,size: 12),
                          const Text(' Public',style: TextStyle(fontSize: 11)),
                          /*   Radio(
                            activeColor: themeProvider.tabColor,
                              value: Email.Onlyme, groupValue: email, onChanged: (Email? val){
                            setState(() {
                              email=val!;
                            });
                          }),
                          const Text("Onlyme"),
                          Radio(value: Email.Public, groupValue: email, onChanged: (Email? val){
                            setState(() {
                              email=val!;
                            });
                          }),
                          const Text("Public"),*/

                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 14,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.radio_button_checked_sharp,color: themeProvider.tabColor,size: 12,),
                        const Text('  Employed  ',style: TextStyle(fontSize: 11)),
                        const SizedBox(width: 4,),
                        const Icon(Icons.radio_button_off,size: 12),
                        const Text('  Unemployed',style: TextStyle(fontSize: 11)),
                        const SizedBox(width: 8,),
                        const Icon(Icons.radio_button_off,size: 12),
                        const Text('  Student',style: TextStyle(fontSize: 11)),
                        /*   Radio(
                                activeColor: themeProvider.tabColor,
                                  value: Email.Onlyme, groupValue: email, onChanged: (Email? val){
                                setState(() {
                                  email=val!;
                                });
                              }),
                              const Text("Onlyme"),
                              Radio(value: Email.Public, groupValue: email, onChanged: (Email? val){
                                setState(() {
                                  email=val!;
                                });
                              }),
                              const Text("Public"),*/

                      ],
                    ),
                  ),

                  const SizedBox(height: 22,),
                  Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: themeProvider.bookAppointmentBackground,
                          border: Border.all(
                              color: themeProvider.corner!
                          )
                      ),
                      child: CupertinoTextFormFieldRow(
                        padding: const EdgeInsets.all(2),
                      )),
                  const SizedBox(height: 14,),
                  Row(
                    children: [
                      const SizedBox(height: 12,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12,),
                          Container(
                              height: 45,
                              width: 168,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: themeProvider.bookAppointmentBackground,
                                  border: Border.all(
                                      color: themeProvider.corner!
                                  )
                              ),
                              child: CupertinoTextFormFieldRow(
                                padding: const EdgeInsets.all(2),
                              )),


                        ],
                      ),
                      const SizedBox(width: 16,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12,),
                          Container(
                              height: 45,
                              width: 168,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: themeProvider.bookAppointmentBackground,
                                  border: Border.all(
                                      color: themeProvider.corner!
                                  )
                              ),
                              child: CupertinoTextFormFieldRow(
                                padding: const EdgeInsets.all(2),
                              )),


                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14,),
                  Row(
                    children: const [
                      Icon(Icons.check_box_outline_blank,size: 18),
                      Text('  I am currently working in this role'),
                    ],
                  ),
                  const SizedBox(height: 14,),
                  Row(
                    children: [
                      const SizedBox(height: 12,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12,),
                          const Text('Start Date'),
                          const SizedBox(height: 4,),
                          Container(
                              height: 45,
                              width: 168,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: themeProvider.bookAppointmentBackground,
                                  border: Border.all(
                                      color: themeProvider.corner!
                                  )
                              ),
                              child: CupertinoTextFormFieldRow(
                                padding: const EdgeInsets.all(2),
                              )),


                        ],
                      ),
                      const SizedBox(width: 16,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12,),
                          const Text('End Date'),
                          const SizedBox(height: 4,),
                          Container(
                              height: 45,
                              width: 168,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: themeProvider.bookAppointmentBackground,
                                  border: Border.all(
                                      color: themeProvider.corner!
                                  )
                              ),
                              child: CupertinoTextFormFieldRow(
                                padding: const EdgeInsets.all(2),
                              )),


                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 33,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text('Make it Public '),
                          Icon(Icons.toggle_on_rounded,color: themeProvider.tabColor),
                        ],
                      ),
                      Container(
                        height: 22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            color: themeProvider.tabColor!,
                          )
                        ),
                        child: const Text('   Save   '),
                      )
                    ],
                  ),
                  const SizedBox(height: 4,),
                  const Divider(),
                  const SizedBox(height: 8,),
                  Row(
                    children: [
                      Icon(Icons.add_circle_outline,color: themeProvider.tabColor,size: 18),
                      Text('  Add new experience',style: TextStyle(color: themeProvider.tabColor),)
                    ],
                  ),
                  const SizedBox(height: 33,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: themeProvider.tabColor!
                          )
                        ),
                        child: const Center(child: Text('     Cancel      ')),
                      ),
                      Container(
                        height: 36,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            gradient: themeProvider.appointmentButtonColor,

                        ),
                        child:  Center(child: Text('        Update Profile        ',style: TextStyle(color: themeProvider.whiteTextColor)),),
                      )

                    ],
                  ),
                  const SizedBox(height: 22,),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
