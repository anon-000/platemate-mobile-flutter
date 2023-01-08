import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/data_models/sub_event_datum.dart';
import 'package:event_admin/widgets/my_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
/// Created by Auro on 16/10/22 at 2:18 AM
///

class SubEventCard extends StatelessWidget {
  final SubEventDatum datum;

  const SubEventCard(this.datum, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          if (datum.attachments!.isNotEmpty)
            MyImage(
              "${datum.attachments!.first}",
              height: 86,
              width: 80,
            ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${datum.name}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  "${datum.description}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.desc,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "${DateFormat.yMMMMd().format(datum.startTime!)}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.desc,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${DateFormat('hh:mm a').format(datum.startTime!)}-${DateFormat('hh:mm a').format(datum.endTime!)}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.desc,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${datum.address!.addressLine1} ${datum.address!.city}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.desc,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
