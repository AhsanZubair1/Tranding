import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Widgets/MainButton.dart';

class ForumDetail extends StatelessWidget {
  late double width, height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: MediaQuery.of(context).padding,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.025),
          child: SingleChildScrollView(
            child: Column(
              children: [
                forum(),
                SizedBox(height: height * 0.03,),
                cResponse(),
                SizedBox(height: height * 0.03,),
                Row(
                  children: [
                    Text('Response Order',
                      style: TextStyle(
                        color: CColors.graytext,
                        fontSize: 10,
                        fontFamily: 'pm',
                      ),
                    ),


                    SizedBox(width: width * 0.02,),

                    Icon(Icons.access_time_rounded,size: 15,color: Colors.black,),
                    SizedBox(width: width * 0.02,),
                    Text('Most liked',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'pm',
                      ),
                    ),

                    SizedBox(width: width * 0.02,),
                    Icon(Icons.keyboard_arrow_down_sharp,size: 15,color: Colors.black,),
                  ],
                ),
                SizedBox(height: height * 0.03,),

                response(),
                SizedBox(height: height * 0.03,),

                response(),
                SizedBox(height: height * 0.03,),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget forum() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: width * 0.08,
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
                      SizedBox(height: height * 0.01,),
                      Row(
                        children: [
                          Text('Today',
                            style: TextStyle(
                                color: CColors.graytext,
                                fontSize: 9,
                                fontFamily: 'pm'
                            ),
                          ),

                          Container(
                              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                              child: Icon(Icons.circle,size: 10,color: CColors.graytext,)
                          ),

                          Text('12:03 PM',
                            style: TextStyle(
                                color: CColors.graytext,
                                fontSize: 9,
                                fontFamily: 'pm'
                            ),
                          ),

                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: height * 0.03,),
            Container(
              margin: EdgeInsets.symmetric(vertical: height * 0.015),
              height: height * 0.3,
              child: Image(
                image: NetworkImage('https://a.c-dn.net/b/1WaXqW/what-is-forex_body_what_is_forex.jpg.full.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            Text('Until recently, the prevailing view assumed lorem ipsum was born as a nonsense text.',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'pr',
                  fontSize: 10
              ),
            ),
            SizedBox(height: height * 0.01,),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: width *0.35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                      image: AssetImage('assets/icons/like.png'),
                      width: 24,
                      height: 24,
                    ),

                    Image(
                      image: AssetImage('assets/icons/share.png'),
                      width: 24,
                      height: 24,
                    ),

                    Image(
                      image: AssetImage('assets/icons/dislike.png'),
                      width: 24,
                      height: 24,
                    ),
                    Image(
                      image: AssetImage('assets/icons/comment.png'),
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02,),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: width * 0.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('2k likes',
                      style: TextStyle(
                        fontFamily: 'pb',
                        fontSize: 10,
                        color: CColors.graytext,
                      ),
                    ),

                    Text('5k Shares',
                      style: TextStyle(
                        fontFamily: 'pb',
                        fontSize: 10,
                        color: CColors.graytext,
                      ),
                    ),

                    Text('1k dislikes',
                      style: TextStyle(
                        fontFamily: 'pb',
                        fontSize: 10,
                        color: CColors.graytext,
                      ),
                    ),

                    Text('50 response',
                      style: TextStyle(
                        fontFamily: 'pb',
                        fontSize: 10,
                        color: CColors.graytext,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.01,),

            Align(
              alignment: Alignment.centerLeft,
              child: Container(
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
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget cResponse(){
    return Card(
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
              radius: width * 0.06,
              backgroundImage: NetworkImage('https://pyxis.nymag.com/v1/imgs/e48/209/63cbdefa481d2e12651381284a2b590d9a-wandavision.rsquare.w700.jpg'),
            ),

            SizedBox(width: width * 0.03,),
            Expanded(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: CColors.gray , width: 1),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: TextField(
                      maxLines: 5,
                      minLines: 5,
                      style: TextStyle(
                          fontFamily: 'pr',
                          fontSize: 9,
                          color: CColors.textblack
                      ),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: (){
                        // node.nextFocus();
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Your Resonse',
                          hintStyle: TextStyle(
                              fontFamily: 'pr',
                              color: CColors.gray,
                            fontSize: 9
                          )
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage('assets/icons/gallery.png'),
                                width: 24,
                              ),
                              SizedBox(width: width * 0.02,),
                              Image(
                                image: AssetImage('assets/icons/video.png'),
                                width: 24,
                              ),
                            ],
                          )
                      ),
                      Container(
                        width: width * 0.25,
                        child: CButton((){

                        }, 'Respond'),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget response(){
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: width * 0.08,
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
                      SizedBox(height: height * 0.01,),
                      Row(
                        children: [
                          Text('Today',
                            style: TextStyle(
                                color: CColors.graytext,
                                fontSize: 9,
                                fontFamily: 'pm'
                            ),
                          ),

                          Container(
                              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                              child: Icon(Icons.circle,size: 10,color: CColors.graytext,)
                          ),

                          Text('12:03 PM',
                            style: TextStyle(
                                color: CColors.graytext,
                                fontSize: 9,
                                fontFamily: 'pm'
                            ),
                          ),

                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: height * 0.03,),
            Text('Until recently, the prevailing view assumed lorem ipsum was born as a nonsense text.',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'pr',
                  fontSize: 10
              ),
            ),
            SizedBox(height: height * 0.01,),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(

                child: Row(
                  children: [
                    Image(
                      image: AssetImage('assets/icons/like.png'),
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(width: width * 0.03,),
                    Image(
                      image: AssetImage('assets/icons/dislike.png'),
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02,),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Row(
                  children: [
                    Text('2k likes',
                      style: TextStyle(
                        fontFamily: 'pb',
                        fontSize: 10,
                        color: CColors.graytext,
                      ),
                    ),
                    SizedBox(width: width * 0.03,),
                    Text('1k dislikes',
                      style: TextStyle(
                        fontFamily: 'pb',
                        fontSize: 10,
                        color: CColors.graytext,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
