import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Interfaces/dValueInterface.dart';
import 'package:trade_watch/Model/QuestionModel.dart';
import 'package:trade_watch/Widgets/QuestionWidget.dart';

class PostSurvey extends StatefulWidget {

  @override
  _PostSurveyState createState() => _PostSurveyState();
}

class _PostSurveyState extends State<PostSurvey> implements dvalueInterface{
  late double height, width;
  bool added = false;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    print(width);
    return Scaffold(
      backgroundColor: CColors.whitebg,
      body: Container(
        padding: MediaQuery.of(context).padding,
        child: Consumer<QuestionProvider>(
          builder: (ctx , model , child){
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: (ctx , i){
                if(i == 0){
                  return topcard(model);
                }else if(i == model.list.length + 1){
                  return bottomcard(model);
                }else{
                  return ChangeNotifierProvider(
                      create: (BuildContext context) {
                        return AnswerProvider();
                      },
                      child: QuestionWidget()
                  );
                }
            },itemCount: model.list.length + 2,);
          },
        ),
      ),
    );
  }

  Widget topcard(QuestionProvider model) {
    return Column(
      children: [
        Card(
          elevation: 5,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.025),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel',
                    style: TextStyle(
                        color: CColors.graytext,
                        fontSize: 16,
                        fontFamily: 'pm'
                    ),
                  ),
                ),
                Text('Post Survey',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'pb'
                  ),
                ),

                Text('Release',
                  style: TextStyle(
                      color: CColors.primary,
                      fontSize: 16,
                      fontFamily: 'psb'
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.025),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05,),
                margin: EdgeInsets.symmetric(vertical: height * 0.01),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 2, color: CColors.stroke),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: TextField(
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'pm',
                      fontSize: 14
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your survey title here....',
                    hintStyle: TextStyle(
                        color: CColors.graytext,
                        fontFamily: 'pm',
                        fontSize: 14
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.005),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Active until: ',
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'psb',
                          color: CColors.graytext
                      ),
                    ),
                    SizedBox(width: width * 0.01,),
                    hoursdropdownwidgt(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget bottomcard(QuestionProvider model){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 40,
              height: 40,
              child: FloatingActionButton(
                onPressed: (){
                  model.addItem(QuestionModel("Hello", []));
                },
                backgroundColor: CColors.primary,
                child: Icon(Icons.add),
              ),
            ),
          ),
          SizedBox(height: height * 0.03,),
          catdropdownwidgt(),
          scatdropdownwidgt(),
          itemdropdownwidgt(),
        ],
      ),
    );
  }
  int? cati;
  List<String> cat = [
    "Stocks",
    "Crypto",
    "Comodity",
    "Forex",
  ];
  int? scati;
  List<String> scat = [
    "Stocks",
    "Crypto",
    "Comodity",
    "Forex",
  ];
  int? itemi;
  List<String> item = [
    "Stocks",
    "Crypto",
    "Comodity",
    "Forex",
  ];
  Widget catdropdownwidgt() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.005),

      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 2, color: CColors.stroke),

      ),
      child: DropdownButton<String>(
        isExpanded: true,
        icon: ImageIcon(AssetImage('assets/icons/arrowdown.png')),
        hint: Container(
          child: Text(cati == null ? 'Select a Category' : '${cat[cati!]} ' ,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'pr',
            ),
          ),
        ),
        underline: SizedBox(),
        items: cat.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        onChanged: (value) {
          FocusScope.of(context).requestFocus(new FocusNode());

          setState((){
            cati = getIndex(value!, cat);
          });
        },
      ),
    );
  }
  Widget scatdropdownwidgt() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.005),
      padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.005),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 2, color: CColors.stroke),

      ),
      child: DropdownButton<String>(
        isExpanded: true,
        icon: ImageIcon(AssetImage('assets/icons/arrowdown.png')),
        hint: Container(
          child: Text(scati == null ? 'Select a Subcategory' : '${scat[scati!]} ' ,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'pr',
            ),
          ),
        ),
        underline: SizedBox(),
        items: scat.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        onChanged: (value) {
          // node!.unfocus();
          FocusScope.of(context).requestFocus(new FocusNode());

          setState((){
            scati = getIndex(value!, scat);
          });
        },
      ),
    );
  }
  Widget itemdropdownwidgt() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.005),
      margin: EdgeInsets.symmetric(vertical: height * 0.005),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 2, color: CColors.stroke),

      ),
      child: DropdownButton<String>(
        isExpanded: true,
        icon: ImageIcon(AssetImage('assets/icons/arrowdown.png')),
        hint: Container(
          child: Text(itemi == null ? 'Select an Item' : '${item[itemi!]} ' ,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'pr',
            ),
          ),
        ),
        underline: SizedBox(),
        items: item.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        onChanged: (value) {
          // node!.unfocus();
          FocusScope.of(context).requestFocus(new FocusNode());
          setState((){
            itemi = getIndex(value!, item);
          });
        },
      ),
    );
  }
  int hoursi = 0;

  List<String> hours = [
    "1 Hour",
    "5 Hours",
    "12 Hours",
    "1 Day",
  ];

  Widget hoursdropdownwidgt() {
    return DropdownButton<String>(
      icon: ImageIcon(AssetImage('assets/icons/arrowdown.png')),
      hint: Container(
        child: Text('${hours[hoursi]}' ,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'psb',
            fontSize: 12
          ),
        ),
      ),
      underline: SizedBox(),
      items: hours.map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState((){
          hoursi = getIndex(value!, hours);
        });
      },
    );
  }
  int getIndex(String s , List<String> sname){
    for(int i = 0 ; i < sname.length ; i ++){
      if(s == sname[i]){
        return i;
      }
    }
    return 0;
  }

  @override
  void func(i , j) {
    int ind = i;
    QuestionModel m = j;

  }


}
