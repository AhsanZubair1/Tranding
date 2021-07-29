import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:trade_watch/Extras/Constants.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Extras/functions.dart';
import 'package:trade_watch/Screens/Auth/EmailSent.dart';
import 'package:trade_watch/Widgets/MainButton.dart';

class ForgotPassword extends StatelessWidget {

  var epc = TextEditingController();
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
                Text('Forgot your\nPassword?',style: TextStyle(
                  fontFamily: 'psb',
                  fontSize: 28,
                ),),
                SizedBox(height: height * 0.01,),
                Text('Enter your registered email below to receive password reset instruction',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'pr',
                      color: Colors.black
                  ),
                ),
                SizedBox(height: height * 0.03,),


                Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                    child: Image(image: AssetImage('assets/images/fp.png'))
                ),

                SizedBox(height: height * 0.05,),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: CColors.gray , width: 1),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: TextField(
                    controller: epc,
                    style: TextStyle(
                        fontFamily: 'pr',
                        fontSize: 15,
                        color: CColors.textblack
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: (){
                      // node.nextFocus();
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'youremail@gmail.com',
                        hintStyle: TextStyle(
                            fontFamily: 'pr',
                            color: CColors.gray
                        )
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03,),



                CButton((){

                  sendreset(context, epc.text);

                },'Send Reset Link'
                ),
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
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
        return EmailSent(email);
      }));
    }else if(response.statusCode == 400){
      Fluttertoast.showToast(msg: 'This image is not associated with any email', textColor: Colors.white, backgroundColor: Colors.red);
    }else{
      Fluttertoast.showToast(msg: 'Something went wrong', textColor: Colors.white, backgroundColor: Colors.red);
    }

  }

}
