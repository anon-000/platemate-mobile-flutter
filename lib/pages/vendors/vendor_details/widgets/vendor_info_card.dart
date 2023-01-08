import 'package:event_admin/app_configs/app_assets.dart';
import 'package:event_admin/data_models/event_vendor.dart';
import 'package:event_admin/widgets/user_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

///
/// Created by Auro on 06/11/22 at 11:35 PM
///

class VendorInfoCard extends StatelessWidget {
  final VendorDatum datum;
  const VendorInfoCard(this.datum, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserCircleAvatar(
          "${datum.user!.avatar}",
          radius: 50,
          name: datum.user!.name,
        ),
        const SizedBox(height: 10),
        Text(
          '${datum.brand}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'Locality and Region',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xffB1B1B1),
          ),
        ),
        const SizedBox(height: 10),
        RatingBar.builder(
          initialRating: datum.averageRating!.truncateToDouble(),
          minRating: 1,
          direction: Axis.horizontal,
          itemCount: 5,
          ignoreGestures: true,
          allowHalfRating: true,
          itemSize: 16,
          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.white,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
      ],
    );
  }
}
