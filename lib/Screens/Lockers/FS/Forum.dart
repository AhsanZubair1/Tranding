import 'package:flutter/material.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Model/ImtModel.dart';
import 'package:trade_watch/Widgets/ForumWidget.dart';

class ForumScreen extends StatelessWidget {

  List<ImtModel> list = [
    ImtModel('assets/images/latestopics.png', 'Latest\nTopics'),
    ImtModel('assets/images/populartopics.png', 'Popular\nTopics'),
    ImtModel('assets/images/unanswered.png', 'Unanswered\n'),
    ImtModel('assets/images/mostliked.png', 'Most\nLiked'),
    ImtModel('assets/images/mostreplies.png', 'Most\nReplied'),
    ImtModel('assets/images/mostdisliked.png', 'Most\nDisliked'),
    ImtModel('assets/images/mostshared.png', 'Most\nShared'),
    ImtModel('assets/images/myquestions.png', 'My\nQuestions'),
    ImtModel('assets/images/myresponded.png', 'My\nResponse'),
  ];
  late double height , width;
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
                  return ForumWidget();
                },
                itemCount: 1,
              ),
          )
        ],
      ),
    );
  }
}
class ForumCatWidget extends StatelessWidget {
  late double height , width;
  ImtModel model;

  ForumCatWidget(this.model);

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 200,
      height: 200,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image(
              width: 200,
              image: AssetImage(
                model.image,
              ),
              fit: BoxFit.cover,
            ),
          ),
          
          Positioned(
            bottom: 20,
              left: 20,
              child: Text(model.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'psb'
                ),
              )
          )
        ],
      ),
    );
  }
}
