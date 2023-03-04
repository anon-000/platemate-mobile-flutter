import 'package:flutter/material.dart';

import '../../../app_configs/app_colors.dart';

///
/// Created by Auro on 04/03/23 at 10:05 AM
///

class LocationPicker extends StatelessWidget {
  const LocationPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 5),
          //   child: Text(
          //     "Current Location",
          //     style: TextStyle(
          //         color: Color(0xff888888),
          //         fontSize: 12,
          //         fontWeight: FontWeight.w500),
          //   ),
          // ),
          // const SizedBox(height: 3),
          Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                color: Color(0xff333333),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  "Bhubaneswar",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.grey20,
                    fontSize: 16,
                  ),
                ),
              ),
              // Flexible(
              //   child: ValueListenableBuilder(
              //     valueListenable: currentLocationNotifier,
              //     builder: (ctx, value, _) => Text(
              //       currentLocationNotifier.value.id == null ||
              //               currentLocationNotifier.value.id!.isEmpty
              //           ? "Set your city"
              //           : "${currentLocationNotifier.value.name}",
              //       maxLines: 1,
              //       overflow: TextOverflow.ellipsis,
              //       style: TextStyle(
              //         color: AppColors.grey80,
              //         fontSize: 14,
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.grey20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
