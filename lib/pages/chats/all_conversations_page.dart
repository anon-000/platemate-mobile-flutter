import 'dart:async';

import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/app_configs/app_decorations.dart';
import 'package:event_admin/pages/chats/controllers/all_conversation_controller.dart';
import 'package:event_admin/pages/chats/widgets/conversation_tile.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 14/10/22 at 9:52 AM
///

class AllConversationsPage extends StatefulWidget {
  static const routeName = '/chat-list-page';

  const AllConversationsPage({Key? key}) : super(key: key);

  @override
  State<AllConversationsPage> createState() => _AllConversationsPageState();
}

class _AllConversationsPageState extends State<AllConversationsPage> {
  int chatType = 1;
  late AllConversationController controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<AllConversationController>()
        ? Get.find<AllConversationController>()
        : Get.put(AllConversationController());
    controller.onInit();
    controller.getData();
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      controller.magicApiCall();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              gradient: AppDecorations.purpleGrad,
            ),
            child: Text(
              "Support tickets",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            width: double.infinity,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                controller.getData();
              },
              child: controller.obx(
                (state) {
                  if (state != null) {
                    return state.isEmpty
                        ? AppEmptyWidget(
                            title: "No support tickets yet",
                            onReload: () {
                              controller.getData();
                            },
                          )
                        : ListView.separated(
                            controller: controller.scrollController,
                            physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            separatorBuilder: (c, i) => SizedBox(height: 16),
                            padding: const EdgeInsets.fromLTRB(16, 22, 16, 130),
                            itemBuilder: (c, i) {
                              if (i >= state.length)
                                return Center(
                                    child: CircularProgressIndicator());
                              return ConversationTile(
                                state[i],
                                onResolveTap: () {},
                              );
                            },
                            itemCount: controller.status.isLoadingMore
                                ? state.length + 1
                                : state.length,
                          );
                  }
                  return SizedBox();
                },
                onError: (e) => AppEmptyWidget(
                  title: "$e",
                ),
                onEmpty: AppEmptyWidget(
                  title: "No support tickets yet",
                  onReload: () {
                    controller.getData();
                  },
                ),
                onLoading: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
