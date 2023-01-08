import 'package:flutter/material.dart';

///
/// Created by Auro on 20/01/22 at 12:02 am
///

class AppOrderStatusWidget extends StatelessWidget {
  final EdgeInsets? padding;
  final int status;

  const AppOrderStatusWidget(this.status, {this.padding});

  @override
  Widget build(BuildContext context) {
    String text = '';
    Color? color, bgColor;
    if (status == -1) {
      color = Color(0xffE49520);
      bgColor = Color(0xffFFEFD7);
      text = 'Order Processing';
    } else if (status == 2) {
      color = Color(0xff3E9AFF);
      bgColor = Color(0xffD6EEFF);
      text = 'Ordered';
    } else if (status == 3) {
      color = Color(0xffE49520);
      bgColor = Color(0xffFFEFD7);
      text = 'Order Processed';
    } else if (status == 4) {
      color = Color(0xff183dab);
      bgColor = Color(0xffa2c4e2);
      text = 'On the way';
    } else if (status == 5) {
      color = Color(0xff56AB18);
      bgColor = Color(0xffD9FAC1);
      text = 'Delivered';
    } else if (status == 6) {
      color = Color(0xffAB1818);
      bgColor = Color(0xffFAC1C1);
      text = 'Cancelled';
    } else {
      color = Color(0xff3E9AFF);
      bgColor = Color(0xffD6EEFF);
      text = 'Ordered';
    }
    return Material(
      color: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: padding ?? const EdgeInsets.fromLTRB(6, 4, 6, 4),
        child: Text(
          text,
          style: TextStyle(fontSize: 10, color: color),
        ),
      ),
    );
  }
}
