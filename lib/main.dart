import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_watch/Screens/Auth/Login.dart';
import 'package:trade_watch/Screens/Dashboard/Dashboard.dart';

import 'Extras/CustomColors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [
        Locale("en"),
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
      ],
      title: 'Trade Watch',
      theme: ThemeData(
        fontFamily: 'pr',
        primarySwatch: MaterialColor(CColors.primary.value, CColors.getSwatch(CColors.primary)),
      ),
      home: Splash(),
    );
  }
}
class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    Future.delayed(Duration(seconds: 2)).then((value){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
        return MyHomePage();
      }));
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Image(
            image: AssetImage('assets/images/logo.png'),
            width: w * .7,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferences? sharedPreferences;
  @override
  void initState() {
    SharedPreferences.getInstance().then((value){
      setState(() {
        sharedPreferences = value;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(sharedPreferences == null){
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }else{
      // sharedPreferences!.remove("token");

      String token = sharedPreferences!.getString("token") ?? '';
      if(token == ''){
        return Login();
      }else{
        return Dashboard();
      }
    }
  }
}

