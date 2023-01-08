// import 'dart:developer';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// import 'in_app_notification.dart';
//
// Future<dynamic> backgroundMessageHandler(RemoteMessage message) async {
//   try {
//     await Firebase.initializeApp();
//     RemoteNotification? notification = message.notification;
//     //
//     log('notification data  --> ${message.data}');
//     // ActivityDatum notificationData = ActivityDatum.fromJson(
//     //     Map<String, dynamic>.from(Platform.isAndroid ? message['data'] : data));
//     //
//     return InAppNotification.showNotification(
//       title: notification?.title ?? 'Title',
//       description: notification?.body ?? 'Description',
//       // imageUrl: notificationData.user.avatar,
//       data: '{}',
//     );
//   } catch (e, s) {
//     log('Notification StackTrace $e $s');
//   }
// }
//
// void onNotificationTapped(dynamic activityDatum) {
// //   // String type = activityDatum.action.trim();
// //   debugPrint('onNotificationTapped ${activityDatum.toJson()}');
// //
// //   switch (activityDatum.entityType) {
// //     case 'user':
// //       if (activityDatum.action == 'follow-request')
// //         Get.toNamed(PendingRequestsPage.routeName, preventDuplicates: false);
// //       else
// //         Get.toNamed(OtherProfilePage.routeName,
// //             arguments: activityDatum.user.id, preventDuplicates: false);
// //       break;
// //     case 'post':
// //       Get.toNamed(SingleVideoPage.routeName,
// //           arguments: {
// //             'videoId': (activityDatum.entityId as VideoDatum).id,
// //           },
// //           preventDuplicates: false);
// //       break;
// //     case 'link':
// //       try {
// //         launch(activityDatum.link);
// //       } catch (_) {
// //         log('Link open error', error: _.toString());
// //       }
// //       break;
// //     case 'hashTag':
// //       log((activityDatum.entityId as HashTagDatum).id);
// //       Get.toNamed(HashTagDetailsPage.routeName,
// //           arguments: {
// //             'hashTag': (activityDatum.entityId as HashTagDatum).tag,
// //           },
// //           preventDuplicates: false);
// //       break;
// //     case 'audio':
// //       Get.toNamed(AudioDetailsPage.routeName,
// //           arguments: {
// //             'audioId': (activityDatum.entityId as AudioData).id,
// //           },
// //           preventDuplicates: false);
// //       break;
// //     case 'chat':
// //       Get.to(ChatPage.secondUser(activityDatum.user), preventDuplicates: false);
// //       break;
// //     default:
// //       if (activityDatum.action == 'link') {
// //         try {
// //           launch(activityDatum.link);
// //         } catch (_) {
// //           log('Link open error', error: _.toString());
// //         }
// //       }
// //   }
// }
