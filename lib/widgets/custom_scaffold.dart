import 'package:platemate_user/widgets/my_background.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 13/10/22 at 10:28 AM
///

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;

  const CustomScaffold({
    Key? key,
    this.appBar,
    this.body,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: Stack(
        children: [
          Positioned(
            child: MyBackground(),
          ),
          if (body != null) body!,
        ],
      ),
    );
  }
}
