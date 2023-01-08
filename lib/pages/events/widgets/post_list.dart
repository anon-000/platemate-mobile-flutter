import 'package:event_admin/pages/events/controllers/posts_controller.dart';
import 'package:event_admin/pages/events/widgets/post_card.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 17/10/22 at 1:48 AM
///

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  late PostsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<PostsController>()
        ? Get.find<PostsController>()
        : Get.put(PostsController());
  }

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        if (state != null) {
          return ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (c, i) => PostCard(
              state[i],
              onLikeTap: () => controller.likeAPost(
                state[i],
                likeDatum: state[i].likeData,
              ),
            ),
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
        height: 300,
        child: AppEmptyWidget(
          title: "No posts yet",
        ),
      ),
      onLoading: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
