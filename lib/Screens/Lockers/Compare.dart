import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:trade_watch/Extras/Constants.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Extras/functions.dart';
import 'package:trade_watch/Interfaces/compareinterface.dart';
import 'package:trade_watch/Model/AllCurrenciesModel.dart';
import 'package:trade_watch/Model/CompareModel.dart';
import 'package:trade_watch/Model/CurrencyModel.dart';
import 'package:trade_watch/Model/ExchangeModel.dart';
import 'package:http/http.dart' as http;


class Compare extends StatefulWidget {
  CurrencyProvider currencyProvider;
  ExchangeProvider exchangeProvider;
  int typeindex;
  int dindex;
  int currindex;
  List<CurrencyModel> dlist;
  Compareinterface compareinterface;
  Compare(
      this.currencyProvider,
      this.exchangeProvider,
      this.typeindex ,
      this.currindex,
      this.dindex,
      this.dlist,
      this.compareinterface);


  @override
  _CompareState createState() => _CompareState();
}

class _CompareState extends State<Compare> {
  late double width, height;

  List<ExchangeModel> elist = [];
  List<CurrencyModel> clist = [];
  List<CurrencyModel> clist2 = [];

  @override
  void initState() {
    elist = widget.exchangeProvider.list;

    typeindex = widget.typeindex;
    curindex = widget.currindex;

    dlist = widget.dlist;
    dindex = widget.dindex;
    super.initState();
  }

  bool getd = false;
  @override
  Widget build(BuildContext context) {

    if(clist.isEmpty)
    clist = widget.currencyProvider.getdata(elist[typeindex].id);

    if(clist2.isEmpty)
    clist2 = widget.currencyProvider.getdata(elist[typeindex2].id);

    Future.delayed(Duration(milliseconds: 10)).then((value){
      if(!getd){
        getCurrencies();
        getd = true;
      }



      if(elist[typeindex].name == "Stocks"){
        if(dlist.isEmpty) {
          Future.delayed(Duration(milliseconds: 10)).then((value) {
            getDriller(clist[curindex].fkId, 1);
          });
        }
      }
    });


    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(

      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text('Primary',
                          style: TextStyle(
                            color: CColors.gray,
                            fontFamily: 'psb',
                            fontSize: 12
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.03,),
                      Expanded(
                        child: Text('Secondary',
                          style: TextStyle(
                            color: CColors.gray,
                            fontFamily: 'psb',
                            fontSize: 12
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01,),
                  Row(
                    children: [
                      Expanded(
                        child: typedropdownwidgt(),
                      ),
                      SizedBox(width: width * 0.03,),
                      Expanded(
                        child: typedropdownwidgt1(),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01,),

                  Row(
                    children: [
                      Expanded(
                        child: clist.length > 0 ? InkWell(
                          onTap: (){
                            pairsheet(context , 1);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: CColors.graytext),
                            ),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: NetworkImage(clist[curindex].iconName),
                                      width: 24,
                                      height: 24,
                                    ),
                                    SizedBox(width: 3),
                                    Container(
                                      width: width * 0.22,
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
                                  ],
                                ),
                                ImageIcon(AssetImage('assets/icons/arrowdown.png')),
                              ],
                            ),
                          ),
                        ) : SizedBox(),
                      ),
                      SizedBox(width: width * 0.015,),
                      Image(
                        image: AssetImage('assets/images/swap.png'),
                        width: 30,
                      ),
                      SizedBox(width: width * 0.015,),
                      Expanded(
                        child: clist2.length > 0 ? InkWell(
                          onTap: (){
                            pairsheet(context, 2);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: CColors.graytext),
                            ),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: NetworkImage(clist2[curindex2].iconName),
                                      width: 24,
                                      height: 24,
                                    ),
                                    SizedBox(width: 3),
                                    Container(
                                      width: width * 0.22,
                                      child: Text('${(clist2)[curindex2].name}' ,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'pm',
                                            fontSize: 14
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                ImageIcon(AssetImage('assets/icons/arrowdown.png')),
                              ],
                            ),
                          ),
                        ) : SizedBox(),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01,),

                  Row(
                    children: [
                      Expanded(
                          child:
                          elist[typeindex].name == "Stocks" && dlist.length > 0?
                          InkWell(
                            onTap: (){
                              drillsheet(context, 1);
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
                                  Expanded(
                                    child: Text(dlist.length > 0 ? '${dlist[dindex].name}' : 'Driller' ,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: CColors.graytext,
                                          fontFamily: 'pb',
                                          fontSize: 10
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                              :
                          SizedBox()
                      ),
                      SizedBox(width: width * 0.03,),
                      Expanded(
                          child:
                          elist[typeindex2].name == "Stocks" && dlist2.length > 0?
                          InkWell(
                            onTap: (){
                              drillsheet(context, 2);
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
                                  Expanded(
                                    child: Text(dlist2.length > 0 ? '${dlist2[dindex2].name}' : 'Driller' ,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,

                                      style: TextStyle(
                                          color: CColors.graytext,
                                          fontFamily: 'pb',
                                          fontSize: 10
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                              :
                          SizedBox()
                      ),

                    ],
                  ),


                  SizedBox(height: height * 0.03,),

                  Container(
                    width: width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Comparison chart',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'pb',
                              fontSize: 18
                          ),
                        ),

                        currencies.length > 0 ? getcurrencies() : SizedBox(),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.03,),

                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: CColors.graytext, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              comlist1.length == 0 ? SizedBox():
                              Text('$curren ${(comlist1.last.close).toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: CColors.graphblue,
                                    fontSize: 18,
                                    fontFamily: 'pb'
                                ),
                              ),

                              comlist2.length == 0 ? SizedBox():
                              Text('$curren ${(comlist2.last.close).toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: CColors.graphpurple,
                                    fontSize: 18,
                                    fontFamily: 'pb'
                                ),
                              ),
                            ],
                          ),
                        ),
                        graph(),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.03,),

                  timeperiodwidget(),

                  SizedBox(height: height * 0.03,),

                  Text('Summary',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'pb',
                      fontSize: 18
                    ),
                  ),

                  SizedBox(height: height * 0.03,),

                  summaryWidget(),

                  SizedBox(height: height * 0.03,),
                ],
              ),
            ),

            other(),
          ],
        ),
      ),
    );
  }

  Widget summaryWidget(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1,color: CColors.graytext),
      ),
      padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),
      child: Column(
        children: [
          SummaryData(1, 'Name', 'Bitcoin', 'Tesla'),
          SummaryData(0, 'Current Price', '\$625.32', '\$625.32'),
          SummaryData(1, 'Highest Price', '\$6205.32', '\$6325.32'),
          SummaryData(1, 'Lowest Price', '\$6215.32', '\$6225.32'),
          SummaryData(1, 'Market Cap', '\$62225.32', '\$6215.32'),

          SummaryData(1, 'Circulation Supply', '-', '-'),
          SummaryData(1, '24h Trading Volume', '-', '-'),
          SummaryData(1, 'Dividend', 'NO', 'NO'),
          SummaryData(1, 'Last Dividend Date', '-', '-'),
          SummaryData(1, 'Last Dividend Provided', '-', '-'),
          SummaryData(1, 'Next Dividend Date', '-', '-'),

        ],
      ),
    );
  }

  Widget SummaryData(int t , String one , String two , String three){
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.0075, horizontal: width * 0.03),
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: Text(one,
              style: TextStyle(
                color: t == 1 ? CColors.textblack : Colors.black,
                fontSize: 10,
                fontFamily: t == 1 ? 'pr' : 'psb',
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(two,
              style: TextStyle(
                color: t == 1 ? CColors.textblack : Colors.black,
                fontSize: 10,
                fontFamily: t == 1 ? 'pr' : 'psb',
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(three,
              style: TextStyle(
                color: t == 1 ? CColors.textblack : Colors.black,
                fontSize: 10,
                fontFamily: t == 1 ? 'pr' : 'psb',
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget timeperiodwidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                handleclick(0);
              },
              child: Container(
                width: width * .1,
                child: Column(
                  children: [
                    Text(
                      '1D',
                      style: TextStyle(
                        color: sel != 0 ? CColors.graytext : CColors.textblack,
                        fontSize: 14,
                        fontFamily: 'pm',
                      ),
                    ),
                    SizedBox(height: 5,),
                    sel !=0 ? SizedBox() :
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: CColors.primary,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){
                handleclick(1);
              },
              child: Container(
                width: width * .1,
                child: Column(
                  children: [
                    Text(
                      '1W',
                      style: TextStyle(
                        color: sel != 1 ? CColors.graytext : CColors.textblack,
                        fontSize: 14,
                        fontFamily: 'pm',
                      ),
                    ),
                    SizedBox(height: 5,),
                    sel !=1 ? SizedBox() :
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: CColors.primary,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){
                handleclick(2);
              },
              child: Container(
                width: width * .1,
                child: Column(
                  children: [
                    Text(
                      '1M',
                      style: TextStyle(
                        color: sel != 2 ? CColors.graytext : CColors.textblack,
                        fontSize: 14,
                        fontFamily: 'pm',
                      ),
                    ),
                    SizedBox(height: 5,),
                    sel !=2 ? SizedBox() :
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: CColors.primary,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){
                handleclick(3);
              },
              child: Container(
                width: width * .1,
                child: Column(
                  children: [
                    Text(
                      '1Q',
                      style: TextStyle(
                        color: sel != 3 ? CColors.graytext : CColors.textblack,
                        fontSize: 14,
                        fontFamily: 'pm',
                      ),
                    ),
                    SizedBox(height: 5,),
                    sel !=3 ? SizedBox() :
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: CColors.primary,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){
                handleclick(4);
              },
              child: Container(
                width: width * .1,
                child: Column(
                  children: [
                    Text(
                      '1Y',
                      style: TextStyle(
                        color: sel != 4 ? CColors.graytext : CColors.textblack,
                        fontSize: 14,
                        fontFamily: 'pm',
                      ),
                    ),
                    SizedBox(height: 5,),
                    sel !=4 ? SizedBox() :
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: CColors.primary,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){
                handleclick(5);
              },
              child: Container(
                width: width * .1,
                child: Column(
                  children: [
                    Text(
                      '1YTD',
                      style: TextStyle(
                        color: sel != 5 ? CColors.graytext : CColors.textblack,
                        fontSize: 14,
                        fontFamily: 'pm',
                      ),
                    ),
                    SizedBox(height: 5,),
                    sel !=5 ? SizedBox() :
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: CColors.primary,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: CColors.gray,
        )
      ],
    );
  }
  Widget typedropdownwidgt() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CColors.graytext),
      ),
      child: DropdownButton<String>(
        icon: ImageIcon(AssetImage('assets/icons/arrowdown.png')),
        isExpanded: true,
        hint: Row(
          children: [
            Image(
              image: NetworkImage(elist[typeindex].image),
              width: 24,
              height: 24,
            ),
            SizedBox(width: 4),
            Container(
              width: width * 0.25,
              child: Text('${elist[typeindex].name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'pm',
                    fontSize: 13
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
              child: Text(value.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'pr',
                  fontSize: 12,

                ),
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {

          int ti = getIndex(value!);
          if(ti == typeindex){
            return;
          }
          // setState((){
          curindex = 0;
          typeindex = ti;
          getdata();
          // });
        },
      ),
    );

  }
  Widget typedropdownwidgt1() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CColors.graytext),
      ),
      child: DropdownButton<String>(
        icon: ImageIcon(AssetImage('assets/icons/arrowdown.png')),
        isExpanded: true,
        hint: Row(
          children: [
            Image(
              image: NetworkImage(elist[typeindex2].image),
              width: 24,
              height: 24,
            ),
            SizedBox(width: 4),
            Container(
              width: width * 0.25,
              child: Text('${elist[typeindex2].name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'pm',
                    fontSize: 13
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
              child: Text(value.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'pr',
                  fontSize: 12,

                ),
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {

          int ti = getIndex(value!);
          if(ti == typeindex2){
            return;
          }

          curindex2 = 0;
          typeindex2 = ti;
          getdata2();
        },
      ),
    );

  }

  int typeindex = 0;
  int typeindex2 = 0;
  int curindex = 0;
  int curindex2 = 0;
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
  int cgetIndex2(String s){
    for(int i = 0 ; i < clist2.length ; i ++){
      if(s == clist2[i].name){
        return i;
      }
    }
    return 0;
  }


  List<CompareModel> comlist1 = [];
  List<CompareModel> comlist2 = [];


  List<double> close1 = [];
  List<double> close2 = [];


  void getData(int type) async{

    Functions().showLoaderDialog(context,);
    String url = Constants.url + 'Eod/GetHistorialData';

    Map<String, Object> body;
    if(type == 1){
      body = {
        "TimePeriod" : ptype[sel],
        "StkId" : elist[typeindex].id,
        "PairId" : elist[typeindex].name == "Stocks" ? dlist[dindex].id : clist[curindex].id,
        'curr' : curren,
      };
    }else{
      print("id2 ${elist[typeindex2].id}");
      body = {
        "TimePeriod" : ptype[sel],
        "StkId" : elist[typeindex2].id,
        "PairId" : elist[typeindex2].name == "Stocks" ? dlist2[dindex2].id : clist2[curindex2].id,
        'curr' : curren,
      };
    }
    final response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );

    print(response.body);
    Navigator.of(context).pop();

    if(response.statusCode == 200){
      var result = jsonDecode(response.body)['res'];
      print(result);
      if(type == 1){
        comlist1 = [];
        fl1 = [];
        close1 = [];
        for(var res in result){
          CompareModel model = CompareModel.fromJson(res);
          close1.add(model.close);
          fl1.add(FlSpot(comlist1.length.toDouble(), model.close));
          comlist1.add(model);
          // print(model.date);
        }
      }else{
        comlist2 = [];
        fl2 = [];
        close2 = [];
        for(var res in result){
          CompareModel model = CompareModel.fromJson(res);
          close2.add(model.close);
          fl2.add(FlSpot(comlist2.length.toDouble(), model.close));
          comlist2.add(model);
          // print(model.date);
        }
      }


      setState(() {});
    }else{
      setState(() {
        error = true;
      });
      Fluttertoast.showToast(msg: 'Something went wrong', backgroundColor: Colors.red, textColor: Colors.white);
    }
  }

  bool error = false;
  Widget graph(){
    return Container(
      height: height * 0.3,
      alignment: Alignment.center,
      child: LineChart(
        LineChartData(
          minX: 0,
          gridData: FlGridData(
            show: false,
          ),
          titlesData: FlTitlesData(
            bottomTitles: SideTitles(
              showTitles: false,
              // reservedSize: 22,
              getTextStyles: (value) => const TextStyle(
                color: Colors.transparent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),

              getTitles: (value) {
                // if(value.toInt() % 4 == 0){
                //   return '${value.toInt()}';
                // }else{
                  return '';
                // }
                },
            ),
            leftTitles: SideTitles(
              showTitles: false,
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          lineBarsData: getgraphdata(),
        ),
      ),
    );
  }

  int sel = 2;
  List<FlSpot> fl1 = [];
  List<FlSpot> fl2 = [];

  List<LineChartBarData> getgraphdata(){

    List<LineChartBarData> l = [];

    try{
      if(fl1.isNotEmpty && fl2.isNotEmpty)
      {
        print(1);

        l = [
          LineChartBarData(
            dotData: FlDotData(
              show: false,
            ),
            isCurved: true,
            spots: fl1,
            colors: [
              CColors.graphblue
            ],
            barWidth: 2,

          ),
          LineChartBarData(
            dotData: FlDotData(
              show: false,
            ),
            isCurved: true,
            spots: fl2,
            colors: [
              CColors.graphpurple
            ],
            barWidth: 3.75,

          ),
        ];
      }
      else if(fl1.isEmpty && fl2.isEmpty)
      {
        print(2);
        l = [];
      }
      else if(fl2.isEmpty)
      {
        print(3);

        l = [
          LineChartBarData(
            dotData: FlDotData(
              show: false,
            ),
            isCurved: true,
            spots: fl1,
            colors: [
              CColors.graphblue
            ],
            barWidth: 2,

          ),
        ];
      }
      else if(fl1.isEmpty)
      {
        print(4);
        l = [
          LineChartBarData(
            dotData: FlDotData(
              show: false,
            ),
            isCurved: true,
            spots: fl2,
            colors: [
              CColors.graphpurple
            ],
            barWidth: 3.75,

          ),
        ];
      }
    }catch(e){
      print(e);
    }

    print("length ${l.length}");
    return l;
  }

  handleclick(int i){
    setState(() {
      sel = i;
    });
    getData(1);
    getData(2);
  }

  var ptype = [
    "Day",
    "Week",
    "Month",
    "Quater",
    "Year",
    "Ytd"
  ];


  void getCurrencies() async{

    Functions().showLoaderDialog(context,text: 'Getting Currencies');
    String url = Constants.url + 'Eod/AllCurrencies';


    final response = await http.get(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );
    Navigator.of(context).pop();


    if(response.statusCode == 200){
      List<String> cc = [];
      var result = jsonDecode(response.body)['res'];
      for(var res in result){
        AllCurrencyModel model = AllCurrencyModel.fromJson(res);
        cc.add(model.iso);
      }

      currencies = cc.toSet().toList();
      setState(() {});

      handleclick(2);
    }else{
      setState(() {
        error = true;
      });
      Fluttertoast.showToast(msg: 'Something went wrong', backgroundColor: Colors.red, textColor: Colors.white);
    }
  }
  String curren = "USD";
  List<String> currencies = [];
  Widget getcurrencies() {
    return Container(
      width: width * 0.3,
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(10),
      //   border: Border.all(color: CColors.graytext),
      // ),
      child: DropdownButton<String>(
        isExpanded: true,
        icon: ImageIcon(AssetImage('assets/icons/arrowdown.png')),
        hint: Container(
          width: width * 0.2,
          child: Text('$curren' ,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'pm',
                fontSize: 12
            ),
          ),
        ),
        underline: SizedBox(),
        items: currencies.map((value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: Container(
                width: width * 0.2,
                child: new Text(
                  value,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'pm',
                      fontSize: 12
                  ),
                  overflow: TextOverflow.ellipsis,
                )
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState((){
            setState(() {
              curren = value!;
            });
            handleclick(sel);
          });
        },
      ),
    );
  }

  void pairsheet(BuildContext context , int t){
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
        child: PairsSheet(t),
      ),);
  }
  Widget PairsSheet(int t){
    var controller = TextEditingController();
    List<CurrencyModel> list2 = [];
    return StatefulBuilder(builder: (ctx , setState){
      list2 = getslist(controller.text , t);
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
                    setcurr(list2[i].name , t);
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
  List<CurrencyModel> getslist(String s, int t){
    if(t == 1) {
      if (s.isEmpty) {
        return clist;
      } else {
        List<CurrencyModel> l = [];
        for (int i = 0; i < clist.length; i++) {
          if (clist[i].name.toLowerCase().contains(s.toLowerCase())) {
            l.add(clist[i]);
          }
        }

        return l;
      }
    }else{

      if (s.isEmpty) {
        return clist2;
      } else {
        List<CurrencyModel> l = [];
        for (int i = 0; i < clist2.length; i++) {
          if (clist2[i].name.toLowerCase().contains(s.toLowerCase())) {
            l.add(clist2[i]);
          }
        }
        return l;
      }
    }
  }
  setcurr(String val , int t){
    setState((){
      if(t == 1){
        curindex = cgetIndex(val);
        if(elist[typeindex].name == "Stocks"){
          getDriller(clist[curindex].fkId, 1);
          return;
        }
        getData(1);
      }else{
        curindex2 = cgetIndex2(val);

        if(elist[typeindex2].name == "Stocks"){
          getDriller(clist2[curindex2].fkId, 2);
          return;
        }
        getData(2);
      }
    });
  }
  getdata() async{
    clist = await widget.currencyProvider.getdataa(elist[typeindex].id);

    if(elist[typeindex].name == "Stocks"){
      getDriller(clist[curindex].fkId, 1);
      return;
    }
    setState(() {
    });
  }
  getdata2() async{
    clist2 = await widget.currencyProvider.getdataa(elist[typeindex2].id);

    if(elist[typeindex2].name == "Stocks"){
      getDriller(clist2[curindex2].fkId, 2);
      return;
    }
    setState(() {
    });
  }





  //driller
  List<CurrencyModel> dlist = [];
  void getDriller(int id,int t) async {
    if(t == 1) {
      // setState(() {
      dindex = 0;
      // });
    }else{
      // setState(() {
      dindex2 = 0;
      // });
    }

    Functions().showLoaderDialog(context, text: 'Getting Data');
    String url = Constants.url + 'Eod/GetStockPairs?id=$id';
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

      if(t == 1) {
        setState(() {
          dlist = clist;
        });
      }else{
        setState(() {
          dlist2 = clist;
        });
      }
      getData(t);
    }else{
      Fluttertoast.showToast(msg: 'Something went wrong', backgroundColor: Colors.red, textColor: Colors.white);
    }
  }
  List<CurrencyModel> dlist2 = [];
  int dindex2 = 0;
  void drillsheet(BuildContext context, int type){
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
        child: DrillSheet(type),
      ),);
  }
  Widget DrillSheet(int type){
    var controller = TextEditingController();
    List<CurrencyModel> list2 = [];
    return StatefulBuilder(builder: (ctx , setState){
      list2 = getdlist(controller.text, type);
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
                    setd(list2[i].name , type);

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
  List<CurrencyModel> getdlist(String s , int t){
    if(t == 1){
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
    }else{
      if(s.isEmpty){
        return dlist2;
      }else{
        List<CurrencyModel> l = [];
        for(int i = 0 ; i < dlist2.length ; i++){
          if(dlist2[i].name.toLowerCase().contains(s.toLowerCase())){
            l.add(dlist2[i]);
          }
        }
        return l;
      }
    }

  }
  setd(String val , int t){
    if(t == 1) {
      int ci = dgetIndex(val);
      if (dindex == ci) {
        return;
      }
      setState(() {
        dindex = ci;
      });

      getData(1);
    }else{
      int ci = dgetIndex2(val);
      if (dindex2 == ci) {
        return;
      }
      setState(() {
        dindex2 = ci;
      });

      getData(2);
    }
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
  int dgetIndex2(String s){
    for(int i = 0 ; i < dlist2.length ; i ++){
      if(s == dlist2[i].name){
        return i;
      }
    }
    return 0;
  }
  Widget other(){
    String name1 = elist[typeindex].name == "Stocks" ?
    dlist.isNotEmpty? dlist[dindex].name : ""
        :
    clist[curindex].name;
    String name2 = elist[typeindex2].name == "Stocks" ?
    dlist2.isNotEmpty? dlist2[dindex2].name : ""
        :
    clist2[curindex2].name;




    String image1 = elist[typeindex].name == "Stocks" ?
    dlist.isNotEmpty? dlist[dindex].iconName : ""
        :
    clist[curindex].iconName;
    String image2 = elist[typeindex2].name == "Stocks" ?
    dlist2.isNotEmpty? dlist2[dindex2].iconName : ""
        :
    clist2[curindex2].iconName;
    return Container(
      width: width,
      color: CColors.gray.withOpacity(0.2),
      padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Other $name1 Related Information',
            style: TextStyle(
              fontFamily: 'pm',
              fontSize: 14,
              color: Colors.black,
            ),
          ),

          SizedBox(height: height * 0.02,),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    widget.compareinterface.func(0, clist,dlist, dindex, typeindex, curindex);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(7),
                            topLeft: Radius.circular(7),
                          ),
                          child: Image(
                            height: height * 0.15,
                            width: double.infinity,
                            image: NetworkImage(image1),
                            fit: BoxFit.cover,
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.01, ),
                          child: Text('News',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'pm',
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                          child: Text('Lorem Ipsum is simply dummy text of the printing.',
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'pr',
                              fontSize: 8,
                            ),
                          ),
                        ),
                        SizedBox(height: 7,),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(width: width * 0.02,),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(7),
                          topLeft: Radius.circular(7),
                        ),
                        child: Image(
                          height: height * 0.15,
                          width: double.infinity,
                          image: NetworkImage(image1),
                          fit: BoxFit.cover,
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.01, ),
                        child: Text('Videos',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'pm',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                        child: Text('Lorem Ipsum is simply dummy text of the printing.',
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'pr',
                            fontSize: 8,
                          ),
                        ),
                      ),
                      SizedBox(height: 7,),
                    ],
                  ),
                ),
              ),

              SizedBox(width: width * 0.02,),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(7),
                          topLeft: Radius.circular(7),
                        ),
                        child: Image(
                          height: height * 0.15,
                          width: double.infinity,
                          image: NetworkImage(image1),
                          fit: BoxFit.cover,
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.01, ),
                        child: Text('Forums',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'pm',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                        child: Text('Lorem Ipsum is simply dummy text of the printing.',
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'pr',
                            fontSize: 8,
                          ),
                        ),
                      ),
                      SizedBox(height: 7,),
                    ],
                  ),
                ),
              ),


            ],
          ),
          SizedBox(height: height * 0.02,),
          Text('Other $name2 Related Information',
            style: TextStyle(
              fontFamily: 'pm',
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: height * 0.02,),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    widget.compareinterface.func(0,clist2, dlist2, dindex2, typeindex2, curindex2);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(7),
                            topLeft: Radius.circular(7),
                          ),
                          child: Image(
                            height: height * 0.15,
                            width: double.infinity,
                            image: NetworkImage(image2),
                            fit: BoxFit.cover,
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.01, ),
                          child: Text('News',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'pm',
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                          child: Text('Lorem Ipsum is simply dummy text of the printing.',
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'pr',
                              fontSize: 8,
                            ),
                          ),
                        ),
                        SizedBox(height: 7,),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(width: width * 0.02,),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(7),
                          topLeft: Radius.circular(7),
                        ),
                        child: Image(
                          height: height * 0.15,
                          width: double.infinity,
                          image: NetworkImage(image2),
                          fit: BoxFit.cover,
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.01, ),
                        child: Text('Videos',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'pm',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                        child: Text('Lorem Ipsum is simply dummy text of the printing.',
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'pr',
                            fontSize: 8,
                          ),
                        ),
                      ),
                      SizedBox(height: 7,),
                    ],
                  ),
                ),
              ),

              SizedBox(width: width * 0.02,),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(7),
                          topLeft: Radius.circular(7),
                        ),
                        child: Image(
                          height: height * 0.15,
                          width: double.infinity,
                          image: NetworkImage(image2),
                          fit: BoxFit.cover,
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.01,),
                        child: Text('Forums',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'pm',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                        child: Text('Lorem Ipsum is simply dummy text of the printing.',
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'pr',
                            fontSize: 8,
                          ),
                        ),
                      ),
                      SizedBox(height: 7,),
                    ],
                  ),
                ),
              ),


            ],
          ),

        ],
      ),
    );
  }
}
