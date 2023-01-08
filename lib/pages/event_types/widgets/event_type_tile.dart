import 'package:event_admin/data_models/event_type.dart';
import 'package:event_admin/pages/events/widgets/event_card.dart';
import 'package:event_admin/widgets/my_image.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 07/01/23 at 10:37 PM
///

class EventTypeTile extends StatelessWidget {
  final EventType datum;
  final VoidCallback? onRemove;

  const EventTypeTile(this.datum, {Key? key, this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 10,),
      decoration: BoxDecoration(
        color: Colors.grey.shade200.withOpacity(0.18),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          MyImage(
            datum.avatar ?? "",
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              '${datum.name}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          EventActionButton(
            'Remove',
            onTap: onRemove,
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
