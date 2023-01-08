import 'package:flutter/material.dart';
import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/pages/dashboard/dashboard_page.dart';

///
/// Created by Auro ) on 18/01/22 at 9:34 pm
///

class LocationPicker extends StatelessWidget {
  const LocationPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            "Current Location",
            style: TextStyle(
                color: Color(0xff888888),
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            Icon(
              Icons.location_on_rounded,
              color: AppColors.brightPrimary,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: ValueListenableBuilder(
                valueListenable: currentLocationNotifier,
                builder: (ctx, value, _) => Text(
                  currentLocationNotifier.value.isEmpty
                      ? "Set your city"
                      : "${currentLocationNotifier.value}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.brightPrimary,
                    fontSize: 14,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
