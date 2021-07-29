import 'package:flutter/material.dart';
import 'package:trade_watch/Model/TrendingModel.dart';
import 'package:trade_watch/Widgets/TrendingWidget.dart';
import 'package:trade_watch/Widgets/TrendingWidget2.dart';

class TrendingScreen extends StatelessWidget {

  List<TrendingHelper> tlist;

  TrendingScreen(this.tlist);
  late double height ,width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(

        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: 15),
              child: Text('Top Trending',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'pb',
                ),
              ),
            ),

            Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (ctx, i){
                    return TrendingWidget2(tlist[i % tlist.length]);
                  },
                  itemCount: tlist.length * 3,
                )
            )
          ],
        ),
      ),
    );
  }


}
