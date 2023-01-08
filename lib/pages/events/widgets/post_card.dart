import 'package:event_admin/app_configs/app_assets.dart';
import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/data_models/post_datum.dart';
import 'package:event_admin/pages/dashboard/dashboard_page.dart';
import 'package:event_admin/pages/posts/posts_details_page.dart';
import 'package:event_admin/widgets/my_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 17/10/22 at 1:51 AM
///

class PostCard extends StatelessWidget {
  final PostDatum datum;
  final VoidCallback? onLikeTap;

  const PostCard(this.datum, {Key? key, this.onLikeTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade200.withOpacity(0.18),
      ),
      child: Column(
        children: [
          if (datum.image!.isNotEmpty)
            GestureDetector(
              onTap: () {
                Get.toNamed(
                  DashboardPage.routeName + PostDetailsPage.routeName,
                  arguments: {
                    "postId": datum.id,
                    "eventId": datum.event,
                  },
                );
              },
              child: Hero(
                tag: "${datum.image!.first}",
                child: MyImage(
                  "${datum.image!.first}",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${datum.title}",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${datum.description}",
                        style: TextStyle(
                          color: AppColors.desc,
                          fontSize: 12,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "${datum.likeCount}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: onLikeTap,
                  child: datum.likeData == null
                      ? Icon(Icons.favorite_border)
                      : Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                ),
                const SizedBox(width: 10),
                Text(
                  "${datum.commentCount}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 5),
                SvgPicture.asset(
                  AppAssets.comment,
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
