import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trade_watch/Model/ImtModel.dart';
import 'package:trade_watch/Widgets/ForumWidget.dart';
import 'package:trade_watch/Widgets/PollWidget.dart';

import 'Forum.dart';

class SurveyScreen extends StatelessWidget {

  late double height , width;

  List<ImtModel> list = [
    ImtModel('assets/images/latestopics.png', 'Latest\nTopics'),
    ImtModel('assets/images/populartopics.png', 'Popular\nTopics'),
    ImtModel('assets/images/unanswered.png', 'My Poll\n'),
    ImtModel('assets/images/mostliked.png', 'Added\nThis Week'),
    ImtModel('assets/images/mostreplies.png', 'Added\nThis Month'),
    ImtModel('assets/images/mostdisliked.png', 'Added\nThis Quater'),
    ImtModel('assets/images/myquestions.png', 'Added\nThis Semester'),
    ImtModel('assets/images/myresponded.png', '6+ Months\nOlder'),
  ];
  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.01,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Text('Topics',style: TextStyle(
                color: Colors.black,
                fontFamily: 'pb',
                fontSize: 18
            ),),
          ),
          SizedBox(height: height * 0.01,),
          Container(
            padding: EdgeInsets.symmetric( vertical: height * 0.015),
            child: Container(
              height: 200,
              alignment: Alignment.center,
              child: ListView.builder(

                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx , i){
                  return ForumCatWidget(list[i]);
                },
                itemCount: list.length,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.025),

              itemBuilder: (ctx,i ){
                return PollWidget();
              },
              itemCount: 1,
            ),
          )
        ],
      ),
    );
  }
}
