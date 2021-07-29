import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:trade_watch/Model/CurrencyModel.dart';
import 'package:trade_watch/Model/ExchangeModel.dart';
import 'package:trade_watch/Widgets/WatchlistWidget.dart';

class Watchlist extends StatelessWidget {

  // CurrencyProvider currencyProvider;
  // ExchangeProvider exchangeProvider;
  // Watchlist(this.currencyProvider, this.exchangeProvider);

  late double height , width;

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image(
                      image: AssetImage('assets/icons/plus.png'),
                    width: 35,
                  ),
                  SizedBox(width: width * 0.02,),
                  Text('Add Watchlist',
                    style: TextStyle(
                      color: CColors.primary,
                      fontFamily: 'psb',
                      fontSize: 16,
                    ),
                  )
                ],
              ),

              Row(
                children: [
                  Image(
                    image: AssetImage('assets/images/coin.png'),
                    width: 24,
                  ),

                  ImageIcon(AssetImage('assets/icons/arrowdown.png'))
                ],
              ),

            ],
          ),
          Expanded(
              child: DefaultTabController(
                length: 4,
                initialIndex: 1,
                child: Container(
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        indicatorColor: CColors.primary,
                        tabs: [
                          Tab(
                              child: Text('Stocks',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'psb',
                                  color: Colors.black,
                                ),
                              )
                          ),
                          Tab(
                            child: Text('Crypto',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'psb',
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Commodity',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'psb',
                                color: Colors.black,
                              ),
                            ),
                          ),

                          Tab(
                            child: Text(
                              'Forex',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'psb',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            wldata(),
                            wldata(),
                            wldata(),
                            wldata(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
          )
        ],
      ),
    );
  }


  Widget wldata(){
    return Container(
      child: Column(
        children: [
          Expanded(
              child: ListView.builder(itemBuilder: (ctx , i){
                return WatchlistWidget();
              },itemCount: 10,
              )
          )
        ],
      ),
    );
  }
}
