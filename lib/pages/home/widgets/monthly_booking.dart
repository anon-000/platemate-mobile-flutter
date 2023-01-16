import 'package:event_admin/data_models/stats_datum.dart';
import 'package:flutter/material.dart';
import '../../../utils/common_functions.dart';

///
/// Created by Auro on 14/01/23 at 7:58 PM
///

class MonthlyBooking extends StatefulWidget {
  final Map<String, BookingReport?>? data;

  const MonthlyBooking(this.data, {Key? key}) : super(key: key);

  @override
  State<MonthlyBooking> createState() => _MonthlyBookingState();
}

class _MonthlyBookingState extends State<MonthlyBooking> {
  List<BookingReport> bookingData = [];
  BookingReport? selectedBooking;

  @override
  void initState() {
    super.initState();
    arrangeData();
  }

  Map<String, BookingReport?>? get data => widget.data;

  arrangeData() {
    List<String> bKeys = data!.keys.toList();
    bKeys.forEach((v) {
      BookingReport d = data![v]!;
      d.monthString = v.substring(0, 3);
      bookingData.add(data![v]!);
    });
    bookingData.sort((a, b) => a.month! > b.month!
        ? 1
        : a.month! < b.month!
            ? -1
            : 0);
    selectedBooking = bookingData.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey.shade200.withOpacity(0.18),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Monthly Bookings",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 4),
                if (selectedBooking != null)
                  Text(
                    "${selectedBooking!.count}",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: DropdownButtonFormField<BookingReport>(
              alignment: Alignment.center,
              isExpanded: true,
              decoration: InputDecoration(border: InputBorder.none),
              elevation: 1,
              items: bookingData
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        "${e.monthString}",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  )
                  .toList(),
              selectedItemBuilder: (ctx) => bookingData
                  .map(
                    (e) => Text(
                      "${getMonthStringFromInt(e.month! + 1)}",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  )
                  .toList(),
              value: selectedBooking,
              iconEnabledColor: Colors.white,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
              ),
              onChanged: (c) {
                setState(() {
                  selectedBooking = c;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
