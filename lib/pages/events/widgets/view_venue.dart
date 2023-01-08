import 'package:event_admin/app_configs/environment.dart';
import 'package:event_admin/data_models/event_datum.dart';
import 'package:event_admin/widgets/map_view.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 29/11/22 at 9:41 PM
///

class ViewVenue extends StatefulWidget {
  final Address address;

  const ViewVenue(this.address, {Key? key}) : super(key: key);

  @override
  State<ViewVenue> createState() => _ViewVenueState();
}

class _ViewVenueState extends State<ViewVenue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View venue"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: widget.address.addressLine1 == null &&
                  widget.address.city == null
              ? Expanded(
                  child: Center(
                    child: Text("No address available"),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Address"),
                    Text("${widget.address.addressLine1}"),
                    const SizedBox(height: 10),
                    Text("City"),
                    Text("${widget.address.city}"),
                    const SizedBox(height: 10),
                    if (widget.address.coordinates != null &&
                        widget.address.coordinates!.isNotEmpty) ...[
                      Text("Map"),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 350,
                        child: IgnorePointer(
                          ignoring: true,
                          child: MyMapView(
                            address: {
                              "latitudes": widget.address.coordinates == null
                                  ? Environment.defaultCoordinates[0]
                                  : widget.address.coordinates![0],
                              "longitude": widget.address.coordinates == null
                                  ? Environment.defaultCoordinates[1]
                                  : widget.address.coordinates![1],
                            },
                          ),
                        ),
                      )
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}
