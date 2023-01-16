import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/app_configs/app_decorations.dart';
import 'package:event_admin/data_models/event_datum.dart';
import 'package:event_admin/widgets/my_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
/// Created by Auro on 14/10/22 at 10:11 AM
///

class EventCard extends StatelessWidget {
  final EventDatum datum;
  final bool invited;
  final VoidCallback? onCancel;
  final VoidCallback? onLeave;
  final VoidCallback? onRemove;

  /// 1 : invited
  /// 2 : normal

  const EventCard(
    this.datum, {
    Key? key,
    this.invited = false,
    this.onRemove,
    this.onCancel,
    this.onLeave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: datum.status != 2
            ? Colors.grey.shade200.withOpacity(0.18)
            : Colors.white,
        borderRadius: BorderRadius.circular(10),
        gradient: datum.status != 2 ? null : AppDecorations.draftGrad,
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          if (datum.attachments!.isNotEmpty && datum.status == 1)
            MyImage(
              "${datum.attachments!.first}",
              height: 120,
              width: 80,
              fit: BoxFit.cover,
            )
          else
            Container(
              height: 120,
              width: 80,
              color: Colors.grey.withOpacity(0.4),
            ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        datum.name == null || datum.name!.isEmpty
                            ? "Untitled"
                            : "${datum.name}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (datum.startTime != null)
                      Text(
                        "${DateFormat('dd-MM-yyyy').format(datum.startTime!)}",
                        style: TextStyle(
                            fontSize: 12,
                            // color: AppColors.desc,
                            color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(width: 16),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  "${datum.user!.name}",
                  style: TextStyle(
                      fontSize: 12,
                      // color: AppColors.desc,
                      color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  "+91 ${datum.user!.phone}",
                  style: TextStyle(
                      fontSize: 12,
                      // color: AppColors.desc,
                      color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  "${datum.eventType!.name}",
                  style: TextStyle(
                      fontSize: 12,
                      // color: AppColors.desc,
                      color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );

    // return Opacity(
    //   opacity: datum.status == 3 ? 0.5 : 1,
    //   child: Container(
    //     // height: 125,
    //     padding: const EdgeInsets.only(left: 15),
    //     decoration: BoxDecoration(
    //       color: datum.status != 2
    //           ? Colors.grey.shade200.withOpacity(0.18)
    //           : Colors.white,
    //       borderRadius: BorderRadius.circular(10),
    //       gradient: datum.status != 2 ? null : AppDecorations.draftGrad,
    //     ),
    //     clipBehavior: Clip.antiAlias,
    //     child: Row(
    //       children: [
    //         Expanded(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               const SizedBox(height: 10),
    //               Text(
    //                 datum.name == null || datum.name!.isEmpty
    //                     ? "Untitled"
    //                     : "${datum.name}",
    //                 style: TextStyle(
    //                   fontSize: 15,
    //                   fontWeight: FontWeight.w600,
    //                   color: Colors.white,
    //                 ),
    //                 maxLines: 2,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //               const SizedBox(height: 6),
    //               Text(
    //                 datum.description == null
    //                     ? "No description yet"
    //                     : "${datum.description}",
    //                 style: TextStyle(
    //                   fontSize: 12,
    //                   color: AppColors.desc,
    //                 ),
    //                 maxLines: 2,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //               SizedBox(height: invited ? 12 : 10),
    //               if (datum.status == 3)
    //                 Text(
    //                   "( This event is cancelled )",
    //                   style: TextStyle(
    //                     fontSize: 12,
    //                     color: AppColors.desc,
    //                   ),
    //                 ),
    //               const SizedBox(height: 10),
    //             ],
    //           ),
    //         ),
    //         const SizedBox(width: 16),
    //         if (datum.attachments!.isNotEmpty && datum.status == 1)
    //           MyImage(
    //             "${datum.attachments!.first}",
    //             height: 125,
    //             width: 100,
    //             fit: BoxFit.cover,
    //           )
    //         else
    //           GestureDetector(
    //             onTap: () {},
    //             child: Container(
    //               height: 110,
    //               width: 100,
    //               alignment: Alignment.center,
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     datum.status == 2 ? "Draft" : '',
    //                     style: TextStyle(
    //                       fontSize: 18,
    //                       fontWeight: FontWeight.w700,
    //                     ),
    //                   ),
    //                   const SizedBox(height: 5),
    //                   if (datum.status == 2)
    //                     EventActionButton(
    //                       "Remove",
    //                       onTap: onRemove,
    //                       loading: datum.loading,
    //                     ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

class EventActionButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final bool loading;

  const EventActionButton(this.title,
      {Key? key, this.onTap, this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loading
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: SizedBox(
              height: 20,
              width: 20,
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 1.5,
              )),
            ),
          )
        : InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 6, 15, 7),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "$title",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          );
  }
}
