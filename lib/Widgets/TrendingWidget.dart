import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Model/TrendingModel.dart';

class TrendingWidget extends StatelessWidget {
  TrendingModel model;
  double opacity;
  TrendingWidget(this.model, {this.opacity = 1});
  late double width,height;


  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;


    double prevalue = model.close - model.change;
    double perc = (model.change / prevalue) * 100;

    print('colse: ${model.close}');
    print('change: ${model.change}');
    print('vale: $prevalue');
    print('perc: $perc');
    return Opacity(
      opacity: opacity,
      child: GestureDetector(
        onTap: (){
          print(model.toJson());
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.085,),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Text(model.code.split(".")[0],
                        style: TextStyle(
                          fontFamily: 'psb',
                          fontSize: 15,
                          color: Colors.black
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.01,),

                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('\$ ${(model.close.toStringAsFixed(2))}',
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
                                  image: AssetImage(perc < 0 ? 'assets/images/downArrow.png' : 'assets/images/upArrow.png'),
                                width: 5.88,
                              ),
                              SizedBox(width: width * 0.01,),
                              Text('${(perc).toStringAsFixed(2)} %'
                                ,style: TextStyle(
                                  color: perc < 0 ? Colors.red : CColors.primary,
                                  fontSize: 10.78,
                                ),
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
