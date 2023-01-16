import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/data_models/review.dart';
import 'package:event_admin/utils/common_functions.dart';
import 'package:event_admin/widgets/user_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

///
/// Created by Auro on 08/01/23 at 10:54 AM
///

class ReviewTile extends StatelessWidget {
  final ReviewDatum datum;

  const ReviewTile(this.datum, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          margin: const EdgeInsets.fromLTRB(36, 36, 0, 0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "  ${datum.createdBy!.name}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                '${timeInAgoFull(datum.createdAt!)}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 4),
                          RatingBarIndicator(
                            rating: datum.rating ?? 0,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "${datum.description}",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.desc,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          child: UserCircleAvatar(
            datum.createdBy!.avatar!.isEmpty
                ? null
                : "${datum.createdBy!.avatar}",
            radius: 40,
            name: datum.createdBy!.name,
          ),
        )
      ],
    );
  }
}
