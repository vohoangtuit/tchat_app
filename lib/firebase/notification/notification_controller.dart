import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:tchat/firebase/notification/data_model.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';


class NotificationController {
  // TODO https://www.youtube.com/watch?v=p7aIZ3aEi2w

  late NotificationController? instance;
  late FirebaseMessaging? _firebaseMessaging;

  late AndroidNotificationChannel? channel;
  late FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;

  final BehaviorSubject<String?> selectNotificationSubject =
      BehaviorSubject<String?>();
  late NotificationAppLaunchDetails? notificationAppLaunchDetails;
 static int count =-1;// todo check duplicate on tap on android
  late TChatBaseScreen? tChatBaseScreen;
  late BuildContext? context;
  NotificationController.getInstance({TChatBaseScreen? baseScreen,BuildContext? context_}) {
    context =context_;
   tChatBaseScreen =baseScreen;
    intiSetup();
  }
  // TODO : getInstance kiểu này bị lõi khi vào detail  lần thứ 2 khi app opening
  // todo Consider canceling any active work during "dispose" or using the "mounted" getter to determine if the State is still active.
  // NotificationController.getInstance({this.vietravelScreen}) {
  //   intiSetup();
  // }

  intiSetup() async {
    _firebaseMessaging = FirebaseMessaging.instance;
     _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    setupLocalNotification();
    handleFirebaseMessage();
    FirebaseMessaging.instance.subscribeToTopic('Notification');// check firebase functions
  }

  Future<String?> deviceToken() async {
    String? token = '';
    try {
      await  FirebaseMessaging.instance.getToken().then((value) {
        if (kDebugMode) {
          print("token::: ${value!}");
        }
        token = value;
      });
    } on Exception catch (_) {
      if (kDebugMode) {
        print("deviceToken Error ");
      }
    }
    return token;
  }

  setupLocalNotification() async {
    await Future.delayed(const Duration(seconds: 6), () {
      var initializationSettingsAndroid =
          const AndroidInitializationSettings('@drawable/ic_notification');

      const IOSInitializationSettings initializationSettingsIOS =
          IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );
      const MacOSInitializationSettings initializationSettingsMacOS =
          MacOSInitializationSettings(
              requestAlertPermission: true,
              requestBadgePermission: true,
              requestSoundPermission: true);
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
          macOS: initializationSettingsMacOS);
      _flutterLocalNotificationsPlugin!.initialize(initializationSettings,
          onSelectNotification: onSelectNotification);
    });
  }

  handleFirebaseMessage() async {
    // todo 1: when app killed and user click notification
    FirebaseMessaging.instance.getInitialMessage().then((message) async{
      if (message != null) {
        if (kDebugMode) {
          print('open app  getInitialMessage: ${message.data}');
        }
        // todo open screen
        tChatBaseScreen!.showMessage('1: new open app');
     //   _getDataDetail(message);
        if(Device.get().isAndroid){// todo android duplicate
          addCount();
          if(count==1){
            _getDataDetail(message);
            resetCount();
          }
        }else{
          _getDataDetail(message);
        }
      }
    });

    // todo 2: when the app running in background but  and user tap
     FirebaseMessaging.onMessageOpenedApp.listen((message) async{
      if (kDebugMode) {
        print('App running in background onMessageOpenedApp: ${message.data}');
      }
      tChatBaseScreen!.showMessage('2: app running background');
      // todo open screen
      if(Device.get().isAndroid){
        addCount();
        if(count==1){
          _getDataDetail(message);
          resetCount();
        }
      }else{ // todo: ios same todo 1, duplicate
       // _getDataDetail(message);
       // resetCount();
      }

    });

    // todo 3: when app opening
    FirebaseMessaging.onMessage.listen((message) async{
      if (message.notification != null) {
        tChatBaseScreen!.showMessage('3: opening');
        if (kDebugMode) {
          print('App opening message : ${message.data}');
          if(tChatBaseScreen!.mounted){
            print('Screen opening : ${tChatBaseScreen!.getNameScreenOpening()}');
          }
        }
        selectNotificationSubject.add(message.data.toString());
        display(message);
       // if(Device.get().isAndroid){
       //   addCount();
       //   if(count==1){
       //     selectNotificationSubject.add(message.data.toString());
       //     display(message);
       //     resetCount();
       //   }
       // }else{
       //
       // }

      }
    });
  }

  void display(RemoteMessage message) async {
    try {
      final int id = DateTime.now().microsecondsSinceEpoch~/10000000;
      // const int id = 0;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            'TChat_channel', 'TChat_channel',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            showWhen: true,
            enableLights: true,
            color: Colors.blue,
            ledColor: Colors.blueAccent,
            ledOnMs: 1000,
            ledOffMs: 500,
            autoCancel: true),
        iOS: IOSNotificationDetails(presentBadge: true),
      );
      // print('display ${message.data}');
      DataNotifyModel data = DataNotifyModel.fromRemoteMessage(message);
      await _flutterLocalNotificationsPlugin!.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
          payload: data.toString());
    } on Exception catch (e) {
      print('Error Notification $e');
    }
  }

  Future onSelectNotification(dynamic payload) async {
    if (payload != null) {
    //  print('notification payload:::::: ${payload.toString()}');
      //selectNotificationSubject.add(payload);
      await handlePayload(payload);
    }
  }

  handlePayload(String payload) async {
    DataNotifyModel data = DataNotifyModel.fromPayload(payload);
    //print('data ${data.toString()}');
    gotoDetailScreen(data);
  }
  _getDataDetail(RemoteMessage remoteMessage){
    DataNotifyModel data = DataNotifyModel.fromRemoteMessage(remoteMessage);
    gotoDetailScreen(data);
  }
  gotoDetailScreen(DataNotifyModel dataModel)async {
     //print('gotoDetailScreen dataModel ${dataModel.toString()}');
    // if(dataModel.typeNotification==1){// todo booking
    //   switch (dataModel.typeBooking) {
    //     case 1: //
    //       print('tour detail');
    //     //  Navigator.push(context!,MaterialPageRoute(builder: (context) => TourBookingDetail(notifyModel: dataModel,)));
    //       break;
    //     case 2: // new
    //       print('hotel detail');
    //       // Navigator.push(context!,MaterialPageRoute(builder: (context) => NewsDetailsScreen(newsId: dataModel.object_id, title: dataModel.title,)));
    //       break;
    //     default:
    //       print('default detail');
    //       break;
    //   }
    // }else if(dataModel.typeNotification==2){// todo delete account
    //
    //  // Navigator.push(context!,MaterialPageRoute(builder: (context) => DeleteAccountDetailScreen( dataModel: dataModel,)));
    //   //
    // }

  }
  void addCount(){
    count=count+1;
  }
  void resetCount(){
    count=-1;
  }
}
//
// var bookingId =tour.bookingId;
// var bookingNo =tour.bookingNo;
// var totalAmount =tour.totalAmount;
// var email =tour.email;
// var monthDayYear =tour.monthDayYear;
// var deviceType
// var date =tour.date;
// fullName: Tu
// typeBooking: 1,// todo 1 is tour/combo : 2 hotel
// 220714087606