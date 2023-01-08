import 'package:event_admin/data_models/vendor_rating.dart';
import 'package:event_admin/pages/vendors/vendor_details/controllers/vendor_ratings_controller.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:event_admin/widgets/user_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 08/11/22 at 4:18 PM
///

class VendorReviews extends StatelessWidget {
  final VendorRatingsController controller;

  const VendorReviews(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        if (state != null) {
          return ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (c, i) => VendorReview(state[i]),
            separatorBuilder: (c, i) => SizedBox(height: 16),
            itemCount: state.length,
          );
        }
        return SizedBox();
      },
      onError: (e) => AppEmptyWidget(
        title: "$e",
      ),
      onEmpty: SizedBox(
        height: 100,
        child: AppEmptyWidget(
          title: "No ratings yet",
        ),
      ),
      onLoading: Center(
        child: CircularProgressIndicator(),
      ),
    );
    // return ListView.separated(
    //   padding: const EdgeInsets.only(top: 10),
    //   physics: NeverScrollableScrollPhysics(),
    //   shrinkWrap: true,
    //   separatorBuilder: (c, i) => SizedBox(height: 16),
    //   itemBuilder: (c, i) => VendorReview(),
    //   itemCount: 3,
    // );
  }
}

class VendorReview extends StatelessWidget {
  final VendorRating datum;

  const VendorReview(this.datum, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200.withOpacity(0.18),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${datum.createdBy!.name}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "${datum.review}",
                  style: TextStyle(
                    color: Color(0xffB1B1B1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 45),
          UserCircleAvatar(
            "${datum.createdBy!.avatar}",
            radius: 32,
          ),
        ],
      ),
    );
  }
}
