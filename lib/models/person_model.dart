import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floor/floor.dart';
import 'package:tchat/models/user_model.dart';
@entity
class PersonModel{
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


  PersonModel({
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

  PersonModel.fromJson(Map<dynamic, dynamic> json) {
   // id = json[userId];
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
    latitude = json['latitude'] ?? 0.0;
    longitude = json['longitude'] ?? 0.0;
  }
  PersonModel.fromLogin(UserModel user){
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
    latitude =  user.latitude??0.0;
    longitude =  user.longitude??0.0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
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
   List<PersonModel> listFromSnapshot(List<QueryDocumentSnapshot> snapshots){
    List<PersonModel> list =<PersonModel>[];
    if(snapshots.isNotEmpty){
      for (var item in snapshots) {
        PersonModel data =PersonModel();

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
        data.latitude = item['latitude'] ?? 0.0;
        data.longitude = item['longitude'] ?? 0.0;
        list.add(data);
      }}

    return list;
  }
  @override
  String toString() {
    return 'PersonModel{id: $id, uid: $uid, email: $email, userName: $userName, fullName: $fullName, birthday: $birthday, gender: $gender, photoUrl: $photoUrl, cover: $cover, statusAccount: $statusAccount, phone: $phone, createdAt: $createdAt, lastUpdated: $lastUpdated, lastLogin: $lastLogin, deviceToken: $deviceToken, isLogin: $isLogin, address: $address, isOnline: $isOnline, accountType: $accountType, isOnlineChat: $isOnlineChat, allowSearch: $allowSearch, latitude: $latitude, longitude: $longitude}';
  }


}