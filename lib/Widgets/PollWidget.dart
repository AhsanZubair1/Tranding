

import 'package:flutter/material.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Screens/Lockers/FS/SurveyDetail.dart';

class PollWidget extends StatelessWidget {

  late double height, width;
  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          return SurveyDetail();
        }));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: width * 0.07,
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
                    Text('15 Questions',
                      style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'pm',
                          color: CColors.graytext
                      ),
                    ),
                    SizedBox(height: height * 0.01,),

                    Container(
                      width: width * 0.5,
                      child: Row(
                        children: [
                          Text('Stocks',
                            style: TextStyle(
                              fontFamily: 'pb',
                              fontSize: 10,
                              color: CColors.blue,
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                            child: Icon(
                              Icons.circle,
                              color: CColors.graytext,
                              size: 15,
                            ),
                          ),

                          Text('100k answers',
                            style: TextStyle(
                              fontFamily: 'pb',
                              fontSize: 10,
                              color: CColors.graytext,
                            ),
                          ),
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
