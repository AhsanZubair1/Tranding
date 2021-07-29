import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Model/TrendingModel.dart';

class TrendingWidget2 extends StatelessWidget {
  TrendingHelper model;
  double opacity;
  TrendingWidget2(this.model, {this.opacity = 1});
  late double width,height;

  List<FlSpot> fl = [];

  List<TrendingModel> tlist = [];
  List<double> clist = [];
  @override
  Widget build(BuildContext context) {
    tlist = model.list.reversed.toList();
    clist = model.clist.reversed.toList();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    if(clist.length > 12){
      var c = clist.sublist(clist.length - 12);
      clist = c;
      print(clist.length);
    }
    for(int i = 0 ; i < clist.length ; i++){
      fl.add(FlSpot(i.toDouble(), clist[i]));
    }
    return Column(
      children: [
        Container(
          child: Row(
            children: [
              Container(
                width: width * 0.15,
                child: Text(model.code!.split(".")[0],
                  style: TextStyle(
                    fontFamily: 'psb',
                    fontSize: 12,
                    color: Colors.black
                  ),
                ),
              ),
              SizedBox(width: width * 0.01,),
              Expanded(child: graph()),
              SizedBox(width: width * 0.01,),

              Container(
                width: width * 0.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('\$ ${(model.list[0].close)}',
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontFamily: 'psb',
                          fontSize: 14,
                          color: Colors.black
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                            image: AssetImage(tlist.last.changeP < 0 ? 'assets/images/downArrow.png' : 'assets/images/upArrow.png'),
                          width: 5.88,
                        ),
                        SizedBox(width: width * 0.01,),
                        Text('${(tlist.last.changeP).toStringAsFixed(2)} %'
                          ,style: TextStyle(
                            color: tlist.last.changeP <0 ? Colors.red : CColors.primary,
                            fontSize: 10.78,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }

  Widget graph(){
    return Container(
      height: 25,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: clist.length.toDouble(),
          minY: clist.reduce(min),

          lineTouchData: LineTouchData(enabled: false),
          gridData: FlGridData(
            show: false,
          ),
          titlesData: FlTitlesData(
            bottomTitles: SideTitles(
              showTitles: false,
              // reservedSize: 22,
              getTextStyles: (value) => const TextStyle(
                color: Colors.transparent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),

              getTitles: (value) {
                if(value.toInt() % 4 == 0){
                  return '${value.toInt()}';
                }else{
                  return '';
                }},
            ),
            leftTitles: SideTitles(
              showTitles: false,
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          lineBarsData: [
            LineChartBarData(
              dotData: FlDotData(
                show: false,
              ),
              isCurved: true,
              spots: fl,
              colors: [
                tlist.last.changeP < 0 ? Colors.red : CColors.primary
              ],
              barWidth: 2.94,
            ),
          ],
        ),
      ),
    );
  }
}
