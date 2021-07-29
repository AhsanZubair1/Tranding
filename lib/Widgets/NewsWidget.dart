import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Model/NewsModel.dart';
import 'package:trade_watch/Screens/others/NewsDetail.dart';

class NewsWidget extends StatelessWidget {

  NewsModel model;

  NewsWidget(this.model);

  late double height , width;

  late DocumentReference firebaseFirestore;
  late String date;
  @override
  Widget build(BuildContext context) {

    String ss = '';
    try{
      if(model.type == 1) {
        var s = model.sourceName!.replaceAll("@", "").replaceAll("#", "").split("text:")[1].replaceAll("}", "");
        print(s.trim());
        // var data = json.decode(model.sourceName!.replaceAll("@", "").replaceAll("#", ""));
        ss = s.trim();
      }else{
        ss = model.sourceName!;
      }
    }catch(e){
      print(e);
    }
    try{
      date = DateFormat('MMM dd,yyyy').format(DateFormat('EEE, dd MMM yyyy hh:mm:ss').parse(
      model.date
      ));
    }catch(e){
      date = DateFormat('MMM dd,yyyy').format(DateFormat('MM/dd/yyyy hh:mm:ss').parse(
          model.date
      ));
    }


    int words = (model.title ?? "").split(" ").length + (model.text ?? "").split(" ").length;
    int min = (words ~/ 200) + 1;

    String token = Provider.of<String>(context);
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    String id = decodedToken["ID"];
    firebaseFirestore = FirebaseFirestore.instance.collection('NewsLikes')
        .doc(model.newsUrl.replaceAll("/", "")).collection('likes').doc(id);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          return NewsDetail(model,);
        }));
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: width * 0.01, vertical: height * 0.015),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15), ),
                    child: Container(
                      width: double.infinity,
                      height: height * 0.2,
                      child: model.imageUrl != null ? Image(
                          image:
                          NetworkImage(model.imageUrl!),
                        fit: BoxFit.cover,
                      ) : Image(
                        image:
                        AssetImage('assets/images/nimage.jpg'),
                        fit: BoxFit.cover,
                      ),
                    )
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black54,
                    padding: EdgeInsets.only(left: width * 0.03,right: width * 0.03,top: width * 0.01, bottom: width * 0.01),
                    child: Text(model.title == null ? "" : model.title!,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'pm'
                      ),
                    ),
                  ),
                ),
              ],
            ),


            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: width * 0.03),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ss,
                          style: TextStyle(
                            color: CColors.yellowd,
                            fontFamily: 'pm',
                            fontSize: 12
                          ),
                        ),
                        SizedBox(height: height * 0.0025,),
                        Row(
                          children: [
                            Text(
                              date,
                              style: TextStyle(
                                color: CColors.graytext,
                                fontFamily: 'pm',
                                fontSize: 12
                              ),
                            ),
                            SizedBox(width: width *0.01,),
                            Icon(Icons.circle,color: CColors.graytext, size: 13,),
                            SizedBox(width: width *0.01,),
                            Text('$min m read',
                              style: TextStyle(
                                  color: CColors.graytext,
                                  fontFamily: 'pm',
                                  fontSize: 12
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 4,
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: firebaseFirestore.snapshots(),
                      builder: (context, snapshot) {
                        int like = 0;
                        if(snapshot.hasData && snapshot.data!.exists){
                          like = snapshot.data!.get("liked") as int;
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: (){
                                if(like == 1){
                                  firebaseFirestore.set({"liked" : 0});
                                }else{
                                  firebaseFirestore.set({"liked" : 1});
                                }
                              },
                              child: Image(
                                  image: AssetImage(like == 1 ? 'assets/icons/nlike.png' : 'assets/icons/like.png'),
                                width: 20,
                                height: 20,
                              ),
                            ),

                            InkWell(
                              onTap: (){
                                Share.share(model.newsUrl);
                              },
                              child: Image(
                                image: AssetImage('assets/icons/share.png'),
                                width: 20,
                                height: 20,
                              ),
                            ),

                            InkWell(
                              onTap: (){
                                if(like == 2){
                                  firebaseFirestore.set({"liked" : 0});
                                }else{
                                  firebaseFirestore.set({"liked" : 2});
                                }
                              },
                              child: Image(
                                image: AssetImage(like == 2 ? 'assets/icons/ndislike.png' :'assets/icons/dislike.png'),
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ],
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
