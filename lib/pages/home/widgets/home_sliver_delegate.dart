// import 'package:event_admin/app_configs/app_assets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// ///
// /// Created by Auro on 14/10/22 at 10:39 AM
// ///
//
// class DashboardSliverDelegate extends SliverPersistentHeaderDelegate {
//   final double expandedHeight;
//
//   DashboardSliverDelegate({
//     required this.expandedHeight,
//   });
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     final theme = Theme.of(context);
//     final appBarSize = expandedHeight - shrinkOffset;
//     final proportion = 2 - (expandedHeight / appBarSize);
//     final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
//     return Container(
//       height: expandedHeight,
//       color: theme.primaryColor,
//       child: Stack(
//         children: [
//           Container(
//             height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
//             child: AppBar(
//               iconTheme: IconThemeData(color: Colors.white),
//               backgroundColor: theme.primaryColor,
//               //brightness: Brightness.dark,
//               leading: IconButton(
//                   icon: SvgPicture.asset(AppAssets.menu),
//                   onPressed: () {
//                     Scaffold.of(context).openDrawer();
//                   }),
//               elevation: 0.0,
//               actions: [
//                 Opacity(
//                   opacity: 1 - percent,
//                   child: IconButton(
//                       icon: SvgPicture.asset(AppAssets.appBarSearch,
//                           color: Colors.white),
//                       onPressed: () {
//                         Get.toNamed(
//                             DashboardPage.routeName + SearchPage.routeName);
//                       }),
//                 ),
//                 NotificationIcon(),
//                 CartIcon(),
//               ],
//               titleSpacing: 0,
//               title: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 18),
//                   SvgPicture.asset(AppAssets.ausicareText),
//                   GestureDetector(
//                     onTap: () async {
//                       final value = await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (c) => PlacePicker(
//                             title: 'Detect my location',
//                           ),
//                         ),
//                       );
//                       try {
//                         if (value != null) {
//                           currentLocationNotifier.value = value;
//                           SharedPreferenceHelper.storeLocation(value);
//                           Future.delayed(Duration(milliseconds: 600)).then(
//                               (value) => SnackBarHelper.show(
//                                   "", "Current city updated"));
//                         }
//                       } catch (err) {
//                         SnackBarHelper.show("", "$err");
//                       }
//                     },
//                     behavior: HitTestBehavior.translucent,
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(0, 4, 8, 10),
//                       child: Row(
//                         children: [
//                           Flexible(
//                             child: ValueListenableBuilder(
//                               valueListenable: currentLocationNotifier,
//                               builder: (ctx, value, _) => Text(
//                                 currentLocationNotifier.value.isEmpty
//                                     ? "Set your city"
//                                     : "${currentLocationNotifier.value}",
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 2, left: 2),
//                             child: Icon(
//                               Icons.keyboard_arrow_down_outlined,
//                               size: 20,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             left: 16,
//             bottom: 16,
//             right: 16,
//             child: Opacity(
//               opacity: percent,
//               child: IgnorePointer(
//                 ignoring: percent != 1,
//                 child: GestureDetector(
//                   onTap: percent == 1 ? () {} : null,
//                   behavior: HitTestBehavior.translucent,
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(4)),
//                     child: Row(
//                       children: [
//                         SvgPicture.asset(AppAssets.search),
//                         SizedBox(width: 12),
//                         Expanded(
//                           child: Text(
//                             'Search for medicines, test & doctors...',
//                             style: TextStyle(color: Color(0xffA3A3A3)),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   double get maxExtent => expandedHeight;
//
//   @override
//   double get minExtent => kToolbarHeight;
//
//   @override
//   bool shouldRebuild(DashboardSliverDelegate oldDelegate) {
//     return oldDelegate.expandedHeight != this.expandedHeight;
//   }
// }
