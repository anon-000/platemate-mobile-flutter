import 'package:event_admin/data_models/event_datum.dart';
import 'package:event_admin/pages/events/widgets/create_post.dart';
import 'package:event_admin/pages/events/widgets/feed_type.dart';
import 'package:event_admin/pages/events/widgets/photo_grid.dart';
import 'package:event_admin/pages/events/widgets/post_list.dart';
import 'package:event_admin/pages/events/widgets/sub_events.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 17/10/22 at 1:53 AM
///

class EventFeed extends StatelessWidget {
  final bool me;
  final int? type;
  final EventDatum? event;
  final Function(int c)? onChanged;

  const EventFeed(
      {Key? key, this.event, this.type, this.onChanged, this.me = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadingText("Feed"),
        const SizedBox(height: 16),
        FeedType(
          me: me,
          type: type,
          onChanged: onChanged,
        ),
        const SizedBox(height: 16),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: type == 1
              ? PostList()
              : type == 2
                  ? PhotoGrid()
                  : CreatePost(
                      eventId: event!.id,
                    ),
        )
      ],
    );
  }
}
