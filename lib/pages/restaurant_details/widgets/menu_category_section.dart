import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platemate_user/app_configs/app_assets.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/pages/restaurant_details/widgets/menu_item_card.dart';

///
/// Created by Auro on 25/04/23 at 11:14 PM
///

class MenuCategorySection extends StatefulWidget {
  final String title;

  const MenuCategorySection({this.title = '', Key? key}) : super(key: key);

  @override
  State<MenuCategorySection> createState() => _MenuCategorySectionState();
}

class _MenuCategorySectionState extends State<MenuCategorySection> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          expanded = !expanded;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${widget.title}",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.grey60,
                    ),
                  ),
                ),
                RotatedBox(
                  quarterTurns: expanded ? 0 : 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(AppAssets.arrow),
                  ),
                ),
              ],
            ),
            if (expanded)
              ListView.separated(
                padding: const EdgeInsets.only(top: 18),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (c, i) => MenuItemCard(),
                separatorBuilder: (c, i) => SizedBox(height: 16),
                itemCount: 6,
              ),
          ],
        ),
      ),
    );
  }
}
