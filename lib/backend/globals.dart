import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zotivity/main.dart';
import 'package:zotivity/models/ZotUser.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

String currentUserEmail = '';
ZotUser currentUser;
var localStorage;

initLocalStorage() async {
  localStorage = await SharedPreferences.getInstance();
}

// this is to make google api calls, see more in the sign_in.dart file
var httpClient;



// Todo: move this code to its own file - the example file is commented out
/////// local notifications

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
BehaviorSubject<String>();

NotificationAppLaunchDetails notificationAppLaunchDetails;

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

void initNotifs ()async{
  configureSelectNotificationSubject();
  var notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid = AndroidInitializationSettings('ic_stat_name');
// Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
// of the `IOSFlutterLocalNotificationsPlugin` class
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          //print('Notification Payload: ' + payload);
        }
        selectNotificationSubject.add(payload);
      });

}


void configureSelectNotificationSubject() {
  selectNotificationSubject.stream.listen((String payload) async {
    print("click clacked");
    if (payload != null) {
      Get.to(() => new BlueScreen());
    }

//    await Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => SecondScreen(payload)),
//    );
  });
}

//// init
void requestIOSPermissions() {
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );



}
  Future<void> showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'Zotivity', 'routines', 'new reminders',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'Zotivity | New routine for X', 'Time for a quick run!', platformChannelSpecifics,
        payload: '');
  }


Future selectNotification(String payload) async {
  if (payload != null) {
   print('erewfwef: $payload');
  }
  selectNotificationSubject.add(payload);

}

////////////////// local notifications