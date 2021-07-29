import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:trade_watch/Extras/Constants.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Extras/functions.dart';
import 'package:trade_watch/Screens/Auth/Login.dart';
import 'package:trade_watch/Widgets/MainButton.dart';

class EmailSent extends StatelessWidget {

  String email;

  EmailSent(this.email);

  late double height ,width;
  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: MediaQuery.of(context).padding,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: height * 0.025 , horizontal: width * 0.05),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email has\nbeen sent!',style: TextStyle(
                  fontFamily: 'psb',
                  fontSize: 28,
                ),),
                SizedBox(height: height * 0.01,),
                Text('Please check your inbox and click on the received link to reset a password',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'pr',
                      color: Colors.black
                  ),
                ),
                SizedBox(height: height * 0.07,),


                Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: Image(image: AssetImage('assets/images/ev.png'))
                ),

                SizedBox(height: height * 0.07,),



                CButton((){
                  // if(controller.text.length < 4){
                  //   Fluttertoast.showToast(msg: 'Invalid OTP' , backgroundColor: Colors.red , textColor: Colors.white);
                  //   return;
                  // }
                  // verifyotp();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx){
                    return Login();
                  }), (route) => false);
                },'Sign in'
                ),
                SizedBox(height: height * 0.03,),

                Align(
                  alignment: Alignment.center,
                  child: RichText(
                      text: TextSpan(
                        text: 'Didn’t receive the link? ',
                        style: TextStyle(
                          color: CColors.graytext,
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(
                              text: 'Resend',
                              style: TextStyle(
                                color: CColors.lightgreen,
                                fontFamily: 'pb',
                                fontSize: 18,
                              ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              sendreset(context, email);
                            },
                          ),
                        ]
                      ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future sendreset(BuildContext context, String email) async {

    Functions().showLoaderDialog(context , text: 'Sending Reset Link');
    String url = Constants.url + 'Auth/SendEmail';
    var body = email;

    print(url);
    final response = await post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
    print(response.body);
    print(response.statusCode);


    Navigator.of(context).pop();
    if(response.statusCode == 200){
      Fluttertoast.showToast(msg: 'Verification email sent', textColor: Colors.white, backgroundColor: Colors.green);
    }else if(response.statusCode == 400){
      Fluttertoast.showToast(msg: 'This image is not associated with any email', textColor: Colors.white, backgroundColor: Colors.red);
    }else{
      Fluttertoast.showToast(msg: 'Something went wrong', textColor: Colors.white, backgroundColor: Colors.red);
    }

  }

}
