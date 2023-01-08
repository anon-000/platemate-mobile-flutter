import 'package:event_admin/app_configs/app_assets.dart';
import 'package:event_admin/data_models/event_datum.dart';
import 'package:event_admin/pages/dashboard/dashboard_page.dart';
import 'package:event_admin/pages/events/add_event_widgets/add_co_hosts_sheet.dart';
import 'package:event_admin/pages/events/add_event_widgets/add_guest_sheet.dart';
import 'package:event_admin/pages/events/event_vendors_page.dart';
import 'package:event_admin/pages/events/widgets/event_property_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 24/10/22 at 1:06 AM
///

class EventMoreDetails extends StatelessWidget {
  final EventDatum? datum;
  final VoidCallback? onDateClick;

  const EventMoreDetails({Key? key, this.datum, this.onDateClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "More details",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 19,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: EventPropertyCard(
                  asset: AppAssets.co_host_png,
                  title: "Co-host details",
                  onTap: () {
                    Get.dialog(AddCoHostsSheet(datum!));
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: EventPropertyCard(
                  asset: AppAssets.guest_png,
                  title: "Guests",
                  onTap: () {
                    Get.dialog(AddGuestSheet(datum!));
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: EventPropertyCard(
                  asset: AppAssets.sub_event_png,
                  title: "Sub Events",
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: EventPropertyCard(
                  asset: AppAssets.date_png,
                  title: "Date & Time",
                  onTap: onDateClick,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: EventPropertyCard(
                  asset: AppAssets.vendor_png,
                  title: "Vendors",
                  onTap: () {
                    Get.toNamed(
                      DashboardPage.routeName + EventVendorsPage.routeName,
                      arguments: {
                        "eventId": datum!.id,
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: EventPropertyCard(
                  asset: AppAssets.budget_png,
                  title: "Budget",
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
