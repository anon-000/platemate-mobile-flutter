import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/app_configs/app_decorations.dart';
import 'package:event_admin/data_models/event_datum.dart';
import 'package:event_admin/pages/events/widgets/view_venue.dart';
import 'package:event_admin/widgets/my_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

///
/// Created by Auro on 16/10/22 at 1:40 AM
///

class EventInfo extends StatelessWidget {
  final EventDatum datum;

  const EventInfo(this.datum, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.grey.shade200.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 21,
              vertical: 11,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${DateFormat.yMMMMd().format(datum.startTime!)}",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ),
                Text(
                  "Time:${DateFormat('hh:mm a').format(datum.startTime!)}-${DateFormat('hh:mm a').format(datum.endTime!)}",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 13),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 22),
            child: Row(
              children: [
                if (datum.attachments!.isNotEmpty)
                  MyImage(
                    "${datum.attachments!.first}",
                    height: 110,
                    width: 110,
                    fit: BoxFit.cover,
                  ),
                if (datum.attachments!.isNotEmpty) const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${datum.name}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      if (datum.description != null &&
                          datum.description!.isNotEmpty)
                        Text(
                          "${datum.description}",
                          style: TextStyle(
                            color: AppColors.desc,
                            fontSize: 12,
                          ),
                        ),
                      const SizedBox(height: 11),
                      GestureDetector(
                        onTap: () {
                          Get.to(ViewVenue(datum.address!));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: AppDecorations.purpleGrad,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Venue",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
