import '../data_model.dart';

const String notificationId='id';
const String notificationType='type';
const String notificationTitle='title';
const String notificationBody='body';
const String notificationClickAction='clickAction';
const String notificationUid='uid';// todo to userID
const String notificationData='data';

const int notificationTypeNewMessage =1;
const int notificationTypeNewAddFriend =2;
const int notificationTypeAcceptAddFriend =3;

const  notificationMessage='messages';
const  notificationAddFriend='add_friend';

class NotificationSent{
  String? toUId;
  String? title;
  String? body;
  String? clickAction;
  //DataNotification data;
  Map<String,dynamic>? data;
  NotificationSent({this.toUId,this.title,this.body,this.clickAction,this.data});

  NotificationSent.fromJson(Map<String, dynamic> json){
    toUId = json[notificationUid];
    title = json[notificationTitle];
    body = json[notificationBody];
    clickAction = json[notificationClickAction];
    data = json[notificationData];
  }

  Map<String, dynamic> toJson() {
    final  map =  <String, dynamic>{};
    map[notificationUid] =toUId;
    map[notificationTitle] = title;
    map[notificationBody] = body;
    map[notificationClickAction] = clickAction;
    map[notificationData] = data;
    return map;
  }

  @override
  String toString() {
    return '{"uid": "$toUId", "title": "$title", "content": "$body", "clickAction": "$clickAction", "data": "$data"}';
  }
}