import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:trade_watch/Alert/BaseAlert.dart';
import 'package:trade_watch/Extras/Constants.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Interfaces/ValueInterface.dart';
import 'package:trade_watch/Model/CurrencyModel.dart';
import 'package:trade_watch/Model/ExchangeModel.dart';
import 'package:trade_watch/Screens/Dashboard/Home.dart';
import 'package:trade_watch/Screens/Dashboard/Locker.dart';
import 'package:trade_watch/Screens/Dashboard/Settings.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> implements valueInterface{
  @override
  void initState() {
    getExchange();
    getCurrencies();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Home(this),
      Locker(ti),
      Settings(),
    ];
    if(responses == 2 && !error){
      return WillPopScope(
        onWillPop: () {
          if(Platform.isAndroid){
            var baseDialog = BaseAlertDialog(
                "Exit App",
                "Do you really want to exit app?", () async {
              SystemNavigator.pop(animated: true);

            }, (){
              Navigator.of(context).pop();
            },
                yes: "Yes",
                no: "No"
            );
            showDialog(context: context, builder: (BuildContext context) => baseDialog);
            return Future.value(false);
          }else{
            return Future.value(true);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: bottomnav(),
          body: Container(
            padding: MediaQuery.of(context).padding,
            child: MultiProvider(
                providers: [
                  Provider(create: (_)=>ExchangeProvider(elist)),
                  Provider(create: (_)=>CurrencyProvider(clist)),
                ],
                child: pages[_selectedpageindex]
            ),
          ),
        ),
      );
    }else if(error){
      return otherWidget(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Something went wrong',style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'fm'
              ),),

              TextButton(
                onPressed: (){
                  getExchange();
                },
                child: Text('Retry',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'fm'
                    )
                ),
              )
            ],
          )
      );
    }else{
      return otherWidget(CircularProgressIndicator());
    }

  }

  int _selectedpageindex = 0;
  void _selectpage(int index , {int ti = 0}){
    this.ti = ti;
    setState(() {
      _selectedpageindex = index;
    });
  }
  BottomNavigationBar bottomnav(){
    return BottomNavigationBar(
        elevation: 3,
        onTap: _selectpage,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedItemColor: CColors.primary,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedpageindex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/Home.png'),
              ),
            label: 'Home'
          ),

          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/Activity.png'),
              ),
              label: 'Locker'
          ),

          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/Setting.png'),
              ),
              label: 'Settings'
          ),
        ]
    );
  }

  int ti = 0;
  @override
  void func(i) {
    _selectpage(1 , ti: i);
  }
  List<ExchangeModel> elist =[];
  List<CurrencyModel> clist =[];
  Future<void> getExchange() async {
    setState(() {
      responses = 0;
      error = false;
    });
    String url = Constants.url + 'Eod/GetExchanges';

    final response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
    );
    print(response.body);

    if(response.statusCode == 200){
      responses = 1;
      var result = jsonDecode(response.body)['res'];
      elist = [];
      for(var res in result){
        try{
          print(res);
          ExchangeModel model = ExchangeModel.fromJson(res);
          print(model.toJson());
          elist.add(model);
        }catch(e){
          print(e);
        }

      }
      getCurrencies();
    }else{
      setState(() {
        error = true;
      });
      Fluttertoast.showToast(msg: 'Something went wrong', backgroundColor: Colors.red, textColor: Colors.white);
    }
  }
  Future<void> getCurrencies() async {
    String url = Constants.url + 'Eod/GetCodes';
    final response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
    );
    print(response.body);
    if(response.statusCode == 200){
      setState(() {
        responses = 2;
      });
      var result = jsonDecode(response.body)['res'];
      clist = [];
      for(var res in result){
        CurrencyModel model = CurrencyModel.fromJson(res);
        print(model.toJson());
        clist.add(model);
      }
      print(clist.length);
    }else{
      setState(() {
        error = true;
      });
      Fluttertoast.showToast(msg: 'Something went wrong', backgroundColor: Colors.red, textColor: Colors.white);
    }
  }

  int responses = 0;
  bool error = false;


  Widget otherWidget(Widget w){
    return Scaffold(
      body: Center(
          child: w
      ),
    );
  }
}
