import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/app_configs/app_decorations.dart';
import 'package:event_admin/pages/chats/controllers/all_chats_controller.dart';
import 'package:event_admin/pages/chats/widgets/chat_tile.dart';
import 'package:event_admin/utils/app_socket_helper.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 18/11/22 at 1:46 AM
///

class ChatDetailsPage extends StatefulWidget {
  static const routeName = '/chat-details-page';

  const ChatDetailsPage({Key? key}) : super(key: key);

  @override
  State<ChatDetailsPage> createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  late AllChatsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<AllChatsController>()
        ? Get.find<AllChatsController>()
        : Get.put(AllChatsController());
    controller.onInit();
    controller.getData();
    AppSocketHelper.initSocket();
  }

  @override
  void dispose() {
    super.dispose();
    AppSocketHelper.disposeSocket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ticket no : ${controller.datum!.supportTicketId}",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              "${controller.datum!.event!.name}",
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //     color: Colors.grey.shade200.withOpacity(0.18),
          //   ),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: TextButton(
          //           onPressed: () {},
          //           child: Text("Accept"),
          //           style: TextButton.styleFrom(
          //             foregroundColor: Colors.white,
          //           ),
          //         ),
          //       ),
          //       Container(
          //         width: 1,
          //         height: 30,
          //         color: Colors.white,
          //       ),
          //       Expanded(
          //         child: TextButton(
          //           onPressed: () {},
          //           child: Text("Reject"),
          //           style: TextButton.styleFrom(
          //             foregroundColor: Colors.white,
          //           ),
          //         ),
          //       ),
          //       Container(
          //         width: 1,
          //         height: 30,
          //         color: Colors.white,
          //       ),
          //       Expanded(
          //         child: TextButton(
          //           onPressed: () {},
          //           child: Text("May be"),
          //           style: TextButton.styleFrom(
          //             foregroundColor: Colors.white,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                controller.getData();
              },
              child: controller.obx(
                (state) {
                  if (state != null) {
                    return ListView.separated(
                      controller: controller.scrollController,
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      separatorBuilder: (c, i) => SizedBox(height: 16),
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      itemBuilder: (c, i) {
                        if (i >= state.length)
                          return Center(child: CircularProgressIndicator());
                        return ChatTile(state[i]);
                      },
                      itemCount: controller.status.isLoadingMore
                          ? state.length + 1
                          : state.length,
                      reverse: true,
                    );
                  }
                  return SizedBox();
                },
                onError: (e) => AppEmptyWidget(
                  title: "$e",
                ),
                onEmpty: AppEmptyWidget(
                  title: "No chats yet",
                  onReload: () {
                    controller.getData();
                  },
                ),
                onLoading: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.textController,
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
                      hintText: "Type your message",
                      suffixIcon: GetBuilder(
                        init: controller,
                        builder: (c) => controller.attachmentLoading
                            ? Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Icon(
                                  //   Icons.attach_file,
                                  //   color: Colors.white,
                                  // ),
                                  // const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: controller.handleChooseAndSendImage,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: controller.sendMessage,
                  child: Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.textController.text.isNotEmpty
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
      ),
    );
  }
}
