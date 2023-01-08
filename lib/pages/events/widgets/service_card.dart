import 'package:flutter/material.dart';
import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/widgets/counter_button.dart';
import 'package:event_admin/widgets/my_image.dart';

///
/// Created by Auro  on 23/01/22 at 10:24 pm
///

class ServiceCard extends StatelessWidget {
  final int? count;

  const ServiceCard({this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(3.5),
            clipBehavior: Clip.antiAlias,
            child: MyImage(
              "https://blog.hubspot.com/hubfs/important-customer-service.jpg",
              height: 75,
              width: 115,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Whole system maintainance",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff969696),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    count != null
                        ? CounterButton(
                            count: count ?? 0,
                            onChanged: (c) {},
                          )
                        : InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 8),
                              child: Text(
                                "Add",
                                style: TextStyle(
                                  color: AppColors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffD4E4FF),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                    const SizedBox(width: 4),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "₹7,000",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000).withOpacity(0.08),
            blurRadius: 27,
            spreadRadius: -20,
            offset: Offset(0, 25),
          )
        ],
      ),
    );
  }
}
