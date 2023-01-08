import 'package:event_admin/app_configs/app_assets.dart';
import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/app_configs/app_decorations.dart';
import 'package:event_admin/pages/posts/controllers/post_details_controller.dart';
import 'package:event_admin/pages/posts/widgets/comment_tile.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:event_admin/widgets/my_image.dart';
import 'package:event_admin/widgets/rating_review_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 30/12/22 at 12:33 AM
///

class PostDetailsPage extends StatefulWidget {
  static const routeName = '/post-details-page';

  const PostDetailsPage({Key? key}) : super(key: key);

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  late PostDetailsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<PostDetailsController>()
        ? Get.find<PostDetailsController>()
        : Get.put(PostDetailsController());
    controller.onInit();
    controller.getData();
  }

  addComment() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: controller.obx(
        (state) {
          if (state != null) {
            return Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      controller.getData();
                      controller.commentController.getData();
                    },
                    child: ListView(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: controller.commentController.scrollController,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade200.withOpacity(0.18),
                          ),
                          child: Column(
                            children: [
                              if (state.image!.isNotEmpty)
                                Hero(
                                  tag: "${state.image!.first}",
                                  child: MyImage(
                                    "${state.image!.first}",
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${state.title}",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "${state.description}",
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
                                      "${state.likeCount}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    GestureDetector(
                                      onTap: () => controller.likeAPost(
                                        likeDatum: state.likeData,
                                      ),
                                      child: state.likeData == null
                                          ? Icon(Icons.favorite_border)
                                          : Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "${state.commentCount}",
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
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                          child: HeadText("Comments"),
                        ),
                        controller.commentController.obx(
                          (cState) {
                            if (cState != null) {
                              return ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (c, i) =>
                                    SizedBox(height: 16),
                                itemBuilder: (c, i) {
                                  if (i >= cState.length)
                                    return Center(
                                        child: CircularProgressIndicator());
                                  return CommentTile(datum: cState[i]);
                                },
                                itemCount: controller
                                        .commentController.status.isLoadingMore
                                    ? cState.length + 1
                                    : cState.length,
                              );
                            }
                            return SizedBox();
                          },
                          onError: (e) => AppEmptyWidget(
                            title: "$e",
                          ),
                          onEmpty: SizedBox(
                            height: 350,
                            child: AppEmptyWidget(
                              title: "No comments yet",
                              onReload: () {
                                controller.commentController.getData();
                              },
                            ),
                          ),
                          onLoading: SizedBox(
                            height: 350,
                            child: Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller
                              .commentController.textEditingController,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          onChanged: (c) {
                            setState(() {});
                          },
                          decoration: AppDecorations.textFieldDecoration_2(
                            context,
                            radius: 25,
                          ).copyWith(
                            hintText: "Type your comment",
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: controller.commentController.addComment,
                        child: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.commentController
                                    .textEditingController.text.isNotEmpty
                                ? AppColors.brightSecondaryColor
                                : Color(0xff6F6F70),
                          ),
                          child: Icon(Icons.send_rounded),
                        ),
                      )
                    ],
                  ),
                ),
              ],
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
          child: Center(child: CircularProgressIndicator(color: Colors.white)),
        ),
      ),
    );
  }
}
