import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Model/NewsModel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends StatefulWidget {
  NewsModel model;
  NewsDetail(this.model);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  late double height , width;

  late String date;

  int _stackIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:Padding(
          padding: MediaQuery.of(context).padding,
          child: IndexedStack(
            index: _stackIndex,
            children: <Widget>[
              Stack(
                children: [
                  WebView(
                    initialUrl: widget.model.newsUrl,
                    onPageStarted: (url) => print("Page started " + url),
                    javascriptMode: JavascriptMode.unrestricted,
                    gestureNavigationEnabled: true,
                    initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
                    onWebResourceError: (v){
                      print(v.description);
                    },
                    onPageFinished: (url) => setState(() => _stackIndex = 0),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
              Center(child: CircularProgressIndicator()),
            ],
          ),
        )
    );
  }
}
