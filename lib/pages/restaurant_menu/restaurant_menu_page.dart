import 'package:flutter/material.dart';
import 'package:platemate_user/pages/cart/widgets/cart_details_bar.dart';
import 'package:platemate_user/pages/restaurant_details/widgets/menu_category_section.dart';
import 'package:platemate_user/pages/restaurant_menu/widgets/menu_restaurant_details.dart';
import 'package:platemate_user/widgets/app_buttons/app_back_button.dart';
import 'package:platemate_user/widgets/my_divider.dart';

///
/// Created by Auro on 26/04/23 at 9:38 PM
///

class RestaurantMenuPage extends StatefulWidget {
  static final routeName = '/Restaurant-Menu-Page';

  const RestaurantMenuPage({Key? key}) : super(key: key);

  @override
  State<RestaurantMenuPage> createState() => _RestaurantMenuPageState();
}

class _RestaurantMenuPageState extends State<RestaurantMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ordering Menu"),
        centerTitle: true,
        leading: RoundedBackButton(),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                MenuRestaurantDetails(),
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
          CartDetailsBar(),
        ],
      ),
    );
  }
}
