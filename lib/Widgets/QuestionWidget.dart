import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Model/QuestionModel.dart';

class QuestionWidget extends StatelessWidget {

  late double width , height;

  FocusScopeNode? node;

  AnswerProvider? p;
  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    if(p == null){
      p = Provider.of<AnswerProvider>(context);
    }
    if(p!.list.isEmpty){
      Future.delayed(Duration(milliseconds: 10)).then((value){
        p!.adItem("");
      });
    }
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Consumer<AnswerProvider>(
      builder: (ctx , m  , child){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.025),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: height * 0.01),
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2, color: CColors.stroke),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: TextField(
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'pr',
                            fontSize: 10
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter question',
                          hintStyle: TextStyle(
                              color: CColors.graytext,
                              fontFamily: 'pr',
                              fontSize: 10
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.03,),
                  Image(
                    image: AssetImage('assets/icons/gallery.png'),
                    width: 35,
                  )
                ],
              ),

              drpdown(),
              Container(
                width: width * 0.5,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, i){
                    return answer(m , i);
                  },
                  padding: EdgeInsets.zero,
                  itemCount: m.list.length,
                  shrinkWrap: true,
                ),
              )

            ],
          ),
        );
      },
    );
  }

  Widget answer(AnswerProvider m , int i){
    return Container(

      margin: EdgeInsets.symmetric(vertical: height * 0.01),
      child: SizedBox(
        height: 40,
        child: TextField(
          onEditingComplete: (){
            if(i == m.list.length -1){
              Future.delayed(Duration(milliseconds: 10)).then((value){
                p!.adItem("");
              });
            }else{
              node!.nextFocus();
            }

          },
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'pr',
            fontSize: 10
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: width * 0.03),
            hintStyle: TextStyle(
              color: CColors.graytext,
              fontFamily: 'pr',
              fontSize: 8
            ),
            hintText: 'Enter Answer'
          ),
        ),
      ),
    );
  }


  String s = "";
  List<String> opt = [
    'Single Choice',
    'Multiple Choice'
  ];
  Widget drpdown() {
    return StatefulBuilder(
        builder: (ctx , setState){
          return Container(
            margin: EdgeInsets.symmetric(vertical: height * 0.005),

            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2, color: CColors.stroke),
                borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              children: [
                Image(image: AssetImage('assets/icons/type.png'),width: 30,),
                SizedBox(width: width * 0.02,),
                Expanded(
                  child: DropdownButton<String>(
                    itemHeight: 50,
                    isExpanded: true,
                    icon: ImageIcon(AssetImage('assets/icons/arrowdown.png')),
                    hint: Container(
                      child: Text(s == "" ? 'Select Answer Type' : s ,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'pr',
                          fontSize: 10
                        ),
                      ),
                    ),
                    underline: SizedBox(),
                    items: opt.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {

                      setState((){
                        s = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          );

        }
    );
  }
}
