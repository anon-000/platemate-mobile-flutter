import 'package:flutter/material.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/widgets/app_title.dart';
import 'package:platemate_user/widgets/my_divider.dart';

///
/// Created by Auro on 26/04/23 at 9:59 PM
///

class CustomisationInputBox extends StatelessWidget {
  final String? selectedValue;

  const CustomisationInputBox({Key? key, this.selectedValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const demoData = ["Gravy", "Semi Gravy", "Full Gravy"];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey90),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          MediumTitleText("Quantity"),
          ListView.separated(
            itemCount: demoData.length,
            separatorBuilder: (c, i) => MyDivider(),
            itemBuilder: (c, i) => Row(
              children: [
                Expanded(
                  child: Text('${demoData[i]}'),
                ),
                Radio(
                  value: demoData[i],
                  groupValue: selectedValue,
                  onChanged: (c) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
