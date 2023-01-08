import 'package:event_admin/data_models/event_vendor.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 08/11/22 at 4:18 PM
///

class VendorOverview extends StatelessWidget {
  final VendorDatum datum;

  const VendorOverview(this.datum, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 6),
          Text(
            "Packages:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Phone Number:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Languages: ${datum.languages!.map((e) => e.name).toList().join(',')}",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Address: ${datum.address!.addressLine1}, ${datum.address!.city!.name}, ${datum.address!.state} - ${datum.address!.pinCode}",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Years of Experience:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
