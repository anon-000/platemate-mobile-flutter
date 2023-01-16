import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/data_models/support_ticket.dart';
import 'package:event_admin/pages/support/chat_details_page.dart';
import 'package:event_admin/pages/support/controllers/all_conversation_controller.dart';
import 'package:event_admin/utils/dialog_helper.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:event_admin/widgets/app_buttons/app_outline_button.dart';
import 'package:event_admin/widgets/app_buttons/app_primary_button.dart';
import 'package:event_admin/widgets/app_loader.dart';
import 'package:event_admin/widgets/my_image.dart';
import 'package:event_admin/widgets/rating_review_widget.dart';
import 'package:event_admin/widgets/user_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_configs/api_routes.dart';
import '../dashboard/dashboard_page.dart';
import 'widgets/conversation_tile.dart';

///
/// Created by Auro on 15/01/23 at 10:01 PM
///

class SupportDetailsPage extends StatefulWidget {
  static const routeName = '/support-details-page';

  const SupportDetailsPage({Key? key}) : super(key: key);

  @override
  State<SupportDetailsPage> createState() => _SupportDetailsPageState();
}

class _SupportDetailsPageState extends State<SupportDetailsPage> {
  late SupportTicket datum;
  bool actionLoading = false;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> args = Get.arguments ?? {};
    datum = args['datum'];
  }

  resolveTicket() async {
    int prevStatus = datum.status!;
    datum.status = 3;
    setState(() {});

    try {
      await ApiCall.patch(
        ApiRoutes.support_ticket,
        id: datum.id,
        body: {
          'status': 3,
        },
      );

      SnackBarHelper.show("Support ticket resolved");
      if (Get.isRegistered<AllConversationController>()) {
        final controller = Get.find<AllConversationController>();
        controller.magicApiCall();
      }
    } catch (err) {
      SnackBarHelper.show("$err");
      datum.status = prevStatus;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ticket no : ${datum.supportTicketId}",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              "${datum.event!.name}",
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
        actions: [
          if (datum.status == 3)
            Center(child: TicketStatus(datum.status == 3 ? "Resolved" : "")),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                ),
                const SizedBox(height: 16),
                HeadText("Contact no"),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      "+91 ${datum.user!.phone}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 16),
                    InkWell(
                      onTap: () {
                        final Uri phoneUri = Uri(
                          scheme: 'tel',
                          path: '${datum.user!.phone}',
                        );
                        launchUrl(phoneUri);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.6)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.call, size: 20),
                            const SizedBox(width: 6),
                            Text("Call now"),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                HeadText("Photos"),
                const SizedBox(height: 10),
                if (datum.attachments!.isEmpty)
                  SizedBox(
                    height: 300,
                    child: Center(child: Text("No photos attached")),
                  )
                else
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: datum.attachments!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (c, i) => ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: MyImage(
                        "${datum.attachments![i]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
              ],
            ),
          ),
          actionLoading
              ? Center(
                  child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppProgress(color: Colors.white),
                ))
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (datum.status != 3)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
                        child: SizedBox(
                          width: double.infinity,
                          child: AppPrimaryButton(
                            child: Text("Resolve"),
                            onPressed: () {
                              showEventDialog(
                                title:
                                    "Are you sure you want to resolve the ticket?",
                                positiveCallback: () {
                                  Get.back();
                                  resolveTicket();
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: MyOutlinedButton(
                          title: 'Have a chat',
                          // key: controller.buttonKeySave,
                          // child: Text(
                          //   "Save as draft",
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //   ),
                          // ),
                          onTap: () async {
                            await Get.toNamed(
                              DashboardPage.routeName +
                                  ChatDetailsPage.routeName,
                              arguments: {
                                "datum": datum,
                              },
                            );
                            if (Get.isRegistered<AllConversationController>()) {
                              final controller =
                                  Get.find<AllConversationController>();
                              controller.magicApiCall();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
