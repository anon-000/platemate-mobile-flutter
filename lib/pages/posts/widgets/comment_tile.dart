import 'package:event_admin/app_configs/app_decorations.dart';
import 'package:event_admin/data_models/comment.dart';
import 'package:event_admin/utils/common_functions.dart';
import 'package:event_admin/widgets/user_circle_avatar.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 30/12/22 at 9:34 AM
///

class CommentTile extends StatelessWidget {
  final CommentDatum datum;

  const CommentTile({Key? key, required this.datum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserCircleAvatar(
            datum.user!.avatar,
            radius: 22,
            name: datum.user!.name,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              "${datum.user!.name}",
                              style: AppDecorations.commentTitle(context),
                            ),
                          ),
                          Container(
                            height: 3,
                            width: 3,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle),
                          ),
                          Text(
                            "${timeInAgoFull(datum.createdAt!)}",
                            style: AppDecorations.commentTitle(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  // child: Html(
                  //   data: widget.datum.comment,
                  // ),
                  child: Text(
                    datum.description!,
                    style: TextStyle(
                      fontSize: 13,
                    ),
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
