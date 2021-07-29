import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_watch/Extras/Constants.dart';
import 'package:trade_watch/Model/CurrencyModel.dart';
import 'package:trade_watch/Model/ExchangeModel.dart';
import 'package:trade_watch/Model/NewsModel.dart';
import 'package:trade_watch/Widgets/NewsWidget.dart';
import 'package:http/http.dart' as http;


class News extends StatefulWidget {

  String code , type;
  News(this.code, this.type);
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  late double height , width;

  @override
  void initState() {
    super.initState();
  }
  SharedPreferences? sharedPreferences;

  String code = "";
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    print('$code   ${widget.code}');
    if(code != widget.code){
      code = widget.code;
      getwebnews(code.replaceAll("-USD", ""));
    }

    return Container(
      child: Column(
        children: [
          Expanded(
              child:
              resp && !error?
                  nlist.isNotEmpty ?
                  newsdata(): Center(child: Text('No data found'))
                  :
              !resp && !error?
              Center(child: CircularProgressIndicator())
              :
              !resp && error?
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Something went wrong',style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'fm'
                    ),),

                    TextButton(
                      onPressed: (){
                        getNews(code);
                      },
                      child: Text('Retry',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'fm'
                          )
                      ),
                    )
                  ],
                ),
              )
              :
              SizedBox()
            ,
          ),
        ],
      ),
    );
  }

  ListView newsdata() {
    return ListView.builder(itemBuilder: (ctx, i){
      return Provider(
          create: (_)=>token,
          child: NewsWidget(nlist[i])
      );
      },itemCount: nlist.length,);
  }

  List<NewsModel> nlist = [];

  String token = '';

  getwebnews(String id) async{

    if(id.isEmpty){
      return;
    }
    nlist = [];
    setState(() {
      resp = false;
      error = false;
    });
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences!.getString("token") ?? '';
    String url;
    if(widget.type == "Stocks"){
      url = "https://stocknewsapi.com/api/v1?tickers=$id&items=25&token=jzivipd0hze0h3ui9ynkr8ilhufpogexhbsoatdi";
    }else if(widget.type == "Cryptocurrencies"){
      print(id);
      url = "https://cryptonews-api.com/api/v1?tickers=$id&items=25&token=u7zfvoclshl7rv9hemmw86rluywjhafjpb9hitxh";
    }else if(widget.type == "FOREX"){
      url = 'https://forexnewsapi.com/api/v1?currencypair=$id&items=25&token=jougxdqodasb7gn0furdnnbmgdijkyznqjezwo5n';
    }else{
      getNews(id);
      return;
    }
    print(url);
    final response = await http.get(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);

    if(response.statusCode == 200){
      var result = jsonDecode(response.body)['data'];
      nlist = [];
      for(var res in result){
        NewsModel model = NewsModel.fromJson(res);
        nlist.add(model);
      }

      getNews(id);
      // setState(() {
      //   resp = true;
      // });
    }else{
      setState(() {
        error = true;
      });
      Fluttertoast.showToast(msg: 'Something went wrong', backgroundColor: Colors.red, textColor: Colors.white);
    }
  }
  Future<void> getNews(String id) async {
    setState(() {
      resp = false;
      error = false;
    });
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences!.getString("token") ?? '';
    String url = Constants.url + 'News/StockNewsGet?fkCode=$id';
    print(url);
    final response = await http.get(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);

    if(response.statusCode == 200){
      var result = jsonDecode(response.body)['rss']['channel']['item'];
      print(result);
      for (var res in result) {
        NewsModel model = NewsModel.fromJson(res);
        model.type = 1;
        nlist.add(model);
      }
      try {
        // for (var res in result) {
        //   NewsModel model = NewsModel.fromJson(res);
        //   print(model.toJson());
        //   nlist.add(model);
        // }
      }catch(e){
        print(e);
      }
      setState(() {
        resp = true;
      });
    }else{
      if(nlist.length > 0){
        setState(() {});
        return;
      }
      setState(() {
        error = true;
      });
      Fluttertoast.showToast(msg: 'Something went wrong', backgroundColor: Colors.red, textColor: Colors.white);
    }
  }

  bool error = false;
  bool resp = false;
}
