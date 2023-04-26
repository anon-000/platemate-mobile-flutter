import 'package:flutter/material.dart';

///
/// Created by Auro on 26/04/23 at 9:53 PM
///

class MenuItemCustomisationSheet extends StatelessWidget {
  const MenuItemCustomisationSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Customization",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),

      ],
    );
  }
}
