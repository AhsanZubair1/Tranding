import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Extras/Linear.dart' as lp;

class SurveyDetail extends StatelessWidget {

  late double width, height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(

        padding: MediaQuery.of(context).padding,
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
                    },child: Image(image: AssetImage('assets/icons/back.png'),width: 30,height: 30,)
                  ),
                  Text('Questionnaire',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'pb'
                    ),
                  ),
                  Image(image: AssetImage('assets/icons/back.png'),width: 30,height: 30,color: Colors.transparent,),

                ],
              ),
              SizedBox(height: height * 0.03,),
              questioninfo(),
              SizedBox(height: height * 0.03,),
              questionwidget(),
              SizedBox(height: height * 0.03,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Back to start',
                    style: TextStyle(
                      color: CColors.textblack,
                      fontSize: 14,
                      fontFamily: 'psb'
                    ),
                  ),


                  Text('Skip Question',
                    style: TextStyle(
                        color: CColors.graytext,
                        fontSize: 14,
                        fontFamily: 'pm'
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget questioninfo(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Question 07 / 10',
          style: TextStyle(
            fontFamily: 'pm',
            fontSize: 18,
            color: Colors.black
          ),
        ),
        SizedBox(height: height * 0.015,),
        LinearPercentIndicator(
          lineHeight: 8,
          percent: 0.7,
          backgroundColor: CColors.graytext,
          progressColor: CColors.primary,
        ),
      ],
    );
  }

  Widget questionwidget(){
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.015),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select an answer',
              style: TextStyle(
                color: CColors.graytexthalf,
                fontSize: 12,
                fontFamily: 'pm'
              ),
            ),

            SizedBox(height: height * 0.02,),

            Text('Lorem ipsum dolor sit amet consectetur adipiscing elit sed do.',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'psb'
              ),
            ),


            ListView.builder(itemBuilder: (ctx,i){
              return AnswerWidget();
            },
              itemCount: 4,
              shrinkWrap: true,
            ),

            SizedBox(height: height * 0.04,),

          ],
        ),
      ),
    );
  }
}
class AnswerWidget extends StatelessWidget {

  late double width, height;
  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(vertical:  height * 0.01),
      child: PhysicalModel(
        borderRadius: BorderRadius.circular(12),
        elevation: 4,
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: LinearPercentIndicator(
            padding: EdgeInsets.zero,
            lineHeight: 55,
            percent: 0.25,
            linearStrokeCap: LinearStrokeCap.butt,
            backgroundColor: Colors.white,
            progressColor: CColors.primary,

            center: Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Row(

                children: [
                  Expanded(
                    child: Text('Answer',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'pm'
                      ),
                    ),
                  ),



                  Text('25%',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'pb'
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
