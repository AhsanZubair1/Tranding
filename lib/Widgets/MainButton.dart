
import 'package:flutter/material.dart';
import 'package:trade_watch/Extras/CustomColors.dart';

class CButton extends StatelessWidget {
  Function onpressed;
  String text;

  CButton(this.onpressed, this.text);

  late double width , height;
  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return TextButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero
      ),
        onPressed:(){
          onpressed();
        },
        child: Container(
          decoration: BoxDecoration(
            color: CColors.primary,
            borderRadius: BorderRadius.circular(width *0.03)
          ),
          padding: EdgeInsets.symmetric(vertical: height * 0.016),
          alignment: Alignment.center,
          width: double.infinity,
          child: Text(text,style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: 'pb',
          ),),
        ));
  }
}
