import 'package:event_admin/app_configs/app_colors.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 14/10/22 at 11:05 AM
///

class EventType extends StatelessWidget {
  final int? type;
  final Function(int t)? onChanged;

  const EventType({Key? key, this.type, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                onChanged!.call(1);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: type == 1
                      ? LinearGradient(
                          colors: [
                            Color(0xff9B92FF),
                            Color(0xff271BA4),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                      : null,
                  color: type == 1 ? AppColors.brightPrimary : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Text(
                  "Invited Events",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: type == 1 ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                onChanged!.call(2);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: type == 2
                      ? LinearGradient(
                          colors: [
                            Color(0xff9B92FF),
                            Color(0xff271BA4),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                      : null,
                  color: type == 2 ? AppColors.brightPrimary : Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  "Created Events",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: type == 2 ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
