import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../helpers/Global.dart';

class FCMController extends GetxController {
  static final FCMController instance = Get.find<FCMController>();
  var _token = ''.obs;
  var fcmNotificationData = RemoteMessage().obs;

  String get deviceToken => _token.value;

  @override
  void onInit() {
    super.onInit();

    /// Android
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    /// IOS
    final DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: iosInitializationSettings);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) =>
            _handleNotificationClick(payload.toString()));

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      /// Update reactive variable data
      fcmNotificationData(message);

      var data = message.data;
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? ios = message.notification?.apple;
      if (notification != null && android != null && ios != null) {
        flutterLocalNotificationsPlugin.show(
          message.notification.hashCode,
          message.notification!.title,
          message.notification!.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
            ),
            iOS: DarwinNotificationDetails(),
          ),
          payload: jsonEncode(message.data),
        );
      }
    });

    getToken();
  }

  void _handleNotificationClick(String? payload) async {
    var data = jsonDecode(payload!);

    /// Handle if the notification related to message
    if (data['type'] == 'message') {
      ///Condition
    }

    /// Handle if the notification related to other stuffs | Notifications
    if (data['type'] == 'notification') {
      /// Handle if the actionable is Post Type
      if (data['actionable'] == 'Post') {
        ///Condition
      }

      /// Handle if the actionable is Profile Type
      if (data['actionable'] == 'Profile') {
        ///Condition
      }
    }
  }

  getToken() async {
    var token = await FirebaseMessaging.instance.getToken();
    _token(token);
    log.w(_token.value);
  }

  /// Local Notification Example
  ///
  /// Usage:
  ///
  /// fCMController.sendNotification(
  ///   "Hello",
  ///   "Local Notification",
  /// );
  ///
  ///
  Future<void> sendNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('channel_id', 'channel_name',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    const AppleNotificationSound appleNotificationSound =
        AppleNotificationSound();
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      subtitle: "channel_name",
      badgeNumber: 1,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: darwinNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics);
  }

  /// Local Notification UI Example
  ///
  /// Usage:
  ///
  /// fCMController.sendNotification(
  ///   "Hello",
  ///   "Local Notification",
  /// );
  ///
  ///
  Future<void> sendUINotification(
      String title, String body, String imageUrl) async {
    final imageUrlWithQueryParam =
        imageUrl + '?cache=${DateTime.now().millisecondsSinceEpoch}';
    log.w(imageUrlWithQueryParam);
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      fullScreenIntent: true,
      styleInformation: BigPictureStyleInformation(
        FilePathAndroidBitmap('assets/systems/logo.png'),
        contentTitle: title,
        htmlFormatContentTitle: true,
        summaryText: 'Summary text',
      ),
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      subtitle: "channel_name",
      badgeNumber: 1,
    );

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: darwinNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  /// Local Notification Progress Example
  ///
  /// Usage:
  ///
  /// fCMController.showProgressNotification(
  ///   "Hello",
  ///   "Local Notification",
  ///   "upload_image_path.png",
  ///   (progress) {
  ///     // Update your UI with the progress value (e.g., update a progress bar)
  ///     print('Progress: $progress%');
  ///   },
  /// );
  ///
  ///
  Future<void> showProgressNotification(
    String title,
    String body,
    String imageUrl,
    Function(int) onProgress,
  ) async {
    int progressValue = 0;
    int notificationId = 0;

    while (progressValue <= 100) {
      final AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        importance: Importance.max,
        priority: Priority.high,
        autoCancel: false,
        enableVibration: true,
        progress: progressValue,
        maxProgress: 100,
        showProgress: true,
      );
      const DarwinNotificationDetails darwinNotificationDetails =
          DarwinNotificationDetails(
        subtitle: "channel_name",
        badgeNumber: 1,
      );
      final NotificationDetails platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: darwinNotificationDetails);
      // Cancel the previous notification (if any)
      if (notificationId != 0) {
        await flutterLocalNotificationsPlugin.cancel(notificationId);
      }

      // Show the updated notification with the custom layout
      await flutterLocalNotificationsPlugin.show(
        notificationId,
        title,
        body,
        platformChannelSpecifics,
        payload: imageUrl,
      );

      onProgress(progressValue);

      await Future.delayed(Duration(seconds: 1));

      progressValue += 10;
    }

    // Remove the final notification
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
