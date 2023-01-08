import 'package:event_admin/pages/events/widgets/event_card.dart';
import 'package:event_admin/widgets/user_circle_avatar.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 08/01/23 at 12:03 PM
///

class PaymentApprovals extends StatelessWidget {
  const PaymentApprovals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment approvals",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          itemCount: 10,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (c, i) => SizedBox(height: 16),
          itemBuilder: (c, i) => Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserCircleAvatar(
                  "",
                  radius: 23,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'A payment approval request from Olivia Rodrigo for  Delivery is 10.00',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                EventActionButton(
                  'Confirm',
                  onTap: () {},
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
