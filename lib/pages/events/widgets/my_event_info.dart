import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/data_models/event_datum.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 18/10/22 at 4:38 PM
///

class MyEventInfo extends StatelessWidget {
  final EventDatum datum;

  const MyEventInfo(this.datum, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(21, 24, 21, 18),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.grey.shade200.withOpacity(0.18),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${datum.name}",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "${datum.description}",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.desc,
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        'Edit',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.edit,
                        size: 14,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          if (datum.attachments!.isNotEmpty)
            Image.asset("${datum.attachments!.first}"),
        ],
      ),
    );
  }
}
