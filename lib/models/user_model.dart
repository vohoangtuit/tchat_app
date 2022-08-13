import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floor/floor.dart';
@entity
class UserModel{
  static const userId ='id';
  static const userEmail ='email';
  static const userUsername ='userName';
  static const userFullName ='fullName';
  static const userBirthday ='birthday';
  static const userGender ='gender';
  static const userPhotoUrl ='photoUrl';
  static const userCover ='cover';
  static const userStatusAccount ='statusAccount';
  static const userPhone ='phone';
  static const userCreatedAt ='createdAt';
  static const userLastUpdated ='lastUpdated';
  static const userLastLogin ='lastLogin';
  static const userDeviceToken ='deviceToken';
  static const userIsLogin ='isLogin';
  static const userAddress ='address';
  static const userIsOnline ='isOnline';
  static const userAccountType ='accountType';
  static const userIsOnlineChat ='isOnlineChat';
  static const userAllowSearch ='allowSearch';
  static const userLatitude ='latitude';
  static const userLongitude ='longitude';

  @PrimaryKey(autoGenerate: true)
  int? idDB;
  String? id;
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
  UserModel._();
  UserModel({
      this.idDB,
      this.id,
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
      this.longitude});

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    id = json[userId];
    email = json[userEmail] ?? "";
    userName = json[userUsername] ?? "";
    fullName = json[userFullName] ?? "";
    birthday = json[userBirthday] ?? "";
    gender = json[userGender] ?? "";
    createdAt = json[userCreatedAt] ?? "";
    photoUrl = json[userPhotoUrl] ?? "";
    cover = json[userCover] ?? "";
    statusAccount = json[userStatusAccount] ?? 0;
    phone = json[userPhone] ?? "";
    lastUpdated = json[userLastUpdated] ?? "";
    lastLogin = json[userLastLogin] ?? "";
    deviceToken = json[userDeviceToken] ?? "";
    isLogin = json[userIsLogin] ??false;
    address = json[userAddress] ?? "";
    isOnline = json[userIsOnline] ?? false;
    accountType = json[userAccountType] ?? 0;
    isOnlineChat = json[userIsOnlineChat] ?? false;
    allowSearch = json[userAllowSearch]??true;
    latitude = json[userLatitude] ?? 0;
    longitude = json[userLongitude] ?? 0;
  }
  UserModel.fromLogin(UserModel user){
    id = user.id;
    email = user.email ?? "";
    userName = user.userName ?? "";
    fullName = user.fullName ?? "";
    birthday = user.birthday ?? "";
    gender = user.gender ?? 0;
    createdAt =  "";
    photoUrl = user.photoUrl ?? "";
    cover = user.cover ?? "";
    statusAccount =  0;
    phone = user.phone ?? "";
    lastUpdated = "";
    lastLogin = "";
    deviceToken =  "";
    isLogin = true;
    address = user.address ?? "";
    isOnline =true;
    accountType = user.accountType ?? 0;
    isOnlineChat =  false;
    allowSearch =true;
    latitude =  0;
    longitude =  0;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data[userId] = id;
    data[userEmail] = email??'';
    data[userUsername] = userName??'';
    data[userFullName] = fullName??'';
    data[userBirthday] = birthday??'';
    data[userGender] = gender??0;
    data[userCreatedAt] = createdAt??'';
    data[userPhotoUrl] = photoUrl??'';
    data[userCover] = cover??'';
    data[userStatusAccount] = statusAccount??0;
    data[userPhone] = phone??'';
    data[userLastUpdated] = lastUpdated??'';
    data[userLastLogin] = lastLogin??'';
    data[userDeviceToken] = deviceToken??'';
    data[userIsLogin] = isLogin??false;
    data[userAddress] = address??'';
    data[userIsOnline] = isOnline??false;
    data[userAccountType] = accountType;
    data[userIsOnlineChat] = isOnlineChat??false;
    data[userAllowSearch] = allowSearch??true;
    data[userLatitude] = latitude??0.0;
    data[userLongitude] = longitude??0.0;

    return data;
  }
  static List<UserModel> listFromSnapshot(List<QueryDocumentSnapshot> snapshots){
    List<UserModel> list =<UserModel>[];
    if(snapshots.isNotEmpty){
      for (var item in snapshots) {
        UserModel data =UserModel();
        data.id = item[userId];
        data.email = item[userEmail] ?? "";
        data.userName = item[userUsername] ?? "";
        data.fullName = item[userFullName] ?? "";
        data.birthday = item[userBirthday] ?? "";
        data.gender = item[userGender] ??0;
        data.createdAt = item[userCreatedAt] ?? "";
        data.photoUrl = item[userPhotoUrl] ?? "";
        data.cover = item[userCover] ?? "";
        data.statusAccount = item[userStatusAccount] ?? 0;
        data.phone = item[userPhone] ?? "";
        data.lastUpdated = item[userLastUpdated] ?? "";
        data.lastLogin = item[userLastLogin] ?? "";
        data.deviceToken = item[userDeviceToken] ?? "";
        data.isLogin = item[userIsLogin] ??false;
        data.address = item[userAddress] ?? "";
        data.isOnline = item[userIsOnline] ?? false;
        data.accountType = item[userAccountType] ?? 0;
        data.isOnlineChat = item[userIsOnlineChat] ?? false;
        data.allowSearch = item[userAllowSearch]??true;
        data.latitude = item[userLatitude] ?? 0;
        data.longitude = item[userLongitude] ?? 0;
        list.add(data);
      }}

    return list;
  }

  @override
  String toString() {
    return '{idDB: $idDB, id: $id, email: $email, userName: $userName, fullName: $fullName, birthday: $birthday, gender: $gender, photoUrl: $photoUrl, cover: $cover, statusAccount: $statusAccount, phone: $phone, createdAt: $createdAt, lastUpdated: $lastUpdated, lastLogin: $lastLogin, deviceToken: $deviceToken, isLogin: $isLogin, address: $address, isOnline: $isOnline, accountType: $accountType, isOnlineChat: $isOnlineChat, allowSearch: $allowSearch, latitude: $latitude, longitude: $longitude}';
  }
}