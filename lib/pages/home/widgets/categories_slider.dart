import 'package:flutter/material.dart';
import 'package:platemate_user/app_configs/app_assets.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/widgets/user_circle_avatar.dart';

///
/// Created by Auro on 04/03/23 at 10:14 AM
///

class CategoriesSlider extends StatelessWidget {
  const CategoriesSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> preferenceList = [
      'Punjabi',
      'Rajasthani',
      'North Indian',
      'Mughlai',
      'Kashmiri',
      'Indo-Chinese',
      'Turkish',
      'Japanese',
      'Italian',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SectionTitle("Browse by Categories"),
        ),
        SizedBox(
          height: 112,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: preferenceList.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (c, i) => SizedBox(width: 16),
            itemBuilder: (c, i) => Column(
              children: [
                UserCircleAvatar(AppAssets.demoIconImageCake),
                const SizedBox(height: 6),
                Text(
                  "${preferenceList[i]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.grey20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;

  const SectionTitle(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: AppColors.grey20,
        ),
      ),
    );
  }
}
