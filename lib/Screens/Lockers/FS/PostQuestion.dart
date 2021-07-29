import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trade_watch/Extras/Constants.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart'as https;
import 'dart:io';
class PostQuestion extends StatefulWidget {

  @override
  _PostQuestionState createState() => _PostQuestionState();
}

class _PostQuestionState extends State<PostQuestion> {
  late double height, width;
  late String categorytext,subcategorytext;
  FocusScopeNode? node;
  String title='';
  String desc='';
  var tnode=FocusNode();

  File? _image;
  String path = "";
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);

        print(_image);
      } else {
        print('No image selected.');
      }
    });
  }
  Future <void>? submitt()async{
    if(title.isEmpty||desc.isEmpty||_image==null||categorytext.isEmpty||subcategorytext.isEmpty){
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Fill form completly")));

    }
    else{
      String url = Constants.url + 'Eod/GetRealTimeData';
      final response=https.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          'title': title,
          'description':desc,
          

        }),
      );

    }
  }
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    if(node == null){
      node = FocusScope.of(context);
    }
    return Scaffold(
      backgroundColor: CColors.whitebg,
      body: SingleChildScrollView(
        child: Container(
          padding: MediaQuery.of(context).padding,
          child: Column(
            children:[
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
                      Text('Post Question',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.01),
                      margin: EdgeInsets.symmetric(vertical: height * 0.01),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 2, color: CColors.stroke),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: TextField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: ()=> node!.nextFocus(),
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'pm',
                            fontSize: 17
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter a title for your post here....',
                          hintStyle: TextStyle(
                            color: CColors.graytext,
                            fontFamily: 'pm',
                            fontSize: 17
                          ),

                        ),
                        onSubmitted: (val){
                          FocusScope.of(context).requestFocus(tnode);

                        },
                        onChanged: (val){
                          setState(() {
                            title=val.toString();
                          });

                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: height * 0.01),
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.01),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 2, color: CColors.stroke),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: TextField(
                        focusNode: tnode,
                        minLines: 10,
                        maxLines: 10,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'pr',
                            fontSize: 12
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter a title for your post here....',
                          hintStyle: TextStyle(
                            color: CColors.graytext,
                            fontFamily: 'pr',
                            fontSize: 12
                          ),

                        ),
                        onChanged: (val){
                          setState(() {
                            desc=val.toString();
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        getImage();
                      },
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: height * 0.01),
                          child: Image(
                            image: AssetImage('assets/images/addimage.png'),
                            width: 100,
                            height: 100,
                          )
                      ),
                    ),

                    catdropdownwidgt(),
                    scatdropdownwidgt(),
                    itemdropdownwidgt(),
                  ],
                ),
              ),

            ]
          ),
        ),
      ),
    );
  }
 late int cati;
  List<String> cat = [
    "Stocks",
    "Crypto",
    "Comodity",
    "Forex",
  ];
late  int scati;
  List<String> scat = [
    "Stocks",
    "Crypto",
    "Comodity",
    "Forex",
  ];
 late int itemi;
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
          child: Text(cati == null ? 'Select a Category' : '${cat[cati]} ' ,
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
            categorytext=cat[cati];
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
          child: Text(scati == null ? 'Select a Subcategory' : '${scat[scati]} ' ,
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
            subcategorytext=scat[scati];
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
          child: Text(itemi == null ? 'Select an Item' : '${item[itemi]} ' ,
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

  int getIndex(String s , List<String> sname){
    for(int i = 0 ; i < sname.length ; i ++){
      if(s == sname[i]){
        return i;
      }
    }
    return 0;
  }
}
