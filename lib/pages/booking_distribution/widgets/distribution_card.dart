import 'package:event_admin/data_models/booking_distribution.dart';
import 'package:event_admin/widgets/my_image.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 08/01/23 at 10:29 AM
///

class DistributionTile extends StatelessWidget {
  final BookingDistribution datum;

  const DistributionTile(this.datum, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
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
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${datum.name}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        "${datum.upOrDownPercentage}%",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                if (datum.upOrDownPercentage! > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Colors.white.withOpacity(0.4)))),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_drop_up,
                          color: Colors.green,
                          size: 30,
                        ),
                        Expanded(
                          child: Text(
                            "${datum.name} booking has gone up since last month",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
