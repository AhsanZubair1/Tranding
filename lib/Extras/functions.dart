

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'CustomColors.dart';

class Functions{
  static String millisecondstodate(String dateFormat , int milliseconds){
    return DateFormat(dateFormat).format(DateTime.fromMillisecondsSinceEpoch(milliseconds));
  }
  showLoaderDialog(BuildContext context , {String text = 'Loading'}){
    AlertDialog alert=AlertDialog(
      content: WillPopScope(
        onWillPop: () async => false,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          padding: EdgeInsets.symmetric(horizontal: 30 , vertical: 10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: CColors.primary,
              ),
              Container(margin: EdgeInsets.only(top: 20),
                  child:Text("$text..." ,style: TextStyle(
                    color: CColors.textblack,
                    fontFamily: 'pm',
                    fontSize: 18,
                  ),)
              ),
            ],),
        ),
      ),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}