import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_watch/Extras/Constants.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Extras/InstaLogin.dart';
import 'package:trade_watch/Extras/functions.dart';
import 'package:trade_watch/Screens/Auth/ForgotPassword.dart';
import 'package:trade_watch/Screens/Auth/Register.dart';
import 'package:trade_watch/Screens/Dashboard/Dashboard.dart';
import 'package:trade_watch/Widgets/MainButton.dart';
import 'package:twitter_login/twitter_login.dart';
// import 'package:twitter_login/twitter_login.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../main.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var epc = TextEditingController();

  var pc = TextEditingController();

  late double height ,width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    var node = FocusScope.of(context);
    if(instaloginflag){
      return instawidget();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: MediaQuery.of(context).padding,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: height * 0.025 , horizontal: width * 0.05),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sign in',style: TextStyle(
                  fontFamily: 'psb',
                  fontSize: 28,
                ),),
                SizedBox(height: height * 0.01,),
                RichText(
                    text: TextSpan(text: 'Welcome to ',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'pr',
                          color: Colors.black
                      ),
                      children: [
                        TextSpan(text: 'Trade Watch',style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'pm',
                            color: CColors.primary
                        ))
                      ]
                    )
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
                      node.nextFocus();
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email or Phone Number',
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
                    controller: pc,
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
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontFamily: 'pr',
                        color: CColors.gray
                      )
                    ),
                    obscureText: true,
                  ),
                ),

                SizedBox(height: height * 0.02,),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                        return ForgotPassword();
                      }));
                    }, child: Text('Forgot Password?', style: TextStyle(
                    color: CColors.lightgreen,
                    fontFamily: 'pm',
                    fontSize: 14,
                  ),),

                  ),
                ),

                SizedBox(height: height * 0.01,),


                CButton((){
                  if(epc.text.isEmpty){
                    Fluttertoast.showToast(msg: "Fields can't be empty");
                  }else if(pc.text.trim().isEmpty){
                    Fluttertoast.showToast(msg: "Fields can't be empty");
                  }else{
                    loginuser(context);
                  }
                  // Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                  //   return Dashboard();
                  // }));
                } , 'Sign in'),

                SizedBox(height: height * 0.02,),

                Align(
                  child: Text('or continue with',style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'pm'
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
                          fblogin(context);
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?',style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'pm',
                      fontSize: 16,
                    ),),
                    TextButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                          return Register();
                        }));
                      },
                      child: Text('Sign up',style: TextStyle(
                        fontFamily: 'pm',
                        fontSize: 16,
                      ),
                      ),
                    )
                  ],
                ),


                SizedBox(height: height * 0.05,),

                Text('By continuing, you are agreeing our Terms, Conditions & Services.',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'pr',
                      fontSize: 14
                  ),
                  textAlign: TextAlign.center,
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  final googleSignIn = GoogleSignIn();

  bool isSigningin = false;

  Future login(BuildContext context) async{

    // googleSignIn.signOut();
    // return;
    isSigningin = true;
    final user = await googleSignIn.signIn();

    if(user == null){
      isSigningin = false;
    }else{
      print(user.id);
      signUpUsersocial(context, user.email , user.id, 'Google' , user.displayName ?? user.email.split("@")[0]);
      final googleAuth = await user.authentication;
    }
  }

  Map<String , dynamic> userobj = {};

  fblogin(BuildContext context) async{
    // FacebookAuth.instance.login(
    //     permissions:["email" , "public_profile"]
    // ).then((value){
    //   print(value.status);
    //   FacebookAuth.instance.getUserData().then((userdata){
    //     userobj = userdata;
    //
    //     String email, name , id;
    //     email = userobj["email"];
    //     name = userobj["name"];
    //     id = userobj["id"];
    //     signUpUsersocial(context, email, id, "facebook", name);
    //     print(userobj);
    //   });
    // }).catchError((error){
    //   print(error.toString());
    // });




// Create an instance of FacebookLogin
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

  Future loginuser(BuildContext context) async {
    Functions().showLoaderDialog(context , text: 'Signing in');
    String url = Constants.url + 'Auth/login';
    var body = {
      'Email': epc.text.trim(),
      'Password': pc.text.trim(),
      'LoginFrom' : 'Custom'
    };

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
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=> MyHomePage()), (route) => false);

    }else if(response.statusCode == 400){
      Fluttertoast.showToast(msg: 'Invalid Credentials', textColor: Colors.white , backgroundColor: Colors.red);
    }else{
      Fluttertoast.showToast(msg: 'Something went wrong', textColor: Colors.white , backgroundColor: Colors.red);
    }
  }

  Future signUpUsersocial(BuildContext context , String email , String id , String type , String name) async {
    Functions().showLoaderDialog(context , text: 'Signing in');
    String url = Constants.url + 'Auth/Register';
    var body = {
      'UniqueId' : id,
      'Name' : name,
      'Email': email,
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
      await prefs.setString('token', convertedDatatoJson['token']);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=> MyHomePage()), (route) => false);
    }else{
      Fluttertoast.showToast(msg: 'Something went wrong', textColor: Colors.red);
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
