import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floor/floor.dart';
@entity
class UserModel{
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? uid;// todo id account firebase
  String? email;
  String? userName;
  String? fullName;
  String? birthday ;
  int? gender;
  String? photoUrl ;
  String? cover;
  int? statusAccount;
  String? phone ;
  String? createdAt;
  String? lastUpdated;
  String? lastLogin;
  String? deviceToken ;
  bool? isLogin;
  String? address ;
  bool? isOnline;
  int? accountType;
  bool? isOnlineChat;
  bool? allowSearch ;
  double? latitude ;
  double? longitude;

  UserModel({
      this.id,
      this.uid,
      this.email,
      this.userName,
      this.fullName,
      this.birthday,
      this.gender,
      this.photoUrl,
      this.cover,
      this.statusAccount,
      this.phone,
      this.createdAt,
      this.lastUpdated,
      this.lastLogin,
      this.deviceToken,
      this.isLogin,
      this.address,
      this.isOnline,
      this.accountType,
      this.isOnlineChat,
      this.allowSearch,
      this.latitude,
      this.longitude
  });

  UserModel.fromJson(Map<dynamic, dynamic> json) {

    uid = json['uid'];
    email = json['email'] ?? '';
    userName = json['userName'] ?? '';
    fullName = json['fullName'] ?? '';
    birthday = json['birthday'] ?? '';
    gender = json['gender'] ?? '';
    photoUrl = json['photoUrl'] ?? '';
    cover = json['cover'] ?? '';
    statusAccount = json['statusAccount'] ?? 0;
    phone = json['phone'] ?? '';
    createdAt = json['createdAt'] ?? '';
    lastUpdated = json['lastUpdated'] ?? '';
    lastLogin = json['lastLogin'] ?? '';
    deviceToken = json['deviceToken'] ?? '';
    isLogin = json['isLogin'] ??false;
    address = json['address'] ?? '';
    isOnline = json['isOnline'] ?? false;
    accountType = json['accountType'] ?? 0;
    isOnlineChat = json['isOnlineChat'] ?? false;
    allowSearch = json['allowSearch']??true;
    latitude = json['latitude'] ?? 0;
    longitude = json['longitude'] ?? 0;
  }
  UserModel.fromLogin(UserModel user){
    uid = user.uid;
    email = user.email ?? '';
    userName = user.userName ?? '';
    fullName = user.fullName ?? '';
    birthday = user.birthday ?? '';
    gender = user.gender ?? 0;
    createdAt =  user.createdAt??'';
    photoUrl = user.photoUrl ?? '';
    cover = user.cover ?? '';
    statusAccount =  0;
    phone = user.phone ?? '';
    lastUpdated = user.lastUpdated??'';
    lastLogin = user.lastLogin??'';
    deviceToken =  user.deviceToken??'';
    isLogin = true;
    address = user.address ?? '';
    isOnline =true;
    accountType = user.accountType ?? 0;
    isOnlineChat =  false;
    allowSearch =true;
    latitude =  user.latitude??0;
    longitude =  user.longitude??0;
  }

  Map<String, dynamic> toJson() {

    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['email'] = email??'';
    data['userName'] = userName??'';
    data['fullName'] = fullName??'';
    data['birthday'] = birthday??'';
    data['gender'] = gender??0;
    data['photoUrl'] = photoUrl??'';
    data['cover'] = cover??'';
    data['statusAccount'] = statusAccount??0;
    data['phone'] = phone??'';
    data['createdAt'] = createdAt??'';
    data['lastUpdated'] = lastUpdated??'';
    data['lastLogin'] = lastLogin??'';
    data['deviceToken'] = deviceToken??'';
   data['isLogin'] = isLogin??false;
    data['address'] = address??'';
    data['isOnline'] = isOnline??false;
    data['accountType'] = accountType;
    data['isOnlineChat'] = isOnlineChat??false;
    data['allowSearch'] = allowSearch??true;
    data['latitude'] = latitude??0.0;
    data['longitude'] = longitude??0.0;
    return data;
  }
  static List<UserModel> listFromSnapshot(List<QueryDocumentSnapshot> snapshots){
    List<UserModel> list =<UserModel>[];
    if(snapshots.isNotEmpty){
      for (var item in snapshots) {
        UserModel data =UserModel();
        // this.uid,
        // this.email,
        // this.userName,
        // this.fullName,
        // this.birthday,
        // this.gender,
        // this.photoUrl,
        // this.cover,
        // this.statusAccount,
        // this.phone,
        // this.createdAt,
        // this.lastUpdated,
        // this.lastLogin,
        // this.deviceToken,
        // this.isLogin,
        // this.address,
        // this.isOnline,
        // this.accountType,
        // this.isOnlineChat,
        // this.allowSearch,
        // this.latitude,
        // this.longitude
        data.uid = item['uid'];
        data.email = item['email'] ?? '';
        data.userName = item['userName'] ??'';
        data.fullName = item['fullName'] ?? '';
        data.birthday = item['birthday'] ?? '';
        data.gender = item['gender'] ??0;
        data.photoUrl = item['photoUrl'] ?? '';
        data.cover = item['cover'] ?? '';
        data.statusAccount = item['statusAccount'] ?? 0;
        data.phone = item['phone'] ?? '';
        data.createdAt = item['createdAt'] ?? '';
        data.lastUpdated = item['lastUpdated'] ?? '';
        data.lastLogin = item['lastLogin'] ?? '';
        data.deviceToken = item['deviceToken'] ?? '';
        data.isLogin = item['isLogin'] ??false;
        data.address = item['address'] ?? '';
        data.isOnline = item['isOnline'] ?? false;
        data.accountType = item['accountType'] ?? 0;
        data.isOnlineChat = item['isOnlineChat'] ?? false;
        data.allowSearch = item['allowSearch']??true;
        data.latitude = item['latitude'] ?? 0;
        data.longitude = item['longitude'] ?? 0;
        list.add(data);
      }}

    return list;
  }

  @override
  String toString() {
    return 'UserModel{id: $id, uid: $uid, email: $email, userName: $userName, fullName: $fullName, birthday: $birthday, gender: $gender, photoUrl: $photoUrl, cover: $cover, statusAccount: $statusAccount, phone: $phone, createdAt: $createdAt, lastUpdated: $lastUpdated, lastLogin: $lastLogin, deviceToken: $deviceToken, isLogin: $isLogin, address: $address, isOnline: $isOnline, accountType: $accountType, isOnlineChat: $isOnlineChat, allowSearch: $allowSearch, latitude: $latitude, longitude: $longitude}';
  }
}

// static const userId ='id';
// static const userEmail ='email';
// static const userUsername ='userName';
// static const userFullName ='fullName';
// static const userBirthday ='birthday';
// static const userGender ='gender';
// static const userPhotoUrl ='photoUrl';
// static const userCover ='cover';
// static const userStatusAccount ='statusAccount';
// static const userPhone ='phone';
// static const userCreatedAt ='createdAt';
// static const userLastUpdated ='lastUpdated';
// static const userLastLogin ='lastLogin';
// static const userDeviceToken ='deviceToken';
// static const userIsLogin ='isLogin';
// static const userAddress ='address';
// static const userIsOnline ='isOnline';
// static const userAccountType ='accountType';
// static const userIsOnlineChat ='isOnlineChat';
// static const userAllowSearch ='allowSearch';
// static const userLatitude ='latitude';
// static const userLongitude ='longitude';
