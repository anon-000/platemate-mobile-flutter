import 'package:event_admin/data_models/chat.dart';
import 'package:event_admin/data_models/support_chat.dart';
import 'package:event_admin/data_models/user.dart';
import 'package:event_admin/pages/common/image_view_page.dart';
import 'package:event_admin/utils/shared_preference_helper.dart';
import 'package:event_admin/widgets/my_image.dart';
import 'package:event_admin/widgets/user_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 18/11/22 at 2:37 AM
///

class ChatTile extends StatelessWidget {
  final SupportChat datum;

  const ChatTile(this.datum, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User createdBy = datum.createdBy!;
    double width = Get.width;
    bool me = createdBy.id == SharedPreferenceHelper.user!.user!.id;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!me)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: UserCircleAvatar(
              "${createdBy.avatar}",
              radius: 20,
              name: createdBy.name,
            ),
          ),
        // Text("${createdBy.name}"),
        Expanded(
          child: datum.attachment != null
              ? datum.attachment!.type == 1
                  ? GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Get.to(
                          ImageViewPage(url: datum.attachment!.link ?? ''),
                        );
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.only(
                          right: me ? 0 : width * 0.25,
                          left: me ? width * 0.25 : 0,
                        ),
                        child: Hero(
                          tag: "${datum.attachment!.link}",
                          child: MyImage("${datum.attachment!.link}"),
                        ),
                      ),
                    )
                  : SizedBox()
              : Container(
                  margin: EdgeInsets.only(
                    right: me ? 0 : width * 0.25,
                    left: me ? width * 0.25 : 0,
                  ),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "${datum.message}",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
        ),
        if (me)
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: UserCircleAvatar(
              "${createdBy.avatar}",
              radius: 20,
              name: createdBy.name,
            ),
          ),
      ],
    );
  }
}
