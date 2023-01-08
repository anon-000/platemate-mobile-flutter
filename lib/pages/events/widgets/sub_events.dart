import 'package:event_admin/data_models/sub_event_datum.dart';
import 'package:event_admin/pages/events/widgets/sub_event_card.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 16/10/22 at 2:14 AM
///

class SubEvents extends StatelessWidget {
  final List<SubEventDatum> data;

  const SubEvents(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadingText("Sub-Events"),
              const SizedBox(height: 16),
              ListView.separated(
                itemCount: data.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (c, i) => SubEventCard(data[i]),
                separatorBuilder: (c, i) => SizedBox(height: 16),
              ),
            ],
          );
  }
}

class HeadingText extends StatelessWidget {
  final String text;

  const HeadingText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 19,
        color: Colors.white,
      ),
    );
  }
}
