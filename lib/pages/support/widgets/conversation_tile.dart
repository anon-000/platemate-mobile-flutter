import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/data_models/support_ticket.dart';
import 'package:event_admin/pages/dashboard/dashboard_page.dart';
import 'package:event_admin/pages/support/controllers/all_conversation_controller.dart';
import 'package:event_admin/pages/support/support_details_page.dart';
import 'package:event_admin/pages/vendors/widgets/vendor_tile.dart';
import 'package:event_admin/widgets/user_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

///
/// Created by Auro on 18/11/22 at 2:21 AM
///

class ConversationTile extends StatelessWidget {
  final SupportTicket datum;
  final VoidCallback? onResolveTap;

  const ConversationTile(this.datum, {Key? key, this.onResolveTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.focusScope!.unfocus();
        await Get.toNamed(
          DashboardPage.routeName + SupportDetailsPage.routeName,
          arguments: {
            "datum": datum,
          },
        );
        if (Get.isRegistered<AllConversationController>()) {
          final controller = Get.find<AllConversationController>();
          controller.magicApiCall();
        }
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                UserCircleAvatar(
                  "${datum.user!.avatar}",
                  radius: 23,
                  name: datum.user!.name,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${datum.user!.name}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      // const SizedBox(height: 4),
                      Text(
                        "${datum.event!.name}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.desc,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Ticket no. ${datum.supportTicketId}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "${DateFormat("dd MMM yyyy").format(datum.addressedOn == null ? datum.createdAt! : datum.addressedOn!)}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "${datum.description}",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.desc,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (datum.status == 3)
                  TicketStatus(datum.status == 3 ? "Resolved" : ""),
                Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: SmallButton(
                    title: 'View details',
                    onTap: onResolveTap,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ChatMsgType extends StatelessWidget {
  final int value;

  const ChatMsgType(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          value == 1 ? Icons.image : Icons.attach_file_sharp,
          size: 18,
        ),
        Text(
          " ${value == 1 ? "Photo" : "Attachment"}",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.desc,
          ),
        ),
      ],
    );
  }
}

class TicketStatus extends StatelessWidget {
  final String title;

  const TicketStatus(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.white.withOpacity(0.6)),
      ),
      child: Text(
        "$title",
        style: TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }
}
