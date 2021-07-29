import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_watch/Extras/Constants.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:http/http.dart' as http;
import 'package:trade_watch/Extras/functions.dart';
import 'package:trade_watch/Screens/Dashboard/Dashboard.dart';
import 'package:trade_watch/Widgets/MainButton.dart';

import '../../main.dart';


class OTPScreen extends StatefulWidget {

  Map<String , dynamic> data;


  OTPScreen(this.data);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late double height ,width;

  @override
  void initState() {
    sendotp();
    super.initState();
  }
  late TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    controller = TextEditingController();

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: status == 0 ? Center(child: CircularProgressIndicator(),) :
      status == 1 ?
      Container(
        padding: MediaQuery.of(context).padding,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: height * 0.025 , horizontal: width * 0.05),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text('Verification\nCode',style: TextStyle(
                  fontFamily: 'psb',
                  fontSize: 28,
                ),),
                SizedBox(height: height * 0.01,),
                Text('Please enter verification code sent to your mobile',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'pr',
                      color: Colors.black
                  ),
                ),
                SizedBox(height: height * 0.03,),
                Text('Code is sent to ${widget.data['PhoneNo']}',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'pr',
                      color: CColors.gray
                  ),
                ),
                SizedBox(height: height * 0.04,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: Image(image: AssetImage('assets/images/otp.png'))
                ),

                SizedBox(height: height * 0.03,),

                PinCodeTextField(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  controller: controller,
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  length: 4,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldHeight: width * 0.13,
                    fieldWidth: width * 0.13,
                    activeColor: CColors.gray,
                    inactiveColor: CColors.gray,
                    borderWidth: 1,
                    borderRadius: BorderRadius.circular(15),
                    selectedColor: CColors.primary
                  ),
                  textStyle: TextStyle(
                      color: Colors.black
                  ),
                  // enableActiveFill: true,
                  cursorColor: Colors.transparent,
                  animationDuration: Duration(milliseconds: 100),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                    otp = value;
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    return true;
                  },
                ),

                CButton((){
                  print(otp);
                  print(controller.text);
                  if(otp.length < 4){
                    Fluttertoast.showToast(msg: 'Invalid OTP' , backgroundColor: Colors.red , textColor: Colors.white);
                    return;
                  }

                  // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Dashboard()));
                  verifyotp();
                },'Verify and Create Account'
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Didn\'t receive code?',
                      style: TextStyle(
                          color: CColors.gray,
                          fontFamily: 'pr',
                          fontSize: 18
                      ),
                    ),
                    TextButton(
                        onPressed: (){
                          sendotp();
                        },
                        child: Text('Request',
                          style: TextStyle(
                            color: CColors.lightgreen,
                            fontFamily: 'pb',
                            fontSize: 18
                          ),
                        )
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ) : Container(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Something went wrong.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'pr'
              ),
            ),

            TextButton(
                onPressed: (){
                  sendotp();
                },
                child: Text('Tap to retry',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'pm'
                ),
                )
            )
          ],
        ),
      ),
    );
  }

  Future sendotp() async {
    setState(() {
      status = 0;
    });
    String url = Constants.url + 'Auth/OTP';
    var body = widget.data['PhoneNo'];


    print(url);
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
    print(response.body);

    if(response.statusCode == 200){
      setState(() {
        status = 1;
      });
    }else if(response.statusCode == 400){
      Fluttertoast.showToast(msg: 'Phone number already registered', textColor: Colors.white, backgroundColor: Colors.red);
      Navigator.of(context).pop();
    }else{
      setState(() {
        status = 2;
      });
      Fluttertoast.showToast(msg: 'Something went wrong', textColor: Colors.white, backgroundColor: Colors.red);
    }

  }

  String otp = '';

  Future verifyotp() async {

    Functions().showLoaderDialog(context , text: 'Verifying');
    String url = Constants.url + 'Auth/OTPcheck';
    var body = {"number" : widget.data['PhoneNo'] , "otpCode" : otp};


    print(url);
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
    print(response.body);

    Navigator.of(context).pop();
    if(response.statusCode == 200){
      signUpUser(context);
    }else{
      Fluttertoast.showToast(msg: 'Something went wrong', textColor: Colors.white, backgroundColor: Colors.red);
    }

  }

  int status = 0;



  Future signUpUser(BuildContext context) async {
    Functions().showLoaderDialog(context , text: 'Creating Account');
    String url = Constants.url + 'Auth/Register';
    var body = widget.data;


    print(url);
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
    print(response.body);
    Navigator.of(context).pop();
    if(response.statusCode == 200){
      var convertedDatatoJson = jsonDecode(response.body);
      print(convertedDatatoJson);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', convertedDatatoJson['token']);
      print(convertedDatatoJson['token']);


      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=> MyHomePage()), (route) => false);
    }else if(response.statusCode == 400){
      Fluttertoast.showToast(msg: 'Email already registered', textColor: Colors.red);
    }else{
      Fluttertoast.showToast(msg: 'Something went wrong', textColor: Colors.red);
    }
  }
}
