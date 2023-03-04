import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platemate_user/app_configs/app_assets.dart';
import 'package:platemate_user/pages/home/widgets/categories_slider.dart';
import 'package:platemate_user/pages/home/widgets/location_picker.dart';
import 'package:platemate_user/pages/home/widgets/recommended_restaurants_slider.dart';

import '../../app_configs/app_colors.dart';

///
/// Created by Auro on 25/02/23 at 10:42 PM
///

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          titleSpacing: 16,
          title: LocationPicker(),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppAssets.qr_scanner),
            ),
            const SizedBox(width: 6),
          ],
        ),
        Expanded(
          child: ListView(
            children: [
              ColoredBox(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.grey80,
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.search,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              "search restaurant or dishes",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.grey60,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CategoriesSlider(),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              RecommendedRestaurantsSlider(),
            ],
          ),
        )
      ],
    );
  }
}
