import 'package:flutter/material.dart';
import 'package:trade_watch/Extras/CustomColors.dart';

class WatchlistWidget extends StatelessWidget {

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('BitCoin',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'psb'
                    ),
                  ),
                  Text('BTC',
                    style: TextStyle(
                      color: CColors.graytext,
                      fontSize: 16,
                      fontFamily: 'psb'
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('\$108969.12',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'psb'
                        ),
                      ),
                      Text('+132%',
                        style: TextStyle(
                          color: CColors.primary,
                          fontSize: 10,
                          fontFamily: 'pr'
                        ),
                      ),
                    ],
                  ),
                  Image(
                      image: AssetImage('assets/icons/arrowup.png'),
                    width: 34,
                  )
                ],
              ),
              Row(
                children: [
                  Image(
                    image: AssetImage('assets/icons/ringing.png'),
                    width: 24,
                  ),
                  SizedBox(width: width * 0.03,),
                  Image(
                    image: AssetImage('assets/icons/star.png'),
                    width: 35,
                  ),
                ],
              )
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
