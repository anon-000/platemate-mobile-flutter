import 'package:flutter/material.dart';
import 'package:platemate_user/pages/restaurant_details/widgets/restaurant_details_section.dart';
import 'package:platemate_user/pages/restaurant_details/widgets/restaurant_sliver_bar.dart';
import 'package:platemate_user/widgets/my_divider.dart';

import 'widgets/menu_category_section.dart';

///
/// Created by Auro on 24/03/23 at 12:16 AM
///

class RestaurantDetailsPage extends StatefulWidget {
  static final routeName = '/Restaurant-Details-Page';

  const RestaurantDetailsPage({Key? key}) : super(key: key);

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var topPadding = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: MySliverAppBar(
              expandedHeight: 200.0,
              topPadding: topPadding,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                RestaurantDetailsSection(),
                const SizedBox(height: 16),
                MenuCategorySection(
                  title: "Recommended for you",
                ),
                MyDivider(),
                MenuCategorySection(
                  title: "Bestsellers",
                ),
                MyDivider(),
                MenuCategorySection(
                  title: "Starters",
                ),
                MyDivider(),
                MenuCategorySection(
                  title: "Main Course",
                ),
                MyDivider(),
                MenuCategorySection(
                  title: "Deserts & Beverages",
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
