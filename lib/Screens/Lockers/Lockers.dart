import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_watch/Extras/Constants.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Extras/functions.dart';
import 'package:trade_watch/Interfaces/compareinterface.dart';
import 'package:trade_watch/Model/CurrencyModel.dart';
import 'package:trade_watch/Model/ExchangeModel.dart';
import 'package:trade_watch/Screens/Lockers/Compare.dart';
import 'package:trade_watch/Screens/Lockers/Videos.dart';
import 'package:trade_watch/Screens/Lockers/Watchlist.dart';

import 'News.dart';

class Lockers extends StatefulWidget {
  int page;

  CurrencyProvider currencyProvider;
  ExchangeProvider exchangeProvider;

  List<CurrencyModel> dlist;
  int dindex;
  int typeindex;
  int currindex;
  Lockers(this.page, this.exchangeProvider , this.currencyProvider ,
      this.typeindex , this.currindex, this.dindex , this.dlist);

  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<Lockers> implements Compareinterface{
  int page = 0;
  SharedPreferences? sharedPreferences;


  initsp() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      token = sharedPreferences!.getString("token") ?? "";
      print(token);
    });
  }
  String? token;
  String txt1='';
  String txt2='';

  @override
  void initState() {
    elist = widget.exchangeProvider.list;
    typeindex = widget.typeindex;
    curindex = widget.currindex;
    dlist = widget.dlist;
    dindex = widget.dindex;

    setState(() {
      page = widget.page;
    });
    initsp();
    super.initState();
  }




  late double height , width;
  @override
  Widget build(BuildContext context) {

    if(clist.isEmpty) {
      clist = widget.currencyProvider.getdata(elist[typeindex].id);
    }


    if(elist[typeindex].name == "Stocks"){

      if(dlist.isEmpty) {
        Future.delayed(Duration(milliseconds: 10)).then((value) {
          getDriller(clist[curindex].fkId);
        });
      }
    }
    List<Widget> pages= [
      News(
          elist[typeindex].name == "Stocks" ?
          dlist.isEmpty ? "" : dlist[dindex].code : clist[curindex].code,
        elist[typeindex].name,
      ),
      Watchlist(),
      Compare(widget.currencyProvider, widget.exchangeProvider , typeindex , curindex, dindex, dlist, this),
      Videos(txt1: txt1,),
    ];
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: sharedPreferences == null ?
      Center(child: CircularProgressIndicator(),)
          :
      Container(
        padding: MediaQuery.of(context).padding,
        child: Container(
          padding: page != 2 ?EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.025)

          :
          EdgeInsets.zero,
          child: Column(
            children: [
              Container(
                padding: page == 2 ?EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.025)
                    :
                EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.arrow_back_sharp,
                            ),
                          ),
                          SizedBox(width: width * 0.03,),
                          deptdropdownwidgt(),
                        ],
                      ),
                    ),

                    Image(
                      image: AssetImage('assets/icons/Ic_Search.png'),
                      width: 24,
                    )
                  ],
                ),
              ),

              page != 2 ?
                  filter() : SizedBox(),
              Expanded(
                child: pages[page],
              ),
            ],
          ),
        ),
      ),
    );
  }
  List<String> sname= [
    "News",
    "Watchlist",
    "Compare",
    "Videos",
  ];
  Widget filter(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              typedropdownwidgt(),

              clist.length > 0 ?
              InkWell(
                onTap: (){
                  pairsheet(context);

                },
                child: Row(
                  children: [
                    Image(
                      image: NetworkImage(clist[curindex].iconName),
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(width: 3),
                    Container(
                      width: width * 0.28,
                      child: Text('${(clist)[curindex].name}' ,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'pm',
                            fontSize: 14
                        ),
                      ),
                    ),
                    ImageIcon(AssetImage('assets/icons/arrowdown.png')),
                  ],
                ),
              )
                  :
              SizedBox(),
            ],
          ),


          elist[typeindex].name == "Stocks" && dlist.length > 0?
          InkWell(
            onTap: (){
              drillsheet(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: height * 0.01),
              decoration: BoxDecoration(
                border: Border.all(color: CColors.graytext,width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image(
                    image: AssetImage('assets/icons/filter.png'),
                    width: 24,
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Text(dlist.length > 0 ? '${dlist[dindex].name}' : 'Driller' ,
                    style: TextStyle(
                        color: CColors.graytext,
                        fontFamily: 'pb',
                        fontSize: 10
                    ),
                  )
                ],
              ),
            ),
          )
              :
          SizedBox(),
        ],
      ),
    );
  }
  Widget deptdropdownwidgt() {
    return DropdownButton<String>(
      itemHeight: 60,
      icon: ImageIcon(AssetImage('assets/icons/arrowdown.png')),
      hint: Container(
        child: Text('${sname[page]} ' ,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'pb',
              fontSize: 36
          ),
        ),
      ),
      underline: SizedBox(),
      items: sname.map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (value) {

        setState((){
          page = getIndexpage(value!);
        });
      },
    );
  }

  int getIndexpage(String s){
    for(int i = 0 ; i < sname.length ; i ++){
      if(s == sname[i]){
        return i;
      }
    }
    return 0;
  }


  Widget typedropdownwidgt() {
    return DropdownButton<String>(

      icon: ImageIcon(AssetImage('assets/icons/arrowdown.png')),
      hint: Row(
        children: [
          Image(
            image: NetworkImage(elist[typeindex].image),
            width: 24,
            height: 24,
          ),
          SizedBox(width: 3),
          Container(
            width: width * 0.3,
            child: Text('${elist[typeindex].name}' ,
              maxLines: 1,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'pm',
                  fontSize: 14
              ),
            ),
          ),
        ],
      ),
      underline: SizedBox(),
      items: elist.map((value) {
        return new DropdownMenuItem<String>(
          value: value.name,
          child: Container(
              width: width * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value.name,

                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'pr',
                        fontSize: 12
                    ),
                  ),
                  Divider(),
                ],
              )
          ),
        );
      }).toList(),
      onChanged: (value) {
        int ti = getIndex(value!);
        txt1=elist[typeindex].name;
        print(txt1);
        print(ti);
        if(ti == typeindex){
          return;
        }
        // setState((){
          curindex = 0;
          typeindex = ti;
          getdata();
        // });
      },
    );
  }
  late int typeindex = 0  ;
  int curindex = 0;
  int getIndex(String s){
    for(int i = 0 ; i < elist.length ; i ++){
      if(s == elist[i].name){

        return i;
      }
    }
    return 0;
  }
  int cgetIndex(String s){
    for(int i = 0 ; i < clist.length ; i ++){
      if(s == clist[i].name){
        return i;
      }
    }
    return 0;
  }

  List<ExchangeModel> elist = [];
  List<CurrencyModel> clist = [];
  void pairsheet(BuildContext context){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25)),
      ),
      backgroundColor: Colors.white,
      builder: (ctx) => Container(
        height: height * 0.8,
        padding: EdgeInsets.symmetric(vertical: height * 0.03 , horizontal: width * 0.03),
        child: PairsSheet(),
      ),);
  }
  Widget PairsSheet(){
    var controller = TextEditingController();
    List<CurrencyModel> list2 = [];
    return StatefulBuilder(builder: (ctx , setState){
      print(controller.text);
      list2 = getslist(controller.text);
      return Column(
        children: [
          TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            onEditingComplete: (){
              setState((){});
            },
            decoration: InputDecoration(
                hintText: 'Search'
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx , i){
                return ListTile(
                  onTap: (){
                    Navigator.of(context).pop();
                    setcurr(list2[i].name);
                  },
                  leading: Image(image: NetworkImage(list2[i].iconName), width: 24,height: 24,),
                  title: Text(list2[i].name),
                );
              },
              itemCount: list2.length,
            ),
          )
        ],
      );
    });
  }
  List<CurrencyModel> getslist(String s){
    if(s.isEmpty){
      return clist;
    }else{
      List<CurrencyModel> l = [];
      for(int i = 0 ; i < clist.length ; i++){
        if(clist[i].name.toLowerCase().contains(s.toLowerCase())){
          l.add(clist[i]);
        }
      }
      return l;
    }
  }
  setcurr(String val){
    int ci = cgetIndex(val);

    if(curindex == ci){
      return;
    }
    setState((){
      curindex = ci;
    });


    if(elist[typeindex].name == "Stocks"){
      getDriller(clist[curindex].fkId);
    }
  }
  getdata() async{
    clist = await widget.currencyProvider.getdataa(elist[typeindex].id);

    if(elist[typeindex].name == "Stocks"){
      getDriller(clist[curindex].fkId);
    }
    setState(() {
    });
  }



  List<CurrencyModel> dlist = [];
  void getDriller(int id) async {
    dindex = 0;
    Functions().showLoaderDialog(context, text: 'Getting Data');
    String url = Constants.url + 'Eod/GetStockPairs?id=$id';
    print(url);
    final response = await post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);
    Navigator.of(context).pop();
    if(response.statusCode == 200){
      var result = jsonDecode(response.body)['res'];
      List<CurrencyModel> clist = [];
      for(var res in result){
        CurrencyModel model = CurrencyModel.fromJson(res);
        clist.add(model);
      }

      setState(() {
        dlist = clist;
      });
    }else{
      Fluttertoast.showToast(msg: 'Something went wrong', backgroundColor: Colors.red, textColor: Colors.white);
      throw("Error");
    }
  }
  void drillsheet(BuildContext context){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25)),
      ),
      backgroundColor: Colors.white,
      builder: (ctx) => Container(
        height: height * 0.8,
        padding: EdgeInsets.symmetric(vertical: height * 0.03 , horizontal: width * 0.03),
        child: DrillSheet(),
      ),);
  }
  Widget DrillSheet(){
    var controller = TextEditingController();
    List<CurrencyModel> list2 = [];
    return StatefulBuilder(builder: (ctx , setState){
      print(controller.text);
      list2 = getdlist(controller.text);
      return Column(
        children: [
          TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            onEditingComplete: (){
              setState((){});
            },
            decoration: InputDecoration(
                hintText: 'Search'
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx , i){
                return ListTile(
                  onTap: (){
                    Navigator.of(context).pop();
                    setd(list2[i].name);
                  },
                  leading: Image(image: NetworkImage(list2[i].iconName), width: 24,height: 24,),

                  title: Text(list2[i].name),
                );
              },
              itemCount: list2.length,
            ),
          )
        ],
      );
    });
  }
  List<CurrencyModel> getdlist(String s){
    if(s.isEmpty){
      return dlist;
    }else{
      List<CurrencyModel> l = [];
      for(int i = 0 ; i < dlist.length ; i++){
        if(dlist[i].name.toLowerCase().contains(s.toLowerCase())){
          l.add(dlist[i]);
        }
      }

      return l;
    }
  }
  setd(String val){
    int ci = dgetIndex(val);

    if(dindex == ci){
      return;
    }
    setState((){
      dindex = ci;
    });
  }
  int dindex = 0;
  int dgetIndex(String s){
    for(int i = 0 ; i < dlist.length ; i ++){
      if(s == dlist[i].name){
        return i;
      }
    }
    return 0;
  }

  @override
  void func(int page, List<CurrencyModel> clist, List<CurrencyModel> dlist, int dindex, int typeindex, int currindex) {
    setState(() {
      this.page = page;
      this.dlist = dlist;
      this.typeindex = typeindex;
      this.dindex = dindex;
      this.curindex = currindex;
      this.clist = clist;
    });
  }
}
