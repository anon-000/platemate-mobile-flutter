import 'package:event_admin/app_configs/app_assets.dart';
import 'package:event_admin/data_models/event_type.dart';
import 'package:event_admin/pages/event_types/controllers/event_type_controller.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:event_admin/widgets/my_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 24/10/22 at 12:17 AM
///

class ChooseEventType extends StatelessWidget {
  final EventTypeController controller;
  final EventType? eventType;
  final Function(EventType c)? onEventChanged;

  const ChooseEventType(this.controller,
      {Key? key, this.eventType, this.onEventChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BoldTitle(
          "Choose Your Event Type ",
          required: true,
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 150,
          child: controller.obx(
              (s) => s == null
                  ? SizedBox()
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: s.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (c, i) => SizedBox(width: 16),
                      itemBuilder: (c, i) => GestureDetector(
                        onTap: () {
                          onEventChanged!.call(s[i]);
                        },
                        child: EventTypeCard(
                          s[i],
                          selected: eventType == null
                              ? false
                              : eventType!.id == s[i].id,
                        ),
                      ),
                    ),
              onEmpty: AppEmptyWidget(title: 'No Event types'),
              onLoading: CircularProgressIndicator(color: Colors.white),
              onError: (e) => AppErrorWidget(title: '$e')),
        ),
      ],
    );
  }
}

class EventTypeCard extends StatelessWidget {
  final bool selected;
  final EventType datum;

  const EventTypeCard(this.datum, {Key? key, this.selected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              // gradient: selected ? AppDecorations.purpleGrad : null,
              color: Colors.grey.shade200.withOpacity(0.18),
              image: DecorationImage(
                image: NetworkImage(
                    "https://static.vecteezy.com/system/resources/previews/003/561/308/non_2x/new-year-party-background-concept-free-vector.jpg"),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: selected ? Color(0xff9B92FF) : Colors.transparent,
                width: 2.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: MyImage(
              "${datum.avatar}",
              height: 50,
              width: 80,
              // width: 60,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "${datum.name}",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: selected ? Color(0xff9B92FF) : Colors.white),
        ),
      ],
    );
  }
}

class BoldTitle extends StatelessWidget {
  final String title;
  final bool required;

  const BoldTitle(this.title, {Key? key, this.required = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 19,
              color: Colors.white,
            ),
          ),
          if (required)
            Text(
              "*",
              style: TextStyle(
                color: Colors.red,
                fontSize: 24,
                height: 1,
                fontWeight: FontWeight.w700,
              ),
            ),
        ],
      ),
    );
  }
}
