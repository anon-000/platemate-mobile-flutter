import 'package:event_admin/app_configs/app_decorations.dart';
import 'package:event_admin/pages/events/create_event_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:event_admin/app_configs/app_assets.dart';
import 'package:event_admin/pages/dashboard/dashboard_page.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

///
/// Created by Auro on 19/01/22 at 12:31 am
///

class BottomNavBar extends StatelessWidget {
  final Function(int)? onPageChange;

  const BottomNavBar({this.onPageChange});

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    // final controller = Get.find<CentralizedLoadingController>();
    return ValueListenableBuilder(
      valueListenable: dashboardIndexNotifier,
      builder: (c, v, _) => SizedBox(
        width: width,
        // height: 70,
        child: Container(
          width: width,
          height: 70,
          decoration: BoxDecoration(
            gradient: AppDecorations.purpleGrad,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  onPageChange!(0);
                },
                child: SizedBox(
                  width: (width * 0.80) / 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        dashboardIndexNotifier.value == 0
                            ? AppAssets.home_enabled
                            : AppAssets.home_disabled,
                      ),
                      if (dashboardIndexNotifier.value == 0)
                        Text(
                          "Home",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onPageChange!(1);
                },
                child: SizedBox(
                  width: (width * 0.80) / 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        dashboardIndexNotifier.value == 1
                            ? AppAssets.shop_enabled
                            : AppAssets.shop_disabled,
                      ),
                      if (dashboardIndexNotifier.value == 1)
                        Text(
                          "Vendors",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onPageChange!(2);
                },
                child: SizedBox(
                  width: (width * 0.80) / 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        dashboardIndexNotifier.value == 2
                            ? AppAssets.message_enabled
                            : AppAssets.message_disabled,
                      ),
                      if (dashboardIndexNotifier.value == 2)
                        Text(
                          "Support",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onPageChange!(3);
                },
                child: SizedBox(
                  width: (width * 0.80) / 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        dashboardIndexNotifier.value == 3
                            ? AppAssets.user_enabled
                            : AppAssets.user_disabled,
                      ),
                      if (dashboardIndexNotifier.value == 3)
                        Text(
                          "Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // return GetBuilder(
    //   init: controller,
    //   builder: (c) => ValueListenableBuilder(
    //     valueListenable: dashboardIndexNotifier,
    //     builder: (c, v, _) => SizedBox(
    //       width: width,
    //       // height: 70,
    //       child: Stack(
    //         //overflow: Overflow.visible,
    //         alignment: Alignment.bottomCenter,
    //         children: [
    //           GestureDetector(
    //             onTap: () {
    //               controller.showAddLoading();
    //               // Get.toNamed(
    //               //   DashboardPage.routeName + CreateEventPage.routeName,
    //               // );
    //             },
    //             child: Container(
    //               color: Colors.transparent,
    //               height: 110,
    //               width: 80,
    //             ),
    //           ),
    //           CustomPaint(
    //             size: Size(width, 70),
    //             painter: BNBCustomPainter(),
    //           ),
    //           Container(
    //             width: width,
    //             height: 70,
    //             // color: Colors.yellow,
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 InkWell(
    //                   onTap: () {
    //                     onPageChange!(0);
    //                   },
    //                   child: SizedBox(
    //                     width: (width * 0.80) / 4,
    //                     child: Column(
    //                       mainAxisSize: MainAxisSize.max,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         SvgPicture.asset(
    //                           dashboardIndexNotifier.value == 0
    //                               ? AppAssets.home_enabled
    //                               : AppAssets.home_disabled,
    //                         ),
    //                         if (dashboardIndexNotifier.value == 0)
    //                           Text(
    //                             "Home",
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontSize: 12,
    //                             ),
    //                           )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 InkWell(
    //                   onTap: () {
    //                     onPageChange!(1);
    //                   },
    //                   child: SizedBox(
    //                     width: (width * 0.80) / 4,
    //                     child: Column(
    //                       mainAxisSize: MainAxisSize.max,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         SvgPicture.asset(
    //                           dashboardIndexNotifier.value == 1
    //                               ? AppAssets.shop_enabled
    //                               : AppAssets.shop_disabled,
    //                         ),
    //                         if (dashboardIndexNotifier.value == 1)
    //                           Text(
    //                             "Vendors",
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontSize: 12,
    //                             ),
    //                           )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 Container(
    //                   width: width * 0.20,
    //                 ),
    //                 InkWell(
    //                   onTap: () {
    //                     onPageChange!(2);
    //                   },
    //                   child: SizedBox(
    //                     width: (width * 0.80) / 4,
    //                     child: Column(
    //                       mainAxisSize: MainAxisSize.max,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         SvgPicture.asset(
    //                           dashboardIndexNotifier.value == 2
    //                               ? AppAssets.message_enabled
    //                               : AppAssets.message_disabled,
    //                         ),
    //                         if (dashboardIndexNotifier.value == 2)
    //                           Text(
    //                             "Messages",
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontSize: 12,
    //                             ),
    //                           )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 InkWell(
    //                   onTap: () {
    //                     onPageChange!(3);
    //                   },
    //                   child: SizedBox(
    //                     width: (width * 0.80) / 4,
    //                     child: Column(
    //                       mainAxisSize: MainAxisSize.max,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         SvgPicture.asset(
    //                           dashboardIndexNotifier.value == 3
    //                               ? AppAssets.user_enabled
    //                               : AppAssets.user_disabled,
    //                         ),
    //                         if (dashboardIndexNotifier.value == 3)
    //                           Text(
    //                             "Profile",
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontSize: 12,
    //                             ),
    //                           )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Center(
    //             child: GestureDetector(
    //               onTap: () {
    //                 controller.showAddLoading();
    //                 // Get.toNamed(
    //                 //   DashboardPage.routeName + CreateEventPage.routeName,
    //                 // );
    //               },
    //               child: Transform.translate(
    //                 offset: Offset(0, -35),
    //                 child: Transform.scale(
    //                   scale: 1.2,
    //                   child: Container(
    //                     decoration: BoxDecoration(
    //                       shape: BoxShape.circle,
    //                       boxShadow: [
    //                         BoxShadow(
    //                           offset: Offset(0, 0),
    //                           blurRadius: 10,
    //                           spreadRadius: 0,
    //                           color: Color(0xffDCDAEE).withOpacity(0.4),
    //                         )
    //                       ],
    //                     ),
    //                     child: controller.addLoading
    //                         ? Transform.translate(
    //                             offset: Offset(0, 0),
    //                             child: SizedBox(
    //                               child: Center(
    //                                 child: Column(
    //                                   mainAxisSize: MainAxisSize.min,
    //                                   children: [
    //                                     AppProgress(
    //                                       color: Colors.white,
    //                                       size: Size(30, 30),
    //                                     ),
    //                                     const SizedBox(height: 4),
    //                                     // Text(
    //                                     //   "Please wait",
    //                                     //   style: TextStyle(
    //                                     //     fontSize: 10,
    //                                     //   ),
    //                                     // )
    //                                   ],
    //                                 ),
    //                               ),
    //                             ),
    //                           )
    //                         : SvgPicture.asset(
    //                             AppAssets.add_fav,
    //                           ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
        Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height),
        [
          Color(0xff9B92FF),
          Color(0xff271BA4),
        ],
      );

    Path path = Path();

    /// left 20
    path.moveTo(0, 0);
    path.moveTo(0, 10);

    /// corner radius
    path.quadraticBezierTo(2, 2, 10, 0);
    // path.quadraticBezierTo(18, 1, 25,0);

    // path.moveTo(10, 0);
    path.quadraticBezierTo(size.width * 0.39, 0, size.width * 0.4, -5);
    // path.quadraticBezierTo(size.width * 0.35, 0, size.width * 0.4, -2);

    // path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);

    /// arc
    path.arcToPoint(Offset(size.width * 0.6, 0),
        radius: Radius.circular(20.0), clockwise: true);

    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.59, -5);

    /// right 20
    path.quadraticBezierTo(size.width * 0.80, 0, size.width - 10, 0);

    /// corner radius
    path.quadraticBezierTo(size.width - 2, 2, size.width, 10);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);

    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.quadraticBezierTo(size.width * 0.4997917, size.height * 0.5004143,
        size.width * 0.5416667, size.height * 0.5000571);
    path0.cubicTo(
        size.width * 0.5543333,
        size.height * 0.4855000,
        size.width * 0.5417917,
        size.height * 0.4142000,
        size.width * 0.5833333,
        size.height * 0.4146571);
    path0.cubicTo(
        size.width * 0.6250333,
        size.height * 0.4146429,
        size.width * 0.6123167,
        size.height * 0.4850571,
        size.width * 0.6250000,
        size.height * 0.4996857);
    path0.quadraticBezierTo(size.width * 0.6666667, size.height * 0.4996857,
        size.width * 0.7916667, size.height * 0.4985714);
    path0.lineTo(size.width * 0.7916667, size.height * 0.5700000);
    path0.lineTo(size.width * 0.3744417, size.height * 0.5711286);
    path0.lineTo(size.width * 0.3741667, size.height * 0.5000000);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// /// left 20
// path.moveTo(0, 0);
// path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
// // path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
//
// /// arc
// path.arcToPoint(Offset(size.width * 0.6, 0),
// radius: Radius.circular(20.0), clockwise: true);
//
// // path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.5, 0);
//
// /// right 20
// path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
//
// path.lineTo(size.width, size.height);
// path.lineTo(0, size.height);
// path.lineTo(0, 20);
