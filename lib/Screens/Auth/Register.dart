import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_watch/Extras/Constants.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Extras/functions.dart';
import 'package:trade_watch/Screens/Auth/Otp.dart';
import 'package:trade_watch/Widgets/MainButton.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../main.dart';

class Register extends StatefulWidget {


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String code = "+1", country = "IN";

  late double height ,width;

  var ec = TextEditingController();

  var nc = TextEditingController();

  var pc = TextEditingController();

  var phc = TextEditingController();

  var rc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    if(instaloginflag){
      return instawidget();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: MediaQuery.of(context).padding,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: height * 0.025 , horizontal: width * 0.05),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text('Sign Up',style: TextStyle(
                  fontFamily: 'psb',
                  fontSize: 28,
                ),),
                SizedBox(height: height * 0.01,),
                Text('Let\'s join millions of traders in \nthe world.',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'pr',
                      color: Colors.black
                  ),
                ),
                SizedBox(height: height * 0.03,),

                Align(
                  child: Text('Sign Up with',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'pm',
                    color: Colors.black
                  ),),
                ),
                SizedBox(height: height * 0.03,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: GestureDetector(
                          onTap: (){
                            login(context);
                          },
                          child: Image(
                            width: width * 0.1,
                            image: AssetImage('assets/images/Google.png'),
                          )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.03),

                      child: GestureDetector(
                        onTap: (){
                          fblogin();
                        },
                        child: Image(
                            width: width * 0.1,
                            image: AssetImage('assets/images/Facebook.png')
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: GestureDetector(
                          onTap: (){
                            instalogin2();
                          },
                          child: Image(
                              width: width * 0.1,
                              image: AssetImage('assets/images/Instagram.png')
                          )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: GestureDetector(
                          onTap: (){
                            twitterlogin();
                          },
                          child: Image(
                              width: width * 0.1,
                              image: AssetImage('assets/images/Twitter.png')
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.03,),


                Row(
                  children: [
                    Expanded(child: Divider()),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width *0.03),
                        child: Text('Or',
                          style: TextStyle(
                            color: CColors.gray,
                            fontSize: 18,
                          ),
                        )
                    ),
                    Expanded(child: Divider()),
                  ],
                ),


                SizedBox(height: height * 0.03,),


                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: CColors.gray , width: 1),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: TextField(
                    controller: ec,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                        fontFamily: 'pr',
                        fontSize: 15,
                        color: CColors.textblack
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: (){
                      node.nextFocus();
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'youremail@email.com',
                        hintStyle: TextStyle(
                            fontFamily: 'pr',
                            color: CColors.gray
                        )
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01,),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: CColors.gray , width: 1),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: TextField(
                    controller: nc,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                        fontFamily: 'pr',
                        fontSize: 15,
                        color: CColors.textblack
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: (){
                      node.nextFocus();
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
                        hintStyle: TextStyle(
                            fontFamily: 'pr',
                            color: CColors.gray
                        )
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01,),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: CColors.gray , width: 1),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: pc,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: (){
                      node.nextFocus();
                    },
                    style: TextStyle(
                        fontFamily: 'pr',
                        fontSize: 15,
                        color: CColors.textblack
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            fontFamily: 'pr',
                            color: CColors.gray
                        )
                    ),
                    obscureText: true,
                  ),
                ),

                SizedBox(height: height * 0.03,),

                Text('Enter your mobile number, we\'ll send you an OTP to verify',
                  style: TextStyle(
                      color: CColors.textblack,
                      fontSize: 14,
                      fontFamily: 'pr'
                  ),
                ),

                SizedBox(height: height * 0.03,),

                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: CColors.gray , width: 1),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: CountryCodePicker(
                        initialSelection: country,
                        onChanged: (val){
                          code = val.dialCode!;
                          country = val.name!;
                          print(code);
                          print(country);
                        },
                        showFlagMain: false,
                      ),
                    ),


                    SizedBox(width: width * 0.03,),
                    Expanded(
                      child: Container(

                        decoration: BoxDecoration(
                            border: Border.all(color: CColors.gray , width: 1),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                        child: TextField(
                          controller: phc,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: (){
                            node.unfocus();
                          },
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                              fontFamily: 'pr',
                              fontSize: 15,
                              color: CColors.textblack
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Phone',
                              hintStyle: TextStyle(
                                  fontFamily: 'pr',
                                  color: CColors.gray
                              )
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

                SizedBox(height: height * 0.03,),

                Text('Referal Code',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'pm',
                    fontSize: 14,
                  ),
                ),

                SizedBox(height: height * 0.01,),

                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: CColors.gray , width: 1),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: TextField(
                    controller: rc,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: (){
                      node.unfocus();
                    },
                    style: TextStyle(
                        fontFamily: 'pr',
                        fontSize: 15,
                        color: CColors.textblack
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Optional',
                        hintStyle: TextStyle(
                            fontFamily: 'pr',
                            color: CColors.gray
                        )
                    ),
                  ),
                ),

                SizedBox(height: height * 0.02,),


                Row(
                  children: [
                    StatefulBuilder(builder: (ctx, setState){
                      return CustomCheckBox(
                        value: checked,
                        shouldShowBorder: true,
                        borderColor: CColors.gray,
                        checkedFillColor: CColors.primary,
                        borderRadius: 8,
                        borderWidth: 1,
                        checkBoxSize: 22,
                        onChanged: (val) {
                          //do your stuff here
                          setState(() {
                            checked = val;
                          });
                        },
                      );
                    }),

                    Expanded(
                        child: Text('I understand trade watch is not a financial advisor.',
                          style: TextStyle(
                            fontFamily: 'pr',
                            fontSize: 14,
                          ),
                        ),
                    )
                  ],
                ),

                SizedBox(height: height * 0.02,),

                CButton((){
                  if(validate()){
                    var d = {
                      'Name' : nc.text.trim(),
                      'Email': ec.text.trim(),
                      'Password': pc.text.trim(),
                      'LoginFrom': 'Custom',
                      'ReffralCode': rc.text.trim(),
                      'PhoneNo': '$code ${phc.text.trim()}',
                  };
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=> OTPScreen(d)));
                  }
                }, 'Sign Up'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validate(){
    if(nc.text.trim().isEmpty){
      Fluttertoast.showToast(msg: 'Fields can\'t be empty');
      return false;
    }else
    if(!EmailValidator.validate(ec.text.trim())){
      Fluttertoast.showToast(msg: 'Invalid Email');
      return false;
    }
    else if(pc.text.trim().isEmpty){
      Fluttertoast.showToast(msg: 'Fields can\'t be empty');
      return false;
    }else if(phc.text.trim().isEmpty){
      Fluttertoast.showToast(msg: 'Fields can\'t be empty');
      return false;
    } if(!checked){
      Fluttertoast.showToast(msg: "Please check \"I understand trade watch is not a financial advisor.\"");
      return false;
    }
    return true;
  }

  bool checked = false;

  final googleSignIn = GoogleSignIn();

  bool isSigningin = false;

  Future login(BuildContext context) async{
    isSigningin = true;
    final user = await googleSignIn.signIn();

    if(user == null){
      isSigningin = false;
    }else{
      print(user.id);

      signUpUsersocial(context, user.email, user.id, 'Google' , user.displayName ?? user.email.split("@")[0]);
      final googleAuth = await user.authentication;
    }
  }

  Map<String , dynamic> userobj = {};

  fblogin() async{

    final fb = FacebookLogin();
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (res.status) {
      case FacebookLoginStatus.success:
      // Logged in

      // Send access token to server for validation and auth
        final FacebookAccessToken accessToken = res.accessToken!;
        print('Access token: ${accessToken.token}');

        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile!.name}! You ID: ${profile.userId}');
        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');
        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null)
          print('And your email is $email');

        signUpUsersocial(context, email ?? "", profile.userId, "facebook", profile.name!);

        break;

      case FacebookLoginStatus.cancel:
        Fluttertoast.showToast(msg: "Login cancelled by user");

        break;
      case FacebookLoginStatus.error:
        Fluttertoast.showToast(msg: "Failed to login");
        print('Error while log in: ${res.error}');
        break;
    }
  }

  twitterlogin() async{
    Functions().showLoaderDialog(context, text: 'Loading');
    final twitterLogin = TwitterLogin(
      apiKey: 'HZMfawBPxNGE2vkTq51rn0XPn',
      apiSecretKey: 'i4dmb0YGuFiJjRP60WKtAdG0CT2EBgVI2NJgTcOorMWZa1vk8f',
      redirectURI: 'tradewatch://android',
    );
    final authResult = await twitterLogin.login();
    Navigator.of(context).pop();
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        var user = authResult.user;
        signUpUsersocial(context, user!.email, user.id.toString(), 'Twitter', user.name);
        break;
      case TwitterLoginStatus.cancelledByUser:
        print('cancel');
        break;
      case TwitterLoginStatus.error:
        print(authResult.errorMessage);
        break;
      case null:
        break;
    }
  }

  Future signUpUsersocial(BuildContext context , String email , String id , String type , String name) async {
    Functions().showLoaderDialog(context , text: 'Signing in');
    String url = Constants.url + 'Auth/Register';
    var body = {
      'UniqueId' : id,
      'Name' : name,
      'Email': email,
      'ReffralCode' : rc.text,
      'LoginFrom': type,
    };
    print(body);
    print(url);
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
    print(response.body);
    Navigator.of(context).pop();
    if(response.statusCode == 200){
      var convertedDatatoJson = jsonDecode(response.body);
      print(convertedDatatoJson);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', convertedDatatoJson['token']);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=> MyHomePage()), (route) => false);
    }else{
      Fluttertoast.showToast(msg: 'Something went wrong', textColor: Colors.red);
    }
  }

  int status = 0;

  late String appid, appsecret, initialuri, redirecteduri;

  instalogin2(){
    appid = "933067880607511";
    appsecret = "02d2ca0d8b3ba45f0286039fa4a6a370";
    redirecteduri = 'https://github.com/loydkim';
    initialuri = 'https://api.instagram.com/oauth/authorize?client_id=$appid&redirect_uri=$redirecteduri&scope=user_profile,user_media&response_type=code';
    setState(() {
      instaloginflag = true;
    });
  }
  int _stackIndex = 1;
  bool instaloginflag = false;
  Widget instawidget(){
    return WillPopScope(
      onWillPop: () {
        setState(() {
          instaloginflag = false;
        });
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body:Padding(
            padding: MediaQuery.of(context).padding,
            child: IndexedStack(
              index: _stackIndex,
              children: <Widget>[
                WebView(
                  initialUrl: initialuri,
                  navigationDelegate: (NavigationRequest request) {
                    print(request.url);
                    if(request.url.startsWith(redirecteduri)){
                      if(request.url.contains('error')) print('the url error');
                      var startIndex = request.url.indexOf('code=');
                      var endIndex = request.url.lastIndexOf('#');
                      var code = request.url.substring(startIndex + 5,endIndex);
                      _logIn(code);
                      print(code);
                      return NavigationDecision.prevent;
                    }
                    return NavigationDecision.navigate;
                  },
                  onPageStarted: (url) => print("Page started " + url),
                  javascriptMode: JavascriptMode.unrestricted,
                  gestureNavigationEnabled: true,
                  initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
                  onWebResourceError: (v){
                    print(v.description);
                  },
                  onPageFinished: (url) => setState(() => _stackIndex = 0),
                ),
                Center(child: Text('Loading open web page ...')),
                Center(child: Text('Creating Profile ...'))
              ],
            ),
          )
      ),
    );
  }

  Future<void>  _logIn(String code) async {
    setState(() => _stackIndex = 2);
    try {
      // Step 1. Get user's short token using facebook developers account information
      // Http post to Instagram access token URL.
      final http.Response response = await http.post(
          Uri.parse("https://api.instagram.com/oauth/access_token"),
          body: {
            "client_id": appid,
            "redirect_uri": redirecteduri,
            "client_secret": appsecret,
            "code": code,
            "grant_type": "authorization_code"
          });


      print(response.body);

      final http.Response responseLongAccessToken = await http.get(
          Uri.parse('https://graph.instagram.com/access_token?grant_type=ig_exchange_token&client_secret=$appsecret&access_token=${json.decode(response.body)['access_token']}')
      );
      final http.Response responseUserData = await http.get(
          Uri.parse('https://graph.instagram.com/${json.decode(response.body)['user_id'].toString()}?fields=id,username,account_type,media_count&access_token=${json.decode(responseLongAccessToken.body)['access_token']}')
      );
      print(responseUserData.body);
      setState(() {
        _stackIndex = 1;
        instaloginflag = false;
      });
      var _userData = json.decode(responseUserData.body);
      signUpUsersocial(context, "", _userData["id"], "Instagram", _userData["username"]);
    }catch(e) {
      print(e.toString());
    }
  }
}
