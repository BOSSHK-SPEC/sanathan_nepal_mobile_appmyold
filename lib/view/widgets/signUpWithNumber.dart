import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';
import 'package:sanathan_nepal_mobile_app/view/helper/styles.dart';

import '../../dashboard/dashboard.dart';



class SignUpWithNumber {
  final TextEditingController usernameController = TextEditingController();
  List<String> otpValues = List.filled(6, '');

  void updateOtpValue(int index, String value) {
    otpValues[index] = value;
  }


  Future<void> showAlertDialog(context, ThemeProvider themeProvider) async {

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Container(
            decoration: BoxDecoration(
              color:themeProvider.tabBackground,
              borderRadius: BorderRadius.circular(18)
            ),
            width: 400,
            height: 272,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    IconButton(onPressed: (){
                      Navigator.of(context).pop();

                    }, icon: const Icon(Icons.cancel_outlined))
                  ],
                ),
                 Text('Enter your Mobile Number', style: TextStyles.heading()),
                Padding(
                  padding: const EdgeInsets.only(left: 22.0,right: 22,top: 18),
                  child:Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(50),
                      ],
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 15),
                        hintText: "Mobile number",
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),

                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Password can't be empty";
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

                      },
                    ),
                  ),
                ),
                const SizedBox(height: 14,),
                GestureDetector(
                  onTap: (){
                    showAlertDialogForExistingUser(context,themeProvider);
                  },
                  child: Container(
                    height: 46,
                    width: 261,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: themeProvider.gradient,
                    ),
                    child:  Center(child: Text('NEXT',style: TextStyle(color: themeProvider.whiteTextColor),)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16,right: 22),
                  child: Text('          You can login easily later using Your '
                      '\n           Personal Mobile Number and OTP.'
                      '\n               Dont need to remember PW.',style: TextStyle(fontSize: 12,color: Colors.grey)),
                ),
                const SizedBox(height: 12.0),

              ],
            ),
          ),
        );
      },
    );
  }
  Future<void> showAlertDialogForExistingUser(context, ThemeProvider themeProvider) async {
    final alertDialogHelper = SignUpWithNumber();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Container(
            decoration: BoxDecoration(
                color:themeProvider.tabBackground,
                borderRadius: BorderRadius.circular(18)
            ),
            width: 400,
            height: 322,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                 // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 170.0),
                      child: IconButton(onPressed: (){
                        alertDialogHelper.showAlertDialog(context,themeProvider);

                      }, icon: const Icon(Icons.arrow_back,)),
                    ),
                    IconButton(onPressed: (){
                      Navigator.of(context).pop();

                    }, icon: const Icon(Icons.cancel_outlined)),
                  ],
                ),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                    Text('Existing User', style: TextStyles.body()),
                const SizedBox(height: 33,),

                Text('Enter OTP', style: TextStyles.subheading()),
                const SizedBox(height: 6,),
                Text('Kritika Paudel', style: TextStyles.subheading(color: themeProvider.tabColor)),
                const SizedBox(height: 22,),
                 ],
               ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6, (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3.0),
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        onChanged: (value) {
                          updateOtpValue(index, value);
                          if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14.0),
                GestureDetector(
                  onTap: (){
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const DashBoard()),
                            (route) => false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0,right: 16),
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: themeProvider.gradient,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child:  Center(child: Text('Log In',style: TextStyle(color: themeProvider.whiteTextColor),)),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not Recieved any code ?',style: TextStyle(fontSize: 13,color: Colors.grey)),
                    TextButton(onPressed: (){}, child:  Text('Resend',style: TextStyle(color: themeProvider.tabColor,fontSize: 14),)),
                  ],
                ),


              ],
            ),
          ),
        );
      },
    );
  }
}

