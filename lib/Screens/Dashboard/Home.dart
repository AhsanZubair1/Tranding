import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:trade_watch/Extras/Constants.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Interfaces/ValueInterface.dart';
import 'package:trade_watch/Model/ExchangeModel.dart';
import 'package:trade_watch/Model/NewsModel.dart';
import 'package:trade_watch/Model/TrendingModel.dart';
import 'package:trade_watch/Screens/Dashboard/TrendingScreen.dart';
import 'package:trade_watch/Widgets/TopNewsWidget.dart';
import 'package:trade_watch/Widgets/TrendingWidget.dart';

class Home extends StatefulWidget {

  valueInterface interface;

  Home(this.interface);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var search = TextEditingController();

  late double height ,width;

  ExchangeProvider? _exchangeProvider;
  @override
  void initState() {

    gettstocks();
    gettcrypto();
     gettforex();
     gettcommodity();

    getNews();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(_exchangeProvider == null){
      _exchangeProvider = Provider.of<ExchangeProvider>(context);
    }
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            searchBar(),
            SizedBox(height: height * 0.01,),

            Container(
              height: 340,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx , i){
                  if(i == 0){
                    return toptrendingcardn();
                  }
                  return TopNewsWidget(nlist[i - 1]);
                },
                itemCount: nlist.length + 1,
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05,vertical: height * 0.01),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Categories',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'pb',
                          fontSize: 24
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.01,),

                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                            onTap: (){
                              int t = getindex("Stocks");
                              print(t);
                              widget.interface.func(t);
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image(
                                    image: AssetImage('assets/images/stocks.png'),
                                  ),
                                ),

                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(25),
                                          bottomLeft: Radius.circular(25),
                                        ),
                                      ),
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text('Stocks',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'pm',
                                          fontSize: 14
                                        ),
                                      ),
                                    )
                                ),

                              ],
                            ),
                          )
                      ),
                      SizedBox(width: width * 0.03,),
                      Expanded(
                          child: GestureDetector(
                            onTap: (){
                              int t = getindex("Cryptocurrencies");
                              print(t);
                              widget.interface.func(t);
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image(
                                    image: AssetImage('assets/images/crypto.png'),
                                  ),
                                ),

                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(25),
                                          bottomLeft: Radius.circular(25),
                                        ),
                                      ),
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text('Crypto',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'pm',
                                            fontSize: 14
                                        ),
                                      ),
                                    )
                                ),

                              ],
                            ),
                          )
                      ),

                    ],
                  ),
                  SizedBox(height: width * 0.03,),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                            onTap: (){
                              int t = getindex("Commodities");
                              print(t);
                              widget.interface.func(t);
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image(
                                    image: AssetImage('assets/images/comodity.png'),
                                  ),
                                ),

                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(25),
                                          bottomLeft: Radius.circular(25),
                                        ),
                                      ),
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text('Commodity',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'pm',
                                            fontSize: 14
                                        ),
                                      ),
                                    )
                                ),

                              ],
                            ),
                          )
                      ),
                      SizedBox(width: width * 0.03,),
                      Expanded(
                          child: GestureDetector(
                            onTap: (){
                              int t = getindex("FOREX");
                              print(t);
                              widget.interface.func(t);
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image(
                                    image: AssetImage('assets/images/forex.png'),
                                  ),
                                ),

                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(25),
                                          bottomLeft: Radius.circular(25),
                                        ),
                                      ),
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text('Forex',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'pm',
                                            fontSize: 14
                                        ),
                                      ),
                                    )
                                ),

                              ],
                            ),
                          )
                      ),

                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget toptrendingcard() {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Card(
        shadowColor: Colors.grey.shade200,
        elevation: height * 0.01,
        margin: EdgeInsets.symmetric(vertical: 15,),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: 15),
                child: Text('Top Trending',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'pb',
                  ),
                ),
              ),
              Expanded(
                child: error ?
                Center(child: Text('Something went wrong')):
                tlist.length == 0 ?
                Center(child: CircularProgressIndicator())
                    :
                Column(
                  children: [
                    Expanded(
                      child: Container(

                        child: Hero(
                          tag: 'trending',

                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (ctx,i){
                              TrendingHelper model;
                              if(i < tlist.length){
                                model = tlist[i];
                              }else{
                                model = tlist.last;
                              }
                              if(i == 3){
                                return Container();
                              }
                              return Container();
                            },
                            itemCount: 4,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: (){
                          _openCustomDialog(context);
                          // Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                          //   return TrendingScreen(tlist);
                          // }));
                        },
                        child: Image(
                          image: AssetImage('assets/images/more.png'),
                          width: 40,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget toptrendingcardn() {

    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Card(
        shadowColor: Colors.grey.shade200,
        elevation: height * 0.01,
        margin: EdgeInsets.symmetric(vertical: 15,),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: width * 0.04,
                    right: width * 0.04,
                    top: 15),
                child: Text('Top Trending',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'pb',
                  ),
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 4,
                  initialIndex: 0,
                  child: Container(
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: true,
                          indicatorWeight: 3,

                          indicatorColor: CColors.primary,
                          tabs: [
                            Tab(
                                child: Text('Stocks',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'pm',
                                    color: Colors.black,
                                  ),
                                )
                            ),
                            Tab(
                              child: Text('Crypto',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'pm',
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Forex',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'pm',
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Commodity',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'pm',
                                  color: Colors.black,
                                ),
                              ),
                            ),

                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              ttdata(stocks , 0),
                              ttdata(crypto , 1),
                              ttdata(forex, 2),
                              ttdata(commodity, 3),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TrendingHelper2? stocks , crypto, forex, commodity;
  Widget ttdata(TrendingHelper2? model , int i){
    // if(i == 3){
    //   return Center(
    //     child: Text('Not implemented yet'),
    //   );
    // }
    if(model == null || model.res == 0 ){
      return Center(
        child: CircularProgressIndicator(),
      );
    }else if(model.res == 2){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Something went wrong',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'pm',
            ),
          ),

          TextButton(
              onPressed: (){
                if(i == 0){
                  gettstocks();
                }else if(i == 1){
                  gettcrypto();
                }else if(i == 2){
                  gettforex();
                }else if(i == 3){
                  gettcommodity();
                }
              },
              child: Text('Retry')
          )
        ],
      );
    }
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.zero,
          itemBuilder: (ctx, i){
            return TrendingWidget(model.list[i]);
          },
        itemCount: model.list.length,
      ),
    );
  }

  Widget searchBar(){
    return Padding(
      padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05 , top: height * 0.025),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03 , vertical: height * 0.01),
        decoration: BoxDecoration(
          color: CColors.offwhite,
          borderRadius: BorderRadius.circular(30)
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                width: 24,
                child: Image(image: AssetImage('assets/icons/Ic_Search.png'))
            ),
            Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search here',
                    hintStyle: TextStyle(
                      color: CColors.graytext,
                      fontSize: 14,
                      fontFamily: 'pr'
                    )
                  ),
                )
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.03),
              width: 24,
                child: Image(image: AssetImage('assets/icons/Voice.png'))
            ),
          ],
        ),
      ),
    );
  }

  List<TrendingHelper> tlist = [];

  bool error = false;
  Future<void> getTrendings() async {
    error = false;
    String url = Constants.url + 'Eod/GetRealTimeData';
    final response = await http.get(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);
    if(response.statusCode == 200){
      var result = jsonDecode(response.body)['res']['result'];
      tlist = [];
      TrendingHelper? th = TrendingHelper();
      TrendingHelper? th2 = TrendingHelper();
      th2.code = 'test';
      tlist.add(th2);
      for(var res in result){
        TrendingModel model = TrendingModel.fromJson(res);
        if(th!.code == null){
          th.code = model.code;
        }
        if(th.code == model.code){
          th.list.add(model);
          th.clist.add(model.close);
        } else{
          tlist.add(th);
          th = TrendingHelper();
          if(th.code == null) {
            th.code = model.code;
          }
          th.list.add(model);
          th.clist.add(model.close);
        }
      }
      tlist.add(th!);
      tlist.removeAt(0);

      setState(() {

      });


    }else{
      setState(() {
        error = true;
      });
      Fluttertoast.showToast(msg: 'Something went wrong', backgroundColor: Colors.red, textColor: Colors.white);
    }
  }

  int getindex(String t){
    if(_exchangeProvider == null){
      return 0;
    }
    var l = _exchangeProvider!.list;
    for(int i =0 ; i < l.length ; i++){
      if(l[i].name == t){
        return i;
      }
    }
    return 0;
  }
  void _openCustomDialog(BuildContext context) {
    showGeneralDialog(barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),

                content: Container(
                  width: width * 0.9,
                    height: height * 0.7,
                    child: TrendingScreen(tlist)
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2)
        {
          return Container();
        }
    );
  }

  getNews(){
    var pairs = [
      {
        'type' : 'sn' ,
        'id' : 'NFLX',
      },
      {
        'type' : 'sn' ,
        'id' : 'GME',
      },
      {
        'type' : 'sn' ,
        'id' : 'TTM',
      },
      {
        'type' : 'cry' ,
        'id' : 'BTC',
      },
      {
        'type' : 'cry' ,
        'id' : 'Dodge',
      },
      {
        'type' : 'cry' ,
        'id' : 'ETH',
      },
      {
        'type' : 'for' ,
        'id' : 'NZD/USD',
      },
      {
        'type' : 'for' ,
        'id' : 'EUR/USD',
      },
      {
        'type' : 'for' ,
        'id' : 'GBP/USD',
      },
      {
        'type' : 'for' ,
        'id' : 'USD/JPY',
      },
    ];

    nlist.clear();

    pairs.forEach((element) {
      getwebnews(element);
    });
  }
  String token = "";
  List<NewsModel> nlist = [];
  getwebnews(Map<String , dynamic> d) async{

    String url;
    if(d['type'] == "sn"){
      url = "https://stocknewsapi.com/api/v1?tickers=${d["id"]}&items=1&token=jzivipd0hze0h3ui9ynkr8ilhufpogexhbsoatdi";
    }else if(d['type'] == "cry"){

      url = "https://cryptonews-api.com/api/v1?tickers=${d["id"]}&items=1&token=u7zfvoclshl7rv9hemmw86rluywjhafjpb9hitxh";
    }else if(d['type'] == "for"){
      url = 'https://forexnewsapi.com/api/v1?currencypair=${d["id"]}&items=1&token=jougxdqodasb7gn0furdnnbmgdijkyznqjezwo5n';
    }else{
      return;
    }
    print(url);
    final response = await http.get(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);

    if(response.statusCode == 200){
      var result = jsonDecode(response.body)['data'];
      for(var res in result){
        print(res);
        NewsModel model = NewsModel.fromJson(res);
        nlist.add(model);
      }
      setState(() {});
    }else{
      setState(() {
        error = true;
      });
      Fluttertoast.showToast(msg: 'Something went wrong', backgroundColor: Colors.red, textColor: Colors.white);
    }
  }



  Future<void> gettstocks() async {
    stocks = TrendingHelper2();
    stocks!.res != 0;
    setState(() {});
    String url = Constants.url + 'Eod/NSEGetRealTimeData';
    final response = await http.get(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );
    print(response.body );


    if(response.statusCode == 200){
      var result = jsonDecode(response.body)['res'];
      List<TrendingModel> tlist = [];
      for(var res in result){
        TrendingModel model = TrendingModel.fromJson(res);
        tlist.add(model);
      }
      setState(() {
        stocks!.res = 1;
        stocks!.list = tlist;
      });
    }else{
      setState(() {
        stocks!.res = 2;
      });
      Fluttertoast.showToast(msg: 'Something went wrong', backgroundColor: Colors.red, textColor: Colors.white);
    }
  }
  Future<void> gettcrypto() async {
    crypto = TrendingHelper2();
    crypto!.res = 0;
    setState(() {});
    String url = Constants.url + 'Eod/CCGetRealTimeData';
    final response = await http.get(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);
    if(response.statusCode == 200){
      var result = jsonDecode(response.body)['res'];
      List<TrendingModel> tlist = [];
      for(var res in result){
        TrendingModel model = TrendingModel.fromJson(res);
        tlist.add(model);
      }
      setState(() {
        crypto!.res = 1;
        crypto!.list = tlist;
      });
    }else{
      setState(() {
        crypto!.res = 2;
      });
      Fluttertoast.showToast(msg: 'Something went wrong', backgroundColor: Colors.red, textColor: Colors.white);
    }
  }
  Future<void> gettforex() async {
    forex = TrendingHelper2();
    forex!.res = 0;
    setState(() {});
    String url = Constants.url + 'Eod/ForexGetRealTimeData';
    final response = await http.get(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);

    if(response.statusCode == 200){
      var result = jsonDecode(response.body)['res'];
      List<TrendingModel> tlist = [];
      for(var res in result){
        TrendingModel model = TrendingModel.fromJson(res);
        tlist.add(model);
      }
      setState(() {
        forex!.res = 1;
        forex!.list = tlist;
      });
    }else{
      setState(() {
        forex!.res = 2;
      });
      Fluttertoast.showToast(msg: 'Something went wrong', backgroundColor: Colors.red, textColor: Colors.white);
    }
  }
  Future<void> gettcommodity() async {
    commodity = TrendingHelper2();
    commodity!.res = 0;
    setState(() {});
    String url = Constants.url + 'Eod/CommGetRealTimeData';
    final response = await http.get(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);

    if(response.statusCode == 200){
      var result = jsonDecode(response.body)['res'];
      List<TrendingModel> tlist = [];
      for(var res in result){
        TrendingModel model = TrendingModel.fromJson(res);
        tlist.add(model);
      }
      setState(() {
        commodity!.res = 1;
        commodity!.list = tlist;
      });
    }else{
      setState(() {
        commodity!.res = 2;
      });
      Fluttertoast.showToast(msg: 'Something went wrong', backgroundColor: Colors.red, textColor: Colors.white);
    }
  }

}


