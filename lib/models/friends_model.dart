import 'package:cloud_firestore/cloud_firestore.dart';



class FriendModel{
 static const  friendModel = 'FriendModel';
 static const friendId = 'id';
 static const friendFullName = 'fullName';
 static const friendPhotoURL  = 'photoURL';
 static const friendTimeRequest  = 'timeRequest';
 static const friendStatusRequest  = 'statusRequest';

 static const friendNotRequest =0;
 static const friendSendRequest =1;
 static const friendWaitingConfirm =2;
 static const friendSuccess =3;
 static const friendActionClickAccept=1;
 static const friendActionClickDenny=2;

  String? id;
  String? fullName;
  String? photoURL = '';
  String? timeRequest = '';
  int? statusRequest=0;
  int? actionConfirm=0;// todo: accept or denny
  FriendModel({this.id, this.fullName, this.photoURL,this.timeRequest, this.statusRequest,this.actionConfirm});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data=  <String, dynamic>{};
    data[friendId] = id;
    data[friendFullName] = fullName;
    data[friendPhotoURL] = photoURL;
    data[friendTimeRequest] = timeRequest;
    data[friendStatusRequest] = statusRequest;
    return data;
  }
  factory FriendModel.fromJson(Map<String, dynamic> json)=>FriendModel(
      id: json[friendId],
      fullName: json[friendFullName],
      photoURL: json[friendPhotoURL],
      timeRequest: json[friendTimeRequest] ?? '',
      statusRequest: json[friendStatusRequest]
  );
  factory FriendModel.fromDocumentSnapshot (DocumentSnapshot doc) =>FriendModel(
      id: doc[friendId],
      fullName: doc[friendFullName],
      photoURL: doc[friendPhotoURL],
      timeRequest: doc[friendTimeRequest],
      statusRequest: doc[friendStatusRequest]
  );
  factory FriendModel.fromQuerySnapshot (QueryDocumentSnapshot doc) =>FriendModel(
      id: doc[friendId],
      fullName: doc[friendFullName],
      photoURL: doc[friendPhotoURL],
      timeRequest: doc[friendTimeRequest],
      statusRequest: doc[friendStatusRequest]
  );

  @override
  String toString() {
    return 'FriendModel{id: $id, fullName: $fullName, photoURL: $photoURL, timeRequest: $timeRequest, statusRequest: $statusRequest}';
  }
}