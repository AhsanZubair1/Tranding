import 'package:flutter/material.dart';
import 'package:trade_watch/Model/CurrencyModel.dart';
import 'package:trade_watch/Model/ExchangeModel.dart';
import 'package:trade_watch/Widgets/VideoWidget.dart';

class Videos extends StatelessWidget {
final String txt1;
Videos({required this.txt1});
  // CurrencyProvider currencyProvider;
  // ExchangeProvider exchangeProvider;
  // Videos(this.currencyProvider, this.exchangeProvider);

  late double height , width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(itemBuilder: (ctx, i){
              return VideoWidget();
            },itemCount: 1,),
          ),
        ],
      ),
    );
  }
}
