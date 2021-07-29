import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_watch/Alert/BaseAlert.dart';
import 'package:trade_watch/Extras/Constants.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Extras/functions.dart';
import 'package:trade_watch/Model/Profile.dart';
import 'package:trade_watch/Widgets/Bottomsheat.dart';
import 'package:trade_watch/Widgets/MainButton.dart';
import 'package:trade_watch/main.dart';
import 'package:http/http.dart'as https;
import 'dart:convert';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late double height, width;
  String ?token = '';
  String tok='';


  Res? model;
 // ProfileModel model;

  String? Ahs="";
  String Ahss='';
  bool edit=false;
  List<String> phone = [];
// Ahs=  model?.name;
  getname(){
   Ahss =Ahs??"".toString();
   print(Ahss);
    String get=Ahss[0];

    int idx=Ahss.indexOf(" ");
    String get2=Ahss[idx+1];
    Ahss=get+get2;
  }
  getmail(){
    if((Ahs ?? "").contains("@")){
      phone = Ahs.toString().split("@");
      Ahss = phone[0];
      Ahs=Ahss;
    }

  }


  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((_) async {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();

      token = await sharedPreferences.getString("token");
      Future.delayed(Duration(microseconds: 10)).then((value){
        print(token);

        getprofile(token);
      });

    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    height = MediaQuery
        .of(context)
        .size
        .height;
    width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.zero,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: height * 0.025),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Settings',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                                fontFamily: 'pb'
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: width * 0.05,),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(Ahs.toString(),
                                            style: TextStyle(
                                                fontFamily: 'pb',
                                                fontSize: 20,
                                                color: Colors.black
                                            ),
                                          ),
                                          Row(
                                            children: [

                                              Text('Edit Profile  ',
                                                style: TextStyle(
                                                    color: CColors.primary,
                                                    fontSize: 14,
                                                    fontFamily: 'pm'
                                                ),
                                              ),

                                              GestureDetector(
                                                onTap: (){
                                                  setState(() {
                                                    pairsheet(context);
                                                  });
                                                },
                                                child: Image(
                                                  image: AssetImage(
                                                      'assets/icons/edit.png'
                                                  ),
                                                  width: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      Row(

                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/icons/invite.png'
                                            ),
                                            width: 35,
                                          ),
                                          SizedBox(width: width * 0.03,),
                                          Text('invite friends',
                                            style: TextStyle(
                                                color: CColors.primary,
                                                fontFamily: "pm",
                                                fontSize: 14

                                            ),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                )
                            ),
                            Column(
                              children: [
                                Container(
                                  width: width * 0.3,
                                  height: width * 0.3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: model?.image.toString()!=null?Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color:  CColors.graytext.withOpacity(0.3)),
                                        padding: EdgeInsets.all(10),
                                        child: Center(
                                          child:Text(Ahss.toString(),style: TextStyle(
                                              color: Colors.green,fontFamily: "pb",fontSize: 60),),
                                        ),
                                      ),
                                    ):Image(
                                      image: NetworkImage(
                                          model!.image.toString()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * 0.01,),
                                InkWell(
                                  onTap: () {
                                    logout(context);
                                  },
                                  child: Row(
                                    children: [
                                      ImageIcon(
                                        AssetImage('assets/icons/logout.png'),
                                        color: CColors.graytext,),
                                      SizedBox(width: width * 0.02,),
                                      Text('Logout', style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'pm',
                                          color: CColors.graytext
                                      ),)
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.025),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Language',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14
                              ),
                            ),
                            Text('English',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'psb',
                              ),
                            )
                          ],
                        ),

                        Container(
                            width: width * 0.3,
                            child: CButton(() {

                            }, 'Change')
                        ),

                      ],
                    ),


                    Container(
                        padding: EdgeInsets.symmetric(vertical: height * 0.02),
                        child: Divider()
                    ),

                    Text('Wallet',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'psb',
                      ),
                    ),

                    Container(
                        padding: EdgeInsets.symmetric(vertical: height * 0.02),
                        child: Divider()
                    ),

                    Text('My Activity',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'psb',
                      ),
                    ),

                    Container(
                        padding: EdgeInsets.symmetric(vertical: height * 0.02),
                        child: Divider()
                    ),

                    Text('Refferal Code',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'psb',
                      ),
                    ),

                    Container(
                        padding: EdgeInsets.symmetric(vertical: height * 0.02),
                        child: Divider()
                    ),

                    Text('Contact Support',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'psb',
                      ),
                    ),

                    Container(
                        padding: EdgeInsets.symmetric(vertical: height * 0.02),
                        child: Divider()
                    ),

                    Text('Terms of Service',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'psb',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void logout(BuildContext context) {
    var baseDialog = BaseAlertDialog(
        "Logout",
        "Do you really want to logout?", () async {
      Navigator.of(context).pop();
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      sharedPreferences.remove("token");

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx) {
            return MyHomePage();
          }), (route) => false);
    }, () {
      Navigator.of(context).pop();
    },
        yes: "Yes",
        no: "No"
    );
    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  Future getprofile(String? tok) async {
   // Functions().showLoaderDialog(context);
    String url = Constants.url + 'Profile/GetProfile';
    final response = await https.get(Uri.parse(url),
      headers: {"Content-Type": "application/json",
        "Authorization": "Bearer $tok"
      },
    );


    if(response.statusCode==200){
      var result=jsonDecode(response.body)['res'];
      print(result);
      setState(() {
        model=Res.fromJson(result);

        Ahs=model?.name;
       if(Ahs.toString().isNotEmpty) {getname();}
       else{
         Ahs=model?.email;
         getmail();

       }
       tok=tok;
      });




     // model=CupertinoIcons.profile_circled

    }
    else{

    }
      // var result =  jsonDecode(response.body);



  }

  void pairsheet(BuildContext context){
    print(token.toString()+"nncfnjnfjncj");
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25)),
      ),
      backgroundColor: Colors.white,
      builder: (ctx) => Container(
        //height: height * 0.8,
        padding: EdgeInsets.symmetric(vertical: height * 0.03 , horizontal: width * 0.03),

        child: BottomSheat(model: model,header: token.toString(),),
      ),);
  }
}
