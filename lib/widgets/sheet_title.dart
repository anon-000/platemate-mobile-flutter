import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 22/01/22 at 7:00 pm
///

class SheetTitle extends StatelessWidget {
  final String title;

  const SheetTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),
    );
  }
}
