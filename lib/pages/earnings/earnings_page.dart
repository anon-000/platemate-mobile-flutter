import 'package:event_admin/pages/earnings/widgets/earing_booking_stats.dart';
import 'package:event_admin/pages/earnings/widgets/earning_bar_chart.dart';
import 'package:flutter/material.dart';

import 'widgets/payment_approvals.dart';

///
/// Created by Auro on 07/01/23 at 8:56 AM
///

class EarningsPage extends StatefulWidget {
  static const routeName = '/earnings-page';

  const EarningsPage({Key? key}) : super(key: key);

  @override
  State<EarningsPage> createState() => _EarningsPageState();
}

class _EarningsPageState extends State<EarningsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Earnings"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          EarningBookingStats(),
          const SizedBox(height: 16),
          EarningBarChart(),
          const SizedBox(height: 16),
          PaymentApprovals(),
        ],
      ),
    );
  }
}
