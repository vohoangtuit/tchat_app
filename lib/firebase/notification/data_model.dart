
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';

const String notificationUid ='uid';
const String notificationTitle ='title';
const String notificationContent ='content';
const String notificationType ='type';
const String notificationClickAction ='click_action';
const String notificationData ='data';
class DataNotifyModel{
  String? uid;
  int? type;
  String? title;
  String? content;
  String? clickAction;
  DataNotifyModel({this.uid,this.type,this.title, this.content,this.clickAction});
  factory DataNotifyModel.fromRemoteMessage(RemoteMessage remoteMessage) {
    var _json = jsonDecode(remoteMessage.data['data']) as Map;
    //print("_json $_json");
    //   print('bookingNo ${_json['bookingNo']}');
    return DataNotifyModel(
      uid: _json[notificationUid],
      type: _json[notificationType],
      title: _json[notificationTitle],
      content: _json[notificationContent],
      clickAction: _json[notificationClickAction],
    );
  }
  factory DataNotifyModel.fromPayload(String payload){
    //print('payload::...:: $payload');
    var json = jsonDecode(payload) as Map<String, dynamic>;
    //Map<String, String> json =payload as Map<String, String>;
    //  print('_json $_json');
    return DataNotifyModel(
      uid: json[notificationUid],
      type: json[notificationType],
      title: json[notificationTitle],
      content: json[notificationContent],
      clickAction: json[notificationClickAction],
    );
  }
  factory DataNotifyModel.dataFromAndroid(Map<String, dynamic> message){
    var data= json.decode(message['data']['data']);
    //var data= json.decode(message['data']);
    return DataNotifyModel(
        uid: data[notificationUid],
        type: data[notificationType],
        title: data[notificationTitle],
        content: data[notificationContent],
        clickAction: data[notificationClickAction],
    );
  }
  Map<String, dynamic> toJson() {
    final  map =  <String, dynamic>{};
    map[notificationUid] = uid;
    map[notificationType] = type;
    map[notificationTitle] = title;
    map[notificationContent] =content;
    map[notificationClickAction] =clickAction;
    return map;
  }
  factory DataNotifyModel.dataFromIOS(Map<String, dynamic> message){
    var data= json.decode(message['data']);
    return DataNotifyModel(
      uid: data[notificationUid],
      type: data[notificationType],
      title: data[notificationTitle],
      content: data[notificationContent],
      clickAction: data[notificationClickAction],
    );
  }
  factory DataNotifyModel.fromJsonPayload(String payload) {
    var data = json.decode(payload) as Map;
    return DataNotifyModel(
        uid:data['uid'],
        type:data['type'],
        title:data['title'],
        content:data['content'],
        clickAction:data['click_action']
    );
  }

@override
  String toString() {
    return '{"uid": "$uid", "type": $type, "title": "$title", "content": "$content","click_action": "$clickAction"}';// todo format to payload
  }

}