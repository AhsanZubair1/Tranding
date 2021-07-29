import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:trade_watch/Extras/Constants.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Extras/functions.dart';
import 'package:trade_watch/Model/CurrencyModel.dart';
import 'package:trade_watch/Model/ExchangeModel.dart';
import 'package:trade_watch/Screens/Lockers/BrokerPage.dart';
import 'package:trade_watch/Screens/Lockers/ForumSurvey.dart';
import 'package:trade_watch/Screens/Lockers/Lockers.dart';

class Locker extends StatefulWidget {


  @override
  _LockerState createState() => _LockerState();

  late int typeindex ;
  Locker(this.typeindex);
}

class _LockerState extends State<Locker> {
  late double height , width;
  var nc = TextEditingController();
  String videotype='';
  String videotype2='';
  ExchangeProvider? _exchangeProvider;
  CurrencyProvider? _currencyProvider;

  @override
  void initState() {
    typeindex = widget.typeindex;
    super.initState();
  }
  bool seach=false;
  @override
  Widget build(BuildContext context) {
    Widget showFeild(){
      return  Container(
        width: width*0.75,
        height: height*0.06,
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

          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(
                  fontFamily: 'pr',
                  color: CColors.gray
              )
          ),
        ),
      );
    }
    if(_exchangeProvider == null){
      _exchangeProvider = Provider.of<ExchangeProvider>(context);
      elist = _exchangeProvider!.getData();
    }
    if(_currencyProvider == null){
      _currencyProvider = Provider.of<CurrencyProvider>(context);
    }
    if(clist.isEmpty) {
      clist = _currencyProvider!.getdata(elist[typeindex].id);
    }
    if(elist[typeindex].name == "Stocks" && dlist.isEmpty){
      Future.delayed(Duration(milliseconds: 10)).then((value){
        getDriller(clist[curindex].fkId);
      });
    }
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.025),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Locker',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontFamily: 'pb'
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    setState(() {
                      seach=!seach;
                    });

                  },
                  child: Image(
                      image: AssetImage('assets/icons/Ic_Search.png'),
                    width: 24,
                  ),
                )
              ],
            ),
            filter(),
            SizedBox(height: width * 0.05,),
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                      onTap: (){
                        gonext(0);
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image(
                              image: AssetImage('assets/images/news.png'),
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
                                height: 70,
                                alignment: Alignment.center,
                                child: Text('News',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'pm',
                                      fontSize: 16
                                  ),
                                ),
                              )
                          ),

                        ],
                      ),
                    )
                ),
                SizedBox(width: width * 0.05,),
                Expanded(
                    child: GestureDetector(
                      onTap: (){
                        gonext(1);
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image(
                              image: AssetImage('assets/images/watchlist.png'),
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
                                height: 70,
                                alignment: Alignment.center,
                                child: Text('Watchlist',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'pm',
                                      fontSize: 16
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
            SizedBox(height: width * 0.05,),
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                      onTap: (){
                        gonext(2);
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image(
                              image: AssetImage('assets/images/compare.png'),
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
                                height: 70,
                                alignment: Alignment.center,
                                child: Text('Compare',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'pm',
                                      fontSize: 16
                                  ),
                                ),
                              )
                          ),

                        ],
                      ),
                    )
                ),
                SizedBox(width: width * 0.05,),
                Expanded(
                    child: GestureDetector(
                      onTap: (){
                        gonext(3);

                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image(
                              image: AssetImage('assets/images/videos.png'),
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
                                height: 70,
                                alignment: Alignment.center,
                                child: Text('Videos',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'pm',
                                      fontSize: 16
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
            SizedBox(height: width * 0.05,),
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                          return ForumSurvey(_exchangeProvider! , _currencyProvider!, typeindex , curindex);
                        }));
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image(
                              image: AssetImage('assets/images/forum.png'),
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
                                height: 70,
                                alignment: Alignment.center,
                                child: Text('Forum & Survey',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'pm',
                                      fontSize: 16
                                  ),
                                ),
                              )
                          ),

                        ],
                      ),
                    )
                ),
                SizedBox(width: width * 0.05,),
                Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                          return BrokerPage();
                        }));
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image(
                              image: AssetImage('assets/images/brokers.png'),
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
                                height: 70,
                                alignment: Alignment.center,
                                child: Text('Brokers',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'pm',
                                      fontSize: 16
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
    );
  }

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
              // currencydropdownwidgt()
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
        videotype='${elist[ti].name}';
        print(videotype);
        if(ti == typeindex){
          return;
        }

        curindex = 0;
        typeindex = ti;

        getdata();
      },
    );
  }

  late int typeindex;
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
                    print(list2[i].name);
                    videotype2=list2[i].name;
                    print("jndjndjdn");

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
    clist = await _currencyProvider!.getdataa(elist[typeindex].id);
    if(elist[typeindex].name == "Stocks"){
      getDriller(clist[curindex].fkId);
    }
    setState(() {
    });
  }

  gonext(int n){
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
      return Lockers(n, _exchangeProvider!, _currencyProvider!, typeindex , curindex, dindex, dlist);
    }));
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
}
