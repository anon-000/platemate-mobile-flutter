import 'package:event_admin/app_configs/app_decorations.dart';
import 'package:event_admin/data_models/event_vendor.dart';
import 'package:event_admin/pages/dashboard/dashboard_page.dart';
import 'package:event_admin/pages/vendors/vendor_details/vendor_details_page.dart';
import 'package:event_admin/widgets/my_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 25/11/22 at 10:14 AM
///

class VendorTile extends StatelessWidget {
  final VendorDatum datum;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback? onRemove;

  const VendorTile(
    this.datum, {
    Key? key,
    this.onAccept,
    this.onReject,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          DashboardPage.routeName + VendorDetailsPage.routeName,
          arguments: {
            "vendorId": datum.id,
          },
        );
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.grey.shade200.withOpacity(0.18),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            MyImage(
              datum.attachments == null || datum.attachments!.isEmpty
                  ? ''
                  : "${datum.attachments!.first}",
              height: 80,
              width: 100,
            ),
            const SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    datum.brand ?? '',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${datum.description}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffB1B1B1),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (datum.status == 2)
                    Row(
                      children: [
                        SmallButton(
                          outlined: true,
                          title: "Reject",
                          onTap: onReject,
                        ),
                        const SizedBox(width: 10),
                        SmallButton(
                          title: "Accept",
                          onTap: onAccept,
                        ),
                      ],
                    ),
                  if (datum.status == 1)
                    SmallButton(
                      outlined: true,
                      title: "Remove",
                      onTap: onRemove,
                    ),
                ],
              ),
            ),
            Icon(Icons.keyboard_arrow_right_rounded),
          ],
        ),
      ),
    );
  }
}

class SmallButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;
  final bool outlined;

  const SmallButton({Key? key, this.title, this.onTap, this.outlined = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          gradient: outlined ? null : AppDecorations.purpleGrad,
          borderRadius: BorderRadius.circular(5),
          border: outlined
              ? Border.all(color: Colors.white.withOpacity(0.6))
              : null,
        ),
        child: Text("$title"),
      ),
    );
  }
}
