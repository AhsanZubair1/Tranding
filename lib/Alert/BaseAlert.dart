import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseAlertDialog extends StatelessWidget {

  //When creating please recheck 'context' if there is an error!

  String title;
  String content;
  String yes;
  String no;
  Function yesOnPressed;
  Function noOnPressed;

  BaseAlertDialog(this.title, this.content, this.yesOnPressed, this.noOnPressed,
      {this.yes = "Yes", this.no = "No"});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? AndroidAlert() : IOSAlert();
  }

  CupertinoAlertDialog IOSAlert() {
    return CupertinoAlertDialog(
      title: new Text(this.title ,),
      content: new Text(this.content ),

      actions: <Widget>[
        new CupertinoDialogAction(
          child: new Text(this.yes),
          onPressed: () {
            this.yesOnPressed();
          },
        ),
        new CupertinoDialogAction(
          child: Text(this.no),
          onPressed: () {
            this.noOnPressed();
          },
        ),
      ],
    );
  }
  AlertDialog AndroidAlert() {
    return AlertDialog(
    title: new Text(this.title ),
    content: new Text(this.content ),

    actions: <Widget>[
      new TextButton(
        child: new Text(this.yes,),
        onPressed: () {
          this.yesOnPressed();
        },
      ),
      new TextButton(
        child: Text(this.no ,),
        onPressed: () {
          this.noOnPressed();
        },
      ),
    ],
  );
  }
}