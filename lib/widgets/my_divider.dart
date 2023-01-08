import 'package:flutter/material.dart';
import 'package:event_admin/app_configs/app_colors.dart';

///
/// Created by Auro on 20/01/22 at 12:13 am
///

class MyDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0,
      thickness: 1,
      color: AppColors.dividerSlot.withOpacity(0.1),
    );
  }
}
