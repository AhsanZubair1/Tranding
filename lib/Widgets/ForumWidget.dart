

import 'package:flutter/material.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Screens/Lockers/FS/ForumDetail.dart';

class ForumWidget extends StatelessWidget {

  late double height, width;
  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: (){

        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> ForumDetail()));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: width * 0.1,
                backgroundImage: NetworkImage('https://pyxis.nymag.com/v1/imgs/e48/209/63cbdefa481d2e12651381284a2b590d9a-wandavision.rsquare.w700.jpg'),
              ),

              SizedBox(width: width * 0.03,),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Lorem ipsum dolor sit',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'psb',
                          color: Colors.black
                      ),
                    ),

                    SizedBox(height: height * 0.01,),
                    Text('Wanda Maximoff',
                      style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'pm',
                          color: CColors.graytext
                      ),
                    ),
                    SizedBox(height: height * 0.02,),

                    Container(
                      width: width *0.35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image(
                            image: AssetImage('assets/icons/like.png'),
                            width: 20,
                            height: 20,
                          ),

                          Image(
                            image: AssetImage('assets/icons/share.png'),
                            width: 20,
                            height: 20,
                          ),

                          Image(
                            image: AssetImage('assets/icons/dislike.png'),
                            width: 20,
                            height: 20,
                          ),
                          Image(
                            image: AssetImage('assets/icons/comment.png'),
                            width: 20,
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.02,),
                    Container(
                      width: width * 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Stocks',
                            style: TextStyle(
                              fontFamily: 'pb',
                              fontSize: 10,
                              color: CColors.blue,
                            ),
                          ),

                          // Text('2k views',
                          //   style: TextStyle(
                          //     fontFamily: 'pb',
                          //     fontSize: 10,
                          //     color: CColors.graytext,
                          //   ),
                          // ),
                          //
                          // Text('50 response',
                          //   style: TextStyle(
                          //     fontFamily: 'pb',
                          //     fontSize: 10,
                          //     color: CColors.graytext,
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
