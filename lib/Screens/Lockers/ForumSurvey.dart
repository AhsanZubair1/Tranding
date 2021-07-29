import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Model/CurrencyModel.dart';
import 'package:trade_watch/Model/ExchangeModel.dart';
import 'package:trade_watch/Model/QuestionModel.dart';
import 'package:trade_watch/Screens/Lockers/FS/Forum.dart';
import 'package:trade_watch/Screens/Lockers/FS/PostQuestion.dart';
import 'package:trade_watch/Screens/Lockers/FS/PostSurvey.dart';
import 'package:trade_watch/Screens/Lockers/FS/SurveyScreen.dart';

class ForumSurvey extends StatefulWidget{
  CurrencyProvider currencyProvider;
  ExchangeProvider exchangeProvider;

  int typeindex;
  int currindex;
  ForumSurvey(this.exchangeProvider , this.currencyProvider , this.typeindex , this.currindex);
  @override
  _ForumSurveyState createState() => _ForumSurveyState();
}

class _ForumSurveyState extends State<ForumSurvey> with SingleTickerProviderStateMixin{
  late double height , width;
  late TabController controller;
  @override
  void initState() {
    // TODO: implement initState
    controller = TabController(length: 2, vsync: this);
    elist = widget.exchangeProvider.list;

    typeindex = widget.typeindex;
    curindex = widget.currindex;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(clist.isEmpty) {
      clist = widget.currencyProvider.getdata(elist[typeindex].id);
    }
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(controller.index == 0){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              return PostQuestion();
            }));
          }else{
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              return ChangeNotifierProvider(create: (BuildContext ctx){
                return QuestionProvider();
              },
                child: PostSurvey(),
              );
            }));
          }

        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: MediaQuery.of(context).padding,
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.zero,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.025),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.arrow_back_sharp,
                            ),
                          ),

                          Image(
                            image: AssetImage('assets/icons/Ic_Search.png'),
                            width: 24,
                          )
                        ],
                      ),
                      TabBar(
                        controller: controller,
                          tabs: [
                            Tab(
                              child: Text(
                                'Forum',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'pb',
                                  fontSize: 24
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Survey',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'pb',
                                  fontSize: 24
                                ),
                              ),
                            ),

                          ]
                      ),
                      SizedBox(height: height * 0.015,),
                      filter(),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  child: TabBarView(
                    controller: controller,
                    children: [
                      ForumScreen(),
                      SurveyScreen(),
                    ],
                  ),
                ),
              )
            ],
          ),

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
              InkWell(
                onTap: (){
                  pairsheet(context);
                },
                child: Row(
                  children: [
                    Container(
                      width: width * 0.3,
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


          elist[typeindex].name == "Stocks" ?
          Container(
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
                Text('Driller',
                  style: TextStyle(
                      color: CColors.graytext,
                      fontFamily: 'pb',
                      fontSize: 10
                  ),
                )
              ],
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
      hint: Container(
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
        if(ti == typeindex){
          return;
        }
        curindex = 0;
        typeindex = ti;
        getdata();
      },
    );
  }
  Widget currencydropdownwidgt() {
    return DropdownButton<String>(
      icon: ImageIcon(AssetImage('assets/icons/arrowdown.png')),
      hint: Container(
        width: width * 0.3,
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
      underline: SizedBox(),
      items: clist.map((value) {
        return new DropdownMenuItem<String>(
          value: value.name,
          child: Container(
              width: width * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Text(
                    value.name,
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
        setState((){
          curindex = cgetIndex(value!);
        });
      },
    );

  }

  late int typeindex = 0;
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
                    setcurr(list2[i].name);
                    Navigator.of(context).pop();
                  },
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
    setState((){
      curindex = cgetIndex(val);
    });
  }
  getdata() async{
    clist = await widget.currencyProvider.getdataa(elist[typeindex].id);
    setState(() {
    });
  }

}
