import 'package:flutter/material.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/widgets/app_title.dart';
import 'package:platemate_user/widgets/my_divider.dart';

///
/// Created by Auro on 26/04/23 at 9:59 PM
///

class CustomisationInputBox extends StatelessWidget {
  const CustomisationInputBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey90),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          MediumTitleText("Quantity"),
          ListView.separated(
            itemCount: 2,
            separatorBuilder: (c, i) => MyDivider(),
            itemBuilder: (c, i) => Row(
              children: [
                Expanded(
                  child: Text('Semi gravy'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
